import NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.Probability.Distributions.Geometric

/-!
# Real logarithmic cocycle growth and integrable negative tails

RMT-33 proves almost-everywhere convergence for the nonnegative
log-positive norm envelope.  This module begins the signed layer.  It defines
the total real observable

`ω ↦ Real.log ‖C.value n ω‖`

and records separately the two hypotheses that make it analytically useful:
pointwise invertibility keeps finite-time norms away from zero, while an
integrable inverse-generator log-positive envelope controls contraction.

The distinction is real.  Lean follows the convention `Real.log 0 = 0`, but
the zero-faithful extended logarithm from `NormObservables` is bottom at a zero
matrix.  In an empty matrix dimension the unique matrix is even a unit while
its selected row-sup norm is zero.  Consequently the bridge from the extended
logarithm to the real logarithm keeps `[Nonempty ι]` explicit.  The purely
real subadditivity and integrability interfaces remain dimension-uniform: in
the empty branch every real and inverse-log-positive observable is zero.

Mathlib's total nonsingular inverse is used only to form finite-time
lower-tail majorants; it is zero on singular matrices.  Inverting a
newest-factor-left product reverses matrix order, so this module does not
construct a same-base inverse cocycle.  It also does not identify inverse
growth with the negative top exponent; in dimension above one the inverse norm
sees the strongest contraction.

The inverse-generator tail hypothesis does not follow from forward
log-positive integrability, even on a probability space.  A compiled boundary
probe below uses a geometric law on the natural numbers and invertible
one-dimensional contractions whose forward log-positive envelope vanishes
while their inverse and signed real-log tails are nonintegrable.

The final theorem is deliberately orthogonal to the tail package.  If the
RMT-33 log-positive rate is strictly positive, then the real logarithm and its
log-positive envelope agree eventually along almost every sample.  This gives
real-log convergence without invertibility or an inverse-tail hypothesis.  Its
statement also accepts an empty matrix dimension, but only vacuously: every
empty-dimensional log-positive rate is zero, so the strict-positivity premise
cannot hold there.

This module proves finite-horizon real-log integrability and one positive-rate
convergence corollary.  It proves no general signed Kingman theorem, `L¹`
convergence, limit-integral interchange, inverse-cocycle exponent identity,
singular-value limit, Lyapunov spectrum, invariant subspace, or Oseledets
splitting.
-/

open Matrix MeasureTheory Set Filter
open scoped Matrix.Norms.Operator Real
open ProbabilityTheory

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle

universe uΩ uι

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-! ## Real logarithms and pointwise invertibility -/

/-- The total real logarithm of the finite-time cocycle norm.

At norm zero this is zero by Lean's `Real.log_zero` convention; it is not the
zero-faithful extended logarithm. -/
def realLogNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → ℝ :=
  fun ω ↦ Real.log ‖C.value k ω‖

/-- Pointwise invertibility of the one-step generator.

This is an algebraic finiteness hypothesis, not an integrability hypothesis
and not an almost-everywhere representative interface. -/
def IsPointwiseInvertible
    (C : DiscreteMatrixCocycle (ι := ι) μ) : Prop :=
  ∀ ω, IsUnit (C.generator ω)

/-- Pointwise invertibility propagates from the generator to every ordered
finite-time cocycle value. -/
theorem IsPointwiseInvertible.value_isUnit
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.IsPointwiseInvertible) (k : ℕ) (ω : Ω) :
    IsUnit (C.value k ω) := by
  induction k with
  | zero => simp
  | succ k ih =>
      rw [congrFun (C.value_succ k) ω]
      exact (hC (C.base^[k] ω)).mul ih

/-- In nonempty dimension, a pointwise invertible value has finite extended
logarithm equal to the coercion of its real logarithm. -/
theorem IsPointwiseInvertible.logNormObservable_eq_coe_realLogNormObservable
    [Nonempty ι]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.IsPointwiseInvertible) (k : ℕ) (ω : Ω) :
    C.logNormObservable k ω = (C.realLogNormObservable k ω : EReal) := by
  have hvalue : C.value k ω ≠ 0 := (hC.value_isUnit k ω).ne_zero
  have hnorm : 0 < ‖C.value k ω‖ := norm_pos_iff.mpr hvalue
  rw [logNormObservable, realLogNormObservable, ← ofReal_norm,
    ENNReal.log_ofReal, if_neg (not_le.mpr hnorm)]

/-- The total real-log norm observable is measurable without invertibility.

Ordinary measurability is possible because `Real.log` itself is total and
measurable at zero. -/
theorem measurable_realLogNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    Measurable (C.realLogNormObservable k) := by
  exact (C.measurable_normObservable k).log

/-- Empty matrix dimension has zero total real-log norm at every horizon. -/
@[simp] theorem realLogNormObservable_eq_zero_of_isEmpty [IsEmpty ι]
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    C.realLogNormObservable k = fun _ ↦ 0 := by
  funext ω
  have hzero : C.value k ω = 0 := by
    ext i
    exact isEmptyElim i
  simp [realLogNormObservable, hzero]

/-- The time-zero total real-log norm vanishes in every finite dimension,
including the empty one. -/
@[simp] theorem realLogNormObservable_zero
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.realLogNormObservable 0 = fun _ ↦ 0 := by
  cases isEmpty_or_nonempty ι with
  | inl hι =>
      letI := hι
      exact C.realLogNormObservable_eq_zero_of_isEmpty 0
  | inr hι =>
      letI := hι
      funext ω
      simp [realLogNormObservable]

/-- At one step, the total real-log norm is the logarithm of the generator
norm. -/
@[simp] theorem realLogNormObservable_one
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.realLogNormObservable 1 = fun ω ↦ Real.log ‖C.generator ω‖ := by
  funext ω
  simp [realLogNormObservable]

