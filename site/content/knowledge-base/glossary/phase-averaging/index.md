---
title: "Phase averaging"
slug: "phase-averaging"
summary: "Phase averaging sums fixed-block estimates across every residue phase, turning a rectangular grid of powered-map samples into one consecutive finite Birkhoff sum while keeping boundary and zero-block cases explicit."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditivePhaseAveraging"
og_image: "phase-averaging-card.png"
og_image_alt: "Warm-paper teaching card showing a grid of fixed-block samples collected across every phase, reindexed into consecutive sliding starts, with boundary gaps removed only by positive-time nonpositivity. The card states that zero block length is vacuous and no limit theorem is proved."
---

**Phase averaging** is a finite reindexing method for shifted-subadditive
processes. Choose a block length, write one block estimate for every possible
offset inside that block, and add those estimates. The powered-map samples then
cover every consecutive start time exactly once.

The word *averaging* has a narrow meaning here. The phases form a finite,
deterministic list. No phase is sampled randomly, no expectation is taken, and
no time limit is formed. Division by the number of phases appears only after
the exact finite sum has been proved and only when the block length is
positive.

This construction continues the
{{< refterm "orbit-majorant-centering" "orbit-majorant centering" >}}
reduction. Centering supplies a shifted-subadditive process that is nonpositive
at every positive horizon. Phase averaging uses that sign to remove two finite
gaps, then replaces a grid of fixed-block samples by one ordinary
{{< refterm "birkhoff-sum" "Birkhoff sum" >}}.

{{< reference-figure
  src="phase-grid-to-sliding-starts.svg"
  alt="A four-row by three-column grid lists block starts for phases zero through three. Reading the grid by orbit time gives the twelve consecutive starts zero through eleven. A second strip decomposes the longer horizon into an initial gap, three complete blocks, and a terminal gap; positive-time nonpositivity removes the two gaps."
  caption="**Finding:** four deterministic phases with three block samples each contain exactly the twelve consecutive start times from zero through eleven. This is the concrete four-by-three instance of the general phase-grid reindexing. For each phase estimate, the longer horizon also contains an initial gap and a terminal gap. Positive-time nonpositivity can remove those gaps, with a separate zero-phase argument avoiding any sign assumption on the time-zero value. The plate shows finite indexing only. It does not assert a Birkhoff limit, a subadditive ergodic theorem, or convergence of any normalized process."
>}}

## The exact finite reindexing

Let \(\Omega\) be a state space, let \(T:\Omega\to\Omega\) be a self-map,
and let \(g:\Omega\to M\) take values in an additive commutative monoid \(M\).
The commutative-monoid assumption means finite sums have a zero, are
associative, and may be reordered. Choose natural numbers \(b\) and \(q\):

- \(b\) is the block length and also the number of residue phases;
- \(q\) is the number of fixed-block samples taken in each phase; and
- \(s\), with \(0\le s\lt b\), is one **phase**, meaning an offset inside a
  block.

The phase-\(s\) sum is

\[
\begin{aligned}
B_s(\omega)
&=\operatorname{BSum}\!\left(T^b,g,q,T^s\omega\right) \\
&=\sum_{\substack{j\in\mathbb N\\j\lt q}}
  g\!\left(T^{bj+s}\omega\right).
\end{aligned}
\]

