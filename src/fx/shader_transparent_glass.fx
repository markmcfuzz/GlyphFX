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
#include "_blend.fxh"
#include "shader_transparent_glass.params.fxh"
#include "_cubemap.fxh"
#include "shader_transparent_glass.vsh"
#include "shader_transparent_glass.psh"

// ----------------------------------------------------------------------------
// Blend state - dual source: out = PS target 0 + background * PS target 1,
// i.e. background * Cmul + Cadd (see _blend.fxh).  Framebuffer alpha is kept.
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
// Depth state - test, but do not write (writing depth breaks the blend in
// Nitrous; it draws transparent surfaces after the opaque geometry).
// ----------------------------------------------------------------------------
DepthStencilState DS_DepthTestOnly
{
    DepthEnable    = TRUE;
    DepthWriteMask = ZERO;
    DepthFunc      = LESS_EQUAL;
};

// No rasterizer state, on purpose: Nitrous draws transparent surfaces in two
// passes (back faces, then front faces) with its own cull mode.  See
// _blend.fxh.

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
        SetBlendState        ( BS_DualSource,          float4(0, 0, 0, 0), 0xFFFFFFFF );
        SetDepthStencilState ( DS_DepthTestOnly,  0 );
    }
}
