#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sColor0;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_4;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 vTransformBounds;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

void main()
{
    highp vec4 _240 = texture(sColor0, vec3(clamp((varying_vec4_0.zw * mix(gl_FragCoord.w, 1.0, flat_varying_vec4_4.y)) + flat_varying_vec4_2.xy, flat_varying_vec4_3.xy, flat_varying_vec4_3.zw), flat_varying_vec4_4.x));
    highp vec3 _251 = (_240.xyz * flat_varying_vec4_1.x) + (_240.www * flat_varying_vec4_1.y);
    highp float _324;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _324 = 1.0;
                break;
            }
            highp vec2 _283 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _283), greaterThan(vClipMaskUvBounds.zw, _283))))
            {
                _324 = 0.0;
                break;
            }
            _324 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_283), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = (flat_varying_vec4_0 * (vec4(_251.x, _251.y, _251.z, _240.w) * 1.0)) * _324;
}

