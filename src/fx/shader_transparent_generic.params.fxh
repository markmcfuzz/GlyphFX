// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_generic.params.fxh
//
// All UI-exposed parameters for shader_transparent_generic.
// Matches the Guerrilla tag layout:
//   - global shader flags and framebuffer blend/fade settings
//   - up to 4 maps; maps 2-4 activated with EnableMapN booleans
//   - per-map: flags, UV transform, texture, 2D texture animation
//   - up to 7 combiner stages; stages 2-7 activated with EnableStageN booleans
//   - per-stage: flags, constants and color0 animation,
//     color inputs A-D with mappings, color outputs (AB / CD / AB CD mux-sum),
//     alpha inputs A-D with mappings, alpha outputs
//
// Stage register model (see ringworld shader_transparent_generic.hlsl):
//   map color/alpha 0-3  = the four sampled maps (t0-t3)
//   vertex color 0/1     = interpolated vertex colors (diffuse light / fade)
//   scratch color 0/1    = temporaries; scratch color 0 doubles as the final
//                          output color, scratch alpha 0 as the final alpha
//   constant color 0/1   = per-stage constants; constant color 0 is animated
//                          between the lower and upper bounds, exactly like the
//                          self-illumination color of the model shader
//
// Stage math:  AB = A op B,  CD = C op D  (op = multiply | dot product;
//   the alpha side always multiplies).  AB CD Mux/Sum = with the mux flag off:
//   AB + CD, with it on: scratch alpha 0 >= 0.5 ? CD : AB.  Output mapping
//   scales/biases all three results before they are written to their targets.
//
// Framebuffer blend function is informational only; select the matching
// technique in the DirectX Shader material to activate the correct blend mode.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_TRANSPARENT_GENERIC_PARAMS_FXH
#define GLYPHFX_TRANSPARENT_GENERIC_PARAMS_FXH

// ----------------------------------------------------------------------------
// Radiosity Properties
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
    string UIName   = "Detail Level  [0=High  1=Medium  2=Low  3=Turd]";
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

// ----------------------------------------------------------------------------
// Physics Properties
// ----------------------------------------------------------------------------
float MaterialType
<
    string UIName   = "Material Type";
    string UIGroup  = "Shader General Fields";
    string UIWidget = "slider";
    int    UIOrder = 7;
    float  UIMin = 0; float UIMax = 32; float UIStep = 1;
> = 0.0;

// ----------------------------------------------------------------------------
// Shader Transparent Generic Attributes
// ----------------------------------------------------------------------------
int NumericCounterLimit
<
    string UIName   = "Numeric Counter Limit";
    string UIGroup  = "Shader Generic Attributes";
    string UIWidget = "Spinner";
    int    UIOrder = 8;
    float  UIMin = 0; float UIMax = 255; float UIStep = 1;
> = 0;

bool AlphaTested
<
    string UIName  = "Alpha Tested";
    string UIGroup = "Shader Generic Attributes";
    int    UIOrder = 9;
> = false;

bool Decal
<
    string UIName  = "Decal";
    string UIGroup = "Shader Generic Attributes";
    int    UIOrder = 10;
> = false;

bool TwoSided
<
    string UIName  = "Two Sided";
    string UIGroup = "Shader Generic Attributes";
    int    UIOrder = 11;
> = false;

bool FirstMapIsScreenspace
<
    string UIName  = "First Map Is In Screenspace";
    string UIGroup = "Shader Generic Attributes";
    int    UIOrder = 12;
> = false;

bool DrawBeforeWater
<
    string UIName  = "Draw Before Water";
    string UIGroup = "Shader Generic Attributes";
    int    UIOrder = 13;
> = false;

bool IgnoreEffect
<
    string UIName  = "Ignore Effect";
    string UIGroup = "Shader Generic Attributes";
    int    UIOrder = 14;
> = false;

bool ScaleFirstMapWithDistance
<
    string UIName  = "Scale First Map With Distance";
    string UIGroup = "Shader Generic Attributes";
    int    UIOrder = 15;
> = false;

bool Numeric
<
    string UIName  = "Numeric";
    string UIGroup = "Shader Generic Attributes";
    int    UIOrder = 16;
> = false;

// Informational - select the matching technique to activate the correct blend.
int FirstMapType
<
    string UIName   = "First Map Type  [0=2D Map  1=Reflection Cubemap  2=Object Center Cubemap  3=Viewer Centered Cubemap]";
    string UIGroup  = "Shader Generic Attributes";
    string UIWidget = "Spinner";
    int    UIOrder = 17;
    float  UIMin = 0; float UIMax = 3; float UIStep = 1;
> = 0;

int FramebufferBlendFunction
<
    string UIName   = "Framebuffer Blend Function  [0=Alpha Blend  1=Multiply  2=Double Multiply  3=Add  4=Subtract  5=Component Min  6=Component Max  7=Alpha-Multiply Add]";
    string UIGroup  = "Shader Generic Attributes";
    string UIWidget = "Spinner";
    int    UIOrder = 18;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int FramebufferFadeMode
<
    string UIName   = "Framebuffer Fade Mode  [0=None  1=Fade When Perpendicular  2=Fade When Parallel]";
    string UIGroup  = "Shader Generic Attributes";
    string UIWidget = "Spinner";
    int    UIOrder = 19;
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
> = 0;

int FramebufferFadeSource
<
    string UIName   = "Framebuffer Fade Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "Shader Generic Attributes";
    string UIWidget = "Spinner";
    int    UIOrder = 20;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

float LensFlareSpacing
<
    string UIName   = "Lens Flare Spacing  (World Units)";
    string UIGroup  = "Shader Generic Attributes";
    string UIWidget = "slider";
    int    UIOrder = 21;
    float  UIMin = 0; float UIMax = 1000; float UIStep = 0.1;
> = 0.0;

Texture2D LensFlareReference
<
    string UIName       = "Lens Flare Reference";
    string UIGroup      = "Shader Generic Attributes";
    string ResourceType = "2D";
    int    UIOrder = 22;
>;

// ----------------------------------------------------------------------------
// Map 1  (always active - the base map)
// ----------------------------------------------------------------------------
bool Map1_Unfiltered
<
    string UIName  = "Unfiltered";
    string UIGroup = "Map 1 - Flags";
    int    UIOrder = 23;
> = false;

bool Map1_UClamped
<
    string UIName  = "U Clamped";
    string UIGroup = "Map 1 - Flags";
    int    UIOrder = 24;
> = false;

bool Map1_VClamped
<
    string UIName  = "V Clamped";
    string UIGroup = "Map 1 - Flags";
    int    UIOrder = 25;
> = false;

float Map1_UScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    int    UIOrder = 26;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map1_VScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    int    UIOrder = 27;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map1_UOffset
<
    string UIName   = "Map U Offset";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    int    UIOrder = 28;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map1_VOffset
<
    string UIName   = "Map V Offset";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    int    UIOrder = 29;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map1_Rotation
<
    string UIName   = "Map Rotation  (Degrees)";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    int    UIOrder = 30;
    float  UIMin = -360; float UIMax = 360; float UIStep = 0.1;
> = 0.0;

float Map1_MipmapBias
<
    string UIName   = "Mipmap Bias";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    int    UIOrder = 31;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

Texture2D Map1Texture
<
    string UIName       = "Map";
    string UIGroup      = "Map 1";
    string ResourceType = "2D";
    int    UIOrder = 32;
