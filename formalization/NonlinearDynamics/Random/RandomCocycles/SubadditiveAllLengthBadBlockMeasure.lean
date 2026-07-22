import NonlinearDynamics.Random.RandomCocycles.SubadditiveBadBlockMeasure

/-!
# All-positive-length centered bad-block measure control

RMT-30 controls the centered bad-block set whose witness length is bounded by
a fixed cap `m`.  This module removes that cap.  The all-positive-length set is
the increasing union of the finite sets, so membership still means one finite
strict witness, now with no predetermined upper bound.

The finite caps are monotone.  Consequently, their `ENNReal` measures converge
to the measure of the union without any measurability or finiteness premise.
Passing that statement through `Measure.real` requires the union to have finite
extended measure, because `Measure.real` totalizes infinite mass to zero.  On a
finite measure space this gate is automatic, and the uniform RMT-30 estimate

`μ.real (finiteCenteredBadBlockSet T X m c) ≤ δ / c`

passes to the all-length union without loss.  The final theorem performs the
same passage for a discrete matrix cocycle's log-positive norm process.

The raw all-length union records a bad block at some length.  It is not an
asymptotic lower-deviation event and is not generally invariant under the base
map.  This module therefore uses neither probability nor ergodicity and proves
no lower liminf, samplewise convergence, full Kingman theorem, signed
logarithmic growth, Lyapunov exponent, or Oseledets splitting.
-/

open MeasureTheory Set Filter Topology Finset Function
open scoped BigOperators ENNReal Topology

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ uι

/-- Points admitting a strict centered-process block below slope `c` at some
positive finite length.  Equivalently, this is the increasing union of the
finite-cap bad-block sets. -/
def centeredAllLengthBadBlockSet {Ω : Type uΩ} (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) (c : ℝ) : Set Ω :=
  ⋃ m : ℕ, finiteCenteredBadBlockSet T X m c

/-- Membership in the all-length bad-block set is exactly the existence of one
positive finite witness.  It does not mean that bad blocks occur infinitely
often. -/
@[simp] theorem mem_centeredAllLengthBadBlockSet_iff
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {c : ℝ} {ω : Ω} :
    ω ∈ centeredAllLengthBadBlockSet T X c ↔
      ∃ n : ℕ, 0 < n ∧ centeredProcess T X n ω < c * (n : ℝ) := by
  simp only [centeredAllLengthBadBlockSet, finiteCenteredBadBlockSet,
    Set.mem_iUnion, Set.mem_setOf_eq, Finset.mem_Icc]
  constructor
  · rintro ⟨m, n, ⟨hnpos, _hnm⟩, hn⟩
    exact ⟨n, hnpos, hn⟩
  · rintro ⟨n, hnpos, hn⟩
    exact ⟨n, n, ⟨hnpos, le_rfl⟩, hn⟩

/-- Enlarging the finite length cap can only enlarge the finite bad-block
set.  This is monotonicity of the search window, not monotonicity of the
centered process in its time variable. -/
theorem finiteCenteredBadBlockSet_mono
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {m M : ℕ} (hmM : m ≤ M) (c : ℝ) :
    finiteCenteredBadBlockSet T X m c ⊆
      finiteCenteredBadBlockSet T X M c := by
  intro ω
  simp only [finiteCenteredBadBlockSet, Set.mem_iUnion, Set.mem_setOf_eq,
    Finset.mem_Icc]
  rintro ⟨n, ⟨hnpos, hnm⟩, hn⟩
  exact ⟨n, ⟨hnpos, hnm.trans hmM⟩, hn⟩

