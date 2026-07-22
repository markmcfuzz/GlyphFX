// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_water.params.fxh
//
// All UI-exposed parameters for shader_transparent_water.
// Field names, grouping and ranges below are transcribed from Guerrilla's
// shader_transparent_water tag editor so this file doubles as an accurate
// reference of the real tag schema, not just a viewport control panel.
// Every tag field is present with its exact name even where the 3ds Max
// viewport can't act on it (no time source, no fog, no BSP) - those are
// called out per-field rather than hidden.
//
//   Guerrilla group          → UIGroup here
//   "radiosity properties"     "Shader General Fields"  (base Shader struct)
//   "physics properties"       "Shader General Fields"  (material type)
//   "water shader"             "Water Shader Flags" + "Base Map"
//                              + "Reflection Properties" + "Ripple Properties"
//   "RIPPLES" (reflexive)      "Ripple 0" .. "Ripple 3"  (max 4 entries)
//
// Guerrilla's own description of the water shader group:
//   "Base map color modulates the background, while base map alpha modulates
//    reflection brightness.  Both of these effects can be independently
//    enabled and disabled.  Note that if the <base map alpha modulates
//    reflection> flag is not set, then the perpendicular/parallel brightness
//    has no effect (but the perpendicular/parallel tint color DOES have an
//    effect)."
//
// Enable* booleans are GlyphFX-only: 3ds Max has no way to clear an assigned
// bitmap once picked, so they are the only way to preview "this map isn't
// really set".  Each one sits immediately above the texture it gates.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_TRANSPARENT_WATER_PARAMS_FXH
#define GLYPHFX_TRANSPARENT_WATER_PARAMS_FXH

// ----------------------------------------------------------------------------
// Viewport light  (GlyphFX-only, not tag data)
// ----------------------------------------------------------------------------
float3 LampPos : POSITION
<
    string Object = "PointLight0";
    string Space  = "World";
    int    refID  = 0;
> = float3(-50.0, 150.0, 100.0);

#ifdef _MAX_
float3 LampColor : LIGHTCOLOR
<
    int    LightRef = 0;
    string UIWidget = "None";
> = float3(1.0, 1.0, 1.0);
#else
float3 LampColor
<
    string UIWidget = "Color";
> = float3(1.0, 1.0, 1.0);
#endif

float4 AmbientColor
<
    string UIName   = "Lightmap Ambient Color";
    string UIWidget = "Color";
> = float4(0.3, 0.3, 0.3, 1.0);

float4 FillLightColor
<
    string UIName   = "Fill Light Color";
    string UIWidget = "Color";
> = float4(0.3, 0.3, 0.35, 1.0);

float LampIntensity
<
    string UIName   = "Light Power";
    string UIWidget = "slider";
    float  UIMin = 0.0; float UIMax = 2.0; float UIStep = 0.01;
> = 0.6;

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
    string UIName   = "Tint Color";
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
// Water Shader Flags
// ----------------------------------------------------------------------------
bool BaseMapAlphaModulatesReflection
<
    string UIName  = "Base Map Alpha Modulates Reflection";
    string UIGroup = "Water Shader Flags";
    int    UIOrder = 8;
> = false;

bool BaseMapColorModulatesBackground
<
    string UIName  = "Base Map Color Modulates Background";
    string UIGroup = "Water Shader Flags";
    int    UIOrder = 9;
> = false;

bool AtmosphericFog
<
    string UIName  = "Atmospheric Fog  (not implemented in viewport)";
    string UIGroup = "Water Shader Flags";
    int    UIOrder = 10;
> = false;

bool DrawBeforeFog
<
    string UIName  = "Draw Before Fog  (not implemented in viewport)";
    string UIGroup = "Water Shader Flags";
    int    UIOrder = 11;
> = false;

// ----------------------------------------------------------------------------
// Base Map
// ----------------------------------------------------------------------------
bool EnableBaseMap
<
    string UIName  = "Enable Base Map";
    string UIGroup = "Base Map";
    int    UIOrder = 12;
> = false;

Texture2D BaseMapTexture
<
    string UIName       = "Base Map";
    string UIGroup      = "Base Map";
    string ResourceType = "2D";
    int    UIOrder = 13;
>;

// ----------------------------------------------------------------------------
// Reflection Properties
//
// View perpendicular = looking straight at the surface (NdotV ≈ 1).
// View parallel      = looking at a glancing angle   (NdotV ≈ 0).
// ----------------------------------------------------------------------------
float ViewPerpendicularBrightness
<
    string UIName   = "View Perpendicular Brightness  [0,1]";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    int    UIOrder = 14;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float4 ViewPerpendicularTintColor
