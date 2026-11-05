// ----------------------------------------------------------------------------
// GlyphFX | fx/_coverage.fxh
//
// Coverage solve for framebuffer blends that Nitrous cannot do.
//
// Nitrous ignores every blend state (see shader_transparent_water.psh for the
// full story), so a transparent surface can only decide per pixel whether it
// covers the background: a dither either writes the pixel opaque or drops it.
// Over a neighbourhood the framebuffer then resolves to
//
//      out = coverage * written + (1 - coverage) * background
//
// The engine's blend is  out = background * Cmul + Cadd  (Add: Cmul = 1,
// Cadd = color; Multiply: Cmul = color, Cadd = 0).  With E an estimate of the
// background brightness, that target is reached for ANY coverage by
//
//      written = residual / coverage + E,   residual = E * (Cmul - 1) + Cadd
//
// The smallest coverage that keeps `written` inside [0,1] is the least that
// still reproduces the full brightness.  `amount` scales that floor (1 = exact,
// above 1 = more see-through but dimmer, below 1 = more coverage and less
// grain), `maxOpacity` caps it, `saturation` pushes the written colour's
// chroma back up (adding E washes it toward grey).
//
// A dither shows the real background only on the pixels it drops, so even the
// exact solve keeps just (1 - coverage) of the background's contrast, where a
// real additive blend keeps all of it.  More see-through costs brightness.
//
// Unlike drawing the colour opaque with luminance as coverage, this keeps the
// average brightness right: a dim additive colour still lifts the whole area
// it covers instead of only showing up on a few scattered pixels.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_COVERAGE_FXH
#define GLYPHFX_COVERAGE_FXH

struct BlendCoverage
{
    float3 color;      // what to write where the surface covers
    float  coverage;   // how much of the pixel it covers
};

BlendCoverage ResolveBlendCoverage(float3 Cmul, float3 Cadd, float background,
                                   float amount, float maxOpacity, float saturation)
{
    BlendCoverage c;

    float  E        = clamp(background, 0.05, 0.95);
    float3 residual = E * (Cmul - 1.0) + Cadd;

    // Smallest coverage whose written colour still fits in [0,1]
    float needDark   = max(-min(min(residual.r, residual.g), residual.b), 0.0) / E;
    float needBright = max( max(max(residual.r, residual.g), residual.b), 0.0) / (1.0 - E);
    float floorCov   = max(needDark, needBright);

    // Scaling the floor (not blending it toward 1) keeps pixels that contribute
    // nothing at zero coverage, so the surface edges still vanish.
    float cov  = min(floorCov / max(amount, 0.125), maxOpacity);
    c.coverage = saturate(cov);

    // Below the floor (amount > 1 or the MaxOpacity cap) the written colour no
    // longer fits in [0,1].  Scale the whole offset from E down instead of
    // clipping channel by channel: clipping only the dominant channel shifts
    // the hue (orange turned yellow-green), scaling keeps it and just dims.
    float3 d  = residual / max(c.coverage, 0.0001);
    float  hi = max(max(d.r, d.g), d.b);
    float  lo = min(min(d.r, d.g), d.b);
    float  k  = 1.0;
    if (hi > 1.0 - E) k = min(k, (1.0 - E) / hi);
    if (lo < -E)      k = min(k, E / -lo);
    float3 col = d * k + E;

    float  lum = dot(col, float3(0.299, 0.587, 0.114));
    col        = lum + (col - lum) * saturation;
    c.color    = saturate(col);

    return c;
}

// Framebuffer Blend Function (tag enum) -> the blend the viewport draws.
//   0 alpha blend, 1 multiply, 2 double multiply, 3 add: as in the tag.
//   4 subtract, 5 component min: darken -> multiply.
//   6 component max: brightens -> add.
//   7 alpha-multiply add: -> alpha blend.
static const int GX_VIEWPORT_BLEND[8] = { 0, 1, 2, 3, 1, 1, 3, 0 };

int ViewportBlendMode(int framebufferBlendFunction)
{
    return GX_VIEWPORT_BLEND[clamp(framebufferBlendFunction, 0, 7)];
}

// Screen-space hash threshold, the same one the other transparent shaders use.
// Dividing by w makes it shift under Nitrous's sub-pixel jitter, so the grain
// averages out once the camera stops.
float CoverageThreshold(float4 clipPos)
{
    float2 screenUV = clipPos.xy / clipPos.w;
    return frac(sin(dot(screenUV, float2(12.9898, 78.233))) * 43758.5453);
}

#endif // GLYPHFX_COVERAGE_FXH
