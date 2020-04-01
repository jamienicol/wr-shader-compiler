#version 300 es
#extension GL_OES_EGL_image_external_essl3 : enable
precision highp float;
precision highp sampler2DArray;
out lowp vec4 oFragColor;
uniform lowp samplerExternalOES sColor0;
flat in vec4 flat_varying_vec4_2;
flat in vec4 flat_varying_vec4_3;
flat in vec4 flat_varying_vec4_4;
in vec4 varying_vec4_0;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1.xy = clamp (((vec2(mod (
    (varying_vec4_0.zw * mix (gl_FragCoord.w, 1.0, flat_varying_vec4_4.y))
  , 
    (flat_varying_vec4_2.zw - flat_varying_vec4_2.xy)
  ))) + flat_varying_vec4_2.xy), flat_varying_vec4_3.xy, flat_varying_vec4_3.zw);
  tmpvar_1.z = flat_varying_vec4_4.x;
  oFragColor = texture (sColor0, tmpvar_1.xy);
}

