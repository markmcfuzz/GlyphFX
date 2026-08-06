// ----------------------------------------------------------------------------
// GlyphFX | fx/_numeric_counter.fxh
//
// Digit crop for the "Numeric" flag of shader_transparent_chicago and
// shader_transparent_generic - the ammo counters on weapon HUDs.
//
// ── WHY THIS EXISTS ──────────────────────────────────────────────────────────
// In the engine the counter's map is not one bitmap but a SEQUENCE of them:
// rasterizer_shader_transparent_chicago.c derives a `bitmap_data_index` from
// the ammo count and binds that element of the bitmap tag to map stage 0
// (rasterizer_shader_transparent_generic.c does the same).  A 3ds Max material
// has a single Texture2D per stage and no concept of bitmap sequences, so the
// viewport works from the source PLATE instead - the single image Tool slices
// the sequence out of - and crops the requested cell out of it here.
//
// ── PLATE LAYOUT ─────────────────────────────────────────────────────────────
// A Halo plate frames its cells with a solid background colour (pure blue) and
// marks sequence breaks with pure magenta; the top-left three pixels carry the
// background / sequence-divider / registration-point key colours.  None of it
// is content, so the crop has to exclude it.  Both plate shapes that show up
// in practice reduce to the same four numbers - which axis the digits run
// along, the margin framing the strip on that axis, the separator between
// cells, and the margin on the other axis:
//
//   numbers_horizontal_example.png   673 x 80   ->  10 cells of 64 x 64
//       margin 3   separator 3   side margin 8
//       3 + 10*64 + 9*3 + 3 = 673            8 + 64 + 8 = 80
//
//   numbers_vertical_example.png      34 x 660  ->  10 cells of 32 x 64
//       margin 1   separator 2   side margin 1
//       1 + 10*64 + 9*2 + 1 = 660            1 + 32 + 1 = 34
//
// Both were measured with a per-row / per-column plate-colour scan of the two
// files in shaders/resources/numbers_sequence_examples, not eyeballed.  Note
// the horizontal plate's leading margin only scans as 2 px because the cyan
// registration-point key pixel sits at (2, 0), inside the third margin column.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_NUMERIC_COUNTER_FXH
#define GLYPHFX_NUMERIC_COUNTER_FXH

// Cells per plate.  The tag's counter is decimal, so a plate holds 0-9.
#define GX_NUMERIC_PLATE_CELLS 10

// Crops one digit cell out of a plate and returns the UV to sample it with.
//
//   uv          the map stage's transformed UV, 0-1 across the digit quad
//   texSize     plate size in texels (from Texture2D.GetDimensions)
//   digit       0-9, which cell to show
//   layout      0 = auto (the plate's long axis), 1 = horizontal, 2 = vertical
//   margin      texels of plate before the first cell and after the last
//   separator   texels of plate between two cells
//   sideMargin  texels of plate on both sides across the strip
//   inset       texels trimmed off every cell edge (see the note below)
float2 NumericPlateUV(float2 uv, float2 texSize, int digit, int layout,
                      float margin, float separator, float sideMargin,
                      float inset)
{
    // Every step below divides by the plate size, so a size that never arrived
    // would turn the whole lookup into NaN and the surface would sample black -
    // invisible under the Add technique, which reads as "the shader is broken"
    // rather than "the size is missing".  Fall back to the uncropped UV so the
    // full plate shows instead: that is the tell that the size has to be typed
    // into the Plate Width / Plate Height parameters by hand.
    if (texSize.x < 1.0 || texSize.y < 1.0)
        return uv;

    // Auto picks the plate's long axis - a 10-cell strip is ~10:1 either way.
    bool horizontal = (layout == 1) || (layout == 0 && texSize.x >= texSize.y);

    float alongTotal  = horizontal ? texSize.x : texSize.y;
    float acrossTotal = horizontal ? texSize.y : texSize.x;

    // N cells framed by a margin at BOTH ends with N-1 separators between them.
    // Both margins are subtracted explicitly: folding the trailing one into the
    // separator count would make it cancel out of the cell's right edge, so the
    // closing border would stay visible no matter what the margin is set to.
    float alongCell  = (alongTotal - 2.0 * margin
                                   - separator * (GX_NUMERIC_PLATE_CELLS - 1))
                     / GX_NUMERIC_PLATE_CELLS;
    float acrossCell = acrossTotal - 2.0 * sideMargin;

    // If those numbers cannot describe a real cell - margins and separators
    // that do not fit inside the plate, or a size the viewport reported wrongly
    // - fall back to the uncropped UV.  Clamping to a 1-texel cell instead
    // would magnify a couple of texels into blocky noise, which looks like a
    // rendering bug rather than a configuration one.  Showing the whole plate
    // is the same tell as a missing size above.
    if (alongCell < 1.0 || acrossCell < 1.0)
        return uv;

    float index      = clamp(digit, 0, GX_NUMERIC_PLATE_CELLS - 1);
    float alongStart = margin + index * (alongCell + separator);

    float2 cellPixels = horizontal ? float2(alongCell,  acrossCell)
                                   : float2(acrossCell, alongCell);
    float2 cellOrigin = horizontal ? float2(alongStart, sideMargin)
                                   : float2(sideMargin, alongStart);

    // Wrap before cropping.  Map 1's own scale / offset / rotation can push the
    // UV well outside 0-1 (a 90 degree rotation alone lands it in -1..0), and
    // the uncropped path hands that to a Wrap sampler - so the cell has to wrap
    // the same way.  Clamping instead would collapse the whole quad onto one
    // edge column of the cell, which on a counter plate is empty.
    float2 local = frac(uv);

    // Bilinear filtering reaches half a texel past the cell edge and would pull
    // the plate's blue / magenta border into the digit, so keep the lookup
    // inside the cell.  Raise `inset` if a coloured fringe still shows up -
    // minified or mipped plates bleed from further away than half a texel.
    float2 edge = min(inset / cellPixels, 0.49);
    local = clamp(local, edge, 1.0 - edge);

    return (cellOrigin + local * cellPixels) / texSize;
}

#endif // GLYPHFX_NUMERIC_COUNTER_FXH
