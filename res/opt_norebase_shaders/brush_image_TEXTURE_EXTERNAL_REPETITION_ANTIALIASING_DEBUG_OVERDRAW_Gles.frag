#version 300 es
#extension GL_OES_EGL_image_external_essl3 : enable
precision highp float;
precision highp sampler2DArray;
out vec4 oFragColor;
void main ()
{
  oFragColor = vec4(0.11, 0.077, 0.027, 0.125);
}

