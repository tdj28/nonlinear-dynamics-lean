import Std

/-!
A bounded five-point worksheet for the quadratic core of the logistic map.

The state `k : Fin 5` represents the grid point `k / 4`.  The integer
quantity `k * (4 - k)` is four times the image under the parameter-four
logistic map.  Exhausting this table illustrates the parabola and its
midpoint maximum.  It does not establish a theorem about every real state.
-/

def scaledLogisticFour (k : Fin 5) : Nat :=
  k.val * (4 - k.val)

def fivePointTable : List Nat :=
  (List.range 5).map fun k => k * (4 - k)

#eval fivePointTable

example : fivePointTable = [0, 3, 4, 3, 0] := by
  decide
