#version 150
precision highp float;
out vec4 oFragColor;
uniform sampler2DArray sColor0;
uniform sampler2D sGpuCache;
flat in vec4 vTransformBounds;
uniform sampler2DArray sPrevPassAlpha;
flat in vec4 vClipMaskUvBounds;
in vec4 vClipMaskUv;
flat in vec4 flat_varying_vec4_1;
flat in vec4 flat_varying_vec4_2;
flat in vec4 flat_varying_vec4_3;
flat in vec4 flat_varying_vec4_4;
flat in ivec4 flat_varying_ivec4_0;
in vec4 varying_vec4_0;
flat in mat4 vColorMat;
flat in int vFuncs[4];
void main ()
{
  vec4 frag_color_1;
  vec3 color_2;
  float alpha_3;
  vec2 tmpvar_4;
  tmpvar_4 = (varying_vec4_0.zw * mix (gl_FragCoord.w, 1.0, flat_varying_vec4_4.y));
  vec3 tmpvar_5;
  tmpvar_5.xy = tmpvar_4;
  tmpvar_5.z = flat_varying_vec4_4.x;
  vec4 tmpvar_6;
  tmpvar_6 = texture (sColor0, tmpvar_5);
  alpha_3 = tmpvar_6.w;
  vec3 tmpvar_7;
  if ((tmpvar_6.w != 0.0)) {
    tmpvar_7 = (tmpvar_6.xyz / tmpvar_6.w);
  } else {
    tmpvar_7 = tmpvar_6.xyz;
  };
  color_2 = tmpvar_7;
  bool tmpvar_8;
  tmpvar_8 = bool(0);
  while (true) {
    tmpvar_8 = (tmpvar_8 || (0 == flat_varying_ivec4_0.x));
    if (tmpvar_8) {
      color_2 = (((color_2 * flat_varying_vec4_4.z) - (0.5 * flat_varying_vec4_4.z)) + 0.5);
      break;
    };
    tmpvar_8 = (tmpvar_8 || (3 == flat_varying_ivec4_0.x));
    if (tmpvar_8) {
      color_2 = mix (color_2, (vec3(1.0, 1.0, 1.0) - color_2), flat_varying_vec4_4.z);
      break;
    };
    tmpvar_8 = (tmpvar_8 || (6 == flat_varying_ivec4_0.x));
    if (tmpvar_8) {
      color_2 = min (max ((color_2 * flat_varying_vec4_4.z), 0.0), 1.0);
      break;
    };
    tmpvar_8 = (tmpvar_8 || (8 == flat_varying_ivec4_0.x));
    if (tmpvar_8) {
      color_2 = mix(pow ((
        (color_2 / 1.055)
       + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), (color_2 / 12.92), bvec3(greaterThanEqual (vec3(0.04045, 0.04045, 0.04045), color_2)));
      break;
    };
    tmpvar_8 = (tmpvar_8 || (9 == flat_varying_ivec4_0.x));
    if (tmpvar_8) {
      color_2 = mix(((vec3(1.055, 1.055, 1.055) * 
        pow (color_2, vec3(0.4166667, 0.4166667, 0.4166667))
      ) - vec3(0.055, 0.055, 0.055)), (color_2 * 12.92), bvec3(greaterThanEqual (vec3(0.0031308, 0.0031308, 0.0031308), color_2)));
      break;
    };
    tmpvar_8 = (tmpvar_8 || (11 == flat_varying_ivec4_0.x));
    if (tmpvar_8) {
      vec4 tmpvar_9;
      tmpvar_9.xyz = color_2;
      tmpvar_9.w = alpha_3;
      vec4 tmpvar_10;
      tmpvar_10 = tmpvar_9;
      int i_11;
      int k_12;
      int offset_13;
      offset_13 = 0;
      i_11 = 0;
      while (true) {
        if ((i_11 >= 4)) {
          break;
        };
        bool tmpvar_14;
        tmpvar_14 = bool(0);
        while (true) {
          int tmpvar_15;
          tmpvar_15 = vFuncs[i_11];
          tmpvar_14 = (tmpvar_14 || (0 == tmpvar_15));
          if (tmpvar_14) {
            break;
          };
          tmpvar_14 = (tmpvar_14 || (1 == tmpvar_15));
          tmpvar_14 = (tmpvar_14 || (2 == tmpvar_15));
          if (tmpvar_14) {
            k_12 = int(floor((tmpvar_10[i_11] * 255.0)));
            int tmpvar_16;
            tmpvar_16 = ((flat_varying_ivec4_0.y + offset_13) + (k_12 / 4));
            ivec2 tmpvar_17;
            tmpvar_17.x = int((uint(tmpvar_16) % 1024u));
            tmpvar_17.y = int((uint(tmpvar_16) / 1024u));
            vec4 tmpvar_18;
            tmpvar_18 = texelFetch (sGpuCache, tmpvar_17, 0);
            tmpvar_10[i_11] = min (max (tmpvar_18[(k_12 % 4)], 0.0), 1.0);
            offset_13 += 64;
            break;
          };
          tmpvar_14 = (tmpvar_14 || (3 == tmpvar_15));
          if (tmpvar_14) {
            int tmpvar_19;
            tmpvar_19 = (flat_varying_ivec4_0.y + offset_13);
            ivec2 tmpvar_20;
            tmpvar_20.x = int((uint(tmpvar_19) % 1024u));
            tmpvar_20.y = int((uint(tmpvar_19) / 1024u));
            vec4 tmpvar_21;
            tmpvar_21 = texelFetch (sGpuCache, tmpvar_20, 0);
            tmpvar_10[i_11] = min (max ((
              (tmpvar_21[0] * tmpvar_10[i_11])
             + tmpvar_21[1]), 0.0), 1.0);
            offset_13++;
            break;
          };
          tmpvar_14 = (tmpvar_14 || (4 == tmpvar_15));
          if (tmpvar_14) {
            int tmpvar_22;
            tmpvar_22 = (flat_varying_ivec4_0.y + offset_13);
            ivec2 tmpvar_23;
            tmpvar_23.x = int((uint(tmpvar_22) % 1024u));
            tmpvar_23.y = int((uint(tmpvar_22) / 1024u));
            vec4 tmpvar_24;
            tmpvar_24 = texelFetch (sGpuCache, tmpvar_23, 0);
            tmpvar_10[i_11] = min (max ((
              (tmpvar_24[0] * pow (tmpvar_10[i_11], tmpvar_24[1]))
             + tmpvar_24[2]), 0.0), 1.0);
            offset_13++;
            break;
          };
          tmpvar_14 = bool(1);
          break;
        };
        i_11++;
      };
      color_2 = tmpvar_10.xyz;
      alpha_3 = tmpvar_10.w;
      break;
    };
    tmpvar_8 = (tmpvar_8 || (10 == flat_varying_ivec4_0.x));
    if (tmpvar_8) {
      color_2 = flat_varying_vec4_1.xyz;
      alpha_3 = flat_varying_vec4_1.w;
      break;
    };
    tmpvar_8 = bool(1);
    vec4 tmpvar_25;
    tmpvar_25.xyz = color_2;
    tmpvar_25.w = alpha_3;
    vec4 tmpvar_26;
    tmpvar_26 = min (max ((
      (vColorMat * tmpvar_25)
     + flat_varying_vec4_3), 0.0), 1.0);
    color_2 = tmpvar_26.xyz;
    alpha_3 = tmpvar_26.w;
    break;
  };
  float tmpvar_27;
  vec2 tmpvar_28;
  tmpvar_28.x = float((tmpvar_4.x >= flat_varying_vec4_2.z));
  tmpvar_28.y = float((tmpvar_4.y >= flat_varying_vec4_2.w));
  vec2 tmpvar_29;
  tmpvar_29 = (vec2(greaterThanEqual (tmpvar_4, flat_varying_vec4_2.xy)) - tmpvar_28);
  tmpvar_27 = (tmpvar_29.x * tmpvar_29.y);
  vec2 tmpvar_30;
  tmpvar_30 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_31;
  tmpvar_31 = max (vec2(0.0, 0.0), tmpvar_30);
  vec2 tmpvar_32;
  tmpvar_32 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_33;
  float tmpvar_34;
  tmpvar_34 = ((0.5 * (
    sqrt(dot (tmpvar_31, tmpvar_31))
   + 
    min (0.0, max (tmpvar_30.x, tmpvar_30.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_32, tmpvar_32)
  )));
  if ((-0.4999 >= tmpvar_34)) {
    tmpvar_33 = 1.0;
  } else {
    if ((tmpvar_34 >= 0.4999)) {
      tmpvar_33 = 0.0;
    } else {
      tmpvar_33 = (0.5 + (tmpvar_34 * (
        ((0.8431027 * tmpvar_34) * tmpvar_34)
       - 1.144536)));
    };
  };
  alpha_3 = (alpha_3 * min (tmpvar_27, tmpvar_33));
  vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = color_2;
  frag_color_1 = (alpha_3 * tmpvar_35);
  float tmpvar_36;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_36 = 1.0;
  } else {
    vec2 tmpvar_37;
    tmpvar_37 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec4 tmpvar_38;
    tmpvar_38.xy = greaterThanEqual (tmpvar_37, vClipMaskUvBounds.xy);
    tmpvar_38.zw = lessThan (tmpvar_37, vClipMaskUvBounds.zw);
    bool tmpvar_39;
    tmpvar_39 = (tmpvar_38 == bvec4(1, 1, 1, 1));
    if (!(tmpvar_39)) {
      tmpvar_36 = 0.0;
    } else {
      ivec3 tmpvar_40;
      tmpvar_40.xy = ivec2(tmpvar_37);
      tmpvar_40.z = int((vClipMaskUv.z + 0.5));
      tmpvar_36 = texelFetch (sPrevPassAlpha, tmpvar_40, 0).x;
    };
  };
  frag_color_1 = (frag_color_1 * tmpvar_36);
  oFragColor = frag_color_1;
}

