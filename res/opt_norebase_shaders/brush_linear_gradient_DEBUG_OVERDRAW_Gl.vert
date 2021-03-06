#version 150
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
flat out vec4 vTransformBounds;
uniform sampler2D sTransformPalette;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
out vec4 varying_vec4_0;
flat out int flat_varying_highp_int_address_0;
void main ()
{
  int tmpvar_1;
  int tmpvar_2;
  int tmpvar_3;
  tmpvar_1 = (aData.y >> 16);
  tmpvar_2 = (aData.z & 65535);
  tmpvar_3 = (aData.z >> 16);
  float tmpvar_4;
  ivec2 tmpvar_5;
  uint tmpvar_6;
  tmpvar_6 = uint(aData.x);
  tmpvar_5.x = int((2u * (tmpvar_6 % 512u)));
  tmpvar_5.y = int((tmpvar_6 / 512u));
  vec4 tmpvar_7;
  tmpvar_7 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_5, 0, ivec2(0, 0));
  vec4 tmpvar_8;
  tmpvar_8 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_5, 0, ivec2(1, 0));
  vec2 tmpvar_9;
  vec2 tmpvar_10;
  tmpvar_9 = tmpvar_7.xy;
  tmpvar_10 = tmpvar_7.zw;
  ivec2 tmpvar_11;
  tmpvar_11.x = int((2u * (tmpvar_6 % 512u)));
  tmpvar_11.y = int((tmpvar_6 / 512u));
  ivec4 tmpvar_12;
  tmpvar_12 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_11, 0, ivec2(0, 0));
  ivec4 tmpvar_13;
  tmpvar_13 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_11, 0, ivec2(1, 0));
  tmpvar_4 = float(tmpvar_12.x);
  mat4 tmpvar_14;
  bool tmpvar_15;
  tmpvar_15 = ((tmpvar_12.z >> 24) == 0);
  int tmpvar_16;
  tmpvar_16 = (tmpvar_12.z & 16777215);
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
  vec2 tmpvar_22;
  vec2 tmpvar_23;
  vec4 segment_data_24;
  int tmpvar_25;
  tmpvar_25 = (tmpvar_3 & 255);
  int tmpvar_26;
  tmpvar_26 = ((tmpvar_3 >> 8) & 255);
  if ((tmpvar_2 == 65535)) {
    tmpvar_22 = tmpvar_9;
    tmpvar_23 = tmpvar_10;
    segment_data_24 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    int tmpvar_27;
    tmpvar_27 = ((tmpvar_12.y + 2) + (tmpvar_2 * 2));
    ivec2 tmpvar_28;
    tmpvar_28.x = int((uint(tmpvar_27) % 1024u));
    tmpvar_28.y = int((uint(tmpvar_27) / 1024u));
    vec4 tmpvar_29;
    tmpvar_29 = texelFetchOffset (sGpuCache, tmpvar_28, 0, ivec2(0, 0));
    tmpvar_23 = tmpvar_29.zw;
    tmpvar_22 = (tmpvar_29.xy + tmpvar_7.xy);
    segment_data_24 = texelFetchOffset (sGpuCache, tmpvar_28, 0, ivec2(1, 0));
  };
  if (tmpvar_15) {
    vec2 tmpvar_30;
    tmpvar_30 = clamp ((tmpvar_22 + (tmpvar_23 * aPosition)), tmpvar_8.xy, (tmpvar_8.xy + tmpvar_8.zw));
    vec4 tmpvar_31;
    tmpvar_31.zw = vec2(0.0, 1.0);
    tmpvar_31.xy = tmpvar_30;
    vec4 tmpvar_32;
    tmpvar_32 = (tmpvar_14 * tmpvar_31);
    vec4 tmpvar_33;
    tmpvar_33.xy = ((tmpvar_32.xy * tmpvar_20.y) + ((
      -(tmpvar_20.zw)
     + tmpvar_19.xy) * tmpvar_32.w));
    tmpvar_33.z = (tmpvar_4 * tmpvar_32.w);
    tmpvar_33.w = tmpvar_32.w;
    gl_Position = (uTransform * tmpvar_33);
    tmpvar_21 = tmpvar_30;
  } else {
    vec4 tmpvar_34;
    tmpvar_34 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_25 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 tmpvar_35;
    tmpvar_35 = (tmpvar_8.xy + tmpvar_8.zw);
    vec4 tmpvar_36;
    tmpvar_36 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_34);
    vec2 tmpvar_37;
    tmpvar_37 = ((tmpvar_22 - tmpvar_36.xy) + ((tmpvar_23 + 
      (tmpvar_36.xy + tmpvar_36.zw)
    ) * aPosition));
    vec4 tmpvar_38;
    tmpvar_38.zw = vec2(0.0, 1.0);
    tmpvar_38.xy = tmpvar_37;
    vec4 tmpvar_39;
    tmpvar_39 = (tmpvar_14 * tmpvar_38);
    vec4 tmpvar_40;
    tmpvar_40.xy = ((tmpvar_39.xy * tmpvar_20.y) + ((tmpvar_19.xy - tmpvar_20.zw) * tmpvar_39.w));
    tmpvar_40.z = (tmpvar_4 * tmpvar_39.w);
    tmpvar_40.w = tmpvar_39.w;
    gl_Position = (uTransform * tmpvar_40);
    vec4 tmpvar_41;
    tmpvar_41.xy = clamp (tmpvar_7.xy, tmpvar_8.xy, tmpvar_35);
    tmpvar_41.zw = clamp ((tmpvar_7.xy + tmpvar_7.zw), tmpvar_8.xy, tmpvar_35);
    vec4 tmpvar_42;
    tmpvar_42.xy = clamp (tmpvar_22, tmpvar_8.xy, tmpvar_35);
    tmpvar_42.zw = clamp ((tmpvar_22 + tmpvar_23), tmpvar_8.xy, tmpvar_35);
    vTransformBounds = mix (tmpvar_41, tmpvar_42, tmpvar_34);
    tmpvar_21 = tmpvar_37;
  };
  ivec2 tmpvar_43;
  tmpvar_43.x = int((uint(tmpvar_12.y) % 1024u));
  tmpvar_43.y = int((uint(tmpvar_12.y) / 1024u));
  vec4 tmpvar_44;
  vec4 tmpvar_45;
  tmpvar_44 = texelFetchOffset (sGpuCache, tmpvar_43, 0, ivec2(0, 0));
  tmpvar_45 = texelFetchOffset (sGpuCache, tmpvar_43, 0, ivec2(1, 0));
  int tmpvar_46;
  vec2 tmpvar_47;
  tmpvar_46 = int(tmpvar_45.x);
  tmpvar_47 = tmpvar_45.yz;
  if (((tmpvar_26 & 2) != 0)) {
    varying_vec4_0.zw = ((tmpvar_21 - tmpvar_22) / tmpvar_23);
    varying_vec4_0.zw = ((varying_vec4_0.zw * (segment_data_24.zw - segment_data_24.xy)) + segment_data_24.xy);
    varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_7.zw);
  } else {
    varying_vec4_0.zw = (tmpvar_21 - tmpvar_7.xy);
  };
  vec2 tmpvar_48;
  tmpvar_48 = (tmpvar_44.zw - tmpvar_44.xy);
  flat_varying_vec4_0.xy = tmpvar_44.xy;
  flat_varying_vec4_0.zw = (tmpvar_48 / dot (tmpvar_48, tmpvar_48));
  flat_varying_vec4_1.xy = tmpvar_47;
  flat_varying_highp_int_address_0 = tmpvar_13.x;
  flat_varying_vec4_1.z = float((tmpvar_46 != 0));
}

