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
out vec4 varying_vec4_0;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
flat out int flat_varying_highp_int_address_0;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_1;

mat4 _2529;

void main()
{
    int _1006 = aData.z & 65535;
    int _1010 = aData.z >> 16;
    uint _1030 = uint(aData.x);
    ivec2 _1038 = ivec2(int(2u * (_1030 % 512u)), int(_1030 / 512u));
    vec4 _1043 = texelFetch(sPrimitiveHeadersF, _1038, 0);
    ivec2 _1046 = _1038 + ivec2(1, 0);
    vec4 _1048 = texelFetch(sPrimitiveHeadersF, _1046, 0);
    vec2 _1050 = _1043.xy;
    vec2 _1052 = _1043.zw;
    vec2 _1056 = _1048.xy;
    vec2 _1058 = _1048.zw;
    ivec4 _1075 = texelFetch(sPrimitiveHeadersI, _1038, 0);
    float _1083 = float(_1075.x);
    int _1086 = _1075.y;
    int _1089 = _1075.z;
    vec2 _2451;
    vec2 _2453;
    vec4 _2495;
    if (_1006 == 65535)
    {
        _2495 = vec4(0.0);
        _2453 = _1050;
        _2451 = _1052;
    }
    else
    {
        uint _1112 = uint((_1086 + 2) + (_1006 * 2));
        ivec2 _1119 = ivec2(int(_1112 % 1024u), int(_1112 / 1024u));
        vec4 _1103 = texelFetch(sGpuCache, _1119, 0);
        _2495 = texelFetch(sGpuCache, _1119 + ivec2(1, 0), 0);
        _2453 = _1103.xy + _1050;
        _2451 = _1103.zw;
    }
    uint _1143 = uint(aData.y >> 16);
    ivec2 _1151 = ivec2(int(2u * (_1143 % 512u)), int(_1143 / 512u));
    vec4 _1161 = texelFetch(sRenderTasks, _1151 + ivec2(1, 0), 0);
    vec2 _1163 = texelFetch(sRenderTasks, _1151, 0).xy;
    float _1129 = _1161.y;
    vec2 _1132 = _1161.zw;
    uint _1257 = uint(_1089 & 16777215);
    ivec2 _1271 = ivec2(int(8u * (_1257 % 128u)), int(_1257 / 128u));
    mat4 _2510 = _2529;
    _2510[0] = texelFetch(sTransformPalette, _1271, 0);
    mat4 _2512 = _2510;
    _2512[1] = texelFetch(sTransformPalette, _1271 + ivec2(1, 0), 0);
    mat4 _2514 = _2512;
    _2514[2] = texelFetch(sTransformPalette, _1271 + ivec2(2, 0), 0);
    mat4 _2516 = _2514;
    _2516[3] = texelFetch(sTransformPalette, _1271 + ivec2(3, 0), 0);
    vec2 _2470;
    if ((_1089 >> 24) == 0)
    {
        vec2 _1390 = clamp(_2453 + (_2451 * aPosition.xy), _1056, _1056 + _1058);
        vec4 _1347 = _2516 * vec4(_1390, 0.0, 1.0);
        float _1363 = _1347.w;
        gl_Position = uTransform * vec4((_1347.xy * _1129) + (((-_1132) + _1163) * _1363), _1083 * _1363, _1363);
        _2470 = _1390;
    }
    else
    {
        bvec4 _807 = notEqual((ivec4(_1010 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _810 = vec4(_807.x ? vec4(1.0).x : vec4(0.0).x, _807.y ? vec4(1.0).y : vec4(0.0).y, _807.z ? vec4(1.0).z : vec4(0.0).z, _807.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1540 = _1056 + _1058;
        vec4 _1447 = vec4(2.0) * _810;
        vec2 _1449 = _1447.xy;
        vec2 _1470 = (_2453 - _1449) + ((_2451 + (_1449 + _1447.zw)) * aPosition.xy);
        vec4 _1482 = _2516 * vec4(_1470, 0.0, 1.0);
        float _1490 = _1482.w;
        gl_Position = uTransform * vec4((_1482.xy * _1129) + ((_1163 - _1132) * _1490), _1083 * _1490, _1490);
        vTransformBounds = mix(vec4(clamp(_1050, _1056, _1540), clamp(_1050 + _1052, _1056, _1540)), vec4(clamp(_2453, _1056, _1540), clamp(_2453 + _2451, _1056, _1540)), _810);
        _2470 = _1470;
    }
    uint _1695 = uint(_1086);
    ivec2 _1702 = ivec2(int(_1695 % 1024u), int(_1695 / 1024u));
    vec4 _1686 = texelFetch(sGpuCache, _1702, 0);
    vec4 _1691 = texelFetch(sGpuCache, _1702 + ivec2(1, 0), 0);
    float _1669 = _1691.x;
    if ((((_1010 >> 8) & 255) & 2) != 0)
    {
        vec2 _1586 = (_2470 - _2453) / _2451;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1586.x, _1586.y);
        vec2 _1599 = (varying_vec4_0.zw * (_2495.zw - _2495.xy)) + _2495.xy;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1599.x, _1599.y);
        vec2 _1606 = varying_vec4_0.zw * _1052;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1606.x, _1606.y);
    }
    else
    {
        vec2 _1613 = _2470 - _1050;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1613.x, _1613.y);
    }
    flat_varying_vec4_0 = vec4(_1686.x, _1686.y, flat_varying_vec4_0.z, flat_varying_vec4_0.w);
    flat_varying_vec4_0.z = _1686.z;
    flat_varying_vec4_0.w = _1686.w;
    varying_vec4_0.w *= _1669;
    flat_varying_vec4_0.y *= _1669;
    flat_varying_vec4_1 = vec4(_1691.z, _1691.w, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
    flat_varying_vec4_1.y *= _1669;
    flat_varying_highp_int_address_0 = texelFetch(sPrimitiveHeadersI, _1046, 0).x;
    flat_varying_vec4_1.z = float(int(_1691.y) != 0);
}

