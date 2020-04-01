#version 150
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2DArray sColor0;
uniform sampler2DArray sColor1;
uniform sampler2DArray sColor2;
flat out mat3 vYuvColorMatrix;
flat out float vYuvCoefficient;
flat out int vYuvFormat;
out vec3 vUV_y;
out vec3 vUV_u;
out vec3 vUV_v;
flat out vec4 vUVBounds_y;
flat out vec4 vUVBounds_u;
flat out vec4 vUVBounds_v;
in vec4 aDeviceRect;
in vec4 aDeviceClipRect;
in vec4 aParams;
in vec3 aTextureLayers;
in vec4 aUvRect0;
in vec4 aUvRect1;
in vec4 aUvRect2;
void main ()
{
  float yuv_coefficient_1;
  int yuv_format_2;
  vec2 uv_3;
  vec2 tmpvar_4;
  tmpvar_4 = clamp ((aDeviceRect.xy + (aPosition * aDeviceRect.zw)), aDeviceClipRect.xy, (aDeviceClipRect.xy + aDeviceClipRect.zw));
  uv_3 = ((tmpvar_4 - aDeviceRect.xy) / aDeviceRect.zw);
  yuv_format_2 = int(aParams.z);
  yuv_coefficient_1 = aParams.w;
  int color_space_5;
  color_space_5 = int(aParams.y);
  mat3 tmpvar_6;
  bool tmpvar_7;
  tmpvar_7 = bool(0);
  if ((0 == color_space_5)) tmpvar_7 = bool(1);
  if (tmpvar_7) {
    tmpvar_6 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.39176, 2.01723, 1.59603, -0.81297, 0.0);
  } else {
    if ((1 == color_space_5)) tmpvar_7 = bool(1);
    if (tmpvar_7) {
      tmpvar_6 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.21325, 2.1124, 1.79274, -0.53291, 0.0);
    } else {
      tmpvar_7 = bool(1);
      tmpvar_6 = mat3(1.164384, 1.164384, 1.164384, 0.0, -0.1873261, 2.141772, 1.678674, -0.6504243, 0.0);
    };
  };
  vYuvColorMatrix = tmpvar_6;
  vYuvCoefficient = yuv_coefficient_1;
  vYuvFormat = yuv_format_2;
  vec2 tmpvar_8;
  tmpvar_8 = vec2(textureSize (sColor0, 0).xy);
  vec3 uv_9;
  uv_9.xy = mix (aUvRect0.xy, aUvRect0.zw, uv_3);
  uv_9.z = aTextureLayers.x;
  vec4 tmpvar_10;
  tmpvar_10.xy = (aUvRect0.xy + vec2(0.5, 0.5));
  tmpvar_10.zw = (aUvRect0.zw - vec2(0.5, 0.5));
  uv_9.xy = (uv_9.xy / tmpvar_8);
  vUV_y = uv_9;
  vUVBounds_y = (tmpvar_10 / tmpvar_8.xyxy);
  vec2 tmpvar_11;
  tmpvar_11 = vec2(textureSize (sColor1, 0).xy);
  vec3 uv_12;
  uv_12.xy = mix (aUvRect1.xy, aUvRect1.zw, uv_3);
  uv_12.z = aTextureLayers.y;
  vec4 tmpvar_13;
  tmpvar_13.xy = (aUvRect1.xy + vec2(0.5, 0.5));
  tmpvar_13.zw = (aUvRect1.zw - vec2(0.5, 0.5));
  uv_12.xy = (uv_12.xy / tmpvar_11);
  vUV_u = uv_12;
  vUVBounds_u = (tmpvar_13 / tmpvar_11.xyxy);
  vec2 tmpvar_14;
  tmpvar_14 = vec2(textureSize (sColor2, 0).xy);
  vec3 uv_15;
  uv_15.xy = mix (aUvRect2.xy, aUvRect2.zw, uv_3);
  uv_15.z = aTextureLayers.z;
  vec4 tmpvar_16;
  tmpvar_16.xy = (aUvRect2.xy + vec2(0.5, 0.5));
  tmpvar_16.zw = (aUvRect2.zw - vec2(0.5, 0.5));
  uv_15.xy = (uv_15.xy / tmpvar_14);
  vUV_v = uv_15;
  vUVBounds_v = (tmpvar_16 / tmpvar_14.xyxy);
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xy = tmpvar_4;
  tmpvar_17.z = aParams.x;
  gl_Position = (uTransform * tmpvar_17);
}

