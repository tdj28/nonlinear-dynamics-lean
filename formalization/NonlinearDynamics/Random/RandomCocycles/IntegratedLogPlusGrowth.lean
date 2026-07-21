import NonlinearDynamics.Random.RandomCocycles.LogPlusIntegrability
import Mathlib.Analysis.Subadditive

/-!
# Integrated finite-horizon log-positive cocycle growth

This module constructs the deterministic subadditive sequence obtained by
integrating the finite-time log-positive norm envelope. Without a probability
measure the integral is not an expectation and is not measure-normalized. The
sequence uses no ergodicity, and its Fekete limit is not an almost-sure limit
or a Lyapunov exponent.

Mathlib's Bochner integral is totalized, so the bare integrated definition has
a value even without integrability. The orbit-sum evaluation, finite-horizon
upper bound, subadditivity theorem, rate definition, and convergence theorem
below assume one-step log-positive integrability explicitly. The normalized
value at time zero is zero by Lean's division-by-zero convention; Fekete's
limit is determined by positive indices.
-/

open Matrix MeasureTheory Set Filter Topology
open scoped Matrix.Norms.Operator Real

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle

universe uΩ uι

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-- The integral of the finite-time log-positive norm envelope. -/
def integratedLogPlusNorm
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : ℝ :=
  ∫ ω, C.logPlusNormObservable k ω ∂μ

/-- The integrated time-zero envelope vanishes. -/
@[simp] theorem integratedLogPlusNorm_zero
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.integratedLogPlusNorm 0 = 0 := by
  simp [integratedLogPlusNorm]

/-- The integrated envelope is nonnegative. -/
theorem integratedLogPlusNorm_nonneg
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    0 ≤ C.integratedLogPlusNorm k := by
  apply integral_nonneg
  exact C.logPlusNormObservable_nonneg k

/-- Pulling any finite-horizon log-positive envelope back by a base iterate
preserves its integral. -/
theorem integral_logPlusNormObservable_at_base_iterate_eq
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k j : ℕ) :
    (∫ ω, C.logPlusNormObservable k (C.base^[j] ω) ∂μ) =
      C.integratedLogPlusNorm k := by
  have hpres := C.base_iterate_preserving j
  have hstrong : AEStronglyMeasurable (C.logPlusNormObservable k)
      (Measure.map (C.base^[j]) μ) :=
    (C.measurable_logPlusNormObservable k).aestronglyMeasurable
  calc
    (∫ ω, C.logPlusNormObservable k (C.base^[j] ω) ∂μ) =
        ∫ x, C.logPlusNormObservable k x ∂Measure.map (C.base^[j]) μ :=
      (integral_map hpres.measurable.aemeasurable hstrong).symm
    _ = C.integratedLogPlusNorm k := by rw [hpres.map_eq]; rfl

/-- The integral of the finite orbit sum is horizon times the one-step
integral. -/
theorem HasIntegrableGeneratorLogPlus.integral_orbitLogPlusSum_eq
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) :
    (∫ ω, C.orbitLogPlusSum k ω ∂μ) =
      k * C.integratedLogPlusNorm 1 := by
  rw [show C.orbitLogPlusSum k = fun ω ↦ ∑ j ∈ Finset.range k,
      C.logPlusNormObservable 1 (C.base^[j] ω) from rfl]
  rw [integral_finsetSum (Finset.range k) fun j _ ↦
    hC.integrable_at_base_iterate j]
  simp_rw [C.integral_logPlusNormObservable_at_base_iterate_eq 1]
  simp [integratedLogPlusNorm]

/-- Every integrated finite-horizon envelope is bounded by horizon times the
one-step integral. -/
theorem HasIntegrableGeneratorLogPlus.integratedLogPlusNorm_le_nat_mul
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) :
    C.integratedLogPlusNorm k ≤ k * C.integratedLogPlusNorm 1 := by
  calc
    C.integratedLogPlusNorm k ≤ ∫ ω, C.orbitLogPlusSum k ω ∂μ := by
      apply integral_mono
      · exact hC.integrable_logPlusNormObservable k
      · exact hC.integrable_orbitLogPlusSum k
      · exact C.logPlusNormObservable_le_orbitLogPlusSum k
    _ = k * C.integratedLogPlusNorm 1 := hC.integral_orbitLogPlusSum_eq k

