import Std

def translationOrbit (c x : Int) : Nat → Int
  | 0 => x
  | n + 1 => translationOrbit c x n + c

theorem translationOrbit_gap (c x y : Int) :
    ∀ n, translationOrbit c y n - translationOrbit c x n = y - x := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih =>
      simp only [translationOrbit]
      omega

example : translationOrbit 2 4 3 = 10 := by decide
example : translationOrbit 2 41 3 - translationOrbit 2 40 3 = 1 := by decide
