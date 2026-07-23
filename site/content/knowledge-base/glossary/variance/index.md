---
title: "Variance"
slug: "variance"
summary: "Variance is the expected squared distance from a random variable to its mean."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.GaussianPrimitives"
og_image: "variance-card.png"
og_image_alt: "Two equally likely values lie two units from their mean, so both squared deviations are four and the variance is four."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

**Variance** measures squared spread around a mean. If a real random variable
\(X\) is defined under a probability measure \(\mathbb P\), has finite
second moment, and has mean

\[
m=\mathbb E_{\mathbb P}[X],
\]

then its variance is

\[
\operatorname{Var}_{\mathbb P}(X)
=\mathbb E_{\mathbb P}\!\left[(X-m)^2\right].
\]

The subtraction measures a deviation from the center. Squaring makes positive
and negative deviations contribute equally and weights large deviations more
heavily. The expectation averages those squared deviations according to the
{{< refterm "probability-law" "probability law" >}} of \(X\).

## Work one example all the way through

Let \(X\) take the values \(-1\) and \(3\), each with probability
\(1/2\). Its mean is

\[
m
=\frac{1}{2}(-1)+\frac{1}{2}(3)
=1.
\]

Both values lie two units from the mean:

\[
-1-1=-2,
\qquad
3-1=2.
\]

Their squared deviations are both \(4\), so

\[
\operatorname{Var}(X)
=\frac{1}{2}(-2)^2+\frac{1}{2}(2)^2
=4.
\]

{{< reference-figure
  src="variance-squared-distance.svg"
  alt="The values minus one and three have equal probability, share mean one, and each contributes squared deviation four to variance four."
  caption="**Finding:** variance averages squared distance from the mean, not raw distance and not distance from zero. The values are an exact toy law, not observations from an experiment."
>}}

The standard deviation is the square root of variance, so this example has
standard deviation \(2\). Variance has squared units. If \(X\) is measured
in meters, then \(\operatorname{Var}(X)\) is measured in square meters,
while its standard deviation returns to meters.

## The rules that make variance useful

For a square-integrable real random variable and real constant \(c\):

\[
\operatorname{Var}(X+c)=\operatorname{Var}(X),
\]

because translation moves both \(X\) and its mean by the same amount. Scaling
has a different effect:

\[
\operatorname{Var}(cX)=c^2\operatorname{Var}(X).
\]

This square is why a Gaussian law parameterized by variance \(v\) is built
from a standard Gaussian by multiplying by \(\sqrt{v}\), not by \(v\).

For two square-integrable variables \(X\) and \(Y\),

\[
\operatorname{Var}(X+Y)
=\operatorname{Var}(X)+\operatorname{Var}(Y)
  +2\operatorname{Cov}(X,Y),
\]

where covariance records their joint linear co-movement. When \(X\) and
\(Y\) are {{< refterm "independence" "independent" >}}, their covariance
vanishes under the usual integrability assumptions, so their variances add.
The converse is false: zero covariance does not generally imply independence.

## Zero variance and almost-sure constancy

If \(X\) is square-integrable under a probability measure, then

\[
\operatorname{Var}(X)=0
\quad\Longleftrightarrow\quad
X=\mathbb E[X]\quad\text{almost surely}.
\]

The phrase "almost surely" matters. A random variable may differ from its mean
on a set of probability zero and still have zero variance. Zero variance does
not force literal function equality at every outcome.

For the exact {{< refterm "gaussian-distribution" "Gaussian law" >}}
\(\gamma_{m,0}\), the same statement appears at the law level:
\(\gamma_{m,0}=\delta_m\). The project theorem
<code>HasRealGaussianLaw.ae_eq_const_of_variance_zero</code> turns that Dirac
law into almost-everywhere equality with \(m\).

## Population variance is not a finite-sample recipe

The definition above is **population variance**: an integral with respect to a
probability law. Given observed data \(x_1,\ldots,x_n\), one can instead
compute descriptive or inferential sample statistics. Two familiar formulas
are

