#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform mat4 uTransform;
uniform highp sampler2DArray sPrevPassColor;

flat out vec4 vTransformBounds;
layout(location = 1) in ivec4 aData;
layout(location = 0) in vec3 aPosition;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_0;
out vec4 varying_vec4_1;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
flat out int flat_varying_highp_int_address_0;

mat4 _2025;

void main()
{
    int _997 = aData.z & 65535;
    uint _1021 = uint(aData.x);
    ivec2 _1029 = ivec2(int(2u * (_1021 % 512u)), int(_1021 / 512u));
    vec4 _1034 = texelFetch(sPrimitiveHeadersF, _1029, 0);
    ivec2 _1037 = _1029 + ivec2(1, 0);
    vec4 _1039 = texelFetch(sPrimitiveHeadersF, _1037, 0);
    vec2 _1041 = _1034.xy;
    vec2 _1043 = _1034.zw;
    vec2 _1047 = _1039.xy;
    vec2 _1049 = _1039.zw;
    ivec4 _1066 = texelFetch(sPrimitiveHeadersI, _1029, 0);
    ivec4 _1071 = texelFetch(sPrimitiveHeadersI, _1037, 0);
    float _1074 = float(_1066.x);
    int _1080 = _1066.z;
    vec2 _2027;
    vec2 _2028;
    if (_997 == 65535)
    {
        _2028 = _1041;
        _2027 = _1043;
    }
    else
    {
        uint _1103 = uint((_1066.y + 3) + (_997 * 2));
        vec4 _1094 = texelFetch(sGpuCache, ivec2(int(_1103 % 1024u), int(_1103 / 1024u)), 0);
        _2028 = _1094.xy + _1041;
        _2027 = _1094.zw;
    }
    uint _1134 = uint(aData.y >> 16);
    ivec2 _1142 = ivec2(int(2u * (_1134 % 512u)), int(_1134 / 512u));
    vec4 _1152 = texelFetch(sRenderTasks, _1142 + ivec2(1, 0), 0);
    vec2 _1154 = texelFetch(sRenderTasks, _1142, 0).xy;
    float _1120 = _1152.y;
    vec2 _1123 = _1152.zw;
    uint _1248 = uint(_1080 & 16777215);
    ivec2 _1262 = ivec2(int(8u * (_1248 % 128u)), int(_1248 / 128u));
    mat4 _1996 = _2025;
    _1996[0] = texelFetch(sTransformPalette, _1262, 0);
    mat4 _1998 = _1996;
    _1998[1] = texelFetch(sTransformPalette, _1262 + ivec2(1, 0), 0);
    mat4 _2000 = _1998;
    _2000[2] = texelFetch(sTransformPalette, _1262 + ivec2(2, 0), 0);
    mat4 _2002 = _2000;
    _2002[3] = texelFetch(sTransformPalette, _1262 + ivec2(3, 0), 0);
    vec4 _2029;
    if ((_1080 >> 24) == 0)
    {
        vec4 _1338 = _2002 * vec4(clamp(_2028 + (_2027 * aPosition.xy), _1047, _1047 + _1049), 0.0, 1.0);
        float _1354 = _1338.w;
        gl_Position = uTransform * vec4((_1338.xy * _1120) + (((-_1123) + _1154) * _1354), _1074 * _1354, _1354);
        _2029 = _1338;
    }
    else
    {
        bvec4 _843 = notEqual((ivec4((aData.z >> 16) & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _846 = vec4(_843.x ? vec4(1.0).x : vec4(0.0).x, _843.y ? vec4(1.0).y : vec4(0.0).y, _843.z ? vec4(1.0).z : vec4(0.0).z, _843.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1531 = _1047 + _1049;
        vec4 _1438 = vec4(2.0) * _846;
        vec2 _1440 = _1438.xy;
        vec4 _1473 = _2002 * vec4((_2028 - _1440) + ((_2027 + (_1440 + _1438.zw)) * aPosition.xy), 0.0, 1.0);
        float _1481 = _1473.w;
        gl_Position = uTransform * vec4((_1473.xy * _1120) + ((_1154 - _1123) * _1481), _1074 * _1481, _1481);
        vTransformBounds = mix(vec4(clamp(_1041, _1047, _1531), clamp(_1041 + _1043, _1047, _1531)), vec4(clamp(_2028, _1047, _1531), clamp(_2028 + _2027, _1047, _1531)), _846);
        _2029 = _1473;
    }
    vec2 _1577 = (_2029.xy * _1120) / vec2(max(0.0, _2029.w));
    vec2 _1584 = vec2(vec3(textureSize(sPrevPassColor, 0)).xy);
    flat_varying_ivec4_0.x = _1071.x;
    uint _1647 = uint(_1071.z);
    ivec2 _1655 = ivec2(int(2u * (_1647 % 512u)), int(_1647 / 512u));
    vec4 _1665 = texelFetch(sRenderTasks, _1655 + ivec2(1, 0), 0);
    vec2 _1636 = _1665.zw;
    vec2 _1600 = ((_1577 + texelFetch(sRenderTasks, _1655, 0).xy) - _1636) / _1584;
    varying_vec4_0 = vec4(_1600.x, _1600.y, varying_vec4_0.z, varying_vec4_0.w);
    varying_vec4_0.w = _1665.x;
    uint _1687 = uint(_1071.y);
    ivec2 _1695 = ivec2(int(2u * (_1687 % 512u)), int(_1687 / 512u));
    vec2 _1618 = ((_1577 + texelFetch(sRenderTasks, _1695, 0).xy) - _1636) / _1584;
    varying_vec4_1 = vec4(_1618.x, _1618.y, varying_vec4_1.z, varying_vec4_1.w);
    varying_vec4_1.w = texelFetch(sRenderTasks, _1695 + ivec2(1, 0), 0).x;
}

