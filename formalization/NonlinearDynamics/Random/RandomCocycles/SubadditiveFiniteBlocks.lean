import NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase
import Mathlib.Dynamics.BirkhoffSum.Basic

/-!
# Finite block estimates for subadditive cocycle processes

This module develops the finite algebra that precedes any subadditive ergodic
argument. A horizon is decomposed into equal blocks and a short remainder.
Repeated shifted subadditivity then bounds the process by a finite Birkhoff sum
of the block observable together with one remainder term. Both remainder
orientations are provided, as are exact quotient-and-remainder forms.

The time-zero boundary remains explicit. Subadditivity alone forces `X 0` to be
pointwise nonnegative, but the estimate for zero exact blocks requires the
additional normalization `X 0 = 0`. A nonzero number of exact blocks, and both
remainder estimates, need no such hypothesis. For a fixed block length `b`,
finite block Birkhoff sums are integrable when the block map `T^[b]` preserves
the measure; preservation of the one-step map is sufficient but not required.

The final declarations specialize the exact-block estimate, the
remainder-first quotient estimate, and finite-sum integrability to the cocycle
log-positive norm process. The two pointwise bounds use only the cocycle's
checked subadditivity and time-zero identity, not its integrability hypothesis.
Only the finite-sum integrability specialization needs integrable one-step
growth. These results require neither probability nor ergodicity and remain
valid for an empty matrix index. Nothing here proves almost-everywhere
convergence, a pointwise ergodic theorem, Kingman's theorem, a Lyapunov
exponent, or an Oseledets splitting.
-/

open MeasureTheory

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ uι

private theorem le_birkhoffSum_blocks_add_remainder_of_add_le
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m k ω, X (m + k) ω ≤ X k (T^[m] ω) + X m ω)
    (b q r : ℕ) (ω : Ω) :
    X (b * q + r) ω ≤
      birkhoffSum (T^[b]) (X b) q ω +
        X r ((T^[b])^[q] ω) := by
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

private theorem le_birkhoffSum_blocks_succ_of_add_le
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m k ω, X (m + k) ω ≤ X k (T^[m] ω) + X m ω)
    (b q : ℕ) (ω : Ω) :
    X (b * (q + 1)) ω ≤
      birkhoffSum (T^[b]) (X b) (q + 1) ω := by
  simpa only [Nat.mul_succ, birkhoffSum_succ] using
    le_birkhoffSum_blocks_add_remainder_of_add_le hadd b q b ω

private theorem le_remainder_add_birkhoffSum_blocks_of_add_le
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m k ω, X (m + k) ω ≤ X k (T^[m] ω) + X m ω)
    (r b q : ℕ) (ω : Ω) :
    X (r + b * q) ω ≤
      X r ω + birkhoffSum (T^[b]) (X b) q (T^[r] ω) := by
  cases q with
  | zero => simp
  | succ q =>
      calc
        X (r + b * (q + 1)) ω ≤
            X (b * (q + 1)) (T^[r] ω) + X r ω :=
          hadd r (b * (q + 1)) ω
        _ ≤ birkhoffSum (T^[b]) (X b) (q + 1) (T^[r] ω) +
              X r ω := by
          simpa only [add_comm] using add_le_add_right
            (le_birkhoffSum_blocks_succ_of_add_le hadd b q (T^[r] ω))
            (X r ω)
        _ = X r ω +
              birkhoffSum (T^[b]) (X b) (q + 1) (T^[r] ω) := add_comm _ _

namespace IsIntegrableSubadditiveProcessCandidate

variable {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
  {μ : Measure Ω} {X : ℕ → Ω → ℝ}

/-- Subadditivity forces the time-zero value to be pointwise nonnegative. -/
theorem zero_nonneg (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (ω : Ω) :
    0 ≤ X 0 ω := by
  have h := hX.add_le 0 0 ω
  simp only [zero_add, Function.iterate_zero_apply] at h
  linarith

/-- For a subadditive candidate, pointwise nonpositivity at time zero is
equivalent to exact vanishing at time zero. -/
theorem zero_eq_zero_iff_nonpos
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X) :
    X 0 = 0 ↔ ∀ ω, X 0 ω ≤ 0 := by
  constructor
  · intro hX0 ω
    rw [hX0]
    exact le_rfl
  · intro hX0
    funext ω
    exact le_antisymm (hX0 ω) (hX.zero_nonneg ω)

/-- A horizon made of `q` blocks of length `b` followed by a remainder `r`
is bounded by the Birkhoff sum of the block observable plus the terminal
remainder. No condition on `X 0` is needed. -/
theorem le_birkhoffSum_blocks_add_remainder
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (b q r : ℕ) (ω : Ω) :
    X (b * q + r) ω ≤
      birkhoffSum (T^[b]) (X b) q ω +
        X r ((T^[b])^[q] ω) :=
  le_birkhoffSum_blocks_add_remainder_of_add_le hX.add_le b q r ω

/-- Exact quotient-and-remainder specialization. It is valid even at `b = 0`,
where it degenerates to the reflexive bound `X n ≤ X n`. -/
theorem le_birkhoffSum_div_add_mod
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (b n : ℕ) (ω : Ω) :
    X n ω ≤
      birkhoffSum (T^[b]) (X b) (n / b) ω +
        X (n % b) ((T^[b])^[n / b] ω) := by
  simpa only [Nat.div_add_mod] using
    hX.le_birkhoffSum_blocks_add_remainder b (n / b) (n % b) ω

/-- A nonzero number of exact blocks needs no time-zero normalization
hypothesis. -/
theorem le_birkhoffSum_blocks_of_ne_zero
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (b q : ℕ) (hq : q ≠ 0) (ω : Ω) :
    X (b * q) ω ≤ birkhoffSum (T^[b]) (X b) q ω := by
  obtain ⟨q, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hq
  exact le_birkhoffSum_blocks_succ_of_add_le hX.add_le b q ω

/-- Exact vanishing at time zero extends the exact-block estimate uniformly
to the zero block count. -/
theorem le_birkhoffSum_blocks_of_zero
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hX0 : X 0 = 0) (b q : ℕ) (ω : Ω) :
    X (b * q) ω ≤ birkhoffSum (T^[b]) (X b) q ω := by
  cases q with
  | zero => simp [hX0]
  | succ q => exact le_birkhoffSum_blocks_succ_of_add_le hX.add_le b q ω

