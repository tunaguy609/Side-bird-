// Side-Bird directional trolling bird
// Simplified, guaranteed-valid OpenSCAD model
// Units: millimeters

$fn = 96;

// ---------- Toggles ----------
left_hand = false;       // false = right-hand bird, true = left-hand mirror
show_debug_axes = false;

// ---------- Dimensions ----------
overall_len = 190.5;     // 7.5 in
body_len    = 139.7;     // 5.5 in
body_dia    = 57.2;      // 2.25 in
blade_chord = 44.5;      // 1.75 in
blade_span  = 50.8;      // 2.0 in
blade_thk   = 2.3;
blade_angle = 10;
blade_x     = 58.0;
keel_len    = 50.8;      // 2.0 in
keel_depth  = 31.75;     // 1.25 in below centreline
keel_thk    = 3.2;
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

// Create a lofted body from a few explicit hull stations.
module body_shell() {
  body_w = body_dia * 0.78;
  body_t = body_dia * 0.60;

  module station(x, sx, sy, sz) {
    translate([x, 0, 0])
      scale([sx, sy, sz])
        sphere(r=1);
  }

  hull() {
    station(0,                3.5, body_w*0.10, body_t*0.18);
    station(18,               5.5, body_w*0.38, body_t*0.36);
    station(45,               7.5, body_w*0.72, body_t*0.68);
    station(78,               8.0, body_w*0.95, body_t*0.94);
    station(104,              7.4, body_w*0.90, body_t*0.90);
    station(125,              5.4, body_w*0.58, body_t*0.56);
    station(body_len - 8,     2.2, body_w*0.18, body_t*0.18);
    station(body_len,         1.2, body_w*0.08, body_t*0.08);
  }
}

// Broad side bar plus two angled support fins, closer to the reference silhouette.
module side_bar() {
  translate([blade_x, 0, 0])
  rotate([0, blade_angle, 0])
  union() {
    // Main horizontal bar
    translate([0, 0, 0])
      cube([blade_chord, blade_thk, 8.0], center=true);

    // Upper forward fin
    translate([-blade_chord*0.12, 0, blade_span*0.20])
      rotate([0, 0, 22])
      cube([blade_chord*0.56, blade_thk, 6.6], center=true);

    // Lower rear fin
    translate([blade_chord*0.05, 0, -blade_span*0.26])
      rotate([0, 0, -28])
      cube([blade_chord*0.52, blade_thk, 6.6], center=true);
  }
}

// Small rear fin/keel.
module rear_fin() {
  translate([body_len - 18, 0, -keel_depth*0.72])
  rotate([0, 90, 0])
  hull() {
    translate([-keel_len*0.50, 0, 0]) cube([0.8, keel_thk, keel_depth*0.16], center=true);
    translate([ keel_len*0.50, 0, 0]) cube([0.8, keel_thk, keel_depth*0.52], center=true);
  }
}

module tow_eye() {
  translate([-nose_eye_len*0.48, 0, 0])
  rotate([0, 90, 0])
  difference() {
    cylinder(d=nose_eye_d, h=nose_eye_len, center=true);
    cylinder(d=3.5, h=nose_eye_len+2, center=true);
  }
}

module bird() {
  union() {
    body_shell();
    side_bar();
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
