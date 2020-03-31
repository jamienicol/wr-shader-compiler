#version 150
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
in ivec2 aTransformIds;
in ivec4 aClipDataResourceAddress;
in vec2 aClipLocalPos;
in vec4 aClipDeviceArea;
in vec4 aClipOrigins;
in float aDevicePixelScale;
out vec4 vLocalPos;
flat out vec4 vClipCenter_Radius_TL;
flat out vec4 vClipCenter_Radius_TR;
flat out vec4 vClipCenter_Radius_BL;
flat out vec4 vClipCenter_Radius_BR;
flat out float vClipMode;
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
  transform_m_1[0] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(0, 0));
  transform_m_1[1] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(1, 0));
  transform_m_1[2] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(2, 0));
  transform_m_1[3] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(3, 0));
  transform_inv_m_2[0] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(4, 0));
  transform_inv_m_2[1] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(5, 0));
  transform_inv_m_2[2] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(6, 0));
  transform_inv_m_2[3] = texelFetchOffset (sTransformPalette, tmpvar_4, 0, ivec2(7, 0));
  mat4 transform_m_5;
  int tmpvar_6;
  tmpvar_6 = (aTransformIds.y & 16777215);
  ivec2 tmpvar_7;
  tmpvar_7.x = int((8u * (
    uint(tmpvar_6)
   % 128u)));
  tmpvar_7.y = int((uint(tmpvar_6) / 128u));
  transform_m_5[0] = texelFetchOffset (sTransformPalette, tmpvar_7, 0, ivec2(0, 0));
  transform_m_5[1] = texelFetchOffset (sTransformPalette, tmpvar_7, 0, ivec2(1, 0));
  transform_m_5[2] = texelFetchOffset (sTransformPalette, tmpvar_7, 0, ivec2(2, 0));
  transform_m_5[3] = texelFetchOffset (sTransformPalette, tmpvar_7, 0, ivec2(3, 0));
  vec4 tmpvar_8;
  vec4 tmpvar_9;
  tmpvar_8 = texelFetchOffset (sGpuCache, aClipDataResourceAddress.xy, 0, ivec2(0, 0));
  tmpvar_9 = texelFetchOffset (sGpuCache, aClipDataResourceAddress.xy, 0, ivec2(1, 0));
  vec4 tmpvar_10;
  tmpvar_10 = texelFetchOffset (sGpuCache, (aClipDataResourceAddress.xy + ivec2(2, 0)), 0, ivec2(1, 0));
  vec4 tmpvar_11;
  tmpvar_11 = texelFetchOffset (sGpuCache, (aClipDataResourceAddress.xy + ivec2(4, 0)), 0, ivec2(1, 0));
  vec4 tmpvar_12;
  tmpvar_12 = texelFetchOffset (sGpuCache, (aClipDataResourceAddress.xy + ivec2(6, 0)), 0, ivec2(1, 0));
  vec4 tmpvar_13;
  tmpvar_13 = texelFetchOffset (sGpuCache, (aClipDataResourceAddress.xy + ivec2(8, 0)), 0, ivec2(1, 0));
  vec4 pos_14;
  vec4 tmpvar_15;
  tmpvar_15.zw = vec2(0.0, 1.0);
  tmpvar_15.xy = (((aClipOrigins.zw + aClipDeviceArea.xy) + (aPosition * aClipDeviceArea.zw)) / aDevicePixelScale);
  vec4 tmpvar_16;
  tmpvar_16 = (transform_m_5 * tmpvar_15);
  pos_14.w = tmpvar_16.w;
  pos_14.xyz = (tmpvar_16.xyz / tmpvar_16.w);
  vec2 tmpvar_17;
  tmpvar_17 = pos_14.xy;
  vec4 tmpvar_18;
  tmpvar_18 = (transform_m_1 * vec4(0.0, 0.0, 0.0, 1.0));
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  vec3 tmpvar_21;
  tmpvar_19 = transform_inv_m_2[uint(0)].xyz;
  tmpvar_20 = transform_inv_m_2[1u].xyz;
  tmpvar_21 = transform_inv_m_2[2u].xyz;
  mat3 tmpvar_22;
  tmpvar_22[0].x = tmpvar_19.x;
  tmpvar_22[1].x = tmpvar_19.y;
  tmpvar_22[2].x = tmpvar_19.z;
  tmpvar_22[0].y = tmpvar_20.x;
  tmpvar_22[1].y = tmpvar_20.y;
  tmpvar_22[2].y = tmpvar_20.z;
  tmpvar_22[0].z = tmpvar_21.x;
  tmpvar_22[1].z = tmpvar_21.y;
  tmpvar_22[2].z = tmpvar_21.z;
  vec3 tmpvar_23;
  tmpvar_23.z = -10000.0;
  tmpvar_23.xy = tmpvar_17;
  vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_22 * vec3(0.0, 0.0, 1.0));
  vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_18.xyz / tmpvar_18.w);
  float tmpvar_26;
  float tmpvar_27;
  tmpvar_27 = dot (tmpvar_24, vec3(0.0, 0.0, 1.0));
  float tmpvar_28;
  tmpvar_28 = abs(tmpvar_27);
  if ((1e-06 < tmpvar_28)) {
    tmpvar_26 = (dot ((tmpvar_25 - tmpvar_23), tmpvar_24) / tmpvar_27);
  };
  vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xy = tmpvar_17;
  tmpvar_29.z = (-10000.0 + tmpvar_26);
  vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 1.0);
  tmpvar_30.xy = ((aClipOrigins.xy + aClipDeviceArea.xy) + (aPosition * aClipDeviceArea.zw));
  gl_Position = (uTransform * tmpvar_30);
  vec4 tmpvar_31;
  tmpvar_31.xy = aClipLocalPos;
  tmpvar_31.zw = (aClipLocalPos + tmpvar_8.zw);
  vTransformBounds = tmpvar_31;
  vClipMode = tmpvar_9.x;
  vLocalPos = ((transform_inv_m_2 * tmpvar_29) * tmpvar_16.w);
  vec2 result_p1_32;
  result_p1_32 = (aClipLocalPos + tmpvar_8.zw);
  vec4 tmpvar_33;
  tmpvar_33.xy = (aClipLocalPos + tmpvar_10.xy);
  tmpvar_33.zw = tmpvar_10.xy;
  vClipCenter_Radius_TL = tmpvar_33;
  vec4 tmpvar_34;
  tmpvar_34.x = (result_p1_32.x - tmpvar_11.x);
  tmpvar_34.y = (aClipLocalPos.y + tmpvar_11.y);
  tmpvar_34.zw = tmpvar_11.xy;
  vClipCenter_Radius_TR = tmpvar_34;
  vec4 tmpvar_35;
  tmpvar_35.xy = (result_p1_32 - tmpvar_13.xy);
  tmpvar_35.zw = tmpvar_13.xy;
  vClipCenter_Radius_BR = tmpvar_35;
  vec4 tmpvar_36;
  tmpvar_36.x = (aClipLocalPos.x + tmpvar_12.x);
  tmpvar_36.y = (result_p1_32.y - tmpvar_12.y);
  tmpvar_36.zw = tmpvar_12.xy;
  vClipCenter_Radius_BL = tmpvar_36;
}

