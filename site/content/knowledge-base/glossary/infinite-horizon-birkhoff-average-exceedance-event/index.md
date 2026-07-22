---
title: "Infinite-horizon Birkhoff-average exceedance event"
slug: "infinite-horizon-birkhoff-average-exceedance-event"
summary: "The infinite-horizon Birkhoff-average exceedance event is the set of starting points for which at least one strictly positive finite time has an orbit average strictly above a fixed threshold."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.InfiniteHopfMaximal"
og_image: "infinite-horizon-birkhoff-average-exceedance-event-card.png"
og_image_alt: "Warm-paper glossary card showing nested finite average-exceedance events forming one exact infinite-horizon event. The card emphasizes strict crossing at positive time, says that the event asserts existence rather than convergence, and identifies finite union mass as a clean sufficient gate for the reusable real-measure limit theorem."
---

The **infinite-horizon Birkhoff-average exceedance event** is the set of
starting points whose orbit average crosses a fixed threshold at least once,
at some finite positive time. The search ranges over every positive natural
time, but every successful point still has one finite witness. The word
*infinite* describes the unbounded search range, not an infinite-duration
average and not a real-valued maximum over infinitely many times.

Random-matrix-theory milestone 24 (RMT-24) formalizes this event, its exact
decomposition into increasing finite events, two distinct measurability
routes, continuity from below in extended measure, and an infinite-horizon
weak estimate. The full construction is in
[From Finite Maximal Bounds to an Infinite Weak Estimate]({{< relref "/knowledge-base/deep-dives/from-finite-maximal-bounds-to-an-infinite-weak-estimate" >}}).
The checked implementation narrative is
[Infinite-Horizon Birkhoff-Average Exceedance Bounds in Lean]({{< relref "/development-notebook/2026/07/infinite-horizon-birkhoff-average-exceedance-bounds-in-lean" >}}).
Its finite predecessor is the
{{< refterm "finite-maximal-ergodic-inequality" "finite maximal ergodic inequality" >}}.
The historical infinite-horizon scope comes from
[Yosida and Kakutani](#ref-infinite-event-yosida-kakutani), while
[Keane and Petersen](#ref-infinite-event-keane-petersen) provide the closest
finite-strict-event precedent.

{{< reference-figure
  src="infinite-horizon-exceedance-event.svg"
  alt="A strict threshold crossing at one positive witness time places a point in the finite event at that same horizon. Conversely, every finite witness remains an infinite witness, so the nested finite events have exactly the infinite event as their union."
  caption="**Finding:** every point in the infinite-horizon event supplies one positive finite witness time. Choosing that same time as the horizon proves membership in one finite event. The reverse inclusion only forgets the finite upper bound, so the union equality is exact and set-theoretic. Time zero never qualifies, and the construction asserts one crossing rather than convergence of the averages. The orbit path and nested regions are conceptual, not empirical data."
>}}

## Exact definition

Let Ω be a state space, let \(T:\Omega\to\Omega\) be a discrete-time
transformation, and let \(g:\Omega\to\mathbb R\) be a real observable. For a
starting point \(\omega\in\Omega\) and a natural number \(k\), the finite
{{< refterm "birkhoff-sum" "Birkhoff sum" >}} is

\[
S_k g(\omega)
{} =
\sum_{0\le j\lt k}g\bigl(T^j\omega\bigr).
\]

At a positive time \(k\ge1\), the Birkhoff average is

\[
A_k g(\omega)=\frac{S_k g(\omega)}{k}.
\]

Fix a real threshold \(a\in\mathbb R\). The infinite-horizon exceedance event
is

\[
E_a(g)
{} =
\left\{\omega:
\exists k\in\mathbb N,\quad
1\le k\ \text{and}\ a\lt A_k g(\omega)
\right\}.
\]

The checked Lean definition states the same predicate directly:

~~~lean
def birkhoffAverageExceedanceSet
    (T : Ω → Ω) (g : Ω → ℝ) (a : ℝ) : Set Ω :=
  {ω | ∃ k, 1 ≤ k ∧ a < birkhoffAverage ℝ T g k ω}
~~~

This event is a union of finite-horizon events, not the superlevel set of a
new real-valued infinite maximum. Avoiding that extra maximum keeps the
construction meaningful even when the sequence of averages is unbounded.

## Strict crossing and positive time are part of the object

The threshold comparison is strict. If \(A_k g(\omega)=a\), then time \(k\)
does not witness membership. This matches the strict finite maximal event used
to derive the estimate. Replacing \(a\lt A_k g(\omega)\) by
\(a\le A_k g(\omega)\) would define a different event, especially on atoms or
on observables whose averages land exactly on the threshold.

Time must also be positive. Mathlib totalizes the zero-time average, but the
value at zero is not an average of any observed orbit values. Building
\(1\le k\) into the definition prevents that convention from creating a
spurious witness.

For the zero observable, these choices are visible immediately:

- if \(0\le a\), every positive-time average equals zero and \(E_a(0)\) is
  empty;
- if \(a\lt0\), time one already crosses the threshold and \(E_a(0)=\Omega\);
  and
- if \(a=0\), equality does not count, so the event is empty.

These are theorem-boundary tests, not special assumptions in the definition.

## The exact increasing union

For a finite horizon \(N\in\mathbb N\), write

\[
E_{N,a}(g)
{} =
\left\{\omega:
\exists k,\quad
1\le k\le N\ \text{and}\ a\lt A_k g(\omega)
\right\}.
\]

The finite events increase with the horizon: if \(M\le N\), then
\(E_{M,a}(g)\subseteq E_{N,a}(g)\). Their union is exactly the infinite event:

\[
E_a(g)=\bigcup_{N\in\mathbb N}E_{N,a}(g).
\]

Both inclusions are constructive. Given an infinite-event witness \(k\), take
\(N=k\). Given a witness inside one finite event, forget only the upper bound
\(k\le N\). No measurable space, measure, topology, integrability, or dynamical
regularity is used in this equality.

The horizon-zero event is empty because no natural number satisfies
\(1\le k\le0\). Including that empty first term causes no problem for the
increasing union.

## Two measurability routes

RMT-24 deliberately exposes two different analytic interfaces.

The **ordinary measurable-set route** assumes that both \(T\) and \(g\) are
measurable. Every finite Birkhoff average is then measurable, each strict
superlevel set \(E_{N,a}(g)\) is measurable, and their countable union is
measurable.

The **null-measurable-set route** assumes instead that \(T\) preserves a
measure \(\mu\) and that \(g\) is integrable with respect to \(\mu\). Every
positive-time Birkhoff average is integrable, hence almost-everywhere strongly
measurable. Its strict superlevel set is null measurable, and a countable union
over positive times remains null measurable. This route needs no finite total
mass, probability normalization, or ergodicity.

Null measurability is weaker than ordinary measurability. It says that the set
agrees with a measurable set up to a \(\mu\)-null discrepancy. It is enough
for the measure-theoretic operations used here, but it must not be advertised
as the ordinary theorem.

## Measure continuity and the real-value cliff

Measures in Lean take values in the **extended nonnegative reals**
\(\mathbb R_{\ge0}\cup\{\infty\}\), written \(\mathbb R_{\ge0\infty}\) in
Mathlib. Continuity from below gives

\[
\mu\bigl(E_{N,a}(g)\bigr)
\longrightarrow
\mu\bigl(E_a(g)\bigr)
\]

in that extended type. Because the finite events are increasing, the checked
Mathlib theorem needs neither measurability of those sets nor a finiteness
premise. The limiting value may be infinite.
This is the exact [continuity-from-below interface used by
RMT-24](#ref-infinite-event-mathlib-continuity).

Mathlib also offers the real-valued view
\(\mu_{\mathbb R}(S)=\operatorname{toReal}(\mu(S))\). This conversion maps
infinite extended mass to zero
([Mathlib's definition of <code>Measure.real</code>](#ref-infinite-event-mathlib-real)).
Therefore it is not continuous at infinity.
To conclude

\[
\mu_{\mathbb R}\bigl(E_{N,a}(g)\bigr)
\longrightarrow
\mu_{\mathbb R}\bigl(E_a(g)\bigr),
\]

RMT-24 proves a reusable corollary under the clean sufficient local condition

\[
\mu\bigl(E_a(g)\bigr)\ne\infty.
\]

A finite total measure is also sufficient, but stronger than this local
statement. Neither condition is claimed to be necessary for every particular
increasing family.

Counting measure supplies the guardrail. Let \(F_N=\{0,\ldots,N-1\}\) inside
the natural numbers. Then \(F_N\) increases to the whole space and
\(\mu_{\mathbb R}(F_N)=N\). The union has infinite extended mass, so its
totalized real measure is zero. The sequence \(N\) plainly does not converge
to zero. Thus no unconditional theorem can push arbitrary continuity from
below through the real projection.

The converse guardrail is equally important. Under the same counting measure,
take identity dynamics, \(g=2\), and \(a=1\). Then every finite event from
horizon one onward and the infinite event are the whole space. Their real
measures are all the totalized value zero, so the real sequence converges even
though the union has infinite extended measure. Local finiteness is therefore
a small sufficient theorem interface, not an if-and-only-if characterization.

## The weak estimate

Assume now that \(\mu\) is a finite measure, \(T\) preserves \(\mu\), and
\(g\) is integrable. The RMT-23 finite inequality bounds every horizon by the
same positive-part integral. Passing through the increasing union gives, for
every real threshold \(a\),

\[
a\,\mu_{\mathbb R}\bigl(E_a(g)\bigr)
\le
\int_\Omega \max\{g(\omega),0\}\,d\mu(\omega).
\]

No sign condition on \(a\) is required for this multiplication form. At a
negative threshold, however, its left side is nonpositive while the right side
is nonnegative, so the result may carry little information. At threshold zero
the left side is zero.

Only a strictly positive threshold licenses order-preserving division:

\[
0\lt a
\quad\Longrightarrow\quad
\mu_{\mathbb R}\bigl(E_a(g)\bigr)
\le
\frac{\displaystyle\int_\Omega \max\{g(\omega),0\}\,d\mu(\omega)}{a}.
\]

The right side uses the positive part \(g^+=\max(g,0)\), not the absolute
value and not the integral of a centered observable. Finite total mass appears
because the finite threshold argument must integrate the constant threshold
and because it safely discharges the real-measure finiteness gate.

## What the event and estimate do not say

Membership in \(E_a(g)\) says that **one** positive-time average crosses
\(a\). It does not say that:

- the averages converge;
- their limit, upper limit, or lower limit has any particular value;
- the crossing happens infinitely often;
- the event is invariant under \(T\);
- the event has probability one or zero;
- the system is ergodic or mixing;
- \(T\) is injective, surjective, or invertible;
- an infinite real maximum exists;
- a strong \(L^p\) maximal estimate holds; or
- the pointwise Birkhoff, Kingman, Lyapunov, or Oseledets theorem has been
  proved.

The weak estimate is an analytic control on event size. A later pointwise
ergodic proof still needs a dense class with known convergence, approximation
control, and a closed-limit argument. RMT-24 supplies the infinite weak
maximal component, not that entire ascent.

## Lean interface

The reusable public declarations are:

- <code>birkhoffAverageExceedanceSet</code>, the event itself;
- <code>mem_birkhoffAverageExceedanceSet_iff</code>, its positive-time witness
  interface;
- <code>birkhoffAverageExceedanceSet_eq_iUnion_finite</code>, the exact union;
- <code>finiteBirkhoffAverageExceedanceSet_subset</code>, finite-to-infinite
  inclusion;
- <code>measurableSet_birkhoffAverageExceedanceSet</code>, ordinary
  measurability;
- <code>nullMeasurableSet_birkhoffAverageExceedanceSet_of_integrable</code>,
  the preservation-and-integrability route;
- <code>tendsto_measure_finiteBirkhoffAverageExceedanceSet</code>, unconditional
  extended-measure continuity;
- <code>tendsto_measureReal_finiteBirkhoffAverageExceedanceSet</code>, locally
  finite real-measure continuity;
- <code>birkhoffAverageExceedanceSet_posPart_bound</code>, the all-threshold
  multiplication estimate; and
- <code>measureReal_birkhoffAverageExceedanceSet_le</code>, the
  positive-threshold weak estimate.

Ten anonymous compiled probes test witness recovery, horizon zero, both
threshold branches for the zero observable, zero measure, an explicitly
nonfinite counting-measure route, positive-threshold division, a noninjective
measure-preserving map whose exceedance event has positive mass, successful
real-measure convergence for one infinite-mass event family, and failure of
real-measure continuity for another infinite-mass increasing family.

## Related concepts

- {{< refterm "birkhoff-sum" "Birkhoff sum" >}} defines the finite orbit sums
  from which the averages are built.
- {{< refterm "finite-maximal-ergodic-inequality" "Finite maximal ergodic inequality" >}}
  supplies the uniform finite-horizon estimate used before taking the union.
- {{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}}
  asks whether the entire average sequence converges, a logically different
  predicate.
- {{< refterm "almost-everywhere" "Almost everywhere" >}} explains the
  null-set equivalence underlying the weaker measurability route.

## References

<a id="ref-infinite-event-yosida-kakutani"></a>**Kôsaku Yosida and Shizuo
Kakutani.**
[Birkhoff's Ergodic Theorem and the Maximal Ergodic Theorem](https://doi.org/10.3792/pia/1195579375),
*Proceedings of the Imperial Academy* 15(6), 165-168, 1939. Their Theorem 2 is
an infinite-horizon average theorem proved with a finite maximal-interval
argument. It is historical scope, not the exact RMT-24 increasing-union proof.

<a id="ref-infinite-event-keane-petersen"></a>**Michael Keane and Karl
Petersen.**
[Easy and Nearly Simultaneous Proofs of the Ergodic Theorem and Maximal Ergodic Theorem](https://doi.org/10.1214/074921706000000266),
*IMS Lecture Notes-Monograph Series* 48, 248-251, 2006, with
[arXiv:math/0608251](https://arxiv.org/abs/math/0608251). Pages 248-249 give
the closest primary precedent for passing from finite strict average events
to an infinite maximal statement, in a probability-space development that
continues farther than RMT-24.

<a id="ref-infinite-event-mathlib-continuity"></a>**Mathlib contributors.**
[Continuity from below for increasing sets](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/MeasureSpace.lean#L648-L654)
and
[continuity of extended-nonnegative-real conversion away from infinity](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/Instances/ENNReal/Lemmas.lean#L103-L107),
Mathlib 4.32.0. These are the exact limit interfaces used by RMT-24.

<a id="ref-infinite-event-mathlib-real"></a>**Mathlib contributors.**
[Definition of <code>Measure.real</code>](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/MeasureSpaceDef.lean#L99-L107),
Mathlib 4.32.0. The source explicitly records that infinite measure is mapped
to zero. RMT-24's local finiteness premise supplies a clean sufficient route
through that totalization boundary; it is not advertised as necessary for
every specific family.
