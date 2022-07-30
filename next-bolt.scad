use <./utils.scad>;

lengths = import("bolt-lengths.json");

function bolt_lengths (options = undef) =
  is_undef(options) ? lengths : (is_string(options) ? lengths[options] : options);

function next_bolt (options, min_length, previous = undef) =
  let (lengths = bolt_lengths(options))
    len(lengths) > 0 ? (
      (lengths[0] >= min_length) ?
        [
          ["next", [
            ["length_clearance", lengths[0] - min_length],
            ["length", lengths[0]]
          ]],
          is_undef(previous) ?
            ["previous", undef] :
            ["previous", [
              ["length", previous],
              ["countersink", min_length - previous]
            ]],
        ] : next_bolt(slice(lengths, 1, len(lengths) - 1), min_length, previous = lengths[0])
    ) : [
      ["previous", [
        ["length", previous],
        ["countersink", min_length - previous]
      ]]
    ];