<
    string UIName   = "View Perpendicular Tint Color";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "Color";
    int    UIOrder = 15;
> = float4(0, 0, 0, 1);

float ViewParallelBrightness
<
    string UIName   = "View Parallel Brightness  [0,1]";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    int    UIOrder = 16;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float4 ViewParallelTintColor
<
    string UIName   = "View Parallel Tint Color";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "Color";
    int    UIOrder = 17;
> = float4(0, 0, 0, 1);

bool EnableReflectionMap
<
    string UIName  = "Enable Reflection Map";
    string UIGroup = "Reflection Properties";
    int    UIOrder = 18;
> = false;

// IMPORTANT: HCE reflection maps are 2D cross-layout atlases, NOT DX11 cubemaps.
Texture2D ReflectionMapTexture
<
    string UIName       = "Reflection Map";
    string UIGroup      = "Reflection Properties";
    string ResourceType = "2D";
    int    UIOrder = 19;
>;

// ----------------------------------------------------------------------------
// Ripple Properties (global)
// ----------------------------------------------------------------------------
float RippleAnimationAngle
<
    string UIName   = "Ripple Animation Angle  [0,360]";
    string UIGroup  = "Ripple Properties";
    string UIWidget = "slider";
    int    UIOrder = 20;
    float  UIMin = 0; float UIMax = 360; float UIStep = 1;
> = 0.0;

float RippleAnimationVelocity
<
    string UIName   = "Ripple Animation Velocity  (not animated in viewport)";
    string UIGroup  = "Ripple Properties";
    string UIWidget = "slider";
    int    UIOrder = 21;
    float  UIMin = -10; float UIMax = 10; float UIStep = 0.01;
> = 0.0;

float RippleScale
<
    string UIName   = "Ripple Scale";
    string UIGroup  = "Ripple Properties";
    string UIWidget = "slider";
    int    UIOrder = 22;
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
> = 0.0;

bool EnableRippleMaps
<
    string UIName  = "Enable Ripple Maps";
    string UIGroup = "Ripple Properties";
    int    UIOrder = 23;
> = false;

Texture2D RippleMapsTexture
<
    string UIName       = "Ripple Maps";
    string UIGroup      = "Ripple Properties";
    string ResourceType = "2D";
    int    UIOrder = 24;
>;

float RippleMipmapLevels
<
    string UIName   = "Ripple Mipmap Levels";
    string UIGroup  = "Ripple Properties";
    string UIWidget = "Spinner";
    int    UIOrder = 25;
    float  UIMin = 0; float UIMax = 16; float UIStep = 1;
> = 0.0;

float RippleMipmapFadeFactor
<
    string UIName   = "Ripple Mipmap Fade Factor  [0,1]";
    string UIGroup  = "Ripple Properties";
    string UIWidget = "slider";
    int    UIOrder = 26;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float RippleMipmapDetailBias
<
    string UIName   = "Ripple Mipmap Detail Bias";
    string UIGroup  = "Ripple Properties";
    string UIWidget = "slider";
    int    UIOrder = 27;
    float  UIMin = -10; float UIMax = 10; float UIStep = 0.01;
> = 0.0;

// ----------------------------------------------------------------------------
// Ripple 0   (RIPPLES reflexive entry 0 - always active)
// ----------------------------------------------------------------------------
bool EnableRipple0
<
    string UIName  = "Enable Ripple 0";
    string UIGroup = "Ripple 0";
    int    UIOrder = 28;
> = false;

float Ripple0_ContributionFactor
<
    string UIName   = "Contribution Factor  [0,1]";
    string UIGroup  = "Ripple 0";
    string UIWidget = "slider";
    int    UIOrder = 29;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float Ripple0_AnimationAngle
<
    string UIName   = "Animation Angle  [0,360]";
    string UIGroup  = "Ripple 0";
    string UIWidget = "slider";
    int    UIOrder = 30;
    float  UIMin = 0; float UIMax = 360; float UIStep = 1;
> = 0.0;

float Ripple0_AnimationVelocity
<
    string UIName   = "Animation Velocity  (not animated in viewport)";
    string UIGroup  = "Ripple 0";
    string UIWidget = "slider";
    int    UIOrder = 31;
    float  UIMin = -10; float UIMax = 10; float UIStep = 0.01;
> = 0.0;

float Ripple0_MapOffsetU
<
    string UIName   = "Map Offset (i)";
    string UIGroup  = "Ripple 0";
    string UIWidget = "Spinner";
    int    UIOrder = 32;
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
> = 0.0;

