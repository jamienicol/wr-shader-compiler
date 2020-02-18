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

mat4 _3246;
vec2 _3377;

void main()
{
    int _1543 = aData.y & 65535;
    int _1547 = aData.z & 65535;
    int _1551 = aData.z >> 16;
    int _1555 = aData.w & 16777215;
    int _914 = (_1551 >> 8) & 255;
    uint _1571 = uint(aData.x);
    ivec2 _1579 = ivec2(int(2u * (_1571 % 512u)), int(_1571 / 512u));
    vec4 _1584 = texelFetch(sPrimitiveHeadersF, _1579, 0);
    ivec2 _1587 = _1579 + ivec2(1, 0);
    vec4 _1589 = texelFetch(sPrimitiveHeadersF, _1587, 0);
    vec2 _1591 = _1584.xy;
    vec2 _1593 = _1584.zw;
    vec2 _1597 = _1589.xy;
    vec2 _1599 = _1589.zw;
    ivec4 _1616 = texelFetch(sPrimitiveHeadersI, _1579, 0);
    ivec4 _1621 = texelFetch(sPrimitiveHeadersI, _1587, 0);
    float _1624 = float(_1616.x);
    int _1627 = _1616.y;
    int _1630 = _1616.z;
    vec2 _3250;
    vec2 _3252;
    vec4 _3259;
    if (_1547 == 65535)
    {
        _3259 = vec4(0.0);
        _3252 = _1591;
        _3250 = _1593;
    }
    else
    {
        uint _1653 = uint((_1627 + 3) + (_1547 * 2));
        ivec2 _1660 = ivec2(int(_1653 % 1024u), int(_1653 / 1024u));
        vec4 _1644 = texelFetch(sGpuCache, _1660, 0);
        _3259 = texelFetch(sGpuCache, _1660 + ivec2(1, 0), 0);
        _3252 = _1644.xy + _1591;
        _3250 = _1644.zw;
    }
    uint _1684 = uint(aData.y >> 16);
    ivec2 _1692 = ivec2(int(2u * (_1684 % 512u)), int(_1684 / 512u));
    vec4 _1702 = texelFetch(sRenderTasks, _1692 + ivec2(1, 0), 0);
    vec2 _1704 = texelFetch(sRenderTasks, _1692, 0).xy;
    float _1670 = _1702.y;
    vec2 _1673 = _1702.zw;
    vec2 _3239;
    float _3240;
    float _3241;
    vec2 _3242;
    vec2 _3243;
    if (_1543 >= 32767)
    {
        _3243 = vec2(0.0);
        _3242 = vec2(0.0);
        _3241 = 0.0;
        _3240 = 0.0;
        _3239 = vec2(0.0);
    }
    else
    {
        uint _1753 = uint(_1543);
        ivec2 _1761 = ivec2(int(2u * (_1753 % 512u)), int(_1753 / 512u));
        vec4 _1766 = texelFetch(sRenderTasks, _1761, 0);
        vec4 _1771 = texelFetch(sRenderTasks, _1761 + ivec2(1, 0), 0);
        _3243 = _1766.xy;
        _3242 = _1766.zw;
        _3241 = _1771.x;
        _3240 = _1771.y;
        _3239 = _1771.zw;
    }
    uint _1798 = uint(_1630 & 16777215);
    ivec2 _1812 = ivec2(int(8u * (_1798 % 128u)), int(_1798 / 128u));
    mat4 _3140 = _3246;
    _3140[0] = texelFetch(sTransformPalette, _1812, 0);
    mat4 _3142 = _3140;
    _3142[1] = texelFetch(sTransformPalette, _1812 + ivec2(1, 0), 0);
    mat4 _3144 = _3142;
    _3144[2] = texelFetch(sTransformPalette, _1812 + ivec2(2, 0), 0);
    mat4 _3146 = _3144;
    _3146[3] = texelFetch(sTransformPalette, _1812 + ivec2(3, 0), 0);
    vec4 _3253;
    vec2 _3254;
    if ((_1630 >> 24) == 0)
    {
        vec2 _1931 = clamp(_3252 + (_3250 * aPosition.xy), _1597, _1597 + _1599);
        vec4 _1888 = _3146 * vec4(_1931, 0.0, 1.0);
        float _1904 = _1888.w;
        gl_Position = uTransform * vec4((_1888.xy * _1670) + (((-_1673) + _1704) * _1904), _1624 * _1904, _1904);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _3254 = _1931;
        _3253 = _1888;
    }
    else
    {
        bvec4 _1005 = notEqual((ivec4(_1551 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _1008 = vec4(_1005.x ? vec4(1.0).x : vec4(0.0).x, _1005.y ? vec4(1.0).y : vec4(0.0).y, _1005.z ? vec4(1.0).z : vec4(0.0).z, _1005.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _2082 = _1597 + _1599;
        vec4 _1989 = vec4(2.0) * _1008;
        vec2 _1991 = _1989.xy;
        vec2 _2012 = (_3252 - _1991) + ((_3250 + (_1991 + _1989.zw)) * aPosition.xy);
        vec4 _2024 = _3146 * vec4(_2012, 0.0, 1.0);
        float _2032 = _2024.w;
        gl_Position = uTransform * vec4((_2024.xy * _1670) + ((_1704 - _1673) * _2032), _1624 * _2032, _2032);
        vTransformBounds = mix(vec4(clamp(_1591, _1597, _2082), clamp(_1591 + _1593, _1597, _2082)), vec4(clamp(_3252, _1597, _2082), clamp(_3252 + _3250, _1597, _2082)), _1008);
        _3254 = _2012;
        _3253 = _2024;
    }
    vClipMaskUvBounds = vec4(_3243, _3243 + _3242);
    vClipMaskUv = vec4((_3253.xy * _3240) + ((_3243 - _3239) * _3253.w), _3241, _3253.w);
    uint _2592 = uint(_1627);
    ivec2 _2599 = ivec2(int(_2592 % 1024u), int(_2592 / 1024u));
    vec4 _2578 = texelFetch(sGpuCache, _2599, 0);
    vec4 _2588 = texelFetch(sGpuCache, _2599 + ivec2(2, 0), 0);
    vec2 _2566 = _2588.xy;
    vec2 _2176 = vec2(textureSize(sColor0, 0));
    uint _2638 = uint(_1555);
    ivec2 _2645 = ivec2(int(_2638 % 1024u), int(_2638 / 1024u));
    vec4 _2629 = texelFetch(sGpuCache, _2645, 0);
    vec2 _2608 = _2629.xy;
    vec2 _2611 = _2629.zw;
    bvec2 _3379 = bvec2(_2588.x < 0.0);
    bool _2195 = (_914 & 2) != 0;
    vec2 _3280;
    vec2 _3294;
    vec2 _3338;
    if (_2195)
    {
        vec2 _3276;
        vec2 _3284;
        vec2 _3298;
        if ((_914 & 128) != 0)
        {
            vec2 _2211 = _2611 - _2608;
            vec2 _2218 = _2608 + (_3259.xy * _2211);
            vec2 _2225 = _2608 + (_3259.zw * _2211);
            vec2 _3270;
            vec2 _3272;
            if ((_914 & 64) != 0)
            {
                vec2 _2237 = _2218 - _2608;
                float _2241 = _1584.x;
                float _2242 = _3252.x - _2241;
                vec2 _3168 = _3377;
                _3168.x = _2242;
                float _2247 = _1584.y;
                vec2 _3172 = _3168;
                _3172.y = _3252.y - _2247;
                bool _2253 = _2237.x < 0.001000000047497451305389404296875;
                bool _2261;
                if (!_2253)
                {
                    _2261 = _2242 < 0.001000000047497451305389404296875;
                }
                else
                {
                    _2261 = _2253;
                }
                vec2 _3264;
                vec2 _3265;
                if (_2261)
                {
                    vec2 _3178 = _2237;
                    _3178.x = _2629.z - _2225.x;
                    vec2 _3184 = _3172;
                    _3184.x = ((_2241 + _1584.z) - _3252.x) - _3250.x;
                    _3265 = _3184;
                    _3264 = _3178;
                }
                else
                {
                    _3265 = _3172;
                    _3264 = _2237;
                }
                bool _2285 = _3264.y < 0.001000000047497451305389404296875;
                bool _2293;
                if (!_2285)
                {
                    _2293 = _3265.y < 0.001000000047497451305389404296875;
                }
                else
                {
                    _2293 = _2285;
                }
                vec2 _3271;
                vec2 _3273;
                if (_2293)
                {
                    vec2 _3190 = _3264;
                    _3190.y = _2629.w - _2225.y;
                    vec2 _3196 = _3265;
                    _3196.y = ((_2247 + _1584.w) - _3252.y) - _3250.y;
                    _3273 = _3190;
                    _3271 = _3196;
                }
                else
                {
                    _3273 = _3264;
                    _3271 = _3265;
                }
                _3272 = _3273;
                _3270 = _3271;
            }
            else
            {
                _3272 = _2225 - _2218;
                _3270 = _3250;
            }
            vec2 _3275;
            if ((_914 & 4) != 0)
            {
                vec2 _3201 = _3270;
                _3201.x = (_3270.y / _3272.y) * _3272.x;
                _3275 = _3201;
            }
            else
            {
                _3275 = _3270;
            }
            vec2 _3277;
            if ((_914 & 8) != 0)
            {
                vec2 _3206 = _3275;
                _3206.y = (_3270.x / _3272.x) * _3272.y;
                _3277 = _3206;
            }
            else
            {
                _3277 = _3275;
            }
            _3298 = _2225;
            _3284 = _2218;
            _3276 = _3277;
        }
        else
        {
            vec2 _3260;
            if ((_914 & 4) != 0)
            {
                vec2 _3210 = _3250;
                _3210.x = _3259.z - _3259.x;
                _3260 = _3210;
            }
            else
            {
                _3260 = _3250;
            }
            vec2 _3278;
            if ((_914 & 8) != 0)
            {
                vec2 _3214 = _3260;
                _3214.y = _3259.w - _3259.y;
                _3278 = _3214;
            }
            else
            {
                _3278 = _3260;
            }
            _3298 = _2611;
            _3284 = _2608;
            _3276 = _3278;
        }
        vec2 _3279;
        if ((_914 & 16) != 0)
        {
            vec2 _3219 = _3276;
            _3219.x = _3250.x / max(1.0, round(_3250.x / _3276.x));
            _3279 = _3219;
        }
        else
        {
            _3279 = _3276;
        }
        vec2 _3340;
        if ((_914 & 32) != 0)
        {
            vec2 _3224 = _3279;
            _3224.y = _3250.y / max(1.0, round(_3250.y / _3279.y));
            _3340 = _3224;
        }
        else
        {
            _3340 = _3279;
        }
        _3338 = _3340;
        _3294 = _3298;
        _3280 = _3284;
    }
    else
    {
        _3338 = vec2(_3379.x ? _1593.x : _2566.x, _3379.y ? _1593.y : _2566.y);
        _3294 = _2611;
        _3280 = _2608;
    }
    bvec2 _3381 = bvec2(_2195);
    vec2 _3382 = vec2(_3381.x ? _3250.x : _1593.x, _3381.y ? _3250.y : _1593.y);
    float _2402 = float((_914 & 1) != 0);
    flat_varying_vec4_4.x = texelFetch(sGpuCache, _2645 + ivec2(1, 0), 0).x;
    flat_varying_vec4_4.y = _2402;
    vec2 _2410 = min(_3280, _3294);
    vec2 _2413 = max(_3280, _3294);
    vec4 _2424 = _2176.xyxy;
    flat_varying_vec4_3 = vec4(_2410 + vec2(0.5), _2413 - vec2(0.5)) / _2424;
    vec2 _2433 = (_3254 - vec2(_3381.x ? _3252.x : _1591.x, _3381.y ? _3252.y : _1591.y)) / _3382;
    int _2435 = _1621.x;
    int _2436 = _2435 & 65535;
    int _3368;
    if (_2436 == 0)
    {
        _3368 = uMode;
    }
    else
    {
        _3368 = _2436;
    }
    vec2 _3345;
    switch (_1621.y)
    {
        case 1:
        {
            uint _2725 = uint(_1555 + 2);
            ivec2 _2732 = ivec2(int(_2725 % 1024u), int(_2725 / 1024u));
            vec4 _2660 = vec4(_2433.x);
            vec4 _2675 = mix(mix(texelFetch(sGpuCache, _2732, 0), texelFetch(sGpuCache, _2732 + ivec2(1, 0), 0), _2660), mix(texelFetch(sGpuCache, _2732 + ivec2(2, 0), 0), texelFetch(sGpuCache, _2732 + ivec2(3, 0), 0), _2660), vec4(_2433.y));
            _3345 = _2675.xy / vec2(_2675.w);
            break;
        }
        default:
        {
            _3345 = _2433;
            break;
        }
    }
    vec2 _2457 = _3382 / _3338;
    vec2 _2463 = mix(_3280, _3294, _3345) - _2410;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2463.x, _2463.y);
    vec2 _2469 = varying_vec4_0.zw / _2176;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2469.x, _2469.y);
    vec2 _2475 = varying_vec4_0.zw * _2457;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2475.x, _2475.y);
    if (_2402 == 0.0)
    {
        vec2 _2486 = varying_vec4_0.zw * _3253.w;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2486.x, _2486.y);
    }
    flat_varying_vec4_2 = vec4(_2410, _2413) / _2424;
    flat_varying_vec4_1 = vec4(flat_varying_vec4_1.x, flat_varying_vec4_1.y, _2457.x, _2457.y);
    float _2505 = float(_1621.z) * 1.525902189314365386962890625e-05;
    vec4 _3369;
    switch (_2435 >> 16)
    {
        case 0:
        {
            vec4 _3236 = _2578;
            _3236.w = _2578.w * _2505;
            _3369 = _3236;
            break;
        }
        default:
        {
            _3369 = _2578 * _2505;
            break;
        }
    }
    switch (_3368)
    {
        case 1:
        case 7:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0, 1.0).x, vec2(0.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _3369;
            break;
        }
        case 5:
        case 6:
        case 9:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _3369;
            break;
        }
        case 2:
        case 3:
        case 8:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_3369.w);
            break;
        }
        case 4:
        {
            flat_varying_vec4_1 = vec4(vec2(-1.0, 1.0).x, vec2(-1.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_3369.w) * texelFetch(sGpuCache, _2599 + ivec2(1, 0), 0);
            break;
        }
        default:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0).x, vec2(0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(1.0);
            break;
        }
    }
    varying_vec4_0 = vec4(_3254.x, _3254.y, varying_vec4_0.z, varying_vec4_0.w);
}

