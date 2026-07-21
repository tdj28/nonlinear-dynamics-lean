import Mathlib.LinearAlgebra.Matrix.Hermitian
import Mathlib.MeasureTheory.Constructions.BorelSpace.Complex

/-!
# Random matrices and measurability

This module provides the first shared interface for the project's random
matrix, random Jacobian, and matrix-cocycle tracks. A random matrix is a
matrix-valued map on a sample space. Its target carries the entrywise product
measurable space, so matrix measurability is equivalent to measurability of
every coordinate random variable.

The index types remain general here. Later ensemble modules will specialize to
finite index types such as `Fin n`.
-/

open Matrix MeasureTheory
open scoped Matrix

universe uΩ uι uκ uρ u𝕜 u𝕝

namespace NonlinearDynamics.Random

/-- A matrix-valued random variable before imposing measurability or a law. -/
abbrev RandomMatrix
    (Ω : Type uΩ) (ι : Type uι) (κ : Type uκ) (𝕜 : Type u𝕜) :=
  Ω → Matrix ι κ 𝕜

namespace RandomMatrix

variable {Ω : Type uΩ} {ι : Type uι} {κ : Type uκ} {𝕜 : Type u𝕜}

/-- The entrywise product measurable space on matrices. -/
instance instMeasurableSpaceMatrix [MeasurableSpace 𝕜] : MeasurableSpace (Matrix ι κ 𝕜) :=
  MeasurableSpace.comap Matrix.of.symm inferInstance

variable [MeasurableSpace Ω] [MeasurableSpace 𝕜]

/-- A matrix-valued map is measurable exactly when all of its entries are measurable. -/
theorem measurable_iff_entries (X : RandomMatrix Ω ι κ 𝕜) :
    Measurable X ↔ ∀ i j, Measurable fun ω ↦ X ω i j := by
  rw [measurable_comap_iff]
  change Measurable (fun ω i j ↦ X ω i j) ↔ _
  simp only [measurable_pi_iff]

/-- Every coordinate of a measurable random matrix is a measurable random variable. -/
theorem measurable_entry {X : RandomMatrix Ω ι κ 𝕜} (hX : Measurable X) (i : ι) (j : κ) :
    Measurable fun ω ↦ X ω i j :=
  (measurable_iff_entries X).mp hX i j

/-- Transposing a measurable random matrix preserves measurability. -/
theorem measurable_transpose {X : RandomMatrix Ω ι κ 𝕜} (hX : Measurable X) :
    Measurable fun ω ↦ (X ω).transpose := by
  rw [measurable_iff_entries]
  exact fun i j ↦ measurable_entry hX j i

/-- Applying a measurable scalar map entrywise preserves matrix measurability. -/
theorem measurable_map {𝕝 : Type u𝕝} [MeasurableSpace 𝕝]
    {X : RandomMatrix Ω ι κ 𝕜} (hX : Measurable X) {f : 𝕜 → 𝕝} (hf : Measurable f) :
    Measurable fun ω ↦ (X ω).map f := by
  rw [measurable_iff_entries]
  exact fun i j ↦ hf.comp (measurable_entry hX i j)

/-- A deterministic matrix, viewed as a constant random matrix, is measurable. -/
theorem measurable_const (A : Matrix ι κ 𝕜) :
    Measurable fun _ : Ω ↦ A := by
  rw [measurable_iff_entries]
  exact fun _ _ ↦ _root_.measurable_const

section Complex

variable {ρ : Type uρ}

/-- Taking the conjugate transpose of a measurable complex random matrix preserves
measurability. -/
theorem measurable_conjTranspose {X : RandomMatrix Ω ι κ ℂ} (hX : Measurable X) :
    Measurable fun ω ↦ (X ω)ᴴ := by
  rw [measurable_iff_entries]
  intro j i
  change Measurable (star ∘ fun ω ↦ X ω i j)
  exact continuous_star.measurable.comp (measurable_entry hX i j)

/-- Pointwise addition preserves measurability for complex random matrices. -/
theorem measurable_add {X Y : RandomMatrix Ω ι κ ℂ} (hX : Measurable X)
    (hY : Measurable Y) :
    Measurable fun ω ↦ X ω + Y ω := by
  rw [measurable_iff_entries]
  intro i j
  exact (measurable_entry hX i j).add (measurable_entry hY i j)

/-- Pointwise matrix multiplication preserves measurability when the shared index is finite. -/
theorem measurable_mul [Fintype κ] {X : RandomMatrix Ω ι κ ℂ}
    {Y : RandomMatrix Ω κ ρ ℂ} (hX : Measurable X) (hY : Measurable Y) :
    Measurable fun ω ↦ X ω * Y ω := by
  rw [measurable_iff_entries]
  intro i k
  simp only [Matrix.mul_apply]
  exact Finset.measurable_sum Finset.univ fun j _ ↦
    (measurable_entry hX i j).mul (measurable_entry hY j k)

/-- The unnormalized Hermitian symmetrization `X + Xᴴ` of a square complex random matrix. -/
def hermitianSymmetrization (X : RandomMatrix Ω ι ι ℂ) : RandomMatrix Ω ι ι ℂ :=
  fun ω ↦ X ω + (X ω)ᴴ

/-- Hermitian symmetrization preserves measurability. -/
theorem measurable_hermitianSymmetrization {X : RandomMatrix Ω ι ι ℂ} (hX : Measurable X) :
    Measurable (hermitianSymmetrization X) :=
  measurable_add hX (measurable_conjTranspose hX)

omit [MeasurableSpace Ω] [MeasurableSpace 𝕜] in
/-- Hermitian symmetrization produces a Hermitian matrix for every sample. -/
theorem hermitianSymmetrization_isHermitian (X : RandomMatrix Ω ι ι ℂ) (ω : Ω) :
    (hermitianSymmetrization X ω).IsHermitian := by
  simp [hermitianSymmetrization, Matrix.IsHermitian, add_comm]

/-- A complex random matrix is almost surely Hermitian with respect to `μ`. -/
def IsHermitianAE (X : RandomMatrix Ω ι ι ℂ) (μ : Measure Ω) : Prop :=
  ∀ᵐ ω ∂μ, (X ω).IsHermitian

/-- Hermitian symmetrization is Hermitian almost surely for every measure. -/
theorem hermitianSymmetrization_isHermitianAE (X : RandomMatrix Ω ι ι ℂ) (μ : Measure Ω) :
    IsHermitianAE (hermitianSymmetrization X) μ :=
  Filter.Eventually.of_forall (hermitianSymmetrization_isHermitian X)

end Complex

end RandomMatrix

end NonlinearDynamics.Random
