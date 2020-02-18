#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sGpuCache;

flat in highp vec4 vTransformBounds;
in highp vec4 vLocalPos;
in highp vec2 vClipMaskImageUv;
flat in highp vec4 vClipMaskUvRect;
flat in highp vec4 vClipMaskUvInnerRect;
flat in highp float vLayer;
layout(location = 0) out highp vec4 oFragColor;

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

void main()
{
    highp vec2 local_pos = vLocalPos.xy / vec2(vLocalPos.w);
    highp float _130;
    if (vLocalPos.w > 0.0)
    {
        highp vec2 param = local_pos;
        _130 = init_transform_fs(param);
    }
    else
    {
        _130 = 0.0;
    }
    highp float alpha = _130;
    highp vec2 clamped_mask_uv = clamp(vClipMaskImageUv, vec2(0.0), vLocalPos.ww);
    if (any(notEqual(clamped_mask_uv, vClipMaskImageUv)))
    {
        discard;
    }
    highp vec2 source_uv = clamp(((clamped_mask_uv / vec2(vLocalPos.w)) * vClipMaskUvRect.zw) + vClipMaskUvRect.xy, vClipMaskUvInnerRect.xy, vClipMaskUvInnerRect.zw);
    highp float clip_alpha = texture(sColor0, vec3(source_uv, vLayer)).x;
    oFragColor = vec4(alpha * clip_alpha, 1.0, 1.0, 1.0);
}

