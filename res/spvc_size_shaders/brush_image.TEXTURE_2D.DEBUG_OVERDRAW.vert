#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform mat4 uTransform;
uniform mediump sampler2D sColor0;

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

mat4 _2854;

void main()
{
    int _1123 = aData.z & 65535;
    int _1127 = aData.z >> 16;
    int _774 = (_1127 >> 8) & 255;
    uint _1147 = uint(aData.x);
    ivec2 _1155 = ivec2(int(2u * (_1147 % 512u)), int(_1147 / 512u));
    vec4 _1160 = texelFetch(sPrimitiveHeadersF, _1155, 0);
    vec4 _1165 = texelFetch(sPrimitiveHeadersF, _1155 + ivec2(1, 0), 0);
    vec2 _1167 = _1160.xy;
    vec2 _1169 = _1160.zw;
    vec2 _1173 = _1165.xy;
    vec2 _1175 = _1165.zw;
    ivec4 _1192 = texelFetch(sPrimitiveHeadersI, _1155, 0);
    float _1200 = float(_1192.x);
    int _1203 = _1192.y;
    int _1206 = _1192.z;
    vec2 _2746;
    vec2 _2748;
    vec4 _2790;
    if (_1123 == 65535)
    {
        _2790 = vec4(0.0);
        _2748 = _1167;
        _2746 = _1169;
    }
    else
    {
        uint _1229 = uint((_1203 + 3) + (_1123 * 2));
        ivec2 _1236 = ivec2(int(_1229 % 1024u), int(_1229 / 1024u));
        vec4 _1220 = texelFetch(sGpuCache, _1236, 0);
        _2790 = texelFetch(sGpuCache, _1236 + ivec2(1, 0), 0);
        _2748 = _1220.xy + _1167;
        _2746 = _1220.zw;
    }
    uint _1260 = uint(aData.y >> 16);
    ivec2 _1268 = ivec2(int(2u * (_1260 % 512u)), int(_1260 / 512u));
    vec4 _1278 = texelFetch(sRenderTasks, _1268 + ivec2(1, 0), 0);
    vec2 _1280 = texelFetch(sRenderTasks, _1268, 0).xy;
    float _1246 = _1278.y;
    vec2 _1249 = _1278.zw;
    uint _1374 = uint(_1206 & 16777215);
    ivec2 _1388 = ivec2(int(8u * (_1374 % 128u)), int(_1374 / 128u));
    mat4 _2837 = _2854;
    _2837[0] = texelFetch(sTransformPalette, _1388, 0);
    mat4 _2839 = _2837;
    _2839[1] = texelFetch(sTransformPalette, _1388 + ivec2(1, 0), 0);
    mat4 _2841 = _2839;
    _2841[2] = texelFetch(sTransformPalette, _1388 + ivec2(2, 0), 0);
    mat4 _2843 = _2841;
    _2843[3] = texelFetch(sTransformPalette, _1388 + ivec2(3, 0), 0);
    vec4 _2764;
    vec2 _2765;
    if ((_1206 >> 24) == 0)
    {
        vec2 _1507 = clamp(_2748 + (_2746 * aPosition.xy), _1173, _1173 + _1175);
        vec4 _1464 = _2843 * vec4(_1507, 0.0, 1.0);
        float _1480 = _1464.w;
        gl_Position = uTransform * vec4((_1464.xy * _1246) + (((-_1249) + _1280) * _1480), _1200 * _1480, _1480);
        _2765 = _1507;
        _2764 = _1464;
    }
    else
    {
        bvec4 _860 = notEqual((ivec4(_1127 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _863 = vec4(_860.x ? vec4(1.0).x : vec4(0.0).x, _860.y ? vec4(1.0).y : vec4(0.0).y, _860.z ? vec4(1.0).z : vec4(0.0).z, _860.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1657 = _1173 + _1175;
        vec4 _1564 = vec4(2.0) * _863;
        vec2 _1566 = _1564.xy;
        vec2 _1587 = (_2748 - _1566) + ((_2746 + (_1566 + _1564.zw)) * aPosition.xy);
        vec4 _1599 = _2843 * vec4(_1587, 0.0, 1.0);
        float _1607 = _1599.w;
        gl_Position = uTransform * vec4((_1599.xy * _1246) + ((_1280 - _1249) * _1607), _1200 * _1607, _1607);
        vTransformBounds = mix(vec4(clamp(_1167, _1173, _1657), clamp(_1167 + _1169, _1173, _1657)), vec4(clamp(_2748, _1173, _1657), clamp(_2748 + _2746, _1173, _1657)), _863);
        _2765 = _1587;
        _2764 = _1599;
    }
    uint _1876 = uint(_1203);
    vec4 _1872 = texelFetch(sGpuCache, ivec2(int(_1876 % 1024u), int(_1876 / 1024u)) + ivec2(2, 0), 0);
    vec2 _1706 = vec2(textureSize(sColor0, 0));
    uint _1922 = uint(aData.w & 16777215);
    ivec2 _1929 = ivec2(int(_1922 % 1024u), int(_1922 / 1024u));
    vec4 _1913 = texelFetch(sGpuCache, _1929, 0);
    vec2 _1892 = _1913.xy;
    vec2 _1895 = _1913.zw;
    vec2 _2856;
    if (_1872.x < 0.0)
    {
        _2856 = _1169;
    }
    else
    {
        _2856 = _1872.xy;
    }
    bool _1725 = (_774 & 2) != 0;
    vec2 _2802;
    vec2 _2805;
    vec2 _2855;
    if (_1725)
    {
        vec2 _2804;
        vec2 _2807;
        if ((_774 & 128) != 0)
        {
            vec2 _1740 = _1895 - _1892;
            _2807 = _1892 + (_2790.zw * _1740);
            _2804 = _1892 + (_2790.xy * _1740);
        }
        else
        {
            _2807 = _1895;
            _2804 = _1892;
        }
        _2855 = _2746;
        _2805 = _2807;
        _2802 = _2804;
    }
    else
    {
        _2855 = _2856;
        _2805 = _1895;
        _2802 = _1892;
    }
    bvec2 _2826 = bvec2(_1725);
    vec2 _2827 = vec2(_2826.x ? _2746.x : _1169.x, _2826.y ? _2746.y : _1169.y);
    float _1761 = float((_774 & 1) != 0);
    flat_varying_vec4_4.x = texelFetch(sGpuCache, _1929 + ivec2(1, 0), 0).x;
    flat_varying_vec4_4.y = _1761;
    vec2 _1769 = min(_2802, _2805);
    vec2 _1772 = max(_2802, _2805);
    vec4 _1783 = _1706.xyxy;
    flat_varying_vec4_3 = vec4(_1769 + vec2(0.5), _1772 - vec2(0.5)) / _1783;
    vec2 _1802 = mix(_2802, _2805, (_2765 - vec2(_2826.x ? _2748.x : _1167.x, _2826.y ? _2748.y : _1167.y)) / _2827) - _1769;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1802.x, _1802.y);
    vec2 _1808 = varying_vec4_0.zw / _1706;
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1808.x, _1808.y);
    vec2 _1814 = varying_vec4_0.zw * (_2827 / _2855);
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1814.x, _1814.y);
    if (_1761 == 0.0)
    {
        vec2 _1825 = varying_vec4_0.zw * _2764.w;
        varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1825.x, _1825.y);
    }
    flat_varying_vec4_2 = vec4(_1769, _1772) / _1783;
}

