import Mathlib.LinearAlgebra.UnitaryGroup
import Mathlib.MeasureTheory.Measure.Dirac
import Mathlib.MeasureTheory.Measure.Typeclasses.Probability
import NonlinearDynamics.Random.RandomMatrices.Hermitian

/-!
# Laws of finite random matrices

This module introduces the distribution-level interface that sits above the
pointwise and almost-everywhere interfaces in `RandomMatrices.Basic` and
`RandomMatrices.Hermitian`.

For a measurable matrix-valued map `X : Ω → Matrix ι ι ℂ`, its law under a
measure `μ` is the pushforward `Measure.map X μ`. The measurability proof is an
explicit argument: the notation "law" must not obscure the hypothesis that
makes the pushforward behave as expected.

The deterministic map `congruence A H = A * H * Aᴴ` preserves Hermiticity for
every square matrix `A`. When `A` belongs to `Matrix.unitaryGroup ι ℂ`, this is
the usual unitary-conjugation action. Unitary-conjugation invariance is defined
here as equality of measures under every such pushforward. No ensemble is
asserted to satisfy that property.
-/

open Matrix MeasureTheory
open scoped Matrix

universe uΩ uι

namespace NonlinearDynamics.Random

namespace RandomMatrix

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]

/-- The deterministic congruence map `H ↦ A * H * Aᴴ` on square complex
matrices. No invertibility or unitarity assumption is needed for this map. -/
def congruence [Fintype ι] (A : Matrix ι ι ℂ) : Matrix ι ι ℂ → Matrix ι ι ℂ :=
  fun H ↦ A * H * Aᴴ

/-- Congruence by a fixed finite matrix is measurable for the entrywise
measurable space on matrices. -/
theorem measurable_congruence [Fintype ι] (A : Matrix ι ι ℂ) :
    Measurable (congruence A) := by
  exact measurable_mul
    (measurable_mul
      (measurable_const (A := A)) measurable_id)
    (measurable_const (A := Aᴴ))

/-- Congruence by the identity matrix is the identity action. -/
@[simp]
theorem congruence_one [Fintype ι] [DecidableEq ι] (H : Matrix ι ι ℂ) :
    congruence (1 : Matrix ι ι ℂ) H = H := by
  simp [congruence]

/-- Congruence sends the zero matrix to the zero matrix. -/
@[simp]
theorem congruence_zero [Fintype ι] (A : Matrix ι ι ℂ) :
    congruence A (0 : Matrix ι ι ℂ) = 0 := by
  simp [congruence]

/-- Congruence by a product is the composite of the two congruence maps. -/
theorem congruence_mul [Fintype ι] (A B H : Matrix ι ι ℂ) :
    congruence (A * B) H = congruence A (congruence B H) := by
  simp only [congruence, Matrix.conjTranspose_mul]
  simp only [Matrix.mul_assoc]

/-- Congruence preserves Hermiticity, without any invertibility assumption on
the fixed matrix. -/
theorem congruence_isHermitian [Fintype ι] (A : Matrix ι ι ℂ)
    {H : Matrix ι ι ℂ} (hH : H.IsHermitian) : (congruence A H).IsHermitian :=
  Matrix.isHermitian_mul_mul_conjTranspose A hH

/-- Pushing a measure forward by identity congruence leaves it unchanged. -/
@[simp]
theorem map_congruence_one [Fintype ι] [DecidableEq ι]
    (ν : Measure (Matrix ι ι ℂ)) :
    Measure.map (congruence (1 : Matrix ι ι ℂ)) ν = ν := by
  convert Measure.map_id using 2
  funext H
  exact congruence_one H

/-- The pushforward law of a measurable matrix-valued map.

The measurability proof is deliberately an explicit argument even though the
value of `Measure.map` itself does not store that proof. It supports the
standard pushforward evaluation and composition theorems below.
-/
noncomputable def law (X : RandomMatrix Ω ι ι ℂ) (_hX : Measurable X)
    (μ : Measure Ω) : Measure (Matrix ι ι ℂ) :=
  Measure.map X μ

