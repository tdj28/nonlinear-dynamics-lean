---
title: "Countably Generated Centered Lower-Deviation Events in Lean"
slug: "countably-generated-centered-lower-deviation-events-in-lean"
date: 2026-07-22
weight: -66
author: "tdj28"
summary: "Random-matrix-theory milestone 32 (RMT-32) replaces a once-bad centered block event with a countably generated strict lower-deviation event. Rational slack makes one-sided shift stability provable, finite-measure ergodicity yields an almost-empty or almost-full dichotomy, and probability normalization plus a strict subunit estimate selects the null branch."
lead: |
  A bad block that occurs once can disappear after one shift, so it cannot support an ergodic lower-bound argument. RMT-32 asks instead for bad blocks beyond every finite cutoff at one rational slope strictly below the target. The rational margin absorbs the endpoint introduced by a shift and keeps the event countably generated. Finite-measure ergodicity then says the event is almost empty or almost full. Probability normalization is a separate final ingredient: together with the inherited strict subunit bound, it rules out the full branch.
key_result: |
  For an integrable centered subadditive-process candidate, the rationally exhausted strict lower-deviation event is null measurable and its preimage lies inside itself. Preservation and finite mass upgrade that inclusion to almost-everywhere equality, while finite-measure ergodicity gives the almost-empty or almost-full dichotomy. On a probability space, the event has mass zero or one. RMT-31 bounds its real mass strictly below one beneath the centered Fekete offset, so only mass zero remains. The module deliberately stops before identifying this event with a real liminf or proving Kingman convergence.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Countable event design, centered shifted subadditivity, almost-everywhere invariance, ergodic rigidity, and Lean measure APIs"
reading_time: "210 to 300 minutes"
prerequisites:
  - "RMT-31 all-positive-length centered bad-block control"
  - "Orbit-majorant centering for shifted-subadditive processes"
  - "Finite measures, probability measures, and almost-everywhere set equality"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveLowerDeviation"
lean_source: "formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveLowerDeviation.lean"
tags:
  - "Lean 4"
  - "Subadditive processes"
  - "Lower deviation"
  - "Rational slack"
  - "Ergodicity"
  - "Matrix cocycles"
  - "Kingman theorem"
og_image: "countably-generated-centered-lower-deviation-events-in-lean-card.png"
og_image_alt: "Warm-paper teaching card showing four steps: choose a rational margin, relax it across one shift, obtain an ergodic null-or-full dichotomy, and exclude the full branch with a strict subunit bound. A side panel distinguishes finite-measure ergodicity from probability normalization."
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
**Abstract.** Let \(T\) act on a measured space, let \(X_n\) be an integrable
shifted-subadditive process candidate, and let

\[
Y_n(\omega)=X_n(\omega)-S_n(X_1)(\omega)
\]

be its orbit-majorant-centered process. For a real slope \(q\), RMT-32 first
defines the fixed-margin event

\[
A_q=\left\{\omega:\forall N\in\mathbb N,\ \exists n\ge N,\ n\gt0,
\ Y_n(\omega)\lt qn\right\}.
\]

For a target \(c\), it then defines the countably generated strict event

\[
D_c=\bigcup_{\substack{q\in\mathbb Q\\q\lt c}} A_q.
\]

Centered shifted subadditivity gives

\[
Y_{n+1}(\omega)\le Y_n(T\omega).
\]

If \(q\lt r\), then \(qn\lt r(n+1)\) for every sufficiently large \(n\).
Consequently \(T^{-1}A_q\subseteq A_r\). Rational density supplies an
intermediate \(r\) below \(c\), yielding \(T^{-1}D_c\subseteq D_c\).

Candidate integrability and preservation make \(D_c\) null measurable.
Preservation plus finite total mass upgrade the one-sided inclusion to
almost-everywhere equality. Finite-measure ergodicity makes \(D_c\) almost
empty or almost full. Probability normalization labels those alternatives
with masses zero and one. Finally, \(D_c\subseteq B_{\infty,c}\) and RMT-31's
ratio theorem give \(\mu_{\mathbb R}(D_c)\lt1\) below the centered Fekete
offset, excluding mass one.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This declaration-complete teaching chapter is published
as an open working note while human editorial acceptance and the separate
scientific-integrity
and zero-context expert-reader reviews are pending. The warning-fatal checked
Lean source is authoritative for every theorem, assumption, and boundary.
{{< /panel >}}

For reusable vocabulary, see
{{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}},
{{< refterm "birkhoff-sum" "Birkhoff sums" >}},
{{< refterm "ergodicity" "ergodicity" >}},
{{< refterm "ergodic-probability-base" "ergodic probability bases" >}},
{{< refterm "integrated-log-positive-growth-rate" "the integrated log-positive growth rate" >}}, and
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycles" >}}.
The companion textbook chapter is
[Rational-Slack Lower-Deviation Events and Ergodic Null Selection]({{< relref "/knowledge-base/deep-dives/rational-slack-lower-deviation-events-and-ergodic-null-selection" >}}).

## Orientation: the quantifier change is the theorem-design step

The previous chapter,
[All-Positive-Length Centered Bad-Block Control in Lean]({{< relref "/development-notebook/2026/07/all-positive-length-centered-bad-block-control-in-lean" >}}),
defined the once-bad event \(B_{\infty,c}\). A point belongs when one positive
finite length satisfies \(Y_n(\omega)\lt cn\). That event is useful for a
uniform measure estimate, but one exceptional witness may vanish when the
initial point is shifted.

RMT-32 changes the logical shape before invoking ergodicity. At one fixed
slope \(q\), it requires a witness beyond every cutoff. It then takes a
countable union over rational \(q\lt c\). The result remembers a durable
strict gap below \(c\), not merely infinitely many values that happen to sit
below \(c\) by a gap shrinking to zero.

{{< reference-figure
  wide="true"
  src="quantifier-ladder.svg"
  alt="A three-step ladder distinguishes one finite bad witness, witnesses beyond every cutoff at one fixed rational slope, and a countable union over rational slopes below the target."
  caption="**Quantifier ladder:** RMT-31 supplies the first rung. RMT-32 formalizes the second and third. Only the latter two ignore every finite prefix, and the third retains a strict margin below the target."
>}}

## Prior work, contribution, and nonclaims

