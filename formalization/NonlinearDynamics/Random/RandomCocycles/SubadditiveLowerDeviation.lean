import NonlinearDynamics.Random.RandomCocycles.SubadditiveAllLengthBadBlockMeasure

/-!
# Countably generated centered lower-deviation events

RMT-31 controls the event that one strict centered bad block occurs at some
positive length.  That event is too coarse for an asymptotic argument.  This
module instead asks for witnesses beyond every finite cutoff, first at one
fixed slope `q`, then with one rational slope strictly below a target `c`.

The rational margin is essential.  Values can lie below `c` at every time
while their normalized slopes approach `c` from below.  Requiring one fixed
rational `q < c` gives a durable gap and keeps the event countably generated.

Centered shifted subadditivity gives

`centeredProcess T X (n + 1) ω ≤ centeredProcess T X n (T ω)`.

For `q < r`, the endpoint cost is absorbed eventually by
`q * n < r * (n + 1)`.  Thus the preimage of the event at `q` lies in the
event at `r`; rational density then gives a same-target one-sided preimage
inclusion for the rationally exhausted event.  Preservation and finite mass
upgrade that inclusion to almost-everywhere equality.  Ergodicity supplies an
almost-empty or almost-full dichotomy, while probability normalization and
RMT-31's strict ratio select the empty branch.

The final specialization applies this architecture to a discrete matrix
cocycle's log-positive norm process.  This module does not identify the event
with a library-level real `liminf`, prove samplewise Kingman convergence,
interchange a limit and integral, construct a signed logarithmic rate, define
a Lyapunov exponent, or prove an Oseledets splitting.
-/

open MeasureTheory Set Filter Topology Function
open scoped ENNReal Topology

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ uι

/-- Points with a strict centered block below slope `q` beyond every finite
cutoff.  The witness length is always positive. -/
def centeredArbitrarilyLateBadBlockSet {Ω : Type uΩ} (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) (q : ℝ) : Set Ω :=
  ⋂ N : ℕ, ⋃ n : ℕ, ⋃ (_h : N ≤ n ∧ 0 < n),
    {ω | centeredProcess T X n ω < q * (n : ℝ)}

/-- Membership means that a positive strict witness exists beyond every
finite cutoff. -/
@[simp] theorem mem_centeredArbitrarilyLateBadBlockSet_iff
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {q : ℝ} {ω : Ω} :
    ω ∈ centeredArbitrarilyLateBadBlockSet T X q ↔
      ∀ N : ℕ, ∃ n : ℕ, N ≤ n ∧ 0 < n ∧
        centeredProcess T X n ω < q * (n : ℝ) := by
  simp only [centeredArbitrarilyLateBadBlockSet, Set.mem_iInter,
    Set.mem_iUnion, Set.mem_setOf_eq]
  constructor
  · intro h N
    obtain ⟨n, hn, hbad⟩ := h N
    exact ⟨n, hn.1, hn.2, hbad⟩
  · rintro h N
    obtain ⟨n, hNn, hn, hbad⟩ := h N
    exact ⟨n, ⟨hNn, hn⟩, hbad⟩

/-- The strict centered lower-deviation event below `c`: some rational slope
strictly below `c` has positive bad blocks arbitrarily late. -/
def centeredStrictLowerDeviationSet {Ω : Type uΩ} (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) (c : ℝ) : Set Ω :=
  ⋃ q : ℚ, ⋃ (_h : (q : ℝ) < c),
    centeredArbitrarilyLateBadBlockSet T X (q : ℝ)

/-- Membership in the strict event exposes one durable rational margin below
the target slope. -/
@[simp] theorem mem_centeredStrictLowerDeviationSet_iff
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {c : ℝ} {ω : Ω} :
    ω ∈ centeredStrictLowerDeviationSet T X c ↔
      ∃ q : ℚ, (q : ℝ) < c ∧
        ω ∈ centeredArbitrarilyLateBadBlockSet T X (q : ℝ) := by
  simp only [centeredStrictLowerDeviationSet, Set.mem_iUnion]
  constructor
  · rintro ⟨q, hqc, hq⟩
    exact ⟨q, hqc, hq⟩
  · rintro ⟨q, hqc, hq⟩
    exact ⟨q, hqc, hq⟩

