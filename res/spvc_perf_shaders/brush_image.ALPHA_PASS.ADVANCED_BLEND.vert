#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform mat4 uTransform;
uniform highp sampler2DArray sColor0;
uniform int uMode;

flat out vec4 vTransformBounds;
layout(location = 1) in ivec4 aData;
layout(location = 0) in vec3 aPosition;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
flat out vec4 flat_varying_vec4_4;
flat out vec4 flat_varying_vec4_3;
out vec4 varying_vec4_0;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_0;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_1;
flat out int flat_varying_highp_int_address_0;

mat4 _2811;

void main()
{
    int _1369 = aData.y & 65535;
    int _1373 = aData.z & 65535;
    int _1377 = aData.z >> 16;
    int _1381 = aData.w & 16777215;
    int _914 = (_1377 >> 8) & 255;
    uint _1397 = uint(aData.x);
    ivec2 _1405 = ivec2(int(2u * (_1397 % 512u)), int(_1397 / 512u));
    vec4 _1410 = texelFetch(sPrimitiveHeadersF, _1405, 0);
    ivec2 _1413 = _1405 + ivec2(1, 0);
    vec4 _1415 = texelFetch(sPrimitiveHeadersF, _1413, 0);
    vec2 _1417 = _1410.xy;
    vec2 _1419 = _1410.zw;
    vec2 _1423 = _1415.xy;
    vec2 _1425 = _1415.zw;
    ivec4 _1442 = texelFetch(sPrimitiveHeadersI, _1405, 0);
    ivec4 _1447 = texelFetch(sPrimitiveHeadersI, _1413, 0);
    float _1450 = float(_1442.x);
    int _1453 = _1442.y;
    int _1456 = _1442.z;
    vec2 _2815;
    vec2 _2817;
    vec4 _2824;
    if (_1373 == 65535)
    {
        _2824 = vec4(0.0);
        _2817 = _1417;
        _2815 = _1419;
    }
    else
    {
        uint _1479 = uint((_1453 + 3) + (_1373 * 2));
        ivec2 _1486 = ivec2(int(_1479 % 1024u), int(_1479 / 1024u));
        vec4 _1470 = texelFetch(sGpuCache, _1486, 0);
        _2824 = texelFetch(sGpuCache, _1486 + ivec2(1, 0), 0);
        _2817 = _1470.xy + _1417;
        _2815 = _1470.zw;
    }
    uint _1510 = uint(aData.y >> 16);
    ivec2 _1518 = ivec2(int(2u * (_1510 % 512u)), int(_1510 / 512u));
    vec4 _1528 = texelFetch(sRenderTasks, _1518 + ivec2(1, 0), 0);
    vec2 _1530 = texelFetch(sRenderTasks, _1518, 0).xy;
    float _1496 = _1528.y;
    vec2 _1499 = _1528.zw;
    vec2 _2804;
    float _2805;
    float _2806;
    vec2 _2807;
    vec2 _2808;
    if (_1369 >= 32767)
    {
        _2808 = vec2(0.0);
        _2807 = vec2(0.0);
        _2806 = 0.0;
        _2805 = 0.0;
        _2804 = vec2(0.0);
    }
    else
    {
        uint _1579 = uint(_1369);
        ivec2 _1587 = ivec2(int(2u * (_1579 % 512u)), int(_1579 / 512u));
        vec4 _1592 = texelFetch(sRenderTasks, _1587, 0);
        vec4 _1597 = texelFetch(sRenderTasks, _1587 + ivec2(1, 0), 0);
        _2808 = _1592.xy;
        _2807 = _1592.zw;
        _2806 = _1597.x;
        _2805 = _1597.y;
        _2804 = _1597.zw;
    }
    uint _1624 = uint(_1456 & 16777215);
    ivec2 _1638 = ivec2(int(8u * (_1624 % 128u)), int(_1624 / 128u));
    mat4 _2765 = _2811;
    _2765[0] = texelFetch(sTransformPalette, _1638, 0);
    mat4 _2767 = _2765;
    _2767[1] = texelFetch(sTransformPalette, _1638 + ivec2(1, 0), 0);
    mat4 _2769 = _2767;
    _2769[2] = texelFetch(sTransformPalette, _1638 + ivec2(2, 0), 0);
    mat4 _2771 = _2769;
    _2771[3] = texelFetch(sTransformPalette, _1638 + ivec2(3, 0), 0);
    vec4 _2818;
    vec2 _2819;
    if ((_1456 >> 24) == 0)
    {
        vec2 _1757 = clamp(_2817 + (_2815 * aPosition.xy), _1423, _1423 + _1425);
        vec4 _1714 = _2771 * vec4(_1757, 0.0, 1.0);
        float _1730 = _1714.w;
        gl_Position = uTransform * vec4((_1714.xy * _1496) + (((-_1499) + _1530) * _1730), _1450 * _1730, _1730);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _2819 = _1757;
        _2818 = _1714;
    }
    else
    {
        bvec4 _1005 = notEqual((ivec4(_1377 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _1008 = vec4(_1005.x ? vec4(1.0).x : vec4(0.0).x, _1005.y ? vec4(1.0).y : vec4(0.0).y, _1005.z ? vec4(1.0).z : vec4(0.0).z, _1005.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1908 = _1423 + _1425;
        vec4 _1815 = vec4(2.0) * _1008;
        vec2 _1817 = _1815.xy;
        vec2 _1838 = (_2817 - _1817) + ((_2815 + (_1817 + _1815.zw)) * aPosition.xy);
        vec4 _1850 = _2771 * vec4(_1838, 0.0, 1.0);
        float _1858 = _1850.w;
        gl_Position = uTransform * vec4((_1850.xy * _1496) + ((_1530 - _1499) * _1858), _1450 * _1858, _1858);
        vTransformBounds = mix(vec4(clamp(_1417, _1423, _1908), clamp(_1417 + _1419, _1423, _1908)), vec4(clamp(_2817, _1423, _1908), clamp(_2817 + _2815, _1423, _1908)), _1008);
        _2819 = _1838;
        _2818 = _1850;
    }
    vClipMaskUvBounds = vec4(_2808, _2808 + _2807);
    vClipMaskUv = vec4((_2818.xy * _2805) + ((_2808 - _2804) * _2818.w), _2806, _2818.w);
    uint _2246 = uint(_1453);
    ivec2 _2253 = ivec2(int(_2246 % 1024u), int(_2246 / 1024u));
    vec4 _2232 = texelFetch(sGpuCache, _2253, 0);
    vec4 _2242 = texelFetch(sGpuCache, _2253 + ivec2(2, 0), 0);
    vec2 _2220 = _2242.xy;
    vec2 _2001 = vec2(vec3(textureSize(sColor0, 0)).xy);
    uint _2292 = uint(_1381);
    ivec2 _2299 = ivec2(int(_2292 % 1024u), int(_2292 / 1024u));
    vec4 _2283 = texelFetch(sGpuCache, _2299, 0);
    vec2 _2262 = _2283.xy;
    vec2 _2265 = _2283.zw;
    bvec2 _2871 = bvec2(_2242.x < 0.0);
    vec2 _2872 = vec2(_2871.x ? _1419.x : _2220.x, _2871.y ? _1419.y : _2220.y);
    bool _2020 = (_914 & 2) != 0;
    vec2 _2825;
    vec2 _2828;
    if (_2020)
    {
        vec2 _2827;
        vec2 _2830;
        if ((_914 & 128) != 0)
        {
            vec2 _2035 = _2265 - _2262;
            _2830 = _2262 + (_2824.zw * _2035);
            _2827 = _2262 + (_2824.xy * _2035);
        }
        else
        {
            _2830 = _2265;
            _2827 = _2262;
        }
        _2828 = _2830;
        _2825 = _2827;
    }
    else
    {
        _2828 = _2265;
        _2825 = _2262;
    }
    bvec2 _2873 = bvec2(_2020);
    vec2 _2876 = vec2(_2873.x ? _2815.x : _1419.x, _2873.y ? _2815.y : _1419.y);
    float _2056 = float((_914 & 1) != 0);
    flat_varying_vec4_4.x = texelFetch(sGpuCache, _2299 + ivec2(1, 0), 0).x;
    flat_varying_vec4_4.y = _2056;
    vec2 _2064 = min(_2825, _2828);
    vec2 _2067 = max(_2825, _2828);
    vec4 _2078 = _2001.xyxy;
    flat_varying_vec4_3 = vec4(_2064 + vec2(0.5), _2067 - vec2(0.5)) / _2078;
    vec2 _2087 = (_2819 - vec2(_2873.x ? _2817.x : _1417.x, _2873.y ? _2817.y : _1417.y)) / _2876;
    int _2089 = _1447.x;
    int _2090 = _2089 & 65535;
    int _2861;
    if (_2090 == 0)
    {
        _2861 = uMode;
    }
    else
    {
        _2861 = _2090;
    }
    vec2 _2849;
    switch (_1447.y)
    {
        case 1:
        {
            uint _2379 = uint(_1381 + 2);
            ivec2 _2386 = ivec2(int(_2379 % 1024u), int(_2379 / 1024u));
            vec4 _2314 = vec4(_2087.x);
            vec4 _2329 = mix(mix(texelFetch(sGpuCache, _2386, 0), texelFetch(sGpuCache, _2386 + ivec2(1, 0), 0), _2314), mix(texelFetch(sGpuCache, _2386 + ivec2(2, 0), 0), texelFetch(sGpuCache, _2386 + ivec2(3, 0), 0), _2314), vec4(_2087.y));
            _2849 = _2329.xy / vec2(_2329.w);
            break;
        }
        default:
        {
            _2849 = _2087;
            break;
        }
    }
    vec2 _2111 = _2876 / vec2(_2873.x ? _2815.x : _2872.x, _2873.y ? _2815.y : _2872.y);
    vec2 _2117 = mix(_2825, _2828, _2849) - _2064;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2117.x, _2117.y);
    vec2 _2123 = varying_vec4_0.zw / _2001;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2123.x, _2123.y);
    vec2 _2129 = varying_vec4_0.zw * _2111;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2129.x, _2129.y);
    if (_2056 == 0.0)
    {
        vec2 _2140 = varying_vec4_0.zw * _2818.w;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2140.x, _2140.y);
    }
    flat_varying_vec4_2 = vec4(_2064, _2067) / _2078;
    flat_varying_vec4_1 = vec4(flat_varying_vec4_1.x, flat_varying_vec4_1.y, _2111.x, _2111.y);
    float _2159 = float(_1447.z) * 1.525902189314365386962890625e-05;
    vec4 _2862;
    switch (_2089 >> 16)
    {
        case 0:
        {
            vec4 _2801 = _2232;
            _2801.w = _2232.w * _2159;
            _2862 = _2801;
            break;
        }
        default:
        {
            _2862 = _2232 * _2159;
            break;
        }
    }
    switch (_2861)
    {
        case 1:
        case 7:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0, 1.0).x, vec2(0.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _2862;
            break;
        }
        case 5:
        case 6:
        case 9:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _2862;
            break;
        }
        case 2:
        case 3:
        case 8:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_2862.w);
            break;
        }
        case 4:
        {
            flat_varying_vec4_1 = vec4(vec2(-1.0, 1.0).x, vec2(-1.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_2862.w) * texelFetch(sGpuCache, _2253 + ivec2(1, 0), 0);
            break;
        }
        default:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0).x, vec2(0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(1.0);
            break;
        }
    }
    varying_vec4_0 = vec4(_2819.x, _2819.y, varying_vec4_0.z, varying_vec4_0.w);
}

