---
title: "From Finite Centered Bad-Block Bounds to All-Positive-Length Control"
slug: "from-finite-centered-bad-block-bounds-to-all-positive-length-control"
date: 2026-07-22
summary: "A textbook passage from uniformly controlled finite centered bad-block sets to the event with one bad witness at any positive length, with the extended-measure limit, finite-target real projection, cocycle specialization, and raw non-invariance all explicit."
lead: "A bound for every finite cap is not yet a bound for the union over all positive lengths. RMT-31 nests the caps, identifies one finite witness, takes continuity from below in extended measure, crosses to real measure only at a finite target, and transports the uniform RMT-30 ratio with le_of_tendsto'. The resulting raw event is still not an asymptotic deviation event and need not be invariant."
draft: false
pro_reviewed: false
level: "Subadditive processes, finite bad-block estimates, null measurable sets, extended nonnegative real measure, filter convergence, and intermediate Lean theorem reading"
reading_time: "180 to 260 minutes"
prerequisites: "Centered subadditive processes, the RMT-30 finite bad-block ratio, increasing unions, finite measures, and elementary real convergence; no Kingman theorem is assumed"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveAllLengthBadBlockMeasure"
toc: true
og_image: "from-finite-centered-bad-block-bounds-to-all-positive-length-control-card.png"
og_image_alt: "Exact two-atom centered bad-block ledger. Amber has centered values minus n minus one, blue has value zero, and the slope is negative three quarters. Length five is the first strict witness, caps zero through four are empty, the all-length event has mass one half, and its unchanged ratio ceiling is two thirds."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This AI-assisted working draft is published as an open
working note. Its mathematical claims and declaration names have been
reconciled with the frozen RMT-31 Lean module, while human publication review
and the configured external Pro review remain pending.
{{< /panel >}}

## Begin with two atoms and one first witness

Let

\[
\Omega=\{\text{amber},\text{blue}\}
\]

carry the uniform probability measure, so each atom has mass \(1/2\). Let the
base map be the identity. This system preserves the measure but is not
ergodic: each singleton is invariant and has nonzero, nonfull mass.

Use the centered process

\[
Y_n(\text{amber})=-(n-1),
\qquad
Y_n(\text{blue})=0.
\]

Natural-number subtraction is truncated, so \(Y_0(\text{amber})=0\), and
\(Y_1=0\) at both atoms. Choose the slope

\[
c=-\frac34.
\]

A positive length \(n\) is a strict bad-block witness at \(x\) when

\[
Y_n(x)\lt cn.
\]

For blue this never happens: \(0\) cannot lie below the negative number
\(-3n/4\). For amber, the complete first ledger is:

| \(n\) | \(Y_n(\text{amber})\) | \(cn\) | strict witness? | reason |
|---:|---:|---:|:---:|---|
| \(0\) | \(0\) | \(0\) | no | witnesses must have positive length |
| \(1\) | \(0\) | \(-3/4\) | no | the value lies above the line |
| \(2\) | \(-1\) | \(-3/2\) | no | the value lies above the line |
| \(3\) | \(-2\) | \(-9/4\) | no | the value lies above the line |
| \(4\) | \(-3\) | \(-3\) | no | equality is not strict |
| \(5\) | \(-4\) | \(-15/4\) | yes | first strict witness |
| \(6\) | \(-5\) | \(-9/2\) | yes | the point remains discoverable |
| \(7\) | \(-6\) | \(-21/4\) | yes | the point remains discoverable |

The algebra isolates the same boundary:

\[
-(n-1)\lt-\frac34n
\quad\Longleftrightarrow\quad
1\lt\frac14n
\quad\Longleftrightarrow\quad
4\lt n.
\]

If \(B_m(c)\) searches only lengths \(1,\ldots,m\), then

\[
B_0(c)=B_1(c)=\cdots=B_4(c)=\varnothing,
\]

while

\[
B_5(c)=B_6(c)=\cdots=\{\text{amber}\}.
\]

Removing the cap does not create an infinite witness. It merely permits the
finite witness \(n=5\):

\[
B_\infty(c)
{} =
\bigcup_{m\in\mathbb N}B_m(c)
=\{\text{amber}\},
\qquad
\mu(B_\infty(c))=\frac12.
\]

