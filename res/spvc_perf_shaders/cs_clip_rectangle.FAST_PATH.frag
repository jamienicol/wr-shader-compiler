#version 300 es
precision mediump float;
precision highp int;

in highp vec4 vLocalPos;
flat in highp vec3 vClipParams;
flat in highp float vClipMode;
layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;

void main()
{
    highp vec2 _112 = vLocalPos.xy / vec2(vLocalPos.w);
    highp vec2 _175 = fwidth(_112);
    highp vec2 _191 = abs(_112) - vClipParams.xy;
    highp float _231;
    switch (0u)
    {
        default:
        {
            highp float _211 = (0.5 * ((length(max(_191, vec2(0.0))) + min(max(_191.x, _191.y), 0.0)) - vClipParams.z)) / (0.3535499870777130126953125 * length(_175));
            if (_211 <= (-0.4999000132083892822265625))
            {
                _231 = 1.0;
                break;
            }
            if (_211 >= 0.4999000132083892822265625)
            {
                _231 = 0.0;
                break;
            }
            _231 = 0.5 + (_211 * (((0.8431026935577392578125 * _211) * _211) - 1.14453601837158203125));
            break;
        }
    }
    oFragColor = vec4((vLocalPos.w > 0.0) ? mix(_231, 1.0 - _231, vClipMode) : 0.0, 0.0, 0.0, 1.0);
}

