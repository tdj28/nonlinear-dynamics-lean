import Std

inductive State where
  | low
  | middle
  | high
  deriving DecidableEq, Repr

open State

def step : State → State
  | low => low
  | middle => low
  | high => middle

def orbit (x : State) : Nat → State
  | 0 => x
  | n + 1 => step (orbit x n)

theorem orbit_low (n : Nat) : orbit low n = low := by
  induction n with
  | zero => rfl
  | succ n ih => simp [orbit, ih, step]

theorem orbit_after_two (x : State) :
    ∀ n, orbit x (n + 2) = low
  | 0 => by cases x <;> rfl
  | n + 1 => by
      change step (orbit x (n + 2)) = low
      rw [orbit_after_two x n]
      rfl

def reachesLow (x : State) : Prop :=
  ∃ N, ∀ n, N ≤ n → orbit x n = low

theorem every_state_reachesLow (x : State) : reachesLow x := by
  refine ⟨2, fun n hn => ?_⟩
  obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_le hn
  simpa [Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using
    orbit_after_two x k

#eval (List.range 5).map (orbit high)
