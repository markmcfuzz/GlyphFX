// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_meter.fx
//
// Halo CE — shader_transparent_meter
// Entry point. Includes all modules and declares the DX11 technique.
//
// 3ds Max 2023+ | DirectX 11 | Shader Model 5.0
// ----------------------------------------------------------------------------

string ParamID = "0x003";

#include "_constants.fxh"
#include "_structs.fxh"
#include "_samplers.fxh"
#include "shader_transparent_meter.params.fxh"
#include "shader_transparent_meter.vsh"
#include "shader_transparent_meter.psh"

// ----------------------------------------------------------------------------
// Blend state — standard alpha blending
// Transparent objects composite over the scene normally.
// Note: in-engine the Decal flag switches to a modulative blend mode;
// that cannot be toggled per-pass here, so alpha blend is used for all cases.
// ----------------------------------------------------------------------------
BlendState BS_AlphaBlend
{
    BlendEnable[0]           = TRUE;
    SrcBlend                 = SRC_ALPHA;
    DestBlend                = INV_SRC_ALPHA;
    BlendOp                  = ADD;
    SrcBlendAlpha            = ONE;
    DestBlendAlpha           = INV_SRC_ALPHA;
    BlendOpAlpha             = ADD;
    RenderTargetWriteMask[0] = 0x0F;
};

// ----------------------------------------------------------------------------
// Depth state — write depth so opaque passes rendered after the meter cannot
// overwrite its pixels.  The VS Z-bias ensures the meter always wins against
// coplanar shader_model geometry regardless of sub-material render order.
// ----------------------------------------------------------------------------
DepthStencilState DS_MeterDepth
{
    DepthEnable    = TRUE;
    DepthWriteMask = ALL;
    DepthFunc      = LESS_EQUAL;
};

// ----------------------------------------------------------------------------
// Rasterizer state — no backface culling
// Matches Halo's two-sided transparent rendering; the TwoSided flag is
// retained as a tag-visible parameter but culling is disabled here for
// correct viewport preview of all meter geometry orientations.
// ----------------------------------------------------------------------------
RasterizerState RS_NoCull
{
    CullMode = None;
};

// ----------------------------------------------------------------------------
// Technique
// ----------------------------------------------------------------------------
technique11 shader_transparent_meter
<
    string UIName = "Halo CE - Shader Transparent Meter";
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
        SetBlendState        ( BS_AlphaBlend, float4(0, 0, 0, 0), 0xFFFFFFFF );
        SetDepthStencilState ( DS_MeterDepth, 0 );
        SetRasterizerState   ( RS_NoCull );
    }
}

