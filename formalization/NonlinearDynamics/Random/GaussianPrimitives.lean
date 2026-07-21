import Mathlib.Probability.Distributions.Gaussian.HasGaussianLaw.Independence

/-!
# Gaussian primitive random variables

This module supplies exact law-level building blocks for later finite random
matrix ensembles. `HasRealGaussianLaw X m v P` records that `X` has the
Mathlib law `gaussianReal m v` under `P`, where `v : ℝ≥0` is the variance.
In particular, `v = 0` is preserved as the Dirac law at `m`.

The exact parameterized law comes before the qualitative predicate
`HasGaussianLaw`. The distinction matters: `HasGaussianLaw` says that a law
is Gaussian, but it does not retain a chosen mean and variance as parameters.

`HasLaw` contains an `AEMeasurable` field. It does not imply ordinary
`Measurable`, so no theorem below silently upgrades almost-everywhere
measurability. `IndependentRealGaussianFamily` therefore records ordinary
coordinate measurability as separate data. The canonical coordinate
projections used at the end of the module satisfy that field through
Mathlib's `measurable_pi_apply`.

This module deliberately makes no complex-Gaussian, matrix-ensemble, GUE,
density, spectral, expectation-of-matrix-observable, or asymptotic claim.
-/

open MeasureTheory ProbabilityTheory
open scoped ENNReal NNReal ProbabilityTheory

universe uΩ uι

namespace NonlinearDynamics.Random

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]

/-- `X` has the real Gaussian law with mean `m` and variance `v` under `P`.

The variance parameter is an `NNReal`. At variance zero, Mathlib's
`gaussianReal m 0` is the Dirac measure at `m`.
-/
def HasRealGaussianLaw (X : Ω → ℝ) (m : ℝ) (v : ℝ≥0) (P : Measure Ω) : Prop :=
  HasLaw X (gaussianReal m v) P

namespace HasRealGaussianLaw

variable {X Y : Ω → ℝ} {m mX mY : ℝ} {v vX vY : ℝ≥0} {P : Measure Ω}

/-- An exact real Gaussian law supplies almost-everywhere measurability.

This conclusion is intentionally weaker than ordinary `Measurable X`.
-/
theorem aemeasurable (hX : HasRealGaussianLaw X m v P) : AEMeasurable X P :=
  ProbabilityTheory.HasLaw.aemeasurable hX

/-- A measure supporting a random variable with an exact Gaussian probability
law is itself a probability measure. -/
theorem isProbabilityMeasure (hX : HasRealGaussianLaw X m v P) : IsProbabilityMeasure P :=
  ProbabilityTheory.HasLaw.isProbabilityMeasure hX

/-- The expectation of a real random variable with exact Gaussian law is its
mean parameter. -/
theorem mean_eq (hX : HasRealGaussianLaw X m v P) : ∫ ω, X ω ∂P = m := by
  rw [ProbabilityTheory.HasLaw.integral_eq hX, integral_id_gaussianReal]

/-- The variance of a real random variable with exact Gaussian law is its
variance parameter, coerced from `NNReal` to `Real`. -/
theorem variance_eq (hX : HasRealGaussianLaw X m v P) : Var[X; P] = (v : ℝ) := by
  simpa using ProbabilityTheory.HasLaw.variance_eq hX

/-- Forgetting the explicit mean and variance leaves a qualitative Gaussian
law. -/
theorem hasGaussianLaw (hX : HasRealGaussianLaw X m v P) : HasGaussianLaw X P :=
  ProbabilityTheory.HasLaw.hasGaussianLaw hX

/-- A real random variable with exact Gaussian law satisfies `MemLp X p P`
for every exponent `p ≠ ∞`, including Mathlib's `p = 0` case. -/
theorem memLp (hX : HasRealGaussianLaw X m v P) (p : ℝ≥0∞) (hp : p ≠ ∞) :
    MemLp X p P :=
  (hasGaussianLaw hX).memLp hp

/-- A real random variable with exact Gaussian law is integrable. -/
theorem integrable (hX : HasRealGaussianLaw X m v P) : Integrable X P :=
  (hasGaussianLaw hX).integrable

