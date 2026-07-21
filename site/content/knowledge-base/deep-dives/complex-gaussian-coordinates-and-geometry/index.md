---
title: "Complex Gaussian Coordinates and Geometry"
slug: "complex-gaussian-coordinates-and-geometry"
date: 2026-07-21
summary: "A guided ascent from two exact real Gaussian coordinates to a complex law, its support geometry, second-order structure, symmetry boundaries, and checked Lean interface."
lead: "A complex Gaussian is not a bell curve with an imaginary label. It is a two-dimensional law whose coordinates, dependence, degeneracies, and normalization must all be named."
draft: true
pro_reviewed: false
level: "Base camp to advanced"
reading_time: "50 to 75 minutes"
prerequisites: "Real Gaussian laws, elementary complex arithmetic, and basic probability notation; no Lean experience required"
lean_module: "NonlinearDynamics.Random.ComplexGaussian"
toc: true
og_image: "complex-gaussian-coordinates-card.png"
og_image_alt: "A warm-paper teaching card compares circular, elliptical, line-supported, and point-mass complex Gaussian geometry while preserving separate real and imaginary variances."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The mathematical
prose, sources, Lean declaration map, figures, and accessibility have not yet
received the required human and Pro reviews. The page must remain a draft until
those gates are complete.
{{< /panel >}}

A real Gaussian law has one axis. A complex Gaussian law has two. That extra
axis creates choices that informal notation often erases: whether the real and
imaginary parts are independent, whether their variances agree, whether a
quoted variance is per coordinate or total, whether the law has a planar
density, and whether rotation invariance is actually known.

This chapter builds one deliberately explicit family. It starts from exact
real Gaussian measures, forms their product, and transports the result through
the canonical identification of an ordered pair \((x,y)\) with the complex
number \(x+iy\). The two component variances remain visible at every stage.
That choice covers circular, elliptical, line-supported, and point-mass
branches without pretending they are the same geometry.

The Lean module follows the same dependency order. It proves the exact measure
first, then coordinate laws and independence, then qualitative Gaussianity and
analytic consequences. It does not formalize a density, properness,
circularity, or a matrix ensemble. Those boundaries are stated here instead of
being hidden behind a suggestive name.

## Choose a route up

| Route | Start with | What you will gain |
|---|---|---|
| First encounter | A complex number as two real coordinates | A concrete model of a complex-valued random variable |
| Probability route | Product laws and pushforwards | Why exact marginals plus independence determine this law |
| Geometry route | Variance along each axis | A complete map of circular, elliptical, line, and point branches |
| Signal route | Covariance and pseudocovariance | A careful separation of properness from circular symmetry |
| Lean route | <code>HasLaw</code> and a real-linear equivalence | A declaration-by-declaration map of the checked module |
| Random-matrix route | Normalization ledgers | A safe handoff toward complex matrix entries without naming GUE early |

### Learning objectives

By the summit, you should be able to:

1. define the Cartesian complex Gaussian measure as a pushforward of a product
   of two exact real Gaussian laws;
2. recover its real, imaginary, and joint coordinate laws;
3. explain why Gaussian marginals do not encode independence;
4. derive the positive-variance planar density without using it at singular
   variance values;
5. compute total centered squared magnitude and pseudocovariance from the two
   component variances;
6. distinguish a proper law from a circularly symmetric law;
7. convert between the two common symmetric normalizations;
8. explain why <code>HasLaw</code> gives almost-everywhere measurability rather
   than ordinary measurability; and
9. identify exactly what the current Lean module proves and what remains prose.

## Base camp: the complex plane is a real two-dimensional space

Every complex number has a unique decomposition

\[
z=x+iy,
\qquad x,y\in\mathbb R.
\]

The maps \(z\mapsto(\operatorname{Re}z,\operatorname{Im}z)\) and
\((x,y)\mapsto x+iy\) are inverse real-linear maps. They are also continuous
and measurable. This matters because a probability law can be transported in
either direction without changing its information, only its representation.

A complex random variable is a map

\[
Z:\Omega\longrightarrow\mathbb C
\]

on a measured outcome space. Its coordinate pair is

\[
\omega\longmapsto
\bigl(\operatorname{Re}Z(\omega),\operatorname{Im}Z(\omega)\bigr).
\]

Three objects must remain distinct:

