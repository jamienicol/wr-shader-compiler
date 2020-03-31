#version 150
precision highp float;
out vec4 oFragColor;
in vec2 vLocalPos;
flat in int vStyle;
flat in vec4 vParams;
void main ()
{
  float alpha_1;
  float aa_range_2;
  vec2 pos_3;
  pos_3 = vLocalPos;
  vec2 tmpvar_4;
  tmpvar_4 = (abs(dFdx(vLocalPos)) + abs(dFdy(vLocalPos)));
  aa_range_2 = (0.35355 * sqrt(dot (tmpvar_4, tmpvar_4)));
  alpha_1 = 1.0;
  bool tmpvar_5;
  tmpvar_5 = bool(0);
  while (true) {
    tmpvar_5 = (tmpvar_5 || (0 == vStyle));
    if (tmpvar_5) {
      break;
    };
    tmpvar_5 = (tmpvar_5 || (2 == vStyle));
    if (tmpvar_5) {
      alpha_1 = float((vParams.y >= floor(
        (pos_3.x + 0.5)
      )));
      break;
    };
    tmpvar_5 = (tmpvar_5 || (1 == vStyle));
    if (tmpvar_5) {
      vec2 tmpvar_6;
      tmpvar_6 = (pos_3 - vParams.yz);
      float tmpvar_7;
      float tmpvar_8;
      tmpvar_8 = ((0.5 * (
        sqrt(dot (tmpvar_6, tmpvar_6))
       - vParams.y)) / aa_range_2);
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
      alpha_1 = tmpvar_7;
      break;
    };
    tmpvar_5 = (tmpvar_5 || (3 == vStyle));
    if (tmpvar_5) {
      float tmpvar_9;
      tmpvar_9 = (vParams.y + vParams.z);
      float tmpvar_10;
      tmpvar_10 = (vParams.w / 2.0);
      float tmpvar_11;
      tmpvar_11 = (-2.0 * (float(
        (tmpvar_9 >= (float(mod (pos_3.x, (2.0 * tmpvar_9)))))
      ) - 0.5));
      float tmpvar_12;
      tmpvar_12 = (tmpvar_10 + ((tmpvar_10 - vParams.x) * tmpvar_11));
      pos_3.x = (float(mod (pos_3.x, tmpvar_9)));
      vec2 tmpvar_13;
      tmpvar_13.x = 0.0;
      tmpvar_13.y = tmpvar_12;
      vec2 tmpvar_14;
      tmpvar_14.x = 1.0;
      tmpvar_14.y = -(tmpvar_11);
      vec2 tmpvar_15;
      tmpvar_15.x = 0.0;
      tmpvar_15.y = tmpvar_12;
      vec2 tmpvar_16;
      tmpvar_16.x = 0.0;
      tmpvar_16.y = -(tmpvar_11);
      vec2 tmpvar_17;
      tmpvar_17.x = vParams.z;
      tmpvar_17.y = tmpvar_12;
      vec2 tmpvar_18;
      tmpvar_18.x = -1.0;
      tmpvar_18.y = -(tmpvar_11);
      float tmpvar_19;
      float tmpvar_20;
      tmpvar_20 = ((0.5 * (
        abs(max (max (dot (
          (tmpvar_14 * inversesqrt(dot (tmpvar_14, tmpvar_14)))
        , 
          (tmpvar_13 - pos_3)
        ), dot (
          (tmpvar_16 * inversesqrt(dot (tmpvar_16, tmpvar_16)))
        , 
          (tmpvar_15 - pos_3)
        )), dot ((tmpvar_18 * 
          inversesqrt(dot (tmpvar_18, tmpvar_18))
        ), (tmpvar_17 - pos_3))))
       - vParams.x)) / aa_range_2);
      if ((-0.4999 >= tmpvar_20)) {
        tmpvar_19 = 1.0;
      } else {
        if ((tmpvar_20 >= 0.4999)) {
          tmpvar_19 = 0.0;
        } else {
          tmpvar_19 = (0.5 + (tmpvar_20 * (
            ((0.8431027 * tmpvar_20) * tmpvar_20)
           - 1.144536)));
        };
      };
      alpha_1 = tmpvar_19;
      if ((1.0 >= vParams.x)) {
        alpha_1 = (1.0 - float((0.5 >= tmpvar_19)));
      };
      break;
    };
    tmpvar_5 = bool(1);
    break;
  };
  oFragColor = vec4(alpha_1);
}

