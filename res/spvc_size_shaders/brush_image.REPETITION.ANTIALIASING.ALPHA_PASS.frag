#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sColor0;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_2;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_4;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_0;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

void main()
{
    highp vec2 _423 = flat_varying_vec4_2.zw - flat_varying_vec4_2.xy;
    highp vec2 _428 = max(varying_vec4_0.zw * mix(gl_FragCoord.w, 1.0, flat_varying_vec4_4.y), vec2(0.0));
    highp vec2 _434 = mod(_428, _423) + flat_varying_vec4_2.xy;
    highp vec2 _613;
    if (_428.x >= (flat_varying_vec4_1.z * _423.x))
    {
        highp vec2 _606 = _434;
        _606.x = flat_varying_vec4_2.z;
        _613 = _606;
    }
    else
    {
        _613 = _434;
    }
    highp vec2 _614;
    if (_428.y >= (flat_varying_vec4_1.w * _423.y))
    {
        highp vec2 _610 = _613;
        _610.y = flat_varying_vec4_2.w;
        _614 = _610;
    }
    else
    {
        _614 = _613;
    }
    highp vec4 _390 = texture(sColor0, vec3(clamp(_614, flat_varying_vec4_3.xy, flat_varying_vec4_3.zw), flat_varying_vec4_4.x));
    highp vec2 _490 = max(vTransformBounds.xy - varying_vec4_0.xy, varying_vec4_0.xy - vTransformBounds.zw);
    highp vec2 _503 = fwidth(varying_vec4_0.xy);
    highp float _599;
    switch (0u)
    {
        default:
        {
            highp float _515 = (0.5 * (length(max(vec2(0.0), _490)) + min(0.0, max(_490.x, _490.y)))) / (0.3535499870777130126953125 * length(_503));
            if (_515 <= (-0.4999000132083892822265625))
            {
                _599 = 1.0;
                break;
            }
            if (_515 >= 0.4999000132083892822265625)
            {
                _599 = 0.0;
                break;
            }
            _599 = 0.5 + (_515 * (((0.8431026935577392578125 * _515) * _515) - 1.14453601837158203125));
            break;
        }
    }
    highp vec3 _404 = (_390.xyz * flat_varying_vec4_1.x) + (_390.www * flat_varying_vec4_1.y);
    highp float _601;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _601 = 1.0;
                break;
            }
            highp vec2 _554 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _554), greaterThan(vClipMaskUvBounds.zw, _554))))
            {
                _601 = 0.0;
                break;
            }
            _601 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_554), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = (flat_varying_vec4_0 * (vec4(_404.x, _404.y, _404.z, _390.w) * _599)) * _601;
}

