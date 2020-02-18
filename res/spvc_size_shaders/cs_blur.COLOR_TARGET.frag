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

vec3 _228;

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
            highp vec3 _216 = _228;
            _216.x = _47;
            highp float _57 = exp((-0.5) / (vSigma * vSigma));
            highp vec3 _218 = _216;
            _218.y = _57;
            highp vec3 _222 = _218;
            _222.z = _57 * _57;
            highp vec2 _80 = _222.xy * _222.yz;
            highp vec4 _211;
            highp float _212;
            highp vec3 _229;
            _229 = vec3(_80.x, _80.y, _222.z);
            _212 = _47;
            _211 = _20 * _47;
            for (mediump int _210 = 1; _210 <= vSupport; )
            {
                highp float _96 = _229.x;
                highp vec2 _98 = _229.yz;
                highp vec2 _100 = _229.xy;
                highp vec2 _101 = _100 * _98;
                highp float _105 = _101.x;
                highp float _107 = _96 + _105;
                highp vec2 _122 = vOffsetScale * (float(_210) + (_105 / _107));
                highp vec2 _178 = _101.xy * vec3(_101.x, _101.y, _229.z).yz;
                _229 = vec3(_178.x, _178.y, _229.z);
                _212 += (2.0 * _107);
                _211 = (_211 + (texture(sPrevPassColor, vec3(clamp(vUv.xy - _122, vUvRect.xy, vUvRect.zw), vUv.z)) * _107)) + (texture(sPrevPassColor, vec3(clamp(vUv.xy + _122, vUvRect.xy, vUvRect.zw), vUv.z)) * _107);
                _210 += 2;
                continue;
            }
            oFragColor = _211 / vec4(_212);
            break;
        }
    }
}

