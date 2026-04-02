# Detail Mask
The detail mask parameter in the `shader_model` is technique to mask a detail map with a desired chanel from a `multipurpose map`. Using the grayscale 
mask, you can control where the detail map is applied on the surface, allowing for more efficient use of texture space and better visual results. The detail mask options include using the reflection mask, self-illumination mask, change color mask, or auxiliary mask, as well as their inverses. This flexibility allows you to achieve a wide range of effects by leveraging the existing channels in the multipurpose map.

---

### Multipurpose Map

> The multipurpose map is an optional bitmap whose individual channels provide greyscale masks for color change, reflections, self illumination, and detail maps (a technique called channel packing). The purpose of each channel depends on the game version:

- **PC**
    - `Red` = auxiliary, `Green` = self-illumination, `Blue` = specular, `Alpha` = change color
- **Xbox**
    - `Red` = specular, `Green` = self-illumination, `Blue` = change color, `Alpha` = auxiliary

---

### Detail Mask Options
This parameter is controlled with a **slider** with a number of preset options:
| Value | Parameter |
|---|---|
| 0 | No detail mask, detail map fully applied |
| 1 | Reflection Mask Inverse |
| 2 | Reflection Mask |
| 3 | Self-Illumination Mask Inverse |
| 4 | Self-Illumination Mask |
| 5 | Change Color Mask Inverse |
| 6 | Change Color Mask |
| 7 | Auxiliary Mask Inverse |
| 8 | Auxiliary Mask |
