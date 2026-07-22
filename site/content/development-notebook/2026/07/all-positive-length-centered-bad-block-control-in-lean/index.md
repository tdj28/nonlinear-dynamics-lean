---
title: "All-Positive-Length Centered Bad-Block Control in Lean"
slug: "all-positive-length-centered-bad-block-control-in-lean"
date: 2026-07-22
weight: -65
author: "tdj28"
summary: "Random-matrix-theory milestone 31 (RMT-31) removes the finite witness cap from the centered bad-block estimate. It identifies the all-positive-length event as an increasing union, passes first through extended measure and then through a locally finite real-measure gate, and preserves the finite-cap rate ratio without assuming probability or ergodicity."
lead: |
  A finite-cap theorem asks whether one bad centered block appears among lengths one through m. RMT-31 lets m grow without changing the question into an asymptotic one. Membership in the resulting union still means one finite witness, not infinitely many witnesses. Extended measure is continuous along the nested caps with no finiteness premise; converting that limit to real-valued measure needs the union itself to have finite extended mass. On a finite measure space, the uniform RMT-30 ratio survives unchanged.
key_result: |
  Let every finite centered bad-block set have the same real-measure upper bound delta divided by c. Because the caps are nested, their extended measures converge to the measure of the all-positive-length union. If the union has finite extended mass, the real measures converge too, and le_of_tendsto' transfers the uniform bound to the limit. The cocycle specialization uses the integrated log-positive Fekete offset. The raw once-bad event is not generally invariant, even over a measure-preserving base, so this is not a lower-liminf or Kingman convergence theorem.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Increasing unions, extended nonnegative real measure, local finiteness, centered subadditive processes, and Lean limit architecture"
reading_time: "150 to 220 minutes"
prerequisites:
  - "RMT-30 finite centered bad-block measure control"
  - "Orbit-majorant centering and finite-measure continuity from below"
  - "Basic familiarity with filters, Tendsto, and extended nonnegative real numbers"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveAllLengthBadBlockMeasure"
lean_source: "formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveAllLengthBadBlockMeasure.lean"
tags:
  - "Lean 4"
  - "Subadditive processes"
  - "Bad blocks"
  - "Increasing unions"
  - "Finite measures"
  - "Matrix cocycles"
  - "Kingman theorem"
og_image: "all-positive-length-centered-bad-block-control-in-lean-card.png"
og_image_alt: "Warm-paper teaching card showing nested finite witness caps joining into one all-positive-length union, followed by an extended-measure limit, a finite-mass gate to real measure, and an unchanged uniform ratio bound. A stop panel says one finite witness, not infinitely many, and raw event not invariant."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed Research Note. Verify claims against the cited primary
sources and any released artifacts before relying on them.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** Let \(T\) preserve a measure \(\mu\), let \(X_n\) be an
integrable shifted-subadditive process candidate, and let

\[
Y_n(\omega)=X_n(\omega)-S_n(X_1)(\omega)
\]

be its orbit-majorant-centered process. RMT-30 controlled the set

\[
B_{m,c}=\bigcup_{1\le n\le m}\{\omega:Y_n(\omega)\lt cn\}
\]

for a fixed finite cap \(m\). RMT-31 defines

\[
B_{\infty,c}=\bigcup_{m\in\mathbb N}B_{m,c}
\]

and proves that membership is equivalent to one positive finite witness
\(n\). The sets \(B_{m,c}\) increase with \(m\), so their extended measures
converge to \(\mu(B_{\infty,c})\) without a set-measurability or finite-mass
premise. Passing through `Measure.real` requires the local condition
\(\mu(B_{\infty,c})\ne\infty\). Under finite total mass, that condition is
automatic, and RMT-30's cap-uniform estimate gives

\[
\mu_{\mathbb R}(B_{\infty,c})\le\frac{\delta}{c}.
\]

The result uses neither probability nor ergodicity. A compiled two-state
countermodel shows that the raw once-bad event need not be setwise invariant,
even when the base map preserves the chosen finite measure.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This declaration-complete teaching chapter is published
as an open working note while human editorial acceptance and the separate
scientific-integrity
and zero-context expert-reader reviews are pending. The warning-fatal checked
Lean source is authoritative for every statement and assumption.
{{< /panel >}}

For reusable vocabulary, see
{{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}},
{{< refterm "birkhoff-sum" "Birkhoff sums" >}},
{{< refterm "integrated-log-positive-growth-rate" "the integrated log-positive growth rate" >}},
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycles" >}}, and
{{< refterm "ergodicity" "ergodicity" >}}. The companion textbook chapter is
[From Finite Centered Bad-Block Bounds to All-Positive-Length Control]({{< relref "/knowledge-base/deep-dives/from-finite-centered-bad-block-bounds-to-all-positive-length-control" >}}).
For an analogous increasing-union architecture applied to a different
observable and threshold event, compare the
{{< refterm "infinite-horizon-birkhoff-average-exceedance-event" "infinite-horizon Birkhoff-average exceedance event" >}}.

## Orientation: removing a cap without changing the quantifier

