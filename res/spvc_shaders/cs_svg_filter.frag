#version 300 es
precision mediump float;
precision highp int;

uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sPrevPassColor;

flat in mediump int vFuncs[4];
flat in mediump ivec4 vData;
flat in highp vec4 vFilterData0;
flat in mediump int vFilterInputCount;
in highp vec3 vInput1Uv;
flat in highp vec4 vInput1UvRect;
in highp vec3 vInput2Uv;
flat in highp vec4 vInput2UvRect;
flat in mediump int vFilterKind;
flat in highp float vFloat0;
flat in highp mat4 vColorMat;
flat in highp vec4 vFilterData1;
layout(location = 0) out highp vec4 oFragColor;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;

highp vec4 sampleInUvRect(highp sampler2DArray sampler, highp vec3 uv, highp vec4 uvRect)
{
    highp vec2 clamped = clamp(uv.xy, uvRect.xy, uvRect.zw);
    return texture(sampler, vec3(clamped, uv.z), 0.0);
}

highp vec3 Multiply(highp vec3 Cb, highp vec3 Cs)
{
    return Cb * Cs;
}

highp vec3 Screen(highp vec3 Cb, highp vec3 Cs)
{
    return (Cb + Cs) - (Cb * Cs);
}

highp vec3 HardLight(highp vec3 Cb, highp vec3 Cs)
{
    highp vec3 param = Cb;
    highp vec3 param_1 = Cs * 2.0;
    highp vec3 m = Multiply(param, param_1);
    highp vec3 param_2 = Cb;
    highp vec3 param_3 = (Cs * 2.0) - vec3(1.0);
    highp vec3 s = Screen(param_2, param_3);
    highp vec3 edge = vec3(0.5);
    return mix(m, s, step(edge, Cs));
}

highp float ColorDodge(highp float Cb, highp float Cs)
{
    if (Cb == 0.0)
    {
        return 0.0;
    }
    else
    {
        if (Cs == 1.0)
        {
            return 1.0;
        }
        else
        {
            return min(1.0, Cb / (1.0 - Cs));
        }
    }
}

highp float ColorBurn(highp float Cb, highp float Cs)
{
    if (Cb == 1.0)
    {
        return 1.0;
    }
    else
    {
        if (Cs == 0.0)
        {
            return 0.0;
        }
        else
        {
            return 1.0 - min(1.0, (1.0 - Cb) / Cs);
        }
    }
}

highp float SoftLight(highp float Cb, highp float Cs)
{
    if (Cs <= 0.5)
    {
        return Cb - (((1.0 - (2.0 * Cs)) * Cb) * (1.0 - Cb));
    }
    else
    {
        highp float D;
        if (Cb <= 0.25)
        {
            D = ((((16.0 * Cb) - 12.0) * Cb) + 4.0) * Cb;
        }
        else
        {
            D = sqrt(Cb);
        }
        return Cb + (((2.0 * Cs) - 1.0) * (D - Cb));
    }
}

highp vec3 Difference(highp vec3 Cb, highp vec3 Cs)
{
    return abs(Cb - Cs);
}

highp vec3 Exclusion(highp vec3 Cb, highp vec3 Cs)
{
    return (Cb + Cs) - ((Cb * 2.0) * Cs);
}

highp float Sat(highp vec3 c)
{
    return max(c.x, max(c.y, c.z)) - min(c.x, min(c.y, c.z));
}

void SetSatInner(inout highp float Cmin, inout highp float Cmid, inout highp float Cmax, highp float s)
{
    if (Cmax > Cmin)
    {
        Cmid = ((Cmid - Cmin) * s) / (Cmax - Cmin);
        Cmax = s;
    }
    else
    {
        Cmid = 0.0;
        Cmax = 0.0;
    }
    Cmin = 0.0;
}

