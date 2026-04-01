// ----------------------------------------------------------------------------
// GlyphFX | fx/_constants.fxh
//
// Global constants and auto-bound transforms shared across all shader types.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_CONSTANTS_FXH
#define GLYPHFX_CONSTANTS_FXH

// ----------------------------------------------------------------------------
// Auto-bound transforms (3ds Max Nitrous)
// ----------------------------------------------------------------------------
float4x4 matWVP  : WorldViewProjection   < string UIWidget = "None"; >;
float4x4 matW    : World                 < string UIWidget = "None"; >;
float4x4 matWIT  : WorldInverseTranspose < string UIWidget = "None"; >;
float4x4 ViewIXf : ViewInverse           < string UIWidget = "None"; >;

#endif // GLYPHFX_CONSTANTS_FXH