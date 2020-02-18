#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform mat4 uTransform;
uniform highp sampler2DArray sColor0;

flat out vec4 vTransformBounds;
layout(location = 1) in ivec4 aData;
layout(location = 0) in vec3 aPosition;
out vec4 varying_vec4_0;
flat out vec4 flat_varying_vec4_4;
flat out vec4 flat_varying_vec4_2;
flat out ivec4 flat_varying_ivec4_0;
flat out int vFuncs[4];
flat out mat4 vColorMat;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_1;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
flat out vec4 flat_varying_vec4_0;
out vec4 varying_vec4_1;
flat out int flat_varying_highp_int_address_0;

mat4 _3668;

void main()
{
    int _1528 = aData.z & 65535;
    int _1532 = aData.z >> 16;
    uint _1552 = uint(aData.x);
    ivec2 _1560 = ivec2(int(2u * (_1552 % 512u)), int(_1552 / 512u));
    vec4 _1565 = texelFetch(sPrimitiveHeadersF, _1560, 0);
    ivec2 _1568 = _1560 + ivec2(1, 0);
    vec4 _1570 = texelFetch(sPrimitiveHeadersF, _1568, 0);
    vec2 _1572 = _1565.xy;
    vec2 _1574 = _1565.zw;
    vec2 _1578 = _1570.xy;
    vec2 _1580 = _1570.zw;
    ivec4 _1597 = texelFetch(sPrimitiveHeadersI, _1560, 0);
    ivec4 _1602 = texelFetch(sPrimitiveHeadersI, _1568, 0);
    float _1605 = float(_1597.x);
    int _1611 = _1597.z;
    vec2 _3578;
    vec2 _3580;
    if (_1528 == 65535)
    {
        _3580 = _1572;
        _3578 = _1574;
    }
    else
    {
        uint _1634 = uint((_1597.y + 3) + (_1528 * 2));
        vec4 _1625 = texelFetch(sGpuCache, ivec2(int(_1634 % 1024u), int(_1634 / 1024u)), 0);
        _3580 = _1625.xy + _1572;
        _3578 = _1625.zw;
    }
    uint _1665 = uint(aData.y >> 16);
    ivec2 _1673 = ivec2(int(2u * (_1665 % 512u)), int(_1665 / 512u));
    vec4 _1683 = texelFetch(sRenderTasks, _1673 + ivec2(1, 0), 0);
    vec2 _1685 = texelFetch(sRenderTasks, _1673, 0).xy;
    float _1651 = _1683.y;
    vec2 _1654 = _1683.zw;
    uint _1779 = uint(_1611 & 16777215);
    ivec2 _1793 = ivec2(int(8u * (_1779 % 128u)), int(_1779 / 128u));
    mat4 _3636 = _3668;
    _3636[0] = texelFetch(sTransformPalette, _1793, 0);
    mat4 _3638 = _3636;
    _3638[1] = texelFetch(sTransformPalette, _1793 + ivec2(1, 0), 0);
    mat4 _3640 = _3638;
    _3640[2] = texelFetch(sTransformPalette, _1793 + ivec2(2, 0), 0);
    mat4 _3642 = _3640;
    _3642[3] = texelFetch(sTransformPalette, _1793 + ivec2(3, 0), 0);
    vec4 _3596;
    vec2 _3597;
    if ((_1611 >> 24) == 0)
    {
        vec2 _1912 = clamp(_3580 + (_3578 * aPosition.xy), _1578, _1578 + _1580);
        vec4 _1869 = _3642 * vec4(_1912, 0.0, 1.0);
        float _1885 = _1869.w;
        gl_Position = uTransform * vec4((_1869.xy * _1651) + (((-_1654) + _1685) * _1885), _1605 * _1885, _1885);
        _3597 = _1912;
        _3596 = _1869;
    }
    else
    {
        bvec4 _940 = notEqual((ivec4(_1532 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _943 = vec4(_940.x ? vec4(1.0).x : vec4(0.0).x, _940.y ? vec4(1.0).y : vec4(0.0).y, _940.z ? vec4(1.0).z : vec4(0.0).z, _940.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _2062 = _1578 + _1580;
        vec4 _1969 = vec4(2.0) * _943;
        vec2 _1971 = _1969.xy;
        vec2 _1992 = (_3580 - _1971) + ((_3578 + (_1971 + _1969.zw)) * aPosition.xy);
        vec4 _2004 = _3642 * vec4(_1992, 0.0, 1.0);
        float _2012 = _2004.w;
        gl_Position = uTransform * vec4((_2004.xy * _1651) + ((_1685 - _1654) * _2012), _1605 * _2012, _2012);
        vTransformBounds = mix(vec4(clamp(_1572, _1578, _2062), clamp(_1572 + _1574, _1578, _2062)), vec4(clamp(_3580, _1578, _2062), clamp(_3580 + _3578, _1578, _2062)), _943);
        _3597 = _1992;
        _3596 = _2004;
    }
    int _2116 = _1602.x;
    uint _2589 = uint(_2116);
    ivec2 _2596 = ivec2(int(_2589 % 1024u), int(_2589 / 1024u));
    vec4 _2580 = texelFetch(sGpuCache, _2596, 0);
    vec2 _2126 = vec2(textureSize(sColor0, 0).xy);
    vec2 _2134 = (_3597 - _1572) / _1574;
    uint _2676 = uint(_2116 + 2);
    ivec2 _2683 = ivec2(int(_2676 % 1024u), int(_2676 / 1024u));
    vec4 _2611 = vec4(_2134.x);
    vec4 _2626 = mix(mix(texelFetch(sGpuCache, _2683, 0), texelFetch(sGpuCache, _2683 + ivec2(1, 0), 0), _2611), mix(texelFetch(sGpuCache, _2683 + ivec2(2, 0), 0), texelFetch(sGpuCache, _2683 + ivec2(3, 0), 0), _2611), vec4(_2134.y));
    float _2146 = float((((_1532 >> 8) & 255) & 1) != 0);
    vec2 _2154 = (mix(_2580.xy, _2580.zw, _2626.xy / vec2(_2626.w)) / _2126) * mix(_3596.w, 1.0, _2146);
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2154.x, _2154.y);
    flat_varying_vec4_4.x = texelFetch(sGpuCache, _2596 + ivec2(1, 0), 0).x;
    flat_varying_vec4_4.y = _2146;
    flat_varying_vec4_2 = _2580 / _2126.xyxy;
    varying_vec4_0 = vec4(_3597.x, _3597.y, varying_vec4_0.z, varying_vec4_0.w);
    int _2183 = _1602.z;
    float _2185 = float(_2183) * 1.52587890625e-05;
    float _2187 = 1.0 - _2185;
    int _2189 = _1602.y;
    flat_varying_ivec4_0.x = _2189 & 65535;
    flat_varying_vec4_4.z = _2185;
    vFuncs[0] = (_2189 >> 28) & 15;
    vFuncs[1] = (_2189 >> 24) & 15;
    vFuncs[2] = (_2189 >> 20) & 15;
    vFuncs[3] = (_2189 >> 16) & 15;
    switch (flat_varying_ivec4_0.x)
    {
        case 1:
        {
            float _2234 = 0.2125999927520751953125 - (0.2125999927520751953125 * _2187);
            float _2245 = 0.715200006961822509765625 - (0.715200006961822509765625 * _2187);
            float _2261 = 0.072200000286102294921875 - (0.072200000286102294921875 * _2187);
            vColorMat = mat4(vec4(0.2125999927520751953125 + (0.7874000072479248046875 * _2187), _2234, _2234, 0.0), vec4(_2245, 0.715200006961822509765625 + (0.284799993038177490234375 * _2187), _2245, 0.0), vec4(_2261, _2261, 0.072200000286102294921875 + (0.927799999713897705078125 * _2187), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
            flat_varying_vec4_3 = vec4(0.0);
            break;
        }
        case 2:
        {
            float _2295 = cos(_2185);
            float _2297 = sin(_2185);
            float _2311 = 0.2125999927520751953125 - (0.2125999927520751953125 * _2295);
            float _2329 = 0.715200006961822509765625 - (0.715200006961822509765625 * _2295);
            float _2332 = 0.715200006961822509765625 * _2297;
            float _2356 = 0.072200000286102294921875 - (0.072200000286102294921875 * _2295);
            vColorMat = mat4(vec4((0.2125999927520751953125 + (0.7874000072479248046875 * _2295)) - (0.2125999927520751953125 * _2297), _2311 + (0.14300000667572021484375 * _2297), _2311 - (0.7874000072479248046875 * _2297), 0.0), vec4(_2329 - _2332, (0.715200006961822509765625 + (0.284799993038177490234375 * _2295)) + (0.14000000059604644775390625 * _2297), _2329 + _2332, 0.0), vec4(_2356 + (0.927799999713897705078125 * _2297), _2356 - (0.28299999237060546875 * _2297), (0.072200000286102294921875 + (0.927799999713897705078125 * _2295)) + (0.072200000286102294921875 * _2297), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
            flat_varying_vec4_3 = vec4(0.0);
            break;
        }
        case 4:
        {
            float _2402 = _2187 * 0.2125999927520751953125;
            float _2414 = _2187 * 0.715200006961822509765625;
            float _2426 = _2187 * 0.072200000286102294921875;
            vColorMat = mat4(vec4(_2402 + _2185, _2402, _2402, 0.0), vec4(_2414, _2414 + _2185, _2414, 0.0), vec4(_2426, _2426, _2426 + _2185, 0.0), vec4(0.0, 0.0, 0.0, 1.0));
            flat_varying_vec4_3 = vec4(0.0);
            break;
        }
        case 5:
        {
            vColorMat = mat4(vec4(0.39300000667572021484375 + (0.60699999332427978515625 * _2187), 0.3490000069141387939453125 - (0.3490000069141387939453125 * _2187), 0.272000014781951904296875 - (0.272000014781951904296875 * _2187), 0.0), vec4(0.768999993801116943359375 - (0.768999993801116943359375 * _2187), 0.68599998950958251953125 + (0.31400001049041748046875 * _2187), 0.533999979496002197265625 - (0.533999979496002197265625 * _2187), 0.0), vec4(0.18899999558925628662109375 - (0.18899999558925628662109375 * _2187), 0.16799999773502349853515625 - (0.16799999773502349853515625 * _2187), 0.13099999725818634033203125 + (0.869000017642974853515625 * _2187), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
            flat_varying_vec4_3 = vec4(0.0);
            break;
        }
        case 7:
        {
            uint _2712 = uint(_2183);
            ivec2 _2719 = ivec2(int(_2712 % 1024u), int(_2712 / 1024u));
            uint _2731 = uint(_2183 + 4);
            vColorMat = mat4(texelFetch(sGpuCache, _2719, 0), texelFetch(sGpuCache, _2719 + ivec2(1, 0), 0), texelFetch(sGpuCache, _2719 + ivec2(2, 0), 0), texelFetch(sGpuCache, _2719 + ivec2(3, 0), 0));
            flat_varying_vec4_3 = texelFetch(sGpuCache, ivec2(int(_2731 % 1024u), int(_2731 / 1024u)), 0);
            break;
        }
        case 11:
        {
            flat_varying_ivec4_0.y = _2183;
            break;
        }
        case 10:
        {
            uint _2750 = uint(_2183);
            flat_varying_vec4_1 = texelFetch(sGpuCache, ivec2(int(_2750 % 1024u), int(_2750 / 1024u)), 0);
            break;
        }
        default:
        {
            break;
        }
    }
}

