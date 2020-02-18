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
flat out vec4 flat_varying_vec4_0;
flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
flat out vec4 flat_varying_vec4_1;
flat out vec4 flat_varying_vec4_2;
flat out vec4 flat_varying_vec4_3;
flat out vec4 flat_varying_vec4_4;
flat out ivec4 flat_varying_ivec4_0;
out vec4 varying_vec4_0;
out vec4 varying_vec4_1;
flat out int flat_varying_highp_int_address_0;

mat4 _2311;

void main()
{
    int _931 = aData.z & 65535;
    uint _955 = uint(aData.x);
    ivec2 _963 = ivec2(int(2u * (_955 % 512u)), int(_955 / 512u));
    vec4 _968 = texelFetch(sPrimitiveHeadersF, _963, 0);
    ivec2 _971 = _963 + ivec2(1, 0);
    vec4 _973 = texelFetch(sPrimitiveHeadersF, _971, 0);
    vec2 _975 = _968.xy;
    vec2 _977 = _968.zw;
    vec2 _981 = _973.xy;
    vec2 _983 = _973.zw;
    ivec4 _1000 = texelFetch(sPrimitiveHeadersI, _963, 0);
    float _1008 = float(_1000.x);
    int _1011 = _1000.y;
    int _1014 = _1000.z;
    vec2 _2240;
    vec2 _2242;
    if (_931 == 65535)
    {
        _2242 = _975;
        _2240 = _977;
    }
    else
    {
        uint _1037 = uint((_1011 + 1) + (_931 * 2));
        vec4 _1028 = texelFetch(sGpuCache, ivec2(int(_1037 % 1024u), int(_1037 / 1024u)), 0);
        _2242 = _1028.xy + _975;
        _2240 = _1028.zw;
    }
    uint _1068 = uint(aData.y >> 16);
    ivec2 _1076 = ivec2(int(2u * (_1068 % 512u)), int(_1068 / 512u));
    vec4 _1086 = texelFetch(sRenderTasks, _1076 + ivec2(1, 0), 0);
    vec2 _1088 = texelFetch(sRenderTasks, _1076, 0).xy;
    float _1054 = _1086.y;
    vec2 _1057 = _1086.zw;
    uint _1182 = uint(_1014 & 16777215);
    ivec2 _1196 = ivec2(int(8u * (_1182 % 128u)), int(_1182 / 128u));
    mat4 _2296 = _2311;
    _2296[0] = texelFetch(sTransformPalette, _1196, 0);
    mat4 _2298 = _2296;
    _2298[1] = texelFetch(sTransformPalette, _1196 + ivec2(1, 0), 0);
    mat4 _2300 = _2298;
    _2300[2] = texelFetch(sTransformPalette, _1196 + ivec2(2, 0), 0);
    mat4 _2302 = _2300;
    _2302[3] = texelFetch(sTransformPalette, _1196 + ivec2(3, 0), 0);
    if ((_1014 >> 24) == 0)
    {
        vec4 _1272 = _2302 * vec4(clamp(_2242 + (_2240 * aPosition.xy), _981, _981 + _983), 0.0, 1.0);
        float _1288 = _1272.w;
        gl_Position = uTransform * vec4((_1272.xy * _1054) + (((-_1057) + _1088) * _1288), _1008 * _1288, _1288);
    }
    else
    {
        bvec4 _821 = notEqual((ivec4((aData.z >> 16) & 255) & ivec4(1, 2, 4, 8)), ivec4(0));
        vec4 _824 = vec4(_821.x ? vec4(1.0).x : vec4(0.0).x, _821.y ? vec4(1.0).y : vec4(0.0).y, _821.z ? vec4(1.0).z : vec4(0.0).z, _821.w ? vec4(1.0).w : vec4(0.0).w);
        vec2 _1465 = _981 + _983;
        vec4 _1372 = vec4(2.0) * _824;
        vec2 _1374 = _1372.xy;
        vec4 _1407 = _2302 * vec4((_2242 - _1374) + ((_2240 + (_1374 + _1372.zw)) * aPosition.xy), 0.0, 1.0);
        float _1415 = _1407.w;
        gl_Position = uTransform * vec4((_1407.xy * _1054) + ((_1088 - _1057) * _1415), _1008 * _1415, _1415);
        vTransformBounds = mix(vec4(clamp(_975, _981, _1465), clamp(_975 + _977, _981, _1465)), vec4(clamp(_2242, _981, _1465), clamp(_2242 + _2240, _981, _1465)), _824);
    }
    uint _1524 = uint(_1011);
    flat_varying_vec4_0 = texelFetch(sGpuCache, ivec2(int(_1524 % 1024u), int(_1524 / 1024u)), 0) * (float(texelFetch(sPrimitiveHeadersI, _971, 0).x) * 1.525902189314365386962890625e-05);
}

