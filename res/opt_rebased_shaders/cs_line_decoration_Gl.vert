#version 150
uniform mat4 uTransform;
in vec2 aPosition;
out vec2 vLocalPos;
flat out int vStyle;
flat out vec4 vParams;
in vec4 aTaskRect;
in vec2 aLocalSize;
in int aStyle;
in float aAxisSelect;
in float aWavyLineThickness;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = mix (aLocalSize, aLocalSize.yx, aAxisSelect);
  vStyle = aStyle;
  bool tmpvar_2;
  tmpvar_2 = bool(0);
  while (true) {
    tmpvar_2 = (tmpvar_2 || (0 == aStyle));
    if (tmpvar_2) {
      break;
    };
    tmpvar_2 = (tmpvar_2 || (2 == aStyle));
    if (tmpvar_2) {
      vec4 tmpvar_3;
      tmpvar_3.zw = vec2(0.0, 0.0);
      tmpvar_3.x = tmpvar_1.x;
      tmpvar_3.y = (0.5 * tmpvar_1.x);
      vParams = tmpvar_3;
      break;
    };
    tmpvar_2 = (tmpvar_2 || (1 == aStyle));
    if (tmpvar_2) {
      vec4 tmpvar_4;
      tmpvar_4.w = 0.0;
      tmpvar_4.x = (tmpvar_1.y * 2.0);
      tmpvar_4.y = (tmpvar_1.y / 2.0);
      tmpvar_4.z = (0.5 * tmpvar_1.y);
      vParams = tmpvar_4;
      break;
    };
    tmpvar_2 = (tmpvar_2 || (3 == aStyle));
    if (tmpvar_2) {
      float tmpvar_5;
      tmpvar_5 = max (aWavyLineThickness, 1.0);
      vec4 tmpvar_6;
      tmpvar_6.x = (tmpvar_5 / 2.0);
      tmpvar_6.y = (tmpvar_1.y - tmpvar_5);
      tmpvar_6.z = max (((tmpvar_5 - 1.0) * 2.0), 1.0);
      tmpvar_6.w = tmpvar_1.y;
      vParams = tmpvar_6;
      break;
    };
    tmpvar_2 = bool(1);
    vParams = vec4(0.0, 0.0, 0.0, 0.0);
    break;
  };
  vLocalPos = (mix (aPosition, aPosition.yx, aAxisSelect) * tmpvar_1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 1.0);
  tmpvar_7.xy = (aTaskRect.xy + (aTaskRect.zw * aPosition));
  gl_Position = (uTransform * tmpvar_7);
}

