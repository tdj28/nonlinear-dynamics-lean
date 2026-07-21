import NonlinearDynamics.Random.RandomCocycles.SubadditiveCentering

/-!
# Finite phase averaging for nonpositive subadditive processes

This module proves the finite phase-averaging estimate that follows orbit-
majorant centering. For a block length `b`, it first reindexes the sum over all
`b` residue phases of `q` observations along `T^[b]` as one ordinary Birkhoff
sum with `b * q` observations along `T`.

For a shifted-subadditive process, the same phase decomposition produces an
initial gap, `q` complete blocks, and a terminal gap at the exact horizon
`b * q + b + r`. The boundary-retaining theorem uses shifted subadditivity
alone. If the process is nonpositive at every positive horizon, both gaps can
be discarded. Summing the resulting inequality over the phases gives a
zero-block-safe estimate with the factor `(b : ℝ)` on the left; division is
exposed separately and requires `b ≠ 0`.

The extra block in `b * q + b + r` is intentional. A commonly reproduced
phase-averaging display counts `q` blocks of length `b` together with `b + r`
boundary positions but labels the total horizon as `b * q + r`. Those counts
are incompatible. The checked arithmetic here retains the missing block and
reindexes exactly `b * q` sliding-block starts. The remainder parameter `r`
is unrestricted; this module does not assert `r < b`.

The final declarations apply the estimate to the orbit-majorant-centered
process and to the centered cocycle log-positive norm observable. They use
only finite algebra and positive-horizon nonpositivity from their bundled
inputs. The candidate methods still carry the measurable-space and
integrability fields of `IsIntegrableSubadditiveProcessCandidate`, and a
`DiscreteMatrixCocycle` already bundles a measure-preserving base, but these
proofs do not consume those fields. No additional time-zero normalization,
measure-preservation, cocycle-integrability, probability, ergodicity, or
nonempty-index hypothesis is imposed.

Nothing here proves a pointwise or mean Birkhoff theorem, almost-everywhere or
`L¹` convergence, Kingman's theorem, an invariant-integral formula, a maximal
inequality, interval packing, a Lyapunov exponent, or an Oseledets splitting.
-/

open MeasureTheory Finset Function

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ uι

/-- Summing fixed-length block Birkhoff sums over all residue phases gives the
ordinary sliding Birkhoff sum over the corresponding rectangular horizon.

This is a pure finite reindexing identity in an additive commutative monoid.
It uses no measurable structure or dynamical hypothesis on `T`. -/
theorem sum_phase_birkhoffSum
    {M : Type*} [AddCommMonoid M] {Ω : Type uΩ}
    (T : Ω → Ω) (g : Ω → M) (b q : ℕ) (ω : Ω) :
    ∑ s ∈ Finset.range b,
        birkhoffSum (T^[b]) g q (T^[s] ω) =
      birkhoffSum T g (b * q) ω := by
  induction q with
  | zero => simp
  | succ q ih =>
      simp_rw [birkhoffSum_succ]
      rw [Finset.sum_add_distrib, ih, Nat.mul_succ, birkhoffSum_add]
      congr 1
      simp only [birkhoffSum]
      apply Finset.sum_congr rfl
      intro s hs
      congr 1
      rw [← Function.iterate_mul]
      rw [← Function.iterate_add_apply, ← Function.iterate_add_apply]
      congr 1
      omega

