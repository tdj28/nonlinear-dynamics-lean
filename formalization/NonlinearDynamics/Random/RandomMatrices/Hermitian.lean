import Mathlib.LinearAlgebra.Matrix.Trace
import NonlinearDynamics.Random.RandomMatrices.Basic

/-!
# Hermitian random matrices

This module separates three conditions that are easy to conflate in informal
probability arguments:

* `IsHermitianEverywhere X` says that every realized matrix is Hermitian;
* `IsHermitianAE X μ` says this only outside a `μ`-null set;
* measurability says that `X` is a genuine matrix-valued random variable.

`HermitianRandomMatrix` bundles the strongest, pointwise version together with
measurability. This is a convenient target for exact finite-dimensional
ensemble constructions. The almost-sure predicate remains available for
ensembles or modifications whose defining property only holds almost surely.

No probability distribution or normalization is chosen here. In particular,
the symmetrization constructor uses the unnormalized map `X ↦ X + Xᴴ` from
`RandomMatrices.Basic`.
-/

open Matrix MeasureTheory
open scoped Matrix

universe uΩ uι

namespace NonlinearDynamics.Random

namespace RandomMatrix

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]

/-- A square complex random matrix is Hermitian everywhere when each of its
realizations is Hermitian. -/
def IsHermitianEverywhere (X : RandomMatrix Ω ι ι ℂ) : Prop :=
  ∀ ω, (X ω).IsHermitian

omit [MeasurableSpace Ω] in
/-- The entrywise characterization of pointwise Hermiticity. -/
theorem isHermitianEverywhere_iff_entries (X : RandomMatrix Ω ι ι ℂ) :
    IsHermitianEverywhere X ↔ ∀ ω i j, star (X ω j i) = X ω i j := by
  simp only [IsHermitianEverywhere, Matrix.IsHermitian.ext_iff]

/-- Pointwise Hermiticity implies almost-sure Hermiticity for every measure. -/
theorem IsHermitianEverywhere.isHermitianAE {X : RandomMatrix Ω ι ι ℂ}
    (hX : IsHermitianEverywhere X) (μ : Measure Ω) : IsHermitianAE X μ :=
  Filter.Eventually.of_forall hX

/-- A measurable random matrix that is Hermitian at every sample. -/
def IsMeasurableHermitian (X : RandomMatrix Ω ι ι ℂ) : Prop :=
  Measurable X ∧ IsHermitianEverywhere X

/-- A measurable random matrix that is Hermitian almost surely. -/
def IsMeasurableHermitianAE (X : RandomMatrix Ω ι ι ℂ) (μ : Measure Ω) : Prop :=
  Measurable X ∧ IsHermitianAE X μ

/-- A pointwise measurable-Hermitian matrix is measurable-Hermitian almost
surely for every measure. -/
theorem IsMeasurableHermitian.isMeasurableHermitianAE
    {X : RandomMatrix Ω ι ι ℂ} (hX : IsMeasurableHermitian X) (μ : Measure Ω) :
    IsMeasurableHermitianAE X μ :=
  ⟨hX.1, hX.2.isHermitianAE μ⟩

/-- Hermitian symmetrization is a measurable Hermitian random matrix whenever
the original random matrix is measurable. -/
theorem isMeasurableHermitian_hermitianSymmetrization
    {X : RandomMatrix Ω ι ι ℂ} (hX : Measurable X) :
    IsMeasurableHermitian (hermitianSymmetrization X) :=
  ⟨measurable_hermitianSymmetrization hX,
    hermitianSymmetrization_isHermitian X⟩

omit [MeasurableSpace Ω] in
/-- Conjugate symmetry of entries, stated for an everywhere-Hermitian random
matrix. -/
theorem IsHermitianEverywhere.star_entry {X : RandomMatrix Ω ι ι ℂ}
    (hX : IsHermitianEverywhere X) (ω : Ω) (i j : ι) :
    star (X ω j i) = X ω i j :=
  (hX ω).apply i j

omit [MeasurableSpace Ω] in
/-- Every diagonal entry of an everywhere-Hermitian complex random matrix is
real, expressed by the vanishing of its imaginary part. -/
theorem IsHermitianEverywhere.diagonal_im_eq_zero
    {X : RandomMatrix Ω ι ι ℂ} (hX : IsHermitianEverywhere X) (ω : Ω) (i : ι) :
    (X ω i i).im = 0 := by
  rw [← Complex.conj_eq_iff_im, ← Complex.star_def]
  exact hX.star_entry ω i i

