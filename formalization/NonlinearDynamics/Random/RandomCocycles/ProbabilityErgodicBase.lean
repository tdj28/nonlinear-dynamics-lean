import NonlinearDynamics.Random.RandomCocycles.IntegratedLogPlusGrowth
import Mathlib.Dynamics.Ergodic.Function

/-!
# Probability and ergodic-base interfaces for random cocycles

This module separates three roles that are easy to conflate. The explicit
one-step log-positive integrability hypothesis controls every finite horizon.
`IsProbabilityMeasure μ` fixes the mass of the base measure at one and thereby
licenses expectation terminology. `Ergodic C.base μ` makes invariant events
and observables rigid. None of these assumptions, separately or together,
constructs a samplewise limit.

The deterministic Fekete rate from the preceding module is nonnegative, is the
infimum over positive normalized horizons, and is bounded above by every such
horizon. These facts need integrability but neither probability nor
ergodicity. The probability-specialized expectation below is definitionally
the same number as the raw integral; its extra assumptions are semantic and
analytic gates, not a numerical rescaling.

The finite-horizon log-positive family is also packaged as an integrable
subadditive-process candidate. The package records exactly integrability and
the shifted pointwise inequality. Measure preservation remains in the cocycle,
and ergodicity remains a separate hypothesis. The pinned Mathlib release has
no Kingman theorem, so this module proves no almost-sure convergence,
limit-integral interchange, Lyapunov exponent, or Oseledets splitting.
-/

open MeasureTheory Set Filter

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ uι

/-- A checked finite-time predicate recording integrability and the shifted
subadditive inequality for a one-sided real process. Measure preservation,
probability, and ergodicity remain separate assumptions. -/
structure IsIntegrableSubadditiveProcessCandidate
    {Ω : Type uΩ} [MeasurableSpace Ω] (T : Ω → Ω) (μ : Measure Ω)
    (X : ℕ → Ω → ℝ) : Prop where
  integrable : ∀ k, Integrable (X k) μ
  add_le : ∀ m k ω, X (m + k) ω ≤ X k (T^[m] ω) + X m ω

namespace DiscreteMatrixCocycle

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-- The log-positive cocycle family satisfies the finite-horizon integrability
and shifted inequality expected of a subadditive-process candidate. -/
theorem HasIntegrableGeneratorLogPlus.isIntegrableSubadditiveProcessCandidate
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) :
    IsIntegrableSubadditiveProcessCandidate C.base μ
      C.logPlusNormObservable where
  integrable := hC.integrable_logPlusNormObservable
  add_le := C.logPlusNormObservable_add_le

/-- The deterministic integrated growth rate is nonnegative. -/
theorem HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_nonneg
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) :
    0 ≤ C.integratedLogPlusGrowthRate hC := by
  apply ge_of_tendsto hC.tendsto_normalizedIntegratedLogPlusNorm
  exact Filter.Eventually.of_forall C.normalizedIntegratedLogPlusNorm_nonneg

/-- The rate is the infimum of the normalized integrated values over positive
horizons. Time zero is not part of this infimum. -/
theorem HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_eq_sInf
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) :
    C.integratedLogPlusGrowthRate hC =
      sInf (C.normalizedIntegratedLogPlusNorm '' Ici 1) := by
  rw [integratedLogPlusGrowthRate, Subadditive.lim]
  rfl

/-- Every positive-horizon normalized value is an upper bound for the
deterministic integrated growth rate. -/
theorem HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_le_normalized
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) {k : ℕ} (hk : k ≠ 0) :
    C.integratedLogPlusGrowthRate hC ≤
      C.normalizedIntegratedLogPlusNorm k := by
  simpa [integratedLogPlusGrowthRate, normalizedIntegratedLogPlusNorm] using
    hC.subadditive_integratedLogPlusNorm.lim_le_div
      C.bddBelow_normalizedIntegratedLogPlusNorm hk

/-- The one-step integrated expansion envelope bounds the deterministic rate
from above. -/
theorem HasIntegrableGeneratorLogPlus.integratedLogPlusGrowthRate_le_oneStep
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) :
    C.integratedLogPlusGrowthRate hC ≤ C.integratedLogPlusNorm 1 := by
  simpa [normalizedIntegratedLogPlusNorm] using
    hC.integratedLogPlusGrowthRate_le_normalized (k := 1) one_ne_zero

/-- On a probability space and under the explicit integrability hypothesis,
the finite-horizon raw integral may be exposed as an expectation. -/
def finiteHorizonLogPlusExpectation [IsProbabilityMeasure μ]
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (_hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) : ℝ :=
  ∫ ω, C.logPlusNormObservable k ω ∂μ

/-- The probability-specialized expectation is the same scalar as the
underlying raw integral. -/
@[simp] theorem finiteHorizonLogPlusExpectation_eq_integratedLogPlusNorm
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) :
    C.finiteHorizonLogPlusExpectation hC k = C.integratedLogPlusNorm k := by
  rfl

omit [Fintype ι] [DecidableEq ι] in
/-- A measurable event strictly invariant under an ergodic probability base
has probability zero or one. -/
theorem ergodicBase_invariantEvent_prob_eq_zero_or_one
    [IsProbabilityMeasure μ]
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (hErg : Ergodic C.base μ) {s : Set Ω}
    (hs : MeasurableSet s) (hinv : C.base ⁻¹' s = s) :
    μ s = 0 ∨ μ s = 1 :=
  hErg.toPreErgodic.prob_eq_zero_or_one hs hinv

omit [Fintype ι] [DecidableEq ι] in
/-- Every a.e. strongly measurable real observable that is invariant almost
everywhere under an ergodic base is almost everywhere constant. -/
theorem ergodicBase_ae_eq_const_of_ae_invariant
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (hErg : Ergodic C.base μ) {g : Ω → ℝ}
    (hg : AEStronglyMeasurable g μ)
    (hinv : g ∘ C.base =ᵐ[μ] g) :
    ∃ c : ℝ, g =ᵐ[μ] Function.const Ω c :=
  hErg.ae_eq_const_of_ae_eq_comp_ae hg hinv

end DiscreteMatrixCocycle

end NonlinearDynamics.Random.RandomCocycles