{{< reference-figure
  wide="true"
  src="two-atom-cap-and-ratio-ledger.svg"
  alt="A uniform two-atom identity system is shown. Amber has centered value minus n minus one, blue has value zero, and the strict comparison line has slope negative three quarters. Lengths zero through four fail, with equality at four, while length five is the first strict witness. Caps zero through four are empty, every later cap is amber, the union has mass one half, and the rate-ratio bound is two thirds. A slope-zero panel shows cap one empty and cap two amber."
  caption="**Exact cap ledger:** amber first crosses strictly below the line \(cn=-3n/4\) at \(n=5\); equality at \(n=4\) is excluded. Thus the nested cap sequence stabilizes from \(\varnothing\) to \(\{\text{amber}\}\), and the all-length event has mass \(1/2\). The normalized integral is bounded below by \(\delta=-1/2\), giving the unchanged ceiling \(\delta/c=2/3\). The slope-zero boundary separately shows why \(Y_1=0\) contributes nothing while \(Y_2=-1\) does."
>}}

### See the rate premise numerically

Uniform integration gives, for every positive \(n\),

\[
\int_\Omega Y_n\,d\mu
{} =
\frac12\bigl(-(n-1)\bigr)+\frac12\cdot0
=-\frac{n-1}{2}.
\]

After normalization,

\[
\frac{\int_\Omega Y_n\,d\mu}{n}
=-\frac{n-1}{2n}
=-\frac12+\frac{1}{2n}.
\]

Set

\[
\delta=-\frac12.
\]

Then \(\delta\) is a lower bound for every positive normalized integral, and

\[
c=-\frac34\lt-\frac12=\delta.
\]

The generic RMT-31 conclusion becomes

\[
\mu(B_\infty(c))
=\frac12
\le
\frac{\delta}{c}
=\frac{-1/2}{-3/4}
=\frac23.
\]

The theorem does not need ergodicity, and this identity model is explicitly
nonergodic. It also does not need probability normalization; the uniform
probability is used here only because it makes every number transparent.

### Let equality fail first and strictness succeed later

Set the slope to zero while keeping the same process. At length one,

\[
Y_1(\text{amber})=0=0\cdot1,
\]

so the strict comparison fails. At length two,

\[
Y_2(\text{amber})=-1\lt0\cdot2,
\]

so amber enters. Therefore

\[
B_1(0)=\varnothing,
\qquad
B_2(0)=\{\text{amber}\}.
\]

This nearby boundary prevents two common mistakes: replacing strict
\(\lt\) by non-strict \(\le\), or deciding the uncapped event from length one
alone.

### Separate one bad length from recurrence and invariance

Now use a different two-atom model. Let the base map collapse both atoms to
blue:

\[
T(\text{amber})=\text{blue},
\qquad
T(\text{blue})=\text{blue}.
\]

The Dirac measure at blue is preserved. Define a one-shot centered process by

\[
Y_n(\text{blue})=0
\]

for every \(n\), and

\[
Y_1(\text{amber})=0,
\qquad
Y_n(\text{amber})=-1\quad(n\ge2).
\]

Choose \(c=-2/5\). Amber is strict at exactly one positive length:

| \(n\) | \(Y_n(\text{amber})\) | \(cn\) | strict? |
|---:|---:|---:|:---:|
| \(1\) | \(0\) | \(-2/5\) | no |
| \(2\) | \(-1\) | \(-4/5\) | yes |
| \(3\) | \(-1\) | \(-6/5\) | no |
| \(4\) | \(-1\) | \(-8/5\) | no |

For \(n\ge3\), the line keeps moving downward while the one-shot value stays
at \(-1\), so there are no arbitrarily late witnesses. Nevertheless,

\[
B_\infty(-2/5)=\{\text{amber}\}
\]

because the raw event asks for one witness. The collapse map never lands at
amber, hence

\[
T^{-1}\bigl(B_\infty(-2/5)\bigr)=\varnothing
\ne
\{\text{amber}\}=B_\infty(-2/5).
\]

