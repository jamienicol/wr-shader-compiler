#version 300 es
precision mediump float;
precision highp int;

struct Fragment
{
    highp vec4 color;
};

uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2DArray sPrevPassColor;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_0;
flat in int flat_varying_highp_int_address_0;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_1;

mediump ivec2 get_gpu_cache_uv(int address)
{
    return ivec2(int(uint(address) % 1024u), int(uint(address) / 1024u));
}

highp vec4[2] fetch_from_gpu_cache_2(int address)
{
    int param = address;
    mediump ivec2 uv = get_gpu_cache_uv(param);
    return vec4[](texelFetch(sGpuCache, uv + ivec2(0), 0), texelFetch(sGpuCache, uv + ivec2(1, 0), 0));
}

highp vec4 dither(highp vec4 color)
{
    return color;
}

highp vec4 sample_gradient(int address, highp float offset, highp float gradient_repeat)
{
    highp float x = mix(offset, fract(offset), gradient_repeat);
    x = 1.0 + (x * 128.0);
    mediump int lut_offset = 2 * int(floor(x));
    lut_offset = clamp(lut_offset, 0, 258);
    int param = address + lut_offset;
    highp vec4 texels[2] = fetch_from_gpu_cache_2(param);
    highp vec4 param_1 = mix(texels[0], texels[1], vec4(fract(x)));
    return dither(param_1);
}

highp float signed_distance_rect(highp vec2 pos, highp vec2 p0, highp vec2 p1)
{
    highp vec2 d = max(p0 - pos, pos - p1);
    return length(max(vec2(0.0), d)) + min(0.0, max(d.x, d.y));
}

highp float compute_aa_range(highp vec2 position)
{
    return 0.3535499870777130126953125 * length(fwidth(position));
}

highp float distance_aa(highp float aa_range, highp float signed_distance)
{
    highp float dist = (0.5 * signed_distance) / aa_range;
    if (dist <= (-0.4999000132083892822265625))
    {
        return 1.0;
    }
    if (dist >= 0.4999000132083892822265625)
    {
        return 0.0;
    }
    return 0.5 + (dist * (((0.8431026935577392578125 * dist) * dist) - 1.14453601837158203125));
}

highp float init_transform_fs(highp vec2 local_pos)
{
    highp vec2 param = local_pos;
    highp vec2 param_1 = vTransformBounds.xy;
    highp vec2 param_2 = vTransformBounds.zw;
    highp float d = signed_distance_rect(param, param_1, param_2);
    highp vec2 param_3 = local_pos;
    highp float aa_range = compute_aa_range(param_3);
    highp float param_4 = aa_range;
    highp float param_5 = d;
    return distance_aa(param_4, param_5);
}

Fragment linear_gradient_brush_fs()
{
    highp vec2 local_pos = max(varying_vec4_0.zw, vec2(0.0));
    highp vec2 pos = mod(local_pos, flat_varying_vec4_1.xy);
    highp vec2 prim_size = flat_varying_vec4_1.xy * flat_varying_vec4_2.xy;
    if (local_pos.x >= prim_size.x)
    {
        pos.x = flat_varying_vec4_1.x;
    }
    if (local_pos.y >= prim_size.y)
    {
        pos.y = flat_varying_vec4_1.y;
    }
    highp float offset = dot(pos - flat_varying_vec4_0.xy, flat_varying_vec4_0.zw);
    int param = flat_varying_highp_int_address_0;
    highp float param_1 = offset;
    highp float param_2 = flat_varying_vec4_1.z;
    highp vec4 color = sample_gradient(param, param_1, param_2);
    highp vec2 param_3 = varying_vec4_0.xy;
    color *= init_transform_fs(param_3);
    return Fragment(color);
}

highp float do_clip()
{
    if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
    {
        return 1.0;
    }
    highp vec2 mask_uv = vClipMaskUv.xy * gl_FragCoord.w;
    bvec2 left = lessThanEqual(vClipMaskUvBounds.xy, mask_uv);
    bvec2 right = greaterThan(vClipMaskUvBounds.zw, mask_uv);
    if (!all(bvec4(left, right)))
    {
        return 0.0;
    }
    mediump ivec3 tc = ivec3(ivec2(mask_uv), int(vClipMaskUv.z + 0.5));
    return texelFetch(sPrevPassAlpha, tc, 0).x;
}

void write_output(highp vec4 color)
{
    oFragColor = color;
}

void main()
{
    Fragment frag = linear_gradient_brush_fs();
    highp float clip_alpha = do_clip();
    frag.color *= clip_alpha;
    highp vec4 param = frag.color;
    write_output(param);
}

