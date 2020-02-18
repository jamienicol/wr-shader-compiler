#version 300 es
precision mediump float;
precision highp int;

struct Fragment
{
    highp vec4 color;
};

uniform highp sampler2DArray sPrevPassColor;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sPrevPassAlpha;

layout(location = 0) out highp vec4 oFragColor;
in highp vec4 varying_vec4_1;
in highp vec4 varying_vec4_0;
flat in mediump ivec4 flat_varying_ivec4_0;
flat in highp vec4 vTransformBounds;
flat in highp vec4 vClipMaskUvBounds;
in highp vec4 vClipMaskUv;
flat in highp vec4 flat_varying_vec4_0;
flat in highp vec4 flat_varying_vec4_1;
flat in highp vec4 flat_varying_vec4_2;
flat in highp vec4 flat_varying_vec4_3;
flat in highp vec4 flat_varying_vec4_4;
flat in int flat_varying_highp_int_address_0;

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
    highp vec3 _362 = ClipColor(param_1);
    return _362;
}

highp vec3 Hue(highp vec3 Cb, highp vec3 Cs)
{
    highp vec3 param = Cb;
    highp vec3 param_1 = Cs;
    highp float param_2 = Sat(param);
    highp vec3 _538 = SetSat(param_1, param_2);
    highp vec3 param_3 = Cb;
    highp vec3 param_4 = _538;
    highp float param_5 = Lum(param_3);
    return SetLum(param_4, param_5);
}

highp vec3 Saturation(highp vec3 Cb, highp vec3 Cs)
{
    highp vec3 param = Cs;
    highp vec3 param_1 = Cb;
    highp float param_2 = Sat(param);
    highp vec3 _553 = SetSat(param_1, param_2);
    highp vec3 param_3 = Cb;
    highp vec3 param_4 = _553;
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

Fragment mix_blend_brush_fs()
{
    highp vec4 Cb = textureLod(sPrevPassColor, vec3(varying_vec4_1.xy, varying_vec4_1.w), 0.0);
    highp vec4 Cs = textureLod(sPrevPassColor, vec3(varying_vec4_0.xy, varying_vec4_0.w), 0.0);
    if (Cb.w != 0.0)
    {
        highp vec3 _620 = Cb.xyz / vec3(Cb.w);
        Cb = vec4(_620.x, _620.y, _620.z, Cb.w);
    }
    if (Cs.w != 0.0)
    {
        highp vec3 _633 = Cs.xyz / vec3(Cs.w);
        Cs = vec4(_633.x, _633.y, _633.z, Cs.w);
    }
    highp vec4 result = vec4(1.0, 1.0, 0.0, 1.0);
    switch (flat_varying_ivec4_0.x)
    {
        case 1:
        {
            highp vec3 param = Cb.xyz;
            highp vec3 param_1 = Cs.xyz;
            highp vec3 _667 = Multiply(param, param_1);
            result = vec4(_667.x, _667.y, _667.z, result.w);
            break;
        }
        case 2:
        {
            highp vec3 param_2 = Cb.xyz;
            highp vec3 param_3 = Cs.xyz;
            highp vec3 _677 = Screen(param_2, param_3);
            result = vec4(_677.x, _677.y, _677.z, result.w);
            break;
        }
        case 3:
        {
            highp vec3 param_4 = Cs.xyz;
            highp vec3 param_5 = Cb.xyz;
            highp vec3 _687 = HardLight(param_4, param_5);
            result = vec4(_687.x, _687.y, _687.z, result.w);
            break;
        }
        case 4:
        {
            highp vec3 _695 = min(Cs.xyz, Cb.xyz);
            result = vec4(_695.x, _695.y, _695.z, result.w);
            break;
        }
        case 5:
        {
            highp vec3 _703 = max(Cs.xyz, Cb.xyz);
            result = vec4(_703.x, _703.y, _703.z, result.w);
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
            highp vec3 _763 = HardLight(param_18, param_19);
            result = vec4(_763.x, _763.y, _763.z, result.w);
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
            highp vec3 _798 = Difference(param_26, param_27);
            result = vec4(_798.x, _798.y, _798.z, result.w);
            break;
        }
        case 11:
        {
            highp vec3 param_28 = Cb.xyz;
            highp vec3 param_29 = Cs.xyz;
            highp vec3 _808 = Exclusion(param_28, param_29);
            result = vec4(_808.x, _808.y, _808.z, result.w);
            break;
        }
        case 12:
        {
            highp vec3 param_30 = Cb.xyz;
            highp vec3 param_31 = Cs.xyz;
            highp vec3 _818 = Hue(param_30, param_31);
            result = vec4(_818.x, _818.y, _818.z, result.w);
            break;
        }
        case 13:
        {
            highp vec3 param_32 = Cb.xyz;
            highp vec3 param_33 = Cs.xyz;
            highp vec3 _828 = Saturation(param_32, param_33);
            result = vec4(_828.x, _828.y, _828.z, result.w);
            break;
        }
        case 14:
        {
            highp vec3 param_34 = Cb.xyz;
            highp vec3 param_35 = Cs.xyz;
            highp vec3 _838 = Color(param_34, param_35);
            result = vec4(_838.x, _838.y, _838.z, result.w);
            break;
        }
        case 15:
        {
            highp vec3 param_36 = Cb.xyz;
            highp vec3 param_37 = Cs.xyz;
            highp vec3 _848 = Luminosity(param_36, param_37);
            result = vec4(_848.x, _848.y, _848.z, result.w);
            break;
        }
        default:
        {
            break;
        }
    }
    highp vec3 _865 = (Cs.xyz * (1.0 - Cb.w)) + (result.xyz * Cb.w);
    result = vec4(_865.x, _865.y, _865.z, result.w);
    result.w = Cs.w;
    highp vec3 _875 = result.xyz * result.w;
    result = vec4(_875.x, _875.y, _875.z, result.w);
    return Fragment(result);
}

void write_output(highp vec4 color)
{
    oFragColor = color;
}

void main()
{
    Fragment frag = mix_blend_brush_fs();
    highp vec4 param = frag.color;
    write_output(param);
}

