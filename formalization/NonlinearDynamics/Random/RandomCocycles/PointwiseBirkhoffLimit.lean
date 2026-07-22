import NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoff
import Mathlib.MeasureTheory.Function.ConditionalExpectation.Real
import Mathlib.MeasureTheory.MeasurableSpace.Invariants
import Mathlib.Probability.IdentDistrib

/-!
# Identifying the finite-measure Birkhoff limit

`PointwiseBirkhoff` proves that the real Birkhoff averages of an integrable
observable converge almost everywhere on a finite measure space.  This module
identifies that limit: it is the conditional expectation of the observable
onto the exact invariant sigma algebra `MeasurableSpace.invariants T`.

The proof deliberately keeps the noninvertible finite-measure theorem in its
natural form.  It does not assume probability normalization, ergodicity,
injectivity, surjectivity, or invertibility.

The main construction is a single total representative `birkhoffLimit`, made
with `Filter.limUnder`.  The one-prefix shift identities from
`BirkhoffConvergence` show that this representative is literally invariant,
even on the fallback branch where the averages do not converge.  For a
strongly measurable observable it is therefore measurable for the exact
invariant sigma algebra.

Pointwise convergence alone does not identify integrals.  We prove that the
orbit translates have identical distributions, hence are uniformly
integrable; Cesaro averaging preserves uniform integrability.  The finite-
measure Vitali theorem upgrades the almost-everywhere convergence to `L¹`.
On every exactly invariant measurable set, measure preservation and
`MeasurePreserving.restrict_preimage` show that each positive-time average has
the same integral as the original observable.  Passing to the `L¹` limit and
using uniqueness of conditional expectation completes the identification.

For a merely integrable observable, the final theorem applies this argument to
one strongly measurable representative and transports both the averages and
conditional expectation across almost-everywhere equality.
-/

open MeasureTheory ProbabilityTheory Set Filter Function
open scoped ENNReal Topology BigOperators

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ

variable {Ω : Type uΩ} [MeasurableSpace Ω]
  {T : Ω → Ω} {f g : Ω → ℝ} {μ : Measure Ω}

omit [MeasurableSpace Ω] in
/-- A single total representative of the pointwise Birkhoff limit.  At a
point where the averages converge, `limUnder` chooses that unique limit; at a
divergent point it uses the canonical nonempty-type fallback. -/
def birkhoffLimit (T : Ω → Ω) (f : Ω → ℝ) (ω : Ω) : ℝ :=
  limUnder atTop (fun n ↦ birkhoffAverage ℝ T f n ω)

omit [MeasurableSpace Ω] in
/-- Whenever the Birkhoff averages have a finite limit, they converge to the
chosen total representative `birkhoffLimit`. -/
theorem tendsto_birkhoffAverage_birkhoffLimit_of_exists
    {ω : Ω}
    (hω : ∃ c : ℝ,
      Tendsto (fun n ↦ birkhoffAverage ℝ T f n ω) atTop (nhds c)) :
    Tendsto (fun n ↦ birkhoffAverage ℝ T f n ω) atTop
      (nhds (birkhoffLimit T f ω)) := by
  exact tendsto_nhds_limUnder hω

omit [MeasurableSpace Ω] in
/-- Membership in the convergence event identifies the pointwise limit with
`birkhoffLimit`. -/
theorem tendsto_birkhoffAverage_birkhoffLimit_of_mem
    {ω : Ω} (hω : ω ∈ birkhoffConvergenceSet T f) :
    Tendsto (fun n ↦ birkhoffAverage ℝ T f n ω) atTop
      (nhds (birkhoffLimit T f ω)) :=
  tendsto_birkhoffAverage_birkhoffLimit_of_exists hω

