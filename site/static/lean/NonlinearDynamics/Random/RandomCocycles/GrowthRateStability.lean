import NonlinearDynamics.Random.RandomCocycles.RealLogNormKingman
import Mathlib.MeasureTheory.Integral.DominatedConvergence
import Mathlib.Topology.UniformSpace.UniformConvergence

/-!
# Upper stability of the signed integrated cocycle growth rate

This module fixes a probability-preserving base and varies only the measurable
matrix generator.  A bundled perturbation class records common forward and
inverse norm bounds together with pointwise invertibility.  Uniform convergence
of generators then gives pointwise convergence of every finite cocycle product,
and the common two-sided bounds give a constant dominator for each finite
real-log observable.

The finite-horizon integrals therefore converge by dominated convergence.  The
signed Fekete rate is the infimum of those normalized finite-horizon integrals,
so every strict upper neighborhood of the limiting rate eventually contains
the rates of the perturbed generators.  This is the sequential upper-
semicontinuity conclusion used here as the precise cocycle-level meaning of
stochastic stability.

The base map and probability measure do not vary.  The result supplies no lower
semicontinuity, full continuity, convergence rate, invariant-measure
selection, random-attractor stability, Lyapunov spectrum, Oseledets splitting,
or stability of invariant subspaces.
-/

open Matrix MeasureTheory Set Filter
open scoped Matrix.Norms.Operator Real Topology

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ uι

