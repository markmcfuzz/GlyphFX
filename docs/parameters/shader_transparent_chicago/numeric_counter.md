# Numeric Counter Plate

Applies to **`shader_transparent_chicago`** and **`shader_transparent_generic`** — both expose the
same parameters and behave identically.

The `Numeric` flag marks a shader as an ammo / countdown counter, the kind used for the bullet
readout on a weapon's HUD plate. In the engine the counter's **Map 1 is not a single bitmap** — it is
a *sequence* of them inside one bitmap tag, and the renderer picks which element to bind from the
ammo count (`rasterizer_shader_transparent_chicago.c` derives a `bitmap_data_index`, then binds that
element to map stage 0).

A 3ds Max material has one `Texture2D` per map stage and no concept of bitmap sequences, so there is
nothing to switch between. The viewport instead takes the **source plate** — the single image Tool
sliced the sequence out of, holding all ten digits — and crops the requested cell out of it in the
pixel shader.

> [!NOTE]
> The crop only runs while `Numeric` is checked. With it off, Map 1 is sampled normally and every
> parameter below is ignored.

---

### Plate Anatomy

A Halo plate frames its cells with a solid **pure blue** background and marks sequence breaks with
**pure magenta**; the top-left three pixels carry the background / sequence-divider /
registration-point key colours. None of that is content, so the crop excludes it.

```
horizontal plate                     vertical plate

 <-M->   <-S->                        +--+
+-----+-+-----+-+-----+ --+          +|00|+  <- M
| 0   | | 1   | | 2   |   | side     +--+
|     | |     | |     |   | margin   |  |    <- S
+-----+-+-----+-+-----+ --+          +--+
                                     +|11|+
   M = plate margin                  +--+
   S = plate separator                ^^
                                    side margin
```

Whatever the shape, the layout comes down to four numbers: **which axis the digits run along**, the
**margin** framing the strip at both ends of that axis, the **separator** between two cells, and the
**side margin** across the strip.

---

### Reference Plates

Both example plates in `shaders/resources/numbers_sequence_examples` were measured with a per-row /
per-column plate-colour scan:

| Plate | Size | Cell | Layout | Plate Margin | Plate Separator | Plate Side Margin |
|---|---|---|---|---|---|---|
| `numbers_horizontal_example.png` | 673 x 80 | 64 x 64 | Horizontal | 3 | 3 | 8 |
| `numbers_vertical_example.png` | 34 x 660 | 32 x 64 | Vertical | 1 | 2 | 1 |

The numbers have to add up exactly, which is a quick way to check a new plate:

```
horizontal   3 + 10*64 + 9*3 + 3 = 673        8 + 64 + 8  = 80
vertical     1 + 10*64 + 9*2 + 1 = 660        1 + 32 + 1  = 34
```

> [!TIP]
> Scanning the horizontal plate makes its leading margin look like 2 px rather than 3. It is 3 — the
> cyan registration-point key pixel sits at (2, 0), inside the third margin column, so that column
> is not uniformly plate-coloured even though it is still margin.

---

### Parameters

All of these are **GlyphFX-only**; none of them exist in the tag.

| Parameter | Widget | Default | Meaning |
|---|---|---|---|
| Numeric Digit | slider 0-9 | 0 | Which cell to show. One digit per material — a three-digit counter is three quads with three materials. |
| Plate Layout | spinner 0-2 | 0 (Auto) | Axis the digits run along. `0` = Auto, `1` = Horizontal, `2` = Vertical. |
| Plate Width | spinner | 0 | Plate width in texels. `0` reads it off the bound texture. |
| Plate Height | spinner | 0 | Plate height in texels. `0` reads it off the bound texture. |
| Plate Margin | slider 0-32 | 3 | Texels of plate before the first digit and after the last one. |
| Plate Separator | slider 0-32 | 3 | Texels of plate between two digits. |
| Plate Side Margin | slider 0-32 | 8 | Texels of plate on both sides across the strip. |
| Plate Cell Edge Inset | slider 0-4 | 0.5 | Texels trimmed off every cell edge. |

**Auto layout** picks the plate's long axis, which is right for both reference plates (a ten-cell
strip is roughly 10:1 either way). Set it explicitly only for a plate that is close to square.

**Plate Width / Plate Height** normally stay at 0, in which case the shader asks the bound texture
for its own size. 3ds Max does not always hand a texture's dimensions to the effect, and the shader
has no way to tell a missing size from a real one — so if the crop refuses to work, type the plate's
real pixel size into these two fields. See *Troubleshooting* below.

**Plate Cell Edge Inset** exists because bilinear filtering reaches half a texel past the cell edge
and would otherwise pull the blue / magenta border into the digit. Half a texel is enough head-on;
raise it if a coloured fringe shows up when the counter is minified or seen at a grazing angle,
where mipping bleeds from further away.

The defaults match the horizontal reference plate. Switching to the vertical one is three values —
margin `1`, separator `2`, side margin `1` — since Auto already handles the axis.

---

### Troubleshooting

**The whole plate still shows with `Numeric` on.** The shader could not get a plate size, so it
skipped the crop rather than dividing by zero. Type the plate's pixel size into **Plate Width** and
**Plate Height** and it will crop.

**A digit shows, but the wrong one, or a sliver of two.** The margin / separator / side margin do not
add up for this plate. Check them against the arithmetic in the *Reference Plates* section above —
the totals have to land exactly on the plate's pixel size.

**It works in one 3ds Max version and not another.** Reading a texture's size from the shader is the
only part of the crop that depends on the host, so a version that reports it differently — or that
loads the bitmap at a reduced or padded resolution — throws the crop off while everything else stays
identical. Fill in **Plate Width** and **Plate Height** with the plate's *original* pixel size. That
is correct even if Max resampled the bitmap: the crop is proportional and only divides by the size at
the very end, so the normalised result comes out the same.

**Nothing shows at all.** The crop is landing on empty plate. Most likely the layout axis is wrong
for this plate (try setting **Plate Layout** explicitly instead of Auto), or the size fields hold a
value that does not match the assigned bitmap.

**A coloured fringe rings the digit.** Raise **Plate Cell Edge Inset** — mipped or minified plates
bleed from further than half a texel.

---

### Notes and Limits

- The crop applies to **Map 1 only**, which is where the engine puts the counter sequence. Maps 2-4
  are sampled normally.
- Because the crop confines the lookup to a single cell, Map 1's **U Clamped / V Clamped** flags
  stop having any effect once `Numeric` is on.
- Map 1's UV scale / offset / rotation still apply, and they apply *before* the crop — so they now
  move the UV around **within** the chosen digit cell rather than across the whole plate. The UV is
  wrapped into the cell exactly as the Wrap sampler would wrap it across the whole plate, so a
  rotation or offset that pushes it outside 0-1 still lands on the digit.
- A plate is assumed to hold exactly **10 cells** (`GX_NUMERIC_PLATE_CELLS` in
  `src/fx/_numeric_counter.fxh`), since the tag's counter is decimal.
- The margin at the start and the margin at the end are assumed to be equal, as they are on every
  Tool-generated plate.