| Object | Example | What it records |
|---|---|---|
| Sample map | \(Z:\Omega\to\mathbb C\) | which complex value each outcome produces |
| Realization | \(Z(\omega)\) | one value at one outcome |
| Law | \(\mathcal L_{\mathbb P}(Z)\) | the probability assigned to every measurable region of the plane |

A scatter plot is a finite collection of realizations. It can suggest shape,
but it is not the law and does not prove independence, Gaussianity, or
rotational symmetry.

{{< checkpoint stage="Base camp" title="Read a complex variable as a joint real law" >}}
Before asking whether \(Z\) is Gaussian, identify the joint law of its real
and imaginary parts. Two one-dimensional marginals do not determine how the
coordinates move together.
{{< /checkpoint >}}

## Camp one: assemble the exact Cartesian law

Write \(\gamma_{a,v}\) for the real Gaussian law with mean
\(a\in\mathbb R\) and variance \(v\ge0\). For a complex center

\[
m=m_{\mathrm R}+i m_{\mathrm I}
\]

and coordinate variances \(v_{\mathrm R},v_{\mathrm I}\ge0\), begin on
\(\mathbb R\times\mathbb R\) with the product measure

\[
\gamma_{m_{\mathrm R},v_{\mathrm R}}
\otimes
\gamma_{m_{\mathrm I},v_{\mathrm I}}.
\]

The first factor governs the real coordinate. The second governs the imaginary
coordinate. The product sign is the dependence statement: the coordinates are
independent. Now transport the pair through

\[
\Phi(x,y)=x+iy.
\]

The resulting measure is

\[
\Gamma^{\mathrm{cart}}_{m;v_{\mathrm R},v_{\mathrm I}}
=\Phi_*
 \left(
  \gamma_{m_{\mathrm R},v_{\mathrm R}}
  \otimes
  \gamma_{m_{\mathrm I},v_{\mathrm I}}
 \right).
\]

The dedicated
{{< refterm "cartesian-complex-gaussian-law" "Cartesian complex Gaussian law" >}}
entry gives the compact operational definition. Here we will unpack every
layer.

### Why exact marginals are not enough

Suppose \(X\) and \(Y\) are both standard real Gaussian variables. At least
two incompatible joint constructions have those marginals:

- choose \(X\) and \(Y\) independently;
- choose one standard Gaussian \(X\) and set \(Y=X\).

In the independent case, \((X,Y)\) fills a two-dimensional cloud. In the
copied case, every point lies on the diagonal line \(y=x\). The marginals are
identical, but the joint laws, support dimensions, and rotation properties are
different.

The Cartesian law chooses the first type of coupling. This is why its
definition begins with a product measure rather than merely listing two
Gaussian marginals.

### The coordinate law can be recovered exactly

Map the complex law back through

\[
z\longmapsto(\operatorname{Re}z,\operatorname{Im}z).
\]

Because this map is the inverse of \(\Phi\), the original product measure is
recovered:

\[
(\operatorname{Re},\operatorname{Im})_*
\Gamma^{\mathrm{cart}}_{m;v_{\mathrm R},v_{\mathrm I}} =
\gamma_{m_{\mathrm R},v_{\mathrm R}}
\otimes
\gamma_{m_{\mathrm I},v_{\mathrm I}}.
\]

Projecting that product onto either coordinate gives the corresponding exact
real Gaussian marginal. This back-and-forth identity is stronger than a
moment calculation. It identifies the complete probability law.

## Camp two: the variance split determines support geometry

The two nonnegative variances form a complete branch table for this family.

{{< reference-figure
  src="complex-gaussian-geometry.svg"
  alt="Equal positive component spreads produce circular contours, unequal positive spreads produce an axis-aligned ellipse, one zero spread produces a line-supported law, and two zero spreads produce a point mass."
  caption="**Finding:** the separate component variances determine whether the Cartesian law occupies the plane, an axis-aligned line, or one point. Equal positive spreads give circular contours; unequal positive spreads give elliptical contours. The shapes are conceptual level sets and supports, not samples or empirical estimates."
>}}

### Both variances positive: a planar density

When \(v_{\mathrm R}>0\) and \(v_{\mathrm I}>0\), multiply the two
one-dimensional Gaussian densities. The coordinate map \(\Phi\) has unit
Jacobian, so with \(z=x+iy\),

