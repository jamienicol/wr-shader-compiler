#version 300 es
#extension GL_OES_EGL_image_external_essl3 : enable
precision highp float;
precision highp sampler2DArray;
out lowp vec4 oFragColor;
uniform lowp samplerExternalOES sColor0;
uniform lowp samplerExternalOES sColor1;
uniform lowp samplerExternalOES sColor2;
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
  bool tmpvar_4;
  tmpvar_4 = bool(0);
  bool tmpvar_5;
  tmpvar_5 = bool(0);
  if ((1 == vFormat)) tmpvar_4 = bool(1);
  if (tmpvar_5) tmpvar_4 = bool(0);
  if (tmpvar_4) {
    vec3 tmpvar_6;
    tmpvar_6.xy = clamp (vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
    tmpvar_6.z = vUv_Y.z;
    yuv_value_3.x = texture (sColor0, tmpvar_6.xy).x;
    vec3 tmpvar_7;
    tmpvar_7.xy = clamp (vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw);
    tmpvar_7.z = vUv_U.z;
    yuv_value_3.y = texture (sColor1, tmpvar_7.xy).x;
    vec3 tmpvar_8;
    tmpvar_8.xy = clamp (vUv_V.xy, vUvBounds_V.xy, vUvBounds_V.zw);
    tmpvar_8.z = vUv_V.z;
    yuv_value_3.z = texture (sColor2, tmpvar_8.xy).x;
    tmpvar_5 = bool(1);
  };
  if ((0 == vFormat)) tmpvar_4 = bool(1);
  if (tmpvar_5) tmpvar_4 = bool(0);
  if (tmpvar_4) {
    vec3 tmpvar_9;
    tmpvar_9.xy = clamp (vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
    tmpvar_9.z = vUv_Y.z;
    yuv_value_3.x = texture (sColor0, tmpvar_9.xy).x;
    vec3 tmpvar_10;
    tmpvar_10.xy = clamp (vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw);
    tmpvar_10.z = vUv_U.z;
    yuv_value_3.yz = texture (sColor1, tmpvar_10.xy).xy;
    tmpvar_5 = bool(1);
  };
  if ((2 == vFormat)) tmpvar_4 = bool(1);
  if (tmpvar_5) tmpvar_4 = bool(0);
  if (tmpvar_4) {
    vec3 tmpvar_11;
    tmpvar_11.xy = clamp (vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
    tmpvar_11.z = vUv_Y.z;
    yuv_value_3 = texture (sColor0, tmpvar_11.xy).yzx;
    tmpvar_5 = bool(1);
  };
  tmpvar_4 = bool(1);
  if (tmpvar_5) tmpvar_4 = bool(0);
  if (tmpvar_4) {
    yuv_value_3 = vec3(0.0, 0.0, 0.0);
    tmpvar_5 = bool(1);
  };
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (vYuvColorMatrix * ((yuv_value_3 * vCoefficient) - vec3(0.06275, 0.50196, 0.50196)));
  color_2 = tmpvar_12;
  vec2 tmpvar_13;
  tmpvar_13 = max ((vTransformBounds.xy - vLocalPos), (vLocalPos - vTransformBounds.zw));
  vec2 tmpvar_14;
  tmpvar_14 = max (vec2(0.0, 0.0), tmpvar_13);
  vec2 tmpvar_15;
  tmpvar_15 = (abs(dFdx(vLocalPos)) + abs(dFdy(vLocalPos)));
  float tmpvar_16;
  float tmpvar_17;
  tmpvar_17 = ((0.5 * (
    sqrt(dot (tmpvar_14, tmpvar_14))
   + 
    min (0.0, max (tmpvar_13.x, tmpvar_13.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_15, tmpvar_15)
  )));
  if ((tmpvar_17 <= -0.4999)) {
    tmpvar_16 = 1.0;
  } else {
    if ((tmpvar_17 >= 0.4999)) {
      tmpvar_16 = 0.0;
    } else {
      tmpvar_16 = (0.5 + (tmpvar_17 * (
        ((0.8431027 * tmpvar_17) * tmpvar_17)
       - 1.144536)));
    };
  };
  color_2 = (tmpvar_12 * tmpvar_16);
  tmpvar_1 = color_2;
  highp float tmpvar_18;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_18 = 1.0;
  } else {
    highp vec2 tmpvar_19;
    tmpvar_19 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_20;
    tmpvar_20 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_19);
    bvec2 tmpvar_21;
    tmpvar_21 = greaterThan (vClipMaskUvBounds.zw, tmpvar_19);
    bool tmpvar_22;
    tmpvar_22 = ((tmpvar_20.x && tmpvar_20.y) && (tmpvar_21.x && tmpvar_21.y));
    if (!(tmpvar_22)) {
      tmpvar_18 = 0.0;
    } else {
      highp ivec3 tmpvar_23;
      tmpvar_23.xy = ivec2(tmpvar_19);
      tmpvar_23.z = int((vClipMaskUv.z + 0.5));
      highp vec4 tmpvar_24;
      tmpvar_24 = texelFetch (sPrevPassAlpha, tmpvar_23, 0);
      tmpvar_18 = tmpvar_24.x;
    };
  };
  tmpvar_1 = (color_2 * tmpvar_18);
  oFragColor = tmpvar_1;
}

