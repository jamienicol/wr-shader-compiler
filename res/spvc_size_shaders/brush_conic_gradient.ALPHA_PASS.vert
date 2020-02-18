#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform mat4 uTransform;

flat out vec4 vTransformBounds;
layout(location = 1) in ivec4 aData;
layout(location = 0) in vec3 aPosition;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
out vec4 varying_vec4_0;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
flat out int flat_varying_highp_int_address_0;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_1;

mat4 _2643;

void main()
{
    int _1039 = aData.y & 65535;
    int _1043 = aData.z & 65535;
    int _1047 = aData.z >> 16;
    uint _1067 = uint(aData.x);
    ivec2 _1075 = ivec2(int(2u * (_1067 % 512u)), int(_1067 / 512u));
    vec4 _1080 = texelFetch(sPrimitiveHeadersF, _1075, 0);
    ivec2 _1083 = _1075 + ivec2(1, 0);
    vec4 _1085 = texelFetch(sPrimitiveHeadersF, _1083, 0);
    vec2 _1087 = _1080.xy;
    vec2 _1089 = _1080.zw;
    vec2 _1093 = _1085.xy;
    vec2 _1095 = _1085.zw;
    ivec4 _1112 = texelFetch(sPrimitiveHeadersI, _1075, 0);
    float _1120 = float(_1112.x);
    int _1123 = _1112.y;
    int _1126 = _1112.z;
    vec2 _2555;
    vec2 _2557;
    vec4 _2604;
    if (_1043 == 65535)
    {
        _2604 = vec4(0.0);
        _2557 = _1087;
        _2555 = _1089;
    }
    else
    {
        uint _1149 = uint((_1123 + 2) + (_1043 * 2));
        ivec2 _1156 = ivec2(int(_1149 % 1024u), int(_1149 / 1024u));
        vec4 _1140 = texelFetch(sGpuCache, _1156, 0);
        _2604 = texelFetch(sGpuCache, _1156 + ivec2(1, 0), 0);
        _2557 = _1140.xy + _1087;
        _2555 = _1140.zw;
    }
    uint _1180 = uint(aData.y >> 16);
    ivec2 _1188 = ivec2(int(2u * (_1180 % 512u)), int(_1180 / 512u));
    vec4 _1198 = texelFetch(sRenderTasks, _1188 + ivec2(1, 0), 0);
    vec2 _1200 = texelFetch(sRenderTasks, _1188, 0).xy;
    float _1166 = _1198.y;
    vec2 _1169 = _1198.zw;
    vec2 _2545;
    float _2546;
    float _2547;
    vec2 _2548;
    vec2 _2549;
    if (_1039 >= 32767)
    {
        _2549 = vec2(0.0);
        _2548 = vec2(0.0);
        _2547 = 0.0;
        _2546 = 0.0;
        _2545 = vec2(0.0);
    }
    else
    {
        uint _1249 = uint(_1039);
        ivec2 _1257 = ivec2(int(2u * (_1249 % 512u)), int(_1249 / 512u));
        vec4 _1262 = texelFetch(sRenderTasks, _1257, 0);
        vec4 _1267 = texelFetch(sRenderTasks, _1257 + ivec2(1, 0), 0);
        _2549 = _1262.xy;
        _2548 = _1262.zw;
        _2547 = _1267.x;
        _2546 = _1267.y;
        _2545 = _1267.zw;
    }
    uint _1294 = uint(_1126 & 16777215);
    ivec2 _1308 = ivec2(int(8u * (_1294 % 128u)), int(_1294 / 128u));
    mat4 _2623 = _2643;
    _2623[0] = texelFetch(sTransformPalette, _1308, 0);
    mat4 _2625 = _2623;
    _2625[1] = texelFetch(sTransformPalette, _1308 + ivec2(1, 0), 0);
    mat4 _2627 = _2625;
    _2627[2] = texelFetch(sTransformPalette, _1308 + ivec2(2, 0), 0);
    mat4 _2629 = _2627;
    _2629[3] = texelFetch(sTransformPalette, _1308 + ivec2(3, 0), 0);
    vec4 _2573;
    vec2 _2579;
    if ((_1126 >> 24) == 0)
    {
        vec2 _1427 = clamp(_2557 + (_2555 * aPosition.xy), _1093, _1093 + _1095);
        vec4 _1384 = _2629 * vec4(_1427, 0.0, 1.0);
        float _1400 = _1384.w;
        gl_Position = uTransform * vec4((_1384.xy * _1166) + (((-_1169) + _1200) * _1400), _1120 * _1400, _1400);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _2579 = _1427;
        _2573 = _1384;
    }
    else
    {
        bvec4 _854 = notEqual((ivec4(_1047 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _857 = vec4(_854.x ? vec4(1.0).x : vec4(0.0).x, _854.y ? vec4(1.0).y : vec4(0.0).y, _854.z ? vec4(1.0).z : vec4(0.0).z, _854.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1578 = _1093 + _1095;
        vec4 _1485 = vec4(2.0) * _857;
        vec2 _1487 = _1485.xy;
        vec2 _1508 = (_2557 - _1487) + ((_2555 + (_1487 + _1485.zw)) * aPosition.xy);
        vec4 _1520 = _2629 * vec4(_1508, 0.0, 1.0);
        float _1528 = _1520.w;
        gl_Position = uTransform * vec4((_1520.xy * _1166) + ((_1200 - _1169) * _1528), _1120 * _1528, _1528);
        vTransformBounds = mix(vec4(clamp(_1087, _1093, _1578), clamp(_1087 + _1089, _1093, _1578)), vec4(clamp(_2557, _1093, _1578), clamp(_2557 + _2555, _1093, _1578)), _857);
        _2579 = _1508;
        _2573 = _1520;
    }
    vClipMaskUvBounds = vec4(_2549, _2549 + _2548);
    vClipMaskUv = vec4((_2573.xy * _2546) + ((_2549 - _2545) * _2573.w), _2547, _2573.w);
    uint _1754 = uint(_1123);
    ivec2 _1761 = ivec2(int(_1754 % 1024u), int(_1754 / 1024u));
    vec4 _1745 = texelFetch(sGpuCache, _1761, 0);
    vec4 _1750 = texelFetch(sGpuCache, _1761 + ivec2(1, 0), 0);
    if ((((_1047 >> 8) & 255) & 2) != 0)
    {
        vec2 _1659 = (_2579 - _2557) / _2555;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1659.x, _1659.y);
        vec2 _1672 = (varying_vec4_0.zw * (_2604.zw - _2604.xy)) + _2604.xy;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1672.x, _1672.y);
        vec2 _1679 = varying_vec4_0.zw * _1089;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1679.x, _1679.y);
    }
    else
    {
        vec2 _1686 = _2579 - _1087;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1686.x, _1686.y);
    }
    flat_varying_vec4_0 = vec4(_1745.x, _1745.y, flat_varying_vec4_0.z, flat_varying_vec4_0.w);
    flat_varying_vec4_0.z = _1745.z;
    vec2 _1700 = _1089 / _1750.yz;
    flat_varying_vec4_1 = vec4(_1750.y, _1750.z, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
    flat_varying_highp_int_address_0 = texelFetch(sPrimitiveHeadersI, _1083, 0).x;
    flat_varying_vec4_1.z = float(int(_1750.x) != 0);
    flat_varying_vec4_2 = vec4(_1700.x, _1700.y, flat_varying_vec4_2.z, flat_varying_vec4_2.w);
    varying_vec4_0 = vec4(_2579.x, _2579.y, varying_vec4_0.z, varying_vec4_0.w);
}