highp vec3 SetSat(inout highp vec3 C, highp float s)
{
    if (C.x <= C.y)
    {
        if (C.y <= C.z)
        {
            highp float param = C.x;
            highp float param_1 = C.y;
            highp float param_2 = C.z;
            highp float param_3 = s;
            SetSatInner(param, param_1, param_2, param_3);
            C.x = param;
            C.y = param_1;
            C.z = param_2;
        }
        else
        {
            if (C.x <= C.z)
            {
                highp float param_4 = C.x;
                highp float param_5 = C.z;
                highp float param_6 = C.y;
                highp float param_7 = s;
                SetSatInner(param_4, param_5, param_6, param_7);
                C.x = param_4;
                C.z = param_5;
                C.y = param_6;
            }
            else
            {
                highp float param_8 = C.z;
                highp float param_9 = C.x;
                highp float param_10 = C.y;
                highp float param_11 = s;
                SetSatInner(param_8, param_9, param_10, param_11);
                C.z = param_8;
                C.x = param_9;
                C.y = param_10;
            }
        }
    }
    else
    {
        if (C.x <= C.z)
        {
            highp float param_12 = C.y;
            highp float param_13 = C.x;
            highp float param_14 = C.z;
            highp float param_15 = s;
            SetSatInner(param_12, param_13, param_14, param_15);
            C.y = param_12;
            C.x = param_13;
            C.z = param_14;
        }
        else
        {
            if (C.y <= C.z)
            {
                highp float param_16 = C.y;
                highp float param_17 = C.z;
                highp float param_18 = C.x;
                highp float param_19 = s;
                SetSatInner(param_16, param_17, param_18, param_19);
                C.y = param_16;
                C.z = param_17;
                C.x = param_18;
            }
            else
            {
                highp float param_20 = C.z;
                highp float param_21 = C.y;
                highp float param_22 = C.x;
                highp float param_23 = s;
                SetSatInner(param_20, param_21, param_22, param_23);
                C.z = param_20;
                C.y = param_21;
                C.x = param_22;
            }
        }
    }
    return C;
}

highp float Lum(highp vec3 c)
{
    highp vec3 f = vec3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375);
    return dot(c, f);
}

highp vec3 ClipColor(inout highp vec3 C)
{
    highp vec3 param = C;
    highp float L = Lum(param);
    highp float n = min(C.x, min(C.y, C.z));
    highp float x = max(C.x, max(C.y, C.z));
    if (n < 0.0)
    {
        C = vec3(L) + (((C - vec3(L)) * L) / vec3(L - n));
    }
    if (x > 1.0)
    {
        C = vec3(L) + (((C - vec3(L)) * (1.0 - L)) / vec3(x - L));
    }
    return C;
}

highp vec3 SetLum(highp vec3 C, highp float l)
{
    highp vec3 param = C;
    highp float d = l - Lum(param);
    highp vec3 param_1 = C + vec3(d);
    highp vec3 _414 = ClipColor(param_1);
    return _414;
}

highp vec3 Hue(highp vec3 Cb, highp vec3 Cs)
{
    highp vec3 param = Cb;
    highp vec3 param_1 = Cs;
    highp float param_2 = Sat(param);
    highp vec3 _590 = SetSat(param_1, param_2);
    highp vec3 param_3 = Cb;
    highp vec3 param_4 = _590;
    highp float param_5 = Lum(param_3);
    return SetLum(param_4, param_5);
}

highp vec3 Saturation(highp vec3 Cb, highp vec3 Cs)
{
    highp vec3 param = Cs;
    highp vec3 param_1 = Cb;
    highp float param_2 = Sat(param);
    highp vec3 _605 = SetSat(param_1, param_2);
    highp vec3 param_3 = Cb;
    highp vec3 param_4 = _605;
    highp float param_5 = Lum(param_3);
    return SetLum(param_4, param_5);
}

highp vec3 Color(highp vec3 Cb, highp vec3 Cs)
{
    highp vec3 param = Cb;
    highp vec3 param_1 = Cs;
    highp float param_2 = Lum(param);
    return SetLum(param_1, param_2);
}

highp vec3 Luminosity(highp vec3 Cb, highp vec3 Cs)
{
    highp vec3 param = Cs;
    highp vec3 param_1 = Cb;
    highp float param_2 = Lum(param);
    return SetLum(param_1, param_2);
}

