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
    highp float _580;
    if (vMixColors != 0)
    {
        highp float _322 = dot(normalize(vColorLine.zw), vColorLine.xy - vPos);
        highp float _581;
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
            _581 = _537;
        }
        else
        {
            _581 = float((_322 + 9.9999997473787516355514526367188e-05) >= 0.0);
        }
        _580 = _581;
    }
    else
    {
        _580 = 0.0;
    }
    highp vec2 _180 = vPos - vClipCenter_Sign.xy;
    highp float _553;
    if (all(lessThan(vClipCenter_Sign.zw * _180, vec2(0.0))))
    {
        highp float _541;
        if (any(lessThanEqual(vClipRadii.xy, vec2(0.0))))
        {
            _541 = length(_180);
        }
        else
        {
            highp vec2 _367 = vec2(1.0) / (vClipRadii.xy * vClipRadii.xy);
            highp vec2 _378 = (_180 * 2.0) * _367;
            _541 = (dot((_180 * _180) * _367, vec2(1.0)) - 1.0) * inversesqrt(dot(_378, _378));
        }
        highp float _387 = _312 * (-0.3535499870777130126953125);
        highp float _545;
        if (any(lessThanEqual(vClipRadii.zw, vec2(0.0))))
        {
            _545 = length(_180);
        }
        else
        {
            highp vec2 _407 = vec2(1.0) / (vClipRadii.zw * vClipRadii.zw);
            highp vec2 _418 = (_180 * 2.0) * _407;
            _545 = (dot((_180 * _180) * _407, vec2(1.0)) - 1.0) * inversesqrt(dot(_418, _418));
        }
        _553 = max(clamp(_541, _387, _313), -clamp(_545, _387, _313));
    }
    else
    {
        _553 = -1.0;
    }
    highp vec2 _220 = vPos - vHorizontalClipCenter_Sign.xy;
    highp float _559;
    if (all(lessThan(vHorizontalClipCenter_Sign.zw * _220, vec2(0.0))))
    {
        highp float _550;
        if (any(lessThanEqual(vHorizontalClipRadii, vec2(0.0))))
        {
            _550 = length(_220);
        }
        else
        {
            highp vec2 _447 = vec2(1.0) / (vHorizontalClipRadii * vHorizontalClipRadii);
            highp vec2 _458 = (_220 * 2.0) * _447;
            _550 = (dot((_220 * _220) * _447, vec2(1.0)) - 1.0) * inversesqrt(dot(_458, _458));
        }
        _559 = max(clamp(_550, _312 * (-0.3535499870777130126953125), _313), _553);
    }
    else
    {
        _559 = _553;
    }
    highp vec2 _246 = vPos - vVerticalClipCenter_Sign.xy;
    highp float _572;
    if (all(lessThan(vVerticalClipCenter_Sign.zw * _246, vec2(0.0))))
    {
        highp float _556;
        if (any(lessThanEqual(vVerticalClipRadii, vec2(0.0))))
        {
            _556 = length(_246);
        }
        else
        {
            highp vec2 _487 = vec2(1.0) / (vVerticalClipRadii * vVerticalClipRadii);
            highp vec2 _498 = (_246 * 2.0) * _487;
            _556 = (dot((_246 * _246) * _487, vec2(1.0)) - 1.0) * inversesqrt(dot(_498, _498));
        }
        _572 = max(clamp(_556, _312 * (-0.3535499870777130126953125), _313), _559);
    }
    else
    {
        _572 = _559;
    }
    highp float _574;
    if (_140)
    {
        highp float _573;
        switch (0u)
        {
            default:
            {
                highp float _519 = (0.5 * _572) / _313;
                if (_519 <= (-0.4999000132083892822265625))
                {
                    _573 = 1.0;
                    break;
                }
                if (_519 >= 0.4999000132083892822265625)
                {
                    _573 = 0.0;
                    break;
                }
                _573 = 0.5 + (_519 * (((0.8431026935577392578125 * _519) * _519) - 1.14453601837158203125));
                break;
            }
        }
        _574 = _573;
    }
    else
    {
        _574 = 1.0;
    }
    oFragColor = mix(vColor0, vColor1, vec4(_580)) * _574;
}

