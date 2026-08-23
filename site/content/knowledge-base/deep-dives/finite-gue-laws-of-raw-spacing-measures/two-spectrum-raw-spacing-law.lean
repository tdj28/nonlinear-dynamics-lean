import Std

def rawGaps : List Int → List Int
  | a :: b :: rest => (a - b) :: rawGaps (b :: rest)
  | _ => []

def toySpectra : List (List Int) :=
  [[2, 2, -1], [3, 1, 1]]

def toyGapSamples : List (List Int) :=
  toySpectra.map rawGaps

#eval toyGapSamples
#eval (rawGaps []).length
#eval (rawGaps [7]).length
#eval (rawGaps [5, 1]).length

example : toyGapSamples = [[0, 3], [2, 0]] := by decide
example : (rawGaps []).length = 0 := by decide
example : (rawGaps [7]).length = 0 := by decide
example : (rawGaps [5, 1]).length = 1 := by decide
