#version 150
// shader: composite YUV_TEXTURE_RECT
#define WR_FRAGMENT_SHADER
#define WR_MAX_VERTEX_TEXTURE_WIDTH 1024U
#define WR_FEATURE_YUV
#define WR_FEATURE_TEXTURE_RECT
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

// Composite a picture cache tile into the framebuffer.

/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

#ifdef WR_FEATURE_PIXEL_LOCAL_STORAGE
// For now, we need both extensions here, in order to initialize
// the PLS to the current framebuffer color. In future, we can
// possibly remove that requirement, or at least support the
// other framebuffer fetch extensions that provide the same
// functionality.
#extension GL_EXT_shader_pixel_local_storage : require
#extension GL_ARM_shader_framebuffer_fetch : require
#endif

#ifdef WR_FEATURE_TEXTURE_EXTERNAL
// Please check https://www.khronos.org/registry/OpenGL/extensions/OES/OES_EGL_image_external_essl3.txt
// for this extension.
#extension GL_OES_EGL_image_external_essl3 : require
#endif

#ifdef WR_FEATURE_ADVANCED_BLEND
#extension GL_KHR_blend_equation_advanced : require
#endif

#ifdef WR_FEATURE_DUAL_SOURCE_BLENDING
#ifdef GL_ES
#extension GL_EXT_blend_func_extended : require
#else
#extension GL_ARB_explicit_attrib_location : require
#endif
#endif

/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

#if defined(GL_ES)
    #if GL_ES == 1
        #ifdef GL_FRAGMENT_PRECISION_HIGH
        precision highp sampler2DArray;
        #else
        precision mediump sampler2DArray;
        #endif

        // Sampler default precision is lowp on mobile GPUs.
        // This causes RGBA32F texture data to be clamped to 16 bit floats on some GPUs (e.g. Mali-T880).
        // Define highp precision macro to allow lossless FLOAT texture sampling.
        #define HIGHP_SAMPLER_FLOAT highp

        // Default int precision in GLES 3 is highp (32 bits) in vertex shaders
        // and mediump (16 bits) in fragment shaders. If an int is being used as
        // a texel address in a fragment shader it, and therefore requires > 16
        // bits, it must be qualified with this.
        #define HIGHP_FS_ADDRESS highp

        // texelFetchOffset is buggy on some Android GPUs (see issue #1694).
        // Fallback to texelFetch on mobile GPUs.
        #define TEXEL_FETCH(sampler, position, lod, offset) texelFetch(sampler, position + offset, lod)
    #else
        #define HIGHP_SAMPLER_FLOAT
        #define HIGHP_FS_ADDRESS
        #define TEXEL_FETCH(sampler, position, lod, offset) texelFetchOffset(sampler, position, lod, offset)
    #endif
#else
    #define HIGHP_SAMPLER_FLOAT
    #define HIGHP_FS_ADDRESS
    #define TEXEL_FETCH(sampler, position, lod, offset) texelFetchOffset(sampler, position, lod, offset)
#endif

#ifdef WR_VERTEX_SHADER
    #ifdef SWGL
        // Annotate a vertex attribute as being flat per each drawn primitive instance.
        // SWGL can use this information to avoid redundantly loading the attribute in all SIMD lanes.
        #define PER_INSTANCE flat
    #else
        #define PER_INSTANCE
    #endif

    #define varying out
#endif

#ifdef WR_FRAGMENT_SHADER
    precision highp float;
    #define varying in
#endif

#if defined(WR_FEATURE_TEXTURE_EXTERNAL) || defined(WR_FEATURE_TEXTURE_RECT) || defined(WR_FEATURE_TEXTURE_2D)
#define TEX_SAMPLE(sampler, tex_coord) texture(sampler, tex_coord.xy)
#else
#define TEX_SAMPLE(sampler, tex_coord) texture(sampler, tex_coord)
#endif

