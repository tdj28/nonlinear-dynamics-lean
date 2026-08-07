import Mathlib.Data.Fintype.Prod
import Mathlib.Dynamics.SymbolicDynamics.Basic
import Mathlib.Topology.MetricSpace.PiNat
import NonlinearDynamics.Deterministic.Chaos.Devaney
import NonlinearDynamics.Deterministic.Discrete.Conjugacy

/-!
# One-sided symbolic coding and the full shift

This module specializes Mathlib's monoid-indexed symbolic-dynamics API to
one-sided sequences `ℕ → A`.  It keeps four layers separate:

* `oneSidedShift` is the left shift supplied by Mathlib's full shift;
* `prefixCylinder` records a finite initial word and forms a basis for the
  product topology when the alphabet is discrete;
* prefix splicing and periodic completion prove transitivity and dense
  positive-period points for the full shift; and
* `itinerary` codes an arbitrary forward orbit by an observable, with an exact
  semiconjugacy theorem and explicit continuity and surjectivity gates.

For a nontrivial discrete alphabet, the compatible `PiNat` metric turns the
one-sided full shift into a Devaney-chaotic system through the Banks theorem
proved in `Chaos.Devaney`.  Finiteness of the alphabet is not needed for that
chaoticity implication; it is the additional hypothesis that makes the
discrete alphabet, and hence its product, compact.

No entropy, mixing, Markov partition, finite-type constraint, or inverse coding
claim is made here.  A continuous itinerary is a topological factor map only
when its surjectivity is supplied separately.
-/

open Function Set Topology

namespace NonlinearDynamics.Deterministic.Chaos

universe u v

variable {A : Type u} {X : Type v}

/-- The one-sided configuration space over an alphabet `A`. -/
abbrev OneSidedSequence (A : Type u) := ℕ → A

/-- The one-sided left shift, specialized from Mathlib's full-shift action. -/
def oneSidedShift (x : OneSidedSequence A) : OneSidedSequence A :=
  SymbolicDynamics.FullShift.shift 1 x

@[simp]
theorem oneSidedShift_apply (x : OneSidedSequence A) (n : ℕ) :
    oneSidedShift x n = x (n + 1) := by
  simp [oneSidedShift, Nat.add_comm]

/-- Iterating the one-sided shift discards exactly the specified prefix. -/
@[simp]
theorem oneSidedShift_iterate_apply (k : ℕ) (x : OneSidedSequence A) (n : ℕ) :
    (oneSidedShift^[k]) x n = x (k + n) := by
  induction k generalizing x with
  | zero => simp
  | succ k ih =>
      simp only [Function.iterate_succ_apply, ih, oneSidedShift_apply]
      congr 1
      omega

/-- The prefix cylinder fixing the coordinates strictly before `n`. -/
abbrev prefixCylinder (x : OneSidedSequence A) (n : ℕ) : Set (OneSidedSequence A) :=
  PiNat.cylinder x n

/-- Prefix cylinders are Mathlib full-shift cylinders on `Finset.range n`. -/
theorem prefixCylinder_eq_fullShift_cylinder (x : OneSidedSequence A) (n : ℕ) :
    prefixCylinder x n =
      SymbolicDynamics.FullShift.cylinder (Finset.range n) x := by
  ext y
  simp [prefixCylinder, PiNat.cylinder, SymbolicDynamics.FullShift.cylinder]

/-- Prefix cylinders are open for a discrete alphabet. -/
theorem isOpen_prefixCylinder [TopologicalSpace A] [DiscreteTopology A]
    (x : OneSidedSequence A) (n : ℕ) : IsOpen (prefixCylinder x n) :=
  PiNat.isOpen_cylinder (fun _ : ℕ => A) x n

/-- Prefix cylinders form a basis for the product topology. -/
theorem isTopologicalBasis_prefixCylinders [TopologicalSpace A]
    [DiscreteTopology A] :
    TopologicalSpace.IsTopologicalBasis
      {s : Set (OneSidedSequence A) | ∃ x n, s = prefixCylinder x n} :=
  PiNat.isTopologicalBasis_cylinders (fun _ : ℕ => A)

/-- Join a prescribed prefix to an arbitrary infinite tail. -/
def splicePrefix (stem tail : OneSidedSequence A) (k : ℕ) :
    OneSidedSequence A :=
  fun i => if i < k then stem i else tail (i - k)

@[simp]
theorem splicePrefix_apply_of_lt (stem tail : OneSidedSequence A)
    {k i : ℕ} (hi : i < k) : splicePrefix stem tail k i = stem i := by
  simp [splicePrefix, hi]

@[simp]
theorem splicePrefix_apply_add (stem tail : OneSidedSequence A)
    (k i : ℕ) : splicePrefix stem tail k (k + i) = tail i := by
  simp [splicePrefix]

