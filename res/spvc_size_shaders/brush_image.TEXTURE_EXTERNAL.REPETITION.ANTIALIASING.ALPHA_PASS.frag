#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassAlpha;
uniform mediump sampler2D sColor0;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_2;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_4;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_0;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

float _615;

void main()
{
    highp vec2 _425 = flat_varying_vec4_2.zw - flat_varying_vec4_2.xy;
    highp vec2 _430 = max(varying_vec4_0.zw * mix(gl_FragCoord.w, 1.0, flat_varying_vec4_4.y), vec2(0.0));
    highp vec2 _436 = mod(_430, _425) + flat_varying_vec4_2.xy;
    highp vec2 _616;
    if (_430.x >= (flat_varying_vec4_1.z * _425.x))
    {
        highp vec2 _608 = _436;
        _608.x = flat_varying_vec4_2.z;
        _616 = _608;
    }
    else
    {
        _616 = _436;
    }
    highp vec2 _617;
    if (_430.y >= (flat_varying_vec4_1.w * _425.y))
    {
        highp vec2 _612 = _616;
        _612.y = flat_varying_vec4_2.w;
        _617 = _612;
    }
    else
    {
        _617 = _616;
    }
    vec4 _392 = texture(sColor0, vec3(clamp(_617, flat_varying_vec4_3.xy, flat_varying_vec4_3.zw), _615).xy);
    highp vec2 _492 = max(vTransformBounds.xy - varying_vec4_0.xy, varying_vec4_0.xy - vTransformBounds.zw);
    highp vec2 _505 = fwidth(varying_vec4_0.xy);
    highp float _601;
    switch (0u)
    {
        default:
        {
            highp float _517 = (0.5 * (length(max(vec2(0.0), _492)) + min(0.0, max(_492.x, _492.y)))) / (0.3535499870777130126953125 * length(_505));
            if (_517 <= (-0.4999000132083892822265625))
            {
                _601 = 1.0;
                break;
            }
            if (_517 >= 0.4999000132083892822265625)
            {
                _601 = 0.0;
                break;
            }
            _601 = 0.5 + (_517 * (((0.8431026935577392578125 * _517) * _517) - 1.14453601837158203125));
            break;
        }
    }
    highp vec3 _406 = (_392.xyz * flat_varying_vec4_1.x) + (_392.www * flat_varying_vec4_1.y);
    highp float _603;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _603 = 1.0;
                break;
            }
            highp vec2 _556 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _556), greaterThan(vClipMaskUvBounds.zw, _556))))
            {
                _603 = 0.0;
                break;
            }
            _603 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_556), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = (flat_varying_vec4_0 * (vec4(_406.x, _406.y, _406.z, _392.w) * _601)) * _603;
}
