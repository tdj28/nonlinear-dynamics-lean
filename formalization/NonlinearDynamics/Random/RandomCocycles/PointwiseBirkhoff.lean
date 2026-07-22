import NonlinearDynamics.Random.RandomCocycles.KoopmanL2Mean
import Mathlib.MeasureTheory.Function.L1Space.AEEqFun
import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# Pointwise Birkhoff convergence by maximal closure

This module closes the gap left deliberately open by `KoopmanL2Mean`.  On a
finite measure space, it proves full-sequence almost-everywhere convergence of
the real Birkhoff averages of every integrable observable.

The proof has two independent halves.  First, the infinite Hopf estimate
controls the event where an approximation error has a large average.  A fixed
Cauchy failure for the target observable must then lie in that maximal-error
event or in the null set where a chosen approximant fails to converge.  Dense
approximation makes every positive Cauchy-failure scale null, reciprocal
natural thresholds make the conclusion countable, and completeness of the
reals turns the resulting pointwise Cauchy sequences into convergent ones.

Second, finite total mass gives a continuous inclusion from real `L²` to real
`L¹` with dense range.  The fixed-plus-simple-coboundary core constructed in
`KoopmanL2Mean` therefore becomes an `L¹`-dense pointwise-good class.  This
supplies the approximants consumed by the abstract maximal-closure theorem.

The final theorem assumes finite total measure and measure preservation.  It
does not assume probability normalization, ergodicity, injectivity,
surjectivity, or invertibility.  It proves convergence-event membership only:
the limit is not identified with a conditional expectation or an ergodic
constant.  The finite-measure hypothesis belongs to this proof route and is
not asserted to be the sharp boundary of the pointwise ergodic theorem.
-/

open MeasureTheory Set Filter Function
open scoped ENNReal Topology

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ

variable {Ω : Type uΩ} [MeasurableSpace Ω]
  {T : Ω → Ω} {f g : Ω → ℝ} {μ : Measure Ω}

omit [MeasurableSpace Ω] in
/-- The absolute value of a real Birkhoff average is bounded by the Birkhoff
average of the pointwise absolute value, including the totalized horizon-zero
case. -/
theorem abs_birkhoffAverage_le_birkhoffAverage_abs
    (T : Ω → Ω) (f : Ω → ℝ) (n : ℕ) (ω : Ω) :
    |birkhoffAverage ℝ T f n ω| ≤
      birkhoffAverage ℝ T (fun x ↦ |f x|) n ω := by
  simp only [birkhoffAverage, birkhoffSum, smul_eq_mul]
  have hn : 0 ≤ (n : ℝ)⁻¹ := inv_nonneg.mpr (Nat.cast_nonneg n)
  rw [abs_mul, abs_of_nonneg hn]
  exact mul_le_mul_of_nonneg_left
    (Finset.abs_sum_le_sum_abs (fun j ↦ f (T^[j] ω)) (Finset.range n)) hn

omit [MeasurableSpace Ω] in
/-- The positive-time event on which the absolute value of at least one
Birkhoff average strictly exceeds `a`. -/
def birkhoffAverageAbsoluteExceedanceSet
    (T : Ω → Ω) (f : Ω → ℝ) (a : ℝ) : Set Ω :=
  {ω | ∃ k, 1 ≤ k ∧ a < |birkhoffAverage ℝ T f k ω|}

omit [MeasurableSpace Ω] in
/-- Membership in the absolute positive-time average-exceedance event. -/
@[simp] theorem mem_birkhoffAverageAbsoluteExceedanceSet_iff
    {a : ℝ} {ω : Ω} :
    ω ∈ birkhoffAverageAbsoluteExceedanceSet T f a ↔
      ∃ k, 1 ≤ k ∧ a < |birkhoffAverage ℝ T f k ω| := by
  rfl

omit [MeasurableSpace Ω] in
/-- Absolute average exceedance is pointwise dominated by ordinary average
exceedance for the absolute observable. -/
theorem birkhoffAverageAbsoluteExceedanceSet_subset (a : ℝ) :
    birkhoffAverageAbsoluteExceedanceSet T f a ⊆
      birkhoffAverageExceedanceSet T (fun x ↦ |f x|) a := by
  rintro ω ⟨k, hk, hka⟩
  exact ⟨k, hk, hka.trans_le
    (abs_birkhoffAverage_le_birkhoffAverage_abs T f k ω)⟩