/-- Pointwise invertibility turns norm submultiplicativity into real-log
subadditivity across every cocycle split.  The empty-dimensional branch is
identically zero. -/
theorem IsPointwiseInvertible.realLogNormObservable_add_le
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.IsPointwiseInvertible) (m k : ℕ) (ω : Ω) :
    C.realLogNormObservable (m + k) ω ≤
      C.realLogNormObservable k (C.base^[m] ω) +
        C.realLogNormObservable m ω := by
  cases isEmpty_or_nonempty ι with
  | inl hι =>
      letI := hι
      simp
  | inr hι =>
      letI := hι
      have hleft :
          C.value k (C.base^[m] ω) * C.value m ω ≠ 0 :=
        ((hC.value_isUnit k (C.base^[m] ω)).mul
          (hC.value_isUnit m ω)).ne_zero
      have hk : C.value k (C.base^[m] ω) ≠ 0 :=
        (hC.value_isUnit k (C.base^[m] ω)).ne_zero
      have hm : C.value m ω ≠ 0 := (hC.value_isUnit m ω).ne_zero
      rw [realLogNormObservable, C.value_add]
      calc
        Real.log ‖C.value k (C.base^[m] ω) * C.value m ω‖ ≤
            Real.log (‖C.value k (C.base^[m] ω)‖ * ‖C.value m ω‖) :=
          Real.log_le_log (norm_pos_iff.mpr hleft) (norm_mul_le _ _)
        _ = Real.log ‖C.value k (C.base^[m] ω)‖ +
            Real.log ‖C.value m ω‖ :=
          Real.log_mul (norm_ne_zero_iff.mpr hk) (norm_ne_zero_iff.mpr hm)

/-! ## Measurable inverse-generator envelope -/

/-- The log-positive norm of Mathlib's total nonsingular inverse of the
generator; the inverse is zero on the singular locus.

Under pointwise invertibility this observable measures one-step contraction of
the forward cocycle.  On the singular locus the total inverse is zero, so the
observable is a measurable totalization that erases collapse rather than a
contraction measurement.  It is not presented as the generator of a same-base
inverse cocycle. -/
def inverseGeneratorLogPlusNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) : Ω → ℝ :=
  fun ω ↦ log⁺ ‖(C.generator ω)⁻¹‖

/-- Determinants of ordinarily measurable finite complex matrices are
measurable.  This private bridge supports inverse measurability because the
pinned library has no matrix `MeasurableInv` instance. -/
private theorem measurable_matrixDet
    {X : Ω → Matrix ι ι ℂ} (hX : Measurable X) :
    Measurable fun ω ↦ (X ω).det := by
  rw [show (fun ω ↦ (X ω).det) = fun ω ↦
      ∑ σ : Equiv.Perm ι, Equiv.Perm.sign σ • ∏ i : ι, X ω (σ i) i by
    funext ω
    exact Matrix.det_apply (X ω)]
  exact Finset.measurable_sum Finset.univ fun σ _ ↦
    (Finset.measurable_prod Finset.univ fun i _ ↦
      RandomMatrix.measurable_entry hX (σ i) i).const_smul _

omit [Fintype ι] in
/-- Updating one row by a constant row preserves entrywise measurability. -/
private theorem measurable_updateRow_const
    {X : Ω → Matrix ι ι ℂ} (hX : Measurable X) (j : ι) (v : ι → ℂ) :
    Measurable fun ω ↦ (X ω).updateRow j v := by
  rw [RandomMatrix.measurable_iff_entries]
  intro a b
  by_cases h : a = j
  · subst a
    simp
  · simp [Matrix.updateRow_apply, h]
    exact RandomMatrix.measurable_entry hX a b

/-- The adjugate of an ordinarily measurable finite complex matrix is
measurable entrywise. -/
private theorem measurable_matrixAdjugate
    {X : Ω → Matrix ι ι ℂ} (hX : Measurable X) :
    Measurable fun ω ↦ (X ω).adjugate := by
  rw [RandomMatrix.measurable_iff_entries]
  intro i j
  simpa only [Matrix.adjugate_apply] using
    measurable_matrixDet (measurable_updateRow_const hX j (Pi.single i 1))

/-- Every measurable finite complex matrix family has a measurable total
matrix inverse, proved through the determinant-adjugate formula. -/
private theorem measurable_matrixInverse
    {X : Ω → Matrix ι ι ℂ} (hX : Measurable X) :
    Measurable fun ω ↦ (X ω)⁻¹ := by
  have hdet : Measurable fun ω ↦ (X ω).det := measurable_matrixDet hX
  have hadj : Measurable fun ω ↦ (X ω).adjugate := measurable_matrixAdjugate hX
  have hformula : (fun ω ↦ (X ω)⁻¹) =
      fun ω ↦ ((X ω).det)⁻¹ • (X ω).adjugate := by
    funext ω
    simpa only [Ring.inverse_eq_inv] using Matrix.inv_def (X ω)
  rw [hformula, RandomMatrix.measurable_iff_entries]
  intro i j
  exact hdet.inv.mul (RandomMatrix.measurable_entry hadj i j)

/-- The selected maximum-row-sum matrix norm is measurable for every
ordinarily measurable finite complex matrix family. -/
private theorem measurable_matrixNorm
    {X : Ω → Matrix ι ι ℂ} (hX : Measurable X) :
    Measurable fun ω ↦ ‖X ω‖ := by
  have hrow : ∀ i : ι,
      Measurable fun ω ↦ ∑ j : ι, ‖X ω i j‖₊ := by
    intro i
    exact Finset.measurable_sum Finset.univ fun j _ ↦
      (RandomMatrix.measurable_entry hX i j).nnnorm
  have hsup : ∀ s : Finset ι,
      Measurable fun ω ↦ s.sup fun i ↦ ∑ j : ι, ‖X ω i j‖₊ := by
    intro s
    classical
    induction s using Finset.induction_on with
    | empty => simp
    | @insert i s hi ih =>
        simpa [Finset.sup_insert, hi] using (hrow i).max ih
  convert (hsup Finset.univ).coe_nnreal_real using 1
  funext ω
  exact Matrix.linfty_opNorm_def (X ω)

