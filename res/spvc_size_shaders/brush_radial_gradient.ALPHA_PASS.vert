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

mat4 _2688;

void main()
{
    int _1060 = aData.y & 65535;
    int _1064 = aData.z & 65535;
    int _1068 = aData.z >> 16;
    uint _1088 = uint(aData.x);
    ivec2 _1096 = ivec2(int(2u * (_1088 % 512u)), int(_1088 / 512u));
    vec4 _1101 = texelFetch(sPrimitiveHeadersF, _1096, 0);
    ivec2 _1104 = _1096 + ivec2(1, 0);
    vec4 _1106 = texelFetch(sPrimitiveHeadersF, _1104, 0);
    vec2 _1108 = _1101.xy;
    vec2 _1110 = _1101.zw;
    vec2 _1114 = _1106.xy;
    vec2 _1116 = _1106.zw;
    ivec4 _1133 = texelFetch(sPrimitiveHeadersI, _1096, 0);
    float _1141 = float(_1133.x);
    int _1144 = _1133.y;
    int _1147 = _1133.z;
    vec2 _2599;
    vec2 _2601;
    vec4 _2648;
    if (_1064 == 65535)
    {
        _2648 = vec4(0.0);
        _2601 = _1108;
        _2599 = _1110;
    }
    else
    {
        uint _1170 = uint((_1144 + 2) + (_1064 * 2));
        ivec2 _1177 = ivec2(int(_1170 % 1024u), int(_1170 / 1024u));
        vec4 _1161 = texelFetch(sGpuCache, _1177, 0);
        _2648 = texelFetch(sGpuCache, _1177 + ivec2(1, 0), 0);
        _2601 = _1161.xy + _1108;
        _2599 = _1161.zw;
    }
    uint _1201 = uint(aData.y >> 16);
    ivec2 _1209 = ivec2(int(2u * (_1201 % 512u)), int(_1201 / 512u));
    vec4 _1219 = texelFetch(sRenderTasks, _1209 + ivec2(1, 0), 0);
    vec2 _1221 = texelFetch(sRenderTasks, _1209, 0).xy;
    float _1187 = _1219.y;
    vec2 _1190 = _1219.zw;
    vec2 _2589;
    float _2590;
    float _2591;
    vec2 _2592;
    vec2 _2593;
    if (_1060 >= 32767)
    {
        _2593 = vec2(0.0);
        _2592 = vec2(0.0);
        _2591 = 0.0;
        _2590 = 0.0;
        _2589 = vec2(0.0);
    }
    else
    {
        uint _1270 = uint(_1060);
        ivec2 _1278 = ivec2(int(2u * (_1270 % 512u)), int(_1270 / 512u));
        vec4 _1283 = texelFetch(sRenderTasks, _1278, 0);
        vec4 _1288 = texelFetch(sRenderTasks, _1278 + ivec2(1, 0), 0);
        _2593 = _1283.xy;
        _2592 = _1283.zw;
        _2591 = _1288.x;
        _2590 = _1288.y;
        _2589 = _1288.zw;
    }
    uint _1315 = uint(_1147 & 16777215);
    ivec2 _1329 = ivec2(int(8u * (_1315 % 128u)), int(_1315 / 128u));
    mat4 _2666 = _2688;
    _2666[0] = texelFetch(sTransformPalette, _1329, 0);
    mat4 _2668 = _2666;
    _2668[1] = texelFetch(sTransformPalette, _1329 + ivec2(1, 0), 0);
    mat4 _2670 = _2668;
    _2670[2] = texelFetch(sTransformPalette, _1329 + ivec2(2, 0), 0);
    mat4 _2672 = _2670;
    _2672[3] = texelFetch(sTransformPalette, _1329 + ivec2(3, 0), 0);
    vec4 _2617;
    vec2 _2623;
    if ((_1147 >> 24) == 0)
    {
        vec2 _1448 = clamp(_2601 + (_2599 * aPosition.xy), _1114, _1114 + _1116);
        vec4 _1405 = _2672 * vec4(_1448, 0.0, 1.0);
        float _1421 = _1405.w;
        gl_Position = uTransform * vec4((_1405.xy * _1187) + (((-_1190) + _1221) * _1421), _1141 * _1421, _1421);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _2623 = _1448;
        _2617 = _1405;
    }
    else
    {
        bvec4 _854 = notEqual((ivec4(_1068 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _857 = vec4(_854.x ? vec4(1.0).x : vec4(0.0).x, _854.y ? vec4(1.0).y : vec4(0.0).y, _854.z ? vec4(1.0).z : vec4(0.0).z, _854.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1599 = _1114 + _1116;
        vec4 _1506 = vec4(2.0) * _857;
        vec2 _1508 = _1506.xy;
        vec2 _1529 = (_2601 - _1508) + ((_2599 + (_1508 + _1506.zw)) * aPosition.xy);
        vec4 _1541 = _2672 * vec4(_1529, 0.0, 1.0);
        float _1549 = _1541.w;
        gl_Position = uTransform * vec4((_1541.xy * _1187) + ((_1221 - _1190) * _1549), _1141 * _1549, _1549);
        vTransformBounds = mix(vec4(clamp(_1108, _1114, _1599), clamp(_1108 + _1110, _1114, _1599)), vec4(clamp(_2601, _1114, _1599), clamp(_2601 + _2599, _1114, _1599)), _857);
        _2623 = _1529;
        _2617 = _1541;
    }
    vClipMaskUvBounds = vec4(_2593, _2593 + _2592);
    vClipMaskUv = vec4((_2617.xy * _2590) + ((_2593 - _2589) * _2617.w), _2591, _2617.w);
    uint _1796 = uint(_1144);
    ivec2 _1803 = ivec2(int(_1796 % 1024u), int(_1796 / 1024u));
    vec4 _1787 = texelFetch(sGpuCache, _1803, 0);
    vec4 _1792 = texelFetch(sGpuCache, _1803 + ivec2(1, 0), 0);
    float _1770 = _1792.x;
    if ((((_1068 >> 8) & 255) & 2) != 0)
    {
        vec2 _1680 = (_2623 - _2601) / _2599;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1680.x, _1680.y);
        vec2 _1693 = (varying_vec4_0.zw * (_2648.zw - _2648.xy)) + _2648.xy;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1693.x, _1693.y);
        vec2 _1700 = varying_vec4_0.zw * _1110;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1700.x, _1700.y);
    }
    else
    {
        vec2 _1707 = _2623 - _1108;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1707.x, _1707.y);
    }
    flat_varying_vec4_0 = vec4(_1787.x, _1787.y, flat_varying_vec4_0.z, flat_varying_vec4_0.w);
    flat_varying_vec4_0.z = _1787.z;
    flat_varying_vec4_0.w = _1787.w;
    vec2 _1725 = _1110 / _1792.zw;
    varying_vec4_0.w *= _1770;
    flat_varying_vec4_0.y *= _1770;
    flat_varying_vec4_1 = vec4(_1792.z, _1792.w, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
    flat_varying_vec4_1.y *= _1770;
    flat_varying_highp_int_address_0 = texelFetch(sPrimitiveHeadersI, _1104, 0).x;
    flat_varying_vec4_1.z = float(int(_1792.y) != 0);
    flat_varying_vec4_2 = vec4(_1725.x, _1725.y, flat_varying_vec4_2.z, flat_varying_vec4_2.w);
    varying_vec4_0 = vec4(_2623.x, _2623.y, varying_vec4_0.z, varying_vec4_0.w);
}

