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
  vec2 input_1_task_task_rect_p0_1;
  vec2 input_1_task_task_rect_size_2;
  ivec2 tmpvar_3;
  tmpvar_3.x = int((2u * (
    uint(aFilterRenderTaskAddress)
   % 512u)));
  tmpvar_3.y = int((uint(aFilterRenderTaskAddress) / 512u));
  vec4 tmpvar_4;
  tmpvar_4 = texelFetchOffset (sRenderTasks, tmpvar_3, 0, ivec2(0, 0));
  vec4 tmpvar_5;
  tmpvar_5 = texelFetchOffset (sRenderTasks, tmpvar_3, 0, ivec2(1, 0));
  vec3 tmpvar_6;
  tmpvar_6 = tmpvar_5.yzw;
  vec2 tmpvar_7;
  tmpvar_7 = (tmpvar_4.xy + (tmpvar_4.zw * aPosition));
  if ((0 < aFilterInputCount)) {
    vec2 tmpvar_8;
    tmpvar_8 = vec2(textureSize (sColor0, 0).xy);
    ivec2 tmpvar_9;
    tmpvar_9.x = int((2u * (
      uint(aFilterInput1TaskAddress)
     % 512u)));
    tmpvar_9.y = int((uint(aFilterInput1TaskAddress) / 512u));
    vec4 tmpvar_10;
    tmpvar_10 = texelFetchOffset (sRenderTasks, tmpvar_9, 0, ivec2(0, 0));
    input_1_task_task_rect_p0_1 = tmpvar_10.xy;
    input_1_task_task_rect_size_2 = tmpvar_10.zw;
    vec4 tmpvar_11;
    tmpvar_11.xy = (tmpvar_10.xy + vec2(0.5, 0.5));
    tmpvar_11.zw = ((tmpvar_10.xy + tmpvar_10.zw) - vec2(0.5, 0.5));
    vInput1UvRect = (tmpvar_11 / tmpvar_8.xyxy);
    vec3 uv_12;
    vec3 tmpvar_13;
    tmpvar_13.xy = vec2(0.0, 0.0);
    tmpvar_13.z = texelFetchOffset (sRenderTasks, tmpvar_9, 0, ivec2(1, 0)).x;
    uv_12.z = tmpvar_13.z;
    uv_12.xy = mix ((tmpvar_10.xy / tmpvar_8), (floor(
      (tmpvar_10.xy + tmpvar_10.zw)
    ) / tmpvar_8), aPosition);
    vInput1Uv = uv_12;
  };
  if ((1 < aFilterInputCount)) {
    vec2 tmpvar_14;
    tmpvar_14 = vec2(textureSize (sColor1, 0).xy);
    ivec2 tmpvar_15;
    tmpvar_15.x = int((2u * (
      uint(aFilterInput2TaskAddress)
     % 512u)));
    tmpvar_15.y = int((uint(aFilterInput2TaskAddress) / 512u));
    vec4 tmpvar_16;
    tmpvar_16 = texelFetchOffset (sRenderTasks, tmpvar_15, 0, ivec2(0, 0));
    vec4 tmpvar_17;
    tmpvar_17.xy = (tmpvar_16.xy + vec2(0.5, 0.5));
    tmpvar_17.zw = ((tmpvar_16.xy + tmpvar_16.zw) - vec2(0.5, 0.5));
    vInput2UvRect = (tmpvar_17 / tmpvar_14.xyxy);
    vec3 uv_18;
    vec3 tmpvar_19;
    tmpvar_19.xy = vec2(0.0, 0.0);
    tmpvar_19.z = texelFetchOffset (sRenderTasks, tmpvar_15, 0, ivec2(1, 0)).x;
    uv_18.z = tmpvar_19.z;
    uv_18.xy = mix ((tmpvar_16.xy / tmpvar_14), (floor(
      (tmpvar_16.xy + tmpvar_16.zw)
    ) / tmpvar_14), aPosition);
    vInput2Uv = uv_18;
  };
  vFilterInputCount = aFilterInputCount;
  vFilterKind = aFilterKind;
  vFuncs[0] = ((aFilterGenericInt >> 12) & 15);
  vFuncs[1] = ((aFilterGenericInt >> 8) & 15);
  vFuncs[2] = ((aFilterGenericInt >> 4) & 15);
  vFuncs[3] = (aFilterGenericInt & 15);
  bool tmpvar_20;
  tmpvar_20 = bool(0);
  while (true) {
    tmpvar_20 = (tmpvar_20 || (0 == aFilterKind));
    if (tmpvar_20) {
      ivec4 tmpvar_21;
      tmpvar_21.yzw = ivec3(0, 0, 0);
      tmpvar_21.x = aFilterGenericInt;
      vData = tmpvar_21;
      break;
    };
    tmpvar_20 = (tmpvar_20 || (1 == aFilterKind));
    if (tmpvar_20) {
      vFilterData0 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
      break;
    };
    tmpvar_20 = (tmpvar_20 || (4 == aFilterKind));
    if (tmpvar_20) {
      vFloat0 = tmpvar_6.x;
      break;
    };
    tmpvar_20 = (tmpvar_20 || (5 == aFilterKind));
    if (tmpvar_20) {
      mat4 tmpvar_22;
      tmpvar_22[uint(0)] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(0, 0));
      tmpvar_22[1u] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(1, 0));
      tmpvar_22[2u] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(2, 0));
      tmpvar_22[3u] = texelFetchOffset (sGpuCache, aFilterExtraDataAddress, 0, ivec2(3, 0));
      vColorMat = tmpvar_22;
      vFilterData0 = texelFetch (sGpuCache, (aFilterExtraDataAddress + ivec2(4, 0)), 0);
      break;
    };
    tmpvar_20 = (tmpvar_20 || (6 == aFilterKind));
    if (tmpvar_20) {
      vFilterData0 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
      break;
    };
    tmpvar_20 = (tmpvar_20 || (7 == aFilterKind));
    if (tmpvar_20) {
      vec2 tmpvar_23;
      tmpvar_23 = vec2(textureSize (sColor0, 0).xy);
      vec4 tmpvar_24;
      tmpvar_24.zw = vec2(0.0, 0.0);
      tmpvar_24.xy = (-(tmpvar_5.yz) / tmpvar_23);
      vFilterData0 = tmpvar_24;
      vec4 tmpvar_25;
      tmpvar_25.xy = input_1_task_task_rect_p0_1;
      tmpvar_25.zw = (input_1_task_task_rect_p0_1 + input_1_task_task_rect_size_2);
      vFilterData1 = (tmpvar_25 / tmpvar_23.xyxy);
      break;
    };
    tmpvar_20 = (tmpvar_20 || (8 == aFilterKind));
    if (tmpvar_20) {
      ivec4 tmpvar_26;
      tmpvar_26.zw = ivec2(0, 0);
      tmpvar_26.xy = aFilterExtraDataAddress;
      vData = tmpvar_26;
      break;
    };
    tmpvar_20 = (tmpvar_20 || (10 == aFilterKind));
    if (tmpvar_20) {
      ivec4 tmpvar_27;
      tmpvar_27.yzw = ivec3(0, 0, 0);
      tmpvar_27.x = aFilterGenericInt;
      vData = tmpvar_27;
      if ((aFilterGenericInt == 6)) {
        vFilterData0 = texelFetch (sGpuCache, aFilterExtraDataAddress, 0);
      };
      break;
    };
    tmpvar_20 = bool(1);
    break;
  };
  vec4 tmpvar_28;
  tmpvar_28.zw = vec2(0.0, 1.0);
  tmpvar_28.xy = tmpvar_7;
  gl_Position = (uTransform * tmpvar_28);
}

