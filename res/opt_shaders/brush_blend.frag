#version 300 es
precision highp float;
precision highp sampler2DArray;
out lowp vec4 oFragColor;
uniform sampler2DArray sColor0;
uniform highp sampler2D sGpuCache;
flat in vec4 vTransformBounds;
flat in vec4 flat_varying_vec4_1;
flat in vec4 flat_varying_vec4_2;
flat in vec4 flat_varying_vec4_3;
flat in vec4 flat_varying_vec4_4;
flat in highp ivec4 flat_varying_ivec4_0;
in vec4 varying_vec4_0;
flat in mat4 vColorMat;
flat in int vFuncs[4];
void main ()
{
  lowp vec3 color_1;
  lowp float alpha_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = (varying_vec4_0.zw * mix (gl_FragCoord.w, 1.0, flat_varying_vec4_4.y));
  highp vec3 tmpvar_4;
  tmpvar_4.xy = tmpvar_3;
  tmpvar_4.z = flat_varying_vec4_4.x;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (sColor0, tmpvar_4);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5.w;
  alpha_2 = tmpvar_6;
  lowp vec3 tmpvar_7;
  if ((tmpvar_5.w != 0.0)) {
    tmpvar_7 = (tmpvar_5.xyz / tmpvar_5.w);
  } else {
    tmpvar_7 = tmpvar_5.xyz;
  };
  color_1 = tmpvar_7;
  bool tmpvar_8;
  tmpvar_8 = bool(0);
  bool tmpvar_9;
  tmpvar_9 = bool(0);
  if ((0 == flat_varying_ivec4_0.x)) tmpvar_8 = bool(1);
  if (tmpvar_9) tmpvar_8 = bool(0);
  if (tmpvar_8) {
    color_1 = (((tmpvar_7 * flat_varying_vec4_4.z) - (0.5 * flat_varying_vec4_4.z)) + 0.5);
    tmpvar_9 = bool(1);
  };
  if ((3 == flat_varying_ivec4_0.x)) tmpvar_8 = bool(1);
  if (tmpvar_9) tmpvar_8 = bool(0);
  if (tmpvar_8) {
    color_1 = mix (color_1, (vec3(1.0, 1.0, 1.0) - color_1), flat_varying_vec4_4.z);
    tmpvar_9 = bool(1);
  };
  if ((6 == flat_varying_ivec4_0.x)) tmpvar_8 = bool(1);
  if (tmpvar_9) tmpvar_8 = bool(0);
  if (tmpvar_8) {
    color_1 = clamp ((color_1 * flat_varying_vec4_4.z), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    tmpvar_9 = bool(1);
  };
  if ((8 == flat_varying_ivec4_0.x)) tmpvar_8 = bool(1);
  if (tmpvar_9) tmpvar_8 = bool(0);
  if (tmpvar_8) {
    color_1 = mix(pow ((
      (color_1 / 1.055)
     + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), (color_1 / 12.92), bvec3(lessThanEqual (color_1, vec3(0.04045, 0.04045, 0.04045))));
    tmpvar_9 = bool(1);
  };
  if ((9 == flat_varying_ivec4_0.x)) tmpvar_8 = bool(1);
  if (tmpvar_9) tmpvar_8 = bool(0);
  if (tmpvar_8) {
    color_1 = mix(((vec3(1.055, 1.055, 1.055) * 
      pow (color_1, vec3(0.4166667, 0.4166667, 0.4166667))
    ) - vec3(0.055, 0.055, 0.055)), (color_1 * 12.92), bvec3(lessThanEqual (color_1, vec3(0.0031308, 0.0031308, 0.0031308))));
    tmpvar_9 = bool(1);
  };
  if ((11 == flat_varying_ivec4_0.x)) tmpvar_8 = bool(1);
  if (tmpvar_9) tmpvar_8 = bool(0);
  if (tmpvar_8) {
    lowp vec4 tmpvar_10;
    tmpvar_10.xyz = color_1;
    tmpvar_10.w = tmpvar_6;
    lowp vec4 colora_11;
    colora_11 = tmpvar_10;
    lowp int k_13;
    highp int offset_14;
    offset_14 = 0;
    for (highp int i_12 = 0; i_12 < 4; i_12++) {
      bool tmpvar_15;
      tmpvar_15 = bool(0);
      bool tmpvar_16;
      tmpvar_16 = bool(0);
      highp int tmpvar_17;
      tmpvar_17 = vFuncs[i_12];
      if ((0 == tmpvar_17)) tmpvar_15 = bool(1);
      if (tmpvar_16) tmpvar_15 = bool(0);
      if (tmpvar_15) {
        tmpvar_16 = bool(1);
      };
      if ((1 == tmpvar_17)) tmpvar_15 = bool(1);
      if ((2 == tmpvar_17)) tmpvar_15 = bool(1);
      if (tmpvar_16) tmpvar_15 = bool(0);
      if (tmpvar_15) {
        k_13 = int(floor((
          colora_11[i_12]
         * 255.0)));
        highp int address_18;
        address_18 = ((flat_varying_ivec4_0.y + offset_14) + (k_13 / 4));
        highp ivec2 tmpvar_19;
        tmpvar_19.x = int((uint(mod (uint(address_18), 1024u))));
        tmpvar_19.y = int((uint(address_18) / 1024u));
        highp float tmpvar_20;
        tmpvar_20 = clamp (texelFetch (sGpuCache, tmpvar_19, 0)[(int(mod (k_13, 4)))], 0.0, 1.0);
        colora_11[i_12] = tmpvar_20;
        offset_14 += 64;
        tmpvar_16 = bool(1);
      };
      if ((3 == tmpvar_17)) tmpvar_15 = bool(1);
      if (tmpvar_16) tmpvar_15 = bool(0);
      if (tmpvar_15) {
        highp int address_21;
        address_21 = (flat_varying_ivec4_0.y + offset_14);
        highp ivec2 tmpvar_22;
        tmpvar_22.x = int((uint(mod (uint(address_21), 1024u))));
        tmpvar_22.y = int((uint(address_21) / 1024u));
        highp vec4 tmpvar_23;
        tmpvar_23 = texelFetch (sGpuCache, tmpvar_22, 0);
        colora_11[i_12] = clamp (((tmpvar_23.x * 
          colora_11[i_12]
        ) + tmpvar_23.y), 0.0, 1.0);
        offset_14++;
        tmpvar_16 = bool(1);
      };
      if ((4 == tmpvar_17)) tmpvar_15 = bool(1);
      if (tmpvar_16) tmpvar_15 = bool(0);
      if (tmpvar_15) {
        highp int address_24;
        address_24 = (flat_varying_ivec4_0.y + offset_14);
        highp ivec2 tmpvar_25;
        tmpvar_25.x = int((uint(mod (uint(address_24), 1024u))));
        tmpvar_25.y = int((uint(address_24) / 1024u));
        highp vec4 tmpvar_26;
        tmpvar_26 = texelFetch (sGpuCache, tmpvar_25, 0);
        highp float tmpvar_27;
        tmpvar_27 = clamp (((tmpvar_26.x * 
          pow (colora_11[i_12], tmpvar_26.y)
        ) + tmpvar_26.z), 0.0, 1.0);
        colora_11[i_12] = tmpvar_27;
        offset_14++;
        tmpvar_16 = bool(1);
      };
      tmpvar_15 = bool(1);
      if (tmpvar_16) tmpvar_15 = bool(0);
      if (tmpvar_15) {
        tmpvar_16 = bool(1);
      };
    };
    color_1 = colora_11.xyz;
    alpha_2 = colora_11.w;
    tmpvar_9 = bool(1);
  };
  if ((10 == flat_varying_ivec4_0.x)) tmpvar_8 = bool(1);
  if (tmpvar_9) tmpvar_8 = bool(0);
  if (tmpvar_8) {
    color_1 = flat_varying_vec4_1.xyz;
    alpha_2 = flat_varying_vec4_1.w;
    tmpvar_9 = bool(1);
  };
  tmpvar_8 = bool(1);
  if (tmpvar_9) tmpvar_8 = bool(0);
  if (tmpvar_8) {
    lowp vec4 tmpvar_28;
    tmpvar_28.xyz = color_1;
    tmpvar_28.w = alpha_2;
    lowp vec4 tmpvar_29;
    tmpvar_29 = clamp (((vColorMat * tmpvar_28) + flat_varying_vec4_3), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0));
    color_1 = tmpvar_29.xyz;
    alpha_2 = tmpvar_29.w;
  };
  highp float tmpvar_30;
  highp vec2 tmpvar_31;
  tmpvar_31.x = float((tmpvar_3.x >= flat_varying_vec4_2.z));
  tmpvar_31.y = float((tmpvar_3.y >= flat_varying_vec4_2.w));
  highp vec2 tmpvar_32;
  tmpvar_32 = (vec2(greaterThanEqual (tmpvar_3, flat_varying_vec4_2.xy)) - tmpvar_31);
  tmpvar_30 = (tmpvar_32.x * tmpvar_32.y);
  vec2 tmpvar_33;
  tmpvar_33 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_34;
  tmpvar_34 = max (vec2(0.0, 0.0), tmpvar_33);
  vec2 tmpvar_35;
  tmpvar_35 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_36;
  float tmpvar_37;
  tmpvar_37 = ((0.5 * (
    sqrt(dot (tmpvar_34, tmpvar_34))
   + 
    min (0.0, max (tmpvar_33.x, tmpvar_33.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_35, tmpvar_35)
  )));
  if ((tmpvar_37 <= -0.4999)) {
    tmpvar_36 = 1.0;
  } else {
    if ((tmpvar_37 >= 0.4999)) {
      tmpvar_36 = 0.0;
    } else {
      tmpvar_36 = (0.5 + (tmpvar_37 * (
        ((0.8431027 * tmpvar_37) * tmpvar_37)
       - 1.144536)));
    };
  };
  highp float tmpvar_38;
  tmpvar_38 = min (tmpvar_30, tmpvar_36);
  alpha_2 = (alpha_2 * tmpvar_38);
  lowp vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = color_1;
  oFragColor = (alpha_2 * tmpvar_39);
}

