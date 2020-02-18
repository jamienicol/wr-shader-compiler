#version 310 es
precision highp float;
precision highp sampler2DArray;
out lowp vec4 oFragColor;
uniform sampler2DArray sColor0;
flat in vec4 vTransformBounds;
in vec4 vLocalPos;
in vec2 vClipMaskImageUv;
flat in vec4 vClipMaskUvRect;
flat in vec4 vClipMaskUvInnerRect;
flat in float vLayer;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = (vLocalPos.xy / vLocalPos.w);
  float tmpvar_2;
  if ((vLocalPos.w > 0.0)) {
    vec2 tmpvar_3;
    tmpvar_3 = max ((vTransformBounds.xy - tmpvar_1), (tmpvar_1 - vTransformBounds.zw));
    vec2 tmpvar_4;
    tmpvar_4 = max (vec2(0.0, 0.0), tmpvar_3);
    vec2 tmpvar_5;
    tmpvar_5 = (abs(dFdx(tmpvar_1)) + abs(dFdy(tmpvar_1)));
    float tmpvar_6;
    float tmpvar_7;
    tmpvar_7 = ((0.5 * (
      sqrt(dot (tmpvar_4, tmpvar_4))
     + 
      min (0.0, max (tmpvar_3.x, tmpvar_3.y))
    )) / (0.35355 * sqrt(
      dot (tmpvar_5, tmpvar_5)
    )));
    if ((tmpvar_7 <= -0.4999)) {
      tmpvar_6 = 1.0;
    } else {
      if ((tmpvar_7 >= 0.4999)) {
        tmpvar_6 = 0.0;
      } else {
        tmpvar_6 = (0.5 + (tmpvar_7 * (
          ((0.8431027 * tmpvar_7) * tmpvar_7)
         - 1.144536)));
      };
    };
    tmpvar_2 = tmpvar_6;
  } else {
    tmpvar_2 = 0.0;
  };
  vec2 tmpvar_8;
  tmpvar_8 = clamp (vClipMaskImageUv, vec2(0.0, 0.0), vLocalPos.ww);
  if ((tmpvar_8 != vClipMaskImageUv)) {
    discard;
  };
  vec3 tmpvar_9;
  tmpvar_9.xy = clamp (((
    (tmpvar_8 / vLocalPos.w)
   * vClipMaskUvRect.zw) + vClipMaskUvRect.xy), vClipMaskUvInnerRect.xy, vClipMaskUvInnerRect.zw);
  tmpvar_9.z = vLayer;
  lowp vec4 tmpvar_10;
  tmpvar_10.yzw = vec3(1.0, 1.0, 1.0);
  tmpvar_10.x = (tmpvar_2 * texture (sColor0, tmpvar_9).x);
  oFragColor = tmpvar_10;
}

