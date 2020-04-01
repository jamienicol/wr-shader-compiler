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
void main ()
{
  int tmpvar_1;
  int tmpvar_2;
  tmpvar_1 = (aData.y >> 16);
  tmpvar_2 = (aData.z & 65535);
  float tmpvar_3;
  ivec2 tmpvar_4;
  uint tmpvar_5;
  tmpvar_5 = uint(aData.x);
  tmpvar_4.x = int((2u * (tmpvar_5 % 512u)));
  tmpvar_4.y = int((tmpvar_5 / 512u));
  vec4 tmpvar_6;
  tmpvar_6 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_4, 0, ivec2(0, 0));
  vec4 tmpvar_7;
  tmpvar_7 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_4, 0, ivec2(1, 0));
  vec2 tmpvar_8;
  vec2 tmpvar_9;
  tmpvar_8 = tmpvar_6.xy;
  tmpvar_9 = tmpvar_6.zw;
  ivec2 tmpvar_10;
  tmpvar_10.x = int((2u * (tmpvar_5 % 512u)));
  tmpvar_10.y = int((tmpvar_5 / 512u));
  ivec4 tmpvar_11;
  tmpvar_11 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_10, 0, ivec2(0, 0));
  ivec4 tmpvar_12;
  tmpvar_12 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_10, 0, ivec2(1, 0));
  tmpvar_3 = float(tmpvar_11.x);
  mat4 tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = ((tmpvar_11.z >> 24) == 0);
  int tmpvar_15;
  tmpvar_15 = (tmpvar_11.z & 16777215);
  ivec2 tmpvar_16;
  tmpvar_16.x = int((8u * (
    uint(tmpvar_15)
   % 128u)));
  tmpvar_16.y = int((uint(tmpvar_15) / 128u));
  tmpvar_13[0] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(0, 0));
  tmpvar_13[1] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(1, 0));
  tmpvar_13[2] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(2, 0));
  tmpvar_13[3] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(3, 0));
  ivec2 tmpvar_17;
  tmpvar_17.x = int((2u * (
    uint(tmpvar_1)
   % 512u)));
  tmpvar_17.y = int((uint(tmpvar_1) / 512u));
  vec4 tmpvar_18;
  tmpvar_18 = texelFetchOffset (sRenderTasks, tmpvar_17, 0, ivec2(0, 0));
  vec4 tmpvar_19;
  tmpvar_19 = texelFetchOffset (sRenderTasks, tmpvar_17, 0, ivec2(1, 0));
  vec2 tmpvar_20;
  vec2 tmpvar_21;
  int tmpvar_22;
  tmpvar_22 = ((aData.z >> 16) & 255);
  if ((tmpvar_2 == 65535)) {
    tmpvar_20 = tmpvar_8;
    tmpvar_21 = tmpvar_9;
  } else {
    int tmpvar_23;
    tmpvar_23 = ((tmpvar_11.y + 1) + (tmpvar_2 * 2));
    ivec2 tmpvar_24;
    tmpvar_24.x = int((uint(tmpvar_23) % 1024u));
    tmpvar_24.y = int((uint(tmpvar_23) / 1024u));
    vec4 tmpvar_25;
    tmpvar_25 = texelFetchOffset (sGpuCache, tmpvar_24, 0, ivec2(0, 0));
    tmpvar_21 = tmpvar_25.zw;
    tmpvar_20 = (tmpvar_25.xy + tmpvar_6.xy);
  };
  if (tmpvar_14) {
    vec4 tmpvar_26;
    tmpvar_26.zw = vec2(0.0, 1.0);
    tmpvar_26.xy = clamp ((tmpvar_20 + (tmpvar_21 * aPosition)), tmpvar_7.xy, (tmpvar_7.xy + tmpvar_7.zw));
    vec4 tmpvar_27;
    tmpvar_27 = (tmpvar_13 * tmpvar_26);
    vec4 tmpvar_28;
    tmpvar_28.xy = ((tmpvar_27.xy * tmpvar_19.y) + ((
      -(tmpvar_19.zw)
     + tmpvar_18.xy) * tmpvar_27.w));
    tmpvar_28.z = (tmpvar_3 * tmpvar_27.w);
    tmpvar_28.w = tmpvar_27.w;
    gl_Position = (uTransform * tmpvar_28);
  } else {
    vec4 tmpvar_29;
    tmpvar_29 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_22 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    vec2 tmpvar_30;
    tmpvar_30 = (tmpvar_7.xy + tmpvar_7.zw);
    vec4 tmpvar_31;
    tmpvar_31 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_29);
    vec4 tmpvar_32;
    tmpvar_32.zw = vec2(0.0, 1.0);
    tmpvar_32.xy = ((tmpvar_20 - tmpvar_31.xy) + ((tmpvar_21 + 
      (tmpvar_31.xy + tmpvar_31.zw)
    ) * aPosition));
    vec4 tmpvar_33;
    tmpvar_33 = (tmpvar_13 * tmpvar_32);
    vec4 tmpvar_34;
    tmpvar_34.xy = ((tmpvar_33.xy * tmpvar_19.y) + ((tmpvar_18.xy - tmpvar_19.zw) * tmpvar_33.w));
    tmpvar_34.z = (tmpvar_3 * tmpvar_33.w);
    tmpvar_34.w = tmpvar_33.w;
    gl_Position = (uTransform * tmpvar_34);
    vec4 tmpvar_35;
    tmpvar_35.xy = clamp (tmpvar_6.xy, tmpvar_7.xy, tmpvar_30);
    tmpvar_35.zw = clamp ((tmpvar_6.xy + tmpvar_6.zw), tmpvar_7.xy, tmpvar_30);
    vec4 tmpvar_36;
    tmpvar_36.xy = clamp (tmpvar_20, tmpvar_7.xy, tmpvar_30);
    tmpvar_36.zw = clamp ((tmpvar_20 + tmpvar_21), tmpvar_7.xy, tmpvar_30);
    vTransformBounds = mix (tmpvar_35, tmpvar_36, tmpvar_29);
  };
  ivec2 tmpvar_37;
  tmpvar_37.x = int((uint(tmpvar_11.y) % 1024u));
  tmpvar_37.y = int((uint(tmpvar_11.y) / 1024u));
  flat_varying_vec4_0 = (texelFetch (sGpuCache, tmpvar_37, 0) * (float(tmpvar_12.x) / 65535.0));
}

