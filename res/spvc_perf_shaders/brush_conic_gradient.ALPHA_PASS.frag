#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sPrevPassAlpha;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_0;
flat in int flat_varying_highp_int_address_0;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_1;

void main()
{
    highp vec2 _434 = max(varying_vec4_0.zw, vec2(0.0));
    highp vec2 _438 = mod(_434, flat_varying_vec4_1.xy);
    highp vec2 _443 = flat_varying_vec4_1.xy * flat_varying_vec4_2.xy;
    highp vec2 _699;
    if (_434.x >= _443.x)
    {
        highp vec2 _690 = _438;
        _690.x = flat_varying_vec4_1.x;
        _699 = _690;
    }
    else
    {
        _699 = _438;
    }
    highp vec2 _700;
    if (_434.y >= _443.y)
    {
        highp vec2 _694 = _699;
        _694.y = flat_varying_vec4_1.y;
        _700 = _694;
    }
    else
    {
        _700 = _699;
    }
    highp vec2 _467 = _700 - flat_varying_vec4_0.xy;
    highp float _479 = mod((atan(_467.y, _467.x) + (1.57079637050628662109375 - flat_varying_vec4_0.z)) * 0.15915493667125701904296875, 1.0);
    highp float _505 = 1.0 + (mix(_479, fract(_479), flat_varying_vec4_1.z) * 128.0);
    uint _543 = uint(flat_varying_highp_int_address_0 + clamp(2 * int(floor(_505)), 0, 258));
    ivec2 _550 = ivec2(int(_543 % 1024u), int(_543 / 1024u));
    highp vec2 _581 = max(vTransformBounds.xy - varying_vec4_0.xy, varying_vec4_0.xy - vTransformBounds.zw);
    highp vec2 _594 = fwidth(varying_vec4_0.xy);
    highp float _701;
    switch (0u)
    {
        default:
        {
            highp float _606 = (0.5 * (length(max(vec2(0.0), _581)) + min(0.0, max(_581.x, _581.y)))) / (0.3535499870777130126953125 * length(_594));
            if (_606 <= (-0.4999000132083892822265625))
            {
                _701 = 1.0;
                break;
            }
            if (_606 >= 0.4999000132083892822265625)
            {
                _701 = 0.0;
                break;
            }
            _701 = 0.5 + (_606 * (((0.8431026935577392578125 * _606) * _606) - 1.14453601837158203125));
            break;
        }
    }
    highp float _703;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _703 = 1.0;
                break;
            }
            highp vec2 _645 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _645), greaterThan(vClipMaskUvBounds.zw, _645))))
            {
                _703 = 0.0;
                break;
            }
            _703 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_645), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = (mix(texelFetch(sGpuCache, _550, 0), texelFetch(sGpuCache, _550 + ivec2(1, 0), 0), vec4(fract(_505))) * _701) * _703;
}