\[
f(z)
=\frac{1}{2\pi\sqrt{v_{\mathrm R}v_{\mathrm I}}}
 \exp\!\left(
  -\frac{(x-m_{\mathrm R})^2}{2v_{\mathrm R}}
  -\frac{(y-m_{\mathrm I})^2}{2v_{\mathrm I}}
 \right).
\]

A level set of the exponent satisfies

\[
\frac{(x-m_{\mathrm R})^2}{v_{\mathrm R}}
+\frac{(y-m_{\mathrm I})^2}{v_{\mathrm I}}
=\text{constant}.
\]

These are ellipses aligned with the real and imaginary axes. The larger
component variance produces the longer axis.

### Equal positive variances: isotropic contours

If \(v_{\mathrm R}=v_{\mathrm I}=q>0\), then

\[
f(z)
=\frac{1}{2\pi q}
 \exp\!\left(-\frac{|z-m|^2}{2q}\right).
\]

The density depends only on distance from \(m\), so its contours are circles.
The centered law is invariant under every rotation. Notice that the total
centered squared magnitude will be \(2q\), not \(q\). A component variance and
a total complex second moment are different normalization slots.

### Exactly one variance zero: a Gaussian line

Suppose \(v_{\mathrm R}=0\) and \(v_{\mathrm I}>0\). The real coordinate
equals \(m_{\mathrm R}\) almost surely, while the imaginary coordinate remains
Gaussian. The law is supported on the vertical line

\[
\{m_{\mathrm R}+iy:y\in\mathbb R\}.
\]

The reversed branch gives a horizontal line. Neither law has a density with
respect to planar area. It does have a one-dimensional Gaussian description
along its supporting line.

### Both variances zero: a Dirac mass

When \(v_{\mathrm R}=v_{\mathrm I}=0\), both real coordinate measures are
Dirac masses. Their product is a Dirac mass at
\((m_{\mathrm R},m_{\mathrm I})\), and the coordinate-pairing map sends that
point to \(m\). Therefore

\[
\Gamma^{\mathrm{cart}}_{m;0,0}=\delta_m.
\]

This is a Gaussian law in Mathlib's qualitative sense. Degenerate Gaussians
are part of the closed family. Excluding them would make scaling by zero an
artificial exceptional case.

## Camp three: mean, total spread, and pseudocovariance

Let

\[
Z=m+X+iY,
\]

where \(X\sim\gamma_{0,v_{\mathrm R}}\),
\(Y\sim\gamma_{0,v_{\mathrm I}}\), and \(X,Y\) are independent.
Linearity of integration gives

\[
\mathbb E[Z]
=m+\mathbb E[X]+i\mathbb E[Y]
=m.
\]

Complex second-order theory then splits into two quantities.

### Covariance with conjugation measures total squared magnitude

The conventional scalar complex covariance is

\[
C_Z
=\mathbb E\!\left[(Z-m)\overline{(Z-m)}\right]
=\mathbb E|Z-m|^2.
\]

Since \(|X+iY|^2=X^2+Y^2\),

\[
C_Z=v_{\mathrm R}+v_{\mathrm I}.
\]

This nonnegative real number measures total squared spread across both axes.

### Pseudocovariance detects directional imbalance

The pseudocovariance is

\[
P_Z
=\mathbb E[(Z-m)^2].
\]

Expand the square:

\[
(X+iY)^2=X^2-Y^2+2iXY.
\]

Independence and centering give
\(\mathbb E[XY]=\mathbb E[X]\mathbb E[Y]=0\), so

\[
P_Z=v_{\mathrm R}-v_{\mathrm I}.
\]

The pair \((C_Z,P_Z)\) recovers the two coordinate variances in this
Cartesian family:

\[
v_{\mathrm R}=\frac{C_Z+P_Z}{2},
\qquad
v_{\mathrm I}=\frac{C_Z-P_Z}{2}.
\]

Here \(P_Z\) is real because the Cartesian axes are independent. For a general
complex Gaussian pair with nonzero covariance between the real and imaginary
coordinates, \(P_Z\) can be complex. This is one reason a single scalar called
"complex variance" cannot describe every second-order law.

{{< panel "info" >}}
The current Lean module proves the exact coordinate laws, independence,
finite moments, integrability, and complex mean. It does not yet define or
prove formulas for \(C_Z\), \(P_Z\), properness, or circularity. The formulas
in this section are mathematical consequences documented for the next formal
layer, not declarations already checked by Lean.
{{< /panel >}}

