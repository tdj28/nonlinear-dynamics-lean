import NonlinearDynamics.Random.RandomCocycles.BirkhoffConvergence
import Mathlib.MeasureTheory.Measure.Count
import Mathlib.MeasureTheory.Order.Lattice

/-!
# A finite Hopf-style maximal ergodic lemma

For a real observable `g`, this module takes the maximum of the Birkhoff sums
at times `0, ..., N` and studies the strict positivity event for that maximum.
The key pointwise estimate compares the maximum at `ω` with the same maximum
at `T ω`.  Measure preservation cancels their integrals and leaves a
nonnegative integral of `g` over the strict event.

The finite-average exceedance corollary applies the result to the centered
observable `g - a`.  Its integral inequality is valid for every real threshold
`a`; no positivity assumption is needed until a later weak-type estimate
divides by `a`.

This is a finite-horizon result.  It proves no infinite-horizon maximal
inequality, pointwise ergodic theorem, Kingman theorem, Lyapunov exponent, or
Oseledets splitting.  It requires neither probability normalization,
ergodicity, injectivity, surjectivity, nor invertibility.
-/

open MeasureTheory Set

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ

variable {Ω : Type uΩ} [MeasurableSpace Ω]
  {T : Ω → Ω} {g : Ω → ℝ} {μ : Measure Ω}

/-- The maximum of the real Birkhoff sums at the nonempty set of horizons
`0, ..., N`.  Including time zero makes the maximum nonnegative. -/
def finiteBirkhoffSumMax (T : Ω → Ω) (g : Ω → ℝ) (N : ℕ) : Ω → ℝ :=
  fun ω ↦
    (Finset.range (N + 1)).sup' Finset.nonempty_range_add_one
      (fun k ↦ birkhoffSum T g k ω)

omit [MeasurableSpace Ω] in
/-- Every Birkhoff sum through horizon `N` is bounded by the finite maximum. -/
theorem birkhoffSum_le_finiteBirkhoffSumMax
    (N k : ℕ) (hk : k ≤ N) (ω : Ω) :
    birkhoffSum T g k ω ≤ finiteBirkhoffSumMax T g N ω := by
  unfold finiteBirkhoffSumMax
  exact Finset.le_sup' (f := fun j ↦ birkhoffSum T g j ω)
    (Finset.mem_range.mpr (Nat.lt_succ_iff.mpr hk))

omit [MeasurableSpace Ω] in
/-- The finite maximum is nonnegative because its index set contains time
zero, whose Birkhoff sum is zero. -/
theorem finiteBirkhoffSumMax_nonneg (N : ℕ) (ω : Ω) :
    0 ≤ finiteBirkhoffSumMax T g N ω := by
  exact birkhoffSum_le_finiteBirkhoffSumMax
    (T := T) (g := g) N 0 (Nat.zero_le N) ω

omit [MeasurableSpace Ω] in
/-- Enlarging the horizon can only increase the finite Birkhoff-sum maximum. -/
theorem finiteBirkhoffSumMax_mono
    {M N : ℕ} (hMN : M ≤ N) (ω : Ω) :
    finiteBirkhoffSumMax T g M ω ≤ finiteBirkhoffSumMax T g N ω := by
  unfold finiteBirkhoffSumMax
  obtain ⟨k, hkM, hkmax⟩ :=
    Finset.exists_mem_eq_sup' Finset.nonempty_range_add_one
      (fun k ↦ birkhoffSum T g k ω)
  rw [hkmax]
  apply birkhoffSum_le_finiteBirkhoffSumMax (T := T) (g := g) N k
  exact (Nat.lt_succ_iff.mp (Finset.mem_range.mp hkM)).trans hMN

omit [MeasurableSpace Ω] in
/-- At horizon zero the finite maximum is exactly the zero Birkhoff sum. -/
@[simp] theorem finiteBirkhoffSumMax_zero (ω : Ω) :
    finiteBirkhoffSumMax T g 0 ω = 0 := by
  simp [finiteBirkhoffSumMax]

