import NonlinearDynamics.Deterministic.Discrete.Attraction
import Mathlib.Topology.Order.LocalExtr

/-!
# Lyapunov functions for deterministic discrete-time systems

This module separates the ingredients of the discrete Lyapunov direct method.
A scalar function can be nonnegative without being positive definite, and its
one-step value can decrease weakly or strictly on a specified region.  These
properties are not definitions of stability or attraction.

Weak decrease on a forward-invariant region makes the scalar values along an
orbit antitone and preserves sublevel sets.  A quantitative sublevel-control
hypothesis then turns weak decrease into Lyapunov stability.  Separately, if
the scalar values along an orbit tend to zero, the same control hypothesis
turns scalar convergence into state attraction.

Strict decrease by itself is not used to claim attraction: on a noncompact
space the scalar values may decrease to a positive limit.  Compact
invariance-principle arguments, coercive global criteria, rates, converse
Lyapunov theorems, and invariant-set versions are outside this first slice.
-/

open Filter Function Set Topology

namespace NonlinearDynamics.Deterministic.Discrete

universe u

variable {X : Type u}

/-- The one-step Lyapunov difference `V (f x) - V x`. -/
def lyapunovDifference (f : X → X) (V : X → ℝ) (x : X) : ℝ :=
  V (f x) - V x

/-- `V` is nonnegative on `S`.  No zero-set condition is included. -/
def IsNonnegativeOn (V : X → ℝ) (S : Set X) : Prop :=
  ∀ x ∈ S, 0 ≤ V x

/-- `V` is positive definite relative to `p` on `S`: it vanishes at `p`
and is strictly positive at every other point of `S`. -/
def IsPositiveDefiniteOn (V : X → ℝ) (p : X) (S : Set X) : Prop :=
  p ∈ S ∧ V p = 0 ∧ ∀ x ∈ S, x ≠ p → 0 < V x

/-- `V` is locally positive definite at `p` when it vanishes at `p` and is
strictly positive away from `p` throughout some neighborhood of `p`. -/
def IsLocallyPositiveDefiniteAt [TopologicalSpace X]
    (V : X → ℝ) (p : X) : Prop :=
  V p = 0 ∧ ∀ᶠ x in 𝓝 p, x ≠ p → 0 < V x

/-- The one-step Lyapunov value weakly decreases on `S`.  Forward invariance
of `S` is deliberately a separate hypothesis. -/
def IsWeakLyapunovDecreaseOn
    (f : X → X) (V : X → ℝ) (S : Set X) : Prop :=
  ∀ x ∈ S, V (f x) ≤ V x

/-- The one-step Lyapunov value strictly decreases at every point of `S`
other than `p`.  This condition alone does not assert attraction. -/
def IsStrictLyapunovDecreaseOn
    (f : X → X) (V : X → ℝ) (p : X) (S : Set X) : Prop :=
  ∀ x ∈ S, x ≠ p → V (f x) < V x

/-- Positive definiteness on a region implies nonnegativity there. -/
theorem IsPositiveDefiniteOn.isNonnegativeOn
    {V : X → ℝ} {p : X} {S : Set X}
    (hV : IsPositiveDefiniteOn V p S) : IsNonnegativeOn V S := by
  intro x hx
  by_cases hxp : x = p
  · simp [hxp, hV.2.1]
  · exact (hV.2.2 x hx hxp).le

/-- Positive definiteness makes `p` a weak minimum of `V` on the selected
region. -/
theorem IsPositiveDefiniteOn.isMinOn
    {V : X → ℝ} {p : X} {S : Set X}
    (hV : IsPositiveDefiniteOn V p S) : IsMinOn V S p := by
  intro x hx
  rw [hV.2.1]
  exact hV.isNonnegativeOn x hx

/-- A region-level certificate becomes locally positive definite when its
region is a neighborhood of the reference point. -/
theorem IsPositiveDefiniteOn.isLocallyPositiveDefiniteAt
    [TopologicalSpace X] {V : X → ℝ} {p : X} {S : Set X}
    (hV : IsPositiveDefiniteOn V p S) (hS : S ∈ 𝓝 p) :
    IsLocallyPositiveDefiniteAt V p := by
  refine ⟨hV.2.1, ?_⟩
  filter_upwards [hS] with x hxS
  exact fun hxp ↦ hV.2.2 x hxS hxp

/-- Local positive definiteness implies Mathlib's weak local-minimum
predicate.  The converse is not claimed. -/
theorem IsLocallyPositiveDefiniteAt.isLocalMin
    [TopologicalSpace X] {V : X → ℝ} {p : X}
    (hV : IsLocallyPositiveDefiniteAt V p) : IsLocalMin V p := by
  filter_upwards [hV.2] with x hx
  by_cases hxp : x = p
  · simp [hxp]
  · simpa only [hV.1] using (hx hxp).le

