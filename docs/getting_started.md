# Getting Started

This guide explains how to use **GlyphFX** shaders in Autodesk 3ds Max.

## Requirements

- Autodesk 3ds Max 2023 to 2026
- A DirectX 11 compatible GPU

## Installation

1. Clone or download this repository:
```bash
   git clone https://github.com/markmcfuzz/GlyphFX.git
```

2. Point 3ds Max to the `fx/` folder - you can keep it anywhere on disk.

## 3ds Max Configuration

> [!IMPORTANT]
> This step is crucial for the shaders to function correctly in 3ds Max.
> 1. Open 3ds Max and go to **File** -> **Preferences** -> **Gamma and LUT** and uncheck **Enable Gamma/LUT Correction**.
>
> 2. For rendering, press **F10** to open the Render Setup dialog, go to the **Renderer** tab and select **Quicksilver Hardware Renderer**.

> [!WARNING]
> For 3ds Max 2025 and later go to **Rendering** -> **Color Management** and change the `Color Management Mode` tab to **Unmanaged** then click in `Save As System Defaults` close and restart 3ds Max.

## Loading a Shader in 3ds Max

1. Open the **Material Editor** (`M` key) and select **Slate Material Editor**.
2. Right click in the space and select **Materials** -> **General** -> **DirectX Shader**.
3. In the DirectX Shader section, click the `.fx` file slot path (under `HLSL File` dropdown).
4. Browse to `fx/` and select the shader you want, for example:

      `GlyphFX/fx/shader_model.fx`

5. The shader parameters will appear in the material UI - assign your
   textures and configure the flags to match your tag.

## Texture Slots

Each shader exposes its texture slots directly in the material UI.
Refer to the [Shader Types](shader_types.md) document for the specific
slots and parameters of each shader.

> [!TIP]
> - The shader works with **Standard**, **High Quality**, and **DX Mode** viewport shading modes.
> - Use the **Debug Mode** parameter to inspect individual texture channels
>   directly in the viewport.
> - Texture paths are not embedded in the `.fx` file - you must assign them
>   manually in the Material Editor each time.