#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sColor0;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_2;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

void main()
{
    highp vec2 _360 = varying_vec4_0.zw * mix(gl_FragCoord.w, 1.0, flat_varying_vec4_2.y);
    highp vec4 _368 = texture(sColor0, vec3(_360, flat_varying_vec4_2.x));
    highp float _370 = _368.w;
    highp vec3 _556;
    if (_370 != 0.0)
    {
        _556 = _368.xyz / vec3(_370);
    }
    else
    {
        _556 = _368.xyz;
    }
    highp vec2 _416 = step(flat_varying_vec4_1.xy, _360) - step(flat_varying_vec4_1.zw, _360);
    highp vec2 _450 = max(vTransformBounds.xy - varying_vec4_0.xy, varying_vec4_0.xy - vTransformBounds.zw);
    highp vec2 _463 = fwidth(varying_vec4_0.xy);
    highp float _559;
    switch (0u)
    {
        default:
        {
            highp float _475 = (0.5 * (length(max(vec2(0.0), _450)) + min(0.0, max(_450.x, _450.y)))) / (0.3535499870777130126953125 * length(_463));
            if (_475 <= (-0.4999000132083892822265625))
            {
                _559 = 1.0;
                break;
            }
            if (_475 >= 0.4999000132083892822265625)
            {
                _559 = 0.0;
                break;
            }
            _559 = 0.5 + (_475 * (((0.8431026935577392578125 * _475) * _475) - 1.14453601837158203125));
            break;
        }
    }
    highp float _562;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _562 = 1.0;
                break;
            }
            highp vec2 _514 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _514), greaterThan(vClipMaskUvBounds.zw, _514))))
            {
                _562 = 0.0;
                break;
            }
            _562 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_514), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = (vec4(_556, 1.0) * ((_370 * flat_varying_vec4_2.z) * min(_416.x * _416.y, _559))) * _562;
}

