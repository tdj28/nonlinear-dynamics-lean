import NonlinearDynamics.Random.RandomCocycles.Discrete
import Mathlib.Analysis.SpecialFunctions.Log.ENNRealLogExp

/-!
# Finite-time norm observables for one-sided matrix cocycles

This module equips a generator-presented discrete complex matrix cocycle with
its finite-time maximum absolute row-sum norm and with the extended-real
logarithm of that norm. The extended logarithm is deliberately formed as
`ENNReal.log ‖A‖ₑ`: a zero matrix therefore has value `⊥`, rather than the
artificial value `Real.log 0 = 0`.

All definitions, measurability results, and cocycle inequalities allow an
empty matrix index type. Positive dimension is needed only to normalize the
time-zero identity to norm one, and hence to extended log norm zero.

This remains a finite-time layer. It proves no integrability, normalized
growth, Lyapunov exponent, subadditive ergodic limit, Oseledets splitting,
probability normalization, ergodicity, or random-Jacobian representation.
-/

open Matrix MeasureTheory
open scoped Matrix.Norms.Operator

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle

universe uΩ uι

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-- The finite-time maximum absolute row-sum norm of a cocycle value. -/
def normObservable (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → ℝ :=
  fun ω ↦ ‖C.value k ω‖

/-- The selected norm is exactly the maximum absolute row-sum norm. -/
theorem normObservable_eq_rowSumSup
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) (ω : Ω) :
    C.normObservable k ω =
      ↑((Finset.univ : Finset ι).sup fun i : ι ↦ ∑ j : ι, ‖C.value k ω i j‖₊) :=
  Matrix.linfty_opNorm_def (C.value k ω)

/-- In positive dimension, the time-zero identity has norm one. -/
@[simp] theorem normObservable_zero [Nonempty ι]
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.normObservable 0 = fun _ ↦ 1 := by
  funext ω
  simp [normObservable]

/-- The one-step norm observable is the norm of the generator. -/
@[simp] theorem normObservable_one
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.normObservable 1 = fun ω ↦ ‖C.generator ω‖ := by
  funext ω
  simp [normObservable]

/-- Finite-time cocycle norms are submultiplicative across every time split. -/
theorem normObservable_add_le
    (C : DiscreteMatrixCocycle (ι := ι) μ) (m k : ℕ) (ω : Ω) :
    C.normObservable (m + k) ω ≤
      C.normObservable k (C.base^[m] ω) * C.normObservable m ω := by
  rw [normObservable, C.value_add]
  exact norm_mul_le _ _

/-- Every finite-time maximum absolute row-sum norm observable is measurable. -/
theorem measurable_normObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    Measurable (C.normObservable k) := by
  have hvalue : Measurable (C.value k) := C.measurable_value k
  have hrow : ∀ i : ι,
      Measurable fun ω ↦ ∑ j : ι, ‖C.value k ω i j‖₊ := by
    intro i
    exact Finset.measurable_sum Finset.univ fun j _ ↦
      (RandomMatrix.measurable_entry hvalue i j).nnnorm
  have hsup : ∀ s : Finset ι,
      Measurable fun ω ↦ s.sup fun i ↦ ∑ j : ι, ‖C.value k ω i j‖₊ := by
    intro s
    classical
    induction s using Finset.induction_on with
    | empty => simp
    | @insert i s hi ih =>
        simpa [Finset.sup_insert, hi] using (hrow i).max ih
  unfold normObservable
  convert (hsup Finset.univ).coe_nnreal_real using 1
  funext ω
  exact Matrix.linfty_opNorm_def (C.value k ω)

/-- The extended-real logarithm of the finite-time operator norm.

The route through `ENNReal.log` records a zero norm as `⊥` exactly.
-/
def logNormObservable (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → EReal :=
  fun ω ↦ ENNReal.log ‖C.value k ω‖ₑ

/-- The extended log norm is bottom exactly when the cocycle value is zero. -/
@[simp] theorem logNormObservable_eq_bot_iff
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) (ω : Ω) :
    C.logNormObservable k ω = ⊥ ↔ C.value k ω = 0 := by
  simp [logNormObservable]

/-- In positive dimension, the time-zero extended log norm is zero. -/
@[simp] theorem logNormObservable_zero [Nonempty ι]
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.logNormObservable 0 = fun _ ↦ 0 := by
  funext ω
  simp [logNormObservable]

/-- The one-step extended log norm is the generator's extended log norm. -/
@[simp] theorem logNormObservable_one
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.logNormObservable 1 = fun ω ↦ ENNReal.log ‖C.generator ω‖ₑ := by
  funext ω
  simp [logNormObservable]

/-- Every finite-time extended log-norm observable is measurable. -/
theorem measurable_logNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    Measurable (C.logNormObservable k) := by
  have hnorm : Measurable (C.normObservable k) := C.measurable_normObservable k
  unfold logNormObservable
  unfold normObservable at hnorm
  simpa only [ofReal_norm] using hnorm.ennreal_ofReal.ennreal_log

/-- Extended log norms are subadditive across every cocycle time split. -/
theorem logNormObservable_add_le
    (C : DiscreteMatrixCocycle (ι := ι) μ) (m k : ℕ) (ω : Ω) :
    C.logNormObservable (m + k) ω ≤
      C.logNormObservable k (C.base^[m] ω) + C.logNormObservable m ω := by
  rw [logNormObservable, C.value_add]
  calc
    ENNReal.log ‖C.value k (C.base^[m] ω) * C.value m ω‖ₑ ≤
        ENNReal.log (‖C.value k (C.base^[m] ω)‖ₑ * ‖C.value m ω‖ₑ) := by
      apply ENNReal.log_monotone
      simpa only [enorm_eq_nnnorm, ← ENNReal.coe_mul, ENNReal.coe_le_coe] using
        (nnnorm_mul_le (C.value k (C.base^[m] ω)) (C.value m ω))
    _ = ENNReal.log ‖C.value k (C.base^[m] ω)‖ₑ +
        ENNReal.log ‖C.value m ω‖ₑ := ENNReal.log_mul_add

/-- Every finite-dimensional empty matrix has zero finite-time norm. -/
@[simp] theorem normObservable_eq_zero_of_isEmpty [IsEmpty ι]
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    C.normObservable k = fun _ ↦ 0 := by
  funext ω
  rw [normObservable]
  have hzero : C.value k ω = 0 := by
    ext i
    exact isEmptyElim i
  simp [hzero]

/-- Every finite-dimensional empty matrix has bottom extended log norm. -/
@[simp] theorem logNormObservable_eq_bot_of_isEmpty [IsEmpty ι]
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    C.logNormObservable k = fun _ ↦ ⊥ := by
  funext ω
  exact (C.logNormObservable_eq_bot_iff k ω).2 <| by
    ext i
    exact isEmptyElim i

end NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle
