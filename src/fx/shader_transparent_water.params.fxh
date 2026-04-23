// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_water.params.fxh
//
// All UI-exposed parameters for shader_transparent_water.
// Matches the Guerrilla tag layout:
//   - water shader flags
//   - base map
//   - view perpendicular/parallel brightness & tint color
//   - reflection map (cubemap)
//   - ripple global properties
//   - ripple maps
//   - ripples block (max 4 entries)
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_TRANSPARENT_WATER_PARAMS_FXH
#define GLYPHFX_TRANSPARENT_WATER_PARAMS_FXH

// ----------------------------------------------------------------------------
// Viewport light
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
// Debug Parameters
// ----------------------------------------------------------------------------
//  0 = normal render
//  1 = base map
//  2 = ripple normal
//  3 = reflection only
int DebugMode
<
    string UIName   = "Debug Mode  [0=Normal  1=Base Map  2=Ripple Normal  3=Reflection Only]";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 3; float UIStep = 1;
> = 0;

float ReflectionIntensityScale
<
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 0.01;
> = 1.0;

float ReflectionBlur
<
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 8; float UIStep = 0.5;
> = 0.0;

float CubemapVOffset
<
    string UIWidget = "slider";
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float CubemapUOffset
<
    string UIWidget = "slider";
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

float CubemapPitch
<
    string UIWidget = "slider";
    float  UIMin = -1.57; float UIMax = 1.57; float UIStep = 0.01;
> = -0.0;

// ----------------------------------------------------------------------------
// Water Shader Flags
// ----------------------------------------------------------------------------
bool BaseMapAlphaModulatesReflection
<
    string UIName  = "Base Map Alpha Modulates Reflection";
    string UIGroup = "Water Shader Flags";
    int    UIOrder = 0;
> = false;

bool BaseMapColorModulatesBackground
<
    string UIName  = "Base Map Color Modulates Background";
    string UIGroup = "Water Shader Flags";
    int    UIOrder = 1;
> = false;

bool AtmosphericFog
<
    string UIName  = "Atmospheric Fog  (not implemented in viewport)";
    string UIGroup = "Water Shader Flags";
    int    UIOrder = 2;
> = false;

bool DrawBeforeFog
<
    string UIName  = "Draw Before Fog  (not implemented in viewport)";
    string UIGroup = "Water Shader Flags";
    int    UIOrder = 3;
> = false;

// ----------------------------------------------------------------------------
// Base Map
// ----------------------------------------------------------------------------
Texture2D BaseMapTexture
<
    string UIName       = "Base Map";
    string UIGroup      = "Base Map";
    string ResourceType = "2D";
    int    UIOrder = 10;
>;

bool EnableBaseMap
<
    string UIName  = "Enable Base Map";
    string UIGroup = "Base Map";
    int    UIOrder = 11;
> = false;

// ----------------------------------------------------------------------------
// Reflection Properties
//
// View perpendicular = looking straight at the surface (NdotV ≈ 1).
// View parallel      = looking at a glancing angle   (NdotV ≈ 0).
// ----------------------------------------------------------------------------
float ViewPerpendicularBrightness
<
    string UIName   = "View Perpendicular Brightness";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 20;
> = 0.0;

float4 ViewPerpendicularTintColor
<
    string UIName   = "View Perpendicular Tint Color";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "Color";
    int    UIOrder = 21;
> = float4(0, 0, 0, 1);

float ViewParallelBrightness
<
    string UIName   = "View Parallel Brightness";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 22;
> = 0.0;

float4 ViewParallelTintColor
<
    string UIName   = "View Parallel Tint Color";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "Color";
    int    UIOrder = 23;
> = float4(0, 0, 0, 1);

// IMPORTANT: HCE reflection maps are 2D cross-layout atlases, NOT DX11 cubemaps.
Texture2D ReflectionMapTexture
<
    string UIName       = "Reflection Map";
    string UIGroup      = "Reflection Properties";
    string ResourceType = "2D";
    int    UIOrder = 24;
>;

bool EnableReflectionMap
<
    string UIName  = "Enable Reflection Map";
    string UIGroup = "Reflection Properties";
    int    UIOrder = 25;
> = true;

// ----------------------------------------------------------------------------
// Ripple Properties (global)
// ----------------------------------------------------------------------------
float RippleAnimationAngle
<
    string UIName   = "Ripple Animation Angle";
    string UIGroup  = "Ripple Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 360; float UIStep = 1;
    int    UIOrder = 30;
> = 0.0;

float RippleAnimationVelocity
<
    string UIName   = "Ripple Animation Velocity  (not animated in viewport)";
    string UIGroup  = "Ripple Properties";
    string UIWidget = "slider";
    float  UIMin = -10; float UIMax = 10; float UIStep = 0.01;
    int    UIOrder = 31;
