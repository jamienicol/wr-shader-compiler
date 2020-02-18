#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;

layout(location = 0) out highp vec4 oFragColor;
in highp vec2 vUv;
flat in highp float vLayer;
flat in highp vec4 vColor;

void main()
{
    oFragColor = vColor * textureLod(sColor0, vec3(vUv, vLayer), 0.0);
}

