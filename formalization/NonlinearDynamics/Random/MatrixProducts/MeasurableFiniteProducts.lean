import NonlinearDynamics.Random.MatrixProducts.FiniteProducts
import NonlinearDynamics.Random.RandomMatrices.Laws
import Mathlib.MeasureTheory.Measure.ProbabilityMeasure

/-!
# Measurable finite random-matrix products

This module adds the first probabilistic layer above ordered deterministic
products. The pointwise algebra remains available over an arbitrary semiring.
For complex random matrices, explicit prefix measurability proves that every
finite sample product is measurable and therefore has a proof-carrying
pushforward law.

The measurability evidence is part of the law interface deliberately:
Mathlib's total `Measure.map` falls back to the zero measure outside its
almost-everywhere-measurable branch. A definition called a law must not hide
that boundary.

Only finite-time products occur here. No independence, stationarity, law
factorization, base transformation, cocycle, integrability, logarithmic
growth, Lyapunov exponent, or asymptotic theorem is introduced.
-/

open Matrix MeasureTheory

namespace NonlinearDynamics.Random.MatrixProducts

universe uΩ uι u𝕜

variable {Ω : Type uΩ} {ι : Type uι} {𝕜 : Type u𝕜}
  [Fintype ι] [DecidableEq ι]

section Algebra

variable [Semiring 𝕜]

/-- The pointwise forward product of a time-indexed matrix-valued map. -/
def sampleForwardProduct (A : ℕ → RandomMatrix Ω ι ι 𝕜) (k : ℕ) :
    RandomMatrix Ω ι ι 𝕜 :=
  fun ω => forwardProduct (fun j => A j ω) k

@[simp] theorem sampleForwardProduct_zero (A : ℕ → RandomMatrix Ω ι ι 𝕜) :
    sampleForwardProduct A 0 = fun _ => 1 := rfl

@[simp] theorem sampleForwardProduct_succ
    (A : ℕ → RandomMatrix Ω ι ι 𝕜) (k : ℕ) :
    sampleForwardProduct A (k + 1) =
      fun ω => A k ω * sampleForwardProduct A k ω := rfl

@[simp] theorem sampleForwardProduct_one (A : ℕ → RandomMatrix Ω ι ι 𝕜) :
    sampleForwardProduct A 1 = A 0 := by
  funext ω
  simp [sampleForwardProduct]

/-- The pointwise random product inherits the deterministic shifted split. -/
theorem sampleForwardProduct_add (A : ℕ → RandomMatrix Ω ι ι 𝕜) (m k : ℕ) :
    sampleForwardProduct A (m + k) =
      fun ω => sampleForwardProduct (fun j => A (m + j)) k ω *
        sampleForwardProduct A m ω := by
  funext ω
  exact forwardProduct_add (fun j => A j ω) m k

end Algebra

section Measurable

variable [MeasurableSpace Ω]

/-- A finite sample product is measurable when every factor in its prefix is
measurable. -/
theorem measurable_sampleForwardProduct (A : ℕ → RandomMatrix Ω ι ι ℂ)
    (k : ℕ) (hA : ∀ j < k, Measurable (A j)) :
    Measurable (sampleForwardProduct A k) := by
  induction k with
  | zero =>
      rw [sampleForwardProduct_zero]
      exact RandomMatrix.measurable_const 1
  | succ k ih =>
      rw [sampleForwardProduct_succ]
      exact RandomMatrix.measurable_mul
        (hA k (Nat.lt_succ_self k))
        (ih fun j hj => hA j (Nat.lt_succ_of_lt hj))

/-- The pushforward law of a finite sample forward product. -/
noncomputable def forwardProductLaw (μ : Measure Ω)
    (A : ℕ → RandomMatrix Ω ι ι ℂ)
    (k : ℕ) (hA : ∀ j < k, Measurable (A j)) :
    Measure (Matrix ι ι ℂ) :=
  RandomMatrix.law (sampleForwardProduct A k)
    (measurable_sampleForwardProduct A k hA) μ

@[simp] theorem forwardProductLaw_zero (μ : Measure Ω)
    [IsProbabilityMeasure μ] (A : ℕ → RandomMatrix Ω ι ι ℂ)
    (hA : ∀ j < 0, Measurable (A j)) :
    forwardProductLaw μ A 0 hA = Measure.dirac 1 := by
  simp [forwardProductLaw, RandomMatrix.law]

@[simp] theorem forwardProductLaw_one (μ : Measure Ω)
    (A : ℕ → RandomMatrix Ω ι ι ℂ)
    (hA : ∀ j < 1, Measurable (A j)) :
    forwardProductLaw μ A 1 hA =
      RandomMatrix.law (A 0) (hA 0 Nat.zero_lt_one) μ := by
  simp [forwardProductLaw, RandomMatrix.law]

/-- A probability source gives every measurable finite product law total mass
one. -/
theorem forwardProductLaw_isProbabilityMeasure (μ : Measure Ω)
    [IsProbabilityMeasure μ] (A : ℕ → RandomMatrix Ω ι ι ℂ) (k : ℕ)
    (hA : ∀ j < k, Measurable (A j)) :
    IsProbabilityMeasure (forwardProductLaw μ A k hA) := by
  exact RandomMatrix.law_isProbabilityMeasure (sampleForwardProduct A k)
    (measurable_sampleForwardProduct A k hA) μ

/-- A measurable finite product law bundled as a probability measure. -/
noncomputable def forwardProductProbabilityLaw (μ : ProbabilityMeasure Ω)
    (A : ℕ → RandomMatrix Ω ι ι ℂ) (k : ℕ)
    (hA : ∀ j < k, Measurable (A j)) :
    ProbabilityMeasure (Matrix ι ι ℂ) :=
  ⟨forwardProductLaw (μ : Measure Ω) A k hA,
    forwardProductLaw_isProbabilityMeasure (μ : Measure Ω) A k hA⟩

/-- Forgetting the probability wrapper recovers the raw forward-product law. -/
@[simp] theorem coe_forwardProductProbabilityLaw (μ : ProbabilityMeasure Ω)
    (A : ℕ → RandomMatrix Ω ι ι ℂ) (k : ℕ)
    (hA : ∀ j < k, Measurable (A j)) :
    ((forwardProductProbabilityLaw μ A k hA :
      ProbabilityMeasure (Matrix ι ι ℂ)) : Measure (Matrix ι ι ℂ)) =
      forwardProductLaw (μ : Measure Ω) A k hA := rfl

end Measurable

end NonlinearDynamics.Random.MatrixProducts
