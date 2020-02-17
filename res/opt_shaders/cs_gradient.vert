#version 300 es
precision highp sampler2DArray;
uniform mat4 uTransform;
in vec3 aPosition;
out float vPos;
flat out vec4 vStops;
flat out vec4 vColor0;
flat out vec4 vColor1;
flat out vec4 vColor2;
flat out vec4 vColor3;
in vec4 aTaskRect;
in float aAxisSelect;
in vec4 aStops;
in vec4 aColor0;
in vec4 aColor1;
in vec4 aColor2;
in vec4 aColor3;
in vec2 aStartStop;
void main ()
{
  vPos = mix (aStartStop.x, aStartStop.y, mix (aPosition.x, aPosition.y, aAxisSelect));
  vStops = aStops;
  vColor0 = aColor0;
  vColor1 = aColor1;
  vColor2 = aColor2;
  vColor3 = aColor3;
  vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = (aTaskRect.xy + (aTaskRect.zw * aPosition.xy));
  gl_Position = (uTransform * tmpvar_1);
}

