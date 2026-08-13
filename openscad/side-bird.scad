// Side-Bird directional trolling bird
// Rebuilt to more closely match the reference silhouette
// Units: millimeters

$fn = 140;

// ---------- Main toggles ----------
left_hand = false;       // false = right-hand bird, true = left-hand mirror
show_debug_axes = false;

// ---------- Overall dimensions ----------
overall_len = 190.5;     // 7.5 in
body_len    = 139.7;     // 5.5 in
body_dia    = 57.2;      // 2.25 in
blade_chord = 44.5;      // 1.75 in
blade_span  = 50.8;      // 2.0 in
blade_thk   = 2.3;
blade_angle = 10;
blade_x     = 58.0;      // slightly forward like the reference

keel_len    = 50.8;      // 2.0 in
keel_depth  = 31.75;     // 1.25 in below centreline
keel_thk    = 3.2;

nose_eye_d   = 9.5;
nose_eye_len = 18;

// ---------- Profile controls ----------
// Reference-like body: flatter, broader in the middle, sharper nose and tail.
body_thickness = 0.60 * body_dia;
body_width     = 0.78 * body_dia;

// Stations: [x, width_scale, thickness_scale]
profile_pts = [
  [0,    0.10, 0.22],
  [8,    0.34, 0.34],
  [20,   0.58, 0.55],
  [38,   0.82, 0.78],
  [62,   1.00, 0.95],
  [88,   0.98, 0.95],
  [112,  0.86, 0.82],
  [126,  0.60, 0.60],
  [136,  0.30, 0.34],
  [body_len, 0.08, 0.16]
];

// ---------- Helpers ----------
function sgn(v) = v < 0 ? -1 : 1;

module debug_axes(len=25){
  if (show_debug_axes) {
    color("red")   cube([len,0.6,0.6], center=false);
    color("green") cube([0.6,len,0.6], center=false);
    color("blue")  cube([0.6,0.6,len], center=false);
  }
}

function interp_pts(i) = profile_pts[i];

module station(x, ws, ts){
  translate([x,0,0])
    scale([1, ws*body_width/2, ts*body_thickness/2])
      sphere(r=1);
}

module body_shell(){
  union(){
    for (i = [0 : len(profile_pts)-2]) {
      hull(){
        station(profile_pts[i][0],   profile_pts[i][1],   profile_pts[i][2]);
        station(profile_pts[i+1][0], profile_pts[i+1][1], profile_pts[i+1][2]);
      }
    }
  }
}

// Main side bar: broad and flat, like the reference images.
module side_bar(){
  translate([blade_x, 0, 0])
  rotate([0, blade_angle, 0])
  union(){
    // main horizontal bar
    translate([0,0,0]) cube([blade_chord, blade_thk, 8.2], center=true);

    // forward-up fin on the outer side
    translate([-blade_chord*0.10, 0, blade_span*0.18])
      rotate([0,0,22])
      cube([blade_chord*0.55, blade_thk, 6.8], center=true);

    // lower-rear fin on the inner side
    translate([blade_chord*0.05, 0, -blade_span*0.26])
      rotate([0,0,-28])
      cube([blade_chord*0.52, blade_thk, 6.8], center=true);
  }
}

// Rear fin/keel: kept subtle, so the silhouette stays close to the shown model.
module rear_fin(){
  translate([body_len - 20, 0, -keel_depth*0.72])
  rotate([0,90,0])
  hull(){
    translate([-keel_len*0.50,0,0]) cube([0.8, keel_thk, keel_depth*0.16], center=true);
    translate([ keel_len*0.50,0,0]) cube([0.8, keel_thk, keel_depth*0.52], center=true);
  }
}

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
    side_bar();
    rear_fin();
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
