#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2D sGpuCache;

layout(location = 0) out highp vec4 oFragColor;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_0;
flat in int flat_varying_highp_int_address_0;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_1;

void main()
{
    highp vec2 _316 = mod(varying_vec4_0.zw, flat_varying_vec4_1.xy) - flat_varying_vec4_0.xy;
    highp float _321 = flat_varying_vec4_0.w - flat_varying_vec4_0.z;
    highp float _325 = -(_321 * _321);
    highp float _329 = flat_varying_vec4_0.z * _321;
    highp float _338 = dot(_316, _316) - (flat_varying_vec4_0.z * flat_varying_vec4_0.z);
    highp float _484;
    if (_325 == 0.0)
    {
        if (_329 == 0.0)
        {
            discard;
        }
        highp float _352 = (0.5 * _338) / _329;
        if (!((flat_varying_vec4_0.z + (_321 * _352)) >= 0.0))
        {
            discard;
        }
        _484 = _352;
    }
    else
    {
        highp float _370 = (_329 * _329) - (_325 * _338);
        if (_370 < 0.0)
        {
            discard;
        }
        highp float _376 = sqrt(_370);
        highp float _381 = (_329 + _376) / _325;
        highp float _386 = (_329 - _376) / _325;
        bool _393 = (flat_varying_vec4_0.z + (_321 * _381)) >= 0.0;
        if (_393)
        {
        }
        else
        {
            if (!((flat_varying_vec4_0.z + (_321 * _386)) >= 0.0))
            {
                discard;
            }
        }
        _484 = _393 ? _381 : _386;
    }
    highp float _429 = 1.0 + (mix(_484, fract(_484), flat_varying_vec4_1.z) * 128.0);
    uint _467 = uint(flat_varying_highp_int_address_0 + clamp(2 * int(floor(_429)), 0, 258));
    ivec2 _474 = ivec2(int(_467 % 1024u), int(_467 / 1024u));
    oFragColor = mix(texelFetch(sGpuCache, _474, 0), texelFetch(sGpuCache, _474 + ivec2(1, 0), 0), vec4(fract(_429)));
}