/-- The weak maximal estimate for absolute positive-time average exceedance.
This is a weak `(1,1)` event bound, not an `L¹` norm bound for a maximal
function. -/
theorem measureReal_birkhoffAverageAbsoluteExceedanceSet_le
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ)
    {a : ℝ} (ha : 0 < a) :
    μ.real (birkhoffAverageAbsoluteExceedanceSet T f a) ≤
      (∫ x, |f x| ∂μ) / a := by
  calc
    μ.real (birkhoffAverageAbsoluteExceedanceSet T f a) ≤
        μ.real (birkhoffAverageExceedanceSet T (fun x ↦ |f x|) a) :=
      measureReal_mono (birkhoffAverageAbsoluteExceedanceSet_subset a)
    _ ≤ (∫ x, max |f x| 0 ∂μ) / a :=
      measureReal_birkhoffAverageExceedanceSet_le hT hf.abs ha
    _ = (∫ x, |f x| ∂μ) / a := by
      have heq : (fun x ↦ max |f x| 0) =ᵐ[μ] fun x ↦ |f x| :=
        Eventually.of_forall fun x ↦ max_eq_left (abs_nonneg (f x))
      rw [integral_congr_ae heq]

omit [MeasurableSpace Ω] in
/-- Points where the Birkhoff-average sequence fails the Cauchy test at the
fixed scale `ε`.  The non-strict exceptional inequality is chosen so that its
complement supplies the strict inequality required by the metric Cauchy
criterion. -/
def birkhoffCauchyExceptionalSet
    (T : Ω → Ω) (f : Ω → ℝ) (ε : ℝ) : Set Ω :=
  {ω | ∀ N : ℕ, ∃ m ≥ N, ∃ n ≥ N,
    ε ≤ |birkhoffAverage ℝ T f m ω - birkhoffAverage ℝ T f n ω|}

omit [MeasurableSpace Ω] in
/-- Membership in the fixed-scale Birkhoff Cauchy exceptional event. -/
@[simp] theorem mem_birkhoffCauchyExceptionalSet_iff {ε : ℝ} {ω : Ω} :
    ω ∈ birkhoffCauchyExceptionalSet T f ε ↔
      ∀ N : ℕ, ∃ m ≥ N, ∃ n ≥ N,
        ε ≤ |birkhoffAverage ℝ T f m ω -
          birkhoffAverage ℝ T f n ω| := by
  rfl

