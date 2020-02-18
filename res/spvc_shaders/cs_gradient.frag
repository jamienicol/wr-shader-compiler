#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;

flat in highp vec4 vColor0;
flat in highp vec4 vColor1;
flat in highp vec4 vStops;
in highp float vPos;
flat in highp vec4 vColor2;
flat in highp vec4 vColor3;
layout(location = 0) out highp vec4 oFragColor;

highp float linear_step(highp float edge0, highp float edge1, highp float x)
{
    if (edge0 >= edge1)
    {
        return 0.0;
    }
    return clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);
}

void main()
{
    highp vec4 color = vColor0;
    highp float param = vStops.x;
    highp float param_1 = vStops.y;
    highp float param_2 = vPos;
    color = mix(color, vColor1, vec4(linear_step(param, param_1, param_2)));
    highp float param_3 = vStops.y;
    highp float param_4 = vStops.z;
    highp float param_5 = vPos;
    color = mix(color, vColor2, vec4(linear_step(param_3, param_4, param_5)));
    highp float param_6 = vStops.z;
    highp float param_7 = vStops.w;
    highp float param_8 = vPos;
    color = mix(color, vColor3, vec4(linear_step(param_6, param_7, param_8)));
    oFragColor = color;
}

