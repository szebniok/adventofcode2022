import strutils, sequtils, deques, sets

let 
  input = readFile("day12input.txt").strip.splitLines
  grid: seq[seq[int]] = input.mapIt(it.mapIt(int(it)))
  height = grid.len
  width = grid[0].len

var 
  queue: Deque[(int, int, int)]
  visited: HashSet[(int, int)]
  part1, part2: int

for y, row in grid:
  let x = row.find(int('E'))
  if x > -1:
    queue.addLast((x, y, 0))
    break

proc canClimb(h, x, y: int): bool =
  if not (0 <= x and x < width): false
  elif not (0 <= y and y < height): false
  elif h == int('E'): true 
  else: 
    let other = grid[y][x]
    other == int('S') or h - other <= 1

while queue.len > 0:
  let 
    (x, y, steps) = queue.popFirst()
    h = grid[y][x]
  if visited.containsOrIncl((x, y)): continue
  if h == int('S') and part1 == 0:
    part1 = steps
  if h == int('a') and part2 == 0:
    part2 = steps
  if canClimb(h, x - 1, y): queue.addLast((x - 1, y, steps + 1))
  if canClimb(h, x + 1, y): queue.addLast((x + 1, y, steps + 1))
  if canClimb(h, x, y - 1): queue.addLast((x, y - 1, steps + 1))
  if canClimb(h, x, y + 1): queue.addLast((x, y + 1, steps + 1))

echo part1
# 2 star
echo part2
