#version 150
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
out vec2 vLocalPos;
out vec3 vUv_Y;
flat out vec4 vUvBounds_Y;
out vec3 vUv_U;
flat out vec4 vUvBounds_U;
out vec3 vUv_V;
flat out vec4 vUvBounds_V;
flat out float vCoefficient;
flat out mat3 vYuvColorMatrix;
flat out int vFormat;
void main ()
{
  int tmpvar_1;
  int tmpvar_2;
  int tmpvar_3;
  int tmpvar_4;
  tmpvar_1 = (aData.y >> 16);
  tmpvar_2 = (aData.y & 65535);
  tmpvar_3 = (aData.z & 65535);
  tmpvar_4 = (aData.z >> 16);
  float tmpvar_5;
  ivec2 tmpvar_6;
  uint tmpvar_7;
  tmpvar_7 = uint(aData.x);
  tmpvar_6.x = int((2u * (tmpvar_7 % 512u)));
  tmpvar_6.y = int((tmpvar_7 / 512u));
  vec4 tmpvar_8;
  tmpvar_8 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_6, 0, ivec2(0, 0));
  vec4 tmpvar_9;
  tmpvar_9 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_6, 0, ivec2(1, 0));
  vec2 tmpvar_10;
  vec2 tmpvar_11;
  tmpvar_10 = tmpvar_8.xy;
  tmpvar_11 = tmpvar_8.zw;
  ivec2 tmpvar_12;
  tmpvar_12.x = int((2u * (tmpvar_7 % 512u)));
  tmpvar_12.y = int((tmpvar_7 / 512u));
  ivec4 tmpvar_13;
  tmpvar_13 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_12, 0, ivec2(0, 0));
  ivec4 tmpvar_14;
  tmpvar_14 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_12, 0, ivec2(1, 0));
  tmpvar_5 = float(tmpvar_13.x);
  mat4 tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = ((tmpvar_13.z >> 24) == 0);
  int tmpvar_17;
  tmpvar_17 = (tmpvar_13.z & 16777215);
  ivec2 tmpvar_18;
  tmpvar_18.x = int((8u * (
    uint(tmpvar_17)
   % 128u)));
  tmpvar_18.y = int((uint(tmpvar_17) / 128u));
  tmpvar_15[0] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(0, 0));
  tmpvar_15[1] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(1, 0));
  tmpvar_15[2] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(2, 0));
  tmpvar_15[3] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(3, 0));
  ivec2 tmpvar_19;
  tmpvar_19.x = int((2u * (
    uint(tmpvar_1)
   % 512u)));
  tmpvar_19.y = int((uint(tmpvar_1) / 512u));
  vec4 tmpvar_20;
  tmpvar_20 = texelFetchOffset (sRenderTasks, tmpvar_19, 0, ivec2(0, 0));
  vec4 tmpvar_21;
  tmpvar_21 = texelFetchOffset (sRenderTasks, tmpvar_19, 0, ivec2(1, 0));
  RectWithSize tmpvar_22;
  float tmpvar_23;
  float tmpvar_24;
  vec2 tmpvar_25;
  if ((tmpvar_2 >= 32767)) {
    tmpvar_22 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_23 = 0.0;
    tmpvar_24 = 0.0;
    tmpvar_25 = vec2(0.0, 0.0);
  } else {
    ivec2 tmpvar_26;
    tmpvar_26.x = int((2u * (
      uint(tmpvar_2)
     % 512u)));
    tmpvar_26.y = int((uint(tmpvar_2) / 512u));
    vec4 tmpvar_27;
    tmpvar_27 = texelFetchOffset (sRenderTasks, tmpvar_26, 0, ivec2(0, 0));
    vec4 tmpvar_28;
    tmpvar_28 = texelFetchOffset (sRenderTasks, tmpvar_26, 0, ivec2(1, 0));
    vec3 tmpvar_29;
    tmpvar_29 = tmpvar_28.yzw;
    tmpvar_22.p0 = tmpvar_27.xy;
    tmpvar_22.size = tmpvar_27.zw;
    tmpvar_23 = tmpvar_28.x;
    tmpvar_24 = tmpvar_29.x;
    tmpvar_25 = tmpvar_29.yz;
  };
  vec2 tmpvar_30;
  vec4 tmpvar_31;
  vec2 tmpvar_32;
  vec2 tmpvar_33;
  int tmpvar_34;
  tmpvar_34 = (tmpvar_4 & 255);
  if ((tmpvar_3 == 65535)) {
    tmpvar_32 = tmpvar_10;
    tmpvar_33 = tmpvar_11;
  } else {
    int tmpvar_35;
    tmpvar_35 = ((tmpvar_13.y + 1) + (tmpvar_3 * 2));
    ivec2 tmpvar_36;
    tmpvar_36.x = int((uint(tmpvar_35) % 1024u));
    tmpvar_36.y = int((uint(tmpvar_35) / 1024u));
    vec4 tmpvar_37;
    tmpvar_37 = texelFetchOffset (sGpuCache, tmpvar_36, 0, ivec2(0, 0));
    tmpvar_33 = tmpvar_37.zw;
    tmpvar_32 = (tmpvar_37.xy + tmpvar_8.xy);
  };
  if (tmpvar_16) {
    vec2 tmpvar_38;
    tmpvar_38 = clamp ((tmpvar_32 + (tmpvar_33 * aPosition)), tmpvar_9.xy, (tmpvar_9.xy + tmpvar_9.zw));
    vec4 tmpvar_39;
    tmpvar_39.zw = vec2(0.0, 1.0);
    tmpvar_39.xy = tmpvar_38;
    vec4 tmpvar_40;
    tmpvar_40 = (tmpvar_15 * tmpvar_39);
    vec4 tmpvar_41;
    tmpvar_41.xy = ((tmpvar_40.xy * tmpvar_21.y) + ((
      -(tmpvar_21.zw)
     + tmpvar_20.xy) * tmpvar_40.w));
    tmpvar_41.z = (tmpvar_5 * tmpvar_40.w);
    tmpvar_41.w = tmpvar_40.w;
    gl_Position = (uTransform * tmpvar_41);
    tmpvar_30 = tmpvar_38;
    tmpvar_31 = tmpvar_40;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    vec4 tmpvar_42;
    tmpvar_42 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_34 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 tmpvar_43;
    tmpvar_43 = (tmpvar_9.xy + tmpvar_9.zw);
    vec4 tmpvar_44;
    tmpvar_44 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_42);
    vec2 tmpvar_45;
    tmpvar_45 = ((tmpvar_32 - tmpvar_44.xy) + ((tmpvar_33 + 
      (tmpvar_44.xy + tmpvar_44.zw)
    ) * aPosition));
    vec4 tmpvar_46;
    tmpvar_46.zw = vec2(0.0, 1.0);
    tmpvar_46.xy = tmpvar_45;
    vec4 tmpvar_47;
    tmpvar_47 = (tmpvar_15 * tmpvar_46);
    vec4 tmpvar_48;
    tmpvar_48.xy = ((tmpvar_47.xy * tmpvar_21.y) + ((tmpvar_20.xy - tmpvar_21.zw) * tmpvar_47.w));
    tmpvar_48.z = (tmpvar_5 * tmpvar_47.w);
    tmpvar_48.w = tmpvar_47.w;
    gl_Position = (uTransform * tmpvar_48);
    vec4 tmpvar_49;
    tmpvar_49.xy = clamp (tmpvar_8.xy, tmpvar_9.xy, tmpvar_43);
    tmpvar_49.zw = clamp ((tmpvar_8.xy + tmpvar_8.zw), tmpvar_9.xy, tmpvar_43);
    vec4 tmpvar_50;
    tmpvar_50.xy = clamp (tmpvar_32, tmpvar_9.xy, tmpvar_43);
    tmpvar_50.zw = clamp ((tmpvar_32 + tmpvar_33), tmpvar_9.xy, tmpvar_43);
    vTransformBounds = mix (tmpvar_49, tmpvar_50, tmpvar_42);
    tmpvar_30 = tmpvar_45;
    tmpvar_31 = tmpvar_47;
  };
  vec4 tmpvar_51;
  tmpvar_51.xy = tmpvar_22.p0;
  tmpvar_51.zw = (tmpvar_22.p0 + tmpvar_22.size);
  vClipMaskUvBounds = tmpvar_51;
  vec4 tmpvar_52;
  tmpvar_52.xy = ((tmpvar_31.xy * tmpvar_24) + (tmpvar_31.w * (tmpvar_22.p0 - tmpvar_25)));
  tmpvar_52.z = tmpvar_23;
  tmpvar_52.w = tmpvar_31.w;
  vClipMaskUv = tmpvar_52;
  int tmpvar_53;
  vec2 f_54;
  f_54 = ((tmpvar_30 - tmpvar_8.xy) / tmpvar_8.zw);
  ivec2 tmpvar_55;
  tmpvar_55.x = int((uint(tmpvar_13.y) % 1024u));
  tmpvar_55.y = int((uint(tmpvar_13.y) / 1024u));
  vec4 tmpvar_56;
  tmpvar_56 = texelFetch (sGpuCache, tmpvar_55, 0);
  tmpvar_53 = int(tmpvar_56.z);
  vCoefficient = tmpvar_56.x;
  int color_space_57;
  color_space_57 = int(tmpvar_56.y);
  mat3 tmpvar_58;
  bool tmpvar_59;
  tmpvar_59 = bool(0);
  if ((0 == color_space_57)) tmpvar_59 = bool(1);
  if (tmpvar_59) {
    tmpvar_58 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.39176, 2.01723, 1.59603, -0.81297, 0.0);
  } else {
    if ((1 == color_space_57)) tmpvar_59 = bool(1);
    if (tmpvar_59) {
      tmpvar_58 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.21325, 2.1124, 1.79274, -0.53291, 0.0);
    } else {
      tmpvar_59 = bool(1);
      tmpvar_58 = mat3(1.164384, 1.164384, 1.164384, 0.0, -0.1873261, 2.141772, 1.678674, -0.6504243, 0.0);
    };
  };
  vYuvColorMatrix = tmpvar_58;
  vFormat = tmpvar_53;
  vLocalPos = tmpvar_30;
  if ((tmpvar_53 == 1)) {
    ivec2 tmpvar_60;
    tmpvar_60.x = int((uint(tmpvar_14.x) % 1024u));
    tmpvar_60.y = int((uint(tmpvar_14.x) / 1024u));
    vec4 tmpvar_61;
    tmpvar_61 = texelFetchOffset (sGpuCache, tmpvar_60, 0, ivec2(0, 0));
    ivec2 tmpvar_62;
    tmpvar_62.x = int((uint(tmpvar_14.y) % 1024u));
    tmpvar_62.y = int((uint(tmpvar_14.y) / 1024u));
    vec4 tmpvar_63;
    tmpvar_63 = texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(0, 0));
    ivec2 tmpvar_64;
    tmpvar_64.x = int((uint(tmpvar_14.z) % 1024u));
    tmpvar_64.y = int((uint(tmpvar_14.z) / 1024u));
    vec4 tmpvar_65;
    tmpvar_65 = texelFetchOffset (sGpuCache, tmpvar_64, 0, ivec2(0, 0));
    vec3 uv_66;
    uv_66.xy = mix (tmpvar_61.xy, tmpvar_61.zw, f_54);
    uv_66.z = texelFetchOffset (sGpuCache, tmpvar_60, 0, ivec2(1, 0)).x;
    vec4 tmpvar_67;
    tmpvar_67.xy = (tmpvar_61.xy + vec2(0.5, 0.5));
    tmpvar_67.zw = (tmpvar_61.zw - vec2(0.5, 0.5));
    vUv_Y = uv_66;
    vUvBounds_Y = tmpvar_67;
    vec3 uv_68;
    uv_68.xy = mix (tmpvar_63.xy, tmpvar_63.zw, f_54);
    uv_68.z = texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(1, 0)).x;
    vec4 tmpvar_69;
    tmpvar_69.xy = (tmpvar_63.xy + vec2(0.5, 0.5));
    tmpvar_69.zw = (tmpvar_63.zw - vec2(0.5, 0.5));
    vUv_U = uv_68;
    vUvBounds_U = tmpvar_69;
    vec3 uv_70;
    uv_70.xy = mix (tmpvar_65.xy, tmpvar_65.zw, f_54);
    uv_70.z = texelFetchOffset (sGpuCache, tmpvar_64, 0, ivec2(1, 0)).x;
    vec4 tmpvar_71;
    tmpvar_71.xy = (tmpvar_65.xy + vec2(0.5, 0.5));
    tmpvar_71.zw = (tmpvar_65.zw - vec2(0.5, 0.5));
    vUv_V = uv_70;
    vUvBounds_V = tmpvar_71;
  } else {
    if ((tmpvar_53 == 0)) {
      ivec2 tmpvar_72;
      tmpvar_72.x = int((uint(tmpvar_14.x) % 1024u));
      tmpvar_72.y = int((uint(tmpvar_14.x) / 1024u));
      vec4 tmpvar_73;
      tmpvar_73 = texelFetchOffset (sGpuCache, tmpvar_72, 0, ivec2(0, 0));
      ivec2 tmpvar_74;
      tmpvar_74.x = int((uint(tmpvar_14.y) % 1024u));
      tmpvar_74.y = int((uint(tmpvar_14.y) / 1024u));
      vec4 tmpvar_75;
      tmpvar_75 = texelFetchOffset (sGpuCache, tmpvar_74, 0, ivec2(0, 0));
      vec3 uv_76;
      uv_76.xy = mix (tmpvar_73.xy, tmpvar_73.zw, f_54);
      uv_76.z = texelFetchOffset (sGpuCache, tmpvar_72, 0, ivec2(1, 0)).x;
      vec4 tmpvar_77;
      tmpvar_77.xy = (tmpvar_73.xy + vec2(0.5, 0.5));
      tmpvar_77.zw = (tmpvar_73.zw - vec2(0.5, 0.5));
      vUv_Y = uv_76;
      vUvBounds_Y = tmpvar_77;
      vec3 uv_78;
      uv_78.xy = mix (tmpvar_75.xy, tmpvar_75.zw, f_54);
      uv_78.z = texelFetchOffset (sGpuCache, tmpvar_74, 0, ivec2(1, 0)).x;
      vec4 tmpvar_79;
      tmpvar_79.xy = (tmpvar_75.xy + vec2(0.5, 0.5));
      tmpvar_79.zw = (tmpvar_75.zw - vec2(0.5, 0.5));
      vUv_U = uv_78;
      vUvBounds_U = tmpvar_79;
    } else {
      if ((tmpvar_53 == 2)) {
        ivec2 tmpvar_80;
        tmpvar_80.x = int((uint(tmpvar_14.x) % 1024u));
        tmpvar_80.y = int((uint(tmpvar_14.x) / 1024u));
        vec4 tmpvar_81;
        tmpvar_81 = texelFetchOffset (sGpuCache, tmpvar_80, 0, ivec2(0, 0));
        vec3 uv_82;
        uv_82.xy = mix (tmpvar_81.xy, tmpvar_81.zw, f_54);
        uv_82.z = texelFetchOffset (sGpuCache, tmpvar_80, 0, ivec2(1, 0)).x;
        vec4 tmpvar_83;
        tmpvar_83.xy = (tmpvar_81.xy + vec2(0.5, 0.5));
        tmpvar_83.zw = (tmpvar_81.zw - vec2(0.5, 0.5));
        vUv_Y = uv_82;
        vUvBounds_Y = tmpvar_83;
      };
    };
  };
}

