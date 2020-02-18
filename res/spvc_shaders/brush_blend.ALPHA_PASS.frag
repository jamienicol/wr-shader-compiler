#version 300 es
precision mediump float;
precision highp int;

struct Fragment
{
    highp vec4 color;
};

uniform highp sampler2D sGpuCache;
uniform highp sampler2DArray sPrevPassAlpha;
uniform highp sampler2DArray sColor0;
uniform highp sampler2DArray sColor1;
uniform highp sampler2DArray sColor2;
uniform highp sampler2DArray sPrevPassColor;

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

highp vec3 Contrast(highp vec3 Cs, highp float amount)
{
    return ((Cs * amount) - vec3(0.5 * amount)) + vec3(0.5);
}

highp vec3 Invert(highp vec3 Cs, highp float amount)
{
    return mix(Cs, vec3(1.0) - Cs, vec3(amount));
}

highp vec3 Brightness(highp vec3 Cs, highp float amount)
{
    return clamp(Cs * amount, vec3(0.0), vec3(1.0));
}

highp vec3 SrgbToLinear(highp vec3 color)
{
    highp vec3 c1 = color / vec3(12.9200000762939453125);
    highp vec3 c2 = pow((color / vec3(1.05499994754791259765625)) + vec3(0.0521326996386051177978515625), vec3(2.400000095367431640625));
    bvec3 _348 = lessThanEqual(color, vec3(0.040449999272823333740234375));
    return vec3(_348.x ? c1.x : c2.x, _348.y ? c1.y : c2.y, _348.z ? c1.z : c2.z);
}

highp vec3 LinearToSrgb(highp vec3 color)
{
    highp vec3 c1 = color * 12.9200000762939453125;
    highp vec3 c2 = (vec3(1.05499994754791259765625) * pow(color, vec3(0.4166666567325592041015625))) - vec3(0.054999999701976776123046875);
    bvec3 _370 = lessThanEqual(color, vec3(0.003130800090730190277099609375));
    return vec3(_370.x ? c1.x : c2.x, _370.y ? c1.y : c2.y, _370.z ? c1.z : c2.z);
}

mediump ivec2 get_gpu_cache_uv(int address)
{
    return ivec2(int(uint(address) % 1024u), int(uint(address) / 1024u));
}

