import strutils, sequtils, algorithm, math

type 
  Item = uint64
  Operation = object
    addition, old: bool
    number: uint64
  Monkey = object
    items: seq[Item]
    operation: Operation
    divisible: uint64
    throwTrue, throwFalse: int

let 
  input = readFile("day11input.txt").strip().splitLines
  allDivisors = toSeq(countup(3, len(input), 7)).mapIt(input[it][21..^1].parseInt)
  divisor = allDivisors.prod.uint64
var monkeys: seq[Monkey]

for i in countup(0, len(input), 7):
  let monkey = Monkey(
    items: input[i+1][18..^1].split(", ").mapIt(it.parseInt.uint64),
    operation: Operation(
      addition: input[i+2][23] == '+',
      old: input[i+2][25] == 'o',
      number: if input[i+2][25] == 'o': 0 else: input[i+2][25..^1].parseInt
    ),
    divisible: input[i+3][21..^1].parseInt.uint64,
    throwTrue: input[i+4][29..^1].parseInt,
    throwFalse: input[i+5][30..^1].parseInt
  )
  monkeys.add(monkey)

proc calcOp(op: Operation, item: Item, part2: bool = false): Item =
  let rhs = if op.old: item else: op.number
  let newItem = if op.addition: item + rhs else: item * rhs
  if part2: newItem mod divisor else: newItem div 3

proc count(monkeys: var seq[Monkey], iters: int, part2: bool): int =
  var counts = newSeqWith(len(monkeys), 0)
  for _ in 0..<iters:
    for i, monkey in monkeys.mpairs:
      for item in monkey.items:
        counts[i] += 1
        let newItem = calcOp(monkey.operation, item, part2)
        let target = if newItem mod monkey.divisible == 0: monkey.throwTrue else: monkey.throwFalse
        monkeys[target].items.add(newItem)
      monkey.items.setLen(0)
  counts.sorted(SortOrder.Descending)[0..1].prod

var monkeys1 = monkeys
echo count(monkeys1, 20, false)
# 2 star
echo count(monkeys, 10000, true)
