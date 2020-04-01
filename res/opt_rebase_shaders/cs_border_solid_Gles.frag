#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
flat in highp vec4 vColor0;
flat in highp vec4 vColor1;
flat in highp vec4 vColorLine;
flat in mediump int vMixColors;
flat in highp vec4 vClipCenter_Sign;
flat in highp vec4 vClipRadii;
flat in highp vec4 vHorizontalClipCenter_Sign;
flat in highp vec2 vHorizontalClipRadii;
flat in highp vec4 vVerticalClipCenter_Sign;
flat in highp vec2 vVerticalClipRadii;
in highp vec2 vPos;
void main ()
{
  highp float d_1;
  highp vec2 clip_relative_pos_2;
  highp float mix_factor_3;
  float tmpvar_4;
  vec2 tmpvar_5;
  tmpvar_5 = (abs(dFdx(vPos)) + abs(dFdy(vPos)));
  tmpvar_4 = (0.35355 * sqrt(dot (tmpvar_5, tmpvar_5)));
  bool tmpvar_6;
  tmpvar_6 = (vMixColors != 2);
  mix_factor_3 = 0.0;
  if ((vMixColors != 0)) {
    float tmpvar_7;
    tmpvar_7 = dot ((vColorLine.zw * inversesqrt(
      dot (vColorLine.zw, vColorLine.zw)
    )), (vColorLine.xy - vPos));
    if (tmpvar_6) {
      float tmpvar_8;
      float tmpvar_9;
      tmpvar_9 = ((0.5 * -(tmpvar_7)) / tmpvar_4);
      if ((-0.4999 >= tmpvar_9)) {
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
  d_1 = -1.0;
  if ((lessThan ((vClipCenter_Sign.zw * tmpvar_11), vec2(0.0, 0.0)) == bvec2(1, 1))) {
    highp float dist_12;
    if ((greaterThanEqual (vec2(0.0, 0.0), vClipRadii.xy) != bvec2(0, 0))) {
      dist_12 = sqrt(dot (tmpvar_11, tmpvar_11));
    } else {
      vec2 tmpvar_13;
      tmpvar_13 = (1.0/((vClipRadii.xy * vClipRadii.xy)));
      vec2 tmpvar_14;
      tmpvar_14 = ((2.0 * tmpvar_11) * tmpvar_13);
      dist_12 = ((dot (
        ((tmpvar_11 * tmpvar_11) * tmpvar_13)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_14, tmpvar_14)));
    };
    float tmpvar_15;
    tmpvar_15 = min (max (dist_12, -(tmpvar_4)), tmpvar_4);
    highp float dist_16;
    if ((greaterThanEqual (vec2(0.0, 0.0), vClipRadii.zw) != bvec2(0, 0))) {
      dist_16 = sqrt(dot (tmpvar_11, tmpvar_11));
    } else {
      vec2 tmpvar_17;
      tmpvar_17 = (1.0/((vClipRadii.zw * vClipRadii.zw)));
      vec2 tmpvar_18;
      tmpvar_18 = ((2.0 * tmpvar_11) * tmpvar_17);
      dist_16 = ((dot (
        ((tmpvar_11 * tmpvar_11) * tmpvar_17)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_18, tmpvar_18)));
    };
    d_1 = max (tmpvar_15, -(min (
      max (dist_16, -(tmpvar_4))
    , tmpvar_4)));
  };
  clip_relative_pos_2 = (vPos - vHorizontalClipCenter_Sign.xy);
  if ((lessThan ((vHorizontalClipCenter_Sign.zw * clip_relative_pos_2), vec2(0.0, 0.0)) == bvec2(1, 1))) {
    highp float dist_19;
    if ((greaterThanEqual (vec2(0.0, 0.0), vHorizontalClipRadii) != bvec2(0, 0))) {
      dist_19 = sqrt(dot (clip_relative_pos_2, clip_relative_pos_2));
    } else {
      vec2 tmpvar_20;
      tmpvar_20 = (1.0/((vHorizontalClipRadii * vHorizontalClipRadii)));
      vec2 tmpvar_21;
      tmpvar_21 = ((2.0 * clip_relative_pos_2) * tmpvar_20);
      dist_19 = ((dot (
        ((clip_relative_pos_2 * clip_relative_pos_2) * tmpvar_20)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_21, tmpvar_21)));
    };
    d_1 = max (min (max (dist_19, 
      -(tmpvar_4)
    ), tmpvar_4), d_1);
  };
  clip_relative_pos_2 = (vPos - vVerticalClipCenter_Sign.xy);
  if ((lessThan ((vVerticalClipCenter_Sign.zw * clip_relative_pos_2), vec2(0.0, 0.0)) == bvec2(1, 1))) {
    highp float dist_22;
    if ((greaterThanEqual (vec2(0.0, 0.0), vVerticalClipRadii) != bvec2(0, 0))) {
      dist_22 = sqrt(dot (clip_relative_pos_2, clip_relative_pos_2));
    } else {
      vec2 tmpvar_23;
      tmpvar_23 = (1.0/((vVerticalClipRadii * vVerticalClipRadii)));
      vec2 tmpvar_24;
      tmpvar_24 = ((2.0 * clip_relative_pos_2) * tmpvar_23);
      dist_22 = ((dot (
        ((clip_relative_pos_2 * clip_relative_pos_2) * tmpvar_23)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_24, tmpvar_24)));
    };
    d_1 = max (min (max (dist_22, 
      -(tmpvar_4)
    ), tmpvar_4), d_1);
  };
  float tmpvar_25;
  if (tmpvar_6) {
    float tmpvar_26;
    float tmpvar_27;
    tmpvar_27 = ((0.5 * d_1) / tmpvar_4);
    if ((-0.4999 >= tmpvar_27)) {
      tmpvar_26 = 1.0;
    } else {
      if ((tmpvar_27 >= 0.4999)) {
        tmpvar_26 = 0.0;
      } else {
        tmpvar_26 = (0.5 + (tmpvar_27 * (
          ((0.8431027 * tmpvar_27) * tmpvar_27)
         - 1.144536)));
      };
    };
    tmpvar_25 = tmpvar_26;
  } else {
    tmpvar_25 = 1.0;
  };
  oFragColor = (mix (vColor0, vColor1, mix_factor_3) * tmpvar_25);
}

