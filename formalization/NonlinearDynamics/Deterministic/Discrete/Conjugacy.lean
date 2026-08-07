import NonlinearDynamics.Deterministic.Discrete.Attraction
import Mathlib.Dynamics.PeriodicPts.Defs
import Mathlib.Topology.Homeomorph.Lemmas

/-!
# Conjugacies and semiconjugacies for deterministic discrete-time systems

This module separates the algebraic orbit identity from the topological data
used to transport limiting behavior.  Mathlib's `Function.Semiconj φ f g`
states only that `φ (f x) = g (φ x)`.  Iterating this identity maps every
forward `f`-orbit to a forward `g`-orbit, with no continuity or surjectivity
assumption.

A topological semiconjugacy adds continuity.  A topological factor map also
adds surjectivity, so every target orbit has a source representative.  A
topological conjugacy uses a homeomorphism and therefore supplies a continuous
inverse whose semiconjugacy equation runs in the opposite direction.

The conclusions below concern fixed points, periodic points, point attraction,
basins, and local or global attracting fixed points.  They do not claim that a
homeomorphism preserves the project's uniform-space forward-stability
predicate.  Such a result needs hypotheses controlling the relevant
uniformities, not only the topologies.
-/

open Filter Function Set Topology

namespace NonlinearDynamics.Deterministic.Discrete

universe u v w

variable {X : Type u} {Y : Type v} {Z : Type w}

/-- A continuous map whose values intertwine the two dynamics.  Surjectivity
is deliberately not included. -/
def IsTopologicalSemiconjugacy [TopologicalSpace X] [TopologicalSpace Y]
    (φ : X → Y) (f : X → X) (g : Y → Y) : Prop :=
  Continuous φ ∧ Semiconj φ f g

/-- A topological factor map is a continuous surjective semiconjugacy. -/
def IsTopologicalFactorMap [TopologicalSpace X] [TopologicalSpace Y]
    (φ : X → Y) (f : X → X) (g : Y → Y) : Prop :=
  IsTopologicalSemiconjugacy φ f g ∧ Surjective φ

/-- A specified topological conjugacy is a homeomorphism that intertwines the
two self-maps. -/
def IsTopologicalConjugacy [TopologicalSpace X] [TopologicalSpace Y]
    (e : X ≃ₜ Y) (f : X → X) (g : Y → Y) : Prop :=
  Semiconj e f g

/-- Two self-maps are topologically conjugate when some homeomorphism
intertwines them. -/
def AreTopologicallyConjugate [TopologicalSpace X] [TopologicalSpace Y]
    (f : X → X) (g : Y → Y) : Prop :=
  ∃ e : X ≃ₜ Y, IsTopologicalConjugacy e f g

/-- A semiconjugacy intertwines every natural-number iterate, including time
zero. -/
theorem semiconj_iterate_apply {φ : X → Y} {f : X → X} {g : Y → Y}
    (h : Semiconj φ f g) (n : ℕ) (x : X) :
    φ (f^[n] x) = g^[n] (φ x) :=
  (h.iterate_right n).eq x

/-- A semiconjugacy transports attraction forward when its map is continuous
at the limiting source point. -/
theorem IsAttractedTo.map_semiconj
    [TopologicalSpace X] [TopologicalSpace Y]
    {φ : X → Y} {f : X → X} {g : Y → Y} {x p : X}
    (hxp : IsAttractedTo f x p) (hφ : ContinuousAt φ p)
    (hsem : Semiconj φ f g) : IsAttractedTo g (φ x) (φ p) := by
  rw [IsAttractedTo] at hxp ⊢
  exact (hφ.tendsto.comp hxp).congr'
    (Filter.Eventually.of_forall fun n ↦ semiconj_iterate_apply hsem n x)

/-- Continuous semiconjugacy sends an attracted source orbit to an attracted
target orbit.  Continuity is used at the limiting point. -/
theorem IsTopologicalSemiconjugacy.map_isAttractedTo
    [TopologicalSpace X] [TopologicalSpace Y]
    {φ : X → Y} {f : X → X} {g : Y → Y} {x p : X}
    (h : IsTopologicalSemiconjugacy φ f g)
    (hxp : IsAttractedTo f x p) : IsAttractedTo g (φ x) (φ p) :=
  hxp.map_semiconj h.1.continuousAt h.2

