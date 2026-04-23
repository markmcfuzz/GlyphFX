// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_glass.fx
//
// Halo CE - shader_transparent_glass
// Entry point.  Includes all modules and declares the DX11 technique.
//
// 3ds Max 2023+ | DirectX 11 | Shader Model 5.0
// ----------------------------------------------------------------------------

string ParamID = "0x003";

#include "_constants.fxh"
#include "_structs.fxh"
#include "_samplers.fxh"
#include "shader_transparent_glass.params.fxh"
#include "_cubemap.fxh"
#include "shader_transparent_glass.vsh"
#include "shader_transparent_glass.psh"

// ----------------------------------------------------------------------------
// Blend state - glass is semi-transparent; Nitrous requires BlendEnable=FALSE
// so we use dithered alpha in the pixel shader instead.
// ----------------------------------------------------------------------------
BlendState BS_Glass
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
// ----------------------------------------------------------------------------
DepthStencilState DS_Default
{
    DepthEnable    = TRUE;
    DepthWriteMask = ALL;
    DepthFunc      = LESS_EQUAL;
};

// ----------------------------------------------------------------------------
// Rasterizer state - no back-face culling so both sides render (glass is
// often two-sided).
// ----------------------------------------------------------------------------
RasterizerState RS_NoCull
{
    CullMode = NONE;
};

RasterizerState RS_BackCull
{
    CullMode = BACK;
};

// ----------------------------------------------------------------------------
// Technique
// ----------------------------------------------------------------------------
technique11 shader_transparent_glass
<
    string UIName = "Halo CE - Shader Transparent Glass";
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
        SetBlendState        ( BS_Glass,          float4(0, 0, 0, 0), 0xFFFFFFFF );
        SetDepthStencilState ( DS_Default,        0 );
        SetRasterizerState   ( RS_NoCull );
    }
}
