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

float _1831;
mat4 _1879;

void main()
{
    uint _686 = uint(aTransformIds.x & 16777215);
    ivec2 _700 = ivec2(int(8u * (_686 % 128u)), int(_686 / 128u));
    mat4 _1846 = _1879;
    _1846[0] = texelFetch(sTransformPalette, _700, 0);
    mat4 _1848 = _1846;
    _1848[1] = texelFetch(sTransformPalette, _700 + ivec2(1, 0), 0);
    mat4 _1850 = _1848;
    _1850[2] = texelFetch(sTransformPalette, _700 + ivec2(2, 0), 0);
    mat4 _1852 = _1850;
    _1852[3] = texelFetch(sTransformPalette, _700 + ivec2(3, 0), 0);
    vec4 _729 = texelFetch(sTransformPalette, _700 + ivec2(4, 0), 0);
    mat4 _1854 = _1879;
    _1854[0] = _729;
    vec4 _735 = texelFetch(sTransformPalette, _700 + ivec2(5, 0), 0);
    mat4 _1856 = _1854;
    _1856[1] = _735;
    vec4 _741 = texelFetch(sTransformPalette, _700 + ivec2(6, 0), 0);
    mat4 _1858 = _1856;
    _1858[2] = _741;
    mat4 _1860 = _1858;
    _1860[3] = texelFetch(sTransformPalette, _700 + ivec2(7, 0), 0);
    uint _762 = uint(aTransformIds.y & 16777215);
    ivec2 _776 = ivec2(int(8u * (_762 % 128u)), int(_762 / 128u));
    mat4 _1864 = _1879;
    _1864[0] = texelFetch(sTransformPalette, _776, 0);
    mat4 _1866 = _1864;
    _1866[1] = texelFetch(sTransformPalette, _776 + ivec2(1, 0), 0);
    mat4 _1868 = _1866;
    _1868[2] = texelFetch(sTransformPalette, _776 + ivec2(2, 0), 0);
    mat4 _1870 = _1868;
    _1870[3] = texelFetch(sTransformPalette, _776 + ivec2(3, 0), 0);
    vec2 _864 = texelFetch(sGpuCache, aClipDataResourceAddress.xy, 0).zw;
    vec4 _916 = texelFetch(sGpuCache, aClipDataResourceAddress.xy + ivec2(3, 0), 0);
    vec2 _1045 = aPosition.xy * aClipDeviceArea.zw;
    vec4 _1057 = _1870 * vec4(((aClipOrigins.zw + aClipDeviceArea.xy) + _1045) / vec2(aDevicePixelScale), 0.0, 1.0);
    vec3 _1063 = _1057.xyz / vec3(_1057.w);
    vec4 _1118 = _1852 * vec4(0.0, 0.0, 0.0, 1.0);
    vec3 _1135 = transpose(mat3(_729.xyz, _735.xyz, _741.xyz)) * vec3(0.0, 0.0, 1.0);
    float _1154 = _1063.x;
    float _1830;
    switch (0u)
    {
        default:
        {
            float _1187 = _1135.z;
            if (abs(_1187) > 9.9999999747524270787835121154785e-07)
            {
                _1830 = dot((_1118.xyz / vec3(_1118.w)) - vec3(_1154, _1063.y, -10000.0), _1135) / _1187;
                break;
            }
            _1830 = _1831;
            break;
        }
    }
    vec4 _1073 = (_1860 * vec4(_1154, _1063.y, (-10000.0) + _1830, 1.0)) * _1057.w;
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

