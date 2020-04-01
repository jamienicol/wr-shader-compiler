#version 300 es
precision highp sampler2DArray;
uniform mat4 uTransform;
in vec2 aPosition;
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
  highp int tmpvar_1;
  highp int tmpvar_2;
  tmpvar_1 = (aData.y >> 16);
  tmpvar_2 = (aData.z & 65535);
  highp float tmpvar_3;
  highp ivec2 tmpvar_4;
  highp uint tmpvar_5;
  tmpvar_5 = uint(aData.x);
  tmpvar_4.x = int((2u * (tmpvar_5 % 512u)));
  tmpvar_4.y = int((tmpvar_5 / 512u));
  highp vec4 tmpvar_6;
  tmpvar_6 = texelFetch (sPrimitiveHeadersF, tmpvar_4, 0);
  highp vec4 tmpvar_7;
  tmpvar_7 = texelFetch (sPrimitiveHeadersF, (tmpvar_4 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_8 = tmpvar_6.xy;
  tmpvar_9 = tmpvar_6.zw;
  highp ivec2 tmpvar_10;
  tmpvar_10.x = int((2u * (tmpvar_5 % 512u)));
  tmpvar_10.y = int((tmpvar_5 / 512u));
  highp ivec4 tmpvar_11;
  tmpvar_11 = texelFetch (sPrimitiveHeadersI, tmpvar_10, 0);
  highp ivec4 tmpvar_12;
  tmpvar_12 = texelFetch (sPrimitiveHeadersI, (tmpvar_10 + ivec2(1, 0)), 0);
  tmpvar_3 = float(tmpvar_11.x);
  highp mat4 tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = ((tmpvar_11.z >> 24) == 0);
  highp int tmpvar_15;
  tmpvar_15 = (tmpvar_11.z & 16777215);
  highp ivec2 tmpvar_16;
  tmpvar_16.x = int((8u * (
    uint(tmpvar_15)
   % 128u)));
  tmpvar_16.y = int((uint(tmpvar_15) / 128u));
  tmpvar_13[0] = texelFetch (sTransformPalette, tmpvar_16, 0);
  tmpvar_13[1] = texelFetch (sTransformPalette, (tmpvar_16 + ivec2(1, 0)), 0);
  tmpvar_13[2] = texelFetch (sTransformPalette, (tmpvar_16 + ivec2(2, 0)), 0);
  tmpvar_13[3] = texelFetch (sTransformPalette, (tmpvar_16 + ivec2(3, 0)), 0);
  highp ivec2 tmpvar_17;
  tmpvar_17.x = int((2u * (
    uint(tmpvar_1)
   % 512u)));
  tmpvar_17.y = int((uint(tmpvar_1) / 512u));
  highp vec4 tmpvar_18;
  tmpvar_18 = texelFetch (sRenderTasks, tmpvar_17, 0);
  highp vec4 tmpvar_19;
  tmpvar_19 = texelFetch (sRenderTasks, (tmpvar_17 + ivec2(1, 0)), 0);
  highp vec4 tmpvar_20;
  highp vec2 tmpvar_21;
  highp vec2 tmpvar_22;
  highp int tmpvar_23;
  tmpvar_23 = ((aData.z >> 16) & 255);
  if ((tmpvar_2 == 65535)) {
    tmpvar_21 = tmpvar_8;
    tmpvar_22 = tmpvar_9;
  } else {
    highp int tmpvar_24;
    tmpvar_24 = ((tmpvar_11.y + 3) + (tmpvar_2 * 2));
    highp ivec2 tmpvar_25;
    tmpvar_25.x = int((uint(tmpvar_24) % 1024u));
    tmpvar_25.y = int((uint(tmpvar_24) / 1024u));
    highp vec4 tmpvar_26;
    tmpvar_26 = texelFetch (sGpuCache, tmpvar_25, 0);
    tmpvar_22 = tmpvar_26.zw;
    tmpvar_21 = (tmpvar_26.xy + tmpvar_6.xy);
  };
  if (tmpvar_14) {
    lowp vec2 tmpvar_27;
    tmpvar_27 = clamp ((tmpvar_21 + (tmpvar_22 * aPosition)), tmpvar_7.xy, (tmpvar_7.xy + tmpvar_7.zw));
    lowp vec4 tmpvar_28;
    tmpvar_28.zw = vec2(0.0, 1.0);
    tmpvar_28.xy = tmpvar_27;
    highp vec4 tmpvar_29;
    tmpvar_29 = (tmpvar_13 * tmpvar_28);
    highp vec4 tmpvar_30;
    tmpvar_30.xy = ((tmpvar_29.xy * tmpvar_19.y) + ((
      -(tmpvar_19.zw)
     + tmpvar_18.xy) * tmpvar_29.w));
    tmpvar_30.z = (tmpvar_3 * tmpvar_29.w);
    tmpvar_30.w = tmpvar_29.w;
    gl_Position = (uTransform * tmpvar_30);
    tmpvar_20 = tmpvar_29;
  } else {
    lowp vec4 tmpvar_31;
    tmpvar_31 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_23 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_32;
    lowp vec2 tmpvar_33;
    tmpvar_32 = tmpvar_21;
    tmpvar_33 = tmpvar_22;
    highp vec2 tmpvar_34;
    tmpvar_34 = (tmpvar_7.xy + tmpvar_7.zw);
    lowp vec2 tmpvar_35;
    tmpvar_35 = clamp (tmpvar_32, tmpvar_7.xy, tmpvar_34);
    lowp vec2 tmpvar_36;
    tmpvar_36 = clamp ((tmpvar_32 + tmpvar_33), tmpvar_7.xy, tmpvar_34);
    lowp vec4 tmpvar_37;
    tmpvar_37 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_31);
    tmpvar_32 = (tmpvar_32 - tmpvar_37.xy);
    tmpvar_33 = (tmpvar_33 + (tmpvar_37.xy + tmpvar_37.zw));
    lowp vec4 tmpvar_38;
    tmpvar_38.zw = vec2(0.0, 1.0);
    tmpvar_38.xy = (tmpvar_32 + (tmpvar_33 * aPosition));
    highp vec4 tmpvar_39;
    tmpvar_39 = (tmpvar_13 * tmpvar_38);
    highp vec4 tmpvar_40;
    tmpvar_40.xy = ((tmpvar_39.xy * tmpvar_19.y) + ((tmpvar_18.xy - tmpvar_19.zw) * tmpvar_39.w));
    tmpvar_40.z = (tmpvar_3 * tmpvar_39.w);
    tmpvar_40.w = tmpvar_39.w;
    gl_Position = (uTransform * tmpvar_40);
    highp vec4 tmpvar_41;
    tmpvar_41.xy = clamp (tmpvar_6.xy, tmpvar_7.xy, tmpvar_34);
    tmpvar_41.zw = clamp ((tmpvar_6.xy + tmpvar_6.zw), tmpvar_7.xy, tmpvar_34);
    lowp vec4 tmpvar_42;
    tmpvar_42.xy = tmpvar_35;
    tmpvar_42.zw = tmpvar_36;
    vTransformBounds = mix (tmpvar_41, tmpvar_42, tmpvar_31);
    tmpvar_20 = tmpvar_39;
  };
  lowp vec2 tmpvar_43;
  tmpvar_43 = vec3(textureSize (sPrevPassColor, 0)).xy;
  flat_varying_ivec4_0.x = tmpvar_12.x;
  highp float tmpvar_44;
  highp ivec2 tmpvar_45;
  tmpvar_45.x = int((2u * (
    uint(tmpvar_12.z)
   % 512u)));
  tmpvar_45.y = int((uint(tmpvar_12.z) / 512u));
  highp vec4 tmpvar_46;
  tmpvar_46 = texelFetch (sRenderTasks, (tmpvar_45 + ivec2(1, 0)), 0);
  tmpvar_44 = tmpvar_46.x;
  highp vec2 tmpvar_47;
  tmpvar_47 = (((tmpvar_20.xy * 
    (tmpvar_46.y / max (0.0, tmpvar_20.w))
  ) + texelFetch (sRenderTasks, tmpvar_45, 0).xy) - tmpvar_46.zw);
  varying_vec4_0.xy = (tmpvar_47 / tmpvar_43);
  varying_vec4_0.w = tmpvar_44;
  highp ivec2 tmpvar_48;
  tmpvar_48.x = int((2u * (
    uint(tmpvar_12.y)
   % 512u)));
  tmpvar_48.y = int((uint(tmpvar_12.y) / 512u));
  highp float tmpvar_49;
  tmpvar_49 = texelFetch (sRenderTasks, (tmpvar_48 + ivec2(1, 0)), 0).x;
  highp vec2 tmpvar_50;
  tmpvar_50 = (((
    (tmpvar_20.xy * tmpvar_19.y)
   / 
    max (0.0, tmpvar_20.w)
  ) + texelFetch (sRenderTasks, tmpvar_48, 0).xy) - (tmpvar_46.zw * (tmpvar_19.y / tmpvar_46.y)));
  varying_vec4_1.xy = (tmpvar_50 / tmpvar_43);
  varying_vec4_1.w = tmpvar_49;
}

