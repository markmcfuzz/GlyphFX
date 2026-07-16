// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_chicago.params.fxh
//
// All UI-exposed parameters for shader_transparent_chicago.
// Matches the Guerrilla tag layout:
//   - global shader flags and framebuffer blend/fade settings
//   - up to 4 map stages; stages 2-4 activated with EnableMapN booleans
//   - per-map: flags, color/alpha blend function, UV transform, texture
//   - extra flags at the bottom
//
// Color/alpha function enum (applies to Maps 2-4):
//   0=current  1=next map  2=multiply  3=double multiply
//   4=add  5=add-signed current  6=add-signed next map  7=subtract
//
// Framebuffer blend function is informational only; select the matching
// technique in the DirectX Shader material to activate the correct blend mode.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_TRANSPARENT_CHICAGO_PARAMS_FXH
#define GLYPHFX_TRANSPARENT_CHICAGO_PARAMS_FXH

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
// Shader Chicago Attributes
// ----------------------------------------------------------------------------
int NumericCounterLimit
<
    string UIName   = "Numeric Counter Limit";
    string UIGroup  = "Shader Chicago Attributes";
    string UIWidget = "Spinner";
    int    UIOrder = 8;
    float  UIMin = 0; float UIMax = 255; float UIStep = 1;
> = 0;

bool AlphaTested
<
    string UIName  = "Alpha Tested";
    string UIGroup = "Shader Chicago Attributes";
    int    UIOrder = 9;
> = false;

bool Decal
<
    string UIName  = "Decal";
    string UIGroup = "Shader Chicago Attributes";
    int    UIOrder = 10;
> = false;

bool TwoSided
<
    string UIName  = "Two Sided";
    string UIGroup = "Shader Chicago Attributes";
    int    UIOrder = 11;
> = false;

bool FirstMapIsScreenspace
<
    string UIName  = "First Map Is Screenspace";
    string UIGroup = "Shader Chicago Attributes";
    int    UIOrder = 12;
> = false;

bool DrawBeforeWater
<
    string UIName  = "Draw Before Water";
    string UIGroup = "Shader Chicago Attributes";
    int    UIOrder = 13;
> = false;

bool IgnoreEffect
<
    string UIName  = "Ignore Effect";
    string UIGroup = "Shader Chicago Attributes";
    int    UIOrder = 14;
> = false;

bool ScaleFirstMapWithDistance
<
    string UIName  = "Scale First Map With Distance";
    string UIGroup = "Shader Chicago Attributes";
    int    UIOrder = 15;
> = false;

bool Numeric
<
    string UIName  = "Numeric";
    string UIGroup = "Shader Chicago Attributes";
    int    UIOrder = 16;
> = false;

// Informational - select the matching technique to activate the correct blend.
int FirstMapType
<
    string UIName   = "First Map Type [0=2D Map 1=Reflection Cubemap  2=Object Center Cubemap  3=Viewer Centered Cubemap]";
    string UIGroup  = "Shader Chicago Attributes";
    string UIWidget = "Spinner";
    int    UIOrder = 17;
    float  UIMin = 0; float UIMax = 3; float UIStep = 1;
> = 0;

int FramebufferBlendFunction
<
    string UIName   = "Framebuffer Blend Function [0=Alpha Blend  1=Multiply  2=Double Multiply  3=Add]";
    string UIGroup  = "Shader Chicago Attributes";
    string UIWidget = "Spinner";
    int    UIOrder = 18;
    float  UIMin = 0; float UIMax = 3; float UIStep = 1;
> = 0;

int FramebufferFadeMode
<
    string UIName   = "Framebuffer Fade Mode [0=None  1=Fade When Perpendicular  2=Fade When Parallel]";
    string UIGroup  = "Shader Chicago Attributes";
    string UIWidget = "Spinner";
    int    UIOrder = 19;
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
> = 0;

