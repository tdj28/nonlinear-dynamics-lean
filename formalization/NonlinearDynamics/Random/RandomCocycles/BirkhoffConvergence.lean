import NonlinearDynamics.Random.RandomCocycles.SubadditiveIntervalPacking
import Mathlib.Dynamics.BirkhoffSum.QuasiMeasurePreserving
import Mathlib.MeasureTheory.Constructions.Polish.Basic

/-!
# Finite Birkhoff averages and their conditional convergence event

This module supplies the finite measurability and integrability
infrastructure needed around Mathlib's `birkhoffSum` and totalized
`birkhoffAverage`.  It isolates the event on which the real averages converge,
proves representative independence and exact preimage invariance, and derives
conditional ergodic zero--one statements.

It deliberately proves no pointwise convergence-existence theorem, maximal
inequality, Kingman theorem, Lyapunov exponent, or Oseledets splitting.
-/

open MeasureTheory Set Filter

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ

variable {Ω : Type uΩ} [MeasurableSpace Ω]
  {T : Ω → Ω} {g h : Ω → ℝ} {μ : Measure Ω}

/-- A real finite-horizon Birkhoff sum is measurable when the dynamics and
observable are measurable. -/
theorem measurable_birkhoffSum (hT : Measurable T) (hg : Measurable g)
    (n : ℕ) : Measurable (birkhoffSum T g n) := by
  unfold birkhoffSum
  exact Finset.measurable_sum (Finset.range n) fun j _ ↦
    hg.comp (hT.iterate j)

/-- A real finite-horizon Birkhoff average is measurable, including the
totalized time-zero average. -/
theorem measurable_birkhoffAverage (hT : Measurable T)
    (hg : Measurable g) (n : ℕ) :
    Measurable (birkhoffAverage ℝ T g n) := by
  change Measurable (fun ω ↦ (n : ℝ)⁻¹ * birkhoffSum T g n ω)
  exact measurable_const.mul (measurable_birkhoffSum hT hg n)

/-- A real finite Birkhoff sum is integrable under measure preservation and
one-step integrability. -/
theorem integrable_birkhoffSum (hT : MeasurePreserving T μ μ)
    (hg : Integrable g μ) (n : ℕ) : Integrable (birkhoffSum T g n) μ := by
  change Integrable (fun ω ↦ ∑ j ∈ Finset.range n, g (T^[j] ω)) μ
  apply integrable_finsetSum
  intro j _hj
  change Integrable (g ∘ T^[j]) μ
  exact (hT.iterate j).integrable_comp_of_integrable hg

/-- A real finite Birkhoff average is integrable under measure preservation
and one-step integrability, including time zero. -/
theorem integrable_birkhoffAverage (hT : MeasurePreserving T μ μ)
    (hg : Integrable g μ) (n : ℕ) :
    Integrable (birkhoffAverage ℝ T g n) μ := by
  unfold birkhoffAverage
  exact (integrable_birkhoffSum hT hg n).const_mul _

/-- The set of points where the real Birkhoff averages converge to some
finite real limit.  This definition asserts no point belongs to the set. -/
def birkhoffConvergenceSet (T : Ω → Ω) (g : Ω → ℝ) : Set Ω :=
  {ω | ∃ c : ℝ, Tendsto (fun n ↦ birkhoffAverage ℝ T g n ω) atTop (nhds c)}

omit [MeasurableSpace Ω] in
/-- Membership in the convergence event is exactly the existence of a finite
real limit for the totalized Birkhoff-average sequence. -/
@[simp] theorem mem_birkhoffConvergenceSet_iff {ω : Ω} :
    ω ∈ birkhoffConvergenceSet T g ↔
      ∃ c : ℝ, Tendsto (fun n ↦ birkhoffAverage ℝ T g n ω) atTop (nhds c) := by
  rfl

/-- The convergence event is measurable for ordinarily measurable dynamics
and observable. -/
theorem measurableSet_birkhoffConvergenceSet
    (hT : Measurable T) (hg : Measurable g) :
    MeasurableSet (birkhoffConvergenceSet T g) := by
  exact MeasureTheory.measurableSet_exists_tendsto
    (fun n ↦ measurable_birkhoffAverage hT hg n)