> = 0.0;

float RippleScale
<
    string UIName   = "Ripple Scale";
    string UIGroup  = "Ripple Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 32;
> = 0.0;

Texture2D RippleMapsTexture
<
    string UIName       = "Ripple Maps";
    string UIGroup      = "Ripple Properties";
    string ResourceType = "2D";
    int    UIOrder = 33;
>;

bool EnableRippleMaps
<
    string UIName  = "Enable Ripple Maps";
    string UIGroup = "Ripple Properties";
    int    UIOrder = 34;
> = false;

float RippleMipmapLevels
<
    string UIName   = "Ripple Mipmap Levels";
    string UIGroup  = "Ripple Properties";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 16; float UIStep = 1;
    int    UIOrder = 35;
> = 0.0;

float RippleMipmapFadeFactor
<
    string UIName   = "Ripple Mipmap Fade Factor";
    string UIGroup  = "Ripple Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 36;
> = 0.0;

float RippleMipmapDetailBias
<
    string UIName   = "Ripple Mipmap Detail Bias";
    string UIGroup  = "Ripple Properties";
    string UIWidget = "slider";
    float  UIMin = -10; float UIMax = 10; float UIStep = 0.01;
    int    UIOrder = 37;
> = 0.0;

// ----------------------------------------------------------------------------
// Ripple 0
// ----------------------------------------------------------------------------
bool EnableRipple0
<
    string UIName  = "Enable Ripple 0";
    string UIGroup = "Ripple 0";
    int    UIOrder = 40;
> = false;

float Ripple0_ContributionFactor
<
    string UIName   = "Contribution Factor";
    string UIGroup  = "Ripple 0";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 41;
> = 0.0;

float Ripple0_AnimationAngle
<
    string UIName   = "Animation Angle";
    string UIGroup  = "Ripple 0";
    string UIWidget = "slider";
    float  UIMin = -360; float UIMax = 360; float UIStep = 1;
    int    UIOrder = 42;
> = 0.0;

float Ripple0_AnimationVelocity
<
    string UIName   = "Animation Velocity  (not animated in viewport)";
    string UIGroup  = "Ripple 0";
    string UIWidget = "slider";
    float  UIMin = -10; float UIMax = 10; float UIStep = 0.01;
    int    UIOrder = 43;
> = 0.0;

float Ripple0_MapOffsetU
<
    string UIName   = "Map Offset i";
    string UIGroup  = "Ripple 0";
    string UIWidget = "Spinner";
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
    int    UIOrder = 44;
> = 0.0;

float Ripple0_MapOffsetV
<
    string UIName   = "Map Offset j";
    string UIGroup  = "Ripple 0";
    string UIWidget = "Spinner";
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
    int    UIOrder = 45;
> = 0.0;

float Ripple0_MapRepeats
<
    string UIName   = "Map Repeats";
    string UIGroup  = "Ripple 0";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 46;
> = 0.0;

float Ripple0_MapIndex
<
    string UIName   = "Map Index";
    string UIGroup  = "Ripple 0";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 16; float UIStep = 1;
    int    UIOrder = 47;
> = 0.0;

// ----------------------------------------------------------------------------
// Ripple 1
// ----------------------------------------------------------------------------
bool EnableRipple1
<
    string UIName  = "Enable Ripple 1";
    string UIGroup = "Ripple 1";
    int    UIOrder = 50;
> = false;

float Ripple1_ContributionFactor
<
    string UIName   = "Contribution Factor";
    string UIGroup  = "Ripple 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 51;
> = 0.0;

float Ripple1_AnimationAngle
<
    string UIName   = "Animation Angle";
    string UIGroup  = "Ripple 1";
    string UIWidget = "slider";
    float  UIMin = -360; float UIMax = 360; float UIStep = 1;
    int    UIOrder = 52;
> = 0.0;

float Ripple1_AnimationVelocity
<
    string UIName   = "Animation Velocity  (not animated in viewport)";
    string UIGroup  = "Ripple 1";
    string UIWidget = "slider";
    float  UIMin = -10; float UIMax = 10; float UIStep = 0.01;
    int    UIOrder = 53;
> = 0.0;

float Ripple1_MapOffsetU
<
    string UIName   = "Map Offset i";
    string UIGroup  = "Ripple 1";
    string UIWidget = "Spinner";
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
    int    UIOrder = 54;
> = 0.0;

float Ripple1_MapOffsetV
<
    string UIName   = "Map Offset j";
    string UIGroup  = "Ripple 1";
    string UIWidget = "Spinner";
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
    int    UIOrder = 55;
> = 0.0;

float Ripple1_MapRepeats
<
    string UIName   = "Map Repeats";
    string UIGroup  = "Ripple 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 56;
> = 0.0;

