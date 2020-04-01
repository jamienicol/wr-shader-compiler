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
uniform sampler2DArray sColor0;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
flat out vec4 vClipMaskUvBounds;
out highp vec4 vClipMaskUv;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
flat out highp vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
flat out lowp vec4 flat_varying_vec4_2;
out lowp vec4 varying_vec4_0;
out highp vec4 varying_vec4_1;
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
  tmpvar_11 = tmpvar_10.xy;
  highp ivec2 tmpvar_12;
  tmpvar_12.x = int((2u * (tmpvar_8 % 512u)));
  tmpvar_12.y = int((tmpvar_8 / 512u));
  highp ivec4 tmpvar_13;
  tmpvar_13 = texelFetch (sPrimitiveHeadersI, tmpvar_12, 0);
  tmpvar_6 = float(tmpvar_13.x);
  highp mat4 tmpvar_14;
  highp int tmpvar_15;
  tmpvar_15 = (tmpvar_13.z & 16777215);
  highp ivec2 tmpvar_16;
  tmpvar_16.x = int((8u * (
    uint(tmpvar_15)
   % 128u)));
  tmpvar_16.y = int((uint(tmpvar_15) / 128u));
  tmpvar_14[0] = texelFetch (sTransformPalette, tmpvar_16, 0);
  tmpvar_14[1] = texelFetch (sTransformPalette, (tmpvar_16 + ivec2(1, 0)), 0);
  tmpvar_14[2] = texelFetch (sTransformPalette, (tmpvar_16 + ivec2(2, 0)), 0);
  tmpvar_14[3] = texelFetch (sTransformPalette, (tmpvar_16 + ivec2(3, 0)), 0);
  highp ivec2 tmpvar_17;
  tmpvar_17.x = int((2u * (
    uint(tmpvar_1)
   % 512u)));
  tmpvar_17.y = int((uint(tmpvar_1) / 512u));
  highp vec4 tmpvar_18;
  tmpvar_18 = texelFetch (sRenderTasks, tmpvar_17, 0);
  highp vec4 tmpvar_19;
  tmpvar_19 = texelFetch (sRenderTasks, (tmpvar_17 + ivec2(1, 0)), 0);
  RectWithSize tmpvar_20;
  highp float tmpvar_21;
  highp float tmpvar_22;
  highp vec2 tmpvar_23;
  if ((tmpvar_2 >= 32767)) {
    tmpvar_20 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_21 = 0.0;
    tmpvar_22 = 0.0;
    tmpvar_23 = vec2(0.0, 0.0);
  } else {
    highp ivec2 tmpvar_24;
    tmpvar_24.x = int((2u * (
      uint(tmpvar_2)
     % 512u)));
    tmpvar_24.y = int((uint(tmpvar_2) / 512u));
    highp vec4 tmpvar_25;
    tmpvar_25 = texelFetch (sRenderTasks, tmpvar_24, 0);
    highp vec4 tmpvar_26;
    tmpvar_26 = texelFetch (sRenderTasks, (tmpvar_24 + ivec2(1, 0)), 0);
    highp vec3 tmpvar_27;
    tmpvar_27 = tmpvar_26.yzw;
    tmpvar_20.p0 = tmpvar_25.xy;
    tmpvar_20.size = tmpvar_25.zw;
    tmpvar_21 = tmpvar_26.x;
    tmpvar_22 = tmpvar_27.x;
    tmpvar_23 = tmpvar_27.yz;
  };
  highp vec2 local_pos_28;
  lowp float tmpvar_29;
  highp vec2 tmpvar_30;
  highp int color_mode_31;
  highp int subpx_dir_32;
  subpx_dir_32 = ((tmpvar_4 >> 8) & 255);
  color_mode_31 = (tmpvar_4 & 255);
  highp ivec2 tmpvar_33;
  tmpvar_33.x = int((uint(tmpvar_13.y) % 1024u));
  tmpvar_33.y = int((uint(tmpvar_13.y) / 1024u));
  highp vec4 tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_34 = texelFetch (sGpuCache, tmpvar_33, 0);
  tmpvar_35 = texelFetch (sGpuCache, (tmpvar_33 + ivec2(1, 0)), 0);
  if ((color_mode_31 == 0)) {
    color_mode_31 = uMode;
  };
  highp int address_36;
  address_36 = ((tmpvar_13.y + 2) + int((
    uint(tmpvar_3)
   / 2u)));
  highp ivec2 tmpvar_37;
  tmpvar_37.x = int((uint(address_36) % 1024u));
  tmpvar_37.y = int((uint(address_36) / 1024u));
  highp vec4 tmpvar_38;
  tmpvar_38 = texelFetch (sGpuCache, tmpvar_37, 0);
  tmpvar_30 = (mix(tmpvar_38.xy, tmpvar_38.zw, bvec2((
    (uint(tmpvar_3) % 2u)
   != uint(0)))) + tmpvar_9.xy);
  highp ivec2 tmpvar_39;
  tmpvar_39.x = int((uint(tmpvar_5) % 1024u));
  tmpvar_39.y = int((uint(tmpvar_5) / 1024u));
  highp vec4 tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_40 = texelFetch (sGpuCache, tmpvar_39, 0);
  tmpvar_41 = texelFetch (sGpuCache, (tmpvar_39 + ivec2(1, 0)), 0);
  tmpvar_29 = tmpvar_41.x;
  vec2 tmpvar_42;
  bool tmpvar_43;
  tmpvar_43 = bool(0);
  bool tmpvar_44;
  tmpvar_44 = bool(1);
  if ((1 == subpx_dir_32)) tmpvar_44 = bool(0);
  if ((2 == subpx_dir_32)) tmpvar_44 = bool(0);
  if ((3 == subpx_dir_32)) tmpvar_44 = bool(0);
  if ((0 == subpx_dir_32)) tmpvar_43 = bool(1);
  if ((bool(1) == tmpvar_44)) tmpvar_43 = bool(1);
  if (tmpvar_43) {
    tmpvar_42 = vec2(0.5, 0.5);
  } else {
    if ((1 == subpx_dir_32)) tmpvar_43 = bool(1);
    if (tmpvar_43) {
      tmpvar_42 = vec2(0.125, 0.5);
    } else {
      if ((2 == subpx_dir_32)) tmpvar_43 = bool(1);
      if (tmpvar_43) {
        tmpvar_42 = vec2(0.5, 0.125);
      } else {
        if ((3 == subpx_dir_32)) tmpvar_43 = bool(1);
        if (tmpvar_43) {
          tmpvar_42 = vec2(0.125, 0.125);
        };
      };
    };
  };
  highp mat2 tmpvar_45;
  tmpvar_45[uint(0)] = tmpvar_14[uint(0)].xy;
  tmpvar_45[1u] = tmpvar_14[1u].xy;
  highp mat2 tmpvar_46;
  tmpvar_46 = (tmpvar_45 * tmpvar_19.y);
  highp vec2 tmpvar_47;
  tmpvar_47 = (tmpvar_14[3].xy * tmpvar_19.y);
  highp mat2 tmpvar_48;
  highp mat2 tmpvar_49;
  tmpvar_49[0].x = tmpvar_46[1].y;
  tmpvar_49[0].y = -(tmpvar_46[0].y);
  tmpvar_49[1].x = -(tmpvar_46[1].x);
  tmpvar_49[1].y = tmpvar_46[0].x;
  tmpvar_48 = (tmpvar_49 / ((tmpvar_46[0].x * tmpvar_46[1].y) - (tmpvar_46[1].x * tmpvar_46[0].y)));
  highp vec2 tmpvar_50;
  highp vec2 tmpvar_51;
  tmpvar_50 = ((tmpvar_41.yz + floor(
    ((tmpvar_46 * tmpvar_30) + tmpvar_42)
  )) + (floor(
    (((tmpvar_46 * tmpvar_9.zw) + tmpvar_47) + 0.5)
  ) - tmpvar_47));
  tmpvar_51 = (tmpvar_40.zw - tmpvar_40.xy);
  highp mat2 tmpvar_52;
  tmpvar_52[uint(0)] = abs(tmpvar_48[0]);
  tmpvar_52[1u] = abs(tmpvar_48[1]);
  highp vec2 tmpvar_53;
  tmpvar_53 = (tmpvar_52 * (tmpvar_51 * 0.5));
  highp vec2 tmpvar_54;
  highp vec2 tmpvar_55;
  tmpvar_54 = ((tmpvar_48 * (tmpvar_50 + 
    (tmpvar_51 * 0.5)
  )) - tmpvar_53);
  tmpvar_55 = (tmpvar_53 * 2.0);
  local_pos_28 = (tmpvar_54 + (tmpvar_55 * aPosition));
  highp vec4 tmpvar_56;
  tmpvar_56.xy = tmpvar_11;
  tmpvar_56.zw = (tmpvar_54 + tmpvar_55);
  highp vec4 tmpvar_57;
  tmpvar_57.xy = tmpvar_54;
  tmpvar_57.zw = (tmpvar_10.xy + tmpvar_10.zw);
  bvec4 tmpvar_58;
  tmpvar_58 = lessThanEqual (tmpvar_56, tmpvar_57);
  if (((tmpvar_58.x && tmpvar_58.y) && (tmpvar_58.z && tmpvar_58.w))) {
    local_pos_28 = (tmpvar_48 * (tmpvar_50 + (tmpvar_51 * aPosition)));
  };
  highp vec2 tmpvar_59;
  tmpvar_59 = clamp (local_pos_28, tmpvar_10.xy, (tmpvar_10.xy + tmpvar_10.zw));
  highp vec4 tmpvar_60;
  tmpvar_60.zw = vec2(0.0, 1.0);
  tmpvar_60.xy = tmpvar_59;
  highp vec4 tmpvar_61;
  tmpvar_61 = (tmpvar_14 * tmpvar_60);
  highp vec4 tmpvar_62;
  tmpvar_62.xy = ((tmpvar_61.xy * tmpvar_19.y) + ((
    -(tmpvar_19.zw)
   + tmpvar_18.xy) * tmpvar_61.w));
  tmpvar_62.z = (tmpvar_6 * tmpvar_61.w);
  tmpvar_62.w = tmpvar_61.w;
  gl_Position = (uTransform * tmpvar_62);
  highp vec2 tmpvar_63;
  tmpvar_63 = (((tmpvar_46 * tmpvar_59) - tmpvar_50) / tmpvar_51);
  highp vec4 tmpvar_64;
  tmpvar_64.xy = tmpvar_63;
  tmpvar_64.zw = (1.0 - tmpvar_63);
  varying_vec4_1 = tmpvar_64;
  vec4 tmpvar_65;
  tmpvar_65.xy = tmpvar_20.p0;
  tmpvar_65.zw = (tmpvar_20.p0 + tmpvar_20.size);
  vClipMaskUvBounds = tmpvar_65;
  highp vec4 tmpvar_66;
  tmpvar_66.xy = ((tmpvar_61.xy * tmpvar_22) + (tmpvar_61.w * (tmpvar_20.p0 - tmpvar_23)));
  tmpvar_66.z = tmpvar_21;
  tmpvar_66.w = tmpvar_61.w;
  vClipMaskUv = tmpvar_66;
  bool tmpvar_67;
  tmpvar_67 = bool(0);
  bool tmpvar_68;
  tmpvar_68 = bool(0);
  if ((1 == color_mode_31)) tmpvar_67 = bool(1);
  if ((7 == color_mode_31)) tmpvar_67 = bool(1);
  if (tmpvar_68) tmpvar_67 = bool(0);
  if (tmpvar_67) {
    flat_varying_vec4_1.xy = vec2(0.0, 1.0);
    flat_varying_vec4_0 = tmpvar_34;
    tmpvar_68 = bool(1);
  };
  if ((5 == color_mode_31)) tmpvar_67 = bool(1);
  if ((6 == color_mode_31)) tmpvar_67 = bool(1);
  if (tmpvar_68) tmpvar_67 = bool(0);
  if (tmpvar_67) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_34;
    tmpvar_68 = bool(1);
  };
  if ((2 == color_mode_31)) tmpvar_67 = bool(1);
  if ((3 == color_mode_31)) tmpvar_67 = bool(1);
  if ((8 == color_mode_31)) tmpvar_67 = bool(1);
  if (tmpvar_68) tmpvar_67 = bool(0);
  if (tmpvar_67) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_34.wwww;
    tmpvar_68 = bool(1);
  };
  if ((4 == color_mode_31)) tmpvar_67 = bool(1);
  if (tmpvar_68) tmpvar_67 = bool(0);
  if (tmpvar_67) {
    flat_varying_vec4_1.xy = vec2(-1.0, 1.0);
    flat_varying_vec4_0 = (tmpvar_34.wwww * tmpvar_35);
    tmpvar_68 = bool(1);
  };
  tmpvar_67 = bool(1);
  if (tmpvar_68) tmpvar_67 = bool(0);
  if (tmpvar_67) {
    flat_varying_vec4_1.xy = vec2(0.0, 0.0);
    flat_varying_vec4_0 = vec4(1.0, 1.0, 1.0, 1.0);
  };
  lowp vec2 tmpvar_69;
  tmpvar_69 = vec3(textureSize (sColor0, 0)).xy;
  varying_vec4_0.xy = mix ((tmpvar_40.xy / tmpvar_69), (tmpvar_40.zw / tmpvar_69), tmpvar_63);
  varying_vec4_0.z = tmpvar_29;
  flat_varying_vec4_2 = ((tmpvar_40 + vec4(0.5, 0.5, -0.5, -0.5)) / tmpvar_69.xyxy);
}

