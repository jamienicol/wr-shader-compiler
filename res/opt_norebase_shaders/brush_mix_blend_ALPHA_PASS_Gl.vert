#version 150
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
uniform sampler2DArray sPrevPassColor;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_0;
out vec4 varying_vec4_1;
void main ()
{
  int tmpvar_1;
  int tmpvar_2;
  int tmpvar_3;
  int tmpvar_4;
  tmpvar_1 = (aData.y >> 16);
  tmpvar_2 = (aData.y & 65535);
  tmpvar_3 = (aData.z & 65535);
  tmpvar_4 = (aData.z >> 16);
  float tmpvar_5;
  ivec2 tmpvar_6;
  uint tmpvar_7;
  tmpvar_7 = uint(aData.x);
  tmpvar_6.x = int((2u * (tmpvar_7 % 512u)));
  tmpvar_6.y = int((tmpvar_7 / 512u));
  vec4 tmpvar_8;
  tmpvar_8 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_6, 0, ivec2(0, 0));
  vec4 tmpvar_9;
  tmpvar_9 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_6, 0, ivec2(1, 0));
  vec2 tmpvar_10;
  vec2 tmpvar_11;
  tmpvar_10 = tmpvar_8.xy;
  tmpvar_11 = tmpvar_8.zw;
  ivec2 tmpvar_12;
  tmpvar_12.x = int((2u * (tmpvar_7 % 512u)));
  tmpvar_12.y = int((tmpvar_7 / 512u));
  ivec4 tmpvar_13;
  tmpvar_13 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_12, 0, ivec2(0, 0));
  ivec4 tmpvar_14;
  tmpvar_14 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_12, 0, ivec2(1, 0));
  tmpvar_5 = float(tmpvar_13.x);
  mat4 tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = ((tmpvar_13.z >> 24) == 0);
  int tmpvar_17;
  tmpvar_17 = (tmpvar_13.z & 16777215);
  ivec2 tmpvar_18;
  tmpvar_18.x = int((8u * (
    uint(tmpvar_17)
   % 128u)));
  tmpvar_18.y = int((uint(tmpvar_17) / 128u));
  tmpvar_15[0] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(0, 0));
  tmpvar_15[1] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(1, 0));
  tmpvar_15[2] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(2, 0));
  tmpvar_15[3] = texelFetchOffset (sTransformPalette, tmpvar_18, 0, ivec2(3, 0));
  ivec2 tmpvar_19;
  tmpvar_19.x = int((2u * (
    uint(tmpvar_1)
   % 512u)));
  tmpvar_19.y = int((uint(tmpvar_1) / 512u));
  vec4 tmpvar_20;
  tmpvar_20 = texelFetchOffset (sRenderTasks, tmpvar_19, 0, ivec2(0, 0));
  vec4 tmpvar_21;
  tmpvar_21 = texelFetchOffset (sRenderTasks, tmpvar_19, 0, ivec2(1, 0));
  RectWithSize tmpvar_22;
  float tmpvar_23;
  float tmpvar_24;
  vec2 tmpvar_25;
  if ((tmpvar_2 >= 32767)) {
    tmpvar_22 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_23 = 0.0;
    tmpvar_24 = 0.0;
    tmpvar_25 = vec2(0.0, 0.0);
  } else {
    ivec2 tmpvar_26;
    tmpvar_26.x = int((2u * (
      uint(tmpvar_2)
     % 512u)));
    tmpvar_26.y = int((uint(tmpvar_2) / 512u));
    vec4 tmpvar_27;
    tmpvar_27 = texelFetchOffset (sRenderTasks, tmpvar_26, 0, ivec2(0, 0));
    vec4 tmpvar_28;
    tmpvar_28 = texelFetchOffset (sRenderTasks, tmpvar_26, 0, ivec2(1, 0));
    vec3 tmpvar_29;
    tmpvar_29 = tmpvar_28.yzw;
    tmpvar_22.p0 = tmpvar_27.xy;
    tmpvar_22.size = tmpvar_27.zw;
    tmpvar_23 = tmpvar_28.x;
    tmpvar_24 = tmpvar_29.x;
    tmpvar_25 = tmpvar_29.yz;
  };
  vec4 tmpvar_30;
  vec2 tmpvar_31;
  vec2 tmpvar_32;
  int tmpvar_33;
  tmpvar_33 = (tmpvar_4 & 255);
  if ((tmpvar_3 == 65535)) {
    tmpvar_31 = tmpvar_10;
    tmpvar_32 = tmpvar_11;
  } else {
    int tmpvar_34;
    tmpvar_34 = ((tmpvar_13.y + 3) + (tmpvar_3 * 2));
    ivec2 tmpvar_35;
    tmpvar_35.x = int((uint(tmpvar_34) % 1024u));
    tmpvar_35.y = int((uint(tmpvar_34) / 1024u));
    vec4 tmpvar_36;
    tmpvar_36 = texelFetchOffset (sGpuCache, tmpvar_35, 0, ivec2(0, 0));
    tmpvar_32 = tmpvar_36.zw;
    tmpvar_31 = (tmpvar_36.xy + tmpvar_8.xy);
  };
  if (tmpvar_16) {
    vec4 tmpvar_37;
    tmpvar_37.zw = vec2(0.0, 1.0);
    tmpvar_37.xy = clamp ((tmpvar_31 + (tmpvar_32 * aPosition)), tmpvar_9.xy, (tmpvar_9.xy + tmpvar_9.zw));
    vec4 tmpvar_38;
    tmpvar_38 = (tmpvar_15 * tmpvar_37);
    vec4 tmpvar_39;
    tmpvar_39.xy = ((tmpvar_38.xy * tmpvar_21.y) + ((
      -(tmpvar_21.zw)
     + tmpvar_20.xy) * tmpvar_38.w));
    tmpvar_39.z = (tmpvar_5 * tmpvar_38.w);
    tmpvar_39.w = tmpvar_38.w;
    gl_Position = (uTransform * tmpvar_39);
    tmpvar_30 = tmpvar_38;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    vec4 tmpvar_40;
    tmpvar_40 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_33 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 tmpvar_41;
    tmpvar_41 = (tmpvar_9.xy + tmpvar_9.zw);
    vec4 tmpvar_42;
    tmpvar_42 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_40);
    vec4 tmpvar_43;
    tmpvar_43.zw = vec2(0.0, 1.0);
    tmpvar_43.xy = ((tmpvar_31 - tmpvar_42.xy) + ((tmpvar_32 + 
      (tmpvar_42.xy + tmpvar_42.zw)
    ) * aPosition));
    vec4 tmpvar_44;
    tmpvar_44 = (tmpvar_15 * tmpvar_43);
    vec4 tmpvar_45;
    tmpvar_45.xy = ((tmpvar_44.xy * tmpvar_21.y) + ((tmpvar_20.xy - tmpvar_21.zw) * tmpvar_44.w));
    tmpvar_45.z = (tmpvar_5 * tmpvar_44.w);
    tmpvar_45.w = tmpvar_44.w;
    gl_Position = (uTransform * tmpvar_45);
    vec4 tmpvar_46;
    tmpvar_46.xy = clamp (tmpvar_8.xy, tmpvar_9.xy, tmpvar_41);
    tmpvar_46.zw = clamp ((tmpvar_8.xy + tmpvar_8.zw), tmpvar_9.xy, tmpvar_41);
    vec4 tmpvar_47;
    tmpvar_47.xy = clamp (tmpvar_31, tmpvar_9.xy, tmpvar_41);
    tmpvar_47.zw = clamp ((tmpvar_31 + tmpvar_32), tmpvar_9.xy, tmpvar_41);
    vTransformBounds = mix (tmpvar_46, tmpvar_47, tmpvar_40);
    tmpvar_30 = tmpvar_44;
  };
  vec4 tmpvar_48;
  tmpvar_48.xy = tmpvar_22.p0;
  tmpvar_48.zw = (tmpvar_22.p0 + tmpvar_22.size);
  vClipMaskUvBounds = tmpvar_48;
  vec4 tmpvar_49;
  tmpvar_49.xy = ((tmpvar_30.xy * tmpvar_24) + (tmpvar_30.w * (tmpvar_22.p0 - tmpvar_25)));
  tmpvar_49.z = tmpvar_23;
  tmpvar_49.w = tmpvar_30.w;
  vClipMaskUv = tmpvar_49;
  vec2 tmpvar_50;
  tmpvar_50 = vec3(textureSize (sPrevPassColor, 0)).xy;
  flat_varying_ivec4_0.x = tmpvar_14.x;
  ivec2 tmpvar_51;
  tmpvar_51.x = int((2u * (
    uint(tmpvar_14.z)
   % 512u)));
  tmpvar_51.y = int((uint(tmpvar_14.z) / 512u));
  vec4 tmpvar_52;
  tmpvar_52 = texelFetchOffset (sRenderTasks, tmpvar_51, 0, ivec2(1, 0));
  varying_vec4_0.xy = (((
    (tmpvar_30.xy * (tmpvar_52.y / max (0.0, tmpvar_30.w)))
   + texelFetchOffset (sRenderTasks, tmpvar_51, 0, ivec2(0, 0)).xy) - tmpvar_52.zw) / tmpvar_50);
  varying_vec4_0.w = tmpvar_52.x;
  ivec2 tmpvar_53;
  tmpvar_53.x = int((2u * (
    uint(tmpvar_14.y)
   % 512u)));
  tmpvar_53.y = int((uint(tmpvar_14.y) / 512u));
  varying_vec4_1.xy = (((
    ((tmpvar_30.xy * tmpvar_21.y) / max (0.0, tmpvar_30.w))
   + texelFetchOffset (sRenderTasks, tmpvar_53, 0, ivec2(0, 0)).xy) - (tmpvar_52.zw * 
    (tmpvar_21.y / tmpvar_52.y)
  )) / tmpvar_50);
  varying_vec4_1.w = texelFetchOffset (sRenderTasks, tmpvar_53, 0, ivec2(1, 0)).x;
}

