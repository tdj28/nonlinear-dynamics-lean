import NonlinearDynamics.Random.RandomCocycles.FiniteHopfMaximal

/-!
# Infinite-horizon Birkhoff-average exceedance bounds

For a real observable `g` and threshold `a`, this module names the event on
which at least one positive-time Birkhoff average strictly exceeds `a`.  The
event is exactly the increasing union of the finite exceedance events from
`FiniteHopfMaximal`.  Continuity of measure from below therefore passes the
finite positive-part estimate to the infinite horizon.

The interfaces deliberately separate three different boundaries.  Ordinary
measurability of `T` and `g` makes the event measurable.  Measure preservation
and integrability make it null measurable without assuming finite total mass.
The real-valued weak estimate uses a finite measure, both because the finite
centered-observable estimate needs constants to be integrable and because
`Measure.real` sends infinite `ENNReal` mass to zero.  Continuity from below is
therefore exposed first in `ENNReal`, without any finiteness premise.  A
separate real-valued corollary exposes the weaker local hypothesis that the
infinite event itself has finite measure.

No real-valued infinite supremum is introduced.  The module proves no
infinite-event integral Hopf lemma, pointwise convergence, mean convergence,
conditional-expectation identification, Kingman theorem, Lyapunov exponent,
or Oseledets splitting.  Probability normalization, ergodicity, injectivity,
surjectivity, and invertibility are not used.
-/

open MeasureTheory Set Filter
open scoped ENNReal

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ

variable {Ω : Type uΩ} [MeasurableSpace Ω]
  {T : Ω → Ω} {g : Ω → ℝ} {μ : Measure Ω}

/-- The infinite-horizon event on which some positive-time Birkhoff average
strictly exceeds the real threshold `a`.  Positive time is built into the
definition, so the totalized zero-time average contributes no witness. -/
def birkhoffAverageExceedanceSet
    (T : Ω → Ω) (g : Ω → ℝ) (a : ℝ) : Set Ω :=
  {ω | ∃ k, 1 ≤ k ∧ a < birkhoffAverage ℝ T g k ω}

omit [MeasurableSpace Ω] in
/-- Membership is exactly the existence of one positive-time average above
the threshold. -/
@[simp] theorem mem_birkhoffAverageExceedanceSet_iff
    {a : ℝ} {ω : Ω} :
    ω ∈ birkhoffAverageExceedanceSet T g a ↔
      ∃ k, 1 ≤ k ∧ a < birkhoffAverage ℝ T g k ω := by
  rfl

omit [MeasurableSpace Ω] in
/-- The infinite exceedance event is exactly the increasing union of the
finite-horizon exceedance events. -/
theorem birkhoffAverageExceedanceSet_eq_iUnion_finite (a : ℝ) :
    birkhoffAverageExceedanceSet T g a =
      ⋃ N : ℕ, finiteBirkhoffAverageExceedanceSet T g N a := by
  ext ω
  simp only [mem_birkhoffAverageExceedanceSet_iff, Set.mem_iUnion,
    mem_finiteBirkhoffAverageExceedanceSet_iff]
  constructor
  · rintro ⟨k, hk1, hk⟩
    exact ⟨k, k, hk1, le_rfl, hk⟩
  · rintro ⟨_N, k, hk1, _hkN, hk⟩
    exact ⟨k, hk1, hk⟩

omit [MeasurableSpace Ω] in
/-- Every finite-horizon exceedance event lies in the infinite event. -/
theorem finiteBirkhoffAverageExceedanceSet_subset
    (N : ℕ) (a : ℝ) :
    finiteBirkhoffAverageExceedanceSet T g N a ⊆
      birkhoffAverageExceedanceSet T g a := by
  rw [birkhoffAverageExceedanceSet_eq_iUnion_finite]
  exact subset_iUnion
    (fun M ↦ finiteBirkhoffAverageExceedanceSet T g M a) N

/-- Ordinary measurability of the dynamics and observable makes the
infinite-horizon exceedance event measurable. -/
theorem measurableSet_birkhoffAverageExceedanceSet
    (hT : Measurable T) (hg : Measurable g) (a : ℝ) :
    MeasurableSet (birkhoffAverageExceedanceSet T g a) := by
  rw [birkhoffAverageExceedanceSet_eq_iUnion_finite]
  exact MeasurableSet.iUnion fun N ↦
    measurableSet_finiteBirkhoffAverageExceedanceSet hT hg N a

