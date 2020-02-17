#version 300 es
precision highp sampler2DArray;
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform mat4 uTransform;
in vec3 aPosition;
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sColor2;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
flat out lowp vec4 vTransformBounds;
uniform highp sampler2D sTransformPalette;
flat out vec4 vClipMaskUvBounds;
out highp vec4 vClipMaskUv;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
out lowp vec2 vLocalPos;
out lowp vec3 vUv_Y;
flat out lowp vec4 vUvBounds_Y;
out lowp vec3 vUv_U;
flat out lowp vec4 vUvBounds_U;
out lowp vec3 vUv_V;
flat out lowp vec4 vUvBounds_V;
flat out highp float vCoefficient;
flat out mat3 vYuvColorMatrix;
flat out highp int vFormat;
void main ()
{
  lowp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp int tmpvar_5;
  highp int tmpvar_6;
  highp int tmpvar_7;
  tmpvar_5 = (aData.y >> 16);
  tmpvar_6 = (aData.y & 65535);
  tmpvar_7 = (aData.z & 65535);
  highp int tmpvar_8;
  tmpvar_8 = ((aData.z >> 16) & 255);
  highp float tmpvar_9;
  highp ivec2 tmpvar_10;
  highp uint tmpvar_11;
  tmpvar_11 = uint(aData.x);
  tmpvar_10.x = int((2u * (uint(mod (tmpvar_11, 512u)))));
  tmpvar_10.y = int((tmpvar_11 / 512u));
  highp vec4 tmpvar_12;
  tmpvar_12 = texelFetch (sPrimitiveHeadersF, tmpvar_10, 0);
  highp vec4 tmpvar_13;
  tmpvar_13 = texelFetch (sPrimitiveHeadersF, (tmpvar_10 + ivec2(1, 0)), 0);
  highp vec2 tmpvar_14;
  highp vec2 tmpvar_15;
  tmpvar_14 = tmpvar_12.xy;
  tmpvar_15 = tmpvar_12.zw;
  highp ivec2 tmpvar_16;
  tmpvar_16.x = int((2u * (uint(mod (tmpvar_11, 512u)))));
  tmpvar_16.y = int((tmpvar_11 / 512u));
  highp ivec4 tmpvar_17;
  tmpvar_17 = texelFetch (sPrimitiveHeadersI, tmpvar_16, 0);
  highp ivec4 tmpvar_18;
  tmpvar_18 = texelFetch (sPrimitiveHeadersI, (tmpvar_16 + ivec2(1, 0)), 0);
  tmpvar_9 = float(tmpvar_17.x);
  if ((tmpvar_7 == 65535)) {
    tmpvar_3 = tmpvar_14;
    tmpvar_4 = tmpvar_15;
  } else {
    highp int tmpvar_19;
    tmpvar_19 = ((tmpvar_17.y + 1) + (tmpvar_7 * 2));
    highp ivec2 tmpvar_20;
    tmpvar_20.x = int((uint(mod (uint(tmpvar_19), 1024u))));
    tmpvar_20.y = int((uint(tmpvar_19) / 1024u));
    highp vec4 tmpvar_21;
    tmpvar_21 = texelFetch (sGpuCache, tmpvar_20, 0);
    tmpvar_4 = tmpvar_21.zw;
    tmpvar_3 = (tmpvar_21.xy + tmpvar_12.xy);
  };
  highp ivec2 tmpvar_22;
  tmpvar_22.x = int((2u * (uint(mod (
    uint(tmpvar_5)
  , 512u)))));
  tmpvar_22.y = int((uint(tmpvar_5) / 512u));
  highp vec4 tmpvar_23;
  tmpvar_23 = texelFetch (sRenderTasks, tmpvar_22, 0);
  highp vec4 tmpvar_24;
  tmpvar_24 = texelFetch (sRenderTasks, (tmpvar_22 + ivec2(1, 0)), 0);
  RectWithSize tmpvar_25;
  highp float tmpvar_26;
  highp float tmpvar_27;
  highp vec2 tmpvar_28;
  if ((tmpvar_6 >= 32767)) {
    tmpvar_25 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_26 = 0.0;
    tmpvar_27 = 0.0;
    tmpvar_28 = vec2(0.0, 0.0);
  } else {
    highp ivec2 tmpvar_29;
    tmpvar_29.x = int((2u * (uint(mod (
      uint(tmpvar_6)
    , 512u)))));
    tmpvar_29.y = int((uint(tmpvar_6) / 512u));
    highp vec4 tmpvar_30;
    tmpvar_30 = texelFetch (sRenderTasks, tmpvar_29, 0);
    highp vec4 tmpvar_31;
    tmpvar_31 = texelFetch (sRenderTasks, (tmpvar_29 + ivec2(1, 0)), 0);
    highp vec3 tmpvar_32;
    tmpvar_32 = tmpvar_31.yzw;
    tmpvar_25.p0 = tmpvar_30.xy;
    tmpvar_25.size = tmpvar_30.zw;
    tmpvar_26 = tmpvar_31.x;
    tmpvar_27 = tmpvar_32.x;
    tmpvar_28 = tmpvar_32.yz;
  };
  highp mat4 tmpvar_33;
  highp int tmpvar_34;
  tmpvar_34 = (tmpvar_17.z & 16777215);
  highp ivec2 tmpvar_35;
  tmpvar_35.x = int((8u * (uint(mod (
    uint(tmpvar_34)
  , 128u)))));
  tmpvar_35.y = int((uint(tmpvar_34) / 128u));
  tmpvar_33[0] = texelFetch (sTransformPalette, tmpvar_35, 0);
  tmpvar_33[1] = texelFetch (sTransformPalette, (tmpvar_35 + ivec2(1, 0)), 0);
  tmpvar_33[2] = texelFetch (sTransformPalette, (tmpvar_35 + ivec2(2, 0)), 0);
  tmpvar_33[3] = texelFetch (sTransformPalette, (tmpvar_35 + ivec2(3, 0)), 0);
  if (((tmpvar_17.z >> 24) == 0)) {
    lowp vec2 tmpvar_36;
    tmpvar_36 = clamp ((tmpvar_3 + (tmpvar_4 * aPosition.xy)), tmpvar_13.xy, (tmpvar_13.xy + tmpvar_13.zw));
    lowp vec4 tmpvar_37;
    tmpvar_37.zw = vec2(0.0, 1.0);
    tmpvar_37.xy = tmpvar_36;
    highp vec4 tmpvar_38;
    tmpvar_38 = (tmpvar_33 * tmpvar_37);
    highp vec4 tmpvar_39;
    tmpvar_39.xy = ((tmpvar_38.xy * tmpvar_24.y) + ((
      -(tmpvar_24.zw)
     + tmpvar_23.xy) * tmpvar_38.w));
    tmpvar_39.z = (tmpvar_9 * tmpvar_38.w);
    tmpvar_39.w = tmpvar_38.w;
    gl_Position = (uTransform * tmpvar_39);
    tmpvar_1 = tmpvar_36;
    tmpvar_2 = tmpvar_38;
    vTransformBounds = vec4(-1e+16, -1e+16, 1e+16, 1e+16);
  } else {
    lowp vec4 tmpvar_40;
    tmpvar_40 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), bvec4(notEqual ((tmpvar_8 & ivec4(1, 2, 4, 8)), ivec4(0, 0, 0, 0))));
    lowp vec2 tmpvar_41;
    lowp vec2 tmpvar_42;
    tmpvar_41 = tmpvar_3;
    tmpvar_42 = tmpvar_4;
    highp vec2 tmpvar_43;
    tmpvar_43 = (tmpvar_13.xy + tmpvar_13.zw);
    lowp vec2 tmpvar_44;
    tmpvar_44 = clamp (tmpvar_41, tmpvar_13.xy, tmpvar_43);
    lowp vec2 tmpvar_45;
    tmpvar_45 = clamp ((tmpvar_41 + tmpvar_42), tmpvar_13.xy, tmpvar_43);
    lowp vec4 tmpvar_46;
    tmpvar_46 = (vec4(2.0, 2.0, 2.0, 2.0) * tmpvar_40);
    tmpvar_41 = (tmpvar_41 - tmpvar_46.xy);
    tmpvar_42 = (tmpvar_42 + (tmpvar_46.xy + tmpvar_46.zw));
    lowp vec2 tmpvar_47;
    tmpvar_47 = (tmpvar_41 + (tmpvar_42 * aPosition.xy));
    lowp vec4 tmpvar_48;
    tmpvar_48.zw = vec2(0.0, 1.0);
    tmpvar_48.xy = tmpvar_47;
    highp vec4 tmpvar_49;
    tmpvar_49 = (tmpvar_33 * tmpvar_48);
    highp vec4 tmpvar_50;
    tmpvar_50.xy = ((tmpvar_49.xy * tmpvar_24.y) + ((tmpvar_23.xy - tmpvar_24.zw) * tmpvar_49.w));
    tmpvar_50.z = (tmpvar_9 * tmpvar_49.w);
    tmpvar_50.w = tmpvar_49.w;
    gl_Position = (uTransform * tmpvar_50);
    highp vec4 tmpvar_51;
    tmpvar_51.xy = clamp (tmpvar_12.xy, tmpvar_13.xy, tmpvar_43);
    tmpvar_51.zw = clamp ((tmpvar_12.xy + tmpvar_12.zw), tmpvar_13.xy, tmpvar_43);
    lowp vec4 tmpvar_52;
    tmpvar_52.xy = tmpvar_44;
    tmpvar_52.zw = tmpvar_45;
    vTransformBounds = mix (tmpvar_51, tmpvar_52, tmpvar_40);
    tmpvar_1 = tmpvar_47;
    tmpvar_2 = tmpvar_49;
  };
  vec4 tmpvar_53;
  tmpvar_53.xy = tmpvar_25.p0;
  tmpvar_53.zw = (tmpvar_25.p0 + tmpvar_25.size);
  vClipMaskUvBounds = tmpvar_53;
  highp vec4 tmpvar_54;
  tmpvar_54.xy = ((tmpvar_2.xy * tmpvar_27) + (tmpvar_2.w * (tmpvar_25.p0 - tmpvar_28)));
  tmpvar_54.z = tmpvar_26;
  tmpvar_54.w = tmpvar_2.w;
  vClipMaskUv = tmpvar_54;
  lowp vec2 f_55;
  f_55 = ((tmpvar_1 - tmpvar_12.xy) / tmpvar_12.zw);
  highp ivec2 tmpvar_56;
  tmpvar_56.x = int((uint(mod (uint(tmpvar_17.y), 1024u))));
  tmpvar_56.y = int((uint(tmpvar_17.y) / 1024u));
  highp vec4 tmpvar_57;
  tmpvar_57 = texelFetch (sGpuCache, tmpvar_56, 0);
  highp int tmpvar_58;
  highp int tmpvar_59;
  tmpvar_58 = int(tmpvar_57.y);
  tmpvar_59 = int(tmpvar_57.z);
  vCoefficient = tmpvar_57.x;
  if ((tmpvar_58 == 0)) {
    vYuvColorMatrix = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.39176, 2.01723, 1.59603, -0.81297, 0.0);
  } else {
    if ((tmpvar_58 == 1)) {
      vYuvColorMatrix = mat3(1.16438, 1.16438, 1.16438, 0.0, -0.21325, 2.1124, 1.79274, -0.53291, 0.0);
    } else {
      vYuvColorMatrix = mat3(1.164384, 1.164384, 1.164384, 0.0, -0.1873261, 2.141772, 1.678674, -0.6504243, 0.0);
    };
  };
  vFormat = tmpvar_59;
  vLocalPos = tmpvar_1;
  if ((tmpvar_59 == 1)) {
    lowp vec2 texture_size_60;
    texture_size_60 = vec2(textureSize (sColor0, 0));
    lowp vec3 uv_61;
    highp ivec2 tmpvar_62;
    tmpvar_62.x = int((uint(mod (uint(tmpvar_18.x), 1024u))));
    tmpvar_62.y = int((uint(tmpvar_18.x) / 1024u));
    highp vec4 tmpvar_63;
    tmpvar_63 = texelFetch (sGpuCache, tmpvar_62, 0);
    highp float tmpvar_64;
    tmpvar_64 = texelFetch (sGpuCache, (tmpvar_62 + ivec2(1, 0)), 0).x;
    lowp float tmpvar_65;
    tmpvar_65 = tmpvar_64;
    uv_61.z = tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66.xy = (tmpvar_63.xy + vec2(0.5, 0.5));
    tmpvar_66.zw = (tmpvar_63.zw - vec2(0.5, 0.5));
    uv_61.xy = (mix (tmpvar_63.xy, tmpvar_63.zw, f_55) / texture_size_60);
    vUv_Y = uv_61;
    vUvBounds_Y = (tmpvar_66 / texture_size_60.xyxy);
    lowp vec2 texture_size_67;
    texture_size_67 = vec2(textureSize (sColor1, 0));
    lowp vec3 uv_68;
    highp ivec2 tmpvar_69;
    tmpvar_69.x = int((uint(mod (uint(tmpvar_18.y), 1024u))));
    tmpvar_69.y = int((uint(tmpvar_18.y) / 1024u));
    highp vec4 tmpvar_70;
    tmpvar_70 = texelFetch (sGpuCache, tmpvar_69, 0);
    highp float tmpvar_71;
    tmpvar_71 = texelFetch (sGpuCache, (tmpvar_69 + ivec2(1, 0)), 0).x;
    lowp float tmpvar_72;
    tmpvar_72 = tmpvar_71;
    uv_68.z = tmpvar_72;
    lowp vec4 tmpvar_73;
    tmpvar_73.xy = (tmpvar_70.xy + vec2(0.5, 0.5));
    tmpvar_73.zw = (tmpvar_70.zw - vec2(0.5, 0.5));
    uv_68.xy = (mix (tmpvar_70.xy, tmpvar_70.zw, f_55) / texture_size_67);
    vUv_U = uv_68;
    vUvBounds_U = (tmpvar_73 / texture_size_67.xyxy);
    lowp vec2 texture_size_74;
    texture_size_74 = vec2(textureSize (sColor2, 0));
    lowp vec3 uv_75;
    highp ivec2 tmpvar_76;
    tmpvar_76.x = int((uint(mod (uint(tmpvar_18.z), 1024u))));
    tmpvar_76.y = int((uint(tmpvar_18.z) / 1024u));
    highp vec4 tmpvar_77;
    tmpvar_77 = texelFetch (sGpuCache, tmpvar_76, 0);
    highp float tmpvar_78;
    tmpvar_78 = texelFetch (sGpuCache, (tmpvar_76 + ivec2(1, 0)), 0).x;
    lowp float tmpvar_79;
    tmpvar_79 = tmpvar_78;
    uv_75.z = tmpvar_79;
    lowp vec4 tmpvar_80;
    tmpvar_80.xy = (tmpvar_77.xy + vec2(0.5, 0.5));
    tmpvar_80.zw = (tmpvar_77.zw - vec2(0.5, 0.5));
    uv_75.xy = (mix (tmpvar_77.xy, tmpvar_77.zw, f_55) / texture_size_74);
    vUv_V = uv_75;
    vUvBounds_V = (tmpvar_80 / texture_size_74.xyxy);
  } else {
    if ((tmpvar_59 == 0)) {
      lowp vec2 texture_size_81;
      texture_size_81 = vec2(textureSize (sColor0, 0));
      lowp vec3 uv_82;
      highp ivec2 tmpvar_83;
      tmpvar_83.x = int((uint(mod (uint(tmpvar_18.x), 1024u))));
      tmpvar_83.y = int((uint(tmpvar_18.x) / 1024u));
      highp vec4 tmpvar_84;
      tmpvar_84 = texelFetch (sGpuCache, tmpvar_83, 0);
      highp float tmpvar_85;
      tmpvar_85 = texelFetch (sGpuCache, (tmpvar_83 + ivec2(1, 0)), 0).x;
      lowp float tmpvar_86;
      tmpvar_86 = tmpvar_85;
      uv_82.z = tmpvar_86;
      lowp vec4 tmpvar_87;
      tmpvar_87.xy = (tmpvar_84.xy + vec2(0.5, 0.5));
      tmpvar_87.zw = (tmpvar_84.zw - vec2(0.5, 0.5));
      uv_82.xy = (mix (tmpvar_84.xy, tmpvar_84.zw, f_55) / texture_size_81);
      vUv_Y = uv_82;
      vUvBounds_Y = (tmpvar_87 / texture_size_81.xyxy);
      lowp vec2 texture_size_88;
      texture_size_88 = vec2(textureSize (sColor1, 0));
      lowp vec3 uv_89;
      highp ivec2 tmpvar_90;
      tmpvar_90.x = int((uint(mod (uint(tmpvar_18.y), 1024u))));
      tmpvar_90.y = int((uint(tmpvar_18.y) / 1024u));
      highp vec4 tmpvar_91;
      tmpvar_91 = texelFetch (sGpuCache, tmpvar_90, 0);
      highp float tmpvar_92;
      tmpvar_92 = texelFetch (sGpuCache, (tmpvar_90 + ivec2(1, 0)), 0).x;
      lowp float tmpvar_93;
      tmpvar_93 = tmpvar_92;
      uv_89.z = tmpvar_93;
      lowp vec4 tmpvar_94;
      tmpvar_94.xy = (tmpvar_91.xy + vec2(0.5, 0.5));
      tmpvar_94.zw = (tmpvar_91.zw - vec2(0.5, 0.5));
      uv_89.xy = (mix (tmpvar_91.xy, tmpvar_91.zw, f_55) / texture_size_88);
      vUv_U = uv_89;
      vUvBounds_U = (tmpvar_94 / texture_size_88.xyxy);
    } else {
      if ((tmpvar_59 == 2)) {
        lowp vec2 texture_size_95;
        texture_size_95 = vec2(textureSize (sColor0, 0));
        lowp vec3 uv_96;
        highp ivec2 tmpvar_97;
        tmpvar_97.x = int((uint(mod (uint(tmpvar_18.x), 1024u))));
        tmpvar_97.y = int((uint(tmpvar_18.x) / 1024u));
        highp vec4 tmpvar_98;
        tmpvar_98 = texelFetch (sGpuCache, tmpvar_97, 0);
        highp float tmpvar_99;
        tmpvar_99 = texelFetch (sGpuCache, (tmpvar_97 + ivec2(1, 0)), 0).x;
        lowp float tmpvar_100;
        tmpvar_100 = tmpvar_99;
        uv_96.z = tmpvar_100;
        lowp vec4 tmpvar_101;
        tmpvar_101.xy = (tmpvar_98.xy + vec2(0.5, 0.5));
        tmpvar_101.zw = (tmpvar_98.zw - vec2(0.5, 0.5));
        uv_96.xy = (mix (tmpvar_98.xy, tmpvar_98.zw, f_55) / texture_size_95);
        vUv_Y = uv_96;
        vUvBounds_Y = (tmpvar_101 / texture_size_95.xyxy);
      };
    };
  };
}

