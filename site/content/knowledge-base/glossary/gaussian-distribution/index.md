---
title: "Gaussian distribution"
slug: "gaussian-distribution"
summary: "A Gaussian distribution is the real probability law determined by a mean and a nonnegative variance, including a point mass when the variance is zero."
draft: true
pro_reviewed: false
toc: true
og_image: "gaussian-distribution-card.png"
og_image_alt: "A standard Gaussian law passes through a variance scaling step and a mean shift to produce an exact parameterized Gaussian law."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page must remain a draft until that review is complete.
{{< /panel >}}

A **Gaussian distribution**, also called a **normal distribution**, is a
probability law on the real line described by two parameters: a mean
\(m\in\mathbb R\), which locates its center, and a variance
\(v\ge 0\), which records its squared spread. This page writes the law as

\[
\gamma_{m,v}.
\]

The notation is deliberately neutral. Authors use \(N(m,v)\),
\(N(m,\sigma^2)\), and sometimes \(N(m,\sigma)\) for closely related
parameter conventions. A formula or software interface must say whether its
second argument is a variance \(v\) or a standard deviation
\(\sigma=\sqrt{v}\).

## The exact probability law

When \(v>0\), the Gaussian law has density

\[
f_{m,v}(x)
=\frac{1}{\sqrt{2\pi v}}
  \exp\!\left(-\frac{(x-m)^2}{2v}\right),
\qquad x\in\mathbb R.
\]

Here \(x\) is a possible real value, \(m\) is the mean, and \(v\) is
the variance. The density is nonnegative and integrates to one. It describes
probability per unit length, not the probability of the single point \(x\).
For a continuous positive-variance Gaussian law, every singleton has
probability zero even though the density at that point may be positive.

The case \(v=0\) is not obtained by substituting zero into the displayed
density. Its exact law is the Dirac point mass at the mean:

\[
\gamma_{m,0}=\delta_m.
\]

Thus zero variance is part of the family, but it is a degenerate Gaussian law:
the random variable equals \(m\) almost surely. This boundary case matters in
formal proofs because scaling any random variable by zero must land there.

## Build every real Gaussian from the standard one

Let \(Z\) have the standard Gaussian law \(\gamma_{0,1}\). For
\(v\ge0\), define

\[
X=m+\sqrt{v}\,Z.
\]

Then \(X\) has law \(\gamma_{m,v}\). Multiplication by
\(\sqrt{v}\) changes variance from \(1\) to \(v\), and addition of
\(m\) moves the mean without changing variance.

{{< reference-figure
  src="gaussian-parameter-map.svg"
  alt="A standard Gaussian law is scaled by the square root of the requested variance and then shifted by the requested mean."
  caption="**Finding:** the two Gaussian parameters have different jobs. Scaling controls variance, while translation controls mean. The plate is a law-level construction, not a claim that one observed sample determines either parameter. The zero-scale path ends at a point mass."
>}}

## A checkable example

Suppose \(Z\sim\gamma_{0,1}\) and set

\[
X=2+3Z.
\]

The expectation and variance follow from the two transformation rules:

\[
\mathbb E[X]
=2+3\mathbb E[Z]
=2,
\]

and

\[
\operatorname{Var}(X)
=3^2\operatorname{Var}(Z)
=9.
\]

Therefore \(X\sim\gamma_{2,9}\). The standard deviation is \(3\),
not \(9\). This is a useful convention check: the coefficient multiplying the
standard Gaussian is the standard deviation, while the second parameter used
on this page is its square.

At the boundary, \(Y=2+0Z\) is equal to \(2\) for every outcome and has
law \(\gamma_{2,0}=\delta_2\).

## A sample, a law, and a Gaussian property are different layers

If \(X:\Omega\to\mathbb R\) is a random variable on a probability
space \((\Omega,\mathcal F,\mathbb P)\), the exact statement

\[
\mathcal L_{\mathbb P}(X)=\gamma_{m,v}
\]

identifies its complete {{< refterm "probability-law" "probability law" >}}.
It is stronger than saying that a finite list of observed values looks
bell-shaped. Data analysis can estimate or test a Gaussian model, but no finite
sample is itself a proof that the underlying law is Gaussian.

