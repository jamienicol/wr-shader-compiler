#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;

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

vec3 _381;
vec3 _385;

void main()
{
    highp vec3 _382;
    if (vFormat == 1)
    {
        highp vec3 _374 = _381;
        _374.x = texture(sColor0, vec3(clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw), vUv_Y.z)).x;
        highp vec3 _376 = _374;
        _376.y = texture(sColor1, vec3(clamp(vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw), vUv_U.z)).x;
        highp vec3 _378 = _376;
        _378.z = texture(sColor2, vec3(clamp(vUv_V.xy, vUvBounds_V.xy, vUvBounds_V.zw), vUv_V.z)).x;
        _382 = _378;
    }
    else
    {
        highp vec3 _383;
        if (vFormat == 0)
        {
            highp vec3 _380 = _385;
            _380.x = texture(sColor0, vec3(clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw), vUv_Y.z)).x;
            highp vec4 _332 = texture(sColor1, vec3(clamp(vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw), vUv_U.z));
            _383 = vec3(_380.x, _332.x, _332.y);
        }
        else
        {
            highp vec3 _384;
            if (vFormat == 2)
            {
                _384 = texture(sColor0, vec3(clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw), vUv_Y.z)).yzx;
            }
            else
            {
                _384 = vec3(0.0);
            }
            _383 = _384;
        }
        _382 = _383;
    }
    oFragColor = vec4(vYuvColorMatrix * ((_382 * vCoefficient) - vec3(0.06274999678134918212890625, 0.501959979534149169921875, 0.501959979534149169921875)), 1.0);
}