/-- Ordinary measurability of the dynamics and observable makes the finite
maximum measurable. -/
theorem measurable_finiteBirkhoffSumMax
    (hT : Measurable T) (hg : Measurable g) (N : ℕ) :
    Measurable (finiteBirkhoffSumMax T g N) := by
  exact Finset.measurable_range_sup'' fun k _hk ↦
    measurable_birkhoffSum hT hg k

/-- Under measure preservation, one-step integrability propagates to the
finite maximum.  No finiteness or probability assumption on the measure is
used. -/
theorem integrable_finiteBirkhoffSumMax
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ) (N : ℕ) :
    Integrable (finiteBirkhoffSumMax T g N) μ := by
  unfold finiteBirkhoffSumMax
  have h : Integrable
      ((Finset.range (N + 1)).sup' Finset.nonempty_range_add_one
        (fun k ↦ birkhoffSum T g k)) μ := by
    refine Finset.sup'_induction
      (p := fun f : Ω → ℝ ↦ Integrable f μ)
      Finset.nonempty_range_add_one (fun k ↦ birkhoffSum T g k) ?_ ?_
    · intro f hf h hh
      exact hf.sup hh
    · intro k hk
      exact integrable_birkhoffSum hT hg k
  convert h using 1
  ext ω
  exact (Finset.sup'_apply (s := Finset.range (N + 1))
    Finset.nonempty_range_add_one (fun k ↦ birkhoffSum T g k) ω).symm

/-- The finite Hopf event is the strict positivity event of the maximum of
the Birkhoff sums through horizon `N`. -/
def finiteHopfEvent (T : Ω → Ω) (g : Ω → ℝ) (N : ℕ) : Set Ω :=
  { ω | 0 < finiteBirkhoffSumMax T g N ω }

/-- Ordinary measurability gives a measurable finite Hopf event. -/
theorem measurableSet_finiteHopfEvent
    (hT : Measurable T) (hg : Measurable g) (N : ℕ) :
    MeasurableSet (finiteHopfEvent T g N) := by
  exact measurableSet_lt measurable_const
    (measurable_finiteBirkhoffSumMax hT hg N)

/-- Integrability gives the weaker null-measurable event interface needed by
the finite maximal proof, without requiring an ordinarily measurable
representative for `g`. -/
theorem nullMeasurableSet_finiteHopfEvent_of_integrable
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ) (N : ℕ) :
    NullMeasurableSet (finiteHopfEvent T g N) μ := by
  exact nullMeasurableSet_lt measurable_const.aemeasurable
    (integrable_finiteBirkhoffSumMax hT hg N).aemeasurable

