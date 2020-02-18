#version 300 es
precision mediump float;
precision highp int;

uniform mediump sampler2D sColor0;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 flat_varying_vec4_2;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_4;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

float _181;

void main()
{
    oFragColor = texture(sColor0, vec3(clamp(mod(varying_vec4_0.zw * mix(gl_FragCoord.w, 1.0, flat_varying_vec4_4.y), flat_varying_vec4_2.zw - flat_varying_vec4_2.xy) + flat_varying_vec4_2.xy, flat_varying_vec4_3.xy, flat_varying_vec4_3.zw), _181).xy);
}

