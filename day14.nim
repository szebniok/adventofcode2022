import strutils, sets

let input = readFile("day14input.txt").strip.splitLines
var 
  grid: HashSet[(int, int)]
  sandX = 500
  sandY, lowestY: int

for line in input:
  let pairs = line.split(" -> ")
  var   
    fromX = pairs[0].split(",")[0].parseInt
    fromY = pairs[0].split(",")[1].parseInt
  lowestY = max(lowestY, fromY)
  for pair in pairs[1..^1]:
    let 
      toX = pair.split(",")[0].parseInt
      toY = pair.split(",")[1].parseInt
    lowestY = max(lowestY, toY)
    for x in min(fromX, toX)..max(fromX, toX):
      grid.incl((x, fromY))
    for y in min(fromY, toY)..max(fromY, toY):
      grid.incl((fromX, y))
    (fromX, fromY) = (toX, toY)

proc simulate(grid: var HashSet[(int, int)], part2: bool = false): int =
  while true:
    if not part2 and sandY > lowestY: break
    elif grid.contains((500, 0)): break
    elif sandY == lowestY + 1:
      result += 1 
      grid.incl((sandX, sandY))
      (sandX, sandY) = (500, 0)
    elif not grid.contains((sandX, sandY + 1)):
      sandY += 1
    elif not grid.contains((sandX - 1, sandY + 1)):
      sandY += 1
      sandX -= 1
    elif not grid.contains((sandX + 1, sandY + 1)):
      sandY += 1
      sandX += 1
    else:
      result += 1 
      grid.incl((sandX, sandY))
      (sandX, sandY) = (500, 0)

var grid1 = grid
echo simulate(grid1)
# 2 star
echo simulate(grid, part2 = true)
