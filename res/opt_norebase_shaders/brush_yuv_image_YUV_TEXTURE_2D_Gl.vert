#version 150
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sColor2;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
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
  tmpvar_1 = (aData.y >> 16);
  tmpvar_2 = (aData.z & 65535);
  float tmpvar_3;
  ivec2 tmpvar_4;
  uint tmpvar_5;
  tmpvar_5 = uint(aData.x);
  tmpvar_4.x = int((2u * (tmpvar_5 % 512u)));
  tmpvar_4.y = int((tmpvar_5 / 512u));
  vec4 tmpvar_6;
  tmpvar_6 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_4, 0, ivec2(0, 0));
  vec4 tmpvar_7;
  tmpvar_7 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_4, 0, ivec2(1, 0));
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  tmpvar_8 = tmpvar_6.xy;
  tmpvar_9 = tmpvar_6.zw;
  ivec2 tmpvar_10;
  tmpvar_10.x = int((2u * (tmpvar_5 % 512u)));
  tmpvar_10.y = int((tmpvar_5 / 512u));
  ivec4 tmpvar_11;
  tmpvar_11 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_10, 0, ivec2(0, 0));
  ivec4 tmpvar_12;
  tmpvar_12 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_10, 0, ivec2(1, 0));
  tmpvar_3 = float(tmpvar_11.x);
  mat4 tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = ((tmpvar_11.z >> 24) == 0);
  int tmpvar_15;
  tmpvar_15 = (tmpvar_11.z & 16777215);
  ivec2 tmpvar_16;
  tmpvar_16.x = int((8u * (
    uint(tmpvar_15)
   % 128u)));
  tmpvar_16.y = int((uint(tmpvar_15) / 128u));
  tmpvar_13[0] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(0, 0));
  tmpvar_13[1] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(1, 0));
  tmpvar_13[2] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(2, 0));
  tmpvar_13[3] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(3, 0));
  ivec2 tmpvar_17;
  tmpvar_17.x = int((2u * (
    uint(tmpvar_1)
   % 512u)));
  tmpvar_17.y = int((uint(tmpvar_1) / 512u));
  vec4 tmpvar_18;
  tmpvar_18 = texelFetchOffset (sRenderTasks, tmpvar_17, 0, ivec2(0, 0));
  vec4 tmpvar_19;
  tmpvar_19 = texelFetchOffset (sRenderTasks, tmpvar_17, 0, ivec2(1, 0));
  vec2 tmpvar_20;
  vec2 tmpvar_21;
  vec2 tmpvar_22;
  int tmpvar_23;
  tmpvar_23 = ((aData.z >> 16) & 255);
  if ((tmpvar_2 == 65535)) {
    tmpvar_21 = tmpvar_8;
    tmpvar_22 = tmpvar_9;
  } else {
    int tmpvar_24;
    tmpvar_24 = ((tmpvar_11.y + 1) + (tmpvar_2 * 2));
    ivec2 tmpvar_25;
    tmpvar_25.x = int((uint(tmpvar_24) % 1024u));
    tmpvar_25.y = int((uint(tmpvar_24) / 1024u));
    vec4 tmpvar_26;
    tmpvar_26 = texelFetchOffset (sGpuCache, tmpvar_25, 0, ivec2(0, 0));
    tmpvar_22 = tmpvar_26.zw;
    tmpvar_21 = (tmpvar_26.xy + tmpvar_6.xy);
  };
  if (tmpvar_14) {
    vec2 tmpvar_27;
    tmpvar_27 = clamp ((tmpvar_21 + (tmpvar_22 * aPosition)), tmpvar_7.xy, (tmpvar_7.xy + tmpvar_7.zw));
    vec4 tmpvar_28;
    tmpvar_28.zw = vec2(0.0, 1.0);
    tmpvar_28.xy = tmpvar_27;
    vec4 tmpvar_29;
    tmpvar_29 = (tmpvar_13 * tmpvar_28);
    vec4 tmpvar_30;
    tmpvar_30.xy = ((tmpvar_29.xy * tmpvar_19.y) + ((
      -(tmpvar_19.zw)
     + tmpvar_18.xy) * tmpvar_29.w));
    tmpvar_30.z = (tmpvar_3 * tmpvar_29.w);
    tmpvar_30.w = tmpvar_29.w;
    gl_Position = (uTransform * tmpvar_30);
    tmpvar_20 = tmpvar_27;
  } else {
    vec4 tmpvar_31;
    tmpvar_31 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_23 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 tmpvar_32;
    tmpvar_32 = (tmpvar_7.xy + tmpvar_7.zw);
    vec4 tmpvar_33;
    tmpvar_33 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_31);
    vec2 tmpvar_34;
    tmpvar_34 = ((tmpvar_21 - tmpvar_33.xy) + ((tmpvar_22 + 
      (tmpvar_33.xy + tmpvar_33.zw)
    ) * aPosition));
    vec4 tmpvar_35;
    tmpvar_35.zw = vec2(0.0, 1.0);
    tmpvar_35.xy = tmpvar_34;
    vec4 tmpvar_36;
    tmpvar_36 = (tmpvar_13 * tmpvar_35);
    vec4 tmpvar_37;
    tmpvar_37.xy = ((tmpvar_36.xy * tmpvar_19.y) + ((tmpvar_18.xy - tmpvar_19.zw) * tmpvar_36.w));
    tmpvar_37.z = (tmpvar_3 * tmpvar_36.w);
    tmpvar_37.w = tmpvar_36.w;
    gl_Position = (uTransform * tmpvar_37);
    vec4 tmpvar_38;
    tmpvar_38.xy = clamp (tmpvar_6.xy, tmpvar_7.xy, tmpvar_32);
    tmpvar_38.zw = clamp ((tmpvar_6.xy + tmpvar_6.zw), tmpvar_7.xy, tmpvar_32);
    vec4 tmpvar_39;
    tmpvar_39.xy = clamp (tmpvar_21, tmpvar_7.xy, tmpvar_32);
    tmpvar_39.zw = clamp ((tmpvar_21 + tmpvar_22), tmpvar_7.xy, tmpvar_32);
    vTransformBounds = mix (tmpvar_38, tmpvar_39, tmpvar_31);
    tmpvar_20 = tmpvar_34;
  };
  int tmpvar_40;
  vec2 f_41;
  f_41 = ((tmpvar_20 - tmpvar_6.xy) / tmpvar_6.zw);
  ivec2 tmpvar_42;
  tmpvar_42.x = int((uint(tmpvar_11.y) % 1024u));
  tmpvar_42.y = int((uint(tmpvar_11.y) / 1024u));
  vec4 tmpvar_43;
  tmpvar_43 = texelFetch (sGpuCache, tmpvar_42, 0);
  tmpvar_40 = int(tmpvar_43.z);
  vCoefficient = tmpvar_43.x;
  int color_space_44;
  color_space_44 = int(tmpvar_43.y);
  mat3 tmpvar_45;
  bool tmpvar_46;
  tmpvar_46 = bool(0);
  if ((0 == color_space_44)) tmpvar_46 = bool(1);
  if (tmpvar_46) {
    tmpvar_45 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.39176, 2.01723, 1.59603, -0.81297, 0.0);
  } else {
    if ((1 == color_space_44)) tmpvar_46 = bool(1);
    if (tmpvar_46) {
      tmpvar_45 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.21325, 2.1124, 1.79274, -0.53291, 0.0);
    } else {
      tmpvar_46 = bool(1);
      tmpvar_45 = mat3(1.164384, 1.164384, 1.164384, 0.0, -0.1873261, 2.141772, 1.678674, -0.6504243, 0.0);
    };
  };
  vYuvColorMatrix = tmpvar_45;
  vFormat = tmpvar_40;
  if ((tmpvar_40 == 1)) {
    ivec2 tmpvar_47;
    tmpvar_47.x = int((uint(tmpvar_12.x) % 1024u));
    tmpvar_47.y = int((uint(tmpvar_12.x) / 1024u));
    vec4 tmpvar_48;
    tmpvar_48 = texelFetchOffset (sGpuCache, tmpvar_47, 0, ivec2(0, 0));
    ivec2 tmpvar_49;
    tmpvar_49.x = int((uint(tmpvar_12.y) % 1024u));
    tmpvar_49.y = int((uint(tmpvar_12.y) / 1024u));
    vec4 tmpvar_50;
    tmpvar_50 = texelFetchOffset (sGpuCache, tmpvar_49, 0, ivec2(0, 0));
    ivec2 tmpvar_51;
    tmpvar_51.x = int((uint(tmpvar_12.z) % 1024u));
    tmpvar_51.y = int((uint(tmpvar_12.z) / 1024u));
    vec4 tmpvar_52;
    tmpvar_52 = texelFetchOffset (sGpuCache, tmpvar_51, 0, ivec2(0, 0));
    vec2 tmpvar_53;
    tmpvar_53 = vec2(textureSize (sColor0, 0));
    vec3 uv_54;
    uv_54.z = texelFetchOffset (sGpuCache, tmpvar_47, 0, ivec2(1, 0)).x;
    vec4 tmpvar_55;
    tmpvar_55.xy = (tmpvar_48.xy + vec2(0.5, 0.5));
    tmpvar_55.zw = (tmpvar_48.zw - vec2(0.5, 0.5));
    uv_54.xy = (mix (tmpvar_48.xy, tmpvar_48.zw, f_41) / tmpvar_53);
    vUv_Y = uv_54;
    vUvBounds_Y = (tmpvar_55 / tmpvar_53.xyxy);
    vec2 tmpvar_56;
    tmpvar_56 = vec2(textureSize (sColor1, 0));
    vec3 uv_57;
    uv_57.z = texelFetchOffset (sGpuCache, tmpvar_49, 0, ivec2(1, 0)).x;
    vec4 tmpvar_58;
    tmpvar_58.xy = (tmpvar_50.xy + vec2(0.5, 0.5));
    tmpvar_58.zw = (tmpvar_50.zw - vec2(0.5, 0.5));
    uv_57.xy = (mix (tmpvar_50.xy, tmpvar_50.zw, f_41) / tmpvar_56);
    vUv_U = uv_57;
    vUvBounds_U = (tmpvar_58 / tmpvar_56.xyxy);
    vec2 tmpvar_59;
    tmpvar_59 = vec2(textureSize (sColor2, 0));
    vec3 uv_60;
    uv_60.z = texelFetchOffset (sGpuCache, tmpvar_51, 0, ivec2(1, 0)).x;
    vec4 tmpvar_61;
    tmpvar_61.xy = (tmpvar_52.xy + vec2(0.5, 0.5));
    tmpvar_61.zw = (tmpvar_52.zw - vec2(0.5, 0.5));
    uv_60.xy = (mix (tmpvar_52.xy, tmpvar_52.zw, f_41) / tmpvar_59);
    vUv_V = uv_60;
    vUvBounds_V = (tmpvar_61 / tmpvar_59.xyxy);
  } else {
    if ((tmpvar_40 == 0)) {
      ivec2 tmpvar_62;
      tmpvar_62.x = int((uint(tmpvar_12.x) % 1024u));
      tmpvar_62.y = int((uint(tmpvar_12.x) / 1024u));
      vec4 tmpvar_63;
      tmpvar_63 = texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(0, 0));
      ivec2 tmpvar_64;
      tmpvar_64.x = int((uint(tmpvar_12.y) % 1024u));
      tmpvar_64.y = int((uint(tmpvar_12.y) / 1024u));
      vec4 tmpvar_65;
      tmpvar_65 = texelFetchOffset (sGpuCache, tmpvar_64, 0, ivec2(0, 0));
      vec2 tmpvar_66;
      tmpvar_66 = vec2(textureSize (sColor0, 0));
      vec3 uv_67;
      uv_67.z = texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(1, 0)).x;
      vec4 tmpvar_68;
      tmpvar_68.xy = (tmpvar_63.xy + vec2(0.5, 0.5));
      tmpvar_68.zw = (tmpvar_63.zw - vec2(0.5, 0.5));
      uv_67.xy = (mix (tmpvar_63.xy, tmpvar_63.zw, f_41) / tmpvar_66);
      vUv_Y = uv_67;
      vUvBounds_Y = (tmpvar_68 / tmpvar_66.xyxy);
      vec2 tmpvar_69;
      tmpvar_69 = vec2(textureSize (sColor1, 0));
      vec3 uv_70;
      uv_70.z = texelFetchOffset (sGpuCache, tmpvar_64, 0, ivec2(1, 0)).x;
      vec4 tmpvar_71;
      tmpvar_71.xy = (tmpvar_65.xy + vec2(0.5, 0.5));
      tmpvar_71.zw = (tmpvar_65.zw - vec2(0.5, 0.5));
      uv_70.xy = (mix (tmpvar_65.xy, tmpvar_65.zw, f_41) / tmpvar_69);
      vUv_U = uv_70;
      vUvBounds_U = (tmpvar_71 / tmpvar_69.xyxy);
    } else {
      if ((tmpvar_40 == 2)) {
        ivec2 tmpvar_72;
        tmpvar_72.x = int((uint(tmpvar_12.x) % 1024u));
        tmpvar_72.y = int((uint(tmpvar_12.x) / 1024u));
        vec4 tmpvar_73;
        tmpvar_73 = texelFetchOffset (sGpuCache, tmpvar_72, 0, ivec2(0, 0));
        vec2 tmpvar_74;
        tmpvar_74 = vec2(textureSize (sColor0, 0));
        vec3 uv_75;
        uv_75.z = texelFetchOffset (sGpuCache, tmpvar_72, 0, ivec2(1, 0)).x;
        vec4 tmpvar_76;
        tmpvar_76.xy = (tmpvar_73.xy + vec2(0.5, 0.5));
        tmpvar_76.zw = (tmpvar_73.zw - vec2(0.5, 0.5));
        uv_75.xy = (mix (tmpvar_73.xy, tmpvar_73.zw, f_41) / tmpvar_74);
        vUv_Y = uv_75;
        vUvBounds_Y = (tmpvar_76 / tmpvar_74.xyxy);
      };
    };
  };
}

