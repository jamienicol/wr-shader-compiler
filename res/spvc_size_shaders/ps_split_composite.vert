#version 300 es

uniform highp sampler2D sRenderTasks;
uniform highp sampler2D sGpuCache;
uniform highp sampler2D sTransformPalette;
uniform highp sampler2D sPrimitiveHeadersF;
uniform highp isampler2D sPrimitiveHeadersI;
uniform mat4 uTransform;
uniform highp sampler2DArray sPrevPassColor;

flat out vec4 vClipMaskUvBounds;
out vec4 vClipMaskUv;
layout(location = 1) in ivec4 aData;
layout(location = 0) in vec3 aPosition;
flat out vec4 vUvSampleBounds;
out vec2 vUv;
flat out vec2 vLayerAndPerspective;
flat out vec4 vTransformBounds;

mat4 _1998;

void main()
{
    uint _880 = uint(aData.y);
    ivec2 _887 = ivec2(int(_880 % 1024u), int(_880 / 1024u));
    vec4 _861 = texelFetch(sGpuCache, _887, 0);
    vec4 _866 = texelFetch(sGpuCache, _887 + ivec2(1, 0), 0);
    uint _897 = uint(aData.x);
    ivec2 _905 = ivec2(int(2u * (_897 % 512u)), int(_897 / 512u));
    vec4 _910 = texelFetch(sPrimitiveHeadersF, _905, 0);
    ivec4 _947 = texelFetch(sPrimitiveHeadersI, _905 + ivec2(1, 0), 0);
    uint _984 = uint(aData.w);
    ivec2 _992 = ivec2(int(2u * (_984 % 512u)), int(_984 / 512u));
    vec4 _1002 = texelFetch(sRenderTasks, _992 + ivec2(1, 0), 0);
    uint _1029 = uint(texelFetch(sPrimitiveHeadersI, _905, 0).z & 16777215);
    ivec2 _1043 = ivec2(int(8u * (_1029 % 128u)), int(_1029 / 128u));
    mat4 _1975 = _1998;
    _1975[0] = texelFetch(sTransformPalette, _1043, 0);
    mat4 _1977 = _1975;
    _1977[1] = texelFetch(sTransformPalette, _1043 + ivec2(1, 0), 0);
    mat4 _1979 = _1977;
    _1979[2] = texelFetch(sTransformPalette, _1043 + ivec2(2, 0), 0);
    mat4 _1981 = _1979;
    _1981[3] = texelFetch(sTransformPalette, _1043 + ivec2(3, 0), 0);
    int _662 = _947.x;
    uint _1131 = uint(_662);
    ivec2 _1138 = ivec2(int(_1131 % 1024u), int(_1131 / 1024u));
    vec4 _1122 = texelFetch(sGpuCache, _1138, 0);
    vec2 _1101 = _1122.xy;
    vec2 _1104 = _1122.zw;
    int _667 = _947.w;
    vec2 _1950;
    float _1951;
    float _1952;
    vec2 _1953;
    vec2 _1954;
    if (_667 >= 32767)
    {
        _1954 = vec2(0.0);
        _1953 = vec2(0.0);
        _1952 = 0.0;
        _1951 = 0.0;
        _1950 = vec2(0.0);
    }
    else
    {
        uint _1175 = uint(_667);
        ivec2 _1183 = ivec2(int(2u * (_1175 % 512u)), int(_1175 / 512u));
        vec4 _1188 = texelFetch(sRenderTasks, _1183, 0);
        vec4 _1193 = texelFetch(sRenderTasks, _1183 + ivec2(1, 0), 0);
        _1954 = _1188.xy;
        _1953 = _1188.zw;
        _1952 = _1193.x;
        _1951 = _1193.y;
        _1950 = _1193.zw;
    }
    vec2 _1214 = vec2(aPosition.x);
    vec2 _1225 = mix(mix(_861.xy, _861.zw, _1214), mix(_866.zw, _866.xy, _1214), vec2(aPosition.y));
    vec4 _707 = _1981 * vec4(_1225, 0.0, 1.0);
    float _711 = _707.w;
    vec2 _714 = _707.xy;
    vClipMaskUvBounds = vec4(_1954, _1954 + _1953);
    vClipMaskUv = vec4((_714 * _1951) + ((_1954 - _1950) * _711), _1952, _711);
    gl_Position = uTransform * vec4(((texelFetch(sRenderTasks, _992, 0).xy - _1002.zw) * _711) + (_714 * _1002.y), _711 * float(aData.z), _711);
    vec2 _755 = vec2(vec3(textureSize(sPrevPassColor, 0)).xy);
    vUvSampleBounds = vec4(min(_1101, _1104) + vec2(0.5), max(_1101, _1104) - vec2(0.5)) / _755.xyxy;
    vec2 _792 = (_1225 - _910.xy) / _910.zw;
    uint _1340 = uint(_662 + 2);
    ivec2 _1347 = ivec2(int(_1340 % 1024u), int(_1340 / 1024u));
    vec4 _1275 = vec4(_792.x);
    vec4 _1290 = mix(mix(texelFetch(sGpuCache, _1347, 0), texelFetch(sGpuCache, _1347 + ivec2(1, 0), 0), _1275), mix(texelFetch(sGpuCache, _1347 + ivec2(2, 0), 0), texelFetch(sGpuCache, _1347 + ivec2(3, 0), 0), _1275), vec4(_792.y));
    float _807 = float(_947.y);
    vUv = (mix(_1101, _1104, _1290.xy / vec2(_1290.w)) / _755) * mix(gl_Position.w, 1.0, _807);
    vLayerAndPerspective = vec2(texelFetch(sGpuCache, _1138 + ivec2(1, 0), 0).x, _807);
}

