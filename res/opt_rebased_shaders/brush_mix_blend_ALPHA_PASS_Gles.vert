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
uniform highp sampler2DArray sPrevPassColor;
flat out highp vec4 vClipMaskUvBounds;
out highp vec4 vClipMaskUv;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
flat out highp ivec4 flat_varying_ivec4_0;
out highp vec4 varying_vec4_0;
out highp vec4 varying_vec4_1;
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
  vec4 vi_world_pos_29;
  vec2 segment_rect_p0_30;
  vec2 segment_rect_size_31;
  int tmpvar_32;
  tmpvar_32 = (instance_flags_4 & 255);
  if ((instance_segment_index_3 == 65535)) {
    segment_rect_p0_30 = tmpvar_9;
    segment_rect_size_31 = tmpvar_10;
  } else {
    int tmpvar_33;
    tmpvar_33 = ((tmpvar_12.y + 3) + (instance_segment_index_3 * 2));
    ivec2 tmpvar_34;
    tmpvar_34.x = int((uint(tmpvar_33) % 1024u));
    tmpvar_34.y = int((uint(tmpvar_33) / 1024u));
    vec4 tmpvar_35;
    tmpvar_35 = texelFetch (sGpuCache, tmpvar_34, 0);
    segment_rect_size_31 = tmpvar_35.zw;
    segment_rect_p0_30 = (tmpvar_35.xy + tmpvar_7.xy);
  };
  if (transform_is_axis_aligned_15) {
    vec4 tmpvar_36;
    tmpvar_36.zw = vec2(0.0, 1.0);
    tmpvar_36.xy = min (max ((segment_rect_p0_30 + 
      (segment_rect_size_31 * aPosition)
    ), tmpvar_8.xy), (tmpvar_8.xy + tmpvar_8.zw));
    vec4 tmpvar_37;
    tmpvar_37 = (transform_m_14 * tmpvar_36);
    vec4 tmpvar_38;
    tmpvar_38.xy = ((tmpvar_37.xy * tmpvar_20.y) + ((
      -(tmpvar_20.zw)
     + tmpvar_19.xy) * tmpvar_37.w));
    tmpvar_38.z = (ph_z_5 * tmpvar_37.w);
    tmpvar_38.w = tmpvar_37.w;
    gl_Position = (uTransform * tmpvar_38);
    vi_world_pos_29 = tmpvar_37;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    vec4 tmpvar_39;
    tmpvar_39 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_32 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 result_p1_40;
    result_p1_40 = (tmpvar_8.xy + tmpvar_8.zw);
    vec4 tmpvar_41;
    tmpvar_41 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_39);
    vec4 tmpvar_42;
    tmpvar_42.zw = vec2(0.0, 1.0);
    tmpvar_42.xy = ((segment_rect_p0_30 - tmpvar_41.xy) + ((segment_rect_size_31 + 
      (tmpvar_41.xy + tmpvar_41.zw)
    ) * aPosition));
    vec4 tmpvar_43;
    tmpvar_43 = (transform_m_14 * tmpvar_42);
    vec4 tmpvar_44;
    tmpvar_44.xy = ((tmpvar_43.xy * tmpvar_20.y) + ((tmpvar_19.xy - tmpvar_20.zw) * tmpvar_43.w));
    tmpvar_44.z = (ph_z_5 * tmpvar_43.w);
    tmpvar_44.w = tmpvar_43.w;
    gl_Position = (uTransform * tmpvar_44);
    vec4 tmpvar_45;
    tmpvar_45.xy = min (max (tmpvar_7.xy, tmpvar_8.xy), result_p1_40);
    tmpvar_45.zw = min (max ((tmpvar_7.xy + tmpvar_7.zw), tmpvar_8.xy), result_p1_40);
    vec4 tmpvar_46;
    tmpvar_46.xy = min (max (segment_rect_p0_30, tmpvar_8.xy), result_p1_40);
    tmpvar_46.zw = min (max ((segment_rect_p0_30 + segment_rect_size_31), tmpvar_8.xy), result_p1_40);
    vTransformBounds = mix (tmpvar_45, tmpvar_46, tmpvar_39);
    vi_world_pos_29 = tmpvar_43;
  };
  vec4 tmpvar_47;
  tmpvar_47.xy = area_common_data_task_rect_21.p0;
  tmpvar_47.zw = (area_common_data_task_rect_21.p0 + area_common_data_task_rect_21.size);
  vClipMaskUvBounds = tmpvar_47;
  vec4 tmpvar_48;
  tmpvar_48.xy = ((vi_world_pos_29.xy * area_device_pixel_scale_23) + (vi_world_pos_29.w * (area_common_data_task_rect_21.p0 - area_screen_origin_24)));
  tmpvar_48.z = area_common_data_texture_layer_index_22;
  tmpvar_48.w = vi_world_pos_29.w;
  vClipMaskUv = tmpvar_48;
  vec2 tmpvar_49;
  tmpvar_49 = vec3(textureSize (sPrevPassColor, 0)).xy;
  flat_varying_ivec4_0.x = tmpvar_13.x;
  ivec2 tmpvar_50;
  tmpvar_50.x = int((2u * (
    uint(tmpvar_13.z)
   % 512u)));
  tmpvar_50.y = int((uint(tmpvar_13.z) / 512u));
  vec4 tmpvar_51;
  tmpvar_51 = texelFetch (sRenderTasks, (tmpvar_50 + ivec2(1, 0)), 0);
  varying_vec4_0.xy = (((
    (vi_world_pos_29.xy * (tmpvar_51.y / max (0.0, vi_world_pos_29.w)))
   + texelFetch (sRenderTasks, tmpvar_50, 0).xy) - tmpvar_51.zw) / tmpvar_49);
  varying_vec4_0.w = tmpvar_51.x;
  ivec2 tmpvar_52;
  tmpvar_52.x = int((2u * (
    uint(tmpvar_13.y)
   % 512u)));
  tmpvar_52.y = int((uint(tmpvar_13.y) / 512u));
  varying_vec4_1.xy = (((
    ((vi_world_pos_29.xy * tmpvar_20.y) / max (0.0, vi_world_pos_29.w))
   + texelFetch (sRenderTasks, tmpvar_52, 0).xy) - (tmpvar_51.zw * 
    (tmpvar_20.y / tmpvar_51.y)
  )) / tmpvar_49);
  varying_vec4_1.w = texelFetch (sRenderTasks, (tmpvar_52 + ivec2(1, 0)), 0).x;
}

