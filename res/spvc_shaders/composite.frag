#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;

layout(location = 0) out highp vec4 oFragColor;
in highp vec2 vUv;
flat in highp float vLayer;
flat in highp vec4 vColor;

void write_output(highp vec4 color)
{
    oFragColor = color;
}

void main()
{
    highp vec4 texel = textureLod(sColor0, vec3(vUv, vLayer), 0.0);
    highp vec4 color = vColor * texel;
    highp vec4 param = color;
    write_output(param);
}

