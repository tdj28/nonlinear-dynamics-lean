import NonlinearDynamics.Random.MatrixProducts.MeasurableFiniteProducts
import Mathlib.Dynamics.Ergodic.MeasurePreserving

/-!
# One-sided discrete matrix cocycles

This module builds the first cocycle layer above measurable finite products. A
base map `T` advances the environment, a matrix generator `A` is sampled along
the orbit `ω, T ω, T^[2] ω, ...`, and the resulting finite product keeps the
project's newest-factor-left convention. The exact one-sided cocycle identity
therefore places the shifted later block on the left.

The pointwise algebra works over an arbitrary semiring. The measurable layer
specializes to complex matrices and packages a generator-presented cocycle
over a measure-preserving base. Empty matrix dimension remains valid.

This finite-time, one-sided interface asserts no probability normalization,
ergodicity, mixing, independence, identical distribution, invertibility,
negative-time extension, skew-product invariance, law factorization, norm or
log-norm integrability, Lyapunov exponent, Oseledets theorem, asymptotic limit,
or random-Jacobian bridge.
-/

open Matrix MeasureTheory

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ uι u𝕜

variable {Ω : Type uΩ} {ι : Type uι} {𝕜 : Type u𝕜}
  [Fintype ι] [DecidableEq ι]

section Algebra

variable [Semiring 𝕜]

/-- The matrix generator observed along the forward orbit of a base map. -/
def orbitMatrixSequence (T : Ω → Ω) (A : RandomMatrix Ω ι ι 𝕜) :
    ℕ → RandomMatrix Ω ι ι 𝕜 :=
  fun j ω => A (T^[j] ω)

/-- The newest-factor-left product generated along a forward base orbit. -/
def cocycleProduct (T : Ω → Ω) (A : RandomMatrix Ω ι ι 𝕜) (k : ℕ) :
    RandomMatrix Ω ι ι 𝕜 :=
  MatrixProducts.sampleForwardProduct (orbitMatrixSequence T A) k

@[simp] theorem cocycleProduct_zero (T : Ω → Ω)
    (A : RandomMatrix Ω ι ι 𝕜) :
    cocycleProduct T A 0 = fun _ => 1 := rfl

@[simp] theorem cocycleProduct_succ (T : Ω → Ω)
    (A : RandomMatrix Ω ι ι 𝕜) (k : ℕ) :
    cocycleProduct T A (k + 1) =
      fun ω => A (T^[k] ω) * cocycleProduct T A k ω := rfl

@[simp] theorem cocycleProduct_one (T : Ω → Ω)
    (A : RandomMatrix Ω ι ι 𝕜) :
    cocycleProduct T A 1 = A := by
  funext ω
  simp [cocycleProduct, orbitMatrixSequence]

/-- The one-sided cocycle identity, with the later block on the left. -/
theorem cocycleProduct_add (T : Ω → Ω)
    (A : RandomMatrix Ω ι ι 𝕜) (m k : ℕ) (ω : Ω) :
    cocycleProduct T A (m + k) ω =
      cocycleProduct T A k (T^[m] ω) * cocycleProduct T A m ω := by
  induction k with
  | zero => simp
  | succ k ih =>
      have hiterate : T^[m + k] ω = T^[k] (T^[m] ω) := by
        rw [Nat.add_comm m k, Function.iterate_add_apply]
      rw [Nat.add_succ, cocycleProduct_succ, cocycleProduct_succ]
      simp only
      rw [ih, hiterate]
      simp only [mul_assoc]

end Algebra

section Measurable

variable [MeasurableSpace Ω]

omit [Fintype ι] [DecidableEq ι] in
/-- Every generator observed at a finite base iterate is measurable. -/
theorem measurable_orbitMatrixSequence (T : Ω → Ω)
    (A : RandomMatrix Ω ι ι ℂ) (hT : Measurable T) (hA : Measurable A)
    (j : ℕ) : Measurable (orbitMatrixSequence T A j) :=
  hA.comp (hT.iterate j)

/-- Every finite cocycle product is measurable. -/
theorem measurable_cocycleProduct (T : Ω → Ω)
    (A : RandomMatrix Ω ι ι ℂ) (hT : Measurable T) (hA : Measurable A)
    (k : ℕ) : Measurable (cocycleProduct T A k) := by
  exact MatrixProducts.measurable_sampleForwardProduct
    (orbitMatrixSequence T A) k fun j _ =>
      measurable_orbitMatrixSequence T A hT hA j

/-- A generator-presented, one-sided complex matrix cocycle over a
measure-preserving base. -/
structure DiscreteMatrixCocycle (μ : Measure Ω) where
  base : Ω → Ω
  generator : RandomMatrix Ω ι ι ℂ
  base_preserving : MeasurePreserving base μ μ
  measurable_generator : Measurable generator

namespace DiscreteMatrixCocycle

variable {μ : Measure Ω}

/-- The finite cocycle value generated along the base orbit. -/
def value (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    RandomMatrix Ω ι ι ℂ :=
  cocycleProduct C.base C.generator k

@[simp] theorem value_zero (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.value 0 = fun _ => 1 := rfl

@[simp] theorem value_one (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.value 1 = C.generator :=
  cocycleProduct_one C.base C.generator

@[simp] theorem value_succ (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    C.value (k + 1) =
      fun ω => C.generator (C.base^[k] ω) * C.value k ω := rfl

/-- The bundled cocycle law preserves the later-block-left convention. -/
theorem value_add (C : DiscreteMatrixCocycle (ι := ι) μ)
    (m k : ℕ) (ω : Ω) :
    C.value (m + k) ω =
      C.value k (C.base^[m] ω) * C.value m ω :=
  cocycleProduct_add C.base C.generator m k ω

/-- Every finite bundled cocycle value is an ordinarily measurable map. -/
theorem measurable_value (C : DiscreteMatrixCocycle (ι := ι) μ) (k : ℕ) :
    Measurable (C.value k) :=
  measurable_cocycleProduct C.base C.generator
    C.base_preserving.measurable C.measurable_generator k

omit [Fintype ι] [DecidableEq ι] in
/-- Every natural-number iterate of the bundled base preserves its measure. -/
theorem base_iterate_preserving (C : DiscreteMatrixCocycle (ι := ι) μ)
    (k : ℕ) : MeasurePreserving C.base^[k] μ μ :=
  C.base_preserving.iterate k

end DiscreteMatrixCocycle

end Measurable

end NonlinearDynamics.Random.RandomCocycles
