---
title: "Finite Bad-Block Measure Bounds Before Kingman Lower Liminf"
slug: "finite-bad-block-measure-bounds-before-kingman-lower-liminf"
date: 2026-07-22
summary: "A textbook derivation of how finite centered bad blocks, orbit visit counts, greedy interval packing, and a negative-threshold limit produce a measure ratio before any lower-liminf theorem."
lead: "The lower half of a subadditive ergodic theorem cannot be read off from the upper limsup. This chapter isolates the finite bridge that comes first: mark short blocks below a negative slope, count orbit visits to those marks, pack witnessing intervals, integrate the resulting pointwise inequality, and pass only the auxiliary horizon to infinity."
draft: true
pro_reviewed: false
level: "Subadditive processes, finite measure theory, Birkhoff sums, interval packing, signed inequalities, and intermediate Lean theorem reading"
reading_time: "190 to 280 minutes"
prerequisites: "Finite sums, real integration, null measurable sets, measure-preserving maps, shifted subadditivity, and elementary limits; Lean experience is helpful but not required"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveBadBlockMeasure"
toc: true
og_image: "finite-bad-block-measure-bounds-before-kingman-lower-liminf-card.png"
og_image_alt: "Warm-paper Deep Dive card showing short centered bad blocks becoming orbit visit marks, greedy packed intervals, an integrated negative-slope inequality, and a finite measure ratio, with lower liminf and Kingman convergence still explicitly absent."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is a draft teaching chapter pending human
editorial, scientific-integrity, and zero-context expert-reader review. The
checked Lean source is authoritative. The chapter proves a finite bad-block
measure estimate, not a lower-liminf theorem or Kingman convergence.
{{< /panel >}}

Let \((\Omega,\mu,T)\) be a finite measure space with a measure-preserving
map \(T:\Omega\to\Omega\). Let

\[
X_n:\Omega\to\mathbb R,
\qquad n\in\mathbb N,
\]

be an integrable shifted-subadditive process. Thus every finite horizon is
integrable and

\[
X_{a+b}(\omega)
\le X_b(T^a\omega)+X_a(\omega).
\]

Subtract the additive orbit sum of the one-step observable:

\[
Y_n(\omega)
{} :=
X_n(\omega)-\sum_{j=0}^{n-1}X_1(T^j\omega).
\]

This is the repository's `centeredProcess`. The word *centered* does not mean
expectation centering. It means subtraction of a pointwise one-step orbit
majorant. Consequently,

\[
Y_1=0,
\qquad
Y_n\le0\quad(n\gt0),
\]

and \(Y\) remains shifted-subadditive.

RMT-30 asks a finite question. Fix a length cap \(m\) and a slope \(c\). How
large can the set of points be where at least one positive block of length at
most \(m\) falls strictly below the line of slope \(c\)? If a number
\(\delta\) is below every positive normalized centered integral and
\(c\lt\delta\), the checked answer is

\[
\mu_{\mathbb R}(B_m(c))\le\frac{\delta}{c}.
\]

Here \(\mu_{\mathbb R}\) is Mathlib's real projection of a finite measure,
and \(B_m(c)\) is the finite bad-block set defined below. The ratio is
nonnegative because the time-one identity forces

\[
c\lt\delta\le0.
\]

The result uses no probability normalization and no ergodicity. It also does
not take a samplewise limit. The only limit is an auxiliary counting horizon
used to remove a finite boundary buffer.

