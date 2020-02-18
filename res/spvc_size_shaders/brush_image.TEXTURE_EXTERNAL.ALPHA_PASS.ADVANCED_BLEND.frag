#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassAlpha;
uniform mediump sampler2D sColor0;

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

float _332;

void main()
{
    vec4 _242 = texture(sColor0, vec3(clamp((varying_vec4_0.zw * mix(gl_FragCoord.w, 1.0, flat_varying_vec4_4.y)) + flat_varying_vec4_2.xy, flat_varying_vec4_3.xy, flat_varying_vec4_3.zw), _332).xy);
    highp vec3 _253 = (_242.xyz * flat_varying_vec4_1.x) + (_242.www * flat_varying_vec4_1.y);
    highp float _330;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _330 = 1.0;
                break;
            }
            highp vec2 _285 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _285), greaterThan(vClipMaskUvBounds.zw, _285))))
            {
                _330 = 0.0;
                break;
            }
            _330 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_285), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = (flat_varying_vec4_0 * (vec4(_253.x, _253.y, _253.z, _242.w) * 1.0)) * _330;
}

