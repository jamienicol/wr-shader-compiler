#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform highp sampler2DArray sPrevPassColor;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_0;
in highp vec4 varying_vec4_1;
void main ()
{
  highp vec4 result_1;
  highp vec4 Cs_2;
  highp vec4 Cb_3;
  vec4 tmpvar_4;
  tmpvar_4 = textureLod (sPrevPassColor, varying_vec4_1.xyw, 0.0);
  Cb_3 = tmpvar_4;
  vec4 tmpvar_5;
  tmpvar_5 = textureLod (sPrevPassColor, varying_vec4_0.xyw, 0.0);
  Cs_2 = tmpvar_5;
  if ((tmpvar_4.w != 0.0)) {
    Cb_3.xyz = (tmpvar_4.xyz / tmpvar_4.w);
  };
  if ((tmpvar_5.w != 0.0)) {
    Cs_2.xyz = (tmpvar_5.xyz / tmpvar_5.w);
  };
  result_1 = vec4(1.0, 1.0, 0.0, 1.0);
  bool tmpvar_6;
  tmpvar_6 = bool(0);
  while (true) {
    tmpvar_6 = (tmpvar_6 || (1 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      result_1.xyz = (Cb_3.xyz * Cs_2.xyz);
      break;
    };
    tmpvar_6 = (tmpvar_6 || (2 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      result_1.xyz = ((Cb_3.xyz + Cs_2.xyz) - (Cb_3.xyz * Cs_2.xyz));
      break;
    };
    tmpvar_6 = (tmpvar_6 || (3 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      highp vec3 tmpvar_7;
      tmpvar_7 = ((2.0 * Cb_3.xyz) - 1.0);
      result_1.xyz = mix ((Cs_2.xyz * (2.0 * Cb_3.xyz)), ((Cs_2.xyz + tmpvar_7) - (Cs_2.xyz * tmpvar_7)), vec3(greaterThanEqual (Cb_3.xyz, vec3(0.5, 0.5, 0.5))));
      break;
    };
    tmpvar_6 = (tmpvar_6 || (4 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      result_1.xyz = min (Cs_2.xyz, Cb_3.xyz);
      break;
    };
    tmpvar_6 = (tmpvar_6 || (5 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      result_1.xyz = max (Cs_2.xyz, Cb_3.xyz);
      break;
    };
    tmpvar_6 = (tmpvar_6 || (6 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      float tmpvar_8;
      if ((Cb_3.x == 0.0)) {
        tmpvar_8 = 0.0;
      } else {
        if ((Cs_2.x == 1.0)) {
          tmpvar_8 = 1.0;
        } else {
          tmpvar_8 = min (1.0, (Cb_3.x / (1.0 - Cs_2.x)));
        };
      };
      result_1.x = tmpvar_8;
      float tmpvar_9;
      if ((Cb_3.y == 0.0)) {
        tmpvar_9 = 0.0;
      } else {
        if ((Cs_2.y == 1.0)) {
          tmpvar_9 = 1.0;
        } else {
          tmpvar_9 = min (1.0, (Cb_3.y / (1.0 - Cs_2.y)));
        };
      };
      result_1.y = tmpvar_9;
      float tmpvar_10;
      if ((Cb_3.z == 0.0)) {
        tmpvar_10 = 0.0;
      } else {
        if ((Cs_2.z == 1.0)) {
          tmpvar_10 = 1.0;
        } else {
          tmpvar_10 = min (1.0, (Cb_3.z / (1.0 - Cs_2.z)));
        };
      };
      result_1.z = tmpvar_10;
      break;
    };
    tmpvar_6 = (tmpvar_6 || (7 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      float tmpvar_11;
      if ((Cb_3.x == 1.0)) {
        tmpvar_11 = 1.0;
      } else {
        if ((Cs_2.x == 0.0)) {
          tmpvar_11 = 0.0;
        } else {
          tmpvar_11 = (1.0 - min (1.0, (
            (1.0 - Cb_3.x)
           / Cs_2.x)));
        };
      };
      result_1.x = tmpvar_11;
      float tmpvar_12;
      if ((Cb_3.y == 1.0)) {
        tmpvar_12 = 1.0;
      } else {
        if ((Cs_2.y == 0.0)) {
          tmpvar_12 = 0.0;
        } else {
          tmpvar_12 = (1.0 - min (1.0, (
            (1.0 - Cb_3.y)
           / Cs_2.y)));
        };
      };
      result_1.y = tmpvar_12;
      float tmpvar_13;
      if ((Cb_3.z == 1.0)) {
        tmpvar_13 = 1.0;
      } else {
        if ((Cs_2.z == 0.0)) {
          tmpvar_13 = 0.0;
        } else {
          tmpvar_13 = (1.0 - min (1.0, (
            (1.0 - Cb_3.z)
           / Cs_2.z)));
        };
      };
      result_1.z = tmpvar_13;
      break;
    };
    tmpvar_6 = (tmpvar_6 || (8 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      highp vec3 tmpvar_14;
      tmpvar_14 = ((2.0 * Cs_2.xyz) - 1.0);
      result_1.xyz = mix ((Cb_3.xyz * (2.0 * Cs_2.xyz)), ((Cb_3.xyz + tmpvar_14) - (Cb_3.xyz * tmpvar_14)), vec3(greaterThanEqual (Cs_2.xyz, vec3(0.5, 0.5, 0.5))));
      break;
    };
    tmpvar_6 = (tmpvar_6 || (9 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      float tmpvar_15;
      if ((0.5 >= Cs_2.x)) {
        tmpvar_15 = (Cb_3.x - ((
          (1.0 - (2.0 * Cs_2.x))
         * Cb_3.x) * (1.0 - Cb_3.x)));
      } else {
        highp float D_16;
        if ((0.25 >= Cb_3.x)) {
          D_16 = (((
            ((16.0 * Cb_3.x) - 12.0)
           * Cb_3.x) + 4.0) * Cb_3.x);
        } else {
          D_16 = sqrt(Cb_3.x);
        };
        tmpvar_15 = (Cb_3.x + ((
          (2.0 * Cs_2.x)
         - 1.0) * (D_16 - Cb_3.x)));
      };
      result_1.x = tmpvar_15;
      float tmpvar_17;
      if ((0.5 >= Cs_2.y)) {
        tmpvar_17 = (Cb_3.y - ((
          (1.0 - (2.0 * Cs_2.y))
         * Cb_3.y) * (1.0 - Cb_3.y)));
      } else {
        highp float D_18;
        if ((0.25 >= Cb_3.y)) {
          D_18 = (((
            ((16.0 * Cb_3.y) - 12.0)
           * Cb_3.y) + 4.0) * Cb_3.y);
        } else {
          D_18 = sqrt(Cb_3.y);
        };
        tmpvar_17 = (Cb_3.y + ((
          (2.0 * Cs_2.y)
         - 1.0) * (D_18 - Cb_3.y)));
      };
      result_1.y = tmpvar_17;
      float tmpvar_19;
      if ((0.5 >= Cs_2.z)) {
        tmpvar_19 = (Cb_3.z - ((
          (1.0 - (2.0 * Cs_2.z))
         * Cb_3.z) * (1.0 - Cb_3.z)));
      } else {
        highp float D_20;
        if ((0.25 >= Cb_3.z)) {
          D_20 = (((
            ((16.0 * Cb_3.z) - 12.0)
           * Cb_3.z) + 4.0) * Cb_3.z);
        } else {
          D_20 = sqrt(Cb_3.z);
        };
        tmpvar_19 = (Cb_3.z + ((
          (2.0 * Cs_2.z)
         - 1.0) * (D_20 - Cb_3.z)));
      };
      result_1.z = tmpvar_19;
      break;
    };
    tmpvar_6 = (tmpvar_6 || (10 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      result_1.xyz = abs((Cb_3.xyz - Cs_2.xyz));
      break;
    };
    tmpvar_6 = (tmpvar_6 || (11 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      result_1.xyz = ((Cb_3.xyz + Cs_2.xyz) - ((2.0 * Cb_3.xyz) * Cs_2.xyz));
      break;
    };
    tmpvar_6 = (tmpvar_6 || (12 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      highp vec3 tmpvar_21;
      tmpvar_21 = Cs_2.xyz;
      float tmpvar_22;
      tmpvar_22 = (max (Cb_3.x, max (Cb_3.y, Cb_3.z)) - min (Cb_3.x, min (Cb_3.y, Cb_3.z)));
      highp vec3 tmpvar_23;
      tmpvar_23 = tmpvar_21;
      if ((Cs_2.y >= Cs_2.x)) {
        if ((Cs_2.z >= Cs_2.y)) {
          float tmpvar_24;
          tmpvar_24 = tmpvar_21.x;
          float tmpvar_25;
          tmpvar_25 = tmpvar_21.y;
          float tmpvar_26;
          tmpvar_26 = tmpvar_21.z;
          highp float tmpvar_27;
          tmpvar_27 = tmpvar_24;
          highp float tmpvar_28;
          tmpvar_28 = tmpvar_25;
          highp float tmpvar_29;
          tmpvar_29 = tmpvar_26;
          if ((Cs_2.x < Cs_2.z)) {
            tmpvar_28 = (((Cs_2.y - Cs_2.x) * tmpvar_22) / (Cs_2.z - Cs_2.x));
            tmpvar_29 = tmpvar_22;
          } else {
            tmpvar_28 = 0.0;
            tmpvar_29 = 0.0;
          };
          tmpvar_27 = 0.0;
          tmpvar_24 = tmpvar_27;
          tmpvar_25 = tmpvar_28;
          tmpvar_26 = tmpvar_29;
          tmpvar_23.x = 0.0;
          tmpvar_23.y = tmpvar_28;
          tmpvar_23.z = tmpvar_29;
        } else {
          if ((Cs_2.z >= Cs_2.x)) {
            float tmpvar_30;
            tmpvar_30 = tmpvar_21.x;
            float tmpvar_31;
            tmpvar_31 = tmpvar_21.z;
            float tmpvar_32;
            tmpvar_32 = tmpvar_21.y;
            highp float tmpvar_33;
            tmpvar_33 = tmpvar_30;
            highp float tmpvar_34;
            tmpvar_34 = tmpvar_31;
            highp float tmpvar_35;
            tmpvar_35 = tmpvar_32;
            if ((Cs_2.x < Cs_2.y)) {
              tmpvar_34 = (((Cs_2.z - Cs_2.x) * tmpvar_22) / (Cs_2.y - Cs_2.x));
              tmpvar_35 = tmpvar_22;
            } else {
              tmpvar_34 = 0.0;
              tmpvar_35 = 0.0;
            };
            tmpvar_33 = 0.0;
            tmpvar_30 = tmpvar_33;
            tmpvar_31 = tmpvar_34;
            tmpvar_32 = tmpvar_35;
            tmpvar_23.x = 0.0;
            tmpvar_23.z = tmpvar_34;
            tmpvar_23.y = tmpvar_35;
          } else {
            float tmpvar_36;
            tmpvar_36 = tmpvar_21.z;
            float tmpvar_37;
            tmpvar_37 = tmpvar_21.x;
            float tmpvar_38;
            tmpvar_38 = tmpvar_21.y;
            highp float tmpvar_39;
            tmpvar_39 = tmpvar_36;
            highp float tmpvar_40;
            tmpvar_40 = tmpvar_37;
            highp float tmpvar_41;
            tmpvar_41 = tmpvar_38;
            if ((Cs_2.z < Cs_2.y)) {
              tmpvar_40 = (((Cs_2.x - Cs_2.z) * tmpvar_22) / (Cs_2.y - Cs_2.z));
              tmpvar_41 = tmpvar_22;
            } else {
              tmpvar_40 = 0.0;
              tmpvar_41 = 0.0;
            };
            tmpvar_39 = 0.0;
            tmpvar_36 = tmpvar_39;
            tmpvar_37 = tmpvar_40;
            tmpvar_38 = tmpvar_41;
            tmpvar_23.z = 0.0;
            tmpvar_23.x = tmpvar_40;
            tmpvar_23.y = tmpvar_41;
          };
        };
      } else {
        if ((Cs_2.z >= Cs_2.x)) {
          float tmpvar_42;
          tmpvar_42 = tmpvar_21.y;
          float tmpvar_43;
          tmpvar_43 = tmpvar_21.x;
          float tmpvar_44;
          tmpvar_44 = tmpvar_21.z;
          highp float tmpvar_45;
          tmpvar_45 = tmpvar_42;
          highp float tmpvar_46;
          tmpvar_46 = tmpvar_43;
          highp float tmpvar_47;
          tmpvar_47 = tmpvar_44;
          if ((Cs_2.y < Cs_2.z)) {
            tmpvar_46 = (((Cs_2.x - Cs_2.y) * tmpvar_22) / (Cs_2.z - Cs_2.y));
            tmpvar_47 = tmpvar_22;
          } else {
            tmpvar_46 = 0.0;
            tmpvar_47 = 0.0;
          };
          tmpvar_45 = 0.0;
          tmpvar_42 = tmpvar_45;
          tmpvar_43 = tmpvar_46;
          tmpvar_44 = tmpvar_47;
          tmpvar_23.y = 0.0;
          tmpvar_23.x = tmpvar_46;
          tmpvar_23.z = tmpvar_47;
        } else {
          if ((Cs_2.z >= Cs_2.y)) {
            float tmpvar_48;
            tmpvar_48 = tmpvar_21.y;
            float tmpvar_49;
            tmpvar_49 = tmpvar_21.z;
            float tmpvar_50;
            tmpvar_50 = tmpvar_21.x;
            highp float tmpvar_51;
            tmpvar_51 = tmpvar_48;
            highp float tmpvar_52;
            tmpvar_52 = tmpvar_49;
            highp float tmpvar_53;
            tmpvar_53 = tmpvar_50;
            if ((Cs_2.y < Cs_2.x)) {
              tmpvar_52 = (((Cs_2.z - Cs_2.y) * tmpvar_22) / (Cs_2.x - Cs_2.y));
              tmpvar_53 = tmpvar_22;
            } else {
              tmpvar_52 = 0.0;
              tmpvar_53 = 0.0;
            };
            tmpvar_51 = 0.0;
            tmpvar_48 = tmpvar_51;
            tmpvar_49 = tmpvar_52;
            tmpvar_50 = tmpvar_53;
            tmpvar_23.y = 0.0;
            tmpvar_23.z = tmpvar_52;
            tmpvar_23.x = tmpvar_53;
          } else {
            float tmpvar_54;
            tmpvar_54 = tmpvar_21.z;
            float tmpvar_55;
            tmpvar_55 = tmpvar_21.y;
            float tmpvar_56;
            tmpvar_56 = tmpvar_21.x;
            highp float tmpvar_57;
            tmpvar_57 = tmpvar_54;
            highp float tmpvar_58;
            tmpvar_58 = tmpvar_55;
            highp float tmpvar_59;
            tmpvar_59 = tmpvar_56;
            if ((Cs_2.z < Cs_2.x)) {
              tmpvar_58 = (((Cs_2.y - Cs_2.z) * tmpvar_22) / (Cs_2.x - Cs_2.z));
              tmpvar_59 = tmpvar_22;
            } else {
              tmpvar_58 = 0.0;
              tmpvar_59 = 0.0;
            };
            tmpvar_57 = 0.0;
            tmpvar_54 = tmpvar_57;
            tmpvar_55 = tmpvar_58;
            tmpvar_56 = tmpvar_59;
            tmpvar_23.z = 0.0;
            tmpvar_23.y = tmpvar_58;
            tmpvar_23.x = tmpvar_59;
          };
        };
      };
      highp vec3 tmpvar_60;
      tmpvar_60 = (tmpvar_23 + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (tmpvar_23, vec3(0.3, 0.59, 0.11))));
      float tmpvar_61;
      tmpvar_61 = dot (tmpvar_60, vec3(0.3, 0.59, 0.11));
      float tmpvar_62;
      tmpvar_62 = min (tmpvar_60.x, min (tmpvar_60.y, tmpvar_60.z));
      float tmpvar_63;
      tmpvar_63 = max (tmpvar_60.x, max (tmpvar_60.y, tmpvar_60.z));
      if ((tmpvar_62 < 0.0)) {
        tmpvar_60 = (tmpvar_61 + ((
          (tmpvar_60 - tmpvar_61)
         * tmpvar_61) / (tmpvar_61 - tmpvar_62)));
      };
      if ((1.0 < tmpvar_63)) {
        tmpvar_60 = (tmpvar_61 + ((
          (tmpvar_60 - tmpvar_61)
         * 
          (1.0 - tmpvar_61)
        ) / (tmpvar_63 - tmpvar_61)));
      };
      result_1.xyz = tmpvar_60;
      break;
    };
    tmpvar_6 = (tmpvar_6 || (13 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      highp vec3 tmpvar_64;
      tmpvar_64 = Cb_3.xyz;
      float tmpvar_65;
      tmpvar_65 = (max (Cs_2.x, max (Cs_2.y, Cs_2.z)) - min (Cs_2.x, min (Cs_2.y, Cs_2.z)));
      highp vec3 tmpvar_66;
      tmpvar_66 = tmpvar_64;
      if ((Cb_3.y >= Cb_3.x)) {
        if ((Cb_3.z >= Cb_3.y)) {
          float tmpvar_67;
          tmpvar_67 = tmpvar_64.x;
          float tmpvar_68;
          tmpvar_68 = tmpvar_64.y;
          float tmpvar_69;
          tmpvar_69 = tmpvar_64.z;
          highp float tmpvar_70;
          tmpvar_70 = tmpvar_67;
          highp float tmpvar_71;
          tmpvar_71 = tmpvar_68;
          highp float tmpvar_72;
          tmpvar_72 = tmpvar_69;
          if ((Cb_3.x < Cb_3.z)) {
            tmpvar_71 = (((Cb_3.y - Cb_3.x) * tmpvar_65) / (Cb_3.z - Cb_3.x));
            tmpvar_72 = tmpvar_65;
          } else {
            tmpvar_71 = 0.0;
            tmpvar_72 = 0.0;
          };
          tmpvar_70 = 0.0;
          tmpvar_67 = tmpvar_70;
          tmpvar_68 = tmpvar_71;
          tmpvar_69 = tmpvar_72;
          tmpvar_66.x = 0.0;
          tmpvar_66.y = tmpvar_71;
          tmpvar_66.z = tmpvar_72;
        } else {
          if ((Cb_3.z >= Cb_3.x)) {
            float tmpvar_73;
            tmpvar_73 = tmpvar_64.x;
            float tmpvar_74;
            tmpvar_74 = tmpvar_64.z;
            float tmpvar_75;
            tmpvar_75 = tmpvar_64.y;
            highp float tmpvar_76;
            tmpvar_76 = tmpvar_73;
            highp float tmpvar_77;
            tmpvar_77 = tmpvar_74;
            highp float tmpvar_78;
            tmpvar_78 = tmpvar_75;
            if ((Cb_3.x < Cb_3.y)) {
              tmpvar_77 = (((Cb_3.z - Cb_3.x) * tmpvar_65) / (Cb_3.y - Cb_3.x));
              tmpvar_78 = tmpvar_65;
            } else {
              tmpvar_77 = 0.0;
              tmpvar_78 = 0.0;
            };
            tmpvar_76 = 0.0;
            tmpvar_73 = tmpvar_76;
            tmpvar_74 = tmpvar_77;
            tmpvar_75 = tmpvar_78;
            tmpvar_66.x = 0.0;
            tmpvar_66.z = tmpvar_77;
            tmpvar_66.y = tmpvar_78;
          } else {
            float tmpvar_79;
            tmpvar_79 = tmpvar_64.z;
            float tmpvar_80;
            tmpvar_80 = tmpvar_64.x;
            float tmpvar_81;
            tmpvar_81 = tmpvar_64.y;
            highp float tmpvar_82;
            tmpvar_82 = tmpvar_79;
            highp float tmpvar_83;
            tmpvar_83 = tmpvar_80;
            highp float tmpvar_84;
            tmpvar_84 = tmpvar_81;
            if ((Cb_3.z < Cb_3.y)) {
              tmpvar_83 = (((Cb_3.x - Cb_3.z) * tmpvar_65) / (Cb_3.y - Cb_3.z));
              tmpvar_84 = tmpvar_65;
            } else {
              tmpvar_83 = 0.0;
              tmpvar_84 = 0.0;
            };
            tmpvar_82 = 0.0;
            tmpvar_79 = tmpvar_82;
            tmpvar_80 = tmpvar_83;
            tmpvar_81 = tmpvar_84;
            tmpvar_66.z = 0.0;
            tmpvar_66.x = tmpvar_83;
            tmpvar_66.y = tmpvar_84;
          };
        };
      } else {
        if ((Cb_3.z >= Cb_3.x)) {
          float tmpvar_85;
          tmpvar_85 = tmpvar_64.y;
          float tmpvar_86;
          tmpvar_86 = tmpvar_64.x;
          float tmpvar_87;
          tmpvar_87 = tmpvar_64.z;
          highp float tmpvar_88;
          tmpvar_88 = tmpvar_85;
          highp float tmpvar_89;
          tmpvar_89 = tmpvar_86;
          highp float tmpvar_90;
          tmpvar_90 = tmpvar_87;
          if ((Cb_3.y < Cb_3.z)) {
            tmpvar_89 = (((Cb_3.x - Cb_3.y) * tmpvar_65) / (Cb_3.z - Cb_3.y));
            tmpvar_90 = tmpvar_65;
          } else {
            tmpvar_89 = 0.0;
            tmpvar_90 = 0.0;
          };
          tmpvar_88 = 0.0;
          tmpvar_85 = tmpvar_88;
          tmpvar_86 = tmpvar_89;
          tmpvar_87 = tmpvar_90;
          tmpvar_66.y = 0.0;
          tmpvar_66.x = tmpvar_89;
          tmpvar_66.z = tmpvar_90;
        } else {
          if ((Cb_3.z >= Cb_3.y)) {
            float tmpvar_91;
            tmpvar_91 = tmpvar_64.y;
            float tmpvar_92;
            tmpvar_92 = tmpvar_64.z;
            float tmpvar_93;
            tmpvar_93 = tmpvar_64.x;
            highp float tmpvar_94;
            tmpvar_94 = tmpvar_91;
            highp float tmpvar_95;
            tmpvar_95 = tmpvar_92;
            highp float tmpvar_96;
            tmpvar_96 = tmpvar_93;
            if ((Cb_3.y < Cb_3.x)) {
              tmpvar_95 = (((Cb_3.z - Cb_3.y) * tmpvar_65) / (Cb_3.x - Cb_3.y));
              tmpvar_96 = tmpvar_65;
            } else {
              tmpvar_95 = 0.0;
              tmpvar_96 = 0.0;
            };
            tmpvar_94 = 0.0;
            tmpvar_91 = tmpvar_94;
            tmpvar_92 = tmpvar_95;
            tmpvar_93 = tmpvar_96;
            tmpvar_66.y = 0.0;
            tmpvar_66.z = tmpvar_95;
            tmpvar_66.x = tmpvar_96;
          } else {
            float tmpvar_97;
            tmpvar_97 = tmpvar_64.z;
            float tmpvar_98;
            tmpvar_98 = tmpvar_64.y;
            float tmpvar_99;
            tmpvar_99 = tmpvar_64.x;
            highp float tmpvar_100;
            tmpvar_100 = tmpvar_97;
            highp float tmpvar_101;
            tmpvar_101 = tmpvar_98;
            highp float tmpvar_102;
            tmpvar_102 = tmpvar_99;
            if ((Cb_3.z < Cb_3.x)) {
              tmpvar_101 = (((Cb_3.y - Cb_3.z) * tmpvar_65) / (Cb_3.x - Cb_3.z));
              tmpvar_102 = tmpvar_65;
            } else {
              tmpvar_101 = 0.0;
              tmpvar_102 = 0.0;
            };
            tmpvar_100 = 0.0;
            tmpvar_97 = tmpvar_100;
            tmpvar_98 = tmpvar_101;
            tmpvar_99 = tmpvar_102;
            tmpvar_66.z = 0.0;
            tmpvar_66.y = tmpvar_101;
            tmpvar_66.x = tmpvar_102;
          };
        };
      };
      highp vec3 tmpvar_103;
      tmpvar_103 = (tmpvar_66 + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (tmpvar_66, vec3(0.3, 0.59, 0.11))));
      float tmpvar_104;
      tmpvar_104 = dot (tmpvar_103, vec3(0.3, 0.59, 0.11));
      float tmpvar_105;
      tmpvar_105 = min (tmpvar_103.x, min (tmpvar_103.y, tmpvar_103.z));
      float tmpvar_106;
      tmpvar_106 = max (tmpvar_103.x, max (tmpvar_103.y, tmpvar_103.z));
      if ((tmpvar_105 < 0.0)) {
        tmpvar_103 = (tmpvar_104 + ((
          (tmpvar_103 - tmpvar_104)
         * tmpvar_104) / (tmpvar_104 - tmpvar_105)));
      };
      if ((1.0 < tmpvar_106)) {
        tmpvar_103 = (tmpvar_104 + ((
          (tmpvar_103 - tmpvar_104)
         * 
          (1.0 - tmpvar_104)
        ) / (tmpvar_106 - tmpvar_104)));
      };
      result_1.xyz = tmpvar_103;
      break;
    };
    tmpvar_6 = (tmpvar_6 || (14 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      highp vec3 tmpvar_107;
      tmpvar_107 = (Cs_2.xyz + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cs_2.xyz, vec3(0.3, 0.59, 0.11))));
      float tmpvar_108;
      tmpvar_108 = dot (tmpvar_107, vec3(0.3, 0.59, 0.11));
      float tmpvar_109;
      tmpvar_109 = min (tmpvar_107.x, min (tmpvar_107.y, tmpvar_107.z));
      float tmpvar_110;
      tmpvar_110 = max (tmpvar_107.x, max (tmpvar_107.y, tmpvar_107.z));
      if ((tmpvar_109 < 0.0)) {
        tmpvar_107 = (tmpvar_108 + ((
          (tmpvar_107 - tmpvar_108)
         * tmpvar_108) / (tmpvar_108 - tmpvar_109)));
      };
      if ((1.0 < tmpvar_110)) {
        tmpvar_107 = (tmpvar_108 + ((
          (tmpvar_107 - tmpvar_108)
         * 
          (1.0 - tmpvar_108)
        ) / (tmpvar_110 - tmpvar_108)));
      };
      result_1.xyz = tmpvar_107;
      break;
    };
    tmpvar_6 = (tmpvar_6 || (15 == flat_varying_ivec4_0.x));
    if (tmpvar_6) {
      highp vec3 tmpvar_111;
      tmpvar_111 = (Cb_3.xyz + (dot (Cs_2.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11))));
      float tmpvar_112;
      tmpvar_112 = dot (tmpvar_111, vec3(0.3, 0.59, 0.11));
      float tmpvar_113;
      tmpvar_113 = min (tmpvar_111.x, min (tmpvar_111.y, tmpvar_111.z));
      float tmpvar_114;
      tmpvar_114 = max (tmpvar_111.x, max (tmpvar_111.y, tmpvar_111.z));
      if ((tmpvar_113 < 0.0)) {
        tmpvar_111 = (tmpvar_112 + ((
          (tmpvar_111 - tmpvar_112)
         * tmpvar_112) / (tmpvar_112 - tmpvar_113)));
      };
      if ((1.0 < tmpvar_114)) {
        tmpvar_111 = (tmpvar_112 + ((
          (tmpvar_111 - tmpvar_112)
         * 
          (1.0 - tmpvar_112)
        ) / (tmpvar_114 - tmpvar_112)));
      };
      result_1.xyz = tmpvar_111;
      break;
    };
    tmpvar_6 = bool(1);
    break;
  };
  result_1.xyz = (((1.0 - tmpvar_4.w) * Cs_2.xyz) + (tmpvar_4.w * result_1.xyz));
  result_1.w = Cs_2.w;
  result_1.xyz = (result_1.xyz * tmpvar_5.w);
  oFragColor = result_1;
}

