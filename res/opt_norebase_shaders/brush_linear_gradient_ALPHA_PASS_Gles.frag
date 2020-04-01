#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform highp sampler2D sGpuCache;
flat in vec4 vTransformBounds;
uniform sampler2DArray sPrevPassAlpha;
flat in vec4 vClipMaskUvBounds;
in vec4 vClipMaskUv;
flat in vec4 flat_varying_vec4_0;
flat in vec4 flat_varying_vec4_1;
flat in vec4 flat_varying_vec4_2;
in vec4 varying_vec4_0;
flat in highp int flat_varying_highp_int_address_0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 color_2;
  vec2 pos_3;
  vec2 tmpvar_4;
  tmpvar_4 = max (varying_vec4_0.zw, vec2(0.0, 0.0));
  pos_3 = (vec2(mod (tmpvar_4, flat_varying_vec4_1.xy)));
  vec2 tmpvar_5;
  tmpvar_5 = (flat_varying_vec4_1.xy * flat_varying_vec4_2.xy);
  if ((tmpvar_4.x >= tmpvar_5.x)) {
    pos_3.x = flat_varying_vec4_1.x;
  };
  if ((tmpvar_4.y >= tmpvar_5.y)) {
    pos_3.y = flat_varying_vec4_1.y;
  };
  float tmpvar_6;
  tmpvar_6 = dot ((pos_3 - flat_varying_vec4_0.xy), flat_varying_vec4_0.zw);
  float x_7;
  x_7 = (1.0 + (mix (tmpvar_6, 
    fract(tmpvar_6)
  , flat_varying_vec4_1.z) * 128.0));
  highp int address_8;
  address_8 = (flat_varying_highp_int_address_0 + clamp ((2 * 
    int(floor(x_7))
  ), 0, 258));
  highp ivec2 tmpvar_9;
  tmpvar_9.x = int((uint(address_8) % 1024u));
  tmpvar_9.y = int((uint(address_8) / 1024u));
  color_2 = mix (texelFetch (sGpuCache, tmpvar_9, 0), texelFetch (sGpuCache, (tmpvar_9 + ivec2(1, 0)), 0), fract(x_7));
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
  color_2 = (color_2 * tmpvar_13);
  tmpvar_1 = color_2;
  highp float tmpvar_15;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_15 = 1.0;
  } else {
    highp vec2 tmpvar_16;
    tmpvar_16 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_17;
    tmpvar_17 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_16);
    bvec2 tmpvar_18;
    tmpvar_18 = greaterThan (vClipMaskUvBounds.zw, tmpvar_16);
    bool tmpvar_19;
    tmpvar_19 = ((tmpvar_17.x && tmpvar_17.y) && (tmpvar_18.x && tmpvar_18.y));
    if (!(tmpvar_19)) {
      tmpvar_15 = 0.0;
    } else {
      highp ivec3 tmpvar_20;
      tmpvar_20.xy = ivec2(tmpvar_16);
      tmpvar_20.z = int((vClipMaskUv.z + 0.5));
      highp vec4 tmpvar_21;
      tmpvar_21 = texelFetch (sPrevPassAlpha, tmpvar_20, 0);
      tmpvar_15 = tmpvar_21.x;
    };
  };
  tmpvar_1 = (color_2 * tmpvar_15);
  oFragColor = tmpvar_1;
}

