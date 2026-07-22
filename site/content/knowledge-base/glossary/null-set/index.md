---
title: "Null set"
slug: "null-set"
summary: "A null set is a set that carries exactly zero mass under a specified measure, even when the set is not empty."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman"
og_image: "null-set-card.png"
og_image_alt: "Three exact interval covers shrink around the point one half, illustrating why its uniform measure is zero."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean examples, source interpretation, figure, and accessibility
remains pending. It is public so readers can follow and improve the teaching
layer while that review is open.
{{< /panel >}}

A **null set** is a set to which a chosen measure assigns exactly zero mass.
The measure must be named: the same set can be null for one measure and carry
all the mass of another.

Null does not mean empty, logically impossible, or merely very unlikely. It
means one precise equation,

\[
\mu(N)=0,
\]

where \(N\) is the set and \(\mu\) is the measure.

## Start with one point in the unit interval

Let the outcome space be \(\Omega=[0,1]\), equipped with the uniform
probability measure \(\mu\). For every interval \((a,b)\) inside \([0,1]\),
its probability is its length \(b-a\).

Consider the singleton

\[
N=\left\{\frac12\right\}.
\]

To find its measure, trap it inside an interval whose length can be made as
small as we like. For every integer \(n\ge 2\), set

\[
I_n=
\left(
\frac12-\frac{1}{2n},
\frac12+\frac{1}{2n}
\right).
\]

The point \(1/2\) lies in every \(I_n\), and the interval has length

\[
\left(\frac12+\frac{1}{2n}\right)
-\left(\frac12-\frac{1}{2n}\right)
=\frac1n.
\]

Because \(N\subseteq I_n\), monotonicity of a measure gives

\[
0\le \mu(N)\le \mu(I_n)=\frac1n
\qquad\text{for every }n\ge2.
\]

The only nonnegative number below every \(1/n\) is zero. Therefore

\[
\mu\left(\left\{\frac12\right\}\right)=0.
\]

{{< reference-figure
  src="shrinking-covers.svg"
  alt="On one fixed zero-to-one scale, the point one half remains inside three open intervals whose exact lengths shrink from one half to one fifth to one twenty-fifth."
  caption="**Finding:** the singleton \(\{1/2\}\) stays inside every displayed cover, while the cover lengths are exactly \(1/2\), \(1/5\), and \(1/25\) on the same scale. Monotonicity therefore gives successively tighter upper bounds for the singleton's uniform probability. Continuing with length \(1/n\) forces that probability to zero. The three rows illustrate the general shrinking-cover proof; they are not sampled data, and three rows alone would not establish the limit."
>}}

The shrinking intervals are not the null set. They are measurable covers with
positive but vanishing mass. Their job is to squeeze the unknown mass of the
singleton between zero and numbers that approach zero.

## A finite die is the nearby nonexample

Now let \(\Omega=\{1,2,3,4,5,6\}\) be a fair six-sided die, and use its
uniform probability measure \(\mathbb P\). The singleton \(\{6\}\) has

\[
\mathbb P(\{6\})=\frac16,
\]

so it is not null. In fact, every nonempty event for this die contains at
least one face and therefore has probability at least \(1/6\). The empty set
is the die's only null set.

The interval singleton and the die singleton each contain exactly one point.
Their cardinalities agree, but their measures do not. Counting points is not
how a general measure decides whether a set is null.

## The exact definition

Let \((\Omega,\mathcal F,\mu)\) be a measure space. Here \(\Omega\) is the
underlying set, \(\mathcal F\) is its collection of measurable sets, and
\(\mu\) assigns mass to those sets. A measurable set \(N\in\mathcal F\) is a
**\(\mu\)-null set** when

\[
\mu(N)=0.
\]

Many authors also call any subset of such a set \(\mu\)-null. This broader
usage is harmless for measure calculations because if \(A\subseteq N\) and
\(\mu(N)=0\), then monotonicity forces \(\mu(A)=0\). Whether every such
subset is itself measurable is a separate question about whether the measure
space has been completed.

The subscript matters. With \(N=\{1/2\}\), let \(\lambda\) denote uniform
measure on \([0,1]\), and let \(\delta_{1/2}\) denote the Dirac probability
measure that puts all mass at \(1/2\). Then

