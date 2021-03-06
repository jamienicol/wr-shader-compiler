#version 150
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2DRect sColor0;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
out vec4 varying_vec4_0;
void main ()
{
  int tmpvar_1;
  int tmpvar_2;
  int tmpvar_3;
  int tmpvar_4;
  tmpvar_1 = (aData.y >> 16);
  tmpvar_2 = (aData.z & 65535);
  tmpvar_3 = (aData.z >> 16);
  tmpvar_4 = (aData.w & 16777215);
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
  tmpvar_5 = float(tmpvar_13.x);
  mat4 tmpvar_14;
  bool tmpvar_15;
  tmpvar_15 = ((tmpvar_13.z >> 24) == 0);
  int tmpvar_16;
  tmpvar_16 = (tmpvar_13.z & 16777215);
  ivec2 tmpvar_17;
  tmpvar_17.x = int((8u * (
    uint(tmpvar_16)
   % 128u)));
  tmpvar_17.y = int((uint(tmpvar_16) / 128u));
  tmpvar_14[0] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(0, 0));
  tmpvar_14[1] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(1, 0));
  tmpvar_14[2] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(2, 0));
  tmpvar_14[3] = texelFetchOffset (sTransformPalette, tmpvar_17, 0, ivec2(3, 0));
  ivec2 tmpvar_18;
  tmpvar_18.x = int((2u * (
    uint(tmpvar_1)
   % 512u)));
  tmpvar_18.y = int((uint(tmpvar_1) / 512u));
  vec4 tmpvar_19;
  tmpvar_19 = texelFetchOffset (sRenderTasks, tmpvar_18, 0, ivec2(0, 0));
  vec4 tmpvar_20;
  tmpvar_20 = texelFetchOffset (sRenderTasks, tmpvar_18, 0, ivec2(1, 0));
  vec2 tmpvar_21;
  vec4 tmpvar_22;
  vec2 tmpvar_23;
  vec2 tmpvar_24;
  vec4 segment_data_25;
  int tmpvar_26;
  tmpvar_26 = (tmpvar_3 & 255);
  int tmpvar_27;
  tmpvar_27 = ((tmpvar_3 >> 8) & 255);
  if ((tmpvar_2 == 65535)) {
    tmpvar_23 = tmpvar_10;
    tmpvar_24 = tmpvar_11;
    segment_data_25 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    int tmpvar_28;
    tmpvar_28 = ((tmpvar_13.y + 3) + (tmpvar_2 * 2));
    ivec2 tmpvar_29;
    tmpvar_29.x = int((uint(tmpvar_28) % 1024u));
    tmpvar_29.y = int((uint(tmpvar_28) / 1024u));
    vec4 tmpvar_30;
    tmpvar_30 = texelFetchOffset (sGpuCache, tmpvar_29, 0, ivec2(0, 0));
    tmpvar_24 = tmpvar_30.zw;
    tmpvar_23 = (tmpvar_30.xy + tmpvar_8.xy);
    segment_data_25 = texelFetchOffset (sGpuCache, tmpvar_29, 0, ivec2(1, 0));
  };
  if (tmpvar_15) {
    vec2 tmpvar_31;
    tmpvar_31 = clamp ((tmpvar_23 + (tmpvar_24 * aPosition)), tmpvar_9.xy, (tmpvar_9.xy + tmpvar_9.zw));
    vec4 tmpvar_32;
    tmpvar_32.zw = vec2(0.0, 1.0);
    tmpvar_32.xy = tmpvar_31;
    vec4 tmpvar_33;
    tmpvar_33 = (tmpvar_14 * tmpvar_32);
    vec4 tmpvar_34;
    tmpvar_34.xy = ((tmpvar_33.xy * tmpvar_20.y) + ((
      -(tmpvar_20.zw)
     + tmpvar_19.xy) * tmpvar_33.w));
    tmpvar_34.z = (tmpvar_5 * tmpvar_33.w);
    tmpvar_34.w = tmpvar_33.w;
    gl_Position = (uTransform * tmpvar_34);
    tmpvar_21 = tmpvar_31;
    tmpvar_22 = tmpvar_33;
  } else {
    vec4 tmpvar_35;
    tmpvar_35 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_26 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 tmpvar_36;
    tmpvar_36 = (tmpvar_9.xy + tmpvar_9.zw);
    vec4 tmpvar_37;
    tmpvar_37 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_35);
    vec2 tmpvar_38;
    tmpvar_38 = ((tmpvar_23 - tmpvar_37.xy) + ((tmpvar_24 + 
      (tmpvar_37.xy + tmpvar_37.zw)
    ) * aPosition));
    vec4 tmpvar_39;
    tmpvar_39.zw = vec2(0.0, 1.0);
    tmpvar_39.xy = tmpvar_38;
    vec4 tmpvar_40;
    tmpvar_40 = (tmpvar_14 * tmpvar_39);
    vec4 tmpvar_41;
    tmpvar_41.xy = ((tmpvar_40.xy * tmpvar_20.y) + ((tmpvar_19.xy - tmpvar_20.zw) * tmpvar_40.w));
    tmpvar_41.z = (tmpvar_5 * tmpvar_40.w);
    tmpvar_41.w = tmpvar_40.w;
    gl_Position = (uTransform * tmpvar_41);
    vec4 tmpvar_42;
    tmpvar_42.xy = clamp (tmpvar_8.xy, tmpvar_9.xy, tmpvar_36);
    tmpvar_42.zw = clamp ((tmpvar_8.xy + tmpvar_8.zw), tmpvar_9.xy, tmpvar_36);
    vec4 tmpvar_43;
    tmpvar_43.xy = clamp (tmpvar_23, tmpvar_9.xy, tmpvar_36);
    tmpvar_43.zw = clamp ((tmpvar_23 + tmpvar_24), tmpvar_9.xy, tmpvar_36);
    vTransformBounds = mix (tmpvar_42, tmpvar_43, tmpvar_35);
    tmpvar_21 = tmpvar_38;
    tmpvar_22 = tmpvar_40;
  };
  vec2 stretch_size_44;
  vec2 tmpvar_45;
  vec2 tmpvar_46;
  vec2 uv1_47;
  vec2 uv0_48;
  ivec2 tmpvar_49;
  tmpvar_49.x = int((uint(tmpvar_13.y) % 1024u));
  tmpvar_49.y = int((uint(tmpvar_13.y) / 1024u));
  vec4 tmpvar_50;
  tmpvar_50 = texelFetchOffset (sGpuCache, tmpvar_49, 0, ivec2(2, 0));
  ivec2 tmpvar_51;
  tmpvar_51.x = int((uint(tmpvar_4) % 1024u));
  tmpvar_51.y = int((uint(tmpvar_4) / 1024u));
  vec4 tmpvar_52;
  tmpvar_52 = texelFetchOffset (sGpuCache, tmpvar_51, 0, ivec2(0, 0));
  float tmpvar_53;
  tmpvar_53 = texelFetchOffset (sGpuCache, tmpvar_51, 0, ivec2(1, 0)).x;
  uv0_48 = tmpvar_52.xy;
  uv1_47 = tmpvar_52.zw;
  tmpvar_45 = tmpvar_10;
  tmpvar_46 = tmpvar_11;
  stretch_size_44 = tmpvar_50.xy;
  if ((tmpvar_50.x < 0.0)) {
    stretch_size_44 = tmpvar_11;
  };
  if (((tmpvar_27 & 2) != 0)) {
    tmpvar_45 = tmpvar_23;
    tmpvar_46 = tmpvar_24;
    stretch_size_44 = tmpvar_24;
    if (((tmpvar_27 & 128) != 0)) {
      vec2 original_stretch_size_54;
      vec2 segment_uv_size_55;
      vec2 tmpvar_56;
      tmpvar_56 = (tmpvar_52.zw - tmpvar_52.xy);
      uv0_48 = (tmpvar_52.xy + (segment_data_25.xy * tmpvar_56));
      uv1_47 = (tmpvar_52.xy + (segment_data_25.zw * tmpvar_56));
      segment_uv_size_55 = (uv1_47 - uv0_48);
      if (((tmpvar_27 & 64) != 0)) {
        segment_uv_size_55 = (uv0_48 - tmpvar_52.xy);
        stretch_size_44 = (tmpvar_23 - tmpvar_8.xy);
        if (((segment_uv_size_55.x < 0.001) || (stretch_size_44.x < 0.001))) {
          segment_uv_size_55.x = (tmpvar_52.z - uv1_47.x);
          stretch_size_44.x = (((tmpvar_8.x + tmpvar_8.z) - tmpvar_23.x) - tmpvar_24.x);
        };
        if (((segment_uv_size_55.y < 0.001) || (stretch_size_44.y < 0.001))) {
          segment_uv_size_55.y = (tmpvar_52.w - uv1_47.y);
          stretch_size_44.y = (((tmpvar_8.y + tmpvar_8.w) - tmpvar_23.y) - tmpvar_24.y);
        };
      };
      original_stretch_size_54 = stretch_size_44;
      if (((tmpvar_27 & 4) != 0)) {
        stretch_size_44.x = ((stretch_size_44.y / segment_uv_size_55.y) * segment_uv_size_55.x);
      };
      if (((tmpvar_27 & 8) != 0)) {
        stretch_size_44.y = ((original_stretch_size_54.x / segment_uv_size_55.x) * segment_uv_size_55.y);
      };
    } else {
      if (((tmpvar_27 & 4) != 0)) {
        stretch_size_44.x = (segment_data_25.z - segment_data_25.x);
      };
      if (((tmpvar_27 & 8) != 0)) {
        stretch_size_44.y = (segment_data_25.w - segment_data_25.y);
      };
    };
    if (((tmpvar_27 & 16) != 0)) {
      stretch_size_44.x = (tmpvar_24.x / max (1.0, roundEven(
        (tmpvar_24.x / stretch_size_44.x)
      )));
    };
    if (((tmpvar_27 & 32) != 0)) {
      stretch_size_44.y = (tmpvar_24.y / max (1.0, roundEven(
        (tmpvar_24.y / stretch_size_44.y)
      )));
    };
  };
  float tmpvar_57;
  if (((tmpvar_27 & 1) != 0)) {
    tmpvar_57 = 1.0;
  } else {
    tmpvar_57 = 0.0;
  };
  flat_varying_vec4_4.x = tmpvar_53;
  flat_varying_vec4_4.y = tmpvar_57;
  vec2 tmpvar_58;
  tmpvar_58 = min (uv0_48, uv1_47);
  vec4 tmpvar_59;
  tmpvar_59.xy = (tmpvar_58 + vec2(0.5, 0.5));
  tmpvar_59.zw = (max (uv0_48, uv1_47) - vec2(0.5, 0.5));
  flat_varying_vec4_3 = tmpvar_59;
  varying_vec4_0.zw = (mix (uv0_48, uv1_47, (
    (tmpvar_21 - tmpvar_45)
   / tmpvar_46)) - tmpvar_58);
  varying_vec4_0.zw = varying_vec4_0.zw;
  varying_vec4_0.zw = (varying_vec4_0.zw * (tmpvar_46 / stretch_size_44));
  if ((tmpvar_57 == 0.0)) {
    varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_22.w);
  };
  vec4 tmpvar_60;
  tmpvar_60.xy = vec2(0.0, 0.0);
  tmpvar_60.zw = vec2(textureSize (sColor0));
  flat_varying_vec4_2 = tmpvar_60;
}