/-- The integrated log-positive envelope is subadditive in the horizon. -/
theorem HasIntegrableGeneratorLogPlus.integratedLogPlusNorm_add_le
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (m k : ℕ) :
    C.integratedLogPlusNorm (m + k) ≤
      C.integratedLogPlusNorm m + C.integratedLogPlusNorm k := by
  have hk : Integrable (C.logPlusNormObservable k) μ :=
    hC.integrable_logPlusNormObservable k
  have hm : Integrable (C.logPlusNormObservable m) μ :=
    hC.integrable_logPlusNormObservable m
  have hmk : Integrable (C.logPlusNormObservable (m + k)) μ :=
    hC.integrable_logPlusNormObservable (m + k)
  have hkShift :
      Integrable (fun ω ↦ C.logPlusNormObservable k (C.base^[m] ω)) μ := by
    change Integrable (C.logPlusNormObservable k ∘ C.base^[m]) μ
    exact (C.base_iterate_preserving m).integrable_comp_of_integrable hk
  have hIntegralShift :
      (∫ ω, C.logPlusNormObservable k (C.base^[m] ω) ∂μ) =
        ∫ ω, C.logPlusNormObservable k ω ∂μ := by
    simpa [integratedLogPlusNorm] using
      C.integral_logPlusNormObservable_at_base_iterate_eq k m
  calc
    C.integratedLogPlusNorm (m + k) ≤
        ∫ ω, (C.logPlusNormObservable k (C.base^[m] ω) +
          C.logPlusNormObservable m ω) ∂μ := by
      apply integral_mono
      · exact hmk
      · exact hkShift.add hm
      · exact C.logPlusNormObservable_add_le m k
    _ = (∫ ω, C.logPlusNormObservable k (C.base^[m] ω) ∂μ) +
        C.integratedLogPlusNorm m := by
      rw [integral_add hkShift hm]
      rfl
    _ = C.integratedLogPlusNorm k + C.integratedLogPlusNorm m := by
      rw [hIntegralShift]
      rfl
    _ = C.integratedLogPlusNorm m + C.integratedLogPlusNorm k := add_comm _ _

/-- The integrated log-positive envelope is a subadditive real sequence. -/
theorem HasIntegrableGeneratorLogPlus.subadditive_integratedLogPlusNorm
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) :
    Subadditive C.integratedLogPlusNorm :=
  hC.integratedLogPlusNorm_add_le

/-- The normalized integrated log-positive envelope. -/
def normalizedIntegratedLogPlusNorm
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : ℝ :=
  C.integratedLogPlusNorm k / k

/-- The normalized integrated envelope is nonnegative. -/
theorem normalizedIntegratedLogPlusNorm_nonneg
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    0 ≤ C.normalizedIntegratedLogPlusNorm k := by
  exact div_nonneg (C.integratedLogPlusNorm_nonneg k) (Nat.cast_nonneg k)

/-- The normalized integrated sequence is bounded below. -/
theorem bddBelow_normalizedIntegratedLogPlusNorm
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    BddBelow (Set.range C.normalizedIntegratedLogPlusNorm) := by
  refine ⟨0, ?_⟩
  rintro _ ⟨k, rfl⟩
  exact C.normalizedIntegratedLogPlusNorm_nonneg k

/-- The Fekete limit of normalized integrated log-positive growth. -/
def integratedLogPlusGrowthRate
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (hC : C.HasIntegrableGeneratorLogPlus) : ℝ :=
  hC.subadditive_integratedLogPlusNorm.lim

/-- The normalized integrated log-positive envelope converges to its Fekete
limit. This is a deterministic limit of integrals, not an almost-sure limit. -/
theorem HasIntegrableGeneratorLogPlus.tendsto_normalizedIntegratedLogPlusNorm
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) :
    Tendsto C.normalizedIntegratedLogPlusNorm atTop
      (𝓝 (C.integratedLogPlusGrowthRate hC)) := by
  exact hC.subadditive_integratedLogPlusNorm.tendsto_lim
    C.bddBelow_normalizedIntegratedLogPlusNorm

end NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle
