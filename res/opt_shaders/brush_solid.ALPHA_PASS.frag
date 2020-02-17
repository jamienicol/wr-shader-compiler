#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
flat in vec4 vTransformBounds;
uniform sampler2DArray sPrevPassAlpha;
flat in vec4 vClipMaskUvBounds;
in vec4 vClipMaskUv;
flat in vec4 flat_varying_vec4_0;
in vec4 varying_vec4_0;
void main ()
{
  highp vec4 tmpvar_1;
  vec4 color_2;
  color_2 = flat_varying_vec4_0;
  vec2 tmpvar_3;
  tmpvar_3 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_4;
  tmpvar_4 = max (vec2(0.0, 0.0), tmpvar_3);
  vec2 tmpvar_5;
  tmpvar_5 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_6;
  float tmpvar_7;
  tmpvar_7 = ((0.5 * (
    sqrt(dot (tmpvar_4, tmpvar_4))
   + 
    min (0.0, max (tmpvar_3.x, tmpvar_3.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_5, tmpvar_5)
  )));
  if ((tmpvar_7 <= -0.4999)) {
    tmpvar_6 = 1.0;
  } else {
    if ((tmpvar_7 >= 0.4999)) {
      tmpvar_6 = 0.0;
    } else {
      tmpvar_6 = (0.5 + (tmpvar_7 * (
        ((0.8431027 * tmpvar_7) * tmpvar_7)
       - 1.144536)));
    };
  };
  color_2 = (flat_varying_vec4_0 * tmpvar_6);
  tmpvar_1 = color_2;
  highp float tmpvar_8;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_8 = 1.0;
  } else {
    highp vec2 tmpvar_9;
    tmpvar_9 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_10;
    tmpvar_10 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_9);
    bvec2 tmpvar_11;
    tmpvar_11 = greaterThan (vClipMaskUvBounds.zw, tmpvar_9);
    bool tmpvar_12;
    tmpvar_12 = ((tmpvar_10.x && tmpvar_10.y) && (tmpvar_11.x && tmpvar_11.y));
    if (!(tmpvar_12)) {
      tmpvar_8 = 0.0;
    } else {
      highp ivec3 tmpvar_13;
      tmpvar_13.xy = ivec2(tmpvar_9);
      tmpvar_13.z = int((vClipMaskUv.z + 0.5));
      highp vec4 tmpvar_14;
      tmpvar_14 = texelFetch (sPrevPassAlpha, tmpvar_13, 0);
      tmpvar_8 = tmpvar_14.x;
    };
  };
  tmpvar_1 = (color_2 * tmpvar_8);
  oFragColor = tmpvar_1;
}

