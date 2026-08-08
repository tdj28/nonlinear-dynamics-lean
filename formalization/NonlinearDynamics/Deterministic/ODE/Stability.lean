import Mathlib.Dynamics.Flow
import Mathlib.Topology.MetricSpace.Equicontinuity
import Mathlib.Topology.MetricSpace.Lipschitz

/-!
# Stability and attraction for continuous-time flows

This module separates four properties of a real-time topological flow.  A
reference orbit is forward stable when the family of all nonnegative-time maps
is equicontinuous at its initial point.  An equilibrium is fixed at every real
time.  Attraction is convergence to a target as real time tends to positive
infinity.  An asymptotically stable equilibrium has both Lyapunov stability
and a neighborhood contained in its basin of attraction.

The stability definition uses Mathlib's additive submonoid of nonnegative real
times, so the quantifier is exactly uniform over `t ≥ 0`; negative time is not
silently included.  The attraction definition uses the order filter `atTop`
on `ℝ`, rather than a sampled natural-number orbit.

This file treats point and equilibrium stability only.  It does not define
invariant-set stability, exponential or input-to-state stability, structural
stability under perturbations of the flow, or stochastic stability.  It also
does not claim that stability implies attraction or that attraction alone
supplies stability.
-/

open Filter Function
open scoped Uniformity

namespace NonlinearDynamics.Deterministic.ODE

universe u

variable {X : Type u}

/-- A reference point is forward stable when all nonnegative-time maps of the
flow form an equicontinuous family there.

The point need not be an equilibrium: nearby initial conditions are compared
with the entire reference orbit `t ↦ ϕ t p`. -/
def IsForwardStableAt [UniformSpace X]
    (ϕ : Flow ℝ X) (p : X) : Prop :=
  EquicontinuousAt (fun t : AddSubmonoid.nonneg ℝ ↦ ϕ t) p

/-- An equilibrium is fixed by the flow at every real time. -/
def IsEquilibrium [TopologicalSpace X]
    (ϕ : Flow ℝ X) (p : X) : Prop :=
  ∀ t : ℝ, ϕ t p = p

/-- A Lyapunov-stable equilibrium is an equilibrium whose reference orbit is
forward stable.  Fixedness and stability remain separate proof obligations. -/
def IsLyapunovStableEquilibrium [UniformSpace X]
    (ϕ : Flow ℝ X) (p : X) : Prop :=
  IsEquilibrium ϕ p ∧ IsForwardStableAt ϕ p

/-- An orbit is attracted to `p` when it converges to `p` as real time tends
to positive infinity.  Equilibrium or stability of `p` is not built in. -/
def IsAttractedTo [TopologicalSpace X]
    (ϕ : Flow ℝ X) (x p : X) : Prop :=
  Tendsto (fun t : ℝ ↦ ϕ t x) atTop (nhds p)

/-- The basin of a point consists of the initial states attracted to it. -/
def basinOfAttraction [TopologicalSpace X]
    (ϕ : Flow ℝ X) (p : X) : Set X :=
  {x | IsAttractedTo ϕ x p}

/-- A locally attracting equilibrium is an equilibrium whose basin is a
neighborhood of the equilibrium. -/
def IsLocallyAttractingEquilibrium [TopologicalSpace X]
    (ϕ : Flow ℝ X) (p : X) : Prop :=
  IsEquilibrium ϕ p ∧ basinOfAttraction ϕ p ∈ nhds p

/-- A globally attracting equilibrium attracts every initial state. -/
def IsGloballyAttractingEquilibrium [TopologicalSpace X]
    (ϕ : Flow ℝ X) (p : X) : Prop :=
  IsEquilibrium ϕ p ∧ ∀ x, IsAttractedTo ϕ x p

/-- An asymptotically stable equilibrium is Lyapunov stable and has a basin
that is a neighborhood of the equilibrium. -/
def IsAsymptoticallyStableEquilibrium [UniformSpace X]
    (ϕ : Flow ℝ X) (p : X) : Prop :=
  IsLyapunovStableEquilibrium ϕ p ∧ basinOfAttraction ϕ p ∈ nhds p

