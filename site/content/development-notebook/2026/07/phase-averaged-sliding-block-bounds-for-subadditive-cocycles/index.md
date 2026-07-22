---
title: "Average the Phases: Sliding-Block Bounds for Subadditive Cocycles in Lean"
slug: "phase-averaged-sliding-block-bounds-for-subadditive-cocycles"
date: 2026-07-21
weight: -52
author: "tdj28"
summary: "Eight public Lean declarations turn residue-phase block sums into one sliding Birkhoff sum and prove a finite upper bound for nonpositive shifted-subadditive processes at the corrected horizon bq+b+r, while keeping the zero-block case vacuous and every asymptotic theorem outside scope."
lead: |
  A fixed block map sees only every b-th orbit point. Average over all b possible starting phases, however, and every one-step sliding position appears exactly once. RMT-20 formalizes that finite combinatorial fact, combines it with positive-horizon nonpositivity, and obtains a sliding-block upper bound without invoking measure preservation, probability, ergodicity, or a limit theorem inside the proof.
key_result: |
  The checked multiplication form bounds b copies of the same process value at horizon bq+b+r by the ordinary bq-term Birkhoff sum of the block observable. The extra block in the horizon is required by the boundary count and repairs an index mismatch in a commonly used teaching display. The theorem is total but vacuous when b = 0; its division form requires b to be nonzero. Candidate wrappers retain their analytic fields, but the raw proof consumes only shifted subadditivity and nonpositivity at positive horizons.
draft: true
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Finite residue phases, Birkhoff-sum reindexing, shifted subadditivity, boundary removal, and matrix-cocycle specialization"
reading_time: "115 to 165 minutes"
prerequisites:
  - "Finite block-and-remainder bounds for shifted-subadditive processes"
  - "Orbit-majorant centering and positive-horizon nonpositivity"
  - "Finite Birkhoff sums and natural iteration"
  - "Natural-number arithmetic for block length, block count, phase, and remainder"
  - "No probability, ergodicity, Birkhoff limit theorem, Kingman theorem, or Lyapunov exponent required"
  - "No prior Lean proof experience required"
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditivePhaseAveraging"
lean_source: "formalization/NonlinearDynamics/Random/RandomCocycles/SubadditivePhaseAveraging.lean"
tags:
  - "Lean 4"
  - "Subadditive processes"
  - "Matrix cocycles"
  - "Birkhoff sums"
  - "Phase averaging"
  - "Sliding blocks"
  - "Finite reindexing"
  - "Boundary terms"
og_image: "phase-averaged-sliding-block-bounds-for-subadditive-cocycles-card.png"
og_image_alt: "Warm-paper teaching card with several residue-phase rows of equal blocks merging into one continuous row of sliding starts. A side label says that the common horizon retains both gaps, and the footer says the result is finite algebra with no Birkhoff, Kingman, or Lyapunov limit theorem."
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
**Editorial status.** This teaching chapter remains a draft while human
editorial acceptance and the separate scientific-integrity and zero-context
expert-reader reviews are pending. The checked Lean source is authoritative
for every theorem statement.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** Let \(T:\Omega\to\Omega\) be a discrete-time map and let
\(X_n(\omega)\) be a real shifted-subadditive process:

\[
X_{m+n}(\omega)
\le
X_n\bigl(T^m\omega\bigr)+X_m(\omega).
\]

Fix a block length \(b\), a block count \(q\), an unrestricted tail parameter
\(r\), and a phase \(s\) with \(s\lt b\). The exact phase decomposition of the
common horizon

\[
N=bq+b+r
\]

contains an initial gap of length \(s\), then \(q\) complete blocks of length
\(b\), then a terminal gap of length \(b+r-s\). Repeated subadditivity gives

\[
\begin{aligned}
X_N(\omega)
&\le
\sum_{j=0}^{q-1}
X_b\bigl(T^{s+bj}\omega\bigr) \\
&\quad+
X_{b+r-s}\bigl(T^{s+bq}\omega\bigr)+X_s(\omega).
\end{aligned}
\]

If \(X_n\le0\) at every positive horizon, the two gaps can be removed. The
phase \(s=0\) is handled separately, so no assertion about \(X_0\) is needed.
Summing over all \(b\) phases and reindexing the rectangular array of block
starts produces

\[
bX_{bq+b+r}(\omega)
\le
\sum_{k=0}^{bq-1}X_b\bigl(T^k\omega\bigr).
\]

Lean expresses the right side as an ordinary Birkhoff sum. The multiplication
form is valid at \(b=0\), where it reduces to \(0\le0\) and carries no process
information. Dividing by \(b\) therefore receives the explicit premise
\(b\ne0\).

The final theorems instantiate the result with RMT-19's
orbit-majorant-centered process and with the centered log-positive norm
observable of a matrix cocycle. The public candidate methods still carry a measurable space,
a measure, and an integrability field because those belong to their wrapper.
The proof itself projects only shifted subadditivity and positive-horizon
nonpositivity. No pointwise or mean Birkhoff theorem, convergence mode,
Kingman theorem, invariant-integral identity, Lyapunov exponent, or Oseledets
splitting is proved.
{{< /panel >}}

This is the proof-to-prose companion for
<code>formalization/NonlinearDynamics/Random/RandomCocycles/SubadditivePhaseAveraging.lean</code>.
It covers all eight public declarations and all seven private named helpers
and smoke declarations in exact source order. Its immediate predecessor is
[Subtract the Orbit Majorant: Centering Subadditive Cocycles in Lean]({{< relref "/development-notebook/2026/07/orbit-majorant-centering-for-subadditive-cocycles" >}}),
which proves the positive-horizon nonpositivity consumed here.
Its immediate successor is
[Pack the Marked Starts: Ordered Disjoint Intervals for Subadditive Cocycles in Lean]({{< relref "/development-notebook/2026/07/ordered-disjoint-interval-packing-for-subadditive-cocycles" >}}),
which formalizes the complementary finite interval-selection mechanism.

