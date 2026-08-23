import NonlinearDynamics.QuantumChaos.FiniteSystems

/-!
# Raw finite spectral statistics

This module defines the first deterministic spectral statistic for the
quantum-chaos branch. The project's Hermitian eigenvalues are ordered
decreasingly, so the raw adjacent spacing at rank `i` is
`lambda i - lambda (i + 1)`. Its index type is `Fin n.pred`: dimensions zero
and one therefore have no gap slots, while an `n x n` Hamiltonian has exactly
`n - 1` slots.

The raw spacing counting measure retains every adjacent slot, including a
zero spacing at a repeated eigenvalue. Scaling by the reciprocal number of
available slots gives a zero-aware empirical measure. It is zero in
dimensions zero and one and is a probability measure from dimension two
onward; a bundled `ProbabilityMeasure` is exposed only in the latter case.

This normalization fixes total mass only. No unfolding, unit-mean rescaling,
ensemble average, GUE specialization, simplicity, level repulsion,
universality, asymptotic law, or quantum-chaos criterion is defined or
inferred here.
-/

open MeasureTheory
open scoped ENNReal

namespace NonlinearDynamics.QuantumChaos

open NonlinearDynamics.Random

noncomputable section

/-- The left spectral rank of an adjacent gap. Its value is `i`. -/
private def rawSpacingLeftIndex {n : ℕ} (i : Fin n.pred) : Fin n :=
  ⟨i.1, Nat.lt_of_succ_lt (Nat.succ_lt_of_lt_pred i.isLt)⟩

/-- The right spectral rank of an adjacent gap. Its value is `i + 1`. -/
private def rawSpacingRightIndex {n : ℕ} (i : Fin n.pred) : Fin n :=
  ⟨i.1 + 1, Nat.succ_lt_of_lt_pred i.isLt⟩

private theorem rawSpacingLeftIndex_le_rightIndex {n : ℕ}
    (i : Fin n.pred) :
    rawSpacingLeftIndex i ≤ rawSpacingRightIndex i := by
  exact Fin.mk_le_mk.mpr (Nat.le_succ i.1)

/-- The raw spacing between adjacent decreasingly ordered energy levels.

For `lambda_0 >= ... >= lambda_(n-1)`, slot `i : Fin n.pred` stores
`lambda_i - lambda_(i+1)`. Repeated adjacent eigenvalues therefore contribute
zero rather than being removed. -/
def rawLevelSpacing {n : ℕ} (H : FiniteHamiltonian n)
    (i : Fin n.pred) : ℝ :=
  RandomMatrix.orderedHermitianEigenvalues H (rawSpacingLeftIndex i) -
    RandomMatrix.orderedHermitianEigenvalues H (rawSpacingRightIndex i)

/-- Every raw level spacing is nonnegative because the reused spectrum is
ordered decreasingly. This does not assert strict positivity or simplicity. -/
theorem rawLevelSpacing_nonneg {n : ℕ} (H : FiniteHamiltonian n)
    (i : Fin n.pred) : 0 ≤ rawLevelSpacing H i := by
  exact sub_nonneg.mpr
    (RandomMatrix.orderedHermitianEigenvalues_antitone H
      (rawSpacingLeftIndex_le_rightIndex i))

/-- Unitary congruence preserves each raw adjacent spacing. -/
@[simp] theorem rawLevelSpacing_hermitianCongruence {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ) (H : FiniteHamiltonian n)
    (i : Fin n.pred) :
    rawLevelSpacing (RandomMatrix.hermitianCongruence U H) i =
      rawLevelSpacing H i := by
  simp [rawLevelSpacing,
    RandomMatrix.orderedHermitianEigenvalues_hermitianCongruence U H]

/-- A fixed raw spacing coordinate is 2-Lipschitz in the intrinsic Frobenius
metric. The constant is the sum of the two 1-Lipschitz eigenvalue bounds. -/
theorem lipschitzWith_rawLevelSpacing {n : ℕ} (i : Fin n.pred) :
    LipschitzWith 2 (fun H : FiniteHamiltonian n => rawLevelSpacing H i) := by
  simpa only [rawLevelSpacing, one_add_one_eq_two] using
    ((RandomMatrix.lipschitzWith_orderedHermitianEigenvalues_apply
      (rawSpacingLeftIndex i)).sub
      (RandomMatrix.lipschitzWith_orderedHermitianEigenvalues_apply
        (rawSpacingRightIndex i)))