/-- The uniform-space stability definition unfolded into entourages and
neighborhoods, with time indexed by the nonnegative-real submonoid. -/
theorem isForwardStableAt_iff [UniformSpace X]
    {ϕ : Flow ℝ X} {p : X} :
    IsForwardStableAt ϕ p ↔
      ∀ U ∈ 𝓤 X, ∀ᶠ x in nhds p,
        ∀ t : AddSubmonoid.nonneg ℝ, (ϕ t p, ϕ t x) ∈ U :=
  Iff.rfl

/-- In a pseudo-metric space, forward stability is the uniform-in-all-forward-
times epsilon-delta comparison of nearby orbits. -/
theorem isForwardStableAt_iff_dist [PseudoMetricSpace X]
    {ϕ : Flow ℝ X} {p : X} :
    IsForwardStableAt ϕ p ↔
      ∀ ε > 0, ∃ δ > 0, ∀ x, dist x p < δ →
        ∀ t : AddSubmonoid.nonneg ℝ, dist (ϕ t p) (ϕ t x) < ε :=
  Metric.equicontinuousAt_iff

/-- At an equilibrium, the orbit comparison reduces to the usual statement
that every sufficiently close initial state remains close to the equilibrium
for every nonnegative real time. -/
theorem isLyapunovStableEquilibrium_iff_dist [PseudoMetricSpace X]
    {ϕ : Flow ℝ X} {p : X} :
    IsLyapunovStableEquilibrium ϕ p ↔
      IsEquilibrium ϕ p ∧
        ∀ ε > 0, ∃ δ > 0, ∀ x, dist x p < δ →
          ∀ t : AddSubmonoid.nonneg ℝ, dist (ϕ t x) p < ε := by
  constructor
  · rintro ⟨hp, hs⟩
    refine ⟨hp, ?_⟩
    rw [isForwardStableAt_iff_dist] at hs
    intro ε hε
    rcases hs ε hε with ⟨δ, hδ, hs⟩
    refine ⟨δ, hδ, fun x hx t ↦ ?_⟩
    simpa only [hp t, dist_comm] using hs x hx t
  · rintro ⟨hp, hs⟩
    refine ⟨hp, ?_⟩
    rw [isForwardStableAt_iff_dist]
    intro ε hε
    rcases hs ε hε with ⟨δ, hδ, hs⟩
    refine ⟨δ, hδ, fun x hx t ↦ ?_⟩
    simpa only [hp t, dist_comm] using hs x hx t

/-- Equilibrium can equivalently be checked only at nonnegative times. -/
theorem isEquilibrium_iff_nonneg [TopologicalSpace X]
    {ϕ : Flow ℝ X} {p : X} :
    IsEquilibrium ϕ p ↔ ∀ t : ℝ, 0 ≤ t → ϕ t p = p := by
  constructor
  · exact fun hp t _ ↦ hp t
  · intro hp t
    by_cases ht : 0 ≤ t
    · exact hp t ht
    · have hneg : 0 ≤ -t := neg_nonneg.mpr (le_of_not_ge ht)
      calc
        ϕ t p = ϕ t (ϕ (-t) p) := by rw [hp (-t) hneg]
        _ = ϕ (t + -t) p := (ϕ.map_add t (-t) p).symm
        _ = p := by simp [ϕ.map_zero_apply]

/-- A common nonexpansive bound on every forward-time map implies forward
stability at every reference point. -/
theorem isForwardStableAt_of_forall_lipschitzWith_one [PseudoMetricSpace X]
    {ϕ : Flow ℝ X}
    (hϕ : ∀ t : AddSubmonoid.nonneg ℝ, LipschitzWith 1 (ϕ t))
    (p : X) : IsForwardStableAt ϕ p := by
  rw [isForwardStableAt_iff_dist]
  intro ε hε
  refine ⟨ε, hε, fun x hx t ↦ ?_⟩
  calc
    dist (ϕ t p) (ϕ t x) ≤ 1 * dist p x := (hϕ t).dist_le_mul p x
    _ = dist x p := by simp only [one_mul, dist_comm]
    _ < ε := hx

