#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
uniform lowp sampler2D sColor1;
uniform lowp sampler2D sColor2;
flat in highp mat3 vYuvColorMatrix;
flat in highp float vYuvCoefficient;
flat in mediump int vYuvFormat;
in highp vec3 vUV_y;
in highp vec3 vUV_u;
in highp vec3 vUV_v;
flat in highp vec4 vUVBounds_y;
flat in highp vec4 vUVBounds_u;
flat in highp vec4 vUVBounds_v;
void main ()
{
  highp vec3 yuv_value_1;
  bool tmpvar_2;
  tmpvar_2 = bool(0);
  while (true) {
    tmpvar_2 = (tmpvar_2 || (1 == vYuvFormat));
    if (tmpvar_2) {
      yuv_value_1.x = texture (sColor0, min (max (vUV_y.xy, vUVBounds_y.xy), vUVBounds_y.zw)).x;
      yuv_value_1.y = texture (sColor1, min (max (vUV_u.xy, vUVBounds_u.xy), vUVBounds_u.zw)).x;
      yuv_value_1.z = texture (sColor2, min (max (vUV_v.xy, vUVBounds_v.xy), vUVBounds_v.zw)).x;
      break;
    };
    tmpvar_2 = (tmpvar_2 || (0 == vYuvFormat));
    if (tmpvar_2) {
      yuv_value_1.x = texture (sColor0, min (max (vUV_y.xy, vUVBounds_y.xy), vUVBounds_y.zw)).x;
      yuv_value_1.yz = texture (sColor1, min (max (vUV_u.xy, vUVBounds_u.xy), vUVBounds_u.zw)).xy;
      break;
    };
    tmpvar_2 = (tmpvar_2 || (2 == vYuvFormat));
    if (tmpvar_2) {
      yuv_value_1 = texture (sColor0, min (max (vUV_y.xy, vUVBounds_y.xy), vUVBounds_y.zw)).yzx;
      break;
    };
    tmpvar_2 = bool(1);
    yuv_value_1 = vec3(0.0, 0.0, 0.0);
    break;
  };
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (vYuvColorMatrix * ((yuv_value_1 * vYuvCoefficient) - vec3(0.06275, 0.50196, 0.50196)));
  oFragColor = tmpvar_3;
}

