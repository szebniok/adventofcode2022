import strutils, strscans, sequtils, math

type
  File = ref object
    size: int
  Directory = ref object
    parent: Directory
    dirs: seq[Directory]
    files: seq[File]

let input = readFile("day7input.txt").strip().splitLines
var 
  root = Directory()
  current = root
  newPath: string
  newSize: int

for line in input:
  if scanf(line, "$$ cd $*$.", newPath):
    if newPath == "..":
      current = current.parent
    else:
      let newDir = Directory(parent: current)
      current.dirs.add(newDir)
      current = newDir
  elif line == "$ ls" or line.startsWith("dir"):
    continue
  elif scanf(line, "$i $w", newSize, newPath):
    let file = File(size: newSize)
    current.files.add(file)

func getDirSize(dir: Directory): int =
  let 
    selfSize = dir.files.mapIt(it.size).sum
    dirsSize = dir.dirs.map(getDirSize).sum
  selfSize + dirsSize

func part1(dir: Directory): int =
  let 
    dirsSize = dir.dirs.map(part1).sum
    size = getDirSize(dir)
  dirsSize + (if size < 100_000: size else: 0)
echo part1(root)

# 2 star
let target = 30000000 - (70000000 - getDirSize(root))
proc part2(dir: Directory): int =
  if getDirSize(dir) < target:
    0
  else:
    let nonZero = dir.dirs.map(part2).filterIt(it > 0)
    if nonZero.len > 0: nonZero.min else: getDirSize(dir)
echo part2(root)
