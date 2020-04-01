#version 300 es
precision highp sampler2DArray;
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2DArray sColor0;
out lowp vec3 vUv;
flat out lowp vec4 vUvRect;
in vec4 aScaleTargetRect;
in highp ivec4 aScaleSourceRect;
in highp int aScaleSourceLayer;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = vec2(aScaleSourceRect.xy);
  vec2 tmpvar_2;
  tmpvar_2 = vec2(aScaleSourceRect.zw);
  lowp vec2 tmpvar_3;
  tmpvar_3 = vec2(textureSize (sColor0, 0).xy);
  vUv.z = float(aScaleSourceLayer);
  vec4 tmpvar_4;
  tmpvar_4.xy = (tmpvar_1 + vec2(0.5, 0.5));
  tmpvar_4.zw = ((tmpvar_1 + tmpvar_2) - vec2(0.5, 0.5));
  vUvRect = (tmpvar_4 / tmpvar_3.xyxy);
  vUv.xy = ((tmpvar_1 + (tmpvar_2 * aPosition)) / tmpvar_3);
  vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 1.0);
  tmpvar_5.xy = (aScaleTargetRect.xy + (aScaleTargetRect.zw * aPosition));
  gl_Position = (uTransform * tmpvar_5);
}

