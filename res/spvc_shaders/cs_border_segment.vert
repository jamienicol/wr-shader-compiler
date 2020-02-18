#version 300 es

uniform mat4 uTransform;
uniform int uMode;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;

layout(location = 5) in int aFlags;
layout(location = 2) in vec4 aRect;
layout(location = 6) in vec2 aWidths;
flat out ivec4 vConfig;
flat out vec4 vPartialWidths;
out vec2 vPos;
layout(location = 0) in vec3 aPosition;
layout(location = 3) in vec4 aColor0;
flat out vec4 vColor00;
flat out vec4 vColor01;
layout(location = 4) in vec4 aColor1;
flat out vec4 vColor10;
flat out vec4 vColor11;
flat out vec4 vClipCenter_Sign;
layout(location = 7) in vec2 aRadii;
flat out vec4 vClipRadii;
flat out vec4 vColorLine;
flat out vec4 vEdgeReference;
flat out vec4 vClipParams1;
layout(location = 8) in vec4 aClipParams1;
flat out vec4 vClipParams2;
layout(location = 9) in vec4 aClipParams2;
layout(location = 1) in vec2 aTaskOrigin;

vec2 get_outer_corner_scale(int segment)
{
    vec2 p;
    switch (segment)
    {
        case 0:
        {
            p = vec2(0.0);
            break;
        }
        case 1:
        {
            p = vec2(1.0, 0.0);
            break;
        }
        case 2:
        {
            p = vec2(1.0);
            break;
        }
        case 3:
        {
            p = vec2(0.0, 1.0);
            break;
        }
        default:
        {
            p = vec2(0.0);
            break;
        }
    }
    return p;
}

vec4 mod_color(vec4 color, bool is_black, bool lighter)
{
    if (is_black)
    {
        if (lighter)
        {
            return vec4(vec3(0.699999988079071044921875), color.w);
        }
        return vec4(vec3(0.300000011920928955078125), color.w);
    }
    if (lighter)
    {
        return vec4(color.xyz * 1.0, color.w);
    }
    return vec4(color.xyz * 0.666666686534881591796875, color.w);
}

vec4[2] get_colors_for_side(vec4 color, int style)
{
    bool is_black = all(equal(color.xyz, vec3(0.0)));
    vec4 result[2];
    switch (style)
    {
        case 6:
        {
            vec4 param = color;
            bool param_1 = is_black;
            bool param_2 = true;
            result[0] = mod_color(param, param_1, param_2);
            vec4 param_3 = color;
            bool param_4 = is_black;
            bool param_5 = false;
            result[1] = mod_color(param_3, param_4, param_5);
            break;
        }
        case 7:
        {
            vec4 param_6 = color;
            bool param_7 = is_black;
            bool param_8 = false;
            result[0] = mod_color(param_6, param_7, param_8);
            vec4 param_9 = color;
            bool param_10 = is_black;
            bool param_11 = true;
            result[1] = mod_color(param_9, param_10, param_11);
            break;
        }
        default:
        {
            result[0] = color;
            result[1] = color;
            break;
        }
    }
    return result;
}

void main()
{
    int segment = aFlags & 255;
    int style0 = (aFlags >> 8) & 255;
    int style1 = (aFlags >> 16) & 255;
    int clip_mode = (aFlags >> 24) & 15;
    int param = segment;
    vec2 outer_scale = get_outer_corner_scale(param);
    vec2 outer = outer_scale * aRect.zw;
    vec2 clip_sign = vec2(1.0) - (outer_scale * 2.0);
    ivec2 edge_axis = ivec2(0);
    vec2 edge_reference = vec2(0.0);
    switch (segment)
    {
        case 0:
        {
            edge_axis = ivec2(0, 1);
            edge_reference = outer;
            break;
        }
        case 1:
        {
            edge_axis = ivec2(1, 0);
            edge_reference = vec2(outer.x - aWidths.x, outer.y);
            break;
        }
        case 2:
        {
            edge_axis = ivec2(0, 1);
            edge_reference = outer - aWidths;
            break;
        }
        case 3:
        {
            edge_axis = ivec2(1, 0);
            edge_reference = vec2(outer.x, outer.y - aWidths.y);
            break;
        }
        case 5:
        case 7:
        {
            edge_axis = ivec2(1);
            break;
        }
        default:
        {
            break;
        }
    }
    vConfig = ivec4(segment, style0 | (style1 << 16), edge_axis.x | (edge_axis.y << 16), clip_mode);
    vPartialWidths = vec4(aWidths / vec2(3.0), aWidths / vec2(2.0));
    vPos = aRect.zw * aPosition.xy;
    vec4 param_1 = aColor0;
    int param_2 = style0;
    vec4 color0[2] = get_colors_for_side(param_1, param_2);
    vColor00 = color0[0];
    vColor01 = color0[1];
    vec4 param_3 = aColor1;
    int param_4 = style1;
    vec4 color1[2] = get_colors_for_side(param_3, param_4);
    vColor10 = color1[0];
    vColor11 = color1[1];
    vClipCenter_Sign = vec4(outer + (clip_sign * aRadii), clip_sign);
    vClipRadii = vec4(aRadii, max(aRadii - aWidths, vec2(0.0)));
    vColorLine = vec4(outer, aWidths.y * (-clip_sign.y), aWidths.x * clip_sign.x);
    vEdgeReference = vec4(edge_reference, edge_reference + aWidths);
    vClipParams1 = aClipParams1;
    vClipParams2 = aClipParams2;
    if (clip_mode == 3)
    {
        float radius = aClipParams1.z;
        if (radius > 0.5)
        {
            radius += 2.0;
        }
        vPos = vClipParams1.xy + (((aPosition.xy * 2.0) - vec2(1.0)) * radius);
        vPos = clamp(vPos, vec2(0.0), aRect.zw);
    }
    else
    {
        if (clip_mode == 1)
        {
            vec2 center = (aClipParams1.xy + aClipParams2.xy) * 0.5;
            float dash_length = length(aClipParams1.xy - aClipParams2.xy);
            float width = max(aWidths.x, aWidths.y);
            vec2 r = vec2(max(dash_length, width)) + vec2(2.0);
            vPos = clamp(vPos, center - r, center + r);
        }
    }
    gl_Position = uTransform * vec4((aTaskOrigin + aRect.xy) + vPos, 0.0, 1.0);
}

