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
out vec4 varying_vec4_0;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_1;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_1;
flat out int flat_varying_highp_int_address_0;

mat4 _2174;

void main()
{
    int _1093 = aData.z & 65535;
    int _1097 = aData.z >> 16;
    uint _1117 = uint(aData.x);
    ivec2 _1125 = ivec2(int(2u * (_1117 % 512u)), int(_1117 / 512u));
    vec4 _1130 = texelFetch(sPrimitiveHeadersF, _1125, 0);
    ivec2 _1133 = _1125 + ivec2(1, 0);
    vec4 _1135 = texelFetch(sPrimitiveHeadersF, _1133, 0);
    vec2 _1137 = _1130.xy;
    vec2 _1139 = _1130.zw;
    vec2 _1143 = _1135.xy;
    vec2 _1145 = _1135.zw;
    ivec4 _1162 = texelFetch(sPrimitiveHeadersI, _1125, 0);
    ivec4 _1167 = texelFetch(sPrimitiveHeadersI, _1133, 0);
    float _1170 = float(_1162.x);
    int _1176 = _1162.z;
    vec2 _2176;
    vec2 _2177;
    if (_1093 == 65535)
    {
        _2177 = _1137;
        _2176 = _1139;
    }
    else
    {
        uint _1199 = uint((_1162.y + 3) + (_1093 * 2));
        vec4 _1190 = texelFetch(sGpuCache, ivec2(int(_1199 % 1024u), int(_1199 / 1024u)), 0);
        _2177 = _1190.xy + _1137;
        _2176 = _1190.zw;
    }
    uint _1230 = uint(aData.y >> 16);
    ivec2 _1238 = ivec2(int(2u * (_1230 % 512u)), int(_1230 / 512u));
    vec4 _1248 = texelFetch(sRenderTasks, _1238 + ivec2(1, 0), 0);
    vec2 _1250 = texelFetch(sRenderTasks, _1238, 0).xy;
    float _1216 = _1248.y;
    vec2 _1219 = _1248.zw;
    uint _1344 = uint(_1176 & 16777215);
    ivec2 _1358 = ivec2(int(8u * (_1344 % 128u)), int(_1344 / 128u));
    mat4 _2143 = _2174;
    _2143[0] = texelFetch(sTransformPalette, _1358, 0);
    mat4 _2145 = _2143;
    _2145[1] = texelFetch(sTransformPalette, _1358 + ivec2(1, 0), 0);
    mat4 _2147 = _2145;
    _2147[2] = texelFetch(sTransformPalette, _1358 + ivec2(2, 0), 0);
    mat4 _2149 = _2147;
    _2149[3] = texelFetch(sTransformPalette, _1358 + ivec2(3, 0), 0);
    vec4 _2178;
    vec2 _2179;
    if ((_1176 >> 24) == 0)
    {
        vec2 _1477 = clamp(_2177 + (_2176 * aPosition.xy), _1143, _1143 + _1145);
        vec4 _1434 = _2149 * vec4(_1477, 0.0, 1.0);
        float _1450 = _1434.w;
        gl_Position = uTransform * vec4((_1434.xy * _1216) + (((-_1219) + _1250) * _1450), _1170 * _1450, _1450);
        _2179 = _1477;
        _2178 = _1434;
    }
    else
    {
        bvec4 _926 = notEqual((ivec4(_1097 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _929 = vec4(_926.x ? vec4(1.0).x : vec4(0.0).x, _926.y ? vec4(1.0).y : vec4(0.0).y, _926.z ? vec4(1.0).z : vec4(0.0).z, _926.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1627 = _1143 + _1145;
        vec4 _1534 = vec4(2.0) * _929;
        vec2 _1536 = _1534.xy;
        vec2 _1557 = (_2177 - _1536) + ((_2176 + (_1536 + _1534.zw)) * aPosition.xy);
        vec4 _1569 = _2149 * vec4(_1557, 0.0, 1.0);
        float _1577 = _1569.w;
        gl_Position = uTransform * vec4((_1569.xy * _1216) + ((_1250 - _1219) * _1577), _1170 * _1577, _1577);
        vTransformBounds = mix(vec4(clamp(_1137, _1143, _1627), clamp(_1137 + _1139, _1143, _1627)), vec4(clamp(_2177, _1143, _1627), clamp(_2177 + _2176, _1143, _1627)), _929);
        _2179 = _1557;
        _2178 = _1569;
    }
    int _1666 = _1167.x;
    uint _1769 = uint(_1666);
    ivec2 _1776 = ivec2(int(_1769 % 1024u), int(_1769 / 1024u));
    vec4 _1760 = texelFetch(sGpuCache, _1776, 0);
    vec2 _1676 = vec2(textureSize(sColor0, 0).xy);
    vec2 _1684 = (_2179 - _1137) / _1139;
    uint _1856 = uint(_1666 + 2);
    ivec2 _1863 = ivec2(int(_1856 % 1024u), int(_1856 / 1024u));
    vec4 _1791 = vec4(_1684.x);
    vec4 _1806 = mix(mix(texelFetch(sGpuCache, _1863, 0), texelFetch(sGpuCache, _1863 + ivec2(1, 0), 0), _1791), mix(texelFetch(sGpuCache, _1863 + ivec2(2, 0), 0), texelFetch(sGpuCache, _1863 + ivec2(3, 0), 0), _1791), vec4(_1684.y));
    float _1696 = float((((_1097 >> 8) & 255) & 1) != 0);
    vec2 _1704 = (mix(_1760.xy, _1760.zw, _1806.xy / vec2(_1806.w)) / _1676) * mix(_2178.w, 1.0, _1696);
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1704.x, _1704.y);
    flat_varying_vec4_2.x = texelFetch(sGpuCache, _1776 + ivec2(1, 0), 0).x;
    flat_varying_vec4_2.y = _1696;
    flat_varying_vec4_1 = _1760 / _1676.xyxy;
    varying_vec4_0 = vec4(_2179.x, _2179.y, varying_vec4_0.z, varying_vec4_0.w);
    flat_varying_vec4_2.z = float(_1167.y) * 1.52587890625e-05;
}

