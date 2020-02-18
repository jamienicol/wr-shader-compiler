#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform mat4 uTransform;

flat out vec4 vTransformBounds;
layout(location = 1) in ivec4 aData;
layout(location = 0) in vec3 aPosition;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
flat out vec4 flat_varying_vec4_0;
out vec4 varying_vec4_0;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_1;
flat out int flat_varying_highp_int_address_0;

mat4 _2465;

void main()
{
    int _982 = aData.y & 65535;
    int _986 = aData.z & 65535;
    uint _1010 = uint(aData.x);
    ivec2 _1018 = ivec2(int(2u * (_1010 % 512u)), int(_1010 / 512u));
    vec4 _1023 = texelFetch(sPrimitiveHeadersF, _1018, 0);
    ivec2 _1026 = _1018 + ivec2(1, 0);
    vec4 _1028 = texelFetch(sPrimitiveHeadersF, _1026, 0);
    vec2 _1030 = _1023.xy;
    vec2 _1032 = _1023.zw;
    vec2 _1036 = _1028.xy;
    vec2 _1038 = _1028.zw;
    ivec4 _1055 = texelFetch(sPrimitiveHeadersI, _1018, 0);
    float _1063 = float(_1055.x);
    int _1066 = _1055.y;
    int _1069 = _1055.z;
    vec2 _2384;
    vec2 _2386;
    if (_986 == 65535)
    {
        _2386 = _1030;
        _2384 = _1032;
    }
    else
    {
        uint _1092 = uint((_1066 + 1) + (_986 * 2));
        vec4 _1083 = texelFetch(sGpuCache, ivec2(int(_1092 % 1024u), int(_1092 / 1024u)), 0);
        _2386 = _1083.xy + _1030;
        _2384 = _1083.zw;
    }
    uint _1123 = uint(aData.y >> 16);
    ivec2 _1131 = ivec2(int(2u * (_1123 % 512u)), int(_1123 / 512u));
    vec4 _1141 = texelFetch(sRenderTasks, _1131 + ivec2(1, 0), 0);
    vec2 _1143 = texelFetch(sRenderTasks, _1131, 0).xy;
    float _1109 = _1141.y;
    vec2 _1112 = _1141.zw;
    vec2 _2374;
    float _2375;
    float _2376;
    vec2 _2377;
    vec2 _2378;
    if (_982 >= 32767)
    {
        _2378 = vec2(0.0);
        _2377 = vec2(0.0);
        _2376 = 0.0;
        _2375 = 0.0;
        _2374 = vec2(0.0);
    }
    else
    {
        uint _1192 = uint(_982);
        ivec2 _1200 = ivec2(int(2u * (_1192 % 512u)), int(_1192 / 512u));
        vec4 _1205 = texelFetch(sRenderTasks, _1200, 0);
        vec4 _1210 = texelFetch(sRenderTasks, _1200 + ivec2(1, 0), 0);
        _2378 = _1205.xy;
        _2377 = _1205.zw;
        _2376 = _1210.x;
        _2375 = _1210.y;
        _2374 = _1210.zw;
    }
    uint _1237 = uint(_1069 & 16777215);
    ivec2 _1251 = ivec2(int(8u * (_1237 % 128u)), int(_1237 / 128u));
    mat4 _2447 = _2465;
    _2447[0] = texelFetch(sTransformPalette, _1251, 0);
    mat4 _2449 = _2447;
    _2449[1] = texelFetch(sTransformPalette, _1251 + ivec2(1, 0), 0);
    mat4 _2451 = _2449;
    _2451[2] = texelFetch(sTransformPalette, _1251 + ivec2(2, 0), 0);
    mat4 _2453 = _2451;
    _2453[3] = texelFetch(sTransformPalette, _1251 + ivec2(3, 0), 0);
    vec4 _2402;
    vec2 _2408;
    if ((_1069 >> 24) == 0)
    {
        vec2 _1370 = clamp(_2386 + (_2384 * aPosition.xy), _1036, _1036 + _1038);
        vec4 _1327 = _2453 * vec4(_1370, 0.0, 1.0);
        float _1343 = _1327.w;
        gl_Position = uTransform * vec4((_1327.xy * _1109) + (((-_1112) + _1143) * _1343), _1063 * _1343, _1343);
        vTransformBounds = vec4(-10000000272564224.0, -10000000272564224.0, 10000000272564224.0, 10000000272564224.0);
        _2408 = _1370;
        _2402 = _1327;
    }
    else
    {
        bvec4 _868 = notEqual((ivec4((aData.z >> 16) & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _871 = vec4(_868.x ? vec4(1.0).x : vec4(0.0).x, _868.y ? vec4(1.0).y : vec4(0.0).y, _868.z ? vec4(1.0).z : vec4(0.0).z, _868.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1521 = _1036 + _1038;
        vec4 _1428 = vec4(2.0) * _871;
        vec2 _1430 = _1428.xy;
        vec2 _1451 = (_2386 - _1430) + ((_2384 + (_1430 + _1428.zw)) * aPosition.xy);
        vec4 _1463 = _2453 * vec4(_1451, 0.0, 1.0);
        float _1471 = _1463.w;
        gl_Position = uTransform * vec4((_1463.xy * _1109) + ((_1143 - _1112) * _1471), _1063 * _1471, _1471);
        vTransformBounds = mix(vec4(clamp(_1030, _1036, _1521), clamp(_1030 + _1032, _1036, _1521)), vec4(clamp(_2386, _1036, _1521), clamp(_2386 + _2384, _1036, _1521)), _871);
        _2408 = _1451;
        _2402 = _1463;
    }
    vClipMaskUvBounds = vec4(_2378, _2378 + _2377);
    vClipMaskUv = vec4((_2402.xy * _2375) + ((_2378 - _2374) * _2402.w), _2376, _2402.w);
    uint _1619 = uint(_1066);
    flat_varying_vec4_0 = texelFetch(sGpuCache, ivec2(int(_1619 % 1024u), int(_1619 / 1024u)), 0) * (float(texelFetch(sPrimitiveHeadersI, _1026, 0).x) * 1.525902189314365386962890625e-05);
    varying_vec4_0 = vec4(_2408.x, _2408.y, varying_vec4_0.z, varying_vec4_0.w);
}
