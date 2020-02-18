#version 310 es
precision highp float;
precision highp sampler2DArray;
out lowp vec4 oFragColor;
uniform sampler2DArray sColor0;
uniform sampler2DArray sColor1;
uniform highp sampler2D sGpuCache;
in vec3 vInput1Uv;
in vec3 vInput2Uv;
flat in vec4 vInput1UvRect;
flat in vec4 vInput2UvRect;
flat in highp int vFilterInputCount;
flat in highp int vFilterKind;
flat in highp ivec4 vData;
flat in vec4 vFilterData0;
flat in vec4 vFilterData1;
flat in float vFloat0;
flat in mat4 vColorMat;
flat in int vFuncs[4];
void main ()
{
  bool needsPremul_1;
  lowp vec4 result_2;
  lowp vec4 Cb_3;
  lowp vec4 Ca_4;
  Ca_4 = vec4(0.0, 0.0, 0.0, 0.0);
  Cb_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((vFilterInputCount > 0)) {
    vec3 tmpvar_5;
    tmpvar_5.xy = clamp (vInput1Uv.xy, vInput1UvRect.xy, vInput1UvRect.zw);
    tmpvar_5.z = vInput1Uv.z;
    lowp vec4 tmpvar_6;
    tmpvar_6 = texture (sColor0, tmpvar_5, 0.0);
    Ca_4 = tmpvar_6;
    if ((tmpvar_6.w != 0.0)) {
      Ca_4.xyz = (tmpvar_6.xyz / tmpvar_6.w);
    };
  };
  if ((vFilterInputCount > 1)) {
    vec3 tmpvar_7;
    tmpvar_7.xy = clamp (vInput2Uv.xy, vInput2UvRect.xy, vInput2UvRect.zw);
    tmpvar_7.z = vInput2Uv.z;
    lowp vec4 tmpvar_8;
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
  bool tmpvar_10;
  tmpvar_10 = bool(0);
  if ((0 == vFilterKind)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    lowp vec4 result_11;
    result_11 = vec4(1.0, 0.0, 0.0, 1.0);
    bool tmpvar_12;
    tmpvar_12 = bool(0);
    bool tmpvar_13;
    tmpvar_13 = bool(0);
    if ((0 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      result_11.xyz = Ca_4.xyz;
      tmpvar_13 = bool(1);
    };
    if ((1 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      result_11.xyz = (Cb_3.xyz * Ca_4.xyz);
      tmpvar_13 = bool(1);
    };
    if ((2 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      result_11.xyz = ((Cb_3.xyz + Ca_4.xyz) - (Cb_3.xyz * Ca_4.xyz));
      tmpvar_13 = bool(1);
    };
    if ((3 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      lowp vec3 Cs_14;
      Cs_14 = ((2.0 * Cb_3.xyz) - 1.0);
      result_11.xyz = mix ((Ca_4.xyz * (2.0 * Cb_3.xyz)), ((Ca_4.xyz + Cs_14) - (Ca_4.xyz * Cs_14)), vec3(greaterThanEqual (Cb_3.xyz, vec3(0.5, 0.5, 0.5))));
      tmpvar_13 = bool(1);
    };
    if ((4 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      result_11.xyz = min (Ca_4.xyz, Cb_3.xyz);
      tmpvar_13 = bool(1);
    };
    if ((5 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      result_11.xyz = max (Ca_4.xyz, Cb_3.xyz);
      tmpvar_13 = bool(1);
    };
    if ((6 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      lowp float tmpvar_15;
      if ((Cb_3.x == 0.0)) {
        tmpvar_15 = 0.0;
      } else {
        if ((Ca_4.x == 1.0)) {
          tmpvar_15 = 1.0;
        } else {
          tmpvar_15 = min (1.0, (Cb_3.x / (1.0 - Ca_4.x)));
        };
      };
      result_11.x = tmpvar_15;
      lowp float tmpvar_16;
      if ((Cb_3.y == 0.0)) {
        tmpvar_16 = 0.0;
      } else {
        if ((Ca_4.y == 1.0)) {
          tmpvar_16 = 1.0;
        } else {
          tmpvar_16 = min (1.0, (Cb_3.y / (1.0 - Ca_4.y)));
        };
      };
      result_11.y = tmpvar_16;
      lowp float tmpvar_17;
      if ((Cb_3.z == 0.0)) {
        tmpvar_17 = 0.0;
      } else {
        if ((Ca_4.z == 1.0)) {
          tmpvar_17 = 1.0;
        } else {
          tmpvar_17 = min (1.0, (Cb_3.z / (1.0 - Ca_4.z)));
        };
      };
      result_11.z = tmpvar_17;
      tmpvar_13 = bool(1);
    };
    if ((7 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      lowp float tmpvar_18;
      if ((Cb_3.x == 1.0)) {
        tmpvar_18 = 1.0;
      } else {
        if ((Ca_4.x == 0.0)) {
          tmpvar_18 = 0.0;
        } else {
          tmpvar_18 = (1.0 - min (1.0, (
            (1.0 - Cb_3.x)
           / Ca_4.x)));
        };
      };
      result_11.x = tmpvar_18;
      lowp float tmpvar_19;
      if ((Cb_3.y == 1.0)) {
        tmpvar_19 = 1.0;
      } else {
        if ((Ca_4.y == 0.0)) {
          tmpvar_19 = 0.0;
        } else {
          tmpvar_19 = (1.0 - min (1.0, (
            (1.0 - Cb_3.y)
           / Ca_4.y)));
        };
      };
      result_11.y = tmpvar_19;
      lowp float tmpvar_20;
      if ((Cb_3.z == 1.0)) {
        tmpvar_20 = 1.0;
      } else {
        if ((Ca_4.z == 0.0)) {
          tmpvar_20 = 0.0;
        } else {
          tmpvar_20 = (1.0 - min (1.0, (
            (1.0 - Cb_3.z)
           / Ca_4.z)));
        };
      };
      result_11.z = tmpvar_20;
      tmpvar_13 = bool(1);
    };
    if ((8 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      lowp vec3 Cs_21;
      Cs_21 = ((2.0 * Ca_4.xyz) - 1.0);
      result_11.xyz = mix ((Cb_3.xyz * (2.0 * Ca_4.xyz)), ((Cb_3.xyz + Cs_21) - (Cb_3.xyz * Cs_21)), vec3(greaterThanEqual (Ca_4.xyz, vec3(0.5, 0.5, 0.5))));
      tmpvar_13 = bool(1);
    };
    if ((9 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      lowp float tmpvar_22;
      if ((Ca_4.x <= 0.5)) {
        tmpvar_22 = (Cb_3.x - ((
          (1.0 - (2.0 * Ca_4.x))
         * Cb_3.x) * (1.0 - Cb_3.x)));
      } else {
        lowp float D_23;
        if ((Cb_3.x <= 0.25)) {
          D_23 = (((
            ((16.0 * Cb_3.x) - 12.0)
           * Cb_3.x) + 4.0) * Cb_3.x);
        } else {
          D_23 = sqrt(Cb_3.x);
        };
        tmpvar_22 = (Cb_3.x + ((
          (2.0 * Ca_4.x)
         - 1.0) * (D_23 - Cb_3.x)));
      };
      result_11.x = tmpvar_22;
      lowp float tmpvar_24;
      if ((Ca_4.y <= 0.5)) {
        tmpvar_24 = (Cb_3.y - ((
          (1.0 - (2.0 * Ca_4.y))
         * Cb_3.y) * (1.0 - Cb_3.y)));
      } else {
        lowp float D_25;
        if ((Cb_3.y <= 0.25)) {
          D_25 = (((
            ((16.0 * Cb_3.y) - 12.0)
           * Cb_3.y) + 4.0) * Cb_3.y);
        } else {
          D_25 = sqrt(Cb_3.y);
        };
        tmpvar_24 = (Cb_3.y + ((
          (2.0 * Ca_4.y)
         - 1.0) * (D_25 - Cb_3.y)));
      };
      result_11.y = tmpvar_24;
      lowp float tmpvar_26;
      if ((Ca_4.z <= 0.5)) {
        tmpvar_26 = (Cb_3.z - ((
          (1.0 - (2.0 * Ca_4.z))
         * Cb_3.z) * (1.0 - Cb_3.z)));
      } else {
        lowp float D_27;
        if ((Cb_3.z <= 0.25)) {
          D_27 = (((
            ((16.0 * Cb_3.z) - 12.0)
           * Cb_3.z) + 4.0) * Cb_3.z);
        } else {
          D_27 = sqrt(Cb_3.z);
        };
        tmpvar_26 = (Cb_3.z + ((
          (2.0 * Ca_4.z)
         - 1.0) * (D_27 - Cb_3.z)));
      };
      result_11.z = tmpvar_26;
      tmpvar_13 = bool(1);
    };
    if ((10 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      result_11.xyz = abs((Cb_3.xyz - Ca_4.xyz));
      tmpvar_13 = bool(1);
    };
    if ((11 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      result_11.xyz = ((Cb_3.xyz + Ca_4.xyz) - ((2.0 * Cb_3.xyz) * Ca_4.xyz));
      tmpvar_13 = bool(1);
    };
    if ((12 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      lowp vec3 Cs_28;
      Cs_28 = Ca_4.xyz;
      lowp float tmpvar_29;
      tmpvar_29 = (max (Cb_3.x, max (Cb_3.y, Cb_3.z)) - min (Cb_3.x, min (Cb_3.y, Cb_3.z)));
      lowp vec3 C_30;
      C_30 = Cs_28;
      if ((Ca_4.x <= Ca_4.y)) {
        if ((Ca_4.y <= Ca_4.z)) {
          lowp float Cmid_31;
          Cmid_31 = Cs_28.y;
          lowp float Cmax_32;
          Cmax_32 = Cs_28.z;
          if ((Ca_4.z > Ca_4.x)) {
            Cmid_31 = (((Ca_4.y - Ca_4.x) * tmpvar_29) / (Ca_4.z - Ca_4.x));
            Cmax_32 = tmpvar_29;
          } else {
            Cmid_31 = 0.0;
            Cmax_32 = 0.0;
          };
          C_30.x = 0.0;
          C_30.y = Cmid_31;
          C_30.z = Cmax_32;
        } else {
          if ((C_30.x <= C_30.z)) {
            lowp float Cmid_33;
            Cmid_33 = C_30.z;
            lowp float Cmax_34;
            Cmax_34 = C_30.y;
            if ((C_30.y > C_30.x)) {
              Cmid_33 = (((C_30.z - C_30.x) * tmpvar_29) / (C_30.y - C_30.x));
              Cmax_34 = tmpvar_29;
            } else {
              Cmid_33 = 0.0;
              Cmax_34 = 0.0;
            };
            C_30.x = 0.0;
            C_30.z = Cmid_33;
            C_30.y = Cmax_34;
          } else {
            lowp float Cmid_35;
            Cmid_35 = C_30.x;
            lowp float Cmax_36;
            Cmax_36 = C_30.y;
            if ((C_30.y > C_30.z)) {
              Cmid_35 = (((C_30.x - C_30.z) * tmpvar_29) / (C_30.y - C_30.z));
              Cmax_36 = tmpvar_29;
            } else {
              Cmid_35 = 0.0;
              Cmax_36 = 0.0;
            };
            C_30.z = 0.0;
            C_30.x = Cmid_35;
            C_30.y = Cmax_36;
          };
        };
      } else {
        if ((C_30.x <= C_30.z)) {
          lowp float Cmid_37;
          Cmid_37 = C_30.x;
          lowp float Cmax_38;
          Cmax_38 = C_30.z;
          if ((C_30.z > C_30.y)) {
            Cmid_37 = (((C_30.x - C_30.y) * tmpvar_29) / (C_30.z - C_30.y));
            Cmax_38 = tmpvar_29;
          } else {
            Cmid_37 = 0.0;
            Cmax_38 = 0.0;
          };
          C_30.y = 0.0;
          C_30.x = Cmid_37;
          C_30.z = Cmax_38;
        } else {
          if ((C_30.y <= C_30.z)) {
            lowp float Cmid_39;
            Cmid_39 = C_30.z;
            lowp float Cmax_40;
            Cmax_40 = C_30.x;
            if ((C_30.x > C_30.y)) {
              Cmid_39 = (((C_30.z - C_30.y) * tmpvar_29) / (C_30.x - C_30.y));
              Cmax_40 = tmpvar_29;
            } else {
              Cmid_39 = 0.0;
              Cmax_40 = 0.0;
            };
            C_30.y = 0.0;
            C_30.z = Cmid_39;
            C_30.x = Cmax_40;
          } else {
            lowp float Cmid_41;
            Cmid_41 = C_30.y;
            lowp float Cmax_42;
            Cmax_42 = C_30.x;
            if ((C_30.x > C_30.z)) {
              Cmid_41 = (((C_30.y - C_30.z) * tmpvar_29) / (C_30.x - C_30.z));
              Cmax_42 = tmpvar_29;
            } else {
              Cmid_41 = 0.0;
              Cmax_42 = 0.0;
            };
            C_30.z = 0.0;
            C_30.y = Cmid_41;
            C_30.x = Cmax_42;
          };
        };
      };
      lowp vec3 C_43;
      C_43 = (C_30 + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (C_30, vec3(0.3, 0.59, 0.11))));
      lowp float tmpvar_44;
      tmpvar_44 = dot (C_43, vec3(0.3, 0.59, 0.11));
      lowp float tmpvar_45;
      tmpvar_45 = min (C_43.x, min (C_43.y, C_43.z));
      lowp float tmpvar_46;
      tmpvar_46 = max (C_43.x, max (C_43.y, C_43.z));
      if ((tmpvar_45 < 0.0)) {
        C_43 = (tmpvar_44 + ((
          (C_43 - tmpvar_44)
         * tmpvar_44) / (tmpvar_44 - tmpvar_45)));
      };
      if ((tmpvar_46 > 1.0)) {
        C_43 = (tmpvar_44 + ((
          (C_43 - tmpvar_44)
         * 
          (1.0 - tmpvar_44)
        ) / (tmpvar_46 - tmpvar_44)));
      };
      result_11.xyz = C_43;
      tmpvar_13 = bool(1);
    };
    if ((13 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      lowp vec3 Cb_47;
      Cb_47 = Cb_3.xyz;
      lowp float tmpvar_48;
      tmpvar_48 = (max (Ca_4.x, max (Ca_4.y, Ca_4.z)) - min (Ca_4.x, min (Ca_4.y, Ca_4.z)));
      lowp vec3 C_49;
      C_49 = Cb_47;
      if ((Cb_3.x <= Cb_3.y)) {
        if ((Cb_3.y <= Cb_3.z)) {
          lowp float Cmid_50;
          Cmid_50 = Cb_47.y;
          lowp float Cmax_51;
          Cmax_51 = Cb_47.z;
          if ((Cb_3.z > Cb_3.x)) {
            Cmid_50 = (((Cb_3.y - Cb_3.x) * tmpvar_48) / (Cb_3.z - Cb_3.x));
            Cmax_51 = tmpvar_48;
          } else {
            Cmid_50 = 0.0;
            Cmax_51 = 0.0;
          };
          C_49.x = 0.0;
          C_49.y = Cmid_50;
          C_49.z = Cmax_51;
        } else {
          if ((C_49.x <= C_49.z)) {
            lowp float Cmid_52;
            Cmid_52 = C_49.z;
            lowp float Cmax_53;
            Cmax_53 = C_49.y;
            if ((C_49.y > C_49.x)) {
              Cmid_52 = (((C_49.z - C_49.x) * tmpvar_48) / (C_49.y - C_49.x));
              Cmax_53 = tmpvar_48;
            } else {
              Cmid_52 = 0.0;
              Cmax_53 = 0.0;
            };
            C_49.x = 0.0;
            C_49.z = Cmid_52;
            C_49.y = Cmax_53;
          } else {
            lowp float Cmid_54;
            Cmid_54 = C_49.x;
            lowp float Cmax_55;
            Cmax_55 = C_49.y;
            if ((C_49.y > C_49.z)) {
              Cmid_54 = (((C_49.x - C_49.z) * tmpvar_48) / (C_49.y - C_49.z));
              Cmax_55 = tmpvar_48;
            } else {
              Cmid_54 = 0.0;
              Cmax_55 = 0.0;
            };
            C_49.z = 0.0;
            C_49.x = Cmid_54;
            C_49.y = Cmax_55;
          };
        };
      } else {
        if ((C_49.x <= C_49.z)) {
          lowp float Cmid_56;
          Cmid_56 = C_49.x;
          lowp float Cmax_57;
          Cmax_57 = C_49.z;
          if ((C_49.z > C_49.y)) {
            Cmid_56 = (((C_49.x - C_49.y) * tmpvar_48) / (C_49.z - C_49.y));
            Cmax_57 = tmpvar_48;
          } else {
            Cmid_56 = 0.0;
            Cmax_57 = 0.0;
          };
          C_49.y = 0.0;
          C_49.x = Cmid_56;
          C_49.z = Cmax_57;
        } else {
          if ((C_49.y <= C_49.z)) {
            lowp float Cmid_58;
            Cmid_58 = C_49.z;
            lowp float Cmax_59;
            Cmax_59 = C_49.x;
            if ((C_49.x > C_49.y)) {
              Cmid_58 = (((C_49.z - C_49.y) * tmpvar_48) / (C_49.x - C_49.y));
              Cmax_59 = tmpvar_48;
            } else {
              Cmid_58 = 0.0;
              Cmax_59 = 0.0;
            };
            C_49.y = 0.0;
            C_49.z = Cmid_58;
            C_49.x = Cmax_59;
          } else {
            lowp float Cmid_60;
            Cmid_60 = C_49.y;
            lowp float Cmax_61;
            Cmax_61 = C_49.x;
            if ((C_49.x > C_49.z)) {
              Cmid_60 = (((C_49.y - C_49.z) * tmpvar_48) / (C_49.x - C_49.z));
              Cmax_61 = tmpvar_48;
            } else {
              Cmid_60 = 0.0;
              Cmax_61 = 0.0;
            };
            C_49.z = 0.0;
            C_49.y = Cmid_60;
            C_49.x = Cmax_61;
          };
        };
      };
      lowp vec3 C_62;
      C_62 = (C_49 + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (C_49, vec3(0.3, 0.59, 0.11))));
      lowp float tmpvar_63;
      tmpvar_63 = dot (C_62, vec3(0.3, 0.59, 0.11));
      lowp float tmpvar_64;
      tmpvar_64 = min (C_62.x, min (C_62.y, C_62.z));
      lowp float tmpvar_65;
      tmpvar_65 = max (C_62.x, max (C_62.y, C_62.z));
      if ((tmpvar_64 < 0.0)) {
        C_62 = (tmpvar_63 + ((
          (C_62 - tmpvar_63)
         * tmpvar_63) / (tmpvar_63 - tmpvar_64)));
      };
      if ((tmpvar_65 > 1.0)) {
        C_62 = (tmpvar_63 + ((
          (C_62 - tmpvar_63)
         * 
          (1.0 - tmpvar_63)
        ) / (tmpvar_65 - tmpvar_63)));
      };
      result_11.xyz = C_62;
      tmpvar_13 = bool(1);
    };
    if ((14 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      lowp vec3 C_66;
      C_66 = (Ca_4.xyz + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (Ca_4.xyz, vec3(0.3, 0.59, 0.11))));
      lowp float tmpvar_67;
      tmpvar_67 = dot (C_66, vec3(0.3, 0.59, 0.11));
      lowp float tmpvar_68;
      tmpvar_68 = min (C_66.x, min (C_66.y, C_66.z));
      lowp float tmpvar_69;
      tmpvar_69 = max (C_66.x, max (C_66.y, C_66.z));
      if ((tmpvar_68 < 0.0)) {
        C_66 = (tmpvar_67 + ((
          (C_66 - tmpvar_67)
         * tmpvar_67) / (tmpvar_67 - tmpvar_68)));
      };
      if ((tmpvar_69 > 1.0)) {
        C_66 = (tmpvar_67 + ((
          (C_66 - tmpvar_67)
         * 
          (1.0 - tmpvar_67)
        ) / (tmpvar_69 - tmpvar_67)));
      };
      result_11.xyz = C_66;
      tmpvar_13 = bool(1);
    };
    if ((15 == vData.x)) tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      lowp vec3 C_70;
      C_70 = (Cb_3.xyz + (dot (Ca_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11))));
      lowp float tmpvar_71;
      tmpvar_71 = dot (C_70, vec3(0.3, 0.59, 0.11));
      lowp float tmpvar_72;
      tmpvar_72 = min (C_70.x, min (C_70.y, C_70.z));
      lowp float tmpvar_73;
      tmpvar_73 = max (C_70.x, max (C_70.y, C_70.z));
      if ((tmpvar_72 < 0.0)) {
        C_70 = (tmpvar_71 + ((
          (C_70 - tmpvar_71)
         * tmpvar_71) / (tmpvar_71 - tmpvar_72)));
      };
      if ((tmpvar_73 > 1.0)) {
        C_70 = (tmpvar_71 + ((
          (C_70 - tmpvar_71)
         * 
          (1.0 - tmpvar_71)
        ) / (tmpvar_73 - tmpvar_71)));
      };
      result_11.xyz = C_70;
      tmpvar_13 = bool(1);
    };
    tmpvar_12 = bool(1);
    if (tmpvar_13) tmpvar_12 = bool(0);
    if (tmpvar_12) {
      tmpvar_13 = bool(1);
    };
    lowp vec4 tmpvar_74;
    tmpvar_74.xyz = (Cb_3.xyz * Cb_3.w);
    tmpvar_74.w = Cb_3.w;
    lowp vec4 tmpvar_75;
    tmpvar_75.w = 1.0;
    tmpvar_75.xyz = (((1.0 - Cb_3.w) * Ca_4.xyz) + (Cb_3.w * result_11.xyz));
    lowp vec4 tmpvar_76;
    tmpvar_76 = mix (tmpvar_74, tmpvar_75, Ca_4.w);
    result_11 = tmpvar_76;
    result_2 = tmpvar_76;
    needsPremul_1 = bool(0);
    tmpvar_10 = bool(1);
  };
  if ((1 == vFilterKind)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    result_2 = vFilterData0;
    needsPremul_1 = bool(0);
    tmpvar_10 = bool(1);
  };
  if ((2 == vFilterKind)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    result_2.xyz = mix(((vec3(1.055, 1.055, 1.055) * 
      pow (Ca_4.xyz, vec3(0.4166667, 0.4166667, 0.4166667))
    ) - vec3(0.055, 0.055, 0.055)), (Ca_4.xyz * 12.92), bvec3(lessThanEqual (Ca_4.xyz, vec3(0.0031308, 0.0031308, 0.0031308))));
    result_2.w = Ca_4.w;
    tmpvar_10 = bool(1);
  };
  if ((3 == vFilterKind)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    result_2.xyz = mix(pow ((
      (Ca_4.xyz / 1.055)
     + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), (Ca_4.xyz / 12.92), bvec3(lessThanEqual (Ca_4.xyz, vec3(0.04045, 0.04045, 0.04045))));
    result_2.w = Ca_4.w;
    tmpvar_10 = bool(1);
  };
  if ((4 == vFilterKind)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    result_2.xyz = Ca_4.xyz;
    result_2.w = (Ca_4.w * vFloat0);
    tmpvar_10 = bool(1);
  };
  if ((5 == vFilterKind)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    result_2 = ((vColorMat * Ca_4) + vFilterData0);
    result_2 = clamp (result_2, vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0));
    tmpvar_10 = bool(1);
  };
  if ((6 == vFilterKind)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    lowp vec4 tmpvar_77;
    tmpvar_77.xyz = vFilterData0.xyz;
    tmpvar_77.w = (Cb_3.w * vFilterData0.w);
    lowp vec4 result_78;
    result_78 = vec4(1.0, 0.0, 0.0, 1.0);
    bool tmpvar_79;
    bool tmpvar_80;
    tmpvar_80 = bool(0);
    tmpvar_79 = bool(1);
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      result_78.xyz = Ca_4.xyz;
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      result_78.xyz = (vFilterData0.xyz * Ca_4.xyz);
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      result_78.xyz = ((vFilterData0.xyz + Ca_4.xyz) - (vFilterData0.xyz * Ca_4.xyz));
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      lowp vec3 Cs_81;
      lowp vec3 tmpvar_82;
      tmpvar_82 = (2.0 * vFilterData0.xyz);
      Cs_81 = (tmpvar_82 - 1.0);
      result_78.xyz = mix ((Ca_4.xyz * tmpvar_82), ((Ca_4.xyz + Cs_81) - (Ca_4.xyz * Cs_81)), vec3(greaterThanEqual (vFilterData0.xyz, vec3(0.5, 0.5, 0.5))));
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      result_78.xyz = min (Ca_4.xyz, vFilterData0.xyz);
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      result_78.xyz = max (Ca_4.xyz, vFilterData0.xyz);
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      lowp float tmpvar_83;
      if ((vFilterData0.x == 0.0)) {
        tmpvar_83 = 0.0;
      } else {
        if ((Ca_4.x == 1.0)) {
          tmpvar_83 = 1.0;
        } else {
          tmpvar_83 = min (1.0, (vFilterData0.x / (1.0 - Ca_4.x)));
        };
      };
      result_78.x = tmpvar_83;
      lowp float tmpvar_84;
      if ((vFilterData0.y == 0.0)) {
        tmpvar_84 = 0.0;
      } else {
        if ((Ca_4.y == 1.0)) {
          tmpvar_84 = 1.0;
        } else {
          tmpvar_84 = min (1.0, (vFilterData0.y / (1.0 - Ca_4.y)));
        };
      };
      result_78.y = tmpvar_84;
      lowp float tmpvar_85;
      if ((vFilterData0.z == 0.0)) {
        tmpvar_85 = 0.0;
      } else {
        if ((Ca_4.z == 1.0)) {
          tmpvar_85 = 1.0;
        } else {
          tmpvar_85 = min (1.0, (vFilterData0.z / (1.0 - Ca_4.z)));
        };
      };
      result_78.z = tmpvar_85;
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      lowp float tmpvar_86;
      if ((vFilterData0.x == 1.0)) {
        tmpvar_86 = 1.0;
      } else {
        if ((Ca_4.x == 0.0)) {
          tmpvar_86 = 0.0;
        } else {
          tmpvar_86 = (1.0 - min (1.0, (
            (1.0 - vFilterData0.x)
           / Ca_4.x)));
        };
      };
      result_78.x = tmpvar_86;
      lowp float tmpvar_87;
      if ((vFilterData0.y == 1.0)) {
        tmpvar_87 = 1.0;
      } else {
        if ((Ca_4.y == 0.0)) {
          tmpvar_87 = 0.0;
        } else {
          tmpvar_87 = (1.0 - min (1.0, (
            (1.0 - vFilterData0.y)
           / Ca_4.y)));
        };
      };
      result_78.y = tmpvar_87;
      lowp float tmpvar_88;
      if ((vFilterData0.z == 1.0)) {
        tmpvar_88 = 1.0;
      } else {
        if ((Ca_4.z == 0.0)) {
          tmpvar_88 = 0.0;
        } else {
          tmpvar_88 = (1.0 - min (1.0, (
            (1.0 - vFilterData0.z)
           / Ca_4.z)));
        };
      };
      result_78.z = tmpvar_88;
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      lowp vec3 Cs_89;
      Cs_89 = ((2.0 * Ca_4.xyz) - 1.0);
      result_78.xyz = mix ((vFilterData0.xyz * (2.0 * Ca_4.xyz)), ((vFilterData0.xyz + Cs_89) - (vFilterData0.xyz * Cs_89)), vec3(greaterThanEqual (Ca_4.xyz, vec3(0.5, 0.5, 0.5))));
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      lowp float tmpvar_90;
      if ((Ca_4.x <= 0.5)) {
        tmpvar_90 = (vFilterData0.x - ((
          (1.0 - (2.0 * Ca_4.x))
         * vFilterData0.x) * (1.0 - vFilterData0.x)));
      } else {
        lowp float D_91;
        if ((vFilterData0.x <= 0.25)) {
          D_91 = (((
            ((16.0 * vFilterData0.x) - 12.0)
           * vFilterData0.x) + 4.0) * vFilterData0.x);
        } else {
          D_91 = sqrt(vFilterData0.x);
        };
        tmpvar_90 = (vFilterData0.x + ((
          (2.0 * Ca_4.x)
         - 1.0) * (D_91 - vFilterData0.x)));
      };
      result_78.x = tmpvar_90;
      lowp float tmpvar_92;
      if ((Ca_4.y <= 0.5)) {
        tmpvar_92 = (vFilterData0.y - ((
          (1.0 - (2.0 * Ca_4.y))
         * vFilterData0.y) * (1.0 - vFilterData0.y)));
      } else {
        lowp float D_93;
        if ((vFilterData0.y <= 0.25)) {
          D_93 = (((
            ((16.0 * vFilterData0.y) - 12.0)
           * vFilterData0.y) + 4.0) * vFilterData0.y);
        } else {
          D_93 = sqrt(vFilterData0.y);
        };
        tmpvar_92 = (vFilterData0.y + ((
          (2.0 * Ca_4.y)
         - 1.0) * (D_93 - vFilterData0.y)));
      };
      result_78.y = tmpvar_92;
      lowp float tmpvar_94;
      if ((Ca_4.z <= 0.5)) {
        tmpvar_94 = (vFilterData0.z - ((
          (1.0 - (2.0 * Ca_4.z))
         * vFilterData0.z) * (1.0 - vFilterData0.z)));
      } else {
        lowp float D_95;
        if ((vFilterData0.z <= 0.25)) {
          D_95 = (((
            ((16.0 * vFilterData0.z) - 12.0)
           * vFilterData0.z) + 4.0) * vFilterData0.z);
        } else {
          D_95 = sqrt(vFilterData0.z);
        };
        tmpvar_94 = (vFilterData0.z + ((
          (2.0 * Ca_4.z)
         - 1.0) * (D_95 - vFilterData0.z)));
      };
      result_78.z = tmpvar_94;
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      result_78.xyz = abs((vFilterData0.xyz - Ca_4.xyz));
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      result_78.xyz = ((vFilterData0.xyz + Ca_4.xyz) - ((2.0 * vFilterData0.xyz) * Ca_4.xyz));
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      lowp vec3 Cs_96;
      Cs_96 = Ca_4.xyz;
      lowp float tmpvar_97;
      tmpvar_97 = (max (vFilterData0.x, max (vFilterData0.y, vFilterData0.z)) - min (vFilterData0.x, min (vFilterData0.y, vFilterData0.z)));
      lowp vec3 C_98;
      C_98 = Cs_96;
      if ((Ca_4.x <= Ca_4.y)) {
        if ((Ca_4.y <= Ca_4.z)) {
          lowp float Cmid_99;
          Cmid_99 = Cs_96.y;
          lowp float Cmax_100;
          Cmax_100 = Cs_96.z;
          if ((Ca_4.z > Ca_4.x)) {
            Cmid_99 = (((Ca_4.y - Ca_4.x) * tmpvar_97) / (Ca_4.z - Ca_4.x));
            Cmax_100 = tmpvar_97;
          } else {
            Cmid_99 = 0.0;
            Cmax_100 = 0.0;
          };
          C_98.x = 0.0;
          C_98.y = Cmid_99;
          C_98.z = Cmax_100;
        } else {
          if ((C_98.x <= C_98.z)) {
            lowp float Cmid_101;
            Cmid_101 = C_98.z;
            lowp float Cmax_102;
            Cmax_102 = C_98.y;
            if ((C_98.y > C_98.x)) {
              Cmid_101 = (((C_98.z - C_98.x) * tmpvar_97) / (C_98.y - C_98.x));
              Cmax_102 = tmpvar_97;
            } else {
              Cmid_101 = 0.0;
              Cmax_102 = 0.0;
            };
            C_98.x = 0.0;
            C_98.z = Cmid_101;
            C_98.y = Cmax_102;
          } else {
            lowp float Cmid_103;
            Cmid_103 = C_98.x;
            lowp float Cmax_104;
            Cmax_104 = C_98.y;
            if ((C_98.y > C_98.z)) {
              Cmid_103 = (((C_98.x - C_98.z) * tmpvar_97) / (C_98.y - C_98.z));
              Cmax_104 = tmpvar_97;
            } else {
              Cmid_103 = 0.0;
              Cmax_104 = 0.0;
            };
            C_98.z = 0.0;
            C_98.x = Cmid_103;
            C_98.y = Cmax_104;
          };
        };
      } else {
        if ((C_98.x <= C_98.z)) {
          lowp float Cmid_105;
          Cmid_105 = C_98.x;
          lowp float Cmax_106;
          Cmax_106 = C_98.z;
          if ((C_98.z > C_98.y)) {
            Cmid_105 = (((C_98.x - C_98.y) * tmpvar_97) / (C_98.z - C_98.y));
            Cmax_106 = tmpvar_97;
          } else {
            Cmid_105 = 0.0;
            Cmax_106 = 0.0;
          };
          C_98.y = 0.0;
          C_98.x = Cmid_105;
          C_98.z = Cmax_106;
        } else {
          if ((C_98.y <= C_98.z)) {
            lowp float Cmid_107;
            Cmid_107 = C_98.z;
            lowp float Cmax_108;
            Cmax_108 = C_98.x;
            if ((C_98.x > C_98.y)) {
              Cmid_107 = (((C_98.z - C_98.y) * tmpvar_97) / (C_98.x - C_98.y));
              Cmax_108 = tmpvar_97;
            } else {
              Cmid_107 = 0.0;
              Cmax_108 = 0.0;
            };
            C_98.y = 0.0;
            C_98.z = Cmid_107;
            C_98.x = Cmax_108;
          } else {
            lowp float Cmid_109;
            Cmid_109 = C_98.y;
            lowp float Cmax_110;
            Cmax_110 = C_98.x;
            if ((C_98.x > C_98.z)) {
              Cmid_109 = (((C_98.y - C_98.z) * tmpvar_97) / (C_98.x - C_98.z));
              Cmax_110 = tmpvar_97;
            } else {
              Cmid_109 = 0.0;
              Cmax_110 = 0.0;
            };
            C_98.z = 0.0;
            C_98.y = Cmid_109;
            C_98.x = Cmax_110;
          };
        };
      };
      lowp vec3 C_111;
      C_111 = (C_98 + (dot (vFilterData0.xyz, vec3(0.3, 0.59, 0.11)) - dot (C_98, vec3(0.3, 0.59, 0.11))));
      lowp float tmpvar_112;
      tmpvar_112 = dot (C_111, vec3(0.3, 0.59, 0.11));
      lowp float tmpvar_113;
      tmpvar_113 = min (C_111.x, min (C_111.y, C_111.z));
      lowp float tmpvar_114;
      tmpvar_114 = max (C_111.x, max (C_111.y, C_111.z));
      if ((tmpvar_113 < 0.0)) {
        C_111 = (tmpvar_112 + ((
          (C_111 - tmpvar_112)
         * tmpvar_112) / (tmpvar_112 - tmpvar_113)));
      };
      if ((tmpvar_114 > 1.0)) {
        C_111 = (tmpvar_112 + ((
          (C_111 - tmpvar_112)
         * 
          (1.0 - tmpvar_112)
        ) / (tmpvar_114 - tmpvar_112)));
      };
      result_78.xyz = C_111;
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      lowp vec3 Cb_115;
      Cb_115 = tmpvar_77.xyz;
      lowp float tmpvar_116;
      tmpvar_116 = (max (Ca_4.x, max (Ca_4.y, Ca_4.z)) - min (Ca_4.x, min (Ca_4.y, Ca_4.z)));
      lowp vec3 C_117;
      C_117 = Cb_115;
      if ((vFilterData0.x <= vFilterData0.y)) {
        if ((vFilterData0.y <= vFilterData0.z)) {
          lowp float Cmid_118;
          Cmid_118 = Cb_115.y;
          lowp float Cmax_119;
          Cmax_119 = Cb_115.z;
          if ((vFilterData0.z > vFilterData0.x)) {
            Cmid_118 = (((vFilterData0.y - vFilterData0.x) * tmpvar_116) / (vFilterData0.z - vFilterData0.x));
            Cmax_119 = tmpvar_116;
          } else {
            Cmid_118 = 0.0;
            Cmax_119 = 0.0;
          };
          C_117.x = 0.0;
          C_117.y = Cmid_118;
          C_117.z = Cmax_119;
        } else {
          if ((C_117.x <= C_117.z)) {
            lowp float Cmid_120;
            Cmid_120 = C_117.z;
            lowp float Cmax_121;
            Cmax_121 = C_117.y;
            if ((C_117.y > C_117.x)) {
              Cmid_120 = (((C_117.z - C_117.x) * tmpvar_116) / (C_117.y - C_117.x));
              Cmax_121 = tmpvar_116;
            } else {
              Cmid_120 = 0.0;
              Cmax_121 = 0.0;
            };
            C_117.x = 0.0;
            C_117.z = Cmid_120;
            C_117.y = Cmax_121;
          } else {
            lowp float Cmid_122;
            Cmid_122 = C_117.x;
            lowp float Cmax_123;
            Cmax_123 = C_117.y;
            if ((C_117.y > C_117.z)) {
              Cmid_122 = (((C_117.x - C_117.z) * tmpvar_116) / (C_117.y - C_117.z));
              Cmax_123 = tmpvar_116;
            } else {
              Cmid_122 = 0.0;
              Cmax_123 = 0.0;
            };
            C_117.z = 0.0;
            C_117.x = Cmid_122;
            C_117.y = Cmax_123;
          };
        };
      } else {
        if ((C_117.x <= C_117.z)) {
          lowp float Cmid_124;
          Cmid_124 = C_117.x;
          lowp float Cmax_125;
          Cmax_125 = C_117.z;
          if ((C_117.z > C_117.y)) {
            Cmid_124 = (((C_117.x - C_117.y) * tmpvar_116) / (C_117.z - C_117.y));
            Cmax_125 = tmpvar_116;
          } else {
            Cmid_124 = 0.0;
            Cmax_125 = 0.0;
          };
          C_117.y = 0.0;
          C_117.x = Cmid_124;
          C_117.z = Cmax_125;
        } else {
          if ((C_117.y <= C_117.z)) {
            lowp float Cmid_126;
            Cmid_126 = C_117.z;
            lowp float Cmax_127;
            Cmax_127 = C_117.x;
            if ((C_117.x > C_117.y)) {
              Cmid_126 = (((C_117.z - C_117.y) * tmpvar_116) / (C_117.x - C_117.y));
              Cmax_127 = tmpvar_116;
            } else {
              Cmid_126 = 0.0;
              Cmax_127 = 0.0;
            };
            C_117.y = 0.0;
            C_117.z = Cmid_126;
            C_117.x = Cmax_127;
          } else {
            lowp float Cmid_128;
            Cmid_128 = C_117.y;
            lowp float Cmax_129;
            Cmax_129 = C_117.x;
            if ((C_117.x > C_117.z)) {
              Cmid_128 = (((C_117.y - C_117.z) * tmpvar_116) / (C_117.x - C_117.z));
              Cmax_129 = tmpvar_116;
            } else {
              Cmid_128 = 0.0;
              Cmax_129 = 0.0;
            };
            C_117.z = 0.0;
            C_117.y = Cmid_128;
            C_117.x = Cmax_129;
          };
        };
      };
      lowp vec3 C_130;
      C_130 = (C_117 + (dot (vFilterData0.xyz, vec3(0.3, 0.59, 0.11)) - dot (C_117, vec3(0.3, 0.59, 0.11))));
      lowp float tmpvar_131;
      tmpvar_131 = dot (C_130, vec3(0.3, 0.59, 0.11));
      lowp float tmpvar_132;
      tmpvar_132 = min (C_130.x, min (C_130.y, C_130.z));
      lowp float tmpvar_133;
      tmpvar_133 = max (C_130.x, max (C_130.y, C_130.z));
      if ((tmpvar_132 < 0.0)) {
        C_130 = (tmpvar_131 + ((
          (C_130 - tmpvar_131)
         * tmpvar_131) / (tmpvar_131 - tmpvar_132)));
      };
      if ((tmpvar_133 > 1.0)) {
        C_130 = (tmpvar_131 + ((
          (C_130 - tmpvar_131)
         * 
          (1.0 - tmpvar_131)
        ) / (tmpvar_133 - tmpvar_131)));
      };
      result_78.xyz = C_130;
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      lowp vec3 C_134;
      C_134 = (Ca_4.xyz + (dot (vFilterData0.xyz, vec3(0.3, 0.59, 0.11)) - dot (Ca_4.xyz, vec3(0.3, 0.59, 0.11))));
      lowp float tmpvar_135;
      tmpvar_135 = dot (C_134, vec3(0.3, 0.59, 0.11));
      lowp float tmpvar_136;
      tmpvar_136 = min (C_134.x, min (C_134.y, C_134.z));
      lowp float tmpvar_137;
      tmpvar_137 = max (C_134.x, max (C_134.y, C_134.z));
      if ((tmpvar_136 < 0.0)) {
        C_134 = (tmpvar_135 + ((
          (C_134 - tmpvar_135)
         * tmpvar_135) / (tmpvar_135 - tmpvar_136)));
      };
      if ((tmpvar_137 > 1.0)) {
        C_134 = (tmpvar_135 + ((
          (C_134 - tmpvar_135)
         * 
          (1.0 - tmpvar_135)
        ) / (tmpvar_137 - tmpvar_135)));
      };
      result_78.xyz = C_134;
      tmpvar_80 = bool(1);
    };
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      lowp vec3 C_138;
      C_138 = (vFilterData0.xyz + (dot (Ca_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (vFilterData0.xyz, vec3(0.3, 0.59, 0.11))));
      lowp float tmpvar_139;
      tmpvar_139 = dot (C_138, vec3(0.3, 0.59, 0.11));
      lowp float tmpvar_140;
      tmpvar_140 = min (C_138.x, min (C_138.y, C_138.z));
      lowp float tmpvar_141;
      tmpvar_141 = max (C_138.x, max (C_138.y, C_138.z));
      if ((tmpvar_140 < 0.0)) {
        C_138 = (tmpvar_139 + ((
          (C_138 - tmpvar_139)
         * tmpvar_139) / (tmpvar_139 - tmpvar_140)));
      };
      if ((tmpvar_141 > 1.0)) {
        C_138 = (tmpvar_139 + ((
          (C_138 - tmpvar_139)
         * 
          (1.0 - tmpvar_139)
        ) / (tmpvar_141 - tmpvar_139)));
      };
      result_78.xyz = C_138;
      tmpvar_80 = bool(1);
    };
    tmpvar_79 = bool(1);
    if (tmpvar_80) tmpvar_79 = bool(0);
    if (tmpvar_79) {
      tmpvar_80 = bool(1);
    };
    lowp vec4 tmpvar_142;
    tmpvar_142.xyz = (vFilterData0.xyz * tmpvar_77.w);
    tmpvar_142.w = tmpvar_77.w;
    lowp vec4 tmpvar_143;
    tmpvar_143.w = 1.0;
    tmpvar_143.xyz = (((1.0 - tmpvar_77.w) * Ca_4.xyz) + (tmpvar_77.w * result_78.xyz));
    lowp vec4 tmpvar_144;
    tmpvar_144 = mix (tmpvar_142, tmpvar_143, Ca_4.w);
    result_78 = tmpvar_144;
    result_2 = tmpvar_144;
    needsPremul_1 = bool(0);
    tmpvar_10 = bool(1);
  };
  if ((7 == vFilterKind)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    vec2 tmpvar_145;
    tmpvar_145 = (vInput1Uv.xy + vFilterData0.xy);
    vec3 tmpvar_146;
    tmpvar_146.xy = tmpvar_145;
    tmpvar_146.z = vInput1Uv.z;
    vec3 tmpvar_147;
    tmpvar_147.xy = clamp (tmpvar_145, vInput1UvRect.xy, vInput1UvRect.zw);
    tmpvar_147.z = tmpvar_146.z;
    vec2 tmpvar_148;
    tmpvar_148.x = float((tmpvar_145.x >= vFilterData1.z));
    tmpvar_148.y = float((tmpvar_145.y >= vFilterData1.w));
    vec2 tmpvar_149;
    tmpvar_149 = (vec2(greaterThanEqual (tmpvar_145, vFilterData1.xy)) - tmpvar_148);
    result_2 = (texture (sColor0, tmpvar_147, 0.0) * (tmpvar_149.x * tmpvar_149.y));
    needsPremul_1 = bool(0);
    tmpvar_10 = bool(1);
  };
  if ((8 == vFilterKind)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    lowp vec4 colora_150;
    colora_150 = Ca_4;
    lowp int k_152;
    highp int offset_153;
    offset_153 = 0;
    for (highp int i_151 = 0; i_151 < 4; i_151++) {
      bool tmpvar_154;
      tmpvar_154 = bool(0);
      bool tmpvar_155;
      tmpvar_155 = bool(0);
      highp int tmpvar_156;
      tmpvar_156 = vFuncs[i_151];
      if ((0 == tmpvar_156)) tmpvar_154 = bool(1);
      if (tmpvar_155) tmpvar_154 = bool(0);
      if (tmpvar_154) {
        tmpvar_155 = bool(1);
      };
      if ((1 == tmpvar_156)) tmpvar_154 = bool(1);
      if ((2 == tmpvar_156)) tmpvar_154 = bool(1);
      if (tmpvar_155) tmpvar_154 = bool(0);
      if (tmpvar_154) {
        k_152 = int(floor((
          colora_150[i_151]
         * 255.0)));
        lowp ivec2 tmpvar_157;
        tmpvar_157.y = 0;
        tmpvar_157.x = (offset_153 + (k_152 / 4));
        lowp ivec2 address_158;
        address_158 = (vData.xy + tmpvar_157);
        highp float tmpvar_159;
        tmpvar_159 = clamp (texelFetch (sGpuCache, address_158, 0)[(int(k_152 % 4))], 0.0, 1.0);
        colora_150[i_151] = tmpvar_159;
        offset_153 += 64;
        tmpvar_155 = bool(1);
      };
      if ((3 == tmpvar_156)) tmpvar_154 = bool(1);
      if (tmpvar_155) tmpvar_154 = bool(0);
      if (tmpvar_154) {
        highp ivec2 tmpvar_160;
        tmpvar_160.y = 0;
        tmpvar_160.x = offset_153;
        highp vec4 tmpvar_161;
        tmpvar_161 = texelFetch (sGpuCache, (vData.xy + tmpvar_160), 0);
        highp float tmpvar_162;
        tmpvar_162 = clamp (((tmpvar_161.x * 
          colora_150[i_151]
        ) + tmpvar_161.y), 0.0, 1.0);
        colora_150[i_151] = tmpvar_162;
        offset_153++;
        tmpvar_155 = bool(1);
      };
      if ((4 == tmpvar_156)) tmpvar_154 = bool(1);
      if (tmpvar_155) tmpvar_154 = bool(0);
      if (tmpvar_154) {
        highp ivec2 tmpvar_163;
        tmpvar_163.y = 0;
        tmpvar_163.x = offset_153;
        highp vec4 tmpvar_164;
        tmpvar_164 = texelFetch (sGpuCache, (vData.xy + tmpvar_163), 0);
        lowp float x_165;
        x_165 = colora_150[i_151];
        highp float tmpvar_166;
        tmpvar_166 = clamp (((tmpvar_164.x * 
          pow (x_165, tmpvar_164.y)
        ) + tmpvar_164.z), 0.0, 1.0);
        colora_150[i_151] = tmpvar_166;
        offset_153++;
        tmpvar_155 = bool(1);
      };
      tmpvar_154 = bool(1);
      if (tmpvar_155) tmpvar_154 = bool(0);
      if (tmpvar_154) {
        tmpvar_155 = bool(1);
      };
    };
    result_2 = colora_150;
    tmpvar_10 = bool(1);
  };
  if ((9 == vFilterKind)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    result_2 = Ca_4;
    tmpvar_10 = bool(1);
  };
  if ((10 == vFilterKind)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    lowp vec4 Cr_167;
    Cr_167 = vec4(0.0, 1.0, 0.0, 1.0);
    bool tmpvar_168;
    tmpvar_168 = bool(0);
    bool tmpvar_169;
    tmpvar_169 = bool(0);
    if ((0 == vData.x)) tmpvar_168 = bool(1);
    if (tmpvar_169) tmpvar_168 = bool(0);
    if (tmpvar_168) {
      Cr_167.xyz = ((Ca_4.w * Ca_4.xyz) + ((Cb_3.w * Cb_3.xyz) * (1.0 - Ca_4.w)));
      Cr_167.w = (Ca_4.w + (Cb_3.w * (1.0 - Ca_4.w)));
      tmpvar_169 = bool(1);
    };
    if ((1 == vData.x)) tmpvar_168 = bool(1);
    if (tmpvar_169) tmpvar_168 = bool(0);
    if (tmpvar_168) {
      Cr_167.xyz = ((Ca_4.w * Ca_4.xyz) * Cb_3.w);
      Cr_167.w = (Ca_4.w * Cb_3.w);
      tmpvar_169 = bool(1);
    };
    if ((2 == vData.x)) tmpvar_168 = bool(1);
    if (tmpvar_169) tmpvar_168 = bool(0);
    if (tmpvar_168) {
      Cr_167.xyz = ((Ca_4.w * Ca_4.xyz) * (1.0 - Cb_3.w));
      Cr_167.w = (Ca_4.w * (1.0 - Cb_3.w));
      tmpvar_169 = bool(1);
    };
    if ((3 == vData.x)) tmpvar_168 = bool(1);
    if (tmpvar_169) tmpvar_168 = bool(0);
    if (tmpvar_168) {
      Cr_167.xyz = (((Ca_4.w * Ca_4.xyz) * Cb_3.w) + ((Cb_3.w * Cb_3.xyz) * (1.0 - Ca_4.w)));
      Cr_167.w = ((Ca_4.w * Cb_3.w) + (Cb_3.w * (1.0 - Ca_4.w)));
      tmpvar_169 = bool(1);
    };
    if ((4 == vData.x)) tmpvar_168 = bool(1);
    if (tmpvar_169) tmpvar_168 = bool(0);
    if (tmpvar_168) {
      Cr_167.xyz = (((Ca_4.w * Ca_4.xyz) * (1.0 - Cb_3.w)) + ((Cb_3.w * Cb_3.xyz) * (1.0 - Ca_4.w)));
      Cr_167.w = ((Ca_4.w * (1.0 - Cb_3.w)) + (Cb_3.w * (1.0 - Ca_4.w)));
      tmpvar_169 = bool(1);
    };
    if ((5 == vData.x)) tmpvar_168 = bool(1);
    if (tmpvar_169) tmpvar_168 = bool(0);
    if (tmpvar_168) {
      Cr_167.xyz = ((Ca_4.w * Ca_4.xyz) + (Cb_3.w * Cb_3.xyz));
      Cr_167.w = (Ca_4.w + Cb_3.w);
      Cr_167 = clamp (Cr_167, vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0));
      tmpvar_169 = bool(1);
    };
    if ((6 == vData.x)) tmpvar_168 = bool(1);
    if (tmpvar_169) tmpvar_168 = bool(0);
    if (tmpvar_168) {
      Cr_167 = (((
        ((vFilterData0.xxxx * Ca_4) * Cb_3)
       + 
        (vFilterData0.yyyy * Ca_4)
      ) + (vFilterData0.zzzz * Cb_3)) + vFilterData0.wwww);
      Cr_167 = clamp (Cr_167, vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0));
      tmpvar_169 = bool(1);
    };
    tmpvar_168 = bool(1);
    if (tmpvar_169) tmpvar_168 = bool(0);
    if (tmpvar_168) {
      tmpvar_169 = bool(1);
    };
    result_2 = Cr_167;
    needsPremul_1 = bool(0);
  };
  tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    tmpvar_10 = bool(1);
  };
  if (needsPremul_1) {
    result_2.xyz = (result_2.xyz * result_2.w);
  };
  oFragColor = result_2;
}

