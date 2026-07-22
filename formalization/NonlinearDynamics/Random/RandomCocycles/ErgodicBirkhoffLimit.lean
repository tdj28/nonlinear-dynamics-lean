import NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoffLimit
import Mathlib.Dynamics.Ergodic.Function
import Mathlib.MeasureTheory.Integral.Average

/-!
# Identifying the ergodic Birkhoff constant

`PointwiseBirkhoffLimit` identifies the almost-everywhere limit of the real
Birkhoff averages with conditional expectation onto
`MeasurableSpace.invariants T`.  This module adds ergodicity and identifies
that invariant target with a normalized constant.

The argument is layered deliberately.  Conditional expectation onto the exact
invariant sigma algebra is literally invariant under composition with `T`.
The weaker `PreErgodic T μ` rigidity hypothesis already turns this invariant
function into an almost-everywhere constant; it does not make the invariant
sigma algebra literally equal to the bottom sigma algebra.  Integrating the
almost-everywhere identity and using the whole-space conditional-expectation
integral theorem identifies the constant.  Full `Ergodic T μ`, which also
contains measure preservation, enters only when the RMT-27 convergence theorem
is composed with that identification.

Mathlib's integral average `⨍ x, f x ∂μ` is the canonical middle object.  On a
finite nonzero measure it is

`(μ.real univ)⁻¹ * ∫ x, f x ∂μ`.

For a probability measure it is the ordinary integral.  We therefore expose
all three presentations: integral average, explicit finite-mass
normalization, and probability expectation.

Mathlib totalizes both conditional expectation and the Bochner integral.
Literal invariance and almost-everywhere constancy consequently need no
integrability premise.  The identified-average theorems do require
`Integrable f μ` and use it through `setIntegral_condExp`; their mathematical
content is not a nonintegrable zero-fallback identity.

Ergodicity alone does not exclude the zero measure.  The finite-mass results
therefore keep an explicit `μ ≠ 0` premise, while the probability
specializations obtain nonzeroness automatically.  No theorem assumes
injectivity, surjectivity, invertibility, mixing, or ergodicity of a powered
map.  No rate, everywhere convergence, Kingman theorem, cocycle-growth limit,
Lyapunov exponent, or Oseledets splitting is claimed.
-/

open MeasureTheory ProbabilityTheory Set Filter Function
open scoped ENNReal Topology BigOperators

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ

variable {Ω : Type uΩ} [MeasurableSpace Ω]
  {T : Ω → Ω} {f : Ω → ℝ} {μ : Measure Ω}

/-- Conditional expectation onto the exact invariant sigma algebra is
literally invariant under one application of the base map.  This is a
representative-level equality, not merely an almost-everywhere statement. -/
theorem condExp_invariants_comp :
    (μ[f | MeasurableSpace.invariants T]) ∘ T =
      μ[f | MeasurableSpace.invariants T] := by
  exact MeasurableSpace.comp_eq_of_measurable_invariants
    (stronglyMeasurable_condExp (m := MeasurableSpace.invariants T)
      (μ := μ) (f := f)).measurable

/-- Literal invariant measurability and pre-ergodic rigidity make the selected
conditional-expectation representative almost everywhere equal to some
constant.  This totalized helper needs neither finiteness nor integrability. -/
private theorem condExp_invariants_ae_eq_const_of_preErgodic
    (hT : PreErgodic T μ) :
    ∃ c : ℝ, μ[f | MeasurableSpace.invariants T] =ᵐ[μ]
      fun _ : Ω ↦ c := by
  apply hT.ae_eq_const_of_ae_eq_comp
  · exact ((stronglyMeasurable_condExp
      (m := MeasurableSpace.invariants T) (μ := μ) (f := f)).mono
        (MeasurableSpace.invariants_le T)).measurable
  · exact condExp_invariants_comp (T := T) (f := f) (μ := μ)

