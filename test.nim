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
