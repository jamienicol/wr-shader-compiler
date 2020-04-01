#version 150
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform mat4 uTransform;
in vec2 aPosition;
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
out vec4 varying_vec4_0;
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
  tmpvar_7 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_6, 0, ivec2(0, 0));
  vec4 tmpvar_8;
  tmpvar_8 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_6, 0, ivec2(1, 0));
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
  tmpvar_12 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_11, 0, ivec2(0, 0));
  ivec4 tmpvar_13;
  tmpvar_13 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_11, 0, ivec2(1, 0));
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
  transform_m_14[0] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(0, 0));
  transform_m_14[1] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(1, 0));
  transform_m_14[2] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(2, 0));
  transform_m_14[3] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(3, 0));
  ivec2 tmpvar_18;
  tmpvar_18.x = int((2u * (
    uint(instance_picture_task_address_1)
   % 512u)));
  tmpvar_18.y = int((uint(instance_picture_task_address_1) / 512u));
  vec4 tmpvar_19;
  tmpvar_19 = texelFetchOffset (sRenderTasks, tmpvar_18, 0, ivec2(0, 0));
  vec4 tmpvar_20;
  tmpvar_20 = texelFetchOffset (sRenderTasks, tmpvar_18, 0, ivec2(1, 0));
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
    tmpvar_26 = texelFetchOffset (sRenderTasks, tmpvar_25, 0, ivec2(0, 0));
    vec4 tmpvar_27;
    tmpvar_27 = texelFetchOffset (sRenderTasks, tmpvar_25, 0, ivec2(1, 0));
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
  int tmpvar_33;
  tmpvar_33 = (instance_flags_4 & 255);
  if ((instance_segment_index_3 == 65535)) {
    segment_rect_p0_31 = tmpvar_9;
    segment_rect_size_32 = tmpvar_10;
  } else {
    int tmpvar_34;
    tmpvar_34 = ((tmpvar_12.y + 1) + (instance_segment_index_3 * 2));
    ivec2 tmpvar_35;
    tmpvar_35.x = int((uint(tmpvar_34) % 1024u));
    tmpvar_35.y = int((uint(tmpvar_34) / 1024u));
    vec4 tmpvar_36;
    tmpvar_36 = texelFetchOffset (sGpuCache, tmpvar_35, 0, ivec2(0, 0));
    segment_rect_size_32 = tmpvar_36.zw;
    segment_rect_p0_31 = (tmpvar_36.xy + tmpvar_7.xy);
  };
  if (transform_is_axis_aligned_15) {
    vec2 tmpvar_37;
    tmpvar_37 = min (max ((segment_rect_p0_31 + 
      (segment_rect_size_32 * aPosition)
    ), tmpvar_8.xy), (tmpvar_8.xy + tmpvar_8.zw));
    vec4 tmpvar_38;
    tmpvar_38.zw = vec2(0.0, 1.0);
    tmpvar_38.xy = tmpvar_37;
    vec4 tmpvar_39;
    tmpvar_39 = (transform_m_14 * tmpvar_38);
    vec4 tmpvar_40;
    tmpvar_40.xy = ((tmpvar_39.xy * tmpvar_20.y) + ((
      -(tmpvar_20.zw)
     + tmpvar_19.xy) * tmpvar_39.w));
    tmpvar_40.z = (ph_z_5 * tmpvar_39.w);
    tmpvar_40.w = tmpvar_39.w;
    gl_Position = (uTransform * tmpvar_40);
    vi_local_pos_29 = tmpvar_37;
    vi_world_pos_30 = tmpvar_39;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    vec4 tmpvar_41;
    tmpvar_41 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_33 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 result_p1_42;
    result_p1_42 = (tmpvar_8.xy + tmpvar_8.zw);
    vec4 tmpvar_43;
    tmpvar_43 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_41);
    vec2 tmpvar_44;
    tmpvar_44 = ((segment_rect_p0_31 - tmpvar_43.xy) + ((segment_rect_size_32 + 
      (tmpvar_43.xy + tmpvar_43.zw)
    ) * aPosition));
    vec4 tmpvar_45;
    tmpvar_45.zw = vec2(0.0, 1.0);
    tmpvar_45.xy = tmpvar_44;
    vec4 tmpvar_46;
    tmpvar_46 = (transform_m_14 * tmpvar_45);
    vec4 tmpvar_47;
    tmpvar_47.xy = ((tmpvar_46.xy * tmpvar_20.y) + ((tmpvar_19.xy - tmpvar_20.zw) * tmpvar_46.w));
    tmpvar_47.z = (ph_z_5 * tmpvar_46.w);
    tmpvar_47.w = tmpvar_46.w;
    gl_Position = (uTransform * tmpvar_47);
    vec4 tmpvar_48;
    tmpvar_48.xy = min (max (tmpvar_7.xy, tmpvar_8.xy), result_p1_42);
    tmpvar_48.zw = min (max ((tmpvar_7.xy + tmpvar_7.zw), tmpvar_8.xy), result_p1_42);
    vec4 tmpvar_49;
    tmpvar_49.xy = min (max (segment_rect_p0_31, tmpvar_8.xy), result_p1_42);
    tmpvar_49.zw = min (max ((segment_rect_p0_31 + segment_rect_size_32), tmpvar_8.xy), result_p1_42);
    vTransformBounds = mix (tmpvar_48, tmpvar_49, tmpvar_41);
    vi_local_pos_29 = tmpvar_44;
    vi_world_pos_30 = tmpvar_46;
  };
  vec4 tmpvar_50;
  tmpvar_50.xy = area_common_data_task_rect_21.p0;
  tmpvar_50.zw = (area_common_data_task_rect_21.p0 + area_common_data_task_rect_21.size);
  vClipMaskUvBounds = tmpvar_50;
  vec4 tmpvar_51;
  tmpvar_51.xy = ((vi_world_pos_30.xy * area_device_pixel_scale_23) + (vi_world_pos_30.w * (area_common_data_task_rect_21.p0 - area_screen_origin_24)));
  tmpvar_51.z = area_common_data_texture_layer_index_22;
  tmpvar_51.w = vi_world_pos_30.w;
  vClipMaskUv = tmpvar_51;
  ivec2 tmpvar_52;
  tmpvar_52.x = int((uint(tmpvar_12.y) % 1024u));
  tmpvar_52.y = int((uint(tmpvar_12.y) / 1024u));
  flat_varying_vec4_0 = (texelFetch (sGpuCache, tmpvar_52, 0) * (float(tmpvar_13.x) / 65535.0));
  varying_vec4_0.xy = vi_local_pos_29;
}

