import Std

/-!
A standalone finite worksheet for three parameter regimes.

The exhaustive table checks that the selected finite systems have zero, one,
and two fixed states.  This file defines no topology on its parameter type, so
it does not establish a bifurcation in a real parameter space.
-/

inductive Regime where
  | below
  | critical
  | above
  deriving DecidableEq, Repr

inductive State where
  | left
  | center
  | right
  deriving DecidableEq, Repr

open Regime State

def step : Regime → State → State
  | below, left => center
  | below, center => right
  | below, right => left
  | critical, left => right
  | critical, center => center
  | critical, right => left
  | above, left => left
  | above, center => left
  | above, right => right

def allStates : List State := [left, center, right]

def fixedStates (r : Regime) : List State :=
  allStates.filter fun x => step r x == x

example : fixedStates below = [] := by decide

example : fixedStates critical = [center] := by decide

example : fixedStates above = [left, right] := by decide

example : step critical center = center := by decide

example : step critical (step critical center) = center := by decide

example : step critical (step critical left) = left := by decide

example : step critical left ≠ left := by decide
