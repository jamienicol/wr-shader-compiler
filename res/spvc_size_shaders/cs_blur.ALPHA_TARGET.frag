#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassAlpha;

in highp vec3 vUv;
flat in mediump int vSupport;
layout(location = 0) out highp vec4 oFragColor;
flat in highp float vSigma;
flat in highp vec2 vOffsetScale;
flat in highp vec4 vUvRect;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;

vec3 _222;

void main()
{
    switch (0u)
    {
        default:
        {
            highp vec4 _20 = texture(sPrevPassAlpha, vUv);
            highp float _23 = _20.x;
            if (vSupport == 0)
            {
                oFragColor = vec4(_23);
                break;
            }
            highp float _46 = 0.398942291736602783203125 / vSigma;
            highp vec3 _210 = _222;
            _210.x = _46;
            highp float _53 = exp((-0.5) / (vSigma * vSigma));
            highp vec3 _212 = _210;
            _212.y = _53;
            highp vec3 _216 = _212;
            _216.z = _53 * _53;
            highp vec2 _76 = _216.xy * _216.yz;
            highp float _205;
            highp float _206;
            highp vec3 _223;
            _223 = vec3(_76.x, _76.y, _216.z);
            _206 = _46;
            _205 = _23 * _46;
            for (mediump int _204 = 1; _204 <= vSupport; )
            {
                highp float _92 = _223.x;
                highp vec2 _94 = _223.yz;
                highp vec2 _96 = _223.xy;
                highp vec2 _97 = _96 * _94;
                highp float _101 = _97.x;
                highp float _103 = _92 + _101;
                highp vec2 _118 = vOffsetScale * (float(_204) + (_101 / _103));
                highp vec2 _176 = _97.xy * vec3(_97.x, _97.y, _223.z).yz;
                _223 = vec3(_176.x, _176.y, _223.z);
                _206 += (2.0 * _103);
                _205 = (_205 + (texture(sPrevPassAlpha, vec3(clamp(vUv.xy - _118, vUvRect.xy, vUvRect.zw), vUv.z)).x * _103)) + (texture(sPrevPassAlpha, vec3(clamp(vUv.xy + _118, vUvRect.xy, vUvRect.zw), vUv.z)).x * _103);
                _204 += 2;
                continue;
            }
            oFragColor = vec4(_205) / vec4(_206);
            break;
        }
    }
}

