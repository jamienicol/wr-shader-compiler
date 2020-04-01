#version 150
#extension GL_KHR_blend_equation_advanced : enable
layout(blend_support_all_equations) out;
precision highp float;
out vec4 oFragColor;
uniform sampler2DRect sColor0;
flat in vec4 vTransformBounds;
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
  vec4 tmpvar_1;
  vec4 texel_2;
  vec2 repeated_uv_3;
  vec2 tmpvar_4;
  tmpvar_4 = (flat_varying_vec4_2.zw - flat_varying_vec4_2.xy);
  vec2 tmpvar_5;
  tmpvar_5 = max ((varying_vec4_0.zw * mix (gl_FragCoord.w, 1.0, flat_varying_vec4_4.y)), vec2(0.0, 0.0));
  repeated_uv_3 = ((vec2(mod (tmpvar_5, tmpvar_4))) + flat_varying_vec4_2.xy);
  if ((tmpvar_5.x >= (flat_varying_vec4_1.z * tmpvar_4.x))) {
    repeated_uv_3.x = flat_varying_vec4_2.z;
  };
  if ((tmpvar_5.y >= (flat_varying_vec4_1.w * tmpvar_4.y))) {
    repeated_uv_3.y = flat_varying_vec4_2.w;
  };
  vec3 tmpvar_6;
  tmpvar_6.xy = clamp (repeated_uv_3, flat_varying_vec4_3.xy, flat_varying_vec4_3.zw);
  tmpvar_6.z = flat_varying_vec4_4.x;
  texel_2 = texture (sColor0, tmpvar_6.xy);
  vec2 tmpvar_7;
  tmpvar_7 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_8;
  tmpvar_8 = max (vec2(0.0, 0.0), tmpvar_7);
  vec2 tmpvar_9;
  tmpvar_9 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_10;
  float tmpvar_11;
  tmpvar_11 = ((0.5 * (
    sqrt(dot (tmpvar_8, tmpvar_8))
   + 
    min (0.0, max (tmpvar_7.x, tmpvar_7.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_9, tmpvar_9)
  )));
  if ((tmpvar_11 <= -0.4999)) {
    tmpvar_10 = 1.0;
  } else {
    if ((tmpvar_11 >= 0.4999)) {
      tmpvar_10 = 0.0;
    } else {
      tmpvar_10 = (0.5 + (tmpvar_11 * (
        ((0.8431027 * tmpvar_11) * tmpvar_11)
       - 1.144536)));
    };
  };
  texel_2.xyz = ((texel_2.xyz * flat_varying_vec4_1.x) + (texel_2.www * flat_varying_vec4_1.y));
  tmpvar_1 = (flat_varying_vec4_0 * (texel_2 * tmpvar_10));
  float tmpvar_12;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_12 = 1.0;
  } else {
    vec2 tmpvar_13;
    tmpvar_13 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_14;
    tmpvar_14 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_13);
    bvec2 tmpvar_15;
    tmpvar_15 = greaterThan (vClipMaskUvBounds.zw, tmpvar_13);
    bool tmpvar_16;
    tmpvar_16 = ((tmpvar_14.x && tmpvar_14.y) && (tmpvar_15.x && tmpvar_15.y));
    if (!(tmpvar_16)) {
      tmpvar_12 = 0.0;
    } else {
      ivec3 tmpvar_17;
      tmpvar_17.xy = ivec2(tmpvar_13);
      tmpvar_17.z = int((vClipMaskUv.z + 0.5));
      tmpvar_12 = texelFetch (sPrevPassAlpha, tmpvar_17, 0).x;
    };
  };
  tmpvar_1 = (tmpvar_1 * tmpvar_12);
  oFragColor = tmpvar_1;
}

