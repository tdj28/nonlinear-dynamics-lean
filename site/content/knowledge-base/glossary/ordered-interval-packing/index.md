---
title: "Ordered interval packing"
slug: "ordered-interval-packing"
summary: "Ordered interval packing encodes positive-length half-open natural intervals by successive gaps, making containment, chronological order, disjointness, abutment, exact covered cardinality, and finite marked-start coverage available by construction."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveIntervalPacking"
og_image: "ordered-interval-packing-card.png"
og_image_alt: "Warm-paper glossary card showing an initial uncovered gap, a positive-length interval, an optional zero gap, a singleton interval, and an interval abutting that singleton without overlap. The footer reads ordered, half-open, disjoint, and finite horizon."
---

An **ordered interval packing** is a finite chronological family of
positive-length half-open intervals inside a finite natural-number horizon.
RMT-21 encodes the family by the gaps before successive intervals rather than
by an arbitrary list plus a separate proof that the list is valid.

The term has a narrow meaning here. A packing is not a probability
distribution, an asymptotic density, a topological cover, or an assertion that
the selected intervals are optimal. It is finite data with checked endpoint,
coverage, and cardinality properties.

The construction continues the finite upper estimate developed by
{{< refterm "phase-averaging" "phase averaging" >}}. Phase averaging gathers
fixed-block estimates. Ordered interval packing handles the complementary
geometry in which different marked starts may choose different positive
lengths.

{{< reference-figure
  src="ordered-packing-on-a-finite-horizon.svg"
  alt="A toy horizon from zero through nine contains selected intervals covering positions one and two, position three alone, and positions six through eight. The first two selected intervals abut. Marked starts one, two, three, six, and eight all lie in the selected union. Separate rows show the ordered endpoints and covered positions."
  caption="**Finding:** a packing can contain a singleton interval and adjacent intervals without overlap. In this toy horizon the selected intervals are `[1,3)`, `[3,4)`, and `[6,9)`. Their covered positions are `{1,2,3,6,7,8}` and their total covered length is six. The marked starts `{1,2,3,6,8}` are all covered, although not every mark begins a selected interval. That last distinction separates coverage from selection provenance. The example is finite and illustrative, not empirical data or an asymptotic density claim."
>}}

## The half-open convention

For natural endpoints \(a\) and \(b\), the half-open interval

\[
[a,b)=\{j\in\mathbb N:a\le j\lt b\}
\]

includes its left endpoint and excludes its right endpoint. If \(a\le b\), it
contains \(b-a\) natural positions.

This convention makes adjacency exact. More generally, the intervals
\([a,b)\) and \([c,d)\) are chronologically disjoint when

\[
b\le c.
\]

Equality is legal: when \(b=c\), the two intervals abut without sharing a
point. In the figure, \([1,3)\) and \([3,4)\) abut at three, but
three belongs only to the second interval.

