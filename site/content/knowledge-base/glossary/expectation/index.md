---
title: "Expectation"
slug: "expectation"
summary: "Expectation is the probability-weighted average of a random quantity across its whole law, not the value of one realization."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase"
og_image: "expectation-card.png"
og_image_alt: "Three exact payoffs are weighted by probabilities to give expectation one, a value that no single outcome attains."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working note. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is public so readers can follow the work while that review is
still open.
{{< /panel >}}

The **expectation** of a random quantity is its probability-weighted average
over the whole experiment. It combines every possible value with the
probability of obtaining that value. It is not the result of one trial, and it
need not be a value that any trial can produce.

Expectation is an integral with respect to a
{{< refterm "probability-measure" "probability measure" >}}. The probability
normalization matters: integrating the same quantity against a general
{{< refterm "measure" "measure" >}} of total mass \(2\) doubles the raw
integral.

## Start with three possible payoffs

Let the outcome space be

\[
\Omega=\{L,M,H\}.
\]

Define a real-valued payoff \(X\) and probability measure \(\mathbb P\) by

| Outcome \(\omega\) | Payoff \(X(\omega)\) | Probability \(\mathbb P(\{\omega\})\) |
|---|---:|---:|
| \(L\) | \(-1\) | \(1/2\) |
| \(M\) | \(2\) | \(1/3\) |
| \(H\) | \(5\) | \(1/6\) |

The three probabilities add to one:

\[
\frac12+\frac13+\frac16
=\frac36+\frac26+\frac16
=1.
\]

Suppose one run produces \(\omega=M\). The realized payoff is then

\[
X(M)=2.
\]

That single observation does not erase the other possibilities. The
{{< refterm "probability-law" "law" >}} of \(X\) still assigns mass \(1/2\)
to payoff \(-1\), mass \(1/3\) to payoff \(2\), and mass \(1/6\) to payoff
\(5\). A realization is one selected value. A law is the complete weighted
list of possible values.

## Compute the weighted average exactly

On a finite probability space, expectation is the sum

\[
\mathbb E_{\mathbb P}[X]
=\sum_{\omega\in\Omega}X(\omega)\mathbb P(\{\omega\}).
\]

For this payoff,

\[
\begin{aligned}
\mathbb E_{\mathbb P}[X]
&=\frac12(-1)+\frac13(2)+\frac16(5)\\
&=-\frac36+\frac46+\frac56\\
&=\frac66\\
&=1.
\end{aligned}
\]

The negative payoff contributes \(-3/6\), while the two positive payoffs
contribute \(4/6\) and \(5/6\). Expectation combines contributions; it does
not choose the most likely payoff.

There is no outcome with payoff \(1\):

\[
X(\Omega)=\{-1,2,5\},
\qquad
1\notin X(\Omega).
\]

Thus an expectation need not be attainable in a single realization. It is the
center of the probability-weighted values, not an additional possible value.

{{< reference-figure
  src="three-outcome-expectation.svg"
  alt="A three-outcome experiment has payoffs minus one, two, and five with probabilities one half, one third, and one sixth. One realized draw selects payoff two, but all three weighted contributions combine to expectation one. A lower comparison doubles the measure to total mass two and raw integral two, then divides by total mass to recover normalized expectation one. A final strip checks linearity for Y equal to two X plus three."
  caption="**Finding:** one realization \(M\) produces \(X(M)=2\), while the law retains all three branches. Their exact weighted contributions are \((1/2)(-1)=-3/6\), \((1/3)2=4/6\), and \((1/6)5=5/6\), so \(\mathbb E_{\mathbb P}[X]=1\), even though \(1\) is not an attainable payoff. Replacing \(\mathbb P\) by the mass-two measure \(\nu=2\mathbb P\) doubles the raw integral to \(2\). Normalizing by \(\nu(\Omega)=2\) restores the probability average \(1\). The patterned cards and labels identify the three branches without relying on color."
>}}

