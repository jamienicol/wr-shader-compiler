#version 300 es
precision highp sampler2DArray;
uniform highp mat4 uTransform;
in highp vec2 aPosition;
flat out highp vec4 vColor;
flat out highp float vLayer;
out highp vec2 vUv;
in highp vec4 aDeviceRect;
in highp vec4 aDeviceClipRect;
in highp vec4 aColor;
in highp vec4 aParams;
in highp vec3 aTextureLayers;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = min (max ((aDeviceRect.xy + 
    (aPosition * aDeviceRect.zw)
  ), aDeviceClipRect.xy), (aDeviceClipRect.xy + aDeviceClipRect.zw));
  vUv = ((tmpvar_1 - aDeviceRect.xy) / aDeviceRect.zw);
  vColor = aColor;
  vLayer = aTextureLayers.x;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xy = tmpvar_1;
  tmpvar_2.z = aParams.x;
  gl_Position = (uTransform * tmpvar_2);
}