/-- Weak decrease is equivalent to a nonpositive Lyapunov difference on the
same region. -/
theorem isWeakLyapunovDecreaseOn_iff_difference_nonpos
    {f : X → X} {V : X → ℝ} {S : Set X} :
    IsWeakLyapunovDecreaseOn f V S ↔
      ∀ x ∈ S, lyapunovDifference f V x ≤ 0 := by
  simp only [IsWeakLyapunovDecreaseOn, lyapunovDifference, sub_nonpos]

/-- Strict decrease is equivalent to a negative Lyapunov difference away
from the reference point. -/
theorem isStrictLyapunovDecreaseOn_iff_difference_neg
    {f : X → X} {V : X → ℝ} {p : X} {S : Set X} :
    IsStrictLyapunovDecreaseOn f V p S ↔
      ∀ x ∈ S, x ≠ p → lyapunovDifference f V x < 0 := by
  simp only [IsStrictLyapunovDecreaseOn, lyapunovDifference, sub_neg]

/-- If `p` is fixed, strict decrease away from `p` implies weak decrease on
the same region. -/
theorem IsStrictLyapunovDecreaseOn.isWeakLyapunovDecreaseOn
    {f : X → X} {V : X → ℝ} {p : X} {S : Set X}
    (hV : IsStrictLyapunovDecreaseOn f V p S)
    (hp : IsFixedPt f p) : IsWeakLyapunovDecreaseOn f V S := by
  intro x hx
  by_cases hxp : x = p
  · subst x
    exact (congrArg V hp).le
  · exact (hV x hx hxp).le

/-- A weakly decreasing Lyapunov value preserves closed sublevels inside a
forward-invariant region. -/
theorem IsWeakLyapunovDecreaseOn.mapsTo_closedSublevel
    {f : X → X} {V : X → ℝ} {S : Set X} {c : ℝ}
    (hV : IsWeakLyapunovDecreaseOn f V S) (hS : MapsTo f S S) :
    MapsTo f (S ∩ {x | V x ≤ c}) (S ∩ {x | V x ≤ c}) := by
  rintro x ⟨hxS, hxc⟩
  exact ⟨hS hxS, (hV x hxS).trans hxc⟩

/-- A weakly decreasing Lyapunov value also preserves open sublevels inside
a forward-invariant region. -/
theorem IsWeakLyapunovDecreaseOn.mapsTo_openSublevel
    {f : X → X} {V : X → ℝ} {S : Set X} {c : ℝ}
    (hV : IsWeakLyapunovDecreaseOn f V S) (hS : MapsTo f S S) :
    MapsTo f (S ∩ {x | V x < c}) (S ∩ {x | V x < c}) := by
  rintro x ⟨hxS, hxc⟩
  exact ⟨hS hxS, (hV x hxS).trans_lt hxc⟩