{{< reference-figure
  wide="true"
  src="collapse-map-raw-event-ledger.svg"
  alt="A collapse map sends both amber and blue to blue and preserves a Dirac mass at blue. Amber has a one-shot centered value negative one from length two onward against slope negative two fifths. It is strictly below the line only at length two, so the raw event is amber, but its preimage is empty. Both sets have zero Dirac-blue measure although they are setwise unequal."
  caption="**Checked non-invariance model:** one strict witness at \(n=2\) puts amber in the raw all-length event, even though no later length works. Because the collapse map sends both atoms to blue, the preimage of \(\{\text{amber}\}\) is empty. The preserved Dirac-blue measure assigns both sets mass zero, so this example proves failure of setwise invariance without claiming failure of almost-everywhere equality. It also makes the once-bad versus asymptotic distinction numerical."
>}}

The two models serve different purposes. The identity model checks nested caps,
the first strict witness, the uniform rate premise, and the \(1/2\le2/3\)
ratio. The collapse model checks that a one-witness union can be setwise
noninvariant even for a preserved finite measure and a valid
shifted-subadditive process.

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

## Seven bridges from the two-atom ledgers to Lean

The finite tables used lists of atoms and exact rational comparisons. The
project module states the same architecture for arbitrary sets, measures, and
centered subadditive processes. Each bridge aligns ordinary language, paper
mathematics, exact Lean syntax, and the tokens that carry the proof.

### Bridge 1: remove the cap without inventing an infinite witness

{{< lean-bridge
  human="A point belongs to the all-length event exactly when one positive finite length is a strict witness."
  math="\(\omega\in B_\infty(c)\Longleftrightarrow\exists n\in\mathbb N,\ 0\lt n\ \land\ Y_n(\omega)\lt cn.\)"
  lean="mem_centeredAllLengthBadBlockSet_iff"
>}}

- <code>centeredAllLengthBadBlockSet T X c</code> is the union over natural
  caps.
- <code>centeredProcess T X n ω</code> is the centered value \(Y_n(\omega)\).
- The witness carries <code>0 &lt; n</code>; cap zero contributes nothing.
- The comparison remains strict. No “infinitely often,” limit, supremum, or
  infinite length appears.
{{< /lean-bridge >}}

### Bridge 2: enlarge only the search window

{{< lean-bridge
  human="If cap m is at most cap M, every witness allowed under m is still allowed under M."
  math="\(m\le M\Longrightarrow B_m(c)\subseteq B_M(c).\)"
  lean="finiteCenteredBadBlockSet_mono hmM c"
>}}

- <code>hmM : m ≤ M</code> is the only premise.
- A witness supplies <code>1 ≤ n</code> and <code>n ≤ m</code>; transitivity
  gives <code>n ≤ M</code>.
- Neither a measurable space nor a measure is needed.
- This theorem does not compare \(Y_m\) and \(Y_M\); the process itself need
  not be monotone in time.
{{< /lean-bridge >}}

### Bridge 3: take the countable null-measurable union

{{< lean-bridge
  human="If every finite cap is null measurable, their countable all-length union is null measurable too."
  math="\(\bigl[\forall m,\ \operatorname{NullMeasurableSet}_\mu(B_m(c))\bigr]\Longrightarrow\operatorname{NullMeasurableSet}_\mu(B_\infty(c)).\)"
  lean="hX.nullMeasurableSet_centeredAllLengthBadBlockSet hT c"
>}}

- <code>hX : IsIntegrableSubadditiveProcessCandidate T μ X</code> supplies
  the RMT-30 regularity for each cap.
- <code>hT : MeasurePreserving T μ μ</code> transports integrability along
  the dynamics.
- <code>NullMeasurableSet.iUnion</code> closes the countable union.
- No finite-mass, probability, ergodicity, or ordinary
  <code>MeasurableSet</code> premise is added.
{{< /lean-bridge >}}

### Bridge 4: take continuity in extended measure first

{{< lean-bridge
  human="The extended measures of the nested finite caps converge to the extended measure of their union, even when the target is infinite."
  math="\(\mu(B_m(c))\longrightarrow\mu(B_\infty(c))\quad\text{in }\mathbb R_{\ge0\infty}.\)"
  lean="tendsto_measure_finiteCenteredBadBlockSet (T := T) (μ := μ) X c"
>}}

- <code>μ (...)</code> is an extended nonnegative real value, so
  \(\infty\) remains legitimate.