/-- Quasi-measure preservation transports the convergence event across
almost-everywhere equal observable representatives. -/
theorem birkhoffConvergenceSet_ae_eq_of_ae_eq
    (hT : Measure.QuasiMeasurePreserving T μ μ) (hgh : g =ᵐ[μ] h) :
    birkhoffConvergenceSet T g =ᵐ[μ] birkhoffConvergenceSet T h := by
  have havg : ∀ᵐ ω ∂μ, ∀ n : ℕ,
      birkhoffAverage ℝ T g n ω = birkhoffAverage ℝ T h n ω := by
    rw [ae_all_iff]
    intro n
    exact hT.birkhoffAverage_ae_eq_of_ae_eq ℝ hgh n
  filter_upwards [havg] with ω hω
  apply propext
  change (∃ c : ℝ, Tendsto (fun n ↦ birkhoffAverage ℝ T g n ω) atTop (nhds c)) ↔
    ∃ c : ℝ, Tendsto (fun n ↦ birkhoffAverage ℝ T h n ω) atTop (nhds c)
  constructor
  · rintro ⟨c, hc⟩
    exact ⟨c, hc.congr' (Eventually.of_forall fun n ↦ hω n)⟩
  · rintro ⟨c, hc⟩
    exact ⟨c, hc.congr' (Eventually.of_forall fun n ↦ (hω n).symm)⟩

/-- An a.e. measurable real observable has a null-measurable convergence
event under quasi-measure-preserving dynamics. -/
theorem nullMeasurableSet_birkhoffConvergenceSet_of_aemeasurable
    (hg : AEMeasurable g μ)
    (hT : Measure.QuasiMeasurePreserving T μ μ) :
    NullMeasurableSet (birkhoffConvergenceSet T g) μ := by
  let g' := hg.mk g
  have hgm : Measurable g' := hg.measurable_mk
  have heq : g =ᵐ[μ] g' := hg.ae_eq_mk
  exact (measurableSet_birkhoffConvergenceSet hT.measurable hgm).nullMeasurableSet.congr
    (birkhoffConvergenceSet_ae_eq_of_ae_eq hT heq).symm

/-- The a.e.-strongly-measurable interface is an ergonomic corollary of the
a.e.-measurable representative theorem. -/
theorem nullMeasurableSet_birkhoffConvergenceSet_of_aestronglyMeasurable
    (hg : AEStronglyMeasurable g μ)
    (hT : Measure.QuasiMeasurePreserving T μ μ) :
    NullMeasurableSet (birkhoffConvergenceSet T g) μ :=
  nullMeasurableSet_birkhoffConvergenceSet_of_aemeasurable hg.aemeasurable hT

/-- Integrability is used only through a.e. strong measurability. -/
theorem nullMeasurableSet_birkhoffConvergenceSet_of_integrable
    (hg : Integrable g μ) (hT : Measure.QuasiMeasurePreserving T μ μ) :
    NullMeasurableSet (birkhoffConvergenceSet T g) μ :=
  nullMeasurableSet_birkhoffConvergenceSet_of_aestronglyMeasurable
    hg.aestronglyMeasurable hT

