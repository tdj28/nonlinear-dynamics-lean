import NonlinearDynamics.Deterministic.Discrete.Conjugacy
import Mathlib.Analysis.Real.Sqrt
import Mathlib.Topology.Order.LeftRight

/-!
# Bifurcation interfaces for deterministic discrete-time systems

This module treats a parameterized discrete system as a family of self-maps
`family : P → X → X`.  A whole-state-space conjugacy bifurcation at `μ` means that
maps not topologically conjugate to `family μ` occur arbitrarily near `μ`.
The definition is deliberately global in the state space and does not require
continuity of the individual self-maps, joint continuity in parameter and
state, or differentiability.

A separate classifier interface records a change in explicitly selected
qualitative data.  Such a change implies the whole-state-space conjugacy
bifurcation predicate only when the classifier is invariant under topological
conjugacy.  Fixed-point
existence and existence of a point with a specified natural-number period are
two examples.  Exact fixed-point sets are not used as classifiers because a
coordinate change can move those sets while preserving the dynamics.

Fixed-point and specified-period branches are pointwise predicates on a chosen
parameter set.  No continuity, differentiability, or maximality of a branch is
bundled into these definitions.

The elementary real family `quadraticFixedPointFamily μ x = x + (μ - x ^ 2)`
has no fixed point for `μ < 0`, one at `μ = 0`, and two for `μ > 0`.  Its
fixed-point-existence classifier changes at zero, which gives a checked
whole-state-space conjugacy bifurcation.  In the declaration name, `Global`
modifies the domain of the conjugating homeomorphism; it does not classify the
fold-type event as a global bifurcation in the standard local/global taxonomy.
This calculation does not establish a generic fold normal-form theorem,
stability exchange, hyperbolicity, transversality, or a numerical detection
method.
-/

open Filter Function Set Topology

namespace NonlinearDynamics.Deterministic.Discrete

universe u v w

variable {P : Type u} {X : Type v} {C : Type w}

/-- A parameterized family of deterministic discrete-time self-maps. -/
abbrev ParameterizedFamily (P : Type u) (X : Type v) := P → X → X

/-- A selected classifier changes at `μ` when it is not eventually equal to
its value at `μ` along the neighborhood filter.  The classifier has a
qualitative interpretation only when its values and invariance properties have
been specified separately. -/
def IsClassificationChangeAt [TopologicalSpace P]
    (classify : P → C) (μ : P) : Prop :=
  ¬∀ᶠ ν in 𝓝 μ, classify ν = classify μ

/-- A classifier changes at `μ` exactly when different classifier values occur
frequently in the neighborhood filter. -/
theorem isClassificationChangeAt_iff_frequently_ne [TopologicalSpace P]
    {classify : P → C} {μ : P} :
    IsClassificationChangeAt classify μ ↔
      ∃ᶠ ν in 𝓝 μ, classify ν ≠ classify μ := by
  rw [IsClassificationChangeAt, Filter.not_eventually]

/-- A whole-state-space conjugacy bifurcation occurs when maps not conjugate
to the reference map by a homeomorphism of the entire state space occur
arbitrarily near the reference parameter.

Here `Global` modifies the domain of the conjugating homeomorphism. It does
not classify the event as a global bifurcation in the standard local/global
bifurcation taxonomy. -/
def IsGlobalTopologicalBifurcationAt
    [TopologicalSpace P] [TopologicalSpace X]
    (family : ParameterizedFamily P X) (μ : P) : Prop :=
  ¬∀ᶠ ν in 𝓝 μ, AreTopologicallyConjugate (family ν) (family μ)

/-- The filter form of a whole-state-space conjugacy bifurcation: inequivalent
systems occur frequently near the reference parameter. -/
theorem isGlobalTopologicalBifurcationAt_iff_frequently_not_conjugate
    [TopologicalSpace P] [TopologicalSpace X]
    {family : ParameterizedFamily P X} {μ : P} :
    IsGlobalTopologicalBifurcationAt family μ ↔
      ∃ᶠ ν in 𝓝 μ, ¬AreTopologicallyConjugate (family ν) (family μ) := by
  rw [IsGlobalTopologicalBifurcationAt, Filter.not_eventually]