A positive natural length may equal one. The interval \([3,4)\) is therefore a
legal singleton. This corrects a small mismatch in the motivating inclusive
display from Lalley's notes: the displayed strict start-to-end comparison
excludes length one, although the following selection permits
\(1\le k\le m\) ([Lalley](#ref-packing-lalley)).

Mathlib's <code>Finset.Ico</code> is the finite-set implementation of this
half-open convention. Its natural-number cardinality is endpoint difference
([finite interval API](#ref-packing-finset-intervals)).

## The gap-length-tail representation

The Lean type is indexed by its total horizon:

~~~lean
inductive OrderedNatIntervalPacking : ℕ → Type
  | empty (horizon : ℕ) : OrderedNatIntervalPacking horizon
  | cons (gap length : ℕ) {tail : ℕ} (length_pos : 0 < length)
      (rest : OrderedNatIntervalPacking tail) :
      OrderedNatIntervalPacking (gap + length + tail)
~~~

An empty packing retains an ambient horizon but selects nothing. A cons node
stores:

- a gap before the next interval, possibly zero;
- a strictly positive selected length; and
- a recursively valid tail beginning after that interval.

The final empty node records the terminal gap. An empty intermediate gap lets
intervals abut. A positive selected length rules out empty intervals but not
singletons.

Because the recursive tail begins after the current interval, every decoded
later interval begins at or after the current endpoint. Ordering and
disjointness are therefore structural consequences of the representation.

## Four views of one packing

RMT-21 exposes four summaries:

| Name | Meaning |
|---|---|
| <code>intervalCount</code> | number of selected intervals |
| <code>coveredLength</code> | sum of selected interval lengths |
| <code>intervals</code> | ordered list of absolute endpoint pairs |
| <code>coveredFinset</code> | finite union of all covered natural positions |

The interval list retains boundaries. The covered finite set retains
membership. They agree through two checked identities:

\[
\operatorname{length}(\operatorname{intervals}(P))
=\operatorname{intervalCount}(P),
\]

and

\[
|\operatorname{coveredFinset}(P)|
=\operatorname{coveredLength}(P).
\]

The second equality depends on pairwise disjointness. Without it, union
cardinality would count an overlap once while the sum of interval lengths
would count it twice.

Membership also has an interval witness: a position belongs to
<code>coveredFinset</code> exactly when it lies between the endpoints of one
decoded half-open interval.

## Coverage is not selection provenance

Let \(B\) be a finite set of marked starts. The predicate

\[
\operatorname{Covers}(P,B)
\quad\Longleftrightarrow\quad
B\subseteq\operatorname{coveredFinset}(P)
\]

says every mark lies somewhere in the selected union. It does not require
every selected interval to start at a mark.

The separate predicate <code>SelectedFrom</code> says every selected interval
does begin at an eligible marked start and has exactly the prescribed length
there. It does not by itself say every mark is covered.

The greedy selector returns both:

\[
P\text{ covers }B
\qquad\text{and}\qquad
P\text{ is selected from }(B,\ell).
\]

The distinction is visible in the toy figure. The mark at two lies inside
\([1,3)\), so it is covered, but it is not the start of a selected interval.

## The leftmost selector

Suppose

\[
B\subseteq\{0,\ldots,H-1\}
\]

and each \(j\in B\) has a prescribed length with

\[
0\lt\ell(j)\le m.
\]

The finite selector repeats the following rule:

1. choose the least remaining marked start \(j\);
2. keep \([j,j+\ell(j))\);
3. remove every remaining mark already inside that interval; and
4. continue with the first mark at or beyond the right endpoint.

Every removed mark is covered by the interval that removed it. Every retained
future start lies at or to the right of that endpoint. Hence the selected
intervals are ordered and disjoint while their union covers all original
marks.

The output horizon is \(H+m\), not \(H\). A start may occur just before \(H\)
and its chosen interval may extend by as much as \(m\). From \(j\lt H\) and
\(\ell(j)\le m\), its right endpoint is strictly below \(H+m\).

The construction proves existence, not uniqueness or optimality. Another
ordered subfamily could satisfy the same two contracts.

## One complete selection and count

Take an old start horizon \(H=10\), a uniform length bound \(m=4\), and

\[
B=\{1,2,4,5,8,9\}.
\]

Prescribe the lengths

\[
\ell(1)=3,\qquad \ell(4)=2,\qquad \ell(8)=4,
\]

with any positive lengths at most four at the starts that will be deleted.
The selector never needs to consult a deleted start's length.

The first remaining start is one. Selecting \([1,4)\) covers the marks one
and two. The mark four survives because a half-open interval excludes its
right endpoint. It is the next leftmost start, and \([4,6)\) covers four and
five. This interval abuts the first without overlapping it. The next survivor
is eight. Its interval \([8,12)\) covers eight and nine. It passes the old
horizon ten, so the selector takes the terminal branch rather than making a
recursive call.

The final packing can be read directly as gap-length-tail data:

| Piece | Size | Meaning |
|---|---:|---|
| initial gap | 1 | skip position zero |
| first length | 3 | select \([1,4)\) |
| next gap | 0 | permit immediate abutment |
| second length | 2 | select \([4,6)\) |
| next gap | 2 | skip positions six and seven |
| third length | 4 | select \([8,12)\) |
| terminal tail | 2 | finish the enlarged horizon at fourteen |

The arithmetic is exact:

\[
1+3+0+2+2+4+2=14=H+m.
\]

Nothing asks all selected endpoints to remain below \(H\). The input starts
are below \(H\); their bounded lengths put every endpoint below \(H+m\).
Here the last endpoint is twelve, strictly below fourteen.

The six marked starts are contained in a covered set of nine positions:

\[
|B|=6
\le
|\{1,2,3,4,5,8,9,10,11\}|
=9
=\operatorname{coveredLength}(P).
\]

This comparison is deliberately one-sided. Three extra positions are covered
without being marked.

Now let the local coefficient be \(c=-2\). Suppose the selected interval
costs are bounded respectively by \(-6\), \(-4\), and \(-8\). Summing gives

\[
\operatorname{cost}(P)\le -18
=c\,\operatorname{coveredLength}(P).
\]

Since \(6\le9\) but \(c\le0\), multiplication reverses the cardinality
comparison:

\[
-18=c\cdot9\le c\cdot6=-12.
\]

Thus a whole-horizon estimate bounded by the selected cost is also bounded by
\(c|B|\). Replacing nine by six without this sign check would point the
inequality in the wrong direction.

This example exposes four distinct acts in the proof: selection deletes
already covered starts; structural packing proves disjointness; coverage
compares two finite cardinalities; and the nonpositive coefficient reverses
that comparison.

## The endpoint translation dictionary

The motivating notes write an integer interval inclusively as
\([j,j+k-1]\). The Lean development uses the extensionally equal half-open
set \([j,j+k)\). Translating the set before translating the inequalities
prevents two mistakes:

| Inclusive presentation | Half-open presentation | Boundary consequence |
|---|---|---|
| \([j,j+k-1]\) | \([j,j+k)\) | both contain exactly \(k\) integers |
| \(1\le k\le m\) | \(0\lt k\le m\) | \(k=1\) is a legal singleton |
| \(j+k-1\lt j'\) | \(j+k\le j'\) | equality permits abutment |
| last included point \(j+k-1\) | excluded endpoint \(j+k\) | cardinality is endpoint difference |

The strict comparison \(j\lt j+k-1\) appearing in Lalley's displayed chain
cannot hold when \(k=1\), even though the following prose permits that
length. RMT-21 treats this as a source-translation repair, not as a new
mathematical restriction. It preserves the allowed length range and records
disjointness using the correct weak endpoint order.

## Coverage gives a cardinality bound

If \(P\) covers \(B\), then

\[
|B|
\le
|\operatorname{coveredFinset}(P)|
{} =
\operatorname{coveredLength}(P).
\]

The inequality need not be equality. One selected interval can cover several
marked starts. The frozen source includes a regression fixture in which marks
zero and one are both covered by the single interval \([0,3)\), so

\[
2\lt3.
\]

This is a toy theorem probe, not an empirical statistic.

If \(B\) is nonempty, coverage also proves the packing contains an interval.
That implication is needed for strict cost summation.

## From favorable starts to a process bound

Let \(X_n(\omega)\) be shifted-subadditive and nonpositive at every positive
horizon. The packing cost adds one term for each selected interval:

\[
\operatorname{cost}(P)
{} =
\sum_{[j,j+k)\text{ selected}}
X_k(T^j\omega).
\]

Repeated subadditivity splits the whole horizon around those intervals. Every
uncovered positive gap contributes a nonpositive term and can be discarded.
Zero gaps are not split off, so no sign condition on \(X_0\) is needed.

If every marked start satisfies

\[
X_{\ell(j)}(T^j\omega)
\le c\,\ell(j)
\]

with \(c\le0\), <code>SelectedFrom</code> transports the bound to the selected
intervals and <code>Covers</code> supplies the count comparison. The final weak
greedy theorem gives

\[
X_{H+m}(\omega)\le c|B|,
\]

provided \(H+m\ne0\).

The direction of the last step comes from the sign. Coverage gives
\(|B|\le L\). Multiplication by \(c\le0\) yields \(cL\le c|B|\).

## Weak and strict have different boundaries

The weak theorem accepts \(B=\varnothing\). Its local hypothesis is vacuous,
the selected packing may be empty, and the conclusion at positive horizon is
\(X_{H+m}\le0\).

The strict theorem requires <code>marked.Nonempty</code>. This is necessary.
With no marks, strict local hypotheses are still vacuous, but an empty packing
has cost zero and marked cardinality zero. A universal strict conclusion could
reduce to \(0\lt0\).

Nonempty marks plus coverage force a nonempty positive-length packing. The
strict theorem therefore derives positive horizon internally and needs no
separate \(H+m\ne0\) premise.

### A four-case boundary checklist

Before applying a packing theorem, test these cases:

1. **No marks.** Coverage and selection provenance may both be vacuous. The
   weak marked-card theorem is meaningful at positive enlarged horizon, but
   strictness needs an explicit nonempty-mark premise.
2. **One selected position.** Positive length includes one, so
   \([j,j+1)\) must remain legal. A representation that excludes it has an
   off-by-one error.
3. **Two adjacent intervals.** An endpoint equality is allowed:
   \([a,b)\) and \([b,c)\) are disjoint. Requiring a positive intervening gap
   proves a narrower theorem.
4. **Zero ambient horizon.** Positive-time nonpositivity says nothing about
   \(X_0\). A weak process theorem therefore needs a nonzero horizon unless
   another premise, such as nonempty coverage, derives positivity.

These tests separate structural validity from hypotheses belonging to the
process layer. Empty horizons are valid indices for the packing type; they
become problematic only when a theorem tries to control an unnormalized
time-zero process value.

## Time zero remains uncontrolled

The raw process theorem assumes only

\[
X_n\le0\quad\text{when }n\ne0.
\]

An empty packing at positive horizon is valid: it reduces the result to that
sign premise. An empty packing at horizon zero is different. The frozen source
uses a process with \(X_0=1\) and negative values later. Its empty horizon-zero
packing has cost zero, so \(X_0\le\operatorname{cost}(P)\) is false.

This countermodel explains the explicit positive-horizon premise in the weak
packing and greedy theorems. Adding \(X_0=0\) globally would hide the exact
boundary and unnecessarily strengthen the useful positive-time result.

## Lean landmarks

The declaration families are:

- <code>OrderedNatIntervalPacking</code>, <code>intervals</code>, and
  <code>coveredFinset</code> for representation and decoding;
- <code>intervals_pairwiseDisjoint_Ico</code> and
  <code>card_coveredFinset</code> for geometry and exact size;
- <code>Covers</code> and <code>SelectedFrom</code> for coverage and provenance;
- <code>exists_orderedPacking_covering</code> for the leftmost selector;
- <code>EveryIntervalCostLE</code> and <code>EveryIntervalCostLT</code> for
  local cost transport;
- <code>le_cost_of_add_le_nonpos</code> for the raw process inequality;
- <code>le_mul_card_of_greedy_cover</code> for the universal weak marked-card
  result; and
- <code>lt_mul_card_of_greedy_cover</code> for the strict nonempty-mark result.

The
[Development Notebook]({{< relref "/development-notebook/2026/07/ordered-disjoint-interval-packing-for-subadditive-cocycles" >}})
maps all sixty-seven named declarations and the compiled boundary probes. The
[full Deep Dive]({{< relref "/knowledge-base/deep-dives/finite-ordered-interval-packing-for-nonpositive-subadditive-processes" >}})
rebuilds the selector and process inequality step by step.

### A compact declaration-reading recipe

When reading a theorem about a packing \(P\), first inspect its conclusion:

- a statement about <code>P.intervals</code> concerns ordered endpoint pairs;
- a statement about <code>P.coveredFinset</code> concerns membership or finite
  cardinality;
- a hypothesis <code>P.Covers B</code> provides only the inclusion of marks;
- a hypothesis <code>P.SelectedFrom B length</code> provides only the origin
  and prescribed length of selected intervals; and
- a hypothesis <code>P.EveryIntervalCostLE</code> has already translated
  selected intervals into recursive process estimates.

The suffix <code>From</code> signals an absolute offset parameter. Recursive
tails store positions relative to where the tail begins, whereas marked sets
and orbit iterates use absolute positions. The public unsuffixed declaration
sets the offset to zero.

For an end-to-end weak estimate, read the declarations in this order:

1. <code>exists_orderedPacking_covering</code> produces geometry, coverage,
   and provenance.
2. <code>SelectedFrom.everyIntervalCostLE</code> moves a local marked-start
   hypothesis onto the actual selected intervals.
3. <code>le_mul_coveredLength_of_add_le_nonpos</code> bounds the full process
   by coefficient times covered length.
4. <code>card_le_coveredLength_of_covers</code> compares marked cardinality
   with that covered length.
5. <code>le_mul_card_of_add_le_nonpos_of_covers</code> applies the
   nonpositive-coefficient reversal.
6. <code>le_mul_card_of_greedy_cover</code> packages the route.

The strict route uses the parallel <code>LT</code> declarations and adds
<code>marked.Nonempty</code>. That single premise prevents strictness from
collapsing to \(0\lt0\).

## What ordered interval packing does not claim

This finite concept does not establish:

- a limiting density of marked starts;
- a maximal inequality;
- a Birkhoff or Kingman theorem;
- almost-everywhere or \(L^1\) convergence;
- a probability or expectation identity;
- independence of intervals;
- maximal, minimum, or unique packing;
- a Vitali covering theorem;
- a Lyapunov exponent; or
- an Oseledets filtration or splitting.

It also does not say that every covered position is marked. Coverage is a
one-way inclusion from marks into the selected union.

## Where to continue

The {{< refterm "phase-averaging" "phase averaging" >}} entry gives the
finite residue-class upper mechanism immediately before this layer. The
{{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}} entry
explains why the residual process is nonpositive at positive horizons.

[Pack the Marked Starts: Ordered Disjoint Intervals for Subadditive Cocycles in Lean]({{< relref "/development-notebook/2026/07/ordered-disjoint-interval-packing-for-subadditive-cocycles" >}})
is the declaration-complete implementation narrative.

[Finite Ordered Interval Packing for Nonpositive Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-ordered-interval-packing-for-nonpositive-subadditive-processes" >}})
is the textbook route through the geometry, selector induction, cost bridge,
and exact stopping point.

The {{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}}
entry is the next analytic interface. It explains how to name, measure, and
prove invariance of an orbit-average convergence event without claiming that
the event is nonempty or conull.

## References

All links below were checked on 2026-07-21. The pinned Mathlib checkout at
commit <code>81a5d257c8e410db227a6665ed08f64fea08e997</code> is the authority for
exact upstream declarations.

<a id="ref-packing-finset-intervals"></a>**Mathlib contributors.**
[Finite interval definitions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Order/Interval/Finset/Defs.html),
with the
[pinned half-open membership theorem](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/Interval/Finset/Defs.lean#L285-L306),
and
[natural interval cardinality](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/Interval/Finset/Nat.lean#L72-L85).
These are the exact half-open finite-set conventions used by the checked
decoder and cardinality proof.

<a id="ref-packing-finset-card"></a>**Mathlib contributors.**
[Finite-set cardinality](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/Finset/Card.html),
with the
[pinned disjoint-union law](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Data/Finset/Card.lean#L565-L577).
This source warrants the library step from structural disjointness to exact
covered cardinality.

<a id="ref-packing-lalley"></a>**Steven P. Lalley.**
[Kingman's Subadditive Ergodic Theorem](https://galton.uchicago.edu/~lalley/Courses/Graz/Kingman.pdf),
University of Chicago lecture notes, 3 pages, undated, accessed 2026-07-21.
Page 2 gives the finite packed-process inequality. Page 3 describes the
leftmost interval selection. The notes use inclusive intervals and contain the
length-one mismatch explained above. The present entry formalizes a corrected
finite half-open interface and makes no claim to have proved the later
asymptotic argument.

<a id="ref-packing-steele"></a>**J. Michael Steele.**
[Kingman's subadditive ergodic theorem](https://www.numdam.org/item/AIHPB_1989__25_1_93_0/),
*Annales de l'Institut Henri Poincare, Probabilites et Statistiques* 25(1),
93-98, 1989. Page 95 presents a related algorithmic finite interval
decomposition. It does not state the exact selector contract used here.

<a id="ref-packing-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source is the historical limit-theorem destination, not a warrant
for reading convergence into the finite packing definition.

The exact upstream Mathlib revision audited for this entry is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the v4.32.0 revision pinned by <code>formalization/lake-manifest.json</code>.
