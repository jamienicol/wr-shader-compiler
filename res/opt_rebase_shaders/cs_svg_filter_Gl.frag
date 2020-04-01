#version 150
precision highp float;
out vec4 oFragColor;
uniform sampler2DArray sColor0;
uniform sampler2DArray sColor1;
uniform sampler2D sGpuCache;
in vec3 vInput1Uv;
in vec3 vInput2Uv;
flat in vec4 vInput1UvRect;
flat in vec4 vInput2UvRect;
flat in int vFilterInputCount;
flat in int vFilterKind;
flat in ivec4 vData;
flat in vec4 vFilterData0;
flat in vec4 vFilterData1;
flat in float vFloat0;
flat in mat4 vColorMat;
flat in int vFuncs[4];
void main ()
{
  bool needsPremul_1;
  vec4 result_2;
  vec4 Cb_3;
  vec4 Ca_4;
  Ca_4 = vec4(0.0, 0.0, 0.0, 0.0);
  Cb_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((0 < vFilterInputCount)) {
    vec3 tmpvar_5;
    tmpvar_5.xy = min (max (vInput1Uv.xy, vInput1UvRect.xy), vInput1UvRect.zw);
    tmpvar_5.z = vInput1Uv.z;
    vec4 tmpvar_6;
    tmpvar_6 = texture (sColor0, tmpvar_5, 0.0);
    Ca_4 = tmpvar_6;
    if ((tmpvar_6.w != 0.0)) {
      Ca_4.xyz = (tmpvar_6.xyz / tmpvar_6.w);
    };
  };
  if ((1 < vFilterInputCount)) {
    vec3 tmpvar_7;
    tmpvar_7.xy = min (max (vInput2Uv.xy, vInput2UvRect.xy), vInput2UvRect.zw);
    tmpvar_7.z = vInput2Uv.z;
    vec4 tmpvar_8;
    tmpvar_8 = texture (sColor1, tmpvar_7, 0.0);
    Cb_3 = tmpvar_8;
    if ((tmpvar_8.w != 0.0)) {
      Cb_3.xyz = (tmpvar_8.xyz / tmpvar_8.w);
    };
  };
  result_2 = vec4(1.0, 0.0, 0.0, 1.0);
  needsPremul_1 = bool(1);
  bool tmpvar_9;
  tmpvar_9 = bool(0);
  while (true) {
    tmpvar_9 = (tmpvar_9 || (0 == vFilterKind));
    if (tmpvar_9) {
      vec4 result_10;
      result_10 = vec4(1.0, 0.0, 0.0, 1.0);
      bool tmpvar_11;
      tmpvar_11 = bool(0);
      while (true) {
        tmpvar_11 = (tmpvar_11 || (0 == vData.x));
        if (tmpvar_11) {
          result_10.xyz = Ca_4.xyz;
          break;
        };
        tmpvar_11 = (tmpvar_11 || (1 == vData.x));
        if (tmpvar_11) {
          result_10.xyz = (Cb_3.xyz * Ca_4.xyz);
          break;
        };
        tmpvar_11 = (tmpvar_11 || (2 == vData.x));
        if (tmpvar_11) {
          result_10.xyz = ((Cb_3.xyz + Ca_4.xyz) - (Cb_3.xyz * Ca_4.xyz));
          break;
        };
        tmpvar_11 = (tmpvar_11 || (3 == vData.x));
        if (tmpvar_11) {
          vec3 tmpvar_12;
          tmpvar_12 = ((2.0 * Cb_3.xyz) - 1.0);
          result_10.xyz = mix ((Ca_4.xyz * (2.0 * Cb_3.xyz)), ((Ca_4.xyz + tmpvar_12) - (Ca_4.xyz * tmpvar_12)), vec3(greaterThanEqual (Cb_3.xyz, vec3(0.5, 0.5, 0.5))));
          break;
        };
        tmpvar_11 = (tmpvar_11 || (4 == vData.x));
        if (tmpvar_11) {
          result_10.xyz = min (Ca_4.xyz, Cb_3.xyz);
          break;
        };
        tmpvar_11 = (tmpvar_11 || (5 == vData.x));
        if (tmpvar_11) {
          result_10.xyz = max (Ca_4.xyz, Cb_3.xyz);
          break;
        };
        tmpvar_11 = (tmpvar_11 || (6 == vData.x));
        if (tmpvar_11) {
          float tmpvar_13;
          if ((Cb_3.x == 0.0)) {
            tmpvar_13 = 0.0;
          } else {
            if ((Ca_4.x == 1.0)) {
              tmpvar_13 = 1.0;
            } else {
              tmpvar_13 = min (1.0, (Cb_3.x / (1.0 - Ca_4.x)));
            };
          };
          result_10.x = tmpvar_13;
          float tmpvar_14;
          if ((Cb_3.y == 0.0)) {
            tmpvar_14 = 0.0;
          } else {
            if ((Ca_4.y == 1.0)) {
              tmpvar_14 = 1.0;
            } else {
              tmpvar_14 = min (1.0, (Cb_3.y / (1.0 - Ca_4.y)));
            };
          };
          result_10.y = tmpvar_14;
          float tmpvar_15;
          if ((Cb_3.z == 0.0)) {
            tmpvar_15 = 0.0;
          } else {
            if ((Ca_4.z == 1.0)) {
              tmpvar_15 = 1.0;
            } else {
              tmpvar_15 = min (1.0, (Cb_3.z / (1.0 - Ca_4.z)));
            };
          };
          result_10.z = tmpvar_15;
          break;
        };
        tmpvar_11 = (tmpvar_11 || (7 == vData.x));
        if (tmpvar_11) {
          float tmpvar_16;
          if ((Cb_3.x == 1.0)) {
            tmpvar_16 = 1.0;
          } else {
            if ((Ca_4.x == 0.0)) {
              tmpvar_16 = 0.0;
            } else {
              tmpvar_16 = (1.0 - min (1.0, (
                (1.0 - Cb_3.x)
               / Ca_4.x)));
            };
          };
          result_10.x = tmpvar_16;
          float tmpvar_17;
          if ((Cb_3.y == 1.0)) {
            tmpvar_17 = 1.0;
          } else {
            if ((Ca_4.y == 0.0)) {
              tmpvar_17 = 0.0;
            } else {
              tmpvar_17 = (1.0 - min (1.0, (
                (1.0 - Cb_3.y)
               / Ca_4.y)));
            };
          };
          result_10.y = tmpvar_17;
          float tmpvar_18;
          if ((Cb_3.z == 1.0)) {
            tmpvar_18 = 1.0;
          } else {
            if ((Ca_4.z == 0.0)) {
              tmpvar_18 = 0.0;
            } else {
              tmpvar_18 = (1.0 - min (1.0, (
                (1.0 - Cb_3.z)
               / Ca_4.z)));
            };
          };
          result_10.z = tmpvar_18;
          break;
        };
        tmpvar_11 = (tmpvar_11 || (8 == vData.x));
        if (tmpvar_11) {
          vec3 tmpvar_19;
          tmpvar_19 = ((2.0 * Ca_4.xyz) - 1.0);
          result_10.xyz = mix ((Cb_3.xyz * (2.0 * Ca_4.xyz)), ((Cb_3.xyz + tmpvar_19) - (Cb_3.xyz * tmpvar_19)), vec3(greaterThanEqual (Ca_4.xyz, vec3(0.5, 0.5, 0.5))));
          break;
        };
        tmpvar_11 = (tmpvar_11 || (9 == vData.x));
        if (tmpvar_11) {
          float tmpvar_20;
          if ((0.5 >= Ca_4.x)) {
            tmpvar_20 = (Cb_3.x - ((
              (1.0 - (2.0 * Ca_4.x))
             * Cb_3.x) * (1.0 - Cb_3.x)));
          } else {
            float D_21;
            if ((0.25 >= Cb_3.x)) {
              D_21 = (((
                ((16.0 * Cb_3.x) - 12.0)
               * Cb_3.x) + 4.0) * Cb_3.x);
            } else {
              D_21 = sqrt(Cb_3.x);
            };
            tmpvar_20 = (Cb_3.x + ((
              (2.0 * Ca_4.x)
             - 1.0) * (D_21 - Cb_3.x)));
          };
          result_10.x = tmpvar_20;
          float tmpvar_22;
          if ((0.5 >= Ca_4.y)) {
            tmpvar_22 = (Cb_3.y - ((
              (1.0 - (2.0 * Ca_4.y))
             * Cb_3.y) * (1.0 - Cb_3.y)));
          } else {
            float D_23;
            if ((0.25 >= Cb_3.y)) {
              D_23 = (((
                ((16.0 * Cb_3.y) - 12.0)
               * Cb_3.y) + 4.0) * Cb_3.y);
            } else {
              D_23 = sqrt(Cb_3.y);
            };
            tmpvar_22 = (Cb_3.y + ((
              (2.0 * Ca_4.y)
             - 1.0) * (D_23 - Cb_3.y)));
          };
          result_10.y = tmpvar_22;
          float tmpvar_24;
          if ((0.5 >= Ca_4.z)) {
            tmpvar_24 = (Cb_3.z - ((
              (1.0 - (2.0 * Ca_4.z))
             * Cb_3.z) * (1.0 - Cb_3.z)));
          } else {
            float D_25;
            if ((0.25 >= Cb_3.z)) {
              D_25 = (((
                ((16.0 * Cb_3.z) - 12.0)
               * Cb_3.z) + 4.0) * Cb_3.z);
            } else {
              D_25 = sqrt(Cb_3.z);
            };
            tmpvar_24 = (Cb_3.z + ((
              (2.0 * Ca_4.z)
             - 1.0) * (D_25 - Cb_3.z)));
          };
          result_10.z = tmpvar_24;
          break;
        };
        tmpvar_11 = (tmpvar_11 || (10 == vData.x));
        if (tmpvar_11) {
          result_10.xyz = abs((Cb_3.xyz - Ca_4.xyz));
          break;
        };
        tmpvar_11 = (tmpvar_11 || (11 == vData.x));
        if (tmpvar_11) {
          result_10.xyz = ((Cb_3.xyz + Ca_4.xyz) - ((2.0 * Cb_3.xyz) * Ca_4.xyz));
          break;
        };
        tmpvar_11 = (tmpvar_11 || (12 == vData.x));
        if (tmpvar_11) {
          vec3 tmpvar_26;
          tmpvar_26 = Ca_4.xyz;
          float tmpvar_27;
          tmpvar_27 = (max (Cb_3.x, max (Cb_3.y, Cb_3.z)) - min (Cb_3.x, min (Cb_3.y, Cb_3.z)));
          vec3 tmpvar_28;
          tmpvar_28 = tmpvar_26;
          if ((Ca_4.y >= Ca_4.x)) {
            if ((Ca_4.z >= Ca_4.y)) {
              float tmpvar_29;
              tmpvar_29 = tmpvar_26.x;
              float tmpvar_30;
              tmpvar_30 = tmpvar_26.y;
              float tmpvar_31;
              tmpvar_31 = tmpvar_26.z;
              float tmpvar_32;
              tmpvar_32 = tmpvar_29;
              float tmpvar_33;
              tmpvar_33 = tmpvar_30;
              float tmpvar_34;
              tmpvar_34 = tmpvar_31;
              if ((Ca_4.x < Ca_4.z)) {
                tmpvar_33 = (((Ca_4.y - Ca_4.x) * tmpvar_27) / (Ca_4.z - Ca_4.x));
                tmpvar_34 = tmpvar_27;
              } else {
                tmpvar_33 = 0.0;
                tmpvar_34 = 0.0;
              };
              tmpvar_32 = 0.0;
              tmpvar_29 = tmpvar_32;
              tmpvar_30 = tmpvar_33;
              tmpvar_31 = tmpvar_34;
              tmpvar_28.x = 0.0;
              tmpvar_28.y = tmpvar_33;
              tmpvar_28.z = tmpvar_34;
            } else {
              if ((Ca_4.z >= Ca_4.x)) {
                float tmpvar_35;
                tmpvar_35 = tmpvar_26.x;
                float tmpvar_36;
                tmpvar_36 = tmpvar_26.z;
                float tmpvar_37;
                tmpvar_37 = tmpvar_26.y;
                float tmpvar_38;
                tmpvar_38 = tmpvar_35;
                float tmpvar_39;
                tmpvar_39 = tmpvar_36;
                float tmpvar_40;
                tmpvar_40 = tmpvar_37;
                if ((Ca_4.x < Ca_4.y)) {
                  tmpvar_39 = (((Ca_4.z - Ca_4.x) * tmpvar_27) / (Ca_4.y - Ca_4.x));
                  tmpvar_40 = tmpvar_27;
                } else {
                  tmpvar_39 = 0.0;
                  tmpvar_40 = 0.0;
                };
                tmpvar_38 = 0.0;
                tmpvar_35 = tmpvar_38;
                tmpvar_36 = tmpvar_39;
                tmpvar_37 = tmpvar_40;
                tmpvar_28.x = 0.0;
                tmpvar_28.z = tmpvar_39;
                tmpvar_28.y = tmpvar_40;
              } else {
                float tmpvar_41;
                tmpvar_41 = tmpvar_26.z;
                float tmpvar_42;
                tmpvar_42 = tmpvar_26.x;
                float tmpvar_43;
                tmpvar_43 = tmpvar_26.y;
                float tmpvar_44;
                tmpvar_44 = tmpvar_41;
                float tmpvar_45;
                tmpvar_45 = tmpvar_42;
                float tmpvar_46;
                tmpvar_46 = tmpvar_43;
                if ((Ca_4.z < Ca_4.y)) {
                  tmpvar_45 = (((Ca_4.x - Ca_4.z) * tmpvar_27) / (Ca_4.y - Ca_4.z));
                  tmpvar_46 = tmpvar_27;
                } else {
                  tmpvar_45 = 0.0;
                  tmpvar_46 = 0.0;
                };
                tmpvar_44 = 0.0;
                tmpvar_41 = tmpvar_44;
                tmpvar_42 = tmpvar_45;
                tmpvar_43 = tmpvar_46;
                tmpvar_28.z = 0.0;
                tmpvar_28.x = tmpvar_45;
                tmpvar_28.y = tmpvar_46;
              };
            };
          } else {
            if ((Ca_4.z >= Ca_4.x)) {
              float tmpvar_47;
              tmpvar_47 = tmpvar_26.y;
              float tmpvar_48;
              tmpvar_48 = tmpvar_26.x;
              float tmpvar_49;
              tmpvar_49 = tmpvar_26.z;
              float tmpvar_50;
              tmpvar_50 = tmpvar_47;
              float tmpvar_51;
              tmpvar_51 = tmpvar_48;
              float tmpvar_52;
              tmpvar_52 = tmpvar_49;
              if ((Ca_4.y < Ca_4.z)) {
                tmpvar_51 = (((Ca_4.x - Ca_4.y) * tmpvar_27) / (Ca_4.z - Ca_4.y));
                tmpvar_52 = tmpvar_27;
              } else {
                tmpvar_51 = 0.0;
                tmpvar_52 = 0.0;
              };
              tmpvar_50 = 0.0;
              tmpvar_47 = tmpvar_50;
              tmpvar_48 = tmpvar_51;
              tmpvar_49 = tmpvar_52;
              tmpvar_28.y = 0.0;
              tmpvar_28.x = tmpvar_51;
              tmpvar_28.z = tmpvar_52;
            } else {
              if ((Ca_4.z >= Ca_4.y)) {
                float tmpvar_53;
                tmpvar_53 = tmpvar_26.y;
                float tmpvar_54;
                tmpvar_54 = tmpvar_26.z;
                float tmpvar_55;
                tmpvar_55 = tmpvar_26.x;
                float tmpvar_56;
                tmpvar_56 = tmpvar_53;
                float tmpvar_57;
                tmpvar_57 = tmpvar_54;
                float tmpvar_58;
                tmpvar_58 = tmpvar_55;
                if ((Ca_4.y < Ca_4.x)) {
                  tmpvar_57 = (((Ca_4.z - Ca_4.y) * tmpvar_27) / (Ca_4.x - Ca_4.y));
                  tmpvar_58 = tmpvar_27;
                } else {
                  tmpvar_57 = 0.0;
                  tmpvar_58 = 0.0;
                };
                tmpvar_56 = 0.0;
                tmpvar_53 = tmpvar_56;
                tmpvar_54 = tmpvar_57;
                tmpvar_55 = tmpvar_58;
                tmpvar_28.y = 0.0;
                tmpvar_28.z = tmpvar_57;
                tmpvar_28.x = tmpvar_58;
              } else {
                float tmpvar_59;
                tmpvar_59 = tmpvar_26.z;
                float tmpvar_60;
                tmpvar_60 = tmpvar_26.y;
                float tmpvar_61;
                tmpvar_61 = tmpvar_26.x;
                float tmpvar_62;
                tmpvar_62 = tmpvar_59;
                float tmpvar_63;
                tmpvar_63 = tmpvar_60;
                float tmpvar_64;
                tmpvar_64 = tmpvar_61;
                if ((Ca_4.z < Ca_4.x)) {
                  tmpvar_63 = (((Ca_4.y - Ca_4.z) * tmpvar_27) / (Ca_4.x - Ca_4.z));
                  tmpvar_64 = tmpvar_27;
                } else {
                  tmpvar_63 = 0.0;
                  tmpvar_64 = 0.0;
                };
                tmpvar_62 = 0.0;
                tmpvar_59 = tmpvar_62;
                tmpvar_60 = tmpvar_63;
                tmpvar_61 = tmpvar_64;
                tmpvar_28.z = 0.0;
                tmpvar_28.y = tmpvar_63;
                tmpvar_28.x = tmpvar_64;
              };
            };
          };
          vec3 tmpvar_65;
          tmpvar_65 = (tmpvar_28 + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (tmpvar_28, vec3(0.3, 0.59, 0.11))));
          float tmpvar_66;
          tmpvar_66 = dot (tmpvar_65, vec3(0.3, 0.59, 0.11));
          float tmpvar_67;
          tmpvar_67 = min (tmpvar_65.x, min (tmpvar_65.y, tmpvar_65.z));
          float tmpvar_68;
          tmpvar_68 = max (tmpvar_65.x, max (tmpvar_65.y, tmpvar_65.z));
          if ((tmpvar_67 < 0.0)) {
            tmpvar_65 = (tmpvar_66 + ((
              (tmpvar_65 - tmpvar_66)
             * tmpvar_66) / (tmpvar_66 - tmpvar_67)));
          };
          if ((1.0 < tmpvar_68)) {
            tmpvar_65 = (tmpvar_66 + ((
              (tmpvar_65 - tmpvar_66)
             * 
              (1.0 - tmpvar_66)
            ) / (tmpvar_68 - tmpvar_66)));
          };
          result_10.xyz = tmpvar_65;
          break;
        };
        tmpvar_11 = (tmpvar_11 || (13 == vData.x));
        if (tmpvar_11) {
          vec3 tmpvar_69;
          tmpvar_69 = Cb_3.xyz;
          float tmpvar_70;
          tmpvar_70 = (max (Ca_4.x, max (Ca_4.y, Ca_4.z)) - min (Ca_4.x, min (Ca_4.y, Ca_4.z)));
          vec3 tmpvar_71;
          tmpvar_71 = tmpvar_69;
          if ((Cb_3.y >= Cb_3.x)) {
            if ((Cb_3.z >= Cb_3.y)) {
              float tmpvar_72;
              tmpvar_72 = tmpvar_69.x;
              float tmpvar_73;
              tmpvar_73 = tmpvar_69.y;
              float tmpvar_74;
              tmpvar_74 = tmpvar_69.z;
              float tmpvar_75;
              tmpvar_75 = tmpvar_72;
              float tmpvar_76;
              tmpvar_76 = tmpvar_73;
              float tmpvar_77;
              tmpvar_77 = tmpvar_74;
              if ((Cb_3.x < Cb_3.z)) {
                tmpvar_76 = (((Cb_3.y - Cb_3.x) * tmpvar_70) / (Cb_3.z - Cb_3.x));
                tmpvar_77 = tmpvar_70;
              } else {
                tmpvar_76 = 0.0;
                tmpvar_77 = 0.0;
              };
              tmpvar_75 = 0.0;
              tmpvar_72 = tmpvar_75;
              tmpvar_73 = tmpvar_76;
              tmpvar_74 = tmpvar_77;
              tmpvar_71.x = 0.0;
              tmpvar_71.y = tmpvar_76;
              tmpvar_71.z = tmpvar_77;
            } else {
              if ((Cb_3.z >= Cb_3.x)) {
                float tmpvar_78;
                tmpvar_78 = tmpvar_69.x;
                float tmpvar_79;
                tmpvar_79 = tmpvar_69.z;
                float tmpvar_80;
                tmpvar_80 = tmpvar_69.y;
                float tmpvar_81;
                tmpvar_81 = tmpvar_78;
                float tmpvar_82;
                tmpvar_82 = tmpvar_79;
                float tmpvar_83;
                tmpvar_83 = tmpvar_80;
                if ((Cb_3.x < Cb_3.y)) {
                  tmpvar_82 = (((Cb_3.z - Cb_3.x) * tmpvar_70) / (Cb_3.y - Cb_3.x));
                  tmpvar_83 = tmpvar_70;
                } else {
                  tmpvar_82 = 0.0;
                  tmpvar_83 = 0.0;
                };
                tmpvar_81 = 0.0;
                tmpvar_78 = tmpvar_81;
                tmpvar_79 = tmpvar_82;
                tmpvar_80 = tmpvar_83;
                tmpvar_71.x = 0.0;
                tmpvar_71.z = tmpvar_82;
                tmpvar_71.y = tmpvar_83;
              } else {
                float tmpvar_84;
                tmpvar_84 = tmpvar_69.z;
                float tmpvar_85;
                tmpvar_85 = tmpvar_69.x;
                float tmpvar_86;
                tmpvar_86 = tmpvar_69.y;
                float tmpvar_87;
                tmpvar_87 = tmpvar_84;
                float tmpvar_88;
                tmpvar_88 = tmpvar_85;
                float tmpvar_89;
                tmpvar_89 = tmpvar_86;
                if ((Cb_3.z < Cb_3.y)) {
                  tmpvar_88 = (((Cb_3.x - Cb_3.z) * tmpvar_70) / (Cb_3.y - Cb_3.z));
                  tmpvar_89 = tmpvar_70;
                } else {
                  tmpvar_88 = 0.0;
                  tmpvar_89 = 0.0;
                };
                tmpvar_87 = 0.0;
                tmpvar_84 = tmpvar_87;
                tmpvar_85 = tmpvar_88;
                tmpvar_86 = tmpvar_89;
                tmpvar_71.z = 0.0;
                tmpvar_71.x = tmpvar_88;
                tmpvar_71.y = tmpvar_89;
              };
            };
          } else {
            if ((Cb_3.z >= Cb_3.x)) {
              float tmpvar_90;
              tmpvar_90 = tmpvar_69.y;
              float tmpvar_91;
              tmpvar_91 = tmpvar_69.x;
              float tmpvar_92;
              tmpvar_92 = tmpvar_69.z;
              float tmpvar_93;
              tmpvar_93 = tmpvar_90;
              float tmpvar_94;
              tmpvar_94 = tmpvar_91;
              float tmpvar_95;
              tmpvar_95 = tmpvar_92;
              if ((Cb_3.y < Cb_3.z)) {
                tmpvar_94 = (((Cb_3.x - Cb_3.y) * tmpvar_70) / (Cb_3.z - Cb_3.y));
                tmpvar_95 = tmpvar_70;
              } else {
                tmpvar_94 = 0.0;
                tmpvar_95 = 0.0;
              };
              tmpvar_93 = 0.0;
              tmpvar_90 = tmpvar_93;
              tmpvar_91 = tmpvar_94;
              tmpvar_92 = tmpvar_95;
              tmpvar_71.y = 0.0;
              tmpvar_71.x = tmpvar_94;
              tmpvar_71.z = tmpvar_95;
            } else {
              if ((Cb_3.z >= Cb_3.y)) {
                float tmpvar_96;
                tmpvar_96 = tmpvar_69.y;
                float tmpvar_97;
                tmpvar_97 = tmpvar_69.z;
                float tmpvar_98;
                tmpvar_98 = tmpvar_69.x;
                float tmpvar_99;
                tmpvar_99 = tmpvar_96;
                float tmpvar_100;
                tmpvar_100 = tmpvar_97;
                float tmpvar_101;
                tmpvar_101 = tmpvar_98;
                if ((Cb_3.y < Cb_3.x)) {
                  tmpvar_100 = (((Cb_3.z - Cb_3.y) * tmpvar_70) / (Cb_3.x - Cb_3.y));
                  tmpvar_101 = tmpvar_70;
                } else {
                  tmpvar_100 = 0.0;
                  tmpvar_101 = 0.0;
                };
                tmpvar_99 = 0.0;
                tmpvar_96 = tmpvar_99;
                tmpvar_97 = tmpvar_100;
                tmpvar_98 = tmpvar_101;
                tmpvar_71.y = 0.0;
                tmpvar_71.z = tmpvar_100;
                tmpvar_71.x = tmpvar_101;
              } else {
                float tmpvar_102;
                tmpvar_102 = tmpvar_69.z;
                float tmpvar_103;
                tmpvar_103 = tmpvar_69.y;
                float tmpvar_104;
                tmpvar_104 = tmpvar_69.x;
                float tmpvar_105;
                tmpvar_105 = tmpvar_102;
                float tmpvar_106;
                tmpvar_106 = tmpvar_103;
                float tmpvar_107;
                tmpvar_107 = tmpvar_104;
                if ((Cb_3.z < Cb_3.x)) {
                  tmpvar_106 = (((Cb_3.y - Cb_3.z) * tmpvar_70) / (Cb_3.x - Cb_3.z));
                  tmpvar_107 = tmpvar_70;
                } else {
                  tmpvar_106 = 0.0;
                  tmpvar_107 = 0.0;
                };
                tmpvar_105 = 0.0;
                tmpvar_102 = tmpvar_105;
                tmpvar_103 = tmpvar_106;
                tmpvar_104 = tmpvar_107;
                tmpvar_71.z = 0.0;
                tmpvar_71.y = tmpvar_106;
                tmpvar_71.x = tmpvar_107;
              };
            };
          };
          vec3 tmpvar_108;
          tmpvar_108 = (tmpvar_71 + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (tmpvar_71, vec3(0.3, 0.59, 0.11))));
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
          result_10.xyz = tmpvar_108;
          break;
        };
        tmpvar_11 = (tmpvar_11 || (14 == vData.x));
        if (tmpvar_11) {
          vec3 tmpvar_112;
          tmpvar_112 = (Ca_4.xyz + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (Ca_4.xyz, vec3(0.3, 0.59, 0.11))));
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
          result_10.xyz = tmpvar_112;
          break;
        };
        tmpvar_11 = (tmpvar_11 || (15 == vData.x));
        if (tmpvar_11) {
          vec3 tmpvar_116;
          tmpvar_116 = (Cb_3.xyz + (dot (Ca_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11))));
          float tmpvar_117;
          tmpvar_117 = dot (tmpvar_116, vec3(0.3, 0.59, 0.11));
          float tmpvar_118;
          tmpvar_118 = min (tmpvar_116.x, min (tmpvar_116.y, tmpvar_116.z));
          float tmpvar_119;
          tmpvar_119 = max (tmpvar_116.x, max (tmpvar_116.y, tmpvar_116.z));
          if ((tmpvar_118 < 0.0)) {
            tmpvar_116 = (tmpvar_117 + ((
              (tmpvar_116 - tmpvar_117)
             * tmpvar_117) / (tmpvar_117 - tmpvar_118)));
          };
          if ((1.0 < tmpvar_119)) {
            tmpvar_116 = (tmpvar_117 + ((
              (tmpvar_116 - tmpvar_117)
             * 
              (1.0 - tmpvar_117)
            ) / (tmpvar_119 - tmpvar_117)));
          };
          result_10.xyz = tmpvar_116;
          break;
        };
        tmpvar_11 = bool(1);
        break;
      };
      vec4 tmpvar_120;
      tmpvar_120.xyz = (Cb_3.xyz * Cb_3.w);
      tmpvar_120.w = Cb_3.w;
      vec4 tmpvar_121;
      tmpvar_121.w = 1.0;
      tmpvar_121.xyz = (((1.0 - Cb_3.w) * Ca_4.xyz) + (Cb_3.w * result_10.xyz));
      vec4 tmpvar_122;
      tmpvar_122 = mix (tmpvar_120, tmpvar_121, Ca_4.w);
      result_10 = tmpvar_122;
      result_2 = tmpvar_122;
      needsPremul_1 = bool(0);
      break;
    };
    tmpvar_9 = (tmpvar_9 || (1 == vFilterKind));
    if (tmpvar_9) {
      result_2 = vFilterData0;
      needsPremul_1 = bool(0);
      break;
    };
    tmpvar_9 = (tmpvar_9 || (2 == vFilterKind));
    if (tmpvar_9) {
      result_2.xyz = mix(((vec3(1.055, 1.055, 1.055) * 
        pow (Ca_4.xyz, vec3(0.4166667, 0.4166667, 0.4166667))
      ) - vec3(0.055, 0.055, 0.055)), (Ca_4.xyz * 12.92), bvec3(greaterThanEqual (vec3(0.0031308, 0.0031308, 0.0031308), Ca_4.xyz)));
      result_2.w = Ca_4.w;
      break;
    };
    tmpvar_9 = (tmpvar_9 || (3 == vFilterKind));
    if (tmpvar_9) {
      result_2.xyz = mix(pow ((
        (Ca_4.xyz / 1.055)
       + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), (Ca_4.xyz / 12.92), bvec3(greaterThanEqual (vec3(0.04045, 0.04045, 0.04045), Ca_4.xyz)));
      result_2.w = Ca_4.w;
      break;
    };
    tmpvar_9 = (tmpvar_9 || (4 == vFilterKind));
    if (tmpvar_9) {
      result_2.xyz = Ca_4.xyz;
      result_2.w = (Ca_4.w * vFloat0);
      break;
    };
    tmpvar_9 = (tmpvar_9 || (5 == vFilterKind));
    if (tmpvar_9) {
      result_2 = ((vColorMat * Ca_4) + vFilterData0);
      result_2 = min (max (result_2, 0.0), 1.0);
      break;
    };
    tmpvar_9 = (tmpvar_9 || (6 == vFilterKind));
    if (tmpvar_9) {
      vec4 tmpvar_123;
      tmpvar_123.xyz = vFilterData0.xyz;
      tmpvar_123.w = (Cb_3.w * vFilterData0.w);
      vec4 tmpvar_124;
      tmpvar_124.xyz = (vFilterData0.xyz * tmpvar_123.w);
      tmpvar_124.w = tmpvar_123.w;
      vec4 tmpvar_125;
      tmpvar_125.w = 1.0;
      tmpvar_125.xyz = (((1.0 - tmpvar_123.w) * Ca_4.xyz) + (tmpvar_123.w * Ca_4.xyz));
      result_2 = mix (tmpvar_124, tmpvar_125, Ca_4.w);
      needsPremul_1 = bool(0);
      break;
    };
    tmpvar_9 = (tmpvar_9 || (7 == vFilterKind));
    if (tmpvar_9) {
      vec2 tmpvar_126;
      tmpvar_126 = (vInput1Uv.xy + vFilterData0.xy);
      vec3 tmpvar_127;
      tmpvar_127.xy = tmpvar_126;
      tmpvar_127.z = vInput1Uv.z;
      vec3 tmpvar_128;
      tmpvar_128.xy = min (max (tmpvar_126, vInput1UvRect.xy), vInput1UvRect.zw);
      tmpvar_128.z = tmpvar_127.z;
      vec2 tmpvar_129;
      tmpvar_129.x = float((tmpvar_126.x >= vFilterData1.z));
      tmpvar_129.y = float((tmpvar_126.y >= vFilterData1.w));
      vec2 tmpvar_130;
      tmpvar_130 = (vec2(greaterThanEqual (tmpvar_126, vFilterData1.xy)) - tmpvar_129);
      result_2 = (texture (sColor0, tmpvar_128, 0.0) * (tmpvar_130.x * tmpvar_130.y));
      needsPremul_1 = bool(0);
      break;
    };
    tmpvar_9 = (tmpvar_9 || (8 == vFilterKind));
    if (tmpvar_9) {
      vec4 tmpvar_131;
      tmpvar_131 = Ca_4;
      int i_132;
      int k_133;
      int offset_134;
      offset_134 = 0;
      i_132 = 0;
      while (true) {
        if ((i_132 >= 4)) {
          break;
        };
        bool tmpvar_135;
        tmpvar_135 = bool(0);
        while (true) {
          int tmpvar_136;
          tmpvar_136 = vFuncs[i_132];
          tmpvar_135 = (tmpvar_135 || (0 == tmpvar_136));
          if (tmpvar_135) {
            break;
          };
          tmpvar_135 = (tmpvar_135 || (1 == tmpvar_136));
          tmpvar_135 = (tmpvar_135 || (2 == tmpvar_136));
          if (tmpvar_135) {
            k_133 = int(floor((tmpvar_131[i_132] * 255.0)));
            ivec2 tmpvar_137;
            tmpvar_137.y = 0;
            tmpvar_137.x = (offset_134 + (k_133 / 4));
            vec4 tmpvar_138;
            tmpvar_138 = texelFetch (sGpuCache, (vData.xy + tmpvar_137), 0);
            tmpvar_131[i_132] = min (max (tmpvar_138[(k_133 % 4)], 0.0), 1.0);
            offset_134 += 64;
            break;
          };
          tmpvar_135 = (tmpvar_135 || (3 == tmpvar_136));
          if (tmpvar_135) {
            ivec2 tmpvar_139;
            tmpvar_139.y = 0;
            tmpvar_139.x = offset_134;
            vec4 tmpvar_140;
            tmpvar_140 = texelFetch (sGpuCache, (vData.xy + tmpvar_139), 0);
            tmpvar_131[i_132] = min (max ((
              (tmpvar_140[0] * tmpvar_131[i_132])
             + tmpvar_140[1]), 0.0), 1.0);
            offset_134++;
            break;
          };
          tmpvar_135 = (tmpvar_135 || (4 == tmpvar_136));
          if (tmpvar_135) {
            ivec2 tmpvar_141;
            tmpvar_141.y = 0;
            tmpvar_141.x = offset_134;
            vec4 tmpvar_142;
            tmpvar_142 = texelFetch (sGpuCache, (vData.xy + tmpvar_141), 0);
            tmpvar_131[i_132] = min (max ((
              (tmpvar_142[0] * pow (tmpvar_131[i_132], tmpvar_142[1]))
             + tmpvar_142[2]), 0.0), 1.0);
            offset_134++;
            break;
          };
          tmpvar_135 = bool(1);
          break;
        };
        i_132++;
      };
      result_2 = tmpvar_131;
      break;
    };
    tmpvar_9 = (tmpvar_9 || (9 == vFilterKind));
    if (tmpvar_9) {
      result_2 = Ca_4;
      break;
    };
    tmpvar_9 = (tmpvar_9 || (10 == vFilterKind));
    if (tmpvar_9) {
      vec4 Cr_143;
      Cr_143 = vec4(0.0, 1.0, 0.0, 1.0);
      bool tmpvar_144;
      tmpvar_144 = bool(0);
      while (true) {
        tmpvar_144 = (tmpvar_144 || (0 == vData.x));
        if (tmpvar_144) {
          Cr_143.xyz = ((Ca_4.w * Ca_4.xyz) + ((Cb_3.w * Cb_3.xyz) * (1.0 - Ca_4.w)));
          Cr_143.w = (Ca_4.w + (Cb_3.w * (1.0 - Ca_4.w)));
          break;
        };
        tmpvar_144 = (tmpvar_144 || (1 == vData.x));
        if (tmpvar_144) {
          Cr_143.xyz = ((Ca_4.w * Ca_4.xyz) * Cb_3.w);
          Cr_143.w = (Ca_4.w * Cb_3.w);
          break;
        };
        tmpvar_144 = (tmpvar_144 || (2 == vData.x));
        if (tmpvar_144) {
          Cr_143.xyz = ((Ca_4.w * Ca_4.xyz) * (1.0 - Cb_3.w));
          Cr_143.w = (Ca_4.w * (1.0 - Cb_3.w));
          break;
        };
        tmpvar_144 = (tmpvar_144 || (3 == vData.x));
        if (tmpvar_144) {
          Cr_143.xyz = (((Ca_4.w * Ca_4.xyz) * Cb_3.w) + ((Cb_3.w * Cb_3.xyz) * (1.0 - Ca_4.w)));
          Cr_143.w = ((Ca_4.w * Cb_3.w) + (Cb_3.w * (1.0 - Ca_4.w)));
          break;
        };
        tmpvar_144 = (tmpvar_144 || (4 == vData.x));
        if (tmpvar_144) {
          Cr_143.xyz = (((Ca_4.w * Ca_4.xyz) * (1.0 - Cb_3.w)) + ((Cb_3.w * Cb_3.xyz) * (1.0 - Ca_4.w)));
          Cr_143.w = ((Ca_4.w * (1.0 - Cb_3.w)) + (Cb_3.w * (1.0 - Ca_4.w)));
          break;
        };
        tmpvar_144 = (tmpvar_144 || (5 == vData.x));
        if (tmpvar_144) {
          Cr_143.xyz = ((Ca_4.w * Ca_4.xyz) + (Cb_3.w * Cb_3.xyz));
          Cr_143.w = (Ca_4.w + Cb_3.w);
          Cr_143 = min (max (Cr_143, 0.0), 1.0);
          break;
        };
        tmpvar_144 = (tmpvar_144 || (6 == vData.x));
        if (tmpvar_144) {
          Cr_143 = (((
            ((vFilterData0.xxxx * Ca_4) * Cb_3)
           + 
            (vFilterData0.yyyy * Ca_4)
          ) + (vFilterData0.zzzz * Cb_3)) + vFilterData0.wwww);
          Cr_143 = min (max (Cr_143, 0.0), 1.0);
          break;
        };
        tmpvar_144 = bool(1);
        break;
      };
      result_2 = Cr_143;
      needsPremul_1 = bool(0);
    };
    tmpvar_9 = bool(1);
    break;
  };
  if (needsPremul_1) {
    result_2.xyz = (result_2.xyz * result_2.w);
  };
  oFragColor = result_2;
}

