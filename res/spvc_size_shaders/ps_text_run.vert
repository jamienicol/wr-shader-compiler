#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform int uMode;
uniform mat4 uTransform;
uniform highp sampler2DArray sColor0;

layout(location = 1) in ivec4 aData;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
layout(location = 0) in vec3 aPosition;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_0;
out vec4 varying_vec4_0;
flat out vec4 flat_varying_vec4_2;
flat out vec4 vTransformBounds;
out vec4 varying_vec4_1;

mat4 _2027;

void main()
{
    int _883 = aData.y & 65535;
    int _891 = aData.z >> 16;
    int _576 = _891 & 255;
    uint _911 = uint(aData.x);
    ivec2 _919 = ivec2(int(2u * (_911 % 512u)), int(_911 / 512u));
    ivec2 _927 = _919 + ivec2(1, 0);
    vec4 _929 = texelFetch(sPrimitiveHeadersF, _927, 0);
    vec2 _937 = _929.xy;
    ivec4 _956 = texelFetch(sPrimitiveHeadersI, _919, 0);
    ivec4 _961 = texelFetch(sPrimitiveHeadersI, _927, 0);
    int _967 = _956.y;
    uint _987 = uint(_956.z & 16777215);
    ivec2 _1001 = ivec2(int(8u * (_987 % 128u)), int(_987 / 128u));
    mat4 _2007 = _2027;
    _2007[0] = texelFetch(sTransformPalette, _1001, 0);
    mat4 _2009 = _2007;
    _2009[1] = texelFetch(sTransformPalette, _1001 + ivec2(1, 0), 0);
    mat4 _2011 = _2009;
    _2011[2] = texelFetch(sTransformPalette, _1001 + ivec2(2, 0), 0);
    mat4 _2013 = _2011;
    _2013[3] = texelFetch(sTransformPalette, _1001 + ivec2(3, 0), 0);
    vec2 _1906;
    float _1907;
    float _1908;
    vec2 _1909;
    vec2 _1910;
    if (_883 >= 32767)
    {
        _1910 = vec2(0.0);
        _1909 = vec2(0.0);
        _1908 = 0.0;
        _1907 = 0.0;
        _1906 = vec2(0.0);
    }
    else
    {
        uint _1087 = uint(_883);
        ivec2 _1095 = ivec2(int(2u * (_1087 % 512u)), int(_1087 / 512u));
        vec4 _1100 = texelFetch(sRenderTasks, _1095, 0);
        vec4 _1105 = texelFetch(sRenderTasks, _1095 + ivec2(1, 0), 0);
        _1910 = _1100.xy;
        _1909 = _1100.zw;
        _1908 = _1105.x;
        _1907 = _1105.y;
        _1906 = _1105.zw;
    }
    uint _1143 = uint(aData.y >> 16);
    ivec2 _1151 = ivec2(int(2u * (_1143 % 512u)), int(_1143 / 512u));
    vec4 _1161 = texelFetch(sRenderTasks, _1151 + ivec2(1, 0), 0);
    float _1129 = _1161.y;
    uint _1204 = uint(_967);
    ivec2 _1211 = ivec2(int(_1204 % 1024u), int(_1204 / 1024u));
    vec4 _1195 = texelFetch(sGpuCache, _1211, 0);
    int _1977;
    if (_576 == 0)
    {
        _1977 = uMode;
    }
    else
    {
        _1977 = _576;
    }
    uint _1220 = uint(aData.z & 65535);
    uint _1249 = uint((_967 + 2) + int(_1220 / 2u));
    vec4 _1246 = texelFetch(sGpuCache, ivec2(int(_1249 % 1024u), int(_1249 / 1024u)), 0);
    vec2 _1227 = _1246.xy;
    vec2 _1229 = _1246.zw;
    bvec2 _1234 = bvec2((_1220 % 2u) != 0u);
    uint _1290 = uint(aData.w & 16777215);
    ivec2 _1297 = ivec2(int(_1290 % 1024u), int(_1290 / 1024u));
    vec4 _1281 = texelFetch(sGpuCache, _1297, 0);
    vec4 _1286 = texelFetch(sGpuCache, _1297 + ivec2(1, 0), 0);
    vec2 _1930;
    switch ((_891 >> 8) & 255)
    {
        case 1:
        {
            _1930 = vec2(0.125, 0.5);
            break;
        }
        case 2:
        {
            _1930 = vec2(0.5, 0.125);
            break;
        }
        case 3:
        {
            _1930 = vec2(0.125);
            break;
        }
        default:
        {
            _1930 = vec2(0.5);
            break;
        }
    }
    float _669 = _1286.w / ((float(_961.z) * 1.525902189314365386962890625e-05) * _1129);
    vec2 _690 = ((_1286.yz + floor(((vec2(_1234.x ? _1229.x : _1227.x, _1234.y ? _1229.y : _1227.y) + texelFetch(sPrimitiveHeadersF, _919, 0).xy) * (1.0 / _669)) + _1930)) * _669) + (vec2(_961.xy) * vec2(0.00390625));
    vec2 _694 = _1281.zw;
    vec2 _697 = _1281.xy;
    vec2 _699 = (_694 - _697) * _669;
    vec2 _1307 = clamp(_690 + (_699 * aPosition.xy), _937, _937 + _929.zw);
    vec4 _726 = _2013 * vec4(_1307, 0.0, 1.0);
    vec2 _729 = _726.xy;
    float _749 = _726.w;
    gl_Position = uTransform * vec4((_729 * _1129) + (((-_1161.zw) + texelFetch(sRenderTasks, _1151, 0).xy) * _749), float(_956.x) * _749, _749);
    vClipMaskUvBounds = vec4(_1910, _1910 + _1909);
    vClipMaskUv = vec4((_729 * _1907) + ((_1910 - _1906) * _749), _1908, _749);
    switch (_1977)
    {
        case 1:
        case 7:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0, 1.0).x, vec2(0.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _1195;
            break;
        }
        case 5:
        case 6:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _1195;
            break;
        }
        case 2:
        case 3:
        case 8:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_1195.w);
            break;
        }
        case 4:
        {
            flat_varying_vec4_1 = vec4(vec2(-1.0, 1.0).x, vec2(-1.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_1195.w) * texelFetch(sGpuCache, _1211 + ivec2(1, 0), 0);
            break;
        }
        default:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0).x, vec2(0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(1.0);
            break;
        }
    }
    vec2 _831 = vec2(vec3(textureSize(sColor0, 0)).xy);
    vec2 _848 = mix(_697 / _831, _694 / _831, (_1307 - _690) / _699);
    varying_vec4_0 = vec4(_848.x, _848.y, varying_vec4_0.z, varying_vec4_0.w);
    varying_vec4_0.z = _1286.x;
    flat_varying_vec4_2 = (_1281 + vec4(0.5, 0.5, -0.5, -0.5)) / _831.xyxy;
}