The {{< refterm "variance" "variance" >}} entry explains Mathlib's real
variance totalization and the moment hypotheses that keep zero-variance
reasoning honest.

## The properness ridge: a moment condition is not a symmetry definition

A finite-second-moment complex variable is **proper** when its centered
pseudocovariance is zero:

\[
P_Z=0.
\]

For the Cartesian family,

\[
P_Z=0
\quad\Longleftrightarrow\quad
v_{\mathrm R}=v_{\mathrm I}.
\]

This is a second-order statement. It examines one complex moment.

A centered complex law is **circularly symmetric** when

\[
e^{i\theta}(Z-m)\stackrel{d}{=}Z-m
\qquad\text{for every }\theta\in\mathbb R.
\]

This is a full-law statement. It asks whether every measurable event keeps the
same probability after every rotation.

### What implication is safe

If a centered finite-second-moment law is circularly symmetric, then it is
proper. Rotating by a phase multiplies the pseudocovariance by
\(e^{2i\theta}\); invariance for every angle forces that number to vanish.

The converse fails for arbitrary distributions. A zero pseudocovariance does
not fix higher moments or the full angular distribution. One can arrange
non-circular discrete laws whose second moment happens to cancel.

Within a centered Gaussian family, the story is stronger. A Gaussian law is
determined by its first and second-order real data. Properness removes the
directional second-order imbalance, and the resulting centered law is
circularly symmetric. In the Cartesian scalar case, the density above makes
the implication visible: equal component variances reduce the exponent to a
function of \(|z-m|\) alone.

### Centered circularity is not origin circularity

If \(m\ne0\), the centered variable \(Z-m\) may be circularly symmetric, but
the law of \(Z\) is generally not invariant under multiplication by a phase
about the origin. The rotation moves the mean. A careful statement says either
"circularly symmetric about zero" or "the centered law is circularly
symmetric."

### The project name refuses to overclaim

The Lean measure is called <code>cartesianComplexGaussian</code>, not
<code>circularComplexGaussian</code> or
<code>properComplexGaussian</code>. Unequal component variances are allowed,
and no circularity or properness predicate appears in the module. The name
records exactly what is proved: a product in Cartesian coordinates followed by
a real-linear equivalence.

## A worked anisotropic example

Take

\[
m=1-2i,
\qquad
v_{\mathrm R}=4,
\qquad
v_{\mathrm I}=\frac14.
\]

Then the coordinate laws are

\[
\operatorname{Re}Z\sim\gamma_{1,4},
\qquad
\operatorname{Im}Z\sim\gamma_{-2,1/4},
\]

and they are independent. The planar density is

\[
f(x+iy)
=\frac{1}{2\pi}
 \exp\!\left(
  -\frac{(x-1)^2}{8}
  -2(y+2)^2
 \right).
\]

The coefficient is \(1/(2\pi\sqrt{4\cdot1/4})=1/(2\pi)\).
The real standard deviation is \(2\); the imaginary standard deviation is
\(1/2\). Thus the density is much wider horizontally than vertically.

The second-order ledger is

\[
C_Z
=4+\frac14
=\frac{17}{4},
\qquad
P_Z
=4-\frac14
=\frac{15}{4}.
\]

The nonzero pseudocovariance certifies that this Cartesian Gaussian is
improper and not circularly symmetric. No plot is needed to infer that
directional imbalance because the exact law already supplies the variances.

## The normalization pass: two common circular laws

Let \(U,V\) be independent real standard Gaussians, each with mean zero and
variance one.

### Unit total squared magnitude

Define

\[
Z_{\mathrm{unit}}
=\frac{U+iV}{\sqrt2}.
\]

Then

\[
v_{\mathrm R}=v_{\mathrm I}=\frac12,
\qquad
C_Z=1,
\qquad
P_Z=0,
\]

and

\[
f_{\mathrm{unit}}(z)
=\frac1\pi e^{-|z|^2}.
\]

Many probability, communications, and random-matrix texts use a notation such
as \(\mathcal{CN}(0,1)\) for this total-second-moment convention.

### Unit component variances

Define instead

\[
Z_{\mathrm{component}}=U+iV.
\]

Now

\[
v_{\mathrm R}=v_{\mathrm I}=1,
\qquad
C_Z=2,
\qquad
P_Z=0,
\]

