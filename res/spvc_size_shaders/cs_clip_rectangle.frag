#version 300 es
precision mediump float;
precision highp int;

flat in highp vec4 vTransformBounds;
in highp vec4 vLocalPos;
flat in highp vec4 vClipCenter_Radius_TL;
flat in highp vec4 vClipCenter_Radius_TR;
flat in highp vec4 vClipCenter_Radius_BR;
flat in highp vec4 vClipCenter_Radius_BL;
flat in highp float vClipMode;
layout(location = 0) out highp vec4 oFragColor;

void main()
{
    highp vec2 _279 = vLocalPos.xy / vec2(vLocalPos.w);
    highp vec2 _352 = fwidth(_279);
    highp float _353 = length(_352);
    highp float _354 = 0.3535499870777130126953125 * _353;
    highp vec2 _383 = max(vTransformBounds.xy - _279, _279 - vTransformBounds.zw);
    highp vec2 _396 = fwidth(_279);
    highp float _798;
    switch (0u)
    {
        default:
        {
            highp float _408 = (0.5 * (length(max(vec2(0.0), _383)) + min(0.0, max(_383.x, _383.y)))) / (0.3535499870777130126953125 * length(_396));
            if (_408 <= (-0.4999000132083892822265625))
            {
                _798 = 1.0;
                break;
            }
            if (_408 >= 0.4999000132083892822265625)
            {
                _798 = 0.0;
                break;
            }
            _798 = 0.5 + (_408 * (((0.8431026935577392578125 * _408) * _408) - 1.14453601837158203125));
            break;
        }
    }
    highp float _451 = _353 * (-0.3535499870777130126953125);
    highp float _804;
    switch (0u)
    {
        default:
        {
            if (!all(lessThan(_279, vClipCenter_Radius_TL.xy)))
            {
                _804 = _451;
                break;
            }
            highp vec2 _500 = _279 - vClipCenter_Radius_TL.xy;
            highp float _801;
            if (any(lessThanEqual(vClipCenter_Radius_TL.zw, vec2(0.0))))
            {
                _801 = length(_500);
            }
            else
            {
                highp vec2 _526 = vec2(1.0) / (vClipCenter_Radius_TL.zw * vClipCenter_Radius_TL.zw);
                highp vec2 _537 = (_500 * 2.0) * _526;
                _801 = (dot((_500 * _500) * _526, vec2(1.0)) - 1.0) * inversesqrt(dot(_537, _537));
            }
            _804 = max(clamp(_801, _451, _354), _451);
            break;
        }
    }
    highp float _814;
    switch (0u)
    {
        default:
        {
            if (!all(lessThan(vec2(-1.0, 1.0) * _279, vec2(-1.0, 1.0) * vClipCenter_Radius_TR.xy)))
            {
                _814 = _804;
                break;
            }
            highp vec2 _574 = _279 - vClipCenter_Radius_TR.xy;
            highp float _811;
            if (any(lessThanEqual(vClipCenter_Radius_TR.zw, vec2(0.0))))
            {
                _811 = length(_574);
            }
            else
            {
                highp vec2 _600 = vec2(1.0) / (vClipCenter_Radius_TR.zw * vClipCenter_Radius_TR.zw);
                highp vec2 _611 = (_574 * 2.0) * _600;
                _811 = (dot((_574 * _574) * _600, vec2(1.0)) - 1.0) * inversesqrt(dot(_611, _611));
            }
            _814 = max(clamp(_811, _451, _354), _804);
            break;
        }
    }
    highp float _826;
    switch (0u)
    {
        default:
        {
            if (!all(lessThan(vec2(-1.0) * _279, vec2(-1.0) * vClipCenter_Radius_BR.xy)))
            {
                _826 = _814;
                break;
            }
            highp vec2 _648 = _279 - vClipCenter_Radius_BR.xy;
            highp float _823;
            if (any(lessThanEqual(vClipCenter_Radius_BR.zw, vec2(0.0))))
            {
                _823 = length(_648);
            }
            else
            {
                highp vec2 _674 = vec2(1.0) / (vClipCenter_Radius_BR.zw * vClipCenter_Radius_BR.zw);
                highp vec2 _685 = (_648 * 2.0) * _674;
                _823 = (dot((_648 * _648) * _674, vec2(1.0)) - 1.0) * inversesqrt(dot(_685, _685));
            }
            _826 = max(clamp(_823, _451, _354), _814);
            break;
        }
    }
    highp float _840;
    switch (0u)
    {
        default:
        {
            if (!all(lessThan(vec2(1.0, -1.0) * _279, vec2(1.0, -1.0) * vClipCenter_Radius_BL.xy)))
            {
                _840 = _826;
                break;
            }
            highp vec2 _722 = _279 - vClipCenter_Radius_BL.xy;
            highp float _837;
            if (any(lessThanEqual(vClipCenter_Radius_BL.zw, vec2(0.0))))
            {
                _837 = length(_722);
            }
            else
            {
                highp vec2 _748 = vec2(1.0) / (vClipCenter_Radius_BL.zw * vClipCenter_Radius_BL.zw);
                highp vec2 _759 = (_722 * 2.0) * _748;
                _837 = (dot((_722 * _722) * _748, vec2(1.0)) - 1.0) * inversesqrt(dot(_759, _759));
            }
            _840 = max(clamp(_837, _451, _354), _826);
            break;
        }
    }
    highp float _843;
    switch (0u)
    {
        default:
        {
            highp float _780 = (0.5 * _840) / _354;
            if (_780 <= (-0.4999000132083892822265625))
            {
                _843 = 1.0;
                break;
            }
            if (_780 >= 0.4999000132083892822265625)
            {
                _843 = 0.0;
                break;
            }
            _843 = 0.5 + (_780 * (((0.8431026935577392578125 * _780) * _780) - 1.14453601837158203125));
            break;
        }
    }
    highp float _309 = _798 * _843;
    oFragColor = vec4((vLocalPos.w > 0.0) ? mix(_309, 1.0 - _309, vClipMode) : 0.0, 0.0, 0.0, 1.0);
}

