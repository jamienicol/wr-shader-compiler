#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sGpuCache;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec2 vLayerAndPerspective;
in highp vec2 vUv;
flat in highp vec4 vUvSampleBounds;
flat in highp vec4 vTransformBounds;

highp float do_clip()
{
    if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
    {
        return 1.0;
    }
    highp vec2 mask_uv = vClipMaskUv.xy * gl_FragCoord.w;
    bvec2 left = lessThanEqual(vClipMaskUvBounds.xy, mask_uv);
    bvec2 right = greaterThan(vClipMaskUvBounds.zw, mask_uv);
    if (!all(bvec4(left, right)))
    {
        return 0.0;
    }
    mediump ivec3 tc = ivec3(ivec2(mask_uv), int(vClipMaskUv.z + 0.5));
    return texelFetch(sPrevPassAlpha, tc, 0).x;
}

void write_output(highp vec4 color)
{
    oFragColor = color;
}

void main()
{
    highp float alpha = do_clip();
    highp float perspective_divisor = mix(gl_FragCoord.w, 1.0, vLayerAndPerspective.y);
    highp vec2 uv = clamp(vUv * perspective_divisor, vUvSampleBounds.xy, vUvSampleBounds.zw);
    highp vec4 param = textureLod(sPrevPassColor, vec3(uv, vLayerAndPerspective.x), 0.0) * alpha;
    write_output(param);
}

