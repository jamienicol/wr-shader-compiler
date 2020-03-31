#version 300 es
#extension GL_EXT_blend_func_extended : enable
precision highp sampler2DArray;
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform highp int uMode;
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform highp sampler2DArray sColor0;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
flat out highp vec4 vClipMaskUvBounds;
out highp vec4 vClipMaskUv;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
flat out highp vec4 flat_varying_vec4_0;
flat out highp vec4 flat_varying_vec4_1;
flat out highp vec4 flat_varying_vec4_2;
out highp vec4 varying_vec4_0;
out highp vec4 varying_vec4_1;
void main ()
{
  int instance_picture_task_address_1;
  int instance_clip_address_2;
  int instance_segment_index_3;
  int instance_flags_4;
  int instance_resource_address_5;
  instance_picture_task_address_1 = (aData.y >> 16);
  instance_clip_address_2 = (aData.y & 65535);
  instance_segment_index_3 = (aData.z & 65535);
  instance_flags_4 = (aData.z >> 16);
  instance_resource_address_5 = (aData.w & 16777215);
  float ph_z_6;
  ivec2 tmpvar_7;
  tmpvar_7.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_7.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_8;
  tmpvar_8 = texelFetch (sPrimitiveHeadersF, tmpvar_7, 0);
  vec4 tmpvar_9;
  tmpvar_9 = texelFetch (sPrimitiveHeadersF, (tmpvar_7 + ivec2(1, 0)), 0);
  vec2 tmpvar_10;
  tmpvar_10 = tmpvar_9.xy;
  ivec2 tmpvar_11;
  tmpvar_11.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_11.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_12;
  tmpvar_12 = texelFetch (sPrimitiveHeadersI, tmpvar_11, 0);
  ph_z_6 = float(tmpvar_12.x);
  mat4 transform_m_13;
  int tmpvar_14;
  tmpvar_14 = (tmpvar_12.z & 16777215);
  ivec2 tmpvar_15;
  tmpvar_15.x = int((8u * (
    uint(tmpvar_14)
   % 128u)));
  tmpvar_15.y = int((uint(tmpvar_14) / 128u));
  transform_m_13[0] = texelFetch (sTransformPalette, tmpvar_15, 0);
  transform_m_13[1] = texelFetch (sTransformPalette, (tmpvar_15 + ivec2(1, 0)), 0);
  transform_m_13[2] = texelFetch (sTransformPalette, (tmpvar_15 + ivec2(2, 0)), 0);
  transform_m_13[3] = texelFetch (sTransformPalette, (tmpvar_15 + ivec2(3, 0)), 0);
  ivec2 tmpvar_16;
  tmpvar_16.x = int((2u * (
    uint(instance_picture_task_address_1)
   % 512u)));
  tmpvar_16.y = int((uint(instance_picture_task_address_1) / 512u));
  vec4 tmpvar_17;
  tmpvar_17 = texelFetch (sRenderTasks, tmpvar_16, 0);
  vec4 tmpvar_18;
  tmpvar_18 = texelFetch (sRenderTasks, (tmpvar_16 + ivec2(1, 0)), 0);
  RectWithSize area_common_data_task_rect_19;
  float area_common_data_texture_layer_index_20;
  float area_device_pixel_scale_21;
  vec2 area_screen_origin_22;
  if ((instance_clip_address_2 >= 32767)) {
    area_common_data_task_rect_19 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    area_common_data_texture_layer_index_20 = 0.0;
    area_device_pixel_scale_21 = 0.0;
    area_screen_origin_22 = vec2(0.0, 0.0);
  } else {
    ivec2 tmpvar_23;
    tmpvar_23.x = int((2u * (
      uint(instance_clip_address_2)
     % 512u)));
    tmpvar_23.y = int((uint(instance_clip_address_2) / 512u));
    vec4 tmpvar_24;
    tmpvar_24 = texelFetch (sRenderTasks, tmpvar_23, 0);
    vec4 tmpvar_25;
    tmpvar_25 = texelFetch (sRenderTasks, (tmpvar_23 + ivec2(1, 0)), 0);
    vec3 tmpvar_26;
    tmpvar_26 = tmpvar_25.yzw;
    area_common_data_task_rect_19.p0 = tmpvar_24.xy;
    area_common_data_task_rect_19.size = tmpvar_24.zw;
    area_common_data_texture_layer_index_20 = tmpvar_25.x;
    area_device_pixel_scale_21 = tmpvar_26.x;
    area_screen_origin_22 = tmpvar_26.yz;
  };
  highp vec2 local_pos_27;
  float res_layer_28;
  vec2 glyph_offset_29;
  highp int color_mode_30;
  highp int subpx_dir_31;
  subpx_dir_31 = ((instance_flags_4 >> 8) & 255);
  color_mode_30 = (instance_flags_4 & 255);
  ivec2 tmpvar_32;
  tmpvar_32.x = int((uint(tmpvar_12.y) % 1024u));
  tmpvar_32.y = int((uint(tmpvar_12.y) / 1024u));
  vec4 tmpvar_33;
  vec4 tmpvar_34;
  tmpvar_33 = texelFetch (sGpuCache, tmpvar_32, 0);
  tmpvar_34 = texelFetch (sGpuCache, (tmpvar_32 + ivec2(1, 0)), 0);
  if ((color_mode_30 == 0)) {
    color_mode_30 = uMode;
  };
  highp int tmpvar_35;
  tmpvar_35 = ((tmpvar_12.y + 2) + int((
    uint(instance_segment_index_3)
   / 2u)));
  ivec2 tmpvar_36;
  tmpvar_36.x = int((uint(tmpvar_35) % 1024u));
  tmpvar_36.y = int((uint(tmpvar_35) / 1024u));
  vec4 tmpvar_37;
  tmpvar_37 = texelFetch (sGpuCache, tmpvar_36, 0);
  glyph_offset_29 = (mix(tmpvar_37.xy, tmpvar_37.zw, bvec2((
    (uint(instance_segment_index_3) % 2u)
   != uint(0)))) + tmpvar_8.xy);
  ivec2 tmpvar_38;
  tmpvar_38.x = int((uint(instance_resource_address_5) % 1024u));
  tmpvar_38.y = int((uint(instance_resource_address_5) / 1024u));
  vec4 tmpvar_39;
  vec4 tmpvar_40;
  tmpvar_39 = texelFetch (sGpuCache, tmpvar_38, 0);
  tmpvar_40 = texelFetch (sGpuCache, (tmpvar_38 + ivec2(1, 0)), 0);
  res_layer_28 = tmpvar_40.x;
  vec2 tmpvar_41;
  bool tmpvar_42;
  tmpvar_42 = bool(0);
  bool tmpvar_43;
  tmpvar_43 = bool(0);
  while (true) {
    tmpvar_43 = (tmpvar_43 || (0 == subpx_dir_31));
    tmpvar_43 = (tmpvar_43 || !((
      ((1 == subpx_dir_31) || (2 == subpx_dir_31))
     || 
      (3 == subpx_dir_31)
    )));
    if (tmpvar_43) {
      tmpvar_41 = vec2(0.5, 0.5);
      tmpvar_42 = bool(1);
      break;
    };
    tmpvar_43 = (tmpvar_43 || (1 == subpx_dir_31));
    if (tmpvar_43) {
      tmpvar_41 = vec2(0.125, 0.5);
      tmpvar_42 = bool(1);
      break;
    };
    tmpvar_43 = (tmpvar_43 || (2 == subpx_dir_31));
    if (tmpvar_43) {
      tmpvar_41 = vec2(0.5, 0.125);
      tmpvar_42 = bool(1);
      break;
    };
    tmpvar_43 = (tmpvar_43 || (3 == subpx_dir_31));
    if (tmpvar_43) {
      tmpvar_41 = vec2(0.125, 0.125);
      tmpvar_42 = bool(1);
      break;
    };
    break;
  };
  if (tmpvar_42) {
    tmpvar_42 = bool(1);
  };
  mat2 tmpvar_44;
  tmpvar_44[uint(0)] = transform_m_13[uint(0)].xy;
  tmpvar_44[1u] = transform_m_13[1u].xy;
  mat2 tmpvar_45;
  tmpvar_45 = (tmpvar_44 * tmpvar_18.y);
  vec2 tmpvar_46;
  tmpvar_46 = (transform_m_13[3].xy * tmpvar_18.y);
  mat2 tmpvar_47;
  mat2 tmpvar_48;
  tmpvar_48[0].x = tmpvar_45[1].y;
  tmpvar_48[0].y = -(tmpvar_45[0].y);
  tmpvar_48[1].x = -(tmpvar_45[1].x);
  tmpvar_48[1].y = tmpvar_45[0].x;
  tmpvar_47 = (tmpvar_48 / ((tmpvar_45[0].x * tmpvar_45[1].y) - (tmpvar_45[1].x * tmpvar_45[0].y)));
  vec2 tmpvar_49;
  vec2 tmpvar_50;
  tmpvar_49 = ((tmpvar_40.yz + floor(
    ((tmpvar_45 * glyph_offset_29) + tmpvar_41)
  )) + (floor(
    (((tmpvar_45 * tmpvar_8.zw) + tmpvar_46) + 0.5)
  ) - tmpvar_46));
  tmpvar_50 = (tmpvar_39.zw - tmpvar_39.xy);
  mat2 tmpvar_51;
  tmpvar_51[uint(0)] = abs(tmpvar_47[0]);
  tmpvar_51[1u] = abs(tmpvar_47[1]);
  vec2 tmpvar_52;
  tmpvar_52 = (tmpvar_51 * (tmpvar_50 * 0.5));
  vec2 tmpvar_53;
  vec2 tmpvar_54;
  tmpvar_53 = ((tmpvar_47 * (tmpvar_49 + 
    (tmpvar_50 * 0.5)
  )) - tmpvar_52);
  tmpvar_54 = (tmpvar_52 * 2.0);
  local_pos_27 = (tmpvar_53 + (tmpvar_54 * aPosition));
  vec4 tmpvar_55;
  tmpvar_55.xy = tmpvar_10;
  tmpvar_55.zw = (tmpvar_53 + tmpvar_54);
  vec4 tmpvar_56;
  tmpvar_56.xy = tmpvar_53;
  tmpvar_56.zw = (tmpvar_9.xy + tmpvar_9.zw);
  if ((greaterThanEqual (tmpvar_56, tmpvar_55) == bvec4(1, 1, 1, 1))) {
    local_pos_27 = (tmpvar_47 * (tmpvar_49 + (tmpvar_50 * aPosition)));
  };
  vec2 tmpvar_57;
  tmpvar_57 = min (max (local_pos_27, tmpvar_9.xy), (tmpvar_9.xy + tmpvar_9.zw));
  vec4 tmpvar_58;
  tmpvar_58.zw = vec2(0.0, 1.0);
  tmpvar_58.xy = tmpvar_57;
  vec4 tmpvar_59;
  tmpvar_59 = (transform_m_13 * tmpvar_58);
  vec4 tmpvar_60;
  tmpvar_60.xy = ((tmpvar_59.xy * tmpvar_18.y) + ((
    -(tmpvar_18.zw)
   + tmpvar_17.xy) * tmpvar_59.w));
  tmpvar_60.z = (ph_z_6 * tmpvar_59.w);
  tmpvar_60.w = tmpvar_59.w;
  gl_Position = (uTransform * tmpvar_60);
  vec2 tmpvar_61;
  tmpvar_61 = (((tmpvar_45 * tmpvar_57) - tmpvar_49) / tmpvar_50);
  vec4 tmpvar_62;
  tmpvar_62.xy = tmpvar_61;
  tmpvar_62.zw = (1.0 - tmpvar_61);
  varying_vec4_1 = tmpvar_62;
  vec4 tmpvar_63;
  tmpvar_63.xy = area_common_data_task_rect_19.p0;
  tmpvar_63.zw = (area_common_data_task_rect_19.p0 + area_common_data_task_rect_19.size);
  vClipMaskUvBounds = tmpvar_63;
  vec4 tmpvar_64;
  tmpvar_64.xy = ((tmpvar_59.xy * area_device_pixel_scale_21) + (tmpvar_59.w * (area_common_data_task_rect_19.p0 - area_screen_origin_22)));
  tmpvar_64.z = area_common_data_texture_layer_index_20;
  tmpvar_64.w = tmpvar_59.w;
  vClipMaskUv = tmpvar_64;
  bool tmpvar_65;
  tmpvar_65 = bool(0);
  while (true) {
    tmpvar_65 = (tmpvar_65 || (1 == color_mode_30));
    tmpvar_65 = (tmpvar_65 || (7 == color_mode_30));
    if (tmpvar_65) {
      flat_varying_vec4_1.xy = vec2(0.0, 1.0);
      flat_varying_vec4_0 = tmpvar_33;
      break;
    };
    tmpvar_65 = (tmpvar_65 || (5 == color_mode_30));
    tmpvar_65 = (tmpvar_65 || (6 == color_mode_30));
    if (tmpvar_65) {
      flat_varying_vec4_1.xy = vec2(1.0, 0.0);
      flat_varying_vec4_0 = tmpvar_33;
      break;
    };
    tmpvar_65 = (tmpvar_65 || (2 == color_mode_30));
    tmpvar_65 = (tmpvar_65 || (3 == color_mode_30));
    tmpvar_65 = (tmpvar_65 || (8 == color_mode_30));
    if (tmpvar_65) {
      flat_varying_vec4_1.xy = vec2(1.0, 0.0);
      flat_varying_vec4_0 = tmpvar_33.wwww;
      break;
    };
    tmpvar_65 = (tmpvar_65 || (4 == color_mode_30));
    if (tmpvar_65) {
      flat_varying_vec4_1.xy = vec2(-1.0, 1.0);
      flat_varying_vec4_0 = (tmpvar_33.wwww * tmpvar_34);
      break;
    };
    tmpvar_65 = bool(1);
    flat_varying_vec4_1.xy = vec2(0.0, 0.0);
    flat_varying_vec4_0 = vec4(1.0, 1.0, 1.0, 1.0);
    break;
  };
  vec2 tmpvar_66;
  tmpvar_66 = vec3(textureSize (sColor0, 0)).xy;
  varying_vec4_0.xy = mix ((tmpvar_39.xy / tmpvar_66), (tmpvar_39.zw / tmpvar_66), tmpvar_61);
  varying_vec4_0.z = res_layer_28;
  flat_varying_vec4_2 = ((tmpvar_39 + vec4(0.5, 0.5, -0.5, -0.5)) / tmpvar_66.xyxy);
}

