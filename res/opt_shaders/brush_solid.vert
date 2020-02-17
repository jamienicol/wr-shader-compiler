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
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp int tmpvar_3;
  highp int tmpvar_4;
  tmpvar_3 = (aData.y >> 16);
  tmpvar_4 = (aData.z & 65535);
  highp int tmpvar_5;
  tmpvar_5 = ((aData.z >> 16) & 255);
  highp float tmpvar_6;
  highp ivec2 tmpvar_7;
  highp uint tmpvar_8;
  tmpvar_8 = uint(aData.x);
  tmpvar_7.x = int((2u * (uint(mod (tmpvar_8, 512u)))));
  tmpvar_7.y = int((tmpvar_8 / 512u));
  highp vec4 tmpvar_9;
  tmpvar_9 = texelFetch (sPrimitiveHeadersF, tmpvar_7, 0);
  highp vec4 tmpvar_10;
  tmpvar_10 = texelFetch (sPrimitiveHeadersF, (tmpvar_7 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_11 = tmpvar_9.xy;
  tmpvar_12 = tmpvar_9.zw;
  highp ivec2 tmpvar_13;
  tmpvar_13.x = int((2u * (uint(mod (tmpvar_8, 512u)))));
  tmpvar_13.y = int((tmpvar_8 / 512u));
  highp ivec4 tmpvar_14;
  tmpvar_14 = texelFetch (sPrimitiveHeadersI, tmpvar_13, 0);
  highp ivec4 tmpvar_15;
  tmpvar_15 = texelFetch (sPrimitiveHeadersI, (tmpvar_13 + ivec2(1, 0)), 0);
  tmpvar_6 = float(tmpvar_14.x);
  if ((tmpvar_4 == 65535)) {
    tmpvar_1 = tmpvar_11;
    tmpvar_2 = tmpvar_12;
  } else {
    highp int tmpvar_16;
    tmpvar_16 = ((tmpvar_14.y + 1) + (tmpvar_4 * 2));
    highp ivec2 tmpvar_17;
    tmpvar_17.x = int((uint(mod (uint(tmpvar_16), 1024u))));
    tmpvar_17.y = int((uint(tmpvar_16) / 1024u));
    highp vec4 tmpvar_18;
    tmpvar_18 = texelFetch (sGpuCache, tmpvar_17, 0);
    tmpvar_2 = tmpvar_18.zw;
    tmpvar_1 = (tmpvar_18.xy + tmpvar_9.xy);
  };
  highp ivec2 tmpvar_19;
  tmpvar_19.x = int((2u * (uint(mod (
    uint(tmpvar_3)
  , 512u)))));
  tmpvar_19.y = int((uint(tmpvar_3) / 512u));
  highp vec4 tmpvar_20;
  tmpvar_20 = texelFetch (sRenderTasks, tmpvar_19, 0);
  highp vec4 tmpvar_21;
  tmpvar_21 = texelFetch (sRenderTasks, (tmpvar_19 + ivec2(1, 0)), 0);
  highp mat4 tmpvar_22;
  highp int tmpvar_23;
  tmpvar_23 = (tmpvar_14.z & 16777215);
  highp ivec2 tmpvar_24;
  tmpvar_24.x = int((8u * (uint(mod (
    uint(tmpvar_23)
  , 128u)))));
  tmpvar_24.y = int((uint(tmpvar_23) / 128u));
  tmpvar_22[0] = texelFetch (sTransformPalette, tmpvar_24, 0);
  tmpvar_22[1] = texelFetch (sTransformPalette, (tmpvar_24 + ivec2(1, 0)), 0);
  tmpvar_22[2] = texelFetch (sTransformPalette, (tmpvar_24 + ivec2(2, 0)), 0);
  tmpvar_22[3] = texelFetch (sTransformPalette, (tmpvar_24 + ivec2(3, 0)), 0);
  if (((tmpvar_14.z >> 24) == 0)) {
    lowp vec2 tmpvar_25;
    tmpvar_25 = clamp ((tmpvar_1 + (tmpvar_2 * aPosition.xy)), tmpvar_10.xy, (tmpvar_10.xy + tmpvar_10.zw));
    lowp vec4 tmpvar_26;
    tmpvar_26.zw = vec2(0.0, 1.0);
    tmpvar_26.xy = tmpvar_25;
    highp vec4 tmpvar_27;
    tmpvar_27 = (tmpvar_22 * tmpvar_26);
    highp vec4 tmpvar_28;
    tmpvar_28.xy = ((tmpvar_27.xy * tmpvar_21.y) + ((
      -(tmpvar_21.zw)
     + tmpvar_20.xy) * tmpvar_27.w));
    tmpvar_28.z = (tmpvar_6 * tmpvar_27.w);
    tmpvar_28.w = tmpvar_27.w;
    gl_Position = (uTransform * tmpvar_28);
  } else {
    lowp vec4 tmpvar_29;
    tmpvar_29 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_5 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_30;
    lowp vec2 tmpvar_31;
    tmpvar_30 = tmpvar_1;
    tmpvar_31 = tmpvar_2;
    highp vec2 tmpvar_32;
    tmpvar_32 = (tmpvar_10.xy + tmpvar_10.zw);
    lowp vec2 tmpvar_33;
    tmpvar_33 = clamp (tmpvar_30, tmpvar_10.xy, tmpvar_32);
    lowp vec2 tmpvar_34;
    tmpvar_34 = clamp ((tmpvar_30 + tmpvar_31), tmpvar_10.xy, tmpvar_32);
    lowp vec4 tmpvar_35;
    tmpvar_35 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_29);
    tmpvar_30 = (tmpvar_30 - tmpvar_35.xy);
    tmpvar_31 = (tmpvar_31 + (tmpvar_35.xy + tmpvar_35.zw));
    lowp vec4 tmpvar_36;
    tmpvar_36.zw = vec2(0.0, 1.0);
    tmpvar_36.xy = (tmpvar_30 + (tmpvar_31 * aPosition.xy));
    highp vec4 tmpvar_37;
    tmpvar_37 = (tmpvar_22 * tmpvar_36);
    highp vec4 tmpvar_38;
    tmpvar_38.xy = ((tmpvar_37.xy * tmpvar_21.y) + ((tmpvar_20.xy - tmpvar_21.zw) * tmpvar_37.w));
    tmpvar_38.z = (tmpvar_6 * tmpvar_37.w);
    tmpvar_38.w = tmpvar_37.w;
    gl_Position = (uTransform * tmpvar_38);
    highp vec4 tmpvar_39;
    tmpvar_39.xy = clamp (tmpvar_9.xy, tmpvar_10.xy, tmpvar_32);
    tmpvar_39.zw = clamp ((tmpvar_9.xy + tmpvar_9.zw), tmpvar_10.xy, tmpvar_32);
    lowp vec4 tmpvar_40;
    tmpvar_40.xy = tmpvar_33;
    tmpvar_40.zw = tmpvar_34;
    vTransformBounds = mix (tmpvar_39, tmpvar_40, tmpvar_29);
  };
  highp ivec2 tmpvar_41;
  tmpvar_41.x = int((uint(mod (uint(tmpvar_14.y), 1024u))));
  tmpvar_41.y = int((uint(tmpvar_14.y) / 1024u));
  flat_varying_vec4_0 = (texelFetch (sGpuCache, tmpvar_41, 0) * (float(tmpvar_15.x) / 65535.0));
}

