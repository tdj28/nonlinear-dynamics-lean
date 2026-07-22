import NonlinearDynamics.Random.RandomCocycles.SubadditivePhaseAveraging
import NonlinearDynamics.Random.RandomCocycles.ErgodicBirkhoffLimit

/-!
# A subadditive upper limsup from phase averaging

This module proves the upper half of a Kingman-style pointwise estimate for
real shifted-subadditive processes whose normalized paths are almost
everywhere genuinely bounded below.  It combines three earlier layers:

* orbit-majorant centering splits `X n / n` into a nonpositive centered term
  and the Birkhoff average of `X 1`;
* finite phase averaging bounds the centered term by one ordinary-base
  Birkhoff sum of a fixed block observable;
* the ergodic Birkhoff theorem identifies both ordinary-base averages on a
  probability space.

For every positive block length `b`, the resulting almost-everywhere bound is

`limsup (fun n ↦ X n ω / (n : ℝ)) atTop ≤ (∫ x, X b x ∂μ) / (b : ℝ)`.

Intersecting these fixed-block conclusions and using the existing deterministic
Fekete `sInf` formula bounds the log-positive cocycle upper limsup by
`integratedLogPlusGrowthRate`.

The proof deliberately applies Birkhoff convergence only to the original map
`T`.  It never assumes or infers ergodicity of `T^[b]`; an explicit two-cycle
probe records that this inference is false.  Probability normalization is
also essential for the final comparison with the raw-integral Fekete rate.

This is not the full subadditive ergodic theorem.  No matching lower bound,
samplewise limit, equality with the deterministic rate, limit-integral
interchange, signed log-norm limit, Lyapunov exponent, or Oseledets splitting
is claimed.  The generic theorem exposes the actual almost-everywhere lower
bound required by the real-valued `limsup` API.  A compatibility wrapper
derives that gate from pointwise nonnegativity for the cocycle log-positive
application.
-/

open MeasureTheory Set Filter Topology Finset Function
open scoped BigOperators ENNReal Topology

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ uι

/-- The integral of a finite Birkhoff sum under a measure-preserving map is the
number of terms times the integral of the observable.  This finite identity
needs neither finite total mass nor ergodicity. -/
theorem integral_birkhoffSum_eq_nat_mul
    {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω} {μ : Measure Ω}
    {f : Ω → ℝ} (hT : MeasurePreserving T μ μ) (hf : Integrable f μ)
    (n : ℕ) :
    (∫ ω, birkhoffSum T f n ω ∂μ) = n * ∫ ω, f ω ∂μ := by
  change (∫ ω, ∑ j ∈ Finset.range n, f (T^[j] ω) ∂μ) = _
  rw [integral_finsetSum (Finset.range n)]
  · simp_rw [show ∀ j : ℕ, (∫ ω, f (T^[j] ω) ∂μ) = ∫ ω, f ω ∂μ by
      intro j
      have hp := hT.iterate j
      have hstrong : AEStronglyMeasurable f (Measure.map (T^[j]) μ) :=
        by simpa only [hp.map_eq] using hf.aestronglyMeasurable
      calc
        (∫ ω, f (T^[j] ω) ∂μ) = ∫ x, f x ∂Measure.map (T^[j]) μ :=
          (integral_map hp.measurable.aemeasurable hstrong).symm
        _ = ∫ x, f x ∂μ := by rw [hp.map_eq]]
    simp only [sum_const, card_range, nsmul_eq_mul]
  · intro j _hj
    change Integrable (f ∘ T^[j]) μ
    exact (hT.iterate j).integrable_comp_of_integrable hf

/-- The prefix length used by phase averaging on a horizon `b * a + r`. -/
private def blockPrefix (b a : ℕ) : ℕ := b * (a - 1)

/-- The one-block-short prefix still escapes to infinity for a positive block. -/
private theorem tendsto_blockPrefix (b : ℕ) (hb : b ≠ 0) :
    Tendsto (blockPrefix b) atTop atTop := by
  rw [tendsto_atTop_atTop]
  intro N
  refine ⟨N + 1, fun a ha ↦ ?_⟩
  simp only [blockPrefix]
  have hbpos : 0 < b := Nat.pos_of_ne_zero hb
  have hNa : N ≤ a - 1 := by omega
  exact hNa.trans (Nat.le_mul_of_pos_left (a - 1) hbpos)

