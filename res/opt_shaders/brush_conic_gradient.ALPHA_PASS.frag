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
  vec2 tmpvar_6;
  tmpvar_6 = (pos_3 - flat_varying_vec4_0.xy);
  float tmpvar_7;
  float tmpvar_8;
  tmpvar_8 = (min (abs(
    (tmpvar_6.y / tmpvar_6.x)
  ), 1.0) / max (abs(
    (tmpvar_6.y / tmpvar_6.x)
  ), 1.0));
  float tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_8);
  tmpvar_9 = (((
    ((((
      ((((-0.01213232 * tmpvar_9) + 0.05368138) * tmpvar_9) - 0.1173503)
     * tmpvar_9) + 0.1938925) * tmpvar_9) - 0.3326756)
   * tmpvar_9) + 0.9999793) * tmpvar_8);
  tmpvar_9 = (tmpvar_9 + (float(
    (abs((tmpvar_6.y / tmpvar_6.x)) > 1.0)
  ) * (
    (tmpvar_9 * -2.0)
   + 1.570796)));
  tmpvar_7 = (tmpvar_9 * sign((tmpvar_6.y / tmpvar_6.x)));
  if ((abs(tmpvar_6.x) > (1e-08 * abs(tmpvar_6.y)))) {
    if ((tmpvar_6.x < 0.0)) {
      if ((tmpvar_6.y >= 0.0)) {
        tmpvar_7 += 3.141593;
      } else {
        tmpvar_7 = (tmpvar_7 - 3.141593);
      };
    };
  } else {
    tmpvar_7 = (sign(tmpvar_6.y) * 1.570796);
  };
  float tmpvar_10;
  tmpvar_10 = (float(mod (((tmpvar_7 + 
    (1.570796 - flat_varying_vec4_0.z)
  ) / 6.283185), 1.0)));
  float x_11;
  x_11 = (1.0 + (mix (tmpvar_10, 
    fract(tmpvar_10)
  , flat_varying_vec4_1.z) * 128.0));
  highp int address_12;
  address_12 = (flat_varying_highp_int_address_0 + clamp ((2 * 
    int(floor(x_11))
  ), 0, 258));
  highp ivec2 tmpvar_13;
  tmpvar_13.x = int((uint(mod (uint(address_12), 1024u))));
  tmpvar_13.y = int((uint(address_12) / 1024u));
  color_2 = mix (texelFetch (sGpuCache, tmpvar_13, 0), texelFetch (sGpuCache, (tmpvar_13 + ivec2(1, 0)), 0), fract(x_11));
  vec2 tmpvar_14;
  tmpvar_14 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_15;
  tmpvar_15 = max (vec2(0.0, 0.0), tmpvar_14);
  vec2 tmpvar_16;
  tmpvar_16 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_17;
  float tmpvar_18;
  tmpvar_18 = ((0.5 * (
    sqrt(dot (tmpvar_15, tmpvar_15))
   + 
    min (0.0, max (tmpvar_14.x, tmpvar_14.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_16, tmpvar_16)
  )));
  if ((tmpvar_18 <= -0.4999)) {
    tmpvar_17 = 1.0;
  } else {
    if ((tmpvar_18 >= 0.4999)) {
      tmpvar_17 = 0.0;
    } else {
      tmpvar_17 = (0.5 + (tmpvar_18 * (
        ((0.8431027 * tmpvar_18) * tmpvar_18)
       - 1.144536)));
    };
  };
  color_2 = (color_2 * tmpvar_17);
  tmpvar_1 = color_2;
  highp float tmpvar_19;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_19 = 1.0;
  } else {
    highp vec2 tmpvar_20;
    tmpvar_20 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_21;
    tmpvar_21 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_20);
    bvec2 tmpvar_22;
    tmpvar_22 = greaterThan (vClipMaskUvBounds.zw, tmpvar_20);
    bool tmpvar_23;
    tmpvar_23 = ((tmpvar_21.x && tmpvar_21.y) && (tmpvar_22.x && tmpvar_22.y));
    if (!(tmpvar_23)) {
      tmpvar_19 = 0.0;
    } else {
      highp ivec3 tmpvar_24;
      tmpvar_24.xy = ivec2(tmpvar_20);
      tmpvar_24.z = int((vClipMaskUv.z + 0.5));
      highp vec4 tmpvar_25;
      tmpvar_25 = texelFetch (sPrevPassAlpha, tmpvar_24, 0);
      tmpvar_19 = tmpvar_25.x;
    };
  };
  tmpvar_1 = (color_2 * tmpvar_19);
  oFragColor = tmpvar_1;
}

