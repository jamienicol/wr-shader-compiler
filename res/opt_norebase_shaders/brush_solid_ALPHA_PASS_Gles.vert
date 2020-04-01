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
flat out vec4 vClipMaskUvBounds;
out highp vec4 vClipMaskUv;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
flat out highp vec4 flat_varying_vec4_0;
out lowp vec4 varying_vec4_0;
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
  lowp vec2 tmpvar_30;
  highp vec4 tmpvar_31;
  highp vec2 tmpvar_32;
  highp vec2 tmpvar_33;
  highp int tmpvar_34;
  tmpvar_34 = (tmpvar_4 & 255);
  if ((tmpvar_3 == 65535)) {
    tmpvar_32 = tmpvar_10;
    tmpvar_33 = tmpvar_11;
  } else {
    highp int tmpvar_35;
    tmpvar_35 = ((tmpvar_13.y + 1) + (tmpvar_3 * 2));
    highp ivec2 tmpvar_36;
    tmpvar_36.x = int((uint(tmpvar_35) % 1024u));
    tmpvar_36.y = int((uint(tmpvar_35) / 1024u));
    highp vec4 tmpvar_37;
    tmpvar_37 = texelFetch (sGpuCache, tmpvar_36, 0);
    tmpvar_33 = tmpvar_37.zw;
    tmpvar_32 = (tmpvar_37.xy + tmpvar_8.xy);
  };
  if (tmpvar_16) {
    lowp vec2 tmpvar_38;
    tmpvar_38 = clamp ((tmpvar_32 + (tmpvar_33 * aPosition)), tmpvar_9.xy, (tmpvar_9.xy + tmpvar_9.zw));
    lowp vec4 tmpvar_39;
    tmpvar_39.zw = vec2(0.0, 1.0);
    tmpvar_39.xy = tmpvar_38;
    highp vec4 tmpvar_40;
    tmpvar_40 = (tmpvar_15 * tmpvar_39);
    highp vec4 tmpvar_41;
    tmpvar_41.xy = ((tmpvar_40.xy * tmpvar_21.y) + ((
      -(tmpvar_21.zw)
     + tmpvar_20.xy) * tmpvar_40.w));
    tmpvar_41.z = (tmpvar_5 * tmpvar_40.w);
    tmpvar_41.w = tmpvar_40.w;
    gl_Position = (uTransform * tmpvar_41);
    tmpvar_30 = tmpvar_38;
    tmpvar_31 = tmpvar_40;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    lowp vec4 tmpvar_42;
    tmpvar_42 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_34 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_43;
    lowp vec2 tmpvar_44;
    tmpvar_43 = tmpvar_32;
    tmpvar_44 = tmpvar_33;
    highp vec2 tmpvar_45;
    tmpvar_45 = (tmpvar_9.xy + tmpvar_9.zw);
    lowp vec2 tmpvar_46;
    tmpvar_46 = clamp (tmpvar_43, tmpvar_9.xy, tmpvar_45);
    lowp vec2 tmpvar_47;
    tmpvar_47 = clamp ((tmpvar_43 + tmpvar_44), tmpvar_9.xy, tmpvar_45);
    lowp vec4 tmpvar_48;
    tmpvar_48 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_42);
    tmpvar_43 = (tmpvar_43 - tmpvar_48.xy);
    tmpvar_44 = (tmpvar_44 + (tmpvar_48.xy + tmpvar_48.zw));
    lowp vec2 tmpvar_49;
    tmpvar_49 = (tmpvar_43 + (tmpvar_44 * aPosition));
    lowp vec4 tmpvar_50;
    tmpvar_50.zw = vec2(0.0, 1.0);
    tmpvar_50.xy = tmpvar_49;
    highp vec4 tmpvar_51;
    tmpvar_51 = (tmpvar_15 * tmpvar_50);
    highp vec4 tmpvar_52;
    tmpvar_52.xy = ((tmpvar_51.xy * tmpvar_21.y) + ((tmpvar_20.xy - tmpvar_21.zw) * tmpvar_51.w));
    tmpvar_52.z = (tmpvar_5 * tmpvar_51.w);
    tmpvar_52.w = tmpvar_51.w;
    gl_Position = (uTransform * tmpvar_52);
    highp vec4 tmpvar_53;
    tmpvar_53.xy = clamp (tmpvar_8.xy, tmpvar_9.xy, tmpvar_45);
    tmpvar_53.zw = clamp ((tmpvar_8.xy + tmpvar_8.zw), tmpvar_9.xy, tmpvar_45);
    lowp vec4 tmpvar_54;
    tmpvar_54.xy = tmpvar_46;
    tmpvar_54.zw = tmpvar_47;
    vTransformBounds = mix (tmpvar_53, tmpvar_54, tmpvar_42);
    tmpvar_30 = tmpvar_49;
    tmpvar_31 = tmpvar_51;
  };
  vec4 tmpvar_55;
  tmpvar_55.xy = tmpvar_22.p0;
  tmpvar_55.zw = (tmpvar_22.p0 + tmpvar_22.size);
  vClipMaskUvBounds = tmpvar_55;
  highp vec4 tmpvar_56;
  tmpvar_56.xy = ((tmpvar_31.xy * tmpvar_24) + (tmpvar_31.w * (tmpvar_22.p0 - tmpvar_25)));
  tmpvar_56.z = tmpvar_23;
  tmpvar_56.w = tmpvar_31.w;
  vClipMaskUv = tmpvar_56;
  highp ivec2 tmpvar_57;
  tmpvar_57.x = int((uint(tmpvar_13.y) % 1024u));
  tmpvar_57.y = int((uint(tmpvar_13.y) / 1024u));
  flat_varying_vec4_0 = (texelFetch (sGpuCache, tmpvar_57, 0) * (float(tmpvar_14.x) / 65535.0));
  varying_vec4_0.xy = tmpvar_30;
}

