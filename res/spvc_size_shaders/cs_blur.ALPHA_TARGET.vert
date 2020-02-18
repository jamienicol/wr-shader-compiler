#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2DArray sPrevPassAlpha;
uniform mat4 uTransform;

layout(location = 2) in int aBlurRenderTaskAddress;
layout(location = 3) in int aBlurSourceTaskAddress;
out vec3 vUv;
flat out float vSigma;
flat out int vSupport;
layout(location = 4) in int aBlurDirection;
flat out vec2 vOffsetScale;
flat out vec4 vUvRect;
layout(location = 0) in vec3 aPosition;
flat out vec4 vTransformBounds;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
layout(location = 1) in ivec4 aData;

void main()
{
    uint _326 = uint(aBlurRenderTaskAddress);
    ivec2 _334 = ivec2(int(2u * (_326 % 512u)), int(_326 / 512u));
    vec4 _339 = texelFetch(sRenderTasks, _334, 0);
    vec4 _344 = texelFetch(sRenderTasks, _334 + ivec2(1, 0), 0);
    float _312 = _344.y;
    uint _366 = uint(aBlurSourceTaskAddress);
    ivec2 _374 = ivec2(int(2u * (_366 % 512u)), int(_366 / 512u));
    vec4 _379 = texelFetch(sRenderTasks, _374, 0);
    vec2 _386 = _379.xy;
    vec2 _173 = vec2(textureSize(sPrevPassAlpha, 0).xy);
    vUv.z = texelFetch(sRenderTasks, _374 + ivec2(1, 0), 0).x;
    vSigma = _312;
    vSupport = int(ceil(1.5 * _312)) * 2;
    switch (aBlurDirection)
    {
        case 0:
        {
            vOffsetScale = vec2(1.0 / _173.x, 0.0);
            break;
        }
        case 1:
        {
            vOffsetScale = vec2(0.0, 1.0 / _173.y);
            break;
        }
        default:
        {
            vOffsetScale = vec2(0.0);
            break;
        }
    }
    vUvRect = vec4(_386 + vec2(0.5), (_386 + _344.zw) - vec2(0.5));
    vUvRect /= _173.xyxy;
    vec2 _266 = mix(_386 / _173, (_386 + _379.zw) / _173, aPosition.xy);
    vUv = vec3(_266.x, _266.y, vUv.z);
    gl_Position = uTransform * vec4(_339.xy + (_339.zw * aPosition.xy), 0.0, 1.0);
}

