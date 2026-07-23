---
title: "Finite Ordered Interval Packing for Nonpositive Subadditive Processes"
slug: "finite-ordered-interval-packing-for-nonpositive-subadditive-processes"
date: 2026-07-21
summary: "A textbook construction of gap-coded ordered half-open interval packings, a leftmost greedy cover of marked starts, exact coverage-to-cardinality bounds, and finite favorable-cost estimates for positive-horizon nonpositive shifted-subadditive processes."
lead: "Attach one positive bounded interval to every marked orbit start. Choosing all of them can create overlaps. The leftmost rule keeps one interval, removes the starts it already covers, and repeats. The selected intervals are ordered and disjoint, yet their union covers every original mark. This chapter develops that finite geometry, explains the empty, singleton, and abutting boundaries, and then derives weak and strict process bounds without an ergodic limit."
draft: false
pro_reviewed: false
level: "Finite sets, half-open intervals, strong induction, shifted subadditivity, positive-horizon nonpositivity, orbit-majorant centering, and one-sided matrix cocycles"
reading_time: "190 to 260 minutes"
prerequisites: "Natural-number arithmetic, finite half-open intervals, finite sets, function iteration, real inequalities, shifted-subadditive processes, orbit-majorant centering, and discrete matrix cocycles; no ergodic theorem is assumed"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveIntervalPacking"
toc: true
og_image: "finite-ordered-interval-packing-for-nonpositive-subadditive-processes-card.png"
og_image_alt: "Warm-paper numeric teaching card for H equals 10 and maximum length 4. Marks at 1, 2, 4, 5, 8, and 9 yield selected intervals [1,4), [4,6), and [8,12). Three cards show each leftmost selection round, and a lower strip decodes the packing as gaps and lengths summing to the enlarged horizon 14 while distinguishing three selected starts from nine covered positions."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The mathematics,
Lean declaration map, source correction, figures, and accessibility have not
yet passed the required human and Pro reviews. The page is publicly available
as an open working note while those reviews remain pending.
{{< /panel >}}

## Begin with six positions you can count by hand

Before introducing an indexed type or a subadditive process, compare two
families of half-open intervals inside the horizon \([0,10)\).

The valid family is

\[
[1,3),\qquad [3,4),\qquad [6,9).
\]

It covers the six positions

\[
\{1,2,3,6,7,8\}.
\]

Its interval lengths are \(2,1,3\), so the arithmetic ledger is

\[
[\text{sum of lengths},\text{size of union}]=[6,6].
\]

The equality is not a coincidence. The first two intervals merely abut:
the endpoint \(3\) is excluded from \([1,3)\) and included in \([3,4)\).
The endpoint tests \(3\le3\) and \(4\le6\) show that the family is ordered.

Now slide the middle interval one step left:

\[
[1,3),\qquad [2,4),\qquad [6,9).
\]

The covered set is still \(\{1,2,3,6,7,8\}\), but the three lengths now sum
to \(2+2+3=7\). The ledger becomes

\[
[7,6].
\]

The failed test \(3\le2\) identifies the overlap. Counting interval lengths
as though they were disjoint has counted position \(2\) twice.

{{< figure
  src="packing-cardinality-sign-and-boundaries.svg"
  alt="Two exact interval ledgers. The ordered family [1,3), [3,4), [6,9) has length sum and union size [6,6]. The overlapping family [1,3), [2,4), [6,9) has [7,6]. Below, six marked starts are compared with nine covered positions: multiplying by negative two reverses the inequality, while multiplying by positive two does not. Four boundary cards show the positive-time empty weak case, the time-zero failure, the empty strict failure, and a valid nonempty strict case."
  caption="The upper row is the same six-position worksheet used in the ordered-interval-packing glossary. The lower rows preview a different, larger greedy worksheet developed below. Keep the two interval families separate: the first diagnoses overlap; the second tests coverage, sign reversal, and theorem boundaries."
>}}

This small example gives the chapter's first invariant:

\[
\left|\bigcup_r I_r\right|
=\sum_r |I_r|
\]

only after order and disjointness have been established. It also exposes the
two legal edge cases that the representation must retain:

- a singleton such as \([3,4)\) has positive length one; and
- two intervals may abut when the first endpoint equals the next start.

The rest of the chapter scales this exact ledger up. We will start with six
marked positions, keep only three left endpoints, decode the resulting packing
from gaps and lengths, and then use a nonpositive coefficient to convert nine
covered positions into a bound by six marked starts.

A finite subadditive argument often reaches the following situation. Along an
orbit of a map \(T\), some starting positions are marked because a short
process interval beginning there has favorable average cost. The interval
length can vary with the start. If every marked interval were kept, overlaps
would prevent the sum of lengths from measuring the size of their union. If
intervals were discarded without a rule, marked starts could disappear from
the argument.

The solution is a leftmost packing rule. Select the interval at the least
remaining marked start. Remove every candidate whose start is already covered
by that interval. Repeat with the next remaining start. This produces a family
that is ordered and pairwise disjoint, while every original marked start is
still covered by some selected interval.

RMT-21 turns that sentence into a checked finite interface. It also proves the
finite process inequality needed after selection. The result is a bridge from
local favorable intervals to a bound by the number of marked starts. Nothing
in that bridge says how many starts are marked along a typical orbit. That
later density or ergodic step remains separate.

