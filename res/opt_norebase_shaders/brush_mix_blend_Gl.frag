#version 150
precision highp float;
out vec4 oFragColor;
uniform sampler2DArray sPrevPassColor;
flat in ivec4 flat_varying_ivec4_0;
in vec4 varying_vec4_0;
in vec4 varying_vec4_1;
void main ()
{
  vec4 result_1;
  vec4 Cs_2;
  vec4 Cb_3;
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
  bool tmpvar_7;
  tmpvar_7 = bool(0);
  if ((1 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    result_1.xyz = (Cb_3.xyz * Cs_2.xyz);
    tmpvar_7 = bool(1);
  };
  if ((2 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    result_1.xyz = ((Cb_3.xyz + Cs_2.xyz) - (Cb_3.xyz * Cs_2.xyz));
    tmpvar_7 = bool(1);
  };
  if ((3 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    vec3 Cs_8;
    Cs_8 = ((2.0 * Cb_3.xyz) - 1.0);
    result_1.xyz = mix ((Cs_2.xyz * (2.0 * Cb_3.xyz)), ((Cs_2.xyz + Cs_8) - (Cs_2.xyz * Cs_8)), vec3(greaterThanEqual (Cb_3.xyz, vec3(0.5, 0.5, 0.5))));
    tmpvar_7 = bool(1);
  };
  if ((4 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    result_1.xyz = min (Cs_2.xyz, Cb_3.xyz);
    tmpvar_7 = bool(1);
  };
  if ((5 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    result_1.xyz = max (Cs_2.xyz, Cb_3.xyz);
    tmpvar_7 = bool(1);
  };
  if ((6 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    float tmpvar_9;
    if ((Cb_3.x == 0.0)) {
      tmpvar_9 = 0.0;
    } else {
      if ((Cs_2.x == 1.0)) {
        tmpvar_9 = 1.0;
      } else {
        tmpvar_9 = min (1.0, (Cb_3.x / (1.0 - Cs_2.x)));
      };
    };
    result_1.x = tmpvar_9;
    float tmpvar_10;
    if ((Cb_3.y == 0.0)) {
      tmpvar_10 = 0.0;
    } else {
      if ((Cs_2.y == 1.0)) {
        tmpvar_10 = 1.0;
      } else {
        tmpvar_10 = min (1.0, (Cb_3.y / (1.0 - Cs_2.y)));
      };
    };
    result_1.y = tmpvar_10;
    float tmpvar_11;
    if ((Cb_3.z == 0.0)) {
      tmpvar_11 = 0.0;
    } else {
      if ((Cs_2.z == 1.0)) {
        tmpvar_11 = 1.0;
      } else {
        tmpvar_11 = min (1.0, (Cb_3.z / (1.0 - Cs_2.z)));
      };
    };
    result_1.z = tmpvar_11;
    tmpvar_7 = bool(1);
  };
  if ((7 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    float tmpvar_12;
    if ((Cb_3.x == 1.0)) {
      tmpvar_12 = 1.0;
    } else {
      if ((Cs_2.x == 0.0)) {
        tmpvar_12 = 0.0;
      } else {
        tmpvar_12 = (1.0 - min (1.0, (
          (1.0 - Cb_3.x)
         / Cs_2.x)));
      };
    };
    result_1.x = tmpvar_12;
    float tmpvar_13;
    if ((Cb_3.y == 1.0)) {
      tmpvar_13 = 1.0;
    } else {
      if ((Cs_2.y == 0.0)) {
        tmpvar_13 = 0.0;
      } else {
        tmpvar_13 = (1.0 - min (1.0, (
          (1.0 - Cb_3.y)
         / Cs_2.y)));
      };
    };
    result_1.y = tmpvar_13;
    float tmpvar_14;
    if ((Cb_3.z == 1.0)) {
      tmpvar_14 = 1.0;
    } else {
      if ((Cs_2.z == 0.0)) {
        tmpvar_14 = 0.0;
      } else {
        tmpvar_14 = (1.0 - min (1.0, (
          (1.0 - Cb_3.z)
         / Cs_2.z)));
      };
    };
    result_1.z = tmpvar_14;
    tmpvar_7 = bool(1);
  };
  if ((8 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    vec3 Cs_15;
    Cs_15 = ((2.0 * Cs_2.xyz) - 1.0);
    result_1.xyz = mix ((Cb_3.xyz * (2.0 * Cs_2.xyz)), ((Cb_3.xyz + Cs_15) - (Cb_3.xyz * Cs_15)), vec3(greaterThanEqual (Cs_2.xyz, vec3(0.5, 0.5, 0.5))));
    tmpvar_7 = bool(1);
  };
  if ((9 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    float tmpvar_16;
    if ((Cs_2.x <= 0.5)) {
      tmpvar_16 = (Cb_3.x - ((
        (1.0 - (2.0 * Cs_2.x))
       * Cb_3.x) * (1.0 - Cb_3.x)));
    } else {
      float D_17;
      if ((Cb_3.x <= 0.25)) {
        D_17 = (((
          ((16.0 * Cb_3.x) - 12.0)
         * Cb_3.x) + 4.0) * Cb_3.x);
      } else {
        D_17 = sqrt(Cb_3.x);
      };
      tmpvar_16 = (Cb_3.x + ((
        (2.0 * Cs_2.x)
       - 1.0) * (D_17 - Cb_3.x)));
    };
    result_1.x = tmpvar_16;
    float tmpvar_18;
    if ((Cs_2.y <= 0.5)) {
      tmpvar_18 = (Cb_3.y - ((
        (1.0 - (2.0 * Cs_2.y))
       * Cb_3.y) * (1.0 - Cb_3.y)));
    } else {
      float D_19;
      if ((Cb_3.y <= 0.25)) {
        D_19 = (((
          ((16.0 * Cb_3.y) - 12.0)
         * Cb_3.y) + 4.0) * Cb_3.y);
      } else {
        D_19 = sqrt(Cb_3.y);
      };
      tmpvar_18 = (Cb_3.y + ((
        (2.0 * Cs_2.y)
       - 1.0) * (D_19 - Cb_3.y)));
    };
    result_1.y = tmpvar_18;
    float tmpvar_20;
    if ((Cs_2.z <= 0.5)) {
      tmpvar_20 = (Cb_3.z - ((
        (1.0 - (2.0 * Cs_2.z))
       * Cb_3.z) * (1.0 - Cb_3.z)));
    } else {
      float D_21;
      if ((Cb_3.z <= 0.25)) {
        D_21 = (((
          ((16.0 * Cb_3.z) - 12.0)
         * Cb_3.z) + 4.0) * Cb_3.z);
      } else {
        D_21 = sqrt(Cb_3.z);
      };
      tmpvar_20 = (Cb_3.z + ((
        (2.0 * Cs_2.z)
       - 1.0) * (D_21 - Cb_3.z)));
    };
    result_1.z = tmpvar_20;
    tmpvar_7 = bool(1);
  };
  if ((10 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    result_1.xyz = abs((Cb_3.xyz - Cs_2.xyz));
    tmpvar_7 = bool(1);
  };
  if ((11 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    result_1.xyz = ((Cb_3.xyz + Cs_2.xyz) - ((2.0 * Cb_3.xyz) * Cs_2.xyz));
    tmpvar_7 = bool(1);
  };
  if ((12 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    vec3 Cs_22;
    Cs_22 = Cs_2.xyz;
    float tmpvar_23;
    tmpvar_23 = (max (Cb_3.x, max (Cb_3.y, Cb_3.z)) - min (Cb_3.x, min (Cb_3.y, Cb_3.z)));
    vec3 C_24;
    C_24 = Cs_22;
    if ((Cs_2.x <= Cs_2.y)) {
      if ((Cs_2.y <= Cs_2.z)) {
        float Cmid_25;
        Cmid_25 = Cs_22.y;
        float Cmax_26;
        Cmax_26 = Cs_22.z;
        if ((Cs_2.z > Cs_2.x)) {
          Cmid_25 = (((Cs_2.y - Cs_2.x) * tmpvar_23) / (Cs_2.z - Cs_2.x));
          Cmax_26 = tmpvar_23;
        } else {
          Cmid_25 = 0.0;
          Cmax_26 = 0.0;
        };
        C_24.x = 0.0;
        C_24.y = Cmid_25;
        C_24.z = Cmax_26;
      } else {
        if ((C_24.x <= C_24.z)) {
          float Cmid_27;
          Cmid_27 = C_24.z;
          float Cmax_28;
          Cmax_28 = C_24.y;
          if ((C_24.y > C_24.x)) {
            Cmid_27 = (((C_24.z - C_24.x) * tmpvar_23) / (C_24.y - C_24.x));
            Cmax_28 = tmpvar_23;
          } else {
            Cmid_27 = 0.0;
            Cmax_28 = 0.0;
          };
          C_24.x = 0.0;
          C_24.z = Cmid_27;
          C_24.y = Cmax_28;
        } else {
          float Cmid_29;
          Cmid_29 = C_24.x;
          float Cmax_30;
          Cmax_30 = C_24.y;
          if ((C_24.y > C_24.z)) {
            Cmid_29 = (((C_24.x - C_24.z) * tmpvar_23) / (C_24.y - C_24.z));
            Cmax_30 = tmpvar_23;
          } else {
            Cmid_29 = 0.0;
            Cmax_30 = 0.0;
          };
          C_24.z = 0.0;
          C_24.x = Cmid_29;
          C_24.y = Cmax_30;
        };
      };
    } else {
      if ((C_24.x <= C_24.z)) {
        float Cmid_31;
        Cmid_31 = C_24.x;
        float Cmax_32;
        Cmax_32 = C_24.z;
        if ((C_24.z > C_24.y)) {
          Cmid_31 = (((C_24.x - C_24.y) * tmpvar_23) / (C_24.z - C_24.y));
          Cmax_32 = tmpvar_23;
        } else {
          Cmid_31 = 0.0;
          Cmax_32 = 0.0;
        };
        C_24.y = 0.0;
        C_24.x = Cmid_31;
        C_24.z = Cmax_32;
      } else {
        if ((C_24.y <= C_24.z)) {
          float Cmid_33;
          Cmid_33 = C_24.z;
          float Cmax_34;
          Cmax_34 = C_24.x;
          if ((C_24.x > C_24.y)) {
            Cmid_33 = (((C_24.z - C_24.y) * tmpvar_23) / (C_24.x - C_24.y));
            Cmax_34 = tmpvar_23;
          } else {
            Cmid_33 = 0.0;
            Cmax_34 = 0.0;
          };
          C_24.y = 0.0;
          C_24.z = Cmid_33;
          C_24.x = Cmax_34;
        } else {
          float Cmid_35;
          Cmid_35 = C_24.y;
          float Cmax_36;
          Cmax_36 = C_24.x;
          if ((C_24.x > C_24.z)) {
            Cmid_35 = (((C_24.y - C_24.z) * tmpvar_23) / (C_24.x - C_24.z));
            Cmax_36 = tmpvar_23;
          } else {
            Cmid_35 = 0.0;
            Cmax_36 = 0.0;
          };
          C_24.z = 0.0;
          C_24.y = Cmid_35;
          C_24.x = Cmax_36;
        };
      };
    };
    vec3 C_37;
    C_37 = (C_24 + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (C_24, vec3(0.3, 0.59, 0.11))));
    float tmpvar_38;
    tmpvar_38 = dot (C_37, vec3(0.3, 0.59, 0.11));
    float tmpvar_39;
    tmpvar_39 = min (C_37.x, min (C_37.y, C_37.z));
    float tmpvar_40;
    tmpvar_40 = max (C_37.x, max (C_37.y, C_37.z));
    if ((tmpvar_39 < 0.0)) {
      C_37 = (tmpvar_38 + ((
        (C_37 - tmpvar_38)
       * tmpvar_38) / (tmpvar_38 - tmpvar_39)));
    };
    if ((tmpvar_40 > 1.0)) {
      C_37 = (tmpvar_38 + ((
        (C_37 - tmpvar_38)
       * 
        (1.0 - tmpvar_38)
      ) / (tmpvar_40 - tmpvar_38)));
    };
    result_1.xyz = C_37;
    tmpvar_7 = bool(1);
  };
  if ((13 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    vec3 Cb_41;
    Cb_41 = Cb_3.xyz;
    float tmpvar_42;
    tmpvar_42 = (max (Cs_2.x, max (Cs_2.y, Cs_2.z)) - min (Cs_2.x, min (Cs_2.y, Cs_2.z)));
    vec3 C_43;
    C_43 = Cb_41;
    if ((Cb_3.x <= Cb_3.y)) {
      if ((Cb_3.y <= Cb_3.z)) {
        float Cmid_44;
        Cmid_44 = Cb_41.y;
        float Cmax_45;
        Cmax_45 = Cb_41.z;
        if ((Cb_3.z > Cb_3.x)) {
          Cmid_44 = (((Cb_3.y - Cb_3.x) * tmpvar_42) / (Cb_3.z - Cb_3.x));
          Cmax_45 = tmpvar_42;
        } else {
          Cmid_44 = 0.0;
          Cmax_45 = 0.0;
        };
        C_43.x = 0.0;
        C_43.y = Cmid_44;
        C_43.z = Cmax_45;
      } else {
        if ((C_43.x <= C_43.z)) {
          float Cmid_46;
          Cmid_46 = C_43.z;
          float Cmax_47;
          Cmax_47 = C_43.y;
          if ((C_43.y > C_43.x)) {
            Cmid_46 = (((C_43.z - C_43.x) * tmpvar_42) / (C_43.y - C_43.x));
            Cmax_47 = tmpvar_42;
          } else {
            Cmid_46 = 0.0;
            Cmax_47 = 0.0;
          };
          C_43.x = 0.0;
          C_43.z = Cmid_46;
          C_43.y = Cmax_47;
        } else {
          float Cmid_48;
          Cmid_48 = C_43.x;
          float Cmax_49;
          Cmax_49 = C_43.y;
          if ((C_43.y > C_43.z)) {
            Cmid_48 = (((C_43.x - C_43.z) * tmpvar_42) / (C_43.y - C_43.z));
            Cmax_49 = tmpvar_42;
          } else {
            Cmid_48 = 0.0;
            Cmax_49 = 0.0;
          };
          C_43.z = 0.0;
          C_43.x = Cmid_48;
          C_43.y = Cmax_49;
        };
      };
    } else {
      if ((C_43.x <= C_43.z)) {
        float Cmid_50;
        Cmid_50 = C_43.x;
        float Cmax_51;
        Cmax_51 = C_43.z;
        if ((C_43.z > C_43.y)) {
          Cmid_50 = (((C_43.x - C_43.y) * tmpvar_42) / (C_43.z - C_43.y));
          Cmax_51 = tmpvar_42;
        } else {
          Cmid_50 = 0.0;
          Cmax_51 = 0.0;
        };
        C_43.y = 0.0;
        C_43.x = Cmid_50;
        C_43.z = Cmax_51;
      } else {
        if ((C_43.y <= C_43.z)) {
          float Cmid_52;
          Cmid_52 = C_43.z;
          float Cmax_53;
          Cmax_53 = C_43.x;
          if ((C_43.x > C_43.y)) {
            Cmid_52 = (((C_43.z - C_43.y) * tmpvar_42) / (C_43.x - C_43.y));
            Cmax_53 = tmpvar_42;
          } else {
            Cmid_52 = 0.0;
            Cmax_53 = 0.0;
          };
          C_43.y = 0.0;
          C_43.z = Cmid_52;
          C_43.x = Cmax_53;
        } else {
          float Cmid_54;
          Cmid_54 = C_43.y;
          float Cmax_55;
          Cmax_55 = C_43.x;
          if ((C_43.x > C_43.z)) {
            Cmid_54 = (((C_43.y - C_43.z) * tmpvar_42) / (C_43.x - C_43.z));
            Cmax_55 = tmpvar_42;
          } else {
            Cmid_54 = 0.0;
            Cmax_55 = 0.0;
          };
          C_43.z = 0.0;
          C_43.y = Cmid_54;
          C_43.x = Cmax_55;
        };
      };
    };
    vec3 C_56;
    C_56 = (C_43 + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (C_43, vec3(0.3, 0.59, 0.11))));
    float tmpvar_57;
    tmpvar_57 = dot (C_56, vec3(0.3, 0.59, 0.11));
    float tmpvar_58;
    tmpvar_58 = min (C_56.x, min (C_56.y, C_56.z));
    float tmpvar_59;
    tmpvar_59 = max (C_56.x, max (C_56.y, C_56.z));
    if ((tmpvar_58 < 0.0)) {
      C_56 = (tmpvar_57 + ((
        (C_56 - tmpvar_57)
       * tmpvar_57) / (tmpvar_57 - tmpvar_58)));
    };
    if ((tmpvar_59 > 1.0)) {
      C_56 = (tmpvar_57 + ((
        (C_56 - tmpvar_57)
       * 
        (1.0 - tmpvar_57)
      ) / (tmpvar_59 - tmpvar_57)));
    };
    result_1.xyz = C_56;
    tmpvar_7 = bool(1);
  };
  if ((14 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    vec3 C_60;
    C_60 = (Cs_2.xyz + (dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cs_2.xyz, vec3(0.3, 0.59, 0.11))));
    float tmpvar_61;
    tmpvar_61 = dot (C_60, vec3(0.3, 0.59, 0.11));
    float tmpvar_62;
    tmpvar_62 = min (C_60.x, min (C_60.y, C_60.z));
    float tmpvar_63;
    tmpvar_63 = max (C_60.x, max (C_60.y, C_60.z));
    if ((tmpvar_62 < 0.0)) {
      C_60 = (tmpvar_61 + ((
        (C_60 - tmpvar_61)
       * tmpvar_61) / (tmpvar_61 - tmpvar_62)));
    };
    if ((tmpvar_63 > 1.0)) {
      C_60 = (tmpvar_61 + ((
        (C_60 - tmpvar_61)
       * 
        (1.0 - tmpvar_61)
      ) / (tmpvar_63 - tmpvar_61)));
    };
    result_1.xyz = C_60;
    tmpvar_7 = bool(1);
  };
  if ((15 == flat_varying_ivec4_0.x)) tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    vec3 C_64;
    C_64 = (Cb_3.xyz + (dot (Cs_2.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cb_3.xyz, vec3(0.3, 0.59, 0.11))));
    float tmpvar_65;
    tmpvar_65 = dot (C_64, vec3(0.3, 0.59, 0.11));
    float tmpvar_66;
    tmpvar_66 = min (C_64.x, min (C_64.y, C_64.z));
    float tmpvar_67;
    tmpvar_67 = max (C_64.x, max (C_64.y, C_64.z));
    if ((tmpvar_66 < 0.0)) {
      C_64 = (tmpvar_65 + ((
        (C_64 - tmpvar_65)
       * tmpvar_65) / (tmpvar_65 - tmpvar_66)));
    };
    if ((tmpvar_67 > 1.0)) {
      C_64 = (tmpvar_65 + ((
        (C_64 - tmpvar_65)
       * 
        (1.0 - tmpvar_65)
      ) / (tmpvar_67 - tmpvar_65)));
    };
    result_1.xyz = C_64;
    tmpvar_7 = bool(1);
  };
  tmpvar_6 = bool(1);
  if (tmpvar_7) tmpvar_6 = bool(0);
  if (tmpvar_6) {
    tmpvar_7 = bool(1);
  };
  result_1.xyz = (((1.0 - tmpvar_4.w) * Cs_2.xyz) + (tmpvar_4.w * result_1.xyz));
  result_1.w = Cs_2.w;
  result_1.xyz = (result_1.xyz * tmpvar_5.w);
  oFragColor = result_1;
}

