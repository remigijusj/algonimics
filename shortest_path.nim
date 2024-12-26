import std/[heapqueue,tables]

type
  Node = tuple[x, y: int]

  Grid = seq[string]

  Item = tuple
    node: Node
    prio: int

func `<`(a, b: Item): bool = a.prio < b.prio


iterator neighbors(p: Node): Node =
  yield (p.x+1, p.y)
  yield (p.x, p.y+1)
  yield (p.x-1, p.y)
  yield (p.x, p.y-1)


func shortestDist(grid: Grid, start, finish: Node): int =
  var queue: HeapQueue[Item] = [(start, 0)].toHeapQueue
  var visited = {start: 0}.toTable
  while queue.len > 0:
    let (this, _) = queue.pop
    if this == finish:
      break # ... why?
    for next in this.neighbors:
      if grid[next.y][next.x] == '#':
        continue
      if next in visited and visited[next] <= visited[this] + 1:
        continue
      visited[next] = visited[this] + 1
      queue.push (next, visited[next])

  result = visited[finish]


# tests
when isMainModule:
  import support/grids

  let grid1 = loadGrid("data/2024-16.txt")
  doAssert grid1.shortestDist(grid1['S'], grid1['E']) == 388

  let grid2 = loadGrid("data/2024-20.txt")
  doAssert grid2.shortestDist(grid2['S'], grid2['E']) == 9376

  echo "OK"
