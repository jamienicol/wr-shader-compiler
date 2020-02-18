#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform mat4 uTransform;
uniform mediump sampler2D sColor0;
uniform mediump sampler2D sColor1;
uniform mediump sampler2D sColor2;

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

mat4 _2964;
vec3 _2977;

void main()
{
    int _1221 = aData.y & 65535;
    int _1225 = aData.z & 65535;
    uint _1249 = uint(aData.x);
    ivec2 _1257 = ivec2(int(2u * (_1249 % 512u)), int(_1249 / 512u));
    vec4 _1262 = texelFetch(sPrimitiveHeadersF, _1257, 0);
    ivec2 _1265 = _1257 + ivec2(1, 0);
    vec4 _1267 = texelFetch(sPrimitiveHeadersF, _1265, 0);
    vec2 _1269 = _1262.xy;
    vec2 _1271 = _1262.zw;
    vec2 _1275 = _1267.xy;
    vec2 _1277 = _1267.zw;
    ivec4 _1294 = texelFetch(sPrimitiveHeadersI, _1257, 0);
    ivec4 _1299 = texelFetch(sPrimitiveHeadersI, _1265, 0);
    float _1302 = float(_1294.x);
    int _1305 = _1294.y;
    int _1308 = _1294.z;
    vec2 _2968;
    vec2 _2970;
    if (_1225 == 65535)
    {
        _2970 = _1269;
        _2968 = _1271;
    }
    else
    {
        uint _1331 = uint((_1305 + 1) + (_1225 * 2));
        vec4 _1322 = texelFetch(sGpuCache, ivec2(int(_1331 % 1024u), int(_1331 / 1024u)), 0);
        _2970 = _1322.xy + _1269;
        _2968 = _1322.zw;
    }
    uint _1362 = uint(aData.y >> 16);
    ivec2 _1370 = ivec2(int(2u * (_1362 % 512u)), int(_1362 / 512u));
    vec4 _1380 = texelFetch(sRenderTasks, _1370 + ivec2(1, 0), 0);
    vec2 _1382 = texelFetch(sRenderTasks, _1370, 0).xy;
    float _1348 = _1380.y;
    vec2 _1351 = _1380.zw;
    vec2 _2957;
    float _2958;
    float _2959;
    vec2 _2960;
    vec2 _2961;
    if (_1221 >= 32767)
    {
        _2961 = vec2(0.0);
        _2960 = vec2(0.0);
        _2959 = 0.0;
        _2958 = 0.0;
        _2957 = vec2(0.0);
    }
    else
    {
        uint _1431 = uint(_1221);
        ivec2 _1439 = ivec2(int(2u * (_1431 % 512u)), int(_1431 / 512u));
        vec4 _1444 = texelFetch(sRenderTasks, _1439, 0);
        vec4 _1449 = texelFetch(sRenderTasks, _1439 + ivec2(1, 0), 0);
        _2961 = _1444.xy;
        _2960 = _1444.zw;
        _2959 = _1449.x;
        _2958 = _1449.y;
        _2957 = _1449.zw;
    }
    uint _1476 = uint(_1308 & 16777215);
    ivec2 _1490 = ivec2(int(8u * (_1476 % 128u)), int(_1476 / 128u));
    mat4 _2907 = _2964;
    _2907[0] = texelFetch(sTransformPalette, _1490, 0);
    mat4 _2909 = _2907;
    _2909[1] = texelFetch(sTransformPalette, _1490 + ivec2(1, 0), 0);
    mat4 _2911 = _2909;
    _2911[2] = texelFetch(sTransformPalette, _1490 + ivec2(2, 0), 0);
    mat4 _2913 = _2911;
    _2913[3] = texelFetch(sTransformPalette, _1490 + ivec2(3, 0), 0);
    vec4 _2971;
    vec2 _2972;
    if ((_1308 >> 24) == 0)
    {
        vec2 _1609 = clamp(_2970 + (_2968 * aPosition.xy), _1275, _1275 + _1277);
        vec4 _1566 = _2913 * vec4(_1609, 0.0, 1.0);
        float _1582 = _1566.w;
        gl_Position = uTransform * vec4((_1566.xy * _1348) + (((-_1351) + _1382) * _1582), _1302 * _1582, _1582);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _2972 = _1609;
        _2971 = _1566;
    }
    else
    {
        bvec4 _902 = notEqual((ivec4((aData.z >> 16) & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _905 = vec4(_902.x ? vec4(1.0).x : vec4(0.0).x, _902.y ? vec4(1.0).y : vec4(0.0).y, _902.z ? vec4(1.0).z : vec4(0.0).z, _902.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1760 = _1275 + _1277;
        vec4 _1667 = vec4(2.0) * _905;
        vec2 _1669 = _1667.xy;
        vec2 _1690 = (_2970 - _1669) + ((_2968 + (_1669 + _1667.zw)) * aPosition.xy);
        vec4 _1702 = _2913 * vec4(_1690, 0.0, 1.0);
        float _1710 = _1702.w;
        gl_Position = uTransform * vec4((_1702.xy * _1348) + ((_1382 - _1351) * _1710), _1302 * _1710, _1710);
        vTransformBounds = mix(vec4(clamp(_1269, _1275, _1760), clamp(_1269 + _1271, _1275, _1760)), vec4(clamp(_2970, _1275, _1760), clamp(_2970 + _2968, _1275, _1760)), _905);
        _2972 = _1690;
        _2971 = _1702;
    }
    vClipMaskUvBounds = vec4(_2961, _2961 + _2960);
    vClipMaskUv = vec4((_2971.xy * _2958) + ((_2961 - _2957) * _2971.w), _2959, _2971.w);
    vec2 _1863 = (_2972 - _1269) / _1271;
    uint _1983 = uint(_1305);
    vec4 _1980 = texelFetch(sGpuCache, ivec2(int(_1983 % 1024u), int(_1983 / 1024u)), 0);
    int _1967 = int(_1980.y);
    vCoefficient = _1980.x;
    if (_1967 == 0)
    {
        vYuvColorMatrix = mat3(vec3(1.16437995433807373046875), vec3(0.0, -0.39175999164581298828125, 2.01723003387451171875), vec3(1.5960299968719482421875, -0.812969982624053955078125, 0.0));
    }
    else
    {
        if (_1967 == 1)
        {
            vYuvColorMatrix = mat3(vec3(1.16437995433807373046875), vec3(0.0, -0.21324999630451202392578125, 2.112400054931640625), vec3(1.79273998737335205078125, -0.53290998935699462890625, 0.0));
        }
        else
        {
            vYuvColorMatrix = mat3(vec3(1.16438353061676025390625), vec3(0.0, -0.1873261034488677978515625, 2.14177227020263671875), vec3(1.67867410182952880859375, -0.650424301624298095703125, 0.0));
        }
    }
    vFormat = int(_1980.z);
    vLocalPos = _2972;
    if (vFormat == 1)
    {
        vec2 _1892 = vec2(textureSize(sColor0, 0));
        uint _2067 = uint(_1299.x);
        ivec2 _2074 = ivec2(int(_2067 % 1024u), int(_2067 / 1024u));
        vec4 _2058 = texelFetch(sGpuCache, _2074, 0);
        vec2 _2037 = _2058.xy;
        vec2 _2040 = _2058.zw;
        vec2 _2004 = mix(_2037, _2040, _1863);
        vec3 _2936 = vec3(_2004.x, _2004.y, _2977.z);
        _2936.z = texelFetch(sGpuCache, _2074 + ivec2(1, 0), 0).x;
        vec2 _2022 = _2936.xy / _1892;
        vUv_Y = vec3(_2022.x, _2022.y, _2936.z);
        vUvBounds_Y = vec4(_2037 + vec2(0.5), _2040 - vec2(0.5)) / _1892.xyxy;
        vec2 _1902 = vec2(textureSize(sColor1, 0));
        uint _2151 = uint(_1299.y);
        ivec2 _2158 = ivec2(int(_2151 % 1024u), int(_2151 / 1024u));
        vec4 _2142 = texelFetch(sGpuCache, _2158, 0);
        vec2 _2121 = _2142.xy;
        vec2 _2124 = _2142.zw;
        vec2 _2088 = mix(_2121, _2124, _1863);
        vec3 _2940 = vec3(_2088.x, _2088.y, _2977.z);
        _2940.z = texelFetch(sGpuCache, _2158 + ivec2(1, 0), 0).x;
        vec2 _2106 = _2940.xy / _1902;
        vUv_U = vec3(_2106.x, _2106.y, _2940.z);
        vUvBounds_U = vec4(_2121 + vec2(0.5), _2124 - vec2(0.5)) / _1902.xyxy;
        vec2 _1912 = vec2(textureSize(sColor2, 0));
        uint _2235 = uint(_1299.z);
        ivec2 _2242 = ivec2(int(_2235 % 1024u), int(_2235 / 1024u));
        vec4 _2226 = texelFetch(sGpuCache, _2242, 0);
        vec2 _2205 = _2226.xy;
        vec2 _2208 = _2226.zw;
        vec2 _2172 = mix(_2205, _2208, _1863);
        vec3 _2944 = vec3(_2172.x, _2172.y, _2977.z);
        _2944.z = texelFetch(sGpuCache, _2242 + ivec2(1, 0), 0).x;
        vec2 _2190 = _2944.xy / _1912;
        vUv_V = vec3(_2190.x, _2190.y, _2944.z);
        vUvBounds_V = vec4(_2205 + vec2(0.5), _2208 - vec2(0.5)) / _1912.xyxy;
    }
    else
    {
        if (vFormat == 0)
        {
            vec2 _1927 = vec2(textureSize(sColor0, 0));
            uint _2319 = uint(_1299.x);
            ivec2 _2326 = ivec2(int(_2319 % 1024u), int(_2319 / 1024u));
            vec4 _2310 = texelFetch(sGpuCache, _2326, 0);
            vec2 _2289 = _2310.xy;
            vec2 _2292 = _2310.zw;
            vec2 _2256 = mix(_2289, _2292, _1863);
            vec3 _2948 = vec3(_2256.x, _2256.y, _2977.z);
            _2948.z = texelFetch(sGpuCache, _2326 + ivec2(1, 0), 0).x;
            vec2 _2274 = _2948.xy / _1927;
            vUv_Y = vec3(_2274.x, _2274.y, _2948.z);
            vUvBounds_Y = vec4(_2289 + vec2(0.5), _2292 - vec2(0.5)) / _1927.xyxy;
            vec2 _1937 = vec2(textureSize(sColor1, 0));
            uint _2403 = uint(_1299.y);
            ivec2 _2410 = ivec2(int(_2403 % 1024u), int(_2403 / 1024u));
            vec4 _2394 = texelFetch(sGpuCache, _2410, 0);
            vec2 _2373 = _2394.xy;
            vec2 _2376 = _2394.zw;
            vec2 _2340 = mix(_2373, _2376, _1863);
            vec3 _2952 = vec3(_2340.x, _2340.y, _2977.z);
            _2952.z = texelFetch(sGpuCache, _2410 + ivec2(1, 0), 0).x;
            vec2 _2358 = _2952.xy / _1937;
            vUv_U = vec3(_2358.x, _2358.y, _2952.z);
            vUvBounds_U = vec4(_2373 + vec2(0.5), _2376 - vec2(0.5)) / _1937.xyxy;
        }
        else
        {
            if (vFormat == 2)
            {
                vec2 _1951 = vec2(textureSize(sColor0, 0));
                uint _2487 = uint(_1299.x);
                ivec2 _2494 = ivec2(int(_2487 % 1024u), int(_2487 / 1024u));
                vec4 _2478 = texelFetch(sGpuCache, _2494, 0);
                vec2 _2457 = _2478.xy;
                vec2 _2460 = _2478.zw;
                vec2 _2424 = mix(_2457, _2460, _1863);
                vec3 _2956 = vec3(_2424.x, _2424.y, _2977.z);
                _2956.z = texelFetch(sGpuCache, _2494 + ivec2(1, 0), 0).x;
                vec2 _2442 = _2956.xy / _1951;
                vUv_Y = vec3(_2442.x, _2442.y, _2956.z);
                vUvBounds_Y = vec4(_2457 + vec2(0.5), _2460 - vec2(0.5)) / _1951.xyxy;
            }
        }
    }
}