private theorem le_blocks_add_remainder_of_add_le
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω)
    (b q r : ℕ) (ω : Ω) :
    X (b * q + r) ω ≤
      birkhoffSum (T^[b]) (X b) q ω + X r ((T^[b])^[q] ω) := by
  induction q generalizing ω with
  | zero => simp
  | succ q ih =>
      calc
        X (b * (q + 1) + r) ω = X (b + (b * q + r)) ω := by
          congr 1
          rw [Nat.mul_succ]
          omega
        _ ≤ X (b * q + r) (T^[b] ω) + X b ω :=
          hadd b (b * q + r) ω
        _ ≤ (birkhoffSum (T^[b]) (X b) q (T^[b] ω) +
              X r ((T^[b])^[q] (T^[b] ω))) + X b ω := by
          simpa only [add_comm] using
            add_le_add_right (ih (T^[b] ω)) (X b ω)
        _ = birkhoffSum (T^[b]) (X b) (q + 1) ω +
              X r ((T^[b])^[q + 1] ω) := by
          rw [birkhoffSum_succ', Function.iterate_succ_apply]
          ring

private theorem le_phase_birkhoffSum_add_boundaries_of_add_le
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω)
    (b q r s : ℕ) (hs : s < b) (ω : Ω) :
    X (b * q + b + r) ω ≤
      (birkhoffSum (T^[b]) (X b) q (T^[s] ω) +
        X (b + r - s) ((T^[b])^[q] (T^[s] ω))) + X s ω := by
  calc
    X (b * q + b + r) ω =
        X (s + (b * q + (b + r - s))) ω := by
      have hsb : s ≤ b + r := by omega
      congr 1
      calc
        b * q + b + r = b * q + (b + r) := by omega
        _ = b * q + (s + (b + r - s)) := by
          rw [Nat.add_sub_of_le hsb]
        _ = s + (b * q + (b + r - s)) := by omega
    _ ≤ X (b * q + (b + r - s)) (T^[s] ω) + X s ω :=
      hadd s (b * q + (b + r - s)) ω
    _ ≤ (birkhoffSum (T^[b]) (X b) q (T^[s] ω) +
          X (b + r - s) ((T^[b])^[q] (T^[s] ω))) + X s ω := by
      linarith [le_blocks_add_remainder_of_add_le hadd b q
        (b + r - s) (T^[s] ω)]

private theorem le_phase_birkhoffSum_of_add_le_nonpos
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    (b q r s : ℕ) (hs : s < b) (ω : Ω) :
    X (b * q + b + r) ω ≤
      birkhoffSum (T^[b]) (X b) q (T^[s] ω) := by
  cases s with
  | zero =>
      calc
        X (b * q + b + r) ω ≤
            birkhoffSum (T^[b]) (X b) q ω +
              X (b + r) ((T^[b])^[q] ω) := by
          simpa only [add_assoc] using
            le_blocks_add_remainder_of_add_le hadd b q (b + r) ω
        _ ≤ birkhoffSum (T^[b]) (X b) q ω := by
          linarith [hnonpos (b + r) (by omega) ((T^[b])^[q] ω)]
  | succ s =>
      calc
        X (b * q + b + r) ω ≤
            (birkhoffSum (T^[b]) (X b) q (T^[s + 1] ω) +
              X (b + r - (s + 1)) ((T^[b])^[q] (T^[s + 1] ω))) +
                X (s + 1) ω :=
          le_phase_birkhoffSum_add_boundaries_of_add_le hadd b q r (s + 1)
            hs ω
        _ ≤ birkhoffSum (T^[b]) (X b) q (T^[s + 1] ω) := by
          linarith [hnonpos (b + r - (s + 1)) (by omega)
              ((T^[b])^[q] (T^[s + 1] ω)),
            hnonpos (s + 1) (by omega) ω]

private theorem natCast_mul_le_birkhoffSum_phase_average_of_add_le_nonpos
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    (b q r : ℕ) (ω : Ω) :
    (b : ℝ) * X (b * q + b + r) ω ≤
      birkhoffSum T (X b) (b * q) ω := by
  have hsum :
      ∑ s ∈ Finset.range b, X (b * q + b + r) ω ≤
        ∑ s ∈ Finset.range b,
          birkhoffSum (T^[b]) (X b) q (T^[s] ω) := by
    apply Finset.sum_le_sum
    intro s hs
    exact le_phase_birkhoffSum_of_add_le_nonpos hadd hnonpos b q r s
      (Finset.mem_range.mp hs) ω
  simpa only [Finset.sum_const, Finset.card_range, nsmul_eq_mul,
    sum_phase_birkhoffSum] using hsum

namespace IsIntegrableSubadditiveProcessCandidate

