import NonlinearDynamics.Random.RandomCocycles.SubadditivePhaseAveraging

/-!
# Finite ordered interval packing

This module encodes a finite ordered family of nonempty half-open
natural intervals by the gaps before them, their lengths, and the remaining
tail horizon.  The representation makes order, disjointness, containment,
abutting intervals, and zero gaps structural rather than propositional.
-/

open MeasureTheory

noncomputable section

namespace NonlinearDynamics.Random.RandomCocycles

universe uΩ uι

/-- An ordered packing of nonempty half-open natural intervals inside a
horizon. `empty N` selects no intervals from `[0, N)`. In
`cons gap length h rest`, the first selected interval is
`[gap, gap + length)` and every interval in `rest` is shifted by
`gap + length`. Gaps may be zero, so selected intervals may abut. -/
inductive OrderedNatIntervalPacking : ℕ → Type
  | empty (horizon : ℕ) : OrderedNatIntervalPacking horizon
  | cons (gap length : ℕ) {tail : ℕ} (length_pos : 0 < length)
      (rest : OrderedNatIntervalPacking tail) :
      OrderedNatIntervalPacking (gap + length + tail)

namespace OrderedNatIntervalPacking

/-- The number of selected intervals. -/
def intervalCount {N : ℕ} : OrderedNatIntervalPacking N → ℕ
  | .empty _ => 0
  | .cons _ _ _ rest => rest.intervalCount + 1

/-- The total number of natural-time positions covered by selected intervals. -/
def coveredLength {N : ℕ} : OrderedNatIntervalPacking N → ℕ
  | .empty _ => 0
  | .cons _ length _ rest => length + rest.coveredLength

/-- Recover the selected half-open endpoints, shifted by an ambient offset. -/
def intervalsFrom {N : ℕ} :
    OrderedNatIntervalPacking N → ℕ → List (ℕ × ℕ)
  | .empty _, _ => []
  | .cons gap length _ rest, offset =>
      (offset + gap, offset + gap + length) ::
        rest.intervalsFrom (offset + gap + length)

/-- Recover the selected half-open endpoints in the ambient horizon `[0, N)`. -/
def intervals {N : ℕ} (P : OrderedNatIntervalPacking N) : List (ℕ × ℕ) :=
  P.intervalsFrom 0

/-- Recovering intervals preserves the structural interval count. -/
theorem length_intervalsFrom {N offset : ℕ}
    (P : OrderedNatIntervalPacking N) :
    (P.intervalsFrom offset).length = P.intervalCount := by
  induction P generalizing offset with
  | empty horizon => simp [intervalsFrom, intervalCount]
  | @cons gap ell tail hell rest ih =>
      simp [intervalsFrom, intervalCount, ih]

/-- The recovered interval list has exactly `intervalCount` entries. -/
theorem length_intervals {N : ℕ} (P : OrderedNatIntervalPacking N) :
    P.intervals.length = P.intervalCount :=
  P.length_intervalsFrom

/-- The finite set of natural-time positions covered by the packing, shifted
by an ambient offset. -/
def coveredFinsetFrom {N : ℕ} :
    OrderedNatIntervalPacking N → ℕ → Finset ℕ
  | .empty _, _ => ∅
  | .cons gap length _ rest, offset =>
      Finset.Ico (offset + gap) (offset + gap + length) ∪
        rest.coveredFinsetFrom (offset + gap + length)

/-- The finite set of selected positions in `[0, N)`. -/
def coveredFinset {N : ℕ} (P : OrderedNatIntervalPacking N) : Finset ℕ :=
  P.coveredFinsetFrom 0

/-- Membership in the covered finite set is witnessed by one recovered
half-open interval. -/
theorem mem_coveredFinsetFrom_iff_exists_interval {N offset j : ℕ}
    (P : OrderedNatIntervalPacking N) :
    j ∈ P.coveredFinsetFrom offset ↔
      ∃ I ∈ P.intervalsFrom offset, I.1 ≤ j ∧ j < I.2 := by
  induction P generalizing offset with
  | empty horizon => simp [coveredFinsetFrom, intervalsFrom]
  | @cons gap ell tail hell rest ih =>
      simp only [coveredFinsetFrom, intervalsFrom, Finset.mem_union,
        Finset.mem_Ico, List.mem_cons, ih]
      aesop

/-- A position is covered exactly when it belongs to one recovered half-open
interval. -/
theorem mem_coveredFinset_iff_exists_interval {N j : ℕ}
    (P : OrderedNatIntervalPacking N) :
    j ∈ P.coveredFinset ↔
      ∃ I ∈ P.intervals, I.1 ≤ j ∧ j < I.2 :=
  P.mem_coveredFinsetFrom_iff_exists_interval

/-- Every selected position lies inside the shifted ambient horizon. -/
theorem mem_coveredFinsetFrom_bounds {N offset j : ℕ}
    (P : OrderedNatIntervalPacking N)
    (hj : j ∈ P.coveredFinsetFrom offset) :
    offset ≤ j ∧ j < offset + N := by
  induction P generalizing offset with
  | empty horizon => simp [coveredFinsetFrom] at hj
  | @cons gap length tail hlength rest ih =>
      simp only [coveredFinsetFrom, Finset.mem_union, Finset.mem_Ico] at hj
      rcases hj with hj | hj
      · omega
      · have hrest := ih hj
        omega

/-- The cardinality of the selected finite set is exactly the sum of the
selected interval lengths. -/
theorem card_coveredFinsetFrom {N offset : ℕ}
    (P : OrderedNatIntervalPacking N) :
    (P.coveredFinsetFrom offset).card = P.coveredLength := by
  induction P generalizing offset with
  | empty horizon => simp [coveredFinsetFrom, coveredLength]
  | @cons gap length tail hlength rest ih =>
      have hdisjoint :
          Disjoint
            (Finset.Ico (offset + gap) (offset + gap + length))
            (rest.coveredFinsetFrom (offset + gap + length)) := by
        rw [Finset.disjoint_left]
        intro j hjInterval hjRest
        rw [Finset.mem_Ico] at hjInterval
        have hrest := rest.mem_coveredFinsetFrom_bounds hjRest
        omega
      rw [coveredFinsetFrom, Finset.card_union_of_disjoint hdisjoint,
        Nat.card_Ico, ih]
      simp only [coveredLength]
      omega

/-- The covered finite set has cardinality equal to `coveredLength`. -/
theorem card_coveredFinset {N : ℕ} (P : OrderedNatIntervalPacking N) :
    P.coveredFinset.card = P.coveredLength :=
  P.card_coveredFinsetFrom

/-- The covered positions lie in the ambient half-open horizon. -/
theorem coveredFinset_subset_range {N : ℕ}
    (P : OrderedNatIntervalPacking N) :
    P.coveredFinset ⊆ Finset.range N := by
  intro j hj
  rw [Finset.mem_range]
  simpa only [zero_add] using (P.mem_coveredFinsetFrom_bounds hj).2

