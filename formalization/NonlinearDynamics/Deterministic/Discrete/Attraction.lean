import NonlinearDynamics.Deterministic.Discrete.Stability
import Mathlib.Topology.MetricSpace.Contracting
import Mathlib.Topology.MetricSpace.HausdorffDistance

/-!
# Attraction and basins for deterministic discrete-time systems

This module separates three ideas that are often compressed into the word
"attractor".  An orbit is attracted to a point when its natural-number
iterates converge to that point.  The basin is the set of initial conditions
with that limit.  A locally attracting fixed point is fixed and has its basin
as a neighborhood; an asymptotically stable fixed point is both Lyapunov
stable and locally attracting.

For a nonempty set, attraction means that the distance from the orbit to the
set tends to zero.  A locally attracting set is additionally forward
invariant and has a basin that is a neighborhood of each of its points.  The
nonempty hypothesis is explicit because Mathlib totalizes `Metric.infDist` at
the empty set as zero.

The set interface is pointwise in the initial condition.  It does not assert
uniform attraction of bounded sets, Hausdorff convergence, compactness,
closedness, equality invariance, an attraction rate, or Lyapunov stability of
an invariant set.
-/

open Filter Function Topology

namespace NonlinearDynamics.Deterministic.Discrete

universe u

variable {X : Type u}

/-- The forward orbit of `x` is attracted to `p` when its iterates converge to
`p`.  Fixedness of `p` is deliberately not built into this orbit-level
relation. -/
def IsAttractedTo [TopologicalSpace X]
    (f : X → X) (x p : X) : Prop :=
  Tendsto (fun n : ℕ ↦ f^[n] x) atTop (𝓝 p)

/-- The basin of a point is the set of initial states whose forward orbits
converge to that point. -/
def basinOfAttraction [TopologicalSpace X]
    (f : X → X) (p : X) : Set X :=
  {x | IsAttractedTo f x p}

/-- A locally attracting fixed point is fixed and has its basin as a
neighborhood.  Attraction is not strengthened to stability here. -/
def IsLocallyAttractingFixedPoint [TopologicalSpace X]
    (f : X → X) (p : X) : Prop :=
  IsFixedPt f p ∧ basinOfAttraction f p ∈ 𝓝 p

/-- A globally attracting fixed point attracts every initial state. -/
def IsGloballyAttractingFixedPoint [TopologicalSpace X]
    (f : X → X) (p : X) : Prop :=
  IsFixedPt f p ∧ ∀ x, IsAttractedTo f x p

/-- An asymptotically stable fixed point is Lyapunov stable and locally
attracting.  This definition keeps stability and attraction as separate
proof obligations. -/
def IsAsymptoticallyStableFixedPoint [UniformSpace X]
    (f : X → X) (p : X) : Prop :=
  IsLyapunovStableFixedPoint f p ∧ basinOfAttraction f p ∈ 𝓝 p

@[simp] theorem mem_basinOfAttraction [TopologicalSpace X]
    {f : X → X} {x p : X} :
    x ∈ basinOfAttraction f p ↔ IsAttractedTo f x p :=
  Iff.rfl

/-- In a pseudo-metric space, attraction to a point is exactly convergence of
the orbit-to-target distance to zero. -/
theorem isAttractedTo_iff_dist [PseudoMetricSpace X]
    {f : X → X} {x p : X} :
    IsAttractedTo f x p ↔
      Tendsto (fun n : ℕ ↦ dist (f^[n] x) p) atTop (𝓝 0) :=
  tendsto_iff_dist_tendsto_zero

/-- A fixed point attracts its own constant orbit. -/
theorem IsFixedPt.isAttractedTo [TopologicalSpace X]
    {f : X → X} {p : X} (hp : IsFixedPt f p) :
    IsAttractedTo f p p := by
  exact tendsto_const_nhds.congr fun n ↦ (iterate_fixed hp n).symm

/-- If an orbit converges to `p` and `f` is continuous at `p`, then `p` is
fixed.  Thus fixedness follows from attraction only with a continuity and
Hausdorff-separation gate. -/
theorem IsAttractedTo.isFixedPt_of_continuousAt
    [TopologicalSpace X] [T2Space X]
    {f : X → X} {x p : X} (hxp : IsAttractedTo f x p)
    (hf : ContinuousAt f p) : IsFixedPt f p :=
  isFixedPt_of_tendsto_iterate hxp hf

/-- Global attraction implies local attraction. -/
theorem IsGloballyAttractingFixedPoint.isLocallyAttractingFixedPoint
    [TopologicalSpace X] {f : X → X} {p : X}
    (h : IsGloballyAttractingFixedPoint f p) :
    IsLocallyAttractingFixedPoint f p :=
  ⟨h.1, Filter.Eventually.of_forall h.2⟩

/-- The asymptotic-stability definition is exactly Lyapunov stability plus
local attraction. -/
theorem isAsymptoticallyStableFixedPoint_iff [UniformSpace X]
    {f : X → X} {p : X} :
    IsAsymptoticallyStableFixedPoint f p ↔
      IsLyapunovStableFixedPoint f p ∧
        IsLocallyAttractingFixedPoint f p := by
  simp only [IsAsymptoticallyStableFixedPoint,
    IsLocallyAttractingFixedPoint, IsLyapunovStableFixedPoint]
  tauto

