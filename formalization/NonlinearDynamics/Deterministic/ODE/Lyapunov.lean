import Mathlib.Analysis.Calculus.Deriv.MeanValue
import NonlinearDynamics.Deterministic.Discrete.Lyapunov
import NonlinearDynamics.Deterministic.ODE.Stability

/-!
# Lyapunov certificates for continuous-time flows

This module develops the trajectory-level direct method for a real-time flow.
The spatial sign and sublevel-control predicates are shared with the discrete
theory, while descent is quantified over every nonnegative real time.

Weak descent preserves forward-invariant sublevels and, together with
continuity and quantitative sublevel control, proves Lyapunov stability of an
equilibrium.  Separately, convergence of the scalar value to zero proves
attraction.  The two conclusions are combined only when both hypotheses are
available.

The derivative bridge concerns the one-variable function
`t ↦ V (ϕ t x)`.  It makes differentiability explicit for a nonpositive
derivative and uses Mathlib's real mean-value theorem to obtain weak descent.
This first slice does not define a manifold Lie derivative or claim that a
vector-field sign condition implies the trajectory derivative condition;
such a corollary additionally needs a checked chain rule connecting the
chosen scalar regularity, the integral-curve flow, and manifold derivatives.

Strict descent remains separate from attraction.  Without a zero-value limit,
compactness or another invariance-principle hypothesis, strict decrease alone
does not identify the orbit's limiting state.
-/

open Filter Function Set

namespace NonlinearDynamics.Deterministic.ODE

universe u

variable {X : Type u}

/-- Nonnegativity is a spatial property independent of whether time is
discrete or continuous. -/
abbrev IsNonnegativeOn (V : X → ℝ) (S : Set X) : Prop :=
  Discrete.IsNonnegativeOn V S

/-- Positive definiteness is a spatial property independent of the time
parameter used by the dynamics. -/
abbrev IsPositiveDefiniteOn (V : X → ℝ) (p : X) (S : Set X) : Prop :=
  Discrete.IsPositiveDefiniteOn V p S

/-- Local positive definiteness is shared with the discrete direct-method
interface. -/
abbrev IsLocallyPositiveDefiniteAt [TopologicalSpace X]
    (V : X → ℝ) (p : X) : Prop :=
  Discrete.IsLocallyPositiveDefiniteAt V p

/-- Positive sublevels control distance to the reference point.  This
quantitative comparison is independent of the dynamics. -/
abbrev HasSublevelControlAt [PseudoMetricSpace X]
    (V : X → ℝ) (p : X) : Prop :=
  Discrete.HasSublevelControlAt V p

/-- The total real derivative of the Lyapunov value along the orbit from `x`
at time `t`.

As usual for Mathlib's `deriv`, this value is zero when differentiability
fails.  The weak derivative-to-descent theorem therefore carries a separate
differentiability hypothesis. -/
noncomputable def lyapunovDerivativeAlong [TopologicalSpace X]
    (ϕ : Flow ℝ X) (V : X → ℝ) (x : X) (t : ℝ) : ℝ :=
  deriv (fun s : ℝ ↦ V (ϕ s x)) t

/-- The Lyapunov value weakly decreases from every point of `S` at every
nonnegative real time.  Forward invariance of `S` is a separate hypothesis. -/
def IsWeakLyapunovDecreaseOn [TopologicalSpace X]
    (ϕ : Flow ℝ X) (V : X → ℝ) (S : Set X) : Prop :=
  ∀ x ∈ S, ∀ t : ℝ, 0 ≤ t → V (ϕ t x) ≤ V x

/-- The Lyapunov value strictly decreases from every nonreference point of
`S` at every strictly positive real time.  This condition does not include
equilibrium, invariance, or attraction. -/
def IsStrictLyapunovDecreaseOn [TopologicalSpace X]
    (ϕ : Flow ℝ X) (V : X → ℝ) (p : X) (S : Set X) : Prop :=
  ∀ x ∈ S, x ≠ p → ∀ t : ℝ, 0 < t → V (ϕ t x) < V x

/-- Positive definiteness implies nonnegativity on the same region. -/
theorem IsPositiveDefiniteOn.isNonnegativeOn
    {V : X → ℝ} {p : X} {S : Set X}
    (hV : IsPositiveDefiniteOn V p S) : IsNonnegativeOn V S :=
  Discrete.IsPositiveDefiniteOn.isNonnegativeOn hV

