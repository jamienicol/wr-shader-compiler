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

struct Transform
{
    mat4 m;
    mat4 inv_m;
    bool is_axis_aligned;
};

struct ClipMaskInstance
{
    int clip_transform_id;
    int prim_transform_id;
    ivec2 clip_data_address;
    ivec2 resource_address;
    vec2 local_pos;
    RectWithSize tile_rect;
    RectWithSize sub_rect;
    vec2 task_origin;
    vec2 screen_origin;
    float device_pixel_scale;
};

struct ClipVertexInfo
{
    vec4 local_pos;
    RectWithSize clipped_local_rect;
};

struct ClipRect
{
    RectWithSize rect;
    vec4 mode;
};

struct ClipCorner
{
    RectWithSize rect;
    vec4 outer_inner_radius;
};

struct ClipData
{
    ClipRect rect;
    ClipCorner top_left;
    ClipCorner top_right;
    ClipCorner bottom_left;
    ClipCorner bottom_right;
};

uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform mat4 uTransform;
uniform int uMode;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sRenderTasks;

flat out vec4 vTransformBounds;
layout(location = 1) in ivec2 aTransformIds;
layout(location = 2) in ivec4 aClipDataResourceAddress;
layout(location = 3) in vec2 aClipLocalPos;
layout(location = 4) in vec4 aClipTileRect;
layout(location = 5) in vec4 aClipDeviceArea;
layout(location = 6) in vec4 aClipOrigins;
layout(location = 7) in float aDevicePixelScale;
layout(location = 0) in vec3 aPosition;
flat out float vClipMode;
out vec4 vLocalPos;
flat out vec4 vClipCenter_Radius_TL;
flat out vec4 vClipCenter_Radius_TR;
flat out vec4 vClipCenter_Radius_BR;
flat out vec4 vClipCenter_Radius_BL;