/-- If `q < r`, the endpoint added by a one-step shift is eventually absorbed
by the slope gap. -/
theorem exists_nat_forall_mul_lt_mul_succ {q r : ℝ} (hqr : q < r) :
    ∃ N : ℕ, ∀ n : ℕ, N ≤ n →
      q * (n : ℝ) < r * ((n + 1 : ℕ) : ℝ) := by
  obtain ⟨N, hN⟩ := exists_nat_gt ((-r) / (r - q))
  refine ⟨N, fun n hNn ↦ ?_⟩
  have hpos : 0 < r - q := sub_pos.mpr hqr
  have hquot : (-r) / (r - q) < (n : ℝ) :=
    hN.trans_le (by exact_mod_cast hNn)
  have hmul : -r < (r - q) * (n : ℝ) := by
    simpa only [mul_comm] using (div_lt_iff₀ hpos).mp hquot
  push_cast
  linarith

/-- Arbitrarily-late witnesses in particular supply one positive finite
witness at the same slope. -/
theorem centeredArbitrarilyLateBadBlockSet_subset_allLength
    {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (q : ℝ) :
    centeredArbitrarilyLateBadBlockSet T X q ⊆
      centeredAllLengthBadBlockSet T X q := by
  intro ω hω
  rw [mem_centeredArbitrarilyLateBadBlockSet_iff] at hω
  rw [mem_centeredAllLengthBadBlockSet_iff]
  obtain ⟨n, _hNn, hn, hbad⟩ := hω 0
  exact ⟨n, hn, hbad⟩

/-- The rationally exhausted strict event lies in RMT-31's once-bad event at
the target slope. -/
theorem centeredStrictLowerDeviationSet_subset_allLength
    {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (c : ℝ) :
    centeredStrictLowerDeviationSet T X c ⊆
      centeredAllLengthBadBlockSet T X c := by
  intro ω hω
  rw [mem_centeredStrictLowerDeviationSet_iff] at hω
  obtain ⟨q, hqc, hq⟩ := hω
  rw [mem_centeredArbitrarilyLateBadBlockSet_iff] at hq
  rw [mem_centeredAllLengthBadBlockSet_iff]
  obtain ⟨n, _hNn, hn, hbad⟩ := hq 0
  refine ⟨n, hn, hbad.trans ?_⟩
  exact mul_lt_mul_of_pos_right hqc (by exact_mod_cast hn)

namespace IsIntegrableSubadditiveProcessCandidate

variable {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
  {μ : Measure Ω} {X : ℕ → Ω → ℝ}

/-- Candidate integrability and base preservation make the fixed-slope
arbitrarily-late event null measurable.  Finite total mass is not needed. -/
theorem nullMeasurableSet_centeredArbitrarilyLateBadBlockSet
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (q : ℝ) :
    NullMeasurableSet (centeredArbitrarilyLateBadBlockSet T X q) μ := by
  rw [centeredArbitrarilyLateBadBlockSet]
  exact NullMeasurableSet.iInter fun N ↦
    NullMeasurableSet.iUnion fun n ↦
      NullMeasurableSet.iUnion fun _hn ↦
        nullMeasurableSet_lt
          (hX.integrable_centeredProcess hT n).aemeasurable
          measurable_const.aemeasurable

/-- The rationally exhausted strict lower-deviation event is null measurable
under the same assumptions. -/
theorem nullMeasurableSet_centeredStrictLowerDeviationSet
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (c : ℝ) :
    NullMeasurableSet (centeredStrictLowerDeviationSet T X c) μ := by
  rw [centeredStrictLowerDeviationSet]
  exact NullMeasurableSet.iUnion fun q ↦
    NullMeasurableSet.iUnion fun _hqc ↦
      hX.nullMeasurableSet_centeredArbitrarilyLateBadBlockSet hT (q : ℝ)

/-- A witness beyond every cutoff at slope `q` pulls back to witnesses at any
strictly larger slope `r`.  The threshold relaxation is genuine. -/
theorem preimage_centeredArbitrarilyLateBadBlockSet_subset_of_lt
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    {q r : ℝ} (hqr : q < r) :
    T ⁻¹' centeredArbitrarilyLateBadBlockSet T X q ⊆
      centeredArbitrarilyLateBadBlockSet T X r := by
  obtain ⟨K, hK⟩ := exists_nat_forall_mul_lt_mul_succ hqr
  intro ω hω
  rw [mem_preimage, mem_centeredArbitrarilyLateBadBlockSet_iff] at hω
  rw [mem_centeredArbitrarilyLateBadBlockSet_iff]
  intro N
  obtain ⟨n, hnmax, hn, hbad⟩ := hω (max N K)
  refine ⟨n + 1, by omega, by omega, ?_⟩
  have hsub := hX.centeredProcess_add_le 1 n ω
  simp only [Function.iterate_one, centeredProcess_one,
    Pi.zero_apply, add_zero] at hsub
  simpa only [Nat.one_add] using
    hsub.trans_lt (hbad.trans (hK n (by omega)))

/-- Rational density turns the relaxed fixed-slope inclusions into an exact
same-target one-sided preimage inclusion for the strict event. -/
theorem preimage_centeredStrictLowerDeviationSet_subset
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X) (c : ℝ) :
    T ⁻¹' centeredStrictLowerDeviationSet T X c ⊆
      centeredStrictLowerDeviationSet T X c := by
  intro ω hω
  rw [mem_preimage, mem_centeredStrictLowerDeviationSet_iff] at hω
  obtain ⟨q, hqc, hq⟩ := hω
  obtain ⟨r, hqr, hrc⟩ := exists_rat_btwn hqc
  rw [mem_centeredStrictLowerDeviationSet_iff]
  refine ⟨r, hrc, ?_⟩
  exact hX.preimage_centeredArbitrarilyLateBadBlockSet_subset_of_lt hqr hq

/-- On a finite preserved measure space, the one-sided preimage inclusion has
equal finite measure on both sides and therefore becomes almost-everywhere
equality. -/
theorem preimage_centeredStrictLowerDeviationSet_ae_eq
    [IsFiniteMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (c : ℝ) :
    T ⁻¹' centeredStrictLowerDeviationSet T X c =ᵐ[μ]
      centeredStrictLowerDeviationSet T X c := by
  let s := centeredStrictLowerDeviationSet T X c
  have hs : NullMeasurableSet s μ :=
    hX.nullMeasurableSet_centeredStrictLowerDeviationSet hT c
  exact ae_eq_of_subset_of_measure_ge
    (hX.preimage_centeredStrictLowerDeviationSet_subset c)
    (hT.measure_preimage hs).ge
    (hs.preimage hT.quasiMeasurePreserving) (by finiteness)

/-- Finite-measure ergodicity makes the strict lower-deviation event almost
empty or almost full.  Probability normalization is not needed for this
dichotomy. -/
theorem centeredStrictLowerDeviationSet_ae_empty_or_univ
    [IsFiniteMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (c : ℝ) :
    centeredStrictLowerDeviationSet T X c =ᵐ[μ] (∅ : Set Ω) ∨
      centeredStrictLowerDeviationSet T X c =ᵐ[μ] Set.univ := by
  exact hT.quasiErgodic.ae_empty_or_univ₀
    (hX.nullMeasurableSet_centeredStrictLowerDeviationSet
      hT.toMeasurePreserving c)
    (hX.preimage_centeredStrictLowerDeviationSet_ae_eq
      hT.toMeasurePreserving c)

/-- On an ergodic probability space, the strict lower-deviation event has
extended measure zero or one. -/
theorem measure_centeredStrictLowerDeviationSet_eq_zero_or_one
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (c : ℝ) :
    μ (centeredStrictLowerDeviationSet T X c) = 0 ∨
      μ (centeredStrictLowerDeviationSet T X c) = 1 := by
  rcases hX.centeredStrictLowerDeviationSet_ae_empty_or_univ hT c with h0 | h1
  · exact Or.inl (ae_eq_empty.mp h0)
  · exact Or.inr (by simpa using measure_congr h1)

/-- RMT-31's all-length ratio makes the strict lower-deviation event have real
mass strictly below one.  This theorem needs finite mass and preservation but
not probability or ergodicity. -/
theorem measureReal_centeredStrictLowerDeviationSet_lt_one
    [IsFiniteMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (δ c : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ))
    (hc : c < δ) :
    μ.real (centeredStrictLowerDeviationSet T X c) < 1 := by
  have hδnonpos : δ ≤ 0 := by
    simpa only [centeredProcess_one, Pi.zero_apply, integral_zero,
      Nat.cast_one, zero_div] using hδ 1 one_ne_zero
  have hcneg : c < 0 := hc.trans_le hδnonpos
  calc
    μ.real (centeredStrictLowerDeviationSet T X c) ≤
        μ.real (centeredAllLengthBadBlockSet T X c) :=
      measureReal_mono (centeredStrictLowerDeviationSet_subset_allLength T X c)
    _ ≤ δ / c :=
      hX.measureReal_centeredAllLengthBadBlockSet_le_rateRatio hT δ c hδ hc
    _ < 1 := (div_lt_one_of_neg hcneg).2 hc

/-- Probability normalization turns the strict subunit estimate into null
branch selection. -/
theorem measure_centeredStrictLowerDeviationSet_eq_zero
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (δ c : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ))
    (hc : c < δ) :
    μ (centeredStrictLowerDeviationSet T X c) = 0 := by
  rcases hX.measure_centeredStrictLowerDeviationSet_eq_zero_or_one hT c with h0 | h1
  · exact h0
  · have hreal : μ.real (centeredStrictLowerDeviationSet T X c) = 1 := by
      simp [Measure.real, h1]
    have hlt := hX.measureReal_centeredStrictLowerDeviationSet_lt_one
      hT.toMeasurePreserving δ c hδ hc
    linarith

end IsIntegrableSubadditiveProcessCandidate

namespace DiscreteMatrixCocycle

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-- Arbitrarily-late centered bad blocks for a cocycle's log-positive norm
process at one real slope. -/
def centeredLogPlusArbitrarilyLateBadBlockSet
    (C : DiscreteMatrixCocycle (ι := ι) μ) (q : ℝ) : Set Ω :=
  centeredArbitrarilyLateBadBlockSet C.base C.logPlusNormObservable q

/-- The rationally generated strict centered lower-deviation event for a
cocycle's log-positive norm process. -/
def centeredLogPlusStrictLowerDeviationSet
    (C : DiscreteMatrixCocycle (ι := ι) μ) (c : ℝ) : Set Ω :=
  centeredStrictLowerDeviationSet C.base C.logPlusNormObservable c

/-- Below the integrated centered Fekete offset, the cocycle's strict
lower-deviation event is null on an ergodic probability base.  Empty matrix
dimension remains valid. -/
theorem HasIntegrableGeneratorLogPlus.measure_centeredLogPlusStrictLowerDeviationSet_eq_zero
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (hErg : Ergodic C.base μ)
    (c : ℝ)
    (hc : c < C.integratedLogPlusGrowthRate hC -
      C.integratedLogPlusNorm 1) :
    μ (C.centeredLogPlusStrictLowerDeviationSet c) = 0 := by
  let hX := hC.isIntegrableSubadditiveProcessCandidate
  exact hX.measure_centeredStrictLowerDeviationSet_eq_zero hErg
    (C.integratedLogPlusGrowthRate hC - C.integratedLogPlusNorm 1) c
    hC.centeredFeketeOffset_le_normalizedIntegral hc

end DiscreteMatrixCocycle

section BoundaryAudits

private def rmt32ZeroProcess {Ω : Type*} (_n : ℕ) (_ω : Ω) : ℝ := 0

private def rmt32Collapse (_b : Bool) : Bool := true

private def rmt32OneShotProcess (n : ℕ) (b : Bool) : ℝ :=
  if b then 0 else if 2 ≤ n then -1 else 0

private theorem rmt32_iterate_collapse_true (n : ℕ) :
    rmt32Collapse^[n] true = true := by
  induction n with
  | zero => rfl
  | succ n ih =>
      rw [Function.iterate_succ_apply]
      simpa [rmt32Collapse] using ih

private theorem rmt32_iterate_collapse_of_ne_zero
    (n : ℕ) (hn : n ≠ 0) (b : Bool) :
    rmt32Collapse^[n] b = true := by
  cases n with
  | zero => contradiction
  | succ n =>
      rw [Function.iterate_succ_apply]
      simpa [rmt32Collapse] using rmt32_iterate_collapse_true n

private theorem rmt32OneShotProcess_candidate :
    IsIntegrableSubadditiveProcessCandidate rmt32Collapse (Measure.dirac true)
      rmt32OneShotProcess where
  integrable := by
    intro n
    exact Integrable.of_bound
      (measurable_of_finite (rmt32OneShotProcess n)).aestronglyMeasurable 1
      (by
        filter_upwards with b
        cases b <;> simp [rmt32OneShotProcess]
        split <;> norm_num)
  add_le := by
    intro m n b
    cases b
    · by_cases hm : m = 0
      · subst m
        simp [rmt32OneShotProcess]
      · rw [rmt32_iterate_collapse_of_ne_zero m hm false]
        by_cases hm1 : m = 1
        · subst m
          simp only [rmt32OneShotProcess, Bool.false_eq_true, if_false,
            if_true, Nat.reduceLeDiff, add_zero]
          split <;> norm_num
        · have hm2 : 2 ≤ m := by omega
          have hsum2 : 2 ≤ m + n := hm2.trans (Nat.le_add_right m n)
          simp [rmt32OneShotProcess, hm2, hsum2]
    · rw [rmt32_iterate_collapse_true]
      simp [rmt32OneShotProcess]

private theorem rmt32Collapse_preserving :
    MeasurePreserving rmt32Collapse (Measure.dirac true)
      (Measure.dirac true) := by
  refine ⟨measurable_const, ?_⟩
  change Measure.map (fun _ : Bool ↦ true) (Measure.dirac true) =
    Measure.dirac true
  exact Measure.map_dirac'
    (measurable_const : Measurable (fun _ : Bool ↦ true)) true

private theorem rmt32OneShotProcess_centered_lower_bound
    (n : ℕ) (b : Bool) :
    (-1 : ℝ) ≤ centeredProcess rmt32Collapse rmt32OneShotProcess n b := by
  cases b <;> simp [centeredProcess, birkhoffSum, rmt32OneShotProcess]
  split <;> norm_num

private theorem rmt32OneShotProcess_not_mem_arbitrarilyLate_of_neg
    (b : Bool) {q : ℝ} (hq : q < 0) :
    b ∉ centeredArbitrarilyLateBadBlockSet rmt32Collapse
      rmt32OneShotProcess q := by
  intro hb
  rw [mem_centeredArbitrarilyLateBadBlockSet_iff] at hb
  obtain ⟨N, hN⟩ := exists_nat_gt (1 / (-q))
  have hnegq : 0 < -q := neg_pos.mpr hq
  have hqN : q * (N : ℝ) < -1 := by
    have hone : 1 < (-q) * (N : ℝ) := by
      simpa only [mul_comm] using (div_lt_iff₀ hnegq).mp hN
    linarith
  obtain ⟨n, hNn, _hn, hbad⟩ := hb N
  have hcast : (N : ℝ) ≤ (n : ℝ) := by exact_mod_cast hNn
  have hqn : q * (n : ℝ) ≤ q * (N : ℝ) :=
    mul_le_mul_of_nonpos_left hcast hq.le
  linarith [rmt32OneShotProcess_centered_lower_bound n b]

/-- The zero process has no strict lower deviation at any nonpositive target
slope. -/
example {Ω : Type*} (T : Ω → Ω) {c : ℝ} (hc : c ≤ 0) :
    centeredStrictLowerDeviationSet T
        (rmt32ZeroProcess : ℕ → Ω → ℝ) c = ∅ := by
  ext ω
  simp only [mem_centeredStrictLowerDeviationSet_iff,
    Set.notMem_empty, iff_false]
  rintro ⟨q, hqc, hq⟩
  rw [mem_centeredArbitrarilyLateBadBlockSet_iff] at hq
  obtain ⟨n, _hNn, hn, hbad⟩ := hq 0
  simp only [centeredProcess, rmt32ZeroProcess, birkhoffSum,
    Finset.sum_const_zero, sub_zero] at hbad
  have hqnonpos : (q : ℝ) ≤ 0 := (hqc.trans_le hc).le
  exact (not_lt_of_ge (mul_nonpos_of_nonpos_of_nonneg hqnonpos
    (Nat.cast_nonneg n))) hbad

/-- The RMT-31 one-shot event is nonempty, but no strict asymptotic lower
deviation survives at the same threshold. -/
example :
    centeredAllLengthBadBlockSet rmt32Collapse rmt32OneShotProcess
        (-(2 : ℝ) / 5) = ({false} : Set Bool) ∧
      centeredStrictLowerDeviationSet rmt32Collapse rmt32OneShotProcess
        (-(2 : ℝ) / 5) = ∅ := by
  constructor
  · ext b
    cases b
    · simp only [mem_centeredAllLengthBadBlockSet_iff,
        Set.mem_singleton_iff, iff_true]
      refine ⟨2, by norm_num, ?_⟩
      norm_num [centeredProcess, rmt32OneShotProcess, birkhoffSum,
        rmt32Collapse]
    · norm_num [mem_centeredAllLengthBadBlockSet_iff,
        centeredProcess, rmt32OneShotProcess, birkhoffSum, rmt32Collapse]
  · ext b
    simp only [mem_centeredStrictLowerDeviationSet_iff,
      Set.notMem_empty, iff_false, not_exists]
    intro q
    simp only [not_and]
    intro hqc
    exact rmt32OneShotProcess_not_mem_arbitrarilyLate_of_neg b
      (hqc.trans (by norm_num))

/-- Infinitely many values can lie strictly below the target slope without
sharing any fixed rational margin below it. -/
example :
    centeredArbitrarilyLateBadBlockSet rmt32Collapse
        rmt32OneShotProcess 0 = ({false} : Set Bool) ∧
      centeredStrictLowerDeviationSet rmt32Collapse rmt32OneShotProcess 0 =
        ∅ := by
  constructor
  · ext b
    cases b
    · simp only [mem_centeredArbitrarilyLateBadBlockSet_iff,
        Set.mem_singleton_iff, iff_true]
      intro N
      refine ⟨max N 2, le_max_left N 2, by omega, ?_⟩
      have htwo : 2 ≤ max N 2 := le_max_right N 2
      simp [centeredProcess, birkhoffSum, rmt32OneShotProcess, htwo]
    · simp only [mem_centeredArbitrarilyLateBadBlockSet_iff,
        Bool.true_eq_false, Set.mem_singleton_iff, iff_false]
      intro h
      obtain ⟨n, _hNn, _hn, hbad⟩ := h 0
      norm_num [centeredProcess, birkhoffSum, rmt32OneShotProcess] at hbad
  · ext b
    simp only [mem_centeredStrictLowerDeviationSet_iff,
      Set.notMem_empty, iff_false]
    rintro ⟨q, hq0, hq⟩
    exact rmt32OneShotProcess_not_mem_arbitrarilyLate_of_neg b hq0 hq

private def rmt32TwoPointProbability : Measure Bool :=
  ENNReal.ofReal 0.5 • (Measure.dirac false + Measure.dirac true)

private instance : IsProbabilityMeasure rmt32TwoPointProbability := by
  refine ⟨?_⟩
  simp [rmt32TwoPointProbability]
  rw [← ENNReal.ofReal_add (by norm_num : (0 : ℝ) ≤ 0.5)
    (by norm_num : (0 : ℝ) ≤ 0.5)]
  norm_num

private theorem rmt32Id_not_preErgodic :
    ¬ PreErgodic (id : Bool → Bool) rmt32TwoPointProbability := by
  intro h
  have hzero := h.measure_self_or_compl_eq_zero
    (s := ({false} : Set Bool)) (measurableSet_singleton false) (by simp)
  simp [rmt32TwoPointProbability] at hzero
  norm_num at hzero

private def rmt32TwoPointProcess (n : ℕ) (b : Bool) : ℝ :=
  if b then 0 else -((n - 1 : ℕ) : ℝ)

private theorem rmt32TwoPointProcess_candidate :
    IsIntegrableSubadditiveProcessCandidate (id : Bool → Bool)
      rmt32TwoPointProbability rmt32TwoPointProcess where
  integrable := by
    intro n
    refine Integrable.of_bound
      (measurable_of_finite (rmt32TwoPointProcess n)).aestronglyMeasurable n ?_
    filter_upwards with b
    cases b <;> simp [rmt32TwoPointProcess]
  add_le := by
    intro m n b
    cases b
    · simp only [Function.iterate_id, id_eq, rmt32TwoPointProcess,
        Bool.false_eq_true, if_false]
      rw [← neg_add]
      apply neg_le_neg
      norm_cast
      omega
    · simp [rmt32TwoPointProcess]

private theorem rmt32TwoPointStrictLowerDeviationSet :
    centeredStrictLowerDeviationSet id rmt32TwoPointProcess
        (-(3 : ℝ) / 4) = ({false} : Set Bool) := by
  ext b
  cases b
  · simp only [mem_centeredStrictLowerDeviationSet_iff,
      Set.mem_singleton_iff, iff_true]
    refine ⟨(-(4 : ℚ) / 5), by norm_num, ?_⟩
    rw [mem_centeredArbitrarilyLateBadBlockSet_iff]
    intro N
    refine ⟨N + 6, by omega, by omega, ?_⟩
    have hcenter :
        centeredProcess id rmt32TwoPointProcess (N + 6) false =
          rmt32TwoPointProcess (N + 6) false := by
      simp [centeredProcess, birkhoffSum, rmt32TwoPointProcess]
    rw [hcenter]
    simp only [rmt32TwoPointProcess, Bool.false_eq_true, if_false]
    have hone : 1 ≤ N + 6 := by omega
    rw [Nat.cast_sub hone]
    push_cast
    norm_num
    linarith
  · simp only [mem_centeredStrictLowerDeviationSet_iff,
      Bool.true_eq_false, Set.mem_singleton_iff, iff_false]
    rintro ⟨q, hqc, hq⟩
    rw [mem_centeredArbitrarilyLateBadBlockSet_iff] at hq
    obtain ⟨n, _hNn, hn, hbad⟩ := hq 0
    simp only [centeredProcess, rmt32TwoPointProcess, if_true,
      birkhoffSum, Function.iterate_id, id_eq, Finset.sum_const_zero,
      sub_zero] at hbad
    have hqneg : (q : ℝ) < 0 := hqc.trans (by norm_num)
    exact (not_lt_of_ge (mul_nonpos_of_nonpos_of_nonneg hqneg.le
      (Nat.cast_nonneg n))) hbad

/-- The event can have intermediate probability on a preserved nonergodic
base. -/
example :
    ¬ PreErgodic (id : Bool → Bool) rmt32TwoPointProbability ∧
      centeredStrictLowerDeviationSet id rmt32TwoPointProcess
          (-(3 : ℝ) / 4) = ({false} : Set Bool) ∧
      rmt32TwoPointProbability.real
          (centeredStrictLowerDeviationSet id rmt32TwoPointProcess
            (-(3 : ℝ) / 4)) = (1 : ℝ) / 2 := by
  refine ⟨rmt32Id_not_preErgodic, rmt32TwoPointStrictLowerDeviationSet, ?_⟩
  rw [rmt32TwoPointStrictLowerDeviationSet]
  simp [rmt32TwoPointProbability, Measure.real]
  norm_num

private def rmt32HalfUnitMeasure : Measure Unit :=
  ENNReal.ofReal 0.5 • Measure.dirac ()

private instance : IsFiniteMeasure rmt32HalfUnitMeasure := by
  refine ⟨?_⟩
  simp [rmt32HalfUnitMeasure]

private theorem rmt32IdHalfUnit_ergodic :
    Ergodic (id : Unit → Unit) rmt32HalfUnitMeasure where
  toMeasurePreserving := MeasurePreserving.id rmt32HalfUnitMeasure
  toPreErgodic := by
    refine ⟨?_⟩
    intro s _hs _hpre
    rcases Set.eq_empty_or_singleton_of_unique s with rfl | rfl
    · simp [eventuallyConst_set']
    · have hunit : ({default} : Set Unit) = Set.univ := by
        ext u
        simp
      rw [hunit, eventuallyConst_set']
      simp

private def rmt32UnitProcess (n : ℕ) (_u : Unit) : ℝ :=
  -((n - 1 : ℕ) : ℝ)

private theorem rmt32UnitProcess_candidate :
    IsIntegrableSubadditiveProcessCandidate (id : Unit → Unit)
      rmt32HalfUnitMeasure rmt32UnitProcess where
  integrable := by
    intro n
    exact integrable_const _
  add_le := by
    intro m n u
    simp only [rmt32UnitProcess]
    rw [← neg_add]
    apply neg_le_neg
    norm_cast
    omega

private theorem rmt32UnitStrictLowerDeviationSet :
    centeredStrictLowerDeviationSet id rmt32UnitProcess
        (-(3 : ℝ) / 4) = Set.univ := by
  ext u
  simp only [mem_centeredStrictLowerDeviationSet_iff, Set.mem_univ, iff_true]
  refine ⟨(-(4 : ℚ) / 5), by norm_num, ?_⟩
  rw [mem_centeredArbitrarilyLateBadBlockSet_iff]
  intro N
  refine ⟨N + 6, by omega, by omega, ?_⟩
  have hcenter :
      centeredProcess id rmt32UnitProcess (N + 6) u =
        rmt32UnitProcess (N + 6) u := by
    simp [centeredProcess, birkhoffSum, rmt32UnitProcess]
  rw [hcenter]
  simp only [rmt32UnitProcess]
  have hone : 1 ≤ N + 6 := by omega
  rw [Nat.cast_sub hone]
  push_cast
  norm_num
  linarith

/-- Ergodicity and a strict subunit ratio do not select the null branch
without probability normalization. -/
example :
    Ergodic (id : Unit → Unit) rmt32HalfUnitMeasure ∧
      centeredStrictLowerDeviationSet id rmt32UnitProcess
          (-(3 : ℝ) / 4) = Set.univ ∧
      rmt32HalfUnitMeasure.real
          (centeredStrictLowerDeviationSet id rmt32UnitProcess
            (-(3 : ℝ) / 4)) = (1 : ℝ) / 2 ∧
      rmt32HalfUnitMeasure.real
          (centeredStrictLowerDeviationSet id rmt32UnitProcess
            (-(3 : ℝ) / 4)) ≤ (2 : ℝ) / 3 ∧
      (2 : ℝ) / 3 < 1 := by
  refine ⟨rmt32IdHalfUnit_ergodic, rmt32UnitStrictLowerDeviationSet, ?_, ?_, by norm_num⟩
  · rw [rmt32UnitStrictLowerDeviationSet]
    simp [rmt32HalfUnitMeasure, Measure.real]
    norm_num
  · rw [rmt32UnitStrictLowerDeviationSet]
    simp [rmt32HalfUnitMeasure, Measure.real]
    norm_num

/-- The cocycle endpoint retains the empty matrix-index boundary. -/
example {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}
    [IsProbabilityMeasure μ] {C : DiscreteMatrixCocycle (ι := Empty) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (hErg : Ergodic C.base μ)
    (c : ℝ)
    (hc : c < C.integratedLogPlusGrowthRate hC -
      C.integratedLogPlusNorm 1) :
    μ (C.centeredLogPlusStrictLowerDeviationSet c) = 0 :=
  hC.measure_centeredLogPlusStrictLowerDeviationSet_eq_zero hErg c hc

end BoundaryAudits

#print axioms mem_centeredArbitrarilyLateBadBlockSet_iff
#print axioms mem_centeredStrictLowerDeviationSet_iff
#print axioms exists_nat_forall_mul_lt_mul_succ
#print axioms centeredStrictLowerDeviationSet_subset_allLength
#print axioms IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredStrictLowerDeviationSet
#print axioms IsIntegrableSubadditiveProcessCandidate.preimage_centeredStrictLowerDeviationSet_subset
#print axioms IsIntegrableSubadditiveProcessCandidate.preimage_centeredStrictLowerDeviationSet_ae_eq
#print axioms IsIntegrableSubadditiveProcessCandidate.centeredStrictLowerDeviationSet_ae_empty_or_univ
#print axioms IsIntegrableSubadditiveProcessCandidate.measure_centeredStrictLowerDeviationSet_eq_zero
#print axioms DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measure_centeredLogPlusStrictLowerDeviationSet_eq_zero

end NonlinearDynamics.Random.RandomCocycles
