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
    vec2 _996;
    switch (_171)
    {
        case 0:
        {
            _996 = vec2(0.0);
            break;
        }
        case 1:
        {
            _996 = vec2(1.0, 0.0);
            break;
        }
        case 2:
        {
            _996 = vec2(1.0);
            break;
        }
        case 3:
        {
            _996 = vec2(0.0, 1.0);
            break;
        }
        default:
        {
            _996 = vec2(0.0);
            break;
        }
    }
    vec2 _198 = _996 * aRect.zw;
    vec2 _204 = vec2(1.0) - (_996 * 2.0);
    ivec2 _997;
    vec2 _1017;
    switch (_171)
    {
        case 0:
        {
            _1017 = _198;
            _997 = ivec2(0, 1);
            break;
        }
        case 1:
        {
            _1017 = vec2(_198.x - aWidths.x, _198.y);
            _997 = ivec2(1, 0);
            break;
        }
        case 2:
        {
            _1017 = _198 - aWidths;
            _997 = ivec2(0, 1);
            break;
        }
        case 3:
        {
            _1017 = vec2(_198.x, _198.y - aWidths.y);
            _997 = ivec2(1, 0);
            break;
        }
        case 5:
        case 7:
        {
            _1017 = vec2(0.0);
            _997 = ivec2(1);
            break;
        }
        default:
        {
            _1017 = vec2(0.0);
            _997 = ivec2(0);
            break;
        }
    }
    vConfig = ivec4(_171, _176 | (_181 << 16), _997.x | (_997.y << 16), _187);
    vPartialWidths = vec4(aWidths * vec2(0.3333333432674407958984375), aWidths * vec2(0.5));
    vPos = aRect.zw * aPosition.xy;
    bool _506 = all(equal(aColor0.xyz, vec3(0.0)));
    vec4 _1003;
    vec4 _1004;
    switch (_176)
    {
        case 6:
        {
            vec4 _1001;
            switch (0u)
            {
                default:
                {
                    if (_506)
                    {
                        _1001 = vec4(0.699999988079071044921875, 0.699999988079071044921875, 0.699999988079071044921875, aColor0.w);
                        break;
                    }
                    _1001 = vec4(aColor0.xyz * 1.0, aColor0.w);
                    break;
                }
            }
            vec4 _1002;
            switch (0u)
            {
                default:
                {
                    if (_506)
                    {
                        _1002 = vec4(0.300000011920928955078125, 0.300000011920928955078125, 0.300000011920928955078125, aColor0.w);
                        break;
                    }
                    _1002 = vec4(aColor0.xyz * 0.666666686534881591796875, aColor0.w);
                    break;
                }
            }
            _1004 = _1001;
            _1003 = _1002;
            break;
        }
        case 7:
        {
            vec4 _999;
            switch (0u)
            {
                default:
                {
                    if (_506)
                    {
                        _999 = vec4(0.300000011920928955078125, 0.300000011920928955078125, 0.300000011920928955078125, aColor0.w);
                        break;
                    }
                    _999 = vec4(aColor0.xyz * 0.666666686534881591796875, aColor0.w);
                    break;
                }
            }
            vec4 _1000;
            switch (0u)
            {
                default:
                {
                    if (_506)
                    {
                        _1000 = vec4(0.699999988079071044921875, 0.699999988079071044921875, 0.699999988079071044921875, aColor0.w);
                        break;
                    }
                    _1000 = vec4(aColor0.xyz * 1.0, aColor0.w);
                    break;
                }
            }
            _1004 = _999;
            _1003 = _1000;
            break;
        }
        default:
        {
            _1004 = aColor0;
            _1003 = aColor0;
            break;
        }
    }
    vColor00 = _1004;
    vColor01 = _1003;
    bool _731 = all(equal(aColor1.xyz, vec3(0.0)));
    vec4 _1011;
    vec4 _1012;
    switch (_181)
    {
        case 6:
        {
            vec4 _1009;
            switch (0u)
            {
                default:
                {
                    if (_731)
                    {
                        _1009 = vec4(0.699999988079071044921875, 0.699999988079071044921875, 0.699999988079071044921875, aColor1.w);
                        break;
                    }
                    _1009 = vec4(aColor1.xyz * 1.0, aColor1.w);
                    break;
                }
            }
            vec4 _1010;
            switch (0u)
            {
                default:
                {
                    if (_731)
                    {
                        _1010 = vec4(0.300000011920928955078125, 0.300000011920928955078125, 0.300000011920928955078125, aColor1.w);
                        break;
                    }
                    _1010 = vec4(aColor1.xyz * 0.666666686534881591796875, aColor1.w);
                    break;
                }
            }
            _1012 = _1009;
            _1011 = _1010;
            break;
        }
        case 7:
        {
            vec4 _1007;
            switch (0u)
            {
                default:
                {
                    if (_731)
                    {
                        _1007 = vec4(0.300000011920928955078125, 0.300000011920928955078125, 0.300000011920928955078125, aColor1.w);
                        break;
                    }
                    _1007 = vec4(aColor1.xyz * 0.666666686534881591796875, aColor1.w);
                    break;
                }
            }
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
            _1012 = _1007;
            _1011 = _1008;
            break;
        }
        default:
        {
            _1012 = aColor1;
            _1011 = aColor1;
            break;
        }
    }
    vColor10 = _1012;
    vColor11 = _1011;
    float _328 = _204.x;
    vClipCenter_Sign = vec4(_198 + (_204 * aRadii), _328, _204.y);
    vClipRadii = vec4(aRadii, max(aRadii - aWidths, vec2(0.0)));
    vColorLine = vec4(_198, aWidths.y * (-_204.y), aWidths.x * _328);
    vEdgeReference = vec4(_1017, _1017 + aWidths);
    vClipParams1 = aClipParams1;
    vClipParams2 = aClipParams2;
    if (_187 == 3)
    {
        float _1028;
        if (aClipParams1.z > 0.5)
        {
            _1028 = aClipParams1.z + 2.0;
        }
        else
        {
            _1028 = aClipParams1.z;
        }
        vPos = vClipParams1.xy + (((aPosition.xy * 2.0) - vec2(1.0)) * _1028);
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

