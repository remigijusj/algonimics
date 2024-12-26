import std/[sets,tables]

type
  Nodes = HashSet[string]

  Graph = Table[string, Nodes]


# DFS recursive topological sorting
proc topoSort(graph: Graph, root: string): seq[string] =
  var order: seq[string]
  var seen: Nodes

  proc helper(node: string) =
    for dep in graph.getOrDefault(node):
      if dep notin seen:
        seen.incl(dep)
        helper(dep)
    order.insert(node, 0)

  helper(root)
  result = order


# tests
when isMainModule:
  import support/graphs
  import std/strutils

  let graph = loadGraph("data/graph2.txt", ordered=true)
  doAssert graph.topoSort("FUEL") == "FUEL,BC,AB,B,CA,C,A,ORE".split(",")

  echo "OK"