## From a finite sum to an integral

For an integrable real random variable

\[
X:\Omega\longrightarrow\mathbb R
\]

on a probability space \((\Omega,\mathcal F,\mathbb P)\), expectation is

\[
\mathbb E_{\mathbb P}[X]
=\int_\Omega X(\omega)\,d\mathbb P(\omega).
\]

The sigma algebra \(\mathcal F\) specifies the measurable
{{< refterm "event" "events" >}}, and \(\mathbb P\) assigns them probability.
The function \(X\) must be measurable so that value-space questions pull back
to events. Integrability ensures that the positive and negative contributions
combine into a finite real number.

In the three-outcome example, the integral is exactly the weighted sum already
computed. The integral notation is not a different average. It is the form
that continues to work on continuous and mixed outcome spaces where listing
all outcomes is impossible.

Expectation can also be computed from the law
\(\mathcal L_{\mathbb P}(X)=X_*\mathbb P\):

\[
\mathbb E_{\mathbb P}[X]
=\int_{\mathbb R}x\,d\mathcal L_{\mathbb P}(X)(x).
\]

The first integral averages over source outcomes. The second averages the
identity function over possible payoff values. They agree because the law is
the pushforward of \(\mathbb P\) through \(X\).

## Raw mass is not probability expectation

Now define a new measure

\[
\nu=2\mathbb P.
\]

Its atomic masses are \(1\), \(2/3\), and \(1/3\), and its total mass is

\[
\nu(\Omega)=2.
\]

The raw integral scales with the measure:

\[
\int_\Omega X\,d\nu
=2\int_\Omega X\,d\mathbb P
=2.
\]

This number is not the probability expectation of \(X\) under \(\nu\), because
\(\nu\) is not a probability measure. If the intent is to turn a positive
finite measure into a probability measure, normalization is an explicit
operation:

\[
\widehat\nu=\frac{\nu}{\nu(\Omega)}
=\frac{\nu}{2}
=\mathbb P.
\]

The normalized average is then

\[
\frac{1}{\nu(\Omega)}\int_\Omega X\,d\nu
=\frac12\cdot2
=1.
\]

Under a probability measure, the denominator is already one, so expectation
is the raw integral. Under a mass-two measure, saying "expectation" without
either normalizing or declaring a different convention hides a factor of two.

## Linearity: transform first or average first

Expectation is linear. For integrable real random variables \(X\) and \(Z\)
and real constants \(a\) and \(b\),

\[
\mathbb E[aX+bZ]
=a\,\mathbb E[X]+b\,\mathbb E[Z].
\]

A constant function has expectation equal to that constant on a probability
space. Therefore, if

\[
Y=2X+3,
\]

then

\[
\mathbb E[Y]=2\mathbb E[X]+3=2(1)+3=5.
\]

The direct three-outcome calculation agrees. The transformed payoffs are
\(1\), \(7\), and \(13\), so

\[
\frac12(1)+\frac13(7)+\frac16(13)
=\frac36+\frac{14}{6}+\frac{13}{6}
=\frac{30}{6}
=5.
\]

Linearity does not say \(\mathbb E[XZ]=\mathbb E[X]\mathbb E[Z]\). That
product identity requires additional assumptions such as independence and
integrability of the product.

## In Lean: type the integral that expectation names

{{< lean-bridge
  human="Average the real quantity X over all outcomes using the probability measure mu."
  math="\(\mathbb E_\mu[X]=\int_\Omega X(\omega)\,d\mu(\omega).\)"
  lean="∫ ω, X ω ∂μ"
>}}

- <code>∫</code> begins Lean's integral notation.
- <code>ω</code> is the bound outcome variable. Its scope extends through the
  integrand that follows the comma.
- <code>X ω</code> is function application, read as the paper expression
  \(X(\omega)\).
- <code>∂μ</code> names the measure used for integration. It is the source
  notation corresponding to \(d\mu(\omega)\).
