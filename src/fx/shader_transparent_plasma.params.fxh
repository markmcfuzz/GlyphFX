// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_plasma.params.fxh
//
// All UI-exposed parameters for shader_transparent_plasma.
// Field names, grouping and help text below are transcribed directly from
// Guerrilla's shader_transparent_plasma tag editor (screenshot supplied by
// Mark, 2026-07-20) so this file doubles as an accurate reference of the real
// tag schema, not just a viewport control panel.  Every tag field is present
// with its exact name even where the 3ds Max viewport can't act on it (no
// time source, no game object) - those are called out per-field below rather
// than hidden, since this file is also used to document the tag layout for
// another project.
//
//   Guerrilla group          → UIGroup here
//   "plasma shader"          → (top-level tag, base Shader fields + groups below)
//   "intensity"               "Intensity"           - how bright the plasma is
//   "offset"                  "Offset"              - how far it extends off the mesh
//   "color"                   "Color"               - tint color + Fresnel brightness
//   "primary noise map"        "Primary Noise Map"
//   "secondary noise map"      "Secondary Noise Map"
//
// "Intensity/Offset Source" and "Tint Color Source" are Halo's Object
// Function A/B/C/D references - scalars exported by scripts/devices on the
// parent object at runtime.  There's no game object driving them in the Max
// viewport, so they're exposed for schema fidelity only and don't affect
// the shader.  If a real tag uses "Tint Color Source", bake its expected
// external multiplier directly into the Perpendicular/Parallel Tint Color
// values below (same workaround used for shader_transparent_generic's
// per-stage color0 source).
//
// ── NOISE VOLUME ATLAS ───────────────────────────────────────────────────────
// The two noise maps are Texture3D volumes in the original engine.  Halo CE's
// own tools store 3D bitmaps as a 2D filmstrip instead: a single row of N
// square slices separated by a solid-colour border of arbitrary width (see
// shaders/resources/plasma shield noise.png for a real example: 32 slices of
// 32x32, 3px dividers, 4px top/bottom margin - measured, not assumed).  Slice
// resolution and count are conventionally powers of two (32x32, 64x64,
// 128x128 ...) but the count itself varies per asset, so Slice Count / Border
// Texels below are GlyphFX viewport parameters - NOT tag data - describing
// the atlas layout so the pixel shader can reconstruct and trilinearly
// sample a pseudo-volume from an ordinary 2D texture.  Tune them to whatever
// noise map image you actually load.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_TRANSPARENT_PLASMA_PARAMS_FXH
#define GLYPHFX_TRANSPARENT_PLASMA_PARAMS_FXH

#ifndef SHOW_TAG_FIELDS
#define SHOW_TAG_FIELDS 0
#endif

// ----------------------------------------------------------------------------
// Shader General Fields  (base "Shader" tag struct)
// ----------------------------------------------------------------------------
bool SimpleParameterization
<
    string UIName  = "Simple Parameterization";
    string UIGroup = "Shader General Fields";
    int    UIOrder = 0;
> = false;

bool IgnoreNormals
<
    string UIName  = "Ignore Normals";
    string UIGroup = "Shader General Fields";
    int    UIOrder = 1;
> = false;

bool TransparentLit
<
    string UIName  = "Transparent Lit";
    string UIGroup = "Shader General Fields";
    int    UIOrder = 2;
> = false;

int DetailLevel
<
    string UIName   = "Detail Level  [0=High 1=Medium 2=Low 3=Turd]";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "slider";
    int    UIOrder = 3;
    float  UIMin = 0; float UIMax = 3; float UIStep = 1;
> = 0;

float Power
<
    string UIName   = "Power";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "slider";
    int    UIOrder = 4;
    float  UIMin = 0; float UIMax = 9999; float UIStep = 1;
> = 1;

float4 ColorOfEmittedLight
<
    string UIName   = "Color of Emitted Light";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "Color";
    int    UIOrder = 5;
> = float4(0, 0, 0, 0);

float4 TintColor
<
    string UIName   = "Tint Color";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "Color";
    int    UIOrder = 6;
> = float4(1, 1, 1, 1);

float MaterialType
<
    string UIName   = "Material Type";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "slider";
    int    UIOrder = 7;
    float  UIMin = 0; float UIMax = 32; float UIStep = 1;
> = 0.0;

// ----------------------------------------------------------------------------
// Intensity - "Controls how bright the plasma is."
// Not wired into the shader: no "intensity" register/constant appears
// anywhere in the disassembled transparent_plasma_m.vsh / transparent_plasma.psh,
// so there is nothing to reproduce even statically.  Kept for tag fidelity.
// ----------------------------------------------------------------------------
int IntensitySource
<
    string UIName   = "Intensity Source  [0=A Out 1=B Out 2=C Out 3=D Out]  (not implemented in viewport)";
    string UIGroup  = "Intensity";
    string UIWidget = "Spinner";
    int    UIOrder = 8;
    float  UIMin = 0; float UIMax = 3; float UIStep = 1;
