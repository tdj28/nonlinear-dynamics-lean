import Mathlib.Dynamics.Flow
import NonlinearDynamics.Deterministic.ODE.GlobalExistence

/-!
# Constructing flows from global integral curves

This module turns the unique global integral curves supplied by
`ODE.GlobalExistence` into Mathlib's topological `Flow` interface.  The
construction separates two logically different inputs:

* uniqueness proves the time-zero and time-composition laws; and
* joint continuity in time and the initial point is an explicit additional
  hypothesis.

Individual integral curves are continuous in time, but pointwise continuity of
the family does not by itself imply continuity of the uncurried map
`ℝ × M → M`.  Consequently this module does not infer continuous dependence,
smooth parameter dependence, or a differentiable flow from an existential
family of global solutions.
-/

open Function Manifold

namespace NonlinearDynamics.Deterministic.ODE

universe u v w

variable
  {E : Type u} [NormedAddCommGroup E] [NormedSpace ℝ E]
  {H : Type v} [TopologicalSpace H] {I : ModelWithCorners ℝ E H}
  {M : Type w} [TopologicalSpace M] [ChartedSpace H M] [IsManifold I 1 M]
  [T2Space M]
  {vfield : (x : M) → TangentSpace I x}

/-- The uniquely chosen global integral curve through `x`.

The definition is noncomputable because `HasUniqueGlobalIntegralCurves`
supplies the curve propositionally.  Its value is nevertheless independent of
the choice mechanism by uniqueness. -/
noncomputable def globalIntegralCurve
    (h : HasUniqueGlobalIntegralCurves vfield) (x : M) : ℝ → M :=
  Classical.choose (h x)

omit [IsManifold I 1 M] [T2Space M] in
/-- The chosen global integral curve has the requested initial value. -/
@[simp]
theorem globalIntegralCurve_zero
    (h : HasUniqueGlobalIntegralCurves vfield) (x : M) :
    globalIntegralCurve h x 0 = x :=
  (Classical.choose_spec (h x)).1.1

omit [IsManifold I 1 M] [T2Space M] in
/-- The chosen curve is a global integral curve of the vector field. -/
theorem globalIntegralCurve_isMIntegralCurve
    (h : HasUniqueGlobalIntegralCurves vfield) (x : M) :
    IsMIntegralCurve (globalIntegralCurve h x) vfield :=
  (Classical.choose_spec (h x)).1.2

omit [IsManifold I 1 M] [T2Space M] in
/-- Any global integral curve with initial value `x` is the chosen curve. -/
theorem globalIntegralCurve_eq
    (h : HasUniqueGlobalIntegralCurves vfield) {x : M} {curve : ℝ → M}
    (hcurve0 : curve 0 = x) (hcurve : IsMIntegralCurve curve vfield) :
    curve = globalIntegralCurve h x :=
  (Classical.choose_spec (h x)).2 curve ⟨hcurve0, hcurve⟩

omit [IsManifold I 1 M] [T2Space M] in
/-- Every chosen global integral curve is continuous in its time variable. -/
theorem globalIntegralCurve_continuous
    (h : HasUniqueGlobalIntegralCurves vfield) (x : M) :
    Continuous (globalIntegralCurve h x) :=
  (globalIntegralCurve_isMIntegralCurve h x).continuous

omit [IsManifold I 1 M] [T2Space M] in
/-- Translating a chosen integral curve in time agrees with restarting the
chosen curve at the translated point.  This is the ODE uniqueness argument
behind the flow composition law. -/
theorem globalIntegralCurve_add
    (h : HasUniqueGlobalIntegralCurves vfield) (t s : ℝ) (x : M) :
    globalIntegralCurve h x (t + s) =
      globalIntegralCurve h (globalIntegralCurve h x s) t := by
  let shifted : ℝ → M := globalIntegralCurve h x ∘ (· + s)
  have hshifted0 : shifted 0 = globalIntegralCurve h x s := by
    simp [shifted]
  have hshifted : IsMIntegralCurve shifted vfield :=
    (globalIntegralCurve_isMIntegralCurve h x).comp_add s
  exact congrFun (globalIntegralCurve_eq h hshifted0 hshifted) t

/-- The time-first evolution map determined by unique global integral curves. -/
noncomputable def globalIntegralCurveMap
    (h : HasUniqueGlobalIntegralCurves vfield) : ℝ → M → M :=
  fun t x ↦ globalIntegralCurve h x t

