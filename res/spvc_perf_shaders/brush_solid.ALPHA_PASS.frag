#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassAlpha;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_0;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

void main()
{
    highp vec2 _302 = max(vTransformBounds.xy - varying_vec4_0.xy, varying_vec4_0.xy - vTransformBounds.zw);
    highp vec2 _315 = fwidth(varying_vec4_0.xy);
    highp float _406;
    switch (0u)
    {
        default:
        {
            highp float _327 = (0.5 * (length(max(vec2(0.0), _302)) + min(0.0, max(_302.x, _302.y)))) / (0.3535499870777130126953125 * length(_315));
            if (_327 <= (-0.4999000132083892822265625))
            {
                _406 = 1.0;
                break;
            }
            if (_327 >= 0.4999000132083892822265625)
            {
                _406 = 0.0;
                break;
            }
            _406 = 0.5 + (_327 * (((0.8431026935577392578125 * _327) * _327) - 1.14453601837158203125));
            break;
        }
    }
    highp float _408;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _408 = 1.0;
                break;
            }
            highp vec2 _366 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _366), greaterThan(vClipMaskUvBounds.zw, _366))))
            {
                _408 = 0.0;
                break;
            }
            _408 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_366), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = (flat_varying_vec4_0 * _406) * _408;
}

