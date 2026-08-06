import Mathlib.Dynamics.FixedPoints.Basic
import Mathlib.Topology.MetricSpace.Equicontinuity
import Mathlib.Topology.MetricSpace.Lipschitz

/-!
# Forward stability for deterministic discrete-time systems

This module treats a self-map `f : α → α` as a one-sided discrete-time
system indexed by natural numbers.  A point is forward stable when the family
of iterates `f^[n]` is equicontinuous there.  This compares nearby initial
conditions with the entire reference orbit and therefore does not require the
reference point to be fixed.

A Lyapunov-stable fixed point is recorded separately as a fixed point together
with forward stability.  In a pseudo-metric space this specializes to the
usual epsilon-delta condition that every sufficiently close initial state
remains close for every natural-number time.

This file does not define invariant-set stability, attraction, asymptotic or
exponential stability, two-sided time, structural stability, or stability
under perturbation of the map itself.
-/

open Function
open scoped Uniformity

namespace NonlinearDynamics.Deterministic.Discrete

universe u

variable {X : Type u}

/-- Forward stability at `p` means equicontinuity at `p` of all
natural-number iterates of `f`.

The reference point need not be fixed: the definition compares the orbit of a
nearby point with the reference orbit `f^[n] p` at every forward time `n`. -/
def IsForwardStableAt [UniformSpace X]
    (f : X → X) (p : X) : Prop :=
  EquicontinuousAt (fun n : ℕ ↦ f^[n]) p

/-- A Lyapunov-stable fixed point is a fixed point that is forward stable. -/
def IsLyapunovStableFixedPoint [UniformSpace X]
    (f : X → X) (p : X) : Prop :=
  IsFixedPt f p ∧ IsForwardStableAt f p

/-- The uniform-space definition unfolded into entourages and neighborhoods. -/
theorem isForwardStableAt_iff [UniformSpace X]
    {f : X → X} {p : X} :
    IsForwardStableAt f p ↔
      ∀ U ∈ 𝓤 X, ∀ᶠ x in nhds p, ∀ n : ℕ, (f^[n] p, f^[n] x) ∈ U :=
  Iff.rfl

/-- In a pseudo-metric space, forward stability is the familiar uniform-in-time
epsilon-delta estimate between nearby orbits. -/
theorem isForwardStableAt_iff_dist [PseudoMetricSpace X]
    {f : X → X} {p : X} :
    IsForwardStableAt f p ↔
      ∀ ε > 0, ∃ δ > 0, ∀ x, dist x p < δ →
        ∀ n : ℕ, dist (f^[n] p) (f^[n] x) < ε :=
  Metric.equicontinuousAt_iff

/-- At a fixed point, the orbit comparison reduces to the usual statement
that every sufficiently close initial state stays close to the fixed point. -/
theorem isLyapunovStableFixedPoint_iff_dist [PseudoMetricSpace X]
    {f : X → X} {p : X} :
    IsLyapunovStableFixedPoint f p ↔
      IsFixedPt f p ∧
        ∀ ε > 0, ∃ δ > 0, ∀ x, dist x p < δ →
          ∀ n : ℕ, dist (f^[n] x) p < ε := by
  constructor
  · rintro ⟨hp, hs⟩
    refine ⟨hp, ?_⟩
    rw [isForwardStableAt_iff_dist] at hs
    intro ε hε
    rcases hs ε hε with ⟨δ, hδ, hs⟩
    refine ⟨δ, hδ, fun x hx n ↦ ?_⟩
    simpa only [iterate_fixed hp n, dist_comm] using hs x hx n
  · rintro ⟨hp, hs⟩
    refine ⟨hp, ?_⟩
    rw [isForwardStableAt_iff_dist]
    intro ε hε
    rcases hs ε hε with ⟨δ, hδ, hs⟩
    refine ⟨δ, hδ, fun x hx n ↦ ?_⟩
    simpa only [iterate_fixed hp n, dist_comm] using hs x hx n

