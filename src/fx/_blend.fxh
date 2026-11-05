// ----------------------------------------------------------------------------
// GlyphFX | fx/_blend.fxh
//
// Real framebuffer blending for the transparent shaders.
//
// Every framebuffer blend the engine uses can be written as
//
//      out = background * Cmul + Cadd
//
//   alpha blend      Cmul = 1 - a          Cadd = rgb * a
//   multiply         Cmul = rgb            Cadd = 0
//   double multiply  Cmul = 2 * rgb        Cadd = 0
//   add              Cmul = 1              Cadd = rgb
//   (and water / glass / plasma's own multi-pass combinations, see each psh)
//
// The pixel shader returns GxBlendOutput (Cadd in render target 0, Cmul in
// render target 1) and the effect uses a dual-source blend state
// (SrcBlend ONE, DestBlend SRC1_COLOR), so the GPU applies exactly that.
//
// What Nitrous needs for it (tested in 3ds Max 2026):
//   - DepthWriteMask = ZERO.  A transparent surface that writes depth breaks
//     the blend; Nitrous draws these surfaces after the opaque geometry.
//   - No RasterizerState in the technique.  Nitrous draws a transparent
//     surface in two passes, back faces first and then front faces, with its
//     own cull mode; a technique that sets one makes both passes draw every
//     face, so every blend is applied twice.  One-sided surfaces drop their
//     back faces in the pixel shader (SV_IsFrontFace).
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_BLEND_FXH
#define GLYPHFX_BLEND_FXH

struct GxBlendOutput
{
    float4 add : SV_Target0;   // Cadd
    float4 mul : SV_Target1;   // Cmul
};

GxBlendOutput BlendOutput(float3 cmul, float3 cadd)
{
    GxBlendOutput o;
    o.add = float4(max(cadd, 0.0), 0.0);
    o.mul = float4(max(cmul, 0.0), 1.0);
    return o;
}

// Drawn as is, covering the background (debug views).
GxBlendOutput BlendOpaque(float3 color)
{
    return BlendOutput((float3)0.0, color);
}

// Framebuffer Blend Function (generic / chicago tag enum) -> the blend drawn.
//   0 alpha blend, 1 multiply, 2 double multiply, 3 add: as in the tag.
//   4 subtract, 5 component min: darken -> multiply.
//   6 component max: brightens -> add.
//   7 alpha-multiply add: -> alpha blend.
static const int GX_VIEWPORT_BLEND[8] = { 0, 1, 2, 3, 1, 1, 3, 0 };

int ViewportBlendMode(int framebufferBlendFunction)
{
    return GX_VIEWPORT_BLEND[clamp(framebufferBlendFunction, 0, 7)];
}

#endif // GLYPHFX_BLEND_FXH