>;

// ----------------------------------------------------------------------------
// 2D Texture Animation 1
// ----------------------------------------------------------------------------
int UAnimationSource1
<
    string UIName   = "U Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 33;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int UAnimationFunction1
<
    string UIName   = "U Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 34;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float UAnimationPeriod1
<
    string UIName   = "U Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 35;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float UAnimationPhase1
<
    string UIName   = "U Animation Phase";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 36;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float UAnimationScale1
<
    string UIName   = "U Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 37;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

int VAnimationSource1
<
    string UIName   = "V Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 38;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int VAnimationFunction1
<
    string UIName   = "V Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 39;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float VAnimationPeriod1
<
    string UIName   = "V Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 40;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float VAnimationPhase1
<
    string UIName   = "V Animation Phase";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 41;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float VAnimationScale1
<
    string UIName   = "V Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 42;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

int RotationAnimationSource1
<
    string UIName   = "Rotation Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 43;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int RotationAnimationFunction1
<
    string UIName   = "Rotation Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 44;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float RotationAnimationPeriod1
<
    string UIName   = "Rotation Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 45;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float RotationAnimationPhase1
<
    string UIName   = "Rotation Animation Phase";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 46;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float RotationAnimationScale1
<
    string UIName   = "Rotation Animation Scale................(Degrees)";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 47;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float AnimationCenterU1
<
    string UIName   = "Animation Center U";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 48;
    float  UIMin = -1; float UIMax = 1000000; float UIStep = 0.01;
> = 0.0;

float AnimationCenterV1
<
    string UIName   = "Animation Center V";
    string UIGroup  = "2D Texture Animation 1";
    string UIWidget = "slider";
    int    UIOrder = 49;
    float  UIMin = -1; float UIMax = 1000000; float UIStep = 0.01;
> = 0.0;

// ----------------------------------------------------------------------------
// Map 2
// ----------------------------------------------------------------------------
bool EnableMap2
<
    string UIName  = "Enable Map 2";
    string UIGroup = "Map 2 - Flags";
    int    UIOrder = 50;
> = false;

bool Map2_Unfiltered
<
    string UIName  = "Unfiltered";
    string UIGroup = "Map 2 - Flags";
    int    UIOrder = 51;
> = false;

bool Map2_UClamped
<
    string UIName  = "U Clamped";
    string UIGroup = "Map 2 - Flags";
    int    UIOrder = 52;
> = false;

bool Map2_VClamped
<
    string UIName  = "V Clamped";
    string UIGroup = "Map 2 - Flags";
    int    UIOrder = 53;
> = false;

float Map2_UScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    int    UIOrder = 54;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map2_VScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    int    UIOrder = 55;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map2_UOffset
<
    string UIName   = "Map U Offset";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    int    UIOrder = 56;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map2_VOffset
<
    string UIName   = "Map V Offset";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    int    UIOrder = 57;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map2_Rotation
<
    string UIName   = "Map Rotation  (Degrees)";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    int    UIOrder = 58;
    float  UIMin = -360; float UIMax = 360; float UIStep = 0.1;
> = 0.0;

float Map2_MipmapBias
<
    string UIName   = "Mipmap Bias";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    int    UIOrder = 59;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

Texture2D Map2Texture
<
    string UIName       = "Map";
    string UIGroup      = "Map 2";
    string ResourceType = "2D";
    int    UIOrder = 60;
>;

// ----------------------------------------------------------------------------
// 2D Texture Animation 2
// ----------------------------------------------------------------------------
int UAnimationSource2
<
    string UIName   = "U Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 61;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int UAnimationFunction2
<
    string UIName   = "U Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 62;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float UAnimationPeriod2
<
    string UIName   = "U Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 63;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float UAnimationPhase2
<
    string UIName   = "U Animation Phase";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 64;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float UAnimationScale2
<
    string UIName   = "U Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 65;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

int VAnimationSource2
<
    string UIName   = "V Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 66;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int VAnimationFunction2
<
    string UIName   = "V Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 67;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float VAnimationPeriod2
<
    string UIName   = "V Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 68;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float VAnimationPhase2
<
    string UIName   = "V Animation Phase";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 69;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float VAnimationScale2
<
    string UIName   = "V Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 70;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

int RotationAnimationSource2
<
    string UIName   = "Rotation Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 71;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int RotationAnimationFunction2
<
    string UIName   = "Rotation Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 72;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float RotationAnimationPeriod2
<
    string UIName   = "Rotation Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 73;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float RotationAnimationPhase2
<
    string UIName   = "Rotation Animation Phase";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 74;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float RotationAnimationScale2
<
    string UIName   = "Rotation Animation Scale................(Degrees)";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 75;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float AnimationCenterU2
<
    string UIName   = "Animation Center U";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 76;
    float  UIMin = -1; float UIMax = 1000000; float UIStep = 0.01;
> = 0.0;

float AnimationCenterV2
<
    string UIName   = "Animation Center V";
    string UIGroup  = "2D Texture Animation 2";
    string UIWidget = "slider";
    int    UIOrder = 77;
    float  UIMin = -1; float UIMax = 1000000; float UIStep = 0.01;
> = 0.0;

// ----------------------------------------------------------------------------
// Map 3
// ----------------------------------------------------------------------------
bool EnableMap3
<
    string UIName  = "Enable Map 3";
    string UIGroup = "Map 3 - Flags";
    int    UIOrder = 78;
> = false;

bool Map3_Unfiltered
<
    string UIName  = "Unfiltered";
    string UIGroup = "Map 3 - Flags";
    int    UIOrder = 79;
> = false;

bool Map3_UClamped
<
    string UIName  = "U Clamped";
    string UIGroup = "Map 3 - Flags";
    int    UIOrder = 80;
> = false;

bool Map3_VClamped
<
    string UIName  = "V Clamped";
    string UIGroup = "Map 3 - Flags";
    int    UIOrder = 81;
> = false;

float Map3_UScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    int    UIOrder = 82;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map3_VScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    int    UIOrder = 83;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map3_UOffset
<
    string UIName   = "Map U Offset";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    int    UIOrder = 84;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map3_VOffset
<
    string UIName   = "Map V Offset";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    int    UIOrder = 85;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map3_Rotation
<
    string UIName   = "Map Rotation  (Degrees)";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    int    UIOrder = 86;
    float  UIMin = -360; float UIMax = 360; float UIStep = 0.1;
> = 0.0;

float Map3_MipmapBias
<
    string UIName   = "Mipmap Bias";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    int    UIOrder = 87;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

Texture2D Map3Texture
<
    string UIName       = "Map";
    string UIGroup      = "Map 3";
    string ResourceType = "2D";
    int    UIOrder = 88;
>;

// ----------------------------------------------------------------------------
// 2D Texture Animation 3
// ----------------------------------------------------------------------------
int UAnimationSource3
<
    string UIName   = "U Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 89;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int UAnimationFunction3
<
    string UIName   = "U Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 90;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float UAnimationPeriod3
<
    string UIName   = "U Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 91;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float UAnimationPhase3
<
    string UIName   = "U Animation Phase";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 92;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float UAnimationScale3
<
    string UIName   = "U Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 93;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

int VAnimationSource3
<
    string UIName   = "V Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 94;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int VAnimationFunction3
<
    string UIName   = "V Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 95;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float VAnimationPeriod3
<
    string UIName   = "V Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 96;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float VAnimationPhase3
<
    string UIName   = "V Animation Phase";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 97;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float VAnimationScale3