- The literal line a human places in a Lean file is
  <code>∫ ω, X ω ∂μ</code>. The complete worksheet below supplies the import,
  types, and hypotheses that give every symbol meaning.
- The notation itself only forms a raw integral. Calling it an expectation is
  semantically justified when <code>μ</code> is a probability measure; a
  finite real interpretation also requires the appropriate integrability
  evidence.
{{< /lean-bridge >}}

The project makes those two gates visible in its finite-horizon cocycle API:

{{< lean-bridge
  human="At horizon k, take the expected log-positive norm of the cocycle product; hC supplies the integrability proof and the surrounding typeclass supplies probability normalization."
  math="\(\mathbb E_\mu[P_k]=\int_\Omega P_k(\omega)\,d\mu(\omega),\quad P_k(\omega)=\log^+\lVert\Phi_k(\omega)\rVert.\)"
  lean="C.finiteHorizonLogPlusExpectation hC k"
>}}

- <code>C</code> is a discrete matrix cocycle over the source measure
  <code>μ</code>.
- <code>k : ℕ</code> is the finite time horizon.
- <code>C.logPlusNormObservable k ω</code> is the project function
  \(P_k(\omega)=\log^+\lVert\Phi_k(\omega)\rVert\).
- <code>hC : C.HasIntegrableGeneratorLogPlus</code> proves the one-step
  hypothesis from which the project derives integrability at every finite
  horizon.
- <code>[IsProbabilityMeasure μ]</code> is present in the complete definition
  even though it is not printed at the call site. Square brackets ask Lean to
  synthesize the visible total-mass-one certificate from context.
- <code>finiteHorizonLogPlusExpectation</code> is a semantic name for the same
  real integral already called <code>integratedLogPlusNorm</code>. It performs
  no hidden division.
{{< /lean-bridge >}}

The following definition and theorem are exact excerpts from the checked
project source:

~~~lean
def finiteHorizonLogPlusExpectation [IsProbabilityMeasure μ]
    (C : DiscreteMatrixCocycle (ι := ι) μ)
    (_hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) : ℝ :=
  ∫ ω, C.logPlusNormObservable k ω ∂μ

@[simp] theorem finiteHorizonLogPlusExpectation_eq_integratedLogPlusNorm
    [IsProbabilityMeasure μ]
    {C : DiscreteMatrixCocycle (ι := ι) μ}
    (hC : C.HasIntegrableGeneratorLogPlus) (k : ℕ) :
    C.finiteHorizonLogPlusExpectation hC k = C.integratedLogPlusNorm k := by
  rfl
~~~

The underscore in <code>_hC</code> records that the proof is deliberately part
of the interface even though the definition body does not compute with it.
The equality proof is <code>rfl</code>: after unfolding the two project names,
both sides are literally the same integral. The theorem is not a
normalization formula. The probability typeclass has already required total
mass one before the expectation name can be formed.

Here is a complete worksheet a human can type into a scratch <code>.lean</code>
file on a provisioned Linux build host:

~~~lean
import NonlinearDynamics.Random.RandomCocycles.ProbabilityErgodicBase

open MeasureTheory

#check integral_add
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.finiteHorizonLogPlusExpectation
#check NonlinearDynamics.Random.RandomCocycles.DiscreteMatrixCocycle.finiteHorizonLogPlusExpectation_eq_integratedLogPlusNorm

variable {Ω : Type*} [MeasurableSpace Ω]
variable (μ : Measure Ω) (X Y : Ω → ℝ)

#check ∫ ω, X ω ∂μ

example (hX : Integrable X μ) (hY : Integrable Y μ) :
    (∫ ω, X ω + Y ω ∂μ) =
      (∫ ω, X ω ∂μ) + (∫ ω, Y ω ∂μ) := by
  exact integral_add hX hY
~~~