int FramebufferFadeSource
<
    string UIName   = "Framebuffer Fade Source [0=A Out  1=B Out  2=C Out  3=D Out]";
    string UIGroup  = "Shader Chicago Attributes";
    string UIWidget = "Spinner";
    int    UIOrder = 20;
    float  UIMin = 0; float UIMax = 3; float UIStep = 1;
> = 0;

int LensFlareSpacing
<
    string UIName   = "Lens Flare Spacing";
    string UIGroup  = "Shader Chicago Attributes";
    string UIWidget = "Spinner";
    int    UIOrder = 21;
    float  UIMin = 0; float UIMax = 255; float UIStep = 1;
> = 0;

Texture2D LensFlareReference
<
    string UIName       = "Lens Flare Reference";
    string UIGroup      = "Shader Chicago Attributes";
    string ResourceType = "2D";
    int    UIOrder = 22;
>;

// ----------------------------------------------------------------------------
// Map 1  (always active - the base stage)
// Color/alpha function is tag-visible but has no effect on the base stage.
// ----------------------------------------------------------------------------
bool Map1_Unfiltered
<
    string UIName  = "Unfiltered";
    string UIGroup = "Map 1 - Flags";
    int    UIOrder = 23;
> = false;

bool Map1_AlphaReplicate
<
    string UIName  = "Alpha Replicate";
    string UIGroup = "Map 1 - Flags";
    int    UIOrder = 24;
> = false;

bool Map1_UClamped
<
    string UIName  = "U Clamped";
    string UIGroup = "Map 1 - Flags";
    int    UIOrder = 25;
> = false;

bool Map1_VClamped
<
    string UIName  = "V Clamped";
    string UIGroup = "Map 1 - Flags";
    int    UIOrder = 26;
> = false;

int Map1_ColorFunction
<
    string UIName   = "Color Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 1";
    string UIWidget = "Spinner";
    int    UIOrder = 27;
    float  UIMin = 0; float UIMax = 13; float UIStep = 1;
> = 0;

int Map1_AlphaFunction
<
    string UIName   = "Alpha Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 1";
    string UIWidget = "Spinner";
    int    UIOrder = 28;
    float  UIMin = 0; float UIMax = 13; float UIStep = 1;
> = 0;

float Map1_UScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    int    UIOrder = 29;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map1_VScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    int    UIOrder = 30;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map1_UOffset
<
    string UIName   = "Map U Offset";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    int    UIOrder = 31;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map1_VOffset
<
    string UIName   = "Map V Offset";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    int    UIOrder = 32;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map1_Rotation
<
    string UIName   = "Map Rotation";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    int    UIOrder = 33;
    float  UIMin = -360; float UIMax = 360; float UIStep = 0.1;
> = 0.0;

float Map1_MipmapBias
<
    string UIName   = "Mipmap Bias";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    int    UIOrder = 34;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

Texture2D Map1Texture
<
    string UIName       = "Map";
    string UIGroup      = "Map 1";
    string ResourceType = "2D";
    int    UIOrder = 35;
>;

// ----------------------------------------------------------------------------
// 2D Texture Animation 1
// ----------------------------------------------------------------------------
int UAnimationSource1
<
    string UIName   = "U Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 36;
> = 0;

int UAnimationFunction1
<
    string UIName   = "U Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 37;
> = 0;

float UAnimationPeriod1
<
    string UIName   = "U Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 38;
> = 0.0;

float UAnimationPhase1
<
    string UIName   = "U Animation Phase";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 39;
> = 0.0;

float UAnimationScale1
<
    string UIName   = "U Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 40;
> = 0.0;

float VAnimationSource1
<
    string UIName   = "V Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 41;
> = 0;

float VAnimationFunction1
<
    string UIName   = "V Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 42;
> = 0;

float VAnimationPeriod1
<
    string UIName   = "V Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 43;
> = 0.0;

