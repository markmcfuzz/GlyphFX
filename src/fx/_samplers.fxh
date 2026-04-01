// ----------------------------------------------------------------------------
// GlyphFX | fx/_samplers.fxh
//
// Shared sampler states used across shader types.
// Individual shaders declare their own Texture2D / TextureCube slots
// with semantic names in their own .params.fxh files.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_SAMPLERS_FXH
#define GLYPHFX_SAMPLERS_FXH

// ----------------------------------------------------------------------------
// Wrap sampler — default for diffuse, detail, multipurpose maps
// ----------------------------------------------------------------------------
SamplerState smpWrap
{
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU  = Wrap;
    AddressV  = Wrap;
};

// ----------------------------------------------------------------------------
// Clamp sampler — used for cubemap / reflection lookups
// ----------------------------------------------------------------------------
SamplerState smpClamp
{
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU  = Clamp;
    AddressV  = Clamp;
    AddressW  = Clamp;
};

#endif // GLYPHFX_SAMPLERS_FXH