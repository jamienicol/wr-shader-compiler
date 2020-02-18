#version 300 es

uniform mat4 uTransform;
uniform int uMode;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;

layout(location = 5) in int aFlags;
layout(location = 2) in vec4 aRect;
flat out int vMixColors;
out vec2 vPos;
layout(location = 0) in vec3 aPosition;
flat out vec4 vColor0;
layout(location = 3) in vec4 aColor0;
flat out vec4 vColor1;
layout(location = 4) in vec4 aColor1;
flat out vec4 vClipCenter_Sign;
layout(location = 7) in vec2 aRadii;
flat out vec4 vClipRadii;
layout(location = 6) in vec2 aWidths;
flat out vec4 vColorLine;
flat out vec4 vHorizontalClipCenter_Sign;
layout(location = 8) in vec4 aClipParams1;
flat out vec2 vHorizontalClipRadii;
flat out vec4 vVerticalClipCenter_Sign;
layout(location = 9) in vec4 aClipParams2;
flat out vec2 vVerticalClipRadii;
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

void main()
{
    int segment = aFlags & 255;
    bool do_aa = ((aFlags >> 24) & 240) != 0;
    int param = segment;
    vec2 outer_scale = get_outer_corner_scale(param);
    vec2 outer = outer_scale * aRect.zw;
    vec2 clip_sign = vec2(1.0) - (outer_scale * 2.0);
    int mix_colors;
    switch (segment)
    {
        case 0:
        case 1:
        case 2:
        case 3:
        {
            mix_colors = do_aa ? 1 : 2;
            break;
        }
        default:
        {
            mix_colors = 0;
            break;
        }
    }
    vMixColors = mix_colors;
    vPos = aRect.zw * aPosition.xy;
    vColor0 = aColor0;
    vColor1 = aColor1;
    vClipCenter_Sign = vec4(outer + (clip_sign * aRadii), clip_sign);
    vClipRadii = vec4(aRadii, max(aRadii - aWidths, vec2(0.0)));
    vColorLine = vec4(outer, aWidths.y * (-clip_sign.y), aWidths.x * clip_sign.x);
    vec2 horizontal_clip_sign = vec2(-clip_sign.x, clip_sign.y);
    vHorizontalClipCenter_Sign = vec4(aClipParams1.xy + (horizontal_clip_sign * aClipParams1.zw), horizontal_clip_sign);
    vHorizontalClipRadii = aClipParams1.zw;
    vec2 vertical_clip_sign = vec2(clip_sign.x, -clip_sign.y);
    vVerticalClipCenter_Sign = vec4(aClipParams2.xy + (vertical_clip_sign * aClipParams2.zw), vertical_clip_sign);
    vVerticalClipRadii = aClipParams2.zw;
    gl_Position = uTransform * vec4((aTaskOrigin + aRect.xy) + vPos, 0.0, 1.0);
}