omit [MeasurableSpace Ω] in
/-- Membership in the strict event is equivalent to a positive Birkhoff sum
at some positive index through `N`.  The index cannot be zero because its sum
is zero. -/
theorem mem_finiteHopfEvent_iff {N : ℕ} {ω : Ω} :
    ω ∈ finiteHopfEvent T g N ↔
      ∃ k, 1 ≤ k ∧ k ≤ N ∧ 0 < birkhoffSum T g k ω := by
  constructor
  · intro hω
    change 0 < (Finset.range (N + 1)).sup'
      Finset.nonempty_range_add_one (fun k ↦ birkhoffSum T g k ω) at hω
    rw [Finset.lt_sup'_iff] at hω
    obtain ⟨k, hkrange, hkpos⟩ := hω
    have hkN : k ≤ N := Nat.lt_succ_iff.mp (Finset.mem_range.mp hkrange)
    have hk1 : 1 ≤ k := by
      by_contra hk
      have hk0 : k = 0 := by omega
      subst k
      simp at hkpos
    exact ⟨k, hk1, hkN, hkpos⟩
  · rintro ⟨k, hk1, hkN, hkpos⟩
    exact lt_of_lt_of_le hkpos
      (birkhoffSum_le_finiteBirkhoffSumMax
        (T := T) (g := g) N k hkN ω)

omit [MeasurableSpace Ω] in
/-- The finite Hopf events are increasing with the horizon. -/
theorem finiteHopfEvent_mono {M N : ℕ} (hMN : M ≤ N) :
    finiteHopfEvent T g M ⊆ finiteHopfEvent T g N := by
  intro ω hω
  exact lt_of_lt_of_le hω
    (finiteBirkhoffSumMax_mono (T := T) (g := g) hMN ω)

omit [MeasurableSpace Ω] in
/-- At horizon zero the strict event is empty.  This is why strict positivity,
rather than nonnegativity, is the informative convention. -/
@[simp] theorem finiteHopfEvent_zero :
    finiteHopfEvent T g 0 = ∅ := by
  ext ω
  simp [finiteHopfEvent]

omit [MeasurableSpace Ω] in
/-- At horizon one, event membership is exactly positivity of the one-step
observable. -/
theorem mem_finiteHopfEvent_one_iff {ω : Ω} :
    ω ∈ finiteHopfEvent T g 1 ↔ 0 < g ω := by
  rw [mem_finiteHopfEvent_iff]
  constructor
  · rintro ⟨k, hk1, hkN, hkpos⟩
    have hk : k = 1 := by omega
    subst k
    simpa only [birkhoffSum_one] using hkpos
  · intro hpos
    exact ⟨1, by omega, by omega, by simpa only [birkhoffSum_one]⟩

omit [MeasurableSpace Ω] in
/-- On the strict event, a positive maximizing index can be peeled into the
first value plus a shifted Birkhoff sum. -/
theorem finiteBirkhoffSumMax_le_on_finiteHopfEvent
    {N : ℕ} {ω : Ω} (hω : ω ∈ finiteHopfEvent T g N) :
    finiteBirkhoffSumMax T g N ω ≤
      g ω + finiteBirkhoffSumMax T g N (T ω) := by
  change 0 < finiteBirkhoffSumMax T g N ω at hω
  obtain ⟨k, hkrange, hmax⟩ :=
    Finset.exists_mem_eq_sup' Finset.nonempty_range_add_one
      (fun k ↦ birkhoffSum T g k ω)
  have hmax' : finiteBirkhoffSumMax T g N ω =
      birkhoffSum T g k ω := hmax
  have hkpos : 0 < birkhoffSum T g k ω := hmax' ▸ hω
  have hkN : k ≤ N := Nat.lt_succ_iff.mp (Finset.mem_range.mp hkrange)
  cases k with
  | zero => simp at hkpos
  | succ j =>
      have hjN : j ≤ N := by omega
      calc
        finiteBirkhoffSumMax T g N ω =
            birkhoffSum T g (j + 1) ω := hmax'
        _ = g ω + birkhoffSum T g j (T ω) :=
          birkhoffSum_succ' T g j ω
        _ ≤ g ω + finiteBirkhoffSumMax T g N (T ω) := by
          gcongr
          exact birkhoffSum_le_finiteBirkhoffSumMax
            (T := T) (g := g) N j hjN (T ω)

omit [MeasurableSpace Ω] in
/-- The pointwise Hopf inequality: subtracting the shifted maximum is bounded
by `g` on the strict event and by zero off it. -/
theorem finiteBirkhoffSumMax_sub_comp_le_indicator
    (N : ℕ) (ω : Ω) :
    finiteBirkhoffSumMax T g N ω - finiteBirkhoffSumMax T g N (T ω) ≤
      (finiteHopfEvent T g N).indicator g ω := by
  by_cases hω : ω ∈ finiteHopfEvent T g N
  · rw [Set.indicator_of_mem hω]
    linarith [finiteBirkhoffSumMax_le_on_finiteHopfEvent
      (T := T) (g := g) hω]
  · rw [Set.indicator_of_notMem hω]
    have hnotpos : ¬ 0 < finiteBirkhoffSumMax T g N ω := hω
    have hzero : finiteBirkhoffSumMax T g N ω = 0 :=
      le_antisymm (le_of_not_gt hnotpos)
        (finiteBirkhoffSumMax_nonneg (T := T) (g := g) N ω)
    rw [hzero, zero_sub]
    exact neg_nonpos.mpr
      (finiteBirkhoffSumMax_nonneg (T := T) (g := g) N (T ω))

private theorem integral_comp_of_measurePreserving
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ) :
    (∫ ω, g (T ω) ∂μ) = ∫ ω, g ω ∂μ := by
  have hgm : AEStronglyMeasurable g (Measure.map T μ) := by
    rw [hT.map_eq]
    exact hg.aestronglyMeasurable
  calc
    (∫ ω, g (T ω) ∂μ) = ∫ ω, g ω ∂Measure.map T μ :=
      (integral_map hT.measurable.aemeasurable hgm).symm
    _ = ∫ ω, g ω ∂μ := by rw [hT.map_eq]

