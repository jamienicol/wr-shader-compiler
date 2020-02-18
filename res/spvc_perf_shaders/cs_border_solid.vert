#version 300 es

uniform mat4 uTransform;

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

void main()
{
    int _44 = aFlags & 255;
    vec2 _248;
    switch (_44)
    {
        case 0:
        {
            _248 = vec2(0.0);
            break;
        }
        case 1:
        {
            _248 = vec2(1.0, 0.0);
            break;
        }
        case 2:
        {
            _248 = vec2(1.0);
            break;
        }
        case 3:
        {
            _248 = vec2(0.0, 1.0);
            break;
        }
        default:
        {
            _248 = vec2(0.0);
            break;
        }
    }
    vec2 _66 = _248 * aRect.zw;
    vec2 _72 = vec2(1.0) - (_248 * 2.0);
    int _249;
    switch (_44)
    {
        case 0:
        case 1:
        case 2:
        case 3:
        {
            _249 = (((aFlags >> 24) & 240) != 0) ? 1 : 2;
            break;
        }
        default:
        {
            _249 = 0;
            break;
        }
    }
    vMixColors = _249;
    vPos = aRect.zw * aPosition.xy;
    vColor0 = aColor0;
    vColor1 = aColor1;
    float _116 = _72.x;
    float _117 = _72.y;
    vClipCenter_Sign = vec4(_66 + (_72 * aRadii), _116, _117);
    vClipRadii = vec4(aRadii, max(aRadii - aWidths, vec2(0.0)));
    float _142 = -_117;
    vColorLine = vec4(_66, aWidths.y * _142, aWidths.x * _116);
    float _156 = -_116;
    vHorizontalClipCenter_Sign = vec4(aClipParams1.xy + (vec2(_156, _117) * aClipParams1.zw), _156, _117);
    vHorizontalClipRadii = aClipParams1.zw;
    vVerticalClipCenter_Sign = vec4(aClipParams2.xy + (vec2(_116, _142) * aClipParams2.zw), _116, _142);
    vVerticalClipRadii = aClipParams2.zw;
    gl_Position = uTransform * vec4((aTaskOrigin + aRect.xy) + vPos, 0.0, 1.0);
}

