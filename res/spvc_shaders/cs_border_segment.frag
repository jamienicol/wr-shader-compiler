#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;

flat in highp vec4 vPartialWidths;
flat in highp vec4 vEdgeReference;
in highp vec2 vPos;
flat in mediump ivec4 vConfig;
flat in highp vec4 vColorLine;
flat in highp vec4 vClipCenter_Sign;
flat in highp vec4 vClipParams1;
flat in highp vec4 vClipParams2;
flat in highp vec4 vClipRadii;
flat in highp vec4 vColor00;
flat in highp vec4 vColor01;
flat in highp vec4 vColor10;
flat in highp vec4 vColor11;
layout(location = 0) out highp vec4 oFragColor;

highp float compute_aa_range(highp vec2 position)
{
    return 0.3535499870777130126953125 * length(fwidth(position));
}

highp float distance_to_line(highp vec2 p0, highp vec2 perp_dir, highp vec2 p)
{
    highp vec2 dir_to_p0 = p0 - p;
    return dot(normalize(perp_dir), dir_to_p0);
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

highp vec4 evaluate_color_for_style_in_corner(highp vec2 clip_relative_pos, mediump int style, inout highp vec4 color0, highp vec4 color1, highp vec4 clip_radii, highp float mix_factor, mediump int segment, highp float aa_range)
{
    switch (style)
    {
        case 2:
        {
            highp vec2 param = clip_relative_pos;
            highp vec2 param_1 = clip_radii.xy - vPartialWidths.xy;
            highp float param_2 = aa_range;
            highp float d_radii_a = distance_to_ellipse(param, param_1, param_2);
            highp vec2 param_3 = clip_relative_pos;
            highp vec2 param_4 = clip_radii.xy - (vPartialWidths.xy * 2.0);
            highp float param_5 = aa_range;
            highp float d_radii_b = distance_to_ellipse(param_3, param_4, param_5);
            highp float d = min(-d_radii_a, d_radii_b);
            highp float param_6 = aa_range;
            highp float param_7 = d;
            color0 *= distance_aa(param_6, param_7);
            break;
        }
        case 6:
        case 7:
        {
            highp vec2 param_8 = clip_relative_pos;
            highp vec2 param_9 = clip_radii.xy - vPartialWidths.zw;
            highp float param_10 = aa_range;
            highp float d_1 = distance_to_ellipse(param_8, param_9, param_10);
            highp float param_11 = aa_range;
            highp float param_12 = d_1;
            highp float alpha = distance_aa(param_11, param_12);
            highp float swizzled_factor;
            switch (segment)
            {
                case 0:
                {
                    swizzled_factor = 0.0;
                    break;
                }
                case 1:
                {
                    swizzled_factor = mix_factor;
                    break;
                }
                case 2:
                {
                    swizzled_factor = 1.0;
                    break;
                }
                case 3:
                {
                    swizzled_factor = 1.0 - mix_factor;
                    break;
                }
                default:
                {
                    swizzled_factor = 0.0;
                    break;
                }
            }
            highp vec4 c0 = mix(color1, color0, vec4(swizzled_factor));
            highp vec4 c1 = mix(color0, color1, vec4(swizzled_factor));
            color0 = mix(c0, c1, vec4(alpha));
            break;
        }
        default:
        {
            break;
        }
    }
    return color0;
}

highp vec4 evaluate_color_for_style_in_edge(highp vec2 pos_vec, mediump int style, inout highp vec4 color0, highp vec4 color1, highp float aa_range, mediump int edge_axis_id)
{
    bvec2 _259 = bvec2(edge_axis_id != 0);
    highp vec2 edge_axis = vec2(_259.x ? vec2(0.0, 1.0).x : vec2(1.0, 0.0).x, _259.y ? vec2(0.0, 1.0).y : vec2(1.0, 0.0).y);
    highp float pos = dot(pos_vec, edge_axis);
    switch (style)
    {
        case 2:
        {
            highp float d = -1.0;
            highp float partial_width = dot(vPartialWidths.xy, edge_axis);
            if (partial_width >= 1.0)
            {
                highp vec2 ref = vec2(dot(vEdgeReference.xy, edge_axis) + partial_width, dot(vEdgeReference.zw, edge_axis) - partial_width);
                d = min(pos - ref.x, ref.y - pos);
            }
            highp float param = aa_range;
            highp float param_1 = d;
            color0 *= distance_aa(param, param_1);
            break;
        }
        case 6:
        case 7:
        {
            highp float ref_1 = dot(vEdgeReference.xy + vPartialWidths.zw, edge_axis);
            highp float d_1 = pos - ref_1;
            highp float param_2 = aa_range;
            highp float param_3 = d_1;
            highp float alpha = distance_aa(param_2, param_3);
            color0 = mix(color0, color1, vec4(alpha));
            break;
        }
        default:
        {
            break;
        }
    }
    return color0;
}

void main()
{
    highp vec2 param = vPos;
    highp float aa_range = compute_aa_range(param);
    mediump int segment = vConfig.x;
    mediump ivec2 style = ivec2(vConfig.y & 65535, vConfig.y >> 16);
    mediump ivec2 edge_axis = ivec2(vConfig.z & 65535, vConfig.z >> 16);
    mediump int clip_mode = vConfig.w;
    highp float mix_factor = 0.0;
    if (edge_axis.x != edge_axis.y)
    {
        highp vec2 param_1 = vColorLine.xy;
        highp vec2 param_2 = vColorLine.zw;
        highp vec2 param_3 = vPos;
        highp float d_line = distance_to_line(param_1, param_2, param_3);
        highp float param_4 = aa_range;
        highp float param_5 = -d_line;
        mix_factor = distance_aa(param_4, param_5);
    }
    highp vec2 clip_relative_pos = vPos - vClipCenter_Sign.xy;
    bool in_clip_region = all(lessThan(vClipCenter_Sign.zw * clip_relative_pos, vec2(0.0)));
    highp float d = -1.0;
    switch (clip_mode)
    {
        case 3:
        {
            d = distance(vClipParams1.xy, vPos) - vClipParams1.z;
            break;
        }
        case 2:
        {
            bool is_vertical = vClipParams1.x == 0.0;
            highp float _445;
            if (is_vertical)
            {
                _445 = vClipParams1.y;
            }
            else
            {
                _445 = vClipParams1.x;
            }
            highp float half_dash = _445;
            highp float _456;
            if (is_vertical)
            {
                _456 = vPos.y;
            }
            else
            {
                _456 = vPos.x;
            }
            highp float pos = _456;
            bool _468 = pos < half_dash;
            bool _477;
            if (!_468)
            {
                _477 = pos > (3.0 * half_dash);
            }
            else
            {
                _477 = _468;
            }
            bool in_dash = _477;
            if (!in_dash)
            {
                d = 1.0;
            }
            break;
        }
        case 1:
        {
            highp vec2 param_6 = vClipParams1.xy;
            highp vec2 param_7 = vClipParams1.zw;
            highp vec2 param_8 = vPos;
            highp float d0 = distance_to_line(param_6, param_7, param_8);
            highp vec2 param_9 = vClipParams2.xy;
            highp vec2 param_10 = vClipParams2.zw;
            highp vec2 param_11 = vPos;
            highp float d1 = distance_to_line(param_9, param_10, param_11);
            d = max(d0, -d1);
            break;
        }
        default:
        {
            break;
        }
    }
    highp vec4 color0;
    highp vec4 color1;
    if (in_clip_region)
    {
        highp vec2 param_12 = clip_relative_pos;
        highp vec2 param_13 = vClipRadii.xy;
        highp float param_14 = aa_range;
        highp float d_radii_a = distance_to_ellipse(param_12, param_13, param_14);
        highp vec2 param_15 = clip_relative_pos;
        highp vec2 param_16 = vClipRadii.zw;
        highp float param_17 = aa_range;
        highp float d_radii_b = distance_to_ellipse(param_15, param_16, param_17);
        highp float d_radii = max(d_radii_a, -d_radii_b);
        d = max(d, d_radii);
        highp vec2 param_18 = clip_relative_pos;
        int param_19 = style.x;
        highp vec4 param_20 = vColor00;
        highp vec4 param_21 = vColor01;
        highp vec4 param_22 = vClipRadii;
        highp float param_23 = mix_factor;
        int param_24 = segment;
        highp float param_25 = aa_range;
        highp vec4 _561 = evaluate_color_for_style_in_corner(param_18, param_19, param_20, param_21, param_22, param_23, param_24, param_25);
        color0 = _561;
        highp vec2 param_26 = clip_relative_pos;
        int param_27 = style.y;
        highp vec4 param_28 = vColor10;
        highp vec4 param_29 = vColor11;
        highp vec4 param_30 = vClipRadii;
        highp float param_31 = mix_factor;
        int param_32 = segment;
        highp float param_33 = aa_range;
        highp vec4 _582 = evaluate_color_for_style_in_corner(param_26, param_27, param_28, param_29, param_30, param_31, param_32, param_33);
        color1 = _582;
    }
    else
    {
        highp vec2 param_34 = vPos;
        int param_35 = style.x;
        highp vec4 param_36 = vColor00;
        highp vec4 param_37 = vColor01;
        highp float param_38 = aa_range;
        int param_39 = edge_axis.x;
        highp vec4 _598 = evaluate_color_for_style_in_edge(param_34, param_35, param_36, param_37, param_38, param_39);
        color0 = _598;
        highp vec2 param_40 = vPos;
        int param_41 = style.y;
        highp vec4 param_42 = vColor10;
        highp vec4 param_43 = vColor11;
        highp float param_44 = aa_range;
        int param_45 = edge_axis.y;
        highp vec4 _613 = evaluate_color_for_style_in_edge(param_40, param_41, param_42, param_43, param_44, param_45);
        color1 = _613;
    }
    highp float param_46 = aa_range;
    highp float param_47 = d;
    highp float alpha = distance_aa(param_46, param_47);
    highp vec4 color = mix(color0, color1, vec4(mix_factor));
    oFragColor = color * alpha;
}

