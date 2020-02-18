#version 300 es

uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform mat4 uTransform;
uniform highp sampler2DArray sColor0;

flat out vec4 vTransformBounds;
layout(location = 1) in ivec2 aTransformIds;
layout(location = 2) in ivec4 aClipDataResourceAddress;
layout(location = 3) in vec2 aClipLocalPos;
layout(location = 4) in vec4 aClipTileRect;
layout(location = 5) in vec4 aClipDeviceArea;
layout(location = 6) in vec4 aClipOrigins;
layout(location = 7) in float aDevicePixelScale;
layout(location = 0) in vec3 aPosition;
flat out float vLayer;
flat out float vClipMode;
out vec4 vLocalPos;
flat out vec4 vEdge;
out vec2 vUv;
flat out vec4 vUvBounds;
flat out vec4 vUvBounds_NoClamp;

mat4 _1414;
float _1416;

void main()
{
    uint _786 = uint(aTransformIds.x & 16777215);
    ivec2 _800 = ivec2(int(8u * (_786 % 128u)), int(_786 / 128u));
    mat4 _1354 = _1414;
    _1354[0] = texelFetch(sTransformPalette, _800, 0);
    mat4 _1356 = _1354;
    _1356[1] = texelFetch(sTransformPalette, _800 + ivec2(1, 0), 0);
    mat4 _1358 = _1356;
    _1358[2] = texelFetch(sTransformPalette, _800 + ivec2(2, 0), 0);
    mat4 _1360 = _1358;
    _1360[3] = texelFetch(sTransformPalette, _800 + ivec2(3, 0), 0);
    vec4 _829 = texelFetch(sTransformPalette, _800 + ivec2(4, 0), 0);
    mat4 _1362 = _1414;
    _1362[0] = _829;
    vec4 _835 = texelFetch(sTransformPalette, _800 + ivec2(5, 0), 0);
    mat4 _1364 = _1362;
    _1364[1] = _835;
    vec4 _841 = texelFetch(sTransformPalette, _800 + ivec2(6, 0), 0);
    mat4 _1366 = _1364;
    _1366[2] = _841;
    mat4 _1368 = _1366;
    _1368[3] = texelFetch(sTransformPalette, _800 + ivec2(7, 0), 0);
    uint _862 = uint(aTransformIds.y & 16777215);
    ivec2 _876 = ivec2(int(8u * (_862 % 128u)), int(_862 / 128u));
    mat4 _1372 = _1414;
    _1372[0] = texelFetch(sTransformPalette, _876, 0);
    mat4 _1374 = _1372;
    _1374[1] = texelFetch(sTransformPalette, _876 + ivec2(1, 0), 0);
    mat4 _1376 = _1374;
    _1376[2] = texelFetch(sTransformPalette, _876 + ivec2(2, 0), 0);
    mat4 _1378 = _1376;
    _1378[3] = texelFetch(sTransformPalette, _876 + ivec2(3, 0), 0);
    vec4 _959 = texelFetch(sGpuCache, aClipDataResourceAddress.xy, 0);
    vec4 _964 = texelFetch(sGpuCache, aClipDataResourceAddress.xy + ivec2(1, 0), 0);
    vec4 _969 = texelFetch(sGpuCache, aClipDataResourceAddress.xy + ivec2(2, 0), 0);
    vec4 _996 = texelFetch(sGpuCache, aClipDataResourceAddress.zw, 0);
    vec2 _1022 = aPosition.xy * aClipDeviceArea.zw;
    vec4 _1034 = _1378 * vec4(((aClipOrigins.zw + aClipDeviceArea.xy) + _1022) / vec2(aDevicePixelScale), 0.0, 1.0);
    float _1036 = _1034.w;
    vec3 _1040 = _1034.xyz / vec3(_1036);
    vec4 _1095 = _1360 * vec4(0.0, 0.0, 0.0, 1.0);
    vec3 _1112 = transpose(mat3(_829.xyz, _835.xyz, _841.xyz)) * vec3(0.0, 0.0, 1.0);
    float _1131 = _1040.x;
    float _1415;
    switch (0u)
    {
        default:
        {
            float _1164 = _1112.z;
            if (abs(_1164) > 9.9999999747524270787835121154785e-07)
            {
                _1415 = dot((_1095.xyz / vec3(_1095.w)) - vec3(_1131, _1040.y, -10000.0), _1112) / _1164;
                break;
            }
            _1415 = _1416;
            break;
        }
    }
    vec4 _1050 = (_1368 * vec4(_1131, _1040.y, (-10000.0) + _1415, 1.0)) * _1036;
    gl_Position = uTransform * vec4((aClipOrigins.xy + aClipDeviceArea.xy) + _1022, 0.0, 1.0);
    float _1075 = _969.x;
    float _1076 = _969.y;
    vTransformBounds = vec4(_1075, _1076, _969.xy + _969.zw);
    vLayer = texelFetch(sGpuCache, aClipDataResourceAddress.zw + ivec2(1, 0), 0).x;
    vClipMode = _959.z;
    float _606 = _1050.w;
    vec2 _608 = _1050.xy / vec2(_606);
    vLocalPos = _1050;
    switch (int(_964.x))
    {
        case 0:
        {
            vEdge.x = 0.5;
            float _623 = _959.x;
            vEdge.z = (_969.z / _623) - 0.5;
            vUv.x = (_608.x - _1075) / _623;
            break;
        }
        default:
        {
            vEdge = vec4(vec2(1.0).x, vEdge.y, vec2(1.0).y, vEdge.w);
            vUv.x = (_608.x - _1075) / _969.z;
            break;
        }
    }
    switch (int(_964.y))
    {
        case 0:
        {
            vEdge.y = 0.5;
            float _662 = _959.y;
            vEdge.w = (_969.w / _662) - 0.5;
            vUv.y = (_608.y - _1076) / _662;
            break;
        }
        default:
        {
            vEdge = vec4(vEdge.x, vec2(1.0).x, vEdge.z, vec2(1.0).y);
            vUv.y = (_608.y - _1076) / _969.w;
            break;
        }
    }
    vUv *= _606;
    vec4 _711 = vec2(vec3(textureSize(sColor0, 0)).xy).xyxy;
    vUvBounds = vec4(_996.xy + vec2(0.5), _996.zw - vec2(0.5)) / _711;
    vUvBounds_NoClamp = _996 / _711;
}