float VAnimationPhase1
<
    string UIName   = "V Animation Phase";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 44;
> = 0.0;

float VAnimationScale1
<
    string UIName   = "V Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 45;
> = 0.0;

float RotationAnimationSource1
<
    string UIName   = "Rotation Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 46;
> = 0;

float RotationAnimationFunction1
<
    string UIName   = "Rotation Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 47;
> = 0;

float RotationAnimationPeriod1
<
    string UIName   = "Rotation Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 48;
> = 0.0;

float RotationAnimationPhase1
<
    string UIName   = "Rotation Animation Phase";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 49;
> = 0.0;

float RotationAnimationScale1
<
    string UIName   = "Rotation Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 50;
> = 0.0;

float2 AnimationCenter1
<
    string UIName   = "Animation Center";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "Vector2";
    int    UIOrder = 51;
> = float2(0.000000, 0.000000);

// ----------------------------------------------------------------------------
// Map 2
// ----------------------------------------------------------------------------
bool EnableMap2
<
    string UIName  = "Enable Map 2";
    string UIGroup = "Map 2";
    int    UIOrder = 52;
> = false;

bool Map2_Unfiltered
<
    string UIName  = "Unfiltered";
    string UIGroup = "Map 2 - Flags";
    int    UIOrder = 53;
> = false;

bool Map2_AlphaReplicate
<
    string UIName  = "Alpha Replicate";
    string UIGroup = "Map 2 - Flags";
    int    UIOrder = 54;
> = false;

bool Map2_UClamped
<
    string UIName  = "U Clamped";
    string UIGroup = "Map 2 - Flags";
    int    UIOrder = 55;
> = false;

bool Map2_VClamped
<
    string UIName  = "V Clamped";
    string UIGroup = "Map 2 - Flags";
    int    UIOrder = 56;
> = false;

int Map2_ColorFunction
<
    string UIName   = "Color Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 2";
    string UIWidget = "Spinner";
    int    UIOrder = 57;
    float  UIMin = 0; float UIMax = 13; float UIStep = 1;
> = 0;

int Map2_AlphaFunction
<
    string UIName   = "Alpha Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 2";
    string UIWidget = "Spinner";
    int    UIOrder = 58;
    float  UIMin = 0; float UIMax = 13; float UIStep = 1;
> = 0;

float Map2_UScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    int    UIOrder = 59;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map2_VScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    int    UIOrder = 60;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map2_UOffset
<
    string UIName   = "Map U Offset";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    int    UIOrder = 61;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map2_VOffset
<
    string UIName   = "Map V Offset";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    int    UIOrder = 62;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map2_Rotation
<
    string UIName   = "Map Rotation";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    int    UIOrder = 63;
    float  UIMin = -360; float UIMax = 360; float UIStep = 0.1;
> = 0.0;

float Map2_MipmapBias
<
    string UIName   = "Mipmap Bias";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    int    UIOrder = 64;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

Texture2D Map2Texture
<
    string UIName       = "Map";
    string UIGroup      = "Map 2";
    string ResourceType = "2D";
    int    UIOrder = 65;
>;

// ----------------------------------------------------------------------------
// 2D Texture Animation 2
// ----------------------------------------------------------------------------
int UAnimationSource2
<
    string UIName   = "U Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 66;
> = 0;

int UAnimationFunction2
<
    string UIName   = "U Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 67;
> = 0;

float UAnimationPeriod2
<
    string UIName   = "U Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 68;
> = 0.0;

float UAnimationPhase2
<
    string UIName   = "U Animation Phase";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 69;
> = 0.0;

float UAnimationScale2
<
    string UIName   = "U Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 70;
> = 0.0;

float VAnimationSource2
<
    string UIName   = "V Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 71;
> = 0;

float VAnimationFunction2
<
    string UIName   = "V Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 72;
> = 0;

float VAnimationPeriod2
<
    string UIName   = "V Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 73;
