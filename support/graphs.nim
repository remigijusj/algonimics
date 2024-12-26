import std/[strutils,sets,tables]

type
  Nodes = HashSet[string]

  Graph = Table[string, Nodes]


proc loadGraph*(filename: string): Graph =
  let lines = readFile(filename).strip.splitLines
  for line in lines:
    let a = line[0..1]
    let b = line[3..4]
    discard result.hasKeyOrPut(a, [b].toHashSet)
    discard result.hasKeyOrPut(b, [a].toHashSet)
    result[a].incl(b)
    result[b].incl(a)