/-- The finite Hopf-style maximal ergodic lemma.  Under only measure
preservation and integrability, the integral of `g` over the strict finite
maximal event is nonnegative. -/
theorem integral_finiteHopfEvent_nonneg
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ) (N : ℕ) :
    0 ≤ ∫ ω in finiteHopfEvent T g N, g ω ∂μ := by
  let M := finiteBirkhoffSumMax T g N
  let E := finiteHopfEvent T g N
  have hM : Integrable M μ := integrable_finiteBirkhoffSumMax hT hg N
  have hMT : Integrable (fun ω ↦ M (T ω)) μ := by
    change Integrable (M ∘ T) μ
    exact hT.integrable_comp_of_integrable hM
  have hE : NullMeasurableSet E μ :=
    nullMeasurableSet_finiteHopfEvent_of_integrable hT hg N
  have hleft : Integrable (fun ω ↦ M ω - M (T ω)) μ := hM.sub hMT
  have hright : Integrable (E.indicator g) μ := hg.indicator₀ hE
  have hmono :
      (∫ ω, M ω - M (T ω) ∂μ) ≤ ∫ ω, E.indicator g ω ∂μ := by
    apply integral_mono hleft hright
    intro ω
    exact finiteBirkhoffSumMax_sub_comp_le_indicator
      (T := T) (g := g) N ω
  have hinv : (∫ ω, M (T ω) ∂μ) = ∫ ω, M ω ∂μ :=
    integral_comp_of_measurePreserving hT hM
  have hzero : (∫ ω, M ω - M (T ω) ∂μ) = 0 := by
    rw [integral_sub hM hMT, hinv, sub_self]
  rw [hzero, integral_indicator₀ hE] at hmono
  exact hmono

/-- The points where at least one positive-time Birkhoff average through `N`
strictly exceeds the real threshold `a`, encoded through the centered
observable `g - a`. -/
def finiteBirkhoffAverageExceedanceSet
    (T : Ω → Ω) (g : Ω → ℝ) (N : ℕ) (a : ℝ) : Set Ω :=
  finiteHopfEvent T (fun ω ↦ g ω - a) N

