import Mathlib.Dynamics.Transitive
import Mathlib.Topology.MetricSpace.HausdorffDistance
import NonlinearDynamics.Deterministic.Chaos.Sensitivity

/-!
# Devaney chaos and the Banks implication

This module separates Devaney's original three-part definition from the
topological core that later makes its sensitivity clause redundant.  The core
requires continuity, open-set topological transitivity, and a dense set of
positive-period periodic points.  The metric predicate additionally requires
the fixed-scale sensitivity interface from `Chaos.Sensitivity`.

The main theorem follows Banks, Brooks, Cairns, Davis, and Stacey: on an
infinite genuine metric space, the continuous topological core implies
sensitivity.  A true metric is essential because the argument separates two
disjoint finite periodic orbits by a positive distance.  Infinity is also
essential: a finite cyclic permutation is transitive and has every point
periodic, but no self-map of a finite metric space is sensitive.

Topological transitivity below requires a positive iterate.  This matches
Devaney's stated convention and keeps the identity element of Mathlib's
generic iterate action from silently supplying a time-zero witness.
-/

open Filter Function Set Topology

namespace NonlinearDynamics.Deterministic.Chaos

universe u

variable {X : Type u}

/-- A self-map is topologically transitive when every ordered pair of nonempty
open sets is connected by some positive iterate of a point from the first set.
Nonemptiness is explicit so that the empty phase space does not satisfy the
predicate vacuously. -/
def IsTopologicallyTransitive [TopologicalSpace X] (f : X → X) : Prop :=
  Nonempty X ∧
    ∀ ⦃U V : Set X⦄, IsOpen U → U.Nonempty → IsOpen V → V.Nonempty →
      ∃ n : ℕ, 0 < n ∧ ∃ x ∈ U, f^[n] x ∈ V

/-- A self-map has dense periodic points when Mathlib's set of points having
some positive period is dense.  Nonemptiness is explicit to exclude the empty
phase space. -/
def HasDensePeriodicPoints [TopologicalSpace X] (f : X → X) : Prop :=
  Nonempty X ∧ Dense (periodicPts f)

/-- The continuous topological core of Devaney chaos.  Sensitivity is kept out
of this predicate so that the Banks implication remains a theorem with visible
metric and infinitude hypotheses. -/
def HasDevaneyCore [TopologicalSpace X] (f : X → X) : Prop :=
  Continuous f ∧ IsTopologicallyTransitive f ∧ HasDensePeriodicPoints f

/-- Devaney's original three-part chaoticity package: the continuous
topological core together with sensitive dependence on initial conditions. -/
def IsDevaneyChaotic [PseudoMetricSpace X] (f : X → X) : Prop :=
  HasDevaneyCore f ∧ IsSensitive f

/-- Unpack the open-set witness supplied by topological transitivity. -/
theorem IsTopologicallyTransitive.exists_pos_iterate_mem [TopologicalSpace X]
    {f : X → X} (h : IsTopologicallyTransitive f)
    {U V : Set X} (hUo : IsOpen U) (hUne : U.Nonempty)
    (hVo : IsOpen V) (hVne : V.Nonempty) :
    ∃ n : ℕ, 0 < n ∧ ∃ x ∈ U, f^[n] x ∈ V :=
  h.2 hUo hUne hVo hVne

/-- Dense positive-period points meet every nonempty open set. -/
theorem HasDensePeriodicPoints.exists_mem_open [TopologicalSpace X]
    {f : X → X} (h : HasDensePeriodicPoints f)
    {U : Set X} (hUo : IsOpen U) (hUne : U.Nonempty) :
    ∃ x ∈ periodicPts f, x ∈ U :=
  h.2.exists_mem_open hUo hUne