/-- A zero-variance Gaussian random variable equals its mean almost
everywhere. -/
theorem ae_eq_const_of_variance_zero (hX : HasRealGaussianLaw X m 0 P) :
    X =ᵐ[P] fun _ ↦ m := by
  apply ProbabilityTheory.HasLaw.ae_eq_of_dirac
  simpa only [HasRealGaussianLaw, gaussianReal_zero_var] using hX

/-- Under a probability measure, having the zero-variance Gaussian law is
equivalent to being almost everywhere equal to the mean. -/
theorem zero_variance_iff [IsProbabilityMeasure P] :
    HasRealGaussianLaw X m 0 P ↔ X =ᵐ[P] fun _ ↦ m := by
  rw [HasRealGaussianLaw, gaussianReal_zero_var, hasLaw_dirac_iff]

/-- Scaling a real Gaussian random variable by `c` scales its mean by `c` and
its variance by `c²`.

The `NNReal` constructor records the proof that `c²` is nonnegative. This
statement also covers `c = 0`, yielding the correct zero-variance Dirac law.
-/
theorem const_mul (hX : HasRealGaussianLaw X m v P) (c : ℝ) :
    HasRealGaussianLaw (fun ω ↦ c * X ω) (c * m)
      (⟨c ^ 2, sq_nonneg c⟩ * v) P :=
  gaussianReal_const_mul hX c

/-- The sum of two independent real Gaussian random variables has the sum of
their means and the sum of their variances. -/
theorem add_of_indep (hX : HasRealGaussianLaw X mX vX P)
    (hY : HasRealGaussianLaw Y mY vY P) (hXY : IndepFun X Y P) :
    HasRealGaussianLaw (fun ω ↦ X ω + Y ω) (mX + mY) (vX + vY) P := by
  simpa only [HasRealGaussianLaw, gaussianReal_conv_gaussianReal] using
    hXY.hasLaw_fun_add hX hY

end HasRealGaussianLaw

/-- A family of mutually independent real random variables with explicit
Gaussian means and variances.

The family itself may have any index type. Finite-product conclusions below
add a `Fintype` assumption only where Mathlib's finite product measure needs
one.
-/
structure IndependentRealGaussianFamily (X : ι → Ω → ℝ) (m : ι → ℝ)
    (v : ι → ℝ≥0) (P : Measure Ω) : Prop where
  /-- Every coordinate is an ordinarily measurable sample map. This is kept
  separate from the almost-everywhere measurability contained in `HasLaw`. -/
  measurable : ∀ i, Measurable (X i)
  /-- Every coordinate has its specified real Gaussian law. -/
  hasLaw : ∀ i, HasRealGaussianLaw (X i) (m i) (v i) P
  /-- The coordinate random variables are mutually independent under `P`. -/
  independent : iIndepFun X P

namespace IndependentRealGaussianFamily

variable {X : ι → Ω → ℝ} {m : ι → ℝ} {v : ι → ℝ≥0} {P : Measure Ω}

/-- Every coordinate in an independent Gaussian family is almost-everywhere
measurable. -/
theorem aemeasurable (hX : IndependentRealGaussianFamily X m v P) (i : ι) :
    AEMeasurable (X i) P :=
  (hX.measurable i).aemeasurable

/-- The base measure of an independent Gaussian family is a probability
measure. -/
theorem isProbabilityMeasure (hX : IndependentRealGaussianFamily X m v P) :
    IsProbabilityMeasure P :=
  hX.independent.isProbabilityMeasure

/-- Each coordinate has its specified mean. -/
theorem mean_eq (hX : IndependentRealGaussianFamily X m v P) (i : ι) :
    ∫ ω, X i ω ∂P = m i :=
  (hX.hasLaw i).mean_eq

/-- Each coordinate has its specified variance. -/
theorem variance_eq (hX : IndependentRealGaussianFamily X m v P) (i : ι) :
    Var[X i; P] = (v i : ℝ) :=
  (hX.hasLaw i).variance_eq

/-- Coordinatewise deterministic scaling preserves ordinary measurability,
the exact Gaussian coordinate laws, and mutual independence.

