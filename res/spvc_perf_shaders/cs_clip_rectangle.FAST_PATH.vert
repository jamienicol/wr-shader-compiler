#version 300 es

uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform mat4 uTransform;

flat out vec4 vTransformBounds;
layout(location = 1) in ivec2 aTransformIds;
layout(location = 2) in ivec4 aClipDataResourceAddress;
layout(location = 3) in vec2 aClipLocalPos;
layout(location = 4) in vec4 aClipTileRect;
layout(location = 5) in vec4 aClipDeviceArea;
layout(location = 6) in vec4 aClipOrigins;
layout(location = 7) in float aDevicePixelScale;
layout(location = 0) in vec3 aPosition;
flat out float vClipMode;
out vec4 vLocalPos;
flat out vec3 vClipParams;

mat4 _1489;
float _1491;

void main()
{
    uint _686 = uint(aTransformIds.x & 16777215);
    ivec2 _700 = ivec2(int(8u * (_686 % 128u)), int(_686 / 128u));
    mat4 _1448 = _1489;
    _1448[0] = texelFetch(sTransformPalette, _700, 0);
    mat4 _1450 = _1448;
    _1450[1] = texelFetch(sTransformPalette, _700 + ivec2(1, 0), 0);
    mat4 _1452 = _1450;
    _1452[2] = texelFetch(sTransformPalette, _700 + ivec2(2, 0), 0);
    mat4 _1454 = _1452;
    _1454[3] = texelFetch(sTransformPalette, _700 + ivec2(3, 0), 0);
    vec4 _729 = texelFetch(sTransformPalette, _700 + ivec2(4, 0), 0);
    mat4 _1456 = _1489;
    _1456[0] = _729;
    vec4 _735 = texelFetch(sTransformPalette, _700 + ivec2(5, 0), 0);
    mat4 _1458 = _1456;
    _1458[1] = _735;
    vec4 _741 = texelFetch(sTransformPalette, _700 + ivec2(6, 0), 0);
    mat4 _1460 = _1458;
    _1460[2] = _741;
    mat4 _1462 = _1460;
    _1462[3] = texelFetch(sTransformPalette, _700 + ivec2(7, 0), 0);
    uint _762 = uint(aTransformIds.y & 16777215);
    ivec2 _776 = ivec2(int(8u * (_762 % 128u)), int(_762 / 128u));
    mat4 _1466 = _1489;
    _1466[0] = texelFetch(sTransformPalette, _776, 0);
    mat4 _1468 = _1466;
    _1468[1] = texelFetch(sTransformPalette, _776 + ivec2(1, 0), 0);
    mat4 _1470 = _1468;
    _1470[2] = texelFetch(sTransformPalette, _776 + ivec2(2, 0), 0);
    mat4 _1472 = _1470;
    _1472[3] = texelFetch(sTransformPalette, _776 + ivec2(3, 0), 0);
    vec2 _864 = texelFetch(sGpuCache, aClipDataResourceAddress.xy, 0).zw;
    vec4 _916 = texelFetch(sGpuCache, aClipDataResourceAddress.xy + ivec2(3, 0), 0);
    vec2 _1045 = aPosition.xy * aClipDeviceArea.zw;
    vec4 _1057 = _1472 * vec4(((aClipOrigins.zw + aClipDeviceArea.xy) + _1045) / vec2(aDevicePixelScale), 0.0, 1.0);
    float _1059 = _1057.w;
    vec3 _1063 = _1057.xyz / vec3(_1059);
    vec4 _1118 = _1454 * vec4(0.0, 0.0, 0.0, 1.0);
    vec3 _1135 = transpose(mat3(_729.xyz, _735.xyz, _741.xyz)) * vec3(0.0, 0.0, 1.0);
    float _1154 = _1063.x;
    float _1490;
    switch (0u)
    {
        default:
        {
            float _1187 = _1135.z;
            if (abs(_1187) > 9.9999999747524270787835121154785e-07)
            {
                _1490 = dot((_1118.xyz / vec3(_1118.w)) - vec3(_1154, _1063.y, -10000.0), _1135) / _1187;
                break;
            }
            _1490 = _1491;
            break;
        }
    }
    vec4 _1073 = (_1462 * vec4(_1154, _1063.y, (-10000.0) + _1490, 1.0)) * _1059;
    gl_Position = uTransform * vec4((aClipOrigins.xy + aClipDeviceArea.xy) + _1045, 0.0, 1.0);
    vTransformBounds = vec4(aClipLocalPos, aClipLocalPos + _864);
    vClipMode = texelFetch(sGpuCache, aClipDataResourceAddress.xy + ivec2(1, 0), 0).x;
    vLocalPos = _1073;
    vec2 _594 = _864 * 0.5;
    float _597 = _916.x;
    vec2 _607 = vLocalPos.xy - ((_594 + aClipLocalPos) * _1073.w);
    vLocalPos = vec4(_607.x, _607.y, vLocalPos.z, vLocalPos.w);
    vClipParams = vec3(_594 - vec2(_597), _597);
}

