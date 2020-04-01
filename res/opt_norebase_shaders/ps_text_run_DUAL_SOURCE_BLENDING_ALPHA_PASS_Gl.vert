#version 150
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform int uMode;
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2DArray sColor0;
uniform sampler2D sRenderTasks;
uniform sampler2D sGpuCache;
uniform sampler2D sTransformPalette;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
uniform sampler2D sPrimitiveHeadersF;
uniform isampler2D sPrimitiveHeadersI;
in ivec4 aData;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_2;
out vec4 varying_vec4_0;
void main ()
{
  int tmpvar_1;
  int tmpvar_2;
  int tmpvar_3;
  int tmpvar_4;
  int tmpvar_5;
  tmpvar_1 = (aData.y >> 16);
  tmpvar_2 = (aData.y & 65535);
  tmpvar_3 = (aData.z & 65535);
  tmpvar_4 = (aData.z >> 16);
  tmpvar_5 = (aData.w & 16777215);
  float tmpvar_6;
  ivec2 tmpvar_7;
  uint tmpvar_8;
  tmpvar_8 = uint(aData.x);
  tmpvar_7.x = int((2u * (tmpvar_8 % 512u)));
  tmpvar_7.y = int((tmpvar_8 / 512u));
  vec4 tmpvar_9;
  tmpvar_9 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_7, 0, ivec2(0, 0));
  vec4 tmpvar_10;
  tmpvar_10 = texelFetchOffset (sPrimitiveHeadersF, tmpvar_7, 0, ivec2(1, 0));
  ivec2 tmpvar_11;
  tmpvar_11.x = int((2u * (tmpvar_8 % 512u)));
  tmpvar_11.y = int((tmpvar_8 / 512u));
  ivec4 tmpvar_12;
  tmpvar_12 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_11, 0, ivec2(0, 0));
  ivec4 tmpvar_13;
  tmpvar_13 = texelFetchOffset (sPrimitiveHeadersI, tmpvar_11, 0, ivec2(1, 0));
  tmpvar_6 = float(tmpvar_12.x);
  mat4 tmpvar_14;
  int tmpvar_15;
  tmpvar_15 = (tmpvar_12.z & 16777215);
  ivec2 tmpvar_16;
  tmpvar_16.x = int((8u * (
    uint(tmpvar_15)
   % 128u)));
  tmpvar_16.y = int((uint(tmpvar_15) / 128u));
  tmpvar_14[0] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(0, 0));
  tmpvar_14[1] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(1, 0));
  tmpvar_14[2] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(2, 0));
  tmpvar_14[3] = texelFetchOffset (sTransformPalette, tmpvar_16, 0, ivec2(3, 0));
  ivec2 tmpvar_17;
  tmpvar_17.x = int((2u * (
    uint(tmpvar_1)
   % 512u)));
  tmpvar_17.y = int((uint(tmpvar_1) / 512u));
  vec4 tmpvar_18;
  tmpvar_18 = texelFetchOffset (sRenderTasks, tmpvar_17, 0, ivec2(0, 0));
  vec4 tmpvar_19;
  tmpvar_19 = texelFetchOffset (sRenderTasks, tmpvar_17, 0, ivec2(1, 0));
  RectWithSize tmpvar_20;
  float tmpvar_21;
  float tmpvar_22;
  vec2 tmpvar_23;
  if ((tmpvar_2 >= 32767)) {
    tmpvar_20 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_21 = 0.0;
    tmpvar_22 = 0.0;
    tmpvar_23 = vec2(0.0, 0.0);
  } else {
    ivec2 tmpvar_24;
    tmpvar_24.x = int((2u * (
      uint(tmpvar_2)
     % 512u)));
    tmpvar_24.y = int((uint(tmpvar_2) / 512u));
    vec4 tmpvar_25;
    tmpvar_25 = texelFetchOffset (sRenderTasks, tmpvar_24, 0, ivec2(0, 0));
    vec4 tmpvar_26;
    tmpvar_26 = texelFetchOffset (sRenderTasks, tmpvar_24, 0, ivec2(1, 0));
    vec3 tmpvar_27;
    tmpvar_27 = tmpvar_26.yzw;
    tmpvar_20.p0 = tmpvar_25.xy;
    tmpvar_20.size = tmpvar_25.zw;
    tmpvar_21 = tmpvar_26.x;
    tmpvar_22 = tmpvar_27.x;
    tmpvar_23 = tmpvar_27.yz;
  };
  float tmpvar_28;
  vec2 tmpvar_29;
  int color_mode_30;
  int subpx_dir_31;
  subpx_dir_31 = ((tmpvar_4 >> 8) & 255);
  color_mode_30 = (tmpvar_4 & 255);
  ivec2 tmpvar_32;
  tmpvar_32.x = int((uint(tmpvar_12.y) % 1024u));
  tmpvar_32.y = int((uint(tmpvar_12.y) / 1024u));
  vec4 tmpvar_33;
  vec4 tmpvar_34;
  tmpvar_33 = texelFetchOffset (sGpuCache, tmpvar_32, 0, ivec2(0, 0));
  tmpvar_34 = texelFetchOffset (sGpuCache, tmpvar_32, 0, ivec2(1, 0));
  if ((color_mode_30 == 0)) {
    color_mode_30 = uMode;
  };
  int address_35;
  address_35 = ((tmpvar_12.y + 2) + int((
    uint(tmpvar_3)
   / 2u)));
  ivec2 tmpvar_36;
  tmpvar_36.x = int((uint(address_35) % 1024u));
  tmpvar_36.y = int((uint(address_35) / 1024u));
  vec4 tmpvar_37;
  tmpvar_37 = texelFetch (sGpuCache, tmpvar_36, 0);
  tmpvar_29 = (mix(tmpvar_37.xy, tmpvar_37.zw, bvec2((
    (uint(tmpvar_3) % 2u)
   != uint(0)))) + tmpvar_9.xy);
  ivec2 tmpvar_38;
  tmpvar_38.x = int((uint(tmpvar_5) % 1024u));
  tmpvar_38.y = int((uint(tmpvar_5) / 1024u));
  vec4 tmpvar_39;
  vec4 tmpvar_40;
  tmpvar_39 = texelFetchOffset (sGpuCache, tmpvar_38, 0, ivec2(0, 0));
  tmpvar_40 = texelFetchOffset (sGpuCache, tmpvar_38, 0, ivec2(1, 0));
  tmpvar_28 = tmpvar_40.x;
  vec2 tmpvar_41;
  bool tmpvar_42;
  tmpvar_42 = bool(0);
  bool tmpvar_43;
  tmpvar_43 = bool(1);
  if ((1 == subpx_dir_31)) tmpvar_43 = bool(0);
  if ((2 == subpx_dir_31)) tmpvar_43 = bool(0);
  if ((3 == subpx_dir_31)) tmpvar_43 = bool(0);
  if ((0 == subpx_dir_31)) tmpvar_42 = bool(1);
  if ((bool(1) == tmpvar_43)) tmpvar_42 = bool(1);
  if (tmpvar_42) {
    tmpvar_41 = vec2(0.5, 0.5);
  } else {
    if ((1 == subpx_dir_31)) tmpvar_42 = bool(1);
    if (tmpvar_42) {
      tmpvar_41 = vec2(0.125, 0.5);
    } else {
      if ((2 == subpx_dir_31)) tmpvar_42 = bool(1);
      if (tmpvar_42) {
        tmpvar_41 = vec2(0.5, 0.125);
      } else {
        if ((3 == subpx_dir_31)) tmpvar_42 = bool(1);
        if (tmpvar_42) {
          tmpvar_41 = vec2(0.125, 0.125);
        };
      };
    };
  };
  float tmpvar_44;
  tmpvar_44 = ((float(tmpvar_13.x) / 65535.0) * tmpvar_19.y);
  float tmpvar_45;
  tmpvar_45 = (tmpvar_40.w / tmpvar_44);
  vec2 tmpvar_46;
  vec2 tmpvar_47;
  tmpvar_46 = ((tmpvar_45 * (tmpvar_40.yz + 
    (floor(((tmpvar_29 * tmpvar_44) + tmpvar_41)) / tmpvar_40.w)
  )) + tmpvar_9.zw);
  tmpvar_47 = (tmpvar_45 * (tmpvar_39.zw - tmpvar_39.xy));
  vec2 tmpvar_48;
  tmpvar_48 = clamp ((tmpvar_46 + (tmpvar_47 * aPosition)), tmpvar_10.xy, (tmpvar_10.xy + tmpvar_10.zw));
  vec4 tmpvar_49;
  tmpvar_49.zw = vec2(0.0, 1.0);
  tmpvar_49.xy = tmpvar_48;
  vec4 tmpvar_50;
  tmpvar_50 = (tmpvar_14 * tmpvar_49);
  vec4 tmpvar_51;
  tmpvar_51.xy = ((tmpvar_50.xy * tmpvar_19.y) + ((
    -(tmpvar_19.zw)
   + tmpvar_18.xy) * tmpvar_50.w));
  tmpvar_51.z = (tmpvar_6 * tmpvar_50.w);
  tmpvar_51.w = tmpvar_50.w;
  gl_Position = (uTransform * tmpvar_51);
  vec2 tmpvar_52;
  tmpvar_52 = ((tmpvar_48 - tmpvar_46) / tmpvar_47);
  vec4 tmpvar_53;
  tmpvar_53.xy = tmpvar_20.p0;
  tmpvar_53.zw = (tmpvar_20.p0 + tmpvar_20.size);
  vClipMaskUvBounds = tmpvar_53;
  vec4 tmpvar_54;
  tmpvar_54.xy = ((tmpvar_50.xy * tmpvar_22) + (tmpvar_50.w * (tmpvar_20.p0 - tmpvar_23)));
  tmpvar_54.z = tmpvar_21;
  tmpvar_54.w = tmpvar_50.w;
  vClipMaskUv = tmpvar_54;
  bool tmpvar_55;
  tmpvar_55 = bool(0);
  bool tmpvar_56;
  tmpvar_56 = bool(0);
  if ((1 == color_mode_30)) tmpvar_55 = bool(1);
  if ((7 == color_mode_30)) tmpvar_55 = bool(1);
  if (tmpvar_56) tmpvar_55 = bool(0);
  if (tmpvar_55) {
    flat_varying_vec4_1.xy = vec2(0.0, 1.0);
    flat_varying_vec4_0 = tmpvar_33;
    tmpvar_56 = bool(1);
  };
  if ((5 == color_mode_30)) tmpvar_55 = bool(1);
  if ((6 == color_mode_30)) tmpvar_55 = bool(1);
  if (tmpvar_56) tmpvar_55 = bool(0);
  if (tmpvar_55) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_33;
    tmpvar_56 = bool(1);
  };
  if ((2 == color_mode_30)) tmpvar_55 = bool(1);
  if ((3 == color_mode_30)) tmpvar_55 = bool(1);
  if ((8 == color_mode_30)) tmpvar_55 = bool(1);
  if (tmpvar_56) tmpvar_55 = bool(0);
  if (tmpvar_55) {
    flat_varying_vec4_1.xy = vec2(1.0, 0.0);
    flat_varying_vec4_0 = tmpvar_33.wwww;
    tmpvar_56 = bool(1);
  };
  if ((4 == color_mode_30)) tmpvar_55 = bool(1);
  if (tmpvar_56) tmpvar_55 = bool(0);
  if (tmpvar_55) {
    flat_varying_vec4_1.xy = vec2(-1.0, 1.0);
    flat_varying_vec4_0 = (tmpvar_33.wwww * tmpvar_34);
    tmpvar_56 = bool(1);
  };
  tmpvar_55 = bool(1);
  if (tmpvar_56) tmpvar_55 = bool(0);
  if (tmpvar_55) {
    flat_varying_vec4_1.xy = vec2(0.0, 0.0);
    flat_varying_vec4_0 = vec4(1.0, 1.0, 1.0, 1.0);
  };
  vec2 tmpvar_57;
  tmpvar_57 = vec3(textureSize (sColor0, 0)).xy;
  varying_vec4_0.xy = mix ((tmpvar_39.xy / tmpvar_57), (tmpvar_39.zw / tmpvar_57), tmpvar_52);
  varying_vec4_0.z = tmpvar_28;
  flat_varying_vec4_2 = ((tmpvar_39 + vec4(0.5, 0.5, -0.5, -0.5)) / tmpvar_57.xyxy);
}