- <code>atTop</code> means that the natural cap tends upward without bound.
- <code>nhds</code> identifies the target neighborhood filter.
- <code>tendsto_measure_iUnion_atTop</code> consumes only the cap monotonicity
  and exact union; event measurability and finite mass are absent.
{{< /lean-bridge >}}

### Bridge 5: cross to `Measure.real` only at a finite target

{{< lean-bridge
  human="Real-valued cap measures converge only after certifying that the union's extended measure is not infinity."
  math="\(\mu(B_\infty(c))\ne\infty\Longrightarrow\mu_{\mathbb R}(B_m(c))\longrightarrow\mu_{\mathbb R}(B_\infty(c)).\)"
  lean="tendsto_measureReal_finiteCenteredBadBlockSet (T := T) (μ := μ) X c hfinite"
>}}

- <code>hfinite : μ (centeredAllLengthBadBlockSet T X c) ≠ ∞</code> is local
  to the target event.
- <code>Measure.real</code> is <code>ENNReal.toReal</code> applied to a
  measure value.
- Since <code>toReal ∞ = 0</code>, continuity cannot be composed through the
  infinity cliff without <code>hfinite</code>.
- <code>[IsFiniteMeasure μ]</code> is a convenient stronger assumption used
  later to discharge this local gate automatically.
{{< /lean-bridge >}}

### Bridge 6: preserve the finite-cap ratio at the union

{{< lean-bridge
  human="A cap-uniform centered rate ratio passes unchanged to all positive lengths on a finite measure space."
  math="\(\delta\le(\int Y_n\,d\mu)/n\ \forall n\gt0,\ c\lt\delta\Longrightarrow\mu_{\mathbb R}(B_\infty(c))\le\delta/c.\)"
  lean="hX.measureReal_centeredAllLengthBadBlockSet_le_rateRatio hT δ c hδ hc"
>}}

- <code>hδ</code> is the lower bound for every nonzero normalized centered
  integral.
- <code>hc : c &lt; δ</code> is the strict slope separation.
- RMT-30 supplies the same ceiling <code>δ / c</code> for every cap.
- <code>le_of_tendsto'</code> carries that closed upper bound through the
  real-measure limit with no extra factor or error term.
{{< /lean-bridge >}}

### Bridge 7: specialize the generic bridge to a matrix cocycle

{{< lean-bridge
  human="For a discrete matrix cocycle with integrable log-positive generator, the same all-length ratio holds with the integrated Fekete offset."
  math="\(c\lt\gamma_\mu^+(C)-\int X_1\,d\mu\Longrightarrow\mu_{\mathbb R}(B_\infty^C(c))\le\bigl(\gamma_\mu^+(C)-\int X_1\,d\mu\bigr)/c.\)"
  lean="hC.measureReal_centeredLogPlusAllLengthBadBlockSet_le_rateRatio c hc"
>}}

- <code>hC : C.HasIntegrableGeneratorLogPlus</code> supplies the generic
  candidate, preservation, and the needed integrability.
- <code>C.integratedLogPlusGrowthRate hC</code> is the deterministic
  integrated log-positive growth rate.
- <code>C.integratedLogPlusNorm 1</code> is the one-step integral.
- The theorem adds neither ergodicity nor a nonempty matrix index and still
  asserts only a once-bad measure bound.
{{< /lean-bridge >}}

### Type-check the exact project interface

{{< repo-check module="NonlinearDynamics.Random.RandomCocycles.SubadditiveAllLengthBadBlockMeasure" >}}

On an approved Linux builder, place this probe in a project scratch file:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.SubadditiveAllLengthBadBlockMeasure

open NonlinearDynamics.Random.RandomCocycles

#check centeredAllLengthBadBlockSet
#check mem_centeredAllLengthBadBlockSet_iff
#check finiteCenteredBadBlockSet_mono
#check centeredAllLengthBadBlockSet_eq_iUnion_finite
#check finiteCenteredBadBlockSet_subset_allLength
#check IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredAllLengthBadBlockSet
#check tendsto_measure_finiteCenteredBadBlockSet
#check tendsto_measureReal_finiteCenteredBadBlockSet
#check IsIntegrableSubadditiveProcessCandidate.measureReal_centeredAllLengthBadBlockSet_le_rateRatio
#check DiscreteMatrixCocycle.centeredLogPlusAllLengthBadBlockSet
#check DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusAllLengthBadBlockSet_le_rateRatio
~~~

