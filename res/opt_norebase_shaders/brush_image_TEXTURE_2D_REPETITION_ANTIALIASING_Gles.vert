#version 300 es
precision highp sampler2DArray;
uniform mat4 uTransform;
in vec2 aPosition;
uniform sampler2D sColor0;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
flat out lowp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
flat out lowp vec4 flat_varying_vec4_2;
flat out lowp vec4 flat_varying_vec4_3;
flat out highp vec4 flat_varying_vec4_4;
out lowp vec4 varying_vec4_0;
void main ()
{
  highp int tmpvar_1;
  highp int tmpvar_2;
  highp int tmpvar_3;
  highp int tmpvar_4;
  tmpvar_1 = (aData.y >> 16);
  tmpvar_2 = (aData.z & 65535);
  tmpvar_3 = (aData.z >> 16);
  tmpvar_4 = (aData.w & 16777215);
  highp float tmpvar_5;
  highp ivec2 tmpvar_6;
  highp uint tmpvar_7;
  tmpvar_7 = uint(aData.x);
  tmpvar_6.x = int((2u * (tmpvar_7 % 512u)));
  tmpvar_6.y = int((tmpvar_7 / 512u));
  highp vec4 tmpvar_8;
  tmpvar_8 = texelFetch (sPrimitiveHeadersF, tmpvar_6, 0);
  highp vec4 tmpvar_9;
  tmpvar_9 = texelFetch (sPrimitiveHeadersF, (tmpvar_6 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_10 = tmpvar_8.xy;
  tmpvar_11 = tmpvar_8.zw;
  highp ivec2 tmpvar_12;
  tmpvar_12.x = int((2u * (tmpvar_7 % 512u)));
  tmpvar_12.y = int((tmpvar_7 / 512u));
  highp ivec4 tmpvar_13;
  tmpvar_13 = texelFetch (sPrimitiveHeadersI, tmpvar_12, 0);
  tmpvar_5 = float(tmpvar_13.x);
  highp mat4 tmpvar_14;
  bool tmpvar_15;
  tmpvar_15 = ((tmpvar_13.z >> 24) == 0);
  highp int tmpvar_16;
  tmpvar_16 = (tmpvar_13.z & 16777215);
  highp ivec2 tmpvar_17;
  tmpvar_17.x = int((8u * (
    uint(tmpvar_16)
   % 128u)));
  tmpvar_17.y = int((uint(tmpvar_16) / 128u));
  tmpvar_14[0] = texelFetch (sTransformPalette, tmpvar_17, 0);
  tmpvar_14[1] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(1, 0)), 0);
  tmpvar_14[2] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(2, 0)), 0);
  tmpvar_14[3] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(3, 0)), 0);
  highp ivec2 tmpvar_18;
  tmpvar_18.x = int((2u * (
    uint(tmpvar_1)
   % 512u)));
  tmpvar_18.y = int((uint(tmpvar_1) / 512u));
  highp vec4 tmpvar_19;
  tmpvar_19 = texelFetch (sRenderTasks, tmpvar_18, 0);
  highp vec4 tmpvar_20;
  tmpvar_20 = texelFetch (sRenderTasks, (tmpvar_18 + ivec2(1, 0)), 0);
  lowp vec2 tmpvar_21;
  highp vec4 tmpvar_22;
  highp vec2 tmpvar_23;
  highp vec2 tmpvar_24;
  highp vec4 segment_data_25;
  highp int tmpvar_26;
  tmpvar_26 = (tmpvar_3 & 255);
  highp int tmpvar_27;
  tmpvar_27 = ((tmpvar_3 >> 8) & 255);
  if ((tmpvar_2 == 65535)) {
    tmpvar_23 = tmpvar_10;
    tmpvar_24 = tmpvar_11;
    segment_data_25 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp int tmpvar_28;
    tmpvar_28 = ((tmpvar_13.y + 3) + (tmpvar_2 * 2));
    highp ivec2 tmpvar_29;
    tmpvar_29.x = int((uint(tmpvar_28) % 1024u));
    tmpvar_29.y = int((uint(tmpvar_28) / 1024u));
    highp vec4 tmpvar_30;
    tmpvar_30 = texelFetch (sGpuCache, tmpvar_29, 0);
    tmpvar_24 = tmpvar_30.zw;
    tmpvar_23 = (tmpvar_30.xy + tmpvar_8.xy);
    segment_data_25 = texelFetch (sGpuCache, (tmpvar_29 + ivec2(1, 0)), 0);
  };
  if (tmpvar_15) {
    lowp vec2 tmpvar_31;
    tmpvar_31 = clamp ((tmpvar_23 + (tmpvar_24 * aPosition)), tmpvar_9.xy, (tmpvar_9.xy + tmpvar_9.zw));
    lowp vec4 tmpvar_32;
    tmpvar_32.zw = vec2(0.0, 1.0);
    tmpvar_32.xy = tmpvar_31;
    highp vec4 tmpvar_33;
    tmpvar_33 = (tmpvar_14 * tmpvar_32);
    highp vec4 tmpvar_34;
    tmpvar_34.xy = ((tmpvar_33.xy * tmpvar_20.y) + ((
      -(tmpvar_20.zw)
     + tmpvar_19.xy) * tmpvar_33.w));
    tmpvar_34.z = (tmpvar_5 * tmpvar_33.w);
    tmpvar_34.w = tmpvar_33.w;
    gl_Position = (uTransform * tmpvar_34);
    tmpvar_21 = tmpvar_31;
    tmpvar_22 = tmpvar_33;
  } else {
    lowp vec4 tmpvar_35;
    tmpvar_35 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_26 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_36;
    lowp vec2 tmpvar_37;
    tmpvar_36 = tmpvar_23;
    tmpvar_37 = tmpvar_24;
    highp vec2 tmpvar_38;
    tmpvar_38 = (tmpvar_9.xy + tmpvar_9.zw);
    lowp vec2 tmpvar_39;
    tmpvar_39 = clamp (tmpvar_36, tmpvar_9.xy, tmpvar_38);
    lowp vec2 tmpvar_40;
    tmpvar_40 = clamp ((tmpvar_36 + tmpvar_37), tmpvar_9.xy, tmpvar_38);
    lowp vec4 tmpvar_41;
    tmpvar_41 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_35);
    tmpvar_36 = (tmpvar_36 - tmpvar_41.xy);
    tmpvar_37 = (tmpvar_37 + (tmpvar_41.xy + tmpvar_41.zw));
    lowp vec2 tmpvar_42;
    tmpvar_42 = (tmpvar_36 + (tmpvar_37 * aPosition));
    lowp vec4 tmpvar_43;
    tmpvar_43.zw = vec2(0.0, 1.0);
    tmpvar_43.xy = tmpvar_42;
    highp vec4 tmpvar_44;
    tmpvar_44 = (tmpvar_14 * tmpvar_43);
    highp vec4 tmpvar_45;
    tmpvar_45.xy = ((tmpvar_44.xy * tmpvar_20.y) + ((tmpvar_19.xy - tmpvar_20.zw) * tmpvar_44.w));
    tmpvar_45.z = (tmpvar_5 * tmpvar_44.w);
    tmpvar_45.w = tmpvar_44.w;
    gl_Position = (uTransform * tmpvar_45);
    highp vec4 tmpvar_46;
    tmpvar_46.xy = clamp (tmpvar_8.xy, tmpvar_9.xy, tmpvar_38);
    tmpvar_46.zw = clamp ((tmpvar_8.xy + tmpvar_8.zw), tmpvar_9.xy, tmpvar_38);
    lowp vec4 tmpvar_47;
    tmpvar_47.xy = tmpvar_39;
    tmpvar_47.zw = tmpvar_40;
    vTransformBounds = mix (tmpvar_46, tmpvar_47, tmpvar_35);
    tmpvar_21 = tmpvar_42;
    tmpvar_22 = tmpvar_44;
  };
  highp vec2 stretch_size_48;
  highp vec2 tmpvar_49;
  highp vec2 tmpvar_50;
  highp vec2 uv1_51;
  highp vec2 uv0_52;
  highp ivec2 tmpvar_53;
  tmpvar_53.x = int((uint(tmpvar_13.y) % 1024u));
  tmpvar_53.y = int((uint(tmpvar_13.y) / 1024u));
  highp vec4 tmpvar_54;
  tmpvar_54 = texelFetch (sGpuCache, (tmpvar_53 + ivec2(2, 0)), 0);
  lowp vec2 tmpvar_55;
  tmpvar_55 = vec2(textureSize (sColor0, 0));
  highp ivec2 tmpvar_56;
  tmpvar_56.x = int((uint(tmpvar_4) % 1024u));
  tmpvar_56.y = int((uint(tmpvar_4) / 1024u));
  highp vec4 tmpvar_57;
  tmpvar_57 = texelFetch (sGpuCache, tmpvar_56, 0);
  highp float tmpvar_58;
  tmpvar_58 = texelFetch (sGpuCache, (tmpvar_56 + ivec2(1, 0)), 0).x;
  uv0_52 = tmpvar_57.xy;
  uv1_51 = tmpvar_57.zw;
  tmpvar_49 = tmpvar_10;
  tmpvar_50 = tmpvar_11;
  stretch_size_48 = tmpvar_54.xy;
  if ((tmpvar_54.x < 0.0)) {
    stretch_size_48 = tmpvar_11;
  };
  if (((tmpvar_27 & 2) != 0)) {
    tmpvar_49 = tmpvar_23;
    tmpvar_50 = tmpvar_24;
    stretch_size_48 = tmpvar_24;
    if (((tmpvar_27 & 128) != 0)) {
      highp vec2 original_stretch_size_59;
      highp vec2 segment_uv_size_60;
      highp vec2 tmpvar_61;
      tmpvar_61 = (tmpvar_57.zw - tmpvar_57.xy);
      uv0_52 = (tmpvar_57.xy + (segment_data_25.xy * tmpvar_61));
      uv1_51 = (tmpvar_57.xy + (segment_data_25.zw * tmpvar_61));
      segment_uv_size_60 = (uv1_51 - uv0_52);
      if (((tmpvar_27 & 64) != 0)) {
        segment_uv_size_60 = (uv0_52 - tmpvar_57.xy);
        stretch_size_48 = (tmpvar_23 - tmpvar_8.xy);
        if (((segment_uv_size_60.x < 0.001) || (stretch_size_48.x < 0.001))) {
          segment_uv_size_60.x = (tmpvar_57.z - uv1_51.x);
          stretch_size_48.x = (((tmpvar_8.x + tmpvar_8.z) - tmpvar_23.x) - tmpvar_24.x);
        };
        if (((segment_uv_size_60.y < 0.001) || (stretch_size_48.y < 0.001))) {
          segment_uv_size_60.y = (tmpvar_57.w - uv1_51.y);
          stretch_size_48.y = (((tmpvar_8.y + tmpvar_8.w) - tmpvar_23.y) - tmpvar_24.y);
        };
      };
      original_stretch_size_59 = stretch_size_48;
      if (((tmpvar_27 & 4) != 0)) {
        stretch_size_48.x = ((stretch_size_48.y / segment_uv_size_60.y) * segment_uv_size_60.x);
      };
      if (((tmpvar_27 & 8) != 0)) {
        stretch_size_48.y = ((original_stretch_size_59.x / segment_uv_size_60.x) * segment_uv_size_60.y);
      };
    } else {
      if (((tmpvar_27 & 4) != 0)) {
        stretch_size_48.x = (segment_data_25.z - segment_data_25.x);
      };
      if (((tmpvar_27 & 8) != 0)) {
        stretch_size_48.y = (segment_data_25.w - segment_data_25.y);
      };
    };
    if (((tmpvar_27 & 16) != 0)) {
      stretch_size_48.x = (tmpvar_24.x / max (1.0, roundEven(
        (tmpvar_24.x / stretch_size_48.x)
      )));
    };
    if (((tmpvar_27 & 32) != 0)) {
      stretch_size_48.y = (tmpvar_24.y / max (1.0, roundEven(
        (tmpvar_24.y / stretch_size_48.y)
      )));
    };
  };
  highp float tmpvar_62;
  if (((tmpvar_27 & 1) != 0)) {
    tmpvar_62 = 1.0;
  } else {
    tmpvar_62 = 0.0;
  };
  flat_varying_vec4_4.x = tmpvar_58;
  flat_varying_vec4_4.y = tmpvar_62;
  highp vec2 tmpvar_63;
  tmpvar_63 = min (uv0_52, uv1_51);
  highp vec2 tmpvar_64;
  tmpvar_64 = max (uv0_52, uv1_51);
  highp vec4 tmpvar_65;
  tmpvar_65.xy = (tmpvar_63 + vec2(0.5, 0.5));
  tmpvar_65.zw = (tmpvar_64 - vec2(0.5, 0.5));
  flat_varying_vec4_3 = (tmpvar_65 / tmpvar_55.xyxy);
  highp vec2 tmpvar_66;
  tmpvar_66 = (tmpvar_50 / stretch_size_48);
  highp vec2 tmpvar_67;
  tmpvar_67 = mix (uv0_52, uv1_51, ((tmpvar_21 - tmpvar_49) / tmpvar_50));
  varying_vec4_0.zw = (tmpvar_67 - tmpvar_63);
  varying_vec4_0.zw = (varying_vec4_0.zw / tmpvar_55);
  varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_66);
  if ((tmpvar_62 == 0.0)) {
    varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_22.w);
  };
  highp vec4 tmpvar_68;
  tmpvar_68.xy = tmpvar_63;
  tmpvar_68.zw = tmpvar_64;
  flat_varying_vec4_2 = (tmpvar_68 / tmpvar_55.xyxy);
}

