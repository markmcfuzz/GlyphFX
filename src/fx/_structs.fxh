// ----------------------------------------------------------------------------
// GlyphFX | fx/_structs.fxh
//
// Shared vertex and pixel shader I/O structs.
// Based on 343i's VS_INPUT / VS_OUTPUT / PS_INPUT from model_common.h
// and model.vsh, extended for the DX11 / Nitrous pipeline.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_STRUCTS_FXH
#define GLYPHFX_STRUCTS_FXH

// ----------------------------------------------------------------------------
// Vertex shader input
// ----------------------------------------------------------------------------
struct VS_INPUT
{
    float4 position : POSITION;
    float3 normal   : NORMAL;
    float2 uv0      : TEXCOORD0;
    float2 uv1      : TEXCOORD1;
};

// ----------------------------------------------------------------------------
// Vertex shader output / Pixel shader input
// ----------------------------------------------------------------------------
struct VS_OUTPUT
{
    float4 clipPos  : SV_POSITION;
    float3 wNormal  : TEXCOORD0;   // world-space normal
    float3 wPos     : TEXCOORD1;   // world-space position
    float3 lampVec  : TEXCOORD2;   // vector from surface to lamp (world space)
    float2 uv0      : TEXCOORD3;   // base map + multipurpose map UV (scaled)
    float2 uv1      : TEXCOORD4;   // detail map UV (scaled)
    float3 oNormal  : TEXCOORD5;   // object-space normal for cubemap sampling
};

typedef VS_OUTPUT PS_INPUT;

// ----------------------------------------------------------------------------
// shader_transparent_meter — no lighting, position + UV only
// ----------------------------------------------------------------------------
struct TM_VS_INPUT
{
    float4 position : POSITION;
    float2 uv0      : TEXCOORD0;
};

struct TM_VS_OUTPUT
{
    float4 clipPos : SV_POSITION;
    float2 uv0     : TEXCOORD0;
};

typedef TM_VS_OUTPUT TM_PS_INPUT;

// ----------------------------------------------------------------------------
// shader_transparent_chicago — position + base UV; VS outputs 4 transformed
// UV channels (one per map stage) computed from the single mesh UV.
// ----------------------------------------------------------------------------
struct TC_VS_INPUT
{
    float4 position : POSITION;
    float2 uv0      : TEXCOORD0;
};

struct TC_VS_OUTPUT
{
    float4 clipPos : SV_POSITION;
    float2 uv0     : TEXCOORD0;   // Map 1 transformed UV
    float2 uv1     : TEXCOORD1;   // Map 2 transformed UV
    float2 uv2     : TEXCOORD2;   // Map 3 transformed UV
    float2 uv3     : TEXCOORD3;   // Map 4 transformed UV
};

typedef TC_VS_OUTPUT TC_PS_INPUT;

#endif // GLYPHFX_STRUCTS_FXH