From the repository root on that approved Linux host, type:

~~~sh
source "$HOME/.elan/env"
CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/Random/RandomCocycles/SubadditiveAllLengthBadBlockMeasure.lean
~~~

This is a **project/Mathlib check**. It can restore or compile substantial
dependencies and must not run on the Mac workstation. The guarded target
checks the pinned manifest and validates the authoritative 481-line source
with warnings treated as errors.
{{< /repo-check >}}

## Run both two-atom ledgers with `Std`

The following file imports only Lean's `Std` library. It computes the nested
caps, first witness, union mass, ratio, slope-zero strictness boundary, and
collapse-map preimage with exact rational arithmetic. It neither imports
Mathlib nor opens this project. Save the block byte for byte as
<code>/tmp/AllLengthBadBlockDeepDiveTutorial.lean</code>:

~~~lean
import Std

namespace AllLengthBadBlockDeepDiveTutorial

inductive Atom where
  | amber
  | blue
  deriving Repr, DecidableEq

def atoms : List Atom := [.amber, .blue]

def atomName : Atom → String
  | .amber => "amber"
  | .blue => "blue"

def centered (n : Nat) : Atom → Rat
  | .amber => -((n - 1 : Nat) : Rat)
  | .blue => 0

def slope : Rat := -(3 : Rat) / 4

def strictBadAt (n : Nat) (x : Atom) : Bool :=
  decide (0 < n ∧ centered n x < slope * (n : Rat))

def capEvent (cap : Nat) : List Atom :=
  atoms.filter fun x =>
    (List.range (cap + 1)).any fun n => strictBadAt n x

def firstWitness (x : Atom) : Option Nat :=
  ((List.range 12).map (· + 1)).find? fun n => strictBadAt n x

def eventMass (event : List Atom) : Rat :=
  (event.length : Rat) / 2

structure CapRow where
  cap : Nat
  event : List String
  mass : Rat
  deriving Repr, DecidableEq

def capRow (cap : Nat) : CapRow :=
  let event := capEvent cap
  { cap := cap
    event := event.map atomName
    mass := eventMass event }

def strictAtSlope (c : Rat) (n : Nat) (x : Atom) : Bool :=
  decide (0 < n ∧ centered n x < c * (n : Rat))

def capEventAtSlope (c : Rat) (cap : Nat) : List Atom :=
  atoms.filter fun x =>
    (List.range (cap + 1)).any fun n => strictAtSlope c n x

def collapse : Atom → Atom
  | .amber => .blue
  | .blue => .blue

def oneShotCentered (n : Nat) : Atom → Rat
  | .amber => if 2 ≤ n then -1 else 0
  | .blue => 0

def oneShotBadAt (n : Nat) (x : Atom) : Bool :=
  decide (0 < n ∧
    oneShotCentered n x < (-(2 : Rat) / 5) * (n : Rat))

def oneShotEvent (cap : Nat) : List Atom :=
  atoms.filter fun x =>
    (List.range (cap + 1)).any fun n => oneShotBadAt n x

def oneShotPreimage (cap : Nat) : List Atom :=
  atoms.filter fun x => (oneShotEvent cap).contains (collapse x)

#eval (List.range 9).map capRow
#eval atoms.map fun x => (atomName x, firstWitness x)
#eval (capEvent 12).map atomName
#eval (eventMass (capEvent 12), (-(1 : Rat) / 2) / slope)
#eval ((capEventAtSlope 0 1).map atomName,
  (capEventAtSlope 0 2).map atomName)
#eval ((oneShotEvent 12).map atomName,
  (oneShotPreimage 12).map atomName)

example : ((List.range 8).map fun n => strictBadAt n .amber) =
    [false, false, false, false, false, true, true, true] := by
  native_decide

example : capEvent 4 = [] := by native_decide
example : capEvent 5 = [.amber] := by native_decide
example : eventMass (capEvent 12) = (1 : Rat) / 2 := by
  native_decide
example : eventMass (capEvent 12) ≤ (-(1 : Rat) / 2) / slope := by
  native_decide
