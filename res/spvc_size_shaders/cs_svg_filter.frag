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

vec4 _5409;

void main()
{
    highp vec4 _5411;
    if (vFilterInputCount > 0)
    {
        highp vec4 _1526 = texture(sColor0, vec3(clamp(vInput1Uv.xy, vInput1UvRect.xy, vInput1UvRect.zw), vInput1Uv.z), 0.0);
        highp float _1289 = _1526.w;
        highp vec4 _5412;
        if (_1289 != 0.0)
        {
            highp vec3 _1298 = _1526.xyz / vec3(_1289);
            _5412 = vec4(_1298.x, _1298.y, _1298.z, _1526.w);
        }
        else
        {
            _5412 = _1526;
        }
        _5411 = _5412;
    }
    else
    {
        _5411 = vec4(0.0);
    }
    highp vec4 _5414;
    if (vFilterInputCount > 1)
    {
        highp vec4 _1543 = texture(sColor1, vec3(clamp(vInput2Uv.xy, vInput2UvRect.xy, vInput2UvRect.zw), vInput2Uv.z), 0.0);
        highp float _1314 = _1543.w;
        highp vec4 _5417;
        if (_1314 != 0.0)
        {
            highp vec3 _1323 = _1543.xyz / vec3(_1314);
            _5417 = vec4(_1323.x, _1323.y, _1323.z, _1543.w);
        }
        else
        {
            _5417 = _1543;
        }
        _5414 = _5417;
    }
    else
    {
        _5414 = vec4(0.0);
    }
    bool _5107;
    bool _5108;
    highp vec4 _5492;
    highp vec4 _5493;
    switch (vFilterKind)
    {
        case 0:
        {
            highp vec4 _5491;
            switch (vData.x)
            {
                case 0:
                {
                    _5491 = vec4(_5411.x, _5411.y, _5411.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 1:
                {
                    highp vec3 _1782 = _5414.xyz * _5411.xyz;
                    _5491 = vec4(_1782.x, _1782.y, _1782.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 2:
                {
                    highp vec3 _1790 = (_5414.xyz + _5411.xyz) - (_5414.xyz * _5411.xyz);
                    _5491 = vec4(_1790.x, _1790.y, _1790.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 3:
                {
                    highp vec3 _1800 = _5414.xyz * 2.0;
                    highp vec3 _1806 = _1800 - vec3(1.0);
                    highp vec3 _1814 = mix(_5411.xyz * _1800, (_5411.xyz + _1806) - (_5411.xyz * _1806), step(vec3(0.5), _5414.xyz));
                    _5491 = vec4(_1814.x, _1814.y, _1814.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 4:
                {
                    highp vec3 _1633 = min(_5411.xyz, _5414.xyz);
                    _5491 = vec4(_1633.x, _1633.y, _1633.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 5:
                {
                    highp vec3 _1640 = max(_5411.xyz, _5414.xyz);
                    _5491 = vec4(_1640.x, _1640.y, _1640.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 6:
                {
                    highp float _5104;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5414.x == 0.0)
                            {
                                _5104 = 0.0;
                                break;
                            }
                            else
                            {
                                if (_5411.x == 1.0)
                                {
                                    _5104 = 1.0;
                                    break;
                                }
                                else
                                {
                                    _5104 = min(1.0, _5414.x / (1.0 - _5411.x));
                                    break;
                                }
                            }
                        }
                    }
                    highp vec4 _5394 = vec4(1.0, 0.0, 0.0, 1.0);
                    _5394.x = _5104;
                    highp float _5105;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5414.y == 0.0)
                            {
                                _5105 = 0.0;
                                break;
                            }
                            else
                            {
                                if (_5411.y == 1.0)
                                {
                                    _5105 = 1.0;
                                    break;
                                }
                                else
                                {
                                    _5105 = min(1.0, _5414.y / (1.0 - _5411.y));
                                    break;
                                }
                            }
                        }
                    }
                    highp vec4 _5398 = _5394;
                    _5398.y = _5105;
                    highp float _5106;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5414.z == 0.0)
                            {
                                _5106 = 0.0;
                                break;
                            }
                            else
                            {
                                if (_5411.z == 1.0)
                                {
                                    _5106 = 1.0;
                                    break;
                                }
                                else
                                {
                                    _5106 = min(1.0, _5414.z / (1.0 - _5411.z));
                                    break;
                                }
                            }
                        }
                    }
                    highp vec4 _5402 = _5398;
                    _5402.z = _5106;
                    _5491 = _5402;
                    break;
                }
                case 7:
                {
                    highp float _5101;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5414.x == 1.0)
                            {
                                _5101 = 1.0;
                                break;
                            }
                            else
                            {
                                if (_5411.x == 0.0)
                                {
                                    _5101 = 0.0;
                                    break;
                                }
                                else
                                {
                                    _5101 = 1.0 - min(1.0, (1.0 - _5414.x) / _5411.x);
                                    break;
                                }
                            }
                        }
                    }
                    highp vec4 _5382 = vec4(1.0, 0.0, 0.0, 1.0);
                    _5382.x = _5101;
                    highp float _5102;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5414.y == 1.0)
                            {
                                _5102 = 1.0;
                                break;
                            }
                            else
                            {
                                if (_5411.y == 0.0)
                                {
                                    _5102 = 0.0;
                                    break;
                                }
                                else
                                {
                                    _5102 = 1.0 - min(1.0, (1.0 - _5414.y) / _5411.y);
                                    break;
                                }
                            }
                        }
                    }
                    highp vec4 _5386 = _5382;
                    _5386.y = _5102;
                    highp float _5103;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5414.z == 1.0)
                            {
                                _5103 = 1.0;
                                break;
                            }
                            else
                            {
                                if (_5411.z == 0.0)
                                {
                                    _5103 = 0.0;
                                    break;
                                }
                                else
                                {
                                    _5103 = 1.0 - min(1.0, (1.0 - _5414.z) / _5411.z);
                                    break;
                                }
                            }
                        }
                    }
                    highp vec4 _5390 = _5386;
                    _5390.z = _5103;
                    _5491 = _5390;
                    break;
                }
                case 8:
                {
                    highp vec3 _1965 = _5411.xyz * 2.0;
                    highp vec3 _1971 = _1965 - vec3(1.0);
                    highp vec3 _1979 = mix(_5414.xyz * _1965, (_5414.xyz + _1971) - (_5414.xyz * _1971), step(vec3(0.5), _5411.xyz));
                    _5491 = vec4(_1979.x, _1979.y, _1979.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 9:
                {
                    highp float _5092;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5411.x <= 0.5)
                            {
                                _5092 = _5414.x - (((1.0 - (2.0 * _5411.x)) * _5414.x) * (1.0 - _5414.x));
                                break;
                            }
                            else
                            {
                                highp float _5091;
                                if (_5414.x <= 0.25)
                                {
                                    _5091 = ((((16.0 * _5414.x) - 12.0) * _5414.x) + 4.0) * _5414.x;
                                }
                                else
                                {
                                    _5091 = sqrt(_5414.x);
                                }
                                _5092 = _5414.x + (((2.0 * _5411.x) - 1.0) * (_5091 - _5414.x));
                                break;
                            }
                        }
                    }
                    highp vec4 _5370 = vec4(1.0, 0.0, 0.0, 1.0);
                    _5370.x = _5092;
                    highp float _5096;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5411.y <= 0.5)
                            {
                                _5096 = _5414.y - (((1.0 - (2.0 * _5411.y)) * _5414.y) * (1.0 - _5414.y));
                                break;
                            }
                            else
                            {
                                highp float _5095;
                                if (_5414.y <= 0.25)
                                {
                                    _5095 = ((((16.0 * _5414.y) - 12.0) * _5414.y) + 4.0) * _5414.y;
                                }
                                else
                                {
                                    _5095 = sqrt(_5414.y);
                                }
                                _5096 = _5414.y + (((2.0 * _5411.y) - 1.0) * (_5095 - _5414.y));
                                break;
                            }
                        }
                    }
                    highp vec4 _5374 = _5370;
                    _5374.y = _5096;
                    highp float _5100;
                    switch (0u)
                    {
                        default:
                        {
                            if (_5411.z <= 0.5)
                            {
                                _5100 = _5414.z - (((1.0 - (2.0 * _5411.z)) * _5414.z) * (1.0 - _5414.z));
                                break;
                            }
                            else
                            {
                                highp float _5099;
                                if (_5414.z <= 0.25)
                                {
                                    _5099 = ((((16.0 * _5414.z) - 12.0) * _5414.z) + 4.0) * _5414.z;
                                }
                                else
                                {
                                    _5099 = sqrt(_5414.z);
                                }
                                _5100 = _5414.z + (((2.0 * _5411.z) - 1.0) * (_5099 - _5414.z));
                                break;
                            }
                        }
                    }
                    highp vec4 _5378 = _5374;
                    _5378.z = _5100;
                    _5491 = _5378;
                    break;
                }
                case 10:
                {
                    highp vec3 _2134 = abs(_5414.xyz - _5411.xyz);
                    _5491 = vec4(_2134.x, _2134.y, _2134.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 11:
                {
                    highp vec3 _2143 = (_5414.xyz + _5411.xyz) - ((_5414.xyz * 2.0) * _5411.xyz);
                    _5491 = vec4(_2143.x, _2143.y, _2143.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 12:
                {
                    highp float _2175 = max(_5414.x, max(_5414.y, _5414.z)) - min(_5414.x, min(_5414.y, _5414.z));
                    highp vec3 _5459;
                    if (_5411.x <= _5411.y)
                    {
                        highp vec3 _5462;
                        if (_5411.y <= _5411.z)
                        {
                            bool _2328 = _5411.z > _5411.x;
                            highp float _5074;
                            if (_2328)
                            {
                                _5074 = ((_5411.y - _5411.x) * _2175) / (_5411.z - _5411.x);
                            }
                            else
                            {
                                _5074 = 0.0;
                            }
                            highp vec3 _5356 = _5411.xyz;
                            _5356.x = 0.0;
                            highp vec3 _5358 = _5356;
                            _5358.y = _5074;
                            highp vec3 _5360 = _5358;
                            _5360.z = _2328 ? _2175 : 0.0;
                            _5462 = _5360;
                        }
                        else
                        {
                            highp vec3 _5463;
                            if (_5411.x <= _5411.z)
                            {
                                bool _2344 = _5411.y > _5411.x;
                                highp float _5072;
                                if (_2344)
                                {
                                    _5072 = ((_5411.z - _5411.x) * _2175) / (_5411.y - _5411.x);
                                }
                                else
                                {
                                    _5072 = 0.0;
                                }
                                highp vec3 _5347 = _5411.xyz;
                                _5347.x = 0.0;
                                highp vec3 _5349 = _5347;
                                _5349.z = _5072;
                                highp vec3 _5351 = _5349;
                                _5351.y = _2344 ? _2175 : 0.0;
                                _5463 = _5351;
                            }
                            else
                            {
                                bool _2360 = _5411.y > _5411.z;
                                highp float _5070;
                                if (_2360)
                                {
                                    _5070 = ((_5411.x - _5411.z) * _2175) / (_5411.y - _5411.z);
                                }
                                else
                                {
                                    _5070 = 0.0;
                                }
                                highp vec3 _5338 = _5411.xyz;
                                _5338.z = 0.0;
                                highp vec3 _5340 = _5338;
                                _5340.x = _5070;
                                highp vec3 _5342 = _5340;
                                _5342.y = _2360 ? _2175 : 0.0;
                                _5463 = _5342;
                            }
                            _5462 = _5463;
                        }
                        _5459 = _5462;
                    }
                    else
                    {
                        highp vec3 _5460;
                        if (_5411.x <= _5411.z)
                        {
                            bool _2376 = _5411.z > _5411.y;
                            highp float _5068;
                            if (_2376)
                            {
                                _5068 = ((_5411.x - _5411.y) * _2175) / (_5411.z - _5411.y);
                            }
                            else
                            {
                                _5068 = 0.0;
                            }
                            highp vec3 _5325 = _5411.xyz;
                            _5325.y = 0.0;
                            highp vec3 _5327 = _5325;
                            _5327.x = _5068;
                            highp vec3 _5329 = _5327;
                            _5329.z = _2376 ? _2175 : 0.0;
                            _5460 = _5329;
                        }
                        else
                        {
                            highp vec3 _5461;
                            if (_5411.y <= _5411.z)
                            {
                                bool _2392 = _5411.x > _5411.y;
                                highp float _5066;
                                if (_2392)
                                {
                                    _5066 = ((_5411.z - _5411.y) * _2175) / (_5411.x - _5411.y);
                                }
                                else
                                {
                                    _5066 = 0.0;
                                }
                                highp vec3 _5316 = _5411.xyz;
                                _5316.y = 0.0;
                                highp vec3 _5318 = _5316;
                                _5318.z = _5066;
                                highp vec3 _5320 = _5318;
                                _5320.x = _2392 ? _2175 : 0.0;
                                _5461 = _5320;
                            }
                            else
                            {
                                bool _2408 = _5411.x > _5411.z;
                                highp float _5064;
                                if (_2408)
                                {
                                    _5064 = ((_5411.y - _5411.z) * _2175) / (_5411.x - _5411.z);
                                }
                                else
                                {
                                    _5064 = 0.0;
                                }
                                highp vec3 _5307 = _5411.xyz;
                                _5307.z = 0.0;
                                highp vec3 _5309 = _5307;
                                _5309.y = _5064;
                                highp vec3 _5311 = _5309;
                                _5311.x = _2408 ? _2175 : 0.0;
                                _5461 = _5311;
                            }
                            _5460 = _5461;
                        }
                        _5459 = _5460;
                    }
                    highp vec3 _2438 = _5459 + vec3(dot(_5414.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_5459, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
                    highp float _2510 = dot(_2438, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
                    highp float _2453 = _2438.x;
                    highp float _2455 = _2438.y;
                    highp float _2457 = _2438.z;
                    highp float _2459 = min(_2453, min(_2455, _2457));
                    highp float _2467 = max(_2453, max(_2455, _2457));
                    highp vec3 _5464;
                    if (_2459 < 0.0)
                    {
                        highp vec3 _2475 = vec3(_2510);
                        _5464 = _2475 + (((_2438 - _2475) * _2510) / vec3(_2510 - _2459));
                    }
                    else
                    {
                        _5464 = _2438;
                    }
                    highp vec3 _5465;
                    if (_2467 > 1.0)
                    {
                        highp vec3 _2493 = vec3(_2510);
                        _5465 = _2493 + (((_5464 - _2493) * (1.0 - _2510)) / vec3(_2467 - _2510));
                    }
                    else
                    {
                        _5465 = _5464;
                    }
                    _5491 = vec4(_5465.x, _5465.y, _5465.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 13:
                {
                    highp float _2542 = max(_5411.x, max(_5411.y, _5411.z)) - min(_5411.x, min(_5411.y, _5411.z));
                    highp vec3 _5433;
                    if (_5414.x <= _5414.y)
                    {
                        highp vec3 _5436;
                        if (_5414.y <= _5414.z)
                        {
                            bool _2695 = _5414.z > _5414.x;
                            highp float _5049;
                            if (_2695)
                            {
                                _5049 = ((_5414.y - _5414.x) * _2542) / (_5414.z - _5414.x);
                            }
                            else
                            {
                                _5049 = 0.0;
                            }
                            highp vec3 _5280 = _5414.xyz;
                            _5280.x = 0.0;
                            highp vec3 _5282 = _5280;
                            _5282.y = _5049;
                            highp vec3 _5284 = _5282;
                            _5284.z = _2695 ? _2542 : 0.0;
                            _5436 = _5284;
                        }
                        else
                        {
                            highp vec3 _5437;
                            if (_5414.x <= _5414.z)
                            {
                                bool _2711 = _5414.y > _5414.x;
                                highp float _5047;
                                if (_2711)
                                {
                                    _5047 = ((_5414.z - _5414.x) * _2542) / (_5414.y - _5414.x);
                                }
                                else
                                {
                                    _5047 = 0.0;
                                }
                                highp vec3 _5271 = _5414.xyz;
                                _5271.x = 0.0;
                                highp vec3 _5273 = _5271;
                                _5273.z = _5047;
                                highp vec3 _5275 = _5273;
                                _5275.y = _2711 ? _2542 : 0.0;
                                _5437 = _5275;
                            }
                            else
                            {
                                bool _2727 = _5414.y > _5414.z;
                                highp float _5045;
                                if (_2727)
                                {
                                    _5045 = ((_5414.x - _5414.z) * _2542) / (_5414.y - _5414.z);
                                }
                                else
                                {
                                    _5045 = 0.0;
                                }
                                highp vec3 _5262 = _5414.xyz;
                                _5262.z = 0.0;
                                highp vec3 _5264 = _5262;
                                _5264.x = _5045;
                                highp vec3 _5266 = _5264;
                                _5266.y = _2727 ? _2542 : 0.0;
                                _5437 = _5266;
                            }
                            _5436 = _5437;
                        }
                        _5433 = _5436;
                    }
                    else
                    {
                        highp vec3 _5434;
                        if (_5414.x <= _5414.z)
                        {
                            bool _2743 = _5414.z > _5414.y;
                            highp float _5043;
                            if (_2743)
                            {
                                _5043 = ((_5414.x - _5414.y) * _2542) / (_5414.z - _5414.y);
                            }
                            else
                            {
                                _5043 = 0.0;
                            }
                            highp vec3 _5249 = _5414.xyz;
                            _5249.y = 0.0;
                            highp vec3 _5251 = _5249;
                            _5251.x = _5043;
                            highp vec3 _5253 = _5251;
                            _5253.z = _2743 ? _2542 : 0.0;
                            _5434 = _5253;
                        }
                        else
                        {
                            highp vec3 _5435;
                            if (_5414.y <= _5414.z)
                            {
                                bool _2759 = _5414.x > _5414.y;
                                highp float _5041;
                                if (_2759)
                                {
                                    _5041 = ((_5414.z - _5414.y) * _2542) / (_5414.x - _5414.y);
                                }
                                else
                                {
                                    _5041 = 0.0;
                                }
                                highp vec3 _5240 = _5414.xyz;
                                _5240.y = 0.0;
                                highp vec3 _5242 = _5240;
                                _5242.z = _5041;
                                highp vec3 _5244 = _5242;
                                _5244.x = _2759 ? _2542 : 0.0;
                                _5435 = _5244;
                            }
                            else
                            {
                                bool _2775 = _5414.x > _5414.z;
                                highp float _5039;
                                if (_2775)
                                {
                                    _5039 = ((_5414.y - _5414.z) * _2542) / (_5414.x - _5414.z);
                                }
                                else
                                {
                                    _5039 = 0.0;
                                }
                                highp vec3 _5231 = _5414.xyz;
                                _5231.z = 0.0;
                                highp vec3 _5233 = _5231;
                                _5233.y = _5039;
                                highp vec3 _5235 = _5233;
                                _5235.x = _2775 ? _2542 : 0.0;
                                _5435 = _5235;
                            }
                            _5434 = _5435;
                        }
                        _5433 = _5434;
                    }
                    highp vec3 _2805 = _5433 + vec3(dot(_5414.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_5433, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
                    highp float _2877 = dot(_2805, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
                    highp float _2820 = _2805.x;
                    highp float _2822 = _2805.y;
                    highp float _2824 = _2805.z;
                    highp float _2826 = min(_2820, min(_2822, _2824));
                    highp float _2834 = max(_2820, max(_2822, _2824));
                    highp vec3 _5438;
                    if (_2826 < 0.0)
                    {
                        highp vec3 _2842 = vec3(_2877);
                        _5438 = _2842 + (((_2805 - _2842) * _2877) / vec3(_2877 - _2826));
                    }
                    else
                    {
                        _5438 = _2805;
                    }
                    highp vec3 _5439;
                    if (_2834 > 1.0)
                    {
                        highp vec3 _2860 = vec3(_2877);
                        _5439 = _2860 + (((_5438 - _2860) * (1.0 - _2877)) / vec3(_2834 - _2877));
                    }
                    else
                    {
                        _5439 = _5438;
                    }
                    _5491 = vec4(_5439.x, _5439.y, _5439.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 14:
                {
                    highp vec3 _2902 = _5411.xyz + vec3(dot(_5414.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_5411.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
                    highp float _2974 = dot(_2902, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
                    highp float _2917 = _2902.x;
                    highp float _2919 = _2902.y;
                    highp float _2921 = _2902.z;
                    highp float _2923 = min(_2917, min(_2919, _2921));
                    highp float _2931 = max(_2917, max(_2919, _2921));
                    highp vec3 _5423;
                    if (_2923 < 0.0)
                    {
                        highp vec3 _2939 = vec3(_2974);
                        _5423 = _2939 + (((_2902 - _2939) * _2974) / vec3(_2974 - _2923));
                    }
                    else
                    {
                        _5423 = _2902;
                    }
                    highp vec3 _5424;
                    if (_2931 > 1.0)
                    {
                        highp vec3 _2957 = vec3(_2974);
                        _5424 = _2957 + (((_5423 - _2957) * (1.0 - _2974)) / vec3(_2931 - _2974));
                    }
                    else
                    {
                        _5424 = _5423;
                    }
                    _5491 = vec4(_5424.x, _5424.y, _5424.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                case 15:
                {
                    highp vec3 _2999 = _5414.xyz + vec3(dot(_5411.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_5414.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
                    highp float _3071 = dot(_2999, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
                    highp float _3014 = _2999.x;
                    highp float _3016 = _2999.y;
                    highp float _3018 = _2999.z;
                    highp float _3020 = min(_3014, min(_3016, _3018));
                    highp float _3028 = max(_3014, max(_3016, _3018));
                    highp vec3 _5419;
                    if (_3020 < 0.0)
                    {
                        highp vec3 _3036 = vec3(_3071);
                        _5419 = _3036 + (((_2999 - _3036) * _3071) / vec3(_3071 - _3020));
                    }
                    else
                    {
                        _5419 = _2999;
                    }
                    highp vec3 _5420;
                    if (_3028 > 1.0)
                    {
                        highp vec3 _3054 = vec3(_3071);
                        _5420 = _3054 + (((_5419 - _3054) * (1.0 - _3071)) / vec3(_3028 - _3071));
                    }
                    else
                    {
                        _5420 = _5419;
                    }
                    _5491 = vec4(_5420.x, _5420.y, _5420.z, vec4(1.0, 0.0, 0.0, 1.0).w);
                    break;
                }
                default:
                {
                    _5491 = vec4(1.0, 0.0, 0.0, 1.0);
                    break;
                }
            }
            _5492 = mix(vec4(_5414.xyz * _5414.w, _5414.w), vec4((_5411.xyz * (1.0 - _5414.w)) + (_5491.xyz * _5414.w), 1.0), vec4(_5411.w));
            _5107 = false;
            break;
        }
        case 1:
        {
            _5492 = vFilterData0;
            _5107 = false;
            break;
        }
        case 2:
        {
            highp vec3 _3076 = _5411.xyz * 12.9200000762939453125;
            highp vec3 _3080 = (vec3(1.05499994754791259765625) * pow(_5411.xyz, vec3(0.4166666567325592041015625))) - vec3(0.054999999701976776123046875);
            bvec3 _3084 = lessThanEqual(_5411.xyz, vec3(0.003130800090730190277099609375));
            highp vec3 _3085 = vec3(_3084.x ? _3076.x : _3080.x, _3084.y ? _3076.y : _3080.y, _3084.z ? _3076.z : _3080.z);
            highp vec4 _5202 = vec4(_3085.x, _3085.y, _3085.z, _5409.w);
            _5202.w = _5411.w;
            _5492 = _5202;
            _5107 = true;
            break;
        }
        case 3:
        {
            highp vec3 _3091 = _5411.xyz * vec3(0.077399380505084991455078125);
            highp vec3 _3096 = pow((_5411.xyz * vec3(0.947867333889007568359375)) + vec3(0.0521326996386051177978515625), vec3(2.400000095367431640625));
            bvec3 _3100 = lessThanEqual(_5411.xyz, vec3(0.040449999272823333740234375));
            highp vec3 _3101 = vec3(_3100.x ? _3091.x : _3096.x, _3100.y ? _3091.y : _3096.y, _3100.z ? _3091.z : _3096.z);
            highp vec4 _5199 = vec4(_3101.x, _3101.y, _3101.z, _5409.w);
            _5199.w = _5411.w;
            _5492 = _5199;
            _5107 = true;
            break;
        }
        case 4:
        {
            highp vec4 _5196 = vec4(_5411.x, _5411.y, _5411.z, _5409.w);
            _5196.w = _5411.w * vFloat0;
            _5492 = _5196;
            _5107 = true;
            break;
        }
        case 5:
        {
            _5492 = clamp((vColorMat * _5411) + vFilterData0, vec4(0.0), vec4(1.0));
            _5107 = true;
            break;
        }
        case 6:
        {
            highp float _1406 = _5414.w * vFilterData0.w;
            _5492 = mix(vec4(vec4(vFilterData0.xyz, _1406).xyz * _1406, _1406), vec4((_5411.xyz * (1.0 - _1406)) + (_5411.xyz * _1406), 1.0), vec4(_5411.w));
            _5107 = false;
            break;
        }
        case 7:
        {
            highp vec2 _1423 = vInput1Uv.xy + vFilterData0.xy;
            highp vec2 _4655 = step(vFilterData1.xy, _1423) - step(vFilterData1.zw, _1423);
            _5492 = texture(sColor0, vec3(clamp(vec3(_1423, vInput1Uv.z).xy, vInput1UvRect.xy, vInput1UvRect.zw), vInput1Uv.z), 0.0) * (_4655.x * _4655.y);
            _5107 = false;
            break;
        }
        case 8:
        {
            highp vec4 param = _5411;
            highp vec4 _4664;
            mediump int _5112;
            for (mediump int _4958 = 0, _4959 = 0; _4958 < 4; _4959 = _5112, _4958++)
            {
                switch (vFuncs[_4958])
                {
                    case 0:
                    {
                        _5112 = _4959;
                        break;
                    }
                    case 1:
                    case 2:
                    {
                        mediump int _4690 = int(floor(param[_4958] * 255.0));
                        _4664 = texelFetch(sGpuCache, vData.xy + ivec2(_4959 + (_4690 / 4), 0), 0);
                        param[_4958] = clamp(_4664[_4690 % 4], 0.0, 1.0);
                        _5112 = _4959 + 64;
                        break;
                    }
                    case 3:
                    {
                        _4664 = texelFetch(sGpuCache, vData.xy + ivec2(_4959, 0), 0);
                        param[_4958] = clamp((_4664.x * param[_4958]) + _4664.y, 0.0, 1.0);
                        _5112 = _4959 + 1;
                        break;
                    }
                    case 4:
                    {
                        _4664 = texelFetch(sGpuCache, vData.xy + ivec2(_4959, 0), 0);
                        param[_4958] = clamp((_4664.x * pow(param[_4958], _4664.y)) + _4664.z, 0.0, 1.0);
                        _5112 = _4959 + 1;
                        break;
                    }
                    default:
                    {
                        _5112 = _4959;
                        break;
                    }
                }
            }
            _5492 = param;
            _5107 = true;
            break;
        }
        case 9:
        {
            _5492 = _5411;
            _5107 = true;
            break;
        }
        case 10:
        {
            highp vec4 _5418;
            switch (vData.x)
            {
                case 0:
                {
                    highp float _4794 = 1.0 - _5411.w;
                    highp vec3 _4796 = (_5411.xyz * _5411.w) + ((_5414.xyz * _5414.w) * _4794);
                    highp vec4 _5184 = vec4(_4796.x, _4796.y, _4796.z, _5409.w);
                    _5184.w = _5411.w + (_5414.w * _4794);
                    _5418 = _5184;
                    break;
                }
                case 1:
                {
                    highp vec3 _4816 = (_5411.xyz * _5411.w) * _5414.w;
                    highp vec4 _5176 = vec4(_4816.x, _4816.y, _4816.z, _5409.w);
                    _5176.w = _5411.w * _5414.w;
                    _5418 = _5176;
                    break;
                }
                case 2:
                {
                    highp float _4832 = 1.0 - _5414.w;
                    highp vec3 _4833 = (_5411.xyz * _5411.w) * _4832;
                    highp vec4 _5170 = vec4(_4833.x, _4833.y, _4833.z, _5409.w);
                    _5170.w = _5411.w * _4832;
                    _5418 = _5170;
                    break;
                }
                case 3:
                {
                    highp vec3 _4860 = ((_5411.xyz * _5411.w) * _5414.w) + ((_5414.xyz * _5414.w) * (1.0 - _5411.w));
                    highp vec4 _5164 = vec4(_4860.x, _4860.y, _4860.z, _5409.w);
                    _5164.w = _5414.w;
                    _5418 = _5164;
                    break;
                }
                case 4:
                {
                    highp float _4883 = 1.0 - _5414.w;
                    highp float _4892 = 1.0 - _5411.w;
                    highp vec3 _4894 = ((_5411.xyz * _5411.w) * _4883) + ((_5414.xyz * _5414.w) * _4892);
                    highp vec4 _5154 = vec4(_4894.x, _4894.y, _4894.z, _5409.w);
                    _5154.w = (_5411.w * _4883) + (_5414.w * _4892);
                    _5418 = _5154;
                    break;
                }
                case 5:
                {
                    highp vec3 _4921 = (_5411.xyz * _5411.w) + (_5414.xyz * _5414.w);
                    highp vec4 _5144 = vec4(_4921.x, _4921.y, _4921.z, _5409.w);
                    _5144.w = _5411.w + _5414.w;
                    _5418 = clamp(_5144, vec4(0.0), vec4(1.0));
                    break;
                }
                case 6:
                {
                    _5418 = clamp(((((vec4(vFilterData0.x) * _5411) * _5414) + (vec4(vFilterData0.y) * _5411)) + (vec4(vFilterData0.z) * _5414)) + vec4(vFilterData0.w), vec4(0.0), vec4(1.0));
                    break;
                }
                default:
                {
                    _5418 = vec4(0.0, 1.0, 0.0, 1.0);
                    break;
                }
            }
            _5493 = _5418;
            _5108 = false;
            _5492 = _5493;
            _5107 = _5108;
            break;
        }
        default:
        {
            _5493 = vec4(1.0, 0.0, 0.0, 1.0);
            _5108 = true;
            _5492 = _5493;
            _5107 = _5108;
            break;
        }
    }
    highp vec4 _5494;
    if (_5107)
    {
        highp vec3 _1470 = _5492.xyz * _5492.w;
        _5494 = vec4(_1470.x, _1470.y, _1470.z, _5492.w);
    }
    else
    {
        _5494 = _5492;
    }
    oFragColor = _5494;
}

