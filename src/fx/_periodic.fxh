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
// The tables, including the random ones (variable period, noise, spark), are
// rebuilt with the engine's random seed by tools/gen_periodic_tables.py into
// _periodic_tables.fxh.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_PERIODIC_FXH
#define GLYPHFX_PERIODIC_FXH

#include "_periodic_tables.fxh"

// Byte i (0-1023) of stored table `table`, as 0-1.
float PeriodicTableEntry(int table, int i)
{
    uint  word  = (uint)table * 256u + ((uint)i >> 2);
    uint4 quad  = GX_PERIODIC_TABLES[word >> 2];
    uint  slot  = word & 3u;
    uint  bytes = slot == 0u ? quad.x : slot == 1u ? quad.y : slot == 2u ? quad.z : quad.w;
    return (float)((bytes >> (((uint)i & 3u) * 8u)) & 0xFFu) / 255.0;
}

// periodic_function_evaluate(function, time).  `time` is already divided by
// the period, so 1.0 = one period.
float PeriodicFunctionEvaluate(int function, float time)
{
    // "one", and the engine's fallback for an invalid type
    if (function <= 0 || function > 11) return 1.0;
    if (function == 1) return 0.0;   // zero

    int   table    = GX_PERIODIC_TABLE_OF[function];
    float t        = time * 25.6;
    float fraction = fmod(t, 1.0);
    int   index    = (int)(t - fraction);

    float first  = PeriodicTableEntry(table, index & 1023);
    float second = PeriodicTableEntry(table, (index + 1) & 1023);

    if (function == 6 || function == 7)
    {
        // slide wraps from 1 back to 0: interpolate across the seam
        if (first > 0.75 && second < 0.25) second += 1.0;
        float r = (1.0 - fraction) * first + second * fraction;
        return r > 1.0 ? r - 1.0 : r;
    }

    return saturate((1.0 - fraction) * first + second * fraction);
}

#endif // GLYPHFX_PERIODIC_FXH
