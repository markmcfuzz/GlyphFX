# Detail Function
The detail function parameter in the `shader_model` controls how the detail map blends with the base map. Each blending mode offers a different way to combine the detail map with the base map, allowing for various visual effects. The choice of detail function can significantly impact the appearance of surfaces, especially when used in conjunction with the detail mask to control where the detail map is applied.

---

## Detail Function Options
This parameter is controlled with a **slider** with a number of preset options:
| Value | Parameter |
|---|---|
| 0 | Double/Biased Multiply |
| 1 | Multiply |
| 2 | Double/Biased Add |

### Double/Biased Multiply
The detail colour is multiplied with the base colour and multipied by **2**, then clamped to **0-1**. Where detail is masked, this has no effect. Unlike the S-shaped response curve of Photoshop's Overlay blending mode, this function continues to brighten exponentially and quickly saturates when the detail map is lighter than **50% gray**.
```h
detail = lerp(0.5, detail.rgb, detail_mask);
result = saturate(base.rgb * detail * 2.0);
```
### Multiply
The detail map is simply multiplied with the base colour, generally darkening the result. Where detail is masked, this has no effect.
```h
detail = lerp(1.0, detail.rgb, detail_mask);
result = saturate(base.rgb * detail);
```
### Double/Biased Add
Has the effect of adding or subtracting the detail map to/from the base map. Where detail is masked or 50% gray, this has no effect.
```h
detail = lerp(0.5, detail.rgb, detail_mask);
biased_detail = 2.0 * detail - 1.0;
result = saturate(base.rgb + biased_detail);
```