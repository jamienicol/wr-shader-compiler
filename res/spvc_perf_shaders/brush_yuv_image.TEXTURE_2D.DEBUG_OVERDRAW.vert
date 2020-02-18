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

mat4 _2792;
vec3 _2801;

void main()
{
    int _1170 = aData.z & 65535;
    uint _1194 = uint(aData.x);
    ivec2 _1202 = ivec2(int(2u * (_1194 % 512u)), int(_1194 / 512u));
    vec4 _1207 = texelFetch(sPrimitiveHeadersF, _1202, 0);
    ivec2 _1210 = _1202 + ivec2(1, 0);
    vec4 _1212 = texelFetch(sPrimitiveHeadersF, _1210, 0);
    vec2 _1214 = _1207.xy;
    vec2 _1216 = _1207.zw;
    vec2 _1220 = _1212.xy;
    vec2 _1222 = _1212.zw;
    ivec4 _1239 = texelFetch(sPrimitiveHeadersI, _1202, 0);
    ivec4 _1244 = texelFetch(sPrimitiveHeadersI, _1210, 0);
    float _1247 = float(_1239.x);
    int _1250 = _1239.y;
    int _1253 = _1239.z;
    vec2 _2794;
    vec2 _2795;
    if (_1170 == 65535)
    {
        _2795 = _1214;
        _2794 = _1216;
    }
    else
    {
        uint _1276 = uint((_1250 + 1) + (_1170 * 2));
        vec4 _1267 = texelFetch(sGpuCache, ivec2(int(_1276 % 1024u), int(_1276 / 1024u)), 0);
        _2795 = _1267.xy + _1214;
        _2794 = _1267.zw;
    }
    uint _1307 = uint(aData.y >> 16);
    ivec2 _1315 = ivec2(int(2u * (_1307 % 512u)), int(_1307 / 512u));
    vec4 _1325 = texelFetch(sRenderTasks, _1315 + ivec2(1, 0), 0);
    vec2 _1327 = texelFetch(sRenderTasks, _1315, 0).xy;
    float _1293 = _1325.y;
    vec2 _1296 = _1325.zw;
    uint _1421 = uint(_1253 & 16777215);
    ivec2 _1435 = ivec2(int(8u * (_1421 % 128u)), int(_1421 / 128u));
    mat4 _2743 = _2792;
    _2743[0] = texelFetch(sTransformPalette, _1435, 0);
    mat4 _2745 = _2743;
    _2745[1] = texelFetch(sTransformPalette, _1435 + ivec2(1, 0), 0);
    mat4 _2747 = _2745;
    _2747[2] = texelFetch(sTransformPalette, _1435 + ivec2(2, 0), 0);
    mat4 _2749 = _2747;
    _2749[3] = texelFetch(sTransformPalette, _1435 + ivec2(3, 0), 0);
    vec2 _2797;
    if ((_1253 >> 24) == 0)
    {
        vec2 _1554 = clamp(_2795 + (_2794 * aPosition.xy), _1220, _1220 + _1222);
        vec4 _1511 = _2749 * vec4(_1554, 0.0, 1.0);
        float _1527 = _1511.w;
        gl_Position = uTransform * vec4((_1511.xy * _1293) + (((-_1296) + _1327) * _1527), _1247 * _1527, _1527);
        _2797 = _1554;
    }
    else
    {
        bvec4 _855 = notEqual((ivec4((aData.z >> 16) & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _858 = vec4(_855.x ? vec4(1.0).x : vec4(0.0).x, _855.y ? vec4(1.0).y : vec4(0.0).y, _855.z ? vec4(1.0).z : vec4(0.0).z, _855.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1704 = _1220 + _1222;
        vec4 _1611 = vec4(2.0) * _858;
        vec2 _1613 = _1611.xy;
        vec2 _1634 = (_2795 - _1613) + ((_2794 + (_1613 + _1611.zw)) * aPosition.xy);
        vec4 _1646 = _2749 * vec4(_1634, 0.0, 1.0);
        float _1654 = _1646.w;
        gl_Position = uTransform * vec4((_1646.xy * _1293) + ((_1327 - _1296) * _1654), _1247 * _1654, _1654);
        vTransformBounds = mix(vec4(clamp(_1214, _1220, _1704), clamp(_1214 + _1216, _1220, _1704)), vec4(clamp(_2795, _1220, _1704), clamp(_2795 + _2794, _1220, _1704)), _858);
        _2797 = _1634;
    }
    vec2 _1772 = (_2797 - _1214) / _1216;
    uint _1890 = uint(_1250);
    vec4 _1887 = texelFetch(sGpuCache, ivec2(int(_1890 % 1024u), int(_1890 / 1024u)), 0);
    int _1874 = int(_1887.y);
    vCoefficient = _1887.x;
    if (_1874 == 0)
    {
        vYuvColorMatrix = mat3(vec3(1.16437995433807373046875), vec3(0.0, -0.39175999164581298828125, 2.01723003387451171875), vec3(1.5960299968719482421875, -0.812969982624053955078125, 0.0));
    }
    else
    {
        if (_1874 == 1)
        {
            vYuvColorMatrix = mat3(vec3(1.16437995433807373046875), vec3(0.0, -0.21324999630451202392578125, 2.112400054931640625), vec3(1.79273998737335205078125, -0.53290998935699462890625, 0.0));
        }
        else
        {
            vYuvColorMatrix = mat3(vec3(1.16438353061676025390625), vec3(0.0, -0.1873261034488677978515625, 2.14177227020263671875), vec3(1.67867410182952880859375, -0.650424301624298095703125, 0.0));
        }
    }
    vFormat = int(_1887.z);
    if (vFormat == 1)
    {
        vec2 _1799 = vec2(textureSize(sColor0, 0));
        uint _1974 = uint(_1244.x);
        ivec2 _1981 = ivec2(int(_1974 % 1024u), int(_1974 / 1024u));
        vec4 _1965 = texelFetch(sGpuCache, _1981, 0);
        vec2 _1944 = _1965.xy;
        vec2 _1947 = _1965.zw;
        vec2 _1911 = mix(_1944, _1947, _1772);
        vec3 _2770 = vec3(_1911.x, _1911.y, _2801.z);
        _2770.z = texelFetch(sGpuCache, _1981 + ivec2(1, 0), 0).x;
        vec2 _1929 = _2770.xy / _1799;
        vUv_Y = vec3(_1929.x, _1929.y, _2770.z);
        vUvBounds_Y = vec4(_1944 + vec2(0.5), _1947 - vec2(0.5)) / _1799.xyxy;
        vec2 _1809 = vec2(textureSize(sColor1, 0));
        uint _2058 = uint(_1244.y);
        ivec2 _2065 = ivec2(int(_2058 % 1024u), int(_2058 / 1024u));
        vec4 _2049 = texelFetch(sGpuCache, _2065, 0);
        vec2 _2028 = _2049.xy;
        vec2 _2031 = _2049.zw;
        vec2 _1995 = mix(_2028, _2031, _1772);
        vec3 _2774 = vec3(_1995.x, _1995.y, _2801.z);
        _2774.z = texelFetch(sGpuCache, _2065 + ivec2(1, 0), 0).x;
        vec2 _2013 = _2774.xy / _1809;
        vUv_U = vec3(_2013.x, _2013.y, _2774.z);
        vUvBounds_U = vec4(_2028 + vec2(0.5), _2031 - vec2(0.5)) / _1809.xyxy;
        vec2 _1819 = vec2(textureSize(sColor2, 0));
        uint _2142 = uint(_1244.z);
        ivec2 _2149 = ivec2(int(_2142 % 1024u), int(_2142 / 1024u));
        vec4 _2133 = texelFetch(sGpuCache, _2149, 0);
        vec2 _2112 = _2133.xy;
        vec2 _2115 = _2133.zw;
        vec2 _2079 = mix(_2112, _2115, _1772);
        vec3 _2778 = vec3(_2079.x, _2079.y, _2801.z);
        _2778.z = texelFetch(sGpuCache, _2149 + ivec2(1, 0), 0).x;
        vec2 _2097 = _2778.xy / _1819;
        vUv_V = vec3(_2097.x, _2097.y, _2778.z);
        vUvBounds_V = vec4(_2112 + vec2(0.5), _2115 - vec2(0.5)) / _1819.xyxy;
    }
    else
    {
        if (vFormat == 0)
        {
            vec2 _1834 = vec2(textureSize(sColor0, 0));
            uint _2226 = uint(_1244.x);
            ivec2 _2233 = ivec2(int(_2226 % 1024u), int(_2226 / 1024u));
            vec4 _2217 = texelFetch(sGpuCache, _2233, 0);
            vec2 _2196 = _2217.xy;
            vec2 _2199 = _2217.zw;
            vec2 _2163 = mix(_2196, _2199, _1772);
            vec3 _2782 = vec3(_2163.x, _2163.y, _2801.z);
            _2782.z = texelFetch(sGpuCache, _2233 + ivec2(1, 0), 0).x;
            vec2 _2181 = _2782.xy / _1834;
            vUv_Y = vec3(_2181.x, _2181.y, _2782.z);
            vUvBounds_Y = vec4(_2196 + vec2(0.5), _2199 - vec2(0.5)) / _1834.xyxy;
            vec2 _1844 = vec2(textureSize(sColor1, 0));
            uint _2310 = uint(_1244.y);
            ivec2 _2317 = ivec2(int(_2310 % 1024u), int(_2310 / 1024u));
            vec4 _2301 = texelFetch(sGpuCache, _2317, 0);
            vec2 _2280 = _2301.xy;
            vec2 _2283 = _2301.zw;
            vec2 _2247 = mix(_2280, _2283, _1772);
            vec3 _2786 = vec3(_2247.x, _2247.y, _2801.z);
            _2786.z = texelFetch(sGpuCache, _2317 + ivec2(1, 0), 0).x;
            vec2 _2265 = _2786.xy / _1844;
            vUv_U = vec3(_2265.x, _2265.y, _2786.z);
            vUvBounds_U = vec4(_2280 + vec2(0.5), _2283 - vec2(0.5)) / _1844.xyxy;
        }
        else
        {
            if (vFormat == 2)
            {
                vec2 _1858 = vec2(textureSize(sColor0, 0));
                uint _2394 = uint(_1244.x);
                ivec2 _2401 = ivec2(int(_2394 % 1024u), int(_2394 / 1024u));
                vec4 _2385 = texelFetch(sGpuCache, _2401, 0);
                vec2 _2364 = _2385.xy;
                vec2 _2367 = _2385.zw;
                vec2 _2331 = mix(_2364, _2367, _1772);
                vec3 _2790 = vec3(_2331.x, _2331.y, _2801.z);
                _2790.z = texelFetch(sGpuCache, _2401 + ivec2(1, 0), 0).x;
                vec2 _2349 = _2790.xy / _1858;
                vUv_Y = vec3(_2349.x, _2349.y, _2790.z);
                vUvBounds_Y = vec4(_2364 + vec2(0.5), _2367 - vec2(0.5)) / _1858.xyxy;
            }
        }
    }
}

