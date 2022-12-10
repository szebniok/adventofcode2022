import strutils, sequtils, math

let input = readFile("day10input.txt").strip().splitLines
var cycles = @[1]

for line in input:
  cycles.add(cycles[^1])
  if line.startsWith("addx"):
    cycles.add(cycles[^1] + line.split(" ")[1].parseInt)

echo @[20, 60, 100, 140, 180, 220].mapIt(it * cycles[it - 1]).sum

# 2 star
for i, v in cycles:
  let crtX = i mod 40
  if crtX == 0 and i > 0: echo ""
  if abs(crtX - v) <= 1:
    stdout.write "█"
  else:
    stdout.write ' '
