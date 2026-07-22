---
title: "Weak-type (1,1) maximal bound"
slug: "weak-type-one-one-maximal-bound"
summary: "A weak-type (1,1) maximal bound controls the measure of starting points where some orbit average exceeds a positive threshold by the integrable size of the observable divided by that threshold."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoff"
og_image: "weak-type-one-one-maximal-bound-card.png"
og_image_alt: "Warm-paper glossary card sending an integrable orbit-average error through a positive threshold gate and bounding the resulting exceptional set by its integrable size divided by the threshold."
---

A **weak-type (1,1) maximal bound** turns integrable size into control of a
bad set. For a real observable, it says that the set of starting points where
at least one positive-time average has large absolute value has measure at
most the observable's \(L^1\) size divided by the positive threshold. The
first \(1\) refers to the integrable input scale. The second \(1\) refers to a
weak \(L^1\) level-set estimate, not to an integrable norm bound for a maximal
function.

Random-matrix-theory milestone 26 (RMT-26) applies this estimate to an
approximation error. That is the quantitative stability needed to pass
pointwise convergence from a dense good class to every real integrable
observable. The complete implementation narrative is
[The Missing Step Closes: Pointwise Birkhoff by Maximal Control in Lean]({{< relref "/development-notebook/2026/07/finite-measure-pointwise-birkhoff-by-maximal-closure-in-lean" >}}).
The connected textbook chapter is
[Pointwise Birkhoff from Maximal Control and Dense Good Functions]({{< relref "/knowledge-base/deep-dives/pointwise-birkhoff-from-maximal-control-and-dense-good-functions" >}}).

{{< reference-figure
  src="weak-type-one-one-maximal-bound.svg"
  alt="An integrable error enters from the left with its total integral size. A positive threshold gate selects starting points having at least one larger absolute Birkhoff average. The selected region on the right is bounded in measure by input size divided by the threshold."
  caption="**Finding:** the maximal bound does not make every orbit-average error uniformly small. It says that a small \(L^1\) error can expose a large average only on a set whose measure is quantitatively small. Raising the threshold shrinks the upper bound, while threshold zero lies outside the division theorem. The diagram represents a theorem inequality, not measured frequencies or a strong maximal-function norm estimate."
>}}

## Exact event-level definition

Let Ω be a state space, let \(T:\Omega\to\Omega\) be a discrete-time map,
and let \(h:\Omega\to\mathbb R\) be a real observable. At a natural horizon
\(n\), define the normalized {{< refterm "birkhoff-sum" "Birkhoff average" >}}

\[
A_nh(\omega)
{} =
\frac{1}{n}\sum_{0\le j\lt n}h\bigl(T^j\omega\bigr).
\]

For a real threshold \(a\), the absolute positive-time exceedance event is

\[
M_a(T,h)
{} =
\left\{\omega:\
\exists n\in\mathbb N,\
1\le n\ \text{and}\
a\lt|A_nh(\omega)|
\right\}.
\]

RMT-26 names this set directly instead of defining a new real-valued supremum:

~~~lean
def birkhoffAverageAbsoluteExceedanceSet
    (T : Ω → Ω) (h : Ω → ℝ) (a : ℝ) : Set Ω :=
  {ω | ∃ k, 1 ≤ k ∧
    a < |birkhoffAverage ℝ T h k ω|}
~~~

Assume that \(\mu\) is a finite measure on \(\Omega\), \(T\) preserves
\(\mu\), \(h\) is integrable, and \(a\gt0\). The checked weak estimate is

\[
\mu_{\mathbb R}\bigl(M_a(T,h)\bigr)
\le
\frac{\displaystyle\int_\Omega |h(\omega)|\,d\mu(\omega)}{a}.
\]

The notation \(\mu_{\mathbb R}\) denotes Mathlib's real-valued projection of
the extended nonnegative measure. Finite total mass ensures that no infinite
set measure is sent through the projection. The numerator is exactly the
\(L^1\) norm of a real integrable representative.

