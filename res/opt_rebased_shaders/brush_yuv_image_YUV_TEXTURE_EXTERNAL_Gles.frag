#version 300 es
#extension GL_OES_EGL_image_external_essl3 : enable
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform lowp samplerExternalOES sColor0;
uniform lowp samplerExternalOES sColor1;
uniform lowp samplerExternalOES sColor2;
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
      yuv_value_1.x = texture (sColor0, min (max (vUv_Y.xy, vUvBounds_Y.xy), vUvBounds_Y.zw)).x;
      yuv_value_1.y = texture (sColor1, min (max (vUv_U.xy, vUvBounds_U.xy), vUvBounds_U.zw)).x;
      yuv_value_1.z = texture (sColor2, min (max (vUv_V.xy, vUvBounds_V.xy), vUvBounds_V.zw)).x;
      break;
    };
    tmpvar_2 = (tmpvar_2 || (0 == vFormat));
    if (tmpvar_2) {
      yuv_value_1.x = texture (sColor0, min (max (vUv_Y.xy, vUvBounds_Y.xy), vUvBounds_Y.zw)).x;
      yuv_value_1.yz = texture (sColor1, min (max (vUv_U.xy, vUvBounds_U.xy), vUvBounds_U.zw)).xy;
      break;
    };
    tmpvar_2 = (tmpvar_2 || (2 == vFormat));
    if (tmpvar_2) {
      yuv_value_1 = texture (sColor0, min (max (vUv_Y.xy, vUvBounds_Y.xy), vUvBounds_Y.zw)).yzx;
      break;
    };
    tmpvar_2 = bool(1);
    yuv_value_1 = vec3(0.0, 0.0, 0.0);
    break;
  };
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (vYuvColorMatrix * ((yuv_value_1 * vCoefficient) - vec3(0.06275, 0.50196, 0.50196)));
  oFragColor = tmpvar_3;
}

