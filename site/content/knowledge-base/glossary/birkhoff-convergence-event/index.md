---
title: "Birkhoff convergence event"
slug: "birkhoff-convergence-event"
summary: "A Birkhoff convergence event is the set of starting points whose normalized finite orbit sums converge to some finite real limit; defining and analyzing the event does not prove that it has any members."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.BirkhoffConvergence"
og_image: "birkhoff-convergence-event-card.png"
og_image_alt: "Warm-paper glossary card separating a finite sequence of Birkhoff averages, the yes-or-no convergence event, and the later ergodic rigidity conclusion. A warning states that event analysis does not prove convergence exists."
---

A **Birkhoff convergence event** is the set of starting points for which the
real Birkhoff averages of one observable converge to some finite real number.
The word **event** means a subset of the state space. It does not mean that the
subset has positive probability, full probability, or even one member.

This distinction is the purpose of the twenty-second random-matrix-theory
milestone (RMT-22). The module isolates the event, proves that it is measurable
under ordinary measurability assumptions, proves that it is unchanged when the
orbit is shifted by one step, and derives conditional null-or-conull and
probability-zero-or-one results. It does **not** prove that the averages
converge.

The underlying finite sums are introduced in the
{{< refterm "birkhoff-sum" "Birkhoff sum" >}} entry. The present term adds one
existential limit statement around those finite objects.

{{< reference-figure
  src="event-membership-is-not-existence.svg"
  alt="Two starting points generate sequences of finite Birkhoff averages. One sequence settles toward a finite height and enters the convergence event. The other keeps rising and stays outside. A separate box says that defining, measuring, or proving invariance of the event does not place every point inside it."
  caption="**Finding:** event membership is a property of one complete sequence of finite averages. A convergent sequence contributes its starting point to the event; a sequence that escapes upward does not. Measurability and invariance let later theorems reason about the event as a set, but neither property proves that a starting point belongs to it. The trajectories are conceptual, not empirical measurements."
>}}

## Exact definition

Let:

- \(\Omega\) be a state space;
- \(T:\Omega\to\Omega\) be a discrete-time map;
- \(g:\Omega\to\mathbb R\) be a real observable;
- \(n\in\mathbb N\) be a finite horizon; and
- \(\omega\in\Omega\) be a starting point.

