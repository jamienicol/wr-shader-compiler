#version 300 es
precision highp sampler2DArray;
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform mat4 uTransform;
in vec2 aPosition;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
flat out lowp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
uniform sampler2DArray sPrevPassColor;
flat out vec4 vClipMaskUvBounds;
out highp vec4 vClipMaskUv;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
flat out highp ivec4 flat_varying_ivec4_0;
out lowp vec4 varying_vec4_0;
out lowp vec4 varying_vec4_1;
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
  highp vec4 tmpvar_30;
  highp vec2 tmpvar_31;
  highp vec2 tmpvar_32;
  highp int tmpvar_33;
  tmpvar_33 = (tmpvar_4 & 255);
  if ((tmpvar_3 == 65535)) {
    tmpvar_31 = tmpvar_10;
    tmpvar_32 = tmpvar_11;
  } else {
    highp int tmpvar_34;
    tmpvar_34 = ((tmpvar_13.y + 3) + (tmpvar_3 * 2));
    highp ivec2 tmpvar_35;
    tmpvar_35.x = int((uint(tmpvar_34) % 1024u));
    tmpvar_35.y = int((uint(tmpvar_34) / 1024u));
    highp vec4 tmpvar_36;
    tmpvar_36 = texelFetch (sGpuCache, tmpvar_35, 0);
    tmpvar_32 = tmpvar_36.zw;
    tmpvar_31 = (tmpvar_36.xy + tmpvar_8.xy);
  };
  if (tmpvar_16) {
    lowp vec2 tmpvar_37;
    tmpvar_37 = clamp ((tmpvar_31 + (tmpvar_32 * aPosition)), tmpvar_9.xy, (tmpvar_9.xy + tmpvar_9.zw));
    lowp vec4 tmpvar_38;
    tmpvar_38.zw = vec2(0.0, 1.0);
    tmpvar_38.xy = tmpvar_37;
    highp vec4 tmpvar_39;
    tmpvar_39 = (tmpvar_15 * tmpvar_38);
    highp vec4 tmpvar_40;
    tmpvar_40.xy = ((tmpvar_39.xy * tmpvar_21.y) + ((
      -(tmpvar_21.zw)
     + tmpvar_20.xy) * tmpvar_39.w));
    tmpvar_40.z = (tmpvar_5 * tmpvar_39.w);
    tmpvar_40.w = tmpvar_39.w;
    gl_Position = (uTransform * tmpvar_40);
    tmpvar_30 = tmpvar_39;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    lowp vec4 tmpvar_41;
    tmpvar_41 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_33 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_42;
    lowp vec2 tmpvar_43;
    tmpvar_42 = tmpvar_31;
    tmpvar_43 = tmpvar_32;
    highp vec2 tmpvar_44;
    tmpvar_44 = (tmpvar_9.xy + tmpvar_9.zw);
    lowp vec2 tmpvar_45;
    tmpvar_45 = clamp (tmpvar_42, tmpvar_9.xy, tmpvar_44);
    lowp vec2 tmpvar_46;
    tmpvar_46 = clamp ((tmpvar_42 + tmpvar_43), tmpvar_9.xy, tmpvar_44);
    lowp vec4 tmpvar_47;
    tmpvar_47 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_41);
    tmpvar_42 = (tmpvar_42 - tmpvar_47.xy);
    tmpvar_43 = (tmpvar_43 + (tmpvar_47.xy + tmpvar_47.zw));
    lowp vec4 tmpvar_48;
    tmpvar_48.zw = vec2(0.0, 1.0);
    tmpvar_48.xy = (tmpvar_42 + (tmpvar_43 * aPosition));
    highp vec4 tmpvar_49;
    tmpvar_49 = (tmpvar_15 * tmpvar_48);
    highp vec4 tmpvar_50;
    tmpvar_50.xy = ((tmpvar_49.xy * tmpvar_21.y) + ((tmpvar_20.xy - tmpvar_21.zw) * tmpvar_49.w));
    tmpvar_50.z = (tmpvar_5 * tmpvar_49.w);
    tmpvar_50.w = tmpvar_49.w;
    gl_Position = (uTransform * tmpvar_50);
    highp vec4 tmpvar_51;
    tmpvar_51.xy = clamp (tmpvar_8.xy, tmpvar_9.xy, tmpvar_44);
    tmpvar_51.zw = clamp ((tmpvar_8.xy + tmpvar_8.zw), tmpvar_9.xy, tmpvar_44);
    lowp vec4 tmpvar_52;
    tmpvar_52.xy = tmpvar_45;
    tmpvar_52.zw = tmpvar_46;
    vTransformBounds = mix (tmpvar_51, tmpvar_52, tmpvar_41);
    tmpvar_30 = tmpvar_49;
  };
  vec4 tmpvar_53;
  tmpvar_53.xy = tmpvar_22.p0;
  tmpvar_53.zw = (tmpvar_22.p0 + tmpvar_22.size);
  vClipMaskUvBounds = tmpvar_53;
  highp vec4 tmpvar_54;
  tmpvar_54.xy = ((tmpvar_30.xy * tmpvar_24) + (tmpvar_30.w * (tmpvar_22.p0 - tmpvar_25)));
  tmpvar_54.z = tmpvar_23;
  tmpvar_54.w = tmpvar_30.w;
  vClipMaskUv = tmpvar_54;
  lowp vec2 tmpvar_55;
  tmpvar_55 = vec3(textureSize (sPrevPassColor, 0)).xy;
  flat_varying_ivec4_0.x = tmpvar_14.x;
  highp float tmpvar_56;
  highp ivec2 tmpvar_57;
  tmpvar_57.x = int((2u * (
    uint(tmpvar_14.z)
   % 512u)));
  tmpvar_57.y = int((uint(tmpvar_14.z) / 512u));
  highp vec4 tmpvar_58;
  tmpvar_58 = texelFetch (sRenderTasks, (tmpvar_57 + ivec2(1, 0)), 0);
  tmpvar_56 = tmpvar_58.x;
  highp vec2 tmpvar_59;
  tmpvar_59 = (((tmpvar_30.xy * 
    (tmpvar_58.y / max (0.0, tmpvar_30.w))
  ) + texelFetch (sRenderTasks, tmpvar_57, 0).xy) - tmpvar_58.zw);
  varying_vec4_0.xy = (tmpvar_59 / tmpvar_55);
  varying_vec4_0.w = tmpvar_56;
  highp ivec2 tmpvar_60;
  tmpvar_60.x = int((2u * (
    uint(tmpvar_14.y)
   % 512u)));
  tmpvar_60.y = int((uint(tmpvar_14.y) / 512u));
  highp float tmpvar_61;
  tmpvar_61 = texelFetch (sRenderTasks, (tmpvar_60 + ivec2(1, 0)), 0).x;
  highp vec2 tmpvar_62;
  tmpvar_62 = (((
    (tmpvar_30.xy * tmpvar_21.y)
   / 
    max (0.0, tmpvar_30.w)
  ) + texelFetch (sRenderTasks, tmpvar_60, 0).xy) - (tmpvar_58.zw * (tmpvar_21.y / tmpvar_58.y)));
  varying_vec4_1.xy = (tmpvar_62 / tmpvar_55);
  varying_vec4_1.w = tmpvar_61;
}

