#version 310 es
precision highp float;
precision highp sampler2DArray;
out lowp vec4 oFragColor;
uniform sampler2DArray sColor0;
in vec3 vUv;
flat in vec4 vUvRect;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.xy = clamp (vUv.xy, vUvRect.xy, vUvRect.zw);
  tmpvar_1.z = vUv.z;
  oFragColor = texture (sColor0, tmpvar_1);
}