/-- A finite set of marked starts is covered when every marked position lies
in one of the selected intervals. -/
def Covers {N : ℕ} (P : OrderedNatIntervalPacking N) (marked : Finset ℕ) :
    Prop := marked ⊆ P.coveredFinset

/-- Covering a nonempty marked set forces the packing itself to be nonempty. -/
theorem intervalCount_ne_zero_of_covers_of_nonempty {N : ℕ}
    (P : OrderedNatIntervalPacking N) {marked : Finset ℕ}
    (hcover : P.Covers marked) (hmarked : marked.Nonempty) :
    P.intervalCount ≠ 0 := by
  cases P with
  | empty horizon =>
      obtain ⟨j, hj⟩ := hmarked
      have := hcover hj
      simp [coveredFinset, coveredFinsetFrom] at this
  | @cons gap ell tail hell rest =>
      simp [intervalCount]

/-- Covering a finite marked set forces its cardinality below the selected
length. This is the finite counting bridge used after a greedy selection. -/
theorem card_le_coveredLength_of_covers {N : ℕ}
    (P : OrderedNatIntervalPacking N) (marked : Finset ℕ)
    (hcover : P.Covers marked) :
    marked.card ≤ P.coveredLength := by
  rw [← P.card_coveredFinset]
  exact Finset.card_le_card hcover

/-- Every recovered interval is nonempty and lies inside the shifted ambient
horizon. -/
theorem intervalsFrom_inside {N offset : ℕ}
    (P : OrderedNatIntervalPacking N) {I : ℕ × ℕ}
    (hI : I ∈ P.intervalsFrom offset) :
    offset ≤ I.1 ∧ I.1 < I.2 ∧ I.2 ≤ offset + N := by
  induction P generalizing offset with
  | empty horizon => simp [intervalsFrom] at hI
  | @cons gap length tail hlength rest ih =>
      simp only [intervalsFrom, List.mem_cons] at hI
      rcases hI with rfl | hI
      · omega
      · have hrest := ih hI
        omega

/-- The recovered intervals occur in endpoint order. In particular, they are
pairwise disjoint as half-open sets; equality permits abutting intervals. -/
theorem intervalsFrom_pairwise {N offset : ℕ}
    (P : OrderedNatIntervalPacking N) :
    (P.intervalsFrom offset).Pairwise (fun I J => I.2 ≤ J.1) := by
  induction P generalizing offset with
  | empty horizon => simp [intervalsFrom]
  | @cons gap length tail hlength rest ih =>
      rw [intervalsFrom, List.pairwise_cons]
      constructor
      · intro I hI
        have hinside := rest.intervalsFrom_inside hI
        omega
      · exact ih

/-- Endpoint order for intervals recovered in `[0, N)`. -/
theorem intervals_pairwise {N : ℕ} (P : OrderedNatIntervalPacking N) :
    P.intervals.Pairwise (fun I J => I.2 ≤ J.1) :=
  P.intervalsFrom_pairwise

/-- The recovered half-open intervals are pairwise disjoint as sets. -/
theorem intervals_pairwiseDisjoint_Ico {N : ℕ}
    (P : OrderedNatIntervalPacking N) :
    P.intervals.Pairwise
      (fun I J => Disjoint (Set.Ico I.1 I.2) (Set.Ico J.1 J.2)) := by
  apply P.intervals_pairwise.imp
  intro I J hIJ
  exact Set.disjoint_left.mpr fun _ hI hJ =>
    hI.2.not_ge (hIJ.trans hJ.1)

/-- Every interval recovered in `[0, N)` is nonempty and contained in that
horizon. -/
theorem intervals_inside {N : ℕ} (P : OrderedNatIntervalPacking N)
    {I : ℕ × ℕ} (hI : I ∈ P.intervals) :
    I.1 < I.2 ∧ I.2 ≤ N := by
  have h := P.intervalsFrom_inside hI
  simpa only [Nat.zero_le, zero_add, true_and] using h

/-- Recursive certificate that every selected interval starts at an absolute
marked position and has the length prescribed there. The offset is the
absolute origin of the current recursive packing. -/
def SelectedFromFrom {N : ℕ} (P : OrderedNatIntervalPacking N)
    (offset : ℕ) (marked : Finset ℕ) (length : ℕ → ℕ) : Prop :=
  match P with
  | .empty _ => True
  | .cons gap ell _ rest =>
      offset + gap ∈ marked ∧
        ell = length (offset + gap) ∧
          rest.SelectedFromFrom (offset + gap + ell) marked length

/-- Every interval in the packing is selected from `marked` with its
prescribed length. -/
def SelectedFrom {N : ℕ} (P : OrderedNatIntervalPacking N)
    (marked : Finset ℕ) (length : ℕ → ℕ) : Prop :=
  P.SelectedFromFrom 0 marked length

/-- Enlarging the set of eligible marked starts preserves a recursive
selection certificate. -/
theorem SelectedFromFrom.mono {N offset : ℕ}
    (P : OrderedNatIntervalPacking N) {selected marked : Finset ℕ}
    {length : ℕ → ℕ} (hselected : P.SelectedFromFrom offset selected length)
    (hsubset : selected ⊆ marked) :
    P.SelectedFromFrom offset marked length := by
  induction P generalizing offset with
  | empty horizon => trivial
  | @cons gap ell tail hell rest ih =>
      exact ⟨hsubset hselected.1, hselected.2.1,
        ih hselected.2.2⟩

/-- The recursive selection certificate exposes the corresponding statement
about every recovered half-open interval. -/
theorem SelectedFromFrom.intervalsFrom_chosen {N offset : ℕ}
    (P : OrderedNatIntervalPacking N) {marked : Finset ℕ}
    {length : ℕ → ℕ} (hselected : P.SelectedFromFrom offset marked length)
    {I : ℕ × ℕ} (hI : I ∈ P.intervalsFrom offset) :
    I.1 ∈ marked ∧ I.2 = I.1 + length I.1 := by
  induction P generalizing offset I with
  | empty horizon => simp [intervalsFrom] at hI
  | @cons gap ell tail hell rest ih =>
      simp only [intervalsFrom, List.mem_cons] at hI
      rcases hI with rfl | hI
      · exact ⟨hselected.1, by rw [hselected.2.1]⟩
      · exact ih hselected.2.2 hI

/-- Public zero-offset form of `SelectedFromFrom.intervalsFrom_chosen`. -/
theorem SelectedFrom.intervals_chosen {N : ℕ}
    (P : OrderedNatIntervalPacking N) {marked : Finset ℕ}
    {length : ℕ → ℕ} (hselected : P.SelectedFrom marked length)
    {I : ℕ × ℕ} (hI : I ∈ P.intervals) :
    I.1 ∈ marked ∧ I.2 = I.1 + length I.1 :=
  SelectedFromFrom.intervalsFrom_chosen (P := P) (offset := 0)
    hselected hI

