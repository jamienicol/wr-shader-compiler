#version 150
precision highp float;
out vec4 oFragColor;
flat in vec4 vTransformBounds;
uniform sampler2DArray sPrevPassAlpha;
flat in vec4 vClipMaskUvBounds;
in vec4 vClipMaskUv;
flat in vec4 flat_varying_vec4_0;
in vec4 varying_vec4_0;
void main ()
{
  vec4 frag_color_1;
  vec4 color_2;
  color_2 = flat_varying_vec4_0;
  vec2 tmpvar_3;
  tmpvar_3 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_4;
  tmpvar_4 = max (vec2(0.0, 0.0), tmpvar_3);
  vec2 tmpvar_5;
  tmpvar_5 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_6;
  float tmpvar_7;
  tmpvar_7 = ((0.5 * (
    sqrt(dot (tmpvar_4, tmpvar_4))
   + 
    min (0.0, max (tmpvar_3.x, tmpvar_3.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_5, tmpvar_5)
  )));
  if ((-0.4999 >= tmpvar_7)) {
    tmpvar_6 = 1.0;
  } else {
    if ((tmpvar_7 >= 0.4999)) {
      tmpvar_6 = 0.0;
    } else {
      tmpvar_6 = (0.5 + (tmpvar_7 * (
        ((0.8431027 * tmpvar_7) * tmpvar_7)
       - 1.144536)));
    };
  };
  color_2 = (flat_varying_vec4_0 * tmpvar_6);
  frag_color_1 = color_2;
  float tmpvar_8;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_8 = 1.0;
  } else {
    vec2 tmpvar_9;
    tmpvar_9 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec4 tmpvar_10;
    tmpvar_10.xy = greaterThanEqual (tmpvar_9, vClipMaskUvBounds.xy);
    tmpvar_10.zw = lessThan (tmpvar_9, vClipMaskUvBounds.zw);
    bool tmpvar_11;
    tmpvar_11 = (tmpvar_10 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_11)) {
      tmpvar_8 = 0.0;
    } else {
      ivec3 tmpvar_12;
      tmpvar_12.xy = ivec2(tmpvar_9);
      tmpvar_12.z = int((vClipMaskUv.z + 0.5));
      tmpvar_8 = texelFetch (sPrevPassAlpha, tmpvar_12, 0).x;
    };
  };
  frag_color_1 = (color_2 * tmpvar_8);
  oFragColor = frag_color_1;
}

