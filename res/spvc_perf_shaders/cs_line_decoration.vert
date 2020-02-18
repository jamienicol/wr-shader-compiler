#version 300 es

uniform mat4 uTransform;

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
    vec2 _19 = vec2(aAxisSelect);
    vec2 _20 = mix(aLocalSize, aLocalSize.yx, _19);
    vStyle = aStyle;
    switch (vStyle)
    {
        case 0:
        {
            break;
        }
        case 2:
        {
            float _42 = _20.x;
            vParams = vec4(_42, 0.5 * _42, 0.0, 0.0);
            break;
        }
        case 1:
        {
            float _53 = _20.y;
            vParams = vec4(_53 * 2.0, _53 * 0.5, 0.5 * _53, 0.0);
            break;
        }
        case 3:
        {
            float _72 = max(aWavyLineThickness, 1.0);
            float _75 = _20.y;
            vParams = vec4(_72 * 0.5, _75 - _72, max((_72 - 1.0) * 2.0, 1.0), _75);
            break;
        }
        default:
        {
            vParams = vec4(0.0);
            break;
        }
    }
    vLocalPos = mix(aPosition.xy, aPosition.yx, _19) * _20;
    gl_Position = uTransform * vec4(aTaskRect.xy + (aTaskRect.zw * aPosition.xy), 0.0, 1.0);
}