<
    string UIName   = "V Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 98;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

int RotationAnimationSource3
<
    string UIName   = "Rotation Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 99;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int RotationAnimationFunction3
<
    string UIName   = "Rotation Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 100;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float RotationAnimationPeriod3
<
    string UIName   = "Rotation Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 101;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float RotationAnimationPhase3
<
    string UIName   = "Rotation Animation Phase";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 102;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float RotationAnimationScale3
<
    string UIName   = "Rotation Animation Scale................(Degrees)";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 103;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float AnimationCenterU3
<
    string UIName   = "Animation Center U";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 104;
    float  UIMin = -1; float UIMax = 1000000; float UIStep = 0.01;
> = 0.0;

float AnimationCenterV3
<
    string UIName   = "Animation Center V";
    string UIGroup  = "2D Texture Animation 3";
    string UIWidget = "slider";
    int    UIOrder = 105;
    float  UIMin = -1; float UIMax = 1000000; float UIStep = 0.01;
> = 0.0;

// ----------------------------------------------------------------------------
// Map 4
// ----------------------------------------------------------------------------
bool EnableMap4
<
    string UIName  = "Enable Map 4";
    string UIGroup = "Map 4 - Flags";
    int    UIOrder = 106;
> = false;

bool Map4_Unfiltered
<
    string UIName  = "Unfiltered";
    string UIGroup = "Map 4 - Flags";
    int    UIOrder = 107;
> = false;

bool Map4_UClamped
<
    string UIName  = "U Clamped";
    string UIGroup = "Map 4 - Flags";
    int    UIOrder = 108;
> = false;

bool Map4_VClamped
<
    string UIName  = "V Clamped";
    string UIGroup = "Map 4 - Flags";
    int    UIOrder = 109;
> = false;

float Map4_UScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    int    UIOrder = 110;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map4_VScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    int    UIOrder = 111;
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map4_UOffset
<
    string UIName   = "Map U Offset";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    int    UIOrder = 112;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map4_VOffset
<
    string UIName   = "Map V Offset";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    int    UIOrder = 113;
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map4_Rotation
<
    string UIName   = "Map Rotation  (Degrees)";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    int    UIOrder = 114;
    float  UIMin = -360; float UIMax = 360; float UIStep = 0.1;
> = 0.0;

float Map4_MipmapBias
<
    string UIName   = "Mipmap Bias";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    int    UIOrder = 115;
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

Texture2D Map4Texture
<
    string UIName       = "Map";
    string UIGroup      = "Map 4";
    string ResourceType = "2D";
    int    UIOrder = 116;
>;

// ----------------------------------------------------------------------------
// 2D Texture Animation 4
// ----------------------------------------------------------------------------
int UAnimationSource4
<
    string UIName   = "U Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 117;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int UAnimationFunction4
<
    string UIName   = "U Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 118;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float UAnimationPeriod4
<
    string UIName   = "U Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 119;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float UAnimationPhase4
<
    string UIName   = "U Animation Phase";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 120;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float UAnimationScale4
<
    string UIName   = "U Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 121;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

int VAnimationSource4
<
    string UIName   = "V Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 122;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int VAnimationFunction4
<
    string UIName   = "V Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 123;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float VAnimationPeriod4
<
    string UIName   = "V Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 124;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float VAnimationPhase4
<
    string UIName   = "V Animation Phase";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 125;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float VAnimationScale4
<
    string UIName   = "V Animation Scale................(Repeats)";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 126;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

int RotationAnimationSource4
<
    string UIName   = "Rotation Animation Source  [0=None  1=A Out  2=B Out  3=C Out  4=D Out]";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 127;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int RotationAnimationFunction4
<
    string UIName   = "Rotation Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 128;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float RotationAnimationPeriod4
<
    string UIName   = "Rotation Animation Period................(Seconds)";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 129;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float RotationAnimationPhase4
<
    string UIName   = "Rotation Animation Phase";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 130;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float RotationAnimationScale4
<
    string UIName   = "Rotation Animation Scale................(Degrees)";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 131;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float AnimationCenterU4
<
    string UIName   = "Animation Center U";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 132;
    float  UIMin = -1; float UIMax = 1000000; float UIStep = 0.01;
> = 0.0;

float AnimationCenterV4
<
    string UIName   = "Animation Center V";
    string UIGroup  = "2D Texture Animation 4";
    string UIWidget = "slider";
    int    UIOrder = 133;
    float  UIMin = -1; float UIMax = 1000000; float UIStep = 0.01;
> = 0.0;

// ----------------------------------------------------------------------------
// Stage 1  (always active - the base stage)
// Defaults replicate the game's implicit stage when a tag has zero
// stages: Map Color/Alpha 0 x One -> Scratch 0 (final color/alpha),
// i.e. a straight pass-through of Map 1.
// ----------------------------------------------------------------------------
bool Stage1_ColorMux
<
    string UIName  = "Color Mux";
    string UIGroup = "Stage 1 - Flags";
    int    UIOrder = 134;
> = false;

bool Stage1_AlphaMux
<
    string UIName  = "Alpha Mux";
    string UIGroup = "Stage 1 - Flags";
    int    UIOrder = 135;
> = false;

bool Stage1_AOutControlsColor0Animation
<
    string UIName  = "A-Out Controls Color0 Animation";
    string UIGroup = "Stage 1 - Flags";
    int    UIOrder = 136;
> = false;

int Stage1_Color0Source
<
    string UIName   = "Color0 Source  [0=None  1=A  2=B  3=C  4=D]";
    string UIGroup  = "Stage 1 - Constants and Animation";
    string UIWidget = "Spinner";
    int    UIOrder = 137;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int Stage1_Color0AnimationFunction
<
    string UIName   = "Color0 Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "Stage 1 - Constants and Animation";
    string UIWidget = "Spinner";
    int    UIOrder = 138;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float Stage1_Color0AnimationPeriod
<
    string UIName   = "Color0 Animation Period................(Seconds)";
    string UIGroup  = "Stage 1 - Constants and Animation";
    string UIWidget = "slider";
    int    UIOrder = 139;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float4 Stage1_Color0AnimationLowerBound
<
    string UIName   = "Color0 Animation Lower Bound  (ARGB)";
    string UIGroup  = "Stage 1 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 140;
> = float4(0, 0, 0, 0);

float4 Stage1_Color0AnimationUpperBound
<
    string UIName   = "Color0 Animation Upper Bound  (ARGB)";
    string UIGroup  = "Stage 1 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 141;
> = float4(1, 1, 1, 1);

float4 Stage1_Color1
<
    string UIName   = "Color1  (ARGB)";
    string UIGroup  = "Stage 1 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 142;
> = float4(1, 1, 1, 1);

int Stage1_ColorInputA
<
    string UIName   = "Input A  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 1 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 143;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 5;

int Stage1_ColorInputAMapping
<
    string UIName   = "Input A Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 1 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 144;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage1_ColorInputB
<
    string UIName   = "Input B  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 1 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 145;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 1;

int Stage1_ColorInputBMapping
<
    string UIName   = "Input B Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 1 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 146;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage1_ColorInputC
<
    string UIName   = "Input C  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 1 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 147;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage1_ColorInputCMapping
<
    string UIName   = "Input C Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 1 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 148;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage1_ColorInputD
<
    string UIName   = "Input D  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 1 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 149;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage1_ColorInputDMapping
