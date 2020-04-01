#version 150
precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sColor2;
flat in mat3 vYuvColorMatrix;
flat in float vYuvCoefficient;
flat in int vYuvFormat;
in vec3 vUV_y;
in vec3 vUV_u;
in vec3 vUV_v;
flat in vec4 vUVBounds_y;
flat in vec4 vUVBounds_u;
flat in vec4 vUVBounds_v;
void main ()
{
  vec3 yuv_value_1;
  bool tmpvar_2;
  tmpvar_2 = bool(0);
  bool tmpvar_3;
  tmpvar_3 = bool(0);
  if ((1 == vYuvFormat)) tmpvar_2 = bool(1);
  if (tmpvar_3) tmpvar_2 = bool(0);
  if (tmpvar_2) {
    vec3 tmpvar_4;
    tmpvar_4.xy = clamp (vUV_y.xy, vUVBounds_y.xy, vUVBounds_y.zw);
    tmpvar_4.z = vUV_y.z;
    yuv_value_1.x = texture (sColor0, tmpvar_4.xy).x;
    vec3 tmpvar_5;
    tmpvar_5.xy = clamp (vUV_u.xy, vUVBounds_u.xy, vUVBounds_u.zw);
    tmpvar_5.z = vUV_u.z;
    yuv_value_1.y = texture (sColor1, tmpvar_5.xy).x;
    vec3 tmpvar_6;
    tmpvar_6.xy = clamp (vUV_v.xy, vUVBounds_v.xy, vUVBounds_v.zw);
    tmpvar_6.z = vUV_v.z;
    yuv_value_1.z = texture (sColor2, tmpvar_6.xy).x;
    tmpvar_3 = bool(1);
  };
  if ((0 == vYuvFormat)) tmpvar_2 = bool(1);
  if (tmpvar_3) tmpvar_2 = bool(0);
  if (tmpvar_2) {
    vec3 tmpvar_7;
    tmpvar_7.xy = clamp (vUV_y.xy, vUVBounds_y.xy, vUVBounds_y.zw);
    tmpvar_7.z = vUV_y.z;
    yuv_value_1.x = texture (sColor0, tmpvar_7.xy).x;
    vec3 tmpvar_8;
    tmpvar_8.xy = clamp (vUV_u.xy, vUVBounds_u.xy, vUVBounds_u.zw);
    tmpvar_8.z = vUV_u.z;
    yuv_value_1.yz = texture (sColor1, tmpvar_8.xy).xy;
    tmpvar_3 = bool(1);
  };
  if ((2 == vYuvFormat)) tmpvar_2 = bool(1);
  if (tmpvar_3) tmpvar_2 = bool(0);
  if (tmpvar_2) {
    vec3 tmpvar_9;
    tmpvar_9.xy = clamp (vUV_y.xy, vUVBounds_y.xy, vUVBounds_y.zw);
    tmpvar_9.z = vUV_y.z;
    yuv_value_1 = texture (sColor0, tmpvar_9.xy).yzx;
    tmpvar_3 = bool(1);
  };
  tmpvar_2 = bool(1);
  if (tmpvar_3) tmpvar_2 = bool(0);
  if (tmpvar_2) {
    yuv_value_1 = vec3(0.0, 0.0, 0.0);
    tmpvar_3 = bool(1);
  };
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (vYuvColorMatrix * ((yuv_value_1 * vYuvCoefficient) - vec3(0.06275, 0.50196, 0.50196)));
  oFragColor = tmpvar_10;
}