omit [MeasurableSpace Ω] in
/-- Membership in the average exceedance set is equivalent to exceeding the
threshold at some positive horizon through `N`. -/
theorem mem_finiteBirkhoffAverageExceedanceSet_iff
    {N : ℕ} {a : ℝ} {ω : Ω} :
    ω ∈ finiteBirkhoffAverageExceedanceSet T g N a ↔
      ∃ k, 1 ≤ k ∧ k ≤ N ∧ a < birkhoffAverage ℝ T g k ω := by
  rw [finiteBirkhoffAverageExceedanceSet, mem_finiteHopfEvent_iff]
  apply exists_congr
  intro k
  apply and_congr_right
  intro hk1
  apply and_congr_right
  intro _hkN
  have hk0 : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk1)
  change (0 < birkhoffSum T (g - fun _ : Ω ↦ a) k ω) ↔
    a < birkhoffAverage ℝ T g k ω
  rw [birkhoffSum_sub]
  have hconst : birkhoffSum T (fun _ : Ω ↦ a) k ω = k * a := by
    simp [birkhoffSum]
  rw [hconst]
  simp only [birkhoffAverage, smul_eq_mul]
  constructor <;> intro h
  · rw [inv_mul_eq_div]
    apply (lt_div_iff₀' (by positivity : (0 : ℝ) < k)).mpr
    linarith
  · rw [inv_mul_eq_div] at h
    have := (lt_div_iff₀' (by positivity : (0 : ℝ) < k)).mp h
    linarith

omit [MeasurableSpace Ω] in
/-- The finite average exceedance sets are increasing with the horizon. -/
theorem finiteBirkhoffAverageExceedanceSet_mono
    {M N : ℕ} {a : ℝ} (hMN : M ≤ N) :
    finiteBirkhoffAverageExceedanceSet T g M a ⊆
      finiteBirkhoffAverageExceedanceSet T g N a :=
  finiteHopfEvent_mono hMN

/-- Ordinary measurability gives a measurable finite-average exceedance set. -/
theorem measurableSet_finiteBirkhoffAverageExceedanceSet
    (hT : Measurable T) (hg : Measurable g) (N : ℕ) (a : ℝ) :
    MeasurableSet (finiteBirkhoffAverageExceedanceSet T g N a) := by
  exact measurableSet_finiteHopfEvent hT (hg.sub measurable_const) N

/-- Under a finite measure, integrability of `g` also makes the centered
observable integrable and the finite-average exceedance set null measurable. -/
theorem nullMeasurableSet_finiteBirkhoffAverageExceedanceSet
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ)
    (N : ℕ) (a : ℝ) :
    NullMeasurableSet (finiteBirkhoffAverageExceedanceSet T g N a) μ := by
  have hcentered : Integrable (fun ω ↦ g ω - a) μ :=
    hg.sub (integrable_const a)
  exact nullMeasurableSet_finiteHopfEvent_of_integrable hT hcentered N

/-- Finite maximal inequality for average exceedances.  On a finite measure
space, `a` times the real measure of the exceedance event is bounded by the
integral of `g` over that event.  The statement is valid for every real `a`,
including zero and negative thresholds. -/
theorem finiteBirkhoffAverageExceedanceSet_integral_lower_bound
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ)
    (N : ℕ) (a : ℝ) :
    a * μ.real (finiteBirkhoffAverageExceedanceSet T g N a) ≤
      ∫ ω in finiteBirkhoffAverageExceedanceSet T g N a, g ω ∂μ := by
  let E := finiteBirkhoffAverageExceedanceSet T g N a
  have hconst : Integrable (fun _ : Ω ↦ a) μ := integrable_const a
  have hcentered : Integrable (fun ω ↦ g ω - a) μ := hg.sub hconst
  have hhopf : 0 ≤ ∫ ω in E, g ω - a ∂μ :=
    integral_finiteHopfEvent_nonneg hT hcentered N
  rw [integral_sub hg.integrableOn hconst.integrableOn,
    setIntegral_const, smul_eq_mul] at hhopf
  linarith

