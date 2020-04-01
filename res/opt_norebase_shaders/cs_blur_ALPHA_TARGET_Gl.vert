#version 150
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sRenderTasks;
uniform sampler2DArray sPrevPassAlpha;
out vec3 vUv;
flat out vec4 vUvRect;
flat out vec2 vOffsetScale;
flat out float vSigma;
flat out int vSupport;
in int aBlurRenderTaskAddress;
in int aBlurSourceTaskAddress;
in int aBlurDirection;
void main ()
{
  ivec2 tmpvar_1;
  uint tmpvar_2;
  tmpvar_2 = uint(aBlurRenderTaskAddress);
  tmpvar_1.x = int((2u * (tmpvar_2 % 512u)));
  tmpvar_1.y = int((tmpvar_2 / 512u));
  vec4 tmpvar_3;
  tmpvar_3 = texelFetchOffset (sRenderTasks, tmpvar_1, 0, ivec2(0, 0));
  vec4 tmpvar_4;
  tmpvar_4 = texelFetchOffset (sRenderTasks, tmpvar_1, 0, ivec2(1, 0));
  ivec2 tmpvar_5;
  uint tmpvar_6;
  tmpvar_6 = uint(aBlurSourceTaskAddress);
  tmpvar_5.x = int((2u * (tmpvar_6 % 512u)));
  tmpvar_5.y = int((tmpvar_6 / 512u));
  vec4 tmpvar_7;
  tmpvar_7 = texelFetchOffset (sRenderTasks, tmpvar_5, 0, ivec2(0, 0));
  vec2 tmpvar_8;
  tmpvar_8 = vec2(textureSize (sPrevPassAlpha, 0).xy);
  vUv.z = texelFetchOffset (sRenderTasks, tmpvar_5, 0, ivec2(1, 0)).x;
  vSigma = tmpvar_4.y;
  vSupport = (int(ceil(
    (1.5 * tmpvar_4.y)
  )) * 2);
  bool tmpvar_9;
  tmpvar_9 = bool(0);
  bool tmpvar_10;
  tmpvar_10 = bool(0);
  if ((0 == aBlurDirection)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    vec2 tmpvar_11;
    tmpvar_11.y = 0.0;
    tmpvar_11.x = (1.0/(tmpvar_8.x));
    vOffsetScale = tmpvar_11;
    tmpvar_10 = bool(1);
  };
  if ((1 == aBlurDirection)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    vec2 tmpvar_12;
    tmpvar_12.x = 0.0;
    tmpvar_12.y = (1.0/(tmpvar_8.y));
    vOffsetScale = tmpvar_12;
    tmpvar_10 = bool(1);
  };
  tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    vOffsetScale = vec2(0.0, 0.0);
  };
  vec4 tmpvar_13;
  tmpvar_13.xy = (tmpvar_7.xy + vec2(0.5, 0.5));
  tmpvar_13.zw = ((tmpvar_7.xy + tmpvar_4.zw) - vec2(0.5, 0.5));
  vUvRect = (tmpvar_13 / tmpvar_8.xyxy);
  vUv.xy = mix ((tmpvar_7.xy / tmpvar_8), ((tmpvar_7.xy + tmpvar_7.zw) / tmpvar_8), aPosition);
  vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 1.0);
  tmpvar_14.xy = (tmpvar_3.xy + (tmpvar_3.zw * aPosition));
  gl_Position = (uTransform * tmpvar_14);
}