In standard weak-type notation, an operator \(\mathcal M\) has weak type
\((1,1)\) with constant \(C\) when

\[
\mu\{\omega:|\mathcal Mh(\omega)|\gt a\}
\le \frac{C\lVert h\rVert_1}{a}
\qquad(a\gt0).
\]

The RMT-26 result has the event-level shape with \(C=1\). It deliberately
does not construct \(\mathcal Mh\) as a finite real number at every point.
The existential event remains meaningful even when the sequence of absolute
averages is unbounded.

## Why the estimate is absolute

The earlier
{{< refterm "infinite-horizon-birkhoff-average-exceedance-event" "infinite-horizon Birkhoff-average exceedance event" >}}
is one-sided. It records a witness to
\(a\lt A_nh(\omega)\), and its bound uses the positive part of \(h\). RMT-26
needs control of \(|A_nh|\) because the error between two average sequences
can have either sign.

For every horizon, the finite triangle inequality gives

\[
|A_nh(\omega)|
\le A_n|h|(\omega).
\]

At horizon zero both sides are zero under Lean's totalized inverse convention.
At positive horizons this is the ordinary triangle inequality for a finite
sum, divided by the nonnegative integer \(n\). Therefore

\[
M_a(T,h)
\subseteq
\left\{\omega:\exists n\ge1,\ a\lt A_n|h|(\omega)\right\}.
\]

Apply the RMT-24 one-sided weak estimate to \(|h|\). Since \(|h|\ge0\), its
positive part is itself, and the numerator simplifies to \(\int|h|\,d\mu\).
This proves the absolute theorem without adding an invertibility or
ergodicity premise and without defining a supremum function.

## Worked example: identity dynamics on two points

Let \(\Omega=\{p,q\}\) carry counting measure, so
\(\mu(\Omega)=2\). This is a finite measure but not a probability measure.
Let \(T\) be the identity and define

\[
h(p)=3,
\qquad
h(q)=1.
\]

For every positive horizon, the orbit stays at its starting point, so

\[
A_nh(p)=3,
\qquad
A_nh(q)=1.
\]

At threshold \(a=2\), strict exceedance occurs only at \(p\):

\[
M_2(T,h)=\{p\},
\qquad
\mu\bigl(M_2(T,h)\bigr)=1.
\]

The integrable size is

\[
\int_\Omega|h|\,d\mu=|3|+|1|=4.
\]

The weak bound reads

\[
1
{} =
\mu\bigl(M_2(T,h)\bigr)
\le \frac{4}{2}=2.
\]

The inequality is valid and not tight in this example. At threshold \(a=3\),
the event is empty because equality is not a strict crossing. At threshold
\(a=1\), the point \(q\) is still excluded for the same reason, while \(p\)
remains included. These checks expose both the positive-time convention and
the strict threshold convention.

For identity dynamics the theorem reduces to the familiar level-set estimate
for an integrable function. In general dynamics, one starting point samples
many values of \(h\), and the same bound controls a threshold crossing at any
positive time.

## Why weak control is the right closure tool

Suppose \(f\) is a target observable and \(g\) is a nearby observable whose
Birkhoff averages already converge almost everywhere. Set \(h=f-g\). Small
\(L^1\) distance means that

\[
\lVert f-g\rVert_1
{} =
\int_\Omega|h|\,d\mu
\]

is small. It does not imply a pointwise bound on \(h\), and it certainly does
not imply that every orbit average of \(h\) is uniformly small. The weak
estimate gives precisely the available replacement:

\[
\mu_{\mathbb R}\bigl(M_a(T,f-g)\bigr)
\le \frac{\lVert f-g\rVert_1}{a}.
\]

Outside this controlled event, every positive-time error average has absolute
value at most \(a\). Choose \(a=\varepsilon/3\). If the average sequence of
\(g\) is already Cauchy at scale \(\varepsilon/3\), then the three-term
comparison

