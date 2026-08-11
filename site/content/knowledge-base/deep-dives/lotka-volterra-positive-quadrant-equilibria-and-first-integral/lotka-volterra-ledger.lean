import Std

/-!
A bounded worksheet for the normalized Lotka-Volterra field.

For the stored integer states, the vector field is
`(x * (1 - y), y * (x - 1))`.  A second ledger checks the corresponding
division-cleared first-integral cancellation
`(x - 1) * (1 - y) + (y - 1) * (x - 1) = 0`.

Exhausting these five stored cases checks the displayed finite tables.  It
does not define the real logarithm, take a derivative, quantify over every
state or parameter, construct a solution, establish positive invariance, or
prove a periodic-orbit theorem.
-/

def normalizedStates : List (Int × Int) :=
  [(0, 0), (1, 1), (2, 1), (1, 2), (2, 3)]

def normalizedLotkaVolterraVector (state : Int × Int) : Int × Int :=
  (state.1 * (1 - state.2), state.2 * (state.1 - 1))

def normalizedVectorLedger : List (Int × Int) :=
  normalizedStates.map normalizedLotkaVolterraVector

def clearedFirstIntegralCancellation (state : Int × Int) : Int :=
  (state.1 - 1) * (1 - state.2) +
    (state.2 - 1) * (state.1 - 1)

def cancellationLedger : List Int :=
  normalizedStates.map clearedFirstIntegralCancellation

#eval normalizedVectorLedger
#eval cancellationLedger

example : normalizedVectorLedger =
    [(0, 0), (0, 0), (0, 1), (-1, 0), (-4, 3)] := by
  decide

example : cancellationLedger = [0, 0, 0, 0, 0] := by
  decide
