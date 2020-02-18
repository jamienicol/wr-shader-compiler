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

mat4 _2661;

void main()
{
    int _1052 = aData.y & 65535;
    int _1056 = aData.z & 65535;
    int _1060 = aData.z >> 16;
    uint _1080 = uint(aData.x);
    ivec2 _1088 = ivec2(int(2u * (_1080 % 512u)), int(_1080 / 512u));
    vec4 _1093 = texelFetch(sPrimitiveHeadersF, _1088, 0);
    ivec2 _1096 = _1088 + ivec2(1, 0);
    vec4 _1098 = texelFetch(sPrimitiveHeadersF, _1096, 0);
    vec2 _1100 = _1093.xy;
    vec2 _1102 = _1093.zw;
    vec2 _1106 = _1098.xy;
    vec2 _1108 = _1098.zw;
    ivec4 _1125 = texelFetch(sPrimitiveHeadersI, _1088, 0);
    float _1133 = float(_1125.x);
    int _1136 = _1125.y;
    int _1139 = _1125.z;
    vec2 _2575;
    vec2 _2577;
    vec4 _2624;
    if (_1056 == 65535)
    {
        _2624 = vec4(0.0);
        _2577 = _1100;
        _2575 = _1102;
    }
    else
    {
        uint _1162 = uint((_1136 + 2) + (_1056 * 2));
        ivec2 _1169 = ivec2(int(_1162 % 1024u), int(_1162 / 1024u));
        vec4 _1153 = texelFetch(sGpuCache, _1169, 0);
        _2624 = texelFetch(sGpuCache, _1169 + ivec2(1, 0), 0);
        _2577 = _1153.xy + _1100;
        _2575 = _1153.zw;
    }
    uint _1193 = uint(aData.y >> 16);
    ivec2 _1201 = ivec2(int(2u * (_1193 % 512u)), int(_1193 / 512u));
    vec4 _1211 = texelFetch(sRenderTasks, _1201 + ivec2(1, 0), 0);
    vec2 _1213 = texelFetch(sRenderTasks, _1201, 0).xy;
    float _1179 = _1211.y;
    vec2 _1182 = _1211.zw;
    vec2 _2565;
    float _2566;
    float _2567;
    vec2 _2568;
    vec2 _2569;
    if (_1052 >= 32767)
    {
        _2569 = vec2(0.0);
        _2568 = vec2(0.0);
        _2567 = 0.0;
        _2566 = 0.0;
        _2565 = vec2(0.0);
    }
    else
    {
        uint _1262 = uint(_1052);
        ivec2 _1270 = ivec2(int(2u * (_1262 % 512u)), int(_1262 / 512u));
        vec4 _1275 = texelFetch(sRenderTasks, _1270, 0);
        vec4 _1280 = texelFetch(sRenderTasks, _1270 + ivec2(1, 0), 0);
        _2569 = _1275.xy;
        _2568 = _1275.zw;
        _2567 = _1280.x;
        _2566 = _1280.y;
        _2565 = _1280.zw;
    }
    uint _1307 = uint(_1139 & 16777215);
    ivec2 _1321 = ivec2(int(8u * (_1307 % 128u)), int(_1307 / 128u));
    mat4 _2642 = _2661;
    _2642[0] = texelFetch(sTransformPalette, _1321, 0);
    mat4 _2644 = _2642;
    _2644[1] = texelFetch(sTransformPalette, _1321 + ivec2(1, 0), 0);
    mat4 _2646 = _2644;
    _2646[2] = texelFetch(sTransformPalette, _1321 + ivec2(2, 0), 0);
    mat4 _2648 = _2646;
    _2648[3] = texelFetch(sTransformPalette, _1321 + ivec2(3, 0), 0);
    vec4 _2593;
    vec2 _2599;
    if ((_1139 >> 24) == 0)
    {
        vec2 _1440 = clamp(_2577 + (_2575 * aPosition.xy), _1106, _1106 + _1108);
        vec4 _1397 = _2648 * vec4(_1440, 0.0, 1.0);
        float _1413 = _1397.w;
        gl_Position = uTransform * vec4((_1397.xy * _1179) + (((-_1182) + _1213) * _1413), _1133 * _1413, _1413);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _2599 = _1440;
        _2593 = _1397;
    }
    else
    {
        bvec4 _854 = notEqual((ivec4(_1060 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _857 = vec4(_854.x ? vec4(1.0).x : vec4(0.0).x, _854.y ? vec4(1.0).y : vec4(0.0).y, _854.z ? vec4(1.0).z : vec4(0.0).z, _854.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1591 = _1106 + _1108;
        vec4 _1498 = vec4(2.0) * _857;
        vec2 _1500 = _1498.xy;
        vec2 _1521 = (_2577 - _1500) + ((_2575 + (_1500 + _1498.zw)) * aPosition.xy);
        vec4 _1533 = _2648 * vec4(_1521, 0.0, 1.0);
        float _1541 = _1533.w;
        gl_Position = uTransform * vec4((_1533.xy * _1179) + ((_1213 - _1182) * _1541), _1133 * _1541, _1541);
        vTransformBounds = mix(vec4(clamp(_1100, _1106, _1591), clamp(_1100 + _1102, _1106, _1591)), vec4(clamp(_2577, _1106, _1591), clamp(_2577 + _2575, _1106, _1591)), _857);
        _2599 = _1521;
        _2593 = _1533;
    }
    vClipMaskUvBounds = vec4(_2569, _2569 + _2568);
    vClipMaskUv = vec4((_2593.xy * _2566) + ((_2569 - _2565) * _2593.w), _2567, _2593.w);
    uint _1780 = uint(_1136);
    ivec2 _1787 = ivec2(int(_1780 % 1024u), int(_1780 / 1024u));
    vec4 _1771 = texelFetch(sGpuCache, _1787, 0);
    vec4 _1776 = texelFetch(sGpuCache, _1787 + ivec2(1, 0), 0);
    if ((((_1060 >> 8) & 255) & 2) != 0)
    {
        vec2 _1675 = (_2599 - _2577) / _2575;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1675.x, _1675.y);
        vec2 _1688 = (varying_vec4_0.zw * (_2624.zw - _2624.xy)) + _2624.xy;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1688.x, _1688.y);
        vec2 _1695 = varying_vec4_0.zw * _1102;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1695.x, _1695.y);
    }
    else
    {
        vec2 _1702 = _2599 - _1100;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1702.x, _1702.y);
    }
    vec2 _1713 = _1771.zw - _1771.xy;
    flat_varying_vec4_0 = vec4(_1771.x, _1771.y, flat_varying_vec4_0.z, flat_varying_vec4_0.w);
    vec2 _1722 = _1713 / vec2(dot(_1713, _1713));
    flat_varying_vec4_0 = vec4(flat_varying_vec4_0.x, flat_varying_vec4_0.y, _1722.x, _1722.y);
    vec2 _1729 = _1102 / _1776.yz;
    flat_varying_vec4_1 = vec4(_1776.y, _1776.z, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
    flat_varying_highp_int_address_0 = texelFetch(sPrimitiveHeadersI, _1096, 0).x;
    flat_varying_vec4_1.z = float(int(_1776.x) != 0);
    flat_varying_vec4_2 = vec4(_1729.x, _1729.y, flat_varying_vec4_2.z, flat_varying_vec4_2.w);
    varying_vec4_0 = vec4(_2599.x, _2599.y, varying_vec4_0.z, varying_vec4_0.w);
}

