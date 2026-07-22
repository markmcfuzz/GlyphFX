// ----------------------------------------------------------------------------
// GlyphFX | fx/model.params.fxh
//
// All UI-exposed parameters for shader_model.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_MODEL_PARAMS_FXH
#define GLYPHFX_MODEL_PARAMS_FXH

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
    string UIName   = "Light Color";
    string UIWidget = "Color";
> = float3(1.0, 1.0, 1.0);
#endif

float4 AmbientColor
<
    string UIName   = "Ambient Color";
    string UIWidget = "Color";
> = float4(0.3, 0.3, 0.3, 1.0);

float4 FillLightColor
<
    string UIName   = "Fill Light Color";
    string UIWidget = "Color";
> = float4(0.3, 0.3, 0.35, 1.0);

float SpecularPower
<
    string UIWidget = "slider";
    float  UIMin = 1.0; float UIMax = 128.0; float UIStep = 1.0;
> = 24.0;

float LampIntensity
<
    string UIName   = "Light Intensity  (Scene Light)";
    string UIWidget = "slider";
    float  UIMin = 0.0; float UIMax = 2.0; float UIStep = 0.01;
> = 0.6;

float DitherScale
<
    //string UIName   = "Dither Scale  (1 = full range)";
    string UIGroup  = "Shader Model Flags";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 1.0;

// Debug parameter to adjust reflection intensity without affecting diffuse lighting, for testing cube map loading and alignment.
float ReflectionIntensityScale
<
    //string UIName   = "Debug Reflection Intensity Scale";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 0.01;
> = 1.0;

float ReflectionBlur
<
    //string UIName   = "Debug Reflection Blur  (0=sharp, 1=full blur)";
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
    //string UIName   = "Cubemap Pitch Rotation (radians)";
    string UIWidget = "slider";
    float  UIMin = -1.57; float UIMax = 1.57; float UIStep = 0.01;
> = -0.0;

// ----------------------------------------------------------------------------
// Radiosity Properties
// ----------------------------------------------------------------------------
bool SimpleParameterization
<
    string UIName = "Simple Parameterization";
    string UIGroup = "Shader General Fields";
    int    UIOrder = 0;
> = false;

bool IgnoreNormals
<
    string UIName = "Ignore Normals";
    string UIGroup = "Shader General Fields";
    int    UIOrder = 1;
> = false;

bool TransparentLit
<
    string UIName = "Transparent Lit";
    string UIGroup = "Shader General Fields";
    int    UIOrder = 2;
> = false;

int DetailLevel
<
    string UIName   = "Detail Level  [0=High  1=Medium  2=Low 3=Turd]";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 3; float UIStep = 1;
    int    UIOrder = 3;
> = 0;

float Power
<
    string UIName   = "Power";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "slider";
    float  UIMin = -0; float UIMax = 9999; float UIStep = 1;
    int    UIOrder = 4;
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

// ----------------------------------------------------------------------------
// Physics Properties
// ----------------------------------------------------------------------------
float MaterialType
<
    string UIName   = "Material Type";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 32; float UIStep = 1;
    int    UIOrder = 7;
> = 0;

// ----------------------------------------------------------------------------
// Shader Model Fields
// ----------------------------------------------------------------------------
bool DetailAfterReflection
<
    string UIName  = "Detail After Reflection";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 8;
> = false;

bool TwoSided
<
    string UIName  = "Two Sided";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 9;
> = false;

bool NotAlphaTested
<
    string UIName  = "Not Alpha Tested";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 10;
> = false;

bool AlphaBlendedDecal
<
    string UIName  = "Alpha Blended Decal";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 11;
> = false;

bool TrueAtmosphericFog
<
    string UIName  = "True Atmospheric Fog";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 12;
> = false;

bool DisableTwoSidedCulling
<
    string UIName   = "Disable Two-Sided Culling";
    string UIGroup  = "Shader Model Flags";
    int    UIOrder = 13;
> = false;

bool UseXboxChannelOrder
<
    string UIName  = "Use Xbox Multipurpose Channel Order";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 14;
> = false;

float Translucency
<
    string UIName   = "Translucency";
    string UIGroup  = "Shader Model Flags";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 15;
> = 0.0000000;

// ----------------------------------------------------------------------------
// Change Color
// ----------------------------------------------------------------------------
int ChangeColorSource
<
    string UIName   = "Change Color Source  [0=none  1=A  2=B  3=C  4=D]";
    string UIGroup  = "Change Color Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
    int    UIOrder = 16;
> = 0;

float4 ChangeColor
<
    string UIName   = "Change Color (Only for 3ds Max)";
    string UIGroup  = "Change Color Properties";
    string UIWidget = "Color";
    int    UIOrder = 17;
> = float4(1, 1, 1, 1);

