// slabV printed bottom tray (replaces the acrylic bottom plate).
// Stack above it is unchanged: PCB, 3mm acrylic mid + Mylar, 1.6mm acrylic top.
// Coordinates are the slabV DXF coordinates (mm). Outline: slabv_outline.dxf,
// the outer edge of upstream case/slabv_bot.dxf (same as the PCB edge).
//
// part = "tray" for the full tray, "test" for the one-corner fit test.

part = "tray";

/* [Fit] */
clear      = 0.4;   // gap between PCB edge and tray wall
wall       = 2.4;   // wall thickness
floor_t    = 2.0;   // floor thickness
under_gap  = 3.5;   // PCB bottom to floor top: clears diodes, pins, Mill-Max tails
pcb_t      = 1.6;
rim_above  = 0;     // wall height above the PCB top (0 = flush with the PCB top)

/* [Screws: M2 from below into the 3mm F/F standoffs] */
boss_d     = 6.0;
hole_d     = 2.4;   // M2 clearance
head_d     = 4.4;   // counterbore for the screw head
shoulder   = 1.5;   // plastic left between screw head and PCB (acts like the 1.6mm bottom plate)

/* [Battery: under the PCB between the controller header rows] */
bat_w      = 13.1;  // measured cell 30 x 12.5 x 3mm, + 0.6 clearance
bat_l      = 30.6;
bat_y      = -36;   // centre of the pocket
bat_depth  = 1.0;   // recess into the floor to locate it

/* [Power switch: SS12D00-style slide switch, beside the USB notch, lever out into the notch] */
// Sits under the PCB in the clear strip between the right notch edge
// ((5.52,-17.18) to (9.62,-1.5)) and SW6's pins (x > 15.6).
sw_w       = 8.8;   // body length + clearance (runs along the notch edge)
sw_d       = 3.8;   // body depth + clearance
sw_depth   = 1.5;   // recess into the floor
sw_pos     = [9.7, -9.9];  // body centre
sw_angle   = 75.3;  // notch edge direction
lever_w    = 5.0;   // slot width for the lever travel
lever_h    = 2.6;

/* [Wire channel: battery leads from under the PCB up into the controller notch] */
wire_w     = 4.0;

$fn = 48;

screws = [
  [-91.23, -27.09], [-87.90,   4.41], [-55.51, -51.18], [-31.38, -16.19],
  [-13.89, -69.79], [-12.40, -44.07], [ 12.40, -44.03], [ 14.07, -69.77],
  [ 31.52, -16.20], [ 55.51, -51.18], [ 88.01,   4.41], [ 91.23, -27.09]
];

H = floor_t + under_gap + pcb_t + rim_above;
pcb_bottom = floor_t + under_gap;

module outline() { import("slabv_outline.dxf"); }

module shell() {
  difference() {
    linear_extrude(H) offset(r = clear + wall) outline();
    translate([0, 0, floor_t]) linear_extrude(H) offset(delta = clear) outline();
  }
}

module bosses() {
  for (p = screws) translate([p[0], p[1], 0]) cylinder(d = boss_d, h = pcb_bottom);
}

module screw_holes() {
  for (p = screws) translate([p[0], p[1], 0]) {
    translate([0, 0, -1]) cylinder(d = hole_d, h = H + 2);
    translate([0, 0, -1]) cylinder(d = head_d, h = pcb_bottom - shoulder + 1);
  }
}

module battery_pocket() {
  translate([-bat_w / 2, bat_y - bat_l / 2, floor_t - bat_depth]) cube([bat_w, bat_l, H]);
}

module switch_cut() {
  translate([sw_pos[0], sw_pos[1], 0]) rotate([0, 0, sw_angle]) {
    translate([-sw_w / 2, -sw_d / 2, floor_t - sw_depth]) cube([sw_w, sw_d, H]);
    // Lever slot: out of the body's notch side (+y here = towards the notch).
    translate([-lever_w / 2, 0, floor_t - sw_depth + 0.6]) cube([lever_w, 10, lever_h]);
  }
}

module wire_channel() {
  // Through the wall at the bottom of the top-centre notch (PCB edge at y = -18.88),
  // so the leads can come up past the PCB edge to the nice!nano.
  translate([-wire_w / 2, -18.88 - 1, floor_t]) cube([wire_w, clear + wall + 2, H]);
}

module tray() {
  difference() {
    union() { shell(); bosses(); }
    screw_holes();
    battery_pocket();
    switch_cut();
    wire_channel();
  }
}

if (part == "tray") tray();
if (part == "test")
  intersection() {
    tray();
    translate([-116, -48, -1]) cube([36, 34, H + 2]);
  }
