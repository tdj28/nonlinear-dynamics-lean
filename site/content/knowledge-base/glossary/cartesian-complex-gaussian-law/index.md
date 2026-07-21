---
title: "Cartesian complex Gaussian law"
slug: "cartesian-complex-gaussian-law"
summary: "A Cartesian complex Gaussian law is the pushforward of two independent real Gaussian laws through the map that joins real and imaginary coordinates."
draft: true
pro_reviewed: false
toc: true
og_image: "cartesian-complex-gaussian-law-card.png"
og_image_alt: "Two exact real Gaussian coordinate laws enter a product-law stage and then become one complex Gaussian law with the two component variances still visible."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page must remain a draft until that review is complete.
{{< /panel >}}

A **Cartesian complex Gaussian law** builds a probability measure on the
complex plane from two independent real Gaussian coordinate laws. It keeps the
real-part variance and imaginary-part variance visible instead of hiding them
behind the ambiguous phrase "standard complex Gaussian."

Let \(m=m_{\mathrm R}+i m_{\mathrm I}\in\mathbb C\), let
\(v_{\mathrm R},v_{\mathrm I}\ge 0\), and write
\(\gamma_{a,v}\) for the real Gaussian law with mean \(a\) and variance
\(v\). Define the coordinate-pairing map

\[
\Phi:\mathbb R\times\mathbb R\longrightarrow\mathbb C,
\qquad
\Phi(x,y)=x+iy.
\]

The Cartesian complex Gaussian law is

\[
\Gamma^{\mathrm{cart}}_{m;v_{\mathrm R},v_{\mathrm I}}
=\Phi_*
 \left(
   \gamma_{m_{\mathrm R},v_{\mathrm R}}
   \otimes
   \gamma_{m_{\mathrm I},v_{\mathrm I}}
 \right).
\]

Here \(\otimes\) is the product of probability measures and \(\Phi_*\)
is a {{< refterm "pushforward-measure" "pushforward measure" >}}. The
definition says more than "both coordinates are Gaussian." The product law
also records their {{< refterm "independence" "independence" >}}.

{{< reference-figure
  src="cartesian-complex-law.svg"
  alt="An exact real-coordinate Gaussian law and an exact imaginary-coordinate Gaussian law combine through a product law before a coordinate-pairing map produces one complex law."
  caption="**Finding:** a Cartesian complex Gaussian law is assembled in two logically separate steps. The product measure fixes both marginal laws and their independence; the coordinate-pairing map then changes representation from an ordered real pair to one complex number. The plate does not assert circular symmetry or choose a matrix normalization."
>}}

## Why the adjective Cartesian matters

The complex plane can be read as the real vector space \(\mathbb R^2\). A
general complex Gaussian variable may therefore be defined from a jointly
Gaussian real pair whose covariance ellipse can be rotated relative to the
real and imaginary axes. The Cartesian family on this page is narrower:

- the real and imaginary parts are independent;
- their covariance is therefore zero when the required moments exist;
- their means and variances are explicit; and
- any anisotropy is aligned with the displayed real and imaginary axes.

The family still permits unequal component variances. "Cartesian" does not
mean identically distributed, circularly symmetric, proper, or standardized.
It names the product-coordinate construction.

## Read the exact law back through the coordinates

Suppose a complex random variable \(Z:\Omega\to\mathbb C\) has law
\(\Gamma^{\mathrm{cart}}_{m;v_{\mathrm R},v_{\mathrm I}}\) under a
probability measure \(\mathbb P\). Applying the real and imaginary coordinate
maps recovers

\[
\operatorname{Re} Z
\sim\gamma_{m_{\mathrm R},v_{\mathrm R}},
\qquad
\operatorname{Im} Z
\sim\gamma_{m_{\mathrm I},v_{\mathrm I}}.
\]

The joint law is the product

\[
\mathcal L_{\mathbb P}
  (\operatorname{Re}Z,\operatorname{Im}Z) =
\gamma_{m_{\mathrm R},v_{\mathrm R}}
\otimes
\gamma_{m_{\mathrm I},v_{\mathrm I}},
\]

so the two coordinate functions are independent. These consequences are
law-level facts. They are not estimates made from a cloud of observed points.

Conversely, if real random variables \(X\) and \(Y\) have those exact
Gaussian laws and are independent, then

\[
Z=X+iY
\]

has the stated Cartesian complex Gaussian law. This converse is the reusable
constructor: build and verify the two primitive coordinates first, then join
them without losing their parameters.

## Geometry and every degenerate branch

The variance pair controls the support geometry.

