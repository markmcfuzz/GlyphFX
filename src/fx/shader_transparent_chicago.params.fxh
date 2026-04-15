// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_chicago.params.fxh
//
// All UI-exposed parameters for shader_transparent_chicago.
// Matches the Guerrilla tag layout:
//   — global shader flags and framebuffer blend/fade settings
//   — up to 4 map stages; stages 2-4 activated with EnableMapN booleans
//   — per-map: flags, color/alpha blend function, UV transform, texture
//   — extra flags at the bottom
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
// Shader Flags
// ----------------------------------------------------------------------------
int NumericCounterLimit
<
    string UIName   = "Numeric Counter Limit";
    string UIGroup  = "Shader Flags";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 255; float UIStep = 1;
> = 0;

bool AlphaTested
<
    string UIName  = "Alpha Tested";
    string UIGroup = "Shader Flags";
> = false;

bool Decal
<
    string UIName  = "Decal";
    string UIGroup = "Shader Flags";
> = false;

bool TwoSided
<
    string UIName  = "Two Sided";
    string UIGroup = "Shader Flags";
> = false;

bool FirstMapIsScreenspace
<
    string UIName  = "First Map Is Screenspace  (not implemented in viewport)";
    string UIGroup = "Shader Flags";
> = false;

bool DrawBeforeWater
<
    string UIName  = "Draw Before Water";
    string UIGroup = "Shader Flags";
> = false;

bool IgnoreEffect
<
    string UIName  = "Ignore Effect";
    string UIGroup = "Shader Flags";
> = false;

bool ScaleFirstMapWithDistance
<
    string UIName  = "Scale First Map With Distance  (not implemented in viewport)";
    string UIGroup = "Shader Flags";
> = false;

bool Numeric
<
    string UIName  = "Numeric";
    string UIGroup = "Shader Flags";
> = false;

// Informational — select the matching technique to activate the correct blend.
int FramebufferBlendFunction
<
    string UIName   = "Framebuffer Blend Function  (select matching technique)  [0=Alpha Blend  1=Multiply  2=Double Multiply  3=Add]";
    string UIGroup  = "Shader Flags";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 3; float UIStep = 1;
> = 0;

int FramebufferFadeMode
<
    string UIName   = "Framebuffer Fade Mode  (not implemented in viewport)  [0=None  1=Fade When Perpendicular  2=Fade When Parallel]";
    string UIGroup  = "Shader Flags";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 2; float UIStep = 1;
> = 0;

// ----------------------------------------------------------------------------
// Extra Flags
// ----------------------------------------------------------------------------
bool DontFadeActiveCamouflage
<
    string UIName  = "Don't Fade Active Camouflage";
    string UIGroup = "Extra Flags";
> = false;

bool NumericCountdownTimer
<
    string UIName  = "Numeric Countdown Timer";
    string UIGroup = "Extra Flags";
> = false;

bool CustomEditionBlending
<
    string UIName  = "Custom Edition Blending";
    string UIGroup = "Extra Flags";
> = false;

// ----------------------------------------------------------------------------
// Map 1  (always active — the base stage)
// Color/alpha function is tag-visible but has no effect on the base stage.
// ----------------------------------------------------------------------------
bool Map1_Unfiltered
<
    string UIName  = "Unfiltered";
    string UIGroup = "Map 1";
> = false;

bool Map1_AlphaReplicate
<
    string UIName  = "Alpha Replicate";
    string UIGroup = "Map 1";
> = false;

bool Map1_UClamped
<
    string UIName  = "U Clamped";
    string UIGroup = "Map 1";
> = false;

bool Map1_VClamped
<
    string UIName  = "V Clamped";
    string UIGroup = "Map 1";
> = false;

int Map1_ColorFunction
<
    string UIName   = "Color Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 1";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Map1_AlphaFunction
<
    string UIName   = "Alpha Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 1";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

float Map1_UScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map1_VScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map1_UOffset
<
    string UIName   = "Map U Offset";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map1_VOffset
<
    string UIName   = "Map V Offset";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map1_Rotation
<
    string UIName   = "Map Rotation  (degrees)";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    float  UIMin = -360; float UIMax = 360; float UIStep = 0.1;
> = 0.0;

float Map1_MipmapBias
<
    string UIName   = "Mipmap Bias";
    string UIGroup  = "Map 1";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

Texture2D Map1Texture
<
    string UIName       = "Map";
    string UIGroup      = "Map 1";
    string ResourceType = "2D";
>;

// ----------------------------------------------------------------------------
// Map 2
// ----------------------------------------------------------------------------
bool EnableMap2
<
    string UIName  = "Enable Map 2";
    string UIGroup = "Map 2";
> = false;

bool Map2_Unfiltered
<
    string UIName  = "Unfiltered";
    string UIGroup = "Map 2";
> = false;

