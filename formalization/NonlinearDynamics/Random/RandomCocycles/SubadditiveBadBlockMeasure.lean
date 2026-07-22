import NonlinearDynamics.Random.RandomCocycles.SubadditiveIntervalPacking
import NonlinearDynamics.Random.RandomCocycles.SubadditiveUpperLimsup

/-!
# Finite centered bad-block measure control

This module turns the finite ordered interval packing from RMT-21 into a
measure estimate for short centered blocks.  For a centered process `Y`, a
length cap `m`, and a threshold `c`, the finite bad-block set consists of the
points admitting some positive length `n ≤ m` with `Y n < c * n`.

The proof counts visits to this set during the first `H` orbit positions,
identifies that count with a Birkhoff sum of an indicator, and integrates it
exactly under measure preservation.  At every marked start it chooses one
witnessing block length.  The greedy packing theorem then gives the pointwise
bound

`Y (H + m) ω ≤ c * finiteOrbitVisitCount T badSet H ω`

when `c ≤ 0` and `H + m ≠ 0`.  If `δ` is a lower bound for every positive
normalized centered integral and `c < δ`, the time-one centered identity
forces `c < δ ≤ 0`.  Integrating the packing inequality and letting `H` tend
to infinity yields

`μ.real badSet ≤ δ / c`.

The final theorem specializes `δ` to the deterministic integrated
log-positive cocycle rate minus the one-step integral.  Finite total measure
and preservation are used, but probability and ergodicity are not.

This is still a finite bad-block theorem, not the lower half of Kingman's
theorem.  It proves no lower liminf, samplewise convergence, equality with the
integrated rate, `L¹` convergence, limit-integral interchange, signed
logarithmic growth, Lyapunov exponent, or Oseledets splitting.
-/

open MeasureTheory Set Filter Topology Finset Function
open scoped BigOperators ENNReal Topology

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ uι

/-- The number of visits among the orbit positions `0, ..., H - 1` to `s`.
This definition is natural-valued and total at horizon zero. -/
noncomputable def finiteOrbitVisitCount {Ω : Type uΩ} (T : Ω → Ω)
    (s : Set Ω) (H : ℕ) (ω : Ω) : ℕ := by
  classical
  exact ((Finset.range H).filter fun j ↦ T^[j] ω ∈ s).card

/-- The real cast of a finite orbit-visit count is the Birkhoff sum of the
set's real-valued indicator.  This is finite combinatorics and needs no
measurable-space or measure hypothesis. -/
theorem natCast_finiteOrbitVisitCount_eq_birkhoffSum_indicator
    {Ω : Type uΩ} (T : Ω → Ω) (s : Set Ω) (H : ℕ) (ω : Ω) :
    (finiteOrbitVisitCount T s H ω : ℝ) =
      birkhoffSum T (s.indicator fun _ ↦ (1 : ℝ)) H ω := by
  classical
  rw [finiteOrbitVisitCount, Finset.natCast_card_filter]
  unfold birkhoffSum
  apply Finset.sum_congr rfl
  intro j hj
  by_cases hjs : T^[j] ω ∈ s <;> simp [hjs]

/-- Under finite total measure and preservation, the integral of a finite
visit count is the horizon times the real measure of the visited set.  Null
measurability is sufficient; ordinary measurability is not required. -/
theorem integral_finiteOrbitVisitCount
    {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω} {μ : Measure Ω}
    [IsFiniteMeasure μ] (hT : MeasurePreserving T μ μ)
    {s : Set Ω} (hs : NullMeasurableSet s μ) (H : ℕ) :
    (∫ ω, (finiteOrbitVisitCount T s H ω : ℝ) ∂μ) =
      H * μ.real s := by
  simp_rw [natCast_finiteOrbitVisitCount_eq_birkhoffSum_indicator]
  rw [integral_birkhoffSum_eq_nat_mul hT
    ((integrable_const (1 : ℝ)).indicator₀ hs) H]
  rw [integral_indicator₀ hs, setIntegral_const]
  simp

/-- Points admitting a strict centered-process block below slope `c`, with
the witness length restricted to the positive finite window `[1, m]`. -/
def finiteCenteredBadBlockSet {Ω : Type uΩ} (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) (m : ℕ) (c : ℝ) : Set Ω :=
  ⋃ n ∈ Finset.Icc 1 m,
    {ω | centeredProcess T X n ω < c * (n : ℝ)}

