#version 300 es
precision highp sampler2DArray;
uniform mat4 uTransform;
in vec3 aPosition;
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
  lowp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec4 segment_data_4;
  highp int tmpvar_5;
  highp int tmpvar_6;
  highp int tmpvar_7;
  tmpvar_5 = (aData.y >> 16);
  tmpvar_6 = (aData.z & 65535);
  tmpvar_7 = (aData.z >> 16);
  highp int tmpvar_8;
  tmpvar_8 = (tmpvar_7 & 255);
  highp int tmpvar_9;
  tmpvar_9 = ((tmpvar_7 >> 8) & 255);
  highp float tmpvar_10;
  highp ivec2 tmpvar_11;
  highp uint tmpvar_12;
  tmpvar_12 = uint(aData.x);
  tmpvar_11.x = int((2u * (uint(tmpvar_12 % 512u))));
  tmpvar_11.y = int((tmpvar_12 / 512u));
  highp vec4 tmpvar_13;
  tmpvar_13 = texelFetch (sPrimitiveHeadersF, tmpvar_11, 0);
  highp vec4 tmpvar_14;
  tmpvar_14 = texelFetch (sPrimitiveHeadersF, (tmpvar_11 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_15 = tmpvar_13.xy;
  tmpvar_16 = tmpvar_13.zw;
  highp ivec2 tmpvar_17;
  tmpvar_17.x = int((2u * (uint(tmpvar_12 % 512u))));
  tmpvar_17.y = int((tmpvar_12 / 512u));
  highp ivec4 tmpvar_18;
  tmpvar_18 = texelFetch (sPrimitiveHeadersI, tmpvar_17, 0);
  highp ivec4 tmpvar_19;
  tmpvar_19 = texelFetch (sPrimitiveHeadersI, (tmpvar_17 + ivec2(1, 0)), 0);
  tmpvar_10 = float(tmpvar_18.x);
  if ((tmpvar_6 == 65535)) {
    tmpvar_2 = tmpvar_15;
    tmpvar_3 = tmpvar_16;
    segment_data_4 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp int tmpvar_20;
    tmpvar_20 = ((tmpvar_18.y + 2) + (tmpvar_6 * 2));
    highp ivec2 tmpvar_21;
    tmpvar_21.x = int((uint(uint(tmpvar_20) % 1024u)));
    tmpvar_21.y = int((uint(tmpvar_20) / 1024u));
    highp vec4 tmpvar_22;
    tmpvar_22 = texelFetch (sGpuCache, tmpvar_21, 0);
    tmpvar_3 = tmpvar_22.zw;
    tmpvar_2 = (tmpvar_22.xy + tmpvar_13.xy);
    segment_data_4 = texelFetch (sGpuCache, (tmpvar_21 + ivec2(1, 0)), 0);
  };
  highp ivec2 tmpvar_23;
  tmpvar_23.x = int((2u * (uint(
    uint(tmpvar_5)
   % 512u))));
  tmpvar_23.y = int((uint(tmpvar_5) / 512u));
  highp vec4 tmpvar_24;
  tmpvar_24 = texelFetch (sRenderTasks, tmpvar_23, 0);
  highp vec4 tmpvar_25;
  tmpvar_25 = texelFetch (sRenderTasks, (tmpvar_23 + ivec2(1, 0)), 0);
  highp mat4 tmpvar_26;
  highp int tmpvar_27;
  tmpvar_27 = (tmpvar_18.z & 16777215);
  highp ivec2 tmpvar_28;
  tmpvar_28.x = int((8u * (uint(
    uint(tmpvar_27)
   % 128u))));
  tmpvar_28.y = int((uint(tmpvar_27) / 128u));
  tmpvar_26[0] = texelFetch (sTransformPalette, tmpvar_28, 0);
  tmpvar_26[1] = texelFetch (sTransformPalette, (tmpvar_28 + ivec2(1, 0)), 0);
  tmpvar_26[2] = texelFetch (sTransformPalette, (tmpvar_28 + ivec2(2, 0)), 0);
  tmpvar_26[3] = texelFetch (sTransformPalette, (tmpvar_28 + ivec2(3, 0)), 0);
  if (((tmpvar_18.z >> 24) == 0)) {
    lowp vec2 tmpvar_29;
    tmpvar_29 = clamp ((tmpvar_2 + (tmpvar_3 * aPosition.xy)), tmpvar_14.xy, (tmpvar_14.xy + tmpvar_14.zw));
    lowp vec4 tmpvar_30;
    tmpvar_30.zw = vec2(0.0, 1.0);
    tmpvar_30.xy = tmpvar_29;
    highp vec4 tmpvar_31;
    tmpvar_31 = (tmpvar_26 * tmpvar_30);
    highp vec4 tmpvar_32;
    tmpvar_32.xy = ((tmpvar_31.xy * tmpvar_25.y) + ((
      -(tmpvar_25.zw)
     + tmpvar_24.xy) * tmpvar_31.w));
    tmpvar_32.z = (tmpvar_10 * tmpvar_31.w);
    tmpvar_32.w = tmpvar_31.w;
    gl_Position = (uTransform * tmpvar_32);
    tmpvar_1 = tmpvar_29;
  } else {
    lowp vec4 tmpvar_33;
    tmpvar_33 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_8 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_34;
    lowp vec2 tmpvar_35;
    tmpvar_34 = tmpvar_2;
    tmpvar_35 = tmpvar_3;
    highp vec2 tmpvar_36;
    tmpvar_36 = (tmpvar_14.xy + tmpvar_14.zw);
    lowp vec2 tmpvar_37;
    tmpvar_37 = clamp (tmpvar_34, tmpvar_14.xy, tmpvar_36);
    lowp vec2 tmpvar_38;
    tmpvar_38 = clamp ((tmpvar_34 + tmpvar_35), tmpvar_14.xy, tmpvar_36);
    lowp vec4 tmpvar_39;
    tmpvar_39 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_33);
    tmpvar_34 = (tmpvar_34 - tmpvar_39.xy);
    tmpvar_35 = (tmpvar_35 + (tmpvar_39.xy + tmpvar_39.zw));
    lowp vec2 tmpvar_40;
    tmpvar_40 = (tmpvar_34 + (tmpvar_35 * aPosition.xy));
    lowp vec4 tmpvar_41;
    tmpvar_41.zw = vec2(0.0, 1.0);
    tmpvar_41.xy = tmpvar_40;
    highp vec4 tmpvar_42;
    tmpvar_42 = (tmpvar_26 * tmpvar_41);
    highp vec4 tmpvar_43;
    tmpvar_43.xy = ((tmpvar_42.xy * tmpvar_25.y) + ((tmpvar_24.xy - tmpvar_25.zw) * tmpvar_42.w));
    tmpvar_43.z = (tmpvar_10 * tmpvar_42.w);
    tmpvar_43.w = tmpvar_42.w;
    gl_Position = (uTransform * tmpvar_43);
    highp vec4 tmpvar_44;
    tmpvar_44.xy = clamp (tmpvar_13.xy, tmpvar_14.xy, tmpvar_36);
    tmpvar_44.zw = clamp ((tmpvar_13.xy + tmpvar_13.zw), tmpvar_14.xy, tmpvar_36);
    lowp vec4 tmpvar_45;
    tmpvar_45.xy = tmpvar_37;
    tmpvar_45.zw = tmpvar_38;
    vTransformBounds = mix (tmpvar_44, tmpvar_45, tmpvar_33);
    tmpvar_1 = tmpvar_40;
  };
  highp ivec2 tmpvar_46;
  tmpvar_46.x = int((uint(uint(tmpvar_18.y) % 1024u)));
  tmpvar_46.y = int((uint(tmpvar_18.y) / 1024u));
  highp vec4 tmpvar_47;
  highp vec4 tmpvar_48;
  tmpvar_47 = texelFetch (sGpuCache, tmpvar_46, 0);
  tmpvar_48 = texelFetch (sGpuCache, (tmpvar_46 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_49;
  highp float tmpvar_50;
  highp int tmpvar_51;
  highp vec2 tmpvar_52;
  tmpvar_49 = tmpvar_47.xy;
  tmpvar_50 = tmpvar_47.z;
  tmpvar_51 = int(tmpvar_48.x);
  tmpvar_52 = tmpvar_48.yz;
  if (((tmpvar_9 & 2) != 0)) {
    varying_vec4_0.zw = ((tmpvar_1 - tmpvar_2) / tmpvar_3);
    varying_vec4_0.zw = ((varying_vec4_0.zw * (segment_data_4.zw - segment_data_4.xy)) + segment_data_4.xy);
    varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_13.zw);
  } else {
    varying_vec4_0.zw = (tmpvar_1 - tmpvar_13.xy);
  };
  flat_varying_vec4_0.xy = tmpvar_49;
  flat_varying_vec4_0.z = tmpvar_50;
  flat_varying_vec4_1.xy = tmpvar_52;
  flat_varying_highp_int_address_0 = tmpvar_19.x;
  flat_varying_vec4_1.z = float((tmpvar_51 != 0));
}