> = 0.0;

float VAnimationPhase2
<
    string UIName   = "V Animation Phase";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 74;
> = 0.0;

float VAnimationScale2
<
    string UIName   = "V Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 75;
> = 0.0;

float RotationAnimationSource2
<
    string UIName   = "Rotation Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 76;
> = 0;

float RotationAnimationFunction2
<
    string UIName   = "Rotation Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 77;
> = 0;

float RotationAnimationPeriod2
<
    string UIName   = "Rotation Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 78;
> = 0.0;

float RotationAnimationPhase2
<
    string UIName   = "Rotation Animation Phase";
    string UIGroup  = "2D Texture Animation ";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 79;
> = 0.0;

float RotationAnimationScale2
<
    string UIName   = "Rotation Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 80;
> = 0.0;

float2 AnimationCenter2
<
    string UIName   = "Animation Center";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "Vector2";
    int    UIOrder = 81;
> = float2(0.000000, 0.000000);

// ----------------------------------------------------------------------------
// Map 3
// ----------------------------------------------------------------------------
bool EnableMap3
<
    string UIName  = "Enable Map 3";
    string UIGroup = "Map 3 - Flags";
    int    UIOrder = 82;
> = false;

bool Map3_Unfiltered
<
    string UIName  = "Unfiltered";
    string UIGroup = "Map 3 - Flags";
    int    UIOrder = 83;
> = false;

bool Map3_AlphaReplicate
<
    string UIName  = "Alpha Replicate";
    string UIGroup = "Map 3 - Flags";
    int    UIOrder = 84;
> = false;

bool Map3_UClamped
<
    string UIName  = "U Clamped";
    string UIGroup = "Map 3 - Flags";
    int    UIOrder = 85;
> = false;

bool Map3_VClamped
<
    string UIName  = "V Clamped";
    string UIGroup = "Map 3 - Flags";
    int    UIOrder = 86;
> = false;

int Map3_ColorFunction
<
    string UIName   = "Color Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 3";
    string UIWidget = "Spinner";
    int    UIOrder = 87;
    float  UIMin = 0; float UIMax = 13; float UIStep = 1;
> = 0;

int Map3_AlphaFunction
<
    string UIName   = "Alpha Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 3";
    string UIWidget = "Spinner";
    int    UIOrder = 88;
    float  UIMin = 0; float UIMax = 13; float UIStep = 1;
> = 0;

float Map3_UScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    int    UIOrder = 89;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map3_VScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    int    UIOrder = 90;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map3_UOffset
<
    string UIName   = "Map U Offset";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    int    UIOrder = 91;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map3_VOffset
<
    string UIName   = "Map V Offset";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    int    UIOrder = 92;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map3_Rotation
<
    string UIName   = "Map Rotation  (degrees)";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    int    UIOrder = 93;
    float  UIMin = -360; float UIMax = 360; float UIStep = 0.1;
> = 0.0;

float Map3_MipmapBias
<
    string UIName   = "Mipmap Bias";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    int    UIOrder = 94;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

Texture2D Map3Texture
<
    string UIName       = "Map";
    string UIGroup      = "Map 3";
    string ResourceType = "2D";
    int    UIOrder = 95;
>;

// ----------------------------------------------------------------------------
// 2D Texture Animation 3
// ----------------------------------------------------------------------------
int UAnimationSource3
<
    string UIName   = "U Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 96;
> = 0;

int UAnimationFunction3
<
    string UIName   = "U Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 97;
> = 0;

float UAnimationPeriod3
<
    string UIName   = "U Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 98;
> = 0.0;

float UAnimationPhase3
<
    string UIName   = "U Animation Phase";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 99;
> = 0.0;

float UAnimationScale3
<
    string UIName   = "U Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 100;
> = 0.0;

float VAnimationSource3
<
    string UIName   = "V Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 101;
> = 0;

float VAnimationFunction3
<
    string UIName   = "V Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 102;