/-- The total inverse-generator log-positive envelope is measurable without
an invertibility hypothesis. -/
theorem measurable_inverseGeneratorLogPlusNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    Measurable C.inverseGeneratorLogPlusNormObservable := by
  unfold inverseGeneratorLogPlusNormObservable
  exact Real.continuous_posLog.measurable.comp
    (measurable_matrixNorm
      (measurable_matrixInverse C.measurable_generator))

/-! ## Finite inverse-value and orbit-sum majorants -/

/-- The log-positive norm of Mathlib's total nonsingular inverse of one
finite-time cocycle value.

For a pointwise invertible cocycle this is the genuine inverse-value envelope.
At a singular value Mathlib's total inverse is zero, so the observable is zero
and carries no quantitative record of the collapse. -/
def inverseValueLogPlusNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → ℝ :=
  fun ω ↦ log⁺ ‖(C.value k ω)⁻¹‖

/-- The inverse-value log-positive observable vanishes at horizon zero in
every finite dimension. -/
@[simp] theorem inverseValueLogPlusNormObservable_zero
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.inverseValueLogPlusNormObservable 0 = fun _ ↦ 0 := by
  cases isEmpty_or_nonempty ι with
  | inl hι =>
      letI := hι
      funext ω
      have hzero : C.value 0 ω = 0 := by
        ext i
        exact isEmptyElim i
      simp [inverseValueLogPlusNormObservable, hzero]
  | inr hι =>
      letI := hι
      funext ω
      simp [inverseValueLogPlusNormObservable]

/-- At one step, the inverse-value envelope is exactly the inverse-generator
envelope. -/
@[simp] theorem inverseValueLogPlusNormObservable_one
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.inverseValueLogPlusNormObservable 1 =
      C.inverseGeneratorLogPlusNormObservable := by
  funext ω
  simp [inverseValueLogPlusNormObservable,
    inverseGeneratorLogPlusNormObservable]

/-- Every finite inverse-value log-positive observable is measurable without
an invertibility hypothesis. -/
theorem measurable_inverseValueLogPlusNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    Measurable (C.inverseValueLogPlusNormObservable k) := by
  unfold inverseValueLogPlusNormObservable
  exact Real.continuous_posLog.measurable.comp
    (measurable_matrixNorm
      (measurable_matrixInverse (C.measurable_value k)))

/-- The finite sum of inverse-generator log-positive norms along the forward
base orbit. -/
def inverseOrbitLogPlusSum
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) : Ω → ℝ :=
  fun ω ↦ ∑ j ∈ Finset.range k,
    C.inverseGeneratorLogPlusNormObservable (C.base^[j] ω)

/-- The inverse-generator orbit sum vanishes at horizon zero. -/
@[simp] theorem inverseOrbitLogPlusSum_zero
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.inverseOrbitLogPlusSum 0 = fun _ ↦ 0 := by
  funext ω
  simp [inverseOrbitLogPlusSum]

/-- Extending the horizon appends the newest inverse-generator tail term. -/
@[simp] theorem inverseOrbitLogPlusSum_succ
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    C.inverseOrbitLogPlusSum (k + 1) = fun ω ↦
      C.inverseOrbitLogPlusSum k ω +
        C.inverseGeneratorLogPlusNormObservable (C.base^[k] ω) := by
  funext ω
  simp [inverseOrbitLogPlusSum, Finset.sum_range_succ]

/-- The inverse norm of a finite product is controlled by the forward-orbit
sum of the inverse-generator envelopes.

This inequality is unconditional: nonsingular inversion and `log⁺` are total,
and `Matrix.mul_inv_rev` handles the reversed product order.  On a singular
locus the total inverse can make the estimate information-free; the later
pointwise-invertibility hypothesis is what turns it into an honest lower-tail
majorant. -/
theorem inverseValueLogPlusNormObservable_le_inverseOrbitLogPlusSum
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) (ω : Ω) :
    C.inverseValueLogPlusNormObservable k ω ≤
      C.inverseOrbitLogPlusSum k ω := by
  induction k with
  | zero => simp
  | succ k ih =>
      change log⁺ ‖(C.value (k + 1) ω)⁻¹‖ ≤
        C.inverseOrbitLogPlusSum (k + 1) ω
      rw [congrFun (C.value_succ k) ω]
      calc
        log⁺ ‖(C.generator (C.base^[k] ω) * C.value k ω)⁻¹‖ =
            log⁺ ‖(C.value k ω)⁻¹ *
              (C.generator (C.base^[k] ω))⁻¹‖ := by
          rw [Matrix.mul_inv_rev]
        _ ≤ log⁺ (‖(C.value k ω)⁻¹‖ *
            ‖(C.generator (C.base^[k] ω))⁻¹‖) :=
          Real.posLog_le_posLog (norm_nonneg _) (norm_mul_le _ _)
        _ ≤ log⁺ ‖(C.value k ω)⁻¹‖ +
            log⁺ ‖(C.generator (C.base^[k] ω))⁻¹‖ :=
          Real.posLog_mul
        _ ≤ C.inverseOrbitLogPlusSum k ω +
            C.inverseGeneratorLogPlusNormObservable (C.base^[k] ω) := by
          simpa [inverseValueLogPlusNormObservable,
            inverseGeneratorLogPlusNormObservable] using
            add_le_add ih (le_refl
              (log⁺ ‖(C.generator (C.base^[k] ω))⁻¹‖))
        _ = C.inverseOrbitLogPlusSum (k + 1) ω := by
          rw [congrFun (C.inverseOrbitLogPlusSum_succ k) ω]

