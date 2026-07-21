---
title: "Normalization convention"
slug: "normalization-convention"
summary: "A normalization convention records exactly how raw variables are scaled and which quantity each parameter denotes."
draft: true
pro_reviewed: false
toc: true
og_image: "normalization-convention-card.png"
og_image_alt: "The same two standard real Gaussian coordinates branch into two complex scalings with different component variances and different total squared magnitudes."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page must remain a draft until that review is complete.
{{< /panel >}}

A **normalization convention** is an explicit agreement about scale. It states
which mathematical quantity each symbol denotes, how primitive variables are
rescaled, and which observables are divided by dimension or another reference
quantity. A normalization is not cosmetic. It changes exact variances,
densities, moments, and the scale on which a limit can be meaningful.

The safest practice is to keep a **normalization ledger**: a short table that
records every scale choice before a named model is introduced.

## One symbol can hide two different Gaussian laws

For a real {{< refterm "gaussian-distribution" "Gaussian distribution" >}},
one author may write \(N(m,\sigma^2)\), using variance as the second
parameter. Another may write \(N(m,\sigma)\), using standard deviation. If
the declaration does not explain its convention, the same text can denote two
different laws.

This project and Mathlib use a variance parameter:

\[
\gamma_{m,v}
\quad\text{with}\quad
v=\operatorname{Var}(X)\ge0.
\]

Scaling by \(c\) sends \(v\) to \(c^2v\). That square is the first line
of the ledger.

## A checkable complex-coordinate example

Let \(U\) and \(V\) be {{< refterm "independence" "independent" >}} real
Gaussian variables with mean zero and variance one. Consider two complex
variables built from the same primitive convention:

\[
Z_A=\frac{U+iV}{\sqrt{2}},
\qquad
Z_B=U+iV.
\]

Their component variances differ:

\[
\operatorname{Var}(\operatorname{Re} Z_A)
=\operatorname{Var}(\operatorname{Im} Z_A)
=\frac{1}{2},
\]

while

\[
\operatorname{Var}(\operatorname{Re} Z_B)
=\operatorname{Var}(\operatorname{Im} Z_B)
=1.
\]

Because \(|x+iy|^2=x^2+y^2\) and both variables are centered,

\[
\mathbb E|Z_A|^2=1,
\qquad
\mathbb E|Z_B|^2=2.
\]

Both constructions are mathematically valid. Calling either one "standard
complex Gaussian" without a component-variance or total-energy statement is
ambiguous.

{{< reference-figure
  src="normalization-branch.svg"
  alt="Two independent real Gaussian coordinates can be divided by the square root of two or left unscaled, producing different component variances and total squared magnitudes."
  caption="**Finding:** a complex Gaussian label does not determine scale. The two branches use the same exact primitive laws but produce total second moments one and two. These are symbolic constructions, not empirical estimates, and neither branch is yet the project's matrix-ensemble convention."
>}}

## The minimum ledger for a Cartesian complex Gaussian

To define a complex Gaussian variable \(Z=X+iY\) without hiding its scale,
record at least:

| Ledger field | Question that must have one answer |
|---|---|
| Real-part mean | What is \(\mathbb E[X]\)? |
| Imaginary-part mean | What is \(\mathbb E[Y]\)? |
| Real-part variance | What is \(\operatorname{Var}(X)\)? |
| Imaginary-part variance | What is \(\operatorname{Var}(Y)\)? |
| Dependence | Are \(X\) and \(Y\) independent, merely uncorrelated, or governed by another joint law? |
| Complex second moment | What does \(\mathbb E|Z-\mathbb E Z|^2\) equal? |
| Pseudocovariance | Is \(\mathbb E[(Z-\mathbb E Z)^2]\) constrained? |
| Naming | Does the scale parameter denote a component variance, total variance, or standard deviation? |

Equal component variances plus independence for centered real Gaussian parts
supports a rotationally symmetric complex law. That statement is a
mathematical consequence of the full Gaussian product law, not a symmetry
theorem in the current Lean module. A ledger entry is a specification, not a
substitute for a theorem.

## The minimum ledger before a Gaussian matrix ensemble

A finite Hermitian matrix adds more places where scale can hide. Before the
project names any specific Gaussian ensemble, the ledger must state:

| Ledger field | Symbolic placeholder |
|---|---|
| Matrix size and zero-size policy | \(n\) and a declared rule for \(n=0\) |
| Diagonal entry law | mean and variance \(d_n\) |
| Off-diagonal real-part law | mean and variance \(a_n\) |
| Off-diagonal imaginary-part law | mean and variance \(b_n\) |
| Dependence | which upper-triangular primitive variables are mutually independent |
| Hermitian reflection | how the lower triangle is determined by conjugation |
| Density convention | the exact exponent and reference volume, if a density is used |
| Spectral scale | whether eigenvalues are order one, order \(\sqrt{n}\), or on another declared scale |
| Trace convention | raw \(\operatorname{tr}\) or normalized \(n^{-1}\operatorname{tr}\) |
| Observable scaling | every additional factor used in moments or correlations |