and

\[
f_{\mathrm{component}}(z)
=\frac1{2\pi}e^{-|z|^2/2}.
\]

Both laws are proper and circularly symmetric. They differ by the deterministic
factor \(\sqrt2\). A theorem or model that says only "standard complex
Gaussian" leaves this factor unresolved.

The {{< refterm "normalization-convention" "normalization convention" >}}
entry turns this comparison into a reusable ledger. The current formalization
keeps \(v_{\mathrm R}\) and \(v_{\mathrm I}\) as separate public parameters
and deliberately does not bless either symmetric branch as the matrix-entry
convention.

## High camp: exact law before qualitative Gaussianity

Mathlib defines a Gaussian measure on a real Banach space by asking that every
continuous real-linear functional push it forward to a real Gaussian measure.
The complex numbers form a two-dimensional real Banach space, so this
definition applies to measures on \(\mathbb C\).

The product of two real Gaussian measures is Gaussian on
\(\mathbb R\times\mathbb R\). Mapping that product through the continuous
real-linear equivalence \(\Phi\) preserves qualitative Gaussianity. Therefore
\(\Gamma^{\mathrm{cart}}_{m;v_{\mathrm R},v_{\mathrm I}}\) is Gaussian in
Mathlib's sense for every nonnegative variance pair, including the degenerate
branches.

That qualitative property is valuable, but it forgets the explicit Cartesian
parameters. The project therefore keeps this order:

\[
\text{exact Cartesian law with two variances}
\quad\Longrightarrow\quad
\text{qualitative Gaussian law on }\mathbb C.
\]

It does not use the qualitative predicate to guess a decomposition or a
normalization.

## The Lean construction, one layer at a time

The module
<code>NonlinearDynamics.Random.ComplexGaussian</code> begins with the exact
measure:

~~~lean
noncomputable def cartesianComplexGaussian
    (m : ℂ) (vRe vIm : ℝ≥0) : Measure ℂ :=
  ((gaussianReal m.re vRe).prod (gaussianReal m.im vIm)).map
    Complex.equivRealProdCLM.symm
~~~

The type \(\mathbb R_{\ge0}\), written <code>ℝ≥0</code>, prevents negative
variances. The map is the inverse of the real-coordinate equivalence, so it
sends \((x,y)\) to \(x+iy\).

### Measure-level declarations

| Declaration | Checked statement |
|---|---|
| <code>cartesianComplexGaussian</code> | defines the pushforward of the product of exact real Gaussian measures |
| <code>instIsProbabilityMeasureCartesianComplexGaussian</code> | the resulting measure has total mass one |
| <code>instIsGaussianCartesianComplexGaussian</code> | the measure is Gaussian on the real Banach space underlying \(\mathbb C\) |
| <code>cartesianComplexGaussian_map_equivRealProd</code> | mapping back to ordered real coordinates recovers the defining product measure |
| <code>cartesianComplexGaussian_map_re</code> | the real marginal is exactly \(\gamma_{m_{\mathrm R},v_{\mathrm R}}\) |
| <code>cartesianComplexGaussian_map_im</code> | the imaginary marginal is exactly \(\gamma_{m_{\mathrm I},v_{\mathrm I}}\) |
| <code>cartesianComplexGaussian_zero_variances</code> | the double-zero branch is exactly \(\delta_m\) |

The map-back theorem is the structural center. The two marginal theorems are
its coordinate shadows. The zero-variance theorem works measure-first, so it
never invokes a singular density formula.

### The exact random-variable predicate

The project then defines

~~~lean
def HasCartesianComplexGaussianLaw
    (Z : Ω → ℂ) (m : ℂ) (vRe vIm : ℝ≥0)
    (P : Measure Ω) : Prop :=
  HasLaw Z (cartesianComplexGaussian m vRe vIm) P
~~~

Mathlib's <code>HasLaw</code> contains two fields:

1. <code>AEMeasurable Z P</code>, meaning that \(Z\) agrees almost everywhere
   with a measurable map; and
2. the exact pushforward identity
   <code>P.map Z = cartesianComplexGaussian m vRe vIm</code>.

It does not provide ordinary <code>Measurable Z</code>. Changing a function on
a null set leaves its law unchanged, so this law-level interface intentionally
lives at the almost-everywhere layer.

