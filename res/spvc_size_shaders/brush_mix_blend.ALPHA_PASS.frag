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

void main()
{
    highp vec4 _1060 = textureLod(sPrevPassColor, vec3(varying_vec4_1.xy, varying_vec4_1.w), 0.0);
    highp vec4 _1069 = textureLod(sPrevPassColor, vec3(varying_vec4_0.xy, varying_vec4_0.w), 0.0);
    highp float _1071 = _1060.w;
    highp vec4 _2935;
    if (_1071 != 0.0)
    {
        highp vec3 _1080 = _1060.xyz / vec3(_1071);
        _2935 = vec4(_1080.x, _1080.y, _1080.z, _1060.w);
    }
    else
    {
        _2935 = _1060;
    }
    highp float _1084 = _1069.w;
    highp vec4 _2936;
    if (_1084 != 0.0)
    {
        highp vec3 _1093 = _1069.xyz / vec3(_1084);
        _2936 = vec4(_1093.x, _1093.y, _1093.z, _1069.w);
    }
    else
    {
        _2936 = _1069;
    }
    highp vec4 _3095;
    switch (flat_varying_ivec4_0.x)
    {
        case 1:
        {
            highp vec3 _1282 = _2935.xyz * _2936.xyz;
            _3095 = vec4(_1282.x, _1282.y, _1282.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 2:
        {
            highp vec3 _1290 = (_2935.xyz + _2936.xyz) - (_2935.xyz * _2936.xyz);
            _3095 = vec4(_1290.x, _1290.y, _1290.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 3:
        {
            highp vec3 _1300 = _2935.xyz * 2.0;
            highp vec3 _1306 = _1300 - vec3(1.0);
            highp vec3 _1314 = mix(_2936.xyz * _1300, (_2936.xyz + _1306) - (_2936.xyz * _1306), step(vec3(0.5), _2935.xyz));
            _3095 = vec4(_1314.x, _1314.y, _1314.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 4:
        {
            highp vec3 _1140 = min(_2936.xyz, _2935.xyz);
            _3095 = vec4(_1140.x, _1140.y, _1140.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 5:
        {
            highp vec3 _1147 = max(_2936.xyz, _2935.xyz);
            _3095 = vec4(_1147.x, _1147.y, _1147.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 6:
        {
            highp float _2704;
            switch (0u)
            {
                default:
                {
                    if (_2935.x == 0.0)
                    {
                        _2704 = 0.0;
                        break;
                    }
                    else
                    {
                        if (_2936.x == 1.0)
                        {
                            _2704 = 1.0;
                            break;
                        }
                        else
                        {
                            _2704 = min(1.0, _2935.x / (1.0 - _2936.x));
                            break;
                        }
                    }
                }
            }
            highp vec4 _2918 = vec4(1.0, 1.0, 0.0, 1.0);
            _2918.x = _2704;
            highp float _2705;
            switch (0u)
            {
                default:
                {
                    if (_2935.y == 0.0)
                    {
                        _2705 = 0.0;
                        break;
                    }
                    else
                    {
                        if (_2936.y == 1.0)
                        {
                            _2705 = 1.0;
                            break;
                        }
                        else
                        {
                            _2705 = min(1.0, _2935.y / (1.0 - _2936.y));
                            break;
                        }
                    }
                }
            }
            highp vec4 _2922 = _2918;
            _2922.y = _2705;
            highp float _2706;
            switch (0u)
            {
                default:
                {
                    if (_2935.z == 0.0)
                    {
                        _2706 = 0.0;
                        break;
                    }
                    else
                    {
                        if (_2936.z == 1.0)
                        {
                            _2706 = 1.0;
                            break;
                        }
                        else
                        {
                            _2706 = min(1.0, _2935.z / (1.0 - _2936.z));
                            break;
                        }
                    }
                }
            }
            highp vec4 _2926 = _2922;
            _2926.z = _2706;
            _3095 = _2926;
            break;
        }
        case 7:
        {
            highp float _2701;
            switch (0u)
            {
                default:
                {
                    if (_2935.x == 1.0)
                    {
                        _2701 = 1.0;
                        break;
                    }
                    else
                    {
                        if (_2936.x == 0.0)
                        {
                            _2701 = 0.0;
                            break;
                        }
                        else
                        {
                            _2701 = 1.0 - min(1.0, (1.0 - _2935.x) / _2936.x);
                            break;
                        }
                    }
                }
            }
            highp vec4 _2906 = vec4(1.0, 1.0, 0.0, 1.0);
            _2906.x = _2701;
            highp float _2702;
            switch (0u)
            {
                default:
                {
                    if (_2935.y == 1.0)
                    {
                        _2702 = 1.0;
                        break;
                    }
                    else
                    {
                        if (_2936.y == 0.0)
                        {
                            _2702 = 0.0;
                            break;
                        }
                        else
                        {
                            _2702 = 1.0 - min(1.0, (1.0 - _2935.y) / _2936.y);
                            break;
                        }
                    }
                }
            }
            highp vec4 _2910 = _2906;
            _2910.y = _2702;
            highp float _2703;
            switch (0u)
            {
                default:
                {
                    if (_2935.z == 1.0)
                    {
                        _2703 = 1.0;
                        break;
                    }
                    else
                    {
                        if (_2936.z == 0.0)
                        {
                            _2703 = 0.0;
                            break;
                        }
                        else
                        {
                            _2703 = 1.0 - min(1.0, (1.0 - _2935.z) / _2936.z);
                            break;
                        }
                    }
                }
            }
            highp vec4 _2914 = _2910;
            _2914.z = _2703;
            _3095 = _2914;
            break;
        }
        case 8:
        {
            highp vec3 _1465 = _2936.xyz * 2.0;
            highp vec3 _1471 = _1465 - vec3(1.0);
            highp vec3 _1479 = mix(_2935.xyz * _1465, (_2935.xyz + _1471) - (_2935.xyz * _1471), step(vec3(0.5), _2936.xyz));
            _3095 = vec4(_1479.x, _1479.y, _1479.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 9:
        {
            highp float _2692;
            switch (0u)
            {
                default:
                {
                    if (_2936.x <= 0.5)
                    {
                        _2692 = _2935.x - (((1.0 - (2.0 * _2936.x)) * _2935.x) * (1.0 - _2935.x));
                        break;
                    }
                    else
                    {
                        highp float _2691;
                        if (_2935.x <= 0.25)
                        {
                            _2691 = ((((16.0 * _2935.x) - 12.0) * _2935.x) + 4.0) * _2935.x;
                        }
                        else
                        {
                            _2691 = sqrt(_2935.x);
                        }
                        _2692 = _2935.x + (((2.0 * _2936.x) - 1.0) * (_2691 - _2935.x));
                        break;
                    }
                }
            }
            highp vec4 _2894 = vec4(1.0, 1.0, 0.0, 1.0);
            _2894.x = _2692;
            highp float _2696;
            switch (0u)
            {
                default:
                {
                    if (_2936.y <= 0.5)
                    {
                        _2696 = _2935.y - (((1.0 - (2.0 * _2936.y)) * _2935.y) * (1.0 - _2935.y));
                        break;
                    }
                    else
                    {
                        highp float _2695;
                        if (_2935.y <= 0.25)
                        {
                            _2695 = ((((16.0 * _2935.y) - 12.0) * _2935.y) + 4.0) * _2935.y;
                        }
                        else
                        {
                            _2695 = sqrt(_2935.y);
                        }
                        _2696 = _2935.y + (((2.0 * _2936.y) - 1.0) * (_2695 - _2935.y));
                        break;
                    }
                }
            }
            highp vec4 _2898 = _2894;
            _2898.y = _2696;
            highp float _2700;
            switch (0u)
            {
                default:
                {
                    if (_2936.z <= 0.5)
                    {
                        _2700 = _2935.z - (((1.0 - (2.0 * _2936.z)) * _2935.z) * (1.0 - _2935.z));
                        break;
                    }
                    else
                    {
                        highp float _2699;
                        if (_2935.z <= 0.25)
                        {
                            _2699 = ((((16.0 * _2935.z) - 12.0) * _2935.z) + 4.0) * _2935.z;
                        }
                        else
                        {
                            _2699 = sqrt(_2935.z);
                        }
                        _2700 = _2935.z + (((2.0 * _2936.z) - 1.0) * (_2699 - _2935.z));
                        break;
                    }
                }
            }
            highp vec4 _2902 = _2898;
            _2902.z = _2700;
            _3095 = _2902;
            break;
        }
        case 10:
        {
            highp vec3 _1634 = abs(_2935.xyz - _2936.xyz);
            _3095 = vec4(_1634.x, _1634.y, _1634.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 11:
        {
            highp vec3 _1643 = (_2935.xyz + _2936.xyz) - ((_2935.xyz * 2.0) * _2936.xyz);
            _3095 = vec4(_1643.x, _1643.y, _1643.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 12:
        {
            highp float _1675 = max(_2935.x, max(_2935.y, _2935.z)) - min(_2935.x, min(_2935.y, _2935.z));
            highp vec3 _2977;
            if (_2936.x <= _2936.y)
            {
                highp vec3 _2980;
                if (_2936.y <= _2936.z)
                {
                    bool _1828 = _2936.z > _2936.x;
                    highp float _2674;
                    if (_1828)
                    {
                        _2674 = ((_2936.y - _2936.x) * _1675) / (_2936.z - _2936.x);
                    }
                    else
                    {
                        _2674 = 0.0;
                    }
                    highp vec3 _2880 = _2936.xyz;
                    _2880.x = 0.0;
                    highp vec3 _2882 = _2880;
                    _2882.y = _2674;
                    highp vec3 _2884 = _2882;
                    _2884.z = _1828 ? _1675 : 0.0;
                    _2980 = _2884;
                }
                else
                {
                    highp vec3 _2981;
                    if (_2936.x <= _2936.z)
                    {
                        bool _1844 = _2936.y > _2936.x;
                        highp float _2672;
                        if (_1844)
                        {
                            _2672 = ((_2936.z - _2936.x) * _1675) / (_2936.y - _2936.x);
                        }
                        else
                        {
                            _2672 = 0.0;
                        }
                        highp vec3 _2871 = _2936.xyz;
                        _2871.x = 0.0;
                        highp vec3 _2873 = _2871;
                        _2873.z = _2672;
                        highp vec3 _2875 = _2873;
                        _2875.y = _1844 ? _1675 : 0.0;
                        _2981 = _2875;
                    }
                    else
                    {
                        bool _1860 = _2936.y > _2936.z;
                        highp float _2670;
                        if (_1860)
                        {
                            _2670 = ((_2936.x - _2936.z) * _1675) / (_2936.y - _2936.z);
                        }
                        else
                        {
                            _2670 = 0.0;
                        }
                        highp vec3 _2862 = _2936.xyz;
                        _2862.z = 0.0;
                        highp vec3 _2864 = _2862;
                        _2864.x = _2670;
                        highp vec3 _2866 = _2864;
                        _2866.y = _1860 ? _1675 : 0.0;
                        _2981 = _2866;
                    }
                    _2980 = _2981;
                }
                _2977 = _2980;
            }
            else
            {
                highp vec3 _2978;
                if (_2936.x <= _2936.z)
                {
                    bool _1876 = _2936.z > _2936.y;
                    highp float _2668;
                    if (_1876)
                    {
                        _2668 = ((_2936.x - _2936.y) * _1675) / (_2936.z - _2936.y);
                    }
                    else
                    {
                        _2668 = 0.0;
                    }
                    highp vec3 _2849 = _2936.xyz;
                    _2849.y = 0.0;
                    highp vec3 _2851 = _2849;
                    _2851.x = _2668;
                    highp vec3 _2853 = _2851;
                    _2853.z = _1876 ? _1675 : 0.0;
                    _2978 = _2853;
                }
                else
                {
                    highp vec3 _2979;
                    if (_2936.y <= _2936.z)
                    {
                        bool _1892 = _2936.x > _2936.y;
                        highp float _2666;
                        if (_1892)
                        {
                            _2666 = ((_2936.z - _2936.y) * _1675) / (_2936.x - _2936.y);
                        }
                        else
                        {
                            _2666 = 0.0;
                        }
                        highp vec3 _2840 = _2936.xyz;
                        _2840.y = 0.0;
                        highp vec3 _2842 = _2840;
                        _2842.z = _2666;
                        highp vec3 _2844 = _2842;
                        _2844.x = _1892 ? _1675 : 0.0;
                        _2979 = _2844;
                    }
                    else
                    {
                        bool _1908 = _2936.x > _2936.z;
                        highp float _2664;
                        if (_1908)
                        {
                            _2664 = ((_2936.y - _2936.z) * _1675) / (_2936.x - _2936.z);
                        }
                        else
                        {
                            _2664 = 0.0;
                        }
                        highp vec3 _2831 = _2936.xyz;
                        _2831.z = 0.0;
                        highp vec3 _2833 = _2831;
                        _2833.y = _2664;
                        highp vec3 _2835 = _2833;
                        _2835.x = _1908 ? _1675 : 0.0;
                        _2979 = _2835;
                    }
                    _2978 = _2979;
                }
                _2977 = _2978;
            }
            highp vec3 _1938 = _2977 + vec3(dot(_2935.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_2977, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
            highp float _2010 = dot(_1938, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
            highp float _1953 = _1938.x;
            highp float _1955 = _1938.y;
            highp float _1957 = _1938.z;
            highp float _1959 = min(_1953, min(_1955, _1957));
            highp float _1967 = max(_1953, max(_1955, _1957));
            highp vec3 _2982;
            if (_1959 < 0.0)
            {
                highp vec3 _1975 = vec3(_2010);
                _2982 = _1975 + (((_1938 - _1975) * _2010) / vec3(_2010 - _1959));
            }
            else
            {
                _2982 = _1938;
            }
            highp vec3 _2983;
            if (_1967 > 1.0)
            {
                highp vec3 _1993 = vec3(_2010);
                _2983 = _1993 + (((_2982 - _1993) * (1.0 - _2010)) / vec3(_1967 - _2010));
            }
            else
            {
                _2983 = _2982;
            }
            _3095 = vec4(_2983.x, _2983.y, _2983.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 13:
        {
            highp float _2042 = max(_2936.x, max(_2936.y, _2936.z)) - min(_2936.x, min(_2936.y, _2936.z));
            highp vec3 _2951;
            if (_2935.x <= _2935.y)
            {
                highp vec3 _2954;
                if (_2935.y <= _2935.z)
                {
                    bool _2195 = _2935.z > _2935.x;
                    highp float _2649;
                    if (_2195)
                    {
                        _2649 = ((_2935.y - _2935.x) * _2042) / (_2935.z - _2935.x);
                    }
                    else
                    {
                        _2649 = 0.0;
                    }
                    highp vec3 _2804 = _2935.xyz;
                    _2804.x = 0.0;
                    highp vec3 _2806 = _2804;
                    _2806.y = _2649;
                    highp vec3 _2808 = _2806;
                    _2808.z = _2195 ? _2042 : 0.0;
                    _2954 = _2808;
                }
                else
                {
                    highp vec3 _2955;
                    if (_2935.x <= _2935.z)
                    {
                        bool _2211 = _2935.y > _2935.x;
                        highp float _2647;
                        if (_2211)
                        {
                            _2647 = ((_2935.z - _2935.x) * _2042) / (_2935.y - _2935.x);
                        }
                        else
                        {
                            _2647 = 0.0;
                        }
                        highp vec3 _2795 = _2935.xyz;
                        _2795.x = 0.0;
                        highp vec3 _2797 = _2795;
                        _2797.z = _2647;
                        highp vec3 _2799 = _2797;
                        _2799.y = _2211 ? _2042 : 0.0;
                        _2955 = _2799;
                    }
                    else
                    {
                        bool _2227 = _2935.y > _2935.z;
                        highp float _2645;
                        if (_2227)
                        {
                            _2645 = ((_2935.x - _2935.z) * _2042) / (_2935.y - _2935.z);
                        }
                        else
                        {
                            _2645 = 0.0;
                        }
                        highp vec3 _2786 = _2935.xyz;
                        _2786.z = 0.0;
                        highp vec3 _2788 = _2786;
                        _2788.x = _2645;
                        highp vec3 _2790 = _2788;
                        _2790.y = _2227 ? _2042 : 0.0;
                        _2955 = _2790;
                    }
                    _2954 = _2955;
                }
                _2951 = _2954;
            }
            else
            {
                highp vec3 _2952;
                if (_2935.x <= _2935.z)
                {
                    bool _2243 = _2935.z > _2935.y;
                    highp float _2643;
                    if (_2243)
                    {
                        _2643 = ((_2935.x - _2935.y) * _2042) / (_2935.z - _2935.y);
                    }
                    else
                    {
                        _2643 = 0.0;
                    }
                    highp vec3 _2773 = _2935.xyz;
                    _2773.y = 0.0;
                    highp vec3 _2775 = _2773;
                    _2775.x = _2643;
                    highp vec3 _2777 = _2775;
                    _2777.z = _2243 ? _2042 : 0.0;
                    _2952 = _2777;
                }
                else
                {
                    highp vec3 _2953;
                    if (_2935.y <= _2935.z)
                    {
                        bool _2259 = _2935.x > _2935.y;
                        highp float _2641;
                        if (_2259)
                        {
                            _2641 = ((_2935.z - _2935.y) * _2042) / (_2935.x - _2935.y);
                        }
                        else
                        {
                            _2641 = 0.0;
                        }
                        highp vec3 _2764 = _2935.xyz;
                        _2764.y = 0.0;
                        highp vec3 _2766 = _2764;
                        _2766.z = _2641;
                        highp vec3 _2768 = _2766;
                        _2768.x = _2259 ? _2042 : 0.0;
                        _2953 = _2768;
                    }
                    else
                    {
                        bool _2275 = _2935.x > _2935.z;
                        highp float _2639;
                        if (_2275)
                        {
                            _2639 = ((_2935.y - _2935.z) * _2042) / (_2935.x - _2935.z);
                        }
                        else
                        {
                            _2639 = 0.0;
                        }
                        highp vec3 _2755 = _2935.xyz;
                        _2755.z = 0.0;
                        highp vec3 _2757 = _2755;
                        _2757.y = _2639;
                        highp vec3 _2759 = _2757;
                        _2759.x = _2275 ? _2042 : 0.0;
                        _2953 = _2759;
                    }
                    _2952 = _2953;
                }
                _2951 = _2952;
            }
            highp vec3 _2305 = _2951 + vec3(dot(_2935.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_2951, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
            highp float _2377 = dot(_2305, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
            highp float _2320 = _2305.x;
            highp float _2322 = _2305.y;
            highp float _2324 = _2305.z;
            highp float _2326 = min(_2320, min(_2322, _2324));
            highp float _2334 = max(_2320, max(_2322, _2324));
            highp vec3 _2956;
            if (_2326 < 0.0)
            {
                highp vec3 _2342 = vec3(_2377);
                _2956 = _2342 + (((_2305 - _2342) * _2377) / vec3(_2377 - _2326));
            }
            else
            {
                _2956 = _2305;
            }
            highp vec3 _2957;
            if (_2334 > 1.0)
            {
                highp vec3 _2360 = vec3(_2377);
                _2957 = _2360 + (((_2956 - _2360) * (1.0 - _2377)) / vec3(_2334 - _2377));
            }
            else
            {
                _2957 = _2956;
            }
            _3095 = vec4(_2957.x, _2957.y, _2957.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 14:
        {
            highp vec3 _2402 = _2936.xyz + vec3(dot(_2935.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_2936.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
            highp float _2474 = dot(_2402, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
            highp float _2417 = _2402.x;
            highp float _2419 = _2402.y;
            highp float _2421 = _2402.z;
            highp float _2423 = min(_2417, min(_2419, _2421));
            highp float _2431 = max(_2417, max(_2419, _2421));
            highp vec3 _2941;
            if (_2423 < 0.0)
            {
                highp vec3 _2439 = vec3(_2474);
                _2941 = _2439 + (((_2402 - _2439) * _2474) / vec3(_2474 - _2423));
            }
            else
            {
                _2941 = _2402;
            }
            highp vec3 _2942;
            if (_2431 > 1.0)
            {
                highp vec3 _2457 = vec3(_2474);
                _2942 = _2457 + (((_2941 - _2457) * (1.0 - _2474)) / vec3(_2431 - _2474));
            }
            else
            {
                _2942 = _2941;
            }
            _3095 = vec4(_2942.x, _2942.y, _2942.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        case 15:
        {
            highp vec3 _2499 = _2935.xyz + vec3(dot(_2936.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) - dot(_2935.xyz, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
            highp float _2571 = dot(_2499, vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
            highp float _2514 = _2499.x;
            highp float _2516 = _2499.y;
            highp float _2518 = _2499.z;
            highp float _2520 = min(_2514, min(_2516, _2518));
            highp float _2528 = max(_2514, max(_2516, _2518));
            highp vec3 _2937;
            if (_2520 < 0.0)
            {
                highp vec3 _2536 = vec3(_2571);
                _2937 = _2536 + (((_2499 - _2536) * _2571) / vec3(_2571 - _2520));
            }
            else
            {
                _2937 = _2499;
            }
            highp vec3 _2938;
            if (_2528 > 1.0)
            {
                highp vec3 _2554 = vec3(_2571);
                _2938 = _2554 + (((_2937 - _2554) * (1.0 - _2571)) / vec3(_2528 - _2571));
            }
            else
            {
                _2938 = _2937;
            }
            _3095 = vec4(_2938.x, _2938.y, _2938.z, vec4(1.0, 1.0, 0.0, 1.0).w);
            break;
        }
        default:
        {
            _3095 = vec4(1.0, 1.0, 0.0, 1.0);
            break;
        }
    }
    highp vec3 _1264 = (_2936.xyz * (1.0 - _2935.w)) + (_3095.xyz * _2935.w);
    highp vec4 _2931 = vec4(_1264.x, _1264.y, _1264.z, _3095.w);
    _2931.w = _2936.w;
    highp vec3 _1274 = _2931.xyz * _2936.w;
    highp float _2707;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _2707 = 1.0;
                break;
            }
            highp vec2 _2593 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _2593), greaterThan(vClipMaskUvBounds.zw, _2593))))
            {
                _2707 = 0.0;
                break;
            }
            _2707 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_2593), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = vec4(_1274.x, _1274.y, _1274.z, _2931.w) * _2707;
}