example : capEventAtSlope 0 1 = [] := by native_decide
example : capEventAtSlope 0 2 = [.amber] := by native_decide
example : oneShotEvent 12 = [.amber] := by native_decide
example : oneShotPreimage 12 = [] := by native_decide

end AllLengthBadBlockDeepDiveTutorial
~~~

Important syntax:

- <code>inductive Atom</code> creates exactly the two named atoms;
- <code>Rat</code> keeps the slopes, masses, and ratio exact;
- <code>List.range (cap + 1)</code> searches lengths zero through the cap,
  while <code>strictBadAt</code> separately requires positive length;
- <code>List.any</code> implements existence of one witness;
- <code>List.filter</code> materializes the finite event;
- <code>find?</code> returns <code>some 5</code> for amber and
  <code>none</code> for blue; and
- each <code>native_decide</code> example asks Lean to certify a displayed
  boundary or inequality.

With the pinned compiler installed, a human types:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean \
  /tmp/AllLengthBadBlockDeepDiveTutorial.lean
~~~

This is a **small standalone tutorial** suitable for a normal Mac or Linux
host. It imports only `Std`, enumerates two atoms, and does not compile Mathlib
or this project. Successful execution prints exactly:

~~~text
[{ cap := 0, event := [], mass := 0 },
 { cap := 1, event := [], mass := 0 },
 { cap := 2, event := [], mass := 0 },
 { cap := 3, event := [], mass := 0 },
 { cap := 4, event := [], mass := 0 },
 { cap := 5, event := ["amber"], mass := (1 : Rat)/2 },
 { cap := 6, event := ["amber"], mass := (1 : Rat)/2 },
 { cap := 7, event := ["amber"], mass := (1 : Rat)/2 },
 { cap := 8, event := ["amber"], mass := (1 : Rat)/2 }]
[("amber", some 5), ("blue", none)]
["amber"]
((1 : Rat)/2, (2 : Rat)/3)
([], ["amber"])
(["amber"], [])
~~~

The first output is the increasing cap sequence. The next three outputs
identify the first witness, union, mass, and ratio. The final two certify the
slope-zero strictness boundary and the collapse model's unequal raw event and
preimage. These finite computations do not model extended nonnegative real
measure, `Measure.real`, null measurability, or filter convergence; those are
the responsibilities of the project module.

## The eleven-declaration interface

The frozen 481-line source exposes exactly eleven public declarations in
source order. Its SHA-256 is
<code>53438522344c078d64473316a594570993d694ada909a33184579cec6a996fb7</code>.

| No. | Declaration | Exact responsibility |
|---:|---|---|
| 1 | <code>centeredAllLengthBadBlockSet</code> | Defines the union of every finite centered bad-block cap |
| 2 | <code>mem_centeredAllLengthBadBlockSet_iff</code> | Rewrites membership as one positive finite strict witness |
| 3 | <code>finiteCenteredBadBlockSet_mono</code> | Proves monotonicity in the search cap |
| 4 | <code>centeredAllLengthBadBlockSet_eq_iUnion_finite</code> | Restates the definitional union exactly |
| 5 | <code>finiteCenteredBadBlockSet_subset_allLength</code> | Embeds each fixed cap in the all-length event |
| 6 | <code>IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredAllLengthBadBlockSet</code> | Takes the countable null-measurable union under preservation |
| 7 | <code>tendsto_measure_finiteCenteredBadBlockSet</code> | Gives unconditional continuity from below in extended measure |
| 8 | <code>tendsto_measureReal_finiteCenteredBadBlockSet</code> | Projects the limit to real measure under local target finiteness |
| 9 | <code>IsIntegrableSubadditiveProcessCandidate.measureReal_centeredAllLengthBadBlockSet_le_rateRatio</code> | Transfers the cap-uniform generic ratio through the real limit |
| 10 | <code>DiscreteMatrixCocycle.centeredLogPlusAllLengthBadBlockSet</code> | Names the cocycle's log-positive all-length event |
| 11 | <code>DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusAllLengthBadBlockSet_le_rateRatio</code> | Specializes the unchanged ratio to the cocycle Fekete offset |

### Fifteen private support items

These source-local declarations build boundary models without enlarging the
public API:

