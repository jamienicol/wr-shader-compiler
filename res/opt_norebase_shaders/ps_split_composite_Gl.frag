#version 150
precision highp float;
out vec4 oFragColor;
uniform sampler2DArray sPrevPassAlpha;
uniform sampler2DArray sPrevPassColor;
flat in vec4 vClipMaskUvBounds;
in vec4 vClipMaskUv;
in vec2 vUv;
flat in vec2 vLayerAndPerspective;
flat in vec4 vUvSampleBounds;
void main ()
{
  float tmpvar_1;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_1 = 1.0;
  } else {
    vec2 tmpvar_2;
    tmpvar_2 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_3;
    tmpvar_3 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_2);
    bvec2 tmpvar_4;
    tmpvar_4 = greaterThan (vClipMaskUvBounds.zw, tmpvar_2);
    bool tmpvar_5;
    tmpvar_5 = ((tmpvar_3.x && tmpvar_3.y) && (tmpvar_4.x && tmpvar_4.y));
    if (!(tmpvar_5)) {
      tmpvar_1 = 0.0;
    } else {
      ivec3 tmpvar_6;
      tmpvar_6.xy = ivec2(tmpvar_2);
      tmpvar_6.z = int((vClipMaskUv.z + 0.5));
      tmpvar_1 = texelFetch (sPrevPassAlpha, tmpvar_6, 0).x;
    };
  };
  vec3 tmpvar_7;
  tmpvar_7.xy = clamp ((vUv * mix (gl_FragCoord.w, 1.0, vLayerAndPerspective.y)), vUvSampleBounds.xy, vUvSampleBounds.zw);
  tmpvar_7.z = vLayerAndPerspective.x;
  oFragColor = (tmpvar_1 * textureLod (sPrevPassColor, tmpvar_7, 0.0));
}

