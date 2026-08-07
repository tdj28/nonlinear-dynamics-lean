import Std

/-!
A standalone countdown model for Lyapunov-style descent.

This file uses only natural numbers and `Std`.  It illustrates positivity,
weak and strict one-step decrease, and an identity-map boundary.  It does not
formalize metric stability or the project's Mathlib-backed direct method.
-/

/-- One countdown update subtracts one, with zero kept fixed. -/
def countdownStep (x : Nat) : Nat := x - 1

/-- The closed-form state after `n` countdown updates. -/
def countdownOrbit (x n : Nat) : Nat := x - n

/-- The countdown state itself is the scalar energy. -/
def countdownEnergy (x : Nat) : Nat := x

theorem countdownEnergy_nonnegative (x : Nat) :
    0 ≤ countdownEnergy x :=
  Nat.zero_le x

theorem countdownEnergy_zero_iff (x : Nat) :
    countdownEnergy x = 0 ↔ x = 0 := by
  rfl

theorem countdownEnergy_positive_of_ne_zero {x : Nat} (hx : x ≠ 0) :
    0 < countdownEnergy x := by
  exact Nat.pos_of_ne_zero hx

theorem countdownEnergy_step_le (x : Nat) :
    countdownEnergy (countdownStep x) ≤ countdownEnergy x := by
  exact Nat.sub_le x 1

theorem countdownEnergy_step_lt_of_ne_zero {x : Nat} (hx : x ≠ 0) :
    countdownEnergy (countdownStep x) < countdownEnergy x := by
  cases x with
  | zero => exact (hx rfl).elim
  | succ n => simp [countdownEnergy, countdownStep]

theorem countdownOrbit_reaches_zero (x : Nat) :
    countdownOrbit x x = 0 := by
  simp [countdownOrbit]

/-- The identity update supplies the weak-descent boundary. -/
def identityStep (x : Nat) : Nat := x

def identityOrbit (x _n : Nat) : Nat := x

theorem identityEnergy_step_le (x : Nat) :
    countdownEnergy (identityStep x) ≤ countdownEnergy x := by
  simp [countdownEnergy, identityStep]

theorem identityOrbit_one_ne_zero (n : Nat) :
    identityOrbit 1 n ≠ 0 := by
  simp [identityOrbit]

#eval List.range 6 |>.map (countdownOrbit 5)
