#version 300 es
precision mediump float;
precision highp int;

struct Fragment
{
    highp vec4 color;
};

uniform mediump sampler2D sColor0;
uniform mediump sampler2D sColor1;
uniform mediump sampler2D sColor2;
uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;

layout(location = 0) out highp vec4 oFragColor;
flat in mediump int vFormat;
in highp vec3 vUv_Y;
flat in highp vec4 vUvBounds_Y;
in highp vec3 vUv_U;
flat in highp vec4 vUvBounds_U;
in highp vec3 vUv_V;
flat in highp vec4 vUvBounds_V;
flat in highp mat3 vYuvColorMatrix;
flat in highp float vCoefficient;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

Fragment yuv_brush_fs()
{
    highp vec3 yuv_value;
    if (vFormat == 1)
    {
        highp vec2 uv_y = clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
        highp vec2 uv_u = clamp(vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw);
        highp vec2 uv_v = clamp(vUv_V.xy, vUvBounds_V.xy, vUvBounds_V.zw);
        yuv_value.x = texture(sColor0, vec3(uv_y, vUv_Y.z).xy).x;
        yuv_value.y = texture(sColor1, vec3(uv_u, vUv_U.z).xy).x;
        yuv_value.z = texture(sColor2, vec3(uv_v, vUv_V.z).xy).x;
    }
    else
    {
        if (vFormat == 0)
        {
            highp vec2 uv_y_1 = clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
            highp vec2 uv_uv = clamp(vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw);
            yuv_value.x = texture(sColor0, vec3(uv_y_1, vUv_Y.z).xy).x;
            vec2 _160 = texture(sColor1, vec3(uv_uv, vUv_U.z).xy).xy;
            yuv_value = vec3(yuv_value.x, _160.x, _160.y);
        }
        else
        {
            if (vFormat == 2)
            {
                highp vec2 uv_y_2 = clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
                yuv_value = texture(sColor0, vec3(uv_y_2, vUv_Y.z).xy).yzx;
            }
            else
            {
                yuv_value = vec3(0.0);
            }
        }
    }
    highp vec3 rgb = vYuvColorMatrix * ((yuv_value * vCoefficient) - vec3(0.06274999678134918212890625, 0.501959979534149169921875, 0.501959979534149169921875));
    highp vec4 color = vec4(rgb, 1.0);
    return Fragment(color);
}

void write_output(highp vec4 color)
{
    oFragColor = color;
}

void main()
{
    Fragment frag = yuv_brush_fs();
    highp vec4 param = frag.color;
    write_output(param);
}

