import std/[strutils,sets,tables]

type
  Nodes = HashSet[string]

  Graph = Table[string, Nodes]


proc loadGraph*(filename: string, ordered=false): Graph =
  let lines = readFile(filename).strip.splitLines
  for line in lines:
    let parts = line.split('-', 2)
    let a = parts[0]
    let b = parts[1]
    discard result.hasKeyOrPut(a, [b].toHashSet)
    result[a].incl(b)
    if not ordered:
      discard result.hasKeyOrPut(b, [a].toHashSet)
      result[b].incl(a)
