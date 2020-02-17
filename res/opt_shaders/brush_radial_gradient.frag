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
  tmpvar_3 = (flat_varying_vec4_0.w - flat_varying_vec4_0.z);
  float tmpvar_4;
  tmpvar_4 = -((tmpvar_3 * tmpvar_3));
  float tmpvar_5;
  tmpvar_5 = (flat_varying_vec4_0.z * tmpvar_3);
  float tmpvar_6;
  tmpvar_6 = (dot (tmpvar_2, tmpvar_2) - (flat_varying_vec4_0.z * flat_varying_vec4_0.z));
  if ((tmpvar_4 == 0.0)) {
    if ((tmpvar_5 == 0.0)) {
      discard;
    };
    float tmpvar_7;
    tmpvar_7 = ((0.5 * tmpvar_6) / tmpvar_5);
    if ((flat_varying_vec4_0.z >= -((tmpvar_3 * tmpvar_7)))) {
      offset_1 = tmpvar_7;
    } else {
      discard;
    };
  } else {
    float tmpvar_8;
    tmpvar_8 = ((tmpvar_5 * tmpvar_5) - (tmpvar_4 * tmpvar_6));
    if ((tmpvar_8 < 0.0)) {
      discard;
    };
    float tmpvar_9;
    tmpvar_9 = sqrt(tmpvar_8);
    float tmpvar_10;
    tmpvar_10 = ((tmpvar_5 + tmpvar_9) / tmpvar_4);
    float tmpvar_11;
    tmpvar_11 = ((tmpvar_5 - tmpvar_9) / tmpvar_4);
    if ((flat_varying_vec4_0.z >= -((tmpvar_3 * tmpvar_10)))) {
      offset_1 = tmpvar_10;
    } else {
      if ((flat_varying_vec4_0.z >= -((tmpvar_3 * tmpvar_11)))) {
        offset_1 = tmpvar_11;
      } else {
        discard;
      };
    };
  };
  float x_12;
  x_12 = (1.0 + (mix (offset_1, 
    fract(offset_1)
  , flat_varying_vec4_1.z) * 128.0));
  highp int address_13;
  address_13 = (flat_varying_highp_int_address_0 + clamp ((2 * 
    int(floor(x_12))
  ), 0, 258));
  highp ivec2 tmpvar_14;
  tmpvar_14.x = int((uint(mod (uint(address_13), 1024u))));
  tmpvar_14.y = int((uint(address_13) / 1024u));
  oFragColor = mix (texelFetch (sGpuCache, tmpvar_14, 0), texelFetch (sGpuCache, (tmpvar_14 + ivec2(1, 0)), 0), fract(x_12));
}

