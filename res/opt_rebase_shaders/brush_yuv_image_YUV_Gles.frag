#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
in highp vec3 vUv_Y;
flat in highp vec4 vUvBounds_Y;
in highp vec3 vUv_U;
flat in highp vec4 vUvBounds_U;
in highp vec3 vUv_V;
flat in highp vec4 vUvBounds_V;
flat in highp float vCoefficient;
flat in highp mat3 vYuvColorMatrix;
flat in mediump int vFormat;
void main ()
{
  highp vec3 yuv_value_1;
  bool tmpvar_2;
  tmpvar_2 = bool(0);
  while (true) {
    tmpvar_2 = (tmpvar_2 || (1 == vFormat));
    if (tmpvar_2) {
      vec3 tmpvar_3;
      tmpvar_3.xy = min (max (vUv_Y.xy, vUvBounds_Y.xy), vUvBounds_Y.zw);
      tmpvar_3.z = vUv_Y.z;
      yuv_value_1.x = texture (sColor0, tmpvar_3).x;
      vec3 tmpvar_4;
      tmpvar_4.xy = min (max (vUv_U.xy, vUvBounds_U.xy), vUvBounds_U.zw);
      tmpvar_4.z = vUv_U.z;
      yuv_value_1.y = texture (sColor1, tmpvar_4).x;
      vec3 tmpvar_5;
      tmpvar_5.xy = min (max (vUv_V.xy, vUvBounds_V.xy), vUvBounds_V.zw);
      tmpvar_5.z = vUv_V.z;
      yuv_value_1.z = texture (sColor2, tmpvar_5).x;
      break;
    };
    tmpvar_2 = (tmpvar_2 || (0 == vFormat));
    if (tmpvar_2) {
      vec3 tmpvar_6;
      tmpvar_6.xy = min (max (vUv_Y.xy, vUvBounds_Y.xy), vUvBounds_Y.zw);
      tmpvar_6.z = vUv_Y.z;
      yuv_value_1.x = texture (sColor0, tmpvar_6).x;
      vec3 tmpvar_7;
      tmpvar_7.xy = min (max (vUv_U.xy, vUvBounds_U.xy), vUvBounds_U.zw);
      tmpvar_7.z = vUv_U.z;
      yuv_value_1.yz = texture (sColor1, tmpvar_7).xy;
      break;
    };
    tmpvar_2 = (tmpvar_2 || (2 == vFormat));
    if (tmpvar_2) {
      vec3 tmpvar_8;
      tmpvar_8.xy = min (max (vUv_Y.xy, vUvBounds_Y.xy), vUvBounds_Y.zw);
      tmpvar_8.z = vUv_Y.z;
      yuv_value_1 = texture (sColor0, tmpvar_8).yzx;
      break;
    };
    tmpvar_2 = bool(1);
    yuv_value_1 = vec3(0.0, 0.0, 0.0);
    break;
  };
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (vYuvColorMatrix * ((yuv_value_1 * vCoefficient) - vec3(0.06275, 0.50196, 0.50196)));
  oFragColor = tmpvar_9;
}

