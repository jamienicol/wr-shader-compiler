#version 150
#extension GL_ARB_explicit_attrib_location : enable
precision highp float;
layout(location=0, index=0) out vec4 oFragColor;
void main ()
{
  oFragColor = vec4(0.11, 0.077, 0.027, 0.125);
}

