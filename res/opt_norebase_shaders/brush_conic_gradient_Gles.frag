#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform highp sampler2D sGpuCache;
flat in vec4 flat_varying_vec4_0;
flat in vec4 flat_varying_vec4_1;
in vec4 varying_vec4_0;
flat in highp int flat_varying_highp_int_address_0;
void main ()
{
  float offset_1;
  vec2 tmpvar_2;
  tmpvar_2 = ((vec2(mod (varying_vec4_0.zw, flat_varying_vec4_1.xy))) - flat_varying_vec4_0.xy);
  float tmpvar_3;
  float tmpvar_4;
  tmpvar_4 = (min (abs(
    (tmpvar_2.y / tmpvar_2.x)
  ), 1.0) / max (abs(
    (tmpvar_2.y / tmpvar_2.x)
  ), 1.0));
  float tmpvar_5;
  tmpvar_5 = (tmpvar_4 * tmpvar_4);
  tmpvar_5 = (((
    ((((
      ((((-0.01213232 * tmpvar_5) + 0.05368138) * tmpvar_5) - 0.1173503)
     * tmpvar_5) + 0.1938925) * tmpvar_5) - 0.3326756)
   * tmpvar_5) + 0.9999793) * tmpvar_4);
  tmpvar_5 = (tmpvar_5 + (float(
    (abs((tmpvar_2.y / tmpvar_2.x)) > 1.0)
  ) * (
    (tmpvar_5 * -2.0)
   + 1.570796)));
  tmpvar_3 = (tmpvar_5 * sign((tmpvar_2.y / tmpvar_2.x)));
  if ((abs(tmpvar_2.x) > (1e-08 * abs(tmpvar_2.y)))) {
    if ((tmpvar_2.x < 0.0)) {
      if ((tmpvar_2.y >= 0.0)) {
        tmpvar_3 += 3.141593;
      } else {
        tmpvar_3 = (tmpvar_3 - 3.141593);
      };
    };
  } else {
    tmpvar_3 = (sign(tmpvar_2.y) * 1.570796);
  };
  offset_1 = (((float(mod (
    ((tmpvar_3 + (1.570796 - flat_varying_vec4_1.w)) / 6.283185)
  , 1.0))) - flat_varying_vec4_0.z) / (flat_varying_vec4_0.w - flat_varying_vec4_0.z));
  float x_6;
  x_6 = (1.0 + (mix (offset_1, 
    fract(offset_1)
  , flat_varying_vec4_1.z) * 128.0));
  highp int address_7;
  address_7 = (flat_varying_highp_int_address_0 + clamp ((2 * 
    int(floor(x_6))
  ), 0, 258));
  highp ivec2 tmpvar_8;
  tmpvar_8.x = int((uint(address_7) % 1024u));
  tmpvar_8.y = int((uint(address_7) / 1024u));
  oFragColor = mix (texelFetch (sGpuCache, tmpvar_8, 0), texelFetch (sGpuCache, (tmpvar_8 + ivec2(1, 0)), 0), fract(x_6));
}

