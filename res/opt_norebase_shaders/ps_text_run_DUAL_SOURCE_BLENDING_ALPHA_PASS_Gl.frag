#version 150
precision highp float;
out vec4 oFragColor;
out vec4 oFragBlend;
uniform sampler2DArray sColor0;
uniform sampler2DArray sPrevPassAlpha;
flat in vec4 vClipMaskUvBounds;
in vec4 vClipMaskUv;
flat in vec4 flat_varying_vec4_0;
flat in vec4 flat_varying_vec4_1;
flat in vec4 flat_varying_vec4_2;
in vec4 varying_vec4_0;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec4 mask_3;
  vec3 tmpvar_4;
  tmpvar_4.xy = clamp (varying_vec4_0.xy, flat_varying_vec4_2.xy, flat_varying_vec4_2.zw);
  tmpvar_4.z = varying_vec4_0.z;
  vec4 tmpvar_5;
  tmpvar_5 = texture (sColor0, tmpvar_4);
  mask_3.w = tmpvar_5.w;
  mask_3.xyz = ((tmpvar_5.xyz * flat_varying_vec4_1.x) + (tmpvar_5.www * flat_varying_vec4_1.y));
  tmpvar_1 = (flat_varying_vec4_0 * mask_3);
  tmpvar_2 = (flat_varying_vec4_0.w * mask_3);
  float tmpvar_6;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_6 = 1.0;
  } else {
    vec2 tmpvar_7;
    tmpvar_7 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_8;
    tmpvar_8 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_7);
    bvec2 tmpvar_9;
    tmpvar_9 = greaterThan (vClipMaskUvBounds.zw, tmpvar_7);
    bool tmpvar_10;
    tmpvar_10 = ((tmpvar_8.x && tmpvar_8.y) && (tmpvar_9.x && tmpvar_9.y));
    if (!(tmpvar_10)) {
      tmpvar_6 = 0.0;
    } else {
      ivec3 tmpvar_11;
      tmpvar_11.xy = ivec2(tmpvar_7);
      tmpvar_11.z = int((vClipMaskUv.z + 0.5));
      tmpvar_6 = texelFetch (sPrevPassAlpha, tmpvar_11, 0).x;
    };
  };
  tmpvar_1 = (tmpvar_1 * tmpvar_6);
  oFragBlend = (tmpvar_2 * tmpvar_6);
  oFragColor = tmpvar_1;
}

