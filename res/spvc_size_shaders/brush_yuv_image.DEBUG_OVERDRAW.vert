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
flat out float vCoefficient;
flat out mat3 vYuvColorMatrix;
flat out int vFormat;
out vec3 vUv_Y;
flat out vec4 vUvBounds_Y;
out vec3 vUv_U;
flat out vec4 vUvBounds_U;
out vec3 vUv_V;
flat out vec4 vUvBounds_V;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_0;
out vec4 varying_vec4_1;
flat out int flat_varying_highp_int_address_0;

vec3 _3514;
mat4 _3516;

void main()
{
    int _1177 = aData.z & 65535;
    uint _1201 = uint(aData.x);
    ivec2 _1209 = ivec2(int(2u * (_1201 % 512u)), int(_1201 / 512u));
    vec4 _1214 = texelFetch(sPrimitiveHeadersF, _1209, 0);
    ivec2 _1217 = _1209 + ivec2(1, 0);
    vec4 _1219 = texelFetch(sPrimitiveHeadersF, _1217, 0);
    vec2 _1221 = _1214.xy;
    vec2 _1223 = _1214.zw;
    vec2 _1227 = _1219.xy;
    vec2 _1229 = _1219.zw;
    ivec4 _1246 = texelFetch(sPrimitiveHeadersI, _1209, 0);
    ivec4 _1251 = texelFetch(sPrimitiveHeadersI, _1217, 0);
    float _1254 = float(_1246.x);
    int _1257 = _1246.y;
    int _1260 = _1246.z;
    vec2 _3416;
    vec2 _3418;
    if (_1177 == 65535)
    {
        _3418 = _1221;
        _3416 = _1223;
    }
    else
    {
        uint _1283 = uint((_1257 + 1) + (_1177 * 2));
        vec4 _1274 = texelFetch(sGpuCache, ivec2(int(_1283 % 1024u), int(_1283 / 1024u)), 0);
        _3418 = _1274.xy + _1221;
        _3416 = _1274.zw;
    }
    uint _1314 = uint(aData.y >> 16);
    ivec2 _1322 = ivec2(int(2u * (_1314 % 512u)), int(_1314 / 512u));
    vec4 _1332 = texelFetch(sRenderTasks, _1322 + ivec2(1, 0), 0);
    vec2 _1334 = texelFetch(sRenderTasks, _1322, 0).xy;
    float _1300 = _1332.y;
    vec2 _1303 = _1332.zw;
    uint _1428 = uint(_1260 & 16777215);
    ivec2 _1442 = ivec2(int(8u * (_1428 % 128u)), int(_1428 / 128u));
    mat4 _3474 = _3516;
    _3474[0] = texelFetch(sTransformPalette, _1442, 0);
    mat4 _3476 = _3474;
    _3476[1] = texelFetch(sTransformPalette, _1442 + ivec2(1, 0), 0);
    mat4 _3478 = _3476;
    _3478[2] = texelFetch(sTransformPalette, _1442 + ivec2(2, 0), 0);
    mat4 _3480 = _3478;
    _3480[3] = texelFetch(sTransformPalette, _1442 + ivec2(3, 0), 0);
    vec2 _3435;
    if ((_1260 >> 24) == 0)
    {
        vec2 _1561 = clamp(_3418 + (_3416 * aPosition.xy), _1227, _1227 + _1229);
        vec4 _1518 = _3480 * vec4(_1561, 0.0, 1.0);
        float _1534 = _1518.w;
        gl_Position = uTransform * vec4((_1518.xy * _1300) + (((-_1303) + _1334) * _1534), _1254 * _1534, _1534);
        _3435 = _1561;
    }
    else
    {
        bvec4 _855 = notEqual((ivec4((aData.z >> 16) & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _858 = vec4(_855.x ? vec4(1.0).x : vec4(0.0).x, _855.y ? vec4(1.0).y : vec4(0.0).y, _855.z ? vec4(1.0).z : vec4(0.0).z, _855.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1711 = _1227 + _1229;
        vec4 _1618 = vec4(2.0) * _858;
        vec2 _1620 = _1618.xy;
        vec2 _1641 = (_3418 - _1620) + ((_3416 + (_1620 + _1618.zw)) * aPosition.xy);
        vec4 _1653 = _3480 * vec4(_1641, 0.0, 1.0);
        float _1661 = _1653.w;
        gl_Position = uTransform * vec4((_1653.xy * _1300) + ((_1334 - _1303) * _1661), _1254 * _1661, _1661);
        vTransformBounds = mix(vec4(clamp(_1221, _1227, _1711), clamp(_1221 + _1223, _1227, _1711)), vec4(clamp(_3418, _1227, _1711), clamp(_3418 + _3416, _1227, _1711)), _858);
        _3435 = _1641;
    }
    vec2 _1779 = (_3435 - _1221) / _1223;
    uint _1903 = uint(_1257);
    vec4 _1900 = texelFetch(sGpuCache, ivec2(int(_1903 % 1024u), int(_1903 / 1024u)), 0);
    int _1887 = int(_1900.y);
    vCoefficient = _1900.x;
    if (_1887 == 0)
    {
        vYuvColorMatrix = mat3(vec3(1.16437995433807373046875), vec3(0.0, -0.39175999164581298828125, 2.01723003387451171875), vec3(1.5960299968719482421875, -0.812969982624053955078125, 0.0));
    }
    else
    {
        if (_1887 == 1)
        {
            vYuvColorMatrix = mat3(vec3(1.16437995433807373046875), vec3(0.0, -0.21324999630451202392578125, 2.112400054931640625), vec3(1.79273998737335205078125, -0.53290998935699462890625, 0.0));
        }
        else
        {
            vYuvColorMatrix = mat3(vec3(1.16438353061676025390625), vec3(0.0, -0.1873261034488677978515625, 2.14177227020263671875), vec3(1.67867410182952880859375, -0.650424301624298095703125, 0.0));
        }
    }
    vFormat = int(_1900.z);
    if (vFormat == 1)
    {
        vec2 _1807 = vec2(textureSize(sColor0, 0).xy);
        uint _1987 = uint(_1251.x);
        ivec2 _1994 = ivec2(int(_1987 % 1024u), int(_1987 / 1024u));
        vec4 _1978 = texelFetch(sGpuCache, _1994, 0);
        vec2 _1957 = _1978.xy;
        vec2 _1960 = _1978.zw;
        vec2 _1924 = mix(_1957, _1960, _1779);
        vec3 _3493 = vec3(_1924.x, _1924.y, _3514.z);
        _3493.z = texelFetch(sGpuCache, _1994 + ivec2(1, 0), 0).x;
        vec2 _1942 = _3493.xy / _1807;
        vUv_Y = vec3(_1942.x, _1942.y, _3493.z);
        vUvBounds_Y = vec4(_1957 + vec2(0.5), _1960 - vec2(0.5)) / _1807.xyxy;
        vec2 _1818 = vec2(textureSize(sColor1, 0).xy);
        uint _2071 = uint(_1251.y);
        ivec2 _2078 = ivec2(int(_2071 % 1024u), int(_2071 / 1024u));
        vec4 _2062 = texelFetch(sGpuCache, _2078, 0);
        vec2 _2041 = _2062.xy;
        vec2 _2044 = _2062.zw;
        vec2 _2008 = mix(_2041, _2044, _1779);
        vec3 _3497 = vec3(_2008.x, _2008.y, _3514.z);
        _3497.z = texelFetch(sGpuCache, _2078 + ivec2(1, 0), 0).x;
        vec2 _2026 = _3497.xy / _1818;
        vUv_U = vec3(_2026.x, _2026.y, _3497.z);
        vUvBounds_U = vec4(_2041 + vec2(0.5), _2044 - vec2(0.5)) / _1818.xyxy;
        vec2 _1829 = vec2(textureSize(sColor2, 0).xy);
        uint _2155 = uint(_1251.z);
        ivec2 _2162 = ivec2(int(_2155 % 1024u), int(_2155 / 1024u));
        vec4 _2146 = texelFetch(sGpuCache, _2162, 0);
        vec2 _2125 = _2146.xy;
        vec2 _2128 = _2146.zw;
        vec2 _2092 = mix(_2125, _2128, _1779);
        vec3 _3501 = vec3(_2092.x, _2092.y, _3514.z);
        _3501.z = texelFetch(sGpuCache, _2162 + ivec2(1, 0), 0).x;
        vec2 _2110 = _3501.xy / _1829;
        vUv_V = vec3(_2110.x, _2110.y, _3501.z);
        vUvBounds_V = vec4(_2125 + vec2(0.5), _2128 - vec2(0.5)) / _1829.xyxy;
    }
    else
    {
        if (vFormat == 0)
        {
            vec2 _1845 = vec2(textureSize(sColor0, 0).xy);
            uint _2239 = uint(_1251.x);
            ivec2 _2246 = ivec2(int(_2239 % 1024u), int(_2239 / 1024u));
            vec4 _2230 = texelFetch(sGpuCache, _2246, 0);
            vec2 _2209 = _2230.xy;
            vec2 _2212 = _2230.zw;
            vec2 _2176 = mix(_2209, _2212, _1779);
            vec3 _3505 = vec3(_2176.x, _2176.y, _3514.z);
            _3505.z = texelFetch(sGpuCache, _2246 + ivec2(1, 0), 0).x;
            vec2 _2194 = _3505.xy / _1845;
            vUv_Y = vec3(_2194.x, _2194.y, _3505.z);
            vUvBounds_Y = vec4(_2209 + vec2(0.5), _2212 - vec2(0.5)) / _1845.xyxy;
            vec2 _1856 = vec2(textureSize(sColor1, 0).xy);
            uint _2323 = uint(_1251.y);
            ivec2 _2330 = ivec2(int(_2323 % 1024u), int(_2323 / 1024u));
            vec4 _2314 = texelFetch(sGpuCache, _2330, 0);
            vec2 _2293 = _2314.xy;
            vec2 _2296 = _2314.zw;
            vec2 _2260 = mix(_2293, _2296, _1779);
            vec3 _3509 = vec3(_2260.x, _2260.y, _3514.z);
            _3509.z = texelFetch(sGpuCache, _2330 + ivec2(1, 0), 0).x;
            vec2 _2278 = _3509.xy / _1856;
            vUv_U = vec3(_2278.x, _2278.y, _3509.z);
            vUvBounds_U = vec4(_2293 + vec2(0.5), _2296 - vec2(0.5)) / _1856.xyxy;
        }
        else
        {
            if (vFormat == 2)
            {
                vec2 _1871 = vec2(textureSize(sColor0, 0).xy);
                uint _2407 = uint(_1251.x);
                ivec2 _2414 = ivec2(int(_2407 % 1024u), int(_2407 / 1024u));
                vec4 _2398 = texelFetch(sGpuCache, _2414, 0);
                vec2 _2377 = _2398.xy;
                vec2 _2380 = _2398.zw;
                vec2 _2344 = mix(_2377, _2380, _1779);
                vec3 _3513 = vec3(_2344.x, _2344.y, _3514.z);
                _3513.z = texelFetch(sGpuCache, _2414 + ivec2(1, 0), 0).x;
                vec2 _2362 = _3513.xy / _1871;
                vUv_Y = vec3(_2362.x, _2362.y, _3513.z);
                vUvBounds_Y = vec4(_2377 + vec2(0.5), _2380 - vec2(0.5)) / _1871.xyxy;
            }
        }
    }
}

