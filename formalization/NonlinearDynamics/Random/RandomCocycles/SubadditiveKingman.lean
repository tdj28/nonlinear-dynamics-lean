import NonlinearDynamics.Random.RandomCocycles.SubadditiveLowerDeviation
import NonlinearDynamics.Random.RandomCocycles.SubadditiveUpperLimsup

/-!
# Log-positive Kingman convergence from rational lower deviations

RMT-32 proves that every rationally generated strict centered lower-deviation
event below the integrated centered Fekete offset is null.  This module turns
that event theorem into a real lower-liminf estimate and combines it with
RMT-29's upper-limsup estimate.

For the centered process, write

`u n ω = centeredProcess T X n ω / (n : ℝ)`.

Division is total at `n = 0`, so `u 0 ω = 0`; `liminf_nat_add` proves that
dropping this finite prefix changes no lower limit.  A fixed-slope event from
RMT-32 is exactly the statement that `u n ω < q` frequently along `atTop`.
Candidate subadditivity makes `u` bounded above by zero.  Consequently
`liminf u < c` puts the point in the rational event `D_c`.

The converse needs an explicit eventual lower bound.  This is not cosmetic:
Mathlib's real `liminf` is totalized in the absence of conditional-completeness
side conditions.  An unbounded-below sequence can therefore have a formal
real `liminf` that does not describe its extended lower limit.  The guarded
equivalence below keeps `IsBoundedUnder (· ≥ ·)` visible.

To prove the almost-everywhere lower estimate at `δ`, the strict event
`{liminf u < δ}` is covered by a countable union of RMT-32 events at rational
targets `c < δ`.  This avoids the invalid substitution `δ < δ`.  The same
null cover also provides an actual eventual lower bound almost everywhere,
so the later real-liminf algebra is semantically meaningful.

Finally, the exact centered-plus-Birkhoff identity and `le_liminf_add` transfer
the lower estimate back to the original process.  For a discrete matrix
cocycle, the centered offset plus the one-step integral is the integrated
log-positive growth rate.  RMT-29 supplies the matching upper limsup, and the
explicitly checked upper and lower boundedness hypotheses allow
`tendsto_of_le_liminf_of_limsup_le` to finish the first samplewise Kingman
convergence result in the project.

This is convergence of the nonnegative log-positive envelope only.  It proves
no `L¹` convergence, limit-integral interchange, signed logarithmic growth,
inverse control, Lyapunov exponent, or Oseledets splitting.
-/

open MeasureTheory Set Filter Topology Function
open scoped ENNReal Topology

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ uι

/-- The total positive-time normalization of a real process.  Division is
total at time zero, where the value is always zero. -/
def normalizedProcess {Ω : Type uΩ} (X : ℕ → Ω → ℝ)
    (n : ℕ) (ω : Ω) : ℝ :=
  X n ω / (n : ℝ)

/-- Time-zero normalization forgets the process value completely. -/
@[simp] theorem normalizedProcess_zero
    {Ω : Type uΩ} (X : ℕ → Ω → ℝ) (ω : Ω) :
    normalizedProcess X 0 ω = 0 := by
  simp [normalizedProcess]

/-- Replacing the time-zero slice leaves the total normalized process
pointwise unchanged at every horizon. -/
@[simp] theorem normalizedProcess_update_zero
    {Ω : Type uΩ} (X : ℕ → Ω → ℝ) (z : Ω → ℝ) :
    normalizedProcess (Function.update X 0 z) = normalizedProcess X := by
  funext n ω
  by_cases hn : n = 0
  · subst n
    simp
  · simp [normalizedProcess, Function.update, hn]

/-- The total normalized centered process.  At time zero it is zero by
totalized real division; all positive-time values have their usual meaning. -/
def normalizedCenteredProcess {Ω : Type uΩ} (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) (n : ℕ) (ω : Ω) : ℝ :=
  normalizedProcess (centeredProcess T X) n ω

