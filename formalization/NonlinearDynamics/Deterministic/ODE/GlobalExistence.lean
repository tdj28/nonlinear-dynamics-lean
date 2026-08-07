import Mathlib.Geometry.Manifold.IntegralCurve.UniformTime

/-!
# Global existence interfaces for ordinary differential equations

This module packages Mathlib's manifold integral-curve continuation theorems
for later use by the project's flow construction.  It keeps four propositions
separate:

* existence of a global integral curve through one point;
* existence through every point;
* existence and uniqueness through one or every point; and
* either a uniform local-time hypothesis or arbitrarily long local curves.

For a `C¹` vector field on a boundaryless manifold, one common positive local
time at every initial point yields global existence.  Smoothness then supplies
uniqueness.  At a fixed initial point, a global curve is equivalent to curves
on every symmetric finite interval.

The theorem does not infer a uniform local time from pointwise local existence.
It also makes no compactness, completeness, growth-bound, maximal-interval,
parameter-dependence, or global-flow claim.  Those require separate hypotheses
or later construction.
-/

open Function Manifold Set

namespace NonlinearDynamics.Deterministic.ODE

universe u v w

variable
  {E : Type u} [NormedAddCommGroup E] [NormedSpace ℝ E]
  {H : Type v} [TopologicalSpace H] {I : ModelWithCorners ℝ E H}
  {M : Type w} [TopologicalSpace M] [ChartedSpace H M] [IsManifold I 1 M]
  [T2Space M]
  {vfield : (x : M) → TangentSpace I x}

/-- A vector field has a global integral curve through `x` at time zero. -/
def HasGlobalIntegralCurveAt
    (vfield : (x : M) → TangentSpace I x) (x : M) : Prop :=
  ∃ curve : ℝ → M, curve 0 = x ∧ IsMIntegralCurve curve vfield

/-- A vector field has a global integral curve through every initial point. -/
def HasGlobalIntegralCurves
    (vfield : (x : M) → TangentSpace I x) : Prop :=
  ∀ x : M, HasGlobalIntegralCurveAt vfield x

/-- There is exactly one global integral curve through `x` at time zero. -/
def HasUniqueGlobalIntegralCurveAt
    (vfield : (x : M) → TangentSpace I x) (x : M) : Prop :=
  ∃! curve : ℝ → M, curve 0 = x ∧ IsMIntegralCurve curve vfield

/-- Every initial point lies on exactly one global integral curve. -/
def HasUniqueGlobalIntegralCurves
    (vfield : (x : M) → TangentSpace I x) : Prop :=
  ∀ x : M, HasUniqueGlobalIntegralCurveAt vfield x

/-- Through `x`, integral curves exist on every symmetric finite interval.
The curves for different radii are not bundled as a compatible family. -/
def HasArbitrarilyLongLocalIntegralCurvesAt
    (vfield : (x : M) → TangentSpace I x) (x : M) : Prop :=
  ∀ a : ℝ, ∃ curve : ℝ → M, curve 0 = x ∧
    IsMIntegralCurveOn curve vfield (Ioo (-a) a)

/-- One positive symmetric time interval works for a local integral curve
through every initial point. -/
def HasUniformLocalIntegralCurves
    (vfield : (x : M) → TangentSpace I x) : Prop :=
  ∃ ε : ℝ, 0 < ε ∧ ∀ x : M, ∃ curve : ℝ → M, curve 0 = x ∧
    IsMIntegralCurveOn curve vfield (Ioo (-ε) ε)

omit [IsManifold I 1 M] [T2Space M] in
/-- A global curve restricts to every symmetric finite interval. -/
theorem HasGlobalIntegralCurveAt.hasArbitrarilyLongLocalIntegralCurvesAt
    {x : M} (h : HasGlobalIntegralCurveAt vfield x) :
    HasArbitrarilyLongLocalIntegralCurvesAt vfield x := by
  rcases h with ⟨curve, hcurve0, hcurve⟩
  intro a
  exact ⟨curve, hcurve0, hcurve.isMIntegralCurveOn _⟩

/-- For a `C¹` vector field on a boundaryless manifold, arbitrarily long local
curves through one point are equivalent to one global curve through it. -/
theorem hasGlobalIntegralCurveAt_iff_hasArbitrarilyLongLocalIntegralCurvesAt
    [BoundarylessManifold I M]
    (hvfield : CMDiff 1
      (fun x ↦ (⟨x, vfield x⟩ : TangentBundle I M))) (x : M) :
    HasGlobalIntegralCurveAt vfield x ↔
      HasArbitrarilyLongLocalIntegralCurvesAt vfield x := by
  simpa [HasGlobalIntegralCurveAt,
    HasArbitrarilyLongLocalIntegralCurvesAt] using
    (exists_isMIntegralCurve_iff_exists_isMIntegralCurveOn_Ioo hvfield x)

