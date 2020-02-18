#version 310 es
precision highp sampler2DArray;
uniform mat4 uTransform;
in vec3 aPosition;
uniform highp sampler2D sRenderTasks;
uniform sampler2DArray sPrevPassColor;
out lowp vec3 vUv;
flat out lowp vec4 vUvRect;
flat out lowp vec2 vOffsetScale;
flat out highp float vSigma;
flat out highp int vSupport;
in highp int aBlurRenderTaskAddress;
in highp int aBlurSourceTaskAddress;
in highp int aBlurDirection;
void main ()
{
  highp ivec2 tmpvar_1;
  highp uint tmpvar_2;
  tmpvar_2 = uint(aBlurRenderTaskAddress);
  tmpvar_1.x = int((2u * (uint(tmpvar_2 % 512u))));
  tmpvar_1.y = int((tmpvar_2 / 512u));
  highp vec4 tmpvar_3;
  tmpvar_3 = texelFetch (sRenderTasks, tmpvar_1, 0);
  highp vec4 tmpvar_4;
  tmpvar_4 = texelFetch (sRenderTasks, (tmpvar_1 + ivec2(1, 0)), 0);
  highp ivec2 tmpvar_5;
  highp uint tmpvar_6;
  tmpvar_6 = uint(aBlurSourceTaskAddress);
  tmpvar_5.x = int((2u * (uint(tmpvar_6 % 512u))));
  tmpvar_5.y = int((tmpvar_6 / 512u));
  highp vec4 tmpvar_7;
  tmpvar_7 = texelFetch (sRenderTasks, tmpvar_5, 0);
  highp float tmpvar_8;
  tmpvar_8 = texelFetch (sRenderTasks, (tmpvar_5 + ivec2(1, 0)), 0).x;
  lowp vec2 tmpvar_9;
  tmpvar_9 = vec2(textureSize (sPrevPassColor, 0).xy);
  vUv.z = tmpvar_8;
  vSigma = tmpvar_4.y;
  vSupport = (int(ceil(
    (1.5 * tmpvar_4.y)
  )) * 2);
  bool tmpvar_10;
  tmpvar_10 = bool(0);
  bool tmpvar_11;
  tmpvar_11 = bool(0);
  if ((0 == aBlurDirection)) tmpvar_10 = bool(1);
  if (tmpvar_11) tmpvar_10 = bool(0);
  if (tmpvar_10) {
    lowp vec2 tmpvar_12;
    tmpvar_12.y = 0.0;
    tmpvar_12.x = (1.0/(tmpvar_9.x));
    vOffsetScale = tmpvar_12;
    tmpvar_11 = bool(1);
  };
  if ((1 == aBlurDirection)) tmpvar_10 = bool(1);
  if (tmpvar_11) tmpvar_10 = bool(0);
  if (tmpvar_10) {
    lowp vec2 tmpvar_13;
    tmpvar_13.x = 0.0;
    tmpvar_13.y = (1.0/(tmpvar_9.y));
    vOffsetScale = tmpvar_13;
    tmpvar_11 = bool(1);
  };
  tmpvar_10 = bool(1);
  if (tmpvar_11) tmpvar_10 = bool(0);
  if (tmpvar_10) {
    vOffsetScale = vec2(0.0, 0.0);
  };
  lowp vec4 tmpvar_14;
  tmpvar_14.xy = (tmpvar_7.xy + vec2(0.5, 0.5));
  tmpvar_14.zw = ((tmpvar_7.xy + tmpvar_4.zw) - vec2(0.5, 0.5));
  vUvRect = (tmpvar_14 / tmpvar_9.xyxy);
  vUv.xy = mix ((tmpvar_7.xy / tmpvar_9), ((tmpvar_7.xy + tmpvar_7.zw) / tmpvar_9), aPosition.xy);
  highp vec4 tmpvar_15;
  tmpvar_15.zw = vec2(0.0, 1.0);
  tmpvar_15.xy = (tmpvar_3.xy + (tmpvar_3.zw * aPosition.xy));
  gl_Position = (uTransform * tmpvar_15);
}

