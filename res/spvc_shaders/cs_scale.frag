#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;

in highp vec3 vUv;
flat in highp vec4 vUvRect;
layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;

void main()
{
    highp vec2 st = clamp(vUv.xy, vUvRect.xy, vUvRect.zw);
    oFragColor = texture(sColor0, vec3(st, vUv.z));
}