/-- For a greedy certificate whose eligible starts lie in `[0, H)` and whose
chosen lengths are at most `m`, every selected right endpoint is strictly
below the enlarged horizon `H + m`. This terminal slack is stronger than the
generic packing containment theorem, which correctly permits equality. -/
theorem SelectedFrom.interval_end_lt_enlargedHorizon {N H m : ℕ}
    (P : OrderedNatIntervalPacking N) {marked : Finset ℕ}
    {length : ℕ → ℕ} (hselected : P.SelectedFrom marked length)
    (hmarked : marked ⊆ Finset.range H)
    (hlength : ∀ j ∈ marked, length j ≤ m)
    {I : ℕ × ℕ} (hI : I ∈ P.intervals) :
    I.2 < H + m := by
  have hchosen := SelectedFrom.intervals_chosen (P := P) hselected hI
  have hstart : I.1 < H := Finset.mem_range.mp (hmarked hchosen.1)
  have hlen := hlength I.1 hchosen.1
  omega

/-- Offset form of the left-to-right greedy interval selector. The first
remaining marked start is selected, every mark inside that interval is
discarded, and recursion continues to its right. -/
private theorem exists_orderedPacking_covering_from
    (m : ℕ) (length : ℕ → ℕ) :
    ∀ (offset H : ℕ) (marked : Finset ℕ),
      marked ⊆ Finset.Ico offset (offset + H) →
      (∀ j ∈ marked, 0 < length j ∧ length j ≤ m) →
      ∃ P : OrderedNatIntervalPacking (H + m),
        marked ⊆ P.coveredFinsetFrom offset ∧
          P.SelectedFromFrom offset marked length := by
  classical
  intro offset H marked hmarked hlength
  induction H using Nat.strong_induction_on generalizing offset marked with
  | h H ih =>
      by_cases hempty : marked = ∅
      · subst marked
        refine ⟨.empty (H + m), ?_, ?_⟩
        · simp [coveredFinsetFrom]
        · trivial
      · have hnonempty : marked.Nonempty := Finset.nonempty_of_ne_empty hempty
        let j := marked.min' hnonempty
        have hjmem : j ∈ marked := by
          simpa only [j] using marked.min'_mem hnonempty
        have hjmin : ∀ k ∈ marked, j ≤ k := by
          intro k hk
          simpa only [j] using marked.min'_le k hk
        have hjbounds : offset ≤ j ∧ j < offset + H := by
          exact Finset.mem_Ico.mp (hmarked hjmem)
        let ell := length j
        have hell : 0 < ell ∧ ell ≤ m := by
          simpa only [ell] using hlength j hjmem
        have hgap : offset + (j - offset) = j := by omega
        by_cases hend : j + ell ≤ offset + H
        · let tailH := offset + H - (j + ell)
          let remaining := marked.filter (j + ell ≤ ·)
          have htail_end : j + ell + tailH = offset + H := by
            dsimp only [tailH]
            omega
          have htail_lt : tailH < H := by
            dsimp only [tailH]
            omega
          have hremaining :
              remaining ⊆ Finset.Ico (j + ell) (j + ell + tailH) := by
            intro k hk
            have hk' := Finset.mem_filter.mp hk
            exact Finset.mem_Ico.mpr ⟨hk'.2, by
              rw [htail_end]
              exact (Finset.mem_Ico.mp (hmarked hk'.1)).2⟩
          have hremaining_length :
              ∀ k ∈ remaining, 0 < length k ∧ length k ≤ m := by
            intro k hk
            exact hlength k (Finset.mem_filter.mp hk).1
          obtain ⟨rest, hcover_rest, hselect_rest⟩ :=
            ih tailH htail_lt (j + ell) remaining hremaining hremaining_length
          have hindex :
              (j - offset) + ell + (tailH + m) = H + m := by
            omega
          have hresult :
              ∃ P : OrderedNatIntervalPacking
                  ((j - offset) + ell + (tailH + m)),
                marked ⊆ P.coveredFinsetFrom offset ∧
                  P.SelectedFromFrom offset marked length := by
            let P : OrderedNatIntervalPacking
                ((j - offset) + ell + (tailH + m)) :=
              .cons (j - offset) ell hell.1 rest
            refine ⟨P, ?_, ?_⟩
            · intro k hk
              have hjk := hjmin k hk
              simp only [P, coveredFinsetFrom, Finset.mem_union]
              rw [hgap]
              by_cases hkfirst : k < j + ell
              · exact Or.inl (Finset.mem_Ico.mpr ⟨hjk, hkfirst⟩)
              · apply Or.inr
                apply hcover_rest
                exact Finset.mem_filter.mpr
                  ⟨hk, Nat.le_of_not_gt hkfirst⟩
            · simp only [P, SelectedFromFrom]
              rw [hgap]
              exact ⟨hjmem, by simp only [ell],
                SelectedFromFrom.mono (P := rest) hselect_rest
                  (Finset.filter_subset _ _)⟩
          rw [hindex] at hresult
          exact hresult
        · let tail := H + m - ((j - offset) + ell)
          have hfit : (j - offset) + ell ≤ H + m := by omega
          have hindex : (j - offset) + ell + tail = H + m := by
            dsimp only [tail]
            omega
          have hresult :
              ∃ P : OrderedNatIntervalPacking ((j - offset) + ell + tail),
                marked ⊆ P.coveredFinsetFrom offset ∧
                  P.SelectedFromFrom offset marked length := by
            let P : OrderedNatIntervalPacking ((j - offset) + ell + tail) :=
              .cons (j - offset) ell hell.1 (.empty tail)
            refine ⟨P, ?_, ?_⟩
            · intro k hk
              have hjk := hjmin k hk
              have hkbound := (Finset.mem_Ico.mp (hmarked hk)).2
              simp only [P, coveredFinsetFrom, Finset.union_empty,
                Finset.mem_Ico]
              rw [hgap]
              exact ⟨hjk, by omega⟩
            · simp only [P, SelectedFromFrom]
              rw [hgap]
              exact ⟨hjmem, by simp only [ell], trivial⟩
          rw [hindex] at hresult
          exact hresult

/-- A finite left-to-right greedy selection. Every marked start lies in the
selected union. Every selected interval begins at a marked point and has the
prescribed positive length there. The selected intervals are ordered,
pairwise disjoint, and contained in `[0, H + m)` by the packing type and its
structural theorems. -/
theorem exists_orderedPacking_covering
    (H m : ℕ) (marked : Finset ℕ) (length : ℕ → ℕ)
    (hmarked : marked ⊆ Finset.range H)
    (hlength : ∀ j ∈ marked, 0 < length j ∧ length j ≤ m) :
    ∃ P : OrderedNatIntervalPacking (H + m),
      P.Covers marked ∧
        P.SelectedFrom marked length := by
  classical
  have hmarked' : marked ⊆ Finset.Ico 0 (0 + H) := by
    simpa only [Nat.Ico_zero_eq_range, zero_add] using hmarked
  obtain ⟨P, hcover, hselect⟩ :=
    exists_orderedPacking_covering_from m length 0 H marked hmarked' hlength
  refine ⟨P, ?_, ?_⟩
  · simpa only [Covers, coveredFinset, zero_add] using hcover
  · simpa only [SelectedFrom, zero_add] using hselect

/-- The selected subadditive-process costs, evaluated at their absolute start
times. -/
def cost {N : ℕ} (P : OrderedNatIntervalPacking N)
    {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (ω : Ω) : ℝ :=
  match P with
  | .empty _ => 0
  | .cons gap length _ rest =>
      X length (T^[gap] ω) +
        rest.cost T X (T^[gap + length] ω)

/-- The selected length never exceeds the ambient horizon. -/
theorem coveredLength_le_horizon {N : ℕ}
    (P : OrderedNatIntervalPacking N) : P.coveredLength ≤ N := by
  induction P with
  | empty horizon => simp [coveredLength]
  | @cons gap length tail hlength rest ih =>
      simp only [coveredLength]
      omega

/-- A nonempty ordered packing has a positive ambient horizon. -/
theorem horizon_pos_of_intervalCount_ne_zero {N : ℕ}
    (P : OrderedNatIntervalPacking N) (hP : P.intervalCount ≠ 0) : 0 < N := by
  induction P with
  | empty horizon => simp [intervalCount] at hP
  | @cons gap length tail hlength rest ih => omega

/-- A pointwise upper bound for every selected interval cost. -/
def EveryIntervalCostLE {N : ℕ} (P : OrderedNatIntervalPacking N)
    {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (ω : Ω) (c : ℝ) : Prop :=
  match P with
  | .empty _ => True
  | .cons gap length _ rest =>
      X length (T^[gap] ω) ≤ c * (length : ℝ) ∧
        rest.EveryIntervalCostLE T X (T^[gap + length] ω) c

/-- A strict pointwise upper bound for every selected interval cost. -/
def EveryIntervalCostLT {N : ℕ} (P : OrderedNatIntervalPacking N)
    {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (ω : Ω) (c : ℝ) : Prop :=
  match P with
  | .empty _ => True
  | .cons gap length _ rest =>
      X length (T^[gap] ω) < c * (length : ℝ) ∧
        rest.EveryIntervalCostLT T X (T^[gap + length] ω) c

/-- Strict interval bounds imply their weak counterparts. -/
theorem EveryIntervalCostLT.le {N : ℕ} (P : OrderedNatIntervalPacking N)
    {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (ω : Ω) (c : ℝ)
    (hcost : P.EveryIntervalCostLT T X ω c) :
    P.EveryIntervalCostLE T X ω c := by
  induction P generalizing ω with
  | empty horizon => trivial
  | @cons gap length tail hlength rest ih =>
      exact ⟨hcost.1.le, ih _ hcost.2⟩

/-- A recursive selection certificate transports weak marked-start bounds to
the recursively shifted per-interval cost predicate. -/
theorem SelectedFromFrom.everyIntervalCostLE {N offset : ℕ}
    (P : OrderedNatIntervalPacking N) {marked : Finset ℕ}
    {length : ℕ → ℕ} {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ)
    (ω : Ω) (c : ℝ)
    (hselected : P.SelectedFromFrom offset marked length)
    (hcost : ∀ j ∈ marked,
      X (length j) (T^[j] ω) ≤ c * (length j : ℝ)) :
    P.EveryIntervalCostLE T X (T^[offset] ω) c := by
  induction P generalizing offset with
  | empty horizon => trivial
  | @cons gap ell tail hell rest ih =>
      change offset + gap ∈ marked ∧
        ell = length (offset + gap) ∧
          rest.SelectedFromFrom (offset + gap + ell) marked length at hselected
      change X ell (T^[gap] (T^[offset] ω)) ≤ c * (ell : ℝ) ∧
        rest.EveryIntervalCostLE T X
          (T^[gap + ell] (T^[offset] ω)) c
      have hfirstOrbit :
          T^[gap] (T^[offset] ω) = T^[offset + gap] ω := by
        calc
          T^[gap] (T^[offset] ω) = T^[gap + offset] ω :=
            (Function.iterate_add_apply T gap offset ω).symm
          _ = T^[offset + gap] ω := by rw [Nat.add_comm gap offset]
      have hrestOrbit :
          T^[gap + ell] (T^[offset] ω) =
            T^[offset + gap + ell] ω := by
        calc
          T^[gap + ell] (T^[offset] ω) =
              T^[(gap + ell) + offset] ω :=
            (Function.iterate_add_apply T (gap + ell) offset ω).symm
          _ = T^[offset + gap + ell] ω :=
            congrArg (fun n : ℕ => T^[n] ω) (by omega)
      constructor
      · rw [hselected.2.1, hfirstOrbit]
        exact hcost (offset + gap) hselected.1
      · rw [hrestOrbit]
        exact ih hselected.2.2

/-- Strict marked-start bounds transport to strict bounds on every selected
interval. -/
theorem SelectedFromFrom.everyIntervalCostLT {N offset : ℕ}
    (P : OrderedNatIntervalPacking N) {marked : Finset ℕ}
    {length : ℕ → ℕ} {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ)
    (ω : Ω) (c : ℝ)
    (hselected : P.SelectedFromFrom offset marked length)
    (hcost : ∀ j ∈ marked,
      X (length j) (T^[j] ω) < c * (length j : ℝ)) :
    P.EveryIntervalCostLT T X (T^[offset] ω) c := by
  induction P generalizing offset with
  | empty horizon => trivial
  | @cons gap ell tail hell rest ih =>
      change offset + gap ∈ marked ∧
        ell = length (offset + gap) ∧
          rest.SelectedFromFrom (offset + gap + ell) marked length at hselected
      change X ell (T^[gap] (T^[offset] ω)) < c * (ell : ℝ) ∧
        rest.EveryIntervalCostLT T X
          (T^[gap + ell] (T^[offset] ω)) c
      have hfirstOrbit :
          T^[gap] (T^[offset] ω) = T^[offset + gap] ω := by
        calc
          T^[gap] (T^[offset] ω) = T^[gap + offset] ω :=
            (Function.iterate_add_apply T gap offset ω).symm
          _ = T^[offset + gap] ω := by rw [Nat.add_comm gap offset]
      have hrestOrbit :
          T^[gap + ell] (T^[offset] ω) =
            T^[offset + gap + ell] ω := by
        calc
          T^[gap + ell] (T^[offset] ω) =
              T^[(gap + ell) + offset] ω :=
            (Function.iterate_add_apply T (gap + ell) offset ω).symm
          _ = T^[offset + gap + ell] ω :=
            congrArg (fun n : ℕ => T^[n] ω) (by omega)
      constructor
      · rw [hselected.2.1, hfirstOrbit]
        exact hcost (offset + gap) hselected.1
      · rw [hrestOrbit]
        exact ih hselected.2.2

/-- Public zero-offset weak cost bridge. -/
theorem SelectedFrom.everyIntervalCostLE {N : ℕ}
    (P : OrderedNatIntervalPacking N) {marked : Finset ℕ}
    {length : ℕ → ℕ} {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ)
    (ω : Ω) (c : ℝ) (hselected : P.SelectedFrom marked length)
    (hcost : ∀ j ∈ marked,
      X (length j) (T^[j] ω) ≤ c * (length j : ℝ)) :
    P.EveryIntervalCostLE T X ω c := by
  simpa only [Function.iterate_zero_apply] using
    SelectedFromFrom.everyIntervalCostLE (P := P) (offset := 0)
      T X ω c hselected hcost

/-- Public zero-offset strict cost bridge. -/
theorem SelectedFrom.everyIntervalCostLT {N : ℕ}
    (P : OrderedNatIntervalPacking N) {marked : Finset ℕ}
    {length : ℕ → ℕ} {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ)
    (ω : Ω) (c : ℝ) (hselected : P.SelectedFrom marked length)
    (hcost : ∀ j ∈ marked,
      X (length j) (T^[j] ω) < c * (length j : ℝ)) :
    P.EveryIntervalCostLT T X ω c := by
  simpa only [Function.iterate_zero_apply] using
    SelectedFromFrom.everyIntervalCostLT (P := P) (offset := 0)
      T X ω c hselected hcost

/-- Summing a common per-unit bound over selected intervals bounds the total
packing cost by that scalar times the covered length. -/
theorem cost_le_mul_coveredLength {N : ℕ} (P : OrderedNatIntervalPacking N)
    {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (ω : Ω) (c : ℝ)
    (hcost : P.EveryIntervalCostLE T X ω c) :
    P.cost T X ω ≤ c * (P.coveredLength : ℝ) := by
  induction P generalizing ω with
  | empty horizon => simp [cost, coveredLength]
  | @cons gap length tail hlength rest ih =>
      change X length (T^[gap] ω) ≤ c * (length : ℝ) ∧
        rest.EveryIntervalCostLE T X (T^[gap + length] ω) c at hcost
      change X length (T^[gap] ω) +
          rest.cost T X (T^[gap + length] ω) ≤
        c * ((length + rest.coveredLength : ℕ) : ℝ)
      calc
        X length (T^[gap] ω) +
              rest.cost T X (T^[gap + length] ω) ≤
            c * (length : ℝ) + c * (rest.coveredLength : ℝ) :=
          add_le_add hcost.1 (ih _ hcost.2)
        _ = c * ((length + rest.coveredLength : ℕ) : ℝ) := by
          simp only [Nat.cast_add]
          ring

/-- For a nonempty packing, strict per-interval bounds sum to a strict bound
for the total cost. The nonempty premise is necessary because an empty sum is
not strictly below itself. -/
theorem cost_lt_mul_coveredLength {N : ℕ} (P : OrderedNatIntervalPacking N)
    {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (ω : Ω) (c : ℝ)
    (hP : P.intervalCount ≠ 0)
    (hcost : P.EveryIntervalCostLT T X ω c) :
    P.cost T X ω < c * (P.coveredLength : ℝ) := by
  cases P with
  | empty horizon => simp [intervalCount] at hP
  | @cons gap length tail hlength rest =>
      change X length (T^[gap] ω) +
          rest.cost T X (T^[gap + length] ω) <
        c * ((length + rest.coveredLength : ℕ) : ℝ)
      calc
        X length (T^[gap] ω) +
              rest.cost T X (T^[gap + length] ω) <
            c * (length : ℝ) + c * (rest.coveredLength : ℝ) :=
          add_lt_add_of_lt_of_le hcost.1
            (rest.cost_le_mul_coveredLength T X _ c hcost.2.le)
        _ = c * ((length + rest.coveredLength : ℕ) : ℝ) := by
          simp only [Nat.cast_add]
          ring

/-- Raw finite interval-packing inequality. It uses only shifted
subadditivity and nonpositivity at positive horizons. The explicit positive
ambient horizon is necessary exactly for the empty packing at horizon zero. -/
theorem le_cost_of_add_le_nonpos
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    {N : ℕ} (P : OrderedNatIntervalPacking N) (hN : N ≠ 0) (ω : Ω) :
    X N ω ≤ P.cost T X ω := by
  induction P generalizing ω with
  | empty horizon =>
      simpa only [cost] using hnonpos horizon hN ω
  | @cons gap length tail hlength rest ih =>
      have hbody :
          X (length + tail) (T^[gap] ω) ≤
            X length (T^[gap] ω) +
              rest.cost T X (T^[gap + length] ω) := by
        cases rest with
        | empty tail =>
            by_cases htail : tail = 0
            · subst tail
              simp only [cost, add_zero]
              exact le_rfl
            · have hsplit := hadd length tail (T^[gap] ω)
              have htail_nonpos :=
                hnonpos tail htail (T^[length] (T^[gap] ω))
              simp only [cost, add_zero]
              linarith
        | @cons nextGap nextLength nextTail hnextLength nextRest =>
            have htail : nextGap + nextLength + nextTail ≠ 0 := by omega
            have hrest := ih htail (T^[gap + length] ω)
            have hsplit :=
              hadd length (nextGap + nextLength + nextTail) (T^[gap] ω)
            rw [← Function.iterate_add_apply] at hsplit
            rw [Nat.add_comm length gap] at hsplit
            linarith
      by_cases hgap : gap = 0
      · subst gap
        simpa only [cost, Function.iterate_zero_apply, zero_add] using hbody
      · have hsplit := hadd gap (length + tail) ω
        have hsplit' :
            X (gap + length + tail) ω ≤
              X (length + tail) (T^[gap] ω) + X gap ω := by
          simpa only [Nat.add_assoc] using hsplit
        have hgap_nonpos := hnonpos gap hgap ω
        simpa only [cost] using (show
          X (gap + length + tail) ω ≤
            X length (T^[gap] ω) +
              rest.cost T X (T^[gap + length] ω) by
                linarith)

/-- Nonempty-pack form of the raw inequality. Here positivity of the ambient
horizon follows from the existence of a selected nonempty interval. -/
theorem le_cost_of_add_le_nonpos_of_nonempty
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    {N : ℕ} (P : OrderedNatIntervalPacking N)
    (hP : P.intervalCount ≠ 0) (ω : Ω) :
    X N ω ≤ P.cost T X ω :=
  P.le_cost_of_add_le_nonpos hadd hnonpos
    (Nat.ne_of_gt (P.horizon_pos_of_intervalCount_ne_zero hP)) ω

/-- The favorable-interval form: if every selected interval has cost at most
`c` times its length, then the whole horizon is bounded by `c` times the
covered length. -/
theorem le_mul_coveredLength_of_add_le_nonpos
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    {N : ℕ} (P : OrderedNatIntervalPacking N) (hN : N ≠ 0)
    (ω : Ω) (c : ℝ) (hcost : P.EveryIntervalCostLE T X ω c) :
    X N ω ≤ c * (P.coveredLength : ℝ) :=
  (P.le_cost_of_add_le_nonpos hadd hnonpos hN ω).trans
    (P.cost_le_mul_coveredLength T X ω c hcost)

/-- Strict favorable-interval form for a nonempty packing. -/
theorem lt_mul_coveredLength_of_add_le_nonpos
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    {N : ℕ} (P : OrderedNatIntervalPacking N)
    (hP : P.intervalCount ≠ 0) (ω : Ω) (c : ℝ)
    (hcost : P.EveryIntervalCostLT T X ω c) :
    X N ω < c * (P.coveredLength : ℝ) :=
  (P.le_cost_of_add_le_nonpos_of_nonempty hadd hnonpos hP ω).trans_lt
    (P.cost_lt_mul_coveredLength T X ω c hP hcost)

/-- Weak marked-cardinality form for an arbitrary covering packing. A
nonpositive coefficient reverses the coverage cardinality comparison. The
positive-horizon premise is still necessary for an empty cover at time zero. -/
theorem le_mul_card_of_add_le_nonpos_of_covers
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    {N : ℕ} (P : OrderedNatIntervalPacking N) (hN : N ≠ 0)
    (marked : Finset ℕ) (hcover : P.Covers marked)
    (ω : Ω) (c : ℝ) (hc : c ≤ 0)
    (hcost : P.EveryIntervalCostLE T X ω c) :
    X N ω ≤ c * (marked.card : ℝ) := by
  have hcardNat : marked.card ≤ P.coveredLength :=
    P.card_le_coveredLength_of_covers marked hcover
  have hcardReal : (marked.card : ℝ) ≤ (P.coveredLength : ℝ) := by
    exact_mod_cast hcardNat
  exact (P.le_mul_coveredLength_of_add_le_nonpos hadd hnonpos hN ω c hcost).trans
    (mul_le_mul_of_nonpos_left hcardReal hc)

/-- Strict marked-cardinality form for a cover of a nonempty marked set.
Nonemptiness of the cover supplies the positive horizon and the strict
finite-sum boundary. -/
theorem lt_mul_card_of_add_le_nonpos_of_covers
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    {N : ℕ} (P : OrderedNatIntervalPacking N)
    (marked : Finset ℕ) (hmarked : marked.Nonempty)
    (hcover : P.Covers marked) (ω : Ω) (c : ℝ) (hc : c ≤ 0)
    (hcost : P.EveryIntervalCostLT T X ω c) :
    X N ω < c * (marked.card : ℝ) := by
  have hP : P.intervalCount ≠ 0 :=
    P.intervalCount_ne_zero_of_covers_of_nonempty hcover hmarked
  have hcardNat : marked.card ≤ P.coveredLength :=
    P.card_le_coveredLength_of_covers marked hcover
  have hcardReal : (marked.card : ℝ) ≤ (P.coveredLength : ℝ) := by
    exact_mod_cast hcardNat
  exact (P.lt_mul_coveredLength_of_add_le_nonpos hadd hnonpos hP ω c hcost).trans_le
    (mul_le_mul_of_nonpos_left hcardReal hc)

/-- The greedy selector turns weak marked-start estimates into a process bound
by the number of marked starts. The explicit positive enlarged horizon is
unavoidable when the marked set and selected packing are both empty. -/
theorem le_mul_card_of_greedy_cover
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ a b ω, X (a + b) ω ≤ X b (T^[a] ω) + X a ω)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    (H m : ℕ) (marked : Finset ℕ) (length : ℕ → ℕ)
    (hmarked : marked ⊆ Finset.range H)
    (hlength : ∀ j ∈ marked, 0 < length j ∧ length j ≤ m)
    (horizon_ne : H + m ≠ 0) (ω : Ω) (c : ℝ) (hc : c ≤ 0)
    (hcost : ∀ j ∈ marked,
      X (length j) (T^[j] ω) ≤ c * (length j : ℝ)) :
    X (H + m) ω ≤ c * (marked.card : ℝ) := by
  obtain ⟨P, hcover, hselected⟩ :=
    exists_orderedPacking_covering H m marked length hmarked hlength
  apply P.le_mul_card_of_add_le_nonpos_of_covers hadd hnonpos horizon_ne
    marked hcover ω c hc
  exact SelectedFrom.everyIntervalCostLE (P := P) T X ω c hselected hcost

/-- Strict marked-start estimates give the strict marked-cardinality process
bound when at least one marked start exists. No separate horizon premise is
needed: the selected positive-length interval makes the packing nonempty. -/
theorem lt_mul_card_of_greedy_cover
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ a b ω, X (a + b) ω ≤ X b (T^[a] ω) + X a ω)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    (H m : ℕ) (marked : Finset ℕ) (length : ℕ → ℕ)
    (hmarked : marked ⊆ Finset.range H)
    (hlength : ∀ j ∈ marked, 0 < length j ∧ length j ≤ m)
    (hmarked_nonempty : marked.Nonempty)
    (ω : Ω) (c : ℝ) (hc : c ≤ 0)
    (hcost : ∀ j ∈ marked,
      X (length j) (T^[j] ω) < c * (length j : ℝ)) :
    X (H + m) ω < c * (marked.card : ℝ) := by
  obtain ⟨P, hcover, hselected⟩ :=
    exists_orderedPacking_covering H m marked length hmarked hlength
  apply P.lt_mul_card_of_add_le_nonpos_of_covers hadd hnonpos marked
    hmarked_nonempty hcover ω c hc
  exact SelectedFrom.everyIntervalCostLT (P := P) T X ω c hselected hcost

/-- Candidate-facing form of the finite ordered interval-packing inequality.
The candidate's integrability field is carried by the receiver but not used. -/
theorem _root_.NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.le_orderedIntervalPackingSum
    {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
    {μ : Measure Ω} {X : ℕ → Ω → ℝ}
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    {N : ℕ} (P : OrderedNatIntervalPacking N) (hN : N ≠ 0) (ω : Ω) :
    X N ω ≤ P.cost T X ω :=
  P.le_cost_of_add_le_nonpos hX.add_le hnonpos hN ω

/-- Candidate-facing favorable-interval estimate. The receiver still carries
finite-horizon integrability, but this pointwise proof does not use it. -/
theorem _root_.NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.le_mul_coveredLength_of_orderedIntervalPacking
    {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
    {μ : Measure Ω} {X : ℕ → Ω → ℝ}
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    {N : ℕ} (P : OrderedNatIntervalPacking N) (hN : N ≠ 0)
    (ω : Ω) (c : ℝ) (hcost : P.EveryIntervalCostLE T X ω c) :
    X N ω ≤ c * (P.coveredLength : ℝ) :=
  P.le_mul_coveredLength_of_add_le_nonpos hX.add_le hnonpos hN ω c hcost

/-- Ordered interval packing for an orbit-majorant-centered process. It needs
neither a time-zero normalization nor an additional preservation hypothesis. -/
theorem _root_.NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.centeredProcess_le_orderedIntervalPackingSum
    {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
    {μ : Measure Ω} {X : ℕ → Ω → ℝ}
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    {N : ℕ} (P : OrderedNatIntervalPacking N) (hN : N ≠ 0) (ω : Ω) :
    centeredProcess T X N ω ≤ P.cost T (centeredProcess T X) ω :=
  P.le_cost_of_add_le_nonpos hX.centeredProcess_add_le
    hX.centeredProcess_nonpos_of_ne_zero hN ω

/-- Direct centered log-positive cocycle specialization. The cocycle already
stores base preservation, but this proof uses only finite algebra and imposes
no generator-integrability, probability, ergodicity, or nonempty-index
hypothesis. -/
theorem _root_.NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.centeredLogPlusNormObservable_le_orderedIntervalPackingSum
    {Ω : Type uΩ} {ι : Type uι} [MeasurableSpace Ω]
    [Fintype ι] [DecidableEq ι] {μ : Measure Ω}
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    {N : ℕ} (P : OrderedNatIntervalPacking N) (hN : N ≠ 0) (ω : Ω) :
    C.centeredLogPlusNormObservable N ω ≤
      P.cost C.base C.centeredLogPlusNormObservable ω :=
  P.le_cost_of_add_le_nonpos C.centeredLogPlusNormObservable_add_le
    (fun n _hn => C.centeredLogPlusNormObservable_nonpos n) hN ω

end OrderedNatIntervalPacking

section EdgeCaseSmokes

private def positiveAtZeroProcess (n : ℕ) (_u : Unit) : ℝ :=
  if n = 0 then 1 else -(n : ℝ)

private theorem positiveAtZeroProcess_add_le (m n : ℕ) (u : Unit) :
    positiveAtZeroProcess (m + n) u ≤
      positiveAtZeroProcess n ((id : Unit → Unit)^[m] u) +
        positiveAtZeroProcess m u := by
  by_cases hm : m = 0
  · subst m
    simp [positiveAtZeroProcess]
  by_cases hn : n = 0
  · subst n
    simp [positiveAtZeroProcess]
  simp [positiveAtZeroProcess, hm, hn]

private theorem positiveAtZeroProcess_nonpos
    (n : ℕ) (hn : n ≠ 0) (u : Unit) :
    positiveAtZeroProcess n u ≤ 0 := by
  simp [positiveAtZeroProcess, hn]

private theorem positiveAtZeroCandidate :
    IsIntegrableSubadditiveProcessCandidate (id : Unit → Unit)
      (0 : Measure Unit) positiveAtZeroProcess where
  integrable := by simp
  add_le := positiveAtZeroProcess_add_le

private def emptyPositivePacking : OrderedNatIntervalPacking 4 :=
  .empty 4

private def fullTerminalPacking : OrderedNatIntervalPacking 3 :=
  .cons 0 3 (by omega) (.empty 0)

private def abuttingPacking : OrderedNatIntervalPacking 5 :=
  .cons 0 2 (by omega) (.cons 0 3 (by omega) (.empty 0))

private def packingWithOuterGaps : OrderedNatIntervalPacking 6 :=
  .cons 1 2 (by omega) (.empty 3)

private def unitAbuttingPacking : OrderedNatIntervalPacking 4 :=
  .cons 0 1 (by omega)
    (.cons 0 1 (by omega)
      (.cons 0 1 (by omega) (.empty 1)))

private def packingWithIntermediateGap : OrderedNatIntervalPacking 5 :=
  .cons 0 1 (by omega) (.cons 2 1 (by omega) (.empty 1))

private def longChoice (j : ℕ) : ℕ :=
  if j = 0 then 3 else 1

private def longCoverPacking : OrderedNatIntervalPacking 5 :=
  .cons 0 3 (by omega) (.empty 2)

example : abuttingPacking.intervals = [(0, 2), (2, 5)] := by
  rfl

example : fullTerminalPacking.intervals = [(0, 3)] := by
  rfl

example : packingWithOuterGaps.intervals = [(1, 3)] := by
  rfl

example : unitAbuttingPacking.intervals = [(0, 1), (1, 2), (2, 3)] := by
  rfl

example : packingWithIntermediateGap.intervals = [(0, 1), (3, 4)] := by
  rfl

example : packingWithIntermediateGap.coveredFinset.card =
    packingWithIntermediateGap.coveredLength :=
  packingWithIntermediateGap.card_coveredFinset

example : longCoverPacking.intervals = [(0, 3)] := by
  rfl

example : longCoverPacking.Covers {0, 1} := by
  rw [OrderedNatIntervalPacking.Covers]
  intro j hj
  simp only [Finset.mem_insert, Finset.mem_singleton] at hj
  rcases hj with rfl | rfl <;>
    norm_num [OrderedNatIntervalPacking.coveredFinset,
      OrderedNatIntervalPacking.coveredFinsetFrom, longCoverPacking]

example : longCoverPacking.SelectedFrom {0, 1} longChoice := by
  norm_num [longCoverPacking, longChoice,
    OrderedNatIntervalPacking.SelectedFrom,
    OrderedNatIntervalPacking.SelectedFromFrom]

example : ({0, 1} : Finset ℕ).card < longCoverPacking.coveredLength := by
  norm_num [longCoverPacking, OrderedNatIntervalPacking.coveredLength]

example : unitAbuttingPacking.intervals.length =
    unitAbuttingPacking.intervalCount :=
  unitAbuttingPacking.length_intervals

example : unitAbuttingPacking.SelectedFrom (Finset.range 3) (fun _ => 1) := by
  norm_num [unitAbuttingPacking, OrderedNatIntervalPacking.SelectedFrom,
    OrderedNatIntervalPacking.SelectedFromFrom]

example : unitAbuttingPacking.Covers (Finset.range 3) := by
  rw [OrderedNatIntervalPacking.Covers]
  intro j hj
  simp only [Finset.mem_range] at hj
  norm_num [OrderedNatIntervalPacking.coveredFinset,
    OrderedNatIntervalPacking.coveredFinsetFrom, unitAbuttingPacking]
  omega

example : ∀ I ∈ unitAbuttingPacking.intervals, I.2 < 3 + 1 := by
  intro I hI
  apply OrderedNatIntervalPacking.SelectedFrom.interval_end_lt_enlargedHorizon
    (P := unitAbuttingPacking)
    (marked := Finset.range 3) (length := fun _ => 1)
  · norm_num [unitAbuttingPacking, OrderedNatIntervalPacking.SelectedFrom,
      OrderedNatIntervalPacking.SelectedFromFrom]
  · exact Finset.Subset.rfl
  · simp
  · exact hI

example : ∃ P : OrderedNatIntervalPacking (0 + 0),
    P.Covers ∅ ∧ P.SelectedFrom ∅ (fun _ => 1) := by
  apply OrderedNatIntervalPacking.exists_orderedPacking_covering
  · simp
  · simp

example : ∃ P : OrderedNatIntervalPacking (3 + 1),
    P.Covers (Finset.range 3) ∧
      P.SelectedFrom (Finset.range 3) (fun _ => 1) := by
  apply OrderedNatIntervalPacking.exists_orderedPacking_covering
  · exact Finset.Subset.rfl
  · simp

example : abuttingPacking.coveredLength = 5 := by
  rfl

example : abuttingPacking.coveredFinset = Finset.range 5 := by
  native_decide

example : packingWithOuterGaps.coveredFinset = {1, 2} := by
  native_decide

example : abuttingPacking.Covers (Finset.range 5) := by
  rw [OrderedNatIntervalPacking.Covers,
    show abuttingPacking.coveredFinset = Finset.range 5 by native_decide]

example : (Finset.range 5).card ≤ abuttingPacking.coveredLength := by
  apply abuttingPacking.card_le_coveredLength_of_covers
  rw [OrderedNatIntervalPacking.Covers,
    show abuttingPacking.coveredFinset = Finset.range 5 by native_decide]

example : positiveAtZeroProcess 0 () = 1 := by
  simp [positiveAtZeroProcess]

example :
    ¬positiveAtZeroProcess 0 () ≤
      (OrderedNatIntervalPacking.empty 0).cost id positiveAtZeroProcess () := by
  simp [positiveAtZeroProcess, OrderedNatIntervalPacking.cost]

example :
    positiveAtZeroProcess 4 () ≤
      emptyPositivePacking.cost id positiveAtZeroProcess () := by
  exact emptyPositivePacking.le_cost_of_add_le_nonpos
    positiveAtZeroProcess_add_le positiveAtZeroProcess_nonpos (by omega) ()

example :
    positiveAtZeroProcess 3 () =
      fullTerminalPacking.cost id positiveAtZeroProcess () := by
  norm_num [positiveAtZeroProcess, fullTerminalPacking,
    OrderedNatIntervalPacking.cost]

example :
    positiveAtZeroProcess 5 () =
      abuttingPacking.cost id positiveAtZeroProcess () := by
  norm_num [positiveAtZeroProcess, abuttingPacking,
    OrderedNatIntervalPacking.cost]

example :
    positiveAtZeroProcess 6 () ≤
      packingWithOuterGaps.cost id positiveAtZeroProcess () := by
  exact packingWithOuterGaps.le_cost_of_add_le_nonpos
    positiveAtZeroProcess_add_le positiveAtZeroProcess_nonpos (by omega) ()

example :
    positiveAtZeroProcess 5 () ≤ (-1 : ℝ) * abuttingPacking.coveredLength := by
  apply abuttingPacking.le_mul_coveredLength_of_add_le_nonpos
    positiveAtZeroProcess_add_le positiveAtZeroProcess_nonpos (by omega) ()
  norm_num [OrderedNatIntervalPacking.EveryIntervalCostLE,
    positiveAtZeroProcess, abuttingPacking]

example :
    positiveAtZeroProcess 5 () < (-(1 : ℝ) / 2) *
      abuttingPacking.coveredLength := by
  apply abuttingPacking.lt_mul_coveredLength_of_add_le_nonpos
    positiveAtZeroProcess_add_le positiveAtZeroProcess_nonpos
    (by norm_num [abuttingPacking, OrderedNatIntervalPacking.intervalCount]) ()
  norm_num [OrderedNatIntervalPacking.EveryIntervalCostLT,
    positiveAtZeroProcess, abuttingPacking]

example :
    positiveAtZeroProcess (1 + 0) () ≤
      (0 : ℝ) * ((∅ : Finset ℕ).card : ℝ) := by
  apply OrderedNatIntervalPacking.le_mul_card_of_greedy_cover
    positiveAtZeroProcess_add_le positiveAtZeroProcess_nonpos
    1 0 ∅ (fun _ => 1)
  · simp
  · simp
  · omega
  · norm_num
  · norm_num

example :
    positiveAtZeroProcess (2 + 3) () ≤
      (-1 : ℝ) * (({0, 1} : Finset ℕ).card : ℝ) := by
  apply OrderedNatIntervalPacking.le_mul_card_of_greedy_cover
    positiveAtZeroProcess_add_le positiveAtZeroProcess_nonpos
    2 3 {0, 1} longChoice
  · intro j hj
    simp only [Finset.mem_insert, Finset.mem_singleton] at hj
    rcases hj with rfl | rfl <;> simp
  · intro j hj
    simp only [Finset.mem_insert, Finset.mem_singleton] at hj
    rcases hj with rfl | rfl <;> norm_num [longChoice]
  · omega
  · norm_num
  · intro j hj
    simp only [Finset.mem_insert, Finset.mem_singleton] at hj
    rcases hj with rfl | rfl <;>
      norm_num [longChoice, positiveAtZeroProcess]

example :
    positiveAtZeroProcess (1 + 1) () <
      (-(1 : ℝ) / 2) * (({0} : Finset ℕ).card : ℝ) := by
  apply OrderedNatIntervalPacking.lt_mul_card_of_greedy_cover
    positiveAtZeroProcess_add_le positiveAtZeroProcess_nonpos
    1 1 {0} (fun _ => 1)
  · simp
  · simp
  · simp
  · norm_num
  · intro j hj
    simp at hj
    subst j
    norm_num [positiveAtZeroProcess]

example {Ω : Type uΩ} [MeasurableSpace Ω] {T : Ω → Ω}
    {μ : Measure Ω} {X : ℕ → Ω → ℝ}
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    {N : ℕ} (P : OrderedNatIntervalPacking N) (hN : N ≠ 0) (ω : Ω) :
    centeredProcess T X N ω ≤ P.cost T (centeredProcess T X) ω :=
  hX.centeredProcess_le_orderedIntervalPackingSum P hN ω

example {Ω : Type uΩ} [MeasurableSpace Ω] {μ : Measure Ω}
    (C : DiscreteMatrixCocycle (ι := Empty) μ)
    {N : ℕ} (P : OrderedNatIntervalPacking N) (hN : N ≠ 0) (ω : Ω) :
    C.centeredLogPlusNormObservable N ω ≤
      P.cost C.base C.centeredLogPlusNormObservable ω :=
  C.centeredLogPlusNormObservable_le_orderedIntervalPackingSum P hN ω

example :
    centeredProcess id positiveAtZeroProcess 5 () ≤
      abuttingPacking.cost id (centeredProcess id positiveAtZeroProcess) () :=
  positiveAtZeroCandidate.centeredProcess_le_orderedIntervalPackingSum
    abuttingPacking (by omega) ()

end EdgeCaseSmokes

end NonlinearDynamics.Random.RandomCocycles

#print axioms NonlinearDynamics.Random.RandomCocycles.OrderedNatIntervalPacking.intervals_pairwiseDisjoint_Ico
#print axioms NonlinearDynamics.Random.RandomCocycles.OrderedNatIntervalPacking.le_cost_of_add_le_nonpos
#print axioms NonlinearDynamics.Random.RandomCocycles.OrderedNatIntervalPacking.exists_orderedPacking_covering
#print axioms NonlinearDynamics.Random.RandomCocycles.OrderedNatIntervalPacking.le_mul_card_of_greedy_cover
#print axioms NonlinearDynamics.Random.RandomCocycles.OrderedNatIntervalPacking.lt_mul_card_of_greedy_cover
#print axioms NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.centeredProcess_le_orderedIntervalPackingSum
#print axioms NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.centeredLogPlusNormObservable_le_orderedIntervalPackingSum
