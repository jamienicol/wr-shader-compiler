#version 300 es
precision highp float;
precision highp sampler2DArray;
out vec4 oFragColor;
flat in vec4 vColor0;
flat in vec4 vColor1;
flat in vec4 vColorLine;
flat in highp int vMixColors;
flat in vec4 vClipCenter_Sign;
flat in vec4 vClipRadii;
flat in vec4 vHorizontalClipCenter_Sign;
flat in vec2 vHorizontalClipRadii;
flat in vec4 vVerticalClipCenter_Sign;
flat in vec2 vVerticalClipRadii;
in vec2 vPos;
void main ()
{
  float d_1;
  vec2 clip_relative_pos_2;
  float mix_factor_3;
  float tmpvar_4;
  vec2 tmpvar_5;
  tmpvar_5 = (abs(dFdx(vPos)) + abs(dFdy(vPos)));
  tmpvar_4 = (0.35355 * sqrt(dot (tmpvar_5, tmpvar_5)));
  bool tmpvar_6;
  tmpvar_6 = (vMixColors != 2);
  mix_factor_3 = 0.0;
  if ((vMixColors != 0)) {
    float tmpvar_7;
    tmpvar_7 = dot (normalize(vColorLine.zw), (vColorLine.xy - vPos));
    if (tmpvar_6) {
      float tmpvar_8;
      float tmpvar_9;
      tmpvar_9 = ((0.5 * -(tmpvar_7)) / tmpvar_4);
      if ((tmpvar_9 <= -0.4999)) {
        tmpvar_8 = 1.0;
      } else {
        if ((tmpvar_9 >= 0.4999)) {
          tmpvar_8 = 0.0;
        } else {
          tmpvar_8 = (0.5 + (tmpvar_9 * (
            ((0.8431027 * tmpvar_9) * tmpvar_9)
           - 1.144536)));
        };
      };
      mix_factor_3 = tmpvar_8;
    } else {
      float tmpvar_10;
      if ((tmpvar_7 >= -0.0001)) {
        tmpvar_10 = 1.0;
      } else {
        tmpvar_10 = 0.0;
      };
      mix_factor_3 = tmpvar_10;
    };
  };
  vec2 tmpvar_11;
  tmpvar_11 = (vPos - vClipCenter_Sign.xy);
  clip_relative_pos_2 = tmpvar_11;
  bvec2 tmpvar_12;
  tmpvar_12 = lessThan ((vClipCenter_Sign.zw * tmpvar_11), vec2(0.0, 0.0));
  d_1 = -1.0;
  if ((tmpvar_12.x && tmpvar_12.y)) {
    float dist_13;
    if (any(lessThanEqual (vClipRadii.xy, vec2(0.0, 0.0)))) {
      dist_13 = sqrt(dot (tmpvar_11, tmpvar_11));
    } else {
      vec2 tmpvar_14;
      tmpvar_14 = (1.0/((vClipRadii.xy * vClipRadii.xy)));
      vec2 tmpvar_15;
      tmpvar_15 = ((2.0 * tmpvar_11) * tmpvar_14);
      dist_13 = ((dot (
        ((tmpvar_11 * tmpvar_11) * tmpvar_14)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_15, tmpvar_15)));
    };
    float tmpvar_16;
    tmpvar_16 = clamp (dist_13, -(tmpvar_4), tmpvar_4);
    float dist_17;
    if (any(lessThanEqual (vClipRadii.zw, vec2(0.0, 0.0)))) {
      dist_17 = sqrt(dot (tmpvar_11, tmpvar_11));
    } else {
      vec2 tmpvar_18;
      tmpvar_18 = (1.0/((vClipRadii.zw * vClipRadii.zw)));
      vec2 tmpvar_19;
      tmpvar_19 = ((2.0 * tmpvar_11) * tmpvar_18);
      dist_17 = ((dot (
        ((tmpvar_11 * tmpvar_11) * tmpvar_18)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_19, tmpvar_19)));
    };
    d_1 = max (tmpvar_16, -(clamp (dist_17, 
      -(tmpvar_4)
    , tmpvar_4)));
  };
  clip_relative_pos_2 = (vPos - vHorizontalClipCenter_Sign.xy);
  bvec2 tmpvar_20;
  tmpvar_20 = lessThan ((vHorizontalClipCenter_Sign.zw * clip_relative_pos_2), vec2(0.0, 0.0));
  if ((tmpvar_20.x && tmpvar_20.y)) {
    float dist_21;
    if (any(lessThanEqual (vHorizontalClipRadii, vec2(0.0, 0.0)))) {
      dist_21 = sqrt(dot (clip_relative_pos_2, clip_relative_pos_2));
    } else {
      vec2 tmpvar_22;
      tmpvar_22 = (1.0/((vHorizontalClipRadii * vHorizontalClipRadii)));
      vec2 tmpvar_23;
      tmpvar_23 = ((2.0 * clip_relative_pos_2) * tmpvar_22);
      dist_21 = ((dot (
        ((clip_relative_pos_2 * clip_relative_pos_2) * tmpvar_22)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_23, tmpvar_23)));
    };
    d_1 = max (clamp (dist_21, -(tmpvar_4), tmpvar_4), d_1);
  };
  clip_relative_pos_2 = (vPos - vVerticalClipCenter_Sign.xy);
  bvec2 tmpvar_24;
  tmpvar_24 = lessThan ((vVerticalClipCenter_Sign.zw * clip_relative_pos_2), vec2(0.0, 0.0));
  if ((tmpvar_24.x && tmpvar_24.y)) {
    float dist_25;
    if (any(lessThanEqual (vVerticalClipRadii, vec2(0.0, 0.0)))) {
      dist_25 = sqrt(dot (clip_relative_pos_2, clip_relative_pos_2));
    } else {
      vec2 tmpvar_26;
      tmpvar_26 = (1.0/((vVerticalClipRadii * vVerticalClipRadii)));
      vec2 tmpvar_27;
      tmpvar_27 = ((2.0 * clip_relative_pos_2) * tmpvar_26);
      dist_25 = ((dot (
        ((clip_relative_pos_2 * clip_relative_pos_2) * tmpvar_26)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_27, tmpvar_27)));
    };
    d_1 = max (clamp (dist_25, -(tmpvar_4), tmpvar_4), d_1);
  };
  float tmpvar_28;
  if (tmpvar_6) {
    float tmpvar_29;
    float tmpvar_30;
    tmpvar_30 = ((0.5 * d_1) / tmpvar_4);
    if ((tmpvar_30 <= -0.4999)) {
      tmpvar_29 = 1.0;
    } else {
      if ((tmpvar_30 >= 0.4999)) {
        tmpvar_29 = 0.0;
      } else {
        tmpvar_29 = (0.5 + (tmpvar_30 * (
          ((0.8431027 * tmpvar_30) * tmpvar_30)
         - 1.144536)));
      };
    };
    tmpvar_28 = tmpvar_29;
  } else {
    tmpvar_28 = 1.0;
  };
  oFragColor = (mix (vColor0, vColor1, mix_factor_3) * tmpvar_28);
}

