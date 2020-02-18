#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;

flat in highp vec4 vTransformBounds;
in highp vec2 vUv;
in highp vec4 vLocalPos;
flat in highp vec4 vEdge;
flat in highp vec4 vUvBounds_NoClamp;
flat in highp vec4 vUvBounds;
flat in highp float vLayer;
flat in highp float vClipMode;
layout(location = 0) out highp vec4 oFragColor;

void main()
{
    highp vec2 _62 = vec2(vLocalPos.w);
    highp vec2 _63 = vUv / _62;
    highp vec2 _99 = vLocalPos.xy / _62;
    highp vec2 _167 = step(vTransformBounds.xy, _99) - step(vTransformBounds.zw, _99);
    highp vec4 _115 = texture(sColor0, vec3(clamp(mix(vUvBounds_NoClamp.xy, vUvBounds_NoClamp.zw, clamp(_63, vec2(0.0), vEdge.xy) + max(vec2(0.0), _63 - vEdge.zw)), vUvBounds.xy, vUvBounds.zw), vLayer));
    highp float _116 = _115.x;
    highp float _173;
    if (vLocalPos.w > 0.0)
    {
        _173 = mix(vClipMode, mix(_116, 1.0 - _116, vClipMode), _167.x * _167.y);
    }
    else
    {
        _173 = 0.0;
    }
    oFragColor = vec4(_173);
}

