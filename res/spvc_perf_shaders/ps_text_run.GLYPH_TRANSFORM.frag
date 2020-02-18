#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sColor0;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_1;
in highp vec4 varying_vec4_1;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 vTransformBounds;

void main()
{
    highp vec4 _122 = texture(sColor0, vec3(clamp(varying_vec4_0.xy, flat_varying_vec4_2.xy, flat_varying_vec4_2.zw), varying_vec4_0.z));
    highp vec3 _135 = (_122.xyz * flat_varying_vec4_1.x) + (_122.www * flat_varying_vec4_1.y);
    highp float _230;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _230 = 1.0;
                break;
            }
            highp vec2 _194 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _194), greaterThan(vClipMaskUvBounds.zw, _194))))
            {
                _230 = 0.0;
                break;
            }
            _230 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_194), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = (flat_varying_vec4_0 * vec4(_135.x, _135.y, _135.z, _122.w)) * (_230 * float(all(greaterThanEqual(varying_vec4_1, vec4(0.0)))));
}

