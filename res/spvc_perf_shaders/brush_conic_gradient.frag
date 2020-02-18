#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2D sGpuCache;

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

void main()
{
    highp vec2 _219 = mod(varying_vec4_0.zw, flat_varying_vec4_1.xy) - flat_varying_vec4_0.xy;
    highp float _231 = mod((atan(_219.y, _219.x) + (1.57079637050628662109375 - flat_varying_vec4_0.z)) * 0.15915493667125701904296875, 1.0);
    highp float _252 = 1.0 + (mix(_231, fract(_231), flat_varying_vec4_1.z) * 128.0);
    uint _290 = uint(flat_varying_highp_int_address_0 + clamp(2 * int(floor(_252)), 0, 258));
    ivec2 _297 = ivec2(int(_290 % 1024u), int(_290 / 1024u));
    oFragColor = mix(texelFetch(sGpuCache, _297, 0), texelFetch(sGpuCache, _297 + ivec2(1, 0), 0), vec4(fract(_252)));
}

