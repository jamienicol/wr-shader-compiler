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
  vec2 tmpvar_1;
  tmpvar_1 = ((vec2(mod (varying_vec4_0.zw, flat_varying_vec4_1.xy))) - flat_varying_vec4_0.xy);
  float tmpvar_2;
  float tmpvar_3;
  tmpvar_3 = (min (abs(
    (tmpvar_1.y / tmpvar_1.x)
  ), 1.0) / max (abs(
    (tmpvar_1.y / tmpvar_1.x)
  ), 1.0));
  float tmpvar_4;
  tmpvar_4 = (tmpvar_3 * tmpvar_3);
  tmpvar_4 = (((
    ((((
      ((((-0.01213232 * tmpvar_4) + 0.05368138) * tmpvar_4) - 0.1173503)
     * tmpvar_4) + 0.1938925) * tmpvar_4) - 0.3326756)
   * tmpvar_4) + 0.9999793) * tmpvar_3);
  tmpvar_4 = (tmpvar_4 + (float(
    (abs((tmpvar_1.y / tmpvar_1.x)) > 1.0)
  ) * (
    (tmpvar_4 * -2.0)
   + 1.570796)));
  tmpvar_2 = (tmpvar_4 * sign((tmpvar_1.y / tmpvar_1.x)));
  if ((abs(tmpvar_1.x) > (1e-08 * abs(tmpvar_1.y)))) {
    if ((tmpvar_1.x < 0.0)) {
      if ((tmpvar_1.y >= 0.0)) {
        tmpvar_2 += 3.141593;
      } else {
        tmpvar_2 = (tmpvar_2 - 3.141593);
      };
    };
  } else {
    tmpvar_2 = (sign(tmpvar_1.y) * 1.570796);
  };
  float tmpvar_5;
  tmpvar_5 = (float(mod (((tmpvar_2 + 
    (1.570796 - flat_varying_vec4_0.z)
  ) / 6.283185), 1.0)));
  float x_6;
  x_6 = (1.0 + (mix (tmpvar_5, 
    fract(tmpvar_5)
  , flat_varying_vec4_1.z) * 128.0));
  highp int address_7;
  address_7 = (flat_varying_highp_int_address_0 + clamp ((2 * 
    int(floor(x_6))
  ), 0, 258));
  highp ivec2 tmpvar_8;
  tmpvar_8.x = int((uint(mod (uint(address_7), 1024u))));
  tmpvar_8.y = int((uint(address_7) / 1024u));
  oFragColor = mix (texelFetch (sGpuCache, tmpvar_8, 0), texelFetch (sGpuCache, (tmpvar_8 + ivec2(1, 0)), 0), fract(x_6));
}