ClipMaskInstance fetch_clip_item()
{
    ClipMaskInstance cmi;
    cmi.clip_transform_id = aTransformIds.x;
    cmi.prim_transform_id = aTransformIds.y;
    cmi.clip_data_address = aClipDataResourceAddress.xy;
    cmi.resource_address = aClipDataResourceAddress.zw;
    cmi.local_pos = aClipLocalPos;
    cmi.tile_rect = RectWithSize(aClipTileRect.xy, aClipTileRect.zw);
    cmi.sub_rect = RectWithSize(aClipDeviceArea.xy, aClipDeviceArea.zw);
    cmi.task_origin = aClipOrigins.xy;
    cmi.screen_origin = aClipOrigins.zw;
    cmi.device_pixel_scale = aDevicePixelScale;
    return cmi;
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

vec4[2] fetch_from_gpu_cache_2_direct(ivec2 address)
{
    return vec4[](texelFetch(sGpuCache, address + ivec2(0), 0), texelFetch(sGpuCache, address + ivec2(1, 0), 0));
}

ClipRect fetch_clip_rect(ivec2 address)
{
    ivec2 param = address;
    vec4 data[2] = fetch_from_gpu_cache_2_direct(param);
    ClipRect rect = ClipRect(RectWithSize(data[0].xy, data[0].zw), data[1]);
    return rect;
}

ClipCorner fetch_clip_corner(inout ivec2 address, float index)
{
    address += ivec2(2 + (2 * int(index)), 0);
    ivec2 param = address;
    vec4 data[2] = fetch_from_gpu_cache_2_direct(param);
    ClipCorner corner = ClipCorner(RectWithSize(data[0].xy, data[0].zw), data[1]);
    return corner;
}

ClipData fetch_clip(ivec2 address)
{
    ivec2 param = address;
    ClipData clip;
    clip.rect = fetch_clip_rect(param);
    ivec2 param_1 = address;
    float param_2 = 0.0;
    ClipCorner _536 = fetch_clip_corner(param_1, param_2);
    clip.top_left = _536;
    ivec2 param_3 = address;
    float param_4 = 1.0;
    ClipCorner _541 = fetch_clip_corner(param_3, param_4);
    clip.top_right = _541;
    ivec2 param_5 = address;
    float param_6 = 2.0;
    ClipCorner _547 = fetch_clip_corner(param_5, param_6);
    clip.bottom_left = _547;
    ivec2 param_7 = address;
    float param_8 = 3.0;
    ClipCorner _553 = fetch_clip_corner(param_7, param_8);
    clip.bottom_right = _553;
    return clip;
}

bool ray_plane(vec3 normal, vec3 pt, vec3 ray_origin, vec3 ray_dir, inout float t)
{
    float denom = dot(normal, ray_dir);
    if (abs(denom) > 9.9999999747524270787835121154785e-07)
    {
        vec3 d = pt - ray_origin;
        t = dot(d, normal) / denom;
        return t >= 0.0;
    }
    return false;
}

vec4 untransform(vec2 ref, vec3 n, vec3 a, mat4 inv_transform)
{
    vec3 p = vec3(ref, -10000.0);
    vec3 d = vec3(0.0, 0.0, 1.0);
    float t = 0.0;
    vec3 param = n;
    vec3 param_1 = a;
    vec3 param_2 = p;
    vec3 param_3 = d;
    float param_4;
    bool _276 = ray_plane(param, param_1, param_2, param_3, param_4);
    t = param_4;
    float z = p.z + (d.z * t);
    vec4 r = inv_transform * vec4(ref, z, 1.0);
    return r;
}

vec4 get_node_pos(vec2 pos, Transform transform)
{
    vec4 ah = transform.m * vec4(0.0, 0.0, 0.0, 1.0);
    vec3 a = ah.xyz / vec3(ah.w);
    vec3 n = transpose(mat3(transform.inv_m[0].xyz, transform.inv_m[1].xyz, transform.inv_m[2].xyz)) * vec3(0.0, 0.0, 1.0);
    vec2 param = pos;
    vec3 param_1 = n;
    vec3 param_2 = a;
    mat4 param_3 = transform.inv_m;
    return untransform(param, param_1, param_2, param_3);
}

void init_transform_vs(vec4 local_bounds)
{
    vTransformBounds = local_bounds;
}

ClipVertexInfo write_clip_tile_vertex(RectWithSize local_clip_rect, Transform prim_transform, Transform clip_transform, RectWithSize sub_rect, vec2 task_origin, vec2 screen_origin, float device_pixel_scale)
{
    vec2 device_pos = (screen_origin + sub_rect.p0) + (aPosition.xy * sub_rect.size);
    vec2 world_pos = device_pos / vec2(device_pixel_scale);
    vec4 pos = prim_transform.m * vec4(world_pos, 0.0, 1.0);
    vec3 _421 = pos.xyz / vec3(pos.w);
    pos = vec4(_421.x, _421.y, _421.z, pos.w);
    vec2 param = pos.xy;
    Transform param_1 = clip_transform;
    vec4 p = get_node_pos(param, param_1);
    vec4 local_pos = p * pos.w;
    vec4 vertex_pos = vec4((task_origin + sub_rect.p0) + (aPosition.xy * sub_rect.size), 0.0, 1.0);
    gl_Position = uTransform * vertex_pos;
    vec4 param_2 = vec4(local_clip_rect.p0, local_clip_rect.p0 + local_clip_rect.size);
    init_transform_vs(param_2);
    ClipVertexInfo vi = ClipVertexInfo(local_pos, local_clip_rect);
    return vi;
}

RectWithEndpoint to_rect_with_endpoint(RectWithSize rect)
{
    RectWithEndpoint result;
    result.p0 = rect.p0;
    result.p1 = rect.p0 + rect.size;
    return result;
}

void main()
{
    ClipMaskInstance cmi = fetch_clip_item();
    int param = cmi.clip_transform_id;
    Transform clip_transform = fetch_transform(param);
    int param_1 = cmi.prim_transform_id;
    Transform prim_transform = fetch_transform(param_1);
    ivec2 param_2 = cmi.clip_data_address;
    ClipData clip = fetch_clip(param_2);
    RectWithSize local_rect = clip.rect.rect;
    local_rect.p0 = cmi.local_pos;
    RectWithSize param_3 = local_rect;
    Transform param_4 = prim_transform;
    Transform param_5 = clip_transform;
    RectWithSize param_6 = cmi.sub_rect;
    vec2 param_7 = cmi.task_origin;
    vec2 param_8 = cmi.screen_origin;
    float param_9 = cmi.device_pixel_scale;
    ClipVertexInfo _600 = write_clip_tile_vertex(param_3, param_4, param_5, param_6, param_7, param_8, param_9);
    ClipVertexInfo vi = _600;
    vClipMode = clip.rect.mode.x;
    vLocalPos = vi.local_pos;
    RectWithSize param_10 = local_rect;
    RectWithEndpoint clip_rect = to_rect_with_endpoint(param_10);
    vec2 r_tl = clip.top_left.outer_inner_radius.xy;
    vec2 r_tr = clip.top_right.outer_inner_radius.xy;
    vec2 r_br = clip.bottom_right.outer_inner_radius.xy;
    vec2 r_bl = clip.bottom_left.outer_inner_radius.xy;
    vClipCenter_Radius_TL = vec4(clip_rect.p0 + r_tl, r_tl);
    vClipCenter_Radius_TR = vec4(clip_rect.p1.x - r_tr.x, clip_rect.p0.y + r_tr.y, r_tr);
    vClipCenter_Radius_BR = vec4(clip_rect.p1 - r_br, r_br);
    vClipCenter_Radius_BL = vec4(clip_rect.p0.x + r_bl.x, clip_rect.p1.y - r_bl.y, r_bl);
}

