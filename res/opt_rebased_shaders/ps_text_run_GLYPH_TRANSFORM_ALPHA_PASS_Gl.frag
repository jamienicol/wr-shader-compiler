#version 150
precision highp float;
out vec4 oFragColor;
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
  vec4 mask_2;
  vec3 tmpvar_3;
  tmpvar_3.xy = min (max (varying_vec4_0.xy, flat_varying_vec4_2.xy), flat_varying_vec4_2.zw);
  tmpvar_3.z = varying_vec4_0.z;
  vec4 tmpvar_4;
  tmpvar_4 = texture (sColor0, tmpvar_3);
  mask_2.w = tmpvar_4.w;
  mask_2.xyz = ((tmpvar_4.xyz * flat_varying_vec4_1.x) + (tmpvar_4.www * flat_varying_vec4_1.y));
  mask_2 = (mask_2 * float((
    greaterThanEqual (varying_vec4_1, vec4(0.0, 0.0, 0.0, 0.0))
   == bvec4(1, 1, 1, 1))));
  frag_color_1 = (flat_varying_vec4_0 * mask_2);
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

