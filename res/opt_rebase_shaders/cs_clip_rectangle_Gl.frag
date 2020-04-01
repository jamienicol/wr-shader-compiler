#version 150
precision highp float;
out vec4 oFragColor;
flat in vec4 vTransformBounds;
in vec4 vLocalPos;
flat in vec4 vClipCenter_Radius_TL;
flat in vec4 vClipCenter_Radius_TR;
flat in vec4 vClipCenter_Radius_BL;
flat in vec4 vClipCenter_Radius_BR;
flat in float vClipMode;
void main ()
{
  float aa_range_1;
  vec2 tmpvar_2;
  tmpvar_2 = (vLocalPos.xy / vLocalPos.w);
  vec2 tmpvar_3;
  tmpvar_3 = (abs(dFdx(tmpvar_2)) + abs(dFdy(tmpvar_2)));
  aa_range_1 = (0.35355 * sqrt(dot (tmpvar_3, tmpvar_3)));
  vec2 tmpvar_4;
  tmpvar_4 = max ((vTransformBounds.xy - tmpvar_2), (tmpvar_2 - vTransformBounds.zw));
  vec2 tmpvar_5;
  tmpvar_5 = max (vec2(0.0, 0.0), tmpvar_4);
  vec2 tmpvar_6;
  tmpvar_6 = (abs(dFdx(tmpvar_2)) + abs(dFdy(tmpvar_2)));
  float tmpvar_7;
  float tmpvar_8;
  tmpvar_8 = ((0.5 * (
    sqrt(dot (tmpvar_5, tmpvar_5))
   + 
    min (0.0, max (tmpvar_4.x, tmpvar_4.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_6, tmpvar_6)
  )));
  if ((-0.4999 >= tmpvar_8)) {
    tmpvar_7 = 1.0;
  } else {
    if ((tmpvar_8 >= 0.4999)) {
      tmpvar_7 = 0.0;
    } else {
      tmpvar_7 = (0.5 + (tmpvar_8 * (
        ((0.8431027 * tmpvar_8) * tmpvar_8)
       - 1.144536)));
    };
  };
  float tmpvar_9;
  tmpvar_9 = -(aa_range_1);
  float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (lessThan (tmpvar_2, vClipCenter_Radius_TL.xy) == bvec2(1, 1));
  if (!(tmpvar_11)) {
    tmpvar_10 = tmpvar_9;
  } else {
    vec2 tmpvar_12;
    tmpvar_12 = (tmpvar_2 - vClipCenter_Radius_TL.xy);
    float dist_13;
    if ((greaterThanEqual (vec2(0.0, 0.0), vClipCenter_Radius_TL.zw) != bvec2(0, 0))) {
      dist_13 = sqrt(dot (tmpvar_12, tmpvar_12));
    } else {
      vec2 tmpvar_14;
      tmpvar_14 = (1.0/((vClipCenter_Radius_TL.zw * vClipCenter_Radius_TL.zw)));
      vec2 tmpvar_15;
      tmpvar_15 = ((2.0 * tmpvar_12) * tmpvar_14);
      dist_13 = ((dot (
        ((tmpvar_12 * tmpvar_12) * tmpvar_14)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_15, tmpvar_15)));
    };
    tmpvar_10 = max (min (max (dist_13, 
      -(aa_range_1)
    ), aa_range_1), tmpvar_9);
  };
  float tmpvar_16;
  bool tmpvar_17;
  tmpvar_17 = (lessThan ((vec2(-1.0, 1.0) * tmpvar_2), (vec2(-1.0, 1.0) * vClipCenter_Radius_TR.xy)) == bvec2(1, 1));
  if (!(tmpvar_17)) {
    tmpvar_16 = tmpvar_10;
  } else {
    vec2 tmpvar_18;
    tmpvar_18 = (tmpvar_2 - vClipCenter_Radius_TR.xy);
    float dist_19;
    if ((greaterThanEqual (vec2(0.0, 0.0), vClipCenter_Radius_TR.zw) != bvec2(0, 0))) {
      dist_19 = sqrt(dot (tmpvar_18, tmpvar_18));
    } else {
      vec2 tmpvar_20;
      tmpvar_20 = (1.0/((vClipCenter_Radius_TR.zw * vClipCenter_Radius_TR.zw)));
      vec2 tmpvar_21;
      tmpvar_21 = ((2.0 * tmpvar_18) * tmpvar_20);
      dist_19 = ((dot (
        ((tmpvar_18 * tmpvar_18) * tmpvar_20)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_21, tmpvar_21)));
    };
    tmpvar_16 = max (min (max (dist_19, 
      -(aa_range_1)
    ), aa_range_1), tmpvar_10);
  };
  float tmpvar_22;
  bool tmpvar_23;
  tmpvar_23 = (lessThan (-(tmpvar_2), -(vClipCenter_Radius_BR.xy)) == bvec2(1, 1));
  if (!(tmpvar_23)) {
    tmpvar_22 = tmpvar_16;
  } else {
    vec2 tmpvar_24;
    tmpvar_24 = (tmpvar_2 - vClipCenter_Radius_BR.xy);
    float dist_25;
    if ((greaterThanEqual (vec2(0.0, 0.0), vClipCenter_Radius_BR.zw) != bvec2(0, 0))) {
      dist_25 = sqrt(dot (tmpvar_24, tmpvar_24));
    } else {
      vec2 tmpvar_26;
      tmpvar_26 = (1.0/((vClipCenter_Radius_BR.zw * vClipCenter_Radius_BR.zw)));
      vec2 tmpvar_27;
      tmpvar_27 = ((2.0 * tmpvar_24) * tmpvar_26);
      dist_25 = ((dot (
        ((tmpvar_24 * tmpvar_24) * tmpvar_26)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_27, tmpvar_27)));
    };
    tmpvar_22 = max (min (max (dist_25, 
      -(aa_range_1)
    ), aa_range_1), tmpvar_16);
  };
  float tmpvar_28;
  bool tmpvar_29;
  tmpvar_29 = (lessThan ((vec2(1.0, -1.0) * tmpvar_2), (vec2(1.0, -1.0) * vClipCenter_Radius_BL.xy)) == bvec2(1, 1));
  if (!(tmpvar_29)) {
    tmpvar_28 = tmpvar_22;
  } else {
    vec2 tmpvar_30;
    tmpvar_30 = (tmpvar_2 - vClipCenter_Radius_BL.xy);
    float dist_31;
    if ((greaterThanEqual (vec2(0.0, 0.0), vClipCenter_Radius_BL.zw) != bvec2(0, 0))) {
      dist_31 = sqrt(dot (tmpvar_30, tmpvar_30));
    } else {
      vec2 tmpvar_32;
      tmpvar_32 = (1.0/((vClipCenter_Radius_BL.zw * vClipCenter_Radius_BL.zw)));
      vec2 tmpvar_33;
      tmpvar_33 = ((2.0 * tmpvar_30) * tmpvar_32);
      dist_31 = ((dot (
        ((tmpvar_30 * tmpvar_30) * tmpvar_32)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_33, tmpvar_33)));
    };
    tmpvar_28 = max (min (max (dist_31, 
      -(aa_range_1)
    ), aa_range_1), tmpvar_22);
  };
  float tmpvar_34;
  float tmpvar_35;
  tmpvar_35 = ((0.5 * tmpvar_28) / aa_range_1);
  if ((-0.4999 >= tmpvar_35)) {
    tmpvar_34 = 1.0;
  } else {
    if ((tmpvar_35 >= 0.4999)) {
      tmpvar_34 = 0.0;
    } else {
      tmpvar_34 = (0.5 + (tmpvar_35 * (
        ((0.8431027 * tmpvar_35) * tmpvar_35)
       - 1.144536)));
    };
  };
  float tmpvar_36;
  tmpvar_36 = (tmpvar_7 * tmpvar_34);
  float tmpvar_37;
  tmpvar_37 = mix (tmpvar_36, (1.0 - tmpvar_36), vClipMode);
  float tmpvar_38;
  if ((0.0 < vLocalPos.w)) {
    tmpvar_38 = tmpvar_37;
  } else {
    tmpvar_38 = 0.0;
  };
  vec4 tmpvar_39;
  tmpvar_39.yzw = vec3(0.0, 0.0, 1.0);
  tmpvar_39.x = tmpvar_38;
  oFragColor = tmpvar_39;
}

