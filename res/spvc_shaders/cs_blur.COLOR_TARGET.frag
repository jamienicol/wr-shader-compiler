#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassColor;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sPrevPassAlpha;

in highp vec3 vUv;
flat in mediump int vSupport;
layout(location = 0) out highp vec4 oFragColor;
flat in highp float vSigma;
flat in highp vec2 vOffsetScale;
flat in highp vec4 vUvRect;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;

void main()
{
    highp vec4 original_color = texture(sPrevPassColor, vUv);
    if (vSupport == 0)
    {
        oFragColor = vec4(original_color);
        return;
    }
    highp vec3 gauss_coefficient;
    gauss_coefficient.x = 1.0 / (2.5066282749176025390625 * vSigma);
    gauss_coefficient.y = exp((-0.5) / (vSigma * vSigma));
    gauss_coefficient.z = gauss_coefficient.y * gauss_coefficient.y;
    highp float gauss_coefficient_total = gauss_coefficient.x;
    highp vec4 avg_color = original_color * gauss_coefficient.x;
    highp vec2 _79 = gauss_coefficient.xy * gauss_coefficient.yz;
    gauss_coefficient = vec3(_79.x, _79.y, gauss_coefficient.z);
    for (mediump int i = 1; i <= vSupport; i += 2)
    {
        highp float gauss_coefficient_subtotal = gauss_coefficient.x;
        highp vec2 _100 = gauss_coefficient.xy * gauss_coefficient.yz;
        gauss_coefficient = vec3(_100.x, _100.y, gauss_coefficient.z);
        gauss_coefficient_subtotal += gauss_coefficient.x;
        highp float gauss_ratio = gauss_coefficient.x / gauss_coefficient_subtotal;
        highp vec2 offset = vOffsetScale * (float(i) + gauss_ratio);
        highp vec2 st0 = clamp(vUv.xy - offset, vUvRect.xy, vUvRect.zw);
        avg_color += (texture(sPrevPassColor, vec3(st0, vUv.z)) * gauss_coefficient_subtotal);
        highp vec2 st1 = clamp(vUv.xy + offset, vUvRect.xy, vUvRect.zw);
        avg_color += (texture(sPrevPassColor, vec3(st1, vUv.z)) * gauss_coefficient_subtotal);
        gauss_coefficient_total += (2.0 * gauss_coefficient_subtotal);
        highp vec2 _177 = gauss_coefficient.xy * gauss_coefficient.yz;
        gauss_coefficient = vec3(_177.x, _177.y, gauss_coefficient.z);
    }
    oFragColor = vec4(avg_color) / vec4(gauss_coefficient_total);
}

