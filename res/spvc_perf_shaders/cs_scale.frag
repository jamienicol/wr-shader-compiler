#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;

in highp vec3 vUv;
flat in highp vec4 vUvRect;
layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;

void main()
{
    oFragColor = texture(sColor0, vec3(clamp(vUv.xy, vUvRect.xy, vUvRect.zw), vUv.z));
}