/-- Measure preservation and integrability give a null-measurable infinite
event without any finite-measure, probability, or ergodicity assumption.
The proof takes a countable union over positive horizons and uses
integrability of each uncentered Birkhoff average. -/
theorem nullMeasurableSet_birkhoffAverageExceedanceSet_of_integrable
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ) (a : ℝ) :
    NullMeasurableSet (birkhoffAverageExceedanceSet T g a) μ := by
  have heq : birkhoffAverageExceedanceSet T g a =
      ⋃ k : {k : ℕ // 1 ≤ k},
        {ω | a < birkhoffAverage ℝ T g k.1 ω} := by
    ext ω
    simp only [mem_birkhoffAverageExceedanceSet_iff, Set.mem_iUnion,
      Set.mem_setOf_eq]
    constructor
    · rintro ⟨k, hk1, hk⟩
      exact ⟨⟨k, hk1⟩, hk⟩
    · rintro ⟨k, hk⟩
      exact ⟨k.1, k.2, hk⟩
  rw [heq]
  exact NullMeasurableSet.iUnion fun k ↦
    nullMeasurableSet_lt measurable_const.aemeasurable
      (integrable_birkhoffAverage hT hg k.1).aemeasurable

/-- The `ENNReal` measures of the increasing finite exceedance events converge
to the `ENNReal` measure of the infinite event.  Continuity from below needs no
measurability of the dynamics or observable, no measurability of the sets, and
no finiteness assumption. -/
theorem tendsto_measure_finiteBirkhoffAverageExceedanceSet (a : ℝ) :
    Tendsto
      (fun N ↦ μ (finiteBirkhoffAverageExceedanceSet T g N a))
      atTop (nhds (μ (birkhoffAverageExceedanceSet T g a))) := by
  rw [birkhoffAverageExceedanceSet_eq_iUnion_finite]
  simpa only [Function.comp_def] using
    (tendsto_measure_iUnion_atTop (μ := μ) fun M N hMN ↦
      finiteBirkhoffAverageExceedanceSet_mono hMN)

/-- Real measures of the increasing finite exceedance events converge to the
real measure of the infinite event when that event has finite `ENNReal`
measure.  This is the clean finite-target hypothesis used to compose with
`ENNReal.tendsto_toReal`.  It is sufficient, not necessary for every particular
sequence: `Measure.real` totalizes infinite mass to zero, so some infinite-mass
families converge after projection while no ungated general continuity theorem
is valid. -/
theorem tendsto_measureReal_finiteBirkhoffAverageExceedanceSet
    (a : ℝ)
    (hfinite : μ (birkhoffAverageExceedanceSet T g a) ≠ ∞) :
    Tendsto
      (fun N ↦ μ.real (finiteBirkhoffAverageExceedanceSet T g N a))
      atTop (nhds (μ.real (birkhoffAverageExceedanceSet T g a))) := by
  have hreal := (ENNReal.tendsto_toReal hfinite).comp
    (tendsto_measure_finiteBirkhoffAverageExceedanceSet
      (T := T) (g := g) (μ := μ) a)
  simpa only [Measure.real, Function.comp_def] using hreal

/-- Infinite-horizon maximal estimate before division by the threshold.  On a
finite measure space, every real threshold `a` times the event's real measure
is bounded by the integral of the positive part of `g`.  No sign condition on
`a` is needed for this multiplication form. -/
theorem birkhoffAverageExceedanceSet_posPart_bound
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ) (a : ℝ) :
    a * μ.real (birkhoffAverageExceedanceSet T g a) ≤
      ∫ ω, max (g ω) 0 ∂μ := by
  apply le_of_tendsto'
    (tendsto_const_nhds.mul
      (tendsto_measureReal_finiteBirkhoffAverageExceedanceSet
        (T := T) (g := g) (μ := μ) a (by finiteness)))
  intro N
  exact finiteBirkhoffAverageExceedanceSet_posPart_bound hT hg N a

/-- Weak infinite-horizon maximal estimate at a positive threshold.
Positivity enters exactly when dividing the preceding multiplication bound by
`a`. -/
theorem measureReal_birkhoffAverageExceedanceSet_le
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ)
    {a : ℝ} (ha : 0 < a) :
    μ.real (birkhoffAverageExceedanceSet T g a) ≤
      (∫ ω, max (g ω) 0 ∂μ) / a := by
  apply (le_div_iff₀ ha).2
  simpa only [mul_comm] using
    birkhoffAverageExceedanceSet_posPart_bound hT hg a

section BoundaryProbes