omit [MeasurableSpace Ω] in
/-- The chosen total Birkhoff limit is pointwise invariant under one
application of the base map.  The divergent fallback branch is invariant too,
because convergence after applying `T` is equivalent to convergence before
applying it. -/
theorem birkhoffLimit_apply_base (T : Ω → Ω) (f : Ω → ℝ) (ω : Ω) :
    birkhoffLimit T f (T ω) = birkhoffLimit T f ω := by
  unfold birkhoffLimit
  by_cases hconv : ∃ c : ℝ,
      Tendsto (fun n ↦ birkhoffAverage ℝ T f n ω) atTop (nhds c)
  · obtain ⟨c, hc⟩ := hconv
    rw [hc.limUnder_eq]
    exact (tendsto_birkhoffAverage_apply_base hc).limUnder_eq
  · have hconvT : ¬ ∃ c : ℝ,
        Tendsto (fun n ↦ birkhoffAverage ℝ T f n (T ω)) atTop (nhds c) := by
      intro h
      obtain ⟨c, hc⟩ := h
      exact hconv ⟨c, tendsto_birkhoffAverage_of_apply_base hc⟩
    rw [limUnder_of_not_tendsto hconvT, limUnder_of_not_tendsto hconv]

/-- A strongly measurable observable under measurable dynamics has a strongly
measurable chosen Birkhoff limit on the ambient sigma algebra. -/
theorem stronglyMeasurable_birkhoffLimit
    (hT : Measurable T) (hf : StronglyMeasurable f) :
    StronglyMeasurable (birkhoffLimit T f) := by
  unfold birkhoffLimit
  apply StronglyMeasurable.limUnder
  intro n
  exact (measurable_birkhoffAverage hT hf.measurable n).stronglyMeasurable

/-- A strongly measurable observable has a chosen Birkhoff limit measurable
for the exact invariant sigma algebra.  This packages ambient measurability and
literal pointwise invariance into Mathlib's invariant-space interface. -/
theorem measurable_birkhoffLimit_invariants
    (hT : Measurable T) (hf : StronglyMeasurable f) :
    Measurable[MeasurableSpace.invariants T] (birkhoffLimit T f) := by
  rw [MeasurableSpace.measurable_invariants_dom]
  refine ⟨(stronglyMeasurable_birkhoffLimit hT hf).measurable, ?_⟩
  intro s hs
  have hinv : birkhoffLimit T f ∘ T = birkhoffLimit T f := by
    funext ω
    exact birkhoffLimit_apply_base T f ω
  rw [hinv]

/-- Finite-measure pointwise convergence lands almost everywhere at the
single chosen representative `birkhoffLimit`. -/
theorem ae_tendsto_birkhoffAverage_birkhoffLimit
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ) :
    ∀ᵐ ω ∂μ, Tendsto (fun n ↦ birkhoffAverage ℝ T f n ω) atTop
      (nhds (birkhoffLimit T f ω)) := by
  filter_upwards [ae_mem_birkhoffConvergenceSet_of_integrable hT hf] with ω hω
  exact tendsto_birkhoffAverage_birkhoffLimit_of_mem hω

/-- Almost-everywhere equal observables have almost-everywhere equal chosen
Birkhoff-limit representatives under quasi-measure-preserving dynamics.  The
proof transports equality through every finite orbit average before applying
`limUnder`. -/
theorem birkhoffLimit_ae_eq_of_ae_eq
    (hT : Measure.QuasiMeasurePreserving T μ μ) (hfg : f =ᵐ[μ] g) :
    birkhoffLimit T f =ᵐ[μ] birkhoffLimit T g := by
  have havg : ∀ᵐ ω ∂μ, ∀ n : ℕ,
      birkhoffAverage ℝ T f n ω = birkhoffAverage ℝ T g n ω := by
    rw [ae_all_iff]
    intro n
    exact hT.birkhoffAverage_ae_eq_of_ae_eq ℝ hfg n
  filter_upwards [havg] with ω hω
  unfold birkhoffLimit
  congr 1
  funext n
  exact hω n

/-- Every measure-preserving orbit translate of an almost-everywhere
measurable observable has the same distribution as the observable itself. -/
theorem identDistrib_orbit_iterate
    (hT : MeasurePreserving T μ μ) (hf : AEMeasurable f μ) (i : ℕ) :
    IdentDistrib (fun ω ↦ f ((T^[i]) ω)) f μ μ := by
  have hTi := hT.iterate i
  have hfmap : AEMeasurable f (Measure.map (T^[i]) μ) := by
    rw [hTi.map_eq]
    exact hf
  refine
    { aemeasurable_fst :=
        hf.comp_quasiMeasurePreserving hTi.quasiMeasurePreserving
      aemeasurable_snd := hf
      map_eq := ?_ }
  change Measure.map (f ∘ T^[i]) μ = Measure.map f μ
  rw [← hfmap.map_map_of_aemeasurable hTi.measurable.aemeasurable,
    hTi.map_eq]

