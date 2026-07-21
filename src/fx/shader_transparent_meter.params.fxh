// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_meter.params.fxh
//
// All UI-exposed parameters for shader_transparent_meter.
// Field names, grouping and ranges below are transcribed from Guerrilla's
// shader_transparent_meter tag editor so this file doubles as an accurate
// reference of the real tag schema, not just a viewport control panel.
// Every tag field is present with its exact name even where the 3ds Max
// viewport can't act on it (no game object driving the function sources) -
// those are called out per-field rather than hidden.
//
//   Guerrilla group             → UIGroup here
//   "radiosity properties"        "Shader General Fields"  (base Shader struct)
//   "physics properties"          "Shader General Fields"  (material type)
//   "meter shader"                "Meter Shader Flags" + "Map"
//   "colors"                      "Colors"
//   "external function sources"   "External Function Sources"
//
// NOTE ON THE TWO "tint color" FIELDS: the base Shader struct has a radiosity
// "tint color" and the meter group has its own "tint color" (named
// "meter tint color" in the tag definition).  HLSL needs unique identifiers,
// so the radiosity one is TintColor and the meter one is MeterTintColor.
//
// The VS/PS I/O structs used by this shader (TM_VS_INPUT / TM_VS_OUTPUT /
// TM_PS_INPUT) live in _structs.fxh - no lighting, no normals; just clip-space
// position and one UV channel.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_TRANSPARENT_METER_PARAMS_FXH
#define GLYPHFX_TRANSPARENT_METER_PARAMS_FXH

// ----------------------------------------------------------------------------
// Shader General Fields  (base "Shader" tag struct)
//   Guerrilla "radiosity properties" + "physics properties".
//   Radiosity is baked offline by the tools and physics only matters in
//   structure BSP uses, so none of these affect the viewport render - they
//   are here for tag fidelity.
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
    string UIName   = "Tint Color  (radiosity)";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "Color";
    int    UIOrder = 6;
> = float4(1, 1, 1, 1);

// Physics properties - only relevant in structure BSP uses.
//   0=Dirt  1=Sand  2=Stone  3=Snow  4=Wood  5=Metal Hollow  6=Metal Thin
//   7=Metal Thick  8=Rubber  9=Glass  10=Force Field  11=Grunt
//   12=Hunter Armor  13=Hunter Skin  14=Elite  15=Jackal
//   16=Jackal Energy Shield  17=Engineer Skin  18=Engineer Force Field
//   19=Flood Combat Form  20=Flood Carrier Form  21=Cyborg Armor
//   22=Cyborg Energy Shield  23=Human Armor  24=Human Skin  25=Sentinel
//   26=Monitor  27=Plastic  28=Water  29=Leaves  30=Elite Energy Shield
//   31=Ice  32=Hunter Shield
float MaterialType
<
    string UIName   = "Material Type  (see enum in header comment)";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "slider";
    int    UIOrder = 7;
    float  UIMin = 0; float UIMax = 32; float UIStep = 1;
> = 0;

// ----------------------------------------------------------------------------
// Meter Shader Flags
//   Decal / Two Sided are handled by the render states in the .fx (the
//   viewport can't switch blend mode per-flag), so the booleans themselves
//   are informational.
// ----------------------------------------------------------------------------
bool Decal
<
    string UIName  = "Decal  (blend mode fixed by technique)";
    string UIGroup = "Meter Shader Flags";
    int    UIOrder = 8;
> = false;

bool TwoSided
<
    string UIName  = "Two Sided  (culling always off in viewport)";
    string UIGroup = "Meter Shader Flags";
    int    UIOrder = 9;
> = false;

bool FlashColorIsNegative
<
    string UIName  = "Flash Color Is Negative";
    string UIGroup = "Meter Shader Flags";
    int    UIOrder = 10;
> = false;

bool TintMode2
<
    string UIName  = "Tint Mode 2  (not implemented in viewport)";
    string UIGroup = "Meter Shader Flags";
    int    UIOrder = 11;
> = false;

bool Unfiltered
<
    string UIName  = "Unfiltered";
    string UIGroup = "Meter Shader Flags";
    int    UIOrder = 12;
> = false;

// ----------------------------------------------------------------------------
// Map
//   The meter map drives everything: .b is the fill/gradient ramp and
//   .a is the shape mask.
// ----------------------------------------------------------------------------
Texture2D MeterMap
<
    string UIName       = "Map";
    string UIGroup      = "Map";
    string ResourceType = "2D";
    int    UIOrder = 13;
>;

// ----------------------------------------------------------------------------
// Colors
//
// Notes on packing (matches the original transparent_meter.psh constants):
//
//   GradientMinColor  → c2.rgb  (c2.a is the meter fill level; see MeterValue)
//   GradientMaxColor  → c1.rgb + c1.a
//     c1.a  = gradient sensitivity: 0.125 maps t0.b [0,1] to a smooth full-range
//             gradient; 1.0 means the gradient sweeps only the lower 1/8 of t0.b.
//             Default 0.125 is the standard engine value for a 1-unit gradient.
//   BackgroundColor   → c3.rgb  (opacity = 1 - BackgroundTransparency)
//   FlashColor        → c0.rgb / c5.rgb * FlashBrightness
//   MeterTintColor    → c4.rgb  (c4.a is unused in base shader; see MeterTransparency)
// ----------------------------------------------------------------------------
float4 GradientMinColor
<
    string UIName   = "Gradient Min Color";
    string UIGroup  = "Colors";
    string UIWidget = "Color";
    int    UIOrder = 14;