/-! ## Integrable two-sided generator tails -/

/-- The explicit finite-log and two-sided one-step integrability package.

It combines pointwise generator invertibility, the existing integrable
forward log-positive envelope, and integrability of the inverse-generator
log-positive envelope. -/
structure HasIntegrableGeneratorLogTails
    (C : DiscreteMatrixCocycle (ι := ι) μ) : Prop where
  isPointwiseInvertible : C.IsPointwiseInvertible
  hasIntegrableGeneratorLogPlus : C.HasIntegrableGeneratorLogPlus
  integrable_inverseGeneratorLogPlus :
    Integrable C.inverseGeneratorLogPlusNormObservable μ

/-- Every finite inverse-generator orbit sum is measurable without an
invertibility hypothesis. -/
theorem measurable_inverseOrbitLogPlusSum
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    Measurable (C.inverseOrbitLogPlusSum k) := by
  unfold inverseOrbitLogPlusSum
  exact Finset.measurable_sum (Finset.range k) fun j _ ↦
    C.measurable_inverseGeneratorLogPlusNormObservable.comp
      (C.base_preserving.measurable.iterate j)

/-- Preservation transports inverse-generator integrability through every
finite base iterate. -/
theorem HasIntegrableGeneratorLogTails.integrable_inverseGeneratorLogPlus_at_base_iterate
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) (j : ℕ) :
    Integrable (fun ω ↦ C.inverseGeneratorLogPlusNormObservable
      (C.base^[j] ω)) μ := by
  change Integrable (C.inverseGeneratorLogPlusNormObservable ∘
    C.base^[j]) μ
  exact (C.base_iterate_preserving j).integrable_comp_of_integrable
    hC.integrable_inverseGeneratorLogPlus

/-- Every finite inverse-generator orbit sum is integrable. -/
theorem HasIntegrableGeneratorLogTails.integrable_inverseOrbitLogPlusSum
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) (k : ℕ) :
    Integrable (C.inverseOrbitLogPlusSum k) μ := by
  unfold inverseOrbitLogPlusSum
  exact integrable_finsetSum (Finset.range k) fun j _ ↦
    hC.integrable_inverseGeneratorLogPlus_at_base_iterate j

/-- In nonempty dimension, the negative inverse-value envelope is a pointwise
lower bound for the forward real logarithmic norm. -/
private theorem neg_inverseValueLogPlus_le_realLogNorm
    [Nonempty ι]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.IsPointwiseInvertible) (k : ℕ) (ω : Ω) :
    -C.inverseValueLogPlusNormObservable k ω ≤
      C.realLogNormObservable k ω := by
  let A := C.value k ω
  have hA : IsUnit A := hC.value_isUnit k ω
  have hAdet : IsUnit A.det := (Matrix.isUnit_iff_isUnit_det A).mp hA
  have hAinv : IsUnit A⁻¹ := Matrix.isUnit_nonsing_inv_iff.mpr hA
  have hA_ne : A ≠ 0 := hA.ne_zero
  have hAinv_ne : A⁻¹ ≠ 0 := hAinv.ne_zero
  have hprod : 1 ≤ ‖A⁻¹‖ * ‖A‖ := by
    calc
      1 = ‖(1 : Matrix ι ι ℂ)‖ := by simp
      _ = ‖A⁻¹ * A‖ := by rw [Matrix.nonsing_inv_mul A hAdet]
      _ ≤ ‖A⁻¹‖ * ‖A‖ := norm_mul_le _ _
  have hlogprod : 0 ≤ Real.log (‖A⁻¹‖ * ‖A‖) :=
    Real.log_nonneg hprod
  rw [Real.log_mul (norm_ne_zero_iff.mpr hAinv_ne)
    (norm_ne_zero_iff.mpr hA_ne)] at hlogprod
  have hlog_le_plus : Real.log ‖A⁻¹‖ ≤ log⁺ ‖A⁻¹‖ := by
    rw [Real.posLog_apply]
    exact le_max_right _ _
  unfold inverseValueLogPlusNormObservable realLogNormObservable
  linarith

/-- The negative inverse-generator orbit sum is a pointwise lower bound for
the finite-time real log norm.  The empty-dimensional branch is identically
zero. -/
theorem IsPointwiseInvertible.neg_inverseOrbitLogPlusSum_le_realLogNormObservable
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.IsPointwiseInvertible) (k : ℕ) (ω : Ω) :
    -C.inverseOrbitLogPlusSum k ω ≤ C.realLogNormObservable k ω := by
  cases isEmpty_or_nonempty ι with
  | inl hι =>
      letI := hι
      have hgen : C.inverseGeneratorLogPlusNormObservable = fun _ ↦ 0 := by
        funext x
        unfold inverseGeneratorLogPlusNormObservable
        have hz : (C.generator x)⁻¹ = 0 := by
          ext i
          exact isEmptyElim i
        simp [hz]
      rw [show C.inverseOrbitLogPlusSum k ω = 0 by
        simp [inverseOrbitLogPlusSum, hgen]]
      simp
  | inr hι =>
      letI := hι
      calc
        -C.inverseOrbitLogPlusSum k ω ≤
            -C.inverseValueLogPlusNormObservable k ω :=
          neg_le_neg
            (C.inverseValueLogPlusNormObservable_le_inverseOrbitLogPlusSum k ω)
        _ ≤ C.realLogNormObservable k ω :=
          neg_inverseValueLogPlus_le_realLogNorm
            hC k ω

