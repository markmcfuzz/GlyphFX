// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_water.fx
//
// Halo CE - shader_transparent_water
// Entry point.  Includes all modules and declares the DX11 technique.
//
// Water is never opaque: the engine modulates the background by the base map
// colour and adds a bump-mapped cube map reflection on top, driven by up to 4
// blended ripple layers.  See the pixel shader header for the derivation from
// rasterizer_shader_transparent_water.c and for how that compositing is
// reproduced through stochastic coverage.
//
// 3ds Max 2023+ | DirectX 11 | Shader Model 5.0
// ----------------------------------------------------------------------------

string ParamID = "0x003";

#include "_constants.fxh"
#include "_structs.fxh"
#include "_samplers.fxh"
#include "shader_transparent_water.params.fxh"
#include "_cubemap.fxh"
#include "shader_transparent_water.vsh"
#include "shader_transparent_water.psh"

// ----------------------------------------------------------------------------
// Blend state
//
// BlendEnable = FALSE.  Nitrous honours no blend configuration at all - the
// engine's own ZERO/SRCCOLOR multiply, its ONE/ONE additive pass and even a
// plain SRC_ALPHA/INV_SRC_ALPHA blend were each tried in the viewport and each
// one landed opaque.  So blending is off, the pixel shader output goes
// straight to the framebuffer, and SrcBlend = ONE / DestBlend = ZERO declares
// the material opaque so it renders in the opaque pass.  Transparency comes
// from the dithered coverage in the pixel shader instead, as in every other
// transparent shader in this project.
// ----------------------------------------------------------------------------
BlendState BS_Water
{
    BlendEnable[0]           = FALSE;
    SrcBlend                 = ONE;
    DestBlend                = ZERO;
    BlendOp                  = ADD;
    SrcBlendAlpha            = ONE;
    DestBlendAlpha           = ZERO;
    BlendOpAlpha             = ADD;
    RenderTargetWriteMask[0] = 0x0F;
};

// ----------------------------------------------------------------------------
// Depth state - the engine writes depth for water (z_write_enable is only
// cleared for sky / draw-before-fog geometry).  Discarded pixels write no
// depth, which is what lets the background survive behind them.
// ----------------------------------------------------------------------------
DepthStencilState DS_Default
{
    DepthEnable    = TRUE;
    DepthWriteMask = ALL;
    DepthFunc      = LESS_EQUAL;
};

// ----------------------------------------------------------------------------
// Rasterizer state - no back-face culling so both sides render (water is
// often two-sided).
// ----------------------------------------------------------------------------
RasterizerState RS_NoCull
{
    CullMode = NONE;
};

// ----------------------------------------------------------------------------
// Technique
// ----------------------------------------------------------------------------
technique11 shader_transparent_water
<
    string UIName = "Halo CE - Shader Transparent Water";
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
        SetBlendState        ( BS_Water,          float4(0, 0, 0, 0), 0xFFFFFFFF );
        SetDepthStencilState ( DS_Default,        0 );
        SetRasterizerState   ( RS_NoCull );
    }
}
