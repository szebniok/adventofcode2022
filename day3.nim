import strutils, tables, sequtils

let input = readFile("day3input.txt").splitLines[0..^2]
var result = 0

for line in input:
  let first = line[0..int(line.len/2)-1]
  for c in line[int(line.len/2)..^1]:
    if first.contains(c):
      result += (case c:
        of 'a'..'z': int(c) - int('a') + 1
        else: int(c) - int('A') + 27)
      break
echo result

# 2 star
result = 0

for group in input.distribute(int(len(input) / 3)):
  var count = initTable[char, int]()
  for i, line in group:
    for c in line:
      count[c] = count.getOrDefault(c, 0).or(1 shl i)
  for c, v in count:
    if v == 0b111:
      result += (case c:
        of 'a'..'z': int(c) - int('a') + 1
        else: int(c) - int('A') + 27)
echo result
