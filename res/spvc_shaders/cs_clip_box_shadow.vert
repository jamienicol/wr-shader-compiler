#version 300 es

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

struct Transform
{
    mat4 m;
    mat4 inv_m;
    bool is_axis_aligned;
};

struct RectWithSize
{
    vec2 p0;
    vec2 size;
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

struct BoxShadowData
{
    vec2 src_rect_size;
    float clip_mode;
    int stretch_mode_x;
    int stretch_mode_y;
    RectWithSize dest_rect;
};

uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform mat4 uTransform;
uniform highp sampler2DArray sColor0;
uniform int uMode;
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
flat out float vLayer;
flat out float vClipMode;
out vec4 vLocalPos;
flat out vec4 vEdge;
out vec2 vUv;
flat out vec4 vUvBounds;
flat out vec4 vUvBounds_NoClamp;

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

vec4[3] fetch_from_gpu_cache_3_direct(ivec2 address)
{
    return vec4[](texelFetch(sGpuCache, address + ivec2(0), 0), texelFetch(sGpuCache, address + ivec2(1, 0), 0), texelFetch(sGpuCache, address + ivec2(2, 0), 0));
}

BoxShadowData fetch_data(ivec2 address)
{
    ivec2 param = address;
    vec4 data[3] = fetch_from_gpu_cache_3_direct(param);
    RectWithSize dest_rect = RectWithSize(data[2].xy, data[2].zw);
    BoxShadowData bs_data = BoxShadowData(data[0].xy, data[0].z, int(data[1].x), int(data[1].y), dest_rect);
    return bs_data;
}

vec4[2] fetch_from_gpu_cache_2_direct(ivec2 address)
{
    return vec4[](texelFetch(sGpuCache, address + ivec2(0), 0), texelFetch(sGpuCache, address + ivec2(1, 0), 0));
}

ImageResource fetch_image_resource_direct(ivec2 address)
{
    ivec2 param = address;
    vec4 data[2] = fetch_from_gpu_cache_2_direct(param);
    RectWithEndpoint uv_rect = RectWithEndpoint(data[0].xy, data[0].zw);
    return ImageResource(uv_rect, data[1].x, data[1].yzw);
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
    bool _299 = ray_plane(param, param_1, param_2, param_3, param_4);
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
    vec3 _443 = pos.xyz / vec3(pos.w);
    pos = vec4(_443.x, _443.y, _443.z, pos.w);
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

void main()
{
    ClipMaskInstance cmi = fetch_clip_item();
    int param = cmi.clip_transform_id;
    Transform clip_transform = fetch_transform(param);
    int param_1 = cmi.prim_transform_id;
    Transform prim_transform = fetch_transform(param_1);
    ivec2 param_2 = cmi.clip_data_address;
    BoxShadowData bs_data = fetch_data(param_2);
    ivec2 param_3 = cmi.resource_address;
    ImageResource res = fetch_image_resource_direct(param_3);
    RectWithSize dest_rect = bs_data.dest_rect;
    RectWithSize param_4 = dest_rect;
    Transform param_5 = prim_transform;
    Transform param_6 = clip_transform;
    RectWithSize param_7 = cmi.sub_rect;
    vec2 param_8 = cmi.task_origin;
    vec2 param_9 = cmi.screen_origin;
    float param_10 = cmi.device_pixel_scale;
    ClipVertexInfo _579 = write_clip_tile_vertex(param_4, param_5, param_6, param_7, param_8, param_9, param_10);
    ClipVertexInfo vi = _579;
    vLayer = res.layer;
    vClipMode = bs_data.clip_mode;
    vec2 texture_size = vec2(vec3(textureSize(sColor0, 0)).xy);
    vec2 local_pos = vi.local_pos.xy / vec2(vi.local_pos.w);
    vLocalPos = vi.local_pos;
    switch (bs_data.stretch_mode_x)
    {
        case 0:
        {
            vEdge.x = 0.5;
            vEdge.z = (dest_rect.size.x / bs_data.src_rect_size.x) - 0.5;
            vUv.x = (local_pos.x - dest_rect.p0.x) / bs_data.src_rect_size.x;
            break;
        }
        default:
        {
            vEdge = vec4(vec2(1.0).x, vEdge.y, vec2(1.0).y, vEdge.w);
            vUv.x = (local_pos.x - dest_rect.p0.x) / dest_rect.size.x;
            break;
        }
    }
    switch (bs_data.stretch_mode_y)
    {
        case 0:
        {
            vEdge.y = 0.5;
            vEdge.w = (dest_rect.size.y / bs_data.src_rect_size.y) - 0.5;
            vUv.y = (local_pos.y - dest_rect.p0.y) / bs_data.src_rect_size.y;
            break;
        }
        default:
        {
            vEdge = vec4(vEdge.x, vec2(1.0).x, vEdge.z, vec2(1.0).y);
            vUv.y = (local_pos.y - dest_rect.p0.y) / dest_rect.size.y;
            break;
        }
    }
    vUv *= vi.local_pos.w;
    vec2 uv0 = res.uv_rect.p0;
    vec2 uv1 = res.uv_rect.p1;
    vUvBounds = vec4(uv0 + vec2(0.5), uv1 - vec2(0.5)) / texture_size.xyxy;
    vUvBounds_NoClamp = vec4(uv0, uv1) / texture_size.xyxy;
}