\[
|A_mf-A_nf|
\le
|A_m(f-g)|+|A_mg-A_ng|+|A_n(f-g)|
\]

makes the average sequence of \(f\) Cauchy at scale \(\varepsilon\), except
on the maximal-error event and the null set where \(g\) fails to converge.
This is the engine behind the
{{< refterm "birkhoff-cauchy-exceptional-set" "Birkhoff Cauchy exceptional set" >}}
estimate.

If pointwise-good approximants can be chosen at arbitrarily small \(L^1\)
distance, the upper bound tends to zero at every fixed positive scale. The
exceptional set is null. A countable intersection over reciprocal scales then
gives full-sequence almost-everywhere convergence. Weak control is enough
because the desired conclusion is also almost everywhere. A strong
\(L^1\)-norm estimate for a maximal function is neither stated nor consumed.

This pattern is historically associated with maximal-to-pointwise proofs.
Yosida and Kakutani's 1939 transformation theorem introduced an explicit
maximal ergodic theorem. Yosida's 1940 development paired maximal control with
a closure principle, and Keane and Petersen's 2006 proof presents a compact
modern probability-space route. RMT-26 follows the same high-level strategy
through repository-specific finite and infinite event theorems.

## Event bounds, not pointwise bounds

The conclusion controls a set measure. It must not be rewritten as

\[
|A_nh(\omega)|\le \frac{\lVert h\rVert_1}{a}
\]

for each point or horizon. That expression has the wrong logical form and the
wrong units. The actual theorem says that the set on which **some** horizon
crosses \(a\) is small. A few starting points may have very large orbit
averages while the estimate remains true.

Nor does the theorem say that the event measure equals the quotient. The
right side may exceed the total mass of the space, as the two-point example
shows. One may combine it with the trivial bound
\(\mu(M_a)\le\mu(\Omega)\), but RMT-26 does not package that minimum because
the quotient form is exactly what the closure argument needs.

## Boundary cases and nonclaims

- **The threshold is strictly positive.** At \(a=0\), the event can be
  nonempty, while real division by zero is totalized in Lean. A theorem with
  the displayed quotient at zero would therefore be false in general.
  Negative thresholds are even less suitable: since absolute values are
  nonnegative, every point crosses every negative threshold at time one.
- **The crossing is strict.** Equality \(|A_nh|=a\) does not witness the
  event. The complement consequently supplies the useful weak inequality
  \(|A_nh|\le a\) at every positive horizon.
- **Time zero is excluded.** The definition requires \(1\le n\). The
  totalized empty average cannot create a witness.
- **Finite measure is explicit.** Probability normalization is stronger and
  unnecessary. On an infinite-measure space, Mathlib's real projection sends
  infinite extended mass to zero, so the displayed real-valued argument cannot
  simply be reused unchanged. Finite total mass is the checked boundary of
  this proof route, not a claim that the broader pointwise theorem is false on
  every infinite-measure space.
- **The zero measure is allowed.** Both sides are zero. This is a valid but
  vacuous measure bound and does not establish pointwise smallness.
- **Only measure preservation is assumed of the dynamics.** Ergodicity,
  injectivity, surjectivity, invertibility, and mixing are absent.
- **Integrability is representative-sensitive only on null sets.** Changing
  \(h\) on a null set may alter the raw event at individual points. Under the
  measure-preserving hypotheses, the measure estimate remains an
  almost-everywhere statement about the chosen representative.

The weak bound does not identify a limit, prove convergence by itself, show
that the maximal event is invariant, give an \(L^1\)-integrable maximal
function, establish norm convergence of averages, or imply an ergodic
constant. It also does not prove Kingman's subadditive theorem, a Lyapunov
exponent, or an Oseledets filtration or splitting.

## Lean interface

RMT-26 exposes the absolute weak estimate through five declarations:

- <code>abs_birkhoffAverage_le_birkhoffAverage_abs</code>, the finite-sum
  triangle inequality, including the totalized horizon-zero case;
