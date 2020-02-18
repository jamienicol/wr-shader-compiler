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
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
out vec4 varying_vec4_0;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_0;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_1;
flat out int flat_varying_highp_int_address_0;

mat4 _2885;

void main()
{
    int _1140 = aData.y & 65535;
    int _1144 = aData.z & 65535;
    int _1148 = aData.z >> 16;
    uint _1168 = uint(aData.x);
    ivec2 _1176 = ivec2(int(2u * (_1168 % 512u)), int(_1168 / 512u));
    vec4 _1181 = texelFetch(sPrimitiveHeadersF, _1176, 0);
    ivec2 _1184 = _1176 + ivec2(1, 0);
    vec4 _1186 = texelFetch(sPrimitiveHeadersF, _1184, 0);
    vec2 _1188 = _1181.xy;
    vec2 _1190 = _1181.zw;
    vec2 _1194 = _1186.xy;
    vec2 _1196 = _1186.zw;
    ivec4 _1213 = texelFetch(sPrimitiveHeadersI, _1176, 0);
    ivec4 _1218 = texelFetch(sPrimitiveHeadersI, _1184, 0);
    float _1221 = float(_1213.x);
    int _1227 = _1213.z;
    vec2 _2797;
    vec2 _2799;
    if (_1144 == 65535)
    {
        _2799 = _1188;
        _2797 = _1190;
    }
    else
    {
        uint _1250 = uint((_1213.y + 3) + (_1144 * 2));
        vec4 _1241 = texelFetch(sGpuCache, ivec2(int(_1250 % 1024u), int(_1250 / 1024u)), 0);
        _2799 = _1241.xy + _1188;
        _2797 = _1241.zw;
    }
    uint _1281 = uint(aData.y >> 16);
    ivec2 _1289 = ivec2(int(2u * (_1281 % 512u)), int(_1281 / 512u));
    vec4 _1299 = texelFetch(sRenderTasks, _1289 + ivec2(1, 0), 0);
    vec2 _1301 = texelFetch(sRenderTasks, _1289, 0).xy;
    float _1267 = _1299.y;
    vec2 _1270 = _1299.zw;
    vec2 _2787;
    float _2788;
    float _2789;
    vec2 _2790;
    vec2 _2791;
    if (_1140 >= 32767)
    {
        _2791 = vec2(0.0);
        _2790 = vec2(0.0);
        _2789 = 0.0;
        _2788 = 0.0;
        _2787 = vec2(0.0);
    }
    else
    {
        uint _1350 = uint(_1140);
        ivec2 _1358 = ivec2(int(2u * (_1350 % 512u)), int(_1350 / 512u));
        vec4 _1363 = texelFetch(sRenderTasks, _1358, 0);
        vec4 _1368 = texelFetch(sRenderTasks, _1358 + ivec2(1, 0), 0);
        _2791 = _1363.xy;
        _2790 = _1363.zw;
        _2789 = _1368.x;
        _2788 = _1368.y;
        _2787 = _1368.zw;
    }
    uint _1395 = uint(_1227 & 16777215);
    ivec2 _1409 = ivec2(int(8u * (_1395 % 128u)), int(_1395 / 128u));
    mat4 _2859 = _2885;
    _2859[0] = texelFetch(sTransformPalette, _1409, 0);
    mat4 _2861 = _2859;
    _2861[1] = texelFetch(sTransformPalette, _1409 + ivec2(1, 0), 0);
    mat4 _2863 = _2861;
    _2863[2] = texelFetch(sTransformPalette, _1409 + ivec2(2, 0), 0);
    mat4 _2865 = _2863;
    _2865[3] = texelFetch(sTransformPalette, _1409 + ivec2(3, 0), 0);
    vec4 _2815;
    vec2 _2821;
    if ((_1227 >> 24) == 0)
    {
        vec2 _1528 = clamp(_2799 + (_2797 * aPosition.xy), _1194, _1194 + _1196);
        vec4 _1485 = _2865 * vec4(_1528, 0.0, 1.0);
        float _1501 = _1485.w;
        gl_Position = uTransform * vec4((_1485.xy * _1267) + (((-_1270) + _1301) * _1501), _1221 * _1501, _1501);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _2821 = _1528;
        _2815 = _1485;
    }
    else
    {
        bvec4 _973 = notEqual((ivec4(_1148 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _976 = vec4(_973.x ? vec4(1.0).x : vec4(0.0).x, _973.y ? vec4(1.0).y : vec4(0.0).y, _973.z ? vec4(1.0).z : vec4(0.0).z, _973.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1679 = _1194 + _1196;
        vec4 _1586 = vec4(2.0) * _976;
        vec2 _1588 = _1586.xy;
        vec2 _1609 = (_2799 - _1588) + ((_2797 + (_1588 + _1586.zw)) * aPosition.xy);
        vec4 _1621 = _2865 * vec4(_1609, 0.0, 1.0);
        float _1629 = _1621.w;
        gl_Position = uTransform * vec4((_1621.xy * _1267) + ((_1301 - _1270) * _1629), _1221 * _1629, _1629);
        vTransformBounds = mix(vec4(clamp(_1188, _1194, _1679), clamp(_1188 + _1190, _1194, _1679)), vec4(clamp(_2799, _1194, _1679), clamp(_2799 + _2797, _1194, _1679)), _976);
        _2821 = _1609;
        _2815 = _1621;
    }
    vClipMaskUvBounds = vec4(_2791, _2791 + _2790);
    vClipMaskUv = vec4((_2815.xy * _2788) + ((_2791 - _2787) * _2815.w), _2789, _2815.w);
    int _1753 = _1218.x;
    uint _1856 = uint(_1753);
    ivec2 _1863 = ivec2(int(_1856 % 1024u), int(_1856 / 1024u));
    vec4 _1847 = texelFetch(sGpuCache, _1863, 0);
    vec2 _1763 = vec2(textureSize(sColor0, 0).xy);
    vec2 _1771 = (_2821 - _1188) / _1190;
    uint _1943 = uint(_1753 + 2);
    ivec2 _1950 = ivec2(int(_1943 % 1024u), int(_1943 / 1024u));
    vec4 _1878 = vec4(_1771.x);
    vec4 _1893 = mix(mix(texelFetch(sGpuCache, _1950, 0), texelFetch(sGpuCache, _1950 + ivec2(1, 0), 0), _1878), mix(texelFetch(sGpuCache, _1950 + ivec2(2, 0), 0), texelFetch(sGpuCache, _1950 + ivec2(3, 0), 0), _1878), vec4(_1771.y));
    float _1783 = float((((_1148 >> 8) & 255) & 1) != 0);
    vec2 _1791 = (mix(_1847.xy, _1847.zw, _1893.xy / vec2(_1893.w)) / _1763) * mix(_2815.w, 1.0, _1783);
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _1791.x, _1791.y);
    flat_varying_vec4_2.x = texelFetch(sGpuCache, _1863 + ivec2(1, 0), 0).x;
    flat_varying_vec4_2.y = _1783;
    flat_varying_vec4_1 = _1847 / _1763.xyxy;
    varying_vec4_0 = vec4(_2821.x, _2821.y, varying_vec4_0.z, varying_vec4_0.w);
    flat_varying_vec4_2.z = float(_1218.y) * 1.52587890625e-05;
}

