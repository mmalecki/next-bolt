# next-bolt
Sometimes you just need someone to hand you the next bolt. In OpenSCAD.

This library accepts a bolt kind (e.g. "M3") a length you need to cover (e.g.,
36.5 mm), and returns the previous-sized, next-sized bolt lengths, and how deep
to respectively, countersink or add clearance.

This allows you to keep your bolt lengths real-life-sized, without driving the
design from the bolt size.

The examples use [`catchnhole`](https://github.com/mmalecki/catchnhole/) for convenience, but this library is absolutely
agnostic about how you choose to (or not to!) render your bolts. You do you.

Anyway, check this out:

```
use <next-bolt/next-bolt.scad>;
echo(next_bolt("M3", 36.5));
// Echoes:
// [
//   ["next", [["length_clearance", 3.5], ["length", 40]]],
//   ["previous", [["length", 35], ["countersink", 1.5]]]
// ]
```

So for the aforementioned bolt and length, our choices are to either use a M3x40
bolt, and add 3.5 mm of bolt-sized clearance past the thing we're trying to reach
with our bolt, or use a M3x35 bolt and countersink it by 1.5 mm.

## Installation
Add a git submodule to your project:

```sh
git submodule add https://github.com/mmalecki/openscad-next-bolt next-bolt
```
## Usage
```openscad
use <next-bolt/next-bolt.scad>;

echo(next_bolt("M3", 36.5));
```
