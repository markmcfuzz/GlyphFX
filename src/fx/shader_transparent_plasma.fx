// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_plasma.fx
//
// Halo CE - shader_transparent_plasma
// Entry point.  Includes all modules and declares the DX11 technique.
//
// 3ds Max 2023+ | DirectX 11 | Shader Model 5.0
// ----------------------------------------------------------------------------

string ParamID = "0x003";

#include "_constants.fxh"
#include "_structs.fxh"
#include "_samplers.fxh"
#include "shader_transparent_plasma.params.fxh"
#include "shader_transparent_plasma.vsh"
#include "shader_transparent_plasma.psh"

// ----------------------------------------------------------------------------
// Blend state - plasma is semi-transparent; Nitrous requires BlendEnable=FALSE
// so we use dithered alpha in the pixel shader instead.
// ----------------------------------------------------------------------------
BlendState BS_Plasma
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
// Rasterizer state - no back-face culling; plasma sheets (shield doors, etc.)
// are viewed from both sides.
// ----------------------------------------------------------------------------
RasterizerState RS_NoCull
{
    CullMode = NONE;
};

// ----------------------------------------------------------------------------
// Technique
// ----------------------------------------------------------------------------
technique11 shader_transparent_plasma
<
    string UIName = "Halo CE - Shader Transparent Plasma";
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
        SetBlendState        ( BS_Plasma,         float4(0, 0, 0, 0), 0xFFFFFFFF );
        SetDepthStencilState ( DS_Default,        0 );
        SetRasterizerState   ( RS_NoCull );
    }
}
