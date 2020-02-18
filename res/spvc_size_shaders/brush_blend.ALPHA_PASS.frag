#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sColor0;

layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in mediump int vFuncs[4];
flat in mediump ivec4 flat_varying_ivec4_0;
flat in highp vec4 flat_varying_vec4_4;
in highp vec4 varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp mat4 vColorMat;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_0;
in highp vec4 varying_vec4_1;
flat in int flat_varying_highp_int_address_0;

void main()
{
    highp vec2 _687 = varying_vec4_0.zw * mix(gl_FragCoord.w, 1.0, flat_varying_vec4_4.y);
    highp vec4 _695 = texture(sColor0, vec3(_687, flat_varying_vec4_4.x));
    highp float _697 = _695.w;
    highp vec3 _1138;
    if (_697 != 0.0)
    {
        _1138 = _695.xyz / vec3(_697);
    }
    else
    {
        _1138 = _695.xyz;
    }
    highp float _1152;
    highp vec3 _1154;
    switch (flat_varying_ivec4_0.x)
    {
        case 0:
        {
            _1154 = ((_1138 * flat_varying_vec4_4.z) - vec3(0.5 * flat_varying_vec4_4.z)) + vec3(0.5);
            _1152 = _697;
            break;
        }
        case 3:
        {
            _1154 = mix(_1138, vec3(1.0) - _1138, vec3(flat_varying_vec4_4.z));
            _1152 = _697;
            break;
        }
        case 6:
        {
            _1154 = clamp(_1138 * flat_varying_vec4_4.z, vec3(0.0), vec3(1.0));
            _1152 = _697;
            break;
        }
        case 8:
        {
            highp vec3 _817 = _1138 * vec3(0.077399380505084991455078125);
            highp vec3 _822 = pow((_1138 * vec3(0.947867333889007568359375)) + vec3(0.0521326996386051177978515625), vec3(2.400000095367431640625));
            bvec3 _826 = lessThanEqual(_1138, vec3(0.040449999272823333740234375));
            _1154 = vec3(_826.x ? _817.x : _822.x, _826.y ? _817.y : _822.y, _826.z ? _817.z : _822.z);
            _1152 = _697;
            break;
        }
        case 9:
        {
            highp vec3 _832 = _1138 * 12.9200000762939453125;
            highp vec3 _836 = (vec3(1.05499994754791259765625) * pow(_1138, vec3(0.4166666567325592041015625))) - vec3(0.054999999701976776123046875);
            bvec3 _840 = lessThanEqual(_1138, vec3(0.003130800090730190277099609375));
            _1154 = vec3(_840.x ? _832.x : _836.x, _840.y ? _832.y : _836.y, _840.z ? _832.z : _836.z);
            _1152 = _697;
            break;
        }
        case 11:
        {
            highp vec4 _672 = vec4(_1138, _697);
            highp vec4 _845;
            mediump int _1157;
            for (mediump int _1140 = 0, _1141 = 0; _1140 < 4; _1141 = _1157, _1140++)
            {
                switch (vFuncs[_1140])
                {
                    case 0:
                    {
                        _1157 = _1141;
                        break;
                    }
                    case 1:
                    case 2:
                    {
                        mediump int _871 = int(floor(_672[_1140] * 255.0));
                        uint _944 = uint((flat_varying_ivec4_0.y + _1141) + (_871 / 4));
                        _845 = texelFetch(sGpuCache, ivec2(int(_944 % 1024u), int(_944 / 1024u)), 0);
                        _672[_1140] = clamp(_845[_871 % 4], 0.0, 1.0);
                        _1157 = _1141 + 64;
                        break;
                    }
                    case 3:
                    {
                        uint _963 = uint(flat_varying_ivec4_0.y + _1141);
                        _845 = texelFetch(sGpuCache, ivec2(int(_963 % 1024u), int(_963 / 1024u)), 0);
                        _672[_1140] = clamp((_845.x * _672[_1140]) + _845.y, 0.0, 1.0);
                        _1157 = _1141 + 1;
                        break;
                    }
                    case 4:
                    {
                        uint _982 = uint(flat_varying_ivec4_0.y + _1141);
                        _845 = texelFetch(sGpuCache, ivec2(int(_982 % 1024u), int(_982 / 1024u)), 0);
                        _672[_1140] = clamp((_845.x * pow(_672[_1140], _845.y)) + _845.z, 0.0, 1.0);
                        _1157 = _1141 + 1;
                        break;
                    }
                    default:
                    {
                        _1157 = _1141;
                        break;
                    }
                }
            }
            _1154 = _672.xyz;
            _1152 = _672.w;
            break;
        }
        case 10:
        {
            _1154 = flat_varying_vec4_1.xyz;
            _1152 = flat_varying_vec4_1.w;
            break;
        }
        default:
        {
            highp vec4 _733 = clamp((vColorMat * vec4(_1138, _697)) + flat_varying_vec4_3, vec4(0.0), vec4(1.0));
            _1154 = _733.xyz;
            _1152 = _733.w;
            break;
        }
    }
    highp vec2 _998 = step(flat_varying_vec4_2.xy, _687) - step(flat_varying_vec4_2.zw, _687);
    highp vec2 _1032 = max(vTransformBounds.xy - varying_vec4_0.xy, varying_vec4_0.xy - vTransformBounds.zw);
    highp vec2 _1045 = fwidth(varying_vec4_0.xy);
    highp float _1150;
    switch (0u)
    {
        default:
        {
            highp float _1057 = (0.5 * (length(max(vec2(0.0), _1032)) + min(0.0, max(_1032.x, _1032.y)))) / (0.3535499870777130126953125 * length(_1045));
            if (_1057 <= (-0.4999000132083892822265625))
            {
                _1150 = 1.0;
                break;
            }
            if (_1057 >= 0.4999000132083892822265625)
            {
                _1150 = 0.0;
                break;
            }
            _1150 = 0.5 + (_1057 * (((0.8431026935577392578125 * _1057) * _1057) - 1.14453601837158203125));
            break;
        }
    }
    highp float _1155;
    switch (0u)
    {
        default:
        {
            if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
            {
                _1155 = 1.0;
                break;
            }
            highp vec2 _1096 = vClipMaskUv.xy * gl_FragCoord.w;
            if (!all(bvec4(lessThanEqual(vClipMaskUvBounds.xy, _1096), greaterThan(vClipMaskUvBounds.zw, _1096))))
            {
                _1155 = 0.0;
                break;
            }
            _1155 = texelFetch(sPrevPassAlpha, ivec3(ivec2(_1096), int(vClipMaskUv.z + 0.5)), 0).x;
            break;
        }
    }
    oFragColor = (vec4(_1154, 1.0) * (_1152 * min(_998.x * _998.y, _1150))) * _1155;
}

