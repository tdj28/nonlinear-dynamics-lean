---
title: "Birkhoff Cauchy exceptional set"
slug: "birkhoff-cauchy-exceptional-set"
summary: "A Birkhoff Cauchy exceptional set contains the starting points whose orbit-average sequence keeps separating by at least one fixed positive scale arbitrarily far into its tail."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoff"
og_image: "birkhoff-cauchy-exceptional-set-card.png"
og_image_alt: "Warm-paper glossary card showing arbitrarily late pairs of Birkhoff averages separated by a fixed positive tolerance, followed by reciprocal tolerances that rule out every positive tail separation."
---

A **Birkhoff Cauchy exceptional set** is a fixed-scale failure event for one
sequence of orbit averages. A starting point belongs to the set when, no
matter how far into the sequence one moves, two still later averages remain
separated by at least the chosen scale. It converts the qualitative question
"does this sequence converge?" into countably measurable events that can be
bounded one scale at a time.

Random-matrix-theory milestone 26 (RMT-26) uses these sets to close the gap
between a dense class of observables with known pointwise convergence and all
real integrable observables. The complete checked narrative is
[The Missing Step Closes: Pointwise Birkhoff by Maximal Control in Lean]({{< relref "/development-notebook/2026/07/finite-measure-pointwise-birkhoff-by-maximal-closure-in-lean" >}}).
The textbook treatment is
[Pointwise Birkhoff from Maximal Control and Dense Good Functions]({{< relref "/knowledge-base/deep-dives/pointwise-birkhoff-from-maximal-control-and-dense-good-functions" >}}).

{{< reference-figure
  src="birkhoff-cauchy-exceptional-set.svg"
  alt="For every proposed tail cutoff, two later Birkhoff averages remain at least a fixed positive tolerance apart, so the starting point stays in the fixed-scale exceptional set. A lower panel contrasts this with the complement, where one tail is controlled at that one scale."
  caption="**Finding:** one fixed-scale exceptional set records a persistent tail separation, not merely an early fluctuation. Its complement supplies one tail on which every pair is strictly closer than the scale. Avoiding the countable scales \(1/(k+1)\) therefore gives the full Cauchy criterion. The plotted values are conceptual and do not identify an ergodic limit."
>}}

## Exact operational definition

Let Ω be a state space, let \(T:\Omega\to\Omega\) be a discrete-time map,
and let \(f:\Omega\to\mathbb R\) be a real observable. For a starting point
\(\omega\in\Omega\) and horizon \(n\in\mathbb N\), write

\[
A_n f(\omega)
{} =
\frac{1}{n}\sum_{0\le j\lt n} f\bigl(T^j\omega\bigr).
\]

This is the normalized {{< refterm "birkhoff-sum" "Birkhoff sum" >}}.
Lean totalizes the inverse of zero, so \(A_0f(\omega)=0\). That finite
convention will not affect any tail statement.

Fix a real scale \(\varepsilon\). The exceptional set is

\[
D_\varepsilon(T,f)
{} =
\left\{\omega:\
  \forall N\in\mathbb N,\
  \exists m\ge N,\
  \exists n\ge N,\
  \varepsilon\le
    \left|A_mf(\omega)-A_nf(\omega)\right|
\right\}.
\]

The checked Lean definition preserves that quantifier order:

~~~lean
def birkhoffCauchyExceptionalSet
    (T : Ω → Ω) (f : Ω → ℝ) (ε : ℝ) : Set Ω :=
  {ω | ∀ N : ℕ, ∃ m ≥ N, ∃ n ≥ N,
    ε ≤ |birkhoffAverage ℝ T f m ω -
      birkhoffAverage ℝ T f n ω|}
~~~

Three details are structural.

First, \(\varepsilon\) is fixed before the tail cutoff \(N\). The set does
not require one pair of averages to defeat every tolerance. Second, the two
witness horizons may depend on \(N\). Persistent oscillation can therefore
move farther out as the requested tail moves. Third, the exceptional
comparison is non-strict. Its logical complement is the strict tail estimate

\[
\omega\notin D_\varepsilon(T,f)
\quad\Longleftrightarrow\quad
\exists N\ \forall m,n\ge N,\
\left|A_mf(\omega)-A_nf(\omega)\right|\lt\varepsilon.
\]

