import strutils, sequtils, math

let 
  input = readFile("day8input.txt").strip.splitLines
  trees = input.mapIt(toSeq(it.items).mapIt(int(it) - int('0')))
  height = len(trees)
  width = len(trees[0])
var 
  visible = newSeqWith(height, newSeqWith(width, false))
  highest: int

for x in 1..<width-1:
  highest = trees[0][x]
  for y in 1..<height-1:
    let tree = trees[y][x]
    if tree > highest:
      highest = tree
      visible[y][x] = true

for x in 1..<width-1:
  highest = trees[^1][x]
  for y in countdown(height-2, 1):
    let tree = trees[y][x]
    if tree > highest:
      highest = tree
      visible[y][x] = true

for y in 1..<height-1:
  highest = trees[y][0]
  for x in 1..<width-1:
    let tree = trees[y][x]
    if tree > highest:
      highest = tree
      visible[y][x] = true

for y in 1..<height-1:
  highest = trees[y][^1]
  for x in countdown(width-2, 1):
    let tree = trees[y][x]
    if tree > highest:
      highest = tree
      visible[y][x] = true
echo visible.mapIt(it.countIt(it)).sum + width * 2 + height * 2 - 4

# 2 star
var result: int
for y in 1..<height-1:
  for x in 1..<width-1:
    let tree = trees[y][x]
    var 
      top = 1
      left = 1
      right = 1
      bottom = 1
      tmpY = y - 1
      tmpX = x - 1
    while tmpY > 0 and trees[tmpY][x] < tree:
      tmpY -= 1
      top += 1
    while tmpX > 0 and trees[y][tmpX] < tree:
      tmpX -= 1
      left += 1
    (tmpY, tmpX) = (y + 1, x + 1)
    while tmpY < height-1 and trees[tmpY][x] < tree:
      tmpY += 1
      bottom += 1
    while tmpX < width-1 and trees[y][tmpX] < tree:
      tmpX += 1
      right += 1
    result = max(result, top * bottom * right * left)
echo result
