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
  lowp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 segment_data_5;
  highp int tmpvar_6;
  highp int tmpvar_7;
  highp int tmpvar_8;
  highp int tmpvar_9;
  tmpvar_6 = (aData.y >> 16);
  tmpvar_7 = (aData.y & 65535);
  tmpvar_8 = (aData.z & 65535);
  tmpvar_9 = (aData.z >> 16);
  highp int tmpvar_10;
  tmpvar_10 = (tmpvar_9 & 255);
  highp int tmpvar_11;
  tmpvar_11 = ((tmpvar_9 >> 8) & 255);
  highp float tmpvar_12;
  highp ivec2 tmpvar_13;
  highp uint tmpvar_14;
  tmpvar_14 = uint(aData.x);
  tmpvar_13.x = int((2u * (uint(tmpvar_14 % 512u))));
  tmpvar_13.y = int((tmpvar_14 / 512u));
  highp vec4 tmpvar_15;
  tmpvar_15 = texelFetch (sPrimitiveHeadersF, tmpvar_13, 0);
  highp vec4 tmpvar_16;
  tmpvar_16 = texelFetch (sPrimitiveHeadersF, (tmpvar_13 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_17 = tmpvar_15.xy;
  tmpvar_18 = tmpvar_15.zw;
  highp ivec2 tmpvar_19;
  tmpvar_19.x = int((2u * (uint(tmpvar_14 % 512u))));
  tmpvar_19.y = int((tmpvar_14 / 512u));
  highp ivec4 tmpvar_20;
  tmpvar_20 = texelFetch (sPrimitiveHeadersI, tmpvar_19, 0);
  highp ivec4 tmpvar_21;
  tmpvar_21 = texelFetch (sPrimitiveHeadersI, (tmpvar_19 + ivec2(1, 0)), 0);
  tmpvar_12 = float(tmpvar_20.x);
  if ((tmpvar_8 == 65535)) {
    tmpvar_3 = tmpvar_17;
    tmpvar_4 = tmpvar_18;
    segment_data_5 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp int tmpvar_22;
    tmpvar_22 = ((tmpvar_20.y + 2) + (tmpvar_8 * 2));
    highp ivec2 tmpvar_23;
    tmpvar_23.x = int((uint(uint(tmpvar_22) % 1024u)));
    tmpvar_23.y = int((uint(tmpvar_22) / 1024u));
    highp vec4 tmpvar_24;
    tmpvar_24 = texelFetch (sGpuCache, tmpvar_23, 0);
    tmpvar_4 = tmpvar_24.zw;
    tmpvar_3 = (tmpvar_24.xy + tmpvar_15.xy);
    segment_data_5 = texelFetch (sGpuCache, (tmpvar_23 + ivec2(1, 0)), 0);
  };
  highp ivec2 tmpvar_25;
  tmpvar_25.x = int((2u * (uint(
    uint(tmpvar_6)
   % 512u))));
  tmpvar_25.y = int((uint(tmpvar_6) / 512u));
  highp vec4 tmpvar_26;
  tmpvar_26 = texelFetch (sRenderTasks, tmpvar_25, 0);
  highp vec4 tmpvar_27;
  tmpvar_27 = texelFetch (sRenderTasks, (tmpvar_25 + ivec2(1, 0)), 0);
  RectWithSize tmpvar_28;
  highp float tmpvar_29;
  highp float tmpvar_30;
  highp vec2 tmpvar_31;
  if ((tmpvar_7 >= 32767)) {
    tmpvar_28 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_29 = 0.0;
    tmpvar_30 = 0.0;
    tmpvar_31 = vec2(0.0, 0.0);
  } else {
    highp ivec2 tmpvar_32;
    tmpvar_32.x = int((2u * (uint(
      uint(tmpvar_7)
     % 512u))));
    tmpvar_32.y = int((uint(tmpvar_7) / 512u));
    highp vec4 tmpvar_33;
    tmpvar_33 = texelFetch (sRenderTasks, tmpvar_32, 0);
    highp vec4 tmpvar_34;
    tmpvar_34 = texelFetch (sRenderTasks, (tmpvar_32 + ivec2(1, 0)), 0);
    highp vec3 tmpvar_35;
    tmpvar_35 = tmpvar_34.yzw;
    tmpvar_28.p0 = tmpvar_33.xy;
    tmpvar_28.size = tmpvar_33.zw;
    tmpvar_29 = tmpvar_34.x;
    tmpvar_30 = tmpvar_35.x;
    tmpvar_31 = tmpvar_35.yz;
  };
  highp mat4 tmpvar_36;
  highp int tmpvar_37;
  tmpvar_37 = (tmpvar_20.z & 16777215);
  highp ivec2 tmpvar_38;
  tmpvar_38.x = int((8u * (uint(
    uint(tmpvar_37)
   % 128u))));
  tmpvar_38.y = int((uint(tmpvar_37) / 128u));
  tmpvar_36[0] = texelFetch (sTransformPalette, tmpvar_38, 0);
  tmpvar_36[1] = texelFetch (sTransformPalette, (tmpvar_38 + ivec2(1, 0)), 0);
  tmpvar_36[2] = texelFetch (sTransformPalette, (tmpvar_38 + ivec2(2, 0)), 0);
  tmpvar_36[3] = texelFetch (sTransformPalette, (tmpvar_38 + ivec2(3, 0)), 0);
  if (((tmpvar_20.z >> 24) == 0)) {
    lowp vec2 tmpvar_39;
    tmpvar_39 = clamp ((tmpvar_3 + (tmpvar_4 * aPosition.xy)), tmpvar_16.xy, (tmpvar_16.xy + tmpvar_16.zw));
    lowp vec4 tmpvar_40;
    tmpvar_40.zw = vec2(0.0, 1.0);
    tmpvar_40.xy = tmpvar_39;
    highp vec4 tmpvar_41;
    tmpvar_41 = (tmpvar_36 * tmpvar_40);
    highp vec4 tmpvar_42;
    tmpvar_42.xy = ((tmpvar_41.xy * tmpvar_27.y) + ((
      -(tmpvar_27.zw)
     + tmpvar_26.xy) * tmpvar_41.w));
    tmpvar_42.z = (tmpvar_12 * tmpvar_41.w);
    tmpvar_42.w = tmpvar_41.w;
    gl_Position = (uTransform * tmpvar_42);
    tmpvar_1 = tmpvar_39;
    tmpvar_2 = tmpvar_41;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    lowp vec4 tmpvar_43;
    tmpvar_43 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_10 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_44;
    lowp vec2 tmpvar_45;
    tmpvar_44 = tmpvar_3;
    tmpvar_45 = tmpvar_4;
    highp vec2 tmpvar_46;
    tmpvar_46 = (tmpvar_16.xy + tmpvar_16.zw);
    lowp vec2 tmpvar_47;
    tmpvar_47 = clamp (tmpvar_44, tmpvar_16.xy, tmpvar_46);
    lowp vec2 tmpvar_48;
    tmpvar_48 = clamp ((tmpvar_44 + tmpvar_45), tmpvar_16.xy, tmpvar_46);
    lowp vec4 tmpvar_49;
    tmpvar_49 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_43);
    tmpvar_44 = (tmpvar_44 - tmpvar_49.xy);
    tmpvar_45 = (tmpvar_45 + (tmpvar_49.xy + tmpvar_49.zw));
    lowp vec2 tmpvar_50;
    tmpvar_50 = (tmpvar_44 + (tmpvar_45 * aPosition.xy));
    lowp vec4 tmpvar_51;
    tmpvar_51.zw = vec2(0.0, 1.0);
    tmpvar_51.xy = tmpvar_50;
    highp vec4 tmpvar_52;
    tmpvar_52 = (tmpvar_36 * tmpvar_51);
    highp vec4 tmpvar_53;
    tmpvar_53.xy = ((tmpvar_52.xy * tmpvar_27.y) + ((tmpvar_26.xy - tmpvar_27.zw) * tmpvar_52.w));
    tmpvar_53.z = (tmpvar_12 * tmpvar_52.w);
    tmpvar_53.w = tmpvar_52.w;
    gl_Position = (uTransform * tmpvar_53);
    highp vec4 tmpvar_54;
    tmpvar_54.xy = clamp (tmpvar_15.xy, tmpvar_16.xy, tmpvar_46);
    tmpvar_54.zw = clamp ((tmpvar_15.xy + tmpvar_15.zw), tmpvar_16.xy, tmpvar_46);
    lowp vec4 tmpvar_55;
    tmpvar_55.xy = tmpvar_47;
    tmpvar_55.zw = tmpvar_48;
    vTransformBounds = mix (tmpvar_54, tmpvar_55, tmpvar_43);
    tmpvar_1 = tmpvar_50;
    tmpvar_2 = tmpvar_52;
  };
  vec4 tmpvar_56;
  tmpvar_56.xy = tmpvar_28.p0;
  tmpvar_56.zw = (tmpvar_28.p0 + tmpvar_28.size);
  vClipMaskUvBounds = tmpvar_56;
  highp vec4 tmpvar_57;
  tmpvar_57.xy = ((tmpvar_2.xy * tmpvar_30) + (tmpvar_2.w * (tmpvar_28.p0 - tmpvar_31)));
  tmpvar_57.z = tmpvar_29;
  tmpvar_57.w = tmpvar_2.w;
  vClipMaskUv = tmpvar_57;
  highp ivec2 tmpvar_58;
  tmpvar_58.x = int((uint(uint(tmpvar_20.y) % 1024u)));
  tmpvar_58.y = int((uint(tmpvar_20.y) / 1024u));
  highp vec4 tmpvar_59;
  highp vec4 tmpvar_60;
  tmpvar_59 = texelFetch (sGpuCache, tmpvar_58, 0);
  tmpvar_60 = texelFetch (sGpuCache, (tmpvar_58 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_61;
  highp float tmpvar_62;
  highp int tmpvar_63;
  highp vec2 tmpvar_64;
  tmpvar_61 = tmpvar_59.xy;
  tmpvar_62 = tmpvar_59.z;
  tmpvar_63 = int(tmpvar_60.x);
  tmpvar_64 = tmpvar_60.yz;
  if (((tmpvar_11 & 2) != 0)) {
    varying_vec4_0.zw = ((tmpvar_1 - tmpvar_3) / tmpvar_4);
    varying_vec4_0.zw = ((varying_vec4_0.zw * (segment_data_5.zw - segment_data_5.xy)) + segment_data_5.xy);
    varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_15.zw);
  } else {
    varying_vec4_0.zw = (tmpvar_1 - tmpvar_15.xy);
  };
  flat_varying_vec4_0.xy = tmpvar_61;
  flat_varying_vec4_0.z = tmpvar_62;
  flat_varying_vec4_1.xy = tmpvar_64;
  flat_varying_highp_int_address_0 = tmpvar_21.x;
  flat_varying_vec4_1.z = float((tmpvar_63 != 0));
  flat_varying_vec4_2.xy = (tmpvar_15.zw / tmpvar_60.yz);
  varying_vec4_0.xy = tmpvar_1;
}

