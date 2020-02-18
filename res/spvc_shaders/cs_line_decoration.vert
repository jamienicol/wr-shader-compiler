#version 300 es

uniform mat4 uTransform;
uniform int uMode;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;

layout(location = 2) in vec2 aLocalSize;
layout(location = 4) in float aAxisSelect;
flat out int vStyle;
layout(location = 3) in int aStyle;
flat out vec4 vParams;
layout(location = 5) in float aWavyLineThickness;
out vec2 vLocalPos;
layout(location = 0) in vec3 aPosition;
layout(location = 1) in vec4 aTaskRect;

void main()
{
    vec2 size = mix(aLocalSize, aLocalSize.yx, vec2(aAxisSelect));
    vStyle = aStyle;
    switch (vStyle)
    {
        case 0:
        {
            break;
        }
        case 2:
        {
            vParams = vec4(size.x, 0.5 * size.x, 0.0, 0.0);
            break;
        }
        case 1:
        {
            float diameter = size.y;
            float period = diameter * 2.0;
            float center_line = 0.5 * size.y;
            vParams = vec4(period, diameter / 2.0, center_line, 0.0);
            break;
        }
        case 3:
        {
            float line_thickness = max(aWavyLineThickness, 1.0);
            float slope_length = size.y - line_thickness;
            float flat_length = max((line_thickness - 1.0) * 2.0, 1.0);
            vParams = vec4(line_thickness / 2.0, slope_length, flat_length, size.y);
            break;
        }
        default:
        {
            vParams = vec4(0.0);
            break;
        }
    }
    vLocalPos = mix(aPosition.xy, aPosition.yx, vec2(aAxisSelect)) * size;
    gl_Position = uTransform * vec4(aTaskRect.xy + (aTaskRect.zw * aPosition.xy), 0.0, 1.0);
}

