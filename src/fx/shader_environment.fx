// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_environment.fx
//
// Halo CE — shader_environment
// Entry point.  Includes all modules and declares the DX11 technique.
//
// 3ds Max 2023+ | DirectX 11 | Shader Model 5.0
// ----------------------------------------------------------------------------

string ParamID = "0x003";

#include "_constants.fxh"
#include "_structs.fxh"
#include "_samplers.fxh"
#include "shader_environment.params.fxh"
#include "_cubemap.fxh"
#include "shader_environment.vsh"
#include "shader_environment.psh"

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
// Technique
// ----------------------------------------------------------------------------
technique11 shader_environment
<
    string UIName = "Halo CE - Shader Environment";
    string Script = "Pass=p0;";
>
{
    pass p0
    <
        string Script = "Draw=geometry;";
    >
    {
        SetVertexShader  ( CompileShader( vs_5_0, VS_Main() ) );
        SetGeometryShader( NULL );
        SetPixelShader   ( CompileShader( ps_5_0, PS_Main() ) );
        SetDepthStencilState( DS_Default, 0 );
    }
}
