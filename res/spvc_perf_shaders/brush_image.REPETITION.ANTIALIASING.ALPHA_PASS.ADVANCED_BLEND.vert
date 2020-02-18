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

mat4 _3253;
vec2 _3384;

void main()
{
    int _1547 = aData.y & 65535;
    int _1551 = aData.z & 65535;
    int _1555 = aData.z >> 16;
    int _1559 = aData.w & 16777215;
    int _914 = (_1555 >> 8) & 255;
    uint _1575 = uint(aData.x);
    ivec2 _1583 = ivec2(int(2u * (_1575 % 512u)), int(_1575 / 512u));
    vec4 _1588 = texelFetch(sPrimitiveHeadersF, _1583, 0);
    ivec2 _1591 = _1583 + ivec2(1, 0);
    vec4 _1593 = texelFetch(sPrimitiveHeadersF, _1591, 0);
    vec2 _1595 = _1588.xy;
    vec2 _1597 = _1588.zw;
    vec2 _1601 = _1593.xy;
    vec2 _1603 = _1593.zw;
    ivec4 _1620 = texelFetch(sPrimitiveHeadersI, _1583, 0);
    ivec4 _1625 = texelFetch(sPrimitiveHeadersI, _1591, 0);
    float _1628 = float(_1620.x);
    int _1631 = _1620.y;
    int _1634 = _1620.z;
    vec2 _3257;
    vec2 _3259;
    vec4 _3266;
    if (_1551 == 65535)
    {
        _3266 = vec4(0.0);
        _3259 = _1595;
        _3257 = _1597;
    }
    else
    {
        uint _1657 = uint((_1631 + 3) + (_1551 * 2));
        ivec2 _1664 = ivec2(int(_1657 % 1024u), int(_1657 / 1024u));
        vec4 _1648 = texelFetch(sGpuCache, _1664, 0);
        _3266 = texelFetch(sGpuCache, _1664 + ivec2(1, 0), 0);
        _3259 = _1648.xy + _1595;
        _3257 = _1648.zw;
    }
    uint _1688 = uint(aData.y >> 16);
    ivec2 _1696 = ivec2(int(2u * (_1688 % 512u)), int(_1688 / 512u));
    vec4 _1706 = texelFetch(sRenderTasks, _1696 + ivec2(1, 0), 0);
    vec2 _1708 = texelFetch(sRenderTasks, _1696, 0).xy;
    float _1674 = _1706.y;
    vec2 _1677 = _1706.zw;
    vec2 _3246;
    float _3247;
    float _3248;
    vec2 _3249;
    vec2 _3250;
    if (_1547 >= 32767)
    {
        _3250 = vec2(0.0);
        _3249 = vec2(0.0);
        _3248 = 0.0;
        _3247 = 0.0;
        _3246 = vec2(0.0);
    }
    else
    {
        uint _1757 = uint(_1547);
        ivec2 _1765 = ivec2(int(2u * (_1757 % 512u)), int(_1757 / 512u));
        vec4 _1770 = texelFetch(sRenderTasks, _1765, 0);
        vec4 _1775 = texelFetch(sRenderTasks, _1765 + ivec2(1, 0), 0);
        _3250 = _1770.xy;
        _3249 = _1770.zw;
        _3248 = _1775.x;
        _3247 = _1775.y;
        _3246 = _1775.zw;
    }
    uint _1802 = uint(_1634 & 16777215);
    ivec2 _1816 = ivec2(int(8u * (_1802 % 128u)), int(_1802 / 128u));
    mat4 _3147 = _3253;
    _3147[0] = texelFetch(sTransformPalette, _1816, 0);
    mat4 _3149 = _3147;
    _3149[1] = texelFetch(sTransformPalette, _1816 + ivec2(1, 0), 0);
    mat4 _3151 = _3149;
    _3151[2] = texelFetch(sTransformPalette, _1816 + ivec2(2, 0), 0);
    mat4 _3153 = _3151;
    _3153[3] = texelFetch(sTransformPalette, _1816 + ivec2(3, 0), 0);
    vec4 _3260;
    vec2 _3261;
    if ((_1634 >> 24) == 0)
    {
        vec2 _1935 = clamp(_3259 + (_3257 * aPosition.xy), _1601, _1601 + _1603);
        vec4 _1892 = _3153 * vec4(_1935, 0.0, 1.0);
        float _1908 = _1892.w;
        gl_Position = uTransform * vec4((_1892.xy * _1674) + (((-_1677) + _1708) * _1908), _1628 * _1908, _1908);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _3261 = _1935;
        _3260 = _1892;
    }
    else
    {
        bvec4 _1005 = notEqual((ivec4(_1555 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _1008 = vec4(_1005.x ? vec4(1.0).x : vec4(0.0).x, _1005.y ? vec4(1.0).y : vec4(0.0).y, _1005.z ? vec4(1.0).z : vec4(0.0).z, _1005.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _2086 = _1601 + _1603;
        vec4 _1993 = vec4(2.0) * _1008;
        vec2 _1995 = _1993.xy;
        vec2 _2016 = (_3259 - _1995) + ((_3257 + (_1995 + _1993.zw)) * aPosition.xy);
        vec4 _2028 = _3153 * vec4(_2016, 0.0, 1.0);
        float _2036 = _2028.w;
        gl_Position = uTransform * vec4((_2028.xy * _1674) + ((_1708 - _1677) * _2036), _1628 * _2036, _2036);
        vTransformBounds = mix(vec4(clamp(_1595, _1601, _2086), clamp(_1595 + _1597, _1601, _2086)), vec4(clamp(_3259, _1601, _2086), clamp(_3259 + _3257, _1601, _2086)), _1008);
        _3261 = _2016;
        _3260 = _2028;
    }
    vClipMaskUvBounds = vec4(_3250, _3250 + _3249);
    vClipMaskUv = vec4((_3260.xy * _3247) + ((_3250 - _3246) * _3260.w), _3248, _3260.w);
    uint _2599 = uint(_1631);
    ivec2 _2606 = ivec2(int(_2599 % 1024u), int(_2599 / 1024u));
    vec4 _2585 = texelFetch(sGpuCache, _2606, 0);
    vec4 _2595 = texelFetch(sGpuCache, _2606 + ivec2(2, 0), 0);
    vec2 _2573 = _2595.xy;
    vec2 _2183 = vec2(vec3(textureSize(sColor0, 0)).xy);
    uint _2645 = uint(_1559);
    ivec2 _2652 = ivec2(int(_2645 % 1024u), int(_2645 / 1024u));
    vec4 _2636 = texelFetch(sGpuCache, _2652, 0);
    vec2 _2615 = _2636.xy;
    vec2 _2618 = _2636.zw;
    bvec2 _3386 = bvec2(_2595.x < 0.0);
    bool _2202 = (_914 & 2) != 0;
    vec2 _3287;
    vec2 _3301;
    vec2 _3345;
    if (_2202)
    {
        vec2 _3283;
        vec2 _3291;
        vec2 _3305;
        if ((_914 & 128) != 0)
        {
            vec2 _2218 = _2618 - _2615;
            vec2 _2225 = _2615 + (_3266.xy * _2218);
            vec2 _2232 = _2615 + (_3266.zw * _2218);
            vec2 _3277;
            vec2 _3279;
            if ((_914 & 64) != 0)
            {
                vec2 _2244 = _2225 - _2615;
                float _2248 = _1588.x;
                float _2249 = _3259.x - _2248;
                vec2 _3175 = _3384;
                _3175.x = _2249;
                float _2254 = _1588.y;
                vec2 _3179 = _3175;
                _3179.y = _3259.y - _2254;
                bool _2260 = _2244.x < 0.001000000047497451305389404296875;
                bool _2268;
                if (!_2260)
                {
                    _2268 = _2249 < 0.001000000047497451305389404296875;
                }
                else
                {
                    _2268 = _2260;
                }
                vec2 _3271;
                vec2 _3272;
                if (_2268)
                {
                    vec2 _3185 = _2244;
                    _3185.x = _2636.z - _2232.x;
                    vec2 _3191 = _3179;
                    _3191.x = ((_2248 + _1588.z) - _3259.x) - _3257.x;
                    _3272 = _3191;
                    _3271 = _3185;
                }
                else
                {
                    _3272 = _3179;
                    _3271 = _2244;
                }
                bool _2292 = _3271.y < 0.001000000047497451305389404296875;
                bool _2300;
                if (!_2292)
                {
                    _2300 = _3272.y < 0.001000000047497451305389404296875;
                }
                else
                {
                    _2300 = _2292;
                }
                vec2 _3278;
                vec2 _3280;
                if (_2300)
                {
                    vec2 _3197 = _3271;
                    _3197.y = _2636.w - _2232.y;
                    vec2 _3203 = _3272;
                    _3203.y = ((_2254 + _1588.w) - _3259.y) - _3257.y;
                    _3280 = _3197;
                    _3278 = _3203;
                }
                else
                {
                    _3280 = _3271;
                    _3278 = _3272;
                }
                _3279 = _3280;
                _3277 = _3278;
            }
            else
            {
                _3279 = _2232 - _2225;
                _3277 = _3257;
            }
            vec2 _3282;
            if ((_914 & 4) != 0)
            {
                vec2 _3208 = _3277;
                _3208.x = (_3277.y / _3279.y) * _3279.x;
                _3282 = _3208;
            }
            else
            {
                _3282 = _3277;
            }
            vec2 _3284;
            if ((_914 & 8) != 0)
            {
                vec2 _3213 = _3282;
                _3213.y = (_3277.x / _3279.x) * _3279.y;
                _3284 = _3213;
            }
            else
            {
                _3284 = _3282;
            }
            _3305 = _2232;
            _3291 = _2225;
            _3283 = _3284;
        }
        else
        {
            vec2 _3267;
            if ((_914 & 4) != 0)
            {
                vec2 _3217 = _3257;
                _3217.x = _3266.z - _3266.x;
                _3267 = _3217;
            }
            else
            {
                _3267 = _3257;
            }
            vec2 _3285;
            if ((_914 & 8) != 0)
            {
                vec2 _3221 = _3267;
                _3221.y = _3266.w - _3266.y;
                _3285 = _3221;
            }
            else
            {
                _3285 = _3267;
            }
            _3305 = _2618;
            _3291 = _2615;
            _3283 = _3285;
        }
        vec2 _3286;
        if ((_914 & 16) != 0)
        {
            vec2 _3226 = _3283;
            _3226.x = _3257.x / max(1.0, round(_3257.x / _3283.x));
            _3286 = _3226;
        }
        else
        {
            _3286 = _3283;
        }
        vec2 _3347;
        if ((_914 & 32) != 0)
        {
            vec2 _3231 = _3286;
            _3231.y = _3257.y / max(1.0, round(_3257.y / _3286.y));
            _3347 = _3231;
        }
        else
        {
            _3347 = _3286;
        }
        _3345 = _3347;
        _3301 = _3305;
        _3287 = _3291;
    }
    else
    {
        _3345 = vec2(_3386.x ? _1597.x : _2573.x, _3386.y ? _1597.y : _2573.y);
        _3301 = _2618;
        _3287 = _2615;
    }
    bvec2 _3388 = bvec2(_2202);
    vec2 _3389 = vec2(_3388.x ? _3257.x : _1597.x, _3388.y ? _3257.y : _1597.y);
    float _2409 = float((_914 & 1) != 0);
    flat_varying_vec4_4.x = texelFetch(sGpuCache, _2652 + ivec2(1, 0), 0).x;
    flat_varying_vec4_4.y = _2409;
    vec2 _2417 = min(_3287, _3301);
    vec2 _2420 = max(_3287, _3301);
    vec4 _2431 = _2183.xyxy;
    flat_varying_vec4_3 = vec4(_2417 + vec2(0.5), _2420 - vec2(0.5)) / _2431;
    vec2 _2440 = (_3261 - vec2(_3388.x ? _3259.x : _1595.x, _3388.y ? _3259.y : _1595.y)) / _3389;
    int _2442 = _1625.x;
    int _2443 = _2442 & 65535;
    int _3375;
    if (_2443 == 0)
    {
        _3375 = uMode;
    }
    else
    {
        _3375 = _2443;
    }
    vec2 _3352;
    switch (_1625.y)
    {
        case 1:
        {
            uint _2732 = uint(_1559 + 2);
            ivec2 _2739 = ivec2(int(_2732 % 1024u), int(_2732 / 1024u));
            vec4 _2667 = vec4(_2440.x);
            vec4 _2682 = mix(mix(texelFetch(sGpuCache, _2739, 0), texelFetch(sGpuCache, _2739 + ivec2(1, 0), 0), _2667), mix(texelFetch(sGpuCache, _2739 + ivec2(2, 0), 0), texelFetch(sGpuCache, _2739 + ivec2(3, 0), 0), _2667), vec4(_2440.y));
            _3352 = _2682.xy / vec2(_2682.w);
            break;
        }
        default:
        {
            _3352 = _2440;
            break;
        }
    }
    vec2 _2464 = _3389 / _3345;
    vec2 _2470 = mix(_3287, _3301, _3352) - _2417;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2470.x, _2470.y);
    vec2 _2476 = varying_vec4_0.zw / _2183;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2476.x, _2476.y);
    vec2 _2482 = varying_vec4_0.zw * _2464;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2482.x, _2482.y);
    if (_2409 == 0.0)
    {
        vec2 _2493 = varying_vec4_0.zw * _3260.w;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2493.x, _2493.y);
    }
    flat_varying_vec4_2 = vec4(_2417, _2420) / _2431;
    flat_varying_vec4_1 = vec4(flat_varying_vec4_1.x, flat_varying_vec4_1.y, _2464.x, _2464.y);
    float _2512 = float(_1625.z) * 1.525902189314365386962890625e-05;
    vec4 _3376;
    switch (_2442 >> 16)
    {
        case 0:
        {
            vec4 _3243 = _2585;
            _3243.w = _2585.w * _2512;
            _3376 = _3243;
            break;
        }
        default:
        {
            _3376 = _2585 * _2512;
            break;
        }
    }
    switch (_3375)
    {
        case 1:
        case 7:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0, 1.0).x, vec2(0.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _3376;
            break;
        }
        case 5:
        case 6:
        case 9:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _3376;
            break;
        }
        case 2:
        case 3:
        case 8:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_3376.w);
            break;
        }
        case 4:
        {
            flat_varying_vec4_1 = vec4(vec2(-1.0, 1.0).x, vec2(-1.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_3376.w) * texelFetch(sGpuCache, _2606 + ivec2(1, 0), 0);
            break;
        }
        default:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0).x, vec2(0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(1.0);
            break;
        }
    }
    varying_vec4_0 = vec4(_3261.x, _3261.y, varying_vec4_0.z, varying_vec4_0.w);
}

