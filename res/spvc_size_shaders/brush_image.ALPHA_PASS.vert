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

mat4 _3479;

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
    vec2 _3299;
    vec2 _3301;
    vec4 _3348;
    if (_1373 == 65535)
    {
        _3348 = vec4(0.0);
        _3301 = _1417;
        _3299 = _1419;
    }
    else
    {
        uint _1479 = uint((_1453 + 3) + (_1373 * 2));
        ivec2 _1486 = ivec2(int(_1479 % 1024u), int(_1479 / 1024u));
        vec4 _1470 = texelFetch(sGpuCache, _1486, 0);
        _3348 = texelFetch(sGpuCache, _1486 + ivec2(1, 0), 0);
        _3301 = _1470.xy + _1417;
        _3299 = _1470.zw;
    }
    uint _1510 = uint(aData.y >> 16);
    ivec2 _1518 = ivec2(int(2u * (_1510 % 512u)), int(_1510 / 512u));
    vec4 _1528 = texelFetch(sRenderTasks, _1518 + ivec2(1, 0), 0);
    vec2 _1530 = texelFetch(sRenderTasks, _1518, 0).xy;
    float _1496 = _1528.y;
    vec2 _1499 = _1528.zw;
    vec2 _3289;
    float _3290;
    float _3291;
    vec2 _3292;
    vec2 _3293;
    if (_1369 >= 32767)
    {
        _3293 = vec2(0.0);
        _3292 = vec2(0.0);
        _3291 = 0.0;
        _3290 = 0.0;
        _3289 = vec2(0.0);
    }
    else
    {
        uint _1579 = uint(_1369);
        ivec2 _1587 = ivec2(int(2u * (_1579 % 512u)), int(_1579 / 512u));
        vec4 _1592 = texelFetch(sRenderTasks, _1587, 0);
        vec4 _1597 = texelFetch(sRenderTasks, _1587 + ivec2(1, 0), 0);
        _3293 = _1592.xy;
        _3292 = _1592.zw;
        _3291 = _1597.x;
        _3290 = _1597.y;
        _3289 = _1597.zw;
    }
    uint _1624 = uint(_1456 & 16777215);
    ivec2 _1638 = ivec2(int(8u * (_1624 % 128u)), int(_1624 / 128u));
    mat4 _3446 = _3479;
    _3446[0] = texelFetch(sTransformPalette, _1638, 0);
    mat4 _3448 = _3446;
    _3448[1] = texelFetch(sTransformPalette, _1638 + ivec2(1, 0), 0);
    mat4 _3450 = _3448;
    _3450[2] = texelFetch(sTransformPalette, _1638 + ivec2(2, 0), 0);
    mat4 _3452 = _3450;
    _3452[3] = texelFetch(sTransformPalette, _1638 + ivec2(3, 0), 0);
    vec4 _3317;
    vec2 _3323;
    if ((_1456 >> 24) == 0)
    {
        vec2 _1757 = clamp(_3301 + (_3299 * aPosition.xy), _1423, _1423 + _1425);
        vec4 _1714 = _3452 * vec4(_1757, 0.0, 1.0);
        float _1730 = _1714.w;
        gl_Position = uTransform * vec4((_1714.xy * _1496) + (((-_1499) + _1530) * _1730), _1450 * _1730, _1730);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _3323 = _1757;
        _3317 = _1714;
    }
    else
    {
        bvec4 _1005 = notEqual((ivec4(_1377 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _1008 = vec4(_1005.x ? vec4(1.0).x : vec4(0.0).x, _1005.y ? vec4(1.0).y : vec4(0.0).y, _1005.z ? vec4(1.0).z : vec4(0.0).z, _1005.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1908 = _1423 + _1425;
        vec4 _1815 = vec4(2.0) * _1008;
        vec2 _1817 = _1815.xy;
        vec2 _1838 = (_3301 - _1817) + ((_3299 + (_1817 + _1815.zw)) * aPosition.xy);
        vec4 _1850 = _3452 * vec4(_1838, 0.0, 1.0);
        float _1858 = _1850.w;
        gl_Position = uTransform * vec4((_1850.xy * _1496) + ((_1530 - _1499) * _1858), _1450 * _1858, _1858);
        vTransformBounds = mix(vec4(clamp(_1417, _1423, _1908), clamp(_1417 + _1419, _1423, _1908)), vec4(clamp(_3301, _1423, _1908), clamp(_3301 + _3299, _1423, _1908)), _1008);
        _3323 = _1838;
        _3317 = _1850;
    }
    vClipMaskUvBounds = vec4(_3293, _3293 + _3292);
    vClipMaskUv = vec4((_3317.xy * _3290) + ((_3293 - _3289) * _3317.w), _3291, _3317.w);
    uint _2246 = uint(_1453);
    ivec2 _2253 = ivec2(int(_2246 % 1024u), int(_2246 / 1024u));
    vec4 _2232 = texelFetch(sGpuCache, _2253, 0);
    vec4 _2242 = texelFetch(sGpuCache, _2253 + ivec2(2, 0), 0);
    vec2 _2001 = vec2(vec3(textureSize(sColor0, 0)).xy);
    uint _2292 = uint(_1381);
    ivec2 _2299 = ivec2(int(_2292 % 1024u), int(_2292 / 1024u));
    vec4 _2283 = texelFetch(sGpuCache, _2299, 0);
    vec2 _2262 = _2283.xy;
    vec2 _2265 = _2283.zw;
    vec2 _3483;
    if (_2242.x < 0.0)
    {
        _3483 = _1419;
    }
    else
    {
        _3483 = _2242.xy;
    }
    bool _2020 = (_914 & 2) != 0;
    vec2 _3360;
    vec2 _3363;
    vec2 _3482;
    if (_2020)
    {
        vec2 _3362;
        vec2 _3365;
        if ((_914 & 128) != 0)
        {
            vec2 _2035 = _2265 - _2262;
            _3365 = _2262 + (_3348.zw * _2035);
            _3362 = _2262 + (_3348.xy * _2035);
        }
        else
        {
            _3365 = _2265;
            _3362 = _2262;
        }
        _3482 = _3299;
        _3363 = _3365;
        _3360 = _3362;
    }
    else
    {
        _3482 = _3483;
        _3363 = _2265;
        _3360 = _2262;
    }
    bvec2 _3433 = bvec2(_2020);
    vec2 _3434 = vec2(_3433.x ? _3299.x : _1419.x, _3433.y ? _3299.y : _1419.y);
    float _2056 = float((_914 & 1) != 0);
    flat_varying_vec4_4.x = texelFetch(sGpuCache, _2299 + ivec2(1, 0), 0).x;
    flat_varying_vec4_4.y = _2056;
    vec2 _2064 = min(_3360, _3363);
    vec2 _2067 = max(_3360, _3363);
    vec4 _2078 = _2001.xyxy;
    flat_varying_vec4_3 = vec4(_2064 + vec2(0.5), _2067 - vec2(0.5)) / _2078;
    vec2 _2087 = (_3323 - vec2(_3433.x ? _3301.x : _1417.x, _3433.y ? _3301.y : _1417.y)) / _3434;
    int _2089 = _1447.x;
    int _2090 = _2089 & 65535;
    int _3411;
    if (_2090 == 0)
    {
        _3411 = uMode;
    }
    else
    {
        _3411 = _2090;
    }
    vec2 _3390;
    switch (_1447.y)
    {
        case 1:
        {
            uint _2379 = uint(_1381 + 2);
            ivec2 _2386 = ivec2(int(_2379 % 1024u), int(_2379 / 1024u));
            vec4 _2314 = vec4(_2087.x);
            vec4 _2329 = mix(mix(texelFetch(sGpuCache, _2386, 0), texelFetch(sGpuCache, _2386 + ivec2(1, 0), 0), _2314), mix(texelFetch(sGpuCache, _2386 + ivec2(2, 0), 0), texelFetch(sGpuCache, _2386 + ivec2(3, 0), 0), _2314), vec4(_2087.y));
            _3390 = _2329.xy / vec2(_2329.w);
            break;
        }
        default:
        {
            _3390 = _2087;
            break;
        }
    }
    vec2 _2111 = _3434 / _3482;
    vec2 _2117 = mix(_3360, _3363, _3390) - _2064;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2117.x, _2117.y);
    vec2 _2123 = varying_vec4_0.zw / _2001;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2123.x, _2123.y);
    vec2 _2129 = varying_vec4_0.zw * _2111;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2129.x, _2129.y);
    if (_2056 == 0.0)
    {
        vec2 _2140 = varying_vec4_0.zw * _3317.w;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2140.x, _2140.y);
    }
    flat_varying_vec4_2 = vec4(_2064, _2067) / _2078;
    flat_varying_vec4_1 = vec4(flat_varying_vec4_1.x, flat_varying_vec4_1.y, _2111.x, _2111.y);
    float _2159 = float(_1447.z) * 1.525902189314365386962890625e-05;
    vec4 _3492;
    switch (_2089 >> 16)
    {
        case 0:
        {
            vec4 _3474 = _2232;
            _3474.w = _2232.w * _2159;
            _3492 = _3474;
            break;
        }
        default:
        {
            _3492 = _2232 * _2159;
            break;
        }
    }
    switch (_3411)
    {
        case 1:
        case 7:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0, 1.0).x, vec2(0.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _3492;
            break;
        }
        case 5:
        case 6:
        case 9:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _3492;
            break;
        }
        case 2:
        case 3:
        case 8:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_3492.w);
            break;
        }
        case 4:
        {
            flat_varying_vec4_1 = vec4(vec2(-1.0, 1.0).x, vec2(-1.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_3492.w) * texelFetch(sGpuCache, _2253 + ivec2(1, 0), 0);
            break;
        }
        default:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0).x, vec2(0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(1.0);
            break;
        }
    }
    varying_vec4_0 = vec4(_3323.x, _3323.y, varying_vec4_0.z, varying_vec4_0.w);
}

