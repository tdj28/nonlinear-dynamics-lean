import Std

/-!
A bounded integer worksheet for the normalized Lorenz field

  x' = y - x
  y' = x * (3 - z) - y
  z' = x * y - 2 * z.

This file checks five stored rows and a stored symmetry relation.  It does not
quantify over real states, construct solutions, or prove an attractor theorem.
-/

abbrev State3 := Int × Int × Int

def normalizedLorenzVector (state : State3) : State3 :=
  (state.2.1 - state.1,
    state.1 * (3 - state.2.2) - state.2.1,
    state.1 * state.2.1 - 2 * state.2.2)

def signFlip (state : State3) : State3 :=
  (-state.1, -state.2.1, state.2.2)

def storedStates : List State3 :=
  [(0, 0, 0), (2, 2, 2), (-2, -2, 2), (1, 2, 3), (-1, -2, 3)]

def storedVectors : List State3 :=
  storedStates.map normalizedLorenzVector

#eval storedVectors

example : storedVectors =
    [(0, 0, 0), (0, 0, 0), (0, 0, 0), (1, -2, -4), (-1, 2, -4)] := by
  decide

example : signFlip (signFlip (1, 2, 3)) = (1, 2, 3) := by
  decide

example : normalizedLorenzVector (signFlip (1, 2, 3)) =
    signFlip (normalizedLorenzVector (1, 2, 3)) := by
  decide