\[
\frac{1}{n}\sum_{k=1}^{n}(x_k-\bar{x})^2
\quad\text{and}\quad
\frac{1}{n-1}\sum_{k=1}^{n}(x_k-\bar{x})^2,
\]

where \(\bar{x}\) is the sample mean. The second expression requires \(n\gt 1\).
They answer different questions and use different denominators. Neither
denominator belongs silently in the measure-theoretic definition of
\(\operatorname{Var}_{\mathbb P}(X)\).

## In Lean: write the variable and the measure explicitly

{{< lean-bridge
  human="The variance of X under probability measure P is four."
  math="\(\operatorname{Var}_{P}(X)=4.\)"
  lean="Var[X; P] = 4"
>}}

- <code>Var[</code> opens Mathlib's scoped notation for real-valued variance.
- <code>X</code> is the whole function from outcomes to real values. It is not
  one sampled number.
- The semicolon separates the random variable from the measure governing its
  outcomes.
- <code>P</code> is the measure. Lean will not silently guess a data table, a
  sampling convention, or a denominator.
- <code>]</code> closes the notation, and <code>= 4</code> is the proposition a
  proof must establish.
- A human literally types <code>Var[X; P] = 4</code> after importing a module
  that opens the probability notation. The project worksheet below supplies
  the import, types, and hypotheses that give each token meaning.
{{< /lean-bridge >}}

For an almost-everywhere measurable \(X\), the integral formula appears as:

{{< lean-bridge
  human="Variance is the integral of the squared deviation from the mean."
  math="\(\operatorname{Var}_{P}(X)=\int_\Omega (X(\omega)-\mathbb E_P[X])^2\,dP(\omega).\)"
  lean="ProbabilityTheory.variance_eq_integral hX"
>}}

- <code>ProbabilityTheory</code> is the namespace containing Mathlib's variance
  API.
- <code>variance_eq_integral</code> is a theorem name, not a request for Lean
  to numerically integrate a distribution.
- <code>hX : AEMeasurable X P</code> supplies the measurability gate.
- Its conclusion contains <code>P[X]</code> for the integral mean and
  <code>∫ ω, (X ω - P[X]) ^ 2 ∂P</code> for the squared-deviation integral.
- The theorem unfolds the mathematical meaning under its hypothesis; it does
  not erase the infinite-variance totalization caveat in the next section.
{{< /lean-bridge >}}

### Standalone tutorial

This first worksheet imports only Lean's small <code>Std</code> library. It
checks the arithmetic of the \(-1,3\) example without restoring Mathlib or
building this repository. Create a scratch file named
<code>VarianceTiny.lean</code>:

~~~lean
import Std

def square (z : Int) : Int := z * z

#eval [(-1 : Int), 3].map (fun x => square (x - 1))

example :
    square ((-1 : Int) - 1) + square (3 - 1) = 2 * 4 := by
  decide
~~~

Then type:

~~~sh
elan run leanprover/lean4:v4.32.0 lean VarianceTiny.lean
~~~

With the pinned Lean 4.32.0 toolchain, the evaluator prints
<code>[4, 4]</code>. The theorem proves that the
sum of the two squared deviations is \(2\cdot4\); dividing by the two equal
probability weights gives variance \(4\). Change the claimed right-hand side
to <code>2 * 5</code> and Lean should reject the file. That deliberate failure
is the quickest way to feel the difference between evaluation and proof.

### Full project check

On a clone with the repository's pinned dependencies
installed, a human can put this in a scratch Lean file:

~~~lean
import NonlinearDynamics.Random.GaussianPrimitives

open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

#check ProbabilityTheory.evariance
#check ProbabilityTheory.variance
#check ProbabilityTheory.variance_eq_integral
#check ProbabilityTheory.variance_const_mul
#check ProbabilityTheory.IndepFun.variance_add
#check NonlinearDynamics.Random.HasRealGaussianLaw.variance_eq
#check NonlinearDynamics.Random.HasRealGaussianLaw.ae_eq_const_of_variance_zero
~~~

