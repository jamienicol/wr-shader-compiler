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
out vec4 vLocalPos;
flat out float vLayer;
out vec2 vClipMaskImageUv;
flat out vec4 vClipMaskUvRect;
flat out vec4 vClipMaskUvInnerRect;

float _1359;
mat4 _1407;

void main()
{
    uint _683 = uint(aTransformIds.x & 16777215);
    ivec2 _697 = ivec2(int(8u * (_683 % 128u)), int(_683 / 128u));
    mat4 _1375 = _1407;
    _1375[0] = texelFetch(sTransformPalette, _697, 0);
    mat4 _1377 = _1375;
    _1377[1] = texelFetch(sTransformPalette, _697 + ivec2(1, 0), 0);
    mat4 _1379 = _1377;
    _1379[2] = texelFetch(sTransformPalette, _697 + ivec2(2, 0), 0);
    mat4 _1381 = _1379;
    _1381[3] = texelFetch(sTransformPalette, _697 + ivec2(3, 0), 0);
    vec4 _726 = texelFetch(sTransformPalette, _697 + ivec2(4, 0), 0);
    mat4 _1383 = _1407;
    _1383[0] = _726;
    vec4 _732 = texelFetch(sTransformPalette, _697 + ivec2(5, 0), 0);
    mat4 _1385 = _1383;
    _1385[1] = _732;
    vec4 _738 = texelFetch(sTransformPalette, _697 + ivec2(6, 0), 0);
    mat4 _1387 = _1385;
    _1387[2] = _738;
    mat4 _1389 = _1387;
    _1389[3] = texelFetch(sTransformPalette, _697 + ivec2(7, 0), 0);
    uint _759 = uint(aTransformIds.y & 16777215);
    ivec2 _773 = ivec2(int(8u * (_759 % 128u)), int(_759 / 128u));
    mat4 _1393 = _1407;
    _1393[0] = texelFetch(sTransformPalette, _773, 0);
    mat4 _1395 = _1393;
    _1395[1] = texelFetch(sTransformPalette, _773 + ivec2(1, 0), 0);
    mat4 _1397 = _1395;
    _1397[2] = texelFetch(sTransformPalette, _773 + ivec2(2, 0), 0);
    mat4 _1399 = _1397;
    _1399[3] = texelFetch(sTransformPalette, _773 + ivec2(3, 0), 0);
    vec4 _863 = texelFetch(sGpuCache, aClipDataResourceAddress.zw, 0);
    vec2 _889 = aPosition.xy * aClipDeviceArea.zw;
    vec4 _901 = _1399 * vec4(((aClipOrigins.zw + aClipDeviceArea.xy) + _889) / vec2(aDevicePixelScale), 0.0, 1.0);
    vec3 _907 = _901.xyz / vec3(_901.w);
    vec4 _962 = _1381 * vec4(0.0, 0.0, 0.0, 1.0);
    vec3 _979 = transpose(mat3(_726.xyz, _732.xyz, _738.xyz)) * vec3(0.0, 0.0, 1.0);
    float _998 = _907.x;
    float _1358;
    switch (0u)
    {
        default:
        {
            float _1031 = _979.z;
            if (abs(_1031) > 9.9999999747524270787835121154785e-07)
            {
                _1358 = dot((_962.xyz / vec3(_962.w)) - vec3(_998, _907.y, -10000.0), _979) / _1031;
                break;
            }
            _1358 = _1359;
            break;
        }
    }
    vec4 _917 = (_1389 * vec4(_998, _907.y, (-10000.0) + _1358, 1.0)) * _901.w;
    gl_Position = uTransform * vec4((aClipOrigins.xy + aClipDeviceArea.xy) + _889, 0.0, 1.0);
    vTransformBounds = vec4(aClipLocalPos, aClipLocalPos + texelFetch(sGpuCache, aClipDataResourceAddress.xy, 0).xy);
    vLocalPos = _917;
    vLayer = texelFetch(sGpuCache, aClipDataResourceAddress.zw + ivec2(1, 0), 0).x;
    vClipMaskImageUv = (_917.xy - (aClipTileRect.xy * _917.w)) / aClipTileRect.zw;
    vec4 _600 = vec2(vec3(textureSize(sColor0, 0)).xy).xyxy;
    vClipMaskUvRect = vec4(_863.xy, _863.zw - _863.xy) / _600;
    vClipMaskUvInnerRect = (_863 + vec4(0.5, 0.5, -0.5, -0.5)) / _600;
}

