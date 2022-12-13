import strutils, sequtils, strscans, algorithm

type 
  ElementKind = enum ekValue, ekList
  Element = ref object 
    case kind: ElementKind
    of ekValue: value: int 
    of ekList: elems: seq[Element]

let 
  input = readFile("day13input.txt").strip()
  encodedPairs = input.split("\n\n").mapIt(it.split("\n")).mapIt((it[0], it[1]))

func parseList(s: string): (Element, string) =
  if s[0].isDigit:
    var
      d: int
      rest: string
    discard scanf(s, "$i$*$.", d, rest)
    (Element(kind: ekValue, value: d), rest)
  else:
    var
      elems: seq[Element]
      stringToParse = s[1..^1]
    while stringToParse.len > 0:
      if stringToParse[0] == ']': 
        stringToParse = stringToParse[1..^1]
        break
      if stringToParse[0] == ',': stringToParse = stringToParse[1..^1]
      let (elem, rest) = parseList(stringToParse)
      elems.add(elem)
      stringToParse = rest
    (Element(kind: ekList, elems: elems), stringToParse)

let pairs: seq[(Element, Element)] = encodedPairs.mapIt((parseList(it[0])[0], parseList(it[1])[0]))

func compare(a, b: Element): int =
  if a.kind == ekValue and b.kind == ekValue: a.value.cmp(b.value)
  elif a.kind == ekValue and b.kind == ekList:
    compare(Element(kind: ekList, elems: @[a]), b)
  elif a.kind == ekList and b.kind == ekValue:
    compare(a, Element(kind: ekList, elems: @[b]))
  else: 
    let pairs = zip(a.elems, b.elems)
    for (a, b) in pairs:
      let cmpResult = compare(a, b)
      if cmpResult != 0: return cmpResult
    a.elems.len.cmp(b.elems.len)

var result: int
for i, (a, b) in pairs:
  if compare(a, b) == -1: result += i + 1  
echo result

# 2 star
let
  elem2 = Element(kind: ekList, elems: @[Element(kind: ekList, elems: @[Element(kind: ekValue, value: 2)])])
  elem6 = Element(kind: ekList, elems: @[Element(kind: ekList, elems: @[Element(kind: ekValue, value: 6)])])
var flat: seq[Element]

for (a, b) in pairs:
  flat.add(a)
  flat.add(b)
flat.add(elem2)
flat.add(elem6)

flat.sort(cmp = compare)
echo (flat.find(elem2) + 1) * (flat.find(elem6) + 1)

