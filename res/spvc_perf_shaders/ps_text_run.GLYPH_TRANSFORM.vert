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
out vec4 varying_vec4_1;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_0;
out vec4 varying_vec4_0;
flat out vec4 flat_varying_vec4_2;
flat out vec4 vTransformBounds;

mat4 _1812;

void main()
{
    int _1006 = aData.y & 65535;
    int _1014 = aData.z >> 16;
    int _655 = _1014 & 255;
    uint _1034 = uint(aData.x);
    ivec2 _1042 = ivec2(int(2u * (_1034 % 512u)), int(_1034 / 512u));
    ivec2 _1050 = _1042 + ivec2(1, 0);
    vec4 _1052 = texelFetch(sPrimitiveHeadersF, _1050, 0);
    vec2 _1060 = _1052.xy;
    ivec4 _1079 = texelFetch(sPrimitiveHeadersI, _1042, 0);
    int _1090 = _1079.y;
    uint _1110 = uint(_1079.z & 16777215);
    ivec2 _1124 = ivec2(int(8u * (_1110 % 128u)), int(_1110 / 128u));
    vec4 _1129 = texelFetch(sTransformPalette, _1124, 0);
    mat4 _1781 = _1812;
    _1781[0] = _1129;
    vec4 _1135 = texelFetch(sTransformPalette, _1124 + ivec2(1, 0), 0);
    mat4 _1783 = _1781;
    _1783[1] = _1135;
    mat4 _1785 = _1783;
    _1785[2] = texelFetch(sTransformPalette, _1124 + ivec2(2, 0), 0);
    vec4 _1147 = texelFetch(sTransformPalette, _1124 + ivec2(3, 0), 0);
    mat4 _1787 = _1785;
    _1787[3] = _1147;
    vec2 _1813;
    float _1814;
    float _1815;
    vec2 _1816;
    vec2 _1817;
    if (_1006 >= 32767)
    {
        _1817 = vec2(0.0);
        _1816 = vec2(0.0);
        _1815 = 0.0;
        _1814 = 0.0;
        _1813 = vec2(0.0);
    }
    else
    {
        uint _1210 = uint(_1006);
        ivec2 _1218 = ivec2(int(2u * (_1210 % 512u)), int(_1210 / 512u));
        vec4 _1223 = texelFetch(sRenderTasks, _1218, 0);
        vec4 _1228 = texelFetch(sRenderTasks, _1218 + ivec2(1, 0), 0);
        _1817 = _1223.xy;
        _1816 = _1223.zw;
        _1815 = _1228.x;
        _1814 = _1228.y;
        _1813 = _1228.zw;
    }
    uint _1266 = uint(aData.y >> 16);
    ivec2 _1274 = ivec2(int(2u * (_1266 % 512u)), int(_1266 / 512u));
    vec4 _1284 = texelFetch(sRenderTasks, _1274 + ivec2(1, 0), 0);
    float _1252 = _1284.y;
    uint _1327 = uint(_1090);
    ivec2 _1334 = ivec2(int(_1327 % 1024u), int(_1327 / 1024u));
    vec4 _1318 = texelFetch(sGpuCache, _1334, 0);
    int _1824;
    if (_655 == 0)
    {
        _1824 = uMode;
    }
    else
    {
        _1824 = _655;
    }
    uint _1343 = uint(aData.z & 65535);
    uint _1372 = uint((_1090 + 2) + int(_1343 / 2u));
    vec4 _1369 = texelFetch(sGpuCache, ivec2(int(_1372 % 1024u), int(_1372 / 1024u)), 0);
    vec2 _1350 = _1369.xy;
    vec2 _1352 = _1369.zw;
    bvec2 _1357 = bvec2((_1343 % 2u) != 0u);
    uint _1413 = uint(aData.w & 16777215);
    ivec2 _1420 = ivec2(int(_1413 % 1024u), int(_1413 / 1024u));
    vec4 _1404 = texelFetch(sGpuCache, _1420, 0);
    vec4 _1409 = texelFetch(sGpuCache, _1420 + ivec2(1, 0), 0);
    vec2 _1819;
    switch ((_1014 >> 8) & 255)
    {
        case 1:
        {
            _1819 = vec2(0.125, 0.5);
            break;
        }
        case 2:
        {
            _1819 = vec2(0.5, 0.125);
            break;
        }
        case 3:
        {
            _1819 = vec2(0.125);
            break;
        }
        default:
        {
            _1819 = vec2(0.5);
            break;
        }
    }
    mat2 _745 = mat2(_1129.xy, _1135.xy) * _1252;
    vec2 _752 = _1147.xy * _1252;
    mat2 _755 = inverse(_745);
    vec2 _781 = (_1409.yz + floor((_745 * (vec2(_1357.x ? _1352.x : _1350.x, _1357.y ? _1352.y : _1350.y) + texelFetch(sPrimitiveHeadersF, _1042, 0).xy)) + _1819)) + (floor(((_745 * (vec2(texelFetch(sPrimitiveHeadersI, _1050, 0).xy) * vec2(0.00390625))) + _752) + vec2(0.5)) - _752);
    vec2 _784 = _1404.zw;
    vec2 _787 = _1404.xy;
    vec2 _788 = _784 - _787;
    vec2 _1429 = _788 * 0.5;
    vec2 _1448 = mat2(abs(_755[0]), abs(_755[1])) * _1429;
    vec2 _1451 = (_755 * (_781 + _1429)) - _1448;
    vec2 _1453 = _1448 * 2.0;
    vec2 _1474 = _1060 + _1052.zw;
    vec2 _1820;
    if (all(lessThanEqual(vec4(_1052.xy, _1451 + _1453), vec4(_1451, _1474))))
    {
        _1820 = _755 * (_781 + (_788 * aPosition.xy));
    }
    else
    {
        _1820 = _1451 + (_1453 * aPosition.xy);
    }
    vec2 _1491 = clamp(_1820, _1060, _1474);
    vec4 _838 = _1787 * vec4(_1491, 0.0, 1.0);
    vec2 _841 = _838.xy;
    float _861 = _838.w;
    gl_Position = uTransform * vec4((_841 * _1252) + (((-_1284.zw) + texelFetch(sRenderTasks, _1274, 0).xy) * _861), float(_1079.x) * _861, _861);
    vec2 _885 = ((_745 * _1491) - _781) / _788;
    varying_vec4_1 = vec4(_885, vec2(1.0) - _885);
    vClipMaskUvBounds = vec4(_1817, _1817 + _1816);
    vClipMaskUv = vec4((_841 * _1814) + ((_1817 - _1813) * _861), _1815, _861);
    switch (_1824)
    {
        case 1:
        case 7:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0, 1.0).x, vec2(0.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _1318;
            break;
        }
        case 5:
        case 6:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = _1318;
            break;
        }
        case 2:
        case 3:
        case 8:
        {
            flat_varying_vec4_1 = vec4(vec2(1.0, 0.0).x, vec2(1.0, 0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_1318.w);
            break;
        }
        case 4:
        {
            flat_varying_vec4_1 = vec4(vec2(-1.0, 1.0).x, vec2(-1.0, 1.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(_1318.w) * texelFetch(sGpuCache, _1334 + ivec2(1, 0), 0);
            break;
        }
        default:
        {
            flat_varying_vec4_1 = vec4(vec2(0.0).x, vec2(0.0).y, flat_varying_vec4_1.z, flat_varying_vec4_1.w);
            flat_varying_vec4_0 = vec4(1.0);
            break;
        }
    }
    vec2 _955 = vec2(vec3(textureSize(sColor0, 0)).xy);
    vec2 _972 = mix(_787 / _955, _784 / _955, _885);
    varying_vec4_0 = vec4(_972.x, _972.y, varying_vec4_0.z, varying_vec4_0.w);
    varying_vec4_0.z = _1409.x;
    flat_varying_vec4_2 = (_1404 + vec4(0.5, 0.5, -0.5, -0.5)) / _955.xyxy;
}