/-- A measurable observable under measurable dynamics has a measurable
fixed-scale Birkhoff Cauchy exceptional event. -/
theorem measurableSet_birkhoffCauchyExceptionalSet
    (hT : Measurable T) (hf : Measurable f) (ε : ℝ) :
    MeasurableSet (birkhoffCauchyExceptionalSet T f ε) := by
  rw [show birkhoffCauchyExceptionalSet T f ε =
      ⋂ N : ℕ, ⋃ m : {m : ℕ // N ≤ m}, ⋃ n : {n : ℕ // N ≤ n},
        {ω | ε ≤ |birkhoffAverage ℝ T f m.1 ω -
          birkhoffAverage ℝ T f n.1 ω|} by
    ext ω
    simp [birkhoffCauchyExceptionalSet]]
  exact MeasurableSet.iInter fun N ↦ MeasurableSet.iUnion fun m ↦
    MeasurableSet.iUnion fun n ↦ measurableSet_le measurable_const (by
      simpa only [Real.norm_eq_abs, Pi.sub_apply] using
        ((measurable_birkhoffAverage hT hf m.1).sub
          (measurable_birkhoffAverage hT hf n.1)).norm)

/-- Quasi-measure preservation transports every fixed-scale Cauchy
exceptional event across almost-everywhere equal observable representatives. -/
theorem birkhoffCauchyExceptionalSet_ae_eq_of_ae_eq
    (hT : Measure.QuasiMeasurePreserving T μ μ)
    (hfg : f =ᵐ[μ] g) (ε : ℝ) :
    birkhoffCauchyExceptionalSet T f ε =ᵐ[μ]
      birkhoffCauchyExceptionalSet T g ε := by
  have havg : ∀ᵐ ω ∂μ, ∀ n : ℕ,
      birkhoffAverage ℝ T f n ω = birkhoffAverage ℝ T g n ω := by
    rw [ae_all_iff]
    intro n
    exact hT.birkhoffAverage_ae_eq_of_ae_eq ℝ hfg n
  filter_upwards [havg] with ω hω
  apply propext
  change (∀ N : ℕ, ∃ m ≥ N, ∃ n ≥ N,
      ε ≤ |birkhoffAverage ℝ T f m ω - birkhoffAverage ℝ T f n ω|) ↔
    ∀ N : ℕ, ∃ m ≥ N, ∃ n ≥ N,
      ε ≤ |birkhoffAverage ℝ T g m ω - birkhoffAverage ℝ T g n ω|
  simp_rw [hω]

/-- An almost-everywhere measurable observable has a null-measurable
fixed-scale Cauchy exceptional event under quasi-measure-preserving dynamics. -/
theorem nullMeasurableSet_birkhoffCauchyExceptionalSet_of_aemeasurable
    (hf : AEMeasurable f μ)
    (hT : Measure.QuasiMeasurePreserving T μ μ) (ε : ℝ) :
    NullMeasurableSet (birkhoffCauchyExceptionalSet T f ε) μ := by
  let f' := hf.mk f
  have hfm : Measurable f' := hf.measurable_mk
  have heq : f =ᵐ[μ] f' := hf.ae_eq_mk
  exact
    (measurableSet_birkhoffCauchyExceptionalSet hT.measurable hfm ε).nullMeasurableSet.congr
      (birkhoffCauchyExceptionalSet_ae_eq_of_ae_eq hT heq ε).symm

/-- Integrability supplies the almost-everywhere measurability needed for
fixed-scale exceptional-event null measurability. -/
theorem nullMeasurableSet_birkhoffCauchyExceptionalSet_of_integrable
    (hf : Integrable f μ) (hT : Measure.QuasiMeasurePreserving T μ μ)
    (ε : ℝ) :
    NullMeasurableSet (birkhoffCauchyExceptionalSet T f ε) μ :=
  nullMeasurableSet_birkhoffCauchyExceptionalSet_of_aemeasurable
    hf.aemeasurable hT ε

omit [MeasurableSpace Ω] in
/-- At a point where the approximant `g` has convergent averages, a Cauchy
failure for `f` forces an absolute maximal exceedance for the approximation
error `f - g`.  Witness horizons are forced past one, so the totalized
horizon-zero average never enters the maximal event. -/
theorem birkhoffCauchyExceptionalSet_subset_exceedance_union_compl
    {ε : ℝ} (hε : 0 < ε) :
    birkhoffCauchyExceptionalSet T f ε ⊆
      birkhoffAverageAbsoluteExceedanceSet T (f - g) (ε / 3) ∪
        (birkhoffConvergenceSet T g)ᶜ := by
  intro ω hω
  by_cases hgood : ω ∈ birkhoffConvergenceSet T g
  · apply Set.mem_union_left
    obtain ⟨c, hc⟩ := mem_birkhoffConvergenceSet_iff.mp hgood
    obtain ⟨N, hN⟩ := Metric.cauchySeq_iff.mp hc.cauchySeq
      (ε / 3) (by positivity)
    obtain ⟨m, hm, n, hn, hmn⟩ := hω (max N 1)
    have hmN : N ≤ m := le_trans (le_max_left _ _) hm
    have hnN : N ≤ n := le_trans (le_max_left _ _) hn
    have hm1 : 1 ≤ m := le_trans (le_max_right _ _) hm
    have hn1 : 1 ≤ n := le_trans (le_max_right _ _) hn
    have hgmgn : |birkhoffAverage ℝ T g m ω -
        birkhoffAverage ℝ T g n ω| < ε / 3 := by
      simpa only [Real.dist_eq] using hN m hmN n hnN
    by_contra hmax
    simp only [mem_birkhoffAverageAbsoluteExceedanceSet_iff, not_exists,
      not_and, not_lt] at hmax
    have hmerr : |birkhoffAverage ℝ T (f - g) m ω| ≤ ε / 3 :=
      hmax m hm1
    have hnerr : |birkhoffAverage ℝ T (f - g) n ω| ≤ ε / 3 :=
      hmax n hn1
    have hmfg : birkhoffAverage ℝ T (f - g) m ω =
        birkhoffAverage ℝ T f m ω - birkhoffAverage ℝ T g m ω := by
      exact congrFun (congrFun (birkhoffAverage_sub (R := ℝ)) m) ω
    have hnfg : birkhoffAverage ℝ T (f - g) n ω =
        birkhoffAverage ℝ T f n ω - birkhoffAverage ℝ T g n ω := by
      exact congrFun (congrFun (birkhoffAverage_sub (R := ℝ)) n) ω
    have htri :
        |birkhoffAverage ℝ T f m ω - birkhoffAverage ℝ T f n ω| ≤
          |birkhoffAverage ℝ T f m ω - birkhoffAverage ℝ T g m ω| +
          |birkhoffAverage ℝ T g m ω - birkhoffAverage ℝ T g n ω| +
          |birkhoffAverage ℝ T g n ω - birkhoffAverage ℝ T f n ω| := by
      calc
        |birkhoffAverage ℝ T f m ω - birkhoffAverage ℝ T f n ω| =
            dist (birkhoffAverage ℝ T f m ω)
              (birkhoffAverage ℝ T f n ω) := by rw [Real.dist_eq]
        _ ≤ dist (birkhoffAverage ℝ T f m ω)
              (birkhoffAverage ℝ T g m ω) +
            dist (birkhoffAverage ℝ T g m ω)
              (birkhoffAverage ℝ T f n ω) := dist_triangle _ _ _
        _ ≤ dist (birkhoffAverage ℝ T f m ω)
              (birkhoffAverage ℝ T g m ω) +
            (dist (birkhoffAverage ℝ T g m ω)
                (birkhoffAverage ℝ T g n ω) +
              dist (birkhoffAverage ℝ T g n ω)
                (birkhoffAverage ℝ T f n ω)) := by
              gcongr
              exact dist_triangle _ _ _
        _ = _ := by rw [Real.dist_eq, Real.dist_eq, Real.dist_eq, add_assoc]
    have hnerr' : |birkhoffAverage ℝ T g n ω -
        birkhoffAverage ℝ T f n ω| ≤ ε / 3 := by
      rw [abs_sub_comm]
      simpa only [hnfg] using hnerr
    have hmerr' : |birkhoffAverage ℝ T f m ω -
        birkhoffAverage ℝ T g m ω| ≤ ε / 3 := by
      simpa only [hmfg] using hmerr
    have : |birkhoffAverage ℝ T f m ω -
        birkhoffAverage ℝ T f n ω| < ε :=
      lt_of_le_of_lt htri (by linarith)
    exact (not_lt_of_ge hmn) this
  · exact Set.mem_union_right _ hgood

/-- Quantitative maximal-closure bound at one positive Cauchy scale. -/
theorem measureReal_birkhoffCauchyExceptionalSet_le
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ)
    (hfg : Integrable (f - g) μ)
    (hgood : ∀ᵐ ω ∂μ, ω ∈ birkhoffConvergenceSet T g)
    {ε : ℝ} (hε : 0 < ε) :
    μ.real (birkhoffCauchyExceptionalSet T f ε) ≤
      (∫ x, |f x - g x| ∂μ) / (ε / 3) := by
  let M := birkhoffAverageAbsoluteExceedanceSet T (f - g) (ε / 3)
  let G := birkhoffConvergenceSet T g
  have hGcompl : μ.real Gᶜ = 0 := by
    rw [measureReal_eq_zero_iff]
    exact mem_ae_iff.mp hgood
  calc
    μ.real (birkhoffCauchyExceptionalSet T f ε) ≤ μ.real (M ∪ Gᶜ) :=
      measureReal_mono
        (birkhoffCauchyExceptionalSet_subset_exceedance_union_compl hε)
    _ ≤ μ.real M + μ.real Gᶜ := measureReal_union_le _ _
    _ = μ.real M := by rw [hGcompl, add_zero]
    _ ≤ (∫ x, |f x - g x| ∂μ) / (ε / 3) := by
      exact measureReal_birkhoffAverageAbsoluteExceedanceSet_le hT hfg
        (by positivity)