### Consequences of the exact predicate

| Declaration | Checked statement |
|---|---|
| <code>HasCartesianComplexGaussianLaw</code> | packages the exact <code>HasLaw</code> statement |
| <code>HasCartesianComplexGaussianLaw.aemeasurable</code> | exposes almost-everywhere measurability |
| <code>HasCartesianComplexGaussianLaw.isProbabilityMeasure</code> | the source measure \(P\) is a probability measure |
| <code>HasCartesianComplexGaussianLaw.jointHasLaw</code> | the real-imaginary pair has the exact product law |
| <code>HasCartesianComplexGaussianLaw.real_hasLaw</code> | the real coordinate has its exact project-level real Gaussian law |
| <code>HasCartesianComplexGaussianLaw.imag_hasLaw</code> | the imaginary coordinate has its exact project-level real Gaussian law |
| <code>HasCartesianComplexGaussianLaw.indep_re_im</code> | the coordinate functions satisfy <code>IndepFun</code> under \(P\) |
| <code>HasCartesianComplexGaussianLaw.hasGaussianLaw</code> | forgets explicit parameters into qualitative Gaussianity |
| <code>HasCartesianComplexGaussianLaw.memLp</code> | \(Z\in L^p(P)\) for every extended exponent \(p\ne\infty\), including Mathlib's \(p=0\) case |
| <code>HasCartesianComplexGaussianLaw.integrable</code> | the complex-valued variable is integrable |
| <code>HasCartesianComplexGaussianLaw.mean_eq</code> | the Bochner integral of \(Z\) equals \(m\) |
| <code>HasCartesianComplexGaussianLaw.ae_eq_const_of_variances_zero</code> | at two zero variances, \(Z=m\) almost everywhere |
| <code>HasCartesianComplexGaussianLaw.of_indep_re_im</code> | independent exact real Gaussian coordinates assemble the exact complex law |

These seven measure-level declarations plus the predicate and its twelve
namespace declarations are the module's twenty public declarations.

## Independence without invented measurability assumptions

The constructor has the exact shape

~~~lean
theorem HasCartesianComplexGaussianLaw.of_indep_re_im
    {X Y : Ω → ℝ}
    (hX : HasRealGaussianLaw X m.re vRe P)
    (hY : HasRealGaussianLaw Y m.im vIm P)
    (hXY : IndepFun X Y P) :
    HasCartesianComplexGaussianLaw
      (fun ω ↦ X ω + Y ω * Complex.I) m vRe vIm P
~~~

There are no separate assumptions <code>Measurable X</code> or
<code>Measurable Y</code>. Each exact real <code>HasLaw</code> supplies the
almost-everywhere measurability needed by the law-composition theorems.

This is compatible with Mathlib's definition of <code>IndepFun</code>.
Independence of functions is independence of the two measurable spaces pulled
back along those functions using <code>MeasurableSpace.comap</code>. The
property does not itself assert that either function is measurable from the
ambient measurable space on \(\Omega\). When almost-everywhere measurability is
needed to identify the joint pushforward law, the two exact law hypotheses
supply it.

The proof proceeds in two conceptual steps:

1. <code>hXY.hasLaw_prod hX hY</code> proves that
   \(\omega\mapsto(X(\omega),Y(\omega))\) has the product law;
2. composition with <code>Complex.equivRealProdCLM.symm</code> turns the pair
   into \(X+iY\) and maps the product to
   <code>cartesianComplexGaussian</code>.

This is the proof-level version of the glossary figure: establish the joint
coordinate law, then change representation.

## Analytic consequences and their exact boundary

The module obtains finite \(L^p\) membership and integrability from
qualitative <code>HasGaussianLaw</code>. The statement

~~~text
MemLp Z p P for every p != infinity
~~~

includes every positive finite moment order and Mathlib's special \(p=0\)
case. It does not claim essential boundedness, which would correspond to
\(p=\infty\). Positive-variance Gaussian laws have unbounded support.

The mean theorem proves a complex Bochner integral identity by applying
<code>Complex.ext</code> and reducing to the already checked real and imaginary
mean theorems. Integrability justifies moving each coordinate through the
integral.

The module stops before a named complex variance. That is intentional.
Mathlib's real <code>variance</code> API and the signal-processing quantities
\(C_Z\) and \(P_Z\) have different types and conventions. A future formal
layer must define the desired complex second moments explicitly, prove their
integrability, and then establish the sum and difference formulas.

