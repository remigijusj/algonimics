import std/[sets,tables]
import std/[sequtils,strutils]

type
  Nodes = HashSet[string]

  Graph = Table[string, Nodes]


# https://en.wikipedia.org/wiki/Bron-Kerbosch_algorithm
iterator bronKerbosch(graph: Graph, r, p, x: Nodes): Nodes {.closure.} =
  if p.len == 0 and x.len == 0:
    yield r
  var p = p
  var x = x
  while p.len > 0:
    let v = p.pop
    let r1 = r.union([v].toHashSet)
    let p1 = p.intersection(graph[v])
    let x1 = x.intersection(graph[v])
    for c in graph.bronKerbosch(r1, p1, x1):
      yield c
    x.incl(v)


func findLargestClique(graph: Graph): Nodes =
  var r0, x0: Nodes
  let p0 = graph.keys.toSeq.toHashSet # ... avoid toSeq
  for clique in graph.bronKerbosch(r0, p0, x0):
    if clique.card > result.card:
      result = clique


# tests
when isMainModule:
  import support/graphs

  let maxClique = "cc,ff,fh,fr,ny,oa,pl,rg,uj,wd,xn,xs,zw".split(',').toHashSet # unique!
  doAssert loadGraph("data/2024-23.txt").findLargestClique == maxClique

  echo "OK"
