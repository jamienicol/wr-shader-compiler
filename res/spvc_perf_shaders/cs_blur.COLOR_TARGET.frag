#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassColor;

in highp vec3 vUv;
flat in mediump int vSupport;
layout(location = 0) out highp vec4 oFragColor;
flat in highp float vSigma;
flat in highp vec2 vOffsetScale;
flat in highp vec4 vUvRect;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;

vec3 _231;

void main()
{
    switch (0u)
    {
        default:
        {
            highp vec4 _20 = texture(sPrevPassColor, vUv);
            if (vSupport == 0)
            {
                oFragColor = _20;
                break;
            }
            highp float _47 = 0.398942291736602783203125 / vSigma;
            highp vec3 _211 = _231;
            _211.x = _47;
            highp float _57 = exp((-0.5) / (vSigma * vSigma));
            highp vec3 _213 = _211;
            _213.y = _57;
            highp vec3 _217 = _213;
            _217.z = _57 * _57;
            highp vec2 _80 = _217.xy * _217.yz;
            highp vec4 _225;
            highp float _226;
            highp vec3 _227;
            _227 = vec3(_80.x, _80.y, _217.z);
            _226 = _47;
            _225 = _20 * _47;
            for (mediump int _224 = 1; _224 <= vSupport; )
            {
                highp float _96 = _227.x;
                highp vec2 _98 = _227.yz;
                highp vec2 _100 = _227.xy;
                highp vec2 _101 = _100 * _98;
                highp float _105 = _101.x;
                highp float _107 = _96 + _105;
                highp vec2 _122 = vOffsetScale * (float(_224) + (_105 / _107));
                highp vec2 _178 = _101.xy * vec3(_101.x, _101.y, _227.z).yz;
                _227 = vec3(_178.x, _178.y, _227.z);
                _226 += (2.0 * _107);
                _225 = (_225 + (texture(sPrevPassColor, vec3(clamp(vUv.xy - _122, vUvRect.xy, vUvRect.zw), vUv.z)) * _107)) + (texture(sPrevPassColor, vec3(clamp(vUv.xy + _122, vUvRect.xy, vUvRect.zw), vUv.z)) * _107);
                _224 += 2;
                continue;
            }
            oFragColor = _225 / vec4(_226);
            break;
        }
    }
}

