import strutils

let input = readFile "day2input.txt"
var score = 0

for line in input.splitLines:
  if line == "": continue
  case line:
    of "A X": score += 3
    of "A Y": score += 6
    of "A Z": score += 0
    of "B X": score += 0
    of "B Y": score += 3
    of "B Z": score += 6
    of "C X": score += 6
    of "C Y": score += 0
    of "C Z": score += 3
  score += int(line[2]) - int('X') + 1

echo score

# 2 star
score = 0
for line in input.splitLines:
  if line == "": continue
  case line:
    of "A X": score += 3
    of "A Y": score += 1
    of "A Z": score += 2
    of "B X": score += 1
    of "B Y": score += 2
    of "B Z": score += 3
    of "C X": score += 2
    of "C Y": score += 3
    of "C Z": score += 1
  score += (int(line[2]) - int('X')) * 3

echo score