/-- The finite-average exceedance bound with an `N`-independent right-hand
side.  Replacing `g` by its positive part loses no validity and needs no sign
assumption on the threshold. -/
theorem finiteBirkhoffAverageExceedanceSet_posPart_bound
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ)
    (N : ℕ) (a : ℝ) :
    a * μ.real (finiteBirkhoffAverageExceedanceSet T g N a) ≤
      ∫ ω, max (g ω) 0 ∂μ := by
  calc
    a * μ.real (finiteBirkhoffAverageExceedanceSet T g N a) ≤
        ∫ ω in finiteBirkhoffAverageExceedanceSet T g N a, g ω ∂μ :=
      finiteBirkhoffAverageExceedanceSet_integral_lower_bound hT hg N a
    _ ≤ ∫ ω in finiteBirkhoffAverageExceedanceSet T g N a,
        max (g ω) 0 ∂μ := by
      exact setIntegral_mono_ae hg.integrableOn hg.pos_part.integrableOn
        (ae_of_all μ fun ω ↦ le_max_left (g ω) 0)
    _ ≤ ∫ ω, max (g ω) 0 ∂μ := by
      exact setIntegral_le_integral hg.pos_part
        (ae_of_all μ fun ω ↦ le_max_right (g ω) 0)

/-- Weak finite maximal estimate for a positive threshold.  Positivity enters
only here, where the preceding uniform integral inequality is divided by
`a`. -/
theorem measureReal_finiteBirkhoffAverageExceedanceSet_le
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ)
    (N : ℕ) {a : ℝ} (ha : 0 < a) :
    μ.real (finiteBirkhoffAverageExceedanceSet T g N a) ≤
      (∫ ω, max (g ω) 0 ∂μ) / a := by
  apply (le_div_iff₀ ha).2
  simpa only [mul_comm] using
    finiteBirkhoffAverageExceedanceSet_posPart_bound hT hg N a

section BoundaryProbes

omit [MeasurableSpace Ω] in
example (T : Ω → Ω) (g : Ω → ℝ) :
    finiteHopfEvent T g 0 = ∅ :=
  finiteHopfEvent_zero

omit [MeasurableSpace Ω] in
example (T : Ω → Ω) (g : Ω → ℝ) (ω : Ω) :
    ω ∈ finiteHopfEvent T g 1 ↔ 0 < g ω :=
  mem_finiteHopfEvent_one_iff

omit [MeasurableSpace Ω] in
example (T : Ω → Ω) (N : ℕ) :
    finiteHopfEvent T (fun _ ↦ (0 : ℝ)) N = ∅ := by
  ext ω
  simp only [mem_finiteHopfEvent_iff, mem_empty_iff_false, iff_false]
  rintro ⟨k, _hk1, _hkN, hkpos⟩
  simp [birkhoffSum] at hkpos

omit [MeasurableSpace Ω] in
example (T : Ω → Ω) (g : Ω → ℝ) (N : ℕ) :
    { ω | 0 ≤ finiteBirkhoffSumMax T g N ω } = univ := by
  ext ω
  simp only [mem_setOf_eq, mem_univ, iff_true]
  exact finiteBirkhoffSumMax_nonneg N ω

example (hg : Integrable g μ) (N : ℕ) :
    0 ≤ ∫ ω in finiteHopfEvent id g N, g ω ∂μ :=
  integral_finiteHopfEvent_nonneg (MeasurePreserving.id μ) hg N

example (hT : Measurable T) (N : ℕ) :
    0 ≤ ∫ _ in finiteHopfEvent T (fun _ ↦ (0 : ℝ)) N,
      (0 : ℝ) ∂(0 : Measure Ω) := by
  apply integral_finiteHopfEvent_nonneg
    (μ := (0 : Measure Ω)) ⟨hT, Measure.map_zero T⟩
      (integrable_zero Ω ℝ (0 : Measure Ω))

example (N : ℕ) :
    ¬ IsFiniteMeasure (Measure.count : Measure ℕ) ∧
      ∃ g : ℕ → ℝ,
        g 0 = 1 ∧ Integrable g Measure.count ∧
          0 ≤ ∫ n in finiteHopfEvent id g N, g n ∂Measure.count := by
  refine ⟨?_, ?_⟩
  · rw [not_isFiniteMeasure_iff]
    simp
  · let g : ℕ → ℝ := fun n ↦ if n = 0 then 1 else 0
    have hg : Integrable g Measure.count := by
      rw [integrable_count_iff]
      exact (hasSum_ite_eq (0 : ℕ) (1 : ℝ)).summable.congr fun n ↦ by
        by_cases hn : n = 0 <;> simp [g, hn]
    refine ⟨g, by simp [g], hg, ?_⟩
    exact integral_finiteHopfEvent_nonneg
      (MeasurePreserving.id (Measure.count : Measure ℕ)) hg N

