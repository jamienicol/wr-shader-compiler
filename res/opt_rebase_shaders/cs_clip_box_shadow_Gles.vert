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
in highp vec4 aClipDeviceArea;
in highp vec4 aClipOrigins;
in highp float aDevicePixelScale;
out highp vec4 vLocalPos;
out highp vec2 vUv;
flat out highp vec4 vUvBounds;
flat out highp float vLayer;
flat out highp vec4 vEdge;
flat out highp vec4 vUvBounds_NoClamp;
flat out highp float vClipMode;
void main ()
{
  float res_layer_1;
  float bs_data_clip_mode_2;
  int bs_data_stretch_mode_x_3;
  int bs_data_stretch_mode_y_4;
  mat4 transform_m_5;
  mat4 transform_inv_m_6;
  int tmpvar_7;
  tmpvar_7 = (aTransformIds.x & 16777215);
  ivec2 tmpvar_8;
  tmpvar_8.x = int((8u * (
    uint(tmpvar_7)
   % 128u)));
  tmpvar_8.y = int((uint(tmpvar_7) / 128u));
  transform_m_5[0] = texelFetch (sTransformPalette, tmpvar_8, 0);
  transform_m_5[1] = texelFetch (sTransformPalette, (tmpvar_8 + ivec2(1, 0)), 0);
  transform_m_5[2] = texelFetch (sTransformPalette, (tmpvar_8 + ivec2(2, 0)), 0);
  transform_m_5[3] = texelFetch (sTransformPalette, (tmpvar_8 + ivec2(3, 0)), 0);
  transform_inv_m_6[0] = texelFetch (sTransformPalette, (tmpvar_8 + ivec2(4, 0)), 0);
  transform_inv_m_6[1] = texelFetch (sTransformPalette, (tmpvar_8 + ivec2(5, 0)), 0);
  transform_inv_m_6[2] = texelFetch (sTransformPalette, (tmpvar_8 + ivec2(6, 0)), 0);
  transform_inv_m_6[3] = texelFetch (sTransformPalette, (tmpvar_8 + ivec2(7, 0)), 0);
  mat4 transform_m_9;
  int tmpvar_10;
  tmpvar_10 = (aTransformIds.y & 16777215);
  ivec2 tmpvar_11;
  tmpvar_11.x = int((8u * (
    uint(tmpvar_10)
   % 128u)));
  tmpvar_11.y = int((uint(tmpvar_10) / 128u));
  transform_m_9[0] = texelFetch (sTransformPalette, tmpvar_11, 0);
  transform_m_9[1] = texelFetch (sTransformPalette, (tmpvar_11 + ivec2(1, 0)), 0);
  transform_m_9[2] = texelFetch (sTransformPalette, (tmpvar_11 + ivec2(2, 0)), 0);
  transform_m_9[3] = texelFetch (sTransformPalette, (tmpvar_11 + ivec2(3, 0)), 0);
  vec2 dest_rect_p0_12;
  vec4 tmpvar_13;
  vec4 tmpvar_14;
  vec4 tmpvar_15;
  tmpvar_13 = texelFetch (sGpuCache, aClipDataResourceAddress.xy, 0);
  tmpvar_14 = texelFetch (sGpuCache, (aClipDataResourceAddress.xy + ivec2(1, 0)), 0);
  tmpvar_15 = texelFetch (sGpuCache, (aClipDataResourceAddress.xy + ivec2(2, 0)), 0);
  dest_rect_p0_12 = tmpvar_15.xy;
  bs_data_clip_mode_2 = tmpvar_13.z;
  bs_data_stretch_mode_x_3 = int(tmpvar_14.x);
  bs_data_stretch_mode_y_4 = int(tmpvar_14.y);
  vec2 uv_rect_p0_16;
  vec2 uv_rect_p1_17;
  vec4 tmpvar_18;
  tmpvar_18 = texelFetch (sGpuCache, aClipDataResourceAddress.zw, 0);
  uv_rect_p0_16 = tmpvar_18.xy;
  uv_rect_p1_17 = tmpvar_18.zw;
  res_layer_1 = texelFetch (sGpuCache, (aClipDataResourceAddress.zw + ivec2(1, 0)), 0).x;
  highp vec4 pos_19;
  vec4 tmpvar_20;
  tmpvar_20.zw = vec2(0.0, 1.0);
  tmpvar_20.xy = (((aClipOrigins.zw + aClipDeviceArea.xy) + (aPosition * aClipDeviceArea.zw)) / aDevicePixelScale);
  vec4 tmpvar_21;
  tmpvar_21 = (transform_m_9 * tmpvar_20);
  pos_19.w = tmpvar_21.w;
  pos_19.xyz = (tmpvar_21.xyz / tmpvar_21.w);
  highp vec2 tmpvar_22;
  tmpvar_22 = pos_19.xy;
  vec4 tmpvar_23;
  tmpvar_23 = (transform_m_5 * vec4(0.0, 0.0, 0.0, 1.0));
  vec3 tmpvar_24;
  vec3 tmpvar_25;
  vec3 tmpvar_26;
  tmpvar_24 = transform_inv_m_6[uint(0)].xyz;
  tmpvar_25 = transform_inv_m_6[1u].xyz;
  tmpvar_26 = transform_inv_m_6[2u].xyz;
  mat3 tmpvar_27;
  tmpvar_27[0].x = tmpvar_24.x;
  tmpvar_27[1].x = tmpvar_24.y;
  tmpvar_27[2].x = tmpvar_24.z;
  tmpvar_27[0].y = tmpvar_25.x;
  tmpvar_27[1].y = tmpvar_25.y;
  tmpvar_27[2].y = tmpvar_25.z;
  tmpvar_27[0].z = tmpvar_26.x;
  tmpvar_27[1].z = tmpvar_26.y;
  tmpvar_27[2].z = tmpvar_26.z;
  vec3 tmpvar_28;
  tmpvar_28.z = -10000.0;
  tmpvar_28.xy = tmpvar_22;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_27 * vec3(0.0, 0.0, 1.0));
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_23.xyz / tmpvar_23.w);
  highp float tmpvar_31;
  float tmpvar_32;
  tmpvar_32 = dot (tmpvar_29, vec3(0.0, 0.0, 1.0));
  float tmpvar_33;
  tmpvar_33 = abs(tmpvar_32);
  if ((1e-06 < tmpvar_33)) {
    tmpvar_31 = (dot ((tmpvar_30 - tmpvar_28), tmpvar_29) / tmpvar_32);
  };
  vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xy = tmpvar_22;
  tmpvar_34.z = (-10000.0 + tmpvar_31);
  vec4 tmpvar_35;
  tmpvar_35 = ((transform_inv_m_6 * tmpvar_34) * tmpvar_21.w);
  vec4 tmpvar_36;
  tmpvar_36.zw = vec2(0.0, 1.0);
  tmpvar_36.xy = ((aClipOrigins.xy + aClipDeviceArea.xy) + (aPosition * aClipDeviceArea.zw));
  gl_Position = (uTransform * tmpvar_36);
  vec4 tmpvar_37;
  tmpvar_37.xy = dest_rect_p0_12;
  tmpvar_37.zw = (tmpvar_15.xy + tmpvar_15.zw);
  vTransformBounds = tmpvar_37;
  vLayer = res_layer_1;
  vClipMode = bs_data_clip_mode_2;
  vec2 tmpvar_38;
  tmpvar_38 = vec3(textureSize (sColor0, 0)).xy;
  vec2 tmpvar_39;
  tmpvar_39 = (tmpvar_35.xy / tmpvar_35.w);
  vLocalPos = tmpvar_35;
  bool tmpvar_40;
  tmpvar_40 = bool(0);
  while (true) {
    tmpvar_40 = (tmpvar_40 || (0 == bs_data_stretch_mode_x_3));
    if (tmpvar_40) {
      vEdge.x = 0.5;
      vEdge.z = ((tmpvar_15.z / tmpvar_13.x) - 0.5);
      vUv.x = ((tmpvar_39.x - tmpvar_15.x) / tmpvar_13.x);
      break;
    };
    tmpvar_40 = bool(1);
    vEdge.xz = vec2(1.0, 1.0);
    vUv.x = ((tmpvar_39.x - tmpvar_15.x) / tmpvar_15.z);
    break;
  };
  bool tmpvar_41;
  tmpvar_41 = bool(0);
  while (true) {
    tmpvar_41 = (tmpvar_41 || (0 == bs_data_stretch_mode_y_4));
    if (tmpvar_41) {
      vEdge.y = 0.5;
      vEdge.w = ((tmpvar_15.w / tmpvar_13.y) - 0.5);
      vUv.y = ((tmpvar_39.y - tmpvar_15.y) / tmpvar_13.y);
      break;
    };
    tmpvar_41 = bool(1);
    vEdge.yw = vec2(1.0, 1.0);
    vUv.y = ((tmpvar_39.y - tmpvar_15.y) / tmpvar_15.w);
    break;
  };
  vUv = (vUv * tmpvar_35.w);
  vec4 tmpvar_42;
  tmpvar_42.xy = (tmpvar_18.xy + vec2(0.5, 0.5));
  tmpvar_42.zw = (tmpvar_18.zw - vec2(0.5, 0.5));
  vUvBounds = (tmpvar_42 / tmpvar_38.xyxy);
  vec4 tmpvar_43;
  tmpvar_43.xy = uv_rect_p0_16;
  tmpvar_43.zw = uv_rect_p1_17;
  vUvBounds_NoClamp = (tmpvar_43 / tmpvar_38.xyxy);
}
