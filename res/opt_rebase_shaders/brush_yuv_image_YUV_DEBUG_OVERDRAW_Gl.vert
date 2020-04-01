#version 150
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2DArray sColor0;
uniform sampler2DArray sColor1;
uniform sampler2DArray sColor2;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
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
  int instance_segment_index_2;
  instance_picture_task_address_1 = (aData.y >> 16);
  instance_segment_index_2 = (aData.z & 65535);
  float ph_z_3;
  ivec2 tmpvar_4;
  tmpvar_4.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_4.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_5;
  tmpvar_5 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_4, 0, ivec2(0, 0));
  vec4 tmpvar_6;
  tmpvar_6 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_4, 0, ivec2(1, 0));
  vec2 tmpvar_7;
  vec2 tmpvar_8;
  tmpvar_7 = tmpvar_5.xy;
  tmpvar_8 = tmpvar_5.zw;
  ivec2 tmpvar_9;
  tmpvar_9.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_9.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_10;
  tmpvar_10 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_9, 0, ivec2(0, 0));
  ivec4 tmpvar_11;
  tmpvar_11 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_9, 0, ivec2(1, 0));
  ph_z_3 = float(tmpvar_10.x);
  mat4 transform_m_12;
  bool transform_is_axis_aligned_13;
  transform_is_axis_aligned_13 = ((tmpvar_10.z >> 24) == 0);
  int tmpvar_14;
  tmpvar_14 = (tmpvar_10.z & 16777215);
  ivec2 tmpvar_15;
  tmpvar_15.x = int((8u * (
    uint(tmpvar_14)
   % 128u)));
  tmpvar_15.y = int((uint(tmpvar_14) / 128u));
  transform_m_12[0] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(0, 0));
  transform_m_12[1] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(1, 0));
  transform_m_12[2] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(2, 0));
  transform_m_12[3] = texelFetchOffset (sTransformPalette, tmpvar_15, 0, ivec2(3, 0));
  ivec2 tmpvar_16;
  tmpvar_16.x = int((2u * (
    uint(instance_picture_task_address_1)
   % 512u)));
  tmpvar_16.y = int((uint(instance_picture_task_address_1) / 512u));
  vec4 tmpvar_17;
  tmpvar_17 = texelFetchOffset (sRenderTasks, tmpvar_16, 0, ivec2(0, 0));
  vec4 tmpvar_18;
  tmpvar_18 = texelFetchOffset (sRenderTasks, tmpvar_16, 0, ivec2(1, 0));
  vec2 vi_local_pos_19;
  vec2 segment_rect_p0_20;
  vec2 segment_rect_size_21;
  int tmpvar_22;
  tmpvar_22 = ((aData.z >> 16) & 255);
  if ((instance_segment_index_2 == 65535)) {
    segment_rect_p0_20 = tmpvar_7;
    segment_rect_size_21 = tmpvar_8;
  } else {
    int tmpvar_23;
    tmpvar_23 = ((tmpvar_10.y + 1) + (instance_segment_index_2 * 2));
    ivec2 tmpvar_24;
    tmpvar_24.x = int((uint(tmpvar_23) % 1024u));
    tmpvar_24.y = int((uint(tmpvar_23) / 1024u));
    vec4 tmpvar_25;
    tmpvar_25 = texelFetchOffset (sGpuCache, tmpvar_24, 0, ivec2(0, 0));
    segment_rect_size_21 = tmpvar_25.zw;
    segment_rect_p0_20 = (tmpvar_25.xy + tmpvar_5.xy);
  };
  if (transform_is_axis_aligned_13) {
    vec2 tmpvar_26;
    tmpvar_26 = min (max ((segment_rect_p0_20 + 
      (segment_rect_size_21 * aPosition)
    ), tmpvar_6.xy), (tmpvar_6.xy + tmpvar_6.zw));
    vec4 tmpvar_27;
    tmpvar_27.zw = vec2(0.0, 1.0);
    tmpvar_27.xy = tmpvar_26;
    vec4 tmpvar_28;
    tmpvar_28 = (transform_m_12 * tmpvar_27);
    vec4 tmpvar_29;
    tmpvar_29.xy = ((tmpvar_28.xy * tmpvar_18.y) + ((
      -(tmpvar_18.zw)
     + tmpvar_17.xy) * tmpvar_28.w));
    tmpvar_29.z = (ph_z_3 * tmpvar_28.w);
    tmpvar_29.w = tmpvar_28.w;
    gl_Position = (uTransform * tmpvar_29);
    vi_local_pos_19 = tmpvar_26;
  } else {
    vec4 tmpvar_30;
    tmpvar_30 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_22 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 result_p1_31;
    result_p1_31 = (tmpvar_6.xy + tmpvar_6.zw);
    vec4 tmpvar_32;
    tmpvar_32 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_30);
    vec2 tmpvar_33;
    tmpvar_33 = ((segment_rect_p0_20 - tmpvar_32.xy) + ((segment_rect_size_21 + 
      (tmpvar_32.xy + tmpvar_32.zw)
    ) * aPosition));
    vec4 tmpvar_34;
    tmpvar_34.zw = vec2(0.0, 1.0);
    tmpvar_34.xy = tmpvar_33;
    vec4 tmpvar_35;
    tmpvar_35 = (transform_m_12 * tmpvar_34);
    vec4 tmpvar_36;
    tmpvar_36.xy = ((tmpvar_35.xy * tmpvar_18.y) + ((tmpvar_17.xy - tmpvar_18.zw) * tmpvar_35.w));
    tmpvar_36.z = (ph_z_3 * tmpvar_35.w);
    tmpvar_36.w = tmpvar_35.w;
    gl_Position = (uTransform * tmpvar_36);
    vec4 tmpvar_37;
    tmpvar_37.xy = min (max (tmpvar_5.xy, tmpvar_6.xy), result_p1_31);
    tmpvar_37.zw = min (max ((tmpvar_5.xy + tmpvar_5.zw), tmpvar_6.xy), result_p1_31);
    vec4 tmpvar_38;
    tmpvar_38.xy = min (max (segment_rect_p0_20, tmpvar_6.xy), result_p1_31);
    tmpvar_38.zw = min (max ((segment_rect_p0_20 + segment_rect_size_21), tmpvar_6.xy), result_p1_31);
    vTransformBounds = mix (tmpvar_37, tmpvar_38, tmpvar_30);
    vi_local_pos_19 = tmpvar_33;
  };
  int prim_yuv_format_39;
  vec2 f_40;
  f_40 = ((vi_local_pos_19 - tmpvar_5.xy) / tmpvar_5.zw);
  ivec2 tmpvar_41;
  tmpvar_41.x = int((uint(tmpvar_10.y) % 1024u));
  tmpvar_41.y = int((uint(tmpvar_10.y) / 1024u));
  vec4 tmpvar_42;
  tmpvar_42 = texelFetch (sGpuCache, tmpvar_41, 0);
  prim_yuv_format_39 = int(tmpvar_42.z);
  vCoefficient = tmpvar_42.x;
  int tmpvar_43;
  tmpvar_43 = int(tmpvar_42.y);
  mat3 tmpvar_44;
  bool tmpvar_45;
  tmpvar_45 = bool(0);
  bool tmpvar_46;
  tmpvar_46 = bool(0);
  while (true) {
    tmpvar_46 = (tmpvar_46 || (0 == tmpvar_43));
    if (tmpvar_46) {
      tmpvar_44 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.39176, 2.01723, 1.59603, -0.81297, 0.0);
      tmpvar_45 = bool(1);
      break;
    };
    tmpvar_46 = (tmpvar_46 || (1 == tmpvar_43));
    if (tmpvar_46) {
      tmpvar_44 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.21325, 2.1124, 1.79274, -0.53291, 0.0);
      tmpvar_45 = bool(1);
      break;
    };
    tmpvar_46 = bool(1);
    tmpvar_44 = mat3(1.164384, 1.164384, 1.164384, 0.0, -0.1873261, 2.141772, 1.678674, -0.6504243, 0.0);
    tmpvar_45 = bool(1);
    break;
  };
  if (tmpvar_45) {
    tmpvar_45 = bool(1);
  };
  vYuvColorMatrix = tmpvar_44;
  vFormat = prim_yuv_format_39;
  if ((prim_yuv_format_39 == 1)) {
    ivec2 tmpvar_47;
    tmpvar_47.x = int((uint(tmpvar_11.x) % 1024u));
    tmpvar_47.y = int((uint(tmpvar_11.x) / 1024u));
    vec4 tmpvar_48;
    tmpvar_48 = texelFetchOffset (sGpuCache, tmpvar_47, 0, ivec2(0, 0));
    ivec2 tmpvar_49;
    tmpvar_49.x = int((uint(tmpvar_11.y) % 1024u));
    tmpvar_49.y = int((uint(tmpvar_11.y) / 1024u));
    vec4 tmpvar_50;
    tmpvar_50 = texelFetchOffset (sGpuCache, tmpvar_49, 0, ivec2(0, 0));
    ivec2 tmpvar_51;
    tmpvar_51.x = int((uint(tmpvar_11.z) % 1024u));
    tmpvar_51.y = int((uint(tmpvar_11.z) / 1024u));
    vec4 tmpvar_52;
    tmpvar_52 = texelFetchOffset (sGpuCache, tmpvar_51, 0, ivec2(0, 0));
    vec2 tmpvar_53;
    tmpvar_53 = vec2(textureSize (sColor0, 0).xy);
    vec3 tmpvar_54;
    tmpvar_54.xy = mix (tmpvar_48.xy, tmpvar_48.zw, f_40);
    tmpvar_54.z = texelFetchOffset (sGpuCache, tmpvar_47, 0, ivec2(1, 0)).x;
    vec4 tmpvar_55;
    tmpvar_55.xy = (tmpvar_48.xy + vec2(0.5, 0.5));
    tmpvar_55.zw = (tmpvar_48.zw - vec2(0.5, 0.5));
    tmpvar_54.xy = (tmpvar_54.xy / tmpvar_53);
    vUv_Y = tmpvar_54;
    vUvBounds_Y = (tmpvar_55 / tmpvar_53.xyxy);
    vec2 tmpvar_56;
    tmpvar_56 = vec2(textureSize (sColor1, 0).xy);
    vec3 tmpvar_57;
    tmpvar_57.xy = mix (tmpvar_50.xy, tmpvar_50.zw, f_40);
    tmpvar_57.z = texelFetchOffset (sGpuCache, tmpvar_49, 0, ivec2(1, 0)).x;
    vec4 tmpvar_58;
    tmpvar_58.xy = (tmpvar_50.xy + vec2(0.5, 0.5));
    tmpvar_58.zw = (tmpvar_50.zw - vec2(0.5, 0.5));
    tmpvar_57.xy = (tmpvar_57.xy / tmpvar_56);
    vUv_U = tmpvar_57;
    vUvBounds_U = (tmpvar_58 / tmpvar_56.xyxy);
    vec2 tmpvar_59;
    tmpvar_59 = vec2(textureSize (sColor2, 0).xy);
    vec3 tmpvar_60;
    tmpvar_60.xy = mix (tmpvar_52.xy, tmpvar_52.zw, f_40);
    tmpvar_60.z = texelFetchOffset (sGpuCache, tmpvar_51, 0, ivec2(1, 0)).x;
    vec4 tmpvar_61;
    tmpvar_61.xy = (tmpvar_52.xy + vec2(0.5, 0.5));
    tmpvar_61.zw = (tmpvar_52.zw - vec2(0.5, 0.5));
    tmpvar_60.xy = (tmpvar_60.xy / tmpvar_59);
    vUv_V = tmpvar_60;
    vUvBounds_V = (tmpvar_61 / tmpvar_59.xyxy);
  } else {
    if ((prim_yuv_format_39 == 0)) {
      ivec2 tmpvar_62;
      tmpvar_62.x = int((uint(tmpvar_11.x) % 1024u));
      tmpvar_62.y = int((uint(tmpvar_11.x) / 1024u));
      vec4 tmpvar_63;
      tmpvar_63 = texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(0, 0));
      ivec2 tmpvar_64;
      tmpvar_64.x = int((uint(tmpvar_11.y) % 1024u));
      tmpvar_64.y = int((uint(tmpvar_11.y) / 1024u));
      vec4 tmpvar_65;
      tmpvar_65 = texelFetchOffset (sGpuCache, tmpvar_64, 0, ivec2(0, 0));
      vec2 tmpvar_66;
      tmpvar_66 = vec2(textureSize (sColor0, 0).xy);
      vec3 tmpvar_67;
      tmpvar_67.xy = mix (tmpvar_63.xy, tmpvar_63.zw, f_40);
      tmpvar_67.z = texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(1, 0)).x;
      vec4 tmpvar_68;
      tmpvar_68.xy = (tmpvar_63.xy + vec2(0.5, 0.5));
      tmpvar_68.zw = (tmpvar_63.zw - vec2(0.5, 0.5));
      tmpvar_67.xy = (tmpvar_67.xy / tmpvar_66);
      vUv_Y = tmpvar_67;
      vUvBounds_Y = (tmpvar_68 / tmpvar_66.xyxy);
      vec2 tmpvar_69;
      tmpvar_69 = vec2(textureSize (sColor1, 0).xy);
      vec3 tmpvar_70;
      tmpvar_70.xy = mix (tmpvar_65.xy, tmpvar_65.zw, f_40);
      tmpvar_70.z = texelFetchOffset (sGpuCache, tmpvar_64, 0, ivec2(1, 0)).x;
      vec4 tmpvar_71;
      tmpvar_71.xy = (tmpvar_65.xy + vec2(0.5, 0.5));
      tmpvar_71.zw = (tmpvar_65.zw - vec2(0.5, 0.5));
      tmpvar_70.xy = (tmpvar_70.xy / tmpvar_69);
      vUv_U = tmpvar_70;
      vUvBounds_U = (tmpvar_71 / tmpvar_69.xyxy);
    } else {
      if ((prim_yuv_format_39 == 2)) {
        ivec2 tmpvar_72;
        tmpvar_72.x = int((uint(tmpvar_11.x) % 1024u));
        tmpvar_72.y = int((uint(tmpvar_11.x) / 1024u));
        vec4 tmpvar_73;
        tmpvar_73 = texelFetchOffset (sGpuCache, tmpvar_72, 0, ivec2(0, 0));
        vec2 tmpvar_74;
        tmpvar_74 = vec2(textureSize (sColor0, 0).xy);
        vec3 tmpvar_75;
        tmpvar_75.xy = mix (tmpvar_73.xy, tmpvar_73.zw, f_40);
        tmpvar_75.z = texelFetchOffset (sGpuCache, tmpvar_72, 0, ivec2(1, 0)).x;
        vec4 tmpvar_76;
        tmpvar_76.xy = (tmpvar_73.xy + vec2(0.5, 0.5));
        tmpvar_76.zw = (tmpvar_73.zw - vec2(0.5, 0.5));
        tmpvar_75.xy = (tmpvar_75.xy / tmpvar_74);
        vUv_Y = tmpvar_75;
        vUvBounds_Y = (tmpvar_76 / tmpvar_74.xyxy);
      };
    };
  };
}