/-- Arbitrarily close almost-everywhere pointwise-good approximants force the
fixed positive Cauchy exceptional scale to have measure zero. -/
theorem measure_birkhoffCauchyExceptionalSet_eq_zero_of_dense_good
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ)
    (happrox : ∀ δ > 0, ∃ g : Ω → ℝ,
      Integrable (f - g) μ ∧
        (∫ x, |f x - g x| ∂μ) < δ ∧
          ∀ᵐ ω ∂μ, ω ∈ birkhoffConvergenceSet T g)
    {ε : ℝ} (hε : 0 < ε) :
    μ (birkhoffCauchyExceptionalSet T f ε) = 0 := by
  rw [← measureReal_eq_zero_iff]
  apply le_antisymm
  · apply le_of_forall_pos_le_add
    intro η hη
    obtain ⟨g, hfg, hdist, hgood⟩ :=
      happrox (η * (ε / 3)) (mul_pos hη (by positivity))
    have hbound := measureReal_birkhoffCauchyExceptionalSet_le
      (f := f) hT hfg hgood hε
    calc
      μ.real (birkhoffCauchyExceptionalSet T f ε) ≤
          (∫ x, |f x - g x| ∂μ) / (ε / 3) := hbound
      _ ≤ (η * (ε / 3)) / (ε / 3) :=
        (div_lt_div_of_pos_right hdist (by positivity)).le
      _ = η := by field_simp
      _ = 0 + η := by ring
  · exact measureReal_nonneg

