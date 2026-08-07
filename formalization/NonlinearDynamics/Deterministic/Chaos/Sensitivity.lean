import Mathlib.Algebra.Order.Archimedean.Basic
import Mathlib.Topology.Perfect
import NonlinearDynamics.Deterministic.Discrete.Stability

/-!
# Sensitivity to initial conditions

This module gives a metric-space interface for sensitive dependence in a
one-sided discrete-time system.  A positive sensitivity scale is selected
before the reference state and its neighborhood.  Every such neighborhood
must contain an initial state whose orbit separates from the reference orbit
by more than that fixed scale at some natural-number time.

The definition is metric-first because the global separation scale is metric
data.  A topology alone says which sets are neighborhoods, but does not choose
a uniform meaning for two points being a fixed amount apart.  The theorem
`isSensitiveAtWith_iff_nhds` exposes the topological neighborhood quantifier
without claiming that sensitivity is invariant under arbitrary changes of
compatible metric on noncompact spaces.

The file also records the obstruction from isolated points, incompatibility
with forward stability at the same reference state, and the real doubling map
as an exact sensitive example.  It does not define expansivity, mixing,
entropy, derivative growth, numerical roundoff growth, finite-horizon
separation, or two-sided time.
-/

open Filter Function Set

namespace NonlinearDynamics.Deterministic.Chaos

universe u

variable {X : Type u}

/-- The forward orbits of `x` and `y` separate by more than `δ` at some
natural-number time.  Time zero is included. -/
def SeparatesAtScale [PseudoMetricSpace X]
    (f : X → X) (δ : ℝ) (x y : X) : Prop :=
  ∃ n : ℕ, δ < dist (f^[n] x) (f^[n] y)

/-- Sensitivity at `x` with a specified scale `δ`: every positive-radius ball
around `x` contains a point whose forward orbit eventually separates from the
orbit of `x` by more than `δ`. -/
def IsSensitiveAtWith [PseudoMetricSpace X]
    (f : X → X) (δ : ℝ) (x : X) : Prop :=
  ∀ ε > 0, ∃ y, dist y x < ε ∧ SeparatesAtScale f δ x y

/-- Global sensitivity with a specified scale.  Positivity of the scale is
part of the predicate, and the same scale must work at every state. -/
def IsSensitiveWith [PseudoMetricSpace X]
    (f : X → X) (δ : ℝ) : Prop :=
  Nonempty X ∧ 0 < δ ∧ ∀ x, IsSensitiveAtWith f δ x

/-- A self-map is sensitive when some fixed positive scale works at every
state and in every neighborhood of that state. -/
def IsSensitive [PseudoMetricSpace X] (f : X → X) : Prop :=
  ∃ δ, IsSensitiveWith f δ

