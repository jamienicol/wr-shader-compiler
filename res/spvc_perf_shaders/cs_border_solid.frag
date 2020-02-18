#version 300 es
precision mediump float;
precision highp int;

in highp vec2 vPos;
flat in mediump int vMixColors;
flat in highp vec4 vColorLine;
flat in highp vec4 vClipCenter_Sign;
flat in highp vec4 vClipRadii;
flat in highp vec4 vHorizontalClipCenter_Sign;
flat in highp vec2 vHorizontalClipRadii;
flat in highp vec4 vVerticalClipCenter_Sign;
flat in highp vec2 vVerticalClipRadii;
flat in highp vec4 vColor0;
flat in highp vec4 vColor1;
layout(location = 0) out highp vec4 oFragColor;

void main()
{
    highp vec2 _311 = fwidth(vPos);
    highp float _312 = length(_311);
    highp float _313 = 0.3535499870777130126953125 * _312;
    bool _140 = vMixColors != 2;
    highp float _555;
    if (vMixColors != 0)
    {
        highp float _322 = dot(normalize(vColorLine.zw), vColorLine.xy - vPos);
        highp float _556;
        if (_140)
        {
            highp float _537;
            switch (0u)
            {
                default:
                {
                    highp float _332 = (_322 * (-0.5)) / _313;
                    if (_332 <= (-0.4999000132083892822265625))
                    {
                        _537 = 1.0;
                        break;
                    }
                    if (_332 >= 0.4999000132083892822265625)
                    {
                        _537 = 0.0;
                        break;
                    }
                    _537 = 0.5 + (_332 * (((0.8431026935577392578125 * _332) * _332) - 1.14453601837158203125));
                    break;
                }
            }
            _556 = _537;
        }
        else
        {
            _556 = float((_322 + 9.9999997473787516355514526367188e-05) >= 0.0);
        }
        _555 = _556;
    }
    else
    {
        _555 = 0.0;
    }
    highp vec2 _180 = vPos - vClipCenter_Sign.xy;
    highp float _543;
    if (all(lessThan(vClipCenter_Sign.zw * _180, vec2(0.0))))
    {
        highp float _538;
        if (any(lessThanEqual(vClipRadii.xy, vec2(0.0))))
        {
            _538 = length(_180);
        }
        else
        {
            highp vec2 _367 = vec2(1.0) / (vClipRadii.xy * vClipRadii.xy);
            highp vec2 _378 = (_180 * 2.0) * _367;
            _538 = (dot((_180 * _180) * _367, vec2(1.0)) - 1.0) * inversesqrt(dot(_378, _378));
        }
        highp float _387 = _312 * (-0.3535499870777130126953125);
        highp float _540;
        if (any(lessThanEqual(vClipRadii.zw, vec2(0.0))))
        {
            _540 = length(_180);
        }
        else
        {
            highp vec2 _407 = vec2(1.0) / (vClipRadii.zw * vClipRadii.zw);
            highp vec2 _418 = (_180 * 2.0) * _407;
            _540 = (dot((_180 * _180) * _407, vec2(1.0)) - 1.0) * inversesqrt(dot(_418, _418));
        }
        _543 = max(clamp(_538, _387, _313), -clamp(_540, _387, _313));
    }
    else
    {
        _543 = -1.0;
    }
    highp vec2 _220 = vPos - vHorizontalClipCenter_Sign.xy;
    highp float _546;
    if (all(lessThan(vHorizontalClipCenter_Sign.zw * _220, vec2(0.0))))
    {
        highp float _541;
        if (any(lessThanEqual(vHorizontalClipRadii, vec2(0.0))))
        {
            _541 = length(_220);
        }
        else
        {
            highp vec2 _447 = vec2(1.0) / (vHorizontalClipRadii * vHorizontalClipRadii);
            highp vec2 _458 = (_220 * 2.0) * _447;
            _541 = (dot((_220 * _220) * _447, vec2(1.0)) - 1.0) * inversesqrt(dot(_458, _458));
        }
        _546 = max(clamp(_541, _312 * (-0.3535499870777130126953125), _313), _543);
    }
    else
    {
        _546 = _543;
    }
    highp vec2 _246 = vPos - vVerticalClipCenter_Sign.xy;
    highp float _547;
    if (all(lessThan(vVerticalClipCenter_Sign.zw * _246, vec2(0.0))))
    {
        highp float _544;
        if (any(lessThanEqual(vVerticalClipRadii, vec2(0.0))))
        {
            _544 = length(_246);
        }
        else
        {
            highp vec2 _487 = vec2(1.0) / (vVerticalClipRadii * vVerticalClipRadii);
            highp vec2 _498 = (_246 * 2.0) * _487;
            _544 = (dot((_246 * _246) * _487, vec2(1.0)) - 1.0) * inversesqrt(dot(_498, _498));
        }
        _547 = max(clamp(_544, _312 * (-0.3535499870777130126953125), _313), _546);
    }
    else
    {
        _547 = _546;
    }
    highp float _549;
    if (_140)
    {
        highp float _548;
        switch (0u)
        {
            default:
            {
                highp float _519 = (0.5 * _547) / _313;
                if (_519 <= (-0.4999000132083892822265625))
                {
                    _548 = 1.0;
                    break;
                }
                if (_519 >= 0.4999000132083892822265625)
                {
                    _548 = 0.0;
                    break;
                }
                _548 = 0.5 + (_519 * (((0.8431026935577392578125 * _519) * _519) - 1.14453601837158203125));
                break;
            }
        }
        _549 = _548;
    }
    else
    {
        _549 = 1.0;
    }
    oFragColor = mix(vColor0, vColor1, vec4(_555)) * _549;
}