/-- A change in a classifier that is invariant under the relevant conjugacies
is sufficient for a whole-state-space conjugacy bifurcation. -/
theorem IsClassificationChangeAt.isGlobalTopologicalBifurcationAt
    [TopologicalSpace P] [TopologicalSpace X]
    {family : ParameterizedFamily P X} {classify : P → C} {μ : P}
    (hchange : IsClassificationChangeAt classify μ)
    (hinvariant : ∀ ν, AreTopologicallyConjugate (family ν) (family μ) →
      classify ν = classify μ) :
    IsGlobalTopologicalBifurcationAt family μ := by
  intro hconj
  apply hchange
  filter_upwards [hconj] with ν hν
  exact hinvariant ν hν

/-- A branch of fixed points on a parameter set.  This predicate asserts only
the pointwise fixed-point equations. -/
def IsFixedPointBranchOn (family : ParameterizedFamily P X)
    (branch : P → X) (s : Set P) : Prop :=
  ∀ μ ∈ s, IsFixedPt (family μ) (branch μ)

/-- A branch of points having a specified natural-number period on a parameter
set.  The specified period need not be the least positive period. -/
def IsSpecifiedPeriodBranchOn (family : ParameterizedFamily P X)
    (n : ℕ) (branch : P → X) (s : Set P) : Prop :=
  ∀ μ ∈ s, IsPeriodicPt (family μ) n (branch μ)

/-- Every fixed-point branch is a specified-period branch for every natural
number, including zero. -/
theorem IsFixedPointBranchOn.isSpecifiedPeriodBranchOn
    {family : ParameterizedFamily P X} {branch : P → X} {s : Set P}
    (hbranch : IsFixedPointBranchOn family branch s) (n : ℕ) :
    IsSpecifiedPeriodBranchOn family n branch s :=
  fun μ hμ ↦ (hbranch μ hμ).isPeriodicPt n

/-- A self-map has a fixed point. -/
def HasFixedPoint (f : X → X) : Prop :=
  ∃ x, IsFixedPt f x

/-- A self-map has a point satisfying the specified-period equation.  This
does not assert that the period is least or positive. -/
def HasSpecifiedPeriodPoint (f : X → X) (n : ℕ) : Prop :=
  ∃ x, IsPeriodicPt f n x

/-- Global topological conjugacy preserves existence of a fixed point. -/
theorem AreTopologicallyConjugate.hasFixedPoint_iff
    [TopologicalSpace X]
    {f g : X → X} (h : AreTopologicallyConjugate f g) :
    HasFixedPoint f ↔ HasFixedPoint g := by
  rcases h with ⟨e, he⟩
  constructor
  · rintro ⟨x, hx⟩
    exact ⟨e x, he.isFixedPt_iff.1 hx⟩
  · rintro ⟨y, hy⟩
    exact ⟨e.symm y, by simpa using he.symm.isFixedPt_iff.1 hy⟩

/-- Global topological conjugacy preserves existence of a point with any
specified natural-number period. -/
theorem AreTopologicallyConjugate.hasSpecifiedPeriodPoint_iff
    [TopologicalSpace X]
    {f g : X → X} (h : AreTopologicallyConjugate f g) (n : ℕ) :
    HasSpecifiedPeriodPoint f n ↔ HasSpecifiedPeriodPoint g n := by
  rcases h with ⟨e, he⟩
  constructor
  · rintro ⟨x, hx⟩
    exact ⟨e x, he.isPeriodicPt_iff.1 hx⟩
  · rintro ⟨y, hy⟩
    exact ⟨e.symm y, by simpa using he.symm.isPeriodicPt_iff.1 hy⟩

