// Side-Bird directional trolling bird
// Printable OpenSCAD file based on the design spec and reference screenshots
// Units: millimeters

$fn = 120;

// ---------- Toggles ----------
left_hand = false;       // false = right-hand bird, true = left-hand mirror
show_debug_axes = false;

// ---------- Scale factor ----------
scale_factor = 1.25;  // Increase overall size by 25%

// ---------- Design dimensions ----------
overall_len = 190.5 * scale_factor;
body_len    = 139.7 * scale_factor;
body_dia    = 57.2 * scale_factor;
blade_chord = 44.5 * scale_factor;
blade_span  = 50.8 * scale_factor;
blade_thk   = 2.3 * scale_factor;
blade_angle = 10;
blade_x     = 56.0 * scale_factor;
keel_len    = 50.8 * scale_factor;
keel_depth  = 31.75 * scale_factor * 1.5;  // Extend keel 50% more up the belly
keel_thk    = 3.2 * scale_factor;
nose_eye_d  = 9.5 * scale_factor;
nose_eye_len = 18 * scale_factor;

// ---------- Jet passage dimensions ----------
jet_diameter = 8 * scale_factor;  // Diameter of jet passages
jet_pos_x = 70 * scale_factor;    // Position along body (X axis)
jet_pos_z = 8 * scale_factor;     // Height offset from centerline (Z axis)

// ---------- Helpers ----------
module debug_axes(len=25) {
  if (show_debug_axes) {
    color("red")   cube([len, 0.6, 0.6], center=false);
    color("green") cube([0.6, len, 0.6], center=false);
    color("blue")  cube([0.6, 0.6, len], center=false);
  }
}

// Flat body silhouette with a rounded nose and tapered tail.
module body_shell() {
  rotate([90, 0, 0])
  linear_extrude(height=20, center=true, convexity=10)
    polygon(points=[
      [0,    0],
      [4,   10],
      [16,  18],
      [34,  24],
      [56,  28],
      [80,  29],
      [102, 27],
      [122, 21],
      [133, 12],
      [139.7, 0],
      [133,-12],
      [122,-21],
      [102,-27],
      [80, -29],
      [56, -28],
      [34, -24],
      [16, -18],
      [4,  -10]
    ]);
}

module main_bar() {
  translate([blade_x, 0, 0])
  rotate([0, blade_angle, 0])
    cube([blade_chord, blade_thk, 8.0], center=true);
}

module upper_spar() {
  translate([blade_x - 10, 0, 11])
  rotate([0, 0, 22])
    cube([blade_chord*0.52, blade_thk, 6.0], center=true);
}

module lower_spar() {
  translate([blade_x - 4, 0, -13])
  rotate([0, 0, -28])
    cube([blade_chord*0.48, blade_thk, 6.0], center=true);
}

module rear_fin() {
  translate([body_len - 18, 0, -10])
  rotate([0, 90, 0])
    cube([keel_len*0.72, keel_thk, 9.0], center=true);
}

module tow_eye() {
  translate([-nose_eye_len*0.42, 0, 0])
  rotate([0, 90, 0])
  difference() {
    cylinder(d=nose_eye_d, h=nose_eye_len, center=true);
    cylinder(d=3.5, h=nose_eye_len+2, center=true);
  }
}

// Jet passages - through-holes for port and starboard
module jet_passages() {
  // Starboard jet (right side, positive Y)
  translate([jet_pos_x, 15, jet_pos_z])
  rotate([0, 0, 90])
    cylinder(d=jet_diameter, h=30, center=true);
  
  // Port jet (left side, negative Y)
  translate([jet_pos_x, -15, jet_pos_z])
  rotate([0, 0, 90])
    cylinder(d=jet_diameter, h=30, center=true);
}

module bird() {
  difference() {
    union() {
      body_shell();
      main_bar();
      upper_spar();
      lower_spar();
      rear_fin();
      tow_eye();
    }
    // Subtract the jet passages
    jet_passages();
  }
}

// ---------- Assembly ----------
if (left_hand) {
  mirror([0, 1, 0]) bird();
} else {
  bird();
}

if (show_debug_axes) debug_axes();