/-- The orbit translates of an integrable observable are uniformly integrable
in `L¹`, because they are identically distributed. -/
theorem uniformIntegrable_orbit_iterate
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ) :
    UniformIntegrable (fun i ω ↦ f ((T^[i]) ω)) 1 μ := by
  apply ProbabilityTheory.MemLp.uniformIntegrable_of_identDistrib
    (f := fun i ω ↦ f ((T^[i]) ω)) (j := 0) (p := 1)
    le_rfl ENNReal.one_ne_top
    (by simpa only [Function.iterate_zero, id_eq] using
      (memLp_one_iff_integrable.mpr hf))
  intro i
  simpa only [Function.iterate_zero, id_eq] using
    (identDistrib_orbit_iterate hT hf.aemeasurable i)

/-- Cesaro averaging transports orbit uniform integrability to the complete
sequence of Birkhoff averages, including the totalized horizon-zero term. -/
theorem uniformIntegrable_birkhoffAverage
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ) :
    UniformIntegrable (fun n ↦ birkhoffAverage ℝ T f n) 1 μ := by
  refine (uniformIntegrable_average (p := 1) le_rfl
    (uniformIntegrable_orbit_iterate hT hf)).ae_eq ?_
  intro n
  filter_upwards with ω
  simp only [birkhoffAverage, birkhoffSum, Pi.smul_apply, Finset.sum_apply]

/-- Uniform integrability and pointwise Birkhoff convergence make the chosen
limit integrable. -/
theorem integrable_birkhoffLimit
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ) :
    Integrable (birkhoffLimit T f) μ := by
  exact (uniformIntegrable_birkhoffAverage hT hf).integrable_of_ae_tendsto
    (ae_tendsto_birkhoffAverage_birkhoffLimit hT hf)

/-- The complete Birkhoff-average sequence converges to the chosen limit in
`L¹`.  This is the Vitali step that permits passage of invariant-set
integrals. -/
theorem tendsto_L1_birkhoffAverage_birkhoffLimit
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ) :
    Tendsto
      (fun n ↦ eLpNorm
        (birkhoffAverage ℝ T f n - birkhoffLimit T f) 1 μ)
      atTop (nhds 0) := by
  apply tendsto_Lp_finite_of_tendsto_ae le_rfl ENNReal.one_ne_top
  · intro n
    exact (integrable_birkhoffAverage hT hf n).aestronglyMeasurable
  · exact memLp_one_iff_integrable.mpr (integrable_birkhoffLimit hT hf)
  · exact (uniformIntegrable_birkhoffAverage hT hf).unifIntegrable
  · exact ae_tendsto_birkhoffAverage_birkhoffLimit hT hf

/-- Integrating an orbit translate over an exactly invariant measurable set
does not change the integral.  `restrict_preimage` keeps this valid for maps
that need not be injective or surjective. -/
theorem setIntegral_orbit_iterate_eq
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ)
    {s : Set Ω} (hs : MeasurableSet[MeasurableSpace.invariants T] s)
    (i : ℕ) :
    ∫ ω in s, f ((T^[i]) ω) ∂μ = ∫ ω in s, f ω ∂μ := by
  have hs0 : MeasurableSet s :=
    (MeasurableSpace.measurableSet_invariants.mp hs).1
  have hsIter : MeasurableSet[MeasurableSpace.invariants (T^[i])] s :=
    MeasurableSpace.le_invariants_iterate T i s hs
  have hinv : (T^[i]) ⁻¹' s = s :=
    (MeasurableSpace.measurableSet_invariants.mp hsIter).2
  have hpres := (hT.iterate i).restrict_preimage hs0
  rw [hinv] at hpres
  change ∫ ω, f ((T^[i]) ω) ∂(μ.restrict s) =
    ∫ ω, f ω ∂(μ.restrict s)
  have hi := integral_map (μ := μ.restrict s)
    hpres.measurable.aemeasurable (f := f)
    (by
      rw [hpres.map_eq]
      exact hf.aestronglyMeasurable.restrict)
  rw [hpres.map_eq] at hi
  exact hi.symm