//======================================================================================
// Vertex shader attributes and uniforms
//======================================================================================
#ifdef WR_VERTEX_SHADER
    // A generic uniform that shaders can optionally use to configure
    // an operation mode for this batch.
    uniform int uMode;

    // Uniform inputs
    uniform mat4 uTransform;       // Orthographic projection

    // Attribute inputs
    in vec2 aPosition;

    // get_fetch_uv is a macro to work around a macOS Intel driver parsing bug.
    // TODO: convert back to a function once the driver issues are resolved, if ever.
    // https://github.com/servo/webrender/pull/623
    // https://github.com/servo/servo/issues/13953
    // Do the division with unsigned ints because that's more efficient with D3D
    #define get_fetch_uv(i, vpi)  ivec2(int(vpi * (uint(i) % (WR_MAX_VERTEX_TEXTURE_WIDTH/vpi))), int(uint(i) / (WR_MAX_VERTEX_TEXTURE_WIDTH/vpi)))
#endif

//======================================================================================
// Fragment shader attributes and uniforms
//======================================================================================
#ifdef WR_FRAGMENT_SHADER
    // Uniform inputs

    #ifdef WR_FEATURE_PIXEL_LOCAL_STORAGE
        // Define the storage class of the pixel local storage.
        // If defined as writable, it's a compile time error to
        // have a normal fragment output variable declared.
        #if defined(PLS_READONLY)
            #define PLS_BLOCK __pixel_local_inEXT
        #elif defined(PLS_WRITEONLY)
            #define PLS_BLOCK __pixel_local_outEXT
        #else
            #define PLS_BLOCK __pixel_localEXT
        #endif

        // The structure of pixel local storage. Right now, it's
        // just the current framebuffer color. In future, we have
        // (at least) 12 bytes of space we can store extra info
        // here (such as clip mask values).
        PLS_BLOCK FrameBuffer {
            layout(rgba8) highp vec4 color;
        } PLS;

        #ifndef PLS_READONLY
        // Write the output of a fragment shader to PLS. Applies
        // premultipled alpha blending by default, since the blender
        // is disabled when PLS is active.
        // TODO(gw): Properly support alpha blend mode for webgl / canvas.
        void write_output(vec4 color) {
            PLS.color = color + PLS.color * (1.0 - color.a);
        }

        // Write a raw value straight to PLS, if the fragment shader has
        // already applied blending.
        void write_output_raw(vec4 color) {
            PLS.color = color;
        }
        #endif

        #ifndef PLS_WRITEONLY
        // Retrieve the current framebuffer color. Useful in conjunction with
        // the write_output_raw function.
        vec4 get_current_framebuffer_color() {
            return PLS.color;
        }
        #endif
    #else
        // Fragment shader outputs
        #ifdef WR_FEATURE_ADVANCED_BLEND
            layout(blend_support_all_equations) out;
        #endif

        #ifdef WR_FEATURE_DUAL_SOURCE_BLENDING
            layout(location = 0, index = 0) out vec4 oFragColor;
            layout(location = 0, index = 1) out vec4 oFragBlend;
        #else
            out vec4 oFragColor;
        #endif

        // Write an output color in normal (non-PLS) shaders.
        void write_output(vec4 color) {
            oFragColor = color;
        }
    #endif

    #define EPSILON                     0.0001

    // "Show Overdraw" color. Premultiplied.
    #define WR_DEBUG_OVERDRAW_COLOR     vec4(0.110, 0.077, 0.027, 0.125)

    float distance_to_line(vec2 p0, vec2 perp_dir, vec2 p) {
        vec2 dir_to_p0 = p0 - p;
        return dot(normalize(perp_dir), dir_to_p0);
    }

    /// Find the appropriate half range to apply the AA approximation over.
    /// This range represents a coefficient to go from one CSS pixel to half a device pixel.
    float compute_aa_range(vec2 position) {
        // The constant factor is chosen to compensate for the fact that length(fw) is equal
        // to sqrt(2) times the device pixel ratio in the typical case. 0.5/sqrt(2) = 0.35355.
        //
        // This coefficient is chosen to ensure that any sample 0.5 pixels or more inside of
        // the shape has no anti-aliasing applied to it (since pixels are sampled at their center,
        // such a pixel (axis aligned) is fully inside the border). We need this so that antialiased
        // curves properly connect with non-antialiased vertical or horizontal lines, among other things.
        //
        // Lines over a half-pixel away from the pixel center *can* intersect with the pixel square;
        // indeed, unless they are horizontal or vertical, they are guaranteed to. However, choosing
        // a nonzero area for such pixels causes noticeable artifacts at the junction between an anti-
        // aliased corner and a straight edge.
        //
        // We may want to adjust this constant in specific scenarios (for example keep the principled
        // value for straight edges where we want pixel-perfect equivalence with non antialiased lines
        // when axis aligned, while selecting a larger and smoother aa range on curves).
        return 0.35355 * length(fwidth(position));
    }

    /// Return the blending coefficient for distance antialiasing.
    ///
    /// 0.0 means inside the shape, 1.0 means outside.
    ///
    /// This cubic polynomial approximates the area of a 1x1 pixel square under a
    /// line, given the signed Euclidean distance from the center of the square to
    /// that line. Calculating the *exact* area would require taking into account
    /// not only this distance but also the angle of the line. However, in
    /// practice, this complexity is not required, as the area is roughly the same
    /// regardless of the angle.
    ///
    /// The coefficients of this polynomial were determined through least-squares
    /// regression and are accurate to within 2.16% of the total area of the pixel
    /// square 95% of the time, with a maximum error of 3.53%.
    ///
    /// See the comments in `compute_aa_range()` for more information on the
    /// cutoff values of -0.5 and 0.5.
    float distance_aa(float aa_range, float signed_distance) {
        float dist = 0.5 * signed_distance / aa_range;
        if (dist <= -0.5 + EPSILON)
            return 1.0;
        if (dist >= 0.5 - EPSILON)
            return 0.0;
        return 0.5 + dist * (0.8431027 * dist * dist - 1.14453603);
    }

    /// Component-wise selection.
    ///
    /// The idea of using this is to ensure both potential branches are executed before
    /// selecting the result, to avoid observable timing differences based on the condition.
    ///
    /// Example usage: color = if_then_else(LessThanEqual(color, vec3(0.5)), vec3(0.0), vec3(1.0));
    ///
    /// The above example sets each component to 0.0 or 1.0 independently depending on whether
    /// their values are below or above 0.5.
    ///
    /// This is written as a macro in order to work with vectors of any dimension.
    ///
    /// Note: Some older android devices don't support mix with bvec. If we ever run into them
    /// the only option we have is to polyfill it with a branch per component.
    #define if_then_else(cond, then_branch, else_branch) mix(else_branch, then_branch, cond)
