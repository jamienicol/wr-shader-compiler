#version 150
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sRenderTasks;
uniform sampler2DArray sPrevPassColor;
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
  tmpvar_1.x = int((2u * (
    uint(aBlurRenderTaskAddress)
   % 512u)));
  tmpvar_1.y = int((uint(aBlurRenderTaskAddress) / 512u));
  vec4 tmpvar_2;
  tmpvar_2 = texelFetchOffset (sRenderTasks, tmpvar_1, 0, ivec2(0, 0));
  vec4 tmpvar_3;
  tmpvar_3 = texelFetchOffset (sRenderTasks, tmpvar_1, 0, ivec2(1, 0));
  ivec2 tmpvar_4;
  tmpvar_4.x = int((2u * (
    uint(aBlurSourceTaskAddress)
   % 512u)));
  tmpvar_4.y = int((uint(aBlurSourceTaskAddress) / 512u));
  vec4 tmpvar_5;
  tmpvar_5 = texelFetchOffset (sRenderTasks, tmpvar_4, 0, ivec2(0, 0));
  vec2 tmpvar_6;
  tmpvar_6 = vec2(textureSize (sPrevPassColor, 0).xy);
  vUv.z = texelFetchOffset (sRenderTasks, tmpvar_4, 0, ivec2(1, 0)).x;
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