/-- The real logarithmic norm is pointwise bounded above by its log-positive
envelope, including at norm zero. -/
theorem realLogNormObservable_le_logPlusNormObservable
    (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) (ω : Ω) :
    C.realLogNormObservable k ω ≤ C.logPlusNormObservable k ω := by
  unfold realLogNormObservable logPlusNormObservable
  rw [Real.posLog_apply]
  exact le_max_right _ _

/-- Two-sided generator-tail integrability propagates to the real logarithmic
norm at every finite horizon. -/
theorem HasIntegrableGeneratorLogTails.integrable_realLogNormObservable
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) (k : ℕ) :
    Integrable (C.realLogNormObservable k) μ := by
  exact MeasureTheory.integrable_of_le_of_le
    (C.measurable_realLogNormObservable k).aestronglyMeasurable
    (Filter.Eventually.of_forall fun ω ↦
      hC.isPointwiseInvertible.neg_inverseOrbitLogPlusSum_le_realLogNormObservable k ω)
    (Filter.Eventually.of_forall fun ω ↦
      C.realLogNormObservable_le_logPlusNormObservable k ω)
    (hC.integrable_inverseOrbitLogPlusSum k).neg
    (hC.hasIntegrableGeneratorLogPlus.integrable_logPlusNormObservable k)

/-- The real logarithmic norm process is an integrable shifted-subadditive
process under the explicit tail package, uniformly including empty matrix
dimension. -/
theorem HasIntegrableGeneratorLogTails.isIntegrableSubadditiveProcessCandidate
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogTails) :
    IsIntegrableSubadditiveProcessCandidate C.base μ
      C.realLogNormObservable where
  integrable := hC.integrable_realLogNormObservable
  add_le := hC.isPointwiseInvertible.realLogNormObservable_add_le

/-! ## Positive-rate agreement with the log-positive theorem -/

/-- Strictly positive log-positive growth forces eventual equality with the
real logarithm, hence almost-everywhere normalized real-log convergence.