/-- Time-zero normalization is always zero, independently of `X 0`. -/
@[simp] theorem normalizedCenteredProcess_zero
    {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (ω : Ω) :
    normalizedCenteredProcess T X 0 ω = 0 := by
  simp [normalizedCenteredProcess]

/-- Dropping the totalized time-zero term does not change the real lower
limit of any normalized process along natural time. -/
theorem liminf_normalizedProcess_succ
    {Ω : Type uΩ} (X : ℕ → Ω → ℝ) (ω : Ω) :
    liminf (fun n ↦ normalizedProcess X (n + 1) ω) atTop =
      liminf (fun n ↦ normalizedProcess X n ω) atTop := by
  exact liminf_nat_add (fun n ↦ normalizedProcess X n ω) 1

/-- The normalized original process is exactly the total normalized centered
process plus the one-step Birkhoff average, uniformly including time zero. -/
theorem normalized_eq_normalizedCenteredProcess_add_birkhoffAverage
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (n : ℕ) (ω : Ω) :
    normalizedProcess X n ω = normalizedCenteredProcess T X n ω +
      birkhoffAverage ℝ T (X 1) n ω :=
  normalized_eq_centered_add_birkhoffAverage n ω

/-- A fixed-slope arbitrarily-late centered bad-block event is exactly a
frequent strict inequality for the total normalized centered process.  The
positive witness in the event removes the time-zero division boundary. -/
theorem mem_centeredArbitrarilyLateBadBlockSet_iff_frequently_normalized_lt
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {q : ℝ} {ω : Ω} :
    ω ∈ centeredArbitrarilyLateBadBlockSet T X q ↔
      ∃ᶠ n in atTop, normalizedCenteredProcess T X n ω < q := by
  rw [mem_centeredArbitrarilyLateBadBlockSet_iff]
  constructor
  · intro h
    rw [frequently_atTop]
    intro N
    obtain ⟨n, hNn, hn, hbad⟩ := h N
    refine ⟨n, hNn, ?_⟩
    rw [normalizedCenteredProcess]
    exact (div_lt_iff₀ (Nat.cast_pos.mpr hn)).2 hbad
  · intro h N
    rw [frequently_atTop] at h
    obtain ⟨n, hnmax, hbad⟩ := h (max N 1)
    have hn : 0 < n := by omega
    refine ⟨n, by omega, hn, ?_⟩
    rw [normalizedCenteredProcess] at hbad
    exact (div_lt_iff₀ (Nat.cast_pos.mpr hn)).1 hbad

/-- Membership in the rationally generated event means that one rational
slope below the target is crossed frequently. -/
theorem mem_centeredStrictLowerDeviationSet_iff_exists_frequently_normalized_lt
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {c : ℝ} {ω : Ω} :
    ω ∈ centeredStrictLowerDeviationSet T X c ↔
      ∃ q : ℚ, (q : ℝ) < c ∧
        ∃ᶠ n in atTop, normalizedCenteredProcess T X n ω < (q : ℝ) := by
  rw [mem_centeredStrictLowerDeviationSet_iff]
  constructor
  · rintro ⟨q, hqc, hq⟩
    exact ⟨q, hqc,
      mem_centeredArbitrarilyLateBadBlockSet_iff_frequently_normalized_lt.mp hq⟩
  · rintro ⟨q, hqc, hq⟩
    exact ⟨q, hqc,
      mem_centeredArbitrarilyLateBadBlockSet_iff_frequently_normalized_lt.mpr hq⟩

/-- If the normalized centered sequence has an eventual lower bound, event
membership forces its real lower limit below the target.  The lower-bound gate
is necessary because real `liminf` is totalized for unbounded sequences. -/
theorem liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {c : ℝ} {ω : Ω}
    (hlower : IsBoundedUnder (· ≥ ·) atTop
      (fun n ↦ normalizedCenteredProcess T X n ω))
    (hω : ω ∈ centeredStrictLowerDeviationSet T X c) :
    liminf (fun n ↦ normalizedCenteredProcess T X n ω) atTop < c := by
  rw [mem_centeredStrictLowerDeviationSet_iff_exists_frequently_normalized_lt]
    at hω
  obtain ⟨q, hqc, hq⟩ := hω
  exact (liminf_le_of_frequently_le
    (hq.mono fun _ hn ↦ le_of_lt hn) hlower).trans_lt hqc

/-- The countable outer exhaustion used to turn strict lower-liminf deviation
at `δ` into RMT-32 events whose targets are all genuinely below `δ`. -/
def centeredRationalLowerDeviationExhaustionSet {Ω : Type uΩ}
    (T : Ω → Ω) (X : ℕ → Ω → ℝ) (δ : ℝ) : Set Ω :=
  ⋃ c : {c : ℚ // (c : ℝ) < δ},
    centeredStrictLowerDeviationSet T X (c : ℝ)

/-- Membership in the outer exhaustion exposes one rational target below
`δ` and membership in its RMT-32 strict event. -/
@[simp] theorem mem_centeredRationalLowerDeviationExhaustionSet_iff
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {δ : ℝ} {ω : Ω} :
    ω ∈ centeredRationalLowerDeviationExhaustionSet T X δ ↔
      ∃ c : ℚ, (c : ℝ) < δ ∧
        ω ∈ centeredStrictLowerDeviationSet T X (c : ℝ) := by
  simp only [centeredRationalLowerDeviationExhaustionSet, mem_iUnion,
    Subtype.exists, exists_prop]

/-- The strict real lower-liminf deviation event for the total normalized
centered process. -/
def centeredLowerLiminfDeviationSet {Ω : Type uΩ}
    (T : Ω → Ω) (X : ℕ → Ω → ℝ) (δ : ℝ) : Set Ω :=
  {ω | liminf (fun n ↦ normalizedCenteredProcess T X n ω) atTop < δ}

/-- Membership in the lower-liminf deviation event is its defining strict
real lower-limit inequality. -/
@[simp] theorem mem_centeredLowerLiminfDeviationSet_iff
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {c : ℝ} {ω : Ω} :
    ω ∈ centeredLowerLiminfDeviationSet T X c ↔
      liminf (fun n ↦ normalizedCenteredProcess T X n ω) atTop < c :=
  Iff.rfl

namespace IsIntegrableSubadditiveProcessCandidate

variable {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
  {μ : Measure Ω} {X : ℕ → Ω → ℝ}

/-- Candidate shifted subadditivity makes the total normalized centered
process pointwise nonpositive.  The time-zero case is handled separately by
totalized division. -/
theorem normalizedCenteredProcess_nonpos
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (n : ℕ) (ω : Ω) : normalizedCenteredProcess T X n ω ≤ 0 := by
  cases n with
  | zero => simp
  | succ n =>
      exact div_nonpos_of_nonpos_of_nonneg
        (hX.centeredProcess_nonpos_of_ne_zero (n + 1)
          (Nat.succ_ne_zero n) ω)
        (Nat.cast_nonneg (n + 1))

/-- A strict real lower-liminf deviation puts the point in the rationally
generated RMT-32 event.  Only the candidate's normalized upper bound is needed
in this direction. -/
theorem mem_centeredStrictLowerDeviationSet_of_liminf_normalizedCenteredProcess_lt
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    {c : ℝ} {ω : Ω}
    (hlim : liminf (fun n ↦ normalizedCenteredProcess T X n ω) atTop < c) :
    ω ∈ centeredStrictLowerDeviationSet T X c := by
  obtain ⟨q, hlq, hqc⟩ := exists_rat_btwn hlim
  rw [mem_centeredStrictLowerDeviationSet_iff_exists_frequently_normalized_lt]
  refine ⟨q, hqc, frequently_lt_of_liminf_lt ?_ hlq⟩
  exact isCoboundedUnder_ge_of_le atTop
    (fun n ↦ hX.normalizedCenteredProcess_nonpos n ω)

/-- Under an explicit eventual lower bound, the RMT-32 rational event is
exactly strict deviation of the real lower limit. -/
theorem mem_centeredStrictLowerDeviationSet_iff_liminf_normalizedCenteredProcess_lt
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    {c : ℝ} {ω : Ω}
    (hlower : IsBoundedUnder (· ≥ ·) atTop
      (fun n ↦ normalizedCenteredProcess T X n ω)) :
    ω ∈ centeredStrictLowerDeviationSet T X c ↔
      liminf (fun n ↦ normalizedCenteredProcess T X n ω) atTop < c := by
  constructor
  · exact liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet
      hlower
  · exact hX.mem_centeredStrictLowerDeviationSet_of_liminf_normalizedCenteredProcess_lt

/-- Every strict centered lower-liminf deviation at `δ` belongs to one RMT-32
event whose rational target is itself strictly below `δ`.  Two rational
margins are chosen: an outer target and the inner witness slope. -/
theorem centeredLowerLiminfDeviationSet_subset_rationalExhaustion
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X) (δ : ℝ) :
    centeredLowerLiminfDeviationSet T X δ ⊆
      centeredRationalLowerDeviationExhaustionSet T X δ := by
  intro ω hω
  change liminf (fun n ↦ normalizedCenteredProcess T X n ω) atTop < δ at hω
  obtain ⟨c, hlc, hcδ⟩ := exists_rat_btwn hω
  rw [mem_centeredRationalLowerDeviationExhaustionSet_iff]
  exact ⟨c, hcδ,
    hX.mem_centeredStrictLowerDeviationSet_of_liminf_normalizedCenteredProcess_lt hlc⟩

/-- On an ergodic probability base, the rational exhaustion below `δ` is
null whenever `δ` is a lower bound for every positive normalized centered
integral. -/
theorem measure_centeredRationalLowerDeviationExhaustionSet_eq_zero
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (δ : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ)) :
    μ (centeredRationalLowerDeviationExhaustionSet T X δ) = 0 := by
  rw [centeredRationalLowerDeviationExhaustionSet]
  exact measure_iUnion_null fun c ↦
    hX.measure_centeredStrictLowerDeviationSet_eq_zero hT
      δ (c : ℝ) hδ c.property

/-- The strict real lower-liminf deviation event below `δ` is null.  The proof
uses the rational exhaustion rather than the unavailable hypothesis
`δ < δ`. -/
theorem measure_centeredLowerLiminfDeviationSet_eq_zero
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (δ : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ)) :
    μ (centeredLowerLiminfDeviationSet T X δ) = 0 :=
  measure_mono_null
    (hX.centeredLowerLiminfDeviationSet_subset_rationalExhaustion δ)
    (hX.measure_centeredRationalLowerDeviationExhaustionSet_eq_zero hT δ hδ)

