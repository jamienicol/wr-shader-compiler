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
in vec4 varying_vec4_1;
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
  bvec4 tmpvar_6;
  tmpvar_6 = greaterThanEqual (varying_vec4_1, vec4(0.0, 0.0, 0.0, 0.0));
  mask_3 = (mask_3 * float((
    (tmpvar_6.x && tmpvar_6.y)
   && 
    (tmpvar_6.z && tmpvar_6.w)
  )));
  tmpvar_1 = (flat_varying_vec4_0 * mask_3);
  tmpvar_2 = (flat_varying_vec4_0.w * mask_3);
  float tmpvar_7;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_7 = 1.0;
  } else {
    vec2 tmpvar_8;
    tmpvar_8 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_9;
    tmpvar_9 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_8);
    bvec2 tmpvar_10;
    tmpvar_10 = greaterThan (vClipMaskUvBounds.zw, tmpvar_8);
    bool tmpvar_11;
    tmpvar_11 = ((tmpvar_9.x && tmpvar_9.y) && (tmpvar_10.x && tmpvar_10.y));
    if (!(tmpvar_11)) {
      tmpvar_7 = 0.0;
    } else {
      ivec3 tmpvar_12;
      tmpvar_12.xy = ivec2(tmpvar_8);
      tmpvar_12.z = int((vClipMaskUv.z + 0.5));
      tmpvar_7 = texelFetch (sPrevPassAlpha, tmpvar_12, 0).x;
    };
  };
  tmpvar_1 = (tmpvar_1 * tmpvar_7);
  oFragBlend = (tmpvar_2 * tmpvar_7);
  oFragColor = tmpvar_1;
}