variable {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
  {μ : Measure Ω} {X : ℕ → Ω → ℝ}

/-- The exact phase-shifted block estimate before its two boundary terms are
discarded. It uses only the candidate's shifted-subadditive inequality; its
integrability field is not consumed. -/
theorem le_phase_birkhoffSum_add_boundaries
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (b q r s : ℕ) (hs : s < b) (ω : Ω) :
    X (b * q + b + r) ω ≤
      (birkhoffSum (T^[b]) (X b) q (T^[s] ω) +
        X (b + r - s) ((T^[b])^[q] (T^[s] ω))) + X s ω :=
  le_phase_birkhoffSum_add_boundaries_of_add_le hX.add_le b q r s hs ω

/-- A phase-shifted block bound with the initial and terminal gaps discarded
using pointwise nonpositivity at positive horizons. No claim about `X 0` is
needed. The exact horizon `b * q + b + r` retains every counted position. -/
theorem le_phase_birkhoffSum
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    (b q r s : ℕ) (hs : s < b) (ω : Ω) :
    X (b * q + b + r) ω ≤
      birkhoffSum (T^[b]) (X b) q (T^[s] ω) :=
  le_phase_birkhoffSum_of_add_le_nonpos hX.add_le hnonpos b q r s hs ω

/-- Averaging the phase-shifted block bounds yields a sliding-block upper
bound. This multiplication form is total at `b = 0`, where it reduces to the
vacuous inequality `0 ≤ 0`. -/
theorem natCast_mul_le_birkhoffSum_phase_average
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    (b q r : ℕ) (ω : Ω) :
    (b : ℝ) * X (b * q + b + r) ω ≤
      birkhoffSum T (X b) (b * q) ω :=
  natCast_mul_le_birkhoffSum_phase_average_of_add_le_nonpos
    hX.add_le hnonpos b q r ω

/-- Division form of the phase-averaged upper bound. Positivity of the real
denominator follows from the explicit hypothesis `b ≠ 0`. -/
theorem le_birkhoffSum_phase_average_div
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    (b q r : ℕ) (hb : b ≠ 0) (ω : Ω) :
    X (b * q + b + r) ω ≤
      birkhoffSum T (X b) (b * q) ω / (b : ℝ) := by
  rw [le_div_iff₀ (by exact_mod_cast Nat.pos_of_ne_zero hb)]
  simpa only [mul_comm] using
    hX.natCast_mul_le_birkhoffSum_phase_average hnonpos b q r ω

/-- Phase averaging for the orbit-majorant-centered process. The method's
candidate wrapper carries measurability and integrability, but the proof uses
only shifted subadditivity and positive-horizon nonpositivity. No additional
time-zero normalization or measure-preservation hypothesis is imposed. -/
theorem centeredProcess_natCast_mul_le_birkhoffSum_phase_average
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (b q r : ℕ) (ω : Ω) :
    (b : ℝ) * centeredProcess T X (b * q + b + r) ω ≤
      birkhoffSum T (centeredProcess T X b) (b * q) ω :=
  natCast_mul_le_birkhoffSum_phase_average_of_add_le_nonpos
    hX.centeredProcess_add_le hX.centeredProcess_nonpos_of_ne_zero b q r ω

/-- Division form of phase averaging for the orbit-majorant-centered process.
It needs only positive block length in addition to the candidate. -/
theorem centeredProcess_le_birkhoffSum_phase_average_div
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (b q r : ℕ) (hb : b ≠ 0) (ω : Ω) :
    centeredProcess T X (b * q + b + r) ω ≤
      birkhoffSum T (centeredProcess T X b) (b * q) ω / (b : ℝ) := by
  rw [le_div_iff₀ (by exact_mod_cast Nat.pos_of_ne_zero hb)]
  simpa only [mul_comm] using
    hX.centeredProcess_natCast_mul_le_birkhoffSum_phase_average b q r ω

end IsIntegrableSubadditiveProcessCandidate

namespace DiscreteMatrixCocycle

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-- Cocycle specialization of centered phase averaging. It is a pointwise
finite inequality whose proof uses only the cocycle's finite algebra. The
cocycle input already bundles a measure-preserving base, but no separate
generator-integrability, probability, ergodicity, or nonempty-index hypothesis
is imposed. -/
theorem centeredLogPlusNormObservable_natCast_mul_le_birkhoffSum_phase_average
    (C : DiscreteMatrixCocycle (ι := ι) μ) (b q r : ℕ) (ω : Ω) :
    (b : ℝ) * C.centeredLogPlusNormObservable (b * q + b + r) ω ≤
      birkhoffSum C.base (C.centeredLogPlusNormObservable b) (b * q) ω :=
  natCast_mul_le_birkhoffSum_phase_average_of_add_le_nonpos
    C.centeredLogPlusNormObservable_add_le
      (fun n _hn ↦ C.centeredLogPlusNormObservable_nonpos n) b q r ω

end DiscreteMatrixCocycle

section EdgeCaseSmokes

variable {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
  {μ : Measure Ω} {X : ℕ → Ω → ℝ}

example (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    (q r : ℕ) (ω : Ω) :
    (0 : ℝ) * X r ω ≤ birkhoffSum T (X 0) 0 ω := by
  simpa only [Nat.zero_mul, Nat.zero_add, Nat.cast_zero] using
    hX.natCast_mul_le_birkhoffSum_phase_average hnonpos 0 q r ω

example (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0) (b r : ℕ) (ω : Ω) :
    (b : ℝ) * X (b + r) ω ≤ 0 := by
  simpa using
    hX.natCast_mul_le_birkhoffSum_phase_average hnonpos b 0 r ω

example (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0) (q r : ℕ) (ω : Ω) :
    X (q + 1 + r) ω ≤ birkhoffSum T (X 1) q ω := by
  simpa using hX.le_birkhoffSum_phase_average_div hnonpos 1 q r
    one_ne_zero ω

example {M : Type*} [AddCommMonoid M] (T : Ω → Ω) (g : Ω → M)
    (q : ℕ) (ω : Ω) :
    ∑ s ∈ Finset.range 1,
        birkhoffSum (T^[1]) g q (T^[s] ω) = birkhoffSum T g q ω := by
  rw [sum_phase_birkhoffSum]
  simp

example {μ : Measure Ω}
    (C : DiscreteMatrixCocycle (ι := Empty) μ) (b q r : ℕ) (ω : Ω) :
    (b : ℝ) * C.centeredLogPlusNormObservable (b * q + b + r) ω ≤
      birkhoffSum C.base (C.centeredLogPlusNormObservable b) (b * q) ω :=
  C.centeredLogPlusNormObservable_natCast_mul_le_birkhoffSum_phase_average
    b q r ω

private def positiveAtZeroProcess (n : ℕ) (_u : Unit) : ℝ :=
  if n = 0 then 1 else -(n : ℝ)

private theorem positiveAtZeroProcess_add_le (m n : ℕ) (u : Unit) :
    positiveAtZeroProcess (m + n) u ≤
      positiveAtZeroProcess n ((id : Unit → Unit)^[m] u) +
        positiveAtZeroProcess m u := by
  by_cases hm : m = 0
  · subst m
    simp [positiveAtZeroProcess]
  by_cases hn : n = 0
  · subst n
    simp [positiveAtZeroProcess]
  simp [positiveAtZeroProcess, hm, hn]

private theorem positiveAtZeroCandidate :
    IsIntegrableSubadditiveProcessCandidate (id : Unit → Unit)
      (0 : Measure Unit) positiveAtZeroProcess where
  integrable := by simp
  add_le := positiveAtZeroProcess_add_le

example : positiveAtZeroProcess 0 () = 1 := by
  simp [positiveAtZeroProcess]

example :
    (2 : ℝ) * positiveAtZeroProcess (2 * 3 + 2 + 1) () ≤
      birkhoffSum id (positiveAtZeroProcess 2) (2 * 3) () := by
  apply positiveAtZeroCandidate.natCast_mul_le_birkhoffSum_phase_average
  intro n hn u
  simp [positiveAtZeroProcess, hn]

end EdgeCaseSmokes

end NonlinearDynamics.Random.RandomCocycles
