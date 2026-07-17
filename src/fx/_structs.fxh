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
// shader_transparent_meter - no lighting, position + UV only
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
// shader_transparent_chicago - position + base UV; VS outputs 4 transformed
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

// ----------------------------------------------------------------------------
// shader_environment - diffuse + bump + detail + self-illumination + reflection
// Requires tangent/binormal for tangent-space bump mapping.
// ----------------------------------------------------------------------------
struct SE_VS_INPUT
{
    float4 position : POSITION;
    float3 normal   : NORMAL;
    float3 tangent  : TANGENT;
    float3 binormal : BINORMAL;
    float2 uv0      : TEXCOORD0;
};

struct SE_VS_OUTPUT
{
    float4 clipPos    : SV_POSITION;
    float3 wNormal    : TEXCOORD0;   // world-space normal
    float3 wPos       : TEXCOORD1;   // world-space position
    float3 lampVec    : TEXCOORD2;   // surface → lamp vector (world space)
    float2 uv0        : TEXCOORD3;   // base map UV
    float3 oNormal    : TEXCOORD4;   // object-space normal for cubemap
    float3 wTangent   : TEXCOORD5;   // world-space tangent (for bump mapping)
    float3 wBinormal  : TEXCOORD6;   // world-space binormal (for bump mapping)
};

typedef SE_VS_OUTPUT SE_PS_INPUT;

// ----------------------------------------------------------------------------
// shader_transparent_glass - uses the same vertex layout as shader_environment
// (position + normal + tangent + binormal + UV for bump-mapped reflections).
// ----------------------------------------------------------------------------
typedef SE_VS_INPUT  TG_VS_INPUT;
typedef SE_VS_OUTPUT TG_VS_OUTPUT;
typedef TG_VS_OUTPUT TG_PS_INPUT;

// ----------------------------------------------------------------------------
// shader_transparent_water - same vertex layout as glass/environment
// (position + normal + tangent + binormal + UV for bump-mapped reflections).
// ----------------------------------------------------------------------------
typedef SE_VS_INPUT  TW_VS_INPUT;
typedef SE_VS_OUTPUT TW_VS_OUTPUT;
typedef TW_VS_OUTPUT TW_PS_INPUT;

// ----------------------------------------------------------------------------
// shader_transparent_generic - position + normal + base UV; VS outputs 4
// transformed UV channels (one per map) plus the two Halo vertex color
// registers the combiner stages can read:
//   vColor0 = vertex color 0: diffuse light (rgb) + fade none (a)
//   vColor1 = vertex color 1: fade parallel (rgb) + fade perpendicular (a)
// ----------------------------------------------------------------------------
struct STG_VS_INPUT
{
    float4 position : POSITION;
    float3 normal   : NORMAL;
    float2 uv0      : TEXCOORD0;
};

struct STG_VS_OUTPUT
{
    float4 clipPos : SV_POSITION;
    float2 uv0     : TEXCOORD0;   // Map 1 transformed UV
    float2 uv1     : TEXCOORD1;   // Map 2 transformed UV
    float2 uv2     : TEXCOORD2;   // Map 3 transformed UV
    float2 uv3     : TEXCOORD3;   // Map 4 transformed UV
    float4 vColor0 : TEXCOORD4;   // vertex color 0 (see above)
    float4 vColor1 : TEXCOORD5;   // vertex color 1 (see above)
};

typedef STG_VS_OUTPUT STG_PS_INPUT;

#endif // GLYPHFX_STRUCTS_FXH