The immediate formal predecessors are
[Finite Ordered Interval Packing for Nonpositive Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-ordered-interval-packing-for-nonpositive-subadditive-processes" >}})
and
[Subadditive Upper Limsup Bounds Before Kingman Convergence]({{< relref "/knowledge-base/deep-dives/subadditive-upper-limsup-bounds-before-kingman-convergence" >}}).
The companion
[Development Notebook]({{< relref "/development-notebook/2026/07/finite-centered-bad-block-measure-control-in-lean" >}})
records the executable source ledger, while the
{{< refterm "finite-orbit-visit-count" "finite orbit-visit count" >}}
glossary chapter isolates the counting interface.
The broader proof lineage comes from interval-decomposition proofs of the
subadditive ergodic theorem, especially Steele's concise construction
([Steele 1989](#ref-bad-deep-steele)). RMT-30 extracts one finite,
machine-checked bridge from that lineage rather than claiming the full theorem
([Kingman 1968](#ref-bad-deep-kingman)).

## Learning objectives

By the end, a reader should be able to:

1. define a finite strict bad-block set with an exact positive-length window;
2. turn finite orbit visits into a real-valued Birkhoff sum of an indicator;
3. explain why null measurability is the correct regularity level;
4. select one witnessing length at every marked orbit start;
5. use greedy interval packing to control the enlarged horizon \(H+m\);
6. identify the genuine false corner \(H=m=0\);
7. integrate the pointwise packing inequality exactly;
8. track the signs of \(c\) and \(\delta\) through negative division;
9. pass the auxiliary horizon \(H\) to infinity without interchanging a
   samplewise limit and an integral;
10. explain how finite-measure rescaling changes the numerical rate; and
11. specialize the generic result to log-positive matrix-cocycle growth.

## One finite bad-block window

For \(m\in\mathbb N\) and \(c\in\mathbb R\), define

\[
B_m(c)
{} :=
\bigcup_{n=1}^{m}
\left\{\omega:Y_n(\omega)\lt cn\right\}.
\]

The interval of candidate lengths is exactly \(1\le n\le m\). Length zero is
excluded because \(Y_0=X_0\) can be positive and because a zero-length block
cannot advance an interval-packing algorithm. The inequality is strict. A
block exactly on the threshold is not marked.

{{< reference-figure
  src="finite-bad-block-window.svg"
  alt="A finite candidate window checks block lengths one through m at a single starting point. Length zero is excluded, blocks above or equal to the threshold are unmarked, and any strict failure below the threshold places the point in the finite bad-block set."
  caption="A point enters the finite bad-block set when at least one positive candidate length up to the cap has centered cost strictly below the chosen slope. The plate shows logical membership only; block heights are conceptual and are not measured data."
>}}

Two boundary facts are immediate. If \(m=0\), the finite length window is
empty, so

\[
B_0(c)=\varnothing.
\]

If \(m=1\) and \(c=0\), then the only candidate is time one. Since \(Y_1=0\)
and the comparison is strict,

\[
B_1(0)=\varnothing.
\]

These are semantic choices, not artifacts of Lean syntax.

## Null measurability is enough

Each \(Y_n\) is integrable under measure preservation. Integrability supplies
almost-everywhere strong measurability, so the strict sublevel set

\[
\{\omega:Y_n(\omega)\lt cn\}
\]

is null measurable. A finite union of null measurable sets is null
measurable. Therefore \(B_m(c)\) is null measurable.

This deliberately does not claim ordinary measurability. A function represented
only up to a null set can define a set that is measurable after completion
without being measurable in the original sigma algebra. The integration API
used here accepts `NullMeasurableSet`, so strengthening the conclusion would
add an assumption without serving the proof.

In Lean, this step is
`IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_finiteCenteredBadBlockSet`.
It combines centered-process integrability, `nullMeasurableSet_lt`, and a
finite bi-union.

## Visit counts turn orbit geometry into a sum

Fix a counting horizon \(H\). Define

\[
N_H(\omega)
{} :=
\#\{j\in\{0,\ldots,H-1\}:T^j\omega\in B_m(c)\}.
\]

This natural-valued count is total at \(H=0\), where it equals zero. Its real
cast has an exact additive representation:

\[
N_H(\omega)
{} =
\sum_{j=0}^{H-1}\mathbf 1_{B_m(c)}(T^j\omega).
\]

The equality is finite combinatorics. It needs no measure, measurable space,
or dynamical hypothesis. The right side is a Birkhoff sum of the real-valued
indicator.

{{< reference-figure
  wide="true"
  src="visits-as-indicator-sum.svg"
  alt="An orbit prefix with H positions contains marked and unmarked starts. Each marked start contributes indicator value one, each unmarked start contributes zero, and summing those indicator values gives the natural visit count after casting to the reals."
  caption="The visit count is exactly an indicator Birkhoff sum. Position, labels, and filled marker shapes all distinguish visits, so the meaning does not depend on color. The displayed orbit is a toy pattern, not an empirical frequency."
>}}

Under finite total measure, null measurability makes the indicator integrable.
Measure preservation gives the same integral at every orbit translate. Hence

\[
\begin{aligned}
\int_\Omega N_H\,d\mu
&=\sum_{j=0}^{H-1}
  \int_\Omega\mathbf 1_{B_m(c)}(T^j\omega)\,d\mu(\omega)\\
&=H\,\mu_{\mathbb R}(B_m(c)).
\end{aligned}
\]

The corresponding public declarations separate the combinatorial and
measure-theoretic layers:

- `finiteOrbitVisitCount` defines the natural count;
- `natCast_finiteOrbitVisitCount_eq_birkhoffSum_indicator` proves its exact
  real cast identity; and
- `integral_finiteOrbitVisitCount` integrates the count under finite measure,
  preservation, and null measurability.

Finite total mass matters here because it makes every bounded indicator
integrable and keeps `Measure.real` informative. Without finiteness, both the
real projection and the Bochner integral have totalized boundary behavior
that can collapse an infinite-mass identity to \(0=0\).

## One witness at every marked start

Suppose \(j\lt H\) is marked, meaning

\[
T^j\omega\in B_m(c).
\]

By definition there exists at least one length \(n\) with

\[
1\le n\le m,
\qquad
Y_n(T^j\omega)\lt cn.
\]

The finite bad-block set records existence but not a preferred witness. The
packing theorem needs a length function, so the proof chooses one witness
\(\ell(j)\) for each marked start. At unmarked starts it uses a harmless
default. Every property of the default is irrelevant because later premises
are quantified only over marked starts.

This separation prevents a common proof error. The algorithm does not choose
one globally optimal length, and it does not need the shortest witness. It
needs only one positive length at most \(m\) whose local centered cost is
favorable.

{{< reference-figure
  wide="true"
  src="witnesses-to-greedy-packing.svg"
  alt="Several marked orbit starts each offer one or more admissible short block lengths. One witness is selected at each mark, then a left-to-right greedy procedure keeps disjoint intervals whose union covers every marked start, even when one selected interval covers later marks."
  caption="Existential bad-block membership becomes usable geometry only after one witness length is selected at each marked start. Greedy selection keeps disjoint intervals and covers all marks; it does not retain every proposed interval or optimize total length."
>}}

## Greedy packing controls the buffered horizon

The selected intervals begin before \(H\) and have length at most \(m\). RMT-21
packs them from left to right inside an ambient horizon of length \(H+m\).
The packing covers every marked start. Its intervals are disjoint, and every
selected interval begins at a mark with centered cost at most its length times
\(c\).

For positive lengths, the centered process is nonpositive. This allows every
uncovered gap to be deleted from an upper bound. Shifted subadditivity then
splits the ambient process across gaps and selected intervals. If \(c\le0\),
covering at least as many time positions as there are marked starts reverses
in the useful direction after multiplication by \(c\). The result is

\[
Y_{H+m}(\omega)
\le cN_H(\omega).
\]

This is
`IsIntegrableSubadditiveProcessCandidate.centeredProcess_le_badBlockVisitCount`.
Although its receiver carries integrability, this pointwise argument uses only
shifted subadditivity and positive-time nonpositivity.

{{< reference-figure
  src="buffered-horizon-and-zero-corner.svg"
  alt="Marked starts occupy the first H orbit positions, selected blocks extend by at most m positions, and the packing therefore sits inside an H plus m ambient horizon. Separate boundary panels show that H zero with positive m is valid, while the joint H zero and m zero corner can fail because the centered time-zero value equals X zero."
  caption="The buffer of length m accommodates every selected block. The only excluded corner is the joint zero horizon: when both H and m vanish, the left side is the unconstrained time-zero value while the visit-count side is zero."
>}}

The premise \(H+m\ne0\) is necessary. If \(H=0\) but \(m\gt0\), there are no
marks and the inequality reduces to \(Y_m\le0\), which is valid. If \(m=0\)
but \(H\gt0\), the bad set is empty and the inequality reduces to
\(Y_H\le0\), also valid. At the joint corner \(H=m=0\), however,

\[
Y_0=X_0
\]

can be positive while the right side is zero. The frozen source compiles this
countermodel with a process positive only at time zero.

The horizon \(H+m\) is safe rather than minimal. A start in
\(\{0,\ldots,H-1\}\) and a length at most \(m\) cannot escape it. The finite
buffer disappears after normalization as \(H\) grows.

## Integrate before taking the horizon limit

Write

\[
q:=\mu_{\mathbb R}(B_m(c)),
\qquad
I_n:=\int_\Omega Y_n\,d\mu.
\]

Assume a real number \(\delta\) satisfies

\[
\delta\le\frac{I_n}{n}
\qquad\text{for every }n\gt0.
\]

The pointwise packing inequality and exact visit-count integral give, for
positive \(H\),

\[
I_{H+m}
\le cHq.
\]

The lower-rate premise at the same enlarged horizon gives

\[
\delta(H+m)
\le I_{H+m}.
\]

Combining them,

\[
\delta(H+m)
\le cHq.
\]

There is no samplewise limit here. For every fixed \(H\), both sides arose
from finite sums, finite packing, and ordinary real integration.

## Why both signs are forced

At time one, \(Y_1=0\). Therefore

\[
\delta
\le\frac{\int Y_1\,d\mu}{1}
{} =0.
\]

The theorem assumes \(c\lt\delta\), so

\[
c\lt\delta\le0.
\]

In particular, \(c\lt0\). This sign is not cosmetic. Dividing an inequality
by a negative number reverses its direction. For \(H\gt0\), divide the finite
inequality by \(cH\) to obtain

\[
q
\le
\frac{\delta}{c}
\left(1+\frac{m}{H}\right).
\]

Because

\[
\frac{H}{H+m}\longrightarrow1,
\]

the equivalent Lean arrangement passes to

\[
\delta\le cq,
\]

then uses negative division one final time:

\[
q\le\frac{\delta}{c}.
\]

{{< reference-figure
  wide="true"
  src="integrate-divide-and-limit.svg"
  alt="A four-stage proof ladder begins with the pointwise packed inequality, replaces visit counts by horizon times bad-set measure after integration, records that both the threshold and lower rate are nonpositive, reverses the inequality when dividing by the negative threshold, and finally removes the finite m buffer as H grows."
  caption="The order of operations matters: integrate the finite inequality, establish the signs, divide with reversal, and only then send the auxiliary horizon to infinity. No limit of sample observables is integrated, and no integral is moved through a limit."
>}}

The core ratio algebra actually needs only \(c\lt0\). The stronger premise
\(c\lt\delta\) gives the downstream fact

\[
0\le\frac{\delta}{c}\lt1.
\]

That strict subunit bound is the feature a later ergodic zero-one argument can
use on a probability space. RMT-30 records the stronger target-facing
premise, but it does not perform that zero-one argument.

## Finite-measure scaling

No probability instance appears in the generic theorem. Let \(a\gt0\) and
replace \(\mu\) by \(a\mu\). Then

\[
I_n^{(a\mu)}=aI_n^{(\mu)},
\qquad
\mu_{\mathbb R}^{(a\mu)}(B_m(c))=a\mu_{\mathbb R}^{(\mu)}(B_m(c)).
\]

A compatible lower rate scales as \(\delta^{(a\mu)}=a\delta^{(\mu)}\), so the
ratio conclusion scales on both sides:

\[
a\mu_{\mathbb R}^{(\mu)}(B_m(c))
\le
\frac{a\delta^{(\mu)}}{c}.
\]

The comparison \(c\lt\delta\) itself is not invariant under rescaling because
\(c\) is a pointwise slope while \(\delta\) is built from raw integrals. This
is not a contradiction. It is a reminder that probability normalization gives
the later subunit ratio its canonical interpretation. The frozen source
compiles a mass-two measure specifically to show that the finite theorem does
not silently require mass one.

The theorem also compiles on a nonergodic two-point identity system with a
genuinely nonempty bad set. One atom follows the centered process
\(Y_n=-(n-1)\), the other follows \(Y_n=0\), and both atoms have mass \(1/2\).
At \(m=5\), \(c=-3/4\), and \(\delta=-1/2\), the bad set is exactly the first
atom and the theorem proves the nontrivial ratio \(1/2\le2/3\). The finite
estimate uses preservation, not orbit indecomposability. Ergodicity belongs
to the next logical layer.

## Cocycle specialization

Let \(C\) be a discrete matrix cocycle and define the log-positive process

\[
X_n(\omega)=\log^+\lVert C(n,\omega)\rVert_\infty.
\]

Its finite centered bad-block set is
`DiscreteMatrixCocycle.centeredLogPlusBadBlockSet`. The existing one-step
log-positive integrability hypothesis packages \(X\) as an integrable
subadditive candidate.

Let

\[
\delta_C
{} :=
\gamma^+_\mu(C)-\int_\Omega X_1\,d\mu,
\]

where \(\gamma^+_\mu(C)\) is the deterministic integrated Fekete rate. The
Fekete lower-bound interface gives, for every positive \(n\),

\[
\gamma^+_\mu(C)
\le\frac1n\int_\Omega X_n\,d\mu.
\]

The centered integral identity then yields

\[
\delta_C
\le
\frac1n\int_\Omega Y_n\,d\mu.
\]

Therefore every \(c\lt\delta_C\) satisfies

\[
\mu_{\mathbb R}\bigl(B^{C}_m(c)\bigr)
\le
\frac{\delta_C}{c}.
\]

{{< reference-figure
  src="generic-ratio-to-cocycle.svg"
  alt="A generic finite-measure theorem receives an integrable centered subadditive process and a lower bound for every normalized centered integral. The cocycle lane supplies those inputs from log-positive norm observables, the one-step integrability hypothesis, the centered integral identity, and the deterministic Fekete lower bound."
  caption="The cocycle theorem is a specialization of the generic finite ratio. Fekete controls normalized integrals, not samplewise limits; the centered identity subtracts the one-step integral; no ergodicity or matrix-index inhabitant is introduced."
>}}

This theorem is
`DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusBadBlockSet_le_rateRatio`.
It remains valid for an empty finite matrix index. The proof never chooses a
matrix coordinate.

## The exact public interface

The frozen RMT-30 module exposes nine declarations in dependency order:

| Declaration | Mathematical role |
|---|---|
| `finiteOrbitVisitCount` | Counts visits to a set in the orbit prefix of length \(H\) |
| `natCast_finiteOrbitVisitCount_eq_birkhoffSum_indicator` | Identifies the real cast with an indicator Birkhoff sum |
| `integral_finiteOrbitVisitCount` | Computes the visit-count integral as \(H\mu_{\mathbb R}(s)\) |
| `finiteCenteredBadBlockSet` | Defines the finite strict union over lengths \(1\) through \(m\) |
| `IsIntegrableSubadditiveProcessCandidate.nullMeasurableSet_finiteCenteredBadBlockSet` | Proves null measurability under preservation |
| `IsIntegrableSubadditiveProcessCandidate.centeredProcess_le_badBlockVisitCount` | Gives the pointwise buffered-horizon packing inequality |
| `IsIntegrableSubadditiveProcessCandidate.measureReal_finiteCenteredBadBlockSet_le_rateRatio` | Proves the generic finite-measure ratio |
| `DiscreteMatrixCocycle.centeredLogPlusBadBlockSet` | Names the cocycle bad-block event |
| `DiscreteMatrixCocycle.HasIntegrableGeneratorLogPlus.measureReal_centeredLogPlusBadBlockSet_le_rateRatio` | Specializes the ratio to the integrated log-positive Fekete offset |

The source then compiles nine boundary probes: zero length cap, zero counting
horizon with positive cap, zero process, the false joint zero corner, zero
measure, a nonergodic identity with an exact half-mass bad set and nontrivial
ratio, equality at the strict time-one threshold, finite mass rescaling, and
the empty-index cocycle signature. Several private model definitions support
those nine examples. Six axiom reports audit the principal theorem chain.

## What is proved, and what is not

The checked layer proves:

- finite orbit-visit counting and its exact indicator-sum identity;
- exact integration of a finite visit count under finite measure and
  preservation;
- null measurability of finite centered bad-block sets;
- a pointwise greedy-packing bound on the buffered horizon;
- a generic finite-measure bad-set ratio; and
- the corresponding log-positive cocycle specialization.

It does not prove:

- a lower liminf inequality;
- almost-everywhere convergence of \(X_n/n\);
- the full subadditive ergodic theorem;
- equality with the integrated Fekete rate;
- convergence in \(L^1\);
- interchange of a limit and an integral;
- ergodicity of \(T\) or of any powered map;
- a signed logarithmic growth rate;
- a Lyapunov exponent;
- an Oseledets splitting; or
- any quantitative convergence rate.

The next mathematical layer can study a lower-liminf event, prove its
one-sided almost invariance, apply ergodic zero-one rigidity, and combine that
lower estimate with RMT-29. None of those steps is hidden inside RMT-30.

## Thirty solved exercises

### Exercise 1: identify the center

Why is \(Y_n\) not expectation-centered?

**Solution.** It subtracts the samplewise Birkhoff sum of \(X_1\), not a
constant such as \(n\int X_1\,d\mu\). The construction is pointwise before
integration.

### Exercise 2: compute time one

Show that \(Y_1=0\).

**Solution.** The one-term Birkhoff sum of \(X_1\) is exactly \(X_1\), so the
difference vanishes.

### Exercise 3: find the positive-time sign

Why is \(Y_n\le0\) for \(n\gt0\)?

**Solution.** Iterating shifted subadditivity bounds \(X_n\) by the orbit sum
of \(X_1\). Subtracting that majorant gives a nonpositive remainder.

### Exercise 4: evaluate the zero cap

What is \(B_0(c)\)?

**Solution.** The candidate interval \(1\le n\le0\) is empty, so the union is
empty.

### Exercise 5: inspect strict equality

Does \(Y_n=cn\) mark a block?

**Solution.** No. Membership uses \(Y_n\lt cn\), not a non-strict comparison.

### Exercise 6: check the time-one threshold

Compute \(B_1(0)\).

**Solution.** The only candidate has \(Y_1=0\), which is not strictly below
zero. Hence the set is empty.

### Exercise 7: locate null measurability

Why does integrability of \(Y_n\) suffice for the strict sublevel set?

**Solution.** Integrability gives almost-everywhere measurability, and a strict
comparison of almost-everywhere measurable real functions defines a null
measurable set.

### Exercise 8: reject an unnecessary strengthening

Why not claim ordinary measurability of \(B_m(c)\)?

**Solution.** The available functions are controlled up to null sets, and the
integration lemmas consume null measurability directly. Ordinary measurability
would require extra hypotheses.

### Exercise 9: compute a visit count

If an orbit prefix of length five visits the bad set at positions one, two,
and four, what is \(N_5\)?

**Solution.** It is three because exactly three filtered indices remain.

### Exercise 10: cast the count

Why does the real cast equal an indicator sum?

**Solution.** Every retained index contributes one and every rejected index
contributes zero. Summing these real values gives the cardinality cast.

### Exercise 11: evaluate horizon zero

What is \(N_0\)?

**Solution.** The range of candidate orbit positions is empty, so the count is
zero.

### Exercise 12: integrate one indicator translate

Why does
\(\int\mathbf 1_B(T^j\omega)\,d\mu=\mu_{\mathbb R}(B)\)?

**Solution.** The iterate \(T^j\) preserves \(\mu\), and the finite-measure
indicator integral equals the real measure of the null measurable set.

### Exercise 13: integrate the whole count

Compute \(\int N_H\,d\mu\).

**Solution.** There are \(H\) translated indicator terms, each with integral
\(\mu_{\mathbb R}(B)\), giving \(H\mu_{\mathbb R}(B)\).

### Exercise 14: choose a witness

What properties must \(\ell(j)\) satisfy at a marked start?

**Solution.** It must obey \(1\le\ell(j)\le m\) and
\(Y_{\ell(j)}(T^j\omega)\lt c\ell(j)\).

### Exercise 15: justify the default

Why may the length function use an arbitrary default at unmarked starts?

**Solution.** Every later length and cost premise is restricted to the marked
finite set. The default is never selected by the packing proof.

### Exercise 16: explain greedy coverage

Why may one chosen interval cover several marks?

**Solution.** Coverage asks every marked position to lie in the selected union,
not to begin its own retained interval. A longer early interval can cover later
marks.

### Exercise 17: locate the coefficient sign

Why does the marked-cardinality comparison require \(c\le0\)?

**Solution.** The packing covers at least as many positions as there are marks.
Multiplication by a nonpositive number reverses that cardinality inequality.

### Exercise 18: explain the buffer

Why use the ambient horizon \(H+m\)?

**Solution.** Every marked start is below \(H\), and every chosen block has
length at most \(m\). The extra buffer contains all selected intervals.

### Exercise 19: test zero counting horizon

What remains when \(H=0\) and \(m\gt0\)?

**Solution.** The visit count is zero and the pointwise inequality becomes
\(Y_m\le0\), which is true at positive time.

### Exercise 20: expose the false corner

Why can \(H=m=0\) fail?

**Solution.** The left side is \(Y_0=X_0\), which need not be nonpositive,
while the right side is the zero visit count multiplied by \(c\).

### Exercise 21: integrate the packing bound

Derive the finite integral inequality.

**Solution.** Integrate \(Y_{H+m}\le cN_H\), then substitute the exact count
integral to obtain \(I_{H+m}\le cHq\).

### Exercise 22: insert the lower rate

How does \(\delta\le I_n/n\) apply at the buffered horizon?

**Solution.** For positive \(H\), the horizon \(H+m\) is positive, so
\(\delta(H+m)\le I_{H+m}\).

### Exercise 23: force the sign of delta

Why must \(\delta\le0\)?

**Solution.** Apply the lower-rate premise at \(n=1\). Since \(Y_1=0\), its
normalized integral is zero.

### Exercise 24: force the sign of c

Why does \(c\lt\delta\) imply \(c\lt0\)?

**Solution.** Combine \(c\lt\delta\) with \(\delta\le0\).

### Exercise 25: divide correctly

Starting from \(\delta(H+m)\le cHq\), which direction follows after division
by \(cH\)?

**Solution.** Since \(cH\lt0\), the order reverses and gives
\(q\le(\delta/c)(1+m/H)\).

### Exercise 26: remove the buffer

What happens to \(1+m/H\) as \(H\to\infty\)?

**Solution.** The fixed ratio \(m/H\) tends to zero, so the factor tends to
one and the bound becomes \(q\le\delta/c\).

### Exercise 27: distinguish the limit

Which object tends to a limit in RMT-30?

**Solution.** Only the elementary scalar coefficient built from \(H\) and
\(m\). The proof does not show that \(Y_n(\omega)/n\) converges.

### Exercise 28: rescale the measure

Under \(\mu\mapsto a\mu\), how should \(q\) and \(\delta\) scale?

**Solution.** Both scale by \(a\), so the ratio theorem remains homogeneous
when the lower-rate witness is rescaled with the raw integrals.

### Exercise 29: locate ergodicity

Where is ergodicity used in the generic measure ratio?

**Solution.** Nowhere. Finite mass, preservation, integrability,
subadditivity, and the lower-rate premise suffice.

### Exercise 30: state the cocycle summit

Give the strongest honest cocycle conclusion in one sentence.

**Solution.** On any finite preserved base, an integrable log-positive matrix
cocycle has each finite centered strict bad-block set bounded in real measure
by the integrated Fekete offset divided by any strictly lower threshold, with
no ergodicity or samplewise convergence conclusion.

## Continue from finite caps to every positive length

This chapter supplies a bound for each fixed length cap. The next textbook
step proves that the caps form an increasing family, identifies their union
with the existence of one positive finite witness, and passes the same
uniform ratio through continuity from below. Read
[From Finite Centered Bad-Block Bounds to All-Positive-Length Control]({{< relref "/knowledge-base/deep-dives/from-finite-centered-bad-block-bounds-to-all-positive-length-control" >}})
for that measure-theoretic bridge, or use the paired
[RMT-31 Development Notebook]({{< relref "/development-notebook/2026/07/all-positive-length-centered-bad-block-control-in-lean" >}})
for the exact Lean declaration and countermodel ledger.

## Proof reproduction

From the repository root, run:

```text
cd formalization
lake build NonlinearDynamics.Random.RandomCocycles.SubadditiveBadBlockMeasure
```

For the complete project and teaching checks, run:

```text
make check
```

The companion Development Notebook gives the exact source-order ledger,
boundary-probe code, and axiom reports.

## References

<a id="ref-bad-deep-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://academic.oup.com/jrsssb/article/30/3/499/7026968),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968,
[doi:10.1111/j.2517-6161.1968.tb00749.x](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x).
This is the primary source for the full theorem whose lower-liminf component
RMT-30 does not yet prove.

<a id="ref-bad-deep-steele"></a>**J. Michael Steele.**
[Kingman's subadditive ergodic theorem](https://www.numdam.org/item/AIHPB_1989__25_1_93_0/),
*Annales de l'Institut Henri Poincare, Probabilites et Statistiques* 25(1),
93-98, 1989. Steele presents an interval-decomposition proof of the full
theorem. RMT-30 formalizes only the finite bad-block measure bridge isolated
in this chapter.

<a id="ref-bad-deep-mathlib-indicator"></a>**Mathlib contributors.**
[Indicator integration](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Integral/Bochner/Set.lean),
Mathlib commit `81a5d257`. The pinned library supplies the null-measurable
indicator integration interface used by the checked proof.

<a id="ref-bad-deep-mathlib-limit"></a>**Mathlib contributors.**
[Elementary limits at infinity](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/SpecificLimits/Basic.lean),
Mathlib commit `81a5d257`. The exact checked source uses the pinned theorem
`tendsto_natCast_div_add_atTop` for the auxiliary horizon coefficient.