> = 0;

float IntensityExponent
<
    string UIName   = "Intensity Exponent  (not implemented in viewport)";
    string UIGroup  = "Intensity";
    string UIWidget = "slider";
    int    UIOrder = 9;
    float  UIMin = 0; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

// ----------------------------------------------------------------------------
// Offset - "Controls how far the plasma energy extends from the model geometry."
// Offset Amount IS implemented (pushes the vertex along its normal, see .vsh).
// Source/Exponent modulate that amount over time in-engine; not reproducible
// without a time source, kept for tag fidelity only.
// ----------------------------------------------------------------------------
int OffsetSource
<
    string UIName   = "Offset Source  [0=A Out 1=B Out 2=C Out 3=D Out]  (not implemented in viewport)";
    string UIGroup  = "Offset";
    string UIWidget = "Spinner";
    int    UIOrder = 10;
    float  UIMin = 0; float UIMax = 3; float UIStep = 1;
> = 0;

float OffsetAmount
<
    string UIName   = "Offset Amount  (World Units)";
    string UIGroup  = "Offset";
    string UIWidget = "slider";
    int    UIOrder = 11;
    float  UIMin = -2; float UIMax = 2; float UIStep = 0.01;
> = 0.0;

float OffsetExponent
<
    string UIName   = "Offset Exponent  (not implemented in viewport)";
    string UIGroup  = "Offset";
    string UIWidget = "slider";
    int    UIOrder = 12;
    float  UIMin = 0; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

// ----------------------------------------------------------------------------
// Color - "Controls the tint color and Fresnel brightness effects."
// ----------------------------------------------------------------------------
float PerpendicularBrightness
<
    string UIName   = "Perpendicular Brightness  [0,1]";
    string UIGroup  = "Color";
    string UIWidget = "slider";
    int    UIOrder = 13;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float4 PerpendicularTintColor
<
    string UIName   = "Perpendicular Tint Color";
    string UIGroup  = "Color";
    string UIWidget = "Color";
    int    UIOrder = 14;
> = float4(0, 0, 0, 1);

float ParallelBrightness
<
    string UIName   = "Parallel Brightness  [0,1]";
    string UIGroup  = "Color";
    string UIWidget = "slider";
    int    UIOrder = 15;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float4 ParallelTintColor
<
    string UIName   = "Parallel Tint Color";
    string UIGroup  = "Color";
    string UIWidget = "Color";
    int    UIOrder = 16;
> = float4(0, 0, 0, 1);

int TintColorSource
<
    string UIName   = "Tint Color Source  [0=None 1=A Out 2=B Out 3=C Out 4=D Out]  (not implemented in viewport)";
    string UIGroup  = "Color";
    string UIWidget = "Spinner";
    int    UIOrder = 17;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

// ----------------------------------------------------------------------------
// Primary Noise Map
// ----------------------------------------------------------------------------
float PrimaryAnimationPeriod
<
    string UIName   = "Primary Animation Period  (Seconds)  (not animated in viewport)";
    string UIGroup  = "Primary Noise Map";
    string UIWidget = "slider";
    int    UIOrder = 18;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 1.0;

float PrimaryAnimationDirectionI
<
    string UIName   = "Primary Animation Direction (i)  (not animated in viewport)";
    string UIGroup  = "Primary Noise Map";
    string UIWidget = "slider";
    int    UIOrder = 19;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 0.0;

float PrimaryAnimationDirectionJ
<
    string UIName   = "Primary Animation Direction (j)  (not animated in viewport)";
    string UIGroup  = "Primary Noise Map";
    string UIWidget = "slider";
    int    UIOrder = 20;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 0.0;

float PrimaryAnimationDirectionK
<
    string UIName   = "Primary Animation Direction (k)  (not animated in viewport)";
    string UIGroup  = "Primary Noise Map";
    string UIWidget = "slider";
    int    UIOrder = 21;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 0.0;

float PrimaryNoiseMapScale
<
    string UIName   = "Primary Noise Map Scale  (World Units per Repeat)";
    string UIGroup  = "Primary Noise Map";
    string UIWidget = "slider";
    int    UIOrder = 22;
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
> = 0.0;

// Toggles the texture off (samples a neutral 0.5/0.5/0.5/0.5 value instead) -
// 3ds Max has no "clear" button for an assigned bitmap, so this is the only
// way to simulate an unassigned/null noise map once one has been picked.
bool EnablePrimaryNoiseMap
<
    string UIName  = "Enable Primary Noise Map";
    string UIGroup = "Primary Noise Map";
    int    UIOrder = 23;
> = true;

Texture2D PrimaryNoiseMapTexture
<
    string UIName       = "Primary Noise Map  (filmstrip atlas, see header comment)";
    string UIGroup      = "Primary Noise Map";
    string ResourceType = "2D";
    int    UIOrder = 24;
>;

