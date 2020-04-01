#version 150
uniform mat4 uTransform;
in vec2 aPosition;
flat out vec4 vColor00;
flat out vec4 vColor01;
flat out vec4 vColor10;
flat out vec4 vColor11;
flat out vec4 vColorLine;
flat out ivec4 vConfig;
flat out vec4 vClipCenter_Sign;
flat out vec4 vClipRadii;
flat out vec4 vEdgeReference;
flat out vec4 vPartialWidths;
flat out vec4 vClipParams1;
flat out vec4 vClipParams2;
out vec2 vPos;
in vec2 aTaskOrigin;
in vec4 aRect;
in vec4 aColor0;
in vec4 aColor1;
in int aFlags;
in vec2 aWidths;
in vec2 aRadii;
in vec4 aClipParams1;
in vec4 aClipParams2;
void main ()
{
  vec2 edge_reference_1;
  ivec2 edge_axis_2;
  vec2 clip_sign_3;
  int tmpvar_4;
  tmpvar_4 = (aFlags & 255);
  int tmpvar_5;
  tmpvar_5 = ((aFlags >> 8) & 255);
  int tmpvar_6;
  tmpvar_6 = ((aFlags >> 16) & 255);
  int tmpvar_7;
  tmpvar_7 = ((aFlags >> 24) & 15);
  vec2 p_8;
  bool tmpvar_9;
  tmpvar_9 = bool(0);
  bool tmpvar_10;
  tmpvar_10 = bool(0);
  if ((0 == tmpvar_4)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    p_8 = vec2(0.0, 0.0);
    tmpvar_10 = bool(1);
  };
  if ((1 == tmpvar_4)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    p_8 = vec2(1.0, 0.0);
    tmpvar_10 = bool(1);
  };
  if ((2 == tmpvar_4)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    p_8 = vec2(1.0, 1.0);
    tmpvar_10 = bool(1);
  };
  if ((3 == tmpvar_4)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    p_8 = vec2(0.0, 1.0);
    tmpvar_10 = bool(1);
  };
  tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    p_8 = vec2(0.0, 0.0);
    tmpvar_10 = bool(1);
  };
  vec2 tmpvar_11;
  tmpvar_11 = (p_8 * aRect.zw);
  clip_sign_3 = (1.0 - (2.0 * p_8));
  edge_axis_2 = ivec2(0, 0);
  edge_reference_1 = vec2(0.0, 0.0);
  bool tmpvar_12;
  tmpvar_12 = bool(0);
  bool tmpvar_13;
  tmpvar_13 = bool(0);
  if ((0 == tmpvar_4)) tmpvar_12 = bool(1);
  if (tmpvar_13) tmpvar_12 = bool(0);
  if (tmpvar_12) {
    edge_axis_2 = ivec2(0, 1);
    edge_reference_1 = tmpvar_11;
    tmpvar_13 = bool(1);
  };
  if ((1 == tmpvar_4)) tmpvar_12 = bool(1);
  if (tmpvar_13) tmpvar_12 = bool(0);
  if (tmpvar_12) {
    edge_axis_2 = ivec2(1, 0);
    vec2 tmpvar_14;
    tmpvar_14.x = (tmpvar_11.x - aWidths.x);
    tmpvar_14.y = tmpvar_11.y;
    edge_reference_1 = tmpvar_14;
    tmpvar_13 = bool(1);
  };
  if ((2 == tmpvar_4)) tmpvar_12 = bool(1);
  if (tmpvar_13) tmpvar_12 = bool(0);
  if (tmpvar_12) {
    edge_axis_2 = ivec2(0, 1);
    edge_reference_1 = (tmpvar_11 - aWidths);
    tmpvar_13 = bool(1);
  };
  if ((3 == tmpvar_4)) tmpvar_12 = bool(1);
  if (tmpvar_13) tmpvar_12 = bool(0);
  if (tmpvar_12) {
    edge_axis_2 = ivec2(1, 0);
    vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_11.x;
    tmpvar_15.y = (tmpvar_11.y - aWidths.y);
    edge_reference_1 = tmpvar_15;
    tmpvar_13 = bool(1);
  };
  if ((5 == tmpvar_4)) tmpvar_12 = bool(1);
  if ((7 == tmpvar_4)) tmpvar_12 = bool(1);
  if (tmpvar_13) tmpvar_12 = bool(0);
  if (tmpvar_12) {
    edge_axis_2 = ivec2(1, 1);
    tmpvar_13 = bool(1);
  };
  tmpvar_12 = bool(1);
  if (tmpvar_13) tmpvar_12 = bool(0);
  if (tmpvar_12) {
    tmpvar_13 = bool(1);
  };
  ivec4 tmpvar_16;
  tmpvar_16.x = tmpvar_4;
  tmpvar_16.y = (tmpvar_5 | (tmpvar_6 << 8));
  tmpvar_16.z = (edge_axis_2.x | (edge_axis_2.y << 8));
  tmpvar_16.w = tmpvar_7;
  vConfig = tmpvar_16;
  vec4 tmpvar_17;
  tmpvar_17.xy = (aWidths / 3.0);
  tmpvar_17.zw = (aWidths / 2.0);
  vPartialWidths = tmpvar_17;
  vPos = (aRect.zw * aPosition);
  vec4 result_0_18;
  vec4 result_1_19;
  bool tmpvar_20;
  tmpvar_20 = (aColor0.xyz == vec3(0.0, 0.0, 0.0));
  bool tmpvar_21;
  tmpvar_21 = bool(0);
  bool tmpvar_22;
  tmpvar_22 = bool(0);
  if ((6 == tmpvar_5)) tmpvar_21 = bool(1);
  if (tmpvar_22) tmpvar_21 = bool(0);
  if (tmpvar_21) {
    vec4 tmpvar_23;
    if (tmpvar_20) {
      vec4 tmpvar_24;
      tmpvar_24.xyz = vec3(0.7, 0.7, 0.7);
      tmpvar_24.w = aColor0.w;
      tmpvar_23 = tmpvar_24;
    } else {
      vec4 tmpvar_25;
      tmpvar_25.xyz = aColor0.xyz;
      tmpvar_25.w = aColor0.w;
      tmpvar_23 = tmpvar_25;
    };
    result_0_18 = tmpvar_23;
    vec4 tmpvar_26;
    if (tmpvar_20) {
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
    result_1_19 = tmpvar_26;
    tmpvar_22 = bool(1);
  };
  if ((7 == tmpvar_5)) tmpvar_21 = bool(1);
  if (tmpvar_22) tmpvar_21 = bool(0);
  if (tmpvar_21) {
    vec4 tmpvar_29;
    if (tmpvar_20) {
      vec4 tmpvar_30;
      tmpvar_30.xyz = vec3(0.3, 0.3, 0.3);
      tmpvar_30.w = aColor0.w;
      tmpvar_29 = tmpvar_30;
    } else {
      vec4 tmpvar_31;
      tmpvar_31.xyz = (aColor0.xyz * 0.6666667);
      tmpvar_31.w = aColor0.w;
      tmpvar_29 = tmpvar_31;
    };
    result_0_18 = tmpvar_29;
    vec4 tmpvar_32;
    if (tmpvar_20) {
      vec4 tmpvar_33;
      tmpvar_33.xyz = vec3(0.7, 0.7, 0.7);
      tmpvar_33.w = aColor0.w;
      tmpvar_32 = tmpvar_33;
    } else {
      vec4 tmpvar_34;
      tmpvar_34.xyz = aColor0.xyz;
      tmpvar_34.w = aColor0.w;
      tmpvar_32 = tmpvar_34;
    };
    result_1_19 = tmpvar_32;
    tmpvar_22 = bool(1);
  };
  tmpvar_21 = bool(1);
  if (tmpvar_22) tmpvar_21 = bool(0);
  if (tmpvar_21) {
    result_0_18 = aColor0;
    result_1_19 = aColor0;
    tmpvar_22 = bool(1);
  };
  vColor00 = result_0_18;
  vColor01 = result_1_19;
  vec4 result_0_35;
  vec4 result_1_36;
  bool tmpvar_37;
  tmpvar_37 = (aColor1.xyz == vec3(0.0, 0.0, 0.0));
  bool tmpvar_38;
  tmpvar_38 = bool(0);
  bool tmpvar_39;
  tmpvar_39 = bool(0);
  if ((6 == tmpvar_6)) tmpvar_38 = bool(1);
  if (tmpvar_39) tmpvar_38 = bool(0);
  if (tmpvar_38) {
    vec4 tmpvar_40;
    if (tmpvar_37) {
      vec4 tmpvar_41;
      tmpvar_41.xyz = vec3(0.7, 0.7, 0.7);
      tmpvar_41.w = aColor1.w;
      tmpvar_40 = tmpvar_41;
    } else {
      vec4 tmpvar_42;
      tmpvar_42.xyz = aColor1.xyz;
      tmpvar_42.w = aColor1.w;
      tmpvar_40 = tmpvar_42;
    };
    result_0_35 = tmpvar_40;
    vec4 tmpvar_43;
    if (tmpvar_37) {
      vec4 tmpvar_44;
      tmpvar_44.xyz = vec3(0.3, 0.3, 0.3);
      tmpvar_44.w = aColor1.w;
      tmpvar_43 = tmpvar_44;
    } else {
      vec4 tmpvar_45;
      tmpvar_45.xyz = (aColor1.xyz * 0.6666667);
      tmpvar_45.w = aColor1.w;
      tmpvar_43 = tmpvar_45;
    };
    result_1_36 = tmpvar_43;
    tmpvar_39 = bool(1);
  };
  if ((7 == tmpvar_6)) tmpvar_38 = bool(1);
  if (tmpvar_39) tmpvar_38 = bool(0);
  if (tmpvar_38) {
    vec4 tmpvar_46;
    if (tmpvar_37) {
      vec4 tmpvar_47;
      tmpvar_47.xyz = vec3(0.3, 0.3, 0.3);
      tmpvar_47.w = aColor1.w;
      tmpvar_46 = tmpvar_47;
    } else {
      vec4 tmpvar_48;
      tmpvar_48.xyz = (aColor1.xyz * 0.6666667);
      tmpvar_48.w = aColor1.w;
      tmpvar_46 = tmpvar_48;
    };
    result_0_35 = tmpvar_46;
    vec4 tmpvar_49;
    if (tmpvar_37) {
      vec4 tmpvar_50;
      tmpvar_50.xyz = vec3(0.7, 0.7, 0.7);
      tmpvar_50.w = aColor1.w;
      tmpvar_49 = tmpvar_50;
    } else {
      vec4 tmpvar_51;
      tmpvar_51.xyz = aColor1.xyz;
      tmpvar_51.w = aColor1.w;
      tmpvar_49 = tmpvar_51;
    };
    result_1_36 = tmpvar_49;
    tmpvar_39 = bool(1);
  };
  tmpvar_38 = bool(1);
  if (tmpvar_39) tmpvar_38 = bool(0);
  if (tmpvar_38) {
    result_0_35 = aColor1;
    result_1_36 = aColor1;
    tmpvar_39 = bool(1);
  };
  vColor10 = result_0_35;
  vColor11 = result_1_36;
  vec4 tmpvar_52;
  tmpvar_52.xy = (tmpvar_11 + (clip_sign_3 * aRadii));
  tmpvar_52.zw = clip_sign_3;
  vClipCenter_Sign = tmpvar_52;
  vec4 tmpvar_53;
  tmpvar_53.xy = aRadii;
  tmpvar_53.zw = max ((aRadii - aWidths), 0.0);
  vClipRadii = tmpvar_53;
  vec4 tmpvar_54;
  tmpvar_54.xy = tmpvar_11;
  tmpvar_54.z = (aWidths.y * -(clip_sign_3.y));
  tmpvar_54.w = (aWidths.x * clip_sign_3.x);
  vColorLine = tmpvar_54;
  vec4 tmpvar_55;
  tmpvar_55.xy = edge_reference_1;
  tmpvar_55.zw = (edge_reference_1 + aWidths);
  vEdgeReference = tmpvar_55;
  vClipParams1 = aClipParams1;
  vClipParams2 = aClipParams2;
  if ((tmpvar_7 == 3)) {
    float radius_56;
    radius_56 = aClipParams1.z;
    if ((aClipParams1.z > 0.5)) {
      radius_56 = (aClipParams1.z + 2.0);
    };
    vPos = (aClipParams1.xy + (radius_56 * (
      (2.0 * aPosition)
     - 1.0)));
    vPos = clamp (vPos, vec2(0.0, 0.0), aRect.zw);
  } else {
    if ((tmpvar_7 == 1)) {
      vec2 tmpvar_57;
      tmpvar_57 = ((aClipParams1.xy + aClipParams2.xy) * 0.5);
      vec2 x_58;
      x_58 = (aClipParams1.xy - aClipParams2.xy);
      vec2 tmpvar_59;
      tmpvar_59 = (vec2(max (sqrt(
        dot (x_58, x_58)
      ), max (aWidths.x, aWidths.y))) + 2.0);
      vPos = clamp (vPos, (tmpvar_57 - tmpvar_59), (tmpvar_57 + tmpvar_59));
    };
  };
  vec4 tmpvar_60;
  tmpvar_60.zw = vec2(0.0, 1.0);
  tmpvar_60.xy = ((aTaskOrigin + aRect.xy) + vPos);
  gl_Position = (uTransform * tmpvar_60);
}

