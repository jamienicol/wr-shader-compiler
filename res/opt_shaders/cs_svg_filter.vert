#version 300 es
precision highp sampler2DArray;
uniform mat4 uTransform;
in vec3 aPosition;
uniform sampler2DArray sColor0;
uniform sampler2DArray sColor1;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
out lowp vec3 vInput1Uv;
out lowp vec3 vInput2Uv;
flat out lowp vec4 vInput1UvRect;
flat out lowp vec4 vInput2UvRect;
flat out highp int vFilterInputCount;
flat out highp int vFilterKind;
flat out highp ivec4 vData;
flat out lowp vec4 vFilterData0;
flat out lowp vec4 vFilterData1;
flat out highp float vFloat0;
flat out highp mat4 vColorMat;
flat out int vFuncs[4];
in highp int aFilterRenderTaskAddress;
in highp int aFilterInput1TaskAddress;
in highp int aFilterInput2TaskAddress;
in highp int aFilterKind;
in highp int aFilterInputCount;
in highp int aFilterGenericInt;
in highp ivec2 aFilterExtraDataAddress;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp ivec2 tmpvar_3;
  highp uint tmpvar_4;
  tmpvar_4 = uint(aFilterRenderTaskAddress);
  tmpvar_3.x = int((2u * (uint(mod (tmpvar_4, 512u)))));
  tmpvar_3.y = int((tmpvar_4 / 512u));
  highp vec4 tmpvar_5;
  tmpvar_5 = texelFetch (sRenderTasks, tmpvar_3, 0);
  highp vec4 tmpvar_6;
  tmpvar_6 = texelFetch (sRenderTasks, (tmpvar_3 + ivec2(1, 0)), 0);
  highp vec3 tmpvar_7;
  tmpvar_7 = tmpvar_6.yzw;
  highp vec2 tmpvar_8;
  tmpvar_8 = (tmpvar_5.xy + (tmpvar_5.zw * aPosition.xy));
  if ((aFilterInputCount > 0)) {
    lowp vec2 tmpvar_9;
    tmpvar_9 = vec2(textureSize (sColor0, 0).xy);
    highp ivec2 tmpvar_10;
    highp uint tmpvar_11;
    tmpvar_11 = uint(aFilterInput1TaskAddress);
    tmpvar_10.x = int((2u * (uint(mod (tmpvar_11, 512u)))));
    tmpvar_10.y = int((tmpvar_11 / 512u));
    highp vec4 tmpvar_12;
    tmpvar_12 = texelFetch (sRenderTasks, tmpvar_10, 0);
    tmpvar_1 = tmpvar_12.xy;
    tmpvar_2 = tmpvar_12.zw;
    lowp vec4 tmpvar_13;
    tmpvar_13.xy = (tmpvar_12.xy + vec2(0.5, 0.5));
    tmpvar_13.zw = ((tmpvar_12.xy + tmpvar_12.zw) - vec2(0.5, 0.5));
    vInput1UvRect = (tmpvar_13 / tmpvar_9.xyxy);
    lowp vec3 uv_14;
    highp vec3 tmpvar_15;
    tmpvar_15.xy = vec2(0.0, 0.0);
    tmpvar_15.z = texelFetch (sRenderTasks, (tmpvar_10 + ivec2(1, 0)), 0).x;
    uv_14.z = tmpvar_15.z;
    uv_14.xy = mix ((tmpvar_12.xy / tmpvar_9), (floor(
      (tmpvar_12.xy + tmpvar_12.zw)
    ) / tmpvar_9), aPosition.xy);
    vInput1Uv = uv_14;
  };
  if ((aFilterInputCount > 1)) {
    lowp vec2 tmpvar_16;
    tmpvar_16 = vec2(textureSize (sColor1, 0).xy);
    highp ivec2 tmpvar_17;
    highp uint tmpvar_18;
    tmpvar_18 = uint(aFilterInput2TaskAddress);
    tmpvar_17.x = int((2u * (uint(mod (tmpvar_18, 512u)))));
    tmpvar_17.y = int((tmpvar_18 / 512u));
    highp vec4 tmpvar_19;
    tmpvar_19 = texelFetch (sRenderTasks, tmpvar_17, 0);
    lowp vec4 tmpvar_20;
    tmpvar_20.xy = (tmpvar_19.xy + vec2(0.5, 0.5));
    tmpvar_20.zw = ((tmpvar_19.xy + tmpvar_19.zw) - vec2(0.5, 0.5));
    vInput2UvRect = (tmpvar_20 / tmpvar_16.xyxy);
    lowp vec3 uv_21;
    highp vec3 tmpvar_22;
    tmpvar_22.xy = vec2(0.0, 0.0);
    tmpvar_22.z = texelFetch (sRenderTasks, (tmpvar_17 + ivec2(1, 0)), 0).x;
    uv_21.z = tmpvar_22.z;
    uv_21.xy = mix ((tmpvar_19.xy / tmpvar_16), (floor(
      (tmpvar_19.xy + tmpvar_19.zw)
    ) / tmpvar_16), aPosition.xy);
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
    highp ivec4 tmpvar_25;
    tmpvar_25.yzw = ivec3(0, 0, 0);
    tmpvar_25.x = aFilterGenericInt;
    vData = tmpvar_25;
    tmpvar_24 = bool(1);
  };
  if ((1 == aFilterKind)) tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    highp vec4 tmpvar_26;
    tmpvar_26 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
    vFilterData0 = tmpvar_26;
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
    highp mat4 tmpvar_27;
    tmpvar_27[uint(0)] = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
    tmpvar_27[1u] = texelFetch (sGpuCache, (aFilterExtraDataAddress + ivec2(1, 0)), 0);
    tmpvar_27[2u] = texelFetch (sGpuCache, (aFilterExtraDataAddress + ivec2(2, 0)), 0);
    tmpvar_27[3u] = texelFetch (sGpuCache, (aFilterExtraDataAddress + ivec2(3, 0)), 0);
    vColorMat = tmpvar_27;
    highp vec4 tmpvar_28;
    tmpvar_28 = texelFetch (sGpuCache, (aFilterExtraDataAddress + ivec2(4, 0)), 0);
    vFilterData0 = tmpvar_28;
    tmpvar_24 = bool(1);
  };
  if ((6 == aFilterKind)) tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    highp vec4 tmpvar_29;
    tmpvar_29 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
    vFilterData0 = tmpvar_29;
    tmpvar_24 = bool(1);
  };
  if ((7 == aFilterKind)) tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    lowp vec2 tmpvar_30;
    lowp vec2 tmpvar_31;
    tmpvar_31 = vec2(textureSize (sColor0, 0).xy);
    lowp vec4 tmpvar_32;
    tmpvar_32.zw = vec2(0.0, 0.0);
    tmpvar_32.xy = (-(tmpvar_6.yz) / tmpvar_31);
    vFilterData0 = tmpvar_32;
    tmpvar_30 = tmpvar_1;
    lowp vec4 tmpvar_33;
    tmpvar_33.xy = tmpvar_30;
    tmpvar_33.zw = (tmpvar_30 + tmpvar_2);
    vFilterData1 = (tmpvar_33 / tmpvar_31.xyxy);
    tmpvar_24 = bool(1);
  };
  if ((8 == aFilterKind)) tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    highp ivec4 tmpvar_34;
    tmpvar_34.zw = ivec2(0, 0);
    tmpvar_34.xy = aFilterExtraDataAddress;
    vData = tmpvar_34;
    tmpvar_24 = bool(1);
  };
  if ((10 == aFilterKind)) tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    highp ivec4 tmpvar_35;
    tmpvar_35.yzw = ivec3(0, 0, 0);
    tmpvar_35.x = aFilterGenericInt;
    vData = tmpvar_35;
    if ((aFilterGenericInt == 6)) {
      highp vec4 tmpvar_36;
      tmpvar_36 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
      vFilterData0 = tmpvar_36;
    };
    tmpvar_24 = bool(1);
  };
  tmpvar_23 = bool(1);
  if (tmpvar_24) tmpvar_23 = bool(0);
  if (tmpvar_23) {
    tmpvar_24 = bool(1);
  };
  highp vec4 tmpvar_37;
  tmpvar_37.zw = vec2(0.0, 1.0);
  tmpvar_37.xy = tmpvar_8;
  gl_Position = (uTransform * tmpvar_37);
}

