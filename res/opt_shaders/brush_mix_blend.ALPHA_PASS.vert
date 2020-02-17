#version 300 es
precision highp sampler2DArray;
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform mat4 uTransform;
in vec3 aPosition;
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
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp int tmpvar_4;
  highp int tmpvar_5;
  highp int tmpvar_6;
  tmpvar_4 = (aData.y >> 16);
  tmpvar_5 = (aData.y & 65535);
  tmpvar_6 = (aData.z & 65535);
  highp int tmpvar_7;
  tmpvar_7 = ((aData.z >> 16) & 255);
  highp float tmpvar_8;
  highp ivec2 tmpvar_9;
  highp uint tmpvar_10;
  tmpvar_10 = uint(aData.x);
  tmpvar_9.x = int((2u * (uint(mod (tmpvar_10, 512u)))));
  tmpvar_9.y = int((tmpvar_10 / 512u));
  highp vec4 tmpvar_11;
  tmpvar_11 = texelFetch (sPrimitiveHeadersF, tmpvar_9, 0);
  highp vec4 tmpvar_12;
  tmpvar_12 = texelFetch (sPrimitiveHeadersF, (tmpvar_9 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_13 = tmpvar_11.xy;
  tmpvar_14 = tmpvar_11.zw;
  highp ivec2 tmpvar_15;
  tmpvar_15.x = int((2u * (uint(mod (tmpvar_10, 512u)))));
  tmpvar_15.y = int((tmpvar_10 / 512u));
  highp ivec4 tmpvar_16;
  tmpvar_16 = texelFetch (sPrimitiveHeadersI, tmpvar_15, 0);
  highp ivec4 tmpvar_17;
  tmpvar_17 = texelFetch (sPrimitiveHeadersI, (tmpvar_15 + ivec2(1, 0)), 0);
  tmpvar_8 = float(tmpvar_16.x);
  if ((tmpvar_6 == 65535)) {
    tmpvar_2 = tmpvar_13;
    tmpvar_3 = tmpvar_14;
  } else {
    highp int tmpvar_18;
    tmpvar_18 = ((tmpvar_16.y + 3) + (tmpvar_6 * 2));
    highp ivec2 tmpvar_19;
    tmpvar_19.x = int((uint(mod (uint(tmpvar_18), 1024u))));
    tmpvar_19.y = int((uint(tmpvar_18) / 1024u));
    highp vec4 tmpvar_20;
    tmpvar_20 = texelFetch (sGpuCache, tmpvar_19, 0);
    tmpvar_3 = tmpvar_20.zw;
    tmpvar_2 = (tmpvar_20.xy + tmpvar_11.xy);
  };
  highp ivec2 tmpvar_21;
  tmpvar_21.x = int((2u * (uint(mod (
    uint(tmpvar_4)
  , 512u)))));
  tmpvar_21.y = int((uint(tmpvar_4) / 512u));
  highp vec4 tmpvar_22;
  tmpvar_22 = texelFetch (sRenderTasks, tmpvar_21, 0);
  highp vec4 tmpvar_23;
  tmpvar_23 = texelFetch (sRenderTasks, (tmpvar_21 + ivec2(1, 0)), 0);
  RectWithSize tmpvar_24;
  highp float tmpvar_25;
  highp float tmpvar_26;
  highp vec2 tmpvar_27;
  if ((tmpvar_5 >= 32767)) {
    tmpvar_24 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_25 = 0.0;
    tmpvar_26 = 0.0;
    tmpvar_27 = vec2(0.0, 0.0);
  } else {
    highp ivec2 tmpvar_28;
    tmpvar_28.x = int((2u * (uint(mod (
      uint(tmpvar_5)
    , 512u)))));
    tmpvar_28.y = int((uint(tmpvar_5) / 512u));
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
  highp mat4 tmpvar_32;
  highp int tmpvar_33;
  tmpvar_33 = (tmpvar_16.z & 16777215);
  highp ivec2 tmpvar_34;
  tmpvar_34.x = int((8u * (uint(mod (
    uint(tmpvar_33)
  , 128u)))));
  tmpvar_34.y = int((uint(tmpvar_33) / 128u));
  tmpvar_32[0] = texelFetch (sTransformPalette, tmpvar_34, 0);
  tmpvar_32[1] = texelFetch (sTransformPalette, (tmpvar_34 + ivec2(1, 0)), 0);
  tmpvar_32[2] = texelFetch (sTransformPalette, (tmpvar_34 + ivec2(2, 0)), 0);
  tmpvar_32[3] = texelFetch (sTransformPalette, (tmpvar_34 + ivec2(3, 0)), 0);
  if (((tmpvar_16.z >> 24) == 0)) {
    lowp vec2 tmpvar_35;
    tmpvar_35 = clamp ((tmpvar_2 + (tmpvar_3 * aPosition.xy)), tmpvar_12.xy, (tmpvar_12.xy + tmpvar_12.zw));
    lowp vec4 tmpvar_36;
    tmpvar_36.zw = vec2(0.0, 1.0);
    tmpvar_36.xy = tmpvar_35;
    highp vec4 tmpvar_37;
    tmpvar_37 = (tmpvar_32 * tmpvar_36);
    highp vec4 tmpvar_38;
    tmpvar_38.xy = ((tmpvar_37.xy * tmpvar_23.y) + ((
      -(tmpvar_23.zw)
     + tmpvar_22.xy) * tmpvar_37.w));
    tmpvar_38.z = (tmpvar_8 * tmpvar_37.w);
    tmpvar_38.w = tmpvar_37.w;
    gl_Position = (uTransform * tmpvar_38);
    tmpvar_1 = tmpvar_37;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    lowp vec4 tmpvar_39;
    tmpvar_39 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_7 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_40;
    lowp vec2 tmpvar_41;
    tmpvar_40 = tmpvar_2;
    tmpvar_41 = tmpvar_3;
    highp vec2 tmpvar_42;
    tmpvar_42 = (tmpvar_12.xy + tmpvar_12.zw);
    lowp vec2 tmpvar_43;
    tmpvar_43 = clamp (tmpvar_40, tmpvar_12.xy, tmpvar_42);
    lowp vec2 tmpvar_44;
    tmpvar_44 = clamp ((tmpvar_40 + tmpvar_41), tmpvar_12.xy, tmpvar_42);
    lowp vec4 tmpvar_45;
    tmpvar_45 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_39);
    tmpvar_40 = (tmpvar_40 - tmpvar_45.xy);
    tmpvar_41 = (tmpvar_41 + (tmpvar_45.xy + tmpvar_45.zw));
    lowp vec4 tmpvar_46;
    tmpvar_46.zw = vec2(0.0, 1.0);
    tmpvar_46.xy = (tmpvar_40 + (tmpvar_41 * aPosition.xy));
    highp vec4 tmpvar_47;
    tmpvar_47 = (tmpvar_32 * tmpvar_46);
    highp vec4 tmpvar_48;
    tmpvar_48.xy = ((tmpvar_47.xy * tmpvar_23.y) + ((tmpvar_22.xy - tmpvar_23.zw) * tmpvar_47.w));
    tmpvar_48.z = (tmpvar_8 * tmpvar_47.w);
    tmpvar_48.w = tmpvar_47.w;
    gl_Position = (uTransform * tmpvar_48);
    highp vec4 tmpvar_49;
    tmpvar_49.xy = clamp (tmpvar_11.xy, tmpvar_12.xy, tmpvar_42);
    tmpvar_49.zw = clamp ((tmpvar_11.xy + tmpvar_11.zw), tmpvar_12.xy, tmpvar_42);
    lowp vec4 tmpvar_50;
    tmpvar_50.xy = tmpvar_43;
    tmpvar_50.zw = tmpvar_44;
    vTransformBounds = mix (tmpvar_49, tmpvar_50, tmpvar_39);
    tmpvar_1 = tmpvar_47;
  };
  vec4 tmpvar_51;
  tmpvar_51.xy = tmpvar_24.p0;
  tmpvar_51.zw = (tmpvar_24.p0 + tmpvar_24.size);
  vClipMaskUvBounds = tmpvar_51;
  highp vec4 tmpvar_52;
  tmpvar_52.xy = ((tmpvar_1.xy * tmpvar_26) + (tmpvar_1.w * (tmpvar_24.p0 - tmpvar_27)));
  tmpvar_52.z = tmpvar_25;
  tmpvar_52.w = tmpvar_1.w;
  vClipMaskUv = tmpvar_52;
  highp vec2 tmpvar_53;
  tmpvar_53 = ((tmpvar_1.xy * tmpvar_23.y) / max (0.0, tmpvar_1.w));
  lowp vec2 tmpvar_54;
  tmpvar_54 = vec3(textureSize (sPrevPassColor, 0)).xy;
  flat_varying_ivec4_0.x = tmpvar_17.x;
  highp float tmpvar_55;
  highp ivec2 tmpvar_56;
  tmpvar_56.x = int((2u * (uint(mod (
    uint(tmpvar_17.z)
  , 512u)))));
  tmpvar_56.y = int((uint(tmpvar_17.z) / 512u));
  highp vec4 tmpvar_57;
  tmpvar_57 = texelFetch (sRenderTasks, (tmpvar_56 + ivec2(1, 0)), 0);
  tmpvar_55 = tmpvar_57.x;
  highp vec2 tmpvar_58;
  tmpvar_58 = ((tmpvar_53 + texelFetch (sRenderTasks, tmpvar_56, 0).xy) - tmpvar_57.zw);
  varying_vec4_0.xy = (tmpvar_58 / tmpvar_54);
  varying_vec4_0.w = tmpvar_55;
  highp ivec2 tmpvar_59;
  tmpvar_59.x = int((2u * (uint(mod (
    uint(tmpvar_17.y)
  , 512u)))));
  tmpvar_59.y = int((uint(tmpvar_17.y) / 512u));
  highp float tmpvar_60;
  tmpvar_60 = texelFetch (sRenderTasks, (tmpvar_59 + ivec2(1, 0)), 0).x;
  highp vec2 tmpvar_61;
  tmpvar_61 = ((tmpvar_53 + texelFetch (sRenderTasks, tmpvar_59, 0).xy) - tmpvar_57.zw);
  varying_vec4_1.xy = (tmpvar_61 / tmpvar_54);
  varying_vec4_1.w = tmpvar_60;
}

