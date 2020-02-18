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

mat4 _1953;

void main()
{
    int _985 = aData.z & 65535;
    int _989 = aData.z >> 16;
    uint _1009 = uint(aData.x);
    ivec2 _1017 = ivec2(int(2u * (_1009 % 512u)), int(_1009 / 512u));
    vec4 _1022 = texelFetch(sPrimitiveHeadersF, _1017, 0);
    ivec2 _1025 = _1017 + ivec2(1, 0);
    vec4 _1027 = texelFetch(sPrimitiveHeadersF, _1025, 0);
    vec2 _1029 = _1022.xy;
    vec2 _1031 = _1022.zw;
    vec2 _1035 = _1027.xy;
    vec2 _1037 = _1027.zw;
    ivec4 _1054 = texelFetch(sPrimitiveHeadersI, _1017, 0);
    float _1062 = float(_1054.x);
    int _1065 = _1054.y;
    int _1068 = _1054.z;
    vec2 _1955;
    vec2 _1956;
    vec4 _1962;
    if (_985 == 65535)
    {
        _1962 = vec4(0.0);
        _1956 = _1029;
        _1955 = _1031;
    }
    else
    {
        uint _1091 = uint((_1065 + 2) + (_985 * 2));
        ivec2 _1098 = ivec2(int(_1091 % 1024u), int(_1091 / 1024u));
        vec4 _1082 = texelFetch(sGpuCache, _1098, 0);
        _1962 = texelFetch(sGpuCache, _1098 + ivec2(1, 0), 0);
        _1956 = _1082.xy + _1029;
        _1955 = _1082.zw;
    }
    uint _1122 = uint(aData.y >> 16);
    ivec2 _1130 = ivec2(int(2u * (_1122 % 512u)), int(_1122 / 512u));
    vec4 _1140 = texelFetch(sRenderTasks, _1130 + ivec2(1, 0), 0);
    vec2 _1142 = texelFetch(sRenderTasks, _1130, 0).xy;
    float _1108 = _1140.y;
    vec2 _1111 = _1140.zw;
    uint _1236 = uint(_1068 & 16777215);
    ivec2 _1250 = ivec2(int(8u * (_1236 % 128u)), int(_1236 / 128u));
    mat4 _1928 = _1953;
    _1928[0] = texelFetch(sTransformPalette, _1250, 0);
    mat4 _1930 = _1928;
    _1930[1] = texelFetch(sTransformPalette, _1250 + ivec2(1, 0), 0);
    mat4 _1932 = _1930;
    _1932[2] = texelFetch(sTransformPalette, _1250 + ivec2(2, 0), 0);
    mat4 _1934 = _1932;
    _1934[3] = texelFetch(sTransformPalette, _1250 + ivec2(3, 0), 0);
    vec2 _1958;
    if ((_1068 >> 24) == 0)
    {
        vec2 _1369 = clamp(_1956 + (_1955 * aPosition.xy), _1035, _1035 + _1037);
        vec4 _1326 = _1934 * vec4(_1369, 0.0, 1.0);
        float _1342 = _1326.w;
        gl_Position = uTransform * vec4((_1326.xy * _1108) + (((-_1111) + _1142) * _1342), _1062 * _1342, _1342);
        _1958 = _1369;
    }
    else
    {
        bvec4 _807 = notEqual((ivec4(_989 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _810 = vec4(_807.x ? vec4(1.0).x : vec4(0.0).x, _807.y ? vec4(1.0).y : vec4(0.0).y, _807.z ? vec4(1.0).z : vec4(0.0).z, _807.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1519 = _1035 + _1037;
        vec4 _1426 = vec4(2.0) * _810;
        vec2 _1428 = _1426.xy;
        vec2 _1449 = (_1956 - _1428) + ((_1955 + (_1428 + _1426.zw)) * aPosition.xy);
        vec4 _1461 = _1934 * vec4(_1449, 0.0, 1.0);
        float _1469 = _1461.w;
        gl_Position = uTransform * vec4((_1461.xy * _1108) + ((_1142 - _1111) * _1469), _1062 * _1469, _1469);
        vTransformBounds = mix(vec4(clamp(_1029, _1035, _1519), clamp(_1029 + _1031, _1035, _1519)), vec4(clamp(_1956, _1035, _1519), clamp(_1956 + _1955, _1035, _1519)), _810);
        _1958 = _1449;
    }
    uint _1653 = uint(_1065);
    ivec2 _1660 = ivec2(int(_1653 % 1024u), int(_1653 / 1024u));
    vec4 _1644 = texelFetch(sGpuCache, _1660, 0);
    vec4 _1649 = texelFetch(sGpuCache, _1660 + ivec2(1, 0), 0);
    if ((((_989 >> 8) & 255) & 2) != 0)
    {
        vec2 _1565 = (_1958 - _1956) / _1955;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1565.x, _1565.y);
        vec2 _1578 = (varying_vec4_0.zw * (_1962.zw - _1962.xy)) + _1962.xy;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1578.x, _1578.y);
        vec2 _1585 = varying_vec4_0.zw * _1031;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1585.x, _1585.y);
    }
    else
    {
        vec2 _1592 = _1958 - _1029;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1592.x, _1592.y);
    }
    flat_varying_vec4_0 = vec4(_1644.x, _1644.y, flat_varying_vec4_0.z, flat_varying_vec4_0.w);
    flat_varying_vec4_0.z = _1644.z;
    flat_varying_vec4_1 = vec4(_1649.y, _1649.z, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
    flat_varying_highp_int_address_0 = texelFetch(sPrimitiveHeadersI, _1025, 0).x;
    flat_varying_vec4_1.z = float(int(_1649.x) != 0);
}