namespace IsIntegrableSubadditiveProcessCandidate

variable {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
  {μ : Measure Ω} {X : ℕ → Ω → ℝ}

/-- Every finite centered bad-block set is null measurable under preservation.
The proof uses finite-horizon centered integrability, strict sublevel-set null
measurability, and a finite union over positive candidate lengths. -/
theorem nullMeasurableSet_finiteCenteredBadBlockSet
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (m : ℕ) (c : ℝ) :
    NullMeasurableSet (finiteCenteredBadBlockSet T X m c) μ := by
  apply Finset.nullMeasurableSet_biUnion
  intro n hn
  exact nullMeasurableSet_lt
    (hX.integrable_centeredProcess hT n).aemeasurable
    measurable_const.aemeasurable

/-- Greedy packing bounds the centered process on the enlarged horizon by the
number of visits to the finite bad-block set.  The single excluded corner
`H + m = 0` is genuine because the centered time-zero value is `X 0`, which a
generic candidate need not make nonpositive. -/
theorem centeredProcess_le_badBlockVisitCount
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (H m : ℕ) (hHm : H + m ≠ 0) (c : ℝ) (hc : c ≤ 0) (ω : Ω) :
    centeredProcess T X (H + m) ω ≤
      c * (finiteOrbitVisitCount T
        (finiteCenteredBadBlockSet T X m c) H ω : ℝ) := by
  classical
  let marked : Finset ℕ :=
    (Finset.range H).filter fun j ↦
      T^[j] ω ∈ finiteCenteredBadBlockSet T X m c
  have hexists : ∀ j ∈ marked, ∃ n ∈ Finset.Icc 1 m,
      centeredProcess T X n (T^[j] ω) < c * (n : ℝ) := by
    intro j hj
    have hjbad : T^[j] ω ∈ finiteCenteredBadBlockSet T X m c :=
      (Finset.mem_filter.mp hj).2
    rw [finiteCenteredBadBlockSet] at hjbad
    simp only [Set.mem_iUnion, Set.mem_setOf_eq] at hjbad
    rcases hjbad with ⟨n, hn, hbad⟩
    exact ⟨n, hn, hbad⟩
  let length : ℕ → ℕ := fun j ↦
    if hj : j ∈ marked then Classical.choose (hexists j hj) else 1
  have hlength_mem : ∀ j ∈ marked, length j ∈ Finset.Icc 1 m := by
    intro j hj
    simpa only [length, dif_pos hj] using
      (Classical.choose_spec (hexists j hj)).1
  have hlength_cost : ∀ j ∈ marked,
      centeredProcess T X (length j) (T^[j] ω) <
        c * (length j : ℝ) := by
    intro j hj
    simpa only [length, dif_pos hj] using
      (Classical.choose_spec (hexists j hj)).2
  have hmarked : marked ⊆ Finset.range H :=
    Finset.filter_subset _ _
  have hlength : ∀ j ∈ marked, 0 < length j ∧ length j ≤ m := by
    intro j hj
    exact Finset.mem_Icc.mp (hlength_mem j hj)
  have hcost : ∀ j ∈ marked,
      centeredProcess T X (length j) (T^[j] ω) ≤
        c * (length j : ℝ) := by
    intro j hj
    exact (hlength_cost j hj).le
  have hpack := OrderedNatIntervalPacking.le_mul_card_of_greedy_cover
    hX.centeredProcess_add_le hX.centeredProcess_nonpos_of_ne_zero
    H m marked length hmarked hlength hHm ω c hc hcost
  simpa only [marked, finiteOrbitVisitCount] using hpack

/-- A lower bound `δ` for every positive normalized centered integral controls
the real measure of every finite strict bad-block set by `δ / c` whenever
`c < δ`.  The time-one centered identity derives `c < δ ≤ 0`, so division by
`c` reverses the final inequality.  No probability or ergodicity assumption
is used. -/
theorem measureReal_finiteCenteredBadBlockSet_le_rateRatio
    [IsFiniteMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (m : ℕ) (δ c : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ))
    (hc : c < δ) :
    μ.real (finiteCenteredBadBlockSet T X m c) ≤ δ / c := by
  let s := finiteCenteredBadBlockSet T X m c
  have hs : NullMeasurableSet s μ :=
    hX.nullMeasurableSet_finiteCenteredBadBlockSet hT m c
  have hδnonpos : δ ≤ 0 := by
    simpa only [centeredProcess_one, Pi.zero_apply, integral_zero,
      Nat.cast_one, zero_div] using hδ 1 one_ne_zero
  have hcneg : c < 0 := hc.trans_le hδnonpos
  have hfinite : ∀ H : ℕ, H ≠ 0 →
      δ ≤ (c * μ.real s) * ((H : ℝ) / ((H : ℝ) + m)) := by
    intro H hH
    have hHm : H + m ≠ 0 := by omega
    have hcenterInt : Integrable (centeredProcess T X (H + m)) μ :=
      hX.integrable_centeredProcess hT (H + m)
    have hindicator : Integrable (s.indicator fun _ ↦ (1 : ℝ)) μ :=
      (integrable_const (1 : ℝ)).indicator₀ hs
    have hcount : Integrable
        (fun ω ↦ (finiteOrbitVisitCount T s H ω : ℝ)) μ := by
      rw [show (fun ω ↦ (finiteOrbitVisitCount T s H ω : ℝ)) =
          birkhoffSum T (s.indicator fun _ ↦ (1 : ℝ)) H by
        funext ω
        exact natCast_finiteOrbitVisitCount_eq_birkhoffSum_indicator
          T s H ω]
      exact integrable_birkhoffSum hT hindicator H
    have hpoint : ∀ ω,
        centeredProcess T X (H + m) ω ≤
          c * (finiteOrbitVisitCount T s H ω : ℝ) := by
      intro ω
      exact hX.centeredProcess_le_badBlockVisitCount
        H m hHm c hcneg.le ω
    have hintle :
        (∫ ω, centeredProcess T X (H + m) ω ∂μ) ≤
          c * ((H : ℝ) * μ.real s) := by
      calc
        (∫ ω, centeredProcess T X (H + m) ω ∂μ) ≤
            ∫ ω, c * (finiteOrbitVisitCount T s H ω : ℝ) ∂μ := by
          exact integral_mono hcenterInt (hcount.const_mul c) hpoint
        _ = c * (∫ ω, (finiteOrbitVisitCount T s H ω : ℝ) ∂μ) := by
          rw [integral_const_mul]
        _ = c * ((H : ℝ) * μ.real s) := by
          rw [integral_finiteOrbitVisitCount hT hs H]
    have hdenom : 0 ≤ ((H + m : ℕ) : ℝ) := Nat.cast_nonneg _
    have hquot : δ ≤
        (c * ((H : ℝ) * μ.real s)) / ((H + m : ℕ) : ℝ) :=
      (hδ (H + m) hHm).trans
        (div_le_div_of_nonneg_right hintle hdenom)
    rw [Nat.cast_add] at hquot
    calc
      δ ≤ c * ((H : ℝ) * μ.real s) / ((H : ℝ) + (m : ℝ)) := hquot
      _ = (c * μ.real s) * ((H : ℝ) / ((H : ℝ) + m)) := by ring
  have hlim : Tendsto
      (fun H : ℕ ↦ (c * μ.real s) * ((H : ℝ) / ((H : ℝ) + m)))
      atTop (𝓝 (c * μ.real s)) := by
    simpa only [mul_one] using
      tendsto_const_nhds.mul (tendsto_natCast_div_add_atTop (m : ℝ))
  have hδmul : δ ≤ c * μ.real s := by
    apply ge_of_tendsto hlim
    filter_upwards [eventually_ne_atTop 0] with H hH
    exact hfinite H hH
  rw [le_div_iff_of_neg hcneg]
  simpa only [mul_comm] using hδmul

end IsIntegrableSubadditiveProcessCandidate

namespace DiscreteMatrixCocycle

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-- The finite centered bad-block set for a discrete matrix cocycle's
log-positive norm process. -/
def centeredLogPlusBadBlockSet
    (C : DiscreteMatrixCocycle (ι := ι) μ) (m : ℕ) (c : ℝ) : Set Ω :=
  finiteCenteredBadBlockSet C.base C.logPlusNormObservable m c

/-- The cocycle bad-block measure is controlled by the ratio of its centered
integrated Fekete offset to any strictly lower threshold.  This finite-measure
specialization uses the cocycle's bundled base preservation and the existing
one-step log-positive integrability hypothesis, but no ergodicity. -/
theorem HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusBadBlockSet_le_rateRatio
    [IsFiniteMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (m : ℕ) (c : ℝ)
    (hc : c < C.integratedLogPlusGrowthRate hC -
      C.integratedLogPlusNorm 1) :
    μ.real (C.centeredLogPlusBadBlockSet m c) ≤
      (C.integratedLogPlusGrowthRate hC -
        C.integratedLogPlusNorm 1) / c := by
  let δ := C.integratedLogPlusGrowthRate hC - C.integratedLogPlusNorm 1
  let hX := hC.isIntegrableSubadditiveProcessCandidate
  have hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess C.base C.logPlusNormObservable n ω ∂μ) /
        (n : ℝ) := by
    intro n hn
    have hnR : (n : ℝ) ≠ 0 := by exact_mod_cast hn
    have hrate :=
      hC.integratedLogPlusGrowthRate_le_normalized (k := n) hn
    rw [normalizedIntegratedLogPlusNorm] at hrate
    rw [hX.integral_centeredProcess C.base_preserving n]
    change δ ≤
      (C.integratedLogPlusNorm n -
        (n : ℝ) * C.integratedLogPlusNorm 1) / (n : ℝ)
    calc
      δ ≤ C.integratedLogPlusNorm n / (n : ℝ) -
          C.integratedLogPlusNorm 1 := by
        exact sub_le_sub_right hrate _
      _ = (C.integratedLogPlusNorm n -
          (n : ℝ) * C.integratedLogPlusNorm 1) / (n : ℝ) := by
        field_simp [hnR]
  simpa only [δ, hX, centeredLogPlusBadBlockSet] using
    hX.measureReal_finiteCenteredBadBlockSet_le_rateRatio
      C.base_preserving m δ c hδ hc

end DiscreteMatrixCocycle

section BoundaryProbes

private def rmt30ZeroProcess {Ω : Type*} (_n : ℕ) (_ω : Ω) : ℝ := 0

private theorem rmt30ZeroProcess_candidate
    {Ω : Type*} [MeasurableSpace Ω] (T : Ω → Ω) (μ : Measure Ω) :
    IsIntegrableSubadditiveProcessCandidate T μ
      (rmt30ZeroProcess : ℕ → Ω → ℝ) where
  integrable := by
    intro n
    exact integrable_zero Ω ℝ μ
  add_le := by
    intros
    simp [rmt30ZeroProcess]

private def rmt30PositiveAtZeroProcess (n : ℕ) (_ω : Unit) : ℝ :=
  if n = 0 then 1 else 0

private theorem rmt30PositiveAtZeroProcess_candidate :
    IsIntegrableSubadditiveProcessCandidate (id : Unit → Unit)
      (0 : Measure Unit) rmt30PositiveAtZeroProcess where
  integrable := by simp
  add_le := by
    intro m n ω
    simp only [Function.iterate_id, id_eq]
    by_cases hm : m = 0 <;> by_cases hn : n = 0 <;>
      simp [rmt30PositiveAtZeroProcess, hm, hn]

private def rmt30TwoPointProbability : Measure Bool :=
  ENNReal.ofReal 0.5 • (Measure.dirac false + Measure.dirac true)

private instance : IsProbabilityMeasure rmt30TwoPointProbability := by
  refine ⟨?_⟩
  simp [rmt30TwoPointProbability]
  rw [← ENNReal.ofReal_add (by norm_num : (0 : ℝ) ≤ 0.5)
    (by norm_num : (0 : ℝ) ≤ 0.5)]
  norm_num

private theorem rmt30Id_not_preErgodic :
    ¬ PreErgodic (id : Bool → Bool) rmt30TwoPointProbability := by
  intro h
  have hzero := h.measure_self_or_compl_eq_zero
    (s := ({false} : Set Bool)) (measurableSet_singleton false) (by simp)
  simp [rmt30TwoPointProbability] at hzero
  norm_num at hzero

/-- A centered nonpositive process that approaches slope `-1` on one atom
and stays zero on the other. -/
private def rmt30TwoPointProcess (n : ℕ) (b : Bool) : ℝ :=
  if b then 0 else -((n - 1 : ℕ) : ℝ)

private theorem rmt30TwoPointProcess_candidate :
    IsIntegrableSubadditiveProcessCandidate (id : Bool → Bool)
      rmt30TwoPointProbability rmt30TwoPointProcess where
  integrable := by
    intro n
    refine Integrable.of_bound
      (measurable_of_finite (rmt30TwoPointProcess n)).aestronglyMeasurable n ?_
    filter_upwards with b
    cases b <;> simp [rmt30TwoPointProcess]
  add_le := by
    intro m n b
    cases b
    · simp only [Function.iterate_id, id_eq, rmt30TwoPointProcess,
        Bool.false_eq_true, if_false]
      rw [← neg_add]
      apply neg_le_neg
      norm_cast
      omega
    · simp [rmt30TwoPointProcess]

private def rmt30MassTwoMeasure : Measure Unit :=
  2 • Measure.dirac ()

private instance : IsFiniteMeasure rmt30MassTwoMeasure := by
  change IsFiniteMeasure (2 • Measure.dirac ())
  infer_instance

/-- A zero length cap makes the candidate-length window empty. -/
example {Ω : Type*} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (c : ℝ) :
    finiteCenteredBadBlockSet T X 0 c = ∅ := by
  simp [finiteCenteredBadBlockSet]

/-- Horizon zero remains valid when the length cap is positive. -/
example {Ω : Type*} [MeasurableSpace Ω] {T : Ω → Ω}
    {μ : Measure Ω} {X : ℕ → Ω → ℝ}
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    {m : ℕ} (hm : m ≠ 0) {c : ℝ} (hc : c ≤ 0) (ω : Ω) :
    centeredProcess T X m ω ≤
      c * (finiteOrbitVisitCount T
        (finiteCenteredBadBlockSet T X m c) 0 ω : ℝ) := by
  simpa only [zero_add] using
    hX.centeredProcess_le_badBlockVisitCount 0 m (by omega) c hc ω

/-- For the zero process and a negative threshold, the finite bad set is
empty. -/
example {Ω : Type*} (T : Ω → Ω) (m : ℕ) {c : ℝ} (hc : c < 0) :
    finiteCenteredBadBlockSet T
      (rmt30ZeroProcess : ℕ → Ω → ℝ) m c = ∅ := by
  ext ω
  simp only [finiteCenteredBadBlockSet, Set.mem_iUnion, Set.mem_setOf_eq,
    Set.notMem_empty, iff_false, not_exists]
  intro n
  simp only [Finset.mem_Icc]
  intro hn
  simp only [centeredProcess, rmt30ZeroProcess, birkhoffSum,
    Finset.sum_const_zero, sub_zero, not_lt]
  exact mul_nonpos_of_nonpos_of_nonneg hc.le (Nat.cast_nonneg n)

/-- The joint corner `H = m = 0` is genuinely false for a candidate that is
positive only at time zero. -/
example :
    ¬ centeredProcess id rmt30PositiveAtZeroProcess (0 + 0) () ≤
      (-1 : ℝ) * (finiteOrbitVisitCount id
        (finiteCenteredBadBlockSet id rmt30PositiveAtZeroProcess 0 (-1))
          0 () : ℝ) := by
  norm_num [centeredProcess, rmt30PositiveAtZeroProcess,
    finiteOrbitVisitCount]

/-- Under zero measure, every real bad-set measure vanishes. -/
example {Ω : Type*} [MeasurableSpace Ω] (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) (m : ℕ) (c : ℝ) :
    (0 : Measure Ω).real (finiteCenteredBadBlockSet T X m c) = 0 := by
  simp

/-- On a preserved nonergodic probability space, a genuinely nonempty bad
set has mass `1 / 2` and satisfies the nontrivial ratio bound `1 / 2 ≤ 2 / 3`. -/
example :
    ¬ PreErgodic (id : Bool → Bool) rmt30TwoPointProbability ∧
      rmt30TwoPointProbability.real
          (finiteCenteredBadBlockSet id rmt30TwoPointProcess 5
            (-(3 : ℝ) / 4)) = (1 : ℝ) / 2 ∧
      rmt30TwoPointProbability.real
          (finiteCenteredBadBlockSet id rmt30TwoPointProcess 5
            (-(3 : ℝ) / 4)) ≤ (2 : ℝ) / 3 := by
  have hbad :
      finiteCenteredBadBlockSet id rmt30TwoPointProcess 5
          (-(3 : ℝ) / 4) = ({false} : Set Bool) := by
    ext b
    cases b
    · simp only [finiteCenteredBadBlockSet, Set.mem_iUnion,
        Set.mem_setOf_eq, Set.mem_singleton_iff, iff_true]
      refine ⟨5, by norm_num, ?_⟩
      norm_num [centeredProcess, rmt30TwoPointProcess, birkhoffSum]
    · norm_num [finiteCenteredBadBlockSet, centeredProcess,
        rmt30TwoPointProcess, birkhoffSum]
  refine ⟨rmt30Id_not_preErgodic, ?_, ?_⟩
  · rw [hbad]
    simp [rmt30TwoPointProbability, Measure.real]
    norm_num
  · have hratio :=
      rmt30TwoPointProcess_candidate.measureReal_finiteCenteredBadBlockSet_le_rateRatio
        (MeasurePreserving.id rmt30TwoPointProbability) 5 (-(1 : ℝ) / 2)
          (-(3 : ℝ) / 4) (by
            intro n hn
            have hcenter :
                centeredProcess id rmt30TwoPointProcess n =
                  rmt30TwoPointProcess n := by
              funext b
              simp [centeredProcess, birkhoffSum, rmt30TwoPointProcess]
            rw [hcenter, rmt30TwoPointProbability, integral_smul_measure]
            rw [integral_add_measure (integrable_dirac (by simp))
              (integrable_dirac (by simp))]
            simp [rmt30TwoPointProcess]
            rw [ENNReal.toReal_ofReal (by norm_num : (0 : ℝ) ≤ 0.5)]
            have hnpos : (0 : ℝ) < n := by
              exact_mod_cast Nat.pos_of_ne_zero hn
            rw [Nat.cast_sub (Nat.one_le_iff_ne_zero.mpr hn)]
            push_cast
            rw [le_div_iff₀ hnpos]
            linarith) (by norm_num)
    norm_num at hratio ⊢
    exact hratio

/-- Equality with the time-one threshold is not marked because the bad-block
definition is strict. -/
example {Ω : Type*} (T : Ω → Ω) (X : ℕ → Ω → ℝ) :
    finiteCenteredBadBlockSet T X 1 0 = ∅ := by
  simp [finiteCenteredBadBlockSet]

/-- Finite scalar rescaling of the measure is supported without probability
normalization. -/
example (m : ℕ) {c : ℝ} (hc : c < 0) :
    rmt30MassTwoMeasure.real
        (finiteCenteredBadBlockSet id
          (rmt30ZeroProcess : ℕ → Unit → ℝ) m c) ≤ 0 / c := by
  apply IsIntegrableSubadditiveProcessCandidate.measureReal_finiteCenteredBadBlockSet_le_rateRatio
      (rmt30ZeroProcess_candidate id rmt30MassTwoMeasure)
      (MeasurePreserving.id rmt30MassTwoMeasure) m 0 c
  · intro n hn
    simp [centeredProcess, rmt30ZeroProcess, birkhoffSum]
  · exact hc

/-- The cocycle endpoint retains the empty matrix-index boundary. -/
example {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}
    [IsFiniteMeasure μ] {C : DiscreteMatrixCocycle (ι := Empty) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (m : ℕ) (c : ℝ)
    (hc : c < C.integratedLogPlusGrowthRate hC -
      C.integratedLogPlusNorm 1) :
    μ.real (C.centeredLogPlusBadBlockSet m c) ≤
      (C.integratedLogPlusGrowthRate hC -
        C.integratedLogPlusNorm 1) / c :=
  hC.measureReal_centeredLogPlusBadBlockSet_le_rateRatio m c hc

end BoundaryProbes

#print axioms natCast_finiteOrbitVisitCount_eq_birkhoffSum_indicator
#print axioms integral_finiteOrbitVisitCount
#print axioms IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_finiteCenteredBadBlockSet
#print axioms IsIntegrableSubadditiveProcessCandidate.centeredProcess_le_badBlockVisitCount
#print axioms IsIntegrableSubadditiveProcessCandidate.measureReal_finiteCenteredBadBlockSet_le_rateRatio
#print axioms DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusBadBlockSet_le_rateRatio

end NonlinearDynamics.Random.RandomCocycles
