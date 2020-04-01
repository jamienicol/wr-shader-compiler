#version 150
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
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
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_0;
flat out mat4 vColorMat;
flat out int vFuncs[4];
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
  int tmpvar_34;
  tmpvar_34 = ((instance_flags_4 >> 8) & 255);
  if ((instance_segment_index_3 == 65535)) {
    segment_rect_p0_31 = tmpvar_9;
    segment_rect_size_32 = tmpvar_10;
  } else {
    int tmpvar_35;
    tmpvar_35 = ((tmpvar_12.y + 3) + (instance_segment_index_3 * 2));
    ivec2 tmpvar_36;
    tmpvar_36.x = int((uint(tmpvar_35) % 1024u));
    tmpvar_36.y = int((uint(tmpvar_35) / 1024u));
    vec4 tmpvar_37;
    tmpvar_37 = texelFetchOffset (sGpuCache, tmpvar_36, 0, ivec2(0, 0));
    segment_rect_size_32 = tmpvar_37.zw;
    segment_rect_p0_31 = (tmpvar_37.xy + tmpvar_7.xy);
  };
  if (transform_is_axis_aligned_15) {
    vec2 tmpvar_38;
    tmpvar_38 = min (max ((segment_rect_p0_31 + 
      (segment_rect_size_32 * aPosition)
    ), tmpvar_8.xy), (tmpvar_8.xy + tmpvar_8.zw));
    vec4 tmpvar_39;
    tmpvar_39.zw = vec2(0.0, 1.0);
    tmpvar_39.xy = tmpvar_38;
    vec4 tmpvar_40;
    tmpvar_40 = (transform_m_14 * tmpvar_39);
    vec4 tmpvar_41;
    tmpvar_41.xy = ((tmpvar_40.xy * tmpvar_20.y) + ((
      -(tmpvar_20.zw)
     + tmpvar_19.xy) * tmpvar_40.w));
    tmpvar_41.z = (ph_z_5 * tmpvar_40.w);
    tmpvar_41.w = tmpvar_40.w;
    gl_Position = (uTransform * tmpvar_41);
    vi_local_pos_29 = tmpvar_38;
    vi_world_pos_30 = tmpvar_40;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    vec4 tmpvar_42;
    tmpvar_42 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_33 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 result_p1_43;
    result_p1_43 = (tmpvar_8.xy + tmpvar_8.zw);
    vec4 tmpvar_44;
    tmpvar_44 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_42);
    vec2 tmpvar_45;
    tmpvar_45 = ((segment_rect_p0_31 - tmpvar_44.xy) + ((segment_rect_size_32 + 
      (tmpvar_44.xy + tmpvar_44.zw)
    ) * aPosition));
    vec4 tmpvar_46;
    tmpvar_46.zw = vec2(0.0, 1.0);
    tmpvar_46.xy = tmpvar_45;
    vec4 tmpvar_47;
    tmpvar_47 = (transform_m_14 * tmpvar_46);
    vec4 tmpvar_48;
    tmpvar_48.xy = ((tmpvar_47.xy * tmpvar_20.y) + ((tmpvar_19.xy - tmpvar_20.zw) * tmpvar_47.w));
    tmpvar_48.z = (ph_z_5 * tmpvar_47.w);
    tmpvar_48.w = tmpvar_47.w;
    gl_Position = (uTransform * tmpvar_48);
    vec4 tmpvar_49;
    tmpvar_49.xy = min (max (tmpvar_7.xy, tmpvar_8.xy), result_p1_43);
    tmpvar_49.zw = min (max ((tmpvar_7.xy + tmpvar_7.zw), tmpvar_8.xy), result_p1_43);
    vec4 tmpvar_50;
    tmpvar_50.xy = min (max (segment_rect_p0_31, tmpvar_8.xy), result_p1_43);
    tmpvar_50.zw = min (max ((segment_rect_p0_31 + segment_rect_size_32), tmpvar_8.xy), result_p1_43);
    vTransformBounds = mix (tmpvar_49, tmpvar_50, tmpvar_42);
    vi_local_pos_29 = tmpvar_45;
    vi_world_pos_30 = tmpvar_47;
  };
  vec4 tmpvar_51;
  tmpvar_51.xy = area_common_data_task_rect_21.p0;
  tmpvar_51.zw = (area_common_data_task_rect_21.p0 + area_common_data_task_rect_21.size);
  vClipMaskUvBounds = tmpvar_51;
  vec4 tmpvar_52;
  tmpvar_52.xy = ((vi_world_pos_30.xy * area_device_pixel_scale_23) + (vi_world_pos_30.w * (area_common_data_task_rect_21.p0 - area_screen_origin_24)));
  tmpvar_52.z = area_common_data_texture_layer_index_22;
  tmpvar_52.w = vi_world_pos_30.w;
  vClipMaskUv = tmpvar_52;
  vec2 uv_rect_p0_53;
  vec2 uv_rect_p1_54;
  ivec2 tmpvar_55;
  tmpvar_55.x = int((uint(tmpvar_13.x) % 1024u));
  tmpvar_55.y = int((uint(tmpvar_13.x) / 1024u));
  vec4 tmpvar_56;
  tmpvar_56 = texelFetchOffset (sGpuCache, tmpvar_55, 0, ivec2(0, 0));
  uv_rect_p0_53 = tmpvar_56.xy;
  uv_rect_p1_54 = tmpvar_56.zw;
  float tmpvar_57;
  tmpvar_57 = texelFetchOffset (sGpuCache, tmpvar_55, 0, ivec2(1, 0)).x;
  vec2 tmpvar_58;
  tmpvar_58 = vec2(textureSize (sColor0, 0).xy);
  vec2 tmpvar_59;
  tmpvar_59 = ((vi_local_pos_29 - tmpvar_7.xy) / tmpvar_7.zw);
  int tmpvar_60;
  tmpvar_60 = (tmpvar_13.x + 2);
  ivec2 tmpvar_61;
  tmpvar_61.x = int((uint(tmpvar_60) % 1024u));
  tmpvar_61.y = int((uint(tmpvar_60) / 1024u));
  vec4 tmpvar_62;
  tmpvar_62 = mix (mix (texelFetchOffset (sGpuCache, tmpvar_61, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_61, 0, ivec2(1, 0)), tmpvar_59.x), mix (texelFetchOffset (sGpuCache, tmpvar_61, 0, ivec2(2, 0)), texelFetchOffset (sGpuCache, tmpvar_61, 0, ivec2(3, 0)), tmpvar_59.x), tmpvar_59.y);
  vec2 tmpvar_63;
  tmpvar_63 = mix (tmpvar_56.xy, tmpvar_56.zw, (tmpvar_62.xy / tmpvar_62.w));
  float tmpvar_64;
  if (((tmpvar_34 & 1) != 0)) {
    tmpvar_64 = 1.0;
  } else {
    tmpvar_64 = 0.0;
  };
  varying_vec4_0.zw = ((tmpvar_63 / tmpvar_58) * mix (vi_world_pos_30.w, 1.0, tmpvar_64));
  flat_varying_vec4_4.x = tmpvar_57;
  flat_varying_vec4_4.y = tmpvar_64;
  vec4 tmpvar_65;
  tmpvar_65.xy = uv_rect_p0_53;
  tmpvar_65.zw = uv_rect_p1_54;
  flat_varying_vec4_2 = (tmpvar_65 / tmpvar_58.xyxy);
  varying_vec4_0.xy = vi_local_pos_29;
  float tmpvar_66;
  tmpvar_66 = (float(tmpvar_13.z) / 65536.0);
  float tmpvar_67;
  tmpvar_67 = (1.0 - tmpvar_66);
  flat_varying_ivec4_0.x = (tmpvar_13.y & 65535);
  flat_varying_vec4_4.z = tmpvar_66;
  vFuncs[0] = ((tmpvar_13.y >> 28) & 15);
  vFuncs[1] = ((tmpvar_13.y >> 24) & 15);
  vFuncs[2] = ((tmpvar_13.y >> 20) & 15);
  vFuncs[3] = ((tmpvar_13.y >> 16) & 15);
  bool tmpvar_68;
  tmpvar_68 = bool(0);
  while (true) {
    int tmpvar_69;
    tmpvar_69 = flat_varying_ivec4_0.x;
    tmpvar_68 = (tmpvar_68 || (1 == flat_varying_ivec4_0.x));
    if (tmpvar_68) {
      vec4 tmpvar_70;
      tmpvar_70.w = 0.0;
      tmpvar_70.x = (0.2126 + (0.7874 * tmpvar_67));
      tmpvar_70.y = (0.2126 - (0.2126 * tmpvar_67));
      tmpvar_70.z = (0.2126 - (0.2126 * tmpvar_67));
      vec4 tmpvar_71;
      tmpvar_71.w = 0.0;
      tmpvar_71.x = (0.7152 - (0.7152 * tmpvar_67));
      tmpvar_71.y = (0.7152 + (0.2848 * tmpvar_67));
      tmpvar_71.z = (0.7152 - (0.7152 * tmpvar_67));
      vec4 tmpvar_72;
      tmpvar_72.w = 0.0;
      tmpvar_72.x = (0.0722 - (0.0722 * tmpvar_67));
      tmpvar_72.y = (0.0722 - (0.0722 * tmpvar_67));
      tmpvar_72.z = (0.0722 + (0.9278 * tmpvar_67));
      mat4 tmpvar_73;
      tmpvar_73[uint(0)] = tmpvar_70;
      tmpvar_73[1u] = tmpvar_71;
      tmpvar_73[2u] = tmpvar_72;
      tmpvar_73[3u] = vec4(0.0, 0.0, 0.0, 1.0);
      vColorMat = tmpvar_73;
      flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
      break;
    };
    tmpvar_68 = (tmpvar_68 || (2 == flat_varying_ivec4_0.x));
    if (tmpvar_68) {
      float tmpvar_74;
      tmpvar_74 = cos(tmpvar_66);
      float tmpvar_75;
      tmpvar_75 = sin(tmpvar_66);
      vec4 tmpvar_76;
      tmpvar_76.w = 0.0;
      tmpvar_76.x = ((0.2126 + (0.7874 * tmpvar_74)) - (0.2126 * tmpvar_75));
      tmpvar_76.y = ((0.2126 - (0.2126 * tmpvar_74)) + (0.143 * tmpvar_75));
      tmpvar_76.z = ((0.2126 - (0.2126 * tmpvar_74)) - (0.7874 * tmpvar_75));
      vec4 tmpvar_77;
      tmpvar_77.w = 0.0;
      tmpvar_77.x = ((0.7152 - (0.7152 * tmpvar_74)) - (0.7152 * tmpvar_75));
      tmpvar_77.y = ((0.7152 + (0.2848 * tmpvar_74)) + (0.14 * tmpvar_75));
      tmpvar_77.z = ((0.7152 - (0.7152 * tmpvar_74)) + (0.7152 * tmpvar_75));
      vec4 tmpvar_78;
      tmpvar_78.w = 0.0;
      tmpvar_78.x = ((0.0722 - (0.0722 * tmpvar_74)) + (0.9278 * tmpvar_75));
      tmpvar_78.y = ((0.0722 - (0.0722 * tmpvar_74)) - (0.283 * tmpvar_75));
      tmpvar_78.z = ((0.0722 + (0.9278 * tmpvar_74)) + (0.0722 * tmpvar_75));
      mat4 tmpvar_79;
      tmpvar_79[uint(0)] = tmpvar_76;
      tmpvar_79[1u] = tmpvar_77;
      tmpvar_79[2u] = tmpvar_78;
      tmpvar_79[3u] = vec4(0.0, 0.0, 0.0, 1.0);
      vColorMat = tmpvar_79;
      flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
      break;
    };
    tmpvar_68 = (tmpvar_68 || (4 == flat_varying_ivec4_0.x));
    if (tmpvar_68) {
      vec4 tmpvar_80;
      tmpvar_80.w = 0.0;
      tmpvar_80.x = ((tmpvar_67 * 0.2126) + tmpvar_66);
      tmpvar_80.y = (tmpvar_67 * 0.2126);
      tmpvar_80.z = (tmpvar_67 * 0.2126);
      vec4 tmpvar_81;
      tmpvar_81.w = 0.0;
      tmpvar_81.x = (tmpvar_67 * 0.7152);
      tmpvar_81.y = ((tmpvar_67 * 0.7152) + tmpvar_66);
      tmpvar_81.z = (tmpvar_67 * 0.7152);
      vec4 tmpvar_82;
      tmpvar_82.w = 0.0;
      tmpvar_82.x = (tmpvar_67 * 0.0722);
      tmpvar_82.y = (tmpvar_67 * 0.0722);
      tmpvar_82.z = ((tmpvar_67 * 0.0722) + tmpvar_66);
      mat4 tmpvar_83;
      tmpvar_83[uint(0)] = tmpvar_80;
      tmpvar_83[1u] = tmpvar_81;
      tmpvar_83[2u] = tmpvar_82;
      tmpvar_83[3u] = vec4(0.0, 0.0, 0.0, 1.0);
      vColorMat = tmpvar_83;
      flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
      break;
    };
    tmpvar_68 = (tmpvar_68 || (5 == flat_varying_ivec4_0.x));
    if (tmpvar_68) {
      vec4 tmpvar_84;
      tmpvar_84.w = 0.0;
      tmpvar_84.x = (0.393 + (0.607 * tmpvar_67));
      tmpvar_84.y = (0.349 - (0.349 * tmpvar_67));
      tmpvar_84.z = (0.272 - (0.272 * tmpvar_67));
      vec4 tmpvar_85;
      tmpvar_85.w = 0.0;
      tmpvar_85.x = (0.769 - (0.769 * tmpvar_67));
      tmpvar_85.y = (0.686 + (0.314 * tmpvar_67));
      tmpvar_85.z = (0.534 - (0.534 * tmpvar_67));
      vec4 tmpvar_86;
      tmpvar_86.w = 0.0;
      tmpvar_86.x = (0.189 - (0.189 * tmpvar_67));
      tmpvar_86.y = (0.168 - (0.168 * tmpvar_67));
      tmpvar_86.z = (0.131 + (0.869 * tmpvar_67));
      mat4 tmpvar_87;
      tmpvar_87[uint(0)] = tmpvar_84;
      tmpvar_87[1u] = tmpvar_85;
      tmpvar_87[2u] = tmpvar_86;
      tmpvar_87[3u] = vec4(0.0, 0.0, 0.0, 1.0);
      vColorMat = tmpvar_87;
      flat_varying_vec4_3 = vec4(0.0, 0.0, 0.0, 0.0);
      break;
    };
    tmpvar_68 = (tmpvar_68 || (7 == flat_varying_ivec4_0.x));
    if (tmpvar_68) {
      ivec2 tmpvar_88;
      tmpvar_88.x = int((uint(tmpvar_13.z) % 1024u));
      tmpvar_88.y = int((uint(tmpvar_13.z) / 1024u));
      int tmpvar_89;
      tmpvar_89 = (tmpvar_13.z + 4);
      ivec2 tmpvar_90;
      tmpvar_90.x = int((uint(tmpvar_89) % 1024u));
      tmpvar_90.y = int((uint(tmpvar_89) / 1024u));
      mat4 tmpvar_91;
      tmpvar_91[uint(0)] = texelFetchOffset (sGpuCache, tmpvar_88, 0, ivec2(0, 0));
      tmpvar_91[1u] = texelFetchOffset (sGpuCache, tmpvar_88, 0, ivec2(1, 0));
      tmpvar_91[2u] = texelFetchOffset (sGpuCache, tmpvar_88, 0, ivec2(2, 0));
      tmpvar_91[3u] = texelFetchOffset (sGpuCache, tmpvar_88, 0, ivec2(3, 0));
      vColorMat = tmpvar_91;
      flat_varying_vec4_3 = texelFetch (sGpuCache, tmpvar_90, 0);
      break;
    };
    tmpvar_68 = (tmpvar_68 || (11 == flat_varying_ivec4_0.x));
    if (tmpvar_68) {
      flat_varying_ivec4_0.y = tmpvar_13.z;
      break;
    };
    tmpvar_68 = (tmpvar_68 || (10 == tmpvar_69));
    if (tmpvar_68) {
      ivec2 tmpvar_92;
      tmpvar_92.x = int((uint(tmpvar_13.z) % 1024u));
      tmpvar_92.y = int((uint(tmpvar_13.z) / 1024u));
      flat_varying_vec4_1 = texelFetch (sGpuCache, tmpvar_92, 0);
      break;
    };
    tmpvar_68 = bool(1);
    break;
  };
}