variable {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
  [Fintype ι] [DecidableEq ι] {μ : Measure Ω}

/-- A measurable matrix generator with common forward and inverse norm bounds.

The constants `M` and `K` are parameters of the carrier so that a convergent
family can share them definitionally.  No topology or dynamics on the sample
space is required. -/
structure UniformlyBoundedInvertibleGenerator (M K : ℝ) where
  toFun : Ω → Matrix ι ι ℂ
  measurable_toFun : Measurable toFun
  isUnit_toFun : ∀ ω, IsUnit (toFun ω)
  norm_le : ∀ ω, ‖toFun ω‖ ≤ M
  norm_inv_le : ∀ ω, ‖(toFun ω)⁻¹‖ ≤ K

namespace UniformlyBoundedInvertibleGenerator

instance {M K : ℝ} :
    CoeFun (UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K)
      (fun _ ↦ Ω → Matrix ι ι ℂ) :=
  ⟨UniformlyBoundedInvertibleGenerator.toFun⟩

/-- A bounded invertible generator over a fixed preserving base produces the
project's one-sided discrete matrix cocycle. -/
def toCocycle {M K : ℝ}
    (G : UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K)
    {T : Ω → Ω} (hT : MeasurePreserving T μ μ) :
    DiscreteMatrixCocycle (ι := ι) μ where
  base := T
  generator := G
  base_preserving := hT
  measurable_generator := G.measurable_toFun

/-- On a finite measure space, uniform forward and inverse bounds imply the
two-sided one-step log-integrability package.

The proof still uses pointwise invertibility separately: Mathlib's total matrix
inverse is zero on singular matrices, so a bound on that total inverse alone
would not exclude singular generators. -/
theorem hasIntegrableGeneratorLogTails [IsFiniteMeasure μ]
    {M K : ℝ}
    (G : UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K)
    {T : Ω → Ω} (hT : MeasurePreserving T μ μ) :
    (G.toCocycle hT).HasIntegrableGeneratorLogTails where
  isPointwiseInvertible := G.isUnit_toFun
  hasIntegrableGeneratorLogPlus := by
    apply Integrable.of_bound
      ((G.toCocycle hT).measurable_logPlusNormObservable 1).aestronglyMeasurable
      (log⁺ M)
    filter_upwards with ω
    rw [Real.norm_eq_abs,
      abs_of_nonneg ((G.toCocycle hT).logPlusNormObservable_nonneg 1 ω),
      (G.toCocycle hT).logPlusNormObservable_one]
    exact Real.posLog_le_posLog (norm_nonneg _) (G.norm_le ω)
  integrable_inverseGeneratorLogPlus := by
    apply Integrable.of_bound
      ((G.toCocycle hT).measurable_inverseGeneratorLogPlusNormObservable
        |>.aestronglyMeasurable)
      (log⁺ K)
    filter_upwards with ω
    change |log⁺ ‖(G ω)⁻¹‖| ≤ log⁺ K
    rw [abs_of_nonneg Real.posLog_nonneg]
    exact Real.posLog_le_posLog (norm_nonneg _) (G.norm_inv_le ω)

/-- The signed integrated Fekete rate attached to a uniformly bounded
invertible generator over the fixed base. -/
def integratedRealLogGrowthRate [IsFiniteMeasure μ]
    {M K : ℝ}
    (G : UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K)
    {T : Ω → Ω} (hT : MeasurePreserving T μ μ) : ℝ :=
  (G.toCocycle hT).integratedRealLogGrowthRate
    (G.hasIntegrableGeneratorLogTails hT)

/-- Uniform convergence of generators gives convergence of every fixed finite
cocycle product at every sample point. -/
theorem tendsto_value_of_tendstoUniformly
    {M K : ℝ}
    {G : ℕ → UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K}
    {G₀ : UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K}
    {T : Ω → Ω} (hT : MeasurePreserving T μ μ)
    (hG : TendstoUniformly (fun n ↦ (G n : Ω → Matrix ι ι ℂ)) G₀ atTop)
    (k : ℕ) (ω : Ω) :
    Tendsto (fun n ↦ (G n).toCocycle hT |>.value k ω) atTop
      (𝓝 (G₀.toCocycle hT |>.value k ω)) := by
  induction k with
  | zero =>
      simp
  | succ k ih =>
      rw [show (fun n ↦ (G n).toCocycle hT |>.value (k + 1) ω) =
          fun n ↦ G n (T^[k] ω) * ((G n).toCocycle hT).value k ω by
        funext n
        exact congrFun (((G n).toCocycle hT).value_succ k) ω]
      rw [show (G₀.toCocycle hT).value (k + 1) ω =
          G₀ (T^[k] ω) * (G₀.toCocycle hT).value k ω by
        exact congrFun ((G₀.toCocycle hT).value_succ k) ω]
      exact (hG.tendsto_at (T^[k] ω)).mul ih

/-- Uniform generator convergence gives pointwise convergence of every fixed
finite-horizon real-log norm observable. -/
theorem tendsto_realLogNormObservable_of_tendstoUniformly
    {M K : ℝ}
    {G : ℕ → UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K}
    {G₀ : UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K}
    {T : Ω → Ω} (hT : MeasurePreserving T μ μ)
    (hG : TendstoUniformly (fun n ↦ (G n : Ω → Matrix ι ι ℂ)) G₀ atTop)
    (k : ℕ) (ω : Ω) :
    Tendsto
      (fun n ↦ ((G n).toCocycle hT).realLogNormObservable k ω)
      atTop
      (𝓝 ((G₀.toCocycle hT).realLogNormObservable k ω)) := by
  cases isEmpty_or_nonempty ι with
  | inl hι =>
      letI := hι
      simp
  | inr hι =>
      letI := hι
      have hvalue := tendsto_value_of_tendstoUniformly hT hG k ω
      have hnorm :
          Tendsto (fun n ↦ ‖((G n).toCocycle hT).value k ω‖) atTop
            (𝓝 ‖(G₀.toCocycle hT).value k ω‖) :=
        continuous_norm.tendsto _ |>.comp hvalue
      have hinvertible : (G₀.toCocycle hT).IsPointwiseInvertible :=
        G₀.isUnit_toFun
      have hne : ‖(G₀.toCocycle hT).value k ω‖ ≠ 0 :=
        norm_ne_zero_iff.mpr (hinvertible.value_isUnit k ω).ne_zero
      exact (Real.continuousAt_log hne).tendsto.comp hnorm

/-- Common one-step forward and inverse bounds give a constant absolute bound
for every finite-horizon real-log observable in the class. -/
theorem abs_realLogNormObservable_le
    [IsFiniteMeasure μ]
    {M K : ℝ}
    (G : UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K)
    {T : Ω → Ω} (hT : MeasurePreserving T μ μ)
    (k : ℕ) (ω : Ω) :
    |(G.toCocycle hT).realLogNormObservable k ω| ≤
      (k : ℝ) * (log⁺ M + log⁺ K) := by
  let C := G.toCocycle hT
  have hforward :
      C.orbitLogPlusSum k ω ≤ (k : ℝ) * log⁺ M := by
    unfold DiscreteMatrixCocycle.orbitLogPlusSum
    calc
      (∑ j ∈ Finset.range k,
          C.logPlusNormObservable 1 (C.base^[j] ω)) ≤
          ∑ _j ∈ Finset.range k, log⁺ M := by
        gcongr with j hj
        rw [C.logPlusNormObservable_one]
        exact Real.posLog_le_posLog (norm_nonneg _) (G.norm_le _)
      _ = (k : ℝ) * log⁺ M := by simp
  have hinverse :
      C.inverseOrbitLogPlusSum k ω ≤ (k : ℝ) * log⁺ K := by
    unfold DiscreteMatrixCocycle.inverseOrbitLogPlusSum
    calc
      (∑ j ∈ Finset.range k,
          C.inverseGeneratorLogPlusNormObservable (C.base^[j] ω)) ≤
          ∑ _j ∈ Finset.range k, log⁺ K := by
        gcongr with j hj
        exact Real.posLog_le_posLog (norm_nonneg _) (G.norm_inv_le _)
      _ = (k : ℝ) * log⁺ K := by simp
  have hinvertible : C.IsPointwiseInvertible := G.isUnit_toFun
  have hlower :=
    hinvertible.neg_inverseOrbitLogPlusSum_le_realLogNormObservable k ω
  have hupper := (C.realLogNormObservable_le_logPlusNormObservable k ω).trans
    (C.logPlusNormObservable_le_orbitLogPlusSum k ω)
  rw [abs_le]
  constructor
  · calc
      -((k : ℝ) * (log⁺ M + log⁺ K)) ≤ -((k : ℝ) * log⁺ K) := by
        nlinarith [mul_nonneg (Nat.cast_nonneg k) (show 0 ≤ log⁺ M from
          Real.posLog_nonneg)]
      _ ≤ -C.inverseOrbitLogPlusSum k ω := neg_le_neg hinverse
      _ ≤ C.realLogNormObservable k ω := hlower
  · calc
      C.realLogNormObservable k ω ≤ C.orbitLogPlusSum k ω := hupper
      _ ≤ (k : ℝ) * log⁺ M := hforward
      _ ≤ (k : ℝ) * (log⁺ M + log⁺ K) := by
        nlinarith [mul_nonneg (Nat.cast_nonneg k) (show 0 ≤ log⁺ K from
          Real.posLog_nonneg)]

/-- At every fixed horizon, uniform generator convergence and common
two-sided bounds imply convergence of the signed real-log integrals. -/
theorem tendsto_integratedRealLogNorm_of_tendstoUniformly
    [IsFiniteMeasure μ]
    {M K : ℝ}
    {G : ℕ → UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K}
    {G₀ : UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K}
    {T : Ω → Ω} (hT : MeasurePreserving T μ μ)
    (hG : TendstoUniformly (fun n ↦ (G n : Ω → Matrix ι ι ℂ)) G₀ atTop)
    (k : ℕ) :
    Tendsto
      (fun n ↦ ((G n).toCocycle hT).integratedRealLogNorm k)
      atTop
      (𝓝 ((G₀.toCocycle hT).integratedRealLogNorm k)) := by
  apply MeasureTheory.tendsto_integral_of_dominated_convergence
    (fun _ ↦ (k : ℝ) * (log⁺ M + log⁺ K))
  · intro n
    exact ((G n).toCocycle hT).measurable_realLogNormObservable k
      |>.aestronglyMeasurable
  · exact integrable_const _
  · intro n
    filter_upwards with ω
    exact abs_realLogNormObservable_le (G n) hT k ω
  · filter_upwards with ω
    exact tendsto_realLogNormObservable_of_tendstoUniformly hT hG k ω

/-- Every strict upper neighborhood of the limiting signed Fekete rate
eventually contains the rates of uniformly convergent generators with the
same forward and inverse bounds.

This is the module's upper-semicontinuity theorem.  It is one-sided because a
Fekete rate is an infimum of finite-horizon normalized integrals. -/
theorem eventually_integratedRealLogGrowthRate_lt
    [IsProbabilityMeasure μ]
    {M K y : ℝ}
    {G : ℕ → UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K}
    {G₀ : UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K}
    {T : Ω → Ω} (hT : MeasurePreserving T μ μ)
    (hG : TendstoUniformly (fun n ↦ (G n : Ω → Matrix ι ι ℂ)) G₀ atTop)
    (hy : G₀.integratedRealLogGrowthRate hT < y) :
    ∀ᶠ n in atTop, (G n).integratedRealLogGrowthRate hT < y := by
  let C₀ := G₀.toCocycle hT
  let hC₀ := G₀.hasIntegrableGeneratorLogTails hT
  have hfinite :
      ∃ k : ℕ, k ≠ 0 ∧ C₀.normalizedIntegratedRealLogNorm k < y := by
    have heventually :
        ∀ᶠ k in atTop, C₀.normalizedIntegratedRealLogNorm k < y :=
      (tendsto_order.1 hC₀.tendsto_normalizedIntegratedRealLogNorm).2 _ hy
    obtain ⟨k, hky, hk⟩ :=
      (heventually.and (eventually_ne_atTop 0)).exists
    exact ⟨k, hk, hky⟩
  obtain ⟨k, hk, hky⟩ := hfinite
  have hintegral :=
    tendsto_integratedRealLogNorm_of_tendstoUniformly hT hG k
  have hnormalized :
      Tendsto
        (fun n ↦ ((G n).toCocycle hT).normalizedIntegratedRealLogNorm k)
        atTop
        (𝓝 (C₀.normalizedIntegratedRealLogNorm k)) := by
    simpa only [DiscreteMatrixCocycle.normalizedIntegratedRealLogNorm] using
      hintegral.div_const (k : ℝ)
  have heventually :
      ∀ᶠ n in atTop,
        ((G n).toCocycle hT).normalizedIntegratedRealLogNorm k < y :=
    (tendsto_order.1 hnormalized).2 _ hky
  filter_upwards [heventually] with n hn
  exact
    ((G n).hasIntegrableGeneratorLogTails hT
      |>.integratedRealLogGrowthRate_le_normalized hk).trans_lt hn

/-- Epsilon form of upper stability: every positive tolerance eventually
bounds the perturbed rate by the limiting rate plus that tolerance. -/
theorem eventually_integratedRealLogGrowthRate_le_add
    [IsProbabilityMeasure μ]
    {M K : ℝ}
    {G : ℕ → UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K}
    {G₀ : UniformlyBoundedInvertibleGenerator (Ω := Ω) (ι := ι) M K}
    {T : Ω → Ω} (hT : MeasurePreserving T μ μ)
    (hG : TendstoUniformly (fun n ↦ (G n : Ω → Matrix ι ι ℂ)) G₀ atTop)
    {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n in atTop,
      (G n).integratedRealLogGrowthRate hT ≤
        G₀.integratedRealLogGrowthRate hT + ε := by
  filter_upwards
      [eventually_integratedRealLogGrowthRate_lt hT hG
        (lt_add_of_pos_right _ hε)]
      with n hn
  exact hn.le

end UniformlyBoundedInvertibleGenerator

end NonlinearDynamics.Random.RandomCocycles

#print axioms NonlinearDynamics.Random.RandomCocycles.UniformlyBoundedInvertibleGenerator.hasIntegrableGeneratorLogTails
#print axioms NonlinearDynamics.Random.RandomCocycles.UniformlyBoundedInvertibleGenerator.tendsto_value_of_tendstoUniformly
#print axioms NonlinearDynamics.Random.RandomCocycles.UniformlyBoundedInvertibleGenerator.tendsto_integratedRealLogNorm_of_tendstoUniformly
#print axioms NonlinearDynamics.Random.RandomCocycles.UniformlyBoundedInvertibleGenerator.eventually_integratedRealLogGrowthRate_lt
#print axioms NonlinearDynamics.Random.RandomCocycles.UniformlyBoundedInvertibleGenerator.eventually_integratedRealLogGrowthRate_le_add
