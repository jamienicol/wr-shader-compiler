#version 150
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform int uMode;
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2DRect sColor0;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
out vec4 varying_vec4_0;
void main ()
{
  int tmpvar_1;
  int tmpvar_2;
  int tmpvar_3;
  int tmpvar_4;
  int tmpvar_5;
  tmpvar_1 = (aData.y >> 16);
  tmpvar_2 = (aData.y & 65535);
  tmpvar_3 = (aData.z & 65535);
  tmpvar_4 = (aData.z >> 16);
  tmpvar_5 = (aData.w & 16777215);
  float tmpvar_6;
  ivec2 tmpvar_7;
  uint tmpvar_8;
  tmpvar_8 = uint(aData.x);
  tmpvar_7.x = int((2u * (tmpvar_8 % 512u)));
  tmpvar_7.y = int((tmpvar_8 / 512u));
  vec4 tmpvar_9;
  tmpvar_9 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_7, 0, ivec2(0, 0));
  vec4 tmpvar_10;
  tmpvar_10 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_7, 0, ivec2(1, 0));
  vec2 tmpvar_11;
  vec2 tmpvar_12;
  tmpvar_11 = tmpvar_9.xy;
  tmpvar_12 = tmpvar_9.zw;
  ivec2 tmpvar_13;
  tmpvar_13.x = int((2u * (tmpvar_8 % 512u)));
  tmpvar_13.y = int((tmpvar_8 / 512u));
  ivec4 tmpvar_14;
  tmpvar_14 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_13, 0, ivec2(0, 0));
  ivec4 tmpvar_15;
  tmpvar_15 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_13, 0, ivec2(1, 0));
  tmpvar_6 = float(tmpvar_14.x);
  mat4 tmpvar_16;
  bool tmpvar_17;
  tmpvar_17 = ((tmpvar_14.z >> 24) == 0);
  int tmpvar_18;
  tmpvar_18 = (tmpvar_14.z & 16777215);
  ivec2 tmpvar_19;
  tmpvar_19.x = int((8u * (
    uint(tmpvar_18)
   % 128u)));
  tmpvar_19.y = int((uint(tmpvar_18) / 128u));
  tmpvar_16[0] = texelFetchOffset (sTransformPalette, tmpvar_19, 0, ivec2(0, 0));
  tmpvar_16[1] = texelFetchOffset (sTransformPalette, tmpvar_19, 0, ivec2(1, 0));
  tmpvar_16[2] = texelFetchOffset (sTransformPalette, tmpvar_19, 0, ivec2(2, 0));
  tmpvar_16[3] = texelFetchOffset (sTransformPalette, tmpvar_19, 0, ivec2(3, 0));
  ivec2 tmpvar_20;
  tmpvar_20.x = int((2u * (
    uint(tmpvar_1)
   % 512u)));
  tmpvar_20.y = int((uint(tmpvar_1) / 512u));
  vec4 tmpvar_21;
  tmpvar_21 = texelFetchOffset (sRenderTasks, tmpvar_20, 0, ivec2(0, 0));
  vec4 tmpvar_22;
  tmpvar_22 = texelFetchOffset (sRenderTasks, tmpvar_20, 0, ivec2(1, 0));
  RectWithSize tmpvar_23;
  float tmpvar_24;
  float tmpvar_25;
  vec2 tmpvar_26;
  if ((tmpvar_2 >= 32767)) {
    tmpvar_23 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_24 = 0.0;
    tmpvar_25 = 0.0;
    tmpvar_26 = vec2(0.0, 0.0);
  } else {
    ivec2 tmpvar_27;
    tmpvar_27.x = int((2u * (
      uint(tmpvar_2)
     % 512u)));
    tmpvar_27.y = int((uint(tmpvar_2) / 512u));
    vec4 tmpvar_28;
    tmpvar_28 = texelFetchOffset (sRenderTasks, tmpvar_27, 0, ivec2(0, 0));
    vec4 tmpvar_29;
    tmpvar_29 = texelFetchOffset (sRenderTasks, tmpvar_27, 0, ivec2(1, 0));
    vec3 tmpvar_30;
    tmpvar_30 = tmpvar_29.yzw;
    tmpvar_23.p0 = tmpvar_28.xy;
    tmpvar_23.size = tmpvar_28.zw;
    tmpvar_24 = tmpvar_29.x;
    tmpvar_25 = tmpvar_30.x;
    tmpvar_26 = tmpvar_30.yz;
  };
  vec2 tmpvar_31;
  vec4 tmpvar_32;
  vec2 tmpvar_33;
  vec2 tmpvar_34;
  vec4 segment_data_35;
  int tmpvar_36;
  tmpvar_36 = (tmpvar_4 & 255);
  int tmpvar_37;
  tmpvar_37 = ((tmpvar_4 >> 8) & 255);
  if ((tmpvar_3 == 65535)) {
    tmpvar_33 = tmpvar_11;
    tmpvar_34 = tmpvar_12;
    segment_data_35 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    int tmpvar_38;
    tmpvar_38 = ((tmpvar_14.y + 3) + (tmpvar_3 * 2));
    ivec2 tmpvar_39;
    tmpvar_39.x = int((uint(tmpvar_38) % 1024u));
    tmpvar_39.y = int((uint(tmpvar_38) / 1024u));
    vec4 tmpvar_40;
    tmpvar_40 = texelFetchOffset (sGpuCache, tmpvar_39, 0, ivec2(0, 0));
    tmpvar_34 = tmpvar_40.zw;
    tmpvar_33 = (tmpvar_40.xy + tmpvar_9.xy);
    segment_data_35 = texelFetchOffset (sGpuCache, tmpvar_39, 0, ivec2(1, 0));
  };
  if (tmpvar_17) {
    vec2 tmpvar_41;
    tmpvar_41 = clamp ((tmpvar_33 + (tmpvar_34 * aPosition)), tmpvar_10.xy, (tmpvar_10.xy + tmpvar_10.zw));
    vec4 tmpvar_42;
    tmpvar_42.zw = vec2(0.0, 1.0);
    tmpvar_42.xy = tmpvar_41;
    vec4 tmpvar_43;
    tmpvar_43 = (tmpvar_16 * tmpvar_42);
    vec4 tmpvar_44;
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
    vec4 tmpvar_45;
    tmpvar_45 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_36 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 tmpvar_46;
    tmpvar_46 = (tmpvar_10.xy + tmpvar_10.zw);
    vec4 tmpvar_47;
    tmpvar_47 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_45);
    vec2 tmpvar_48;
    tmpvar_48 = ((tmpvar_33 - tmpvar_47.xy) + ((tmpvar_34 + 
      (tmpvar_47.xy + tmpvar_47.zw)
    ) * aPosition));
    vec4 tmpvar_49;
    tmpvar_49.zw = vec2(0.0, 1.0);
    tmpvar_49.xy = tmpvar_48;
    vec4 tmpvar_50;
    tmpvar_50 = (tmpvar_16 * tmpvar_49);
    vec4 tmpvar_51;
    tmpvar_51.xy = ((tmpvar_50.xy * tmpvar_22.y) + ((tmpvar_21.xy - tmpvar_22.zw) * tmpvar_50.w));
    tmpvar_51.z = (tmpvar_6 * tmpvar_50.w);
    tmpvar_51.w = tmpvar_50.w;
    gl_Position = (uTransform * tmpvar_51);
    vec4 tmpvar_52;
    tmpvar_52.xy = clamp (tmpvar_9.xy, tmpvar_10.xy, tmpvar_46);
    tmpvar_52.zw = clamp ((tmpvar_9.xy + tmpvar_9.zw), tmpvar_10.xy, tmpvar_46);
    vec4 tmpvar_53;
    tmpvar_53.xy = clamp (tmpvar_33, tmpvar_10.xy, tmpvar_46);
    tmpvar_53.zw = clamp ((tmpvar_33 + tmpvar_34), tmpvar_10.xy, tmpvar_46);
    vTransformBounds = mix (tmpvar_52, tmpvar_53, tmpvar_45);
    tmpvar_31 = tmpvar_48;
    tmpvar_32 = tmpvar_50;
  };
  vec4 tmpvar_54;
  tmpvar_54.xy = tmpvar_23.p0;
  tmpvar_54.zw = (tmpvar_23.p0 + tmpvar_23.size);
  vClipMaskUvBounds = tmpvar_54;
  vec4 tmpvar_55;
  tmpvar_55.xy = ((tmpvar_32.xy * tmpvar_25) + (tmpvar_32.w * (tmpvar_23.p0 - tmpvar_26)));
  tmpvar_55.z = tmpvar_24;
  tmpvar_55.w = tmpvar_32.w;
  vClipMaskUv = tmpvar_55;
  int color_mode_56;
  vec2 f_57;
  vec2 stretch_size_58;
  vec2 tmpvar_59;
  vec2 tmpvar_60;
  vec2 uv1_61;
  vec2 uv0_62;
  vec4 tmpvar_63;
  ivec2 tmpvar_64;
  tmpvar_64.x = int((uint(tmpvar_14.y) % 1024u));
  tmpvar_64.y = int((uint(tmpvar_14.y) / 1024u));
  vec4 tmpvar_65;
  vec4 tmpvar_66;
  vec4 tmpvar_67;
  tmpvar_65 = texelFetchOffset (sGpuCache, tmpvar_64, 0, ivec2(0, 0));
  tmpvar_66 = texelFetchOffset (sGpuCache, tmpvar_64, 0, ivec2(1, 0));
  tmpvar_67 = texelFetchOffset (sGpuCache, tmpvar_64, 0, ivec2(2, 0));
  tmpvar_63 = tmpvar_65;
  ivec2 tmpvar_68;
  tmpvar_68.x = int((uint(tmpvar_5) % 1024u));
  tmpvar_68.y = int((uint(tmpvar_5) / 1024u));
  vec4 tmpvar_69;
  tmpvar_69 = texelFetchOffset (sGpuCache, tmpvar_68, 0, ivec2(0, 0));
  float tmpvar_70;
  tmpvar_70 = texelFetchOffset (sGpuCache, tmpvar_68, 0, ivec2(1, 0)).x;
  uv0_62 = tmpvar_69.xy;
  uv1_61 = tmpvar_69.zw;
  tmpvar_59 = tmpvar_11;
  tmpvar_60 = tmpvar_12;
  stretch_size_58 = tmpvar_67.xy;
  if ((tmpvar_67.x < 0.0)) {
    stretch_size_58 = tmpvar_12;
  };
  if (((tmpvar_37 & 2) != 0)) {
    tmpvar_59 = tmpvar_33;
    tmpvar_60 = tmpvar_34;
    stretch_size_58 = tmpvar_34;
    if (((tmpvar_37 & 128) != 0)) {
      vec2 tmpvar_71;
      tmpvar_71 = (tmpvar_69.zw - tmpvar_69.xy);
      uv0_62 = (tmpvar_69.xy + (segment_data_35.xy * tmpvar_71));
      uv1_61 = (tmpvar_69.xy + (segment_data_35.zw * tmpvar_71));
    };
  };
  float tmpvar_72;
  if (((tmpvar_37 & 1) != 0)) {
    tmpvar_72 = 1.0;
  } else {
    tmpvar_72 = 0.0;
  };
  flat_varying_vec4_4.x = tmpvar_70;
  flat_varying_vec4_4.y = tmpvar_72;
  vec2 tmpvar_73;
  tmpvar_73 = min (uv0_62, uv1_61);
  vec4 tmpvar_74;
  tmpvar_74.xy = (tmpvar_73 + vec2(0.5, 0.5));
  tmpvar_74.zw = (max (uv0_62, uv1_61) - vec2(0.5, 0.5));
  flat_varying_vec4_3 = tmpvar_74;
  vec2 tmpvar_75;
  tmpvar_75 = ((tmpvar_31 - tmpvar_59) / tmpvar_60);
  f_57 = tmpvar_75;
  int tmpvar_76;
  tmpvar_76 = (tmpvar_15.x & 65535);
  color_mode_56 = tmpvar_76;
  int tmpvar_77;
  tmpvar_77 = (tmpvar_15.x >> 16);
  if ((tmpvar_76 == 0)) {
    color_mode_56 = uMode;
  };
  bool tmpvar_78;
  tmpvar_78 = bool(0);
  bool tmpvar_79;
  tmpvar_79 = bool(0);
  if ((1 == tmpvar_15.y)) tmpvar_78 = bool(1);
  if (tmpvar_79) tmpvar_78 = bool(0);
  if (tmpvar_78) {
    int address_80;
    address_80 = (tmpvar_5 + 2);
    ivec2 tmpvar_81;
    tmpvar_81.x = int((uint(address_80) % 1024u));
    tmpvar_81.y = int((uint(address_80) / 1024u));
    vec4 tmpvar_82;
    tmpvar_82 = mix (mix (texelFetchOffset (sGpuCache, tmpvar_81, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_81, 0, ivec2(1, 0)), tmpvar_75.x), mix (texelFetchOffset (sGpuCache, tmpvar_81, 0, ivec2(2, 0)), texelFetchOffset (sGpuCache, tmpvar_81, 0, ivec2(3, 0)), tmpvar_75.x), tmpvar_75.y);
    f_57 = (tmpvar_82.xy / tmpvar_82.w);
    tmpvar_79 = bool(1);
  };
  tmpvar_78 = bool(1);
  if (tmpvar_79) tmpvar_78 = bool(0);
  if (tmpvar_78) {
    tmpvar_79 = bool(1);
  };
  vec2 tmpvar_83;
  tmpvar_83 = (tmpvar_60 / stretch_size_58);
  varying_vec4_0.zw = (mix (uv0_62, uv1_61, f_57) - tmpvar_73);
  varying_vec4_0.zw = varying_vec4_0.zw;
  varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_83);
  if ((tmpvar_72 == 0.0)) {
    varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_32.w);
  };
  vec4 tmpvar_84;
  tmpvar_84.xy = vec2(0.0, 0.0);
  tmpvar_84.zw = vec2(textureSize (sColor0));
  flat_varying_vec4_2 = tmpvar_84;
  flat_varying_vec4_1.zw = tmpvar_83;
  float tmpvar_85;
  tmpvar_85 = (float(tmpvar_15.z) / 65535.0);
  bool tmpvar_86;
  tmpvar_86 = bool(0);
  bool tmpvar_87;
  tmpvar_87 = bool(0);
  if ((0 == tmpvar_77)) tmpvar_86 = bool(1);
  if (tmpvar_87) tmpvar_86 = bool(0);
  if (tmpvar_86) {
    tmpvar_63.w = (tmpvar_65.w * tmpvar_85);
    tmpvar_87 = bool(1);
  };
  tmpvar_86 = bool(1);
  if (tmpvar_87) tmpvar_86 = bool(0);
  if (tmpvar_86) {
    tmpvar_63 = (tmpvar_63 * tmpvar_85);
    tmpvar_87 = bool(1);
  };
  bool tmpvar_88;
  tmpvar_88 = bool(0);
  bool tmpvar_89;
  tmpvar_89 = bool(0);
  if ((1 == color_mode_56)) tmpvar_88 = bool(1);
  if ((7 == color_mode_56)) tmpvar_88 = bool(1);
  if (tmpvar_89) tmpvar_88 = bool(0);
  if (tmpvar_88) {
    flat_varying_vec4_1.xy = vec2(0.0, 1.0);
    flat_varying_vec4_0 = tmpvar_63;
    tmpvar_89 = bool(1);
  };
  if ((5 == color_mode_56)) tmpvar_88 = bool(1);
  if ((6 == color_mode_56)) tmpvar_88 = bool(1);
  if ((9 == color_mode_56)) tmpvar_88 = bool(1);
  if (tmpvar_89) tmpvar_88 = bool(0);
  if (tmpvar_88) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_63;
    tmpvar_89 = bool(1);
  };
  if ((2 == color_mode_56)) tmpvar_88 = bool(1);
  if ((3 == color_mode_56)) tmpvar_88 = bool(1);
  if ((8 == color_mode_56)) tmpvar_88 = bool(1);
  if (tmpvar_89) tmpvar_88 = bool(0);
  if (tmpvar_88) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_63.wwww;
    tmpvar_89 = bool(1);
  };
  if ((4 == color_mode_56)) tmpvar_88 = bool(1);
  if (tmpvar_89) tmpvar_88 = bool(0);
  if (tmpvar_88) {
    flat_varying_vec4_1.xy = vec2(-1.0, 1.0);
    flat_varying_vec4_0 = (tmpvar_63.wwww * tmpvar_66);
    tmpvar_89 = bool(1);
  };
  tmpvar_88 = bool(1);
  if (tmpvar_89) tmpvar_88 = bool(0);
  if (tmpvar_88) {
    flat_varying_vec4_1.xy = vec2(0.0, 0.0);
    flat_varying_vec4_0 = vec4(1.0, 1.0, 1.0, 1.0);
  };
  varying_vec4_0.xy = tmpvar_31;
}

