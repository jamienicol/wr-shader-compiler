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

mat4 _2680;
vec2 _2768;

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
    vec2 _2682;
    vec2 _2683;
    vec4 _2689;
    if (_1301 == 65535)
    {
        _2689 = vec4(0.0);
        _2683 = _1345;
        _2682 = _1347;
    }
    else
    {
        uint _1407 = uint((_1381 + 3) + (_1301 * 2));
        ivec2 _1414 = ivec2(int(_1407 % 1024u), int(_1407 / 1024u));
        vec4 _1398 = texelFetch(sGpuCache, _1414, 0);
        _2689 = texelFetch(sGpuCache, _1414 + ivec2(1, 0), 0);
        _2683 = _1398.xy + _1345;
        _2682 = _1398.zw;
    }
    uint _1438 = uint(aData.y >> 16);
    ivec2 _1446 = ivec2(int(2u * (_1438 % 512u)), int(_1438 / 512u));
    vec4 _1456 = texelFetch(sRenderTasks, _1446 + ivec2(1, 0), 0);
    vec2 _1458 = texelFetch(sRenderTasks, _1446, 0).xy;
    float _1424 = _1456.y;
    vec2 _1427 = _1456.zw;
    uint _1552 = uint(_1384 & 16777215);
    ivec2 _1566 = ivec2(int(8u * (_1552 % 128u)), int(_1552 / 128u));
    mat4 _2595 = _2680;
    _2595[0] = texelFetch(sTransformPalette, _1566, 0);
    mat4 _2597 = _2595;
    _2597[1] = texelFetch(sTransformPalette, _1566 + ivec2(1, 0), 0);
    mat4 _2599 = _2597;
    _2599[2] = texelFetch(sTransformPalette, _1566 + ivec2(2, 0), 0);
    mat4 _2601 = _2599;
    _2601[3] = texelFetch(sTransformPalette, _1566 + ivec2(3, 0), 0);
    vec4 _2684;
    vec2 _2685;
    if ((_1384 >> 24) == 0)
    {
        vec2 _1685 = clamp(_2683 + (_2682 * aPosition.xy), _1351, _1351 + _1353);
        vec4 _1642 = _2601 * vec4(_1685, 0.0, 1.0);
        float _1658 = _1642.w;
        gl_Position = uTransform * vec4((_1642.xy * _1424) + (((-_1427) + _1458) * _1658), _1378 * _1658, _1658);
        _2685 = _1685;
        _2684 = _1642;
    }
    else
    {
        bvec4 _860 = notEqual((ivec4(_1305 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _863 = vec4(_860.x ? vec4(1.0).x : vec4(0.0).x, _860.y ? vec4(1.0).y : vec4(0.0).y, _860.z ? vec4(1.0).z : vec4(0.0).z, _860.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1835 = _1351 + _1353;
        vec4 _1742 = vec4(2.0) * _863;
        vec2 _1744 = _1742.xy;
        vec2 _1765 = (_2683 - _1744) + ((_2682 + (_1744 + _1742.zw)) * aPosition.xy);
        vec4 _1777 = _2601 * vec4(_1765, 0.0, 1.0);
        float _1785 = _1777.w;
        gl_Position = uTransform * vec4((_1777.xy * _1424) + ((_1458 - _1427) * _1785), _1378 * _1785, _1785);
        vTransformBounds = mix(vec4(clamp(_1345, _1351, _1835), clamp(_1345 + _1347, _1351, _1835)), vec4(clamp(_2683, _1351, _1835), clamp(_2683 + _2682, _1351, _1835)), _863);
        _2685 = _1765;
        _2684 = _1777;
    }
    uint _2229 = uint(_1381);
    vec4 _2225 = texelFetch(sGpuCache, ivec2(int(_2229 % 1024u), int(_2229 / 1024u)) + ivec2(2, 0), 0);
    vec2 _2203 = _2225.xy;
    vec2 _1888 = vec2(textureSize(sColor0, 0));
    uint _2275 = uint(aData.w & 16777215);
    ivec2 _2282 = ivec2(int(_2275 % 1024u), int(_2275 / 1024u));
    vec4 _2266 = texelFetch(sGpuCache, _2282, 0);
    vec2 _2245 = _2266.xy;
    vec2 _2248 = _2266.zw;
    bvec2 _2770 = bvec2(_2225.x < 0.0);
    bool _1907 = (_774 & 2) != 0;
    vec2 _2710;
    vec2 _2724;
    vec2 _2763;
    if (_1907)
    {
        vec2 _2706;
        vec2 _2714;
        vec2 _2728;
        if ((_774 & 128) != 0)
        {
            vec2 _1923 = _2248 - _2245;
            vec2 _1930 = _2245 + (_2689.xy * _1923);
            vec2 _1937 = _2245 + (_2689.zw * _1923);
            vec2 _2700;
            vec2 _2702;
            if ((_774 & 64) != 0)
            {
                vec2 _1949 = _1930 - _2245;
                float _1953 = _1338.x;
                float _1954 = _2683.x - _1953;
                vec2 _2621 = _2768;
                _2621.x = _1954;
                float _1959 = _1338.y;
                vec2 _2625 = _2621;
                _2625.y = _2683.y - _1959;
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
                vec2 _2694;
                vec2 _2695;
                if (_1973)
                {
                    vec2 _2631 = _1949;
                    _2631.x = _2266.z - _1937.x;
                    vec2 _2637 = _2625;
                    _2637.x = ((_1953 + _1338.z) - _2683.x) - _2682.x;
                    _2695 = _2637;
                    _2694 = _2631;
                }
                else
                {
                    _2695 = _2625;
                    _2694 = _1949;
                }
                bool _1997 = _2694.y < 0.001000000047497451305389404296875;
                bool _2005;
                if (!_1997)
                {
                    _2005 = _2695.y < 0.001000000047497451305389404296875;
                }
                else
                {
                    _2005 = _1997;
                }
                vec2 _2701;
                vec2 _2703;
                if (_2005)
                {
                    vec2 _2643 = _2694;
                    _2643.y = _2266.w - _1937.y;
                    vec2 _2649 = _2695;
                    _2649.y = ((_1959 + _1338.w) - _2683.y) - _2682.y;
                    _2703 = _2643;
                    _2701 = _2649;
                }
                else
                {
                    _2703 = _2694;
                    _2701 = _2695;
                }
                _2702 = _2703;
                _2700 = _2701;
            }
            else
            {
                _2702 = _1937 - _1930;
                _2700 = _2682;
            }
            vec2 _2705;
            if ((_774 & 4) != 0)
            {
                vec2 _2654 = _2700;
                _2654.x = (_2700.y / _2702.y) * _2702.x;
                _2705 = _2654;
            }
            else
            {
                _2705 = _2700;
            }
            vec2 _2707;
            if ((_774 & 8) != 0)
            {
                vec2 _2659 = _2705;
                _2659.y = (_2700.x / _2702.x) * _2702.y;
                _2707 = _2659;
            }
            else
            {
                _2707 = _2705;
            }
            _2728 = _1937;
            _2714 = _1930;
            _2706 = _2707;
        }
        else
        {
            vec2 _2690;
            if ((_774 & 4) != 0)
            {
                vec2 _2663 = _2682;
                _2663.x = _2689.z - _2689.x;
                _2690 = _2663;
            }
            else
            {
                _2690 = _2682;
            }
            vec2 _2708;
            if ((_774 & 8) != 0)
            {
                vec2 _2667 = _2690;
                _2667.y = _2689.w - _2689.y;
                _2708 = _2667;
            }
            else
            {
                _2708 = _2690;
            }
            _2728 = _2248;
            _2714 = _2245;
            _2706 = _2708;
        }
        vec2 _2709;
        if ((_774 & 16) != 0)
        {
            vec2 _2672 = _2706;
            _2672.x = _2682.x / max(1.0, round(_2682.x / _2706.x));
            _2709 = _2672;
        }
        else
        {
            _2709 = _2706;
        }
        vec2 _2765;
        if ((_774 & 32) != 0)
        {
            vec2 _2677 = _2709;
            _2677.y = _2682.y / max(1.0, round(_2682.y / _2709.y));
            _2765 = _2677;
        }
        else
        {
            _2765 = _2709;
        }
        _2763 = _2765;
        _2724 = _2728;
        _2710 = _2714;
    }
    else
    {
        _2763 = vec2(_2770.x ? _1347.x : _2203.x, _2770.y ? _1347.y : _2203.y);
        _2724 = _2248;
        _2710 = _2245;
    }
    bvec2 _2772 = bvec2(_1907);
    vec2 _2773 = vec2(_2772.x ? _2682.x : _1347.x, _2772.y ? _2682.y : _1347.y);
    float _2114 = float((_774 & 1) != 0);
    flat_varying_vec4_4.x = texelFetch(sGpuCache, _2282 + ivec2(1, 0), 0).x;
    flat_varying_vec4_4.y = _2114;
    vec2 _2122 = min(_2710, _2724);
    vec2 _2125 = max(_2710, _2724);
    vec4 _2136 = _1888.xyxy;
    flat_varying_vec4_3 = vec4(_2122 + vec2(0.5), _2125 - vec2(0.5)) / _2136;
    vec2 _2155 = mix(_2710, _2724, (_2685 - vec2(_2772.x ? _2683.x : _1345.x, _2772.y ? _2683.y : _1345.y)) / _2773) - _2122;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2155.x, _2155.y);
    vec2 _2161 = varying_vec4_0.zw / _1888;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2161.x, _2161.y);
    vec2 _2167 = varying_vec4_0.zw * (_2773 / _2763);
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2167.x, _2167.y);
    if (_2114 == 0.0)
    {
        vec2 _2178 = varying_vec4_0.zw * _2684.w;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2178.x, _2178.y);
    }
    flat_varying_vec4_2 = vec4(_2122, _2125) / _2136;
}

