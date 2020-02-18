#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sGpuCache;

in highp vec4 vLocalPos;
flat in highp vec3 vClipParams;
flat in highp float vClipMode;
layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;

highp float compute_aa_range(highp vec2 position)
{
    return 0.3535499870777130126953125 * length(fwidth(position));
}

highp float sd_box(highp vec2 pos, highp vec2 box_size)
{
    highp vec2 d = abs(pos) - box_size;
    return length(max(d, vec2(0.0))) + min(max(d.x, d.y), 0.0);
}

highp float sd_rounded_box(highp vec2 pos, highp vec2 box_size, highp float radius)
{
    highp vec2 param = pos;
    highp vec2 param_1 = box_size;
    return sd_box(param, param_1) - radius;
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

void main()
{
    highp vec2 local_pos = vLocalPos.xy / vec2(vLocalPos.w);
    highp vec2 param = local_pos;
    highp float aa_range = compute_aa_range(param);
    highp vec2 param_1 = local_pos;
    highp vec2 param_2 = vClipParams.xy;
    highp float param_3 = vClipParams.z;
    highp float d = sd_rounded_box(param_1, param_2, param_3);
    highp float param_4 = aa_range;
    highp float param_5 = d;
    highp float f = distance_aa(param_4, param_5);
    highp float final_alpha = mix(f, 1.0 - f, vClipMode);
    highp float final_final_alpha = (vLocalPos.w > 0.0) ? final_alpha : 0.0;
    oFragColor = vec4(final_final_alpha, 0.0, 0.0, 1.0);
}

