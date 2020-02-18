#version 300 es

struct RectWithSize
{
    vec2 p0;
    vec2 size;
};

struct RectWithEndpoint
{
    vec2 p0;
    vec2 p1;
};

struct RenderTaskCommonData
{
    RectWithSize task_rect;
    float texture_layer_index;
};

struct RenderTaskData
{
    RenderTaskCommonData common_data;
    vec3 user_data;
};

struct PictureTask
{
    RenderTaskCommonData common_data;
    float device_pixel_scale;
    vec2 content_origin;
};

struct ClipArea
{
    RenderTaskCommonData common_data;
    float device_pixel_scale;
    vec2 screen_origin;
};

struct Transform
{
    mat4 m;
    mat4 inv_m;
    bool is_axis_aligned;
};

struct Instance
{
    int prim_header_address;
    int picture_task_address;
    int clip_address;
    int segment_index;
    int flags;
    int resource_address;
    int brush_kind;
};

struct PrimitiveHeader
{
    RectWithSize local_rect;
    RectWithSize local_clip_rect;
    float z;
    int specific_prim_address;
    int transform_id;
    ivec4 user_data;
};

struct VertexInfo
{
    vec2 local_pos;
    vec4 world_pos;
};

struct RadialGradient
{
    vec4 center_start_end_radius;
    float ratio_xy;
    int extend_mode;
    vec2 stretch_size;
};

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform mat4 uTransform;
uniform int uMode;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;

flat out vec4 vTransformBounds;
layout(location = 1) in ivec4 aData;
layout(location = 0) in vec3 aPosition;
out vec4 varying_vec4_0;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
flat out int flat_varying_highp_int_address_0;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_1;

Instance decode_instance_attributes()
{
    Instance instance;
    instance.prim_header_address = aData.x;
    instance.picture_task_address = aData.y >> 16;
    instance.clip_address = aData.y & 65535;
    instance.segment_index = aData.z & 65535;
    instance.flags = aData.z >> 16;
    instance.resource_address = aData.w & 16777215;
    instance.brush_kind = aData.w >> 24;
    return instance;
}

PrimitiveHeader fetch_prim_header(int index)
{
    ivec2 uv_f = ivec2(int(2u * (uint(index) % 512u)), int(uint(index) / 512u));
    vec4 local_rect = texelFetch(sPrimitiveHeadersF, uv_f + ivec2(0), 0);
    vec4 local_clip_rect = texelFetch(sPrimitiveHeadersF, uv_f + ivec2(1, 0), 0);
    PrimitiveHeader ph;
    ph.local_rect = RectWithSize(local_rect.xy, local_rect.zw);
    ph.local_clip_rect = RectWithSize(local_clip_rect.xy, local_clip_rect.zw);
    ivec2 uv_i = ivec2(int(2u * (uint(index) % 512u)), int(uint(index) / 512u));
    ivec4 data0 = texelFetch(sPrimitiveHeadersI, uv_i + ivec2(0), 0);
    ivec4 data1 = texelFetch(sPrimitiveHeadersI, uv_i + ivec2(1, 0), 0);
    ph.z = float(data0.x);
    ph.specific_prim_address = data0.y;
    ph.transform_id = data0.z;
    ph.user_data = data1;
    return ph;
}

ivec2 get_gpu_cache_uv(int address)
{
    return ivec2(int(uint(address) % 1024u), int(uint(address) / 1024u));
}

vec4[2] fetch_from_gpu_cache_2(int address)
{
    int param = address;
    ivec2 uv = get_gpu_cache_uv(param);
    return vec4[](texelFetch(sGpuCache, uv + ivec2(0), 0), texelFetch(sGpuCache, uv + ivec2(1, 0), 0));
}

RenderTaskData fetch_render_task_data(int index)
{
    ivec2 uv = ivec2(int(2u * (uint(index) % 512u)), int(uint(index) / 512u));
    vec4 texel0 = texelFetch(sRenderTasks, uv + ivec2(0), 0);
    vec4 texel1 = texelFetch(sRenderTasks, uv + ivec2(1, 0), 0);
    RectWithSize task_rect = RectWithSize(texel0.xy, texel0.zw);
    RenderTaskCommonData common_data = RenderTaskCommonData(task_rect, texel1.x);
    RenderTaskData data = RenderTaskData(common_data, texel1.yzw);
    return data;
}

PictureTask fetch_picture_task(int address)
{
    int param = address;
    RenderTaskData task_data = fetch_render_task_data(param);
    PictureTask task = PictureTask(task_data.common_data, task_data.user_data.x, task_data.user_data.yz);
    return task;
}

ClipArea fetch_clip_area(int index)
{
    ClipArea area;
    if (index >= 32767)
    {
        RectWithSize rect = RectWithSize(vec2(0.0), vec2(0.0));
        area.common_data = RenderTaskCommonData(rect, 0.0);
        area.device_pixel_scale = 0.0;
        area.screen_origin = vec2(0.0);
    }
    else
    {
        int param = index;
        RenderTaskData task_data = fetch_render_task_data(param);
        area.common_data = task_data.common_data;
        area.device_pixel_scale = task_data.user_data.x;
        area.screen_origin = task_data.user_data.yz;
    }
    return area;
}