/-- Every positive-time Birkhoff average has the same integral as the
original observable on an exactly invariant measurable set. -/
theorem setIntegral_birkhoffAverage_eq
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ)
    {s : Set Ω} (hs : MeasurableSet[MeasurableSpace.invariants T] s)
    {n : ℕ} (hn : n ≠ 0) :
    ∫ ω in s, birkhoffAverage ℝ T f n ω ∂μ =
      ∫ ω in s, f ω ∂μ := by
  unfold birkhoffAverage birkhoffSum
  rw [integral_smul, integral_finsetSum]
  · simp_rw [setIntegral_orbit_iterate_eq hT hf hs]
    simp [hn]
  · intro i _hi
    exact ((hT.iterate i).integrable_comp_of_integrable hf).integrableOn

/-- `L¹` convergence passes the invariant-set integral identity from all
positive-time averages to the chosen pointwise limit. -/
theorem setIntegral_birkhoffLimit_eq
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ)
    {s : Set Ω} (hs : MeasurableSet[MeasurableSpace.invariants T] s) :
    ∫ ω in s, birkhoffLimit T f ω ∂μ = ∫ ω in s, f ω ∂μ := by
  have hL1 := tendsto_L1_birkhoffAverage_birkhoffLimit hT hf
  have hset := tendsto_setIntegral_of_L1' (birkhoffLimit T f)
    (integrable_birkhoffLimit hT hf).aestronglyMeasurable
    (Eventually.of_forall fun n ↦ integrable_birkhoffAverage hT hf n)
    hL1 s
  have heq :
      (fun n ↦ ∫ ω in s, birkhoffAverage ℝ T f n ω ∂μ) =ᶠ[atTop]
        (fun _n ↦ ∫ ω in s, f ω ∂μ) := by
    filter_upwards [eventually_ge_atTop 1] with n hn
    exact setIntegral_birkhoffAverage_eq hT hf hs (Nat.ne_of_gt hn)
  have hconst : Tendsto
      (fun n ↦ ∫ ω in s, birkhoffAverage ℝ T f n ω ∂μ) atTop
      (nhds (∫ ω in s, f ω ∂μ)) :=
    tendsto_const_nhds.congr' heq.symm
  exact tendsto_nhds_unique hset hconst

private theorem birkhoffLimit_ae_eq_condExp_of_stronglyMeasurable
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ)
    (hfm : StronglyMeasurable f) :
    birkhoffLimit T f =ᵐ[μ] μ[f | MeasurableSpace.invariants T] := by
  apply ae_eq_condExp_of_forall_setIntegral_eq
    (MeasurableSpace.invariants_le T) hf
  · intro s _hs _hμs
    exact (integrable_birkhoffLimit hT hf).integrableOn
  · intro s hs _hμs
    exact setIntegral_birkhoffLimit_eq hT hf hs
  · exact (measurable_birkhoffLimit_invariants hT.measurable hfm).stronglyMeasurable.aestronglyMeasurable

