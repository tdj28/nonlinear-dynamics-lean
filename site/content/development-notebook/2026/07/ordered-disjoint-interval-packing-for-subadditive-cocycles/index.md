---
title: "Pack the Marked Starts: Ordered Disjoint Intervals for Subadditive Cocycles in Lean"
slug: "ordered-disjoint-interval-packing-for-subadditive-cocycles"
date: 2026-07-21
weight: -53
author: "tdj28"
summary: "A gap-indexed Lean packing builds positive-length half-open intervals with ordering and disjointness by construction, selects a subfamily that covers every marked start, and turns per-start favorable costs into finite weak and strict marked-card bounds while keeping every asymptotic theorem outside scope."
lead: |
  A long orbit may contain many starts with a favorable short interval, but those intervals can overlap. RMT-21 chooses them from left to right, keeps an ordered disjoint subfamily whose union still covers every marked start, and charges a nonpositive shifted-subadditive process to the chosen intervals. The result is finite combinatorics and finite algebra: singleton intervals and zero gaps are legal, empty marks retain a weak conclusion at positive enlarged horizon, and no density or limit theorem is invoked.
key_result: |
  From marks below H and prescribed positive lengths at most m, the checked selector returns a packing in the enlarged horizon H+m. SelectedFrom certifies the origin and exact length of every chosen interval; Covers certifies that no marked start is missed. Those separate facts lift per-marked-start cost bounds to packing costs and then to bounds in terms of the number of marked starts. The weak marked-card result covers the empty set when H+m is nonzero; the strict result requires marked.Nonempty and derives that positivity. The raw process inequality excludes the empty packing at horizon zero because no premise controls the process at time zero.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Finite half-open intervals, gap-indexed recursion, greedy covering, exact cardinality, shifted subadditivity, favorable costs, and matrix-cocycle specialization"
reading_time: "135 to 190 minutes"
prerequisites:
  - "Finite phase averaging for positive-horizon nonpositive shifted-subadditive processes"
  - "Finite sets, natural-number intervals, and strong induction"
  - "Natural iteration and the project convention for shifted subadditivity"
  - "Orbit-majorant centering and the centered log-positive cocycle observable"
  - "No probability, density theorem, maximal inequality, ergodic theorem, or limit theorem required"
  - "No prior Lean proof experience required"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveIntervalPacking"
lean_source: "formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveIntervalPacking.lean"
tags:
  - "Lean 4"
  - "Subadditive processes"
  - "Matrix cocycles"
  - "Ordered interval packing"
  - "Half-open intervals"
  - "Greedy selection"
  - "Finite coverings"
  - "Boundary cases"
og_image: "ordered-disjoint-interval-packing-for-subadditive-cocycles-card.png"
og_image_alt: "Warm-paper teaching card showing marked orbit positions and three ordered nonoverlapping half-open intervals chosen from left to right. A side panel says empty marks have a weak bound only when the enlarged horizon is positive; a second panel reserves strictness for nonempty marks. The footer says no density or limit theorem is proved."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed Research Note. Verify claims against the cited primary
sources and any released artifacts before relying on them.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This teaching chapter is published as an open working
note while human
editorial acceptance and the separate scientific-integrity and zero-context
expert-reader reviews are pending. The checked Lean source is authoritative
for every theorem statement.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** Let \(T:\Omega\to\Omega\) and let
\(X_n(\omega)\in\mathbb R\) satisfy the shifted-subadditive law

\[
X_{a+b}(\omega)
\le
X_b\bigl(T^a\omega\bigr)+X_a(\omega).
\]

Assume also that \(X_n(\omega)\le0\) whenever \(n\ne0\). RMT-21 first
constructs a finite combinatorial object: an ordered packing of positive-length
half-open natural intervals inside a horizon. Its constructors store the gap
before an interval, the interval length, and a recursively shifted tail.
Consequently order, containment, disjointness, zero gaps, abutment, and a
terminal gap are properties of the data rather than a separate consistency
record.

Given a finite set \(B\subseteq\{0,\ldots,H-1\}\), a bound \(m\), and a
chosen length \(\ell(j)\) with

\[
0\lt\ell(j)\le m
\qquad\text{for every }j\in B,
\]

a leftmost greedy construction produces a packing in the enlarged horizon
\(H+m\). Every selected interval begins at a marked start and has exactly the
prescribed length there. At the same time, the selected union covers every
marked start. These are two different certificates, named
<code>SelectedFrom</code> and <code>Covers</code>.

The module then attaches a process cost to each selected interval. Repeated
subadditivity splits the whole horizon around the selected intervals. Only
positive gaps are discarded, so the proof does not use \(X_0\le0\). If the
coefficient \(c\le0\) and every marked interval satisfies

\[
X_{\ell(j)}\bigl(T^j\omega\bigr)
\le c\,\ell(j),
\]

the weak theorem yields

\[
X_{H+m}(\omega)\le c\,|B|,
\]

provided \(H+m\ne0\). The statement is valid even when \(B\) is empty.
Replacing the local weak inequalities by strict ones gives a strict global
bound only when \(B\) is nonempty. That premise is necessary: strict local
hypotheses are vacuous on the empty set, while an empty sum cannot be strictly
less than itself.

Candidate, centered-process, and matrix-cocycle wrappers expose the same finite
packing inequality. They add no probability, ergodicity, density estimate,
maximal inequality, pointwise Birkhoff theorem, Kingman theorem,
almost-everywhere limit, Lyapunov exponent, or Oseledets splitting.
{{< /panel >}}

This is the proof-to-prose companion for
<code>formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveIntervalPacking.lean</code>.
It covers all fifty-four public named declarations, the private selector engine,
and all twelve private named boundary fixtures in exact source order. Anonymous
compiled examples are audited together in the boundary section.

