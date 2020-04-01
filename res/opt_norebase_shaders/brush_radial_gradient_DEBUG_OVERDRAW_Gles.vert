#version 300 es
precision highp sampler2DArray;
uniform mat4 uTransform;
in vec2 aPosition;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
flat out lowp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
flat out highp vec4 flat_varying_vec4_0;
flat out highp vec4 flat_varying_vec4_1;
out highp vec4 varying_vec4_0;
flat out highp int flat_varying_highp_int_address_0;
void main ()
{
  highp int tmpvar_1;
  highp int tmpvar_2;
  highp int tmpvar_3;
  tmpvar_1 = (aData.y >> 16);
  tmpvar_2 = (aData.z & 65535);
  tmpvar_3 = (aData.z >> 16);
  highp float tmpvar_4;
  highp ivec2 tmpvar_5;
  highp uint tmpvar_6;
  tmpvar_6 = uint(aData.x);
  tmpvar_5.x = int((2u * (tmpvar_6 % 512u)));
  tmpvar_5.y = int((tmpvar_6 / 512u));
  highp vec4 tmpvar_7;
  tmpvar_7 = texelFetch (sPrimitiveHeadersF, tmpvar_5, 0);
  highp vec4 tmpvar_8;
  tmpvar_8 = texelFetch (sPrimitiveHeadersF, (tmpvar_5 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_9 = tmpvar_7.xy;
  tmpvar_10 = tmpvar_7.zw;
  highp ivec2 tmpvar_11;
  tmpvar_11.x = int((2u * (tmpvar_6 % 512u)));
  tmpvar_11.y = int((tmpvar_6 / 512u));
  highp ivec4 tmpvar_12;
  tmpvar_12 = texelFetch (sPrimitiveHeadersI, tmpvar_11, 0);
  highp ivec4 tmpvar_13;
  tmpvar_13 = texelFetch (sPrimitiveHeadersI, (tmpvar_11 + ivec2(1, 0)), 0);
  tmpvar_4 = float(tmpvar_12.x);
  highp mat4 tmpvar_14;
  bool tmpvar_15;
  tmpvar_15 = ((tmpvar_12.z >> 24) == 0);
  highp int tmpvar_16;
  tmpvar_16 = (tmpvar_12.z & 16777215);
  highp ivec2 tmpvar_17;
  tmpvar_17.x = int((8u * (
    uint(tmpvar_16)
   % 128u)));
  tmpvar_17.y = int((uint(tmpvar_16) / 128u));
  tmpvar_14[0] = texelFetch (sTransformPalette, tmpvar_17, 0);
  tmpvar_14[1] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(1, 0)), 0);
  tmpvar_14[2] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(2, 0)), 0);
  tmpvar_14[3] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(3, 0)), 0);
  highp ivec2 tmpvar_18;
  tmpvar_18.x = int((2u * (
    uint(tmpvar_1)
   % 512u)));
  tmpvar_18.y = int((uint(tmpvar_1) / 512u));
  highp vec4 tmpvar_19;
  tmpvar_19 = texelFetch (sRenderTasks, tmpvar_18, 0);
  highp vec4 tmpvar_20;
  tmpvar_20 = texelFetch (sRenderTasks, (tmpvar_18 + ivec2(1, 0)), 0);
  lowp vec2 tmpvar_21;
  highp vec2 tmpvar_22;
  highp vec2 tmpvar_23;
  highp vec4 segment_data_24;
  highp int tmpvar_25;
  tmpvar_25 = (tmpvar_3 & 255);
  highp int tmpvar_26;
  tmpvar_26 = ((tmpvar_3 >> 8) & 255);
  if ((tmpvar_2 == 65535)) {
    tmpvar_22 = tmpvar_9;
    tmpvar_23 = tmpvar_10;
    segment_data_24 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp int tmpvar_27;
    tmpvar_27 = ((tmpvar_12.y + 2) + (tmpvar_2 * 2));
    highp ivec2 tmpvar_28;
    tmpvar_28.x = int((uint(tmpvar_27) % 1024u));
    tmpvar_28.y = int((uint(tmpvar_27) / 1024u));
    highp vec4 tmpvar_29;
    tmpvar_29 = texelFetch (sGpuCache, tmpvar_28, 0);
    tmpvar_23 = tmpvar_29.zw;
    tmpvar_22 = (tmpvar_29.xy + tmpvar_7.xy);
    segment_data_24 = texelFetch (sGpuCache, (tmpvar_28 + ivec2(1, 0)), 0);
  };
  if (tmpvar_15) {
    lowp vec2 tmpvar_30;
    tmpvar_30 = clamp ((tmpvar_22 + (tmpvar_23 * aPosition)), tmpvar_8.xy, (tmpvar_8.xy + tmpvar_8.zw));
    lowp vec4 tmpvar_31;
    tmpvar_31.zw = vec2(0.0, 1.0);
    tmpvar_31.xy = tmpvar_30;
    highp vec4 tmpvar_32;
    tmpvar_32 = (tmpvar_14 * tmpvar_31);
    highp vec4 tmpvar_33;
    tmpvar_33.xy = ((tmpvar_32.xy * tmpvar_20.y) + ((
      -(tmpvar_20.zw)
     + tmpvar_19.xy) * tmpvar_32.w));
    tmpvar_33.z = (tmpvar_4 * tmpvar_32.w);
    tmpvar_33.w = tmpvar_32.w;
    gl_Position = (uTransform * tmpvar_33);
    tmpvar_21 = tmpvar_30;
  } else {
    lowp vec4 tmpvar_34;
    tmpvar_34 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_25 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_35;
    lowp vec2 tmpvar_36;
    tmpvar_35 = tmpvar_22;
    tmpvar_36 = tmpvar_23;
    highp vec2 tmpvar_37;
    tmpvar_37 = (tmpvar_8.xy + tmpvar_8.zw);
    lowp vec2 tmpvar_38;
    tmpvar_38 = clamp (tmpvar_35, tmpvar_8.xy, tmpvar_37);
    lowp vec2 tmpvar_39;
    tmpvar_39 = clamp ((tmpvar_35 + tmpvar_36), tmpvar_8.xy, tmpvar_37);
    lowp vec4 tmpvar_40;
    tmpvar_40 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_34);
    tmpvar_35 = (tmpvar_35 - tmpvar_40.xy);
    tmpvar_36 = (tmpvar_36 + (tmpvar_40.xy + tmpvar_40.zw));
    lowp vec2 tmpvar_41;
    tmpvar_41 = (tmpvar_35 + (tmpvar_36 * aPosition));
    lowp vec4 tmpvar_42;
    tmpvar_42.zw = vec2(0.0, 1.0);
    tmpvar_42.xy = tmpvar_41;
    highp vec4 tmpvar_43;
    tmpvar_43 = (tmpvar_14 * tmpvar_42);
    highp vec4 tmpvar_44;
    tmpvar_44.xy = ((tmpvar_43.xy * tmpvar_20.y) + ((tmpvar_19.xy - tmpvar_20.zw) * tmpvar_43.w));
    tmpvar_44.z = (tmpvar_4 * tmpvar_43.w);
    tmpvar_44.w = tmpvar_43.w;
    gl_Position = (uTransform * tmpvar_44);
    highp vec4 tmpvar_45;
    tmpvar_45.xy = clamp (tmpvar_7.xy, tmpvar_8.xy, tmpvar_37);
    tmpvar_45.zw = clamp ((tmpvar_7.xy + tmpvar_7.zw), tmpvar_8.xy, tmpvar_37);
    lowp vec4 tmpvar_46;
    tmpvar_46.xy = tmpvar_38;
    tmpvar_46.zw = tmpvar_39;
    vTransformBounds = mix (tmpvar_45, tmpvar_46, tmpvar_34);
    tmpvar_21 = tmpvar_41;
  };
  highp ivec2 tmpvar_47;
  tmpvar_47.x = int((uint(tmpvar_12.y) % 1024u));
  tmpvar_47.y = int((uint(tmpvar_12.y) / 1024u));
  highp vec4 tmpvar_48;
  highp vec4 tmpvar_49;
  tmpvar_48 = texelFetch (sGpuCache, tmpvar_47, 0);
  tmpvar_49 = texelFetch (sGpuCache, (tmpvar_47 + ivec2(1, 0)), 0);
  highp int tmpvar_50;
  highp vec2 tmpvar_51;
  tmpvar_50 = int(tmpvar_49.y);
  tmpvar_51 = tmpvar_49.zw;
  if (((tmpvar_26 & 2) != 0)) {
    varying_vec4_0.zw = ((tmpvar_21 - tmpvar_22) / tmpvar_23);
    varying_vec4_0.zw = ((varying_vec4_0.zw * (segment_data_24.zw - segment_data_24.xy)) + segment_data_24.xy);
    varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_7.zw);
  } else {
    varying_vec4_0.zw = (tmpvar_21 - tmpvar_7.xy);
  };
  flat_varying_vec4_0.x = tmpvar_48.x;
  flat_varying_vec4_0.zw = tmpvar_48.zw;
  varying_vec4_0.w = (varying_vec4_0.w * tmpvar_49.x);
  flat_varying_vec4_0.y = (tmpvar_48.y * tmpvar_49.x);
  flat_varying_vec4_1.x = tmpvar_51.x;
  flat_varying_vec4_1.y = (tmpvar_49.w * tmpvar_49.x);
  flat_varying_highp_int_address_0 = tmpvar_13.x;
  flat_varying_vec4_1.z = float((tmpvar_50 != 0));
}