/-- Strict positive-time descent becomes weak nonnegative-time descent when
the reference point is an equilibrium. -/
theorem IsStrictLyapunovDecreaseOn.isWeakLyapunovDecreaseOn
    [TopologicalSpace X] {ϕ : Flow ℝ X} {V : X → ℝ} {p : X} {S : Set X}
    (hV : IsStrictLyapunovDecreaseOn ϕ V p S)
    (hp : IsEquilibrium ϕ p) : IsWeakLyapunovDecreaseOn ϕ V S := by
  intro x hx t ht
  by_cases hxp : x = p
  · subst x
    rw [hp t]
  · by_cases ht0 : t = 0
    · subst t
      rw [ϕ.map_zero_apply]
    · exact (hV x hx hxp t (lt_of_le_of_ne ht (Ne.symm ht0))).le

/-- Weak descent preserves closed sublevels inside a forward-invariant
region. -/
theorem IsWeakLyapunovDecreaseOn.isForwardInvariant_closedSublevel
    [TopologicalSpace X] {ϕ : Flow ℝ X} {V : X → ℝ} {S : Set X} {c : ℝ}
    (hV : IsWeakLyapunovDecreaseOn ϕ V S)
    (hS : IsForwardInvariant ϕ S) :
    IsForwardInvariant ϕ (S ∩ {x | V x ≤ c}) := by
  intro t ht x hx
  exact ⟨hS ht hx.1, (hV x hx.1 t ht).trans hx.2⟩

/-- Weak descent also preserves open sublevels inside a forward-invariant
region. -/
theorem IsWeakLyapunovDecreaseOn.isForwardInvariant_openSublevel
    [TopologicalSpace X] {ϕ : Flow ℝ X} {V : X → ℝ} {S : Set X} {c : ℝ}
    (hV : IsWeakLyapunovDecreaseOn ϕ V S)
    (hS : IsForwardInvariant ϕ S) :
    IsForwardInvariant ϕ (S ∩ {x | V x < c}) := by
  intro t ht x hx
  exact ⟨hS ht hx.1, (hV x hx.1 t ht).trans_lt hx.2⟩

/-- On a forward-invariant region, weak descent makes the scalar value along
an orbit antitone over nonnegative real time. -/
theorem IsWeakLyapunovDecreaseOn.antitoneOn_orbit
    [TopologicalSpace X] {ϕ : Flow ℝ X} {V : X → ℝ} {S : Set X}
    (hV : IsWeakLyapunovDecreaseOn ϕ V S)
    (hS : IsForwardInvariant ϕ S) {x : X} (hx : x ∈ S) :
    AntitoneOn (fun t : ℝ ↦ V (ϕ t x)) (Set.Ici 0) := by
  intro s hs t _ht hst
  have hxs : ϕ s x ∈ S := hS hs hx
  calc
    V (ϕ t x) = V (ϕ (t - s) (ϕ s x)) := by
      rw [← ϕ.map_add, sub_add_cancel]
    _ ≤ V (ϕ s x) := hV _ hxs _ (sub_nonneg.mpr hst)

/-- A differentiable scalar value with nonpositive derivative along every
orbit from `S` supplies weak Lyapunov descent on `S`. -/
theorem isWeakLyapunovDecreaseOn_of_derivative_nonpos
    [TopologicalSpace X] {ϕ : Flow ℝ X} {V : X → ℝ} {S : Set X}
    (hdiff : ∀ x ∈ S, Differentiable ℝ (fun t : ℝ ↦ V (ϕ t x)))
    (hderiv : ∀ x ∈ S, ∀ t : ℝ,
      lyapunovDerivativeAlong ϕ V x t ≤ 0) :
    IsWeakLyapunovDecreaseOn ϕ V S := by
  intro x hx t ht
  have hanti : Antitone (fun s : ℝ ↦ V (ϕ s x)) :=
    antitone_of_deriv_nonpos (hdiff x hx) fun s ↦ by
      simpa only [lyapunovDerivativeAlong] using hderiv x hx s
  simpa only [ϕ.map_zero_apply] using hanti ht

