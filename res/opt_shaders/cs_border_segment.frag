#version 300 es
precision highp float;
precision highp sampler2DArray;
out vec4 oFragColor;
flat in vec4 vColor00;
flat in vec4 vColor01;
flat in vec4 vColor10;
flat in vec4 vColor11;
flat in vec4 vColorLine;
flat in highp ivec4 vConfig;
flat in vec4 vClipCenter_Sign;
flat in vec4 vClipRadii;
flat in vec4 vEdgeReference;
flat in vec4 vPartialWidths;
flat in vec4 vClipParams1;
flat in vec4 vClipParams2;
in vec2 vPos;
void main ()
{
  float d_1;
  float mix_factor_2;
  vec4 color1_3;
  vec4 color0_4;
  float tmpvar_5;
  vec2 tmpvar_6;
  tmpvar_6 = (abs(dFdx(vPos)) + abs(dFdy(vPos)));
  tmpvar_5 = (0.35355 * sqrt(dot (tmpvar_6, tmpvar_6)));
  highp ivec2 tmpvar_7;
  tmpvar_7.x = (vConfig.y & 65535);
  tmpvar_7.y = (vConfig.y >> 16);
  highp ivec2 tmpvar_8;
  tmpvar_8.x = (vConfig.z & 65535);
  tmpvar_8.y = (vConfig.z >> 16);
  mix_factor_2 = 0.0;
  if ((tmpvar_8.x != tmpvar_8.y)) {
    float tmpvar_9;
    float tmpvar_10;
    tmpvar_10 = ((0.5 * -(
      dot (normalize(vColorLine.zw), (vColorLine.xy - vPos))
    )) / tmpvar_5);
    if ((tmpvar_10 <= -0.4999)) {
      tmpvar_9 = 1.0;
    } else {
      if ((tmpvar_10 >= 0.4999)) {
        tmpvar_9 = 0.0;
      } else {
        tmpvar_9 = (0.5 + (tmpvar_10 * (
          ((0.8431027 * tmpvar_10) * tmpvar_10)
         - 1.144536)));
      };
    };
    mix_factor_2 = tmpvar_9;
  };
  vec2 tmpvar_11;
  tmpvar_11 = (vPos - vClipCenter_Sign.xy);
  bvec2 tmpvar_12;
  tmpvar_12 = lessThan ((vClipCenter_Sign.zw * tmpvar_11), vec2(0.0, 0.0));
  bool tmpvar_13;
  tmpvar_13 = (tmpvar_12.x && tmpvar_12.y);
  d_1 = -1.0;
  bool tmpvar_14;
  tmpvar_14 = bool(0);
  bool tmpvar_15;
  tmpvar_15 = bool(0);
  if ((3 == vConfig.w)) tmpvar_14 = bool(1);
  if (tmpvar_15) tmpvar_14 = bool(0);
  if (tmpvar_14) {
    vec2 tmpvar_16;
    tmpvar_16 = (vClipParams1.xy - vPos);
    d_1 = (sqrt(dot (tmpvar_16, tmpvar_16)) - vClipParams1.z);
    tmpvar_15 = bool(1);
  };
  if ((2 == vConfig.w)) tmpvar_14 = bool(1);
  if (tmpvar_15) tmpvar_14 = bool(0);
  if (tmpvar_14) {
    bool tmpvar_17;
    tmpvar_17 = (vClipParams1.x == 0.0);
    float tmpvar_18;
    if (tmpvar_17) {
      tmpvar_18 = vClipParams1.y;
    } else {
      tmpvar_18 = vClipParams1.x;
    };
    float tmpvar_19;
    if (tmpvar_17) {
      tmpvar_19 = vPos.y;
    } else {
      tmpvar_19 = vPos.x;
    };
    bool tmpvar_20;
    tmpvar_20 = ((tmpvar_19 < tmpvar_18) || (tmpvar_19 > (3.0 * tmpvar_18)));
    if (!(tmpvar_20)) {
      d_1 = 1.0;
    };
    tmpvar_15 = bool(1);
  };
  if ((1 == vConfig.w)) tmpvar_14 = bool(1);
  if (tmpvar_15) tmpvar_14 = bool(0);
  if (tmpvar_14) {
    d_1 = max (dot (normalize(vClipParams1.zw), (vClipParams1.xy - vPos)), -(dot (
      normalize(vClipParams2.zw)
    , 
      (vClipParams2.xy - vPos)
    )));
    tmpvar_15 = bool(1);
  };
  tmpvar_14 = bool(1);
  if (tmpvar_15) tmpvar_14 = bool(0);
  if (tmpvar_14) {
    tmpvar_15 = bool(1);
  };
  if (tmpvar_13) {
    float dist_21;
    if (any(lessThanEqual (vClipRadii.xy, vec2(0.0, 0.0)))) {
      dist_21 = sqrt(dot (tmpvar_11, tmpvar_11));
    } else {
      vec2 tmpvar_22;
      tmpvar_22 = (1.0/((vClipRadii.xy * vClipRadii.xy)));
      vec2 tmpvar_23;
      tmpvar_23 = ((2.0 * tmpvar_11) * tmpvar_22);
      dist_21 = ((dot (
        ((tmpvar_11 * tmpvar_11) * tmpvar_22)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_23, tmpvar_23)));
    };
    float tmpvar_24;
    tmpvar_24 = clamp (dist_21, -(tmpvar_5), tmpvar_5);
    float dist_25;
    if (any(lessThanEqual (vClipRadii.zw, vec2(0.0, 0.0)))) {
      dist_25 = sqrt(dot (tmpvar_11, tmpvar_11));
    } else {
      vec2 tmpvar_26;
      tmpvar_26 = (1.0/((vClipRadii.zw * vClipRadii.zw)));
      vec2 tmpvar_27;
      tmpvar_27 = ((2.0 * tmpvar_11) * tmpvar_26);
      dist_25 = ((dot (
        ((tmpvar_11 * tmpvar_11) * tmpvar_26)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_27, tmpvar_27)));
    };
    d_1 = max (d_1, max (tmpvar_24, -(
      clamp (dist_25, -(tmpvar_5), tmpvar_5)
    )));
    vec4 color0_28;
    color0_28 = vColor00;
    bool tmpvar_29;
    tmpvar_29 = bool(0);
    bool tmpvar_30;
    tmpvar_30 = bool(0);
    if ((2 == tmpvar_7.x)) tmpvar_29 = bool(1);
    if (tmpvar_30) tmpvar_29 = bool(0);
    if (tmpvar_29) {
      vec2 radii_31;
      radii_31 = (vClipRadii.xy - vPartialWidths.xy);
      float dist_32;
      if (any(lessThanEqual (radii_31, vec2(0.0, 0.0)))) {
        dist_32 = sqrt(dot (tmpvar_11, tmpvar_11));
      } else {
        vec2 tmpvar_33;
        tmpvar_33 = (1.0/((radii_31 * radii_31)));
        vec2 tmpvar_34;
        tmpvar_34 = ((2.0 * tmpvar_11) * tmpvar_33);
        dist_32 = ((dot (
          ((tmpvar_11 * tmpvar_11) * tmpvar_33)
        , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_34, tmpvar_34)));
      };
      float tmpvar_35;
      tmpvar_35 = clamp (dist_32, -(tmpvar_5), tmpvar_5);
      vec2 radii_36;
      radii_36 = (vClipRadii.xy - (2.0 * vPartialWidths.xy));
      float dist_37;
      if (any(lessThanEqual (radii_36, vec2(0.0, 0.0)))) {
        dist_37 = sqrt(dot (tmpvar_11, tmpvar_11));
      } else {
        vec2 tmpvar_38;
        tmpvar_38 = (1.0/((radii_36 * radii_36)));
        vec2 tmpvar_39;
        tmpvar_39 = ((2.0 * tmpvar_11) * tmpvar_38);
        dist_37 = ((dot (
          ((tmpvar_11 * tmpvar_11) * tmpvar_38)
        , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_39, tmpvar_39)));
      };
      float tmpvar_40;
      float tmpvar_41;
      tmpvar_41 = ((0.5 * min (
        -(tmpvar_35)
      , 
        clamp (dist_37, -(tmpvar_5), tmpvar_5)
      )) / tmpvar_5);
      if ((tmpvar_41 <= -0.4999)) {
        tmpvar_40 = 1.0;
      } else {
        if ((tmpvar_41 >= 0.4999)) {
          tmpvar_40 = 0.0;
        } else {
          tmpvar_40 = (0.5 + (tmpvar_41 * (
            ((0.8431027 * tmpvar_41) * tmpvar_41)
           - 1.144536)));
        };
      };
      color0_28 = (vColor00 * tmpvar_40);
      tmpvar_30 = bool(1);
    };
    if ((6 == tmpvar_7.x)) tmpvar_29 = bool(1);
    if ((7 == tmpvar_7.x)) tmpvar_29 = bool(1);
    if (tmpvar_30) tmpvar_29 = bool(0);
    if (tmpvar_29) {
      float swizzled_factor_42;
      vec2 radii_43;
      radii_43 = (vClipRadii.xy - vPartialWidths.zw);
      float dist_44;
      if (any(lessThanEqual (radii_43, vec2(0.0, 0.0)))) {
        dist_44 = sqrt(dot (tmpvar_11, tmpvar_11));
      } else {
        vec2 tmpvar_45;
        tmpvar_45 = (1.0/((radii_43 * radii_43)));
        vec2 tmpvar_46;
        tmpvar_46 = ((2.0 * tmpvar_11) * tmpvar_45);
        dist_44 = ((dot (
          ((tmpvar_11 * tmpvar_11) * tmpvar_45)
        , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_46, tmpvar_46)));
      };
      float tmpvar_47;
      float tmpvar_48;
      tmpvar_48 = ((0.5 * clamp (dist_44, 
        -(tmpvar_5)
      , tmpvar_5)) / tmpvar_5);
      if ((tmpvar_48 <= -0.4999)) {
        tmpvar_47 = 1.0;
      } else {
        if ((tmpvar_48 >= 0.4999)) {
          tmpvar_47 = 0.0;
        } else {
          tmpvar_47 = (0.5 + (tmpvar_48 * (
            ((0.8431027 * tmpvar_48) * tmpvar_48)
           - 1.144536)));
        };
      };
      bool tmpvar_49;
      tmpvar_49 = bool(0);
      bool tmpvar_50;
      tmpvar_50 = bool(0);
      if ((0 == vConfig.x)) tmpvar_49 = bool(1);
      if (tmpvar_50) tmpvar_49 = bool(0);
      if (tmpvar_49) {
        swizzled_factor_42 = 0.0;
        tmpvar_50 = bool(1);
      };
      if ((1 == vConfig.x)) tmpvar_49 = bool(1);
      if (tmpvar_50) tmpvar_49 = bool(0);
      if (tmpvar_49) {
        swizzled_factor_42 = mix_factor_2;
        tmpvar_50 = bool(1);
      };
      if ((2 == vConfig.x)) tmpvar_49 = bool(1);
      if (tmpvar_50) tmpvar_49 = bool(0);
      if (tmpvar_49) {
        swizzled_factor_42 = 1.0;
        tmpvar_50 = bool(1);
      };
      if ((3 == vConfig.x)) tmpvar_49 = bool(1);
      if (tmpvar_50) tmpvar_49 = bool(0);
      if (tmpvar_49) {
        swizzled_factor_42 = (1.0 - mix_factor_2);
        tmpvar_50 = bool(1);
      };
      tmpvar_49 = bool(1);
      if (tmpvar_50) tmpvar_49 = bool(0);
      if (tmpvar_49) {
        swizzled_factor_42 = 0.0;
        tmpvar_50 = bool(1);
      };
      color0_28 = mix (mix (vColor01, color0_28, swizzled_factor_42), mix (color0_28, vColor01, swizzled_factor_42), tmpvar_47);
      tmpvar_30 = bool(1);
    };
    tmpvar_29 = bool(1);
    if (tmpvar_30) tmpvar_29 = bool(0);
    if (tmpvar_29) {
      tmpvar_30 = bool(1);
    };
    color0_4 = color0_28;
    vec4 color0_51;
    color0_51 = vColor10;
    bool tmpvar_52;
    tmpvar_52 = bool(0);
    bool tmpvar_53;
    tmpvar_53 = bool(0);
    if ((2 == tmpvar_7.y)) tmpvar_52 = bool(1);
    if (tmpvar_53) tmpvar_52 = bool(0);
    if (tmpvar_52) {
      vec2 radii_54;
      radii_54 = (vClipRadii.xy - vPartialWidths.xy);
      float dist_55;
      if (any(lessThanEqual (radii_54, vec2(0.0, 0.0)))) {
        dist_55 = sqrt(dot (tmpvar_11, tmpvar_11));
      } else {
        vec2 tmpvar_56;
        tmpvar_56 = (1.0/((radii_54 * radii_54)));
        vec2 tmpvar_57;
        tmpvar_57 = ((2.0 * tmpvar_11) * tmpvar_56);
        dist_55 = ((dot (
          ((tmpvar_11 * tmpvar_11) * tmpvar_56)
        , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_57, tmpvar_57)));
      };
      float tmpvar_58;
      tmpvar_58 = clamp (dist_55, -(tmpvar_5), tmpvar_5);
      vec2 radii_59;
      radii_59 = (vClipRadii.xy - (2.0 * vPartialWidths.xy));
      float dist_60;
      if (any(lessThanEqual (radii_59, vec2(0.0, 0.0)))) {
        dist_60 = sqrt(dot (tmpvar_11, tmpvar_11));
      } else {
        vec2 tmpvar_61;
        tmpvar_61 = (1.0/((radii_59 * radii_59)));
        vec2 tmpvar_62;
        tmpvar_62 = ((2.0 * tmpvar_11) * tmpvar_61);
        dist_60 = ((dot (
          ((tmpvar_11 * tmpvar_11) * tmpvar_61)
        , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_62, tmpvar_62)));
      };
      float tmpvar_63;
      float tmpvar_64;
      tmpvar_64 = ((0.5 * min (
        -(tmpvar_58)
      , 
        clamp (dist_60, -(tmpvar_5), tmpvar_5)
      )) / tmpvar_5);
      if ((tmpvar_64 <= -0.4999)) {
        tmpvar_63 = 1.0;
      } else {
        if ((tmpvar_64 >= 0.4999)) {
          tmpvar_63 = 0.0;
        } else {
          tmpvar_63 = (0.5 + (tmpvar_64 * (
            ((0.8431027 * tmpvar_64) * tmpvar_64)
           - 1.144536)));
        };
      };
      color0_51 = (vColor10 * tmpvar_63);
      tmpvar_53 = bool(1);
    };
    if ((6 == tmpvar_7.y)) tmpvar_52 = bool(1);
    if ((7 == tmpvar_7.y)) tmpvar_52 = bool(1);
    if (tmpvar_53) tmpvar_52 = bool(0);
    if (tmpvar_52) {
      float swizzled_factor_65;
      vec2 radii_66;
      radii_66 = (vClipRadii.xy - vPartialWidths.zw);
      float dist_67;
      if (any(lessThanEqual (radii_66, vec2(0.0, 0.0)))) {
        dist_67 = sqrt(dot (tmpvar_11, tmpvar_11));
      } else {
        vec2 tmpvar_68;
        tmpvar_68 = (1.0/((radii_66 * radii_66)));
        vec2 tmpvar_69;
        tmpvar_69 = ((2.0 * tmpvar_11) * tmpvar_68);
        dist_67 = ((dot (
          ((tmpvar_11 * tmpvar_11) * tmpvar_68)
        , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_69, tmpvar_69)));
      };
      float tmpvar_70;
      float tmpvar_71;
      tmpvar_71 = ((0.5 * clamp (dist_67, 
        -(tmpvar_5)
      , tmpvar_5)) / tmpvar_5);
      if ((tmpvar_71 <= -0.4999)) {
        tmpvar_70 = 1.0;
      } else {
        if ((tmpvar_71 >= 0.4999)) {
          tmpvar_70 = 0.0;
        } else {
          tmpvar_70 = (0.5 + (tmpvar_71 * (
            ((0.8431027 * tmpvar_71) * tmpvar_71)
           - 1.144536)));
        };
      };
      bool tmpvar_72;
      tmpvar_72 = bool(0);
      bool tmpvar_73;
      tmpvar_73 = bool(0);
      if ((0 == vConfig.x)) tmpvar_72 = bool(1);
      if (tmpvar_73) tmpvar_72 = bool(0);
      if (tmpvar_72) {
        swizzled_factor_65 = 0.0;
        tmpvar_73 = bool(1);
      };
      if ((1 == vConfig.x)) tmpvar_72 = bool(1);
      if (tmpvar_73) tmpvar_72 = bool(0);
      if (tmpvar_72) {
        swizzled_factor_65 = mix_factor_2;
        tmpvar_73 = bool(1);
      };
      if ((2 == vConfig.x)) tmpvar_72 = bool(1);
      if (tmpvar_73) tmpvar_72 = bool(0);
      if (tmpvar_72) {
        swizzled_factor_65 = 1.0;
        tmpvar_73 = bool(1);
      };
      if ((3 == vConfig.x)) tmpvar_72 = bool(1);
      if (tmpvar_73) tmpvar_72 = bool(0);
      if (tmpvar_72) {
        swizzled_factor_65 = (1.0 - mix_factor_2);
        tmpvar_73 = bool(1);
      };
      tmpvar_72 = bool(1);
      if (tmpvar_73) tmpvar_72 = bool(0);
      if (tmpvar_72) {
        swizzled_factor_65 = 0.0;
        tmpvar_73 = bool(1);
      };
      color0_51 = mix (mix (vColor11, color0_51, swizzled_factor_65), mix (color0_51, vColor11, swizzled_factor_65), tmpvar_70);
      tmpvar_53 = bool(1);
    };
    tmpvar_52 = bool(1);
    if (tmpvar_53) tmpvar_52 = bool(0);
    if (tmpvar_52) {
      tmpvar_53 = bool(1);
    };
    color1_3 = color0_51;
  } else {
    vec4 color0_74;
    color0_74 = vColor00;
    vec2 tmpvar_75;
    if ((tmpvar_8.x != 0)) {
      tmpvar_75 = vec2(0.0, 1.0);
    } else {
      tmpvar_75 = vec2(1.0, 0.0);
    };
    float tmpvar_76;
    tmpvar_76 = dot (vPos, tmpvar_75);
    bool tmpvar_77;
    tmpvar_77 = bool(0);
    bool tmpvar_78;
    tmpvar_78 = bool(0);
    if ((2 == tmpvar_7.x)) tmpvar_77 = bool(1);
    if (tmpvar_78) tmpvar_77 = bool(0);
    if (tmpvar_77) {
      float d_79;
      d_79 = -1.0;
      float tmpvar_80;
      tmpvar_80 = dot (vPartialWidths.xy, tmpvar_75);
      if ((tmpvar_80 >= 1.0)) {
        vec2 tmpvar_81;
        tmpvar_81.x = (dot (vEdgeReference.xy, tmpvar_75) + tmpvar_80);
        tmpvar_81.y = (dot (vEdgeReference.zw, tmpvar_75) - tmpvar_80);
        d_79 = min ((tmpvar_76 - tmpvar_81.x), (tmpvar_81.y - tmpvar_76));
      };
      float tmpvar_82;
      float tmpvar_83;
      tmpvar_83 = ((0.5 * d_79) / tmpvar_5);
      if ((tmpvar_83 <= -0.4999)) {
        tmpvar_82 = 1.0;
      } else {
        if ((tmpvar_83 >= 0.4999)) {
          tmpvar_82 = 0.0;
        } else {
          tmpvar_82 = (0.5 + (tmpvar_83 * (
            ((0.8431027 * tmpvar_83) * tmpvar_83)
           - 1.144536)));
        };
      };
      color0_74 = (vColor00 * tmpvar_82);
      tmpvar_78 = bool(1);
    };
    if ((6 == tmpvar_7.x)) tmpvar_77 = bool(1);
    if ((7 == tmpvar_7.x)) tmpvar_77 = bool(1);
    if (tmpvar_78) tmpvar_77 = bool(0);
    if (tmpvar_77) {
      float tmpvar_84;
      float tmpvar_85;
      tmpvar_85 = ((0.5 * (tmpvar_76 - 
        dot ((vEdgeReference.xy + vPartialWidths.zw), tmpvar_75)
      )) / tmpvar_5);
      if ((tmpvar_85 <= -0.4999)) {
        tmpvar_84 = 1.0;
      } else {
        if ((tmpvar_85 >= 0.4999)) {
          tmpvar_84 = 0.0;
        } else {
          tmpvar_84 = (0.5 + (tmpvar_85 * (
            ((0.8431027 * tmpvar_85) * tmpvar_85)
           - 1.144536)));
        };
      };
      color0_74 = mix (color0_74, vColor01, tmpvar_84);
      tmpvar_78 = bool(1);
    };
    tmpvar_77 = bool(1);
    if (tmpvar_78) tmpvar_77 = bool(0);
    if (tmpvar_77) {
      tmpvar_78 = bool(1);
    };
    color0_4 = color0_74;
    vec4 color0_86;
    color0_86 = vColor10;
    vec2 tmpvar_87;
    if ((tmpvar_8.y != 0)) {
      tmpvar_87 = vec2(0.0, 1.0);
    } else {
      tmpvar_87 = vec2(1.0, 0.0);
    };
    float tmpvar_88;
    tmpvar_88 = dot (vPos, tmpvar_87);
    bool tmpvar_89;
    tmpvar_89 = bool(0);
    bool tmpvar_90;
    tmpvar_90 = bool(0);
    if ((2 == tmpvar_7.y)) tmpvar_89 = bool(1);
    if (tmpvar_90) tmpvar_89 = bool(0);
    if (tmpvar_89) {
      float d_91;
      d_91 = -1.0;
      float tmpvar_92;
      tmpvar_92 = dot (vPartialWidths.xy, tmpvar_87);
      if ((tmpvar_92 >= 1.0)) {
        vec2 tmpvar_93;
        tmpvar_93.x = (dot (vEdgeReference.xy, tmpvar_87) + tmpvar_92);
        tmpvar_93.y = (dot (vEdgeReference.zw, tmpvar_87) - tmpvar_92);
        d_91 = min ((tmpvar_88 - tmpvar_93.x), (tmpvar_93.y - tmpvar_88));
      };
      float tmpvar_94;
      float tmpvar_95;
      tmpvar_95 = ((0.5 * d_91) / tmpvar_5);
      if ((tmpvar_95 <= -0.4999)) {
        tmpvar_94 = 1.0;
      } else {
        if ((tmpvar_95 >= 0.4999)) {
          tmpvar_94 = 0.0;
        } else {
          tmpvar_94 = (0.5 + (tmpvar_95 * (
            ((0.8431027 * tmpvar_95) * tmpvar_95)
           - 1.144536)));
        };
      };
      color0_86 = (vColor10 * tmpvar_94);
      tmpvar_90 = bool(1);
    };
    if ((6 == tmpvar_7.y)) tmpvar_89 = bool(1);
    if ((7 == tmpvar_7.y)) tmpvar_89 = bool(1);
    if (tmpvar_90) tmpvar_89 = bool(0);
    if (tmpvar_89) {
      float tmpvar_96;
      float tmpvar_97;
      tmpvar_97 = ((0.5 * (tmpvar_88 - 
        dot ((vEdgeReference.xy + vPartialWidths.zw), tmpvar_87)
      )) / tmpvar_5);
      if ((tmpvar_97 <= -0.4999)) {
        tmpvar_96 = 1.0;
      } else {
        if ((tmpvar_97 >= 0.4999)) {
          tmpvar_96 = 0.0;
        } else {
          tmpvar_96 = (0.5 + (tmpvar_97 * (
            ((0.8431027 * tmpvar_97) * tmpvar_97)
           - 1.144536)));
        };
      };
      color0_86 = mix (color0_86, vColor11, tmpvar_96);
      tmpvar_90 = bool(1);
    };
    tmpvar_89 = bool(1);
    if (tmpvar_90) tmpvar_89 = bool(0);
    if (tmpvar_89) {
      tmpvar_90 = bool(1);
    };
    color1_3 = color0_86;
  };
  float tmpvar_98;
  float tmpvar_99;
  tmpvar_99 = ((0.5 * d_1) / tmpvar_5);
  if ((tmpvar_99 <= -0.4999)) {
    tmpvar_98 = 1.0;
  } else {
    if ((tmpvar_99 >= 0.4999)) {
      tmpvar_98 = 0.0;
    } else {
      tmpvar_98 = (0.5 + (tmpvar_99 * (
        ((0.8431027 * tmpvar_99) * tmpvar_99)
       - 1.144536)));
    };
  };
  oFragColor = (mix (color0_4, color1_3, mix_factor_2) * tmpvar_98);
}

