#version 300 es
precision mediump float;
precision highp int;

flat in highp vec4 vPartialWidths;
flat in highp vec4 vEdgeReference;
in highp vec2 vPos;
flat in mediump ivec4 vConfig;
flat in highp vec4 vColorLine;
flat in highp vec4 vClipCenter_Sign;
flat in highp vec4 vClipParams1;
flat in highp vec4 vClipParams2;
flat in highp vec4 vClipRadii;
flat in highp vec4 vColor00;
flat in highp vec4 vColor01;
flat in highp vec4 vColor10;
flat in highp vec4 vColor11;
layout(location = 0) out highp vec4 oFragColor;

void main()
{
    highp vec2 _647 = fwidth(vPos);
    highp float _648 = length(_647);
    highp float _649 = 0.3535499870777130126953125 * _648;
    mediump int _365 = vConfig.y & 65535;
    mediump int _369 = vConfig.y >> 16;
    mediump int _375 = vConfig.z & 65535;
    mediump int _378 = vConfig.z >> 16;
    highp float _1685;
    if (_375 != _378)
    {
        highp float _1605;
        switch (0u)
        {
            default:
            {
                highp float _668 = (dot(normalize(vColorLine.zw), vColorLine.xy - vPos) * (-0.5)) / _649;
                if (_668 <= (-0.4999000132083892822265625))
                {
                    _1605 = 1.0;
                    break;
                }
                if (_668 >= 0.4999000132083892822265625)
                {
                    _1605 = 0.0;
                    break;
                }
                _1605 = 0.5 + (_668 * (((0.8431026935577392578125 * _668) * _668) - 1.14453601837158203125));
                break;
            }
        }
        _1685 = _1605;
    }
    else
    {
        _1685 = 0.0;
    }
    highp vec2 _414 = vPos - vClipCenter_Sign.xy;
    highp float _1674;
    switch (vConfig.w)
    {
        case 3:
        {
            _1674 = distance(vClipParams1.xy, vPos) - vClipParams1.z;
            break;
        }
        case 2:
        {
            bool _443 = vClipParams1.x == 0.0;
            highp float _1608;
            if (_443)
            {
                _1608 = vClipParams1.y;
            }
            else
            {
                _1608 = vClipParams1.x;
            }
            highp float _1610;
            if (_443)
            {
                _1610 = vPos.y;
            }
            else
            {
                _1610 = vPos.x;
            }
            bool _469 = _1610 < _1608;
            bool _478;
            if (!_469)
            {
                _478 = _1610 > (3.0 * _1608);
            }
            else
            {
                _478 = _469;
            }
            _1674 = (!_478) ? 1.0 : (-1.0);
            break;
        }
        case 1:
        {
            _1674 = max(dot(normalize(vClipParams1.zw), vClipParams1.xy - vPos), -dot(normalize(vClipParams2.zw), vClipParams2.xy - vPos));
            break;
        }
        default:
        {
            _1674 = -1.0;
            break;
        }
    }
    highp float _1821;
    highp vec4 _1850;
    highp vec4 _1865;
    if (all(lessThan(vClipCenter_Sign.zw * _414, vec2(0.0))))
    {
        highp float _1665;
        if (any(lessThanEqual(vClipRadii.xy, vec2(0.0))))
        {
            _1665 = length(_414);
        }
        else
        {
            highp vec2 _721 = vec2(1.0) / (vClipRadii.xy * vClipRadii.xy);
            highp vec2 _732 = (_414 * 2.0) * _721;
            _1665 = (dot((_414 * _414) * _721, vec2(1.0)) - 1.0) * inversesqrt(dot(_732, _732));
        }
        highp float _741 = _648 * (-0.3535499870777130126953125);
        highp float _1669;
        if (any(lessThanEqual(vClipRadii.zw, vec2(0.0))))
        {
            _1669 = length(_414);
        }
        else
        {
            highp vec2 _761 = vec2(1.0) / (vClipRadii.zw * vClipRadii.zw);
            highp vec2 _772 = (_414 * 2.0) * _761;
            _1669 = (dot((_414 * _414) * _761, vec2(1.0)) - 1.0) * inversesqrt(dot(_772, _772));
        }
        highp vec4 _1737;
        switch (_365)
        {
            case 2:
            {
                highp vec2 _815 = vClipRadii.xy - vPartialWidths.xy;
                highp float _1724;
                if (any(lessThanEqual(_815, vec2(0.0))))
                {
                    _1724 = length(_414);
                }
                else
                {
                    highp vec2 _891 = vec2(1.0) / (_815 * _815);
                    highp vec2 _902 = (_414 * 2.0) * _891;
                    _1724 = (dot((_414 * _414) * _891, vec2(1.0)) - 1.0) * inversesqrt(dot(_902, _902));
                }
                highp vec2 _824 = vClipRadii.xy - (vPartialWidths.xy * 2.0);
                highp float _1729;
                if (any(lessThanEqual(_824, vec2(0.0))))
                {
                    _1729 = length(_414);
                }
                else
                {
                    highp vec2 _931 = vec2(1.0) / (_824 * _824);
                    highp vec2 _942 = (_414 * 2.0) * _931;
                    _1729 = (dot((_414 * _414) * _931, vec2(1.0)) - 1.0) * inversesqrt(dot(_942, _942));
                }
                highp float _1733;
                switch (0u)
                {
                    default:
                    {
                        highp float _963 = (0.5 * min(-clamp(_1724, _741, _649), clamp(_1729, _741, _649))) / _649;
                        if (_963 <= (-0.4999000132083892822265625))
                        {
                            _1733 = 1.0;
                            break;
                        }
                        if (_963 >= 0.4999000132083892822265625)
                        {
                            _1733 = 0.0;
                            break;
                        }
                        _1733 = 0.5 + (_963 * (((0.8431026935577392578125 * _963) * _963) - 1.14453601837158203125));
                        break;
                    }
                }
                _1737 = vColor00 * _1733;
                break;
            }
            case 6:
            case 7:
            {
                highp vec2 _841 = vClipRadii.xy - vPartialWidths.zw;
                highp float _1704;
                if (any(lessThanEqual(_841, vec2(0.0))))
                {
                    _1704 = length(_414);
                }
                else
                {
                    highp vec2 _998 = vec2(1.0) / (_841 * _841);
                    highp vec2 _1009 = (_414 * 2.0) * _998;
                    _1704 = (dot((_414 * _414) * _998, vec2(1.0)) - 1.0) * inversesqrt(dot(_1009, _1009));
                }
                highp float _1707;
                switch (0u)
                {
                    default:
                    {
                        highp float _1030 = (0.5 * clamp(_1704, _741, _649)) / _649;
                        if (_1030 <= (-0.4999000132083892822265625))
                        {
                            _1707 = 1.0;
                            break;
                        }
                        if (_1030 >= 0.4999000132083892822265625)
                        {
                            _1707 = 0.0;
                            break;
                        }
                        _1707 = 0.5 + (_1030 * (((0.8431026935577392578125 * _1030) * _1030) - 1.14453601837158203125));
                        break;
                    }
                }
                highp float _1722;
                switch (vConfig.x)
                {
                    case 0:
                    {
                        _1722 = 0.0;
                        break;
                    }
                    case 1:
                    {
                        _1722 = _1685;
                        break;
                    }
                    case 2:
                    {
                        _1722 = 1.0;
                        break;
                    }
                    case 3:
                    {
                        _1722 = 1.0 - _1685;
                        break;
                    }
                    default:
                    {
                        _1722 = 0.0;
                        break;
                    }
                }
                highp vec4 _861 = vec4(_1722);
                _1737 = mix(mix(vColor01, vColor00, _861), mix(vColor00, vColor01, _861), vec4(_1707));
                break;
            }
            default:
            {
                _1737 = vColor00;
                break;
            }
        }
        highp vec4 _1806;
        switch (_369)
        {
            case 2:
            {
                highp vec2 _1079 = vClipRadii.xy - vPartialWidths.xy;
                highp float _1793;
                if (any(lessThanEqual(_1079, vec2(0.0))))
                {
                    _1793 = length(_414);
                }
                else
                {
                    highp vec2 _1155 = vec2(1.0) / (_1079 * _1079);
                    highp vec2 _1166 = (_414 * 2.0) * _1155;
                    _1793 = (dot((_414 * _414) * _1155, vec2(1.0)) - 1.0) * inversesqrt(dot(_1166, _1166));
                }
                highp vec2 _1088 = vClipRadii.xy - (vPartialWidths.xy * 2.0);
                highp float _1798;
                if (any(lessThanEqual(_1088, vec2(0.0))))
                {
                    _1798 = length(_414);
                }
                else
                {
                    highp vec2 _1195 = vec2(1.0) / (_1088 * _1088);
                    highp vec2 _1206 = (_414 * 2.0) * _1195;
                    _1798 = (dot((_414 * _414) * _1195, vec2(1.0)) - 1.0) * inversesqrt(dot(_1206, _1206));
                }
                highp float _1802;
                switch (0u)
                {
                    default:
                    {
                        highp float _1227 = (0.5 * min(-clamp(_1793, _741, _649), clamp(_1798, _741, _649))) / _649;
                        if (_1227 <= (-0.4999000132083892822265625))
                        {
                            _1802 = 1.0;
                            break;
                        }
                        if (_1227 >= 0.4999000132083892822265625)
                        {
                            _1802 = 0.0;
                            break;
                        }
                        _1802 = 0.5 + (_1227 * (((0.8431026935577392578125 * _1227) * _1227) - 1.14453601837158203125));
                        break;
                    }
                }
                _1806 = vColor10 * _1802;
                break;
            }
            case 6:
            case 7:
            {
                highp vec2 _1105 = vClipRadii.xy - vPartialWidths.zw;
                highp float _1773;
                if (any(lessThanEqual(_1105, vec2(0.0))))
                {
                    _1773 = length(_414);
                }
                else
                {
                    highp vec2 _1262 = vec2(1.0) / (_1105 * _1105);
                    highp vec2 _1273 = (_414 * 2.0) * _1262;
                    _1773 = (dot((_414 * _414) * _1262, vec2(1.0)) - 1.0) * inversesqrt(dot(_1273, _1273));
                }
                highp float _1776;
                switch (0u)
                {
                    default:
                    {
                        highp float _1294 = (0.5 * clamp(_1773, _741, _649)) / _649;
                        if (_1294 <= (-0.4999000132083892822265625))
                        {
                            _1776 = 1.0;
                            break;
                        }
                        if (_1294 >= 0.4999000132083892822265625)
                        {
                            _1776 = 0.0;
                            break;
                        }
                        _1776 = 0.5 + (_1294 * (((0.8431026935577392578125 * _1294) * _1294) - 1.14453601837158203125));
                        break;
                    }
                }
                highp float _1791;
                switch (vConfig.x)
                {
                    case 0:
                    {
                        _1791 = 0.0;
                        break;
                    }
                    case 1:
                    {
                        _1791 = _1685;
                        break;
                    }
                    case 2:
                    {
                        _1791 = 1.0;
                        break;
                    }
                    case 3:
                    {
                        _1791 = 1.0 - _1685;
                        break;
                    }
                    default:
                    {
                        _1791 = 0.0;
                        break;
                    }
                }
                highp vec4 _1125 = vec4(_1791);
                _1806 = mix(mix(vColor11, vColor10, _1125), mix(vColor10, vColor11, _1125), vec4(_1776));
                break;
            }
            default:
            {
                _1806 = vColor10;
                break;
            }
        }
        _1865 = _1806;
        _1850 = _1737;
        _1821 = max(_1674, max(clamp(_1665, _741, _649), -clamp(_1669, _741, _649)));
    }
    else
    {
        bvec2 _1327 = bvec2(_375 != 0);
        highp vec2 _1328 = vec2(_1327.x ? vec2(0.0, 1.0).x : vec2(1.0, 0.0).x, _1327.y ? vec2(0.0, 1.0).y : vec2(1.0, 0.0).y);
        highp float _1331 = dot(vPos, _1328);
        highp vec4 _1639;
        switch (_365)
        {
            case 2:
            {
                highp float _1340 = dot(vPartialWidths.xy, _1328);
                highp float _1635;
                if (_1340 >= 1.0)
                {
                    _1635 = min(_1331 - (dot(vEdgeReference.xy, _1328) + _1340), (dot(vEdgeReference.zw, _1328) - _1340) - _1331);
                }
                else
                {
                    _1635 = -1.0;
                }
                highp float _1636;
                switch (0u)
                {
                    default:
                    {
                        highp float _1400 = (0.5 * _1635) / _649;
                        if (_1400 <= (-0.4999000132083892822265625))
                        {
                            _1636 = 1.0;
                            break;
                        }
                        if (_1400 >= 0.4999000132083892822265625)
                        {
                            _1636 = 0.0;
                            break;
                        }
                        _1636 = 0.5 + (_1400 * (((0.8431026935577392578125 * _1400) * _1400) - 1.14453601837158203125));
                        break;
                    }
                }
                _1639 = vColor00 * _1636;
                break;
            }
            case 6:
            case 7:
            {
                highp float _1629;
                switch (0u)
                {
                    default:
                    {
                        highp float _1427 = (0.5 * (_1331 - dot(vEdgeReference.xy + vPartialWidths.zw, _1328))) / _649;
                        if (_1427 <= (-0.4999000132083892822265625))
                        {
                            _1629 = 1.0;
                            break;
                        }
                        if (_1427 >= 0.4999000132083892822265625)
                        {
                            _1629 = 0.0;
                            break;
                        }
                        _1629 = 0.5 + (_1427 * (((0.8431026935577392578125 * _1427) * _1427) - 1.14453601837158203125));
                        break;
                    }
                }
                _1639 = mix(vColor00, vColor01, vec4(_1629));
                break;
            }
            default:
            {
                _1639 = vColor00;
                break;
            }
        }
        bvec2 _1460 = bvec2(_378 != 0);
        highp vec2 _1461 = vec2(_1460.x ? vec2(0.0, 1.0).x : vec2(1.0, 0.0).x, _1460.y ? vec2(0.0, 1.0).y : vec2(1.0, 0.0).y);
        highp float _1464 = dot(vPos, _1461);
        highp vec4 _1658;
        switch (_369)
        {
            case 2:
            {
                highp float _1473 = dot(vPartialWidths.xy, _1461);
                highp float _1654;
                if (_1473 >= 1.0)
                {
                    _1654 = min(_1464 - (dot(vEdgeReference.xy, _1461) + _1473), (dot(vEdgeReference.zw, _1461) - _1473) - _1464);
                }
                else
                {
                    _1654 = -1.0;
                }
                highp float _1655;
                switch (0u)
                {
                    default:
                    {
                        highp float _1533 = (0.5 * _1654) / _649;
                        if (_1533 <= (-0.4999000132083892822265625))
                        {
                            _1655 = 1.0;
                            break;
                        }
                        if (_1533 >= 0.4999000132083892822265625)
                        {
                            _1655 = 0.0;
                            break;
                        }
                        _1655 = 0.5 + (_1533 * (((0.8431026935577392578125 * _1533) * _1533) - 1.14453601837158203125));
                        break;
                    }
                }
                _1658 = vColor10 * _1655;
                break;
            }
            case 6:
            case 7:
            {
                highp float _1648;
                switch (0u)
                {
                    default:
                    {
                        highp float _1560 = (0.5 * (_1464 - dot(vEdgeReference.xy + vPartialWidths.zw, _1461))) / _649;
                        if (_1560 <= (-0.4999000132083892822265625))
                        {
                            _1648 = 1.0;
                            break;
                        }
                        if (_1560 >= 0.4999000132083892822265625)
                        {
                            _1648 = 0.0;
                            break;
                        }
                        _1648 = 0.5 + (_1560 * (((0.8431026935577392578125 * _1560) * _1560) - 1.14453601837158203125));
                        break;
                    }
                }
                _1658 = mix(vColor10, vColor11, vec4(_1648));
                break;
            }
            default:
            {
                _1658 = vColor10;
                break;
            }
        }
        _1865 = _1658;
        _1850 = _1639;
        _1821 = _1674;
    }
    highp float _1848;
    switch (0u)
    {
        default:
        {
            highp float _1587 = (0.5 * _1821) / _649;
            if (_1587 <= (-0.4999000132083892822265625))
            {
                _1848 = 1.0;
                break;
            }
            if (_1587 >= 0.4999000132083892822265625)
            {
                _1848 = 0.0;
                break;
            }
            _1848 = 0.5 + (_1587 * (((0.8431026935577392578125 * _1587) * _1587) - 1.14453601837158203125));
            break;
        }
    }
    oFragColor = mix(_1850, _1865, vec4(_1685)) * _1848;
}

