#version 300 es
precision highp float;
precision highp sampler2DArray;
out lowp vec4 oFragColor;
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sColor2;
in vec3 vUv_Y;
flat in vec4 vUvBounds_Y;
in vec3 vUv_U;
flat in vec4 vUvBounds_U;
in vec3 vUv_V;
flat in vec4 vUvBounds_V;
flat in float vCoefficient;
flat in mat3 vYuvColorMatrix;
flat in highp int vFormat;
void main ()
{
  lowp vec3 yuv_value_1;
  bool tmpvar_2;
  tmpvar_2 = bool(0);
  bool tmpvar_3;
  tmpvar_3 = bool(0);
  if ((1 == vFormat)) tmpvar_2 = bool(1);
  if (tmpvar_3) tmpvar_2 = bool(0);
  if (tmpvar_2) {
    vec3 tmpvar_4;
    tmpvar_4.xy = clamp (vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
    tmpvar_4.z = vUv_Y.z;
    yuv_value_1.x = texture (sColor0, tmpvar_4.xy).x;
    vec3 tmpvar_5;
    tmpvar_5.xy = clamp (vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw);
    tmpvar_5.z = vUv_U.z;
    yuv_value_1.y = texture (sColor1, tmpvar_5.xy).x;
    vec3 tmpvar_6;
    tmpvar_6.xy = clamp (vUv_V.xy, vUvBounds_V.xy, vUvBounds_V.zw);
    tmpvar_6.z = vUv_V.z;
    yuv_value_1.z = texture (sColor2, tmpvar_6.xy).x;
    tmpvar_3 = bool(1);
  };
  if ((0 == vFormat)) tmpvar_2 = bool(1);
  if (tmpvar_3) tmpvar_2 = bool(0);
  if (tmpvar_2) {
    vec3 tmpvar_7;
    tmpvar_7.xy = clamp (vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
    tmpvar_7.z = vUv_Y.z;
    yuv_value_1.x = texture (sColor0, tmpvar_7.xy).x;
    vec3 tmpvar_8;
    tmpvar_8.xy = clamp (vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw);
    tmpvar_8.z = vUv_U.z;
    yuv_value_1.yz = texture (sColor1, tmpvar_8.xy).xy;
    tmpvar_3 = bool(1);
  };
  if ((2 == vFormat)) tmpvar_2 = bool(1);
  if (tmpvar_3) tmpvar_2 = bool(0);
  if (tmpvar_2) {
    vec3 tmpvar_9;
    tmpvar_9.xy = clamp (vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
    tmpvar_9.z = vUv_Y.z;
    yuv_value_1 = texture (sColor0, tmpvar_9.xy).yzx;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = bool(1);
  if (tmpvar_3) tmpvar_2 = bool(0);
  if (tmpvar_2) {
    yuv_value_1 = vec3(0.0, 0.0, 0.0);
    tmpvar_3 = bool(1);
  };
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (vYuvColorMatrix * ((yuv_value_1 * vCoefficient) - vec3(0.06275, 0.50196, 0.50196)));
  oFragColor = tmpvar_10;
}