highp vec4 fetch_from_gpu_cache_1(int address)
{
    int param = address;
    mediump ivec2 uv = get_gpu_cache_uv(param);
    return texelFetch(sGpuCache, uv, 0);
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
                int param = (flat_varying_ivec4_0.y + offset) + (k / 4);
                texel = fetch_from_gpu_cache_1(param);
                colora[i] = clamp(texel[k % 4], 0.0, 1.0);
                offset += 64;
                break;
            }
            case 3:
            {
                int param_1 = flat_varying_ivec4_0.y + offset;
                texel = fetch_from_gpu_cache_1(param_1);
                colora[i] = clamp((texel.x * colora[i]) + texel.y, 0.0, 1.0);
                offset++;
                break;
            }
            case 4:
            {
                int param_2 = flat_varying_ivec4_0.y + offset;
                texel = fetch_from_gpu_cache_1(param_2);
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

highp float point_inside_rect(highp vec2 p, highp vec2 p0, highp vec2 p1)
{
    highp vec2 s = step(p0, p) - step(p1, p);
    return s.x * s.y;
}

highp float signed_distance_rect(highp vec2 pos, highp vec2 p0, highp vec2 p1)
{
    highp vec2 d = max(p0 - pos, pos - p1);
    return length(max(vec2(0.0), d)) + min(0.0, max(d.x, d.y));
}

highp float compute_aa_range(highp vec2 position)
{
    return 0.3535499870777130126953125 * length(fwidth(position));
}

highp float distance_aa(highp float aa_range, highp float signed_distance)
{
    highp float dist = (0.5 * signed_distance) / aa_range;
    if (dist <= (-0.4999000132083892822265625))
    {
        return 1.0;
    }
    if (dist >= 0.4999000132083892822265625)
    {
        return 0.0;
    }
    return 0.5 + (dist * (((0.8431026935577392578125 * dist) * dist) - 1.14453601837158203125));
}

highp float init_transform_fs(highp vec2 local_pos)
{
    highp vec2 param = local_pos;
    highp vec2 param_1 = vTransformBounds.xy;
    highp vec2 param_2 = vTransformBounds.zw;
    highp float d = signed_distance_rect(param, param_1, param_2);
    highp vec2 param_3 = local_pos;
    highp float aa_range = compute_aa_range(param_3);
    highp float param_4 = aa_range;
    highp float param_5 = d;
    return distance_aa(param_4, param_5);
}

Fragment blend_brush_fs()
{
    highp float perspective_divisor = mix(gl_FragCoord.w, 1.0, flat_varying_vec4_4.y);
    highp vec2 uv = varying_vec4_0.zw * perspective_divisor;
    highp vec4 Cs = texture(sColor0, vec3(uv, flat_varying_vec4_4.x));
    highp float alpha = Cs.w;
    highp vec3 _513;
    if (alpha != 0.0)
    {
        _513 = Cs.xyz / vec3(alpha);
    }
    else
    {
        _513 = Cs.xyz;
    }
    highp vec3 color = _513;
    switch (flat_varying_ivec4_0.x)
    {
        case 0:
        {
            highp vec3 param = color;
            highp float param_1 = flat_varying_vec4_4.z;
            color = Contrast(param, param_1);
            break;
        }
        case 3:
        {
            highp vec3 param_2 = color;
            highp float param_3 = flat_varying_vec4_4.z;
            color = Invert(param_2, param_3);
            break;
        }
        case 6:
        {
            highp vec3 param_4 = color;
            highp float param_5 = flat_varying_vec4_4.z;
            color = Brightness(param_4, param_5);
            break;
        }
        case 8:
        {
            highp vec3 param_6 = color;
            color = SrgbToLinear(param_6);
            break;
        }
        case 9:
        {
            highp vec3 param_7 = color;
            color = LinearToSrgb(param_7);
            break;
        }
        case 11:
        {
            highp vec4 colora = vec4(color, alpha);
            highp vec4 param_8 = colora;
            highp vec4 _574 = ComponentTransfer(param_8);
            colora = _574;
            color = colora.xyz;
            alpha = colora.w;
            break;
        }
        case 10:
        {
            color = flat_varying_vec4_1.xyz;
            alpha = flat_varying_vec4_1.w;
            break;
        }
        default:
        {
            highp vec4 result = (vColorMat * vec4(color, alpha)) + flat_varying_vec4_3;
            result = clamp(result, vec4(0.0), vec4(1.0));
            color = result.xyz;
            alpha = result.w;
            break;
        }
    }
    highp vec2 param_9 = uv;
    highp vec2 param_10 = flat_varying_vec4_2.xy;
    highp vec2 param_11 = flat_varying_vec4_2.zw;
    highp vec2 param_12 = varying_vec4_0.xy;
    alpha *= min(point_inside_rect(param_9, param_10, param_11), init_transform_fs(param_12));
    return Fragment(vec4(color, 1.0) * alpha);
}

highp float do_clip()
{
    if (all(equal(vClipMaskUvBounds.xy, vClipMaskUvBounds.zw)))
    {
        return 1.0;
    }
    highp vec2 mask_uv = vClipMaskUv.xy * gl_FragCoord.w;
    bvec2 left = lessThanEqual(vClipMaskUvBounds.xy, mask_uv);
    bvec2 right = greaterThan(vClipMaskUvBounds.zw, mask_uv);
    if (!all(bvec4(left, right)))
    {
        return 0.0;
    }
    mediump ivec3 tc = ivec3(ivec2(mask_uv), int(vClipMaskUv.z + 0.5));
    return texelFetch(sPrevPassAlpha, tc, 0).x;
}

void write_output(highp vec4 color)
{
    oFragColor = color;
}

void main()
{
    Fragment frag = blend_brush_fs();
    highp float clip_alpha = do_clip();
    frag.color *= clip_alpha;
    highp vec4 param = frag.color;
    write_output(param);
}