/-- A matrix law evaluates a measurable set by taking its preimage under the
random matrix. -/
theorem law_apply (X : RandomMatrix Ω ι ι ℂ) (hX : Measurable X)
    (μ : Measure Ω) {s : Set (Matrix ι ι ℂ)} (hs : MeasurableSet s) :
    law X hX μ s = μ (X ⁻¹' s) := by
  exact Measure.map_apply hX hs

/-- The law of a measurable composite is the pushforward of the original law. -/
theorem law_comp {X : RandomMatrix Ω ι ι ℂ} (hX : Measurable X)
    {f : Matrix ι ι ℂ → Matrix ι ι ℂ} (hf : Measurable f) (μ : Measure Ω) :
    law (f ∘ X) (hf.comp hX) μ = Measure.map f (law X hX μ) := by
  exact (Measure.map_map hf hX).symm

/-- A probability measure on the sample space induces a probability law. -/
theorem law_isProbabilityMeasure (X : RandomMatrix Ω ι ι ℂ) (hX : Measurable X)
    (μ : Measure Ω) [IsProbabilityMeasure μ] : IsProbabilityMeasure (law X hX μ) :=
  Measure.isProbabilityMeasure_map hX.aemeasurable

/-- Under a Dirac measure on the sample space, the law is the Dirac measure at
the realized matrix. -/
theorem law_dirac (X : RandomMatrix Ω ι ι ℂ) (hX : Measurable X) (ω : Ω) :
    law X hX (Measure.dirac ω) = Measure.dirac (X ω) := by
  exact Measure.map_dirac' hX ω

/-- A finite complex matrix law is invariant under unitary conjugation when
every unitary congruence pushforward leaves it unchanged. -/
def IsUnitaryConjugationInvariant [Fintype ι] [DecidableEq ι]
    (ν : Measure (Matrix ι ι ℂ)) : Prop :=
  ∀ U : Matrix.unitaryGroup ι ℂ,
    Measure.map (congruence (U : Matrix ι ι ℂ)) ν = ν

/-- The zero measure is invariant under unitary conjugation. -/
theorem isUnitaryConjugationInvariant_zero [Fintype ι] [DecidableEq ι] :
    IsUnitaryConjugationInvariant (0 : Measure (Matrix ι ι ℂ)) := by
  intro U
  simp

/-- The Dirac measure at the zero matrix is invariant under unitary
conjugation. -/
theorem isUnitaryConjugationInvariant_dirac_zero [Fintype ι] [DecidableEq ι] :
    IsUnitaryConjugationInvariant
      (Measure.dirac (0 : Matrix ι ι ℂ)) := by
  intro U
  rw [Measure.map_dirac' (measurable_congruence (U : Matrix ι ι ℂ))]
  simp

end RandomMatrix

namespace HermitianRandomMatrix

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]

/-- The law of a bundled Hermitian random matrix. Its measurability evidence is
the corresponding field of the bundle. -/
noncomputable def law (X : HermitianRandomMatrix Ω ι) (μ : Measure Ω) :
    Measure (Matrix ι ι ℂ) :=
  RandomMatrix.law X.toRandomMatrix X.measurable_toRandomMatrix μ

/-- A probability measure on the sample space gives a probability law for a
bundled Hermitian random matrix. -/
theorem law_isProbabilityMeasure (X : HermitianRandomMatrix Ω ι) (μ : Measure Ω)
    [IsProbabilityMeasure μ] : IsProbabilityMeasure (law X μ) :=
  RandomMatrix.law_isProbabilityMeasure X.toRandomMatrix
    X.measurable_toRandomMatrix μ

/-- The law of `A X Aᴴ` is the congruence pushforward of the law of `X`. -/
theorem law_conjugateBy [Fintype ι] (A : Matrix ι ι ℂ)
    (X : HermitianRandomMatrix Ω ι) (μ : Measure Ω) :
    law (X.conjugateBy A) μ =
      Measure.map (RandomMatrix.congruence A) (law X μ) := by
  exact RandomMatrix.law_comp X.measurable_toRandomMatrix
    (RandomMatrix.measurable_congruence A) μ

/-- A bundled Hermitian random matrix has a unitary-conjugation-invariant law
under `μ` when its pushforward law has that measure-level property. -/
def HasUnitaryConjugationInvariantLaw [Fintype ι] [DecidableEq ι]
    (X : HermitianRandomMatrix Ω ι) (μ : Measure Ω) : Prop :=
  RandomMatrix.IsUnitaryConjugationInvariant (law X μ)

/-- Invariance of the law is equivalent to equality in law after conjugation
by every element of `Matrix.unitaryGroup`. -/
theorem hasUnitaryConjugationInvariantLaw_iff [Fintype ι] [DecidableEq ι]
    (X : HermitianRandomMatrix Ω ι) (μ : Measure Ω) :
    HasUnitaryConjugationInvariantLaw X μ ↔
      ∀ U : Matrix.unitaryGroup ι ℂ,
        law (X.conjugateBy (U : Matrix ι ι ℂ)) μ = law X μ := by
  simp only [HasUnitaryConjugationInvariantLaw,
    RandomMatrix.IsUnitaryConjugationInvariant, law_conjugateBy]

end HermitianRandomMatrix

end NonlinearDynamics.Random