Its immediate predecessor is
[Average the Phases: Sliding-Block Bounds for Subadditive Cocycles in Lean]({{< relref "/development-notebook/2026/07/phase-averaged-sliding-block-bounds-for-subadditive-cocycles" >}}).
That chapter supplies a complementary finite upper mechanism. The compact
definition here is the
{{< refterm "ordered-interval-packing" "ordered interval packing" >}}
glossary entry. The parallel textbook treatment is
[Finite Ordered Interval Packing for Nonpositive Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-ordered-interval-packing-for-nonpositive-subadditive-processes" >}}).

Its immediate successor is
[Convergence Without Existence: Birkhoff Events and Ergodic Rigidity in Lean]({{< relref "/development-notebook/2026/07/birkhoff-convergence-events-and-ergodic-rigidity-in-lean" >}}).
That chapter isolates a measurable or null-measurable convergence event for
one-step Birkhoff averages and proves its exact finite-prefix invariance and
conditional ergodic rigidity. It does not yet make the marked set here large.

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| First encounter | [Why favorable starts overlap](#why-favorable-starts-overlap) | See the finite selection problem before the Lean type |
| Geometry route | [The gap-length-tail code is already a proof](#the-gap-length-tail-code-is-already-a-proof) | Understand order, disjointness, and abutment structurally |
| Selector route | [The leftmost selector covers every marked start](#the-leftmost-selector-covers-every-marked-start) | Follow strong induction and filtered remaining marks |
| Counting route | [Disjointness turns union size into covered length](#disjointness-turns-union-size-into-covered-length) | Derive the marked-cardinality bridge |
| Dynamics route | [The finite subadditive packing inequality](#the-finite-subadditive-packing-inequality) | Split the process and delete only positive gaps |
| Boundary route | [Weak for every marked set, strict only when marks exist](#weak-for-every-marked-set-strict-only-when-marks-exist) | See why empty, singleton, and abutting cases determine the API |
| API route | [The complete source-order tour](#the-complete-source-order-tour) | Audit every named declaration |
| Lean route | [How Lean executes the finite proof](#how-lean-executes-the-finite-proof) | Read recursion, strong induction, iteration, and arithmetic |
| Integrity route | [What interval packing still does not prove](#what-interval-packing-still-does-not-prove) | Block every asymptotic overread |

### Learning objectives

By the summit, a reader should be able to:

1. translate an inclusive integer interval into a half-open natural interval;
2. explain why positive length admits a singleton interval;
3. explain why endpoint equality permits two half-open intervals to abut;
4. read the horizon index of <code>OrderedNatIntervalPacking</code>;
5. distinguish a prefix gap, selected length, recursive tail, and terminal gap;
6. recover absolute endpoints from recursively relative gaps;
7. distinguish the interval list from the finite set of covered positions;
8. prove that recovered interval count equals the structural interval count;
9. explain why structural order implies pairwise set disjointness;
10. derive exact covered cardinality from disjoint finite unions;
11. distinguish <code>Covers</code> from <code>SelectedFrom</code>;
12. explain why selector provenance needs an absolute recursive offset;
13. state the enlarged-horizon selector theorem;
14. justify \(H+m\) from \(j\lt H\) and \(\ell(j)\le m\);
15. describe the leftmost-mark filtering rule;
16. explain why every deleted mark remains covered;
17. explain the branch in which the first interval crosses the old horizon;
18. explain why selected endpoints are strictly below the enlarged horizon;
19. define the cost of a packing;
20. distinguish one interval cost from a pointwise sum over its covered sites;
21. transport per-marked-start estimates through <code>SelectedFrom</code>;
22. sum weak interval estimates over an empty or nonempty packing;
23. explain why strict summation needs a nonempty packing;
24. derive horizon positivity from nonzero interval count;
25. split and discard only positive gaps in the process inequality;
26. reproduce the time-zero countermodel;
27. turn coverage into \(|B|\le L\), where \(L\) is covered length;
28. explain why multiplication by \(c\le0\) reverses that comparison;
29. state both covered-length process bounds;
30. state both marked-cardinality process bounds;
31. state both end-to-end greedy-cover bounds;
32. identify the extra horizon premise on the universal weak greedy theorem;
33. identify the nonempty-mark premise on the strict greedy theorem;
34. separate wrapper fields from fields used by a pointwise proof;
35. explain why the empty matrix index remains allowed;
36. list every asymptotic claim that this finite module deliberately does not make.

## Why favorable starts overlap

The lower-estimate stage of a classical subadditive argument begins with a
finite set of orbit positions where some short interval has favorable average
cost. At a marked position \(j\), choose a positive length \(\ell(j)\le m\).
The associated half-open interval is

\[
I_j=[j,j+\ell(j)).
\]

Keeping every \(I_j\) is usually impossible because they may overlap. Yet
discarding intervals arbitrarily can lose the coverage needed to compare total
selected length with the number of marked starts.

Lalley's lecture notes use a leftmost rule: keep the interval at the leftmost
remaining marked start, delete every candidate whose left endpoint is already
inside that interval, then repeat ([Lalley](#ref-rmt21-lalley)). A deleted
start is not forgotten. It is covered by the interval that caused its deletion.
The next retained start lies at or to the right of the previous right endpoint,
so the retained half-open intervals are disjoint.

{{< panel "warning" >}}
**Two endpoint corrections matter.** Lalley's displayed equation (6) uses
inclusive intervals \([j,j+k-1]\). A positive length \(k=1\) is the singleton
\([j,j]\), but the displayed strict comparison \(j\lt j+k-1\) excludes it.
The following selection explicitly allows \(1\le k\le m\). In half-open form,
positive length is equivalent to \(j\lt j+k\). The inclusive separation
\(j+k-1\lt j'\) translates to \(j+k\le j'\), so equality means legal
abutment, not overlap. RMT-21 encodes these corrected half-open relations.
{{< /panel >}}

The Lean theorem is not a transcription of every later probabilistic step in
those notes. It isolates and checks only the finite selector, coverage,
cardinality, and subadditive-cost layer.

### What is inherited, repaired, and newly packaged

Three source roles must stay separate. Lalley's equation (6) motivates the
finite packed-process inequality, and the following paragraph motivates
leftmost selection. Steele supplies related algorithmic proof lineage for a
finite interval decomposition. Kingman's 1968 paper is the historical
asymptotic destination. None of those sources states the exact Lean interface
<code>Covers ∧ SelectedFrom</code>, the indexed gap representation, or the
weak-versus-strict empty-set API used here.

The endpoint repair can be verified extensionally. For \(k\gt0\),

\[
r\in[j,j+k-1]
\quad\Longleftrightarrow\quad
j\le r\le j+k-1
\quad\Longleftrightarrow\quad
j\le r\lt j+k
\quad\Longleftrightarrow\quad
r\in[j,j+k).
\]

Thus the repair preserves the set and its \(k\) integer positions. It changes
only the faulty strict start-to-last-point comparison. Likewise,

\[
j+k-1\lt j'
\quad\Longleftrightarrow\quad
j+k\le j',
\]

so the corrected separation relation is weak at the excluded endpoint.

RMT-21 then adds formal packaging needed by later code: exact interval and
covered-set decoders, a proof that covered cardinality equals summed length,
separate coverage and provenance contracts, weak and strict local-cost
predicates, a time-zero countermodel, and wrappers for the established
subadditive-process and cocycle layers. Those are checked elaborations of the
finite idea, not claims that the cited sources used the same data type or
theorem names.

## Half-open intervals encode the boundary convention

A half-open natural interval \([a,b)\) contains exactly those \(j\) with
\(a\le j\lt b\). It has \(b-a\) positions when \(a\le b\). This convention has
three advantages here:

1. length is the endpoint difference;
2. adjacent intervals \([a,b)\) and \([b,c)\) are disjoint; and
3. the horizon \([0,N)\) contains exactly the natural positions below \(N\).

Mathlib provides both <code>Finset.Ico</code> for finite covered positions and
<code>Set.Ico</code> for set-theoretic disjointness. The pinned definitions and
cardinality theorems are cited below
([finite interval definitions](#ref-rmt21-finset-intervals),
[natural interval cardinality](#ref-rmt21-finset-nat)).

The module stores endpoints as pairs of natural numbers. It does not introduce
a parallel interval structure. The packing itself carries the stronger
invariant that the pairs arise in chronological order with positive lengths.

## The gap-length-tail code is already a proof

The central type is indexed by its ambient horizon:

~~~lean
inductive OrderedNatIntervalPacking : ℕ → Type
  | empty (horizon : ℕ) : OrderedNatIntervalPacking horizon
  | cons (gap length : ℕ) {tail : ℕ} (length_pos : 0 < length)
      (rest : OrderedNatIntervalPacking tail) :
      OrderedNatIntervalPacking (gap + length + tail)
~~~

The empty constructor retains a horizon even though it selects no intervals.
The cons constructor lays out three consecutive regions:

- an uncovered gap, which may have length zero;
- one selected interval, whose length is strictly positive; and
- a recursively encoded tail.

The recursive tail begins after the first gap and interval. A gap stored in the
tail is therefore an intermediate gap in absolute coordinates. An empty value
at the end retains the terminal gap. No separate proposition is needed to say
that a later interval begins after the earlier one.

{{< reference-figure
  src="gap-length-tail-encoding.svg"
  alt="A horizon is split into a possibly zero prefix gap, one positive-length selected interval, and a shifted recursive tail containing later gaps and intervals. The terminal empty node retains the final uncovered horizon."
  caption="**Finding:** the recursive data layout is also the geometric invariant. Each selected interval has positive length. Gaps may be zero, so adjacent intervals may touch at one endpoint while remaining disjoint. The recursive tail starts only after the preceding selected interval, and the final empty node records the terminal gap. This is finite structure, not an asymptotic covering theorem."
>}}

Two elementary folds expose the packing size. <code>intervalCount</code> counts
constructors of the second kind. <code>coveredLength</code> adds their lengths.
Neither count includes any gap.

## Decode endpoints and covered positions

The packing stores relative gaps, but users need absolute starts. The helper
<code>intervalsFrom</code> carries an absolute offset through recursion. At a
cons node with gap \(g\) and length \(\ell\), it emits

\[
(\text{offset}+g,\ \text{offset}+g+\ell)
\]

and recurses from the emitted right endpoint. The public
<code>intervals</code> decoder starts at offset zero.

The finite-set decoder follows the same traversal. <code>coveredFinsetFrom</code>
unions the current <code>Finset.Ico</code> with the shifted tail. The public
<code>coveredFinset</code> again starts at zero.

The two views answer different questions:

| View | What it remembers | What it forgets |
|---|---|---|
| <code>intervals</code> | ordered endpoints and interval boundaries | pointwise union operations |
| <code>coveredFinset</code> | exactly which natural positions are covered | which selected interval supplied a position |
| <code>intervalCount</code> | number of selected intervals | endpoints and lengths |
| <code>coveredLength</code> | total selected length | number and placement of intervals |

Theorems connect the views. <code>length_intervalsFrom</code> and
<code>length_intervals</code> show that decoding preserves interval count.
The two membership equivalences state that a position belongs to the covered
finite set exactly when one recovered interval contains it. The shifted bounds
theorem then places every covered position inside the shifted horizon.

## Coverage and provenance are different contracts

For a finite marked set \(B\),

~~~lean
def Covers (P : OrderedNatIntervalPacking N) (marked : Finset ℕ) : Prop :=
  marked ⊆ P.coveredFinset
~~~

says only that every mark lies somewhere in the selected union. It does not say
that selected intervals began at marks. It does not say their lengths came from
the prescribed function. A large unrelated interval could satisfy
<code>Covers</code>.

The provenance predicate <code>SelectedFromFrom</code> supplies the missing
contract recursively. At an absolute offset, every cons node must begin at a
member of the eligible marked set and its stored length must equal the value of
the prescribed length function at that start. <code>SelectedFrom</code> is the
zero-offset public form.

This separation is not bureaucracy. The later proof uses each certificate for
a different purpose:

- <code>Covers</code> gives the cardinality comparison;
- <code>SelectedFrom</code> transports a cost hypothesis stated only at marked
  starts to every selected interval.

The monotonicity theorem permits a recursive certificate over a filtered set
of remaining marks to be widened back to the original set. The two
<code>intervals_chosen</code> theorems expose the recursive certificate in terms
of decoded endpoints. The enlarged-horizon endpoint theorem combines that
provenance with \(j\lt H\) and \(\ell(j)\le m\) to prove every selected right
endpoint is strictly below \(H+m\).

## The leftmost selector covers every marked start

Fix \(H,m\in\mathbb N\), a finite set \(B\subseteq\operatorname{range}(H)\),
and \(\ell:\mathbb N\to\mathbb N\) with \(0\lt\ell(j)\le m\) on \(B\).
The public selector states

\[
\exists P:\operatorname{Packing}(H+m),
\quad P\text{ covers }B
\quad\text{and}\quad
P\text{ is selected from }(B,\ell).
\]

The private engine proves an offset form by strong induction on the remaining
old-horizon length.

1. If the marked set is empty, return an empty packing with horizon \(H+m\).
2. Otherwise choose its minimum \(j\).
3. Let \(\ell=\ell(j)\).
4. If \(j+\ell\le\text{offset}+H\), filter the remaining marks to starts at
   least \(j+\ell\), then recurse on the shorter tail horizon.
5. If the interval crosses the old horizon, stop after this interval. Every
   remaining marked start lies between \(j\) and the interval endpoint.

The first branch is where abutment appears. A later start equal to \(j+\ell\)
survives the filter and may begin the next selected interval. That is correct
for half-open intervals.

The second branch is why the target horizon is enlarged. Because \(j\lt H\)
and \(\ell\le m\), the chosen endpoint still lies strictly below \(H+m\), even
when it passes the end of the old horizon.

At each deletion, coverage is local: a mark removed because it lies before
\(j+\ell\) belongs to the current interval. A mark that survives is covered by
the recursive packing. This induction proves coverage without a separate
maximality or optimality theorem.

## Trace one greedy run all the way through

The selector becomes easier to audit when the candidate set, deletion filter,
and type index are written side by side. Take

\[
H=10,\qquad m=4,\qquad
B=\{1,2,4,5,8,9\}.
\]

Use prescribed lengths \(\ell(1)=3\), \(\ell(4)=2\), and
\(\ell(8)=4\). The other marked starts may have any positive length at most
four because they will be removed before selection.

| Round | Remaining marks | Leftmost start | Selected interval | Marks retained by the endpoint filter |
|---:|---|---:|---|---|
| 1 | \(\{1,2,4,5,8,9\}\) | \(1\) | \([1,4)\) | \(\{4,5,8,9\}\) |
| 2 | \(\{4,5,8,9\}\) | \(4\) | \([4,6)\) | \(\{8,9\}\) |
| 3 | \(\{8,9\}\) | \(8\) | \([8,12)\) | stop in the crossing branch |

Round one removes one and two because both are below the endpoint four. The
mark four survives: the filter keeps starts satisfying \(4\le r\), exactly
matching membership outside the half-open interval \([1,4)\). Round two
removes four and five. The first two selected intervals abut, and the weak
endpoint comparison certifies that they remain disjoint.

Round three exposes the enlarged-horizon case. The endpoint twelve passes the
old endpoint ten. Every remaining mark is at least eight because eight is
minimal, and every one is below ten by the input bound. Therefore every
remaining mark lies in \([8,12)\), and recursion can stop.

The output packing has the run-length code

\[
(1,3),\ (0,2),\ (2,4),\ \text{tail }2.
\]

Reading those numbers gives an initial gap of one, selected length three,
zero gap, selected length two, gap two, selected length four, and terminal
tail two. The type index checks the entire sum:

\[
1+3+0+2+2+4+2=14=H+m.
\]

Its selected intervals cover

\[
\{1,2,3,4,5,8,9,10,11\},
\]

so the covered length is nine while \(|B|=6\). The three additional covered
positions are harmless. Coverage is the inclusion
\(B\subseteq P.\operatorname{coveredFinset}\), not equality of those finite
sets.

This trace mirrors the private induction engine almost line for line:

1. <code>marked.min'</code> produces the least start and its membership proof.
2. <code>marked.filter (j + ell ≤ ·)</code> records precisely the survivors.
3. A second comparison decides whether the endpoint remains within the old
   horizon.
4. In the recursive branch, <code>Finset.filter_subset</code> and
   <code>SelectedFromFrom.mono</code> widen tail provenance back to the
   original marked set.
5. In the crossing branch, minimality and the old start bound prove coverage
   directly.
6. <code>omega</code> proves both the strictly smaller induction index and the
   reconstructed \(H+m\) type index.

The deletion proof and the coverage proof are the same argument viewed from
opposite sides. If a candidate fails the survivor test, then it is below the
selected endpoint. Minimality puts it at or above the selected start. Those
two inequalities place it inside the current interval.

### Why deleted starts still carry length hypotheses

In the worked run, the selector never consults the prescribed lengths at two,
five, or nine. The public theorem nevertheless assumes a positive bounded
length at every original mark. This is intentional uniformity, not a hidden
claim that every length is used. Before execution, any marked start could
become the minimum of a recursive survivor set. The global hypothesis lets
each recursive call obtain its chosen length without rebuilding a new
partial function.

After selection, <code>SelectedFrom</code> records lengths only for intervals
that were actually kept. Likewise, the local-cost bridge consumes the
marked-start cost hypothesis only at selected starts. A deleted mark is
accounted for geometrically through coverage, not algebraically through its
own process term. This separation is why one long favorable interval can pay
for several marked starts without double-counting overlapping costs.

## Follow the cardinality sign reversal numerically

Suppose the common coefficient is \(c=-2\), and the selected local costs obey

\[
X_3(T^1\omega)\le-6,\qquad
X_2(T^4\omega)\le-4,\qquad
X_4(T^8\omega)\le-8.
\]

The recursive cost sum is at most \(-18\), which is
\(c\cdot9\), where nine is the covered length. Shifted subadditivity and
positive-time nonpositivity give

\[
X_{14}(\omega)
\le \operatorname{cost}(P)
\le -18.
\]

Coverage gives \(6\le9\). Since \(c\le0\), multiplying by \(c\) reverses the
comparison:

\[
-18=c\cdot9\le c\cdot6=-12.
\]

Consequently \(X_{14}(\omega)\le-12=c|B|\). The marked-card theorem is not
claiming that six selected intervals exist. It uses three selected intervals
covering six marks, nine covered positions, and one sign-aware multiplication
step.

In Lean, the relevant proof first obtains a natural-number inequality from
<code>card_le_coveredLength_of_covers</code>. The statement is moved into
\(\mathbb R\) with <code>exact_mod_cast</code>. Only then does
<code>mul_le_mul_of_nonpos_left</code> apply the hypothesis
<code>hc : c ≤ 0</code>. Keeping those stages separate makes the reversal
visible to the reader and the elaborator.

## Why the ambient horizon is \(H+m\)

The marked-start horizon controls starts, not endpoints. If \(j\lt H\) and
\(0\lt\ell(j)\le m\), then

\[
j+\ell(j)\lt H+m.
\]

The inequality is strict because \(j\le H-1\) when \(H\gt0\). The packing type
itself only promises endpoints at most its horizon; the selector provenance
proves the stronger strict endpoint bound.

Using horizon \(H\) would reject a legal marked start near its right edge.
Using an unbounded ambient horizon would erase a finite quantity required by
the later process inequality. The explicit \(H+m\) is a clean uniform choice:
it gives the strict endpoint bound above while keeping the degenerate
\(H=m=0\) case free of truncated subtraction. A sharper positive-horizon
encoding could use \(H+m-1\), but that refinement is not needed here.

The empty case remains informative. If \(H=m=0\), the selector exists and
returns an empty packing of horizon zero. The combinatorics are valid. A later
process inequality at that horizon is not valid unless time zero is separately
controlled.

## Disjointness turns union size into covered length

The shifted containment theorem shows every recovered interval lies inside its
ambient shifted horizon. The shifted pairwise theorem shows every earlier
right endpoint is at most every later left endpoint. Mapping this endpoint
relation to <code>Set.Ico</code> gives pairwise set disjointness.

The exact cardinality proof then follows the recursive representation. The
current interval contributes exactly its length. It is disjoint from the tail
covered set because every tail position begins at or beyond the current right
endpoint. Mathlib's disjoint-union cardinality theorem combines the two sizes
([finite-set cardinality](#ref-rmt21-finset-card)). Thus

\[
|\operatorname{coveredFinset}(P)|
=\operatorname{coveredLength}(P).
\]

If \(P\) covers \(B\), finite-set monotonicity gives

\[
|B|
\le
|\operatorname{coveredFinset}(P)|
{} =
\operatorname{coveredLength}(P).
\]

Coverage of a nonempty marked set also proves that the packing has nonzero
interval count. An empty packing covers no positions. This small lemma is the
bridge later used to obtain strict finite summation.

## From per-marked-start costs to recursive interval costs

For a map \(T\), process \(X\), sample \(\omega\), and coefficient \(c\), the
packing cost is

\[
\operatorname{cost}(P)
{} =
\sum_{I\text{ selected}}
X_{|I|}\bigl(T^{\operatorname{start}(I)}\omega\bigr).
\]

This display is explanatory. Lean defines the sum recursively so that every
tail is evaluated at the correctly shifted sample. It is not a sum of the
one-step values \(X_1\) over all covered positions.

The predicates <code>EveryIntervalCostLE</code> and
<code>EveryIntervalCostLT</code> mirror that recursion. Their empty branch is
<code>True</code>. At a cons node they assert a weak or strict linear bound for
the current selected interval and recur at the shifted sample.

The two offset bridge theorems are the key interface between selector and
dynamics. A <code>SelectedFromFrom</code> certificate identifies the current
absolute start and prescribed length. Natural-iterate addition aligns the
recursively shifted sample with that absolute start. The public zero-offset
bridges then state:

- weak bounds at every marked start imply
  <code>EveryIntervalCostLE</code> for the selected packing;
- strict bounds at every marked start imply
  <code>EveryIntervalCostLT</code>.

The strict predicate implies the weak predicate pointwise. Summing weak bounds
works for every packing, including empty. Summing strict bounds needs a nonzero
interval count.

## The finite subadditive packing inequality

Suppose \(X\) is shifted-subadditive and nonpositive at every positive horizon.
For a packing \(P\) inside \(N\ne0\), RMT-21 proves

\[
X_N(\omega)
\le
\operatorname{cost}(P,T,X,\omega).
\]

The direction can feel surprising. The selected interval costs may be
negative. Every uncovered positive gap also has nonpositive cost, so deleting
those gap terms makes the right side larger and preserves an upper bound.

The induction must avoid manufacturing a time-zero term. It treats three
places carefully:

1. If the initial gap is zero, do not split it off.
2. If the terminal tail is zero, stop at the final selected interval rather
   than splitting a zero tail.
3. If the recursive rest contains another positive-length interval, its
   horizon is positive even when its leading gap is zero.

This is why the raw theorem assumes only positive-horizon nonpositivity. It
does not impose \(X_0=0\) or even \(X_0\le0\).

For a nonempty packing, positive horizon follows from the selected
positive-length interval. The companion theorem therefore replaces the
explicit \(N\ne0\) premise by nonzero interval count.

Combining the process inequality with weak or strict interval-cost summation
gives bounds by covered length:

\[
X_N(\omega)
\le c\,\operatorname{coveredLength}(P)
\]

for weak local estimates, and a strict version for nonempty \(P\).

## Weak for every marked set, strict only when marks exist

Coverage gives \(|B|\le L\), where \(L\) is selected covered length. If
\(c\le0\), multiplication reverses this inequality:

\[
cL\le c|B|.
\]

That sign premise is essential. It is the finite algebra that turns a lower
bound on selected length into an upper bound on a negative process value.

The universal covering theorem is weak:

\[
X_N(\omega)\le c|B|.
\]

It accepts the empty marked set, but still requires \(N\ne0\). The end-to-end
greedy version uses \(N=H+m\) and exposes exactly that horizon premise.

The strict theorem has a different boundary:

\[
X_N(\omega)\lt c|B|.
\]

It requires \(B\) to be nonempty. Coverage then forces a nonempty packing,
which supplies both horizon positivity and at least one strict summand. The
end-to-end strict greedy theorem consequently needs no separate
\(H+m\ne0\) premise.

{{< reference-figure
  src="selected-starts-to-marked-card-bound.svg"
  alt="A dependency diagram separates coverage from interval provenance. Coverage yields a marked-count bound. Provenance carries per-marked-start costs to selected interval costs. Shifted subadditivity and positive-time nonpositivity bound the horizon by packing cost. A nonpositive coefficient combines the lanes; a nonempty-marks gate appears only on the strict route."
  caption="**Finding:** the final marked-card bound is a composition of independent finite facts. `Covers` controls cardinality, while `SelectedFrom` controls where each local cost hypothesis applies. Shifted subadditivity and positive-time nonpositivity compare the whole horizon with the packing cost. Multiplication by a nonpositive coefficient reverses the coverage-length inequality. The weak route accepts empty marks and retains a positive-horizon premise; the strict route requires nonempty marks."
>}}

### The empty-set counterexample

Let \(X_n=0\) at every positive time and let \(B=\varnothing\). Every strict
per-mark hypothesis is true because there is no marked \(j\). The greedy
packing is empty and both its cost and marked cardinality are zero. A universal
strict conclusion would demand \(0\lt0\), which is false.

This counterexample is not a corner to smooth over. It fixes the API: weak for
all finite marked sets, strict under <code>marked.Nonempty</code>.

## Proof dependencies versus wrapper baggage

The raw packing and process theorems use no measurable space, measure,
integrability, probability, or ergodicity. The public candidate wrappers are
methods on a stronger bundled object, so their receiver still carries finite
horizon integrability and a measure. The proof projects only shifted
subadditivity.

The centered-process wrapper additionally uses the already checked facts that
orbit-majorant centering preserves shifted subadditivity and is nonpositive at
positive horizons. It needs no time-zero normalization and no additional
measure-preservation witness.

The matrix-cocycle wrapper takes the cocycle directly. The cocycle already
stores a preserved base map, but the proof consumes only finite algebra and the
centered log-positive observable's subadditivity and sign. It does not require
the separate generator-integrability package. Empty matrix dimension remains
legal.

The current wrappers stop at the packing-sum inequality. The generic
marked-card and greedy theorems can be instantiated with the centered cocycle
observable without adding a separate wrapper for every composition.

## The complete source-order tour

The following map covers all sixty-seven named declarations in the frozen
1,131-line source. Items 30 and 56 through 67 are private. The compiled
anonymous examples after item 67 exercise the public surface and boundary
models.

### Items 1–7: the indexed packing and interval-list decoder

1. <code>OrderedNatIntervalPacking</code> is the horizon-indexed empty/cons
   representation.
2. <code>intervalCount</code> counts selected intervals.
3. <code>coveredLength</code> sums selected lengths.
4. <code>intervalsFrom</code> decodes endpoints from an absolute offset.
5. <code>intervals</code> is the zero-offset decoder.
6. <code>length_intervalsFrom</code> proves shifted decoding preserves count.
7. <code>length_intervals</code> is the public zero-offset count identity.

### Items 8–18: covered positions, coverage, and cardinality

8. <code>coveredFinsetFrom</code> recursively unions shifted half-open finite
   intervals.
9. <code>coveredFinset</code> starts that decoder at zero.
10. <code>mem_coveredFinsetFrom_iff_exists_interval</code> equates shifted
    covered membership with membership in one decoded interval.
11. <code>mem_coveredFinset_iff_exists_interval</code> is the public zero-offset
    equivalence.
12. <code>mem_coveredFinsetFrom_bounds</code> puts every covered point inside
    the shifted horizon.
13. <code>card_coveredFinsetFrom</code> proves exact shifted union cardinality.
14. <code>card_coveredFinset</code> identifies public covered cardinality with
    covered length.
15. <code>coveredFinset_subset_range</code> contains every covered point below
    the horizon.
16. <code>Covers</code> defines coverage as marked-set inclusion.
17. <code>intervalCount_ne_zero_of_covers_of_nonempty</code> turns nonempty
    coverage into nonempty packing.
18. <code>card_le_coveredLength_of_covers</code> is the marked-count bridge.

### Items 19–23: interval order and disjointness

19. <code>intervalsFrom_inside</code> proves shifted start, positive length,
    and endpoint containment.
20. <code>intervalsFrom_pairwise</code> proves chronological endpoint order.
21. <code>intervals_pairwise</code> specializes order to offset zero.
22. <code>intervals_pairwiseDisjoint_Ico</code> converts order to pairwise
    disjoint half-open sets.
23. <code>intervals_inside</code> gives the public nonempty/contained endpoint
    statement.

### Items 24–31: selected provenance and the greedy selector

24. <code>SelectedFromFrom</code> recursively certifies absolute selected
    starts and prescribed lengths.
25. <code>SelectedFrom</code> is its zero-offset public form.
26. <code>SelectedFromFrom.mono</code> widens eligible starts along a finite-set
    inclusion.
27. <code>SelectedFromFrom.intervalsFrom_chosen</code> exposes provenance for
    every shifted decoded interval.
28. <code>SelectedFrom.intervals_chosen</code> exposes it at offset zero.
29. <code>SelectedFrom.interval_end_lt_enlargedHorizon</code> proves strict
    endpoint slack from marked-start and length bounds.
30. <code>exists_orderedPacking_covering_from</code> is the private offset
    strong-induction selector.
31. <code>exists_orderedPacking_covering</code> returns a packing at \(H+m\)
    with both coverage and provenance.

### Items 32–43: packing costs and local-cost transport

32. <code>cost</code> recursively adds selected process costs at absolute
    starts.
33. <code>coveredLength_le_horizon</code> bounds selected length by ambient
    length.
34. <code>horizon_pos_of_intervalCount_ne_zero</code> derives positive horizon
    from a nonempty packing.
35. <code>EveryIntervalCostLE</code> is the recursive weak local-cost predicate.
36. <code>EveryIntervalCostLT</code> is the strict predicate.
37. <code>EveryIntervalCostLT.le</code> weakens every strict local estimate.
38. <code>SelectedFromFrom.everyIntervalCostLE</code> transports weak marked
    estimates at an arbitrary offset.
39. <code>SelectedFromFrom.everyIntervalCostLT</code> transports strict marked
    estimates at an arbitrary offset.
40. <code>SelectedFrom.everyIntervalCostLE</code> is the zero-offset weak
    bridge.
41. <code>SelectedFrom.everyIntervalCostLT</code> is the zero-offset strict
    bridge.
42. <code>cost_le_mul_coveredLength</code> sums weak local estimates.
43. <code>cost_lt_mul_coveredLength</code> sums strict estimates for a nonempty
    packing.

### Items 44–51: process, covered-length, marked-card, and greedy bounds

44. <code>le_cost_of_add_le_nonpos</code> is the raw positive-horizon packing
    inequality.
45. <code>le_cost_of_add_le_nonpos_of_nonempty</code> derives horizon positivity
    internally.
46. <code>le_mul_coveredLength_of_add_le_nonpos</code> is the weak
    covered-length process bound.
47. <code>lt_mul_coveredLength_of_add_le_nonpos</code> is its strict nonempty
    counterpart.
48. <code>le_mul_card_of_add_le_nonpos_of_covers</code> combines weak cost,
    coverage, and \(c\le0\).
49. <code>lt_mul_card_of_add_le_nonpos_of_covers</code> combines strict cost
    with nonempty marked coverage.
50. <code>le_mul_card_of_greedy_cover</code> composes selection, provenance,
    coverage, and weak per-mark estimates. It retains \(H+m\ne0\).
51. <code>lt_mul_card_of_greedy_cover</code> is the strict end-to-end theorem.
    Nonempty marks imply a positive enlarged horizon.

### Items 52–55: project wrappers

52. <code>IsIntegrableSubadditiveProcessCandidate.le_orderedIntervalPackingSum</code>
    exposes the raw packing sum on a candidate receiver.
53. <code>IsIntegrableSubadditiveProcessCandidate.le_mul_coveredLength_of_orderedIntervalPacking</code>
    exposes the weak covered-length form.
54. <code>IsIntegrableSubadditiveProcessCandidate.centeredProcess_le_orderedIntervalPackingSum</code>
    specializes to the orbit-majorant-centered process.
55. <code>DiscreteMatrixCocycle.centeredLogPlusNormObservable_le_orderedIntervalPackingSum</code>
    specializes directly to the centered cocycle observable.

### Items 56–67: private boundary witnesses

56. <code>positiveAtZeroProcess</code> equals one at time zero and a negative
    linear value later.
57. <code>positiveAtZeroProcess_add_le</code> proves its shifted
    subadditivity.
58. <code>positiveAtZeroProcess_nonpos</code> proves only positive-horizon
    nonpositivity.
59. <code>positiveAtZeroCandidate</code> packages the witness over the zero
    measure.
60. <code>emptyPositivePacking</code> is an empty packing at positive horizon.
61. <code>fullTerminalPacking</code> selects one interval ending exactly at its
    horizon.
62. <code>abuttingPacking</code> selects two adjacent intervals with zero
    intermediate gap.
63. <code>packingWithOuterGaps</code> retains both an initial and terminal gap.
64. <code>unitAbuttingPacking</code> selects three singleton intervals that
    abut.
65. <code>packingWithIntermediateGap</code> selects two singleton intervals
    separated by a positive internal gap.
66. <code>longChoice</code> assigns a longer interval at start zero and unit
    length elsewhere.
67. <code>longCoverPacking</code> covers two marked starts with one selected
    interval, showing that marked cardinality can be strictly smaller than
    covered length.

## Boundary cases are part of the theorem

### Empty marked set

The selector returns an empty packing and both <code>Covers</code> and
<code>SelectedFrom</code> hold vacuously. The weak greedy theorem is useful at
positive enlarged horizon and says \(X_{H+m}\le0\). The strict theorem is not
available because <code>marked.Nonempty</code> is false.

### Empty packing at positive horizon

The raw inequality reduces to positive-horizon nonpositivity:
\(X_N\le0=\operatorname{cost}(P)\). This is valid and useful.

### Empty packing at horizon zero

The private witness has \(X_0=1\). The empty packing cost is zero. Therefore

\[
X_0=1\not\le0=\operatorname{cost}(\operatorname{empty}(0)).
\]

This countermodel refutes the version of the raw theorem with its horizon
premise deleted.

### Singleton intervals

<code>unitAbuttingPacking</code> contains \([0,1)\), \([1,2)\), and \([2,3)\).
Each interval has one natural position. This is the direct regression test for
the strict-endpoint inconsistency in the motivating inclusive display.

### Abutting intervals

<code>abuttingPacking</code> contains \([0,2)\) and \([2,5)\). Their endpoint
and start are equal, but their intersection is empty. Requiring a positive gap
would reject a legal packing and break the leftmost selector when the next
uncovered mark lies exactly at the prior endpoint.

### Endpoint at the horizon

<code>fullTerminalPacking</code> contains \([0,3)\) in horizon three. Generic
packing containment permits endpoint equality. The selector's stronger
endpoint theorem is strict only because its ambient horizon includes the extra
\(m\) slack.

### Zero gaps and outer gaps

An initial gap of zero must not create an \(X_0\) summand. A positive outer gap
may be split and discarded by nonpositivity. A terminal gap of zero is handled
without a time-zero sign premise.

### Zero length bound

If \(m=0\), a nonempty marked set cannot satisfy
\(0\lt\ell(j)\le m\). The empty marked set still produces a packing. The weak
process theorem then needs \(H\ne0\), exactly as its explicit enlarged-horizon
premise says.

### Empty matrix dimension

The cocycle smoke test instantiates the final wrapper with index type
<code>Empty</code>. No positive matrix dimension has leaked into this finite
algebra.

## How Lean executes the finite proof

### Let the type eliminate geometric side conditions

Induction on the packing immediately exposes a prefix gap, positive selected
length, and recursively valid tail. There is no separate proof record to
unpack at every step.

### Carry absolute offsets explicitly

Relative gaps are convenient constructors. Process costs and marked-start
hypotheses use absolute orbit positions. The <code>From</code> definitions and
theorems carry an offset until a zero-offset wrapper closes the public API.

### Use strong induction on remaining old horizon

The selector does not decrease by exactly one. After selecting a length-
\(\ell\) interval, it recurses on the tail beginning at \(j+\ell\). Strong
induction states exactly the needed decreasing relation.

### Use the finite minimum, then filter

<code>Finset.min'</code> chooses the leftmost mark. Filtering by
\(j+\ell\le k\) retains exactly the starts that are not covered by the current
half-open interval. <code>SelectedFromFrom.mono</code> widens the recursive
certificate from this filtered set back to the original marked set.

### Normalize natural iterates at the cost bridge

The recursive packing has already shifted the sample. The per-mark hypothesis
is written at an absolute exponent. <code>Function.iterate_add_apply</code> and
commutativity of natural addition identify the two forms
([function iteration](#ref-rmt21-function-iterate)).

### Let <code>omega</code> own endpoint arithmetic

The proof obligations are linear natural-number inequalities and equalities:
tail horizons, endpoint containment, strict decrease, and reconstruction of
\(H+m\). The <code>omega</code> tactic handles those Presburger facts after the
semantic cases have been chosen.

### Let <code>linarith</code> delete signed gaps

Subadditivity supplies a sum containing a gap term. Positive-horizon
nonpositivity bounds that term by zero. <code>linarith</code> performs only the
final ordered-ring combination.

### Cast cardinalities before reversing multiplication

Coverage begins in natural numbers. The process bound lives in real numbers.
The proof casts \(|B|\le L\) to the reals, then applies multiplication by a
nonpositive coefficient on the left. This is the only reason the marked-card
theorems require \(c\le0\).

## Common wrong turns

### Using closed intervals in Lean

Closed intervals double-count a shared endpoint. The selector and cardinality
proof are designed around half-open intervals.

### Requiring a positive gap

Pairwise disjoint half-open intervals may abut. A strict gap rejects valid
output and contradicts the leftmost filter.

### Requiring length at least two

Positive natural length includes one. The strict endpoint chain in the source
display is not a valid reason to remove singleton intervals.

### Treating <code>Covers</code> as provenance

Coverage alone does not say where a selected interval began or which length
function it obeys. Per-mark cost transport requires <code>SelectedFrom</code>.

### Treating <code>SelectedFrom</code> as coverage

A packing can select legitimate marked intervals and still omit other marks.
The greedy theorem returns both predicates.

### Demanding the original horizon \(H\)

A legal interval beginning at \(H-1\) may extend beyond \(H\). The uniform
bound on length gives the enlarged horizon \(H+m\).

### Dropping the horizon premise from the weak greedy theorem

When \(H=m=0\) and marks are empty, the selector exists but positive-horizon
nonpositivity says nothing about \(X_0\).

### Claiming a strict theorem for empty marks

Strict per-mark hypotheses are vacuous on the empty set. The desired strict
conclusion can reduce to \(0\lt0\).

### Forgetting that \(c\le0\)

Coverage gives a lower bound on selected length. It becomes the desired upper
bound only after multiplication reverses direction.

### Reading packing cost as an orbit sum of \(X_1\)

Each summand is a variable-horizon process value at one selected start. It is
not a Birkhoff sum unless additional equality is proved.

### Discarding zero gaps with nonpositivity

The sign premise applies only at nonzero horizons. The proof branches around
zero gaps instead.

### Calling the selector optimal or canonical

The theorem proves existence of a leftmost construction with coverage and
provenance. It proves no minimum number of intervals, maximum covered length,
or uniqueness.

### Calling coverage a density estimate

The result is a finite cardinality inequality for a supplied finite marked
set. No limiting density exists in the statement.

### Calling this Kingman's theorem

The module proves a finite ingredient used in one proof strategy. It contains
no limit, almost-everywhere quantifier, expectation, or invariant function.

## What interval packing still does not prove

RMT-21 proves none of the following:

1. a lower or upper asymptotic density of marked starts;
2. a maximal inequality;
3. a finite or pointwise Birkhoff ergodic theorem;
4. a mean ergodic theorem;
5. Kingman's subadditive ergodic theorem;
6. almost-sure or almost-everywhere convergence;
7. convergence in probability or in \(L^1\);
8. interchange of a limit and an integral;
9. an invariant-integral identity;
10. ergodicity of \(T\) or any power of \(T\);
11. a probability-space normalization;
12. a measure estimate for a marked event;
13. independence or stationarity of selected intervals;
14. uniqueness, maximality, or optimality of the selected packing;
15. a Vitali covering theorem or a Riesz covering lemma;
16. a signed logarithmic cocycle observable;
17. a top or lower Lyapunov exponent;
18. a singular-value growth theorem;
19. an exterior-power cocycle;
20. an invariant Oseledets filtration or splitting.

The final two wrappers remain finite statements about the project's
log-positive expansion envelope. They do not recover contraction clipped by
that observable.

## Exercises with solutions

### Exercise 1: decode one cons node

Let the offset be five, the gap two, and the length three. What interval is
emitted?

**Solution.** The start is \(5+2=7\) and the endpoint is \(7+3=10\), so the
half-open interval is \([7,10)\).

### Exercise 2: identify the terminal gap

What constructor records a terminal gap of four after the last selected
interval?

**Solution.** The recursive rest is <code>.empty 4</code>. Empty retains a
horizon even though it selects nothing.

### Exercise 3: permit abutment

Are \([2,5)\) and \([5,8)\) disjoint?

**Solution.** Yes. The first excludes five and the second includes it. Their
endpoint order is \(5\le5\).

### Exercise 4: permit a singleton

How many natural positions lie in \([4,5)\)?

**Solution.** Exactly one, namely four. Its positive length is one.

### Exercise 5: separate the decoders

What does the interval list remember that the covered finite set forgets?

**Solution.** It remembers ordered interval boundaries. The finite union only
remembers which positions are covered.

### Exercise 6: recover interval count

Why does <code>length_intervals</code> need no disjointness theorem?

**Solution.** It counts list nodes, not union positions. Each cons emits one
pair and recurses.

### Exercise 7: recover covered cardinality

Why does <code>card_coveredFinset</code> need disjointness?

**Solution.** Cardinality of a union is additive only when overlaps are absent.

### Exercise 8: distinguish coverage

Can one long interval that starts outside \(B\) satisfy <code>Covers B</code>?

**Solution.** Yes, if it contains every mark. Coverage alone is not provenance.

### Exercise 9: distinguish provenance

Can a <code>SelectedFrom</code> packing omit a marked start?

**Solution.** Yes. The predicate constrains selected intervals but does not
require every eligible mark to be covered.

### Exercise 10: combine the predicates

What two facts does the greedy selector return?

**Solution.** <code>P.Covers marked</code> and
<code>P.SelectedFrom marked length</code>.

### Exercise 11: find the leftmost mark

If \(B=\{2,3,7\}\) and \(\ell(2)=3\), which marks are removed after selecting
at two?

**Solution.** The interval is \([2,5)\), so starts two and three are covered.
Seven remains.

### Exercise 12: see abutment in the filter

If the first interval is \([2,5)\), does a mark at five survive?

**Solution.** Yes. The filter retains starts at least five. A subsequent
interval may abut the first.

### Exercise 13: prove induction decreases

Why is the recursive old-horizon tail shorter after selecting a positive
interval?

**Solution.** The new origin lies at \(j+\ell(j)\), strictly to the right of
the selected start because \(\ell(j)\gt0\).

### Exercise 14: explain the crossing branch

Why can recursion stop when \(j+\ell(j)\) passes the old horizon end?

**Solution.** Every marked start is still below the old end and at least the
leftmost \(j\), so it lies inside the selected interval.

### Exercise 15: justify the enlarged endpoint

From \(j\lt H\) and \(\ell(j)\le m\), show \(j+\ell(j)\lt H+m\).

**Solution.** Natural arithmetic gives \(j+1\le H\), hence
\(j+\ell(j)\lt H+m\) using positive-length and bound arithmetic. This is the
fact discharged by <code>omega</code>.

### Exercise 16: compare endpoint theorems

Why does generic <code>intervals_inside</code> permit endpoint \(N\), while the
selector endpoint theorem gives a strict bound below \(H+m\)?

**Solution.** A generic packing may fill its horizon exactly. The selector's
target horizon includes uniform extra slack \(m\) beyond the start horizon.

### Exercise 17: count covered marks

If \(B\subseteq P.coveredFinset\), why is \(|B|\le P.coveredLength\)?

**Solution.** Finite-set inclusion gives
\(|B|\le|P.coveredFinset|\), and exact cardinality identifies the latter with
covered length.

### Exercise 18: derive nonempty packing

Why does a packing covering nonempty \(B\) have nonzero interval count?

**Solution.** An empty packing has empty covered finite set and cannot contain
a witness from \(B\).

### Exercise 19: read one cost term

For interval \([j,j+\ell)\), which process value enters the cost?

**Solution.** \(X_\ell(T^j\omega)\).

### Exercise 20: reject a pointwise interpretation

Is that term equal to \(\sum_{r\lt\ell}X_1(T^{j+r}\omega)\)?

**Solution.** Not in general. Subadditivity supplies only an inequality unless
the process is additive.

### Exercise 21: align recursive offsets

Why does the cost bridge use function-iterate addition?

**Solution.** The tail sample has already been shifted by earlier gaps and
intervals. The theorem identifies that nested shift with the absolute selected
start named by <code>SelectedFromFrom</code>.

### Exercise 22: sum weak bounds on empty packing

What does <code>cost_le_mul_coveredLength</code> become?

**Solution.** \(0\le c\cdot0\), hence \(0\le0\).

### Exercise 23: try to sum strict bounds on empty packing

What false conclusion would result?

**Solution.** \(0\lt0\). This is why nonzero interval count is explicit.

### Exercise 24: discard a positive gap

If subadditivity yields \(X_N\le A+X_g\) with \(g\ne0\), what sign fact removes
the gap?

**Solution.** \(X_g\le0\), so \(A+X_g\le A\).

### Exercise 25: handle a zero gap

Why not use the same sign fact when \(g=0\)?

**Solution.** The premise controls only nonzero horizons. Lean instead avoids
splitting off that gap.

### Exercise 26: test the time-zero witness

What are the process value and empty packing cost at horizon zero?

**Solution.** The private witness has process value one and packing cost zero,
so the desired inequality fails.

### Exercise 27: retain the positive empty case

What happens for an empty packing at horizon four under the same witness?

**Solution.** \(X_4=-4\le0\), so the raw inequality is valid.

### Exercise 28: reverse the count inequality

Suppose \(|B|\le L\) and \(c=-2\). Which way does multiplication go?

**Solution.** \(-2L\le-2|B|\).

### Exercise 29: locate the coefficient premise

Which theorem family needs \(c\le0\): covered-length or marked-card?

**Solution.** Marked-card. Covered-length uses no comparison between \(L\) and
another cardinality.

### Exercise 30: audit the weak greedy boundary

Why does <code>le_mul_card_of_greedy_cover</code> retain \(H+m\ne0\)?

**Solution.** Empty marks can produce an empty horizon-zero packing, and no
positive-time sign premise controls \(X_0\).

### Exercise 31: audit the strict greedy boundary

Why can <code>lt_mul_card_of_greedy_cover</code> omit the horizon premise?

**Solution.** Nonempty marks plus coverage force at least one selected
positive-length interval, hence a positive horizon.

### Exercise 32: construct the empty strict counterexample

Take a process identically zero at positive times and no marks. Why are all
strict local hypotheses true?

**Solution.** They are universally quantified over the empty marked set, so
there is no counterexample. The global strict conclusion is still false.

### Exercise 33: audit wrapper integrability

Does the candidate-facing packing-sum proof use the candidate's integrability
field?

**Solution.** No. The receiver carries it, but the proof projects only
<code>add_le</code> and takes nonpositivity separately.

### Exercise 34: audit preservation

Does the centered-process packing theorem require a new preservation witness?

**Solution.** No. It is pointwise finite algebra once the centered
subadditivity and sign theorems are available.

### Exercise 35: audit matrix dimension

Why is no nonempty index premise needed?

**Solution.** The centered log-positive observable's finite algebra is already
valid for the empty matrix index, and the packing layer is scalar.

### Exercise 36: name the next missing bridge

What must be proved before this finite marked-card inequality becomes a
Kingman theorem?

**Solution.** One still needs exact measurable marked events, finite-measure
and stationarity interfaces, a pointwise Birkhoff theorem or another density
mechanism, limit and integral control, and the argument identifying the
liminf. RMT-21 supplies none of those automatically.

## Reproducibility and audit ledger

| Artifact | Role | Validation |
|---|---|---|
| <code>SubadditiveIntervalPacking.lean</code> | Fifty-four public named declarations, one private selector engine, twelve private named fixtures, and compiled anonymous boundary probes | Direct warning-fatal Lean check and axiom audit |
| <code>RandomCocycles.lean</code> | Aggregator import and scope summary | Warning-fatal checks through the root |
| This <code>index.md</code> | Declaration-complete proof-to-prose map | Teaching source hygiene and Hugo warnings fatal |
| <code>gap-length-tail-encoding.svg</code> | Structural packing representation | UTF-8 XML parse and rendered inspection |
| <code>selected-starts-to-marked-card-bound.svg</code> | Selector-to-dynamics dependency boundary | UTF-8 XML parse and rendered inspection |
| <code>generate-card.sh</code> | Deterministic featured-card generator | <code>--verify</code> byte comparison and 1200x630 dimension check |

From the repository root:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/SubadditiveIntervalPacking.lean
lake build NonlinearDynamics.Random.RandomCocycles.SubadditiveIntervalPacking
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles.lean
lake env lean -DwarningAsError=true NonlinearDynamics/Random.lean
lake env lean -DwarningAsError=true NonlinearDynamics.lean
cd ..
python3 scripts/check_teaching_source_hygiene.py
make site-check
~~~

The public-surface audit should include:

~~~lean
import NonlinearDynamics

open NonlinearDynamics.Random.RandomCocycles

#check OrderedNatIntervalPacking
#check OrderedNatIntervalPacking.intervals_pairwiseDisjoint_Ico
#check OrderedNatIntervalPacking.exists_orderedPacking_covering
#check OrderedNatIntervalPacking.SelectedFrom.everyIntervalCostLE
#check OrderedNatIntervalPacking.SelectedFrom.everyIntervalCostLT
#check OrderedNatIntervalPacking.le_cost_of_add_le_nonpos
#check OrderedNatIntervalPacking.le_mul_card_of_greedy_cover
#check OrderedNatIntervalPacking.lt_mul_card_of_greedy_cover
#check IsIntegrableSubadditiveProcessCandidate.centeredProcess_le_orderedIntervalPackingSum
#check DiscreteMatrixCocycle.centeredLogPlusNormObservable_le_orderedIntervalPackingSum
~~~

The integrated repository module is 1,131 lines with SHA-256
<code>732187ce77b5efa14df3a992f194d5dce4dfc8d9f5fa6dbaf658c5ed41ef4f4d</code>.
That hash records the exact source audited for this chapter; the repository
module is the present authority. Its warning-fatal leaf check and the
aggregator/root builds pass. The axiom audit reports only Lean and Mathlib's
standard logical dependencies, with no <code>sorry</code>, <code>admit</code>,
<code>unsafe</code> declaration, or custom axiom.

This article publishes as an open working note with <code>draft: false</code> and
retains <code>pro_reviewed: false</code>. Automated checks do not replace human
mathematical, source, accessibility, and editorial review.

## The next ridge

RMT-20 supplied the finite phase-averaged upper mechanism. RMT-21 now supplies
the complementary finite interval-packing mechanism: choose bounded favorable
intervals, retain an ordered disjoint cover of all marked starts, and turn
their local estimates into a marked-cardinality process bound.

The next dependency is not another repackaging theorem. It is the analytic
infrastructure that makes the marked set large along typical orbits and
connects finite inequalities to limits. That work must state exact measurable
events, probability or finite-measure assumptions, measure preservation,
integrability, stationarity, maximal or Birkhoff machinery, almost-everywhere
quantifiers, and limit-identification steps. The current module does not allow
any one of those assumptions to be inferred from notation.

The immediate successor,
[Convergence Without Existence: Birkhoff Events and Ergodic Rigidity in Lean]({{< relref "/development-notebook/2026/07/birkhoff-convergence-events-and-ergodic-rigidity-in-lean" >}}),
supplies the first event-level bridge. It proves that convergence of one-step
Birkhoff averages is an exactly invariant measurable or null-measurable event,
then derives conditional null-or-conull and probability-zero-or-one laws.
It supplies no convergence existence, marked-set density or frequency, maximal
inequality, pointwise Birkhoff theorem, or Kingman theorem. Those analytic
inputs remain the next ridge between this finite packing and asymptotic
subadditive dynamics.

For matrix cocycles, the observable remains log-positive and therefore clips
contraction. Signed Lyapunov exponents, singular-value rates, exterior powers,
and Oseledets splittings remain separate future layers.

## References

The links below were checked on 2026-07-21. The pinned Mathlib 4.32.0 checkout
at commit
<code>81a5d257c8e410db227a6665ed08f64fea08e997</code> is the exact authority for
upstream theorem names used by the frozen proof.

<a id="ref-rmt21-finset-intervals"></a>
**Mathlib contributors.**
[Finite interval definitions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Order/Interval/Finset/Defs.html),
with the
[pinned definitions and membership theorem](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/Interval/Finset/Defs.lean#L285-L306).
These declarations define <code>Finset.Ico</code> and identify its members with
the half-open endpoint inequalities used by the packing decoder.

<a id="ref-rmt21-finset-nat"></a>
**Mathlib contributors.**
[Natural-number finite intervals](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Order/Interval/Finset/Nat.html),
with the
[pinned range and cardinality laws](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/Interval/Finset/Nat.lean#L72-L85).
These laws identify <code>Finset.range H</code> with the half-open interval from
zero and compute the size of a natural <code>Ico</code>.

<a id="ref-rmt21-finset-card"></a>
**Mathlib contributors.**
[Finite-set cardinality](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/Finset/Card.html),
with the
[pinned disjoint-union laws](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Data/Finset/Card.lean#L565-L577).
RMT-21 uses these declarations to add interval and recursive-tail cardinalities
only after proving disjointness.

<a id="ref-rmt21-list-pairwise"></a>
**Lean contributors.**
[Lean 4 list pairwise source](https://github.com/leanprover/lean4/blob/v4.32.0/src/lean/Init/Data/List/Basic.lean#L1384-L1395),
Lean 4.32.0. The recursive <code>pairwise_cons</code> characterization matches
the source-order proof of endpoint separation.

<a id="ref-rmt21-function-iterate"></a>
**Mathlib contributors.**
[Function iteration](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Logic/Function/Iterate.html),
with the
[pinned iterate laws](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Logic/Function/Iterate.lean#L54-L87).
The addition law aligns recursively shifted samples with absolute selected
starts.

<a id="ref-rmt21-lalley"></a>
**Steven P. Lalley.**
[Kingman's Subadditive Ergodic Theorem](https://galton.uchicago.edu/~lalley/Courses/Graz/Kingman.pdf),
University of Chicago lecture notes, 3 pages, undated, accessed 2026-07-21.
Page 2 states the finite packed-process inequality as equation (6). Page 3
describes choosing the leftmost blue interval and deleting candidates whose
starts it covers. The notes use inclusive integer intervals. Their displayed
strict start-to-end chain excludes length one although the next paragraph
allows \(1\le k\le m\). RMT-21 translates the argument to half-open intervals,
admits singleton and abutting selections, and separately repairs the empty-set
strict boundary. These notes motivate the finite construction; they are not an
upstream Lean theorem or the primary source for Kingman's asymptotic theorem.

<a id="ref-rmt21-steele"></a>
**J. Michael Steele.**
[Kingman's subadditive ergodic theorem](https://www.numdam.org/item/AIHPB_1989__25_1_93_0/),
*Annales de l'Institut Henri Poincare, Probabilites et Statistiques* 25(1),
93-98, 1989, with the
[archival PDF](https://www.numdam.org/item/AIHPB_1989__25_1_93_0.pdf).
Page 95 gives a conceptually algorithmic decomposition of a finite integer
interval into selected bounded intervals and singleton classes. It is related
proof lineage, but it neither states nor replaces RMT-21's exact
<code>Covers</code> and <code>SelectedFrom</code> selector contract.

<a id="ref-rmt21-kingman"></a>
**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source is the historical asymptotic destination. RMT-21 proves
only finite combinatorics and a finite process inequality.

The exact upstream Mathlib revision audited for this chapter is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