highp vec4 blend(highp vec4 Cs, highp vec4 Cb, mediump int mode)
{
    highp vec4 result = vec4(1.0, 0.0, 0.0, 1.0);
    switch (mode)
    {
        case 0:
        {
            result = vec4(Cs.xyz.x, Cs.xyz.y, Cs.xyz.z, result.w);
            break;
        }
        case 1:
        {
            highp vec3 param = Cb.xyz;
            highp vec3 param_1 = Cs.xyz;
            highp vec3 _664 = Multiply(param, param_1);
            result = vec4(_664.x, _664.y, _664.z, result.w);
            break;
        }
        case 2:
        {
            highp vec3 param_2 = Cb.xyz;
            highp vec3 param_3 = Cs.xyz;
            highp vec3 _674 = Screen(param_2, param_3);
            result = vec4(_674.x, _674.y, _674.z, result.w);
            break;
        }
        case 3:
        {
            highp vec3 param_4 = Cs.xyz;
            highp vec3 param_5 = Cb.xyz;
            highp vec3 _684 = HardLight(param_4, param_5);
            result = vec4(_684.x, _684.y, _684.z, result.w);
            break;
        }
        case 4:
        {
            highp vec3 _692 = min(Cs.xyz, Cb.xyz);
            result = vec4(_692.x, _692.y, _692.z, result.w);
            break;
        }
        case 5:
        {
            highp vec3 _700 = max(Cs.xyz, Cb.xyz);
            result = vec4(_700.x, _700.y, _700.z, result.w);
            break;
        }
        case 6:
        {
            highp float param_6 = Cb.x;
            highp float param_7 = Cs.x;
            result.x = ColorDodge(param_6, param_7);
            highp float param_8 = Cb.y;
            highp float param_9 = Cs.y;
            result.y = ColorDodge(param_8, param_9);
            highp float param_10 = Cb.z;
            highp float param_11 = Cs.z;
            result.z = ColorDodge(param_10, param_11);
            break;
        }
        case 7:
        {
            highp float param_12 = Cb.x;
            highp float param_13 = Cs.x;
            result.x = ColorBurn(param_12, param_13);
            highp float param_14 = Cb.y;
            highp float param_15 = Cs.y;
            result.y = ColorBurn(param_14, param_15);
            highp float param_16 = Cb.z;
            highp float param_17 = Cs.z;
            result.z = ColorBurn(param_16, param_17);
            break;
        }
        case 8:
        {
            highp vec3 param_18 = Cb.xyz;
            highp vec3 param_19 = Cs.xyz;
            highp vec3 _760 = HardLight(param_18, param_19);
            result = vec4(_760.x, _760.y, _760.z, result.w);
            break;
        }
        case 9:
        {
            highp float param_20 = Cb.x;
            highp float param_21 = Cs.x;
            result.x = SoftLight(param_20, param_21);
            highp float param_22 = Cb.y;
            highp float param_23 = Cs.y;
            result.y = SoftLight(param_22, param_23);
            highp float param_24 = Cb.z;
            highp float param_25 = Cs.z;
            result.z = SoftLight(param_24, param_25);
            break;
        }
        case 10:
        {
            highp vec3 param_26 = Cb.xyz;
            highp vec3 param_27 = Cs.xyz;
            highp vec3 _795 = Difference(param_26, param_27);
            result = vec4(_795.x, _795.y, _795.z, result.w);
            break;
        }
        case 11:
        {
            highp vec3 param_28 = Cb.xyz;
            highp vec3 param_29 = Cs.xyz;
            highp vec3 _805 = Exclusion(param_28, param_29);
            result = vec4(_805.x, _805.y, _805.z, result.w);
            break;
        }
        case 12:
        {
            highp vec3 param_30 = Cb.xyz;
            highp vec3 param_31 = Cs.xyz;
            highp vec3 _815 = Hue(param_30, param_31);
            result = vec4(_815.x, _815.y, _815.z, result.w);
            break;
        }
        case 13:
        {
            highp vec3 param_32 = Cb.xyz;
            highp vec3 param_33 = Cs.xyz;
            highp vec3 _825 = Saturation(param_32, param_33);
            result = vec4(_825.x, _825.y, _825.z, result.w);
            break;
        }
        case 14:
        {
            highp vec3 param_34 = Cb.xyz;
            highp vec3 param_35 = Cs.xyz;
            highp vec3 _835 = Color(param_34, param_35);
            result = vec4(_835.x, _835.y, _835.z, result.w);
            break;
        }
        case 15:
        {
            highp vec3 param_36 = Cb.xyz;
            highp vec3 param_37 = Cs.xyz;
            highp vec3 _845 = Luminosity(param_36, param_37);
            result = vec4(_845.x, _845.y, _845.z, result.w);
            break;
        }
        default:
        {
            break;
        }
    }
    highp vec3 rgb = (Cs.xyz * (1.0 - Cb.w)) + (result.xyz * Cb.w);
    result = mix(vec4(Cb.xyz * Cb.w, Cb.w), vec4(rgb, 1.0), vec4(Cs.w));
    return result;
}

highp vec3 LinearToSrgb(highp vec3 color)
{
    highp vec3 c1 = color * 12.9200000762939453125;
    highp vec3 c2 = (vec3(1.05499994754791259765625) * pow(color, vec3(0.4166666567325592041015625))) - vec3(0.054999999701976776123046875);
    bvec3 _932 = lessThanEqual(color, vec3(0.003130800090730190277099609375));
    return vec3(_932.x ? c1.x : c2.x, _932.y ? c1.y : c2.y, _932.z ? c1.z : c2.z);
}

