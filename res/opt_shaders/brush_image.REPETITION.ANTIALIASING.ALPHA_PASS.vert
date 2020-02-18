#version 310 es
precision highp sampler2DArray;
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform highp int uMode;
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
flat out highp vec4 flat_varying_vec4_0;
flat out highp vec4 flat_varying_vec4_1;
flat out lowp vec4 flat_varying_vec4_2;
flat out lowp vec4 flat_varying_vec4_3;
flat out highp vec4 flat_varying_vec4_4;
out lowp vec4 varying_vec4_0;
void main ()
{
  lowp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 segment_data_5;
  highp int tmpvar_6;
  highp int tmpvar_7;
  highp int tmpvar_8;
  highp int tmpvar_9;
  highp int tmpvar_10;
  tmpvar_6 = (aData.y >> 16);
  tmpvar_7 = (aData.y & 65535);
  tmpvar_8 = (aData.z & 65535);
  tmpvar_9 = (aData.z >> 16);
  tmpvar_10 = (aData.w & 16777215);
  highp int tmpvar_11;
  tmpvar_11 = (tmpvar_9 & 255);
  highp int tmpvar_12;
  tmpvar_12 = ((tmpvar_9 >> 8) & 255);
  highp float tmpvar_13;
  highp ivec2 tmpvar_14;
  highp uint tmpvar_15;
  tmpvar_15 = uint(aData.x);
  tmpvar_14.x = int((2u * (uint(tmpvar_15 % 512u))));
  tmpvar_14.y = int((tmpvar_15 / 512u));
  highp vec4 tmpvar_16;
  tmpvar_16 = texelFetch (sPrimitiveHeadersF, tmpvar_14, 0);
  highp vec4 tmpvar_17;
  tmpvar_17 = texelFetch (sPrimitiveHeadersF, (tmpvar_14 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_18 = tmpvar_16.xy;
  tmpvar_19 = tmpvar_16.zw;
  highp ivec2 tmpvar_20;
  tmpvar_20.x = int((2u * (uint(tmpvar_15 % 512u))));
  tmpvar_20.y = int((tmpvar_15 / 512u));
  highp ivec4 tmpvar_21;
  tmpvar_21 = texelFetch (sPrimitiveHeadersI, tmpvar_20, 0);
  highp ivec4 tmpvar_22;
  tmpvar_22 = texelFetch (sPrimitiveHeadersI, (tmpvar_20 + ivec2(1, 0)), 0);
  tmpvar_13 = float(tmpvar_21.x);
  if ((tmpvar_8 == 65535)) {
    tmpvar_3 = tmpvar_18;
    tmpvar_4 = tmpvar_19;
    segment_data_5 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp int tmpvar_23;
    tmpvar_23 = ((tmpvar_21.y + 3) + (tmpvar_8 * 2));
    highp ivec2 tmpvar_24;
    tmpvar_24.x = int((uint(uint(tmpvar_23) % 1024u)));
    tmpvar_24.y = int((uint(tmpvar_23) / 1024u));
    highp vec4 tmpvar_25;
    tmpvar_25 = texelFetch (sGpuCache, tmpvar_24, 0);
    tmpvar_4 = tmpvar_25.zw;
    tmpvar_3 = (tmpvar_25.xy + tmpvar_16.xy);
    segment_data_5 = texelFetch (sGpuCache, (tmpvar_24 + ivec2(1, 0)), 0);
  };
  highp ivec2 tmpvar_26;
  tmpvar_26.x = int((2u * (uint(
    uint(tmpvar_6)
   % 512u))));
  tmpvar_26.y = int((uint(tmpvar_6) / 512u));
  highp vec4 tmpvar_27;
  tmpvar_27 = texelFetch (sRenderTasks, tmpvar_26, 0);
  highp vec4 tmpvar_28;
  tmpvar_28 = texelFetch (sRenderTasks, (tmpvar_26 + ivec2(1, 0)), 0);
  RectWithSize tmpvar_29;
  highp float tmpvar_30;
  highp float tmpvar_31;
  highp vec2 tmpvar_32;
  if ((tmpvar_7 >= 32767)) {
    tmpvar_29 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_30 = 0.0;
    tmpvar_31 = 0.0;
    tmpvar_32 = vec2(0.0, 0.0);
  } else {
    highp ivec2 tmpvar_33;
    tmpvar_33.x = int((2u * (uint(
      uint(tmpvar_7)
     % 512u))));
    tmpvar_33.y = int((uint(tmpvar_7) / 512u));
    highp vec4 tmpvar_34;
    tmpvar_34 = texelFetch (sRenderTasks, tmpvar_33, 0);
    highp vec4 tmpvar_35;
    tmpvar_35 = texelFetch (sRenderTasks, (tmpvar_33 + ivec2(1, 0)), 0);
    highp vec3 tmpvar_36;
    tmpvar_36 = tmpvar_35.yzw;
    tmpvar_29.p0 = tmpvar_34.xy;
    tmpvar_29.size = tmpvar_34.zw;
    tmpvar_30 = tmpvar_35.x;
    tmpvar_31 = tmpvar_36.x;
    tmpvar_32 = tmpvar_36.yz;
  };
  highp mat4 tmpvar_37;
  highp int tmpvar_38;
  tmpvar_38 = (tmpvar_21.z & 16777215);
  highp ivec2 tmpvar_39;
  tmpvar_39.x = int((8u * (uint(
    uint(tmpvar_38)
   % 128u))));
  tmpvar_39.y = int((uint(tmpvar_38) / 128u));
  tmpvar_37[0] = texelFetch (sTransformPalette, tmpvar_39, 0);
  tmpvar_37[1] = texelFetch (sTransformPalette, (tmpvar_39 + ivec2(1, 0)), 0);
  tmpvar_37[2] = texelFetch (sTransformPalette, (tmpvar_39 + ivec2(2, 0)), 0);
  tmpvar_37[3] = texelFetch (sTransformPalette, (tmpvar_39 + ivec2(3, 0)), 0);
  if (((tmpvar_21.z >> 24) == 0)) {
    lowp vec2 tmpvar_40;
    tmpvar_40 = clamp ((tmpvar_3 + (tmpvar_4 * aPosition.xy)), tmpvar_17.xy, (tmpvar_17.xy + tmpvar_17.zw));
    lowp vec4 tmpvar_41;
    tmpvar_41.zw = vec2(0.0, 1.0);
    tmpvar_41.xy = tmpvar_40;
    highp vec4 tmpvar_42;
    tmpvar_42 = (tmpvar_37 * tmpvar_41);
    highp vec4 tmpvar_43;
    tmpvar_43.xy = ((tmpvar_42.xy * tmpvar_28.y) + ((
      -(tmpvar_28.zw)
     + tmpvar_27.xy) * tmpvar_42.w));
    tmpvar_43.z = (tmpvar_13 * tmpvar_42.w);
    tmpvar_43.w = tmpvar_42.w;
    gl_Position = (uTransform * tmpvar_43);
    tmpvar_1 = tmpvar_40;
    tmpvar_2 = tmpvar_42;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    lowp vec4 tmpvar_44;
    tmpvar_44 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_11 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_45;
    lowp vec2 tmpvar_46;
    tmpvar_45 = tmpvar_3;
    tmpvar_46 = tmpvar_4;
    highp vec2 tmpvar_47;
    tmpvar_47 = (tmpvar_17.xy + tmpvar_17.zw);
    lowp vec2 tmpvar_48;
    tmpvar_48 = clamp (tmpvar_45, tmpvar_17.xy, tmpvar_47);
    lowp vec2 tmpvar_49;
    tmpvar_49 = clamp ((tmpvar_45 + tmpvar_46), tmpvar_17.xy, tmpvar_47);
    lowp vec4 tmpvar_50;
    tmpvar_50 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_44);
    tmpvar_45 = (tmpvar_45 - tmpvar_50.xy);
    tmpvar_46 = (tmpvar_46 + (tmpvar_50.xy + tmpvar_50.zw));
    lowp vec2 tmpvar_51;
    tmpvar_51 = (tmpvar_45 + (tmpvar_46 * aPosition.xy));
    lowp vec4 tmpvar_52;
    tmpvar_52.zw = vec2(0.0, 1.0);
    tmpvar_52.xy = tmpvar_51;
    highp vec4 tmpvar_53;
    tmpvar_53 = (tmpvar_37 * tmpvar_52);
    highp vec4 tmpvar_54;
    tmpvar_54.xy = ((tmpvar_53.xy * tmpvar_28.y) + ((tmpvar_27.xy - tmpvar_28.zw) * tmpvar_53.w));
    tmpvar_54.z = (tmpvar_13 * tmpvar_53.w);
    tmpvar_54.w = tmpvar_53.w;
    gl_Position = (uTransform * tmpvar_54);
    highp vec4 tmpvar_55;
    tmpvar_55.xy = clamp (tmpvar_16.xy, tmpvar_17.xy, tmpvar_47);
    tmpvar_55.zw = clamp ((tmpvar_16.xy + tmpvar_16.zw), tmpvar_17.xy, tmpvar_47);
    lowp vec4 tmpvar_56;
    tmpvar_56.xy = tmpvar_48;
    tmpvar_56.zw = tmpvar_49;
    vTransformBounds = mix (tmpvar_55, tmpvar_56, tmpvar_44);
    tmpvar_1 = tmpvar_51;
    tmpvar_2 = tmpvar_53;
  };
  vec4 tmpvar_57;
  tmpvar_57.xy = tmpvar_29.p0;
  tmpvar_57.zw = (tmpvar_29.p0 + tmpvar_29.size);
  vClipMaskUvBounds = tmpvar_57;
  highp vec4 tmpvar_58;
  tmpvar_58.xy = ((tmpvar_2.xy * tmpvar_31) + (tmpvar_2.w * (tmpvar_29.p0 - tmpvar_32)));
  tmpvar_58.z = tmpvar_30;
  tmpvar_58.w = tmpvar_2.w;
  vClipMaskUv = tmpvar_58;
  highp int color_mode_59;
  highp vec2 f_60;
  highp vec2 stretch_size_61;
  highp vec2 tmpvar_62;
  highp vec2 tmpvar_63;
  highp vec2 uv1_64;
  highp vec2 uv0_65;
  highp vec4 tmpvar_66;
  highp ivec2 tmpvar_67;
  tmpvar_67.x = int((uint(uint(tmpvar_21.y) % 1024u)));
  tmpvar_67.y = int((uint(tmpvar_21.y) / 1024u));
  highp vec4 tmpvar_68;
  highp vec4 tmpvar_69;
  highp vec4 tmpvar_70;
  tmpvar_68 = texelFetch (sGpuCache, tmpvar_67, 0);
  tmpvar_69 = texelFetch (sGpuCache, (tmpvar_67 + ivec2(1, 0)), 0);
  tmpvar_70 = texelFetch (sGpuCache, (tmpvar_67 + ivec2(2, 0)), 0);
  tmpvar_66 = tmpvar_68;
  lowp vec2 tmpvar_71;
  tmpvar_71 = vec3(textureSize (sColor0, 0)).xy;
  highp ivec2 tmpvar_72;
  tmpvar_72.x = int((uint(uint(tmpvar_10) % 1024u)));
  tmpvar_72.y = int((uint(tmpvar_10) / 1024u));
  highp vec4 tmpvar_73;
  tmpvar_73 = texelFetch (sGpuCache, tmpvar_72, 0);
  highp float tmpvar_74;
  tmpvar_74 = texelFetch (sGpuCache, (tmpvar_72 + ivec2(1, 0)), 0).x;
  uv0_65 = tmpvar_73.xy;
  uv1_64 = tmpvar_73.zw;
  tmpvar_62 = tmpvar_18;
  tmpvar_63 = tmpvar_19;
  stretch_size_61 = tmpvar_70.xy;
  if ((tmpvar_70.x < 0.0)) {
    stretch_size_61 = tmpvar_19;
  };
  if (((tmpvar_12 & 2) != 0)) {
    tmpvar_62 = tmpvar_3;
    tmpvar_63 = tmpvar_4;
    stretch_size_61 = tmpvar_4;
    if (((tmpvar_12 & 128) != 0)) {
      highp vec2 original_stretch_size_75;
      highp vec2 segment_uv_size_76;
      highp vec2 tmpvar_77;
      tmpvar_77 = (tmpvar_73.zw - tmpvar_73.xy);
      uv0_65 = (tmpvar_73.xy + (segment_data_5.xy * tmpvar_77));
      uv1_64 = (tmpvar_73.xy + (segment_data_5.zw * tmpvar_77));
      segment_uv_size_76 = (uv1_64 - uv0_65);
      if (((tmpvar_12 & 64) != 0)) {
        segment_uv_size_76 = (uv0_65 - tmpvar_73.xy);
        stretch_size_61 = (tmpvar_3 - tmpvar_16.xy);
        if (((segment_uv_size_76.x < 0.001) || (stretch_size_61.x < 0.001))) {
          segment_uv_size_76.x = (tmpvar_73.z - uv1_64.x);
          stretch_size_61.x = (((tmpvar_16.x + tmpvar_16.z) - tmpvar_3.x) - tmpvar_4.x);
        };
        if (((segment_uv_size_76.y < 0.001) || (stretch_size_61.y < 0.001))) {
          segment_uv_size_76.y = (tmpvar_73.w - uv1_64.y);
          stretch_size_61.y = (((tmpvar_16.y + tmpvar_16.w) - tmpvar_3.y) - tmpvar_4.y);
        };
      };
      original_stretch_size_75 = stretch_size_61;
      if (((tmpvar_12 & 4) != 0)) {
        stretch_size_61.x = ((stretch_size_61.y / segment_uv_size_76.y) * segment_uv_size_76.x);
      };
      if (((tmpvar_12 & 8) != 0)) {
        stretch_size_61.y = ((original_stretch_size_75.x / segment_uv_size_76.x) * segment_uv_size_76.y);
      };
    } else {
      if (((tmpvar_12 & 4) != 0)) {
        stretch_size_61.x = (segment_data_5.z - segment_data_5.x);
      };
      if (((tmpvar_12 & 8) != 0)) {
        stretch_size_61.y = (segment_data_5.w - segment_data_5.y);
      };
    };
    if (((tmpvar_12 & 16) != 0)) {
      stretch_size_61.x = (tmpvar_4.x / max (1.0, roundEven(
        (tmpvar_4.x / stretch_size_61.x)
      )));
    };
    if (((tmpvar_12 & 32) != 0)) {
      stretch_size_61.y = (tmpvar_4.y / max (1.0, roundEven(
        (tmpvar_4.y / stretch_size_61.y)
      )));
    };
  };
  highp float tmpvar_78;
  if (((tmpvar_12 & 1) != 0)) {
    tmpvar_78 = 1.0;
  } else {
    tmpvar_78 = 0.0;
  };
  flat_varying_vec4_4.x = tmpvar_74;
  flat_varying_vec4_4.y = tmpvar_78;
  highp vec2 tmpvar_79;
  tmpvar_79 = min (uv0_65, uv1_64);
  highp vec2 tmpvar_80;
  tmpvar_80 = max (uv0_65, uv1_64);
  highp vec4 tmpvar_81;
  tmpvar_81.xy = (tmpvar_79 + vec2(0.5, 0.5));
  tmpvar_81.zw = (tmpvar_80 - vec2(0.5, 0.5));
  flat_varying_vec4_3 = (tmpvar_81 / tmpvar_71.xyxy);
  highp vec2 tmpvar_82;
  tmpvar_82 = ((tmpvar_1 - tmpvar_62) / tmpvar_63);
  f_60 = tmpvar_82;
  highp int tmpvar_83;
  tmpvar_83 = (tmpvar_22.x & 65535);
  color_mode_59 = tmpvar_83;
  highp int tmpvar_84;
  tmpvar_84 = (tmpvar_22.x >> 16);
  if ((tmpvar_83 == 0)) {
    color_mode_59 = uMode;
  };
  bool tmpvar_85;
  tmpvar_85 = bool(0);
  bool tmpvar_86;
  tmpvar_86 = bool(0);
  if ((1 == tmpvar_22.y)) tmpvar_85 = bool(1);
  if (tmpvar_86) tmpvar_85 = bool(0);
  if (tmpvar_85) {
    highp int address_87;
    address_87 = (tmpvar_10 + 2);
    highp ivec2 tmpvar_88;
    tmpvar_88.x = int((uint(uint(address_87) % 1024u)));
    tmpvar_88.y = int((uint(address_87) / 1024u));
    highp vec4 tmpvar_89;
    tmpvar_89 = mix (mix (texelFetch (sGpuCache, tmpvar_88, 0), texelFetch (sGpuCache, (tmpvar_88 + ivec2(1, 0)), 0), tmpvar_82.x), mix (texelFetch (sGpuCache, (tmpvar_88 + ivec2(2, 0)), 0), texelFetch (sGpuCache, (tmpvar_88 + ivec2(3, 0)), 0), tmpvar_82.x), tmpvar_82.y);
    f_60 = (tmpvar_89.xy / tmpvar_89.w);
    tmpvar_86 = bool(1);
  };
  tmpvar_85 = bool(1);
  if (tmpvar_86) tmpvar_85 = bool(0);
  if (tmpvar_85) {
    tmpvar_86 = bool(1);
  };
  highp vec2 tmpvar_90;
  tmpvar_90 = (tmpvar_63 / stretch_size_61);
  highp vec2 tmpvar_91;
  tmpvar_91 = mix (uv0_65, uv1_64, f_60);
  varying_vec4_0.zw = (tmpvar_91 - tmpvar_79);
  varying_vec4_0.zw = (varying_vec4_0.zw / tmpvar_71);
  varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_90);
  if ((tmpvar_78 == 0.0)) {
    varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_2.w);
  };
  highp vec4 tmpvar_92;
  tmpvar_92.xy = tmpvar_79;
  tmpvar_92.zw = tmpvar_80;
  flat_varying_vec4_2 = (tmpvar_92 / tmpvar_71.xyxy);
  flat_varying_vec4_1.zw = tmpvar_90;
  highp float tmpvar_93;
  tmpvar_93 = (float(tmpvar_22.z) / 65535.0);
  bool tmpvar_94;
  tmpvar_94 = bool(0);
  bool tmpvar_95;
  tmpvar_95 = bool(0);
  if ((0 == tmpvar_84)) tmpvar_94 = bool(1);
  if (tmpvar_95) tmpvar_94 = bool(0);
  if (tmpvar_94) {
    tmpvar_66.w = (tmpvar_68.w * tmpvar_93);
    tmpvar_95 = bool(1);
  };
  tmpvar_94 = bool(1);
  if (tmpvar_95) tmpvar_94 = bool(0);
  if (tmpvar_94) {
    tmpvar_66 = (tmpvar_66 * tmpvar_93);
    tmpvar_95 = bool(1);
  };
  bool tmpvar_96;
  tmpvar_96 = bool(0);
  bool tmpvar_97;
  tmpvar_97 = bool(0);
  if ((1 == color_mode_59)) tmpvar_96 = bool(1);
  if ((7 == color_mode_59)) tmpvar_96 = bool(1);
  if (tmpvar_97) tmpvar_96 = bool(0);
  if (tmpvar_96) {
    flat_varying_vec4_1.xy = vec2(0.0, 1.0);
    flat_varying_vec4_0 = tmpvar_66;
    tmpvar_97 = bool(1);
  };
  if ((5 == color_mode_59)) tmpvar_96 = bool(1);
  if ((6 == color_mode_59)) tmpvar_96 = bool(1);
  if ((9 == color_mode_59)) tmpvar_96 = bool(1);
  if (tmpvar_97) tmpvar_96 = bool(0);
  if (tmpvar_96) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_66;
    tmpvar_97 = bool(1);
  };
  if ((2 == color_mode_59)) tmpvar_96 = bool(1);
  if ((3 == color_mode_59)) tmpvar_96 = bool(1);
  if ((8 == color_mode_59)) tmpvar_96 = bool(1);
  if (tmpvar_97) tmpvar_96 = bool(0);
  if (tmpvar_96) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_66.wwww;
    tmpvar_97 = bool(1);
  };
  if ((4 == color_mode_59)) tmpvar_96 = bool(1);
  if (tmpvar_97) tmpvar_96 = bool(0);
  if (tmpvar_96) {
    flat_varying_vec4_1.xy = vec2(-1.0, 1.0);
    flat_varying_vec4_0 = (tmpvar_66.wwww * tmpvar_69);
    tmpvar_97 = bool(1);
  };
  tmpvar_96 = bool(1);
  if (tmpvar_97) tmpvar_96 = bool(0);
  if (tmpvar_96) {
    flat_varying_vec4_1.xy = vec2(0.0, 0.0);
    flat_varying_vec4_0 = vec4(1.0, 1.0, 1.0, 1.0);
  };
  varying_vec4_0.xy = tmpvar_1;
}

