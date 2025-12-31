// --- DRAINAGE SAUCER GENERATOR ---
// Features:
// 1. Watertight Bottom (Additive construction).
// 2. Dynamic Ribs & Hub (Scales automatically based on diameter).
// 3. Configurable dimensions.

// --- CURVE QUALITY ($fn) ---
// This number controls how smooth circles look. 
// OpenSCAD creates circles using many small straight lines.
//   60  = Good for small prints or drafts (faster to render).
//   120 = Smooth quality (recommended for final prints).
//   360 = Very high definition (slow to render).
$fn = 120; 

// --- CONFIGURATION ---

// Diameter of the pot bottom intended for this saucer
pot_diameter = 120; 

// Height of the outer side walls
wall_height = 10; 

// Lift Height (Airflow/Drainage gap)
rib_height = 4;    

// --- MATERIAL THICKNESS ---
floor_thick = 2.0; // Thickness of the solid bottom base
wall_thick = 2.0;  // Thickness of the vertical side walls
rib_thick = 2.0;   // Thickness of the internal ribs

// --- RIB SETTINGS ---
// Set to 0 = Automatic calculation
// Set to >0 = Manual Count
rib_count = 0;

// --- RENDER ---
saucer_assembly();

module saucer_assembly() {
    
    // --- DIMENSION LOGIC ---
    // Add clearance for easy fit (2mm total gap)
    inner_rad = (pot_diameter / 2) + 2;
    outer_rad = inner_rad + wall_thick;
    
    // Dynamic Hub: ~1/15th of diameter, constrained to min 4mm
    hub_radius = max(4, pot_diameter / 15);
    
    // Dynamic Ribs: 1 rib approximately every 20mm of circumference
    auto_rib_count = max(6, floor((2 * 3.14159 * inner_rad) / 20));
    step_angle = 360 / ((rib_count > 0) ? rib_count : auto_rib_count);
    
    final_ribs = (rib_count > 0) ? rib_count : auto_rib_count;

    // Output calculated parameters to console
    echo(str("Saucer Diameter: ", pot_diameter, "mm"));
    echo(str("Rib Count: ", final_ribs));
    echo(str("Hub Radius: ", hub_radius, "mm"));

    union() {
        
        // 1. SOLID FLOOR DISC
        color("DodgerBlue")
        cylinder(r=outer_rad, h=floor_thick);
        
        // 2. WALL RING
        color("SteelBlue")
        translate([0, 0, floor_thick])
        difference() {
            cylinder(r=outer_rad, h=wall_height); 
            translate([0,0,-1])
                cylinder(r=inner_rad, h=wall_height + 2); 
        }
        
        // 3. RIBS & HUB STRUCTURE
        color("LightSkyBlue")
        translate([0, 0, floor_thick])
        union() {
            // Generate Radial Ribs
            for(i=[0:final_ribs-1]) {
                rotate([0, 0, i*step_angle])
                translate([inner_rad/2, 0, rib_height/2])
                    cube([inner_rad, rib_thick, rib_height], center=true);
            }
            
            // Central Hub
            cylinder(r=hub_radius, h=rib_height);
        }
    }
}