/-- A strictly negative derivative along every orbit from `S` supplies strict
positive-time Lyapunov descent.  Strict negativity of Mathlib's total `deriv`
also forces differentiability at every time. -/
theorem isStrictLyapunovDecreaseOn_of_derivative_neg
    [TopologicalSpace X] {ϕ : Flow ℝ X} {V : X → ℝ} {p : X} {S : Set X}
    (hderiv : ∀ x ∈ S, x ≠ p → ∀ t : ℝ,
      lyapunovDerivativeAlong ϕ V x t < 0) :
    IsStrictLyapunovDecreaseOn ϕ V p S := by
  intro x hx hxp t ht
  have hanti : StrictAnti (fun s : ℝ ↦ V (ϕ s x)) :=
    strictAnti_of_deriv_neg fun s ↦ by
      simpa only [lyapunovDerivativeAlong] using hderiv x hx hxp s
  simpa only [ϕ.map_zero_apply] using hanti ht

/-- Continuity at the equilibrium, quantitative sublevel control, and weak
descent at every forward time give Lyapunov stability. -/
theorem isLyapunovStableEquilibrium_of_continuousAt_of_sublevelControl
    [PseudoMetricSpace X] {ϕ : Flow ℝ X} {p : X} {V : X → ℝ}
    (hp : IsEquilibrium ϕ p) (hV0 : V p = 0) (hVc : ContinuousAt V p)
    (hcontrol : HasSublevelControlAt V p)
    (hdec : IsWeakLyapunovDecreaseOn ϕ V Set.univ) :
    IsLyapunovStableEquilibrium ϕ p := by
  rw [isLyapunovStableEquilibrium_iff_dist]
  refine ⟨hp, fun ε hε ↦ ?_⟩
  rcases hcontrol ε hε with ⟨c, hc, hsublevel⟩
  have hsublevel_nhds : {x | V x < c} ∈ nhds p := by
    change V ⁻¹' Set.Iio c ∈ nhds p
    exact hVc (by simpa only [hV0] using Iio_mem_nhds hc)
  rcases Metric.mem_nhds_iff.1 hsublevel_nhds with ⟨δ, hδ, hball⟩
  refine ⟨δ, hδ, fun x hx t ↦ hsublevel _ ?_⟩
  exact (hdec x (Set.mem_univ x) t t.property).trans_lt (hball hx)

/-- A global positive-definite certificate supplies the zero-value hypothesis
in the continuous-time stability theorem. -/
theorem isLyapunovStableEquilibrium_of_positiveDefinite_of_sublevelControl
    [PseudoMetricSpace X] {ϕ : Flow ℝ X} {p : X} {V : X → ℝ}
    (hp : IsEquilibrium ϕ p)
    (hV : IsPositiveDefiniteOn V p Set.univ) (hVc : ContinuousAt V p)
    (hcontrol : HasSublevelControlAt V p)
    (hdec : IsWeakLyapunovDecreaseOn ϕ V Set.univ) :
    IsLyapunovStableEquilibrium ϕ p :=
  isLyapunovStableEquilibrium_of_continuousAt_of_sublevelControl
    hp hV.2.1 hVc hcontrol hdec

/-- If the Lyapunov value along one real-time orbit tends to zero and positive
sublevels control distance, then that orbit is attracted to the reference
point. -/
theorem isAttractedTo_of_tendsto_lyapunov
    [PseudoMetricSpace X] {ϕ : Flow ℝ X} {x p : X} {V : X → ℝ}
    (hcontrol : HasSublevelControlAt V p)
    (hlim : Tendsto (fun t : ℝ ↦ V (ϕ t x)) atTop (nhds 0)) :
    IsAttractedTo ϕ x p := by
  rw [IsAttractedTo]
  refine Metric.tendsto_atTop.2 fun ε hε ↦ ?_
  rcases hcontrol ε hε with ⟨c, hc, hsublevel⟩
  have hEventually : ∀ᶠ t : ℝ in atTop, V (ϕ t x) < c :=
    hlim (Iio_mem_nhds hc)
  rcases eventually_atTop.1 hEventually with ⟨T, hT⟩
  exact ⟨T, fun t ht ↦ hsublevel _ (hT t ht)⟩

/-- Zero-value convergence on a neighborhood gives a locally attracting
equilibrium. -/
theorem isLocallyAttractingEquilibrium_of_tendsto_lyapunov
    [PseudoMetricSpace X] {ϕ : Flow ℝ X} {p : X} {V : X → ℝ} {S : Set X}
    (hp : IsEquilibrium ϕ p) (hcontrol : HasSublevelControlAt V p)
    (hS : S ∈ nhds p)
    (hlim : ∀ x ∈ S, Tendsto (fun t : ℝ ↦ V (ϕ t x)) atTop (nhds 0)) :
    IsLocallyAttractingEquilibrium ϕ p := by
  refine ⟨hp, ?_⟩
  filter_upwards [hS] with x hx
  exact isAttractedTo_of_tendsto_lyapunov hcontrol (hlim x hx)

