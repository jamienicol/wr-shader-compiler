#version 300 es
precision highp sampler2DArray;
uniform highp mat4 uTransform;
in highp vec2 aPosition;
flat out highp vec4 vColor0;
flat out highp vec4 vColor1;
flat out highp vec4 vColorLine;
flat out highp int vMixColors;
flat out highp vec4 vClipCenter_Sign;
flat out highp vec4 vClipRadii;
flat out highp vec4 vHorizontalClipCenter_Sign;
flat out highp vec2 vHorizontalClipRadii;
flat out highp vec4 vVerticalClipCenter_Sign;
flat out highp vec2 vVerticalClipRadii;
out highp vec2 vPos;
in highp vec2 aTaskOrigin;
in highp vec4 aRect;
in highp vec4 aColor0;
in highp vec4 aColor1;
in highp int aFlags;
in highp vec2 aWidths;
in highp vec2 aRadii;
in highp vec4 aClipParams1;
in highp vec4 aClipParams2;
void main ()
{
  highp int mix_colors_1;
  int tmpvar_2;
  tmpvar_2 = (aFlags & 255);
  bool tmpvar_3;
  tmpvar_3 = (((aFlags >> 24) & 240) != 0);
  highp vec2 p_4;
  bool tmpvar_5;
  tmpvar_5 = bool(0);
  while (true) {
    tmpvar_5 = (tmpvar_5 || (0 == tmpvar_2));
    if (tmpvar_5) {
      p_4 = vec2(0.0, 0.0);
      break;
    };
    tmpvar_5 = (tmpvar_5 || (1 == tmpvar_2));
    if (tmpvar_5) {
      p_4 = vec2(1.0, 0.0);
      break;
    };
    tmpvar_5 = (tmpvar_5 || (2 == tmpvar_2));
    if (tmpvar_5) {
      p_4 = vec2(1.0, 1.0);
      break;
    };
    tmpvar_5 = (tmpvar_5 || (3 == tmpvar_2));
    if (tmpvar_5) {
      p_4 = vec2(0.0, 1.0);
      break;
    };
    tmpvar_5 = bool(1);
    p_4 = vec2(0.0, 0.0);
    break;
  };
  vec2 tmpvar_6;
  tmpvar_6 = (p_4 * aRect.zw);
  vec2 tmpvar_7;
  tmpvar_7 = (1.0 - (2.0 * p_4));
  bool tmpvar_8;
  tmpvar_8 = bool(0);
  while (true) {
    tmpvar_8 = (tmpvar_8 || (0 == tmpvar_2));
    tmpvar_8 = (tmpvar_8 || (1 == tmpvar_2));
    tmpvar_8 = (tmpvar_8 || (2 == tmpvar_2));
    tmpvar_8 = (tmpvar_8 || (3 == tmpvar_2));
    if (tmpvar_8) {
      int tmpvar_9;
      if (tmpvar_3) {
        tmpvar_9 = 1;
      } else {
        tmpvar_9 = 2;
      };
      mix_colors_1 = tmpvar_9;
      break;
    };
    tmpvar_8 = bool(1);
    mix_colors_1 = 0;
    break;
  };
  vMixColors = mix_colors_1;
  vPos = (aRect.zw * aPosition);
  vColor0 = aColor0;
  vColor1 = aColor1;
  vec4 tmpvar_10;
  tmpvar_10.xy = (tmpvar_6 + (tmpvar_7 * aRadii));
  tmpvar_10.zw = tmpvar_7;
  vClipCenter_Sign = tmpvar_10;
  vec4 tmpvar_11;
  tmpvar_11.xy = aRadii;
  tmpvar_11.zw = max ((aRadii - aWidths), 0.0);
  vClipRadii = tmpvar_11;
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_6;
  tmpvar_12.z = (aWidths.y * -(tmpvar_7.y));
  tmpvar_12.w = (aWidths.x * tmpvar_7.x);
  vColorLine = tmpvar_12;
  vec2 tmpvar_13;
  tmpvar_13.x = -(tmpvar_7.x);
  tmpvar_13.y = tmpvar_7.y;
  vec4 tmpvar_14;
  tmpvar_14.xy = (aClipParams1.xy + (tmpvar_13 * aClipParams1.zw));
  tmpvar_14.zw = tmpvar_13;
  vHorizontalClipCenter_Sign = tmpvar_14;
  vHorizontalClipRadii = aClipParams1.zw;
  vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_7.x;
  tmpvar_15.y = -(tmpvar_7.y);
  vec4 tmpvar_16;
  tmpvar_16.xy = (aClipParams2.xy + (tmpvar_15 * aClipParams2.zw));
  tmpvar_16.zw = tmpvar_15;
  vVerticalClipCenter_Sign = tmpvar_16;
  vVerticalClipRadii = aClipParams2.zw;
  vec4 tmpvar_17;
  tmpvar_17.zw = vec2(0.0, 1.0);
  tmpvar_17.xy = ((aTaskOrigin + aRect.xy) + vPos);
  gl_Position = (uTransform * tmpvar_17);
}

