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

mat4 _1975;

void main()
{
    int _998 = aData.z & 65535;
    int _1002 = aData.z >> 16;
    uint _1022 = uint(aData.x);
    ivec2 _1030 = ivec2(int(2u * (_1022 % 512u)), int(_1022 / 512u));
    vec4 _1035 = texelFetch(sPrimitiveHeadersF, _1030, 0);
    ivec2 _1038 = _1030 + ivec2(1, 0);
    vec4 _1040 = texelFetch(sPrimitiveHeadersF, _1038, 0);
    vec2 _1042 = _1035.xy;
    vec2 _1044 = _1035.zw;
    vec2 _1048 = _1040.xy;
    vec2 _1050 = _1040.zw;
    ivec4 _1067 = texelFetch(sPrimitiveHeadersI, _1030, 0);
    float _1075 = float(_1067.x);
    int _1078 = _1067.y;
    int _1081 = _1067.z;
    vec2 _1977;
    vec2 _1978;
    vec4 _1984;
    if (_998 == 65535)
    {
        _1984 = vec4(0.0);
        _1978 = _1042;
        _1977 = _1044;
    }
    else
    {
        uint _1104 = uint((_1078 + 2) + (_998 * 2));
        ivec2 _1111 = ivec2(int(_1104 % 1024u), int(_1104 / 1024u));
        vec4 _1095 = texelFetch(sGpuCache, _1111, 0);
        _1984 = texelFetch(sGpuCache, _1111 + ivec2(1, 0), 0);
        _1978 = _1095.xy + _1042;
        _1977 = _1095.zw;
    }
    uint _1135 = uint(aData.y >> 16);
    ivec2 _1143 = ivec2(int(2u * (_1135 % 512u)), int(_1135 / 512u));
    vec4 _1153 = texelFetch(sRenderTasks, _1143 + ivec2(1, 0), 0);
    vec2 _1155 = texelFetch(sRenderTasks, _1143, 0).xy;
    float _1121 = _1153.y;
    vec2 _1124 = _1153.zw;
    uint _1249 = uint(_1081 & 16777215);
    ivec2 _1263 = ivec2(int(8u * (_1249 % 128u)), int(_1249 / 128u));
    mat4 _1951 = _1975;
    _1951[0] = texelFetch(sTransformPalette, _1263, 0);
    mat4 _1953 = _1951;
    _1953[1] = texelFetch(sTransformPalette, _1263 + ivec2(1, 0), 0);
    mat4 _1955 = _1953;
    _1955[2] = texelFetch(sTransformPalette, _1263 + ivec2(2, 0), 0);
    mat4 _1957 = _1955;
    _1957[3] = texelFetch(sTransformPalette, _1263 + ivec2(3, 0), 0);
    vec2 _1980;
    if ((_1081 >> 24) == 0)
    {
        vec2 _1382 = clamp(_1978 + (_1977 * aPosition.xy), _1048, _1048 + _1050);
        vec4 _1339 = _1957 * vec4(_1382, 0.0, 1.0);
        float _1355 = _1339.w;
        gl_Position = uTransform * vec4((_1339.xy * _1121) + (((-_1124) + _1155) * _1355), _1075 * _1355, _1355);
        _1980 = _1382;
    }
    else
    {
        bvec4 _807 = notEqual((ivec4(_1002 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _810 = vec4(_807.x ? vec4(1.0).x : vec4(0.0).x, _807.y ? vec4(1.0).y : vec4(0.0).y, _807.z ? vec4(1.0).z : vec4(0.0).z, _807.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1532 = _1048 + _1050;
        vec4 _1439 = vec4(2.0) * _810;
        vec2 _1441 = _1439.xy;
        vec2 _1462 = (_1978 - _1441) + ((_1977 + (_1441 + _1439.zw)) * aPosition.xy);
        vec4 _1474 = _1957 * vec4(_1462, 0.0, 1.0);
        float _1482 = _1474.w;
        gl_Position = uTransform * vec4((_1474.xy * _1121) + ((_1155 - _1124) * _1482), _1075 * _1482, _1482);
        vTransformBounds = mix(vec4(clamp(_1042, _1048, _1532), clamp(_1042 + _1044, _1048, _1532)), vec4(clamp(_1978, _1048, _1532), clamp(_1978 + _1977, _1048, _1532)), _810);
        _1980 = _1462;
    }
    uint _1679 = uint(_1078);
    ivec2 _1686 = ivec2(int(_1679 % 1024u), int(_1679 / 1024u));
    vec4 _1670 = texelFetch(sGpuCache, _1686, 0);
    vec4 _1675 = texelFetch(sGpuCache, _1686 + ivec2(1, 0), 0);
    if ((((_1002 >> 8) & 255) & 2) != 0)
    {
        vec2 _1581 = (_1980 - _1978) / _1977;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1581.x, _1581.y);
        vec2 _1594 = (varying_vec4_0.zw * (_1984.zw - _1984.xy)) + _1984.xy;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1594.x, _1594.y);
        vec2 _1601 = varying_vec4_0.zw * _1044;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1601.x, _1601.y);
    }
    else
    {
        vec2 _1608 = _1980 - _1042;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1608.x, _1608.y);
    }
    vec2 _1619 = _1670.zw - _1670.xy;
    flat_varying_vec4_0 = vec4(_1670.x, _1670.y, flat_varying_vec4_0.z, flat_varying_vec4_0.w);
    vec2 _1628 = _1619 / vec2(dot(_1619, _1619));
    flat_varying_vec4_0 = vec4(flat_varying_vec4_0.x, flat_varying_vec4_0.y, _1628.x, _1628.y);
    flat_varying_vec4_1 = vec4(_1675.y, _1675.z, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
    flat_varying_highp_int_address_0 = texelFetch(sPrimitiveHeadersI, _1038, 0).x;
    flat_varying_vec4_1.z = float(int(_1675.x) != 0);
}

