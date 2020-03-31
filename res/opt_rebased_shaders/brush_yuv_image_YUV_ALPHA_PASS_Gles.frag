#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
flat in highp vec4 vTransformBounds;
uniform highp sampler2DArray sPrevPassAlpha;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
in highp vec2 vLocalPos;
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
  vec4 frag_color_1;
  highp vec4 color_2;
  highp vec3 yuv_value_3;
  bool tmpvar_4;
  tmpvar_4 = bool(0);
  while (true) {
    tmpvar_4 = (tmpvar_4 || (1 == vFormat));
    if (tmpvar_4) {
      vec3 tmpvar_5;
      tmpvar_5.xy = min (max (vUv_Y.xy, vUvBounds_Y.xy), vUvBounds_Y.zw);
      tmpvar_5.z = vUv_Y.z;
      yuv_value_3.x = texture (sColor0, tmpvar_5).x;
      vec3 tmpvar_6;
      tmpvar_6.xy = min (max (vUv_U.xy, vUvBounds_U.xy), vUvBounds_U.zw);
      tmpvar_6.z = vUv_U.z;
      yuv_value_3.y = texture (sColor1, tmpvar_6).x;
      vec3 tmpvar_7;
      tmpvar_7.xy = min (max (vUv_V.xy, vUvBounds_V.xy), vUvBounds_V.zw);
      tmpvar_7.z = vUv_V.z;
      yuv_value_3.z = texture (sColor2, tmpvar_7).x;
      break;
    };
    tmpvar_4 = (tmpvar_4 || (0 == vFormat));
    if (tmpvar_4) {
      vec3 tmpvar_8;
      tmpvar_8.xy = min (max (vUv_Y.xy, vUvBounds_Y.xy), vUvBounds_Y.zw);
      tmpvar_8.z = vUv_Y.z;
      yuv_value_3.x = texture (sColor0, tmpvar_8).x;
      vec3 tmpvar_9;
      tmpvar_9.xy = min (max (vUv_U.xy, vUvBounds_U.xy), vUvBounds_U.zw);
      tmpvar_9.z = vUv_U.z;
      yuv_value_3.yz = texture (sColor1, tmpvar_9).xy;
      break;
    };
    tmpvar_4 = (tmpvar_4 || (2 == vFormat));
    if (tmpvar_4) {
      vec3 tmpvar_10;
      tmpvar_10.xy = min (max (vUv_Y.xy, vUvBounds_Y.xy), vUvBounds_Y.zw);
      tmpvar_10.z = vUv_Y.z;
      yuv_value_3 = texture (sColor0, tmpvar_10).yzx;
      break;
    };
    tmpvar_4 = bool(1);
    yuv_value_3 = vec3(0.0, 0.0, 0.0);
    break;
  };
  vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = (vYuvColorMatrix * ((yuv_value_3 * vCoefficient) - vec3(0.06275, 0.50196, 0.50196)));
  color_2 = tmpvar_11;
  vec2 tmpvar_12;
  tmpvar_12 = max ((vTransformBounds.xy - vLocalPos), (vLocalPos - vTransformBounds.zw));
  vec2 tmpvar_13;
  tmpvar_13 = max (vec2(0.0, 0.0), tmpvar_12);
  vec2 tmpvar_14;
  tmpvar_14 = (abs(dFdx(vLocalPos)) + abs(dFdy(vLocalPos)));
  float tmpvar_15;
  float tmpvar_16;
  tmpvar_16 = ((0.5 * (
    sqrt(dot (tmpvar_13, tmpvar_13))
   + 
    min (0.0, max (tmpvar_12.x, tmpvar_12.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_14, tmpvar_14)
  )));
  if ((-0.4999 >= tmpvar_16)) {
    tmpvar_15 = 1.0;
  } else {
    if ((tmpvar_16 >= 0.4999)) {
      tmpvar_15 = 0.0;
    } else {
      tmpvar_15 = (0.5 + (tmpvar_16 * (
        ((0.8431027 * tmpvar_16) * tmpvar_16)
       - 1.144536)));
    };
  };
  color_2 = (tmpvar_11 * tmpvar_15);
  frag_color_1 = color_2;
  float tmpvar_17;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_17 = 1.0;
  } else {
    vec2 tmpvar_18;
    tmpvar_18 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec4 tmpvar_19;
    tmpvar_19.xy = greaterThanEqual (tmpvar_18, vClipMaskUvBounds.xy);
    tmpvar_19.zw = lessThan (tmpvar_18, vClipMaskUvBounds.zw);
    bool tmpvar_20;
    tmpvar_20 = (tmpvar_19 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_20)) {
      tmpvar_17 = 0.0;
    } else {
      ivec3 tmpvar_21;
      tmpvar_21.xy = ivec2(tmpvar_18);
      tmpvar_21.z = int((vClipMaskUv.z + 0.5));
      tmpvar_17 = texelFetch (sPrevPassAlpha, tmpvar_21, 0).x;
    };
  };
  frag_color_1 = (color_2 * tmpvar_17);
  oFragColor = frag_color_1;
}

