#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;

in highp vec2 vPos;
flat in mediump int vMixColors;
flat in highp vec4 vColorLine;
flat in highp vec4 vClipCenter_Sign;
flat in highp vec4 vClipRadii;
flat in highp vec4 vHorizontalClipCenter_Sign;
flat in highp vec2 vHorizontalClipRadii;
flat in highp vec4 vVerticalClipCenter_Sign;
flat in highp vec2 vVerticalClipRadii;
flat in highp vec4 vColor0;
flat in highp vec4 vColor1;
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

void main()
{
    highp vec2 param = vPos;
    highp float aa_range = compute_aa_range(param);
    bool do_aa = vMixColors != 2;
    highp float mix_factor = 0.0;
    if (vMixColors != 0)
    {
        highp vec2 param_1 = vColorLine.xy;
        highp vec2 param_2 = vColorLine.zw;
        highp vec2 param_3 = vPos;
        highp float d_line = distance_to_line(param_1, param_2, param_3);
        if (do_aa)
        {
            highp float param_4 = aa_range;
            highp float param_5 = -d_line;
            mix_factor = distance_aa(param_4, param_5);
        }
        else
        {
            mix_factor = float((d_line + 9.9999997473787516355514526367188e-05) >= 0.0);
        }
    }
    highp vec2 clip_relative_pos = vPos - vClipCenter_Sign.xy;
    bool in_clip_region = all(lessThan(vClipCenter_Sign.zw * clip_relative_pos, vec2(0.0)));
    highp float d = -1.0;
    if (in_clip_region)
    {
        highp vec2 param_6 = clip_relative_pos;
        highp vec2 param_7 = vClipRadii.xy;
        highp float param_8 = aa_range;
        highp float d_radii_a = distance_to_ellipse(param_6, param_7, param_8);
        highp vec2 param_9 = clip_relative_pos;
        highp vec2 param_10 = vClipRadii.zw;
        highp float param_11 = aa_range;
        highp float d_radii_b = distance_to_ellipse(param_9, param_10, param_11);
        d = max(d_radii_a, -d_radii_b);
    }
    clip_relative_pos = vPos - vHorizontalClipCenter_Sign.xy;
    in_clip_region = all(lessThan(vHorizontalClipCenter_Sign.zw * clip_relative_pos, vec2(0.0)));
    if (in_clip_region)
    {
        highp vec2 param_12 = clip_relative_pos;
        highp vec2 param_13 = vHorizontalClipRadii;
        highp float param_14 = aa_range;
        highp float d_radii = distance_to_ellipse(param_12, param_13, param_14);
        d = max(d_radii, d);
    }
    clip_relative_pos = vPos - vVerticalClipCenter_Sign.xy;
    in_clip_region = all(lessThan(vVerticalClipCenter_Sign.zw * clip_relative_pos, vec2(0.0)));
    if (in_clip_region)
    {
        highp vec2 param_15 = clip_relative_pos;
        highp vec2 param_16 = vVerticalClipRadii;
        highp float param_17 = aa_range;
        highp float d_radii_1 = distance_to_ellipse(param_15, param_16, param_17);
        d = max(d_radii_1, d);
    }
    highp float _269;
    if (do_aa)
    {
        highp float param_18 = aa_range;
        highp float param_19 = d;
        _269 = distance_aa(param_18, param_19);
    }
    else
    {
        _269 = 1.0;
    }
    highp float alpha = _269;
    highp vec4 color = mix(vColor0, vColor1, vec4(mix_factor));
    oFragColor = color * alpha;
}