omit [MeasurableSpace Ω] in
/-- Avoiding every reciprocal natural Cauchy scale makes the real Birkhoff
average sequence Cauchy.  The thresholds `1 / (k + 1)` are a countable family
cofinal at zero. -/
theorem cauchySeq_birkhoffAverage_of_not_mem_exceptional
    (ω : Ω)
    (hω : ∀ k : ℕ, ω ∉ birkhoffCauchyExceptionalSet T f
      (1 / ((k : ℝ) + 1))) :
    CauchySeq (fun n ↦ birkhoffAverage ℝ T f n ω) := by
  apply Metric.cauchySeq_iff.mpr
  intro ε hε
  obtain ⟨k, hkε⟩ := exists_nat_one_div_lt hε
  have hk := hω k
  change ¬ (∀ N : ℕ, ∃ m ≥ N, ∃ n ≥ N,
    1 / ((k : ℝ) + 1) ≤
      |birkhoffAverage ℝ T f m ω - birkhoffAverage ℝ T f n ω|) at hk
  push Not at hk
  obtain ⟨N, hN⟩ := hk
  refine ⟨N, fun m hm n hn ↦ ?_⟩
  rw [Real.dist_eq]
  exact (hN m hm n hn).trans hkε

/-- Abstract Banach-principle-style maximal closure: arbitrarily close
integrable-error approximants with almost-everywhere convergent Birkhoff
averages force full-sequence almost-everywhere convergence for `f`.
Integrability of `f` itself is not logically needed at this abstract layer. -/
theorem ae_mem_birkhoffConvergenceSet_of_dense_good
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ)
    (happrox : ∀ δ > 0, ∃ g : Ω → ℝ,
      Integrable (f - g) μ ∧
        (∫ x, |f x - g x| ∂μ) < δ ∧
          ∀ᵐ ω ∂μ, ω ∈ birkhoffConvergenceSet T g) :
    ∀ᵐ ω ∂μ, ω ∈ birkhoffConvergenceSet T f := by
  have hscale : ∀ k : ℕ,
      ∀ᵐ ω ∂μ, ω ∉ birkhoffCauchyExceptionalSet T f
        (1 / ((k : ℝ) + 1)) := by
    intro k
    rw [ae_iff]
    simpa only [Classical.not_not, Set.setOf_mem_eq] using
      measure_birkhoffCauchyExceptionalSet_eq_zero_of_dense_good
        hT happrox (by positivity : 0 < 1 / ((k : ℝ) + 1))
  have hall : ∀ᵐ ω ∂μ, ∀ k : ℕ,
      ω ∉ birkhoffCauchyExceptionalSet T f
        (1 / ((k : ℝ) + 1)) := ae_all_iff.mpr hscale
  filter_upwards [hall] with ω hω
  obtain ⟨c, hc⟩ := cauchySeq_tendsto_of_complete
    (cauchySeq_birkhoffAverage_of_not_mem_exceptional ω hω)
  exact mem_birkhoffConvergenceSet_iff.mpr ⟨c, hc⟩

