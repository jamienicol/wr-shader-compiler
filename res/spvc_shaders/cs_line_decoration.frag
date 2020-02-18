#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;

in highp vec2 vLocalPos;
flat in mediump int vStyle;
flat in highp vec4 vParams;
layout(location = 0) out highp vec4 oFragColor;

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

highp float distance_to_line(highp vec2 p0, highp vec2 perp_dir, highp vec2 p)
{
    highp vec2 dir_to_p0 = p0 - p;
    return dot(normalize(perp_dir), dir_to_p0);
}

void main()
{
    highp vec2 pos = vLocalPos;
    highp vec2 param = pos;
    highp float aa_range = compute_aa_range(param);
    highp float alpha = 1.0;
    switch (vStyle)
    {
        case 0:
        {
            break;
        }
        case 2:
        {
            alpha = step(floor(pos.x + 0.5), vParams.y);
            break;
        }
        case 1:
        {
            highp vec2 dot_relative_pos = pos - vParams.yz;
            highp float dot_distance = length(dot_relative_pos) - vParams.y;
            highp float param_1 = aa_range;
            highp float param_2 = dot_distance;
            alpha = distance_aa(param_1, param_2);
            break;
        }
        case 3:
        {
            highp float half_line_thickness = vParams.x;
            highp float slope_length = vParams.y;
            highp float flat_length = vParams.z;
            highp float vertical_bounds = vParams.w;
            highp float half_period = slope_length + flat_length;
            highp float mid_height = vertical_bounds / 2.0;
            highp float peak_offset = mid_height - half_line_thickness;
            highp float flip = (-2.0) * (step(mod(pos.x, 2.0 * half_period), half_period) - 0.5);
            peak_offset *= flip;
            highp float peak_height = mid_height + peak_offset;
            pos.x = mod(pos.x, half_period);
            highp vec2 param_3 = vec2(0.0, peak_height);
            highp vec2 param_4 = vec2(1.0, -flip);
            highp vec2 param_5 = pos;
            highp float dist1 = distance_to_line(param_3, param_4, param_5);
            highp vec2 param_6 = vec2(0.0, peak_height);
            highp vec2 param_7 = vec2(0.0, -flip);
            highp vec2 param_8 = pos;
            highp float dist2 = distance_to_line(param_6, param_7, param_8);
            highp vec2 param_9 = vec2(flat_length, peak_height);
            highp vec2 param_10 = vec2(-1.0, -flip);
            highp vec2 param_11 = pos;
            highp float dist3 = distance_to_line(param_9, param_10, param_11);
            highp float dist = abs(max(max(dist1, dist2), dist3));
            highp float param_12 = aa_range;
            highp float param_13 = dist - half_line_thickness;
            alpha = distance_aa(param_12, param_13);
            if (half_line_thickness <= 1.0)
            {
                alpha = 1.0 - step(alpha, 0.5);
            }
            break;
        }
        default:
        {
            break;
        }
    }
    oFragColor = vec4(alpha);
}

