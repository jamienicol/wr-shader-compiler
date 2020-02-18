#version 300 es
precision mediump float;
precision highp int;

in highp vec2 vLocalPos;
flat in mediump int vStyle;
flat in highp vec4 vParams;
layout(location = 0) out highp vec4 oFragColor;

void main()
{
    highp vec2 _256 = fwidth(vLocalPos);
    highp float _258 = 0.3535499870777130126953125 * length(_256);
    highp float _343;
    switch (vStyle)
    {
        case 0:
        {
            _343 = 1.0;
            break;
        }
        case 2:
        {
            _343 = step(floor(vLocalPos.x + 0.5), vParams.y);
            break;
        }
        case 1:
        {
            highp float _342;
            switch (0u)
            {
                default:
                {
                    highp float _268 = (0.5 * (length(vLocalPos - vParams.yz) - vParams.y)) / _258;
                    if (_268 <= (-0.4999000132083892822265625))
                    {
                        _342 = 1.0;
                        break;
                    }
                    if (_268 >= 0.4999000132083892822265625)
                    {
                        _342 = 0.0;
                        break;
                    }
                    _342 = 0.5 + (_268 * (((0.8431026935577392578125 * _268) * _268) - 1.14453601837158203125));
                    break;
                }
            }
            _343 = _342;
            break;
        }
        case 3:
        {
            highp float _145 = vParams.y + vParams.z;
            highp float _149 = vParams.w * 0.5;
            highp float _163 = step(mod(vLocalPos.x, 2.0 * _145), _145) - 0.5;
            highp float _171 = _149 + ((_149 - vParams.x) * ((-2.0) * _163));
            highp vec2 _349 = vLocalPos;
            _349.x = mod(vLocalPos.x, _145);
            highp float _181 = _163 * 2.0;
            highp vec2 _290 = vec2(0.0, _171) - _349;
            highp float _340;
            switch (0u)
            {
                default:
                {
                    highp float _322 = (0.5 * (abs(max(max(dot(normalize(vec2(1.0, _181)), _290), dot(normalize(vec2(0.0, _181)), _290)), dot(normalize(vec2(-1.0, _181)), vec2(vParams.z, _171) - _349))) - vParams.x)) / _258;
                    if (_322 <= (-0.4999000132083892822265625))
                    {
                        _340 = 1.0;
                        break;
                    }
                    if (_322 >= 0.4999000132083892822265625)
                    {
                        _340 = 0.0;
                        break;
                    }
                    _340 = 0.5 + (_322 * (((0.8431026935577392578125 * _322) * _322) - 1.14453601837158203125));
                    break;
                }
            }
            highp float _344;
            if (vParams.x <= 1.0)
            {
                _344 = 1.0 - step(_340, 0.5);
            }
            else
            {
                _344 = _340;
            }
            _343 = _344;
            break;
        }
        default:
        {
            _343 = 1.0;
            break;
        }
    }
    oFragColor = vec4(_343);
}

