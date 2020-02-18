#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sPrevPassAlpha;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_0;
flat in int flat_varying_highp_int_address_0;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_1;

void main()
{
    highp vec2 _419 = max(varying_vec4_0.zw, vec2(0.0));
    highp vec2 _423 = mod(_419, flat_varying_vec4_1.xy);
    highp vec2 _428 = flat_varying_vec4_1.xy * flat_varying_vec4_2.xy;
    highp vec2 _673;
    if (_419.x >= _428.x)
    {
        highp vec2 _666 = _423;
        _666.x = flat_varying_vec4_1.x;
        _673 = _666;
    }
    else
    {
        _673 = _423;
    }
    highp vec2 _674;
    if (_419.y >= _428.y)
    {
        highp vec2 _670 = _673;
        _670.y = flat_varying_vec4_1.y;
        _674 = _670;
    }
    else
    {
        _674 = _673;
    }
    highp float _455 = dot(_674 - flat_varying_vec4_0.xy, flat_varying_vec4_0.zw);
    highp float _481 = 1.0 + (mix(_455, fract(_455), flat_varying_vec4_1.z) * 128.0);
    uint _519 = uint(flat_varying_highp_int_address_0 + clamp(2 * int(floor(_481)), 0, 258));
    ivec2 _526 = ivec2(int(_519 % 1024u), int(_519 / 1024u));
    highp vec2 _557 = max(vTransformBounds.xy - varying_vec4_0.xy, varying_vec4_0.xy - vTransformBounds.zw);
    highp vec2 _570 = fwidth(varying_vec4_0.xy);
    highp float _675;
    switch (0u)
    {
        default:
        {
            highp float _582 = (0.5 * (length(max(vec2(0.0), _557)) + min(0.0, max(_557.x, _557.y)))) / (0.3535499870777130126953125 * length(_570));
            if (_582 <= (-0.4999000132083892822265625))
            {
                _675 = 1.0;
                break;
            }
            if (_582 >= 0.4999000132083892822265625)
            {
                _675 = 0.0;
                break;
            }
            _675 = 0.5 + (_582 * (((0.8431026935577392578125 * _582) * _582) - 1.14453601837158203125));
            break;
        }
    }
    highp float _677;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _677 = 1.0;
                break;
            }
            highp vec2 _621 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _621), greaterThan(vClipMaskUvBounds.zw, _621))))
            {
                _677 = 0.0;
                break;
            }
            _677 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_621), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = (mix(texelFetch(sGpuCache, _526, 0), texelFetch(sGpuCache, _526 + ivec2(1, 0), 0), vec4(fract(_481))) * _675) * _677;
}