The first <code>#check</code> asks for Mathlib's integral-linearity theorem.
The next two inspect the project's guarded expectation definition and its
equality with the raw integrated observable. The local variables make the
line <code>#check ∫ ω, X ω ∂μ</code> meaningful. Finally, the
<code>example</code> asks Lean to verify additivity from explicit
integrability proofs. It is the typed counterpart of
\(\mathbb E[X+Y]=\mathbb E[X]+\mathbb E[Y]\) when \(\mu\) is a probability
measure, and a valid raw-integral identity for general \(\mu\).

{{< repo-check >}}
The authoritative source is
[<code>formalization/NonlinearDynamics/Random/RandomCocycles/ProbabilityErgodicBase.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/ProbabilityErgodicBase.lean).
That module imports the finite-horizon log-positive observable and its
integrability theory, requires <code>[IsProbabilityMeasure μ]</code> before
using the expectation name, and proves by <code>rfl</code> that the named
expectation equals <code>integratedLogPlusNorm</code>. The worksheet above uses
the same project import and exact declaration names. The repository's guarded
build command checks the complete module on the approved Linux builder.
{{< /repo-check >}}

## Distinctions and failure modes

| Tempting shortcut | What is wrong | Correct repair |
|---|---|---|
| "The expectation is what happened" | One realization is \(X(\omega)\); expectation averages the whole law | Keep the observed value and distribution-level average separate |
| "The expectation must be a possible value" | Weighted centers can lie between or outside discrete listed values | Check the range \(X(\Omega)\) separately |
| "The most likely value is the expectation" | Mode and expectation answer different questions | Compute probability times value for every branch |
| "Any raw integral is an expectation" | A measure may have total mass other than one | Require a probability measure or explicitly normalize a positive finite measure |
| "The law and one sample contain the same information" | One sample selects one value; the law records weights for all values | Use repeated data to estimate the law, not to redefine it after one draw |
| "Finite values guarantee finite expectation" | On an infinite outcome space, tails can make a real random variable nonintegrable | Prove integrability or state an extended nonnegative expectation |
| "Changing a function on a null set changes its expectation" | Integrals identify functions that agree almost everywhere | Use the {{< refterm "null-set" "null set" >}} and almost-everywhere interface explicitly |
| "Linearity makes products factor" | \(\mathbb E[XZ]=\mathbb E[X]\mathbb E[Z]\) is not linearity | Add independence and product-integrability hypotheses when appropriate |

{{< panel "warning" >}}
**What expectation alone does not tell you.** The mean does not determine the
law, variance, tails, median, mode, or a typical realization. Very different
distributions can have the same expectation. An existence claim also needs
care: for a signed real quantity, uncontrolled positive and negative tails do
not automatically define a finite expectation.
{{< /panel >}}

## Where to continue

Read {{< refterm "event" "event" >}} for the measurable yes-or-no questions
underlying the outcome space. Read {{< refterm "measure" "measure" >}} and
{{< refterm "probability-measure" "probability measure" >}} for the difference
between raw mass and normalized mass. Read
{{< refterm "probability-law" "probability law" >}} for the value-space
distribution that also determines expectation, and
{{< refterm "null-set" "null set" >}} for changes that do not affect an
integral.

The chapter
[Probability Normalization and Ergodic Rigidity Before Kingman]({{< relref "/knowledge-base/deep-dives/probability-normalization-and-ergodic-rigidity-before-kingman" >}})
places the project's finite-horizon expectation beside its integrability and
ergodicity assumptions.

## References

**Mathlib contributors.**
[Bochner integral basics](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Integral/Bochner/Basic.html),
Mathlib 4 documentation. This official implementation reference contains the
real and vector-valued integral API, including <code>integral_add</code> and
the integral of a constant.

**Mathlib contributors.**
[Probability measure typeclass](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Typeclasses/Probability.html),
Mathlib 4 documentation. This official source records the total-mass-one
assumption used by the project's expectation interface.

**Olav Kallenberg.**
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1),
third edition, Springer, 2021. This is a standard reference for expectation,
integration, laws of random elements, and almost-everywhere equivalence.
