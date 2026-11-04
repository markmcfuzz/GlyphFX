// ----------------------------------------------------------------------------
// GlyphFX | fx/_periodic.fxh
//
// Halo's periodic functions (the "function" enum of every animated tag field),
// ported from source/math/periodic_functions.c of the OpenCE decompile.
//
// The engine never evaluates these on the fly.  At startup it fills one
// 1024-entry byte table per function, normalised to [0,1] (except slide), and
// periodic_function_evaluate(f, t) reads it as:
//
//      index = t * 25.6     linear interpolation between index and index+1,
//                           wrapping at 1024 (slide also wraps in value)
//
// One table entry advances x by 0.027343748 (~28/1024), so over one period
// (t = 0..1, 25.6 entries) x covers 0.7: cosine and slide run 0.7 cycles per
// period, not 1.  That is the engine's behaviour and is kept here.
//
// Each entry is computed here from its formula instead of stored.  The trig is
// reduced to frac() of the exact table x, so the result matches the engine's
// byte tables except for a few entries that land one step (1/255) apart.
//
// Exact:        one, zero, cosine, diagonal wave, slide, jitter, wander.
// Approximated: the engine builds cosine/diagonal wave/slide (variable
//               period), noise and spark from real_random() with a fixed seed.
//               Until those tables are reproduced, the variable-period ones
//               use their fixed-period shape, noise a hash per entry and spark
//               slide squared (its shape over a fixed period).
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_PERIODIC_FXH
#define GLYPHFX_PERIODIC_FXH

// Function enum -> table shape.
//   0 cosine  1 slide  2 diagonal wave  3 jitter/wander  4 noise  5 spark
// "one" and "zero" never reach the table (entries 0 and 1 are unused).
static const int GX_PERIODIC_SHAPE[12] = { 0, 0, 0, 0, 2, 2, 1, 1, 4, 3, 3, 5 };

// Normalisation the engine applies: (value - min) / (max - min), from the
// min/max over the 1024 entries.  Range 0 = stored raw (slide).
static const float2 GX_PERIODIC_NORM[6] =
{
    float2(-1.0,        2.0),          // cosine
    float2( 0.0,        0.0),          // slide (raw)
    float2( 0.0,        0.99999952),   // diagonal wave
    float2(-1.8535528,  3.6323037),    // jitter / wander
    float2( 0.0,        1.0),          // noise (approximation)
    float2( 0.0,        0.99999905)    // spark (approximation)
};

static const float GX_TWO_PI = 6.28318531;

// Raw (un-normalised) value of table entry i.
float PeriodicTableRaw(int shape, int i)
{
    float x = (float)i * 0.027343748;

    [flatten] if (shape == 0)
        return cos(GX_TWO_PI * frac(x));

    float s = frac(x);
    [flatten] if (shape == 1)
        return s;
    [flatten] if (shape == 2)
        return s < 0.5 ? s * 2.0 : 1.0 - (s - 0.5) * 2.0;
    [flatten] if (shape == 3)
    {
        // cos(25.13x) cos(0.898x) + cos(43.98x) sin(1.571x), halved,
        // + sin(3.142x) cos(6.283x)  - every factor is a whole or simple
        // fraction of a cycle per x, so it reduces exactly.
        float fast = cos(GX_TWO_PI * frac(x * 4.0));
        float slow = cos(GX_TWO_PI * frac(x / 7.0));
        float c14  = cos(GX_TWO_PI * frac(x * 7.0));
        float s05  = sin(GX_TWO_PI * frac(x * 0.25));
        float s1   = sin(GX_TWO_PI * frac(x * 0.5));
        return (slow * fast + c14 * s05) * 0.5 + s1 * cos(GX_TWO_PI * s);
    }
    [flatten] if (shape == 4)
        return frac(sin((float)i * 12.9898) * 43758.5453);
    return s * s;
}

// Normalised, byte-quantised table entry, wrapped to the table size.
float PeriodicTableEntry(int shape, int i)
{
    float  raw = PeriodicTableRaw(shape, i & 1023);
    float2 nr  = GX_PERIODIC_NORM[shape];
    float  v   = nr.y != 0.0 ? (raw - nr.x) / nr.y : raw;
    return clamp(floor(v * 255.0), 0.0, 255.0) / 255.0;
}

// periodic_function_evaluate(function, time).  `time` is already divided by
// the period, so 1.0 = one period.
float PeriodicFunctionEvaluate(int function, float time)
{
    // "one", and the engine's fallback for an invalid type
    if (function <= 0 || function > 11) return 1.0;
    if (function == 1) return 0.0;   // zero

    int   shape    = GX_PERIODIC_SHAPE[function];
    float t        = time * 25.6;
    float fraction = fmod(t, 1.0);
    int   index    = (int)(t - fraction);

    float first  = PeriodicTableEntry(shape, index);
    float second = PeriodicTableEntry(shape, index + 1);

    if (shape == 1)
    {
        // slide wraps from 1 back to 0: interpolate across the seam
        if (first > 0.75 && second < 0.25) second += 1.0;
        float r = (1.0 - fraction) * first + second * fraction;
        return r > 1.0 ? r - 1.0 : r;
    }

    return saturate((1.0 - fraction) * first + second * fraction);
}

#endif // GLYPHFX_PERIODIC_FXH
