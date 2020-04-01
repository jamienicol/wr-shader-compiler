#version 150
precision highp float;
out vec4 oFragColor;
uniform sampler2D sGpuCache;
flat in vec4 flat_varying_vec4_0;
flat in vec4 flat_varying_vec4_1;
in vec4 varying_vec4_0;
flat in int flat_varying_highp_int_address_0;
void main ()
{
  float tmpvar_1;
  tmpvar_1 = dot (((vec2(mod (varying_vec4_0.zw, flat_varying_vec4_1.xy))) - flat_varying_vec4_0.xy), flat_varying_vec4_0.zw);
  float x_2;
  x_2 = (1.0 + (mix (tmpvar_1, 
    fract(tmpvar_1)
  , flat_varying_vec4_1.z) * 128.0));
  int address_3;
  address_3 = (flat_varying_highp_int_address_0 + clamp ((2 * 
    int(floor(x_2))
  ), 0, 258));
  ivec2 tmpvar_4;
  tmpvar_4.x = int((uint(address_3) % 1024u));
  tmpvar_4.y = int((uint(address_3) / 1024u));
  oFragColor = mix (texelFetchOffset (sGpuCache, tmpvar_4, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_4, 0, ivec2(1, 0)), fract(x_2));
}