omit [MeasurableSpace Ω] in
example {a : ℝ} {ω : Ω}
    (hω : ω ∈ birkhoffAverageExceedanceSet T g a) :
    ∃ N, ω ∈ finiteBirkhoffAverageExceedanceSet T g N a := by
  obtain ⟨k, hk1, hk⟩ :=
    mem_birkhoffAverageExceedanceSet_iff.mp hω
  exact ⟨k, mem_finiteBirkhoffAverageExceedanceSet_iff.mpr
    ⟨k, hk1, le_rfl, hk⟩⟩

omit [MeasurableSpace Ω] in
example (T : Ω → Ω) (g : Ω → ℝ) (a : ℝ) :
    finiteBirkhoffAverageExceedanceSet T g 0 a = ∅ := by
  simp [finiteBirkhoffAverageExceedanceSet]

omit [MeasurableSpace Ω] in
example (T : Ω → Ω) {a : ℝ} (ha : 0 ≤ a) :
    birkhoffAverageExceedanceSet T (fun _ ↦ (0 : ℝ)) a = ∅ := by
  ext ω
  simp only [mem_birkhoffAverageExceedanceSet_iff, mem_empty_iff_false,
    iff_false]
  rintro ⟨k, _hk1, hk⟩
  have hz : birkhoffAverage ℝ T (fun _ ↦ (0 : ℝ)) k ω = 0 := by
    simp [birkhoffAverage, birkhoffSum]
  rw [hz] at hk
  exact (not_lt_of_ge ha) hk

omit [MeasurableSpace Ω] in
example (T : Ω → Ω) {a : ℝ} (ha : a < 0) :
    birkhoffAverageExceedanceSet T (fun _ ↦ (0 : ℝ)) a = univ := by
  ext ω
  simp only [mem_birkhoffAverageExceedanceSet_iff, mem_univ, iff_true]
  refine ⟨1, by omega, ?_⟩
  simpa [birkhoffAverage, birkhoffSum] using ha

example (hT : Measurable T) (g : Ω → ℝ) (a : ℝ) :
    a * (0 : Measure Ω).real (birkhoffAverageExceedanceSet T g a) ≤
      ∫ ω, max (g ω) 0 ∂(0 : Measure Ω) := by
  apply birkhoffAverageExceedanceSet_posPart_bound
    (μ := (0 : Measure Ω))
  · exact ⟨hT, Measure.map_zero T⟩
  · exact integrable_zero_measure

example (g : ℕ → ℝ) (hg : Integrable g (Measure.count : Measure ℕ)) (a : ℝ) :
    ¬ IsFiniteMeasure (Measure.count : Measure ℕ) ∧
      NullMeasurableSet (birkhoffAverageExceedanceSet id g a)
        (Measure.count : Measure ℕ) := by
  refine ⟨?_, nullMeasurableSet_birkhoffAverageExceedanceSet_of_integrable
    (MeasurePreserving.id (Measure.count : Measure ℕ)) hg a⟩
  rw [not_isFiniteMeasure_iff]
  simp

example [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hg : Integrable g μ)
    {a : ℝ} (ha : 0 < a) :
    μ.real (birkhoffAverageExceedanceSet T g a) ≤
      (∫ ω, max (g ω) 0 ∂μ) / a :=
  measureReal_birkhoffAverageExceedanceSet_le hT hg ha

