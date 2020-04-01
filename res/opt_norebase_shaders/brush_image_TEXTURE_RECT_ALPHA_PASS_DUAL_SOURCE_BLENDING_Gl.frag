#version 150
precision highp float;
out vec4 oFragColor;
out vec4 oFragBlend;
uniform sampler2DRect sColor0;
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
  vec3 tmpvar_4;
  tmpvar_4.xy = clamp (((varying_vec4_0.zw * 
    mix (gl_FragCoord.w, 1.0, flat_varying_vec4_4.y)
  ) + flat_varying_vec4_2.xy), flat_varying_vec4_3.xy, flat_varying_vec4_3.zw);
  tmpvar_4.z = flat_varying_vec4_4.x;
  vec4 tmpvar_5;
  tmpvar_5 = texture (sColor0, tmpvar_4.xy);
  texel_3.w = tmpvar_5.w;
  texel_3.xyz = ((tmpvar_5.xyz * flat_varying_vec4_1.x) + (tmpvar_5.www * flat_varying_vec4_1.y));
  tmpvar_1 = (flat_varying_vec4_0 * texel_3);
  tmpvar_2 = (texel_3 * flat_varying_vec4_0.w);
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

