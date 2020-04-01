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
  float tmpvar_1;
  tmpvar_1 = float(aData.z);
  ivec2 tmpvar_2;
  uint tmpvar_3;
  tmpvar_3 = uint(aData.y);
  tmpvar_2.x = int((tmpvar_3 % 1024u));
  tmpvar_2.y = int((tmpvar_3 / 1024u));
  vec4 tmpvar_4;
  tmpvar_4 = texelFetchOffset (sGpuCache, tmpvar_2, 0, ivec2(0, 0));
  vec4 tmpvar_5;
  tmpvar_5 = texelFetchOffset (sGpuCache, tmpvar_2, 0, ivec2(1, 0));
  ivec2 tmpvar_6;
  uint tmpvar_7;
  tmpvar_7 = uint(aData.x);
  tmpvar_6.x = int((2u * (tmpvar_7 % 512u)));
  tmpvar_6.y = int((tmpvar_7 / 512u));
  vec4 tmpvar_8;
  tmpvar_8 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_6, 0, ivec2(0, 0));
  ivec2 tmpvar_9;
  tmpvar_9.x = int((2u * (tmpvar_7 % 512u)));
  tmpvar_9.y = int((tmpvar_7 / 512u));
  ivec4 tmpvar_10;
  tmpvar_10 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_9, 0, ivec2(1, 0));
  ivec2 tmpvar_11;
  uint tmpvar_12;
  tmpvar_12 = uint(aData.w);
  tmpvar_11.x = int((2u * (tmpvar_12 % 512u)));
  tmpvar_11.y = int((tmpvar_12 / 512u));
  vec4 tmpvar_13;
  tmpvar_13 = texelFetchOffset (sRenderTasks, tmpvar_11, 0, ivec2(0, 0));
  vec4 tmpvar_14;
  tmpvar_14 = texelFetchOffset (sRenderTasks, tmpvar_11, 0, ivec2(1, 0));
  mat4 tmpvar_15;
  int tmpvar_16;
  tmpvar_16 = (texelFetchOffset (sPrimitiveHeadersI, tmpvar_9, 0, ivec2(0, 0)).z & 16777215);
  ivec2 tmpvar_17;
  tmpvar_17.x = int((8u * (
    uint(tmpvar_16)
   % 128u)));
  tmpvar_17.y = int((uint(tmpvar_16) / 128u));
  tmpvar_15[0] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(0, 0));
  tmpvar_15[1] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(1, 0));
  tmpvar_15[2] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(2, 0));
  tmpvar_15[3] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(3, 0));
  ivec2 tmpvar_18;
  tmpvar_18.x = int((uint(tmpvar_10.x) % 1024u));
  tmpvar_18.y = int((uint(tmpvar_10.x) / 1024u));
  vec4 tmpvar_19;
  tmpvar_19 = texelFetchOffset (sGpuCache, tmpvar_18, 0, ivec2(0, 0));
  float tmpvar_20;
  tmpvar_20 = texelFetchOffset (sGpuCache, tmpvar_18, 0, ivec2(1, 0)).x;
  RectWithSize tmpvar_21;
  float tmpvar_22;
  float tmpvar_23;
  vec2 tmpvar_24;
  if ((tmpvar_10.w >= 32767)) {
    tmpvar_21 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_22 = 0.0;
    tmpvar_23 = 0.0;
    tmpvar_24 = vec2(0.0, 0.0);
  } else {
    ivec2 tmpvar_25;
    tmpvar_25.x = int((2u * (
      uint(tmpvar_10.w)
     % 512u)));
    tmpvar_25.y = int((uint(tmpvar_10.w) / 512u));
    vec4 tmpvar_26;
    tmpvar_26 = texelFetchOffset (sRenderTasks, tmpvar_25, 0, ivec2(0, 0));
    vec4 tmpvar_27;
    tmpvar_27 = texelFetchOffset (sRenderTasks, tmpvar_25, 0, ivec2(1, 0));
    vec3 tmpvar_28;
    tmpvar_28 = tmpvar_27.yzw;
    tmpvar_21.p0 = tmpvar_26.xy;
    tmpvar_21.size = tmpvar_26.zw;
    tmpvar_22 = tmpvar_27.x;
    tmpvar_23 = tmpvar_28.x;
    tmpvar_24 = tmpvar_28.yz;
  };
  vec2 tmpvar_29;
  tmpvar_29 = mix (mix (tmpvar_4.xy, tmpvar_4.zw, aPosition.x), mix (tmpvar_5.zw, tmpvar_5.xy, aPosition.x), aPosition.y);
  vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 1.0);
  tmpvar_30.xy = tmpvar_29;
  vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * tmpvar_30);
  vec4 tmpvar_32;
  tmpvar_32.xy = (((tmpvar_13.xy - tmpvar_14.zw) * tmpvar_31.w) + (tmpvar_31.xy * tmpvar_14.y));
  tmpvar_32.z = (tmpvar_31.w * tmpvar_1);
  tmpvar_32.w = tmpvar_31.w;
  vec4 tmpvar_33;
  tmpvar_33.xy = tmpvar_21.p0;
  tmpvar_33.zw = (tmpvar_21.p0 + tmpvar_21.size);
  vClipMaskUvBounds = tmpvar_33;
  vec4 tmpvar_34;
  tmpvar_34.xy = ((tmpvar_31.xy * tmpvar_23) + (tmpvar_31.w * (tmpvar_21.p0 - tmpvar_24)));
  tmpvar_34.z = tmpvar_22;
  tmpvar_34.w = tmpvar_31.w;
  vClipMaskUv = tmpvar_34;
  gl_Position = (uTransform * tmpvar_32);
  vec2 tmpvar_35;
  tmpvar_35 = vec3(textureSize (sPrevPassColor, 0)).xy;
  vec4 tmpvar_36;
  tmpvar_36.xy = (min (tmpvar_19.xy, tmpvar_19.zw) + vec2(0.5, 0.5));
  tmpvar_36.zw = (max (tmpvar_19.xy, tmpvar_19.zw) - vec2(0.5, 0.5));
  vUvSampleBounds = (tmpvar_36 / tmpvar_35.xyxy);
  vec2 tmpvar_37;
  tmpvar_37 = ((tmpvar_29 - tmpvar_8.xy) / tmpvar_8.zw);
  int address_38;
  address_38 = (tmpvar_10.x + 2);
  ivec2 tmpvar_39;
  tmpvar_39.x = int((uint(address_38) % 1024u));
  tmpvar_39.y = int((uint(address_38) / 1024u));
  vec4 tmpvar_40;
  tmpvar_40 = mix (mix (texelFetchOffset (sGpuCache, tmpvar_39, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_39, 0, ivec2(1, 0)), tmpvar_37.x), mix (texelFetchOffset (sGpuCache, tmpvar_39, 0, ivec2(2, 0)), texelFetchOffset (sGpuCache, tmpvar_39, 0, ivec2(3, 0)), tmpvar_37.x), tmpvar_37.y);
  float tmpvar_41;
  tmpvar_41 = float(tmpvar_10.y);
  vUv = ((mix (tmpvar_19.xy, tmpvar_19.zw, 
    (tmpvar_40.xy / tmpvar_40.w)
  ) / tmpvar_35) * mix (gl_Position.w, 1.0, tmpvar_41));
  vec2 tmpvar_42;
  tmpvar_42.x = tmpvar_20;
  tmpvar_42.y = tmpvar_41;
  vLayerAndPerspective = tmpvar_42;
}