An exact parameterized law is also more informative than the qualitative
statement "the law is Gaussian." The latter says that some Gaussian law is
present. The former records which mean and variance it has. Both viewpoints
are useful, but later normalization arguments need the parameters.

## The pinned Lean representation

Mathlib 4.32.0 represents the law as
<code>gaussianReal m v</code>, where <code>m : ℝ</code> and
<code>v : ℝ≥0</code>. The type <code>ℝ≥0</code>, written
<code>NNReal</code> in generated documentation, prevents a negative variance
from being supplied.

The project records the exact law with:

```lean
def HasRealGaussianLaw (X : Ω → ℝ) (m : ℝ) (v : ℝ≥0)
    (P : Measure Ω) : Prop :=
  HasLaw X (gaussianReal m v) P
```

The underlying Mathlib predicate <code>HasLaw</code> stores two facts:
<code>X</code> is almost-everywhere measurable under <code>P</code>, and the
pushforward <code>P.map X</code> equals the stated measure. It does not supply
ordinary <code>Measurable X</code>. The project therefore exposes
<code>HasRealGaussianLaw.aemeasurable</code> without silently strengthening it.

The checked project layer also exposes these exact consequences:

- <code>HasRealGaussianLaw.mean_eq</code> and
  <code>HasRealGaussianLaw.variance_eq</code> recover \(m\) and \(v\);
- <code>HasRealGaussianLaw.memLp</code> gives membership in every finite
  \(L^p\) space, and <code>.integrable</code> gives integrability;
- <code>.ae_eq_const_of_variance_zero</code> handles the degenerate law;
- <code>.const_mul</code> records the variance factor \(c^2\), including
  \(c=0\); and
- <code>.add_of_indep</code> adds means and variances when the two variables
  are independent.

Mathlib also has <code>HasGaussianLaw X P</code>, a qualitative predicate for
Gaussianity in real Banach spaces. The project's
<code>HasRealGaussianLaw.hasGaussianLaw</code> deliberately forgets explicit
parameters only after establishing the exact real law.

## Edge cases and nonclaims

- A Gaussian density formula applies directly only for \(v>0\). At
  \(v=0\), the law is a point mass.
- Equal means and variances do not determine an arbitrary probability law.
  They determine a law inside the Gaussian family.
- Gaussian marginals do not by themselves determine a joint law. Dependence
  between coordinates must be specified separately.
- A Gaussian law has finite moments of every finite order, but measurability
  alone does not imply Gaussianity or integrability.
- This definition is real-valued. A complex Gaussian variable requires a
  declared joint law for its real and imaginary parts and a declared
  {{< refterm "normalization-convention" "normalization convention" >}}.
- This page does not define a matrix ensemble or a Gaussian unitary ensemble.

## Where to continue

Read {{< refterm "variance" "variance" >}} for the exact squared-spread
calculation and {{< refterm "independence" "independence" >}} before combining
several Gaussian coordinates. The
[Gaussian Laws, Independence, and Normalization]({{< relref "/knowledge-base/deep-dives/gaussian-laws-independence-and-normalization" >}})
Deep Dive assembles those concepts into finite product laws. The
{{< refterm "probability-law" "probability law" >}} and
{{< refterm "pushforward-measure" "pushforward measure" >}} entries explain
the measure-theoretic layer beneath the notation.

## References

**National Institute of Standards and Technology.**
[Normal Distribution](https://www.itl.nist.gov/div898/handbook/eda/section3/eda3661.htm),
Engineering Statistics Handbook. This official reference states the
positive-variance density and distinguishes location from scale.

**Mathlib contributors.**
[Gaussian distributions over the reals](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
Mathlib 4 documentation. This is the official API reference for
<code>gaussianReal</code>, its zero-variance Dirac branch, means, variances,
finite moments, scaling, and independent sums.

**Mathlib contributors.**
[Gaussian random variables](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/HasGaussianLaw/Basic.html),
Mathlib 4 documentation. This documents the qualitative
<code>HasGaussianLaw</code> interface that the exact project predicate can
forget into.

The project is pinned to Mathlib commit
[`81a5d257`](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
so the declaration names above can be audited against the exact dependency.
