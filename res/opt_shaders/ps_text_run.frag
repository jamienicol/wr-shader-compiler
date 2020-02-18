#version 310 es
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
in vec4 varying_vec4_0;
void main ()
{
  lowp vec4 mask_1;
  vec3 tmpvar_2;
  tmpvar_2.xy = clamp (varying_vec4_0.xy, flat_varying_vec4_2.xy, flat_varying_vec4_2.zw);
  tmpvar_2.z = varying_vec4_0.z;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (sColor0, tmpvar_2);
  mask_1.w = tmpvar_3.w;
  mask_1.xyz = ((tmpvar_3.xyz * flat_varying_vec4_1.x) + (tmpvar_3.www * flat_varying_vec4_1.y));
  highp float tmpvar_4;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_4 = 1.0;
  } else {
    highp vec2 tmpvar_5;
    tmpvar_5 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_6;
    tmpvar_6 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_5);
    bvec2 tmpvar_7;
    tmpvar_7 = greaterThan (vClipMaskUvBounds.zw, tmpvar_5);
    bool tmpvar_8;
    tmpvar_8 = ((tmpvar_6.x && tmpvar_6.y) && (tmpvar_7.x && tmpvar_7.y));
    if (!(tmpvar_8)) {
      tmpvar_4 = 0.0;
    } else {
      highp ivec3 tmpvar_9;
      tmpvar_9.xy = ivec2(tmpvar_5);
      tmpvar_9.z = int((vClipMaskUv.z + 0.5));
      highp vec4 tmpvar_10;
      tmpvar_10 = texelFetch (sPrevPassAlpha, tmpvar_9, 0);
      tmpvar_4 = tmpvar_10.x;
    };
  };
  oFragColor = ((flat_varying_vec4_0 * mask_1) * tmpvar_4);
}

