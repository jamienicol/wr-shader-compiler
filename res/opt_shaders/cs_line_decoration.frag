#version 300 es
precision highp float;
precision highp sampler2DArray;
out vec4 oFragColor;
in vec2 vLocalPos;
flat in highp int vStyle;
flat in vec4 vParams;
void main ()
{
  float alpha_1;
  vec2 pos_2;
  pos_2 = vLocalPos;
  float tmpvar_3;
  vec2 tmpvar_4;
  tmpvar_4 = (abs(dFdx(vLocalPos)) + abs(dFdy(vLocalPos)));
  tmpvar_3 = (0.35355 * sqrt(dot (tmpvar_4, tmpvar_4)));
  alpha_1 = 1.0;
  bool tmpvar_5;
  tmpvar_5 = bool(0);
  bool tmpvar_6;
  tmpvar_6 = bool(0);
  if ((0 == vStyle)) tmpvar_5 = bool(1);
  if (tmpvar_6) tmpvar_5 = bool(0);
  if (tmpvar_5) {
    tmpvar_6 = bool(1);
  };
  if ((2 == vStyle)) tmpvar_5 = bool(1);
  if (tmpvar_6) tmpvar_5 = bool(0);
  if (tmpvar_5) {
    alpha_1 = float((vParams.y >= floor(
      (vLocalPos.x + 0.5)
    )));
    tmpvar_6 = bool(1);
  };
  if ((1 == vStyle)) tmpvar_5 = bool(1);
  if (tmpvar_6) tmpvar_5 = bool(0);
  if (tmpvar_5) {
    vec2 tmpvar_7;
    tmpvar_7 = (vLocalPos - vParams.yz);
    float tmpvar_8;
    float tmpvar_9;
    tmpvar_9 = ((0.5 * (
      sqrt(dot (tmpvar_7, tmpvar_7))
     - vParams.y)) / tmpvar_3);
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
    alpha_1 = tmpvar_8;
    tmpvar_6 = bool(1);
  };
  if ((3 == vStyle)) tmpvar_5 = bool(1);
  if (tmpvar_6) tmpvar_5 = bool(0);
  if (tmpvar_5) {
    float tmpvar_10;
    tmpvar_10 = (vParams.y + vParams.z);
    float tmpvar_11;
    tmpvar_11 = (vParams.w / 2.0);
    float tmpvar_12;
    tmpvar_12 = (-2.0 * (float(
      (tmpvar_10 >= (float(mod (vLocalPos.x, (2.0 * tmpvar_10)))))
    ) - 0.5));
    float tmpvar_13;
    tmpvar_13 = (tmpvar_11 + ((tmpvar_11 - vParams.x) * tmpvar_12));
    pos_2.x = (float(mod (vLocalPos.x, tmpvar_10)));
    vec2 tmpvar_14;
    tmpvar_14.x = 0.0;
    tmpvar_14.y = tmpvar_13;
    vec2 tmpvar_15;
    tmpvar_15.x = 1.0;
    tmpvar_15.y = -(tmpvar_12);
    vec2 tmpvar_16;
    tmpvar_16.x = 0.0;
    tmpvar_16.y = tmpvar_13;
    vec2 tmpvar_17;
    tmpvar_17.x = 0.0;
    tmpvar_17.y = -(tmpvar_12);
    vec2 tmpvar_18;
    tmpvar_18.x = vParams.z;
    tmpvar_18.y = tmpvar_13;
    vec2 tmpvar_19;
    tmpvar_19.x = -1.0;
    tmpvar_19.y = -(tmpvar_12);
    float tmpvar_20;
    float tmpvar_21;
    tmpvar_21 = ((0.5 * (
      abs(max (max (dot (
        normalize(tmpvar_15)
      , 
        (tmpvar_14 - pos_2)
      ), dot (
        normalize(tmpvar_17)
      , 
        (tmpvar_16 - pos_2)
      )), dot (normalize(tmpvar_19), (tmpvar_18 - pos_2))))
     - vParams.x)) / tmpvar_3);
    if ((tmpvar_21 <= -0.4999)) {
      tmpvar_20 = 1.0;
    } else {
      if ((tmpvar_21 >= 0.4999)) {
        tmpvar_20 = 0.0;
      } else {
        tmpvar_20 = (0.5 + (tmpvar_21 * (
          ((0.8431027 * tmpvar_21) * tmpvar_21)
         - 1.144536)));
      };
    };
    alpha_1 = tmpvar_20;
    if ((vParams.x <= 1.0)) {
      alpha_1 = (1.0 - float((0.5 >= tmpvar_20)));
    };
    tmpvar_6 = bool(1);
  };
  tmpvar_5 = bool(1);
  if (tmpvar_6) tmpvar_5 = bool(0);
  if (tmpvar_5) {
    tmpvar_6 = bool(1);
  };
  oFragColor = vec4(alpha_1);
}