omit [MeasurableSpace Ω] in
/-- Positive-index shift identity expressing the average at `T ω` through
the next average at `ω`. -/
theorem birkhoffAverage_succ_apply_base (T : Ω → Ω) (g : Ω → ℝ)
    (n : ℕ) (ω : Ω) :
    birkhoffAverage ℝ T g (n + 1) (T ω) =
      ((n + 2 : ℕ) : ℝ) / ((n + 1 : ℕ) : ℝ) *
          birkhoffAverage ℝ T g (n + 2) ω -
        g ω / ((n + 1 : ℕ) : ℝ) := by
  rw [show n + 2 = (n + 1) + 1 by omega]
  simp only [birkhoffAverage, smul_eq_mul, birkhoffSum_succ']
  have hn1 : ((n + 1 : ℕ) : ℝ) ≠ 0 := by positivity
  have hn2 : (((n + 1) + 1 : ℕ) : ℝ) ≠ 0 := by positivity
  field_simp
  ring_nf

omit [MeasurableSpace Ω] in
/-- Convergence at a point implies convergence to the same limit after one
application of the base map. -/
theorem tendsto_birkhoffAverage_apply_base
    {T : Ω → Ω} {g : Ω → ℝ} {ω : Ω} {c : ℝ}
    (hconv : Tendsto (fun n ↦ birkhoffAverage ℝ T g n ω) atTop (nhds c)) :
    Tendsto (fun n ↦ birkhoffAverage ℝ T g n (T ω)) atTop (nhds c) := by
  have hratio : Tendsto
      (fun n : ℕ ↦ ((n + 2 : ℕ) : ℝ) / ((n + 1 : ℕ) : ℝ))
      atTop (nhds 1) := by
    have h := (tendsto_const_nhds :
      Tendsto (fun _ : ℕ ↦ (1 : ℝ)) atTop (nhds 1)).add
      (tendsto_one_div_add_atTop_nhds_zero_nat (𝕜 := ℝ))
    convert h using 1
    · funext n
      push_cast
      field_simp
      ring_nf
    · norm_num
  have hshift : Tendsto
      (fun n ↦ birkhoffAverage ℝ T g (n + 2) ω) atTop (nhds c) :=
    (tendsto_add_atTop_iff_nat 2).mpr hconv
  have hsmall : Tendsto
      (fun n : ℕ ↦ g ω / ((n + 1 : ℕ) : ℝ)) atTop (nhds 0) := by
    simpa only [Nat.cast_add, Nat.cast_one] using
      (tendsto_add_atTop_iff_nat 1).mpr
        (tendsto_const_div_atTop_nhds_zero_nat (g ω))
  apply (tendsto_add_atTop_iff_nat 1).mp
  convert (hratio.mul hshift).sub hsmall using 1
  · funext n
    exact birkhoffAverage_succ_apply_base T g n ω
  · ring_nf

omit [MeasurableSpace Ω] in
/-- Positive-index shift identity expressing the next average at `ω`
through the current average at `T ω`. -/
theorem birkhoffAverage_succ_succ_apply (T : Ω → Ω) (g : Ω → ℝ)
    (n : ℕ) (ω : Ω) :
    birkhoffAverage ℝ T g (n + 2) ω =
      g ω / ((n + 2 : ℕ) : ℝ) +
        ((n + 1 : ℕ) : ℝ) / ((n + 2 : ℕ) : ℝ) *
          birkhoffAverage ℝ T g (n + 1) (T ω) := by
  rw [show n + 2 = (n + 1) + 1 by omega]
  simp only [birkhoffAverage, smul_eq_mul, birkhoffSum_succ']
  have hn1 : ((n + 1 : ℕ) : ℝ) ≠ 0 := by positivity
  have hn2 : (((n + 1) + 1 : ℕ) : ℝ) ≠ 0 := by positivity
  field_simp

omit [MeasurableSpace Ω] in
/-- Convergence after one application of the base map implies convergence to
the same limit at the original point. -/
theorem tendsto_birkhoffAverage_of_apply_base
    {T : Ω → Ω} {g : Ω → ℝ} {ω : Ω} {c : ℝ}
    (hconv : Tendsto (fun n ↦ birkhoffAverage ℝ T g n (T ω)) atTop (nhds c)) :
    Tendsto (fun n ↦ birkhoffAverage ℝ T g n ω) atTop (nhds c) := by
  have hsmall : Tendsto
      (fun n : ℕ ↦ g ω / ((n + 2 : ℕ) : ℝ)) atTop (nhds 0) := by
    simpa only [Nat.cast_add, Nat.cast_ofNat] using
      (tendsto_add_atTop_iff_nat 2).mpr
        (tendsto_const_div_atTop_nhds_zero_nat (g ω))
  have hratio : Tendsto
      (fun n : ℕ ↦ ((n + 1 : ℕ) : ℝ) / ((n + 2 : ℕ) : ℝ))
      atTop (nhds 1) := by
    have h := (tendsto_natCast_div_add_atTop (1 : ℝ)).comp
      (tendsto_add_atTop_nat 1)
    convert h using 1
    funext n
    simp only [Function.comp_apply, Nat.cast_add, Nat.cast_one,
      Nat.cast_ofNat]
    ring_nf
  have hshift : Tendsto
      (fun n ↦ birkhoffAverage ℝ T g (n + 1) (T ω)) atTop (nhds c) :=
    (tendsto_add_atTop_iff_nat 1).mpr hconv
  apply (tendsto_add_atTop_iff_nat 2).mp
  convert hsmall.add (hratio.mul hshift) using 1
  · funext n
    exact birkhoffAverage_succ_succ_apply T g n ω
  · ring_nf

omit [MeasurableSpace Ω] in
/-- One application of the base map preserves both convergence and the exact
finite real limit. -/
theorem tendsto_birkhoffAverage_apply_base_iff
    {T : Ω → Ω} {g : Ω → ℝ} {ω : Ω} {c : ℝ} :
    Tendsto (fun n ↦ birkhoffAverage ℝ T g n (T ω)) atTop (nhds c) ↔
      Tendsto (fun n ↦ birkhoffAverage ℝ T g n ω) atTop (nhds c) :=
  ⟨tendsto_birkhoffAverage_of_apply_base, tendsto_birkhoffAverage_apply_base⟩

omit [MeasurableSpace Ω] in
/-- The convergence event is exactly preimage-invariant.  No injectivity,
surjectivity, measurability, or invertibility assumption is needed. -/
theorem preimage_birkhoffConvergenceSet (T : Ω → Ω) (g : Ω → ℝ) :
    T ⁻¹' birkhoffConvergenceSet T g = birkhoffConvergenceSet T g := by
  ext ω
  simp only [mem_preimage, mem_birkhoffConvergenceSet_iff]
  constructor
  · rintro ⟨c, hc⟩
    exact ⟨c, tendsto_birkhoffAverage_of_apply_base hc⟩
  · rintro ⟨c, hc⟩
    exact ⟨c, tendsto_birkhoffAverage_apply_base hc⟩

/-- The ordinarily measurable path needs only pre-ergodicity because event
invariance is exact. -/
theorem birkhoffConvergenceSet_ae_empty_or_univ_of_measurableSet
    (hT : PreErgodic T μ)
    (hset : MeasurableSet (birkhoffConvergenceSet T g)) :
    birkhoffConvergenceSet T g =ᵐ[μ] (∅ : Set Ω) ∨
      birkhoffConvergenceSet T g =ᵐ[μ] univ :=
  hT.ae_empty_or_univ hset (preimage_birkhoffConvergenceSet T g)

/-- The null-measurable path uses quasi-ergodicity. -/
theorem birkhoffConvergenceSet_ae_empty_or_univ_of_nullMeasurableSet
    (hT : QuasiErgodic T μ)
    (hset : NullMeasurableSet (birkhoffConvergenceSet T g) μ) :
    birkhoffConvergenceSet T g =ᵐ[μ] (∅ : Set Ω) ∨
      birkhoffConvergenceSet T g =ᵐ[μ] univ := by
  exact hT.ae_empty_or_univ₀ hset
    (Eventually.of_forall fun ω ↦ propext <| Set.ext_iff.mp
      (preimage_birkhoffConvergenceSet T g) ω)

/-- Conditional ergodic rigidity for an a.e. measurable observable. -/
theorem birkhoffConvergenceSet_ae_empty_or_univ_of_aemeasurable
    (hg : AEMeasurable g μ) (hT : QuasiErgodic T μ) :
    birkhoffConvergenceSet T g =ᵐ[μ] (∅ : Set Ω) ∨
      birkhoffConvergenceSet T g =ᵐ[μ] univ :=
  birkhoffConvergenceSet_ae_empty_or_univ_of_nullMeasurableSet hT
    (nullMeasurableSet_birkhoffConvergenceSet_of_aemeasurable hg
      hT.toQuasiMeasurePreserving)

/-- Conditional ergodic rigidity for an a.e. strongly measurable observable. -/
theorem birkhoffConvergenceSet_ae_empty_or_univ_of_aestronglyMeasurable
    (hg : AEStronglyMeasurable g μ) (hT : QuasiErgodic T μ) :
    birkhoffConvergenceSet T g =ᵐ[μ] (∅ : Set Ω) ∨
      birkhoffConvergenceSet T g =ᵐ[μ] univ :=
  birkhoffConvergenceSet_ae_empty_or_univ_of_aemeasurable hg.aemeasurable hT

/-- Conditional ergodic rigidity for an integrable observable. -/
theorem birkhoffConvergenceSet_ae_empty_or_univ_of_integrable
    (hg : Integrable g μ) (hT : QuasiErgodic T μ) :
    birkhoffConvergenceSet T g =ᵐ[μ] (∅ : Set Ω) ∨
      birkhoffConvergenceSet T g =ᵐ[μ] univ :=
  birkhoffConvergenceSet_ae_empty_or_univ_of_aestronglyMeasurable
    hg.aestronglyMeasurable hT

/-- On a probability space, the measurable/pre-ergodic path gives a zero--one
law for the convergence event. -/
theorem measure_birkhoffConvergenceSet_eq_zero_or_one_of_measurableSet
    [IsProbabilityMeasure μ] (hT : PreErgodic T μ)
    (hset : MeasurableSet (birkhoffConvergenceSet T g)) :
    μ (birkhoffConvergenceSet T g) = 0 ∨
      μ (birkhoffConvergenceSet T g) = 1 :=
  hT.prob_eq_zero_or_one hset (preimage_birkhoffConvergenceSet T g)

/-- On a probability space, the null-measurable/quasi-ergodic path also gives
a zero--one law. -/
theorem measure_birkhoffConvergenceSet_eq_zero_or_one_of_nullMeasurableSet
    [IsProbabilityMeasure μ] (hT : QuasiErgodic T μ)
    (hset : NullMeasurableSet (birkhoffConvergenceSet T g) μ) :
    μ (birkhoffConvergenceSet T g) = 0 ∨
      μ (birkhoffConvergenceSet T g) = 1 := by
  rcases birkhoffConvergenceSet_ae_empty_or_univ_of_nullMeasurableSet hT hset with
    hzero | hone
  · left
    exact ae_eq_empty.mp hzero
  · right
    simpa using measure_congr hone

/-- Probability zero--one corollary for an a.e. measurable observable. -/
theorem measure_birkhoffConvergenceSet_eq_zero_or_one_of_aemeasurable
    [IsProbabilityMeasure μ] (hg : AEMeasurable g μ) (hT : QuasiErgodic T μ) :
    μ (birkhoffConvergenceSet T g) = 0 ∨
      μ (birkhoffConvergenceSet T g) = 1 :=
  measure_birkhoffConvergenceSet_eq_zero_or_one_of_nullMeasurableSet hT
    (nullMeasurableSet_birkhoffConvergenceSet_of_aemeasurable hg
      hT.toQuasiMeasurePreserving)

/-- Probability zero--one corollary for an a.e. strongly measurable observable. -/
theorem measure_birkhoffConvergenceSet_eq_zero_or_one_of_aestronglyMeasurable
    [IsProbabilityMeasure μ] (hg : AEStronglyMeasurable g μ)
    (hT : QuasiErgodic T μ) :
    μ (birkhoffConvergenceSet T g) = 0 ∨
      μ (birkhoffConvergenceSet T g) = 1 :=
  measure_birkhoffConvergenceSet_eq_zero_or_one_of_aemeasurable
    hg.aemeasurable hT

/-- Probability zero--one corollary for an integrable observable. -/
theorem measure_birkhoffConvergenceSet_eq_zero_or_one_of_integrable
    [IsProbabilityMeasure μ] (hg : Integrable g μ) (hT : QuasiErgodic T μ) :
    μ (birkhoffConvergenceSet T g) = 0 ∨
      μ (birkhoffConvergenceSet T g) = 1 :=
  measure_birkhoffConvergenceSet_eq_zero_or_one_of_aestronglyMeasurable
    hg.aestronglyMeasurable hT

variable {X : ℕ → Ω → ℝ}

/-- The Birkhoff convergence event of the one-step observable `X 1`. Its
definition does not require `X` to satisfy any process law, and `X 0` plays no
role. -/
def oneStepBirkhoffConvergenceSet
    (T : Ω → Ω) (X : ℕ → Ω → ℝ) : Set Ω :=
  birkhoffConvergenceSet T (X 1)

namespace IsIntegrableSubadditiveProcessCandidate

/-- Candidate one-step event null-measurability needs only the candidate's
one-step integrability and quasi-measure preservation. -/
theorem nullMeasurableSet_oneStepBirkhoffConvergenceSet
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Measure.QuasiMeasurePreserving T μ μ) :
    NullMeasurableSet (oneStepBirkhoffConvergenceSet T X) μ :=
  nullMeasurableSet_birkhoffConvergenceSet_of_integrable (hX.integrable 1) hT

omit [MeasurableSpace Ω] in
/-- The candidate one-step event is exactly preimage-invariant without using
the candidate laws. -/
theorem preimage_oneStepBirkhoffConvergenceSet (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) :
    T ⁻¹' oneStepBirkhoffConvergenceSet T X =
      oneStepBirkhoffConvergenceSet T X :=
  preimage_birkhoffConvergenceSet T (X 1)

/-- Conditional quasi-ergodic rigidity of the candidate's one-step event. -/
theorem oneStepBirkhoffConvergenceSet_ae_empty_or_univ
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : QuasiErgodic T μ) :
    oneStepBirkhoffConvergenceSet T X =ᵐ[μ] (∅ : Set Ω) ∨
      oneStepBirkhoffConvergenceSet T X =ᵐ[μ] univ :=
  birkhoffConvergenceSet_ae_empty_or_univ_of_integrable (hX.integrable 1) hT

