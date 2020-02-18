#version 300 es

struct RectWithSize
{
    vec2 p0;
    vec2 size;
};

struct RenderTaskCommonData
{
    RectWithSize task_rect;
    float texture_layer_index;
};

struct RenderTaskData
{
    RenderTaskCommonData common_data;
    vec3 user_data;
};

struct BlurTask
{
    RenderTaskCommonData common_data;
    float blur_radius;
    vec2 blur_region;
};

uniform highp sampler2D sRenderTasks;
uniform highp sampler2DArray sPrevPassAlpha;
uniform mat4 uTransform;
uniform int uMode;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2DArray sPrevPassColor;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;

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

RenderTaskData fetch_render_task_data(int index)
{
    ivec2 uv = ivec2(int(2u * (uint(index) % 512u)), int(uint(index) / 512u));
    vec4 texel0 = texelFetch(sRenderTasks, uv + ivec2(0), 0);
    vec4 texel1 = texelFetch(sRenderTasks, uv + ivec2(1, 0), 0);
    RectWithSize task_rect = RectWithSize(texel0.xy, texel0.zw);
    RenderTaskCommonData common_data = RenderTaskCommonData(task_rect, texel1.x);
    RenderTaskData data = RenderTaskData(common_data, texel1.yzw);
    return data;
}

BlurTask fetch_blur_task(int address)
{
    int param = address;
    RenderTaskData task_data = fetch_render_task_data(param);
    BlurTask task = BlurTask(task_data.common_data, task_data.user_data.x, task_data.user_data.yz);
    return task;
}

RenderTaskCommonData fetch_render_task_common_data(int index)
{
    ivec2 uv = ivec2(int(2u * (uint(index) % 512u)), int(uint(index) / 512u));
    vec4 texel0 = texelFetch(sRenderTasks, uv + ivec2(0), 0);
    vec4 texel1 = texelFetch(sRenderTasks, uv + ivec2(1, 0), 0);
    RectWithSize task_rect = RectWithSize(texel0.xy, texel0.zw);
    RenderTaskCommonData data = RenderTaskCommonData(task_rect, texel1.x);
    return data;
}

void main()
{
    int param = aBlurRenderTaskAddress;
    BlurTask blur_task = fetch_blur_task(param);
    int param_1 = aBlurSourceTaskAddress;
    RenderTaskCommonData src_task = fetch_render_task_common_data(param_1);
    RectWithSize src_rect = src_task.task_rect;
    RectWithSize target_rect = blur_task.common_data.task_rect;
    vec2 texture_size = vec2(textureSize(sPrevPassAlpha, 0).xy);
    vUv.z = src_task.texture_layer_index;
    vSigma = blur_task.blur_radius;
    vSupport = int(ceil(1.5 * blur_task.blur_radius)) * 2;
    switch (aBlurDirection)
    {
        case 0:
        {
            vOffsetScale = vec2(1.0 / texture_size.x, 0.0);
            break;
        }
        case 1:
        {
            vOffsetScale = vec2(0.0, 1.0 / texture_size.y);
            break;
        }
        default:
        {
            vOffsetScale = vec2(0.0);
            break;
        }
    }
    vUvRect = vec4(src_rect.p0 + vec2(0.5), (src_rect.p0 + blur_task.blur_region) - vec2(0.5));
    vUvRect /= texture_size.xyxy;
    vec2 pos = target_rect.p0 + (target_rect.size * aPosition.xy);
    vec2 uv0 = src_rect.p0 / texture_size;
    vec2 uv1 = (src_rect.p0 + src_rect.size) / texture_size;
    vec2 _265 = mix(uv0, uv1, aPosition.xy);
    vUv = vec3(_265.x, _265.y, vUv.z);
    gl_Position = uTransform * vec4(pos, 0.0, 1.0);
}

