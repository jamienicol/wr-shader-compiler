#version 150
uniform mat4 uTransform;
in vec2 aPosition;
flat out vec4 vColor;
flat out float vLayer;
out vec2 vUv;
in vec4 aDeviceRect;
in vec4 aDeviceClipRect;
in vec4 aColor;
in vec4 aParams;
in vec3 aTextureLayers;
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

