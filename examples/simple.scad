// Say you need to join a 80 mm x 20 mm x 20 mm beam and your own 40 mm x 20 mm x 16.5 mm design,
// with a side-cut nutcatch.

use <catchnhole/catchnhole.scad>;
use <../next-bolt.scad>;
use <../lookup-kv/lookup-kv.scad>;

$fn = 25;

// Whether to "slice" our parts in half, to expose the bolt holes and nutcatch.
slice = true;
// Whether to pick the next-, or previous-sized bolt.
pick = "next"; // [next, previous]
// Whether to show the bolt itself (as opposed to just the bolt hole).
show_bolt = true;

// Metric bolt size.
bolt = "M3";
// Bolt head shape.
bolt_kind = "socket_head"; // [socket_head, countersunk, headless]
// Heigh of our part.
h = 16.5;
// Width of our the beam and our part.
w = 20;
// Height of the beam we're joining to.
beam_h = 20;
// How far from the bottom of the part to place the side-cut nutcatch.
nutcatch_offset = 3;

b = lookup_kv(next_bolt(bolt, h + beam_h - nutcatch_offset), pick);
z = pick == "next" ? lookup_kv(b, "length_clearance") : lookup_kv(b, "countersink");
echo(str(pick, " bolt is ", b));
assert(b != undef, "the picked bolt should not be undefined");

difference () {
  union () {
    color(alpha = 0.5) {
      cube([40, slice ? w / 2 : w, h]);
      translate([0, 0, h]) cube([80, slice ? w / 2 : w, beam_h]);
    }
  }

  to_nutcatch () {
    nutcatch_sidecut(bolt);
    picked_bolt();
  }
}

module to_nutcatch () {
  translate([20, w / 2, nutcatch_offset]) children();
}

module picked_bolt () {
  translate([0, 0, pick == "next" ? -z : 0])
    bolt(bolt, lookup_kv(b, "length"), kind = bolt_kind, head_top_clearance = pick == "previous" ? z : 0);
}

if (show_bolt) {
  to_nutcatch ()
    picked_bolt();
}