The placeholders \(d_n,a_n,b_n\) are not values. They make the missing choice
visible. Two entrywise descriptions and one density formula define the same law
only after their constants have been checked against each other.

## Normalization is part of the theorem statement

Suppose a random matrix \(H_n\) is replaced by \(c_nH_n\). Its eigenvalues
are multiplied by \(c_n\), its \(k\)-th trace power is multiplied by
\(c_n^k\), and its entry variances are multiplied by \(c_n^2\). Thus the
claims

\[
\operatorname{tr}(H_n^k),
\qquad
\frac{1}{n}\operatorname{tr}(H_n^k),
\qquad
\operatorname{tr}((c_nH_n)^k)
\]

are related but not interchangeable. A limit theorem, exact moment identity,
or spectral plot that omits these factors is not fully specified.

The same discipline applies outside random matrices. Lyapunov exponents need a
time normalization, spectral form factors need a trace convention, and
empirical spectral measures need a mass normalization. The ledger changes
with the object, but the rule does not: name the denominator and the scale.

## The pinned Lean layer keeps scale explicit

The project theorem <code>HasRealGaussianLaw.const_mul</code> states the
coordinate scaling law without introducing a shorthand variance convention:

```text
HasRealGaussianLaw X m v P
  -> HasRealGaussianLaw (fun ω ↦ c * X ω) (c * m)
       (⟨c ^ 2, sq_nonneg c⟩ * v) P
```

The nonnegative-real constructor stores the proof that \(c^2\ge0\). The
formula also includes \(c=0\), so the output is the correct zero-variance
Dirac law.

For a family, <code>IndependentRealGaussianFamily.scale</code> accepts a
coordinate-dependent scale <code>c : ι → ℝ</code>. It preserves three separate
facts: ordinary coordinate measurability, each exact Gaussian law, and mutual
independence. This is enough to prepare coordinates for a later complex
construction without committing to a matrix normalization.

The checked <code>cartesianComplexGaussian m vRe vIm</code> measure now uses
the same exact-law ingredients. It maps the product of two exact real Gaussian
laws into \(\mathbb C\), while
<code>HasCartesianComplexGaussianLaw</code> keeps <code>vRe</code> and
<code>vIm</code> visible. The module proves the exact joint and marginal laws,
coordinate independence, finite moments, integrability, mean, and the
double-zero Dirac branch. It does not select equal variances or formalize a
complex density, pseudocovariance, properness, or circular symmetry.

## Edge cases and nonclaims

- A normalization does not make a probability measure integrate to one unless
  the required constant has actually been proved.
- "Unit variance" is ambiguous for a complex variable until component versus
  total variance is specified.
- Entrywise variance and eigenvalue scale are related through dimension and
  matrix structure. One cannot be inferred from a name alone.
- Raw trace and normalized trace are different observables.
- Setting \(n=0\) can make dimension-dependent factors undefined. A
  formal constructor needs an explicit policy.
- The project has formalized an explicit two-variance Cartesian complex
  Gaussian family. It has not approved an unqualified "standard" complex scale
  or a named Gaussian matrix normalization.
- Nothing on this page proves a Gaussian unitary ensemble law, unitary
  invariance, an eigenvalue density, or an asymptotic spectral result.

## Where to continue

Read {{< refterm "variance" "variance" >}} for the scaling square and
{{< refterm "independence" "independence" >}} for the joint-law obligation.
The Deep Dive
[Gaussian Laws, Independence, and Normalization]({{< relref "/knowledge-base/deep-dives/gaussian-laws-independence-and-normalization" >}})
builds a complete finite real product law. The
{{< refterm "cartesian-complex-gaussian-law" "Cartesian complex Gaussian law" >}}
fills the independent-coordinate ledger without choosing a symmetric scale,
and
[Complex Gaussian Coordinates and Geometry]({{< relref "/knowledge-base/deep-dives/complex-gaussian-coordinates-and-geometry" >}})
develops its geometry and symmetry boundaries. The
{{< refterm "independent-cartesian-complex-gaussian-family" "Independent Cartesian complex Gaussian family" >}}
then promotes both variance parameters to index-dependent functions, and
[Finite Product Probability Spaces and Independent Gaussian Fields]({{< relref "/knowledge-base/deep-dives/finite-product-probability-spaces-and-independent-gaussian-fields" >}})
tracks those functions through real coordinatewise scaling without selecting a
matrix normalization.

## References

**National Institute of Standards and Technology.**
[Normal Distribution](https://www.itl.nist.gov/div898/handbook/eda/section3/eda3661.htm),
Engineering Statistics Handbook. This official reference states the usual
location and scale parameterization, against which the variance convention can
be checked.

**Mathlib contributors.**
[Gaussian distributions over the reals](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
Mathlib 4 documentation. This is the official API reference for the variance
parameter and the exact scaling rule used by the project.

**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems. I](https://doi.org/10.1063/1.1703773),
*Journal of Mathematical Physics* 3 (1962), 140-156. This primary historical
source motivates symmetry-defined matrix ensembles. It does not select the
normalization for this project.

The local formalization is pinned to Mathlib 4.32.0 at commit
[`81a5d257`](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997).
