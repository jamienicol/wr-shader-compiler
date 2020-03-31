#version 300 es
precision highp sampler2DArray;
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform highp sampler2DArray sColor0;
uniform highp sampler2D sGpuCache;
flat out highp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
in highp ivec2 aTransformIds;
in highp ivec4 aClipDataResourceAddress;
in highp vec2 aClipLocalPos;
in highp vec4 aClipTileRect;
in highp vec4 aClipDeviceArea;
in highp vec4 aClipOrigins;
in highp float aDevicePixelScale;
out highp vec4 vLocalPos;
out highp vec2 vClipMaskImageUv;
flat out highp vec4 vClipMaskUvRect;
flat out highp vec4 vClipMaskUvInnerRect;
flat out highp float vLayer;
void main ()
{
  float res_layer_1;
  mat4 transform_m_2;
  mat4 transform_inv_m_3;
  int tmpvar_4;
  tmpvar_4 = (aTransformIds.x & 16777215);
  ivec2 tmpvar_5;
  tmpvar_5.x = int((8u * (
    uint(tmpvar_4)
   % 128u)));
  tmpvar_5.y = int((uint(tmpvar_4) / 128u));
  transform_m_2[0] = texelFetch (sTransformPalette, tmpvar_5, 0);
  transform_m_2[1] = texelFetch (sTransformPalette, (tmpvar_5 + ivec2(1, 0)), 0);
  transform_m_2[2] = texelFetch (sTransformPalette, (tmpvar_5 + ivec2(2, 0)), 0);
  transform_m_2[3] = texelFetch (sTransformPalette, (tmpvar_5 + ivec2(3, 0)), 0);
  transform_inv_m_3[0] = texelFetch (sTransformPalette, (tmpvar_5 + ivec2(4, 0)), 0);
  transform_inv_m_3[1] = texelFetch (sTransformPalette, (tmpvar_5 + ivec2(5, 0)), 0);
  transform_inv_m_3[2] = texelFetch (sTransformPalette, (tmpvar_5 + ivec2(6, 0)), 0);
  transform_inv_m_3[3] = texelFetch (sTransformPalette, (tmpvar_5 + ivec2(7, 0)), 0);
  mat4 transform_m_6;
  int tmpvar_7;
  tmpvar_7 = (aTransformIds.y & 16777215);
  ivec2 tmpvar_8;
  tmpvar_8.x = int((8u * (
    uint(tmpvar_7)
   % 128u)));
  tmpvar_8.y = int((uint(tmpvar_7) / 128u));
  transform_m_6[0] = texelFetch (sTransformPalette, tmpvar_8, 0);
  transform_m_6[1] = texelFetch (sTransformPalette, (tmpvar_8 + ivec2(1, 0)), 0);
  transform_m_6[2] = texelFetch (sTransformPalette, (tmpvar_8 + ivec2(2, 0)), 0);
  transform_m_6[3] = texelFetch (sTransformPalette, (tmpvar_8 + ivec2(3, 0)), 0);
  vec2 uv_rect_p0_9;
  vec2 uv_rect_p1_10;
  vec4 tmpvar_11;
  tmpvar_11 = texelFetch (sGpuCache, aClipDataResourceAddress.zw, 0);
  uv_rect_p0_9 = tmpvar_11.xy;
  uv_rect_p1_10 = tmpvar_11.zw;
  res_layer_1 = texelFetch (sGpuCache, (aClipDataResourceAddress.zw + ivec2(1, 0)), 0).x;
  vec2 tmpvar_12;
  tmpvar_12 = texelFetch (sGpuCache, aClipDataResourceAddress.xy, 0).xy;
  highp vec4 pos_13;
  vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 1.0);
  tmpvar_14.xy = (((aClipOrigins.zw + aClipDeviceArea.xy) + (aPosition * aClipDeviceArea.zw)) / aDevicePixelScale);
  vec4 tmpvar_15;
  tmpvar_15 = (transform_m_6 * tmpvar_14);
  pos_13.w = tmpvar_15.w;
  pos_13.xyz = (tmpvar_15.xyz / tmpvar_15.w);
  highp vec2 tmpvar_16;
  tmpvar_16 = pos_13.xy;
  vec4 tmpvar_17;
  tmpvar_17 = (transform_m_2 * vec4(0.0, 0.0, 0.0, 1.0));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  vec3 tmpvar_20;
  tmpvar_18 = transform_inv_m_3[uint(0)].xyz;
  tmpvar_19 = transform_inv_m_3[1u].xyz;
  tmpvar_20 = transform_inv_m_3[2u].xyz;
  mat3 tmpvar_21;
  tmpvar_21[0].x = tmpvar_18.x;
  tmpvar_21[1].x = tmpvar_18.y;
  tmpvar_21[2].x = tmpvar_18.z;
  tmpvar_21[0].y = tmpvar_19.x;
  tmpvar_21[1].y = tmpvar_19.y;
  tmpvar_21[2].y = tmpvar_19.z;
  tmpvar_21[0].z = tmpvar_20.x;
  tmpvar_21[1].z = tmpvar_20.y;
  tmpvar_21[2].z = tmpvar_20.z;
  vec3 tmpvar_22;
  tmpvar_22.z = -10000.0;
  tmpvar_22.xy = tmpvar_16;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_21 * vec3(0.0, 0.0, 1.0));
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_17.xyz / tmpvar_17.w);
  highp float tmpvar_25;
  float tmpvar_26;
  tmpvar_26 = dot (tmpvar_23, vec3(0.0, 0.0, 1.0));
  float tmpvar_27;
  tmpvar_27 = abs(tmpvar_26);
  if ((1e-06 < tmpvar_27)) {
    tmpvar_25 = (dot ((tmpvar_24 - tmpvar_22), tmpvar_23) / tmpvar_26);
  };
  vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xy = tmpvar_16;
  tmpvar_28.z = (-10000.0 + tmpvar_25);
  vec4 tmpvar_29;
  tmpvar_29 = ((transform_inv_m_3 * tmpvar_28) * tmpvar_15.w);
  vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 1.0);
  tmpvar_30.xy = ((aClipOrigins.xy + aClipDeviceArea.xy) + (aPosition * aClipDeviceArea.zw));
  gl_Position = (uTransform * tmpvar_30);
  vec4 tmpvar_31;
  tmpvar_31.xy = aClipLocalPos;
  tmpvar_31.zw = (aClipLocalPos + tmpvar_12);
  vTransformBounds = tmpvar_31;
  vLocalPos = tmpvar_29;
  vLayer = res_layer_1;
  vClipMaskImageUv = ((tmpvar_29.xy - (aClipTileRect.xy * tmpvar_29.w)) / aClipTileRect.zw);
  vec2 tmpvar_32;
  tmpvar_32 = vec3(textureSize (sColor0, 0)).xy;
  vec4 tmpvar_33;
  tmpvar_33.xy = uv_rect_p0_9;
  tmpvar_33.zw = (tmpvar_11.zw - tmpvar_11.xy);
  vClipMaskUvRect = (tmpvar_33 / tmpvar_32.xyxy);
  vec4 tmpvar_34;
  tmpvar_34.xy = uv_rect_p0_9;
  tmpvar_34.zw = uv_rect_p1_10;
  vClipMaskUvInnerRect = ((tmpvar_34 + vec4(0.5, 0.5, -0.5, -0.5)) / tmpvar_32.xyxy);
}

