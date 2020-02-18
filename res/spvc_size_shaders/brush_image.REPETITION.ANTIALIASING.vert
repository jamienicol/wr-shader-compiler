#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform mat4 uTransform;
uniform highp sampler2DArray sColor0;

flat out vec4 vTransformBounds;
layout(location = 1) in ivec4 aData;
layout(location = 0) in vec3 aPosition;
flat out vec4 flat_varying_vec4_4;
flat out vec4 flat_varying_vec4_3;
out vec4 varying_vec4_0;
flat out vec4 flat_varying_vec4_2;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_1;
flat out int flat_varying_highp_int_address_0;

mat4 _3367;

void main()
{
    int _1305 = aData.z & 65535;
    int _1309 = aData.z >> 16;
    int _774 = (_1309 >> 8) & 255;
    uint _1329 = uint(aData.x);
    ivec2 _1337 = ivec2(int(2u * (_1329 % 512u)), int(_1329 / 512u));
    vec4 _1342 = texelFetch(sPrimitiveHeadersF, _1337, 0);
    vec4 _1347 = texelFetch(sPrimitiveHeadersF, _1337 + ivec2(1, 0), 0);
    vec2 _1349 = _1342.xy;
    vec2 _1351 = _1342.zw;
    vec2 _1355 = _1347.xy;
    vec2 _1357 = _1347.zw;
    ivec4 _1374 = texelFetch(sPrimitiveHeadersI, _1337, 0);
    float _1382 = float(_1374.x);
    int _1385 = _1374.y;
    int _1388 = _1374.z;
    vec2 _3127;
    vec2 _3129;
    vec4 _3171;
    if (_1305 == 65535)
    {
        _3171 = vec4(0.0);
        _3129 = _1349;
        _3127 = _1351;
    }
    else
    {
        uint _1411 = uint((_1385 + 3) + (_1305 * 2));
        ivec2 _1418 = ivec2(int(_1411 % 1024u), int(_1411 / 1024u));
        vec4 _1402 = texelFetch(sGpuCache, _1418, 0);
        _3171 = texelFetch(sGpuCache, _1418 + ivec2(1, 0), 0);
        _3129 = _1402.xy + _1349;
        _3127 = _1402.zw;
    }
    uint _1442 = uint(aData.y >> 16);
    ivec2 _1450 = ivec2(int(2u * (_1442 % 512u)), int(_1442 / 512u));
    vec4 _1460 = texelFetch(sRenderTasks, _1450 + ivec2(1, 0), 0);
    vec2 _1462 = texelFetch(sRenderTasks, _1450, 0).xy;
    float _1428 = _1460.y;
    vec2 _1431 = _1460.zw;
    uint _1556 = uint(_1388 & 16777215);
    ivec2 _1570 = ivec2(int(8u * (_1556 % 128u)), int(_1556 / 128u));
    mat4 _3290 = _3367;
    _3290[0] = texelFetch(sTransformPalette, _1570, 0);
    mat4 _3292 = _3290;
    _3292[1] = texelFetch(sTransformPalette, _1570 + ivec2(1, 0), 0);
    mat4 _3294 = _3292;
    _3294[2] = texelFetch(sTransformPalette, _1570 + ivec2(2, 0), 0);
    mat4 _3296 = _3294;
    _3296[3] = texelFetch(sTransformPalette, _1570 + ivec2(3, 0), 0);
    vec4 _3145;
    vec2 _3146;
    if ((_1388 >> 24) == 0)
    {
        vec2 _1689 = clamp(_3129 + (_3127 * aPosition.xy), _1355, _1355 + _1357);
        vec4 _1646 = _3296 * vec4(_1689, 0.0, 1.0);
        float _1662 = _1646.w;
        gl_Position = uTransform * vec4((_1646.xy * _1428) + (((-_1431) + _1462) * _1662), _1382 * _1662, _1662);
        _3146 = _1689;
        _3145 = _1646;
    }
    else
    {
        bvec4 _860 = notEqual((ivec4(_1309 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _863 = vec4(_860.x ? vec4(1.0).x : vec4(0.0).x, _860.y ? vec4(1.0).y : vec4(0.0).y, _860.z ? vec4(1.0).z : vec4(0.0).z, _860.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1839 = _1355 + _1357;
        vec4 _1746 = vec4(2.0) * _863;
        vec2 _1748 = _1746.xy;
        vec2 _1769 = (_3129 - _1748) + ((_3127 + (_1748 + _1746.zw)) * aPosition.xy);
        vec4 _1781 = _3296 * vec4(_1769, 0.0, 1.0);
        float _1789 = _1781.w;
        gl_Position = uTransform * vec4((_1781.xy * _1428) + ((_1462 - _1431) * _1789), _1382 * _1789, _1789);
        vTransformBounds = mix(vec4(clamp(_1349, _1355, _1839), clamp(_1349 + _1351, _1355, _1839)), vec4(clamp(_3129, _1355, _1839), clamp(_3129 + _3127, _1355, _1839)), _863);
        _3146 = _1769;
        _3145 = _1781;
    }
    uint _2236 = uint(_1385);
    vec4 _2232 = texelFetch(sGpuCache, ivec2(int(_2236 % 1024u), int(_2236 / 1024u)) + ivec2(2, 0), 0);
    vec2 _1895 = vec2(vec3(textureSize(sColor0, 0)).xy);
    uint _2282 = uint(aData.w & 16777215);
    ivec2 _2289 = ivec2(int(_2282 % 1024u), int(_2282 / 1024u));
    vec4 _2273 = texelFetch(sGpuCache, _2289, 0);
    vec2 _2252 = _2273.xy;
    vec2 _2255 = _2273.zw;
    vec2 _3400;
    if (_2232.x < 0.0)
    {
        _3400 = _1351;
    }
    else
    {
        _3400 = _2232.xy;
    }
    bool _1914 = (_774 & 2) != 0;
    vec2 _3203;
    vec2 _3388;
    vec2 _3399;
    if (_1914)
    {
        vec2 _3207;
        vec2 _3384;
        vec2 _3392;
        if ((_774 & 128) != 0)
        {
            vec2 _1930 = _2255 - _2252;
            vec2 _1937 = _2252 + (_3171.xy * _1930);
            vec2 _1944 = _2252 + (_3171.zw * _1930);
            vec2 _3378;
            vec2 _3380;
            if ((_774 & 64) != 0)
            {
                vec2 _1956 = _1937 - _2252;
                float _1960 = _1342.x;
                float _1961 = _3129.x - _1960;
                vec2 _3308 = _3127;
                _3308.x = _1961;
                float _1966 = _1342.y;
                vec2 _3312 = _3308;
                _3312.y = _3129.y - _1966;
                bool _1972 = _1956.x < 0.001000000047497451305389404296875;
                bool _1980;
                if (!_1972)
                {
                    _1980 = _1961 < 0.001000000047497451305389404296875;
                }
                else
                {
                    _1980 = _1972;
                }
                vec2 _3372;
                vec2 _3373;
                if (_1980)
                {
                    vec2 _3318 = _1956;
                    _3318.x = _2273.z - _1944.x;
                    vec2 _3324 = _3312;
                    _3324.x = ((_1960 + _1342.z) - _3129.x) - _3127.x;
                    _3373 = _3324;
                    _3372 = _3318;
                }
                else
                {
                    _3373 = _3312;
                    _3372 = _1956;
                }
                bool _2004 = _3372.y < 0.001000000047497451305389404296875;
                bool _2012;
                if (!_2004)
                {
                    _2012 = _3373.y < 0.001000000047497451305389404296875;
                }
                else
                {
                    _2012 = _2004;
                }
                vec2 _3379;
                vec2 _3381;
                if (_2012)
                {
                    vec2 _3330 = _3372;
                    _3330.y = _2273.w - _1944.y;
                    vec2 _3336 = _3373;
                    _3336.y = ((_1966 + _1342.w) - _3129.y) - _3127.y;
                    _3381 = _3330;
                    _3379 = _3336;
                }
                else
                {
                    _3381 = _3372;
                    _3379 = _3373;
                }
                _3380 = _3381;
                _3378 = _3379;
            }
            else
            {
                _3380 = _1944 - _1937;
                _3378 = _3127;
            }
            vec2 _3383;
            if ((_774 & 4) != 0)
            {
                vec2 _3341 = _3378;
                _3341.x = (_3378.y / _3380.y) * _3380.x;
                _3383 = _3341;
            }
            else
            {
                _3383 = _3378;
            }
            vec2 _3385;
            if ((_774 & 8) != 0)
            {
                vec2 _3346 = _3383;
                _3346.y = (_3378.x / _3380.x) * _3380.y;
                _3385 = _3346;
            }
            else
            {
                _3385 = _3383;
            }
            _3392 = _1944;
            _3384 = _3385;
            _3207 = _1937;
        }
        else
        {
            vec2 _3368;
            if ((_774 & 4) != 0)
            {
                vec2 _3350 = _3127;
                _3350.x = _3171.z - _3171.x;
                _3368 = _3350;
            }
            else
            {
                _3368 = _3127;
            }
            vec2 _3386;
            if ((_774 & 8) != 0)
            {
                vec2 _3354 = _3368;
                _3354.y = _3171.w - _3171.y;
                _3386 = _3354;
            }
            else
            {
                _3386 = _3368;
            }
            _3392 = _2255;
            _3384 = _3386;
            _3207 = _2252;
        }
        vec2 _3387;
        if ((_774 & 16) != 0)
        {
            vec2 _3359 = _3384;
            _3359.x = _3127.x / max(1.0, round(_3127.x / _3384.x));
            _3387 = _3359;
        }
        else
        {
            _3387 = _3384;
        }
        vec2 _3401;
        if ((_774 & 32) != 0)
        {
            vec2 _3364 = _3387;
            _3364.y = _3127.y / max(1.0, round(_3127.y / _3387.y));
            _3401 = _3364;
        }
        else
        {
            _3401 = _3387;
        }
        _3399 = _3401;
        _3388 = _3392;
        _3203 = _3207;
    }
    else
    {
        _3399 = _3400;
        _3388 = _2255;
        _3203 = _2252;
    }
    bvec2 _3279 = bvec2(_1914);
    vec2 _3280 = vec2(_3279.x ? _3127.x : _1351.x, _3279.y ? _3127.y : _1351.y);
    float _2121 = float((_774 & 1) != 0);
    flat_varying_vec4_4.x = texelFetch(sGpuCache, _2289 + ivec2(1, 0), 0).x;
    flat_varying_vec4_4.y = _2121;
    vec2 _2129 = min(_3203, _3388);
    vec2 _2132 = max(_3203, _3388);
    vec4 _2143 = _1895.xyxy;
    flat_varying_vec4_3 = vec4(_2129 + vec2(0.5), _2132 - vec2(0.5)) / _2143;
    vec2 _2162 = mix(_3203, _3388, (_3146 - vec2(_3279.x ? _3129.x : _1349.x, _3279.y ? _3129.y : _1349.y)) / _3280) - _2129;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2162.x, _2162.y);
    vec2 _2168 = varying_vec4_0.zw / _1895;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2168.x, _2168.y);
    vec2 _2174 = varying_vec4_0.zw * (_3280 / _3399);
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2174.x, _2174.y);
    if (_2121 == 0.0)
    {
        vec2 _2185 = varying_vec4_0.zw * _3145.w;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2185.x, _2185.y);
    }
    flat_varying_vec4_2 = vec4(_2129, _2132) / _2143;
}

