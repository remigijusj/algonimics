import std/[strutils]

type
  XY = tuple[x, y: int]

  # Assumption: all rows have the same length,
  # the walls are marked by `#` and enclose the outside perimeter.
  Grid* = seq[string]


proc loadGrid*(filename: string): Grid =
  readFile(filename).strip.splitLines


func `[]`*(grid: Grid, c: char): XY =
  for y, line in grid:
    for x, val in line:
      if val == c: return (x, y)
