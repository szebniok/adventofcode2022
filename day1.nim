import strutils, algorithm, math

let input = readFile "day1input.txt"
var
  maxKcal = -1
  current = 0

for line in input.splitLines:
  if line == "": 
    maxKcal = max(maxKcal, current)
    current = 0
  else:
    current += parseInt(line)

echo maxKcal

# 2 star
var kcals = newSeq[int]()

for line in input.splitLines:
  if line == "": 
    kcals.add(current)
    current = 0
  else:
    current += parseInt(line)

echo kcals.sorted[^3..^1].sum
