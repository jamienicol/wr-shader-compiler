#version 300 es
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
  highp vec2 local_pos_1;
  vec2 snap_bias_2;
  highp vec2 tmpvar_3;
  highp int color_mode_4;
  highp int tmpvar_5;
  highp int tmpvar_6;
  highp int tmpvar_7;
  highp int tmpvar_8;
  highp int tmpvar_9;
  tmpvar_5 = (aData.y >> 16);
  tmpvar_6 = (aData.y & 65535);
  tmpvar_7 = (aData.z & 65535);
  tmpvar_8 = (aData.z >> 16);
  tmpvar_9 = (aData.w & 16777215);
  highp int tmpvar_10;
  tmpvar_10 = ((tmpvar_8 >> 8) & 255);
  highp int tmpvar_11;
  tmpvar_11 = (tmpvar_8 & 255);
  color_mode_4 = tmpvar_11;
  highp float tmpvar_12;
  highp ivec2 tmpvar_13;
  highp uint tmpvar_14;
  tmpvar_14 = uint(aData.x);
  tmpvar_13.x = int((2u * (uint(mod (tmpvar_14, 512u)))));
  tmpvar_13.y = int((tmpvar_14 / 512u));
  highp vec4 tmpvar_15;
  tmpvar_15 = texelFetch (sPrimitiveHeadersF, tmpvar_13, 0);
  highp vec4 tmpvar_16;
  tmpvar_16 = texelFetch (sPrimitiveHeadersF, (tmpvar_13 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_17;
  tmpvar_17 = tmpvar_16.xy;
  highp ivec2 tmpvar_18;
  tmpvar_18.x = int((2u * (uint(mod (tmpvar_14, 512u)))));
  tmpvar_18.y = int((tmpvar_14 / 512u));
  highp ivec4 tmpvar_19;
  tmpvar_19 = texelFetch (sPrimitiveHeadersI, tmpvar_18, 0);
  highp ivec4 tmpvar_20;
  tmpvar_20 = texelFetch (sPrimitiveHeadersI, (tmpvar_18 + ivec2(1, 0)), 0);
  tmpvar_12 = float(tmpvar_19.x);
  highp mat4 tmpvar_21;
  highp int tmpvar_22;
  tmpvar_22 = (tmpvar_19.z & 16777215);
  highp ivec2 tmpvar_23;
  tmpvar_23.x = int((8u * (uint(mod (
    uint(tmpvar_22)
  , 128u)))));
  tmpvar_23.y = int((uint(tmpvar_22) / 128u));
  tmpvar_21[0] = texelFetch (sTransformPalette, tmpvar_23, 0);
  tmpvar_21[1] = texelFetch (sTransformPalette, (tmpvar_23 + ivec2(1, 0)), 0);
  tmpvar_21[2] = texelFetch (sTransformPalette, (tmpvar_23 + ivec2(2, 0)), 0);
  tmpvar_21[3] = texelFetch (sTransformPalette, (tmpvar_23 + ivec2(3, 0)), 0);
  RectWithSize tmpvar_24;
  highp float tmpvar_25;
  highp float tmpvar_26;
  highp vec2 tmpvar_27;
  if ((tmpvar_6 >= 32767)) {
    tmpvar_24 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_25 = 0.0;
    tmpvar_26 = 0.0;
    tmpvar_27 = vec2(0.0, 0.0);
  } else {
    highp ivec2 tmpvar_28;
    tmpvar_28.x = int((2u * (uint(mod (
      uint(tmpvar_6)
    , 512u)))));
    tmpvar_28.y = int((uint(tmpvar_6) / 512u));
    highp vec4 tmpvar_29;
    tmpvar_29 = texelFetch (sRenderTasks, tmpvar_28, 0);
    highp vec4 tmpvar_30;
    tmpvar_30 = texelFetch (sRenderTasks, (tmpvar_28 + ivec2(1, 0)), 0);
    highp vec3 tmpvar_31;
    tmpvar_31 = tmpvar_30.yzw;
    tmpvar_24.p0 = tmpvar_29.xy;
    tmpvar_24.size = tmpvar_29.zw;
    tmpvar_25 = tmpvar_30.x;
    tmpvar_26 = tmpvar_31.x;
    tmpvar_27 = tmpvar_31.yz;
  };
  highp ivec2 tmpvar_32;
  tmpvar_32.x = int((2u * (uint(mod (
    uint(tmpvar_5)
  , 512u)))));
  tmpvar_32.y = int((uint(tmpvar_5) / 512u));
  highp vec4 tmpvar_33;
  tmpvar_33 = texelFetch (sRenderTasks, tmpvar_32, 0);
  highp vec4 tmpvar_34;
  tmpvar_34 = texelFetch (sRenderTasks, (tmpvar_32 + ivec2(1, 0)), 0);
  highp ivec2 tmpvar_35;
  tmpvar_35.x = int((uint(mod (uint(tmpvar_19.y), 1024u))));
  tmpvar_35.y = int((uint(tmpvar_19.y) / 1024u));
  highp vec4 tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_36 = texelFetch (sGpuCache, tmpvar_35, 0);
  tmpvar_37 = texelFetch (sGpuCache, (tmpvar_35 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_38;
  tmpvar_38 = (vec2(tmpvar_20.xy) / 256.0);
  if ((tmpvar_11 == 0)) {
    color_mode_4 = uMode;
  };
  highp int tmpvar_39;
  tmpvar_39 = ((tmpvar_19.y + 2) + int((
    uint(tmpvar_7)
   / 2u)));
  highp ivec2 tmpvar_40;
  tmpvar_40.x = int((uint(mod (uint(tmpvar_39), 1024u))));
  tmpvar_40.y = int((uint(tmpvar_39) / 1024u));
  highp vec4 tmpvar_41;
  tmpvar_41 = texelFetch (sGpuCache, tmpvar_40, 0);
  tmpvar_3 = (mix(tmpvar_41.xy, tmpvar_41.zw, bvec2((
    (uint(mod (uint(tmpvar_7), 2u)))
   != uint(0)))) + tmpvar_15.xy);
  highp ivec2 tmpvar_42;
  tmpvar_42.x = int((uint(mod (uint(tmpvar_9), 1024u))));
  tmpvar_42.y = int((uint(tmpvar_9) / 1024u));
  highp vec4 tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_43 = texelFetch (sGpuCache, tmpvar_42, 0);
  tmpvar_44 = texelFetch (sGpuCache, (tmpvar_42 + ivec2(1, 0)), 0);
  highp float tmpvar_45;
  tmpvar_45 = tmpvar_44.x;
  bool tmpvar_46;
  tmpvar_46 = bool(0);
  bool tmpvar_47;
  tmpvar_47 = bool(0);
  bool tmpvar_48;
  tmpvar_48 = bool(1);
  if ((1 == tmpvar_10)) tmpvar_48 = bool(0);
  if (tmpvar_47) tmpvar_48 = bool(0);
  if ((2 == tmpvar_10)) tmpvar_48 = bool(0);
  if (tmpvar_47) tmpvar_48 = bool(0);
  if ((3 == tmpvar_10)) tmpvar_48 = bool(0);
  if (tmpvar_47) tmpvar_48 = bool(0);
  if ((0 == tmpvar_10)) tmpvar_46 = bool(1);
  if ((bool(1) == tmpvar_48)) tmpvar_46 = bool(1);
  if (tmpvar_47) tmpvar_46 = bool(0);
  if (tmpvar_46) {
    snap_bias_2 = vec2(0.5, 0.5);
    tmpvar_47 = bool(1);
  };
  if ((1 == tmpvar_10)) tmpvar_46 = bool(1);
  if (tmpvar_47) tmpvar_46 = bool(0);
  if (tmpvar_46) {
    snap_bias_2 = vec2(0.125, 0.5);
    tmpvar_47 = bool(1);
  };
  if ((2 == tmpvar_10)) tmpvar_46 = bool(1);
  if (tmpvar_47) tmpvar_46 = bool(0);
  if (tmpvar_46) {
    snap_bias_2 = vec2(0.5, 0.125);
    tmpvar_47 = bool(1);
  };
  if ((3 == tmpvar_10)) tmpvar_46 = bool(1);
  if (tmpvar_47) tmpvar_46 = bool(0);
  if (tmpvar_46) {
    snap_bias_2 = vec2(0.125, 0.125);
    tmpvar_47 = bool(1);
  };
  highp mat2 tmpvar_49;
  tmpvar_49[uint(0)] = tmpvar_21[uint(0)].xy;
  tmpvar_49[1u] = tmpvar_21[1u].xy;
  highp mat2 tmpvar_50;
  tmpvar_50 = (tmpvar_49 * tmpvar_34.y);
  highp vec2 tmpvar_51;
  tmpvar_51 = (tmpvar_21[3].xy * tmpvar_34.y);
  highp mat2 tmpvar_52;
  highp mat2 tmpvar_53;
  tmpvar_53[0].x = tmpvar_50[1].y;
  tmpvar_53[0].y = -(tmpvar_50[0].y);
  tmpvar_53[1].x = -(tmpvar_50[1].x);
  tmpvar_53[1].y = tmpvar_50[0].x;
  tmpvar_52 = (tmpvar_53 / ((tmpvar_50[0].x * tmpvar_50[1].y) - (tmpvar_50[1].x * tmpvar_50[0].y)));
  highp vec2 tmpvar_54;
  highp vec2 tmpvar_55;
  tmpvar_54 = ((tmpvar_44.yz + floor(
    ((tmpvar_50 * tmpvar_3) + snap_bias_2)
  )) + (floor(
    (((tmpvar_50 * tmpvar_38) + tmpvar_51) + 0.5)
  ) - tmpvar_51));
  tmpvar_55 = (tmpvar_43.zw - tmpvar_43.xy);
  highp mat2 tmpvar_56;
  tmpvar_56[uint(0)] = abs(tmpvar_52[0]);
  tmpvar_56[1u] = abs(tmpvar_52[1]);
  highp vec2 tmpvar_57;
  tmpvar_57 = (tmpvar_56 * (tmpvar_55 * 0.5));
  highp vec2 tmpvar_58;
  highp vec2 tmpvar_59;
  tmpvar_58 = ((tmpvar_52 * (tmpvar_54 + 
    (tmpvar_55 * 0.5)
  )) - tmpvar_57);
  tmpvar_59 = (tmpvar_57 * 2.0);
  local_pos_1 = (tmpvar_58 + (tmpvar_59 * aPosition.xy));
  highp vec4 tmpvar_60;
  tmpvar_60.xy = tmpvar_17;
  tmpvar_60.zw = (tmpvar_58 + tmpvar_59);
  highp vec4 tmpvar_61;
  tmpvar_61.xy = tmpvar_58;
  tmpvar_61.zw = (tmpvar_16.xy + tmpvar_16.zw);
  bvec4 tmpvar_62;
  tmpvar_62 = lessThanEqual (tmpvar_60, tmpvar_61);
  if (((tmpvar_62.x && tmpvar_62.y) && (tmpvar_62.z && tmpvar_62.w))) {
    local_pos_1 = (tmpvar_52 * (tmpvar_54 + (tmpvar_55 * aPosition.xy)));
  };
  highp vec2 tmpvar_63;
  tmpvar_63 = clamp (local_pos_1, tmpvar_16.xy, (tmpvar_16.xy + tmpvar_16.zw));
  local_pos_1 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64.zw = vec2(0.0, 1.0);
  tmpvar_64.xy = tmpvar_63;
  highp vec4 tmpvar_65;
  tmpvar_65 = (tmpvar_21 * tmpvar_64);
  highp vec4 tmpvar_66;
  tmpvar_66.xy = ((tmpvar_65.xy * tmpvar_34.y) + ((
    -(tmpvar_34.zw)
   + tmpvar_33.xy) * tmpvar_65.w));
  tmpvar_66.z = (tmpvar_12 * tmpvar_65.w);
  tmpvar_66.w = tmpvar_65.w;
  gl_Position = (uTransform * tmpvar_66);
  highp vec2 tmpvar_67;
  tmpvar_67 = (((tmpvar_50 * tmpvar_63) - tmpvar_54) / tmpvar_55);
  highp vec4 tmpvar_68;
  tmpvar_68.xy = tmpvar_67;
  tmpvar_68.zw = (1.0 - tmpvar_67);
  varying_vec4_1 = tmpvar_68;
  vec4 tmpvar_69;
  tmpvar_69.xy = tmpvar_24.p0;
  tmpvar_69.zw = (tmpvar_24.p0 + tmpvar_24.size);
  vClipMaskUvBounds = tmpvar_69;
  highp vec4 tmpvar_70;
  tmpvar_70.xy = ((tmpvar_65.xy * tmpvar_26) + (tmpvar_65.w * (tmpvar_24.p0 - tmpvar_27)));
  tmpvar_70.z = tmpvar_25;
  tmpvar_70.w = tmpvar_65.w;
  vClipMaskUv = tmpvar_70;
  bool tmpvar_71;
  tmpvar_71 = bool(0);
  bool tmpvar_72;
  tmpvar_72 = bool(0);
  if ((1 == color_mode_4)) tmpvar_71 = bool(1);
  if ((7 == color_mode_4)) tmpvar_71 = bool(1);
  if (tmpvar_72) tmpvar_71 = bool(0);
  if (tmpvar_71) {
    flat_varying_vec4_1.xy = vec2(0.0, 1.0);
    flat_varying_vec4_0 = tmpvar_36;
    tmpvar_72 = bool(1);
  };
  if ((5 == color_mode_4)) tmpvar_71 = bool(1);
  if ((6 == color_mode_4)) tmpvar_71 = bool(1);
  if (tmpvar_72) tmpvar_71 = bool(0);
  if (tmpvar_71) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_36;
    tmpvar_72 = bool(1);
  };
  if ((2 == color_mode_4)) tmpvar_71 = bool(1);
  if ((3 == color_mode_4)) tmpvar_71 = bool(1);
  if ((8 == color_mode_4)) tmpvar_71 = bool(1);
  if (tmpvar_72) tmpvar_71 = bool(0);
  if (tmpvar_71) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_36.wwww;
    tmpvar_72 = bool(1);
  };
  if ((4 == color_mode_4)) tmpvar_71 = bool(1);
  if (tmpvar_72) tmpvar_71 = bool(0);
  if (tmpvar_71) {
    flat_varying_vec4_1.xy = vec2(-1.0, 1.0);
    flat_varying_vec4_0 = (tmpvar_36.wwww * tmpvar_37);
    tmpvar_72 = bool(1);
  };
  tmpvar_71 = bool(1);
  if (tmpvar_72) tmpvar_71 = bool(0);
  if (tmpvar_71) {
    flat_varying_vec4_1.xy = vec2(0.0, 0.0);
    flat_varying_vec4_0 = vec4(1.0, 1.0, 1.0, 1.0);
  };
  lowp vec2 tmpvar_73;
  tmpvar_73 = vec3(textureSize (sColor0, 0)).xy;
  varying_vec4_0.xy = mix ((tmpvar_43.xy / tmpvar_73), (tmpvar_43.zw / tmpvar_73), tmpvar_67);
  varying_vec4_0.z = tmpvar_45;
  flat_varying_vec4_2 = ((tmpvar_43 + vec4(0.5, 0.5, -0.5, -0.5)) / tmpvar_73.xyxy);
}

