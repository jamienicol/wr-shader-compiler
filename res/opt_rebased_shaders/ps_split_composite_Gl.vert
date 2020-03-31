#version 150
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
uniform sampler2D sTransformPalette;
uniform sampler2DArray sPrevPassColor;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
out vec2 vUv;
flat out vec2 vLayerAndPerspective;
flat out vec4 vUvSampleBounds;
void main ()
{
  float ci_z_1;
  ci_z_1 = float(aData.z);
  ivec2 tmpvar_2;
  tmpvar_2.x = int((uint(aData.y) % 1024u));
  tmpvar_2.y = int((uint(aData.y) / 1024u));
  vec4 tmpvar_3;
  tmpvar_3 = texelFetchOffset (sGpuCache, tmpvar_2, 0, ivec2(0, 0));
  vec4 tmpvar_4;
  tmpvar_4 = texelFetchOffset (sGpuCache, tmpvar_2, 0, ivec2(1, 0));
  ivec2 tmpvar_5;
  tmpvar_5.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_5.y = int((uint(aData.x) / 512u));
  vec4 tmpvar_6;
  tmpvar_6 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_5, 0, ivec2(0, 0));
  ivec2 tmpvar_7;
  tmpvar_7.x = int((2u * (
    uint(aData.x)
   % 512u)));
  tmpvar_7.y = int((uint(aData.x) / 512u));
  ivec4 tmpvar_8;
  tmpvar_8 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_7, 0, ivec2(1, 0));
  ivec2 tmpvar_9;
  tmpvar_9.x = int((2u * (
    uint(aData.w)
   % 512u)));
  tmpvar_9.y = int((uint(aData.w) / 512u));
  vec4 tmpvar_10;
  tmpvar_10 = texelFetchOffset (sRenderTasks, tmpvar_9, 0, ivec2(0, 0));
  vec4 tmpvar_11;
  tmpvar_11 = texelFetchOffset (sRenderTasks, tmpvar_9, 0, ivec2(1, 0));
  mat4 transform_m_12;
  int tmpvar_13;
  tmpvar_13 = (texelFetchOffset (sPrimitiveHeadersI, tmpvar_7, 0, ivec2(0, 0)).z & 16777215);
  ivec2 tmpvar_14;
  tmpvar_14.x = int((8u * (
    uint(tmpvar_13)
   % 128u)));
  tmpvar_14.y = int((uint(tmpvar_13) / 128u));
  transform_m_12[0] = texelFetchOffset (sTransformPalette, tmpvar_14, 0, ivec2(0, 0));
  transform_m_12[1] = texelFetchOffset (sTransformPalette, tmpvar_14, 0, ivec2(1, 0));
  transform_m_12[2] = texelFetchOffset (sTransformPalette, tmpvar_14, 0, ivec2(2, 0));
  transform_m_12[3] = texelFetchOffset (sTransformPalette, tmpvar_14, 0, ivec2(3, 0));
  ivec2 tmpvar_15;
  tmpvar_15.x = int((uint(tmpvar_8.x) % 1024u));
  tmpvar_15.y = int((uint(tmpvar_8.x) / 1024u));
  vec4 tmpvar_16;
  tmpvar_16 = texelFetchOffset (sGpuCache, tmpvar_15, 0, ivec2(0, 0));
  float tmpvar_17;
  tmpvar_17 = texelFetchOffset (sGpuCache, tmpvar_15, 0, ivec2(1, 0)).x;
  RectWithSize area_common_data_task_rect_18;
  float area_common_data_texture_layer_index_19;
  float area_device_pixel_scale_20;
  vec2 area_screen_origin_21;
  if ((tmpvar_8.w >= 32767)) {
    area_common_data_task_rect_18 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    area_common_data_texture_layer_index_19 = 0.0;
    area_device_pixel_scale_20 = 0.0;
    area_screen_origin_21 = vec2(0.0, 0.0);
  } else {
    ivec2 tmpvar_22;
    tmpvar_22.x = int((2u * (
      uint(tmpvar_8.w)
     % 512u)));
    tmpvar_22.y = int((uint(tmpvar_8.w) / 512u));
    vec4 tmpvar_23;
    tmpvar_23 = texelFetchOffset (sRenderTasks, tmpvar_22, 0, ivec2(0, 0));
    vec4 tmpvar_24;
    tmpvar_24 = texelFetchOffset (sRenderTasks, tmpvar_22, 0, ivec2(1, 0));
    vec3 tmpvar_25;
    tmpvar_25 = tmpvar_24.yzw;
    area_common_data_task_rect_18.p0 = tmpvar_23.xy;
    area_common_data_task_rect_18.size = tmpvar_23.zw;
    area_common_data_texture_layer_index_19 = tmpvar_24.x;
    area_device_pixel_scale_20 = tmpvar_25.x;
    area_screen_origin_21 = tmpvar_25.yz;
  };
  vec2 tmpvar_26;
  tmpvar_26 = mix (mix (tmpvar_3.xy, tmpvar_3.zw, aPosition.x), mix (tmpvar_4.zw, tmpvar_4.xy, aPosition.x), aPosition.y);
  vec4 tmpvar_27;
  tmpvar_27.zw = vec2(0.0, 1.0);
  tmpvar_27.xy = tmpvar_26;
  vec4 tmpvar_28;
  tmpvar_28 = (transform_m_12 * tmpvar_27);
  vec4 tmpvar_29;
  tmpvar_29.xy = (((tmpvar_10.xy - tmpvar_11.zw) * tmpvar_28.w) + (tmpvar_28.xy * tmpvar_11.y));
  tmpvar_29.z = (tmpvar_28.w * ci_z_1);
  tmpvar_29.w = tmpvar_28.w;
  vec4 tmpvar_30;
  tmpvar_30.xy = area_common_data_task_rect_18.p0;
  tmpvar_30.zw = (area_common_data_task_rect_18.p0 + area_common_data_task_rect_18.size);
  vClipMaskUvBounds = tmpvar_30;
  vec4 tmpvar_31;
  tmpvar_31.xy = ((tmpvar_28.xy * area_device_pixel_scale_20) + (tmpvar_28.w * (area_common_data_task_rect_18.p0 - area_screen_origin_21)));
  tmpvar_31.z = area_common_data_texture_layer_index_19;
  tmpvar_31.w = tmpvar_28.w;
  vClipMaskUv = tmpvar_31;
  gl_Position = (uTransform * tmpvar_29);
  vec2 tmpvar_32;
  tmpvar_32 = vec3(textureSize (sPrevPassColor, 0)).xy;
  vec4 tmpvar_33;
  tmpvar_33.xy = (min (tmpvar_16.xy, tmpvar_16.zw) + vec2(0.5, 0.5));
  tmpvar_33.zw = (max (tmpvar_16.xy, tmpvar_16.zw) - vec2(0.5, 0.5));
  vUvSampleBounds = (tmpvar_33 / tmpvar_32.xyxy);
  vec2 tmpvar_34;
  tmpvar_34 = ((tmpvar_26 - tmpvar_6.xy) / tmpvar_6.zw);
  int tmpvar_35;
  tmpvar_35 = (tmpvar_8.x + 2);
  ivec2 tmpvar_36;
  tmpvar_36.x = int((uint(tmpvar_35) % 1024u));
  tmpvar_36.y = int((uint(tmpvar_35) / 1024u));
  vec4 tmpvar_37;
  tmpvar_37 = mix (mix (texelFetchOffset (sGpuCache, tmpvar_36, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_36, 0, ivec2(1, 0)), tmpvar_34.x), mix (texelFetchOffset (sGpuCache, tmpvar_36, 0, ivec2(2, 0)), texelFetchOffset (sGpuCache, tmpvar_36, 0, ivec2(3, 0)), tmpvar_34.x), tmpvar_34.y);
  float tmpvar_38;
  tmpvar_38 = float(tmpvar_8.y);
  vUv = ((mix (tmpvar_16.xy, tmpvar_16.zw, 
    (tmpvar_37.xy / tmpvar_37.w)
  ) / tmpvar_32) * mix (gl_Position.w, 1.0, tmpvar_38));
  vec2 tmpvar_39;
  tmpvar_39.x = tmpvar_17;
  tmpvar_39.y = tmpvar_38;
  vLayerAndPerspective = tmpvar_39;
}