- <code>birkhoffAverageAbsoluteExceedanceSet</code>, the strict positive-time
  event;
- <code>mem_birkhoffAverageAbsoluteExceedanceSet_iff</code>, its exact witness
  interface;
- <code>birkhoffAverageAbsoluteExceedanceSet_subset</code>, reduction to the
  one-sided event for \(|h|\); and
- <code>measureReal_birkhoffAverageAbsoluteExceedanceSet_le</code>, the
  finite-measure weak-type \((1,1)\) estimate at a positive threshold.

The upstream
<code>measureReal_birkhoffAverageExceedanceSet_le</code> declaration in RMT-24
supplies the one-sided bound. RMT-26 then consumes the absolute version in
<code>measureReal_birkhoffCauchyExceptionalSet_le</code> and the dense-good
closure theorem.

## Related concepts

- {{< refterm "finite-maximal-ergodic-inequality" "Finite maximal ergodic inequality" >}}
  supplies the horizon-uniform finite estimate upstream of the infinite
  event.
- {{< refterm "infinite-horizon-birkhoff-average-exceedance-event" "Infinite-horizon Birkhoff-average exceedance event" >}}
  explains the exact positive-time existential event and its one-sided weak
  bound.
- {{< refterm "birkhoff-cauchy-exceptional-set" "Birkhoff Cauchy exceptional set" >}}
  shows how the absolute estimate controls persistent tail separation.
- {{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}}
  is the final set entered after the reciprocal-scale Cauchy argument.
- {{< refterm "almost-everywhere" "Almost everywhere" >}} explains the
  null-set language used in the closure step.

## References

<a id="ref-weak-yosida-kakutani"></a>**Kôsaku Yosida and Shizuo Kakutani.**
[Birkhoff's Ergodic Theorem and the Maximal Ergodic Theorem](https://doi.org/10.3792/pia/1195579375),
*Proceedings of the Imperial Academy* 15(6), 165-168, 1939. Theorem 2 gives
the historical transformation maximal theorem. Its assumptions and notation
are not identical to the RMT-26 interface.

<a id="ref-weak-yosida"></a>**Kôsaku Yosida.**
[Ergodic theorems of Birkhoff-Khintchine's type](https://doi.org/10.4099/jjm1924.17.0_31),
*Japanese Journal of Mathematics* 17, 31-36, 1940. Pages 33-34 combine
maximal control with a dense-class closure argument.

<a id="ref-weak-garsia"></a>**Adriano Garsia.**
[A Simple Proof of E. Hopf's Maximal Ergodic Theorem](https://doi.org/10.1512/iumj.1965.14.14027),
*Journal of Mathematics and Mechanics* 14(3), 381-382, 1965. This short paper
is a primary source for the finite-maximum proof style upstream of the
repository's finite event inequality.

<a id="ref-weak-keane-petersen"></a>**Michael Keane and Karl Petersen.**
[Easy and Nearly Simultaneous Proofs of the Ergodic Theorem and Maximal Ergodic Theorem](https://doi.org/10.1214/074921706000000266),
*IMS Lecture Notes-Monograph Series* 48, 248-251, 2006, with
[arXiv:math/0608251](https://arxiv.org/abs/math/0608251). The paper treats a
possibly noninvertible measure-preserving transformation on a probability
space and cleanly separates maximal control from the convergence corollary.

<a id="ref-weak-mathlib"></a>**Mathlib contributors.**
[Finite-measure real-valued measure interface](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/Real.lean)
and the pinned Mathlib 4.32.0 tree at commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).
These interfaces make the finiteness boundary of the real-valued estimate
explicit.

<a id="ref-weak-lean"></a>**Nonlinear Dynamics in Lean contributors.**
[`InfiniteHopfMaximal.lean`](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/InfiniteHopfMaximal.lean)
and
[`PointwiseBirkhoff.lean`](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/PointwiseBirkhoff.lean),
the checked sources for the one-sided and absolute event bounds.
