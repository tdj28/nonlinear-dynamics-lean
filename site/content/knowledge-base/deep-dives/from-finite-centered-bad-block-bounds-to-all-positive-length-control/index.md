---
title: "From Finite Centered Bad-Block Bounds to All-Positive-Length Control"
slug: "from-finite-centered-bad-block-bounds-to-all-positive-length-control"
date: 2026-07-22
summary: "A textbook passage from uniformly controlled finite centered bad-block sets to the event with one bad witness at any positive length, with the extended-measure limit, finite-target real projection, cocycle specialization, and raw non-invariance all explicit."
lead: "A bound for every finite cap is not yet a bound for the union over all positive lengths. RMT-31 nests the caps, identifies one finite witness, takes continuity from below in extended measure, crosses to real measure only at a finite target, and transports the uniform RMT-30 ratio with le_of_tendsto'. The resulting raw event is still not an asymptotic deviation event and need not be invariant."
draft: true
pro_reviewed: false
level: "Subadditive processes, finite bad-block estimates, null measurable sets, extended nonnegative real measure, filter convergence, and intermediate Lean theorem reading"
reading_time: "170 to 250 minutes"
prerequisites: "Centered subadditive processes, the RMT-30 finite bad-block ratio, increasing unions, finite measures, and elementary real convergence; no Kingman theorem is assumed"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveAllLengthBadBlockMeasure"
toc: true
og_image: "from-finite-centered-bad-block-bounds-to-all-positive-length-control-card.png"
og_image_alt: "Warm-paper Deep Dive card showing nested finite centered bad-block caps becoming one all-positive-length union, extended measure continuity preceding a finite-target real projection, and the uniform finite ratio passing to the union. A warning states that the raw once-bad event need not be invariant and is not a lower-liminf event."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Its mathematical
claims and declaration names have been reconciled with the frozen RMT-31 Lean
module, but human publication review and the configured external Pro review
remain pending.
{{< /panel >}}

RMT-30 fixes a natural-number cap \(m\) and controls the points at which some
centered block of length at most \(m\) falls strictly below a line. RMT-31
removes the cap. Three operations must remain separate:

1. identify the all-length event exactly as a nested union;
2. take the limit in the native extended measure type; and
3. project to real measure only after ruling out an infinite target.

The last operation is where finite mass enters. It is not needed for the set
identity, null measurability, or extended-measure continuity. Once the real
limit is justified, the same upper bound that RMT-30 proves for every cap
passes to the union by closedness of an upper interval.