/-- The finite-measure inclusion from real `L²` to real `L¹`, before
continuity is bundled.  It keeps the same almost-everywhere equivalence class. -/
def l2ToL1Linear [IsFiniteMeasure μ] :
    Lp ℝ 2 μ →ₗ[ℝ] Lp ℝ 1 μ where
  toFun h := ⟨h.1, Lp.antitone (E := ℝ) (μ := μ) (by norm_num) h.2⟩
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

/-- The linear finite-measure `L²` to `L¹` inclusion has the same chosen
representative almost everywhere. -/
theorem l2ToL1Linear_apply_ae [IsFiniteMeasure μ] (h : Lp ℝ 2 μ) :
    l2ToL1Linear h =ᵐ[μ] h := by
  exact EventuallyEq.rfl

/-- Hölder's finite-measure bound for the linear `L²` to `L¹` inclusion. -/
theorem norm_l2ToL1Linear_apply_le [IsFiniteMeasure μ] (h : Lp ℝ 2 μ) :
    ‖l2ToL1Linear h‖ ≤
      (μ Set.univ).toReal ^ (1 / 2 : ℝ) * ‖h‖ := by
  have hbound := eLpNorm_le_eLpNorm_mul_rpow_measure_univ
    (f := fun x ↦ h x) (p := (1 : ℝ≥0∞)) (q := (2 : ℝ≥0∞))
    (by norm_num) (Lp.aestronglyMeasurable h)
  have hexp :
      1 / (1 : ℝ≥0∞).toReal - 1 / (2 : ℝ≥0∞).toReal =
        (1 / 2 : ℝ) := by
    norm_num
  rw [hexp] at hbound
  have hfinite : eLpNorm (fun x ↦ h x) (2 : ℝ≥0∞) μ *
      μ Set.univ ^ (1 / 2 : ℝ) ≠ ∞ := by
    exact ENNReal.mul_ne_top (Lp.eLpNorm_ne_top h)
      (ENNReal.rpow_ne_top_of_nonneg (by positivity)
        (measure_ne_top μ Set.univ))
  have hreal := ENNReal.toReal_mono hfinite hbound
  simpa [l2ToL1Linear, Lp.norm_def, ENNReal.toReal_mul,
    ← ENNReal.toReal_rpow, mul_comm] using hreal

/-- The continuous finite-measure inclusion from real `L²` to real `L¹`. -/
def l2ToL1 [IsFiniteMeasure μ] :
    Lp ℝ 2 μ →L[ℝ] Lp ℝ 1 μ :=
  LinearMap.mkContinuous l2ToL1Linear
    ((μ Set.univ).toReal ^ (1 / 2 : ℝ))
    norm_l2ToL1Linear_apply_le

/-- The continuous `L²` to `L¹` inclusion retains the same representative
almost everywhere. -/
theorem l2ToL1_apply_ae [IsFiniteMeasure μ] (h : Lp ℝ 2 μ) :
    l2ToL1 h =ᵐ[μ] h := by
  exact EventuallyEq.rfl

/-- The operator norm of finite-measure `L²` inclusion into `L¹` is at most
the square root of the total mass. -/
theorem norm_l2ToL1_le [IsFiniteMeasure μ] :
    ‖(l2ToL1 (μ := μ))‖ ≤ (μ Set.univ).toReal ^ (1 / 2 : ℝ) := by
  apply LinearMap.mkContinuous_norm_le
  positivity

/-- The finite-measure `L²` to `L¹` inclusion is injective on equivalence
classes. -/
theorem l2ToL1_injective [IsFiniteMeasure μ] :
    Function.Injective (l2ToL1 (μ := μ)) := by
  intro h k hhk
  apply Lp.ext
  have himage : (fun x ↦ l2ToL1 h x) =ᵐ[μ]
      (fun x ↦ l2ToL1 k x) := by
    rw [hhk]
  exact (l2ToL1_apply_ae h).symm.trans <|
    himage.trans (l2ToL1_apply_ae k)

