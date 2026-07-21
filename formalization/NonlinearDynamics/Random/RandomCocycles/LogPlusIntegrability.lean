import NonlinearDynamics.Random.RandomCocycles.NormObservables
import Mathlib.Analysis.SpecialFunctions.Log.PosLog

/-!
# Log-positive cocycle growth and finite-horizon integrability

This module defines the real-valued positive logarithm of the finite-time
cocycle norm, its orbit-sum majorant, and propagation of an explicit one-step
integrability hypothesis to every finite horizon.

The positive logarithm is only an integrability envelope. It records expansion
above norm one but erases contraction and singular collapse, so it is not the
extended log-norm observable and is not a Lyapunov exponent.

This remains a finite-horizon layer. It proves no probability normalization,
ergodicity, normalized growth limit, subadditive ergodic theorem, Lyapunov
exponent, Oseledets splitting, inverse-cocycle estimate, or random-Jacobian
representation.
-/

open Matrix MeasureTheory
open scoped Matrix.Norms.Operator Real

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle

universe uΩ uι

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-- The real positive logarithm of the finite-time cocycle norm. -/
def logPlusNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → ℝ :=
  fun ω ↦ log⁺ (C.normObservable k ω)

/-- Log-positive norm growth is pointwise nonnegative. -/
theorem logPlusNormObservable_nonneg
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) (ω : Ω) :
    0 ≤ C.logPlusNormObservable k ω :=
  Real.posLog_nonneg

/-- The time-zero log-positive norm vanishes in every finite dimension,
including the empty one. -/
@[simp] theorem logPlusNormObservable_zero
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.logPlusNormObservable 0 = fun _ ↦ 0 := by
  cases isEmpty_or_nonempty ι with
  | inl hι =>
      letI := hι
      funext ω
      change log⁺ (C.normObservable 0 ω) = 0
      rw [congrFun (C.normObservable_eq_zero_of_isEmpty 0) ω]
      exact Real.posLog_zero
  | inr hι =>
      letI := hι
      funext ω
      change log⁺ (C.normObservable 0 ω) = 0
      rw [congrFun C.normObservable_zero ω]
      exact Real.posLog_one

/-- At one step, log-positive norm growth is the positive logarithm of the
generator norm. -/
@[simp] theorem logPlusNormObservable_one
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.logPlusNormObservable 1 = fun ω ↦ log⁺ ‖C.generator ω‖ := by
  funext ω
  simp [logPlusNormObservable]

/-- Every finite-time log-positive norm observable is measurable. -/
theorem measurable_logPlusNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    Measurable (C.logPlusNormObservable k) :=
  Real.continuous_posLog.measurable.comp (C.measurable_normObservable k)

/-- Log-positive finite-time growth is subadditive across the cocycle split. -/
theorem logPlusNormObservable_add_le
    (C : DiscreteMatrixCocycle (ι := ι) μ) (m k : ℕ) (ω : Ω) :
    C.logPlusNormObservable (m + k) ω ≤
      C.logPlusNormObservable k (C.base^[m] ω) +
        C.logPlusNormObservable m ω := by
  calc
    log⁺ (C.normObservable (m + k) ω) ≤
        log⁺ (C.normObservable k (C.base^[m] ω) * C.normObservable m ω) :=
      Real.posLog_le_posLog (norm_nonneg _) (C.normObservable_add_le m k ω)
    _ ≤ log⁺ (C.normObservable k (C.base^[m] ω)) +
        log⁺ (C.normObservable m ω) := Real.posLog_mul

/-- Empty matrix dimension has zero log-positive norm growth at every time. -/
@[simp] theorem logPlusNormObservable_eq_zero_of_isEmpty [IsEmpty ι]
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    C.logPlusNormObservable k = fun _ ↦ 0 := by
  funext ω
  simp [logPlusNormObservable]

/-- The cumulative one-step log-positive norm observed along the base orbit. -/
def orbitLogPlusSum
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → ℝ :=
  fun ω ↦ ∑ j ∈ Finset.range k,
    C.logPlusNormObservable 1 (C.base^[j] ω)

