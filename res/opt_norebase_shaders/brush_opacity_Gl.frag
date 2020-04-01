#version 150
precision highp float;
out vec4 oFragColor;
uniform sampler2DArray sColor0;
flat in vec4 vTransformBounds;
flat in vec4 flat_varying_vec4_1;
flat in vec4 flat_varying_vec4_2;
in vec4 varying_vec4_0;
void main ()
{
  float alpha_1;
  vec2 tmpvar_2;
  tmpvar_2 = (varying_vec4_0.zw * mix (gl_FragCoord.w, 1.0, flat_varying_vec4_2.y));
  vec3 tmpvar_3;
  tmpvar_3.xy = tmpvar_2;
  tmpvar_3.z = flat_varying_vec4_2.x;
  vec4 tmpvar_4;
  tmpvar_4 = texture (sColor0, tmpvar_3);
  alpha_1 = tmpvar_4.w;
  vec3 tmpvar_5;
  if ((tmpvar_4.w != 0.0)) {
    tmpvar_5 = (tmpvar_4.xyz / tmpvar_4.w);
  } else {
    tmpvar_5 = tmpvar_4.xyz;
  };
  alpha_1 = (tmpvar_4.w * flat_varying_vec4_2.z);
  float tmpvar_6;
  vec2 tmpvar_7;
  tmpvar_7.x = float((tmpvar_2.x >= flat_varying_vec4_1.z));
  tmpvar_7.y = float((tmpvar_2.y >= flat_varying_vec4_1.w));
  vec2 tmpvar_8;
  tmpvar_8 = (vec2(greaterThanEqual (tmpvar_2, flat_varying_vec4_1.xy)) - tmpvar_7);
  tmpvar_6 = (tmpvar_8.x * tmpvar_8.y);
  vec2 tmpvar_9;
  tmpvar_9 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_10;
  tmpvar_10 = max (vec2(0.0, 0.0), tmpvar_9);
  vec2 tmpvar_11;
  tmpvar_11 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = ((0.5 * (
    sqrt(dot (tmpvar_10, tmpvar_10))
   + 
    min (0.0, max (tmpvar_9.x, tmpvar_9.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_11, tmpvar_11)
  )));
  if ((tmpvar_13 <= -0.4999)) {
    tmpvar_12 = 1.0;
  } else {
    if ((tmpvar_13 >= 0.4999)) {
      tmpvar_12 = 0.0;
    } else {
      tmpvar_12 = (0.5 + (tmpvar_13 * (
        ((0.8431027 * tmpvar_13) * tmpvar_13)
       - 1.144536)));
    };
  };
  alpha_1 = (alpha_1 * min (tmpvar_6, tmpvar_12));
  vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  oFragColor = (alpha_1 * tmpvar_14);
}

