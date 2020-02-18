#version 300 es

uniform highp sampler2DArray sColor0;
uniform mat4 uTransform;

layout(location = 3) in ivec4 aScaleSourceRect;
out vec3 vUv;
layout(location = 4) in int aScaleSourceLayer;
flat out vec4 vUvRect;
layout(location = 2) in vec4 aScaleTargetRect;
layout(location = 0) in vec3 aPosition;
flat out vec4 vTransformBounds;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
layout(location = 1) in ivec4 aData;

void main()
{
    vec2 _19 = vec2(aScaleSourceRect.xy);
    vec2 _22 = vec2(aScaleSourceRect.zw);
    vec2 _36 = vec2(textureSize(sColor0, 0).xy);
    vUv.z = float(aScaleSourceLayer);
    vUvRect = vec4(_19 + vec2(0.5), (_19 + _22) - vec2(0.5)) / _36.xyxy;
    vec2 _93 = (_19 + (_22 * aPosition.xy)) / _36;
    vUv = vec3(_93.x, _93.y, vUv.z);
    gl_Position = uTransform * vec4(aScaleTargetRect.xy + (aScaleTargetRect.zw * aPosition.xy), 0.0, 1.0);
}