/-- Banach's contraction theorem supplies a globally attracting fixed point on
a nonempty complete metric space. -/
theorem isGloballyAttractingFixedPoint_fixedPoint
    [MetricSpace X] [CompleteSpace X] [Nonempty X]
    {K : NNReal} {f : X → X} (hf : ContractingWith K f) :
    IsGloballyAttractingFixedPoint f (ContractingWith.fixedPoint f hf) :=
  ⟨hf.fixedPoint_isFixedPt, fun x ↦ hf.tendsto_iterate_fixedPoint x⟩

/-- The fixed point of a contraction is asymptotically stable: contraction
gives both nonexpansive forward stability and global attraction. -/
theorem isAsymptoticallyStableFixedPoint_fixedPoint
    [MetricSpace X] [CompleteSpace X] [Nonempty X]
    {K : NNReal} {f : X → X} (hf : ContractingWith K f) :
    IsAsymptoticallyStableFixedPoint f
      (ContractingWith.fixedPoint f hf) := by
  refine ⟨isLyapunovStableFixedPoint_of_lipschitzWith_one
    (hf.toLipschitzWith.weaken hf.1.le) hf.fixedPoint_isFixedPt, ?_⟩
  exact Filter.Eventually.of_forall fun x ↦ hf.tendsto_iterate_fixedPoint x

/-- The constant map with value `p` has `p` as a globally attracting fixed
point. -/
theorem isGloballyAttractingFixedPoint_const [TopologicalSpace X] (p : X) :
    IsGloballyAttractingFixedPoint (fun _ : X ↦ p) p := by
  refine ⟨rfl, fun x ↦ ?_⟩
  refine tendsto_const_nhds.congr' <|
    (eventually_ge_atTop 1).mono fun n hn ↦ ?_
  obtain ⟨k, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (Nat.ne_of_gt hn)
  exact (iterate_fixed (f := fun _ : X ↦ p) rfl k).symm

/-- A nonempty set attracts an orbit when the distance from the orbit to the
set tends to zero.  Nonemptiness prevents the totalized empty-set distance
from making every orbit vacuously attracted. -/
def IsAttractedToSet [PseudoMetricSpace X]
    (f : X → X) (x : X) (A : Set X) : Prop :=
  A.Nonempty ∧
    Tendsto (fun n : ℕ ↦ Metric.infDist (f^[n] x) A) atTop (𝓝 0)

/-- The basin of a set consists of the initial states attracted to that set. -/
def basinOfAttractionSet [PseudoMetricSpace X]
    (f : X → X) (A : Set X) : Set X :=
  {x | IsAttractedToSet f x A}

/-- A locally attracting set is nonempty, forward invariant, and has a basin
that is a neighborhood of each point of the set. -/
def IsLocallyAttractingSet [PseudoMetricSpace X]
    (f : X → X) (A : Set X) : Prop :=
  A.Nonempty ∧ Set.MapsTo f A A ∧
    ∀ p ∈ A, basinOfAttractionSet f A ∈ 𝓝 p

@[simp] theorem mem_basinOfAttractionSet [PseudoMetricSpace X]
    {f : X → X} {x : X} {A : Set X} :
    x ∈ basinOfAttractionSet f A ↔ IsAttractedToSet f x A :=
  Iff.rfl

/-- Attraction to a singleton set is exactly attraction to its point. -/
theorem isAttractedToSet_singleton_iff [PseudoMetricSpace X]
    {f : X → X} {x p : X} :
    IsAttractedToSet f x {p} ↔ IsAttractedTo f x p := by
  simp only [IsAttractedToSet, Set.singleton_nonempty, true_and,
    Metric.infDist_singleton, isAttractedTo_iff_dist]

/-- The singleton-set basin agrees exactly with the point basin. -/
theorem basinOfAttractionSet_singleton [PseudoMetricSpace X]
    {f : X → X} {p : X} :
    basinOfAttractionSet f {p} = basinOfAttraction f p := by
  ext x
  exact isAttractedToSet_singleton_iff

/-- A locally attracting singleton set is exactly a locally attracting fixed
point. -/
theorem isLocallyAttractingSet_singleton_iff [PseudoMetricSpace X]
    {f : X → X} {p : X} :
    IsLocallyAttractingSet f {p} ↔
      IsLocallyAttractingFixedPoint f p := by
  simp only [IsLocallyAttractingSet, Set.singleton_nonempty, true_and,
    Set.mapsTo_singleton, Set.mem_singleton_iff,
    IsLocallyAttractingFixedPoint, basinOfAttractionSet_singleton, forall_eq]
  rfl

end NonlinearDynamics.Deterministic.Discrete

#print axioms NonlinearDynamics.Deterministic.Discrete.isAttractedTo_iff_dist
#print axioms NonlinearDynamics.Deterministic.Discrete.IsAttractedTo.isFixedPt_of_continuousAt
#print axioms NonlinearDynamics.Deterministic.Discrete.isAsymptoticallyStableFixedPoint_iff
#print axioms NonlinearDynamics.Deterministic.Discrete.isGloballyAttractingFixedPoint_fixedPoint
#print axioms NonlinearDynamics.Deterministic.Discrete.isAsymptoticallyStableFixedPoint_fixedPoint
#print axioms NonlinearDynamics.Deterministic.Discrete.isLocallyAttractingSet_singleton_iff