> = float4(0.0, 0.0, 0.0, 1.0);

float4 GradientMaxColor
<
    //(Alpha channel = gradient sensitivity: 0.125 = full sweep, 1.0 = 1/8 sweep)
    string UIName   = "Gradient Max Color";
    string UIGroup  = "Colors";
    string UIWidget = "Color";
    int    UIOrder = 15;
> = float4(0.0, 0.0, 0.0, 0.125);

float4 BackgroundColor
<
    string UIName   = "Background Color";
    string UIGroup  = "Colors";
    string UIWidget = "Color";
    int    UIOrder = 16;
> = float4(0.0, 0.0, 0.0, 1.0);

float4 FlashColor
<
    string UIName   = "Flash Color";
    string UIGroup  = "Colors";
    string UIWidget = "Color";
    int    UIOrder = 17;
> = float4(0.0, 0.0, 0.0, 1.0);

// Guerrilla calls this simply "tint color"; renamed here to avoid clashing
// with the radiosity Tint Color above.  Applied in-engine as constant c4;
// the ported pixel shader does not modulate by it yet.
float4 MeterTintColor
<
    string UIName   = "Tint Color  (meter)  (not applied in viewport)";
    string UIGroup  = "Colors";
    string UIWidget = "Color";
    int    UIOrder = 18;
> = float4(0.0, 0.0, 0.0, 1.0);

float MeterTransparency
<
    string UIName   = "Meter Transparency  [0,1]";
    string UIGroup  = "Colors";
    string UIWidget = "slider";
    int    UIOrder = 19;
    float  UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.01;
> = 0.0;

float BackgroundTransparency
<
    string UIName   = "Background Transparency  [0,1]";
    string UIGroup  = "Colors";
    string UIWidget = "slider";
    int    UIOrder = 20;
    float  UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.01;
> = 0.0;

// ----------------------------------------------------------------------------
// External Function Sources
//
// Halo's Object Function A/B/C/D references - runtime scalars exported by
// scripts/devices on the parent object.  There is no game object driving them
// in the Max viewport, so they are exposed for schema fidelity only; use the
// Viewport Function Overrides below to preview a given state instead.
// ----------------------------------------------------------------------------
int MeterBrightnessSource
<
    string UIName   = "Meter Brightness Source  [0=None 1=A Out 2=B Out 3=C Out 4=D Out]  (not implemented in viewport)";
    string UIGroup  = "External Function Sources";
    string UIWidget = "Spinner";
    int    UIOrder = 21;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int FlashBrightnessSource
<
    string UIName   = "Flash Brightness Source  [0=None 1=A Out 2=B Out 3=C Out 4=D Out]  (see Flash Brightness)";
    string UIGroup  = "External Function Sources";
    string UIWidget = "Spinner";
    int    UIOrder = 22;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int ValueSource
<
    string UIName   = "Value Source  [0=None 1=A Out 2=B Out 3=C Out 4=D Out]  (see Meter Value)";
    string UIGroup  = "External Function Sources";
    string UIWidget = "Spinner";
    int    UIOrder = 23;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int GradientSource
<
    string UIName   = "Gradient Source  [0=None 1=A Out 2=B Out 3=C Out 4=D Out]  (not implemented in viewport)";
    string UIGroup  = "External Function Sources";
    string UIWidget = "Spinner";
    int    UIOrder = 24;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int FlashExtensionSource
<
    string UIName   = "Flash-Extension Source  [0=None 1=A Out 2=B Out 3=C Out 4=D Out]  (not implemented in viewport)";
    string UIGroup  = "External Function Sources";
    string UIWidget = "Spinner";
    int    UIOrder = 25;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

// ----------------------------------------------------------------------------
// Viewport Function Overrides  (GlyphFX-only, not tag data)
//
// In-engine the values below are driven at runtime by the function sources
// above.  In 3ds Max they are exposed as static sliders so the tag appearance
// can be previewed at any fill level or flash intensity.
// ----------------------------------------------------------------------------
float MeterValue
<
    string UIName   = "Meter Value  [0=Empty 1=Full]  (replaces value source)";
    string UIGroup  = "Viewport Function Overrides";
    string UIWidget = "slider";
    int    UIOrder = 26;
    float  UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.01;
> = 0.0;

float FlashBrightness
<
    string UIName   = "Flash Brightness  (replaces flash brightness source)";
    string UIGroup  = "Viewport Function Overrides";
    string UIWidget = "slider";
    int    UIOrder = 27;
    float  UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.01;
> = 0.0;

// ----------------------------------------------------------------------------
// Opacity Controls  (GlyphFX-only, not tag data)
// ----------------------------------------------------------------------------
float DitherScale
<
    string UIName   = "Dither Scale  (1 = full range)";
    string UIGroup  = "Opacity Controls";
    string UIWidget = "slider";
    int    UIOrder = 28;
    float  UIMin = 0.5; float UIMax = 2.0; float UIStep = 0.01;
> = 1.0;

#endif // GLYPHFX_TRANSPARENT_METER_PARAMS_FXH
