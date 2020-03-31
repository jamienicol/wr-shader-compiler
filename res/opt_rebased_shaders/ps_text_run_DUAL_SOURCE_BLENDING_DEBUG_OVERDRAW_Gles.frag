#version 300 es
#extension GL_EXT_blend_func_extended : enable
precision highp float;
precision highp sampler2DArray;
layout(location=0, index=0) out highp vec4 oFragColor;
void main ()
{
  oFragColor = vec4(0.11, 0.077, 0.027, 0.125);
}