/-- Probability zero--one law for the candidate's one-step event. -/
theorem measure_oneStepBirkhoffConvergenceSet_eq_zero_or_one
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : QuasiErgodic T μ) :
    μ (oneStepBirkhoffConvergenceSet T X) = 0 ∨
      μ (oneStepBirkhoffConvergenceSet T X) = 1 :=
  measure_birkhoffConvergenceSet_eq_zero_or_one_of_integrable
    (hX.integrable 1) hT

end IsIntegrableSubadditiveProcessCandidate

namespace DiscreteMatrixCocycle

universe uι

variable {ι : Type uι} [Fintype ι] [DecidableEq ι]

/-- The convergence event for Birkhoff averages of the cocycle's one-step
log-positive norm observable. -/
def generatorLogPlusBirkhoffConvergenceSet
    (C : DiscreteMatrixCocycle (ι := ι) μ) : Set Ω :=
  birkhoffConvergenceSet C.base (C.logPlusNormObservable 1)

/-- The generator log-positive convergence event is measurable without a
generator-integrability or nonempty-index hypothesis. -/
theorem measurableSet_generatorLogPlusBirkhoffConvergenceSet
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    MeasurableSet C.generatorLogPlusBirkhoffConvergenceSet :=
  measurableSet_birkhoffConvergenceSet C.base_preserving.measurable
    (C.measurable_logPlusNormObservable 1)

