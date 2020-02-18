#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sColor0;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in mediump int vFuncs[4];
flat in mediump ivec4 flat_varying_ivec4_0;
flat in highp vec4 flat_varying_vec4_4;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp mat4 vColorMat;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

void main()
{
    highp vec2 _613 = varying_vec4_0.zw * mix(gl_FragCoord.w, 1.0, flat_varying_vec4_4.y);
    highp vec4 _621 = texture(sColor0, vec3(_613, flat_varying_vec4_4.x));
    highp float _623 = _621.w;
    highp vec3 _1011;
    if (_623 != 0.0)
    {
        _1011 = _621.xyz / vec3(_623);
    }
    else
    {
        _1011 = _621.xyz;
    }
    highp float _1020;
    highp vec3 _1022;
    switch (flat_varying_ivec4_0.x)
    {
        case 0:
        {
            _1022 = ((_1011 * flat_varying_vec4_4.z) - vec3(0.5 * flat_varying_vec4_4.z)) + vec3(0.5);
            _1020 = _623;
            break;
        }
        case 3:
        {
            _1022 = mix(_1011, vec3(1.0) - _1011, vec3(flat_varying_vec4_4.z));
            _1020 = _623;
            break;
        }
        case 6:
        {
            _1022 = clamp(_1011 * flat_varying_vec4_4.z, vec3(0.0), vec3(1.0));
            _1020 = _623;
            break;
        }
        case 8:
        {
            highp vec3 _743 = _1011 * vec3(0.077399380505084991455078125);
            highp vec3 _748 = pow((_1011 * vec3(0.947867333889007568359375)) + vec3(0.0521326996386051177978515625), vec3(2.400000095367431640625));
            bvec3 _752 = lessThanEqual(_1011, vec3(0.040449999272823333740234375));
            _1022 = vec3(_752.x ? _743.x : _748.x, _752.y ? _743.y : _748.y, _752.z ? _743.z : _748.z);
            _1020 = _623;
            break;
        }
        case 9:
        {
            highp vec3 _758 = _1011 * 12.9200000762939453125;
            highp vec3 _762 = (vec3(1.05499994754791259765625) * pow(_1011, vec3(0.4166666567325592041015625))) - vec3(0.054999999701976776123046875);
            bvec3 _766 = lessThanEqual(_1011, vec3(0.003130800090730190277099609375));
            _1022 = vec3(_766.x ? _758.x : _762.x, _766.y ? _758.y : _762.y, _766.z ? _758.z : _762.z);
            _1020 = _623;
            break;
        }
        case 11:
        {
            highp vec4 _598 = vec4(_1011, _623);
            highp vec4 _771;
            mediump int _1023;
            for (mediump int _1013 = 0, _1014 = 0; _1013 < 4; _1014 = _1023, _1013++)
            {
                switch (vFuncs[_1013])
                {
                    case 0:
                    {
                        _1023 = _1014;
                        break;
                    }
                    case 1:
                    case 2:
                    {
                        mediump int _797 = int(floor(_598[_1013] * 255.0));
                        uint _870 = uint((flat_varying_ivec4_0.y + _1014) + (_797 / 4));
                        _771 = texelFetch(sGpuCache, ivec2(int(_870 % 1024u), int(_870 / 1024u)), 0);
                        _598[_1013] = clamp(_771[_797 % 4], 0.0, 1.0);
                        _1023 = _1014 + 64;
                        break;
                    }
                    case 3:
                    {
                        uint _889 = uint(flat_varying_ivec4_0.y + _1014);
                        _771 = texelFetch(sGpuCache, ivec2(int(_889 % 1024u), int(_889 / 1024u)), 0);
                        _598[_1013] = clamp((_771.x * _598[_1013]) + _771.y, 0.0, 1.0);
                        _1023 = _1014 + 1;
                        break;
                    }
                    case 4:
                    {
                        uint _908 = uint(flat_varying_ivec4_0.y + _1014);
                        _771 = texelFetch(sGpuCache, ivec2(int(_908 % 1024u), int(_908 / 1024u)), 0);
                        _598[_1013] = clamp((_771.x * pow(_598[_1013], _771.y)) + _771.z, 0.0, 1.0);
                        _1023 = _1014 + 1;
                        break;
                    }
                    default:
                    {
                        _1023 = _1014;
                        break;
                    }
                }
            }
            _1022 = _598.xyz;
            _1020 = _598.w;
            break;
        }
        case 10:
        {
            _1022 = flat_varying_vec4_1.xyz;
            _1020 = flat_varying_vec4_1.w;
            break;
        }
        default:
        {
            highp vec4 _659 = clamp((vColorMat * vec4(_1011, _623)) + flat_varying_vec4_3, vec4(0.0), vec4(1.0));
            _1022 = _659.xyz;
            _1020 = _659.w;
            break;
        }
    }
    highp vec2 _924 = step(flat_varying_vec4_2.xy, _613) - step(flat_varying_vec4_2.zw, _613);
    highp vec2 _958 = max(vTransformBounds.xy - varying_vec4_0.xy, varying_vec4_0.xy - vTransformBounds.zw);
    highp vec2 _971 = fwidth(varying_vec4_0.xy);
    highp float _1018;
    switch (0u)
    {
        default:
        {
            highp float _983 = (0.5 * (length(max(vec2(0.0), _958)) + min(0.0, max(_958.x, _958.y)))) / (0.3535499870777130126953125 * length(_971));
            if (_983 <= (-0.4999000132083892822265625))
            {
                _1018 = 1.0;
                break;
            }
            if (_983 >= 0.4999000132083892822265625)
            {
                _1018 = 0.0;
                break;
            }
            _1018 = 0.5 + (_983 * (((0.8431026935577392578125 * _983) * _983) - 1.14453601837158203125));
            break;
        }
    }
    oFragColor = vec4(_1022, 1.0) * (_1020 * min(_924.x * _924.y, _1018));
}