/-- Square-integrable real functions have dense range in real `L¹` on a
finite-measure space. -/
theorem denseRange_l2ToL1 [IsFiniteMeasure μ] :
    DenseRange (l2ToL1 (μ := μ)) := by
  apply (Lp.simpleFunc.dense (E := ℝ) (p := (1 : ℝ≥0∞))
    (μ := μ) (by simp)).mono
  intro h hh
  let hs : Lp.simpleFunc ℝ 1 μ := ⟨h, hh⟩
  let v : MeasureTheory.SimpleFunc Ω ℝ := Lp.simpleFunc.toSimpleFunc hs
  have hv2 : MemLp v 2 μ := v.memLp_of_isFiniteMeasure 2 μ
  let k : Lp ℝ 2 μ := hv2.toLp v
  refine ⟨k, ?_⟩
  apply Lp.ext
  exact (l2ToL1_apply_ae k).trans <|
    (MemLp.coeFn_toLp hv2).trans <| by
      simpa [hs, v] using Lp.simpleFunc.toSimpleFunc_eq_toFun hs

/-- A dense real `L²` set remains dense after inclusion into real `L¹`. -/
theorem dense_image_l2ToL1_of_dense [IsFiniteMeasure μ]
    {s : Set (Lp ℝ 2 μ)} (hs : Dense s) :
    Dense (l2ToL1 '' s) :=
  denseRange_l2ToL1.dense_image l2ToL1.continuous hs

/-- The included fixed-plus-simple-coboundary core from RMT-25, now regarded
as a subset of real `L¹`. -/
def fixedPlusSimpleCoboundarySetL1 [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) : Set (Lp ℝ 1 μ) :=
  l2ToL1 '' fixedPlusSimpleCoboundarySetL2 hT

/-- The included RMT-25 pointwise-good core is dense in real `L¹` on every
finite measure-preserving system. -/
theorem dense_fixedPlusSimpleCoboundarySetL1 [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) :
    Dense (fixedPlusSimpleCoboundarySetL1 hT) :=
  dense_image_l2ToL1_of_dense (dense_fixedPlusSimpleCoboundarySetL2 hT)

/-- Membership in the included `L¹` core retains the RMT-25 representative's
almost-everywhere pointwise-good property. -/
theorem ae_mem_birkhoffConvergenceSet_of_mem_fixedPlusSimpleCoboundarySetL1
    [IsFiniteMeasure μ] (hT : MeasurePreserving T μ μ)
    {h : Lp ℝ 1 μ} (hh : h ∈ fixedPlusSimpleCoboundarySetL1 hT) :
    ∀ᵐ ω ∂μ, ω ∈ birkhoffConvergenceSet T (fun ω ↦ h ω) := by
  rcases hh with ⟨k, hk, rfl⟩
  have hgood :=
    ae_mem_birkhoffConvergenceSet_of_mem_fixedPlusSimpleCoboundarySetL2 hT hk
  have hevents := birkhoffConvergenceSet_ae_eq_of_ae_eq
    hT.quasiMeasurePreserving (l2ToL1_apply_ae k)
  filter_upwards [hevents, hgood] with ω hevent hmem
  change birkhoffConvergenceSet T (l2ToL1 k) ω
  rw [hevent]
  exact hmem

/-- **Finite-measure pointwise Birkhoff theorem, convergence form.**  Every
real integrable observable on a finite measure-preserving system has
full-sequence almost-everywhere convergent Birkhoff averages.  The theorem
asserts membership in `birkhoffConvergenceSet`; it does not identify the
limit. -/
theorem ae_mem_birkhoffConvergenceSet_of_integrable
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ) :
    ∀ᵐ ω ∂μ, ω ∈ birkhoffConvergenceSet T f := by
  apply ae_mem_birkhoffConvergenceSet_of_dense_good hT
  intro δ hδ
  let f₁ : Lp ℝ 1 μ := hf.toL1 f
  obtain ⟨g₁, hg₁, hfg₁⟩ :=
    (dense_fixedPlusSimpleCoboundarySetL1 hT).exists_dist_lt f₁ hδ
  refine ⟨fun x ↦ g₁ x, hf.sub (L1.integrable_coeFn g₁), ?_,
    ae_mem_birkhoffConvergenceSet_of_mem_fixedPlusSimpleCoboundarySetL1
      hT hg₁⟩
  calc
    (∫ x, |f x - g₁ x| ∂μ) =
        ∫ x, dist (f₁ x) (g₁ x) ∂μ := by
      apply integral_congr_ae
      filter_upwards [hf.coeFn_toL1] with x hx
      rw [Real.dist_eq, hx]
    _ = dist f₁ g₁ := (L1.dist_eq_integral_dist f₁ g₁).symm
    _ < δ := hfg₁