/-- Forward stability includes ordinary continuity of the one-step map at the
reference point. -/
theorem IsForwardStableAt.continuousAt [UniformSpace X]
    {f : X → X} {p : X} (h : IsForwardStableAt f p) :
    ContinuousAt f p := by
  simpa only [iterate_one] using
    (show EquicontinuousAt (fun n : ℕ ↦ f^[n]) p from h).continuousAt 1

/-- Every nonexpansive self-map is forward stable at every point. -/
theorem isForwardStableAt_of_lipschitzWith_one [PseudoMetricSpace X]
    {f : X → X} (hf : LipschitzWith 1 f) (p : X) :
    IsForwardStableAt f p := by
  rw [isForwardStableAt_iff_dist]
  intro ε hε
  refine ⟨ε, hε, fun x hx n ↦ ?_⟩
  calc
    dist (f^[n] p) (f^[n] x) ≤ dist p x := by
      simpa only [one_pow, NNReal.coe_one, one_mul] using
        (hf.iterate n).dist_le_mul p x
    _ = dist x p := dist_comm p x
    _ < ε := hx

/-- A fixed point of a nonexpansive map is Lyapunov stable. -/
theorem isLyapunovStableFixedPoint_of_lipschitzWith_one
    [PseudoMetricSpace X] {f : X → X} {p : X}
    (hf : LipschitzWith 1 f) (hp : IsFixedPt f p) :
    IsLyapunovStableFixedPoint f p :=
  ⟨hp, isForwardStableAt_of_lipschitzWith_one hf p⟩

/-- The identity map is forward stable at every point. -/
@[simp] theorem isForwardStableAt_id [PseudoMetricSpace X] (p : X) :
    IsForwardStableAt (id : X → X) p :=
  isForwardStableAt_of_lipschitzWith_one LipschitzWith.id p

/-- Translation on the real line is forward stable at every reference point. -/
theorem isForwardStableAt_add_const (c p : ℝ) :
    IsForwardStableAt (fun x : ℝ ↦ x + c) p :=
  isForwardStableAt_of_lipschitzWith_one
    (LipschitzWith.mk_one fun x y ↦ by
      simpa only [Real.dist_eq, add_sub_add_right_eq_sub] using
        (le_refl |x - y|)) p

/-- A nonzero translation exhibits a forward-stable reference orbit that is
not a fixed point. -/
theorem forwardStableAt_add_const_not_fixed {c p : ℝ} (hc : c ≠ 0) :
    IsForwardStableAt (fun x : ℝ ↦ x + c) p ∧
      ¬IsFixedPt (fun x : ℝ ↦ x + c) p := by
  refine ⟨isForwardStableAt_add_const c p, ?_⟩
  intro hp
  apply hc
  apply add_left_cancel (a := p)
  simpa [IsFixedPt] using hp

/-- The constant map with value `p` has `p` as a Lyapunov-stable fixed point. -/
theorem isLyapunovStableFixedPoint_const [PseudoMetricSpace X] (p : X) :
    IsLyapunovStableFixedPoint (fun _ : X ↦ p) p :=
  isLyapunovStableFixedPoint_of_lipschitzWith_one
    (LipschitzWith.const' p) rfl

end NonlinearDynamics.Deterministic.Discrete

#print axioms NonlinearDynamics.Deterministic.Discrete.isForwardStableAt_iff_dist
#print axioms NonlinearDynamics.Deterministic.Discrete.isLyapunovStableFixedPoint_iff_dist
#print axioms NonlinearDynamics.Deterministic.Discrete.IsForwardStableAt.continuousAt
#print axioms NonlinearDynamics.Deterministic.Discrete.isForwardStableAt_of_lipschitzWith_one
#print axioms NonlinearDynamics.Deterministic.Discrete.forwardStableAt_add_const_not_fixed
#print axioms NonlinearDynamics.Deterministic.Discrete.isLyapunovStableFixedPoint_const