Transform fetch_transform(int id)
{
    Transform transform;
    transform.is_axis_aligned = (id >> 24) == 0;
    int index = id & 16777215;
    ivec2 uv = ivec2(int(8u * (uint(index) % 128u)), int(uint(index) / 128u));
    ivec2 uv0 = ivec2(uv.x + 0, uv.y);
    transform.m[0] = texelFetch(sTransformPalette, uv0 + ivec2(0), 0);
    transform.m[1] = texelFetch(sTransformPalette, uv0 + ivec2(1, 0), 0);
    transform.m[2] = texelFetch(sTransformPalette, uv0 + ivec2(2, 0), 0);
    transform.m[3] = texelFetch(sTransformPalette, uv0 + ivec2(3, 0), 0);
    transform.inv_m[0] = texelFetch(sTransformPalette, uv0 + ivec2(4, 0), 0);
    transform.inv_m[1] = texelFetch(sTransformPalette, uv0 + ivec2(5, 0), 0);
    transform.inv_m[2] = texelFetch(sTransformPalette, uv0 + ivec2(6, 0), 0);
    transform.inv_m[3] = texelFetch(sTransformPalette, uv0 + ivec2(7, 0), 0);
    return transform;
}

vec2 clamp_rect(vec2 pt, RectWithSize rect)
{
    return clamp(pt, rect.p0, rect.p0 + rect.size);
}

VertexInfo write_vertex(RectWithSize instance_rect, RectWithSize local_clip_rect, float z, Transform transform, PictureTask task)
{
    vec2 local_pos = instance_rect.p0 + (instance_rect.size * aPosition.xy);
    vec2 param = local_pos;
    RectWithSize param_1 = local_clip_rect;
    vec2 clamped_local_pos = clamp_rect(param, param_1);
    vec4 world_pos = transform.m * vec4(clamped_local_pos, 0.0, 1.0);
    vec2 device_pos = world_pos.xy * task.device_pixel_scale;
    vec2 final_offset = (-task.content_origin) + task.common_data.task_rect.p0;
    gl_Position = uTransform * vec4(device_pos + (final_offset * world_pos.w), z * world_pos.w, world_pos.w);
    VertexInfo vi = VertexInfo(clamped_local_pos, world_pos);
    return vi;
}

RectWithEndpoint to_rect_with_endpoint(RectWithSize rect)
{
    RectWithEndpoint result;
    result.p0 = rect.p0;
    result.p1 = rect.p0 + rect.size;
    return result;
}

void init_transform_vs(vec4 local_bounds)
{
    vTransformBounds = local_bounds;
}

VertexInfo write_transform_vertex(inout RectWithSize local_segment_rect, RectWithSize local_prim_rect, RectWithSize local_clip_rect, vec4 clip_edge_mask, float z, Transform transform, PictureTask task)
{
    RectWithSize param = local_clip_rect;
    RectWithEndpoint clip_rect = to_rect_with_endpoint(param);
    RectWithSize param_1 = local_segment_rect;
    RectWithEndpoint segment_rect = to_rect_with_endpoint(param_1);
    segment_rect.p0 = clamp(segment_rect.p0, clip_rect.p0, clip_rect.p1);
    segment_rect.p1 = clamp(segment_rect.p1, clip_rect.p0, clip_rect.p1);
    RectWithSize param_2 = local_prim_rect;
    RectWithEndpoint prim_rect = to_rect_with_endpoint(param_2);
    prim_rect.p0 = clamp(prim_rect.p0, clip_rect.p0, clip_rect.p1);
    prim_rect.p1 = clamp(prim_rect.p1, clip_rect.p0, clip_rect.p1);
    float extrude_amount = 2.0;
    vec4 extrude_distance = vec4(extrude_amount) * clip_edge_mask;
    local_segment_rect.p0 -= extrude_distance.xy;
    local_segment_rect.size += (extrude_distance.xy + extrude_distance.zw);
    vec2 local_pos = local_segment_rect.p0 + (local_segment_rect.size * aPosition.xy);
    vec2 task_offset = task.common_data.task_rect.p0 - task.content_origin;
    vec4 world_pos = transform.m * vec4(local_pos, 0.0, 1.0);
    vec4 final_pos = vec4((world_pos.xy * task.device_pixel_scale) + (task_offset * world_pos.w), z * world_pos.w, world_pos.w);
    gl_Position = uTransform * final_pos;
    vec4 param_3 = mix(vec4(prim_rect.p0, prim_rect.p1), vec4(segment_rect.p0, segment_rect.p1), clip_edge_mask);
    init_transform_vs(param_3);
    VertexInfo vi = VertexInfo(local_pos, world_pos);
    return vi;
}

