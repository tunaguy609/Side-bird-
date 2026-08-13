// Side-Bird directional trolling bird
// Updated to better match the shown Cults3D reference shape
// Units: millimeters

$fn = 120;

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
nose_eye_d   = 9.5;
nose_eye_len = 18;

// ---------- Shape controls ----------
// These are tuned to give a flatter top, fuller belly, sharper nose/tail,
// and more of the “directional bird” silhouette from the reference images.
body_scale_y = 1.0;
body_scale_z = 1.0;
nose_r       = 5.0;
shoulder_r   = body_dia * 0.50;
mid_r        = body_dia * 0.53;
tail_r       = 4.4;

blade_root_drop = 2.0;   // slight downward lean to the outer blade

// ---------- Helpers ----------
function lerp(a,b,t) = a + (b-a)*t;

module debug_axes(len=25){
  if (show_debug_axes) {
    color("red")   cube([len,0.6,0.6], center=false);
    color("green") cube([0.6,len,0.6], center=false);
    color("blue")  cube([0.6,0.6,len], center=false);
  }
}

// More bird-like body using several hull stations.
module body_shell(){
  hull(){
    translate([0,0,0]) scale([0.95,0.78,0.92]) sphere(r=nose_r);
    translate([nose_len*0.40,0,0]) scale([1.00,0.95,1.00]) sphere(r=shoulder_r);
    translate([nose_len + 40,0,0]) scale([1.02,1.00,1.00]) sphere(r=mid_r);
    translate([nose_len + 78,0,0]) scale([1.00,0.98,0.98]) sphere(r=mid_r*0.98);
    translate([body_len - 18,0,0]) scale([0.72,0.90,0.88]) sphere(r=tail_r);
    translate([body_len,0,0]) scale([0.42,0.62,0.60]) sphere(r=4.0);
  }
}

// Side blade: more like the reference, with a broad straight bar and swept lower fin.
module side_blade(){
  rotate([0,blade_angle,0])
  translate([blade_x,0,0])
  union(){
    // Main crossbar
    translate([0,0,0])
      cube([blade_chord, blade_thk, 8.0], center=true);

    // Forward swept upper fin segment
    rotate([0,0,28])
      translate([-blade_chord*0.12, 0, blade_span*0.18])
      cube([blade_chord*0.52, blade_thk, 7.0], center=true);

    // Lower swept fin segment
    rotate([0,0,-24])
      translate([-blade_chord*0.18, 0, -blade_span*0.24 - blade_root_drop])
      cube([blade_chord*0.58, blade_thk, 7.0], center=true);
  }
}

// Tail keel: slightly more pronounced and angled like the reference thumbnails.
module tail_keel(){
  translate([body_len - tail_len*0.15, 0, -keel_depth*0.92])
  rotate([0,90,0])
  hull(){
    translate([-keel_len/2,0,0]) cube([0.8, keel_thk, keel_depth*0.18], center=true);
    translate([ keel_len/2,0,0]) cube([0.8, keel_thk, keel_depth*0.62], center=true);
  }
}

// Nose tow-eye boss/placeholder.
module tow_eye(){
  translate([-nose_eye_len*0.48,0,0])
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