// ----------------------------------------------------------------------------
// Self Illumination Color
// ----------------------------------------------------------------------------
bool NoRandomPhaseFlag
<
    string UIName = "No Random Phase";
    string UIGroup = "Self Illumination Properties";
    int UIOrder = 18;
> = false;

int SelfIlluminationColorSource
<
    string UIName = "Self Illum Color Source";
    string UIGroup = "Self Illumination Properties";
    string UIWidget = "slider";
    float UIMin = 0; float UIMax = 4; float UIStep = 1;
    int UIOrder = 19;
> = 0.0;

int SelfIlluminationAnimationFunction
<
    string UIName   = "Self Illum Animation Function [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "Self Illumination Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 20;
> = 0;

float4 AnimationColorLowerBound
<
    string UIName = "Animation Color Lower Bound";
    string UIGroup = "Self Illumination Properties";
    string UIWidget = "Color";
    int UIOrder = 21;
> = float4(0, 0, 0, 0);

float4 AnimationColorUpperBound
<
    string UIName = "Animation Color Upper Bound";
    string UIGroup = "Self Illumination Properties";
    string UIWidget = "Color";
    int UIOrder = 22;
> = float4(0, 0, 0, 0);

float4 SelfIlluminationColor
<
    string UIName   = "Self Illumination Color (Only for 3ds Max)";
    string UIGroup  = "Self Illumination Properties";
    string UIWidget = "Color";
    int    UIOrder = 23;
> = float4(0, 0, 0, 0);

float MapUScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Base Map Properties";
    string UIWidget = "slider";
    float  UIMin = -64; float UIMax = 64; float UIStep = 0.01;
    int    UIOrder = 24;
> = 1.0;

float MapVScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Base Map Properties";
    string UIWidget = "slider";
    float  UIMin = -64; float UIMax = 64; float UIStep = 0.01;
    int    UIOrder = 25;
> = 1.0;

bool EnableBaseMap
<
    string UIName  = "Enable Base Map..................(only for 3ds Max)";
    string UIGroup = "Shader Model Flags";
    int    UIOrder =26;
> = true;

Texture2D BaseMapTexture
<
    string UIName       = "Base Map";
    string UIGroup      = "Base Map Properties";
    string ResourceType = "2D";
    int    UIOrder = 27;
>;

// ----------------------------------------------------------------------------
// Multipurpose Properties
// ----------------------------------------------------------------------------
bool EnableMultipurposeMap
<
    string UIName  = "Enable Multipurpose Map........(only for 3ds Max)";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 28;
> = true;

Texture2D MultipurposeMapTexture
<
    string UIName       = "Multipurpose Map";
    string UIGroup      = "Multipurpose Properties";
    string ResourceType = "2D";
    int    UIOrder = 29;
>;

int DetailFunction
<
    string UIName   = "Detail Function  [0=Double Biased Multiply  1=Multiply  2=Biased Add]";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
    int    UIOrder = 30;
> = 0;

int DetailMask
<
    string UIName   = "Detail Mask  [0=None  1=Refl_Inv  2=Refl  3=SI_Inv  4=SI  5=CC_Inv  6=CC  7=Aux_Inv  8=Aux]";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
    int    UIOrder = 31;
> = 0;

float DetailMapScale
<
    string UIName   = "Detail Map Scale";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 64; float UIStep = 0.01;
    int    UIOrder = 32;
> = 1.0;

bool EnableDetailMap
<
    string UIName  = "Enable Detail Map.................(only for 3ds Max)";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 33;
> = true;

Texture2D DetailMapTexture
<
    string UIName       = "Detail Map";
    string UIGroup      = "Multipurpose Properties";
    string ResourceType = "2D";
    int    UIOrder = 34;
>;

float DetailMapVScale
<
    string UIName   = "Detail Map V Scale";
    string UIGroup  = "Multipurpose Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 64; float UIStep = 0.01;
    int    UIOrder = 35;
> = 0.0;

// ----------------------------------------------------------------------------
// Texture Scrolling Animation
// ----------------------------------------------------------------------------
int UAnimationSource
<
    string UIName   = "U Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 36;
> = 0;

int UAnimationFunction
<
    string UIName   = "U Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 37;
> = 0;

float UAnimationPeriod
<
    string UIName   = "U Animation Period................(Seconds)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 38;
> = 0.0;

float UAnimationPhase
<
    string UIName   = "U Animation Phase";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 39;
> = 0.0;

float UAnimationScale
<
    string UIName   = "U Animation Scale................(Repeats)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 40;
> = 0.0;

float VAnimationSource
<
    string UIName   = "V Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 41;
> = 0;

float VAnimationFunction
<
    string UIName   = "V Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 42;
> = 0;