/-- Off the null rational exhaustion, one fixed rational slope supplies an
actual eventual lower bound for the normalized centered sequence. -/
private theorem ae_isBoundedUnder_ge_normalizedCenteredProcess
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (δ : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ)) :
    ∀ᵐ ω ∂μ, IsBoundedUnder (· ≥ ·) atTop
      (fun n ↦ normalizedCenteredProcess T X n ω) := by
  have hzero :=
    hX.measure_centeredRationalLowerDeviationExhaustionSet_eq_zero hT δ hδ
  rw [measure_eq_zero_iff_ae_notMem] at hzero
  filter_upwards [hzero] with ω hω
  obtain ⟨q, hqδ⟩ := exists_rat_lt δ
  obtain ⟨c, hqc, hcδ⟩ := exists_rat_btwn hqδ
  have hnotD : ω ∉ centeredStrictLowerDeviationSet T X (c : ℝ) := by
    intro hD
    exact hω (mem_centeredRationalLowerDeviationExhaustionSet_iff.mpr
      ⟨c, hcδ, hD⟩)
  have hnotfreq : ¬ ∃ᶠ n in atTop,
      normalizedCenteredProcess T X n ω < (q : ℝ) := by
    intro hfreq
    apply hnotD
    rw [mem_centeredStrictLowerDeviationSet_iff_exists_frequently_normalized_lt]
    exact ⟨q, hqc, hfreq⟩
  refine ⟨(q : ℝ), ?_⟩
  exact (not_frequently.mp hnotfreq).mono fun _ hn ↦ le_of_not_gt hn

