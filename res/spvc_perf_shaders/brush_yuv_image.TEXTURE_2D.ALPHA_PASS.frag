#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassAlpha;
uniform mediump sampler2D sColor0;
uniform mediump sampler2D sColor1;
uniform mediump sampler2D sColor2;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in mediump int vFormat;
in highp vec3 vUv_Y;
flat in highp vec4 vUvBounds_Y;
in highp vec3 vUv_U;
flat in highp vec4 vUvBounds_U;
in highp vec3 vUv_V;
flat in highp vec4 vUvBounds_V;
flat in highp mat3 vYuvColorMatrix;
flat in highp float vCoefficient;
in highp vec2 vLocalPos;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

vec3 _716;
float _724;
vec3 _725;

void main()
{
    highp vec3 _717;
    if (vFormat == 1)
    {
        highp vec3 _707 = _716;
        _707.x = texture(sColor0, vec3(clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw), _724).xy).x;
        highp vec3 _709 = _707;
        _709.y = texture(sColor1, vec3(clamp(vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw), _724).xy).x;
        highp vec3 _711 = _709;
        _711.z = texture(sColor2, vec3(clamp(vUv_V.xy, vUvBounds_V.xy, vUvBounds_V.zw), _724).xy).x;
        _717 = _711;
    }
    else
    {
        highp vec3 _718;
        if (vFormat == 0)
        {
            highp vec3 _713 = _725;
            _713.x = texture(sColor0, vec3(clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw), _724).xy).x;
            vec4 _533 = texture(sColor1, vec3(clamp(vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw), _724).xy);
            _718 = vec3(_713.x, _533.x, _533.y);
        }
        else
        {
            highp vec3 _719;
            if (vFormat == 2)
            {
                _719 = texture(sColor0, vec3(clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw), _724).xy).yzx;
            }
            else
            {
                _719 = vec3(0.0);
            }
            _718 = _719;
        }
        _717 = _718;
    }
    highp vec2 _604 = max(vTransformBounds.xy - vLocalPos, vLocalPos - vTransformBounds.zw);
    highp vec2 _617 = fwidth(vLocalPos);
    highp float _720;
    switch (0u)
    {
        default:
        {
            highp float _629 = (0.5 * (length(max(vec2(0.0), _604)) + min(0.0, max(_604.x, _604.y)))) / (0.3535499870777130126953125 * length(_617));
            if (_629 <= (-0.4999000132083892822265625))
            {
                _720 = 1.0;
                break;
            }
            if (_629 >= 0.4999000132083892822265625)
            {
                _720 = 0.0;
                break;
            }
            _720 = 0.5 + (_629 * (((0.8431026935577392578125 * _629) * _629) - 1.14453601837158203125));
            break;
        }
    }
    highp float _722;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _722 = 1.0;
                break;
            }
            highp vec2 _668 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _668), greaterThan(vClipMaskUvBounds.zw, _668))))
            {
                _722 = 0.0;
                break;
            }
            _722 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_668), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = (vec4(vYuvColorMatrix * ((_717 * vCoefficient) - vec3(0.06274999678134918212890625, 0.501959979534149169921875, 0.501959979534149169921875)), 1.0) * _720) * _722;
}

