import unittest
import ny

forAll:
  given(x, some[int]())
  given(y, some[int]())
do:
  echo "x: ", x, " y: ", y
  check (x + y) - y == x
