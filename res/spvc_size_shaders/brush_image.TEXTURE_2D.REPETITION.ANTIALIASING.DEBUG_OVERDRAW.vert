#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform mat4 uTransform;
uniform mediump sampler2D sColor0;

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

mat4 _3360;

void main()
{
    int _1301 = aData.z & 65535;
    int _1305 = aData.z >> 16;
    int _774 = (_1305 >> 8) & 255;
    uint _1325 = uint(aData.x);
    ivec2 _1333 = ivec2(int(2u * (_1325 % 512u)), int(_1325 / 512u));
    vec4 _1338 = texelFetch(sPrimitiveHeadersF, _1333, 0);
    vec4 _1343 = texelFetch(sPrimitiveHeadersF, _1333 + ivec2(1, 0), 0);
    vec2 _1345 = _1338.xy;
    vec2 _1347 = _1338.zw;
    vec2 _1351 = _1343.xy;
    vec2 _1353 = _1343.zw;
    ivec4 _1370 = texelFetch(sPrimitiveHeadersI, _1333, 0);
    float _1378 = float(_1370.x);
    int _1381 = _1370.y;
    int _1384 = _1370.z;
    vec2 _3120;
    vec2 _3122;
    vec4 _3164;
    if (_1301 == 65535)
    {
        _3164 = vec4(0.0);
        _3122 = _1345;
        _3120 = _1347;
    }
    else
    {
        uint _1407 = uint((_1381 + 3) + (_1301 * 2));
        ivec2 _1414 = ivec2(int(_1407 % 1024u), int(_1407 / 1024u));
        vec4 _1398 = texelFetch(sGpuCache, _1414, 0);
        _3164 = texelFetch(sGpuCache, _1414 + ivec2(1, 0), 0);
        _3122 = _1398.xy + _1345;
        _3120 = _1398.zw;
    }
    uint _1438 = uint(aData.y >> 16);
    ivec2 _1446 = ivec2(int(2u * (_1438 % 512u)), int(_1438 / 512u));
    vec4 _1456 = texelFetch(sRenderTasks, _1446 + ivec2(1, 0), 0);
    vec2 _1458 = texelFetch(sRenderTasks, _1446, 0).xy;
    float _1424 = _1456.y;
    vec2 _1427 = _1456.zw;
    uint _1552 = uint(_1384 & 16777215);
    ivec2 _1566 = ivec2(int(8u * (_1552 % 128u)), int(_1552 / 128u));
    mat4 _3283 = _3360;
    _3283[0] = texelFetch(sTransformPalette, _1566, 0);
    mat4 _3285 = _3283;
    _3285[1] = texelFetch(sTransformPalette, _1566 + ivec2(1, 0), 0);
    mat4 _3287 = _3285;
    _3287[2] = texelFetch(sTransformPalette, _1566 + ivec2(2, 0), 0);
    mat4 _3289 = _3287;
    _3289[3] = texelFetch(sTransformPalette, _1566 + ivec2(3, 0), 0);
    vec4 _3138;
    vec2 _3139;
    if ((_1384 >> 24) == 0)
    {
        vec2 _1685 = clamp(_3122 + (_3120 * aPosition.xy), _1351, _1351 + _1353);
        vec4 _1642 = _3289 * vec4(_1685, 0.0, 1.0);
        float _1658 = _1642.w;
        gl_Position = uTransform * vec4((_1642.xy * _1424) + (((-_1427) + _1458) * _1658), _1378 * _1658, _1658);
        _3139 = _1685;
        _3138 = _1642;
    }
    else
    {
        bvec4 _860 = notEqual((ivec4(_1305 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _863 = vec4(_860.x ? vec4(1.0).x : vec4(0.0).x, _860.y ? vec4(1.0).y : vec4(0.0).y, _860.z ? vec4(1.0).z : vec4(0.0).z, _860.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1835 = _1351 + _1353;
        vec4 _1742 = vec4(2.0) * _863;
        vec2 _1744 = _1742.xy;
        vec2 _1765 = (_3122 - _1744) + ((_3120 + (_1744 + _1742.zw)) * aPosition.xy);
        vec4 _1777 = _3289 * vec4(_1765, 0.0, 1.0);
        float _1785 = _1777.w;
        gl_Position = uTransform * vec4((_1777.xy * _1424) + ((_1458 - _1427) * _1785), _1378 * _1785, _1785);
        vTransformBounds = mix(vec4(clamp(_1345, _1351, _1835), clamp(_1345 + _1347, _1351, _1835)), vec4(clamp(_3122, _1351, _1835), clamp(_3122 + _3120, _1351, _1835)), _863);
        _3139 = _1765;
        _3138 = _1777;
    }
    uint _2229 = uint(_1381);
    vec4 _2225 = texelFetch(sGpuCache, ivec2(int(_2229 % 1024u), int(_2229 / 1024u)) + ivec2(2, 0), 0);
    vec2 _1888 = vec2(textureSize(sColor0, 0));
    uint _2275 = uint(aData.w & 16777215);
    ivec2 _2282 = ivec2(int(_2275 % 1024u), int(_2275 / 1024u));
    vec4 _2266 = texelFetch(sGpuCache, _2282, 0);
    vec2 _2245 = _2266.xy;
    vec2 _2248 = _2266.zw;
    vec2 _3393;
    if (_2225.x < 0.0)
    {
        _3393 = _1347;
    }
    else
    {
        _3393 = _2225.xy;
    }
    bool _1907 = (_774 & 2) != 0;
    vec2 _3196;
    vec2 _3381;
    vec2 _3392;
    if (_1907)
    {
        vec2 _3200;
        vec2 _3377;
        vec2 _3385;
        if ((_774 & 128) != 0)
        {
            vec2 _1923 = _2248 - _2245;
            vec2 _1930 = _2245 + (_3164.xy * _1923);
            vec2 _1937 = _2245 + (_3164.zw * _1923);
            vec2 _3371;
            vec2 _3373;
            if ((_774 & 64) != 0)
            {
                vec2 _1949 = _1930 - _2245;
                float _1953 = _1338.x;
                float _1954 = _3122.x - _1953;
                vec2 _3301 = _3120;
                _3301.x = _1954;
                float _1959 = _1338.y;
                vec2 _3305 = _3301;
                _3305.y = _3122.y - _1959;
                bool _1965 = _1949.x < 0.001000000047497451305389404296875;
                bool _1973;
                if (!_1965)
                {
                    _1973 = _1954 < 0.001000000047497451305389404296875;
                }
                else
                {
                    _1973 = _1965;
                }
                vec2 _3365;
                vec2 _3366;
                if (_1973)
                {
                    vec2 _3311 = _1949;
                    _3311.x = _2266.z - _1937.x;
                    vec2 _3317 = _3305;
                    _3317.x = ((_1953 + _1338.z) - _3122.x) - _3120.x;
                    _3366 = _3317;
                    _3365 = _3311;
                }
                else
                {
                    _3366 = _3305;
                    _3365 = _1949;
                }
                bool _1997 = _3365.y < 0.001000000047497451305389404296875;
                bool _2005;
                if (!_1997)
                {
                    _2005 = _3366.y < 0.001000000047497451305389404296875;
                }
                else
                {
                    _2005 = _1997;
                }
                vec2 _3372;
                vec2 _3374;
                if (_2005)
                {
                    vec2 _3323 = _3365;
                    _3323.y = _2266.w - _1937.y;
                    vec2 _3329 = _3366;
                    _3329.y = ((_1959 + _1338.w) - _3122.y) - _3120.y;
                    _3374 = _3323;
                    _3372 = _3329;
                }
                else
                {
                    _3374 = _3365;
                    _3372 = _3366;
                }
                _3373 = _3374;
                _3371 = _3372;
            }
            else
            {
                _3373 = _1937 - _1930;
                _3371 = _3120;
            }
            vec2 _3376;
            if ((_774 & 4) != 0)
            {
                vec2 _3334 = _3371;
                _3334.x = (_3371.y / _3373.y) * _3373.x;
                _3376 = _3334;
            }
            else
            {
                _3376 = _3371;
            }
            vec2 _3378;
            if ((_774 & 8) != 0)
            {
                vec2 _3339 = _3376;
                _3339.y = (_3371.x / _3373.x) * _3373.y;
                _3378 = _3339;
            }
            else
            {
                _3378 = _3376;
            }
            _3385 = _1937;
            _3377 = _3378;
            _3200 = _1930;
        }
        else
        {
            vec2 _3361;
            if ((_774 & 4) != 0)
            {
                vec2 _3343 = _3120;
                _3343.x = _3164.z - _3164.x;
                _3361 = _3343;
            }
            else
            {
                _3361 = _3120;
            }
            vec2 _3379;
            if ((_774 & 8) != 0)
            {
                vec2 _3347 = _3361;
                _3347.y = _3164.w - _3164.y;
                _3379 = _3347;
            }
            else
            {
                _3379 = _3361;
            }
            _3385 = _2248;
            _3377 = _3379;
            _3200 = _2245;
        }
        vec2 _3380;
        if ((_774 & 16) != 0)
        {
            vec2 _3352 = _3377;
            _3352.x = _3120.x / max(1.0, round(_3120.x / _3377.x));
            _3380 = _3352;
        }
        else
        {
            _3380 = _3377;
        }
        vec2 _3394;
        if ((_774 & 32) != 0)
        {
            vec2 _3357 = _3380;
            _3357.y = _3120.y / max(1.0, round(_3120.y / _3380.y));
            _3394 = _3357;
        }
        else
        {
            _3394 = _3380;
        }
        _3392 = _3394;
        _3381 = _3385;
        _3196 = _3200;
    }
    else
    {
        _3392 = _3393;
        _3381 = _2248;
        _3196 = _2245;
    }
    bvec2 _3272 = bvec2(_1907);
    vec2 _3273 = vec2(_3272.x ? _3120.x : _1347.x, _3272.y ? _3120.y : _1347.y);
    float _2114 = float((_774 & 1) != 0);
    flat_varying_vec4_4.x = texelFetch(sGpuCache, _2282 + ivec2(1, 0), 0).x;
    flat_varying_vec4_4.y = _2114;
    vec2 _2122 = min(_3196, _3381);
    vec2 _2125 = max(_3196, _3381);
    vec4 _2136 = _1888.xyxy;
    flat_varying_vec4_3 = vec4(_2122 + vec2(0.5), _2125 - vec2(0.5)) / _2136;
    vec2 _2155 = mix(_3196, _3381, (_3139 - vec2(_3272.x ? _3122.x : _1345.x, _3272.y ? _3122.y : _1345.y)) / _3273) - _2122;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2155.x, _2155.y);
    vec2 _2161 = varying_vec4_0.zw / _1888;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2161.x, _2161.y);
    vec2 _2167 = varying_vec4_0.zw * (_3273 / _3392);
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2167.x, _2167.y);
    if (_2114 == 0.0)
    {
        vec2 _2178 = varying_vec4_0.zw * _3138.w;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2178.x, _2178.y);
    }
    flat_varying_vec4_2 = vec4(_2122, _2125) / _2136;
}

