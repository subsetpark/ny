import math
import unittest

from examples import Example, some

const maxExamples = 200

template forAll*(testName: string, declarations: untyped, body: untyped) =
  test testName:
    var
      reloadProcs {.inject.} = newSeq[proc()]()
      currentValProcs {.inject.} = newSeq[proc()]()
    declarations
    for x in 1..maxExamples:
      for reloadProc in reloadProcs:
        reloadProc()
      try:
        body
      except:
        echo "falsified example."
        for currentValProc in currentValProcs:
          currentValProc()
        raise

template given*(varName: untyped, varType: Example): typed =
  var
    captured = varType
    `varName` {.inject.} = captured.next()

  proc `reload varName`() =
    `varName` = captured.next()
  reloadProcs.add(`reload varName`)

  proc `currentVal varName`() =
    echo `varName`.astToStr, " current value: ", varName
  currentValProcs.add(`currentVal varName`)

export some
