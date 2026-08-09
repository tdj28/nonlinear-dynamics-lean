import Std

/-!
A bounded five-point worksheet for the parameter-two tent map.

The state `k : Fin 5` represents the grid point `k / 4`.  The natural number
`scaledTentTwo k` is four times the corresponding tent-map output.  Exhausting
this table establishes the displayed finite list.  It does not establish a
theorem about every real state.
-/

def scaledTentTwo (k : Fin 5) : Nat :=
  min (2 * k.val) (2 * (4 - k.val))

def fivePointTentTable : List Nat :=
  (List.range 5).map fun k => min (2 * k) (2 * (4 - k))

#eval fivePointTentTable

example : fivePointTentTable = [0, 2, 4, 2, 0] := by
  decide