### Reproduce the check

From the repository root:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/ComplexGaussian.lean
~~~

To run the whole proof-to-prose gate, including Hugo drafts:

~~~sh
make check
~~~

The commands check the file that exists in the repository. No ellipses in this
chapter are presented as executable Lean.

## The deliberate RMT-03 boundary before a family

The single-coordinate layer provides:

- an exact complex probability measure with explicit component variances;
- exact real, imaginary, and joint coordinate laws;
- independence of the two Cartesian coordinates;
- a constructor from independent exact real Gaussian variables;
- qualitative Gaussianity on \(\mathbb C\);
- finite moments, integrability, and exact mean;
- line-supported and point-mass degeneracies; and
- no hidden selection between the two common circular scales.

It does not itself provide:

- a preferred symmetric variance pair;
- a formal pseudocovariance or properness predicate;
- a proof of circular symmetry;
- a complex density theorem;
- a family of mutually independent complex coordinates;
- a Hermitian matrix constructor;
- a Gaussian unitary ensemble law;
- unitary invariance;
- eigenvalue measurability;
- expected trace moments; or
- an asymptotic spectral theorem.

{{< panel "info" >}}
**Current continuation.** The subsequent
<code>NonlinearDynamics.Random.ComplexGaussianFamilies</code> module now
provides mutually independent finite complex coordinates, their exact product
law, coordinatewise real scaling, a canonical product sample space, and the
empty-index Dirac boundary. It still does not choose a matrix normalization or
construct a Gaussian unitary ensemble.
{{< /panel >}}

A complex matrix law adds diagonal and off-diagonal roles, conjugate
reflection, dimension scaling, and a zero-size policy. In a Hermitian matrix,
the lower-triangular entries are not independent primitive degrees of freedom:
conjugate symmetry determines them from the upper triangle. A later constructor
must select primitive coordinates first and reflect them second.

The normalization ledger must then state, at minimum:

| Slot | Required decision |
|---|---|
| Matrix size | index type, dimension, and the zero-dimensional policy |
| Diagonal coordinates | exact real mean and variance |
| Off-diagonal coordinates | exact real-part and imaginary-part means and variances |
| Independence | exactly which primitive upper-triangular coordinates are mutually independent |
| Hermitian reflection | how lower-triangular entries are determined |
| Matrix scaling | every dimension-dependent factor |
| Trace convention | raw trace or normalized trace |
| Spectral target | intended eigenvalue scale |

The word "Gaussian" fills none of these matrix slots by itself.

## Common wrong turns

| Wrong turn | Why it fails | Correct layer |
|---|---|---|
| "Both coordinates are Gaussian, so they are independent" | marginals do not determine a coupling | state or prove the joint product law |
| "Complex variance is one obvious number" | component variances, total squared magnitude, and pseudocovariance differ | publish a normalization ledger |
| "Equal variances imply circularity" | not for an arbitrary non-Gaussian joint law | require the full Gaussian product structure |
| "Proper means circular by definition" | properness is second-order; circularity is distributional | use the Gaussian implication only with its hypotheses |
| "A nonzero mean circular Gaussian is origin invariant" | rotations move the mean | center first or state symmetry about \(m\) |
| "The density works at zero variance" | singular laws have no planar density | use the measure definition and Dirac branches |
| "HasLaw proves ordinary measurability" | it stores only almost-everywhere measurability | keep the layers distinct |
| "HasGaussianLaw remembers the component variances" | it is qualitative | retain the exact Cartesian predicate |
| "Standard complex Gaussian fixes the scale" | unit total spread and unit component spread differ by \(\sqrt2\) | keep both variances explicit |
| "A complex coordinate already defines GUE" | a matrix ensemble needs many additional choices and proofs | complete the matrix ledger first |

## Summit checklist

- [ ] The complex law is defined as a measure, not only by a positive-density
      formula.
- [ ] The real and imaginary means and variances are explicit.
- [ ] Independence is encoded in the joint law, not inferred from marginals.
- [ ] Every zero-variance branch has a support description.
- [ ] Total centered squared magnitude and pseudocovariance are not conflated.
- [ ] Properness and circular symmetry are defined at their correct levels.
- [ ] A nonzero mean is centered before claiming phase invariance.
- [ ] Any "unit" or "standard" scale states whether it is per component or
      total.
