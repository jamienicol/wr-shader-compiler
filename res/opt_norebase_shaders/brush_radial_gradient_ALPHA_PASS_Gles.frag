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
  float offset_3;
  vec2 pos_4;
  vec2 tmpvar_5;
  tmpvar_5 = max (varying_vec4_0.zw, vec2(0.0, 0.0));
  pos_4 = (vec2(mod (tmpvar_5, flat_varying_vec4_1.xy)));
  vec2 tmpvar_6;
  tmpvar_6 = (flat_varying_vec4_1.xy * flat_varying_vec4_2.xy);
  if ((tmpvar_5.x >= tmpvar_6.x)) {
    pos_4.x = flat_varying_vec4_1.x;
  };
  if ((tmpvar_5.y >= tmpvar_6.y)) {
    pos_4.y = flat_varying_vec4_1.y;
  };
  vec2 tmpvar_7;
  tmpvar_7 = (pos_4 - flat_varying_vec4_0.xy);
  float tmpvar_8;
  tmpvar_8 = (flat_varying_vec4_0.w - flat_varying_vec4_0.z);
  float tmpvar_9;
  tmpvar_9 = -((tmpvar_8 * tmpvar_8));
  float tmpvar_10;
  tmpvar_10 = (flat_varying_vec4_0.z * tmpvar_8);
  float tmpvar_11;
  tmpvar_11 = (dot (tmpvar_7, tmpvar_7) - (flat_varying_vec4_0.z * flat_varying_vec4_0.z));
  if ((tmpvar_9 == 0.0)) {
    if ((tmpvar_10 == 0.0)) {
      discard;
    };
    float tmpvar_12;
    tmpvar_12 = ((0.5 * tmpvar_11) / tmpvar_10);
    if ((flat_varying_vec4_0.z >= -((tmpvar_8 * tmpvar_12)))) {
      offset_3 = tmpvar_12;
    } else {
      discard;
    };
  } else {
    float tmpvar_13;
    tmpvar_13 = ((tmpvar_10 * tmpvar_10) - (tmpvar_9 * tmpvar_11));
    if ((tmpvar_13 < 0.0)) {
      discard;
    };
    float tmpvar_14;
    tmpvar_14 = sqrt(tmpvar_13);
    float tmpvar_15;
    tmpvar_15 = ((tmpvar_10 + tmpvar_14) / tmpvar_9);
    float tmpvar_16;
    tmpvar_16 = ((tmpvar_10 - tmpvar_14) / tmpvar_9);
    if ((flat_varying_vec4_0.z >= -((tmpvar_8 * tmpvar_15)))) {
      offset_3 = tmpvar_15;
    } else {
      if ((flat_varying_vec4_0.z >= -((tmpvar_8 * tmpvar_16)))) {
        offset_3 = tmpvar_16;
      } else {
        discard;
      };
    };
  };
  float x_17;
  x_17 = (1.0 + (mix (offset_3, 
    fract(offset_3)
  , flat_varying_vec4_1.z) * 128.0));
  highp int address_18;
  address_18 = (flat_varying_highp_int_address_0 + clamp ((2 * 
    int(floor(x_17))
  ), 0, 258));
  highp ivec2 tmpvar_19;
  tmpvar_19.x = int((uint(address_18) % 1024u));
  tmpvar_19.y = int((uint(address_18) / 1024u));
  color_2 = mix (texelFetch (sGpuCache, tmpvar_19, 0), texelFetch (sGpuCache, (tmpvar_19 + ivec2(1, 0)), 0), fract(x_17));
  vec2 tmpvar_20;
  tmpvar_20 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_21;
  tmpvar_21 = max (vec2(0.0, 0.0), tmpvar_20);
  vec2 tmpvar_22;
  tmpvar_22 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_23;
  float tmpvar_24;
  tmpvar_24 = ((0.5 * (
    sqrt(dot (tmpvar_21, tmpvar_21))
   + 
    min (0.0, max (tmpvar_20.x, tmpvar_20.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_22, tmpvar_22)
  )));
  if ((tmpvar_24 <= -0.4999)) {
    tmpvar_23 = 1.0;
  } else {
    if ((tmpvar_24 >= 0.4999)) {
      tmpvar_23 = 0.0;
    } else {
      tmpvar_23 = (0.5 + (tmpvar_24 * (
        ((0.8431027 * tmpvar_24) * tmpvar_24)
       - 1.144536)));
    };
  };
  color_2 = (color_2 * tmpvar_23);
  tmpvar_1 = color_2;
  highp float tmpvar_25;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_25 = 1.0;
  } else {
    highp vec2 tmpvar_26;
    tmpvar_26 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_27;
    tmpvar_27 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_26);
    bvec2 tmpvar_28;
    tmpvar_28 = greaterThan (vClipMaskUvBounds.zw, tmpvar_26);
    bool tmpvar_29;
    tmpvar_29 = ((tmpvar_27.x && tmpvar_27.y) && (tmpvar_28.x && tmpvar_28.y));
    if (!(tmpvar_29)) {
      tmpvar_25 = 0.0;
    } else {
      highp ivec3 tmpvar_30;
      tmpvar_30.xy = ivec2(tmpvar_26);
      tmpvar_30.z = int((vClipMaskUv.z + 0.5));
      highp vec4 tmpvar_31;
      tmpvar_31 = texelFetch (sPrevPassAlpha, tmpvar_30, 0);
      tmpvar_25 = tmpvar_31.x;
    };
  };
  tmpvar_1 = (color_2 * tmpvar_25);
  oFragColor = tmpvar_1;
}

