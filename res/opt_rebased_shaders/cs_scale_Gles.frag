#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform highp sampler2DArray sColor0;
in highp vec3 vUv;
flat in highp vec4 vUvRect;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.xy = min (max (vUv.xy, vUvRect.xy), vUvRect.zw);
  tmpvar_1.z = vUv.z;
  oFragColor = texture (sColor0, tmpvar_1);
}

