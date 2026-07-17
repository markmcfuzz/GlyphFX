// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_generic.fx
//
// Halo CE - shader_transparent_generic
// Entry point.  Includes all modules and declares the DX11 techniques.
//
// Select the technique that matches the "Framebuffer Blend Function" in the tag:
//
//   Halo CE - Generic (Alpha Blend)      alpha blend  - combiner alpha = opacity
//   Halo CE - Generic (Multiply)         multiply     - polygon darkens / tints bg
//   Halo CE - Generic (Double Multiply)  double mul   - same as multiply, 2× result
//   Halo CE - Generic (Add)              add          - color added on top of bg
//
// Subtract, Component Min/Max and Alpha-Multiply Add have no viewport
// equivalent - pick the closest of the four techniques above.
//
// 3ds Max 2023+ | DirectX 11 | Shader Model 5.0
// ----------------------------------------------------------------------------

string ParamID = "0x003";

#include "_constants.fxh"
#include "_structs.fxh"
#include "_samplers.fxh"
#include "shader_transparent_generic.params.fxh"
#include "shader_transparent_generic.vsh"
#include "shader_transparent_generic.psh"

// ----------------------------------------------------------------------------
// Blend states
// ----------------------------------------------------------------------------

// Alpha Blend - standard compositing:  src.a × src + (1 − src.a) × dst
// BlendEnable = FALSE: GPU blending is off, PS output goes directly to framebuffer.
// SrcBlend = ONE / DestBlend = ZERO: tells Nitrous this is an OPAQUE material so
// Standard/High Quality viewport composites it opaquely - black stays black.
// For DX mode, BlendEnable=FALSE means these factors are irrelevant anyway.
BlendState BS_AlphaBlend
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

// Add - result = src.a × src.rgb + dst.rgb
//   Luminance is used as alpha in PS_Add: dark pixels get alpha ≈ 0 and
//   contribute almost nothing; bright pixels add their full colour on top.
//   No polygon silhouette / dark rectangle - the background shows through
//   at dark pixels naturally without any discard or dithering.
BlendState BS_Add
{
    BlendEnable[0]           = FALSE;
    SrcBlend                 = SRC_ALPHA;
    DestBlend                = ONE;
    BlendOp                  = ADD;
    SrcBlendAlpha            = ZERO;
    DestBlendAlpha           = ONE;
    BlendOpAlpha             = ADD;
    RenderTargetWriteMask[0] = 0x0F;
};

// Multiply - stochastic approximation via inverted luminance dither.
//   Bright pixels (high lum) are discarded → background shows through.
//   Dark pixels survive and draw their colour opaquely → darkens the background.
//   BlendEnable = FALSE so Nitrous composites surviving fragments as opaque
//   geometry, landing correctly on top of the already-rendered scene.
BlendState BS_Multiply
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

// Double Multiply - same stochastic approach as Multiply.
//   Output RGB is pre-doubled (× 2) before the inverted-lum dither.
//   Mid grey (0.5) × 2 = 1.0 → nearly always discarded → near-neutral effect.
BlendState BS_DoubleMultiply
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
// Techniques
// ----------------------------------------------------------------------------
// Alpha Blend - the combiner's final alpha (scratch alpha 0) is the opacity.
technique11 blend_func_alpha_blend
<
    string UIName = "Halo CE - Generic (Alpha Blend)";
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
        SetPixelShader       ( CompileShader( ps_5_0, PS_AlphaBlend() ) );
        SetBlendState        ( BS_AlphaBlend,      float4(0, 0, 0, 0), 0xFFFFFFFF );
        SetDepthStencilState ( DS_DepthReadWrite,  0 );
        SetRasterizerState   ( RS_NoCull );
    }
}
// Multiply - polygon RGB multiplies the background.
// White = no effect; black = darkens to black.
technique11 blend_func_multiply
<
    string UIName = "Halo CE - Generic (Multiply)";
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
        SetPixelShader       ( CompileShader( ps_5_0, PS_Multiply() ) );
        SetBlendState        ( BS_Multiply,        float4(0, 0, 0, 0), 0xFFFFFFFF );
        SetDepthStencilState ( DS_DepthReadWrite,  0 );
        SetRasterizerState   ( RS_NoCull );
    }
}
// Double Multiply - same as Multiply but 2× result.
// Mid grey (0.5) leaves background unchanged.
technique11 blend_func_double_multiply
<
    string UIName = "Halo CE - Generic (Double Multiply)";
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
        SetPixelShader       ( CompileShader( ps_5_0, PS_DoubleMultiply() ) );
        SetBlendState        ( BS_DoubleMultiply,  float4(0, 0, 0, 0), 0xFFFFFFFF );
        SetDepthStencilState ( DS_DepthReadWrite,  0 );
        SetRasterizerState   ( RS_NoCull );
    }
}
// Add - opacity from RGB luminance; colour is added to the background.
technique11 blend_func_add
<
    string UIName = "Halo CE - Generic (Add)";
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
        SetPixelShader       ( CompileShader( ps_5_0, PS_Add() ) );
        SetBlendState        ( BS_Add,             float4(0, 0, 0, 0), 0xFFFFFFFF );
        SetDepthStencilState ( DS_DepthReadWrite,  0 );
        SetRasterizerState   ( RS_NoCull );
    }
}