example :
    ∃ (T : Bool → Bool),
      ¬ Function.Injective T ∧
        MeasurePreserving T (Measure.dirac false) (Measure.dirac false) ∧
          0 < (Measure.dirac false).real
              (birkhoffAverageExceedanceSet T (fun _ ↦ (2 : ℝ)) 1) ∧
            (Measure.dirac false).real
              (birkhoffAverageExceedanceSet T (fun _ ↦ (2 : ℝ)) 1) ≤
            (∫ b, max ((fun _ : Bool ↦ (2 : ℝ)) b) 0
              ∂Measure.dirac false) / 1 := by
  let T : Bool → Bool := fun _ ↦ false
  have hTnotinj : ¬ Function.Injective T := by
    intro hTinj
    have : (false : Bool) = true := hTinj rfl
    simp at this
  have hTpres :
      MeasurePreserving T (Measure.dirac false) (Measure.dirac false) := by
    refine ⟨measurable_const, ?_⟩
    rw [Measure.map_dirac' measurable_const]
  have hevent :
      birkhoffAverageExceedanceSet T (fun _ ↦ (2 : ℝ)) 1 = Set.univ := by
    ext b
    simp only [mem_birkhoffAverageExceedanceSet_iff, Set.mem_univ, iff_true]
    refine ⟨1, by omega, ?_⟩
    norm_num [birkhoffAverage, birkhoffSum, T]
  refine ⟨T, hTnotinj, hTpres, ?_, ?_⟩
  · rw [hevent]
    simp [Measure.real]
  · exact measureReal_birkhoffAverageExceedanceSet_le hTpres
      (integrable_const (2 : ℝ)) one_pos

/-- Local finiteness is a clean sufficient premise for the general real-limit
theorem, not a necessary condition for every particular exceedance family.
For identity dynamics and the constant observable two on counting measure,
the infinite event and every positive-horizon event are `univ`.  Their
totalized real measures are therefore all zero, so convergence holds even
though the union has infinite extended measure. -/
example :
    Tendsto
      (fun N ↦ (Measure.count : Measure ℕ).real
        (finiteBirkhoffAverageExceedanceSet id (fun _ ↦ (2 : ℝ)) N 1))
      atTop
      (nhds ((Measure.count : Measure ℕ).real
        (birkhoffAverageExceedanceSet id (fun _ ↦ (2 : ℝ)) 1))) := by
  have hfinite (N : ℕ) (hN : 1 ≤ N) :
      finiteBirkhoffAverageExceedanceSet id (fun _ : ℕ ↦ (2 : ℝ)) N 1 =
        Set.univ := by
    ext n
    simp only [mem_finiteBirkhoffAverageExceedanceSet_iff, Set.mem_univ,
      iff_true]
    refine ⟨1, by omega, hN, ?_⟩
    norm_num [birkhoffAverage, birkhoffSum]
  have hinfinite :
      birkhoffAverageExceedanceSet id (fun _ : ℕ ↦ (2 : ℝ)) 1 =
        Set.univ := by
    ext n
    simp only [mem_birkhoffAverageExceedanceSet_iff, Set.mem_univ, iff_true]
    refine ⟨1, by omega, ?_⟩
    norm_num [birkhoffAverage, birkhoffSum]
  have huniv :
      (Measure.count : Measure ℕ).real (Set.univ : Set ℕ) = 0 := by
    rw [Measure.real, Measure.count_apply_infinite Set.infinite_univ]
    simp
  rw [hinfinite, huniv]
  apply tendsto_const_nhds.congr'
  filter_upwards [eventually_ge_atTop (1 : ℕ)] with N hN
  rw [hfinite N hN, huniv]

/-- Ungated passage through `Measure.real` can fail at infinite mass: these
finite counting-measure ranges increase to `univ`, but their real measures do
not converge to the totalized real measure of the union. -/
example :
    ∃ s : ℕ → Set ℕ,
      Monotone s ∧ (⋃ N, s N) = Set.univ ∧
        ¬ Tendsto (fun N ↦ Measure.count.real (s N)) atTop
          (nhds (Measure.count.real (Set.univ : Set ℕ))) := by
  let s : ℕ → Set ℕ := fun N ↦ (↑(Finset.range N) : Set ℕ)
  refine ⟨s, ?_, ?_, ?_⟩
  · intro M N hMN n hn
    simp only [s, Finset.mem_coe, Finset.mem_range] at hn ⊢
    omega
  · ext n
    simp only [s, Set.mem_iUnion, Finset.mem_coe, Finset.mem_range,
      Set.mem_univ, iff_true]
    exact ⟨n + 1, by omega⟩
  · intro h
    have hrange (N : ℕ) : Measure.count.real (s N) = N := by
      rw [Measure.real, Measure.count_apply_finset]
      simp
    have huniv : Measure.count.real (Set.univ : Set ℕ) = 0 := by
      rw [Measure.real, Measure.count_apply_infinite Set.infinite_univ]
      simp
    simp_rw [hrange, huniv] at h
    obtain ⟨N, hN⟩ := Metric.tendsto_atTop.1 h 1 zero_lt_one
    have hlarge := hN (max N 2) (le_max_left N 2)
    rw [Real.dist_eq, sub_zero, abs_of_nonneg (Nat.cast_nonneg _)] at hlarge
    have : (2 : ℝ) ≤ (max N 2 : ℕ) := by
      exact_mod_cast le_max_right N 2
    linarith

end BoundaryProbes

#print axioms nullMeasurableSet_birkhoffAverageExceedanceSet_of_integrable
#print axioms tendsto_measure_finiteBirkhoffAverageExceedanceSet
#print axioms tendsto_measureReal_finiteBirkhoffAverageExceedanceSet
#print axioms birkhoffAverageExceedanceSet_posPart_bound
#print axioms measureReal_birkhoffAverageExceedanceSet_le

end NonlinearDynamics.Random.RandomCocycles
