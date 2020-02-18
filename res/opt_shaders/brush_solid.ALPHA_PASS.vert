#version 310 es
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
flat out vec4 vClipMaskUvBounds;
out highp vec4 vClipMaskUv;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
flat out highp vec4 flat_varying_vec4_0;
out lowp vec4 varying_vec4_0;
void main ()
{
  lowp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp int tmpvar_5;
  highp int tmpvar_6;
  highp int tmpvar_7;
  tmpvar_5 = (aData.y >> 16);
  tmpvar_6 = (aData.y & 65535);
  tmpvar_7 = (aData.z & 65535);
  highp int tmpvar_8;
  tmpvar_8 = ((aData.z >> 16) & 255);
  highp float tmpvar_9;
  highp ivec2 tmpvar_10;
  highp uint tmpvar_11;
  tmpvar_11 = uint(aData.x);
  tmpvar_10.x = int((2u * (uint(tmpvar_11 % 512u))));
  tmpvar_10.y = int((tmpvar_11 / 512u));
  highp vec4 tmpvar_12;
  tmpvar_12 = texelFetch (sPrimitiveHeadersF, tmpvar_10, 0);
  highp vec4 tmpvar_13;
  tmpvar_13 = texelFetch (sPrimitiveHeadersF, (tmpvar_10 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_14;
  highp vec2 tmpvar_15;
  tmpvar_14 = tmpvar_12.xy;
  tmpvar_15 = tmpvar_12.zw;
  highp ivec2 tmpvar_16;
  tmpvar_16.x = int((2u * (uint(tmpvar_11 % 512u))));
  tmpvar_16.y = int((tmpvar_11 / 512u));
  highp ivec4 tmpvar_17;
  tmpvar_17 = texelFetch (sPrimitiveHeadersI, tmpvar_16, 0);
  highp ivec4 tmpvar_18;
  tmpvar_18 = texelFetch (sPrimitiveHeadersI, (tmpvar_16 + ivec2(1, 0)), 0);
  tmpvar_9 = float(tmpvar_17.x);
  if ((tmpvar_7 == 65535)) {
    tmpvar_3 = tmpvar_14;
    tmpvar_4 = tmpvar_15;
  } else {
    highp int tmpvar_19;
    tmpvar_19 = ((tmpvar_17.y + 1) + (tmpvar_7 * 2));
    highp ivec2 tmpvar_20;
    tmpvar_20.x = int((uint(uint(tmpvar_19) % 1024u)));
    tmpvar_20.y = int((uint(tmpvar_19) / 1024u));
    highp vec4 tmpvar_21;
    tmpvar_21 = texelFetch (sGpuCache, tmpvar_20, 0);
    tmpvar_4 = tmpvar_21.zw;
    tmpvar_3 = (tmpvar_21.xy + tmpvar_12.xy);
  };
  highp ivec2 tmpvar_22;
  tmpvar_22.x = int((2u * (uint(
    uint(tmpvar_5)
   % 512u))));
  tmpvar_22.y = int((uint(tmpvar_5) / 512u));
  highp vec4 tmpvar_23;
  tmpvar_23 = texelFetch (sRenderTasks, tmpvar_22, 0);
  highp vec4 tmpvar_24;
  tmpvar_24 = texelFetch (sRenderTasks, (tmpvar_22 + ivec2(1, 0)), 0);
  RectWithSize tmpvar_25;
  highp float tmpvar_26;
  highp float tmpvar_27;
  highp vec2 tmpvar_28;
  if ((tmpvar_6 >= 32767)) {
    tmpvar_25 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_26 = 0.0;
    tmpvar_27 = 0.0;
    tmpvar_28 = vec2(0.0, 0.0);
  } else {
    highp ivec2 tmpvar_29;
    tmpvar_29.x = int((2u * (uint(
      uint(tmpvar_6)
     % 512u))));
    tmpvar_29.y = int((uint(tmpvar_6) / 512u));
    highp vec4 tmpvar_30;
    tmpvar_30 = texelFetch (sRenderTasks, tmpvar_29, 0);
    highp vec4 tmpvar_31;
    tmpvar_31 = texelFetch (sRenderTasks, (tmpvar_29 + ivec2(1, 0)), 0);
    highp vec3 tmpvar_32;
    tmpvar_32 = tmpvar_31.yzw;
    tmpvar_25.p0 = tmpvar_30.xy;
    tmpvar_25.size = tmpvar_30.zw;
    tmpvar_26 = tmpvar_31.x;
    tmpvar_27 = tmpvar_32.x;
    tmpvar_28 = tmpvar_32.yz;
  };
  highp mat4 tmpvar_33;
  highp int tmpvar_34;
  tmpvar_34 = (tmpvar_17.z & 16777215);
  highp ivec2 tmpvar_35;
  tmpvar_35.x = int((8u * (uint(
    uint(tmpvar_34)
   % 128u))));
  tmpvar_35.y = int((uint(tmpvar_34) / 128u));
  tmpvar_33[0] = texelFetch (sTransformPalette, tmpvar_35, 0);
  tmpvar_33[1] = texelFetch (sTransformPalette, (tmpvar_35 + ivec2(1, 0)), 0);
  tmpvar_33[2] = texelFetch (sTransformPalette, (tmpvar_35 + ivec2(2, 0)), 0);
  tmpvar_33[3] = texelFetch (sTransformPalette, (tmpvar_35 + ivec2(3, 0)), 0);
  if (((tmpvar_17.z >> 24) == 0)) {
    lowp vec2 tmpvar_36;
    tmpvar_36 = clamp ((tmpvar_3 + (tmpvar_4 * aPosition.xy)), tmpvar_13.xy, (tmpvar_13.xy + tmpvar_13.zw));
    lowp vec4 tmpvar_37;
    tmpvar_37.zw = vec2(0.0, 1.0);
    tmpvar_37.xy = tmpvar_36;
    highp vec4 tmpvar_38;
    tmpvar_38 = (tmpvar_33 * tmpvar_37);
    highp vec4 tmpvar_39;
    tmpvar_39.xy = ((tmpvar_38.xy * tmpvar_24.y) + ((
      -(tmpvar_24.zw)
     + tmpvar_23.xy) * tmpvar_38.w));
    tmpvar_39.z = (tmpvar_9 * tmpvar_38.w);
    tmpvar_39.w = tmpvar_38.w;
    gl_Position = (uTransform * tmpvar_39);
    tmpvar_1 = tmpvar_36;
    tmpvar_2 = tmpvar_38;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    lowp vec4 tmpvar_40;
    tmpvar_40 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_8 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_41;
    lowp vec2 tmpvar_42;
    tmpvar_41 = tmpvar_3;
    tmpvar_42 = tmpvar_4;
    highp vec2 tmpvar_43;
    tmpvar_43 = (tmpvar_13.xy + tmpvar_13.zw);
    lowp vec2 tmpvar_44;
    tmpvar_44 = clamp (tmpvar_41, tmpvar_13.xy, tmpvar_43);
    lowp vec2 tmpvar_45;
    tmpvar_45 = clamp ((tmpvar_41 + tmpvar_42), tmpvar_13.xy, tmpvar_43);
    lowp vec4 tmpvar_46;
    tmpvar_46 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_40);
    tmpvar_41 = (tmpvar_41 - tmpvar_46.xy);
    tmpvar_42 = (tmpvar_42 + (tmpvar_46.xy + tmpvar_46.zw));
    lowp vec2 tmpvar_47;
    tmpvar_47 = (tmpvar_41 + (tmpvar_42 * aPosition.xy));
    lowp vec4 tmpvar_48;
    tmpvar_48.zw = vec2(0.0, 1.0);
    tmpvar_48.xy = tmpvar_47;
    highp vec4 tmpvar_49;
    tmpvar_49 = (tmpvar_33 * tmpvar_48);
    highp vec4 tmpvar_50;
    tmpvar_50.xy = ((tmpvar_49.xy * tmpvar_24.y) + ((tmpvar_23.xy - tmpvar_24.zw) * tmpvar_49.w));
    tmpvar_50.z = (tmpvar_9 * tmpvar_49.w);
    tmpvar_50.w = tmpvar_49.w;
    gl_Position = (uTransform * tmpvar_50);
    highp vec4 tmpvar_51;
    tmpvar_51.xy = clamp (tmpvar_12.xy, tmpvar_13.xy, tmpvar_43);
    tmpvar_51.zw = clamp ((tmpvar_12.xy + tmpvar_12.zw), tmpvar_13.xy, tmpvar_43);
    lowp vec4 tmpvar_52;
    tmpvar_52.xy = tmpvar_44;
    tmpvar_52.zw = tmpvar_45;
    vTransformBounds = mix (tmpvar_51, tmpvar_52, tmpvar_40);
    tmpvar_1 = tmpvar_47;
    tmpvar_2 = tmpvar_49;
  };
  vec4 tmpvar_53;
  tmpvar_53.xy = tmpvar_25.p0;
  tmpvar_53.zw = (tmpvar_25.p0 + tmpvar_25.size);
  vClipMaskUvBounds = tmpvar_53;
  highp vec4 tmpvar_54;
  tmpvar_54.xy = ((tmpvar_2.xy * tmpvar_27) + (tmpvar_2.w * (tmpvar_25.p0 - tmpvar_28)));
  tmpvar_54.z = tmpvar_26;
  tmpvar_54.w = tmpvar_2.w;
  vClipMaskUv = tmpvar_54;
  highp ivec2 tmpvar_55;
  tmpvar_55.x = int((uint(uint(tmpvar_17.y) % 1024u)));
  tmpvar_55.y = int((uint(tmpvar_17.y) / 1024u));
  flat_varying_vec4_0 = (texelFetch (sGpuCache, tmpvar_55, 0) * (float(tmpvar_18.x) / 65535.0));
  varying_vec4_0.xy = tmpvar_1;
}

