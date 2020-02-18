#version 300 es

uniform mat4 uTransform;
uniform int uMode;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;

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
    vec2 world_pos = aDeviceRect.xy + (aPosition.xy * aDeviceRect.zw);
    vec2 clipped_world_pos = clamp(world_pos, aDeviceClipRect.xy, aDeviceClipRect.xy + aDeviceClipRect.zw);
    vUv = (clipped_world_pos - aDeviceRect.xy) / aDeviceRect.zw;
    vColor = aColor;
    vLayer = aLayer;
    gl_Position = uTransform * vec4(clipped_world_pos, aZId, 1.0);
}