/-- The spliced sequence belongs to the cylinder determined by its prefix. -/
theorem splicePrefix_mem_prefixCylinder (stem tail : OneSidedSequence A)
    (k : ℕ) : splicePrefix stem tail k ∈ prefixCylinder stem k := by
  intro i hi
  exact splicePrefix_apply_of_lt stem tail hi

/-- Shifting by the splice length recovers the selected tail exactly. -/
theorem oneSidedShift_iterate_splicePrefix (stem tail : OneSidedSequence A)
    (k : ℕ) : (oneSidedShift^[k]) (splicePrefix stem tail k) = tail := by
  ext i
  simp

/-- Repeat the initial block of length `p`; at `p = 0` this uses Lean's total
natural-number remainder convention.  Positive-period uses below choose
`p = n + 1`. -/
def periodicExtension (x : OneSidedSequence A) (p : ℕ) : OneSidedSequence A :=
  fun i => x (i % p)

@[simp]
theorem periodicExtension_apply_of_lt (x : OneSidedSequence A)
    {p i : ℕ} (hi : i < p) : periodicExtension x p i = x i := by
  simp [periodicExtension, Nat.mod_eq_of_lt hi]

/-- Repeating a block of length `p` gives a point fixed by the `p`th shift
iterate.  The statement also holds at zero, but only positive `p` enters
`periodicPts`. -/
theorem periodicExtension_isPeriodicPt (x : OneSidedSequence A) (p : ℕ) :
    IsPeriodicPt oneSidedShift p (periodicExtension x p) := by
  ext i
  simp [periodicExtension]

/-- Every prefix cylinder contains an explicitly constructed positive-period
point. -/
theorem exists_isPeriodicPt_mem_prefixCylinder (x : OneSidedSequence A)
    (n : ℕ) :
    ∃ p ∈ prefixCylinder x n, ∃ k : ℕ, 0 < k ∧
      IsPeriodicPt oneSidedShift k p := by
  let p := periodicExtension x (n + 1)
  refine ⟨p, ?_, n + 1, Nat.zero_lt_succ n,
    periodicExtension_isPeriodicPt x (n + 1)⟩
  intro i hi
  exact periodicExtension_apply_of_lt x (hi.trans (Nat.lt_succ_self n))

/-- The one-sided shift is continuous in the product topology. -/
theorem continuous_oneSidedShift [TopologicalSpace A] :
    Continuous (oneSidedShift (A := A)) :=
  SymbolicDynamics.FullShift.continuous_shift 1

/-- On every nonempty discrete alphabet, the one-sided full shift is
positive-time topologically transitive. -/
theorem oneSidedShift_isTopologicallyTransitive [TopologicalSpace A]
    [DiscreteTopology A] [Nonempty A] :
    IsTopologicallyTransitive (oneSidedShift (A := A)) := by
  refine ⟨inferInstance, ?_⟩
  intro U V hUo hUne _hVo hVne
  rcases hUne with ⟨x, hxU⟩
  obtain ⟨W, ⟨z, n, rfl⟩, hxW, hWU⟩ :=
    (isTopologicalBasis_prefixCylinders (A := A)).exists_subset_of_mem_open hxU hUo
  rcases hVne with ⟨y, hyV⟩
  let k := n + 1
  let w := splicePrefix z y k
  have hwk : w ∈ prefixCylinder z k := splicePrefix_mem_prefixCylinder z y k
  have hwn : w ∈ prefixCylinder z n :=
    PiNat.cylinder_anti z (Nat.le_succ n) hwk
  refine ⟨k, Nat.zero_lt_succ n, w, hWU hwn, ?_⟩
  have hwshift : (oneSidedShift^[k]) w = y := by
    simpa [w] using oneSidedShift_iterate_splicePrefix z y k
  rw [hwshift]
  exact hyV

/-- On every nonempty discrete alphabet, positive-period points are dense in
the one-sided full shift. -/
theorem oneSidedShift_hasDensePeriodicPoints [TopologicalSpace A]
    [DiscreteTopology A] [Nonempty A] :
    HasDensePeriodicPoints (oneSidedShift (A := A)) := by
  refine ⟨inferInstance, dense_iff_inter_open.2 ?_⟩
  intro U hUo hUne
  rcases hUne with ⟨x, hxU⟩
  obtain ⟨W, ⟨z, n, rfl⟩, _hxW, hWU⟩ :=
    (isTopologicalBasis_prefixCylinders (A := A)).exists_subset_of_mem_open hxU hUo
  rcases exists_isPeriodicPt_mem_prefixCylinder z n with
    ⟨p, hpC, k, hk, hp⟩
  exact ⟨p, hWU hpC, ⟨k, hk, hp⟩⟩

/-- The continuous topological core of the one-sided full shift. -/
theorem oneSidedShift_hasDevaneyCore [TopologicalSpace A]
    [DiscreteTopology A] [Nonempty A] :
    HasDevaneyCore (oneSidedShift (A := A)) :=
  ⟨continuous_oneSidedShift,
    oneSidedShift_isTopologicallyTransitive,
    oneSidedShift_hasDensePeriodicPoints⟩