#endif

//======================================================================================
// Shared shader uniforms
//======================================================================================
#ifdef WR_FEATURE_TEXTURE_2D
uniform sampler2D sColor0;
uniform sampler2D sColor1;
uniform sampler2D sColor2;
#elif defined WR_FEATURE_TEXTURE_RECT
uniform sampler2DRect sColor0;
uniform sampler2DRect sColor1;
uniform sampler2DRect sColor2;
#elif defined WR_FEATURE_TEXTURE_EXTERNAL
uniform samplerExternalOES sColor0;
uniform samplerExternalOES sColor1;
uniform samplerExternalOES sColor2;
#else
uniform sampler2DArray sColor0;
uniform sampler2DArray sColor1;
uniform sampler2DArray sColor2;
#endif

#ifdef WR_FEATURE_DITHERING
uniform sampler2D sDither;
#endif

//======================================================================================
// Interpolator definitions
//======================================================================================

//======================================================================================
// VS only types and UBOs
//======================================================================================

//======================================================================================
// VS only functions
//======================================================================================
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

// shared is already included

#define YUV_FORMAT_NV12             0
#define YUV_FORMAT_PLANAR           1
#define YUV_FORMAT_INTERLEAVED      2

#ifdef WR_VERTEX_SHADER

#ifdef WR_FEATURE_TEXTURE_RECT
    #define TEX_SIZE(sampler) vec2(1.0)
#else
    #define TEX_SIZE(sampler) vec2(textureSize(sampler, 0).xy)
#endif

#define YUV_COLOR_SPACE_REC601      0
#define YUV_COLOR_SPACE_REC709      1
#define YUV_COLOR_SPACE_REC2020     2

// The constants added to the Y, U and V components are applied in the fragment shader.

// From Rec601:
// [R]   [1.1643835616438356,  0.0,                 1.5960267857142858   ]   [Y -  16]
// [G] = [1.1643835616438358, -0.3917622900949137, -0.8129676472377708   ] x [U - 128]
// [B]   [1.1643835616438356,  2.017232142857143,   8.862867620416422e-17]   [V - 128]
//
// For the range [0,1] instead of [0,255].
//
// The matrix is stored in column-major.
const mat3 YuvColorMatrixRec601 = mat3(
    1.16438,  1.16438, 1.16438,
    0.0,     -0.39176, 2.01723,
    1.59603, -0.81297, 0.0
);

