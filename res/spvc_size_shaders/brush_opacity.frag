#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 flat_varying_vec4_2;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

void main()
{
    highp vec2 _285 = varying_vec4_0.zw * mix(gl_FragCoord.w, 1.0, flat_varying_vec4_2.y);
    highp vec4 _293 = texture(sColor0, vec3(_285, flat_varying_vec4_2.x));
    highp float _295 = _293.w;
    highp vec3 _425;
    if (_295 != 0.0)
    {
        _425 = _293.xyz / vec3(_295);
    }
    else
    {
        _425 = _293.xyz;
    }
    highp vec2 _341 = step(flat_varying_vec4_1.xy, _285) - step(flat_varying_vec4_1.zw, _285);
    highp vec2 _375 = max(vTransformBounds.xy - varying_vec4_0.xy, varying_vec4_0.xy - vTransformBounds.zw);
    highp vec2 _388 = fwidth(varying_vec4_0.xy);
    highp float _428;
    switch (0u)
    {
        default:
        {
            highp float _400 = (0.5 * (length(max(vec2(0.0), _375)) + min(0.0, max(_375.x, _375.y)))) / (0.3535499870777130126953125 * length(_388));
            if (_400 <= (-0.4999000132083892822265625))
            {
                _428 = 1.0;
                break;
            }
            if (_400 >= 0.4999000132083892822265625)
            {
                _428 = 0.0;
                break;
            }
            _428 = 0.5 + (_400 * (((0.8431026935577392578125 * _400) * _400) - 1.14453601837158203125));
            break;
        }
    }
    oFragColor = vec4(_425, 1.0) * ((_295 * flat_varying_vec4_2.z) * min(_341.x * _341.y, _428));
}

