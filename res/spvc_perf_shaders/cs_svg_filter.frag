#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;

flat in mediump int vFuncs[4];
flat in mediump ivec4 vData;
flat in highp vec4 vFilterData0;
flat in mediump int vFilterInputCount;
in highp vec3 vInput1Uv;
flat in highp vec4 vInput1UvRect;
in highp vec3 vInput2Uv;
flat in highp vec4 vInput2UvRect;
flat in mediump int vFilterKind;
flat in highp float vFloat0;
flat in highp mat4 vColorMat;
flat in highp vec4 vFilterData1;
layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;

vec4 _5685;

void main()
{
    highp vec4 _5435;
    if (vFilterInputCount > 0)
    {
        highp vec4 _1526 = texture(sColor0, vec3(clamp(vInput1Uv.xy, vInput1UvRect.xy, vInput1UvRect.zw), vInput1Uv.z), 0.0);
        highp float _1289 = _1526.w;
        highp vec4 _5436;
        if (_1289 != 0.0)
        {
            highp vec3 _1298 = _1526.xyz / vec3(_1289);
            _5436 = vec4(_1298.x, _1298.y, _1298.z, _1526.w);
        }
        else
        {
            _5436 = _1526;
        }
        _5435 = _5436;
    }
    else
    {
        _5435 = vec4(0.0);
    }
    highp vec4 _5438;
    if (vFilterInputCount > 1)
    {
        highp vec4 _1543 = texture(sColor1, vec3(clamp(vInput2Uv.xy, vInput2UvRect.xy, vInput2UvRect.zw), vInput2Uv.z), 0.0);
        highp float _1314 = _1543.w;
        highp vec4 _5441;
        if (_1314 != 0.0)
        {
            highp vec3 _1323 = _1543.xyz / vec3(_1314);
            _5441 = vec4(_1323.x, _1323.y, _1323.z, _1543.w);
        }
        else
        {
            _5441 = _1543;
        }
        _5438 = _5441;
    }
    else
    {
        _5438 = vec4(0.0);
    }
    bool _5666;
    bool _5667;
    highp vec4 _5671;
    highp vec4 _5672;
    switch (vFilterKind)
    {
        case 0:
        {
            highp vec4 _5665;
            switch (vData.x)
            {
                case 0:
                {
                    _5665 = vec4(_5435.x, _5435.y, _5435.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 1:
                {
                    highp vec3 _1782 = _5438.xyz * _5435.xyz;
                    _5665 = vec4(_1782.x, _1782.y, _1782.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 2:
                {
                    highp vec3 _1790 = (_5438.xyz + _5435.xyz) - (_5438.xyz * _5435.xyz);
                    _5665 = vec4(_1790.x, _1790.y, _1790.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 3:
                {
                    highp vec3 _1800 = _5438.xyz * 2.0;
                    highp vec3 _1806 = _1800 - vec3(1.0);
                    highp vec3 _1814 = mix(_5435.xyz * _1800, (_5435.xyz + _1806) - (_5435.xyz * _1806), step(vec3(0.5), _5438.xyz));
                    _5665 = vec4(_1814.x, _1814.y, _1814.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 4:
                {
                    highp vec3 _1633 = min(_5435.xyz, _5438.xyz);
                    _5665 = vec4(_1633.x, _1633.y, _1633.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 5:
                {
                    highp vec3 _1640 = max(_5435.xyz, _5438.xyz);
                    _5665 = vec4(_1640.x, _1640.y, _1640.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 6:
                {
                    highp float _5659;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5438.x == 0.0)
                            {
                                _5659 = 0.0;
                                break;
                            }
                            else
                            {
                                if (_5435.x == 1.0)
                                {
                                    _5659 = 1.0;
                                    break;
                                }
                                else
                                {
                                    _5659 = min(1.0, _5438.x / (1.0 - _5435.x));
                                    break;
                                }
                            }
                        }
                    }
                    highp vec4 _4967 = _5685;
                    _4967.x = _5659;
                    highp float _5661;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5438.y == 0.0)
                            {
                                _5661 = 0.0;
                                break;
                            }
                            else
                            {
                                if (_5435.y == 1.0)
                                {
                                    _5661 = 1.0;
                                    break;
                                }
                                else
                                {
                                    _5661 = min(1.0, _5438.y / (1.0 - _5435.y));
                                    break;
                                }
                            }
                        }
                    }
                    highp vec4 _4971 = _4967;
                    _4971.y = _5661;
                    highp float _5663;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5438.z == 0.0)
                            {
                                _5663 = 0.0;
                                break;
                            }
                            else
                            {
                                if (_5435.z == 1.0)
                                {
                                    _5663 = 1.0;
                                    break;
                                }
                                else
                                {
                                    _5663 = min(1.0, _5438.z / (1.0 - _5435.z));
                                    break;
                                }
                            }
                        }
                    }
                    highp vec4 _4975 = _4971;
                    _4975.z = _5663;
                    _5665 = _4975;
                    break;
                }
                case 7:
                {
                    highp float _5653;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5438.x == 1.0)
                            {
                                _5653 = 1.0;
                                break;
                            }
                            else
                            {
                                if (_5435.x == 0.0)
                                {
                                    _5653 = 0.0;
                                    break;
                                }
                                else
                                {
                                    _5653 = 1.0 - min(1.0, (1.0 - _5438.x) / _5435.x);
                                    break;
                                }
                            }
                        }
                    }
                    highp vec4 _4979 = _5685;
                    _4979.x = _5653;
                    highp float _5655;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5438.y == 1.0)
                            {
                                _5655 = 1.0;
                                break;
                            }
                            else
                            {
                                if (_5435.y == 0.0)
                                {
                                    _5655 = 0.0;
                                    break;
                                }
                                else
                                {
                                    _5655 = 1.0 - min(1.0, (1.0 - _5438.y) / _5435.y);
                                    break;
                                }
                            }
                        }
                    }
                    highp vec4 _4983 = _4979;
                    _4983.y = _5655;
                    highp float _5657;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5438.z == 1.0)
                            {
                                _5657 = 1.0;
                                break;
                            }
                            else
                            {
                                if (_5435.z == 0.0)
                                {
                                    _5657 = 0.0;
                                    break;
                                }
                                else
                                {
                                    _5657 = 1.0 - min(1.0, (1.0 - _5438.z) / _5435.z);
                                    break;
                                }
                            }
                        }
                    }
                    highp vec4 _4987 = _4983;
                    _4987.z = _5657;
                    _5665 = _4987;
                    break;
                }
                case 8:
                {
                    highp vec3 _1965 = _5435.xyz * 2.0;
                    highp vec3 _1971 = _1965 - vec3(1.0);
                    highp vec3 _1979 = mix(_5438.xyz * _1965, (_5438.xyz + _1971) - (_5438.xyz * _1971), step(vec3(0.5), _5435.xyz));
                    _5665 = vec4(_1979.x, _1979.y, _1979.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 9:
                {
                    highp float _5642;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5435.x <= 0.5)
                            {
                                _5642 = _5438.x - (((1.0 - (2.0 * _5435.x)) * _5438.x) * (1.0 - _5438.x));
                                break;
                            }
                            else
                            {
                                highp float _5641;
                                if (_5438.x <= 0.25)
                                {
                                    _5641 = ((((16.0 * _5438.x) - 12.0) * _5438.x) + 4.0) * _5438.x;
                                }
                                else
                                {
                                    _5641 = sqrt(_5438.x);
                                }
                                _5642 = _5438.x + (((2.0 * _5435.x) - 1.0) * (_5641 - _5438.x));
                                break;
                            }
                        }
                    }
                    highp vec4 _4991 = _5685;
                    _4991.x = _5642;
                    highp float _5646;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5435.y <= 0.5)
                            {
                                _5646 = _5438.y - (((1.0 - (2.0 * _5435.y)) * _5438.y) * (1.0 - _5438.y));
                                break;
                            }
                            else
                            {
                                highp float _5645;
                                if (_5438.y <= 0.25)
                                {
                                    _5645 = ((((16.0 * _5438.y) - 12.0) * _5438.y) + 4.0) * _5438.y;
                                }
                                else
                                {
                                    _5645 = sqrt(_5438.y);
                                }
                                _5646 = _5438.y + (((2.0 * _5435.y) - 1.0) * (_5645 - _5438.y));
                                break;
                            }
                        }
                    }
                    highp vec4 _4995 = _4991;
                    _4995.y = _5646;
                    highp float _5650;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5435.z <= 0.5)
                            {
                                _5650 = _5438.z - (((1.0 - (2.0 * _5435.z)) * _5438.z) * (1.0 - _5438.z));
                                break;
                            }
                            else
                            {
                                highp float _5649;
                                if (_5438.z <= 0.25)
                                {
                                    _5649 = ((((16.0 * _5438.z) - 12.0) * _5438.z) + 4.0) * _5438.z;
                                }
                                else
                                {
                                    _5649 = sqrt(_5438.z);
                                }
                                _5650 = _5438.z + (((2.0 * _5435.z) - 1.0) * (_5649 - _5438.z));
                                break;
                            }
                        }
                    }
                    highp vec4 _4999 = _4995;
                    _4999.z = _5650;
                    _5665 = _4999;
                    break;
                }
                case 10:
                {
                    highp vec3 _2134 = abs(_5438.xyz - _5435.xyz);
                    _5665 = vec4(_2134.x, _2134.y, _2134.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 11:
                {
                    highp vec3 _2143 = (_5438.xyz + _5435.xyz) - ((_5438.xyz * 2.0) * _5435.xyz);
                    _5665 = vec4(_2143.x, _2143.y, _2143.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 12:
                {
                    highp float _2175 = max(_5438.x, max(_5438.y, _5438.z)) - min(_5438.x, min(_5438.y, _5438.z));
                    highp vec3 _5621;
                    if (_5435.x <= _5435.y)
                    {
                        highp vec3 _5622;
                        if (_5435.y <= _5435.z)
                        {
                            bool _2328 = _5435.z > _5435.x;
                            highp float _5619;
                            if (_2328)
                            {
                                _5619 = ((_5435.y - _5435.x) * _2175) / (_5435.z - _5435.x);
                            }
                            else
                            {
                                _5619 = 0.0;
                            }
                            highp vec3 _5014 = _5435.xyz;
                            _5014.x = 0.0;
                            highp vec3 _5016 = _5014;
                            _5016.y = _5619;
                            highp vec3 _5018 = _5016;
                            _5018.z = _2328 ? _2175 : 0.0;
                            _5622 = _5018;
                        }
                        else
                        {
                            highp vec3 _5623;
                            if (_5435.x <= _5435.z)
                            {
                                bool _2344 = _5435.y > _5435.x;
                                highp float _5616;
                                if (_2344)
                                {
                                    _5616 = ((_5435.z - _5435.x) * _2175) / (_5435.y - _5435.x);
                                }
                                else
                                {
                                    _5616 = 0.0;
                                }
                                highp vec3 _5025 = _5435.xyz;
                                _5025.x = 0.0;
                                highp vec3 _5027 = _5025;
                                _5027.z = _5616;
                                highp vec3 _5029 = _5027;
                                _5029.y = _2344 ? _2175 : 0.0;
                                _5623 = _5029;
                            }
                            else
                            {
                                bool _2360 = _5435.y > _5435.z;
                                highp float _5613;
                                if (_2360)
                                {
                                    _5613 = ((_5435.x - _5435.z) * _2175) / (_5435.y - _5435.z);
                                }
                                else
                                {
                                    _5613 = 0.0;
                                }
                                highp vec3 _5034 = _5435.xyz;
                                _5034.z = 0.0;
                                highp vec3 _5036 = _5034;
                                _5036.x = _5613;
                                highp vec3 _5038 = _5036;
                                _5038.y = _2360 ? _2175 : 0.0;
                                _5623 = _5038;
                            }
                            _5622 = _5623;
                        }
                        _5621 = _5622;
                    }
                    else
                    {
                        highp vec3 _5624;
                        if (_5435.x <= _5435.z)
                        {
                            bool _2376 = _5435.z > _5435.y;
                            highp float _5610;
                            if (_2376)
                            {
                                _5610 = ((_5435.x - _5435.y) * _2175) / (_5435.z - _5435.y);
                            }
                            else
                            {
                                _5610 = 0.0;
                            }
                            highp vec3 _5045 = _5435.xyz;
                            _5045.y = 0.0;
                            highp vec3 _5047 = _5045;
                            _5047.x = _5610;
                            highp vec3 _5049 = _5047;
                            _5049.z = _2376 ? _2175 : 0.0;
                            _5624 = _5049;
                        }
                        else
                        {
                            highp vec3 _5625;
                            if (_5435.y <= _5435.z)
                            {
                                bool _2392 = _5435.x > _5435.y;
                                highp float _5607;
                                if (_2392)
                                {
                                    _5607 = ((_5435.z - _5435.y) * _2175) / (_5435.x - _5435.y);
                                }
                                else
                                {
                                    _5607 = 0.0;
                                }
                                highp vec3 _5056 = _5435.xyz;
                                _5056.y = 0.0;
                                highp vec3 _5058 = _5056;
                                _5058.z = _5607;
                                highp vec3 _5060 = _5058;
                                _5060.x = _2392 ? _2175 : 0.0;
                                _5625 = _5060;
                            }
                            else
                            {
                                bool _2408 = _5435.x > _5435.z;
                                highp float _5604;
                                if (_2408)
                                {
                                    _5604 = ((_5435.y - _5435.z) * _2175) / (_5435.x - _5435.z);
                                }
                                else
                                {
                                    _5604 = 0.0;
                                }
                                highp vec3 _5065 = _5435.xyz;
                                _5065.z = 0.0;
                                highp vec3 _5067 = _5065;
                                _5067.y = _5604;
                                highp vec3 _5069 = _5067;
                                _5069.x = _2408 ? _2175 : 0.0;
                                _5625 = _5069;
                            }
                            _5624 = _5625;
                        }
                        _5621 = _5624;
                    }
                    highp vec3 _2438 = _5621 + vec3(dot(_5438.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_5621, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
                    highp float _2510 = dot(_2438, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
                    highp float _2453 = _2438.x;
                    highp float _2455 = _2438.y;
                    highp float _2457 = _2438.z;
                    highp float _2459 = min(_2453, min(_2455, _2457));
                    highp float _2467 = max(_2453, max(_2455, _2457));
                    highp vec3 _5626;
                    if (_2459 < 0.0)
                    {
                        highp vec3 _2475 = vec3(_2510);
                        _5626 = _2475 + (((_2438 - _2475) * _2510) / vec3(_2510 - _2459));
                    }
                    else
                    {
                        _5626 = _2438;
                    }
                    highp vec3 _5627;
                    if (_2467 > 1.0)
                    {
                        highp vec3 _2493 = vec3(_2510);
                        _5627 = _2493 + (((_5626 - _2493) * (1.0 - _2510)) / vec3(_2467 - _2510));
                    }
                    else
                    {
                        _5627 = _5626;
                    }
                    _5665 = vec4(_5627.x, _5627.y, _5627.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 13:
                {
                    highp float _2542 = max(_5435.x, max(_5435.y, _5435.z)) - min(_5435.x, min(_5435.y, _5435.z));
                    highp vec3 _5583;
                    if (_5438.x <= _5438.y)
                    {
                        highp vec3 _5584;
                        if (_5438.y <= _5438.z)
                        {
                            bool _2695 = _5438.z > _5438.x;
                            highp float _5581;
                            if (_2695)
                            {
                                _5581 = ((_5438.y - _5438.x) * _2542) / (_5438.z - _5438.x);
                            }
                            else
                            {
                                _5581 = 0.0;
                            }
                            highp vec3 _5090 = _5438.xyz;
                            _5090.x = 0.0;
                            highp vec3 _5092 = _5090;
                            _5092.y = _5581;
                            highp vec3 _5094 = _5092;
                            _5094.z = _2695 ? _2542 : 0.0;
                            _5584 = _5094;
                        }
                        else
                        {
                            highp vec3 _5585;
                            if (_5438.x <= _5438.z)
                            {
                                bool _2711 = _5438.y > _5438.x;
                                highp float _5578;
                                if (_2711)
                                {
                                    _5578 = ((_5438.z - _5438.x) * _2542) / (_5438.y - _5438.x);
                                }
                                else
                                {
                                    _5578 = 0.0;
                                }
                                highp vec3 _5101 = _5438.xyz;
                                _5101.x = 0.0;
                                highp vec3 _5103 = _5101;
                                _5103.z = _5578;
                                highp vec3 _5105 = _5103;
                                _5105.y = _2711 ? _2542 : 0.0;
                                _5585 = _5105;
                            }
                            else
                            {
                                bool _2727 = _5438.y > _5438.z;
                                highp float _5575;
                                if (_2727)
                                {
                                    _5575 = ((_5438.x - _5438.z) * _2542) / (_5438.y - _5438.z);
                                }
                                else
                                {
                                    _5575 = 0.0;
                                }
                                highp vec3 _5110 = _5438.xyz;
                                _5110.z = 0.0;
                                highp vec3 _5112 = _5110;
                                _5112.x = _5575;
                                highp vec3 _5114 = _5112;
                                _5114.y = _2727 ? _2542 : 0.0;
                                _5585 = _5114;
                            }
                            _5584 = _5585;
                        }
                        _5583 = _5584;
                    }
                    else
                    {
                        highp vec3 _5586;
                        if (_5438.x <= _5438.z)
                        {
                            bool _2743 = _5438.z > _5438.y;
                            highp float _5572;
                            if (_2743)
                            {
                                _5572 = ((_5438.x - _5438.y) * _2542) / (_5438.z - _5438.y);
                            }
                            else
                            {
                                _5572 = 0.0;
                            }
                            highp vec3 _5121 = _5438.xyz;
                            _5121.y = 0.0;
                            highp vec3 _5123 = _5121;
                            _5123.x = _5572;
                            highp vec3 _5125 = _5123;
                            _5125.z = _2743 ? _2542 : 0.0;
                            _5586 = _5125;
                        }
                        else
                        {
                            highp vec3 _5587;
                            if (_5438.y <= _5438.z)
                            {
                                bool _2759 = _5438.x > _5438.y;
                                highp float _5569;
                                if (_2759)
                                {
                                    _5569 = ((_5438.z - _5438.y) * _2542) / (_5438.x - _5438.y);
                                }
                                else
                                {
                                    _5569 = 0.0;
                                }
                                highp vec3 _5132 = _5438.xyz;
                                _5132.y = 0.0;
                                highp vec3 _5134 = _5132;
                                _5134.z = _5569;
                                highp vec3 _5136 = _5134;
                                _5136.x = _2759 ? _2542 : 0.0;
                                _5587 = _5136;
                            }
                            else
                            {
                                bool _2775 = _5438.x > _5438.z;
                                highp float _5566;
                                if (_2775)
                                {
                                    _5566 = ((_5438.y - _5438.z) * _2542) / (_5438.x - _5438.z);
                                }
                                else
                                {
                                    _5566 = 0.0;
                                }
                                highp vec3 _5141 = _5438.xyz;
                                _5141.z = 0.0;
                                highp vec3 _5143 = _5141;
                                _5143.y = _5566;
                                highp vec3 _5145 = _5143;
                                _5145.x = _2775 ? _2542 : 0.0;
                                _5587 = _5145;
                            }
                            _5586 = _5587;
                        }
                        _5583 = _5586;
                    }
                    highp vec3 _2805 = _5583 + vec3(dot(_5438.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_5583, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
                    highp float _2877 = dot(_2805, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
                    highp float _2820 = _2805.x;
                    highp float _2822 = _2805.y;
                    highp float _2824 = _2805.z;
                    highp float _2826 = min(_2820, min(_2822, _2824));
                    highp float _2834 = max(_2820, max(_2822, _2824));
                    highp vec3 _5588;
                    if (_2826 < 0.0)
                    {
                        highp vec3 _2842 = vec3(_2877);
                        _5588 = _2842 + (((_2805 - _2842) * _2877) / vec3(_2877 - _2826));
                    }
                    else
                    {
                        _5588 = _2805;
                    }
                    highp vec3 _5589;
                    if (_2834 > 1.0)
                    {
                        highp vec3 _2860 = vec3(_2877);
                        _5589 = _2860 + (((_5588 - _2860) * (1.0 - _2877)) / vec3(_2834 - _2877));
                    }
                    else
                    {
                        _5589 = _5588;
                    }
                    _5665 = vec4(_5589.x, _5589.y, _5589.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 14:
                {
                    highp vec3 _2902 = _5435.xyz + vec3(dot(_5438.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_5435.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
                    highp float _2974 = dot(_2902, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
                    highp float _2917 = _2902.x;
                    highp float _2919 = _2902.y;
                    highp float _2921 = _2902.z;
                    highp float _2923 = min(_2917, min(_2919, _2921));
                    highp float _2931 = max(_2917, max(_2919, _2921));
                    highp vec3 _5561;
                    if (_2923 < 0.0)
                    {
                        highp vec3 _2939 = vec3(_2974);
                        _5561 = _2939 + (((_2902 - _2939) * _2974) / vec3(_2974 - _2923));
                    }
                    else
                    {
                        _5561 = _2902;
                    }
                    highp vec3 _5562;
                    if (_2931 > 1.0)
                    {
                        highp vec3 _2957 = vec3(_2974);
                        _5562 = _2957 + (((_5561 - _2957) * (1.0 - _2974)) / vec3(_2931 - _2974));
                    }
                    else
                    {
                        _5562 = _5561;
                    }
                    _5665 = vec4(_5562.x, _5562.y, _5562.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 15:
                {
                    highp vec3 _2999 = _5438.xyz + vec3(dot(_5435.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_5438.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
                    highp float _3071 = dot(_2999, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
                    highp float _3014 = _2999.x;
                    highp float _3016 = _2999.y;
                    highp float _3018 = _2999.z;
                    highp float _3020 = min(_3014, min(_3016, _3018));
                    highp float _3028 = max(_3014, max(_3016, _3018));
                    highp vec3 _5557;
                    if (_3020 < 0.0)
                    {
                        highp vec3 _3036 = vec3(_3071);
                        _5557 = _3036 + (((_2999 - _3036) * _3071) / vec3(_3071 - _3020));
                    }
                    else
                    {
                        _5557 = _2999;
                    }
                    highp vec3 _5558;
                    if (_3028 > 1.0)
                    {
                        highp vec3 _3054 = vec3(_3071);
                        _5558 = _3054 + (((_5557 - _3054) * (1.0 - _3071)) / vec3(_3028 - _3071));
                    }
                    else
                    {
                        _5558 = _5557;
                    }
                    _5665 = vec4(_5558.x, _5558.y, _5558.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                default:
                {
                    _5665 = vec4(1.0, 0.0, 0.0, 1.0);
                    break;
                }
            }
            _5671 = mix(vec4(_5438.xyz * _5438.w, _5438.w), vec4((_5435.xyz * (1.0 - _5438.w)) + (_5665.xyz * _5438.w), 1.0), vec4(_5435.w));
            _5666 = false;
            break;
        }
        case 1:
        {
            _5671 = vFilterData0;
            _5666 = false;
            break;
        }
        case 2:
        {
            highp vec3 _3076 = _5435.xyz * 12.9200000762939453125;
            highp vec3 _3080 = (vec3(1.05499994754791259765625) * pow(_5435.xyz, vec3(0.4166666567325592041015625))) - vec3(0.054999999701976776123046875);
            bvec3 _3084 = lessThanEqual(_5435.xyz, vec3(0.003130800090730190277099609375));
            highp vec3 _3085 = vec3(_3084.x ? _3076.x : _3080.x, _3084.y ? _3076.y : _3080.y, _3084.z ? _3076.z : _3080.z);
            highp vec4 _5171 = vec4(_3085.x, _3085.y, _3085.z, vec4(1.0, 0.0, 0.0, 1.0).w);
            _5171.w = _5435.w;
            _5671 = _5171;
            _5666 = true;
            break;
        }
        case 3:
        {
            highp vec3 _3091 = _5435.xyz * vec3(0.077399380505084991455078125);
            highp vec3 _3096 = pow((_5435.xyz * vec3(0.947867333889007568359375)) + vec3(0.0521326996386051177978515625), vec3(2.400000095367431640625));
            bvec3 _3100 = lessThanEqual(_5435.xyz, vec3(0.040449999272823333740234375));
            highp vec3 _3101 = vec3(_3100.x ? _3091.x : _3096.x, _3100.y ? _3091.y : _3096.y, _3100.z ? _3091.z : _3096.z);
            highp vec4 _5174 = vec4(_3101.x, _3101.y, _3101.z, vec4(1.0, 0.0, 0.0, 1.0).w);
            _5174.w = _5435.w;
            _5671 = _5174;
            _5666 = true;
            break;
        }
        case 4:
        {
            highp vec4 _5177 = vec4(_5435.x, _5435.y, _5435.z, vec4(1.0, 0.0, 0.0, 1.0).w);
            _5177.w = _5435.w * vFloat0;
            _5671 = _5177;
            _5666 = true;
            break;
        }
        case 5:
        {
            _5671 = clamp((vColorMat * _5435) + vFilterData0, vec4(0.0), vec4(1.0));
            _5666 = true;
            break;
        }
        case 6:
        {
            highp float _1406 = _5438.w * vFilterData0.w;
            _5671 = mix(vec4(vec4(vFilterData0.xyz, _1406).xyz * _1406, _1406), vec4((_5435.xyz * (1.0 - _1406)) + (_5435.xyz * _1406), 1.0), vec4(_5435.w));
            _5666 = false;
            break;
        }
        case 7:
        {
            highp vec2 _1423 = vInput1Uv.xy + vFilterData0.xy;
            highp vec2 _4655 = step(vFilterData1.xy, _1423) - step(vFilterData1.zw, _1423);
            _5671 = texture(sColor0, vec3(clamp(vec3(_1423, vInput1Uv.z).xy, vInput1UvRect.xy, vInput1UvRect.zw), vInput1Uv.z), 0.0) * (_4655.x * _4655.y);
            _5666 = false;
            break;
        }
        case 8:
        {
            highp vec4 param = _5435;
            highp vec4 _4664;
            mediump int _5674;
            for (mediump int _5443 = 0, _5444 = 0; _5443 < 4; _5444 = _5674, _5443++)
            {
                switch (vFuncs[_5443])
                {
                    case 0:
                    {
                        _5674 = _5444;
                        break;
                    }
                    case 1:
                    case 2:
                    {
                        mediump int _4690 = int(floor(param[_5443] * 255.0));
                        _4664 = texelFetch(sGpuCache, vData.xy + ivec2(_5444 + (_4690 / 4), 0), 0);
                        param[_5443] = clamp(_4664[_4690 % 4], 0.0, 1.0);
                        _5674 = _5444 + 64;
                        break;
                    }
                    case 3:
                    {
                        _4664 = texelFetch(sGpuCache, vData.xy + ivec2(_5444, 0), 0);
                        param[_5443] = clamp((_4664.x * param[_5443]) + _4664.y, 0.0, 1.0);
                        _5674 = _5444 + 1;
                        break;
                    }
                    case 4:
                    {
                        _4664 = texelFetch(sGpuCache, vData.xy + ivec2(_5444, 0), 0);
                        param[_5443] = clamp((_4664.x * pow(param[_5443], _4664.y)) + _4664.z, 0.0, 1.0);
                        _5674 = _5444 + 1;
                        break;
                    }
                    default:
                    {
                        _5674 = _5444;
                        break;
                    }
                }
            }
            _5671 = param;
            _5666 = true;
            break;
        }
        case 9:
        {
            _5671 = _5435;
            _5666 = true;
            break;
        }
        case 10:
        {
            highp vec4 _5442;
            switch (vData.x)
            {
                case 0:
                {
                    highp float _4794 = 1.0 - _5435.w;
                    highp vec3 _4796 = (_5435.xyz * _5435.w) + ((_5438.xyz * _5438.w) * _4794);
                    highp vec4 _5394 = vec4(_4796.x, _4796.y, _4796.z, vec4(0.0, 1.0, 0.0, 1.0).w);
                    _5394.w = _5435.w + (_5438.w * _4794);
                    _5442 = _5394;
                    break;
                }
                case 1:
                {
                    highp vec3 _4816 = (_5435.xyz * _5435.w) * _5438.w;
                    highp vec4 _5400 = vec4(_4816.x, _4816.y, _4816.z, vec4(0.0, 1.0, 0.0, 1.0).w);
                    _5400.w = _5435.w * _5438.w;
                    _5442 = _5400;
                    break;
                }
                case 2:
                {
                    highp float _4832 = 1.0 - _5438.w;
                    highp vec3 _4833 = (_5435.xyz * _5435.w) * _4832;
                    highp vec4 _5406 = vec4(_4833.x, _4833.y, _4833.z, vec4(0.0, 1.0, 0.0, 1.0).w);
                    _5406.w = _5435.w * _4832;
                    _5442 = _5406;
                    break;
                }
                case 3:
                {
                    highp vec3 _4860 = ((_5435.xyz * _5435.w) * _5438.w) + ((_5438.xyz * _5438.w) * (1.0 - _5435.w));
                    highp vec4 _5416 = vec4(_4860.x, _4860.y, _4860.z, vec4(0.0, 1.0, 0.0, 1.0).w);
                    _5416.w = _5438.w;
                    _5442 = _5416;
                    break;
                }
                case 4:
                {
                    highp float _4883 = 1.0 - _5438.w;
                    highp float _4892 = 1.0 - _5435.w;
                    highp vec3 _4894 = ((_5435.xyz * _5435.w) * _4883) + ((_5438.xyz * _5438.w) * _4892);
                    highp vec4 _5426 = vec4(_4894.x, _4894.y, _4894.z, vec4(0.0, 1.0, 0.0, 1.0).w);
                    _5426.w = (_5435.w * _4883) + (_5438.w * _4892);
                    _5442 = _5426;
                    break;
                }
                case 5:
                {
                    highp vec3 _4921 = (_5435.xyz * _5435.w) + (_5438.xyz * _5438.w);
                    highp vec4 _5432 = vec4(_4921.x, _4921.y, _4921.z, vec4(0.0, 1.0, 0.0, 1.0).w);
                    _5432.w = _5435.w + _5438.w;
                    _5442 = clamp(_5432, vec4(0.0), vec4(1.0));
                    break;
                }
                case 6:
                {
                    _5442 = clamp(((((vec4(vFilterData0.x) * _5435) * _5438) + (vec4(vFilterData0.y) * _5435)) + (vec4(vFilterData0.z) * _5438)) + vec4(vFilterData0.w), vec4(0.0), vec4(1.0));
                    break;
                }
                default:
                {
                    _5442 = vec4(0.0, 1.0, 0.0, 1.0);
                    break;
                }
            }
            _5672 = _5442;
            _5667 = false;
            _5671 = _5672;
            _5666 = _5667;
            break;
        }
        default:
        {
            _5672 = vec4(1.0, 0.0, 0.0, 1.0);
            _5667 = true;
            _5671 = _5672;
            _5666 = _5667;
            break;
        }
    }
    highp vec4 _5673;
    if (_5666)
    {
        highp vec3 _1470 = _5671.xyz * _5671.w;
        _5673 = vec4(_1470.x, _1470.y, _1470.z, _5671.w);
    }
    else
    {
        _5673 = _5671;
    }
    oFragColor = _5673;
}