/-- A fixed raw spacing coordinate varies continuously with the Hamiltonian. -/
theorem continuous_rawLevelSpacing {n : ℕ} (i : Fin n.pred) :
    Continuous (fun H : FiniteHamiltonian n => rawLevelSpacing H i) := by
  exact (RandomMatrix.continuous_orderedHermitianEigenvalues_apply
    (rawSpacingLeftIndex i)).sub
    (RandomMatrix.continuous_orderedHermitianEigenvalues_apply
      (rawSpacingRightIndex i))

/-- The whole finite raw-spacing vector is continuous in the product
topology. -/
theorem continuous_rawLevelSpacings {n : ℕ} :
    Continuous (@rawLevelSpacing n) :=
  continuous_pi continuous_rawLevelSpacing

/-- A fixed raw spacing coordinate is Borel-measurable. -/
theorem measurable_rawLevelSpacing {n : ℕ} (i : Fin n.pred) :
    Measurable (fun H : FiniteHamiltonian n => rawLevelSpacing H i) :=
  (continuous_rawLevelSpacing i).measurable

/-- The whole finite raw-spacing vector is Borel-measurable. -/
theorem measurable_rawLevelSpacings {n : ℕ} :
    Measurable (@rawLevelSpacing n) :=
  continuous_rawLevelSpacings.measurable

/-- The finite counting measure with one Dirac mass for every adjacent gap.
Zero gaps and multiplicities are retained. -/
def rawSpacingCountingMeasure {n : ℕ}
    (H : FiniteHamiltonian n) : Measure ℝ :=
  ∑ i, Measure.dirac (rawLevelSpacing H i)

/-- Unitary congruence preserves the raw-spacing counting measure. -/
@[simp] theorem rawSpacingCountingMeasure_hermitianCongruence {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ) (H : FiniteHamiltonian n) :
    rawSpacingCountingMeasure (RandomMatrix.hermitianCongruence U H) =
      rawSpacingCountingMeasure H := by
  simp [rawSpacingCountingMeasure]

/-- A zero-dimensional Hamiltonian has no adjacent spectral gaps. -/
@[simp] theorem rawSpacingCountingMeasure_zero
    (H : FiniteHamiltonian 0) : rawSpacingCountingMeasure H = 0 := by
  simp [rawSpacingCountingMeasure]

/-- A one-dimensional Hamiltonian has no adjacent spectral gaps. -/
@[simp] theorem rawSpacingCountingMeasure_one
    (H : FiniteHamiltonian 1) : rawSpacingCountingMeasure H = 0 := by
  simp [rawSpacingCountingMeasure]

/-- The total mass of the raw-spacing counting measure is the number of
available adjacent slots, `n.pred`. -/
@[simp] theorem rawSpacingCountingMeasure_univ {n : ℕ}
    (H : FiniteHamiltonian n) :
    rawSpacingCountingMeasure H Set.univ = n.pred := by
  simp [rawSpacingCountingMeasure]

/-- The raw-spacing counting measure is measurable as a map into the Giry
measurable space of measures. -/
theorem measurable_rawSpacingCountingMeasure {n : ℕ} :
    Measurable (@rawSpacingCountingMeasure n) := by
  unfold rawSpacingCountingMeasure
  exact Finset.measurable_fun_sum Finset.univ fun i _ =>
    Measure.measurable_dirac.comp (measurable_rawLevelSpacing i)

/-- The zero-aware empirical raw-spacing measure. It divides the counting
measure by the number of available gaps, not by the matrix dimension. The
result is zero when `n.pred = 0`. -/
def empiricalRawSpacingMeasure {n : ℕ}
    (H : FiniteHamiltonian n) : Measure ℝ :=
  (n.pred : ℝ≥0∞)⁻¹ • rawSpacingCountingMeasure H