That strict inequality is exactly the form used by the metric Cauchy
criterion.

## Worked example: averages prescribed to alternate

The definition itself needs no measure or measurability. This makes it easy to
test on a deliberately divergent orbit. Let \(\Omega=\mathbb N\), let
\(T(k)=k+1\), and start at \(0\). Define

\[
f(k)
{} =
(k+1)(-1)^{k+1}-k(-1)^k.
\]

For every positive \(n\), the orbit sum telescopes:

\[
\begin{aligned}
\sum_{k=0}^{n-1}f(k)
&=\sum_{k=0}^{n-1}
  \left((k+1)(-1)^{k+1}-k(-1)^k\right) \\
&=n(-1)^n.
\end{aligned}
\]

Consequently,

\[
A_nf(0)=(-1)^n
\qquad\text{for every }n\ge1.
\]

Given any cutoff \(N\), choose
\(m=2(N+1)\) and \(n=2(N+1)+1\). Both horizons are at least \(N\), while

\[
\left|A_mf(0)-A_nf(0)\right|
{} = |1-(-1)|=2.
\]

Thus \(0\in D_\varepsilon(T,f)\) for every
\(0\lt\varepsilon\le2\). If \(\varepsilon\gt2\), choose the tail cutoff
\(N=1\). All later averages are either \(1\) or \(-1\), so every later pair
has distance at most \(2\lt\varepsilon\). Hence
\(0\notin D_\varepsilon(T,f)\) at those larger scales.

This example checks both inclusions at the threshold \(2\). It is not an
application of the pointwise ergodic theorem: the observable is unbounded and
is not integrable for counting measure on \(\mathbb N\). Its job is to test
the raw event definition.

## From one scale to the Cauchy property

A real sequence is Cauchy when every positive tolerance eventually controls
every pair in one common tail. It would be inconvenient to intersect over all
positive real tolerances because that family is uncountable. The reciprocal
natural scales

\[
r_k=\frac{1}{k+1},\qquad k\in\mathbb N,
\]

solve the problem. They are positive, countable, and approach zero. If a point
avoids every \(D_{r_k}(T,f)\), then for a requested \(r\gt0\) one can choose
\(k\) with \(r_k\lt r\). Nonmembership at scale \(r_k\) gives a tail whose
pairs are closer than \(r_k\), hence closer than \(r\). Therefore the average
sequence is Cauchy.

Because the real numbers are complete, the Cauchy sequence converges to some
real limit. This yields membership in the
{{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}}.
It does not yet say what the limit is.

## Measurability and representatives

If \(T\) and \(f\) are measurable, each finite average is measurable. The
event can then be expanded as

\[
D_\varepsilon(T,f)
{} =
\bigcap_{N\in\mathbb N}
\bigcup_{\substack{m\in\mathbb N\\N\le m}}
\bigcup_{\substack{n\in\mathbb N\\N\le n}}
\left\{\omega:
\varepsilon\le|A_mf(\omega)-A_nf(\omega)|
\right\}.
\]

Countable intersections and unions preserve measurability, and the innermost
set is the inverse image of a closed real ray under a measurable function.
This is the architecture of
<code>measurableSet_birkhoffCauchyExceptionalSet</code>.

An integrable observable in Mathlib is represented by an ordinary function
that is only guaranteed to be measurable almost everywhere. If
\(f=g\) {{< refterm "almost-everywhere" "almost everywhere" >}}, and
\(T\) is quasi-measure-preserving, the equality can be pulled back along every
finite iterate of \(T\). The two average sequences then agree almost
everywhere at every natural horizon. Since the horizon family is countable,
the two exceptional sets agree almost everywhere.

This representative transport proves null measurability from either an
almost-everywhere measurable or an integrable representative. It does not
claim literal equality of the two sets. Changing a function on a null set may
change membership at individual starting points even though it cannot change
the event modulo a null set under the stated dynamics.

## Why maximal control makes the event small

Suppose \(g\) is an approximating observable whose averages converge at
\(\omega\). Its average sequence is then Cauchy. For late horizons \(m,n\),
insert the two approximating averages:

