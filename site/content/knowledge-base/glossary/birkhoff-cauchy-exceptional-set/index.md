---
title: "Birkhoff Cauchy exceptional set"
slug: "birkhoff-cauchy-exceptional-set"
summary: "A Birkhoff Cauchy exceptional set contains the starting points whose orbit-average sequence keeps separating by at least one fixed positive scale arbitrarily far into its tail."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoff"
og_image: "birkhoff-cauchy-exceptional-set-card.png"
og_image_alt: "A positive-time average sequence alternating between minus one and one has later pairs at distance two beyond cutoffs one, four, and seven, while a constant average sequence has tail distance zero."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note. Human review
of the mathematics, Lean interpretation, sources, figure, and accessibility
remains pending. Publication lets readers inspect the construction; it does
not certify professional review.
{{< /panel >}}

Start with a sequence of positive-time orbit averages that alternates forever:

\[
A_1=-1,\quad A_2=1,\quad A_3=-1,\quad A_4=1,\quad\ldots
\]

Fix the separation scale \(\varepsilon=2\). No proposed tail cutoff repairs
the oscillation. After any cutoff \(N\ge1\), choose an even
\(m\ge N\) and the next odd horizon \(n=m+1\). Then

\[
|A_m-A_n|=|1-(-1)|=2\ge\varepsilon.
\]

For example, cutoffs \(1,4,7\) admit witness pairs
\((2,3),(4,5),(8,9)\). The witnesses move later when the cutoff moves later;
the fixed scale stays the same. This starting point is exceptional at scale
\(2\).

Now compare identity dynamics with a constant reading \(3\). Every
positive-time average is \(3\), so after cutoff \(1\) every pair has distance
\(0\lt1/2\). That point is **not** exceptional at scale \(1/2\). The two
exact sequences expose both sides of the definition before any measure or
ergodic theorem enters. A concrete observable producing the alternating
sequence is derived below.

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
  alt="The average sequence minus one, one, minus one, one and so on has witness pairs at distance two beyond cutoffs one, four, and seven. A constant sequence equal to three has tail distance zero, and a final ladder shows reciprocal scales one, one half, one third, and so on."
  caption="**Exact fixed-scale comparison:** for \(A_n=(-1)^n\) at positive time and \(\varepsilon=2\), the later pairs \((2,3),(4,5),(8,9)\) defeat the sample cutoffs \(1,4,7\), and the parity construction supplies such a pair after every cutoff. For the constant sequence \(A_n=3\), cutoff \(1\) makes every pair distance \(0\lt1/2\), proving nonmembership at that scale. Avoiding all reciprocal-scale exceptional sets \(D_{1/(k+1)}\) yields the complete Cauchy criterion. The values are exact toy calculations; no measure, ergodicity, or limit identification is asserted."
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

## In Lean: fixed-scale membership

{{< lean-bridge
  human="A starting point is exceptional at scale epsilon when every proposed tail cutoff still has two later Birkhoff averages at least epsilon apart."
  math="\(\omega\in D_\varepsilon(T,f)\Longleftrightarrow\forall N,\ \exists m\ge N,\ \exists n\ge N,\ \varepsilon\le|A_mf(\omega)-A_nf(\omega)|.\)"
  lean="mem_birkhoffCauchyExceptionalSet_iff"
>}}

- <code>ω ∈ birkhoffCauchyExceptionalSet T f ε</code> is membership of one
  starting point in one fixed-scale event.
- <code>∀ N : ℕ</code> lets an adversary choose any tail cutoff.
- The nested witnesses <code>∃ m ≥ N, ∃ n ≥ N</code> may change with that
  cutoff; one fixed pair is not required to work forever.
- The final comparison is non-strict <code>ε ≤ |...|</code>. Negating it
  produces the strict tail inequality required by the metric Cauchy test.
- The theorem is proved by <code>rfl</code>: it exposes the definition without
  adding measurability, a measure, or convergence.
{{< /lean-bridge >}}

## In Lean: maximal control bounds one bad scale

{{< lean-bridge
  human="If g already converges almost everywhere, the measure of f's epsilon-Cauchy failures is bounded by the L1 approximation error divided by epsilon over three."
  math="\(\mu_{\mathbb R}(D_\varepsilon(T,f))\le\dfrac{\int|f-g|\,d\mu}{\varepsilon/3},\qquad\varepsilon>0.\)"
  lean="measureReal_birkhoffCauchyExceptionalSet_le hT hfg hgood hε"
>}}

- <code>hT : MeasurePreserving T μ μ</code> supplies the dynamical transport.
- <code>hfg : Integrable (f - g) μ</code> makes the approximation error an
  \(L^1\) input.
- <code>hgood : ∀ᵐ ω ∂μ, ω ∈ birkhoffConvergenceSet T g</code> says the
  approximant's averages converge outside a null set.
- <code>hε : 0 &lt; ε</code> makes all three error budgets positive and licenses
  division by <code>ε / 3</code>.
- The ambient <code>[IsFiniteMeasure μ]</code> instance makes
  <code>μ.real</code> a faithful real-valued mass in this argument.
- This is event-measure control, not a pointwise bound on every orbit.
{{< /lean-bridge >}}

