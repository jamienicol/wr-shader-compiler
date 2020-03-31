#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform lowp sampler2D sColor0;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
in highp vec4 varying_vec4_0;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.xy = min (max ((
    (varying_vec4_0.zw * mix (gl_FragCoord.w, 1.0, flat_varying_vec4_4.y))
   + flat_varying_vec4_2.xy), flat_varying_vec4_3.xy), flat_varying_vec4_3.zw);
  tmpvar_1.z = flat_varying_vec4_4.x;
  oFragColor = texture (sColor0, tmpvar_1.xy);
}

