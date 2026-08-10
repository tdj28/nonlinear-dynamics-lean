import Std

/-!
A bounded five-state worksheet for the normalized logistic vector field.

At growth rate `r = 2`, write the state as `x = k / 4`.  Multiplying
`2 * x * (1 - x)` by eight gives the integer expression `k * (4 - k)`.
Exhausting `k = 0, 1, 2, 3, 4` checks the displayed finite table.  It does
not establish a theorem about every real state or solve the ODE.
-/

def scaledLogisticODEValue (k : Nat) : Nat :=
  k * (4 - k)

def scaledLogisticODETable : List Nat :=
  (List.range 5).map scaledLogisticODEValue

#eval scaledLogisticODETable

example : scaledLogisticODETable = [0, 3, 4, 3, 0] := by
  decide