/-- The honest generic centered lower endpoint: almost every normalized
centered sequence is eventually bounded below and has real lower limit at
least `δ`.  Returning both facts prevents totalized `liminf` from being
mistaken for an extended-real conclusion. -/
theorem ae_isBoundedUnder_ge_and_le_liminf_normalizedCenteredProcess
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (δ : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ)) :
    ∀ᵐ ω ∂μ,
      IsBoundedUnder (· ≥ ·) atTop
          (fun n ↦ normalizedCenteredProcess T X n ω) ∧
        δ ≤ liminf
          (fun n ↦ normalizedCenteredProcess T X n ω) atTop := by
  have hbad := hX.measure_centeredLowerLiminfDeviationSet_eq_zero hT δ hδ
  rw [measure_eq_zero_iff_ae_notMem] at hbad
  filter_upwards
      [hX.ae_isBoundedUnder_ge_normalizedCenteredProcess hT δ hδ, hbad]
      with ω hlower hω
  exact ⟨hlower, by
    simpa only [centeredLowerLiminfDeviationSet, mem_setOf_eq, not_lt]
      using hω⟩

/-- Adding back the convergent one-step Birkhoff average transfers the
centered lower estimate to the original process. -/
theorem ae_add_oneStepIntegral_le_liminf_normalized
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (δ : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ)) :
    ∀ᵐ ω ∂μ,
      δ + ∫ x, X 1 x ∂μ ≤
        liminf (fun n ↦ normalizedProcess X n ω) atTop := by
  filter_upwards
      [hX.ae_isBoundedUnder_ge_and_le_liminf_normalizedCenteredProcess
        hT δ hδ,
        ae_tendsto_birkhoffAverage_integral_of_ergodic hT (hX.integrable 1)]
      with ω hcenter hBirkhoff
  let u : ℕ → ℝ := fun n ↦ normalizedCenteredProcess T X n ω
  let v : ℕ → ℝ := fun n ↦ birkhoffAverage ℝ T (X 1) n ω
  have hcenterUpper : IsBoundedUnder (· ≤ ·) atTop u := by
    exact isBoundedUnder_of ⟨0,
      fun (n : ℕ) ↦ hX.normalizedCenteredProcess_nonpos n ω⟩
  have hadd : liminf u atTop + liminf v atTop ≤ liminf (u + v) atTop :=
    le_liminf_add hcenter.1 hcenterUpper
      hBirkhoff.isBoundedUnder_ge
      hBirkhoff.isBoundedUnder_le.isCoboundedUnder_ge
  calc
    δ + ∫ x, X 1 x ∂μ ≤ liminf u atTop + liminf v atTop := by
      rw [hBirkhoff.liminf_eq]
      have hδlim : δ ≤ liminf u atTop := hcenter.2
      exact add_le_add hδlim le_rfl
    _ ≤ liminf (u + v) atTop := hadd
    _ = liminf (fun n ↦ normalizedProcess X n ω) atTop := by
      apply liminf_congr
      filter_upwards with n
      exact (normalized_eq_normalizedCenteredProcess_add_birkhoffAverage
        n ω).symm

