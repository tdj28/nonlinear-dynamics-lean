---
title: "Log-Positive Kingman Convergence from Rational Lower Deviations in Lean"
slug: "log-positive-kingman-convergence-from-rational-lower-deviations-in-lean"
date: 2026-07-22
weight: -67
author: "tdj28"
summary: "Random-matrix-theory milestone 33 (RMT-33) turns the null rational lower-deviation events of RMT-32 into an honest almost-everywhere lower-liminf bound, adds back the one-step Birkhoff average, and squeezes the normalized log-positive cocycle observable to its integrated Fekete growth rate."
lead: |
  The last obstruction is not a missing inequality but a semantic guard. Mathlib's real liminf is total even when a sequence has no eventual lower bound, so membership in a rational lower-deviation event cannot imply a real lower-liminf inequality without an explicit boundedness hypothesis. RMT-33 keeps that gate visible, covers strict liminf deviations by a null union at genuinely smaller rational targets, and reuses the same cover to construct an eventual lower bound almost everywhere. The centered estimate then joins a convergent Birkhoff average, while the earlier upper-limsup theorem closes a samplewise squeeze for the nonnegative log-positive cocycle observable.
key_result: |
  On a probability space, an integrable shifted-subadditive candidate over an ergodic transformation has an almost-everywhere eventual lower bound for its normalized centered process and a centered real liminf at least any common lower bound for its positive normalized centered integrals. Adding the ergodic Birkhoff limit transfers this lower estimate to the original process. For a discrete matrix cocycle with integrable one-step log-positive norm, bundled measure preservation and PreErgodic base dynamics imply almost-everywhere convergence of the total normalized log-positive norm observable to the integrated log-positive growth rate. Empty matrix dimension remains valid.
draft: true
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Conditional-completeness guards, real liminf events, countable null covers, Birkhoff addition, and log-positive cocycle convergence"
reading_time: "300 to 420 minutes"
prerequisites:
  - "RMT-32 rational strict lower-deviation events and null selection"
  - "RMT-29 subadditive upper-limsup control"
  - "RMT-28 ergodic Birkhoff averages and integral identification"
  - "Mathlib filters, frequent and eventual predicates, and real liminf APIs"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman"
lean_source: "formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveKingman.lean"
tags:
  - "Lean 4"
  - "Kingman theorem"
  - "Subadditive processes"
  - "Lower limit"
  - "Rational deviation"
  - "Ergodic theorem"
  - "Matrix cocycles"
  - "Log-positive growth"
og_image: "log-positive-kingman-convergence-from-rational-lower-deviations-in-lean-card.png"
og_image_alt: "Warm-paper teaching card showing a five-stage proof: normalize totally, guard the real lower limit, remove a rational null cover, add a Birkhoff average, and squeeze the normalized log-positive cocycle observable to the integrated growth rate."
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
**Abstract.** Let \(T\) act ergodically on a probability space, let \(X_n\) be
an integrable shifted-subadditive process candidate, and write

\[
u_n(\omega)=\frac{Y_n(\omega)}{n},
\qquad
Y_n=X_n-S_n(X_1).
\]

Lean uses total real division, so \(u_0=0\). Candidate subadditivity gives the
pointwise ceiling \(u_n\le 0\). The RMT-32 event \(D_c\) means that some
rational \(q\lt c\) is crossed frequently. If the real lower limit is below
\(c\), the ceiling supplies the conditional-completeness side needed to find
such a frequent rational crossing. The converse needs an actual eventual
lower bound. Without it, Mathlib's real `liminf` is a totalized value rather
than an extended-real lower limit.

For every target \(\delta\), RMT-33 covers

\[
\{\omega:\liminf_n u_n(\omega)\lt\delta\}
\]

by a countable union of RMT-32 events at rational targets strictly below
\(\delta\). That union is null. Its complement also gives a fixed rational
eventual lower bound, so both the numerical lower-liminf inequality and its
semantic boundedness certificate hold almost everywhere. The exact identity

\[
\frac{X_n}{n}=\frac{Y_n}{n}+\frac{S_n(X_1)}{n}
\]

then combines the centered estimate with Birkhoff convergence. For the
log-positive matrix-cocycle process, the centered Fekete offset plus the
one-step integral is the integrated growth rate. RMT-29 supplies the matching
upper limsup, and explicit upper and lower boundedness hypotheses close the
real convergence theorem.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This declaration-complete teaching chapter remains a
draft while human editorial acceptance and separate scientific-integrity and
zero-context expert-reader reviews are pending. The warning-fatal Lean source
is authoritative for every theorem, assumption, and boundary claim.
{{< /panel >}}

For reusable vocabulary, see {{< refterm "limit-inferior" "limit inferior" >}},
{{< refterm "limit-superior" "limit superior" >}},
{{< refterm "birkhoff-sum" "Birkhoff sums" >}},
{{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}},
{{< refterm "ergodic-probability-base" "ergodic probability bases" >}},
{{< refterm "integrated-log-positive-growth-rate" "the integrated log-positive growth rate" >}},
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycles" >}}, and
{{< refterm "almost-everywhere" "almost-everywhere statements" >}}.
The companion textbook chapter is
[The Guarded Real-Liminf Bridge to Log-Positive Kingman Convergence]({{< relref "/knowledge-base/deep-dives/guarded-real-liminf-bridge-to-log-positive-kingman-convergence" >}}).

## Orientation: the missing endpoint is a guarded bridge

RMT-32 proved that rationally generated strict centered lower-deviation
events are null below the centered Fekete offset. That theorem did not yet
identify those events with a real lower-limit statement. RMT-33 performs that
translation, but only after stating the conditional-completeness guard that
the real codomain requires.

The whole milestone can be read as five interfaces:

1. normalize every natural time, including zero;
2. connect rational frequent crossings with a real lower limit under the
   correct one-sided boundedness assumptions;
3. build a countable null cover below the desired target and recover an
   actual eventual lower bound off that cover;
4. add the convergent one-step Birkhoff average back to the centered process;
5. combine the lower endpoint with RMT-29's upper endpoint for the
   log-positive cocycle observable.

{{< reference-figure
  wide="true"
  src="rmt33-proof-ladder.svg"
  alt="A five-stage proof ladder runs from total normalization through a guarded real lower-limit bridge and a rational null cover to Birkhoff addition and a final log-positive convergence squeeze."
  caption="**The RMT-33 proof ladder:** every arrow names a separate mathematical interface. The rational null cover is central because it supplies both an almost-everywhere inequality and the boundedness certificate needed to interpret the real lower limit honestly."
>}}

The immediate predecessor is
[Countably Generated Centered Lower-Deviation Events in Lean]({{< relref "/development-notebook/2026/07/countably-generated-centered-lower-deviation-events-in-lean" >}}).
The complementary upper endpoint is
[Subadditive Upper Limsup from Phase Averaging in Lean]({{< relref "/development-notebook/2026/07/subadditive-upper-limsup-from-phase-averaging-in-lean" >}}),
and the additive convergence input is
[Identifying the Ergodic Birkhoff Constant in Lean]({{< relref "/development-notebook/2026/07/identifying-the-ergodic-birkhoff-constant-in-lean" >}}).

## Prior work, this milestone's contribution, and exact nonclaims

