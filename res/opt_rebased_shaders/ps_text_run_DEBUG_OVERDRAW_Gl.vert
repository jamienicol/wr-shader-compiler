#version 150
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform int uMode;
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2DArray sColor0;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
uniform sampler2D sTransformPalette;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_2;
out vec4 varying_vec4_0;
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
  tmpvar_8 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_7, 0, ivec2(0, 0));
  vec4 tmpvar_9;
  tmpvar_9 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_7, 0, ivec2(1, 0));
  ivec2 tmpvar_10;
  tmpvar_10.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_10.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_11;
  tmpvar_11 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_10, 0, ivec2(0, 0));
  ivec4 tmpvar_12;
  tmpvar_12 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_10, 0, ivec2(1, 0));
  ph_z_6 = float(tmpvar_11.x);
  mat4 transform_m_13;
  int tmpvar_14;
  tmpvar_14 = (tmpvar_11.z & 16777215);
  ivec2 tmpvar_15;
  tmpvar_15.x = int((8u * (
    uint(tmpvar_14)
   % 128u)));
  tmpvar_15.y = int((uint(tmpvar_14) / 128u));
  transform_m_13[0] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(0, 0));
  transform_m_13[1] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(1, 0));
  transform_m_13[2] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(2, 0));
  transform_m_13[3] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(3, 0));
  ivec2 tmpvar_16;
  tmpvar_16.x = int((2u * (
    uint(instance_picture_task_address_1)
   % 512u)));
  tmpvar_16.y = int((uint(instance_picture_task_address_1) / 512u));
  vec4 tmpvar_17;
  tmpvar_17 = texelFetchOffset (sRenderTasks, tmpvar_16, 0, ivec2(0, 0));
  vec4 tmpvar_18;
  tmpvar_18 = texelFetchOffset (sRenderTasks, tmpvar_16, 0, ivec2(1, 0));
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
    tmpvar_24 = texelFetchOffset (sRenderTasks, tmpvar_23, 0, ivec2(0, 0));
    vec4 tmpvar_25;
    tmpvar_25 = texelFetchOffset (sRenderTasks, tmpvar_23, 0, ivec2(1, 0));
    vec3 tmpvar_26;
    tmpvar_26 = tmpvar_25.yzw;
    area_common_data_task_rect_19.p0 = tmpvar_24.xy;
    area_common_data_task_rect_19.size = tmpvar_24.zw;
    area_common_data_texture_layer_index_20 = tmpvar_25.x;
    area_device_pixel_scale_21 = tmpvar_26.x;
    area_screen_origin_22 = tmpvar_26.yz;
  };
  float res_layer_27;
  vec2 glyph_offset_28;
  int color_mode_29;
  int subpx_dir_30;
  subpx_dir_30 = ((instance_flags_4 >> 8) & 255);
  color_mode_29 = (instance_flags_4 & 255);
  ivec2 tmpvar_31;
  tmpvar_31.x = int((uint(tmpvar_11.y) % 1024u));
  tmpvar_31.y = int((uint(tmpvar_11.y) / 1024u));
  vec4 tmpvar_32;
  vec4 tmpvar_33;
  tmpvar_32 = texelFetchOffset (sGpuCache, tmpvar_31, 0, ivec2(0, 0));
  tmpvar_33 = texelFetchOffset (sGpuCache, tmpvar_31, 0, ivec2(1, 0));
  if ((color_mode_29 == 0)) {
    color_mode_29 = uMode;
  };
  int tmpvar_34;
  tmpvar_34 = ((tmpvar_11.y + 2) + int((
    uint(instance_segment_index_3)
   / 2u)));
  ivec2 tmpvar_35;
  tmpvar_35.x = int((uint(tmpvar_34) % 1024u));
  tmpvar_35.y = int((uint(tmpvar_34) / 1024u));
  vec4 tmpvar_36;
  tmpvar_36 = texelFetch (sGpuCache, tmpvar_35, 0);
  glyph_offset_28 = (mix(tmpvar_36.xy, tmpvar_36.zw, bvec2((
    (uint(instance_segment_index_3) % 2u)
   != uint(0)))) + tmpvar_8.xy);
  ivec2 tmpvar_37;
  tmpvar_37.x = int((uint(instance_resource_address_5) % 1024u));
  tmpvar_37.y = int((uint(instance_resource_address_5) / 1024u));
  vec4 tmpvar_38;
  vec4 tmpvar_39;
  tmpvar_38 = texelFetchOffset (sGpuCache, tmpvar_37, 0, ivec2(0, 0));
  tmpvar_39 = texelFetchOffset (sGpuCache, tmpvar_37, 0, ivec2(1, 0));
  res_layer_27 = tmpvar_39.x;
  vec2 tmpvar_40;
  bool tmpvar_41;
  tmpvar_41 = bool(0);
  bool tmpvar_42;
  tmpvar_42 = bool(0);
  while (true) {
    tmpvar_42 = (tmpvar_42 || (0 == subpx_dir_30));
    tmpvar_42 = (tmpvar_42 || !((
      ((1 == subpx_dir_30) || (2 == subpx_dir_30))
     || 
      (3 == subpx_dir_30)
    )));
    if (tmpvar_42) {
      tmpvar_40 = vec2(0.5, 0.5);
      tmpvar_41 = bool(1);
      break;
    };
    tmpvar_42 = (tmpvar_42 || (1 == subpx_dir_30));
    if (tmpvar_42) {
      tmpvar_40 = vec2(0.125, 0.5);
      tmpvar_41 = bool(1);
      break;
    };
    tmpvar_42 = (tmpvar_42 || (2 == subpx_dir_30));
    if (tmpvar_42) {
      tmpvar_40 = vec2(0.5, 0.125);
      tmpvar_41 = bool(1);
      break;
    };
    tmpvar_42 = (tmpvar_42 || (3 == subpx_dir_30));
    if (tmpvar_42) {
      tmpvar_40 = vec2(0.125, 0.125);
      tmpvar_41 = bool(1);
      break;
    };
    break;
  };
  if (tmpvar_41) {
    tmpvar_41 = bool(1);
  };
  float tmpvar_43;
  tmpvar_43 = ((float(tmpvar_12.x) / 65535.0) * tmpvar_18.y);
  float tmpvar_44;
  tmpvar_44 = (tmpvar_39.w / tmpvar_43);
  vec2 tmpvar_45;
  vec2 tmpvar_46;
  tmpvar_45 = ((tmpvar_44 * (tmpvar_39.yz + 
    (floor(((glyph_offset_28 * tmpvar_43) + tmpvar_40)) / tmpvar_39.w)
  )) + tmpvar_8.zw);
  tmpvar_46 = (tmpvar_44 * (tmpvar_38.zw - tmpvar_38.xy));
  vec2 tmpvar_47;
  tmpvar_47 = min (max ((tmpvar_45 + 
    (tmpvar_46 * aPosition)
  ), tmpvar_9.xy), (tmpvar_9.xy + tmpvar_9.zw));
  vec4 tmpvar_48;
  tmpvar_48.zw = vec2(0.0, 1.0);
  tmpvar_48.xy = tmpvar_47;
  vec4 tmpvar_49;
  tmpvar_49 = (transform_m_13 * tmpvar_48);
  vec4 tmpvar_50;
  tmpvar_50.xy = ((tmpvar_49.xy * tmpvar_18.y) + ((
    -(tmpvar_18.zw)
   + tmpvar_17.xy) * tmpvar_49.w));
  tmpvar_50.z = (ph_z_6 * tmpvar_49.w);
  tmpvar_50.w = tmpvar_49.w;
  gl_Position = (uTransform * tmpvar_50);
  vec2 tmpvar_51;
  tmpvar_51 = ((tmpvar_47 - tmpvar_45) / tmpvar_46);
  vec4 tmpvar_52;
  tmpvar_52.xy = area_common_data_task_rect_19.p0;
  tmpvar_52.zw = (area_common_data_task_rect_19.p0 + area_common_data_task_rect_19.size);
  vClipMaskUvBounds = tmpvar_52;
  vec4 tmpvar_53;
  tmpvar_53.xy = ((tmpvar_49.xy * area_device_pixel_scale_21) + (tmpvar_49.w * (area_common_data_task_rect_19.p0 - area_screen_origin_22)));
  tmpvar_53.z = area_common_data_texture_layer_index_20;
  tmpvar_53.w = tmpvar_49.w;
  vClipMaskUv = tmpvar_53;
  bool tmpvar_54;
  tmpvar_54 = bool(0);
  while (true) {
    tmpvar_54 = (tmpvar_54 || (1 == color_mode_29));
    tmpvar_54 = (tmpvar_54 || (7 == color_mode_29));
    if (tmpvar_54) {
      flat_varying_vec4_1.xy = vec2(0.0, 1.0);
      flat_varying_vec4_0 = tmpvar_32;
      break;
    };
    tmpvar_54 = (tmpvar_54 || (5 == color_mode_29));
    tmpvar_54 = (tmpvar_54 || (6 == color_mode_29));
    if (tmpvar_54) {
      flat_varying_vec4_1.xy = vec2(1.0, 0.0);
      flat_varying_vec4_0 = tmpvar_32;
      break;
    };
    tmpvar_54 = (tmpvar_54 || (2 == color_mode_29));
    tmpvar_54 = (tmpvar_54 || (3 == color_mode_29));
    tmpvar_54 = (tmpvar_54 || (8 == color_mode_29));
    if (tmpvar_54) {
      flat_varying_vec4_1.xy = vec2(1.0, 0.0);
      flat_varying_vec4_0 = tmpvar_32.wwww;
      break;
    };
    tmpvar_54 = (tmpvar_54 || (4 == color_mode_29));
    if (tmpvar_54) {
      flat_varying_vec4_1.xy = vec2(-1.0, 1.0);
      flat_varying_vec4_0 = (tmpvar_32.wwww * tmpvar_33);
      break;
    };
    tmpvar_54 = bool(1);
    flat_varying_vec4_1.xy = vec2(0.0, 0.0);
    flat_varying_vec4_0 = vec4(1.0, 1.0, 1.0, 1.0);
    break;
  };
  vec2 tmpvar_55;
  tmpvar_55 = vec3(textureSize (sColor0, 0)).xy;
  varying_vec4_0.xy = mix ((tmpvar_38.xy / tmpvar_55), (tmpvar_38.zw / tmpvar_55), tmpvar_51);
  varying_vec4_0.z = res_layer_27;
  flat_varying_vec4_2 = ((tmpvar_38 + vec4(0.5, 0.5, -0.5, -0.5)) / tmpvar_55.xyxy);
}

