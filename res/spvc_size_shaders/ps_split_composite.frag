#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec2 vLayerAndPerspective;
in highp vec2 vUv;
flat in highp vec4 vUvSampleBounds;
flat in highp vec4 vTransformBounds;

void main()
{
    highp float _211;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _211 = 1.0;
                break;
            }
            highp vec2 _175 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _175), greaterThan(vClipMaskUvBounds.zw, _175))))
            {
                _211 = 0.0;
                break;
            }
            _211 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_175), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = textureLod(sPrevPassColor, vec3(clamp(vUv * mix(gl_FragCoord.w, 1.0, vLayerAndPerspective.y), vUvSampleBounds.xy, vUvSampleBounds.zw), vLayerAndPerspective.x), 0.0) * _211;
}