example :
    ∃ T : Bool → Bool,
      ¬ Function.Injective T ∧
        MeasurePreserving T (Measure.dirac false) (Measure.dirac false) ∧
          0 ≤ ∫ _ in finiteHopfEvent T (fun _ ↦ (0 : ℝ)) 3,
            (0 : ℝ) ∂Measure.dirac false := by
  let T : Bool → Bool := fun _ ↦ false
  have hTnotinj : ¬ Function.Injective T := by
    intro hTinj
    have : (false : Bool) = true := hTinj rfl
    simp at this
  have hTpres : MeasurePreserving T (Measure.dirac false) (Measure.dirac false) := by
    refine ⟨measurable_const, ?_⟩
    rw [Measure.map_dirac' measurable_const]
  refine ⟨T, hTnotinj, hTpres, ?_⟩
  exact integral_finiteHopfEvent_nonneg hTpres
    (integrable_zero Bool ℝ (Measure.dirac false)) 3

example :
    ∃ (T : Bool → Bool) (g : Bool → ℝ),
      Measurable T ∧ Integrable g (Measure.dirac true) ∧
        ¬ MeasurePreserving T (Measure.dirac true) (Measure.dirac true) ∧
          (∫ ω in finiteHopfEvent T g 2, g ω ∂Measure.dirac true) < 0 := by
  classical
  let T : Bool → Bool := fun _ ↦ false
  let g : Bool → ℝ := fun b ↦ if b = true then -1 else 2
  have hg : Integrable g (Measure.dirac true) := by
    apply integrable_dirac
    simp [g]
  have hTnotpres :
      ¬ MeasurePreserving T (Measure.dirac true) (Measure.dirac true) := by
    intro hTpres
    have hmap := hTpres.map_eq
    rw [Measure.map_dirac' measurable_const] at hmap
    have hmass := congrArg (fun ν : Measure Bool ↦ ν {true}) hmap
    simp at hmass
  have htrue : true ∈ finiteHopfEvent T g 2 := by
    rw [mem_finiteHopfEvent_iff]
    refine ⟨2, by omega, by omega, ?_⟩
    change 0 < birkhoffSum T g (1 + 1) true
    rw [birkhoffSum_succ']
    norm_num [birkhoffSum_one, T, g]
  refine ⟨T, g, measurable_const, hg, hTnotpres, ?_⟩
  rw [setIntegral_dirac]
  simp [htrue, g]

example [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ) (N : ℕ) :
    (-1 : ℝ) * μ.real (finiteBirkhoffAverageExceedanceSet T g N (-1)) ≤
      ∫ ω in finiteBirkhoffAverageExceedanceSet T g N (-1), g ω ∂μ :=
  finiteBirkhoffAverageExceedanceSet_integral_lower_bound hT hg N (-1)

example [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ)
    (N : ℕ) {a : ℝ} (ha : 0 < a) :
    μ.real (finiteBirkhoffAverageExceedanceSet T g N a) ≤
      (∫ ω, max (g ω) 0 ∂μ) / a :=
  measureReal_finiteBirkhoffAverageExceedanceSet_le hT hg N ha

end BoundaryProbes

#print axioms integral_finiteHopfEvent_nonneg
#print axioms finiteBirkhoffAverageExceedanceSet_integral_lower_bound
#print axioms measureReal_finiteBirkhoffAverageExceedanceSet_le

end NonlinearDynamics.Random.RandomCocycles