/-- Each fixed residue lane `b * a + r` is cofinal when `b` is positive. -/
private theorem tendsto_arithmetic (b r : ℕ) (hb : b ≠ 0) :
    Tendsto (fun a ↦ b * a + r) atTop atTop := by
  rw [tendsto_atTop_atTop]
  intro N
  refine ⟨N, fun a ha ↦ ?_⟩
  have hbpos : 0 < b := Nat.pos_of_ne_zero hb
  exact ha.trans <| (Nat.le_mul_of_pos_left a hbpos).trans
    (Nat.le_add_right (b * a) r)

/-- The phase-averaging coefficient converges to the reciprocal block length. -/
private theorem tendsto_blockCoefficient (b r : ℕ) (hb : b ≠ 0) :
    Tendsto
      (fun a ↦ ((blockPrefix b a : ℕ) : ℝ) /
        ((b : ℝ) * ((b * a + r : ℕ) : ℝ)))
      atTop (𝓝 ((b : ℝ)⁻¹)) := by
  have hbR : (b : ℝ) ≠ 0 := by exact_mod_cast hb
  have hraw :=
    tendsto_add_mul_div_add_mul_atTop_nhds
      (-(b : ℝ)) ((b : ℝ) * r) (b : ℝ) (d := (b : ℝ) * b)
      (mul_ne_zero hbR hbR)
  have hlim : (b : ℝ) / ((b : ℝ) * b) = (b : ℝ)⁻¹ := by
    field_simp
  rw [hlim] at hraw
  refine hraw.congr' ?_
  filter_upwards [eventually_ge_atTop 1] with a ha
  simp only [blockPrefix]
  push_cast
  rw [Nat.cast_sub ha]
  ring

namespace IsIntegrableSubadditiveProcessCandidate

