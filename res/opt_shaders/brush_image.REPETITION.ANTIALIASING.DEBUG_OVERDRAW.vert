#version 310 es
precision highp sampler2DArray;
uniform mat4 uTransform;
in vec3 aPosition;
uniform sampler2DArray sColor0;
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
  lowp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 segment_data_5;
  highp int tmpvar_6;
  highp int tmpvar_7;
  highp int tmpvar_8;
  highp int tmpvar_9;
  tmpvar_6 = (aData.y >> 16);
  tmpvar_7 = (aData.z & 65535);
  tmpvar_8 = (aData.z >> 16);
  tmpvar_9 = (aData.w & 16777215);
  highp int tmpvar_10;
  tmpvar_10 = (tmpvar_8 & 255);
  highp int tmpvar_11;
  tmpvar_11 = ((tmpvar_8 >> 8) & 255);
  highp float tmpvar_12;
  highp ivec2 tmpvar_13;
  highp uint tmpvar_14;
  tmpvar_14 = uint(aData.x);
  tmpvar_13.x = int((2u * (uint(tmpvar_14 % 512u))));
  tmpvar_13.y = int((tmpvar_14 / 512u));
  highp vec4 tmpvar_15;
  tmpvar_15 = texelFetch (sPrimitiveHeadersF, tmpvar_13, 0);
  highp vec4 tmpvar_16;
  tmpvar_16 = texelFetch (sPrimitiveHeadersF, (tmpvar_13 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_17 = tmpvar_15.xy;
  tmpvar_18 = tmpvar_15.zw;
  highp ivec2 tmpvar_19;
  tmpvar_19.x = int((2u * (uint(tmpvar_14 % 512u))));
  tmpvar_19.y = int((tmpvar_14 / 512u));
  highp ivec4 tmpvar_20;
  tmpvar_20 = texelFetch (sPrimitiveHeadersI, tmpvar_19, 0);
  tmpvar_12 = float(tmpvar_20.x);
  if ((tmpvar_7 == 65535)) {
    tmpvar_3 = tmpvar_17;
    tmpvar_4 = tmpvar_18;
    segment_data_5 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp int tmpvar_21;
    tmpvar_21 = ((tmpvar_20.y + 3) + (tmpvar_7 * 2));
    highp ivec2 tmpvar_22;
    tmpvar_22.x = int((uint(uint(tmpvar_21) % 1024u)));
    tmpvar_22.y = int((uint(tmpvar_21) / 1024u));
    highp vec4 tmpvar_23;
    tmpvar_23 = texelFetch (sGpuCache, tmpvar_22, 0);
    tmpvar_4 = tmpvar_23.zw;
    tmpvar_3 = (tmpvar_23.xy + tmpvar_15.xy);
    segment_data_5 = texelFetch (sGpuCache, (tmpvar_22 + ivec2(1, 0)), 0);
  };
  highp ivec2 tmpvar_24;
  tmpvar_24.x = int((2u * (uint(
    uint(tmpvar_6)
   % 512u))));
  tmpvar_24.y = int((uint(tmpvar_6) / 512u));
  highp vec4 tmpvar_25;
  tmpvar_25 = texelFetch (sRenderTasks, tmpvar_24, 0);
  highp vec4 tmpvar_26;
  tmpvar_26 = texelFetch (sRenderTasks, (tmpvar_24 + ivec2(1, 0)), 0);
  highp mat4 tmpvar_27;
  highp int tmpvar_28;
  tmpvar_28 = (tmpvar_20.z & 16777215);
  highp ivec2 tmpvar_29;
  tmpvar_29.x = int((8u * (uint(
    uint(tmpvar_28)
   % 128u))));
  tmpvar_29.y = int((uint(tmpvar_28) / 128u));
  tmpvar_27[0] = texelFetch (sTransformPalette, tmpvar_29, 0);
  tmpvar_27[1] = texelFetch (sTransformPalette, (tmpvar_29 + ivec2(1, 0)), 0);
  tmpvar_27[2] = texelFetch (sTransformPalette, (tmpvar_29 + ivec2(2, 0)), 0);
  tmpvar_27[3] = texelFetch (sTransformPalette, (tmpvar_29 + ivec2(3, 0)), 0);
  if (((tmpvar_20.z >> 24) == 0)) {
    lowp vec2 tmpvar_30;
    tmpvar_30 = clamp ((tmpvar_3 + (tmpvar_4 * aPosition.xy)), tmpvar_16.xy, (tmpvar_16.xy + tmpvar_16.zw));
    lowp vec4 tmpvar_31;
    tmpvar_31.zw = vec2(0.0, 1.0);
    tmpvar_31.xy = tmpvar_30;
    highp vec4 tmpvar_32;
    tmpvar_32 = (tmpvar_27 * tmpvar_31);
    highp vec4 tmpvar_33;
    tmpvar_33.xy = ((tmpvar_32.xy * tmpvar_26.y) + ((
      -(tmpvar_26.zw)
     + tmpvar_25.xy) * tmpvar_32.w));
    tmpvar_33.z = (tmpvar_12 * tmpvar_32.w);
    tmpvar_33.w = tmpvar_32.w;
    gl_Position = (uTransform * tmpvar_33);
    tmpvar_1 = tmpvar_30;
    tmpvar_2 = tmpvar_32;
  } else {
    lowp vec4 tmpvar_34;
    tmpvar_34 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_10 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_35;
    lowp vec2 tmpvar_36;
    tmpvar_35 = tmpvar_3;
    tmpvar_36 = tmpvar_4;
    highp vec2 tmpvar_37;
    tmpvar_37 = (tmpvar_16.xy + tmpvar_16.zw);
    lowp vec2 tmpvar_38;
    tmpvar_38 = clamp (tmpvar_35, tmpvar_16.xy, tmpvar_37);
    lowp vec2 tmpvar_39;
    tmpvar_39 = clamp ((tmpvar_35 + tmpvar_36), tmpvar_16.xy, tmpvar_37);
    lowp vec4 tmpvar_40;
    tmpvar_40 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_34);
    tmpvar_35 = (tmpvar_35 - tmpvar_40.xy);
    tmpvar_36 = (tmpvar_36 + (tmpvar_40.xy + tmpvar_40.zw));
    lowp vec2 tmpvar_41;
    tmpvar_41 = (tmpvar_35 + (tmpvar_36 * aPosition.xy));
    lowp vec4 tmpvar_42;
    tmpvar_42.zw = vec2(0.0, 1.0);
    tmpvar_42.xy = tmpvar_41;
    highp vec4 tmpvar_43;
    tmpvar_43 = (tmpvar_27 * tmpvar_42);
    highp vec4 tmpvar_44;
    tmpvar_44.xy = ((tmpvar_43.xy * tmpvar_26.y) + ((tmpvar_25.xy - tmpvar_26.zw) * tmpvar_43.w));
    tmpvar_44.z = (tmpvar_12 * tmpvar_43.w);
    tmpvar_44.w = tmpvar_43.w;
    gl_Position = (uTransform * tmpvar_44);
    highp vec4 tmpvar_45;
    tmpvar_45.xy = clamp (tmpvar_15.xy, tmpvar_16.xy, tmpvar_37);
    tmpvar_45.zw = clamp ((tmpvar_15.xy + tmpvar_15.zw), tmpvar_16.xy, tmpvar_37);
    lowp vec4 tmpvar_46;
    tmpvar_46.xy = tmpvar_38;
    tmpvar_46.zw = tmpvar_39;
    vTransformBounds = mix (tmpvar_45, tmpvar_46, tmpvar_34);
    tmpvar_1 = tmpvar_41;
    tmpvar_2 = tmpvar_43;
  };
  highp vec2 stretch_size_47;
  highp vec2 tmpvar_48;
  highp vec2 tmpvar_49;
  highp vec2 uv1_50;
  highp vec2 uv0_51;
  highp ivec2 tmpvar_52;
  tmpvar_52.x = int((uint(uint(tmpvar_20.y) % 1024u)));
  tmpvar_52.y = int((uint(tmpvar_20.y) / 1024u));
  highp vec4 tmpvar_53;
  tmpvar_53 = texelFetch (sGpuCache, (tmpvar_52 + ivec2(2, 0)), 0);
  lowp vec2 tmpvar_54;
  tmpvar_54 = vec3(textureSize (sColor0, 0)).xy;
  highp ivec2 tmpvar_55;
  tmpvar_55.x = int((uint(uint(tmpvar_9) % 1024u)));
  tmpvar_55.y = int((uint(tmpvar_9) / 1024u));
  highp vec4 tmpvar_56;
  tmpvar_56 = texelFetch (sGpuCache, tmpvar_55, 0);
  highp float tmpvar_57;
  tmpvar_57 = texelFetch (sGpuCache, (tmpvar_55 + ivec2(1, 0)), 0).x;
  uv0_51 = tmpvar_56.xy;
  uv1_50 = tmpvar_56.zw;
  tmpvar_48 = tmpvar_17;
  tmpvar_49 = tmpvar_18;
  stretch_size_47 = tmpvar_53.xy;
  if ((tmpvar_53.x < 0.0)) {
    stretch_size_47 = tmpvar_18;
  };
  if (((tmpvar_11 & 2) != 0)) {
    tmpvar_48 = tmpvar_3;
    tmpvar_49 = tmpvar_4;
    stretch_size_47 = tmpvar_4;
    if (((tmpvar_11 & 128) != 0)) {
      highp vec2 original_stretch_size_58;
      highp vec2 segment_uv_size_59;
      highp vec2 tmpvar_60;
      tmpvar_60 = (tmpvar_56.zw - tmpvar_56.xy);
      uv0_51 = (tmpvar_56.xy + (segment_data_5.xy * tmpvar_60));
      uv1_50 = (tmpvar_56.xy + (segment_data_5.zw * tmpvar_60));
      segment_uv_size_59 = (uv1_50 - uv0_51);
      if (((tmpvar_11 & 64) != 0)) {
        segment_uv_size_59 = (uv0_51 - tmpvar_56.xy);
        stretch_size_47 = (tmpvar_3 - tmpvar_15.xy);
        if (((segment_uv_size_59.x < 0.001) || (stretch_size_47.x < 0.001))) {
          segment_uv_size_59.x = (tmpvar_56.z - uv1_50.x);
          stretch_size_47.x = (((tmpvar_15.x + tmpvar_15.z) - tmpvar_3.x) - tmpvar_4.x);
        };
        if (((segment_uv_size_59.y < 0.001) || (stretch_size_47.y < 0.001))) {
          segment_uv_size_59.y = (tmpvar_56.w - uv1_50.y);
          stretch_size_47.y = (((tmpvar_15.y + tmpvar_15.w) - tmpvar_3.y) - tmpvar_4.y);
        };
      };
      original_stretch_size_58 = stretch_size_47;
      if (((tmpvar_11 & 4) != 0)) {
        stretch_size_47.x = ((stretch_size_47.y / segment_uv_size_59.y) * segment_uv_size_59.x);
      };
      if (((tmpvar_11 & 8) != 0)) {
        stretch_size_47.y = ((original_stretch_size_58.x / segment_uv_size_59.x) * segment_uv_size_59.y);
      };
    } else {
      if (((tmpvar_11 & 4) != 0)) {
        stretch_size_47.x = (segment_data_5.z - segment_data_5.x);
      };
      if (((tmpvar_11 & 8) != 0)) {
        stretch_size_47.y = (segment_data_5.w - segment_data_5.y);
      };
    };
    if (((tmpvar_11 & 16) != 0)) {
      stretch_size_47.x = (tmpvar_4.x / max (1.0, roundEven(
        (tmpvar_4.x / stretch_size_47.x)
      )));
    };
    if (((tmpvar_11 & 32) != 0)) {
      stretch_size_47.y = (tmpvar_4.y / max (1.0, roundEven(
        (tmpvar_4.y / stretch_size_47.y)
      )));
    };
  };
  highp float tmpvar_61;
  if (((tmpvar_11 & 1) != 0)) {
    tmpvar_61 = 1.0;
  } else {
    tmpvar_61 = 0.0;
  };
  flat_varying_vec4_4.x = tmpvar_57;
  flat_varying_vec4_4.y = tmpvar_61;
  highp vec2 tmpvar_62;
  tmpvar_62 = min (uv0_51, uv1_50);
  highp vec2 tmpvar_63;
  tmpvar_63 = max (uv0_51, uv1_50);
  highp vec4 tmpvar_64;
  tmpvar_64.xy = (tmpvar_62 + vec2(0.5, 0.5));
  tmpvar_64.zw = (tmpvar_63 - vec2(0.5, 0.5));
  flat_varying_vec4_3 = (tmpvar_64 / tmpvar_54.xyxy);
  highp vec2 tmpvar_65;
  tmpvar_65 = (tmpvar_49 / stretch_size_47);
  highp vec2 tmpvar_66;
  tmpvar_66 = mix (uv0_51, uv1_50, ((tmpvar_1 - tmpvar_48) / tmpvar_49));
  varying_vec4_0.zw = (tmpvar_66 - tmpvar_62);
  varying_vec4_0.zw = (varying_vec4_0.zw / tmpvar_54);
  varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_65);
  if ((tmpvar_61 == 0.0)) {
    varying_vec4_0.zw = (varying_vec4_0.zw * tmpvar_2.w);
  };
  highp vec4 tmpvar_67;
  tmpvar_67.xy = tmpvar_62;
  tmpvar_67.zw = tmpvar_63;
  flat_varying_vec4_2 = (tmpvar_67 / tmpvar_54.xyxy);
}