highp vec3 SrgbToLinear(highp vec3 color)
{
    highp vec3 c1 = color / vec3(12.9200000762939453125);
    highp vec3 c2 = pow((color / vec3(1.05499994754791259765625)) + vec3(0.0521326996386051177978515625), vec3(2.400000095367431640625));
    bvec3 _910 = lessThanEqual(color, vec3(0.040449999272823333740234375));
    return vec3(_910.x ? c1.x : c2.x, _910.y ? c1.y : c2.y, _910.z ? c1.z : c2.z);
}

highp float point_inside_rect(highp vec2 p, highp vec2 p0, highp vec2 p1)
{
    highp vec2 s = step(p0, p) - step(p1, p);
    return s.x * s.y;
}

highp vec4 fetch_from_gpu_cache_1_direct(mediump ivec2 address)
{
    return texelFetch(sGpuCache, address, 0);
}

highp vec4 ComponentTransfer(inout highp vec4 colora)
{
    mediump int offset = 0;
    highp vec4 texel;
    for (mediump int i = 0; i < 4; i++)
    {
        switch (vFuncs[i])
        {
            case 0:
            {
                break;
            }
            case 1:
            case 2:
            {
                mediump int k = int(floor(colora[i] * 255.0));
                ivec2 param = vData.xy + ivec2(offset + (k / 4), 0);
                texel = fetch_from_gpu_cache_1_direct(param);
                colora[i] = clamp(texel[k % 4], 0.0, 1.0);
                offset += 64;
                break;
            }
            case 3:
            {
                ivec2 param_1 = vData.xy + ivec2(offset, 0);
                texel = fetch_from_gpu_cache_1_direct(param_1);
                colora[i] = clamp((texel.x * colora[i]) + texel.y, 0.0, 1.0);
                offset++;
                break;
            }
            case 4:
            {
                ivec2 param_2 = vData.xy + ivec2(offset, 0);
                texel = fetch_from_gpu_cache_1_direct(param_2);
                colora[i] = clamp((texel.x * pow(colora[i], texel.y)) + texel.z, 0.0, 1.0);
                offset++;
                break;
            }
            default:
            {
                break;
            }
        }
    }
    return colora;
}

highp vec4 composite(highp vec4 Cs, highp vec4 Cb, mediump int mode)
{
    highp vec4 Cr = vec4(0.0, 1.0, 0.0, 1.0);
    switch (mode)
    {
        case 0:
        {
            highp vec3 _1075 = (Cs.xyz * Cs.w) + ((Cb.xyz * Cb.w) * (1.0 - Cs.w));
            Cr = vec4(_1075.x, _1075.y, _1075.z, Cr.w);
            Cr.w = Cs.w + (Cb.w * (1.0 - Cs.w));
            break;
        }
        case 1:
        {
            highp vec3 _1096 = (Cs.xyz * Cs.w) * Cb.w;
            Cr = vec4(_1096.x, _1096.y, _1096.z, Cr.w);
            Cr.w = Cs.w * Cb.w;
            break;
        }
        case 2:
        {
            highp vec3 _1114 = (Cs.xyz * Cs.w) * (1.0 - Cb.w);
            Cr = vec4(_1114.x, _1114.y, _1114.z, Cr.w);
            Cr.w = Cs.w * (1.0 - Cb.w);
            break;
        }
        case 3:
        {
            highp vec3 _1142 = ((Cs.xyz * Cs.w) * Cb.w) + ((Cb.xyz * Cb.w) * (1.0 - Cs.w));
            Cr = vec4(_1142.x, _1142.y, _1142.z, Cr.w);
            Cr.w = (Cs.w * Cb.w) + (Cb.w * (1.0 - Cs.w));
            break;
        }
        case 4:
        {
            highp vec3 _1177 = ((Cs.xyz * Cs.w) * (1.0 - Cb.w)) + ((Cb.xyz * Cb.w) * (1.0 - Cs.w));
            Cr = vec4(_1177.x, _1177.y, _1177.z, Cr.w);
            Cr.w = (Cs.w * (1.0 - Cb.w)) + (Cb.w * (1.0 - Cs.w));
            break;
        }
        case 5:
        {
            highp vec3 _1205 = (Cs.xyz * Cs.w) + (Cb.xyz * Cb.w);
            Cr = vec4(_1205.x, _1205.y, _1205.z, Cr.w);
            Cr.w = Cs.w + Cb.w;
            Cr = clamp(Cr, vec4(0.0), vec4(1.0));
            break;
        }
        case 6:
        {
            Cr = ((((vec4(vFilterData0.x) * Cs) * Cb) + (vec4(vFilterData0.y) * Cs)) + (vec4(vFilterData0.z) * Cb)) + vec4(vFilterData0.w);
            Cr = clamp(Cr, vec4(0.0), vec4(1.0));
            break;
        }
        default:
        {
            break;
        }
    }
    return Cr;
}

