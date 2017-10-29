import types

type MutationState = enum
  msInit, msGen, msReduce

type Example*[T] = ref object
  next*: iterator(): T
  state: MutationState

proc reverse*(ex: var Example) =
  case ex.state
  of msGen:
    ex.state = msReduce
  of msReduce:
    ex.state = msGen
  else: discard

proc some*[T](): Example[T] =
  var example = Example[T]()
  let next = iterator(): T =
    var
      count: int
      cap = mutCap[T]()
      v: T

    while true:
      case example.state
      of msInit:
        v = T(0)
        example.state = msGen
      else:
        v = getVal(cap)

      if count == 20:
        case example.state
        of msGen:
          growCap(cap)
        of msReduce:
          reduceCap(cap)
        else: discard
        count = 0

      count += 1
      yield v

  example.state = msInit
  example.next = next
  return example
