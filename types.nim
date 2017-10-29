import random
import math

proc mutCap*[int](): int = 128

proc growCap*[int](cap: var int) =
  if cap > int.high.float.sqrt.int:
    cap = int.high
  else:
    cap = cap * cap

proc reduceCap*[int](cap: var int) =
  let root = cap.float.sqrt.int
  if cap > root:
    cap = root

proc getVal*[int](cap: int): int = random(cap)