/-- The remainder may be placed first without a time-zero normalization
hypothesis. This keeps the finite remainder observable at the original sample
and, when complete blocks are present, starts them after that remainder. -/
theorem le_remainder_add_birkhoffSum_blocks
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (r b q : ℕ) (ω : Ω) :
    X (r + b * q) ω ≤
      X r ω + birkhoffSum (T^[b]) (X b) q (T^[r] ω) :=
  le_remainder_add_birkhoffSum_blocks_of_add_le hX.add_le r b q ω

/-- Quotient-and-remainder form with the finite remainder at the original
sample. At positive block length, `Nat.mod_lt` additionally gives
`n % b < b`; that strict bound is not needed for this inequality. -/
theorem le_mod_add_birkhoffSum_div
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (b n : ℕ) (ω : Ω) :
    X n ω ≤ X (n % b) ω +
      birkhoffSum (T^[b]) (X b) (n / b) (T^[n % b] ω) := by
  simpa only [Nat.mod_add_div] using
    hX.le_remainder_add_birkhoffSum_blocks (n % b) b (n / b) ω

/-- If the fixed block map preserves the measure, every finite Birkhoff sum
of that block observable is integrable. Preservation of `T` itself,
probability normalization, and ergodicity are not required. -/
theorem integrable_birkhoffSum_blocks
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (b q : ℕ) (hTb : MeasurePreserving (T^[b]) μ μ) :
    Integrable (birkhoffSum (T^[b]) (X b) q) μ := by
  change Integrable
    (fun ω ↦ ∑ j ∈ Finset.range q, X b ((T^[b])^[j] ω)) μ
  apply integrable_finsetSum
  intro j _hj
  change Integrable (X b ∘ (T^[b])^[j]) μ
  exact (hTb.iterate j).integrable_comp_of_integrable (hX.integrable b)

end IsIntegrableSubadditiveProcessCandidate

namespace DiscreteMatrixCocycle

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-- Cocycle log-positive growth at an exact block multiple is bounded by the
block Birkhoff sum, uniformly including zero blocks. No integrability
hypothesis is needed for this pointwise inequality. -/
theorem logPlusNormObservable_nat_mul_le_birkhoffSum
    (C : DiscreteMatrixCocycle (ι := ι) μ) (b q : ℕ) (ω : Ω) :
    C.logPlusNormObservable (b * q) ω ≤
      birkhoffSum (C.base^[b]) (C.logPlusNormObservable b) q ω := by
  cases q with
  | zero => simp
  | succ q =>
      exact le_birkhoffSum_blocks_succ_of_add_le
        C.logPlusNormObservable_add_le b q ω

/-- Quotient-and-remainder cocycle bound with the short remainder evaluated at
the original sample and complete blocks begun after it. No integrability
hypothesis is needed for this pointwise inequality. -/
theorem logPlusNormObservable_le_mod_add_blockBirkhoffSum
    (C : DiscreteMatrixCocycle (ι := ι) μ) (b n : ℕ) (ω : Ω) :
    C.logPlusNormObservable n ω ≤
      C.logPlusNormObservable (n % b) ω +
        birkhoffSum (C.base^[b]) (C.logPlusNormObservable b) (n / b)
          (C.base^[n % b] ω) := by
  simpa only [Nat.mod_add_div] using
    le_remainder_add_birkhoffSum_blocks_of_add_le
      C.logPlusNormObservable_add_le (n % b) b (n / b) ω

/-- Every cocycle block Birkhoff sum is integrable. This finite-time result
uses the cocycle's stored measure preservation, not probability or ergodicity. -/
theorem HasIntegrableGeneratorLogPlus.integrable_blockBirkhoffSum
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (b q : ℕ) :
    Integrable
      (birkhoffSum (C.base^[b]) (C.logPlusNormObservable b) q) μ :=
  hC.isIntegrableSubadditiveProcessCandidate.integrable_birkhoffSum_blocks
    b q (C.base_preserving.iterate b)

end DiscreteMatrixCocycle

end NonlinearDynamics.Random.RandomCocycles