float Ripple0_MapOffsetV
<
    string UIName   = "Map Offset (j)";
    string UIGroup  = "Ripple 0";
    string UIWidget = "Spinner";
    int    UIOrder = 33;
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
> = 0.0;

float Ripple0_MapRepeats
<
    string UIName   = "Map Repeats";
    string UIGroup  = "Ripple 0";
    string UIWidget = "slider";
    int    UIOrder = 34;
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
> = 0.0;

float Ripple0_MapIndex
<
    string UIName   = "Map Index";
    string UIGroup  = "Ripple 0";
    string UIWidget = "Spinner";
    int    UIOrder = 35;
    float  UIMin = 0; float UIMax = 16; float UIStep = 1;
> = 0.0;

// ----------------------------------------------------------------------------
// Ripple 1   (RIPPLES reflexive entry 1)
// ----------------------------------------------------------------------------
bool EnableRipple1
<
    string UIName  = "Enable Ripple 1";
    string UIGroup = "Ripple 1";
    int    UIOrder = 36;
> = false;

float Ripple1_ContributionFactor
<
    string UIName   = "Contribution Factor  [0,1]";
    string UIGroup  = "Ripple 1";
    string UIWidget = "slider";
    int    UIOrder = 37;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float Ripple1_AnimationAngle
<
    string UIName   = "Animation Angle  [0,360]";
    string UIGroup  = "Ripple 1";
    string UIWidget = "slider";
    int    UIOrder = 38;
    float  UIMin = 0; float UIMax = 360; float UIStep = 1;
> = 0.0;

float Ripple1_AnimationVelocity
<
    string UIName   = "Animation Velocity  (not animated in viewport)";
    string UIGroup  = "Ripple 1";
    string UIWidget = "slider";
    int    UIOrder = 39;
    float  UIMin = -10; float UIMax = 10; float UIStep = 0.01;
> = 0.0;

float Ripple1_MapOffsetU
<
    string UIName   = "Map Offset (i)";
    string UIGroup  = "Ripple 1";
    string UIWidget = "Spinner";
    int    UIOrder = 40;
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
> = 0.0;

float Ripple1_MapOffsetV
<
    string UIName   = "Map Offset (j)";
    string UIGroup  = "Ripple 1";
    string UIWidget = "Spinner";
    int    UIOrder = 41;
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
> = 0.0;

float Ripple1_MapRepeats
<
    string UIName   = "Map Repeats";
    string UIGroup  = "Ripple 1";
    string UIWidget = "slider";
    int    UIOrder = 42;
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
> = 0.0;

float Ripple1_MapIndex
<
    string UIName   = "Map Index";
    string UIGroup  = "Ripple 1";
    string UIWidget = "Spinner";
    int    UIOrder = 43;
    float  UIMin = 0; float UIMax = 16; float UIStep = 1;
> = 0.0;

// ----------------------------------------------------------------------------
// Ripple 2   (RIPPLES reflexive entry 2)
// ----------------------------------------------------------------------------
bool EnableRipple2
<
    string UIName  = "Enable Ripple 2";
    string UIGroup = "Ripple 2";
    int    UIOrder = 44;
> = false;

float Ripple2_ContributionFactor
<
    string UIName   = "Contribution Factor  [0,1]";
    string UIGroup  = "Ripple 2";
    string UIWidget = "slider";
    int    UIOrder = 45;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float Ripple2_AnimationAngle
<
    string UIName   = "Animation Angle  [0,360]";
    string UIGroup  = "Ripple 2";
    string UIWidget = "slider";
    int    UIOrder = 46;
    float  UIMin = 0; float UIMax = 360; float UIStep = 1;
> = 0.0;

float Ripple2_AnimationVelocity
<
    string UIName   = "Animation Velocity  (not animated in viewport)";
    string UIGroup  = "Ripple 2";
    string UIWidget = "slider";
    int    UIOrder = 47;
    float  UIMin = -10; float UIMax = 10; float UIStep = 0.01;
> = 0.0;

float Ripple2_MapOffsetU
<
    string UIName   = "Map Offset (i)";
    string UIGroup  = "Ripple 2";
    string UIWidget = "Spinner";
    int    UIOrder = 48;
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
> = 0.0;

float Ripple2_MapOffsetV
<
    string UIName   = "Map Offset (j)";
    string UIGroup  = "Ripple 2";
    string UIWidget = "Spinner";
    int    UIOrder = 49;
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
> = 0.0;

float Ripple2_MapRepeats
<
    string UIName   = "Map Repeats";
    string UIGroup  = "Ripple 2";
    string UIWidget = "slider";
    int    UIOrder = 50;
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
> = 0.0;

