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

Fragment radial_gradient_brush_fs()
{
    highp vec2 pos = mod(varying_vec4_0.zw, flat_varying_vec4_1.xy);
    highp vec2 pd = pos - flat_varying_vec4_0.xy;
    highp float rd = flat_varying_vec4_0.w - flat_varying_vec4_0.z;
    highp float A = -(rd * rd);
    highp float B = flat_varying_vec4_0.z * rd;
    highp float C = dot(pd, pd) - (flat_varying_vec4_0.z * flat_varying_vec4_0.z);
    highp float offset;
    if (A == 0.0)
    {
        if (B == 0.0)
        {
            discard;
        }
        highp float t = (0.5 * C) / B;
        if ((flat_varying_vec4_0.z + (rd * t)) >= 0.0)
        {
            offset = t;
        }
        else
        {
            discard;
        }
    }
    else
    {
        highp float discr = (B * B) - (A * C);
        if (discr < 0.0)
        {
            discard;
        }
        discr = sqrt(discr);
        highp float t0 = (B + discr) / A;
        highp float t1 = (B - discr) / A;
        if ((flat_varying_vec4_0.z + (rd * t0)) >= 0.0)
        {
            offset = t0;
        }
        else
        {
            if ((flat_varying_vec4_0.z + (rd * t1)) >= 0.0)
            {
                offset = t1;
            }
            else
            {
                discard;
            }
        }
    }
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
    Fragment _127 = radial_gradient_brush_fs();
    Fragment frag = _127;
    highp vec4 param = frag.color;
    write_output(param);
}