/-- With the compatible prefix metric, the one-sided full shift over a
nontrivial discrete alphabet is Devaney chaotic. -/
theorem oneSidedShift_isDevaneyChaotic [TopologicalSpace A]
    [DiscreteTopology A] [Nontrivial A] :
    letI : MetricSpace (OneSidedSequence A) := PiNat.metricSpace
    IsDevaneyChaotic (oneSidedShift (A := A)) := by
  letI : MetricSpace (OneSidedSequence A) := PiNat.metricSpace
  exact oneSidedShift_hasDevaneyCore.isDevaneyChaotic

/-- A finite nontrivial discrete alphabet gives the customary compact
Devaney-chaotic one-sided full shift.  The finite hypothesis supplies
compactness; the chaoticity proof itself only needs nontriviality. -/
theorem finiteAlphabet_oneSidedShift_isDevaneyChaotic [TopologicalSpace A]
    [DiscreteTopology A] [Finite A] [Nontrivial A] :
    letI : MetricSpace (OneSidedSequence A) := PiNat.metricSpace
    IsDevaneyChaotic (oneSidedShift (A := A)) :=
  oneSidedShift_isDevaneyChaotic

/-- Code a forward orbit by recording the value of an observable at every
natural-number iterate. -/
def itinerary (f : X → X) (label : X → A) (x : X) : OneSidedSequence A :=
  fun n => label ((f^[n]) x)

@[simp]
theorem itinerary_apply (f : X → X) (label : X → A) (x : X) (n : ℕ) :
    itinerary f label x n = label ((f^[n]) x) := rfl

/-- The itinerary map intertwines the original dynamics with the one-sided
shift, without any topological assumptions. -/
theorem itinerary_semiconj (f : X → X) (label : X → A) :
    Semiconj (itinerary f label) f oneSidedShift := by
  intro x
  ext n
  simp [itinerary, Function.iterate_succ_apply]

/-- A continuous map and continuous observable give a continuous itinerary
into the product topology. -/
theorem continuous_itinerary [TopologicalSpace X] [TopologicalSpace A]
    {f : X → X} {label : X → A} (hf : Continuous f)
    (hlabel : Continuous label) : Continuous (itinerary f label) :=
  continuous_pi fun n => hlabel.comp (hf.iterate n)

/-- The continuous itinerary is a topological semiconjugacy. -/
theorem itinerary_isTopologicalSemiconjugacy
    [TopologicalSpace X] [TopologicalSpace A]
    {f : X → X} {label : X → A} (hf : Continuous f)
    (hlabel : Continuous label) :
    NonlinearDynamics.Deterministic.Discrete.IsTopologicalSemiconjugacy
      (itinerary f label) f oneSidedShift :=
  ⟨continuous_itinerary hf hlabel, itinerary_semiconj f label⟩

/-- Surjectivity is the additional gate that promotes a continuous itinerary
to a topological factor map onto the full shift. -/
theorem itinerary_isTopologicalFactorMap
    [TopologicalSpace X] [TopologicalSpace A]
    {f : X → X} {label : X → A} (hf : Continuous f)
    (hlabel : Continuous label) (hsurj : Surjective (itinerary f label)) :
    NonlinearDynamics.Deterministic.Discrete.IsTopologicalFactorMap
      (itinerary f label) f oneSidedShift :=
  ⟨itinerary_isTopologicalSemiconjugacy hf hlabel, hsurj⟩

/-- Reading coordinate zero is the canonical observable on the full shift. -/
def headSymbol (x : OneSidedSequence A) : A := x 0

/-- The itinerary of the head observable on the full shift is the original
sequence itself. -/
@[simp]
theorem itinerary_oneSidedShift_headSymbol (x : OneSidedSequence A) :
    itinerary oneSidedShift headSymbol x = x := by
  ext n
  simp [headSymbol]

/-- The canonical head-itinerary coding of the full shift is injective. -/
theorem injective_itinerary_oneSidedShift_headSymbol :
    Injective (itinerary (A := A) oneSidedShift headSymbol) := by
  intro x y h
  simpa using h

/-- The canonical head-itinerary coding of the full shift is surjective. -/
theorem surjective_itinerary_oneSidedShift_headSymbol :
    Surjective (itinerary (A := A) oneSidedShift headSymbol) := by
  intro x
  exact ⟨x, itinerary_oneSidedShift_headSymbol x⟩

#print axioms oneSidedShift_isTopologicallyTransitive
#print axioms oneSidedShift_hasDensePeriodicPoints
#print axioms oneSidedShift_isDevaneyChaotic
#print axioms itinerary_isTopologicalFactorMap

end NonlinearDynamics.Deterministic.Chaos
