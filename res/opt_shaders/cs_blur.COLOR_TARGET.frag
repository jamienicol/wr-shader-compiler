#version 300 es
precision highp float;
precision highp sampler2DArray;
out lowp vec4 oFragColor;
uniform sampler2DArray sPrevPassColor;
in vec3 vUv;
flat in vec4 vUvRect;
flat in vec2 vOffsetScale;
flat in float vSigma;
flat in highp int vSupport;
void main ()
{
  lowp vec4 avg_color_2;
  float gauss_coefficient_total_3;
  vec3 gauss_coefficient_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (sPrevPassColor, vUv);
  if ((vSupport == 0)) {
    oFragColor = tmpvar_5;
    return;
  };
  gauss_coefficient_4.x = (1.0/((2.506628 * vSigma)));
  gauss_coefficient_4.y = exp((-0.5 / (vSigma * vSigma)));
  gauss_coefficient_4.z = (gauss_coefficient_4.y * gauss_coefficient_4.y);
  gauss_coefficient_total_3 = gauss_coefficient_4.x;
  avg_color_2 = (tmpvar_5 * gauss_coefficient_4.x);
  gauss_coefficient_4.xy = (gauss_coefficient_4.xy * gauss_coefficient_4.yz);
  for (highp int i_1 = 1; i_1 <= vSupport; i_1 += 2) {
    float gauss_coefficient_subtotal_6;
    float tmpvar_7;
    tmpvar_7 = gauss_coefficient_4.x;
    gauss_coefficient_4.xy = (gauss_coefficient_4.xy * gauss_coefficient_4.yz);
    gauss_coefficient_subtotal_6 = (tmpvar_7 + gauss_coefficient_4.x);
    vec2 tmpvar_8;
    tmpvar_8 = (vOffsetScale * (float(i_1) + (gauss_coefficient_4.x / gauss_coefficient_subtotal_6)));
    vec3 tmpvar_9;
    tmpvar_9.xy = clamp ((vUv.xy - tmpvar_8), vUvRect.xy, vUvRect.zw);
    tmpvar_9.z = vUv.z;
    avg_color_2 = (avg_color_2 + (texture (sPrevPassColor, tmpvar_9) * gauss_coefficient_subtotal_6));
    vec3 tmpvar_10;
    tmpvar_10.xy = clamp ((vUv.xy + tmpvar_8), vUvRect.xy, vUvRect.zw);
    tmpvar_10.z = vUv.z;
    avg_color_2 = (avg_color_2 + (texture (sPrevPassColor, tmpvar_10) * gauss_coefficient_subtotal_6));
    gauss_coefficient_total_3 = (gauss_coefficient_total_3 + (2.0 * gauss_coefficient_subtotal_6));
    gauss_coefficient_4.xy = (gauss_coefficient_4.xy * gauss_coefficient_4.yz);
  };
  oFragColor = (avg_color_2 / gauss_coefficient_total_3);
}

