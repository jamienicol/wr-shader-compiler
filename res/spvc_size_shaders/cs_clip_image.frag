#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;

flat in highp vec4 vTransformBounds;
in highp vec4 vLocalPos;
in highp vec2 vClipMaskImageUv;
flat in highp vec4 vClipMaskUvRect;
flat in highp vec4 vClipMaskUvInnerRect;
flat in highp float vLayer;
layout(location = 0) out highp vec4 oFragColor;

void main()
{
    highp vec2 _125 = vec2(vLocalPos.w);
    highp vec2 _126 = vLocalPos.xy / _125;
    highp float _280;
    if (vLocalPos.w > 0.0)
    {
        highp vec2 _236 = max(vTransformBounds.xy - _126, _126 - vTransformBounds.zw);
        highp vec2 _249 = fwidth(_126);
        highp float _279;
        switch (0u)
        {
            default:
            {
                highp float _261 = (0.5 * (length(max(vec2(0.0), _236)) + min(0.0, max(_236.x, _236.y)))) / (0.3535499870777130126953125 * length(_249));
                if (_261 <= (-0.4999000132083892822265625))
                {
                    _279 = 1.0;
                    break;
                }
                if (_261 >= 0.4999000132083892822265625)
                {
                    _279 = 0.0;
                    break;
                }
                _279 = 0.5 + (_261 * (((0.8431026935577392578125 * _261) * _261) - 1.14453601837158203125));
                break;
            }
        }
        _280 = _279;
    }
    else
    {
        _280 = 0.0;
    }
    highp vec2 _145 = clamp(vClipMaskImageUv, vec2(0.0), vLocalPos.ww);
    if (any(notEqual(_145, vClipMaskImageUv)))
    {
        discard;
    }
    oFragColor = vec4(_280 * texture(sColor0, vec3(clamp(((_145 / _125) * vClipMaskUvRect.zw) + vClipMaskUvRect.xy, vClipMaskUvInnerRect.xy, vClipMaskUvInnerRect.zw), vLayer)).x, 1.0, 1.0, 1.0);
}

