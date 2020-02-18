#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform mat4 uTransform;
uniform mediump sampler2D sColor0;
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

mat4 _2804;

void main()
{
    int _1365 = aData.y & 65535;
    int _1369 = aData.z & 65535;
    int _1373 = aData.z >> 16;
    int _1377 = aData.w & 16777215;
    int _914 = (_1373 >> 8) & 255;
    uint _1393 = uint(aData.x);
    ivec2 _1401 = ivec2(int(2u * (_1393 % 512u)), int(_1393 / 512u));
    vec4 _1406 = texelFetch(sPrimitiveHeadersF, _1401, 0);
    ivec2 _1409 = _1401 + ivec2(1, 0);
    vec4 _1411 = texelFetch(sPrimitiveHeadersF, _1409, 0);
    vec2 _1413 = _1406.xy;
    vec2 _1415 = _1406.zw;
    vec2 _1419 = _1411.xy;
    vec2 _1421 = _1411.zw;
    ivec4 _1438 = texelFetch(sPrimitiveHeadersI, _1401, 0);
    ivec4 _1443 = texelFetch(sPrimitiveHeadersI, _1409, 0);
    float _1446 = float(_1438.x);
    int _1449 = _1438.y;
    int _1452 = _1438.z;
    vec2 _2808;
    vec2 _2810;
    vec4 _2817;
    if (_1369 == 65535)
    {
        _2817 = vec4(0.0);
        _2810 = _1413;
        _2808 = _1415;
    }
    else
    {
        uint _1475 = uint((_1449 + 3) + (_1369 * 2));
        ivec2 _1482 = ivec2(int(_1475 % 1024u), int(_1475 / 1024u));
        vec4 _1466 = texelFetch(sGpuCache, _1482, 0);
        _2817 = texelFetch(sGpuCache, _1482 + ivec2(1, 0), 0);
        _2810 = _1466.xy + _1413;
        _2808 = _1466.zw;
    }
    uint _1506 = uint(aData.y >> 16);
    ivec2 _1514 = ivec2(int(2u * (_1506 % 512u)), int(_1506 / 512u));
    vec4 _1524 = texelFetch(sRenderTasks, _1514 + ivec2(1, 0), 0);
    vec2 _1526 = texelFetch(sRenderTasks, _1514, 0).xy;
    float _1492 = _1524.y;
    vec2 _1495 = _1524.zw;
    vec2 _2797;
    float _2798;
    float _2799;
    vec2 _2800;
    vec2 _2801;
    if (_1365 >= 32767)
    {
        _2801 = vec2(0.0);
        _2800 = vec2(0.0);
        _2799 = 0.0;
        _2798 = 0.0;
        _2797 = vec2(0.0);
    }
    else
    {
        uint _1575 = uint(_1365);
        ivec2 _1583 = ivec2(int(2u * (_1575 % 512u)), int(_1575 / 512u));
        vec4 _1588 = texelFetch(sRenderTasks, _1583, 0);
        vec4 _1593 = texelFetch(sRenderTasks, _1583 + ivec2(1, 0), 0);
        _2801 = _1588.xy;
        _2800 = _1588.zw;
        _2799 = _1593.x;
        _2798 = _1593.y;
        _2797 = _1593.zw;
    }
    uint _1620 = uint(_1452 & 16777215);
    ivec2 _1634 = ivec2(int(8u * (_1620 % 128u)), int(_1620 / 128u));
    mat4 _2758 = _2804;
    _2758[0] = texelFetch(sTransformPalette, _1634, 0);
    mat4 _2760 = _2758;
    _2760[1] = texelFetch(sTransformPalette, _1634 + ivec2(1, 0), 0);
    mat4 _2762 = _2760;
    _2762[2] = texelFetch(sTransformPalette, _1634 + ivec2(2, 0), 0);
    mat4 _2764 = _2762;
    _2764[3] = texelFetch(sTransformPalette, _1634 + ivec2(3, 0), 0);
    vec4 _2811;
    vec2 _2812;
    if ((_1452 >> 24) == 0)
    {
        vec2 _1753 = clamp(_2810 + (_2808 * aPosition.xy), _1419, _1419 + _1421);
        vec4 _1710 = _2764 * vec4(_1753, 0.0, 1.0);
        float _1726 = _1710.w;
        gl_Position = uTransform * vec4((_1710.xy * _1492) + (((-_1495) + _1526) * _1726), _1446 * _1726, _1726);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _2812 = _1753;
        _2811 = _1710;
    }
    else
    {
        bvec4 _1005 = notEqual((ivec4(_1373 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _1008 = vec4(_1005.x ? vec4(1.0).x : vec4(0.0).x, _1005.y ? vec4(1.0).y : vec4(0.0).y, _1005.z ? vec4(1.0).z : vec4(0.0).z, _1005.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1904 = _1419 + _1421;
        vec4 _1811 = vec4(2.0) * _1008;
        vec2 _1813 = _1811.xy;
        vec2 _1834 = (_2810 - _1813) + ((_2808 + (_1813 + _1811.zw)) * aPosition.xy);
        vec4 _1846 = _2764 * vec4(_1834, 0.0, 1.0);
        float _1854 = _1846.w;
        gl_Position = uTransform * vec4((_1846.xy * _1492) + ((_1526 - _1495) * _1854), _1446 * _1854, _1854);
        vTransformBounds = mix(vec4(clamp(_1413, _1419, _1904), clamp(_1413 + _1415, _1419, _1904)), vec4(clamp(_2810, _1419, _1904), clamp(_2810 + _2808, _1419, _1904)), _1008);
        _2812 = _1834;
        _2811 = _1846;
    }
    vClipMaskUvBounds = vec4(_2801, _2801 + _2800);
    vClipMaskUv = vec4((_2811.xy * _2798) + ((_2801 - _2797) * _2811.w), _2799, _2811.w);
    uint _2239 = uint(_1449);
    ivec2 _2246 = ivec2(int(_2239 % 1024u), int(_2239 / 1024u));
    vec4 _2225 = texelFetch(sGpuCache, _2246, 0);
    vec4 _2235 = texelFetch(sGpuCache, _2246 + ivec2(2, 0), 0);
    vec2 _2213 = _2235.xy;
    vec2 _1994 = vec2(textureSize(sColor0, 0));
    uint _2285 = uint(_1377);
    ivec2 _2292 = ivec2(int(_2285 % 1024u), int(_2285 / 1024u));
    vec4 _2276 = texelFetch(sGpuCache, _2292, 0);
    vec2 _2255 = _2276.xy;
    vec2 _2258 = _2276.zw;
    bvec2 _2864 = bvec2(_2235.x < 0.0);
    vec2 _2865 = vec2(_2864.x ? _1415.x : _2213.x, _2864.y ? _1415.y : _2213.y);
    bool _2013 = (_914 & 2) != 0;
    vec2 _2818;
    vec2 _2821;
    if (_2013)
    {
        vec2 _2820;
        vec2 _2823;
        if ((_914 & 128) != 0)
        {
            vec2 _2028 = _2258 - _2255;
            _2823 = _2255 + (_2817.zw * _2028);
            _2820 = _2255 + (_2817.xy * _2028);
        }
        else
        {
            _2823 = _2258;
            _2820 = _2255;
        }
        _2821 = _2823;
        _2818 = _2820;
    }
    else
    {
        _2821 = _2258;
        _2818 = _2255;
    }
    bvec2 _2866 = bvec2(_2013);
    vec2 _2869 = vec2(_2866.x ? _2808.x : _1415.x, _2866.y ? _2808.y : _1415.y);
    float _2049 = float((_914 & 1) != 0);
    flat_varying_vec4_4.x = texelFetch(sGpuCache, _2292 + ivec2(1, 0), 0).x;
    flat_varying_vec4_4.y = _2049;
    vec2 _2057 = min(_2818, _2821);
    vec2 _2060 = max(_2818, _2821);
    vec4 _2071 = _1994.xyxy;
    flat_varying_vec4_3 = vec4(_2057 + vec2(0.5), _2060 - vec2(0.5)) / _2071;
    vec2 _2080 = (_2812 - vec2(_2866.x ? _2810.x : _1413.x, _2866.y ? _2810.y : _1413.y)) / _2869;
    int _2082 = _1443.x;
    int _2083 = _2082 & 65535;
    int _2854;
    if (_2083 == 0)
    {
        _2854 = uMode;
    }
    else
    {
        _2854 = _2083;
    }
    vec2 _2842;
    switch (_1443.y)
    {
        case 1:
        {
            uint _2372 = uint(_1377 + 2);
            ivec2 _2379 = ivec2(int(_2372 % 1024u), int(_2372 / 1024u));
            vec4 _2307 = vec4(_2080.x);
            vec4 _2322 = mix(mix(texelFetch(sGpuCache, _2379, 0), texelFetch(sGpuCache, _2379 + ivec2(1, 0), 0), _2307), mix(texelFetch(sGpuCache, _2379 + ivec2(2, 0), 0), texelFetch(sGpuCache, _2379 + ivec2(3, 0), 0), _2307), vec4(_2080.y));
            _2842 = _2322.xy / vec2(_2322.w);
            break;
        }
        default:
        {
            _2842 = _2080;
            break;
        }
    }
    vec2 _2104 = _2869 / vec2(_2866.x ? _2808.x : _2865.x, _2866.y ? _2808.y : _2865.y);
    vec2 _2110 = mix(_2818, _2821, _2842) - _2057;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2110.x, _2110.y);
    vec2 _2116 = varying_vec4_0.zw / _1994;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2116.x, _2116.y);
    vec2 _2122 = varying_vec4_0.zw * _2104;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2122.x, _2122.y);
    if (_2049 == 0.0)
    {
        vec2 _2133 = varying_vec4_0.zw * _2811.w;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2133.x, _2133.y);
    }
    flat_varying_vec4_2 = vec4(_2057, _2060) / _2071;
    flat_varying_vec4_1 = vec4(flat_varying_vec4_1.x, flat_varying_vec4_1.y, _2104.x, _2104.y);
    float _2152 = float(_1443.z) * 1.525902189314365386962890625e-05;
    vec4 _2855;
    switch (_2082 >> 16)
    {
        case 0:
        {
            vec4 _2794 = _2225;
            _2794.w = _2225.w * _2152;
            _2855 = _2794;
            break;
        }
        default:
        {
            _2855 = _2225 * _2152;
            break;
        }
    }
    switch (_2854)
    {
        case 1:
        case 7:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0, 1.0).x, vec2(0.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _2855;
            break;
        }
        case 5:
        case 6:
        case 9:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _2855;
            break;
        }
        case 2:
        case 3:
        case 8:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_2855.w);
            break;
        }
        case 4:
        {
            flat_varying_vec4_1 = vec4(vec2(-1.0, 1.0).x, vec2(-1.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_2855.w) * texelFetch(sGpuCache, _2246 + ivec2(1, 0), 0);
            break;
        }
        default:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0).x, vec2(0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(1.0);
            break;
        }
    }
    varying_vec4_0 = vec4(_2812.x, _2812.y, varying_vec4_0.z, varying_vec4_0.w);
}

