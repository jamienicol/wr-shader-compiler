#version 300 es
precision highp sampler2DArray;
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2DArray sPrevPassAlpha;
out highp vec3 vUv;
flat out highp vec4 vUvRect;
flat out highp vec2 vOffsetScale;
flat out highp float vSigma;
flat out highp int vSupport;
in highp int aBlurRenderTaskAddress;
in highp int aBlurSourceTaskAddress;
in highp int aBlurDirection;
void main ()
{
  ivec2 tmpvar_1;
  tmpvar_1.x = int((2u * (
    uint(aBlurRenderTaskAddress)
   % 512u)));
  tmpvar_1.y = int((uint(aBlurRenderTaskAddress) / 512u));
  vec4 tmpvar_2;
  tmpvar_2 = texelFetch (sRenderTasks, tmpvar_1, 0);
  vec4 tmpvar_3;
  tmpvar_3 = texelFetch (sRenderTasks, (tmpvar_1 + ivec2(1, 0)), 0);
  ivec2 tmpvar_4;
  tmpvar_4.x = int((2u * (
    uint(aBlurSourceTaskAddress)
   % 512u)));
  tmpvar_4.y = int((uint(aBlurSourceTaskAddress) / 512u));
  vec4 tmpvar_5;
  tmpvar_5 = texelFetch (sRenderTasks, tmpvar_4, 0);
  vec2 tmpvar_6;
  tmpvar_6 = vec2(textureSize (sPrevPassAlpha, 0).xy);
  vUv.z = texelFetch (sRenderTasks, (tmpvar_4 + ivec2(1, 0)), 0).x;
  vSigma = tmpvar_3.y;
  vSupport = (int(ceil(
    (1.5 * tmpvar_3.y)
  )) * 2);
  bool tmpvar_7;
  tmpvar_7 = bool(0);
  while (true) {
    tmpvar_7 = (tmpvar_7 || (0 == aBlurDirection));
    if (tmpvar_7) {
      vec2 tmpvar_8;
      tmpvar_8.y = 0.0;
      tmpvar_8.x = (1.0/(tmpvar_6.x));
      vOffsetScale = tmpvar_8;
      break;
    };
    tmpvar_7 = (tmpvar_7 || (1 == aBlurDirection));
    if (tmpvar_7) {
      vec2 tmpvar_9;
      tmpvar_9.x = 0.0;
      tmpvar_9.y = (1.0/(tmpvar_6.y));
      vOffsetScale = tmpvar_9;
      break;
    };
    tmpvar_7 = bool(1);
    vOffsetScale = vec2(0.0, 0.0);
    break;
  };
  vec4 tmpvar_10;
  tmpvar_10.xy = (tmpvar_5.xy + vec2(0.5, 0.5));
  tmpvar_10.zw = ((tmpvar_5.xy + tmpvar_3.zw) - vec2(0.5, 0.5));
  vUvRect = (tmpvar_10 / tmpvar_6.xyxy);
  vUv.xy = mix ((tmpvar_5.xy / tmpvar_6), ((tmpvar_5.xy + tmpvar_5.zw) / tmpvar_6), aPosition);
  vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 1.0);
  tmpvar_11.xy = (tmpvar_2.xy + (tmpvar_2.zw * aPosition));
  gl_Position = (uTransform * tmpvar_11);
}