/-- Fixed-point existence changes at a parameter. -/
def IsFixedPointExistenceChangeAt [TopologicalSpace P]
    (family : ParameterizedFamily P X) (μ : P) : Prop :=
  IsClassificationChangeAt (fun ν ↦ HasFixedPoint (family ν)) μ

/-- Existence of a point with a specified natural-number period changes at a
parameter. -/
def IsSpecifiedPeriodExistenceChangeAt [TopologicalSpace P]
    (family : ParameterizedFamily P X) (n : ℕ) (μ : P) : Prop :=
  IsClassificationChangeAt (fun ν ↦ HasSpecifiedPeriodPoint (family ν) n) μ

/-- A fixed-point-existence change obstructs local constancy of the
whole-state-space topological conjugacy class. -/
theorem IsFixedPointExistenceChangeAt.isGlobalTopologicalBifurcationAt
    [TopologicalSpace P] [TopologicalSpace X]
    {family : ParameterizedFamily P X} {μ : P}
    (hchange : IsFixedPointExistenceChangeAt family μ) :
    IsGlobalTopologicalBifurcationAt family μ :=
  IsClassificationChangeAt.isGlobalTopologicalBifurcationAt
    (family := family)
    (classify := fun ν ↦ HasFixedPoint (family ν))
    hchange fun _ hν ↦ propext hν.hasFixedPoint_iff

/-- A specified-period-existence change obstructs local constancy of the
whole-state-space topological conjugacy class. -/
theorem IsSpecifiedPeriodExistenceChangeAt.isGlobalTopologicalBifurcationAt
    [TopologicalSpace P] [TopologicalSpace X]
    {family : ParameterizedFamily P X} {n : ℕ} {μ : P}
    (hchange : IsSpecifiedPeriodExistenceChangeAt family n μ) :
    IsGlobalTopologicalBifurcationAt family μ :=
  IsClassificationChangeAt.isGlobalTopologicalBifurcationAt
    (family := family)
    (classify := fun ν ↦ HasSpecifiedPeriodPoint (family ν) n)
    hchange fun _ hν ↦ propext (hν.hasSpecifiedPeriodPoint_iff n)

/-- A classifier cannot change at an isolated parameter. -/
theorem not_isClassificationChangeAt_of_isOpen_singleton
    [TopologicalSpace P] (classify : P → C) (μ : P)
    (hμ : IsOpen ({μ} : Set P)) :
    ¬IsClassificationChangeAt classify μ := by
  intro hchange
  apply hchange
  filter_upwards [hμ.mem_nhds rfl] with ν hν
  exact congrArg classify hν

section QuadraticFixedPointFamily

/-- An elementary real family whose fixed-point equation is `μ = x ^ 2`. -/
def quadraticFixedPointFamily : ParameterizedFamily ℝ ℝ :=
  fun μ x ↦ x + (μ - x ^ 2)

/-- The fixed-point equation of the quadratic family. -/
@[simp] theorem quadraticFixedPointFamily_isFixedPt_iff (μ x : ℝ) :
    IsFixedPt (quadraticFixedPointFamily μ) x ↔ μ = x ^ 2 := by
  simp [quadraticFixedPointFamily, IsFixedPt, sub_eq_zero]

/-- The quadratic family has a real fixed point exactly for nonnegative
parameters. -/
@[simp] theorem quadraticFixedPointFamily_hasFixedPoint_iff (μ : ℝ) :
    HasFixedPoint (quadraticFixedPointFamily μ) ↔ 0 ≤ μ := by
  constructor
  · rintro ⟨x, hx⟩
    rw [quadraticFixedPointFamily_isFixedPt_iff] at hx
    rw [hx]
    exact sq_nonneg x
  · intro hμ
    refine ⟨√μ, ?_⟩
    rw [quadraticFixedPointFamily_isFixedPt_iff]
    exact (Real.sq_sqrt hμ).symm

