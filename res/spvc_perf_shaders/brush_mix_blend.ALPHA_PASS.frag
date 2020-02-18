#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
in highp vec4 varying_vec4_1;
in highp vec4 varying_vec4_0;
flat in mediump ivec4 flat_varying_ivec4_0;
flat in highp vec4 vTransformBounds;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in int flat_varying_highp_int_address_0;

vec4 _3045;

void main()
{
    highp vec4 _1060 = textureLod(sPrevPassColor, vec3(varying_vec4_1.xy, varying_vec4_1.w), 0.0);
    highp vec4 _1069 = textureLod(sPrevPassColor, vec3(varying_vec4_0.xy, varying_vec4_0.w), 0.0);
    highp float _1071 = _1060.w;
    highp vec4 _2843;
    if (_1071 != 0.0)
    {
        highp vec3 _1080 = _1060.xyz / vec3(_1071);
        _2843 = vec4(_1080.x, _1080.y, _1080.z, _1060.w);
    }
    else
    {
        _2843 = _1060;
    }
    highp float _1084 = _1069.w;
    highp vec4 _2844;
    if (_1084 != 0.0)
    {
        highp vec3 _1093 = _1069.xyz / vec3(_1084);
        _2844 = vec4(_1093.x, _1093.y, _1093.z, _1069.w);
    }
    else
    {
        _2844 = _1069;
    }
    highp vec4 _3039;
    switch (flat_varying_ivec4_0.x)
    {
        case 1:
        {
            highp vec3 _1282 = _2843.xyz * _2844.xyz;
            _3039 = vec4(_1282.x, _1282.y, _1282.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 2:
        {
            highp vec3 _1290 = (_2843.xyz + _2844.xyz) - (_2843.xyz * _2844.xyz);
            _3039 = vec4(_1290.x, _1290.y, _1290.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 3:
        {
            highp vec3 _1300 = _2843.xyz * 2.0;
            highp vec3 _1306 = _1300 - vec3(1.0);
            highp vec3 _1314 = mix(_2844.xyz * _1300, (_2844.xyz + _1306) - (_2844.xyz * _1306), step(vec3(0.5), _2843.xyz));
            _3039 = vec4(_1314.x, _1314.y, _1314.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 4:
        {
            highp vec3 _1140 = min(_2844.xyz, _2843.xyz);
            _3039 = vec4(_1140.x, _1140.y, _1140.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 5:
        {
            highp vec3 _1147 = max(_2844.xyz, _2843.xyz);
            _3039 = vec4(_1147.x, _1147.y, _1147.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 6:
        {
            highp float _2959;
            switch (0u)
            {
                default:
                {
                    if (_2843.x == 0.0)
                    {
                        _2959 = 0.0;
                        break;
                    }
                    else
                    {
                        if (_2844.x == 1.0)
                        {
                            _2959 = 1.0;
                            break;
                        }
                        else
                        {
                            _2959 = min(1.0, _2843.x / (1.0 - _2844.x));
                            break;
                        }
                    }
                }
            }
            highp vec4 _2638 = _3045;
            _2638.x = _2959;
            highp float _2963;
            switch (0u)
            {
                default:
                {
                    if (_2843.y == 0.0)
                    {
                        _2963 = 0.0;
                        break;
                    }
                    else
                    {
                        if (_2844.y == 1.0)
                        {
                            _2963 = 1.0;
                            break;
                        }
                        else
                        {
                            _2963 = min(1.0, _2843.y / (1.0 - _2844.y));
                            break;
                        }
                    }
                }
            }
            highp vec4 _2642 = _2638;
            _2642.y = _2963;
            highp float _2967;
            switch (0u)
            {
                default:
                {
                    if (_2843.z == 0.0)
                    {
                        _2967 = 0.0;
                        break;
                    }
                    else
                    {
                        if (_2844.z == 1.0)
                        {
                            _2967 = 1.0;
                            break;
                        }
                        else
                        {
                            _2967 = min(1.0, _2843.z / (1.0 - _2844.z));
                            break;
                        }
                    }
                }
            }
            highp vec4 _2646 = _2642;
            _2646.z = _2967;
            _3039 = _2646;
            break;
        }
        case 7:
        {
            highp float _2949;
            switch (0u)
            {
                default:
                {
                    if (_2843.x == 1.0)
                    {
                        _2949 = 1.0;
                        break;
                    }
                    else
                    {
                        if (_2844.x == 0.0)
                        {
                            _2949 = 0.0;
                            break;
                        }
                        else
                        {
                            _2949 = 1.0 - min(1.0, (1.0 - _2843.x) / _2844.x);
                            break;
                        }
                    }
                }
            }
            highp vec4 _2650 = _3045;
            _2650.x = _2949;
            highp float _2953;
            switch (0u)
            {
                default:
                {
                    if (_2843.y == 1.0)
                    {
                        _2953 = 1.0;
                        break;
                    }
                    else
                    {
                        if (_2844.y == 0.0)
                        {
                            _2953 = 0.0;
                            break;
                        }
                        else
                        {
                            _2953 = 1.0 - min(1.0, (1.0 - _2843.y) / _2844.y);
                            break;
                        }
                    }
                }
            }
            highp vec4 _2654 = _2650;
            _2654.y = _2953;
            highp float _2957;
            switch (0u)
            {
                default:
                {
                    if (_2843.z == 1.0)
                    {
                        _2957 = 1.0;
                        break;
                    }
                    else
                    {
                        if (_2844.z == 0.0)
                        {
                            _2957 = 0.0;
                            break;
                        }
                        else
                        {
                            _2957 = 1.0 - min(1.0, (1.0 - _2843.z) / _2844.z);
                            break;
                        }
                    }
                }
            }
            highp vec4 _2658 = _2654;
            _2658.z = _2957;
            _3039 = _2658;
            break;
        }
        case 8:
        {
            highp vec3 _1465 = _2844.xyz * 2.0;
            highp vec3 _1471 = _1465 - vec3(1.0);
            highp vec3 _1479 = mix(_2843.xyz * _1465, (_2843.xyz + _1471) - (_2843.xyz * _1471), step(vec3(0.5), _2844.xyz));
            _3039 = vec4(_1479.x, _1479.y, _1479.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 9:
        {
            highp float _2930;
            switch (0u)
            {
                default:
                {
                    if (_2844.x <= 0.5)
                    {
                        _2930 = _2843.x - (((1.0 - (2.0 * _2844.x)) * _2843.x) * (1.0 - _2843.x));
                        break;
                    }
                    else
                    {
                        highp float _2929;
                        if (_2843.x <= 0.25)
                        {
                            _2929 = ((((16.0 * _2843.x) - 12.0) * _2843.x) + 4.0) * _2843.x;
                        }
                        else
                        {
                            _2929 = sqrt(_2843.x);
                        }
                        _2930 = _2843.x + (((2.0 * _2844.x) - 1.0) * (_2929 - _2843.x));
                        break;
                    }
                }
            }
            highp vec4 _2662 = _3045;
            _2662.x = _2930;
            highp float _2938;
            switch (0u)
            {
                default:
                {
                    if (_2844.y <= 0.5)
                    {
                        _2938 = _2843.y - (((1.0 - (2.0 * _2844.y)) * _2843.y) * (1.0 - _2843.y));
                        break;
                    }
                    else
                    {
                        highp float _2937;
                        if (_2843.y <= 0.25)
                        {
                            _2937 = ((((16.0 * _2843.y) - 12.0) * _2843.y) + 4.0) * _2843.y;
                        }
                        else
                        {
                            _2937 = sqrt(_2843.y);
                        }
                        _2938 = _2843.y + (((2.0 * _2844.y) - 1.0) * (_2937 - _2843.y));
                        break;
                    }
                }
            }
            highp vec4 _2666 = _2662;
            _2666.y = _2938;
            highp float _2946;
            switch (0u)
            {
                default:
                {
                    if (_2844.z <= 0.5)
                    {
                        _2946 = _2843.z - (((1.0 - (2.0 * _2844.z)) * _2843.z) * (1.0 - _2843.z));
                        break;
                    }
                    else
                    {
                        highp float _2945;
                        if (_2843.z <= 0.25)
                        {
                            _2945 = ((((16.0 * _2843.z) - 12.0) * _2843.z) + 4.0) * _2843.z;
                        }
                        else
                        {
                            _2945 = sqrt(_2843.z);
                        }
                        _2946 = _2843.z + (((2.0 * _2844.z) - 1.0) * (_2945 - _2843.z));
                        break;
                    }
                }
            }
            highp vec4 _2670 = _2666;
            _2670.z = _2946;
            _3039 = _2670;
            break;
        }
        case 10:
        {
            highp vec3 _1634 = abs(_2843.xyz - _2844.xyz);
            _3039 = vec4(_1634.x, _1634.y, _1634.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 11:
        {
            highp vec3 _1643 = (_2843.xyz + _2844.xyz) - ((_2843.xyz * 2.0) * _2844.xyz);
            _3039 = vec4(_1643.x, _1643.y, _1643.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 12:
        {
            highp float _1675 = max(_2843.x, max(_2843.y, _2843.z)) - min(_2843.x, min(_2843.y, _2843.z));
            highp vec3 _2909;
            if (_2844.x <= _2844.y)
            {
                highp vec3 _2910;
                if (_2844.y <= _2844.z)
                {
                    bool _1828 = _2844.z > _2844.x;
                    highp float _2907;
                    if (_1828)
                    {
                        _2907 = ((_2844.y - _2844.x) * _1675) / (_2844.z - _2844.x);
                    }
                    else
                    {
                        _2907 = 0.0;
                    }
                    highp vec3 _2685 = _2844.xyz;
                    _2685.x = 0.0;
                    highp vec3 _2687 = _2685;
                    _2687.y = _2907;
                    highp vec3 _2689 = _2687;
                    _2689.z = _1828 ? _1675 : 0.0;
                    _2910 = _2689;
                }
                else
                {
                    highp vec3 _2911;
                    if (_2844.x <= _2844.z)
                    {
                        bool _1844 = _2844.y > _2844.x;
                        highp float _2904;
                        if (_1844)
                        {
                            _2904 = ((_2844.z - _2844.x) * _1675) / (_2844.y - _2844.x);
                        }
                        else
                        {
                            _2904 = 0.0;
                        }
                        highp vec3 _2696 = _2844.xyz;
                        _2696.x = 0.0;
                        highp vec3 _2698 = _2696;
                        _2698.z = _2904;
                        highp vec3 _2700 = _2698;
                        _2700.y = _1844 ? _1675 : 0.0;
                        _2911 = _2700;
                    }
                    else
                    {
                        bool _1860 = _2844.y > _2844.z;
                        highp float _2901;
                        if (_1860)
                        {
                            _2901 = ((_2844.x - _2844.z) * _1675) / (_2844.y - _2844.z);
                        }
                        else
                        {
                            _2901 = 0.0;
                        }
                        highp vec3 _2705 = _2844.xyz;
                        _2705.z = 0.0;
                        highp vec3 _2707 = _2705;
                        _2707.x = _2901;
                        highp vec3 _2709 = _2707;
                        _2709.y = _1860 ? _1675 : 0.0;
                        _2911 = _2709;
                    }
                    _2910 = _2911;
                }
                _2909 = _2910;
            }
            else
            {
                highp vec3 _2912;
                if (_2844.x <= _2844.z)
                {
                    bool _1876 = _2844.z > _2844.y;
                    highp float _2898;
                    if (_1876)
                    {
                        _2898 = ((_2844.x - _2844.y) * _1675) / (_2844.z - _2844.y);
                    }
                    else
                    {
                        _2898 = 0.0;
                    }
                    highp vec3 _2716 = _2844.xyz;
                    _2716.y = 0.0;
                    highp vec3 _2718 = _2716;
                    _2718.x = _2898;
                    highp vec3 _2720 = _2718;
                    _2720.z = _1876 ? _1675 : 0.0;
                    _2912 = _2720;
                }
                else
                {
                    highp vec3 _2913;
                    if (_2844.y <= _2844.z)
                    {
                        bool _1892 = _2844.x > _2844.y;
                        highp float _2895;
                        if (_1892)
                        {
                            _2895 = ((_2844.z - _2844.y) * _1675) / (_2844.x - _2844.y);
                        }
                        else
                        {
                            _2895 = 0.0;
                        }
                        highp vec3 _2727 = _2844.xyz;
                        _2727.y = 0.0;
                        highp vec3 _2729 = _2727;
                        _2729.z = _2895;
                        highp vec3 _2731 = _2729;
                        _2731.x = _1892 ? _1675 : 0.0;
                        _2913 = _2731;
                    }
                    else
                    {
                        bool _1908 = _2844.x > _2844.z;
                        highp float _2892;
                        if (_1908)
                        {
                            _2892 = ((_2844.y - _2844.z) * _1675) / (_2844.x - _2844.z);
                        }
                        else
                        {
                            _2892 = 0.0;
                        }
                        highp vec3 _2736 = _2844.xyz;
                        _2736.z = 0.0;
                        highp vec3 _2738 = _2736;
                        _2738.y = _2892;
                        highp vec3 _2740 = _2738;
                        _2740.x = _1908 ? _1675 : 0.0;
                        _2913 = _2740;
                    }
                    _2912 = _2913;
                }
                _2909 = _2912;
            }
            highp vec3 _1938 = _2909 + vec3(dot(_2843.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_2909, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
            highp float _2010 = dot(_1938, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
            highp float _1953 = _1938.x;
            highp float _1955 = _1938.y;
            highp float _1957 = _1938.z;
            highp float _1959 = min(_1953, min(_1955, _1957));
            highp float _1967 = max(_1953, max(_1955, _1957));
            highp vec3 _2914;
            if (_1959 < 0.0)
            {
                highp vec3 _1975 = vec3(_2010);
                _2914 = _1975 + (((_1938 - _1975) * _2010) / vec3(_2010 - _1959));
            }
            else
            {
                _2914 = _1938;
            }
            highp vec3 _2915;
            if (_1967 > 1.0)
            {
                highp vec3 _1993 = vec3(_2010);
                _2915 = _1993 + (((_2914 - _1993) * (1.0 - _2010)) / vec3(_1967 - _2010));
            }
            else
            {
                _2915 = _2914;
            }
            _3039 = vec4(_2915.x, _2915.y, _2915.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 13:
        {
            highp float _2042 = max(_2844.x, max(_2844.y, _2844.z)) - min(_2844.x, min(_2844.y, _2844.z));
            highp vec3 _2871;
            if (_2843.x <= _2843.y)
            {
                highp vec3 _2872;
                if (_2843.y <= _2843.z)
                {
                    bool _2195 = _2843.z > _2843.x;
                    highp float _2869;
                    if (_2195)
                    {
                        _2869 = ((_2843.y - _2843.x) * _2042) / (_2843.z - _2843.x);
                    }
                    else
                    {
                        _2869 = 0.0;
                    }
                    highp vec3 _2761 = _2843.xyz;
                    _2761.x = 0.0;
                    highp vec3 _2763 = _2761;
                    _2763.y = _2869;
                    highp vec3 _2765 = _2763;
                    _2765.z = _2195 ? _2042 : 0.0;
                    _2872 = _2765;
                }
                else
                {
                    highp vec3 _2873;
                    if (_2843.x <= _2843.z)
                    {
                        bool _2211 = _2843.y > _2843.x;
                        highp float _2866;
                        if (_2211)
                        {
                            _2866 = ((_2843.z - _2843.x) * _2042) / (_2843.y - _2843.x);
                        }
                        else
                        {
                            _2866 = 0.0;
                        }
                        highp vec3 _2772 = _2843.xyz;
                        _2772.x = 0.0;
                        highp vec3 _2774 = _2772;
                        _2774.z = _2866;
                        highp vec3 _2776 = _2774;
                        _2776.y = _2211 ? _2042 : 0.0;
                        _2873 = _2776;
                    }
                    else
                    {
                        bool _2227 = _2843.y > _2843.z;
                        highp float _2863;
                        if (_2227)
                        {
                            _2863 = ((_2843.x - _2843.z) * _2042) / (_2843.y - _2843.z);
                        }
                        else
                        {
                            _2863 = 0.0;
                        }
                        highp vec3 _2781 = _2843.xyz;
                        _2781.z = 0.0;
                        highp vec3 _2783 = _2781;
                        _2783.x = _2863;
                        highp vec3 _2785 = _2783;
                        _2785.y = _2227 ? _2042 : 0.0;
                        _2873 = _2785;
                    }
                    _2872 = _2873;
                }
                _2871 = _2872;
            }
            else
            {
                highp vec3 _2874;
                if (_2843.x <= _2843.z)
                {
                    bool _2243 = _2843.z > _2843.y;
                    highp float _2860;
                    if (_2243)
                    {
                        _2860 = ((_2843.x - _2843.y) * _2042) / (_2843.z - _2843.y);
                    }
                    else
                    {
                        _2860 = 0.0;
                    }
                    highp vec3 _2792 = _2843.xyz;
                    _2792.y = 0.0;
                    highp vec3 _2794 = _2792;
                    _2794.x = _2860;
                    highp vec3 _2796 = _2794;
                    _2796.z = _2243 ? _2042 : 0.0;
                    _2874 = _2796;
                }
                else
                {
                    highp vec3 _2875;
                    if (_2843.y <= _2843.z)
                    {
                        bool _2259 = _2843.x > _2843.y;
                        highp float _2857;
                        if (_2259)
                        {
                            _2857 = ((_2843.z - _2843.y) * _2042) / (_2843.x - _2843.y);
                        }
                        else
                        {
                            _2857 = 0.0;
                        }
                        highp vec3 _2803 = _2843.xyz;
                        _2803.y = 0.0;
                        highp vec3 _2805 = _2803;
                        _2805.z = _2857;
                        highp vec3 _2807 = _2805;
                        _2807.x = _2259 ? _2042 : 0.0;
                        _2875 = _2807;
                    }
                    else
                    {
                        bool _2275 = _2843.x > _2843.z;
                        highp float _2854;
                        if (_2275)
                        {
                            _2854 = ((_2843.y - _2843.z) * _2042) / (_2843.x - _2843.z);
                        }
                        else
                        {
                            _2854 = 0.0;
                        }
                        highp vec3 _2812 = _2843.xyz;
                        _2812.z = 0.0;
                        highp vec3 _2814 = _2812;
                        _2814.y = _2854;
                        highp vec3 _2816 = _2814;
                        _2816.x = _2275 ? _2042 : 0.0;
                        _2875 = _2816;
                    }
                    _2874 = _2875;
                }
                _2871 = _2874;
            }
            highp vec3 _2305 = _2871 + vec3(dot(_2843.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_2871, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
            highp float _2377 = dot(_2305, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
            highp float _2320 = _2305.x;
            highp float _2322 = _2305.y;
            highp float _2324 = _2305.z;
            highp float _2326 = min(_2320, min(_2322, _2324));
            highp float _2334 = max(_2320, max(_2322, _2324));
            highp vec3 _2876;
            if (_2326 < 0.0)
            {
                highp vec3 _2342 = vec3(_2377);
                _2876 = _2342 + (((_2305 - _2342) * _2377) / vec3(_2377 - _2326));
            }
            else
            {
                _2876 = _2305;
            }
            highp vec3 _2877;
            if (_2334 > 1.0)
            {
                highp vec3 _2360 = vec3(_2377);
                _2877 = _2360 + (((_2876 - _2360) * (1.0 - _2377)) / vec3(_2334 - _2377));
            }
            else
            {
                _2877 = _2876;
            }
            _3039 = vec4(_2877.x, _2877.y, _2877.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 14:
        {
            highp vec3 _2402 = _2844.xyz + vec3(dot(_2843.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_2844.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
            highp float _2474 = dot(_2402, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
            highp float _2417 = _2402.x;
            highp float _2419 = _2402.y;
            highp float _2421 = _2402.z;
            highp float _2423 = min(_2417, min(_2419, _2421));
            highp float _2431 = max(_2417, max(_2419, _2421));
            highp vec3 _2849;
            if (_2423 < 0.0)
            {
                highp vec3 _2439 = vec3(_2474);
                _2849 = _2439 + (((_2402 - _2439) * _2474) / vec3(_2474 - _2423));
            }
            else
            {
                _2849 = _2402;
            }
            highp vec3 _2850;
            if (_2431 > 1.0)
            {
                highp vec3 _2457 = vec3(_2474);
                _2850 = _2457 + (((_2849 - _2457) * (1.0 - _2474)) / vec3(_2431 - _2474));
            }
            else
            {
                _2850 = _2849;
            }
            _3039 = vec4(_2850.x, _2850.y, _2850.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 15:
        {
            highp vec3 _2499 = _2843.xyz + vec3(dot(_2844.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_2843.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
            highp float _2571 = dot(_2499, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
            highp float _2514 = _2499.x;
            highp float _2516 = _2499.y;
            highp float _2518 = _2499.z;
            highp float _2520 = min(_2514, min(_2516, _2518));
            highp float _2528 = max(_2514, max(_2516, _2518));
            highp vec3 _2845;
            if (_2520 < 0.0)
            {
                highp vec3 _2536 = vec3(_2571);
                _2845 = _2536 + (((_2499 - _2536) * _2571) / vec3(_2571 - _2520));
            }
            else
            {
                _2845 = _2499;
            }
            highp vec3 _2846;
            if (_2528 > 1.0)
            {
                highp vec3 _2554 = vec3(_2571);
                _2846 = _2554 + (((_2845 - _2554) * (1.0 - _2571)) / vec3(_2528 - _2571));
            }
            else
            {
                _2846 = _2845;
            }
            _3039 = vec4(_2846.x, _2846.y, _2846.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        default:
        {
            _3039 = vec4(1.0, 1.0, 0.0, 1.0);
            break;
        }
    }
    highp vec3 _1264 = (_2844.xyz * (1.0 - _2843.w)) + (_3039.xyz * _2843.w);
    highp vec4 _2839 = vec4(_1264.x, _1264.y, _1264.z, _3039.w);
    _2839.w = _2844.w;
    highp vec3 _1274 = _2839.xyz * _2844.w;
    highp float _3040;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _3040 = 1.0;
                break;
            }
            highp vec2 _2593 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _2593), greaterThan(vClipMaskUvBounds.zw, _2593))))
            {
                _3040 = 0.0;
                break;
            }
            _3040 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_2593), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = vec4(_1274.x, _1274.y, _1274.z, _2839.w) * _3040;
}

