#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sPrevPassColor;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 vTransformBounds;
in highp vec4 varying_vec4_1;

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
    highp vec3 tc = vec3(clamp(varying_vec4_0.xy, flat_varying_vec4_2.xy, flat_varying_vec4_2.zw), varying_vec4_0.z);
    highp vec4 mask = texture(sColor0, tc);
    highp vec3 _134 = (mask.xyz * flat_varying_vec4_1.x) + (mask.www * flat_varying_vec4_1.y);
    mask = vec4(_134.x, _134.y, _134.z, mask.w);
    highp float alpha = do_clip();
    highp vec4 param = (flat_varying_vec4_0 * mask) * alpha;
    write_output(param);
}
