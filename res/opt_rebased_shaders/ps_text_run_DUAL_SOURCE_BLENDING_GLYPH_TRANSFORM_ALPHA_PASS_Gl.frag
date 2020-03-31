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
in vec4 varying_vec4_0;
in vec4 varying_vec4_1;
void main ()
{
  vec4 frag_color_1;
  vec4 frag_blend_2;
  vec4 mask_3;
  vec3 tmpvar_4;
  tmpvar_4.xy = min (max (varying_vec4_0.xy, flat_varying_vec4_2.xy), flat_varying_vec4_2.zw);
  tmpvar_4.z = varying_vec4_0.z;
  vec4 tmpvar_5;
  tmpvar_5 = texture (sColor0, tmpvar_4);
  mask_3.w = tmpvar_5.w;
  mask_3.xyz = ((tmpvar_5.xyz * flat_varying_vec4_1.x) + (tmpvar_5.www * flat_varying_vec4_1.y));
  mask_3 = (mask_3 * float((
    greaterThanEqual (varying_vec4_1, vec4(0.0, 0.0, 0.0, 0.0))
   == bvec4(1, 1, 1, 1))));
  frag_color_1 = (flat_varying_vec4_0 * mask_3);
  frag_blend_2 = (flat_varying_vec4_0.w * mask_3);
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

