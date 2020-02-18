#version 300 es
precision mediump float;
precision highp int;

struct Fragment
{
    highp vec4 color;
};

uniform mediump sampler2D sColor0;
uniform mediump sampler2D sColor1;
uniform mediump sampler2D sColor2;
uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 flat_varying_vec4_4;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

Fragment image_brush_fs()
{
    highp float perspective_divisor = mix(gl_FragCoord.w, 1.0, flat_varying_vec4_4.y);
    highp vec2 repeated_uv = (varying_vec4_0.zw * perspective_divisor) + flat_varying_vec4_2.xy;
    highp vec2 uv = clamp(repeated_uv, flat_varying_vec4_3.xy, flat_varying_vec4_3.zw);
    highp vec4 texel = texture(sColor0, vec3(uv, flat_varying_vec4_4.x).xy);
    Fragment frag;
    frag.color = texel;
    return frag;
}

void write_output(highp vec4 color)
{
    oFragColor = color;
}

void main()
{
    Fragment frag = image_brush_fs();
    highp vec4 param = frag.color;
    write_output(param);
}

