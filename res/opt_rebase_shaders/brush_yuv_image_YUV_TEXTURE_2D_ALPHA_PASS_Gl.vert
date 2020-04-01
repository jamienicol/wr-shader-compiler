#version 150
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sColor2;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
out vec2 vLocalPos;
out vec3 vUv_Y;
flat out vec4 vUvBounds_Y;
out vec3 vUv_U;
flat out vec4 vUvBounds_U;
out vec3 vUv_V;
flat out vec4 vUvBounds_V;
flat out float vCoefficient;
flat out mat3 vYuvColorMatrix;
flat out int vFormat;
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
  int prim_yuv_format_52;
  vec2 f_53;
  f_53 = ((vi_local_pos_29 - tmpvar_7.xy) / tmpvar_7.zw);
  ivec2 tmpvar_54;
  tmpvar_54.x = int((uint(tmpvar_12.y) % 1024u));
  tmpvar_54.y = int((uint(tmpvar_12.y) / 1024u));
  vec4 tmpvar_55;
  tmpvar_55 = texelFetch (sGpuCache, tmpvar_54, 0);
  prim_yuv_format_52 = int(tmpvar_55.z);
  vCoefficient = tmpvar_55.x;
  int tmpvar_56;
  tmpvar_56 = int(tmpvar_55.y);
  mat3 tmpvar_57;
  bool tmpvar_58;
  tmpvar_58 = bool(0);
  bool tmpvar_59;
  tmpvar_59 = bool(0);
  while (true) {
    tmpvar_59 = (tmpvar_59 || (0 == tmpvar_56));
    if (tmpvar_59) {
      tmpvar_57 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.39176, 2.01723, 1.59603, -0.81297, 0.0);
      tmpvar_58 = bool(1);
      break;
    };
    tmpvar_59 = (tmpvar_59 || (1 == tmpvar_56));
    if (tmpvar_59) {
      tmpvar_57 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.21325, 2.1124, 1.79274, -0.53291, 0.0);
      tmpvar_58 = bool(1);
      break;
    };
    tmpvar_59 = bool(1);
    tmpvar_57 = mat3(1.164384, 1.164384, 1.164384, 0.0, -0.1873261, 2.141772, 1.678674, -0.6504243, 0.0);
    tmpvar_58 = bool(1);
    break;
  };
  if (tmpvar_58) {
    tmpvar_58 = bool(1);
  };
  vYuvColorMatrix = tmpvar_57;
  vFormat = prim_yuv_format_52;
  vLocalPos = vi_local_pos_29;
  if ((prim_yuv_format_52 == 1)) {
    ivec2 tmpvar_60;
    tmpvar_60.x = int((uint(tmpvar_13.x) % 1024u));
    tmpvar_60.y = int((uint(tmpvar_13.x) / 1024u));
    vec4 tmpvar_61;
    tmpvar_61 = texelFetchOffset (sGpuCache, tmpvar_60, 0, ivec2(0, 0));
    ivec2 tmpvar_62;
    tmpvar_62.x = int((uint(tmpvar_13.y) % 1024u));
    tmpvar_62.y = int((uint(tmpvar_13.y) / 1024u));
    vec4 tmpvar_63;
    tmpvar_63 = texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(0, 0));
    ivec2 tmpvar_64;
    tmpvar_64.x = int((uint(tmpvar_13.z) % 1024u));
    tmpvar_64.y = int((uint(tmpvar_13.z) / 1024u));
    vec4 tmpvar_65;
    tmpvar_65 = texelFetchOffset (sGpuCache, tmpvar_64, 0, ivec2(0, 0));
    vec2 tmpvar_66;
    tmpvar_66 = vec2(textureSize (sColor0, 0));
    vec3 tmpvar_67;
    tmpvar_67.xy = mix (tmpvar_61.xy, tmpvar_61.zw, f_53);
    tmpvar_67.z = texelFetchOffset (sGpuCache, tmpvar_60, 0, ivec2(1, 0)).x;
    vec4 tmpvar_68;
    tmpvar_68.xy = (tmpvar_61.xy + vec2(0.5, 0.5));
    tmpvar_68.zw = (tmpvar_61.zw - vec2(0.5, 0.5));
    tmpvar_67.xy = (tmpvar_67.xy / tmpvar_66);
    vUv_Y = tmpvar_67;
    vUvBounds_Y = (tmpvar_68 / tmpvar_66.xyxy);
    vec2 tmpvar_69;
    tmpvar_69 = vec2(textureSize (sColor1, 0));
    vec3 tmpvar_70;
    tmpvar_70.xy = mix (tmpvar_63.xy, tmpvar_63.zw, f_53);
    tmpvar_70.z = texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(1, 0)).x;
    vec4 tmpvar_71;
    tmpvar_71.xy = (tmpvar_63.xy + vec2(0.5, 0.5));
    tmpvar_71.zw = (tmpvar_63.zw - vec2(0.5, 0.5));
    tmpvar_70.xy = (tmpvar_70.xy / tmpvar_69);
    vUv_U = tmpvar_70;
    vUvBounds_U = (tmpvar_71 / tmpvar_69.xyxy);
    vec2 tmpvar_72;
    tmpvar_72 = vec2(textureSize (sColor2, 0));
    vec3 tmpvar_73;
    tmpvar_73.xy = mix (tmpvar_65.xy, tmpvar_65.zw, f_53);
    tmpvar_73.z = texelFetchOffset (sGpuCache, tmpvar_64, 0, ivec2(1, 0)).x;
    vec4 tmpvar_74;
    tmpvar_74.xy = (tmpvar_65.xy + vec2(0.5, 0.5));
    tmpvar_74.zw = (tmpvar_65.zw - vec2(0.5, 0.5));
    tmpvar_73.xy = (tmpvar_73.xy / tmpvar_72);
    vUv_V = tmpvar_73;
    vUvBounds_V = (tmpvar_74 / tmpvar_72.xyxy);
  } else {
    if ((prim_yuv_format_52 == 0)) {
      ivec2 tmpvar_75;
      tmpvar_75.x = int((uint(tmpvar_13.x) % 1024u));
      tmpvar_75.y = int((uint(tmpvar_13.x) / 1024u));
      vec4 tmpvar_76;
      tmpvar_76 = texelFetchOffset (sGpuCache, tmpvar_75, 0, ivec2(0, 0));
      ivec2 tmpvar_77;
      tmpvar_77.x = int((uint(tmpvar_13.y) % 1024u));
      tmpvar_77.y = int((uint(tmpvar_13.y) / 1024u));
      vec4 tmpvar_78;
      tmpvar_78 = texelFetchOffset (sGpuCache, tmpvar_77, 0, ivec2(0, 0));
      vec2 tmpvar_79;
      tmpvar_79 = vec2(textureSize (sColor0, 0));
      vec3 tmpvar_80;
      tmpvar_80.xy = mix (tmpvar_76.xy, tmpvar_76.zw, f_53);
      tmpvar_80.z = texelFetchOffset (sGpuCache, tmpvar_75, 0, ivec2(1, 0)).x;
      vec4 tmpvar_81;
      tmpvar_81.xy = (tmpvar_76.xy + vec2(0.5, 0.5));
      tmpvar_81.zw = (tmpvar_76.zw - vec2(0.5, 0.5));
      tmpvar_80.xy = (tmpvar_80.xy / tmpvar_79);
      vUv_Y = tmpvar_80;
      vUvBounds_Y = (tmpvar_81 / tmpvar_79.xyxy);
      vec2 tmpvar_82;
      tmpvar_82 = vec2(textureSize (sColor1, 0));
      vec3 tmpvar_83;
      tmpvar_83.xy = mix (tmpvar_78.xy, tmpvar_78.zw, f_53);
      tmpvar_83.z = texelFetchOffset (sGpuCache, tmpvar_77, 0, ivec2(1, 0)).x;
      vec4 tmpvar_84;
      tmpvar_84.xy = (tmpvar_78.xy + vec2(0.5, 0.5));
      tmpvar_84.zw = (tmpvar_78.zw - vec2(0.5, 0.5));
      tmpvar_83.xy = (tmpvar_83.xy / tmpvar_82);
      vUv_U = tmpvar_83;
      vUvBounds_U = (tmpvar_84 / tmpvar_82.xyxy);
    } else {
      if ((prim_yuv_format_52 == 2)) {
        ivec2 tmpvar_85;
        tmpvar_85.x = int((uint(tmpvar_13.x) % 1024u));
        tmpvar_85.y = int((uint(tmpvar_13.x) / 1024u));
        vec4 tmpvar_86;
        tmpvar_86 = texelFetchOffset (sGpuCache, tmpvar_85, 0, ivec2(0, 0));
        vec2 tmpvar_87;
        tmpvar_87 = vec2(textureSize (sColor0, 0));
        vec3 tmpvar_88;
        tmpvar_88.xy = mix (tmpvar_86.xy, tmpvar_86.zw, f_53);
        tmpvar_88.z = texelFetchOffset (sGpuCache, tmpvar_85, 0, ivec2(1, 0)).x;
        vec4 tmpvar_89;
        tmpvar_89.xy = (tmpvar_86.xy + vec2(0.5, 0.5));
        tmpvar_89.zw = (tmpvar_86.zw - vec2(0.5, 0.5));
        tmpvar_88.xy = (tmpvar_88.xy / tmpvar_87);
        vUv_Y = tmpvar_88;
        vUvBounds_Y = (tmpvar_89 / tmpvar_87.xyxy);
      };
    };
  };
}

