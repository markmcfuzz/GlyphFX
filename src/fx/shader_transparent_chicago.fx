// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_chicago.fx
//
// Halo CE - shader_transparent_chicago
// Entry point.  Includes all modules and declares the DX11 techniques.
//
// One technique.  The tag's "Framebuffer Blend Function" parameter picks the
// blend: Alpha Blend, Multiply, Double Multiply and Add as in the tag;
// Subtract and Component Min draw as Multiply, Component Max as Add and
// Alpha-Multiply Add as Alpha Blend.  Scenes saved with one of the old
// per-blend techniques fall back to this one.
//
// 3ds Max 2023+ | DirectX 11 | Shader Model 5.0
// ----------------------------------------------------------------------------

string ParamID = "0x003";

#include "_constants.fxh"
#include "_structs.fxh"
#include "_samplers.fxh"
#include "_numeric_counter.fxh"
#include "_blend.fxh"
#include "_periodic.fxh"
#include "shader_transparent_chicago.params.fxh"
#include "shader_transparent_chicago.vsh"
#include "shader_transparent_chicago.psh"

// ----------------------------------------------------------------------------
// Blend state - dual source: out = PS target 0 + background * PS target 1,
// i.e. background * Cmul + Cadd for every framebuffer blend (see the psh).
// The framebuffer alpha is left as it is.
// ----------------------------------------------------------------------------
BlendState BS_DualSource
{
    BlendEnable[0]           = TRUE;
    SrcBlend                 = ONE;
    DestBlend                = SRC1_COLOR;
    BlendOp                  = ADD;
    SrcBlendAlpha            = ZERO;
    DestBlendAlpha           = ONE;
    BlendOpAlpha             = ADD;
    RenderTargetWriteMask[0] = 0x0F;
};

// ----------------------------------------------------------------------------
// Depth state - test, but do not write.  A transparent surface that writes
// depth hides what Nitrous draws behind it later (tested in Max 2026).
// ----------------------------------------------------------------------------
DepthStencilState DS_DepthTestOnly
{
    DepthEnable    = TRUE;
    DepthWriteMask = ZERO;
    DepthFunc      = LESS_EQUAL;
};

// ----------------------------------------------------------------------------
// No rasterizer state, on purpose.  Nitrous draws a transparent surface in two
// passes, back faces first and then front faces, by setting the cull mode of
// each pass itself.  Setting one here (it used to be CullMode NONE) overrides
// that, so both passes drew every face and every blend was applied twice
// (measured in Max 2026: an Add of 0.25 came out 0.5).  The Two Sided flag is
// handled in the pixel shader instead.
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// Technique
// ----------------------------------------------------------------------------
technique11 shader_transparent_chicago
<
    string UIName = "Halo CE - Chicago";
    string Script = "Pass=p0;";
>
{
    pass p0
    <
        string Script = "Draw=geometry;";
    >
    {
        SetVertexShader      ( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader    ( NULL );
        SetPixelShader       ( CompileShader( ps_5_0, PS_Main() ) );
        SetBlendState        ( BS_DualSource,      float4(0, 0, 0, 0), 0xFFFFFFFF );
        SetDepthStencilState ( DS_DepthTestOnly,   0 );
    }
}
