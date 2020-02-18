#version 310 es
precision highp sampler2DArray;
uniform mat4 uTransform;
in vec3 aPosition;
uniform sampler2DArray sColor0;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
flat out lowp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
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
  tmpvar_5 = (aData.y >> 16);
  tmpvar_6 = (aData.z & 65535);
  tmpvar_7 = (aData.z >> 16);
  highp int tmpvar_8;
  tmpvar_8 = (tmpvar_7 & 255);
  highp int tmpvar_9;
  tmpvar_9 = ((tmpvar_7 >> 8) & 255);
  highp float tmpvar_10;
  highp ivec2 tmpvar_11;
  highp uint tmpvar_12;
  tmpvar_12 = uint(aData.x);
  tmpvar_11.x = int((2u * (uint(tmpvar_12 % 512u))));
  tmpvar_11.y = int((tmpvar_12 / 512u));
  highp vec4 tmpvar_13;
  tmpvar_13 = texelFetch (sPrimitiveHeadersF, tmpvar_11, 0);
  highp vec4 tmpvar_14;
  tmpvar_14 = texelFetch (sPrimitiveHeadersF, (tmpvar_11 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_15 = tmpvar_13.xy;
  tmpvar_16 = tmpvar_13.zw;
  highp ivec2 tmpvar_17;
  tmpvar_17.x = int((2u * (uint(tmpvar_12 % 512u))));
  tmpvar_17.y = int((tmpvar_12 / 512u));
  highp ivec4 tmpvar_18;
  tmpvar_18 = texelFetch (sPrimitiveHeadersI, tmpvar_17, 0);
  highp ivec4 tmpvar_19;
  tmpvar_19 = texelFetch (sPrimitiveHeadersI, (tmpvar_17 + ivec2(1, 0)), 0);
  tmpvar_10 = float(tmpvar_18.x);
  if ((tmpvar_6 == 65535)) {
    tmpvar_3 = tmpvar_15;
    tmpvar_4 = tmpvar_16;
  } else {
    highp int tmpvar_20;
    tmpvar_20 = ((tmpvar_18.y + 3) + (tmpvar_6 * 2));
    highp ivec2 tmpvar_21;
    tmpvar_21.x = int((uint(uint(tmpvar_20) % 1024u)));
    tmpvar_21.y = int((uint(tmpvar_20) / 1024u));
    highp vec4 tmpvar_22;
    tmpvar_22 = texelFetch (sGpuCache, tmpvar_21, 0);
    tmpvar_4 = tmpvar_22.zw;
    tmpvar_3 = (tmpvar_22.xy + tmpvar_13.xy);
  };
  highp ivec2 tmpvar_23;
  tmpvar_23.x = int((2u * (uint(
    uint(tmpvar_5)
   % 512u))));
  tmpvar_23.y = int((uint(tmpvar_5) / 512u));
  highp vec4 tmpvar_24;
  tmpvar_24 = texelFetch (sRenderTasks, tmpvar_23, 0);
  highp vec4 tmpvar_25;
  tmpvar_25 = texelFetch (sRenderTasks, (tmpvar_23 + ivec2(1, 0)), 0);
  highp mat4 tmpvar_26;
  highp int tmpvar_27;
  tmpvar_27 = (tmpvar_18.z & 16777215);
  highp ivec2 tmpvar_28;
  tmpvar_28.x = int((8u * (uint(
    uint(tmpvar_27)
   % 128u))));
  tmpvar_28.y = int((uint(tmpvar_27) / 128u));
  tmpvar_26[0] = texelFetch (sTransformPalette, tmpvar_28, 0);
  tmpvar_26[1] = texelFetch (sTransformPalette, (tmpvar_28 + ivec2(1, 0)), 0);
  tmpvar_26[2] = texelFetch (sTransformPalette, (tmpvar_28 + ivec2(2, 0)), 0);
  tmpvar_26[3] = texelFetch (sTransformPalette, (tmpvar_28 + ivec2(3, 0)), 0);
  if (((tmpvar_18.z >> 24) == 0)) {
    lowp vec2 tmpvar_29;
    tmpvar_29 = clamp ((tmpvar_3 + (tmpvar_4 * aPosition.xy)), tmpvar_14.xy, (tmpvar_14.xy + tmpvar_14.zw));
    lowp vec4 tmpvar_30;
    tmpvar_30.zw = vec2(0.0, 1.0);
    tmpvar_30.xy = tmpvar_29;
    highp vec4 tmpvar_31;
    tmpvar_31 = (tmpvar_26 * tmpvar_30);
    highp vec4 tmpvar_32;
    tmpvar_32.xy = ((tmpvar_31.xy * tmpvar_25.y) + ((
      -(tmpvar_25.zw)
     + tmpvar_24.xy) * tmpvar_31.w));
    tmpvar_32.z = (tmpvar_10 * tmpvar_31.w);
    tmpvar_32.w = tmpvar_31.w;
    gl_Position = (uTransform * tmpvar_32);
    tmpvar_1 = tmpvar_29;
    tmpvar_2 = tmpvar_31;
  } else {
    lowp vec4 tmpvar_33;
    tmpvar_33 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_8 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_34;
    lowp vec2 tmpvar_35;
    tmpvar_34 = tmpvar_3;
    tmpvar_35 = tmpvar_4;
    highp vec2 tmpvar_36;
    tmpvar_36 = (tmpvar_14.xy + tmpvar_14.zw);
    lowp vec2 tmpvar_37;
    tmpvar_37 = clamp (tmpvar_34, tmpvar_14.xy, tmpvar_36);
    lowp vec2 tmpvar_38;
    tmpvar_38 = clamp ((tmpvar_34 + tmpvar_35), tmpvar_14.xy, tmpvar_36);
    lowp vec4 tmpvar_39;
    tmpvar_39 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_33);
    tmpvar_34 = (tmpvar_34 - tmpvar_39.xy);
    tmpvar_35 = (tmpvar_35 + (tmpvar_39.xy + tmpvar_39.zw));
    lowp vec2 tmpvar_40;
    tmpvar_40 = (tmpvar_34 + (tmpvar_35 * aPosition.xy));
    lowp vec4 tmpvar_41;
    tmpvar_41.zw = vec2(0.0, 1.0);
    tmpvar_41.xy = tmpvar_40;
    highp vec4 tmpvar_42;
    tmpvar_42 = (tmpvar_26 * tmpvar_41);
    highp vec4 tmpvar_43;
    tmpvar_43.xy = ((tmpvar_42.xy * tmpvar_25.y) + ((tmpvar_24.xy - tmpvar_25.zw) * tmpvar_42.w));
    tmpvar_43.z = (tmpvar_10 * tmpvar_42.w);
    tmpvar_43.w = tmpvar_42.w;
    gl_Position = (uTransform * tmpvar_43);
    highp vec4 tmpvar_44;
    tmpvar_44.xy = clamp (tmpvar_13.xy, tmpvar_14.xy, tmpvar_36);
    tmpvar_44.zw = clamp ((tmpvar_13.xy + tmpvar_13.zw), tmpvar_14.xy, tmpvar_36);
    lowp vec4 tmpvar_45;
    tmpvar_45.xy = tmpvar_37;
    tmpvar_45.zw = tmpvar_38;
    vTransformBounds = mix (tmpvar_44, tmpvar_45, tmpvar_33);
    tmpvar_1 = tmpvar_40;
    tmpvar_2 = tmpvar_42;
  };
  highp vec2 tmpvar_46;
  highp vec2 tmpvar_47;
  highp ivec2 tmpvar_48;
  tmpvar_48.x = int((uint(uint(tmpvar_19.x) % 1024u)));
  tmpvar_48.y = int((uint(tmpvar_19.x) / 1024u));
  highp vec4 tmpvar_49;
  tmpvar_49 = texelFetch (sGpuCache, tmpvar_48, 0);
  tmpvar_46 = tmpvar_49.xy;
  tmpvar_47 = tmpvar_49.zw;
  highp float tmpvar_50;
  tmpvar_50 = texelFetch (sGpuCache, (tmpvar_48 + ivec2(1, 0)), 0).x;
  lowp vec2 tmpvar_51;
  tmpvar_51 = vec2(textureSize (sColor0, 0).xy);
  lowp vec2 tmpvar_52;
  tmpvar_52 = ((tmpvar_1 - tmpvar_13.xy) / tmpvar_13.zw);
  lowp vec2 tmpvar_53;
  highp int address_54;
  address_54 = (tmpvar_19.x + 2);
  highp ivec2 tmpvar_55;
  tmpvar_55.x = int((uint(uint(address_54) % 1024u)));
  tmpvar_55.y = int((uint(address_54) / 1024u));
  highp vec4 tmpvar_56;
  tmpvar_56 = mix (mix (texelFetch (sGpuCache, tmpvar_55, 0), texelFetch (sGpuCache, (tmpvar_55 + ivec2(1, 0)), 0), tmpvar_52.x), mix (texelFetch (sGpuCache, (tmpvar_55 + ivec2(2, 0)), 0), texelFetch (sGpuCache, (tmpvar_55 + ivec2(3, 0)), 0), tmpvar_52.x), tmpvar_52.y);
  tmpvar_53 = (tmpvar_56.xy / tmpvar_56.w);
  lowp vec2 tmpvar_57;
  tmpvar_57 = mix (tmpvar_49.xy, tmpvar_49.zw, tmpvar_53);
  highp float tmpvar_58;
  if (((tmpvar_9 & 1) != 0)) {
    tmpvar_58 = 1.0;
  } else {
    tmpvar_58 = 0.0;
  };
  highp float tmpvar_59;
  tmpvar_59 = mix (tmpvar_2.w, 1.0, tmpvar_58);
  varying_vec4_0.zw = ((tmpvar_57 / tmpvar_51) * tmpvar_59);
  flat_varying_vec4_4.x = tmpvar_50;
  flat_varying_vec4_4.y = tmpvar_58;
  highp vec4 tmpvar_60;
  tmpvar_60.xy = tmpvar_46;
  tmpvar_60.zw = tmpvar_47;
  flat_varying_vec4_2 = (tmpvar_60 / tmpvar_51.xyxy);
  varying_vec4_0.xy = tmpvar_1;
  highp float tmpvar_61;
  tmpvar_61 = (float(tmpvar_19.z) / 65536.0);
  highp float tmpvar_62;
  tmpvar_62 = (1.0 - tmpvar_61);
  flat_varying_ivec4_0.x = (tmpvar_19.y & 65535);
  flat_varying_vec4_4.z = tmpvar_61;
  vFuncs[0] = ((tmpvar_19.y >> 28) & 15);
  vFuncs[1] = ((tmpvar_19.y >> 24) & 15);
  vFuncs[2] = ((tmpvar_19.y >> 20) & 15);
  vFuncs[3] = ((tmpvar_19.y >> 16) & 15);
  bool tmpvar_63;
  tmpvar_63 = bool(0);
  bool tmpvar_64;
  tmpvar_64 = bool(0);
  highp int tmpvar_65;
  tmpvar_65 = flat_varying_ivec4_0.x;
  if ((1 == flat_varying_ivec4_0.x)) tmpvar_63 = bool(1);
  if (tmpvar_64) tmpvar_63 = bool(0);
  if (tmpvar_63) {
    highp vec4 tmpvar_66;
    tmpvar_66.w = 0.0;
    tmpvar_66.x = (0.2126 + (0.7874 * tmpvar_62));
    tmpvar_66.y = (0.2126 - (0.2126 * tmpvar_62));
    tmpvar_66.z = (0.2126 - (0.2126 * tmpvar_62));
    highp vec4 tmpvar_67;
    tmpvar_67.w = 0.0;
    tmpvar_67.x = (0.7152 - (0.7152 * tmpvar_62));
    tmpvar_67.y = (0.7152 + (0.2848 * tmpvar_62));
    tmpvar_67.z = (0.7152 - (0.7152 * tmpvar_62));
    highp vec4 tmpvar_68;
    tmpvar_68.w = 0.0;
    tmpvar_68.x = (0.0722 - (0.0722 * tmpvar_62));
    tmpvar_68.y = (0.0722 - (0.0722 * tmpvar_62));
    tmpvar_68.z = (0.0722 + (0.9278 * tmpvar_62));
    highp mat4 tmpvar_69;
    tmpvar_69[uint(0)] = tmpvar_66;
    tmpvar_69[1u] = tmpvar_67;
    tmpvar_69[2u] = tmpvar_68;
    tmpvar_69[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    vColorMat = tmpvar_69;
    flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
    tmpvar_64 = bool(1);
  };
  if ((2 == flat_varying_ivec4_0.x)) tmpvar_63 = bool(1);
  if (tmpvar_64) tmpvar_63 = bool(0);
  if (tmpvar_63) {
    highp float tmpvar_70;
    tmpvar_70 = cos(tmpvar_61);
    highp float tmpvar_71;
    tmpvar_71 = sin(tmpvar_61);
    highp vec4 tmpvar_72;
    tmpvar_72.w = 0.0;
    tmpvar_72.x = ((0.2126 + (0.7874 * tmpvar_70)) - (0.2126 * tmpvar_71));
    tmpvar_72.y = ((0.2126 - (0.2126 * tmpvar_70)) + (0.143 * tmpvar_71));
    tmpvar_72.z = ((0.2126 - (0.2126 * tmpvar_70)) - (0.7874 * tmpvar_71));
    highp vec4 tmpvar_73;
    tmpvar_73.w = 0.0;
    tmpvar_73.x = ((0.7152 - (0.7152 * tmpvar_70)) - (0.7152 * tmpvar_71));
    tmpvar_73.y = ((0.7152 + (0.2848 * tmpvar_70)) + (0.14 * tmpvar_71));
    tmpvar_73.z = ((0.7152 - (0.7152 * tmpvar_70)) + (0.7152 * tmpvar_71));
    highp vec4 tmpvar_74;
    tmpvar_74.w = 0.0;
    tmpvar_74.x = ((0.0722 - (0.0722 * tmpvar_70)) + (0.9278 * tmpvar_71));
    tmpvar_74.y = ((0.0722 - (0.0722 * tmpvar_70)) - (0.283 * tmpvar_71));
    tmpvar_74.z = ((0.0722 + (0.9278 * tmpvar_70)) + (0.0722 * tmpvar_71));
    highp mat4 tmpvar_75;
    tmpvar_75[uint(0)] = tmpvar_72;
    tmpvar_75[1u] = tmpvar_73;
    tmpvar_75[2u] = tmpvar_74;
    tmpvar_75[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    vColorMat = tmpvar_75;
    flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
    tmpvar_64 = bool(1);
  };
  if ((4 == flat_varying_ivec4_0.x)) tmpvar_63 = bool(1);
  if (tmpvar_64) tmpvar_63 = bool(0);
  if (tmpvar_63) {
    highp vec4 tmpvar_76;
    tmpvar_76.w = 0.0;
    tmpvar_76.x = ((tmpvar_62 * 0.2126) + tmpvar_61);
    tmpvar_76.y = (tmpvar_62 * 0.2126);
    tmpvar_76.z = (tmpvar_62 * 0.2126);
    highp vec4 tmpvar_77;
    tmpvar_77.w = 0.0;
    tmpvar_77.x = (tmpvar_62 * 0.7152);
    tmpvar_77.y = ((tmpvar_62 * 0.7152) + tmpvar_61);
    tmpvar_77.z = (tmpvar_62 * 0.7152);
    highp vec4 tmpvar_78;
    tmpvar_78.w = 0.0;
    tmpvar_78.x = (tmpvar_62 * 0.0722);
    tmpvar_78.y = (tmpvar_62 * 0.0722);
    tmpvar_78.z = ((tmpvar_62 * 0.0722) + tmpvar_61);
    highp mat4 tmpvar_79;
    tmpvar_79[uint(0)] = tmpvar_76;
    tmpvar_79[1u] = tmpvar_77;
    tmpvar_79[2u] = tmpvar_78;
    tmpvar_79[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    vColorMat = tmpvar_79;
    flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
    tmpvar_64 = bool(1);
  };
  if ((5 == flat_varying_ivec4_0.x)) tmpvar_63 = bool(1);
  if (tmpvar_64) tmpvar_63 = bool(0);
  if (tmpvar_63) {
    highp vec4 tmpvar_80;
    tmpvar_80.w = 0.0;
    tmpvar_80.x = (0.393 + (0.607 * tmpvar_62));
    tmpvar_80.y = (0.349 - (0.349 * tmpvar_62));
    tmpvar_80.z = (0.272 - (0.272 * tmpvar_62));
    highp vec4 tmpvar_81;
    tmpvar_81.w = 0.0;
    tmpvar_81.x = (0.769 - (0.769 * tmpvar_62));
    tmpvar_81.y = (0.686 + (0.314 * tmpvar_62));
    tmpvar_81.z = (0.534 - (0.534 * tmpvar_62));
    highp vec4 tmpvar_82;
    tmpvar_82.w = 0.0;
    tmpvar_82.x = (0.189 - (0.189 * tmpvar_62));
    tmpvar_82.y = (0.168 - (0.168 * tmpvar_62));
    tmpvar_82.z = (0.131 + (0.869 * tmpvar_62));
    highp mat4 tmpvar_83;
    tmpvar_83[uint(0)] = tmpvar_80;
    tmpvar_83[1u] = tmpvar_81;
    tmpvar_83[2u] = tmpvar_82;
    tmpvar_83[3u] = vec4(0.0, 0.0, 0.0, 1.0);
    vColorMat = tmpvar_83;
    flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
    tmpvar_64 = bool(1);
  };
  if ((7 == flat_varying_ivec4_0.x)) tmpvar_63 = bool(1);
  if (tmpvar_64) tmpvar_63 = bool(0);
  if (tmpvar_63) {
    highp ivec2 tmpvar_84;
    tmpvar_84.x = int((uint(uint(tmpvar_19.z) % 1024u)));
    tmpvar_84.y = int((uint(tmpvar_19.z) / 1024u));
    highp int address_85;
    address_85 = (tmpvar_19.z + 4);
    highp ivec2 tmpvar_86;
    tmpvar_86.x = int((uint(uint(address_85) % 1024u)));
    tmpvar_86.y = int((uint(address_85) / 1024u));
    highp mat4 tmpvar_87;
    tmpvar_87[uint(0)] = texelFetch (sGpuCache, tmpvar_84, 0);
    tmpvar_87[1u] = texelFetch (sGpuCache, (tmpvar_84 + ivec2(1, 0)), 0);
    tmpvar_87[2u] = texelFetch (sGpuCache, (tmpvar_84 + ivec2(2, 0)), 0);
    tmpvar_87[3u] = texelFetch (sGpuCache, (tmpvar_84 + ivec2(3, 0)), 0);
    vColorMat = tmpvar_87;
    flat_varying_vec4_3 = texelFetch (sGpuCache, tmpvar_86, 0);
    tmpvar_64 = bool(1);
  };
  if ((11 == flat_varying_ivec4_0.x)) tmpvar_63 = bool(1);
  if (tmpvar_64) tmpvar_63 = bool(0);
  if (tmpvar_63) {
    flat_varying_ivec4_0.y = tmpvar_19.z;
    tmpvar_64 = bool(1);
  };
  if ((10 == tmpvar_65)) tmpvar_63 = bool(1);
  if (tmpvar_64) tmpvar_63 = bool(0);
  if (tmpvar_63) {
    highp ivec2 tmpvar_88;
    tmpvar_88.x = int((uint(uint(tmpvar_19.z) % 1024u)));
    tmpvar_88.y = int((uint(tmpvar_19.z) / 1024u));
    flat_varying_vec4_1 = texelFetch (sGpuCache, tmpvar_88, 0);
    tmpvar_64 = bool(1);
  };
  tmpvar_63 = bool(1);
  if (tmpvar_64) tmpvar_63 = bool(0);
  if (tmpvar_63) {
    tmpvar_64 = bool(1);
  };
}