float VAnimationPeriod
<
    string UIName   = "V Animation Period................(Seconds)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 43;
> = 0.0;

float VAnimationPhase
<
    string UIName   = "V Animation Phase";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 44;
> = 0.0;

float VAnimationScale
<
    string UIName   = "V Animation Scale................(Repeats)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 45;
> = 0.0;

float RotationAnimationSource
<
    string UIName   = "Rotation Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 46;
> = 0;

float RotationAnimationFunction
<
    string UIName   = "Rotation Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 47;
> = 0;

float RotationAnimationPeriod
<
    string UIName   = "Rotation Animation Period................(Seconds)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 48;
> = 0.0;

float RotationAnimationPhase
<
    string UIName   = "Rotation Animation Phase";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 49;
> = 0.0;

float RotationAnimationScale
<
    string UIName   = "Rotation Animation Scale................(Repeats)";
    string UIGroup  = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 50;
> = 0.0;

//Deprecated to split into 2 params
//float2 AnimationCenter
//<
//    string UIName   = "Animation Center";
//    string UIGroup  = "Texture Scrolling Animation";
//    string UIWidget = "Vector2";
//    int    UIOrder = 51;
//> = float2(0.000000, 0.000000);

float RotationAnimationCenterX
<
    string UIName = "Animation Center X";
    string UIGroups = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float UIMin = -1000000; float UIMax = 1000000; float UIStep = 0.1;
    int UIOrder = 51; 
> = 0.0;

float RotationAnimationCenterY
<
    string UIName = "Animation Center Y";
    string UIGroups = "Texture Scrolling Animation";
    string UIWidget = "slider";
    float UIMin = -1000000; float UIMax = 1000000; float UIStep = 0.1;
    int UIOrder = 52; 
> = 0.0;

// ----------------------------------------------------------------------------
// Reflection Properties
// ----------------------------------------------------------------------------

float PerpendicularBrightness
<
    string UIName   = "Perpendicular Brightness";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 53;
> = 0.0;

float4 PerpendicularTintColor
<
    string UIName   = "Perpendicular Tint Color";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "Color";
    int    UIOrder = 54;
> = float4(1, 1, 1, 1);

float ParallelBrightness
<
    string UIName   = "Parallel Brightness";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
    int    UIOrder = 55;
> = 0.0;

float4 ParallelTintColor
<
    string UIName   = "Parallel Tint Color";
    string UIGroup  = "Reflection Properties";
    string UIWidget = "Color";
    int    UIOrder = 56;
> = float4(1, 1, 1, 1);

int ReflectionMask
<
    string UIGroup  = "Reflection Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
    int    UIOrder = 57;
> = 0;

bool EnableReflectionCube
<
    string UIName  = "Enable Reflection Cube..........(only for 3ds Max)";
    string UIGroup = "Shader Model Flags";
    int    UIOrder = 58;
> = true;

// IMPORTANT: HCE reflection maps are 2D cross-layout atlases, NOT DX11 cubemaps.
Texture2D ReflectionCubeTexture
<
    string UIName       = "Reflection Cube Map";
    string UIGroup      = "Reflection Properties";
    string ResourceType = "2D";
    int    UIOrder = 59;
>;

// ----------------------------------------------------------------------------
// Debug Parameters
// These are not intended for artistic control, but are useful for inspecting
// ----------------------------------------------------------------------------
// Debug visualisation - set to non-zero to inspect individual channels.
//  0 = normal render
//  1 = base map (unlit)
//  2 = multipurpose map RGB
//  3 = mp.R channel (grayscale)
//  4 = mp.G channel (grayscale)  <- self-illumination mask
//  5 = mp.B channel (grayscale)  <- PC specular/reflection mask
//  6 = mp.A channel (grayscale)  <- PC change-color mask
//  7 = detail map (unlit)
//  8 = reflection only (no diffuse) - tests whether cube map is loading
int DebugMode
<
    string UIName   = "Debug Mode  [0=Off  1=Base  2=MP.RGB  3=MP.R  4=MP.G  5=MP.B  6=MP.A  7=Detail  8=ReflOnly]";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
    int UIOrder = 60;
> = 0;

// ----------------------------------------------------------------------------
// Texture-connected flags
// DX11 samples unbound textures as black (0,0,0,0), which breaks blend modes
// that expect a neutral value. Set each flag only when the texture is assigned.
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// Other Properties (Hidden in 3ds Max UI)
// ----------------------------------------------------------------------------
float c_alpha_ref
<
    string UIGroup  = "Other Properties";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.5;

float4 c_fog_color
<
    string UIGroup  = "Other Properties";
    string UIWidget = "Color";
> = float4(0.5, 0.6, 0.7, 1);

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


#endif // GLYPHFX_MODEL_PARAMS_FXH