**Prior work.** Kingman's 1968 paper is the primary historical source for the
subadditive ergodic theorem ([Kingman 1968](#ref-rmt32-kingman)). Steele's
1989 proof centers a subadditive process, introduces a lower asymptotic
quantity, derives a one-sided transformation inequality, and then uses
measure preservation to obtain almost-everywhere equality
([Steele 1989](#ref-rmt32-steele)). That proof architecture motivates this
milestone.

The set \(D_c\), its rational exhaustion, and the exact Lean API in this note
are a project adaptation. They are not definitions quoted from Steele or
Kingman. Mathlib supplies countable null-measurable unions and intersections,
measure preservation on preimages, finite-measure almost-equality, rational
density, and ergodic almost-empty-or-full rigidity
([Mathlib sources](#ref-rmt32-mathlib-null)).

**This note's contribution.** RMT-32:

- separates a once-bad event from an arbitrarily-late fixed-margin event;
- packages strict deviation below a real target as a countable rational union;
- proves the endpoint-absorption estimate with no sign assumption on either
  slope;
- proves fixed-slope preimage inclusion after a genuine slope relaxation;
- recovers a same-target preimage inclusion by rational density;
- separates finite-measure ergodic dichotomy from probability branch
  selection;
- reuses the RMT-31 ratio to exclude the full branch; and
- specializes the null result to the log-positive matrix-cocycle process,
  including empty matrix dimension.

**Not claimed.** The module proves no equality between \(D_c\) and a Mathlib
`liminf` event, no lower-liminf inequality, no samplewise convergence, no
identification of a limit with the integrated rate, no \(L^1\) convergence,
no limit-integral interchange, no signed logarithmic growth rate, no Lyapunov
exponent, and no Oseledets splitting. It also does not claim same-slope
setwise invariance of \(A_q\) or \(D_c\).

## Why rational slack is doing two jobs

Suppose normalized centered values approach \(c\) from below. Then they can be
strictly below \(c\) arbitrarily late while failing to stay below every fixed
smaller threshold. For instance, a sequence with normalized values
\(c-1/n\) has no uniform negative margin beneath \(c\). Therefore the raw
same-target event \(A_c\) is too weak to represent a strict lower deviation.

The union over rational \(q\lt c\) says something stronger: at least one
fixed rational margin works beyond every cutoff. Density of the rationals
loses no strict gap. If a real margin lies strictly below \(c\), a rational
one can be inserted between them.

Countability is the second job. A union over all real thresholds below \(c\)
would not be directly closed by Mathlib's countable null-measurable union
theorem. The rationals preserve the intended strict semantics while keeping
the event inside a countable construction.

{{< reference-figure
  wide="true"
  src="rational-slack-exhaustion.svg"
  alt="Several rational witness lanes lie strictly below one target. Each lane requires witnesses beyond every cutoff, and a brace gathers the lanes into one countable strict event."
  caption="**Rational exhaustion:** one durable rational lane witnesses strict deviation. A second rational may be inserted above it but still below the target, which is exactly the room needed by the shift proof."
>}}

{{< panel "info" >}}
**Notation boundary.** \(A_q\) is the fixed-real-slope arbitrarily-late event.
\(D_c\) is the union over rational slopes strictly below the real target.
They are different sets. The compiled one-shot probe has
\(A_0=\{\mathsf{false}\}\) but \(D_0=\varnothing\).
{{< /panel >}}

## The one-step shift spends some margin

Centered subadditivity at the split (1+n) simplifies because the centered
time-one value is zero:

\[
Y_{n+1}(\omega)\le Y_n(T\omega).
\]

Assume \(T\omega\in A_q\). Given a desired cutoff \(N\), choose a witness
\(n\) beyond both \(N\) and an arithmetic cutoff \(K\). The witness at the
shifted point satisfies \(Y_n(T\omega)\lt qn\). At the original point,
centered subadditivity produces length \(n+1\), not length \(n\). We therefore
need

\[
qn\lt r(n+1)
\]

for a slightly larger slope \(r\). If \(q\lt r\), the growing gap
\((r-q)n\) eventually absorbs the fixed endpoint term \(r\). The theorem
`exists_nat_forall_mul_lt_mul_succ` proves this without assuming \(q\) or
\(r\) is negative.

This yields

\[
T^{-1}A_q\subseteq A_r\qquad(q\lt r).
\]

It does not yield \(T^{-1}A_q\subseteq A_q\). For \(D_c\), begin with a
rational \(q\lt c\), choose a rational \(r\) with \(q\lt r\lt c\), and move
from \(A_q\) to \(A_r\). Both lanes remain inside \(D_c\), so

\[
T^{-1}D_c\subseteq D_c.
\]

{{< reference-figure
  wide="true"
  src="shift-with-relaxed-slope.svg"
  alt="A shifted-point witness moves through centered subadditivity to the original point at a length increased by one, then enters a slightly relaxed rational lane after an Archimedean cutoff."
  caption="**Shift architecture:** the process inequality adds one endpoint. A strictly larger rational slope pays for that endpoint at sufficiently late witnesses. Rational density then keeps the relaxed slope below the original target."
>}}

## From inclusion to almost-everywhere invariance

The fixed-margin event is a countable intersection over cutoffs, a countable
union over witness lengths, and a proof-indexed union over the cutoff and
positivity conditions. Every leaf is a strict sublevel set of an integrable
centered process. `NullMeasurableSet.iInter` and
`NullMeasurableSet.iUnion` assemble the event. A further rational union
assembles \(D_c\). Finite total mass is not needed for either null-measurability
theorem.

Now let \(s=D_c\). The one-sided theorem gives \(T^{-1}s\subseteq s\).
Preservation gives equal extended measures:

\[
\mu(T^{-1}s)=\mu(s).
\]

On a finite measure space, the target has finite mass. Mathlib's
`ae_eq_of_subset_of_measure_ge` then upgrades subset plus equal measure to

\[
T^{-1}s=^{\mu}_{\mathrm{a.e.}}s.
\]

This is almost-everywhere equality, not setwise equality. The distinction is
intentional: null points may still disagree.

## Ergodicity creates a dichotomy; probability selects a branch

Finite-measure ergodicity acts on the almost-invariant null-measurable event.
Through `QuasiErgodic.ae_empty_or_univ₀`, it yields

\[
D_c=^{\mu}_{\mathrm{a.e.}}\varnothing
\quad\text{or}\quad
D_c=^{\mu}_{\mathrm{a.e.}}\Omega.
\]

No probability normalization is needed for that dichotomy. This is the first
important assumption boundary.

On a probability space, the two alternatives have numerical extended masses
zero and one. The RMT-31 inclusion \(D_c\subseteq B_{\infty,c}\), together
with the uniform all-length ratio, supplies a separate strict estimate. If
\(\delta\) is a lower bound for every positive normalized centered integral
and \(c\lt\delta\), then the time-one centered identity gives
\(\delta\le0\), hence \(c\lt0\), and

\[
\mu_{\mathbb R}(D_c)
\le \mu_{\mathbb R}(B_{\infty,c})
\le \frac{\delta}{c}
\lt 1.
\]

Probability normalization is what makes the almost-full branch have mass
one. The strict subunit estimate then excludes it. An ergodic finite measure
whose total mass is one half can have \(D_c=\Omega\) and
\(\mu_{\mathbb R}(D_c)=1/2\lt1\). The compiled half-Dirac probe verifies this
boundary.

{{< reference-figure
  wide="true"
  src="measure-rigidity-branch-selection.svg"
  alt="A five-stage flow moves from null measurability to almost-everywhere invariance, then to an ergodic almost-empty-or-almost-full dichotomy, then combines probability branch labels with a strict subunit estimate to select the empty branch."
  caption="**Assumption ledger in one picture:** finite-measure ergodicity supplies qualitative rigidity. Probability supplies the numerical mass of the full space. The RMT-31 estimate excludes that numerical branch."
>}}

## The cocycle specialization

For a discrete matrix cocycle \(C\), the generic process is
`C.logPlusNormObservable`. Its centered Fekete offset is

\[
\delta=
\operatorname{integratedLogPlusGrowthRate}(C)
-\operatorname{integratedLogPlusNorm}(C,1).
\]

RMT-30 now exposes the reusable theorem
`centeredFeketeOffset_le_normalizedIntegral`, which proves that this
\(\delta\) bounds every positive normalized centered integral from below.
RMT-32 therefore instantiates the generic null-selection theorem directly.

The cocycle endpoint assumes an integrable generator log-positive norm, an
ergodic probability base, and \(c\lt\delta\). It retains `Fintype` and
`DecidableEq` on the matrix index but no `Nonempty` assumption. Empty matrix
dimension remains a compiled boundary. The observable is log-positive, so
contractions are clipped. The result is not a theorem about a signed
Lyapunov exponent.

## Public declaration surface in exact source order

The module exports nineteen declarations.

### 1. `centeredArbitrarilyLateBadBlockSet`

```lean
def centeredArbitrarilyLateBadBlockSet {Ω : Type uΩ} (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) (q : ℝ) : Set Ω :=
  ⋂ N : ℕ, ⋃ n : ℕ, ⋃ (_h : N ≤ n ∧ 0 < n),
    {ω | centeredProcess T X n ω < q * (n : ℝ)}
```

Names the fixed-real-slope event \(A_q\). The proof index records both the
cutoff and positivity conditions inside the union.

### 2. `mem_centeredArbitrarilyLateBadBlockSet_iff`

```lean
@[simp] theorem mem_centeredArbitrarilyLateBadBlockSet_iff
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {q : ℝ} {ω : Ω} :
    ω ∈ centeredArbitrarilyLateBadBlockSet T X q ↔
      ∀ N : ℕ, ∃ n : ℕ, N ≤ n ∧ 0 < n ∧
        centeredProcess T X n ω < q * (n : ℝ)
```

Exposes the exact beyond-every-cutoff semantics and keeps witness positivity
explicit.

### 3. `centeredStrictLowerDeviationSet`

```lean
def centeredStrictLowerDeviationSet {Ω : Type uΩ} (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) (c : ℝ) : Set Ω :=
  ⋃ q : ℚ, ⋃ (_h : (q : ℝ) < c),
    centeredArbitrarilyLateBadBlockSet T X (q : ℝ)
```

Names \(D_c\), a countable union of durable rational margins.

### 4. `mem_centeredStrictLowerDeviationSet_iff`

```lean
@[simp] theorem mem_centeredStrictLowerDeviationSet_iff
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {c : ℝ} {ω : Ω} :
    ω ∈ centeredStrictLowerDeviationSet T X c ↔
      ∃ q : ℚ, (q : ℝ) < c ∧
        ω ∈ centeredArbitrarilyLateBadBlockSet T X (q : ℝ)
```

Turns nested indexed-union membership into one rational witness and its
strict target inequality.

### 5. `exists_nat_forall_mul_lt_mul_succ`

```lean
theorem exists_nat_forall_mul_lt_mul_succ {q r : ℝ} (hqr : q < r) :
    ∃ N : ℕ, ∀ n : ℕ, N ≤ n →
      q * (n : ℝ) < r * ((n + 1 : ℕ) : ℝ)
```

Absorbs the one-step endpoint for any ordered real slopes. No negativity
premise is hidden.

### 6. `centeredArbitrarilyLateBadBlockSet_subset_allLength`

```lean
theorem centeredArbitrarilyLateBadBlockSet_subset_allLength
    {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (q : ℝ) :
    centeredArbitrarilyLateBadBlockSet T X q ⊆
      centeredAllLengthBadBlockSet T X q
```

Chooses cutoff zero and forgets recurrence, leaving one positive witness.

### 7. `centeredStrictLowerDeviationSet_subset_allLength`

```lean
theorem centeredStrictLowerDeviationSet_subset_allLength
    {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (c : ℝ) :
    centeredStrictLowerDeviationSet T X c ⊆
      centeredAllLengthBadBlockSet T X c
```

Forgets recurrence and raises the rational witness slope from \(q\) to \(c\)
using the positive witness length.

### 8. `IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredArbitrarilyLateBadBlockSet`

```lean
theorem nullMeasurableSet_centeredArbitrarilyLateBadBlockSet
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (q : ℝ) :
    NullMeasurableSet (centeredArbitrarilyLateBadBlockSet T X q) μ
```

Uses centered-process integrability at each length, strict-sublevel null
measurability, and countable intersections and unions. Finite mass is absent.

### 9. `IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredStrictLowerDeviationSet`

```lean
theorem nullMeasurableSet_centeredStrictLowerDeviationSet
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (c : ℝ) :
    NullMeasurableSet (centeredStrictLowerDeviationSet T X c) μ
```

Adds the countable rational union to declaration 8.

### 10. `IsIntegrableSubadditiveProcessCandidate.preimage_centeredArbitrarilyLateBadBlockSet_subset_of_lt`

```lean
theorem preimage_centeredArbitrarilyLateBadBlockSet_subset_of_lt
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    {q r : ℝ} (hqr : q < r) :
    T ⁻¹' centeredArbitrarilyLateBadBlockSet T X q ⊆
      centeredArbitrarilyLateBadBlockSet T X r
```

Combines declaration 5 with centered shifted subadditivity. It needs the
candidate's algebraic law but neither preservation nor a finite measure.

### 11. `IsIntegrableSubadditiveProcessCandidate.preimage_centeredStrictLowerDeviationSet_subset`

```lean
theorem preimage_centeredStrictLowerDeviationSet_subset
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X) (c : ℝ) :
    T ⁻¹' centeredStrictLowerDeviationSet T X c ⊆
      centeredStrictLowerDeviationSet T X c
```

Uses rational density to turn declaration 10's relaxed-slope result into a
same-target one-sided inclusion for \(D_c\).

### 12. `IsIntegrableSubadditiveProcessCandidate.preimage_centeredStrictLowerDeviationSet_ae_eq`

```lean
theorem preimage_centeredStrictLowerDeviationSet_ae_eq
    [IsFiniteMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (c : ℝ) :
    T ⁻¹' centeredStrictLowerDeviationSet T X c =ᵐ[μ]
      centeredStrictLowerDeviationSet T X c
```

Combines one-sided inclusion, preserved measure, preimage null measurability,
and finite target mass to get almost-everywhere equality.

### 13. `IsIntegrableSubadditiveProcessCandidate.centeredStrictLowerDeviationSet_ae_empty_or_univ`

```lean
theorem centeredStrictLowerDeviationSet_ae_empty_or_univ
    [IsFiniteMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (c : ℝ) :
    centeredStrictLowerDeviationSet T X c =ᵐ[μ] (∅ : Set Ω) ∨
      centeredStrictLowerDeviationSet T X c =ᵐ[μ] Set.univ
```

Applies quasi-ergodic rigidity to declarations 9 and 12. Probability is not
required.

### 14. `IsIntegrableSubadditiveProcessCandidate.measure_centeredStrictLowerDeviationSet_eq_zero_or_one`

```lean
theorem measure_centeredStrictLowerDeviationSet_eq_zero_or_one
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (c : ℝ) :
    μ (centeredStrictLowerDeviationSet T X c) = 0 ∨
      μ (centeredStrictLowerDeviationSet T X c) = 1
```

Converts the almost-empty or almost-full alternatives into numerical
extended-measure branches using probability normalization.

### 15. `IsIntegrableSubadditiveProcessCandidate.measureReal_centeredStrictLowerDeviationSet_lt_one`

```lean
theorem measureReal_centeredStrictLowerDeviationSet_lt_one
    [IsFiniteMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : MeasurePreserving T μ μ) (δ c : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ))
    (hc : c < δ) :
    μ.real (centeredStrictLowerDeviationSet T X c) < 1
```

Uses declaration 7, RMT-31's all-length ratio, the time-one sign deduction,
and negative-denominator arithmetic. It needs neither probability nor
ergodicity.

### 16. `IsIntegrableSubadditiveProcessCandidate.measure_centeredStrictLowerDeviationSet_eq_zero`

```lean
theorem measure_centeredStrictLowerDeviationSet_eq_zero
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (δ c : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ))
    (hc : c < δ) :
    μ (centeredStrictLowerDeviationSet T X c) = 0
```

Selects the zero branch from declaration 14 by contradicting declaration 15
if the mass were one.

### 17. `DiscreteMatrixCocycle.centeredLogPlusArbitrarilyLateBadBlockSet`

```lean
def centeredLogPlusArbitrarilyLateBadBlockSet
    (C : DiscreteMatrixCocycle (ι := ι) μ) (q : ℝ) : Set Ω :=
  centeredArbitrarilyLateBadBlockSet C.base C.logPlusNormObservable q
```

Gives the fixed-margin generic event a cocycle-facing name.

### 18. `DiscreteMatrixCocycle.centeredLogPlusStrictLowerDeviationSet`

```lean
def centeredLogPlusStrictLowerDeviationSet
    (C : DiscreteMatrixCocycle (ι := ι) μ) (c : ℝ) : Set Ω :=
  centeredStrictLowerDeviationSet C.base C.logPlusNormObservable c
```

Gives the rationally exhausted strict event a cocycle-facing name.

### 19. `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measure_centeredLogPlusStrictLowerDeviationSet_eq_zero`

```lean
theorem HasIntegrableGeneratorLogPlus.measure_centeredLogPlusStrictLowerDeviationSet_eq_zero
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (hErg : Ergodic C.base μ)
    (c : ℝ)
    (hc : c < C.integratedLogPlusGrowthRate hC -
      C.integratedLogPlusNorm 1) :
    μ (C.centeredLogPlusStrictLowerDeviationSet c) = 0
```

Instantiates declaration 16 with the cocycle candidate and RMT-30's extracted
centered Fekete offset lower bound. The matrix index may be empty.

## Complete local proof-step ledger

| Declaration | Local step, in source order | Job |
|---|---|---|
| Fixed-margin membership | Unfold intersection and union membership | Converts nested set constructors into cutoff and witness quantifiers |
| Fixed-margin membership | Forward direction splits the proof pair | Separates cutoff and positivity evidence |
| Fixed-margin membership | Reverse direction repackages the proof pair | Re-enters the proof-indexed union |
| Strict-event membership | Unfold both rational unions | Exposes one rational slope and its strict target proof |
| Endpoint absorption | `N` from `exists_nat_gt` | Chooses an Archimedean cutoff above the required quotient |
| Endpoint absorption | `hpos` | Records positivity of the slope gap |
| Endpoint absorption | `hquot` | Moves the natural witness beyond the real cutoff |
| Endpoint absorption | `hmul` | Clears the positive denominator |
| Endpoint absorption | `push_cast`; `linarith` | Rewrites the successor cast and closes the linear inequality |
| Fixed-margin to once-bad | Specialize the cutoff at zero | Obtains one positive witness and forgets recurrence |
| Strict event to once-bad | Extract `q`, then specialize at zero | Obtains one positive rational-margin witness |
| Strict event to once-bad | `mul_lt_mul_of_pos_right` | Raises the threshold from \(q\) to \(c\) using positive length |
| Fixed-margin null measurability | `iInter`, then two `iUnion` steps | Mirrors the countable set constructor exactly |
| Fixed-margin null measurability | `nullMeasurableSet_lt` | Uses centered integrability against a measurable constant threshold |
| Strict-event null measurability | Two rational indexed unions | Reuses fixed-margin null measurability for every included slope |
| Relaxed fixed-slope preimage | `K` from endpoint absorption | Freezes when the slope gap pays for one endpoint |
| Relaxed fixed-slope preimage | Witness cutoff `max N K` | Satisfies the requested cutoff and arithmetic cutoff together |
| Relaxed fixed-slope preimage | `hsub` from `centeredProcess_add_le 1 n` | Moves a shifted witness to an original-point witness of length one larger |
| Relaxed fixed-slope preimage | Strict transitivity | Chains process control, badness, and endpoint absorption |
| Same-target strict preimage | Extract rational `q` | Opens membership in the source strict event |
| Same-target strict preimage | `r` from `exists_rat_btwn` | Inserts a relaxed rational slope while staying below the target |
| Same-target strict preimage | Declaration 10 | Moves from the `q` lane to the `r` lane |
| Almost invariance | Local abbreviation `s` and null-measurability fact `hs` | Keeps the measure proof readable |
| Almost invariance | `hT.measure_preimage hs` | Gives equal measure to the set and its preimage |
| Almost invariance | `hs.preimage hT.quasiMeasurePreserving` | Supplies null measurability on the subset side |
| Almost invariance | `ae_eq_of_subset_of_measure_ge` | Converts subset plus equal finite measure into almost-everywhere equality |
| Ergodic dichotomy | `hT.quasiErgodic.ae_empty_or_univ₀` | Applies rigidity to a null-measurable almost-invariant set |
| Numerical zero or one | Case split on the dichotomy | Converts almost-empty and almost-full into measure equalities |
| Strict subunit mass | `hδnonpos` from time one | Proves \(\delta\le0\) because the time-one centered integral is zero |
| Strict subunit mass | `hcneg` | Derives \(c\lt0\) from \(c\lt\delta\le0\) |
| Strict subunit mass | `measureReal_mono` | Compares \(D_c\) with RMT-31's once-bad event |
| Strict subunit mass | RMT-31 ratio theorem | Bounds the larger event by \(\delta/c\) |
| Strict subunit mass | `div_lt_one_of_neg` | Converts \(c\lt\delta\) into \(\delta/c\lt1\) for negative \(c\) |
| Null selection | Case split on zero or one | Returns the zero branch immediately |
| Null selection | `hreal` and `hlt` | Turns mass one into real mass one and contradicts strict subunit mass |
| Cocycle null theorem | Local candidate `hX` | Retrieves the generic centered-process interface |
| Cocycle null theorem | Extracted RMT-30 bound | Supplies every positive normalized centered-integral lower bound |
| Cocycle null theorem | Declaration 16 | Selects the null branch below the centered Fekete offset |

## Receiver surface versus proof dependency

Declarations 10 and 11 are methods on the full
`IsIntegrableSubadditiveProcessCandidate` bundle. Their proofs use only the
bundle's shifted-subadditivity field `add_le`. They do not use its
integrability field, preservation, or finite mass.

The receiver is retained for an ergonomic, uniform project API. This is not a
claim that integrability is mathematically necessary for the two set
inclusions. Integrability first becomes active in declaration 8, where it
supplies null measurability of the strict sublevel leaves, and remains active
through the measure-theoretic conclusions.

## Private boundary-support declarations

The source next introduces twenty-one private declarations. They compile
countermodels and degenerate cases without enlarging the public namespace.

| Private item, in source order | Construction or proof job |
|---|---|
| `rmt32ZeroProcess` | Constant zero at every time and point |
| `rmt32Collapse` | Sends both Boolean points to `true` |
| `rmt32OneShotProcess` | Is minus one from length two onward at `false`, and zero otherwise |
| `rmt32_iterate_collapse_true` | Proves every iterate fixes `true` |
| `rmt32_iterate_collapse_of_ne_zero` | Proves every positive iterate sends either point to `true` |
| `rmt32OneShotProcess_candidate` | Compiles integrability and shifted subadditivity over the collapse base |
| `rmt32Collapse_preserving` | Proves the collapse preserves the Dirac measure at `true` |
| `rmt32OneShotProcess_centered_lower_bound` | Gives the pointwise centered lower bound minus one |
| `rmt32OneShotProcess_not_mem_arbitrarilyLate_of_neg` | Uses an Archimedean cutoff to exclude every negative fixed margin |
| `rmt32TwoPointProbability` | Half the sum of the Dirac masses at `false` and `true` |
| anonymous `IsProbabilityMeasure` instance | Verifies total mass one for the two-point measure |
| `rmt32Id_not_preErgodic` | Uses the invariant singleton to refute pre-ergodicity of the Boolean identity |
| `rmt32TwoPointProcess` | Equals minus `n - 1` on `false` and zero on `true` |
| `rmt32TwoPointProcess_candidate` | Compiles finite-space integrability and shifted subadditivity |
| `rmt32TwoPointStrictLowerDeviationSet` | Computes the strict event at minus three quarters as `{false}` |
| `rmt32HalfUnitMeasure` | Scales the Dirac mass on `Unit` to total mass one half |
| anonymous `IsFiniteMeasure` instance | Records finiteness without probability normalization |
| `rmt32IdHalfUnit_ergodic` | Proves the identity on the one-point space is ergodic for the half-Dirac measure |
| `rmt32UnitProcess` | Equals minus `n - 1` at the unique point |
| `rmt32UnitProcess_candidate` | Compiles constant-function integrability and shifted subadditivity |
| `rmt32UnitStrictLowerDeviationSet` | Computes the strict event at minus three quarters as the full space |

## Six compiled boundary probes in exact source order

{{< reference-figure
  wide="true"
  src="rmt32-boundary-probe-grid.svg"
  alt="Six conceptual cells summarize the compiled probes: a zero-process empty event, a one-shot separation, a fixed-zero-slope separation, a nonergodic half-mass event, an ergodic half-Dirac full event with subunit mass, and an empty matrix index."
  caption="**Compiled boundary grid:** the examples separate recurrence from one-shot badness, fixed-target recurrence from strict rational slack, finite-measure rigidity from probability normalization, and matrix finiteness from nonempty dimension."
>}}

1. **Zero process.** For every \(c\le0\), the zero process has
   \(D_c=\varnothing\). A rational \(q\lt c\) is nonpositive, so
   \(0\lt qn\) cannot hold at a positive length.
2. **One-shot collapse.** At \(c=-2/5\), the RMT-31 once-bad event is exactly
   `{false}`, while \(D_c\) is empty. The centered process never drops below
   minus one, whereas every negative linear threshold eventually does.
3. **Raw fixed target versus strict rational event.** For the same process,
   \(A_0=\{\mathsf{false}\}\) because minus one is below zero at every late
   length. Yet \(D_0=\varnothing\), since no fixed negative rational margin
   works. This compiles the reason \(A_c\) cannot replace \(D_c\).
4. **Nonergodic probability model.** The Boolean identity preserves the
   two-atom probability but is not pre-ergodic. At \(c=-3/4\), the strict
   event is `{false}` and has real mass \(1/2\). Intermediate probability is
   possible when ergodicity is absent.
5. **Ergodic subprobability model.** The identity on `Unit` is ergodic for a
   Dirac measure scaled to total mass \(1/2\). The strict event is the full
   space and has real mass \(1/2\le2/3\lt1\). Thus ergodicity plus a strict
   subunit estimate does not select the null branch unless full-space mass is
   normalized to one.
6. **Empty matrix index.** The final cocycle null theorem typechecks with
   `ι := Empty`. No coordinate choice or nonempty-index premise is hidden.

## Complete source-order map

| Order | Kind | Source item |
|---:|---|---|
| 1 | Public definition | `centeredArbitrarilyLateBadBlockSet` |
| 2 | Public theorem | `mem_centeredArbitrarilyLateBadBlockSet_iff` |
| 3 | Public definition | `centeredStrictLowerDeviationSet` |
| 4 | Public theorem | `mem_centeredStrictLowerDeviationSet_iff` |
| 5 | Public theorem | `exists_nat_forall_mul_lt_mul_succ` |
| 6 | Public theorem | `centeredArbitrarilyLateBadBlockSet_subset_allLength` |
| 7 | Public theorem | `centeredStrictLowerDeviationSet_subset_allLength` |
| 8 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredArbitrarilyLateBadBlockSet` |
| 9 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredStrictLowerDeviationSet` |
| 10 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.preimage_centeredArbitrarilyLateBadBlockSet_subset_of_lt` |
| 11 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.preimage_centeredStrictLowerDeviationSet_subset` |
| 12 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.preimage_centeredStrictLowerDeviationSet_ae_eq` |
| 13 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.centeredStrictLowerDeviationSet_ae_empty_or_univ` |
| 14 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.measure_centeredStrictLowerDeviationSet_eq_zero_or_one` |
| 15 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.measureReal_centeredStrictLowerDeviationSet_lt_one` |
| 16 | Public receiver theorem | `IsIntegrableSubadditiveProcessCandidate.measure_centeredStrictLowerDeviationSet_eq_zero` |
| 17 | Public cocycle definition | `DiscreteMatrixCocycle.centeredLogPlusArbitrarilyLateBadBlockSet` |
| 18 | Public cocycle definition | `DiscreteMatrixCocycle.centeredLogPlusStrictLowerDeviationSet` |
| 19 | Public cocycle receiver theorem | `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measure_centeredLogPlusStrictLowerDeviationSet_eq_zero` |
| 20 | Private boundary definition | `rmt32ZeroProcess` |
| 21 | Private boundary definition | `rmt32Collapse` |
| 22 | Private boundary definition | `rmt32OneShotProcess` |
| 23 | Private boundary theorem | `rmt32_iterate_collapse_true` |
| 24 | Private boundary theorem | `rmt32_iterate_collapse_of_ne_zero` |
| 25 | Private boundary theorem | `rmt32OneShotProcess_candidate` |
| 26 | Private boundary theorem | `rmt32Collapse_preserving` |
| 27 | Private boundary theorem | `rmt32OneShotProcess_centered_lower_bound` |
| 28 | Private boundary theorem | `rmt32OneShotProcess_not_mem_arbitrarilyLate_of_neg` |
| 29 | Anonymous example | Zero process gives an empty strict event at every nonpositive target |
| 30 | Anonymous example | Once-bad one-shot event is nonempty while the strict late event is empty |
| 31 | Anonymous example | Raw fixed-zero-slope event is nonempty while the rational strict event is empty |
| 32 | Private boundary definition | `rmt32TwoPointProbability` |
| 33 | Private boundary instance | `IsProbabilityMeasure rmt32TwoPointProbability` |
| 34 | Private boundary theorem | `rmt32Id_not_preErgodic` |
| 35 | Private boundary definition | `rmt32TwoPointProcess` |
| 36 | Private boundary theorem | `rmt32TwoPointProcess_candidate` |
| 37 | Private boundary theorem | `rmt32TwoPointStrictLowerDeviationSet` |
| 38 | Anonymous example | Nonergodic strict event is a singleton of mass one half |
| 39 | Private boundary definition | `rmt32HalfUnitMeasure` |
| 40 | Private boundary instance | `IsFiniteMeasure rmt32HalfUnitMeasure` |
| 41 | Private boundary theorem | `rmt32IdHalfUnit_ergodic` |
| 42 | Private boundary definition | `rmt32UnitProcess` |
| 43 | Private boundary theorem | `rmt32UnitProcess_candidate` |
| 44 | Private boundary theorem | `rmt32UnitStrictLowerDeviationSet` |
| 45 | Anonymous example | Ergodic half-Dirac full event has strict subunit mass |
| 46 | Anonymous example | Empty matrix-index cocycle null theorem |
| 47 | Axiom audit | Fixed-margin membership semantics |
| 48 | Axiom audit | Strict-event membership semantics |
| 49 | Axiom audit | Endpoint absorption |
| 50 | Axiom audit | Strict event embeds into the once-bad event |
| 51 | Axiom audit | Strict-event null measurability |
| 52 | Axiom audit | Same-target one-sided preimage inclusion |
| 53 | Axiom audit | Almost-everywhere preimage equality |
| 54 | Axiom audit | Finite-measure ergodic dichotomy |
| 55 | Axiom audit | Generic null-branch selection |
| 56 | Axiom audit | Cocycle null-branch selection |

## Ten axiom reports

The warning-fatal Lean run prints all ten theorem footprints as exactly the
same standard trio:

```text
'NonlinearDynamics.Random.RandomCocycles.mem_centeredArbitrarilyLateBadBlockSet_iff'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.mem_centeredStrictLowerDeviationSet_iff'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.exists_nat_forall_mul_lt_mul_succ'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.centeredStrictLowerDeviationSet_subset_allLength'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredStrictLowerDeviationSet'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.preimage_centeredStrictLowerDeviationSet_subset'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.preimage_centeredStrictLowerDeviationSet_ae_eq'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.centeredStrictLowerDeviationSet_ae_empty_or_univ'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.measure_centeredStrictLowerDeviationSet_eq_zero'
depends on axioms: [propext, Classical.choice, Quot.sound]

'NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measure_centeredLogPlusStrictLowerDeviationSet_eq_zero'
depends on axioms: [propext, Classical.choice, Quot.sound]
```

No project-specific axiom or proof hole appears.

## Assumption and conclusion ledger

| Layer | Required assumptions | Exact output | Explicitly absent |
|---|---|---|---|
| Event definitions and membership | Functions, naturals, real or rational slopes | Exact cutoff and witness semantics | Measurable space, measure, preservation |
| Endpoint absorption | Two ordered real slopes | Eventual successor threshold inequality | Sign restrictions, process, measure |
| Event inclusion into once-bad | Positive witness semantics and rational target ordering | Set inclusion | Candidate, measurability, preservation |
| Fixed and strict null measurability | Integrable candidate, preservation | `NullMeasurableSet` | Finite total mass, probability, ergodicity |
| Pure preimage inclusions | Full candidate receiver, with only `add_le` consumed by the proof | Relaxed fixed-slope inclusion and same-target strict-event inclusion | Integrability as proof dependency, preservation, finite mass |
| Almost invariance | Candidate, preservation, finite measure | Preimage equals event almost everywhere | Ergodicity, probability, setwise equality |
| Ergodic rigidity | Candidate, finite measure, ergodic base | Event almost empty or almost full | Probability normalization, rate bound |
| Numerical dichotomy | Candidate, ergodic probability base | Extended measure zero or one | Blockwise lower-rate premise |
| Strict subunit estimate | Candidate, finite measure, preservation, normalized lower bound, strict target | Real event mass below one | Ergodicity, probability |
| Generic null selection | Candidate, ergodic probability base, normalized lower bound, strict target | Extended event measure zero | Liminf identification, process convergence |
| Cocycle null selection | Finite decidable index, integrable generator log-positive norm, ergodic probability base, target below centered Fekete offset | Cocycle strict-event measure zero | Nonempty index, signed log, Lyapunov exponent |

## Common wrong turns

### Using the once-bad event in an ergodic argument

One witness can disappear after a shift. The compiled collapse model has a
nonempty once-bad event and an empty strict late event at the same threshold.

### Replacing \(D_c\) with \(A_c\)

Arbitrarily late values below \(c\) may approach \(c\) with vanishing slack.
The fixed-zero-slope probe has \(A_0\ne D_0\). Strict lower deviation needs a
fixed smaller rational slope.

### Taking an uncountable real union

The intended strict event can be exhausted by rational thresholds. Using all
real thresholds discards the direct countable-union measurability proof for no
mathematical gain.

### Claiming same-slope preimage stability

The shift changes length from \(n\) to \(n+1\). The public fixed-slope theorem
therefore moves from \(q\) to a strictly larger \(r\). Same-target stability
appears only after taking the rational union.

### Calling one-sided inclusion invariance

`T ⁻¹' D_c ⊆ D_c` is not equality. Preservation and finite mass are used in a
separate theorem to obtain equality only almost everywhere.

### Treating finite-measure ergodicity as probability

Ergodicity gives the almost-empty or almost-full dichotomy at any finite total
mass. It does not make the full space have mass one.

### Inferring nullity from real mass below one

The half-Dirac probe is ergodic, has \(D_c=\Omega\), and still has real event
mass below one. Probability normalization is exactly what makes subunit mass
contradict the full branch.

### Dividing before establishing the sign

The ratio denominator is negative. The proof first specializes the normalized
lower bound at time one to get \(\delta\le0\), then derives \(c\lt0\), and only
then uses `div_lt_one_of_neg`.

### Treating the receiver bundle as a minimal hypothesis list

The pure preimage-inclusion methods live on the project candidate bundle for
API consistency, but their proofs project only `add_le`. Integrability is not
a hidden logical input to those two proofs.

### Calling \(D_c\) a liminf event already

Its quantifiers are designed for a lower-limit bridge, but no theorem in this
module equates it with a library-level real `liminf`. The later
[RMT-33 Notebook]({{< relref "/development-notebook/2026/07/log-positive-kingman-convergence-from-rational-lower-deviations-in-lean" >}})
states and proves the guarded bridge explicitly.

### Reading log-positive growth as signed asymptotic growth

The cocycle observable clips contractions. Nullity of its strict centered
lower-deviation event is not a Lyapunov-exponent or Oseledets theorem.

## Thirty solved exercises

### Exercise 1: unfold the fixed-margin event

What does \(\omega\in A_q\) mean without set constructors?

**Solution.** For every natural cutoff \(N\), there is a natural
\(n\ge N\) with \(n\gt0\) and \(Y_n(\omega)\lt qn\). The same fixed \(q\)
must work for all cutoffs, while \(n\) may depend on \(N\).

### Exercise 2: explain the positivity conjunct

Why retain \(n\gt0\) even when cutoffs eventually become positive?

**Solution.** The definition quantifies over cutoff zero too, and downstream
normalized expressions divide by \(n\). Positivity makes the intended witness
domain explicit at every use and prevents time zero from entering by accident.

### Exercise 3: forget recurrence

Why does \(A_q\subseteq B_{\infty,q}\)?

**Solution.** Specialize the beyond-every-cutoff property at \(N=0\). It
returns one positive witness satisfying the once-bad inequality.

### Exercise 4: reject the converse

Why need \(B_{\infty,q}\not\subseteq A_q\) in general?

**Solution.** The one-shot collapse process has one strict witness at length
two but no fixed negative-margin witnesses arbitrarily late. Its once-bad set
is `{false}` while the corresponding strict late event is empty.

### Exercise 5: distinguish \(A_c\) from \(D_c\)

Suppose \(Y_n/n=c-1/n\). Which same-target property holds, and which durable
margin property can fail?

**Solution.** Every normalized value is below \(c\), so the same-target event
\(A_c\) holds. For any fixed \(q\lt c\), eventually \(c-1/n\gt q\), so no
single \(A_q\) with \(q\lt c\) need hold. Thus membership in \(D_c\) can fail.

### Exercise 6: justify rational thresholds

Why are rationals sufficient for a strict real target?

**Solution.** If a working real margin \(a\) satisfies \(a\lt c\), density
provides a rational \(q\) with \(a\lt q\lt c\). A value below \(an\) at
positive \(n\) is also below \(qn\), so the rational lane preserves the
strict deviation.

### Exercise 7: identify the countability benefit

What measure-theoretic closure becomes available after restricting margins to
\(\mathbb Q\)?

**Solution.** `NullMeasurableSet.iUnion` closes countable indexed unions. The
rationals form a countable type, so the strict event inherits null
measurability from its fixed-margin pieces.

### Exercise 8: derive the endpoint inequality

Rewrite \(qn\lt r(n+1)\) to show why \(q\lt r\) is enough eventually.

**Solution.** The inequality is equivalent to
\(-r\lt(r-q)n\). Since \(r-q\gt0\), the right side grows without bound as
\(n\) grows, so one Archimedean cutoff suffices.

### Exercise 9: inspect signs

Does Exercise 8 require \(q\lt0\) or \(r\lt0\)?

**Solution.** No. Only \(r-q\gt0\) is used. The numerator (-r) may have any
sign; `exists_nat_gt` still chooses a natural above its quotient by the
positive gap.

### Exercise 10: orient the preimage

What does \(\omega\in T^{-1}A_q\) say?

**Solution.** It says \(T\omega\in A_q\). The proof starts with arbitrarily
late bad witnesses at the shifted point and uses centered subadditivity to
construct witnesses at the original point.

### Exercise 11: account for the successor

Why does the constructed original-point witness have length \(n+1\)?

**Solution.** The centered subadditive split is (1+n): the first block
starts at \(\omega\), and the remaining length-\(n\) block starts at
\(T\omega\). The centered time-one term simplifies to zero.

### Exercise 12: combine cutoffs

Why does the Lean proof query the shifted event at `max N K`?

**Solution.** The witness must be beyond the caller's desired cutoff \(N\) and
beyond the arithmetic cutoff \(K\) where the slope relaxation is valid. The
maximum enforces both with one query.

### Exercise 13: recover the same target

Given a source lane \(q\lt c\), how does the proof stay inside \(D_c\) after
the shift?

**Solution.** Choose rational \(r\) with \(q\lt r\lt c\). Declaration 10
moves the witness into \(A_r\), and \(r\lt c\) places that lane back inside
\(D_c\).

### Exercise 14: assemble null measurability

Which countable constructors appear in \(A_q\)?

**Solution.** A countable intersection over cutoffs, a countable union over
lengths, and a union over a proof proposition. The proof proposition is a
subsingleton and therefore countable. Each leaf is a null-measurable strict
sublevel set.

### Exercise 15: locate finite mass

Do declarations 8 and 9 need `[IsFiniteMeasure μ]`?

**Solution.** No. Countable null-measurable closure and integrability of each
centered process suffice. Finite mass first enters the almost-equality theorem.

### Exercise 16: upgrade a subset

Why does preservation matter after \(T^{-1}D_c\subseteq D_c\)?

**Solution.** It gives equal measures to \(D_c\) and its preimage. On a finite
target, a null-measurable subset with at least the target's measure must agree
with the target almost everywhere.

### Exercise 17: distinguish equality notions

Does declaration 12 prove \(T^{-1}D_c=D_c\) as sets?

**Solution.** No. It proves equality almost everywhere under \(\mu\). Setwise
disagreement on a null subset remains possible.

### Exercise 18: isolate the ergodic conclusion

What does finite-measure ergodicity yield before probability enters?

**Solution.** It yields \(D_c=^{\mu}_{\mathrm{a.e.}}\varnothing\) or
\(D_c=^{\mu}_{\mathrm{a.e.}}\Omega\). These are qualitative alternatives
relative to the given measure, not yet the numerical statement zero or one.

### Exercise 19: spend probability normalization

Where is total mass one used?

**Solution.** It turns the almost-full alternative into
\(\mu(D_c)=\mu(\Omega)=1\). The almost-empty alternative already has mass
zero without normalization.

### Exercise 20: read the half-Dirac probe

Why does event mass \(1/2\lt1\) fail to exclude the full branch there?

**Solution.** The full space itself has mass \(1/2\). Since \(D_c=\Omega\),
the event can be full and still have strict subunit mass. This is exactly what
probability normalization prevents.

### Exercise 21: derive the sign of \(\delta\)

What does the normalized lower bound say at \(n=1\)?

**Solution.** The centered time-one process is identically zero, so its
integral and normalized integral are zero. Therefore \(\delta\le0\).

### Exercise 22: prove the ratio is strict

Given \(c\lt\delta\le0\), why is \(\delta/c\lt1\)?

**Solution.** First \(c\lt0\). Multiplying the desired inequality by the
negative \(c\) reverses it, reducing \(\delta/c\lt1\) exactly to
\(c\lt\delta\).

### Exercise 23: read the nonergodic Boolean probe

What assumption does its half-mass event show to be necessary for the
dichotomy theorem?

**Solution.** It shows the need for ergodicity. The preserved probability
space has a strict event of mass \(1/2\), neither zero nor one, because the
identity preserves the nontrivial singleton.

### Exercise 24: test the zero process

Why is \(D_c\) empty for the zero process when \(c\le0\)?

**Solution.** Every included rational satisfies \(q\lt c\le0\). At positive
length \(n\), \(qn\le0\), so the required strict inequality \(0\lt qn\) is
impossible.

### Exercise 25: audit the API receiver

Which field of the candidate bundle do declarations 10 and 11 actually use?

**Solution.** Only `add_le`, through `centeredProcess_add_le`. They remain
methods on the full bundle for project ergonomics, while integrability begins
its proof role in declaration 8.

### Exercise 26: retain empty matrix dimension

Why can the cocycle theorem compile for `ι := Empty`?

**Solution.** Its assumptions require only a finite decidable index and the
bundled cocycle and integrability laws. No step chooses a coordinate, so no
`Nonempty ι` premise is needed.

### Exercise 27: state the source relationship honestly

Did Steele define the event \(D_c\) used here?

**Solution.** No. Steele supplies related centering, one-sided transformation,
and preservation architecture for a liminf proof. The rationally generated
event and its exact formal interface are this project's adaptation.

### Exercise 28: identify the RMT-33 bridge

What equivalence remains before \(D_c\) can prove a lower-liminf statement?

**Solution.** The later RMT-33 module connects membership in \(D_c\) with
frequent strict threshold crossings and then with a real lower-limit failure,
including the exact filter, boundedness, and positive-time conventions.

### Exercise 29: reject a full Kingman claim

Why does nullity of \(D_c\) for every \(c\lt\delta\) not yet finish samplewise
Kingman convergence?

**Solution.** The event-to-liminf bridge is absent from RMT-32, and a complete
convergence theorem must combine the lower bound with the earlier upper
limsup bound at the same deterministic rate. The present module proves only
the null-event component; RMT-33 later supplies those additional theorems.

### Exercise 30: read the cocycle threshold

Which number replaces the generic \(\delta\) in declaration 19?

**Solution.** The integrated log-positive growth rate minus the one-step
integrated log-positive norm. RMT-30's extracted theorem proves that this
centered Fekete offset is below every positive normalized centered integral.

## Reproduction and audit

The frozen source inspected for this note has 668 lines and SHA-256
`1bdcfd6b3be654f52bae22bdb2b44c15848e66d51f3a0973ce1c8aba61db14d4`.
Lean is pinned to 4.32.0 and Mathlib to commit
`81a5d257c8e410db227a6665ed08f64fea08e997`.

Build the leaf module with warnings fatal:

```text
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/SubadditiveLowerDeviation.lean
```

Regenerate and byte-verify the page-owned social card from any working
directory:

```text
site/content/development-notebook/2026/07/countably-generated-centered-lower-deviation-events-in-lean/generate-card.sh
site/content/development-notebook/2026/07/countably-generated-centered-lower-deviation-events-in-lean/generate-card.sh --verify
```

Check the generator and conceptual assets directly:

```text
shellcheck site/content/development-notebook/2026/07/countably-generated-centered-lower-deviation-events-in-lean/generate-card.sh
xmllint --noout site/content/development-notebook/2026/07/countably-generated-centered-lower-deviation-events-in-lean/*.svg
magick identify -format '%wx%h\n' site/content/development-notebook/2026/07/countably-generated-centered-lower-deviation-events-in-lean/countably-generated-centered-lower-deviation-events-in-lean-card.png
```

After the shared coverage map and companion textbook chapter are integrated,
run:

```text
make content-coverage
make content-hygiene
make site-check
```

## Discussion

Everything in this section interprets the checked architecture; the formal
declarations and their explicit assumptions stand on their own. The central
design lesson is that an ergodic proof begins before the ergodic theorem is
called. It begins with choosing an event whose quantifiers can survive a
shift.

The rational union is not cosmetic encoding. It simultaneously expresses a
strict asymptotic gap, exposes the slack needed to absorb one endpoint, and
keeps null measurability countable. Removing any one of those roles produces
a plausible but unusable event: the once-bad event forgets recurrence, the raw
same-target event allows vanishing slack, and an uncountable threshold union
loses the immediate Mathlib closure theorem.

The assumption split is equally substantive. Finite-measure ergodicity says
an almost-invariant event carries no nontrivial measurable information. It
does not normalize the mass of the universe. The half-Dirac probe makes that
distinction concrete: the event is full, ergodicity holds, and a real-mass
bound below one also holds. Probability is therefore not decorative notation
around the final theorem. It changes which numerical value represents the
full branch.

RMT-32 reaches the last event-level step of the lower-bound route. The
subsequent RMT-33 milestone connects this hand-built countable event to a
guarded real `liminf` formulation and combines it with the upper-limsup
machinery. That bridge is checked rather than inferred from the suggestive
name `centeredStrictLowerDeviationSet`.

## Navigation: adjacent milestones

**Previous, RMT-31:**
[All-Positive-Length Centered Bad-Block Control in Lean]({{< relref "/development-notebook/2026/07/all-positive-length-centered-bad-block-control-in-lean" >}})
passes one uniform finite-cap measure ratio to the once-bad union over every
positive length. It assumes finite measure and preservation but no probability
or ergodicity.

**Current companion:**
[Rational-Slack Lower-Deviation Events and Ergodic Null Selection]({{< relref "/knowledge-base/deep-dives/rational-slack-lower-deviation-events-and-ergodic-null-selection" >}})
develops the mathematics as a textbook ascent, with the event design,
one-sided shift geometry, and measure-theoretic rigidity separated into
reusable conceptual layers.

**Next, RMT-33:**
[Log-Positive Kingman Convergence from Rational Lower Deviations in Lean]({{< relref "/development-notebook/2026/07/log-positive-kingman-convergence-from-rational-lower-deviations-in-lean" >}})
builds the guarded real-liminf bridge, derives the almost-everywhere centered
and uncentered lower bounds, and combines them with the checked upper-limsup
route. RMT-32 itself does not pre-claim any of those later results.

## References

<a id="ref-rmt32-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://academic.oup.com/jrsssb/article/30/3/499/7026968),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968,
[doi:10.1111/j.2517-6161.1968.tb00749.x](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x).
This is the primary historical theorem source. Its convergence theorem is
strictly stronger than the event-nullity result formalized here.

<a id="ref-rmt32-steele"></a>**J. Michael Steele.**
[Kingman's subadditive ergodic theorem](https://www.numdam.org/item/AIHPB_1989__25_1_93_0/),
*Annales de l'Institut Henri Poincaré, Probabilités et Statistiques* 25(1),
93-98, 1989, MR 995293, Zbl 0669.60039, with the
[archival PDF](https://www.numdam.org/item/AIHPB_1989__25_1_93_0.pdf).
Page 94 centers the process, introduces its lower asymptotic quantity, obtains
a one-sided transformation comparison, and uses preservation to reach
almost-everywhere equality. RMT-32 follows that architectural cue while using
a project-specific rational event rather than attributing the event to Steele.

<a id="ref-rmt32-rmt31"></a>**This project.**
[All-Positive-Length Centered Bad-Block Control in Lean]({{< relref "/development-notebook/2026/07/all-positive-length-centered-bad-block-control-in-lean" >}}),
RMT-31. This checked predecessor supplies the once-bad superset and its
uniform real-measure ratio.

<a id="ref-rmt32-rmt30"></a>**This project.**
[Finite Centered Bad-Block Measure Control in Lean]({{< relref "/development-notebook/2026/07/finite-centered-bad-block-measure-control-in-lean" >}}),
RMT-30. This checked predecessor now exposes the centered Fekete offset as a
reusable lower bound for every positive normalized centered integral.

<a id="ref-rmt32-mathlib-null"></a>**Mathlib contributors.**
[Null-measurable countable unions and intersections](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/NullMeasurable.lean#L133-L149),
Mathlib commit `81a5d257`. The pinned source contains
`NullMeasurableSet.iUnion` and `NullMeasurableSet.iInter`.

<a id="ref-rmt32-mathlib-preserving"></a>**Mathlib contributors.**
[Measure-preserving preimage equality](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/MeasurePreserving.lean#L143-L150),
Mathlib commit `81a5d257`. The pinned source contains
`MeasurePreserving.measure_preimage` and its real-measure companion.

<a id="ref-rmt32-mathlib-ae"></a>**Mathlib contributors.**
[Almost-equality from subset and finite equal mass](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/MeasureSpace.lean#L368-L371),
Mathlib commit `81a5d257`. The pinned source contains
`ae_eq_of_subset_of_measure_ge`.

<a id="ref-rmt32-mathlib-ergodic"></a>**Mathlib contributors.**
[Almost-invariant-set rigidity](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Ergodic.lean#L135-L139),
Mathlib commit `81a5d257`. The pinned source contains
`QuasiErgodic.ae_empty_or_univ₀`. The finite-measure ergodic wrappers appear
later in the same file.

<a id="ref-rmt32-mathlib-rational"></a>**Mathlib contributors.**
[Rational density in Archimedean ordered fields](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Algebra/Order/Archimedean/Basic.lean#L372-L375),
Mathlib commit `81a5d257`. The pinned source contains `exists_rat_btwn`.

<a id="ref-rmt32-mathlib-real"></a>**Mathlib contributors.**
[Monotonicity of real-valued measure](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/Real.lean#L90-L92),
Mathlib commit `81a5d257`. The pinned source contains `measureReal_mono`.

<a id="ref-rmt32-mathlib-order"></a>**Mathlib contributors.**
[Division by a negative denominator](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Algebra/Order/Field/Basic.lean#L469-L473),
Mathlib commit `81a5d257`. The pinned source contains `div_lt_one_of_neg`.
