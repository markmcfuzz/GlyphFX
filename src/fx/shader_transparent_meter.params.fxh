// ----------------------------------------------------------------------------
// GlyphFX | fx/shader_transparent_meter.params.fxh
//
// All UI-exposed parameters for shader_transparent_meter.
// Also defines the lightweight VS/PS I/O structs used by this shader —
// no lighting, no normals; just clip-space position and one UV channel.
// ----------------------------------------------------------------------------

#ifndef GLYPHFX_TRANSPARENT_METER_PARAMS_FXH
#define GLYPHFX_TRANSPARENT_METER_PARAMS_FXH

// ----------------------------------------------------------------------------
// Flags
// ----------------------------------------------------------------------------
bool Decal
<
    string UIName  = "Decal";
    string UIGroup = "Flags";
    int    UIOrder = 0;
> = false;

bool TwoSided
<
    string UIName  = "Two Sided";
    string UIGroup = "Flags";
    int    UIOrder = 1;
> = false;

bool FlashColorIsNegative
<
    string UIName  = "Flash Color Is Negative";
    string UIGroup = "Flags";
    int    UIOrder = 2;
> = false;

bool TintMode2
<
    string UIName  = "Tint Mode 2";
    string UIGroup = "Flags";
    int    UIOrder = 3;
> = false;

bool Unfiltered
<
    string UIName  = "Unfiltered";
    string UIGroup = "Flags";
    int    UIOrder = 4;
> = false;

// ----------------------------------------------------------------------------
// Map
// ----------------------------------------------------------------------------
Texture2D MeterMap
<
    string UIName       = "Map";
    string UIGroup      = "Map";
    string ResourceType = "2D";
    int    UIOrder = 5;
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
//   TintColor         → c4.rgb  (c4.a is unused in base shader; see MeterTransparency)
// ----------------------------------------------------------------------------
float4 GradientMinColor
<
    string UIName   = "Gradient Min Color";
    string UIGroup  = "Colors";
    string UIWidget = "Color";
    int    UIOrder = 6;
> = float4(0.0, 0.0, 0.0, 1.0);

float4 GradientMaxColor
<   
    //(Alpha channel = gradient sensitivity: 0.125 = full sweep, 1.0 = 1/8 sweep)
    string UIName   = "Gradient Max Color";
    string UIGroup  = "Colors";
    string UIWidget = "Color";
    int    UIOrder = 7;
> = float4(0.0, 0.0, 0.0, 0.125);

float4 BackgroundColor
<
    string UIName   = "Background Color";
    string UIGroup  = "Colors";
    string UIWidget = "Color";
    int    UIOrder = 8;
> = float4(0.0, 0.0, 0.0, 1.0);

float4 FlashColor
<
    string UIName   = "Flash Color";
    string UIGroup  = "Colors";
    string UIWidget = "Color";
    int    UIOrder = 9;
> = float4(0.0, 0.0, 0.0, 1.0);

float4 TintColor
<
    string UIName   = "Tint Color";
    string UIGroup  = "Colors";
    string UIWidget = "Color";
    int    UIOrder = 10;
> = float4(0.0, 0.0, 0.0, 1.0);

float MeterTransparency
<
    string UIName   = "Meter Transparency";
    string UIGroup  = "Colors";
    string UIWidget = "slider";
    int    UIOrder = 11;
    float  UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.01;
> = 0.0;

float BackgroundTransparency
<
    string UIName   = "Background Transparency";
    string UIGroup  = "Colors";
    string UIWidget = "slider";
    int    UIOrder = 12;
    float  UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.01;
> = 0.0;

// ----------------------------------------------------------------------------
// External function source replacements
//
// In-engine these are driven at runtime by game state. In 3ds Max they are
// exposed as static sliders so the tag appearance can be previewed at any
// fill level or flash intensity.
// ----------------------------------------------------------------------------
float MeterValue
<
    string UIName   = "Meter Value  [0 = empty   1 = full]  (replaces value source)";
    string UIGroup  = "Colors";
    string UIWidget = "slider";
    float  UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.01;
> = 0.0;

float FlashBrightness
<
    string UIName   = "Flash Brightness  (replaces flash brightness source)";
    string UIGroup  = "Colors";
    string UIWidget = "slider";
    float  UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.01;
> = 0.0;

// ----------------------------------------------------------------------------
// Opacity Controls
// ----------------------------------------------------------------------------
float DitherScale
<
    string UIName   = "Dither Scale  (1 = full range)";
    string UIGroup  = "Opacity Controls";
    string UIWidget = "slider";
    float  UIMin = 0.5; float UIMax = 2.0; float UIStep = 0.01;
> = 1.0;

#endif // GLYPHFX_TRANSPARENT_METER_PARAMS_FXH
