#version 150
precision highp float;
out vec4 oFragColor;
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sColor2;
flat in vec4 vTransformBounds;
uniform sampler2DArray sPrevPassAlpha;
flat in vec4 vClipMaskUvBounds;
in vec4 vClipMaskUv;
in vec2 vLocalPos;
in vec3 vUv_Y;
flat in vec4 vUvBounds_Y;
in vec3 vUv_U;
flat in vec4 vUvBounds_U;
in vec3 vUv_V;
flat in vec4 vUvBounds_V;
flat in float vCoefficient;
flat in mat3 vYuvColorMatrix;
flat in int vFormat;
void main ()
{
  vec4 frag_color_1;
  vec4 color_2;
  vec3 yuv_value_3;
  bool tmpvar_4;
  tmpvar_4 = bool(0);
  while (true) {
    tmpvar_4 = (tmpvar_4 || (1 == vFormat));
    if (tmpvar_4) {
      yuv_value_3.x = texture (sColor0, min (max (vUv_Y.xy, vUvBounds_Y.xy), vUvBounds_Y.zw)).x;
      yuv_value_3.y = texture (sColor1, min (max (vUv_U.xy, vUvBounds_U.xy), vUvBounds_U.zw)).x;
      yuv_value_3.z = texture (sColor2, min (max (vUv_V.xy, vUvBounds_V.xy), vUvBounds_V.zw)).x;
      break;
    };
    tmpvar_4 = (tmpvar_4 || (0 == vFormat));
    if (tmpvar_4) {
      yuv_value_3.x = texture (sColor0, min (max (vUv_Y.xy, vUvBounds_Y.xy), vUvBounds_Y.zw)).x;
      yuv_value_3.yz = texture (sColor1, min (max (vUv_U.xy, vUvBounds_U.xy), vUvBounds_U.zw)).xy;
      break;
    };
    tmpvar_4 = (tmpvar_4 || (2 == vFormat));
    if (tmpvar_4) {
      yuv_value_3 = texture (sColor0, min (max (vUv_Y.xy, vUvBounds_Y.xy), vUvBounds_Y.zw)).yzx;
      break;
    };
    tmpvar_4 = bool(1);
    yuv_value_3 = vec3(0.0, 0.0, 0.0);
    break;
  };
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = (vYuvColorMatrix * ((yuv_value_3 * vCoefficient) - vec3(0.06275, 0.50196, 0.50196)));
  color_2 = tmpvar_5;
  vec2 tmpvar_6;
  tmpvar_6 = max ((vTransformBounds.xy - vLocalPos), (vLocalPos - vTransformBounds.zw));
  vec2 tmpvar_7;
  tmpvar_7 = max (vec2(0.0, 0.0), tmpvar_6);
  vec2 tmpvar_8;
  tmpvar_8 = (abs(dFdx(vLocalPos)) + abs(dFdy(vLocalPos)));
  float tmpvar_9;
  float tmpvar_10;
  tmpvar_10 = ((0.5 * (
    sqrt(dot (tmpvar_7, tmpvar_7))
   + 
    min (0.0, max (tmpvar_6.x, tmpvar_6.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_8, tmpvar_8)
  )));
  if ((-0.4999 >= tmpvar_10)) {
    tmpvar_9 = 1.0;
  } else {
    if ((tmpvar_10 >= 0.4999)) {
      tmpvar_9 = 0.0;
    } else {
      tmpvar_9 = (0.5 + (tmpvar_10 * (
        ((0.8431027 * tmpvar_10) * tmpvar_10)
       - 1.144536)));
    };
  };
  color_2 = (tmpvar_5 * tmpvar_9);
  frag_color_1 = color_2;
  float tmpvar_11;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_11 = 1.0;
  } else {
    vec2 tmpvar_12;
    tmpvar_12 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec4 tmpvar_13;
    tmpvar_13.xy = greaterThanEqual (tmpvar_12, vClipMaskUvBounds.xy);
    tmpvar_13.zw = lessThan (tmpvar_12, vClipMaskUvBounds.zw);
    bool tmpvar_14;
    tmpvar_14 = (tmpvar_13 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_14)) {
      tmpvar_11 = 0.0;
    } else {
      ivec3 tmpvar_15;
      tmpvar_15.xy = ivec2(tmpvar_12);
      tmpvar_15.z = int((vClipMaskUv.z + 0.5));
      tmpvar_11 = texelFetch (sPrevPassAlpha, tmpvar_15, 0).x;
    };
  };
  frag_color_1 = (color_2 * tmpvar_11);
  oFragColor = frag_color_1;
}

