#version 300 es

struct RectWithSize
{
    vec2 p0;
    vec2 size;
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

struct RectWithEndpoint
{
    vec2 p0;
    vec2 p1;
};

struct ImageResource
{
    RectWithEndpoint uv_rect;
    float layer;
    vec3 user_data;
};

struct ImageResourceExtra
{
    vec4 st_tl;
    vec4 st_tr;
    vec4 st_bl;
    vec4 st_br;
};

struct Transform
{
    mat4 m;
    mat4 inv_m;
    bool is_axis_aligned;
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

struct SplitGeometry
{
    vec2 local[4];
};

struct SplitCompositeInstance
{
    int prim_header_index;
    int polygons_address;
    float z;
    int render_task_index;
};

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform mat4 uTransform;
uniform highp sampler2DArray sPrevPassColor;
uniform int uMode;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2DArray sPrevPassAlpha;

flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
layout(location = 1) in ivec4 aData;
layout(location = 0) in vec3 aPosition;
flat out vec4 vUvSampleBounds;
out vec2 vUv;
flat out vec2 vLayerAndPerspective;
flat out vec4 vTransformBounds;

SplitCompositeInstance fetch_composite_instance()
{
    SplitCompositeInstance ci;
    ci.prim_header_index = aData.x;
    ci.polygons_address = aData.y;
    ci.z = float(aData.z);
    ci.render_task_index = aData.w;
    return ci;
}

ivec2 get_gpu_cache_uv(int address)
{
    return ivec2(int(uint(address) % 1024u), int(uint(address) / 1024u));
}

SplitGeometry fetch_split_geometry(int address)
{
    int param = address;
    ivec2 uv = get_gpu_cache_uv(param);
    vec4 data0 = texelFetch(sGpuCache, uv + ivec2(0), 0);
    vec4 data1 = texelFetch(sGpuCache, uv + ivec2(1, 0), 0);
    SplitGeometry geo;
    geo.local = vec2[](data0.xy, data0.zw, data1.xy, data1.zw);
    return geo;
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

vec4[2] fetch_from_gpu_cache_2(int address)
{
    int param = address;
    ivec2 uv = get_gpu_cache_uv(param);
    return vec4[](texelFetch(sGpuCache, uv + ivec2(0), 0), texelFetch(sGpuCache, uv + ivec2(1, 0), 0));
}

ImageResource fetch_image_resource(int address)
{
    int param = address;
    vec4 data[2] = fetch_from_gpu_cache_2(param);
    RectWithEndpoint uv_rect = RectWithEndpoint(data[0].xy, data[0].zw);
    return ImageResource(uv_rect, data[1].x, data[1].yzw);
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

vec2 bilerp(vec2 a, vec2 b, vec2 c, vec2 d, float s, float t)
{
    vec2 x = mix(a, b, vec2(t));
    vec2 y = mix(c, d, vec2(t));
    return mix(x, y, vec2(s));
}

void write_clip(vec4 world_pos, ClipArea area)
{
    vec2 uv = (world_pos.xy * area.device_pixel_scale) + ((area.common_data.task_rect.p0 - area.screen_origin) * world_pos.w);
    vClipMaskUvBounds = vec4(area.common_data.task_rect.p0, area.common_data.task_rect.p0 + area.common_data.task_rect.size);
    vClipMaskUv = vec4(uv, area.common_data.texture_layer_index, world_pos.w);
}

vec4[4] fetch_from_gpu_cache_4(int address)
{
    int param = address;
    ivec2 uv = get_gpu_cache_uv(param);
    return vec4[](texelFetch(sGpuCache, uv + ivec2(0), 0), texelFetch(sGpuCache, uv + ivec2(1, 0), 0), texelFetch(sGpuCache, uv + ivec2(2, 0), 0), texelFetch(sGpuCache, uv + ivec2(3, 0), 0));
}

ImageResourceExtra fetch_image_resource_extra(int address)
{
    int param = address + 2;
    vec4 data[4] = fetch_from_gpu_cache_4(param);
    return ImageResourceExtra(data[0], data[1], data[2], data[3]);
}

vec2 get_image_quad_uv(int address, vec2 f)
{
    int param = address;
    ImageResourceExtra extra_data = fetch_image_resource_extra(param);
    vec4 x = mix(extra_data.st_tl, extra_data.st_tr, vec4(f.x));
    vec4 y = mix(extra_data.st_bl, extra_data.st_br, vec4(f.x));
    vec4 z = mix(x, y, vec4(f.y));
    return z.xy / vec2(z.w);
}

void main()
{
    SplitCompositeInstance ci = fetch_composite_instance();
    int param = ci.polygons_address;
    SplitGeometry geometry = fetch_split_geometry(param);
    int param_1 = ci.prim_header_index;
    PrimitiveHeader ph = fetch_prim_header(param_1);
    int param_2 = ci.render_task_index;
    PictureTask dest_task = fetch_picture_task(param_2);
    int param_3 = ph.transform_id;
    Transform transform = fetch_transform(param_3);
    int param_4 = ph.user_data.x;
    ImageResource res = fetch_image_resource(param_4);
    int param_5 = ph.user_data.w;
    ClipArea clip_area = fetch_clip_area(param_5);
    vec2 dest_origin = dest_task.common_data.task_rect.p0 - dest_task.content_origin;
    vec2 param_6 = geometry.local[0];
    vec2 param_7 = geometry.local[1];
    vec2 param_8 = geometry.local[3];
    vec2 param_9 = geometry.local[2];
    float param_10 = aPosition.y;
    float param_11 = aPosition.x;
    vec2 local_pos = bilerp(param_6, param_7, param_8, param_9, param_10, param_11);
    vec4 world_pos = transform.m * vec4(local_pos, 0.0, 1.0);
    vec4 final_pos = vec4((dest_origin * world_pos.w) + (world_pos.xy * dest_task.device_pixel_scale), world_pos.w * ci.z, world_pos.w);
    vec4 param_12 = world_pos;
    ClipArea param_13 = clip_area;
    write_clip(param_12, param_13);
    gl_Position = uTransform * final_pos;
    vec2 texture_size = vec2(vec3(textureSize(sPrevPassColor, 0)).xy);
    vec2 uv0 = res.uv_rect.p0;
    vec2 uv1 = res.uv_rect.p1;
    vec2 min_uv = min(uv0, uv1);
    vec2 max_uv = max(uv0, uv1);
    vUvSampleBounds = vec4(min_uv + vec2(0.5), max_uv - vec2(0.5)) / texture_size.xyxy;
    vec2 f = (local_pos - ph.local_rect.p0) / ph.local_rect.size;
    int param_14 = ph.user_data.x;
    vec2 param_15 = f;
    f = get_image_quad_uv(param_14, param_15);
    vec2 uv = mix(uv0, uv1, f);
    float perspective_interpolate = float(ph.user_data.y);
    vUv = (uv / texture_size) * mix(gl_Position.w, 1.0, perspective_interpolate);
    vLayerAndPerspective = vec2(res.layer, perspective_interpolate);
}