\[
\lambda(N)=0,
\qquad
\delta_{1/2}(N)=1.
\]

The set did not change. The measure did.

## Two closure rules do most of the work

### Subsets inherit zero mass

If \(A\subseteq N\) and \(N\) is \(\mu\)-null, then

\[
0\le\mu(A)\le\mu(N)=0,
\]

so \(\mu(A)=0\). This is the rule used in the shrinking-cover example and in
many formal proofs: first place a complicated exceptional set inside a null
cover, then transfer zero mass to the smaller set.

### Countable unions stay null

If \(N_0,N_1,N_2,\ldots\) are all \(\mu\)-null, countable subadditivity gives

\[
\mu\!\left(\bigcup_{k=0}^{\infty}N_k\right)
\le
\sum_{k=0}^{\infty}\mu(N_k)
=0.
\]

Therefore their union is null. This explains why a countable set such as
\(\mathbb Q\cap[0,1]\) has uniform measure zero: enumerate its points and
take a countable union of null singletons.

Countability is essential. The interval is the union of all of its
singletons,

\[
[0,1]=\bigcup_{x\in[0,1]}\{x\},
\]

but this is an uncountable union, and the interval has uniform measure one.
The countable-union theorem cannot be applied to that display.

## Measure zero is not logical impossibility

The mathematical outcome \(x=1/2\) belongs to \([0,1]\). Nothing in the set
model forbids it, yet the singleton event has probability zero under the
uniform law. By contrast, the impossible event is the empty set: it contains
no outcome at all.

This distinction becomes especially important when moving between a model and
physical measurement. An idealized continuous probability model can assign
zero probability to every exact value even though every realized value is one
of those exact values. Finite-resolution instruments report intervals, and
those intervals can have positive probability.

| Statement | What it says | Uniform \([0,1]\) example |
|---|---|---|
| \(N=\varnothing\) | No outcome belongs to the event | The event is impossible |
| \(\mu(N)=0\) | The chosen measure assigns zero mass | \(N=\{1/2\}\) is nonempty and null |
| \(0\lt\mu(N)\ll1\) | The event has small positive mass | A short interval around \(1/2\) |

There is no universal numerical threshold at which “small” becomes “null.”
Null means exactly zero.

## From null sets to almost-everywhere statements

A property \(P(\omega)\) holds
{{< refterm "almost-everywhere" "almost everywhere" >}} with respect to
\(\mu\) precisely when its failure set is null:

\[
\mu\{\omega\in\Omega:\neg P(\omega)\}=0.
\]

For the interval example, the statement \(x\ne1/2\) fails only on the null
set \(\{1/2\}\), so it holds almost everywhere. For the fair die, “the roll
is not six” fails on a set of probability \(1/6\), so it does not hold almost
surely.

Countable unions let us combine countably many almost-everywhere statements.
If statement \(k\) fails only on \(N_k\), then all statements hold
simultaneously outside \(\bigcup_k N_k\), which is still null. The analogous
claim for an uncountable family needs additional structure and is not a free
consequence of the null-set rules.

## In Lean: zero mass is the definition

Mathlib does not require a special bundled “null set” object for the basic
calculation. It writes the defining equality directly.

{{< lean-bridge
  human="The set N carries zero mass under the measure mu."
  math="\(\mu(N)=0\)."
  lean="μ N = 0"
>}}

- <code>μ</code> is a value of type <code>Measure Ω</code>, a measure on the
  outcome type <code>Ω</code>.
- <code>N</code> is a value of type <code>Set Ω</code>.
- Function application is written by spacing, so <code>μ N</code> means “the
  measure of <code>N</code>.”
- <code>= 0</code> says that value is exactly zero. For an ordinary measure,
  the value lives in the extended nonnegative reals, so it cannot be negative.
{{< /lean-bridge >}}

Two Mathlib lemmas encode the closure rules from the previous section.
<code>measure_mono_null</code> transfers zero mass from a set to any subset,
and <code>measure_iUnion_null</code> combines a countable family of null sets.
A human can type this worksheet:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.SubadditiveKingman

open MeasureTheory Set

#check measure_mono_null
#check measure_iUnion_null

