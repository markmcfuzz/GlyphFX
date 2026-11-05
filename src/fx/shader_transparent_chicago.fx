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
#include "_coverage.fxh"
#include "_periodic.fxh"
#include "shader_transparent_chicago.params.fxh"
#include "shader_transparent_chicago.vsh"
#include "shader_transparent_chicago.psh"

// ----------------------------------------------------------------------------
// Blend state
// Nitrous ignores blend states, so GPU blending stays off and the material is
// declared opaque; the pixel shader reproduces each blend (alpha with a
// dither, the others with the coverage solve in _coverage.fxh).
// ----------------------------------------------------------------------------
BlendState BS_Opaque
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
// Depth state
// DepthWriteMask = ALL is required by Nitrous.  The dither clip in the pixel
// shader ensures transparent fragments are discarded before writing depth.
// ----------------------------------------------------------------------------
DepthStencilState DS_DepthReadWrite
{
    DepthEnable    = TRUE;
    DepthWriteMask = ALL;
    DepthFunc      = LESS_EQUAL;
};

// ----------------------------------------------------------------------------
// Rasterizer state - no back-face culling so both sides render correctly.
// ----------------------------------------------------------------------------
RasterizerState RS_NoCull
{
    CullMode = NONE;
};

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
        SetBlendState        ( BS_Opaque,          float4(0, 0, 0, 0), 0xFFFFFFFF );
        SetDepthStencilState ( DS_DepthReadWrite,  0 );
        SetRasterizerState   ( RS_NoCull );
    }
}