The variance in coordinate `i` is multiplied by `(c i)²`. Zero scale
factors are allowed and produce the corresponding zero-variance Dirac laws.
-/
theorem scale (hX : IndependentRealGaussianFamily X m v P) (c : ι → ℝ) :
    IndependentRealGaussianFamily (fun i ω ↦ c i * X i ω)
      (fun i ↦ c i * m i) (fun i ↦ ⟨(c i) ^ 2, sq_nonneg (c i)⟩ * v i) P := by
  refine ⟨fun i ↦ (hX.measurable i).const_mul (c i),
    fun i ↦ (hX.hasLaw i).const_mul (c i), ?_⟩
  simpa only [Function.comp_def] using
    hX.independent.comp (fun i x ↦ c i * x) (fun i ↦ measurable_const_mul (c i))

variable [Fintype ι]

/-- A finite independent Gaussian family has the exact product of its
coordinate Gaussian laws as its joint law. -/
theorem jointHasLaw (hX : IndependentRealGaussianFamily X m v P) :
    HasLaw (fun ω i ↦ X i ω) (Measure.pi fun i ↦ gaussianReal (m i) (v i)) P :=
  hX.independent.hasLaw_pi hX.hasLaw

/-- A finite independent Gaussian family is jointly Gaussian after forgetting
the explicit coordinate parameters. -/
theorem jointHasGaussianLaw (hX : IndependentRealGaussianFamily X m v P) :
    HasGaussianLaw (fun ω i ↦ X i ω) P :=
  hX.independent.hasGaussianLaw fun i ↦ (hX.hasLaw i).hasGaussianLaw

end IndependentRealGaussianFamily

/-- The canonical finite product measure with coordinate laws
`gaussianReal (m i) (v i)`.

For an empty finite index type this is the Dirac measure at the unique empty
tuple. This convention concerns a scalar product space only; it does not choose
the later policy for zero-dimensional matrix ensembles.
-/
noncomputable def gaussianProductMeasure [Fintype ι] (m : ι → ℝ) (v : ι → ℝ≥0) :
    Measure (ι → ℝ) :=
  Measure.pi fun i ↦ gaussianReal (m i) (v i)

/-- A finite product of real Gaussian probability measures is a probability
measure. -/
instance instIsProbabilityMeasureGaussianProduct [Fintype ι]
    (m : ι → ℝ) (v : ι → ℝ≥0) :
    IsProbabilityMeasure (gaussianProductMeasure m v) := by
  unfold gaussianProductMeasure
  infer_instance

/-- Under the canonical Gaussian product measure, evaluation at `i` has the
specified Gaussian law. -/
theorem gaussianProductMeasure_hasLaw_eval [Fintype ι]
    (m : ι → ℝ) (v : ι → ℝ≥0) (i : ι) :
    HasRealGaussianLaw (fun x : ι → ℝ ↦ x i) (m i) (v i)
      (gaussianProductMeasure m v) := by
  exact (measurePreserving_eval (fun i ↦ gaussianReal (m i) (v i)) i).hasLaw

/-- Coordinate evaluations are mutually independent under the canonical
Gaussian product measure. -/
theorem gaussianProductMeasure_iIndepFun [Fintype ι]
    (m : ι → ℝ) (v : ι → ℝ≥0) :
    iIndepFun (fun i (x : ι → ℝ) ↦ x i) (gaussianProductMeasure m v) := by
  exact iIndepFun_pi (μ := fun i ↦ gaussianReal (m i) (v i))
    (X := fun _ ↦ id) fun _ ↦ aemeasurable_id

/-- The coordinate projections on the canonical product sample space form an
independent real Gaussian family with the requested parameters. -/
theorem gaussianProductMeasure_independentFamily [Fintype ι]
    (m : ι → ℝ) (v : ι → ℝ≥0) :
    IndependentRealGaussianFamily (fun i (x : ι → ℝ) ↦ x i) m v
      (gaussianProductMeasure m v) :=
  ⟨fun i ↦ measurable_pi_apply i,
    gaussianProductMeasure_hasLaw_eval m v,
    gaussianProductMeasure_iIndepFun m v⟩

end NonlinearDynamics.Random
