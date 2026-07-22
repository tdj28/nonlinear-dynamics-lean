---
title: "Normalized space average"
slug: "normalized-space-average"
summary: "A normalized space average divides an integrable observable's measure integral by the finite nonzero total mass, making the result invariant under positive rescaling of the measure."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.ErgodicBirkhoffLimit"
og_image: "normalized-space-average-card.png"
og_image_alt: "Warm-paper glossary card showing a measure and its fivefold rescaling with different raw masses and integrals but the same normalized space average."
---

A **normalized space average** is an integral divided by the total mass of the
measure. For an integrable real observable \(f:\Omega\to\mathbb R\) and a
finite nonzero measure \(\mu\),

\[
\operatorname{Avg}_\mu(f)
{} =
\frac{1}{\mu(\Omega)}\int_\Omega f\,d\mu.
\]

The normalization makes an average insensitive to the arbitrary overall scale
of a finite measure. It also separates the general finite-measure theorem from
the probability special case. When \(\mu(\Omega)=1\), the normalized average
equals the ordinary integral and can be read as expectation. At any other
mass, the raw integral and the average are different quantities.

Mathlib already provides the canonical integral-average operation and notation:

~~~lean
⨍ ω, f ω ∂μ
~~~

Random-matrix-theory milestone 28 (RMT-28) uses that object to identify the
constant
{{< refterm "ergodicity" "ergodicity" >}} leaves behind. The complete theorem
and Lean declaration map are in
[Ergodic Birkhoff Limits and Normalized Space Averages]({{< relref "/knowledge-base/deep-dives/ergodic-birkhoff-limits-and-normalized-space-averages" >}}).

{{< reference-figure
  wide="true"
  src="normalized-space-average-scaling.svg"
  alt="A two-atom weighted measure has total mass three and raw integral six, while its fivefold rescaling has mass fifteen and raw integral thirty. Both divisions produce the same normalized average two. A probability normalization also has expectation two."
  caption="**Finding:** multiplying a finite nonzero measure by a positive scalar changes its total mass and raw integral by the same factor, so the normalized space average stays fixed. The probability branch rescales total mass to one and then the same number is the ordinary integral. This algebraic invariance does not by itself imply that any orbit time average converges."
>}}

## Mathlib semantics

For a normed additive commutative group valued function, Mathlib defines
<code>MeasureTheory.average μ f</code> by integrating against the normalized
measure

\[
\bigl(\mu(\Omega)\bigr)^{-1}\mu.
\]

The notation <code>⨍ x, f x ∂μ</code> names that definition. Its public
rewrite is

~~~lean
theorem average_eq (f : Ω → E) :
    ⨍ x, f x ∂μ = (μ.real univ)⁻¹ • ∫ x, f x ∂μ
~~~

For real-valued \(f\), scalar multiplication is ordinary multiplication:

\[
\operatorname{Avg}_\mu(f)
{} =
\bigl(\mu.\operatorname{real}(\Omega)\bigr)^{-1}
\int_\Omega f\,d\mu.
\]

The expression <code>μ.real univ</code> converts the extended nonnegative mass
to a real number. Under <code>IsFiniteMeasure μ</code>, it is the finite total
mass. An explicit premise <code>hμ : μ ≠ 0</code> makes it nonzero.

Mathlib also provides

~~~lean
theorem average_eq_integral [IsProbabilityMeasure μ] (f : Ω → E) :
    ⨍ x, f x ∂μ = ∫ x, f x ∂μ
~~~

This is the exact bridge from normalized finite-measure language to
probability expectation language.

## Worked weighted example

Let \(\Omega=\{p,q\}\). Give \(p\) mass \(2\), give \(q\) mass \(1\), and set

\[
f(p)=1,\qquad f(q)=4.
\]

Then

\[
\mu(\Omega)=2+1=3
\]

and

\[
\int_\Omega f\,d\mu
{} =
2\cdot1+1\cdot4
{} =
6.
\]

Therefore

\[
\operatorname{Avg}_\mu(f)=\frac63=2.
\]

Now scale the measure by \(5\). The atom masses become \(10\) and \(5\), the
total mass becomes \(15\), and the raw integral becomes \(30\). The normalized
average remains

\[
\operatorname{Avg}_{5\mu}(f)=\frac{30}{15}=2.
\]

If instead we normalize \(\mu\) to the probability measure
\(\widehat\mu=\mu/3\), then

\[
\int_\Omega f\,d\widehat\mu=2.
\]

The same numerical value now is an expectation because
\(\widehat\mu(\Omega)=1\).

## Why the denominator belongs in the theorem

Suppose an invariant conditional expectation is almost everywhere a constant
\(c\). Conditional expectation preserves the whole-space integral, so

\[
\mu(\Omega)c=\int_\Omega f\,d\mu.
\]

For finite nonzero mass, cancellation gives

\[
c=\operatorname{Avg}_\mu(f).
\]

