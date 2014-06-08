screen_pos
==========

A small commandline shorthand for using xrandr to position the main monitor relative to a second monitor.

Usage: `coffee index.coffee relative_coord [relative_pos] [-n]`

`relative_coord` is the number of pixes to position the main monitor down or to the left of the second monitor (depending on `relative_pos`).

`relative_pos` is the direction-position of the main monitor relative to the second monitor: 'under', 'above', 'left', or 'right'. Default is 'under'.

`-n` is whether or not to negate `relative_coord` (a required hack because commandline argument '-5' is interpreted as "argument named '5' is true").
