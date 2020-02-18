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

mat4 _2245;

void main()
{
    int _1127 = aData.z & 65535;
    int _1131 = aData.z >> 16;
    int _774 = (_1131 >> 8) & 255;
    uint _1151 = uint(aData.x);
    ivec2 _1159 = ivec2(int(2u * (_1151 % 512u)), int(_1151 / 512u));
    vec4 _1164 = texelFetch(sPrimitiveHeadersF, _1159, 0);
    vec4 _1169 = texelFetch(sPrimitiveHeadersF, _1159 + ivec2(1, 0), 0);
    vec2 _1171 = _1164.xy;
    vec2 _1173 = _1164.zw;
    vec2 _1177 = _1169.xy;
    vec2 _1179 = _1169.zw;
    ivec4 _1196 = texelFetch(sPrimitiveHeadersI, _1159, 0);
    float _1204 = float(_1196.x);
    int _1207 = _1196.y;
    int _1210 = _1196.z;
    vec2 _2247;
    vec2 _2248;
    vec4 _2254;
    if (_1127 == 65535)
    {
        _2254 = vec4(0.0);
        _2248 = _1171;
        _2247 = _1173;
    }
    else
    {
        uint _1233 = uint((_1207 + 3) + (_1127 * 2));
        ivec2 _1240 = ivec2(int(_1233 % 1024u), int(_1233 / 1024u));
        vec4 _1224 = texelFetch(sGpuCache, _1240, 0);
        _2254 = texelFetch(sGpuCache, _1240 + ivec2(1, 0), 0);
        _2248 = _1224.xy + _1171;
        _2247 = _1224.zw;
    }
    uint _1264 = uint(aData.y >> 16);
    ivec2 _1272 = ivec2(int(2u * (_1264 % 512u)), int(_1264 / 512u));
    vec4 _1282 = texelFetch(sRenderTasks, _1272 + ivec2(1, 0), 0);
    vec2 _1284 = texelFetch(sRenderTasks, _1272, 0).xy;
    float _1250 = _1282.y;
    vec2 _1253 = _1282.zw;
    uint _1378 = uint(_1210 & 16777215);
    ivec2 _1392 = ivec2(int(8u * (_1378 % 128u)), int(_1378 / 128u));
    mat4 _2220 = _2245;
    _2220[0] = texelFetch(sTransformPalette, _1392, 0);
    mat4 _2222 = _2220;
    _2222[1] = texelFetch(sTransformPalette, _1392 + ivec2(1, 0), 0);
    mat4 _2224 = _2222;
    _2224[2] = texelFetch(sTransformPalette, _1392 + ivec2(2, 0), 0);
    mat4 _2226 = _2224;
    _2226[3] = texelFetch(sTransformPalette, _1392 + ivec2(3, 0), 0);
    vec4 _2249;
    vec2 _2250;
    if ((_1210 >> 24) == 0)
    {
        vec2 _1511 = clamp(_2248 + (_2247 * aPosition.xy), _1177, _1177 + _1179);
        vec4 _1468 = _2226 * vec4(_1511, 0.0, 1.0);
        float _1484 = _1468.w;
        gl_Position = uTransform * vec4((_1468.xy * _1250) + (((-_1253) + _1284) * _1484), _1204 * _1484, _1484);
        _2250 = _1511;
        _2249 = _1468;
    }
    else
    {
        bvec4 _860 = notEqual((ivec4(_1131 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _863 = vec4(_860.x ? vec4(1.0).x : vec4(0.0).x, _860.y ? vec4(1.0).y : vec4(0.0).y, _860.z ? vec4(1.0).z : vec4(0.0).z, _860.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1661 = _1177 + _1179;
        vec4 _1568 = vec4(2.0) * _863;
        vec2 _1570 = _1568.xy;
        vec2 _1591 = (_2248 - _1570) + ((_2247 + (_1570 + _1568.zw)) * aPosition.xy);
        vec4 _1603 = _2226 * vec4(_1591, 0.0, 1.0);
        float _1611 = _1603.w;
        gl_Position = uTransform * vec4((_1603.xy * _1250) + ((_1284 - _1253) * _1611), _1204 * _1611, _1611);
        vTransformBounds = mix(vec4(clamp(_1171, _1177, _1661), clamp(_1171 + _1173, _1177, _1661)), vec4(clamp(_2248, _1177, _1661), clamp(_2248 + _2247, _1177, _1661)), _863);
        _2250 = _1591;
        _2249 = _1603;
    }
    uint _1883 = uint(_1207);
    vec4 _1879 = texelFetch(sGpuCache, ivec2(int(_1883 % 1024u), int(_1883 / 1024u)) + ivec2(2, 0), 0);
    vec2 _1857 = _1879.xy;
    vec2 _1713 = vec2(vec3(textureSize(sColor0, 0)).xy);
    uint _1929 = uint(aData.w & 16777215);
    ivec2 _1936 = ivec2(int(_1929 % 1024u), int(_1929 / 1024u));
    vec4 _1920 = texelFetch(sGpuCache, _1936, 0);
    vec2 _1899 = _1920.xy;
    vec2 _1902 = _1920.zw;
    bvec2 _2273 = bvec2(_1879.x < 0.0);
    vec2 _2274 = vec2(_2273.x ? _1173.x : _1857.x, _2273.y ? _1173.y : _1857.y);
    bool _1732 = (_774 & 2) != 0;
    vec2 _2255;
    vec2 _2258;
    if (_1732)
    {
        vec2 _2257;
        vec2 _2260;
        if ((_774 & 128) != 0)
        {
            vec2 _1747 = _1902 - _1899;
            _2260 = _1899 + (_2254.zw * _1747);
            _2257 = _1899 + (_2254.xy * _1747);
        }
        else
        {
            _2260 = _1902;
            _2257 = _1899;
        }
        _2258 = _2260;
        _2255 = _2257;
    }
    else
    {
        _2258 = _1902;
        _2255 = _1899;
    }
    bvec2 _2275 = bvec2(_1732);
    vec2 _2278 = vec2(_2275.x ? _2247.x : _1173.x, _2275.y ? _2247.y : _1173.y);
    float _1768 = float((_774 & 1) != 0);
    flat_varying_vec4_4.x = texelFetch(sGpuCache, _1936 + ivec2(1, 0), 0).x;
    flat_varying_vec4_4.y = _1768;
    vec2 _1776 = min(_2255, _2258);
    vec2 _1779 = max(_2255, _2258);
    vec4 _1790 = _1713.xyxy;
    flat_varying_vec4_3 = vec4(_1776 + vec2(0.5), _1779 - vec2(0.5)) / _1790;
    vec2 _1809 = mix(_2255, _2258, (_2250 - vec2(_2275.x ? _2248.x : _1171.x, _2275.y ? _2248.y : _1171.y)) / _2278) - _1776;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1809.x, _1809.y);
    vec2 _1815 = varying_vec4_0.zw / _1713;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1815.x, _1815.y);
    vec2 _1821 = varying_vec4_0.zw * (_2278 / vec2(_2275.x ? _2247.x : _2274.x, _2275.y ? _2247.y : _2274.y));
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1821.x, _1821.y);
    if (_1768 == 0.0)
    {
        vec2 _1832 = varying_vec4_0.zw * _2249.w;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1832.x, _1832.y);
    }
    flat_varying_vec4_2 = vec4(_1776, _1779) / _1790;
}

