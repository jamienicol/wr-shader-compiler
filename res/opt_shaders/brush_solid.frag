#version 300 es
precision highp float;
precision highp sampler2DArray;
out vec4 oFragColor;
flat in vec4 flat_varying_vec4_0;
void main ()
{
  oFragColor = flat_varying_vec4_0;
}

