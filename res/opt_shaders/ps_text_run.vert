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
void main ()
{
  vec2 snap_bias_1;
  highp vec2 tmpvar_2;
  highp int color_mode_3;
  highp int tmpvar_4;
  highp int tmpvar_5;
  highp int tmpvar_6;
  highp int tmpvar_7;
  highp int tmpvar_8;
  tmpvar_4 = (aData.y >> 16);
  tmpvar_5 = (aData.y & 65535);
  tmpvar_6 = (aData.z & 65535);
  tmpvar_7 = (aData.z >> 16);
  tmpvar_8 = (aData.w & 16777215);
  highp int tmpvar_9;
  tmpvar_9 = ((tmpvar_7 >> 8) & 255);
  highp int tmpvar_10;
  tmpvar_10 = (tmpvar_7 & 255);
  color_mode_3 = tmpvar_10;
  highp float tmpvar_11;
  highp ivec2 tmpvar_12;
  highp uint tmpvar_13;
  tmpvar_13 = uint(aData.x);
  tmpvar_12.x = int((2u * (uint(mod (tmpvar_13, 512u)))));
  tmpvar_12.y = int((tmpvar_13 / 512u));
  highp vec4 tmpvar_14;
  tmpvar_14 = texelFetch (sPrimitiveHeadersF, tmpvar_12, 0);
  highp vec4 tmpvar_15;
  tmpvar_15 = texelFetch (sPrimitiveHeadersF, (tmpvar_12 + ivec2(1, 0)), 0);
  highp ivec2 tmpvar_16;
  tmpvar_16.x = int((2u * (uint(mod (tmpvar_13, 512u)))));
  tmpvar_16.y = int((tmpvar_13 / 512u));
  highp ivec4 tmpvar_17;
  tmpvar_17 = texelFetch (sPrimitiveHeadersI, tmpvar_16, 0);
  highp ivec4 tmpvar_18;
  tmpvar_18 = texelFetch (sPrimitiveHeadersI, (tmpvar_16 + ivec2(1, 0)), 0);
  tmpvar_11 = float(tmpvar_17.x);
  highp mat4 tmpvar_19;
  highp int tmpvar_20;
  tmpvar_20 = (tmpvar_17.z & 16777215);
  highp ivec2 tmpvar_21;
  tmpvar_21.x = int((8u * (uint(mod (
    uint(tmpvar_20)
  , 128u)))));
  tmpvar_21.y = int((uint(tmpvar_20) / 128u));
  tmpvar_19[0] = texelFetch (sTransformPalette, tmpvar_21, 0);
  tmpvar_19[1] = texelFetch (sTransformPalette, (tmpvar_21 + ivec2(1, 0)), 0);
  tmpvar_19[2] = texelFetch (sTransformPalette, (tmpvar_21 + ivec2(2, 0)), 0);
  tmpvar_19[3] = texelFetch (sTransformPalette, (tmpvar_21 + ivec2(3, 0)), 0);
  RectWithSize tmpvar_22;
  highp float tmpvar_23;
  highp float tmpvar_24;
  highp vec2 tmpvar_25;
  if ((tmpvar_5 >= 32767)) {
    tmpvar_22 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_23 = 0.0;
    tmpvar_24 = 0.0;
    tmpvar_25 = vec2(0.0, 0.0);
  } else {
    highp ivec2 tmpvar_26;
    tmpvar_26.x = int((2u * (uint(mod (
      uint(tmpvar_5)
    , 512u)))));
    tmpvar_26.y = int((uint(tmpvar_5) / 512u));
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
  highp ivec2 tmpvar_30;
  tmpvar_30.x = int((2u * (uint(mod (
    uint(tmpvar_4)
  , 512u)))));
  tmpvar_30.y = int((uint(tmpvar_4) / 512u));
  highp vec4 tmpvar_31;
  tmpvar_31 = texelFetch (sRenderTasks, tmpvar_30, 0);
  highp vec4 tmpvar_32;
  tmpvar_32 = texelFetch (sRenderTasks, (tmpvar_30 + ivec2(1, 0)), 0);
  highp ivec2 tmpvar_33;
  tmpvar_33.x = int((uint(mod (uint(tmpvar_17.y), 1024u))));
  tmpvar_33.y = int((uint(tmpvar_17.y) / 1024u));
  highp vec4 tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_34 = texelFetch (sGpuCache, tmpvar_33, 0);
  tmpvar_35 = texelFetch (sGpuCache, (tmpvar_33 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_36;
  tmpvar_36 = (vec2(tmpvar_18.xy) / 256.0);
  if ((tmpvar_10 == 0)) {
    color_mode_3 = uMode;
  };
  highp int tmpvar_37;
  tmpvar_37 = ((tmpvar_17.y + 2) + int((
    uint(tmpvar_6)
   / 2u)));
  highp ivec2 tmpvar_38;
  tmpvar_38.x = int((uint(mod (uint(tmpvar_37), 1024u))));
  tmpvar_38.y = int((uint(tmpvar_37) / 1024u));
  highp vec4 tmpvar_39;
  tmpvar_39 = texelFetch (sGpuCache, tmpvar_38, 0);
  tmpvar_2 = (mix(tmpvar_39.xy, tmpvar_39.zw, bvec2((
    (uint(mod (uint(tmpvar_6), 2u)))
   != uint(0)))) + tmpvar_14.xy);
  highp ivec2 tmpvar_40;
  tmpvar_40.x = int((uint(mod (uint(tmpvar_8), 1024u))));
  tmpvar_40.y = int((uint(tmpvar_8) / 1024u));
  highp vec4 tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_41 = texelFetch (sGpuCache, tmpvar_40, 0);
  tmpvar_42 = texelFetch (sGpuCache, (tmpvar_40 + ivec2(1, 0)), 0);
  highp float tmpvar_43;
  tmpvar_43 = tmpvar_42.x;
  bool tmpvar_44;
  tmpvar_44 = bool(0);
  bool tmpvar_45;
  tmpvar_45 = bool(0);
  bool tmpvar_46;
  tmpvar_46 = bool(1);
  if ((1 == tmpvar_9)) tmpvar_46 = bool(0);
  if (tmpvar_45) tmpvar_46 = bool(0);
  if ((2 == tmpvar_9)) tmpvar_46 = bool(0);
  if (tmpvar_45) tmpvar_46 = bool(0);
  if ((3 == tmpvar_9)) tmpvar_46 = bool(0);
  if (tmpvar_45) tmpvar_46 = bool(0);
  if ((0 == tmpvar_9)) tmpvar_44 = bool(1);
  if ((bool(1) == tmpvar_46)) tmpvar_44 = bool(1);
  if (tmpvar_45) tmpvar_44 = bool(0);
  if (tmpvar_44) {
    snap_bias_1 = vec2(0.5, 0.5);
    tmpvar_45 = bool(1);
  };
  if ((1 == tmpvar_9)) tmpvar_44 = bool(1);
  if (tmpvar_45) tmpvar_44 = bool(0);
  if (tmpvar_44) {
    snap_bias_1 = vec2(0.125, 0.5);
    tmpvar_45 = bool(1);
  };
  if ((2 == tmpvar_9)) tmpvar_44 = bool(1);
  if (tmpvar_45) tmpvar_44 = bool(0);
  if (tmpvar_44) {
    snap_bias_1 = vec2(0.5, 0.125);
    tmpvar_45 = bool(1);
  };
  if ((3 == tmpvar_9)) tmpvar_44 = bool(1);
  if (tmpvar_45) tmpvar_44 = bool(0);
  if (tmpvar_44) {
    snap_bias_1 = vec2(0.125, 0.125);
    tmpvar_45 = bool(1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (tmpvar_42.w / ((
    float(tmpvar_18.z)
   / 65535.0) * tmpvar_32.y));
  highp vec2 tmpvar_48;
  highp vec2 tmpvar_49;
  tmpvar_48 = ((tmpvar_47 * (tmpvar_42.yz + 
    floor(((tmpvar_2 * (1.0/(tmpvar_47))) + snap_bias_1))
  )) + tmpvar_36);
  tmpvar_49 = (tmpvar_47 * (tmpvar_41.zw - tmpvar_41.xy));
  highp vec2 tmpvar_50;
  tmpvar_50 = clamp ((tmpvar_48 + (tmpvar_49 * aPosition.xy)), tmpvar_15.xy, (tmpvar_15.xy + tmpvar_15.zw));
  highp vec4 tmpvar_51;
  tmpvar_51.zw = vec2(0.0, 1.0);
  tmpvar_51.xy = tmpvar_50;
  highp vec4 tmpvar_52;
  tmpvar_52 = (tmpvar_19 * tmpvar_51);
  highp vec4 tmpvar_53;
  tmpvar_53.xy = ((tmpvar_52.xy * tmpvar_32.y) + ((
    -(tmpvar_32.zw)
   + tmpvar_31.xy) * tmpvar_52.w));
  tmpvar_53.z = (tmpvar_11 * tmpvar_52.w);
  tmpvar_53.w = tmpvar_52.w;
  gl_Position = (uTransform * tmpvar_53);
  highp vec2 tmpvar_54;
  tmpvar_54 = ((tmpvar_50 - tmpvar_48) / tmpvar_49);
  vec4 tmpvar_55;
  tmpvar_55.xy = tmpvar_22.p0;
  tmpvar_55.zw = (tmpvar_22.p0 + tmpvar_22.size);
  vClipMaskUvBounds = tmpvar_55;
  highp vec4 tmpvar_56;
  tmpvar_56.xy = ((tmpvar_52.xy * tmpvar_24) + (tmpvar_52.w * (tmpvar_22.p0 - tmpvar_25)));
  tmpvar_56.z = tmpvar_23;
  tmpvar_56.w = tmpvar_52.w;
  vClipMaskUv = tmpvar_56;
  bool tmpvar_57;
  tmpvar_57 = bool(0);
  bool tmpvar_58;
  tmpvar_58 = bool(0);
  if ((1 == color_mode_3)) tmpvar_57 = bool(1);
  if ((7 == color_mode_3)) tmpvar_57 = bool(1);
  if (tmpvar_58) tmpvar_57 = bool(0);
  if (tmpvar_57) {
    flat_varying_vec4_1.xy = vec2(0.0, 1.0);
    flat_varying_vec4_0 = tmpvar_34;
    tmpvar_58 = bool(1);
  };
  if ((5 == color_mode_3)) tmpvar_57 = bool(1);
  if ((6 == color_mode_3)) tmpvar_57 = bool(1);
  if (tmpvar_58) tmpvar_57 = bool(0);
  if (tmpvar_57) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_34;
    tmpvar_58 = bool(1);
  };
  if ((2 == color_mode_3)) tmpvar_57 = bool(1);
  if ((3 == color_mode_3)) tmpvar_57 = bool(1);
  if ((8 == color_mode_3)) tmpvar_57 = bool(1);
  if (tmpvar_58) tmpvar_57 = bool(0);
  if (tmpvar_57) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_34.wwww;
    tmpvar_58 = bool(1);
  };
  if ((4 == color_mode_3)) tmpvar_57 = bool(1);
  if (tmpvar_58) tmpvar_57 = bool(0);
  if (tmpvar_57) {
    flat_varying_vec4_1.xy = vec2(-1.0, 1.0);
    flat_varying_vec4_0 = (tmpvar_34.wwww * tmpvar_35);
    tmpvar_58 = bool(1);
  };
  tmpvar_57 = bool(1);
  if (tmpvar_58) tmpvar_57 = bool(0);
  if (tmpvar_57) {
    flat_varying_vec4_1.xy = vec2(0.0, 0.0);
    flat_varying_vec4_0 = vec4(1.0, 1.0, 1.0, 1.0);
  };
  lowp vec2 tmpvar_59;
  tmpvar_59 = vec3(textureSize (sColor0, 0)).xy;
  varying_vec4_0.xy = mix ((tmpvar_41.xy / tmpvar_59), (tmpvar_41.zw / tmpvar_59), tmpvar_54);
  varying_vec4_0.z = tmpvar_43;
  flat_varying_vec4_2 = ((tmpvar_41 + vec4(0.5, 0.5, -0.5, -0.5)) / tmpvar_59.xyxy);
}

