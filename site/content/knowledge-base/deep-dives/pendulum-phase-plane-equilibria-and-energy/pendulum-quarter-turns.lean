import Std

/-!
A bounded five-state worksheet for quarter-turn pendulum samples.

The lists below encode the exact sine and cosine values at
`0, π/2, π, 3π/2, 2π` as integer data.  At `κ = 1` and zero angular
velocity, acceleration is negative sine and twice the normalized energy is
`2 * (1 - cosine)`.  Exhausting these five stored cases checks the displayed
finite ledger.  It does not derive the trigonometric values, quantify over
real angles, construct a solution, or establish energy conservation.
-/

def sineQuarterTurns : List Int :=
  [0, 1, 0, -1, 0]

def cosineQuarterTurns : List Int :=
  [1, 0, -1, 0, 1]

def accelerationLedger : List Int :=
  sineQuarterTurns.map fun sineValue ↦ -sineValue

def twiceEnergyLedger : List Int :=
  cosineQuarterTurns.map fun cosineValue ↦ 2 * (1 - cosineValue)

#eval accelerationLedger
#eval twiceEnergyLedger

example : accelerationLedger = [0, -1, 0, 1, 0] := by
  decide

example : twiceEnergyLedger = [0, 2, 4, 2, 0] := by
  decide