omit [IsManifold I 1 M] [T2Space M] in
/-- The evolution map fixes every point at time zero. -/
@[simp]
theorem globalIntegralCurveMap_zero
    (h : HasUniqueGlobalIntegralCurves vfield) (x : M) :
    globalIntegralCurveMap h 0 x = x :=
  globalIntegralCurve_zero h x

omit [IsManifold I 1 M] [T2Space M] in
/-- The evolution map satisfies the additive action law. -/
theorem globalIntegralCurveMap_add
    (h : HasUniqueGlobalIntegralCurves vfield) (t s : ℝ) (x : M) :
    globalIntegralCurveMap h (t + s) x =
      globalIntegralCurveMap h t (globalIntegralCurveMap h s x) :=
  globalIntegralCurve_add h t s x

/-- Joint continuity of the unique global integral-curve family in time and
initial state.  This is stronger than continuity of each individual curve and
is the precise extra gate needed by Mathlib's `Flow`. -/
def HasContinuousGlobalIntegralCurveFamily
    (h : HasUniqueGlobalIntegralCurves vfield) : Prop :=
  Continuous (uncurry (globalIntegralCurveMap h))

/-- Unique global integral curves with joint continuous dependence assemble
into a topological flow by real time. -/
noncomputable def HasUniqueGlobalIntegralCurves.toFlow
    (h : HasUniqueGlobalIntegralCurves vfield)
    (hcont : HasContinuousGlobalIntegralCurveFamily h) : Flow ℝ M where
  toFun := globalIntegralCurveMap h
  cont' := hcont
  map_add' := globalIntegralCurveMap_add h
  map_zero' := globalIntegralCurveMap_zero h

omit [IsManifold I 1 M] [T2Space M] in
/-- Evaluation of the constructed flow is evaluation of the chosen curve. -/
@[simp]
theorem HasUniqueGlobalIntegralCurves.toFlow_apply
    (h : HasUniqueGlobalIntegralCurves vfield)
    (hcont : HasContinuousGlobalIntegralCurveFamily h) (t : ℝ) (x : M) :
    h.toFlow hcont t x = globalIntegralCurve h x t :=
  rfl

/-- A flow is an integral-curve flow for a vector field when each orbit map is
a global integral curve of that field. -/
def IsIntegralCurveFlow (ϕ : Flow ℝ M)
    (vfield : (x : M) → TangentSpace I x) : Prop :=
  ∀ x : M, IsMIntegralCurve (fun t ↦ ϕ t x) vfield

omit [IsManifold I 1 M] [T2Space M] in
/-- Every orbit map of the constructed flow is the selected global integral
curve of the vector field. -/
theorem HasUniqueGlobalIntegralCurves.toFlow_isIntegralCurveFlow
    (h : HasUniqueGlobalIntegralCurves vfield)
    (hcont : HasContinuousGlobalIntegralCurveFamily h) :
    IsIntegralCurveFlow (h.toFlow hcont) vfield :=
  globalIntegralCurve_isMIntegralCurve h

omit [IsManifold I 1 M] [T2Space M] in
/-- An integral-curve flow supplies a global integral curve through every
point. -/
theorem IsIntegralCurveFlow.hasGlobalIntegralCurves
    {ϕ : Flow ℝ M} (hϕ : IsIntegralCurveFlow ϕ vfield) :
    HasGlobalIntegralCurves vfield :=
  fun x ↦ ⟨fun t ↦ ϕ t x, ϕ.map_zero_apply x, hϕ x⟩

/-- For a continuously differentiable vector field on a boundaryless
manifold, an integral-curve flow supplies unique global integral curves. -/
theorem IsIntegralCurveFlow.hasUniqueGlobalIntegralCurves
    [BoundarylessManifold I M]
    {ϕ : Flow ℝ M} (hϕ : IsIntegralCurveFlow ϕ vfield)
    (hvfield : CMDiff 1
      (fun x ↦ (⟨x, vfield x⟩ : TangentBundle I M))) :
    HasUniqueGlobalIntegralCurves vfield :=
  hϕ.hasGlobalIntegralCurves.hasUnique hvfield

#print axioms globalIntegralCurve_add
#print axioms HasUniqueGlobalIntegralCurves.toFlow
#print axioms HasUniqueGlobalIntegralCurves.toFlow_isIntegralCurveFlow
#print axioms IsIntegralCurveFlow.hasUniqueGlobalIntegralCurves

end NonlinearDynamics.Deterministic.ODE
