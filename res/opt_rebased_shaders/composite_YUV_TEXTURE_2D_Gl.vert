#version 150
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sColor2;
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
  tmpvar_4 = min (max ((aDeviceRect.xy + 
    (aPosition * aDeviceRect.zw)
  ), aDeviceClipRect.xy), (aDeviceClipRect.xy + aDeviceClipRect.zw));
  uv_3 = ((tmpvar_4 - aDeviceRect.xy) / aDeviceRect.zw);
  yuv_format_2 = int(aParams.z);
  yuv_coefficient_1 = aParams.w;
  int tmpvar_5;
  tmpvar_5 = int(aParams.y);
  mat3 tmpvar_6;
  bool tmpvar_7;
  tmpvar_7 = bool(0);
  bool tmpvar_8;
  tmpvar_8 = bool(0);
  while (true) {
    tmpvar_8 = (tmpvar_8 || (0 == tmpvar_5));
    if (tmpvar_8) {
      tmpvar_6 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.39176, 2.01723, 1.59603, -0.81297, 0.0);
      tmpvar_7 = bool(1);
      break;
    };
    tmpvar_8 = (tmpvar_8 || (1 == tmpvar_5));
    if (tmpvar_8) {
      tmpvar_6 = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.21325, 2.1124, 1.79274, -0.53291, 0.0);
      tmpvar_7 = bool(1);
      break;
    };
    tmpvar_8 = bool(1);
    tmpvar_6 = mat3(1.164384, 1.164384, 1.164384, 0.0, -0.1873261, 2.141772, 1.678674, -0.6504243, 0.0);
    tmpvar_7 = bool(1);
    break;
  };
  if (tmpvar_7) {
    tmpvar_7 = bool(1);
  };
  vYuvColorMatrix = tmpvar_6;
  vYuvCoefficient = yuv_coefficient_1;
  vYuvFormat = yuv_format_2;
  vec2 tmpvar_9;
  tmpvar_9 = vec2(textureSize (sColor0, 0));
  vec3 tmpvar_10;
  tmpvar_10.xy = mix (aUvRect0.xy, aUvRect0.zw, uv_3);
  tmpvar_10.z = aTextureLayers.x;
  vec4 tmpvar_11;
  tmpvar_11.xy = (aUvRect0.xy + vec2(0.5, 0.5));
  tmpvar_11.zw = (aUvRect0.zw - vec2(0.5, 0.5));
  tmpvar_10.xy = (tmpvar_10.xy / tmpvar_9);
  vUV_y = tmpvar_10;
  vUVBounds_y = (tmpvar_11 / tmpvar_9.xyxy);
  vec2 tmpvar_12;
  tmpvar_12 = vec2(textureSize (sColor1, 0));
  vec3 tmpvar_13;
  tmpvar_13.xy = mix (aUvRect1.xy, aUvRect1.zw, uv_3);
  tmpvar_13.z = aTextureLayers.y;
  vec4 tmpvar_14;
  tmpvar_14.xy = (aUvRect1.xy + vec2(0.5, 0.5));
  tmpvar_14.zw = (aUvRect1.zw - vec2(0.5, 0.5));
  tmpvar_13.xy = (tmpvar_13.xy / tmpvar_12);
  vUV_u = tmpvar_13;
  vUVBounds_u = (tmpvar_14 / tmpvar_12.xyxy);
  vec2 tmpvar_15;
  tmpvar_15 = vec2(textureSize (sColor2, 0));
  vec3 tmpvar_16;
  tmpvar_16.xy = mix (aUvRect2.xy, aUvRect2.zw, uv_3);
  tmpvar_16.z = aTextureLayers.z;
  vec4 tmpvar_17;
  tmpvar_17.xy = (aUvRect2.xy + vec2(0.5, 0.5));
  tmpvar_17.zw = (aUvRect2.zw - vec2(0.5, 0.5));
  tmpvar_16.xy = (tmpvar_16.xy / tmpvar_15);
  vUV_v = tmpvar_16;
  vUVBounds_v = (tmpvar_17 / tmpvar_15.xyxy);
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xy = tmpvar_4;
  tmpvar_18.z = aParams.x;
  gl_Position = (uTransform * tmpvar_18);
}

