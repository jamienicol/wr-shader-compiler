#version 300 es
#extension GL_KHR_blend_equation_advanced : enable
layout(blend_support_all_equations) out;
precision highp float;
precision highp sampler2DArray;
out lowp vec4 oFragColor;
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
  lowp vec4 tmpvar_1;
  lowp vec4 texel_2;
  highp vec3 tmpvar_3;
  tmpvar_3.xy = clamp (((varying_vec4_0.zw * 
    mix (gl_FragCoord.w, 1.0, flat_varying_vec4_4.y)
  ) + flat_varying_vec4_2.xy), flat_varying_vec4_3.xy, flat_varying_vec4_3.zw);
  tmpvar_3.z = flat_varying_vec4_4.x;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (sColor0, tmpvar_3);
  texel_2.w = tmpvar_4.w;
  texel_2.xyz = ((tmpvar_4.xyz * flat_varying_vec4_1.x) + (tmpvar_4.www * flat_varying_vec4_1.y));
  tmpvar_1 = (flat_varying_vec4_0 * texel_2);
  highp float tmpvar_5;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_5 = 1.0;
  } else {
    highp vec2 tmpvar_6;
    tmpvar_6 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_7;
    tmpvar_7 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_6);
    bvec2 tmpvar_8;
    tmpvar_8 = greaterThan (vClipMaskUvBounds.zw, tmpvar_6);
    bool tmpvar_9;
    tmpvar_9 = ((tmpvar_7.x && tmpvar_7.y) && (tmpvar_8.x && tmpvar_8.y));
    if (!(tmpvar_9)) {
      tmpvar_5 = 0.0;
    } else {
      highp ivec3 tmpvar_10;
      tmpvar_10.xy = ivec2(tmpvar_6);
      tmpvar_10.z = int((vClipMaskUv.z + 0.5));
      highp vec4 tmpvar_11;
      tmpvar_11 = texelFetch (sPrevPassAlpha, tmpvar_10, 0);
      tmpvar_5 = tmpvar_11.x;
    };
  };
  tmpvar_1 = (tmpvar_1 * tmpvar_5);
  oFragColor = tmpvar_1;
}

