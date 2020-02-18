#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sGpuCache;

flat in highp vec4 vTransformBounds;
in highp vec2 vUv;
in highp vec4 vLocalPos;
flat in highp vec4 vEdge;
flat in highp vec4 vUvBounds_NoClamp;
flat in highp vec4 vUvBounds;
flat in highp float vLayer;
flat in highp float vClipMode;
layout(location = 0) out highp vec4 oFragColor;

highp float point_inside_rect(highp vec2 p, highp vec2 p0, highp vec2 p1)
{
    highp vec2 s = step(p0, p) - step(p1, p);
    return s.x * s.y;
}

highp float init_transform_rough_fs(highp vec2 local_pos)
{
    highp vec2 param = local_pos;
    highp vec2 param_1 = vTransformBounds.xy;
    highp vec2 param_2 = vTransformBounds.zw;
    return point_inside_rect(param, param_1, param_2);
}

void main()
{
    highp vec2 uv_linear = vUv / vec2(vLocalPos.w);
    highp vec2 uv = clamp(uv_linear, vec2(0.0), vEdge.xy);
    uv += max(vec2(0.0), uv_linear - vEdge.zw);
    uv = mix(vUvBounds_NoClamp.xy, vUvBounds_NoClamp.zw, uv);
    uv = clamp(uv, vUvBounds.xy, vUvBounds.zw);
    highp vec2 param = vLocalPos.xy / vec2(vLocalPos.w);
    highp float in_shadow_rect = init_transform_rough_fs(param);
    highp float texel = texture(sColor0, vec3(uv, vLayer)).x;
    highp float alpha = mix(texel, 1.0 - texel, vClipMode);
    highp float _129;
    if (vLocalPos.w > 0.0)
    {
        _129 = mix(vClipMode, alpha, in_shadow_rect);
    }
    else
    {
        _129 = 0.0;
    }
    highp float result = _129;
    oFragColor = vec4(result);
}

