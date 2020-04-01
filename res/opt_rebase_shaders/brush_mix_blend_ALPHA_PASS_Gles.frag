#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_0;
in highp vec4 varying_vec4_1;
void main ()
{
  vec4 frag_color_1;
  highp vec4 result_2;
  highp vec4 Cs_3;
  highp vec4 Cb_4;
  vec4 tmpvar_5;
  tmpvar_5 = textureLod (sPrevPassColor, varying_vec4_1.xyw, 0.0);
  Cb_4 = tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6 = textureLod (sPrevPassColor, varying_vec4_0.xyw, 0.0);
  Cs_3 = tmpvar_6;
  if ((tmpvar_5.w != 0.0)) {
    Cb_4.xyz = (tmpvar_5.xyz / tmpvar_5.w);
  };
  if ((tmpvar_6.w != 0.0)) {
    Cs_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  };
  result_2 = vec4(1.0, 1.0, 0.0, 1.0);
  bool tmpvar_7;
  tmpvar_7 = bool(0);
  while (true) {
    tmpvar_7 = (tmpvar_7 || (1 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      result_2.xyz = (Cb_4.xyz * Cs_3.xyz);
      break;
    };
    tmpvar_7 = (tmpvar_7 || (2 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      result_2.xyz = ((Cb_4.xyz + Cs_3.xyz) - (Cb_4.xyz * Cs_3.xyz));
      break;
    };
    tmpvar_7 = (tmpvar_7 || (3 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      highp vec3 tmpvar_8;
      tmpvar_8 = ((2.0 * Cb_4.xyz) - 1.0);
      result_2.xyz = mix ((Cs_3.xyz * (2.0 * Cb_4.xyz)), ((Cs_3.xyz + tmpvar_8) - (Cs_3.xyz * tmpvar_8)), vec3(greaterThanEqual (Cb_4.xyz, vec3(0.5, 0.5, 0.5))));
      break;
    };
    tmpvar_7 = (tmpvar_7 || (4 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      result_2.xyz = min (Cs_3.xyz, Cb_4.xyz);
      break;
    };
    tmpvar_7 = (tmpvar_7 || (5 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      result_2.xyz = max (Cs_3.xyz, Cb_4.xyz);
      break;
    };
    tmpvar_7 = (tmpvar_7 || (6 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      float tmpvar_9;
      if ((Cb_4.x == 0.0)) {
        tmpvar_9 = 0.0;
      } else {
        if ((Cs_3.x == 1.0)) {
          tmpvar_9 = 1.0;
        } else {
          tmpvar_9 = min (1.0, (Cb_4.x / (1.0 - Cs_3.x)));
        };
      };
      result_2.x = tmpvar_9;
      float tmpvar_10;
      if ((Cb_4.y == 0.0)) {
        tmpvar_10 = 0.0;
      } else {
        if ((Cs_3.y == 1.0)) {
          tmpvar_10 = 1.0;
        } else {
          tmpvar_10 = min (1.0, (Cb_4.y / (1.0 - Cs_3.y)));
        };
      };
      result_2.y = tmpvar_10;
      float tmpvar_11;
      if ((Cb_4.z == 0.0)) {
        tmpvar_11 = 0.0;
      } else {
        if ((Cs_3.z == 1.0)) {
          tmpvar_11 = 1.0;
        } else {
          tmpvar_11 = min (1.0, (Cb_4.z / (1.0 - Cs_3.z)));
        };
      };
      result_2.z = tmpvar_11;
      break;
    };
    tmpvar_7 = (tmpvar_7 || (7 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      float tmpvar_12;
      if ((Cb_4.x == 1.0)) {
        tmpvar_12 = 1.0;
      } else {
        if ((Cs_3.x == 0.0)) {
          tmpvar_12 = 0.0;
        } else {
          tmpvar_12 = (1.0 - min (1.0, (
            (1.0 - Cb_4.x)
           / Cs_3.x)));
        };
      };
      result_2.x = tmpvar_12;
      float tmpvar_13;
      if ((Cb_4.y == 1.0)) {
        tmpvar_13 = 1.0;
      } else {
        if ((Cs_3.y == 0.0)) {
          tmpvar_13 = 0.0;
        } else {
          tmpvar_13 = (1.0 - min (1.0, (
            (1.0 - Cb_4.y)
           / Cs_3.y)));
        };
      };
      result_2.y = tmpvar_13;
      float tmpvar_14;
      if ((Cb_4.z == 1.0)) {
        tmpvar_14 = 1.0;
      } else {
        if ((Cs_3.z == 0.0)) {
          tmpvar_14 = 0.0;
        } else {
          tmpvar_14 = (1.0 - min (1.0, (
            (1.0 - Cb_4.z)
           / Cs_3.z)));
        };
      };
      result_2.z = tmpvar_14;
      break;
    };
    tmpvar_7 = (tmpvar_7 || (8 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      highp vec3 tmpvar_15;
      tmpvar_15 = ((2.0 * Cs_3.xyz) - 1.0);
      result_2.xyz = mix ((Cb_4.xyz * (2.0 * Cs_3.xyz)), ((Cb_4.xyz + tmpvar_15) - (Cb_4.xyz * tmpvar_15)), vec3(greaterThanEqual (Cs_3.xyz, vec3(0.5, 0.5, 0.5))));
      break;
    };
    tmpvar_7 = (tmpvar_7 || (9 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      float tmpvar_16;
      if ((0.5 >= Cs_3.x)) {
        tmpvar_16 = (Cb_4.x - ((
          (1.0 - (2.0 * Cs_3.x))
         * Cb_4.x) * (1.0 - Cb_4.x)));
      } else {
        highp float D_17;
        if ((0.25 >= Cb_4.x)) {
          D_17 = (((
            ((16.0 * Cb_4.x) - 12.0)
           * Cb_4.x) + 4.0) * Cb_4.x);
        } else {
          D_17 = sqrt(Cb_4.x);
        };
        tmpvar_16 = (Cb_4.x + ((
          (2.0 * Cs_3.x)
         - 1.0) * (D_17 - Cb_4.x)));
      };
      result_2.x = tmpvar_16;
      float tmpvar_18;
      if ((0.5 >= Cs_3.y)) {
        tmpvar_18 = (Cb_4.y - ((
          (1.0 - (2.0 * Cs_3.y))
         * Cb_4.y) * (1.0 - Cb_4.y)));
      } else {
        highp float D_19;
        if ((0.25 >= Cb_4.y)) {
          D_19 = (((
            ((16.0 * Cb_4.y) - 12.0)
           * Cb_4.y) + 4.0) * Cb_4.y);
        } else {
          D_19 = sqrt(Cb_4.y);
        };
        tmpvar_18 = (Cb_4.y + ((
          (2.0 * Cs_3.y)
         - 1.0) * (D_19 - Cb_4.y)));
      };
      result_2.y = tmpvar_18;
      float tmpvar_20;
      if ((0.5 >= Cs_3.z)) {
        tmpvar_20 = (Cb_4.z - ((
          (1.0 - (2.0 * Cs_3.z))
         * Cb_4.z) * (1.0 - Cb_4.z)));
      } else {
        highp float D_21;
        if ((0.25 >= Cb_4.z)) {
          D_21 = (((
            ((16.0 * Cb_4.z) - 12.0)
           * Cb_4.z) + 4.0) * Cb_4.z);
        } else {
          D_21 = sqrt(Cb_4.z);
        };
        tmpvar_20 = (Cb_4.z + ((
          (2.0 * Cs_3.z)
         - 1.0) * (D_21 - Cb_4.z)));
      };
      result_2.z = tmpvar_20;
      break;
    };
    tmpvar_7 = (tmpvar_7 || (10 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      result_2.xyz = abs((Cb_4.xyz - Cs_3.xyz));
      break;
    };
    tmpvar_7 = (tmpvar_7 || (11 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      result_2.xyz = ((Cb_4.xyz + Cs_3.xyz) - ((2.0 * Cb_4.xyz) * Cs_3.xyz));
      break;
    };
    tmpvar_7 = (tmpvar_7 || (12 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      highp vec3 tmpvar_22;
      tmpvar_22 = Cs_3.xyz;
      float tmpvar_23;
      tmpvar_23 = (max (Cb_4.x, max (Cb_4.y, Cb_4.z)) - min (Cb_4.x, min (Cb_4.y, Cb_4.z)));
      highp vec3 tmpvar_24;
      tmpvar_24 = tmpvar_22;
      if ((Cs_3.y >= Cs_3.x)) {
        if ((Cs_3.z >= Cs_3.y)) {
          float tmpvar_25;
          tmpvar_25 = tmpvar_22.x;
          float tmpvar_26;
          tmpvar_26 = tmpvar_22.y;
          float tmpvar_27;
          tmpvar_27 = tmpvar_22.z;
          highp float tmpvar_28;
          tmpvar_28 = tmpvar_25;
          highp float tmpvar_29;
          tmpvar_29 = tmpvar_26;
          highp float tmpvar_30;
          tmpvar_30 = tmpvar_27;
          if ((Cs_3.x < Cs_3.z)) {
            tmpvar_29 = (((Cs_3.y - Cs_3.x) * tmpvar_23) / (Cs_3.z - Cs_3.x));
            tmpvar_30 = tmpvar_23;
          } else {
            tmpvar_29 = 0.0;
            tmpvar_30 = 0.0;
          };
          tmpvar_28 = 0.0;
          tmpvar_25 = tmpvar_28;
          tmpvar_26 = tmpvar_29;
          tmpvar_27 = tmpvar_30;
          tmpvar_24.x = 0.0;
          tmpvar_24.y = tmpvar_29;
          tmpvar_24.z = tmpvar_30;
        } else {
          if ((Cs_3.z >= Cs_3.x)) {
            float tmpvar_31;
            tmpvar_31 = tmpvar_22.x;
            float tmpvar_32;
            tmpvar_32 = tmpvar_22.z;
            float tmpvar_33;
            tmpvar_33 = tmpvar_22.y;
            highp float tmpvar_34;
            tmpvar_34 = tmpvar_31;
            highp float tmpvar_35;
            tmpvar_35 = tmpvar_32;
            highp float tmpvar_36;
            tmpvar_36 = tmpvar_33;
            if ((Cs_3.x < Cs_3.y)) {
              tmpvar_35 = (((Cs_3.z - Cs_3.x) * tmpvar_23) / (Cs_3.y - Cs_3.x));
              tmpvar_36 = tmpvar_23;
            } else {
              tmpvar_35 = 0.0;
              tmpvar_36 = 0.0;
            };
            tmpvar_34 = 0.0;
            tmpvar_31 = tmpvar_34;
            tmpvar_32 = tmpvar_35;
            tmpvar_33 = tmpvar_36;
            tmpvar_24.x = 0.0;
            tmpvar_24.z = tmpvar_35;
            tmpvar_24.y = tmpvar_36;
          } else {
            float tmpvar_37;
            tmpvar_37 = tmpvar_22.z;
            float tmpvar_38;
            tmpvar_38 = tmpvar_22.x;
            float tmpvar_39;
            tmpvar_39 = tmpvar_22.y;
            highp float tmpvar_40;
            tmpvar_40 = tmpvar_37;
            highp float tmpvar_41;
            tmpvar_41 = tmpvar_38;
            highp float tmpvar_42;
            tmpvar_42 = tmpvar_39;
            if ((Cs_3.z < Cs_3.y)) {
              tmpvar_41 = (((Cs_3.x - Cs_3.z) * tmpvar_23) / (Cs_3.y - Cs_3.z));
              tmpvar_42 = tmpvar_23;
            } else {
              tmpvar_41 = 0.0;
              tmpvar_42 = 0.0;
            };
            tmpvar_40 = 0.0;
            tmpvar_37 = tmpvar_40;
            tmpvar_38 = tmpvar_41;
            tmpvar_39 = tmpvar_42;
            tmpvar_24.z = 0.0;
            tmpvar_24.x = tmpvar_41;
            tmpvar_24.y = tmpvar_42;
          };
        };
      } else {
        if ((Cs_3.z >= Cs_3.x)) {
          float tmpvar_43;
          tmpvar_43 = tmpvar_22.y;
          float tmpvar_44;
          tmpvar_44 = tmpvar_22.x;
          float tmpvar_45;
          tmpvar_45 = tmpvar_22.z;
          highp float tmpvar_46;
          tmpvar_46 = tmpvar_43;
          highp float tmpvar_47;
          tmpvar_47 = tmpvar_44;
          highp float tmpvar_48;
          tmpvar_48 = tmpvar_45;
          if ((Cs_3.y < Cs_3.z)) {
            tmpvar_47 = (((Cs_3.x - Cs_3.y) * tmpvar_23) / (Cs_3.z - Cs_3.y));
            tmpvar_48 = tmpvar_23;
          } else {
            tmpvar_47 = 0.0;
            tmpvar_48 = 0.0;
          };
          tmpvar_46 = 0.0;
          tmpvar_43 = tmpvar_46;
          tmpvar_44 = tmpvar_47;
          tmpvar_45 = tmpvar_48;
          tmpvar_24.y = 0.0;
          tmpvar_24.x = tmpvar_47;
          tmpvar_24.z = tmpvar_48;
        } else {
          if ((Cs_3.z >= Cs_3.y)) {
            float tmpvar_49;
            tmpvar_49 = tmpvar_22.y;
            float tmpvar_50;
            tmpvar_50 = tmpvar_22.z;
            float tmpvar_51;
            tmpvar_51 = tmpvar_22.x;
            highp float tmpvar_52;
            tmpvar_52 = tmpvar_49;
            highp float tmpvar_53;
            tmpvar_53 = tmpvar_50;
            highp float tmpvar_54;
            tmpvar_54 = tmpvar_51;
            if ((Cs_3.y < Cs_3.x)) {
              tmpvar_53 = (((Cs_3.z - Cs_3.y) * tmpvar_23) / (Cs_3.x - Cs_3.y));
              tmpvar_54 = tmpvar_23;
            } else {
              tmpvar_53 = 0.0;
              tmpvar_54 = 0.0;
            };
            tmpvar_52 = 0.0;
            tmpvar_49 = tmpvar_52;
            tmpvar_50 = tmpvar_53;
            tmpvar_51 = tmpvar_54;
            tmpvar_24.y = 0.0;
            tmpvar_24.z = tmpvar_53;
            tmpvar_24.x = tmpvar_54;
          } else {
            float tmpvar_55;
            tmpvar_55 = tmpvar_22.z;
            float tmpvar_56;
            tmpvar_56 = tmpvar_22.y;
            float tmpvar_57;
            tmpvar_57 = tmpvar_22.x;
            highp float tmpvar_58;
            tmpvar_58 = tmpvar_55;
            highp float tmpvar_59;
            tmpvar_59 = tmpvar_56;
            highp float tmpvar_60;
            tmpvar_60 = tmpvar_57;
            if ((Cs_3.z < Cs_3.x)) {
              tmpvar_59 = (((Cs_3.y - Cs_3.z) * tmpvar_23) / (Cs_3.x - Cs_3.z));
              tmpvar_60 = tmpvar_23;
            } else {
              tmpvar_59 = 0.0;
              tmpvar_60 = 0.0;
            };
            tmpvar_58 = 0.0;
            tmpvar_55 = tmpvar_58;
            tmpvar_56 = tmpvar_59;
            tmpvar_57 = tmpvar_60;
            tmpvar_24.z = 0.0;
            tmpvar_24.y = tmpvar_59;
            tmpvar_24.x = tmpvar_60;
          };
        };
      };
      highp vec3 tmpvar_61;
      tmpvar_61 = (tmpvar_24 + (dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (tmpvar_24, vec3(0.3, 0.59, 0.11))));
      float tmpvar_62;
      tmpvar_62 = dot (tmpvar_61, vec3(0.3, 0.59, 0.11));
      float tmpvar_63;
      tmpvar_63 = min (tmpvar_61.x, min (tmpvar_61.y, tmpvar_61.z));
      float tmpvar_64;
      tmpvar_64 = max (tmpvar_61.x, max (tmpvar_61.y, tmpvar_61.z));
      if ((tmpvar_63 < 0.0)) {
        tmpvar_61 = (tmpvar_62 + ((
          (tmpvar_61 - tmpvar_62)
         * tmpvar_62) / (tmpvar_62 - tmpvar_63)));
      };
      if ((1.0 < tmpvar_64)) {
        tmpvar_61 = (tmpvar_62 + ((
          (tmpvar_61 - tmpvar_62)
         * 
          (1.0 - tmpvar_62)
        ) / (tmpvar_64 - tmpvar_62)));
      };
      result_2.xyz = tmpvar_61;
      break;
    };
    tmpvar_7 = (tmpvar_7 || (13 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      highp vec3 tmpvar_65;
      tmpvar_65 = Cb_4.xyz;
      float tmpvar_66;
      tmpvar_66 = (max (Cs_3.x, max (Cs_3.y, Cs_3.z)) - min (Cs_3.x, min (Cs_3.y, Cs_3.z)));
      highp vec3 tmpvar_67;
      tmpvar_67 = tmpvar_65;
      if ((Cb_4.y >= Cb_4.x)) {
        if ((Cb_4.z >= Cb_4.y)) {
          float tmpvar_68;
          tmpvar_68 = tmpvar_65.x;
          float tmpvar_69;
          tmpvar_69 = tmpvar_65.y;
          float tmpvar_70;
          tmpvar_70 = tmpvar_65.z;
          highp float tmpvar_71;
          tmpvar_71 = tmpvar_68;
          highp float tmpvar_72;
          tmpvar_72 = tmpvar_69;
          highp float tmpvar_73;
          tmpvar_73 = tmpvar_70;
          if ((Cb_4.x < Cb_4.z)) {
            tmpvar_72 = (((Cb_4.y - Cb_4.x) * tmpvar_66) / (Cb_4.z - Cb_4.x));
            tmpvar_73 = tmpvar_66;
          } else {
            tmpvar_72 = 0.0;
            tmpvar_73 = 0.0;
          };
          tmpvar_71 = 0.0;
          tmpvar_68 = tmpvar_71;
          tmpvar_69 = tmpvar_72;
          tmpvar_70 = tmpvar_73;
          tmpvar_67.x = 0.0;
          tmpvar_67.y = tmpvar_72;
          tmpvar_67.z = tmpvar_73;
        } else {
          if ((Cb_4.z >= Cb_4.x)) {
            float tmpvar_74;
            tmpvar_74 = tmpvar_65.x;
            float tmpvar_75;
            tmpvar_75 = tmpvar_65.z;
            float tmpvar_76;
            tmpvar_76 = tmpvar_65.y;
            highp float tmpvar_77;
            tmpvar_77 = tmpvar_74;
            highp float tmpvar_78;
            tmpvar_78 = tmpvar_75;
            highp float tmpvar_79;
            tmpvar_79 = tmpvar_76;
            if ((Cb_4.x < Cb_4.y)) {
              tmpvar_78 = (((Cb_4.z - Cb_4.x) * tmpvar_66) / (Cb_4.y - Cb_4.x));
              tmpvar_79 = tmpvar_66;
            } else {
              tmpvar_78 = 0.0;
              tmpvar_79 = 0.0;
            };
            tmpvar_77 = 0.0;
            tmpvar_74 = tmpvar_77;
            tmpvar_75 = tmpvar_78;
            tmpvar_76 = tmpvar_79;
            tmpvar_67.x = 0.0;
            tmpvar_67.z = tmpvar_78;
            tmpvar_67.y = tmpvar_79;
          } else {
            float tmpvar_80;
            tmpvar_80 = tmpvar_65.z;
            float tmpvar_81;
            tmpvar_81 = tmpvar_65.x;
            float tmpvar_82;
            tmpvar_82 = tmpvar_65.y;
            highp float tmpvar_83;
            tmpvar_83 = tmpvar_80;
            highp float tmpvar_84;
            tmpvar_84 = tmpvar_81;
            highp float tmpvar_85;
            tmpvar_85 = tmpvar_82;
            if ((Cb_4.z < Cb_4.y)) {
              tmpvar_84 = (((Cb_4.x - Cb_4.z) * tmpvar_66) / (Cb_4.y - Cb_4.z));
              tmpvar_85 = tmpvar_66;
            } else {
              tmpvar_84 = 0.0;
              tmpvar_85 = 0.0;
            };
            tmpvar_83 = 0.0;
            tmpvar_80 = tmpvar_83;
            tmpvar_81 = tmpvar_84;
            tmpvar_82 = tmpvar_85;
            tmpvar_67.z = 0.0;
            tmpvar_67.x = tmpvar_84;
            tmpvar_67.y = tmpvar_85;
          };
        };
      } else {
        if ((Cb_4.z >= Cb_4.x)) {
          float tmpvar_86;
          tmpvar_86 = tmpvar_65.y;
          float tmpvar_87;
          tmpvar_87 = tmpvar_65.x;
          float tmpvar_88;
          tmpvar_88 = tmpvar_65.z;
          highp float tmpvar_89;
          tmpvar_89 = tmpvar_86;
          highp float tmpvar_90;
          tmpvar_90 = tmpvar_87;
          highp float tmpvar_91;
          tmpvar_91 = tmpvar_88;
          if ((Cb_4.y < Cb_4.z)) {
            tmpvar_90 = (((Cb_4.x - Cb_4.y) * tmpvar_66) / (Cb_4.z - Cb_4.y));
            tmpvar_91 = tmpvar_66;
          } else {
            tmpvar_90 = 0.0;
            tmpvar_91 = 0.0;
          };
          tmpvar_89 = 0.0;
          tmpvar_86 = tmpvar_89;
          tmpvar_87 = tmpvar_90;
          tmpvar_88 = tmpvar_91;
          tmpvar_67.y = 0.0;
          tmpvar_67.x = tmpvar_90;
          tmpvar_67.z = tmpvar_91;
        } else {
          if ((Cb_4.z >= Cb_4.y)) {
            float tmpvar_92;
            tmpvar_92 = tmpvar_65.y;
            float tmpvar_93;
            tmpvar_93 = tmpvar_65.z;
            float tmpvar_94;
            tmpvar_94 = tmpvar_65.x;
            highp float tmpvar_95;
            tmpvar_95 = tmpvar_92;
            highp float tmpvar_96;
            tmpvar_96 = tmpvar_93;
            highp float tmpvar_97;
            tmpvar_97 = tmpvar_94;
            if ((Cb_4.y < Cb_4.x)) {
              tmpvar_96 = (((Cb_4.z - Cb_4.y) * tmpvar_66) / (Cb_4.x - Cb_4.y));
              tmpvar_97 = tmpvar_66;
            } else {
              tmpvar_96 = 0.0;
              tmpvar_97 = 0.0;
            };
            tmpvar_95 = 0.0;
            tmpvar_92 = tmpvar_95;
            tmpvar_93 = tmpvar_96;
            tmpvar_94 = tmpvar_97;
            tmpvar_67.y = 0.0;
            tmpvar_67.z = tmpvar_96;
            tmpvar_67.x = tmpvar_97;
          } else {
            float tmpvar_98;
            tmpvar_98 = tmpvar_65.z;
            float tmpvar_99;
            tmpvar_99 = tmpvar_65.y;
            float tmpvar_100;
            tmpvar_100 = tmpvar_65.x;
            highp float tmpvar_101;
            tmpvar_101 = tmpvar_98;
            highp float tmpvar_102;
            tmpvar_102 = tmpvar_99;
            highp float tmpvar_103;
            tmpvar_103 = tmpvar_100;
            if ((Cb_4.z < Cb_4.x)) {
              tmpvar_102 = (((Cb_4.y - Cb_4.z) * tmpvar_66) / (Cb_4.x - Cb_4.z));
              tmpvar_103 = tmpvar_66;
            } else {
              tmpvar_102 = 0.0;
              tmpvar_103 = 0.0;
            };
            tmpvar_101 = 0.0;
            tmpvar_98 = tmpvar_101;
            tmpvar_99 = tmpvar_102;
            tmpvar_100 = tmpvar_103;
            tmpvar_67.z = 0.0;
            tmpvar_67.y = tmpvar_102;
            tmpvar_67.x = tmpvar_103;
          };
        };
      };
      highp vec3 tmpvar_104;
      tmpvar_104 = (tmpvar_67 + (dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (tmpvar_67, vec3(0.3, 0.59, 0.11))));
      float tmpvar_105;
      tmpvar_105 = dot (tmpvar_104, vec3(0.3, 0.59, 0.11));
      float tmpvar_106;
      tmpvar_106 = min (tmpvar_104.x, min (tmpvar_104.y, tmpvar_104.z));
      float tmpvar_107;
      tmpvar_107 = max (tmpvar_104.x, max (tmpvar_104.y, tmpvar_104.z));
      if ((tmpvar_106 < 0.0)) {
        tmpvar_104 = (tmpvar_105 + ((
          (tmpvar_104 - tmpvar_105)
         * tmpvar_105) / (tmpvar_105 - tmpvar_106)));
      };
      if ((1.0 < tmpvar_107)) {
        tmpvar_104 = (tmpvar_105 + ((
          (tmpvar_104 - tmpvar_105)
         * 
          (1.0 - tmpvar_105)
        ) / (tmpvar_107 - tmpvar_105)));
      };
      result_2.xyz = tmpvar_104;
      break;
    };
    tmpvar_7 = (tmpvar_7 || (14 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      highp vec3 tmpvar_108;
      tmpvar_108 = (Cs_3.xyz + (dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cs_3.xyz, vec3(0.3, 0.59, 0.11))));
      float tmpvar_109;
      tmpvar_109 = dot (tmpvar_108, vec3(0.3, 0.59, 0.11));
      float tmpvar_110;
      tmpvar_110 = min (tmpvar_108.x, min (tmpvar_108.y, tmpvar_108.z));
      float tmpvar_111;
      tmpvar_111 = max (tmpvar_108.x, max (tmpvar_108.y, tmpvar_108.z));
      if ((tmpvar_110 < 0.0)) {
        tmpvar_108 = (tmpvar_109 + ((
          (tmpvar_108 - tmpvar_109)
         * tmpvar_109) / (tmpvar_109 - tmpvar_110)));
      };
      if ((1.0 < tmpvar_111)) {
        tmpvar_108 = (tmpvar_109 + ((
          (tmpvar_108 - tmpvar_109)
         * 
          (1.0 - tmpvar_109)
        ) / (tmpvar_111 - tmpvar_109)));
      };
      result_2.xyz = tmpvar_108;
      break;
    };
    tmpvar_7 = (tmpvar_7 || (15 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      highp vec3 tmpvar_112;
      tmpvar_112 = (Cb_4.xyz + (dot (Cs_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11))));
      float tmpvar_113;
      tmpvar_113 = dot (tmpvar_112, vec3(0.3, 0.59, 0.11));
      float tmpvar_114;
      tmpvar_114 = min (tmpvar_112.x, min (tmpvar_112.y, tmpvar_112.z));
      float tmpvar_115;
      tmpvar_115 = max (tmpvar_112.x, max (tmpvar_112.y, tmpvar_112.z));
      if ((tmpvar_114 < 0.0)) {
        tmpvar_112 = (tmpvar_113 + ((
          (tmpvar_112 - tmpvar_113)
         * tmpvar_113) / (tmpvar_113 - tmpvar_114)));
      };
      if ((1.0 < tmpvar_115)) {
        tmpvar_112 = (tmpvar_113 + ((
          (tmpvar_112 - tmpvar_113)
         * 
          (1.0 - tmpvar_113)
        ) / (tmpvar_115 - tmpvar_113)));
      };
      result_2.xyz = tmpvar_112;
      break;
    };
    tmpvar_7 = bool(1);
    break;
  };
  result_2.xyz = (((1.0 - tmpvar_5.w) * Cs_3.xyz) + (tmpvar_5.w * result_2.xyz));
  result_2.w = Cs_3.w;
  result_2.xyz = (result_2.xyz * tmpvar_6.w);
  frag_color_1 = result_2;
  float tmpvar_116;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_116 = 1.0;
  } else {
    vec2 tmpvar_117;
    tmpvar_117 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec4 tmpvar_118;
    tmpvar_118.xy = greaterThanEqual (tmpvar_117, vClipMaskUvBounds.xy);
    tmpvar_118.zw = lessThan (tmpvar_117, vClipMaskUvBounds.zw);
    bool tmpvar_119;
    tmpvar_119 = (tmpvar_118 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_119)) {
      tmpvar_116 = 0.0;
    } else {
      ivec3 tmpvar_120;
      tmpvar_120.xy = ivec2(tmpvar_117);
      tmpvar_120.z = int((vClipMaskUv.z + 0.5));
      tmpvar_116 = texelFetch (sPrevPassAlpha, tmpvar_120, 0).x;
    };
  };
  frag_color_1 = (result_2 * tmpvar_116);
  oFragColor = frag_color_1;
}

