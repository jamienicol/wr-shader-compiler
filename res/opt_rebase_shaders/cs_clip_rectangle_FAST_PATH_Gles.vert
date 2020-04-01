#version 300 es
precision highp sampler2DArray;
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform highp sampler2D sGpuCache;
flat out highp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
in highp ivec2 aTransformIds;
in highp ivec4 aClipDataResourceAddress;
in highp vec2 aClipLocalPos;
in highp vec4 aClipDeviceArea;
in highp vec4 aClipOrigins;
in highp float aDevicePixelScale;
out highp vec4 vLocalPos;
flat out highp vec3 vClipParams;
flat out highp float vClipMode;
void main ()
{
  mat4 transform_m_1;
  mat4 transform_inv_m_2;
  int tmpvar_3;
  tmpvar_3 = (aTransformIds.x & 16777215);
  ivec2 tmpvar_4;
  tmpvar_4.x = int((8u * (
    uint(tmpvar_3)
   % 128u)));
  tmpvar_4.y = int((uint(tmpvar_3) / 128u));
  transform_m_1[0] = texelFetch (sTransformPalette, tmpvar_4, 0);
  transform_m_1[1] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(1, 0)), 0);
  transform_m_1[2] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(2, 0)), 0);
  transform_m_1[3] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(3, 0)), 0);
  transform_inv_m_2[0] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(4, 0)), 0);
  transform_inv_m_2[1] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(5, 0)), 0);
  transform_inv_m_2[2] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(6, 0)), 0);
  transform_inv_m_2[3] = texelFetch (sTransformPalette, (tmpvar_4 + ivec2(7, 0)), 0);
  mat4 transform_m_5;
  int tmpvar_6;
  tmpvar_6 = (aTransformIds.y & 16777215);
  ivec2 tmpvar_7;
  tmpvar_7.x = int((8u * (
    uint(tmpvar_6)
   % 128u)));
  tmpvar_7.y = int((uint(tmpvar_6) / 128u));
  transform_m_5[0] = texelFetch (sTransformPalette, tmpvar_7, 0);
  transform_m_5[1] = texelFetch (sTransformPalette, (tmpvar_7 + ivec2(1, 0)), 0);
  transform_m_5[2] = texelFetch (sTransformPalette, (tmpvar_7 + ivec2(2, 0)), 0);
  transform_m_5[3] = texelFetch (sTransformPalette, (tmpvar_7 + ivec2(3, 0)), 0);
  vec4 tmpvar_8;
  vec4 tmpvar_9;
  tmpvar_8 = texelFetch (sGpuCache, aClipDataResourceAddress.xy, 0);
  tmpvar_9 = texelFetch (sGpuCache, (aClipDataResourceAddress.xy + ivec2(1, 0)), 0);
  vec4 tmpvar_10;
  tmpvar_10 = texelFetch (sGpuCache, (ivec2(3, 0) + aClipDataResourceAddress.xy), 0);
  highp vec4 pos_11;
  vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 1.0);
  tmpvar_12.xy = (((aClipOrigins.zw + aClipDeviceArea.xy) + (aPosition * aClipDeviceArea.zw)) / aDevicePixelScale);
  vec4 tmpvar_13;
  tmpvar_13 = (transform_m_5 * tmpvar_12);
  pos_11.w = tmpvar_13.w;
  pos_11.xyz = (tmpvar_13.xyz / tmpvar_13.w);
  highp vec2 tmpvar_14;
  tmpvar_14 = pos_11.xy;
  vec4 tmpvar_15;
  tmpvar_15 = (transform_m_1 * vec4(0.0, 0.0, 0.0, 1.0));
  vec3 tmpvar_16;
  vec3 tmpvar_17;
  vec3 tmpvar_18;
  tmpvar_16 = transform_inv_m_2[uint(0)].xyz;
  tmpvar_17 = transform_inv_m_2[1u].xyz;
  tmpvar_18 = transform_inv_m_2[2u].xyz;
  mat3 tmpvar_19;
  tmpvar_19[0].x = tmpvar_16.x;
  tmpvar_19[1].x = tmpvar_16.y;
  tmpvar_19[2].x = tmpvar_16.z;
  tmpvar_19[0].y = tmpvar_17.x;
  tmpvar_19[1].y = tmpvar_17.y;
  tmpvar_19[2].y = tmpvar_17.z;
  tmpvar_19[0].z = tmpvar_18.x;
  tmpvar_19[1].z = tmpvar_18.y;
  tmpvar_19[2].z = tmpvar_18.z;
  vec3 tmpvar_20;
  tmpvar_20.z = -10000.0;
  tmpvar_20.xy = tmpvar_14;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_19 * vec3(0.0, 0.0, 1.0));
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_15.xyz / tmpvar_15.w);
  highp float tmpvar_23;
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_21, vec3(0.0, 0.0, 1.0));
  float tmpvar_25;
  tmpvar_25 = abs(tmpvar_24);
  if ((1e-06 < tmpvar_25)) {
    tmpvar_23 = (dot ((tmpvar_22 - tmpvar_20), tmpvar_21) / tmpvar_24);
  };
  vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xy = tmpvar_14;
  tmpvar_26.z = (-10000.0 + tmpvar_23);
  vec4 tmpvar_27;
  tmpvar_27 = ((transform_inv_m_2 * tmpvar_26) * tmpvar_13.w);
  vec4 tmpvar_28;
  tmpvar_28.zw = vec2(0.0, 1.0);
  tmpvar_28.xy = ((aClipOrigins.xy + aClipDeviceArea.xy) + (aPosition * aClipDeviceArea.zw));
  gl_Position = (uTransform * tmpvar_28);
  vec4 tmpvar_29;
  tmpvar_29.xy = aClipLocalPos;
  tmpvar_29.zw = (aClipLocalPos + tmpvar_8.zw);
  vTransformBounds = tmpvar_29;
  vClipMode = tmpvar_9.x;
  vLocalPos.zw = tmpvar_27.zw;
  vec2 tmpvar_30;
  tmpvar_30 = (0.5 * tmpvar_8.zw);
  vLocalPos.xy = (tmpvar_27.xy - ((tmpvar_30 + aClipLocalPos) * tmpvar_27.w));
  vec3 tmpvar_31;
  tmpvar_31.xy = (tmpvar_30 - tmpvar_10.xx);
  tmpvar_31.z = tmpvar_10.x;
  vClipParams = tmpvar_31;
}