// From Rec709:
// [R]   [1.1643835616438356,  0.0,                    1.7927410714285714]   [Y -  16]
// [G] = [1.1643835616438358, -0.21324861427372963,   -0.532909328559444 ] x [U - 128]
// [B]   [1.1643835616438356,  2.1124017857142854,     0.0               ]   [V - 128]
//
// For the range [0,1] instead of [0,255]:
//
// The matrix is stored in column-major.
const mat3 YuvColorMatrixRec709 = mat3(
    1.16438,  1.16438,  1.16438,
    0.0    , -0.21325,  2.11240,
    1.79274, -0.53291,  0.0
);

// From Re2020:
// [R]   [1.16438356164384,  0.0,                    1.678674107142860 ]   [Y -  16]
// [G] = [1.16438356164384, -0.187326104219343,     -0.650424318505057 ] x [U - 128]
// [B]   [1.16438356164384,  2.14177232142857,       0.0               ]   [V - 128]
//
// For the range [0,1] instead of [0,255]:
//
// The matrix is stored in column-major.
const mat3 YuvColorMatrixRec2020 = mat3(
    1.16438356164384 ,  1.164383561643840,  1.16438356164384,
    0.0              , -0.187326104219343,  2.14177232142857,
    1.67867410714286 , -0.650424318505057,  0.0
);

mat3 get_yuv_color_matrix(int color_space) {
    switch (color_space) {
        case YUV_COLOR_SPACE_REC601:
            return YuvColorMatrixRec601;
        case YUV_COLOR_SPACE_REC709:
            return YuvColorMatrixRec709;
        default:
            return YuvColorMatrixRec2020;
    }
}

void write_uv_rect(
    vec2 uv0,
    vec2 uv1,
    float layer,
    vec2 f,
    vec2 texture_size,
    out vec3 uv,
    out vec4 uv_bounds
) {
    uv.xy = mix(uv0, uv1, f);
    uv.z = layer;

    uv_bounds = vec4(uv0 + vec2(0.5), uv1 - vec2(0.5));

    #ifndef WR_FEATURE_TEXTURE_RECT
        uv.xy /= texture_size;
        uv_bounds /= texture_size.xyxy;
    #endif
}
#endif

#ifdef WR_FRAGMENT_SHADER

vec4 sample_yuv(
    int format,
    mat3 yuv_color_matrix,
    float coefficient,
    vec3 in_uv_y,
    vec3 in_uv_u,
    vec3 in_uv_v,
    vec4 uv_bounds_y,
    vec4 uv_bounds_u,
    vec4 uv_bounds_v
) {
    vec3 yuv_value;

    switch (format) {
        case YUV_FORMAT_PLANAR:
            {
                // The yuv_planar format should have this third texture coordinate.
                vec2 uv_y = clamp(in_uv_y.xy, uv_bounds_y.xy, uv_bounds_y.zw);
                vec2 uv_u = clamp(in_uv_u.xy, uv_bounds_u.xy, uv_bounds_u.zw);
                vec2 uv_v = clamp(in_uv_v.xy, uv_bounds_v.xy, uv_bounds_v.zw);
                yuv_value.x = TEX_SAMPLE(sColor0, vec3(uv_y, in_uv_y.z)).r;
                yuv_value.y = TEX_SAMPLE(sColor1, vec3(uv_u, in_uv_u.z)).r;
                yuv_value.z = TEX_SAMPLE(sColor2, vec3(uv_v, in_uv_v.z)).r;
            }
            break;

        case YUV_FORMAT_NV12:
            {
                vec2 uv_y = clamp(in_uv_y.xy, uv_bounds_y.xy, uv_bounds_y.zw);
                vec2 uv_uv = clamp(in_uv_u.xy, uv_bounds_u.xy, uv_bounds_u.zw);
                yuv_value.x = TEX_SAMPLE(sColor0, vec3(uv_y, in_uv_y.z)).r;
                yuv_value.yz = TEX_SAMPLE(sColor1, vec3(uv_uv, in_uv_u.z)).rg;
            }
            break;

        case YUV_FORMAT_INTERLEAVED:
            {
                // "The Y, Cb and Cr color channels within the 422 data are mapped into
                // the existing green, blue and red color channels."
                // https://www.khronos.org/registry/OpenGL/extensions/APPLE/APPLE_rgb_422.txt
                vec2 uv_y = clamp(in_uv_y.xy, uv_bounds_y.xy, uv_bounds_y.zw);
                yuv_value = TEX_SAMPLE(sColor0, vec3(uv_y, in_uv_y.z)).gbr;
            }
            break;

        default:
            yuv_value = vec3(0.0);
            break;
    }

    // See the YuvColorMatrix definition for an explanation of where the constants come from.
    vec3 rgb = yuv_color_matrix * (yuv_value * coefficient - vec3(0.06275, 0.50196, 0.50196));
    vec4 color = vec4(rgb, 1.0);

    return color;
}
#endif

