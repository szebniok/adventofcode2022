import strutils, strscans, sequtils

type
  Stack = seq[char]
  Stacks = array[9, Stack]
  Move = tuple[count: int, `from`: int, to: int]

let input = readFile("day5input.txt").strip(leading = false).splitLines()
var 
  state: Stacks
  moves = newSeq[Move]()

for line in input:
  if line.isEmptyOrWhitespace: continue 
  if line.startsWith(" 1"): continue
  if line.startsWith("move"):
    var m: Move
    discard scanf(line, "move $i from $i to $i", m.count, m.from, m.to)
    moves.add(m)
  else:
    for i in 0..8:
      if line[i*4] == '[':
        state[i].insert(line[i*4+1], 0)

var state1 = state
for (count, `from`, to) in moves:
  for _ in 0..count-1:
    state1[to - 1].add(state1[`from` - 1].pop())

echo state1.mapIt(it[^1]).join()

# 2 star
for (count, `from`, to) in moves:
  var tmp = newSeq[char](count)
  for i in 0..count-1:
    tmp[count - i - 1] = state[`from` - 1].pop()
  for crate in tmp:
    state[to - 1].add(crate)

echo state.mapIt(it[^1]).join()
