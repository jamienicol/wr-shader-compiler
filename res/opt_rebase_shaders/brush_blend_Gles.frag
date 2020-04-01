#version 300 es
precision highp float;
precision highp sampler2DArray;
out highp vec4 oFragColor;
uniform highp sampler2DArray sColor0;
uniform highp sampler2D sGpuCache;
flat in highp vec4 vTransformBounds;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_0;
flat in highp mat4 vColorMat;
flat in mediump int vFuncs[4];
void main ()
{
  highp vec3 color_1;
  highp float alpha_2;
  vec2 tmpvar_3;
  tmpvar_3 = (varying_vec4_0.zw * mix (gl_FragCoord.w, 1.0, flat_varying_vec4_4.y));
  vec3 tmpvar_4;
  tmpvar_4.xy = tmpvar_3;
  tmpvar_4.z = flat_varying_vec4_4.x;
  vec4 tmpvar_5;
  tmpvar_5 = texture (sColor0, tmpvar_4);
  alpha_2 = tmpvar_5.w;
  vec3 tmpvar_6;
  if ((tmpvar_5.w != 0.0)) {
    tmpvar_6 = (tmpvar_5.xyz / tmpvar_5.w);
  } else {
    tmpvar_6 = tmpvar_5.xyz;
  };
  color_1 = tmpvar_6;
  bool tmpvar_7;
  tmpvar_7 = bool(0);
  while (true) {
    tmpvar_7 = (tmpvar_7 || (0 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      color_1 = (((color_1 * flat_varying_vec4_4.z) - (0.5 * flat_varying_vec4_4.z)) + 0.5);
      break;
    };
    tmpvar_7 = (tmpvar_7 || (3 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      color_1 = mix (color_1, (vec3(1.0, 1.0, 1.0) - color_1), flat_varying_vec4_4.z);
      break;
    };
    tmpvar_7 = (tmpvar_7 || (6 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      color_1 = min (max ((color_1 * flat_varying_vec4_4.z), 0.0), 1.0);
      break;
    };
    tmpvar_7 = (tmpvar_7 || (8 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      color_1 = mix(pow ((
        (color_1 / 1.055)
       + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), (color_1 / 12.92), bvec3(greaterThanEqual (vec3(0.04045, 0.04045, 0.04045), color_1)));
      break;
    };
    tmpvar_7 = (tmpvar_7 || (9 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      color_1 = mix(((vec3(1.055, 1.055, 1.055) * 
        pow (color_1, vec3(0.4166667, 0.4166667, 0.4166667))
      ) - vec3(0.055, 0.055, 0.055)), (color_1 * 12.92), bvec3(greaterThanEqual (vec3(0.0031308, 0.0031308, 0.0031308), color_1)));
      break;
    };
    tmpvar_7 = (tmpvar_7 || (11 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      vec4 tmpvar_8;
      tmpvar_8.xyz = color_1;
      tmpvar_8.w = alpha_2;
      highp vec4 tmpvar_9;
      tmpvar_9 = tmpvar_8;
      mediump int i_10;
      mediump int k_11;
      mediump int offset_12;
      offset_12 = 0;
      i_10 = 0;
      while (true) {
        if ((i_10 >= 4)) {
          break;
        };
        bool tmpvar_13;
        tmpvar_13 = bool(0);
        while (true) {
          int tmpvar_14;
          tmpvar_14 = vFuncs[i_10];
          tmpvar_13 = (tmpvar_13 || (0 == tmpvar_14));
          if (tmpvar_13) {
            break;
          };
          tmpvar_13 = (tmpvar_13 || (1 == tmpvar_14));
          tmpvar_13 = (tmpvar_13 || (2 == tmpvar_14));
          if (tmpvar_13) {
            k_11 = int(floor((tmpvar_9[i_10] * 255.0)));
            highp int tmpvar_15;
            tmpvar_15 = ((flat_varying_ivec4_0.y + offset_12) + (k_11 / 4));
            ivec2 tmpvar_16;
            tmpvar_16.x = int((uint(tmpvar_15) % 1024u));
            tmpvar_16.y = int((uint(tmpvar_15) / 1024u));
            vec4 tmpvar_17;
            tmpvar_17 = texelFetch (sGpuCache, tmpvar_16, 0);
            tmpvar_9[i_10] = min (max (tmpvar_17[(k_11 % 4)], 0.0), 1.0);
            offset_12 += 64;
            break;
          };
          tmpvar_13 = (tmpvar_13 || (3 == tmpvar_14));
          if (tmpvar_13) {
            highp int tmpvar_18;
            tmpvar_18 = (flat_varying_ivec4_0.y + offset_12);
            ivec2 tmpvar_19;
            tmpvar_19.x = int((uint(tmpvar_18) % 1024u));
            tmpvar_19.y = int((uint(tmpvar_18) / 1024u));
            vec4 tmpvar_20;
            tmpvar_20 = texelFetch (sGpuCache, tmpvar_19, 0);
            tmpvar_9[i_10] = min (max ((
              (tmpvar_20[0] * tmpvar_9[i_10])
             + tmpvar_20[1]), 0.0), 1.0);
            offset_12++;
            break;
          };
          tmpvar_13 = (tmpvar_13 || (4 == tmpvar_14));
          if (tmpvar_13) {
            highp int tmpvar_21;
            tmpvar_21 = (flat_varying_ivec4_0.y + offset_12);
            ivec2 tmpvar_22;
            tmpvar_22.x = int((uint(tmpvar_21) % 1024u));
            tmpvar_22.y = int((uint(tmpvar_21) / 1024u));
            vec4 tmpvar_23;
            tmpvar_23 = texelFetch (sGpuCache, tmpvar_22, 0);
            tmpvar_9[i_10] = min (max ((
              (tmpvar_23[0] * pow (tmpvar_9[i_10], tmpvar_23[1]))
             + tmpvar_23[2]), 0.0), 1.0);
            offset_12++;
            break;
          };
          tmpvar_13 = bool(1);
          break;
        };
        i_10++;
      };
      color_1 = tmpvar_9.xyz;
      alpha_2 = tmpvar_9.w;
      break;
    };
    tmpvar_7 = (tmpvar_7 || (10 == flat_varying_ivec4_0.x));
    if (tmpvar_7) {
      color_1 = flat_varying_vec4_1.xyz;
      alpha_2 = flat_varying_vec4_1.w;
      break;
    };
    tmpvar_7 = bool(1);
    vec4 tmpvar_24;
    tmpvar_24.xyz = color_1;
    tmpvar_24.w = alpha_2;
    vec4 tmpvar_25;
    tmpvar_25 = min (max ((
      (vColorMat * tmpvar_24)
     + flat_varying_vec4_3), 0.0), 1.0);
    color_1 = tmpvar_25.xyz;
    alpha_2 = tmpvar_25.w;
    break;
  };
  float tmpvar_26;
  vec2 tmpvar_27;
  tmpvar_27.x = float((tmpvar_3.x >= flat_varying_vec4_2.z));
  tmpvar_27.y = float((tmpvar_3.y >= flat_varying_vec4_2.w));
  vec2 tmpvar_28;
  tmpvar_28 = (vec2(greaterThanEqual (tmpvar_3, flat_varying_vec4_2.xy)) - tmpvar_27);
  tmpvar_26 = (tmpvar_28.x * tmpvar_28.y);
  vec2 tmpvar_29;
  tmpvar_29 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_30;
  tmpvar_30 = max (vec2(0.0, 0.0), tmpvar_29);
  vec2 tmpvar_31;
  tmpvar_31 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_32;
  float tmpvar_33;
  tmpvar_33 = ((0.5 * (
    sqrt(dot (tmpvar_30, tmpvar_30))
   + 
    min (0.0, max (tmpvar_29.x, tmpvar_29.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_31, tmpvar_31)
  )));
  if ((-0.4999 >= tmpvar_33)) {
    tmpvar_32 = 1.0;
  } else {
    if ((tmpvar_33 >= 0.4999)) {
      tmpvar_32 = 0.0;
    } else {
      tmpvar_32 = (0.5 + (tmpvar_33 * (
        ((0.8431027 * tmpvar_33) * tmpvar_33)
       - 1.144536)));
    };
  };
  alpha_2 = (alpha_2 * min (tmpvar_26, tmpvar_32));
  vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = color_1;
  oFragColor = (alpha_2 * tmpvar_34);
}