| Variance branch | Geometry of the law |
|---|---|
| \(v_{\mathrm R}\gt 0\) and \(v_{\mathrm I}\gt 0\) | a two-dimensional Gaussian measure with axis-aligned elliptical contours |
| \(v_{\mathrm R}=v_{\mathrm I}\gt 0\) | the ellipse becomes a circle around \(m\) |
| exactly one variance is zero | the law is supported on a horizontal or vertical line through \(m\) |
| \(v_{\mathrm R}=v_{\mathrm I}=0\) | the law is the Dirac point mass \(\delta_m\) |

When both variances are positive, the density with respect to planar Lebesgue
measure is

\[
f(x+iy)
=\frac{1}{2\pi\sqrt{v_{\mathrm R}v_{\mathrm I}}}
  \exp\!\left(
    -\frac{(x-m_{\mathrm R})^2}{2v_{\mathrm R}}
    -\frac{(y-m_{\mathrm I})^2}{2v_{\mathrm I}}
  \right).
\]

This formula is the product of the two real Gaussian densities. It must not be
used when either variance is zero. A line-supported law is singular with
respect to two-dimensional area, and the double-zero law is a point mass.
The measure definition handles all four branches without dividing by zero.

## Complex variance and pseudocovariance are different ledgers

Write the centered variable as

\[
Z-m=X+iY,
\]

where \(X\) and \(Y\) are independent, centered real Gaussians with
variances \(v_{\mathrm R}\) and \(v_{\mathrm I}\). The total centered
squared magnitude is

\[
\mathbb E|Z-m|^2
=\mathbb E[X^2+Y^2]
=v_{\mathrm R}+v_{\mathrm I}.
\]

The **pseudocovariance**, also called complementary variance in some
literature, is instead

\[
\mathbb E[(Z-m)^2]
=\mathbb E[X^2-Y^2+2iXY]
=v_{\mathrm R}-v_{\mathrm I}.
\]

The last equality uses independence and centering to make
\(\mathbb E[XY]=0\). The sum and difference therefore answer different
questions. Total squared magnitude records overall spread. Pseudocovariance
detects the imbalance between the two Cartesian axes in this family.

Neither quantity should be called simply "the variance" without stating the
convention. The {{< refterm "variance" "variance" >}} and
{{< refterm "normalization-convention" "normalization convention" >}}
entries explain why the units and parameter names must remain explicit.

## Properness is not the definition of circularity

A second-order complex variable is called **proper** when its centered
pseudocovariance vanishes. In this Cartesian family,

\[
\mathbb E[(Z-m)^2]=0
\quad\Longleftrightarrow\quad
v_{\mathrm R}=v_{\mathrm I}.
\]

A centered law is **circularly symmetric** when multiplication by every unit
complex phase leaves its complete law unchanged:

\[
e^{i\theta}(Z-m)\ \stackrel{d}{=}\ Z-m
\qquad\text{for every }\theta\in\mathbb R.
\]

Circular symmetry is a full distributional statement. Properness is a
second-moment statement. For this Gaussian family, equal component variances
make the centered two-dimensional Gaussian isotropic, so properness and
circular symmetry agree. Outside the Gaussian family, zero pseudocovariance
does not determine the full law and need not imply circular symmetry.

A nonzero mean introduces another distinction. The centered variable may be
circularly symmetric about \(m\), while the uncentered law is not invariant
under rotations about the origin. Any use of "circular" should say which
center is fixed.

## Two common normalizations are two different laws

Let \(U,V\sim\gamma_{0,1}\) be independent. Then

\[
Z_1=\frac{U+iV}{\sqrt2}
\]

has component variances \(1/2\), total centered squared magnitude \(1\),
and density

\[
f_1(z)=\frac{1}{\pi}e^{-|z|^2}.
\]

By contrast,

\[
Z_2=U+iV
\]

has component variances \(1\), total centered squared magnitude \(2\), and
density

\[
f_2(z)=\frac{1}{2\pi}e^{-|z|^2/2}.
\]

Both are centered, proper, and circularly symmetric. They are not the same
probability law. This project therefore keeps both component variances in the
public interface and does not define an unqualified "standard" constructor.

## The checked Lean representation

The project measure is named <code>cartesianComplexGaussian</code>. It maps
the product of two Mathlib <code>gaussianReal</code> measures through the
continuous real-linear equivalence that identifies an ordered pair of real
coordinates with a complex number:

~~~lean
noncomputable def cartesianComplexGaussian
    (m : ℂ) (vRe vIm : ℝ≥0) : Measure ℂ :=
  ((gaussianReal m.re vRe).prod (gaussianReal m.im vIm)).map
    Complex.equivRealProdCLM.symm
~~~

The exact random-variable predicate is

~~~lean
def HasCartesianComplexGaussianLaw (Z : Ω → ℂ) (m : ℂ)
    (vRe vIm : ℝ≥0) (P : Measure Ω) : Prop :=
  HasLaw Z (cartesianComplexGaussian m vRe vIm) P
~~~