end IsIntegrableSubadditiveProcessCandidate

namespace DiscreteMatrixCocycle

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-- The normalized log-positive cocycle process has almost-everywhere lower
limit at least its integrated Fekete growth rate.  Empty matrix dimension
remains valid. -/
theorem HasIntegrableGeneratorLogPlus.ae_integratedLogPlusGrowthRate_le_liminf_normalized
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (hT : PreErgodic C.base μ) :
    ∀ᵐ ω ∂μ,
      C.integratedLogPlusGrowthRate hC ≤
        liminf
          (fun n ↦ normalizedProcess C.logPlusNormObservable n ω) atTop := by
  let hX := hC.isIntegrableSubadditiveProcessCandidate
  let hErg : Ergodic C.base μ := ⟨C.base_preserving, hT⟩
  filter_upwards
      [hX.ae_add_oneStepIntegral_le_liminf_normalized hErg
        (C.integratedLogPlusGrowthRate hC - C.integratedLogPlusNorm 1)
        hC.centeredFeketeOffset_le_normalizedIntegral]
      with ω hω
  simpa only [integratedLogPlusNorm, sub_add_cancel] using hω

/-- On an ergodic probability base, the full normalized log-positive cocycle
process converges almost everywhere to the integrated Fekete growth rate.
This is the project's log-positive Kingman endpoint, not a signed Lyapunov
exponent theorem. -/
theorem HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedLogPlusNormObservable
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (hT : PreErgodic C.base μ) :
    ∀ᵐ ω ∂μ,
      Tendsto
        (fun n ↦ normalizedProcess C.logPlusNormObservable n ω) atTop
        (𝓝 (C.integratedLogPlusGrowthRate hC)) := by
  let hX := hC.isIntegrableSubadditiveProcessCandidate
  let hErg : Ergodic C.base μ := ⟨C.base_preserving, hT⟩
  filter_upwards
      [hC.ae_integratedLogPlusGrowthRate_le_liminf_normalized hT,
        hC.ae_limsup_normalized_le_integratedLogPlusGrowthRate hErg,
        ae_tendsto_birkhoffAverage_integral_of_ergodic hErg hC]
      with ω hlower hupper hBirkhoff
  have hnormLower : IsBoundedUnder (· ≥ ·) atTop
      (fun n ↦ normalizedProcess C.logPlusNormObservable n ω) := by
    exact isBoundedUnder_of ⟨0, fun (n : ℕ) ↦
      div_nonneg (C.logPlusNormObservable_nonneg n ω) (Nat.cast_nonneg n)⟩
  have hnorm_le_avg :
      (fun n ↦ normalizedProcess C.logPlusNormObservable n ω) ≤ᶠ[atTop]
        (fun n ↦ birkhoffAverage ℝ C.base
          (C.logPlusNormObservable 1) n ω) := by
    filter_upwards [eventually_ge_atTop 1] with n hn
    simpa only [normalizedProcess, birkhoffAverage, smul_eq_mul,
      div_eq_inv_mul] using
      (div_le_div_iff_of_pos_right (Nat.cast_pos.mpr hn)).2
        (hX.oneStepBirkhoffMajorant_of_ne_zero n (by omega) ω)
  have hnormUpper : IsBoundedUnder (· ≤ ·) atTop
      (fun n ↦ normalizedProcess C.logPlusNormObservable n ω) :=
    hBirkhoff.isBoundedUnder_le.mono_le hnorm_le_avg
  exact tendsto_of_le_liminf_of_limsup_le
    hlower hupper hnormUpper hnormLower

