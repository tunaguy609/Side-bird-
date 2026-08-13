// Side-Bird directional trolling bird
// Screenshot silhouette + design doc dimensions
// Units: millimeters

$fn = 120;

// ---------- Toggles ----------
left_hand = false;
show_debug_axes = false;

// ---------- Dimensions from design doc ----------
overall_len = 190.5;
body_len    = 139.7;
body_dia    = 57.2;
blade_chord = 44.5;
blade_span  = 50.8;
blade_thk   = 2.3;
blade_angle = 10;
blade_x     = 56.0;
keel_len    = 50.8;
keel_depth  = 31.75;
keel_thk    = 3.2;
nose_eye_d  = 9.5;
nose_eye_len = 18;

// ---------- Helpers ----------
module debug_axes(len=25) {
  if (show_debug_axes) {
    color("red")   cube([len, 0.6, 0.6], center=false);
    color("green") cube([0.6, len, 0.6], center=false);
    color("blue")  cube([0.6, 0.6, len], center=false);
  }
}

// Flat body silhouette inspired by the screenshots.
// Body length is kept to the design doc; the outline is wide and leaf-like.
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

module bird() {
  union() {
    body_shell();
    main_bar();
    upper_spar();
    lower_spar();
    rear_fin();
    tow_eye();
  }
}

// ---------- Assembly ----------
if (left_hand) {
  mirror([0, 1, 0]) bird();
} else {
  bird();
}

if (show_debug_axes) debug_axes();
