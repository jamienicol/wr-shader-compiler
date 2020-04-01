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
  vec4 tmpvar_1;
  vec3 color_2;
  float alpha_3;
  vec2 tmpvar_4;
  tmpvar_4 = (varying_vec4_0.zw * mix (gl_FragCoord.w, 1.0, flat_varying_vec4_4.y));
  vec3 tmpvar_5;
  tmpvar_5.xy = tmpvar_4;
  tmpvar_5.z = flat_varying_vec4_4.x;
  vec4 tmpvar_6;
  tmpvar_6 = texture (sColor0, tmpvar_5);
  float tmpvar_7;
  tmpvar_7 = tmpvar_6.w;
  alpha_3 = tmpvar_7;
  vec3 tmpvar_8;
  if ((tmpvar_6.w != 0.0)) {
    tmpvar_8 = (tmpvar_6.xyz / tmpvar_6.w);
  } else {
    tmpvar_8 = tmpvar_6.xyz;
  };
  color_2 = tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = bool(0);
  bool tmpvar_10;
  tmpvar_10 = bool(0);
  if ((0 == flat_varying_ivec4_0.x)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    color_2 = (((tmpvar_8 * flat_varying_vec4_4.z) - (0.5 * flat_varying_vec4_4.z)) + 0.5);
    tmpvar_10 = bool(1);
  };
  if ((3 == flat_varying_ivec4_0.x)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    color_2 = mix (color_2, (vec3(1.0, 1.0, 1.0) - color_2), flat_varying_vec4_4.z);
    tmpvar_10 = bool(1);
  };
  if ((6 == flat_varying_ivec4_0.x)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    color_2 = clamp ((color_2 * flat_varying_vec4_4.z), vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
    tmpvar_10 = bool(1);
  };
  if ((8 == flat_varying_ivec4_0.x)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    color_2 = mix(pow ((
      (color_2 / 1.055)
     + vec3(0.0521327, 0.0521327, 0.0521327)), vec3(2.4, 2.4, 2.4)), (color_2 / 12.92), bvec3(lessThanEqual (color_2, vec3(0.04045, 0.04045, 0.04045))));
    tmpvar_10 = bool(1);
  };
  if ((9 == flat_varying_ivec4_0.x)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    color_2 = mix(((vec3(1.055, 1.055, 1.055) * 
      pow (color_2, vec3(0.4166667, 0.4166667, 0.4166667))
    ) - vec3(0.055, 0.055, 0.055)), (color_2 * 12.92), bvec3(lessThanEqual (color_2, vec3(0.0031308, 0.0031308, 0.0031308))));
    tmpvar_10 = bool(1);
  };
  if ((11 == flat_varying_ivec4_0.x)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    vec4 tmpvar_11;
    tmpvar_11.xyz = color_2;
    tmpvar_11.w = tmpvar_7;
    vec4 colora_12;
    colora_12 = tmpvar_11;
    int k_14;
    int offset_15;
    offset_15 = 0;
    for (int i_13 = 0; i_13 < 4; i_13++) {
      bool tmpvar_16;
      tmpvar_16 = bool(0);
      bool tmpvar_17;
      tmpvar_17 = bool(0);
      int tmpvar_18;
      tmpvar_18 = vFuncs[i_13];
      if ((0 == tmpvar_18)) tmpvar_16 = bool(1);
      if (tmpvar_17) tmpvar_16 = bool(0);
      if (tmpvar_16) {
        tmpvar_17 = bool(1);
      };
      if ((1 == tmpvar_18)) tmpvar_16 = bool(1);
      if ((2 == tmpvar_18)) tmpvar_16 = bool(1);
      if (tmpvar_17) tmpvar_16 = bool(0);
      if (tmpvar_16) {
        k_14 = int(floor((
          colora_12[i_13]
         * 255.0)));
        int address_19;
        address_19 = ((flat_varying_ivec4_0.y + offset_15) + (k_14 / 4));
        ivec2 tmpvar_20;
        tmpvar_20.x = int((uint(address_19) % 1024u));
        tmpvar_20.y = int((uint(address_19) / 1024u));
        colora_12[i_13] = clamp (texelFetch (sGpuCache, tmpvar_20, 0)[(k_14 % 4)], 0.0, 1.0);
        offset_15 += 64;
        tmpvar_17 = bool(1);
      };
      if ((3 == tmpvar_18)) tmpvar_16 = bool(1);
      if (tmpvar_17) tmpvar_16 = bool(0);
      if (tmpvar_16) {
        int address_21;
        address_21 = (flat_varying_ivec4_0.y + offset_15);
        ivec2 tmpvar_22;
        tmpvar_22.x = int((uint(address_21) % 1024u));
        tmpvar_22.y = int((uint(address_21) / 1024u));
        vec4 tmpvar_23;
        tmpvar_23 = texelFetch (sGpuCache, tmpvar_22, 0);
        colora_12[i_13] = clamp (((tmpvar_23.x * 
          colora_12[i_13]
        ) + tmpvar_23.y), 0.0, 1.0);
        offset_15++;
        tmpvar_17 = bool(1);
      };
      if ((4 == tmpvar_18)) tmpvar_16 = bool(1);
      if (tmpvar_17) tmpvar_16 = bool(0);
      if (tmpvar_16) {
        int address_24;
        address_24 = (flat_varying_ivec4_0.y + offset_15);
        ivec2 tmpvar_25;
        tmpvar_25.x = int((uint(address_24) % 1024u));
        tmpvar_25.y = int((uint(address_24) / 1024u));
        vec4 tmpvar_26;
        tmpvar_26 = texelFetch (sGpuCache, tmpvar_25, 0);
        colora_12[i_13] = clamp (((tmpvar_26.x * 
          pow (colora_12[i_13], tmpvar_26.y)
        ) + tmpvar_26.z), 0.0, 1.0);
        offset_15++;
        tmpvar_17 = bool(1);
      };
      tmpvar_16 = bool(1);
      if (tmpvar_17) tmpvar_16 = bool(0);
      if (tmpvar_16) {
        tmpvar_17 = bool(1);
      };
    };
    color_2 = colora_12.xyz;
    alpha_3 = colora_12.w;
    tmpvar_10 = bool(1);
  };
  if ((10 == flat_varying_ivec4_0.x)) tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    color_2 = flat_varying_vec4_1.xyz;
    alpha_3 = flat_varying_vec4_1.w;
    tmpvar_10 = bool(1);
  };
  tmpvar_9 = bool(1);
  if (tmpvar_10) tmpvar_9 = bool(0);
  if (tmpvar_9) {
    vec4 tmpvar_27;
    tmpvar_27.xyz = color_2;
    tmpvar_27.w = alpha_3;
    vec4 tmpvar_28;
    tmpvar_28 = clamp (((vColorMat * tmpvar_27) + flat_varying_vec4_3), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0));
    color_2 = tmpvar_28.xyz;
    alpha_3 = tmpvar_28.w;
  };
  float tmpvar_29;
  vec2 tmpvar_30;
  tmpvar_30.x = float((tmpvar_4.x >= flat_varying_vec4_2.z));
  tmpvar_30.y = float((tmpvar_4.y >= flat_varying_vec4_2.w));
  vec2 tmpvar_31;
  tmpvar_31 = (vec2(greaterThanEqual (tmpvar_4, flat_varying_vec4_2.xy)) - tmpvar_30);
  tmpvar_29 = (tmpvar_31.x * tmpvar_31.y);
  vec2 tmpvar_32;
  tmpvar_32 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_33;
  tmpvar_33 = max (vec2(0.0, 0.0), tmpvar_32);
  vec2 tmpvar_34;
  tmpvar_34 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_35;
  float tmpvar_36;
  tmpvar_36 = ((0.5 * (
    sqrt(dot (tmpvar_33, tmpvar_33))
   + 
    min (0.0, max (tmpvar_32.x, tmpvar_32.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_34, tmpvar_34)
  )));
  if ((tmpvar_36 <= -0.4999)) {
    tmpvar_35 = 1.0;
  } else {
    if ((tmpvar_36 >= 0.4999)) {
      tmpvar_35 = 0.0;
    } else {
      tmpvar_35 = (0.5 + (tmpvar_36 * (
        ((0.8431027 * tmpvar_36) * tmpvar_36)
       - 1.144536)));
    };
  };
  alpha_3 = (alpha_3 * min (tmpvar_29, tmpvar_35));
  vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = color_2;
  tmpvar_1 = (alpha_3 * tmpvar_37);
  float tmpvar_38;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_38 = 1.0;
  } else {
    vec2 tmpvar_39;
    tmpvar_39 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_40;
    tmpvar_40 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_39);
    bvec2 tmpvar_41;
    tmpvar_41 = greaterThan (vClipMaskUvBounds.zw, tmpvar_39);
    bool tmpvar_42;
    tmpvar_42 = ((tmpvar_40.x && tmpvar_40.y) && (tmpvar_41.x && tmpvar_41.y));
    if (!(tmpvar_42)) {
      tmpvar_38 = 0.0;
    } else {
      ivec3 tmpvar_43;
      tmpvar_43.xy = ivec2(tmpvar_39);
      tmpvar_43.z = int((vClipMaskUv.z + 0.5));
      tmpvar_38 = texelFetch (sPrevPassAlpha, tmpvar_43, 0).x;
    };
  };
  tmpvar_1 = (tmpvar_1 * tmpvar_38);
  oFragColor = tmpvar_1;
}

