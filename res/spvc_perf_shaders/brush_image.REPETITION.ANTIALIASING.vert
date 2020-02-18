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

mat4 _2687;
vec2 _2775;

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
    vec2 _2689;
    vec2 _2690;
    vec4 _2696;
    if (_1305 == 65535)
    {
        _2696 = vec4(0.0);
        _2690 = _1349;
        _2689 = _1351;
    }
    else
    {
        uint _1411 = uint((_1385 + 3) + (_1305 * 2));
        ivec2 _1418 = ivec2(int(_1411 % 1024u), int(_1411 / 1024u));
        vec4 _1402 = texelFetch(sGpuCache, _1418, 0);
        _2696 = texelFetch(sGpuCache, _1418 + ivec2(1, 0), 0);
        _2690 = _1402.xy + _1349;
        _2689 = _1402.zw;
    }
    uint _1442 = uint(aData.y >> 16);
    ivec2 _1450 = ivec2(int(2u * (_1442 % 512u)), int(_1442 / 512u));
    vec4 _1460 = texelFetch(sRenderTasks, _1450 + ivec2(1, 0), 0);
    vec2 _1462 = texelFetch(sRenderTasks, _1450, 0).xy;
    float _1428 = _1460.y;
    vec2 _1431 = _1460.zw;
    uint _1556 = uint(_1388 & 16777215);
    ivec2 _1570 = ivec2(int(8u * (_1556 % 128u)), int(_1556 / 128u));
    mat4 _2602 = _2687;
    _2602[0] = texelFetch(sTransformPalette, _1570, 0);
    mat4 _2604 = _2602;
    _2604[1] = texelFetch(sTransformPalette, _1570 + ivec2(1, 0), 0);
    mat4 _2606 = _2604;
    _2606[2] = texelFetch(sTransformPalette, _1570 + ivec2(2, 0), 0);
    mat4 _2608 = _2606;
    _2608[3] = texelFetch(sTransformPalette, _1570 + ivec2(3, 0), 0);
    vec4 _2691;
    vec2 _2692;
    if ((_1388 >> 24) == 0)
    {
        vec2 _1689 = clamp(_2690 + (_2689 * aPosition.xy), _1355, _1355 + _1357);
        vec4 _1646 = _2608 * vec4(_1689, 0.0, 1.0);
        float _1662 = _1646.w;
        gl_Position = uTransform * vec4((_1646.xy * _1428) + (((-_1431) + _1462) * _1662), _1382 * _1662, _1662);
        _2692 = _1689;
        _2691 = _1646;
    }
    else
    {
        bvec4 _860 = notEqual((ivec4(_1309 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _863 = vec4(_860.x ? vec4(1.0).x : vec4(0.0).x, _860.y ? vec4(1.0).y : vec4(0.0).y, _860.z ? vec4(1.0).z : vec4(0.0).z, _860.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1839 = _1355 + _1357;
        vec4 _1746 = vec4(2.0) * _863;
        vec2 _1748 = _1746.xy;
        vec2 _1769 = (_2690 - _1748) + ((_2689 + (_1748 + _1746.zw)) * aPosition.xy);
        vec4 _1781 = _2608 * vec4(_1769, 0.0, 1.0);
        float _1789 = _1781.w;
        gl_Position = uTransform * vec4((_1781.xy * _1428) + ((_1462 - _1431) * _1789), _1382 * _1789, _1789);
        vTransformBounds = mix(vec4(clamp(_1349, _1355, _1839), clamp(_1349 + _1351, _1355, _1839)), vec4(clamp(_2690, _1355, _1839), clamp(_2690 + _2689, _1355, _1839)), _863);
        _2692 = _1769;
        _2691 = _1781;
    }
    uint _2236 = uint(_1385);
    vec4 _2232 = texelFetch(sGpuCache, ivec2(int(_2236 % 1024u), int(_2236 / 1024u)) + ivec2(2, 0), 0);
    vec2 _2210 = _2232.xy;
    vec2 _1895 = vec2(vec3(textureSize(sColor0, 0)).xy);
    uint _2282 = uint(aData.w & 16777215);
    ivec2 _2289 = ivec2(int(_2282 % 1024u), int(_2282 / 1024u));
    vec4 _2273 = texelFetch(sGpuCache, _2289, 0);
    vec2 _2252 = _2273.xy;
    vec2 _2255 = _2273.zw;
    bvec2 _2777 = bvec2(_2232.x < 0.0);
    bool _1914 = (_774 & 2) != 0;
    vec2 _2717;
    vec2 _2731;
    vec2 _2770;
    if (_1914)
    {
        vec2 _2713;
        vec2 _2721;
        vec2 _2735;
        if ((_774 & 128) != 0)
        {
            vec2 _1930 = _2255 - _2252;
            vec2 _1937 = _2252 + (_2696.xy * _1930);
            vec2 _1944 = _2252 + (_2696.zw * _1930);
            vec2 _2707;
            vec2 _2709;
            if ((_774 & 64) != 0)
            {
                vec2 _1956 = _1937 - _2252;
                float _1960 = _1342.x;
                float _1961 = _2690.x - _1960;
                vec2 _2628 = _2775;
                _2628.x = _1961;
                float _1966 = _1342.y;
                vec2 _2632 = _2628;
                _2632.y = _2690.y - _1966;
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
                vec2 _2701;
                vec2 _2702;
                if (_1980)
                {
                    vec2 _2638 = _1956;
                    _2638.x = _2273.z - _1944.x;
                    vec2 _2644 = _2632;
                    _2644.x = ((_1960 + _1342.z) - _2690.x) - _2689.x;
                    _2702 = _2644;
                    _2701 = _2638;
                }
                else
                {
                    _2702 = _2632;
                    _2701 = _1956;
                }
                bool _2004 = _2701.y < 0.001000000047497451305389404296875;
                bool _2012;
                if (!_2004)
                {
                    _2012 = _2702.y < 0.001000000047497451305389404296875;
                }
                else
                {
                    _2012 = _2004;
                }
                vec2 _2708;
                vec2 _2710;
                if (_2012)
                {
                    vec2 _2650 = _2701;
                    _2650.y = _2273.w - _1944.y;
                    vec2 _2656 = _2702;
                    _2656.y = ((_1966 + _1342.w) - _2690.y) - _2689.y;
                    _2710 = _2650;
                    _2708 = _2656;
                }
                else
                {
                    _2710 = _2701;
                    _2708 = _2702;
                }
                _2709 = _2710;
                _2707 = _2708;
            }
            else
            {
                _2709 = _1944 - _1937;
                _2707 = _2689;
            }
            vec2 _2712;
            if ((_774 & 4) != 0)
            {
                vec2 _2661 = _2707;
                _2661.x = (_2707.y / _2709.y) * _2709.x;
                _2712 = _2661;
            }
            else
            {
                _2712 = _2707;
            }
            vec2 _2714;
            if ((_774 & 8) != 0)
            {
                vec2 _2666 = _2712;
                _2666.y = (_2707.x / _2709.x) * _2709.y;
                _2714 = _2666;
            }
            else
            {
                _2714 = _2712;
            }
            _2735 = _1944;
            _2721 = _1937;
            _2713 = _2714;
        }
        else
        {
            vec2 _2697;
            if ((_774 & 4) != 0)
            {
                vec2 _2670 = _2689;
                _2670.x = _2696.z - _2696.x;
                _2697 = _2670;
            }
            else
            {
                _2697 = _2689;
            }
            vec2 _2715;
            if ((_774 & 8) != 0)
            {
                vec2 _2674 = _2697;
                _2674.y = _2696.w - _2696.y;
                _2715 = _2674;
            }
            else
            {
                _2715 = _2697;
            }
            _2735 = _2255;
            _2721 = _2252;
            _2713 = _2715;
        }
        vec2 _2716;
        if ((_774 & 16) != 0)
        {
            vec2 _2679 = _2713;
            _2679.x = _2689.x / max(1.0, round(_2689.x / _2713.x));
            _2716 = _2679;
        }
        else
        {
            _2716 = _2713;
        }
        vec2 _2772;
        if ((_774 & 32) != 0)
        {
            vec2 _2684 = _2716;
            _2684.y = _2689.y / max(1.0, round(_2689.y / _2716.y));
            _2772 = _2684;
        }
        else
        {
            _2772 = _2716;
        }
        _2770 = _2772;
        _2731 = _2735;
        _2717 = _2721;
    }
    else
    {
        _2770 = vec2(_2777.x ? _1351.x : _2210.x, _2777.y ? _1351.y : _2210.y);
        _2731 = _2255;
        _2717 = _2252;
    }
    bvec2 _2779 = bvec2(_1914);
    vec2 _2780 = vec2(_2779.x ? _2689.x : _1351.x, _2779.y ? _2689.y : _1351.y);
    float _2121 = float((_774 & 1) != 0);
    flat_varying_vec4_4.x = texelFetch(sGpuCache, _2289 + ivec2(1, 0), 0).x;
    flat_varying_vec4_4.y = _2121;
    vec2 _2129 = min(_2717, _2731);
    vec2 _2132 = max(_2717, _2731);
    vec4 _2143 = _1895.xyxy;
    flat_varying_vec4_3 = vec4(_2129 + vec2(0.5), _2132 - vec2(0.5)) / _2143;
    vec2 _2162 = mix(_2717, _2731, (_2692 - vec2(_2779.x ? _2690.x : _1349.x, _2779.y ? _2690.y : _1349.y)) / _2780) - _2129;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2162.x, _2162.y);
    vec2 _2168 = varying_vec4_0.zw / _1895;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2168.x, _2168.y);
    vec2 _2174 = varying_vec4_0.zw * (_2780 / _2770);
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2174.x, _2174.y);
    if (_2121 == 0.0)
    {
        vec2 _2185 = varying_vec4_0.zw * _2691.w;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2185.x, _2185.y);
    }
    flat_varying_vec4_2 = vec4(_2129, _2132) / _2143;
}