As with the real layer, <code>HasLaw</code> carries
<code>AEMeasurable Z P</code>, not ordinary <code>Measurable Z</code>. The
constructor from two real variables requires their exact real laws and
<code>IndepFun X Y P</code>. It does not add ordinary measurability assumptions
that the proof does not need. Mathlib defines <code>IndepFun</code> through the
two pulled-back measurable spaces generated by the functions, so independence
itself is meaningful without treating either function as ordinarily
measurable into the ambient source space.

The checked module exposes the following layers:

- probability of the measure and of any source measure carrying the law;
- exact real-part, imaginary-part, and joint coordinate laws;
- independence of the two coordinate functions;
- qualitative Gaussianity as a Gaussian law on the real Banach space
  underlying \(\mathbb C\);
- finite \(L^p\) membership for every \(p\ne\infty\) and integrability;
- the exact complex mean \(m\);
- almost-everywhere equality with \(m\) when both variances are zero; and
- construction from independent real Gaussian coordinates.

The theorem names are mapped declaration by declaration in the paired
Development Notebook chapter. The current Lean module does not formalize the
planar density, pseudocovariance, properness, circular symmetry, or a matrix
normalization. Those are mathematical interpretations and explicit next-layer
boundaries, not hidden consequences attributed to the checker.

## Edge cases and nonclaims

- Gaussian real and imaginary marginals do not imply the Cartesian law unless
  their joint dependence is fixed.
- Independence is stronger than zero covariance for arbitrary variables.
- Equal component variances imply circular symmetry here because the complete
  joint law is Gaussian and a product. Equal variances alone would not do so
  for an arbitrary non-Gaussian pair.
- A positive planar density exists only when both component variances are
  positive.
- A slanted line-supported Gaussian in the complex plane is a valid general
  real two-dimensional Gaussian, but it is not represented by an independent
  Cartesian pair unless its line is one of the chosen coordinate axes.
- Qualitative <code>HasGaussianLaw</code> does not recover this page's explicit
  component variances.
- Nothing here defines a random matrix, a Gaussian unitary ensemble, unitary
  invariance, eigenvalues, a trace moment, or an asymptotic law.

## Where to continue

The textbook chapter
[Complex Gaussian Coordinates and Geometry]({{< relref "/knowledge-base/deep-dives/complex-gaussian-coordinates-and-geometry" >}})
derives the law, densities, moments, symmetry distinctions, degeneracies, and
Lean proof architecture in full. The earlier
[Gaussian Laws, Independence, and Normalization]({{< relref "/knowledge-base/deep-dives/gaussian-laws-independence-and-normalization" >}})
chapter builds the real primitives and finite product laws used here.

The
{{< refterm "independent-cartesian-complex-gaussian-family" "Independent Cartesian complex Gaussian family" >}}
entry lifts this exact law to mutually independent indexed coordinates. Its
textbook companion,
[Finite Product Probability Spaces and Independent Gaussian Fields]({{< relref "/knowledge-base/deep-dives/finite-product-probability-spaces-and-independent-gaussian-fields" >}}),
explains the exact joint product law, cross-family independence trap, canonical
sample space, real scaling, and empty-index boundary.

Use {{< refterm "gaussian-distribution" "Gaussian distribution" >}} for
the one-dimensional measure, {{< refterm "independence" "independence" >}}
for the product-law obligation, {{< refterm "variance" "variance" >}} for
the finite-moment boundary, and
{{< refterm "normalization-convention" "normalization convention" >}} before
carrying these coordinates into a matrix model.

## References

**Mathlib contributors.**
[Gaussian distributions over the reals](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
Mathlib 4 documentation. This official API defines the exact real coordinate
measures, including their zero-variance Dirac branches.

**Mathlib contributors.**
[Law of a random variable](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/HasLaw.html),
Mathlib 4 documentation. This is the official source for the
<code>AEMeasurable</code> and pushforward fields carried by
<code>HasLaw</code>.

**Mathlib contributors.**
[Complex numbers as a real normed space](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Complex/Basic.html),
Mathlib 4 documentation. This documents
<code>Complex.equivRealProdCLM</code> and the real and imaginary continuous
linear maps used to move between \(\mathbb C\) and \(\mathbb R^2\).

**F. D. Neeser and J. L. Massey.**
[Proper Complex Random Processes with Applications to Information Theory](https://doi.org/10.1109/18.243446),
*IEEE Transactions on Information Theory* 39 (1993), 1293-1302. This primary
source defines pseudocovariance-based properness and explains why covariance
alone does not capture complex second-order structure.

**Bernard Picinbono.**
[Second-Order Complex Random Vectors and Normal Distributions](https://doi.org/10.1109/78.539051),
*IEEE Transactions on Signal Processing* 44 (1996), 2637-2640. This primary
source develops covariance and relation information for complex normal laws.

The exact upstream source audited for the Lean discussion is Mathlib commit
[`81a5d257`](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by this repository.