The first two checks expose both codomains. The next three inspect the integral,
scaling, and independent-sum rules. The final two are project theorems: an exact
Gaussian has the stated variance, and zero Gaussian variance yields equality
with the mean almost everywhere.

{{< repo-check >}}
The authoritative project source is
[<code>formalization/NonlinearDynamics/Random/GaussianPrimitives.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/GaussianPrimitives.lean).
The command below builds that exact module against the pinned Mathlib checkout.
{{< /repo-check >}}

## Why the pinned real-valued notation needs care

Mathlib 4.32.0 defines two related quantities:

- <code>evariance X P : ℝ≥0∞</code> is an extended nonnegative real and can
  take the value infinity;
- <code>variance X P : ℝ</code>, written <code>Var[X; P]</code>, applies
  <code>ENNReal.toReal</code> to extended variance.

The real-valued operation is total. In Mathlib it returns zero when the
extended variance is infinite. Therefore a raw equality
<code>Var[X; P] = 0</code> must not be interpreted as almost-sure constancy
unless a finite second-moment hypothesis rules out the infinite case.

For measurable \(X\), Mathlib's finite-variance identity is exposed as
<code>variance_eq_integral</code>:

```lean
#check ProbabilityTheory.variance_eq_integral
#check ProbabilityTheory.variance_const_mul
#check ProbabilityTheory.IndepFun.variance_add
```

The project's exact Gaussian predicate avoids the totalization trap because a
Gaussian variable belongs to every finite \(L^p\) space. Its theorem
<code>HasRealGaussianLaw.variance_eq</code> states

```text
Var[X; P] = (v : ℝ)
```

for the explicit nonnegative-real parameter <code>v : ℝ≥0</code>.

## Edge cases and nonclaims

- Variance requires a measure. A bare function has no variance until a measure
  on its domain is fixed.
- Variance may be infinite. The extended quantity is the appropriate target before
  square integrability has been proved.
- A finite variance does not imply a Gaussian law. Many non-Gaussian laws have
  the same mean and variance.
- Variance summarizes one aspect of spread. It does not determine tail shape,
  skewness, multimodality, or dependence with other variables.
- Variance zero means almost-sure constancy under the stated hypotheses, not
  pointwise constancy on every element of the sample space.
- For a complex variable, one must say whether "variance" means
  \(\mathbb E|Z-\mathbb E Z|^2\), a covariance matrix of real and imaginary
  parts, a pseudocovariance, or another convention.

## Where to continue

The {{< refterm "gaussian-distribution" "Gaussian distribution" >}} uses
variance as its exact spread parameter. The
{{< refterm "normalization-convention" "normalization convention" >}} page
explains why scaling choices must be written down before real coordinates are
assembled into a complex variable or matrix. The
{{< refterm "cartesian-complex-gaussian-law" "Cartesian complex Gaussian law" >}}
keeps both component variances explicit, while
[Complex Gaussian Coordinates and Geometry]({{< relref "/knowledge-base/deep-dives/complex-gaussian-coordinates-and-geometry" >}})
derives their sum, difference, support geometry, and symmetry boundary. The
earlier
[Gaussian Laws, Independence, and Normalization]({{< relref "/knowledge-base/deep-dives/gaussian-laws-independence-and-normalization" >}})
builds the real finite-product foundation.

## References

**Mathlib contributors.**
[Variance of random variables](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Moments/Variance.html),
Mathlib 4 documentation. This official API reference documents
<code>evariance</code>, the totalized real <code>variance</code>, scaling, and
variance addition under independence.

**Mathlib contributors.**
[Gaussian distributions over the reals](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
Mathlib 4 documentation. The results <code>variance_id_gaussianReal</code> and
<code>memLp_id_gaussianReal</code> connect the parameter \(v\) to finite
variance and all finite moments.

**National Institute of Standards and Technology.**
[What do we mean by normal data?](https://www.itl.nist.gov/div898/handbook/pmc/section5/pmc51.htm),
Engineering Statistics Handbook. This official reference distinguishes a
normal law's variance from its standard deviation.

The local formalization uses the exact Mathlib 4.32.0 dependency pinned at
commit
[`81a5d257`](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).
