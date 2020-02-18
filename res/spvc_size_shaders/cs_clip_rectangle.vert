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
flat out vec4 vClipCenter_Radius_TL;
flat out vec4 vClipCenter_Radius_TR;
flat out vec4 vClipCenter_Radius_BR;
flat out vec4 vClipCenter_Radius_BL;

float _1943;
mat4 _2001;

void main()
{
    uint _747 = uint(aTransformIds.x & 16777215);
    ivec2 _761 = ivec2(int(8u * (_747 % 128u)), int(_747 / 128u));
    mat4 _1962 = _2001;
    _1962[0] = texelFetch(sTransformPalette, _761, 0);
    mat4 _1964 = _1962;
    _1964[1] = texelFetch(sTransformPalette, _761 + ivec2(1, 0), 0);
    mat4 _1966 = _1964;
    _1966[2] = texelFetch(sTransformPalette, _761 + ivec2(2, 0), 0);
    mat4 _1968 = _1966;
    _1968[3] = texelFetch(sTransformPalette, _761 + ivec2(3, 0), 0);
    vec4 _790 = texelFetch(sTransformPalette, _761 + ivec2(4, 0), 0);
    mat4 _1970 = _2001;
    _1970[0] = _790;
    vec4 _796 = texelFetch(sTransformPalette, _761 + ivec2(5, 0), 0);
    mat4 _1972 = _1970;
    _1972[1] = _796;
    vec4 _802 = texelFetch(sTransformPalette, _761 + ivec2(6, 0), 0);
    mat4 _1974 = _1972;
    _1974[2] = _802;
    mat4 _1976 = _1974;
    _1976[3] = texelFetch(sTransformPalette, _761 + ivec2(7, 0), 0);
    uint _823 = uint(aTransformIds.y & 16777215);
    ivec2 _837 = ivec2(int(8u * (_823 % 128u)), int(_823 / 128u));
    mat4 _1980 = _2001;
    _1980[0] = texelFetch(sTransformPalette, _837, 0);
    mat4 _1982 = _1980;
    _1982[1] = texelFetch(sTransformPalette, _837 + ivec2(1, 0), 0);
    mat4 _1984 = _1982;
    _1984[2] = texelFetch(sTransformPalette, _837 + ivec2(2, 0), 0);
    mat4 _1986 = _1984;
    _1986[3] = texelFetch(sTransformPalette, _837 + ivec2(3, 0), 0);
    vec4 _977 = texelFetch(sGpuCache, aClipDataResourceAddress.xy + ivec2(3, 0), 0);
    vec4 _1013 = texelFetch(sGpuCache, aClipDataResourceAddress.xy + ivec2(5, 0), 0);
    vec4 _1049 = texelFetch(sGpuCache, aClipDataResourceAddress.xy + ivec2(7, 0), 0);
    vec4 _1085 = texelFetch(sGpuCache, aClipDataResourceAddress.xy + ivec2(9, 0), 0);
    vec2 _1106 = aPosition.xy * aClipDeviceArea.zw;
    vec4 _1118 = _1986 * vec4(((aClipOrigins.zw + aClipDeviceArea.xy) + _1106) / vec2(aDevicePixelScale), 0.0, 1.0);
    vec3 _1124 = _1118.xyz / vec3(_1118.w);
    vec4 _1179 = _1968 * vec4(0.0, 0.0, 0.0, 1.0);
    vec3 _1196 = transpose(mat3(_790.xyz, _796.xyz, _802.xyz)) * vec3(0.0, 0.0, 1.0);
    float _1215 = _1124.x;
    float _1942;
    switch (0u)
    {
        default:
        {
            float _1248 = _1196.z;
            if (abs(_1248) > 9.9999999747524270787835121154785e-07)
            {
                _1942 = dot((_1179.xyz / vec3(_1179.w)) - vec3(_1215, _1124.y, -10000.0), _1196) / _1248;
                break;
            }
            _1942 = _1943;
            break;
        }
    }
    gl_Position = uTransform * vec4((aClipOrigins.xy + aClipDeviceArea.xy) + _1106, 0.0, 1.0);
    vec2 _1158 = aClipLocalPos + texelFetch(sGpuCache, aClipDataResourceAddress.xy, 0).zw;
    float _1161 = _1158.x;
    vTransformBounds = vec4(aClipLocalPos, _1161, _1158.y);
    vClipMode = texelFetch(sGpuCache, aClipDataResourceAddress.xy + ivec2(1, 0), 0).x;
    vLocalPos = (_1976 * vec4(_1215, _1124.y, (-10000.0) + _1942, 1.0)) * _1118.w;
    vClipCenter_Radius_TL = vec4(aClipLocalPos + _977.xy, _977.xy);
    vClipCenter_Radius_TR = vec4(_1161 - _1013.x, aClipLocalPos.y + _1013.y, _1013.xy);
    vClipCenter_Radius_BR = vec4(_1158 - _1085.xy, _1085.xy);
    vClipCenter_Radius_BL = vec4(aClipLocalPos.x + _1049.x, _1158.y - _1049.y, _1049.xy);
}

