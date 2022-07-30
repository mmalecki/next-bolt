// Say you need to join a 20 mm x 20 mm beam with holes spaced every 20 mm
// in the center of the beam, and your own design, with a side-cut nutcatch.

use <catchnhole/catchnhole.scad>;
use <../next-bolt.scad>;
use <../lookup-kv/lookup-kv.scad>;

$fn = 20;
// Whether to "slice" these in half, to expose the innards..
slice = true;
pick = "next"; // [next, previous]

bolt = "M3";
bolt_kind = "socket_head"; // [socket_head, countersunk, headless]
h = 17.5;
w = 20;
beam_h = 20;
nutcatch_offset = $t * h; // This is usually a design rule, or a part-dependent constraint.

b = lookup_kv(next_bolt(bolt, h + beam_h - nutcatch_offset), pick);
z = pick == "next" ? lookup_kv(b, "length_clearance") : lookup_kv(b, "countersink");
echo(str(pick, " bolt is ", b));
assert(b != undef);

difference () {
  union () {
    color(alpha = 0.5) {
      cube([40, slice ? w / 2 : w, h]);
      translate([0, 0, h]) cube([80, slice ? w / 2 : w, beam_h]);
    }
  }

  translate([20, w / 2, nutcatch_offset]) {
    nutcatch_sidecut(bolt);
    // translate([0, 0, -z]) bolt(bolt, lookup_kv(b, "length"), kind = bolt_kind);
  }
}

translate([20, w / 2, nutcatch_offset]) {
  translate([0, 0, pick == "next" ? -z : 0])
    bolt(bolt, lookup_kv(b, "length"), kind = bolt_kind, head_top_clearance = pick == "previous" ? z : 0);
}
