import strutils, sets, strscans

type Position = tuple[x: int, y: int]

func `-`(a, b: Position): Position =
  (a.x - b.x, a.y - b.y)

func `+=`(a: var Position, b: Position) =
  a = (a.x + b.x, a.y + b.y)

let input = readFile("day9input.txt").strip().splitLines

proc move(input: seq[string], nodes: var seq[Position]): int =
  var
    dir: char
    count: int
    visited: HashSet[Position]
    move: Position
  for line in input:
    discard scanf(line, "$c $i", dir, count) 
    case dir:
      of 'L': move = (-1, 0)
      of 'R': move = (1, 0)
      of 'U': move = (0, -1)
      else: move = (0, 1)
    for _ in 0..<count:
      nodes[0] += move
      for i, node in nodes.mpairs:
        if i == 0: continue
        let diff = nodes[i - 1] - node
        if diff.x.abs > 1 or diff.y.abs > 1:
          node += (diff.x.clamp(-1, 1), diff.y.clamp(-1, 1))
      visited.incl(nodes[^1])
  visited.len

var nodes = newSeq[Position](2)
echo move(input, nodes)

# 2 star
nodes = newSeq[Position](10)
echo move(input, nodes)
