#version 150
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2DArray sColor0;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_2;
out vec4 varying_vec4_0;
void main ()
{
  int instance_picture_task_address_1;
  int instance_segment_index_2;
  int instance_flags_3;
  instance_picture_task_address_1 = (aData.y >> 16);
  instance_segment_index_2 = (aData.z & 65535);
  instance_flags_3 = (aData.z >> 16);
  float ph_z_4;
  ivec2 tmpvar_5;
  tmpvar_5.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_5.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_6;
  tmpvar_6 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_5, 0, ivec2(0, 0));
  vec4 tmpvar_7;
  tmpvar_7 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_5, 0, ivec2(1, 0));
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  tmpvar_8 = tmpvar_6.xy;
  tmpvar_9 = tmpvar_6.zw;
  ivec2 tmpvar_10;
  tmpvar_10.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_10.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_11;
  tmpvar_11 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_10, 0, ivec2(0, 0));
  ivec4 tmpvar_12;
  tmpvar_12 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_10, 0, ivec2(1, 0));
  ph_z_4 = float(tmpvar_11.x);
  mat4 transform_m_13;
  bool transform_is_axis_aligned_14;
  transform_is_axis_aligned_14 = ((tmpvar_11.z >> 24) == 0);
  int tmpvar_15;
  tmpvar_15 = (tmpvar_11.z & 16777215);
  ivec2 tmpvar_16;
  tmpvar_16.x = int((8u * (
    uint(tmpvar_15)
   % 128u)));
  tmpvar_16.y = int((uint(tmpvar_15) / 128u));
  transform_m_13[0] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(0, 0));
  transform_m_13[1] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(1, 0));
  transform_m_13[2] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(2, 0));
  transform_m_13[3] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(3, 0));
  ivec2 tmpvar_17;
  tmpvar_17.x = int((2u * (
    uint(instance_picture_task_address_1)
   % 512u)));
  tmpvar_17.y = int((uint(instance_picture_task_address_1) / 512u));
  vec4 tmpvar_18;
  tmpvar_18 = texelFetchOffset (sRenderTasks, tmpvar_17, 0, ivec2(0, 0));
  vec4 tmpvar_19;
  tmpvar_19 = texelFetchOffset (sRenderTasks, tmpvar_17, 0, ivec2(1, 0));
  vec2 vi_local_pos_20;
  vec4 vi_world_pos_21;
  vec2 segment_rect_p0_22;
  vec2 segment_rect_size_23;
  int tmpvar_24;
  tmpvar_24 = (instance_flags_3 & 255);
  int tmpvar_25;
  tmpvar_25 = ((instance_flags_3 >> 8) & 255);
  if ((instance_segment_index_2 == 65535)) {
    segment_rect_p0_22 = tmpvar_8;
    segment_rect_size_23 = tmpvar_9;
  } else {
    int tmpvar_26;
    tmpvar_26 = ((tmpvar_11.y + 3) + (instance_segment_index_2 * 2));
    ivec2 tmpvar_27;
    tmpvar_27.x = int((uint(tmpvar_26) % 1024u));
    tmpvar_27.y = int((uint(tmpvar_26) / 1024u));
    vec4 tmpvar_28;
    tmpvar_28 = texelFetchOffset (sGpuCache, tmpvar_27, 0, ivec2(0, 0));
    segment_rect_size_23 = tmpvar_28.zw;
    segment_rect_p0_22 = (tmpvar_28.xy + tmpvar_6.xy);
  };
  if (transform_is_axis_aligned_14) {
    vec2 tmpvar_29;
    tmpvar_29 = min (max ((segment_rect_p0_22 + 
      (segment_rect_size_23 * aPosition)
    ), tmpvar_7.xy), (tmpvar_7.xy + tmpvar_7.zw));
    vec4 tmpvar_30;
    tmpvar_30.zw = vec2(0.0, 1.0);
    tmpvar_30.xy = tmpvar_29;
    vec4 tmpvar_31;
    tmpvar_31 = (transform_m_13 * tmpvar_30);
    vec4 tmpvar_32;
    tmpvar_32.xy = ((tmpvar_31.xy * tmpvar_19.y) + ((
      -(tmpvar_19.zw)
     + tmpvar_18.xy) * tmpvar_31.w));
    tmpvar_32.z = (ph_z_4 * tmpvar_31.w);
    tmpvar_32.w = tmpvar_31.w;
    gl_Position = (uTransform * tmpvar_32);
    vi_local_pos_20 = tmpvar_29;
    vi_world_pos_21 = tmpvar_31;
  } else {
    vec4 tmpvar_33;
    tmpvar_33 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_24 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 result_p1_34;
    result_p1_34 = (tmpvar_7.xy + tmpvar_7.zw);
    vec4 tmpvar_35;
    tmpvar_35 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_33);
    vec2 tmpvar_36;
    tmpvar_36 = ((segment_rect_p0_22 - tmpvar_35.xy) + ((segment_rect_size_23 + 
      (tmpvar_35.xy + tmpvar_35.zw)
    ) * aPosition));
    vec4 tmpvar_37;
    tmpvar_37.zw = vec2(0.0, 1.0);
    tmpvar_37.xy = tmpvar_36;
    vec4 tmpvar_38;
    tmpvar_38 = (transform_m_13 * tmpvar_37);
    vec4 tmpvar_39;
    tmpvar_39.xy = ((tmpvar_38.xy * tmpvar_19.y) + ((tmpvar_18.xy - tmpvar_19.zw) * tmpvar_38.w));
    tmpvar_39.z = (ph_z_4 * tmpvar_38.w);
    tmpvar_39.w = tmpvar_38.w;
    gl_Position = (uTransform * tmpvar_39);
    vec4 tmpvar_40;
    tmpvar_40.xy = min (max (tmpvar_6.xy, tmpvar_7.xy), result_p1_34);
    tmpvar_40.zw = min (max ((tmpvar_6.xy + tmpvar_6.zw), tmpvar_7.xy), result_p1_34);
    vec4 tmpvar_41;
    tmpvar_41.xy = min (max (segment_rect_p0_22, tmpvar_7.xy), result_p1_34);
    tmpvar_41.zw = min (max ((segment_rect_p0_22 + segment_rect_size_23), tmpvar_7.xy), result_p1_34);
    vTransformBounds = mix (tmpvar_40, tmpvar_41, tmpvar_33);
    vi_local_pos_20 = tmpvar_36;
    vi_world_pos_21 = tmpvar_38;
  };
  vec2 uv_rect_p0_42;
  vec2 uv_rect_p1_43;
  ivec2 tmpvar_44;
  tmpvar_44.x = int((uint(tmpvar_12.x) % 1024u));
  tmpvar_44.y = int((uint(tmpvar_12.x) / 1024u));
  vec4 tmpvar_45;
  tmpvar_45 = texelFetchOffset (sGpuCache, tmpvar_44, 0, ivec2(0, 0));
  uv_rect_p0_42 = tmpvar_45.xy;
  uv_rect_p1_43 = tmpvar_45.zw;
  float tmpvar_46;
  tmpvar_46 = texelFetchOffset (sGpuCache, tmpvar_44, 0, ivec2(1, 0)).x;
  vec2 tmpvar_47;
  tmpvar_47 = vec2(textureSize (sColor0, 0).xy);
  vec2 tmpvar_48;
  tmpvar_48 = ((vi_local_pos_20 - tmpvar_6.xy) / tmpvar_6.zw);
  int tmpvar_49;
  tmpvar_49 = (tmpvar_12.x + 2);
  ivec2 tmpvar_50;
  tmpvar_50.x = int((uint(tmpvar_49) % 1024u));
  tmpvar_50.y = int((uint(tmpvar_49) / 1024u));
  vec4 tmpvar_51;
  tmpvar_51 = mix (mix (texelFetchOffset (sGpuCache, tmpvar_50, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_50, 0, ivec2(1, 0)), tmpvar_48.x), mix (texelFetchOffset (sGpuCache, tmpvar_50, 0, ivec2(2, 0)), texelFetchOffset (sGpuCache, tmpvar_50, 0, ivec2(3, 0)), tmpvar_48.x), tmpvar_48.y);
  vec2 tmpvar_52;
  tmpvar_52 = mix (tmpvar_45.xy, tmpvar_45.zw, (tmpvar_51.xy / tmpvar_51.w));
  float tmpvar_53;
  if (((tmpvar_25 & 1) != 0)) {
    tmpvar_53 = 1.0;
  } else {
    tmpvar_53 = 0.0;
  };
  varying_vec4_0.zw = ((tmpvar_52 / tmpvar_47) * mix (vi_world_pos_21.w, 1.0, tmpvar_53));
  flat_varying_vec4_2.x = tmpvar_46;
  flat_varying_vec4_2.y = tmpvar_53;
  vec4 tmpvar_54;
  tmpvar_54.xy = uv_rect_p0_42;
  tmpvar_54.zw = uv_rect_p1_43;
  flat_varying_vec4_1 = (tmpvar_54 / tmpvar_47.xyxy);
  varying_vec4_0.xy = vi_local_pos_20;
  flat_varying_vec4_2.z = (float(tmpvar_12.y) / 65536.0);
}