<
    string UIName   = "Input D Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 1 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 150;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage1_ColorOutputAB
<
    string UIName   = "Output AB  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 1 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 151;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 1;

int Stage1_ColorOutputABFunction
<
    string UIName   = "Output AB Function  [0=Multiply  1=Dot Product]";
    string UIGroup  = "Stage 1 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 152;
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

int Stage1_ColorOutputCD
<
    string UIName   = "Output CD  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 1 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 153;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage1_ColorOutputCDFunction
<
    string UIName   = "Output CD Function  [0=Multiply  1=Dot Product]";
    string UIGroup  = "Stage 1 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 154;
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

int Stage1_ColorOutputABCDMuxSum
<
    string UIName   = "Output AB CD Mux/Sum  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 1 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 155;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage1_ColorOutputMapping
<
    string UIName   = "Output Mapping  [0=Identity  1=Scale by 1/2  2=Scale by 2  3=Scale by 4  4=Bias by -1/2  5=Expand Normal ((x-1/2)*2)]";
    string UIGroup  = "Stage 1 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 156;
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
> = 0;

int Stage1_AlphaInputA
<
    string UIName   = "Input A  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 1 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 157;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 5;

int Stage1_AlphaInputAMapping
<
    string UIName   = "Input A Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 1 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 158;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage1_AlphaInputB
<
    string UIName   = "Input B  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 1 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 159;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 1;

int Stage1_AlphaInputBMapping
<
    string UIName   = "Input B Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 1 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 160;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage1_AlphaInputC
<
    string UIName   = "Input C  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 1 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 161;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage1_AlphaInputCMapping
<
    string UIName   = "Input C Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 1 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 162;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage1_AlphaInputD
<
    string UIName   = "Input D  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 1 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 163;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage1_AlphaInputDMapping
<
    string UIName   = "Input D Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 1 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 164;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage1_AlphaOutputAB
<
    string UIName   = "Output AB  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 1 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 165;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 1;

int Stage1_AlphaOutputCD
<
    string UIName   = "Output CD  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 1 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 166;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage1_AlphaOutputABCDMuxSum
<
    string UIName   = "Output AB CD Mux/Sum  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 1 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 167;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage1_AlphaOutputMapping
<
    string UIName   = "Output Mapping  [0=Identity  1=Scale by 1/2  2=Scale by 2  3=Scale by 4  4=Bias by -1/2  5=Expand Normal ((x-1/2)*2)]";
    string UIGroup  = "Stage 1 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 168;
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
> = 0;

// ----------------------------------------------------------------------------
// Stage 2
// ----------------------------------------------------------------------------
bool EnableStage2
<
    string UIName  = "Enable Stage 2";
    string UIGroup = "Stage 2 - Flags";
    int    UIOrder = 169;
> = false;

bool Stage2_ColorMux
<
    string UIName  = "Color Mux";
    string UIGroup = "Stage 2 - Flags";
    int    UIOrder = 170;
> = false;

bool Stage2_AlphaMux
<
    string UIName  = "Alpha Mux";
    string UIGroup = "Stage 2 - Flags";
    int    UIOrder = 171;
> = false;

bool Stage2_AOutControlsColor0Animation
<
    string UIName  = "A-Out Controls Color0 Animation";
    string UIGroup = "Stage 2 - Flags";
    int    UIOrder = 172;
> = false;

int Stage2_Color0Source
<
    string UIName   = "Color0 Source  [0=None  1=A  2=B  3=C  4=D]";
    string UIGroup  = "Stage 2 - Constants and Animation";
    string UIWidget = "Spinner";
    int    UIOrder = 173;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int Stage2_Color0AnimationFunction
<
    string UIName   = "Color0 Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "Stage 2 - Constants and Animation";
    string UIWidget = "Spinner";
    int    UIOrder = 174;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float Stage2_Color0AnimationPeriod
<
    string UIName   = "Color0 Animation Period................(Seconds)";
    string UIGroup  = "Stage 2 - Constants and Animation";
    string UIWidget = "slider";
    int    UIOrder = 175;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float4 Stage2_Color0AnimationLowerBound
<
    string UIName   = "Color0 Animation Lower Bound  (ARGB)";
    string UIGroup  = "Stage 2 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 176;
> = float4(0, 0, 0, 0);

float4 Stage2_Color0AnimationUpperBound
<
    string UIName   = "Color0 Animation Upper Bound  (ARGB)";
    string UIGroup  = "Stage 2 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 177;
> = float4(1, 1, 1, 1);

float4 Stage2_Color1
<
    string UIName   = "Color1  (ARGB)";
    string UIGroup  = "Stage 2 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 178;
> = float4(1, 1, 1, 1);

int Stage2_ColorInputA
<
    string UIName   = "Input A  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 2 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 179;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage2_ColorInputAMapping
<
    string UIName   = "Input A Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 2 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 180;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage2_ColorInputB
<
    string UIName   = "Input B  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 2 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 181;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage2_ColorInputBMapping
<
    string UIName   = "Input B Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 2 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 182;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage2_ColorInputC
<
    string UIName   = "Input C  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 2 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 183;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage2_ColorInputCMapping
<
    string UIName   = "Input C Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 2 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 184;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage2_ColorInputD
<
    string UIName   = "Input D  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 2 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 185;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage2_ColorInputDMapping
<
    string UIName   = "Input D Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 2 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 186;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage2_ColorOutputAB
<
    string UIName   = "Output AB  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 2 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 187;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage2_ColorOutputABFunction
<
    string UIName   = "Output AB Function  [0=Multiply  1=Dot Product]";
    string UIGroup  = "Stage 2 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 188;
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

int Stage2_ColorOutputCD
<
    string UIName   = "Output CD  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 2 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 189;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage2_ColorOutputCDFunction
<
    string UIName   = "Output CD Function  [0=Multiply  1=Dot Product]";
    string UIGroup  = "Stage 2 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 190;
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

int Stage2_ColorOutputABCDMuxSum
<
    string UIName   = "Output AB CD Mux/Sum  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 2 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 191;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage2_ColorOutputMapping
<
    string UIName   = "Output Mapping  [0=Identity  1=Scale by 1/2  2=Scale by 2  3=Scale by 4  4=Bias by -1/2  5=Expand Normal ((x-1/2)*2)]";
    string UIGroup  = "Stage 2 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 192;
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
> = 0;

int Stage2_AlphaInputA
<
    string UIName   = "Input A  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 2 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 193;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage2_AlphaInputAMapping
<
    string UIName   = "Input A Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 2 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 194;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage2_AlphaInputB
<
    string UIName   = "Input B  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 2 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 195;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage2_AlphaInputBMapping
<
    string UIName   = "Input B Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 2 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 196;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage2_AlphaInputC
<
    string UIName   = "Input C  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 2 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 197;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage2_AlphaInputCMapping
<
    string UIName   = "Input C Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 2 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 198;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage2_AlphaInputD
<
    string UIName   = "Input D  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 2 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 199;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage2_AlphaInputDMapping
<
    string UIName   = "Input D Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 2 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 200;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage2_AlphaOutputAB
<
    string UIName   = "Output AB  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 2 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 201;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage2_AlphaOutputCD
<
    string UIName   = "Output CD  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 2 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 202;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage2_AlphaOutputABCDMuxSum
<
    string UIName   = "Output AB CD Mux/Sum  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 2 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 203;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage2_AlphaOutputMapping
