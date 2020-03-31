#version 150
precision highp float;
out vec4 oFragColor;
in vec4 vLocalPos;
flat in vec3 vClipParams;
flat in float vClipMode;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = (vLocalPos.xy / vLocalPos.w);
  vec2 tmpvar_2;
  tmpvar_2 = (abs(dFdx(tmpvar_1)) + abs(dFdy(tmpvar_1)));
  vec2 tmpvar_3;
  tmpvar_3 = (abs(tmpvar_1) - vClipParams.xy);
  vec2 tmpvar_4;
  tmpvar_4 = max (tmpvar_3, vec2(0.0, 0.0));
  float tmpvar_5;
  float tmpvar_6;
  tmpvar_6 = ((0.5 * (
    (sqrt(dot (tmpvar_4, tmpvar_4)) + min (max (tmpvar_3.x, tmpvar_3.y), 0.0))
   - vClipParams.z)) / (0.35355 * sqrt(
    dot (tmpvar_2, tmpvar_2)
  )));
  if ((-0.4999 >= tmpvar_6)) {
    tmpvar_5 = 1.0;
  } else {
    if ((tmpvar_6 >= 0.4999)) {
      tmpvar_5 = 0.0;
    } else {
      tmpvar_5 = (0.5 + (tmpvar_6 * (
        ((0.8431027 * tmpvar_6) * tmpvar_6)
       - 1.144536)));
    };
  };
  float tmpvar_7;
  tmpvar_7 = mix (tmpvar_5, (1.0 - tmpvar_5), vClipMode);
  float tmpvar_8;
  if ((0.0 < vLocalPos.w)) {
    tmpvar_8 = tmpvar_7;
  } else {
    tmpvar_8 = 0.0;
  };
  vec4 tmpvar_9;
  tmpvar_9.yzw = vec3(0.0, 0.0, 1.0);
  tmpvar_9.x = tmpvar_8;
  oFragColor = tmpvar_9;
}

