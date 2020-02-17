#version 300 es
precision highp sampler2DArray;
struct RectWithSize {
  vec2 p0;
  vec2 size;
};
uniform mat4 uTransform;
in vec3 aPosition;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform sampler2DArray sPrevPassColor;
flat out vec4 vClipMaskUvBounds;
out highp vec4 vClipMaskUv;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
in highp ivec4 aData;
out highp vec2 vUv;
flat out highp vec2 vLayerAndPerspective;
flat out lowp vec4 vUvSampleBounds;
void main ()
{
  float tmpvar_1;
  tmpvar_1 = float(aData.z);
  highp ivec2 tmpvar_2;
  highp uint tmpvar_3;
  tmpvar_3 = uint(aData.y);
  tmpvar_2.x = int((uint(mod (tmpvar_3, 1024u))));
  tmpvar_2.y = int((tmpvar_3 / 1024u));
  highp vec4 tmpvar_4;
  tmpvar_4 = texelFetch (sGpuCache, tmpvar_2, 0);
  highp vec4 tmpvar_5;
  tmpvar_5 = texelFetch (sGpuCache, (tmpvar_2 + ivec2(1, 0)), 0);
  highp ivec2 tmpvar_6;
  highp uint tmpvar_7;
  tmpvar_7 = uint(aData.x);
  tmpvar_6.x = int((2u * (uint(mod (tmpvar_7, 512u)))));
  tmpvar_6.y = int((tmpvar_7 / 512u));
  highp vec4 tmpvar_8;
  tmpvar_8 = texelFetch (sPrimitiveHeadersF, tmpvar_6, 0);
  highp ivec2 tmpvar_9;
  tmpvar_9.x = int((2u * (uint(mod (tmpvar_7, 512u)))));
  tmpvar_9.y = int((tmpvar_7 / 512u));
  highp ivec4 tmpvar_10;
  tmpvar_10 = texelFetch (sPrimitiveHeadersI, (tmpvar_9 + ivec2(1, 0)), 0);
  highp ivec2 tmpvar_11;
  highp uint tmpvar_12;
  tmpvar_12 = uint(aData.w);
  tmpvar_11.x = int((2u * (uint(mod (tmpvar_12, 512u)))));
  tmpvar_11.y = int((tmpvar_12 / 512u));
  highp vec4 tmpvar_13;
  tmpvar_13 = texelFetch (sRenderTasks, tmpvar_11, 0);
  highp vec4 tmpvar_14;
  tmpvar_14 = texelFetch (sRenderTasks, (tmpvar_11 + ivec2(1, 0)), 0);
  highp mat4 tmpvar_15;
  highp int tmpvar_16;
  tmpvar_16 = (texelFetch (sPrimitiveHeadersI, tmpvar_9, 0).z & 16777215);
  highp ivec2 tmpvar_17;
  tmpvar_17.x = int((8u * (uint(mod (
    uint(tmpvar_16)
  , 128u)))));
  tmpvar_17.y = int((uint(tmpvar_16) / 128u));
  tmpvar_15[0] = texelFetch (sTransformPalette, tmpvar_17, 0);
  tmpvar_15[1] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(1, 0)), 0);
  tmpvar_15[2] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(2, 0)), 0);
  tmpvar_15[3] = texelFetch (sTransformPalette, (tmpvar_17 + ivec2(3, 0)), 0);
  highp ivec2 tmpvar_18;
  tmpvar_18.x = int((uint(mod (uint(tmpvar_10.x), 1024u))));
  tmpvar_18.y = int((uint(tmpvar_10.x) / 1024u));
  highp vec4 tmpvar_19;
  tmpvar_19 = texelFetch (sGpuCache, tmpvar_18, 0);
  highp float tmpvar_20;
  tmpvar_20 = texelFetch (sGpuCache, (tmpvar_18 + ivec2(1, 0)), 0).x;
  RectWithSize tmpvar_21;
  highp float tmpvar_22;
  highp float tmpvar_23;
  highp vec2 tmpvar_24;
  if ((tmpvar_10.w >= 32767)) {
    tmpvar_21 = RectWithSize(vec2(0.0, 0.0), vec2(0.0, 0.0));
    tmpvar_22 = 0.0;
    tmpvar_23 = 0.0;
    tmpvar_24 = vec2(0.0, 0.0);
  } else {
    highp ivec2 tmpvar_25;
    tmpvar_25.x = int((2u * (uint(mod (
      uint(tmpvar_10.w)
    , 512u)))));
    tmpvar_25.y = int((uint(tmpvar_10.w) / 512u));
    highp vec4 tmpvar_26;
    tmpvar_26 = texelFetch (sRenderTasks, tmpvar_25, 0);
    highp vec4 tmpvar_27;
    tmpvar_27 = texelFetch (sRenderTasks, (tmpvar_25 + ivec2(1, 0)), 0);
    highp vec3 tmpvar_28;
    tmpvar_28 = tmpvar_27.yzw;
    tmpvar_21.p0 = tmpvar_26.xy;
    tmpvar_21.size = tmpvar_26.zw;
    tmpvar_22 = tmpvar_27.x;
    tmpvar_23 = tmpvar_28.x;
    tmpvar_24 = tmpvar_28.yz;
  };
  highp vec2 tmpvar_29;
  tmpvar_29 = mix (mix (tmpvar_4.xy, tmpvar_4.zw, aPosition.x), mix (tmpvar_5.zw, tmpvar_5.xy, aPosition.x), aPosition.y);
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 1.0);
  tmpvar_30.xy = tmpvar_29;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_15 * tmpvar_30);
  highp vec4 tmpvar_32;
  tmpvar_32.xy = (((tmpvar_13.xy - tmpvar_14.zw) * tmpvar_31.w) + (tmpvar_31.xy * tmpvar_14.y));
  tmpvar_32.z = (tmpvar_31.w * tmpvar_1);
  tmpvar_32.w = tmpvar_31.w;
  vec4 tmpvar_33;
  tmpvar_33.xy = tmpvar_21.p0;
  tmpvar_33.zw = (tmpvar_21.p0 + tmpvar_21.size);
  vClipMaskUvBounds = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.xy = ((tmpvar_31.xy * tmpvar_23) + (tmpvar_31.w * (tmpvar_21.p0 - tmpvar_24)));
  tmpvar_34.z = tmpvar_22;
  tmpvar_34.w = tmpvar_31.w;
  vClipMaskUv = tmpvar_34;
  gl_Position = (uTransform * tmpvar_32);
  lowp vec2 tmpvar_35;
  tmpvar_35 = vec3(textureSize (sPrevPassColor, 0)).xy;
  highp vec4 tmpvar_36;
  tmpvar_36.xy = (min (tmpvar_19.xy, tmpvar_19.zw) + vec2(0.5, 0.5));
  tmpvar_36.zw = (max (tmpvar_19.xy, tmpvar_19.zw) - vec2(0.5, 0.5));
  vUvSampleBounds = (tmpvar_36 / tmpvar_35.xyxy);
  highp vec2 tmpvar_37;
  tmpvar_37 = ((tmpvar_29 - tmpvar_8.xy) / tmpvar_8.zw);
  highp int address_38;
  address_38 = (tmpvar_10.x + 2);
  highp ivec2 tmpvar_39;
  tmpvar_39.x = int((uint(mod (uint(address_38), 1024u))));
  tmpvar_39.y = int((uint(address_38) / 1024u));
  highp vec4 tmpvar_40;
  tmpvar_40 = mix (mix (texelFetch (sGpuCache, tmpvar_39, 0), texelFetch (sGpuCache, (tmpvar_39 + ivec2(1, 0)), 0), tmpvar_37.x), mix (texelFetch (sGpuCache, (tmpvar_39 + ivec2(2, 0)), 0), texelFetch (sGpuCache, (tmpvar_39 + ivec2(3, 0)), 0), tmpvar_37.x), tmpvar_37.y);
  highp float tmpvar_41;
  tmpvar_41 = float(tmpvar_10.y);
  vUv = ((mix (tmpvar_19.xy, tmpvar_19.zw, 
    (tmpvar_40.xy / tmpvar_40.w)
  ) / tmpvar_35) * mix (gl_Position.w, 1.0, tmpvar_41));
  highp vec2 tmpvar_42;
  tmpvar_42.x = tmpvar_20;
  tmpvar_42.y = tmpvar_41;
  vLayerAndPerspective = tmpvar_42;
}