/-- For a nonnegative parameter, the fixed points are exactly the two square
root branches, which coincide when the parameter is zero. -/
theorem quadraticFixedPointFamily_isFixedPt_iff_eq_sqrt_or_eq_neg_sqrt
    {μ x : ℝ} (hμ : 0 ≤ μ) :
    IsFixedPt (quadraticFixedPointFamily μ) x ↔ x = √μ ∨ x = -√μ := by
  rw [quadraticFixedPointFamily_isFixedPt_iff]
  have hsqrt : (√μ) ^ 2 = μ := Real.sq_sqrt hμ
  constructor
  · intro hx
    apply sq_eq_sq_iff_eq_or_eq_neg.1
    exact hx.symm.trans hsqrt.symm
  · intro hx
    apply hx.elim <;> rintro rfl
    · exact hsqrt.symm
    · simpa using hsqrt.symm

/-- The nonnegative square-root branch consists of fixed points. -/
theorem quadraticFixedPointFamily_sqrt_isFixedPointBranchOn :
    IsFixedPointBranchOn quadraticFixedPointFamily Real.sqrt (Ici 0) := by
  intro μ hμ
  rw [quadraticFixedPointFamily_isFixedPt_iff]
  exact (Real.sq_sqrt hμ).symm

/-- The negative square-root branch also consists of fixed points. -/
theorem quadraticFixedPointFamily_neg_sqrt_isFixedPointBranchOn :
    IsFixedPointBranchOn quadraticFixedPointFamily (fun μ ↦ -√μ) (Ici 0) := by
  intro μ hμ
  rw [quadraticFixedPointFamily_isFixedPt_iff]
  simpa using (Real.sq_sqrt hμ).symm

/-- The two square-root branches are distinct at every positive parameter. -/
theorem quadraticFixedPointFamily_sqrt_ne_neg_sqrt {μ : ℝ} (hμ : 0 < μ) :
    √μ ≠ -√μ :=
  ne_of_gt (neg_lt_self (Real.sqrt_pos.2 hμ))

/-- Fixed-point existence for the quadratic family changes at parameter zero. -/
theorem quadraticFixedPointFamily_isFixedPointExistenceChangeAt_zero :
    IsFixedPointExistenceChangeAt quadraticFixedPointFamily 0 := by
  rw [IsFixedPointExistenceChangeAt,
    isClassificationChangeAt_iff_frequently_ne]
  exact (frequently_lt_nhds (0 : ℝ)).mono fun μ hμ ↦ by
    simp [quadraticFixedPointFamily_hasFixedPoint_iff, not_le.mpr hμ]

/-- The elementary quadratic family satisfies the whole-state-space conjugacy
bifurcation predicate at zero because negative parameters arbitrarily near
zero have no fixed point while the zero-parameter map has one. -/
theorem quadraticFixedPointFamily_isGlobalTopologicalBifurcationAt_zero :
    IsGlobalTopologicalBifurcationAt quadraticFixedPointFamily 0 :=
  quadraticFixedPointFamily_isFixedPointExistenceChangeAt_zero.isGlobalTopologicalBifurcationAt

end QuadraticFixedPointFamily

end NonlinearDynamics.Deterministic.Discrete

#print axioms NonlinearDynamics.Deterministic.Discrete.isClassificationChangeAt_iff_frequently_ne
#print axioms NonlinearDynamics.Deterministic.Discrete.IsClassificationChangeAt.isGlobalTopologicalBifurcationAt
#print axioms NonlinearDynamics.Deterministic.Discrete.AreTopologicallyConjugate.hasFixedPoint_iff
#print axioms NonlinearDynamics.Deterministic.Discrete.IsFixedPointExistenceChangeAt.isGlobalTopologicalBifurcationAt
#print axioms NonlinearDynamics.Deterministic.Discrete.quadraticFixedPointFamily_isFixedPt_iff_eq_sqrt_or_eq_neg_sqrt
#print axioms NonlinearDynamics.Deterministic.Discrete.quadraticFixedPointFamily_isGlobalTopologicalBifurcationAt_zero
