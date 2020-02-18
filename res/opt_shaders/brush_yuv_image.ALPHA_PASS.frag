#version 310 es
precision highp float;
precision highp sampler2DArray;
out lowp vec4 oFragColor;
uniform sampler2DArray sColor0;
uniform sampler2DArray sColor1;
uniform sampler2DArray sColor2;
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
flat in highp int vFormat;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  lowp vec3 yuv_value_3;
  if ((vFormat == 1)) {
    vec3 tmpvar_4;
    tmpvar_4.xy = clamp (vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
    tmpvar_4.z = vUv_Y.z;
    yuv_value_3.x = texture (sColor0, tmpvar_4).x;
    vec3 tmpvar_5;
    tmpvar_5.xy = clamp (vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw);
    tmpvar_5.z = vUv_U.z;
    yuv_value_3.y = texture (sColor1, tmpvar_5).x;
    vec3 tmpvar_6;
    tmpvar_6.xy = clamp (vUv_V.xy, vUvBounds_V.xy, vUvBounds_V.zw);
    tmpvar_6.z = vUv_V.z;
    yuv_value_3.z = texture (sColor2, tmpvar_6).x;
  } else {
    if ((vFormat == 0)) {
      vec3 tmpvar_7;
      tmpvar_7.xy = clamp (vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
      tmpvar_7.z = vUv_Y.z;
      yuv_value_3.x = texture (sColor0, tmpvar_7).x;
      vec3 tmpvar_8;
      tmpvar_8.xy = clamp (vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw);
      tmpvar_8.z = vUv_U.z;
      yuv_value_3.yz = texture (sColor1, tmpvar_8).xy;
    } else {
      if ((vFormat == 2)) {
        vec3 tmpvar_9;
        tmpvar_9.xy = clamp (vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
        tmpvar_9.z = vUv_Y.z;
        yuv_value_3 = texture (sColor0, tmpvar_9).yzx;
      } else {
        yuv_value_3 = vec3(0.0, 0.0, 0.0);
      };
    };
  };
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (vYuvColorMatrix * ((yuv_value_3 * vCoefficient) - vec3(0.06275, 0.50196, 0.50196)));
  color_2 = tmpvar_10;
  vec2 tmpvar_11;
  tmpvar_11 = max ((vTransformBounds.xy - vLocalPos), (vLocalPos - vTransformBounds.zw));
  vec2 tmpvar_12;
  tmpvar_12 = max (vec2(0.0, 0.0), tmpvar_11);
  vec2 tmpvar_13;
  tmpvar_13 = (abs(dFdx(vLocalPos)) + abs(dFdy(vLocalPos)));
  float tmpvar_14;
  float tmpvar_15;
  tmpvar_15 = ((0.5 * (
    sqrt(dot (tmpvar_12, tmpvar_12))
   + 
    min (0.0, max (tmpvar_11.x, tmpvar_11.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_13, tmpvar_13)
  )));
  if ((tmpvar_15 <= -0.4999)) {
    tmpvar_14 = 1.0;
  } else {
    if ((tmpvar_15 >= 0.4999)) {
      tmpvar_14 = 0.0;
    } else {
      tmpvar_14 = (0.5 + (tmpvar_15 * (
        ((0.8431027 * tmpvar_15) * tmpvar_15)
       - 1.144536)));
    };
  };
  color_2 = (tmpvar_10 * tmpvar_14);
  tmpvar_1 = color_2;
  highp float tmpvar_16;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_16 = 1.0;
  } else {
    highp vec2 tmpvar_17;
    tmpvar_17 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_18;
    tmpvar_18 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_17);
    bvec2 tmpvar_19;
    tmpvar_19 = greaterThan (vClipMaskUvBounds.zw, tmpvar_17);
    bool tmpvar_20;
    tmpvar_20 = ((tmpvar_18.x && tmpvar_18.y) && (tmpvar_19.x && tmpvar_19.y));
    if (!(tmpvar_20)) {
      tmpvar_16 = 0.0;
    } else {
      highp ivec3 tmpvar_21;
      tmpvar_21.xy = ivec2(tmpvar_17);
      tmpvar_21.z = int((vClipMaskUv.z + 0.5));
      highp vec4 tmpvar_22;
      tmpvar_22 = texelFetch (sPrevPassAlpha, tmpvar_21, 0);
      tmpvar_16 = tmpvar_22.x;
    };
  };
  tmpvar_1 = (color_2 * tmpvar_16);
  oFragColor = tmpvar_1;
}