/-- A common nonexpansive bound plus equilibrium gives Lyapunov stability. -/
theorem isLyapunovStableEquilibrium_of_forall_lipschitzWith_one
    [PseudoMetricSpace X] {ϕ : Flow ℝ X} {p : X}
    (hϕ : ∀ t : AddSubmonoid.nonneg ℝ, LipschitzWith 1 (ϕ t))
    (hp : IsEquilibrium ϕ p) :
    IsLyapunovStableEquilibrium ϕ p :=
  ⟨hp, isForwardStableAt_of_forall_lipschitzWith_one hϕ p⟩

/-- The identity flow is forward stable at every point. -/
@[simp] theorem isForwardStableAt_id [PseudoMetricSpace X] (p : X) :
    IsForwardStableAt (Flow.id ℝ X) p :=
  isForwardStableAt_of_forall_lipschitzWith_one
    (fun _ ↦ LipschitzWith.id) p

/-- Every point is a Lyapunov-stable equilibrium of the identity flow. -/
@[simp] theorem isLyapunovStableEquilibrium_id [PseudoMetricSpace X] (p : X) :
    IsLyapunovStableEquilibrium (Flow.id ℝ X) p :=
  ⟨fun _ ↦ rfl, isForwardStableAt_id p⟩

/-- Translation at constant velocity `c` is a real-time flow. -/
def translationFlow (c : ℝ) : Flow ℝ ℝ where
  toFun t x := x + t * c
  cont' := continuous_snd.add (continuous_fst.mul continuous_const)
  map_add' t s x := by ring
  map_zero' x := by simp

@[simp] theorem translationFlow_apply (c t x : ℝ) :
    translationFlow c t x = x + t * c :=
  rfl

/-- Constant-velocity translation is forward stable at every reference point. -/
theorem isForwardStableAt_translationFlow (c p : ℝ) :
    IsForwardStableAt (translationFlow c) p := by
  apply isForwardStableAt_of_forall_lipschitzWith_one
  intro t
  exact LipschitzWith.mk_one fun x y ↦ by
    simp only [translationFlow_apply, Real.dist_eq, add_sub_add_right_eq_sub]

/-- A nonzero translation flow exhibits a forward-stable reference orbit that
is not an equilibrium. -/
theorem forwardStableAt_translationFlow_not_equilibrium
    {c p : ℝ} (hc : c ≠ 0) :
    IsForwardStableAt (translationFlow c) p ∧
      ¬IsEquilibrium (translationFlow c) p := by
  refine ⟨isForwardStableAt_translationFlow c p, ?_⟩
  intro hp
  apply hc
  apply add_left_cancel (a := p)
  simpa using hp 1

@[simp] theorem mem_basinOfAttraction [TopologicalSpace X]
    {ϕ : Flow ℝ X} {x p : X} :
    x ∈ basinOfAttraction ϕ p ↔ IsAttractedTo ϕ x p :=
  Iff.rfl

/-- In a pseudo-metric space, attraction is exactly convergence of the
orbit-to-target distance to zero along real time. -/
theorem isAttractedTo_iff_dist [PseudoMetricSpace X]
    {ϕ : Flow ℝ X} {x p : X} :
    IsAttractedTo ϕ x p ↔
      Tendsto (fun t : ℝ ↦ dist (ϕ t x) p) atTop (nhds 0) :=
  tendsto_iff_dist_tendsto_zero

/-- An equilibrium attracts its own constant orbit. -/
theorem IsEquilibrium.isAttractedTo [TopologicalSpace X]
    {ϕ : Flow ℝ X} {p : X} (hp : IsEquilibrium ϕ p) :
    IsAttractedTo ϕ p p := by
  exact tendsto_const_nhds.congr fun t ↦ (hp t).symm