/-- On a forward-invariant region, weak one-step decrease bounds every later
orbit value by its initial value. -/
theorem IsWeakLyapunovDecreaseOn.iterate_le
    {f : X → X} {V : X → ℝ} {S : Set X}
    (hV : IsWeakLyapunovDecreaseOn f V S) (hS : MapsTo f S S)
    {x : X} (hx : x ∈ S) (n : ℕ) : V (f^[n] x) ≤ V x := by
  induction n with
  | zero => rfl
  | succ n ih =>
      rw [iterate_succ_apply']
      exact (hV _ (hS.iterate n hx)).trans ih

/-- On a forward-invariant region, the Lyapunov values along each orbit form
an antitone sequence. -/
theorem IsWeakLyapunovDecreaseOn.antitone_orbit
    {f : X → X} {V : X → ℝ} {S : Set X}
    (hV : IsWeakLyapunovDecreaseOn f V S) (hS : MapsTo f S S)
    {x : X} (hx : x ∈ S) : Antitone (fun n : ℕ ↦ V (f^[n] x)) := by
  apply antitone_nat_of_succ_le
  intro n
  simpa only [Nat.succ_eq_add_one, iterate_succ_apply'] using
    hV _ (hS.iterate n hx)

/-- Positive sublevels of `V` control distance to `p`.  This explicit
comparison condition is what pointwise positive definiteness alone cannot
supply on an arbitrary noncompact pseudo-metric space. -/
def HasSublevelControlAt [PseudoMetricSpace X]
    (V : X → ℝ) (p : X) : Prop :=
  ∀ ε > 0, ∃ c > 0, ∀ x, V x < c → dist x p < ε

/-- Continuous sublevels, quantitative distance control, and global weak
decrease give Lyapunov stability of a fixed point. -/
theorem isLyapunovStableFixedPoint_of_continuousAt_of_sublevelControl
    [PseudoMetricSpace X] {f : X → X} {p : X} {V : X → ℝ}
    (hp : IsFixedPt f p) (hV0 : V p = 0) (hVc : ContinuousAt V p)
    (hcontrol : HasSublevelControlAt V p)
    (hdec : IsWeakLyapunovDecreaseOn f V Set.univ) :
    IsLyapunovStableFixedPoint f p := by
  rw [isLyapunovStableFixedPoint_iff_dist]
  refine ⟨hp, fun ε hε ↦ ?_⟩
  rcases hcontrol ε hε with ⟨c, hc, hsublevel⟩
  have hsublevel_nhds : {x | V x < c} ∈ 𝓝 p := by
    change V ⁻¹' Set.Iio c ∈ 𝓝 p
    exact hVc (by simpa only [hV0] using Iio_mem_nhds hc)
  rcases Metric.mem_nhds_iff.1 hsublevel_nhds with ⟨δ, hδ, hball⟩
  refine ⟨δ, hδ, fun x hx n ↦ hsublevel _ ?_⟩
  exact (hdec.iterate_le (Set.mapsTo_univ f Set.univ) (Set.mem_univ x) n).trans_lt
    (hball hx)

/-- If Lyapunov values along one orbit tend to zero and positive sublevels
control distance, then that orbit is attracted to the reference point. -/
theorem isAttractedTo_of_tendsto_lyapunov
    [PseudoMetricSpace X] {f : X → X} {x p : X} {V : X → ℝ}
    (hcontrol : HasSublevelControlAt V p)
    (hlim : Tendsto (fun n : ℕ ↦ V (f^[n] x)) atTop (𝓝 0)) :
    IsAttractedTo f x p := by
  rw [IsAttractedTo]
  refine Metric.tendsto_atTop.2 fun ε hε ↦ ?_
  rcases hcontrol ε hε with ⟨c, hc, hsublevel⟩
  have hEventually : ∀ᶠ n : ℕ in atTop, V (f^[n] x) < c :=
    hlim (Iio_mem_nhds hc)
  rcases eventually_atTop.1 hEventually with ⟨N, hN⟩
  exact ⟨N, fun n hn ↦ hsublevel _ (hN n hn)⟩

/-- If every orbit's Lyapunov value tends to zero, sublevel control upgrades
the pointwise bridge to a globally attracting fixed point. -/
theorem isGloballyAttractingFixedPoint_of_tendsto_lyapunov
    [PseudoMetricSpace X] {f : X → X} {p : X} {V : X → ℝ}
    (hp : IsFixedPt f p) (hcontrol : HasSublevelControlAt V p)
    (hlim : ∀ x, Tendsto (fun n : ℕ ↦ V (f^[n] x)) atTop (𝓝 0)) :
    IsGloballyAttractingFixedPoint f p :=
  ⟨hp, fun x ↦ isAttractedTo_of_tendsto_lyapunov hcontrol (hlim x)⟩

/-- The local stability bridge and global zero-energy convergence together
give asymptotic stability.  The two obligations remain explicit. -/
theorem isAsymptoticallyStableFixedPoint_of_lyapunov
    [PseudoMetricSpace X] {f : X → X} {p : X} {V : X → ℝ}
    (hp : IsFixedPt f p) (hV0 : V p = 0) (hVc : ContinuousAt V p)
    (hcontrol : HasSublevelControlAt V p)
    (hdec : IsWeakLyapunovDecreaseOn f V Set.univ)
    (hlim : ∀ x, Tendsto (fun n : ℕ ↦ V (f^[n] x)) atTop (𝓝 0)) :
    IsAsymptoticallyStableFixedPoint f p :=
  ⟨isLyapunovStableFixedPoint_of_continuousAt_of_sublevelControl
      hp hV0 hVc hcontrol hdec,
    Filter.Eventually.of_forall fun x ↦
      isAttractedTo_of_tendsto_lyapunov hcontrol (hlim x)⟩

end NonlinearDynamics.Deterministic.Discrete

#print axioms NonlinearDynamics.Deterministic.Discrete.IsLocallyPositiveDefiniteAt.isLocalMin
#print axioms NonlinearDynamics.Deterministic.Discrete.IsWeakLyapunovDecreaseOn.antitone_orbit
#print axioms NonlinearDynamics.Deterministic.Discrete.isLyapunovStableFixedPoint_of_continuousAt_of_sublevelControl
#print axioms NonlinearDynamics.Deterministic.Discrete.isAttractedTo_of_tendsto_lyapunov
#print axioms NonlinearDynamics.Deterministic.Discrete.isGloballyAttractingFixedPoint_of_tendsto_lyapunov
#print axioms NonlinearDynamics.Deterministic.Discrete.isAsymptoticallyStableFixedPoint_of_lyapunov
