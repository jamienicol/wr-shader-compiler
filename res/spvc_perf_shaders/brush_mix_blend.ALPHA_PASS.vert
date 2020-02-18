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
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_0;
out vec4 varying_vec4_1;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
flat out int flat_varying_highp_int_address_0;

mat4 _2191;

void main()
{
    int _1044 = aData.y & 65535;
    int _1048 = aData.z & 65535;
    uint _1072 = uint(aData.x);
    ivec2 _1080 = ivec2(int(2u * (_1072 % 512u)), int(_1072 / 512u));
    vec4 _1085 = texelFetch(sPrimitiveHeadersF, _1080, 0);
    ivec2 _1088 = _1080 + ivec2(1, 0);
    vec4 _1090 = texelFetch(sPrimitiveHeadersF, _1088, 0);
    vec2 _1092 = _1085.xy;
    vec2 _1094 = _1085.zw;
    vec2 _1098 = _1090.xy;
    vec2 _1100 = _1090.zw;
    ivec4 _1117 = texelFetch(sPrimitiveHeadersI, _1080, 0);
    ivec4 _1122 = texelFetch(sPrimitiveHeadersI, _1088, 0);
    float _1125 = float(_1117.x);
    int _1131 = _1117.z;
    vec2 _2195;
    vec2 _2197;
    if (_1048 == 65535)
    {
        _2197 = _1092;
        _2195 = _1094;
    }
    else
    {
        uint _1154 = uint((_1117.y + 3) + (_1048 * 2));
        vec4 _1145 = texelFetch(sGpuCache, ivec2(int(_1154 % 1024u), int(_1154 / 1024u)), 0);
        _2197 = _1145.xy + _1092;
        _2195 = _1145.zw;
    }
    uint _1185 = uint(aData.y >> 16);
    ivec2 _1193 = ivec2(int(2u * (_1185 % 512u)), int(_1185 / 512u));
    vec4 _1203 = texelFetch(sRenderTasks, _1193 + ivec2(1, 0), 0);
    vec2 _1205 = texelFetch(sRenderTasks, _1193, 0).xy;
    float _1171 = _1203.y;
    vec2 _1174 = _1203.zw;
    vec2 _2184;
    float _2185;
    float _2186;
    vec2 _2187;
    vec2 _2188;
    if (_1044 >= 32767)
    {
        _2188 = vec2(0.0);
        _2187 = vec2(0.0);
        _2186 = 0.0;
        _2185 = 0.0;
        _2184 = vec2(0.0);
    }
    else
    {
        uint _1254 = uint(_1044);
        ivec2 _1262 = ivec2(int(2u * (_1254 % 512u)), int(_1254 / 512u));
        vec4 _1267 = texelFetch(sRenderTasks, _1262, 0);
        vec4 _1272 = texelFetch(sRenderTasks, _1262 + ivec2(1, 0), 0);
        _2188 = _1267.xy;
        _2187 = _1267.zw;
        _2186 = _1272.x;
        _2185 = _1272.y;
        _2184 = _1272.zw;
    }
    uint _1299 = uint(_1131 & 16777215);
    ivec2 _1313 = ivec2(int(8u * (_1299 % 128u)), int(_1299 / 128u));
    mat4 _2154 = _2191;
    _2154[0] = texelFetch(sTransformPalette, _1313, 0);
    mat4 _2156 = _2154;
    _2156[1] = texelFetch(sTransformPalette, _1313 + ivec2(1, 0), 0);
    mat4 _2158 = _2156;
    _2158[2] = texelFetch(sTransformPalette, _1313 + ivec2(2, 0), 0);
    mat4 _2160 = _2158;
    _2160[3] = texelFetch(sTransformPalette, _1313 + ivec2(3, 0), 0);
    vec4 _2198;
    if ((_1131 >> 24) == 0)
    {
        vec4 _1389 = _2160 * vec4(clamp(_2197 + (_2195 * aPosition.xy), _1098, _1098 + _1100), 0.0, 1.0);
        float _1405 = _1389.w;
        gl_Position = uTransform * vec4((_1389.xy * _1171) + (((-_1174) + _1205) * _1405), _1125 * _1405, _1405);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _2198 = _1389;
    }
    else
    {
        bvec4 _890 = notEqual((ivec4((aData.z >> 16) & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _893 = vec4(_890.x ? vec4(1.0).x : vec4(0.0).x, _890.y ? vec4(1.0).y : vec4(0.0).y, _890.z ? vec4(1.0).z : vec4(0.0).z, _890.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1583 = _1098 + _1100;
        vec4 _1490 = vec4(2.0) * _893;
        vec2 _1492 = _1490.xy;
        vec4 _1525 = _2160 * vec4((_2197 - _1492) + ((_2195 + (_1492 + _1490.zw)) * aPosition.xy), 0.0, 1.0);
        float _1533 = _1525.w;
        gl_Position = uTransform * vec4((_1525.xy * _1171) + ((_1205 - _1174) * _1533), _1125 * _1533, _1533);
        vTransformBounds = mix(vec4(clamp(_1092, _1098, _1583), clamp(_1092 + _1094, _1098, _1583)), vec4(clamp(_2197, _1098, _1583), clamp(_2197 + _2195, _1098, _1583)), _893);
        _2198 = _1525;
    }
    vClipMaskUvBounds = vec4(_2188, _2188 + _2187);
    vClipMaskUv = vec4((_2198.xy * _2185) + ((_2188 - _2184) * _2198.w), _2186, _2198.w);
    vec2 _1664 = (_2198.xy * _1171) / vec2(max(0.0, _2198.w));
    vec2 _1671 = vec2(vec3(textureSize(sPrevPassColor, 0)).xy);
    flat_varying_ivec4_0.x = _1122.x;
    uint _1734 = uint(_1122.z);
    ivec2 _1742 = ivec2(int(2u * (_1734 % 512u)), int(_1734 / 512u));
    vec4 _1752 = texelFetch(sRenderTasks, _1742 + ivec2(1, 0), 0);
    vec2 _1723 = _1752.zw;
    vec2 _1687 = ((_1664 + texelFetch(sRenderTasks, _1742, 0).xy) - _1723) / _1671;
    varying_vec4_0 = vec4(_1687.x, _1687.y, varying_vec4_0.z, varying_vec4_0.w);
    varying_vec4_0.w = _1752.x;
    uint _1774 = uint(_1122.y);
    ivec2 _1782 = ivec2(int(2u * (_1774 % 512u)), int(_1774 / 512u));
    vec2 _1705 = ((_1664 + texelFetch(sRenderTasks, _1782, 0).xy) - _1723) / _1671;
    varying_vec4_1 = vec4(_1705.x, _1705.y, varying_vec4_1.z, varying_vec4_1.w);
    varying_vec4_1.w = texelFetch(sRenderTasks, _1782 + ivec2(1, 0), 0).x;
}