\[
\begin{aligned}
|A_mf-A_nf|
&\le |A_mf-A_mg|
  +|A_mg-A_ng|
  +|A_ng-A_nf| \\
&=|A_m(f-g)|
  +|A_mg-A_ng|
  +|A_n(f-g)|.
\end{aligned}
\]

At a positive scale \(\varepsilon\), the middle term is eventually strictly
below \(\varepsilon/3\). If neither endpoint error ever strictly exceeds
\(\varepsilon/3\), each endpoint term is at most that value. The total is
then strictly below \(\varepsilon\), contradicting a witness for
\(D_\varepsilon(T,f)\). RMT-26 packages this as

\[
D_\varepsilon(T,f)
\subseteq
M_{\varepsilon/3}(T,f-g)
\cup
\operatorname{Conv}(T,g)^c,
\]

where \(M_a\) is the absolute positive-time maximal exceedance event and
\(\operatorname{Conv}(T,g)\) is the convergence event of \(g\).

If \(\mu\) is finite, \(T\) preserves \(\mu\), \(f-g\) is integrable, and
\(g\) converges almost everywhere, the
{{< refterm "weak-type-one-one-maximal-bound" "weak-type (1,1) maximal bound" >}}
gives

\[
\mu_{\mathbb R}\bigl(D_\varepsilon(T,f)\bigr)
\le
\frac{\displaystyle\int_\Omega|f-g|\,d\mu}
     {\varepsilon/3}.
\]

Here \(\mu_{\mathbb R}\) is Mathlib's real-valued view of the finite measure.
If pointwise-good approximants exist at arbitrarily small integrable distance,
the right side can be made smaller than every positive real number. The
exceptional set therefore has measure zero. Intersecting the complements over
all reciprocal scales gives one conull set, meaning a set whose complement has
measure zero, on which the complete average
sequence is Cauchy and hence convergent.

This is a Banach-principle closure argument. Banach's 1926 paper established
an early general extension principle for almost-everywhere convergence from a
dense class. Yosida's 1940 proof of an ergodic theorem explicitly combines a
closure lemma attributed to Banach with convergence on a bounded dense class.
RMT-26 follows that architecture through its own checked maximal estimate and
does not claim to formalize either historical theorem word for word.

## Boundary cases and nonclaims

- **The scale must be positive in the closure theorem.** At
  \(\varepsilon=0\), every point is exceptional: for each \(N\), take
  \(m=n=N\), so \(0\le|A_mf-A_nf|=0\). The same argument covers negative
  scales. The raw set is still defined, but it carries no Cauchy information.
- **Horizon zero is harmless.** The set quantifies over all natural horizons,
  yet a tail cutoff can always be increased past one. RMT-26 does exactly that
  before invoking a positive-time maximal event. The totalized value
  \(A_0f=0\) is never used as a lasting convergence constraint.
- **Identity dynamics are not exceptional at positive scales.** For
  \(T=\operatorname{id}\), every positive-time average equals \(f(\omega)\).
  Choosing \(N=1\) shows that \(D_\varepsilon(T,f)\) is empty for every
  \(\varepsilon\gt0\), even before measurability is discussed.
- **Zero measure does not make the raw set empty.** It makes every set null.
  An almost-everywhere conclusion over the zero measure is valid but vacuous.
- **Probability and ergodicity are absent.** Finite total mass need not be
  one, and the closure theorem does not assume that invariant events are
  trivial.
- **No invertibility is hidden.** Measure preservation supplies measurable
  forward iteration. Injectivity, surjectivity, a measurable inverse, and an
  equivalence structure are not premises.

Membership in one positive-scale exceptional set proves that the average
sequence is not Cauchy, but nonmembership in one such set does not prove
convergence. One must avoid a cofinal family of scales. Conversely, nullity of
each scale separately becomes an almost-everywhere convergence statement only
after a countable intersection. None of these steps identifies the limit,
proves integrable-norm convergence, establishes an ergodic constant, or proves
Kingman's subadditive ergodic theorem, a Lyapunov exponent, or an Oseledets
splitting.

## Lean interface

The RMT-26 declarations attached directly to this term are:

- <code>birkhoffCauchyExceptionalSet</code> and
  <code>mem_birkhoffCauchyExceptionalSet_iff</code>, the set and its exact
  witness interface;
