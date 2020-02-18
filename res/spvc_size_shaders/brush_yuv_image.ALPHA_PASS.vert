#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform mat4 uTransform;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;

flat out vec4 vTransformBounds;
layout(location = 1) in ivec4 aData;
layout(location = 0) in vec3 aPosition;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
flat out float vCoefficient;
flat out mat3 vYuvColorMatrix;
flat out int vFormat;
out vec2 vLocalPos;
out vec3 vUv_Y;
flat out vec4 vUvBounds_Y;
out vec3 vUv_U;
flat out vec4 vUvBounds_U;
out vec3 vUv_V;
flat out vec4 vUvBounds_V;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_0;
out vec4 varying_vec4_1;
flat out int flat_varying_highp_int_address_0;

vec3 _3665;
mat4 _3668;

void main()
{
    int _1228 = aData.y & 65535;
    int _1232 = aData.z & 65535;
    uint _1256 = uint(aData.x);
    ivec2 _1264 = ivec2(int(2u * (_1256 % 512u)), int(_1256 / 512u));
    vec4 _1269 = texelFetch(sPrimitiveHeadersF, _1264, 0);
    ivec2 _1272 = _1264 + ivec2(1, 0);
    vec4 _1274 = texelFetch(sPrimitiveHeadersF, _1272, 0);
    vec2 _1276 = _1269.xy;
    vec2 _1278 = _1269.zw;
    vec2 _1282 = _1274.xy;
    vec2 _1284 = _1274.zw;
    ivec4 _1301 = texelFetch(sPrimitiveHeadersI, _1264, 0);
    ivec4 _1306 = texelFetch(sPrimitiveHeadersI, _1272, 0);
    float _1309 = float(_1301.x);
    int _1312 = _1301.y;
    int _1315 = _1301.z;
    vec2 _3556;
    vec2 _3558;
    if (_1232 == 65535)
    {
        _3558 = _1276;
        _3556 = _1278;
    }
    else
    {
        uint _1338 = uint((_1312 + 1) + (_1232 * 2));
        vec4 _1329 = texelFetch(sGpuCache, ivec2(int(_1338 % 1024u), int(_1338 / 1024u)), 0);
        _3558 = _1329.xy + _1276;
        _3556 = _1329.zw;
    }
    uint _1369 = uint(aData.y >> 16);
    ivec2 _1377 = ivec2(int(2u * (_1369 % 512u)), int(_1369 / 512u));
    vec4 _1387 = texelFetch(sRenderTasks, _1377 + ivec2(1, 0), 0);
    vec2 _1389 = texelFetch(sRenderTasks, _1377, 0).xy;
    float _1355 = _1387.y;
    vec2 _1358 = _1387.zw;
    vec2 _3546;
    float _3547;
    float _3548;
    vec2 _3549;
    vec2 _3550;
    if (_1228 >= 32767)
    {
        _3550 = vec2(0.0);
        _3549 = vec2(0.0);
        _3548 = 0.0;
        _3547 = 0.0;
        _3546 = vec2(0.0);
    }
    else
    {
        uint _1438 = uint(_1228);
        ivec2 _1446 = ivec2(int(2u * (_1438 % 512u)), int(_1438 / 512u));
        vec4 _1451 = texelFetch(sRenderTasks, _1446, 0);
        vec4 _1456 = texelFetch(sRenderTasks, _1446 + ivec2(1, 0), 0);
        _3550 = _1451.xy;
        _3549 = _1451.zw;
        _3548 = _1456.x;
        _3547 = _1456.y;
        _3546 = _1456.zw;
    }
    uint _1483 = uint(_1315 & 16777215);
    ivec2 _1497 = ivec2(int(8u * (_1483 % 128u)), int(_1483 / 128u));
    mat4 _3623 = _3668;
    _3623[0] = texelFetch(sTransformPalette, _1497, 0);
    mat4 _3625 = _3623;
    _3625[1] = texelFetch(sTransformPalette, _1497 + ivec2(1, 0), 0);
    mat4 _3627 = _3625;
    _3627[2] = texelFetch(sTransformPalette, _1497 + ivec2(2, 0), 0);
    mat4 _3629 = _3627;
    _3629[3] = texelFetch(sTransformPalette, _1497 + ivec2(3, 0), 0);
    vec4 _3574;
    vec2 _3580;
    if ((_1315 >> 24) == 0)
    {
        vec2 _1616 = clamp(_3558 + (_3556 * aPosition.xy), _1282, _1282 + _1284);
        vec4 _1573 = _3629 * vec4(_1616, 0.0, 1.0);
        float _1589 = _1573.w;
        gl_Position = uTransform * vec4((_1573.xy * _1355) + (((-_1358) + _1389) * _1589), _1309 * _1589, _1589);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _3580 = _1616;
        _3574 = _1573;
    }
    else
    {
        bvec4 _902 = notEqual((ivec4((aData.z >> 16) & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _905 = vec4(_902.x ? vec4(1.0).x : vec4(0.0).x, _902.y ? vec4(1.0).y : vec4(0.0).y, _902.z ? vec4(1.0).z : vec4(0.0).z, _902.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1767 = _1282 + _1284;
        vec4 _1674 = vec4(2.0) * _905;
        vec2 _1676 = _1674.xy;
        vec2 _1697 = (_3558 - _1676) + ((_3556 + (_1676 + _1674.zw)) * aPosition.xy);
        vec4 _1709 = _3629 * vec4(_1697, 0.0, 1.0);
        float _1717 = _1709.w;
        gl_Position = uTransform * vec4((_1709.xy * _1355) + ((_1389 - _1358) * _1717), _1309 * _1717, _1717);
        vTransformBounds = mix(vec4(clamp(_1276, _1282, _1767), clamp(_1276 + _1278, _1282, _1767)), vec4(clamp(_3558, _1282, _1767), clamp(_3558 + _3556, _1282, _1767)), _905);
        _3580 = _1697;
        _3574 = _1709;
    }
    vClipMaskUvBounds = vec4(_3550, _3550 + _3549);
    vClipMaskUv = vec4((_3574.xy * _3547) + ((_3550 - _3546) * _3574.w), _3548, _3574.w);
    vec2 _1870 = (_3580 - _1276) / _1278;
    uint _1996 = uint(_1312);
    vec4 _1993 = texelFetch(sGpuCache, ivec2(int(_1996 % 1024u), int(_1996 / 1024u)), 0);
    int _1980 = int(_1993.y);
    vCoefficient = _1993.x;
    if (_1980 == 0)
    {
        vYuvColorMatrix = mat3(vec3(1.16437995433807373046875), vec3(0.0, -0.39175999164581298828125, 2.01723003387451171875), vec3(1.5960299968719482421875, -0.812969982624053955078125, 0.0));
    }
    else
    {
        if (_1980 == 1)
        {
            vYuvColorMatrix = mat3(vec3(1.16437995433807373046875), vec3(0.0, -0.21324999630451202392578125, 2.112400054931640625), vec3(1.79273998737335205078125, -0.53290998935699462890625, 0.0));
        }
        else
        {
            vYuvColorMatrix = mat3(vec3(1.16438353061676025390625), vec3(0.0, -0.1873261034488677978515625, 2.14177227020263671875), vec3(1.67867410182952880859375, -0.650424301624298095703125, 0.0));
        }
    }
    vFormat = int(_1993.z);
    vLocalPos = _3580;
    if (vFormat == 1)
    {
        vec2 _1900 = vec2(textureSize(sColor0, 0).xy);
        uint _2080 = uint(_1306.x);
        ivec2 _2087 = ivec2(int(_2080 % 1024u), int(_2080 / 1024u));
        vec4 _2071 = texelFetch(sGpuCache, _2087, 0);
        vec2 _2050 = _2071.xy;
        vec2 _2053 = _2071.zw;
        vec2 _2017 = mix(_2050, _2053, _1870);
        vec3 _3644 = vec3(_2017.x, _2017.y, _3665.z);
        _3644.z = texelFetch(sGpuCache, _2087 + ivec2(1, 0), 0).x;
        vec2 _2035 = _3644.xy / _1900;
        vUv_Y = vec3(_2035.x, _2035.y, _3644.z);
        vUvBounds_Y = vec4(_2050 + vec2(0.5), _2053 - vec2(0.5)) / _1900.xyxy;
        vec2 _1911 = vec2(textureSize(sColor1, 0).xy);
        uint _2164 = uint(_1306.y);
        ivec2 _2171 = ivec2(int(_2164 % 1024u), int(_2164 / 1024u));
        vec4 _2155 = texelFetch(sGpuCache, _2171, 0);
        vec2 _2134 = _2155.xy;
        vec2 _2137 = _2155.zw;
        vec2 _2101 = mix(_2134, _2137, _1870);
        vec3 _3648 = vec3(_2101.x, _2101.y, _3665.z);
        _3648.z = texelFetch(sGpuCache, _2171 + ivec2(1, 0), 0).x;
        vec2 _2119 = _3648.xy / _1911;
        vUv_U = vec3(_2119.x, _2119.y, _3648.z);
        vUvBounds_U = vec4(_2134 + vec2(0.5), _2137 - vec2(0.5)) / _1911.xyxy;
        vec2 _1922 = vec2(textureSize(sColor2, 0).xy);
        uint _2248 = uint(_1306.z);
        ivec2 _2255 = ivec2(int(_2248 % 1024u), int(_2248 / 1024u));
        vec4 _2239 = texelFetch(sGpuCache, _2255, 0);
        vec2 _2218 = _2239.xy;
        vec2 _2221 = _2239.zw;
        vec2 _2185 = mix(_2218, _2221, _1870);
        vec3 _3652 = vec3(_2185.x, _2185.y, _3665.z);
        _3652.z = texelFetch(sGpuCache, _2255 + ivec2(1, 0), 0).x;
        vec2 _2203 = _3652.xy / _1922;
        vUv_V = vec3(_2203.x, _2203.y, _3652.z);
        vUvBounds_V = vec4(_2218 + vec2(0.5), _2221 - vec2(0.5)) / _1922.xyxy;
    }
    else
    {
        if (vFormat == 0)
        {
            vec2 _1938 = vec2(textureSize(sColor0, 0).xy);
            uint _2332 = uint(_1306.x);
            ivec2 _2339 = ivec2(int(_2332 % 1024u), int(_2332 / 1024u));
            vec4 _2323 = texelFetch(sGpuCache, _2339, 0);
            vec2 _2302 = _2323.xy;
            vec2 _2305 = _2323.zw;
            vec2 _2269 = mix(_2302, _2305, _1870);
            vec3 _3656 = vec3(_2269.x, _2269.y, _3665.z);
            _3656.z = texelFetch(sGpuCache, _2339 + ivec2(1, 0), 0).x;
            vec2 _2287 = _3656.xy / _1938;
            vUv_Y = vec3(_2287.x, _2287.y, _3656.z);
            vUvBounds_Y = vec4(_2302 + vec2(0.5), _2305 - vec2(0.5)) / _1938.xyxy;
            vec2 _1949 = vec2(textureSize(sColor1, 0).xy);
            uint _2416 = uint(_1306.y);
            ivec2 _2423 = ivec2(int(_2416 % 1024u), int(_2416 / 1024u));
            vec4 _2407 = texelFetch(sGpuCache, _2423, 0);
            vec2 _2386 = _2407.xy;
            vec2 _2389 = _2407.zw;
            vec2 _2353 = mix(_2386, _2389, _1870);
            vec3 _3660 = vec3(_2353.x, _2353.y, _3665.z);
            _3660.z = texelFetch(sGpuCache, _2423 + ivec2(1, 0), 0).x;
            vec2 _2371 = _3660.xy / _1949;
            vUv_U = vec3(_2371.x, _2371.y, _3660.z);
            vUvBounds_U = vec4(_2386 + vec2(0.5), _2389 - vec2(0.5)) / _1949.xyxy;
        }
        else
        {
            if (vFormat == 2)
            {
                vec2 _1964 = vec2(textureSize(sColor0, 0).xy);
                uint _2500 = uint(_1306.x);
                ivec2 _2507 = ivec2(int(_2500 % 1024u), int(_2500 / 1024u));
                vec4 _2491 = texelFetch(sGpuCache, _2507, 0);
                vec2 _2470 = _2491.xy;
                vec2 _2473 = _2491.zw;
                vec2 _2437 = mix(_2470, _2473, _1870);
                vec3 _3664 = vec3(_2437.x, _2437.y, _3665.z);
                _3664.z = texelFetch(sGpuCache, _2507 + ivec2(1, 0), 0).x;
                vec2 _2455 = _3664.xy / _1964;
                vUv_Y = vec3(_2455.x, _2455.y, _3664.z);
                vUvBounds_Y = vec4(_2470 + vec2(0.5), _2473 - vec2(0.5)) / _1964.xyxy;
            }
        }
    }
}