- [ ] Lean claims are limited to the twenty declarations in the checked module.
- [ ] Density, symmetry, matrix, spectral, and asymptotic claims are not
      attributed to Lean before they are formalized.

## Where to continue

Use the linked glossary as a concept map:

- {{< refterm "cartesian-complex-gaussian-law" "Cartesian complex Gaussian law" >}}
  for the compact exact definition and branch table;
- {{< refterm "independent-cartesian-complex-gaussian-family" "Independent Cartesian complex Gaussian family" >}}
  for the checked indexed bundle and dependence contract;
- {{< refterm "gaussian-distribution" "Gaussian distribution" >}} for each
  real coordinate and its zero-variance Dirac branch;
- {{< refterm "independence" "independence" >}} for product-law
  factorization;
- {{< refterm "variance" "variance" >}} for squared spread and finite-moment
  hypotheses;
- {{< refterm "normalization-convention" "normalization convention" >}} for
  the scale ledger; and
- {{< refterm "probability-law" "probability law" >}} and
  {{< refterm "pushforward-measure" "pushforward measure" >}} for the
  underlying measure transport.

The earlier chapter
[Gaussian Laws, Independence, and Normalization]({{< relref "/knowledge-base/deep-dives/gaussian-laws-independence-and-normalization" >}})
constructs the exact real laws and finite product machinery used here.
[Finite Product Probability Spaces and Independent Gaussian Fields]({{< relref "/knowledge-base/deep-dives/finite-product-probability-spaces-and-independent-gaussian-fields" >}})
continues from one complex coordinate to exact finite field laws, canonical
sample spaces, scaling, and the cross-family independence audit.
[Random Matrices: From Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}})
explains the measurable matrix, Hermitian, law, and trace-observable layers that
a future Gaussian matrix constructor must join.

## References

**Mathlib contributors.**
[Complex numbers as a real normed space](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Complex/Basic.html),
Mathlib 4 documentation. This official API documents
<code>Complex.equivRealProdCLM</code>, its inverse, and the continuous real and
imaginary coordinate maps.

**Mathlib contributors.**
[Gaussian distributions over the reals](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
Mathlib 4 documentation. This is the exact source for the two coordinate
measures, their variances, transformations, moments, and Dirac boundary.

**Mathlib contributors.**
[Gaussian distributions in Banach spaces](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Basic.html),
Mathlib 4 documentation. This defines a Gaussian measure through all
continuous real-linear functionals and proves preservation under continuous
linear maps and products.

**Mathlib contributors.**
[Gaussian random variables](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/HasGaussianLaw/Basic.html),
Mathlib 4 documentation. This is the official API for qualitative Gaussian
laws, finite \(L^p\) membership, integrability, and continuous linear maps.

**Mathlib contributors.**
[Law of a random variable](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/HasLaw.html),
Mathlib 4 documentation. This documents the almost-everywhere measurability
and pushforward identity stored by <code>HasLaw</code>.

**Mathlib contributors.**
[Independence of functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Independence/Basic.html),
Mathlib 4 documentation. This documents the comap-based definition of
<code>IndepFun</code> and its product-law characterization.

**Nathaniel R. Goodman.**
[Statistical Analysis Based on a Certain Multivariate Complex Gaussian Distribution](https://doi.org/10.1214/aoms/1177704250),
*The Annals of Mathematical Statistics* 34 (1963), 152-177. This primary
historical source develops a circular complex multivariate Gaussian family. It
does not determine the normalization chosen by this project.

**F. D. Neeser and J. L. Massey.**
[Proper Complex Random Processes with Applications to Information Theory](https://doi.org/10.1109/18.243446),
*IEEE Transactions on Information Theory* 39 (1993), 1293-1302. This primary
source separates covariance from pseudocovariance and defines properness by
vanishing pseudocovariance.

**Bernard Picinbono.**
[Second-Order Complex Random Vectors and Normal Distributions](https://doi.org/10.1109/78.539051),
*IEEE Transactions on Signal Processing* 44 (1996), 2637-2640. This primary
source explains why covariance alone is insufficient for general complex
second-order Gaussian structure.

The exact upstream Lean source audited for this chapter is Mathlib commit
[`81a5d257`](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the dependency revision recorded in <code>formalization/lake-manifest.json</code>.
