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

mat4 _3998;

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
    vec2 _3666;
    vec2 _3668;
    vec4 _3715;
    if (_1547 == 65535)
    {
        _3715 = vec4(0.0);
        _3668 = _1591;
        _3666 = _1593;
    }
    else
    {
        uint _1653 = uint((_1627 + 3) + (_1547 * 2));
        ivec2 _1660 = ivec2(int(_1653 % 1024u), int(_1653 / 1024u));
        vec4 _1644 = texelFetch(sGpuCache, _1660, 0);
        _3715 = texelFetch(sGpuCache, _1660 + ivec2(1, 0), 0);
        _3668 = _1644.xy + _1591;
        _3666 = _1644.zw;
    }
    uint _1684 = uint(aData.y >> 16);
    ivec2 _1692 = ivec2(int(2u * (_1684 % 512u)), int(_1684 / 512u));
    vec4 _1702 = texelFetch(sRenderTasks, _1692 + ivec2(1, 0), 0);
    vec2 _1704 = texelFetch(sRenderTasks, _1692, 0).xy;
    float _1670 = _1702.y;
    vec2 _1673 = _1702.zw;
    vec2 _3656;
    float _3657;
    float _3658;
    vec2 _3659;
    vec2 _3660;
    if (_1543 >= 32767)
    {
        _3660 = vec2(0.0);
        _3659 = vec2(0.0);
        _3658 = 0.0;
        _3657 = 0.0;
        _3656 = vec2(0.0);
    }
    else
    {
        uint _1753 = uint(_1543);
        ivec2 _1761 = ivec2(int(2u * (_1753 % 512u)), int(_1753 / 512u));
        vec4 _1766 = texelFetch(sRenderTasks, _1761, 0);
        vec4 _1771 = texelFetch(sRenderTasks, _1761 + ivec2(1, 0), 0);
        _3660 = _1766.xy;
        _3659 = _1766.zw;
        _3658 = _1771.x;
        _3657 = _1771.y;
        _3656 = _1771.zw;
    }
    uint _1798 = uint(_1630 & 16777215);
    ivec2 _1812 = ivec2(int(8u * (_1798 % 128u)), int(_1798 / 128u));
    mat4 _3905 = _3998;
    _3905[0] = texelFetch(sTransformPalette, _1812, 0);
    mat4 _3907 = _3905;
    _3907[1] = texelFetch(sTransformPalette, _1812 + ivec2(1, 0), 0);
    mat4 _3909 = _3907;
    _3909[2] = texelFetch(sTransformPalette, _1812 + ivec2(2, 0), 0);
    mat4 _3911 = _3909;
    _3911[3] = texelFetch(sTransformPalette, _1812 + ivec2(3, 0), 0);
    vec4 _3684;
    vec2 _3690;
    if ((_1630 >> 24) == 0)
    {
        vec2 _1931 = clamp(_3668 + (_3666 * aPosition.xy), _1597, _1597 + _1599);
        vec4 _1888 = _3911 * vec4(_1931, 0.0, 1.0);
        float _1904 = _1888.w;
        gl_Position = uTransform * vec4((_1888.xy * _1670) + (((-_1673) + _1704) * _1904), _1624 * _1904, _1904);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _3690 = _1931;
        _3684 = _1888;
    }
    else
    {
        bvec4 _1005 = notEqual((ivec4(_1551 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _1008 = vec4(_1005.x ? vec4(1.0).x : vec4(0.0).x, _1005.y ? vec4(1.0).y : vec4(0.0).y, _1005.z ? vec4(1.0).z : vec4(0.0).z, _1005.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _2082 = _1597 + _1599;
        vec4 _1989 = vec4(2.0) * _1008;
        vec2 _1991 = _1989.xy;
        vec2 _2012 = (_3668 - _1991) + ((_3666 + (_1991 + _1989.zw)) * aPosition.xy);
        vec4 _2024 = _3911 * vec4(_2012, 0.0, 1.0);
        float _2032 = _2024.w;
        gl_Position = uTransform * vec4((_2024.xy * _1670) + ((_1704 - _1673) * _2032), _1624 * _2032, _2032);
        vTransformBounds = mix(vec4(clamp(_1591, _1597, _2082), clamp(_1591 + _1593, _1597, _2082)), vec4(clamp(_3668, _1597, _2082), clamp(_3668 + _3666, _1597, _2082)), _1008);
        _3690 = _2012;
        _3684 = _2024;
    }
    vClipMaskUvBounds = vec4(_3660, _3660 + _3659);
    vClipMaskUv = vec4((_3684.xy * _3657) + ((_3660 - _3656) * _3684.w), _3658, _3684.w);
    uint _2592 = uint(_1627);
    ivec2 _2599 = ivec2(int(_2592 % 1024u), int(_2592 / 1024u));
    vec4 _2578 = texelFetch(sGpuCache, _2599, 0);
    vec4 _2588 = texelFetch(sGpuCache, _2599 + ivec2(2, 0), 0);
    vec2 _2176 = vec2(textureSize(sColor0, 0));
    uint _2638 = uint(_1555);
    ivec2 _2645 = ivec2(int(_2638 % 1024u), int(_2638 / 1024u));
    vec4 _2629 = texelFetch(sGpuCache, _2645, 0);
    vec2 _2608 = _2629.xy;
    vec2 _2611 = _2629.zw;
    vec2 _4033;
    if (_2588.x < 0.0)
    {
        _4033 = _1593;
    }
    else
    {
        _4033 = _2588.xy;
    }
    bool _2195 = (_914 & 2) != 0;
    vec2 _3747;
    vec2 _4019;
    vec2 _4032;
    if (_2195)
    {
        vec2 _3751;
        vec2 _4015;
        vec2 _4023;
        if ((_914 & 128) != 0)
        {
            vec2 _2211 = _2611 - _2608;
            vec2 _2218 = _2608 + (_3715.xy * _2211);
            vec2 _2225 = _2608 + (_3715.zw * _2211);
            vec2 _4009;
            vec2 _4011;
            if ((_914 & 64) != 0)
            {
                vec2 _2237 = _2218 - _2608;
                float _2241 = _1584.x;
                float _2242 = _3668.x - _2241;
                vec2 _3925 = _3666;
                _3925.x = _2242;
                float _2247 = _1584.y;
                vec2 _3929 = _3925;
                _3929.y = _3668.y - _2247;
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
                vec2 _4003;
                vec2 _4004;
                if (_2261)
                {
                    vec2 _3935 = _2237;
                    _3935.x = _2629.z - _2225.x;
                    vec2 _3941 = _3929;
                    _3941.x = ((_2241 + _1584.z) - _3668.x) - _3666.x;
                    _4004 = _3941;
                    _4003 = _3935;
                }
                else
                {
                    _4004 = _3929;
                    _4003 = _2237;
                }
                bool _2285 = _4003.y < 0.001000000047497451305389404296875;
                bool _2293;
                if (!_2285)
                {
                    _2293 = _4004.y < 0.001000000047497451305389404296875;
                }
                else
                {
                    _2293 = _2285;
                }
                vec2 _4010;
                vec2 _4012;
                if (_2293)
                {
                    vec2 _3947 = _4003;
                    _3947.y = _2629.w - _2225.y;
                    vec2 _3953 = _4004;
                    _3953.y = ((_2247 + _1584.w) - _3668.y) - _3666.y;
                    _4012 = _3947;
                    _4010 = _3953;
                }
                else
                {
                    _4012 = _4003;
                    _4010 = _4004;
                }
                _4011 = _4012;
                _4009 = _4010;
            }
            else
            {
                _4011 = _2225 - _2218;
                _4009 = _3666;
            }
            vec2 _4014;
            if ((_914 & 4) != 0)
            {
                vec2 _3958 = _4009;
                _3958.x = (_4009.y / _4011.y) * _4011.x;
                _4014 = _3958;
            }
            else
            {
                _4014 = _4009;
            }
            vec2 _4016;
            if ((_914 & 8) != 0)
            {
                vec2 _3963 = _4014;
                _3963.y = (_4009.x / _4011.x) * _4011.y;
                _4016 = _3963;
            }
            else
            {
                _4016 = _4014;
            }
            _4023 = _2225;
            _4015 = _4016;
            _3751 = _2218;
        }
        else
        {
            vec2 _3999;
            if ((_914 & 4) != 0)
            {
                vec2 _3967 = _3666;
                _3967.x = _3715.z - _3715.x;
                _3999 = _3967;
            }
            else
            {
                _3999 = _3666;
            }
            vec2 _4017;
            if ((_914 & 8) != 0)
            {
                vec2 _3971 = _3999;
                _3971.y = _3715.w - _3715.y;
                _4017 = _3971;
            }
            else
            {
                _4017 = _3999;
            }
            _4023 = _2611;
            _4015 = _4017;
            _3751 = _2608;
        }
        vec2 _4018;
        if ((_914 & 16) != 0)
        {
            vec2 _3976 = _4015;
            _3976.x = _3666.x / max(1.0, round(_3666.x / _4015.x));
            _4018 = _3976;
        }
        else
        {
            _4018 = _4015;
        }
        vec2 _4034;
        if ((_914 & 32) != 0)
        {
            vec2 _3981 = _4018;
            _3981.y = _3666.y / max(1.0, round(_3666.y / _4018.y));
            _4034 = _3981;
        }
        else
        {
            _4034 = _4018;
        }
        _4032 = _4034;
        _4019 = _4023;
        _3747 = _3751;
    }
    else
    {
        _4032 = _4033;
        _4019 = _2611;
        _3747 = _2608;
    }
    bvec2 _3892 = bvec2(_2195);
    vec2 _3893 = vec2(_3892.x ? _3666.x : _1593.x, _3892.y ? _3666.y : _1593.y);
    float _2402 = float((_914 & 1) != 0);
    flat_varying_vec4_4.x = texelFetch(sGpuCache, _2645 + ivec2(1, 0), 0).x;
    flat_varying_vec4_4.y = _2402;
    vec2 _2410 = min(_3747, _4019);
    vec2 _2413 = max(_3747, _4019);
    vec4 _2424 = _2176.xyxy;
    flat_varying_vec4_3 = vec4(_2410 + vec2(0.5), _2413 - vec2(0.5)) / _2424;
    vec2 _2433 = (_3690 - vec2(_3892.x ? _3668.x : _1591.x, _3892.y ? _3668.y : _1591.y)) / _3893;
    int _2435 = _1621.x;
    int _2436 = _2435 & 65535;
    int _3859;
    if (_2436 == 0)
    {
        _3859 = uMode;
    }
    else
    {
        _3859 = _2436;
    }
    vec2 _3838;
    switch (_1621.y)
    {
        case 1:
        {
            uint _2725 = uint(_1555 + 2);
            ivec2 _2732 = ivec2(int(_2725 % 1024u), int(_2725 / 1024u));
            vec4 _2660 = vec4(_2433.x);
            vec4 _2675 = mix(mix(texelFetch(sGpuCache, _2732, 0), texelFetch(sGpuCache, _2732 + ivec2(1, 0), 0), _2660), mix(texelFetch(sGpuCache, _2732 + ivec2(2, 0), 0), texelFetch(sGpuCache, _2732 + ivec2(3, 0), 0), _2660), vec4(_2433.y));
            _3838 = _2675.xy / vec2(_2675.w);
            break;
        }
        default:
        {
            _3838 = _2433;
            break;
        }
    }
    vec2 _2457 = _3893 / _4032;
    vec2 _2463 = mix(_3747, _4019, _3838) - _2410;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2463.x, _2463.y);
    vec2 _2469 = varying_vec4_0.zw / _2176;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2469.x, _2469.y);
    vec2 _2475 = varying_vec4_0.zw * _2457;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2475.x, _2475.y);
    if (_2402 == 0.0)
    {
        vec2 _2486 = varying_vec4_0.zw * _3684.w;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2486.x, _2486.y);
    }
    flat_varying_vec4_2 = vec4(_2410, _2413) / _2424;
    flat_varying_vec4_1 = vec4(flat_varying_vec4_1.x, flat_varying_vec4_1.y, _2457.x, _2457.y);
    float _2505 = float(_1621.z) * 1.525902189314365386962890625e-05;
    vec4 _4055;
    switch (_2435 >> 16)
    {
        case 0:
        {
            vec4 _3993 = _2578;
            _3993.w = _2578.w * _2505;
            _4055 = _3993;
            break;
        }
        default:
        {
            _4055 = _2578 * _2505;
            break;
        }
    }
    switch (_3859)
    {
        case 1:
        case 7:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0, 1.0).x, vec2(0.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _4055;
            break;
        }
        case 5:
        case 6:
        case 9:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _4055;
            break;
        }
        case 2:
        case 3:
        case 8:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_4055.w);
            break;
        }
        case 4:
        {
            flat_varying_vec4_1 = vec4(vec2(-1.0, 1.0).x, vec2(-1.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_4055.w) * texelFetch(sGpuCache, _2599 + ivec2(1, 0), 0);
            break;
        }
        default:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0).x, vec2(0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(1.0);
            break;
        }
    }
    varying_vec4_0 = vec4(_3690.x, _3690.y, varying_vec4_0.z, varying_vec4_0.w);
}

