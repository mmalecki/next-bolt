use <../next-bolt.scad>;
use <../lookup-kv/lookup-kv.scad>;

module test_too_long () {
  match = next_bolt("M3", 150);
  assert(is_undef(lookup_kv(match, "next")), "there is no M3 bolt longer than 150 mm");
  previous = lookup_kv(match, "previous");
  assert(lookup_kv(previous, "length") == 70);
  assert(lookup_kv(previous, "countersink") == 80);
}

module test_too_short () {
  match = next_bolt("M3", 1);
  next = lookup_kv(match, "next");
  assert(is_undef(lookup_kv(match, "previous")), "there is no M3 bolt shorter than 1 mm");
  assert(lookup_kv(next, "length") == 4);
  assert(lookup_kv(next, "length_clearance") == 3);
}

module test_just_right () {
  match = next_bolt("M3", 36.5);
  echo(match);
  next = lookup_kv(match, "next");
  previous = lookup_kv(match, "previous");

  assert(!is_undef(next), "there is a M3 bolt longer than 36.5 mm");
  assert(lookup_kv(next, "length") == 40);
  assert(lookup_kv(next, "length_clearance") == 3.5);

  assert(!is_undef(previous), "there is a M3 bolt shorter than 36.5 mm");
  assert(lookup_kv(previous, "length") == 35);
  assert(lookup_kv(previous, "countersink") == 1.5);
}

test_too_long();
test_too_short();
test_just_right();