/-- The generator log-positive convergence event is exactly invariant without
a generator-integrability or nonempty-index hypothesis. -/
theorem preimage_generatorLogPlusBirkhoffConvergenceSet
    (C : DiscreteMatrixCocycle (ι := ι) μ) :
    C.base ⁻¹' C.generatorLogPlusBirkhoffConvergenceSet =
      C.generatorLogPlusBirkhoffConvergenceSet :=
  preimage_birkhoffConvergenceSet C.base (C.logPlusNormObservable 1)

/-- Measurability and exact invariance reduce event rigidity to pre-ergodicity;
no generator-integrability hypothesis is used. -/
theorem generatorLogPlusBirkhoffConvergenceSet_ae_empty_or_univ
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (hT : PreErgodic C.base μ) :
    C.generatorLogPlusBirkhoffConvergenceSet =ᵐ[μ] (∅ : Set Ω) ∨
      C.generatorLogPlusBirkhoffConvergenceSet =ᵐ[μ] univ :=
  hT.ae_empty_or_univ C.measurableSet_generatorLogPlusBirkhoffConvergenceSet
    C.preimage_generatorLogPlusBirkhoffConvergenceSet

/-- Probability zero--one law for the generator event under pre-ergodicity,
with no generator-integrability hypothesis. -/
theorem measure_generatorLogPlusBirkhoffConvergenceSet_eq_zero_or_one
    [IsProbabilityMeasure μ]
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (hT : PreErgodic C.base μ) :
    μ C.generatorLogPlusBirkhoffConvergenceSet = 0 ∨
      μ C.generatorLogPlusBirkhoffConvergenceSet = 1 :=
  hT.prob_eq_zero_or_one
    C.measurableSet_generatorLogPlusBirkhoffConvergenceSet
    C.preimage_generatorLogPlusBirkhoffConvergenceSet

