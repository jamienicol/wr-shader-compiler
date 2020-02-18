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

struct Glyph
{
    vec2 offset;
};

struct GlyphResource
{
    vec4 uv_rect;
    float layer;
    vec2 offset;
    float scale;
};

struct TextRun
{
    vec4 color;
    vec4 bg_color;
};

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform int uMode;
uniform mat4 uTransform;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;

layout(location = 1) in ivec4 aData;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
layout(location = 0) in vec3 aPosition;
out vec4 varying_vec4_1;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_0;
out vec4 varying_vec4_0;
flat out vec4 flat_varying_vec4_2;
flat out vec4 vTransformBounds;

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

PictureTask fetch_picture_task(int address)
{
    int param = address;
    RenderTaskData task_data = fetch_render_task_data(param);
    PictureTask task = PictureTask(task_data.common_data, task_data.user_data.x, task_data.user_data.yz);
    return task;
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

TextRun fetch_text_run(int address)
{
    int param = address;
    vec4 data[2] = fetch_from_gpu_cache_2(param);
    return TextRun(data[0], data[1]);
}

vec4 fetch_from_gpu_cache_1(int address)
{
    int param = address;
    ivec2 uv = get_gpu_cache_uv(param);
    return texelFetch(sGpuCache, uv, 0);
}

Glyph fetch_glyph(int specific_prim_address, int glyph_index)
{
    int glyph_address = (specific_prim_address + 2) + int(uint(glyph_index) / 2u);
    int param = glyph_address;
    vec4 data = fetch_from_gpu_cache_1(param);
    bvec2 _605 = bvec2((uint(glyph_index) % 2u) != 0u);
    vec2 glyph = vec2(_605.x ? data.zw.x : data.xy.x, _605.y ? data.zw.y : data.xy.y);
    return Glyph(glyph);
}

GlyphResource fetch_glyph_resource(int address)
{
    int param = address;
    vec4 data[2] = fetch_from_gpu_cache_2(param);
    return GlyphResource(data[0], data[1].x, data[1].yz, data[1].w);
}

RectWithSize transform_rect(RectWithSize rect, mat2 transform)
{
    vec2 center = transform * (rect.p0 + (rect.size * 0.5));
    vec2 radius = mat2(vec2(abs(transform[0])), vec2(abs(transform[1]))) * (rect.size * 0.5);
    return RectWithSize(center - radius, radius * 2.0);
}

bool rect_inside_rect(RectWithSize little, RectWithSize big)
{
    return all(lessThanEqual(vec4(big.p0, little.p0 + little.size), vec4(little.p0, big.p0 + big.size)));
}

vec2 clamp_rect(vec2 pt, RectWithSize rect)
{
    return clamp(pt, rect.p0, rect.p0 + rect.size);
}

void write_clip(vec4 world_pos, ClipArea area)
{
    vec2 uv = (world_pos.xy * area.device_pixel_scale) + ((area.common_data.task_rect.p0 - area.screen_origin) * world_pos.w);
    vClipMaskUvBounds = vec4(area.common_data.task_rect.p0, area.common_data.task_rect.p0 + area.common_data.task_rect.size);
    vClipMaskUv = vec4(uv, area.common_data.texture_layer_index, world_pos.w);
}

void main()
{
    Instance instance = decode_instance_attributes();
    int glyph_index = instance.segment_index;
    int subpx_dir = (instance.flags >> 8) & 255;
    int color_mode = instance.flags & 255;
    int param = instance.prim_header_address;
    PrimitiveHeader ph = fetch_prim_header(param);
    int param_1 = ph.transform_id;
    Transform transform = fetch_transform(param_1);
    int param_2 = instance.clip_address;
    ClipArea clip_area = fetch_clip_area(param_2);
    int param_3 = instance.picture_task_address;
    PictureTask task = fetch_picture_task(param_3);
    int param_4 = ph.specific_prim_address;
    TextRun text = fetch_text_run(param_4);
    vec2 text_offset = vec2(ph.user_data.xy) / vec2(256.0);
    if (color_mode == 0)
    {
        color_mode = uMode;
    }
    int param_5 = ph.specific_prim_address;
    int param_6 = glyph_index;
    Glyph glyph = fetch_glyph(param_5, param_6);
    glyph.offset += ph.local_rect.p0;
    int param_7 = instance.resource_address;
    GlyphResource res = fetch_glyph_resource(param_7);
    vec2 snap_bias;
    switch (subpx_dir)
    {
        case 1:
        {
            snap_bias = vec2(0.125, 0.5);
            break;
        }
        case 2:
        {
            snap_bias = vec2(0.5, 0.125);
            break;
        }
        case 3:
        {
            snap_bias = vec2(0.125);
            break;
        }
        default:
        {
            snap_bias = vec2(0.5);
            break;
        }
    }
    mat2 glyph_transform = mat2(transform.m[0].xy, transform.m[1].xy) * task.device_pixel_scale;
    vec2 glyph_translation = transform.m[3].xy * task.device_pixel_scale;
    mat2 glyph_transform_inv = inverse(glyph_transform);
    vec2 raster_glyph_offset = floor((glyph_transform * glyph.offset) + snap_bias);
    vec2 raster_text_offset = floor(((glyph_transform * text_offset) + glyph_translation) + vec2(0.5)) - glyph_translation;
    RectWithSize glyph_rect = RectWithSize((res.offset + raster_glyph_offset) + raster_text_offset, res.uv_rect.zw - res.uv_rect.xy);
    RectWithSize param_8 = glyph_rect;
    mat2 param_9 = glyph_transform_inv;
    RectWithSize local_rect = transform_rect(param_8, param_9);
    vec2 local_pos = local_rect.p0 + (local_rect.size * aPosition.xy);
    RectWithSize param_10 = local_rect;
    RectWithSize param_11 = ph.local_clip_rect;
    if (rect_inside_rect(param_10, param_11))
    {
        local_pos = glyph_transform_inv * (glyph_rect.p0 + (glyph_rect.size * aPosition.xy));
    }
    vec2 param_12 = local_pos;
    RectWithSize param_13 = ph.local_clip_rect;
    local_pos = clamp_rect(param_12, param_13);
    vec4 world_pos = transform.m * vec4(local_pos, 0.0, 1.0);
    vec2 device_pos = world_pos.xy * task.device_pixel_scale;
    vec2 final_offset = (-task.content_origin) + task.common_data.task_rect.p0;
    gl_Position = uTransform * vec4(device_pos + (final_offset * world_pos.w), ph.z * world_pos.w, world_pos.w);
    vec2 f = ((glyph_transform * local_pos) - glyph_rect.p0) / glyph_rect.size;
    varying_vec4_1 = vec4(f, vec2(1.0) - f);
    vec4 param_14 = world_pos;
    ClipArea param_15 = clip_area;
    write_clip(param_14, param_15);
    switch (color_mode)
    {
        case 1:
        case 7:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0, 1.0).x, vec2(0.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = text.color;
            break;
        }
        case 5:
        case 6:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = text.color;
            break;
        }
        case 2:
        case 3:
        case 8:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(text.color.w);
            break;
        }
        case 4:
        {
            flat_varying_vec4_1 = vec4(vec2(-1.0, 1.0).x, vec2(-1.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(text.color.w) * text.bg_color;
            break;
        }
        default:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0).x, vec2(0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(1.0);
            break;
        }
    }
    vec2 texture_size = vec2(vec3(textureSize(sColor0, 0)).xy);
    vec2 st0 = res.uv_rect.xy / texture_size;
    vec2 st1 = res.uv_rect.zw / texture_size;
    vec2 _971 = mix(st0, st1, f);
    varying_vec4_0 = vec4(_971.x, _971.y, varying_vec4_0.z, varying_vec4_0.w);
    varying_vec4_0.z = res.layer;
    flat_varying_vec4_2 = (res.uv_rect + vec4(0.5, 0.5, -0.5, -0.5)) / texture_size.xyxy;
}

