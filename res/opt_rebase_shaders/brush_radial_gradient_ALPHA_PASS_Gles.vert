#version 300 es
precision highp sampler2DArray;
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
flat out highp vec4 vTransformBounds;
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
flat out highp int flat_varying_highp_int_address_0;
void main ()
{
  int instance_picture_task_address_1;
  int instance_clip_address_2;
  int instance_segment_index_3;
  int instance_flags_4;
  instance_picture_task_address_1 = (aData.y >> 16);
  instance_clip_address_2 = (aData.y & 65535);
  instance_segment_index_3 = (aData.z & 65535);
  instance_flags_4 = (aData.z >> 16);
  float ph_z_5;
  ivec2 tmpvar_6;
  tmpvar_6.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_6.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_7;
  tmpvar_7 = texelFetch (sPrimitiveHeadersF, tmpvar_6, 0);
  vec4 tmpvar_8;
  tmpvar_8 = texelFetch (sPrimitiveHeadersF, (tmpvar_6 + ivec2(1, 0)), 0);
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  tmpvar_9 = tmpvar_7.xy;
  tmpvar_10 = tmpvar_7.zw;
  ivec2 tmpvar_11;
  tmpvar_11.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_11.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_12;
  tmpvar_12 = texelFetch (sPrimitiveHeadersI, tmpvar_11, 0);
  ivec4 tmpvar_13;
  tmpvar_13 = texelFetch (sPrimitiveHeadersI, (tmpvar_11 + ivec2(1, 0)), 0);
  ph_z_5 = float(tmpvar_12.x);
  mat4 transform_m_14;
  bool transform_is_axis_aligned_15;
  transform_is_axis_aligned_15 = ((tmpvar_12.z >> 24) == 0);
  int tmpvar_16;
  tmpvar_16 = (tmpvar_12.z & 16777215);
  ivec2 tmpvar_17;
  tmpvar_17.x = int((8u * (
    uint(tmpvar_16)
   % 128u)));
  tmpvar_17.y = int((uint(tmpvar_16) / 128u));
  transform_m_14[0] = texelFetch (sTransformPalette, tmpvar_17, 0);
  transform_m_14[1] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(1, 0)), 0);
  transform_m_14[2] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(2, 0)), 0);
  transform_m_14[3] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(3, 0)), 0);
  ivec2 tmpvar_18;
  tmpvar_18.x = int((2u * (
    uint(instance_picture_task_address_1)
   % 512u)));
  tmpvar_18.y = int((uint(instance_picture_task_address_1) / 512u));
  vec4 tmpvar_19;
  tmpvar_19 = texelFetch (sRenderTasks, tmpvar_18, 0);
  vec4 tmpvar_20;
  tmpvar_20 = texelFetch (sRenderTasks, (tmpvar_18 + ivec2(1, 0)), 0);
  RectWithSize area_common_data_task_rect_21;
  float area_common_data_texture_layer_index_22;
  float area_device_pixel_scale_23;
  vec2 area_screen_origin_24;
  if ((instance_clip_address_2 >= 32767)) {
    area_common_data_task_rect_21 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    area_common_data_texture_layer_index_22 = 0.0;
    area_device_pixel_scale_23 = 0.0;
    area_screen_origin_24 = vec2(0.0, 0.0);
  } else {
    ivec2 tmpvar_25;
    tmpvar_25.x = int((2u * (
      uint(instance_clip_address_2)
     % 512u)));
    tmpvar_25.y = int((uint(instance_clip_address_2) / 512u));
    vec4 tmpvar_26;
    tmpvar_26 = texelFetch (sRenderTasks, tmpvar_25, 0);
    vec4 tmpvar_27;
    tmpvar_27 = texelFetch (sRenderTasks, (tmpvar_25 + ivec2(1, 0)), 0);
    vec3 tmpvar_28;
    tmpvar_28 = tmpvar_27.yzw;
    area_common_data_task_rect_21.p0 = tmpvar_26.xy;
    area_common_data_task_rect_21.size = tmpvar_26.zw;
    area_common_data_texture_layer_index_22 = tmpvar_27.x;
    area_device_pixel_scale_23 = tmpvar_28.x;
    area_screen_origin_24 = tmpvar_28.yz;
  };
  vec2 vi_local_pos_29;
  vec4 vi_world_pos_30;
  vec2 segment_rect_p0_31;
  vec2 segment_rect_size_32;
  highp vec4 segment_data_33;
  int tmpvar_34;
  tmpvar_34 = (instance_flags_4 & 255);
  int tmpvar_35;
  tmpvar_35 = ((instance_flags_4 >> 8) & 255);
  if ((instance_segment_index_3 == 65535)) {
    segment_rect_p0_31 = tmpvar_9;
    segment_rect_size_32 = tmpvar_10;
    segment_data_33 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    int tmpvar_36;
    tmpvar_36 = ((tmpvar_12.y + 2) + (instance_segment_index_3 * 2));
    ivec2 tmpvar_37;
    tmpvar_37.x = int((uint(tmpvar_36) % 1024u));
    tmpvar_37.y = int((uint(tmpvar_36) / 1024u));
    vec4 tmpvar_38;
    tmpvar_38 = texelFetch (sGpuCache, tmpvar_37, 0);
    segment_rect_size_32 = tmpvar_38.zw;
    segment_rect_p0_31 = (tmpvar_38.xy + tmpvar_7.xy);
    segment_data_33 = texelFetch (sGpuCache, (tmpvar_37 + ivec2(1, 0)), 0);
  };
  if (transform_is_axis_aligned_15) {
    vec2 tmpvar_39;
    tmpvar_39 = min (max ((segment_rect_p0_31 + 
      (segment_rect_size_32 * aPosition)
    ), tmpvar_8.xy), (tmpvar_8.xy + tmpvar_8.zw));
    vec4 tmpvar_40;
    tmpvar_40.zw = vec2(0.0, 1.0);
    tmpvar_40.xy = tmpvar_39;
    vec4 tmpvar_41;
    tmpvar_41 = (transform_m_14 * tmpvar_40);
    vec4 tmpvar_42;
    tmpvar_42.xy = ((tmpvar_41.xy * tmpvar_20.y) + ((
      -(tmpvar_20.zw)
     + tmpvar_19.xy) * tmpvar_41.w));
    tmpvar_42.z = (ph_z_5 * tmpvar_41.w);
    tmpvar_42.w = tmpvar_41.w;
    gl_Position = (uTransform * tmpvar_42);
    vi_local_pos_29 = tmpvar_39;
    vi_world_pos_30 = tmpvar_41;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    vec4 tmpvar_43;
    tmpvar_43 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_34 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 result_p1_44;
    result_p1_44 = (tmpvar_8.xy + tmpvar_8.zw);
    vec4 tmpvar_45;
    tmpvar_45 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_43);
    vec2 tmpvar_46;
    tmpvar_46 = ((segment_rect_p0_31 - tmpvar_45.xy) + ((segment_rect_size_32 + 
      (tmpvar_45.xy + tmpvar_45.zw)
    ) * aPosition));
    vec4 tmpvar_47;
    tmpvar_47.zw = vec2(0.0, 1.0);
    tmpvar_47.xy = tmpvar_46;
    vec4 tmpvar_48;
    tmpvar_48 = (transform_m_14 * tmpvar_47);
    vec4 tmpvar_49;
    tmpvar_49.xy = ((tmpvar_48.xy * tmpvar_20.y) + ((tmpvar_19.xy - tmpvar_20.zw) * tmpvar_48.w));
    tmpvar_49.z = (ph_z_5 * tmpvar_48.w);
    tmpvar_49.w = tmpvar_48.w;
    gl_Position = (uTransform * tmpvar_49);
    vec4 tmpvar_50;
    tmpvar_50.xy = min (max (tmpvar_7.xy, tmpvar_8.xy), result_p1_44);
    tmpvar_50.zw = min (max ((tmpvar_7.xy + tmpvar_7.zw), tmpvar_8.xy), result_p1_44);
    vec4 tmpvar_51;
    tmpvar_51.xy = min (max (segment_rect_p0_31, tmpvar_8.xy), result_p1_44);
    tmpvar_51.zw = min (max ((segment_rect_p0_31 + segment_rect_size_32), tmpvar_8.xy), result_p1_44);
    vTransformBounds = mix (tmpvar_50, tmpvar_51, tmpvar_43);
    vi_local_pos_29 = tmpvar_46;
    vi_world_pos_30 = tmpvar_48;
  };
  vec4 tmpvar_52;
  tmpvar_52.xy = area_common_data_task_rect_21.p0;
  tmpvar_52.zw = (area_common_data_task_rect_21.p0 + area_common_data_task_rect_21.size);
  vClipMaskUvBounds = tmpvar_52;
  vec4 tmpvar_53;
  tmpvar_53.xy = ((vi_world_pos_30.xy * area_device_pixel_scale_23) + (vi_world_pos_30.w * (area_common_data_task_rect_21.p0 - area_screen_origin_24)));
  tmpvar_53.z = area_common_data_texture_layer_index_22;
  tmpvar_53.w = vi_world_pos_30.w;
  vClipMaskUv = tmpvar_53;
  ivec2 tmpvar_54;
  tmpvar_54.x = int((uint(tmpvar_12.y) % 1024u));
  tmpvar_54.y = int((uint(tmpvar_12.y) / 1024u));
  vec4 tmpvar_55;
  vec4 tmpvar_56;
  tmpvar_55 = texelFetch (sGpuCache, tmpvar_54, 0);
  tmpvar_56 = texelFetch (sGpuCache, (tmpvar_54 + ivec2(1, 0)), 0);
  int tmpvar_57;
  vec2 tmpvar_58;
  tmpvar_57 = int(tmpvar_56.y);
  tmpvar_58 = tmpvar_56.zw;
  if (((tmpvar_35 & 2) != 0)) {
    varying_vec4_0.zw = ((vi_local_pos_29 - segment_rect_p0_31) / segment_rect_size_32);
    varying_vec4_0.zw = ((varying_vec4_0.zw * (segment_data_33.zw - segment_data_33.xy)) + segment_data_33.xy);
    varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_7.zw);
  } else {
    varying_vec4_0.zw = (vi_local_pos_29 - tmpvar_7.xy);
  };
  flat_varying_vec4_0.x = tmpvar_55.x;
  flat_varying_vec4_0.zw = tmpvar_55.zw;
  varying_vec4_0.w = (varying_vec4_0.w * tmpvar_56.x);
  flat_varying_vec4_0.y = (tmpvar_55.y * tmpvar_56.x);
  flat_varying_vec4_1.x = tmpvar_58.x;
  flat_varying_vec4_1.y = (tmpvar_56.w * tmpvar_56.x);
  flat_varying_highp_int_address_0 = tmpvar_13.x;
  flat_varying_vec4_1.z = float((tmpvar_57 != 0));
  flat_varying_vec4_2.xy = (tmpvar_7.zw / tmpvar_56.zw);
  varying_vec4_0.xy = vi_local_pos_29;
}

