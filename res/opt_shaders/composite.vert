#version 310 es
precision highp sampler2DArray;
uniform mat4 uTransform;
in vec3 aPosition;
out vec2 vUv;
flat out vec4 vColor;
flat out float vLayer;
in vec4 aDeviceRect;
in vec4 aDeviceClipRect;
in vec4 aColor;
in float aLayer;
in float aZId;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = clamp ((aDeviceRect.xy + (aPosition.xy * aDeviceRect.zw)), aDeviceClipRect.xy, (aDeviceClipRect.xy + aDeviceClipRect.zw));
  vUv = ((tmpvar_1 - aDeviceRect.xy) / aDeviceRect.zw);
  vColor = aColor;
  vLayer = aLayer;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xy = tmpvar_1;
  tmpvar_2.z = aZId;
  gl_Position = (uTransform * tmpvar_2);
}

