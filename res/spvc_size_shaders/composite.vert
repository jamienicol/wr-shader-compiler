#version 300 es

uniform mat4 uTransform;

layout(location = 1) in vec4 aDeviceRect;
layout(location = 0) in vec3 aPosition;
layout(location = 2) in vec4 aDeviceClipRect;
out vec2 vUv;
flat out vec4 vColor;
layout(location = 3) in vec4 aColor;
flat out float vLayer;
layout(location = 4) in float aLayer;
layout(location = 5) in float aZId;

void main()
{
    vec2 _35 = clamp(aDeviceRect.xy + (aPosition.xy * aDeviceRect.zw), aDeviceClipRect.xy, aDeviceClipRect.xy + aDeviceClipRect.zw);
    vUv = (_35 - aDeviceRect.xy) / aDeviceRect.zw;
    vColor = aColor;
    vLayer = aLayer;
    gl_Position = uTransform * vec4(_35, aZId, 1.0);
}

