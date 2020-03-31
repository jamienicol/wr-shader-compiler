#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform highp sampler2DArray sColor0;
flat in highp vec4 vColor;
flat in highp float vLayer;
in highp vec2 vUv;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.xy = vUv;
  tmpvar_1.z = vLayer;
  oFragColor = (vColor * textureLod (sColor0, tmpvar_1, 0.0));
}