The exponent \(bj+s\) says: begin at offset \(s\), then advance one complete
block between samples. Mathlib's finite Birkhoff-sum definition and its
successor and addition laws supply this exact bookkeeping
([official Birkhoff-sum documentation](#ref-phase-mathlib-birkhoff),
[pinned source](#ref-phase-mathlib-birkhoff-pinned)). The iterate identity
\((T^b)^j=T^{bj}\) is likewise a finite function-iteration law
([pinned iterate source](#ref-phase-mathlib-iterate)).

Now sum over all \(b\) phases. Every natural number \(k\lt bq\) has one unique
representation

\[
k=bj+s,
\qquad
j\lt q,
\qquad
s\lt b.
\]

Therefore the rectangular phase grid is exactly one consecutive orbit sum:

\[
\boxed{
\sum_{\substack{s\in\mathbb N\\s\lt b}}
  \operatorname{BSum}\!\left(T^b,g,q,T^s\omega\right)
{} =
\operatorname{BSum}(T,g,bq,\omega).
}
\]

Lean names this identity <code>sum_phase_birkhoffSum</code>. It needs no
measurable space, measure, preservation property, probability law,
integrability, or ergodicity. It is a theorem about finite sums and natural
indices.

Commutativity matters because the left side groups terms by phase while the
right side orders them by orbit time. For real-valued processes that
reordering is harmless. One should not silently transplant the same statement
to an order-sensitive noncommutative product.

## A four-by-three arithmetic check

Take \(b=4\) phases and \(q=3\) samples per phase. The phase grid contains
these start times:

| Phase | Powered-map start times |
|---|---|
| \(s=0\) | \(0,4,8\) |
| \(s=1\) | \(1,5,9\) |
| \(s=2\) | \(2,6,10\) |
| \(s=3\) | \(3,7,11\) |

Every start from zero through eleven appears once. Nothing appears twice, and
nothing in that range is skipped.

For a numerical check, suppose
\(g(T^k\omega)=k+1\) over these twelve starts. The four phase sums are

\[
\begin{aligned}
B_0&=1+5+9=15, \\
B_1&=2+6+10=18, \\
B_2&=3+7+11=21, \\
B_3&=4+8+12=24.
\end{aligned}
\]

Adding by phase gives \(15+18+21+24=78\). Reading consecutively gives
\(1+2+\cdots+12=78\). Phase averaging does not estimate one sum by the other;
it proves that they are the same finite sum under a different grouping.

## Boundary geometry for a subadditive process

The reindexing identity alone says nothing about a subadditive process at a
long horizon. That connection comes from a separate inequality.

Let \(X_n(\omega)\) be a real-valued process satisfying shifted
subadditivity:

\[
X_{m+n}(\omega)\le X_n(T^m\omega)+X_m(\omega).
\]

Fix \(b,q,r\in\mathbb N\), and define the longer horizon

\[
N=bq+b+r.
\]

Here \(r\) is a terminal tail parameter. It is not assumed to be less than
\(b\). For any phase \(s\lt b\), natural-number arithmetic gives

\[
N=s+bq+(b+r-s).
\]

This equality identifies three consecutive pieces:

1. an initial gap of length \(s\);
2. \(q\) complete blocks, each of length \(b\); and
3. a terminal gap of length \(b+r-s\).

Repeated shifted subadditivity first separates the initial gap and then
separates the complete blocks from the terminal gap. The exact result is

\[
\begin{aligned}
X_N(\omega)\le{}&
  \operatorname{BSum}\!\left(T^b,X_b,q,T^s\omega\right) \\
&+X_{b+r-s}\!\left(T^{bq+s}\omega\right)
  +X_s(\omega).
\end{aligned}
\]

This is the boundary-retaining theorem. Lean names it
<code>le_phase_birkhoffSum_add_boundaries</code>. It consumes the candidate's
shifted-subadditive field, but it does not use that candidate's integrability
field.

The hypothesis \(s\lt b\) has two jobs. It makes \(s\) a genuine residue
phase, and it ensures

\[
b+r-s\ge1.
\]

Thus the terminal gap is always positive, even when \(r=0\). That strict
positivity is what permits the next step.

## Why positive-time nonpositivity removes the gaps

Assume

\[
n\ne0\quad\Longrightarrow\quad X_n(\omega)\le0
\]

for every sample \(\omega\). This is positive-time nonpositivity. It deliberately
says nothing about \(X_0\).

When \(0\lt s\lt b\), both boundary lengths are positive:

\[
s\ne0,
\qquad
b+r-s\ne0.
\]

Both boundary values on the right side are therefore nonpositive. Removing
them makes the right side larger, so the valid upper bound remains

\[
X_N(\omega)\le
\operatorname{BSum}\!\left(T^b,X_b,q,T^s\omega\right).
\]

The zero phase needs separate care. Subadditivity does not force \(X_0=0\),
and it does not force \(X_0\le0\). In fact, shifted subadditivity forces
\(X_0\ge0\). Consequently one may not obtain the \(s=0\) estimate by inserting
an \(X_0\) prefix and then pretending that prefix is nonpositive.

Instead, at \(s=0\) the proof starts directly with \(q\) complete blocks and
one terminal gap of length \(b+r\):

\[
X_N(\omega)\le
\operatorname{BSum}\!\left(T^b,X_b,q,\omega\right)
+X_{b+r}\!\left(T^{bq}\omega\right).
\]

The existence of phase zero implies \(b\gt0\), so \(b+r\gt0\). The terminal
term is nonpositive and can be removed. This route proves the same phase bound
without ever asking for a sign at time zero.

Lean packages the result as <code>le_phase_birkhoffSum</code>. The distinction
between positive-time nonpositivity and \(X_0=0\) is not a technical nuisance.
It is exactly what allows the theorem to apply after orbit-majorant centering
without adding a false time-zero premise.

## Sum first, divide only at positive block length

The phase bound has the same left side for every \(s\lt b\). Summing all
\(b\) inequalities gives

\[
b\,X_{bq+b+r}(\omega)\le
\sum_{\substack{s\in\mathbb N\\s\lt b}}
  \operatorname{BSum}\!\left(T^b,X_b,q,T^s\omega\right).
\]

Apply the exact reindexing identity to the right side:

\[
\boxed{
b\,X_{bq+b+r}(\omega)\le
\operatorname{BSum}(T,X_b,bq,\omega).
}
\]

This multiplication form is
<code>natCast_mul_le_birkhoffSum_phase_average</code>. The cast in the Lean name
records that the natural block length \(b\) is viewed as a real scalar before
it multiplies \(X_{bq+b+r}\).

If \(b\ne0\), then its real cast is positive and division preserves the
inequality:

\[
\boxed{
X_{bq+b+r}(\omega)\le
\frac{1}{b}\operatorname{BSum}(T,X_b,bq,\omega).
}
\]

Lean exposes this as <code>le_birkhoffSum_phase_average_div</code>. This is the
literal arithmetic average over the \(b\) deterministic phase inequalities.
It is not an expectation over random phases and not a Birkhoff average in a
time-asymptotic theorem.

## Every degenerate index says something different

The total Lean statements include all natural inputs, but their information
content changes at the boundary.

### Zero block length

At \(b=0\), there are no phases. The reindexing identity is empty sum equals
empty sum:

\[
0=0.
\]

The multiplication inequality also becomes

\[
0\cdot X_r(\omega)\le\operatorname{BSum}(T,X_0,0,\omega),
\]

which simplifies to \(0\le0\). It is valid and completely vacuous. There is
no phase \(s\) satisfying \(s\lt0\), so the phase-specific theorems have no
instance at this block length. The division theorem explicitly requires
\(b\ne0\) and cannot be used.

### Zero samples per phase

At \(q=0\), each phase Birkhoff sum is empty. For positive \(b\), the summed
inequality becomes

\[
b\,X_{b+r}(\omega)\le0.
\]

Unlike the \(b=0\) case, this statement is informative. The horizon \(b+r\)
is positive, so it follows from positive-time nonpositivity.

### Unit block length

At \(b=1\), there is exactly one phase, \(s=0\). The powered map \(T^1\) is
the original map, division is by one, and the result reads

\[
X_{q+1+r}(\omega)\le\operatorname{BSum}(T,X_1,q,\omega).
\]

This is a useful sanity check: phase averaging adds no artificial multiplicity
when only one phase exists.

### Unrestricted terminal parameter

No theorem assumes \(r\lt b\). If \(r\) is much larger than \(b\), the terminal
gap is longer, but it remains positive and hence nonpositive as a process
value. A later quotient-and-remainder or asymptotic argument may choose
\(r\lt b\) for its own reason. That condition is not part of this finite
estimate.

## A positive value at time zero is allowed

Consider a one-point state space with identity base map and define

\[
X_0=1,
\qquad
X_n=-n\quad\text{for }n\gt0.
\]

For positive \(m,n\), shifted subadditivity holds with equality. If either
index is zero, the extra \(X_0=1\) only makes the right side larger. Every
positive horizon is nonpositive, yet \(X_0\) is strictly positive.

The phase and phase-average inequalities remain valid for this process. The
example proves that an assumption \(X_0=0\) would be stronger than the finite
argument needs. It also explains why the zero phase must avoid discarding an
\(X_0\) prefix.

## Orbit-majorant-centered and cocycle forms

For an integrable shifted-subadditive candidate \(X\), orbit-majorant
centering defines

\[
Y_n(\omega)
{} =
X_n(\omega)-\operatorname{BSum}(T,X_1,n,\omega).
\]

The preceding module proves two facts used here:

1. \(Y\) remains shifted-subadditive; and
2. \(Y_n\le0\) for every \(n\ne0\), without assuming \(X_0=0\).

Substituting \(Y\) into the phase-average theorem gives

\[
b\,Y_{bq+b+r}(\omega)\le
\operatorname{BSum}(T,Y_b,bq,\omega),
\]

and, when \(b\ne0\), the corresponding division form. These are
<code>centeredProcess_natCast_mul_le_birkhoffSum_phase_average</code> and
<code>centeredProcess_le_birkhoffSum_phase_average_div</code>. Neither theorem
asks for a new \(X_0=0\) premise or a measure-preservation proof for \(T\).

The discrete matrix-cocycle specialization replaces \(Y_n\) by the centered
log-positive norm observable. Its multiplication theorem works even when the
matrix index type is empty. It requires no separate generator-integrability
hypothesis, probability normalization, ergodicity assumption, or
positive-dimensionality witness. It remains a statement about the
log-positive envelope, not a signed Lyapunov exponent.

## The wrapper ledger

There is an important difference between a premise carried by an interface and
a field actually used in a proof.

| Declaration family | Mathematical facts consumed by the proof | Structure still carried by the public input |
|---|---|---|
| phase-grid reindexing | finite addition and iterate arithmetic | none |
| boundary-retaining candidate method | shifted subadditivity | measurable space, measure, and finite-horizon integrability inside the candidate |
| boundary-dropping phase and phase-average methods | shifted subadditivity and positive-time nonpositivity | the same candidate wrapper |
| centered-process phase averages | shifted subadditivity through the centering lemmas and their positive-time sign | the original candidate wrapper; no new preservation argument |
| centered matrix-cocycle phase average | the cocycle's checked finite algebra and sign | a cocycle object that already stores a measure-preserving base |

Thus it is accurate to say that the generic candidate proofs consume only the
<code>add_le</code> field, but inaccurate to say their public theorem statements
have no integrability premise at all. A caller still supplies an
<code>IsIntegrableSubadditiveProcessCandidate</code>. Likewise, the direct
cocycle theorem does not use base preservation, but the input cocycle already
bundles it.

This wrapper bookkeeping prevents two opposite mistakes. One should not add
probability or ergodicity merely because the topic is ergodic theory. One
should also not erase assumptions that remain present in a bundled public
interface merely because a particular proof projection ignores them.

## The printed index mismatch this theorem repairs

Lalley's three-page notes present the classical phase-shift strategy in a
proof of Kingman's theorem. On page 2, each displayed phase inequality has
\(n\) complete blocks of length \(m\) and \(k+m\) one-step boundary positions,
but the left side is indexed by \(nm+k\). Those pieces account for

\[
nm+(k+m)=(n+1)m+k,
\]

not \(nm+k\). The same page first describes at most \(k+m\) one-step terms in
each phase inequality, then describes the averaged remainder using a count of
at most \(mk\). With \(m\) displayed phases, those two counts are not
compatible as written
([Lalley, pp. 1–2](#ref-phase-lalley)).

The Lean theorem makes the repair explicit. Its \(q\) complete \(b\)-blocks
and \(b+r\) boundary positions have horizon \(bq+b+r\). Averaging over the
\(b\) phases reindexes exactly \(bq\) sliding-block starts. An alternative
asymptotic repair could retain the shorter horizon and use one fewer complete
block layer. The present finite API chooses the longer horizon because it
matches every term in the displayed phase decomposition directly.

This correction does not challenge Kingman's theorem. It repairs a finite
index display used on the way to an asymptotic estimate. The asymptotic theorem
itself is a separate result with measure-theoretic hypotheses
([Kingman, 1968](#ref-phase-kingman)).

## Lean landmarks

The eight public declarations appear in dependency order:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.SubadditivePhaseAveraging

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

The first declaration is a pure identity. The next four expose the generic
boundary, phase, multiplication, and division layers. The following two
specialize the aggregate forms to orbit-majorant centering. The last theorem
is the direct centered log-positive matrix-cocycle specialization.

Private helper theorems carry the raw <code>add_le</code> proofs internally.
They are implementation routes, not additional public API declarations.

## What phase averaging does not claim

This finite construction proves an exact reindexing and pointwise upper
bounds. It does not prove or imply:

- a random or expectation-valued average over phases;
- a pointwise or mean Birkhoff ergodic theorem;
- convergence of a Birkhoff average;
- almost-everywhere, in-probability, in-distribution, or \(L^1\) convergence;
- Kingman's subadditive ergodic theorem;
- a limsup passage from the finite inequality;
- an invariant limiting function or an invariant-integral formula;
- interchange of a limit and an integral;
- a maximal inequality or an ordered interval-packing lemma;
- probability normalization, ergodicity, independence, or mixing;
- a lower estimate complementary to the present upper estimate;
- a Lyapunov exponent or Oseledets splitting;
- recovery of contraction discarded by a log-positive norm observable; or
- information at zero block length beyond the vacuous identity \(0\le0\).

The distinction is especially important because the right side is a finite
Birkhoff sum. Naming that object does not import any theorem about its
normalized limit. The current module deliberately stops before the analytic
machinery that would justify an asymptotic passage.

## Where to continue

The
{{< refterm "orbit-majorant-centering" "Orbit-majorant centering" >}}
entry explains why the input process is shifted-subadditive and nonpositive at
positive horizons. The
{{< refterm "birkhoff-sum" "Birkhoff sum" >}}
entry develops the finite orbit-sum and powered-map conventions used in every
phase row.

The
[Development Notebook]({{< relref "/development-notebook/2026/07/phase-averaged-sliding-block-bounds-for-subadditive-cocycles" >}})
maps the complete Lean implementation and its edge probes. The
[full Deep Dive]({{< relref "/knowledge-base/deep-dives/finite-phase-averaging-for-nonpositive-subadditive-processes" >}})
builds a longer textbook route through the proof geometry, source correction,
and future analytic dependencies.

The complementary finite construction is
{{< refterm "ordered-interval-packing" "ordered interval packing" >}}. Its
[Development Notebook]({{< relref "/development-notebook/2026/07/ordered-disjoint-interval-packing-for-subadditive-cocycles" >}})
maps the Lean selector and marked-card bounds, while
[Finite Ordered Interval Packing for Nonpositive Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-ordered-interval-packing-for-nonpositive-subadditive-processes" >}})
develops the textbook route through the leftmost cover and boundary cases.

## References

<a id="ref-phase-mathlib-birkhoff"></a>**Mathlib contributors.**
[Birkhoff sums](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Basic.html),
Mathlib 4 documentation. This official page defines the finite orbit sum and
states its zero, one, successor, and addition laws.

<a id="ref-phase-mathlib-birkhoff-pinned"></a>**Mathlib contributors.**
[Pinned Birkhoff-sum source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Basic.lean#L30-L57),
Mathlib commit <code>81a5d257</code>. These exact definitions and finite laws
are the upstream API used by the checked reindexing and block arguments.

<a id="ref-phase-mathlib-iterate"></a>**Mathlib contributors.**
[Pinned function-iterate source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Logic/Function/Iterate.lean#L65-L87),
Mathlib commit <code>81a5d257</code>. The cited lines give successor, addition,
and multiplication laws for natural iterates, including
<code>Function.iterate_mul</code>.

<a id="ref-phase-lalley"></a>**Steven P. Lalley.**
[Kingman's Subadditive Ergodic Theorem](https://galton.uchicago.edu/~lalley/Courses/Graz/Kingman.pdf),
University of Chicago lecture notes, 3 pages, undated, accessed 2026-07-21.
Pages 1–2 present orbit-majorant centering and the phase-shift upper-estimate
strategy. The finite index mismatch discussed above is visible in the page 2
displays and their following remainder count.

<a id="ref-phase-kingman"></a>**J. F. C. Kingman.**
[The ergodic theory of subadditive stochastic processes](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x),
*Journal of the Royal Statistical Society: Series B* 30(3), 499-510, 1968.
This primary source establishes the asymptotic subadditive ergodic theory that
motivates the finite phase method. The present glossary entry does not claim
or formalize Kingman's convergence theorem.

The exact upstream Mathlib revision audited for this entry is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the v4.32.0 revision pinned by <code>formalization/lake-manifest.json</code>.