/-- Smooth global integral curves through the same initial point are unique. -/
theorem HasGlobalIntegralCurveAt.hasUnique
    [BoundarylessManifold I M]
    (hvfield : CMDiff 1
      (fun x ↦ (⟨x, vfield x⟩ : TangentBundle I M)))
    {x : M} (h : HasGlobalIntegralCurveAt vfield x) :
    HasUniqueGlobalIntegralCurveAt vfield x := by
  rcases h with ⟨curve, hcurve0, hcurve⟩
  refine ⟨curve, ⟨hcurve0, hcurve⟩, ?_⟩
  intro other hother
  exact isMIntegralCurve_Ioo_eq_of_contMDiff_boundaryless
    hvfield hother.2 hcurve (hother.1.trans hcurve0.symm)

/-- Smooth global existence through every point upgrades to unique global
existence through every point. -/
theorem HasGlobalIntegralCurves.hasUnique
    [BoundarylessManifold I M]
    (hvfield : CMDiff 1
      (fun x ↦ (⟨x, vfield x⟩ : TangentBundle I M)))
    (h : HasGlobalIntegralCurves vfield) :
    HasUniqueGlobalIntegralCurves vfield :=
  fun x ↦ (h x).hasUnique hvfield

/-- A uniform positive local existence time yields a global integral curve
through every point. -/
theorem HasUniformLocalIntegralCurves.hasGlobalIntegralCurves
    [BoundarylessManifold I M]
    (hvfield : CMDiff 1
      (fun x ↦ (⟨x, vfield x⟩ : TangentBundle I M)))
    (h : HasUniformLocalIntegralCurves vfield) :
    HasGlobalIntegralCurves vfield := by
  rcases h with ⟨ε, hε, hlocal⟩
  intro x
  exact exists_isMIntegralCurve_of_isMIntegralCurveOn hvfield hε hlocal x

/-- Under the smooth boundaryless hypotheses, uniform local existence gives
unique global integral curves. -/
theorem HasUniformLocalIntegralCurves.hasUniqueGlobalIntegralCurves
    [BoundarylessManifold I M]
    (hvfield : CMDiff 1
      (fun x ↦ (⟨x, vfield x⟩ : TangentBundle I M)))
    (h : HasUniformLocalIntegralCurves vfield) :
    HasUniqueGlobalIntegralCurves vfield :=
  (h.hasGlobalIntegralCurves hvfield).hasUnique hvfield

omit [IsManifold I 1 M] [T2Space M] in
/-- Global existence supplies a uniform local interval, for example radius
one, without any smoothness hypothesis. -/
theorem HasGlobalIntegralCurves.hasUniformLocalIntegralCurves
    (h : HasGlobalIntegralCurves vfield) :
    HasUniformLocalIntegralCurves vfield := by
  refine ⟨1, zero_lt_one, ?_⟩
  intro x
  rcases h x with ⟨curve, hcurve0, hcurve⟩
  exact ⟨curve, hcurve0, hcurve.isMIntegralCurveOn _⟩

/-- For a `C¹` field on a boundaryless manifold, global existence through all
points is equivalent to one uniform positive local-time radius. -/
theorem hasGlobalIntegralCurves_iff_hasUniformLocalIntegralCurves
    [BoundarylessManifold I M]
    (hvfield : CMDiff 1
      (fun x ↦ (⟨x, vfield x⟩ : TangentBundle I M))) :
    HasGlobalIntegralCurves vfield ↔ HasUniformLocalIntegralCurves vfield :=
  ⟨HasGlobalIntegralCurves.hasUniformLocalIntegralCurves,
    fun h ↦ h.hasGlobalIntegralCurves hvfield⟩

omit [IsManifold I 1 M] [T2Space M] in
/-- A zero of a vector field lies on the constant global integral curve. -/
theorem hasGlobalIntegralCurveAt_of_eq_zero {x : M} (hx : vfield x = 0) :
    HasGlobalIntegralCurveAt vfield x :=
  ⟨fun _ ↦ x, rfl, isMIntegralCurve_const hx⟩

omit [IsManifold I 1 M] [T2Space M] in
/-- The zero vector field has a constant global integral curve through every
point. -/
theorem zeroVectorField_hasGlobalIntegralCurves :
    HasGlobalIntegralCurves (I := I)
      (fun x : M ↦ (0 : TangentSpace I x)) :=
  fun _ ↦ hasGlobalIntegralCurveAt_of_eq_zero rfl

#print axioms hasGlobalIntegralCurveAt_iff_hasArbitrarilyLongLocalIntegralCurvesAt
#print axioms HasUniformLocalIntegralCurves.hasGlobalIntegralCurves
#print axioms HasUniformLocalIntegralCurves.hasUniqueGlobalIntegralCurves
#print axioms zeroVectorField_hasGlobalIntegralCurves

end NonlinearDynamics.Deterministic.ODE
