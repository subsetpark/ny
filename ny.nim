import math
import unittest

from examples import Example, some

const maxExamples = 200

template forAll*(declarations: untyped, body: untyped) =
  var reloadProcs {.inject.} = newSeq[proc()]()
  declarations
  for x in 1..maxExamples:
    for reloadProc in reloadProcs:
      reloadProc()
    body

template given*(varName: untyped, varType: Example): typed =
  var
    captured = varType
    `varName` {.inject.} = varType.next()
  proc `reload varName`() =
    `varName` = captured.next()
  reloadProcs.add(`reload varName`)

export some
