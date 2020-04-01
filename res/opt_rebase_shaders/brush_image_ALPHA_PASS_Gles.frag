#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sPrevPassAlpha;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
in highp vec4 varying_vec4_0;
void main ()
{
  vec4 frag_color_1;
  highp vec4 texel_2;
  vec3 tmpvar_3;
  tmpvar_3.xy = min (max ((
    (varying_vec4_0.zw * mix (gl_FragCoord.w, 1.0, flat_varying_vec4_4.y))
   + flat_varying_vec4_2.xy), flat_varying_vec4_3.xy), flat_varying_vec4_3.zw);
  tmpvar_3.z = flat_varying_vec4_4.x;
  vec4 tmpvar_4;
  tmpvar_4 = texture (sColor0, tmpvar_3);
  texel_2.w = tmpvar_4.w;
  texel_2.xyz = ((tmpvar_4.xyz * flat_varying_vec4_1.x) + (tmpvar_4.www * flat_varying_vec4_1.y));
  frag_color_1 = (flat_varying_vec4_0 * texel_2);
  float tmpvar_5;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_5 = 1.0;
  } else {
    vec2 tmpvar_6;
    tmpvar_6 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec4 tmpvar_7;
    tmpvar_7.xy = greaterThanEqual (tmpvar_6, vClipMaskUvBounds.xy);
    tmpvar_7.zw = lessThan (tmpvar_6, vClipMaskUvBounds.zw);
    bool tmpvar_8;
    tmpvar_8 = (tmpvar_7 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_8)) {
      tmpvar_5 = 0.0;
    } else {
      ivec3 tmpvar_9;
      tmpvar_9.xy = ivec2(tmpvar_6);
      tmpvar_9.z = int((vClipMaskUv.z + 0.5));
      tmpvar_5 = texelFetch (sPrevPassAlpha, tmpvar_9, 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_5);
  oFragColor = frag_color_1;
}

