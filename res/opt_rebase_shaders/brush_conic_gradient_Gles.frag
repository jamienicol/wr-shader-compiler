#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform highp sampler2D sGpuCache;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
in highp vec4 varying_vec4_0;
flat in highp int flat_varying_highp_int_address_0;
void main ()
{
  highp float offset_1;
  vec2 tmpvar_2;
  tmpvar_2 = ((vec2(mod (varying_vec4_0.zw, flat_varying_vec4_1.xy))) - flat_varying_vec4_0.xy);
  bool tmpvar_3;
  tmpvar_3 = (0.0 >= tmpvar_2.x);
  float tmpvar_4;
  tmpvar_4 = mix(tmpvar_2.y, abs(tmpvar_2.x), bool(tmpvar_3));
  float tmpvar_5;
  tmpvar_5 = mix(abs(tmpvar_2.x), tmpvar_2.y, bool(tmpvar_3));
  float tmpvar_6;
  tmpvar_6 = mix(1.0, 0.25, bool((abs(tmpvar_5) >= 1e+18)));
  float tmpvar_7;
  tmpvar_7 = (1.0/((tmpvar_5 * tmpvar_6)));
  float tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = (min (abs(
    mix(abs(((tmpvar_4 * tmpvar_6) * tmpvar_7)), 1.0, bool((abs(tmpvar_2.x) == abs(tmpvar_2.y))))
  ), 1.0) / max (abs(
    mix(abs(((tmpvar_4 * tmpvar_6) * tmpvar_7)), 1.0, bool((abs(tmpvar_2.x) == abs(tmpvar_2.y))))
  ), 1.0));
  float tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_9);
  tmpvar_10 = (((
    ((((
      ((((-0.01213232 * tmpvar_10) + 0.05368138) * tmpvar_10) - 0.1173503)
     * tmpvar_10) + 0.1938925) * tmpvar_10) - 0.3326756)
   * tmpvar_10) + 0.9999793) * tmpvar_9);
  tmpvar_10 = (tmpvar_10 + (float(
    (1.0 < abs(mix(abs(
      ((tmpvar_4 * tmpvar_6) * tmpvar_7)
    ), 1.0, bool((
      abs(tmpvar_2.x)
     == 
      abs(tmpvar_2.y)
    )))))
  ) * (
    (tmpvar_10 * -2.0)
   + 1.570796)));
  tmpvar_8 = (tmpvar_10 * sign(mix(
    abs(((tmpvar_4 * tmpvar_6) * tmpvar_7))
  , 1.0, bool(
    (abs(tmpvar_2.x) == abs(tmpvar_2.y))
  ))));
  tmpvar_8 = (tmpvar_8 + (float(tmpvar_3) * 1.570796));
  offset_1 = (((float(mod (
    ((mix(tmpvar_8, -(tmpvar_8), bool((
      min (tmpvar_2.y, tmpvar_7)
     < 0.0))) + (1.570796 - flat_varying_vec4_1.w)) / 6.283185)
  , 1.0))) - flat_varying_vec4_0.z) / (flat_varying_vec4_0.w - flat_varying_vec4_0.z));
  highp float x_11;
  x_11 = (1.0 + (mix (offset_1, 
    fract(offset_1)
  , flat_varying_vec4_1.z) * 128.0));
  highp int tmpvar_12;
  tmpvar_12 = (flat_varying_highp_int_address_0 + min (max (
    (2 * int(floor(x_11)))
  , 0), 258));
  ivec2 tmpvar_13;
  tmpvar_13.x = int((uint(tmpvar_12) % 1024u));
  tmpvar_13.y = int((uint(tmpvar_12) / 1024u));
  oFragColor = mix (texelFetch (sGpuCache, tmpvar_13, 0), texelFetch (sGpuCache, (tmpvar_13 + ivec2(1, 0)), 0), fract(x_11));
}