/-- Unitary congruence preserves the empirical raw-spacing measure. -/
@[simp] theorem empiricalRawSpacingMeasure_hermitianCongruence {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ) (H : FiniteHamiltonian n) :
    empiricalRawSpacingMeasure (RandomMatrix.hermitianCongruence U H) =
      empiricalRawSpacingMeasure H := by
  simp [empiricalRawSpacingMeasure]

/-- The zero-dimensional empirical raw-spacing measure is zero. -/
@[simp] theorem empiricalRawSpacingMeasure_zero
    (H : FiniteHamiltonian 0) : empiricalRawSpacingMeasure H = 0 := by
  rw [empiricalRawSpacingMeasure, rawSpacingCountingMeasure_zero H, smul_zero]

/-- The one-dimensional empirical raw-spacing measure is zero. -/
@[simp] theorem empiricalRawSpacingMeasure_one
    (H : FiniteHamiltonian 1) : empiricalRawSpacingMeasure H = 0 := by
  rw [empiricalRawSpacingMeasure, rawSpacingCountingMeasure_one H, smul_zero]

/-- In every dimension, the empirical raw-spacing measure is either zero or
a probability measure. The zero cases are dimensions zero and one. -/
theorem empiricalRawSpacingMeasure_isZeroOrProbability {n : ℕ}
    (H : FiniteHamiltonian n) :
    IsZeroOrProbabilityMeasure (empiricalRawSpacingMeasure H) := by
  have hmass : (n.pred : ℝ≥0∞) =
      rawSpacingCountingMeasure H Set.univ := by
    simp
  rw [empiricalRawSpacingMeasure, hmass]
  infer_instance

/-- From dimension two onward, the empirical raw-spacing measure is a
probability measure because at least one adjacent slot exists. -/
theorem empiricalRawSpacingMeasure_succ_succ_isProbability (n : ℕ)
    (H : FiniteHamiltonian (n + 2)) :
    IsProbabilityMeasure (empiricalRawSpacingMeasure H) := by
  rw [isProbabilityMeasure_iff]
  rw [empiricalRawSpacingMeasure, Measure.smul_apply,
    rawSpacingCountingMeasure_univ]
  exact ENNReal.inv_mul_cancel (by simp) (by simp)

/-- The empirical raw-spacing measure bundled as a genuine probability
measure in dimension `n + 2`. -/
def empiricalRawSpacingProbability (n : ℕ)
    (H : FiniteHamiltonian (n + 2)) : ProbabilityMeasure ℝ :=
  ⟨empiricalRawSpacingMeasure H,
    empiricalRawSpacingMeasure_succ_succ_isProbability n H⟩

private theorem measurable_const_smul_rawSpacingMeasure (c : ℝ≥0∞) :
    Measurable (fun μ : Measure ℝ => c • μ) := by
  refine Measure.measurable_of_measurable_coe _ fun s hs => ?_
  simp only [Measure.smul_apply, smul_eq_mul]
  exact _root_.measurable_const.mul (Measure.measurable_coe hs)

/-- The zero-aware empirical raw-spacing measure is Giry-measurable. -/
theorem measurable_empiricalRawSpacingMeasure {n : ℕ} :
    Measurable (@empiricalRawSpacingMeasure n) := by
  exact (measurable_const_smul_rawSpacingMeasure (n.pred : ℝ≥0∞)⁻¹).comp
    measurable_rawSpacingCountingMeasure

/-- In dimension `n + 2`, the empirical raw-spacing probability wrapper is
measurable. -/
theorem measurable_empiricalRawSpacingProbability (n : ℕ) :
    Measurable (empiricalRawSpacingProbability n) := by
  exact (measurable_empiricalRawSpacingMeasure (n := n + 2)).subtype_mk

#print axioms rawLevelSpacing_nonneg
#print axioms lipschitzWith_rawLevelSpacing
#print axioms rawSpacingCountingMeasure_univ
#print axioms empiricalRawSpacingMeasure_isZeroOrProbability
#print axioms empiricalRawSpacingMeasure_succ_succ_isProbability
#print axioms measurable_empiricalRawSpacingProbability

end

end NonlinearDynamics.QuantumChaos