example {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω)
    {A N : Set Ω} (hAN : A ⊆ N) (hN : μ N = 0) :
    μ A = 0 :=
  measure_mono_null hAN hN

example {Ω ι : Type*} [MeasurableSpace Ω] [Countable ι]
    (μ : Measure Ω) (N : ι → Set Ω)
    (hN : ∀ i, μ (N i) = 0) :
    μ (⋃ i, N i) = 0 :=
  measure_iUnion_null hN

#check NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.measure_centeredRationalLowerDeviationExhaustionSet_eq_zero

#check NonlinearDynamics.Random.RandomCocycles.IsIntegrableSubadditiveProcessCandidate.measure_centeredLowerLiminfDeviationSet_eq_zero
~~~

The first two <code>#check</code> commands ask Lean to report Mathlib's theorem
types. Each <code>example</code> then supplies all arguments explicitly and asks
Lean to verify the corresponding proof term. <code>[Countable ι]</code> is the
important gate on the second example; without it, the union theorem would be
false.

The final two commands point to checked project declarations. In
<code>SubadditiveKingman.lean</code>, the rational lower-deviation exhaustion is
a countable union. Its proof uses <code>measure_iUnion_null</code> to show the
union is null. The next theorem places a real lower-liminf deviation set inside
that exhaustion and uses <code>measure_mono_null</code> to transfer zero mass to
the subset. This is the same two-step architecture as the paper argument:
build a null cover, then descend to the event of interest.

{{< repo-check >}}
The authoritative checked source is
[<code>formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveKingman.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveKingman.lean).
The worksheet's import and both fully qualified declaration names are copyable.
The guarded command below checks the complete project module containing the
two project theorems.
{{< /repo-check >}}

## Boundaries worth keeping visible

| Tempting shortcut | What is actually true |
|---|---|
| “A singleton is always null.” | False. A Dirac measure gives its supporting singleton mass one, and a fair die gives each face mass \(1/6\). |
| “A countable union of null sets is null.” | True. Countability is part of the theorem. |
| “Any union of null sets is null.” | False. \([0,1]\) is an uncountable union of null singletons under uniform measure. |
| “A subset of a null set is null.” | True as a zero-mass statement. Its measurability may use completion of the measure space. |
| “Probability zero means the outcome cannot occur.” | False in a continuous model. It means the event carries zero probability mass. |
| “Null is a property of the set alone.” | False. It is always relative to a measure. |

{{< panel "warning" >}}
**What this definition does not prove.** Knowing \(\mu(N)=0\) does not say
that \(N\) is empty, open, closed, finite, countable, independently generated,
or negligible for a different measure. It also does not automatically make
every subset of \(N\) measurable in an uncompleted measure space. Those are
separate claims.
{{< /panel >}}

## Where to continue

The {{< refterm "measurable-space" "measurable space" >}} entry explains which
sets are available as measurable events. The
{{< refterm "almost-everywhere" "almost-everywhere" >}} entry turns a null
failure set into a quantified statement. The
{{< refterm "probability-law" "probability distribution (law)" >}} entry
shows how a random object moves probability onto its value space, and the
{{< refterm "pushforward-measure" "pushforward measure" >}} entry develops
that construction directly.

For the project-scale use of countable null covers, continue to
[Rational slack, lower-deviation events, and ergodic null selection]({{< relref "/knowledge-base/deep-dives/rational-slack-lower-deviation-events-and-ergodic-null-selection" >}}).
That Deep Dive explains why rational thresholds supply a countable family and
how the resulting null event enters the log-positive Kingman argument.

## References

**Mathlib contributors.**
[Outer-measure foundations](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/OuterMeasure/Basic.html),
Mathlib 4 documentation. This is the official implementation reference for
<code>measure_mono_null</code>, <code>measure_iUnion_null_iff</code>, and the
<code>measure_iUnion_null</code> alias used by the project.

**Olav Kallenberg.**
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1),
third edition, Springer, 2021. This develops null events, almost-everywhere
reasoning, and probability measures in a standard measure-theoretic setting.

**Project source.**
[SubadditiveKingman.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveKingman.lean)
contains the checked countable-union and subset-null proof architecture
described in the Lean section.