bool Map2_AlphaReplicate
<
    string UIName  = "Alpha Replicate";
    string UIGroup = "Map 2";
> = false;

bool Map2_UClamped
<
    string UIName  = "U Clamped";
    string UIGroup = "Map 2";
> = false;

bool Map2_VClamped
<
    string UIName  = "V Clamped";
    string UIGroup = "Map 2";
> = false;

int Map2_ColorFunction
<
    string UIName   = "Color Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 2";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Map2_AlphaFunction
<
    string UIName   = "Alpha Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 2";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

float Map2_UScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map2_VScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map2_UOffset
<
    string UIName   = "Map U Offset";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map2_VOffset
<
    string UIName   = "Map V Offset";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map2_Rotation
<
    string UIName   = "Map Rotation  (degrees)";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    float  UIMin = -360; float UIMax = 360; float UIStep = 0.1;
> = 0.0;

float Map2_MipmapBias
<
    string UIName   = "Mipmap Bias";
    string UIGroup  = "Map 2";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

Texture2D Map2Texture
<
    string UIName       = "Map";
    string UIGroup      = "Map 2";
    string ResourceType = "2D";
>;

// ----------------------------------------------------------------------------
// Map 3
// ----------------------------------------------------------------------------
bool EnableMap3
<
    string UIName  = "Enable Map 3";
    string UIGroup = "Map 3";
> = false;

bool Map3_Unfiltered
<
    string UIName  = "Unfiltered";
    string UIGroup = "Map 3";
> = false;

bool Map3_AlphaReplicate
<
    string UIName  = "Alpha Replicate";
    string UIGroup = "Map 3";
> = false;

bool Map3_UClamped
<
    string UIName  = "U Clamped";
    string UIGroup = "Map 3";
> = false;

bool Map3_VClamped
<
    string UIName  = "V Clamped";
    string UIGroup = "Map 3";
> = false;

int Map3_ColorFunction
<
    string UIName   = "Color Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 3";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Map3_AlphaFunction
<
    string UIName   = "Alpha Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 3";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

float Map3_UScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map3_VScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map3_UOffset
<
    string UIName   = "Map U Offset";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map3_VOffset
<
    string UIName   = "Map V Offset";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map3_Rotation
<
    string UIName   = "Map Rotation  (degrees)";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    float  UIMin = -360; float UIMax = 360; float UIStep = 0.1;
> = 0.0;

float Map3_MipmapBias
<
    string UIName   = "Mipmap Bias";
    string UIGroup  = "Map 3";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

Texture2D Map3Texture
<
    string UIName       = "Map";
    string UIGroup      = "Map 3";
    string ResourceType = "2D";
>;

// ----------------------------------------------------------------------------
// Map 4
// ----------------------------------------------------------------------------
bool EnableMap4
<
    string UIName  = "Enable Map 4";
    string UIGroup = "Map 4";
> = false;

bool Map4_Unfiltered
<
    string UIName  = "Unfiltered";
    string UIGroup = "Map 4";
> = false;

bool Map4_AlphaReplicate
<
    string UIName  = "Alpha Replicate";
    string UIGroup = "Map 4";
> = false;

bool Map4_UClamped
<
    string UIName  = "U Clamped";
    string UIGroup = "Map 4";
> = false;

bool Map4_VClamped
<
    string UIName  = "V Clamped";
    string UIGroup = "Map 4";
> = false;

int Map4_ColorFunction
<
    string UIName   = "Color Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 4";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

int Map4_AlphaFunction
<
    string UIName   = "Alpha Function  [0=Current  1=Next Map  2=Multiply  3=Double Mul  4=Add  5=Signed Add (cur)  6=Signed Add (next)  7=Subtract]";
    string UIGroup  = "Map 4";
    string UIWidget = "Spinner";
    float  UIMin = 0; float UIMax = 7; float UIStep = 1;
> = 0;

float Map4_UScale
<
    string UIName   = "Map U Scale";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map4_VScale
<
    string UIName   = "Map V Scale";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    float  UIMin = -16; float UIMax = 16; float UIStep = 0.01;
> = 1.0;

float Map4_UOffset
<
    string UIName   = "Map U Offset";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map4_VOffset
<
    string UIName   = "Map V Offset";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    float  UIMin = -1; float UIMax = 1; float UIStep = 0.001;
> = 0.0;

float Map4_Rotation
<
    string UIName   = "Map Rotation  (degrees)";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    float  UIMin = -360; float UIMax = 360; float UIStep = 0.1;
> = 0.0;

float Map4_MipmapBias
<
    string UIName   = "Mipmap Bias";
    string UIGroup  = "Map 4";
    string UIWidget = "slider";
    float  UIMin = 0; float UIMax = 1; float UIStep = 0.01;
> = 0.0;

Texture2D Map4Texture
<
    string UIName       = "Map";
    string UIGroup      = "Map 4";
    string ResourceType = "2D";
>;

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