void main()
{
    highp vec4 Ca = vec4(0.0);
    highp vec4 Cb = vec4(0.0);
    if (vFilterInputCount > 0)
    {
        highp vec3 param = vInput1Uv;
        highp vec4 param_1 = vInput1UvRect;
        Ca = sampleInUvRect(sColor0, param, param_1);
        if (Ca.w != 0.0)
        {
            highp vec3 _1297 = Ca.xyz / vec3(Ca.w);
            Ca = vec4(_1297.x, _1297.y, _1297.z, Ca.w);
        }
    }
    if (vFilterInputCount > 1)
    {
        highp vec3 param_2 = vInput2Uv;
        highp vec4 param_3 = vInput2UvRect;
        Cb = sampleInUvRect(sColor1, param_2, param_3);
        if (Cb.w != 0.0)
        {
            highp vec3 _1322 = Cb.xyz / vec3(Cb.w);
            Cb = vec4(_1322.x, _1322.y, _1322.z, Cb.w);
        }
    }
    highp vec4 result = vec4(1.0, 0.0, 0.0, 1.0);
    bool needsPremul = true;
    switch (vFilterKind)
    {
        case 0:
        {
            highp vec4 param_4 = Ca;
            highp vec4 param_5 = Cb;
            int param_6 = vData.x;
            result = blend(param_4, param_5, param_6);
            needsPremul = false;
            break;
        }
        case 1:
        {
            result = vFilterData0;
            needsPremul = false;
            break;
        }
        case 2:
        {
            highp vec3 param_7 = Ca.xyz;
            highp vec3 _1359 = LinearToSrgb(param_7);
            result = vec4(_1359.x, _1359.y, _1359.z, result.w);
            result.w = Ca.w;
            break;
        }
        case 3:
        {
            highp vec3 param_8 = Ca.xyz;
            highp vec3 _1369 = SrgbToLinear(param_8);
            result = vec4(_1369.x, _1369.y, _1369.z, result.w);
            result.w = Ca.w;
            break;
        }
        case 4:
        {
            result = vec4(Ca.xyz.x, Ca.xyz.y, Ca.xyz.z, result.w);
            result.w = Ca.w * vFloat0;
            break;
        }
        case 5:
        {
            result = (vColorMat * Ca) + vFilterData0;
            result = clamp(result, vec4(0.0), vec4(1.0));
            break;
        }
        case 6:
        {
            highp vec4 shadow = vec4(vFilterData0.xyz, Cb.w * vFilterData0.w);
            highp vec4 param_9 = Ca;
            highp vec4 param_10 = shadow;
            int param_11 = 0;
            result = blend(param_9, param_10, param_11);
            needsPremul = false;
            break;
        }
        case 7:
        {
            highp vec2 offsetUv = vInput1Uv.xy + vFilterData0.xy;
            highp vec3 param_12 = vec3(offsetUv, vInput1Uv.z);
            highp vec4 param_13 = vInput1UvRect;
            result = sampleInUvRect(sColor0, param_12, param_13);
            highp vec2 param_14 = offsetUv;
            highp vec2 param_15 = vFilterData1.xy;
            highp vec2 param_16 = vFilterData1.zw;
            result *= point_inside_rect(param_14, param_15, param_16);
            needsPremul = false;
            break;
        }
        case 8:
        {
            highp vec4 param_17 = Ca;
            highp vec4 _1448 = ComponentTransfer(param_17);
            result = _1448;
            break;
        }
        case 9:
        {
            result = Ca;
            break;
        }
        case 10:
        {
            highp vec4 param_18 = Ca;
            highp vec4 param_19 = Cb;
            int param_20 = vData.x;
            result = composite(param_18, param_19, param_20);
            needsPremul = false;
        }
        default:
        {
            break;
        }
    }
    if (needsPremul)
    {
        highp vec3 _1469 = result.xyz * result.w;
        result = vec4(_1469.x, _1469.y, _1469.z, result.w);
    }
    oFragColor = result;
}

