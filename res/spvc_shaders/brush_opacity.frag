#version 300 es
precision mediump float;
precision highp int;

struct Fragment
{
    highp vec4 color;
};

uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 flat_varying_vec4_2;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

highp float point_inside_rect(highp vec2 p, highp vec2 p0, highp vec2 p1)
{
    highp vec2 s = step(p0, p) - step(p1, p);
    return s.x * s.y;
}

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

Fragment opacity_brush_fs()
{
    highp float perspective_divisor = mix(gl_FragCoord.w, 1.0, flat_varying_vec4_2.y);
    highp vec2 uv = varying_vec4_0.zw * perspective_divisor;
    highp vec4 Cs = texture(sColor0, vec3(uv, flat_varying_vec4_2.x));
    highp float alpha = Cs.w;
    highp vec3 _194;
    if (alpha != 0.0)
    {
        _194 = Cs.xyz / vec3(alpha);
    }
    else
    {
        _194 = Cs.xyz;
    }
    highp vec3 color = _194;
    alpha *= flat_varying_vec4_2.z;
    highp vec2 param = uv;
    highp vec2 param_1 = flat_varying_vec4_1.xy;
    highp vec2 param_2 = flat_varying_vec4_1.zw;
    highp vec2 param_3 = varying_vec4_0.xy;
    alpha *= min(point_inside_rect(param, param_1, param_2), init_transform_fs(param_3));
    return Fragment(vec4(color, 1.0) * alpha);
}

void write_output(highp vec4 color)
{
    oFragColor = color;
}

void main()
{
    Fragment frag = opacity_brush_fs();
    highp vec4 param = frag.color;
    write_output(param);
}

