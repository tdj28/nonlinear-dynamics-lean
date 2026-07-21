import NonlinearDynamics.Random.RandomMatrices.Hermitian

/-!
# Elementary observables of finite random matrices

The first observables used in finite random-matrix calculations are traces of
matrix powers. For a matrix `X`, the function `tracePower X k` is the scalar
random variable

`ω ↦ tr((X ω)^k)`.

This module proves the two structural facts needed before discussing moments:
the observable is measurable, and it is real-valued when `X` is Hermitian.
Expectation and integrability are intentionally left to ensemble-specific
modules, because measurability alone does not guarantee that a moment exists.
-/

open Matrix MeasureTheory
open scoped Matrix

universe uΩ uι

namespace NonlinearDynamics.Random

namespace RandomMatrix

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]

/-- The `k`th trace-power observable of a square complex random matrix. -/
def tracePower [Fintype ι] [DecidableEq ι]
    (X : RandomMatrix Ω ι ι ℂ) (k : ℕ) : Ω → ℂ :=
  fun ω ↦ Matrix.trace ((X ω) ^ k)

/-- Pointwise matrix powers preserve measurability in finite dimensions. -/
theorem measurable_matrixPow [Fintype ι] [DecidableEq ι]
    {X : RandomMatrix Ω ι ι ℂ} (hX : Measurable X) (k : ℕ) :
    Measurable fun ω ↦ (X ω) ^ k := by
  induction k with
  | zero =>
      simpa only [pow_zero] using
        (measurable_const (Ω := Ω) (1 : Matrix ι ι ℂ))
  | succ k ih =>
      simpa only [pow_succ] using measurable_mul ih hX

/-- Every trace-power observable of a measurable finite random matrix is
measurable. -/
theorem measurable_tracePower [Fintype ι] [DecidableEq ι]
    {X : RandomMatrix Ω ι ι ℂ} (hX : Measurable X) (k : ℕ) :
    Measurable (tracePower X k) := by
  change Measurable fun ω ↦ Matrix.trace ((X ω) ^ k)
  exact measurable_trace (measurable_matrixPow hX k)

omit [MeasurableSpace Ω] in
/-- Every power of an everywhere-Hermitian finite random matrix remains
Hermitian everywhere. -/
theorem IsHermitianEverywhere.matrixPow [Fintype ι] [DecidableEq ι]
    {X : RandomMatrix Ω ι ι ℂ} (hX : IsHermitianEverywhere X) (k : ℕ) :
    IsHermitianEverywhere fun ω ↦ (X ω) ^ k :=
  fun ω ↦ (hX ω).pow k

omit [MeasurableSpace Ω] in
/-- Trace-power observables of an everywhere-Hermitian finite random matrix are
real at every sample. -/
theorem IsHermitianEverywhere.tracePower_im_eq_zero [Fintype ι] [DecidableEq ι]
    {X : RandomMatrix Ω ι ι ℂ} (hX : IsHermitianEverywhere X) (k : ℕ) (ω : Ω) :
    (tracePower X k ω).im = 0 := by
  simpa only [tracePower] using (hX.matrixPow k).trace_im_eq_zero ω

/-- Trace-power observables of an almost-surely Hermitian finite random matrix
are real almost surely. -/
theorem isHermitianAE_tracePower_im_eq_zero [Fintype ι] [DecidableEq ι]
    {X : RandomMatrix Ω ι ι ℂ} {μ : Measure Ω} (hX : IsHermitianAE X μ) (k : ℕ) :
    ∀ᵐ ω ∂μ, (tracePower X k ω).im = 0 := by
  filter_upwards [hX] with ω hω
  rw [← Complex.conj_eq_iff_im, ← Complex.star_def]
  simpa only [tracePower] using star_trace_eq_of_isHermitian (hω.pow k)

end RandomMatrix

namespace HermitianRandomMatrix

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]

/-- Package the pointwise `k`th power of a finite Hermitian random matrix. -/
def matrixPow [Fintype ι] [DecidableEq ι]
    (X : HermitianRandomMatrix Ω ι) (k : ℕ) : HermitianRandomMatrix Ω ι where
  toRandomMatrix := fun ω ↦ (X ω) ^ k
  measurable_toRandomMatrix := RandomMatrix.measurable_matrixPow X.measurable_toRandomMatrix k
  isHermitian := X.isHermitian.matrixPow k

@[simp]
theorem matrixPow_apply [Fintype ι] [DecidableEq ι]
    (X : HermitianRandomMatrix Ω ι) (k : ℕ) (ω : Ω) :
    X.matrixPow k ω = (X ω) ^ k :=
  rfl

/-- Every trace-power observable of a bundled finite Hermitian random matrix is
measurable. -/
theorem measurable_tracePower [Fintype ι] [DecidableEq ι]
    (X : HermitianRandomMatrix Ω ι) (k : ℕ) :
    Measurable (RandomMatrix.tracePower X.toRandomMatrix k) :=
  RandomMatrix.measurable_tracePower X.measurable_toRandomMatrix k

/-- Every trace-power observable of a bundled finite Hermitian random matrix is
real at every sample. -/
theorem tracePower_im_eq_zero [Fintype ι] [DecidableEq ι]
    (X : HermitianRandomMatrix Ω ι) (k : ℕ) (ω : Ω) :
    (RandomMatrix.tracePower X.toRandomMatrix k ω).im = 0 :=
  X.isHermitian.tracePower_im_eq_zero k ω

end HermitianRandomMatrix

end NonlinearDynamics.Random
