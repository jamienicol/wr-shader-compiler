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

struct FilterTask
{
    RenderTaskCommonData common_data;
    vec3 user_data;
};

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform mat4 uTransform;
uniform int uMode;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;

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

FilterTask fetch_filter_task(int address)
{
    int param = address;
    RenderTaskData task_data = fetch_render_task_data(param);
    FilterTask task = FilterTask(task_data.common_data, task_data.user_data);
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

vec4 compute_uv_rect(RenderTaskCommonData task, vec2 texture_size)
{
    RectWithSize task_rect = task.task_rect;
    vec4 uvRect = vec4(task_rect.p0 + vec2(0.5), (task_rect.p0 + task_rect.size) - vec2(0.5));
    uvRect /= texture_size.xyxy;
    return uvRect;
}

vec3 compute_uv(RenderTaskCommonData task, vec2 texture_size)
{
    RectWithSize task_rect = task.task_rect;
    vec3 uv = vec3(0.0, 0.0, task.texture_layer_index);
    vec2 uv0 = task_rect.p0 / texture_size;
    vec2 uv1 = floor(task_rect.p0 + task_rect.size) / texture_size;
    vec2 _251 = mix(uv0, uv1, aPosition.xy);
    uv = vec3(_251.x, _251.y, uv.z);
    return uv;
}

vec4 fetch_from_gpu_cache_1_direct(ivec2 address)
{
    return texelFetch(sGpuCache, address, 0);
}

vec4[4] fetch_from_gpu_cache_4_direct(ivec2 address)
{
    return vec4[](texelFetch(sGpuCache, address + ivec2(0), 0), texelFetch(sGpuCache, address + ivec2(1, 0), 0), texelFetch(sGpuCache, address + ivec2(2, 0), 0), texelFetch(sGpuCache, address + ivec2(3, 0), 0));
}

void main()
{
    int param = aFilterRenderTaskAddress;
    FilterTask filter_task = fetch_filter_task(param);
    RectWithSize target_rect = filter_task.common_data.task_rect;
    vec2 pos = target_rect.p0 + (target_rect.size * aPosition.xy);
    RenderTaskCommonData input_1_task;
    if (aFilterInputCount > 0)
    {
        vec2 texture_size = vec2(textureSize(sColor0, 0).xy);
        int param_1 = aFilterInput1TaskAddress;
        input_1_task = fetch_render_task_common_data(param_1);
        RenderTaskCommonData param_2 = input_1_task;
        vec2 param_3 = texture_size;
        vInput1UvRect = compute_uv_rect(param_2, param_3);
        RenderTaskCommonData param_4 = input_1_task;
        vec2 param_5 = texture_size;
        vInput1Uv = compute_uv(param_4, param_5);
    }
    if (aFilterInputCount > 1)
    {
        vec2 texture_size_1 = vec2(textureSize(sColor1, 0).xy);
        int param_6 = aFilterInput2TaskAddress;
        RenderTaskCommonData input_2_task = fetch_render_task_common_data(param_6);
        RenderTaskCommonData param_7 = input_2_task;
        vec2 param_8 = texture_size_1;
        vInput2UvRect = compute_uv_rect(param_7, param_8);
        RenderTaskCommonData param_9 = input_2_task;
        vec2 param_10 = texture_size_1;
        vInput2Uv = compute_uv(param_9, param_10);
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
            ivec2 param_11 = aFilterExtraDataAddress;
            vFilterData0 = fetch_from_gpu_cache_1_direct(param_11);
            break;
        }
        case 4:
        {
            vFloat0 = filter_task.user_data.x;
            break;
        }
        case 5:
        {
            ivec2 param_12 = aFilterExtraDataAddress;
            vec4 mat_data[4] = fetch_from_gpu_cache_4_direct(param_12);
            vColorMat = mat4(vec4(mat_data[0]), vec4(mat_data[1]), vec4(mat_data[2]), vec4(mat_data[3]));
            ivec2 param_13 = aFilterExtraDataAddress + ivec2(4, 0);
            vFilterData0 = fetch_from_gpu_cache_1_direct(param_13);
            break;
        }
        case 6:
        {
            ivec2 param_14 = aFilterExtraDataAddress;
            vFilterData0 = fetch_from_gpu_cache_1_direct(param_14);
            break;
        }
        case 7:
        {
            vec2 texture_size_2 = vec2(textureSize(sColor0, 0).xy);
            vFilterData0 = vec4((-filter_task.user_data.xy) / texture_size_2, vec2(0.0));
            RectWithSize task_rect = input_1_task.task_rect;
            vec4 clipRect = vec4(task_rect.p0, task_rect.p0 + task_rect.size);
            clipRect /= texture_size_2.xyxy;
            vFilterData1 = clipRect;
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
                ivec2 param_15 = aFilterExtraDataAddress;
                vFilterData0 = fetch_from_gpu_cache_1_direct(param_15);
            }
            break;
        }
        default:
        {
            break;
        }
    }
    gl_Position = uTransform * vec4(pos, 0.0, 1.0);
}

