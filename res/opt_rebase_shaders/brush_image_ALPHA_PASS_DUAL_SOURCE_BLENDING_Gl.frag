#version 150
#extension GL_ARB_explicit_attrib_location : enable
precision highp float;
layout(location=0, index=0) out vec4 oFragColor;
layout(location=0, index=1) out vec4 oFragBlend;
uniform sampler2DArray sColor0;
uniform sampler2DArray sPrevPassAlpha;
flat in vec4 vClipMaskUvBounds;
in vec4 vClipMaskUv;
flat in vec4 flat_varying_vec4_0;
flat in vec4 flat_varying_vec4_1;
flat in vec4 flat_varying_vec4_2;
flat in vec4 flat_varying_vec4_3;
flat in vec4 flat_varying_vec4_4;
in vec4 varying_vec4_0;
void main ()
{
  vec4 frag_color_1;
  vec4 frag_blend_2;
  vec4 texel_3;
  vec3 tmpvar_4;
  tmpvar_4.xy = min (max ((
    (varying_vec4_0.zw * mix (gl_FragCoord.w, 1.0, flat_varying_vec4_4.y))
   + flat_varying_vec4_2.xy), flat_varying_vec4_3.xy), flat_varying_vec4_3.zw);
  tmpvar_4.z = flat_varying_vec4_4.x;
  vec4 tmpvar_5;
  tmpvar_5 = texture (sColor0, tmpvar_4);
  texel_3.w = tmpvar_5.w;
  texel_3.xyz = ((tmpvar_5.xyz * flat_varying_vec4_1.x) + (tmpvar_5.www * flat_varying_vec4_1.y));
  frag_color_1 = (flat_varying_vec4_0 * texel_3);
  frag_blend_2 = (texel_3 * flat_varying_vec4_0.w);
  float tmpvar_6;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_6 = 1.0;
  } else {
    vec2 tmpvar_7;
    tmpvar_7 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec4 tmpvar_8;
    tmpvar_8.xy = greaterThanEqual (tmpvar_7, vClipMaskUvBounds.xy);
    tmpvar_8.zw = lessThan (tmpvar_7, vClipMaskUvBounds.zw);
    bool tmpvar_9;
    tmpvar_9 = (tmpvar_8 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_9)) {
      tmpvar_6 = 0.0;
    } else {
      ivec3 tmpvar_10;
      tmpvar_10.xy = ivec2(tmpvar_7);
      tmpvar_10.z = int((vClipMaskUv.z + 0.5));
      tmpvar_6 = texelFetch (sPrevPassAlpha, tmpvar_10, 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_6);
  oFragBlend = (frag_blend_2 * tmpvar_6);
  oFragColor = frag_color_1;
}

