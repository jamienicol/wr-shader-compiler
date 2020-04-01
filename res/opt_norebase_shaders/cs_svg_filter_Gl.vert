#version 150
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2DArray sColor0;
uniform sampler2DArray sColor1;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
out vec3 vInput1Uv;
out vec3 vInput2Uv;
flat out vec4 vInput1UvRect;
flat out vec4 vInput2UvRect;
flat out int vFilterInputCount;
flat out int vFilterKind;
flat out ivec4 vData;
flat out vec4 vFilterData0;
flat out vec4 vFilterData1;
flat out float vFloat0;
flat out mat4 vColorMat;
flat out int vFuncs[4];
in int aFilterRenderTaskAddress;
in int aFilterInput1TaskAddress;
in int aFilterInput2TaskAddress;
in int aFilterKind;
in int aFilterInputCount;
in int aFilterGenericInt;
in ivec2 aFilterExtraDataAddress;
void main ()
{
  vec2 tmpvar_1;
  vec2 tmpvar_2;
  ivec2 tmpvar_3;
  uint tmpvar_4;
  tmpvar_4 = uint(aFilterRenderTaskAddress);
  tmpvar_3.x = int((2u * (tmpvar_4 % 512u)));
  tmpvar_3.y = int((tmpvar_4 / 512u));
  vec4 tmpvar_5;
  tmpvar_5 = texelFetchOffset (sRenderTasks, tmpvar_3, 0, ivec2(0, 0));
  vec4 tmpvar_6;
  tmpvar_6 = texelFetchOffset (sRenderTasks, tmpvar_3, 0, ivec2(1, 0));
  vec3 tmpvar_7;
  tmpvar_7 = tmpvar_6.yzw;
  vec2 tmpvar_8;
  tmpvar_8 = (tmpvar_5.xy + (tmpvar_5.zw * aPosition));
  if ((aFilterInputCount > 0)) {
    vec2 tmpvar_9;
    tmpvar_9 = vec2(textureSize (sColor0, 0).xy);
    ivec2 tmpvar_10;
    uint tmpvar_11;
    tmpvar_11 = uint(aFilterInput1TaskAddress);
    tmpvar_10.x = int((2u * (tmpvar_11 % 512u)));
    tmpvar_10.y = int((tmpvar_11 / 512u));
    vec4 tmpvar_12;
    tmpvar_12 = texelFetchOffset (sRenderTasks, tmpvar_10, 0, ivec2(0, 0));
    tmpvar_1 = tmpvar_12.xy;
    tmpvar_2 = tmpvar_12.zw;
    vec4 tmpvar_13;
    tmpvar_13.xy = (tmpvar_12.xy + vec2(0.5, 0.5));
    tmpvar_13.zw = ((tmpvar_12.xy + tmpvar_12.zw) - vec2(0.5, 0.5));
    vInput1UvRect = (tmpvar_13 / tmpvar_9.xyxy);
    vec3 uv_14;
    vec3 tmpvar_15;
    tmpvar_15.xy = vec2(0.0, 0.0);
    tmpvar_15.z = texelFetchOffset (sRenderTasks, tmpvar_10, 0, ivec2(1, 0)).x;
    uv_14.z = tmpvar_15.z;
    uv_14.xy = mix ((tmpvar_12.xy / tmpvar_9), (floor(
      (tmpvar_12.xy + tmpvar_12.zw)
    ) / tmpvar_9), aPosition);
    vInput1Uv = uv_14;
  };
  if ((aFilterInputCount > 1)) {
    vec2 tmpvar_16;
    tmpvar_16 = vec2(textureSize (sColor1, 0).xy);
    ivec2 tmpvar_17;
    uint tmpvar_18;
    tmpvar_18 = uint(aFilterInput2TaskAddress);
    tmpvar_17.x = int((2u * (tmpvar_18 % 512u)));
    tmpvar_17.y = int((tmpvar_18 / 512u));
    vec4 tmpvar_19;
    tmpvar_19 = texelFetchOffset (sRenderTasks, tmpvar_17, 0, ivec2(0, 0));
    vec4 tmpvar_20;
    tmpvar_20.xy = (tmpvar_19.xy + vec2(0.5, 0.5));
    tmpvar_20.zw = ((tmpvar_19.xy + tmpvar_19.zw) - vec2(0.5, 0.5));
    vInput2UvRect = (tmpvar_20 / tmpvar_16.xyxy);
    vec3 uv_21;
    vec3 tmpvar_22;
    tmpvar_22.xy = vec2(0.0, 0.0);
    tmpvar_22.z = texelFetchOffset (sRenderTasks, tmpvar_17, 0, ivec2(1, 0)).x;
    uv_21.z = tmpvar_22.z;
    uv_21.xy = mix ((tmpvar_19.xy / tmpvar_16), (floor(
      (tmpvar_19.xy + tmpvar_19.zw)
    ) / tmpvar_16), aPosition);
    vInput2Uv = uv_21;
  };
  vFilterInputCount = aFilterInputCount;
  vFilterKind = aFilterKind;
  vFuncs[0] = ((aFilterGenericInt >> 12) & 15);
  vFuncs[1] = ((aFilterGenericInt >> 8) & 15);
  vFuncs[2] = ((aFilterGenericInt >> 4) & 15);
  vFuncs[3] = (aFilterGenericInt & 15);
  bool tmpvar_23;
  tmpvar_23 = bool(0);
  bool tmpvar_24;
  tmpvar_24 = bool(0);
  if ((0 == aFilterKind)) tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    ivec4 tmpvar_25;
    tmpvar_25.yzw = ivec3(0, 0, 0);
    tmpvar_25.x = aFilterGenericInt;
    vData = tmpvar_25;
    tmpvar_24 = bool(1);
  };
  if ((1 == aFilterKind)) tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    vFilterData0 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
    tmpvar_24 = bool(1);
  };
  if ((4 == aFilterKind)) tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    vFloat0 = tmpvar_7.x;
    tmpvar_24 = bool(1);
  };
  if ((5 == aFilterKind)) tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    mat4 tmpvar_26;
    tmpvar_26[uint(0)] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(0, 0));
    tmpvar_26[1u] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(1, 0));
    tmpvar_26[2u] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(2, 0));
    tmpvar_26[3u] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(3, 0));
    vColorMat = tmpvar_26;
    vFilterData0 = texelFetch (sGpuCache, (aFilterExtraDataAddress + ivec2(4, 0)), 0);
    tmpvar_24 = bool(1);
  };
  if ((6 == aFilterKind)) tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    vFilterData0 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
    tmpvar_24 = bool(1);
  };
  if ((7 == aFilterKind)) tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    vec2 tmpvar_27;
    tmpvar_27 = vec2(textureSize (sColor0, 0).xy);
    vec4 tmpvar_28;
    tmpvar_28.zw = vec2(0.0, 0.0);
    tmpvar_28.xy = (-(tmpvar_6.yz) / tmpvar_27);
    vFilterData0 = tmpvar_28;
    vec4 tmpvar_29;
    tmpvar_29.xy = tmpvar_1;
    tmpvar_29.zw = (tmpvar_1 + tmpvar_2);
    vFilterData1 = (tmpvar_29 / tmpvar_27.xyxy);
    tmpvar_24 = bool(1);
  };
  if ((8 == aFilterKind)) tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    ivec4 tmpvar_30;
    tmpvar_30.zw = ivec2(0, 0);
    tmpvar_30.xy = aFilterExtraDataAddress;
    vData = tmpvar_30;
    tmpvar_24 = bool(1);
  };
  if ((10 == aFilterKind)) tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    ivec4 tmpvar_31;
    tmpvar_31.yzw = ivec3(0, 0, 0);
    tmpvar_31.x = aFilterGenericInt;
    vData = tmpvar_31;
    if ((aFilterGenericInt == 6)) {
      vFilterData0 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
    };
    tmpvar_24 = bool(1);
  };
  tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    tmpvar_24 = bool(1);
  };
  vec4 tmpvar_32;
  tmpvar_32.zw = vec2(0.0, 1.0);
  tmpvar_32.xy = tmpvar_8;
  gl_Position = (uTransform * tmpvar_32);
}

