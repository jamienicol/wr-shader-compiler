#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform mat4 uTransform;

layout(location = 0) in vec3 aPosition;
layout(location = 2) in int aFilterRenderTaskAddress;
layout(location = 6) in int aFilterInputCount;
layout(location = 3) in int aFilterInput1TaskAddress;
flat out vec4 vInput1UvRect;
out vec3 vInput1Uv;
layout(location = 4) in int aFilterInput2TaskAddress;
flat out vec4 vInput2UvRect;
out vec3 vInput2Uv;
flat out int vFilterInputCount;
flat out int vFilterKind;
layout(location = 5) in int aFilterKind;
flat out int vFuncs[4];
layout(location = 7) in int aFilterGenericInt;
flat out ivec4 vData;
flat out vec4 vFilterData0;
layout(location = 8) in ivec2 aFilterExtraDataAddress;
flat out float vFloat0;
flat out mat4 vColorMat;
flat out vec4 vFilterData1;
flat out vec4 vTransformBounds;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
layout(location = 1) in ivec4 aData;

vec2 _931;

void main()
{
    uint _555 = uint(aFilterRenderTaskAddress);
    ivec2 _563 = ivec2(int(2u * (_555 % 512u)), int(_555 / 512u));
    vec4 _568 = texelFetch(sRenderTasks, _563, 0);
    vec4 _573 = texelFetch(sRenderTasks, _563 + ivec2(1, 0), 0);
    vec2 _930;
    vec2 _933;
    if (aFilterInputCount > 0)
    {
        vec2 _292 = vec2(textureSize(sColor0, 0).xy);
        uint _595 = uint(aFilterInput1TaskAddress);
        ivec2 _603 = ivec2(int(2u * (_595 % 512u)), int(_595 / 512u));
        vec4 _608 = texelFetch(sRenderTasks, _603, 0);
        vec2 _615 = _608.xy;
        vec2 _617 = _608.zw;
        vec2 _636 = _615 + _617;
        vInput1UvRect = vec4(_615 + vec2(0.5), _636 - vec2(0.5)) / _292.xyxy;
        vec2 _674 = mix(_615 / _292, floor(_636) / _292, aPosition.xy);
        vInput1Uv = vec3(_674.x, _674.y, vec3(0.0, 0.0, texelFetch(sRenderTasks, _603 + ivec2(1, 0), 0).x).z);
        _933 = _615;
        _930 = _617;
    }
    else
    {
        _933 = _931;
        _930 = _931;
    }
    if (aFilterInputCount > 1)
    {
        vec2 _322 = vec2(textureSize(sColor1, 0).xy);
        uint _685 = uint(aFilterInput2TaskAddress);
        ivec2 _693 = ivec2(int(2u * (_685 % 512u)), int(_685 / 512u));
        vec4 _698 = texelFetch(sRenderTasks, _693, 0);
        vec2 _705 = _698.xy;
        vec2 _726 = _705 + _698.zw;
        vInput2UvRect = vec4(_705 + vec2(0.5), _726 - vec2(0.5)) / _322.xyxy;
        vec2 _764 = mix(_705 / _322, floor(_726) / _322, aPosition.xy);
        vInput2Uv = vec3(_764.x, _764.y, vec3(0.0, 0.0, texelFetch(sRenderTasks, _693 + ivec2(1, 0), 0).x).z);
    }
    vFilterInputCount = aFilterInputCount;
    vFilterKind = aFilterKind;
    vFuncs[0] = (aFilterGenericInt >> 12) & 15;
    vFuncs[1] = (aFilterGenericInt >> 8) & 15;
    vFuncs[2] = (aFilterGenericInt >> 4) & 15;
    vFuncs[3] = aFilterGenericInt & 15;
    switch (aFilterKind)
    {
        case 0:
        {
            vData = ivec4(aFilterGenericInt, 0, 0, 0);
            break;
        }
        case 1:
        {
            vFilterData0 = texelFetch(sGpuCache, aFilterExtraDataAddress, 0);
            break;
        }
        case 4:
        {
            vFloat0 = _573.y;
            break;
        }
        case 5:
        {
            vColorMat = mat4(texelFetch(sGpuCache, aFilterExtraDataAddress, 0), texelFetch(sGpuCache, aFilterExtraDataAddress + ivec2(1, 0), 0), texelFetch(sGpuCache, aFilterExtraDataAddress + ivec2(2, 0), 0), texelFetch(sGpuCache, aFilterExtraDataAddress + ivec2(3, 0), 0));
            vFilterData0 = texelFetch(sGpuCache, aFilterExtraDataAddress + ivec2(4, 0), 0);
            break;
        }
        case 6:
        {
            vFilterData0 = texelFetch(sGpuCache, aFilterExtraDataAddress, 0);
            break;
        }
        case 7:
        {
            vec2 _451 = vec2(textureSize(sColor0, 0).xy);
            vFilterData0 = vec4((-_573.yz) / _451, 0.0, 0.0);
            vFilterData1 = vec4(_933, _933 + _930) / _451.xyxy;
            break;
        }
        case 8:
        {
            vData = ivec4(aFilterExtraDataAddress, 0, 0);
            break;
        }
        case 10:
        {
            vData = ivec4(aFilterGenericInt, 0, 0, 0);
            if (aFilterGenericInt == 6)
            {
                vFilterData0 = texelFetch(sGpuCache, aFilterExtraDataAddress, 0);
            }
            break;
        }
        default:
        {
            break;
        }
    }
    gl_Position = uTransform * vec4(_568.xy + (_568.zw * aPosition.xy), 0.0, 1.0);
}