/-- Expanded form of the preceding open-set theorem, including a positive
period witness for the selected point. -/
theorem HasDensePeriodicPoints.exists_isPeriodicPt_mem_open [TopologicalSpace X]
    {f : X → X} (h : HasDensePeriodicPoints f)
    {U : Set X} (hUo : IsOpen U) (hUne : U.Nonempty) :
    ∃ x ∈ U, ∃ n : ℕ, 0 < n ∧ IsPeriodicPt f n x := by
  rcases h.exists_mem_open hUo hUne with ⟨x, hxper, hxU⟩
  rcases hxper with ⟨n, hn, hperiod⟩
  exact ⟨x, hxU, n, hn, hperiod⟩

/-- Points on the same positive periodic orbit have the same finite periodic
orbit cycle. -/
theorem periodicOrbit_eq_of_mem
    {f : X → X} {p q : X} (hp : p ∈ periodicPts f)
    (hq : q ∈ periodicOrbit f p) :
    periodicOrbit f q = periodicOrbit f p := by
  rw [mem_periodicOrbit_iff hp] at hq
  rcases hq with ⟨n, rfl⟩
  exact periodicOrbit_apply_iterate_eq hp n

private theorem mem_cycle_toFinset_iff [DecidableEq X]
    {s : Cycle X} {z : X} : z ∈ (↑s.toFinset : Set X) ↔ z ∈ s := by
  induction s using Quotient.inductionOn'
  simp only [Cycle.mk''_eq_coe, Cycle.coe_toFinset, Finset.mem_coe,
    List.mem_toFinset, Cycle.mem_coe_iff]