RadialGradient fetch_radial_gradient(int address)
{
    int param = address;
    vec4 data[2] = fetch_from_gpu_cache_2(param);
    return RadialGradient(data[0], data[1].x, int(data[1].y), data[1].zw);
}

void radial_gradient_brush_vs(VertexInfo vi, int prim_address, RectWithSize local_rect, RectWithSize segment_rect, ivec4 prim_user_data, int specific_resource_address, mat4 transform, PictureTask pic_task, int brush_flags, vec4 texel_rect)
{
    int param = prim_address;
    RadialGradient gradient = fetch_radial_gradient(param);
    if ((brush_flags & 2) != 0)
    {
        vec2 _888 = (vi.local_pos - segment_rect.p0) / segment_rect.size;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _888.x, _888.y);
        vec2 _901 = (varying_vec4_0.zw * (texel_rect.zw - texel_rect.xy)) + texel_rect.xy;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _901.x, _901.y);
        vec2 _908 = varying_vec4_0.zw * local_rect.size;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _908.x, _908.y);
    }
    else
    {
        vec2 _916 = vi.local_pos - local_rect.p0;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _916.x, _916.y);
    }
    flat_varying_vec4_0 = vec4(gradient.center_start_end_radius.xy.x, gradient.center_start_end_radius.xy.y, flat_varying_vec4_0.z, flat_varying_vec4_0.w);
    flat_varying_vec4_0.z = gradient.center_start_end_radius.z;
    flat_varying_vec4_0.w = gradient.center_start_end_radius.w;
    vec2 tile_repeat = local_rect.size / gradient.stretch_size;
    varying_vec4_0.w *= gradient.ratio_xy;
    flat_varying_vec4_0.y *= gradient.ratio_xy;
    flat_varying_vec4_1 = vec4(gradient.stretch_size.x, gradient.stretch_size.y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
    flat_varying_vec4_1.y *= gradient.ratio_xy;
    flat_varying_highp_int_address_0 = prim_user_data.x;
    flat_varying_vec4_1.z = float(gradient.extend_mode != 0);
}

void main()
{
    Instance instance = decode_instance_attributes();
    int edge_flags = instance.flags & 255;
    int brush_flags = (instance.flags >> 8) & 255;
    int param = instance.prim_header_address;
    PrimitiveHeader ph = fetch_prim_header(param);
    RectWithSize segment_rect;
    vec4 segment_data;
    if (instance.segment_index == 65535)
    {
        segment_rect = ph.local_rect;
        segment_data = vec4(0.0);
    }
    else
    {
        int segment_address = (ph.specific_prim_address + 2) + (instance.segment_index * 2);
        int param_1 = segment_address;
        vec4 segment_info[2] = fetch_from_gpu_cache_2(param_1);
        segment_rect = RectWithSize(segment_info[0].xy, segment_info[0].zw);
        segment_rect.p0 += ph.local_rect.p0;
        segment_data = segment_info[1];
    }
    int param_2 = instance.picture_task_address;
    PictureTask pic_task = fetch_picture_task(param_2);
    int param_3 = instance.clip_address;
    ClipArea clip_area = fetch_clip_area(param_3);
    int param_4 = ph.transform_id;
    Transform transform = fetch_transform(param_4);
    VertexInfo vi;
    if (transform.is_axis_aligned)
    {
        RectWithSize param_5 = segment_rect;
        RectWithSize param_6 = ph.local_clip_rect;
        float param_7 = ph.z;
        Transform param_8 = transform;
        PictureTask param_9 = pic_task;
        VertexInfo _796 = write_vertex(param_5, param_6, param_7, param_8, param_9);
        vi = _796;
    }
    else
    {
        bvec4 edge_mask = notEqual((ivec4(edge_flags) & ivec4(1, 2, 4, 8)), ivec4(0));
        RectWithSize param_10 = segment_rect;
        RectWithSize param_11 = ph.local_rect;
        RectWithSize param_12 = ph.local_clip_rect;
        vec4 param_13 = vec4(edge_mask.x ? vec4(1.0).x : vec4(0.0).x, edge_mask.y ? vec4(1.0).y : vec4(0.0).y, edge_mask.z ? vec4(1.0).z : vec4(0.0).z, edge_mask.w ? vec4(1.0).w : vec4(0.0).w);
        float param_14 = ph.z;
        Transform param_15 = transform;
        PictureTask param_16 = pic_task;
        VertexInfo _826 = write_transform_vertex(param_10, param_11, param_12, param_13, param_14, param_15, param_16);
        vi = _826;
    }
    VertexInfo param_17 = vi;
    int param_18 = ph.specific_prim_address;
    RectWithSize param_19 = ph.local_rect;
    RectWithSize param_20 = segment_rect;
    ivec4 param_21 = ph.user_data;
    int param_22 = instance.resource_address;
    mat4 param_23 = transform.m;
    PictureTask param_24 = pic_task;
    int param_25 = brush_flags;
    vec4 param_26 = segment_data;
    radial_gradient_brush_vs(param_17, param_18, param_19, param_20, param_21, param_22, param_23, param_24, param_25, param_26);
}