- <code>measurableSet_birkhoffCauchyExceptionalSet</code>, the ordinary
  measurable route;
- <code>birkhoffCauchyExceptionalSet_ae_eq_of_ae_eq</code>, representative
  transport under quasi-measure preservation;
- <code>nullMeasurableSet_birkhoffCauchyExceptionalSet_of_aemeasurable</code>
  and
  <code>nullMeasurableSet_birkhoffCauchyExceptionalSet_of_integrable</code>,
  the two null-measurable routes;
- <code>birkhoffCauchyExceptionalSet_subset_exceedance_union_compl</code>, the
  three-error pointwise containment;
- <code>measureReal_birkhoffCauchyExceptionalSet_le</code>, its quantitative
  finite-measure estimate;
- <code>measure_birkhoffCauchyExceptionalSet_eq_zero_of_dense_good</code>, the
  dense-good nullity theorem; and
- <code>cauchySeq_birkhoffAverage_of_not_mem_exceptional</code>, the reciprocal
  scale bridge to the metric Cauchy criterion.

The later theorem <code>ae_mem_birkhoffConvergenceSet_of_dense_good</code>
assembles those declarations into almost-everywhere convergence.

## Related concepts

- {{< refterm "birkhoff-sum" "Birkhoff sum" >}} supplies the finite sums and
  normalized averages used in the event.
- {{< refterm "birkhoff-convergence-event" "Birkhoff convergence event" >}}
  records the existence of a finite real limit after the Cauchy step.
- {{< refterm "infinite-horizon-birkhoff-average-exceedance-event" "Infinite-horizon Birkhoff-average exceedance event" >}}
  is the one-sided positive-time event from which absolute error control is
  derived.
- {{< refterm "almost-everywhere" "Almost everywhere" >}} explains why
  representative changes and countable conull intersections must be tracked
  explicitly.
- {{< refterm "koopman-coboundary" "Koopman coboundary" >}} describes one
  component of the dense pointwise-good core used by RMT-26.

## References

<a id="ref-cauchy-banach"></a>**Stefan Banach.**
[Sur la convergence presque partout de fonctionnelles linéaires](http://kielich.amu.edu.pl/Stefan_Banach/pdf/oeuvres2/355.pdf),
*Bulletin des Sciences Mathématiques* 50, 27-32 and 36-43, 1926. Theorems I
and III develop continuity in measure and extension of almost-everywhere
convergence from a dense subset. RMT-26 uses the strategy, not Banach's exact
statement.

<a id="ref-cauchy-yosida"></a>**Kôsaku Yosida.**
[Ergodic theorems of Birkhoff-Khintchine's type](https://doi.org/10.4099/jjm1924.17.0_31),
*Japanese Journal of Mathematics* 17, 31-36, 1940. Pages 33-34 combine a
closure lemma attributed to Banach with convergence on a bounded dense class.

<a id="ref-cauchy-keane-petersen"></a>**Michael Keane and Karl Petersen.**
[Easy and Nearly Simultaneous Proofs of the Ergodic Theorem and Maximal Ergodic Theorem](https://doi.org/10.1214/074921706000000266),
*IMS Lecture Notes-Monograph Series* 48, 248-251, 2006, with
[arXiv:math/0608251](https://arxiv.org/abs/math/0608251). The paper gives a
closely related maximal-to-pointwise route for a possibly noninvertible
measure-preserving transformation on a probability space. RMT-26 instead
states its convergence theorem for an arbitrary finite measure.

<a id="ref-cauchy-mathlib"></a>**Mathlib contributors.**
[Metric Cauchy sequences](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/MetricSpace/Cauchy.lean#L59-L67),
[almost-everywhere countable quantification](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/OuterMeasure/AE.lean#L95-L97),
and the pinned Mathlib 4.32.0 tree at commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).
The local checkout, rather than these broad source links, is the exact interface
authority for the checked declaration signatures.

<a id="ref-cauchy-lean"></a>**Nonlinear Dynamics in Lean contributors.**
[`PointwiseBirkhoff.lean`](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/PointwiseBirkhoff.lean),
the checked source defining and using the event.