/-- The chosen Birkhoff-limit representative of every integrable observable
is almost everywhere its conditional expectation onto the exact invariant
sigma algebra.  A strongly measurable representative is used only inside the
proof and both limits and conditional expectations are transported back
across almost-everywhere equality. -/
theorem birkhoffLimit_ae_eq_condExp
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ) :
    birkhoffLimit T f =ᵐ[μ] μ[f | MeasurableSpace.invariants T] := by
  let f' := hf.aestronglyMeasurable.mk f
  have hf'm : StronglyMeasurable f' :=
    hf.aestronglyMeasurable.stronglyMeasurable_mk
  have hff' : f =ᵐ[μ] f' := hf.aestronglyMeasurable.ae_eq_mk
  have hf'i : Integrable f' μ := hf.congr hff'
  exact (birkhoffLimit_ae_eq_of_ae_eq hT.quasiMeasurePreserving hff').trans
    ((birkhoffLimit_ae_eq_condExp_of_stronglyMeasurable hT hf'i hf'm).trans
      (condExp_congr_ae hff'.symm))

/-- **Finite-measure pointwise Birkhoff theorem with limit identification.**

For every real integrable observable and every measure-preserving self-map of
a finite measure space, the complete Birkhoff-average sequence converges
almost everywhere to conditional expectation onto the exact invariant sigma
algebra.  No probability, ergodicity, injectivity, surjectivity, or
invertibility assumption is present. -/
theorem ae_tendsto_birkhoffAverage_condExp
    [IsFiniteMeasure μ]
    (hT : MeasurePreserving T μ μ) (hf : Integrable f μ) :
    ∀ᵐ ω ∂μ,
      Tendsto (fun n ↦ birkhoffAverage ℝ T f n ω) atTop
        (nhds (μ[f | MeasurableSpace.invariants T] ω)) := by
  filter_upwards [ae_tendsto_birkhoffAverage_birkhoffLimit hT hf,
    birkhoffLimit_ae_eq_condExp hT hf] with ω hconv hlimit
  rwa [← hlimit]

section BoundaryProbes

/-- The zero measure is included without a nonzero-mass premise; its
almost-everywhere conclusion is vacuous. -/
example (hf : Integrable f (0 : Measure Ω)) :
    ∀ᵐ ω ∂(0 : Measure Ω),
      Tendsto (fun n ↦ birkhoffAverage ℝ id f n ω) atTop
        (nhds ((0 : Measure Ω)[f | MeasurableSpace.invariants id] ω)) := by
  exact ae_tendsto_birkhoffAverage_condExp
    (MeasurePreserving.id (0 : Measure Ω)) hf

/-- Identity dynamics require no ergodicity assumption. -/
example [IsFiniteMeasure μ] (hf : Integrable f μ) :
    ∀ᵐ ω ∂μ,
      Tendsto (fun n ↦ birkhoffAverage ℝ id f n ω) atTop
        (nhds (μ[f | MeasurableSpace.invariants id] ω)) := by
  exact ae_tendsto_birkhoffAverage_condExp (MeasurePreserving.id μ) hf

/-- The identity map on two positive atoms is not ergodic, yet the general
identified-limit theorem applies.  This prevents accidental collapse of the
invariant sigma algebra to the trivial sigma algebra. -/
example : ¬ Ergodic id (Measure.dirac false + Measure.dirac true) := by
  intro h
  have hzero := h.toPreErgodic.measure_self_or_compl_eq_zero
    (s := ({false} : Set Bool)) (measurableSet_singleton false) (by simp)
  simp [Measure.dirac_apply'] at hzero

/-- The two-atom nonergodic identity system retains its full conditional-
expectation target rather than replacing it by a constant. -/
example (h : Bool → ℝ)
    (hh : Integrable h (Measure.dirac false + Measure.dirac true)) :
    ∀ᵐ ω ∂(Measure.dirac false + Measure.dirac true),
      Tendsto (fun n ↦ birkhoffAverage ℝ id h n ω) atTop
        (nhds ((Measure.dirac false + Measure.dirac true)[
          h | MeasurableSpace.invariants id] ω)) := by
  exact ae_tendsto_birkhoffAverage_condExp
    (MeasurePreserving.id (Measure.dirac false + Measure.dirac true)) hh

/-- A noninjective constant map preserving a Dirac measure exercises the
identified-limit theorem without injectivity, surjectivity, or invertibility. -/
example :
    ∃ (S : Bool → Bool)
      (_hS : MeasurePreserving S (Measure.dirac false) (Measure.dirac false)),
      ¬ Function.Injective S ∧ ¬ Function.Surjective S ∧
        ∀ h : Bool → ℝ, Integrable h (Measure.dirac false) →
          ∀ᵐ ω ∂Measure.dirac false,
            Tendsto (fun n ↦ birkhoffAverage ℝ S h n ω) atTop
              (nhds ((Measure.dirac false)[
                h | MeasurableSpace.invariants S] ω)) := by
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
  exact ae_tendsto_birkhoffAverage_condExp hSpres hh

end BoundaryProbes

#print axioms measurable_birkhoffLimit_invariants
#print axioms uniformIntegrable_birkhoffAverage
#print axioms tendsto_L1_birkhoffAverage_birkhoffLimit
#print axioms birkhoffLimit_ae_eq_condExp
#print axioms ae_tendsto_birkhoffAverage_condExp

end NonlinearDynamics.Random.RandomCocycles