/-- A topological factor of a globally attracting fixed-point system has the
image fixed point as a global attractor. -/
theorem IsTopologicalFactorMap.map_isGloballyAttractingFixedPoint
    [TopologicalSpace X] [TopologicalSpace Y]
    {φ : X → Y} {f : X → X} {g : Y → Y} {p : X}
    (h : IsTopologicalFactorMap φ f g)
    (hp : IsGloballyAttractingFixedPoint f p) :
    IsGloballyAttractingFixedPoint g (φ p) := by
  refine ⟨hp.1.map h.1.2, fun y ↦ ?_⟩
  rcases h.2 y with ⟨x, rfl⟩
  exact h.1.map_isAttractedTo (hp.2 x)

/-- The inverse homeomorphism conjugates the target system back to the source
system. -/
theorem IsTopologicalConjugacy.symm
    [TopologicalSpace X] [TopologicalSpace Y]
    {e : X ≃ₜ Y} {f : X → X} {g : Y → Y}
    (h : IsTopologicalConjugacy e f g) :
    IsTopologicalConjugacy e.symm g f :=
  h.inverse_left e.symm_apply_apply e.apply_symm_apply

/-- Topological conjugacies compose. -/
theorem IsTopologicalConjugacy.trans
    [TopologicalSpace X] [TopologicalSpace Y] [TopologicalSpace Z]
    {e : X ≃ₜ Y} {e' : Y ≃ₜ Z}
    {f : X → X} {g : Y → Y} {k : Z → Z}
    (h : IsTopologicalConjugacy e f g)
    (h' : IsTopologicalConjugacy e' g k) :
    IsTopologicalConjugacy (e.trans e') f k := by
  intro x
  change e' (e (f x)) = k (e' (e x))
  rw [h x]
  exact h' (e x)

/-- A conjugacy identifies fixed points pointwise. -/
theorem IsTopologicalConjugacy.isFixedPt_iff
    [TopologicalSpace X] [TopologicalSpace Y]
    {e : X ≃ₜ Y} {f : X → X} {g : Y → Y} {p : X}
    (h : IsTopologicalConjugacy e f g) :
    IsFixedPt f p ↔ IsFixedPt g (e p) := by
  constructor
  · exact fun hp ↦ hp.map h
  · intro hp
    simpa using hp.map h.symm

/-- A conjugacy identifies points having any specified natural-number period.
This is a statement about a period, not necessarily the least period. -/
theorem IsTopologicalConjugacy.isPeriodicPt_iff
    [TopologicalSpace X] [TopologicalSpace Y]
    {e : X ≃ₜ Y} {f : X → X} {g : Y → Y} {p : X} {n : ℕ}
    (h : IsTopologicalConjugacy e f g) :
    IsPeriodicPt f n p ↔ IsPeriodicPt g n (e p) := by
  constructor
  · exact fun hp ↦ hp.map h
  · intro hp
    simpa using hp.map h.symm

/-- A topological conjugacy identifies attraction of corresponding point
orbits.  Both directions use continuity, once for the homeomorphism and once
for its inverse. -/
theorem IsTopologicalConjugacy.isAttractedTo_iff
    [TopologicalSpace X] [TopologicalSpace Y]
    {e : X ≃ₜ Y} {f : X → X} {g : Y → Y} {x p : X}
    (h : IsTopologicalConjugacy e f g) :
    IsAttractedTo f x p ↔ IsAttractedTo g (e x) (e p) := by
  constructor
  · exact fun hxp ↦
      (show IsTopologicalSemiconjugacy (e : X → Y) f g from
        ⟨e.continuous, h⟩).map_isAttractedTo hxp
  · intro hxp
    have hback :=
      (show IsTopologicalSemiconjugacy (e.symm : Y → X) g f from
        ⟨e.symm.continuous, h.symm⟩).map_isAttractedTo hxp
    simpa using hback

/-- The preimage of the target basin is exactly the source basin. -/
theorem IsTopologicalConjugacy.basin_preimage
    [TopologicalSpace X] [TopologicalSpace Y]
    {e : X ≃ₜ Y} {f : X → X} {g : Y → Y} {p : X}
    (h : IsTopologicalConjugacy e f g) :
    e ⁻¹' basinOfAttraction g (e p) = basinOfAttraction f p := by
  ext x
  exact h.isAttractedTo_iff.symm

/-- A conjugacy maps a point basin onto the corresponding point basin. -/
theorem IsTopologicalConjugacy.image_basin
    [TopologicalSpace X] [TopologicalSpace Y]
    {e : X ≃ₜ Y} {f : X → X} {g : Y → Y} {p : X}
    (h : IsTopologicalConjugacy e f g) :
    e '' basinOfAttraction f p = basinOfAttraction g (e p) := by
  ext y
  constructor
  · rintro ⟨x, hx, rfl⟩
    exact h.isAttractedTo_iff.1 hx
  · intro hy
    refine ⟨e.symm y, ?_, e.apply_symm_apply y⟩
    apply h.isAttractedTo_iff.2
    simpa using hy

/-- A conjugacy identifies local attraction of corresponding fixed points. -/
theorem IsTopologicalConjugacy.isLocallyAttractingFixedPoint_iff
    [TopologicalSpace X] [TopologicalSpace Y]
    {e : X ≃ₜ Y} {f : X → X} {g : Y → Y} {p : X}
    (h : IsTopologicalConjugacy e f g) :
    IsLocallyAttractingFixedPoint f p ↔
      IsLocallyAttractingFixedPoint g (e p) := by
  constructor
  · rintro ⟨hp, hbasin⟩
    refine ⟨hp.map h, ?_⟩
    rw [← h.image_basin]
    exact e.isOpenMap.image_mem_nhds hbasin
  · rintro ⟨hp, hbasin⟩
    refine ⟨?_, ?_⟩
    · simpa using hp.map h.symm
    · rw [← show e.symm '' basinOfAttraction g (e p) =
          basinOfAttraction f p by
        simpa using h.symm.image_basin (p := e p)]
      simpa using e.symm.isOpenMap.image_mem_nhds hbasin

/-- A conjugacy identifies global attraction of corresponding fixed points. -/
theorem IsTopologicalConjugacy.isGloballyAttractingFixedPoint_iff
    [TopologicalSpace X] [TopologicalSpace Y]
    {e : X ≃ₜ Y} {f : X → X} {g : Y → Y} {p : X}
    (h : IsTopologicalConjugacy e f g) :
    IsGloballyAttractingFixedPoint f p ↔
      IsGloballyAttractingFixedPoint g (e p) := by
  constructor
  · exact fun hp ↦
      (show IsTopologicalFactorMap (e : X → Y) f g from
        ⟨⟨e.continuous, h⟩, e.surjective⟩).map_isGloballyAttractingFixedPoint hp
  · intro hg
    have hback :=
      (show IsTopologicalFactorMap (e.symm : Y → X) g f from
        ⟨⟨e.symm.continuous, h.symm⟩, e.symm.surjective⟩).map_isGloballyAttractingFixedPoint hg
    simpa using hback

/-- Every system is topologically conjugate to itself. -/
@[refl] theorem areTopologicallyConjugate_refl [TopologicalSpace X]
    (f : X → X) : AreTopologicallyConjugate f f :=
  ⟨Homeomorph.refl X, Semiconj.id_left⟩

/-- Topological conjugacy is symmetric. -/
@[symm] theorem AreTopologicallyConjugate.symm
    [TopologicalSpace X] [TopologicalSpace Y]
    {f : X → X} {g : Y → Y}
    (h : AreTopologicallyConjugate f g) :
    AreTopologicallyConjugate g f := by
  rcases h with ⟨e, he⟩
  exact ⟨e.symm, he.symm⟩

/-- Topological conjugacy is transitive across state spaces. -/
@[trans] theorem AreTopologicallyConjugate.trans
    [TopologicalSpace X] [TopologicalSpace Y] [TopologicalSpace Z]
    {f : X → X} {g : Y → Y} {k : Z → Z}
    (h : AreTopologicallyConjugate f g)
    (h' : AreTopologicallyConjugate g k) :
    AreTopologicallyConjugate f k := by
  rcases h with ⟨e, he⟩
  rcases h' with ⟨e', he'⟩
  exact ⟨e.trans e', he.trans he'⟩

end NonlinearDynamics.Deterministic.Discrete

#print axioms NonlinearDynamics.Deterministic.Discrete.semiconj_iterate_apply
#print axioms NonlinearDynamics.Deterministic.Discrete.IsTopologicalFactorMap.map_isGloballyAttractingFixedPoint
#print axioms NonlinearDynamics.Deterministic.Discrete.IsTopologicalConjugacy.isPeriodicPt_iff
#print axioms NonlinearDynamics.Deterministic.Discrete.IsTopologicalConjugacy.isAttractedTo_iff
#print axioms NonlinearDynamics.Deterministic.Discrete.IsTopologicalConjugacy.isLocallyAttractingFixedPoint_iff
#print axioms NonlinearDynamics.Deterministic.Discrete.AreTopologicallyConjugate.trans
