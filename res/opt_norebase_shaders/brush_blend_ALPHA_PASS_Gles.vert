#version 300 es
precision highp sampler2DArray;
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform mat4 uTransform;
in vec2 aPosition;
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
  highp int tmpvar_1;
  highp int tmpvar_2;
  highp int tmpvar_3;
  highp int tmpvar_4;
  tmpvar_1 = (aData.y >> 16);
  tmpvar_2 = (aData.y & 65535);
  tmpvar_3 = (aData.z & 65535);
  tmpvar_4 = (aData.z >> 16);
  highp float tmpvar_5;
  highp ivec2 tmpvar_6;
  highp uint tmpvar_7;
  tmpvar_7 = uint(aData.x);
  tmpvar_6.x = int((2u * (tmpvar_7 % 512u)));
  tmpvar_6.y = int((tmpvar_7 / 512u));
  highp vec4 tmpvar_8;
  tmpvar_8 = texelFetch (sPrimitiveHeadersF, tmpvar_6, 0);
  highp vec4 tmpvar_9;
  tmpvar_9 = texelFetch (sPrimitiveHeadersF, (tmpvar_6 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_10 = tmpvar_8.xy;
  tmpvar_11 = tmpvar_8.zw;
  highp ivec2 tmpvar_12;
  tmpvar_12.x = int((2u * (tmpvar_7 % 512u)));
  tmpvar_12.y = int((tmpvar_7 / 512u));
  highp ivec4 tmpvar_13;
  tmpvar_13 = texelFetch (sPrimitiveHeadersI, tmpvar_12, 0);
  highp ivec4 tmpvar_14;
  tmpvar_14 = texelFetch (sPrimitiveHeadersI, (tmpvar_12 + ivec2(1, 0)), 0);
  tmpvar_5 = float(tmpvar_13.x);
  highp mat4 tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = ((tmpvar_13.z >> 24) == 0);
  highp int tmpvar_17;
  tmpvar_17 = (tmpvar_13.z & 16777215);
  highp ivec2 tmpvar_18;
  tmpvar_18.x = int((8u * (
    uint(tmpvar_17)
   % 128u)));
  tmpvar_18.y = int((uint(tmpvar_17) / 128u));
  tmpvar_15[0] = texelFetch (sTransformPalette, tmpvar_18, 0);
  tmpvar_15[1] = texelFetch (sTransformPalette, (tmpvar_18 + ivec2(1, 0)), 0);
  tmpvar_15[2] = texelFetch (sTransformPalette, (tmpvar_18 + ivec2(2, 0)), 0);
  tmpvar_15[3] = texelFetch (sTransformPalette, (tmpvar_18 + ivec2(3, 0)), 0);
  highp ivec2 tmpvar_19;
  tmpvar_19.x = int((2u * (
    uint(tmpvar_1)
   % 512u)));
  tmpvar_19.y = int((uint(tmpvar_1) / 512u));
  highp vec4 tmpvar_20;
  tmpvar_20 = texelFetch (sRenderTasks, tmpvar_19, 0);
  highp vec4 tmpvar_21;
  tmpvar_21 = texelFetch (sRenderTasks, (tmpvar_19 + ivec2(1, 0)), 0);
  RectWithSize tmpvar_22;
  highp float tmpvar_23;
  highp float tmpvar_24;
  highp vec2 tmpvar_25;
  if ((tmpvar_2 >= 32767)) {
    tmpvar_22 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_23 = 0.0;
    tmpvar_24 = 0.0;
    tmpvar_25 = vec2(0.0, 0.0);
  } else {
    highp ivec2 tmpvar_26;
    tmpvar_26.x = int((2u * (
      uint(tmpvar_2)
     % 512u)));
    tmpvar_26.y = int((uint(tmpvar_2) / 512u));
    highp vec4 tmpvar_27;
    tmpvar_27 = texelFetch (sRenderTasks, tmpvar_26, 0);
    highp vec4 tmpvar_28;
    tmpvar_28 = texelFetch (sRenderTasks, (tmpvar_26 + ivec2(1, 0)), 0);
    highp vec3 tmpvar_29;
    tmpvar_29 = tmpvar_28.yzw;
    tmpvar_22.p0 = tmpvar_27.xy;
    tmpvar_22.size = tmpvar_27.zw;
    tmpvar_23 = tmpvar_28.x;
    tmpvar_24 = tmpvar_29.x;
    tmpvar_25 = tmpvar_29.yz;
  };
  lowp vec2 tmpvar_30;
  highp vec4 tmpvar_31;
  highp vec2 tmpvar_32;
  highp vec2 tmpvar_33;
  highp int tmpvar_34;
  tmpvar_34 = (tmpvar_4 & 255);
  highp int tmpvar_35;
  tmpvar_35 = ((tmpvar_4 >> 8) & 255);
  if ((tmpvar_3 == 65535)) {
    tmpvar_32 = tmpvar_10;
    tmpvar_33 = tmpvar_11;
  } else {
    highp int tmpvar_36;
    tmpvar_36 = ((tmpvar_13.y + 3) + (tmpvar_3 * 2));
    highp ivec2 tmpvar_37;
    tmpvar_37.x = int((uint(tmpvar_36) % 1024u));
    tmpvar_37.y = int((uint(tmpvar_36) / 1024u));
    highp vec4 tmpvar_38;
    tmpvar_38 = texelFetch (sGpuCache, tmpvar_37, 0);
    tmpvar_33 = tmpvar_38.zw;
    tmpvar_32 = (tmpvar_38.xy + tmpvar_8.xy);
  };
  if (tmpvar_16) {
    lowp vec2 tmpvar_39;
    tmpvar_39 = clamp ((tmpvar_32 + (tmpvar_33 * aPosition)), tmpvar_9.xy, (tmpvar_9.xy + tmpvar_9.zw));
    lowp vec4 tmpvar_40;
    tmpvar_40.zw = vec2(0.0, 1.0);
    tmpvar_40.xy = tmpvar_39;
    highp vec4 tmpvar_41;
    tmpvar_41 = (tmpvar_15 * tmpvar_40);
    highp vec4 tmpvar_42;
    tmpvar_42.xy = ((tmpvar_41.xy * tmpvar_21.y) + ((
      -(tmpvar_21.zw)
     + tmpvar_20.xy) * tmpvar_41.w));
    tmpvar_42.z = (tmpvar_5 * tmpvar_41.w);
    tmpvar_42.w = tmpvar_41.w;
    gl_Position = (uTransform * tmpvar_42);
    tmpvar_30 = tmpvar_39;
    tmpvar_31 = tmpvar_41;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    lowp vec4 tmpvar_43;
    tmpvar_43 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_34 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_44;
    lowp vec2 tmpvar_45;
    tmpvar_44 = tmpvar_32;
    tmpvar_45 = tmpvar_33;
    highp vec2 tmpvar_46;
    tmpvar_46 = (tmpvar_9.xy + tmpvar_9.zw);
    lowp vec2 tmpvar_47;
    tmpvar_47 = clamp (tmpvar_44, tmpvar_9.xy, tmpvar_46);
    lowp vec2 tmpvar_48;
    tmpvar_48 = clamp ((tmpvar_44 + tmpvar_45), tmpvar_9.xy, tmpvar_46);
    lowp vec4 tmpvar_49;
    tmpvar_49 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_43);
    tmpvar_44 = (tmpvar_44 - tmpvar_49.xy);
    tmpvar_45 = (tmpvar_45 + (tmpvar_49.xy + tmpvar_49.zw));
    lowp vec2 tmpvar_50;
    tmpvar_50 = (tmpvar_44 + (tmpvar_45 * aPosition));
    lowp vec4 tmpvar_51;
    tmpvar_51.zw = vec2(0.0, 1.0);
    tmpvar_51.xy = tmpvar_50;
    highp vec4 tmpvar_52;
    tmpvar_52 = (tmpvar_15 * tmpvar_51);
    highp vec4 tmpvar_53;
    tmpvar_53.xy = ((tmpvar_52.xy * tmpvar_21.y) + ((tmpvar_20.xy - tmpvar_21.zw) * tmpvar_52.w));
    tmpvar_53.z = (tmpvar_5 * tmpvar_52.w);
    tmpvar_53.w = tmpvar_52.w;
    gl_Position = (uTransform * tmpvar_53);
    highp vec4 tmpvar_54;
    tmpvar_54.xy = clamp (tmpvar_8.xy, tmpvar_9.xy, tmpvar_46);
    tmpvar_54.zw = clamp ((tmpvar_8.xy + tmpvar_8.zw), tmpvar_9.xy, tmpvar_46);
    lowp vec4 tmpvar_55;
    tmpvar_55.xy = tmpvar_47;
    tmpvar_55.zw = tmpvar_48;
    vTransformBounds = mix (tmpvar_54, tmpvar_55, tmpvar_43);
    tmpvar_30 = tmpvar_50;
    tmpvar_31 = tmpvar_52;
  };
  vec4 tmpvar_56;
  tmpvar_56.xy = tmpvar_22.p0;
  tmpvar_56.zw = (tmpvar_22.p0 + tmpvar_22.size);
  vClipMaskUvBounds = tmpvar_56;
  highp vec4 tmpvar_57;
  tmpvar_57.xy = ((tmpvar_31.xy * tmpvar_24) + (tmpvar_31.w * (tmpvar_22.p0 - tmpvar_25)));
  tmpvar_57.z = tmpvar_23;
  tmpvar_57.w = tmpvar_31.w;
  vClipMaskUv = tmpvar_57;
  highp vec2 tmpvar_58;
  highp vec2 tmpvar_59;
  highp ivec2 tmpvar_60;
  tmpvar_60.x = int((uint(tmpvar_14.x) % 1024u));
  tmpvar_60.y = int((uint(tmpvar_14.x) / 1024u));
  highp vec4 tmpvar_61;
  tmpvar_61 = texelFetch (sGpuCache, tmpvar_60, 0);
  tmpvar_58 = tmpvar_61.xy;
  tmpvar_59 = tmpvar_61.zw;
  highp float tmpvar_62;
  tmpvar_62 = texelFetch (sGpuCache, (tmpvar_60 + ivec2(1, 0)), 0).x;
  lowp vec2 tmpvar_63;
  tmpvar_63 = vec2(textureSize (sColor0, 0).xy);
  lowp vec2 tmpvar_64;
  tmpvar_64 = ((tmpvar_30 - tmpvar_8.xy) / tmpvar_8.zw);
  lowp vec2 tmpvar_65;
  highp int address_66;
  address_66 = (tmpvar_14.x + 2);
  highp ivec2 tmpvar_67;
  tmpvar_67.x = int((uint(address_66) % 1024u));
  tmpvar_67.y = int((uint(address_66) / 1024u));
  highp vec4 tmpvar_68;
  tmpvar_68 = mix (mix (texelFetch (sGpuCache, tmpvar_67, 0), texelFetch (sGpuCache, (tmpvar_67 + ivec2(1, 0)), 0), tmpvar_64.x), mix (texelFetch (sGpuCache, (tmpvar_67 + ivec2(2, 0)), 0), texelFetch (sGpuCache, (tmpvar_67 + ivec2(3, 0)), 0), tmpvar_64.x), tmpvar_64.y);
  tmpvar_65 = (tmpvar_68.xy / tmpvar_68.w);
  lowp vec2 tmpvar_69;
  tmpvar_69 = mix (tmpvar_61.xy, tmpvar_61.zw, tmpvar_65);
  highp float tmpvar_70;
  if (((tmpvar_35 & 1) != 0)) {
    tmpvar_70 = 1.0;
  } else {
    tmpvar_70 = 0.0;
  };
  highp float tmpvar_71;
  tmpvar_71 = mix (tmpvar_31.w, 1.0, tmpvar_70);
  varying_vec4_0.zw = ((tmpvar_69 / tmpvar_63) * tmpvar_71);
  flat_varying_vec4_4.x = tmpvar_62;
  flat_varying_vec4_4.y = tmpvar_70;
  highp vec4 tmpvar_72;
  tmpvar_72.xy = tmpvar_58;
  tmpvar_72.zw = tmpvar_59;
  flat_varying_vec4_2 = (tmpvar_72 / tmpvar_63.xyxy);
  varying_vec4_0.xy = tmpvar_30;
  highp float tmpvar_73;
  tmpvar_73 = (float(tmpvar_14.z) / 65536.0);
  highp float tmpvar_74;
  tmpvar_74 = (1.0 - tmpvar_73);
  flat_varying_ivec4_0.x = (tmpvar_14.y & 65535);
  flat_varying_vec4_4.z = tmpvar_73;
  vFuncs[0] = ((tmpvar_14.y >> 28) & 15);
  vFuncs[1] = ((tmpvar_14.y >> 24) & 15);
  vFuncs[2] = ((tmpvar_14.y >> 20) & 15);
  vFuncs[3] = ((tmpvar_14.y >> 16) & 15);
  bool tmpvar_75;
  tmpvar_75 = bool(0);
  bool tmpvar_76;
  tmpvar_76 = bool(0);
  highp int tmpvar_77;
  tmpvar_77 = flat_varying_ivec4_0.x;
  if ((1 == flat_varying_ivec4_0.x)) tmpvar_75 = bool(1);
  if (tmpvar_76) tmpvar_75 = bool(0);
  if (tmpvar_75) {
    highp vec4 tmpvar_78;
    tmpvar_78.w = 0.0;
    tmpvar_78.x = (0.2126 + (0.7874 * tmpvar_74));
    tmpvar_78.y = (0.2126 - (0.2126 * tmpvar_74));
    tmpvar_78.z = (0.2126 - (0.2126 * tmpvar_74));
    highp vec4 tmpvar_79;
    tmpvar_79.w = 0.0;
    tmpvar_79.x = (0.7152 - (0.7152 * tmpvar_74));
    tmpvar_79.y = (0.7152 + (0.2848 * tmpvar_74));
    tmpvar_79.z = (0.7152 - (0.7152 * tmpvar_74));
    highp vec4 tmpvar_80;
    tmpvar_80.w = 0.0;
    tmpvar_80.x = (0.0722 - (0.0722 * tmpvar_74));
    tmpvar_80.y = (0.0722 - (0.0722 * tmpvar_74));
    tmpvar_80.z = (0.0722 + (0.9278 * tmpvar_74));
    highp mat4 tmpvar_81;
    tmpvar_81[uint(0)] = tmpvar_78;
    tmpvar_81[1u] = tmpvar_79;
    tmpvar_81[2u] = tmpvar_80;
    tmpvar_81[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    vColorMat = tmpvar_81;
    flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
    tmpvar_76 = bool(1);
  };
  if ((2 == flat_varying_ivec4_0.x)) tmpvar_75 = bool(1);
  if (tmpvar_76) tmpvar_75 = bool(0);
  if (tmpvar_75) {
    highp float tmpvar_82;
    tmpvar_82 = cos(tmpvar_73);
    highp float tmpvar_83;
    tmpvar_83 = sin(tmpvar_73);
    highp vec4 tmpvar_84;
    tmpvar_84.w = 0.0;
    tmpvar_84.x = ((0.2126 + (0.7874 * tmpvar_82)) - (0.2126 * tmpvar_83));
    tmpvar_84.y = ((0.2126 - (0.2126 * tmpvar_82)) + (0.143 * tmpvar_83));
    tmpvar_84.z = ((0.2126 - (0.2126 * tmpvar_82)) - (0.7874 * tmpvar_83));
    highp vec4 tmpvar_85;
    tmpvar_85.w = 0.0;
    tmpvar_85.x = ((0.7152 - (0.7152 * tmpvar_82)) - (0.7152 * tmpvar_83));
    tmpvar_85.y = ((0.7152 + (0.2848 * tmpvar_82)) + (0.14 * tmpvar_83));
    tmpvar_85.z = ((0.7152 - (0.7152 * tmpvar_82)) + (0.7152 * tmpvar_83));
    highp vec4 tmpvar_86;
    tmpvar_86.w = 0.0;
    tmpvar_86.x = ((0.0722 - (0.0722 * tmpvar_82)) + (0.9278 * tmpvar_83));
    tmpvar_86.y = ((0.0722 - (0.0722 * tmpvar_82)) - (0.283 * tmpvar_83));
    tmpvar_86.z = ((0.0722 + (0.9278 * tmpvar_82)) + (0.0722 * tmpvar_83));
    highp mat4 tmpvar_87;
    tmpvar_87[uint(0)] = tmpvar_84;
    tmpvar_87[1u] = tmpvar_85;
    tmpvar_87[2u] = tmpvar_86;
    tmpvar_87[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    vColorMat = tmpvar_87;
    flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
    tmpvar_76 = bool(1);
  };
  if ((4 == flat_varying_ivec4_0.x)) tmpvar_75 = bool(1);
  if (tmpvar_76) tmpvar_75 = bool(0);
  if (tmpvar_75) {
    highp vec4 tmpvar_88;
    tmpvar_88.w = 0.0;
    tmpvar_88.x = ((tmpvar_74 * 0.2126) + tmpvar_73);
    tmpvar_88.y = (tmpvar_74 * 0.2126);
    tmpvar_88.z = (tmpvar_74 * 0.2126);
    highp vec4 tmpvar_89;
    tmpvar_89.w = 0.0;
    tmpvar_89.x = (tmpvar_74 * 0.7152);
    tmpvar_89.y = ((tmpvar_74 * 0.7152) + tmpvar_73);
    tmpvar_89.z = (tmpvar_74 * 0.7152);
    highp vec4 tmpvar_90;
    tmpvar_90.w = 0.0;
    tmpvar_90.x = (tmpvar_74 * 0.0722);
    tmpvar_90.y = (tmpvar_74 * 0.0722);
    tmpvar_90.z = ((tmpvar_74 * 0.0722) + tmpvar_73);
    highp mat4 tmpvar_91;
    tmpvar_91[uint(0)] = tmpvar_88;
    tmpvar_91[1u] = tmpvar_89;
    tmpvar_91[2u] = tmpvar_90;
    tmpvar_91[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    vColorMat = tmpvar_91;
    flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
    tmpvar_76 = bool(1);
  };
  if ((5 == flat_varying_ivec4_0.x)) tmpvar_75 = bool(1);
  if (tmpvar_76) tmpvar_75 = bool(0);
  if (tmpvar_75) {
    highp vec4 tmpvar_92;
    tmpvar_92.w = 0.0;
    tmpvar_92.x = (0.393 + (0.607 * tmpvar_74));
    tmpvar_92.y = (0.349 - (0.349 * tmpvar_74));
    tmpvar_92.z = (0.272 - (0.272 * tmpvar_74));
    highp vec4 tmpvar_93;
    tmpvar_93.w = 0.0;
    tmpvar_93.x = (0.769 - (0.769 * tmpvar_74));
    tmpvar_93.y = (0.686 + (0.314 * tmpvar_74));
    tmpvar_93.z = (0.534 - (0.534 * tmpvar_74));
    highp vec4 tmpvar_94;
    tmpvar_94.w = 0.0;
    tmpvar_94.x = (0.189 - (0.189 * tmpvar_74));
    tmpvar_94.y = (0.168 - (0.168 * tmpvar_74));
    tmpvar_94.z = (0.131 + (0.869 * tmpvar_74));
    highp mat4 tmpvar_95;
    tmpvar_95[uint(0)] = tmpvar_92;
    tmpvar_95[1u] = tmpvar_93;
    tmpvar_95[2u] = tmpvar_94;
    tmpvar_95[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    vColorMat = tmpvar_95;
    flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
    tmpvar_76 = bool(1);
  };
  if ((7 == flat_varying_ivec4_0.x)) tmpvar_75 = bool(1);
  if (tmpvar_76) tmpvar_75 = bool(0);
  if (tmpvar_75) {
    highp ivec2 tmpvar_96;
    tmpvar_96.x = int((uint(tmpvar_14.z) % 1024u));
    tmpvar_96.y = int((uint(tmpvar_14.z) / 1024u));
    highp int address_97;
    address_97 = (tmpvar_14.z + 4);
    highp ivec2 tmpvar_98;
    tmpvar_98.x = int((uint(address_97) % 1024u));
    tmpvar_98.y = int((uint(address_97) / 1024u));
    highp mat4 tmpvar_99;
    tmpvar_99[uint(0)] = texelFetch (sGpuCache, tmpvar_96, 0);
    tmpvar_99[1u] = texelFetch (sGpuCache, (tmpvar_96 + ivec2(1, 0)), 0);
    tmpvar_99[2u] = texelFetch (sGpuCache, (tmpvar_96 + ivec2(2, 0)), 0);
    tmpvar_99[3u] = texelFetch (sGpuCache, (tmpvar_96 + ivec2(3, 0)), 0);
    vColorMat = tmpvar_99;
    flat_varying_vec4_3 = texelFetch (sGpuCache, tmpvar_98, 0);
    tmpvar_76 = bool(1);
  };
  if ((11 == flat_varying_ivec4_0.x)) tmpvar_75 = bool(1);
  if (tmpvar_76) tmpvar_75 = bool(0);
  if (tmpvar_75) {
    flat_varying_ivec4_0.y = tmpvar_14.z;
    tmpvar_76 = bool(1);
  };
  if ((10 == tmpvar_77)) tmpvar_75 = bool(1);
  if (tmpvar_76) tmpvar_75 = bool(0);
  if (tmpvar_75) {
    highp ivec2 tmpvar_100;
    tmpvar_100.x = int((uint(tmpvar_14.z) % 1024u));
    tmpvar_100.y = int((uint(tmpvar_14.z) / 1024u));
    flat_varying_vec4_1 = texelFetch (sGpuCache, tmpvar_100, 0);
    tmpvar_76 = bool(1);
  };
  tmpvar_75 = bool(1);
  if (tmpvar_76) tmpvar_75 = bool(0);
  if (tmpvar_75) {
    tmpvar_76 = bool(1);
  };
}

