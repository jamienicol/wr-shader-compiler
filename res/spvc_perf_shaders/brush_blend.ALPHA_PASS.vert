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
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
out vec4 varying_vec4_0;
flat out vec4 flat_varying_vec4_4;
flat out vec4 flat_varying_vec4_2;
flat out ivec4 flat_varying_ivec4_0;
flat out int vFuncs[4];
flat out mat4 vColorMat;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_0;
out vec4 varying_vec4_1;
flat out int flat_varying_highp_int_address_0;

mat4 _3251;

void main()
{
    int _1575 = aData.y & 65535;
    int _1579 = aData.z & 65535;
    int _1583 = aData.z >> 16;
    uint _1603 = uint(aData.x);
    ivec2 _1611 = ivec2(int(2u * (_1603 % 512u)), int(_1603 / 512u));
    vec4 _1616 = texelFetch(sPrimitiveHeadersF, _1611, 0);
    ivec2 _1619 = _1611 + ivec2(1, 0);
    vec4 _1621 = texelFetch(sPrimitiveHeadersF, _1619, 0);
    vec2 _1623 = _1616.xy;
    vec2 _1625 = _1616.zw;
    vec2 _1629 = _1621.xy;
    vec2 _1631 = _1621.zw;
    ivec4 _1648 = texelFetch(sPrimitiveHeadersI, _1611, 0);
    ivec4 _1653 = texelFetch(sPrimitiveHeadersI, _1619, 0);
    float _1656 = float(_1648.x);
    int _1662 = _1648.z;
    vec2 _3255;
    vec2 _3257;
    if (_1579 == 65535)
    {
        _3257 = _1623;
        _3255 = _1625;
    }
    else
    {
        uint _1685 = uint((_1648.y + 3) + (_1579 * 2));
        vec4 _1676 = texelFetch(sGpuCache, ivec2(int(_1685 % 1024u), int(_1685 / 1024u)), 0);
        _3257 = _1676.xy + _1623;
        _3255 = _1676.zw;
    }
    uint _1716 = uint(aData.y >> 16);
    ivec2 _1724 = ivec2(int(2u * (_1716 % 512u)), int(_1716 / 512u));
    vec4 _1734 = texelFetch(sRenderTasks, _1724 + ivec2(1, 0), 0);
    vec2 _1736 = texelFetch(sRenderTasks, _1724, 0).xy;
    float _1702 = _1734.y;
    vec2 _1705 = _1734.zw;
    vec2 _3244;
    float _3245;
    float _3246;
    vec2 _3247;
    vec2 _3248;
    if (_1575 >= 32767)
    {
        _3248 = vec2(0.0);
        _3247 = vec2(0.0);
        _3246 = 0.0;
        _3245 = 0.0;
        _3244 = vec2(0.0);
    }
    else
    {
        uint _1785 = uint(_1575);
        ivec2 _1793 = ivec2(int(2u * (_1785 % 512u)), int(_1785 / 512u));
        vec4 _1798 = texelFetch(sRenderTasks, _1793, 0);
        vec4 _1803 = texelFetch(sRenderTasks, _1793 + ivec2(1, 0), 0);
        _3248 = _1798.xy;
        _3247 = _1798.zw;
        _3246 = _1803.x;
        _3245 = _1803.y;
        _3244 = _1803.zw;
    }
    uint _1830 = uint(_1662 & 16777215);
    ivec2 _1844 = ivec2(int(8u * (_1830 % 128u)), int(_1830 / 128u));
    mat4 _3203 = _3251;
    _3203[0] = texelFetch(sTransformPalette, _1844, 0);
    mat4 _3205 = _3203;
    _3205[1] = texelFetch(sTransformPalette, _1844 + ivec2(1, 0), 0);
    mat4 _3207 = _3205;
    _3207[2] = texelFetch(sTransformPalette, _1844 + ivec2(2, 0), 0);
    mat4 _3209 = _3207;
    _3209[3] = texelFetch(sTransformPalette, _1844 + ivec2(3, 0), 0);
    vec4 _3258;
    vec2 _3259;
    if ((_1662 >> 24) == 0)
    {
        vec2 _1963 = clamp(_3257 + (_3255 * aPosition.xy), _1629, _1629 + _1631);
        vec4 _1920 = _3209 * vec4(_1963, 0.0, 1.0);
        float _1936 = _1920.w;
        gl_Position = uTransform * vec4((_1920.xy * _1702) + (((-_1705) + _1736) * _1936), _1656 * _1936, _1936);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _3259 = _1963;
        _3258 = _1920;
    }
    else
    {
        bvec4 _987 = notEqual((ivec4(_1583 & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _990 = vec4(_987.x ? vec4(1.0).x : vec4(0.0).x, _987.y ? vec4(1.0).y : vec4(0.0).y, _987.z ? vec4(1.0).z : vec4(0.0).z, _987.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _2114 = _1629 + _1631;
        vec4 _2021 = vec4(2.0) * _990;
        vec2 _2023 = _2021.xy;
        vec2 _2044 = (_3257 - _2023) + ((_3255 + (_2023 + _2021.zw)) * aPosition.xy);
        vec4 _2056 = _3209 * vec4(_2044, 0.0, 1.0);
        float _2064 = _2056.w;
        gl_Position = uTransform * vec4((_2056.xy * _1702) + ((_1736 - _1705) * _2064), _1656 * _2064, _2064);
        vTransformBounds = mix(vec4(clamp(_1623, _1629, _2114), clamp(_1623 + _1625, _1629, _2114)), vec4(clamp(_3257, _1629, _2114), clamp(_3257 + _3255, _1629, _2114)), _990);
        _3259 = _2044;
        _3258 = _2056;
    }
    vClipMaskUvBounds = vec4(_3248, _3248 + _3247);
    vClipMaskUv = vec4((_3258.xy * _3245) + ((_3248 - _3244) * _3258.w), _3246, _3258.w);
    int _2203 = _1653.x;
    uint _2676 = uint(_2203);
    ivec2 _2683 = ivec2(int(_2676 % 1024u), int(_2676 / 1024u));
    vec4 _2667 = texelFetch(sGpuCache, _2683, 0);
    vec2 _2213 = vec2(textureSize(sColor0, 0).xy);
    vec2 _2221 = (_3259 - _1623) / _1625;
    uint _2763 = uint(_2203 + 2);
    ivec2 _2770 = ivec2(int(_2763 % 1024u), int(_2763 / 1024u));
    vec4 _2698 = vec4(_2221.x);
    vec4 _2713 = mix(mix(texelFetch(sGpuCache, _2770, 0), texelFetch(sGpuCache, _2770 + ivec2(1, 0), 0), _2698), mix(texelFetch(sGpuCache, _2770 + ivec2(2, 0), 0), texelFetch(sGpuCache, _2770 + ivec2(3, 0), 0), _2698), vec4(_2221.y));
    float _2233 = float((((_1583 >> 8) & 255) & 1) != 0);
    vec2 _2241 = (mix(_2667.xy, _2667.zw, _2713.xy / vec2(_2713.w)) / _2213) * mix(_3258.w, 1.0, _2233);
    varying_vec4_0 = vec4(varying_vec4_0.x, varying_vec4_0.y, _2241.x, _2241.y);
    flat_varying_vec4_4.x = texelFetch(sGpuCache, _2683 + ivec2(1, 0), 0).x;
    flat_varying_vec4_4.y = _2233;
    flat_varying_vec4_2 = _2667 / _2213.xyxy;
    varying_vec4_0 = vec4(_3259.x, _3259.y, varying_vec4_0.z, varying_vec4_0.w);
    int _2270 = _1653.z;
    float _2272 = float(_2270) * 1.52587890625e-05;
    float _2274 = 1.0 - _2272;
    int _2276 = _1653.y;
    flat_varying_ivec4_0.x = _2276 & 65535;
    flat_varying_vec4_4.z = _2272;
    vFuncs[0] = (_2276 >> 28) & 15;
    vFuncs[1] = (_2276 >> 24) & 15;
    vFuncs[2] = (_2276 >> 20) & 15;
    vFuncs[3] = (_2276 >> 16) & 15;
    switch (flat_varying_ivec4_0.x)
    {
        case 1:
        {
            float _2321 = 0.2125999927520751953125 - (0.2125999927520751953125 * _2274);
            float _2332 = 0.715200006961822509765625 - (0.715200006961822509765625 * _2274);
            float _2348 = 0.072200000286102294921875 - (0.072200000286102294921875 * _2274);
            vColorMat = mat4(vec4(0.2125999927520751953125 + (0.7874000072479248046875 * _2274), _2321, _2321, 0.0), vec4(_2332, 0.715200006961822509765625 + (0.284799993038177490234375 * _2274), _2332, 0.0), vec4(_2348, _2348, 0.072200000286102294921875 + (0.927799999713897705078125 * _2274), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
            flat_varying_vec4_3 = vec4(0.0);
            break;
        }
        case 2:
        {
            float _2382 = cos(_2272);
            float _2384 = sin(_2272);
            float _2398 = 0.2125999927520751953125 - (0.2125999927520751953125 * _2382);
            float _2416 = 0.715200006961822509765625 - (0.715200006961822509765625 * _2382);
            float _2419 = 0.715200006961822509765625 * _2384;
            float _2443 = 0.072200000286102294921875 - (0.072200000286102294921875 * _2382);
            vColorMat = mat4(vec4((0.2125999927520751953125 + (0.7874000072479248046875 * _2382)) - (0.2125999927520751953125 * _2384), _2398 + (0.14300000667572021484375 * _2384), _2398 - (0.7874000072479248046875 * _2384), 0.0), vec4(_2416 - _2419, (0.715200006961822509765625 + (0.284799993038177490234375 * _2382)) + (0.14000000059604644775390625 * _2384), _2416 + _2419, 0.0), vec4(_2443 + (0.927799999713897705078125 * _2384), _2443 - (0.28299999237060546875 * _2384), (0.072200000286102294921875 + (0.927799999713897705078125 * _2382)) + (0.072200000286102294921875 * _2384), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
            flat_varying_vec4_3 = vec4(0.0);
            break;
        }
        case 4:
        {
            float _2489 = _2274 * 0.2125999927520751953125;
            float _2501 = _2274 * 0.715200006961822509765625;
            float _2513 = _2274 * 0.072200000286102294921875;
            vColorMat = mat4(vec4(_2489 + _2272, _2489, _2489, 0.0), vec4(_2501, _2501 + _2272, _2501, 0.0), vec4(_2513, _2513, _2513 + _2272, 0.0), vec4(0.0, 0.0, 0.0, 1.0));
            flat_varying_vec4_3 = vec4(0.0);
            break;
        }
        case 5:
        {
            vColorMat = mat4(vec4(0.39300000667572021484375 + (0.60699999332427978515625 * _2274), 0.3490000069141387939453125 - (0.3490000069141387939453125 * _2274), 0.272000014781951904296875 - (0.272000014781951904296875 * _2274), 0.0), vec4(0.768999993801116943359375 - (0.768999993801116943359375 * _2274), 0.68599998950958251953125 + (0.31400001049041748046875 * _2274), 0.533999979496002197265625 - (0.533999979496002197265625 * _2274), 0.0), vec4(0.18899999558925628662109375 - (0.18899999558925628662109375 * _2274), 0.16799999773502349853515625 - (0.16799999773502349853515625 * _2274), 0.13099999725818634033203125 + (0.869000017642974853515625 * _2274), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
            flat_varying_vec4_3 = vec4(0.0);
            break;
        }
        case 7:
        {
            uint _2799 = uint(_2270);
            ivec2 _2806 = ivec2(int(_2799 % 1024u), int(_2799 / 1024u));
            uint _2818 = uint(_2270 + 4);
            vColorMat = mat4(texelFetch(sGpuCache, _2806, 0), texelFetch(sGpuCache, _2806 + ivec2(1, 0), 0), texelFetch(sGpuCache, _2806 + ivec2(2, 0), 0), texelFetch(sGpuCache, _2806 + ivec2(3, 0), 0));
            flat_varying_vec4_3 = texelFetch(sGpuCache, ivec2(int(_2818 % 1024u), int(_2818 / 1024u)), 0);
            break;
        }
        case 11:
        {
            flat_varying_ivec4_0.y = _2270;
            break;
        }
        case 10:
        {
            uint _2837 = uint(_2270);
            flat_varying_vec4_1 = texelFetch(sGpuCache, ivec2(int(_2837 % 1024u), int(_2837 / 1024u)), 0);
            break;
        }
        default:
        {
            break;
        }
    }
}

