import sets

let input = readFile("day6input.txt")[0..^2]
var occ: HashSet[char]

for i in 3..len(input)-1:
  for j in -3..0:
    occ.incl(input[i+j])
  if len(occ) == 4:
    echo i+1
    break
  occ.clear()

# 2 star
occ.clear()
for i in 13..len(input)-1:
  for j in -13..0:
    occ.incl(input[i+j])
  if len(occ) == 14:
    echo i+1
    break
  occ.clear()
