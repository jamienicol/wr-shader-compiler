#version 300 es
precision highp sampler2DArray;
uniform highp mat4 uTransform;
in highp vec2 aPosition;
flat out highp vec4 vColor00;
flat out highp vec4 vColor01;
flat out highp vec4 vColor10;
flat out highp vec4 vColor11;
flat out highp vec4 vColorLine;
flat out mediump ivec4 vConfig;
flat out highp vec4 vClipCenter_Sign;
flat out highp vec4 vClipRadii;
flat out highp vec4 vEdgeReference;
flat out highp vec4 vPartialWidths;
flat out highp vec4 vClipParams1;
flat out highp vec4 vClipParams2;
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
  highp vec2 edge_reference_1;
  highp ivec2 edge_axis_2;
  highp vec2 clip_sign_3;
  int tmpvar_4;
  tmpvar_4 = (aFlags & 255);
  int tmpvar_5;
  tmpvar_5 = ((aFlags >> 8) & 255);
  int tmpvar_6;
  tmpvar_6 = ((aFlags >> 16) & 255);
  int tmpvar_7;
  tmpvar_7 = ((aFlags >> 24) & 15);
  highp vec2 p_8;
  bool tmpvar_9;
  tmpvar_9 = bool(0);
  while (true) {
    tmpvar_9 = (tmpvar_9 || (0 == tmpvar_4));
    if (tmpvar_9) {
      p_8 = vec2(0.0, 0.0);
      break;
    };
    tmpvar_9 = (tmpvar_9 || (1 == tmpvar_4));
    if (tmpvar_9) {
      p_8 = vec2(1.0, 0.0);
      break;
    };
    tmpvar_9 = (tmpvar_9 || (2 == tmpvar_4));
    if (tmpvar_9) {
      p_8 = vec2(1.0, 1.0);
      break;
    };
    tmpvar_9 = (tmpvar_9 || (3 == tmpvar_4));
    if (tmpvar_9) {
      p_8 = vec2(0.0, 1.0);
      break;
    };
    tmpvar_9 = bool(1);
    p_8 = vec2(0.0, 0.0);
    break;
  };
  vec2 tmpvar_10;
  tmpvar_10 = (p_8 * aRect.zw);
  clip_sign_3 = (1.0 - (2.0 * p_8));
  edge_axis_2 = ivec2(0, 0);
  edge_reference_1 = vec2(0.0, 0.0);
  bool tmpvar_11;
  tmpvar_11 = bool(0);
  while (true) {
    tmpvar_11 = (tmpvar_11 || (0 == tmpvar_4));
    if (tmpvar_11) {
      edge_axis_2 = ivec2(0, 1);
      edge_reference_1 = tmpvar_10;
      break;
    };
    tmpvar_11 = (tmpvar_11 || (1 == tmpvar_4));
    if (tmpvar_11) {
      edge_axis_2 = ivec2(1, 0);
      vec2 tmpvar_12;
      tmpvar_12.x = (tmpvar_10.x - aWidths.x);
      tmpvar_12.y = tmpvar_10.y;
      edge_reference_1 = tmpvar_12;
      break;
    };
    tmpvar_11 = (tmpvar_11 || (2 == tmpvar_4));
    if (tmpvar_11) {
      edge_axis_2 = ivec2(0, 1);
      edge_reference_1 = (tmpvar_10 - aWidths);
      break;
    };
    tmpvar_11 = (tmpvar_11 || (3 == tmpvar_4));
    if (tmpvar_11) {
      edge_axis_2 = ivec2(1, 0);
      vec2 tmpvar_13;
      tmpvar_13.x = tmpvar_10.x;
      tmpvar_13.y = (tmpvar_10.y - aWidths.y);
      edge_reference_1 = tmpvar_13;
      break;
    };
    tmpvar_11 = (tmpvar_11 || (5 == tmpvar_4));
    tmpvar_11 = (tmpvar_11 || (7 == tmpvar_4));
    if (tmpvar_11) {
      edge_axis_2 = ivec2(1, 1);
      break;
    };
    tmpvar_11 = bool(1);
    break;
  };
  ivec4 tmpvar_14;
  tmpvar_14.x = tmpvar_4;
  tmpvar_14.y = (tmpvar_5 | (tmpvar_6 << 8));
  tmpvar_14.z = (edge_axis_2.x | (edge_axis_2.y << 8));
  tmpvar_14.w = tmpvar_7;
  vConfig = tmpvar_14;
  vec4 tmpvar_15;
  tmpvar_15.xy = (aWidths / 3.0);
  tmpvar_15.zw = (aWidths / 2.0);
  vPartialWidths = tmpvar_15;
  vPos = (aRect.zw * aPosition);
  bool is_black_16;
  vec4 tmpvar_17;
  vec4 tmpvar_18;
  is_black_16 = (aColor0.xyz == vec3(0.0, 0.0, 0.0));
  bool tmpvar_19;
  tmpvar_19 = bool(0);
  while (true) {
    tmpvar_19 = (tmpvar_19 || (6 == tmpvar_5));
    if (tmpvar_19) {
      vec4 tmpvar_20;
      if (is_black_16) {
        vec4 tmpvar_21;
        tmpvar_21.xyz = vec3(0.7, 0.7, 0.7);
        tmpvar_21.w = aColor0.w;
        tmpvar_20 = tmpvar_21;
      } else {
        vec4 tmpvar_22;
        tmpvar_22.xyz = aColor0.xyz;
        tmpvar_22.w = aColor0.w;
        tmpvar_20 = tmpvar_22;
      };
      tmpvar_17 = tmpvar_20;
      vec4 tmpvar_23;
      if (is_black_16) {
        vec4 tmpvar_24;
        tmpvar_24.xyz = vec3(0.3, 0.3, 0.3);
        tmpvar_24.w = aColor0.w;
        tmpvar_23 = tmpvar_24;
      } else {
        vec4 tmpvar_25;
        tmpvar_25.xyz = (aColor0.xyz * 0.6666667);
        tmpvar_25.w = aColor0.w;
        tmpvar_23 = tmpvar_25;
      };
      tmpvar_18 = tmpvar_23;
      break;
    };
    tmpvar_19 = (tmpvar_19 || (7 == tmpvar_5));
    if (tmpvar_19) {
      vec4 tmpvar_26;
      if (is_black_16) {
        vec4 tmpvar_27;
        tmpvar_27.xyz = vec3(0.3, 0.3, 0.3);
        tmpvar_27.w = aColor0.w;
        tmpvar_26 = tmpvar_27;
      } else {
        vec4 tmpvar_28;
        tmpvar_28.xyz = (aColor0.xyz * 0.6666667);
        tmpvar_28.w = aColor0.w;
        tmpvar_26 = tmpvar_28;
      };
      tmpvar_17 = tmpvar_26;
      vec4 tmpvar_29;
      if (is_black_16) {
        vec4 tmpvar_30;
        tmpvar_30.xyz = vec3(0.7, 0.7, 0.7);
        tmpvar_30.w = aColor0.w;
        tmpvar_29 = tmpvar_30;
      } else {
        vec4 tmpvar_31;
        tmpvar_31.xyz = aColor0.xyz;
        tmpvar_31.w = aColor0.w;
        tmpvar_29 = tmpvar_31;
      };
      tmpvar_18 = tmpvar_29;
      break;
    };
    tmpvar_19 = bool(1);
    tmpvar_17 = aColor0;
    tmpvar_18 = aColor0;
    break;
  };
  vColor00 = tmpvar_17;
  vColor01 = tmpvar_18;
  bool is_black_32;
  vec4 tmpvar_33;
  vec4 tmpvar_34;
  is_black_32 = (aColor1.xyz == vec3(0.0, 0.0, 0.0));
  bool tmpvar_35;
  tmpvar_35 = bool(0);
  while (true) {
    tmpvar_35 = (tmpvar_35 || (6 == tmpvar_6));
    if (tmpvar_35) {
      vec4 tmpvar_36;
      if (is_black_32) {
        vec4 tmpvar_37;
        tmpvar_37.xyz = vec3(0.7, 0.7, 0.7);
        tmpvar_37.w = aColor1.w;
        tmpvar_36 = tmpvar_37;
      } else {
        vec4 tmpvar_38;
        tmpvar_38.xyz = aColor1.xyz;
        tmpvar_38.w = aColor1.w;
        tmpvar_36 = tmpvar_38;
      };
      tmpvar_33 = tmpvar_36;
      vec4 tmpvar_39;
      if (is_black_32) {
        vec4 tmpvar_40;
        tmpvar_40.xyz = vec3(0.3, 0.3, 0.3);
        tmpvar_40.w = aColor1.w;
        tmpvar_39 = tmpvar_40;
      } else {
        vec4 tmpvar_41;
        tmpvar_41.xyz = (aColor1.xyz * 0.6666667);
        tmpvar_41.w = aColor1.w;
        tmpvar_39 = tmpvar_41;
      };
      tmpvar_34 = tmpvar_39;
      break;
    };
    tmpvar_35 = (tmpvar_35 || (7 == tmpvar_6));
    if (tmpvar_35) {
      vec4 tmpvar_42;
      if (is_black_32) {
        vec4 tmpvar_43;
        tmpvar_43.xyz = vec3(0.3, 0.3, 0.3);
        tmpvar_43.w = aColor1.w;
        tmpvar_42 = tmpvar_43;
      } else {
        vec4 tmpvar_44;
        tmpvar_44.xyz = (aColor1.xyz * 0.6666667);
        tmpvar_44.w = aColor1.w;
        tmpvar_42 = tmpvar_44;
      };
      tmpvar_33 = tmpvar_42;
      vec4 tmpvar_45;
      if (is_black_32) {
        vec4 tmpvar_46;
        tmpvar_46.xyz = vec3(0.7, 0.7, 0.7);
        tmpvar_46.w = aColor1.w;
        tmpvar_45 = tmpvar_46;
      } else {
        vec4 tmpvar_47;
        tmpvar_47.xyz = aColor1.xyz;
        tmpvar_47.w = aColor1.w;
        tmpvar_45 = tmpvar_47;
      };
      tmpvar_34 = tmpvar_45;
      break;
    };
    tmpvar_35 = bool(1);
    tmpvar_33 = aColor1;
    tmpvar_34 = aColor1;
    break;
  };
  vColor10 = tmpvar_33;
  vColor11 = tmpvar_34;
  vec4 tmpvar_48;
  tmpvar_48.xy = (tmpvar_10 + (clip_sign_3 * aRadii));
  tmpvar_48.zw = clip_sign_3;
  vClipCenter_Sign = tmpvar_48;
  vec4 tmpvar_49;
  tmpvar_49.xy = aRadii;
  tmpvar_49.zw = max ((aRadii - aWidths), 0.0);
  vClipRadii = tmpvar_49;
  vec4 tmpvar_50;
  tmpvar_50.xy = tmpvar_10;
  tmpvar_50.z = (aWidths.y * -(clip_sign_3.y));
  tmpvar_50.w = (aWidths.x * clip_sign_3.x);
  vColorLine = tmpvar_50;
  vec4 tmpvar_51;
  tmpvar_51.xy = edge_reference_1;
  tmpvar_51.zw = (edge_reference_1 + aWidths);
  vEdgeReference = tmpvar_51;
  vClipParams1 = aClipParams1;
  vClipParams2 = aClipParams2;
  if ((tmpvar_7 == 3)) {
    highp float radius_52;
    radius_52 = aClipParams1.z;
    if ((0.5 < aClipParams1.z)) {
      radius_52 = (aClipParams1.z + 2.0);
    };
    vPos = (aClipParams1.xy + (radius_52 * (
      (2.0 * aPosition)
     - 1.0)));
    vPos = min (max (vPos, vec2(0.0, 0.0)), aRect.zw);
  } else {
    if ((tmpvar_7 == 1)) {
      vec2 tmpvar_53;
      tmpvar_53 = ((aClipParams1.xy + aClipParams2.xy) * 0.5);
      vec2 tmpvar_54;
      tmpvar_54 = (aClipParams1.xy - aClipParams2.xy);
      vec2 tmpvar_55;
      tmpvar_55 = (vec2(max (sqrt(
        dot (tmpvar_54, tmpvar_54)
      ), max (aWidths.x, aWidths.y))) + 2.0);
      vPos = min (max (vPos, (tmpvar_53 - tmpvar_55)), (tmpvar_53 + tmpvar_55));
    };
  };
  vec4 tmpvar_56;
  tmpvar_56.zw = vec2(0.0, 1.0);
  tmpvar_56.xy = ((aTaskOrigin + aRect.xy) + vPos);
  gl_Position = (uTransform * tmpvar_56);
}