> = 0;

float VAnimationPeriod3
<
    string UIName   = "V Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 103;
> = 0.0;

float VAnimationPhase3
<
    string UIName   = "V Animation Phase";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 104;
> = 0.0;

float VAnimationScale3
<
    string UIName   = "V Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 105;
> = 0.0;

float RotationAnimationSource3
<
    string UIName   = "Rotation Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 106;
> = 0;

float RotationAnimationFunction3
<
    string UIName   = "Rotation Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 107;
> = 0;

float RotationAnimationPeriod3
<
    string UIName   = "Rotation Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 108;
> = 0.0;

float RotationAnimationPhase3
<
    string UIName   = "Rotation Animation Phase";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 109;
> = 0.0;

float RotationAnimationScale3
<
    string UIName   = "Rotation Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 110;
> = 0.0;

float2 AnimationCenter3
<
    string UIName   = "Animation Center";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "Vector2";
    int    UIOrder = 111;
> = float2(0.000000, 0.000000);

// ----------------------------------------------------------------------------
// Map 4
// ----------------------------------------------------------------------------
bool EnableMap4
<
    string UIName  = "Enable Map 4";
    string UIGroup = "Map 4 - Flags";
    int    UIOrder = 112;
> = false;

bool Map4_Unfiltered
<
    string UIName  = "Unfiltered";
    string UIGroup = "Map 4 - Flags";
    int    UIOrder = 113;
> = false;

bool Map4_AlphaReplicate
<
    string UIName  = "Alpha Replicate";
    string UIGroup = "Map 4 - Flags";
    int    UIOrder = 114;
> = false;

bool Map4_UClamped
<
    string UIName  = "U Clamped";
    string UIGroup = "Map 4 - Flags";
    int    UIOrder = 115;
> = false;

bool Map4_VClamped
<
    string UIName  = "V Clamped";
    string UIGroup = "Map 4 - Flags";
    int    UIOrder = 116;
> = false;

int Map4_ColorFunction
<
    string UIName   = "Color Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 4";
    string UIWidget = "Spinner";
    int    UIOrder = 117;
    float  UIMin = 0; float UIMax = 13; float UIStep = 1;
> = 0;

int Map4_AlphaFunction
<
    string UIName   = "Alpha Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 4";
    string UIWidget = "Spinner";
    int    UIOrder = 118;
    float  UIMin = 0; float UIMax = 13; float UIStep = 1;
> = 0;

float Map4_UScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    int    UIOrder = 119;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map4_VScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    int    UIOrder = 120;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map4_UOffset
<
    string UIName   = "Map U Offset";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    int    UIOrder = 121;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map4_VOffset
<
    string UIName   = "Map V Offset";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    int    UIOrder = 122;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map4_Rotation
<
    string UIName   = "Map Rotation  (degrees)";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    int    UIOrder = 123;
    float  UIMin = -360; float UIMax = 360; float UIStep = 0.1;
> = 0.0;

float Map4_MipmapBias
<
    string UIName   = "Mipmap Bias";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    int    UIOrder = 124;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

Texture2D Map4Texture
<
    string UIName       = "Map";
    string UIGroup      = "Map 4";
    string ResourceType = "2D";
    int    UIOrder = 125;
>;

// ----------------------------------------------------------------------------
// 2D Texture Animation 4
// ----------------------------------------------------------------------------
int UAnimationSource4
<
    string UIName   = "U Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 126;
> = 0;

int UAnimationFunction4
<
    string UIName   = "U Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder =127;
> = 0;

float UAnimationPeriod4
<
    string UIName   = "U Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 128;
> = 0.0;

float UAnimationPhase4
<
    string UIName   = "U Animation Phase";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 129;
> = 0.0;

float UAnimationScale4
<
    string UIName   = "U Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 130;
> = 0.0;

float VAnimationSource4
<
    string UIName   = "V Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 131;
