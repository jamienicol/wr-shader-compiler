#version 150
precision highp float;
out vec4 oFragColor;
uniform sampler2D sGpuCache;
flat in vec4 vTransformBounds;
uniform sampler2DArray sPrevPassAlpha;
flat in vec4 vClipMaskUvBounds;
in vec4 vClipMaskUv;
flat in vec4 flat_varying_vec4_0;
flat in vec4 flat_varying_vec4_1;
flat in vec4 flat_varying_vec4_2;
in vec4 varying_vec4_0;
flat in int flat_varying_highp_int_address_0;
void main ()
{
  vec4 frag_color_1;
  vec4 color_2;
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
  bool tmpvar_8;
  tmpvar_8 = (0.0 >= tmpvar_7.x);
  float tmpvar_9;
  tmpvar_9 = mix(tmpvar_7.y, abs(tmpvar_7.x), bool(tmpvar_8));
  float tmpvar_10;
  tmpvar_10 = mix(abs(tmpvar_7.x), tmpvar_7.y, bool(tmpvar_8));
  float tmpvar_11;
  tmpvar_11 = mix(1.0, 0.25, bool((abs(tmpvar_10) >= 1e+18)));
  float tmpvar_12;
  tmpvar_12 = (1.0/((tmpvar_10 * tmpvar_11)));
  float tmpvar_13;
  float tmpvar_14;
  tmpvar_14 = (min (abs(
    mix(abs(((tmpvar_9 * tmpvar_11) * tmpvar_12)), 1.0, bool((abs(tmpvar_7.x) == abs(tmpvar_7.y))))
  ), 1.0) / max (abs(
    mix(abs(((tmpvar_9 * tmpvar_11) * tmpvar_12)), 1.0, bool((abs(tmpvar_7.x) == abs(tmpvar_7.y))))
  ), 1.0));
  float tmpvar_15;
  tmpvar_15 = (tmpvar_14 * tmpvar_14);
  tmpvar_15 = (((
    ((((
      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
   * tmpvar_15) + 0.9999793) * tmpvar_14);
  tmpvar_15 = (tmpvar_15 + (float(
    (1.0 < abs(mix(abs(
      ((tmpvar_9 * tmpvar_11) * tmpvar_12)
    ), 1.0, bool((
      abs(tmpvar_7.x)
     == 
      abs(tmpvar_7.y)
    )))))
  ) * (
    (tmpvar_15 * -2.0)
   + 1.570796)));
  tmpvar_13 = (tmpvar_15 * sign(mix(
    abs(((tmpvar_9 * tmpvar_11) * tmpvar_12))
  , 1.0, bool(
    (abs(tmpvar_7.x) == abs(tmpvar_7.y))
  ))));
  tmpvar_13 = (tmpvar_13 + (float(tmpvar_8) * 1.570796));
  offset_3 = (((float(mod (
    ((mix(tmpvar_13, -(tmpvar_13), bool((
      min (tmpvar_7.y, tmpvar_12)
     < 0.0))) + (1.570796 - flat_varying_vec4_1.w)) / 6.283185)
  , 1.0))) - flat_varying_vec4_0.z) / (flat_varying_vec4_0.w - flat_varying_vec4_0.z));
  float x_16;
  x_16 = (1.0 + (mix (offset_3, 
    fract(offset_3)
  , flat_varying_vec4_1.z) * 128.0));
  int tmpvar_17;
  tmpvar_17 = (flat_varying_highp_int_address_0 + min (max (
    (2 * int(floor(x_16)))
  , 0), 258));
  ivec2 tmpvar_18;
  tmpvar_18.x = int((uint(tmpvar_17) % 1024u));
  tmpvar_18.y = int((uint(tmpvar_17) / 1024u));
  color_2 = mix (texelFetchOffset (sGpuCache, tmpvar_18, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_18, 0, ivec2(1, 0)), fract(x_16));
  vec2 tmpvar_19;
  tmpvar_19 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_20;
  tmpvar_20 = max (vec2(0.0, 0.0), tmpvar_19);
  vec2 tmpvar_21;
  tmpvar_21 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_22;
  float tmpvar_23;
  tmpvar_23 = ((0.5 * (
    sqrt(dot (tmpvar_20, tmpvar_20))
   + 
    min (0.0, max (tmpvar_19.x, tmpvar_19.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_21, tmpvar_21)
  )));
  if ((-0.4999 >= tmpvar_23)) {
    tmpvar_22 = 1.0;
  } else {
    if ((tmpvar_23 >= 0.4999)) {
      tmpvar_22 = 0.0;
    } else {
      tmpvar_22 = (0.5 + (tmpvar_23 * (
        ((0.8431027 * tmpvar_23) * tmpvar_23)
       - 1.144536)));
    };
  };
  color_2 = (color_2 * tmpvar_22);
  frag_color_1 = color_2;
  float tmpvar_24;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_24 = 1.0;
  } else {
    vec2 tmpvar_25;
    tmpvar_25 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec4 tmpvar_26;
    tmpvar_26.xy = greaterThanEqual (tmpvar_25, vClipMaskUvBounds.xy);
    tmpvar_26.zw = lessThan (tmpvar_25, vClipMaskUvBounds.zw);
    bool tmpvar_27;
    tmpvar_27 = (tmpvar_26 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_27)) {
      tmpvar_24 = 0.0;
    } else {
      ivec3 tmpvar_28;
      tmpvar_28.xy = ivec2(tmpvar_25);
      tmpvar_28.z = int((vClipMaskUv.z + 0.5));
      tmpvar_24 = texelFetch (sPrevPassAlpha, tmpvar_28, 0).x;
    };
  };
  frag_color_1 = (color_2 * tmpvar_24);
  oFragColor = frag_color_1;
}

