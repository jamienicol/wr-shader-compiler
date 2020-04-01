#version 300 es
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
in vec4 varying_vec4_1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 mask_2;
  vec3 tmpvar_3;
  tmpvar_3.xy = clamp (varying_vec4_0.xy, flat_varying_vec4_2.xy, flat_varying_vec4_2.zw);
  tmpvar_3.z = varying_vec4_0.z;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (sColor0, tmpvar_3);
  mask_2.w = tmpvar_4.w;
  mask_2.xyz = ((tmpvar_4.xyz * flat_varying_vec4_1.x) + (tmpvar_4.www * flat_varying_vec4_1.y));
  bvec4 tmpvar_5;
  tmpvar_5 = greaterThanEqual (varying_vec4_1, vec4(0.0, 0.0, 0.0, 0.0));
  mask_2 = (mask_2 * float((
    (tmpvar_5.x && tmpvar_5.y)
   && 
    (tmpvar_5.z && tmpvar_5.w)
  )));
  tmpvar_1 = (flat_varying_vec4_0 * mask_2);
  highp float tmpvar_6;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_6 = 1.0;
  } else {
    highp vec2 tmpvar_7;
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
      highp ivec3 tmpvar_11;
      tmpvar_11.xy = ivec2(tmpvar_7);
      tmpvar_11.z = int((vClipMaskUv.z + 0.5));
      highp vec4 tmpvar_12;
      tmpvar_12 = texelFetch (sPrevPassAlpha, tmpvar_11, 0);
      tmpvar_6 = tmpvar_12.x;
    };
  };
  tmpvar_1 = (tmpvar_1 * tmpvar_6);
  oFragColor = tmpvar_1;
}