private theorem exists_two_disjoint_periodicOrbits [MetricSpace X] [Infinite X]
    [DecidableEq X]
    {f : X → X} (hdense : Dense (periodicPts f)) :
    ∃ p q : X, p ∈ periodicPts f ∧ q ∈ periodicPts f ∧
      Disjoint
        (↑(periodicOrbit f p).toFinset : Set X)
        (↑(periodicOrbit f q).toFinset : Set X) := by
  classical
  rcases hdense.nonempty with ⟨p, hp⟩
  let P : Set X := ↑(periodicOrbit f p).toFinset
  have hPfinite : P.Finite := (periodicOrbit f p).toFinset.finite_toSet
  have hPcompl : Pᶜ.Nonempty := hPfinite.infinite_compl.nonempty
  rcases hdense.exists_mem_open hPfinite.isClosed.isOpen_compl hPcompl with
    ⟨q, hq, hqP⟩
  refine ⟨p, q, hp, hq, Set.disjoint_left.mpr ?_⟩
  intro z hzp hzq
  have hzp' : z ∈ periodicOrbit f p := mem_cycle_toFinset_iff.mp hzp
  have hzq' : z ∈ periodicOrbit f q := mem_cycle_toFinset_iff.mp hzq
  have horbits : periodicOrbit f p = periodicOrbit f q :=
    (periodicOrbit_eq_of_mem hp hzp').symm.trans
      (periodicOrbit_eq_of_mem hq hzq')
  have hq_in_p : q ∈ periodicOrbit f p := by
    rw [horbits]
    exact self_mem_periodicOrbit hq
  exact hqP (mem_cycle_toFinset_iff.mpr hq_in_p)

private theorem exists_periodicOrbit_far [MetricSpace X] [Infinite X]
    {f : X → X} (hdense : Dense (periodicPts f)) :
    ∃ δ : ℝ, 0 < δ ∧ ∀ x : X, ∃ q ∈ periodicPts f,
      ∀ m : ℕ, 4 * δ ≤ dist x (f^[m] q) := by
  classical
  rcases exists_two_disjoint_periodicOrbits hdense with
    ⟨p, q, hp, hq, hpq⟩
  let P : Set X := ↑(periodicOrbit f p).toFinset
  let Q : Set X := ↑(periodicOrbit f q).toFinset
  have hPcompact : IsCompact P := (periodicOrbit f p).toFinset.finite_toSet.isCompact
  have hQclosed : IsClosed Q := (periodicOrbit f q).toFinset.finite_toSet.isClosed
  obtain ⟨r, hr, hsep⟩ := Metric.exists_pos_forall_lt_edist hPcompact hQclosed
    (by simpa only [P, Q] using hpq)
  let δ : ℝ := (r : ℝ) / 8
  have hδ : 0 < δ := by positivity
  refine ⟨δ, hδ, fun x ↦ ?_⟩
  by_cases hfarP : ∀ a ∈ P, 4 * δ ≤ dist x a
  · refine ⟨p, hp, fun m ↦ hfarP _ ?_⟩
    have hm := iterate_mem_periodicOrbit hp m
    exact mem_cycle_toFinset_iff.mpr hm
  · push Not at hfarP
    rcases hfarP with ⟨a, haP, hax⟩
    refine ⟨q, hq, fun m ↦ ?_⟩
    have hfmQ : f^[m] q ∈ Q := by
      have hm := iterate_mem_periodicOrbit hq m
      exact mem_cycle_toFinset_iff.mpr hm
    by_contra hnot
    have hxb : dist x (f^[m] q) < 4 * δ := lt_of_not_ge hnot
    have hab_edist := hsep a haP (f^[m] q) hfmQ
    have hab : (r : ℝ) < dist a (f^[m] q) := by
      rw [edist_dist] at hab_edist
      exact ENNReal.coe_lt_ofReal.mp hab_edist
    have htriangle := dist_triangle a x (f^[m] q)
    rw [dist_comm a x] at htriangle
    dsimp [δ] at hax hxb
    linarith

/-- The Banks--Brooks--Cairns--Davis--Stacey implication: on an infinite
metric space, the continuous transitive core with dense positive-period points
has sensitive dependence on initial conditions. -/
theorem HasDevaneyCore.isSensitive [MetricSpace X] [Infinite X]
    {f : X → X} (h : HasDevaneyCore f) : IsSensitive f := by
  rcases h with ⟨hcont, htrans, hperiodic⟩
  rcases exists_periodicOrbit_far hperiodic.2 with ⟨δ, hδ, hfar⟩
  refine ⟨δ, hperiodic.1, hδ, fun x ε hε ↦ ?_⟩
  let ρ := min ε δ
  have hρ : 0 < ρ := lt_min hε hδ
  let U := Metric.ball x ρ
  have hUo : IsOpen U := Metric.isOpen_ball
  have hUne : U.Nonempty := ⟨x, Metric.mem_ball_self hρ⟩
  rcases hperiodic.exists_mem_open hUo hUne with ⟨p, hp, hpU⟩
  let n := minimalPeriod f p
  have hn : 0 < n := minimalPeriod_pos_of_mem_periodicPts hp
  have hpperiod : IsPeriodicPt f n p := isPeriodicPt_minimalPeriod f p
  rcases hfar x with ⟨q, _, hqfar⟩
  let V : Set X := ⋂ i ∈ Finset.range (n + 1),
    (f^[i]) ⁻¹' Metric.ball (f^[i] q) δ
  have hVo : IsOpen V := by
    dsimp [V]
    exact isOpen_biInter_finset fun i _ ↦
      Metric.isOpen_ball.preimage (hcont.iterate i)
  have hqV : q ∈ V := by
    simp only [V, mem_iInter, mem_preimage, Metric.mem_ball]
    intro i _
    exact dist_self _ |>.trans_lt hδ
  rcases htrans.exists_pos_iterate_mem hUo hUne hVo ⟨q, hqV⟩ with
    ⟨k, _, y, hyU, hyV⟩
  let r := n - k % n
  have hrle : r ≤ n := by
    exact Nat.sub_le _ _
  let m := k + r
  have hnm : n ∣ m := by
    refine ⟨k / n + 1, ?_⟩
    dsimp [m, r]
    have hmod := Nat.mod_lt k hn
    have hmod_add : k % n + (n - k % n) = n :=
      Nat.add_sub_of_le (Nat.le_of_lt hmod)
    calc
      k + (n - k % n) = (n * (k / n) + k % n) + (n - k % n) := by
        rw [Nat.div_add_mod]
      _ = n * (k / n) + n := by rw [add_assoc, hmod_add]
      _ = n * (k / n + 1) := by rw [Nat.mul_add, Nat.mul_one]
  have hyrange : r ∈ Finset.range (n + 1) :=
    Finset.mem_range.mpr (Nat.lt_succ_of_le hrle)
  have hyclose : dist (f^[r] (f^[k] y)) (f^[r] q) < δ := by
    have hyV' := hyV
    simp only [V, mem_iInter, mem_preimage, Metric.mem_ball] at hyV'
    exact hyV' r hyrange
  have hytime : f^[m] y = f^[r] (f^[k] y) := by
    rw [show m = r + k by simp only [m, add_comm], Function.iterate_add_apply]
  have hptime : f^[m] p = p := (hpperiod.trans_dvd hnm).eq
  have hfar_r : 4 * δ ≤ dist x (f^[r] q) := hqfar r
  have hpx : dist p x < δ := by
    have hpρ : dist p x < ρ := hpU
    exact hpρ.trans_le (min_le_right _ _)
  have hpy : 2 * δ < dist (f^[m] p) (f^[m] y) := by
    rw [hptime, hytime]
    have htriangle := dist_triangle4 x p (f^[r] (f^[k] y)) (f^[r] q)
    rw [dist_comm x p] at htriangle
    linarith
  have hpε : dist p x < ε := hpU.trans_le (min_le_left _ _)
  have hyε : dist y x < ε := by
    have hyρ : dist y x < ρ := hyU
    exact hyρ.trans_le (min_le_left _ _)
  by_cases hxy : δ < dist (f^[m] x) (f^[m] y)
  · exact ⟨y, hyε, m, hxy⟩
  · have hxp : δ < dist (f^[m] x) (f^[m] p) := by
      by_contra hnot
      have hxy' := le_of_not_gt hxy
      have hxp' := le_of_not_gt hnot
      have htriangle :=
        dist_triangle (f^[m] p) (f^[m] x) (f^[m] y)
      rw [dist_comm (f^[m] p) (f^[m] x)] at htriangle
      linarith
    exact ⟨p, hpε, m, hxp⟩

/-- On an infinite metric space, the topological core supplies the third field
of Devaney's original definition. -/
theorem HasDevaneyCore.isDevaneyChaotic [MetricSpace X] [Infinite X]
    {f : X → X} (h : HasDevaneyCore f) : IsDevaneyChaotic f :=
  ⟨h, h.isSensitive⟩

/-- Under the Banks hypotheses, the original three-clause predicate is
equivalent to its continuous topological core. -/
theorem isDevaneyChaotic_iff_hasDevaneyCore [MetricSpace X] [Infinite X]
    {f : X → X} : IsDevaneyChaotic f ↔ HasDevaneyCore f :=
  ⟨And.left, HasDevaneyCore.isDevaneyChaotic⟩

/-- No self-map of a finite metric space is Devaney chaotic, even though a
cyclic permutation may satisfy the two topological clauses. -/
theorem not_isDevaneyChaotic_of_finite [MetricSpace X] [Finite X]
    (f : X → X) : ¬IsDevaneyChaotic f := by
  intro h
  exact not_isSensitive_of_finite f h.2

/-- A Devaney-chaotic metric system has no isolated points. -/
theorem IsDevaneyChaotic.perfectSpace [PseudoMetricSpace X]
    {f : X → X} (h : IsDevaneyChaotic f) : PerfectSpace X :=
  h.2.perfectSpace

end NonlinearDynamics.Deterministic.Chaos

#print axioms NonlinearDynamics.Deterministic.Chaos.HasDevaneyCore.isSensitive
#print axioms NonlinearDynamics.Deterministic.Chaos.isDevaneyChaotic_iff_hasDevaneyCore
#print axioms NonlinearDynamics.Deterministic.Chaos.not_isDevaneyChaotic_of_finite