## In Lean: reciprocal scales give the full Cauchy property

{{< lean-bridge
  human="If omega avoids the exceptional event at every reciprocal natural scale, its complete Birkhoff-average sequence is Cauchy."
  math="\(\bigl[\forall k,\ \omega\notin D_{1/(k+1)}(T,f)\bigr]\Longrightarrow(A_nf(\omega))_n\text{ is Cauchy}.\)"
  lean="cauchySeq_birkhoffAverage_of_not_mem_exceptional ω hω"
>}}

- <code>hω : ∀ k : ℕ, ω ∉ ...</code> is countable scale-by-scale
  nonmembership.
- Lean writes the scale as <code>1 / ((k : ℝ) + 1)</code>; the cast puts the
  natural index into the real denominator.
- <code>CauchySeq</code> is the metric Cauchy property for the entire natural
  sequence, not a subsequence.
- <code>exists_nat_one_div_lt</code> chooses a reciprocal scale strictly below
  any requested positive tolerance.
- Completeness of \(\mathbb R\) is a later step from <code>CauchySeq</code> to
  existence of a finite real limit.
{{< /lean-bridge >}}

### Exact declaration ledger

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

## Standalone tutorial

**Standalone tutorial.** This complete file constructs
integer partial sums whose positive-time averages alternate exactly between
\(-1\) and \(1\). It then computes the moving witnesses for cutoffs
\(1,4,7\) and contrasts the constant-average complement. It imports only
Lean's <code>Std</code> library; it does not define measures or the general
Cauchy event.

Save it as <code>BirkhoffCauchyScratch.lean</code>:

~~~lean
import Std

namespace BirkhoffCauchyScratch

def targetSum (n : Nat) : Int :=
  if n % 2 = 0 then Int.ofNat n else -Int.ofNat n

def reading (k : Nat) : Int :=
  targetSum (k + 1) - targetSum k

def orbitSum (n : Nat) : Int :=
  (List.range n).foldl (fun total k => total + reading k) 0

def average (n : Nat) : Int :=
  if n = 0 then 0 else orbitSum n / Int.ofNat n

def evenAtOrAfter (N : Nat) : Nat :=
  if N % 2 = 0 then N else N + 1

def witness (N : Nat) : Nat × Nat :=
  let m := evenAtOrAfter (max N 1)
  (m, m + 1)

def witnessDistance (N : Nat) : Nat :=
  let pair := witness N
  (average pair.1 - average pair.2).natAbs

#eval (List.range 9).map (fun j => average (j + 1))
#eval [witness 1, witness 4, witness 7]
#eval [witnessDistance 1, witnessDistance 4, witnessDistance 7]

example : (List.range 6).map (fun j => average (j + 1)) =
    [-1, 1, -1, 1, -1, 1] := by decide
example : witness 1 = (2, 3) := by decide
example : witness 4 = (4, 5) := by decide
example : witness 7 = (8, 9) := by decide
example : witnessDistance 1 = 2 := by decide
example : witnessDistance 4 = 2 := by decide
example : witnessDistance 7 = 2 := by decide
example : ((3 : Int) - 3).natAbs < 1 := by decide

end BirkhoffCauchyScratch
~~~

Run it on an ordinary Mac or Linux machine with the pinned compiler:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean BirkhoffCauchyScratch.lean
~~~

This exact worksheet was executed successfully with Lean 4.32.0 while editing
this page. The average row was
<code>[-1, 1, -1, 1, -1, 1, -1, 1, -1]</code>. The witness rows should be
<code>[(2, 3), (4, 5), (8, 9)]</code> and <code>[2, 2, 2]</code>.
The last theorem checks the constant-sequence distance \(0\lt1\), an
integer-scaled version of the \(0\lt1/2\) complement example. The finite
program audits the arithmetic; the parity argument above proves witnesses
exist beyond every cutoff.

## Try the exact declarations in the project

{{< repo-check >}}
**Full project check.** This uses the repository's pinned Lean and Mathlib
dependencies and may require substantial disk space and memory.
Create a temporary project worksheet containing:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.PointwiseBirkhoff

open MeasureTheory Filter
open NonlinearDynamics.Random.RandomCocycles

#check birkhoffCauchyExceptionalSet
#check mem_birkhoffCauchyExceptionalSet_iff
#check measurableSet_birkhoffCauchyExceptionalSet
#check birkhoffCauchyExceptionalSet_ae_eq_of_ae_eq
#check nullMeasurableSet_birkhoffCauchyExceptionalSet_of_integrable
#check birkhoffCauchyExceptionalSet_subset_exceedance_union_compl
#check measureReal_birkhoffCauchyExceptionalSet_le
#check measure_birkhoffCauchyExceptionalSet_eq_zero_of_dense_good
#check cauchySeq_birkhoffAverage_of_not_mem_exceptional
#check ae_mem_birkhoffConvergenceSet_of_dense_good
~~~

Each <code>#check</code> asks the pinned elaborator for an exact declaration
type. The full-project command rendered below checks the authoritative RMT-26
module. It uses the repository's pinned dependencies and may require substantial
disk space and memory.
{{< /repo-check >}}

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