variable {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
  {μ : Measure Ω} {X : ℕ → Ω → ℝ}

/-- The centered block integral is the original block integral minus `b`
copies of the one-step integral.  Preservation is used only to transport the
finite Birkhoff-sum terms. -/
theorem integral_centeredProcess
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (b : ℕ) :
    (∫ ω, centeredProcess T X b ω ∂μ) =
      (∫ ω, X b ω ∂μ) - b * ∫ ω, X 1 ω ∂μ := by
  rw [show (fun ω ↦ centeredProcess T X b ω) =
      fun ω ↦ X b ω - birkhoffSum T (X 1) b ω by rfl]
  have hsum : Integrable (birkhoffSum T (X 1) b) μ := by
    simpa only [Function.iterate_one] using
      hX.integrable_birkhoffSum_blocks 1 b hT
  rw [integral_sub (hX.integrable b) hsum]
  rw [integral_birkhoffSum_eq_nat_mul hT (hX.integrable 1) b]

/-- Fixed-block upper half of a Kingman-style estimate under an honest
almost-everywhere lower-boundedness hypothesis for the normalized process.
On an ergodic probability space, its normalized upper limsup is at most the
normalized integral of each positive block observable. -/
theorem ae_limsup_normalized_le_blockIntegral_of_ae_isBoundedUnder_ge
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ)
    (hXlower : ∀ᵐ ω ∂μ,
      IsBoundedUnder (· ≥ ·) atTop (fun n ↦ X n ω / (n : ℝ)))
    (b : ℕ) (hb : b ≠ 0) :
    ∀ᵐ ω ∂μ,
      limsup (fun n ↦ X n ω / (n : ℝ)) atTop ≤
        (∫ x, X b x ∂μ) / (b : ℝ) := by
  let Y := centeredProcess T X
  have hYint : Integrable (Y b) μ :=
    hX.integrable_centeredProcess hT.toMeasurePreserving b
  filter_upwards
      [hXlower,
        ae_tendsto_birkhoffAverage_integral_of_ergodic hT hYint,
        ae_tendsto_birkhoffAverage_integral_of_ergodic hT (hX.integrable 1)]
      with ω hnormLower hYavg hOneAvg
  have hnorm_le_avg :
      (fun n ↦ X n ω / (n : ℝ)) ≤ᶠ[atTop]
        (fun n ↦ birkhoffAverage ℝ T (X 1) n ω) := by
    filter_upwards [eventually_ge_atTop 1] with n hn
    simpa only [birkhoffAverage, smul_eq_mul, div_eq_inv_mul] using
      (div_le_div_iff_of_pos_right (Nat.cast_pos.mpr hn)).2
        (hX.oneStepBirkhoffMajorant_of_ne_zero n (by omega) ω)
  have hupper :
      IsBoundedUnder (· ≤ ·) atTop (fun n ↦ X n ω / (n : ℝ)) :=
    hOneAvg.isBoundedUnder_le.mono_le hnorm_le_avg
  rw [limsup_le_iff hnormLower.isCoboundedUnder_le hupper]
  intro z hz
  apply Eventually.atTop_of_arithmetic hb
  intro r _hr
  have hYsub :
      Tendsto
        (fun a ↦ birkhoffAverage ℝ T (Y b) (blockPrefix b a) ω)
        atTop (𝓝 (∫ x, Y b x ∂μ)) :=
    hYavg.comp (tendsto_blockPrefix b hb)
  have hscaled :
      Tendsto
        (fun a ↦
          birkhoffAverage ℝ T (Y b) (blockPrefix b a) ω *
            (((blockPrefix b a : ℕ) : ℝ) /
              ((b : ℝ) * ((b * a + r : ℕ) : ℝ))))
        atTop (𝓝 ((∫ x, Y b x ∂μ) * (b : ℝ)⁻¹)) :=
    hYsub.mul (tendsto_blockCoefficient b r hb)
  have hOneSub :
      Tendsto (fun a ↦ birkhoffAverage ℝ T (X 1) (b * a + r) ω)
        atTop (𝓝 (∫ x, X 1 x ∂μ)) :=
    hOneAvg.comp (tendsto_arithmetic b r hb)
  have htarget :
      (∫ x, Y b x ∂μ) * (b : ℝ)⁻¹ + (∫ x, X 1 x ∂μ) =
        (∫ x, X b x ∂μ) / (b : ℝ) := by
    rw [hX.integral_centeredProcess hT.toMeasurePreserving b]
    have hbR : (b : ℝ) ≠ 0 := by exact_mod_cast hb
    field_simp
    ring
  have hv := hscaled.add hOneSub
  rw [htarget] at hv
  filter_upwards [hv.eventually (Iio_mem_nhds hz), eventually_ge_atTop 2]
      with a hva ha
  apply lt_of_le_of_lt ?_ hva
  have hnpos : 0 < b * a + r := by
    exact Nat.add_pos_left
      (Nat.mul_pos (Nat.pos_of_ne_zero hb) (by omega)) r
  rw [normalized_eq_centered_add_birkhoffAverage (T := T) (X := X)]
  have hphase := hX.centeredProcess_le_birkhoffSum_phase_average_div
    b (a - 1) r hb ω
  have hindex : b * (a - 1) + b + r = b * a + r := by
    have ha1 : a - 1 + 1 = a := Nat.sub_add_cancel (by omega)
    calc
      b * (a - 1) + b + r = b * ((a - 1) + 1) + r := by
        rw [Nat.mul_add, Nat.mul_one]
      _ = b * a + r := by rw [ha1]
  rw [hindex] at hphase
  have hdiv := (div_le_div_iff_of_pos_right (Nat.cast_pos.mpr hnpos)).2 hphase
  have hdiv' :
      centeredProcess T X (b * a + r) ω / ((b : ℝ) * a + r) ≤
        birkhoffSum T (centeredProcess T X b) (b * (a - 1)) ω /
          (b : ℝ) / ((b : ℝ) * a + r) := by
    simpa only [Nat.cast_add, Nat.cast_mul] using hdiv
  have hcenter :
      centeredProcess T X (b * a + r) ω / (b * a + r : ℝ) ≤
        birkhoffAverage ℝ T (Y b) (blockPrefix b a) ω *
          ((blockPrefix b a : ℕ) : ℝ) /
            ((b : ℝ) * ((b * a + r : ℕ) : ℝ)) := by
    calc
      centeredProcess T X (b * a + r) ω / (b * a + r : ℝ) ≤
          birkhoffSum T (centeredProcess T X b) (b * (a - 1)) ω /
            (b : ℝ) / (b * a + r : ℝ) := hdiv'
      _ = birkhoffAverage ℝ T (Y b) (blockPrefix b a) ω *
          ((blockPrefix b a : ℕ) : ℝ) /
            ((b : ℝ) * ((b * a + r : ℕ) : ℝ)) := by
        simp only [birkhoffAverage, smul_eq_mul, Y, blockPrefix,
          Nat.cast_mul, Nat.cast_add]
        have hbR : (b : ℝ) ≠ 0 := by exact_mod_cast hb
        have haR : ((a - 1 : ℕ) : ℝ) ≠ 0 := by
          exact_mod_cast (show a - 1 ≠ 0 by omega)
        field_simp [hbR, haR]
  simpa only [div_eq_mul_inv, mul_assoc, add_comm, Nat.cast_add, Nat.cast_mul]
    using add_le_add_right hcenter
      (birkhoffAverage ℝ T (X 1) (b * a + r) ω)

