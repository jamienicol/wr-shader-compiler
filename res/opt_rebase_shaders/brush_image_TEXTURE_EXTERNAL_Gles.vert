#version 300 es
#extension GL_OES_EGL_image_external_essl3 : enable
precision highp sampler2DArray;
uniform highp mat4 uTransform;
in highp vec2 aPosition;
uniform lowp samplerExternalOES sColor0;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
flat out highp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
flat out highp vec4 flat_varying_vec4_2;
flat out highp vec4 flat_varying_vec4_3;
flat out highp vec4 flat_varying_vec4_4;
out highp vec4 varying_vec4_0;
void main ()
{
  int instance_picture_task_address_1;
  int instance_segment_index_2;
  int instance_flags_3;
  int instance_resource_address_4;
  instance_picture_task_address_1 = (aData.y >> 16);
  instance_segment_index_2 = (aData.z & 65535);
  instance_flags_3 = (aData.z >> 16);
  instance_resource_address_4 = (aData.w & 16777215);
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
  ph_z_5 = float(tmpvar_12.x);
  mat4 transform_m_13;
  bool transform_is_axis_aligned_14;
  transform_is_axis_aligned_14 = ((tmpvar_12.z >> 24) == 0);
  int tmpvar_15;
  tmpvar_15 = (tmpvar_12.z & 16777215);
  ivec2 tmpvar_16;
  tmpvar_16.x = int((8u * (
    uint(tmpvar_15)
   % 128u)));
  tmpvar_16.y = int((uint(tmpvar_15) / 128u));
  transform_m_13[0] = texelFetch (sTransformPalette, tmpvar_16, 0);
  transform_m_13[1] = texelFetch (sTransformPalette, (tmpvar_16 + ivec2(1, 0)), 0);
  transform_m_13[2] = texelFetch (sTransformPalette, (tmpvar_16 + ivec2(2, 0)), 0);
  transform_m_13[3] = texelFetch (sTransformPalette, (tmpvar_16 + ivec2(3, 0)), 0);
  ivec2 tmpvar_17;
  tmpvar_17.x = int((2u * (
    uint(instance_picture_task_address_1)
   % 512u)));
  tmpvar_17.y = int((uint(instance_picture_task_address_1) / 512u));
  vec4 tmpvar_18;
  tmpvar_18 = texelFetch (sRenderTasks, tmpvar_17, 0);
  vec4 tmpvar_19;
  tmpvar_19 = texelFetch (sRenderTasks, (tmpvar_17 + ivec2(1, 0)), 0);
  vec2 vi_local_pos_20;
  vec4 vi_world_pos_21;
  vec2 segment_rect_p0_22;
  vec2 segment_rect_size_23;
  highp vec4 segment_data_24;
  int tmpvar_25;
  tmpvar_25 = (instance_flags_3 & 255);
  int tmpvar_26;
  tmpvar_26 = ((instance_flags_3 >> 8) & 255);
  if ((instance_segment_index_2 == 65535)) {
    segment_rect_p0_22 = tmpvar_9;
    segment_rect_size_23 = tmpvar_10;
    segment_data_24 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    int tmpvar_27;
    tmpvar_27 = ((tmpvar_12.y + 3) + (instance_segment_index_2 * 2));
    ivec2 tmpvar_28;
    tmpvar_28.x = int((uint(tmpvar_27) % 1024u));
    tmpvar_28.y = int((uint(tmpvar_27) / 1024u));
    vec4 tmpvar_29;
    tmpvar_29 = texelFetch (sGpuCache, tmpvar_28, 0);
    segment_rect_size_23 = tmpvar_29.zw;
    segment_rect_p0_22 = (tmpvar_29.xy + tmpvar_7.xy);
    segment_data_24 = texelFetch (sGpuCache, (tmpvar_28 + ivec2(1, 0)), 0);
  };
  if (transform_is_axis_aligned_14) {
    vec2 tmpvar_30;
    tmpvar_30 = min (max ((segment_rect_p0_22 + 
      (segment_rect_size_23 * aPosition)
    ), tmpvar_8.xy), (tmpvar_8.xy + tmpvar_8.zw));
    vec4 tmpvar_31;
    tmpvar_31.zw = vec2(0.0, 1.0);
    tmpvar_31.xy = tmpvar_30;
    vec4 tmpvar_32;
    tmpvar_32 = (transform_m_13 * tmpvar_31);
    vec4 tmpvar_33;
    tmpvar_33.xy = ((tmpvar_32.xy * tmpvar_19.y) + ((
      -(tmpvar_19.zw)
     + tmpvar_18.xy) * tmpvar_32.w));
    tmpvar_33.z = (ph_z_5 * tmpvar_32.w);
    tmpvar_33.w = tmpvar_32.w;
    gl_Position = (uTransform * tmpvar_33);
    vi_local_pos_20 = tmpvar_30;
    vi_world_pos_21 = tmpvar_32;
  } else {
    vec4 tmpvar_34;
    tmpvar_34 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_25 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 result_p1_35;
    result_p1_35 = (tmpvar_8.xy + tmpvar_8.zw);
    vec4 tmpvar_36;
    tmpvar_36 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_34);
    vec2 tmpvar_37;
    tmpvar_37 = ((segment_rect_p0_22 - tmpvar_36.xy) + ((segment_rect_size_23 + 
      (tmpvar_36.xy + tmpvar_36.zw)
    ) * aPosition));
    vec4 tmpvar_38;
    tmpvar_38.zw = vec2(0.0, 1.0);
    tmpvar_38.xy = tmpvar_37;
    vec4 tmpvar_39;
    tmpvar_39 = (transform_m_13 * tmpvar_38);
    vec4 tmpvar_40;
    tmpvar_40.xy = ((tmpvar_39.xy * tmpvar_19.y) + ((tmpvar_18.xy - tmpvar_19.zw) * tmpvar_39.w));
    tmpvar_40.z = (ph_z_5 * tmpvar_39.w);
    tmpvar_40.w = tmpvar_39.w;
    gl_Position = (uTransform * tmpvar_40);
    vec4 tmpvar_41;
    tmpvar_41.xy = min (max (tmpvar_7.xy, tmpvar_8.xy), result_p1_35);
    tmpvar_41.zw = min (max ((tmpvar_7.xy + tmpvar_7.zw), tmpvar_8.xy), result_p1_35);
    vec4 tmpvar_42;
    tmpvar_42.xy = min (max (segment_rect_p0_22, tmpvar_8.xy), result_p1_35);
    tmpvar_42.zw = min (max ((segment_rect_p0_22 + segment_rect_size_23), tmpvar_8.xy), result_p1_35);
    vTransformBounds = mix (tmpvar_41, tmpvar_42, tmpvar_34);
    vi_local_pos_20 = tmpvar_37;
    vi_world_pos_21 = tmpvar_39;
  };
  highp vec2 stretch_size_43;
  vec2 local_rect_p0_44;
  vec2 local_rect_size_45;
  highp vec2 uv1_46;
  highp vec2 uv0_47;
  ivec2 tmpvar_48;
  tmpvar_48.x = int((uint(tmpvar_12.y) % 1024u));
  tmpvar_48.y = int((uint(tmpvar_12.y) / 1024u));
  vec4 tmpvar_49;
  tmpvar_49 = texelFetch (sGpuCache, (tmpvar_48 + ivec2(2, 0)), 0);
  vec2 tmpvar_50;
  tmpvar_50 = vec2(textureSize (sColor0, 0));
  ivec2 tmpvar_51;
  tmpvar_51.x = int((uint(instance_resource_address_4) % 1024u));
  tmpvar_51.y = int((uint(instance_resource_address_4) / 1024u));
  vec4 tmpvar_52;
  tmpvar_52 = texelFetch (sGpuCache, tmpvar_51, 0);
  float tmpvar_53;
  tmpvar_53 = texelFetch (sGpuCache, (tmpvar_51 + ivec2(1, 0)), 0).x;
  uv0_47 = tmpvar_52.xy;
  uv1_46 = tmpvar_52.zw;
  local_rect_p0_44 = tmpvar_9;
  local_rect_size_45 = tmpvar_10;
  stretch_size_43 = tmpvar_49.xy;
  if ((tmpvar_49.x < 0.0)) {
    stretch_size_43 = tmpvar_10;
  };
  if (((tmpvar_26 & 2) != 0)) {
    local_rect_p0_44 = segment_rect_p0_22;
    local_rect_size_45 = segment_rect_size_23;
    stretch_size_43 = segment_rect_size_23;
    if (((tmpvar_26 & 128) != 0)) {
      vec2 tmpvar_54;
      tmpvar_54 = (tmpvar_52.zw - tmpvar_52.xy);
      uv0_47 = (tmpvar_52.xy + (segment_data_24.xy * tmpvar_54));
      uv1_46 = (tmpvar_52.xy + (segment_data_24.zw * tmpvar_54));
    };
  };
  float tmpvar_55;
  if (((tmpvar_26 & 1) != 0)) {
    tmpvar_55 = 1.0;
  } else {
    tmpvar_55 = 0.0;
  };
  flat_varying_vec4_4.x = tmpvar_53;
  flat_varying_vec4_4.y = tmpvar_55;
  vec2 tmpvar_56;
  tmpvar_56 = min (uv0_47, uv1_46);
  vec2 tmpvar_57;
  tmpvar_57 = max (uv0_47, uv1_46);
  vec4 tmpvar_58;
  tmpvar_58.xy = (tmpvar_56 + vec2(0.5, 0.5));
  tmpvar_58.zw = (tmpvar_57 - vec2(0.5, 0.5));
  flat_varying_vec4_3 = (tmpvar_58 / tmpvar_50.xyxy);
  varying_vec4_0.zw = (mix (uv0_47, uv1_46, (
    (vi_local_pos_20 - local_rect_p0_44)
   / local_rect_size_45)) - tmpvar_56);
  varying_vec4_0.zw = (varying_vec4_0.zw / tmpvar_50);
  varying_vec4_0.zw = (varying_vec4_0.zw * (local_rect_size_45 / stretch_size_43));
  if ((tmpvar_55 == 0.0)) {
    varying_vec4_0.zw = (varying_vec4_0.zw * vi_world_pos_21.w);
  };
  vec4 tmpvar_59;
  tmpvar_59.xy = tmpvar_56;
  tmpvar_59.zw = tmpvar_57;
  flat_varying_vec4_2 = (tmpvar_59 / tmpvar_50.xyxy);
}

