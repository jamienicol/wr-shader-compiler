#version 310 es
precision highp float;
precision highp sampler2DArray;
out lowp vec4 oFragColor;
uniform sampler2DArray sPrevPassAlpha;
uniform sampler2DArray sPrevPassColor;
flat in vec4 vClipMaskUvBounds;
in vec4 vClipMaskUv;
flat in highp ivec4 flat_varying_ivec4_0;
in vec4 varying_vec4_0;
in vec4 varying_vec4_1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 result_2;
  lowp vec4 Cs_3;
  lowp vec4 Cb_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = textureLod (sPrevPassColor, varying_vec4_1.xyw, 0.0);
  Cb_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
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
  bool tmpvar_8;
  tmpvar_8 = bool(0);
  if ((1 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    result_2.xyz = (Cb_4.xyz * Cs_3.xyz);
    tmpvar_8 = bool(1);
  };
  if ((2 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    result_2.xyz = ((Cb_4.xyz + Cs_3.xyz) - (Cb_4.xyz * Cs_3.xyz));
    tmpvar_8 = bool(1);
  };
  if ((3 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    lowp vec3 Cs_9;
    Cs_9 = ((2.0 * Cb_4.xyz) - 1.0);
    result_2.xyz = mix ((Cs_3.xyz * (2.0 * Cb_4.xyz)), ((Cs_3.xyz + Cs_9) - (Cs_3.xyz * Cs_9)), vec3(greaterThanEqual (Cb_4.xyz, vec3(0.5, 0.5, 0.5))));
    tmpvar_8 = bool(1);
  };
  if ((4 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    result_2.xyz = min (Cs_3.xyz, Cb_4.xyz);
    tmpvar_8 = bool(1);
  };
  if ((5 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    result_2.xyz = max (Cs_3.xyz, Cb_4.xyz);
    tmpvar_8 = bool(1);
  };
  if ((6 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    lowp float tmpvar_10;
    if ((Cb_4.x == 0.0)) {
      tmpvar_10 = 0.0;
    } else {
      if ((Cs_3.x == 1.0)) {
        tmpvar_10 = 1.0;
      } else {
        tmpvar_10 = min (1.0, (Cb_4.x / (1.0 - Cs_3.x)));
      };
    };
    result_2.x = tmpvar_10;
    lowp float tmpvar_11;
    if ((Cb_4.y == 0.0)) {
      tmpvar_11 = 0.0;
    } else {
      if ((Cs_3.y == 1.0)) {
        tmpvar_11 = 1.0;
      } else {
        tmpvar_11 = min (1.0, (Cb_4.y / (1.0 - Cs_3.y)));
      };
    };
    result_2.y = tmpvar_11;
    lowp float tmpvar_12;
    if ((Cb_4.z == 0.0)) {
      tmpvar_12 = 0.0;
    } else {
      if ((Cs_3.z == 1.0)) {
        tmpvar_12 = 1.0;
      } else {
        tmpvar_12 = min (1.0, (Cb_4.z / (1.0 - Cs_3.z)));
      };
    };
    result_2.z = tmpvar_12;
    tmpvar_8 = bool(1);
  };
  if ((7 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    lowp float tmpvar_13;
    if ((Cb_4.x == 1.0)) {
      tmpvar_13 = 1.0;
    } else {
      if ((Cs_3.x == 0.0)) {
        tmpvar_13 = 0.0;
      } else {
        tmpvar_13 = (1.0 - min (1.0, (
          (1.0 - Cb_4.x)
         / Cs_3.x)));
      };
    };
    result_2.x = tmpvar_13;
    lowp float tmpvar_14;
    if ((Cb_4.y == 1.0)) {
      tmpvar_14 = 1.0;
    } else {
      if ((Cs_3.y == 0.0)) {
        tmpvar_14 = 0.0;
      } else {
        tmpvar_14 = (1.0 - min (1.0, (
          (1.0 - Cb_4.y)
         / Cs_3.y)));
      };
    };
    result_2.y = tmpvar_14;
    lowp float tmpvar_15;
    if ((Cb_4.z == 1.0)) {
      tmpvar_15 = 1.0;
    } else {
      if ((Cs_3.z == 0.0)) {
        tmpvar_15 = 0.0;
      } else {
        tmpvar_15 = (1.0 - min (1.0, (
          (1.0 - Cb_4.z)
         / Cs_3.z)));
      };
    };
    result_2.z = tmpvar_15;
    tmpvar_8 = bool(1);
  };
  if ((8 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    lowp vec3 Cs_16;
    Cs_16 = ((2.0 * Cs_3.xyz) - 1.0);
    result_2.xyz = mix ((Cb_4.xyz * (2.0 * Cs_3.xyz)), ((Cb_4.xyz + Cs_16) - (Cb_4.xyz * Cs_16)), vec3(greaterThanEqual (Cs_3.xyz, vec3(0.5, 0.5, 0.5))));
    tmpvar_8 = bool(1);
  };
  if ((9 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    lowp float tmpvar_17;
    if ((Cs_3.x <= 0.5)) {
      tmpvar_17 = (Cb_4.x - ((
        (1.0 - (2.0 * Cs_3.x))
       * Cb_4.x) * (1.0 - Cb_4.x)));
    } else {
      lowp float D_18;
      if ((Cb_4.x <= 0.25)) {
        D_18 = (((
          ((16.0 * Cb_4.x) - 12.0)
         * Cb_4.x) + 4.0) * Cb_4.x);
      } else {
        D_18 = sqrt(Cb_4.x);
      };
      tmpvar_17 = (Cb_4.x + ((
        (2.0 * Cs_3.x)
       - 1.0) * (D_18 - Cb_4.x)));
    };
    result_2.x = tmpvar_17;
    lowp float tmpvar_19;
    if ((Cs_3.y <= 0.5)) {
      tmpvar_19 = (Cb_4.y - ((
        (1.0 - (2.0 * Cs_3.y))
       * Cb_4.y) * (1.0 - Cb_4.y)));
    } else {
      lowp float D_20;
      if ((Cb_4.y <= 0.25)) {
        D_20 = (((
          ((16.0 * Cb_4.y) - 12.0)
         * Cb_4.y) + 4.0) * Cb_4.y);
      } else {
        D_20 = sqrt(Cb_4.y);
      };
      tmpvar_19 = (Cb_4.y + ((
        (2.0 * Cs_3.y)
       - 1.0) * (D_20 - Cb_4.y)));
    };
    result_2.y = tmpvar_19;
    lowp float tmpvar_21;
    if ((Cs_3.z <= 0.5)) {
      tmpvar_21 = (Cb_4.z - ((
        (1.0 - (2.0 * Cs_3.z))
       * Cb_4.z) * (1.0 - Cb_4.z)));
    } else {
      lowp float D_22;
      if ((Cb_4.z <= 0.25)) {
        D_22 = (((
          ((16.0 * Cb_4.z) - 12.0)
         * Cb_4.z) + 4.0) * Cb_4.z);
      } else {
        D_22 = sqrt(Cb_4.z);
      };
      tmpvar_21 = (Cb_4.z + ((
        (2.0 * Cs_3.z)
       - 1.0) * (D_22 - Cb_4.z)));
    };
    result_2.z = tmpvar_21;
    tmpvar_8 = bool(1);
  };
  if ((10 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    result_2.xyz = abs((Cb_4.xyz - Cs_3.xyz));
    tmpvar_8 = bool(1);
  };
  if ((11 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    result_2.xyz = ((Cb_4.xyz + Cs_3.xyz) - ((2.0 * Cb_4.xyz) * Cs_3.xyz));
    tmpvar_8 = bool(1);
  };
  if ((12 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    lowp vec3 Cs_23;
    Cs_23 = Cs_3.xyz;
    lowp float tmpvar_24;
    tmpvar_24 = (max (Cb_4.x, max (Cb_4.y, Cb_4.z)) - min (Cb_4.x, min (Cb_4.y, Cb_4.z)));
    lowp vec3 C_25;
    C_25 = Cs_23;
    if ((Cs_3.x <= Cs_3.y)) {
      if ((Cs_3.y <= Cs_3.z)) {
        lowp float Cmid_26;
        Cmid_26 = Cs_23.y;
        lowp float Cmax_27;
        Cmax_27 = Cs_23.z;
        if ((Cs_3.z > Cs_3.x)) {
          Cmid_26 = (((Cs_3.y - Cs_3.x) * tmpvar_24) / (Cs_3.z - Cs_3.x));
          Cmax_27 = tmpvar_24;
        } else {
          Cmid_26 = 0.0;
          Cmax_27 = 0.0;
        };
        C_25.x = 0.0;
        C_25.y = Cmid_26;
        C_25.z = Cmax_27;
      } else {
        if ((C_25.x <= C_25.z)) {
          lowp float Cmid_28;
          Cmid_28 = C_25.z;
          lowp float Cmax_29;
          Cmax_29 = C_25.y;
          if ((C_25.y > C_25.x)) {
            Cmid_28 = (((C_25.z - C_25.x) * tmpvar_24) / (C_25.y - C_25.x));
            Cmax_29 = tmpvar_24;
          } else {
            Cmid_28 = 0.0;
            Cmax_29 = 0.0;
          };
          C_25.x = 0.0;
          C_25.z = Cmid_28;
          C_25.y = Cmax_29;
        } else {
          lowp float Cmid_30;
          Cmid_30 = C_25.x;
          lowp float Cmax_31;
          Cmax_31 = C_25.y;
          if ((C_25.y > C_25.z)) {
            Cmid_30 = (((C_25.x - C_25.z) * tmpvar_24) / (C_25.y - C_25.z));
            Cmax_31 = tmpvar_24;
          } else {
            Cmid_30 = 0.0;
            Cmax_31 = 0.0;
          };
          C_25.z = 0.0;
          C_25.x = Cmid_30;
          C_25.y = Cmax_31;
        };
      };
    } else {
      if ((C_25.x <= C_25.z)) {
        lowp float Cmid_32;
        Cmid_32 = C_25.x;
        lowp float Cmax_33;
        Cmax_33 = C_25.z;
        if ((C_25.z > C_25.y)) {
          Cmid_32 = (((C_25.x - C_25.y) * tmpvar_24) / (C_25.z - C_25.y));
          Cmax_33 = tmpvar_24;
        } else {
          Cmid_32 = 0.0;
          Cmax_33 = 0.0;
        };
        C_25.y = 0.0;
        C_25.x = Cmid_32;
        C_25.z = Cmax_33;
      } else {
        if ((C_25.y <= C_25.z)) {
          lowp float Cmid_34;
          Cmid_34 = C_25.z;
          lowp float Cmax_35;
          Cmax_35 = C_25.x;
          if ((C_25.x > C_25.y)) {
            Cmid_34 = (((C_25.z - C_25.y) * tmpvar_24) / (C_25.x - C_25.y));
            Cmax_35 = tmpvar_24;
          } else {
            Cmid_34 = 0.0;
            Cmax_35 = 0.0;
          };
          C_25.y = 0.0;
          C_25.z = Cmid_34;
          C_25.x = Cmax_35;
        } else {
          lowp float Cmid_36;
          Cmid_36 = C_25.y;
          lowp float Cmax_37;
          Cmax_37 = C_25.x;
          if ((C_25.x > C_25.z)) {
            Cmid_36 = (((C_25.y - C_25.z) * tmpvar_24) / (C_25.x - C_25.z));
            Cmax_37 = tmpvar_24;
          } else {
            Cmid_36 = 0.0;
            Cmax_37 = 0.0;
          };
          C_25.z = 0.0;
          C_25.y = Cmid_36;
          C_25.x = Cmax_37;
        };
      };
    };
    lowp vec3 C_38;
    C_38 = (C_25 + (dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (C_25, vec3(0.3, 0.59, 0.11))));
    lowp float tmpvar_39;
    tmpvar_39 = dot (C_38, vec3(0.3, 0.59, 0.11));
    lowp float tmpvar_40;
    tmpvar_40 = min (C_38.x, min (C_38.y, C_38.z));
    lowp float tmpvar_41;
    tmpvar_41 = max (C_38.x, max (C_38.y, C_38.z));
    if ((tmpvar_40 < 0.0)) {
      C_38 = (tmpvar_39 + ((
        (C_38 - tmpvar_39)
       * tmpvar_39) / (tmpvar_39 - tmpvar_40)));
    };
    if ((tmpvar_41 > 1.0)) {
      C_38 = (tmpvar_39 + ((
        (C_38 - tmpvar_39)
       * 
        (1.0 - tmpvar_39)
      ) / (tmpvar_41 - tmpvar_39)));
    };
    result_2.xyz = C_38;
    tmpvar_8 = bool(1);
  };
  if ((13 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    lowp vec3 Cb_42;
    Cb_42 = Cb_4.xyz;
    lowp float tmpvar_43;
    tmpvar_43 = (max (Cs_3.x, max (Cs_3.y, Cs_3.z)) - min (Cs_3.x, min (Cs_3.y, Cs_3.z)));
    lowp vec3 C_44;
    C_44 = Cb_42;
    if ((Cb_4.x <= Cb_4.y)) {
      if ((Cb_4.y <= Cb_4.z)) {
        lowp float Cmid_45;
        Cmid_45 = Cb_42.y;
        lowp float Cmax_46;
        Cmax_46 = Cb_42.z;
        if ((Cb_4.z > Cb_4.x)) {
          Cmid_45 = (((Cb_4.y - Cb_4.x) * tmpvar_43) / (Cb_4.z - Cb_4.x));
          Cmax_46 = tmpvar_43;
        } else {
          Cmid_45 = 0.0;
          Cmax_46 = 0.0;
        };
        C_44.x = 0.0;
        C_44.y = Cmid_45;
        C_44.z = Cmax_46;
      } else {
        if ((C_44.x <= C_44.z)) {
          lowp float Cmid_47;
          Cmid_47 = C_44.z;
          lowp float Cmax_48;
          Cmax_48 = C_44.y;
          if ((C_44.y > C_44.x)) {
            Cmid_47 = (((C_44.z - C_44.x) * tmpvar_43) / (C_44.y - C_44.x));
            Cmax_48 = tmpvar_43;
          } else {
            Cmid_47 = 0.0;
            Cmax_48 = 0.0;
          };
          C_44.x = 0.0;
          C_44.z = Cmid_47;
          C_44.y = Cmax_48;
        } else {
          lowp float Cmid_49;
          Cmid_49 = C_44.x;
          lowp float Cmax_50;
          Cmax_50 = C_44.y;
          if ((C_44.y > C_44.z)) {
            Cmid_49 = (((C_44.x - C_44.z) * tmpvar_43) / (C_44.y - C_44.z));
            Cmax_50 = tmpvar_43;
          } else {
            Cmid_49 = 0.0;
            Cmax_50 = 0.0;
          };
          C_44.z = 0.0;
          C_44.x = Cmid_49;
          C_44.y = Cmax_50;
        };
      };
    } else {
      if ((C_44.x <= C_44.z)) {
        lowp float Cmid_51;
        Cmid_51 = C_44.x;
        lowp float Cmax_52;
        Cmax_52 = C_44.z;
        if ((C_44.z > C_44.y)) {
          Cmid_51 = (((C_44.x - C_44.y) * tmpvar_43) / (C_44.z - C_44.y));
          Cmax_52 = tmpvar_43;
        } else {
          Cmid_51 = 0.0;
          Cmax_52 = 0.0;
        };
        C_44.y = 0.0;
        C_44.x = Cmid_51;
        C_44.z = Cmax_52;
      } else {
        if ((C_44.y <= C_44.z)) {
          lowp float Cmid_53;
          Cmid_53 = C_44.z;
          lowp float Cmax_54;
          Cmax_54 = C_44.x;
          if ((C_44.x > C_44.y)) {
            Cmid_53 = (((C_44.z - C_44.y) * tmpvar_43) / (C_44.x - C_44.y));
            Cmax_54 = tmpvar_43;
          } else {
            Cmid_53 = 0.0;
            Cmax_54 = 0.0;
          };
          C_44.y = 0.0;
          C_44.z = Cmid_53;
          C_44.x = Cmax_54;
        } else {
          lowp float Cmid_55;
          Cmid_55 = C_44.y;
          lowp float Cmax_56;
          Cmax_56 = C_44.x;
          if ((C_44.x > C_44.z)) {
            Cmid_55 = (((C_44.y - C_44.z) * tmpvar_43) / (C_44.x - C_44.z));
            Cmax_56 = tmpvar_43;
          } else {
            Cmid_55 = 0.0;
            Cmax_56 = 0.0;
          };
          C_44.z = 0.0;
          C_44.y = Cmid_55;
          C_44.x = Cmax_56;
        };
      };
    };
    lowp vec3 C_57;
    C_57 = (C_44 + (dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (C_44, vec3(0.3, 0.59, 0.11))));
    lowp float tmpvar_58;
    tmpvar_58 = dot (C_57, vec3(0.3, 0.59, 0.11));
    lowp float tmpvar_59;
    tmpvar_59 = min (C_57.x, min (C_57.y, C_57.z));
    lowp float tmpvar_60;
    tmpvar_60 = max (C_57.x, max (C_57.y, C_57.z));
    if ((tmpvar_59 < 0.0)) {
      C_57 = (tmpvar_58 + ((
        (C_57 - tmpvar_58)
       * tmpvar_58) / (tmpvar_58 - tmpvar_59)));
    };
    if ((tmpvar_60 > 1.0)) {
      C_57 = (tmpvar_58 + ((
        (C_57 - tmpvar_58)
       * 
        (1.0 - tmpvar_58)
      ) / (tmpvar_60 - tmpvar_58)));
    };
    result_2.xyz = C_57;
    tmpvar_8 = bool(1);
  };
  if ((14 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    lowp vec3 C_61;
    C_61 = (Cs_3.xyz + (dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cs_3.xyz, vec3(0.3, 0.59, 0.11))));
    lowp float tmpvar_62;
    tmpvar_62 = dot (C_61, vec3(0.3, 0.59, 0.11));
    lowp float tmpvar_63;
    tmpvar_63 = min (C_61.x, min (C_61.y, C_61.z));
    lowp float tmpvar_64;
    tmpvar_64 = max (C_61.x, max (C_61.y, C_61.z));
    if ((tmpvar_63 < 0.0)) {
      C_61 = (tmpvar_62 + ((
        (C_61 - tmpvar_62)
       * tmpvar_62) / (tmpvar_62 - tmpvar_63)));
    };
    if ((tmpvar_64 > 1.0)) {
      C_61 = (tmpvar_62 + ((
        (C_61 - tmpvar_62)
       * 
        (1.0 - tmpvar_62)
      ) / (tmpvar_64 - tmpvar_62)));
    };
    result_2.xyz = C_61;
    tmpvar_8 = bool(1);
  };
  if ((15 == flat_varying_ivec4_0.x)) tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    lowp vec3 C_65;
    C_65 = (Cb_4.xyz + (dot (Cs_3.xyz, vec3(0.3, 0.59, 0.11)) - dot (Cb_4.xyz, vec3(0.3, 0.59, 0.11))));
    lowp float tmpvar_66;
    tmpvar_66 = dot (C_65, vec3(0.3, 0.59, 0.11));
    lowp float tmpvar_67;
    tmpvar_67 = min (C_65.x, min (C_65.y, C_65.z));
    lowp float tmpvar_68;
    tmpvar_68 = max (C_65.x, max (C_65.y, C_65.z));
    if ((tmpvar_67 < 0.0)) {
      C_65 = (tmpvar_66 + ((
        (C_65 - tmpvar_66)
       * tmpvar_66) / (tmpvar_66 - tmpvar_67)));
    };
    if ((tmpvar_68 > 1.0)) {
      C_65 = (tmpvar_66 + ((
        (C_65 - tmpvar_66)
       * 
        (1.0 - tmpvar_66)
      ) / (tmpvar_68 - tmpvar_66)));
    };
    result_2.xyz = C_65;
    tmpvar_8 = bool(1);
  };
  tmpvar_7 = bool(1);
  if (tmpvar_8) tmpvar_7 = bool(0);
  if (tmpvar_7) {
    tmpvar_8 = bool(1);
  };
  result_2.xyz = (((1.0 - tmpvar_5.w) * Cs_3.xyz) + (tmpvar_5.w * result_2.xyz));
  result_2.w = Cs_3.w;
  result_2.xyz = (result_2.xyz * tmpvar_6.w);
  tmpvar_1 = result_2;
  highp float tmpvar_69;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_69 = 1.0;
  } else {
    highp vec2 tmpvar_70;
    tmpvar_70 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_71;
    tmpvar_71 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_70);
    bvec2 tmpvar_72;
    tmpvar_72 = greaterThan (vClipMaskUvBounds.zw, tmpvar_70);
    bool tmpvar_73;
    tmpvar_73 = ((tmpvar_71.x && tmpvar_71.y) && (tmpvar_72.x && tmpvar_72.y));
    if (!(tmpvar_73)) {
      tmpvar_69 = 0.0;
    } else {
      highp ivec3 tmpvar_74;
      tmpvar_74.xy = ivec2(tmpvar_70);
      tmpvar_74.z = int((vClipMaskUv.z + 0.5));
      highp vec4 tmpvar_75;
      tmpvar_75 = texelFetch (sPrevPassAlpha, tmpvar_74, 0);
      tmpvar_69 = tmpvar_75.x;
    };
  };
  tmpvar_1 = (result_2 * tmpvar_69);
  oFragColor = tmpvar_1;
}

