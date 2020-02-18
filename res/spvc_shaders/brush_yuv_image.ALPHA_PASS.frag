#version 300 es
precision mediump float;
precision highp int;

struct Fragment
{
    highp vec4 color;
};

uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sPrevPassColor;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in mediump int vFormat;
in highp vec3 vUv_Y;
flat in highp vec4 vUvBounds_Y;
in highp vec3 vUv_U;
flat in highp vec4 vUvBounds_U;
in highp vec3 vUv_V;
flat in highp vec4 vUvBounds_V;
flat in highp mat3 vYuvColorMatrix;
flat in highp float vCoefficient;
in highp vec2 vLocalPos;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

highp float signed_distance_rect(highp vec2 pos, highp vec2 p0, highp vec2 p1)
{
    highp vec2 d = max(p0 - pos, pos - p1);
    return length(max(vec2(0.0), d)) + min(0.0, max(d.x, d.y));
}

highp float compute_aa_range(highp vec2 position)
{
    return 0.3535499870777130126953125 * length(fwidth(position));
}

highp float distance_aa(highp float aa_range, highp float signed_distance)
{
    highp float dist = (0.5 * signed_distance) / aa_range;
    if (dist <= (-0.4999000132083892822265625))
    {
        return 1.0;
    }
    if (dist >= 0.4999000132083892822265625)
    {
        return 0.0;
    }
    return 0.5 + (dist * (((0.8431026935577392578125 * dist) * dist) - 1.14453601837158203125));
}

highp float init_transform_fs(highp vec2 local_pos)
{
    highp vec2 param = local_pos;
    highp vec2 param_1 = vTransformBounds.xy;
    highp vec2 param_2 = vTransformBounds.zw;
    highp float d = signed_distance_rect(param, param_1, param_2);
    highp vec2 param_3 = local_pos;
    highp float aa_range = compute_aa_range(param_3);
    highp float param_4 = aa_range;
    highp float param_5 = d;
    return distance_aa(param_4, param_5);
}

Fragment yuv_brush_fs()
{
    highp vec3 yuv_value;
    if (vFormat == 1)
    {
        highp vec2 uv_y = clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
        highp vec2 uv_u = clamp(vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw);
        highp vec2 uv_v = clamp(vUv_V.xy, vUvBounds_V.xy, vUvBounds_V.zw);
        yuv_value.x = texture(sColor0, vec3(uv_y, vUv_Y.z)).x;
        yuv_value.y = texture(sColor1, vec3(uv_u, vUv_U.z)).x;
        yuv_value.z = texture(sColor2, vec3(uv_v, vUv_V.z)).x;
    }
    else
    {
        if (vFormat == 0)
        {
            highp vec2 uv_y_1 = clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
            highp vec2 uv_uv = clamp(vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw);
            yuv_value.x = texture(sColor0, vec3(uv_y_1, vUv_Y.z)).x;
            highp vec2 _330 = texture(sColor1, vec3(uv_uv, vUv_U.z)).xy;
            yuv_value = vec3(yuv_value.x, _330.x, _330.y);
        }
        else
        {
            if (vFormat == 2)
            {
                highp vec2 uv_y_2 = clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw);
                yuv_value = texture(sColor0, vec3(uv_y_2, vUv_Y.z)).yzx;
            }
            else
            {
                yuv_value = vec3(0.0);
            }
        }
    }
    highp vec3 rgb = vYuvColorMatrix * ((yuv_value * vCoefficient) - vec3(0.06274999678134918212890625, 0.501959979534149169921875, 0.501959979534149169921875));
    highp vec4 color = vec4(rgb, 1.0);
    highp vec2 param = vLocalPos;
    color *= init_transform_fs(param);
    return Fragment(color);
}

highp float do_clip()
{
    if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
    {
        return 1.0;
    }
    highp vec2 mask_uv = vClipMaskUv.xy * gl_FragCoord.w;
    bvec2 left = lessThanEqual(vClipMaskUvBounds.xy, mask_uv);
    bvec2 right = greaterThan(vClipMaskUvBounds.zw, mask_uv);
    if (!all(bvec4(left, right)))
    {
        return 0.0;
    }
    mediump ivec3 tc = ivec3(ivec2(mask_uv), int(vClipMaskUv.z + 0.5));
    return texelFetch(sPrevPassAlpha, tc, 0).x;
}

void write_output(highp vec4 color)
{
    oFragColor = color;
}

void main()
{
    Fragment frag = yuv_brush_fs();
    highp float clip_alpha = do_clip();
    frag.color *= clip_alpha;
    highp vec4 param = frag.color;
    write_output(param);
}