end DiscreteMatrixCocycle

section BoundaryProbes

omit [MeasurableSpace Ω] in
example (T : Ω → Ω) (g : Ω → ℝ) (ω : Ω) :
    birkhoffAverage ℝ T g 0 ω = 0 :=
  birkhoffAverage_zero ℝ T g ω

omit [MeasurableSpace Ω] in
example (T : Ω → Ω) :
    birkhoffConvergenceSet T (fun _ ↦ (0 : ℝ)) = univ := by
  ext ω
  simp only [mem_birkhoffConvergenceSet_iff, mem_univ, iff_true]
  refine ⟨0, ?_⟩
  apply (tendsto_const_nhds :
    Tendsto (fun _ : ℕ ↦ (0 : ℝ)) atTop (nhds 0)).congr'
  exact Eventually.of_forall fun n ↦ by
    simp [birkhoffAverage, birkhoffSum]

omit [MeasurableSpace Ω] in
example (T : Ω → Ω) (c : ℝ) :
    birkhoffConvergenceSet T (fun _ ↦ c) = univ := by
  ext ω
  simp only [mem_birkhoffConvergenceSet_iff, mem_univ, iff_true]
  refine ⟨c, ?_⟩
  apply (tendsto_const_nhds :
    Tendsto (fun _ : ℕ ↦ c) atTop (nhds c)).congr'
  filter_upwards [eventually_ge_atTop 1] with n hn
  symm
  have hinv : (fun _ : Ω ↦ c) ∘ T = (fun _ : Ω ↦ c) := by rfl
  exact congrFun (birkhoffAverage_of_comp_eq (R := ℝ) hinv
    (Nat.cast_ne_zero.mpr (Nat.ne_zero_of_lt hn))) ω

