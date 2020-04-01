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
  highp ivec2 tmpvar_11;
  tmpvar_11.x = int((2u * (tmpvar_8 % 512u)));
  tmpvar_11.y = int((tmpvar_8 / 512u));
  highp ivec4 tmpvar_12;
  tmpvar_12 = texelFetch (sPrimitiveHeadersI, tmpvar_11, 0);
  highp ivec4 tmpvar_13;
  tmpvar_13 = texelFetch (sPrimitiveHeadersI, (tmpvar_11 + ivec2(1, 0)), 0);
  tmpvar_6 = float(tmpvar_12.x);
  highp mat4 tmpvar_14;
  highp int tmpvar_15;
  tmpvar_15 = (tmpvar_12.z & 16777215);
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
  lowp float tmpvar_28;
  highp vec2 tmpvar_29;
  highp int color_mode_30;
  highp int subpx_dir_31;
  subpx_dir_31 = ((tmpvar_4 >> 8) & 255);
  color_mode_30 = (tmpvar_4 & 255);
  highp ivec2 tmpvar_32;
  tmpvar_32.x = int((uint(tmpvar_12.y) % 1024u));
  tmpvar_32.y = int((uint(tmpvar_12.y) / 1024u));
  highp vec4 tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_33 = texelFetch (sGpuCache, tmpvar_32, 0);
  tmpvar_34 = texelFetch (sGpuCache, (tmpvar_32 + ivec2(1, 0)), 0);
  if ((color_mode_30 == 0)) {
    color_mode_30 = uMode;
  };
  highp int address_35;
  address_35 = ((tmpvar_12.y + 2) + int((
    uint(tmpvar_3)
   / 2u)));
  highp ivec2 tmpvar_36;
  tmpvar_36.x = int((uint(address_35) % 1024u));
  tmpvar_36.y = int((uint(address_35) / 1024u));
  highp vec4 tmpvar_37;
  tmpvar_37 = texelFetch (sGpuCache, tmpvar_36, 0);
  tmpvar_29 = (mix(tmpvar_37.xy, tmpvar_37.zw, bvec2((
    (uint(tmpvar_3) % 2u)
   != uint(0)))) + tmpvar_9.xy);
  highp ivec2 tmpvar_38;
  tmpvar_38.x = int((uint(tmpvar_5) % 1024u));
  tmpvar_38.y = int((uint(tmpvar_5) / 1024u));
  highp vec4 tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_39 = texelFetch (sGpuCache, tmpvar_38, 0);
  tmpvar_40 = texelFetch (sGpuCache, (tmpvar_38 + ivec2(1, 0)), 0);
  tmpvar_28 = tmpvar_40.x;
  vec2 tmpvar_41;
  bool tmpvar_42;
  tmpvar_42 = bool(0);
  bool tmpvar_43;
  tmpvar_43 = bool(1);
  if ((1 == subpx_dir_31)) tmpvar_43 = bool(0);
  if ((2 == subpx_dir_31)) tmpvar_43 = bool(0);
  if ((3 == subpx_dir_31)) tmpvar_43 = bool(0);
  if ((0 == subpx_dir_31)) tmpvar_42 = bool(1);
  if ((bool(1) == tmpvar_43)) tmpvar_42 = bool(1);
  if (tmpvar_42) {
    tmpvar_41 = vec2(0.5, 0.5);
  } else {
    if ((1 == subpx_dir_31)) tmpvar_42 = bool(1);
    if (tmpvar_42) {
      tmpvar_41 = vec2(0.125, 0.5);
    } else {
      if ((2 == subpx_dir_31)) tmpvar_42 = bool(1);
      if (tmpvar_42) {
        tmpvar_41 = vec2(0.5, 0.125);
      } else {
        if ((3 == subpx_dir_31)) tmpvar_42 = bool(1);
        if (tmpvar_42) {
          tmpvar_41 = vec2(0.125, 0.125);
        };
      };
    };
  };
  highp float tmpvar_44;
  tmpvar_44 = ((float(tmpvar_13.x) / 65535.0) * tmpvar_19.y);
  highp float tmpvar_45;
  tmpvar_45 = (tmpvar_40.w / tmpvar_44);
  highp vec2 tmpvar_46;
  highp vec2 tmpvar_47;
  tmpvar_46 = ((tmpvar_45 * (tmpvar_40.yz + 
    (floor(((tmpvar_29 * tmpvar_44) + tmpvar_41)) / tmpvar_40.w)
  )) + tmpvar_9.zw);
  tmpvar_47 = (tmpvar_45 * (tmpvar_39.zw - tmpvar_39.xy));
  highp vec2 tmpvar_48;
  tmpvar_48 = clamp ((tmpvar_46 + (tmpvar_47 * aPosition)), tmpvar_10.xy, (tmpvar_10.xy + tmpvar_10.zw));
  highp vec4 tmpvar_49;
  tmpvar_49.zw = vec2(0.0, 1.0);
  tmpvar_49.xy = tmpvar_48;
  highp vec4 tmpvar_50;
  tmpvar_50 = (tmpvar_14 * tmpvar_49);
  highp vec4 tmpvar_51;
  tmpvar_51.xy = ((tmpvar_50.xy * tmpvar_19.y) + ((
    -(tmpvar_19.zw)
   + tmpvar_18.xy) * tmpvar_50.w));
  tmpvar_51.z = (tmpvar_6 * tmpvar_50.w);
  tmpvar_51.w = tmpvar_50.w;
  gl_Position = (uTransform * tmpvar_51);
  highp vec2 tmpvar_52;
  tmpvar_52 = ((tmpvar_48 - tmpvar_46) / tmpvar_47);
  vec4 tmpvar_53;
  tmpvar_53.xy = tmpvar_20.p0;
  tmpvar_53.zw = (tmpvar_20.p0 + tmpvar_20.size);
  vClipMaskUvBounds = tmpvar_53;
  highp vec4 tmpvar_54;
  tmpvar_54.xy = ((tmpvar_50.xy * tmpvar_22) + (tmpvar_50.w * (tmpvar_20.p0 - tmpvar_23)));
  tmpvar_54.z = tmpvar_21;
  tmpvar_54.w = tmpvar_50.w;
  vClipMaskUv = tmpvar_54;
  bool tmpvar_55;
  tmpvar_55 = bool(0);
  bool tmpvar_56;
  tmpvar_56 = bool(0);
  if ((1 == color_mode_30)) tmpvar_55 = bool(1);
  if ((7 == color_mode_30)) tmpvar_55 = bool(1);
  if (tmpvar_56) tmpvar_55 = bool(0);
  if (tmpvar_55) {
    flat_varying_vec4_1.xy = vec2(0.0, 1.0);
    flat_varying_vec4_0 = tmpvar_33;
    tmpvar_56 = bool(1);
  };
  if ((5 == color_mode_30)) tmpvar_55 = bool(1);
  if ((6 == color_mode_30)) tmpvar_55 = bool(1);
  if (tmpvar_56) tmpvar_55 = bool(0);
  if (tmpvar_55) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_33;
    tmpvar_56 = bool(1);
  };
  if ((2 == color_mode_30)) tmpvar_55 = bool(1);
  if ((3 == color_mode_30)) tmpvar_55 = bool(1);
  if ((8 == color_mode_30)) tmpvar_55 = bool(1);
  if (tmpvar_56) tmpvar_55 = bool(0);
  if (tmpvar_55) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_33.wwww;
    tmpvar_56 = bool(1);
  };
  if ((4 == color_mode_30)) tmpvar_55 = bool(1);
  if (tmpvar_56) tmpvar_55 = bool(0);
  if (tmpvar_55) {
    flat_varying_vec4_1.xy = vec2(-1.0, 1.0);
    flat_varying_vec4_0 = (tmpvar_33.wwww * tmpvar_34);
    tmpvar_56 = bool(1);
  };
  tmpvar_55 = bool(1);
  if (tmpvar_56) tmpvar_55 = bool(0);
  if (tmpvar_55) {
    flat_varying_vec4_1.xy = vec2(0.0, 0.0);
    flat_varying_vec4_0 = vec4(1.0, 1.0, 1.0, 1.0);
  };
  lowp vec2 tmpvar_57;
  tmpvar_57 = vec3(textureSize (sColor0, 0)).xy;
  varying_vec4_0.xy = mix ((tmpvar_39.xy / tmpvar_57), (tmpvar_39.zw / tmpvar_57), tmpvar_52);
  varying_vec4_0.z = tmpvar_28;
  flat_varying_vec4_2 = ((tmpvar_39 + vec4(0.5, 0.5, -0.5, -0.5)) / tmpvar_57.xyxy);
}

