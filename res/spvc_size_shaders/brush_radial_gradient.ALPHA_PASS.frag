#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sPrevPassAlpha;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_0;
flat in int flat_varying_highp_int_address_0;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_1;

void main()
{
    highp vec2 _529 = max(varying_vec4_0.zw, vec2(0.0));
    highp vec2 _533 = mod(_529, flat_varying_vec4_1.xy);
    highp vec2 _538 = flat_varying_vec4_1.xy * flat_varying_vec4_2.xy;
    highp vec2 _890;
    if (_529.x >= _538.x)
    {
        highp vec2 _883 = _533;
        _883.x = flat_varying_vec4_1.x;
        _890 = _883;
    }
    else
    {
        _890 = _533;
    }
    highp vec2 _891;
    if (_529.y >= _538.y)
    {
        highp vec2 _887 = _890;
        _887.y = flat_varying_vec4_1.y;
        _891 = _887;
    }
    else
    {
        _891 = _890;
    }
    highp vec2 _562 = _891 - flat_varying_vec4_0.xy;
    highp float _567 = flat_varying_vec4_0.w - flat_varying_vec4_0.z;
    highp float _571 = -(_567 * _567);
    highp float _575 = flat_varying_vec4_0.z * _567;
    highp float _584 = dot(_562, _562) - (flat_varying_vec4_0.z * flat_varying_vec4_0.z);
    highp float _873;
    if (_571 == 0.0)
    {
        if (_575 == 0.0)
        {
            discard;
        }
        highp float _598 = (0.5 * _584) / _575;
        if (!((flat_varying_vec4_0.z + (_567 * _598)) >= 0.0))
        {
            discard;
        }
        _873 = _598;
    }
    else
    {
        highp float _616 = (_575 * _575) - (_571 * _584);
        if (_616 < 0.0)
        {
            discard;
        }
        highp float _622 = sqrt(_616);
        highp float _627 = (_575 + _622) / _571;
        highp float _632 = (_575 - _622) / _571;
        bool _639 = (flat_varying_vec4_0.z + (_567 * _627)) >= 0.0;
        if (_639)
        {
        }
        else
        {
            if (!((flat_varying_vec4_0.z + (_567 * _632)) >= 0.0))
            {
                discard;
            }
        }
        _873 = _639 ? _627 : _632;
    }
    highp float _680 = 1.0 + (mix(_873, fract(_873), flat_varying_vec4_1.z) * 128.0);
    uint _718 = uint(flat_varying_highp_int_address_0 + clamp(2 * int(floor(_680)), 0, 258));
    ivec2 _725 = ivec2(int(_718 % 1024u), int(_718 / 1024u));
    highp vec2 _756 = max(vTransformBounds.xy - varying_vec4_0.xy, varying_vec4_0.xy - vTransformBounds.zw);
    highp vec2 _769 = fwidth(varying_vec4_0.xy);
    highp float _875;
    switch (0u)
    {
        default:
        {
            highp float _781 = (0.5 * (length(max(vec2(0.0), _756)) + min(0.0, max(_756.x, _756.y)))) / (0.3535499870777130126953125 * length(_769));
            if (_781 <= (-0.4999000132083892822265625))
            {
                _875 = 1.0;
                break;
            }
            if (_781 >= 0.4999000132083892822265625)
            {
                _875 = 0.0;
                break;
            }
            _875 = 0.5 + (_781 * (((0.8431026935577392578125 * _781) * _781) - 1.14453601837158203125));
            break;
        }
    }
    highp float _877;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _877 = 1.0;
                break;
            }
            highp vec2 _820 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _820), greaterThan(vClipMaskUvBounds.zw, _820))))
            {
                _877 = 0.0;
                break;
            }
            _877 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_820), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = (mix(texelFetch(sGpuCache, _725, 0), texelFetch(sGpuCache, _725 + ivec2(1, 0), 0), vec4(fract(_680))) * _875) * _877;
}