**Prior work.** Kingman's 1968 paper is the primary historical source for the
subadditive ergodic theorem ([Kingman 1968](#ref-rmt33-kingman)). Steele's 1989
account gives a short centering-based route through the subadditive argument
([Steele 1989](#ref-rmt33-steele)). Birkhoff's original ergodic theorem is the
historical source for the additive average used when centering is reversed
([Birkhoff 1931](#ref-rmt33-birkhoff)). The formal endpoint here is narrower
than the broadest classical formulations: it is tailored to the project's
real-valued process interfaces and then specialized to a nonnegative
log-positive matrix observable.

**This milestone's formal contribution.** RMT-33:

- defines total normalized original and centered processes;
- proves that replacing the time-zero slice changes no normalized value;
- records finite-prefix invariance of real `liminf` along natural time;
- translates arbitrarily-late bad blocks into `Frequently` normalized
  inequalities;
- proves the rational event to lower-liminf implication under an eventual
  lower bound;
- proves the reverse implication from the candidate's pointwise upper
  ceiling;
- exposes an exact guarded equivalence between the event and real strict
  lower-liminf deviation;
- covers a strict lower-liminf event by countably many RMT-32 events at
  genuinely smaller rational targets;
- proves both that cover and the lower-liminf deviation event are null;
- extracts an almost-everywhere eventual lower bound from the complement of
  the same cover;
- adds the one-step Birkhoff integral to the centered lower estimate;
- specializes the lower endpoint to the integrated log-positive growth rate;
  and
- combines lower liminf, upper limsup, and explicit boundedness gates into
  almost-everywhere convergence.

**Not claimed.** The module does not prove the full classical Kingman theorem
for arbitrary signed real subadditive processes. It does not assert an
unconditional equivalence between \(D_c\) and
\(\liminf u_n\lt c\); the event-to-liminf direction requires eventual lower
boundedness. It makes no extended-real lower-limit claim for unbounded-below
sequences. It proves no convergence in \(L^1\), in probability, or uniformly,
and no rate or concentration inequality. It performs no limit-integral
interchange and does not identify an expectation of the samplewise limit. It
proves no signed logarithmic growth, negative-tail estimate, inverse-cocycle
control, Lyapunov exponent, Lyapunov spectrum, Oseledets filtration, or
Oseledets splitting. It assumes no powered-map ergodicity, mixing, or
independence. It draws no nonlinear-stability, bifurcation, or physical-chaos
conclusion.

The positive endpoint is precise: on a probability base, bundled preservation
plus `PreErgodic` dynamics and one-step log-positive integrability give
almost-everywhere convergence of the normalized log-positive norm observable.
The theorem remains valid for an empty finite matrix index.

## Total normalization and the finite-prefix boundary

For a real process \(X:\mathbb N\to\Omega\to\mathbb R\), the module defines

\[
\operatorname{norm}X(n,\omega)=\frac{X_n(\omega)}{n}.
\]

In Lean, real division is total. At \(n=0\), the denominator is zero and the
quotient evaluates to zero. Thus `normalizedProcess X 0 ω` forgets `X 0 ω`
completely. This is a useful total API, but the note never pretends that the
zero-time quotient carries asymptotic information.

Two facts make the convention safe:

- replacing `X 0` by any function leaves the total normalized process
  pointwise unchanged; and
- `liminf_nat_add` removes any fixed finite prefix, so starting at time one
  gives the same real lower limit as starting at time zero.

{{< reference-figure
  wide="true"
  src="time-zero-is-forgotten.svg"
  alt="A timeline marks time zero as a totalized zero that forgets the original process slice, then shows positive normalized values and a finite-prefix shift leading to the same lower limit."
  caption="**Time zero is total but asymptotically silent:** the first theorem is pointwise, while finite-prefix invariance is a filter theorem. They solve different boundary obligations."
>}}

The exact centering identity is also total:

\[
\operatorname{normalizedProcess}(X)_n
=\operatorname{normalizedCenteredProcess}(T,X)_n
+\operatorname{birkhoffAverage}(T,X_1)_n.
\]

At time zero both normalized terms are zero. The identity is formally true
there, though its mathematical content belongs to positive time.

## The event bridge has asymmetric boundedness gates

Fix a point \(\omega\) and abbreviate

\[
u_n=\operatorname{normalizedCenteredProcess}(T,X,n,\omega).
\]

RMT-32's fixed-slope event is exactly

\[
\operatorname{Frequently}_{n\to\infty}(u_n\lt q).
\]

The positive witness in the original set definition is important. In the
forward direction it permits division by \(n\gt0\). In the reverse direction,
a frequent witness is requested beyond `max N 1`, which reconstructs both the
cutoff and positivity conditions.

The rational event \(D_c\) is therefore equivalent to the existence of a
rational \(q\lt c\) crossed frequently. From event membership to
\(\liminf u_n\lt c\), Mathlib's `liminf_le_of_frequently_le` requires

\[
\operatorname{IsBoundedUnder}(\,\ge,\operatorname{atTop},u\,),
\]

an actual eventual lower bound.

The reverse direction uses a different gate. Candidate centered
subadditivity gives \(u_n\le0\) for every \(n\), including the separate
zero-time case. This pointwise upper ceiling implies the coboundedness
condition required by `frequently_lt_of_liminf_lt`. A rational \(q\) between
the real lower limit and \(c\) then supplies the event witness.

{{< reference-figure
  wide="true"
  src="guarded-liminf-event-bridge.svg"
  alt="Two arrows connect a strict real lower-limit inequality and rational frequent-crossing event membership. The forward arrow uses the candidate's upper ceiling, while the reverse arrow is gated by an eventual lower bound."
  caption="**The bridge is not symmetric:** lower limit to event uses the candidate's upper ceiling. Event to lower limit needs a genuine eventual lower bound. The guarded equivalence keeps both logical jobs visible."
>}}

This asymmetry is the central design decision of the module. Hiding the lower
bound inside an informal appeal to the usual extended-real meaning of liminf
would make the statement stronger than Mathlib's real-valued API justifies.

## Why the proof chooses two rational cuts

Suppose the real lower limit \(L(\omega)\) satisfies \(L(\omega)\lt\delta\).
RMT-32 proves nullity only for events whose target is strictly below the
integral offset \(\delta\). Substituting \(\delta\) itself would demand the
false premise \(\delta\lt\delta\).

RMT-33 chooses an outer rational target \(c\) with

\[
L(\omega)\lt c\lt\delta.
\]

The lower-limit-to-event theorem then proves membership in \(D_c\). Inside
that theorem, rational density chooses an inner witness \(q\) with

\[
L(\omega)\lt q\lt c.
\]

The two cuts have distinct scopes. The outer cut places the point in a member
of a countable null cover indexed below \(\delta\). The inner cut witnesses the
strict rational event at that outer target.

{{< reference-figure
  wide="true"
  src="two-rational-cuts-below-the-rate.svg"
  alt="A number line orders the formal lower limit, an inner rational witness, an outer rational event target, and the integral offset. Labels distinguish the witness cut from the countable-cover cut."
  caption="**Two rational cuts, two proof obligations:** the inner rational witnesses frequent crossing, while the outer rational indexes a null event whose target is genuinely below the desired endpoint."
>}}

The outer exhaustion is

\[
E_\delta=\bigcup_{\substack{c\in\mathbb Q\\c\lt\delta}}D_c.
\]

Every member event has measure zero by RMT-32, so the countable union is null.
The strict lower-liminf deviation set is a subset of \(E_\delta\), hence null
by monotonicity.

## The totalized real lower limit needs a countermodel

The guard is not merely an artifact of a difficult proof. Consider the
genuine subadditive candidate on `Unit`

\[
X_n=-n^2.
\]

Its centered process relative to \(X_1=-1\) is

\[
Y_n=-n^2+n,
\]

and for positive time

\[
\frac{Y_n}{n}=-(n-1).
\]

The values escape to negative infinity. The point belongs to \(D_{-1}\), and
there is no eventual lower bound. Yet the module proves that Mathlib's
totalized real `liminf` for this normalized sequence is zero. Internally, the
set of real eventual lower bounds is empty and `Real.sSup_empty` is zero.

{{< reference-figure
  wide="true"
  src="totalized-real-liminf-countermodel.svg"
  alt="A descending sequence of positive-time centered normalized values crosses negative one and then escapes downward. A separate totalized real lower-limit box reports zero because the set of eventual real lower bounds is empty."
  caption="**A formal boundary countermodel:** event membership plus unbounded negative escape does not force Mathlib's totalized real `liminf` below the event target. The missing premise is exactly the eventual lower bound shown in the guarded theorem."
>}}

This example does not say that the extended-real lower limit is zero. It says
the opposite lesson: a total real-valued operation can return a conventional
value when the conditional-completeness side conditions fail. The module
therefore returns boundedness together with its almost-everywhere real
lower-liminf estimate.

## One null cover delivers two outputs

Off \(E_\delta\), choose rationals \(q\lt c\lt\delta\). Since the point is not
in \(D_c\), it cannot cross \(q\) frequently. The negation of frequent strict
inequality becomes an eventual weak inequality:

\[
\operatorname{Eventually}_{n\to\infty}(q\le u_n).
\]

Thus \(q\) is an actual eventual lower bound. Independently, the complement
of the strict lower-liminf deviation set gives \(\delta\le\liminf u_n\). Both
bad sets are null, so their almost-everywhere intersection returns the pair

\[
\operatorname{IsBoundedUnder}(\ge,\operatorname{atTop},u)
\quad\text{and}\quad
\delta\le\liminf_n u_n.
\]

{{< reference-figure
  wide="true"
  src="null-cover-two-deliverables.svg"
  alt="A rational null cover splits into two outputs on its complement: a fixed rational eventual lower bound and a lower-limit inequality at the target. The outputs rejoin as one almost-everywhere pair."
  caption="**The null cover does double duty:** it rules out strict lower-limit failure and, through the negation of frequent crossing, manufactures the boundedness certificate needed for later real-liminf algebra."
>}}

## Adding back the one-step Birkhoff average

Write \(u_n\) for the normalized centered process and \(v_n\) for the
one-step Birkhoff average. The exact identity gives the original normalized
process as \(u_n+v_n\). Ergodic Birkhoff convergence supplies

\[
v_n\longrightarrow\int X_1\,d\mu.
\]

The lower-limit addition theorem used by Lean is deliberately explicit about
boundedness. The centered sequence has the almost-everywhere eventual lower
bound just constructed and a pointwise upper bound of zero. The convergent
Birkhoff sequence supplies its own lower and upper boundedness data. Therefore

\[
\liminf u_n+\liminf v_n\le\liminf(u_n+v_n).
\]

Since the Birkhoff lower limit equals its limit, the generic original-process
endpoint is

\[
\delta+\int X_1\,d\mu
\le
\liminf_n\frac{X_n}{n}.
\]

{{< reference-figure
  wide="true"
  src="centered-plus-birkhoff-liminf-transfer.svg"
  alt="A centered lower-limit stream and a convergent Birkhoff-average stream enter an addition gate whose four boundedness certificates are shown, producing a lower bound for the original normalized process."
  caption="**Adding back is a theorem, not algebraic decoration:** the pointwise identity identifies the sum, while `le_liminf_add` spends four one-sided boundedness certificates before passing to lower limits."
>}}

## The log-positive cocycle endpoint

For a discrete matrix cocycle \(C\), the generic candidate is
`C.logPlusNormObservable`. Choose

\[
\delta=
\operatorname{integratedLogPlusGrowthRate}(C)
-\operatorname{integratedLogPlusNorm}(C,1).
\]

RMT-30 supplies this value as a lower bound for every positive normalized
centered integral. Adding the one-step integral cancels the subtraction, so
the generic theorem becomes

\[
\operatorname{integratedLogPlusGrowthRate}(C)
\le
\liminf_n\frac{\log^+\lVert C_n(\omega)\rVert}{n}
\]

almost everywhere.

RMT-29 supplies the matching almost-everywhere upper endpoint

\[
\limsup_n\frac{\log^+\lVert C_n(\omega)\rVert}{n}
\le
\operatorname{integratedLogPlusGrowthRate}(C).
\]

The normalized log-positive sequence is nonnegative, which supplies its
eventual lower bound. The one-step Birkhoff majorant bounds it eventually
above by a convergent sequence, which supplies its eventual upper bound.
Mathlib's `tendsto_of_le_liminf_of_limsup_le` then yields convergence.

{{< reference-figure
  wide="true"
  src="log-positive-kingman-squeeze.svg"
  alt="The integrated log-positive growth rate sits between the lower limit and upper limit bounds, while nonnegativity and a convergent Birkhoff majorant provide the lower and upper boundedness gates needed for convergence."
  caption="**The final squeeze:** lower liminf and upper limsup inequalities determine the candidate limit only after the real-valued sequence is certified bounded below and above along the filter."
>}}

The theorem asks for `PreErgodic C.base μ`, not a separate preservation
hypothesis, because the cocycle structure already bundles
`C.base_preserving`. The proof combines them locally into `Ergodic C.base μ`.

## Public declaration surface in exact source order

The module exports twenty-four declarations. The signatures below are the
public interface in source order. Each code block is an interface excerpt;
proof bodies remain in the checked Lean source.

### 1. `normalizedProcess`

```lean
def normalizedProcess {Ω : Type uΩ} (X : ℕ → Ω → ℝ)
    (n : ℕ) (ω : Ω) : ℝ :=
  X n ω / (n : ℝ)
```

Defines the total positive-time normalization and fixes the zero-time value by
total real division.

### 2. `normalizedProcess_zero`

```lean
@[simp] theorem normalizedProcess_zero
    {Ω : Type uΩ} (X : ℕ → Ω → ℝ) (ω : Ω) :
    normalizedProcess X 0 ω = 0
```

Records the time-zero convention as a simplification theorem.

### 3. `normalizedProcess_update_zero`

```lean
@[simp] theorem normalizedProcess_update_zero
    {Ω : Type uΩ} (X : ℕ → Ω → ℝ) (z : Ω → ℝ) :
    normalizedProcess (Function.update X 0 z) = normalizedProcess X
```

Shows that the total normalized process is pointwise insensitive to the
entire time-zero slice.

### 4. `normalizedCenteredProcess`

```lean
def normalizedCenteredProcess {Ω : Type uΩ} (T : Ω → Ω)
    (X : ℕ → Ω → ℝ) (n : ℕ) (ω : Ω) : ℝ :=
  normalizedProcess (centeredProcess T X) n ω
```

Names the total normalization of the orbit-majorant-centered process.

### 5. `normalizedCenteredProcess_zero`

```lean
@[simp] theorem normalizedCenteredProcess_zero
    {Ω : Type uΩ} (T : Ω → Ω) (X : ℕ → Ω → ℝ) (ω : Ω) :
    normalizedCenteredProcess T X 0 ω = 0
```

Keeps the centered zero-time boundary visible at the named API.

### 6. `liminf_normalizedProcess_succ`

```lean
theorem liminf_normalizedProcess_succ
    {Ω : Type uΩ} (X : ℕ → Ω → ℝ) (ω : Ω) :
    liminf (fun n ↦ normalizedProcess X (n + 1) ω) atTop =
      liminf (fun n ↦ normalizedProcess X n ω) atTop
```

Uses `liminf_nat_add` to prove that dropping the time-zero prefix changes no
real lower limit.

### 7. `normalized_eq_normalizedCenteredProcess_add_birkhoffAverage`

```lean
theorem normalized_eq_normalizedCenteredProcess_add_birkhoffAverage
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (n : ℕ) (ω : Ω) :
    normalizedProcess X n ω = normalizedCenteredProcess T X n ω +
      birkhoffAverage ℝ T (X 1) n ω
```

Exposes the exact pointwise decomposition used when the centered estimate is
transferred back to the original process.

### 8. `mem_centeredArbitrarilyLateBadBlockSet_iff_frequently_normalized_lt`

```lean
theorem mem_centeredArbitrarilyLateBadBlockSet_iff_frequently_normalized_lt
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {q : ℝ} {ω : Ω} :
    ω ∈ centeredArbitrarilyLateBadBlockSet T X q ↔
      ∃ᶠ n in atTop, normalizedCenteredProcess T X n ω < q
```

Translates the beyond-every-cutoff set into filter language while preserving
the positive-time boundary.

### 9. `mem_centeredStrictLowerDeviationSet_iff_exists_frequently_normalized_lt`

```lean
theorem mem_centeredStrictLowerDeviationSet_iff_exists_frequently_normalized_lt
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {c : ℝ} {ω : Ω} :
    ω ∈ centeredStrictLowerDeviationSet T X c ↔
      ∃ q : ℚ, (q : ℝ) < c ∧
        ∃ᶠ n in atTop, normalizedCenteredProcess T X n ω < (q : ℝ)
```

Makes the fixed rational margin in \(D_c\) explicit.

### 10. `liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet`

```lean
theorem liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {c : ℝ} {ω : Ω}
    (hlower : IsBoundedUnder (· ≥ ·) atTop
      (fun n ↦ normalizedCenteredProcess T X n ω))
    (hω : ω ∈ centeredStrictLowerDeviationSet T X c) :
    liminf (fun n ↦ normalizedCenteredProcess T X n ω) atTop < c
```

Provides the guarded event-to-liminf implication. The lower-bound premise is
mathematically necessary for the real-valued `liminf` API.

### 11. `centeredRationalLowerDeviationExhaustionSet`

```lean
def centeredRationalLowerDeviationExhaustionSet {Ω : Type uΩ}
    (T : Ω → Ω) (X : ℕ → Ω → ℝ) (δ : ℝ) : Set Ω :=
  ⋃ c : {c : ℚ // (c : ℝ) < δ},
    centeredStrictLowerDeviationSet T X (c : ℝ)
```

Defines the countable outer cover whose event targets are all genuinely below
\(\delta\).

### 12. `mem_centeredRationalLowerDeviationExhaustionSet_iff`

```lean
@[simp] theorem mem_centeredRationalLowerDeviationExhaustionSet_iff
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {δ : ℝ} {ω : Ω} :
    ω ∈ centeredRationalLowerDeviationExhaustionSet T X δ ↔
      ∃ c : ℚ, (c : ℝ) < δ ∧
        ω ∈ centeredStrictLowerDeviationSet T X (c : ℝ)
```

Exposes one outer rational target and its RMT-32 event membership.

### 13. `centeredLowerLiminfDeviationSet`

```lean
def centeredLowerLiminfDeviationSet {Ω : Type uΩ}
    (T : Ω → Ω) (X : ℕ → Ω → ℝ) (δ : ℝ) : Set Ω :=
  {ω | liminf (fun n ↦ normalizedCenteredProcess T X n ω) atTop < δ}
```

Names the strict real lower-liminf deviation set without claiming that it is
measurable by definition.

### 14. `mem_centeredLowerLiminfDeviationSet_iff`

```lean
@[simp] theorem mem_centeredLowerLiminfDeviationSet_iff
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    {c : ℝ} {ω : Ω} :
    ω ∈ centeredLowerLiminfDeviationSet T X c ↔
      liminf (fun n ↦ normalizedCenteredProcess T X n ω) atTop < c
```

Provides the definitional membership interface.

### 15. `IsIntegrableSubadditiveProcessCandidate.normalizedCenteredProcess_nonpos`

```lean
theorem normalizedCenteredProcess_nonpos
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (n : ℕ) (ω : Ω) : normalizedCenteredProcess T X n ω ≤ 0
```

Turns centered candidate subadditivity into the pointwise upper ceiling used
by the reverse event bridge.

### 16. `IsIntegrableSubadditiveProcessCandidate.mem_centeredStrictLowerDeviationSet_of_liminf_normalizedCenteredProcess_lt`

```lean
theorem mem_centeredStrictLowerDeviationSet_of_liminf_normalizedCenteredProcess_lt
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    {c : ℝ} {ω : Ω}
    (hlim : liminf (fun n ↦ normalizedCenteredProcess T X n ω) atTop < c) :
    ω ∈ centeredStrictLowerDeviationSet T X c
```

Chooses a rational between the real lower limit and the target, using the
pointwise upper ceiling as Mathlib's coboundedness gate.

### 17. `IsIntegrableSubadditiveProcessCandidate.mem_centeredStrictLowerDeviationSet_iff_liminf_normalizedCenteredProcess_lt`

```lean
theorem mem_centeredStrictLowerDeviationSet_iff_liminf_normalizedCenteredProcess_lt
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    {c : ℝ} {ω : Ω}
    (hlower : IsBoundedUnder (· ≥ ·) atTop
      (fun n ↦ normalizedCenteredProcess T X n ω)) :
    ω ∈ centeredStrictLowerDeviationSet T X c ↔
      liminf (fun n ↦ normalizedCenteredProcess T X n ω) atTop < c
```

Packages the two directions as the honest guarded equivalence.

### 18. `IsIntegrableSubadditiveProcessCandidate.centeredLowerLiminfDeviationSet_subset_rationalExhaustion`

```lean
theorem centeredLowerLiminfDeviationSet_subset_rationalExhaustion
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X) (δ : ℝ) :
    centeredLowerLiminfDeviationSet T X δ ⊆
      centeredRationalLowerDeviationExhaustionSet T X δ
```

Chooses the outer rational cut and delegates the inner cut to declaration 16.

### 19. `IsIntegrableSubadditiveProcessCandidate.measure_centeredRationalLowerDeviationExhaustionSet_eq_zero`

```lean
theorem measure_centeredRationalLowerDeviationExhaustionSet_eq_zero
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (δ : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ)) :
    μ (centeredRationalLowerDeviationExhaustionSet T X δ) = 0
```

Uses `measure_iUnion_null` and invokes RMT-32 at each subtype index
\(c\lt\delta\).

### 20. `IsIntegrableSubadditiveProcessCandidate.measure_centeredLowerLiminfDeviationSet_eq_zero`

```lean
theorem measure_centeredLowerLiminfDeviationSet_eq_zero
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (δ : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ)) :
    μ (centeredLowerLiminfDeviationSet T X δ) = 0
```

Combines declaration 18 with declaration 19 by `measure_mono_null`.

### 21. `IsIntegrableSubadditiveProcessCandidate.ae_isBoundedUnder_ge_and_le_liminf_normalizedCenteredProcess`

```lean
theorem ae_isBoundedUnder_ge_and_le_liminf_normalizedCenteredProcess
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (δ : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ)) :
    ∀ᵐ ω ∂μ,
      IsBoundedUnder (· ≥ ·) atTop
          (fun n ↦ normalizedCenteredProcess T X n ω) ∧
        δ ≤ liminf
          (fun n ↦ normalizedCenteredProcess T X n ω) atTop
```

Returns the actual eventual lower bound and the real lower-liminf inequality
together.

### 22. `IsIntegrableSubadditiveProcessCandidate.ae_add_oneStepIntegral_le_liminf_normalized`

```lean
theorem ae_add_oneStepIntegral_le_liminf_normalized
    [IsProbabilityMeasure μ]
    (hX : IsIntegrableSubadditiveProcessCandidate T μ X)
    (hT : Ergodic T μ) (δ : ℝ)
    (hδ : ∀ n : ℕ, n ≠ 0 →
      δ ≤ (∫ ω, centeredProcess T X n ω ∂μ) / (n : ℝ)) :
    ∀ᵐ ω ∂μ,
      δ + ∫ x, X 1 x ∂μ ≤
        liminf (fun n ↦ normalizedProcess X n ω) atTop
```

Adds the convergent one-step Birkhoff average and transports the centered
lower bound to the original process.

### 23. `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_integratedLogPlusGrowthRate_le_liminf_normalized`

```lean
theorem HasIntegrableGeneratorLogPlus.ae_integratedLogPlusGrowthRate_le_liminf_normalized
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (hT : PreErgodic C.base μ) :
    ∀ᵐ ω ∂μ,
      C.integratedLogPlusGrowthRate hC ≤
        liminf
          (fun n ↦ normalizedProcess C.logPlusNormObservable n ω) atTop
```

Specializes declaration 22 at the centered Fekete offset and cancels the
one-step integral.

### 24. `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedLogPlusNormObservable`

```lean
theorem HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedLogPlusNormObservable
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (hT : PreErgodic C.base μ) :
    ∀ᵐ ω ∂μ,
      Tendsto
        (fun n ↦ normalizedProcess C.logPlusNormObservable n ω) atTop
        (𝓝 (C.integratedLogPlusGrowthRate hC))
```

Intersects the lower endpoint, RMT-29's upper endpoint, and Birkhoff
convergence, then discharges the two boundedness gates for the final squeeze.

## Complete local proof-step ledger

| Source declaration | Local proof step, in execution order | Mathematical job |
|---|---|---|
| `normalizedProcess_zero` | Simplify total real division at zero | Establishes the boundary convention |
| `normalizedProcess_update_zero` | Extensionality in time and sample point | Reduces function equality to values |
| `normalizedProcess_update_zero` | Split on whether the horizon is zero | Uses totality at zero and ordinary update behavior elsewhere |
| `liminf_normalizedProcess_succ` | Apply `liminf_nat_add` with shift one | Removes the finite zero-time prefix |
| Exact centering identity | Reuse `normalized_eq_centered_add_birkhoffAverage` | Avoids reproving the pointwise algebra |
| Fixed-slope event bridge, forward | Unfold membership and `frequently_atTop` | Turns every cutoff into a filter witness |
| Fixed-slope event bridge, forward | Divide by the positive witness length | Converts \(Y_n\lt qn\) into \(Y_n/n\lt q\) |
| Fixed-slope event bridge, reverse | Query frequency at `max N 1` | Recovers both the requested cutoff and positive time |
| Fixed-slope event bridge, reverse | Multiply by the positive witness length | Reconstructs the original bad-block inequality |
| Rational event bridge | Rewrite both event membership interfaces | Exposes one rational frequent-crossing witness |
| Event to lower limit | Weaken frequent strict inequalities to weak ones | Matches `liminf_le_of_frequently_le` |
| Event to lower limit | Spend the explicit eventual lower bound | Gives a meaningful real lower-limit comparison |
| Candidate ceiling | Split the horizon into zero and successor | Handles total division at zero separately |
| Candidate ceiling | Divide centered nonpositivity by a nonnegative cast | Proves every normalized centered value is nonpositive |
| Lower limit to event | Choose a rational between the lower limit and target | Produces a fixed strict margin |
| Lower limit to event | Convert the pointwise zero ceiling into coboundedness | Discharges `frequently_lt_of_liminf_lt` |
| Guarded equivalence | Compose the preceding two directions | Keeps the lower-bound premise at the interface |
| Outer exhaustion membership | Simplify subtype-indexed union membership | Exposes one rational target below \(\delta\) |
| Strict lower-limit cover | Choose an outer rational between lower limit and \(\delta\) | Avoids the invalid endpoint substitution |
| Strict lower-limit cover | Invoke lower-limit-to-event at that rational | Internally chooses the second rational cut |
| Exhaustion nullity | Rewrite the outer union | Makes countable nullity directly applicable |
| Exhaustion nullity | Apply `measure_iUnion_null` | Reuses RMT-32 separately at each strict rational target |
| Lower-limit event nullity | Apply `measure_mono_null` | Transfers nullity along the proved subset |
| Eventual lower bound helper | Rewrite cover nullity as almost-everywhere nonmembership | Moves from measure zero to pointwise work |
| Eventual lower bound helper | Choose rationals \(q\lt c\lt\delta\) | Fixes a candidate lower bound and an enclosing event target |
| Eventual lower bound helper | Rule out frequent crossing of \(q\) | Otherwise the point would belong to \(D_c\) and the cover |
| Eventual lower bound helper | Apply `not_frequently` | Converts failure of frequent strict crossing into eventual weak lower bound |
| Centered pair theorem | Intersect the helper with complement of the lower-limit event | Returns boundedness and the numerical lower bound together |
| Add-back theorem | Intersect the centered pair with ergodic Birkhoff convergence | Places all pointwise hypotheses at one sample point |
| Add-back theorem | Name centered and Birkhoff sequences \(u\) and \(v\) | Makes the lower-limit algebra readable |
| Add-back theorem | Obtain centered upper boundedness from \(u_n\le0\) | Supplies the second centered gate |
| Add-back theorem | Obtain Birkhoff lower and upper gates from convergence | Supplies both additive-sequence gates |
| Add-back theorem | Apply `le_liminf_add` | Passes the lower bounds through addition |
| Add-back theorem | Rewrite the Birkhoff lower limit by convergence | Identifies its contribution with the one-step integral |
| Add-back theorem | Apply `liminf_congr` to the exact identity | Identifies \(u+v\) with the original normalized process |
| Cocycle lower endpoint | Build `Ergodic` from bundled preservation and `PreErgodic` | Matches the generic theorem's base interface |
| Cocycle lower endpoint | Choose the centered Fekete offset as \(\delta\) | Imports the finite-horizon integral lower bound |
| Cocycle lower endpoint | Simplify by `sub_add_cancel` | Recovers the integrated log-positive growth rate |
| Final convergence | Intersect lower liminf, upper limsup, and Birkhoff results | Aligns the three almost-everywhere inputs |
| Final convergence | Use log-positive nonnegativity | Gives an eventual lower bound for the normalized observable |
| Final convergence | Divide the one-step Birkhoff majorant at positive horizons | Produces an eventual pointwise upper comparison |
| Final convergence | Transfer boundedness from the convergent Birkhoff average | Gives an eventual upper bound for the normalized observable |
| Final convergence | Apply `tendsto_of_le_liminf_of_limsup_le` | Closes the real convergence squeeze |

## Private support surface in exact source order

Private declarations are not part of the importable API, but they are part of
the audited proof artifact. There are eleven, in this order.

| Private number | Exact name | Role |
|---:|---|---|
| 1 | `IsIntegrableSubadditiveProcessCandidate.ae_isBoundedUnder_ge_normalizedCenteredProcess` | Extracts an almost-everywhere eventual lower bound off the rational exhaustion |
| 2 | `rmt33ZeroProcess` | Supplies the zero-process boundary probe |
| 3 | `rmt33ApproachZeroFromBelow` | Defines the sequence \(-1/n\) with total value zero at time zero |
| 4 | `rmt33ApproachZeroFromBelow_tendsto` | Proves convergence of that probe to zero |
| 5 | `rmt33ApproachZeroFromBelow_frequently_neg` | Proves strict negative crossing remains frequent |
| 6 | `rmt33ApproachZeroFromBelow_not_frequently_below` | Rules out every fixed rational margin below zero |
| 7 | `rmt33QuadraticEscapeProcess` | Defines the unbounded-below process \(X_n=-n^2\) |
| 8 | `rmt33QuadraticEscapeProcess_candidate` | Proves integrability and shifted subadditivity on a Dirac base |
| 9 | `rmt33QuadraticEscape_centered` | Computes the centered process as \(-n^2+n\) |
| 10 | `rmt33QuadraticEscape_mem` | Proves membership in the strict event at target \(-1\) |
| 11 | `rmt33QuadraticEscape_liminf` | Computes Mathlib's totalized real lower limit as zero |

The first helper is logically central. It is private because the public pair
theorem is the safer endpoint: callers receive the boundedness certificate
and the lower-limit inequality together. The remaining ten declarations make
the boundary audits compact and reproducible without widening the production
API.

## Five checked boundary examples in exact source order

| Example | Checked statement | What it protects |
|---:|---|---|
| 1 | The zero process has normalized centered lower limit zero and empty strict lower-liminf deviation set at target zero | Equality boundary and empty bad set |
| 2 | Arbitrary replacement of the time-zero process slice leaves normalized `liminf` unchanged | Total-division boundary |
| 3 | The sequence \(-1/n\) has lower limit zero and is frequently negative, but crosses no fixed rational threshold below zero frequently | Strict target versus fixed strict margin |
| 4 | The quadratic Dirac process is a genuine candidate, belongs to \(D_{-1}\), has no eventual lower bound, and has formal real `liminf` zero | Necessity of the lower-bound guard |
| 5 | The final cocycle convergence theorem specializes to `ι := Empty` | Empty matrix-index boundary |

The third and fourth examples diagnose different possible overstatements. The
approach-to-zero example shows why frequent crossing of the target itself is
weaker than a rationally exhausted strict event. The quadratic example shows
why even genuine rational event membership does not control a totalized real
lower limit without eventual lower boundedness.

## Exact complete source-order map

This linear map interleaves public declarations, private support, anonymous
examples, and the final axiom reports exactly as they occur in the 627-line
module.

| Source item | Kind | Exact source name or checked role |
|---:|---|---|
| 1 | Public | `normalizedProcess` |
| 2 | Public | `normalizedProcess_zero` |
| 3 | Public | `normalizedProcess_update_zero` |
| 4 | Public | `normalizedCenteredProcess` |
| 5 | Public | `normalizedCenteredProcess_zero` |
| 6 | Public | `liminf_normalizedProcess_succ` |
| 7 | Public | `normalized_eq_normalizedCenteredProcess_add_birkhoffAverage` |
| 8 | Public | `mem_centeredArbitrarilyLateBadBlockSet_iff_frequently_normalized_lt` |
| 9 | Public | `mem_centeredStrictLowerDeviationSet_iff_exists_frequently_normalized_lt` |
| 10 | Public | `liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet` |
| 11 | Public | `centeredRationalLowerDeviationExhaustionSet` |
| 12 | Public | `mem_centeredRationalLowerDeviationExhaustionSet_iff` |
| 13 | Public | `centeredLowerLiminfDeviationSet` |
| 14 | Public | `mem_centeredLowerLiminfDeviationSet_iff` |
| 15 | Public | `IsIntegrableSubadditiveProcessCandidate.normalizedCenteredProcess_nonpos` |
| 16 | Public | `IsIntegrableSubadditiveProcessCandidate.mem_centeredStrictLowerDeviationSet_of_liminf_normalizedCenteredProcess_lt` |
| 17 | Public | `IsIntegrableSubadditiveProcessCandidate.mem_centeredStrictLowerDeviationSet_iff_liminf_normalizedCenteredProcess_lt` |
| 18 | Public | `IsIntegrableSubadditiveProcessCandidate.centeredLowerLiminfDeviationSet_subset_rationalExhaustion` |
| 19 | Public | `IsIntegrableSubadditiveProcessCandidate.measure_centeredRationalLowerDeviationExhaustionSet_eq_zero` |
| 20 | Public | `IsIntegrableSubadditiveProcessCandidate.measure_centeredLowerLiminfDeviationSet_eq_zero` |
| 21 | Private | `IsIntegrableSubadditiveProcessCandidate.ae_isBoundedUnder_ge_normalizedCenteredProcess` |
| 22 | Public | `IsIntegrableSubadditiveProcessCandidate.ae_isBoundedUnder_ge_and_le_liminf_normalizedCenteredProcess` |
| 23 | Public | `IsIntegrableSubadditiveProcessCandidate.ae_add_oneStepIntegral_le_liminf_normalized` |
| 24 | Public | `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_integratedLogPlusGrowthRate_le_liminf_normalized` |
| 25 | Public | `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedLogPlusNormObservable` |
| 26 | Private | `rmt33ZeroProcess` |
| 27 | Example | Zero process lower limit and empty deviation set |
| 28 | Example | Time-zero update leaves normalized lower limit unchanged |
| 29 | Private | `rmt33ApproachZeroFromBelow` |
| 30 | Private | `rmt33ApproachZeroFromBelow_tendsto` |
| 31 | Private | `rmt33ApproachZeroFromBelow_frequently_neg` |
| 32 | Private | `rmt33ApproachZeroFromBelow_not_frequently_below` |
| 33 | Example | Approach-zero strict crossing without a fixed rational margin |
| 34 | Private | `rmt33QuadraticEscapeProcess` |
| 35 | Private | `rmt33QuadraticEscapeProcess_candidate` |
| 36 | Private | `rmt33QuadraticEscape_centered` |
| 37 | Private | `rmt33QuadraticEscape_mem` |
| 38 | Private | `rmt33QuadraticEscape_liminf` |
| 39 | Example | Quadratic candidate demonstrating the lower-bound guard |
| 40 | Example | Empty-index specialization of final convergence |
| 41 | Axiom print | `normalizedProcess_update_zero` |
| 42 | Axiom print | `liminf_normalizedProcess_succ` |
| 43 | Axiom print | `mem_centeredArbitrarilyLateBadBlockSet_iff_frequently_normalized_lt` |
| 44 | Axiom print | `liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet` |
| 45 | Axiom print | `IsIntegrableSubadditiveProcessCandidate.mem_centeredStrictLowerDeviationSet_of_liminf_normalizedCenteredProcess_lt` |
| 46 | Axiom print | `IsIntegrableSubadditiveProcessCandidate.centeredLowerLiminfDeviationSet_subset_rationalExhaustion` |
| 47 | Axiom print | `IsIntegrableSubadditiveProcessCandidate.measure_centeredLowerLiminfDeviationSet_eq_zero` |
| 48 | Axiom print | `IsIntegrableSubadditiveProcessCandidate.ae_isBoundedUnder_ge_and_le_liminf_normalizedCenteredProcess` |
| 49 | Axiom print | `IsIntegrableSubadditiveProcessCandidate.ae_add_oneStepIntegral_le_liminf_normalized` |
| 50 | Axiom print | `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_integratedLogPlusGrowthRate_le_liminf_normalized` |
| 51 | Axiom print | `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedLogPlusNormObservable` |

The source map counts twenty-four public declarations, eleven private support
items, five anonymous examples, and eleven axiom reports.

## Lean engineering notes

### `IsBoundedUnder` and `IsCoboundedUnder` are not cosmetic dual names

With relation `(· ≥ ·)`, `IsBoundedUnder` supplies a real value that is
eventually below the sequence. That is the lower-bound gate needed by
`liminf_le_of_frequently_le`. With the same written relation,
`IsCoboundedUnder` expresses the upper-side conditional-completeness gate used
by `frequently_lt_of_liminf_lt`. The candidate's pointwise estimate
\(u_n\le0\) produces the latter, not the former.

### Negating frequency is the constructive lower-bound move

Once \(q\) is fixed, Lean can transform

```lean
¬ ∃ᶠ n in atTop, u n < q
```

into an eventual statement by `not_frequently.mp`. A monotonicity step turns
the resulting pointwise negation into `q ≤ u n`. Packaging that witness gives
`IsBoundedUnder (· ≥ ·) atTop u`. This is stronger and more reusable than a
bare proof that the real lower limit happens not to be below \(\delta\).

### The outer union uses a subtype index

The definition indexes over

```lean
{c : ℚ // (c : ℝ) < δ}
```

rather than over all rationals plus an empty branch. Each index therefore
carries the strict hypothesis needed by RMT-32. `measure_iUnion_null` receives
that proof as `c.property`, and no endpoint case is generated.

### `liminf_congr` separates asymptotic identity from syntactic identity

The normalized centered-plus-Birkhoff identity is pointwise at every natural
time, but the sum is introduced through local abbreviations. `liminf_congr`
lets the proof identify the functions eventually, avoiding fragile unfolding
of both abstractions inside a large `calc` chain.

### `PreErgodic` is the unbundled logical half needed at the cocycle boundary

The generic process theorem asks for `Ergodic T μ`, which packages
measure preservation and pre-ergodicity. A `DiscreteMatrixCocycle` already
stores preservation of its base map. The public cocycle theorem therefore
asks only for `PreErgodic C.base μ` and builds the combined structure locally.

## Axiom audit

The module ends with eleven `#print axioms` commands. A warning-fatal direct
check of the final source reports the same standard Mathlib trio for every
printed theorem:

```text
[propext, Classical.choice, Quot.sound]
```

The eleven printed declarations, in source order, are:

1. `normalizedProcess_update_zero`
2. `liminf_normalizedProcess_succ`
3. `mem_centeredArbitrarilyLateBadBlockSet_iff_frequently_normalized_lt`
4. `liminf_normalizedCenteredProcess_lt_of_mem_centeredStrictLowerDeviationSet`
5. `IsIntegrableSubadditiveProcessCandidate.mem_centeredStrictLowerDeviationSet_of_liminf_normalizedCenteredProcess_lt`
6. `IsIntegrableSubadditiveProcessCandidate.centeredLowerLiminfDeviationSet_subset_rationalExhaustion`
7. `IsIntegrableSubadditiveProcessCandidate.measure_centeredLowerLiminfDeviationSet_eq_zero`
8. `IsIntegrableSubadditiveProcessCandidate.ae_isBoundedUnder_ge_and_le_liminf_normalizedCenteredProcess`
9. `IsIntegrableSubadditiveProcessCandidate.ae_add_oneStepIntegral_le_liminf_normalized`
10. `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_integratedLogPlusGrowthRate_le_liminf_normalized`
11. `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.ae_tendsto_normalizedLogPlusNormObservable`

This report rules out hidden `sorry` declarations in the printed dependency
closures. It does not replace review of whether the formal definitions match
the intended mathematics.

## Reproduce the Lean and teaching artifacts

From the repository root, load the pinned Elan environment and check the leaf
module with warnings treated as errors:

```sh
cd formalization
. "$HOME/.elan/env"
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/SubadditiveKingman.lean
```

Build the whole formalization:

```sh
cd formalization
. "$HOME/.elan/env"
lake build
```

Regenerate and verify the deterministic social card from any working
directory:

```sh
site/content/development-notebook/2026/07/\
log-positive-kingman-convergence-from-rational-lower-deviations-in-lean/\
generate-card.sh

site/content/development-notebook/2026/07/\
log-positive-kingman-convergence-from-rational-lower-deviations-in-lean/\
generate-card.sh --verify

magick identify -format '%wx%h\n' \
  site/content/development-notebook/2026/07/\
log-positive-kingman-convergence-from-rational-lower-deviations-in-lean/\
log-positive-kingman-convergence-from-rational-lower-deviations-in-lean-card.png
```

The expected dimensions are `1200x630`. Validate the generator and all eight
conceptual SVGs when the optional tools are installed:

```sh
shellcheck \
  site/content/development-notebook/2026/07/\
log-positive-kingman-convergence-from-rational-lower-deviations-in-lean/\
generate-card.sh

xmllint --noout \
  site/content/development-notebook/2026/07/\
log-positive-kingman-convergence-from-rational-lower-deviations-in-lean/*.svg
```

Run the teaching-source gate and render every draft page in memory:

```sh
python3 scripts/check_teaching_source_hygiene.py
hugo --source site --config hugo.yaml --buildDrafts \
  --panicOnWarning --noBuildLock --renderToMemory
```

The repository-wide content-coverage check is intentionally separate from
this bundle. Its manifest is updated with the coherent milestone integration,
not by this isolated page artifact.

## Exercises with worked solutions

### Exercise 1: evaluate the total zero-time normalization

Why does `normalizedProcess X 0 ω` not depend on `X 0 ω`?

**Solution.** The definition is `X 0 ω / (0 : ℝ)`. Division in a field is
total, with division by zero reducing to multiplication by the inverse of
zero. Since that inverse is zero, the quotient simplifies to zero for every
numerator. This is a formal convention, not a claim that a time-zero growth
rate is analytically meaningful.

### Exercise 2: prove update insensitivity without filter theory

Sketch the two cases needed to prove that updating `X` at time zero leaves
`normalizedProcess X` unchanged as a function.

**Solution.** Apply function extensionality to a horizon \(n\) and point
\(\omega\). If \(n=0\), both normalized values simplify to zero. If \(n\ne0\),
`Function.update` returns the original slice, and both quotients are
definitionally the same. No asymptotic theorem is needed because the result is
pointwise at every horizon.

### Exercise 3: distinguish update insensitivity from prefix invariance

Why is declaration 6 still useful after declaration 3?

**Solution.** Declaration 3 concerns only a replacement at index zero and is
an equality of total normalized functions. Declaration 6 says that shifting
the entire sequence by one index leaves its lower limit unchanged. The latter
is a filter fact and would also ignore any other finite prefix after an
appropriate natural shift.

### Exercise 4: translate one bad-block witness

Assume \(n\gt0\) and \(Y_n(\omega)\lt qn\). Derive the normalized inequality
used by the frequent-crossing event.

**Solution.** The cast \((n:\mathbb R)\) is positive. Divide both sides by that
positive number, which preserves strict order, to obtain
\(Y_n(\omega)/n\lt q\). In Lean the relevant equivalence is `div_lt_iff₀`, and
the positivity proof is `Nat.cast_pos.mpr hn`.

### Exercise 5: recover positivity from frequency

Why does the reverse event bridge query a frequent predicate at `max N 1`
instead of at \(N\)?

**Solution.** A witness beyond `max N 1` is automatically beyond the caller's
cutoff \(N\) and at least one. The first fact reconstructs the
beyond-every-cutoff quantifier, while the second makes division or
multiplication by the cast horizon order-safe. Querying only at \(N\) would
leave the case \(N=0,n=0\) unresolved.

### Exercise 6: compare strict target crossing with a fixed margin

For \(a_n=-1/n\), explain why \(a_n\lt0\) frequently but no fixed rational
\(q\lt0\) satisfies \(a_n\lt q\) frequently.

**Solution.** Every positive-time value is negative, so strict crossing of
zero occurs beyond every cutoff. But \(a_n\to0\). For fixed \(q\lt0\), the
tail eventually lies strictly above \(q\), which makes \(a_n\lt q\) eventually
false and therefore not frequent. This is why \(D_0\) encodes a fixed strict
margin rather than raw frequent crossing of the target.

### Exercise 7: identify the event-to-liminf gate

Which hypothesis permits `liminf_le_of_frequently_le` to turn frequent weak
crossing of \(q\) into \(\liminf u_n\le q\)?

**Solution.** It needs `IsBoundedUnder (· ≥ ·) atTop u`, an eventual real
lower bound for the sequence. This ensures the set of eventual lower bounds
is nonempty in the conditionally complete real order. Event membership alone
supplies frequent upper comparisons, not this lower boundedness.

### Exercise 8: identify the lower-limit-to-event gate

Why is the candidate estimate \(u_n\le0\) useful in the reverse direction?

**Solution.** `frequently_lt_of_liminf_lt` needs a coboundedness condition on
the relevant real family. The pointwise ceiling zero supplies it uniformly.
After choosing rational \(q\) with \(\liminf u_n\lt q\lt c\), the theorem
produces frequent \(u_n\lt q\), exactly the witness required for \(D_c\).

### Exercise 9: reject an unconditional equivalence

State the smallest visible change that would make the guarded equivalence
mathematically false in this module's real-valued semantics.

**Solution.** Remove the `hlower : IsBoundedUnder (· ≥ ·) atTop u` premise.
The quadratic boundary process then belongs to \(D_{-1}\) but has formal real
lower limit zero, so the implication from membership to a lower limit below
\(-1\) fails. Candidate subadditivity does not repair this because it gives an
upper bound, not a lower bound.

### Exercise 10: choose the outer rational cut

Given \(L\lt\delta\), what strict inequalities must the outer rational \(c\)
satisfy, and what job does each side perform?

**Solution.** Choose \(L\lt c\lt\delta\). The left inequality lets the
lower-limit-to-event theorem place the point in \(D_c\). The right inequality
meets RMT-32's strict threshold hypothesis and makes \(D_c\) one of the null
events in the outer exhaustion.

### Exercise 11: locate the inner rational cut

Where does the second rational \(q\) appear after the outer target \(c\) has
already been chosen?

**Solution.** It appears inside
`mem_centeredStrictLowerDeviationSet_of_liminf_normalizedCenteredProcess_lt`.
That theorem chooses \(q\) with \(L\lt q\lt c\) and proves frequent crossing
of \(q\). Thus \(c\) indexes the countable cover, while \(q\) witnesses
membership in its selected event.

### Exercise 12: audit countability

Why is the subtype `{c : ℚ // (c : ℝ) < δ}` preferable to an outer union over
all real numbers below \(\delta\)?

**Solution.** The subtype is countable because the rationals are countable,
so `measure_iUnion_null` applies directly. Rational density loses no strict
gap: every lower limit strictly below \(\delta\) admits an intermediate
rational target. A union over reals would not provide the same countable
measure interface.

### Exercise 13: transfer nullity through a subset

Which two facts suffice to prove that the strict lower-liminf deviation set is
null?

**Solution.** First prove it is a subset of the rational exhaustion. Then
prove the exhaustion has measure zero by a countable union of RMT-32 null
events. `measure_mono_null` transfers the zero measure to the subset without
requiring an independent measurability proof for the lower-liminf set.

### Exercise 14: compute the quadratic centered process

For \(X_n=-n^2\) and one-step observable \(X_1=-1\), compute
\(Y_n=X_n-S_n(X_1)\).

**Solution.** On the identity action over `Unit`, the Birkhoff sum of the
constant one-step value \(-1\) is \(-n\). Therefore
\(Y_n=-n^2-(-n)=-n^2+n\). At positive time the normalized value is
\(-n+1=-(n-1)\).

### Exercise 15: verify quadratic subadditivity

Reduce \(X_{m+n}\le X_m+X_n\) for \(X_n=-n^2\) to a nonnegative product.

**Solution.** Expanding gives
\(-(m+n)^2\le-m^2-n^2\), equivalent to \(2mn\ge0\). Natural-number casts are
nonnegative, so their product is nonnegative. The Lean proof records the cast
facts and lets `nlinarith` close the polynomial inequality.

### Exercise 16: explain the formal quadratic lower limit

Why does Mathlib's real `liminf` evaluate to zero for the positive-time
sequence \(-n\)?

**Solution.** The real `liminf` is expressed as the supremum of real eventual
lower bounds. No real \(a\) is eventually below every \(-n\), so that set is
empty. Mathlib totalizes the supremum of the empty real set as
`Real.sSup_empty = 0`, producing zero despite negative escape.

### Exercise 17: avoid an extended-real misreading

What would be wrong with reporting the previous result as saying that the
ordinary asymptotic lower limit of \(-n\) is zero?

**Solution.** In the extended reals the sequence tends to negative infinity,
so its extended lower limit is negative infinity. The value zero belongs only
to the totalized real operation outside its conditional-completeness regime.
The boundary example documents API semantics, not a new analytic convention.

### Exercise 18: construct an eventual lower bound off the cover

Suppose \(\omega\notin D_c\) and \(q\lt c\). Show why \(q\le u_n(\omega)\)
eventually.

**Solution.** If \(u_n(\omega)\lt q\) were frequent, the rational witness \(q\)
would put \(\omega\) in \(D_c\), contradicting the premise. Therefore the
strict inequality is not frequent. The filter identity for negated frequency
gives eventual failure of that inequality, equivalent over reals to eventual
\(q\le u_n(\omega)\).

### Exercise 19: distinguish a witness from its enclosing target

Could the helper choose only one rational below \(\delta\) and use it both as
the fixed lower bound and as the target of the same strict event?

**Solution.** No. Membership in \(D_c\) requires a rational witness strictly
below \(c\). To infer a contradiction from frequent crossing at \(q\), the
helper needs \(q\lt c\). A second inequality \(c\lt\delta\) places that event
inside the null exhaustion. The two values encode the strict slack explicitly.

### Exercise 20: justify returning a pair

Why does the public centered endpoint return boundedness together with
\(\delta\le\liminf u_n\)?

**Solution.** The numerical inequality alone could be misread as an
extended-real conclusion even where Mathlib's real `liminf` is totalized.
Returning `IsBoundedUnder` certifies that an eventual real lower bound exists
at the same sample point. The pair is also exactly what the later addition
theorem needs.

### Exercise 21: obtain the centered upper gate

Which bound supplies `IsBoundedUnder (· ≤ ·) atTop u` in the add-back proof?

**Solution.** Declaration 15 gives \(u_n\le0\) for every natural \(n\). The
constant zero is therefore a global upper bound, hence an eventual upper
bound. This is independent of the almost-everywhere lower bound extracted
from the rational cover.

### Exercise 22: obtain both Birkhoff gates

Why does convergence of \(v_n\) supply the lower and upper boundedness data
required by `le_liminf_add`?

**Solution.** Every convergent real sequence is eventually bounded below and
above. Mathlib exposes these as properties of the `Tendsto` proof. The
add-back theorem uses the lower property directly and converts the upper
property into the coboundedness form expected by the lower-limit addition
API.

### Exercise 23: read the direction of `le_liminf_add`

Why is
\(\liminf u+\liminf v\le\liminf(u+v)\) the direction needed here?

**Solution.** The centered theorem gives a lower bound on \(\liminf u\), and
Birkhoff convergence identifies \(\liminf v\). Adding these known lower
bounds gives a lower bound on their sum. The displayed theorem then transfers
that quantity below the lower limit of the original normalized process.

### Exercise 24: separate pointwise and lower-limit equality

What does `liminf_congr` contribute after the exact centering identity is
already known?

**Solution.** The proof has locally named functions \(u\) and \(v\), while the
goal names `normalizedProcess X`. `liminf_congr` accepts eventual pointwise
equality between those function expressions. The exact identity proves that
eventual equality at every index without forcing broad definitional unfolding.

### Exercise 25: cancel the cocycle offset

Show algebraically why the generic lower endpoint becomes the integrated
log-positive growth rate.

**Solution.** Substitute
\(\delta=g-I_1\), where \(g\) is the integrated growth rate and \(I_1\) is the
one-step integrated log-positive norm. The generic left side is
\((g-I_1)+I_1=g\). Lean closes this with `sub_add_cancel` after unfolding the
one-step integral notation.

### Exercise 26: assemble cocycle ergodicity

Why does the cocycle-facing theorem ask for `PreErgodic` rather than the full
`Ergodic` structure?

**Solution.** The cocycle structure already bundles that its base map
preserves \(\mu\). `PreErgodic` supplies the remaining invariant-set rigidity.
The proof constructs `⟨C.base_preserving, hT⟩`, avoiding a duplicated
preservation assumption at the public endpoint.

### Exercise 27: produce the final lower boundedness gate

Why is the normalized log-positive observable bounded below even at time
zero?

**Solution.** The numerator `logPlusNormObservable` is nonnegative, and every
natural cast denominator is nonnegative. Real division of two nonnegative
values is nonnegative. At zero, total division produces zero, so the same
pointwise lower bound holds uniformly across all horizons.

### Exercise 28: produce the final upper boundedness gate

How does the one-step Birkhoff majorant lead to eventual upper boundedness of
the normalized cocycle observable?

**Solution.** At every positive horizon, divide the finite-horizon majorant by
the positive cast horizon to compare the normalized observable with the
one-step Birkhoff average. The comparison is eventual because horizons are
eventually at least one. The Birkhoff average converges, hence is eventually
bounded above, and boundedness transfers through the eventual comparison.

### Exercise 29: state the four final squeeze inputs

List the hypotheses consumed by `tendsto_of_le_liminf_of_limsup_le` in the
final theorem.

**Solution.** The integrated rate is below the real lower limit; the real
upper limit is below the same integrated rate; the sequence is eventually
bounded above; and it is eventually bounded below. The first two identify a
single candidate limit. The latter two ensure the totalized real lower and
upper limits are operating in their intended conditionally complete regime.

### Exercise 30: audit the empty-index boundary

Which part of the final statement excludes `ι := Empty`?

**Solution.** None. The index type needs `Fintype` and `DecidableEq`, both of
which exist for `Empty`. The checked anonymous example instantiates the final
theorem directly. The endpoint therefore does not smuggle in a nonempty
matrix-dimension hypothesis.

### Exercise 31: reject a signed Lyapunov conclusion

Why does convergence of normalized `logPlusNormObservable` not by itself
produce a signed top Lyapunov exponent?

**Solution.** The positive part discards negative logarithmic behavior. A
signed theorem would need control of the negative tail, including possible
singularity or small norms, and often inverse-cocycle information. This module
proves convergence only for the nonnegative envelope named in its statement.

### Exercise 32: compare a possible extended-real redesign

What would an extended-real formulation change, and why is the present real
formulation still useful?

**Solution.** An extended-real lower limit could represent negative escape
directly and would alter the conditional-completeness bookkeeping. It would
also require new interfaces for integration, addition, and comparison with
the real Birkhoff term. The present formulation stays compatible with the
existing real-valued process library and remains honest by exporting the
eventual boundedness certificate whenever real lower-limit algebra is used.

## Discussion prompts

The following are research and design questions, not claims established by
RMT-33.

1. Would an `EReal` lower-deviation layer simplify future signed-process
   extensions, or merely move complexity into integration and addition?
2. Which negative-tail hypotheses are minimal for replacing `logPlus` by a
   signed logarithmic norm observable?
3. Can the generic process endpoint be strengthened to convergence without
   specializing to a pointwise nonnegative observable, and which explicit
   upper and lower boundedness witnesses would be needed?
4. Which additional uniform-integrability argument would be required before
   claiming \(L^1\) convergence or exchanging limit and integral?
5. How should a future multiplicative ergodic theorem layer distinguish a
   scalar top growth rate from a filtration or splitting theorem?

## Source-backed scope notes

Kingman is cited for the historical subadditive ergodic theorem, not as a
source for the exact Lean declarations or their totalized-real boundary
design. Steele is cited for a centering-oriented proof architecture, not for
the project's rational subtype exhaustion or its particular API split.
Birkhoff is cited for the additive ergodic theorem whose Mathlib
formalization supplies the convergent one-step average. The details of
`liminf`, conditional completeness, and the final squeeze are grounded in the
pinned Mathlib source rather than in an informal convention.

The primary artifact for every formal claim is the checked module at the
`lean_source` path in the front matter. The prose deliberately distinguishes
historical motivation, project-specific theorem design, and machine-checked
content.

## Navigation

- Companion textbook chapter:
  [The Guarded Real-Liminf Bridge to Log-Positive Kingman Convergence]({{< relref "/knowledge-base/deep-dives/guarded-real-liminf-bridge-to-log-positive-kingman-convergence" >}})
- Previous lower-event milestone:
  [Countably Generated Centered Lower-Deviation Events in Lean]({{< relref "/development-notebook/2026/07/countably-generated-centered-lower-deviation-events-in-lean" >}})
- Complementary upper endpoint:
  [Subadditive Upper Limsup from Phase Averaging in Lean]({{< relref "/development-notebook/2026/07/subadditive-upper-limsup-from-phase-averaging-in-lean" >}})
- Additive convergence input:
  [Identifying the Ergodic Birkhoff Constant in Lean]({{< relref "/development-notebook/2026/07/identifying-the-ergodic-birkhoff-constant-in-lean" >}})
- Integrated-rate construction:
  [Integrated Log-Positive Growth and a Deterministic Fekete Limit]({{< relref "/development-notebook/2026/07/integrated-log-positive-growth-and-deterministic-fekete-limit" >}})

## References

1. <a id="ref-rmt33-kingman"></a>J. F. C. Kingman,
   “The Ergodic Theory of Subadditive Stochastic Processes,” *Journal of the
   Royal Statistical Society: Series B* 30(3), 499-510 (1968).
   [Version of record](https://academic.oup.com/jrsssb/article/30/3/499/7026968).
   [DOI](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x).
2. <a id="ref-rmt33-steele"></a>J. Michael Steele,
   “Kingman's Subadditive Ergodic Theorem,” *Annales de l'I.H.P.
   Probabilités et statistiques* 25(1), 93-98 (1989).
   [Article record](https://www.numdam.org/item/AIHPB_1989__25_1_93_0/).
   [PDF](https://www.numdam.org/item/AIHPB_1989__25_1_93_0.pdf).
3. <a id="ref-rmt33-birkhoff"></a>George D. Birkhoff,
   “Proof of the Ergodic Theorem,” *Proceedings of the National Academy of
   Sciences* 17(12), 656-660 (1931).
   [DOI](https://doi.org/10.1073/pnas.17.2.656).
4. <a id="ref-rmt33-mathlib-order"></a>Mathlib contributors,
   `Mathlib/Order/LiminfLimsup.lean`, pinned project revision
   `81a5d257c8e410db227a6665ed08f64fea08e997`.
   [Pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/LiminfLimsup.lean).
5. <a id="ref-rmt33-mathlib-algebra"></a>Mathlib contributors,
   `Mathlib/Topology/Algebra/Order/LiminfLimsup.lean`, pinned project revision
   `81a5d257c8e410db227a6665ed08f64fea08e997`.
   [Pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/Algebra/Order/LiminfLimsup.lean).
6. <a id="ref-rmt33-mathlib-topology"></a>Mathlib contributors,
   `Mathlib/Topology/Order/LiminfLimsup.lean`, pinned project revision
   `81a5d257c8e410db227a6665ed08f64fea08e997`.
   [Pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/Order/LiminfLimsup.lean).