/-- For a continuous real flow on a Hausdorff space, any pointwise forward
orbit limit is an equilibrium.  Joint continuity transports the limit through
each fixed-time map, while the flow law identifies that transported orbit with
a time translate of the original orbit. -/
theorem IsAttractedTo.isEquilibrium [TopologicalSpace X] [T2Space X]
    {ϕ : Flow ℝ X} {x p : X} (hxp : IsAttractedTo ϕ x p) :
    IsEquilibrium ϕ p := by
  intro s
  have hshift : Tendsto (fun t : ℝ ↦ ϕ (s + t) x) atTop (nhds p) :=
    hxp.comp (tendsto_atTop_add_const_left atTop s tendsto_id)
  have htransport :
      Tendsto (fun t : ℝ ↦ ϕ s (ϕ t x)) atTop (nhds (ϕ s p)) :=
    (ϕ.continuous_toFun s).continuousAt.comp hxp
  have hsame : Tendsto (fun t : ℝ ↦ ϕ (s + t) x) atTop (nhds (ϕ s p)) := by
    simpa only [ϕ.map_add] using htransport
  exact tendsto_nhds_unique hsame hshift

/-- Under the identity flow on a T1 space, attraction to `p` holds exactly for
the orbit that starts at `p`.  Thus Lyapunov stability does not by itself make
an equilibrium locally or globally attracting. -/
theorem isAttractedTo_id_iff [TopologicalSpace X] [T1Space X]
    {x p : X} :
    IsAttractedTo (Flow.id ℝ X) x p ↔ x = p := by
  simpa only [IsAttractedTo, Flow.id_apply, id_eq] using
    (tendsto_const_nhds_iff (l := (atTop : Filter ℝ)) (c := x) (d := p))

/-- Global attraction implies local attraction. -/
theorem IsGloballyAttractingEquilibrium.isLocallyAttractingEquilibrium
    [TopologicalSpace X] {ϕ : Flow ℝ X} {p : X}
    (h : IsGloballyAttractingEquilibrium ϕ p) :
    IsLocallyAttractingEquilibrium ϕ p :=
  ⟨h.1, Filter.Eventually.of_forall h.2⟩

/-- The asymptotic-stability definition is exactly Lyapunov stability plus
local attraction. -/
theorem isAsymptoticallyStableEquilibrium_iff [UniformSpace X]
    {ϕ : Flow ℝ X} {p : X} :
    IsAsymptoticallyStableEquilibrium ϕ p ↔
      IsLyapunovStableEquilibrium ϕ p ∧
        IsLocallyAttractingEquilibrium ϕ p := by
  simp only [IsAsymptoticallyStableEquilibrium,
    IsLocallyAttractingEquilibrium, IsLyapunovStableEquilibrium]
  tauto

end NonlinearDynamics.Deterministic.ODE

#print axioms NonlinearDynamics.Deterministic.ODE.isForwardStableAt_iff_dist
#print axioms NonlinearDynamics.Deterministic.ODE.isLyapunovStableEquilibrium_iff_dist
#print axioms NonlinearDynamics.Deterministic.ODE.isEquilibrium_iff_nonneg
#print axioms NonlinearDynamics.Deterministic.ODE.isForwardStableAt_of_forall_lipschitzWith_one
#print axioms NonlinearDynamics.Deterministic.ODE.forwardStableAt_translationFlow_not_equilibrium
#print axioms NonlinearDynamics.Deterministic.ODE.isAttractedTo_iff_dist
#print axioms NonlinearDynamics.Deterministic.ODE.IsAttractedTo.isEquilibrium
#print axioms NonlinearDynamics.Deterministic.ODE.isAttractedTo_id_iff
#print axioms NonlinearDynamics.Deterministic.ODE.isAsymptoticallyStableEquilibrium_iff
