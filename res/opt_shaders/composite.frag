#version 310 es
precision highp float;
precision highp sampler2DArray;
out lowp vec4 oFragColor;
uniform sampler2DArray sColor0;
in vec2 vUv;
flat in vec4 vColor;
flat in float vLayer;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.xy = vUv;
  tmpvar_1.z = vLayer;
  oFragColor = (vColor * textureLod (sColor0, tmpvar_1, 0.0));
}