<
    string UIName   = "Output Mapping  [0=Identity  1=Scale by 1/2  2=Scale by 2  3=Scale by 4  4=Bias by -1/2  5=Expand Normal ((x-1/2)*2)]";
    string UIGroup  = "Stage 2 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 204;
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
> = 0;

// ----------------------------------------------------------------------------
// Stage 3
// ----------------------------------------------------------------------------
bool EnableStage3
<
    string UIName  = "Enable Stage 3";
    string UIGroup = "Stage 3 - Flags";
    int    UIOrder = 205;
> = false;

bool Stage3_ColorMux
<
    string UIName  = "Color Mux";
    string UIGroup = "Stage 3 - Flags";
    int    UIOrder = 206;
> = false;

bool Stage3_AlphaMux
<
    string UIName  = "Alpha Mux";
    string UIGroup = "Stage 3 - Flags";
    int    UIOrder = 207;
> = false;

bool Stage3_AOutControlsColor0Animation
<
    string UIName  = "A-Out Controls Color0 Animation";
    string UIGroup = "Stage 3 - Flags";
    int    UIOrder = 208;
> = false;

int Stage3_Color0Source
<
    string UIName   = "Color0 Source  [0=None  1=A  2=B  3=C  4=D]";
    string UIGroup  = "Stage 3 - Constants and Animation";
    string UIWidget = "Spinner";
    int    UIOrder = 209;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int Stage3_Color0AnimationFunction
<
    string UIName   = "Color0 Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "Stage 3 - Constants and Animation";
    string UIWidget = "Spinner";
    int    UIOrder = 210;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float Stage3_Color0AnimationPeriod
<
    string UIName   = "Color0 Animation Period................(Seconds)";
    string UIGroup  = "Stage 3 - Constants and Animation";
    string UIWidget = "slider";
    int    UIOrder = 211;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float4 Stage3_Color0AnimationLowerBound
<
    string UIName   = "Color0 Animation Lower Bound  (ARGB)";
    string UIGroup  = "Stage 3 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 212;
> = float4(0, 0, 0, 0);

float4 Stage3_Color0AnimationUpperBound
<
    string UIName   = "Color0 Animation Upper Bound  (ARGB)";
    string UIGroup  = "Stage 3 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 213;
> = float4(1, 1, 1, 1);

float4 Stage3_Color1
<
    string UIName   = "Color1  (ARGB)";
    string UIGroup  = "Stage 3 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 214;
> = float4(1, 1, 1, 1);

int Stage3_ColorInputA
<
    string UIName   = "Input A  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 3 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 215;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage3_ColorInputAMapping
<
    string UIName   = "Input A Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 3 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 216;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage3_ColorInputB
<
    string UIName   = "Input B  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 3 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 217;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage3_ColorInputBMapping
<
    string UIName   = "Input B Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 3 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 218;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage3_ColorInputC
<
    string UIName   = "Input C  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 3 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 219;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage3_ColorInputCMapping
<
    string UIName   = "Input C Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 3 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 220;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage3_ColorInputD
<
    string UIName   = "Input D  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 3 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 221;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage3_ColorInputDMapping
<
    string UIName   = "Input D Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 3 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 222;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage3_ColorOutputAB
<
    string UIName   = "Output AB  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 3 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 223;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage3_ColorOutputABFunction
<
    string UIName   = "Output AB Function  [0=Multiply  1=Dot Product]";
    string UIGroup  = "Stage 3 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 224;
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

int Stage3_ColorOutputCD
<
    string UIName   = "Output CD  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 3 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 225;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage3_ColorOutputCDFunction
<
    string UIName   = "Output CD Function  [0=Multiply  1=Dot Product]";
    string UIGroup  = "Stage 3 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 226;
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

int Stage3_ColorOutputABCDMuxSum
<
    string UIName   = "Output AB CD Mux/Sum  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 3 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 227;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage3_ColorOutputMapping
<
    string UIName   = "Output Mapping  [0=Identity  1=Scale by 1/2  2=Scale by 2  3=Scale by 4  4=Bias by -1/2  5=Expand Normal ((x-1/2)*2)]";
    string UIGroup  = "Stage 3 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 228;
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
> = 0;

int Stage3_AlphaInputA
<
    string UIName   = "Input A  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 3 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 229;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage3_AlphaInputAMapping
<
    string UIName   = "Input A Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 3 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 230;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage3_AlphaInputB
<
    string UIName   = "Input B  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 3 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 231;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage3_AlphaInputBMapping
<
    string UIName   = "Input B Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 3 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 232;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage3_AlphaInputC
<
    string UIName   = "Input C  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 3 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 233;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage3_AlphaInputCMapping
<
    string UIName   = "Input C Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 3 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 234;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage3_AlphaInputD
<
    string UIName   = "Input D  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 3 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 235;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage3_AlphaInputDMapping
<
    string UIName   = "Input D Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 3 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 236;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage3_AlphaOutputAB
<
    string UIName   = "Output AB  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 3 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 237;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage3_AlphaOutputCD
<
    string UIName   = "Output CD  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 3 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 238;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage3_AlphaOutputABCDMuxSum
<
    string UIName   = "Output AB CD Mux/Sum  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 3 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 239;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage3_AlphaOutputMapping
<
    string UIName   = "Output Mapping  [0=Identity  1=Scale by 1/2  2=Scale by 2  3=Scale by 4  4=Bias by -1/2  5=Expand Normal ((x-1/2)*2)]";
    string UIGroup  = "Stage 3 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 240;
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
> = 0;

// ----------------------------------------------------------------------------
// Stage 4
// ----------------------------------------------------------------------------
bool EnableStage4
<
    string UIName  = "Enable Stage 4";
    string UIGroup = "Stage 4 - Flags";
    int    UIOrder = 241;
> = false;

bool Stage4_ColorMux
<
    string UIName  = "Color Mux";
    string UIGroup = "Stage 4 - Flags";
    int    UIOrder = 242;
> = false;

bool Stage4_AlphaMux
<
    string UIName  = "Alpha Mux";
    string UIGroup = "Stage 4 - Flags";
    int    UIOrder = 243;
> = false;

bool Stage4_AOutControlsColor0Animation
<
    string UIName  = "A-Out Controls Color0 Animation";
    string UIGroup = "Stage 4 - Flags";
    int    UIOrder = 244;
> = false;

int Stage4_Color0Source
<
    string UIName   = "Color0 Source  [0=None  1=A  2=B  3=C  4=D]";
    string UIGroup  = "Stage 4 - Constants and Animation";
    string UIWidget = "Spinner";
    int    UIOrder = 245;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int Stage4_Color0AnimationFunction
<
    string UIName   = "Color0 Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "Stage 4 - Constants and Animation";
    string UIWidget = "Spinner";
    int    UIOrder = 246;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float Stage4_Color0AnimationPeriod
<
    string UIName   = "Color0 Animation Period................(Seconds)";
    string UIGroup  = "Stage 4 - Constants and Animation";
    string UIWidget = "slider";
    int    UIOrder = 247;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float4 Stage4_Color0AnimationLowerBound
<
    string UIName   = "Color0 Animation Lower Bound  (ARGB)";
    string UIGroup  = "Stage 4 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 248;
> = float4(0, 0, 0, 0);

float4 Stage4_Color0AnimationUpperBound
<
    string UIName   = "Color0 Animation Upper Bound  (ARGB)";
    string UIGroup  = "Stage 4 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 249;
> = float4(1, 1, 1, 1);