/-- On a finite nonzero pre-ergodic system, the invariant conditional
expectation of an integrable real observable is almost everywhere its integral
average.  Measure preservation is not needed for this rigidity statement. -/
theorem condExp_invariants_ae_eq_average_of_preErgodic
    [IsFiniteMeasure μ]
    (hμ : μ ≠ 0) (hT : PreErgodic T μ) (hf : Integrable f μ) :
    μ[f | MeasurableSpace.invariants T] =ᵐ[μ]
      fun _ : Ω ↦ ⨍ x, f x ∂μ := by
  letI : NeZero μ := ⟨hμ⟩
  obtain ⟨c, hc⟩ :=
    condExp_invariants_ae_eq_const_of_preErgodic (f := f) hT
  have hIntegral : μ.real univ * c = ∫ x, f x ∂μ := by
    calc
      μ.real univ * c = ∫ _x : Ω, c ∂μ := by
        simp only [integral_const, smul_eq_mul]
      _ = ∫ x, μ[f | MeasurableSpace.invariants T] x ∂μ :=
        (integral_congr_ae hc).symm
      _ = ∫ x, f x ∂μ := by
        simpa only [setIntegral_univ] using
          setIntegral_condExp (MeasurableSpace.invariants_le T) hf
            (MeasurableSet.univ :
              MeasurableSet[MeasurableSpace.invariants T] (univ : Set Ω))
  have hcAverage : c = ⨍ x, f x ∂μ := by
    apply mul_left_cancel₀ (measureReal_univ_ne_zero (μ := μ))
    calc
      μ.real univ * c = ∫ x, f x ∂μ := hIntegral
      _ = μ.real univ * ⨍ x, f x ∂μ := by
        simpa only [smul_eq_mul] using (measure_smul_average μ f).symm
  exact hc.trans (Eventually.of_forall fun _ ↦ hcAverage)

/-- Explicit finite-mass form of the pre-ergodic conditional-expectation
target.  The nonzero-measure premise makes the finite real denominator
positive. -/
theorem condExp_invariants_ae_eq_normalizedIntegral_of_preErgodic
    [IsFiniteMeasure μ]
    (hμ : μ ≠ 0) (hT : PreErgodic T μ) (hf : Integrable f μ) :
    μ[f | MeasurableSpace.invariants T] =ᵐ[μ]
      fun _ : Ω ↦ (μ.real univ)⁻¹ * ∫ x, f x ∂μ := by
  simpa only [average_eq, smul_eq_mul] using
    (condExp_invariants_ae_eq_average_of_preErgodic
      (T := T) (f := f) hμ hT hf)

/-- On a pre-ergodic probability space, the invariant conditional expectation
of an integrable real observable is almost everywhere its ordinary integral.
Measure preservation remains unnecessary for this identification alone. -/
theorem condExp_invariants_ae_eq_integral_of_preErgodic
    [IsProbabilityMeasure μ]
    (hT : PreErgodic T μ) (hf : Integrable f μ) :
    μ[f | MeasurableSpace.invariants T] =ᵐ[μ]
      fun _ : Ω ↦ ∫ x, f x ∂μ := by
  simpa only [average_eq_integral] using
    (condExp_invariants_ae_eq_average_of_preErgodic
      (T := T) (f := f) (μ := μ) (NeZero.ne μ) hT hf)

/-- Explicit normalized-integral form of the finite nonzero ergodic Birkhoff
limit. -/
theorem ae_tendsto_birkhoffAverage_normalizedIntegral_of_ergodic
    [IsFiniteMeasure μ]
    (hμ : μ ≠ 0) (hT : Ergodic T μ) (hf : Integrable f μ) :
    ∀ᵐ ω ∂μ,
      Tendsto (fun n ↦ birkhoffAverage ℝ T f n ω) atTop
        (nhds ((μ.real univ)⁻¹ * ∫ x, f x ∂μ)) := by
  filter_upwards
      [ae_tendsto_birkhoffAverage_condExp hT.toMeasurePreserving hf,
        condExp_invariants_ae_eq_normalizedIntegral_of_preErgodic
          (T := T) (f := f) hμ hT.toPreErgodic hf]
      with ω hconv htarget
  simpa only [htarget] using hconv

