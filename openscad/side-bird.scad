// Side-Bird directional trolling bird
// Rebuilt from scratch to match the uploaded reference silhouette
// Units: millimeters

$fn = 96;

// ---------- Toggles ----------
left_hand = false;       // false = right-hand bird, true = left-hand mirror
show_debug_axes = false;

// ---------- Primary dimensions ----------
overall_len = 190.5;     // 7.5 in
body_len    = 120.0;     // image-driven silhouette length
body_w      = 58.0;      // broad, flat body
body_t      = 20.0;      // thin profile
blade_x     = 60.0;
blade_thk   = 2.3;
blade_chord = 52.0;
blade_h     = 44.0;
blade_angle = 10;

rear_fin_x  = 88.0;
rear_fin_w  = 10.0;
rear_fin_h  = 22.0;
rear_fin_t  = 2.4;

nose_eye_d   = 9.5;
nose_eye_len = 18;

// ---------- Helpers ----------
module debug_axes(len=25) {
  if (show_debug_axes) {
    color("red")   cube([len, 0.6, 0.6], center=false);
    color("green") cube([0.6, len, 0.6], center=false);
    color("blue")  cube([0.6, 0.6, len], center=false);
  }
}

// 2D body profile used for a flat, wing-like silhouette.
module body_profile_2d() {
  polygon(points=[
    [0,   0],
    [8,   10],
    [24,  20],
    [50,  28],
    [78,  30],
    [102, 26],
    [116, 14],
    [120,  0],
    [116,-14],
    [102,-26],
    [78, -30],
    [50, -28],
    [24, -20],
    [8,  -10]
  ]);
}

module body_shell() {
  linear_extrude(height=body_t, center=true, convexity=10)
    scale([body_w/60, 1, 1])
      body_profile_2d();
}

// Main cross bar seen in the reference.
module main_bar() {
  translate([blade_x, 0, 0])
  rotate([0, blade_angle, 0])
    cube([blade_chord, blade_thk, 8.0], center=true);
}

// Diagonal support pieces like the photo.
module upper_spar() {
  translate([blade_x - 8, 0, 12])
  rotate([0, 0, 22])
    cube([blade_chord*0.48, blade_thk, 6.0], center=true);
}

module lower_spar() {
  translate([blade_x - 4, 0, -14])
  rotate([0, 0, -28])
    cube([blade_chord*0.46, blade_thk, 6.0], center=true);
}

// Small rear fin near the back of the body.
module rear_fin() {
  translate([rear_fin_x, 0, -8])
  rotate([0, 90, 0])
    cube([rear_fin_h, rear_fin_t, rear_fin_w], center=true);
}

// Small nose tow eye/boss.
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