float4 Stage4_Color1
<
    string UIName   = "Color1  (ARGB)";
    string UIGroup  = "Stage 4 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 250;
> = float4(1, 1, 1, 1);

int Stage4_ColorInputA
<
    string UIName   = "Input A  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 4 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 251;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage4_ColorInputAMapping
<
    string UIName   = "Input A Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 4 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 252;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage4_ColorInputB
<
    string UIName   = "Input B  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 4 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 253;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage4_ColorInputBMapping
<
    string UIName   = "Input B Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 4 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 254;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage4_ColorInputC
<
    string UIName   = "Input C  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 4 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 255;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage4_ColorInputCMapping
<
    string UIName   = "Input C Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 4 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 256;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage4_ColorInputD
<
    string UIName   = "Input D  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 4 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 257;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage4_ColorInputDMapping
<
    string UIName   = "Input D Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 4 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 258;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage4_ColorOutputAB
<
    string UIName   = "Output AB  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 4 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 259;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage4_ColorOutputABFunction
<
    string UIName   = "Output AB Function  [0=Multiply  1=Dot Product]";
    string UIGroup  = "Stage 4 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 260;
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

int Stage4_ColorOutputCD
<
    string UIName   = "Output CD  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 4 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 261;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage4_ColorOutputCDFunction
<
    string UIName   = "Output CD Function  [0=Multiply  1=Dot Product]";
    string UIGroup  = "Stage 4 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 262;
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

int Stage4_ColorOutputABCDMuxSum
<
    string UIName   = "Output AB CD Mux/Sum  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 4 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 263;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage4_ColorOutputMapping
<
    string UIName   = "Output Mapping  [0=Identity  1=Scale by 1/2  2=Scale by 2  3=Scale by 4  4=Bias by -1/2  5=Expand Normal ((x-1/2)*2)]";
    string UIGroup  = "Stage 4 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 264;
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
> = 0;

int Stage4_AlphaInputA
<
    string UIName   = "Input A  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 4 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 265;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage4_AlphaInputAMapping
<
    string UIName   = "Input A Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 4 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 266;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage4_AlphaInputB
<
    string UIName   = "Input B  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 4 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 267;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage4_AlphaInputBMapping
<
    string UIName   = "Input B Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 4 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 268;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage4_AlphaInputC
<
    string UIName   = "Input C  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 4 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 269;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage4_AlphaInputCMapping
<
    string UIName   = "Input C Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 4 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 270;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage4_AlphaInputD
<
    string UIName   = "Input D  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 4 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 271;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage4_AlphaInputDMapping
<
    string UIName   = "Input D Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 4 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 272;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage4_AlphaOutputAB
<
    string UIName   = "Output AB  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 4 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 273;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage4_AlphaOutputCD
<
    string UIName   = "Output CD  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 4 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 274;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage4_AlphaOutputABCDMuxSum
<
    string UIName   = "Output AB CD Mux/Sum  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 4 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 275;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage4_AlphaOutputMapping
<
    string UIName   = "Output Mapping  [0=Identity  1=Scale by 1/2  2=Scale by 2  3=Scale by 4  4=Bias by -1/2  5=Expand Normal ((x-1/2)*2)]";
    string UIGroup  = "Stage 4 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 276;
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
> = 0;

// ----------------------------------------------------------------------------
// Stage 5
// ----------------------------------------------------------------------------
bool EnableStage5
<
    string UIName  = "Enable Stage 5";
    string UIGroup = "Stage 5 - Flags";
    int    UIOrder = 277;
> = false;

bool Stage5_ColorMux
<
    string UIName  = "Color Mux";
    string UIGroup = "Stage 5 - Flags";
    int    UIOrder = 278;
> = false;

bool Stage5_AlphaMux
<
    string UIName  = "Alpha Mux";
    string UIGroup = "Stage 5 - Flags";
    int    UIOrder = 279;
> = false;

bool Stage5_AOutControlsColor0Animation
<
    string UIName  = "A-Out Controls Color0 Animation";
    string UIGroup = "Stage 5 - Flags";
    int    UIOrder = 280;
> = false;

int Stage5_Color0Source
<
    string UIName   = "Color0 Source  [0=None  1=A  2=B  3=C  4=D]";
    string UIGroup  = "Stage 5 - Constants and Animation";
    string UIWidget = "Spinner";
    int    UIOrder = 281;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int Stage5_Color0AnimationFunction
<
    string UIName   = "Color0 Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "Stage 5 - Constants and Animation";
    string UIWidget = "Spinner";
    int    UIOrder = 282;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float Stage5_Color0AnimationPeriod
<
    string UIName   = "Color0 Animation Period................(Seconds)";
    string UIGroup  = "Stage 5 - Constants and Animation";
    string UIWidget = "slider";
    int    UIOrder = 283;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float4 Stage5_Color0AnimationLowerBound
<
    string UIName   = "Color0 Animation Lower Bound  (ARGB)";
    string UIGroup  = "Stage 5 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 284;
> = float4(0, 0, 0, 0);

float4 Stage5_Color0AnimationUpperBound
<
    string UIName   = "Color0 Animation Upper Bound  (ARGB)";
    string UIGroup  = "Stage 5 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 285;
> = float4(1, 1, 1, 1);

float4 Stage5_Color1
<
    string UIName   = "Color1  (ARGB)";
    string UIGroup  = "Stage 5 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 286;
> = float4(1, 1, 1, 1);

int Stage5_ColorInputA
<
    string UIName   = "Input A  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 5 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 287;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage5_ColorInputAMapping
<
    string UIName   = "Input A Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 5 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 288;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage5_ColorInputB
<
    string UIName   = "Input B  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 5 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 289;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage5_ColorInputBMapping
<
    string UIName   = "Input B Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 5 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 290;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage5_ColorInputC
<
    string UIName   = "Input C  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 5 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 291;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage5_ColorInputCMapping
<
    string UIName   = "Input C Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 5 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 292;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage5_ColorInputD
<
    string UIName   = "Input D  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 5 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 293;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage5_ColorInputDMapping
<
    string UIName   = "Input D Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 5 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 294;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage5_ColorOutputAB
<
    string UIName   = "Output AB  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 5 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 295;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage5_ColorOutputABFunction
<
    string UIName   = "Output AB Function  [0=Multiply  1=Dot Product]";
    string UIGroup  = "Stage 5 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 296;
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

int Stage5_ColorOutputCD
<
    string UIName   = "Output CD  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 5 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 297;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage5_ColorOutputCDFunction
<
    string UIName   = "Output CD Function  [0=Multiply  1=Dot Product]";
    string UIGroup  = "Stage 5 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 298;
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

int Stage5_ColorOutputABCDMuxSum
<
    string UIName   = "Output AB CD Mux/Sum  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 5 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 299;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage5_ColorOutputMapping
<
    string UIName   = "Output Mapping  [0=Identity  1=Scale by 1/2  2=Scale by 2  3=Scale by 4  4=Bias by -1/2  5=Expand Normal ((x-1/2)*2)]";
    string UIGroup  = "Stage 5 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 300;
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
> = 0;

int Stage5_AlphaInputA
<
    string UIName   = "Input A  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 5 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 301;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage5_AlphaInputAMapping
<
    string UIName   = "Input A Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 5 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 302;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage5_AlphaInputB
<
    string UIName   = "Input B  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 5 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 303;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage5_AlphaInputBMapping