/-- Separation at a scale remains true after lowering the scale. -/
theorem SeparatesAtScale.mono [PseudoMetricSpace X]
    {f : X → X} {δ δ' : ℝ} {x y : X}
    (h : SeparatesAtScale f δ x y) (hscale : δ' ≤ δ) :
    SeparatesAtScale f δ' x y := by
  rcases h with ⟨n, hn⟩
  exact ⟨n, hscale.trans_lt hn⟩

/-- A positive separation scale forces the two initial states to be distinct. -/
theorem SeparatesAtScale.ne [PseudoMetricSpace X]
    {f : X → X} {δ : ℝ} {x y : X}
    (h : SeparatesAtScale f δ x y) (hδ : 0 < δ) :
    x ≠ y := by
  intro hxy
  subst y
  rcases h with ⟨n, hn⟩
  have : δ < 0 := by simpa using hn
  exact (not_lt_of_ge hδ.le) this

/-- If the initial distance is already below the separation scale, a witness
time for separation must be positive even though iteration is indexed by all
natural numbers. -/
theorem SeparatesAtScale.exists_pos [PseudoMetricSpace X]
    {f : X → X} {δ : ℝ} {x y : X}
    (h : SeparatesAtScale f δ x y) (hclose : dist y x < δ) :
    ∃ n : ℕ, 0 < n ∧ δ < dist (f^[n] x) (f^[n] y) := by
  rcases h with ⟨n, hn⟩
  have hn0 : n ≠ 0 := by
    intro hnzero
    subst n
    simp only [Function.iterate_zero_apply] at hn
    exact (lt_asymm hclose (by simpa only [dist_comm] using hn))
  exact ⟨n, Nat.pos_of_ne_zero hn0, hn⟩

/-- Sensitivity at a point is antitone in its separation scale. -/
theorem IsSensitiveAtWith.mono [PseudoMetricSpace X]
    {f : X → X} {δ δ' : ℝ} {x : X}
    (h : IsSensitiveAtWith f δ x) (hscale : δ' ≤ δ) :
    IsSensitiveAtWith f δ' x := by
  intro ε hε
  rcases h ε hε with ⟨y, hy, hsep⟩
  exact ⟨y, hy, hsep.mono hscale⟩

/-- Global sensitivity passes to every smaller positive scale. -/
theorem IsSensitiveWith.mono [PseudoMetricSpace X]
    {f : X → X} {δ δ' : ℝ}
    (h : IsSensitiveWith f δ) (hδ' : 0 < δ') (hscale : δ' ≤ δ) :
    IsSensitiveWith f δ' :=
  ⟨h.1, hδ', fun x ↦ (h.2.2 x).mono hscale⟩

/-- The ball formulation of pointwise sensitivity is equivalent to the
standard formulation using every neighborhood of the reference state. -/
theorem isSensitiveAtWith_iff_nhds [PseudoMetricSpace X]
    {f : X → X} {δ : ℝ} {x : X} :
    IsSensitiveAtWith f δ x ↔
      ∀ U ∈ 𝓝 x, ∃ y ∈ U, SeparatesAtScale f δ x y := by
  constructor
  · intro h U hU
    rcases Metric.mem_nhds_iff.mp hU with ⟨ε, hε, hball⟩
    rcases h ε hε with ⟨y, hy, hsep⟩
    exact ⟨y, hball hy, hsep⟩
  · intro h ε hε
    rcases h (Metric.ball x ε) (Metric.ball_mem_nhds x hε) with
      ⟨y, hy, hsep⟩
    exact ⟨y, hy, hsep⟩

/-- An isolated state prevents sensitivity at that state at every positive
scale. -/
theorem not_isSensitiveAtWith_of_isOpen_singleton [PseudoMetricSpace X]
    {f : X → X} {δ : ℝ} {x : X} (hδ : 0 < δ)
    (hx : IsOpen ({x} : Set X)) :
    ¬IsSensitiveAtWith f δ x := by
  intro hs
  have hmem : ({x} : Set X) ∈ 𝓝 x := hx.mem_nhds (by simp)
  rcases isSensitiveAtWith_iff_nhds.mp hs {x} hmem with
    ⟨y, hy, hsep⟩
  have hyx : y = x := by simpa using hy
  exact hsep.ne hδ hyx.symm

/-- No self-map of a nonempty discrete pseudo-metric space is sensitive. -/
theorem not_isSensitive_of_discreteTopology [PseudoMetricSpace X]
    [DiscreteTopology X] (f : X → X) :
    ¬IsSensitive f := by
  rintro ⟨δ, hnonempty, hδ, hs⟩
  let x : X := Classical.choice hnonempty
  exact not_isSensitiveAtWith_of_isOpen_singleton hδ
    (isOpen_discrete ({x} : Set X)) (hs x)

/-- In particular, no self-map of a finite metric space is sensitive. -/
theorem not_isSensitive_of_finite [MetricSpace X] [Finite X] (f : X → X) :
    ¬IsSensitive f := by
  letI : DiscreteTopology X :=
    DiscreteTopology.of_finite_of_isClosed_singleton fun _ ↦ isClosed_singleton
  exact not_isSensitive_of_discreteTopology f

/-- A sensitive pseudo-metric space has no isolated point. -/
theorem IsSensitive.perfectSpace [PseudoMetricSpace X]
    {f : X → X} (hs : IsSensitive f) :
    PerfectSpace X := by
  rcases hs with ⟨δ, _, hδ, hall⟩
  rw [perfectSpace_iff_forall_not_isolated]
  intro x
  apply Filter.neBot_iff.mpr
  intro hbot
  exact not_isSensitiveAtWith_of_isOpen_singleton hδ
    ((isOpen_singleton_iff_punctured_nhds x).mpr hbot) (hall x)

/-- Sensitivity at a positive scale and forward stability are incompatible at
the same reference state. -/
theorem IsSensitiveAtWith.not_isForwardStableAt [PseudoMetricSpace X]
    {f : X → X} {δ : ℝ} {x : X}
    (hs : IsSensitiveAtWith f δ x) (hδ : 0 < δ) :
    ¬NonlinearDynamics.Deterministic.Discrete.IsForwardStableAt f x := by
  intro hstable
  rw [NonlinearDynamics.Deterministic.Discrete.isForwardStableAt_iff_dist] at hstable
  rcases hstable δ hδ with ⟨ε, hε, hclose⟩
  rcases hs ε hε with ⟨y, hy, n, hn⟩
  exact (not_lt_of_ge hn.le) (hclose y hy n)

/-- A globally sensitive map is not forward stable at any reference state. -/
theorem IsSensitive.not_isForwardStableAt [PseudoMetricSpace X]
    {f : X → X} (hs : IsSensitive f) (x : X) :
    ¬NonlinearDynamics.Deterministic.Discrete.IsForwardStableAt f x := by
  rcases hs with ⟨δ, hδ, hall⟩
  exact (hall.2 x).not_isForwardStableAt hall.1

/-- A nonexpansive self-map on a nonempty pseudo-metric space is not
sensitive. -/
theorem not_isSensitive_of_lipschitzWith_one [PseudoMetricSpace X]
    {f : X → X} (hf : LipschitzWith 1 f) :
    ¬IsSensitive f := by
  intro hs
  rcases hs with ⟨δ, hnonempty, hδ, hall⟩
  let x : X := Classical.choice hnonempty
  have hs' : IsSensitive f := ⟨δ, hnonempty, hδ, hall⟩
  exact hs'.not_isForwardStableAt x
    (NonlinearDynamics.Deterministic.Discrete.isForwardStableAt_of_lipschitzWith_one hf x)

/-- The identity map on a nonempty pseudo-metric space is not sensitive. -/
@[simp] theorem not_isSensitive_id [PseudoMetricSpace X] :
    ¬IsSensitive (id : X → X) :=
  not_isSensitive_of_lipschitzWith_one LipschitzWith.id

/-- The real doubling map used as the module's exact sensitive example. -/
def doublingMap (x : ℝ) : ℝ := 2 * x

/-- Iterating the real doubling map multiplies the initial state by a power of
two. -/
theorem doublingMap_iterate (n : ℕ) (x : ℝ) :
    doublingMap^[n] x = (2 : ℝ) ^ n * x := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [Function.iterate_succ_apply', ih]
      simp only [doublingMap, pow_succ]
      ring

/-- The real doubling map is sensitive with scale one. -/
theorem doublingMap_isSensitiveWith_one :
    IsSensitiveWith doublingMap 1 := by
  refine ⟨inferInstance, by norm_num, fun x ε hε ↦ ?_⟩
  let y := x + ε / 2
  have hhalf : 0 < ε / 2 := half_pos hε
  have hy : dist y x < ε := by
    rw [Real.dist_eq]
    dsimp [y]
    have : x + ε / 2 - x = ε / 2 := by ring
    rw [this, abs_of_pos hhalf]
    exact half_lt_self hε
  obtain ⟨n, hn⟩ := pow_unbounded_of_one_lt (ε / 2)⁻¹
    (show (1 : ℝ) < 2 by norm_num)
  refine ⟨y, hy, n, ?_⟩
  rw [doublingMap_iterate n x, doublingMap_iterate n y, Real.dist_eq]
  dsimp [y]
  have hdiff :
      (2 : ℝ) ^ n * x - (2 : ℝ) ^ n * (x + ε / 2) =
        -((2 : ℝ) ^ n * (ε / 2)) := by ring
  rw [hdiff, abs_neg, abs_of_pos (mul_pos (pow_pos (by norm_num) n) hhalf)]
  exact (inv_lt_iff_one_lt_mul₀ hhalf).mp hn

/-- The real doubling map is sensitive. -/
theorem doublingMap_isSensitive : IsSensitive doublingMap :=
  ⟨1, doublingMap_isSensitiveWith_one⟩

end NonlinearDynamics.Deterministic.Chaos

#print axioms NonlinearDynamics.Deterministic.Chaos.isSensitiveAtWith_iff_nhds
#print axioms NonlinearDynamics.Deterministic.Chaos.not_isSensitive_of_discreteTopology
#print axioms NonlinearDynamics.Deterministic.Chaos.IsSensitiveAtWith.not_isForwardStableAt
#print axioms NonlinearDynamics.Deterministic.Chaos.not_isSensitive_of_lipschitzWith_one
#print axioms NonlinearDynamics.Deterministic.Chaos.doublingMap_isSensitive
