#version 150
precision highp float;
out vec4 oFragColor;
flat in vec4 vColor00;
flat in vec4 vColor01;
flat in vec4 vColor10;
flat in vec4 vColor11;
flat in vec4 vColorLine;
flat in ivec4 vConfig;
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
  ivec2 tmpvar_7;
  tmpvar_7.x = (vConfig.y & 255);
  tmpvar_7.y = (vConfig.y >> 8);
  ivec2 tmpvar_8;
  tmpvar_8.x = (vConfig.z & 255);
  tmpvar_8.y = (vConfig.z >> 8);
  mix_factor_2 = 0.0;
  if ((tmpvar_8.x != tmpvar_8.y)) {
    float tmpvar_9;
    float tmpvar_10;
    tmpvar_10 = ((0.5 * -(
      dot ((vColorLine.zw * inversesqrt(dot (vColorLine.zw, vColorLine.zw))), (vColorLine.xy - vPos))
    )) / tmpvar_5);
    if ((-0.4999 >= tmpvar_10)) {
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
  bool tmpvar_12;
  tmpvar_12 = (lessThan ((vClipCenter_Sign.zw * tmpvar_11), vec2(0.0, 0.0)) == bvec2(1, 1));
  d_1 = -1.0;
  bool tmpvar_13;
  tmpvar_13 = bool(0);
  while (true) {
    tmpvar_13 = (tmpvar_13 || (3 == vConfig.w));
    if (tmpvar_13) {
      vec2 tmpvar_14;
      tmpvar_14 = (vClipParams1.xy - vPos);
      d_1 = (sqrt(dot (tmpvar_14, tmpvar_14)) - vClipParams1.z);
      break;
    };
    tmpvar_13 = (tmpvar_13 || (2 == vConfig.w));
    if (tmpvar_13) {
      bool tmpvar_15;
      tmpvar_15 = (vClipParams1.x == 0.0);
      float tmpvar_16;
      if (tmpvar_15) {
        tmpvar_16 = vClipParams1.y;
      } else {
        tmpvar_16 = vClipParams1.x;
      };
      float tmpvar_17;
      if (tmpvar_15) {
        tmpvar_17 = vPos.y;
      } else {
        tmpvar_17 = vPos.x;
      };
      bool tmpvar_18;
      tmpvar_18 = ((tmpvar_17 < tmpvar_16) || ((3.0 * tmpvar_16) < tmpvar_17));
      if (!(tmpvar_18)) {
        d_1 = 1.0;
      };
      break;
    };
    tmpvar_13 = (tmpvar_13 || (1 == vConfig.w));
    if (tmpvar_13) {
      d_1 = max (dot ((vClipParams1.zw * 
        inversesqrt(dot (vClipParams1.zw, vClipParams1.zw))
      ), (vClipParams1.xy - vPos)), -(dot (
        (vClipParams2.zw * inversesqrt(dot (vClipParams2.zw, vClipParams2.zw)))
      , 
        (vClipParams2.xy - vPos)
      )));
      break;
    };
    tmpvar_13 = bool(1);
    break;
  };
  if (tmpvar_12) {
    float dist_19;
    if ((greaterThanEqual (vec2(0.0, 0.0), vClipRadii.xy) != bvec2(0, 0))) {
      dist_19 = sqrt(dot (tmpvar_11, tmpvar_11));
    } else {
      vec2 tmpvar_20;
      tmpvar_20 = (1.0/((vClipRadii.xy * vClipRadii.xy)));
      vec2 tmpvar_21;
      tmpvar_21 = ((2.0 * tmpvar_11) * tmpvar_20);
      dist_19 = ((dot (
        ((tmpvar_11 * tmpvar_11) * tmpvar_20)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_21, tmpvar_21)));
    };
    float tmpvar_22;
    tmpvar_22 = min (max (dist_19, -(tmpvar_5)), tmpvar_5);
    float dist_23;
    if ((greaterThanEqual (vec2(0.0, 0.0), vClipRadii.zw) != bvec2(0, 0))) {
      dist_23 = sqrt(dot (tmpvar_11, tmpvar_11));
    } else {
      vec2 tmpvar_24;
      tmpvar_24 = (1.0/((vClipRadii.zw * vClipRadii.zw)));
      vec2 tmpvar_25;
      tmpvar_25 = ((2.0 * tmpvar_11) * tmpvar_24);
      dist_23 = ((dot (
        ((tmpvar_11 * tmpvar_11) * tmpvar_24)
      , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_25, tmpvar_25)));
    };
    d_1 = max (d_1, max (tmpvar_22, -(
      min (max (dist_23, -(tmpvar_5)), tmpvar_5)
    )));
    vec4 tmpvar_26;
    tmpvar_26 = vColor00;
    bool tmpvar_27;
    tmpvar_27 = bool(0);
    while (true) {
      tmpvar_27 = (tmpvar_27 || (2 == tmpvar_7.x));
      if (tmpvar_27) {
        vec2 tmpvar_28;
        tmpvar_28 = (vClipRadii.xy - vPartialWidths.xy);
        float dist_29;
        if ((greaterThanEqual (vec2(0.0, 0.0), tmpvar_28) != bvec2(0, 0))) {
          dist_29 = sqrt(dot (tmpvar_11, tmpvar_11));
        } else {
          vec2 tmpvar_30;
          tmpvar_30 = (1.0/((tmpvar_28 * tmpvar_28)));
          vec2 tmpvar_31;
          tmpvar_31 = ((2.0 * tmpvar_11) * tmpvar_30);
          dist_29 = ((dot (
            ((tmpvar_11 * tmpvar_11) * tmpvar_30)
          , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_31, tmpvar_31)));
        };
        float tmpvar_32;
        tmpvar_32 = min (max (dist_29, -(tmpvar_5)), tmpvar_5);
        vec2 tmpvar_33;
        tmpvar_33 = (vClipRadii.xy - (2.0 * vPartialWidths.xy));
        float dist_34;
        if ((greaterThanEqual (vec2(0.0, 0.0), tmpvar_33) != bvec2(0, 0))) {
          dist_34 = sqrt(dot (tmpvar_11, tmpvar_11));
        } else {
          vec2 tmpvar_35;
          tmpvar_35 = (1.0/((tmpvar_33 * tmpvar_33)));
          vec2 tmpvar_36;
          tmpvar_36 = ((2.0 * tmpvar_11) * tmpvar_35);
          dist_34 = ((dot (
            ((tmpvar_11 * tmpvar_11) * tmpvar_35)
          , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_36, tmpvar_36)));
        };
        float tmpvar_37;
        float tmpvar_38;
        tmpvar_38 = ((0.5 * min (
          -(tmpvar_32)
        , 
          min (max (dist_34, -(tmpvar_5)), tmpvar_5)
        )) / tmpvar_5);
        if ((-0.4999 >= tmpvar_38)) {
          tmpvar_37 = 1.0;
        } else {
          if ((tmpvar_38 >= 0.4999)) {
            tmpvar_37 = 0.0;
          } else {
            tmpvar_37 = (0.5 + (tmpvar_38 * (
              ((0.8431027 * tmpvar_38) * tmpvar_38)
             - 1.144536)));
          };
        };
        tmpvar_26 = (tmpvar_26 * tmpvar_37);
        break;
      };
      tmpvar_27 = (tmpvar_27 || (6 == tmpvar_7.x));
      tmpvar_27 = (tmpvar_27 || (7 == tmpvar_7.x));
      if (tmpvar_27) {
        float swizzled_factor_39;
        vec2 tmpvar_40;
        tmpvar_40 = (vClipRadii.xy - vPartialWidths.zw);
        float dist_41;
        if ((greaterThanEqual (vec2(0.0, 0.0), tmpvar_40) != bvec2(0, 0))) {
          dist_41 = sqrt(dot (tmpvar_11, tmpvar_11));
        } else {
          vec2 tmpvar_42;
          tmpvar_42 = (1.0/((tmpvar_40 * tmpvar_40)));
          vec2 tmpvar_43;
          tmpvar_43 = ((2.0 * tmpvar_11) * tmpvar_42);
          dist_41 = ((dot (
            ((tmpvar_11 * tmpvar_11) * tmpvar_42)
          , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_43, tmpvar_43)));
        };
        float tmpvar_44;
        float tmpvar_45;
        tmpvar_45 = ((0.5 * min (
          max (dist_41, -(tmpvar_5))
        , tmpvar_5)) / tmpvar_5);
        if ((-0.4999 >= tmpvar_45)) {
          tmpvar_44 = 1.0;
        } else {
          if ((tmpvar_45 >= 0.4999)) {
            tmpvar_44 = 0.0;
          } else {
            tmpvar_44 = (0.5 + (tmpvar_45 * (
              ((0.8431027 * tmpvar_45) * tmpvar_45)
             - 1.144536)));
          };
        };
        bool tmpvar_46;
        tmpvar_46 = bool(0);
        while (true) {
          tmpvar_46 = (tmpvar_46 || (0 == vConfig.x));
          if (tmpvar_46) {
            swizzled_factor_39 = 0.0;
            break;
          };
          tmpvar_46 = (tmpvar_46 || (1 == vConfig.x));
          if (tmpvar_46) {
            swizzled_factor_39 = mix_factor_2;
            break;
          };
          tmpvar_46 = (tmpvar_46 || (2 == vConfig.x));
          if (tmpvar_46) {
            swizzled_factor_39 = 1.0;
            break;
          };
          tmpvar_46 = (tmpvar_46 || (3 == vConfig.x));
          if (tmpvar_46) {
            swizzled_factor_39 = (1.0 - mix_factor_2);
            break;
          };
          tmpvar_46 = bool(1);
          swizzled_factor_39 = 0.0;
          break;
        };
        tmpvar_26 = mix (mix (vColor01, tmpvar_26, swizzled_factor_39), mix (tmpvar_26, vColor01, swizzled_factor_39), tmpvar_44);
        break;
      };
      tmpvar_27 = bool(1);
      break;
    };
    color0_4 = tmpvar_26;
    vec4 tmpvar_47;
    tmpvar_47 = vColor10;
    bool tmpvar_48;
    tmpvar_48 = bool(0);
    while (true) {
      tmpvar_48 = (tmpvar_48 || (2 == tmpvar_7.y));
      if (tmpvar_48) {
        vec2 tmpvar_49;
        tmpvar_49 = (vClipRadii.xy - vPartialWidths.xy);
        float dist_50;
        if ((greaterThanEqual (vec2(0.0, 0.0), tmpvar_49) != bvec2(0, 0))) {
          dist_50 = sqrt(dot (tmpvar_11, tmpvar_11));
        } else {
          vec2 tmpvar_51;
          tmpvar_51 = (1.0/((tmpvar_49 * tmpvar_49)));
          vec2 tmpvar_52;
          tmpvar_52 = ((2.0 * tmpvar_11) * tmpvar_51);
          dist_50 = ((dot (
            ((tmpvar_11 * tmpvar_11) * tmpvar_51)
          , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_52, tmpvar_52)));
        };
        float tmpvar_53;
        tmpvar_53 = min (max (dist_50, -(tmpvar_5)), tmpvar_5);
        vec2 tmpvar_54;
        tmpvar_54 = (vClipRadii.xy - (2.0 * vPartialWidths.xy));
        float dist_55;
        if ((greaterThanEqual (vec2(0.0, 0.0), tmpvar_54) != bvec2(0, 0))) {
          dist_55 = sqrt(dot (tmpvar_11, tmpvar_11));
        } else {
          vec2 tmpvar_56;
          tmpvar_56 = (1.0/((tmpvar_54 * tmpvar_54)));
          vec2 tmpvar_57;
          tmpvar_57 = ((2.0 * tmpvar_11) * tmpvar_56);
          dist_55 = ((dot (
            ((tmpvar_11 * tmpvar_11) * tmpvar_56)
          , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_57, tmpvar_57)));
        };
        float tmpvar_58;
        float tmpvar_59;
        tmpvar_59 = ((0.5 * min (
          -(tmpvar_53)
        , 
          min (max (dist_55, -(tmpvar_5)), tmpvar_5)
        )) / tmpvar_5);
        if ((-0.4999 >= tmpvar_59)) {
          tmpvar_58 = 1.0;
        } else {
          if ((tmpvar_59 >= 0.4999)) {
            tmpvar_58 = 0.0;
          } else {
            tmpvar_58 = (0.5 + (tmpvar_59 * (
              ((0.8431027 * tmpvar_59) * tmpvar_59)
             - 1.144536)));
          };
        };
        tmpvar_47 = (tmpvar_47 * tmpvar_58);
        break;
      };
      tmpvar_48 = (tmpvar_48 || (6 == tmpvar_7.y));
      tmpvar_48 = (tmpvar_48 || (7 == tmpvar_7.y));
      if (tmpvar_48) {
        float swizzled_factor_60;
        vec2 tmpvar_61;
        tmpvar_61 = (vClipRadii.xy - vPartialWidths.zw);
        float dist_62;
        if ((greaterThanEqual (vec2(0.0, 0.0), tmpvar_61) != bvec2(0, 0))) {
          dist_62 = sqrt(dot (tmpvar_11, tmpvar_11));
        } else {
          vec2 tmpvar_63;
          tmpvar_63 = (1.0/((tmpvar_61 * tmpvar_61)));
          vec2 tmpvar_64;
          tmpvar_64 = ((2.0 * tmpvar_11) * tmpvar_63);
          dist_62 = ((dot (
            ((tmpvar_11 * tmpvar_11) * tmpvar_63)
          , vec2(1.0, 1.0)) - 1.0) * inversesqrt(dot (tmpvar_64, tmpvar_64)));
        };
        float tmpvar_65;
        float tmpvar_66;
        tmpvar_66 = ((0.5 * min (
          max (dist_62, -(tmpvar_5))
        , tmpvar_5)) / tmpvar_5);
        if ((-0.4999 >= tmpvar_66)) {
          tmpvar_65 = 1.0;
        } else {
          if ((tmpvar_66 >= 0.4999)) {
            tmpvar_65 = 0.0;
          } else {
            tmpvar_65 = (0.5 + (tmpvar_66 * (
              ((0.8431027 * tmpvar_66) * tmpvar_66)
             - 1.144536)));
          };
        };
        bool tmpvar_67;
        tmpvar_67 = bool(0);
        while (true) {
          tmpvar_67 = (tmpvar_67 || (0 == vConfig.x));
          if (tmpvar_67) {
            swizzled_factor_60 = 0.0;
            break;
          };
          tmpvar_67 = (tmpvar_67 || (1 == vConfig.x));
          if (tmpvar_67) {
            swizzled_factor_60 = mix_factor_2;
            break;
          };
          tmpvar_67 = (tmpvar_67 || (2 == vConfig.x));
          if (tmpvar_67) {
            swizzled_factor_60 = 1.0;
            break;
          };
          tmpvar_67 = (tmpvar_67 || (3 == vConfig.x));
          if (tmpvar_67) {
            swizzled_factor_60 = (1.0 - mix_factor_2);
            break;
          };
          tmpvar_67 = bool(1);
          swizzled_factor_60 = 0.0;
          break;
        };
        tmpvar_47 = mix (mix (vColor11, tmpvar_47, swizzled_factor_60), mix (tmpvar_47, vColor11, swizzled_factor_60), tmpvar_65);
        break;
      };
      tmpvar_48 = bool(1);
      break;
    };
    color1_3 = tmpvar_47;
  } else {
    vec4 tmpvar_68;
    tmpvar_68 = vColor00;
    float pos_69;
    vec2 tmpvar_70;
    if ((tmpvar_8.x != 0)) {
      tmpvar_70 = vec2(0.0, 1.0);
    } else {
      tmpvar_70 = vec2(1.0, 0.0);
    };
    pos_69 = dot (vPos, tmpvar_70);
    bool tmpvar_71;
    tmpvar_71 = bool(0);
    while (true) {
      tmpvar_71 = (tmpvar_71 || (2 == tmpvar_7.x));
      if (tmpvar_71) {
        float d_72;
        d_72 = -1.0;
        float tmpvar_73;
        tmpvar_73 = dot (vPartialWidths.xy, tmpvar_70);
        if ((tmpvar_73 >= 1.0)) {
          vec2 tmpvar_74;
          tmpvar_74.x = (dot (vEdgeReference.xy, tmpvar_70) + tmpvar_73);
          tmpvar_74.y = (dot (vEdgeReference.zw, tmpvar_70) - tmpvar_73);
          d_72 = min ((pos_69 - tmpvar_74.x), (tmpvar_74.y - pos_69));
        };
        float tmpvar_75;
        float tmpvar_76;
        tmpvar_76 = ((0.5 * d_72) / tmpvar_5);
        if ((-0.4999 >= tmpvar_76)) {
          tmpvar_75 = 1.0;
        } else {
          if ((tmpvar_76 >= 0.4999)) {
            tmpvar_75 = 0.0;
          } else {
            tmpvar_75 = (0.5 + (tmpvar_76 * (
              ((0.8431027 * tmpvar_76) * tmpvar_76)
             - 1.144536)));
          };
        };
        tmpvar_68 = (tmpvar_68 * tmpvar_75);
        break;
      };
      tmpvar_71 = (tmpvar_71 || (6 == tmpvar_7.x));
      tmpvar_71 = (tmpvar_71 || (7 == tmpvar_7.x));
      if (tmpvar_71) {
        float tmpvar_77;
        float tmpvar_78;
        tmpvar_78 = ((0.5 * (pos_69 - 
          dot ((vEdgeReference.xy + vPartialWidths.zw), tmpvar_70)
        )) / tmpvar_5);
        if ((-0.4999 >= tmpvar_78)) {
          tmpvar_77 = 1.0;
        } else {
          if ((tmpvar_78 >= 0.4999)) {
            tmpvar_77 = 0.0;
          } else {
            tmpvar_77 = (0.5 + (tmpvar_78 * (
              ((0.8431027 * tmpvar_78) * tmpvar_78)
             - 1.144536)));
          };
        };
        tmpvar_68 = mix (tmpvar_68, vColor01, tmpvar_77);
        break;
      };
      tmpvar_71 = bool(1);
      break;
    };
    color0_4 = tmpvar_68;
    vec4 tmpvar_79;
    tmpvar_79 = vColor10;
    float pos_80;
    vec2 tmpvar_81;
    if ((tmpvar_8.y != 0)) {
      tmpvar_81 = vec2(0.0, 1.0);
    } else {
      tmpvar_81 = vec2(1.0, 0.0);
    };
    pos_80 = dot (vPos, tmpvar_81);
    bool tmpvar_82;
    tmpvar_82 = bool(0);
    while (true) {
      tmpvar_82 = (tmpvar_82 || (2 == tmpvar_7.y));
      if (tmpvar_82) {
        float d_83;
        d_83 = -1.0;
        float tmpvar_84;
        tmpvar_84 = dot (vPartialWidths.xy, tmpvar_81);
        if ((tmpvar_84 >= 1.0)) {
          vec2 tmpvar_85;
          tmpvar_85.x = (dot (vEdgeReference.xy, tmpvar_81) + tmpvar_84);
          tmpvar_85.y = (dot (vEdgeReference.zw, tmpvar_81) - tmpvar_84);
          d_83 = min ((pos_80 - tmpvar_85.x), (tmpvar_85.y - pos_80));
        };
        float tmpvar_86;
        float tmpvar_87;
        tmpvar_87 = ((0.5 * d_83) / tmpvar_5);
        if ((-0.4999 >= tmpvar_87)) {
          tmpvar_86 = 1.0;
        } else {
          if ((tmpvar_87 >= 0.4999)) {
            tmpvar_86 = 0.0;
          } else {
            tmpvar_86 = (0.5 + (tmpvar_87 * (
              ((0.8431027 * tmpvar_87) * tmpvar_87)
             - 1.144536)));
          };
        };
        tmpvar_79 = (tmpvar_79 * tmpvar_86);
        break;
      };
      tmpvar_82 = (tmpvar_82 || (6 == tmpvar_7.y));
      tmpvar_82 = (tmpvar_82 || (7 == tmpvar_7.y));
      if (tmpvar_82) {
        float tmpvar_88;
        float tmpvar_89;
        tmpvar_89 = ((0.5 * (pos_80 - 
          dot ((vEdgeReference.xy + vPartialWidths.zw), tmpvar_81)
        )) / tmpvar_5);
        if ((-0.4999 >= tmpvar_89)) {
          tmpvar_88 = 1.0;
        } else {
          if ((tmpvar_89 >= 0.4999)) {
            tmpvar_88 = 0.0;
          } else {
            tmpvar_88 = (0.5 + (tmpvar_89 * (
              ((0.8431027 * tmpvar_89) * tmpvar_89)
             - 1.144536)));
          };
        };
        tmpvar_79 = mix (tmpvar_79, vColor11, tmpvar_88);
        break;
      };
      tmpvar_82 = bool(1);
      break;
    };
    color1_3 = tmpvar_79;
  };
  float tmpvar_90;
  float tmpvar_91;
  tmpvar_91 = ((0.5 * d_1) / tmpvar_5);
  if ((-0.4999 >= tmpvar_91)) {
    tmpvar_90 = 1.0;
  } else {
    if ((tmpvar_91 >= 0.4999)) {
      tmpvar_90 = 0.0;
    } else {
      tmpvar_90 = (0.5 + (tmpvar_91 * (
        ((0.8431027 * tmpvar_91) * tmpvar_91)
       - 1.144536)));
    };
  };
  oFragColor = (mix (color0_4, color1_3, mix_factor_2) * tmpvar_90);
}

