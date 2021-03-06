#version 300 es
precision highp sampler2DArray;
uniform mat4 uTransform;
in vec2 aPosition;
uniform highp sampler2D sGpuCache;
flat out highp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
in highp ivec2 aTransformIds;
in highp ivec4 aClipDataResourceAddress;
in vec2 aClipLocalPos;
in vec4 aClipDeviceArea;
in vec4 aClipOrigins;
in float aDevicePixelScale;
out highp vec4 vLocalPos;
flat out highp vec4 vClipCenter_Radius_TL;
flat out highp vec4 vClipCenter_Radius_TR;
flat out highp vec4 vClipCenter_Radius_BL;
flat out highp vec4 vClipCenter_Radius_BR;
flat out highp float vClipMode;
void main ()
{
  highp mat4 tmpvar_1;
  highp mat4 tmpvar_2;
  highp int tmpvar_3;
  tmpvar_3 = (aTransformIds.x & 16777215);
  highp ivec2 tmpvar_4;
  tmpvar_4.x = int((8u * (
    uint(tmpvar_3)
   % 128u)));
  tmpvar_4.y = int((uint(tmpvar_3) / 128u));
  tmpvar_1[0] = texelFetch (sTransformPalette, tmpvar_4, 0);
  tmpvar_1[1] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(1, 0)), 0);
  tmpvar_1[2] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(2, 0)), 0);
  tmpvar_1[3] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(3, 0)), 0);
  tmpvar_2[0] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(4, 0)), 0);
  tmpvar_2[1] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(5, 0)), 0);
  tmpvar_2[2] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(6, 0)), 0);
  tmpvar_2[3] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(7, 0)), 0);
  highp mat4 tmpvar_5;
  highp int tmpvar_6;
  tmpvar_6 = (aTransformIds.y & 16777215);
  highp ivec2 tmpvar_7;
  tmpvar_7.x = int((8u * (
    uint(tmpvar_6)
   % 128u)));
  tmpvar_7.y = int((uint(tmpvar_6) / 128u));
  tmpvar_5[0] = texelFetch (sTransformPalette, tmpvar_7, 0);
  tmpvar_5[1] = texelFetch (sTransformPalette, (tmpvar_7 + ivec2(1, 0)), 0);
  tmpvar_5[2] = texelFetch (sTransformPalette, (tmpvar_7 + ivec2(2, 0)), 0);
  tmpvar_5[3] = texelFetch (sTransformPalette, (tmpvar_7 + ivec2(3, 0)), 0);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_8 = texelFetch (sGpuCache, aClipDataResourceAddress.xy, 0);
  tmpvar_9 = texelFetch (sGpuCache, (aClipDataResourceAddress.xy + ivec2(1, 0)), 0);
  highp vec4 tmpvar_10;
  tmpvar_10 = texelFetch (sGpuCache, (ivec2(3, 0) + aClipDataResourceAddress.xy), 0);
  highp vec4 tmpvar_11;
  tmpvar_11 = texelFetch (sGpuCache, (ivec2(5, 0) + aClipDataResourceAddress.xy), 0);
  highp vec4 tmpvar_12;
  tmpvar_12 = texelFetch (sGpuCache, (ivec2(7, 0) + aClipDataResourceAddress.xy), 0);
  highp vec4 tmpvar_13;
  tmpvar_13 = texelFetch (sGpuCache, (ivec2(9, 0) + aClipDataResourceAddress.xy), 0);
  highp vec4 pos_14;
  vec4 tmpvar_15;
  tmpvar_15.zw = vec2(0.0, 1.0);
  tmpvar_15.xy = (((aClipOrigins.zw + aClipDeviceArea.xy) + (aPosition * aClipDeviceArea.zw)) / aDevicePixelScale);
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_5 * tmpvar_15);
  pos_14.w = tmpvar_16.w;
  pos_14.xyz = (tmpvar_16.xyz / tmpvar_16.w);
  highp vec2 pos_17;
  pos_17 = pos_14.xy;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_1 * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec3 tmpvar_19;
  highp vec3 tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_19 = tmpvar_2[uint(0)].xyz;
  tmpvar_20 = tmpvar_2[1u].xyz;
  tmpvar_21 = tmpvar_2[2u].xyz;
  highp mat3 tmpvar_22;
  tmpvar_22[0].x = tmpvar_19.x;
  tmpvar_22[1].x = tmpvar_19.y;
  tmpvar_22[2].x = tmpvar_19.z;
  tmpvar_22[0].y = tmpvar_20.x;
  tmpvar_22[1].y = tmpvar_20.y;
  tmpvar_22[2].y = tmpvar_20.z;
  tmpvar_22[0].z = tmpvar_21.x;
  tmpvar_22[1].z = tmpvar_21.y;
  tmpvar_22[2].z = tmpvar_21.z;
  highp vec3 tmpvar_23;
  tmpvar_23.z = -10000.0;
  tmpvar_23.xy = pos_17;
  highp vec3 normal_24;
  normal_24 = (tmpvar_22 * vec3(0.0, 0.0, 1.0));
  highp vec3 pt_25;
  pt_25 = (tmpvar_18.xyz / tmpvar_18.w);
  highp float t_26;
  highp float tmpvar_27;
  tmpvar_27 = abs(normal_24.z);
  if ((tmpvar_27 > 1e-06)) {
    t_26 = (dot ((pt_25 - tmpvar_23), normal_24) / normal_24.z);
  };
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xy = pos_17;
  tmpvar_28.z = (-10000.0 + t_26);
  vec4 tmpvar_29;
  tmpvar_29.zw = vec2(0.0, 1.0);
  tmpvar_29.xy = ((aClipOrigins.xy + aClipDeviceArea.xy) + (aPosition * aClipDeviceArea.zw));
  gl_Position = (uTransform * tmpvar_29);
  highp vec4 tmpvar_30;
  tmpvar_30.xy = aClipLocalPos;
  tmpvar_30.zw = (aClipLocalPos + tmpvar_8.zw);
  vTransformBounds = tmpvar_30;
  vClipMode = tmpvar_9.x;
  vLocalPos = ((tmpvar_2 * tmpvar_28) * tmpvar_16.w);
  highp vec2 tmpvar_31;
  tmpvar_31 = (aClipLocalPos + tmpvar_8.zw);
  highp vec4 tmpvar_32;
  tmpvar_32.xy = (aClipLocalPos + tmpvar_10.xy);
  tmpvar_32.zw = tmpvar_10.xy;
  vClipCenter_Radius_TL = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.x = (tmpvar_31.x - tmpvar_11.x);
  tmpvar_33.y = (aClipLocalPos.y + tmpvar_11.y);
  tmpvar_33.zw = tmpvar_11.xy;
  vClipCenter_Radius_TR = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.xy = (tmpvar_31 - tmpvar_13.xy);
  tmpvar_34.zw = tmpvar_13.xy;
  vClipCenter_Radius_BR = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35.x = (aClipLocalPos.x + tmpvar_12.x);
  tmpvar_35.y = (tmpvar_31.y - tmpvar_12.y);
  tmpvar_35.zw = tmpvar_12.xy;
  vClipCenter_Radius_BL = tmpvar_35;
}