float Ripple2_MapIndex
<
    string UIName   = "Map Index";
    string UIGroup  = "Ripple 2";
    string UIWidget = "Spinner";
    int    UIOrder = 51;
    float  UIMin = 0; float UIMax = 16; float UIStep = 1;
> = 0.0;

// ----------------------------------------------------------------------------
// Ripple 3   (RIPPLES reflexive entry 3)
// ----------------------------------------------------------------------------
bool EnableRipple3
<
    string UIName  = "Enable Ripple 3";
    string UIGroup = "Ripple 3";
    int    UIOrder = 52;
> = false;

float Ripple3_ContributionFactor
<
    string UIName   = "Contribution Factor  [0,1]";
    string UIGroup  = "Ripple 3";
    string UIWidget = "slider";
    int    UIOrder = 53;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float Ripple3_AnimationAngle
<
    string UIName   = "Animation Angle  [0,360]";
    string UIGroup  = "Ripple 3";
    string UIWidget = "slider";
    int    UIOrder = 54;
    float  UIMin = 0; float UIMax = 360; float UIStep = 1;
> = 0.0;

float Ripple3_AnimationVelocity
<
    string UIName   = "Animation Velocity  (not animated in viewport)";
    string UIGroup  = "Ripple 3";
    string UIWidget = "slider";
    int    UIOrder = 55;
    float  UIMin = -10; float UIMax = 10; float UIStep = 0.01;
> = 0.0;

float Ripple3_MapOffsetU
<
    string UIName   = "Map Offset (i)";
    string UIGroup  = "Ripple 3";
    string UIWidget = "Spinner";
    int    UIOrder = 56;
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
> = 0.0;

float Ripple3_MapOffsetV
<
    string UIName   = "Map Offset (j)";
    string UIGroup  = "Ripple 3";
    string UIWidget = "Spinner";
    int    UIOrder = 57;
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
> = 0.0;

float Ripple3_MapRepeats
<
    string UIName   = "Map Repeats";
    string UIGroup  = "Ripple 3";
    string UIWidget = "slider";
    int    UIOrder = 58;
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
> = 0.0;

float Ripple3_MapIndex
<
    string UIName   = "Map Index";
    string UIGroup  = "Ripple 3";
    string UIWidget = "Spinner";
    int    UIOrder = 59;
    float  UIMin = 0; float UIMax = 16; float UIStep = 1;
> = 0.0;

// ----------------------------------------------------------------------------
// Other Properties  (GlyphFX-only, not tag data)
// ----------------------------------------------------------------------------
float c_alpha_ref
<
    string UIGroup  = "Other Properties";
    string UIWidget = "slider";
    int    UIOrder = 60;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.5;

float4 c_fog_color_correction_0
<
    string UIGroup  = "Other Properties";
    string UIWidget = "Color";
    int    UIOrder = 61;
> = float4(0.5, 0.6, 0.7, 1);

float4 c_fog_color_correction_E
<
    string UIGroup  = "Other Properties";
    string UIWidget = "Color";
    int    UIOrder = 62;
> = float4(0, 0, 0, 0);

float4 c_fog_color_correction_1
<
    string UIGroup  = "Other Properties";
    string UIWidget = "Color";
    int    UIOrder = 63;
> = float4(1, 1, 1, 1);

// ----------------------------------------------------------------------------
// Debug Parameters  (GlyphFX-only, not tag data)
//  0 = normal render
//  1 = base map
//  2 = ripple normal
//  3 = reflection only
// ----------------------------------------------------------------------------
int DebugMode
<
    string UIName   = "Debug Mode  [0=Normal 1=Base Map 2=Ripple Normal 3=Reflection Only]";
    string UIGroup  = "Debug Parameters";
    string UIWidget = "Spinner";
    int    UIOrder = 64;
    float  UIMin = 0; float UIMax = 3; float UIStep = 1;
> = 0;

float ReflectionIntensityScale
<
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    int    UIOrder = 65;
    float  UIMin = 0; float UIMax = 4; float UIStep = 0.01;
> = 1.0;

float ReflectionBlur
<
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    int    UIOrder = 66;
    float  UIMin = 0; float UIMax = 8; float UIStep = 0.5;
> = 0.0;

float CubemapVOffset
<
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    int    UIOrder = 67;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float CubemapUOffset
<
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    int    UIOrder = 68;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float CubemapPitch
<
    string UIGroup  = "Debug Parameters";
    string UIWidget = "slider";
    int    UIOrder = 69;
    float  UIMin = -1.57; float UIMax = 1.57; float UIStep = 0.01;
> = -0.0;

#endif // GLYPHFX_TRANSPARENT_WATER_PARAMS_FXH