<
    string UIName   = "Input B Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 5 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 304;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage5_AlphaInputC
<
    string UIName   = "Input C  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 5 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 305;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage5_AlphaInputCMapping
<
    string UIName   = "Input C Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 5 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 306;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage5_AlphaInputD
<
    string UIName   = "Input D  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 5 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 307;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage5_AlphaInputDMapping
<
    string UIName   = "Input D Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 5 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 308;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage5_AlphaOutputAB
<
    string UIName   = "Output AB  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 5 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 309;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage5_AlphaOutputCD
<
    string UIName   = "Output CD  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 5 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 310;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage5_AlphaOutputABCDMuxSum
<
    string UIName   = "Output AB CD Mux/Sum  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 5 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 311;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage5_AlphaOutputMapping
<
    string UIName   = "Output Mapping  [0=Identity  1=Scale by 1/2  2=Scale by 2  3=Scale by 4  4=Bias by -1/2  5=Expand Normal ((x-1/2)*2)]";
    string UIGroup  = "Stage 5 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 312;
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
> = 0;

// ----------------------------------------------------------------------------
// Stage 6
// ----------------------------------------------------------------------------
bool EnableStage6
<
    string UIName  = "Enable Stage 6";
    string UIGroup = "Stage 6 - Flags";
    int    UIOrder = 313;
> = false;

bool Stage6_ColorMux
<
    string UIName  = "Color Mux";
    string UIGroup = "Stage 6 - Flags";
    int    UIOrder = 314;
> = false;

bool Stage6_AlphaMux
<
    string UIName  = "Alpha Mux";
    string UIGroup = "Stage 6 - Flags";
    int    UIOrder = 315;
> = false;

bool Stage6_AOutControlsColor0Animation
<
    string UIName  = "A-Out Controls Color0 Animation";
    string UIGroup = "Stage 6 - Flags";
    int    UIOrder = 316;
> = false;

int Stage6_Color0Source
<
    string UIName   = "Color0 Source  [0=None  1=A  2=B  3=C  4=D]";
    string UIGroup  = "Stage 6 - Constants and Animation";
    string UIWidget = "Spinner";
    int    UIOrder = 317;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int Stage6_Color0AnimationFunction
<
    string UIName   = "Color0 Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "Stage 6 - Constants and Animation";
    string UIWidget = "Spinner";
    int    UIOrder = 318;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float Stage6_Color0AnimationPeriod
<
    string UIName   = "Color0 Animation Period................(Seconds)";
    string UIGroup  = "Stage 6 - Constants and Animation";
    string UIWidget = "slider";
    int    UIOrder = 319;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float4 Stage6_Color0AnimationLowerBound
<
    string UIName   = "Color0 Animation Lower Bound  (ARGB)";
    string UIGroup  = "Stage 6 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 320;
> = float4(0, 0, 0, 0);

float4 Stage6_Color0AnimationUpperBound
<
    string UIName   = "Color0 Animation Upper Bound  (ARGB)";
    string UIGroup  = "Stage 6 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 321;
> = float4(1, 1, 1, 1);

float4 Stage6_Color1
<
    string UIName   = "Color1  (ARGB)";
    string UIGroup  = "Stage 6 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 322;
> = float4(1, 1, 1, 1);

int Stage6_ColorInputA
<
    string UIName   = "Input A  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 6 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 323;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage6_ColorInputAMapping
<
    string UIName   = "Input A Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 6 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 324;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage6_ColorInputB
<
    string UIName   = "Input B  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 6 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 325;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage6_ColorInputBMapping
<
    string UIName   = "Input B Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 6 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 326;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage6_ColorInputC
<
    string UIName   = "Input C  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 6 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 327;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage6_ColorInputCMapping
<
    string UIName   = "Input C Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 6 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 328;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage6_ColorInputD
<
    string UIName   = "Input D  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 6 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 329;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage6_ColorInputDMapping
<
    string UIName   = "Input D Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 6 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 330;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage6_ColorOutputAB
<
    string UIName   = "Output AB  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 6 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 331;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage6_ColorOutputABFunction
<
    string UIName   = "Output AB Function  [0=Multiply  1=Dot Product]";
    string UIGroup  = "Stage 6 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 332;
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

int Stage6_ColorOutputCD
<
    string UIName   = "Output CD  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 6 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 333;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage6_ColorOutputCDFunction
<
    string UIName   = "Output CD Function  [0=Multiply  1=Dot Product]";
    string UIGroup  = "Stage 6 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 334;
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

int Stage6_ColorOutputABCDMuxSum
<
    string UIName   = "Output AB CD Mux/Sum  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 6 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 335;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage6_ColorOutputMapping
<
    string UIName   = "Output Mapping  [0=Identity  1=Scale by 1/2  2=Scale by 2  3=Scale by 4  4=Bias by -1/2  5=Expand Normal ((x-1/2)*2)]";
    string UIGroup  = "Stage 6 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 336;
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
> = 0;

int Stage6_AlphaInputA
<
    string UIName   = "Input A  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 6 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 337;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage6_AlphaInputAMapping
<
    string UIName   = "Input A Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 6 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 338;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage6_AlphaInputB
<
    string UIName   = "Input B  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 6 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 339;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage6_AlphaInputBMapping
<
    string UIName   = "Input B Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 6 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 340;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage6_AlphaInputC
<
    string UIName   = "Input C  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 6 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 341;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage6_AlphaInputCMapping
<
    string UIName   = "Input C Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 6 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 342;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage6_AlphaInputD
<
    string UIName   = "Input D  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 6 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 343;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage6_AlphaInputDMapping
<
    string UIName   = "Input D Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 6 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 344;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage6_AlphaOutputAB
<
    string UIName   = "Output AB  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 6 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 345;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage6_AlphaOutputCD
<
    string UIName   = "Output CD  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 6 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 346;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage6_AlphaOutputABCDMuxSum
<
    string UIName   = "Output AB CD Mux/Sum  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 6 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 347;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage6_AlphaOutputMapping
<
    string UIName   = "Output Mapping  [0=Identity  1=Scale by 1/2  2=Scale by 2  3=Scale by 4  4=Bias by -1/2  5=Expand Normal ((x-1/2)*2)]";
    string UIGroup  = "Stage 6 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 348;
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
> = 0;

// ----------------------------------------------------------------------------
// Stage 7
// ----------------------------------------------------------------------------
bool EnableStage7
<
    string UIName  = "Enable Stage 7";
    string UIGroup = "Stage 7 - Flags";
    int    UIOrder = 349;
> = false;

bool Stage7_ColorMux
<
    string UIName  = "Color Mux";
    string UIGroup = "Stage 7 - Flags";
    int    UIOrder = 350;
> = false;

bool Stage7_AlphaMux
<
    string UIName  = "Alpha Mux";
    string UIGroup = "Stage 7 - Flags";
    int    UIOrder = 351;
> = false;

bool Stage7_AOutControlsColor0Animation
<
    string UIName  = "A-Out Controls Color0 Animation";
    string UIGroup = "Stage 7 - Flags";
    int    UIOrder = 352;
> = false;

int Stage7_Color0Source
<
    string UIName   = "Color0 Source  [0=None  1=A  2=B  3=C  4=D]";
    string UIGroup  = "Stage 7 - Constants and Animation";
    string UIWidget = "Spinner";
    int    UIOrder = 353;
    float  UIMin = 0; float UIMax = 4; float UIStep = 1;
> = 0;

