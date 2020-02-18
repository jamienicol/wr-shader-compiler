#version 300 es

uniform mat4 uTransform;
uniform int uMode;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;

out float vPos;
layout(location = 8) in vec2 aStartStop;
layout(location = 0) in vec3 aPosition;
layout(location = 2) in float aAxisSelect;
flat out vec4 vStops;
layout(location = 3) in vec4 aStops;
flat out vec4 vColor0;
layout(location = 4) in vec4 aColor0;
flat out vec4 vColor1;
layout(location = 5) in vec4 aColor1;
flat out vec4 vColor2;
layout(location = 6) in vec4 aColor2;
flat out vec4 vColor3;
layout(location = 7) in vec4 aColor3;
layout(location = 1) in vec4 aTaskRect;

void main()
{
    vPos = mix(aStartStop.x, aStartStop.y, mix(aPosition.x, aPosition.y, aAxisSelect));
    vStops = aStops;
    vColor0 = aColor0;
    vColor1 = aColor1;
    vColor2 = aColor2;
    vColor3 = aColor3;
    gl_Position = uTransform * vec4(aTaskRect.xy + (aTaskRect.zw * aPosition.xy), 0.0, 1.0);
}