float Ripple1_MapIndex
<
    string UIName   = "Map Index";
    string UIGroup  = "Ripple 1";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 16; float UIStep = 1;
    int    UIOrder = 57;
> = 0.0;

// ----------------------------------------------------------------------------
// Ripple 2
// ----------------------------------------------------------------------------
bool EnableRipple2
<
    string UIName  = "Enable Ripple 2";
    string UIGroup = "Ripple 2";
    int    UIOrder = 60;
> = false;

float Ripple2_ContributionFactor
<
    string UIName   = "Contribution Factor";
    string UIGroup  = "Ripple 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 61;
> = 0.0;

float Ripple2_AnimationAngle
<
    string UIName   = "Animation Angle";
    string UIGroup  = "Ripple 2";
    string UIWidget = "slider";
    float  UIMin = -360; float UIMax = 360; float UIStep = 1;
    int    UIOrder = 62;
> = 0.0;

float Ripple2_AnimationVelocity
<
    string UIName   = "Animation Velocity  (not animated in viewport)";
    string UIGroup  = "Ripple 2";
    string UIWidget = "slider";
    float  UIMin = -10; float UIMax = 10; float UIStep = 0.01;
    int    UIOrder = 63;
> = 0.0;

float Ripple2_MapOffsetU
<
    string UIName   = "Map Offset i";
    string UIGroup  = "Ripple 2";
    string UIWidget = "Spinner";
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
    int    UIOrder = 64;
> = 0.0;

float Ripple2_MapOffsetV
<
    string UIName   = "Map Offset j";
    string UIGroup  = "Ripple 2";
    string UIWidget = "Spinner";
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
    int    UIOrder = 65;
> = 0.0;

float Ripple2_MapRepeats
<
    string UIName   = "Map Repeats";
    string UIGroup  = "Ripple 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 66;
> = 0.0;

float Ripple2_MapIndex
<
    string UIName   = "Map Index";
    string UIGroup  = "Ripple 2";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 16; float UIStep = 1;
    int    UIOrder = 67;
> = 0.0;

// ----------------------------------------------------------------------------
// Ripple 3
// ----------------------------------------------------------------------------
bool EnableRipple3
<
    string UIName  = "Enable Ripple 3";
    string UIGroup = "Ripple 3";
    int    UIOrder = 70;
> = false;

float Ripple3_ContributionFactor
<
    string UIName   = "Contribution Factor";
    string UIGroup  = "Ripple 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 71;
> = 0.0;

float Ripple3_AnimationAngle
<
    string UIName   = "Animation Angle";
    string UIGroup  = "Ripple 3";
    string UIWidget = "slider";
    float  UIMin = -360; float UIMax = 360; float UIStep = 1;
    int    UIOrder = 72;
> = 0.0;

float Ripple3_AnimationVelocity
<
    string UIName   = "Animation Velocity  (not animated in viewport)";
    string UIGroup  = "Ripple 3";
    string UIWidget = "slider";
    float  UIMin = -10; float UIMax = 10; float UIStep = 0.01;
    int    UIOrder = 73;
> = 0.0;

float Ripple3_MapOffsetU
<
    string UIName   = "Map Offset i";
    string UIGroup  = "Ripple 3";
    string UIWidget = "Spinner";
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
    int    UIOrder = 74;
> = 0.0;

float Ripple3_MapOffsetV
<
    string UIName   = "Map Offset j";
    string UIGroup  = "Ripple 3";
    string UIWidget = "Spinner";
    float  UIMin = -256; float UIMax = 256; float UIStep = 1;
    int    UIOrder = 75;
> = 0.0;

float Ripple3_MapRepeats
<
    string UIName   = "Map Repeats";
    string UIGroup  = "Ripple 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 200; float UIStep = 0.1;
    int    UIOrder = 76;
> = 0.0;

float Ripple3_MapIndex
<
    string UIName   = "Map Index";
    string UIGroup  = "Ripple 3";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 16; float UIStep = 1;
    int    UIOrder = 77;
> = 0.0;

// ----------------------------------------------------------------------------
// Other Properties
// ----------------------------------------------------------------------------
float c_alpha_ref
<
    string UIGroup  = "Other Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.5;

float4 c_fog_color_correction_0
<
    string UIGroup  = "Other Properties";
    string UIWidget = "Color";
> = float4(0.5, 0.6, 0.7, 1);

float4 c_fog_color_correction_E
<
    string UIGroup  = "Other Properties";
    string UIWidget = "Color";
> = float4(0, 0, 0, 0);

float4 c_fog_color_correction_1
<
    string UIGroup  = "Other Properties";
    string UIWidget = "Color";
> = float4(1, 1, 1, 1);

#endif // GLYPHFX_TRANSPARENT_WATER_PARAMS_FXH
