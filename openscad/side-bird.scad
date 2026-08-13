// Side-Bird directional trolling bird
// Parametric OpenSCAD model based on DESIGN.md
// Units: millimeters

$fn = 96;

// ---------- Main toggles ----------
left_hand = false;       // false = right-hand bird, true = left-hand mirror
show_debug_axes = false;

// ---------- Key dimensions ----------
overall_len = 190.5;     // 7.5 in
body_len    = 139.7;     // 5.5 in
body_dia    = 57.2;      // 2.25 in
nose_len    = 25.4;      // 1.0 in
tail_len    = 12.7;      // 0.5 in
blade_chord = 44.5;      // 1.75 in
blade_span  = 50.8;      // 2.0 in
blade_thk   = 2.3;
blade_angle = 10;
blade_x     = 56.0;      // approx 40% of body length from nose

keel_len    = 50.8;      // 2.0 in
keel_depth  = 31.75;     // 1.25 in below centreline
keel_thk    = 3.2;

// Tow eye placeholder geometry
nose_eye_d  = 9.5;
nose_eye_len = 18;

// ---------- Helpers ----------
function clamp(x,a,b) = min(max(x,a),b);
function lerp(a,b,t) = a + (b-a)*t;

module debug_axes(len=25){
  if (show_debug_axes) {
    color("red")   cube([len,0.6,0.6], center=false);
    color("green") cube([0.6,len,0.6], center=false);
    color("blue")  cube([0.6,0.6,len], center=false);
  }
}

// Smooth axisymmetric body using hull between scaled spheres.
module body_shell(){
  nose_r = 4.0;
  mid_r  = body_dia/2;
  tail_r = 5.0;

  hull(){
    translate([0,0,0]) sphere(r=nose_r);
    translate([nose_len,0,0]) sphere(r=mid_r);
    translate([nose_len + (body_len-nose_len-tail_len),0,0]) sphere(r=mid_r);
    translate([body_len,0,0]) sphere(r=tail_r);
  }
}

// Side blade: a swept rectangular plate, slightly tapered by hull.
module side_blade(){
  rotate([0,blade_angle,0])
  translate([blade_x,0,0])
  rotate([0,0,90])
  hull(){
    translate([0,0,-blade_span/2]) cube([blade_chord*0.65, blade_thk, 0.8], center=true);
    translate([blade_chord*0.35,0,blade_span/2]) cube([blade_chord*0.35, blade_thk, 0.8], center=true);
  }
}

// Tail keel: a simple double-wedge-like fin extending below the centerline.
module tail_keel(){
  translate([body_len - tail_len*0.4, 0, -keel_depth])
  rotate([0,90,0])
  hull(){
    translate([-keel_len/2,0,0]) cube([0.8, keel_thk, keel_depth*0.15], center=true);
    translate([ keel_len/2,0,0]) cube([0.8, keel_thk, keel_depth*0.55], center=true);
  }
}

// Nose tow-eye boss/placeholder.
module tow_eye(){
  translate([-nose_eye_len*0.45,0,0])
  rotate([0,90,0])
  difference(){
    cylinder(d=nose_eye_d, h=nose_eye_len, center=true);
    cylinder(d=3.5, h=nose_eye_len+2, center=true);
  }
}

module bird(){
  union(){
    body_shell();
    side_blade();
    tail_keel();
    tow_eye();
  }
}

// ---------- Assembly ----------
if (left_hand) {
  mirror([0,1,0]) bird();
} else {
  bird();
}

if (show_debug_axes) debug_axes();
