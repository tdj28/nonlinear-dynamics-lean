import Std

/-!
A standalone finite-prefix worksheet for the one-sided binary shift.

The stream type is infinite, as a genuinely finite metric space is discrete
and cannot be sensitive.  Every witness below is nevertheless an exact finite
construction: preserve a requested prefix, flip the next bit, and shift that
bit to the head.  This file formalizes the prefix combinatorics, not the
Cantor-space metric or product topology used by the full mathematical model.
-/

abbrev BitStream := Nat → Bool

def shiftN (n : Nat) (x : BitStream) : BitStream :=
  fun i => x (n + i)

def PrefixEq (k : Nat) (x y : BitStream) : Prop :=
  ∀ i, i < k → x i = y i

def flipAt (k : Nat) (x : BitStream) : BitStream :=
  fun i => if i = k then !x i else x i

theorem flipAt_prefixEq (x : BitStream) (k : Nat) :
    PrefixEq k x (flipAt k x) := by
  intro i hi
  simp [flipAt, Nat.ne_of_lt hi]

theorem shift_prefix_sensitive (x : BitStream) (k : Nat) :
    ∃ y, PrefixEq k x y ∧ shiftN k x 0 ≠ shiftN k y 0 := by
  refine ⟨flipAt k x, flipAt_prefixEq x k, ?_⟩
  simp [shiftN, flipAt]

/- Selecting one separation time before the neighborhood depth is known is
too strong.  A prefix of length `n + 1` fixes the bit that the `n`-fold shift
would move to the head. -/
theorem no_neighborhood_independent_separation_time :
    ¬∃ n, ∀ x k, ∃ y,
      PrefixEq k x y ∧ shiftN n x 0 ≠ shiftN n y 0 := by
  rintro ⟨n, h⟩
  let x : BitStream := fun _ => false
  rcases h x (n + 1) with ⟨y, hy, hsep⟩
  apply hsep
  simpa [shiftN] using hy n (Nat.lt_succ_self n)

def alternating : BitStream := fun i => i % 2 == 0

example : PrefixEq 6 alternating (flipAt 6 alternating) :=
  flipAt_prefixEq alternating 6

example : shiftN 6 alternating 0 ≠ shiftN 6 (flipAt 6 alternating) 0 := by
  simp [shiftN, flipAt]