The immediate predecessor is
[Finite Phase Averaging for Nonpositive Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-phase-averaging-for-nonpositive-subadditive-processes" >}}).
The compact definition is the
{{< refterm "ordered-interval-packing" "ordered interval packing" >}}
glossary chapter. The declaration-complete implementation narrative is
[Pack the Marked Starts: Ordered Disjoint Intervals for Subadditive Cocycles in Lean]({{< relref "/development-notebook/2026/07/ordered-disjoint-interval-packing-for-subadditive-cocycles" >}}).

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| Intuition route | [From a favorable start to a bounded interval](#from-a-favorable-start-to-a-bounded-interval) | See why overlap and coverage must be solved together |
| Convention route | [Half-open intervals remove two off-by-one traps](#half-open-intervals-remove-two-off-by-one-traps) | Understand singleton and abutting intervals |
| Data route | [An indexed packing stores the proof in the data](#an-indexed-packing-stores-the-proof-in-the-data) | Read the gap-length-tail representation |
| Algorithm route | [The leftmost rule and why every deleted mark stays covered](#the-leftmost-rule-and-why-every-deleted-mark-stays-covered) | Rebuild the strong-induction selector |
| Counting route | [Exact covered cardinality and the marked-count inequality](#exact-covered-cardinality-and-the-marked-count-inequality) | Turn coverage into a length estimate |
| Dynamics route | [Discard only positive gaps in the subadditive proof](#discard-only-positive-gaps-in-the-subadditive-proof) | Charge the whole horizon to selected intervals |
| Boundary route | [Weak and strict marked-card bounds](#weak-and-strict-marked-card-bounds) | See why empty marks change the inequality symbol |
| Lean route | [The checked declaration architecture](#the-checked-declaration-architecture) | Locate every layer of the frozen API |
| Integrity route | [The exact stopping point](#the-exact-stopping-point) | Separate finite packing from Kingman's theorem |

### Learning objectives

By the summit, a reader should be able to:

1. define a half-open natural interval and calculate its cardinality;
2. translate an inclusive interval \([j,j+k-1]\) into \([j,j+k)\);
3. explain why \(k=1\) is a legal singleton;
4. explain why endpoint equality is legal for adjacent intervals;
5. distinguish a marked start from a covered position;
6. state the finite leftmost-selection problem;
7. decode a gap-length-tail packing into absolute endpoints;
8. explain why the packing horizon is a type index;
9. recover the list of selected intervals and its length;
10. recover the finite set of covered positions;
11. prove membership in that set has an interval witness;
12. derive pairwise endpoint order from recursive placement;
13. convert endpoint order to set disjointness;
14. derive exact covered cardinality;
15. distinguish <code>Covers</code> and <code>SelectedFrom</code>;
16. explain the absolute offset in <code>SelectedFromFrom</code>;
17. follow the minimum-and-filter selector step;
18. prove each deleted mark is covered;
19. prove the recursive tail horizon is smaller;
20. explain the branch where the selected interval crosses the old horizon;
21. derive the enlarged horizon \(H+m\);
22. distinguish generic endpoint containment from selector endpoint slack;
23. define recursive packing cost;
24. transport per-mark costs to selected interval costs;
25. sum weak costs over any packing;
26. state why strict cost summation requires nonempty packing;
27. split a shifted-subadditive process around selected intervals;
28. delete a positive initial gap;
29. avoid introducing an \(X_0\) term at zero gap;
30. avoid introducing an \(X_0\) term at zero terminal gap;
31. derive the weak covered-length process bound;
32. derive the strict covered-length process bound;
33. turn coverage into a marked-cardinality inequality;
34. reverse that inequality under \(c\le0\);
35. state the weak all-marked-sets theorem;
36. state the strict nonempty-mark theorem;
37. reproduce the empty-set strict counterexample;
38. reproduce the horizon-zero process counterexample;
39. interpret the candidate wrapper honestly;
40. interpret the centered-process wrapper honestly;
41. interpret the empty-index cocycle wrapper honestly;
42. identify which source claims are motivational rather than formal inputs;
43. explain why finite coverage is not an asymptotic density;
44. list the analytic infrastructure still missing before Kingman's theorem.

## The common setup and notation ledger

Let:

- \(\Omega\) be a state space;
- \(T:\Omega\to\Omega\) be a discrete-time map;
- \(X:\mathbb N\to\Omega\to\mathbb R\) be a finite-horizon process;
- \(H\in\mathbb N\) be a horizon containing eligible starts;
- \(m\in\mathbb N\) be a uniform upper bound on selected lengths;
- \(B\subseteq\{0,\ldots,H-1\}\) be a finite set of marked starts; and
- \(\ell:\mathbb N\to\mathbb N\) assign a length to each start, with
  \(0\lt\ell(j)\le m\) whenever \(j\in B\).

The shifted-subadditive convention is

\[
X_{a+b}(\omega)
\le
X_b\bigl(T^a\omega\bigr)+X_a(\omega).
\]

The later finite process theorem assumes

\[
n\ne0
\quad\Longrightarrow\quad
X_n(\omega)\le0.
\]

It does not assume a sign or normalization at time zero.

The coefficient \(c\in\mathbb R\) in a favorable interval estimate is
nonpositive. That sign is used only when a lower bound on selected length is
converted into the desired upper bound on process cost.

## From a favorable start to a bounded interval

At each \(j\in B\), suppose the chosen length satisfies a local estimate such
as

\[
X_{\ell(j)}\bigl(T^j\omega\bigr)
\le
c\,\ell(j).
\]

The corresponding geometric object is

\[
I_j=[j,j+\ell(j)).
\]

The length function can vary. One start may choose length one and the next
length five. Two such intervals can overlap even when their starts are
distinct. The selection problem is therefore not simply to sort a list.

We need two outcomes simultaneously:

1. selected intervals must be ordered and disjoint so their lengths add
   exactly; and
2. every original marked start must lie in the selected union so marked
   cardinality is controlled.

The second condition does not require every mark to remain a selected start.
A mark inside an earlier selected interval is allowed to disappear from the
candidate list because it is already covered.

## Half-open intervals remove two off-by-one traps

Lalley's lower-estimate discussion uses inclusive integer intervals
\([j,j+k-1]\) and the finite inequality labeled equation (6)
([Lalley](#ref-packing-deep-lalley)). The following greedy paragraph permits
\(1\le k\le m\).

The displayed endpoint chain nevertheless includes a strict comparison from
the start to \(j+k-1\). At \(k=1\), it asks \(j\lt j\). That is impossible,
although the interval should be the legal singleton \(\{j\}\).

The half-open translation is

\[
[j,j+k-1]
\quad\longleftrightarrow\quad
[j,j+k).
\]

Now positive length is exactly \(j\lt j+k\). The separation between two
inclusive intervals,

\[
j+k-1\lt j',
\]

becomes

\[
j+k\le j'.
\]

Equality means the intervals abut. No integer position is shared.

{{< panel "warning" >}}
**Do not copy the strict signs mechanically.** The first strict sign in the
inclusive display excludes singleton intervals. The second becomes a weak
endpoint-to-next-start comparison after translation to half-open intervals.
The Lean representation admits every positive length and every zero gap.
{{< /panel >}}

Mathlib's <code>Finset.Ico</code> and <code>Set.Ico</code> implement the same
convention in finite and set-theoretic forms
([Mathlib finite intervals](#ref-packing-deep-finset)).

### Repair the source at the level of sets

The safest translation begins with membership, not with a chain of endpoint
symbols. For \(k\gt0\), membership in Lalley's inclusive interval means

\[
r\in[j,j+k-1]
\quad\Longleftrightarrow\quad
j\le r\ \text{ and }\ r\le j+k-1.
\]

For natural numbers, the second comparison is equivalent to
\(r\lt j+k\). Therefore

\[
r\in[j,j+k-1]
\quad\Longleftrightarrow\quad
r\in[j,j+k).
\]

This extensional equality preserves the intended \(k\) positions. It also
shows exactly where the singleton lives. When \(k=1\), both presentations
denote \(\{j\}\); the half-open endpoint inequality is \(j\lt j+1\), which is
true. The displayed strict inequality \(j\lt j+k-1\) would instead become
\(j\lt j\), which is false. The repair removes that accidental exclusion
without changing the following stated range \(1\le k\le m\).

Now compare two selected intervals. The inclusive separation condition says
the last point of the first lies strictly before the first point of the next:

\[
j+k-1\lt j'.
\]

Over natural numbers this is equivalent to \(j+k\le j'\). That is exactly
the order needed for disjoint half-open intervals. Equality means the first
interval excludes the boundary that the second includes.

There are consequently two separate corrections:

1. positive length becomes the strict start-to-excluded-endpoint comparison
   \(j\lt j+k\); and
2. chronological separation becomes the weak comparison
   \(j+k\le j'\).

Keeping the first comparison strict and the second weak admits singletons and
abutment simultaneously. Strengthening either one changes the mathematical
class of packings.

## An indexed packing stores the proof in the data

An arbitrary list of endpoint pairs would require propositions saying:

- each start is below its endpoint;
- every endpoint is inside the horizon;
- the list is chronological; and
- different intervals are disjoint.

RMT-21 instead uses an indexed inductive family. The empty constructor selects
nothing but retains any horizon. The cons constructor stores a natural gap, a
positive interval length, and a valid recursive tail. Its result horizon is
definitionally the sum of those three lengths.

The first interval starts after the gap. The recursive tail begins after that
interval. Therefore every later interval begins no earlier than the current
endpoint. Zero gaps allow equality. Positive interval lengths rule out empty
selected regions.

The type does not promise that the packing is maximal, that its gaps are
minimal, or that it came from a selector. Those are separate questions.

## A concrete packing from gaps

Consider a horizon of ten positions. Choose:

- an initial gap of one;
- a selected length of two;
- a zero intermediate gap;
- a selected length of one;
- a gap of two;
- a selected length of three; and
- a terminal gap of one.

The decoded intervals are

\[
[1,3),\qquad[3,4),\qquad[6,9).
\]

The covered finite set is

\[
\{1,2,3,6,7,8\}.
\]

The interval count is three and covered length is six. The first two intervals
abut. The middle interval is a singleton. Every endpoint is at most ten.

The recursive representation can be read as a run-length description of the
horizon, alternating unselected gaps and selected regions. Unlike an arbitrary
binary mask, it also preserves interval boundaries.

## A complete greedy example, including deletion

Let the old start horizon be \(H=10\), the uniform length bound be \(m=4\),
and the marked set be

\[
B=\{1,2,4,5,8,9\}.
\]

Prescribe \(\ell(1)=3\), \(\ell(4)=2\), and \(\ell(8)=4\). The remaining
prescribed values may be any positive natural numbers at most four. They are
part of the input but are never inspected once their starts are deleted.

The first minimum is one. Its interval is \([1,4)\). The survivor filter keeps
exactly starts \(r\) satisfying \(4\le r\), so the state changes as follows:

\[
\{1,2,4,5,8,9\}
\longrightarrow
\{4,5,8,9\}.
\]

Why is deletion safe? A deleted mark \(r\) satisfies \(r\lt4\). Minimum
selection gives \(1\le r\). Hence \(r\in[1,4)\). In particular, the deleted
mark two remains covered even though it never becomes a selected start. The
mark four survives because it is the excluded endpoint.

The next minimum is four. Selecting \([4,6)\) produces

\[
\{4,5,8,9\}
\longrightarrow
\{8,9\}.
\]

The intervals \([1,4)\) and \([4,6)\) abut. Their shared written boundary
does not create a shared set member.

The next minimum is eight. The proposed endpoint is twelve, which passes the
old horizon endpoint ten. This is the selector's terminal branch. Every
remaining mark \(r\) satisfies \(8\le r\) by minimality and \(r\lt10\) by the
original start bound. Since \(10\le12\), both remaining marks lie in
\([8,12)\). No recursive survivor set is needed.

The final selected family is

\[
[1,4),\qquad[4,6),\qquad[8,12).
\]

Its gap-length-tail representation is

\[
\text{gap }1,\ \text{length }3,
\text{gap }0,\ \text{length }2,
\text{gap }2,\ \text{length }4,
\text{tail }2.
\]

The type index is not approximate bookkeeping. It checks the exact identity

\[
1+3+0+2+2+4+2=14=H+m.
\]

The last selected endpoint, twelve, is strictly below fourteen even though it
is beyond the old endpoint ten. The terminal tail of two fills the remainder
of the indexed horizon.

The union contains nine positions:

\[
\operatorname{coveredFinset}(P)
=\{1,2,3,4,5,8,9,10,11\}.
\]

Here is the distinction between selection provenance and coverage in full.
Every selected start is covered, but three covered marks were deliberately
discarded:

| Original mark \(j\) | Selected as a left endpoint? | Covered by the selected union? |
|---:|:---:|:---:|
| \(1\) | yes | yes |
| \(2\) | no | yes |
| \(4\) | yes | yes |
| \(5\) | no | yes |
| \(8\) | yes | yes |
| \(9\) | no | yes |

The selected-start set is \(\{1,4,8\}\). The covered set is larger because an
interval covers positions, not merely its own left endpoint. The proof needs
both facts: selected intervals inherit local cost hypotheses from their
left endpoints, while coverage controls the cardinality of the original
marked set.

{{< figure
  src="leftmost-greedy-packing-ledger.svg"
  alt="A numbered horizon from zero through thirteen with marks at 1, 2, 4, 5, 8, and 9. Three selected half-open intervals are [1,4), [4,6), and [8,12). Three round cards show the remaining marks, the marks covered in that round, and the survivors. A final strip decodes the packing as gap 1, length 3, gap 0, length 2, gap 2, length 4, tail 2, summing to fourteen. The footer distinguishes selected starts 1, 4, 8 from nine covered positions."
  caption="The complete larger worksheet. Leftmost selection chooses 1, then 4, then 8. The last interval crosses the old endpoint \(H=10\) but stays inside the enlarged packing horizon \(H+m=14\). The diagram is finite bookkeeping, not a density or convergence plot."
>}}

Thus

\[
|B|=6\le9=\operatorname{coveredLength}(P).
\]

The interval count is only three. Neither interval count nor covered length
equals marked cardinality in general. The proof needs the chain

\[
|B|
\le|\operatorname{coveredFinset}(P)|
=\operatorname{coveredLength}(P),
\]

not a claim that one interval was selected for every mark.

Now take \(c=-2\). Suppose the three selected costs are bounded by
\(-6\), \(-4\), and \(-8\), the coefficient times their respective
lengths. Summation gives

\[
\operatorname{cost}(P)\le-18=c\cdot9.
\]

Coverage gives \(6\le9\), but the coefficient is nonpositive, so the
real-number comparison reverses:

\[
-18=c\cdot9\le c\cdot6=-12.
\]

If the raw packing inequality gives
\(X_{14}(\omega)\le\operatorname{cost}(P)\), transitivity yields
\(X_{14}(\omega)\le-12=c|B|\). This is the complete finite route from local
favorable intervals to a marked-cardinality estimate.

## Covered positions, interval provenance, and three distinct predicates

Three propositions should never be conflated.

### Geometric validity

Every value of <code>OrderedNatIntervalPacking N</code> is geometrically valid
inside \(N\). Public theorems recover endpoint containment, chronological
order, and pairwise disjointness.

### Coverage

<code>P.Covers B</code> means

\[
B\subseteq P.\operatorname{coveredFinset}.
\]

It says every mark is contained. It says nothing about the origin of selected
intervals.

### Selection provenance

<code>P.SelectedFrom B ell</code> means every selected interval begins at a
member of \(B\) and has the prescribed length there. It says nothing about
whether unselected marks are covered.

The greedy theorem returns all three layers: geometric validity through the
type, coverage through <code>Covers</code>, and provenance through
<code>SelectedFrom</code>.

The recursive predicate is named <code>SelectedFromFrom</code> because it must
remember an absolute offset. The packing tail stores relative gaps. The marked
set and process hypotheses use absolute orbit positions. The offset is the
bridge between those coordinate systems.

## The leftmost rule and why every deleted mark stays covered

{{< reference-figure
  src="leftmost-selection-covers-every-mark.svg"
  alt="Three rows show a finite leftmost interval-selection algorithm. The first row chooses the earliest mark and shades every mark its interval covers. The second row retains only starts at or beyond that endpoint and chooses the next one. The final row contains ordered disjoint selected intervals whose union includes every original mark. Different marker shapes identify selected starts, covered deleted starts, and unmarked positions."
  caption="**Finding:** deletion is the coverage proof. A marked start is removed only when it lies inside the interval just selected, so it remains represented in the selected union. Starts at the right endpoint survive because the intervals are half-open, permitting the next interval to abut. The final family is ordered and disjoint by construction. The plate illustrates the finite selector, not a density or maximality theorem."
>}}

The offset selector proceeds by strong induction on the remaining old-horizon
length.

If no marks remain, return an empty packing whose horizon includes the old
tail and the uniform extra allowance \(m\).

Otherwise, let \(j\) be the least marked start and let \(k=\ell(j)\). The
positive-length premise gives \(j\lt j+k\).

There are two branches.

### The interval ends within the old horizon

Keep \([j,j+k)\). Filter the remaining marked set by the predicate

\[
j+k\le r.
\]

A removed mark \(r\lt j+k\) is at least \(j\) because \(j\) was least, so it
lies in the selected interval. A surviving mark lies at or to the right of the
endpoint. The recursive old tail is strictly shorter, so strong induction
applies.

The recursive selector certifies provenance relative to the filtered set.
Because that set is a subset of the original marked set,
<code>SelectedFromFrom.mono</code> widens the certificate.

### The interval crosses the old horizon

Keep the same interval and stop. Every marked start was below the old horizon,
at least \(j\), and now strictly below \(j+k\). Thus one interval covers all
remaining marks.

This branch is not an error case. It is the reason the target horizon is
enlarged.

## Strong induction and the two endpoint branches

Ordinary successor induction would force the proof to decrement the horizon by
one. The selector can jump by the selected interval length and by the distance
from the current offset to the leftmost mark. Strong induction instead allows
recursion at any strictly smaller remaining horizon.

The proof must reconstruct the target type index after each recursive call.
Suppose the selected start is \(j\), current offset is \(o\), interval length is
\(k\), and recursive old tail length is \(R\). The new packing horizon is

\[
(j-o)+k+(R+m)=H+m.
\]

The natural-number equalities include truncated subtraction. The branch
hypotheses ensure the subtractions are exact, and Lean's <code>omega</code>
tactic closes the linear arithmetic.

In the crossing branch, the terminal tail is chosen as the difference between
\(H+m\) and the used prefix plus interval. The length bound \(k\le m\) proves
this difference is defined and reconstructs the same target index.

## Why \(H+m\) is the correct enlarged horizon

The eligible-start premise controls only \(j\lt H\). The length premise gives
\(k\le m\). Therefore

\[
j+k\lt H+m.
\]

The strict endpoint slack is stronger than the generic packing invariant. A
generic interval may end exactly at its ambient horizon. The selector target
has an extra uniform length allowance, so every selected endpoint is strictly
inside it.

Why not use \(H+m-1\)? In natural arithmetic that expression complicates the
empty and zero cases, while \(H+m\) is uniform and follows directly from the
hypotheses. The later process theorem evaluates \(X_{H+m}\). This has the same
start-window-plus-maximal-length shape as Lalley's \(nm+m\) horizon, but it is
a zero-based adaptation rather than an exact reindexing of Lalley's marked
sample window.

Why not use an infinite interval family? The subsequent subadditive inequality
is finite. Keeping a finite explicit horizon lets Lean audit every gap and
time-zero branch before any limiting argument is designed.

## Exact covered cardinality and the marked-count inequality

The interval decoder provides an ordered list. The covered decoder provides a
finite union. The crucial theorem proves

\[
|P.\operatorname{coveredFinset}|
=P.\operatorname{coveredLength}.
\]

Inductively, the current <code>Finset.Ico</code> is disjoint from the recursive
tail. Its cardinality is the current selected length. Mathlib then adds the
cardinalities of the disjoint union
([finite-set cardinality](#ref-packing-deep-card)).

Coverage gives

\[
|B|
\le
|P.\operatorname{coveredFinset}|
=P.\operatorname{coveredLength}.
\]

The inequality can be strict. If marks zero and one choose lengths three and
one, the leftmost selector may keep \([0,3)\) alone. It covers both marks, while
selected covered length is three and marked cardinality is two.

This strictness is useful when \(c\le0\): a longer selected cover gives a more
negative intermediate bound, which is at most the desired marked-card bound.

## The selected cost is not a pointwise sum

For a selected interval \([j,j+k)\), the cost contribution is

\[
X_k(T^j\omega).
\]

It is one variable-horizon process value. It is not defined as

\[
\sum_{r=0}^{k-1}X_1(T^{j+r}\omega).
\]

Shifted subadditivity may bound the first expression by a sum of smaller
pieces, but it does not make them equal. This distinction is essential for a
genuinely subadditive process.

The recursive <code>cost</code> definition evaluates the first selected
interval after its prefix gap, then evaluates the recursive tail after both the
gap and interval. Natural-iterate addition proves that this nested sample shift
equals the absolute interval start recovered by <code>SelectedFromFrom</code>
([function iteration](#ref-packing-deep-iterate)).

## Discard only positive gaps in the subadditive proof

Let \(P\) be a packing inside a nonzero horizon \(N\). Repeated shifted
subadditivity decomposes \(X_N\) into selected interval terms and gap terms.
Every positive gap has nonpositive process value and may be discarded from the
upper bound.

The proof must not say every gap is nonpositive. A zero gap would ask for
\(X_0\le0\), which is not assumed.

Three branches prevent that mistake:

1. **Zero initial gap.** Start directly with the first selected interval.
2. **Zero terminal tail.** Stop at the final interval instead of splitting a
   zero remainder.
3. **Nonempty recursive tail.** Its horizon is positive because it contains a
   positive-length interval, even if its own leading gap is zero.

The resulting raw inequality is

\[
X_N(\omega)
\le
P.\operatorname{cost}(T,X,\omega).
\]

An empty packing at positive \(N\) reduces the theorem to \(X_N\le0\). At
\(N=0\), the theorem is false without a time-zero premise. This exact boundary
is retained rather than hidden behind \(X_0=0\).

## Transport per-mark costs through <code>SelectedFrom</code>

The selector hypothesis is naturally stated at marked starts:

\[
\forall j\in B,
\quad
X_{\ell(j)}(T^j\omega)
\le c\,\ell(j).
\]

The recursive packing-cost theorem wants the same fact at every cons node.
The <code>SelectedFromFrom.everyIntervalCostLE</code> theorem transports it.
Its strict sibling transports a strict inequality. The zero-offset public
forms remove the initial iterate by zero.

These bridge theorems are why <code>SelectedFrom</code> is not replaced by a
mere endpoint-list proposition. Its recursive shape aligns with the recursive
cost definition and makes the orbit shifts provable by induction.

Weak interval bounds sum over any packing:

\[
P.\operatorname{cost}
\le
c\,P.\operatorname{coveredLength}.
\]

Strict interval bounds sum strictly only if the packing contains an interval.
The empty recursion branch carries <code>True</code>, but an empty strict sum
would demand \(0\lt0\).

## Weak and strict marked-card bounds

Combine four finite facts:

1. the whole horizon is at most the packing cost;
2. local weak or strict estimates bound packing cost by \(cL\);
3. coverage gives \(|B|\le L\); and
4. \(c\le0\) gives \(cL\le c|B|\).

The universal weak conclusion is

\[
X_N(\omega)
\le
c|B|.
\]

It requires \(N\ne0\), even if \(B\) is empty.

The strict conclusion is

\[
X_N(\omega)
\lt
c|B|.
\]

It requires \(B\) to be nonempty. Coverage then forces a nonempty packing, so
horizon positivity follows automatically.

The end-to-end greedy theorems instantiate \(N=H+m\), construct \(P\), use
<code>SelectedFrom</code> to transport per-mark costs, and use
<code>Covers</code> for cardinality.

{{< reference-figure
  src="empty-singleton-and-abutting-boundaries.svg"
  alt="Three panels show boundary cases. An empty marked set produces an empty packing and supports a weak conclusion only at positive enlarged horizon. A one-position interval is labeled legal positive length. Two adjacent half-open intervals meet at an endpoint and are labeled disjoint with zero gap."
  caption="**Finding:** the boundary cases fix three public choices. Empty marks make every strict local hypothesis vacuous, so only the weak marked-card theorem can apply, and it retains an explicit positive enlarged-horizon premise. Positive length includes one, so singleton intervals are legal. A zero gap allows half-open intervals to abut while remaining disjoint. None of these cases is removed by an auxiliary normalization."
>}}

### Why the empty set destroys universal strictness

Take \(X_n=0\) at positive horizons and \(B=\varnothing\). Every statement of
the form

\[
\forall j\in B,\quad X_{\ell(j)}(T^j\omega)\lt c\ell(j)
\]

is true because there is no \(j\). The selected packing can be empty. Its cost
and \(c|B|\) are both zero. A strict conclusion would be \(0\lt0\).

This is a mathematical counterexample, not a Lean inconvenience. The strict
theorem therefore accepts <code>marked.Nonempty</code>.

### Why time zero destroys an unconditional weak theorem

Define \(X_0=1\) and \(X_n=-n\) for positive \(n\). This process is
shifted-subadditive and nonpositive at positive horizons. The empty packing at
horizon zero has cost zero, so \(X_0\le0\) fails.

The weak greedy theorem retains \(H+m\ne0\). The strict theorem derives it from
nonempty marks and positive selected length.

## Candidate and cocycle wrappers

The generic candidate wrapper has a measurable space, a measure, and a finite
horizon integrability field in its receiver type. The pointwise packing proof
uses only its shifted-subadditivity field, plus a separate positive-horizon
sign hypothesis. Prose should distinguish receiver baggage from consumed
fields.

The orbit-majorant-centered process already has the two algebraic properties
needed here:

- shifted subadditivity; and
- nonpositivity at positive horizons.

Its packing theorem needs no \(X_0=0\) and no extra preservation theorem.

The discrete matrix-cocycle wrapper specializes to the centered log-positive
norm observable. It imposes no generator-integrability package, probability,
ergodicity, or nonempty matrix index. The cocycle receiver still stores base
preservation because that is part of the object, but this finite pointwise
proof does not use an integral.

The observable remains log-positive. It controls expansion after clipping
contraction and is not a signed Lyapunov observable.

## Seven bridges from paper mathematics to checked Lean

Each bridge below says the same fact three ways: first as a sentence a human
might write, then as mathematics, then as the exact Lean interface. The
project declarations import Mathlib and belong on the guarded Linux builder.
The later `Std` worksheet is intentionally small enough for an ordinary Mac
or Linux computer.

### Lean bridge 1: the data itself enforces positive lengths

{{< lean-bridge
  human="An empty packing may have any horizon. To add an interval, record a gap, a positive length, and the remaining packing; the new horizon is their exact sum."
  math="\(\frac{0\lt\ell\quad P:\mathcal P(t)}{\operatorname{cons}(g,\ell,P):\mathcal P(g+\ell+t)}.\)"
  lean="OrderedNatIntervalPacking.cons gap length length_pos rest"
>}}

**Exact project declaration.**

~~~lean
inductive OrderedNatIntervalPacking : ℕ → Type
  | empty (horizon : ℕ) : OrderedNatIntervalPacking horizon
  | cons (gap length : ℕ) {tail : ℕ} (length_pos : 0 < length)
      (rest : OrderedNatIntervalPacking tail) :
      OrderedNatIntervalPacking (gap + length + tail)
~~~

Read `ℕ → Type` as “one type for each natural-number horizon.”
`length_pos` is a proof stored with the constructor. Braces around `{tail :
ℕ}` make the tail horizon implicit, so Lean infers it from `rest`. The result
index `gap + length + tail` is the gap-length-tail equation, not a later
side condition.
{{< /lean-bridge >}}

### Lean bridge 2: covered membership has an interval witness

{{< lean-bridge
  human="A position is covered exactly when one decoded half-open interval starts at or before it and ends strictly after it."
  math="\(j\in\operatorname{covered}(P)\Longleftrightarrow\exists(a,b)\in\operatorname{intervals}(P),\ a\le j\lt b.\)"
  lean="P.mem_coveredFinset_iff_exists_interval"
>}}

**Exact project declaration.**

~~~lean
theorem mem_coveredFinset_iff_exists_interval {N j : ℕ}
    (P : OrderedNatIntervalPacking N) :
    j ∈ P.coveredFinset ↔
      ∃ I ∈ P.intervals, I.1 ≤ j ∧ j < I.2
~~~

`↔` is logical equivalence. The phrase `∃ I ∈ P.intervals` introduces an
endpoint pair and its list-membership proof. `I.1` and `I.2` are its left and
right endpoints. The strict `j < I.2` is the excluded right edge of
`Finset.Ico`.
{{< /lean-bridge >}}

### Lean bridge 3: disjoint geometry becomes exact cardinality

{{< lean-bridge
  human="Because decoded intervals are ordered and disjoint, the number of covered positions equals the sum of selected lengths."
  math="\(\left|\operatorname{covered}(P)\right|=\operatorname{coveredLength}(P).\)"
  lean="P.card_coveredFinset"
>}}

**Exact project declaration.**

~~~lean
theorem card_coveredFinset {N : ℕ} (P : OrderedNatIntervalPacking N) :
    P.coveredFinset.card = P.coveredLength
~~~

The dot in `P.coveredFinset.card` chains two projections: decode the finite
covered set, then count it. The theorem is exact equality, not an upper bound.
Its shifted helper proves the current `Finset.Ico` disjoint from the recursive
tail before applying finite-union cardinality.
{{< /lean-bridge >}}

### Lean bridge 4: leftmost selection returns coverage and provenance

{{< lean-bridge
  human="Bounded positive lengths on marked starts inside [0,H) produce a packing inside [0,H+m). Every original mark is covered, and every selected interval came from a marked start with its prescribed length."
  math="\(B\subseteq[0,H),\ 0\lt\ell(j)\le m\ (j\in B)\Longrightarrow\exists P:\mathcal P(H+m),\ B\subseteq\operatorname{covered}(P)\land P\operatorname{\ selectedFrom}(B,\ell).\)"
  lean="exists_orderedPacking_covering H m marked length hmarked hlength"
>}}

**Exact project declaration.**

~~~lean
theorem exists_orderedPacking_covering
    (H m : ℕ) (marked : Finset ℕ) (length : ℕ → ℕ)
    (hmarked : marked ⊆ Finset.range H)
    (hlength : ∀ j ∈ marked, 0 < length j ∧ length j ≤ m) :
    ∃ P : OrderedNatIntervalPacking (H + m),
      P.Covers marked ∧
        P.SelectedFrom marked length
~~~

`Finset.range H` is \(\{0,\ldots,H-1\}\). `∀ j ∈ marked` means “for every
natural \(j\), if \(j\) is marked.” The returned conjunction keeps `Covers`
and `SelectedFrom` distinct. The private proof selects `marked.min'`, filters
survivors at or beyond the chosen endpoint, and recurses by strong induction.
{{< /lean-bridge >}}

### Lean bridge 5: positive gaps may be discarded, zero gaps may not

{{< lean-bridge
  human="Shifted subadditivity decomposes a positive horizon into selected interval costs and gaps. Every nonzero gap costs at most zero, so the whole process value is at most the selected cost."
  math="\(X_{a+b}(\omega)\le X_b(T^a\omega)+X_a(\omega),\ n\ne0\Rightarrow X_n(\omega)\le0,\ N\ne0\Rightarrow X_N(\omega)\le\operatorname{cost}(P,T,X,\omega).\)"
  lean="P.le_cost_of_add_le_nonpos hadd hnonpos hN ω"
>}}

**Exact project declaration.**

~~~lean
theorem le_cost_of_add_le_nonpos
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    {N : ℕ} (P : OrderedNatIntervalPacking N) (hN : N ≠ 0) (ω : Ω) :
    X N ω ≤ P.cost T X ω
~~~

`T^[m]` is Lean's notation for the \(m\)-fold iterate of `T`. The premise
`n ≠ 0` is intentionally inside `hnonpos`; the theorem never assumes
`X 0 ω ≤ 0`. The separate `hN` prevents the empty time-zero counterexample.
{{< /lean-bridge >}}

### Lean bridge 6: a nonpositive coefficient reverses the counting inequality

{{< lean-bridge
  human="If a packing covers all marks, every selected interval has weak cost at most c times its length, and c is nonpositive, then the process is bounded by c times the number of marks."
  math="\(|B|\le L,\ c\le0,\ X_N\le cL\Longrightarrow X_N\le cL\le c|B|.\)"
  lean="P.le_mul_card_of_add_le_nonpos_of_covers hadd hnonpos hN marked hcover ω c hc hcost"
>}}

**Exact project declaration.**

~~~lean
theorem le_mul_card_of_add_le_nonpos_of_covers
    {Ω : Type uΩ} {T : Ω → Ω} {X : ℕ → Ω → ℝ}
    (hadd : ∀ m n ω, X (m + n) ω ≤ X n (T^[m] ω) + X m ω)
    (hnonpos : ∀ n, n ≠ 0 → ∀ ω, X n ω ≤ 0)
    {N : ℕ} (P : OrderedNatIntervalPacking N) (hN : N ≠ 0)
    (marked : Finset ℕ) (hcover : P.Covers marked)
    (ω : Ω) (c : ℝ) (hc : c ≤ 0)
    (hcost : P.EveryIntervalCostLE T X ω c) :
    X N ω ≤ c * (marked.card : ℝ)
~~~

`(marked.card : ℝ)` is a type cast from a natural count to a real number.
`hc` supplies the sign needed by `mul_le_mul_of_nonpos_left`. With \(c=+2\),
the numeric worksheet would demand \(18\le12\), so deleting `hc` would make
the conclusion false.
{{< /lean-bridge >}}

### Lean bridge 7: strictness needs at least one marked start

{{< lean-bridge
  human="Strict favorable estimates yield a strict marked-card bound only when the marked set is nonempty."
  math="\(B\ne\varnothing,\ X_{\ell(j)}(T^j\omega)\lt c\ell(j)\ (j\in B)\Longrightarrow X_{H+m}(\omega)\lt c|B|.\)"
  lean="lt_mul_card_of_greedy_cover hadd hnonpos H m marked length hmarked hlength hmarked_nonempty ω c hc hcost"
>}}

**Exact project declaration.**

~~~lean
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
    X (H + m) ω < c * (marked.card : ℝ)
~~~

`marked.Nonempty` provides a witness. Coverage then forces a nonempty packing,
so the selected strict costs contain at least one term and the horizon is
positive. Without that witness, every local premise is vacuous and the target
can collapse to \(0\lt0\).
{{< /lean-bridge >}}

### Type-check the seven project bridges

{{< repo-check module="NonlinearDynamics.Random.RandomCocycles.SubadditiveIntervalPacking" >}}

The seven bridge endpoints can be queried in a project scratch file with:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.SubadditiveIntervalPacking

open NonlinearDynamics.Random.RandomCocycles

#check OrderedNatIntervalPacking
#check OrderedNatIntervalPacking.mem_coveredFinset_iff_exists_interval
#check OrderedNatIntervalPacking.card_coveredFinset
#check OrderedNatIntervalPacking.exists_orderedPacking_covering
#check OrderedNatIntervalPacking.le_cost_of_add_le_nonpos
#check OrderedNatIntervalPacking.le_mul_card_of_add_le_nonpos_of_covers
#check OrderedNatIntervalPacking.lt_mul_card_of_greedy_cover
~~~

`#check` asks Lean to print the inferred type without constructing new data or
running a proof. These queries correspond in order to the seven bridges above.

On an approved Linux builder, from the repository root, a human types:

~~~sh
source "$HOME/.elan/env"
CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/Random/RandomCocycles/SubadditiveIntervalPacking.lean
~~~

This is a **project/Mathlib check**. It restores or builds substantial
dependencies and must use the guarded Linux workflow, such as a
human-approved Runpod. Do not run it on the Mac workstation. The command
checks the source file containing all seven declarations with warnings treated
as errors and with the pinned manifest integrity gate.
{{< /repo-check >}}

## The checked declaration architecture

The frozen source has fifty-four public named declarations and thirteen
private named declarations. The architecture is best read in nine layers.

### Layer 1: representation and two decoders

<code>OrderedNatIntervalPacking</code>, <code>intervalCount</code>,
<code>coveredLength</code>, <code>intervalsFrom</code>, <code>intervals</code>,
<code>length_intervalsFrom</code>, <code>length_intervals</code>,
<code>coveredFinsetFrom</code>, and <code>coveredFinset</code> define and decode
the structural object.

### Layer 2: membership, bounds, and exact cardinality

The two covered-membership equivalences connect the finite union to decoded
intervals. <code>mem_coveredFinsetFrom_bounds</code> supplies containment.
<code>card_coveredFinsetFrom</code> and <code>card_coveredFinset</code> compute
exact size. <code>coveredFinset_subset_range</code> gives the public horizon
containment.

### Layer 3: coverage and interval geometry

<code>Covers</code>,
<code>intervalCount_ne_zero_of_covers_of_nonempty</code>, and
<code>card_le_coveredLength_of_covers</code> form the coverage interface. The
five <code>intervals...</code> theorems prove shifted containment, endpoint
order, pairwise set disjointness, and public containment.

### Layer 4: provenance and selection

<code>SelectedFromFrom</code>, <code>SelectedFrom</code>, monotonicity, both
decoded-interval provenance theorems, and the enlarged-horizon endpoint theorem
expose selection provenance. The private
<code>exists_orderedPacking_covering_from</code> is the strong-induction engine;
<code>exists_orderedPacking_covering</code> is the public selector.

### Layer 5: local costs

<code>cost</code>, the two horizon-length facts, the weak and strict recursive
cost predicates, strict-to-weak conversion, four provenance-to-cost bridges,
and the two total-cost theorems turn local hypotheses into selected-length
bounds.

### Layer 6: raw and covered-length process inequalities

<code>le_cost_of_add_le_nonpos</code> and its nonempty form charge the horizon to
the packing. The weak and strict covered-length theorems compose that bound
with local costs.

### Layer 7: marked-cardinality and end-to-end selector inequalities

The two <code>...of_covers</code> theorems use coverage and \(c\le0\). The weak
and strict <code>...of_greedy_cover</code> theorems add selector existence and
per-mark cost transport.

### Layer 8: project wrappers

Two candidate methods, one centered-process method, and one direct
matrix-cocycle method expose the finite packing sum and covered-length form in
the established project namespaces.

### Layer 9: private regression fixtures

The time-zero witness and candidate test the exact missing normalization. The
empty, full-terminal, abutting, outer-gap, intermediate-gap, singleton,
long-choice, and long-cover fixtures test every endpoint and cardinality
boundary. Anonymous examples check empty selector output, unit abutment,
strict versus weak marked-card bounds, a strict coverage inequality, positive
and zero gaps, final endpoints, centered wrappers, and empty matrix dimension.

The
[Development Notebook]({{< relref "/development-notebook/2026/07/ordered-disjoint-interval-packing-for-subadditive-cocycles" >}})
lists all sixty-seven named declarations individually in exact source order.

### Complete declaration manifest

This chapter also records that source-order manifest directly, so a reader can
audit the frozen module without treating any helper as invisible prose. The
public surface contains exactly fifty-four names:

| No. | Public declaration | Contract in this chapter |
|---:|---|---|
| 1 | <code>OrderedNatIntervalPacking</code> | Indexed gap-length-tail representation |
| 2 | <code>intervalCount</code> | Number of selected intervals |
| 3 | <code>coveredLength</code> | Sum of selected lengths |
| 4 | <code>intervalsFrom</code> | Decode endpoints from an absolute offset |
| 5 | <code>intervals</code> | Decode endpoints from zero |
| 6 | <code>length_intervalsFrom</code> | Shifted decoder preserves interval count |
| 7 | <code>length_intervals</code> | Public decoder preserves interval count |
| 8 | <code>coveredFinsetFrom</code> | Decode the shifted finite covered union |
| 9 | <code>coveredFinset</code> | Decode the zero-offset covered union |
| 10 | <code>mem_coveredFinsetFrom_iff_exists_interval</code> | Shifted membership has an interval witness |
| 11 | <code>mem_coveredFinset_iff_exists_interval</code> | Public membership has an interval witness |
| 12 | <code>mem_coveredFinsetFrom_bounds</code> | Shifted covered positions lie in the shifted horizon |
| 13 | <code>card_coveredFinsetFrom</code> | Shifted covered cardinality equals covered length |
| 14 | <code>card_coveredFinset</code> | Public covered cardinality equals covered length |
| 15 | <code>coveredFinset_subset_range</code> | Covered positions lie in <code>Finset.range N</code> |
| 16 | <code>Covers</code> | Every marked point belongs to the covered union |
| 17 | <code>intervalCount_ne_zero_of_covers_of_nonempty</code> | A nonempty covered set forces a nonempty packing |
| 18 | <code>card_le_coveredLength_of_covers</code> | Coverage gives marked count at most covered length |
| 19 | <code>intervalsFrom_inside</code> | Shifted decoded endpoints stay inside their horizon |
| 20 | <code>intervalsFrom_pairwise</code> | Earlier shifted intervals end before later starts |
| 21 | <code>intervals_pairwise</code> | Zero-offset endpoint order |
| 22 | <code>intervals_pairwiseDisjoint_Ico</code> | Decoded half-open sets are pairwise disjoint |
| 23 | <code>intervals_inside</code> | Zero-offset endpoint containment |
| 24 | <code>SelectedFromFrom</code> | Recursive shifted selection provenance |
| 25 | <code>SelectedFrom</code> | Zero-offset selection provenance |
| 26 | <code>SelectedFromFrom.mono</code> | Provenance survives enlarging the eligible set |
| 27 | <code>SelectedFromFrom.intervalsFrom_chosen</code> | Shifted decoded intervals expose their chosen start and length |
| 28 | <code>SelectedFrom.intervals_chosen</code> | Public decoded intervals expose their chosen start and length |
| 29 | <code>SelectedFrom.interval_end_lt_enlargedHorizon</code> | Selected endpoints have strict \(H+m\) slack |
| 30 | <code>exists_orderedPacking_covering</code> | Public leftmost cover and provenance theorem |
| 31 | <code>cost</code> | Recursive sum of selected shifted process values |
| 32 | <code>coveredLength_le_horizon</code> | Selected length never exceeds the packing horizon |
| 33 | <code>horizon_pos_of_intervalCount_ne_zero</code> | A nonempty packing has positive horizon |
| 34 | <code>EveryIntervalCostLE</code> | Recursive weak local-cost predicate |
| 35 | <code>EveryIntervalCostLT</code> | Recursive strict local-cost predicate |
| 36 | <code>EveryIntervalCostLT.le</code> | Strict local costs imply weak local costs |
| 37 | <code>SelectedFromFrom.everyIntervalCostLE</code> | Shifted provenance transports weak marked costs |
| 38 | <code>SelectedFromFrom.everyIntervalCostLT</code> | Shifted provenance transports strict marked costs |
| 39 | <code>SelectedFrom.everyIntervalCostLE</code> | Public provenance transports weak marked costs |
| 40 | <code>SelectedFrom.everyIntervalCostLT</code> | Public provenance transports strict marked costs |
| 41 | <code>cost_le_mul_coveredLength</code> | Weak local costs sum to a weak covered-length bound |
| 42 | <code>cost_lt_mul_coveredLength</code> | Strict local costs sum strictly for nonempty packings |
| 43 | <code>le_cost_of_add_le_nonpos</code> | Positive-horizon process value is at most packing cost |
| 44 | <code>le_cost_of_add_le_nonpos_of_nonempty</code> | Nonempty packing supplies the positive horizon |
| 45 | <code>le_mul_coveredLength_of_add_le_nonpos</code> | Weak process bound by covered length |
| 46 | <code>lt_mul_coveredLength_of_add_le_nonpos</code> | Strict process bound by covered length |
| 47 | <code>le_mul_card_of_add_le_nonpos_of_covers</code> | Weak covered packing bound by marked count |
| 48 | <code>lt_mul_card_of_add_le_nonpos_of_covers</code> | Strict nonempty covered packing bound by marked count |
| 49 | <code>le_mul_card_of_greedy_cover</code> | End-to-end weak greedy marked-count theorem |
| 50 | <code>lt_mul_card_of_greedy_cover</code> | End-to-end strict nonempty greedy theorem |
| 51 | <code>IsIntegrableSubadditiveProcessCandidate.le_orderedIntervalPackingSum</code> | Candidate-facing packing-cost wrapper |
| 52 | <code>IsIntegrableSubadditiveProcessCandidate.le_mul_coveredLength_of_orderedIntervalPacking</code> | Candidate-facing covered-length wrapper |
| 53 | <code>IsIntegrableSubadditiveProcessCandidate.centeredProcess_le_orderedIntervalPackingSum</code> | Orbit-majorant-centered packing wrapper |
| 54 | <code>DiscreteMatrixCocycle.centeredLogPlusNormObservable_le_orderedIntervalPackingSum</code> | Centered log-positive cocycle wrapper |

The thirteen private named declarations are implementation machinery or
regression fixtures. They are not additional public assumptions:

| No. | Private declaration | Why it exists |
|---:|---|---|
| 1 | <code>exists_orderedPacking_covering_from</code> | Offset strong-induction selector used by the public existence theorem |
| 2 | <code>positiveAtZeroProcess</code> | Concrete \(X_0=1\), positive-time nonpositive boundary process |
| 3 | <code>positiveAtZeroProcess_add_le</code> | Shifted-subadditivity proof for that boundary process |
| 4 | <code>positiveAtZeroProcess_nonpos</code> | Positive-horizon sign proof for that boundary process |
| 5 | <code>positiveAtZeroCandidate</code> | Candidate fixture retaining the time-zero counterexample |
| 6 | <code>emptyPositivePacking</code> | Empty packing at positive horizon |
| 7 | <code>fullTerminalPacking</code> | Selected interval ending exactly at a generic horizon |
| 8 | <code>abuttingPacking</code> | Zero-gap abutting intervals |
| 9 | <code>packingWithOuterGaps</code> | Nonzero initial and terminal gaps |
| 10 | <code>unitAbuttingPacking</code> | Length-one intervals with zero intermediate gap |
| 11 | <code>packingWithIntermediateGap</code> | Positive gap between selected intervals |
| 12 | <code>longChoice</code> | Prescribed-length fixture whose first interval covers later marks |
| 13 | <code>longCoverPacking</code> | Expected packing for the long-choice selector test |

Unnamed `example` declarations below these fixtures exercise equalities,
inequalities, endpoints, wrapper specializations, and empty-index matrix
behavior. They are checked regression examples, but they do not add names to
the fifty-four-plus-thirteen manifest.

## Why the public API has this shape

Several tempting convenience theorems are deliberately absent from the frozen
surface.

There is no single predicate combining <code>Covers</code> and
<code>SelectedFrom</code>. A packing can cover a marked set even when its
intervals came from elsewhere, and it can be selected from eligible marks
while failing to cover all of them. Keeping the predicates separate lets
later arguments consume only the contract they need. The greedy existence
theorem returns their conjunction because that construction proves both.

There is no separate marked-card theorem from packing cost alone. The useful
route needs three logically different ingredients: a process-to-packing-cost
inequality, a local-cost-to-covered-length inequality, and a
coverage-to-marked-cardinality comparison under a nonpositive coefficient.
The public <code>...of_covers</code> declarations expose that composition
without pretending the packing cost itself contains marked-set information.

There is also no extensional equivalence theorem saying that equality of
decoded interval lists is the same as equality of indexed packing values.
The representation stores proof-relevant positive-length witnesses and
recursive horizon structure. Downstream mathematics uses decoded intervals,
covered positions, and cost, so an extensional quotient would add machinery
without helping this milestone.

Weak and strict estimates are parallel declarations instead of one theorem
with a boolean mode. Their bases differ mathematically. Weak summation has the
valid empty base \(0\le0\). Strict summation needs a nonzero interval count,
and the marked-card version obtains it from <code>marked.Nonempty</code> plus
coverage. Separate names keep that additional premise visible at every call
site.

Finally, the selector engine remains private while its existence theorem is
public. Later files should rely on coverage and provenance, not on a
particular implementation of finite minimum and filtering. This leaves room
to replace the algorithm without changing consumers, while the private
boundary fixtures protect the current construction against singleton,
abutment, terminal-tail, outer-gap, and long-cover regressions.

The declaration count reflects these choices: fifty-four public named
declarations form the reusable mathematical interface; the private selector
and twelve private named fixtures support implementation and auditing. The
thirteen private names are not missing public mathematics.

This separation also keeps future asymptotic work honest. A density theorem
will be able to provide a new marked set and a lower bound on its cardinality
without reopening selector internals. A matrix-cocycle application will be
able to provide local favorable costs without proving coverage again. The
finite packing layer is the junction: provenance receives local analytic
information, coverage emits a counting inequality, and the indexed geometry
ensures the selected costs do not overlap.

## Lean proofcraft

### Indexed induction replaces repeated validity proofs

Pattern matching on a packing gives exactly the geometric decomposition needed
for both cardinality and process proofs.

### Offset helpers reconcile relative storage with absolute statements

Every <code>From</code> definition accepts an absolute origin. Its public
wrapper starts at zero. This pattern avoids repeatedly translating a tail back
to global coordinates.

### Pairwise list order is enough

The recursive list theorem proves each earlier endpoint is at most each later
start. A simple implication converts that relation to pairwise disjoint
<code>Set.Ico</code> intervals.

### Strong induction matches greedy jumps

The recursive selector advances to the selected right endpoint, not merely to
the successor horizon. Strong induction permits that variable-size decrease.

### Finite filtering carries the coverage invariant

The remaining set is filtered by an endpoint comparison. Removed elements are
proved inside the current interval; retained elements satisfy the recursive
start horizon.

### Function-iterate addition aligns samples

The cost bridge rewrites nested shifts to absolute exponents. The exact pinned
iteration law is finite and requires no dynamics or measure theory.

### Sign-aware multiplication closes the marked-card step

Lean makes the reversal under \(c\le0\) explicit. This prevents an intuitive
but directionally wrong use of the coverage inequality.

## Replay the two hardest Lean proof states

The informal selector has two points where the indexed types reveal more
bookkeeping than the paper proof. Replaying those states explains why the
implementation uses an offset theorem and strong induction.

### The recursive endpoint branch

Suppose the recursive call begins at absolute offset \(o\) with old remaining
horizon \(H\). Let \(j\) be the least mark and
\(\ell=\operatorname{length}(j)\). In the branch

\[
j+\ell\le o+H,
\]

the proof defines

\[
\operatorname{tailH}=o+H-(j+\ell).
\]

Two arithmetic facts are required before recursion:

\[
j+\ell+\operatorname{tailH}=o+H
\]

and

\[
\operatorname{tailH}\lt H.
\]

The first aligns the new half-open range with the old endpoint. The second is
the well-founded decrease for strong induction. Positive length matters in
the second proof: after reaching the least mark, the algorithm advances past
at least one position.

The survivor set is

\[
B'=\{r\in B:j+\ell\le r\}.
\]

For \(r\in B'\), the old containment proof supplies
\(r\lt o+H\). Rewriting the endpoint with the first arithmetic identity gives

\[
j+\ell\le r\lt j+\ell+\operatorname{tailH},
\]

which is exactly membership in the recursive half-open start range.

The recursive result has type

\[
\operatorname{OrderedNatIntervalPacking}(\operatorname{tailH}+m).
\]

Adding the new gap and interval gives the apparent index

\[
(j-o)+\ell+(\operatorname{tailH}+m).
\]

The proof records \(o+(j-o)=j\), then uses the endpoint identity to show this
index equals \(H+m\). A rewrite transports the existential witness across that
equality. This is why the indexed representation is useful: Lean refuses to
forget even one unit of horizon.

Coverage in this branch is a local decision. For an original mark \(r\), the
proof splits on \(r\lt j+\ell\). In the true branch, minimality supplies
\(j\le r\), placing \(r\) in the current interval. In the false branch,
\(j+\ell\le r\), so \(r\) belongs to \(B'\) and recursive coverage applies.

Provenance has a different shape. The current interval uses the facts
\(j\in B\) and \(\ell=\operatorname{length}(j)\). The recursive certificate
mentions \(B'\). Since \(B'\subseteq B\),
<code>SelectedFromFrom.mono</code> widens it. Coverage and provenance are
therefore proved by different arguments even though the selector returns
both.

### The crossing endpoint branch

If \(j+\ell\gt o+H\), define the final tail by

\[
\operatorname{tail}=H+m-((j-o)+\ell).
\]

The length bound \(\ell\le m\), least-start bounds, and natural arithmetic
prove

\[
(j-o)+\ell\le H+m.
\]

That fact makes the subtraction exact, so

\[
(j-o)+\ell+\operatorname{tail}=H+m.
\]

The packing consists of one cons node followed by an empty tail. For any mark
\(r\), minimality gives \(j\le r\); the old start bound gives
\(r\lt o+H\); and the branch condition gives \(o+H\lt j+\ell\).
Therefore \(r\in[j,j+\ell)\). The terminal branch covers all survivors at
once.

This branch also explains why targeting \(H\) alone is impossible. A legal
start near the end of the old horizon can choose a legal length that crosses
that endpoint. The additional \(m\) is a uniform budget for exactly this
case.

### The marked-cardinality proof state

After the process and local-cost theorems, the weak coverage theorem has two
facts of different numeric types:

\[
X_N(\omega)\le c\,
  (\operatorname{coveredLength}(P):\mathbb R)
\]

and

\[
\operatorname{card}(B)
\le\operatorname{coveredLength}(P)
\]

in natural numbers. The Lean proof proceeds in three explicit stages.

First, <code>card_le_coveredLength_of_covers</code> supplies the natural
inequality. Second, <code>exact_mod_cast</code> turns it into

\[
(\operatorname{card}(B):\mathbb R)
\le(\operatorname{coveredLength}(P):\mathbb R).
\]

Third, <code>mul_le_mul_of_nonpos_left</code> applies \(c\le0\) and returns

\[
c\,(\operatorname{coveredLength}(P):\mathbb R)
\le c\,(\operatorname{card}(B):\mathbb R).
\]

The weak theorem composes two non-strict inequalities. The strict theorem
first obtains a strict covered-length estimate and then uses
<code>LT.lt.trans_le</code> with the same non-strict sign-reversed comparison.
Nonempty coverage proves the packing has nonzero interval count, which is the
missing premise for strict summation.

### Trace the end-to-end declaration route

For the weak public theorem, a reader can follow this exact dependency path:

1. <code>exists_orderedPacking_covering</code> constructs \(P\), coverage,
   and selection provenance.
2. <code>SelectedFrom.everyIntervalCostLE</code> transports the local
   marked-start hypothesis to the recursive interval-cost predicate.
3. <code>le_mul_coveredLength_of_add_le_nonpos</code> combines the raw process
   inequality with the interval costs.
4. <code>card_le_coveredLength_of_covers</code> changes geometric coverage
   into a cardinality comparison.
5. <code>le_mul_card_of_add_le_nonpos_of_covers</code> performs the cast and
   sign reversal.
6. <code>le_mul_card_of_greedy_cover</code> packages all five steps.

The strict route substitutes the <code>LT</code> cost predicates and the
strict covered-length theorem, then asks for
<code>marked.Nonempty</code>. Keeping the weak and strict paths parallel makes
their single logical difference easy to audit.

## Common wrong turns

### Reusing the inclusive endpoint chain unchanged

That loses singleton intervals and obscures legal abutment. Translate the sets,
not just the typography.

### Asking <code>Covers</code> to prove local costs

Coverage provides no selected-start provenance. Use <code>SelectedFrom</code>.

### Asking <code>SelectedFrom</code> to prove coverage

Provenance constrains what was selected but does not require all marks to be
represented. Use both contracts.

### Making gaps positive

The selector naturally produces zero gaps when a next uncovered mark equals
the prior endpoint.

### Making intervals longer than one

The source selection allows length one, and the frozen unit-abutting fixture
checks it.

### Using only horizon \(H\)

Starts are bounded by \(H\); endpoints need the uniform extra length \(m\).

### Removing the weak horizon premise

Combinatorial selection works at \(H=m=0\), but positive-time process sign does
not control \(X_0\).

### Making the strict theorem universal

The empty marked set turns strict local hypotheses into vacuous truths and the
conclusion into a false strict empty-sum inequality.

### Forgetting \(c\le0\)

The cardinality comparison points the wrong way for a positive coefficient.

### Calling selected cost a Birkhoff sum

Intervals have variable lengths. Their process values are not one fixed
observable sampled along consecutive times.

### Claiming a density from finite coverage

No sequence of marked sets or normalized cardinalities appears in the theorem.

### Importing Steele as the selector theorem

Steele's algorithmic decomposition is related proof lineage, but its interval
classes and full asymptotic proof do not state the exact
<code>Covers</code>/<code>SelectedFrom</code> result checked here
([Steele](#ref-packing-deep-steele)).

## Forty-four solved exercises

### Base camp: see the geometry

#### Exercise 1: translate an inclusive singleton

Translate \([7,7]\) to half-open form.

**Solution.** The inclusive set contains the natural numbers \(r\) satisfying
\(7\le r\le7\), so it contains exactly seven. Replacing the last included
point by the next excluded endpoint gives \([7,8)\). Its membership condition
is \(7\le r\lt8\), which again admits only seven. The endpoint difference is
\(8-7=1\), so this is a positive-length interval, not an empty boundary case.
Any formalization that demands the excluded endpoint be more than one step
past the start would incorrectly lose this singleton.

#### Exercise 2: translate separation

Translate \(j+k-1\lt j'\) to half-open endpoints.

**Solution.** The last included point of the first interval is
\(j+k-1\). Saying it is strictly before \(j'\) means its successor is at most
\(j'\). That successor is \(j+k\), the excluded half-open endpoint. Hence the
translated relation is \(j+k\le j'\). If equality holds, the first interval
excludes \(j'\) and the next interval includes it, so the sets are disjoint.
Replacing the translated weak comparison by \(j+k\lt j'\) would insert an
unnecessary uncovered position and forbid legal abutment.

#### Exercise 3: test abutment

Do \([0,2)\) and \([2,5)\) overlap?

**Solution.** No. Two belongs only to the second interval.

#### Exercise 4: decode a prefix

At offset four, gap three, and length two, what is the interval?

**Solution.** \([7,9)\).

#### Exercise 5: identify a zero gap

What does a zero recursive gap mean geometrically?

**Solution.** The next interval begins at the previous endpoint.

#### Exercise 6: identify an empty tail

What does <code>.empty 5</code> after the last interval record?

**Solution.** A terminal uncovered gap of length five.

#### Exercise 7: compare two sizes

Can interval count equal covered length?

**Solution.** Sometimes, for example when every interval is a singleton. In
general they measure different quantities.

#### Exercise 8: find the toy covered set

What positions are covered by \([1,3)\), \([3,4)\), and \([6,9)\)?

**Solution.** \(\{1,2,3,6,7,8\}\).

#### Exercise 9: count it two ways

What is its cardinality, and what is the sum of lengths?

**Solution.** Both are six, using \(2+1+3\).

#### Exercise 10: distinguish a covered mark

In the same packing, may two be marked without being selected?

**Solution.** Yes. It is covered by the interval beginning at one.

#### Exercise 11: state the three contracts

Name geometry, coverage, and provenance.

**Solution.** The packing type supplies geometry, <code>Covers</code> supplies
coverage, and <code>SelectedFrom</code> supplies provenance.

### Mid-mountain: rebuild the selector

#### Exercise 12: choose the first start

Why use the least marked start?

**Solution.** It ensures every other mark is at or to its right, which makes
the coverage split exhaustive.

#### Exercise 13: choose the filter

After selecting \([j,j+k)\), which starts remain?

**Solution.** Those \(r\) with \(j+k\le r\).

#### Exercise 14: cover a deleted start

Why is any deleted \(r\) inside the interval?

**Solution.** The start \(j\) was chosen as the minimum of the current finite
marked set, so every current candidate \(r\) satisfies \(j\le r\). The
survivor filter keeps exactly candidates with \(j+k\le r\). A deleted
candidate fails that comparison; linear order therefore gives
\(r\lt j+k\). Combining the two inequalities yields
\(j\le r\lt j+k\), precisely the membership condition for
\([j,j+k)\). This proves coverage at the moment of deletion. The recursive
call never needs to remember that candidate again.

#### Exercise 15: allow the endpoint

Why does \(r=j+k\) remain?

**Solution.** The first interval excludes its right endpoint, so that start is
not covered yet.

#### Exercise 16: prove positive movement

Why is \(j+k\gt j\)?

**Solution.** The length premise gives \(k\gt0\).

#### Exercise 17: justify strong induction

Why not recurse on marked-set cardinality alone?

**Solution.** That could prove termination, but the construction also needs an
exact indexed tail horizon. Strong induction on remaining horizon aligns with
the target type arithmetic.

#### Exercise 18: explain the crossing branch

If \(j+k\) exceeds the old horizon end, why are all marks covered?

**Solution.** Let the old endpoint be \(o+H\). For any remaining mark \(r\),
minimum selection gives \(j\le r\), while the input range gives
\(r\lt o+H\). The crossing branch is the negation of
\(j+k\le o+H\), so linear order gives \(o+H\lt j+k\). Thus
\(j\le r\lt o+H\lt j+k\), and therefore \(r\in[j,j+k)\). One selected
interval covers every remaining mark, so returning an empty recursive tail
loses nothing. The endpoint may cross the old horizon but remains within the
enlarged one because \(k\le m\).

#### Exercise 19: derive endpoint slack

Show \(j+k\lt H+m\) from \(j\lt H\) and \(k\le m\).

**Solution.** Monotonicity of addition gives \(j+k\le j+m\) from
\(k\le m\). Adding \(m\) to \(j\lt H\) gives \(j+m\lt H+m\). Transitivity
then yields \(j+k\lt H+m\). Equivalently, add the strict inequality
\(j\lt H\) to the weak inequality \(k\le m\). The strictness comes from the
start bound, not from \(k\lt m\); an interval of maximal allowed length is
still valid.

#### Exercise 20: inspect empty input

What packing exists when \(B=\varnothing\) and \(H=m=0\)?

**Solution.** The empty packing at horizon zero, with vacuous coverage and
provenance.

#### Exercise 21: reject uniqueness

Does the existence theorem say the returned packing is unique?

**Solution.** No. It specifies contracts, not an extensional uniqueness
property.

#### Exercise 22: explain monotonicity

Why widen a selection certificate from filtered marks to original marks?

**Solution.** Recursive intervals start in the filtered subset, which is also
a subset of the original eligible set.

### High camp: connect costs and cardinality

#### Exercise 23: write one selected cost

What term corresponds to \([j,j+k)\)?

**Solution.** \(X_k(T^j\omega)\).

#### Exercise 24: reject additivity

Why can this not be replaced by a sum of \(X_1\) terms?

**Solution.** Shifted subadditivity gives only an upper inequality for a
general process.

#### Exercise 25: align an offset

What library law turns a nested iterate into an absolute start?

**Solution.** <code>Function.iterate_add_apply</code>, together with natural
addition rearrangement.

#### Exercise 26: sum weak costs

Why does the weak theorem include an empty packing?

**Solution.** Its base case is \(0\le0\).

#### Exercise 27: sum strict costs

Why does strictness require at least one interval?

**Solution.** An empty strict sum would require \(0\lt0\).

#### Exercise 28: derive positive horizon

Why does a nonempty packing have positive horizon?

**Solution.** It contains a selected interval of positive natural length.

#### Exercise 29: delete an initial gap

When is \(X_g\le0\) available?

**Solution.** Exactly when \(g\ne0\).

#### Exercise 30: handle zero initial gap

What should the proof do when \(g=0\)?

**Solution.** Avoid splitting a gap term and begin at the selected interval.

#### Exercise 31: handle zero terminal gap

What should the proof do when the last interval ends at the horizon?

**Solution.** Stop at that interval rather than introduce \(X_0\).

#### Exercise 32: derive the raw inequality

What remains after every positive gap is deleted?

**Solution.** The sum of selected interval process costs.

#### Exercise 33: use coverage

What cardinality inequality follows from \(B\subseteq P.coveredFinset\)?

**Solution.** \(|B|\le P.coveredLength\).

#### Exercise 34: use the sign of \(c\)

If \(c\le0\), what follows from \(|B|\le L\)?

**Solution.** After casting the natural inequality to the reals, multiply both
sides by the nonpositive number \(c\). Order reverses, giving
\(cL\le c|B|\). For a concrete check, take \(c=-2\), \(|B|=6\), and
\(L=9\). Then \(-18\le-12\). This direction is what the process proof needs:
an intermediate upper bound by the more negative number \(cL\) implies the
weaker requested bound by \(c|B|\). If \(c\) were positive, the comparison
would point the other way and coverage alone would not close the theorem.

### Summit: audit boundaries and claims

#### Exercise 35: empty weak conclusion

What does the weak marked-card theorem say for \(B=\varnothing\)?

**Solution.** At positive horizon, \(X_N\le0\).

#### Exercise 36: empty strict failure

Why are strict local assumptions not enough for empty \(B\)?

**Solution.** They are vacuous, while the desired strict empty-sum conclusion
can be false.

#### Exercise 37: time-zero failure

Use \(X_0=1\) to refute an unconditional empty-packing theorem.

**Solution.** At horizon zero the empty cost is zero, so \(1\le0\) fails.

#### Exercise 38: positive empty validity

Why is the same empty packing valid at positive horizon under the sign premise?

**Solution.** The theorem reduces to the assumed \(X_N\le0\).

#### Exercise 39: long cover inequality

Can one interval of length three cover two marks?

**Solution.** Yes. Let the interval be \([0,3)\) and the marked set be
\(\{0,1\}\). Both starts lie in the selected union, so <code>Covers</code>
holds. If the prescribed length at zero is three, the single interval can
also satisfy <code>SelectedFrom</code>. The marked cardinality is two, the
interval count is one, and the covered length is three. This single fixture
shows that all three quantities can differ. It also exercises strict
coverage-to-length inequality without suggesting any asymptotic density.

#### Exercise 40: audit candidate baggage

Which candidate field does the pointwise packing theorem use?

**Solution.** Shifted subadditivity. Integrability remains in the receiver but
is not projected by the proof.

#### Exercise 41: audit centered time zero

Does the centered wrapper require its process value at zero to vanish?

**Solution.** No. The packing theorem discards only positive gaps and retains
an explicit positive-horizon boundary.

#### Exercise 42: audit matrix index

Can the cocycle wrapper be instantiated on an empty finite index type?

**Solution.** Yes. The compiled smoke test does so.

#### Exercise 43: reject density language

Why is \(|B|\le L\) not a density theorem?

**Solution.** It contains no growing sequence, normalization by horizon, or
limit.

#### Exercise 44: name the next theorem gap

What remains before a lower asymptotic estimate?

**Solution.** First define the favorable-start event with exact measurable
quantifiers over the allowed finite lengths, then prove its measurability.
Second connect the event to a stationary finite-measure dynamical system and
obtain an orbit-frequency statement, for example through a suitable
pointwise ergodic theorem whose hypotheses are all checked. Third combine
that frequency with the finite marked-card bound along a growing sequence of
horizons. Finally justify normalization, passage to a liminf or limit,
almost-everywhere exceptional sets, integrability, and any expectation
identity required by the intended Kingman statement. RMT-21 provides the
finite inequality inserted into that future argument; it provides none of
the measure-theoretic or limiting bridges by itself.

## Run the complete finite worksheet on a normal computer

The following file imports only Lean's `Std` library. It does not import
Mathlib or this project. It computes both numeric examples, exposes every
greedy round, prints the gap-length-tail decoder, separates selected starts
from covered marks, checks the sign reversal, and evaluates the empty,
nonempty, singleton, abutting, and time-zero boundaries.

Save this block byte for byte as
<code>/tmp/OrderedIntervalPackingDeepDiveTutorial.lean</code>:

~~~lean
import Std

namespace OrderedIntervalPackingDeepDiveTutorial

abbrev NatInterval := Nat × Nat

def packing : List NatInterval :=
  [(1, 3), (3, 4), (6, 9)]

def nearMiss : List NatInterval :=
  [(1, 3), (2, 4), (6, 9)]

def openingMarked : List Nat :=
  [1, 2, 3, 6, 8]

def inside (I : NatInterval) (j : Nat) : Bool :=
  decide (I.1 ≤ j ∧ j < I.2)

def coveredPositions (horizon : Nat)
    (family : List NatInterval) : List Nat :=
  (List.range horizon).filter fun j =>
    family.any fun I => inside I j

def intervalLength (I : NatInterval) : Nat :=
  I.2 - I.1

def totalLength (family : List NatInterval) : Nat :=
  family.foldl (fun total I => total + intervalLength I) 0

def isOrdered : List NatInterval → Bool
  | [] => true
  | [_] => true
  | I :: J :: rest =>
      decide (I.2 ≤ J.1) && isOrdered (J :: rest)

def allCovered (marked : List Nat)
    (horizon : Nat) (family : List NatInterval) : Bool :=
  marked.all fun j => (coveredPositions horizon family).contains j

/-
The deeper example uses H = 10, m = 4, and marked starts
[1, 2, 4, 5, 8, 9].  The leftmost start chooses its prescribed interval;
every mark inside it is deleted; recursion continues with the survivors.
-/

def marked : List Nat :=
  [1, 2, 4, 5, 8, 9]

def prescribedLength (start : Nat) : Nat :=
  match start with
  | 1 => 3
  | 4 => 2
  | 8 => 4
  | _ => 1

structure GreedyRound where
  remainingBefore : List Nat
  selectedStart : Nat
  selectedInterval : NatInterval
  coveredMarks : List Nat
  survivors : List Nat
  deriving Repr, DecidableEq

def greedyRoundsWithFuel :
    Nat → List Nat → List GreedyRound
  | 0, _ => []
  | _ + 1, [] => []
  | fuel + 1, start :: rest =>
      let endpoint := start + prescribedLength start
      let covered :=
        start :: rest.filter (fun j => decide (j < endpoint))
      let survivors :=
        rest.filter (fun j => decide (endpoint ≤ j))
      { remainingBefore := start :: rest
        selectedStart := start
        selectedInterval := (start, endpoint)
        coveredMarks := covered
        survivors := survivors } ::
        greedyRoundsWithFuel fuel survivors

def greedyRounds (starts : List Nat) : List GreedyRound :=
  greedyRoundsWithFuel starts.length starts

def greedyPacking (starts : List Nat) : List NatInterval :=
  (greedyRounds starts).map GreedyRound.selectedInterval

def selectedStarts (family : List NatInterval) : List Nat :=
  family.map Prod.fst

def selectionCoverageLedger :
    List (Nat × Bool × Bool) :=
  let family := greedyPacking marked
  let selected := selectedStarts family
  let covered := coveredPositions 14 family
  marked.map fun j =>
    (j, selected.contains j, covered.contains j)

def encodeFrom (cursor horizon : Nat) :
    List NatInterval → List Nat
  | [] => [horizon - cursor]
  | I :: rest =>
      (I.1 - cursor) :: intervalLength I ::
        encodeFrom I.2 horizon rest

def gapLengthTail (horizon : Nat)
    (family : List NatInterval) : List Nat :=
  encodeFrom 0 horizon family

structure SignLedger where
  markedCount : Nat
  coveredLength : Nat
  coefficient : Int
  coefficientTimesCovered : Int
  coefficientTimesMarked : Int
  nonpositiveReversalHolds : Bool
  positiveCoefficientWouldWork : Bool
  weakSelectedCost : Int
  strictSelectedCost : Int
  strictMarkedBoundHolds : Bool
  deriving Repr, DecidableEq

def signLedger : SignLedger :=
  let family := greedyPacking marked
  let covered := totalLength family
  let count := marked.length
  let c : Int := -2
  let weakCost : Int := ([-6, -4, -8] : List Int).sum
  let strictCost : Int := ([-7, -5, -9] : List Int).sum
  { markedCount := count
    coveredLength := covered
    coefficient := c
    coefficientTimesCovered := c * covered
    coefficientTimesMarked := c * count
    nonpositiveReversalHolds := decide (c * covered ≤ c * count)
    positiveCoefficientWouldWork :=
      decide ((2 : Int) * covered ≤ 2 * count)
    weakSelectedCost := weakCost
    strictSelectedCost := strictCost
    strictMarkedBoundHolds := decide (strictCost < c * count) }

def positiveAtZeroProcess (horizon : Nat) : Int :=
  if horizon = 0 then 1 else -(horizon : Int)

structure BoundaryLedger where
  emptyGreedyPacking : List NatInterval
  emptyWeakAtPositiveTime : Bool
  emptyWeakAtTimeZero : Bool
  emptyStrictSum : Bool
  nonemptyStrictSum : Bool
  singletonOrdered : Bool
  abuttingOrdered : Bool
  deriving Repr, DecidableEq

def boundaryLedger : BoundaryLedger :=
  { emptyGreedyPacking := greedyPacking []
    emptyWeakAtPositiveTime := decide (positiveAtZeroProcess 4 ≤ 0)
    emptyWeakAtTimeZero := decide (positiveAtZeroProcess 0 ≤ 0)
    emptyStrictSum := decide ((0 : Int) < 0)
    nonemptyStrictSum := signLedger.strictMarkedBoundHolds
    singletonOrdered := isOrdered [(3, 4)]
    abuttingOrdered := isOrdered [(1, 3), (3, 4)] }

#eval coveredPositions 10 packing
#eval [totalLength packing, (coveredPositions 10 packing).length]
#eval [isOrdered packing, allCovered openingMarked 10 packing]
#eval coveredPositions 10 nearMiss
#eval [totalLength nearMiss, (coveredPositions 10 nearMiss).length]
#eval isOrdered nearMiss
#eval greedyRounds marked
#eval greedyPacking marked
#eval gapLengthTail 14 (greedyPacking marked)
#eval [totalLength (greedyPacking marked),
  (gapLengthTail 14 (greedyPacking marked)).sum]
#eval coveredPositions 14 (greedyPacking marked)
#eval selectionCoverageLedger
#eval signLedger
#eval boundaryLedger

example : coveredPositions 10 packing = [1, 2, 3, 6, 7, 8] := by
  native_decide
example : [totalLength packing, (coveredPositions 10 packing).length] =
    [6, 6] := by native_decide
example : isOrdered packing = true := by native_decide
example : allCovered openingMarked 10 packing = true := by native_decide

example : coveredPositions 10 nearMiss = [1, 2, 3, 6, 7, 8] := by
  native_decide
example : [totalLength nearMiss, (coveredPositions 10 nearMiss).length] =
    [7, 6] := by native_decide
example : isOrdered nearMiss = false := by native_decide

example : greedyPacking marked = [(1, 4), (4, 6), (8, 12)] := by
  native_decide
example : gapLengthTail 14 (greedyPacking marked) =
    [1, 3, 0, 2, 2, 4, 2] := by native_decide
example : coveredPositions 14 (greedyPacking marked) =
    [1, 2, 3, 4, 5, 8, 9, 10, 11] := by native_decide
example : allCovered marked 14 (greedyPacking marked) = true := by
  native_decide
example : selectedStarts (greedyPacking marked) = [1, 4, 8] := by
  native_decide

example : signLedger.nonpositiveReversalHolds = true := by native_decide
example : signLedger.positiveCoefficientWouldWork = false := by native_decide
example : signLedger.weakSelectedCost = -18 := by native_decide
example : signLedger.strictSelectedCost = -21 := by native_decide
example : signLedger.strictMarkedBoundHolds = true := by native_decide

example : boundaryLedger.emptyWeakAtPositiveTime = true := by native_decide
example : boundaryLedger.emptyWeakAtTimeZero = false := by native_decide
example : boundaryLedger.emptyStrictSum = false := by native_decide
example : boundaryLedger.nonemptyStrictSum = true := by native_decide
example : boundaryLedger.singletonOrdered = true := by native_decide
example : boundaryLedger.abuttingOrdered = true := by native_decide

end OrderedIntervalPackingDeepDiveTutorial
~~~

The important syntax is deliberately ordinary:

- `List.range horizon` enumerates \(0,\ldots,\text{horizon}-1\);
- `filter` keeps the positions or survivors satisfying a Boolean test;
- `decide` computes a proposition such as \(j\lt\text{endpoint}\);
- `structure GreedyRound` gives names to the four columns of one algorithm
  step;
- `#eval` prints a value; and
- each `example ... := by native_decide` asks Lean's kernel-checked decision
  procedure to certify the displayed finite equality or inequality.

With the repository's pinned Lean toolchain already installed, a human types:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean \
  /tmp/OrderedIntervalPackingDeepDiveTutorial.lean
~~~

This is a **small standalone tutorial**. It imports only `Std`, uses short
lists, and is suitable for a normal Mac or Linux host. It does not validate
the Mathlib project module. Successful execution prints exactly:

~~~text
[1, 2, 3, 6, 7, 8]
[6, 6]
[true, true]
[1, 2, 3, 6, 7, 8]
[7, 6]
false
[{ remainingBefore := [1, 2, 4, 5, 8, 9],
   selectedStart := 1,
   selectedInterval := (1, 4),
   coveredMarks := [1, 2],
   survivors := [4, 5, 8, 9] },
 { remainingBefore := [4, 5, 8, 9],
   selectedStart := 4,
   selectedInterval := (4, 6),
   coveredMarks := [4, 5],
   survivors := [8, 9] },
 { remainingBefore := [8, 9],
   selectedStart := 8,
   selectedInterval := (8, 12),
   coveredMarks := [8, 9],
   survivors := [] }]
[(1, 4), (4, 6), (8, 12)]
[1, 3, 0, 2, 2, 4, 2]
[9, 14]
[1, 2, 3, 4, 5, 8, 9, 10, 11]
[(1, true, true), (2, false, true), (4, true, true), (5, false, true), (8, true, true), (9, false, true)]
{ markedCount := 6,
  coveredLength := 9,
  coefficient := -2,
  coefficientTimesCovered := -18,
  coefficientTimesMarked := -12,
  nonpositiveReversalHolds := true,
  positiveCoefficientWouldWork := false,
  weakSelectedCost := -18,
  strictSelectedCost := -21,
  strictMarkedBoundHolds := true }
{ emptyGreedyPacking := [],
  emptyWeakAtPositiveTime := true,
  emptyWeakAtTimeZero := false,
  emptyStrictSum := false,
  nonemptyStrictSum := true,
  singletonOrdered := true,
  abuttingOrdered := true }
~~~

The transcript connects the diagrams to executable facts. The first six lines
are the separate six-position valid/near-miss worksheet. The remaining lines
belong to the larger \(H=10,m=4\) greedy worksheet.

## Read and reproduce the checked Lean slice

The source-order entry point is
<code>NonlinearDynamics.Random.RandomCocycles.SubadditiveIntervalPacking</code>.
From the repository root on an approved Linux builder, the intended direct
audit is:

~~~sh
source "$HOME/.elan/env"
CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/Random/RandomCocycles/SubadditiveIntervalPacking.lean
CLOUD_LEAN_BUILD=1 make check
~~~

The integrated repository module has 1,131 lines and SHA-256
<code>732187ce77b5efa14df3a992f194d5dce4dfc8d9f5fa6dbaf658c5ed41ef4f4d</code>.
That hash records the exact source audited for this chapter; the repository
module is the present authority. These are **project/Mathlib checks**, not
standalone tutorials. They restore or compile substantial dependencies and
must run through the guarded cloud workflow. The Mac workstation is for
editing, Hugo, static checks, and the bounded `Std` worksheet above.

## What the milestone establishes

RMT-21 establishes:

1. a structural finite type for ordered positive-length half-open intervals;
2. absolute endpoint and covered-position decoders;
3. interval-count preservation;
4. containment and pairwise disjointness;
5. exact covered cardinality;
6. separate coverage and selection-provenance contracts;
7. an explicit leftmost selector at enlarged horizon \(H+m\);
8. coverage of every original marked start;
9. exact prescribed length for every selected interval;
10. strict endpoint slack for selector output;
11. weak and strict per-interval cost transport;
12. a raw finite subadditive packing inequality with exact time-zero boundary;
13. weak and strict covered-length bounds;
14. weak marked-cardinality bounds for arbitrary finite marked sets;
15. strict marked-cardinality bounds for nonempty marked sets;
16. end-to-end greedy-cover theorems; and
17. candidate, centered-process, and centered cocycle packing-sum wrappers.

## The exact stopping point

This milestone does not establish:

1. measurability of a future favorable-start event;
2. a positive or asymptotic measure for that event;
3. a pointwise Birkhoff theorem;
4. a maximal inequality;
5. a density theorem for marked starts;
6. Kingman's subadditive ergodic theorem;
7. almost-everywhere convergence of \(X_n/n\);
8. convergence in mean;
9. identification of a limit with an infimum of expectations;
10. invariance or constancy of a liminf;
11. a probability-space normalization;
12. ergodicity of a base or its powers;
13. independence of intervals or marks;
14. uniqueness or optimality of the packing;
15. a signed cocycle growth rate;
16. a Lyapunov exponent; or
17. an Oseledets splitting.

The leftmost selector is a finite combinatorial theorem. The cost inequality is
a finite algebraic theorem. Their composition remains finite.

## Where to continue

[Finite Phase Averaging for Nonpositive Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-phase-averaging-for-nonpositive-subadditive-processes" >}})
is the immediate predecessor and complementary finite upper mechanism.

The {{< refterm "ordered-interval-packing" "ordered interval packing" >}}
glossary chapter is the compact convention, boundary, and theorem reference.
The {{< refterm "phase-averaging" "phase averaging" >}} and
{{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}}
chapters explain the finite upper estimate and positive-horizon sign reduction.

[Pack the Marked Starts: Ordered Disjoint Intervals for Subadditive Cocycles in Lean]({{< relref "/development-notebook/2026/07/ordered-disjoint-interval-packing-for-subadditive-cocycles" >}})
gives the complete declaration-by-declaration source tour and boundary-smoke
ledger.

The next checked ridge is
[Birkhoff Convergence Events Before the Pointwise Ergodic Theorem]({{< relref "/knowledge-base/deep-dives/birkhoff-convergence-events-before-the-pointwise-ergodic-theorem" >}}).
It constructs a measurable, representative-safe, exactly invariant event for
ordinary Birkhoff-average convergence and proves conditional ergodic rigidity.
It does not yet produce membership, orbit frequency for the marked set, or the
pointwise and subadditive limit theorems still needed after this finite packing
layer.

## References

All links below were checked on 2026-07-21. The pinned local Mathlib checkout
at commit <code>81a5d257c8e410db227a6665ed08f64fea08e997</code> is the exact
authority for upstream declarations.

<a id="ref-packing-deep-finset"></a>**Mathlib contributors.**
[Finite interval definitions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Order/Interval/Finset/Defs.html),
with the
[pinned half-open membership theorem](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/Interval/Finset/Defs.lean#L285-L306),
and
[natural interval cardinality](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/Interval/Finset/Nat.lean#L72-L85).
These sources define the finite half-open intervals and endpoint-difference
cardinality used by the packing decoder.

<a id="ref-packing-deep-card"></a>**Mathlib contributors.**
[Finite-set cardinality](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/Finset/Card.html),
with the
[pinned disjoint-union theorem](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Data/Finset/Card.lean#L565-L577).
This theorem is the library bridge from structural disjointness to exact
covered cardinality.

<a id="ref-packing-deep-iterate"></a>**Mathlib contributors.**
[Function iteration](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Logic/Function/Iterate.html),
with the
[pinned addition law](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Logic/Function/Iterate.lean#L54-L87).
RMT-21 uses this finite identity to align recursively shifted samples with
absolute selected starts.

<a id="ref-packing-deep-lalley"></a>**Steven P. Lalley.**
[Kingman's Subadditive Ergodic Theorem](https://galton.uchicago.edu/~lalley/Courses/Graz/Kingman.pdf),
University of Chicago lecture notes, 3 pages, undated, accessed 2026-07-21.
Page 2 states the packed-process inequality as equation (6). Page 3 gives the
leftmost blue-interval selection and explains why all bad starts remain
covered. The notes use inclusive intervals and their displayed strict
start-to-end chain excludes length one despite the next paragraph allowing
\(1\le k\le m\). This chapter uses the corrected half-open convention and also
separates the weak empty-set conclusion from the strict nonempty one.

<a id="ref-packing-deep-steele"></a>**J. Michael Steele.**
[Kingman's subadditive ergodic theorem](https://www.numdam.org/item/AIHPB_1989__25_1_93_0/),
*Annales de l'Institut Henri Poincare, Probabilites et Statistiques* 25(1),
93-98, 1989, with the
[archival PDF](https://www.numdam.org/item/AIHPB_1989__25_1_93_0.pdf).
Page 95 gives a related conceptually algorithmic interval decomposition in a
full proof of Kingman's theorem. It motivates explicit finite algorithms but
does not state RMT-21's selector contract.

<a id="ref-packing-deep-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source is the historical asymptotic destination. The present
chapter proves and explains only a finite ingredient.

The exact upstream Mathlib revision audited for this chapter is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