This corollary needs neither pointwise invertibility, inverse-tail
integrability, nor a nonempty-index typeclass.  In empty dimension its strict
positive-rate premise is impossible, so that specialization is vacuous; the
substantive noninvertible boundary is positive-dimensional singular growth. -/
theorem HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedRealLogNormObservable_of_pos
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (hT : PreErgodic C.base μ)
    (hpos : 0 < C.integratedLogPlusGrowthRate hC) :
    ∀ᵐ ω ∂μ,
      Tendsto
        (fun n ↦ normalizedProcess C.realLogNormObservable n ω) atTop
        (nhds (C.integratedLogPlusGrowthRate hC)) := by
  filter_upwards
      [hC.ae_tendsto_normalizedLogPlusNormObservable hT]
      with ω hlimit
  have hlower : ∀ᶠ n in atTop,
      C.integratedLogPlusGrowthRate hC / 2 <
        normalizedProcess C.logPlusNormObservable n ω :=
    hlimit.eventually (Ioi_mem_nhds (half_lt_self hpos))
  have heq :
      (fun n ↦ normalizedProcess C.logPlusNormObservable n ω) =ᶠ[atTop]
        (fun n ↦ normalizedProcess C.realLogNormObservable n ω) := by
    filter_upwards [hlower, eventually_ge_atTop 1] with n hn_lower hn
    have hncast : 0 < (n : ℝ) := Nat.cast_pos.mpr hn
    have hnormalized :
        0 < normalizedProcess C.logPlusNormObservable n ω :=
      (half_pos hpos).trans hn_lower
    have hlogPlus : 0 < C.logPlusNormObservable n ω :=
      (div_pos_iff_of_pos_right hncast).mp hnormalized
    have hlog : 0 < Real.log (C.normObservable n ω) := by
      rw [logPlusNormObservable, Real.posLog_apply, lt_max_iff] at hlogPlus
      exact hlogPlus.resolve_left (lt_irrefl 0)
    have hobs : C.logPlusNormObservable n ω =
        C.realLogNormObservable n ω := by
      have hlog' : 0 < Real.log ‖C.value n ω‖ := by
        simpa [normObservable] using hlog
      unfold logPlusNormObservable realLogNormObservable normObservable
      rw [Real.posLog_apply, max_eq_right hlog'.le]
    unfold normalizedProcess
    rw [hobs]
  exact hlimit.congr' heq

/-! ## Compiled boundary probes -/

-- Lean's real logarithm totalizes a singular norm to zero.
example : Real.log (0 : ℝ) = 0 := by simp

-- The log-positive envelope erases strict scalar contraction.
example : log⁺ (1 / 2 : ℝ) = 0 := by
  exact (Real.posLog_eq_zero_iff _).2 (by norm_num)

-- The signed real logarithm still records that contraction.
example : Real.log (1 / 2 : ℝ) < 0 := by
  exact Real.log_neg (by norm_num) (by norm_num)

-- The inverse log-positive envelope records the missing contraction tail.
example : 0 < log⁺ ((1 / 2 : ℝ)⁻¹) := by
  rw [Real.posLog_eq_log (by norm_num)]
  exact Real.log_pos (by norm_num)

-- In empty dimension the unique zero matrix is algebraically a unit.
example : IsUnit (0 : Matrix Empty Empty ℂ) := by
  convert isUnit_one using 1
  exact Subsingleton.elim _ _

-- Hence every empty-dimensional cocycle satisfies pointwise invertibility.
example (C : DiscreteMatrixCocycle (ι := Empty) μ) :
    C.IsPointwiseInvertible := by
  intro ω
  convert isUnit_one using 1
  exact Subsingleton.elim _ _

-- Nevertheless its extended log is bottom while its total real log is zero.
example (C : DiscreteMatrixCocycle (ι := Empty) μ) (k : ℕ) (ω : Ω) :
    C.logNormObservable k ω = ⊥ ∧ C.realLogNormObservable k ω = 0 := by
  constructor
  · exact congrFun (C.logNormObservable_eq_bot_of_isEmpty k) ω
  · have hzero : C.value k ω = 0 := by
      ext i
      exact isEmptyElim i
    simp [realLogNormObservable, hzero]

-- The positive-rate endpoint accepts empty dimension only vacuously: its
-- integrated log-positive growth rate is necessarily zero.
example (C : DiscreteMatrixCocycle (ι := Empty) μ)
    (hC : C.HasIntegrableGeneratorLogPlus) :
    C.integratedLogPlusGrowthRate hC = 0 := by
  have hzero : C.normalizedIntegratedLogPlusNorm = fun _ ↦ 0 := by
    funext n
    simp [normalizedIntegratedLogPlusNorm, integratedLogPlusNorm]
  have hzero_tendsto :
      Tendsto C.normalizedIntegratedLogPlusNorm atTop (nhds 0) := by
    rw [hzero]
    exact tendsto_const_nhds
  exact tendsto_nhds_unique
    hC.tendsto_normalizedIntegratedLogPlusNorm hzero_tendsto

-- Matrix inversion reverses the order of a newest-factor-left product.
example (A B : Matrix (Fin 2) (Fin 2) ℂ) :
    (A * B)⁻¹ = B⁻¹ * A⁻¹ := by
  exact Matrix.mul_inv_rev A B

private def singularExpandingMatrix : Matrix (Fin 2) (Fin 2) ℂ :=
  !![(2 : ℂ), 0; 0, 0]

-- A singular matrix can still have an expanding top norm.
example : ¬ IsUnit singularExpandingMatrix ∧ 1 < ‖singularExpandingMatrix‖ := by
  constructor
  · rw [Matrix.isUnit_iff_isUnit_det]
    simp [singularExpandingMatrix]
  · rw [Matrix.linfty_opNorm_def]
    norm_num [singularExpandingMatrix, Finset.sup_insert]

-- On an infinite measure space, even a constant contraction separates the
-- two tails: the forward constant is zero while the inverse constant is
-- strictly positive.  This isolates the finite-measure boundary, since every
-- finite constant is integrable on a probability space; the next probe needs
-- a genuine heavy tail to obtain the same separation there.
example :
    Integrable (fun _ : ℝ ↦ log⁺ (1 / 2 : ℝ)) volume ∧
      ¬ Integrable (fun _ : ℝ ↦ log⁺ ((1 / 2 : ℝ)⁻¹)) volume := by
  constructor
  · rw [integrable_const_iff]
    exact Or.inl ((Real.posLog_eq_zero_iff _).2 (by norm_num))
  · rw [integrable_const_iff]
    simp only [not_or]
    constructor
    · exact ne_of_gt (by
        rw [Real.posLog_eq_log (by norm_num)]
        exact Real.log_pos (by norm_num))
    · intro hfinite
      letI := hfinite
      have hlt : volume (Set.univ : Set ℝ) < ⊤ :=
        measure_lt_top volume Set.univ
      rw [Real.volume_univ] at hlt
      exact (lt_irrefl ⊤) hlt

private def geometricTailParameter : unitInterval :=
  ⟨(1 / 2 : ℝ), by constructor <;> norm_num⟩

private def geometricTailMeasure : Measure ℕ :=
  geometricMeasure geometricTailParameter

private instance : IsProbabilityMeasure geometricTailMeasure := by
  unfold geometricTailMeasure
  infer_instance

private def geometricTailExponent (n : ℕ) : ℝ :=
  (2 : ℝ) ^ n

private def geometricTailMatrix (n : ℕ) : Matrix (Fin 1) (Fin 1) ℂ :=
  !![((Real.exp (-geometricTailExponent n) : ℝ) : ℂ)]

private def geometricTailCocycle :
    DiscreteMatrixCocycle (ι := Fin 1) geometricTailMeasure where
  base := id
  generator := geometricTailMatrix
  base_preserving := MeasurePreserving.id geometricTailMeasure
  measurable_generator := by fun_prop

private theorem geometricTailParameter_ne_zero :
    geometricTailParameter ≠ 0 := by
  intro h
  have h' := congrArg Subtype.val h
  norm_num [geometricTailParameter] at h'

private theorem geometricTailMatrix_norm (n : ℕ) :
    ‖geometricTailMatrix n‖ = Real.exp (-geometricTailExponent n) := by
  rw [Matrix.linfty_opNorm_def]
  simpa [geometricTailMatrix] using
    Complex.norm_exp_ofReal (-geometricTailExponent n)

private theorem geometricTailMatrix_inv (n : ℕ) :
    (geometricTailMatrix n)⁻¹ =
      !![((Real.exp (geometricTailExponent n) : ℝ) : ℂ)] := by
  rw [Matrix.inv_subsingleton]
  ext i j
  fin_cases i
  fin_cases j
  simp [geometricTailMatrix, Ring.inverse_eq_inv, Real.exp_neg]

private theorem geometricTailMatrix_inv_norm (n : ℕ) :
    ‖(geometricTailMatrix n)⁻¹‖ = Real.exp (geometricTailExponent n) := by
  rw [geometricTailMatrix_inv, Matrix.linfty_opNorm_def]
  simp

private theorem geometricTailCocycle_isPointwiseInvertible :
    geometricTailCocycle.IsPointwiseInvertible := by
  intro n
  rw [Matrix.isUnit_iff_isUnit_det]
  simp [geometricTailCocycle, geometricTailMatrix]

private theorem geometricTail_forward_logPlus (n : ℕ) :
    log⁺ ‖geometricTailMatrix n‖ = 0 := by
  rw [geometricTailMatrix_norm]
  exact (Real.posLog_eq_zero_iff _).2 <| by
    rw [abs_of_pos (Real.exp_pos _), Real.exp_le_one_iff]
    exact neg_nonpos.mpr (pow_nonneg (by norm_num) _)

private theorem geometricTail_inverse_logPlus (n : ℕ) :
    log⁺ ‖(geometricTailMatrix n)⁻¹‖ = geometricTailExponent n := by
  rw [geometricTailMatrix_inv_norm]
  rw [Real.posLog_eq_log]
  · exact Real.log_exp _
  · rw [abs_of_pos (Real.exp_pos _)]
    exact (Real.one_le_exp_iff).2 (pow_nonneg (by norm_num) _)

private theorem geometricTail_realLog (n : ℕ) :
    Real.log ‖geometricTailMatrix n‖ = -geometricTailExponent n := by
  rw [geometricTailMatrix_norm, Real.log_exp]

private theorem geometricTail_forward_observable :
    geometricTailCocycle.logPlusNormObservable 1 = fun _ ↦ 0 := by
  funext n
  unfold logPlusNormObservable normObservable
  rw [show geometricTailCocycle.value 1 n = geometricTailMatrix n by
    simp [geometricTailCocycle]]
  exact geometricTail_forward_logPlus n

private theorem geometricTail_inverse_observable :
    geometricTailCocycle.inverseGeneratorLogPlusNormObservable =
      geometricTailExponent := by
  funext n
  unfold inverseGeneratorLogPlusNormObservable
  rw [show geometricTailCocycle.generator n = geometricTailMatrix n by
    rfl]
  exact geometricTail_inverse_logPlus n

private theorem geometricTail_real_observable :
    geometricTailCocycle.realLogNormObservable 1 =
      fun n ↦ -geometricTailExponent n := by
  funext n
  unfold realLogNormObservable
  rw [show geometricTailCocycle.value 1 n = geometricTailMatrix n by
    simp [geometricTailCocycle]]
  exact geometricTail_realLog n

private theorem geometricTail_not_summable :
    ¬ Summable (fun n : ℕ ↦
      (1 - geometricTailParameter : ℝ) ^ n * geometricTailParameter *
        ‖geometricTailExponent n‖) := by
  have hfun : (fun n : ℕ ↦
      (1 - geometricTailParameter : ℝ) ^ n * geometricTailParameter *
        ‖geometricTailExponent n‖) = fun _ ↦ (1 / 2 : ℝ) := by
    funext n
    change ((1 : ℝ) - 1 / 2) ^ n * (1 / 2) * ‖(2 : ℝ) ^ n‖ = 1 / 2
    rw [show (1 : ℝ) - 1 / 2 = 1 / 2 by norm_num]
    rw [Real.norm_of_nonneg (pow_nonneg (by norm_num : (0 : ℝ) ≤ 2) n)]
    calc
      (1 / 2 : ℝ) ^ n * (1 / 2) * 2 ^ n =
          ((1 / 2 : ℝ) ^ n * 2 ^ n) * (1 / 2) := by ring
      _ = (((1 / 2 : ℝ) * 2) ^ n) * (1 / 2) := by rw [mul_pow]
      _ = 1 / 2 := by norm_num
  rw [hfun, summable_const_iff]
  norm_num

private theorem geometricTail_hasIntegrableGeneratorLogPlus :
    geometricTailCocycle.HasIntegrableGeneratorLogPlus := by
  rw [HasIntegrableGeneratorLogPlus, geometricTail_forward_observable]
  exact integrable_zero ℕ ℝ geometricTailMeasure

private theorem geometricTail_not_integrable_inverse :
    ¬ Integrable geometricTailCocycle.inverseGeneratorLogPlusNormObservable
      geometricTailMeasure := by
  rw [geometricTail_inverse_observable]
  unfold geometricTailMeasure
  rw [integrable_geometricMeasure_iff geometricTailParameter_ne_zero]
  exact geometricTail_not_summable

private theorem geometricTail_not_integrable_real :
    ¬ Integrable (geometricTailCocycle.realLogNormObservable 1)
      geometricTailMeasure := by
  rw [geometricTail_real_observable]
  unfold geometricTailMeasure
  rw [integrable_geometricMeasure_iff geometricTailParameter_ne_zero]
  simpa only [norm_neg] using geometricTail_not_summable

-- Forward log-positive integrability therefore does not imply either the
-- inverse-generator tail or signed real-log integrability, even for an
-- invertible one-dimensional cocycle over a genuine probability measure.
-- Its base is the identity, so this is a one-step tail counterexample rather
-- than an independent-sampling or ergodic construction.
-- At atom `n`, the geometric mass is `2⁻ⁿ⁻¹`, while both missing
-- absolute tails have size `2ⁿ`, leaving the nonsummable constant `1 / 2`.
example :
    IsProbabilityMeasure geometricTailMeasure ∧
      geometricTailCocycle.IsPointwiseInvertible ∧
      geometricTailCocycle.HasIntegrableGeneratorLogPlus ∧
      ¬ Integrable geometricTailCocycle.inverseGeneratorLogPlusNormObservable
        geometricTailMeasure ∧
      ¬ Integrable (geometricTailCocycle.realLogNormObservable 1)
        geometricTailMeasure := by
  exact ⟨inferInstance, geometricTailCocycle_isPointwiseInvertible,
    geometricTail_hasIntegrableGeneratorLogPlus,
    geometricTail_not_integrable_inverse,
    geometricTail_not_integrable_real⟩

private def singularFirstContraction : Matrix (Fin 2) (Fin 2) ℂ :=
  !![(1 / 2 : ℂ), 0; 0, 0]

private def singularSecondContraction : Matrix (Fin 2) (Fin 2) ℂ :=
  !![0, 0; 0, (1 / 2 : ℂ)]

-- Without a nonvanishing interface, `Real.log 0 = 0` makes real-log
-- subadditivity genuinely false for singular factors whose product vanishes.
example : ¬ (Real.log ‖singularFirstContraction * singularSecondContraction‖ ≤
    Real.log ‖singularFirstContraction‖ +
      Real.log ‖singularSecondContraction‖) := by
  rw [show singularFirstContraction * singularSecondContraction = 0 by
    ext i j
    fin_cases i <;> fin_cases j <;>
      norm_num [singularFirstContraction, singularSecondContraction,
        Matrix.mul_apply, Fin.sum_univ_two]]
  rw [show ‖singularFirstContraction‖ = 1 / 2 by
    rw [Matrix.linfty_opNorm_def]
    norm_num [singularFirstContraction, Finset.sup_insert,
      Finset.univ_fin2]]
  rw [show ‖singularSecondContraction‖ = 1 / 2 by
    rw [Matrix.linfty_opNorm_def]
    norm_num [singularSecondContraction, Finset.sup_insert,
      Finset.univ_fin2]]
  simp only [norm_zero, Real.log_zero, not_le]
  have hneg : Real.log (1 / 2 : ℝ) < 0 :=
    Real.log_neg (by norm_num) (by norm_num)
  linarith

-- The total nonsingular inverse is zero on a singular contraction, so the
-- inverse sandwich also genuinely needs the selected invertibility interface.
example : ¬ (-log⁺ ‖singularFirstContraction⁻¹‖ ≤
    Real.log ‖singularFirstContraction‖) := by
  rw [show singularFirstContraction⁻¹ = 0 by
    apply Matrix.nonsing_inv_apply_not_isUnit
    simp [singularFirstContraction]]
  rw [show ‖singularFirstContraction‖ = 1 / 2 by
    rw [Matrix.linfty_opNorm_def]
    norm_num [singularFirstContraction, Finset.sup_insert,
      Finset.univ_fin2]]
  simp only [norm_zero, Real.posLog_zero, neg_zero, not_le]
  exact Real.log_neg (by norm_num) (by norm_num)

private def twoRateContraction : Matrix (Fin 2) (Fin 2) ℂ :=
  !![(1 / 2 : ℂ), 0; 0, (1 / 4 : ℂ)]

private def twoRateInverse : Matrix (Fin 2) (Fin 2) ℂ :=
  !![(2 : ℂ), 0; 0, 4]

-- In two dimensions the inverse norm sees the strongest contraction: here
-- the inverse lower majorant is strictly below the negative top log rate.
example : twoRateContraction⁻¹ = twoRateInverse ∧
    -log⁺ ‖twoRateContraction⁻¹‖ < Real.log ‖twoRateContraction‖ := by
  have hinv : twoRateContraction⁻¹ = twoRateInverse := by
    have hdet : IsUnit twoRateContraction.det := by
      simp [twoRateContraction]
    rw [Matrix.nonsing_inv_apply twoRateContraction hdet]
    ext i j
    fin_cases i <;> fin_cases j <;>
      norm_num [twoRateContraction, twoRateInverse, Matrix.adjugate_apply,
        Matrix.det_fin_two, Matrix.updateRow_apply, Pi.single_apply]
  refine ⟨hinv, ?_⟩
  rw [hinv]
  rw [show ‖twoRateContraction‖ = 1 / 2 by
    rw [Matrix.linfty_opNorm_def]
    norm_num [twoRateContraction, Finset.sup_insert, Finset.univ_fin2]]
  rw [show ‖twoRateInverse‖ = 4 by
    rw [Matrix.linfty_opNorm_def]
    norm_num [twoRateInverse, Finset.sup_insert, Finset.univ_fin2]]
  rw [Real.posLog_eq_log (by norm_num)]
  have hlog4 : Real.log (4 : ℝ) = 2 * Real.log 2 := by
    rw [show (4 : ℝ) = 2 * 2 by norm_num,
      Real.log_mul (by norm_num) (by norm_num)]
    ring
  have hloghalf : Real.log (1 / 2 : ℝ) = -Real.log 2 := by
    rw [one_div]
    exact Real.log_inv (2 : ℝ)
  rw [hlog4, hloghalf]
  have hpos : 0 < Real.log (2 : ℝ) := Real.log_pos (by norm_num)
  linarith

private def upperShear : Matrix (Fin 2) (Fin 2) ℂ :=
  !![1, 1; 0, 1]

private def lowerShear : Matrix (Fin 2) (Fin 2) ℂ :=
  !![1, 0; 1, 1]

-- Noncommuting shears expose why a same-order product of pointwise inverses
-- cannot be advertised as the inverse of the forward cocycle value.
example : lowerShear⁻¹ * upperShear⁻¹ ≠
    upperShear⁻¹ * lowerShear⁻¹ := by
  intro h
  have hentry := congrFun (congrFun h 0) 0
  norm_num [upperShear, lowerShear, Matrix.inv_def, Matrix.adjugate_apply,
    Matrix.det_fin_two, Matrix.updateRow_apply, Pi.single_apply,
    Matrix.mul_apply, Fin.sum_univ_two] at hentry

end NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle

#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.IsPointwiseInvertible.value_isUnit
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.IsPointwiseInvertible.logNormObservable_eq_coe_realLogNormObservable
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.measurable_realLogNormObservable
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.IsPointwiseInvertible.realLogNormObservable_add_le
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.measurable_inverseGeneratorLogPlusNormObservable
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.inverseValueLogPlusNormObservable_le_inverseOrbitLogPlusSum
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogTails.integrable_inverseOrbitLogPlusSum
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.IsPointwiseInvertible.neg_inverseOrbitLogPlusSum_le_realLogNormObservable
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogTails.integrable_realLogNormObservable
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogTails.isIntegrableSubadditiveProcessCandidate
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedRealLogNormObservable_of_pos
