#version 150
precision highp float;
out vec4 oFragColor;
uniform sampler2DArray sColor0;
in vec3 vUv;
flat in vec4 vUvRect;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.xy = min (max (vUv.xy, vUvRect.xy), vUvRect.zw);
  tmpvar_1.z = vUv.z;
  oFragColor = texture (sColor0, tmpvar_1);
}

