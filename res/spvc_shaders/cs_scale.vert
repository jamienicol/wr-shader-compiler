#version 300 es

struct RectWithSize
{
    vec2 p0;
    vec2 size;
};

uniform highp sampler2DArray sColor0;
uniform mat4 uTransform;
uniform int uMode;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;

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
    RectWithSize src_rect = RectWithSize(vec2(aScaleSourceRect.xy), vec2(aScaleSourceRect.zw));
    vec2 texture_size = vec2(textureSize(sColor0, 0).xy);
    vUv.z = float(aScaleSourceLayer);
    vUvRect = vec4(src_rect.p0 + vec2(0.5), (src_rect.p0 + src_rect.size) - vec2(0.5)) / texture_size.xyxy;
    vec2 pos = aScaleTargetRect.xy + (aScaleTargetRect.zw * aPosition.xy);
    vec2 _92 = (src_rect.p0 + (src_rect.size * aPosition.xy)) / texture_size;
    vUv = vec3(_92.x, _92.y, vUv.z);
    gl_Position = uTransform * vec4(pos, 0.0, 1.0);
}

