# Parametric Smart Drainage Saucer

A fully parametric OpenSCAD script for generating 3D printable plant pot saucers.

Unlike scaling a standard STL file - which results in thick, wasteful walls and distorted geometry - this script recalculates the mesh to ensure walls remain thin (2mm) and internal ribs are evenly spaced, regardless of the saucer size.

## Features

* **Solve the Scaling Problem:** Whether your pot is 50mm or 300mm, the walls stay efficient and the print time remains optimized.
* **Smart Internal Ribs:** Automatically calculates the optimal number of ribs to support the weight of the pot while allowing airflow and drainage.
* **Watertight Construction:** Uses additive geometry to ensure a solid, leak-proof bottom layer.
* **Dynamic Hub:** The center support scales automatically to handle the weight of larger pots.

## How to Use

1. Download and install [OpenSCAD](https://openscad.org/).
2. Open `drainage_saucer.scad`.
3. Adjust the variables at the top of the file to match your pot:
    ```openscad
    pot_diameter = 120; // The bottom diameter of your pot
    wall_height = 10;   // How tall the side walls should be
    ```
4. Press **F5** to Preview.
5. Press **F6** to Render.
6. File -> Export -> Export as STL.

## Customization Options

| Variable | Default | Description |
| :--- | :--- | :--- |
| `pot_diameter` | 120 | Diameter of the pot bottom (mm). |
| `wall_height` | 10 | Height of the outer rim (mm). |
| `floor_thick` | 2.0 | Thickness of the solid bottom base (mm). |
| `wall_thick` | 2.0 | Thickness of the vertical side walls (mm). |
| `rib_height` | 4 | Air gap under the pot (mm). |
| `rib_thick` | 2.0 | Thickness of the internal ribs (mm). |
| `rib_count` | 0 | Set to 0 for automatic calculation, or a number to force a specific count. |
| `$fn` | 120 | Curve smoothness (resolution). Higher = smoother but slower to render. |

## License

This project is open source and free to use.
