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
flat out highp vec4 flat_varying_vec4_1;
flat out highp vec4 flat_varying_vec4_2;
out highp vec4 varying_vec4_0;
flat out highp int flat_varying_highp_int_address_0;
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
  highp vec4 segment_data_34;
  highp int tmpvar_35;
  tmpvar_35 = (tmpvar_4 & 255);
  highp int tmpvar_36;
  tmpvar_36 = ((tmpvar_4 >> 8) & 255);
  if ((tmpvar_3 == 65535)) {
    tmpvar_32 = tmpvar_10;
    tmpvar_33 = tmpvar_11;
    segment_data_34 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp int tmpvar_37;
    tmpvar_37 = ((tmpvar_13.y + 2) + (tmpvar_3 * 2));
    highp ivec2 tmpvar_38;
    tmpvar_38.x = int((uint(tmpvar_37) % 1024u));
    tmpvar_38.y = int((uint(tmpvar_37) / 1024u));
    highp vec4 tmpvar_39;
    tmpvar_39 = texelFetch (sGpuCache, tmpvar_38, 0);
    tmpvar_33 = tmpvar_39.zw;
    tmpvar_32 = (tmpvar_39.xy + tmpvar_8.xy);
    segment_data_34 = texelFetch (sGpuCache, (tmpvar_38 + ivec2(1, 0)), 0);
  };
  if (tmpvar_16) {
    lowp vec2 tmpvar_40;
    tmpvar_40 = clamp ((tmpvar_32 + (tmpvar_33 * aPosition)), tmpvar_9.xy, (tmpvar_9.xy + tmpvar_9.zw));
    lowp vec4 tmpvar_41;
    tmpvar_41.zw = vec2(0.0, 1.0);
    tmpvar_41.xy = tmpvar_40;
    highp vec4 tmpvar_42;
    tmpvar_42 = (tmpvar_15 * tmpvar_41);
    highp vec4 tmpvar_43;
    tmpvar_43.xy = ((tmpvar_42.xy * tmpvar_21.y) + ((
      -(tmpvar_21.zw)
     + tmpvar_20.xy) * tmpvar_42.w));
    tmpvar_43.z = (tmpvar_5 * tmpvar_42.w);
    tmpvar_43.w = tmpvar_42.w;
    gl_Position = (uTransform * tmpvar_43);
    tmpvar_30 = tmpvar_40;
    tmpvar_31 = tmpvar_42;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    lowp vec4 tmpvar_44;
    tmpvar_44 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_35 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_45;
    lowp vec2 tmpvar_46;
    tmpvar_45 = tmpvar_32;
    tmpvar_46 = tmpvar_33;
    highp vec2 tmpvar_47;
    tmpvar_47 = (tmpvar_9.xy + tmpvar_9.zw);
    lowp vec2 tmpvar_48;
    tmpvar_48 = clamp (tmpvar_45, tmpvar_9.xy, tmpvar_47);
    lowp vec2 tmpvar_49;
    tmpvar_49 = clamp ((tmpvar_45 + tmpvar_46), tmpvar_9.xy, tmpvar_47);
    lowp vec4 tmpvar_50;
    tmpvar_50 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_44);
    tmpvar_45 = (tmpvar_45 - tmpvar_50.xy);
    tmpvar_46 = (tmpvar_46 + (tmpvar_50.xy + tmpvar_50.zw));
    lowp vec2 tmpvar_51;
    tmpvar_51 = (tmpvar_45 + (tmpvar_46 * aPosition));
    lowp vec4 tmpvar_52;
    tmpvar_52.zw = vec2(0.0, 1.0);
    tmpvar_52.xy = tmpvar_51;
    highp vec4 tmpvar_53;
    tmpvar_53 = (tmpvar_15 * tmpvar_52);
    highp vec4 tmpvar_54;
    tmpvar_54.xy = ((tmpvar_53.xy * tmpvar_21.y) + ((tmpvar_20.xy - tmpvar_21.zw) * tmpvar_53.w));
    tmpvar_54.z = (tmpvar_5 * tmpvar_53.w);
    tmpvar_54.w = tmpvar_53.w;
    gl_Position = (uTransform * tmpvar_54);
    highp vec4 tmpvar_55;
    tmpvar_55.xy = clamp (tmpvar_8.xy, tmpvar_9.xy, tmpvar_47);
    tmpvar_55.zw = clamp ((tmpvar_8.xy + tmpvar_8.zw), tmpvar_9.xy, tmpvar_47);
    lowp vec4 tmpvar_56;
    tmpvar_56.xy = tmpvar_48;
    tmpvar_56.zw = tmpvar_49;
    vTransformBounds = mix (tmpvar_55, tmpvar_56, tmpvar_44);
    tmpvar_30 = tmpvar_51;
    tmpvar_31 = tmpvar_53;
  };
  vec4 tmpvar_57;
  tmpvar_57.xy = tmpvar_22.p0;
  tmpvar_57.zw = (tmpvar_22.p0 + tmpvar_22.size);
  vClipMaskUvBounds = tmpvar_57;
  highp vec4 tmpvar_58;
  tmpvar_58.xy = ((tmpvar_31.xy * tmpvar_24) + (tmpvar_31.w * (tmpvar_22.p0 - tmpvar_25)));
  tmpvar_58.z = tmpvar_23;
  tmpvar_58.w = tmpvar_31.w;
  vClipMaskUv = tmpvar_58;
  highp ivec2 tmpvar_59;
  tmpvar_59.x = int((uint(tmpvar_13.y) % 1024u));
  tmpvar_59.y = int((uint(tmpvar_13.y) / 1024u));
  highp vec4 tmpvar_60;
  highp vec4 tmpvar_61;
  tmpvar_60 = texelFetch (sGpuCache, tmpvar_59, 0);
  tmpvar_61 = texelFetch (sGpuCache, (tmpvar_59 + ivec2(1, 0)), 0);
  highp int tmpvar_62;
  highp vec2 tmpvar_63;
  tmpvar_62 = int(tmpvar_61.x);
  tmpvar_63 = tmpvar_61.yz;
  if (((tmpvar_36 & 2) != 0)) {
    varying_vec4_0.zw = ((tmpvar_30 - tmpvar_32) / tmpvar_33);
    varying_vec4_0.zw = ((varying_vec4_0.zw * (segment_data_34.zw - segment_data_34.xy)) + segment_data_34.xy);
    varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_8.zw);
  } else {
    varying_vec4_0.zw = (tmpvar_30 - tmpvar_8.xy);
  };
  highp vec2 tmpvar_64;
  tmpvar_64 = (tmpvar_60.zw - tmpvar_60.xy);
  flat_varying_vec4_0.xy = tmpvar_60.xy;
  flat_varying_vec4_0.zw = (tmpvar_64 / dot (tmpvar_64, tmpvar_64));
  flat_varying_vec4_1.xy = tmpvar_63;
  flat_varying_highp_int_address_0 = tmpvar_14.x;
  flat_varying_vec4_1.z = float((tmpvar_62 != 0));
  flat_varying_vec4_2.xy = (tmpvar_8.zw / tmpvar_61.yz);
  varying_vec4_0.xy = tmpvar_30;
}