/-- Conjugate symmetry of entries holds almost surely when the matrix is
Hermitian almost surely. -/
theorem isHermitianAE_star_entry {X : RandomMatrix Ω ι ι ℂ} {μ : Measure Ω}
    (hX : IsHermitianAE X μ) (i j : ι) :
    ∀ᵐ ω ∂μ, star (X ω j i) = X ω i j :=
  hX.mono fun _ hω ↦ hω.apply i j

/-- Diagonal entries are real almost surely when the matrix is Hermitian almost
surely. -/
theorem isHermitianAE_diagonal_im_eq_zero
    {X : RandomMatrix Ω ι ι ℂ} {μ : Measure Ω} (hX : IsHermitianAE X μ) (i : ι) :
    ∀ᵐ ω ∂μ, (X ω i i).im = 0 := by
  filter_upwards [hX] with ω hω
  rw [← Complex.conj_eq_iff_im, ← Complex.star_def]
  exact hω.apply i i

/-- The trace of a measurable finite random matrix is a measurable complex
random variable. -/
theorem measurable_trace [Fintype ι] {X : RandomMatrix Ω ι ι ℂ}
    (hX : Measurable X) : Measurable fun ω ↦ Matrix.trace (X ω) := by
  simp only [Matrix.trace, Matrix.diag_apply]
  exact Finset.measurable_sum Finset.univ fun i _ ↦ measurable_entry hX i i

/-- The trace of a finite Hermitian complex matrix is fixed by complex
conjugation. -/
theorem star_trace_eq_of_isHermitian [Fintype ι] {A : Matrix ι ι ℂ}
    (hA : A.IsHermitian) : star (Matrix.trace A) = Matrix.trace A := by
  rw [← Matrix.trace_conjTranspose, hA.eq]

omit [MeasurableSpace Ω] in
/-- The trace of an everywhere-Hermitian finite random matrix is real. -/
theorem IsHermitianEverywhere.trace_im_eq_zero [Fintype ι]
    {X : RandomMatrix Ω ι ι ℂ} (hX : IsHermitianEverywhere X) (ω : Ω) :
    (Matrix.trace (X ω)).im = 0 := by
  rw [← Complex.conj_eq_iff_im, ← Complex.star_def]
  exact star_trace_eq_of_isHermitian (hX ω)

/-- The trace of an almost-surely Hermitian finite random matrix is real almost
surely. -/
theorem isHermitianAE_trace_im_eq_zero [Fintype ι]
    {X : RandomMatrix Ω ι ι ℂ} {μ : Measure Ω} (hX : IsHermitianAE X μ) :
    ∀ᵐ ω ∂μ, (Matrix.trace (X ω)).im = 0 := by
  filter_upwards [hX] with ω hω
  rw [← Complex.conj_eq_iff_im, ← Complex.star_def]
  exact star_trace_eq_of_isHermitian hω

end RandomMatrix

/-- A measurable complex random matrix whose every realization is Hermitian.

This pointwise bundle is deliberately stronger than an almost-sure assertion.
Use `RandomMatrix.IsMeasurableHermitianAE` when null-set modifications matter.
-/
structure HermitianRandomMatrix (Ω : Type uΩ) (ι : Type uι) [MeasurableSpace Ω] where
  /-- The underlying matrix-valued map. -/
  toRandomMatrix : RandomMatrix Ω ι ι ℂ
  /-- Measurability with respect to the entrywise matrix measurable space. -/
  measurable_toRandomMatrix : Measurable toRandomMatrix
  /-- Hermiticity of every realization. -/
  isHermitian : RandomMatrix.IsHermitianEverywhere toRandomMatrix

namespace HermitianRandomMatrix

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]

/-- A bundled Hermitian random matrix can be applied to a sample like its
underlying random matrix. -/
instance : CoeFun (HermitianRandomMatrix Ω ι) fun _ ↦ Ω → Matrix ι ι ℂ where
  coe X := X.toRandomMatrix

