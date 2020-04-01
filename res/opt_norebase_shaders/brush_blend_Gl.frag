#version 150
precision highp float;
out vec4 oFragColor;
uniform sampler2DArray sColor0;
uniform sampler2D sGpuCache;
flat in vec4 vTransformBounds;
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
  vec3 color_1;
  float alpha_2;
  vec2 tmpvar_3;
  tmpvar_3 = (varying_vec4_0.zw * mix (gl_FragCoord.w, 1.0, flat_varying_vec4_4.y));
  vec3 tmpvar_4;
  tmpvar_4.xy = tmpvar_3;
  tmpvar_4.z = flat_varying_vec4_4.x;
  vec4 tmpvar_5;
  tmpvar_5 = texture (sColor0, tmpvar_4);
  float tmpvar_6;
  tmpvar_6 = tmpvar_5.w;
  alpha_2 = tmpvar_6;
  vec3 tmpvar_7;
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
    vec4 tmpvar_10;
    tmpvar_10.xyz = color_1;
    tmpvar_10.w = tmpvar_6;
    vec4 colora_11;
    colora_11 = tmpvar_10;
    int k_13;
    int offset_14;
    offset_14 = 0;
    for (int i_12 = 0; i_12 < 4; i_12++) {
      bool tmpvar_15;
      tmpvar_15 = bool(0);
      bool tmpvar_16;
      tmpvar_16 = bool(0);
      int tmpvar_17;
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
        int address_18;
        address_18 = ((flat_varying_ivec4_0.y + offset_14) + (k_13 / 4));
        ivec2 tmpvar_19;
        tmpvar_19.x = int((uint(address_18) % 1024u));
        tmpvar_19.y = int((uint(address_18) / 1024u));
        colora_11[i_12] = clamp (texelFetch (sGpuCache, tmpvar_19, 0)[(k_13 % 4)], 0.0, 1.0);
        offset_14 += 64;
        tmpvar_16 = bool(1);
      };
      if ((3 == tmpvar_17)) tmpvar_15 = bool(1);
      if (tmpvar_16) tmpvar_15 = bool(0);
      if (tmpvar_15) {
        int address_20;
        address_20 = (flat_varying_ivec4_0.y + offset_14);
        ivec2 tmpvar_21;
        tmpvar_21.x = int((uint(address_20) % 1024u));
        tmpvar_21.y = int((uint(address_20) / 1024u));
        vec4 tmpvar_22;
        tmpvar_22 = texelFetch (sGpuCache, tmpvar_21, 0);
        colora_11[i_12] = clamp (((tmpvar_22.x * 
          colora_11[i_12]
        ) + tmpvar_22.y), 0.0, 1.0);
        offset_14++;
        tmpvar_16 = bool(1);
      };
      if ((4 == tmpvar_17)) tmpvar_15 = bool(1);
      if (tmpvar_16) tmpvar_15 = bool(0);
      if (tmpvar_15) {
        int address_23;
        address_23 = (flat_varying_ivec4_0.y + offset_14);
        ivec2 tmpvar_24;
        tmpvar_24.x = int((uint(address_23) % 1024u));
        tmpvar_24.y = int((uint(address_23) / 1024u));
        vec4 tmpvar_25;
        tmpvar_25 = texelFetch (sGpuCache, tmpvar_24, 0);
        colora_11[i_12] = clamp (((tmpvar_25.x * 
          pow (colora_11[i_12], tmpvar_25.y)
        ) + tmpvar_25.z), 0.0, 1.0);
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
    vec4 tmpvar_26;
    tmpvar_26.xyz = color_1;
    tmpvar_26.w = alpha_2;
    vec4 tmpvar_27;
    tmpvar_27 = clamp (((vColorMat * tmpvar_26) + flat_varying_vec4_3), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0));
    color_1 = tmpvar_27.xyz;
    alpha_2 = tmpvar_27.w;
  };
  float tmpvar_28;
  vec2 tmpvar_29;
  tmpvar_29.x = float((tmpvar_3.x >= flat_varying_vec4_2.z));
  tmpvar_29.y = float((tmpvar_3.y >= flat_varying_vec4_2.w));
  vec2 tmpvar_30;
  tmpvar_30 = (vec2(greaterThanEqual (tmpvar_3, flat_varying_vec4_2.xy)) - tmpvar_29);
  tmpvar_28 = (tmpvar_30.x * tmpvar_30.y);
  vec2 tmpvar_31;
  tmpvar_31 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_32;
  tmpvar_32 = max (vec2(0.0, 0.0), tmpvar_31);
  vec2 tmpvar_33;
  tmpvar_33 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_34;
  float tmpvar_35;
  tmpvar_35 = ((0.5 * (
    sqrt(dot (tmpvar_32, tmpvar_32))
   + 
    min (0.0, max (tmpvar_31.x, tmpvar_31.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_33, tmpvar_33)
  )));
  if ((tmpvar_35 <= -0.4999)) {
    tmpvar_34 = 1.0;
  } else {
    if ((tmpvar_35 >= 0.4999)) {
      tmpvar_34 = 0.0;
    } else {
      tmpvar_34 = (0.5 + (tmpvar_35 * (
        ((0.8431027 * tmpvar_35) * tmpvar_35)
       - 1.144536)));
    };
  };
  alpha_2 = (alpha_2 * min (tmpvar_28, tmpvar_34));
  vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = color_1;
  oFragColor = (alpha_2 * tmpvar_36);
}

