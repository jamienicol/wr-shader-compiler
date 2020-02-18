#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassColor;

layout(location = 0) out highp vec4 oFragColor;
in highp vec4 varying_vec4_1;
in highp vec4 varying_vec4_0;
flat in mediump ivec4 flat_varying_ivec4_0;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in int flat_varying_highp_int_address_0;

void main()
{
    highp vec4 _983 = textureLod(sPrevPassColor, vec3(varying_vec4_1.xy, varying_vec4_1.w), 0.0);
    highp vec4 _992 = textureLod(sPrevPassColor, vec3(varying_vec4_0.xy, varying_vec4_0.w), 0.0);
    highp float _994 = _983.w;
    highp vec4 _2800;
    if (_994 != 0.0)
    {
        highp vec3 _1003 = _983.xyz / vec3(_994);
        _2800 = vec4(_1003.x, _1003.y, _1003.z, _983.w);
    }
    else
    {
        _2800 = _983;
    }
    highp float _1007 = _992.w;
    highp vec4 _2801;
    if (_1007 != 0.0)
    {
        highp vec3 _1016 = _992.xyz / vec3(_1007);
        _2801 = vec4(_1016.x, _1016.y, _1016.z, _992.w);
    }
    else
    {
        _2801 = _992;
    }
    highp vec4 _2960;
    switch (flat_varying_ivec4_0.x)
    {
        case 1:
        {
            highp vec3 _1205 = _2800.xyz * _2801.xyz;
            _2960 = vec4(_1205.x, _1205.y, _1205.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 2:
        {
            highp vec3 _1213 = (_2800.xyz + _2801.xyz) - (_2800.xyz * _2801.xyz);
            _2960 = vec4(_1213.x, _1213.y, _1213.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 3:
        {
            highp vec3 _1223 = _2800.xyz * 2.0;
            highp vec3 _1229 = _1223 - vec3(1.0);
            highp vec3 _1237 = mix(_2801.xyz * _1223, (_2801.xyz + _1229) - (_2801.xyz * _1229), step(vec3(0.5), _2800.xyz));
            _2960 = vec4(_1237.x, _1237.y, _1237.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 4:
        {
            highp vec3 _1063 = min(_2801.xyz, _2800.xyz);
            _2960 = vec4(_1063.x, _1063.y, _1063.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 5:
        {
            highp vec3 _1070 = max(_2801.xyz, _2800.xyz);
            _2960 = vec4(_1070.x, _1070.y, _1070.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 6:
        {
            highp float _2571;
            switch (0u)
            {
                default:
                {
                    if (_2800.x == 0.0)
                    {
                        _2571 = 0.0;
                        break;
                    }
                    else
                    {
                        if (_2801.x == 1.0)
                        {
                            _2571 = 1.0;
                            break;
                        }
                        else
                        {
                            _2571 = min(1.0, _2800.x / (1.0 - _2801.x));
                            break;
                        }
                    }
                }
            }
            highp vec4 _2783 = vec4(1.0, 1.0, 0.0, 1.0);
            _2783.x = _2571;
            highp float _2572;
            switch (0u)
            {
                default:
                {
                    if (_2800.y == 0.0)
                    {
                        _2572 = 0.0;
                        break;
                    }
                    else
                    {
                        if (_2801.y == 1.0)
                        {
                            _2572 = 1.0;
                            break;
                        }
                        else
                        {
                            _2572 = min(1.0, _2800.y / (1.0 - _2801.y));
                            break;
                        }
                    }
                }
            }
            highp vec4 _2787 = _2783;
            _2787.y = _2572;
            highp float _2573;
            switch (0u)
            {
                default:
                {
                    if (_2800.z == 0.0)
                    {
                        _2573 = 0.0;
                        break;
                    }
                    else
                    {
                        if (_2801.z == 1.0)
                        {
                            _2573 = 1.0;
                            break;
                        }
                        else
                        {
                            _2573 = min(1.0, _2800.z / (1.0 - _2801.z));
                            break;
                        }
                    }
                }
            }
            highp vec4 _2791 = _2787;
            _2791.z = _2573;
            _2960 = _2791;
            break;
        }
        case 7:
        {
            highp float _2568;
            switch (0u)
            {
                default:
                {
                    if (_2800.x == 1.0)
                    {
                        _2568 = 1.0;
                        break;
                    }
                    else
                    {
                        if (_2801.x == 0.0)
                        {
                            _2568 = 0.0;
                            break;
                        }
                        else
                        {
                            _2568 = 1.0 - min(1.0, (1.0 - _2800.x) / _2801.x);
                            break;
                        }
                    }
                }
            }
            highp vec4 _2771 = vec4(1.0, 1.0, 0.0, 1.0);
            _2771.x = _2568;
            highp float _2569;
            switch (0u)
            {
                default:
                {
                    if (_2800.y == 1.0)
                    {
                        _2569 = 1.0;
                        break;
                    }
                    else
                    {
                        if (_2801.y == 0.0)
                        {
                            _2569 = 0.0;
                            break;
                        }
                        else
                        {
                            _2569 = 1.0 - min(1.0, (1.0 - _2800.y) / _2801.y);
                            break;
                        }
                    }
                }
            }
            highp vec4 _2775 = _2771;
            _2775.y = _2569;
            highp float _2570;
            switch (0u)
            {
                default:
                {
                    if (_2800.z == 1.0)
                    {
                        _2570 = 1.0;
                        break;
                    }
                    else
                    {
                        if (_2801.z == 0.0)
                        {
                            _2570 = 0.0;
                            break;
                        }
                        else
                        {
                            _2570 = 1.0 - min(1.0, (1.0 - _2800.z) / _2801.z);
                            break;
                        }
                    }
                }
            }
            highp vec4 _2779 = _2775;
            _2779.z = _2570;
            _2960 = _2779;
            break;
        }
        case 8:
        {
            highp vec3 _1388 = _2801.xyz * 2.0;
            highp vec3 _1394 = _1388 - vec3(1.0);
            highp vec3 _1402 = mix(_2800.xyz * _1388, (_2800.xyz + _1394) - (_2800.xyz * _1394), step(vec3(0.5), _2801.xyz));
            _2960 = vec4(_1402.x, _1402.y, _1402.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 9:
        {
            highp float _2559;
            switch (0u)
            {
                default:
                {
                    if (_2801.x <= 0.5)
                    {
                        _2559 = _2800.x - (((1.0 - (2.0 * _2801.x)) * _2800.x) * (1.0 - _2800.x));
                        break;
                    }
                    else
                    {
                        highp float _2558;
                        if (_2800.x <= 0.25)
                        {
                            _2558 = ((((16.0 * _2800.x) - 12.0) * _2800.x) + 4.0) * _2800.x;
                        }
                        else
                        {
                            _2558 = sqrt(_2800.x);
                        }
                        _2559 = _2800.x + (((2.0 * _2801.x) - 1.0) * (_2558 - _2800.x));
                        break;
                    }
                }
            }
            highp vec4 _2759 = vec4(1.0, 1.0, 0.0, 1.0);
            _2759.x = _2559;
            highp float _2563;
            switch (0u)
            {
                default:
                {
                    if (_2801.y <= 0.5)
                    {
                        _2563 = _2800.y - (((1.0 - (2.0 * _2801.y)) * _2800.y) * (1.0 - _2800.y));
                        break;
                    }
                    else
                    {
                        highp float _2562;
                        if (_2800.y <= 0.25)
                        {
                            _2562 = ((((16.0 * _2800.y) - 12.0) * _2800.y) + 4.0) * _2800.y;
                        }
                        else
                        {
                            _2562 = sqrt(_2800.y);
                        }
                        _2563 = _2800.y + (((2.0 * _2801.y) - 1.0) * (_2562 - _2800.y));
                        break;
                    }
                }
            }
            highp vec4 _2763 = _2759;
            _2763.y = _2563;
            highp float _2567;
            switch (0u)
            {
                default:
                {
                    if (_2801.z <= 0.5)
                    {
                        _2567 = _2800.z - (((1.0 - (2.0 * _2801.z)) * _2800.z) * (1.0 - _2800.z));
                        break;
                    }
                    else
                    {
                        highp float _2566;
                        if (_2800.z <= 0.25)
                        {
                            _2566 = ((((16.0 * _2800.z) - 12.0) * _2800.z) + 4.0) * _2800.z;
                        }
                        else
                        {
                            _2566 = sqrt(_2800.z);
                        }
                        _2567 = _2800.z + (((2.0 * _2801.z) - 1.0) * (_2566 - _2800.z));
                        break;
                    }
                }
            }
            highp vec4 _2767 = _2763;
            _2767.z = _2567;
            _2960 = _2767;
            break;
        }
        case 10:
        {
            highp vec3 _1557 = abs(_2800.xyz - _2801.xyz);
            _2960 = vec4(_1557.x, _1557.y, _1557.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 11:
        {
            highp vec3 _1566 = (_2800.xyz + _2801.xyz) - ((_2800.xyz * 2.0) * _2801.xyz);
            _2960 = vec4(_1566.x, _1566.y, _1566.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 12:
        {
            highp float _1598 = max(_2800.x, max(_2800.y, _2800.z)) - min(_2800.x, min(_2800.y, _2800.z));
            highp vec3 _2842;
            if (_2801.x <= _2801.y)
            {
                highp vec3 _2845;
                if (_2801.y <= _2801.z)
                {
                    bool _1751 = _2801.z > _2801.x;
                    highp float _2541;
                    if (_1751)
                    {
                        _2541 = ((_2801.y - _2801.x) * _1598) / (_2801.z - _2801.x);
                    }
                    else
                    {
                        _2541 = 0.0;
                    }
                    highp vec3 _2745 = _2801.xyz;
                    _2745.x = 0.0;
                    highp vec3 _2747 = _2745;
                    _2747.y = _2541;
                    highp vec3 _2749 = _2747;
                    _2749.z = _1751 ? _1598 : 0.0;
                    _2845 = _2749;
                }
                else
                {
                    highp vec3 _2846;
                    if (_2801.x <= _2801.z)
                    {
                        bool _1767 = _2801.y > _2801.x;
                        highp float _2539;
                        if (_1767)
                        {
                            _2539 = ((_2801.z - _2801.x) * _1598) / (_2801.y - _2801.x);
                        }
                        else
                        {
                            _2539 = 0.0;
                        }
                        highp vec3 _2736 = _2801.xyz;
                        _2736.x = 0.0;
                        highp vec3 _2738 = _2736;
                        _2738.z = _2539;
                        highp vec3 _2740 = _2738;
                        _2740.y = _1767 ? _1598 : 0.0;
                        _2846 = _2740;
                    }
                    else
                    {
                        bool _1783 = _2801.y > _2801.z;
                        highp float _2537;
                        if (_1783)
                        {
                            _2537 = ((_2801.x - _2801.z) * _1598) / (_2801.y - _2801.z);
                        }
                        else
                        {
                            _2537 = 0.0;
                        }
                        highp vec3 _2727 = _2801.xyz;
                        _2727.z = 0.0;
                        highp vec3 _2729 = _2727;
                        _2729.x = _2537;
                        highp vec3 _2731 = _2729;
                        _2731.y = _1783 ? _1598 : 0.0;
                        _2846 = _2731;
                    }
                    _2845 = _2846;
                }
                _2842 = _2845;
            }
            else
            {
                highp vec3 _2843;
                if (_2801.x <= _2801.z)
                {
                    bool _1799 = _2801.z > _2801.y;
                    highp float _2535;
                    if (_1799)
                    {
                        _2535 = ((_2801.x - _2801.y) * _1598) / (_2801.z - _2801.y);
                    }
                    else
                    {
                        _2535 = 0.0;
                    }
                    highp vec3 _2714 = _2801.xyz;
                    _2714.y = 0.0;
                    highp vec3 _2716 = _2714;
                    _2716.x = _2535;
                    highp vec3 _2718 = _2716;
                    _2718.z = _1799 ? _1598 : 0.0;
                    _2843 = _2718;
                }
                else
                {
                    highp vec3 _2844;
                    if (_2801.y <= _2801.z)
                    {
                        bool _1815 = _2801.x > _2801.y;
                        highp float _2533;
                        if (_1815)
                        {
                            _2533 = ((_2801.z - _2801.y) * _1598) / (_2801.x - _2801.y);
                        }
                        else
                        {
                            _2533 = 0.0;
                        }
                        highp vec3 _2705 = _2801.xyz;
                        _2705.y = 0.0;
                        highp vec3 _2707 = _2705;
                        _2707.z = _2533;
                        highp vec3 _2709 = _2707;
                        _2709.x = _1815 ? _1598 : 0.0;
                        _2844 = _2709;
                    }
                    else
                    {
                        bool _1831 = _2801.x > _2801.z;
                        highp float _2531;
                        if (_1831)
                        {
                            _2531 = ((_2801.y - _2801.z) * _1598) / (_2801.x - _2801.z);
                        }
                        else
                        {
                            _2531 = 0.0;
                        }
                        highp vec3 _2696 = _2801.xyz;
                        _2696.z = 0.0;
                        highp vec3 _2698 = _2696;
                        _2698.y = _2531;
                        highp vec3 _2700 = _2698;
                        _2700.x = _1831 ? _1598 : 0.0;
                        _2844 = _2700;
                    }
                    _2843 = _2844;
                }
                _2842 = _2843;
            }
            highp vec3 _1861 = _2842 + vec3(dot(_2800.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_2842, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
            highp float _1933 = dot(_1861, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
            highp float _1876 = _1861.x;
            highp float _1878 = _1861.y;
            highp float _1880 = _1861.z;
            highp float _1882 = min(_1876, min(_1878, _1880));
            highp float _1890 = max(_1876, max(_1878, _1880));
            highp vec3 _2847;
            if (_1882 < 0.0)
            {
                highp vec3 _1898 = vec3(_1933);
                _2847 = _1898 + (((_1861 - _1898) * _1933) / vec3(_1933 - _1882));
            }
            else
            {
                _2847 = _1861;
            }
            highp vec3 _2848;
            if (_1890 > 1.0)
            {
                highp vec3 _1916 = vec3(_1933);
                _2848 = _1916 + (((_2847 - _1916) * (1.0 - _1933)) / vec3(_1890 - _1933));
            }
            else
            {
                _2848 = _2847;
            }
            _2960 = vec4(_2848.x, _2848.y, _2848.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 13:
        {
            highp float _1965 = max(_2801.x, max(_2801.y, _2801.z)) - min(_2801.x, min(_2801.y, _2801.z));
            highp vec3 _2816;
            if (_2800.x <= _2800.y)
            {
                highp vec3 _2819;
                if (_2800.y <= _2800.z)
                {
                    bool _2118 = _2800.z > _2800.x;
                    highp float _2516;
                    if (_2118)
                    {
                        _2516 = ((_2800.y - _2800.x) * _1965) / (_2800.z - _2800.x);
                    }
                    else
                    {
                        _2516 = 0.0;
                    }
                    highp vec3 _2669 = _2800.xyz;
                    _2669.x = 0.0;
                    highp vec3 _2671 = _2669;
                    _2671.y = _2516;
                    highp vec3 _2673 = _2671;
                    _2673.z = _2118 ? _1965 : 0.0;
                    _2819 = _2673;
                }
                else
                {
                    highp vec3 _2820;
                    if (_2800.x <= _2800.z)
                    {
                        bool _2134 = _2800.y > _2800.x;
                        highp float _2514;
                        if (_2134)
                        {
                            _2514 = ((_2800.z - _2800.x) * _1965) / (_2800.y - _2800.x);
                        }
                        else
                        {
                            _2514 = 0.0;
                        }
                        highp vec3 _2660 = _2800.xyz;
                        _2660.x = 0.0;
                        highp vec3 _2662 = _2660;
                        _2662.z = _2514;
                        highp vec3 _2664 = _2662;
                        _2664.y = _2134 ? _1965 : 0.0;
                        _2820 = _2664;
                    }
                    else
                    {
                        bool _2150 = _2800.y > _2800.z;
                        highp float _2512;
                        if (_2150)
                        {
                            _2512 = ((_2800.x - _2800.z) * _1965) / (_2800.y - _2800.z);
                        }
                        else
                        {
                            _2512 = 0.0;
                        }
                        highp vec3 _2651 = _2800.xyz;
                        _2651.z = 0.0;
                        highp vec3 _2653 = _2651;
                        _2653.x = _2512;
                        highp vec3 _2655 = _2653;
                        _2655.y = _2150 ? _1965 : 0.0;
                        _2820 = _2655;
                    }
                    _2819 = _2820;
                }
                _2816 = _2819;
            }
            else
            {
                highp vec3 _2817;
                if (_2800.x <= _2800.z)
                {
                    bool _2166 = _2800.z > _2800.y;
                    highp float _2510;
                    if (_2166)
                    {
                        _2510 = ((_2800.x - _2800.y) * _1965) / (_2800.z - _2800.y);
                    }
                    else
                    {
                        _2510 = 0.0;
                    }
                    highp vec3 _2638 = _2800.xyz;
                    _2638.y = 0.0;
                    highp vec3 _2640 = _2638;
                    _2640.x = _2510;
                    highp vec3 _2642 = _2640;
                    _2642.z = _2166 ? _1965 : 0.0;
                    _2817 = _2642;
                }
                else
                {
                    highp vec3 _2818;
                    if (_2800.y <= _2800.z)
                    {
                        bool _2182 = _2800.x > _2800.y;
                        highp float _2508;
                        if (_2182)
                        {
                            _2508 = ((_2800.z - _2800.y) * _1965) / (_2800.x - _2800.y);
                        }
                        else
                        {
                            _2508 = 0.0;
                        }
                        highp vec3 _2629 = _2800.xyz;
                        _2629.y = 0.0;
                        highp vec3 _2631 = _2629;
                        _2631.z = _2508;
                        highp vec3 _2633 = _2631;
                        _2633.x = _2182 ? _1965 : 0.0;
                        _2818 = _2633;
                    }
                    else
                    {
                        bool _2198 = _2800.x > _2800.z;
                        highp float _2506;
                        if (_2198)
                        {
                            _2506 = ((_2800.y - _2800.z) * _1965) / (_2800.x - _2800.z);
                        }
                        else
                        {
                            _2506 = 0.0;
                        }
                        highp vec3 _2620 = _2800.xyz;
                        _2620.z = 0.0;
                        highp vec3 _2622 = _2620;
                        _2622.y = _2506;
                        highp vec3 _2624 = _2622;
                        _2624.x = _2198 ? _1965 : 0.0;
                        _2818 = _2624;
                    }
                    _2817 = _2818;
                }
                _2816 = _2817;
            }
            highp vec3 _2228 = _2816 + vec3(dot(_2800.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_2816, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
            highp float _2300 = dot(_2228, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
            highp float _2243 = _2228.x;
            highp float _2245 = _2228.y;
            highp float _2247 = _2228.z;
            highp float _2249 = min(_2243, min(_2245, _2247));
            highp float _2257 = max(_2243, max(_2245, _2247));
            highp vec3 _2821;
            if (_2249 < 0.0)
            {
                highp vec3 _2265 = vec3(_2300);
                _2821 = _2265 + (((_2228 - _2265) * _2300) / vec3(_2300 - _2249));
            }
            else
            {
                _2821 = _2228;
            }
            highp vec3 _2822;
            if (_2257 > 1.0)
            {
                highp vec3 _2283 = vec3(_2300);
                _2822 = _2283 + (((_2821 - _2283) * (1.0 - _2300)) / vec3(_2257 - _2300));
            }
            else
            {
                _2822 = _2821;
            }
            _2960 = vec4(_2822.x, _2822.y, _2822.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 14:
        {
            highp vec3 _2325 = _2801.xyz + vec3(dot(_2800.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_2801.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
            highp float _2397 = dot(_2325, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
            highp float _2340 = _2325.x;
            highp float _2342 = _2325.y;
            highp float _2344 = _2325.z;
            highp float _2346 = min(_2340, min(_2342, _2344));
            highp float _2354 = max(_2340, max(_2342, _2344));
            highp vec3 _2806;
            if (_2346 < 0.0)
            {
                highp vec3 _2362 = vec3(_2397);
                _2806 = _2362 + (((_2325 - _2362) * _2397) / vec3(_2397 - _2346));
            }
            else
            {
                _2806 = _2325;
            }
            highp vec3 _2807;
            if (_2354 > 1.0)
            {
                highp vec3 _2380 = vec3(_2397);
                _2807 = _2380 + (((_2806 - _2380) * (1.0 - _2397)) / vec3(_2354 - _2397));
            }
            else
            {
                _2807 = _2806;
            }
            _2960 = vec4(_2807.x, _2807.y, _2807.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 15:
        {
            highp vec3 _2422 = _2800.xyz + vec3(dot(_2801.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_2800.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
            highp float _2494 = dot(_2422, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
            highp float _2437 = _2422.x;
            highp float _2439 = _2422.y;
            highp float _2441 = _2422.z;
            highp float _2443 = min(_2437, min(_2439, _2441));
            highp float _2451 = max(_2437, max(_2439, _2441));
            highp vec3 _2802;
            if (_2443 < 0.0)
            {
                highp vec3 _2459 = vec3(_2494);
                _2802 = _2459 + (((_2422 - _2459) * _2494) / vec3(_2494 - _2443));
            }
            else
            {
                _2802 = _2422;
            }
            highp vec3 _2803;
            if (_2451 > 1.0)
            {
                highp vec3 _2477 = vec3(_2494);
                _2803 = _2477 + (((_2802 - _2477) * (1.0 - _2494)) / vec3(_2451 - _2494));
            }
            else
            {
                _2803 = _2802;
            }
            _2960 = vec4(_2803.x, _2803.y, _2803.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        default:
        {
            _2960 = vec4(1.0, 1.0, 0.0, 1.0);
            break;
        }
    }
    highp vec3 _1187 = (_2801.xyz * (1.0 - _2800.w)) + (_2960.xyz * _2800.w);
    highp vec4 _2796 = vec4(_1187.x, _1187.y, _1187.z, _2960.w);
    _2796.w = _2801.w;
    highp vec3 _1197 = _2796.xyz * _2801.w;
    oFragColor = vec4(_1197.x, _1197.y, _1197.z, _2796.w);
}

