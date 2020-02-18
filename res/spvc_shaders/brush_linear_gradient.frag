#version 300 es
precision mediump float;
precision highp int;

struct Fragment
{
    highp vec4 color;
};

uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;

layout(location = 0) out highp vec4 oFragColor;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_0;
flat in int flat_varying_highp_int_address_0;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_2;
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

Fragment linear_gradient_brush_fs()
{
    highp vec2 pos = mod(varying_vec4_0.zw, flat_varying_vec4_1.xy);
    highp float offset = dot(pos - flat_varying_vec4_0.xy, flat_varying_vec4_0.zw);
    int param = flat_varying_highp_int_address_0;
    highp float param_1 = offset;
    highp float param_2 = flat_varying_vec4_1.z;
    highp vec4 color = sample_gradient(param, param_1, param_2);
    return Fragment(color);
}

void write_output(highp vec4 color)
{
    oFragColor = color;
}

void main()
{
    Fragment frag = linear_gradient_brush_fs();
    highp vec4 param = frag.color;
    write_output(param);
}