#ifdef WR_FEATURE_YUV
flat varying mat3 vYuvColorMatrix;
flat varying float vYuvCoefficient;
flat varying int vYuvFormat;
varying vec3 vUV_y;
varying vec3 vUV_u;
varying vec3 vUV_v;
flat varying vec4 vUVBounds_y;
flat varying vec4 vUVBounds_u;
flat varying vec4 vUVBounds_v;
#else
flat varying vec4 vColor;
flat varying float vLayer;
varying vec2 vUv;
#endif

#ifdef WR_VERTEX_SHADER
PER_INSTANCE in vec4 aDeviceRect;
PER_INSTANCE in vec4 aDeviceClipRect;
PER_INSTANCE in vec4 aColor;
PER_INSTANCE in vec4 aParams;
PER_INSTANCE in vec3 aTextureLayers;

#ifdef WR_FEATURE_YUV
PER_INSTANCE in vec4 aUvRect0;
PER_INSTANCE in vec4 aUvRect1;
PER_INSTANCE in vec4 aUvRect2;
#endif

void main(void) {
	// Get world position
    vec2 world_pos = aDeviceRect.xy + aPosition.xy * aDeviceRect.zw;

    // Clip the position to the world space clip rect
    vec2 clipped_world_pos = clamp(world_pos, aDeviceClipRect.xy, aDeviceClipRect.xy + aDeviceClipRect.zw);

    // Derive the normalized UV from the clipped vertex position
    vec2 uv = (clipped_world_pos - aDeviceRect.xy) / aDeviceRect.zw;

#ifdef WR_FEATURE_YUV
    int yuv_color_space = int(aParams.y);
    int yuv_format = int(aParams.z);
    float yuv_coefficient = aParams.w;

    vYuvColorMatrix = get_yuv_color_matrix(yuv_color_space);
    vYuvCoefficient = yuv_coefficient;
    vYuvFormat = yuv_format;

    write_uv_rect(
        aUvRect0.xy,
        aUvRect0.zw,
        aTextureLayers.x,
        uv,
        TEX_SIZE(sColor0),
        vUV_y,
        vUVBounds_y
    );
    write_uv_rect(
        aUvRect1.xy,
        aUvRect1.zw,
        aTextureLayers.y,
        uv,
        TEX_SIZE(sColor1),
        vUV_u,
        vUVBounds_u
    );
    write_uv_rect(
        aUvRect2.xy,
        aUvRect2.zw,
        aTextureLayers.z,
        uv,
        TEX_SIZE(sColor2),
        vUV_v,
        vUVBounds_v
    );
#else
    vUv = uv;
    // Pass through color and texture array layer
    vColor = aColor;
    vLayer = aTextureLayers.x;
#endif

    gl_Position = uTransform * vec4(clipped_world_pos, aParams.x /* z_id */, 1.0);
}
#endif

#ifdef WR_FRAGMENT_SHADER
void main(void) {
#ifdef WR_FEATURE_YUV
    vec4 color = sample_yuv(
        vYuvFormat,
        vYuvColorMatrix,
        vYuvCoefficient,
        vUV_y,
        vUV_u,
        vUV_v,
        vUVBounds_y,
        vUVBounds_u,
        vUVBounds_v
    );
#else
    // The color is just the texture sample modulated by a supplied color
	vec4 texel = textureLod(sColor0, vec3(vUv, vLayer), 0.0);
    vec4 color = vColor * texel;
#endif
	write_output(color);
}
#endif