The previous chapter,
[Finite Centered Bad-Block Measure Control in Lean]({{< relref "/development-notebook/2026/07/finite-centered-bad-block-measure-control-in-lean" >}}),
proved one estimate for every fixed finite cap. The new step is to identify
the union of all those caps and pass the uniform estimate to that union.

The quantifier is easy to overread. A point belongs to the all-length event
when there exists one positive natural number \(n\) for which the strict
inequality holds. The witness is always finite. The definition does not say
that bad lengths are unbounded, arbitrarily late, or infinite in number.

{{< reference-figure
  wide="true"
  src="finite-caps-to-all-length-union.svg"
  alt="Nested finite witness caps expand from short lengths to larger finite menus. Their union is labeled one finite witness somewhere, while a separate crossed-out lane says infinitely many witnesses are not asserted."
  caption="**Quantifier boundary:** increasing the cap exhausts every positive finite length. It changes a bounded existential witness into an unbounded existential witness, not into an infinitely-often statement."
>}}

## Prior work, contribution, and nonclaims

**Prior work.** Kingman's primary 1968 paper proves the much stronger
subadditive ergodic theorem ([Kingman 1968](#ref-rmt31-kingman)). This module
formalizes only a measure-continuity bridge used on one possible route toward
its lower bound. [RMT-30](#ref-rmt31-rmt30) supplies the cap-uniform estimate.
Mathlib supplies [countable null-measurable union
closure](#ref-rmt31-mathlib-null), [continuity from below for extended
measure](#ref-rmt31-mathlib-measure), [continuity of
`ENNReal.toReal`](#ref-rmt31-mathlib-ennreal) away from infinity, and the
[order-closed limit lemma](#ref-rmt31-mathlib-order) used to retain a uniform
upper bound.

**This note's contribution.** RMT-31:

- names the once-bad event across every positive finite witness length;
- proves its exact existential membership semantics;
- exposes the nesting and inclusion API for finite caps;
- separates unconditional extended-measure continuity from locally finite
  real-measure continuity;
- passes the RMT-30 ratio unchanged to the union; and
- specializes the result to the cocycle log-positive process without adding
  probability, ergodicity, or a nonempty matrix index.

**Not claimed.** The module proves no infinitely-often statement, no raw-event
invariance, no almost-invariance theorem, no lower-liminf bound, no samplewise
convergence, no equality with the integrated rate, no full Kingman theorem, no
\(L^1\) convergence, no limit-integral interchange, no powered-map
ergodicity, no signed logarithmic rate, no Lyapunov exponent, and no Oseledets
splitting.

## The increasing-union argument

Write \(B_m=B_{m,c}\) with \(c\) fixed. If \(m\le M\), every length in the
window from one through \(m\) also lies in the window from one through \(M\).
Therefore

\[
B_m\subseteq B_M.
\]

This is monotonicity of the search window. It is not monotonicity of the
sequence \(Y_n(\omega)\) in time. No such process monotonicity is assumed or
proved.

The union identity is definitionally true:

\[
B_{\infty,c}=\bigcup_{m\in\mathbb N}B_{m,c}.
\]

Declaration 4 gives this `rfl` fact a stable theorem name. Although its proof
is one line, the name is intentional public API: later proofs and readers can
refer to the representation without unfolding the definition or depending on
its implementation spelling.

Every finite cap embeds into the union by choosing its own cap as the union
index. Conversely, a member of the union arrives with some cap \(m\), some
witness \(n\le m\), and a strict centered inequality. Erasing \(m\) leaves one
positive finite witness. In the reverse direction, a witness \(n\) enters the
union through cap \(m=n\).

## Extended measure must come first

Mathlib measures take values in the extended nonnegative reals
\(\mathbb R_{\ge0}\cup\{\infty\}\). Continuity from below naturally lives in
that space:

\[
\mu(B_m)\longrightarrow\mu\!\left(\bigcup_m B_m\right).
\]

The theorem `tendsto_measure_iUnion_atTop` needs the nesting proof. It does not
need each \(B_m\) to be measurable, and it does not need finite total mass.
This is why RMT-31 states the extended-measure convergence theorem separately
from the null-measurability theorem.

`Measure.real` then applies `ENNReal.toReal` to an extended measure. That map
is intentionally total, and infinity is sent to zero. Consequently, it is not
continuous at infinity in the way this proof needs. The correct gate is local:

\[
\mu(B_{\infty,c})\ne\infty.
\]

It is enough that the target union has finite extended mass. The theorem does
not require a globally finite measure space. A global `[IsFiniteMeasure μ]`
instance is merely a convenient sufficient condition used by the final ratio
theorems; Mathlib's [`measure_ne_top`](#ref-rmt31-mathlib-finite) discharges
the local gate.

{{< reference-figure
  src="extended-to-real-measure-gate.svg"
  alt="A blue lane shows nested sets flowing unconditionally to an extended-measure limit that may be infinite. A gate labeled target union has finite extended mass then opens a green lane to real-measure convergence. A warning notes that real measure sends infinite mass to zero."
  caption="**Type gate:** continuity from below is first proved in extended measure. Conversion to real-valued measure is licensed only at a finite target because totalization sends infinite mass to zero."
>}}

## Why the uniform ratio survives unchanged

RMT-30 proves for every cap \(m\):

\[
\mu_{\mathbb R}(B_m)\le \frac{\delta}{c}.
\]

RMT-31 does not sum these estimates. Summing would introduce a useless factor
or divergence. Instead, the cap sets are nested and their real measures
converge to the union's real measure under finite mass. The right side is the
same constant for every cap. The order-closed lemma `le_of_tendsto'` says that
a limit of values all bounded above by one constant remains bounded above by
that constant. Thus

\[
\mu_{\mathbb R}(B_{\infty,c})\le \frac{\delta}{c}
\]

with no loss.

{{< reference-figure
  src="uniform-ratio-survives-the-union.svg"
  alt="Under the finite-target gate, several increasing finite-cap real measures sit below one horizontal uniform ratio ceiling. They converge to the all-length real measure, which remains below the same ceiling. A note says no summation and no extra constant."
  caption="**Limit architecture:** finite target mass licenses real-measure convergence. Each cap has the identical upper bound, so `le_of_tendsto'` carries that bound to the union without summing cap estimates."
>}}

The generic theorem retains exactly the RMT-30 analytic premises: an
integrable candidate, a measure-preserving base, finite total mass, a lower
bound \(\delta\) for every positive normalized centered integral, and
\(c\lt\delta\). Probability and ergodicity remain absent. As in RMT-30, the
time-one centered identity forces \(\delta\le0\), so \(c\lt0\); RMT-31 reuses
the already proved finite-cap theorem rather than repeating that sign proof.

## The raw once-bad event is not invariant

An asymptotic deviation event is often designed to ignore a finite prefix.
This raw event is different. It remembers whether at least one witness occurs,
so applying the base map can remove the only witness.

The compiled countermodel uses `Bool`. The map `rmt31Collapse` sends both
points to `true` and preserves the Dirac measure at `true`. The process is zero
on `true`; on `false` it is zero before length two and minus one from length
two onward. Its one-step value is zero, so orbit-majorant centering does not
change it. At slope minus two fifths, length two marks `false`, while `true`
is never marked. The all-length set is therefore the singleton `{false}`.
Its preimage under the collapse map is empty.

The source compiles both the integrable shifted-subadditive candidate and the
measure-preserving proof before proving the unequal sets. The disagreement is
setwise. In this particular Dirac model it occurs on a null point, so the probe
does not refute a possible almost-everywhere statement under additional
design. It does decisively refute calling the raw set invariant.

{{< reference-figure
  wide="true"
  src="raw-all-length-event-is-not-invariant.svg"
  alt="Two Boolean states both collapse to the true state. The false state has one bad witness at length two and belongs to the raw all-length event, while true does not. The event is the false singleton, but its preimage under collapse is empty, despite preservation of the Dirac mass at true."
  caption="**Compiled countermodel:** a valid centered subadditive process over a measure-preserving collapse map has raw event `{false}` and preimage `empty`. Once-bad membership is not setwise invariant."
>}}

[RMT-32]({{< relref "/development-notebook/2026/07/countably-generated-centered-lower-deviation-events-in-lean" >}})
now defines the arbitrarily-late strict lower-deviation event with rational
margins and proves its one-sided preimage relation. Finite-measure ergodicity
gives an almost-empty or almost-full dichotomy. Probability normalization is
a separate final ingredient: it makes the full branch have mass one, so the
strict subunit estimate can exclude it.

## Public declaration surface in exact source order

The module exports eleven declarations.

### 1. `centeredAllLengthBadBlockSet`

```lean
def centeredAllLengthBadBlockSet {Ω : Type uΩ} (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) (c : ℝ) : Set Ω :=
  ⋃ m : ℕ, finiteCenteredBadBlockSet T X m c
```

Names the union over every natural cap. The cap-zero term is empty and causes
no special case.

### 2. `mem_centeredAllLengthBadBlockSet_iff`

```lean
@[simp] theorem mem_centeredAllLengthBadBlockSet_iff
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {c : ℝ} {ω : Ω} :
    ω ∈ centeredAllLengthBadBlockSet T X c ↔
      ∃ n : ℕ, 0 < n ∧ centeredProcess T X n ω < c * (n : ℝ)
```

Eliminates the auxiliary cap from membership and records exactly one finite
strict witness.

### 3. `finiteCenteredBadBlockSet_mono`

```lean
theorem finiteCenteredBadBlockSet_mono
    {m M : ℕ} (hmM : m ≤ M) (c : ℝ) :
    finiteCenteredBadBlockSet T X m c ⊆
      finiteCenteredBadBlockSet T X M c
```

Transports the same witness through the larger endpoint bound.

### 4. `centeredAllLengthBadBlockSet_eq_iUnion_finite`

```lean
theorem centeredAllLengthBadBlockSet_eq_iUnion_finite
    (T : Ω → Ω) (X : ℕ → Ω → ℝ) (c : ℝ) :
    centeredAllLengthBadBlockSet T X c =
      ⋃ m : ℕ, finiteCenteredBadBlockSet T X m c
```

This is deliberately a named `rfl` theorem. Its value is API stability and
readable rewriting, not proof complexity.

### 5. `finiteCenteredBadBlockSet_subset_allLength`

```lean
theorem finiteCenteredBadBlockSet_subset_allLength
    (T : Ω → Ω) (X : ℕ → Ω → ℝ) (m : ℕ) (c : ℝ) :
    finiteCenteredBadBlockSet T X m c ⊆
      centeredAllLengthBadBlockSet T X c
```

Injects cap \(m\) into the indexed union at index \(m\).

### 6. `IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredAllLengthBadBlockSet`

```lean
theorem nullMeasurableSet_centeredAllLengthBadBlockSet
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (c : ℝ) :
    NullMeasurableSet (centeredAllLengthBadBlockSet T X c) μ
```

Applies RMT-30 null measurability at every cap and Mathlib countable-union
closure. Finite mass is not required.

### 7. `tendsto_measure_finiteCenteredBadBlockSet`

```lean
theorem tendsto_measure_finiteCenteredBadBlockSet
    (X : ℕ → Ω → ℝ) (c : ℝ) :
    Tendsto
      (fun m ↦ μ (finiteCenteredBadBlockSet T X m c))
      atTop (nhds (μ (centeredAllLengthBadBlockSet T X c)))
```

Uses nesting and `tendsto_measure_iUnion_atTop`. It needs neither candidate
integrability, preservation, set measurability, nor finite mass.

### 8. `tendsto_measureReal_finiteCenteredBadBlockSet`

```lean
theorem tendsto_measureReal_finiteCenteredBadBlockSet
    (X : ℕ → Ω → ℝ) (c : ℝ)
    (hfinite : μ (centeredAllLengthBadBlockSet T X c) ≠ ∞) :
    Tendsto
      (fun m ↦ μ.real (finiteCenteredBadBlockSet T X m c))
      atTop (nhds (μ.real (centeredAllLengthBadBlockSet T X c)))
```

Composes declaration 7 with `ENNReal.tendsto_toReal`. Only the target union's
extended measure must be finite.

### 9. `IsIntegrableSubadditiveProcessCandidate.measureReal_centeredAllLengthBadBlockSet_le_rateRatio`

```lean
theorem measureReal_centeredAllLengthBadBlockSet_le_rateRatio
    [IsFiniteMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (δ c : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ))
    (hc : c < δ) :
    μ.real (centeredAllLengthBadBlockSet T X c) ≤ δ / c
```

Uses finite total mass to discharge declaration 8's local gate, then
`le_of_tendsto'` and the RMT-30 bound at every cap.

### 10. `DiscreteMatrixCocycle.centeredLogPlusAllLengthBadBlockSet`

```lean
def centeredLogPlusAllLengthBadBlockSet
    (C : DiscreteMatrixCocycle (ι := ι) μ) (c : ℝ) : Set Ω :=
  centeredAllLengthBadBlockSet C.base C.logPlusNormObservable c
```

Gives the generic union a cocycle-facing name.

### 11. `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusAllLengthBadBlockSet_le_rateRatio`

```lean
theorem HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusAllLengthBadBlockSet_le_rateRatio
    [IsFiniteMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (c : ℝ)
    (hc : c < C.integratedLogPlusGrowthRate hC -
      C.integratedLogPlusNorm 1) :
    μ.real (C.centeredLogPlusAllLengthBadBlockSet c) ≤
      (C.integratedLogPlusGrowthRate hC -
        C.integratedLogPlusNorm 1) / c
```

Passes RMT-30's cocycle bound cap by cap and takes the same real-measure limit.
The finite decidable matrix index may be empty.

## Complete proof-step ledger

| Declaration | Source-order proof step | Job |
|---|---|---|
| Membership | Unfold both set definitions and indexed-union membership | Exposes cap, witness, positivity, endpoint, and strict inequality |
| Membership | Forward direction erases the cap | Retains one positive finite witness |
| Membership | Reverse direction chooses cap equal to witness | Re-enters the union without choice or asymptotics |
| Cap monotonicity | Unpack the old witness | Retrieves \(1\le n\le m\) and its strict cost |
| Cap monotonicity | Compose \(n\le m\le M\) | Reuses the witness at the larger cap |
| Named union identity | `rfl` | Publishes the defining representation as stable API |
| Finite-cap inclusion | Rewrite by the named union identity | Makes the target visibly indexed |
| Finite-cap inclusion | `subset_iUnion` at index \(m\) | Embeds the chosen cap |
| Null measurability | Rewrite as the countable union | Aligns with Mathlib's closure theorem |
| Null measurability | Apply `NullMeasurableSet.iUnion` | Reuses RMT-30 capwise null measurability |
| Extended convergence | Rewrite as the increasing union | Aligns target with continuity from below |
| Extended convergence | Apply `tendsto_measure_iUnion_atTop` | Supplies cap monotonicity and no extra analytic premise |
| Real convergence | Compose `ENNReal.tendsto_toReal hfinite` | Uses continuity away from infinity |
| Real convergence | Simplify `Measure.real` and composition | Restates the composed limit in public notation |
| Generic ratio | Apply `le_of_tendsto'` to real convergence | Makes the union measure the limit of cap measures |
| Generic ratio | Invoke RMT-30 for each \(m\) | Supplies the same \(\delta/c\) upper bound uniformly |
| Cocycle wrapper | Apply `le_of_tendsto'` | Uses finite measure for the local limit gate |
| Cocycle wrapper | Invoke RMT-30 cocycle theorem for each cap | Avoids duplicating the integrated-rate argument |

## Fifteen private boundary-support items

The private items do not enlarge the public API. They make the anonymous
examples executable.

| Order | Private item | Role |
|---:|---|---|
| 1 | `rmt31ZeroProcess` | Constant-zero process on any space |
| 2 | `rmt31ZeroProcess_candidate` | Integrability and shifted subadditivity of the zero process |
| 3 | `rmt31TwoPointProbability` | Half the sum of the two Boolean Dirac masses |
| 4 | private `IsProbabilityMeasure rmt31TwoPointProbability` instance | Checks that the two half masses total one |
| 5 | `rmt31Id_not_preErgodic` | Uses the invariant singleton to refute pre-ergodicity of the identity |
| 6 | `rmt31TwoPointProcess` | Equals minus \(n-1\) on `false` and zero on `true` |
| 7 | `rmt31TwoPointProcess_candidate` | Finite-space integrability and shifted subadditivity proof |
| 8 | `rmt31MassTwoMeasure` | Twice the Dirac measure on `Unit` |
| 9 | private `IsFiniteMeasure rmt31MassTwoMeasure` instance | Records finite mass without probability normalization |
| 10 | `rmt31Collapse` | Constant Boolean map with value `true` |
| 11 | `rmt31OneShotProcess` | One negative value from length two onward only at `false` |
| 12 | `rmt31_iterate_collapse_true` | Every iterate fixes `true` |
| 13 | `rmt31_iterate_collapse_of_ne_zero` | Every positive iterate sends either point to `true` |
| 14 | `rmt31OneShotProcess_candidate` | Compiles integrability and shifted subadditivity for the countermodel |
| 15 | `rmt31Collapse_preserving` | Proves preservation of the Dirac mass at `true` |

## Ten compiled boundary probes in exact source order

{{< reference-figure
  wide="true"
  src="rmt31-boundary-probe-grid.svg"
  alt="A two by five grid lists ten compiled probes: empty cap, finite-cap inclusion, zero process, zero measure, nonergodic half-mass example, later strict witness, cap-one strictness, mass-two measure, empty matrix index, and measure-preserving raw non-invariance."
  caption="**Compiled boundary grid:** the examples cover empty and degenerate cases, genuine nonergodic and nonprobability models, strict witness semantics, empty matrix dimension, and the setwise non-invariance countermodel."
>}}

1. **Cap zero.** The finite approximant at cap zero is empty. This says
   nothing about the union over larger caps.
2. **Finite-cap inclusion.** Every finite bad-block set embeds in the
   all-length event through its own cap index.
3. **Zero process.** At a negative slope, the zero process has no strict
   positive-length witness, so its all-length set is empty.
4. **Zero measure.** Every all-length set has real measure zero under the zero
   measure.
5. **Nonergodic half-mass model.** The Boolean identity is not pre-ergodic.
   At \(c=-3/4\), the bad set is exactly `{false}`, has real mass \(1/2\),
   and satisfies the theorem's nontrivial \(1/2\le2/3\) bound.
6. **Later witness after time-one equality.** At \(c=0\), the point `false`
   is unmarked at length one but enters at length two. One strict later witness
   is enough.
7. **Cap-one formula.** For the two-point process, the cap-one set is all
   points exactly when \(0\lt c\), and is empty otherwise. This compiles the
   strict threshold.
8. **Mass-two finite measure.** The generic union theorem works for a finite
   measure of total mass two. No probability instance is hidden.
9. **Empty matrix index.** The cocycle theorem compiles with `ι := Empty`.
10. **Preserving non-invariance.** The one-shot process is a valid candidate,
    the collapse map preserves its Dirac measure, and the raw all-length set
    still differs from its preimage.

## Complete source-order map

| Order | Kind | Source item |
|---:|---|---|
| 1 | Public definition | `centeredAllLengthBadBlockSet` |
| 2 | Public theorem | `mem_centeredAllLengthBadBlockSet_iff` |
| 3 | Public theorem | `finiteCenteredBadBlockSet_mono` |
| 4 | Public theorem | `centeredAllLengthBadBlockSet_eq_iUnion_finite` |
| 5 | Public theorem | `finiteCenteredBadBlockSet_subset_allLength` |
| 6 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredAllLengthBadBlockSet` |
| 7 | Public theorem | `tendsto_measure_finiteCenteredBadBlockSet` |
| 8 | Public theorem | `tendsto_measureReal_finiteCenteredBadBlockSet` |
| 9 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.measureReal_centeredAllLengthBadBlockSet_le_rateRatio` |
| 10 | Public cocycle definition | `DiscreteMatrixCocycle.centeredLogPlusAllLengthBadBlockSet` |
| 11 | Public cocycle receiver theorem | `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusAllLengthBadBlockSet_le_rateRatio` |
| 12 | Private definition | `rmt31ZeroProcess` |
| 13 | Private theorem | `rmt31ZeroProcess_candidate` |
| 14 | Private definition | `rmt31TwoPointProbability` |
| 15 | Private instance | `IsProbabilityMeasure rmt31TwoPointProbability` |
| 16 | Private theorem | `rmt31Id_not_preErgodic` |
| 17 | Private definition | `rmt31TwoPointProcess` |
| 18 | Private theorem | `rmt31TwoPointProcess_candidate` |
| 19 | Private definition | `rmt31MassTwoMeasure` |
| 20 | Private instance | `IsFiniteMeasure rmt31MassTwoMeasure` |
| 21 | Anonymous example | Cap zero is empty |
| 22 | Anonymous example | Finite-cap inclusion |
| 23 | Anonymous example | Zero process at negative slope |
| 24 | Anonymous example | Zero-measure real mass |
| 25 | Anonymous example | Nonergodic half-mass set and ratio |
| 26 | Anonymous example | Later strict witness at threshold zero |
| 27 | Anonymous example | Exact cap-one strictness formula |
| 28 | Anonymous example | Mass-two finite-measure theorem |
| 29 | Anonymous example | Empty matrix-index cocycle theorem |
| 30 | Private definition | `rmt31Collapse` |
| 31 | Private definition | `rmt31OneShotProcess` |
| 32 | Private theorem | `rmt31_iterate_collapse_true` |
| 33 | Private theorem | `rmt31_iterate_collapse_of_ne_zero` |
| 34 | Private theorem | `rmt31OneShotProcess_candidate` |
| 35 | Private theorem | `rmt31Collapse_preserving` |
| 36 | Anonymous example | Measure-preserving raw non-invariance |
| 37 | Axiom audit | Membership semantics |
| 38 | Axiom audit | Cap monotonicity |
| 39 | Axiom audit | All-length null measurability |
| 40 | Axiom audit | Extended-measure convergence |
| 41 | Axiom audit | Real-measure convergence |
| 42 | Axiom audit | Generic all-length ratio |
| 43 | Axiom audit | Cocycle all-length ratio |

## Seven axiom reports

The warning-fatal Lean run prints all seven theorem footprints as exactly the
same standard trio:

```text
'NonlinearDynamics.Random.RandomCocycles.mem_centeredAllLengthBadBlockSet_iff'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.finiteCenteredBadBlockSet_mono'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredAllLengthBadBlockSet'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.tendsto_measure_finiteCenteredBadBlockSet'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.tendsto_measureReal_finiteCenteredBadBlockSet'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.measureReal_centeredAllLengthBadBlockSet_le_rateRatio'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusAllLengthBadBlockSet_le_rateRatio'
depends on axioms: [propext, Classical.choice, Quot.sound]
```

No project-specific axiom or proof hole appears.

## Assumption and conclusion ledger

| Layer | Required assumptions | Exact output | Explicitly absent |
|---|---|---|---|
| Membership and nesting | Functions, natural caps, real threshold | Existential witness, subset relations | Measurability, measure, preservation |
| Null measurability | Integrable candidate, preservation | Union is null measurable | Finite total mass, probability, ergodicity |
| Extended continuity | Measurable-space structure and a measure | Extended cap measures tend to union measure | Set measurability, candidate, preservation, finite mass |
| Real continuity | Extended continuity plus finite target union mass | Real cap measures tend to real union measure | Global finite measure, probability, ergodicity |
| Generic ratio | Finite measure, candidate, preservation, blockwise lower rate, strict threshold | All-length real measure at most \(\delta/c\) | Probability, ergodicity, invariance |
| Cocycle ratio | Finite measure, finite decidable index, integrable generator log-positive norm, strict threshold | Same ratio at the integrated Fekete offset | Nonempty index, probability, ergodicity, signed log rate |

## Common wrong turns

### Confusing one witness with infinitely many

The union over caps eliminates a predetermined upper bound. It does not add
the quantifiers needed for arbitrarily late or infinitely recurring failures.

### Applying `Measure.real` before checking infinity

Extended measure is the native continuity-from-below target. Since
`Measure.real` totalizes infinite mass to zero, direct real conversion without
a finite target is not a valid general theorem.

### Summing finite-cap bounds

The family is nested and the bound is uniform. Take the limit of the cap
measures. Do not use a union bound and do not add one copy of \(\delta/c\) for
every cap.

### Adding measurability to extended continuity

The Mathlib continuity theorem used here is designed for an increasing family
and does not ask for measurable sets. Null measurability remains useful for
later measure-theoretic work but is not a hidden premise of declaration 7.

### Treating local finiteness as global finiteness

Declaration 8 asks only that the limiting union have finite extended measure.
The global finite-measure typeclass appears later because it automatically
supplies that fact and is already required by the RMT-30 bound.

### Calling the once-bad event invariant

The compiled collapse model refutes setwise invariance under preservation.
An asymptotic event must be designed with different quantifiers and proved
separately.

### Calling real measure a probability

The mass-two probe shows that the theorem is genuinely finite-measure. The
left side is a real-valued measure, not necessarily a number at most one.

### Reading log-positive growth as a Lyapunov exponent

The observable clips contractions. The theorem controls a log-positive
envelope and says nothing about a signed exponent or invariant splitting.

## Twenty-four solved exercises

### Exercise 1: unfold membership

What does \(\omega\in B_{\infty,c}\) mean after eliminating the cap?

**Solution.** There exists a natural \(n\gt0\) such that
\(Y_n(\omega)\lt cn\). The witness is finite because every natural is finite.

### Exercise 2: separate the quantifiers

Does Exercise 1 imply that bad witnesses occur infinitely often?

**Solution.** No. An existential statement can be satisfied by exactly one
witness. Infinitely often requires a different arbitrarily-late quantifier.

### Exercise 3: choose the reverse cap

Given a witness \(n\), which cap proves membership in the union?

**Solution.** Choose \(m=n\). Then \(1\le n\le m\) follows from positivity and
reflexivity.

### Exercise 4: inspect cap zero

Why does including \(m=0\) in the outer union not add points?

**Solution.** The inner positive window from one through zero is empty, so
\(B_{0,c}=\varnothing\).

### Exercise 5: prove cap monotonicity

If \(m\le M\), why does \(B_{m,c}\subseteq B_{M,c}\)?

**Solution.** Reuse the same witness \(n\). Its endpoint proof composes as
\(n\le m\le M\).

### Exercise 6: reject process monotonicity

Does cap monotonicity say \(Y_m(\omega)\le Y_M(\omega)\)?

**Solution.** No. It compares search sets, not process values at different
times.

### Exercise 7: explain the named `rfl`

Why publish declaration 4 if its proof is reflexivity?

**Solution.** The theorem gives the defining union a stable rewrite name, so
downstream proofs need not unfold an implementation detail.

### Exercise 8: embed one cap

Which indexed-union lemma proves \(B_m\subseteq\bigcup_M B_M\)?

**Solution.** `subset_iUnion` at index \(m\).

### Exercise 9: build null measurability

What are the two ingredients for the all-length null-measurability theorem?

**Solution.** RMT-30 proves each finite cap null measurable, and
`NullMeasurableSet.iUnion` closes a countable union.

### Exercise 10: locate finite mass

Does extended-measure continuity from below require finite total mass?

**Solution.** No. Its codomain includes infinity, so the limit may legitimately
be infinite.

### Exercise 11: locate set measurability

Does declaration 7 consume declaration 6?

**Solution.** No. The Mathlib theorem used for the increasing union needs
nesting but not measurability of the sets.

### Exercise 12: explain the real-measure hazard

Why not apply `ENNReal.toReal` to the extended limit unconditionally?

**Solution.** It sends infinity to zero and lacks the required continuity at
that point.

### Exercise 13: state the local gate

What is the weakest finiteness assumption in declaration 8?

**Solution.** Only \(\mu(B_{\infty,c})\ne\infty\), not global finite total
mass.

### Exercise 14: discharge the gate globally

How does `[IsFiniteMeasure μ]` supply declaration 8's premise?

**Solution.** Mathlib's `measure_ne_top` says every set has extended measure
different from infinity under a finite-measure instance.

### Exercise 15: preserve the ratio

Why is there no extra constant in the all-length estimate?

**Solution.** Every cap has the same upper bound, and a convergent limit of
values below one fixed constant remains below that constant.

### Exercise 16: name the order lemma

What does `le_of_tendsto'` contribute?

**Solution.** Given convergence of cap measures to the union measure and a
pointwise upper bound on every cap measure, it closes the inequality at the
limit.

### Exercise 17: avoid a union bound

Why would countable subadditivity be the wrong main tool here?

**Solution.** It would sum repeated copies of the same cap bound and discard
the crucial nesting. Continuity from below is exact.

### Exercise 18: test the zero process

For \(Y_n=0\) and \(c\lt0\), can a positive witness exist?

**Solution.** No. For \(n\gt0\), \(cn\lt0\), so the strict inequality
\(0\lt cn\) is false.

### Exercise 19: read the nonergodic probe

What does the Boolean identity example establish?

**Solution.** It compiles a genuine half-mass bad set and a nontrivial ratio
bound on a system that is not pre-ergodic. Ergodicity is unnecessary.

### Exercise 20: read the mass-two probe

What hidden premise does `rmt31MassTwoMeasure` reject?

**Solution.** It rejects probability normalization. A finite measure of total
mass two still satisfies the theorem.

### Exercise 21: read threshold zero

Why can `false` enter the all-length event at \(c=0\) although the time-one
center is zero?

**Solution.** Equality at length one is not strict, but the length-two centered
value is negative and supplies a later strict witness.

### Exercise 22: compute the countermodel preimage

If a map sends both Boolean points to `true`, what is the preimage of
`{false}`?

**Solution.** It is empty, since no input maps to `false`.

### Exercise 23: scope the countermodel

Does the compiled countermodel refute almost-everywhere invariance?

**Solution.** Not in its Dirac measure. The unequal point is null. The example
refutes raw setwise invariance, which is exactly the claim the module avoids.

### Exercise 24: identify future work

What must change before an ergodic zero-one lower-liminf argument can begin?

**Solution.** One must define an arbitrarily-late lower-deviation event and
prove the appropriate preimage or almost-invariance relation before invoking
ergodic rigidity. RMT-32 now does so. It also keeps the assumption order
precise: finite-measure ergodicity gives the dichotomy, while probability
normalization lets a strict subunit estimate select the null branch. None of
those are RMT-31 conclusions.

## Reproduction and audit

The frozen source inspected for this note has 481 lines and SHA-256
`53438522344c078d64473316a594570993d694ada909a33184579cec6a996fb7`.
Lean is pinned to 4.32.0 and Mathlib to commit
`81a5d257c8e410db227a6665ed08f64fea08e997`.

Build the leaf module with warnings fatal:

```text
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/SubadditiveAllLengthBadBlockMeasure.lean
```

Regenerate and byte-verify the page-owned social card from any working
directory:

```text
site/content/development-notebook/2026/07/all-positive-length-centered-bad-block-control-in-lean/generate-card.sh
site/content/development-notebook/2026/07/all-positive-length-centered-bad-block-control-in-lean/generate-card.sh --verify
```

Check the generator and conceptual assets directly:

```text
shellcheck site/content/development-notebook/2026/07/all-positive-length-centered-bad-block-control-in-lean/generate-card.sh
xmllint --noout site/content/development-notebook/2026/07/all-positive-length-centered-bad-block-control-in-lean/*.svg
magick identify -format '%wx%h\n' site/content/development-notebook/2026/07/all-positive-length-centered-bad-block-control-in-lean/all-positive-length-centered-bad-block-control-in-lean-card.png
```

After the shared coverage map and companion teaching pages are integrated by
their own release steps, run:

```text
make content-coverage
make content-hygiene
make site-check
```

## Discussion

RMT-31 is a small theorem layer with an important type discipline. The finite
cap does not disappear by informal notation. It disappears through a named
increasing union, an exact membership equivalence, and two separate continuity
statements whose codomains have different boundary behavior.

The extended-measure theorem is stronger as an interface than a finite-measure
only statement because it needs no measurability, preservation, candidate, or
finiteness premise. The real-measure theorem is more delicate, not more
general: its explicit local gate prevents the totalized value at infinity from
masquerading as continuity. The final theorem then spends global finite mass
only where the inherited capwise estimate and real conversion need it.

The second clarification concerns dynamics. A union over all finite witness
lengths sounds infinite-horizon, but its logical form is still once-bad. The
compiled collapse model shows why that distinction matters. A single witness
can vanish after one shift, so the raw event is not the invariant event needed
for ergodic rigidity. The next lower-deviation construction must earn its
asymptotic and invariance properties with new quantifiers and proofs.

## Navigation: previous and future milestones

**Previous, RMT-30:**
[Finite Centered Bad-Block Measure Control in Lean]({{< relref "/development-notebook/2026/07/finite-centered-bad-block-measure-control-in-lean" >}})
proves the uniform estimate for each finite witness cap by visit counting,
ordered interval packing, and exact finite-measure integration.

**Next, RMT-32:**
[Countably Generated Centered Lower-Deviation Events in Lean]({{< relref "/development-notebook/2026/07/countably-generated-centered-lower-deviation-events-in-lean" >}})
defines the rationally exhausted arbitrarily-late event, proves its
measure-theoretic shift behavior, obtains finite-measure ergodic rigidity, and
uses probability normalization plus this chapter's ratio to select the null
branch. It still stops before the exact real-liminf bridge.

## References

<a id="ref-rmt31-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://academic.oup.com/jrsssb/article/30/3/499/7026968),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968,
[doi:10.1111/j.2517-6161.1968.tb00749.x](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x).
This is the primary historical theorem source. Its convergence theorem is much
stronger than the continuity bridge proved here.

<a id="ref-rmt31-rmt30"></a>**This project.**
[Finite Centered Bad-Block Measure Control in Lean]({{< relref "/development-notebook/2026/07/finite-centered-bad-block-measure-control-in-lean" >}}),
RMT-30. This checked predecessor supplies the finite-cap bad-set definition,
capwise null measurability, and the uniform generic and cocycle ratio bounds.

<a id="ref-rmt31-mathlib-null"></a>**Mathlib contributors.**
[Null-measurable sets](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/NullMeasurable.lean#L133-L135),
Mathlib commit `81a5d257`. The pinned source contains
`NullMeasurableSet.iUnion` for countable unions.

<a id="ref-rmt31-mathlib-measure"></a>**Mathlib contributors.**
[Measure-space continuity](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/MeasureSpace.lean#L646-L653),
Mathlib commit `81a5d257`. The pinned source contains
`tendsto_measure_iUnion_atTop` for increasing families, explicitly without a
measurability premise.

<a id="ref-rmt31-mathlib-ennreal"></a>**Mathlib contributors.**
[Extended nonnegative real topology](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/Instances/ENNReal/Lemmas.lean#L103-L104),
Mathlib commit `81a5d257`. The pinned source contains `ENNReal.tendsto_toReal`
at finite targets.

<a id="ref-rmt31-mathlib-order"></a>**Mathlib contributors.**
[Closed-order limit lemmas](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/Order/OrderClosed.lean#L138-L140),
Mathlib commit `81a5d257`. The pinned source contains `le_of_tendsto'`.

<a id="ref-rmt31-mathlib-finite"></a>**Mathlib contributors.**
[Finite-measure typeclass](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/Typeclasses/Finite.lean#L35-L56),
Mathlib commit `81a5d257`. The pinned source defines `IsFiniteMeasure` and
proves `measure_ne_top`.