/-- Probability specialization: for an integrable real observable on an
ergodic probability space, the full Birkhoff sequence converges almost
everywhere to its integral. -/
theorem ae_tendsto_birkhoffAverage_integral_of_ergodic
    [IsProbabilityMeasure μ]
    (hT : Ergodic T μ) (hf : Integrable f μ) :
    ∀ᵐ ω ∂μ,
      Tendsto (fun n ↦ birkhoffAverage ℝ T f n ω) atTop
        (nhds (∫ x, f x ∂μ)) := by
  filter_upwards
      [ae_tendsto_birkhoffAverage_condExp hT.toMeasurePreserving hf,
        condExp_invariants_ae_eq_integral_of_preErgodic
          (T := T) (f := f) hT.toPreErgodic hf]
      with ω hconv htarget
  simpa only [htarget] using hconv

section BoundaryProbes

private def rmt28ConstantFalse : Bool → Bool := fun _ ↦ false

private def rmt28MassTwoDirac : Measure Bool :=
  (2 : ℝ≥0∞) • Measure.dirac false

private def rmt28TwoAtomMeasure : Measure Bool :=
  Measure.dirac false + Measure.dirac true

private def rmt28TwoAtomObservable : Bool → ℝ :=
  fun b ↦ if b then 1 else 0

private theorem rmt28ConstantFalse_not_injective :
    ¬ Function.Injective rmt28ConstantFalse := by
  intro h
  have : (false : Bool) = true := h rfl
  simp at this

private theorem rmt28ConstantFalse_not_surjective :
    ¬ Function.Surjective rmt28ConstantFalse := by
  intro h
  obtain ⟨b, hb⟩ := h true
  simp [rmt28ConstantFalse] at hb