The [finite Birkhoff average](#ref-convergence-event-average) is

\[
A_n^g(\omega)
{} =
\frac{1}{n}\sum_{\substack{j\in\mathbb N\\j\lt n}}
g\bigl(T^j\omega\bigr).
\]

Mathlib totalizes division, so \(A_0^g(\omega)=0\). This time-zero value is a
convenient finite convention. It does not constrain any separately defined
process value \(X_0(\omega)\).

The convergence event is

\[
E(T,g)
{} =
\left\{\omega\in\Omega:
\exists c\in\mathbb R,\ A_n^g(\omega)\longrightarrow c\right\}.
\]

The Lean definition is deliberately just as literal:

~~~lean
def birkhoffConvergenceSet (T : Ω → Ω) (g : Ω → ℝ) : Set Ω :=
  {ω | ∃ c : ℝ,
    Tendsto (fun n ↦ birkhoffAverage ℝ T g n ω) atTop (nhds c)}
~~~

The simp theorem <code>mem_birkhoffConvergenceSet_iff</code> exposes this
definition at a point. It is useful because later proofs can rewrite set
membership into an explicit limit witness without unfolding unrelated
implementation details.

## Four statements that must stay separate

The following claims answer different questions:

| Layer | Representative claim | What it controls |
|---|---|---|
| Finite | every \(A_n^g\) is measurable or integrable | one fixed horizon |
| Event | \(E(T,g)\) is measurable or null measurable | whether the set is legitimate for measure theory |
| Rigidity | \(E(T,g)\) is null or conull under ergodicity | the only possible sizes if it is invariant |
| Existence | almost every point lies in \(E(T,g)\) | actual convergence |

RMT-22 proves the first three layers under their stated hypotheses. It does
not prove the fourth. In particular, the disjunction

\[
E(T,g)=\varnothing\quad\text{almost everywhere}
\qquad\text{or}\qquad
E(T,g)=\Omega\quad\text{almost everywhere}
\]

does not choose the second branch. The
[pointwise Birkhoff ergodic theorem](#ref-convergence-event-birkhoff) is the kind of
analytic result that supplies almost-everywhere membership under additional
hypotheses.

## Why the event is measurable

Suppose \(T\) and \(g\) are ordinarily measurable. Every iterate \(T^j\) is
measurable, so every finite composition \(g\circ T^j\) is measurable. A finite
sum of those functions is measurable, and multiplication by the constant
\(n^{-1}\) preserves measurability. Therefore each map

\[
\omega\longmapsto A_n^g(\omega)
\]

is measurable.

For a sequence of real-valued measurable functions, the set of points where
the sequence converges to some real limit is measurable. RMT-22 applies
Mathlib's
[<code>MeasureTheory.measurableSet_exists_tendsto</code>](#ref-convergence-event-polish)
to obtain
<code>measurableSet_birkhoffConvergenceSet</code>. No probability,
integrability, preservation, or ergodicity assumption is needed for this
ordinary-measurability route.

## Why integrability does not imply ordinary measurability

In Mathlib, <code>Integrable g μ</code> contains almost-everywhere strong
measurability, not an assertion that the supplied representative \(g\) is
ordinarily measurable at every point. Replacing that premise by
<code>Measurable g</code> would silently strengthen the theorem.

RMT-22 instead starts from <code>AEMeasurable g μ</code>. Mathlib's
[almost-everywhere measurable representative API](#ref-convergence-event-representative)
provides an ordinarily measurable representative <code>hg.mk g</code> such that

\[
g = \operatorname{mk}(g)
\qquad\text{almost everywhere}.
\]

If \(T\) is
[quasi-measure-preserving](#ref-convergence-event-qmp), an almost-everywhere equality remains
available along every finite orbit iterate. The finite Birkhoff averages of
the two representatives are consequently equal almost everywhere at every
horizon. Their convergence events are therefore equal almost everywhere.
This proves that the original event is **null measurable**: it agrees almost
everywhere with a measurable set.

The public interface exposes three honest levels:

- <code>..._of_aemeasurable</code> is the primary representative theorem;
- <code>..._of_aestronglyMeasurable</code> is an ergonomic corollary; and
- <code>..._of_integrable</code> uses only the measurability field of
  integrability.

Quasi-measure preservation matters. Without it, a null exceptional set for
\(g=h\) need not remain null after taking preimages along the orbit.

## Exact preimage invariance

The finite averages at \(\omega\) and \(T\omega\) differ only by a finite prefix. For
positive indices, RMT-22 proves both algebraic identities

\[
\begin{aligned}
A_{n+1}^g(T\omega)
&=\frac{n+2}{n+1}A_{n+2}^g(\omega)
  -\frac{g(\omega)}{n+1},\\
A_{n+2}^g(\omega)
&=\frac{g(\omega)}{n+2}
  +\frac{n+1}{n+2}A_{n+1}^g(T\omega).
\end{aligned}
\]

The rational coefficients tend to one and the one-point correction tends to
zero. Hence convergence at \(\omega\) to \(c\) is equivalent to convergence at
\(T\omega\) to the **same** \(c\). No measurability, boundedness, preservation,
injectivity, surjectivity, or invertibility premise is used.

Existentially quantifying the common limit gives the exact set equation

\[
T^{-1}\bigl(E(T,g)\bigr)=E(T,g).
\]

This is preimage invariance. RMT-22 makes no image-invariance claim. When \(T\)
is not surjective, equality with \(T(E(T,g))\) is a different statement and
does not follow from this proof.

## Ergodic rigidity remains conditional

For an ordinarily measurable event, exact preimage invariance and
<code>PreErgodic T μ</code> already give the almost-everywhere empty-or-full
dichotomy. The full measure-preservation component of <code>Ergodic</code> is
not consumed by that route.

For a merely null-measurable event, the corresponding
[Mathlib theorem](#ref-convergence-event-ergodic) uses
<code>QuasiErgodic T μ</code>. RMT-22 therefore keeps that receiver on its
generic representative-safe theorem. An ordinary ergodic hypothesis can be
passed through <code>hT.quasiErgodic</code> when desired.

On a probability space, the two branches become the numerical zero-one law

\[
\mu(E(T,g))=0
\qquad\text{or}\qquad
\mu(E(T,g))=1.
\]

Again, this is a dichotomy, not an existence theorem. On the zero measure, the
almost-everywhere empty and almost-everywhere full descriptions are both
vacuous because every set agrees almost everywhere with every other set.

## Three boundary models

### Zero and constant observables

If \(g=0\), every finite average is zero, so \(E(T,g)=\Omega\) for every map
\(T\). If \(g\equiv c\), the time-zero average is zero but every positive-time
average is \(c\). Removing the first term of a sequence does not change its
limit, so the convergence event is still all of \(\Omega\).

### Identity dynamics

If \(T\) is the identity, the orbit never leaves \(\omega\). For every positive \(n\),

\[
A_n^g(\omega)=g(\omega).
\]

Thus every point belongs to the event, even if \(g\) is not measurable. This
is a pointwise algebraic fact, not a measure-theoretic one.

### A genuinely divergent orbit

Let the state space be the natural numbers, let \(T(k)=k+1\), let
\(g(k)=k\), and start at zero. Then

\[
A_{n+1}^g(0)=\frac n2.
\]

The sequence tends to positive infinity, not to a finite real. Hence
\(0\notin E(T,g)\). This compiled RMT-22 probe prevents the event definition
from being mistaken for a universal convergence assertion.

## Candidate and matrix-cocycle views

For an integrable shifted-subadditive-process candidate \(X\), RMT-22 names

\[
E_1(T,X)=E(T,X_1).
\]

Only the one-step observable appears. The value \(X_0\) can be nonzero. The
compiled boundary model constructs a valid candidate over the zero measure
with \(X_0=1\) and \(X_n=0\) for positive \(n\); its one-step convergence event
is still the whole space.

For a discrete matrix cocycle \(C\), the named event uses the measurable
one-step log-positive norm observable

\[
\omega\longmapsto
\log^+\lVert C(1,\omega)\rVert_\infty.
\]

Ordinary measurability comes from the cocycle itself. The event-measurability,
exact-invariance, and pre-ergodic rigidity wrappers require no
<code>HasIntegrableGeneratorLogPlus</code> premise and no nonempty matrix-index
premise. The empty matrix index is an explicit compiled probe.

## The 37-declaration interface at a glance

The frozen RMT-22 source exposes exactly thirty-seven public declarations:

| Family | Count | Responsibility |
|---|---:|---|
| Finite sum and average | 4 | measurability and integrability |
| Event and representatives | 7 | definition, membership, measurability, and representative transport |
| Shift and exact invariance | 6 | two identities, two limit directions, an equivalence, and a preimage equation |
| Generic rigidity and zero-one laws | 10 | measurable and null-measurable paths plus three representative corollaries each |
| Candidate specialization | 5 | one-step event and conditional wrappers |
| Matrix-cocycle specialization | 5 | generator event and conditional wrappers without generator integrability |

The long
[Deep Dive]({{< relref "/knowledge-base/deep-dives/birkhoff-convergence-events-before-the-pointwise-ergodic-theorem" >}})
lists all declaration names and reconstructs their proof dependencies.

## What the term does not claim

A Birkhoff convergence event, even when measurable and invariant, does not by
itself establish:

- membership of any specified point;
- nonemptiness, positive measure, or full measure;
- almost-everywhere convergence;
- identification of a limit with a space average;
- convergence in integrable norm, probability, or distribution;
- a maximal ergodic inequality;
- the pointwise Birkhoff ergodic theorem;
- Kingman's subadditive ergodic theorem;
- mixing, independence, or decay of correlations;
- a Lyapunov exponent; or
- an Oseledets filtration or splitting.

## Where to continue

The {{< refterm "almost-everywhere" "almost everywhere" >}} entry explains
the equality notion used for representatives and events. The
{{< refterm "ergodic-probability-base" "ergodic probability base" >}}
entry separates probability normalization, preservation, ergodicity, and
integrability.

[Birkhoff Convergence Events Before the Pointwise Ergodic Theorem]({{< relref "/knowledge-base/deep-dives/birkhoff-convergence-events-before-the-pointwise-ergodic-theorem" >}})
develops the complete textbook route, solved exercises, and declaration map.

[Finite Ordered Interval Packing for Nonpositive Subadditive Processes]({{< relref "/knowledge-base/deep-dives/finite-ordered-interval-packing-for-nonpositive-subadditive-processes" >}})
is the finite combinatorial predecessor. RMT-22 supplies an event interface,
but it still does not supply the density or convergence theorem needed to
complete the later Kingman argument.

## References

All Mathlib links below refer to the v4.32.0 API used by this project. The
pinned local checkout at commit
<code>81a5d257c8e410db227a6665ed08f64fea08e997</code> is the exact source
authority.

<a id="ref-convergence-event-average"></a>**Mathlib contributors.**
[Birkhoff averages](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/Average.html),
with the
[pinned definition and time-zero theorem](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Average.lean#L36-L55).
These sources define the totalized finite average reused by RMT-22.

<a id="ref-convergence-event-qmp"></a>**Mathlib contributors.**
[Birkhoff averages under quasi-measure-preserving maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/BirkhoffSum/QuasiMeasurePreserving.html),
with the
[pinned representative-transport theorem](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/QuasiMeasurePreserving.lean#L33-L46).
This is the finite almost-everywhere transport used before event congruence.

<a id="ref-convergence-event-representative"></a>**Mathlib contributors.**
[Almost-everywhere measurable representatives](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/MeasureSpaceDef.html#MeasureTheory.AEMeasurable.mk),
with the
[pinned <code>AEMeasurable.mk</code>, <code>measurable_mk</code>, and
<code>ae_eq_mk</code> API](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/MeasureSpaceDef.lean#L425-L442).
This is the ordinary representative used by the primary
<code>AEMeasurable</code> route.

<a id="ref-convergence-event-polish"></a>**Mathlib contributors.**
[Polish-space measure constructions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Constructions/Polish/Basic.html),
with the
[pinned convergence-set theorem](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Constructions/Polish/Basic.lean#L994-L1001).
The theorem proves measurability of the points where a measurable sequence has
some limit in a completely metrizable second-countable target such as the
reals.

<a id="ref-convergence-event-ergodic"></a>**Mathlib contributors.**
[Ergodic maps and measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Dynamics/Ergodic/Ergodic.html),
with the
[pinned pre-ergodic and quasi-ergodic rigidity theorems](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/Ergodic/Ergodic.lean#L61-L78).
The same source contains the null-measurable quasi-ergodic path used by the
representative-safe interface.

<a id="ref-convergence-event-birkhoff"></a>**George D. Birkhoff.**
[Proof of the Ergodic Theorem](https://pmc.ncbi.nlm.nih.gov/articles/PMC1076138/),
*Proceedings of the National Academy of Sciences* 17(12), 656-660, 1931.
The archival record gives DOI
[10.1073/pnas.17.2.656](https://doi.org/10.1073/pnas.17.2.656).
This primary source is the historical pointwise convergence theorem. RMT-22
formalizes only the finite and conditional event infrastructure before such a
theorem.

The exact upstream revision is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the v4.32.0 revision pinned by <code>formalization/lake-manifest.json</code>.
