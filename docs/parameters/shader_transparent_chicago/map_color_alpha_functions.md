# Map Color / Alpha Functions

`shader_transparent_chicago` has **no colour parameter of its own** — no tint, no constant colour,
nothing. The only way to colour anything is to combine map stages, which is what these two
parameters do. They are also the single most misread field in the tag.

---

### The Function Belongs to the Blend *After* the Map

A map's Color Function does **not** describe how that map joins the ones before it. It describes how
everything accumulated so far — *current* — combines with the map that comes **next**.

That is why the enum is worded the way it is: `current`, `next map`, `subtract current`,
`blend next map alpha`. Those names only make sense from a vantage point *between* two maps.

Four maps therefore produce only **three** blends:

| Blend | Driven by |
|---|---|
| Map 1 → Map 2 | **Map 1's** function |
| result → Map 3 | **Map 2's** function |
| result → Map 4 | **Map 3's** function |
| — | Map 4's function is **inert**, nothing follows it |

This mirrors the reference shader exactly (`shaders/fx/chicago_shader.psh`), which runs three stage
calls over four sampled textures, each taking `(accumulated, next map)`.

> [!IMPORTANT]
> On a two-map tag it is **Map 1's** function that matters, not Map 2's. Setting Map 2's function
> and expecting it to blend into Map 1 does nothing.

---

### Tinting a Map

Since there is no colour parameter, the standard trick — and how Halo's own ammo counters do it — is:

1. Put the greyscale artwork in **Map 1**.
2. Put the colour in **Map 2**.
3. Set **Map 1's Color Function** (and Alpha Function, if the alpha needs it) to **2 = Multiply**.

Map 1 is then multiplied by Map 2: white artwork takes Map 2's colour, black stays black.

---

### The Enum

With `A` = current (everything accumulated up to and including this map) and `B` = the next map:

| Value | Name | Result |
|---|---|---|
| 0 | current | `A` |
| 1 | next map | `B` |
| 2 | multiply | `A × B` |
| 3 | double multiply | `2 × A × B` |
| 4 | add | `A + B` |
| 5 | add signed current | `A + B − ½` |
| 6 | add signed next map | `A + B − ½` |
| 7 | subtract current | `B − A` |
| 8 | subtract next map | `A − B` |
| 9 | blend current alpha | `lerp(A, B, current alpha)` |
| 10 | blend current alpha inverse | `lerp(A, B, 1 − current alpha)` |
| 11 | blend next map alpha | `lerp(A, B, next map alpha)` |
| 12 | blend next map alpha inverse | `lerp(A, B, 1 − next map alpha)` |

Everything except the blend-by-alpha rows is saturated to `[0, 1]`, as the fixed-function pipeline
does.

**Why 5 and 6 are identical.** They come from the D3D9 fixed-function `ADDSIGNED` op, which is
symmetric — `A + B − ½` either way. Both values exist in the tag, but they cannot produce different
results. The two `subtract` entries *are* different: the named operand is the one being subtracted.

The Alpha Function uses the same enum on the alpha channel alone. Its blend-by-alpha rows read the
same two values they are combining, so `9`/`11` and `10`/`12` collapse into two distinct behaviours
rather than four.

---

### Notes

- Alpha Replicate spreads a map's sampled alpha across its RGB *before* the blend, so it changes what
  that map contributes as `B`.
- The stage arithmetic runs before the framebuffer blend mode. Pick the technique that matches the
  tag's Framebuffer Blend Function; the maps are already combined by then.