private theorem rmt28ConstantFalse_measurePreserving_dirac :
    MeasurePreserving rmt28ConstantFalse (Measure.dirac false)
      (Measure.dirac false) := by
  refine ⟨measurable_const, ?_⟩
  rw [Measure.map_dirac' (f := rmt28ConstantFalse) measurable_const]
  rfl

private theorem rmt28PreErgodic_dirac (a : Bool) (S : Bool → Bool) :
    PreErgodic S (Measure.dirac a) := by
  refine ⟨?_⟩
  intro s _hs _hS
  rw [ae_dirac_eq, Filter.eventuallyConst_set]
  exact em (a ∈ s)

private theorem rmt28ConstantFalse_ergodic_dirac :
    Ergodic rmt28ConstantFalse (Measure.dirac false) :=
  ⟨rmt28ConstantFalse_measurePreserving_dirac,
    rmt28PreErgodic_dirac false rmt28ConstantFalse⟩

private theorem rmt28ConstantFalse_not_measurePreserving_dirac_true :
    ¬ MeasurePreserving rmt28ConstantFalse (Measure.dirac true)
      (Measure.dirac true) := by
  intro h
  have hmap := h.map_eq
  rw [Measure.map_dirac' (f := rmt28ConstantFalse) measurable_const] at hmap
  have happ := congrArg (fun ν : Measure Bool ↦ ν {true}) hmap
  simp [rmt28ConstantFalse, Measure.dirac_apply'] at happ

private theorem rmt28MassTwoDirac_ne_zero : rmt28MassTwoDirac ≠ 0 := by
  intro h
  have h' := congrArg (fun ν : Measure Bool ↦ ν univ) h
  norm_num [rmt28MassTwoDirac] at h'

private instance : IsFiniteMeasure rmt28MassTwoDirac := by
  refine ⟨?_⟩
  simp [rmt28MassTwoDirac]

private instance : IsFiniteMeasure rmt28TwoAtomMeasure := by
  change IsFiniteMeasure (Measure.dirac false + Measure.dirac true)
  infer_instance

private theorem rmt28ConstantFalse_ergodic_massTwoDirac :
    Ergodic rmt28ConstantFalse rmt28MassTwoDirac := by
  simpa only [rmt28MassTwoDirac] using
    rmt28ConstantFalse_ergodic_dirac.smul_measure (2 : ℝ≥0∞)

/-- A probability Dirac system can be ergodic even when its base map is
neither injective nor surjective. -/
example :
    Ergodic rmt28ConstantFalse (Measure.dirac false) ∧
      ¬ Function.Injective rmt28ConstantFalse ∧
      ¬ Function.Surjective rmt28ConstantFalse ∧
      ∀ h : Bool → ℝ, Integrable h (Measure.dirac false) →
        ∀ᵐ ω ∂Measure.dirac false,
          Tendsto
            (fun n ↦ birkhoffAverage ℝ rmt28ConstantFalse h n ω) atTop
            (nhds (∫ x, h x ∂Measure.dirac false)) := by
  refine ⟨rmt28ConstantFalse_ergodic_dirac,
    rmt28ConstantFalse_not_injective, rmt28ConstantFalse_not_surjective, ?_⟩
  intro h hh
  exact ae_tendsto_birkhoffAverage_integral_of_ergodic
    rmt28ConstantFalse_ergodic_dirac hh

/-- The conditional-expectation identification needs only pre-ergodic
rigidity.  With a Dirac mass at `true`, the same constant map is pre-ergodic
but does not preserve the measure. -/
example (h : Bool → ℝ) (hh : Integrable h (Measure.dirac true)) :
    PreErgodic rmt28ConstantFalse (Measure.dirac true) ∧
      ¬ MeasurePreserving rmt28ConstantFalse (Measure.dirac true)
        (Measure.dirac true) ∧
      (Measure.dirac true)[
        h | MeasurableSpace.invariants rmt28ConstantFalse]
          =ᵐ[Measure.dirac true]
            fun _ ↦ ∫ x, h x ∂Measure.dirac true := by
  have hpre := rmt28PreErgodic_dirac true rmt28ConstantFalse
  exact ⟨hpre, rmt28ConstantFalse_not_measurePreserving_dirac_true,
    condExp_invariants_ae_eq_integral_of_preErgodic hpre hh⟩

/-- Scaling the Dirac measure to mass two preserves ergodicity and the
nonbijective base.  The normalized target is exactly the supported value. -/
example (h : Bool → ℝ) (hh : Integrable h rmt28MassTwoDirac) :
    ¬ Function.Injective rmt28ConstantFalse ∧
      ¬ Function.Surjective rmt28ConstantFalse ∧
      ∀ᵐ ω ∂rmt28MassTwoDirac,
        Tendsto
          (fun n ↦ birkhoffAverage ℝ rmt28ConstantFalse h n ω) atTop
          (nhds (h false)) := by
  have hmass : rmt28MassTwoDirac.real univ = 2 := by
    rw [rmt28MassTwoDirac, measureReal_ennreal_smul_apply, measureReal_def]
    norm_num [Measure.dirac_apply']
  have hIntegral : ∫ x, h x ∂rmt28MassTwoDirac = 2 * h false := by
    rw [rmt28MassTwoDirac, integral_smul_measure, integral_dirac]
    norm_num [smul_eq_mul]
  have htarget :
      (rmt28MassTwoDirac.real univ)⁻¹ *
          ∫ x, h x ∂rmt28MassTwoDirac = h false := by
    rw [hmass, hIntegral]
    ring
  refine ⟨rmt28ConstantFalse_not_injective,
    rmt28ConstantFalse_not_surjective, ?_⟩
  filter_upwards
      [ae_tendsto_birkhoffAverage_normalizedIntegral_of_ergodic
        rmt28MassTwoDirac_ne_zero
        rmt28ConstantFalse_ergodic_massTwoDirac hh]
      with ω hconv
  simpa only [htarget] using hconv

/-- Mathlib permits the zero measure to be ergodic, but it cannot satisfy the
nonzero-mass gate.  Its normalized almost-everywhere statement is vacuous. -/
example (h : Bool → ℝ) :
    Ergodic id (0 : Measure Bool) ∧
      ¬ NeZero (0 : Measure Bool) ∧
      ∀ᵐ ω ∂(0 : Measure Bool),
        Tendsto (fun n ↦ birkhoffAverage ℝ id h n ω) atTop
          (nhds (((0 : Measure Bool).real univ)⁻¹ *
            ∫ x, h x ∂(0 : Measure Bool))) := by
  refine ⟨Ergodic.zero_measure measurable_id, ?_, by simp⟩
  intro hne
  exact hne.out rfl

/-- On a two-atom identity system the observable that separates the atoms is
not almost everywhere constant, and its conditional expectation does not
collapse to the normalized integral.  This records the necessity of the
pre-ergodic rigidity gate. -/
example :
    ¬ PreErgodic id rmt28TwoAtomMeasure ∧
      ¬ Ergodic id rmt28TwoAtomMeasure ∧
      ¬ (rmt28TwoAtomMeasure[
        rmt28TwoAtomObservable | MeasurableSpace.invariants id]
          =ᵐ[rmt28TwoAtomMeasure]
            fun _ ↦ (rmt28TwoAtomMeasure.real univ)⁻¹ *
              ∫ x, rmt28TwoAtomObservable x ∂rmt28TwoAtomMeasure) := by
  have hnotPreErgodic : ¬ PreErgodic id rmt28TwoAtomMeasure := by
    intro h
    have hzero := h.measure_self_or_compl_eq_zero
      (s := ({false} : Set Bool)) (measurableSet_singleton false) (by simp)
    simp [rmt28TwoAtomMeasure, Measure.dirac_apply'] at hzero
  have hnotErgodic : ¬ Ergodic id rmt28TwoAtomMeasure :=
    fun h ↦ hnotPreErgodic h.toPreErgodic
  have hIntegrable :
      Integrable rmt28TwoAtomObservable rmt28TwoAtomMeasure := by
    simp [rmt28TwoAtomMeasure]
  have hnotConst :
      ¬ ∃ c : ℝ,
        rmt28TwoAtomObservable =ᵐ[rmt28TwoAtomMeasure] fun _ ↦ c := by
    rintro ⟨c, hc⟩
    have hc' :
        rmt28TwoAtomObservable false = c ∧
          rmt28TwoAtomObservable true = c := by
      simpa [rmt28TwoAtomMeasure, Filter.EventuallyEq] using hc
    have : (0 : ℝ) = 1 := hc'.1.trans hc'.2.symm
    norm_num [rmt28TwoAtomObservable] at this
  refine ⟨hnotPreErgodic, hnotErgodic, ?_⟩
  intro hcollapse
  have hself :
      rmt28TwoAtomMeasure[
        rmt28TwoAtomObservable | MeasurableSpace.invariants id]
          =ᵐ[rmt28TwoAtomMeasure] rmt28TwoAtomObservable := by
    rw [MeasurableSpace.invariants_id]
    exact condExp_of_aestronglyMeasurable' le_rfl
      (measurable_of_finite rmt28TwoAtomObservable).aestronglyMeasurable
      hIntegrable
  apply hnotConst
  exact ⟨(rmt28TwoAtomMeasure.real univ)⁻¹ *
    ∫ x, rmt28TwoAtomObservable x ∂rmt28TwoAtomMeasure,
    hself.symm.trans hcollapse⟩

end BoundaryProbes

#print axioms condExp_invariants_comp
#print axioms condExp_invariants_ae_eq_average_of_preErgodic
#print axioms condExp_invariants_ae_eq_normalizedIntegral_of_preErgodic
#print axioms condExp_invariants_ae_eq_integral_of_preErgodic
#print axioms ae_tendsto_birkhoffAverage_normalizedIntegral_of_ergodic
#print axioms ae_tendsto_birkhoffAverage_integral_of_ergodic

end NonlinearDynamics.Random.RandomCocycles