omit [MeasurableSpace Ω] in
example (g : Ω → ℝ) :
    birkhoffConvergenceSet id g = univ := by
  ext ω
  simp only [mem_birkhoffConvergenceSet_iff, mem_univ, iff_true]
  refine ⟨g ω, ?_⟩
  apply (tendsto_const_nhds :
    Tendsto (fun _ : ℕ ↦ g ω) atTop (nhds (g ω))).congr'
  filter_upwards [eventually_ge_atTop 1] with n hn
  symm
  have hfixed : Function.IsFixedPt id ω := by rfl
  exact hfixed.birkhoffAverage_eq (R := ℝ) g
    (Nat.cast_ne_zero.mpr (Nat.ne_zero_of_lt hn))

omit [MeasurableSpace Ω] in
example :
    ¬ Function.Injective (fun _ : Bool ↦ false) ∧
      ∀ g : Bool → ℝ,
        (fun _ : Bool ↦ false) ⁻¹'
            birkhoffConvergenceSet (fun _ : Bool ↦ false) g =
          birkhoffConvergenceSet (fun _ : Bool ↦ false) g := by
  constructor
  · intro hinj
    have hfalse : (false : Bool) = true := hinj rfl
    simp at hfalse
  · intro g
    exact preimage_birkhoffConvergenceSet (fun _ : Bool ↦ false) g

example (hg : AEMeasurable g μ)
    (hT : Measure.QuasiMeasurePreserving T μ μ) :
    birkhoffConvergenceSet T g =ᵐ[μ]
      birkhoffConvergenceSet T (hg.mk g) :=
  birkhoffConvergenceSet_ae_eq_of_ae_eq hT hg.ae_eq_mk

example (hT : Measurable T) (g : Ω → ℝ) :
    birkhoffConvergenceSet T g =ᵐ[(0 : Measure Ω)] (∅ : Set Ω) ∨
      birkhoffConvergenceSet T g =ᵐ[(0 : Measure Ω)] univ :=
  birkhoffConvergenceSet_ae_empty_or_univ_of_aemeasurable
    (aemeasurable_zero_measure : AEMeasurable g (0 : Measure Ω))
    (QuasiErgodic.zero_measure hT)

example (ω0 : Ω) :
    ∃ X : ℕ → Ω → ℝ,
      IsIntegrableSubadditiveProcessCandidate id (0 : Measure Ω) X ∧
        X 0 ω0 ≠ 0 ∧
          oneStepBirkhoffConvergenceSet id X = univ := by
  let X : ℕ → Ω → ℝ := fun n _ ↦ if n = 0 then 1 else 0
  refine ⟨X, ?_, by simp [X], ?_⟩
  · constructor
    · intro k
      exact integrable_zero_measure
    · intro m k ω
      dsimp [X]
      by_cases hm : m = 0 <;> by_cases hk : k = 0 <;> simp [hm, hk]
  · change birkhoffConvergenceSet id (fun _ ↦ (0 : ℝ)) = univ
    ext ω
    simp only [mem_birkhoffConvergenceSet_iff, mem_univ, iff_true]
    refine ⟨0, ?_⟩
    apply (tendsto_const_nhds :
      Tendsto (fun _ : ℕ ↦ (0 : ℝ)) atTop (nhds 0)).congr'
    exact Eventually.of_forall fun n ↦ by
      simp [birkhoffAverage, birkhoffSum]

