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
out vec4 varying_vec4_0;
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
  vec2 tmpvar_30;
  vec4 tmpvar_31;
  vec2 tmpvar_32;
  vec2 tmpvar_33;
  int tmpvar_34;
  tmpvar_34 = (tmpvar_4 & 255);
  int tmpvar_35;
  tmpvar_35 = ((tmpvar_4 >> 8) & 255);
  if ((tmpvar_3 == 65535)) {
    tmpvar_32 = tmpvar_10;
    tmpvar_33 = tmpvar_11;
  } else {
    int tmpvar_36;
    tmpvar_36 = ((tmpvar_13.y + 3) + (tmpvar_3 * 2));
    ivec2 tmpvar_37;
    tmpvar_37.x = int((uint(tmpvar_36) % 1024u));
    tmpvar_37.y = int((uint(tmpvar_36) / 1024u));
    vec4 tmpvar_38;
    tmpvar_38 = texelFetchOffset (sGpuCache, tmpvar_37, 0, ivec2(0, 0));
    tmpvar_33 = tmpvar_38.zw;
    tmpvar_32 = (tmpvar_38.xy + tmpvar_8.xy);
  };
  if (tmpvar_16) {
    vec2 tmpvar_39;
    tmpvar_39 = clamp ((tmpvar_32 + (tmpvar_33 * aPosition)), tmpvar_9.xy, (tmpvar_9.xy + tmpvar_9.zw));
    vec4 tmpvar_40;
    tmpvar_40.zw = vec2(0.0, 1.0);
    tmpvar_40.xy = tmpvar_39;
    vec4 tmpvar_41;
    tmpvar_41 = (tmpvar_15 * tmpvar_40);
    vec4 tmpvar_42;
    tmpvar_42.xy = ((tmpvar_41.xy * tmpvar_21.y) + ((
      -(tmpvar_21.zw)
     + tmpvar_20.xy) * tmpvar_41.w));
    tmpvar_42.z = (tmpvar_5 * tmpvar_41.w);
    tmpvar_42.w = tmpvar_41.w;
    gl_Position = (uTransform * tmpvar_42);
    tmpvar_30 = tmpvar_39;
    tmpvar_31 = tmpvar_41;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    vec4 tmpvar_43;
    tmpvar_43 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_34 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 tmpvar_44;
    tmpvar_44 = (tmpvar_9.xy + tmpvar_9.zw);
    vec4 tmpvar_45;
    tmpvar_45 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_43);
    vec2 tmpvar_46;
    tmpvar_46 = ((tmpvar_32 - tmpvar_45.xy) + ((tmpvar_33 + 
      (tmpvar_45.xy + tmpvar_45.zw)
    ) * aPosition));
    vec4 tmpvar_47;
    tmpvar_47.zw = vec2(0.0, 1.0);
    tmpvar_47.xy = tmpvar_46;
    vec4 tmpvar_48;
    tmpvar_48 = (tmpvar_15 * tmpvar_47);
    vec4 tmpvar_49;
    tmpvar_49.xy = ((tmpvar_48.xy * tmpvar_21.y) + ((tmpvar_20.xy - tmpvar_21.zw) * tmpvar_48.w));
    tmpvar_49.z = (tmpvar_5 * tmpvar_48.w);
    tmpvar_49.w = tmpvar_48.w;
    gl_Position = (uTransform * tmpvar_49);
    vec4 tmpvar_50;
    tmpvar_50.xy = clamp (tmpvar_8.xy, tmpvar_9.xy, tmpvar_44);
    tmpvar_50.zw = clamp ((tmpvar_8.xy + tmpvar_8.zw), tmpvar_9.xy, tmpvar_44);
    vec4 tmpvar_51;
    tmpvar_51.xy = clamp (tmpvar_32, tmpvar_9.xy, tmpvar_44);
    tmpvar_51.zw = clamp ((tmpvar_32 + tmpvar_33), tmpvar_9.xy, tmpvar_44);
    vTransformBounds = mix (tmpvar_50, tmpvar_51, tmpvar_43);
    tmpvar_30 = tmpvar_46;
    tmpvar_31 = tmpvar_48;
  };
  vec4 tmpvar_52;
  tmpvar_52.xy = tmpvar_22.p0;
  tmpvar_52.zw = (tmpvar_22.p0 + tmpvar_22.size);
  vClipMaskUvBounds = tmpvar_52;
  vec4 tmpvar_53;
  tmpvar_53.xy = ((tmpvar_31.xy * tmpvar_24) + (tmpvar_31.w * (tmpvar_22.p0 - tmpvar_25)));
  tmpvar_53.z = tmpvar_23;
  tmpvar_53.w = tmpvar_31.w;
  vClipMaskUv = tmpvar_53;
  vec2 tmpvar_54;
  vec2 tmpvar_55;
  ivec2 tmpvar_56;
  tmpvar_56.x = int((uint(tmpvar_14.x) % 1024u));
  tmpvar_56.y = int((uint(tmpvar_14.x) / 1024u));
  vec4 tmpvar_57;
  tmpvar_57 = texelFetchOffset (sGpuCache, tmpvar_56, 0, ivec2(0, 0));
  tmpvar_54 = tmpvar_57.xy;
  tmpvar_55 = tmpvar_57.zw;
  float tmpvar_58;
  tmpvar_58 = texelFetchOffset (sGpuCache, tmpvar_56, 0, ivec2(1, 0)).x;
  vec2 tmpvar_59;
  tmpvar_59 = vec2(textureSize (sColor0, 0).xy);
  vec2 tmpvar_60;
  tmpvar_60 = ((tmpvar_30 - tmpvar_8.xy) / tmpvar_8.zw);
  int address_61;
  address_61 = (tmpvar_14.x + 2);
  ivec2 tmpvar_62;
  tmpvar_62.x = int((uint(address_61) % 1024u));
  tmpvar_62.y = int((uint(address_61) / 1024u));
  vec4 tmpvar_63;
  tmpvar_63 = mix (mix (texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(0, 0)), texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(1, 0)), tmpvar_60.x), mix (texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(2, 0)), texelFetchOffset (sGpuCache, tmpvar_62, 0, ivec2(3, 0)), tmpvar_60.x), tmpvar_60.y);
  vec2 tmpvar_64;
  tmpvar_64 = mix (tmpvar_57.xy, tmpvar_57.zw, (tmpvar_63.xy / tmpvar_63.w));
  float tmpvar_65;
  if (((tmpvar_35 & 1) != 0)) {
    tmpvar_65 = 1.0;
  } else {
    tmpvar_65 = 0.0;
  };
  varying_vec4_0.zw = ((tmpvar_64 / tmpvar_59) * mix (tmpvar_31.w, 1.0, tmpvar_65));
  flat_varying_vec4_2.x = tmpvar_58;
  flat_varying_vec4_2.y = tmpvar_65;
  vec4 tmpvar_66;
  tmpvar_66.xy = tmpvar_54;
  tmpvar_66.zw = tmpvar_55;
  flat_varying_vec4_1 = (tmpvar_66 / tmpvar_59.xyxy);
  varying_vec4_0.xy = tmpvar_30;
  flat_varying_vec4_2.z = (float(tmpvar_14.y) / 65536.0);
}

