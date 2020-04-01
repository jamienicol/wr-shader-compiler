#version 150
precision highp float;
out vec4 oFragColor;
uniform sampler2DArray sColor0;
flat in vec4 vColor;
flat in float vLayer;
in vec2 vUv;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.xy = vUv;
  tmpvar_1.z = vLayer;
  oFragColor = (vColor * textureLod (sColor0, tmpvar_1, 0.0));
}