end DiscreteMatrixCocycle

section BoundaryAudits

private def rmt33ZeroProcess {Ω : Type*} (_n : ℕ) (_ω : Ω) : ℝ := 0

/-- The zero process has lower limit zero and no strict lower-liminf deviation
at the zero target. -/
example {Ω : Type*} (T : Ω → Ω) (ω : Ω) :
    liminf
        (fun n ↦ normalizedCenteredProcess T
          (rmt33ZeroProcess : ℕ → Ω → ℝ) n ω) atTop = 0 ∧
      centeredLowerLiminfDeviationSet T
        (rmt33ZeroProcess : ℕ → Ω → ℝ) 0 = ∅ := by
  constructor
  · simp [normalizedCenteredProcess, normalizedProcess, centeredProcess,
      rmt33ZeroProcess, birkhoffSum]
  · ext x
    simp [centeredLowerLiminfDeviationSet, normalizedCenteredProcess,
      normalizedProcess, centeredProcess, rmt33ZeroProcess, birkhoffSum]

/-- An arbitrary replacement at time zero leaves every normalized value, and
therefore the lower limit, unchanged. -/
example {Ω : Type*} (X : ℕ → Ω → ℝ) (z : Ω → ℝ) (ω : Ω) :
    liminf (fun n ↦ normalizedProcess (Function.update X 0 z) n ω) atTop =
      liminf (fun n ↦ normalizedProcess X n ω) atTop := by
  simp

private def rmt33ApproachZeroFromBelow (n : ℕ) : ℝ :=
  (-1 : ℝ) / (n : ℝ)

private theorem rmt33ApproachZeroFromBelow_tendsto :
    Tendsto rmt33ApproachZeroFromBelow atTop (nhds 0) := by
  change Tendsto (fun n : ℕ ↦ (-1 : ℝ) / (n : ℝ)) atTop (nhds 0)
  exact tendsto_const_div_atTop_nhds_zero_nat (-1 : ℝ)