If one omitted the denominator, scaling \(\mu\) would change the claimed
constant even though almost-everywhere sets and
{{< refterm "ergodicity" "ergodic rigidity" >}} are unchanged by positive
scalar rescaling. RMT-28's mass-two Dirac probe checks this issue directly:

\[
\mu=2\delta_x,\qquad
\int h\,d\mu=2h(x),\qquad
\operatorname{Avg}_\mu(h)=h(x).
\]

## Average, probability integral, and expectation

These phrases should not be interchanged silently.

| Quantity | General finite nonzero measure | Probability measure |
|---|---|---|
| Raw integral | \(\int f\,d\mu\) | \(\int f\,d\mu\) |
| Normalized average | \(\mu(\Omega)^{-1}\int f\,d\mu\) | \(\int f\,d\mu\) |
| Expectation language | Avoid unless a probability law has been specified | Appropriate for an integrable random variable |

An integral is mathematically defined for measures that are not probability
measures. The word **expectation** normally communicates that the measure is a
probability law. RMT-28 therefore reserves its ordinary-integral endpoint for
<code>[IsProbabilityMeasure μ]</code> and keeps the reciprocal mass explicit
in its general theorem.

## Totalized edge cases

Mathlib's operation is defined beyond the semantic finite nonzero integrable
setting.

- For the zero measure,
  <code>⨍ x, f x ∂(0 : Measure Ω) = 0</code>.
- For an infinite measure, the documented average value is \(0\).
- For a nonintegrable function, the totalized Bochner integral and hence the
  average are \(0\).
- The real inverse of zero is \(0\), so the explicit formula remains a total
  expression even at zero mass.

These conventions make rewriting and theorem statements total. They do not
justify calling the fallback value a physical or probabilistic mean. RMT-28's
semantic identification assumes <code>IsFiniteMeasure μ</code>,
<code>μ ≠ 0</code>, and <code>Integrable f μ</code>. The probability
specialization obtains finite and nonzero mass automatically.

## Relation to time averages

A space average is a static measure-theoretic quantity. Its definition alone
says nothing about an orbit. To conclude

\[
\frac1n\sum_{j=0}^{n-1}f(T^j\omega)
\longrightarrow
\operatorname{Avg}_\mu(f),
\]

one needs a pointwise ergodic theorem and the appropriate dynamical
hypotheses. RMT-27 first identifies the general limit as conditional
expectation onto the invariant sigma algebra. RMT-28 uses full ergodicity to
collapse that target and obtain the normalized space average almost
everywhere.

Without ergodicity, an identity map on two positive-mass atoms keeps the
starting value forever. Its time average is generally not the global
normalized space average.

## Boundaries and nonclaims

- A normalized average is not automatically an expectation.
- It is invariant under positive scalar rescaling of the measure, not under an
  arbitrary change in relative weights.
- Its existence as a totalized expression does not prove integrability.
- It does not imply Birkhoff convergence, ergodicity, or measure preservation.
- A Birkhoff theorem yields an almost-everywhere limit, not necessarily a
  pointwise limit for every state.
- It supplies no convergence rate, mixing statement, or independence.
- It is unrelated to normalized matrix trace unless a separate theorem
  identifies the observable and measure in question.
- It does not prove a subadditive cocycle limit, Lyapunov exponent, or
  Oseledets splitting.

## Related concepts

- {{< refterm "ergodicity" "Ergodicity" >}} is the rigidity condition that
  makes the invariant Birkhoff target almost everywhere constant.
- {{< refterm "conditional-expectation" "Conditional expectation" >}} is the
  target before that collapse.
- {{< refterm "invariant-sigma-algebra" "Invariant sigma algebra" >}} records
  the information retained by the nonergodic limit.
- {{< refterm "ergodic-probability-base" "Ergodic probability base" >}}
  separates mass-one normalization, measure preservation, invariant
  rigidity, and integrability.
- [Birkhoff Limits, Invariant Sigma Algebras, and Conditional Expectation]({{< relref "/knowledge-base/deep-dives/birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation" >}})
  proves the predecessor conditional-expectation target.
- [Probability Normalization and Ergodic Rigidity Before Kingman]({{< relref "/knowledge-base/deep-dives/probability-normalization-and-ergodic-rigidity-before-kingman" >}})
  explains why probability and ergodicity are independent assumptions.

## References

<a id="ref-normalized-average-mathlib"></a>**Mathlib contributors.**
[Integral averages](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Integral/Average.lean#L271-L345),
Mathlib 4.32.0 at pinned commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).
This source is authoritative for the canonical <code>⨍</code> notation,
totalized definition, explicit reciprocal-mass formula, zero-measure theorem,
and probability specialization.

<a id="ref-normalized-average-project"></a>**Nonlinear Dynamics in Lean contributors.**
[ErgodicBirkhoffLimit.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/ErgodicBirkhoffLimit.lean),
the checked source identifying invariant conditional expectation and Birkhoff
limits with the canonical and explicit normalized averages.
