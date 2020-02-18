#version 310 es
precision highp sampler2DArray;
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform mat4 uTransform;
in vec3 aPosition;
uniform sampler2DArray sColor0;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
flat out lowp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
flat out vec4 vClipMaskUvBounds;
out highp vec4 vClipMaskUv;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
flat out highp vec4 flat_varying_vec4_1;
flat out lowp vec4 flat_varying_vec4_2;
flat out highp vec4 flat_varying_vec4_3;
flat out highp vec4 flat_varying_vec4_4;
flat out highp ivec4 flat_varying_ivec4_0;
out lowp vec4 varying_vec4_0;
flat out highp mat4 vColorMat;
flat out highp int vFuncs[4];
void main ()
{
  lowp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp int tmpvar_5;
  highp int tmpvar_6;
  highp int tmpvar_7;
  highp int tmpvar_8;
  tmpvar_5 = (aData.y >> 16);
  tmpvar_6 = (aData.y & 65535);
  tmpvar_7 = (aData.z & 65535);
  tmpvar_8 = (aData.z >> 16);
  highp int tmpvar_9;
  tmpvar_9 = (tmpvar_8 & 255);
  highp int tmpvar_10;
  tmpvar_10 = ((tmpvar_8 >> 8) & 255);
  highp float tmpvar_11;
  highp ivec2 tmpvar_12;
  highp uint tmpvar_13;
  tmpvar_13 = uint(aData.x);
  tmpvar_12.x = int((2u * (uint(tmpvar_13 % 512u))));
  tmpvar_12.y = int((tmpvar_13 / 512u));
  highp vec4 tmpvar_14;
  tmpvar_14 = texelFetch (sPrimitiveHeadersF, tmpvar_12, 0);
  highp vec4 tmpvar_15;
  tmpvar_15 = texelFetch (sPrimitiveHeadersF, (tmpvar_12 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_16 = tmpvar_14.xy;
  tmpvar_17 = tmpvar_14.zw;
  highp ivec2 tmpvar_18;
  tmpvar_18.x = int((2u * (uint(tmpvar_13 % 512u))));
  tmpvar_18.y = int((tmpvar_13 / 512u));
  highp ivec4 tmpvar_19;
  tmpvar_19 = texelFetch (sPrimitiveHeadersI, tmpvar_18, 0);
  highp ivec4 tmpvar_20;
  tmpvar_20 = texelFetch (sPrimitiveHeadersI, (tmpvar_18 + ivec2(1, 0)), 0);
  tmpvar_11 = float(tmpvar_19.x);
  if ((tmpvar_7 == 65535)) {
    tmpvar_3 = tmpvar_16;
    tmpvar_4 = tmpvar_17;
  } else {
    highp int tmpvar_21;
    tmpvar_21 = ((tmpvar_19.y + 3) + (tmpvar_7 * 2));
    highp ivec2 tmpvar_22;
    tmpvar_22.x = int((uint(uint(tmpvar_21) % 1024u)));
    tmpvar_22.y = int((uint(tmpvar_21) / 1024u));
    highp vec4 tmpvar_23;
    tmpvar_23 = texelFetch (sGpuCache, tmpvar_22, 0);
    tmpvar_4 = tmpvar_23.zw;
    tmpvar_3 = (tmpvar_23.xy + tmpvar_14.xy);
  };
  highp ivec2 tmpvar_24;
  tmpvar_24.x = int((2u * (uint(
    uint(tmpvar_5)
   % 512u))));
  tmpvar_24.y = int((uint(tmpvar_5) / 512u));
  highp vec4 tmpvar_25;
  tmpvar_25 = texelFetch (sRenderTasks, tmpvar_24, 0);
  highp vec4 tmpvar_26;
  tmpvar_26 = texelFetch (sRenderTasks, (tmpvar_24 + ivec2(1, 0)), 0);
  RectWithSize tmpvar_27;
  highp float tmpvar_28;
  highp float tmpvar_29;
  highp vec2 tmpvar_30;
  if ((tmpvar_6 >= 32767)) {
    tmpvar_27 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_28 = 0.0;
    tmpvar_29 = 0.0;
    tmpvar_30 = vec2(0.0, 0.0);
  } else {
    highp ivec2 tmpvar_31;
    tmpvar_31.x = int((2u * (uint(
      uint(tmpvar_6)
     % 512u))));
    tmpvar_31.y = int((uint(tmpvar_6) / 512u));
    highp vec4 tmpvar_32;
    tmpvar_32 = texelFetch (sRenderTasks, tmpvar_31, 0);
    highp vec4 tmpvar_33;
    tmpvar_33 = texelFetch (sRenderTasks, (tmpvar_31 + ivec2(1, 0)), 0);
    highp vec3 tmpvar_34;
    tmpvar_34 = tmpvar_33.yzw;
    tmpvar_27.p0 = tmpvar_32.xy;
    tmpvar_27.size = tmpvar_32.zw;
    tmpvar_28 = tmpvar_33.x;
    tmpvar_29 = tmpvar_34.x;
    tmpvar_30 = tmpvar_34.yz;
  };
  highp mat4 tmpvar_35;
  highp int tmpvar_36;
  tmpvar_36 = (tmpvar_19.z & 16777215);
  highp ivec2 tmpvar_37;
  tmpvar_37.x = int((8u * (uint(
    uint(tmpvar_36)
   % 128u))));
  tmpvar_37.y = int((uint(tmpvar_36) / 128u));
  tmpvar_35[0] = texelFetch (sTransformPalette, tmpvar_37, 0);
  tmpvar_35[1] = texelFetch (sTransformPalette, (tmpvar_37 + ivec2(1, 0)), 0);
  tmpvar_35[2] = texelFetch (sTransformPalette, (tmpvar_37 + ivec2(2, 0)), 0);
  tmpvar_35[3] = texelFetch (sTransformPalette, (tmpvar_37 + ivec2(3, 0)), 0);
  if (((tmpvar_19.z >> 24) == 0)) {
    lowp vec2 tmpvar_38;
    tmpvar_38 = clamp ((tmpvar_3 + (tmpvar_4 * aPosition.xy)), tmpvar_15.xy, (tmpvar_15.xy + tmpvar_15.zw));
    lowp vec4 tmpvar_39;
    tmpvar_39.zw = vec2(0.0, 1.0);
    tmpvar_39.xy = tmpvar_38;
    highp vec4 tmpvar_40;
    tmpvar_40 = (tmpvar_35 * tmpvar_39);
    highp vec4 tmpvar_41;
    tmpvar_41.xy = ((tmpvar_40.xy * tmpvar_26.y) + ((
      -(tmpvar_26.zw)
     + tmpvar_25.xy) * tmpvar_40.w));
    tmpvar_41.z = (tmpvar_11 * tmpvar_40.w);
    tmpvar_41.w = tmpvar_40.w;
    gl_Position = (uTransform * tmpvar_41);
    tmpvar_1 = tmpvar_38;
    tmpvar_2 = tmpvar_40;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    lowp vec4 tmpvar_42;
    tmpvar_42 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_9 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_43;
    lowp vec2 tmpvar_44;
    tmpvar_43 = tmpvar_3;
    tmpvar_44 = tmpvar_4;
    highp vec2 tmpvar_45;
    tmpvar_45 = (tmpvar_15.xy + tmpvar_15.zw);
    lowp vec2 tmpvar_46;
    tmpvar_46 = clamp (tmpvar_43, tmpvar_15.xy, tmpvar_45);
    lowp vec2 tmpvar_47;
    tmpvar_47 = clamp ((tmpvar_43 + tmpvar_44), tmpvar_15.xy, tmpvar_45);
    lowp vec4 tmpvar_48;
    tmpvar_48 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_42);
    tmpvar_43 = (tmpvar_43 - tmpvar_48.xy);
    tmpvar_44 = (tmpvar_44 + (tmpvar_48.xy + tmpvar_48.zw));
    lowp vec2 tmpvar_49;
    tmpvar_49 = (tmpvar_43 + (tmpvar_44 * aPosition.xy));
    lowp vec4 tmpvar_50;
    tmpvar_50.zw = vec2(0.0, 1.0);
    tmpvar_50.xy = tmpvar_49;
    highp vec4 tmpvar_51;
    tmpvar_51 = (tmpvar_35 * tmpvar_50);
    highp vec4 tmpvar_52;
    tmpvar_52.xy = ((tmpvar_51.xy * tmpvar_26.y) + ((tmpvar_25.xy - tmpvar_26.zw) * tmpvar_51.w));
    tmpvar_52.z = (tmpvar_11 * tmpvar_51.w);
    tmpvar_52.w = tmpvar_51.w;
    gl_Position = (uTransform * tmpvar_52);
    highp vec4 tmpvar_53;
    tmpvar_53.xy = clamp (tmpvar_14.xy, tmpvar_15.xy, tmpvar_45);
    tmpvar_53.zw = clamp ((tmpvar_14.xy + tmpvar_14.zw), tmpvar_15.xy, tmpvar_45);
    lowp vec4 tmpvar_54;
    tmpvar_54.xy = tmpvar_46;
    tmpvar_54.zw = tmpvar_47;
    vTransformBounds = mix (tmpvar_53, tmpvar_54, tmpvar_42);
    tmpvar_1 = tmpvar_49;
    tmpvar_2 = tmpvar_51;
  };
  vec4 tmpvar_55;
  tmpvar_55.xy = tmpvar_27.p0;
  tmpvar_55.zw = (tmpvar_27.p0 + tmpvar_27.size);
  vClipMaskUvBounds = tmpvar_55;
  highp vec4 tmpvar_56;
  tmpvar_56.xy = ((tmpvar_2.xy * tmpvar_29) + (tmpvar_2.w * (tmpvar_27.p0 - tmpvar_30)));
  tmpvar_56.z = tmpvar_28;
  tmpvar_56.w = tmpvar_2.w;
  vClipMaskUv = tmpvar_56;
  highp vec2 tmpvar_57;
  highp vec2 tmpvar_58;
  highp ivec2 tmpvar_59;
  tmpvar_59.x = int((uint(uint(tmpvar_20.x) % 1024u)));
  tmpvar_59.y = int((uint(tmpvar_20.x) / 1024u));
  highp vec4 tmpvar_60;
  tmpvar_60 = texelFetch (sGpuCache, tmpvar_59, 0);
  tmpvar_57 = tmpvar_60.xy;
  tmpvar_58 = tmpvar_60.zw;
  highp float tmpvar_61;
  tmpvar_61 = texelFetch (sGpuCache, (tmpvar_59 + ivec2(1, 0)), 0).x;
  lowp vec2 tmpvar_62;
  tmpvar_62 = vec2(textureSize (sColor0, 0).xy);
  lowp vec2 tmpvar_63;
  tmpvar_63 = ((tmpvar_1 - tmpvar_14.xy) / tmpvar_14.zw);
  lowp vec2 tmpvar_64;
  highp int address_65;
  address_65 = (tmpvar_20.x + 2);
  highp ivec2 tmpvar_66;
  tmpvar_66.x = int((uint(uint(address_65) % 1024u)));
  tmpvar_66.y = int((uint(address_65) / 1024u));
  highp vec4 tmpvar_67;
  tmpvar_67 = mix (mix (texelFetch (sGpuCache, tmpvar_66, 0), texelFetch (sGpuCache, (tmpvar_66 + ivec2(1, 0)), 0), tmpvar_63.x), mix (texelFetch (sGpuCache, (tmpvar_66 + ivec2(2, 0)), 0), texelFetch (sGpuCache, (tmpvar_66 + ivec2(3, 0)), 0), tmpvar_63.x), tmpvar_63.y);
  tmpvar_64 = (tmpvar_67.xy / tmpvar_67.w);
  lowp vec2 tmpvar_68;
  tmpvar_68 = mix (tmpvar_60.xy, tmpvar_60.zw, tmpvar_64);
  highp float tmpvar_69;
  if (((tmpvar_10 & 1) != 0)) {
    tmpvar_69 = 1.0;
  } else {
    tmpvar_69 = 0.0;
  };
  highp float tmpvar_70;
  tmpvar_70 = mix (tmpvar_2.w, 1.0, tmpvar_69);
  varying_vec4_0.zw = ((tmpvar_68 / tmpvar_62) * tmpvar_70);
  flat_varying_vec4_4.x = tmpvar_61;
  flat_varying_vec4_4.y = tmpvar_69;
  highp vec4 tmpvar_71;
  tmpvar_71.xy = tmpvar_57;
  tmpvar_71.zw = tmpvar_58;
  flat_varying_vec4_2 = (tmpvar_71 / tmpvar_62.xyxy);
  varying_vec4_0.xy = tmpvar_1;
  highp float tmpvar_72;
  tmpvar_72 = (float(tmpvar_20.z) / 65536.0);
  highp float tmpvar_73;
  tmpvar_73 = (1.0 - tmpvar_72);
  flat_varying_ivec4_0.x = (tmpvar_20.y & 65535);
  flat_varying_vec4_4.z = tmpvar_72;
  vFuncs[0] = ((tmpvar_20.y >> 28) & 15);
  vFuncs[1] = ((tmpvar_20.y >> 24) & 15);
  vFuncs[2] = ((tmpvar_20.y >> 20) & 15);
  vFuncs[3] = ((tmpvar_20.y >> 16) & 15);
  bool tmpvar_74;
  tmpvar_74 = bool(0);
  bool tmpvar_75;
  tmpvar_75 = bool(0);
  highp int tmpvar_76;
  tmpvar_76 = flat_varying_ivec4_0.x;
  if ((1 == flat_varying_ivec4_0.x)) tmpvar_74 = bool(1);
  if (tmpvar_75) tmpvar_74 = bool(0);
  if (tmpvar_74) {
    highp vec4 tmpvar_77;
    tmpvar_77.w = 0.0;
    tmpvar_77.x = (0.2126 + (0.7874 * tmpvar_73));
    tmpvar_77.y = (0.2126 - (0.2126 * tmpvar_73));
    tmpvar_77.z = (0.2126 - (0.2126 * tmpvar_73));
    highp vec4 tmpvar_78;
    tmpvar_78.w = 0.0;
    tmpvar_78.x = (0.7152 - (0.7152 * tmpvar_73));
    tmpvar_78.y = (0.7152 + (0.2848 * tmpvar_73));
    tmpvar_78.z = (0.7152 - (0.7152 * tmpvar_73));
    highp vec4 tmpvar_79;
    tmpvar_79.w = 0.0;
    tmpvar_79.x = (0.0722 - (0.0722 * tmpvar_73));
    tmpvar_79.y = (0.0722 - (0.0722 * tmpvar_73));
    tmpvar_79.z = (0.0722 + (0.9278 * tmpvar_73));
    highp mat4 tmpvar_80;
    tmpvar_80[uint(0)] = tmpvar_77;
    tmpvar_80[1u] = tmpvar_78;
    tmpvar_80[2u] = tmpvar_79;
    tmpvar_80[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    vColorMat = tmpvar_80;
    flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
    tmpvar_75 = bool(1);
  };
  if ((2 == flat_varying_ivec4_0.x)) tmpvar_74 = bool(1);
  if (tmpvar_75) tmpvar_74 = bool(0);
  if (tmpvar_74) {
    highp float tmpvar_81;
    tmpvar_81 = cos(tmpvar_72);
    highp float tmpvar_82;
    tmpvar_82 = sin(tmpvar_72);
    highp vec4 tmpvar_83;
    tmpvar_83.w = 0.0;
    tmpvar_83.x = ((0.2126 + (0.7874 * tmpvar_81)) - (0.2126 * tmpvar_82));
    tmpvar_83.y = ((0.2126 - (0.2126 * tmpvar_81)) + (0.143 * tmpvar_82));
    tmpvar_83.z = ((0.2126 - (0.2126 * tmpvar_81)) - (0.7874 * tmpvar_82));
    highp vec4 tmpvar_84;
    tmpvar_84.w = 0.0;
    tmpvar_84.x = ((0.7152 - (0.7152 * tmpvar_81)) - (0.7152 * tmpvar_82));
    tmpvar_84.y = ((0.7152 + (0.2848 * tmpvar_81)) + (0.14 * tmpvar_82));
    tmpvar_84.z = ((0.7152 - (0.7152 * tmpvar_81)) + (0.7152 * tmpvar_82));
    highp vec4 tmpvar_85;
    tmpvar_85.w = 0.0;
    tmpvar_85.x = ((0.0722 - (0.0722 * tmpvar_81)) + (0.9278 * tmpvar_82));
    tmpvar_85.y = ((0.0722 - (0.0722 * tmpvar_81)) - (0.283 * tmpvar_82));
    tmpvar_85.z = ((0.0722 + (0.9278 * tmpvar_81)) + (0.0722 * tmpvar_82));
    highp mat4 tmpvar_86;
    tmpvar_86[uint(0)] = tmpvar_83;
    tmpvar_86[1u] = tmpvar_84;
    tmpvar_86[2u] = tmpvar_85;
    tmpvar_86[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    vColorMat = tmpvar_86;
    flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
    tmpvar_75 = bool(1);
  };
  if ((4 == flat_varying_ivec4_0.x)) tmpvar_74 = bool(1);
  if (tmpvar_75) tmpvar_74 = bool(0);
  if (tmpvar_74) {
    highp vec4 tmpvar_87;
    tmpvar_87.w = 0.0;
    tmpvar_87.x = ((tmpvar_73 * 0.2126) + tmpvar_72);
    tmpvar_87.y = (tmpvar_73 * 0.2126);
    tmpvar_87.z = (tmpvar_73 * 0.2126);
    highp vec4 tmpvar_88;
    tmpvar_88.w = 0.0;
    tmpvar_88.x = (tmpvar_73 * 0.7152);
    tmpvar_88.y = ((tmpvar_73 * 0.7152) + tmpvar_72);
    tmpvar_88.z = (tmpvar_73 * 0.7152);
    highp vec4 tmpvar_89;
    tmpvar_89.w = 0.0;
    tmpvar_89.x = (tmpvar_73 * 0.0722);
    tmpvar_89.y = (tmpvar_73 * 0.0722);
    tmpvar_89.z = ((tmpvar_73 * 0.0722) + tmpvar_72);
    highp mat4 tmpvar_90;
    tmpvar_90[uint(0)] = tmpvar_87;
    tmpvar_90[1u] = tmpvar_88;
    tmpvar_90[2u] = tmpvar_89;
    tmpvar_90[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    vColorMat = tmpvar_90;
    flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
    tmpvar_75 = bool(1);
  };
  if ((5 == flat_varying_ivec4_0.x)) tmpvar_74 = bool(1);
  if (tmpvar_75) tmpvar_74 = bool(0);
  if (tmpvar_74) {
    highp vec4 tmpvar_91;
    tmpvar_91.w = 0.0;
    tmpvar_91.x = (0.393 + (0.607 * tmpvar_73));
    tmpvar_91.y = (0.349 - (0.349 * tmpvar_73));
    tmpvar_91.z = (0.272 - (0.272 * tmpvar_73));
    highp vec4 tmpvar_92;
    tmpvar_92.w = 0.0;
    tmpvar_92.x = (0.769 - (0.769 * tmpvar_73));
    tmpvar_92.y = (0.686 + (0.314 * tmpvar_73));
    tmpvar_92.z = (0.534 - (0.534 * tmpvar_73));
    highp vec4 tmpvar_93;
    tmpvar_93.w = 0.0;
    tmpvar_93.x = (0.189 - (0.189 * tmpvar_73));
    tmpvar_93.y = (0.168 - (0.168 * tmpvar_73));
    tmpvar_93.z = (0.131 + (0.869 * tmpvar_73));
    highp mat4 tmpvar_94;
    tmpvar_94[uint(0)] = tmpvar_91;
    tmpvar_94[1u] = tmpvar_92;
    tmpvar_94[2u] = tmpvar_93;
    tmpvar_94[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    vColorMat = tmpvar_94;
    flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
    tmpvar_75 = bool(1);
  };
  if ((7 == flat_varying_ivec4_0.x)) tmpvar_74 = bool(1);
  if (tmpvar_75) tmpvar_74 = bool(0);
  if (tmpvar_74) {
    highp ivec2 tmpvar_95;
    tmpvar_95.x = int((uint(uint(tmpvar_20.z) % 1024u)));
    tmpvar_95.y = int((uint(tmpvar_20.z) / 1024u));
    highp int address_96;
    address_96 = (tmpvar_20.z + 4);
    highp ivec2 tmpvar_97;
    tmpvar_97.x = int((uint(uint(address_96) % 1024u)));
    tmpvar_97.y = int((uint(address_96) / 1024u));
    highp mat4 tmpvar_98;
    tmpvar_98[uint(0)] = texelFetch (sGpuCache, tmpvar_95, 0);
    tmpvar_98[1u] = texelFetch (sGpuCache, (tmpvar_95 + ivec2(1, 0)), 0);
    tmpvar_98[2u] = texelFetch (sGpuCache, (tmpvar_95 + ivec2(2, 0)), 0);
    tmpvar_98[3u] = texelFetch (sGpuCache, (tmpvar_95 + ivec2(3, 0)), 0);
    vColorMat = tmpvar_98;
    flat_varying_vec4_3 = texelFetch (sGpuCache, tmpvar_97, 0);
    tmpvar_75 = bool(1);
  };
  if ((11 == flat_varying_ivec4_0.x)) tmpvar_74 = bool(1);
  if (tmpvar_75) tmpvar_74 = bool(0);
  if (tmpvar_74) {
    flat_varying_ivec4_0.y = tmpvar_20.z;
    tmpvar_75 = bool(1);
  };
  if ((10 == tmpvar_76)) tmpvar_74 = bool(1);
  if (tmpvar_75) tmpvar_74 = bool(0);
  if (tmpvar_74) {
    highp ivec2 tmpvar_99;
    tmpvar_99.x = int((uint(uint(tmpvar_20.z) % 1024u)));
    tmpvar_99.y = int((uint(tmpvar_20.z) / 1024u));
    flat_varying_vec4_1 = texelFetch (sGpuCache, tmpvar_99, 0);
    tmpvar_75 = bool(1);
  };
  tmpvar_74 = bool(1);
  if (tmpvar_75) tmpvar_74 = bool(0);
  if (tmpvar_74) {
    tmpvar_75 = bool(1);
  };
}

