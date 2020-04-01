#version 150
precision highp float;
out vec4 oFragColor;
uniform sampler2DArray sColor0;
flat in vec4 vTransformBounds;
uniform sampler2DArray sPrevPassAlpha;
flat in vec4 vClipMaskUvBounds;
in vec4 vClipMaskUv;
flat in vec4 flat_varying_vec4_1;
flat in vec4 flat_varying_vec4_2;
in vec4 varying_vec4_0;
void main ()
{
  vec4 tmpvar_1;
  float alpha_2;
  vec2 tmpvar_3;
  tmpvar_3 = (varying_vec4_0.zw * mix (gl_FragCoord.w, 1.0, flat_varying_vec4_2.y));
  vec3 tmpvar_4;
  tmpvar_4.xy = tmpvar_3;
  tmpvar_4.z = flat_varying_vec4_2.x;
  vec4 tmpvar_5;
  tmpvar_5 = texture (sColor0, tmpvar_4);
  alpha_2 = tmpvar_5.w;
  vec3 tmpvar_6;
  if ((tmpvar_5.w != 0.0)) {
    tmpvar_6 = (tmpvar_5.xyz / tmpvar_5.w);
  } else {
    tmpvar_6 = tmpvar_5.xyz;
  };
  alpha_2 = (tmpvar_5.w * flat_varying_vec4_2.z);
  float tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_8.x = float((tmpvar_3.x >= flat_varying_vec4_1.z));
  tmpvar_8.y = float((tmpvar_3.y >= flat_varying_vec4_1.w));
  vec2 tmpvar_9;
  tmpvar_9 = (vec2(greaterThanEqual (tmpvar_3, flat_varying_vec4_1.xy)) - tmpvar_8);
  tmpvar_7 = (tmpvar_9.x * tmpvar_9.y);
  vec2 tmpvar_10;
  tmpvar_10 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_11;
  tmpvar_11 = max (vec2(0.0, 0.0), tmpvar_10);
  vec2 tmpvar_12;
  tmpvar_12 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_13;
  float tmpvar_14;
  tmpvar_14 = ((0.5 * (
    sqrt(dot (tmpvar_11, tmpvar_11))
   + 
    min (0.0, max (tmpvar_10.x, tmpvar_10.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_12, tmpvar_12)
  )));
  if ((tmpvar_14 <= -0.4999)) {
    tmpvar_13 = 1.0;
  } else {
    if ((tmpvar_14 >= 0.4999)) {
      tmpvar_13 = 0.0;
    } else {
      tmpvar_13 = (0.5 + (tmpvar_14 * (
        ((0.8431027 * tmpvar_14) * tmpvar_14)
       - 1.144536)));
    };
  };
  alpha_2 = (alpha_2 * min (tmpvar_7, tmpvar_13));
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_6;
  tmpvar_1 = (alpha_2 * tmpvar_15);
  float tmpvar_16;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_16 = 1.0;
  } else {
    vec2 tmpvar_17;
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
      ivec3 tmpvar_21;
      tmpvar_21.xy = ivec2(tmpvar_17);
      tmpvar_21.z = int((vClipMaskUv.z + 0.5));
      tmpvar_16 = texelFetch (sPrevPassAlpha, tmpvar_21, 0).x;
    };
  };
  tmpvar_1 = (tmpvar_1 * tmpvar_16);
  oFragColor = tmpvar_1;
}

