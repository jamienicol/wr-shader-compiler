#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
in highp vec2 vUv;
flat in highp vec2 vLayerAndPerspective;
flat in highp vec4 vUvSampleBounds;
void main ()
{
  float tmpvar_1;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_1 = 1.0;
  } else {
    vec2 tmpvar_2;
    tmpvar_2 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec4 tmpvar_3;
    tmpvar_3.xy = greaterThanEqual (tmpvar_2, vClipMaskUvBounds.xy);
    tmpvar_3.zw = lessThan (tmpvar_2, vClipMaskUvBounds.zw);
    bool tmpvar_4;
    tmpvar_4 = (tmpvar_3 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_4)) {
      tmpvar_1 = 0.0;
    } else {
      ivec3 tmpvar_5;
      tmpvar_5.xy = ivec2(tmpvar_2);
      tmpvar_5.z = int((vClipMaskUv.z + 0.5));
      tmpvar_1 = texelFetch (sPrevPassAlpha, tmpvar_5, 0).x;
    };
  };
  vec3 tmpvar_6;
  tmpvar_6.xy = min (max ((vUv * 
    mix (gl_FragCoord.w, 1.0, vLayerAndPerspective.y)
  ), vUvSampleBounds.xy), vUvSampleBounds.zw);
  tmpvar_6.z = vLayerAndPerspective.x;
  oFragColor = (tmpvar_1 * textureLod (sPrevPassColor, tmpvar_6, 0.0));
}