@[simp]
theorem coe_toRandomMatrix (X : HermitianRandomMatrix Ω ι) :
    (X.toRandomMatrix : Ω → Matrix ι ι ℂ) = X :=
  rfl

/-- Two bundled Hermitian random matrices are equal when their realizations are
equal. -/
@[ext]
theorem ext {X Y : HermitianRandomMatrix Ω ι} (h : ∀ ω, X ω = Y ω) : X = Y := by
  cases X
  cases Y
  congr
  funext ω
  exact h ω

/-- Every entry of a bundled Hermitian random matrix is measurable. -/
theorem measurable_entry (X : HermitianRandomMatrix Ω ι) (i j : ι) :
    Measurable fun ω ↦ X ω i j :=
  RandomMatrix.measurable_entry X.measurable_toRandomMatrix i j

/-- A bundled Hermitian random matrix is Hermitian almost surely for any
measure. -/
theorem isHermitianAE (X : HermitianRandomMatrix Ω ι) (μ : Measure Ω) :
    RandomMatrix.IsHermitianAE X.toRandomMatrix μ :=
  X.isHermitian.isHermitianAE μ

/-- A bundled Hermitian random matrix satisfies the unbundled measurable and
almost-surely Hermitian predicate for any measure. -/
theorem isMeasurableHermitianAE (X : HermitianRandomMatrix Ω ι) (μ : Measure Ω) :
    RandomMatrix.IsMeasurableHermitianAE X.toRandomMatrix μ :=
  ⟨X.measurable_toRandomMatrix, X.isHermitianAE μ⟩

/-- Package the unnormalized Hermitian symmetrization of a measurable random
matrix. -/
def ofSymmetrization (X : RandomMatrix Ω ι ι ℂ) (hX : Measurable X) :
    HermitianRandomMatrix Ω ι where
  toRandomMatrix := RandomMatrix.hermitianSymmetrization X
  measurable_toRandomMatrix := RandomMatrix.measurable_hermitianSymmetrization hX
  isHermitian := RandomMatrix.hermitianSymmetrization_isHermitian X

/-- The congruence transform `A X Aᴴ` of a Hermitian random matrix.

Hermiticity needs no invertibility or unitarity assumption on `A`. Later
unitary-invariance results can specialize this operation to unitary `A`.
-/
def conjugateBy [Fintype ι] (A : Matrix ι ι ℂ) (X : HermitianRandomMatrix Ω ι) :
    HermitianRandomMatrix Ω ι where
  toRandomMatrix := fun ω ↦ A * X ω * Aᴴ
  measurable_toRandomMatrix :=
    RandomMatrix.measurable_mul
      (RandomMatrix.measurable_mul
        (RandomMatrix.measurable_const (Ω := Ω) A) X.measurable_toRandomMatrix)
      (RandomMatrix.measurable_const (Ω := Ω) Aᴴ)
  isHermitian := fun ω ↦ Matrix.isHermitian_mul_mul_conjTranspose A (X.isHermitian ω)

/-- Entries of a bundled Hermitian random matrix satisfy conjugate symmetry. -/
theorem star_entry (X : HermitianRandomMatrix Ω ι) (ω : Ω) (i j : ι) :
    star (X ω j i) = X ω i j :=
  X.isHermitian.star_entry ω i j

/-- Diagonal entries of a bundled Hermitian random matrix are real. -/
theorem diagonal_im_eq_zero (X : HermitianRandomMatrix Ω ι) (ω : Ω) (i : ι) :
    (X ω i i).im = 0 :=
  X.isHermitian.diagonal_im_eq_zero ω i

/-- The trace observable of a finite bundled Hermitian random matrix is
measurable. -/
theorem measurable_trace [Fintype ι] (X : HermitianRandomMatrix Ω ι) :
    Measurable fun ω ↦ Matrix.trace (X ω) :=
  RandomMatrix.measurable_trace X.measurable_toRandomMatrix

/-- The trace of a finite bundled Hermitian random matrix is real at every
sample. -/
theorem trace_im_eq_zero [Fintype ι] (X : HermitianRandomMatrix Ω ι) (ω : Ω) :
    (Matrix.trace (X ω)).im = 0 :=
  X.isHermitian.trace_im_eq_zero ω

end HermitianRandomMatrix

end NonlinearDynamics.Random
