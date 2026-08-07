import Std

/-!
A standalone finite model of semiconjugacy and conjugacy.

The four-direction system factors onto a two-axis system.  The factor forgets
orientation, so it is not injective.  A second encoding identifies the two
axis labels with `Bool` and has an explicit inverse, giving a finite conjugacy.
This file imports only `Std`; it does not formalize topological continuity.
-/

inductive Direction where
  | north | east | south | west
  deriving Repr, DecidableEq

inductive Axis where
  | vertical | horizontal
  deriving Repr, DecidableEq

open Direction Axis

def quarterTurn : Direction → Direction
  | north => east
  | east => south
  | south => west
  | west => north

def toggleAxis : Axis → Axis
  | vertical => horizontal
  | horizontal => vertical

def axisOf : Direction → Axis
  | north => vertical
  | east => horizontal
  | south => vertical
  | west => horizontal

theorem axisOf_quarterTurn (d : Direction) :
    axisOf (quarterTurn d) = toggleAxis (axisOf d) := by
  cases d <;> rfl

def directionOrbit (d : Direction) : Nat → Direction
  | 0 => d
  | n + 1 => quarterTurn (directionOrbit d n)

def axisOrbit (a : Axis) : Nat → Axis
  | 0 => a
  | n + 1 => toggleAxis (axisOrbit a n)

theorem axisOf_directionOrbit (d : Direction) :
    ∀ n, axisOf (directionOrbit d n) = axisOrbit (axisOf d) n := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih =>
      simp only [directionOrbit, axisOrbit, axisOf_quarterTurn, ih]

theorem north_ne_south : north ≠ south := by
  decide

theorem axisOf_not_injective : ¬Function.Injective axisOf := by
  intro h
  exact north_ne_south (h rfl)

def axisCode : Axis → Bool
  | vertical => false
  | horizontal => true

def axisDecode : Bool → Axis
  | false => vertical
  | true => horizontal

def toggleBool : Bool → Bool
  | false => true
  | true => false

theorem axisDecode_axisCode (a : Axis) :
    axisDecode (axisCode a) = a := by
  cases a <;> rfl

theorem axisCode_axisDecode (b : Bool) :
    axisCode (axisDecode b) = b := by
  cases b <;> rfl

theorem axisCode_toggleAxis (a : Axis) :
    axisCode (toggleAxis a) = toggleBool (axisCode a) := by
  cases a <;> rfl

#eval List.range 5 |>.map (directionOrbit north)
#eval List.range 5 |>.map (axisOrbit vertical)