int PrimaryNoiseSliceCount
<
    string UIName   = "Atlas Slice Count  (GlyphFX-only, not tag data)";
    string UIGroup  = "Primary Noise Map";
    string UIWidget = "Spinner";
    int    UIOrder = 25;
    float  UIMin = 1; float UIMax = 256; float UIStep = 1;
> = 32;

float PrimaryNoiseBorderTexelsH
<
    string UIName   = "Atlas Border Texels - Horizontal  (GlyphFX-only, not tag data)";
    string UIGroup  = "Primary Noise Map";
    string UIWidget = "slider";
    int    UIOrder = 26;
    float  UIMin = 0; float UIMax = 16; float UIStep = 0.5;
> = 3.0;

float PrimaryNoiseBorderTexelsV
<
    string UIName   = "Atlas Border Texels - Vertical  (GlyphFX-only, not tag data)";
    string UIGroup  = "Primary Noise Map";
    string UIWidget = "slider";
    int    UIOrder = 27;
    float  UIMin = 0; float UIMax = 16; float UIStep = 0.5;
> = 4.0;

// ----------------------------------------------------------------------------
// Secondary Noise Map
// ----------------------------------------------------------------------------
float SecondaryAnimationPeriod
<
    string UIName   = "Secondary Animation Period  (Seconds)  (not animated in viewport)";
    string UIGroup  = "Secondary Noise Map";
    string UIWidget = "slider";
    int    UIOrder = 28;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 1.0;

float SecondaryAnimationDirectionI
<
    string UIName   = "Secondary Animation Direction (i)  (not animated in viewport)";
    string UIGroup  = "Secondary Noise Map";
    string UIWidget = "slider";
    int    UIOrder = 29;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 0.0;

float SecondaryAnimationDirectionJ
<
    string UIName   = "Secondary Animation Direction (j)  (not animated in viewport)";
    string UIGroup  = "Secondary Noise Map";
    string UIWidget = "slider";
    int    UIOrder = 30;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 0.0;

float SecondaryAnimationDirectionK
<
    string UIName   = "Secondary Animation Direction (k)  (not animated in viewport)";
    string UIGroup  = "Secondary Noise Map";
    string UIWidget = "slider";
    int    UIOrder = 31;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 0.0;

float SecondaryNoiseMapScale
<
    string UIName   = "Secondary Noise Map Scale  (World Units per Repeat)";
    string UIGroup  = "Secondary Noise Map";
    string UIWidget = "slider";
    int    UIOrder = 32;
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
> = 0.0;

// Toggles the texture off (samples a neutral 0.5/0.5/0.5/0.5 value instead) -
// 3ds Max has no "clear" button for an assigned bitmap, so this is the only
// way to simulate an unassigned/null noise map once one has been picked.
bool EnableSecondaryNoiseMap
<
    string UIName  = "Enable Secondary Noise Map";
    string UIGroup = "Secondary Noise Map";
    int    UIOrder = 33;
> = true;

Texture2D SecondaryNoiseMapTexture
<
    string UIName       = "Secondary Noise Map  (filmstrip atlas, see header comment)";
    string UIGroup      = "Secondary Noise Map";
    string ResourceType = "2D";
    int    UIOrder = 34;
>;

int SecondaryNoiseSliceCount
<
    string UIName   = "Atlas Slice Count  (GlyphFX-only, not tag data)";
    string UIGroup  = "Secondary Noise Map";
    string UIWidget = "Spinner";
    int    UIOrder = 35;
    float  UIMin = 1; float UIMax = 256; float UIStep = 1;
> = 32;

//#if SHOW_TAG_FIELDS
float SecondaryNoiseBorderTexelsH
<
    string UIName   = "Atlas Border Texels - Horizontal  (GlyphFX-only, not tag data)";
    string UIGroup  = "Secondary Noise Map";
    string UIWidget = "slider";
    int    UIOrder = 36;
    float  UIMin = 0; float UIMax = 16; float UIStep = 0.5;
> = 3.0;

float SecondaryNoiseBorderTexelsV
<
    string UIName   = "Atlas Border Texels - Vertical  (GlyphFX-only, not tag data)";
    string UIGroup  = "Secondary Noise Map";
    string UIWidget = "slider";
    int    UIOrder = 37;
    float  UIMin = 0; float UIMax = 16; float UIStep = 0.5;
> = 4.0;
//#endif // SHOW_TAG_FIELDS

// ----------------------------------------------------------------------------
// Debug Parameters  (GlyphFX-only, not tag data)
//  0 = normal render
//  1 = primary noise map raw
//  2 = secondary noise map raw
//  3 = plasma mask (raw, before tint)
//  4 = view-angle tint (Diff.rgb)
// ----------------------------------------------------------------------------
int DebugMode
<
    string UIName   = "Debug Mode  [0=Normal 1=Noise A 2=Noise B 3=Plasma Mask 4=View Tint]";
    string UIGroup  = "Debug Parameters";
    string UIWidget = "Spinner";
    int    UIOrder = 38;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

#endif // GLYPHFX_TRANSPARENT_PLASMA_PARAMS_FXH
