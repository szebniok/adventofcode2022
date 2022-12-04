import strutils, sequtils, strscans

type Pair = (int, int, int, int)

let input = readFile("day4input.txt").strip().splitLines
var pairs = newSeq[Pair]()

for line in input:
  var a, b, c, d: int
  discard scanf(line, "$i-$i,$i-$i", a, b, c, d)
  pairs.add((a, b, c, d))

echo pairs.countIt(
  (it[0] <= it[2] and it[1] >= it[3]) or
  (it[2] <= it[0] and it[3] >= it[1])
)

# 2 star
echo pairs.countIt(
  (it[1] >= it[2] and it[0] <= it[3]) or
  (it[3] >= it[0] and it[2] <= it[1])
)