int Stage7_Color0AnimationFunction
<
    string UIName   = "Color0 Animation Function  [0=One  1=Zero  2=Cosine  3=Cosine (Variable Period)  4=Diagonal Wave  5=Diagonal Wave (Variable Period)  6=Slide  7=Slide (Variable Period)  8=Noise  9=Jitter  10=Wander  11=Spark]";
    string UIGroup  = "Stage 7 - Constants and Animation";
    string UIWidget = "Spinner";
    int    UIOrder = 354;
    float  UIMin = 0; float UIMax = 11; float UIStep = 1;
> = 0;

float Stage7_Color0AnimationPeriod
<
    string UIName   = "Color0 Animation Period................(Seconds)";
    string UIGroup  = "Stage 7 - Constants and Animation";
    string UIWidget = "slider";
    int    UIOrder = 355;
    float  UIMin = 0; float UIMax = 1000000; float UIStep = 0.1;
> = 0.0;

float4 Stage7_Color0AnimationLowerBound
<
    string UIName   = "Color0 Animation Lower Bound  (ARGB)";
    string UIGroup  = "Stage 7 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 356;
> = float4(0, 0, 0, 0);

float4 Stage7_Color0AnimationUpperBound
<
    string UIName   = "Color0 Animation Upper Bound  (ARGB)";
    string UIGroup  = "Stage 7 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 357;
> = float4(1, 1, 1, 1);

float4 Stage7_Color1
<
    string UIName   = "Color1  (ARGB)";
    string UIGroup  = "Stage 7 - Constants and Animation";
    string UIWidget = "Color";
    int    UIOrder = 358;
> = float4(1, 1, 1, 1);

int Stage7_ColorInputA
<
    string UIName   = "Input A  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 7 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 359;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage7_ColorInputAMapping
<
    string UIName   = "Input A Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 7 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 360;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage7_ColorInputB
<
    string UIName   = "Input B  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 7 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 361;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage7_ColorInputBMapping
<
    string UIName   = "Input B Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 7 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 362;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage7_ColorInputC
<
    string UIName   = "Input C  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 7 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 363;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage7_ColorInputCMapping
<
    string UIName   = "Input C Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 7 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 364;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage7_ColorInputD
<
    string UIName   = "Input D  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3  9=Vertex Color 0/Diffuse Light  10=Vertex Color 1/Fade Perpendicular  11=Scratch Color 0  12=Scratch Color 1  13=Constant Color 0  14=Constant Color 1  15=Map Alpha 0  16=Map Alpha 1  17=Map Alpha 2  18=Map Alpha 3  19=Vertex Alpha 0/Fade None  20=Vertex Alpha 1/Fade Perpendicular  21=Scratch Alpha 0  22=Scratch Alpha 1  23=Constant Alpha 0  24=Constant Alpha 1]";
    string UIGroup  = "Stage 7 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 365;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage7_ColorInputDMapping
<
    string UIName   = "Input D Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 7 - Color Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 366;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage7_ColorOutputAB
<
    string UIName   = "Output AB  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 7 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 367;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage7_ColorOutputABFunction
<
    string UIName   = "Output AB Function  [0=Multiply  1=Dot Product]";
    string UIGroup  = "Stage 7 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 368;
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

int Stage7_ColorOutputCD
<
    string UIName   = "Output CD  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 7 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 369;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage7_ColorOutputCDFunction
<
    string UIName   = "Output CD Function  [0=Multiply  1=Dot Product]";
    string UIGroup  = "Stage 7 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 370;
    float  UIMin = 0; float UIMax = 1; float UIStep = 1;
> = 0;

int Stage7_ColorOutputABCDMuxSum
<
    string UIName   = "Output AB CD Mux/Sum  [0=Discard  1=Scratch Color 0/Final Color  2=Scratch Color 1  3=Vertex Color 0  4=Vertex Color 1  5=Map Color 0  6=Map Color 1  7=Map Color 2  8=Map Color 3]";
    string UIGroup  = "Stage 7 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 371;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage7_ColorOutputMapping
<
    string UIName   = "Output Mapping  [0=Identity  1=Scale by 1/2  2=Scale by 2  3=Scale by 4  4=Bias by -1/2  5=Expand Normal ((x-1/2)*2)]";
    string UIGroup  = "Stage 7 - Color Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 372;
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
> = 0;

int Stage7_AlphaInputA
<
    string UIName   = "Input A  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 7 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 373;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage7_AlphaInputAMapping
<
    string UIName   = "Input A Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 7 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 374;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage7_AlphaInputB
<
    string UIName   = "Input B  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 7 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 375;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage7_AlphaInputBMapping
<
    string UIName   = "Input B Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 7 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 376;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage7_AlphaInputC
<
    string UIName   = "Input C  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 7 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 377;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage7_AlphaInputCMapping
<
    string UIName   = "Input C Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 7 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 378;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage7_AlphaInputD
<
    string UIName   = "Input D  [0=Zero  1=One  2=One Half  3=Negative One  4=Negative One Half  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3  9=Vertex Alpha 0/Fade None  10=Vertex Alpha 1/Fade Perpendicular  11=Scratch Alpha 0  12=Scratch Alpha 1  13=Constant Alpha 0  14=Constant Alpha 1  15=Map Blue 0  16=Map Blue 1  17=Map Blue 2  18=Map Blue 3  19=Vertex Blue 0/Blue Light  20=Vertex Blue 1/Fade Parallel  21=Scratch Blue 0  22=Scratch Blue 1  23=Constant Blue 0  24=Constant Blue 1]";
    string UIGroup  = "Stage 7 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 379;
    float  UIMin = 0; float UIMax = 24; float UIStep = 1;
> = 0;

int Stage7_AlphaInputDMapping
<
    string UIName   = "Input D Mapping  [0=Clamp(x)  1=1-Clamp(x)  2=2*Clamp(x)-1  3=1-2*Clamp(x)  4=Clamp(x)-1/2  5=1/2-Clamp(x)  6=x  7=-x]";
    string UIGroup  = "Stage 7 - Alpha Inputs";
    string UIWidget = "Spinner";
    int    UIOrder = 380;
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Stage7_AlphaOutputAB
<
    string UIName   = "Output AB  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 7 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 381;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage7_AlphaOutputCD
<
    string UIName   = "Output CD  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 7 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 382;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage7_AlphaOutputABCDMuxSum
<
    string UIName   = "Output AB CD Mux/Sum  [0=Discard  1=Scratch Alpha 0/Final Alpha  2=Scratch Alpha 1  3=Vertex Alpha 0/Fog  4=Vertex Alpha 1  5=Map Alpha 0  6=Map Alpha 1  7=Map Alpha 2  8=Map Alpha 3]";
    string UIGroup  = "Stage 7 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 383;
    float  UIMin = 0; float UIMax = 8; float UIStep = 1;
> = 0;

int Stage7_AlphaOutputMapping
<
    string UIName   = "Output Mapping  [0=Identity  1=Scale by 1/2  2=Scale by 2  3=Scale by 4  4=Bias by -1/2  5=Expand Normal ((x-1/2)*2)]";
    string UIGroup  = "Stage 7 - Alpha Outputs";
    string UIWidget = "Spinner";
    int    UIOrder = 384;
    float  UIMin = 0; float UIMax = 5; float UIStep = 1;
> = 0;

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

#endif // GLYPHFX_TRANSPARENT_GENERIC_PARAMS_FXH