/-- Nonnegative candidates satisfy the lower-boundedness gate automatically,
recovering the original fixed-block upper estimate. -/
theorem ae_limsup_normalized_le_blockIntegral
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (hXnonneg : ∀ n ω, 0 ≤ X n ω)
    (b : ℕ) (hb : b ≠ 0) :
    ∀ᵐ ω ∂μ,
      limsup (fun n ↦ X n ω / (n : ℝ)) atTop ≤
        (∫ x, X b x ∂μ) / (b : ℝ) := by
  apply hX.ae_limsup_normalized_le_blockIntegral_of_ae_isBoundedUnder_ge
    hT ?_ b hb
  exact Filter.Eventually.of_forall fun ω ↦
    isBoundedUnder_of ⟨0, fun n ↦
      div_nonneg (hXnonneg n ω) (Nat.cast_nonneg n)⟩

end IsIntegrableSubadditiveProcessCandidate

namespace DiscreteMatrixCocycle

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-- The log-positive cocycle upper limsup is almost everywhere bounded by the
existing deterministic Fekete rate on an ergodic probability base.  This is an
upper estimate only, not a samplewise convergence theorem. -/
theorem HasIntegrableGeneratorLogPlus.ae_limsup_normalized_le_integratedLogPlusGrowthRate
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (hT : Ergodic C.base μ) :
    ∀ᵐ ω ∂μ,
      limsup
          (fun n ↦ C.logPlusNormObservable n ω / (n : ℝ)) atTop ≤
        C.integratedLogPlusGrowthRate hC := by
  have hblock : ∀ b : ℕ, ∀ᵐ ω ∂μ, b ≠ 0 →
      limsup
          (fun n ↦ C.logPlusNormObservable n ω / (n : ℝ)) atTop ≤
        C.normalizedIntegratedLogPlusNorm b := by
    intro b
    by_cases hb : b = 0
    · simp [hb]
    · filter_upwards
          [IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral
              hC.isIntegrableSubadditiveProcessCandidate hT
                C.logPlusNormObservable_nonneg b hb]
        with ω hω
      intro _hb
      simpa only [normalizedIntegratedLogPlusNorm,
        integratedLogPlusNorm] using hω
  filter_upwards [ae_all_iff.2 hblock] with ω hω
  rw [hC.integratedLogPlusGrowthRate_eq_sInf]
  apply le_csInf
  · exact ⟨C.normalizedIntegratedLogPlusNorm 1, ⟨1, by simp, rfl⟩⟩
  · intro y hy
    rcases hy with ⟨b, hb, rfl⟩
    exact hω b (Nat.ne_of_gt hb)

end DiscreteMatrixCocycle

section BoundaryProbes

private def rmt29ZeroProcess {Ω : Type*} (_n : ℕ) (_ω : Ω) : ℝ := 0

private theorem rmt29ZeroProcess_candidate
    {Ω : Type*} [MeasurableSpace Ω] (T : Ω → Ω) (μ : Measure Ω) :
    IsIntegrableSubadditiveProcessCandidate T μ
      (rmt29ZeroProcess : ℕ → Ω → ℝ) where
  integrable := by
    intro n
    change Integrable (0 : Ω → ℝ) μ
    exact integrable_zero Ω ℝ μ
  add_le := by
    intros
    simp only [rmt29ZeroProcess, add_zero, le_refl]

private def rmt29Flip : Bool → Bool := fun b ↦ !b

private def rmt29TwoCycleMeasure : Measure Bool :=
  ENNReal.ofReal 0.5 • (Measure.dirac false + Measure.dirac true)

private instance : IsProbabilityMeasure rmt29TwoCycleMeasure := by
  refine ⟨?_⟩
  simp [rmt29TwoCycleMeasure]
  rw [← ENNReal.ofReal_add (by norm_num : (0 : ℝ) ≤ 0.5)
    (by norm_num : (0 : ℝ) ≤ 0.5)]
  norm_num

