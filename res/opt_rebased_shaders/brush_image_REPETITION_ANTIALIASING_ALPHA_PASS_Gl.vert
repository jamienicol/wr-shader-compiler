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
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
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
  vec2 tmpvar_10;
  vec2 tmpvar_11;
  tmpvar_10 = tmpvar_8.xy;
  tmpvar_11 = tmpvar_8.zw;
  ivec2 tmpvar_12;
  tmpvar_12.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_12.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_13;
  tmpvar_13 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_12, 0, ivec2(0, 0));
  ivec4 tmpvar_14;
  tmpvar_14 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_12, 0, ivec2(1, 0));
  ph_z_6 = float(tmpvar_13.x);
  mat4 transform_m_15;
  bool transform_is_axis_aligned_16;
  transform_is_axis_aligned_16 = ((tmpvar_13.z >> 24) == 0);
  int tmpvar_17;
  tmpvar_17 = (tmpvar_13.z & 16777215);
  ivec2 tmpvar_18;
  tmpvar_18.x = int((8u * (
    uint(tmpvar_17)
   % 128u)));
  tmpvar_18.y = int((uint(tmpvar_17) / 128u));
  transform_m_15[0] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(0, 0));
  transform_m_15[1] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(1, 0));
  transform_m_15[2] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(2, 0));
  transform_m_15[3] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(3, 0));
  ivec2 tmpvar_19;
  tmpvar_19.x = int((2u * (
    uint(instance_picture_task_address_1)
   % 512u)));
  tmpvar_19.y = int((uint(instance_picture_task_address_1) / 512u));
  vec4 tmpvar_20;
  tmpvar_20 = texelFetchOffset (sRenderTasks, tmpvar_19, 0, ivec2(0, 0));
  vec4 tmpvar_21;
  tmpvar_21 = texelFetchOffset (sRenderTasks, tmpvar_19, 0, ivec2(1, 0));
  RectWithSize area_common_data_task_rect_22;
  float area_common_data_texture_layer_index_23;
  float area_device_pixel_scale_24;
  vec2 area_screen_origin_25;
  if ((instance_clip_address_2 >= 32767)) {
    area_common_data_task_rect_22 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    area_common_data_texture_layer_index_23 = 0.0;
    area_device_pixel_scale_24 = 0.0;
    area_screen_origin_25 = vec2(0.0, 0.0);
  } else {
    ivec2 tmpvar_26;
    tmpvar_26.x = int((2u * (
      uint(instance_clip_address_2)
     % 512u)));
    tmpvar_26.y = int((uint(instance_clip_address_2) / 512u));
    vec4 tmpvar_27;
    tmpvar_27 = texelFetchOffset (sRenderTasks, tmpvar_26, 0, ivec2(0, 0));
    vec4 tmpvar_28;
    tmpvar_28 = texelFetchOffset (sRenderTasks, tmpvar_26, 0, ivec2(1, 0));
    vec3 tmpvar_29;
    tmpvar_29 = tmpvar_28.yzw;
    area_common_data_task_rect_22.p0 = tmpvar_27.xy;
    area_common_data_task_rect_22.size = tmpvar_27.zw;
    area_common_data_texture_layer_index_23 = tmpvar_28.x;
    area_device_pixel_scale_24 = tmpvar_29.x;
    area_screen_origin_25 = tmpvar_29.yz;
  };
  vec2 vi_local_pos_30;
  vec4 vi_world_pos_31;
  vec2 segment_rect_p0_32;
  vec2 segment_rect_size_33;
  vec4 segment_data_34;
  int tmpvar_35;
  tmpvar_35 = (instance_flags_4 & 255);
  int tmpvar_36;
  tmpvar_36 = ((instance_flags_4 >> 8) & 255);
  if ((instance_segment_index_3 == 65535)) {
    segment_rect_p0_32 = tmpvar_10;
    segment_rect_size_33 = tmpvar_11;
    segment_data_34 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    int tmpvar_37;
    tmpvar_37 = ((tmpvar_13.y + 3) + (instance_segment_index_3 * 2));
    ivec2 tmpvar_38;
    tmpvar_38.x = int((uint(tmpvar_37) % 1024u));
    tmpvar_38.y = int((uint(tmpvar_37) / 1024u));
    vec4 tmpvar_39;
    tmpvar_39 = texelFetchOffset (sGpuCache, tmpvar_38, 0, ivec2(0, 0));
    segment_rect_size_33 = tmpvar_39.zw;
    segment_rect_p0_32 = (tmpvar_39.xy + tmpvar_8.xy);
    segment_data_34 = texelFetchOffset (sGpuCache, tmpvar_38, 0, ivec2(1, 0));
  };
  if (transform_is_axis_aligned_16) {
    vec2 tmpvar_40;
    tmpvar_40 = min (max ((segment_rect_p0_32 + 
      (segment_rect_size_33 * aPosition)
    ), tmpvar_9.xy), (tmpvar_9.xy + tmpvar_9.zw));
    vec4 tmpvar_41;
    tmpvar_41.zw = vec2(0.0, 1.0);
    tmpvar_41.xy = tmpvar_40;
    vec4 tmpvar_42;
    tmpvar_42 = (transform_m_15 * tmpvar_41);
    vec4 tmpvar_43;
    tmpvar_43.xy = ((tmpvar_42.xy * tmpvar_21.y) + ((
      -(tmpvar_21.zw)
     + tmpvar_20.xy) * tmpvar_42.w));
    tmpvar_43.z = (ph_z_6 * tmpvar_42.w);
    tmpvar_43.w = tmpvar_42.w;
    gl_Position = (uTransform * tmpvar_43);
    vi_local_pos_30 = tmpvar_40;
    vi_world_pos_31 = tmpvar_42;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    vec4 tmpvar_44;
    tmpvar_44 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_35 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 result_p1_45;
    result_p1_45 = (tmpvar_9.xy + tmpvar_9.zw);
    vec4 tmpvar_46;
    tmpvar_46 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_44);
    vec2 tmpvar_47;
    tmpvar_47 = ((segment_rect_p0_32 - tmpvar_46.xy) + ((segment_rect_size_33 + 
      (tmpvar_46.xy + tmpvar_46.zw)
    ) * aPosition));
    vec4 tmpvar_48;
    tmpvar_48.zw = vec2(0.0, 1.0);
    tmpvar_48.xy = tmpvar_47;
    vec4 tmpvar_49;
    tmpvar_49 = (transform_m_15 * tmpvar_48);
    vec4 tmpvar_50;
    tmpvar_50.xy = ((tmpvar_49.xy * tmpvar_21.y) + ((tmpvar_20.xy - tmpvar_21.zw) * tmpvar_49.w));
    tmpvar_50.z = (ph_z_6 * tmpvar_49.w);
    tmpvar_50.w = tmpvar_49.w;
    gl_Position = (uTransform * tmpvar_50);
    vec4 tmpvar_51;
    tmpvar_51.xy = min (max (tmpvar_8.xy, tmpvar_9.xy), result_p1_45);
    tmpvar_51.zw = min (max ((tmpvar_8.xy + tmpvar_8.zw), tmpvar_9.xy), result_p1_45);
    vec4 tmpvar_52;
    tmpvar_52.xy = min (max (segment_rect_p0_32, tmpvar_9.xy), result_p1_45);
    tmpvar_52.zw = min (max ((segment_rect_p0_32 + segment_rect_size_33), tmpvar_9.xy), result_p1_45);
    vTransformBounds = mix (tmpvar_51, tmpvar_52, tmpvar_44);
    vi_local_pos_30 = tmpvar_47;
    vi_world_pos_31 = tmpvar_49;
  };
  vec4 tmpvar_53;
  tmpvar_53.xy = area_common_data_task_rect_22.p0;
  tmpvar_53.zw = (area_common_data_task_rect_22.p0 + area_common_data_task_rect_22.size);
  vClipMaskUvBounds = tmpvar_53;
  vec4 tmpvar_54;
  tmpvar_54.xy = ((vi_world_pos_31.xy * area_device_pixel_scale_24) + (vi_world_pos_31.w * (area_common_data_task_rect_22.p0 - area_screen_origin_25)));
  tmpvar_54.z = area_common_data_texture_layer_index_23;
  tmpvar_54.w = vi_world_pos_31.w;
  vClipMaskUv = tmpvar_54;
  int color_mode_55;
  vec2 f_56;
  vec2 stretch_size_57;
  vec2 local_rect_p0_58;
  vec2 local_rect_size_59;
  vec2 uv1_60;
  vec2 uv0_61;
  vec4 image_data_color_62;
  ivec2 tmpvar_63;
  tmpvar_63.x = int((uint(tmpvar_13.y) % 1024u));
  tmpvar_63.y = int((uint(tmpvar_13.y) / 1024u));
  vec4 tmpvar_64;
  vec4 tmpvar_65;
  tmpvar_64 = texelFetchOffset (sGpuCache, tmpvar_63, 0, ivec2(1, 0));
  tmpvar_65 = texelFetchOffset (sGpuCache, tmpvar_63, 0, ivec2(2, 0));
  image_data_color_62 = texelFetchOffset (sGpuCache, tmpvar_63, 0, ivec2(0, 0));
  vec2 tmpvar_66;
  tmpvar_66 = vec3(textureSize (sColor0, 0)).xy;
  ivec2 tmpvar_67;
  tmpvar_67.x = int((uint(instance_resource_address_5) % 1024u));
  tmpvar_67.y = int((uint(instance_resource_address_5) / 1024u));
  vec4 tmpvar_68;
  tmpvar_68 = texelFetchOffset (sGpuCache, tmpvar_67, 0, ivec2(0, 0));
  float tmpvar_69;
  tmpvar_69 = texelFetchOffset (sGpuCache, tmpvar_67, 0, ivec2(1, 0)).x;
  uv0_61 = tmpvar_68.xy;
  uv1_60 = tmpvar_68.zw;
  local_rect_p0_58 = tmpvar_10;
  local_rect_size_59 = tmpvar_11;
  stretch_size_57 = tmpvar_65.xy;
  if ((tmpvar_65.x < 0.0)) {
    stretch_size_57 = tmpvar_11;
  };
  if (((tmpvar_36 & 2) != 0)) {
    local_rect_p0_58 = segment_rect_p0_32;
    local_rect_size_59 = segment_rect_size_33;
    stretch_size_57 = segment_rect_size_33;
    if (((tmpvar_36 & 128) != 0)) {
      vec2 original_stretch_size_70;
      vec2 segment_uv_size_71;
      vec2 tmpvar_72;
      tmpvar_72 = (tmpvar_68.zw - tmpvar_68.xy);
      uv0_61 = (tmpvar_68.xy + (segment_data_34.xy * tmpvar_72));
      uv1_60 = (tmpvar_68.xy + (segment_data_34.zw * tmpvar_72));
      segment_uv_size_71 = (uv1_60 - uv0_61);
      if (((tmpvar_36 & 64) != 0)) {
        segment_uv_size_71 = (uv0_61 - tmpvar_68.xy);
        stretch_size_57 = (segment_rect_p0_32 - tmpvar_8.xy);
        if (((segment_uv_size_71.x < 0.001) || (stretch_size_57.x < 0.001))) {
          segment_uv_size_71.x = (tmpvar_68.z - uv1_60.x);
          stretch_size_57.x = (((tmpvar_8.x + tmpvar_8.z) - segment_rect_p0_32.x) - segment_rect_size_33.x);
        };
        if (((segment_uv_size_71.y < 0.001) || (stretch_size_57.y < 0.001))) {
          segment_uv_size_71.y = (tmpvar_68.w - uv1_60.y);
          stretch_size_57.y = (((tmpvar_8.y + tmpvar_8.w) - segment_rect_p0_32.y) - segment_rect_size_33.y);
        };
      };
      original_stretch_size_70 = stretch_size_57;
      if (((tmpvar_36 & 4) != 0)) {
        stretch_size_57.x = ((stretch_size_57.y / segment_uv_size_71.y) * segment_uv_size_71.x);
      };
      if (((tmpvar_36 & 8) != 0)) {
        stretch_size_57.y = ((original_stretch_size_70.x / segment_uv_size_71.x) * segment_uv_size_71.y);
      };
    } else {
      if (((tmpvar_36 & 4) != 0)) {
        stretch_size_57.x = (segment_data_34.z - segment_data_34.x);
      };
      if (((tmpvar_36 & 8) != 0)) {
        stretch_size_57.y = (segment_data_34.w - segment_data_34.y);
      };
    };
    if (((tmpvar_36 & 16) != 0)) {
      stretch_size_57.x = (segment_rect_size_33.x / max (1.0, roundEven(
        (segment_rect_size_33.x / stretch_size_57.x)
      )));
    };
    if (((tmpvar_36 & 32) != 0)) {
      stretch_size_57.y = (segment_rect_size_33.y / max (1.0, roundEven(
        (segment_rect_size_33.y / stretch_size_57.y)
      )));
    };
  };
  float tmpvar_73;
  if (((tmpvar_36 & 1) != 0)) {
    tmpvar_73 = 1.0;
  } else {
    tmpvar_73 = 0.0;
  };
  flat_varying_vec4_4.x = tmpvar_69;
  flat_varying_vec4_4.y = tmpvar_73;
  vec2 tmpvar_74;
  tmpvar_74 = min (uv0_61, uv1_60);
  vec2 tmpvar_75;
  tmpvar_75 = max (uv0_61, uv1_60);
  vec4 tmpvar_76;
  tmpvar_76.xy = (tmpvar_74 + vec2(0.5, 0.5));
  tmpvar_76.zw = (tmpvar_75 - vec2(0.5, 0.5));
  flat_varying_vec4_3 = (tmpvar_76 / tmpvar_66.xyxy);
  f_56 = ((vi_local_pos_30 - local_rect_p0_58) / local_rect_size_59);
  int tmpvar_77;
  tmpvar_77 = (tmpvar_14.x & 65535);
  color_mode_55 = tmpvar_77;
  int tmpvar_78;
  tmpvar_78 = (tmpvar_14.x >> 16);
  if ((tmpvar_77 == 0)) {
    color_mode_55 = uMode;
  };
  bool tmpvar_79;
  tmpvar_79 = bool(0);
  while (true) {
    tmpvar_79 = (tmpvar_79 || (1 == tmpvar_14.y));
    if (tmpvar_79) {
      int tmpvar_80;
      tmpvar_80 = (instance_resource_address_5 + 2);
      ivec2 tmpvar_81;
      tmpvar_81.x = int((uint(tmpvar_80) % 1024u));
      tmpvar_81.y = int((uint(tmpvar_80) / 1024u));
      vec4 tmpvar_82;
      tmpvar_82 = mix (mix (texelFetchOffset (sGpuCache, tmpvar_81, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_81, 0, ivec2(1, 0)), f_56.x), mix (texelFetchOffset (sGpuCache, tmpvar_81, 0, ivec2(2, 0)), texelFetchOffset (sGpuCache, tmpvar_81, 0, ivec2(3, 0)), f_56.x), f_56.y);
      f_56 = (tmpvar_82.xy / tmpvar_82.w);
      break;
    };
    tmpvar_79 = bool(1);
    break;
  };
  vec2 tmpvar_83;
  tmpvar_83 = (local_rect_size_59 / stretch_size_57);
  varying_vec4_0.zw = (mix (uv0_61, uv1_60, f_56) - tmpvar_74);
  varying_vec4_0.zw = (varying_vec4_0.zw / tmpvar_66);
  varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_83);
  if ((tmpvar_73 == 0.0)) {
    varying_vec4_0.zw = (varying_vec4_0.zw * vi_world_pos_31.w);
  };
  vec4 tmpvar_84;
  tmpvar_84.xy = tmpvar_74;
  tmpvar_84.zw = tmpvar_75;
  flat_varying_vec4_2 = (tmpvar_84 / tmpvar_66.xyxy);
  flat_varying_vec4_1.zw = tmpvar_83;
  float tmpvar_85;
  tmpvar_85 = (float(tmpvar_14.z) / 65535.0);
  bool tmpvar_86;
  tmpvar_86 = bool(0);
  while (true) {
    tmpvar_86 = (tmpvar_86 || (0 == tmpvar_78));
    if (tmpvar_86) {
      image_data_color_62.w = (image_data_color_62.w * tmpvar_85);
      break;
    };
    tmpvar_86 = bool(1);
    image_data_color_62 = (image_data_color_62 * tmpvar_85);
    break;
  };
  bool tmpvar_87;
  tmpvar_87 = bool(0);
  while (true) {
    tmpvar_87 = (tmpvar_87 || (1 == color_mode_55));
    tmpvar_87 = (tmpvar_87 || (7 == color_mode_55));
    if (tmpvar_87) {
      flat_varying_vec4_1.xy = vec2(0.0, 1.0);
      flat_varying_vec4_0 = image_data_color_62;
      break;
    };
    tmpvar_87 = (tmpvar_87 || (5 == color_mode_55));
    tmpvar_87 = (tmpvar_87 || (6 == color_mode_55));
    tmpvar_87 = (tmpvar_87 || (9 == color_mode_55));
    if (tmpvar_87) {
      flat_varying_vec4_1.xy = vec2(1.0, 0.0);
      flat_varying_vec4_0 = image_data_color_62;
      break;
    };
    tmpvar_87 = (tmpvar_87 || (2 == color_mode_55));
    tmpvar_87 = (tmpvar_87 || (3 == color_mode_55));
    tmpvar_87 = (tmpvar_87 || (8 == color_mode_55));
    if (tmpvar_87) {
      flat_varying_vec4_1.xy = vec2(1.0, 0.0);
      flat_varying_vec4_0 = image_data_color_62.wwww;
      break;
    };
    tmpvar_87 = (tmpvar_87 || (4 == color_mode_55));
    if (tmpvar_87) {
      flat_varying_vec4_1.xy = vec2(-1.0, 1.0);
      flat_varying_vec4_0 = (image_data_color_62.wwww * tmpvar_64);
      break;
    };
    tmpvar_87 = bool(1);
    flat_varying_vec4_1.xy = vec2(0.0, 0.0);
    flat_varying_vec4_0 = vec4(1.0, 1.0, 1.0, 1.0);
    break;
  };
  varying_vec4_0.xy = vi_local_pos_30;
}