This is one measure-theoretic bridge inside Kingman's much stronger
subadditive ergodic theorem ([Kingman 1968](#ref-all-length-kingman)). The
finite interval-decomposition perspective is also visible in Steele's
exposition ([Steele 1989](#ref-all-length-steele)); neither source is claimed
to contain this repository's Lean interface.

This chapter is the textbook companion to the
[RMT-31 Development Notebook]({{< relref "/development-notebook/2026/07/all-positive-length-centered-bad-block-control-in-lean" >}}).
Its input comes from
[Finite Bad-Block Measure Bounds Before Kingman Lower Liminf]({{< relref "/knowledge-base/deep-dives/finite-bad-block-measure-bounds-before-kingman-lower-liminf" >}}).
Useful compact references are
{{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}},
{{< refterm "finite-orbit-visit-count" "finite orbit-visit count" >}}, and
{{< refterm "integrated-log-positive-growth-rate" "integrated log-positive growth rate" >}}.

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| Event | [Start with finite caps](#start-with-finite-caps) | Separate one witness from recurrent failure |
| Set | [Nest the caps](#nest-the-caps) | Prove the exact increasing union |
| Regularity | [Take the countable null-measurable union](#take-the-countable-null-measurable-union) | See why finite mass is absent |
| Measure | [Use extended measure first](#use-extended-measure-first) | Apply unconditional continuity from below |
| Projection | [Cross the real-projection cliff](#cross-the-real-projection-cliff) | Isolate local finiteness |
| Bound | [Transport the uniform RMT-30 ratio](#transport-the-uniform-rmt-30-ratio) | Preserve the ratio without loss |
| Cocycle | [Specialize to log-positive cocycles](#specialize-to-log-positive-cocycles) | Discharge the generic rate premise |
| Boundary | [The raw event need not be invariant](#the-raw-event-need-not-be-invariant) | Read the checked countermodel |
| Next layer | [Continue into the checked RMT-32 event](#rmt-32-now-supplies-the-event-layer) | Reach ergodic null selection without claiming a liminf bridge |
| Practice | [Thirty solved exercises](#thirty-solved-exercises) | Rebuild every bridge |

## Common setup and notation

Let \(\Omega\) be a type, \(\mu\) a measure, and
\(T:\Omega\to\Omega\) a map. An integrable shifted-subadditive candidate is a
family \(X_n:\Omega\to\mathbb R\) satisfying

\[
X_{a+b}(\omega)\le X_b(T^a\omega)+X_a(\omega).
\]

The repository centers it by subtracting the one-step orbit sum:

\[
Y_n(\omega)
{} :=
X_n(\omega)-\sum_{j=0}^{n-1}X_1(T^j\omega).
\]

This is pointwise {{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}},
not expectation centering. It gives \(Y_1=0\), preserves shifted
subadditivity, and makes \(Y_n\le0\) for positive \(n\). A block is bad at
\(\omega\) when \(Y_n(\omega)\lt cn\). Equality is not a witness.

## Start with finite caps

For \(m\in\mathbb N\), RMT-30 defines

\[
B_m(c)
{} :=
\bigcup_{1\le n\le m}\{\omega:Y_n(\omega)\lt cn\}.
\]

The cap-zero set is empty. At a positive cap, membership means at least one
allowed length works, not that every length works. RMT-31 defines

\[
B_\infty(c):=\bigcup_{m\in\mathbb N}B_m(c).
\]

The infinity symbol describes the search range. Every actual witness is
finite. The checked membership theorem is

\[
\omega\in B_\infty(c)
\quad\Longleftrightarrow\quad
\exists n\in\mathbb N,\quad 0\lt n\ \text{and}\ Y_n(\omega)\lt cn.
\]

This is a **once-bad** event. It does not mean failures occur infinitely
often, eventually, or along an unbounded sequence.

{{< reference-figure
  src="nested-finite-caps-and-one-finite-witness.svg"
  alt="Nested finite bad-block caps grow with the search window. A point whose first strict witness is at length three is absent from the first two caps, enters the third cap, remains in later caps, and belongs to the union because of one finite witness rather than infinitely many witnesses."
  caption="**Finding:** removing the cap preserves finite witness semantics. A point enters when one positive witness becomes available and remains in every larger search window. The nesting shows monotonicity of events in the cap, not monotonicity of the centered process in time. The witness length and shapes are conceptual, not measured data."
>}}

The compiled two-point process calibrates strictness. It has \(Y_1=0\) at
both points, while one point has \(Y_2=-1\). At slope \(c=0\), equality at
time one contributes nothing but time two is a strict witness. The all-length
event can therefore be nonempty when the cap-one event is empty.

## Nest the caps

If \(m\le M\), every witness with \(1\le n\le m\) also satisfies
\(1\le n\le M\). Thus \(B_m(c)\subseteq B_M(c)\). This is monotonicity of
the search window, not a claim that \(Y_m(\omega)\le Y_M(\omega)\).

The all-length definition is already the union, so
<code>centeredAllLengthBadBlockSet_eq_iUnion_finite</code> is proved by
<code>rfl</code>. The theorem
<code>finiteCenteredBadBlockSet_subset_allLength</code> packages inclusion of
any cap. Conversely, given an uncapped witness \(n\), choose cap \(m=n\). No
compactness, limiting witness, supremum, or infinite maximizing time is
involved.

## Take the countable null-measurable union

Assume \(X\) is an integrable shifted-subadditive candidate and \(T\)
preserves \(\mu\). RMT-30 proves every \(B_m(c)\) null measurable. RMT-31
uses Mathlib's [closure under countable null-measurable
unions](#ref-all-length-mathlib-null) to prove

\[
\operatorname{NullMeasurableSet}_\mu(B_\infty(c)).
\]

Integrability supplies almost-everywhere measurability; it need not make the
chosen representatives ordinarily measurable. The theorem does not claim an
ordinary <code>MeasurableSet</code> certificate. Finite total mass,
probability, and ergodicity are absent. Preservation transports integrability
through the dynamics; it does not make this raw union invariant.

## Use extended measure first

Lean measures take values in \(\mathbb R_{\ge0\infty}\). Since the caps
increase and their union is exact, continuity from below gives

\[
\mu(B_m(c))\longrightarrow\mu(B_\infty(c)).
\]

<code>tendsto_measure_finiteCenteredBadBlockSet</code> needs no measurability
of the events, integrability, subadditivity, preservation, finite mass,
probability, or ergodicity. Mathlib's
[<code>tendsto_measure_iUnion_atTop</code>](#ref-all-length-mathlib-continuity)
consumes only the increasing-set geometry and permits an infinite target.

{{< reference-figure
  src="continuity-first-in-extended-measure.svg"
  alt="An increasing sequence of finite bad-block caps feeds directly into continuity from below in extended nonnegative real measure. The limit is the measure of the union, whether finite or infinite, and no set-measurability, integrability, preservation, or finite-mass gate appears."
  caption="**Finding:** continuity from below belongs first in extended nonnegative real measure, where infinity remains a legitimate limit. The theorem consumes only nesting and the exact union. Separate regularity and dynamical hypotheses are useful elsewhere, but they are not hidden inputs to this limit. The plate is logical, not quantitative."
>}}

## Cross the real-projection cliff

Mathlib's [real-valued measure view](#ref-all-length-mathlib-real) is

\[
\mu_{\mathbb R}(S):=\operatorname{toReal}(\mu(S)).
\]

At infinity, \(\operatorname{toReal}(\infty)=0\), so this projection is not
continuous there. RMT-31 therefore assumes the local gate

\[
\mu(B_\infty(c))\ne\infty
\]

before composing
[<code>ENNReal.tendsto_toReal</code>](#ref-all-length-mathlib-toreal) with
extended continuity.
The result is

\[
\mu_{\mathbb R}(B_m(c))\longrightarrow
\mu_{\mathbb R}(B_\infty(c)).
\]

The gate concerns one event, not all of \(\Omega\). A finite measure space is
a convenient stronger interface because every subset has measure at most the
finite total mass; Lean discharges the target by <code>finiteness</code>.

{{< reference-figure
  src="finite-target-real-projection.svg"
  alt="The upper lane projects a finite extended-measure target to real measure and preserves convergence. The lower lane shows the infinity cliff, where the real projection sends infinite mass to zero and cannot generally preserve a limit. Finite total measure automatically certifies the union target."
  caption="**Finding:** real-measure continuity is a projection theorem with a finite-target premise, not a second unconditional continuity theorem. Local event finiteness is the checked gate; finite total mass discharges it automatically. The infinity lane shows information loss and does not claim failure for every particular infinite-target sequence."
>}}

## Transport the uniform RMT-30 ratio

Assume \(\mu\) is finite, \(T\) preserves \(\mu\), and \(X\) is an
integrable shifted-subadditive candidate. Suppose

\[
\delta\le
\frac{\int_\Omega Y_n\,d\mu}{n}
\qquad\text{for every }n\ne0,
\]

and choose \(c\lt\delta\). RMT-30 proves for every cap \(m\) that

\[
\mu_{\mathbb R}(B_m(c))\le\frac{\delta}{c}.
\]

The right side is independent of \(m\). Finite mass gives real convergence of
the cap measures. Lean's
[<code>le_of_tendsto'</code>](#ref-all-length-mathlib-order) then says that the limit
of values below one fixed ceiling remains below that ceiling:

\[
\boxed{\mu_{\mathbb R}(B_\infty(c))\le\frac{\delta}{c}}.
\]

The limit passage loses no factor and introduces no error term. It does not
repeat interval packing. RMT-30 has done the finite combinatorics; RMT-31
transports the cap-uniform conclusion. Since \(Y_1=0\), the rate premise
forces \(\delta\le0\), and \(c\lt\delta\) forces \(c\lt0\).

{{< reference-figure
  src="uniform-ratio-through-the-limit.svg"
  alt="Every finite cap lies below the same ratio ceiling. Finite total measure supplies convergence of the real cap measures, and le_of_tendsto' carries that unchanged ceiling to the all-length union. The diagram separates the RMT-30 finite estimate from the RMT-31 closed-limit step."
  caption="**Finding:** uniformity in the cap is the transferable resource. RMT-30 proves the same ratio for each cap; RMT-31 proves real convergence under finite mass and applies le_of_tendsto' to retain the ceiling at the union. No product monotonicity, limit-integral interchange, or new packing argument is used."
>}}

### Finite mass need not mean probability

The theorem uses <code>IsFiniteMeasure μ</code>, not probability. The source
checks a measure of total mass two. Under rescaling, event mass and raw
integrals scale, so a compatible \(\delta\) scales too. A two-atom identity
example is nonergodic, has bad set exactly one atom of mass \(1/2\), and proves
\(1/2\le2/3\).

## Specialize to log-positive cocycles

For a discrete matrix cocycle \(C\), take
\(X_n(\omega)=\log^+\lVert C(n,\omega)\rVert_\infty\). The named event is
<code>DiscreteMatrixCocycle.centeredLogPlusAllLengthBadBlockSet</code>.
The hypothesis <code>C.HasIntegrableGeneratorLogPlus</code> packages the
generic candidate and one-step integrability. Define

\[
\delta_C:=\gamma^+_\mu(C)-\int_\Omega X_1\,d\mu,
\]

where \(\gamma^+_\mu(C)\) is the
{{< refterm "integrated-log-positive-growth-rate" "integrated log-positive growth rate" >}}.
The deterministic Fekete interface supplies the uniform rate premise. For
every \(c\lt\delta_C\),

\[
\mu_{\mathbb R}(B_\infty^C(c))\le\frac{\delta_C}{c}.
\]

The theorem assumes no ergodicity and no positive-dimension premise; it
compiles with an empty finite matrix index. It concerns log-positive norm, not
signed logarithmic growth or a Lyapunov exponent.

## The raw event need not be invariant

An all-length union is not automatically invariant. It records one bad block
starting **now**, and moving the origin can erase that witness.

The source compiles a countermodel on <code>Bool</code>:

- the base map sends both points to <code>true</code>;
- the Dirac mass at <code>true</code> is preserved;
- the one-shot process is zero at <code>true</code>;
- at <code>false</code>, it is zero before length two and \(-1\) thereafter;
- at slope \(-2/5\), the bad event is exactly <code>{false}</code>.

The preimage of that singleton is empty, so

\[
T^{-1}B_\infty(-2/5)\ne B_\infty(-2/5).
\]

The source checks the integrable shifted-subadditive candidate and preservation
before proving non-invariance.

{{< reference-figure
  src="once-bad-versus-asymptotic-deviation.svg"
  alt="The left lane shows a checked collapse-map model where false has one later bad witness, the raw once-bad event is the singleton false, and shifting sends the point to true, so the event's preimage is empty and invariance fails. The right lane summarizes checked RMT-32: rational-slack recurrence, one-sided inclusion, finite-measure almost-invariance, ergodic empty-or-full dichotomy, and probability-based null selection."
  caption="**Finding:** a union over all lengths is still a once-bad event tied to the current origin. In the checked model, shifting removes the sole bad starting point even though the map preserves the measure and the process satisfies the generic interface. The now-checked RMT-32 lane proves a one-sided preimage inclusion first, then uses preservation and finite mass for almost-invariance. Finite-measure ergodicity yields the empty-or-full dichotomy; probability normalization and the strict ratio select the null branch."
>}}

Null measurability does not imply invariance. Measure preservation does not
make every dynamically defined set invariant. A subunit bound cannot become a
zero-one conclusion until the right event earns invariance or almost
invariance and the matching ergodic hypothesis is present.

## RMT-32 now supplies the event layer

RMT-32 does not merely add ergodicity to \(B_\infty(c)\). It replaces one
positive witness by an asymptotic statement: an intersection over starting
cutoffs of unions over later positive lengths. To represent strict lower
deviation honestly, it chooses one rational margin \(q\lt c\).

The checked change is from

\[
\exists n\gt0,\quad Y_n(\omega)\lt cn
\]

to a statement like

\[
q\in\mathbb Q,\quad q\lt c,\qquad
\forall N,\ \exists n\ge N,\quad 0\lt n\ \text{and}\ Y_n(\omega)\lt qn.
\]

The strict rational slack matters. A sequence can lie below \(c\) infinitely
often while approaching \(c\), so those witnesses alone do not prove that
its lower liminf is strictly below \(c\).

The new
[Rational-Slack Lower-Deviation Events and Ergodic Null Selection]({{< relref "/knowledge-base/deep-dives/rational-slack-lower-deviation-events-and-ergodic-null-selection" >}})
chapter follows the completed proof. RMT-32 establishes countable null
measurability, a threshold-relaxed fixed-slope preimage inclusion, rational
density at the target, and almost-invariance under preservation plus finite
mass. Finite-measure ergodicity yields an almost-empty or almost-full
dichotomy. Probability is not needed for that fork; probability normalization
and RMT-31's strict subunit ratio select the null branch.

The exact equivalence with a library-level real lower limit remains RMT-33's
job. RMT-31 supplies the quantitative once-bad ceiling used in branch
selection, while RMT-32 supplies the distinct asymptotic event and rigidity
layer.

## The eleven-declaration interface

| Declaration | Role |
|---|---|
| <code>centeredAllLengthBadBlockSet</code> | Defines the union |
| <code>mem_centeredAllLengthBadBlockSet_iff</code> | Gives one positive witness |
| <code>finiteCenteredBadBlockSet_mono</code> | Proves cap monotonicity |
| <code>centeredAllLengthBadBlockSet_eq_iUnion_finite</code> | Restates the union |
| <code>finiteCenteredBadBlockSet_subset_allLength</code> | Embeds each cap |
| <code>IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredAllLengthBadBlockSet</code> | Takes the null-measurable union |
| <code>tendsto_measure_finiteCenteredBadBlockSet</code> | Gives extended continuity |
| <code>tendsto_measureReal_finiteCenteredBadBlockSet</code> | Projects under local finiteness |
| <code>IsIntegrableSubadditiveProcessCandidate.measureReal_centeredAllLengthBadBlockSet_le_rateRatio</code> | Transfers the ratio |
| <code>DiscreteMatrixCocycle.centeredLogPlusAllLengthBadBlockSet</code> | Names the cocycle event |
| <code>DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusAllLengthBadBlockSet_le_rateRatio</code> | Proves the cocycle ratio |

Fifteen private support items build boundary models. Ten examples check the
zero cap, finite inclusion, negative-slope zero process, zero measure,
nonergodic half-mass model, strict later witness, cap-one behavior, mass-two
measure, empty cocycle index, and non-invariance. Seven axiom reports inspect
the central chain.

## Assumption and nonclaim ledger

| Layer | Required | Absent or unproved |
|---|---|---|
| Definition | Map, process, slope | Measurable space, measure, subadditivity |
| Union | Natural witness bounds | Every analytic premise |
| Null measurability | Candidate, preservation | Finite mass, probability, ergodicity |
| Extended limit | Increasing caps, union | Set measurability, preservation, finite mass |
| Real limit | Finite measure of union | Finite total mass as such |
| Generic ratio | Finite measure, preservation, candidate, uniform rate, \(c\lt\delta\) | Probability, ergodicity, invariance |
| Cocycle ratio | Finite measure, finite decidable matrix index, cocycle with bundled base preservation, integrable log-positive generator | Nonempty matrix index, probability, ergodicity, signed log growth |
| Future | Not in RMT-31 | Lower liminf, zero-one rigidity, Kingman convergence |

The module proves no lower-liminf inequality, almost-everywhere convergence,
\(L^1\) convergence, signed logarithmic growth, Lyapunov exponent, or
Oseledets splitting.

## Thirty solved exercises

### Exercise 1: unpack membership
What does \(\omega\in B_\infty(c)\) mean?

**Solution.** One finite \(n\) satisfies \(0\lt n\) and
\(Y_n(\omega)\lt cn\). There is no predetermined cap.

### Exercise 2: reject recurrence
Does membership imply infinitely many bad lengths?

**Solution.** No. A single existential witness suffices.

### Exercise 3: compute cap zero
What is \(B_0(c)\)?

**Solution.** It is empty because no positive length is at most zero.

### Exercise 4: recover a cap
Given an uncapped witness \(n\), which cap works?

**Solution.** Choose \(m=n\); then \(n\le m\) by reflexivity.

### Exercise 5: prove finite inclusion
Why is \(B_m(c)\subseteq B_\infty(c)\)?

**Solution.** It is one term of the defining union.

### Exercise 6: prove monotonicity
Why does \(m\le M\) imply \(B_m(c)\subseteq B_M(c)\)?

**Solution.** Reuse the witness and compose \(n\le m\) with \(m\le M\).

### Exercise 7: reject process monotonicity
Does Exercise 6 prove \(Y_m(\omega)\le Y_M(\omega)\)?

**Solution.** No. Search windows grow; terminal process values need not.

### Exercise 8: test equality
If \(Y_n(\omega)=cn\), is \(n\) a bad witness?

**Solution.** No. The definition requires strict inequality.

### Exercise 9: use a later witness
Can equality at time one coexist with all-length membership?

**Solution.** Yes. A later length can be strictly bad; the compiled example
uses time two at slope zero.

### Exercise 10: classify the union
Is equality with the cap union only almost everywhere?

**Solution.** No. It is exact set equality and is definitional.

### Exercise 11: build null measurability
Why is the all-length event null measurable?

**Solution.** Every cap is null measurable and countable unions preserve that
property.

### Exercise 12: avoid stronger regularity
May this be restated as ordinary measurability?

**Solution.** Not generally. Null measurability permits a null-set difference
from a measurable representative.

### Exercise 13: remove finite mass
Where is finite mass used in Exercise 11?

**Solution.** Nowhere. Countable-union closure has no finiteness premise.

### Exercise 14: state native continuity
Which limit is unconditional?

**Solution.** \(\mu(B_m(c))\to\mu(B_\infty(c))\) in extended measure, even
at an infinite target.

### Exercise 15: locate set measurability
Does that continuity theorem require measurable caps?

**Solution.** No. The Mathlib theorem used here accepts increasing sets
without that premise.

### Exercise 16: compute the cliff
What is \(\operatorname{toReal}(\infty)\)?

**Solution.** Zero. The projection loses the extended infinity information.

### Exercise 17: state the local gate
What permits real-measure convergence?

**Solution.** The target event's extended measure must differ from infinity.

### Exercise 18: compare finiteness notions
Can the real theorem apply when \(\mu(\Omega)=\infty\)?

**Solution.** Yes, if this particular union event has finite measure.

### Exercise 19: discharge the gate
Why does a finite measure instance suffice?

**Solution.** The event measure is bounded by the finite total mass.

### Exercise 20: transfer a ceiling
If \(x_m\to x\) and \(x_m\le C\), why is \(x\le C\)?

**Solution.** The closed interval ending at \(C\) contains every term and
therefore its limit. Lean uses <code>le_of_tendsto'</code>.

### Exercise 21: locate the finite input
What does RMT-30 contribute?

**Solution.** It proves the same ratio ceiling for every finite cap.

### Exercise 22: avoid new packing
Why is interval packing absent from RMT-31?

**Solution.** Packing already proved the uniform finite theorem; RMT-31 only
transports it through a limit.

### Exercise 23: force the rate sign
Why is \(\delta\le0\)?

**Solution.** Apply the rate premise at time one, where \(Y_1=0\).

### Exercise 24: force the slope sign
Why is \(c\lt0\)?

**Solution.** Combine \(c\lt\delta\) with \(\delta\le0\).

### Exercise 25: remove probability
Does the generic theorem require total mass one?

**Solution.** No. It requires finite mass and compiles for mass two.

### Exercise 26: remove ergodicity
What does the two-atom identity model show?

**Solution.** A nonergodic system has a half-mass bad event satisfying
\(1/2\le2/3\).

### Exercise 27: identify the cocycle rate
What plays the role of \(\delta\)?

**Solution.** The integrated log-positive Fekete rate minus the one-step
log-positive integral.

### Exercise 28: permit an empty index
Why can the matrix index be empty?

**Solution.** The proof uses a bundled norm-process interface and never
chooses a coordinate.

### Exercise 29: diagnose non-invariance
Why is the singleton event not invariant?

**Solution.** The collapse map sends both points to <code>true</code>, so the
preimage of <code>{false}</code> is empty.

### Exercise 30: design RMT-32
What must replace one-witness membership?

**Solution.** Arbitrarily late witnesses with suitable rational slack, a
lower-liminf interpretation, a proved one-sided preimage inclusion, and an
almost-invariance upgrade using preservation plus finite mass.

## Reproduce the checked interface

From the repository root:

~~~text
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/SubadditiveAllLengthBadBlockMeasure.lean
lake build NonlinearDynamics.Random.RandomCocycles.SubadditiveAllLengthBadBlockMeasure
~~~

For complete source and teaching checks, run <code>make check</code>. The
paired [Development Notebook]({{< relref "/development-notebook/2026/07/all-positive-length-centered-bad-block-control-in-lean" >}})
gives the proof ledger, countermodel inventory, and axiom reports.

## Continue the learning path

[Finite Bad-Block Measure Bounds Before Kingman Lower Liminf]({{< relref "/knowledge-base/deep-dives/finite-bad-block-measure-bounds-before-kingman-lower-liminf" >}})
derives the uniform finite-cap ratio.

[From Finite Maximal Bounds to an Infinite Weak Estimate]({{< relref "/knowledge-base/deep-dives/from-finite-maximal-bounds-to-an-infinite-weak-estimate" >}})
develops the analogous increasing-union and real-projection bridge.

{{< refterm "infinite-horizon-birkhoff-average-exceedance-event" "Infinite-horizon Birkhoff-average exceedance event" >}}
is a comparison for another one-witness event.
{{< refterm "birkhoff-sum" "Birkhoff sum" >}} and
{{< refterm "almost-everywhere" "almost everywhere" >}} review language used
in the regularity and future asymptotic layers.

## References

These primary sources and library references use Mathlib 4.32.0 at pinned
commit <code>81a5d257c8e410db227a6665ed08f64fea08e997</code>.

<a id="ref-all-length-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://academic.oup.com/jrsssb/article/30/3/499/7026968),
*JRSS Series B* 30(3), 499-510, 1968,
[doi:10.1111/j.2517-6161.1968.tb00749.x](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x).
This is the primary source for the full theorem RMT-31 does not claim.

<a id="ref-all-length-steele"></a>**J. Michael Steele.**
[Kingman's subadditive ergodic theorem](https://www.numdam.org/item/AIHPB_1989__25_1_93_0/),
*Annales de l'Institut Henri Poincare* 25(1), 93-98, 1989. Its interval
decomposition motivates the finite machinery; RMT-31 isolates the union step.

<a id="ref-all-length-mathlib-continuity"></a>**Mathlib contributors.**
[Continuity from below](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/MeasureSpace.lean#L646-L653),
Mathlib 4.32.0. It supplies the unconditional extended-measure limit.

<a id="ref-all-length-mathlib-toreal"></a>**Mathlib contributors.**
[Continuity of ENNReal.toReal away from infinity](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/Instances/ENNReal/Lemmas.lean#L100-L104),
Mathlib 4.32.0. RMT-31 uses it only at a finite target.

<a id="ref-all-length-mathlib-real"></a>**Mathlib contributors.**
[Definition of Measure.real](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/MeasureSpaceDef.lean#L99-L107),
Mathlib 4.32.0. The definition totalizes infinite mass to zero.

<a id="ref-all-length-mathlib-null"></a>**Mathlib contributors.**
[Null-measurable sets](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/NullMeasurable.lean#L132-L135),
Mathlib 4.32.0. The proof uses countable-union closure here.

<a id="ref-all-length-mathlib-order"></a>**Mathlib contributors.**
[Closed-order limit lemmas](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/Order/OrderClosed.lean#L132-L140),
Mathlib 4.32.0. The ratio proof uses <code>le_of_tendsto'</code> to retain a
common upper bound at the real-measure limit.