> = 0;

float VAnimationFunction4
<
    string UIName   = "V Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 132;
> = 0;

float VAnimationPeriod4
<
    string UIName   = "V Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 133;
> = 0.0;

float VAnimationPhase4
<
    string UIName   = "V Animation Phase";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 134;
> = 0.0;

float VAnimationScale4
<
    string UIName   = "V Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 135;
> = 0.0;

float RotationAnimationSource4
<
    string UIName   = "Rotation Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
    int    UIOrder = 136;
> = 0;

float RotationAnimationFunction4
<
    string UIName   = "Rotation Animation Function  [0=None  1=Zero  2=Cosine  3=Cosine (Variable Period) 4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period) 8=Noise 9=Jitter 10=Wander 11=Spark]";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
    int    UIOrder = 137;
> = 0;

float RotationAnimationPeriod4
<
    string UIName   = "Rotation Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 138;
> = 0.0;

float RotationAnimationPhase4
<
    string UIName   = "Rotation Animation Phase";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 139;
> = 0.0;

float RotationAnimationScale4
<
    string UIName   = "Rotation Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
    int    UIOrder = 140;
> = 0.0;

float2 AnimationCenter4
<
    string UIName   = "Animation Center";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "Vector2";
    int    UIOrder = 141;
> = float2(0.000000, 0.000000);

// ----------------------------------------------------------------------------
// Extra Flags
// ----------------------------------------------------------------------------
bool DontFadeActiveCamouflage
<
    string UIName  = "Don't Fade Active Camouflage";
    string UIGroup = "Extra Flags";
    int    UIOrder = 142;
> = false;

bool NumericCountdownTimer
<
    string UIName  = "Numeric Countdown Timer";
    string UIGroup = "Extra Flags";
    int    UIOrder = 143;
> = false;

bool CustomEditionBlending
<
    string UIName  = "Custom Edition Blending";
    string UIGroup = "Extra Flags";
    int    UIOrder = 144;
> = false;

// ----------------------------------------------------------------------------
// Opacity Controls
// Applied to the alpha channel (AlphaBlend) or luminance (Add) before output.
// Match the controls from the opacity example shader.
// ----------------------------------------------------------------------------
float OpacityGamma
<
    //string UIName   = "Opacity Gamma / Smoothing  (1 = linear)";
    string UIGroup  = "Opacity Controls";
    string UIWidget = "slider";
    float  UIMin = 0.1; float UIMax = 4.0; float UIStep = 0.05;
> = 1.0;

float OpacityContrast
<
    //string UIName   = "Opacity Contrast  (1 = no change)";
    string UIGroup  = "Opacity Controls";
    string UIWidget = "slider";
    float  UIMin = 0.1; float UIMax = 5.0; float UIStep = 0.05;
> = 1.0;

float OpacityBias
<
    //string UIName   = "Opacity Bias";
    string UIGroup  = "Opacity Controls";
    string UIWidget = "slider";
    float  UIMin = -1.0; float UIMax = 1.0; float UIStep = 0.01;
> = 0.0;

float DitherScale
<
    //string UIName   = "Dither Scale  (1 = full range)";
    string UIGroup  = "Opacity Controls";
    string UIWidget = "slider";
    float  UIMin = 0.0; float UIMax = 2.0; float UIStep = 0.01;
> = 1.0;

// Brightness multiplier applied to RGB before output.
// Compensates for the viewport being darker than the in-game renderer.
// 1.0 = no change.  Raise above 1.0 to match in-game brightness.
float Brightness
<
    //string UIName   = "Brightness  (1 = no change)";
    string UIGroup  = "Opacity Controls";
    string UIWidget = "slider";
    float  UIMin = 0.0; float UIMax = 8.0; float UIStep = 0.05;
> = 1.0;

#endif // GLYPHFX_TRANSPARENT_CHICAGO_PARAMS_FXH