private theorem rmt33ApproachZeroFromBelow_frequently_neg :
    ∃ᶠ n in atTop, rmt33ApproachZeroFromBelow n < 0 := by
  rw [frequently_atTop]
  intro N
  refine ⟨max N 1, le_max_left _ _, ?_⟩
  rw [rmt33ApproachZeroFromBelow]
  exact div_neg_of_neg_of_pos (by norm_num) (by positivity)

private theorem rmt33ApproachZeroFromBelow_not_frequently_below
    (q : ℚ) (hq : (q : ℝ) < 0) :
    ¬ ∃ᶠ n in atTop, rmt33ApproachZeroFromBelow n < (q : ℝ) := by
  have hevent : ∀ᶠ n in atTop, (q : ℝ) < rmt33ApproachZeroFromBelow n :=
    rmt33ApproachZeroFromBelow_tendsto.eventually (Ioi_mem_nhds hq)
  exact not_frequently.mpr
    (hevent.mono fun _ hn ↦ not_lt_of_ge hn.le)

/-- A sequence may cross its limiting target strictly and frequently while
retaining no fixed rational margin below that target. -/
example :
    liminf rmt33ApproachZeroFromBelow atTop = 0 ∧
      (∃ᶠ n in atTop, rmt33ApproachZeroFromBelow n < 0) ∧
      ∀ q : ℚ, (q : ℝ) < 0 →
        ¬ ∃ᶠ n in atTop, rmt33ApproachZeroFromBelow n < (q : ℝ) := by
  exact ⟨rmt33ApproachZeroFromBelow_tendsto.liminf_eq,
    rmt33ApproachZeroFromBelow_frequently_neg,
    rmt33ApproachZeroFromBelow_not_frequently_below⟩

private def rmt33QuadraticEscapeProcess (n : ℕ) (_u : Unit) : ℝ :=
  -((n : ℝ) ^ 2)

private theorem rmt33QuadraticEscapeProcess_candidate :
    IsIntegrableSubadditiveProcessCandidate (id : Unit → Unit)
      (Measure.dirac ()) rmt33QuadraticEscapeProcess where
  integrable := by
    intro n
    exact integrable_const _
  add_le := by
    intro m n u
    simp only [rmt33QuadraticEscapeProcess]
    push_cast
    have hm : (0 : ℝ) ≤ (m : ℝ) := Nat.cast_nonneg m
    have hn : (0 : ℝ) ≤ (n : ℝ) := Nat.cast_nonneg n
    nlinarith [mul_nonneg hm hn]

private theorem rmt33QuadraticEscape_centered (n : ℕ) :
    centeredProcess id rmt33QuadraticEscapeProcess n () =
      -((n : ℝ) ^ 2) + (n : ℝ) := by
  simp [centeredProcess, birkhoffSum, rmt33QuadraticEscapeProcess]

private theorem rmt33QuadraticEscape_mem :
    () ∈ centeredStrictLowerDeviationSet id rmt33QuadraticEscapeProcess (-1) := by
  rw [mem_centeredStrictLowerDeviationSet_iff]
  refine ⟨(-2 : ℚ), by norm_num, ?_⟩
  rw [mem_centeredArbitrarilyLateBadBlockSet_iff]
  intro N
  refine ⟨N + 4, by omega, by omega, ?_⟩
  rw [rmt33QuadraticEscape_centered]
  push_cast
  nlinarith [sq_nonneg (N : ℝ)]

