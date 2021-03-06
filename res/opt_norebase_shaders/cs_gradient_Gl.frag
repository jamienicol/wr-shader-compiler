#version 150
precision highp float;
out vec4 oFragColor;
in float vPos;
flat in vec4 vStops;
flat in vec4 vColor0;
flat in vec4 vColor1;
flat in vec4 vColor2;
flat in vec4 vColor3;
void main ()
{
  vec4 color_1;
  color_1 = vColor0;
  float tmpvar_2;
  if ((vStops.x >= vStops.y)) {
    tmpvar_2 = 0.0;
  } else {
    tmpvar_2 = clamp (((vPos - vStops.x) / (vStops.y - vStops.x)), 0.0, 1.0);
  };
  color_1 = mix (vColor0, vColor1, tmpvar_2);
  float tmpvar_3;
  if ((vStops.y >= vStops.z)) {
    tmpvar_3 = 0.0;
  } else {
    tmpvar_3 = clamp (((vPos - vStops.y) / (vStops.z - vStops.y)), 0.0, 1.0);
  };
  color_1 = mix (color_1, vColor2, tmpvar_3);
  float tmpvar_4;
  if ((vStops.z >= vStops.w)) {
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = clamp (((vPos - vStops.z) / (vStops.w - vStops.z)), 0.0, 1.0);
  };
  vec4 tmpvar_5;
  tmpvar_5 = mix (color_1, vColor3, tmpvar_4);
  color_1 = tmpvar_5;
  oFragColor = tmpvar_5;
}

