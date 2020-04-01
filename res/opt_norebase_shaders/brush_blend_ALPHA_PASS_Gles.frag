#version 300 es
precision highp float;
precision highp sampler2DArray;
out lowp vec4 oFragColor;
uniform sampler2DArray sColor0;
uniform highp sampler2D sGpuCache;
flat in vec4 vTransformBounds;
uniform sampler2DArray sPrevPassAlpha;
flat in vec4 vClipMaskUvBounds;
in vec4 vClipMaskUv;
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
  lowp vec4 tmpvar_1;
  lowp vec3 color_2;
  lowp float alpha_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (varying_vec4_0.zw * mix (gl_FragCoord.w, 1.0, flat_varying_vec4_4.y));
  highp vec3 tmpvar_5;
  tmpvar_5.xy = tmpvar_4;
  tmpvar_5.z = flat_varying_vec4_4.x;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (sColor0, tmpvar_5);
  lowp float tmpvar_7;
  tmpvar_7 = tmpvar_6.w;
  alpha_3 = tmpvar_7;
  lowp vec3 tmpvar_8;
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
    lowp vec4 tmpvar_11;
    tmpvar_11.xyz = color_2;
    tmpvar_11.w = tmpvar_7;
    lowp vec4 colora_12;
    colora_12 = tmpvar_11;
    lowp int k_14;
    highp int offset_15;
    offset_15 = 0;
    for (highp int i_13 = 0; i_13 < 4; i_13++) {
      bool tmpvar_16;
      tmpvar_16 = bool(0);
      bool tmpvar_17;
      tmpvar_17 = bool(0);
      highp int tmpvar_18;
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
        highp int address_19;
        address_19 = ((flat_varying_ivec4_0.y + offset_15) + (k_14 / 4));
        highp ivec2 tmpvar_20;
        tmpvar_20.x = int((uint(address_19) % 1024u));
        tmpvar_20.y = int((uint(address_19) / 1024u));
        highp float tmpvar_21;
        tmpvar_21 = clamp (texelFetch (sGpuCache, tmpvar_20, 0)[(k_14 % 4)], 0.0, 1.0);
        colora_12[i_13] = tmpvar_21;
        offset_15 += 64;
        tmpvar_17 = bool(1);
      };
      if ((3 == tmpvar_18)) tmpvar_16 = bool(1);
      if (tmpvar_17) tmpvar_16 = bool(0);
      if (tmpvar_16) {
        highp int address_22;
        address_22 = (flat_varying_ivec4_0.y + offset_15);
        highp ivec2 tmpvar_23;
        tmpvar_23.x = int((uint(address_22) % 1024u));
        tmpvar_23.y = int((uint(address_22) / 1024u));
        highp vec4 tmpvar_24;
        tmpvar_24 = texelFetch (sGpuCache, tmpvar_23, 0);
        colora_12[i_13] = clamp (((tmpvar_24.x * 
          colora_12[i_13]
        ) + tmpvar_24.y), 0.0, 1.0);
        offset_15++;
        tmpvar_17 = bool(1);
      };
      if ((4 == tmpvar_18)) tmpvar_16 = bool(1);
      if (tmpvar_17) tmpvar_16 = bool(0);
      if (tmpvar_16) {
        highp int address_25;
        address_25 = (flat_varying_ivec4_0.y + offset_15);
        highp ivec2 tmpvar_26;
        tmpvar_26.x = int((uint(address_25) % 1024u));
        tmpvar_26.y = int((uint(address_25) / 1024u));
        highp vec4 tmpvar_27;
        tmpvar_27 = texelFetch (sGpuCache, tmpvar_26, 0);
        highp float tmpvar_28;
        tmpvar_28 = clamp (((tmpvar_27.x * 
          pow (colora_12[i_13], tmpvar_27.y)
        ) + tmpvar_27.z), 0.0, 1.0);
        colora_12[i_13] = tmpvar_28;
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
    lowp vec4 tmpvar_29;
    tmpvar_29.xyz = color_2;
    tmpvar_29.w = alpha_3;
    lowp vec4 tmpvar_30;
    tmpvar_30 = clamp (((vColorMat * tmpvar_29) + flat_varying_vec4_3), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0));
    color_2 = tmpvar_30.xyz;
    alpha_3 = tmpvar_30.w;
  };
  highp float tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32.x = float((tmpvar_4.x >= flat_varying_vec4_2.z));
  tmpvar_32.y = float((tmpvar_4.y >= flat_varying_vec4_2.w));
  highp vec2 tmpvar_33;
  tmpvar_33 = (vec2(greaterThanEqual (tmpvar_4, flat_varying_vec4_2.xy)) - tmpvar_32);
  tmpvar_31 = (tmpvar_33.x * tmpvar_33.y);
  vec2 tmpvar_34;
  tmpvar_34 = max ((vTransformBounds.xy - varying_vec4_0.xy), (varying_vec4_0.xy - vTransformBounds.zw));
  vec2 tmpvar_35;
  tmpvar_35 = max (vec2(0.0, 0.0), tmpvar_34);
  vec2 tmpvar_36;
  tmpvar_36 = (abs(dFdx(varying_vec4_0.xy)) + abs(dFdy(varying_vec4_0.xy)));
  float tmpvar_37;
  float tmpvar_38;
  tmpvar_38 = ((0.5 * (
    sqrt(dot (tmpvar_35, tmpvar_35))
   + 
    min (0.0, max (tmpvar_34.x, tmpvar_34.y))
  )) / (0.35355 * sqrt(
    dot (tmpvar_36, tmpvar_36)
  )));
  if ((tmpvar_38 <= -0.4999)) {
    tmpvar_37 = 1.0;
  } else {
    if ((tmpvar_38 >= 0.4999)) {
      tmpvar_37 = 0.0;
    } else {
      tmpvar_37 = (0.5 + (tmpvar_38 * (
        ((0.8431027 * tmpvar_38) * tmpvar_38)
       - 1.144536)));
    };
  };
  highp float tmpvar_39;
  tmpvar_39 = min (tmpvar_31, tmpvar_37);
  alpha_3 = (alpha_3 * tmpvar_39);
  lowp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = color_2;
  tmpvar_1 = (alpha_3 * tmpvar_40);
  highp float tmpvar_41;
  if ((vClipMaskUvBounds.xy == vClipMaskUvBounds.zw)) {
    tmpvar_41 = 1.0;
  } else {
    highp vec2 tmpvar_42;
    tmpvar_42 = (vClipMaskUv.xy * gl_FragCoord.w);
    bvec2 tmpvar_43;
    tmpvar_43 = lessThanEqual (vClipMaskUvBounds.xy, tmpvar_42);
    bvec2 tmpvar_44;
    tmpvar_44 = greaterThan (vClipMaskUvBounds.zw, tmpvar_42);
    bool tmpvar_45;
    tmpvar_45 = ((tmpvar_43.x && tmpvar_43.y) && (tmpvar_44.x && tmpvar_44.y));
    if (!(tmpvar_45)) {
      tmpvar_41 = 0.0;
    } else {
      highp ivec3 tmpvar_46;
      tmpvar_46.xy = ivec2(tmpvar_42);
      tmpvar_46.z = int((vClipMaskUv.z + 0.5));
      highp vec4 tmpvar_47;
      tmpvar_47 = texelFetch (sPrevPassAlpha, tmpvar_46, 0);
      tmpvar_41 = tmpvar_47.x;
    };
  };
  tmpvar_1 = (tmpvar_1 * tmpvar_41);
  oFragColor = tmpvar_1;
}