section BoundaryProbes

omit [MeasurableSpace Ω] in
/-- At threshold zero every point is exceptional, showing why the quantitative
closure theorems require a strictly positive Cauchy scale. -/
example : birkhoffCauchyExceptionalSet T f 0 = Set.univ := by
  ext ω
  simp only [mem_birkhoffCauchyExceptionalSet_iff, Set.mem_univ, iff_true]
  intro N
  exact ⟨N, le_rfl, N, le_rfl, by simp⟩

/-- The zero-measure boundary gives zero, rather than unit, inclusion norm. -/
example : ‖(l2ToL1 (Ω := Ω) (μ := (0 : Measure Ω)))‖ = 0 := by
  apply le_antisymm
  · simpa using norm_l2ToL1_le (Ω := Ω) (μ := (0 : Measure Ω))
  · exact norm_nonneg _

/-- On a probability space the general finite-mass norm coefficient reduces
to one, although probability normalization is absent from the final theorem. -/
example [IsProbabilityMeasure μ] : ‖(l2ToL1 (μ := μ))‖ ≤ 1 := by
  simpa using norm_l2ToL1_le (Ω := Ω) (μ := μ)

/-- Threshold one exercises the strictly positive gate in the absolute weak
maximal estimate without leaving a residual division factor. -/
example [IsFiniteMeasure μ] (hT : MeasurePreserving T μ μ)
    (hf : Integrable f μ) :
    μ.real (birkhoffAverageAbsoluteExceedanceSet T f 1) ≤
      ∫ x, |f x| ∂μ := by
  simpa using measureReal_birkhoffAverageAbsoluteExceedanceSet_le
    hT hf (a := 1) (by norm_num)

/-- The final pointwise theorem includes the zero-measure boundary with no
nonzero-mass premise; its almost-everywhere conclusion is then vacuous. -/
example (hf : Integrable f (0 : Measure Ω)) :
    ∀ᵐ ω ∂(0 : Measure Ω), ω ∈ birkhoffConvergenceSet id f := by
  exact ae_mem_birkhoffConvergenceSet_of_integrable
    (MeasurePreserving.id (0 : Measure Ω)) hf

/-- Identity dynamics satisfy the final theorem for every real integrable
observable without an ergodicity premise. -/
example [IsFiniteMeasure μ] (hf : Integrable f μ) :
    ∀ᵐ ω ∂μ, ω ∈ birkhoffConvergenceSet id f := by
  exact ae_mem_birkhoffConvergenceSet_of_integrable
    (MeasurePreserving.id μ) hf

/-- A noninjective constant map preserving a Dirac measure exercises the final
result without injectivity, surjectivity, or invertibility. -/
example :
    ∃ (S : Bool → Bool)
      (_hS : MeasurePreserving S (Measure.dirac false) (Measure.dirac false)),
      ¬ Function.Injective S ∧ ¬ Function.Surjective S ∧
        ∀ h : Bool → ℝ, Integrable h (Measure.dirac false) →
          ∀ᵐ ω ∂Measure.dirac false,
            ω ∈ birkhoffConvergenceSet S h := by
  let S : Bool → Bool := fun _ ↦ false
  have hSnotinj : ¬ Function.Injective S := by
    intro hSinj
    have : (false : Bool) = true := hSinj rfl
    simp at this
  have hSnotsurj : ¬ Function.Surjective S := by
    intro hSsurj
    obtain ⟨b, hb⟩ := hSsurj true
    simp [S] at hb
  have hSpres :
      MeasurePreserving S (Measure.dirac false) (Measure.dirac false) := by
    refine ⟨measurable_const, ?_⟩
    rw [Measure.map_dirac' measurable_const]
  refine ⟨S, hSpres, hSnotinj, hSnotsurj, ?_⟩
  intro h hh
  exact ae_mem_birkhoffConvergenceSet_of_integrable hSpres hh

end BoundaryProbes

#print axioms measureReal_birkhoffAverageAbsoluteExceedanceSet_le
#print axioms ae_mem_birkhoffConvergenceSet_of_dense_good
#print axioms denseRange_l2ToL1
#print axioms dense_fixedPlusSimpleCoboundarySetL1
#print axioms ae_mem_birkhoffConvergenceSet_of_integrable

end NonlinearDynamics.Random.RandomCocycles
