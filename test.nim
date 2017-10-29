import algorithm
import unittest
import ny

forAll "sample test":
  given(x, some[int]())
  given(y, some[int]())
do:
  check (x + y) - y == x

forAll "division test":
  given(x, some[int]())
  given(y, some[int]())
do:
  check (x * y) / y == x.float

forAll "reverse is reversible":
  given(xs, some[seq[int]]())
do:
  check xs == xs.reversed(system.cmp).reversed(system.cmp)