private theorem rmt33QuadraticEscape_liminf :
    liminf
        (fun n ↦ normalizedCenteredProcess id rmt33QuadraticEscapeProcess n ())
        atTop = 0 := by
  change liminf
    (fun n ↦ normalizedProcess
      (centeredProcess id rmt33QuadraticEscapeProcess) n ()) atTop = 0
  rw [← liminf_normalizedProcess_succ
    (centeredProcess id rmt33QuadraticEscapeProcess) ()]
  calc
    liminf
        (fun n ↦ normalizedCenteredProcess id rmt33QuadraticEscapeProcess
          (n + 1) ()) atTop =
        liminf (fun n : ℕ ↦ -(n : ℝ)) atTop := by
      apply liminf_congr
      filter_upwards with n
      rw [normalizedCenteredProcess, normalizedProcess,
        rmt33QuadraticEscape_centered]
      have hne : (((n + 1 : ℕ) : ℝ)) ≠ 0 := by positivity
      push_cast
      field_simp
      ring
    _ = 0 := by
      rw [liminf_eq]
      have hempty :
          {a : ℝ | ∀ᶠ n : ℕ in atTop, a ≤ -(n : ℝ)} = ∅ := by
        rw [Set.eq_empty_iff_forall_notMem]
        intro a ha
        change ∀ᶠ n : ℕ in atTop, a ≤ -(n : ℝ) at ha
        rw [eventually_atTop] at ha
        obtain ⟨N, hN⟩ := ha
        obtain ⟨n, hn⟩ := exists_nat_gt (-a)
        have hcast : (n : ℝ) ≤ (max N n : ℕ) := by
          exact_mod_cast le_max_right N n
        have hbound := hN (max N n) (le_max_left N n)
        linarith
      rw [hempty, Real.sSup_empty]

/-- Without an eventual lower bound, even a genuine subadditive candidate can
belong to the rational lower-deviation event while Mathlib's totalized real
`liminf` remains zero. -/
example :
    IsIntegrableSubadditiveProcessCandidate (id : Unit → Unit)
        (Measure.dirac ()) rmt33QuadraticEscapeProcess ∧
      () ∈ centeredStrictLowerDeviationSet id rmt33QuadraticEscapeProcess (-1) ∧
      ¬ IsBoundedUnder (· ≥ ·) atTop
        (fun n ↦ normalizedCenteredProcess id rmt33QuadraticEscapeProcess n ()) ∧
      ¬ liminf
        (fun n ↦ normalizedCenteredProcess id rmt33QuadraticEscapeProcess n ())
          atTop < -1 := by
  refine ⟨rmt33QuadraticEscapeProcess_candidate, rmt33QuadraticEscape_mem,
    ?_, ?_⟩
  · intro hlower
    have hfalse :=
      liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet
        hlower rmt33QuadraticEscape_mem
    rw [rmt33QuadraticEscape_liminf] at hfalse
    norm_num at hfalse
  · rw [rmt33QuadraticEscape_liminf]
    norm_num

/-- The final log-positive convergence theorem retains the empty matrix-index
boundary. -/
example {Ω : Type uΩ} [MeasurableSpace Ω] {μ : Measure Ω}
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := Empty) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (hT : PreErgodic C.base μ) :
    ∀ᵐ ω ∂μ,
      Tendsto
        (fun n ↦ normalizedProcess C.logPlusNormObservable n ω) atTop
        (nhds (C.integratedLogPlusGrowthRate hC)) :=
  hC.ae_tendsto_normalizedLogPlusNormObservable hT

end BoundaryAudits

#print axioms normalizedProcess_update_zero
#print axioms liminf_normalizedProcess_succ
#print axioms mem_centeredArbitrarilyLateBadBlockSet_iff_frequently_normalized_lt
#print axioms liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet
#print axioms IsIntegrableSubadditiveProcessCandidate.mem_centeredStrictLowerDeviationSet_of_liminf_normalizedCenteredProcess_lt
#print axioms IsIntegrableSubadditiveProcessCandidate.centeredLowerLiminfDeviationSet_subset_rationalExhaustion
#print axioms IsIntegrableSubadditiveProcessCandidate.measure_centeredLowerLiminfDeviationSet_eq_zero
#print axioms IsIntegrableSubadditiveProcessCandidate.ae_isBoundedUnder_ge_and_le_liminf_normalizedCenteredProcess
#print axioms IsIntegrableSubadditiveProcessCandidate.ae_add_oneStepIntegral_le_liminf_normalized
#print axioms DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_integratedLogPlusGrowthRate_le_liminf_normalized
#print axioms DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedLogPlusNormObservable

end NonlinearDynamics.Random.RandomCocycles