The reusable term introduced by this chapter is
[phase averaging](/knowledge-base/glossary/phase-averaging/). The parallel
textbook treatment is
[Finite Phase Averaging for Nonpositive Subadditive Processes](/knowledge-base/deep-dives/finite-phase-averaging-for-nonpositive-subadditive-processes/).
Earlier foundations include the
{{< refterm "birkhoff-sum" "Birkhoff sum" >}},
{{< refterm "orbit-majorant-centering" "orbit-majorant-centered process" >}},
and
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided discrete matrix cocycle" >}}.

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| First encounter | [Why phases solve a powered-map problem](#why-phases-solve-a-powered-map-problem) | See the combinatorial idea before the proof |
| Geometry route | [One common horizon, three kinds of pieces](#one-common-horizon-three-kinds-of-pieces) | Follow prefix, complete blocks, and terminal gap |
| Source-audit route | [Why the horizon contains one extra block](#why-the-horizon-contains-one-extra-block) | Understand the explicit correction to the teaching display |
| Algebra route | [The rectangular reindexing identity](#the-rectangular-reindexing-identity) | Turn phase rows into one sliding sum |
| Assumption route | [Proof dependencies versus wrapper baggage](#proof-dependencies-versus-wrapper-baggage) | Separate consumed fields from signature context |
| API route | [The complete source-order tour](#the-complete-source-order-tour) | Inspect all fifteen named declarations |
| Boundary route | [Degenerate cases are part of the theorem](#degenerate-cases-are-part-of-the-theorem) | Audit zero block length, zero block count, and time zero |
| Lean route | [How Lean executes the finite proof](#how-lean-executes-the-finite-proof) | Read induction, iteration, arithmetic, and finite-sum steps |
| Integrity route | [What phase averaging still does not prove](#what-phase-averaging-still-does-not-prove) | Block every asymptotic overread |

### Learning objectives

By the summit, a reader should be able to:

1. distinguish a block length, block count, phase, and tail parameter;
2. explain why the common horizon is \(bq+b+r\);
3. decompose that horizon into a prefix, complete blocks, and a terminal gap;
4. show why \(s\lt b\) makes the terminal gap positive;
5. explain why the phase-zero proof must avoid an \(X_0\le0\) premise;
6. expand a powered-map Birkhoff sum into ordinary orbit positions;
7. derive the phase reindexing identity on paper;
8. explain why that identity works in any additive commutative monoid;
9. identify the induction variable used by Lean;
10. locate the uses of <code>birkhoffSum_succ</code> and
    <code>birkhoffSum_add</code>;
11. explain what <code>Function.iterate_mul</code> contributes;
12. explain what natural-number arithmetic is discharged by
    <code>omega</code>;
13. state the boundary-retaining raw inequality;
14. remove both boundary values under positive-horizon nonpositivity;
15. sum the phase inequalities with <code>Finset.sum_le_sum</code>;
16. turn a sum of identical left sides into multiplication by \(b\);
17. distinguish the total multiplication theorem from its positive-block
    division form;
18. simplify the multiplication theorem at \(b=0\);
19. simplify it at \(q=0\);
20. simplify the division theorem at \(b=1\);
21. explain why \(r\) is unrestricted in this module;
22. audit the source correction rather than silently reproducing it;
23. follow all eight public declarations in source order;
24. follow all seven private named declarations in source order;
25. distinguish raw proof dependencies from candidate-wrapper baggage;
26. explain why no additional measure-preservation hypothesis is passed to
    the centered candidate methods;
27. explain why the cocycle theorem takes \(C\) rather than \(hC\);
28. retain the empty matrix-index boundary;
29. use the positive-at-zero smoke model to reject an unnecessary
    \(X_0=0\) premise;
30. run the warning-fatal leaf and root import checks; and
31. name the interval-packing layer that remains for the complementary finite
    estimate.

## Why phases solve a powered-map problem

A fixed block length \(b\) naturally introduces the powered map \(T^b\). If
we begin at \(\omega\), then the \(q\)-term block Birkhoff sum is

\[
\operatorname{BS}_{T^b}(X_b,q,\omega)
{} =
\sum_{j=0}^{q-1}X_b\bigl(T^{bj}\omega\bigr).
\]

This sum sees starts at orbit times \(0,b,2b,\ldots\). It misses every start
whose residue modulo \(b\) is nonzero. That is not an analytic failure. It is
simply the sampling pattern created by the powered map.

Now shift the starting sample by \(T^s\), where \(s\lt b\). The same
powered-map sum sees

\[
s,\quad s+b,\quad s+2b,\quad\ldots,\quad s+(q-1)b.
\]

Let \(s\) run through every residue phase from zero to \(b-1\). Every integer
from zero through \(bq-1\) has exactly one representation \(s+bj\) with
\(s\lt b\) and \(j\lt q\). Therefore the array of phase rows is just a
different organization of the consecutive sliding starts.

The mathematical point is elementary, but it solves a serious proof-design
problem. One can apply an ordinary Birkhoff theorem to the base map \(T\)
without pretending that ergodicity passes from \(T\) to \(T^b\). Lalley's
blocking discussion highlights precisely that powered-map obstruction
([Lalley](#ref-rmt20-lalley)). RMT-20 freezes only the finite reindexing and
finite upper bound. It does not invoke the later Birkhoff limit.

{{< reference-figure
  src="phase-rows-become-sliding-starts.svg"
  alt="Several horizontal residue-phase rows each contain equally spaced complete blocks. Prefix gaps grow from the first row to the last while terminal gaps shrink. Arrows merge the rows into one continuous sequence labeled every sliding start appears once. A footer says the common horizon retains both boundary gaps."
  caption="**Finding:** a powered-map row samples one residue class of block starts. Taking every phase fills every ordinary sliding start exactly once. Each row still spans the same long horizon because a longer prefix is paired with a shorter terminal gap. The plate is conceptual and contains no empirical values. It does not assert convergence or erase a boundary term by itself."
>}}

The pure reindexing theorem is stronger than the real-valued application in
one direction and weaker in another. It works for values in any additive
commutative monoid, so subtraction, order, topology, and integration are
absent. On the other hand, it says only that two finite sums are equal. The
subadditive inequality and sign condition enter later.

## One common horizon, three kinds of pieces

Fix \(b,q,r\in\mathbb N\) and a phase \(s\lt b\). Define

\[
N=bq+b+r.
\]

The phase-\(s\) decomposition has three parts:

1. an initial prefix of length \(s\);
2. \(q\) complete blocks, each of length \(b\); and
3. a terminal gap of length \(b+r-s\).

The arithmetic closes exactly:

\[
s+bq+(b+r-s)=bq+b+r=N.
\]

Repeated shifted subadditivity first separates the prefix from the rest. It
then applies the finite block-plus-remainder estimate to the trajectory
starting at \(T^s\omega\). The result is

\[
\begin{aligned}
X_N(\omega)
&\le
\operatorname{BS}_{T^b}(X_b,q,T^s\omega) \\
&\quad+
X_{b+r-s}\bigl((T^b)^q(T^s\omega)\bigr)+X_s(\omega).
\end{aligned}
\]

This is the boundary-retaining theorem. It consumes only the raw
shifted-subadditive inequality. It is the right theorem to inspect whenever
the sign hypothesis is unavailable, because it displays exactly what must be
controlled later.

Suppose now that

\[
n\ne0\quad\Longrightarrow\quad X_n(\omega)\le0
\]

for every sample. When \(s\gt0\), the prefix length is positive. The terminal
length is also positive because \(s\lt b\) implies \(b+r-s\gt0\). Both
boundary values are therefore nonpositive and can be discarded.

The phase \(s=0\) needs different bookkeeping. The boundary-retaining formula
would contain \(X_0(\omega)\), but the hypothesis deliberately says nothing
about time zero. The proof instead invokes the terminal-remainder block bound
directly:

\[
X_N(\omega)
\le
\operatorname{BS}_{T^b}(X_b,q,\omega)
+X_{b+r}\bigl((T^b)^q\omega\bigr).
\]

Since \(s=0\lt b\), we know \(b\gt0\), hence \(b+r\gt0\). The sole remainder
is nonpositive and can be removed. This branch is why RMT-20 obtains all
phase inequalities without assuming \(X_0=0\).

{{< panel "info" >}}
**The phase-zero trap.** A proof that applies the two-boundary formula
uniformly and then writes “both boundaries are nonpositive” has silently used
\(X_0\le0\). For a subadditive candidate, that would force \(X_0=0\). The
checked proof splits \(s=0\) and never asks for that stronger normalization.
{{< /panel >}}

The nonpositive subadditive reduction was established in RMT-19 and has
lineage in broader multiplicative-ergodic arguments
([Karlsson and Margulis](#ref-rmt20-karlsson-margulis)). RMT-20 uses only its
finite pointwise sign consequence. It does not import the asymptotic
conclusion of that literature.

## Why the horizon contains one extra block

The horizon \(bq+b+r\) is not a cosmetic choice. It is forced by the pieces
shown above. The \(q\) complete blocks contribute \(bq\), while the prefix and
terminal gap contribute

\[
s+(b+r-s)=b+r.
\]

Together they contribute \(bq+b+r\).

This matters because a standard teaching route contains a printed indexing
mismatch. Lalley's phase display labels its left side \(g_{nm+k}\), but each
displayed row contains \(n\) blocks of length \(m\) together with \(k+m\)
one-step boundary positions. Those displayed pieces total
\((n+1)m+k\), not \(nm+k\). The following sentence counts at most
\(k+m\le2m\) one-step terms in each row. Across \(m\) displayed rows, those
boundary occurrences total \(m(k+m)\), not the later printed \(mk\)
([the displayed argument in Lalley's notes](#ref-rmt20-lalley)).

RMT-20 does not silently copy or silently repair that display. It states the
correction explicitly and proves the finite theorem at horizon
\(bq+b+r\). Under the correspondence \(b=m\), \(q=n\), and \(r=k\), this is
exactly \((n+1)m+k\). Its phase sum contains exactly \(bq\) sliding-block
starts.

Another coherent repair could keep the horizon \(nm+k\) and use only
\(n-1\) complete \(m\)-blocks in each phase row. That is not the decomposition
formalized here. RMT-20 keeps the displayed count of \(n\) complete blocks and
therefore retains the extra block in the horizon.

The correction is narrow. It does not dispute Kingman's theorem, Lalley's
overall asymptotic destination, or the valid observation that one must avoid
assuming \(T^m\) is ergodic. It says only that the finite row displayed on
that page has a count mismatch, and it replaces that row with checked
arithmetic.

The parameter \(r\) remains unrestricted. Many asymptotic blocking arguments
eventually choose \(r\) as a remainder with \(r\lt b\), but no such fact is
needed for the RMT-20 inequality. Adding it to the signature would misdescribe
the finite algebra. A later theorem may specialize \(r\) to a modulus and
prove the strict bound where it is actually used.

## The rectangular reindexing identity

For an observable \(g:\Omega\to M\) with values in an additive commutative
monoid, define the phase rectangle

\[
R
{} =
\sum_{s=0}^{b-1}
\sum_{j=0}^{q-1}
g\bigl(T^{s+bj}\omega\bigr).
\]

Every pair \((s,j)\) determines the integer \(k=s+bj\). The residue condition
\(s\lt b\) and block condition \(j\lt q\) put \(k\) in the range
\(0\le k\lt bq\). Conversely, Euclidean division of such a \(k\) by \(b\)
recovers one pair. Thus

\[
R
{} =
\sum_{k=0}^{bq-1}g\bigl(T^k\omega\bigr).
\]

Lean's proof does not construct this bijection explicitly. It inducts on the
number of columns \(q\). The zero-column rectangle is empty on both sides. In
the successor step, <code>birkhoffSum_succ</code> peels the new value from
each phase row. The induction hypothesis handles the old rectangle, while
<code>birkhoffSum_add</code> splits the ordinary sliding sum into its first
\(bq\) positions and the next \(b\) positions. Natural-iterate identities
identify the new phase values with that tail. The finite Birkhoff-sum laws are
the pinned Mathlib interface used by the proof
([Mathlib Birkhoff sums](#ref-rmt20-birkhoff-basic)); the iterate multiplication
and addition laws come from Mathlib's function-iterate API
([Mathlib function iteration](#ref-rmt20-function-iterate)).

The theorem includes two useful degeneracies. If \(q=0\), every inner sum is
empty and the ordinary horizon is zero. If \(b=0\), the outer phase sum is
empty and \(bq=0\). Both sides reduce to the additive identity. This is real
content about the finite sum definition, not an invitation to divide by zero
later.

## From every phase inequality to one sliding bound

After boundary removal, each \(s\lt b\) satisfies

\[
X_N(\omega)
\le
\operatorname{BS}_{T^b}(X_b,q,T^s\omega).
\]

Sum these \(b\) inequalities. The left side is a finite sum of the same real
number, hence

\[
\sum_{s=0}^{b-1}X_N(\omega)=bX_N(\omega).
\]

The right side is the phase rectangle. Apply the reindexing identity:

\[
\begin{aligned}
bX_N(\omega)
&\le
\sum_{s=0}^{b-1}
\operatorname{BS}_{T^b}(X_b,q,T^s\omega) \\
&{} =
\operatorname{BS}_{T}(X_b,bq,\omega).
\end{aligned}
\]

Substituting \(N=bq+b+r\) gives the central multiplication theorem.

When \(b\gt0\), division preserves the inequality:

\[
X_{bq+b+r}(\omega)
\le
\frac{
\operatorname{BS}_{T}(X_b,bq,\omega)
}{b}.
\]

The denominator is the number of phase rows, not the number \(bq\) of sliding
starts. The right side can also be viewed as \(q\) times the ordinary average
of \(X_b\) over \(bq\) starts, but RMT-20 deliberately does not introduce
that reformulation. It would still be a finite identity, not a convergence
statement.

{{< reference-figure
  src="rmt20-proof-and-wrapper-lanes.svg"
  alt="A left lane starts with finite Birkhoff reindexing in an additive commutative monoid. A middle lane adds raw shifted subadditivity and positive-horizon nonpositivity to obtain a phase-averaged upper bound. A right wrapper lane shows candidate and cocycle interfaces carrying analytic fields that the finite proof does not consume. The footer says division alone requires a nonzero block length."
  caption="**Finding:** the proof has a small algebraic core and broader public wrappers. Reindexing is pure additive algebra. Boundary retention uses shifted subadditivity. Boundary deletion uses only positive-horizon nonpositivity. Candidate integrability and the cocycle's bundled measure-preserving base remain available in the signatures but are not consumed by this proof."
>}}

## Proof dependencies versus wrapper baggage

A theorem can live as a method on a rich structure even when its proof uses
only one field. That distinction matters here.

| Layer | Present in the signature | Actually consumed by the proof |
|---|---|---|
| Pure reindexing | \(T\), \(g\), \(b\), \(q\), \(\omega\), additive commutative monoid | Birkhoff-sum and iterate identities |
| Private boundary estimate | Raw family \(X\) and shifted-subadditive inequality | Shifted subadditivity plus natural arithmetic |
| Private boundary removal | Raw shifted subadditivity and positive-horizon nonpositivity | Those two assumptions only |
| Public candidate methods | Measurable space, measure, integrable candidate wrapper | <code>hX.add_le</code>, plus derived centered-process sign where applicable |
| Cocycle specialization | A <code>DiscreteMatrixCocycle</code>, which already bundles a preserved base | Cocycle centered subadditivity and nonpositivity |
| Division forms | The corresponding multiplication theorem | The additional premise <code>b ≠ 0</code> |

The candidate methods cannot honestly be described as having no measurable
space or no integrability object in their signatures. They do. The precise
claim is that the proof does not inspect <code>hX.integrable</code>, does not
take an additional <code>hT</code>, and does not use probability or
ergodicity. The private raw helpers reveal this dependency boundary.

Likewise, a <code>DiscreteMatrixCocycle</code> already contains its base map,
measure, measurability data, and measure-preservation proof. The final theorem
takes only \(C\), with no separate
<code>HasIntegrableGeneratorLogPlus</code> argument. Its proof projects the
two pointwise centered laws and ignores the stored analytic fields.

This distinction keeps two kinds of honesty in view at once. The public API
fits the project's existing candidate and cocycle abstractions. The prose
still reports the smaller proof kernel instead of pretending the wrapper is
logically minimal.

## The complete source-order tour

The source interleaves public API declarations, private raw engines, and
private edge-case witnesses. The order below matches the Lean file exactly.

### Source item 1, public declaration 1: `sum_phase_birkhoffSum`

This theorem is the rectangular reindexing identity:

\[
\sum_{s=0}^{b-1}
\operatorname{BS}_{T^b}(g,q,T^s\omega)
{} =
\operatorname{BS}_{T}(g,bq,\omega).
\]

Its value type is any <code>AddCommMonoid</code>. There is no order, real
scalar, measurable structure, or measure. The proof inducts on \(q\), expands
successor Birkhoff sums across every phase, invokes the induction hypothesis,
and identifies the new column with the final length-\(b\) segment of the
ordinary sum.

The commutativity requirement comes from organizing finite sums and using
Mathlib's Birkhoff-sum API in that setting. Nothing in the statement suggests
an integral or limit.

### Source item 2, private declaration 1: `le_blocks_add_remainder_of_add_le`

The first private engine repeats the terminal-remainder block induction at the
raw algebra level:

\[
X_{bq+r}(\omega)
\le
\operatorname{BS}_{T^b}(X_b,q,\omega)
+X_r\bigl((T^b)^q\omega\bigr).
\]

It takes only a function family and the shifted-subadditive inequality. It is
private because RMT-18 already exposes the candidate-facing theorem. RMT-20
needs a raw version so later specializations can remain tied to the exact
algebra they use.

The induction peels one block of length \(b\) from the beginning. The
successor Birkhoff identity with the first term exposed,
<code>birkhoffSum_succ'</code>, matches that direction.

### Source item 3, private declaration 2: `le_phase_birkhoffSum_add_boundaries_of_add_le`

This engine creates the complete phase geometry. It rewrites the long horizon
as

\[
bq+b+r=s+\bigl(bq+(b+r-s)\bigr),
\]

uses shifted subadditivity once at the prefix, then invokes private declaration
1 on the shifted sample \(T^s\omega\). The hypothesis \(s\lt b\) is stronger
than the raw subtraction identity needs, but it is the natural residue-phase
domain and guarantees all later positivity facts.

The result retains both \(X_s\) and \(X_{b+r-s}\). No sign hypothesis is
present. This is the most informative finite inequality in the file because
it exposes the exact error terms before any favorable sign is used.

### Source item 4, private declaration 3: `le_phase_birkhoffSum_of_add_le_nonpos`

The third private engine discards the boundaries. Its sign premise is

\[
\forall n\ne0,\ \forall\omega,\quad X_n(\omega)\le0.
\]

The proof splits on \(s\). At zero phase it uses private declaration 1 with
the single positive remainder \(b+r\). At successor phase it uses private
declaration 2 and proves both \(s+1\) and \(b+r-(s+1)\) are nonzero. Lean's
<code>omega</code> tactic certifies those natural-number facts, while
<code>linarith</code> combines the real inequalities.

This split is not proof noise. It is the precise reason \(X_0=0\) is absent.

### Source item 5, private declaration 4: `natCast_mul_le_birkhoffSum_phase_average_of_add_le_nonpos`

The fourth private engine sums private declaration 3 over
<code>Finset.range b</code>. <code>Finset.sum_le_sum</code> lifts the pointwise
phase inequalities. The left sum becomes \(b\) times a constant through
<code>Finset.sum_const</code>, <code>Finset.card_range</code>, and
<code>nsmul_eq_mul</code>. Public declaration 1 rewrites the right sum.

Because an empty finite sum is valid, this raw theorem includes \(b=0\). The
result is then \(0\le0\). That boundary is intentionally retained in the
multiplication API.

### Source item 6, public declaration 2: `le_phase_birkhoffSum_add_boundaries`

The first candidate method exposes private declaration 2 through
<code>hX.add_le</code>. It carries the full
<code>IsIntegrableSubadditiveProcessCandidate</code> wrapper, but never reads
<code>hX.integrable</code>.

Its role is diagnostic as well as reusable. A future theorem with a different
boundary-control hypothesis can start from this exact inequality rather than
rebuilding the phase decomposition.

### Source item 7, public declaration 3: `le_phase_birkhoffSum`

This method adds positive-horizon nonpositivity and returns the boundary-free
phase estimate. Its arguments still include \(s\lt b\). It does not need
\(X_0=0\), measure preservation, probability, or ergodicity.

The theorem is pointwise in \(\omega\). It does not say the inequality holds
only almost everywhere, nor does it integrate either side.

### Source item 8, public declaration 4: `natCast_mul_le_birkhoffSum_phase_average`

This is the generic multiplication form:

\[
bX_{bq+b+r}(\omega)
\le
\operatorname{BS}_{T}(X_b,bq,\omega).
\]

The Lean name begins with <code>natCast</code> because the natural block length
is cast into the reals before multiplication. This declaration is total at
\(b=0\). Its documentation explicitly calls the resulting \(0\le0\) statement
vacuous.

### Source item 9, public declaration 5: `le_birkhoffSum_phase_average_div`

The division form takes exactly one additional premise:
<code>hb : b ≠ 0</code>. Lean converts that natural nonzero fact into
positivity of the real cast, applies <code>le_div_iff₀</code>, and reuses public
declaration 4 after commuting multiplication.

This separation prevents totalized real division from disguising the
zero-block boundary. There is no theorem at \(b=0\) whose right side is an
informative average.

### Source item 10, public declaration 6: `centeredProcess_natCast_mul_le_birkhoffSum_phase_average`

RMT-19 defined <code>centeredProcess T X</code> by subtracting the additive
one-step orbit majorant. It proved two raw facts needed here: shifted
subadditivity and nonpositivity at every nonzero horizon. Public declaration 6
passes those facts directly to private declaration 4.

No \(X_0=0\) premise is added. No <code>MeasurePreserving T μ μ</code>
argument is added. The surrounding candidate wrapper remains because the two
facts are methods of that wrapper, but its integrability field is unused.

### Source item 11, public declaration 7: `centeredProcess_le_birkhoffSum_phase_average_div`

This is the positive-block division form for the centered process. It adds
only <code>b ≠ 0</code> to public declaration 6. The result remains finite and
pointwise.

It is tempting to call the right side a predictor of a limiting exponent.
That interpretation is not in the theorem. It is one finite sliding Birkhoff
sum divided by the number of phase rows.

### Source item 12, public declaration 8: `centeredLogPlusNormObservable_natCast_mul_le_birkhoffSum_phase_average`

The last public theorem specializes the multiplication form to a discrete
matrix cocycle's centered log-positive norm observable. It takes \(C\)
directly. The proof supplies
<code>C.centeredLogPlusNormObservable_add_le</code> and
<code>C.centeredLogPlusNormObservable_nonpos</code> to the raw private engine.

There is no <code>HasIntegrableGeneratorLogPlus</code> premise, no probability
or ergodicity assumption, and no <code>Nonempty ι</code> premise. The cocycle
object itself already bundles a measure-preserving base, but that field is not
consumed by this proof.

Only the multiplication specialization is public. A cocycle division wrapper
would be a one-line consequence when \(b\ne0\), but it is not needed by the
next dependency and would enlarge the API without adding a new proof boundary.

### Source item 13, private declaration 5: `positiveAtZeroProcess`

The edge-case section defines a process on the one-point space:

\[
P_n
{} =
\begin{cases}
1,&n=0,\\
-n,&n\gt0.
\end{cases}
\]

This private witness makes the time-zero boundary concrete. Positive horizons
are nonpositive, but \(P_0=1\). The base is the identity and the measure will
be zero.

### Source item 14, private declaration 6: `positiveAtZeroProcess_add_le`

The next private theorem proves shifted subadditivity for \(P\). The identity
base removes orbit geometry, but the proof still audits the cases \(m=0\) and
\(n=0\) separately. When both are positive, the inequality is equality because
\(-(m+n)=-m-n\).

This witness refutes any claim that positive-horizon nonpositivity plus
subadditivity automatically forces \(X_0=0\).

### Source item 15, private declaration 7: `positiveAtZeroCandidate`

The final private named declaration packages \(P\) as an integrable candidate
over the zero measure. Every real-valued function is integrable against that
measure, and private declaration 6 supplies the algebraic field.

The succeeding unnamed examples verify \(P_0=1\) and apply the phase-average
theorem at concrete block, count, and tail values. They demonstrate that the
public theorem genuinely permits a positive time-zero value.

## Degenerate cases are part of the theorem

Boundary probes are not decorative tests. They determine which assumptions
belong in the API.

### Zero block length

Set \(b=0\) in the multiplication theorem. The horizon becomes \(r\), the
left coefficient becomes zero, and the Birkhoff-sum length becomes zero:

\[
0\cdot X_r(\omega)
\le
\operatorname{BS}_T(X_0,0,\omega).
\]

Both sides are zero. The statement is valid for every \(q\) and \(r\), but it
contains no comparison involving \(X_r\). The division form correctly refuses
this boundary.

### Zero block count

Set \(q=0\). The theorem says

\[
bX_{b+r}(\omega)\le0.
\]

If \(b\gt0\), then \(b+r\gt0\), so this follows from positive-horizon
nonpositivity. If \(b=0\), the inequality is again \(0\le0\). This check
confirms that no nonexistent block term survives an empty Birkhoff sum.

### Unit block length

Set \(b=1\). There is only phase zero, and the division theorem becomes

\[
X_{q+1+r}(\omega)
\le
\operatorname{BS}_T(X_1,q,\omega).
\]

The extra one in the horizon is the terminal positive gap used to delete the
remainder. This specialization is a quick way to detect the missing-block
index error.

### Identity base and zero measure

The positive-at-zero model uses the identity base. Its phase theorem remains
valid because the proof is finite pointwise algebra. Packaging it over the
zero measure shows that probability normalization is absent. The zero measure
does not cause the inequality; it merely satisfies the unused candidate
integrability field with the weakest possible analytic environment.

### Empty matrix dimension

The cocycle smoke test instantiates the matrix index with <code>Empty</code>.
No proof selects a coordinate, vector, or matrix entry. The theorem therefore
survives dimension zero, where the prior log-positive observable has already
been defined consistently.

### Unrestricted tail parameter

The theorem accepts every \(r\in\mathbb N\). Even a tail longer than a block is
legal. Calling \(r\) a “remainder” can suggest \(r\lt b\), but that inequality
is not part of this API. In this chapter, “tail parameter” is often the more
literal phrase. A quotient-and-modulus specialization may later earn the
strict bound.

## Assumption ledger

| Result | Shifted subadditivity | Positive-horizon nonpositivity | Candidate integrability present | Additional measure preservation | \(X_0=0\) | \(b\ne0\) | Probability or ergodicity |
|---|---:|---:|---:|---:|---:|---:|---:|
| Phase reindexing identity | No | No | No | No | No | No | No |
| Boundary-retaining phase bound | Yes | No | Wrapper only | No | No | No | No |
| Boundary-free phase bound | Yes | Yes | Wrapper only | No | No | No | No |
| Multiplication phase average | Yes | Yes | Wrapper only | No | No | No | No |
| Division phase average | Yes | Yes | Wrapper only | No | No | Yes | No |
| Centered multiplication form | Derived from candidate | Derived from candidate | Wrapper only | No | No | No | No |
| Centered division form | Derived from candidate | Derived from candidate | Wrapper only | No | No | Yes | No |
| Cocycle multiplication form | Established cocycle law | Established cocycle law | No \(hC\) argument | No additional premise | No | No | No |

“Wrapper only” means the public method receives an integrable candidate, so
the field exists, but the proof projects no integrability fact. “No additional
premise” for the cocycle means the theorem does not take a separate
measure-preservation argument; the cocycle structure still carries its base
preservation field.

## How Lean executes the finite proof

### Induct on columns, not on phases

The reindexing proof inducts on \(q\). Adding one to \(q\) appends one value to
every phase row, which is exactly what <code>birkhoffSum_succ</code> exposes.
Induction on \(b\) would change both the number of rows and the stride, making
the iterate arithmetic less local.

### Rewrite natural multiplication before orbit iteration

The successor step changes \(bq\) to \(b(q+1)\). Lean first rewrites this with
<code>Nat.mul_succ</code>. The new orbit exponents then reduce through
<code>Function.iterate_mul</code> and
<code>Function.iterate_add_apply</code>. Keeping arithmetic and function
iteration as separate rewrite stages makes elaboration predictable.

### Let `omega` certify the indexing geometry

The source uses <code>omega</code> for Presburger arithmetic facts such as

\[
bq+b+r=s+\bigl(bq+(b+r-s)\bigr)
\]

under the relevant inequalities, and for proving the terminal boundary length
is nonzero. The tactic is not proving subadditivity. It is certifying the
natural-number bookkeeping around the mathematical inequality.

### Let `linarith` remove nonpositive boundaries

Once Lean has the boundary-retaining real inequality and proofs that the
boundary values are at most zero, <code>linarith</code> performs the ordered
ring step. The conceptual proof remains visible because the exact inequalities
are passed to the tactic explicitly.

### Sum pointwise inequalities before simplifying

The phase-average helper first builds

\[
\sum_s X_N(\omega)
\le
\sum_s \operatorname{BS}_{T^b}(X_b,q,T^s\omega)
\]

with <code>Finset.sum_le_sum</code>. Only then does <code>simpa</code> use the
constant-sum, cardinality, scalar-multiplication, and phase-reindexing laws.
This order mirrors the paper proof and keeps the finite combinatorics auditable.

### Separate multiplication from division

The division theorem begins with <code>le_div_iff₀</code>. Its positivity proof
comes from <code>Nat.pos_of_ne_zero hb</code>, transported to the reals with
<code>exact_mod_cast</code>. The prior multiplication theorem then closes the
goal. This API split keeps the zero-block theorem true without narrating it as
an average.

### Compile through both the leaf and the root

A leaf theorem can compile while its aggregator import is missing. The
milestone therefore runs the leaf with warnings fatal, builds its object file,
and checks <code>RandomCocycles</code>, <code>Random</code>, and the root
<code>NonlinearDynamics</code> aggregator. The public smoke block below catches
namespace drift as well.

## Common wrong turns

### Replacing \(bq+b+r\) with \(bq+r\)

That loses a full block of boundary positions. Write the prefix and terminal
lengths beside the complete blocks, then sum them before choosing the horizon.

### Calling the correction a new theorem of Kingman

The correction concerns one finite displayed decomposition in lecture notes.
It neither alters nor reproves Kingman's subadditive ergodic theorem.

### Dropping \(X_0\) in the phase-zero branch

Positive-horizon nonpositivity says nothing at zero. Use the terminal-remainder
bound directly when \(s=0\), exactly as the private helper does.

### Adding \(X_0=0\) to avoid the branch split

That would make the proof shorter and the public theorem weaker. The
positive-at-zero smoke model demonstrates that the premise is unnecessary.

### Assuming \(r\lt b\)

No quotient or modulus appears in the theorem. The finite inequality accepts
an arbitrary tail parameter. Add a strict remainder bound only in a later
specialization that proves it.

### Dividing at \(b=0\)

Real division is total in Lean, but a totalized formula would hide the fact
that there are no phases. Keep the informative division form behind
<code>b ≠ 0</code>.

### Reading \(0\le0\) as a zero-block estimate for \(X_r\)

At \(b=0\), multiplication annihilates the process value. The theorem is
valid but vacuous. It does not imply a sign or bound for \(X_r\).

### Applying a Birkhoff limit theorem to \(T^b\)

The whole phase device is motivated by the fact that ergodicity of \(T\) need
not pass to \(T^b\). RMT-20 uses only finite Birkhoff sums and no ergodicity at
all.

### Calling a Birkhoff sum an expectation

The right side samples one orbit. It is not a space integral and does not
require a measure to be defined.

### Saying the candidate theorems have no integrability assumptions

Their signatures take an integrable candidate. The precise statement is that
the proofs do not consume its integrability field.

### Saying the cocycle theorem has no preserved base

The cocycle object already bundles one. The honest claim is that no additional
preservation hypothesis is passed and the proof does not inspect the field.

### Requiring `HasIntegrableGeneratorLogPlus`

The cocycle specialization is pointwise. Its inputs are the centered
subadditive law and sign theorem already attached to \(C\). Generator
integrability would be unused baggage.

### Adding a positive matrix dimension

No coordinate is selected. The empty-index smoke compiles and should remain
supported.

### Treating the phase sum as independent samples

The phase rows are deterministic shifts of the same orbit. There is no
independence claim and no probabilistic averaging in the theorem.

### Concluding convergence from a finite inequality

An inequality for every finite \(b,q,r\) does not by itself justify a limsup,
exchange a limit with an integral, or identify a samplewise rate. Each passage
needs its own hypotheses and theorem.

### Claiming the log-positive bound is a signed Lyapunov estimate

The cocycle observable uses \(\log^+\), which clips contraction and exact
collapse. A finite upper bound for that envelope is not a signed exponent.

## What phase averaging still does not prove

RMT-20 proves finite identities and pointwise finite inequalities. It proves
none of the following:

1. a pointwise Birkhoff ergodic theorem;
2. a mean Birkhoff ergodic theorem;
3. convergence almost everywhere;
4. convergence in probability or measure;
5. convergence in \(L^1\) or any \(L^p\) space;
6. convergence of normalized centered values;
7. a limsup inequality obtained by passing \(q\to\infty\);
8. a liminf inequality;
9. Kingman's subadditive ergodic theorem;
10. a maximal inequality;
11. a dominated-convergence or uniform-integrability argument;
12. an exchange of limit and integral;
13. an invariant samplewise limit;
14. constancy of a limit under ergodicity;
15. an equality between a samplewise limit and a deterministic Fekete rate;
16. ergodicity of \(T^b\);
17. measure preservation as a conclusion of finite reindexing;
18. independence or mixing of the phase rows;
19. a probability statement;
20. expectation centering or mean zero;
21. a bound uniform in \(b\), \(q\), or \(r\);
22. a strict tail bound \(r\lt b\);
23. a rate of convergence;
24. the complementary finite lower estimate;
25. an ordered-disjoint-interval packing theorem;
26. a covering or density lemma for favorable orbit positions;
27. a signed logarithmic cocycle observable;
28. negative-tail integrability;
29. a Furstenberg-Kesten exponent;
30. a Lyapunov exponent;
31. singular-value growth;
32. invertibility of the base map or matrices;
33. exterior-power cocycles; or
34. an Oseledets splitting.

Kingman's original theorem is the historical asymptotic destination
([Kingman, 1968](#ref-rmt20-kingman)). RMT-20 contributes one corrected finite
upper-bound mechanism that may enter a future formal proof. It does not claim
that the remaining analytic and combinatorial layers are automatic.

## Exercises with solutions

### Exercise 1: list one phase row

For \(b=4\), \(q=3\), and phase \(s=2\), list the three block starts.

**Solution.** They are \(2\), \(6\), and \(10\), given by \(s+bj\) for
\(j=0,1,2\).

### Exercise 2: list all sliding starts

For the same \(b\) and \(q\), what starts appear after all phases are used?

**Solution.** Phases zero through three produce every integer from \(0\)
through \(11\), exactly the range of length \(bq=12\).

### Exercise 3: check the common horizon

Let \(b=4\), \(q=3\), \(r=2\), and \(s=3\). Compute the prefix, block, and
terminal lengths.

**Solution.** The prefix has length \(3\), the complete blocks have total
length \(12\), and the terminal gap has length \(4+2-3=3\). Their sum is
\(18=4\cdot3+4+2\).

### Exercise 4: detect the missing block

Why would the horizon \(bq+r\) fail in Exercise 3?

**Solution.** It would be \(14\), while the displayed pieces total \(18\).
The discrepancy is one full block of length \(b=4\).

### Exercise 5: prove the terminal gap is positive

Assume \(s\lt b\). Show \(b+r-s\ne0\).

**Solution.** Since \(s\lt b\), \(s+1\le b\). Hence
\(1\le b-s\le b+r-s\), so the terminal length is positive.

### Exercise 6: find the phase-zero obstruction

Which boundary term in the two-boundary formula is not controlled by
positive-horizon nonpositivity when \(s=0\)?

**Solution.** The prefix term is \(X_0(\omega)\). The proof avoids it by using
the one-remainder block theorem directly.

### Exercise 7: repair phase zero

What terminal length replaces the two boundaries at phase zero?

**Solution.** The direct block-plus-remainder theorem uses one terminal
remainder of length \(b+r\). Since \(0\lt b\), this length is positive.

### Exercise 8: expand a powered-map sum

Expand
\(\operatorname{BS}_{T^b}(g,3,T^s\omega)\).

**Solution.** It is

\[
g(T^s\omega)+g(T^{s+b}\omega)+g(T^{s+2b}\omega).
\]

### Exercise 9: prove uniqueness of a phase representation

Suppose \(s+bj=s'+bj'\) with \(s,s'\lt b\). Why must the pairs agree?

**Solution.** Reducing modulo \(b\) gives \(s=s'\). Cancellation then gives
\(bj=bj'\). If \(b\gt0\), cancellation gives \(j=j'\). At \(b=0\), no phase
satisfies \(s\lt b\), so the domain is empty.

### Exercise 10: audit the monoid assumption

Why does public declaration 1 not require real numbers?

**Solution.** It only rearranges finite additions. No subtraction, order, or
scalar division occurs, so an additive commutative monoid is sufficient.

### Exercise 11: choose the induction variable

Why is induction on \(q\) natural for the reindexing theorem?

**Solution.** Increasing \(q\) appends one block observation to every phase
row and appends one segment of length \(b\) to the ordinary Birkhoff sum. The
successor laws match both changes directly.

### Exercise 12: identify the iterate law

Which identity relates repeated application of \(T^b\) to application of
\(T\) for \(bq\) steps?

**Solution.** <code>Function.iterate_mul</code> identifies
\((T^b)^q\) with \(T^{bq}\), up to the orientation used by the rewrite.

### Exercise 13: retain the boundaries

Write the complete phase inequality before using signs.

**Solution.**

\[
\begin{aligned}
X_{bq+b+r}(\omega)
&\le
\operatorname{BS}_{T^b}(X_b,q,T^s\omega) \\
&\quad+X_{b+r-s}\bigl((T^b)^q(T^s\omega)\bigr)+X_s(\omega).
\end{aligned}
\]

### Exercise 14: remove a nonpositive boundary

If \(A\le B+C\) and \(C\le0\), what follows?

**Solution.** \(A\le B\), because \(B+C\le B\). In Lean the final linear
combination is discharged by <code>linarith</code>.

### Exercise 15: sum the phases

What does the sum of the identical left side over <code>range b</code>
become?

**Solution.** It is \(b\) copies of \(X_N(\omega)\), represented first as a
natural scalar multiplication and then simplified to real multiplication
\(bX_N(\omega)\).

### Exercise 16: interpret the right side

After summing phases, how many ordinary sliding starts occur?

**Solution.** There are \(bq\), because \(b\) phases each contribute \(q\)
block observations and the reindexing theorem shows every start appears once.

### Exercise 17: set \(b=0\)

What information does the multiplication theorem provide?

**Solution.** None about \(X_r\). It reduces to \(0\le0\). This is a valid but
vacuous totalized boundary.

### Exercise 18: set \(q=0\)

Simplify the multiplication theorem.

**Solution.** It becomes \(bX_{b+r}(\omega)\le0\). For positive \(b\), this
follows from the sign of the positive-horizon value. For \(b=0\), it is
vacuous.

### Exercise 19: set \(b=1\)

Simplify the division theorem.

**Solution.** It becomes

\[
X_{q+1+r}(\omega)
\le
\operatorname{BS}_{T}(X_1,q,\omega).
\]

There is only one residue phase.

### Exercise 20: locate the only division premise

Which public declarations require <code>b ≠ 0</code>?

**Solution.** Public declarations 5 and 7, the generic and centered division
forms. Both multiplication forms remain total at zero.

### Exercise 21: locate integrability use

Which RMT-20 proof reads <code>hX.integrable</code>?

**Solution.** None. The candidate methods carry the field in their wrapper
but project only the shifted-subadditive law and previously derived centered
facts.

### Exercise 22: locate measure preservation

Does a centered candidate theorem take <code>hT : MeasurePreserving T μ μ</code>?

**Solution.** No. RMT-19 needed that premise to prove integrability of the
centered family. RMT-20's finite phase inequalities do not transport
integrability and add no such argument.

### Exercise 23: audit the cocycle premise

Why is <code>HasIntegrableGeneratorLogPlus</code> absent from public
declaration 8?

**Solution.** The theorem uses only centered shifted subadditivity and
nonpositivity, both already proved directly from the cocycle's finite algebra.
It neither integrates nor takes a limit.

### Exercise 24: test the empty index

What assumption would exclude the empty matrix dimension?

**Solution.** <code>Nonempty ι</code> would exclude it. RMT-20 assumes only
<code>Fintype ι</code> and <code>DecidableEq ι</code>, so <code>Empty</code>
remains valid.

### Exercise 25: inspect the positive-at-zero process

Compute \(P_0\), \(P_1\), and \(P_4\).

**Solution.** They are \(1\), \(-1\), and \(-4\). Thus every positive horizon
is nonpositive while time zero is positive.

### Exercise 26: verify its subadditivity at a zero input

Take \(m=0\). What does the inequality say?

**Solution.** It says \(P_n\le P_n+P_0=P_n+1\), which holds. The case
\(n=0\) is analogous.

### Exercise 27: verify its positive-positive case

Take \(m,n\gt0\). What does the inequality become?

**Solution.** Both sides equal \(-(m+n)\), because the identity base does not
change the sample.

### Exercise 28: separate source correction from theorem scope

Does repairing Lalley's displayed finite horizon prove the limsup estimate in
the notes?

**Solution.** No. It supplies a correct finite inequality. Passing to a
limsup still needs a suitable Birkhoff theorem, normalization, remainder
control, and a justified limiting argument.

### Exercise 29: reject independence

Are the phase rows independent random samples?

**Solution.** No. They are deterministic shifts along one orbit. The theorem
uses finite addition, not independence.

### Exercise 30: reject expectation language

Why is division by \(b\) not an expectation?

**Solution.** It averages finitely many phase inequalities at one sample. No
measure integral appears. The result is a deterministic finite average over
residue classes.

### Exercise 31: design a quotient specialization

How could a later theorem obtain \(r\lt b\)?

**Solution.** For \(b\gt0\), choose \(r=N\bmod b\) and invoke
<code>Nat.mod_lt</code>. RMT-20 keeps \(r\) general because that specialization
is not required for its finite identity.

### Exercise 32: name the complementary layer

What finite combinatorics remains before the lower side of a Kingman-style
argument?

**Solution.** One needs an ordered-disjoint-interval packing or covering
layer that selects favorable finite blocks along the orbit while controlling
uncovered positions. Phase averaging itself proves the upper finite estimate,
not that packing theorem. RMT-21 now supplies the separate finite layer in
[Pack the Marked Starts]({{< relref "/development-notebook/2026/07/ordered-disjoint-interval-packing-for-subadditive-cocycles" >}}).

### Exercise 33: write the referee correction

Correct the sentence “Averaging phases proves the centered cocycle converges
to its Lyapunov exponent.”

**Solution.** Averaging phases proves a finite pointwise upper bound for the
centered log-positive cocycle observable. It uses shifted subadditivity and
nonpositivity, adds no generator-integrability hypothesis, and proves no
convergence or signed Lyapunov exponent.

### Exercise 34: audit both source counts

Suppose a display has \(m\) phase rows and each row contains \(k+m\)
one-step boundary occurrences. How many such occurrences are displayed in
total, and how could one instead retain the horizon \(nm+k\)?

**Solution.** The displayed total is \(m(k+m)\), not \(mk\). A coherent
alternative decomposition at horizon \(nm+k\) could use only \(n-1\)
complete length-\(m\) blocks in each row. RMT-20 chooses the other repair: it
keeps all \(n\) displayed complete blocks and changes the common horizon to
\((n+1)m+k\).

## Reproducibility and audit ledger

| Artifact | Role | Validation |
|---|---|---|
| <code>SubadditivePhaseAveraging.lean</code> | Eight public declarations, four private proof engines, and three private smoke declarations | Direct warning-fatal Lean check and axiom audit |
| <code>RandomCocycles.lean</code> | Aggregator import and scope summary | Warning-fatal aggregator checks through the root |
| This <code>index.md</code> | Declaration-complete proof-to-prose map | Teaching source hygiene and Hugo warnings fatal |
| <code>phase-rows-become-sliding-starts.svg</code> | Prose-only phase geometry | UTF-8 XML parse and rendered inspection |
| <code>rmt20-proof-and-wrapper-lanes.svg</code> | Prose-only dependency boundary | UTF-8 XML parse and rendered inspection |
| <code>generate-card.sh</code> | Deterministic featured-card generator | <code>--verify</code> byte comparison and 1200x630 dimension check |

From the repository root:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles/SubadditivePhaseAveraging.lean
lake build NonlinearDynamics.Random.RandomCocycles.SubadditivePhaseAveraging
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomCocycles.lean
lake env lean -DwarningAsError=true NonlinearDynamics/Random.lean
lake env lean -DwarningAsError=true NonlinearDynamics.lean
cd ..
python3 scripts/check_teaching_source_hygiene.py
make site-check
~~~

The public-surface smoke test is:

~~~lean
import NonlinearDynamics

open NonlinearDynamics.Random.RandomCocycles

#check sum_phase_birkhoffSum
#check IsIntegrableSubadditiveProcessCandidate.le_phase_birkhoffSum_add_boundaries
#check IsIntegrableSubadditiveProcessCandidate.le_phase_birkhoffSum
#check IsIntegrableSubadditiveProcessCandidate.natCast_mul_le_birkhoffSum_phase_average
#check IsIntegrableSubadditiveProcessCandidate.le_birkhoffSum_phase_average_div
#check IsIntegrableSubadditiveProcessCandidate.centeredProcess_natCast_mul_le_birkhoffSum_phase_average
#check IsIntegrableSubadditiveProcessCandidate.centeredProcess_le_birkhoffSum_phase_average_div
#check DiscreteMatrixCocycle.centeredLogPlusNormObservable_natCast_mul_le_birkhoffSum_phase_average
~~~

The axiom audit reports only Lean and Mathlib's standard
<code>propext</code>, <code>Classical.choice</code>, and
<code>Quot.sound</code> dependencies. The source contains no
<code>sorry</code>, <code>admit</code>, <code>unsafe</code> declaration, or
custom axiom.

The article remains <code>draft: true</code> and
<code>pro_reviewed: false</code>. Automated checks do not replace human
mathematical, source, accessibility, and editorial review.

## The next ridge

RMT-20 supplied the corrected finite upper mechanism. Every residue phase
gives a complete-block inequality at one common horizon, and the sum of those
powered-map rows becomes one ordinary sliding Birkhoff sum. The proof has kept
its zero-block and time-zero boundaries visible.

RMT-21 now freezes the complementary finite direction, whose geometry is
different. One must
choose favorable finite intervals along a long orbit, make them ordered and
disjoint, and cover every marked start. Lalley's
lower-estimate discussion describes such a leftmost-interval selection in
prose ([Lalley](#ref-rmt20-lalley)). Steele gives a separate conceptually
algorithmic interval decomposition in a proof of Kingman's theorem
([Steele, 1989](#ref-rmt20-steele)). The checked successor
[packs the marked starts]({{< relref "/development-notebook/2026/07/ordered-disjoint-interval-packing-for-subadditive-cocycles" >}})
by a leftmost greedy rule, keeps the weak empty-mark boundary separate from
the strict nonempty-mark theorem, and imports neither complete limit proof.
Its compact term is
{{< refterm "ordered-interval-packing" "ordered interval packing" >}}, and
its textbook treatment is
[Finite Ordered Interval Packing for Nonpositive Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-ordered-interval-packing-for-nonpositive-subadditive-processes" >}}).

Only after both finite directions exist should the project choose and encode
the analytic convergence route. That later layer must distinguish pointwise
from mean convergence, state probability and measure-preservation assumptions,
identify where ergodicity is used, and justify every limit, integral, and
invariance step. RMT-20's finite Birkhoff sum is infrastructure for that work,
not a substitute for it.

[RMT-29]({{< relref "/development-notebook/2026/07/subadditive-upper-limsup-from-phase-averaging-in-lean" >}})
is the later checked consumer of this upper mechanism. It combines phase
averaging with ordinary-map ergodic Birkhoff convergence to obtain an upper
limsup estimate, while retaining the separate lower-bound and convergence
gap.

For matrix cocycles, the signed-growth program remains farther away. The
current observable is log-positive and therefore controls an expansion
envelope. Signed Lyapunov exponents, singular values, exterior powers, and
Oseledets splittings require additional definitions and integrability choices.
The finite phase theorem does not settle them. Classical random-matrix-product
growth supplies the motivation, not a theorem already obtained here
([Furstenberg and Kesten](#ref-rmt20-furstenberg-kesten)).

## References

The links below were checked on 2026-07-21. The pinned local Mathlib 4.32.0
checkout at commit
<code>81a5d257c8e410db227a6665ed08f64fea08e997</code> is the exact authority for
Lean declarations.

<a id="ref-rmt20-birkhoff-basic"></a>
**Mathlib contributors.**
[Birkhoff sums](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Basic.html),
Mathlib 4 documentation, with the
[pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Basic.lean#L31-L57).
This official source defines the finite orbit sum and its zero, one,
successor, and addition laws. RMT-20 uses those finite declarations and no
convergence theorem.

<a id="ref-rmt20-function-iterate"></a>
**Mathlib contributors.**
[Function iteration](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Logic/Function/Iterate.html),
Mathlib 4 documentation, with the
[pinned addition and multiplication laws](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Logic/Function/Iterate.lean#L67-L87).
These official declarations identify powered-map iterations with ordinary
natural iterates in the phase-reindexing proof.

<a id="ref-rmt20-lalley"></a>
**Steven P. Lalley.**
[Kingman's Subadditive Ergodic Theorem](https://galton.uchicago.edu/~lalley/Courses/Graz/Kingman.pdf),
University of Chicago lecture notes, undated, accessed 2026-07-21. Page 2
displays the multiple phase decompositions and states that \(T^m\) need not be
ergodic; page 3 sketches the later interval selection. The displayed upper-bound
rows combine \(n\) length-\(m\) blocks with \(k+m\) one-step boundary
positions while retaining the label \(g_{nm+k}\); RMT-20 corrects only that
finite count. These notes are a teaching source, not an upstream Lean
dependency or the primary source for Kingman's theorem.

<a id="ref-rmt20-kingman"></a>
**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source is the historical asymptotic destination. RMT-20 proves a
finite phase bound and does not claim to formalize Kingman's theorem.

<a id="ref-rmt20-steele"></a>
**J. Michael Steele.**
[Kingman's subadditive ergodic theorem](https://www.numdam.org/item/AIHPB_1989__25_1_93_0/),
*Annales de l'Institut Henri Poincaré, Probabilités et Statistiques* 25(1),
93-98, 1989, with the
[archival PDF](https://www.numdam.org/item/AIHPB_1989__25_1_93_0.pdf).
The paper develops a conceptually algorithmic proof and decomposes a finite
integer interval into selected bounded intervals and controlled singleton
classes. RMT-20 does not formalize that algorithm; it identifies finite
interval packing as a separate successor layer.

<a id="ref-rmt20-karlsson-margulis"></a>
**Anders Karlsson and Gregory A. Margulis.**
[A Multiplicative Ergodic Theorem and Nonpositively Curved Spaces](https://doi.org/10.1007/s002200050750),
*Communications in Mathematical Physics* 208, 107-123, 1999. The paper uses a
nonpositive subadditive reduction in a broader multiplicative-ergodic proof.
RMT-20 inherits that finite sign setting from RMT-19 but proves no
multiplicative-ergodic conclusion.

<a id="ref-rmt20-furstenberg-kesten"></a>
**Harry Furstenberg and Harry Kesten.**
[Products of Random Matrices](https://doi.org/10.1214/aoms/1177705909),
*The Annals of Mathematical Statistics* 31(2), 457-469, 1960. This primary
source motivates the random-matrix-product destination. The present theorem
is only a finite log-positive cocycle bound and does not establish a
Furstenberg-Kesten exponent.

The exact upstream Lean revision audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
