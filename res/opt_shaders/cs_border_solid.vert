#version 310 es
precision highp sampler2DArray;
uniform mat4 uTransform;
in vec3 aPosition;
flat out vec4 vColor0;
flat out vec4 vColor1;
flat out vec4 vColorLine;
flat out highp int vMixColors;
flat out vec4 vClipCenter_Sign;
flat out vec4 vClipRadii;
flat out vec4 vHorizontalClipCenter_Sign;
flat out vec2 vHorizontalClipRadii;
flat out vec4 vVerticalClipCenter_Sign;
flat out vec2 vVerticalClipRadii;
out vec2 vPos;
in vec2 aTaskOrigin;
in vec4 aRect;
in vec4 aColor0;
in vec4 aColor1;
in highp int aFlags;
in vec2 aWidths;
in vec2 aRadii;
in vec4 aClipParams1;
in vec4 aClipParams2;
void main ()
{
  highp int mix_colors_1;
  highp int tmpvar_2;
  tmpvar_2 = (aFlags & 255);
  bool tmpvar_3;
  tmpvar_3 = (((aFlags >> 24) & 240) != 0);
  vec2 p_4;
  bool tmpvar_5;
  tmpvar_5 = bool(0);
  bool tmpvar_6;
  tmpvar_6 = bool(0);
  if ((0 == tmpvar_2)) tmpvar_5 = bool(1);
  if (tmpvar_6) tmpvar_5 = bool(0);
  if (tmpvar_5) {
    p_4 = vec2(0.0, 0.0);
    tmpvar_6 = bool(1);
  };
  if ((1 == tmpvar_2)) tmpvar_5 = bool(1);
  if (tmpvar_6) tmpvar_5 = bool(0);
  if (tmpvar_5) {
    p_4 = vec2(1.0, 0.0);
    tmpvar_6 = bool(1);
  };
  if ((2 == tmpvar_2)) tmpvar_5 = bool(1);
  if (tmpvar_6) tmpvar_5 = bool(0);
  if (tmpvar_5) {
    p_4 = vec2(1.0, 1.0);
    tmpvar_6 = bool(1);
  };
  if ((3 == tmpvar_2)) tmpvar_5 = bool(1);
  if (tmpvar_6) tmpvar_5 = bool(0);
  if (tmpvar_5) {
    p_4 = vec2(0.0, 1.0);
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = bool(1);
  if (tmpvar_6) tmpvar_5 = bool(0);
  if (tmpvar_5) {
    p_4 = vec2(0.0, 0.0);
    tmpvar_6 = bool(1);
  };
  vec2 tmpvar_7;
  tmpvar_7 = (p_4 * aRect.zw);
  vec2 tmpvar_8;
  tmpvar_8 = (1.0 - (2.0 * p_4));
  bool tmpvar_9;
  tmpvar_9 = bool(0);
  bool tmpvar_10;
  tmpvar_10 = bool(0);
  if ((0 == tmpvar_2)) tmpvar_9 = bool(1);
  if ((1 == tmpvar_2)) tmpvar_9 = bool(1);
  if ((2 == tmpvar_2)) tmpvar_9 = bool(1);
  if ((3 == tmpvar_2)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    highp int tmpvar_11;
    if (tmpvar_3) {
      tmpvar_11 = 1;
    } else {
      tmpvar_11 = 2;
    };
    mix_colors_1 = tmpvar_11;
    tmpvar_10 = bool(1);
  };
  tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    mix_colors_1 = 0;
    tmpvar_10 = bool(1);
  };
  vMixColors = mix_colors_1;
  vPos = (aRect.zw * aPosition.xy);
  vColor0 = aColor0;
  vColor1 = aColor1;
  vec4 tmpvar_12;
  tmpvar_12.xy = (tmpvar_7 + (tmpvar_8 * aRadii));
  tmpvar_12.zw = tmpvar_8;
  vClipCenter_Sign = tmpvar_12;
  vec4 tmpvar_13;
  tmpvar_13.xy = aRadii;
  tmpvar_13.zw = max ((aRadii - aWidths), 0.0);
  vClipRadii = tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.xy = tmpvar_7;
  tmpvar_14.z = (aWidths.y * -(tmpvar_8.y));
  tmpvar_14.w = (aWidths.x * tmpvar_8.x);
  vColorLine = tmpvar_14;
  vec2 tmpvar_15;
  tmpvar_15.x = -(tmpvar_8.x);
  tmpvar_15.y = tmpvar_8.y;
  vec4 tmpvar_16;
  tmpvar_16.xy = (aClipParams1.xy + (tmpvar_15 * aClipParams1.zw));
  tmpvar_16.zw = tmpvar_15;
  vHorizontalClipCenter_Sign = tmpvar_16;
  vHorizontalClipRadii = aClipParams1.zw;
  vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_8.x;
  tmpvar_17.y = -(tmpvar_8.y);
  vec4 tmpvar_18;
  tmpvar_18.xy = (aClipParams2.xy + (tmpvar_17 * aClipParams2.zw));
  tmpvar_18.zw = tmpvar_17;
  vVerticalClipCenter_Sign = tmpvar_18;
  vVerticalClipRadii = aClipParams2.zw;
  vec4 tmpvar_19;
  tmpvar_19.zw = vec2(0.0, 1.0);
  tmpvar_19.xy = ((aTaskOrigin + aRect.xy) + vPos);
  gl_Position = (uTransform * tmpvar_19);
}