example (C : DiscreteMatrixCocycle (Ω := Ω) (ι := Empty) μ) :
    MeasurableSet C.generatorLogPlusBirkhoffConvergenceSet ∧
      C.base ⁻¹' C.generatorLogPlusBirkhoffConvergenceSet =
        C.generatorLogPlusBirkhoffConvergenceSet :=
  ⟨C.measurableSet_generatorLogPlusBirkhoffConvergenceSet,
    C.preimage_generatorLogPlusBirkhoffConvergenceSet⟩

omit [MeasurableSpace Ω] in
example {T : Ω → Ω} {g : Ω → ℝ} {ω : Ω}
    (hdiv : ∀ c : ℝ,
      ¬ Tendsto (fun n ↦ birkhoffAverage ℝ T g n ω) atTop (nhds c)) :
    ω ∉ birkhoffConvergenceSet T g := by
  simpa only [mem_birkhoffConvergenceSet_iff, not_exists] using hdiv

omit [MeasurableSpace Ω] in
example (n : ℕ) :
    birkhoffAverage ℝ Nat.succ (fun k : ℕ ↦ (k : ℝ)) (n + 1) 0 =
      (n : ℝ) / 2 := by
  simp only [birkhoffAverage, birkhoffSum, Nat.succ_iterate, zero_add,
    smul_eq_mul]
  have hsum :
      (∑ j ∈ Finset.range (n + 1), (j : ℝ)) * 2 =
        ((n + 1 : ℕ) : ℝ) * (n : ℝ) := by
    rw [← Nat.cast_sum]
    norm_cast
    simpa using Finset.sum_range_id_mul_two (n + 1)
  field_simp
  nlinarith [hsum]

omit [MeasurableSpace Ω] in
example :
    0 ∉ birkhoffConvergenceSet Nat.succ (fun k : ℕ ↦ (k : ℝ)) := by
  simp only [mem_birkhoffConvergenceSet_iff, not_exists]
  intro c hc
  have hc' : Tendsto
      (fun n ↦ birkhoffAverage ℝ Nat.succ (fun k : ℕ ↦ (k : ℝ))
        (n + 1) 0) atTop (nhds c) :=
    (tendsto_add_atTop_iff_nat 1).mpr hc
  have havg :
      (fun n ↦ birkhoffAverage ℝ Nat.succ (fun k : ℕ ↦ (k : ℝ))
        (n + 1) 0) = fun n : ℕ ↦ (n : ℝ) / 2 := by
    funext n
    simp only [birkhoffAverage, birkhoffSum, Nat.succ_iterate, zero_add,
      smul_eq_mul]
    have hsum :
        (∑ j ∈ Finset.range (n + 1), (j : ℝ)) * 2 =
          ((n + 1 : ℕ) : ℝ) * (n : ℝ) := by
      rw [← Nat.cast_sum]
      norm_cast
      simpa using Finset.sum_range_id_mul_two (n + 1)
    field_simp
    nlinarith [hsum]
  rw [havg] at hc'
  have htop : Tendsto (fun n : ℕ ↦ (n : ℝ) / 2) atTop atTop :=
    (tendsto_div_const_atTop_of_pos (f := fun n : ℕ ↦ (n : ℝ)) two_pos).mpr
      tendsto_natCast_atTop_atTop
  exact not_tendsto_atTop_of_tendsto_nhds hc' htop

end BoundaryProbes

#print axioms birkhoffConvergenceSet_ae_eq_of_ae_eq
#print axioms nullMeasurableSet_birkhoffConvergenceSet_of_aemeasurable
#print axioms tendsto_birkhoffAverage_apply_base_iff
#print axioms birkhoffConvergenceSet_ae_empty_or_univ_of_integrable
#print axioms IsIntegrableSubadditiveProcessCandidate.oneStepBirkhoffConvergenceSet_ae_empty_or_univ
#print axioms DiscreteMatrixCocycle.generatorLogPlusBirkhoffConvergenceSet_ae_empty_or_univ

end NonlinearDynamics.Random.RandomCocycles
