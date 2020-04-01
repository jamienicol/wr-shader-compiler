#version 300 es
#extension GL_EXT_blend_func_extended : enable
precision highp sampler2DArray;
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform highp int uMode;
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sColor0;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
flat out lowp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
flat out vec4 vClipMaskUvBounds;
out highp vec4 vClipMaskUv;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
flat out highp vec4 flat_varying_vec4_0;
flat out highp vec4 flat_varying_vec4_1;
flat out lowp vec4 flat_varying_vec4_2;
flat out lowp vec4 flat_varying_vec4_3;
flat out highp vec4 flat_varying_vec4_4;
out lowp vec4 varying_vec4_0;
void main ()
{
  highp int tmpvar_1;
  highp int tmpvar_2;
  highp int tmpvar_3;
  highp int tmpvar_4;
  highp int tmpvar_5;
  tmpvar_1 = (aData.y >> 16);
  tmpvar_2 = (aData.y & 65535);
  tmpvar_3 = (aData.z & 65535);
  tmpvar_4 = (aData.z >> 16);
  tmpvar_5 = (aData.w & 16777215);
  highp float tmpvar_6;
  highp ivec2 tmpvar_7;
  highp uint tmpvar_8;
  tmpvar_8 = uint(aData.x);
  tmpvar_7.x = int((2u * (tmpvar_8 % 512u)));
  tmpvar_7.y = int((tmpvar_8 / 512u));
  highp vec4 tmpvar_9;
  tmpvar_9 = texelFetch (sPrimitiveHeadersF, tmpvar_7, 0);
  highp vec4 tmpvar_10;
  tmpvar_10 = texelFetch (sPrimitiveHeadersF, (tmpvar_7 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_11 = tmpvar_9.xy;
  tmpvar_12 = tmpvar_9.zw;
  highp ivec2 tmpvar_13;
  tmpvar_13.x = int((2u * (tmpvar_8 % 512u)));
  tmpvar_13.y = int((tmpvar_8 / 512u));
  highp ivec4 tmpvar_14;
  tmpvar_14 = texelFetch (sPrimitiveHeadersI, tmpvar_13, 0);
  highp ivec4 tmpvar_15;
  tmpvar_15 = texelFetch (sPrimitiveHeadersI, (tmpvar_13 + ivec2(1, 0)), 0);
  tmpvar_6 = float(tmpvar_14.x);
  highp mat4 tmpvar_16;
  bool tmpvar_17;
  tmpvar_17 = ((tmpvar_14.z >> 24) == 0);
  highp int tmpvar_18;
  tmpvar_18 = (tmpvar_14.z & 16777215);
  highp ivec2 tmpvar_19;
  tmpvar_19.x = int((8u * (
    uint(tmpvar_18)
   % 128u)));
  tmpvar_19.y = int((uint(tmpvar_18) / 128u));
  tmpvar_16[0] = texelFetch (sTransformPalette, tmpvar_19, 0);
  tmpvar_16[1] = texelFetch (sTransformPalette, (tmpvar_19 + ivec2(1, 0)), 0);
  tmpvar_16[2] = texelFetch (sTransformPalette, (tmpvar_19 + ivec2(2, 0)), 0);
  tmpvar_16[3] = texelFetch (sTransformPalette, (tmpvar_19 + ivec2(3, 0)), 0);
  highp ivec2 tmpvar_20;
  tmpvar_20.x = int((2u * (
    uint(tmpvar_1)
   % 512u)));
  tmpvar_20.y = int((uint(tmpvar_1) / 512u));
  highp vec4 tmpvar_21;
  tmpvar_21 = texelFetch (sRenderTasks, tmpvar_20, 0);
  highp vec4 tmpvar_22;
  tmpvar_22 = texelFetch (sRenderTasks, (tmpvar_20 + ivec2(1, 0)), 0);
  RectWithSize tmpvar_23;
  highp float tmpvar_24;
  highp float tmpvar_25;
  highp vec2 tmpvar_26;
  if ((tmpvar_2 >= 32767)) {
    tmpvar_23 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_24 = 0.0;
    tmpvar_25 = 0.0;
    tmpvar_26 = vec2(0.0, 0.0);
  } else {
    highp ivec2 tmpvar_27;
    tmpvar_27.x = int((2u * (
      uint(tmpvar_2)
     % 512u)));
    tmpvar_27.y = int((uint(tmpvar_2) / 512u));
    highp vec4 tmpvar_28;
    tmpvar_28 = texelFetch (sRenderTasks, tmpvar_27, 0);
    highp vec4 tmpvar_29;
    tmpvar_29 = texelFetch (sRenderTasks, (tmpvar_27 + ivec2(1, 0)), 0);
    highp vec3 tmpvar_30;
    tmpvar_30 = tmpvar_29.yzw;
    tmpvar_23.p0 = tmpvar_28.xy;
    tmpvar_23.size = tmpvar_28.zw;
    tmpvar_24 = tmpvar_29.x;
    tmpvar_25 = tmpvar_30.x;
    tmpvar_26 = tmpvar_30.yz;
  };
  lowp vec2 tmpvar_31;
  highp vec4 tmpvar_32;
  highp vec2 tmpvar_33;
  highp vec2 tmpvar_34;
  highp vec4 segment_data_35;
  highp int tmpvar_36;
  tmpvar_36 = (tmpvar_4 & 255);
  highp int tmpvar_37;
  tmpvar_37 = ((tmpvar_4 >> 8) & 255);
  if ((tmpvar_3 == 65535)) {
    tmpvar_33 = tmpvar_11;
    tmpvar_34 = tmpvar_12;
    segment_data_35 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp int tmpvar_38;
    tmpvar_38 = ((tmpvar_14.y + 3) + (tmpvar_3 * 2));
    highp ivec2 tmpvar_39;
    tmpvar_39.x = int((uint(tmpvar_38) % 1024u));
    tmpvar_39.y = int((uint(tmpvar_38) / 1024u));
    highp vec4 tmpvar_40;
    tmpvar_40 = texelFetch (sGpuCache, tmpvar_39, 0);
    tmpvar_34 = tmpvar_40.zw;
    tmpvar_33 = (tmpvar_40.xy + tmpvar_9.xy);
    segment_data_35 = texelFetch (sGpuCache, (tmpvar_39 + ivec2(1, 0)), 0);
  };
  if (tmpvar_17) {
    lowp vec2 tmpvar_41;
    tmpvar_41 = clamp ((tmpvar_33 + (tmpvar_34 * aPosition)), tmpvar_10.xy, (tmpvar_10.xy + tmpvar_10.zw));
    lowp vec4 tmpvar_42;
    tmpvar_42.zw = vec2(0.0, 1.0);
    tmpvar_42.xy = tmpvar_41;
    highp vec4 tmpvar_43;
    tmpvar_43 = (tmpvar_16 * tmpvar_42);
    highp vec4 tmpvar_44;
    tmpvar_44.xy = ((tmpvar_43.xy * tmpvar_22.y) + ((
      -(tmpvar_22.zw)
     + tmpvar_21.xy) * tmpvar_43.w));
    tmpvar_44.z = (tmpvar_6 * tmpvar_43.w);
    tmpvar_44.w = tmpvar_43.w;
    gl_Position = (uTransform * tmpvar_44);
    tmpvar_31 = tmpvar_41;
    tmpvar_32 = tmpvar_43;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    lowp vec4 tmpvar_45;
    tmpvar_45 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_36 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_46;
    lowp vec2 tmpvar_47;
    tmpvar_46 = tmpvar_33;
    tmpvar_47 = tmpvar_34;
    highp vec2 tmpvar_48;
    tmpvar_48 = (tmpvar_10.xy + tmpvar_10.zw);
    lowp vec2 tmpvar_49;
    tmpvar_49 = clamp (tmpvar_46, tmpvar_10.xy, tmpvar_48);
    lowp vec2 tmpvar_50;
    tmpvar_50 = clamp ((tmpvar_46 + tmpvar_47), tmpvar_10.xy, tmpvar_48);
    lowp vec4 tmpvar_51;
    tmpvar_51 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_45);
    tmpvar_46 = (tmpvar_46 - tmpvar_51.xy);
    tmpvar_47 = (tmpvar_47 + (tmpvar_51.xy + tmpvar_51.zw));
    lowp vec2 tmpvar_52;
    tmpvar_52 = (tmpvar_46 + (tmpvar_47 * aPosition));
    lowp vec4 tmpvar_53;
    tmpvar_53.zw = vec2(0.0, 1.0);
    tmpvar_53.xy = tmpvar_52;
    highp vec4 tmpvar_54;
    tmpvar_54 = (tmpvar_16 * tmpvar_53);
    highp vec4 tmpvar_55;
    tmpvar_55.xy = ((tmpvar_54.xy * tmpvar_22.y) + ((tmpvar_21.xy - tmpvar_22.zw) * tmpvar_54.w));
    tmpvar_55.z = (tmpvar_6 * tmpvar_54.w);
    tmpvar_55.w = tmpvar_54.w;
    gl_Position = (uTransform * tmpvar_55);
    highp vec4 tmpvar_56;
    tmpvar_56.xy = clamp (tmpvar_9.xy, tmpvar_10.xy, tmpvar_48);
    tmpvar_56.zw = clamp ((tmpvar_9.xy + tmpvar_9.zw), tmpvar_10.xy, tmpvar_48);
    lowp vec4 tmpvar_57;
    tmpvar_57.xy = tmpvar_49;
    tmpvar_57.zw = tmpvar_50;
    vTransformBounds = mix (tmpvar_56, tmpvar_57, tmpvar_45);
    tmpvar_31 = tmpvar_52;
    tmpvar_32 = tmpvar_54;
  };
  vec4 tmpvar_58;
  tmpvar_58.xy = tmpvar_23.p0;
  tmpvar_58.zw = (tmpvar_23.p0 + tmpvar_23.size);
  vClipMaskUvBounds = tmpvar_58;
  highp vec4 tmpvar_59;
  tmpvar_59.xy = ((tmpvar_32.xy * tmpvar_25) + (tmpvar_32.w * (tmpvar_23.p0 - tmpvar_26)));
  tmpvar_59.z = tmpvar_24;
  tmpvar_59.w = tmpvar_32.w;
  vClipMaskUv = tmpvar_59;
  highp int color_mode_60;
  lowp vec2 f_61;
  highp vec2 stretch_size_62;
  highp vec2 tmpvar_63;
  highp vec2 tmpvar_64;
  highp vec2 uv1_65;
  highp vec2 uv0_66;
  highp vec4 tmpvar_67;
  highp ivec2 tmpvar_68;
  tmpvar_68.x = int((uint(tmpvar_14.y) % 1024u));
  tmpvar_68.y = int((uint(tmpvar_14.y) / 1024u));
  highp vec4 tmpvar_69;
  highp vec4 tmpvar_70;
  highp vec4 tmpvar_71;
  tmpvar_69 = texelFetch (sGpuCache, tmpvar_68, 0);
  tmpvar_70 = texelFetch (sGpuCache, (tmpvar_68 + ivec2(1, 0)), 0);
  tmpvar_71 = texelFetch (sGpuCache, (tmpvar_68 + ivec2(2, 0)), 0);
  tmpvar_67 = tmpvar_69;
  lowp vec2 tmpvar_72;
  tmpvar_72 = vec2(textureSize (sColor0, 0));
  highp ivec2 tmpvar_73;
  tmpvar_73.x = int((uint(tmpvar_5) % 1024u));
  tmpvar_73.y = int((uint(tmpvar_5) / 1024u));
  highp vec4 tmpvar_74;
  tmpvar_74 = texelFetch (sGpuCache, tmpvar_73, 0);
  highp float tmpvar_75;
  tmpvar_75 = texelFetch (sGpuCache, (tmpvar_73 + ivec2(1, 0)), 0).x;
  uv0_66 = tmpvar_74.xy;
  uv1_65 = tmpvar_74.zw;
  tmpvar_63 = tmpvar_11;
  tmpvar_64 = tmpvar_12;
  stretch_size_62 = tmpvar_71.xy;
  if ((tmpvar_71.x < 0.0)) {
    stretch_size_62 = tmpvar_12;
  };
  if (((tmpvar_37 & 2) != 0)) {
    tmpvar_63 = tmpvar_33;
    tmpvar_64 = tmpvar_34;
    stretch_size_62 = tmpvar_34;
    if (((tmpvar_37 & 128) != 0)) {
      highp vec2 tmpvar_76;
      tmpvar_76 = (tmpvar_74.zw - tmpvar_74.xy);
      uv0_66 = (tmpvar_74.xy + (segment_data_35.xy * tmpvar_76));
      uv1_65 = (tmpvar_74.xy + (segment_data_35.zw * tmpvar_76));
    };
  };
  highp float tmpvar_77;
  if (((tmpvar_37 & 1) != 0)) {
    tmpvar_77 = 1.0;
  } else {
    tmpvar_77 = 0.0;
  };
  flat_varying_vec4_4.x = tmpvar_75;
  flat_varying_vec4_4.y = tmpvar_77;
  highp vec2 tmpvar_78;
  tmpvar_78 = min (uv0_66, uv1_65);
  highp vec2 tmpvar_79;
  tmpvar_79 = max (uv0_66, uv1_65);
  highp vec4 tmpvar_80;
  tmpvar_80.xy = (tmpvar_78 + vec2(0.5, 0.5));
  tmpvar_80.zw = (tmpvar_79 - vec2(0.5, 0.5));
  flat_varying_vec4_3 = (tmpvar_80 / tmpvar_72.xyxy);
  lowp vec2 tmpvar_81;
  tmpvar_81 = ((tmpvar_31 - tmpvar_63) / tmpvar_64);
  f_61 = tmpvar_81;
  highp int tmpvar_82;
  tmpvar_82 = (tmpvar_15.x & 65535);
  color_mode_60 = tmpvar_82;
  highp int tmpvar_83;
  tmpvar_83 = (tmpvar_15.x >> 16);
  if ((tmpvar_82 == 0)) {
    color_mode_60 = uMode;
  };
  bool tmpvar_84;
  tmpvar_84 = bool(0);
  bool tmpvar_85;
  tmpvar_85 = bool(0);
  if ((1 == tmpvar_15.y)) tmpvar_84 = bool(1);
  if (tmpvar_85) tmpvar_84 = bool(0);
  if (tmpvar_84) {
    lowp vec2 tmpvar_86;
    highp int address_87;
    address_87 = (tmpvar_5 + 2);
    highp ivec2 tmpvar_88;
    tmpvar_88.x = int((uint(address_87) % 1024u));
    tmpvar_88.y = int((uint(address_87) / 1024u));
    highp vec4 tmpvar_89;
    tmpvar_89 = mix (mix (texelFetch (sGpuCache, tmpvar_88, 0), texelFetch (sGpuCache, (tmpvar_88 + ivec2(1, 0)), 0), tmpvar_81.x), mix (texelFetch (sGpuCache, (tmpvar_88 + ivec2(2, 0)), 0), texelFetch (sGpuCache, (tmpvar_88 + ivec2(3, 0)), 0), tmpvar_81.x), tmpvar_81.y);
    tmpvar_86 = (tmpvar_89.xy / tmpvar_89.w);
    f_61 = tmpvar_86;
    tmpvar_85 = bool(1);
  };
  tmpvar_84 = bool(1);
  if (tmpvar_85) tmpvar_84 = bool(0);
  if (tmpvar_84) {
    tmpvar_85 = bool(1);
  };
  highp vec2 tmpvar_90;
  tmpvar_90 = (tmpvar_64 / stretch_size_62);
  highp vec2 tmpvar_91;
  tmpvar_91 = mix (uv0_66, uv1_65, f_61);
  varying_vec4_0.zw = (tmpvar_91 - tmpvar_78);
  varying_vec4_0.zw = (varying_vec4_0.zw / tmpvar_72);
  varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_90);
  if ((tmpvar_77 == 0.0)) {
    varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_32.w);
  };
  highp vec4 tmpvar_92;
  tmpvar_92.xy = tmpvar_78;
  tmpvar_92.zw = tmpvar_79;
  flat_varying_vec4_2 = (tmpvar_92 / tmpvar_72.xyxy);
  flat_varying_vec4_1.zw = tmpvar_90;
  highp float tmpvar_93;
  tmpvar_93 = (float(tmpvar_15.z) / 65535.0);
  bool tmpvar_94;
  tmpvar_94 = bool(0);
  bool tmpvar_95;
  tmpvar_95 = bool(0);
  if ((0 == tmpvar_83)) tmpvar_94 = bool(1);
  if (tmpvar_95) tmpvar_94 = bool(0);
  if (tmpvar_94) {
    tmpvar_67.w = (tmpvar_69.w * tmpvar_93);
    tmpvar_95 = bool(1);
  };
  tmpvar_94 = bool(1);
  if (tmpvar_95) tmpvar_94 = bool(0);
  if (tmpvar_94) {
    tmpvar_67 = (tmpvar_67 * tmpvar_93);
    tmpvar_95 = bool(1);
  };
  bool tmpvar_96;
  tmpvar_96 = bool(0);
  bool tmpvar_97;
  tmpvar_97 = bool(0);
  if ((1 == color_mode_60)) tmpvar_96 = bool(1);
  if ((7 == color_mode_60)) tmpvar_96 = bool(1);
  if (tmpvar_97) tmpvar_96 = bool(0);
  if (tmpvar_96) {
    flat_varying_vec4_1.xy = vec2(0.0, 1.0);
    flat_varying_vec4_0 = tmpvar_67;
    tmpvar_97 = bool(1);
  };
  if ((5 == color_mode_60)) tmpvar_96 = bool(1);
  if ((6 == color_mode_60)) tmpvar_96 = bool(1);
  if ((9 == color_mode_60)) tmpvar_96 = bool(1);
  if (tmpvar_97) tmpvar_96 = bool(0);
  if (tmpvar_96) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_67;
    tmpvar_97 = bool(1);
  };
  if ((2 == color_mode_60)) tmpvar_96 = bool(1);
  if ((3 == color_mode_60)) tmpvar_96 = bool(1);
  if ((8 == color_mode_60)) tmpvar_96 = bool(1);
  if (tmpvar_97) tmpvar_96 = bool(0);
  if (tmpvar_96) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_67.wwww;
    tmpvar_97 = bool(1);
  };
  if ((4 == color_mode_60)) tmpvar_96 = bool(1);
  if (tmpvar_97) tmpvar_96 = bool(0);
  if (tmpvar_96) {
    flat_varying_vec4_1.xy = vec2(-1.0, 1.0);
    flat_varying_vec4_0 = (tmpvar_67.wwww * tmpvar_70);
    tmpvar_97 = bool(1);
  };
  tmpvar_96 = bool(1);
  if (tmpvar_97) tmpvar_96 = bool(0);
  if (tmpvar_96) {
    flat_varying_vec4_1.xy = vec2(0.0, 0.0);
    flat_varying_vec4_0 = vec4(1.0, 1.0, 1.0, 1.0);
  };
  varying_vec4_0.xy = tmpvar_31;
}

