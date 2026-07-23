---
title: "Complex Gaussian Coordinates in Lean: Cartesian Laws Without Hidden Symmetry"
slug: "complex-gaussians-from-independent-real-coordinates"
date: 2026-07-21
weight: 20
author: "tdj28"
summary: "A declaration-by-declaration ascent from two exact independent real Gaussian laws to a complex law with explicit coordinate variances, finite moments, degenerate cases, and no unearned circular or GUE convention."
lead: |
  A complex Gaussian is not one parameter wearing an imaginary unit. It is a two-dimensional real law whose coordinate variances, independence, and geometry must be stated. This module builds that law exactly, retains anisotropic and degenerate cases, and stops before circular symmetry or a GUE normalization can slip in by name.
key_result: |
  Lean now has an exact Cartesian complex Gaussian measure obtained by mapping a product of real Gaussian measures into the complex plane. Its real and imaginary marginals, their independence, the complex mean, all finite moments, and the double-degenerate Dirac case are checked. A constructor also turns any two independent real variables with the requested exact laws into the corresponding complex variable without assuming ordinary measurability that the theorem does not need.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "First complex-probability intuition to formal random-matrix foundations"
reading_time: "60 to 80 minutes"
prerequisites:
  - "Real and imaginary parts of a complex number"
  - "Basic probability vocabulary; the measure-theoretic distinctions are developed here"
  - "The Gaussian Primitives notebook is helpful but not required"
lean_module: "NonlinearDynamics.Random.ComplexGaussian"
lean_source: "formalization/NonlinearDynamics/Random/ComplexGaussian.lean"
tags:
  - "Lean 4"
  - "Complex Gaussian distributions"
  - "Probability laws"
  - "Independence"
  - "Random matrices"
  - "GUE foundations"
og_image: "complex-gaussian-card.png"
og_image_alt: "Warm-paper teaching card showing independent real and imaginary Gaussian coordinates mapped into an anisotropic complex-plane ellipse, with no circular-symmetry claim."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted teaching draft. The human author
has not yet inspected and accepted the exposition, sources, equations, Lean
artifacts, exercises, or generated social card. The canonical teaching-only
AI-use disclosure is therefore intentionally pending because its human-
inspection clause is not yet true. Scientific-integrity and zero-context
expert-reader reviews are also pending. This page is published as an open
working note while all named reviews remain pending.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** `ComplexGaussian.lean` defines a probability measure on
\(\mathbb C\) by taking the product of two real Gaussian measures and mapping
the pair \((x,y)\) to \(x+iy\). The mean \(m\in\mathbb C\) and the two
coordinate variances \(v_{\mathrm{Re}},v_{\mathrm{Im}}\in\mathbb R_{\ge 0}\)
remain visible in the public interface.

The checked consequences include exact real and imaginary marginal laws,
independence of those coordinates, real-vector-space Gaussianity, every
non-infinite `MemLp` exponent, integrability, the complex expectation, and
almost-everywhere constancy when both variances vanish. A converse constructor
packages independent real variables with exact Gaussian laws into the same
complex law.

**Takeaway.** "Cartesian complex Gaussian" means exactly what the constructor
proves: independent Gaussian coordinates in the chosen real-imaginary axes. It
does not silently mean circular, proper, isotropic, standard, or GUE-normalized.
{{< /panel >}}

This is the code companion to
`formalization/NonlinearDynamics/Random/ComplexGaussian.lean`. Every named
declaration in that file is explained below. The compiler-checked source is
the authority whenever prose notation abbreviates a Lean type.

