#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;

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

vec3 _712;
vec3 _713;

void main()
{
    highp vec3 _714;
    if (vFormat == 1)
    {
        highp vec3 _703 = _713;
        _703.x = texture(sColor0, vec3(clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw), vUv_Y.z)).x;
        highp vec3 _705 = _703;
        _705.y = texture(sColor1, vec3(clamp(vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw), vUv_U.z)).x;
        highp vec3 _707 = _705;
        _707.z = texture(sColor2, vec3(clamp(vUv_V.xy, vUvBounds_V.xy, vUvBounds_V.zw), vUv_V.z)).x;
        _714 = _707;
    }
    else
    {
        highp vec3 _715;
        if (vFormat == 0)
        {
            highp vec3 _709 = _712;
            _709.x = texture(sColor0, vec3(clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw), vUv_Y.z)).x;
            highp vec4 _522 = texture(sColor1, vec3(clamp(vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw), vUv_U.z));
            _715 = vec3(_709.x, _522.x, _522.y);
        }
        else
        {
            highp vec3 _716;
            if (vFormat == 2)
            {
                _716 = texture(sColor0, vec3(clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw), vUv_Y.z)).yzx;
            }
            else
            {
                _716 = vec3(0.0);
            }
            _715 = _716;
        }
        _714 = _715;
    }
    highp vec2 _592 = max(vTransformBounds.xy - vLocalPos, vLocalPos - vTransformBounds.zw);
    highp vec2 _605 = fwidth(vLocalPos);
    highp float _698;
    switch (0u)
    {
        default:
        {
            highp float _617 = (0.5 * (length(max(vec2(0.0), _592)) + min(0.0, max(_592.x, _592.y)))) / (0.3535499870777130126953125 * length(_605));
            if (_617 <= (-0.4999000132083892822265625))
            {
                _698 = 1.0;
                break;
            }
            if (_617 >= 0.4999000132083892822265625)
            {
                _698 = 0.0;
                break;
            }
            _698 = 0.5 + (_617 * (((0.8431026935577392578125 * _617) * _617) - 1.14453601837158203125));
            break;
        }
    }
    highp float _700;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _700 = 1.0;
                break;
            }
            highp vec2 _656 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _656), greaterThan(vClipMaskUvBounds.zw, _656))))
            {
                _700 = 0.0;
                break;
            }
            _700 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_656), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = (vec4(vYuvColorMatrix * ((_714 * vCoefficient) - vec3(0.06274999678134918212890625, 0.501959979534149169921875, 0.501959979534149169921875)), 1.0) * _698) * _700;
}

