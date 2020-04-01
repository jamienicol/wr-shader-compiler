#version 150
precision highp float;
out vec4 oFragColor;
out vec4 oFragBlend;
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
  vec4 tmpvar_2;
  vec4 texel_3;
  vec2 repeated_uv_4;
  vec2 tmpvar_5;
  tmpvar_5 = (flat_varying_vec4_2.zw - flat_varying_vec4_2.xy);
  vec2 tmpvar_6;
  tmpvar_6 = max ((varying_vec4_0.zw * mix (gl_FragCoord.w, 1.0, flat_varying_vec4_4.y)), vec2(0.0, 0.0));
  repeated_uv_4 = ((vec2(mod (tmpvar_6, tmpvar_5))) + flat_varying_vec4_2.xy);
  if ((tmpvar_6.x >= (flat_varying_vec4_1.z * tmpvar_5.x))) {
    repeated_uv_4.x = flat_varying_vec4_2.z;
  };
  if ((tmpvar_6.y >= (flat_varying_vec4_1.w * tmpvar_5.y))) {
    repeated_uv_4.y = flat_varying_vec4_2.w;
  };
  vec3 tmpvar_7;
  tmpvar_7.xy = clamp (repeated_uv_4, flat_varying_vec4_3.xy, flat_varying_vec4_3.zw);
  tmpvar_7.z = flat_varying_vec4_4.x;
  texel_3 = texture (sColor0, tmpvar_7.xy);
  vec2 tmpvar_8;
  tmpvar_8 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_9;
  tmpvar_9 = max (vec2(0.0, 0.0), tmpvar_8);
  vec2 tmpvar_10;
  tmpvar_10 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_11;
  float tmpvar_12;
  tmpvar_12 = ((0.5 * (
    sqrt(dot (tmpvar_9, tmpvar_9))
   + 
    min (0.0, max (tmpvar_8.x, tmpvar_8.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_10, tmpvar_10)
  )));
  if ((tmpvar_12 <= -0.4999)) {
    tmpvar_11 = 1.0;
  } else {
    if ((tmpvar_12 >= 0.4999)) {
      tmpvar_11 = 0.0;
    } else {
      tmpvar_11 = (0.5 + (tmpvar_12 * (
        ((0.8431027 * tmpvar_12) * tmpvar_12)
       - 1.144536)));
    };
  };
  texel_3.xyz = ((texel_3.xyz * flat_varying_vec4_1.x) + (texel_3.www * flat_varying_vec4_1.y));
  vec4 tmpvar_13;
  tmpvar_13 = (texel_3 * tmpvar_11);
  tmpvar_1 = (flat_varying_vec4_0 * tmpvar_13);
  tmpvar_2 = (tmpvar_13 * flat_varying_vec4_0.w);
  float tmpvar_14;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_14 = 1.0;
  } else {
    vec2 tmpvar_15;
    tmpvar_15 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_16;
    tmpvar_16 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_15);
    bvec2 tmpvar_17;
    tmpvar_17 = greaterThan (vClipMaskUvBounds.zw, tmpvar_15);
    bool tmpvar_18;
    tmpvar_18 = ((tmpvar_16.x && tmpvar_16.y) && (tmpvar_17.x && tmpvar_17.y));
    if (!(tmpvar_18)) {
      tmpvar_14 = 0.0;
    } else {
      ivec3 tmpvar_19;
      tmpvar_19.xy = ivec2(tmpvar_15);
      tmpvar_19.z = int((vClipMaskUv.z + 0.5));
      tmpvar_14 = texelFetch (sPrevPassAlpha, tmpvar_19, 0).x;
    };
  };
  tmpvar_1 = (tmpvar_1 * tmpvar_14);
  oFragBlend = (tmpvar_2 * tmpvar_14);
  oFragColor = tmpvar_1;
}

