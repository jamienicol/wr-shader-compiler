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

vec3 _225;

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
            highp vec3 _205 = _225;
            _205.x = _46;
            highp float _53 = exp((-0.5) / (vSigma * vSigma));
            highp vec3 _207 = _205;
            _207.y = _53;
            highp vec3 _211 = _207;
            _211.z = _53 * _53;
            highp vec2 _76 = _211.xy * _211.yz;
            highp float _219;
            highp float _220;
            highp vec3 _221;
            _221 = vec3(_76.x, _76.y, _211.z);
            _220 = _46;
            _219 = _23 * _46;
            for (mediump int _218 = 1; _218 <= vSupport; )
            {
                highp float _92 = _221.x;
                highp vec2 _94 = _221.yz;
                highp vec2 _96 = _221.xy;
                highp vec2 _97 = _96 * _94;
                highp float _101 = _97.x;
                highp float _103 = _92 + _101;
                highp vec2 _118 = vOffsetScale * (float(_218) + (_101 / _103));
                highp vec2 _176 = _97.xy * vec3(_97.x, _97.y, _221.z).yz;
                _221 = vec3(_176.x, _176.y, _221.z);
                _220 += (2.0 * _103);
                _219 = (_219 + (texture(sPrevPassAlpha, vec3(clamp(vUv.xy - _118, vUvRect.xy, vUvRect.zw), vUv.z)).x * _103)) + (texture(sPrevPassAlpha, vec3(clamp(vUv.xy + _118, vUvRect.xy, vUvRect.zw), vUv.z)).x * _103);
                _218 += 2;
                continue;
            }
            oFragColor = vec4(_219) / vec4(_220);
            break;
        }
    }
}

