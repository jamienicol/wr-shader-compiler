#version 300 es

uniform mat4 uTransform;

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

void main()
{
    int _171 = aFlags & 255;
    int _176 = (aFlags >> 8) & 255;
    int _181 = (aFlags >> 16) & 255;
    int _187 = (aFlags >> 24) & 15;
    vec2 _970;
    switch (_171)
    {
        case 0:
        {
            _970 = vec2(0.0);
            break;
        }
        case 1:
        {
            _970 = vec2(1.0, 0.0);
            break;
        }
        case 2:
        {
            _970 = vec2(1.0);
            break;
        }
        case 3:
        {
            _970 = vec2(0.0, 1.0);
            break;
        }
        default:
        {
            _970 = vec2(0.0);
            break;
        }
    }
    vec2 _198 = _970 * aRect.zw;
    vec2 _204 = vec2(1.0) - (_970 * 2.0);
    vec2 _1018;
    ivec2 _1069;
    switch (_171)
    {
        case 0:
        {
            _1069 = ivec2(0, 1);
            _1018 = _198;
            break;
        }
        case 1:
        {
            _1069 = ivec2(1, 0);
            _1018 = vec2(_198.x - aWidths.x, _198.y);
            break;
        }
        case 2:
        {
            _1069 = ivec2(0, 1);
            _1018 = _198 - aWidths;
            break;
        }
        case 3:
        {
            _1069 = ivec2(1, 0);
            _1018 = vec2(_198.x, _198.y - aWidths.y);
            break;
        }
        case 5:
        case 7:
        {
            _1069 = ivec2(1);
            _1018 = vec2(0.0);
            break;
        }
        default:
        {
            _1069 = ivec2(0);
            _1018 = vec2(0.0);
            break;
        }
    }
    vConfig = ivec4(_171, _176 | (_181 << 16), _1069.x | (_1069.y << 16), _187);
    vPartialWidths = vec4(aWidths * vec2(0.3333333432674407958984375), aWidths * vec2(0.5));
    vPos = aRect.zw * aPosition.xy;
    bool _506 = all(equal(aColor0.xyz, vec3(0.0)));
    vec4 _995;
    vec4 _996;
    switch (_176)
    {
        case 6:
        {
            vec4 _991;
            switch (0u)
            {
                default:
                {
                    if (_506)
                    {
                        _991 = vec4(0.699999988079071044921875, 0.699999988079071044921875, 0.699999988079071044921875, aColor0.w);
                        break;
                    }
                    _991 = vec4(aColor0.xyz * 1.0, aColor0.w);
                    break;
                }
            }
            vec4 _994;
            switch (0u)
            {
                default:
                {
                    if (_506)
                    {
                        _994 = vec4(0.300000011920928955078125, 0.300000011920928955078125, 0.300000011920928955078125, aColor0.w);
                        break;
                    }
                    _994 = vec4(aColor0.xyz * 0.666666686534881591796875, aColor0.w);
                    break;
                }
            }
            _996 = _991;
            _995 = _994;
            break;
        }
        case 7:
        {
            vec4 _987;
            switch (0u)
            {
                default:
                {
                    if (_506)
                    {
                        _987 = vec4(0.300000011920928955078125, 0.300000011920928955078125, 0.300000011920928955078125, aColor0.w);
                        break;
                    }
                    _987 = vec4(aColor0.xyz * 0.666666686534881591796875, aColor0.w);
                    break;
                }
            }
            vec4 _990;
            switch (0u)
            {
                default:
                {
                    if (_506)
                    {
                        _990 = vec4(0.699999988079071044921875, 0.699999988079071044921875, 0.699999988079071044921875, aColor0.w);
                        break;
                    }
                    _990 = vec4(aColor0.xyz * 1.0, aColor0.w);
                    break;
                }
            }
            _996 = _987;
            _995 = _990;
            break;
        }
        default:
        {
            _996 = aColor0;
            _995 = aColor0;
            break;
        }
    }
    vColor00 = _996;
    vColor01 = _995;
    bool _731 = all(equal(aColor1.xyz, vec3(0.0)));
    vec4 _1012;
    vec4 _1013;
    switch (_181)
    {
        case 6:
        {
            vec4 _1008;
            switch (0u)
            {
                default:
                {
                    if (_731)
                    {
                        _1008 = vec4(0.699999988079071044921875, 0.699999988079071044921875, 0.699999988079071044921875, aColor1.w);
                        break;
                    }
                    _1008 = vec4(aColor1.xyz * 1.0, aColor1.w);
                    break;
                }
            }
            vec4 _1011;
            switch (0u)
            {
                default:
                {
                    if (_731)
                    {
                        _1011 = vec4(0.300000011920928955078125, 0.300000011920928955078125, 0.300000011920928955078125, aColor1.w);
                        break;
                    }
                    _1011 = vec4(aColor1.xyz * 0.666666686534881591796875, aColor1.w);
                    break;
                }
            }
            _1013 = _1008;
            _1012 = _1011;
            break;
        }
        case 7:
        {
            vec4 _1004;
            switch (0u)
            {
                default:
                {
                    if (_731)
                    {
                        _1004 = vec4(0.300000011920928955078125, 0.300000011920928955078125, 0.300000011920928955078125, aColor1.w);
                        break;
                    }
                    _1004 = vec4(aColor1.xyz * 0.666666686534881591796875, aColor1.w);
                    break;
                }
            }
            vec4 _1007;
            switch (0u)
            {
                default:
                {
                    if (_731)
                    {
                        _1007 = vec4(0.699999988079071044921875, 0.699999988079071044921875, 0.699999988079071044921875, aColor1.w);
                        break;
                    }
                    _1007 = vec4(aColor1.xyz * 1.0, aColor1.w);
                    break;
                }
            }
            _1013 = _1004;
            _1012 = _1007;
            break;
        }
        default:
        {
            _1013 = aColor1;
            _1012 = aColor1;
            break;
        }
    }
    vColor10 = _1013;
    vColor11 = _1012;
    float _328 = _204.x;
    vClipCenter_Sign = vec4(_198 + (_204 * aRadii), _328, _204.y);
    vClipRadii = vec4(aRadii, max(aRadii - aWidths, vec2(0.0)));
    vColorLine = vec4(_198, aWidths.y * (-_204.y), aWidths.x * _328);
    vEdgeReference = vec4(_1018, _1018 + aWidths);
    vClipParams1 = aClipParams1;
    vClipParams2 = aClipParams2;
    if (_187 == 3)
    {
        float _1039;
        if (aClipParams1.z > 0.5)
        {
            _1039 = aClipParams1.z + 2.0;
        }
        else
        {
            _1039 = aClipParams1.z;
        }
        vPos = vClipParams1.xy + (((aPosition.xy * 2.0) - vec2(1.0)) * _1039);
        vPos = clamp(vPos, vec2(0.0), aRect.zw);
    }
    else
    {
        if (_187 == 1)
        {
            vec2 _415 = (aClipParams1.xy + aClipParams2.xy) * 0.5;
            vec2 _435 = vec2(max(length(aClipParams1.xy - aClipParams2.xy), max(aWidths.x, aWidths.y))) + vec2(2.0);
            vPos = clamp(vPos, _415 - _435, _415 + _435);
        }
    }
    gl_Position = uTransform * vec4((aTaskOrigin + aRect.xy) + vPos, 0.0, 1.0);
}