/-- The all-length set is exactly the increasing union of the finite-cap
sets. -/
theorem centeredAllLengthBadBlockSet_eq_iUnion_finite
    {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (c : ℝ) :
    centeredAllLengthBadBlockSet T X c =
      ⋃ m : ℕ, finiteCenteredBadBlockSet T X m c := by
  rfl

/-- Every finite-cap bad-block set lies in the all-length event. -/
theorem finiteCenteredBadBlockSet_subset_allLength
    {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ)
    (m : ℕ) (c : ℝ) :
    finiteCenteredBadBlockSet T X m c ⊆
      centeredAllLengthBadBlockSet T X c := by
  rw [centeredAllLengthBadBlockSet_eq_iUnion_finite]
  exact subset_iUnion (fun M ↦ finiteCenteredBadBlockSet T X M c) m

namespace IsIntegrableSubadditiveProcessCandidate

variable {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
  {μ : Measure Ω} {X : ℕ → Ω → ℝ}

/-- The all-positive-length bad-block set is null measurable under
preservation.  Finite mass is not needed: each cap is null measurable by
RMT-30, and countable unions preserve null measurability. -/
theorem nullMeasurableSet_centeredAllLengthBadBlockSet
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (c : ℝ) :
    NullMeasurableSet (centeredAllLengthBadBlockSet T X c) μ := by
  rw [centeredAllLengthBadBlockSet_eq_iUnion_finite]
  exact NullMeasurableSet.iUnion fun m ↦
    hX.nullMeasurableSet_finiteCenteredBadBlockSet hT m c

end IsIntegrableSubadditiveProcessCandidate

/-- Extended measures of the nested finite-cap bad-block sets converge to the
extended measure of the all-length union.  Continuity from below needs neither
set measurability nor finite mass. -/
theorem tendsto_measure_finiteCenteredBadBlockSet
    {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
    {μ : Measure Ω} (X : ℕ → Ω → ℝ) (c : ℝ) :
    Tendsto
      (fun m ↦ μ (finiteCenteredBadBlockSet T X m c))
      atTop (nhds (μ (centeredAllLengthBadBlockSet T X c))) := by
  rw [centeredAllLengthBadBlockSet_eq_iUnion_finite]
  simpa only [Function.comp_def] using
    (tendsto_measure_iUnion_atTop (μ := μ) fun m M hmM ↦
      finiteCenteredBadBlockSet_mono hmM c)

/-- Real measures of the finite-cap bad-block sets converge to the real
measure of their union when that union has finite extended measure.  The local
finiteness gate is explicit because `Measure.real` sends infinite mass to
zero. -/
theorem tendsto_measureReal_finiteCenteredBadBlockSet
    {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
    {μ : Measure Ω} (X : ℕ → Ω → ℝ) (c : ℝ)
    (hfinite : μ (centeredAllLengthBadBlockSet T X c) ≠ ∞) :
    Tendsto
      (fun m ↦ μ.real (finiteCenteredBadBlockSet T X m c))
      atTop (nhds (μ.real (centeredAllLengthBadBlockSet T X c))) := by
  have hreal := (ENNReal.tendsto_toReal hfinite).comp
    (tendsto_measure_finiteCenteredBadBlockSet
      (T := T) (μ := μ) X c)
  simpa only [Measure.real, Function.comp_def] using hreal

namespace IsIntegrableSubadditiveProcessCandidate

variable {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
  {μ : Measure Ω} {X : ℕ → Ω → ℝ}

/-- A lower bound `δ` for every positive normalized centered integral controls
the real measure of the strict bad-block set across all positive lengths by
the same ratio `δ / c` as every finite cap.  Finite measure licenses the real
continuity step; probability and ergodicity are not used. -/
theorem measureReal_centeredAllLengthBadBlockSet_le_rateRatio
    [IsFiniteMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (δ c : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ))
    (hc : c < δ) :
    μ.real (centeredAllLengthBadBlockSet T X c) ≤ δ / c := by
  apply le_of_tendsto'
    (tendsto_measureReal_finiteCenteredBadBlockSet
      (T := T) (μ := μ) X c (by finiteness))
  intro m
  exact hX.measureReal_finiteCenteredBadBlockSet_le_rateRatio
    hT m δ c hδ hc

end IsIntegrableSubadditiveProcessCandidate

namespace DiscreteMatrixCocycle

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-- The all-positive-length centered bad-block set for a discrete matrix
cocycle's log-positive norm process. -/
def centeredLogPlusAllLengthBadBlockSet
    (C : DiscreteMatrixCocycle (ι := ι) μ) (c : ℝ) : Set Ω :=
  centeredAllLengthBadBlockSet C.base C.logPlusNormObservable c

/-- The all-length cocycle bad-block measure is controlled by the same
centered Fekete-offset ratio as every finite cap.  This uses the cocycle's
bundled preservation and one-step log-positive integrability, but no
ergodicity or positive-dimension premise. -/
theorem HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusAllLengthBadBlockSet_le_rateRatio
    [IsFiniteMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (c : ℝ)
    (hc : c < C.integratedLogPlusGrowthRate hC -
      C.integratedLogPlusNorm 1) :
    μ.real (C.centeredLogPlusAllLengthBadBlockSet c) ≤
      (C.integratedLogPlusGrowthRate hC -
        C.integratedLogPlusNorm 1) / c := by
  apply le_of_tendsto'
    (tendsto_measureReal_finiteCenteredBadBlockSet
      (T := C.base) (μ := μ) C.logPlusNormObservable c (by finiteness))
  intro m
  simpa only [centeredLogPlusBadBlockSet] using
    hC.measureReal_centeredLogPlusBadBlockSet_le_rateRatio m c hc

end DiscreteMatrixCocycle

section BoundaryAudits

private def rmt31ZeroProcess {Ω : Type*} (_n : ℕ) (_ω : Ω) : ℝ := 0

private theorem rmt31ZeroProcess_candidate
    {Ω : Type*} [MeasurableSpace Ω] (T : Ω → Ω) (μ : Measure Ω) :
    IsIntegrableSubadditiveProcessCandidate T μ
      (rmt31ZeroProcess : ℕ → Ω → ℝ) where
  integrable := by
    intro n
    exact integrable_zero Ω ℝ μ
  add_le := by
    intros
    simp [rmt31ZeroProcess]

private def rmt31TwoPointProbability : Measure Bool :=
  ENNReal.ofReal 0.5 • (Measure.dirac false + Measure.dirac true)

private instance : IsProbabilityMeasure rmt31TwoPointProbability := by
  refine ⟨?_⟩
  simp [rmt31TwoPointProbability]
  rw [← ENNReal.ofReal_add (by norm_num : (0 : ℝ) ≤ 0.5)
    (by norm_num : (0 : ℝ) ≤ 0.5)]
  norm_num

private theorem rmt31Id_not_preErgodic :
    ¬ PreErgodic (id : Bool → Bool) rmt31TwoPointProbability := by
  intro h
  have hzero := h.measure_self_or_compl_eq_zero
    (s := ({false} : Set Bool)) (measurableSet_singleton false) (by simp)
  simp [rmt31TwoPointProbability] at hzero
  norm_num at hzero

private def rmt31TwoPointProcess (n : ℕ) (b : Bool) : ℝ :=
  if b then 0 else -((n - 1 : ℕ) : ℝ)

private theorem rmt31TwoPointProcess_candidate :
    IsIntegrableSubadditiveProcessCandidate (id : Bool → Bool)
      rmt31TwoPointProbability rmt31TwoPointProcess where
  integrable := by
    intro n
    refine Integrable.of_bound
      (measurable_of_finite (rmt31TwoPointProcess n)).aestronglyMeasurable n ?_
    filter_upwards with b
    cases b <;> simp [rmt31TwoPointProcess]
  add_le := by
    intro m n b
    cases b
    · simp only [Function.iterate_id, id_eq, rmt31TwoPointProcess,
        Bool.false_eq_true, if_false]
      rw [← neg_add]
      apply neg_le_neg
      norm_cast
      omega
    · simp [rmt31TwoPointProcess]

private def rmt31MassTwoMeasure : Measure Unit :=
  2 • Measure.dirac ()

private instance : IsFiniteMeasure rmt31MassTwoMeasure := by
  change IsFiniteMeasure (2 • Measure.dirac ())
  infer_instance

/-- The cap-zero approximant is empty.  This does not make the all-length
event empty. -/
example {Ω : Type*} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (c : ℝ) :
    finiteCenteredBadBlockSet T X 0 c = ∅ := by
  simp [finiteCenteredBadBlockSet]

/-- A finite-cap event always embeds in the event with no cap. -/
example {Ω : Type*} (T : Ω → Ω) (X : ℕ → Ω → ℝ)
    (m : ℕ) (c : ℝ) :
    finiteCenteredBadBlockSet T X m c ⊆
      centeredAllLengthBadBlockSet T X c :=
  finiteCenteredBadBlockSet_subset_allLength T X m c

/-- The zero process has no strict witness below a negative slope. -/
example {Ω : Type*} (T : Ω → Ω) {c : ℝ} (hc : c < 0) :
    centeredAllLengthBadBlockSet T
      (rmt31ZeroProcess : ℕ → Ω → ℝ) c = ∅ := by
  ext ω
  simp only [mem_centeredAllLengthBadBlockSet_iff,
    Set.notMem_empty, iff_false, not_exists]
  intro n
  rintro ⟨hn, hbad⟩
  simp only [centeredProcess, rmt31ZeroProcess, birkhoffSum,
    Finset.sum_const_zero, sub_zero] at hbad
  exact (not_lt_of_ge (mul_nonpos_of_nonpos_of_nonneg hc.le
    (Nat.cast_nonneg n))) hbad

/-- The all-length real measure is zero under the zero measure. -/
example {Ω : Type*} [MeasurableSpace Ω] (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) (c : ℝ) :
    (0 : Measure Ω).real (centeredAllLengthBadBlockSet T X c) = 0 := by
  simp

/-- Probability and ergodicity are unnecessary.  On this nonergodic
two-atom probability space the bad set is genuinely nonempty, has mass
`1 / 2`, and satisfies the generic ratio bound `1 / 2 ≤ 2 / 3`. -/
example :
    ¬ PreErgodic (id : Bool → Bool) rmt31TwoPointProbability ∧
      rmt31TwoPointProbability.real
          (centeredAllLengthBadBlockSet id rmt31TwoPointProcess
            (-(3 : ℝ) / 4)) = (1 : ℝ) / 2 ∧
      rmt31TwoPointProbability.real
          (centeredAllLengthBadBlockSet id rmt31TwoPointProcess
            (-(3 : ℝ) / 4)) ≤ (2 : ℝ) / 3 := by
  have hbad :
      centeredAllLengthBadBlockSet id rmt31TwoPointProcess
          (-(3 : ℝ) / 4) = ({false} : Set Bool) := by
    ext b
    cases b
    · simp only [mem_centeredAllLengthBadBlockSet_iff,
        Set.mem_singleton_iff, iff_true]
      refine ⟨5, by norm_num, ?_⟩
      norm_num [centeredProcess, rmt31TwoPointProcess, birkhoffSum]
    · norm_num [mem_centeredAllLengthBadBlockSet_iff,
        centeredProcess, rmt31TwoPointProcess, birkhoffSum]
  refine ⟨rmt31Id_not_preErgodic, ?_, ?_⟩
  · rw [hbad]
    simp [rmt31TwoPointProbability, Measure.real]
    norm_num
  · have hratio :=
      rmt31TwoPointProcess_candidate.measureReal_centeredAllLengthBadBlockSet_le_rateRatio
        (MeasurePreserving.id rmt31TwoPointProbability) (-(1 : ℝ) / 2)
          (-(3 : ℝ) / 4) (by
            intro n hn
            have hcenter :
                centeredProcess id rmt31TwoPointProcess n =
                  rmt31TwoPointProcess n := by
              funext b
              simp [centeredProcess, birkhoffSum, rmt31TwoPointProcess]
            rw [hcenter, rmt31TwoPointProbability, integral_smul_measure]
            rw [integral_add_measure (integrable_dirac (by simp))
              (integrable_dirac (by simp))]
            simp [rmt31TwoPointProcess]
            rw [ENNReal.toReal_ofReal (by norm_num : (0 : ℝ) ≤ 0.5)]
            have hnpos : (0 : ℝ) < n := by
              exact_mod_cast Nat.pos_of_ne_zero hn
            rw [Nat.cast_sub (Nat.one_le_iff_ne_zero.mpr hn)]
            push_cast
            rw [le_div_iff₀ hnpos]
            linarith) (by norm_num)
    norm_num at hratio ⊢
    exact hratio

/-- Equality at length one is excluded by the strict threshold, but a later
strict witness can still put the point in the all-length event. -/
example :
    false ∈ centeredAllLengthBadBlockSet id rmt31TwoPointProcess 0 := by
  rw [mem_centeredAllLengthBadBlockSet_iff]
  refine ⟨2, by norm_num, ?_⟩
  norm_num [centeredProcess, rmt31TwoPointProcess, birkhoffSum]

/-- The cap-one approximant makes the strict-threshold convention explicit. -/
example (c : ℝ) :
    finiteCenteredBadBlockSet id rmt31TwoPointProcess 1 c =
      (if 0 < c then Set.univ else ∅) := by
  ext b
  simp [finiteCenteredBadBlockSet]

/-- Finite measures need not be probability measures. -/
example {c : ℝ} (hc : c < 0) :
    rmt31MassTwoMeasure.real
        (centeredAllLengthBadBlockSet id
          (rmt31ZeroProcess : ℕ → Unit → ℝ) c) ≤ 0 / c := by
  apply IsIntegrableSubadditiveProcessCandidate.measureReal_centeredAllLengthBadBlockSet_le_rateRatio
      (rmt31ZeroProcess_candidate id rmt31MassTwoMeasure)
      (MeasurePreserving.id rmt31MassTwoMeasure) 0 c
  · intro n hn
    simp [centeredProcess, rmt31ZeroProcess, birkhoffSum]
  · exact hc

/-- The cocycle theorem remains valid for an empty matrix index. -/
example {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}
    [IsFiniteMeasure μ] {C : DiscreteMatrixCocycle (ι := Empty) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (c : ℝ)
    (hc : c < C.integratedLogPlusGrowthRate hC -
      C.integratedLogPlusNorm 1) :
    μ.real (C.centeredLogPlusAllLengthBadBlockSet c) ≤
      (C.integratedLogPlusGrowthRate hC -
        C.integratedLogPlusNorm 1) / c :=
  hC.measureReal_centeredLogPlusAllLengthBadBlockSet_le_rateRatio c hc

private def rmt31Collapse (_b : Bool) : Bool := true

private def rmt31OneShotProcess (n : ℕ) (b : Bool) : ℝ :=
  if b then 0 else if 2 ≤ n then -1 else 0

private theorem rmt31_iterate_collapse_true (n : ℕ) :
    rmt31Collapse^[n] true = true := by
  induction n with
  | zero => rfl
  | succ n ih =>
      rw [Function.iterate_succ_apply]
      simpa [rmt31Collapse] using ih

private theorem rmt31_iterate_collapse_of_ne_zero
    (n : ℕ) (hn : n ≠ 0) (b : Bool) :
    rmt31Collapse^[n] b = true := by
  cases n with
  | zero => contradiction
  | succ n =>
      rw [Function.iterate_succ_apply]
      simpa [rmt31Collapse] using rmt31_iterate_collapse_true n

private theorem rmt31OneShotProcess_candidate :
    IsIntegrableSubadditiveProcessCandidate rmt31Collapse (Measure.dirac true)
      rmt31OneShotProcess where
  integrable := by
    intro n
    exact Integrable.of_bound
      (measurable_of_finite (rmt31OneShotProcess n)).aestronglyMeasurable 1
      (by
        filter_upwards with b
        cases b <;> simp [rmt31OneShotProcess]
        split <;> norm_num)
  add_le := by
    intro m n b
    cases b
    · by_cases hm : m = 0
      · subst m
        simp [rmt31OneShotProcess]
      · rw [rmt31_iterate_collapse_of_ne_zero m hm false]
        by_cases hm1 : m = 1
        · subst m
          simp only [rmt31OneShotProcess, Bool.false_eq_true, if_false,
            if_true, Nat.reduceLeDiff, add_zero]
          split <;> norm_num
        · have hm2 : 2 ≤ m := by omega
          have hsum2 : 2 ≤ m + n := hm2.trans (Nat.le_add_right m n)
          simp [rmt31OneShotProcess, hm2, hsum2]
    · rw [rmt31_iterate_collapse_true]
      simp [rmt31OneShotProcess]

private theorem rmt31Collapse_preserving :
    MeasurePreserving rmt31Collapse (Measure.dirac true)
      (Measure.dirac true) := by
  refine ⟨measurable_const, ?_⟩
  change Measure.map (fun _ : Bool ↦ true) (Measure.dirac true) =
    Measure.dirac true
  exact Measure.map_dirac'
    (measurable_const : Measurable (fun _ : Bool ↦ true)) true

/-- Even for an integrable shifted-subadditive process over a finite
measure-preserving base, the raw all-length event need not be setwise
invariant. -/
example :
    rmt31Collapse ⁻¹'
        centeredAllLengthBadBlockSet rmt31Collapse rmt31OneShotProcess
          (-(2 : ℝ) / 5) ≠
      centeredAllLengthBadBlockSet rmt31Collapse rmt31OneShotProcess
        (-(2 : ℝ) / 5) := by
  have _hCandidate := rmt31OneShotProcess_candidate
  have _hPreserving := rmt31Collapse_preserving
  have hbad :
      centeredAllLengthBadBlockSet rmt31Collapse rmt31OneShotProcess
          (-(2 : ℝ) / 5) = ({false} : Set Bool) := by
    ext b
    cases b
    · simp only [mem_centeredAllLengthBadBlockSet_iff,
        Set.mem_singleton_iff, iff_true]
      refine ⟨2, by norm_num, ?_⟩
      norm_num [centeredProcess, rmt31OneShotProcess, birkhoffSum,
        rmt31Collapse]
    · norm_num [mem_centeredAllLengthBadBlockSet_iff,
        centeredProcess, rmt31OneShotProcess, birkhoffSum, rmt31Collapse]
  rw [hbad]
  intro heq
  have hfalse := Set.ext_iff.mp heq false
  simp [rmt31Collapse] at hfalse

end BoundaryAudits

#print axioms mem_centeredAllLengthBadBlockSet_iff
#print axioms finiteCenteredBadBlockSet_mono
#print axioms IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredAllLengthBadBlockSet
#print axioms tendsto_measure_finiteCenteredBadBlockSet
#print axioms tendsto_measureReal_finiteCenteredBadBlockSet
#print axioms IsIntegrableSubadditiveProcessCandidate.measureReal_centeredAllLengthBadBlockSet_le_rateRatio
#print axioms DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusAllLengthBadBlockSet_le_rateRatio

end NonlinearDynamics.Random.RandomCocycles
