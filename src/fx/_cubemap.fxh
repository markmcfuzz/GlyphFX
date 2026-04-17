// ----------------------------------------------------------------------------
// GlyphFX | fx/_cubemap.fxh
//
// Halo CE cross-layout cubemap sampler with face-boundary blending.
//
// Atlas layout (4x3 grid, only 6 cells used):
//   [UP   ][     ][     ][     ]   row 0
//   [BACK ][LEFT ][FRONT][RIGHT]   row 1
//   [DOWN ][     ][     ][     ]   row 2
//
// Halo uses Z-up: +Y = forward (back face), +X = right, +Z = up.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_CUBEMAP_FXH
#define GLYPHFX_CUBEMAP_FXH

// Face indices: 0=BACK(+Y) 1=FRONT(-Y) 2=RIGHT(+X) 3=LEFT(-X) 4=UP(+Z) 5=DOWN(-Z)

// Internal: compute atlas UV for a specific face.
float2 _HaloCEFaceUV(float3 dir, int face, float2 margin, float2 cell)
{
    float  mag, uc, vc;
    float2 base;

    [flatten]
    if      (face == 0) { mag =  dir.y; uc = -dir.x; vc = -dir.z; base = float2(0.00, 1.0/3.0); }
    else if (face == 1) { mag = -dir.y; uc =  dir.x; vc = -dir.z; base = float2(0.50, 1.0/3.0); }
    else if (face == 2) { mag =  dir.x; uc =  dir.y; vc = -dir.z; base = float2(0.75, 1.0/3.0); }
    else if (face == 3) { mag = -dir.x; uc = -dir.y; vc = -dir.z; base = float2(0.25, 1.0/3.0); }
    else if (face == 4) { mag =  dir.z; uc = -dir.x; vc =  dir.y; base = float2(0.00, 0.0);     }
    else                { mag = -dir.z; uc = -dir.x; vc = -dir.y; base = float2(0.00, 2.0/3.0); }

    mag = max(mag, 0.001);
    float2 uv = float2(uc, vc) / mag * 0.5 + 0.5;
    uv = clamp(uv, margin, 1.0 - margin);

    float2 atlasUV = base + uv * cell;
    atlasUV += float2(CubemapUOffset * 0.25, CubemapVOffset * (1.0 / 3.0));
    return atlasUV;
}

// Samples the cubemap atlas with smooth face-boundary and corner blending.
// Uses per-axis 8th-power weights: sharp in face centers, smooth at edges
// (2-face blend) and corners (3-face blend).
float4 SampleHaloCECubeMap(
    Texture2D    tex,
    SamplerState smp,
    float3       dir,
    float        mipLevel)
{
    // Texture size -> per-face texel margin to prevent bilinear bleed
    float texW, texH;
    tex.GetDimensions(texW, texH);
    float2 cell       = float2(0.25, 1.0 / 3.0);
    float2 facePixels = float2(texW, texH) * cell;
    float2 margin     = max(0.5, pow(2.0, mipLevel) * 0.5) / facePixels;

    dir = normalize(dir);
    float3 a = abs(dir);

    // Per-axis weight: 16th power keeps face-centers clean, narrow blend at edges/corners
    float3 w = a * a;       // ^2
    w = w * w;               // ^4
    w = w * w;               // ^8
    w = w * w;               // ^16
    w = w * a;               // ^17 to give more weight to axis with larger magnitude (face center)
    w = w * a;               // ^18 for even stronger face-center bias
    w /= max(dot(w, (float3)1.0), 0.0001);

    // One face per axis, sign-selected
    int fX = (dir.x >= 0) ? 2 : 3;   // RIGHT / LEFT
    int fY = (dir.y >= 0) ? 0 : 1;   // BACK  / FRONT
    int fZ = (dir.z >= 0) ? 4 : 5;   // UP    / DOWN

    // Only sample faces with meaningful weight (>1%)
    float4 result = (float4)0;

    [branch] if (w.x > 0.01)
        result += w.x * tex.SampleLevel(smp, _HaloCEFaceUV(dir, fX, margin, cell), mipLevel);
    [branch] if (w.y > 0.01)
        result += w.y * tex.SampleLevel(smp, _HaloCEFaceUV(dir, fY, margin, cell), mipLevel);
    [branch] if (w.z > 0.01)
        result += w.z * tex.SampleLevel(smp, _HaloCEFaceUV(dir, fZ, margin, cell), mipLevel);

    return result;
}

#endif // GLYPHFX_CUBEMAP_FXH