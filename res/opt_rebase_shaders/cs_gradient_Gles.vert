#version 300 es
precision highp sampler2DArray;
uniform highp mat4 uTransform;
in highp vec2 aPosition;
out highp float vPos;
flat out highp vec4 vStops;
flat out highp vec4 vColor0;
flat out highp vec4 vColor1;
flat out highp vec4 vColor2;
flat out highp vec4 vColor3;
in highp vec4 aTaskRect;
in highp float aAxisSelect;
in highp vec4 aStops;
in highp vec4 aColor0;
in highp vec4 aColor1;
in highp vec4 aColor2;
in highp vec4 aColor3;
in highp vec2 aStartStop;
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
  tmpvar_1.xy = (aTaskRect.xy + (aTaskRect.zw * aPosition));
  gl_Position = (uTransform * tmpvar_1);
}

