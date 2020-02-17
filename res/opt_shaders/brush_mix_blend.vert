#version 300 es
precision highp sampler2DArray;
uniform mat4 uTransform;
in vec3 aPosition;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
flat out lowp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
uniform sampler2DArray sPrevPassColor;
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
  tmpvar_4 = (aData.y >> 16);
  tmpvar_5 = (aData.z & 65535);
  highp int tmpvar_6;
  tmpvar_6 = ((aData.z >> 16) & 255);
  highp float tmpvar_7;
  highp ivec2 tmpvar_8;
  highp uint tmpvar_9;
  tmpvar_9 = uint(aData.x);
  tmpvar_8.x = int((2u * (uint(tmpvar_9 % 512u))));
  tmpvar_8.y = int((tmpvar_9 / 512u));
  highp vec4 tmpvar_10;
  tmpvar_10 = texelFetch (sPrimitiveHeadersF, tmpvar_8, 0);
  highp vec4 tmpvar_11;
  tmpvar_11 = texelFetch (sPrimitiveHeadersF, (tmpvar_8 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_12 = tmpvar_10.xy;
  tmpvar_13 = tmpvar_10.zw;
  highp ivec2 tmpvar_14;
  tmpvar_14.x = int((2u * (uint(tmpvar_9 % 512u))));
  tmpvar_14.y = int((tmpvar_9 / 512u));
  highp ivec4 tmpvar_15;
  tmpvar_15 = texelFetch (sPrimitiveHeadersI, tmpvar_14, 0);
  highp ivec4 tmpvar_16;
  tmpvar_16 = texelFetch (sPrimitiveHeadersI, (tmpvar_14 + ivec2(1, 0)), 0);
  tmpvar_7 = float(tmpvar_15.x);
  if ((tmpvar_5 == 65535)) {
    tmpvar_2 = tmpvar_12;
    tmpvar_3 = tmpvar_13;
  } else {
    highp int tmpvar_17;
    tmpvar_17 = ((tmpvar_15.y + 3) + (tmpvar_5 * 2));
    highp ivec2 tmpvar_18;
    tmpvar_18.x = int((uint(uint(tmpvar_17) % 1024u)));
    tmpvar_18.y = int((uint(tmpvar_17) / 1024u));
    highp vec4 tmpvar_19;
    tmpvar_19 = texelFetch (sGpuCache, tmpvar_18, 0);
    tmpvar_3 = tmpvar_19.zw;
    tmpvar_2 = (tmpvar_19.xy + tmpvar_10.xy);
  };
  highp ivec2 tmpvar_20;
  tmpvar_20.x = int((2u * (uint(
    uint(tmpvar_4)
   % 512u))));
  tmpvar_20.y = int((uint(tmpvar_4) / 512u));
  highp vec4 tmpvar_21;
  tmpvar_21 = texelFetch (sRenderTasks, tmpvar_20, 0);
  highp vec4 tmpvar_22;
  tmpvar_22 = texelFetch (sRenderTasks, (tmpvar_20 + ivec2(1, 0)), 0);
  highp mat4 tmpvar_23;
  highp int tmpvar_24;
  tmpvar_24 = (tmpvar_15.z & 16777215);
  highp ivec2 tmpvar_25;
  tmpvar_25.x = int((8u * (uint(
    uint(tmpvar_24)
   % 128u))));
  tmpvar_25.y = int((uint(tmpvar_24) / 128u));
  tmpvar_23[0] = texelFetch (sTransformPalette, tmpvar_25, 0);
  tmpvar_23[1] = texelFetch (sTransformPalette, (tmpvar_25 + ivec2(1, 0)), 0);
  tmpvar_23[2] = texelFetch (sTransformPalette, (tmpvar_25 + ivec2(2, 0)), 0);
  tmpvar_23[3] = texelFetch (sTransformPalette, (tmpvar_25 + ivec2(3, 0)), 0);
  if (((tmpvar_15.z >> 24) == 0)) {
    lowp vec2 tmpvar_26;
    tmpvar_26 = clamp ((tmpvar_2 + (tmpvar_3 * aPosition.xy)), tmpvar_11.xy, (tmpvar_11.xy + tmpvar_11.zw));
    lowp vec4 tmpvar_27;
    tmpvar_27.zw = vec2(0.0, 1.0);
    tmpvar_27.xy = tmpvar_26;
    highp vec4 tmpvar_28;
    tmpvar_28 = (tmpvar_23 * tmpvar_27);
    highp vec4 tmpvar_29;
    tmpvar_29.xy = ((tmpvar_28.xy * tmpvar_22.y) + ((
      -(tmpvar_22.zw)
     + tmpvar_21.xy) * tmpvar_28.w));
    tmpvar_29.z = (tmpvar_7 * tmpvar_28.w);
    tmpvar_29.w = tmpvar_28.w;
    gl_Position = (uTransform * tmpvar_29);
    tmpvar_1 = tmpvar_28;
  } else {
    lowp vec4 tmpvar_30;
    tmpvar_30 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_6 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_31;
    lowp vec2 tmpvar_32;
    tmpvar_31 = tmpvar_2;
    tmpvar_32 = tmpvar_3;
    highp vec2 tmpvar_33;
    tmpvar_33 = (tmpvar_11.xy + tmpvar_11.zw);
    lowp vec2 tmpvar_34;
    tmpvar_34 = clamp (tmpvar_31, tmpvar_11.xy, tmpvar_33);
    lowp vec2 tmpvar_35;
    tmpvar_35 = clamp ((tmpvar_31 + tmpvar_32), tmpvar_11.xy, tmpvar_33);
    lowp vec4 tmpvar_36;
    tmpvar_36 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_30);
    tmpvar_31 = (tmpvar_31 - tmpvar_36.xy);
    tmpvar_32 = (tmpvar_32 + (tmpvar_36.xy + tmpvar_36.zw));
    lowp vec4 tmpvar_37;
    tmpvar_37.zw = vec2(0.0, 1.0);
    tmpvar_37.xy = (tmpvar_31 + (tmpvar_32 * aPosition.xy));
    highp vec4 tmpvar_38;
    tmpvar_38 = (tmpvar_23 * tmpvar_37);
    highp vec4 tmpvar_39;
    tmpvar_39.xy = ((tmpvar_38.xy * tmpvar_22.y) + ((tmpvar_21.xy - tmpvar_22.zw) * tmpvar_38.w));
    tmpvar_39.z = (tmpvar_7 * tmpvar_38.w);
    tmpvar_39.w = tmpvar_38.w;
    gl_Position = (uTransform * tmpvar_39);
    highp vec4 tmpvar_40;
    tmpvar_40.xy = clamp (tmpvar_10.xy, tmpvar_11.xy, tmpvar_33);
    tmpvar_40.zw = clamp ((tmpvar_10.xy + tmpvar_10.zw), tmpvar_11.xy, tmpvar_33);
    lowp vec4 tmpvar_41;
    tmpvar_41.xy = tmpvar_34;
    tmpvar_41.zw = tmpvar_35;
    vTransformBounds = mix (tmpvar_40, tmpvar_41, tmpvar_30);
    tmpvar_1 = tmpvar_38;
  };
  highp vec2 tmpvar_42;
  tmpvar_42 = ((tmpvar_1.xy * tmpvar_22.y) / max (0.0, tmpvar_1.w));
  lowp vec2 tmpvar_43;
  tmpvar_43 = vec3(textureSize (sPrevPassColor, 0)).xy;
  flat_varying_ivec4_0.x = tmpvar_16.x;
  highp float tmpvar_44;
  highp ivec2 tmpvar_45;
  tmpvar_45.x = int((2u * (uint(
    uint(tmpvar_16.z)
   % 512u))));
  tmpvar_45.y = int((uint(tmpvar_16.z) / 512u));
  highp vec4 tmpvar_46;
  tmpvar_46 = texelFetch (sRenderTasks, (tmpvar_45 + ivec2(1, 0)), 0);
  tmpvar_44 = tmpvar_46.x;
  highp vec2 tmpvar_47;
  tmpvar_47 = ((tmpvar_42 + texelFetch (sRenderTasks, tmpvar_45, 0).xy) - tmpvar_46.zw);
  varying_vec4_0.xy = (tmpvar_47 / tmpvar_43);
  varying_vec4_0.w = tmpvar_44;
  highp ivec2 tmpvar_48;
  tmpvar_48.x = int((2u * (uint(
    uint(tmpvar_16.y)
   % 512u))));
  tmpvar_48.y = int((uint(tmpvar_16.y) / 512u));
  highp float tmpvar_49;
  tmpvar_49 = texelFetch (sRenderTasks, (tmpvar_48 + ivec2(1, 0)), 0).x;
  highp vec2 tmpvar_50;
  tmpvar_50 = ((tmpvar_42 + texelFetch (sRenderTasks, tmpvar_48, 0).xy) - tmpvar_46.zw);
  varying_vec4_1.xy = (tmpvar_50 / tmpvar_43);
  varying_vec4_1.w = tmpvar_49;
}