| No. | Private item | Role |
|---:|---|---|
| 1 | <code>rmt31ZeroProcess</code> | Defines the identically zero process |
| 2 | <code>rmt31ZeroProcess_candidate</code> | Certifies integrability and shifted subadditivity of the zero process |
| 3 | <code>rmt31TwoPointProbability</code> | Defines the equal-weight measure on `Bool` |
| 4 | private <code>IsProbabilityMeasure rmt31TwoPointProbability</code> instance | Proves that the two weights sum to one |
| 5 | <code>rmt31Id_not_preErgodic</code> | Proves identity on the two-atom probability space is not pre-ergodic |
| 6 | <code>rmt31TwoPointProcess</code> | Defines zero on blue/`true` and \(-(n-1)\) on amber/`false` |
| 7 | <code>rmt31TwoPointProcess_candidate</code> | Certifies the displayed process as an integrable shifted-subadditive candidate |
| 8 | <code>rmt31MassTwoMeasure</code> | Defines a finite measure of total mass two on `Unit` |
| 9 | private <code>IsFiniteMeasure rmt31MassTwoMeasure</code> instance | Supplies its finite-measure certificate |
| 10 | <code>rmt31Collapse</code> | Sends both Boolean points to `true` |
| 11 | <code>rmt31OneShotProcess</code> | Defines the zero/negative-one one-shot process |
| 12 | <code>rmt31_iterate_collapse_true</code> | Shows every iterate keeps `true` fixed |
| 13 | <code>rmt31_iterate_collapse_of_ne_zero</code> | Shows every positive iterate sends either point to `true` |
| 14 | <code>rmt31OneShotProcess_candidate</code> | Certifies the one-shot process as an integrable shifted-subadditive candidate |
| 15 | <code>rmt31Collapse_preserving</code> | Proves the collapse map preserves the Dirac measure at `true` |

### Ten anonymous compiled examples

The examples are checked propositions but do not create public names:

| Probe | Exact boundary checked |
|---:|---|
| 1 | Every cap-zero event is empty |
| 2 | Every finite cap embeds in the all-length union |
| 3 | The zero process has no strict witness below a negative slope |
| 4 | Every all-length event has real measure zero under the zero measure |
| 5 | The nonergodic uniform two-point identity model has event mass \(1/2\) and satisfies \(1/2\le2/3\) |
| 6 | Equality at length one for slope zero is excluded, while length two gives a later strict witness |
| 7 | The cap-one event for the two-point process is the whole space exactly when \(0\lt c\), and is empty otherwise |
| 8 | The generic ratio theorem works for a finite measure of total mass two, not only a probability |
| 9 | The cocycle theorem compiles with an empty matrix index |
| 10 | The preserved collapse-map model has a raw event unequal to its preimage |

### Seven axiom reports

The source prints the axiom footprints of:

1. <code>mem_centeredAllLengthBadBlockSet_iff</code>;
2. <code>finiteCenteredBadBlockSet_mono</code>;
3. <code>IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_centeredAllLengthBadBlockSet</code>;
4. <code>tendsto_measure_finiteCenteredBadBlockSet</code>;
5. <code>tendsto_measureReal_finiteCenteredBadBlockSet</code>;
6. <code>IsIntegrableSubadditiveProcessCandidate.measureReal_centeredAllLengthBadBlockSet_le_rateRatio</code>; and
7. <code>DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusAllLengthBadBlockSet_le_rateRatio</code>.

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

## Reproduce the right layer on the right machine

There are two deliberately separate runnable paths.

- The `Std` worksheet is a tiny two-atom arithmetic tutorial suitable for an
  ordinary Mac or Linux host.
- The exact project import, extended-measure API, `Measure.real`, filter
  limits, candidate interface, and warning-fatal leaf check belong to the
  guarded Linux/RunPod command in
  [Type-check the exact project interface](#type-check-the-exact-project-interface).

The distinction is about resource use, not pedagogy. Readers should type,
run, and modify the finite tutorial locally. The Mathlib-backed proof remains
fully visible without rebuilding the project cache on this workstation.

The Hugo teaching layer can be checked safely from the repository root:

~~~sh
make site-check
git diff --check
~~~

The paired [Development Notebook]({{< relref "/development-notebook/2026/07/all-positive-length-centered-bad-block-control-in-lean" >}})
gives the implementation ledger and review history.

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