/-- Zero-value convergence along every orbit gives a globally attracting
equilibrium. -/
theorem isGloballyAttractingEquilibrium_of_tendsto_lyapunov
    [PseudoMetricSpace X] {ϕ : Flow ℝ X} {p : X} {V : X → ℝ}
    (hp : IsEquilibrium ϕ p) (hcontrol : HasSublevelControlAt V p)
    (hlim : ∀ x, Tendsto (fun t : ℝ ↦ V (ϕ t x)) atTop (nhds 0)) :
    IsGloballyAttractingEquilibrium ϕ p :=
  ⟨hp, fun x ↦ isAttractedTo_of_tendsto_lyapunov hcontrol (hlim x)⟩

/-- The stability bridge and neighborhood-level zero-value convergence give
asymptotic stability.  Weak descent alone is not used to infer attraction. -/
theorem isAsymptoticallyStableEquilibrium_of_lyapunov
    [PseudoMetricSpace X] {ϕ : Flow ℝ X} {p : X} {V : X → ℝ} {S : Set X}
    (hp : IsEquilibrium ϕ p) (hV0 : V p = 0) (hVc : ContinuousAt V p)
    (hcontrol : HasSublevelControlAt V p)
    (hdec : IsWeakLyapunovDecreaseOn ϕ V Set.univ)
    (hS : S ∈ nhds p)
    (hlim : ∀ x ∈ S, Tendsto (fun t : ℝ ↦ V (ϕ t x)) atTop (nhds 0)) :
    IsAsymptoticallyStableEquilibrium ϕ p := by
  refine ⟨isLyapunovStableEquilibrium_of_continuousAt_of_sublevelControl
      hp hV0 hVc hcontrol hdec, ?_⟩
  filter_upwards [hS] with x hx
  exact isAttractedTo_of_tendsto_lyapunov hcontrol (hlim x hx)

/-- The real translation flow with `V x = -x` has strict scalar descent at
every positive time but no equilibrium.  This boundary example records that
strict descent does not silently supply the missing equilibrium hypothesis. -/
theorem strictLyapunovDecreaseOn_neg_translationFlow (p : ℝ) :
    IsStrictLyapunovDecreaseOn (translationFlow 1) (fun x : ℝ ↦ -x) p Set.univ := by
  intro x _hx _hxp t ht
  simp only [translationFlow_apply, mul_one]
  linarith

/-- Strict descent by itself does not imply that the named reference point is
an equilibrium. -/
theorem strictLyapunovDecreaseOn_neg_translationFlow_not_equilibrium (p : ℝ) :
    IsStrictLyapunovDecreaseOn (translationFlow 1) (fun x : ℝ ↦ -x) p Set.univ ∧
      ¬IsEquilibrium (translationFlow 1) p :=
  ⟨strictLyapunovDecreaseOn_neg_translationFlow p,
    (forwardStableAt_translationFlow_not_equilibrium
      (p := p) (show (1 : ℝ) ≠ 0 by norm_num)).2⟩

end NonlinearDynamics.Deterministic.ODE

#print axioms NonlinearDynamics.Deterministic.ODE.IsWeakLyapunovDecreaseOn.antitoneOn_orbit
#print axioms NonlinearDynamics.Deterministic.ODE.isWeakLyapunovDecreaseOn_of_derivative_nonpos
#print axioms NonlinearDynamics.Deterministic.ODE.isStrictLyapunovDecreaseOn_of_derivative_neg
#print axioms NonlinearDynamics.Deterministic.ODE.isLyapunovStableEquilibrium_of_continuousAt_of_sublevelControl
#print axioms NonlinearDynamics.Deterministic.ODE.isAttractedTo_of_tendsto_lyapunov
#print axioms NonlinearDynamics.Deterministic.ODE.isLocallyAttractingEquilibrium_of_tendsto_lyapunov
#print axioms NonlinearDynamics.Deterministic.ODE.isAsymptoticallyStableEquilibrium_of_lyapunov
#print axioms NonlinearDynamics.Deterministic.ODE.strictLyapunovDecreaseOn_neg_translationFlow_not_equilibrium
