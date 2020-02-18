#version 300 es
precision mediump float;
precision highp int;

uniform mediump sampler2D sColor0;
uniform mediump sampler2D sColor1;
uniform mediump sampler2D sColor2;

layout(location = 0) out highp vec4 oFragColor;
flat in mediump int vFormat;
in highp vec3 vUv_Y;
flat in highp vec4 vUvBounds_Y;
in highp vec3 vUv_U;
flat in highp vec4 vUvBounds_U;
in highp vec3 vUv_V;
flat in highp vec4 vUvBounds_V;
flat in highp mat3 vYuvColorMatrix;
flat in highp float vCoefficient;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in mediump ivec4 flat_varying_ivec4_0;
in highp vec4 varying_vec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

vec3 _393;
float _397;
vec3 _398;

void main()
{
    highp vec3 _394;
    if (vFormat == 1)
    {
        highp vec3 _386 = _393;
        _386.x = texture(sColor0, vec3(clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw), _397).xy).x;
        highp vec3 _388 = _386;
        _388.y = texture(sColor1, vec3(clamp(vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw), _397).xy).x;
        highp vec3 _390 = _388;
        _390.z = texture(sColor2, vec3(clamp(vUv_V.xy, vUvBounds_V.xy, vUvBounds_V.zw), _397).xy).x;
        _394 = _390;
    }
    else
    {
        highp vec3 _395;
        if (vFormat == 0)
        {
            highp vec3 _392 = _398;
            _392.x = texture(sColor0, vec3(clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw), _397).xy).x;
            vec4 _343 = texture(sColor1, vec3(clamp(vUv_U.xy, vUvBounds_U.xy, vUvBounds_U.zw), _397).xy);
            _395 = vec3(_392.x, _343.x, _343.y);
        }
        else
        {
            highp vec3 _396;
            if (vFormat == 2)
            {
                _396 = texture(sColor0, vec3(clamp(vUv_Y.xy, vUvBounds_Y.xy, vUvBounds_Y.zw), _397).xy).yzx;
            }
            else
            {
                _396 = vec3(0.0);
            }
            _395 = _396;
        }
        _394 = _395;
    }
    oFragColor = vec4(vYuvColorMatrix * ((_394 * vCoefficient) - vec3(0.06274999678134918212890625, 0.501959979534149169921875, 0.501959979534149169921875)), 1.0);
}

