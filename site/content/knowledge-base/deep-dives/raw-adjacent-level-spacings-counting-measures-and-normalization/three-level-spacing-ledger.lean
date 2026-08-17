import Std

/-!
A bounded integer-list worksheet for the repeated three-level spectrum in the
paired Deep Dive. It checks stored finite data only. It does not compute
Mathlib's noncomputable Hermitian eigenvalue ordering or construct measures.
-/

def adjacentDecreasingGaps : List Int → List Int
  | [] => []
  | [_] => []
  | a :: b :: rest => (a - b) :: adjacentDecreasingGaps (b :: rest)

def levels : List Int := [2, 2, -1]
def gaps : List Int := adjacentDecreasingGaps levels

def gapCount : Nat := gaps.length
def meanGapNumerator : Int := gaps.sum
def meanGapDenominator : Nat := gaps.length

#eval levels
#eval gaps
#eval gapCount
#eval meanGapNumerator
#eval meanGapDenominator

example : gaps = [0, 3] := by decide
example : gapCount = 2 := by decide
example : meanGapNumerator = 3 := by decide
example : meanGapDenominator = 2 := by decide

example : adjacentDecreasingGaps [] = [] := by decide
example : adjacentDecreasingGaps [7] = [] := by decide
example : adjacentDecreasingGaps [7, 2] = [5] := by decide

example : gaps.all (fun d => 0 ≤ d) = true := by decide