private theorem rmt29Flip_measurePreserving_twoCycle :
    MeasurePreserving rmt29Flip rmt29TwoCycleMeasure
      rmt29TwoCycleMeasure := by
  have hsum :
      MeasurePreserving rmt29Flip
        (Measure.dirac false + Measure.dirac true)
        (Measure.dirac false + Measure.dirac true) := by
    have hmeas : Measurable rmt29Flip := measurable_of_finite _
    refine ⟨hmeas, ?_⟩
    rw [Measure.map_add _ _ hmeas]
    simp only [Measure.map_dirac' hmeas]
    exact add_comm _ _
  exact hsum.smul_measure (ENNReal.ofReal 0.5)

private theorem rmt29Flip_preErgodic_twoCycle :
    PreErgodic rmt29Flip rmt29TwoCycleMeasure := by
  refine ⟨?_⟩
  intro s _hs hinv
  have hmem (b : Bool) : (rmt29Flip b ∈ s ↔ b ∈ s) := by
    have := Set.ext_iff.mp hinv b
    simpa only [Set.mem_preimage] using this
  by_cases hf : false ∈ s
  · have ht : true ∈ s := (hmem true).mp (by simpa [rmt29Flip] using hf)
    have hs : s = univ := by
      ext b
      cases b <;> simp [hf, ht]
    rw [hs, eventuallyConst_set']
    simp
  · have ht : true ∉ s := by
      intro ht
      exact hf ((hmem false).mp (by simpa [rmt29Flip] using ht))
    have hs : s = ∅ := by
      ext b
      cases b <;> simp [hf, ht]
    rw [hs, eventuallyConst_set']
    simp

private theorem rmt29Flip_ergodic_twoCycle :
    Ergodic rmt29Flip rmt29TwoCycleMeasure :=
  ⟨rmt29Flip_measurePreserving_twoCycle, rmt29Flip_preErgodic_twoCycle⟩

private theorem rmt29Flip_square_eq_id : rmt29Flip^[2] = id := by
  funext b
  cases b <;> rfl

private theorem rmt29Flip_square_not_ergodic :
    ¬ Ergodic (rmt29Flip^[2]) rmt29TwoCycleMeasure := by
  rw [rmt29Flip_square_eq_id]
  intro h
  have hzero := h.toPreErgodic.measure_self_or_compl_eq_zero
    (s := ({false} : Set Bool)) (measurableSet_singleton false) (by simp)
  simp [rmt29TwoCycleMeasure] at hzero
  norm_num at hzero

/-- The integral identity is total at horizon zero. -/
example {Ω : Type*} [MeasurableSpace Ω] {T : Ω → Ω} {μ : Measure Ω}
    {f : Ω → ℝ} (hT : MeasurePreserving T μ μ) (hf : Integrable f μ) :
    (∫ ω, birkhoffSum T f 0 ω ∂μ) = 0 := by
  simpa only [Nat.cast_zero, zero_mul] using
    integral_birkhoffSum_eq_nat_mul hT hf 0

/-- The generic upper-limsup theorem handles the totalized zero process
without placing a strict-positivity requirement on time zero. -/
example {Ω : Type*} [MeasurableSpace Ω] {T : Ω → Ω} {μ : Measure Ω}
    [IsProbabilityMeasure μ] (hT : Ergodic T μ) :
    ∀ᵐ ω ∂μ,
      limsup
          (fun n ↦ rmt29ZeroProcess n ω / (n : ℝ)) atTop ≤ 0 := by
  simpa only [rmt29ZeroProcess, zero_div, integral_zero] using
    (rmt29ZeroProcess_candidate T μ).ae_limsup_normalized_le_blockIntegral
      hT (by intros; simp [rmt29ZeroProcess]) 1 one_ne_zero

/-- An ergodic two-cycle can have a nonergodic square.  The fixed-block bound
at `b = 2` nevertheless applies because its Birkhoff limits use only the
original map. -/
example :
    Ergodic rmt29Flip rmt29TwoCycleMeasure ∧
      ¬ Ergodic (rmt29Flip^[2]) rmt29TwoCycleMeasure ∧
      ∀ᵐ ω ∂rmt29TwoCycleMeasure,
        limsup
            (fun n ↦ rmt29ZeroProcess n ω / (n : ℝ)) atTop ≤ 0 := by
  refine ⟨rmt29Flip_ergodic_twoCycle, rmt29Flip_square_not_ergodic, ?_⟩
  simpa only [rmt29ZeroProcess, zero_div, integral_zero] using
    (IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral
        (rmt29ZeroProcess_candidate rmt29Flip rmt29TwoCycleMeasure)
          rmt29Flip_ergodic_twoCycle
            (by intros; simp [rmt29ZeroProcess]) 2 (by norm_num))

end BoundaryProbes

#print axioms integral_birkhoffSum_eq_nat_mul
#print axioms IsIntegrableSubadditiveProcessCandidate.integral_centeredProcess
#print axioms IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral_of_ae_isBoundedUnder_ge
#print axioms IsIntegrableSubadditiveProcessCandidate.ae_limsup_normalized_le_blockIntegral
#print axioms DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_limsup_normalized_le_integratedLogPlusGrowthRate

end NonlinearDynamics.Random.RandomCocycles
