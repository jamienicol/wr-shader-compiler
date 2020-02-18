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
    highp float _1650;
    if (_375 != _378)
    {
        highp float _1617;
        switch (0u)
        {
            default:
            {
                highp float _668 = (dot(normalize(vColorLine.zw), vColorLine.xy - vPos) * (-0.5)) / _649;
                if (_668 <= (-0.4999000132083892822265625))
                {
                    _1617 = 1.0;
                    break;
                }
                if (_668 >= 0.4999000132083892822265625)
                {
                    _1617 = 0.0;
                    break;
                }
                _1617 = 0.5 + (_668 * (((0.8431026935577392578125 * _668) * _668) - 1.14453601837158203125));
                break;
            }
        }
        _1650 = _1617;
    }
    else
    {
        _1650 = 0.0;
    }
    highp vec2 _414 = vPos - vClipCenter_Sign.xy;
    highp float _1640;
    switch (vConfig.w)
    {
        case 3:
        {
            _1640 = distance(vClipParams1.xy, vPos) - vClipParams1.z;
            break;
        }
        case 2:
        {
            bool _443 = vClipParams1.x == 0.0;
            highp float _1618;
            if (_443)
            {
                _1618 = vClipParams1.y;
            }
            else
            {
                _1618 = vClipParams1.x;
            }
            highp float _1619;
            if (_443)
            {
                _1619 = vPos.y;
            }
            else
            {
                _1619 = vPos.x;
            }
            bool _469 = _1619 < _1618;
            bool _478;
            if (!_469)
            {
                _478 = _1619 > (3.0 * _1618);
            }
            else
            {
                _478 = _469;
            }
            _1640 = (!_478) ? 1.0 : (-1.0);
            break;
        }
        case 1:
        {
            _1640 = max(dot(normalize(vClipParams1.zw), vClipParams1.xy - vPos), -dot(normalize(vClipParams2.zw), vClipParams2.xy - vPos));
            break;
        }
        default:
        {
            _1640 = -1.0;
            break;
        }
    }
    highp float _1691;
    highp vec4 _1720;
    highp vec4 _1735;
    if (all(lessThan(vClipCenter_Sign.zw * _414, vec2(0.0))))
    {
        highp float _1636;
        if (any(lessThanEqual(vClipRadii.xy, vec2(0.0))))
        {
            _1636 = length(_414);
        }
        else
        {
            highp vec2 _721 = vec2(1.0) / (vClipRadii.xy * vClipRadii.xy);
            highp vec2 _732 = (_414 * 2.0) * _721;
            _1636 = (dot((_414 * _414) * _721, vec2(1.0)) - 1.0) * inversesqrt(dot(_732, _732));
        }
        highp float _741 = _648 * (-0.3535499870777130126953125);
        highp float _1637;
        if (any(lessThanEqual(vClipRadii.zw, vec2(0.0))))
        {
            _1637 = length(_414);
        }
        else
        {
            highp vec2 _761 = vec2(1.0) / (vClipRadii.zw * vClipRadii.zw);
            highp vec2 _772 = (_414 * 2.0) * _761;
            _1637 = (dot((_414 * _414) * _761, vec2(1.0)) - 1.0) * inversesqrt(dot(_772, _772));
        }
        highp vec4 _1668;
        switch (_365)
        {
            case 2:
            {
                highp vec2 _815 = vClipRadii.xy - vPartialWidths.xy;
                highp float _1662;
                if (any(lessThanEqual(_815, vec2(0.0))))
                {
                    _1662 = length(_414);
                }
                else
                {
                    highp vec2 _891 = vec2(1.0) / (_815 * _815);
                    highp vec2 _902 = (_414 * 2.0) * _891;
                    _1662 = (dot((_414 * _414) * _891, vec2(1.0)) - 1.0) * inversesqrt(dot(_902, _902));
                }
                highp vec2 _824 = vClipRadii.xy - (vPartialWidths.xy * 2.0);
                highp float _1663;
                if (any(lessThanEqual(_824, vec2(0.0))))
                {
                    _1663 = length(_414);
                }
                else
                {
                    highp vec2 _931 = vec2(1.0) / (_824 * _824);
                    highp vec2 _942 = (_414 * 2.0) * _931;
                    _1663 = (dot((_414 * _414) * _931, vec2(1.0)) - 1.0) * inversesqrt(dot(_942, _942));
                }
                highp float _1664;
                switch (0u)
                {
                    default:
                    {
                        highp float _963 = (0.5 * min(-clamp(_1662, _741, _649), clamp(_1663, _741, _649))) / _649;
                        if (_963 <= (-0.4999000132083892822265625))
                        {
                            _1664 = 1.0;
                            break;
                        }
                        if (_963 >= 0.4999000132083892822265625)
                        {
                            _1664 = 0.0;
                            break;
                        }
                        _1664 = 0.5 + (_963 * (((0.8431026935577392578125 * _963) * _963) - 1.14453601837158203125));
                        break;
                    }
                }
                _1668 = vColor00 * _1664;
                break;
            }
            case 6:
            case 7:
            {
                highp vec2 _841 = vClipRadii.xy - vPartialWidths.zw;
                highp float _1655;
                if (any(lessThanEqual(_841, vec2(0.0))))
                {
                    _1655 = length(_414);
                }
                else
                {
                    highp vec2 _998 = vec2(1.0) / (_841 * _841);
                    highp vec2 _1009 = (_414 * 2.0) * _998;
                    _1655 = (dot((_414 * _414) * _998, vec2(1.0)) - 1.0) * inversesqrt(dot(_1009, _1009));
                }
                highp float _1656;
                switch (0u)
                {
                    default:
                    {
                        highp float _1030 = (0.5 * clamp(_1655, _741, _649)) / _649;
                        if (_1030 <= (-0.4999000132083892822265625))
                        {
                            _1656 = 1.0;
                            break;
                        }
                        if (_1030 >= 0.4999000132083892822265625)
                        {
                            _1656 = 0.0;
                            break;
                        }
                        _1656 = 0.5 + (_1030 * (((0.8431026935577392578125 * _1030) * _1030) - 1.14453601837158203125));
                        break;
                    }
                }
                highp float _1661;
                switch (vConfig.x)
                {
                    case 0:
                    {
                        _1661 = 0.0;
                        break;
                    }
                    case 1:
                    {
                        _1661 = _1650;
                        break;
                    }
                    case 2:
                    {
                        _1661 = 1.0;
                        break;
                    }
                    case 3:
                    {
                        _1661 = 1.0 - _1650;
                        break;
                    }
                    default:
                    {
                        _1661 = 0.0;
                        break;
                    }
                }
                highp vec4 _861 = vec4(_1661);
                _1668 = mix(mix(vColor01, vColor00, _861), mix(vColor00, vColor01, _861), vec4(_1656));
                break;
            }
            default:
            {
                _1668 = vColor00;
                break;
            }
        }
        highp vec4 _1690;
        switch (_369)
        {
            case 2:
            {
                highp vec2 _1079 = vClipRadii.xy - vPartialWidths.xy;
                highp float _1684;
                if (any(lessThanEqual(_1079, vec2(0.0))))
                {
                    _1684 = length(_414);
                }
                else
                {
                    highp vec2 _1155 = vec2(1.0) / (_1079 * _1079);
                    highp vec2 _1166 = (_414 * 2.0) * _1155;
                    _1684 = (dot((_414 * _414) * _1155, vec2(1.0)) - 1.0) * inversesqrt(dot(_1166, _1166));
                }
                highp vec2 _1088 = vClipRadii.xy - (vPartialWidths.xy * 2.0);
                highp float _1685;
                if (any(lessThanEqual(_1088, vec2(0.0))))
                {
                    _1685 = length(_414);
                }
                else
                {
                    highp vec2 _1195 = vec2(1.0) / (_1088 * _1088);
                    highp vec2 _1206 = (_414 * 2.0) * _1195;
                    _1685 = (dot((_414 * _414) * _1195, vec2(1.0)) - 1.0) * inversesqrt(dot(_1206, _1206));
                }
                highp float _1686;
                switch (0u)
                {
                    default:
                    {
                        highp float _1227 = (0.5 * min(-clamp(_1684, _741, _649), clamp(_1685, _741, _649))) / _649;
                        if (_1227 <= (-0.4999000132083892822265625))
                        {
                            _1686 = 1.0;
                            break;
                        }
                        if (_1227 >= 0.4999000132083892822265625)
                        {
                            _1686 = 0.0;
                            break;
                        }
                        _1686 = 0.5 + (_1227 * (((0.8431026935577392578125 * _1227) * _1227) - 1.14453601837158203125));
                        break;
                    }
                }
                _1690 = vColor10 * _1686;
                break;
            }
            case 6:
            case 7:
            {
                highp vec2 _1105 = vClipRadii.xy - vPartialWidths.zw;
                highp float _1677;
                if (any(lessThanEqual(_1105, vec2(0.0))))
                {
                    _1677 = length(_414);
                }
                else
                {
                    highp vec2 _1262 = vec2(1.0) / (_1105 * _1105);
                    highp vec2 _1273 = (_414 * 2.0) * _1262;
                    _1677 = (dot((_414 * _414) * _1262, vec2(1.0)) - 1.0) * inversesqrt(dot(_1273, _1273));
                }
                highp float _1678;
                switch (0u)
                {
                    default:
                    {
                        highp float _1294 = (0.5 * clamp(_1677, _741, _649)) / _649;
                        if (_1294 <= (-0.4999000132083892822265625))
                        {
                            _1678 = 1.0;
                            break;
                        }
                        if (_1294 >= 0.4999000132083892822265625)
                        {
                            _1678 = 0.0;
                            break;
                        }
                        _1678 = 0.5 + (_1294 * (((0.8431026935577392578125 * _1294) * _1294) - 1.14453601837158203125));
                        break;
                    }
                }
                highp float _1683;
                switch (vConfig.x)
                {
                    case 0:
                    {
                        _1683 = 0.0;
                        break;
                    }
                    case 1:
                    {
                        _1683 = _1650;
                        break;
                    }
                    case 2:
                    {
                        _1683 = 1.0;
                        break;
                    }
                    case 3:
                    {
                        _1683 = 1.0 - _1650;
                        break;
                    }
                    default:
                    {
                        _1683 = 0.0;
                        break;
                    }
                }
                highp vec4 _1125 = vec4(_1683);
                _1690 = mix(mix(vColor11, vColor10, _1125), mix(vColor10, vColor11, _1125), vec4(_1678));
                break;
            }
            default:
            {
                _1690 = vColor10;
                break;
            }
        }
        _1735 = _1690;
        _1720 = _1668;
        _1691 = max(_1640, max(clamp(_1636, _741, _649), -clamp(_1637, _741, _649)));
    }
    else
    {
        bvec2 _1327 = bvec2(_375 != 0);
        highp vec2 _1328 = vec2(_1327.x ? vec2(0.0, 1.0).x : vec2(1.0, 0.0).x, _1327.y ? vec2(0.0, 1.0).y : vec2(1.0, 0.0).y);
        highp float _1331 = dot(vPos, _1328);
        highp vec4 _1627;
        switch (_365)
        {
            case 2:
            {
                highp float _1340 = dot(vPartialWidths.xy, _1328);
                highp float _1623;
                if (_1340 >= 1.0)
                {
                    _1623 = min(_1331 - (dot(vEdgeReference.xy, _1328) + _1340), (dot(vEdgeReference.zw, _1328) - _1340) - _1331);
                }
                else
                {
                    _1623 = -1.0;
                }
                highp float _1624;
                switch (0u)
                {
                    default:
                    {
                        highp float _1400 = (0.5 * _1623) / _649;
                        if (_1400 <= (-0.4999000132083892822265625))
                        {
                            _1624 = 1.0;
                            break;
                        }
                        if (_1400 >= 0.4999000132083892822265625)
                        {
                            _1624 = 0.0;
                            break;
                        }
                        _1624 = 0.5 + (_1400 * (((0.8431026935577392578125 * _1400) * _1400) - 1.14453601837158203125));
                        break;
                    }
                }
                _1627 = vColor00 * _1624;
                break;
            }
            case 6:
            case 7:
            {
                highp float _1620;
                switch (0u)
                {
                    default:
                    {
                        highp float _1427 = (0.5 * (_1331 - dot(vEdgeReference.xy + vPartialWidths.zw, _1328))) / _649;
                        if (_1427 <= (-0.4999000132083892822265625))
                        {
                            _1620 = 1.0;
                            break;
                        }
                        if (_1427 >= 0.4999000132083892822265625)
                        {
                            _1620 = 0.0;
                            break;
                        }
                        _1620 = 0.5 + (_1427 * (((0.8431026935577392578125 * _1427) * _1427) - 1.14453601837158203125));
                        break;
                    }
                }
                _1627 = mix(vColor00, vColor01, vec4(_1620));
                break;
            }
            default:
            {
                _1627 = vColor00;
                break;
            }
        }
        bvec2 _1460 = bvec2(_378 != 0);
        highp vec2 _1461 = vec2(_1460.x ? vec2(0.0, 1.0).x : vec2(1.0, 0.0).x, _1460.y ? vec2(0.0, 1.0).y : vec2(1.0, 0.0).y);
        highp float _1464 = dot(vPos, _1461);
        highp vec4 _1635;
        switch (_369)
        {
            case 2:
            {
                highp float _1473 = dot(vPartialWidths.xy, _1461);
                highp float _1631;
                if (_1473 >= 1.0)
                {
                    _1631 = min(_1464 - (dot(vEdgeReference.xy, _1461) + _1473), (dot(vEdgeReference.zw, _1461) - _1473) - _1464);
                }
                else
                {
                    _1631 = -1.0;
                }
                highp float _1632;
                switch (0u)
                {
                    default:
                    {
                        highp float _1533 = (0.5 * _1631) / _649;
                        if (_1533 <= (-0.4999000132083892822265625))
                        {
                            _1632 = 1.0;
                            break;
                        }
                        if (_1533 >= 0.4999000132083892822265625)
                        {
                            _1632 = 0.0;
                            break;
                        }
                        _1632 = 0.5 + (_1533 * (((0.8431026935577392578125 * _1533) * _1533) - 1.14453601837158203125));
                        break;
                    }
                }
                _1635 = vColor10 * _1632;
                break;
            }
            case 6:
            case 7:
            {
                highp float _1628;
                switch (0u)
                {
                    default:
                    {
                        highp float _1560 = (0.5 * (_1464 - dot(vEdgeReference.xy + vPartialWidths.zw, _1461))) / _649;
                        if (_1560 <= (-0.4999000132083892822265625))
                        {
                            _1628 = 1.0;
                            break;
                        }
                        if (_1560 >= 0.4999000132083892822265625)
                        {
                            _1628 = 0.0;
                            break;
                        }
                        _1628 = 0.5 + (_1560 * (((0.8431026935577392578125 * _1560) * _1560) - 1.14453601837158203125));
                        break;
                    }
                }
                _1635 = mix(vColor10, vColor11, vec4(_1628));
                break;
            }
            default:
            {
                _1635 = vColor10;
                break;
            }
        }
        _1735 = _1635;
        _1720 = _1627;
        _1691 = _1640;
    }
    highp float _1718;
    switch (0u)
    {
        default:
        {
            highp float _1587 = (0.5 * _1691) / _649;
            if (_1587 <= (-0.4999000132083892822265625))
            {
                _1718 = 1.0;
                break;
            }
            if (_1587 >= 0.4999000132083892822265625)
            {
                _1718 = 0.0;
                break;
            }
            _1718 = 0.5 + (_1587 * (((0.8431026935577392578125 * _1587) * _1587) - 1.14453601837158203125));
            break;
        }
    }
    oFragColor = mix(_1720, _1735, vec4(_1650)) * _1718;
}

