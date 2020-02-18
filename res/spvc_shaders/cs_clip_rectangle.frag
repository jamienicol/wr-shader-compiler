#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sGpuCache;

flat in highp vec4 vTransformBounds;
in highp vec4 vLocalPos;
flat in highp vec4 vClipCenter_Radius_TL;
flat in highp vec4 vClipCenter_Radius_TR;
flat in highp vec4 vClipCenter_Radius_BR;
flat in highp vec4 vClipCenter_Radius_BL;
flat in highp float vClipMode;
layout(location = 0) out highp vec4 oFragColor;

highp float compute_aa_range(highp vec2 position)
{
    return 0.3535499870777130126953125 * length(fwidth(position));
}

highp float signed_distance_rect(highp vec2 pos, highp vec2 p0, highp vec2 p1)
{
    highp vec2 d = max(p0 - pos, pos - p1);
    return length(max(vec2(0.0), d)) + min(0.0, max(d.x, d.y));
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

highp float distance_to_ellipse(highp vec2 p, highp vec2 radii, highp float aa_range)
{
    highp float dist;
    if (any(lessThanEqual(radii, vec2(0.0))))
    {
        dist = length(p);
    }
    else
    {
        highp vec2 invRadiiSq = vec2(1.0) / (radii * radii);
        highp float g = dot((p * p) * invRadiiSq, vec2(1.0)) - 1.0;
        highp vec2 dG = (p * 2.0) * invRadiiSq;
        dist = g * inversesqrt(dot(dG, dG));
    }
    return clamp(dist, -aa_range, aa_range);
}

highp float clip_against_ellipse_if_needed(highp vec2 pos, highp float current_distance, highp vec4 ellipse_center_radius, highp vec2 sign_modifier, highp float aa_range)
{
    if (!all(lessThan(sign_modifier * pos, sign_modifier * ellipse_center_radius.xy)))
    {
        return current_distance;
    }
    highp vec2 param = pos - ellipse_center_radius.xy;
    highp vec2 param_1 = ellipse_center_radius.zw;
    highp float param_2 = aa_range;
    highp float _distance = distance_to_ellipse(param, param_1, param_2);
    return max(_distance, current_distance);
}

highp float rounded_rect(highp vec2 pos, highp vec4 clip_center_radius_tl, highp vec4 clip_center_radius_tr, highp vec4 clip_center_radius_br, highp vec4 clip_center_radius_bl, highp float aa_range)
{
    highp float current_distance = -aa_range;
    highp vec2 param = pos;
    highp float param_1 = current_distance;
    highp vec4 param_2 = clip_center_radius_tl;
    highp vec2 param_3 = vec2(1.0);
    highp float param_4 = aa_range;
    current_distance = clip_against_ellipse_if_needed(param, param_1, param_2, param_3, param_4);
    highp vec2 param_5 = pos;
    highp float param_6 = current_distance;
    highp vec4 param_7 = clip_center_radius_tr;
    highp vec2 param_8 = vec2(-1.0, 1.0);
    highp float param_9 = aa_range;
    current_distance = clip_against_ellipse_if_needed(param_5, param_6, param_7, param_8, param_9);
    highp vec2 param_10 = pos;
    highp float param_11 = current_distance;
    highp vec4 param_12 = clip_center_radius_br;
    highp vec2 param_13 = vec2(-1.0);
    highp float param_14 = aa_range;
    current_distance = clip_against_ellipse_if_needed(param_10, param_11, param_12, param_13, param_14);
    highp vec2 param_15 = pos;
    highp float param_16 = current_distance;
    highp vec4 param_17 = clip_center_radius_bl;
    highp vec2 param_18 = vec2(1.0, -1.0);
    highp float param_19 = aa_range;
    current_distance = clip_against_ellipse_if_needed(param_15, param_16, param_17, param_18, param_19);
    highp float param_20 = aa_range;
    highp float param_21 = current_distance;
    return distance_aa(param_20, param_21);
}

void main()
{
    highp vec2 local_pos = vLocalPos.xy / vec2(vLocalPos.w);
    highp vec2 param = local_pos;
    highp float aa_range = compute_aa_range(param);
    highp vec2 param_1 = local_pos;
    highp float alpha = init_transform_fs(param_1);
    highp vec2 param_2 = local_pos;
    highp vec4 param_3 = vClipCenter_Radius_TL;
    highp vec4 param_4 = vClipCenter_Radius_TR;
    highp vec4 param_5 = vClipCenter_Radius_BR;
    highp vec4 param_6 = vClipCenter_Radius_BL;
    highp float param_7 = aa_range;
    highp float clip_alpha = rounded_rect(param_2, param_3, param_4, param_5, param_6, param_7);
    highp float combined_alpha = alpha * clip_alpha;
    highp float final_alpha = mix(combined_alpha, 1.0 - combined_alpha, vClipMode);
    highp float final_final_alpha = (vLocalPos.w > 0.0) ? final_alpha : 0.0;
    oFragColor = vec4(final_final_alpha, 0.0, 0.0, 1.0);
}