The reusable probability background lives in
[Gaussian Laws, Independence, and Normalization]({{< relref "/knowledge-base/deep-dives/gaussian-laws-independence-and-normalization" >}}).
The geometric continuation is
[Complex Gaussian Coordinates and Geometry]({{< relref "/knowledge-base/deep-dives/complex-gaussian-coordinates-and-geometry" >}}).
Useful compact entries include
{{< refterm "gaussian-distribution" "Gaussian distribution" >}},
{{< refterm "variance" >}}, {{< refterm "independence" >}},
{{< refterm "normalization-convention" "normalization convention" >}}, and
{{< refterm "cartesian-complex-gaussian-law" "Cartesian complex Gaussian law" >}}.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First complex-probability encounter | [Base camp](#base-camp-one-complex-number-two-real-coordinates) | See a complex variable as a two-dimensional real random vector |
| Measure-theory route | [Build the law](#camp-one-build-the-law-before-naming-the-variable) | Follow product measure, measurable map, and exact marginals |
| Lean route | [Declaration map](#the-entire-lean-file-as-a-declaration-map) | Match every theorem to its upstream proof engine |
| Geometry route | [What Cartesian structure entails](#what-cartesian-structure-entails-and-what-it-does-not) | Separate an axis-aligned ellipse from circular or proper symmetry |
| Physics route | [Quadratures and matrix entries](#why-physicists-care-about-the-variance-split) | Connect coordinate variances to complex amplitudes and future GUE entries |
| Edge-case route | [Degenerate laws](#camp-four-the-degenerate-cases-are-part-of-the-space) | Understand line-supported and point-supported Gaussians |

### Learning objectives

By the summit, a reader should be able to:

1. construct a complex law by mapping a product law through the real-linear
   equivalence \(\mathbb R^2\simeq\mathbb C\);
2. explain why `cartesianComplexGaussian m vRe vIm` exposes two variances;
3. distinguish the law of a complex variable from a sample map into
   \(\mathbb C\);
4. recover exact real and imaginary marginal laws by mapping back through
   coordinate projections;
5. explain why marginal laws alone do not prove independence;
6. interpret `HasGaussianLaw Z P` over \(\mathbb C\) as real-vector-space
   Gaussianity;
7. derive finite moments, integrability, and expectation from the exact law;
8. explain the line-supported and double-degenerate cases without dividing by
   a variance;
9. state exactly what `of_indep_re_im` assumes about two source variables;
10. distinguish Cartesian, circular, proper, and isotropic language;
11. compute the normalization ledger for the two common equal-variance choices;
12. identify every theorem still required before an object may be called GUE.

## The construction in one picture

{{< mermaid >}}
flowchart LR
  A["real Gaussian for the real coordinate"] --> C["product law on an ordered pair"]
  B["real Gaussian for the imaginary coordinate"] --> C
  C --> D["continuous real-linear equivalence"]
  D --> E["exact Cartesian law on the complex plane"]
  E --> F["recover exact real marginal"]
  E --> G["recover exact imaginary marginal"]
  E --> H["recover coordinate independence"]
  E --> I["real-vector-space Gaussianity and finite moments"]
  J["equal coordinate variances"] -. "future symmetry theorem" .-> K["circular centered law"]
  L["matrix variance ledger"] -. "future ensemble theorem" .-> M["GUE law"]
{{< /mermaid >}}

<p class="figure-note"><strong>Reading the proof graph.</strong> The solid
arrows are the current checked interface: product real laws are transported to
the complex plane, and the exact coordinate facts can be recovered. The dotted
arrows are deliberately absent. Equal variances suggest additional rotational
geometry, while a matrix ledger can eventually support GUE, but neither claim
is made by this module.</p>

## Why a complex Gaussian needs two coordinates

A real Gaussian variable lives on a line. A complex Gaussian variable lives on
a plane. Writing

\[
  Z=X+iY
\]

identifies that plane with two real coordinate axes. The formula is elementary,
but its probabilistic content is not. One must still say:

- the law of \(X\);
- the law of \(Y\);
- whether \(X\) and \(Y\) are independent;
- whether their variances are equal;
- which convention turns those coordinate variances into a complex scale; and
- what happens when one or both variances are zero.

The phrase "complex Gaussian" is used with several conventions across
probability, statistics, signal processing, and random-matrix physics. The
classical multivariate setting already makes the complex structure explicit
([Goodman 1963](#ref-goodman-1963)). A
formal interface should therefore preserve the raw facts before introducing a
convenience name. This module chooses the descriptive adjective *Cartesian*:
the law is built in a named pair of axes from independent real Gaussian
coordinates.

That choice is intentionally broader than the most familiar circular complex
normal. If the coordinate variances differ, contours are ellipses rather than
circles. If one variance vanishes, the law is supported on a line. If both
vanish, it is supported at a single point. All three situations are legitimate
values of the same parameterized measure.

## Lineage, local contribution, and nonclaims

Product measures, Gaussian measures on real normed spaces, measurable linear
images, and independence are established mathematics. The repository pins
Mathlib 4.32.0 at a specific commit
([Mathlib release](#ref-mathlib-release)), which supplies the foundational
theorems. The project module does not reprove the Gaussian
integral, derive a bivariate density, or develop characteristic functions from
scratch.

The local contribution is a random-matrix-facing interface:

- an exact complex measure with named mean and separate coordinate variances;
- an exact-law predicate around that measure;
- forward construction from the product of real laws;
- backward recovery of the pair law and both marginals;
- a theorem recording independence of real and imaginary parts;
- qualitative Gaussianity over the real vector space \(\mathbb C\);
- finite-moment, integrability, and complex-mean consequences;
- explicit double-degenerate Dirac and almost-everywhere-constant behavior;
- and a constructor from arbitrary independent real variables with exact laws.

### Not claimed

- `Cartesian` does not mean circular symmetry under multiplication by every
  complex phase.
- `Cartesian` does not mean properness or vanishing pseudo-covariance.
- Unequal coordinate variances are not rejected or normalized away.
- No density formula on \(\mathbb C\) is introduced.
- No complex variance notation is selected.
- No covariance matrix or pseudo-covariance API is introduced.
- No ordinary measurability of the source variables is inferred from `HasLaw`.
- No matrix, Hermitian ensemble, Wigner matrix, or GUE law is constructed.
- No diagonal or off-diagonal dimension scaling is selected.
- No unitary invariance, eigenvalue law, trace expectation, or asymptotic result
  follows from this file.

## Base camp: one complex number, two real coordinates

Every \(z\in\mathbb C\) has unique coordinates

\[
  z=\operatorname{Re}(z)+i\operatorname{Im}(z).
\]

The library represents this decomposition as a continuous real-linear
equivalence:

```lean
Complex.equivRealProdCLM : ℂ ≃L[ℝ] ℝ × ℝ
```

Its forward direction sends \(z\) to `(z.re, z.im)`. Its inverse sends a pair
`p` to `p.1 + p.2 * Complex.I`. The `CLM` suffix signals continuous linear
structure. That one object provides several facts the probability proof needs:

1. it is a bijection;
2. both directions are real-linear;
3. both directions are continuous;
4. therefore both directions are Borel measurable; and
5. qualitative Gaussianity is preserved under this equivalence.

This equivalence and its inverse formula are part of Mathlib's checked complex
analysis API ([Mathlib complex source](#ref-mathlib-complex)). This is more
than a convenient conversion function. It says that complex
Gaussianity in this file is Gaussianity on the two-dimensional real normed
space underlying \(\mathbb C\). The definition does not assume complex
linearity.

{{< panel "info" >}}
**The scalar field matters.** A real continuous linear functional on
\(\mathbb C\) may inspect a real combination of both coordinates. Saying the
complex variable has `HasGaussianLaw` means every such real linear projection
has a real Gaussian law. It is stronger than saying only `Z.re` and `Z.im` are
separately Gaussian, unless the joint structure is also controlled.
{{< /panel >}}

## Camp one: build the law before naming the variable

Fix a complex mean \(m\) and two nonnegative real variances
\(v_{\mathrm{Re}}\) and \(v_{\mathrm{Im}}\). The coordinate measures are
Mathlib's exact variance-parameterized real Gaussians
([Mathlib real Gaussians](#ref-mathlib-gaussian-real)). First build the product
measure

\[
  \gamma
  =\mathcal N\!\left(\operatorname{Re}m,v_{\mathrm{Re}}\right)
   \otimes
   \mathcal N\!\left(\operatorname{Im}m,v_{\mathrm{Im}}\right)
\]

on \(\mathbb R\times\mathbb R\). Mathlib's `Measure.prod` supplies the exact
measure construction and marginal theorems
([Mathlib product measures](#ref-mathlib-product)). Then push it through
\(T(x,y)=x+iy\):

\[
  \operatorname{CG}_{\mathrm{cart}}
    \left(m,v_{\mathrm{Re}},v_{\mathrm{Im}}\right)
  =T_{\#}\gamma.
\]

Here \(T_{\#}\gamma\) means the pushforward measure. For every measurable set
\(A\subseteq\mathbb C\), it assigns the mass
\(\gamma(T^{-1}(A))\).

### `cartesianComplexGaussian`

`cartesianComplexGaussian m vRe vIm` is exactly that mapped product measure.
Its three parameters remain visible. In particular, no function combines
`vRe` and `vIm` into a single ambiguous number called `variance`.

The definition uses `Measure.map` only after supplying a measurable inverse
coordinate equivalence. This matters because Mathlib's `Measure.map` is total:
outside the measurable case it has fallback behavior. The proof never relies
on that fallback.

### `instIsProbabilityMeasureCartesianComplexGaussian`

The named probability instance
`instIsProbabilityMeasureCartesianComplexGaussian` closes the probability
bookkeeping loop. Each real Gaussian is a probability measure. Their product
is a probability measure. Mapping a probability measure through a measurable
function preserves total mass one. Later expectation and `HasGaussianLaw`
theorems can therefore obtain the required typeclass automatically.

This theorem does not say the measure is absolutely continuous. When either
coordinate variance is zero, the measure is singular with respect to
two-dimensional Lebesgue measure, yet it remains a probability measure.

### `cartesianComplexGaussian_map_equivRealProd`

`cartesianComplexGaussian_map_equivRealProd` proves that transporting the
complex law through
`Complex.equivRealProdCLM` recovers the original product of real Gaussian
measures. Conceptually,

\[
  (T^{-1})_{\#}(T_{\#}\gamma)=\gamma.
\]

The proof uses measurability in both directions and the inverse laws of the
equivalence. This is the central audit theorem for the definition: the mapped
measure has not forgotten or mixed the two coordinates.

### `cartesianComplexGaussian_map_re` and `cartesianComplexGaussian_map_im`

The two coordinate map declarations `cartesianComplexGaussian_map_re` and
`cartesianComplexGaussian_map_im` prove

\[
  (\operatorname{Re})_{\#}
  \operatorname{CG}_{\mathrm{cart}}(m,v_{\mathrm{Re}},v_{\mathrm{Im}})
  =\mathcal N(\operatorname{Re}m,v_{\mathrm{Re}}),
\]

and

\[
  (\operatorname{Im})_{\#}
  \operatorname{CG}_{\mathrm{cart}}(m,v_{\mathrm{Re}},v_{\mathrm{Im}})
  =\mathcal N(\operatorname{Im}m,v_{\mathrm{Im}}).
\]

The map-back theorem exposes the product law; `Measure.map_fst_prod` and
`Measure.map_snd_prod` then recover its marginals. These are exact statements,
not merely assertions that the coordinates are qualitatively Gaussian.

### `instIsGaussianCartesianComplexGaussian`

`instIsGaussianCartesianComplexGaussian` records that the exact Cartesian
measure is also Gaussian as a measure on the real normed
space \(\mathbb C\). Mathlib defines this measure class through every real
continuous linear projection
([Mathlib Gaussian measures](#ref-mathlib-gaussian-basic)). The proof starts
with the product of two Gaussian real
measures and transports Gaussianity through the continuous real-linear
equivalence.

This theorem is geometric but parameter-forgetting. It enables generic
Gaussian tools, while the exact mapped-product definition retains the means,
coordinate variances, and independence needed for matrix construction.

## Camp two: exact law of a complex sample map

A measure on \(\mathbb C\) is not yet a random variable. Let
\((\Omega,\mathcal F,P)\) be a measure space and
\(Z:\Omega\to\mathbb C\) a sample map.

### `HasCartesianComplexGaussianLaw`

`HasCartesianComplexGaussianLaw Z m vRe vIm P` abbreviates the exact statement

```lean
HasLaw Z (cartesianComplexGaussian m vRe vIm) P
```

The predicate records two things inherited from `HasLaw`
([Mathlib law API](#ref-mathlib-haslaw)):

1. `Z` is almost-everywhere measurable under `P`;
2. pushing `P` forward through `Z` gives exactly the requested Cartesian law.

The second item is stronger than separately naming the two marginal laws. It
fixes the joint distribution, including independence.

### `HasCartesianComplexGaussianLaw.aemeasurable`

The `aemeasurable` declaration exposes the first `HasLaw` field. It returns
`AEMeasurable Z P`, not `Measurable Z`.

Almost-everywhere measurability is the right law-level notion because changing
`Z` on a `P`-null set should not change its probability law. Ordinary
measurability is a stronger pointwise statement and is not fabricated by this
wrapper.

### `HasCartesianComplexGaussianLaw.isProbabilityMeasure`

The source-normalization declaration proves that an exact Cartesian complex
Gaussian law forces `P` to be a probability measure. The target law has mass
one, and equality of pushforward laws transports that mass back to the source.

As in the real primitive, this is a consequence of the exact law, not a global
assumption baked into the predicate's definition.

## Camp three: recover the coordinates and their dependence

The exact complex law contains a complete statement about the ordered pair
`(Z.re, Z.im)`. The next declarations unpack it at progressively smaller
scales.

### `HasCartesianComplexGaussianLaw.jointHasLaw`

`HasCartesianComplexGaussianLaw.jointHasLaw` states that

```lean
fun omega => ((Z omega).re, (Z omega).im)
```

has the product law

```lean
(gaussianReal m.re vRe).prod (gaussianReal m.im vIm)
```

under `P`. It composes the exact law of `Z` with the forward
`Complex.equivRealProdCLM` map, then simplifies using the map-back theorem.

This theorem is the strongest coordinate-level statement in the file. The
marginal and independence declarations can be read as projections of it.

### `HasCartesianComplexGaussianLaw.real_hasLaw`

`HasCartesianComplexGaussianLaw.real_hasLaw` yields

```lean
HasRealGaussianLaw (fun omega => (Z omega).re) m.re vRe P
```

It may be proved by composing the joint pair law with `Prod.fst`, or by
composing `Z` directly with `Complex.re` and applying the measure-level map
theorem. Either path preserves a.e. measurability and identifies the exact
pushforward law.

### `HasCartesianComplexGaussianLaw.imag_hasLaw`

`HasCartesianComplexGaussianLaw.imag_hasLaw` is the parallel theorem for
`Complex.im`:

```lean
HasRealGaussianLaw (fun omega => (Z omega).im) m.im vIm P
```

The separate theorem is not redundant. Random-matrix code will later assign
different variance schedules to real and imaginary coordinates, and it should
be able to retrieve each schedule directly.

### `HasCartesianComplexGaussianLaw.indep_re_im`

`HasCartesianComplexGaussianLaw.indep_re_im` proves

```lean
IndepFun (fun omega => (Z omega).re)
  (fun omega => (Z omega).im) P
```

The proof uses the exact product joint law and Mathlib's law-level
characterization of independent functions
([Mathlib independence API](#ref-mathlib-independence)). This is the right logical
direction: a product joint law entails independence. Merely knowing that each
marginal is Gaussian would not.

For example, if \(X\) is a real Gaussian and \(Y=X\), then both coordinates
have Gaussian marginals but are maximally dependent. The product-law theorem
rules that example out.

{{< panel "info" >}}
**Independence is not ordinary measurability.** Mathlib formulates `IndepFun`
through the sigma-algebras pulled back by the two functions. The later
constructor assumes exact `HasLaw` hypotheses and `IndepFun`; it does not add
ordinary `Measurable X` or `Measurable Y` assumptions. The exact laws already
supply the a.e. measurability needed for law transport.
{{< /panel >}}

## Camp four: Gaussian consequences in the complex plane

### `HasCartesianComplexGaussianLaw.hasGaussianLaw`

The qualitative declaration drops the explicit parameters and proves

```lean
HasGaussianLaw Z P
```

for the real normed vector space \(\mathbb C\). Any real continuous linear
functional applied to `Z` therefore has a real Gaussian law.

The exact predicate should remain the default while normalization information
matters. The qualitative theorem is the bridge to Mathlib's general Gaussian
integrability and linear-image API.

### `HasCartesianComplexGaussianLaw.memLp`

For every extended exponent `p` with `p ≠ ⊤`, the `memLp` declaration proves

```lean
MemLp Z p P
```

This includes every finite positive moment exponent and Mathlib's special
`p = 0` case. It excludes `p = ∞`, because a nondegenerate Gaussian variable
is not essentially bounded.

The proof does not integrate a two-dimensional density in this project. It
passes through `hasGaussianLaw` and reuses Mathlib's general Gaussian moment
theorem ([Mathlib Gaussian variables](#ref-mathlib-hasgaussian)).

### `HasCartesianComplexGaussianLaw.integrable`

Integrability is the \(L^1\) specialization needed to define the Bochner
expectation

\[
  \int_\Omega Z(\omega)\,dP(\omega).
\]

The theorem follows from the finite-moment result, but it deserves a named
declaration because later matrix-entry and trace arguments will require
`Integrable` directly.

### `HasCartesianComplexGaussianLaw.mean_eq`

`HasCartesianComplexGaussianLaw.mean_eq` proves

\[
  \int_\Omega Z\,dP=m.
\]

This is a vector-valued integral in \(\mathbb C\). The proof can be audited
coordinatewise: the exact real-part law gives mean `m.re`, the exact
imaginary-part law gives mean `m.im`, and equality of complex numbers follows
from equality of both coordinates.

No single scalar called "complex variance" appears. The file has established
the expectation while continuing to store second-order scale as the ordered
pair `(vRe, vIm)`.

## Camp five: the degenerate cases are part of the space

### `cartesianComplexGaussian_zero_variances`

At the measure level, `cartesianComplexGaussian_zero_variances` proves

\[
  \operatorname{CG}_{\mathrm{cart}}(m,0,0)=\delta_m.
\]

Each real Gaussian becomes a Dirac measure at its coordinate mean. Their
product is the Dirac measure at `(m.re, m.im)`, and the inverse coordinate map
sends that pair to `m`.

This is not a density theorem with a limiting argument. It is an exact identity
at the boundary of the nonnegative variance parameters.

### `HasCartesianComplexGaussianLaw.ae_eq_const_of_variances_zero`

`HasCartesianComplexGaussianLaw.ae_eq_const_of_variances_zero` proves that an
exact law with both
variances zero satisfies

\[
  Z(\omega)=m
  \quad\text{for }P\text{-almost every }\omega.
\]

It does not claim pointwise equality. A random variable may differ from `m` on
a null set while retaining the same Dirac law.

### One zero variance

There is no special theorem that discards the cases `(vRe, 0)` or `(0, vIm)`.
That omission is a feature. The general definition already handles them:

- if `vIm = 0`, the law lies on the horizontal line with imaginary coordinate
  `m.im`;
- if `vRe = 0`, the law lies on the vertical line with real coordinate `m.re`;
- if both are zero, the two lines meet at the Dirac point `m`.

Retaining these cases keeps later coordinate schedules closed under zero
scaling and allows sparse or boundary constructions without a second API.

## Summit construction: start from independent real variables

### `HasCartesianComplexGaussianLaw.of_indep_re_im`

Suppose two real sample maps satisfy exact laws

\[
  X\sim\mathcal N(\operatorname{Re}m,v_{\mathrm{Re}}),
  \qquad
  Y\sim\mathcal N(\operatorname{Im}m,v_{\mathrm{Im}}),
\]

and suppose `IndepFun X Y P`. The constructor proves that

\[
  \omega\longmapsto X(\omega)+iY(\omega)
\]

has `HasCartesianComplexGaussianLaw` with those exact parameters.

The proof has two clean transports:

1. `IndepFun.hasLaw_prod` turns the exact marginal laws and independence into
   the exact product law of `(X, Y)`;
2. `HasLaw.comp` maps that pair law through
   `Complex.equivRealProdCLM.symm`.

The constructor asks for no ordinary `Measurable X` or `Measurable Y`
hypothesis. This is an important difference from the earlier
`IndependentRealGaussianFamily` record, which stores ordinary coordinate
measurability for later pointwise family operations. Here the task is only to
prove a law. The two `HasRealGaussianLaw` hypotheses provide a.e.
measurability, and `IndepFun` provides the dependence structure. The proof
derives `IsProbabilityMeasure P` from `hX` before invoking the finite-measure
product-law API. Its last step uses `HasLaw.congr` to identify the composed
equivalence with the displayed function `X + Y * Complex.I` almost everywhere.

{{< panel "warning" >}}
**Do not strengthen a theorem while explaining it.** It is tempting to call
`X` and `Y` "measurable independent Gaussians." The checked constructor does
not require ordinary measurability. Its exact scope is "independent real
variables with exact Gaussian laws," followed by the precise a.e.
measurability consequence when needed.
{{< /panel >}}

## What Cartesian structure entails, and what it does not

Center the variable by writing

\[
  Z-m=U+iV,
\]

where \(U\) and \(V\) are independent, centered real Gaussians with variances
\(v_{\mathrm{Re}}\) and \(v_{\mathrm{Im}}\). Then

\[
  \mathbb E\lvert Z-m\rvert^2
  =v_{\mathrm{Re}}+v_{\mathrm{Im}}.
\]

This paper calculation helps compare conventions, but the current Lean file
does not package the left-hand side as a named complex variance theorem.

Another diagnostic is the centered pseudo-covariance, also called relation in
some complex second-order literature
([Picinbono 1996](#ref-picinbono-1996)):

\[
  \mathbb E[(Z-m)^2]
  =v_{\mathrm{Re}}-v_{\mathrm{Im}},
\]

because independence and centering remove the mixed term. When the coordinate
variances are equal, this expression vanishes. When they differ, it records
the preferred axes of the ellipse. The current module does not formalize this
identity or define properness, so it is mathematical orientation rather than a
checked project theorem.

The vocabulary ladder is:

| Term | What it should mean here | Established by this file? |
|---|---|---|
| Cartesian | Exact independent real and imaginary Gaussian coordinates in the chosen axes | Yes |
| Isotropic covariance | Equal coordinate variances after centering | The parameters can express it; no named symmetry theorem |
| Proper | Vanishing pseudo-covariance or relation, under the chosen definition | No |
| Circular centered law | Invariance in distribution under every complex phase rotation | No |
| Standard complex Gaussian | A convention-dependent special case | Intentionally unnamed |

For a scalar Gaussian, equal independent centered coordinate variances are the
familiar route to circular symmetry. Still, that implication deserves its own
definition and proof. A name should not perform the proof's work.

## Why anisotropic laws are retained

An anisotropic complex Gaussian has different spreads along the real and
imaginary axes. Its constant-density contours, when both variances are
positive, are axis-aligned ellipses. Retaining this family is useful for more
than generality's sake:

- it makes every normalization choice explicit;
- it supports models with unequal quadrature noise;
- it exposes accidental real-imaginary asymmetry in later matrix entries;
- it keeps degenerate line-supported limits inside the same type;
- and it lets future theorems state equal-variance hypotheses exactly where
  rotational symmetry is used.

If the constructor had accepted only one variance parameter, equal splitting
would already have been chosen. The current three-parameter measure prevents
that hidden decision.

## Why physicists care about the variance split

In wave mechanics and signal processing, a complex amplitude carries two
quadratures. In random-matrix physics, an off-diagonal Hermitian entry also
has two real degrees of freedom, while its conjugate partner is fixed and a
diagonal entry must be real. Dyson's symmetry-class program supplies the
historical matrix-ensemble motivation ([Dyson 1962](#ref-dyson-1962)); it does
not choose the scalar normalization used here.

Two common centered equal-coordinate choices illustrate the convention trap.
Let `U` and `V` be independent real Gaussians.

| Coordinate variances | Resulting second moment | Common informal shorthand |
|---|---|---|
| \(\operatorname{Var}(U)=\operatorname{Var}(V)=1/2\) | \(\mathbb E|U+iV|^2=1\) | Unit complex second moment |
| \(\operatorname{Var}(U)=\operatorname{Var}(V)=1\) | \(\mathbb E|U+iV|^2=2\) | Unit variance per real component |

Both are mathematically coherent. Calling both "standard complex Gaussian"
without a ledger creates a factor-of-two error.

A future Wigner-scaled GUE may use dimension-dependent variances, often with a
real diagonal variance and half-sized real and imaginary off-diagonal
variances. This project has not approved that convention, density exponent,
trace normalization, or zero-dimensional policy. The current module provides
the coordinates needed to state the choice later; it does not make the choice.

## The entire Lean file as a declaration map

| Declaration | Layer | Checked content |
|---|---|---|
| `cartesianComplexGaussian` | Measure definition | Map a product of exact real Gaussian measures into \(\mathbb C\) |
| `instIsProbabilityMeasureCartesianComplexGaussian` | Measure structure | The mapped product has total mass one |
| `instIsGaussianCartesianComplexGaussian` | Measure structure | The law is Gaussian over the real vector space \(\mathbb C\) |
| `cartesianComplexGaussian_map_equivRealProd` | Exact measure identity | Real-imaginary coordinates recover the original product law |
| `cartesianComplexGaussian_map_re` | Exact marginal | Real projection has `gaussianReal m.re vRe` |
| `cartesianComplexGaussian_map_im` | Exact marginal | Imaginary projection has `gaussianReal m.im vIm` |
| `cartesianComplexGaussian_zero_variances` | Degenerate measure | Two zero variances give `Measure.dirac m` |
| `HasCartesianComplexGaussianLaw` | Exact sample-map predicate | `HasLaw` for the Cartesian complex measure |
| `HasCartesianComplexGaussianLaw.aemeasurable` | Measurability | Exposes `AEMeasurable Z P` |
| `HasCartesianComplexGaussianLaw.isProbabilityMeasure` | Source normalization | Exact law forces `P` to have mass one |
| `HasCartesianComplexGaussianLaw.jointHasLaw` | Exact joint law | Coordinate pair has the product law |
| `HasCartesianComplexGaussianLaw.real_hasLaw` | Exact coordinate law | `Z.re` has the named real Gaussian law |
| `HasCartesianComplexGaussianLaw.imag_hasLaw` | Exact coordinate law | `Z.im` has the named real Gaussian law |
| `HasCartesianComplexGaussianLaw.indep_re_im` | Dependence | `Z.re` and `Z.im` are `IndepFun` |
| `HasCartesianComplexGaussianLaw.hasGaussianLaw` | Qualitative class | Every real linear projection is Gaussian |
| `HasCartesianComplexGaussianLaw.memLp` | Moments | `MemLp Z p P` for `p ≠ ⊤` |
| `HasCartesianComplexGaussianLaw.integrable` | Integrability | Complex Bochner integrability |
| `HasCartesianComplexGaussianLaw.mean_eq` | First moment | Integral of `Z` equals `m` |
| `HasCartesianComplexGaussianLaw.ae_eq_const_of_variances_zero` | Degenerate sample map | `Z = m` almost everywhere |
| `HasCartesianComplexGaussianLaw.of_indep_re_im` | Constructor | Independent exact real laws assemble into the complex exact law |

The source names are discussed in the surrounding subsections, and the
proof-to-prose gate checks this final inventory mechanically.

## Proof architecture: a small number of transports

### 1. Product first

The two real Gaussian probability measures are combined with `Measure.prod`.
This supplies the independent joint law before any map into \(\mathbb C\)
occurs.

### 2. Map through an equivalence

`Complex.equivRealProdCLM.symm` is continuous and measurable. `Measure.map`
therefore transports the product law into the complex plane without a density
calculation.

### 3. Map back to audit the definition

`Measure.map_map` and the inverse law for the equivalence recover the original
product. The marginal theorems then use the first and second projections.

### 4. Move between product law and independence

At measure level, a product is independent by construction. At sample-map
level, an exact product joint law implies `IndepFun`. In the constructor,
`IndepFun.hasLaw_prod` runs the bridge in the other direction.

### 5. Forget parameters only when useful

The exact law is converted to `HasGaussianLaw` only to reuse generic Gaussian
theorems such as finite `MemLp`. The public exact predicate remains available
for coordinate arithmetic.

### 6. Prove vector identities by coordinates

The complex mean and the double-zero conclusion reduce to real and imaginary
facts, then close by complex extensionality. This proof style exposes exactly
which coordinate theorem supplies each equality.

## Exact commands: compile, cover, and preview

From the repository root on macOS or Linux:

```sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true NonlinearDynamics/Random/ComplexGaussian.lean
lake build
cd ..
```

The direct `lean` command checks this module with every warning promoted to an
error. `lake build` checks the complete import graph.

Starting from the repository root, build the complete formalization and check
the public teaching content:

```sh
cd formalization
lake build

cd ..
make content-hygiene
make site-check
```

`lake build` checks the complete project import graph. The final two commands
inspect the public teaching content and render the site.

Regenerate the card from any working directory:

```sh
site/content/development-notebook/2026/07/\
complex-gaussians-from-independent-real-coordinates/generate-card.sh
```

The generator resolves its default output beside itself, strips time-dependent
PNG metadata, and checks the dimensions. It can also receive an explicit
output path as its first argument for byte-identity testing.

## Edge-case register

| Situation | What the checked API does | Common wrong inference |
|---|---|---|
| `vRe = 0`, `vIm > 0` | Supports a vertical Gaussian line through `m` | Every complex Gaussian has a planar density |
| `vRe > 0`, `vIm = 0` | Supports a horizontal Gaussian line through `m` | Both coordinates must be nondegenerate |
| `vRe = vIm = 0` | Measure is `dirac m`; sample map equals `m` a.e. | The definition is undefined at zero variance |
| `vRe ≠ vIm` | Keeps an anisotropic Cartesian Gaussian | Gaussianity implies rotational symmetry |
| `vRe = vIm` | Parameters permit isotropy | Circularity is already a checked theorem |
| `p = ∞` | `memLp` theorem does not apply | Gaussian tails imply essential boundedness |
| Null-set modification of `Z` | Exact law can remain unchanged | Equality in law is pointwise equality |
| Exact marginal laws without `IndepFun` | Constructor cannot be used | Gaussian marginals determine a joint law |
| `IndepFun` plus exact marginal laws | Product joint law is available | Ordinary measurability must be added by hand |
| Nonzero mean `m` | Law is centered around `m` | Rotation about the origin preserves the law |
| A future matrix uses these coordinates | Scalar law is available | GUE invariance or normalization follows automatically |

## Failure modes this interface prevents

### Hiding a factor of two

One parameter called "complex variance" may mean total complex second moment
or variance per real component. Separate `vRe` and `vIm` block that ambiguity
at the function boundary.

### Confusing two Gaussian marginals with a Gaussian vector

Dependence can couple Gaussian marginals. The exact product law and `IndepFun`
theorem record the joint structure needed for real-vector-space Gaussianity.

### Promoting a.e. measurability to ordinary measurability

`HasLaw` carries only `AEMeasurable`. The constructor's signature remains as
weak as its law-level proof requires, and the notebook does not narrate a
stronger hypothesis.

### Treating equal variances as a symmetry proof

Equal parameters make a circular theorem plausible, but the project does not
claim invariance under phase multiplication until that map, law equality, and
proof exist in Lean.

### Excluding singular Gaussians

Zero coordinate variances remain legal. This prevents later zero scaling from
escaping the API and keeps boundary cases auditable.

### Calling a scalar primitive GUE

GUE is a law on Hermitian matrices with a normalization and an invariance
statement. One exact complex entry is only raw material.

## Worked normalization ledgers

### Ledger A: unit total complex second moment

Let \(m=0\) and choose

\[
  v_{\mathrm{Re}}=v_{\mathrm{Im}}=\frac12.
\]

Then the paper calculation gives

\[
  \mathbb E|Z|^2=\frac12+\frac12=1.
\]

Each real axis has standard deviation \(1/\sqrt2\). This is one common meaning
of a unit complex Gaussian.

### Ledger B: unit variance on each real component

Let \(m=0\) and choose

\[
  v_{\mathrm{Re}}=v_{\mathrm{Im}}=1.
\]

Then

\[
  \mathbb E|Z|^2=1+1=2.
\]

This is another common meaning of a standard complex Gaussian. Neither ledger
is promoted to a project definition in this module.

### Ledger C: anisotropic diagnostic

Choose \(v_{\mathrm{Re}}=4\) and \(v_{\mathrm{Im}}=1\). The spread along the
real axis is twice the spread along the imaginary axis because standard
deviation is the square root of variance. The total centered second moment is
five, while the informal pseudo-covariance diagnostic is three. This law is
Cartesian Gaussian and non-circular.

These are deductions from the displayed parameters, not empirical results.
Their purpose is to rehearse the ledger that later matrix definitions must
make explicit.

## Exercises

{{< panel "exercise" >}}
**Exercise 1: reconstruct the measure.** Write the three-stage definition of
`cartesianComplexGaussian m vRe vIm`: two real measures, their product, and the
map into \(\mathbb C\). Identify the measurability proof needed at the last
stage.
{{< /panel >}}

{{< panel "exercise" >}}
**Exercise 2: audit a marginal.** Starting from the map-back theorem, compose
with `Prod.fst` and explain why the real-part law is exactly
`gaussianReal m.re vRe` rather than merely some Gaussian measure.
{{< /panel >}}

{{< panel "exercise" >}}
**Exercise 3: dependence counterexample.** Let \(X\) be standard real Gaussian
and set \(Y=X\). Which exact marginal hypotheses hold? Which hypothesis of
`of_indep_re_im` fails? Describe the support of `(X, Y)` in the plane.
{{< /panel >}}

{{< panel "exercise" >}}
**Exercise 4: a line-supported law.** Take `vIm = 0` and `vRe > 0`. State the
imaginary-part law and its a.e. consequence. Why is the complex law still
Gaussian as a real-vector-space law?
{{< /panel >}}

{{< panel "exercise" >}}
**Exercise 5: phase rotation on paper.** For centered independent coordinates
with equal variance, compute the covariance of the real and imaginary parts
after multiplying by a unit complex number. Explain what additional Lean law
equality would be needed to turn the calculation into circular symmetry.
{{< /panel >}}

{{< panel "exercise" >}}
**Exercise 6: convention audit.** A paper says \(Z\) is "standard complex
normal" and later uses \(\mathbb E|Z|^2=1\). Infer the likely coordinate
variances. What must still be checked before translating the paper's notation
into Lean?
{{< /panel >}}

{{< panel "exercise" >}}
**Exercise 7: constructor hypotheses.** Explain why exact `HasRealGaussianLaw`
hypotheses supply a.e. measurability, why `IndepFun` supplies dependence
structure, and why ordinary `Measurable X` is not needed for this law-level
constructor.
{{< /panel >}}

{{< panel "exercise" >}}
**Exercise 8: prepare one Hermitian entry.** Let an upper-triangular matrix
entry use a centered Cartesian law. List the additional definitions and proofs
needed to reflect it into the lower triangle, prove Hermiticity, select a
dimension scaling, and identify the resulting matrix law.
{{< /panel >}}

## The next ridge: from one complex coordinate to a matrix ensemble

The next layer is a finite family of scaled Gaussian coordinates and a
measurable assembly map into Hermitian matrices. It needs:

1. finite labels for diagonal and upper-triangular primitive coordinates;
2. exact real laws for diagonal entries;
3. exact Cartesian complex laws for off-diagonal entries;
4. mutual independence of the primitive family;
5. conjugate reflection into the lower triangle;
6. ordinary measurability of the assembled matrix-valued map;
7. pointwise Hermiticity;
8. scalar and finite-product integrability sufficient for matrix observables;
9. an approved dimension-dependent normalization ledger; and
10. an explicit policy for the zero-dimensional matrix.

Only after those facts are fixed can the project name a GUE constructor. Even
then, the law's invariance under deterministic unitary conjugation is a theorem
to prove, not a consequence of the constructor's name. The earlier
`RandomMatrices.Laws` module supplies the target language for that theorem.

## Summit register

The module reaches a precise intermediate summit. An exact probability measure
on \(\mathbb C\) is constructed from two named real Gaussian measures and a
continuous real-linear equivalence. Mapping back recovers the product law;
projecting recovers exact marginals; the joint product entails independence.

For a sample map with this law, Lean exposes a.e. measurability, source
normalization, real-vector-space Gaussianity, every finite `MemLp` exponent,
integrability, the complex expectation, and double-zero a.e. constancy. The
constructor from independent exact real laws closes the loop from reusable
real primitives to one complex coordinate.

The summit is intentionally not circular and not GUE. The visible variance
split keeps anisotropic, line-supported, and point-supported laws available.
That restraint is what makes the next normalization decision reviewable.

## References

The technical references below were opened and checked against official
Mathlib documentation and pinned source on 2026-07-21. The complex-normal and
random-matrix references link to original journal records.

<a id="ref-mathlib-release"></a>
**Mathlib contributors.**
[Mathlib 4.32.0 release](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
commit
[`81a5d257c8e410db227a6665ed08f64fea08e997`](https://github.com/leanprover-community/mathlib4/commit/81a5d257c8e410db227a6665ed08f64fea08e997).
This is the exact library revision pinned by the repository.

<a id="ref-mathlib-haslaw"></a>
**Mathlib contributors.**
[Law of a random variable](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/HasLaw.html),
with
[pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Probability/HasLaw.lean).
This is the primary API source for `HasLaw`, a.e. measurability,
`IndepFun.hasLaw_prod`, and composition of exact laws.

<a id="ref-mathlib-gaussian-real"></a>
**Mathlib contributors.**
[Real Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
with
[pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Probability/Distributions/Gaussian/Real.lean).
This is the primary API source for exact real Gaussian laws, probability
normalization, moments, and the zero-variance Dirac case.

<a id="ref-mathlib-gaussian-basic"></a>
**Mathlib contributors.**
[Gaussian measures in Banach spaces](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Basic.html),
with
[pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Probability/Distributions/Gaussian/Basic.lean).
This is the primary API source for Gaussian measures defined through all real
continuous linear projections.

<a id="ref-mathlib-hasgaussian"></a>
**Mathlib contributors.**
[Gaussian random variables](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/HasGaussianLaw/Basic.html),
with
[pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Probability/Distributions/Gaussian/HasGaussianLaw/Basic.lean).
This is the primary API source for `HasGaussianLaw`, transport through
continuous linear equivalences, finite `MemLp`, and integrability.

<a id="ref-mathlib-product"></a>
**Mathlib contributors.**
[Product measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Prod.html),
with
[pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/Prod.lean).
This is the primary API source for `Measure.prod`, probability preservation,
and exact first and second marginals.

<a id="ref-mathlib-independence"></a>
**Mathlib contributors.**
[Independence of functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Independence/Basic.html),
with
[pinned source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Probability/Independence/Basic.lean).
This is the primary API source for `IndepFun` and the product-joint-law
characterization.

<a id="ref-mathlib-complex"></a>
**Mathlib contributors.**
[Complex continuous-linear equivalence source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Complex/Basic.lean#L132-L137).
This is the primary source for `Complex.equivRealProdCLM` and the formula for
its inverse.

<a id="ref-goodman-1963"></a>
**N. R. Goodman.**
[Statistical Analysis Based on a Certain Multivariate Complex Gaussian
Distribution (An Introduction)](https://doi.org/10.1214/aoms/1177704250),
*The Annals of Mathematical Statistics* 34(1), 152-177, 1963. This original
article is cited for the classical complex multivariate Gaussian setting, not
as a warrant that the current Lean law is circular or proper.

<a id="ref-picinbono-1996"></a>
**Bernard Picinbono.**
[Second-Order Complex Random Vectors and Normal
Distributions](https://doi.org/10.1109/78.539051),
*IEEE Transactions on Signal Processing* 44(10), 2637-2640, 1996. This
peer-reviewed article is cited for the need to track relation or
pseudo-covariance information in complex second-order statistics.

<a id="ref-dyson-1962"></a>
**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems.
I](https://doi.org/10.1063/1.1703773),
*Journal of Mathematical Physics* 3, 140-156, 1962. This original article is
cited only for the historical symmetry-class motivation. It does not supply a
GUE theorem for the current scalar module.
