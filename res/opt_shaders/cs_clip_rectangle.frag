#version 310 es
precision highp float;
precision highp sampler2DArray;
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
  if ((tmpvar_8 <= -0.4999)) {
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
  float current_distance_9;
  current_distance_9 = -(aa_range_1);
  float tmpvar_10;
  bvec2 tmpvar_11;
  tmpvar_11 = lessThan (tmpvar_2, vClipCenter_Radius_TL.xy);
  bool tmpvar_12;
  tmpvar_12 = (tmpvar_11.x && tmpvar_11.y);
  if (!(tmpvar_12)) {
    tmpvar_10 = current_distance_9;
  } else {
    vec2 p_13;
    p_13 = (tmpvar_2 - vClipCenter_Radius_TL.xy);
    float dist_14;
    if (any(lessThanEqual (vClipCenter_Radius_TL.zw, vec2(0.0, 0.0)))) {
      dist_14 = sqrt(dot (p_13, p_13));
    } else {
      vec2 tmpvar_15;
      tmpvar_15 = (1.0/((vClipCenter_Radius_TL.zw * vClipCenter_Radius_TL.zw)));
      vec2 tmpvar_16;
      tmpvar_16 = ((2.0 * p_13) * tmpvar_15);
      dist_14 = ((dot (
        ((p_13 * p_13) * tmpvar_15)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_16, tmpvar_16)));
    };
    tmpvar_10 = max (clamp (dist_14, -(aa_range_1), aa_range_1), current_distance_9);
  };
  float tmpvar_17;
  bvec2 tmpvar_18;
  tmpvar_18 = lessThan ((vec2(-1.0, 1.0) * tmpvar_2), (vec2(-1.0, 1.0) * vClipCenter_Radius_TR.xy));
  bool tmpvar_19;
  tmpvar_19 = (tmpvar_18.x && tmpvar_18.y);
  if (!(tmpvar_19)) {
    tmpvar_17 = tmpvar_10;
  } else {
    vec2 p_20;
    p_20 = (tmpvar_2 - vClipCenter_Radius_TR.xy);
    float dist_21;
    if (any(lessThanEqual (vClipCenter_Radius_TR.zw, vec2(0.0, 0.0)))) {
      dist_21 = sqrt(dot (p_20, p_20));
    } else {
      vec2 tmpvar_22;
      tmpvar_22 = (1.0/((vClipCenter_Radius_TR.zw * vClipCenter_Radius_TR.zw)));
      vec2 tmpvar_23;
      tmpvar_23 = ((2.0 * p_20) * tmpvar_22);
      dist_21 = ((dot (
        ((p_20 * p_20) * tmpvar_22)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_23, tmpvar_23)));
    };
    tmpvar_17 = max (clamp (dist_21, -(aa_range_1), aa_range_1), tmpvar_10);
  };
  float tmpvar_24;
  bvec2 tmpvar_25;
  tmpvar_25 = lessThan (-(tmpvar_2), -(vClipCenter_Radius_BR.xy));
  bool tmpvar_26;
  tmpvar_26 = (tmpvar_25.x && tmpvar_25.y);
  if (!(tmpvar_26)) {
    tmpvar_24 = tmpvar_17;
  } else {
    vec2 p_27;
    p_27 = (tmpvar_2 - vClipCenter_Radius_BR.xy);
    float dist_28;
    if (any(lessThanEqual (vClipCenter_Radius_BR.zw, vec2(0.0, 0.0)))) {
      dist_28 = sqrt(dot (p_27, p_27));
    } else {
      vec2 tmpvar_29;
      tmpvar_29 = (1.0/((vClipCenter_Radius_BR.zw * vClipCenter_Radius_BR.zw)));
      vec2 tmpvar_30;
      tmpvar_30 = ((2.0 * p_27) * tmpvar_29);
      dist_28 = ((dot (
        ((p_27 * p_27) * tmpvar_29)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_30, tmpvar_30)));
    };
    tmpvar_24 = max (clamp (dist_28, -(aa_range_1), aa_range_1), tmpvar_17);
  };
  float tmpvar_31;
  bvec2 tmpvar_32;
  tmpvar_32 = lessThan ((vec2(1.0, -1.0) * tmpvar_2), (vec2(1.0, -1.0) * vClipCenter_Radius_BL.xy));
  bool tmpvar_33;
  tmpvar_33 = (tmpvar_32.x && tmpvar_32.y);
  if (!(tmpvar_33)) {
    tmpvar_31 = tmpvar_24;
  } else {
    vec2 p_34;
    p_34 = (tmpvar_2 - vClipCenter_Radius_BL.xy);
    float dist_35;
    if (any(lessThanEqual (vClipCenter_Radius_BL.zw, vec2(0.0, 0.0)))) {
      dist_35 = sqrt(dot (p_34, p_34));
    } else {
      vec2 tmpvar_36;
      tmpvar_36 = (1.0/((vClipCenter_Radius_BL.zw * vClipCenter_Radius_BL.zw)));
      vec2 tmpvar_37;
      tmpvar_37 = ((2.0 * p_34) * tmpvar_36);
      dist_35 = ((dot (
        ((p_34 * p_34) * tmpvar_36)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_37, tmpvar_37)));
    };
    tmpvar_31 = max (clamp (dist_35, -(aa_range_1), aa_range_1), tmpvar_24);
  };
  float tmpvar_38;
  float tmpvar_39;
  tmpvar_39 = ((0.5 * tmpvar_31) / aa_range_1);
  if ((tmpvar_39 <= -0.4999)) {
    tmpvar_38 = 1.0;
  } else {
    if ((tmpvar_39 >= 0.4999)) {
      tmpvar_38 = 0.0;
    } else {
      tmpvar_38 = (0.5 + (tmpvar_39 * (
        ((0.8431027 * tmpvar_39) * tmpvar_39)
       - 1.144536)));
    };
  };
  float tmpvar_40;
  tmpvar_40 = (tmpvar_7 * tmpvar_38);
  float tmpvar_41;
  tmpvar_41 = mix (tmpvar_40, (1.0 - tmpvar_40), vClipMode);
  float tmpvar_42;
  if ((vLocalPos.w > 0.0)) {
    tmpvar_42 = tmpvar_41;
  } else {
    tmpvar_42 = 0.0;
  };
  vec4 tmpvar_43;
  tmpvar_43.yzw = vec3(0.0, 0.0, 1.0);
  tmpvar_43.x = tmpvar_42;
  oFragColor = tmpvar_43;
}