/-- The empty orbit sum vanishes. -/
@[simp] theorem orbitLogPlusSum_zero
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.orbitLogPlusSum 0 = fun _ ↦ 0 := by
  funext ω
  simp only [orbitLogPlusSum, Finset.range_zero, Finset.sum_empty]

/-- Extending the horizon appends the newest one-step log-positive term. -/
@[simp] theorem orbitLogPlusSum_succ
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    C.orbitLogPlusSum (k + 1) = fun ω ↦
      C.orbitLogPlusSum k ω +
        C.logPlusNormObservable 1 (C.base^[k] ω) := by
  funext ω
  simp [orbitLogPlusSum, Finset.sum_range_succ]

/-- Every finite orbit sum is measurable. -/
theorem measurable_orbitLogPlusSum
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    Measurable (C.orbitLogPlusSum k) := by
  unfold orbitLogPlusSum
  exact Finset.measurable_sum (Finset.range k) fun j _ ↦
    (C.measurable_logPlusNormObservable 1).comp
      (C.base_preserving.measurable.iterate j)

/-- Finite-time log-positive norm growth is bounded by the sum of the
one-step log-positive norms along the base orbit. -/
theorem logPlusNormObservable_le_orbitLogPlusSum
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) (ω : Ω) :
    C.logPlusNormObservable k ω ≤ C.orbitLogPlusSum k ω := by
  induction k with
  | zero => simp
  | succ k ih =>
      calc
        C.logPlusNormObservable (k + 1) ω ≤
            C.logPlusNormObservable 1 (C.base^[k] ω) +
              C.logPlusNormObservable k ω :=
          C.logPlusNormObservable_add_le k 1 ω
        _ ≤ C.logPlusNormObservable 1 (C.base^[k] ω) +
              C.orbitLogPlusSum k ω :=
          add_le_add_right ih (C.logPlusNormObservable 1 (C.base^[k] ω))
        _ = C.orbitLogPlusSum (k + 1) ω := by
          rw [C.orbitLogPlusSum_succ]
          exact add_comm _ _

/-- The one-step log-positive norm has finite integral with respect to the
base measure. This is an explicit hypothesis, not a consequence of measure
preservation. -/
def HasIntegrableGeneratorLogPlus
    (C : DiscreteMatrixCocycle (ι := ι) μ) : Prop :=
  Integrable (C.logPlusNormObservable 1) μ

/-- A generator log-positive integrability hypothesis is preserved when the
observable is pulled back by any natural base iterate. -/
theorem HasIntegrableGeneratorLogPlus.integrable_at_base_iterate
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (j : ℕ) :
    Integrable (fun ω ↦ C.logPlusNormObservable 1 (C.base^[j] ω)) μ := by
  change Integrable (C.logPlusNormObservable 1 ∘ C.base^[j]) μ
  exact (C.base_iterate_preserving j).integrable_comp_of_integrable hC

/-- Under the one-step hypothesis, every finite orbit sum is integrable. -/
theorem HasIntegrableGeneratorLogPlus.integrable_orbitLogPlusSum
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) :
    Integrable (C.orbitLogPlusSum k) μ := by
  unfold orbitLogPlusSum
  exact integrable_finsetSum (Finset.range k) fun j _ ↦
    hC.integrable_at_base_iterate j

/-- A one-step log-positive integrability hypothesis propagates to every
finite-time log-positive cocycle norm. -/
theorem HasIntegrableGeneratorLogPlus.integrable_logPlusNormObservable
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) :
    Integrable (C.logPlusNormObservable k) μ := by
  apply (hC.integrable_orbitLogPlusSum k).mono'
    (C.measurable_logPlusNormObservable k).aestronglyMeasurable
  filter_upwards with ω
  rw [Real.norm_eq_abs, abs_of_nonneg (C.logPlusNormObservable_nonneg k ω)]
  exact C.logPlusNormObservable_le_orbitLogPlusSum k ω

end NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle
