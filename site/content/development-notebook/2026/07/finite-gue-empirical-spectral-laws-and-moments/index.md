---
title: "Finite Gaussian Unitary Ensemble Spectral Laws in Lean: Random Measures, Barycenters, and Normalized Moments"
slug: "finite-gue-empirical-spectral-laws-and-moments"
date: 2026-07-21
weight: -30
author: "tdj28"
summary: "A declaration-complete account of the finite Wigner-scaled Gaussian unitary ensemble (GUE) empirical spectral law: raw and probability-valued law packages, the mean empirical measure, exact zero-dimensional behavior, and the first two normalized spectral-moment expectations."
lead: |
  One matrix has an empirical spectral measure. A random matrix makes that measure random, so its distribution is a law on measures. Averaging that law produces yet another measure on the real line. RMT-10C formalizes all three layers for the finite Gaussian unitary ensemble (GUE) and proves that the expected first normalized spectral moment is zero, while the expected second is one in every positive dimension.
key_result: |
  Lean now names the finite Gaussian unitary ensemble (GUE) pushforward law of empirical spectral measures, proves it is an outer probability law in every dimension, gives a stricter probability-measure-valued package in positive dimension, and forms its barycenter with Mathlib's Giry join. Sample spectral moments one and two are exactly normalized trace and normalized trace square. Their GUE expectations are zero and the total all-dimension expression n⁻¹n, which is zero at dimension zero and one in every positive dimension.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Finite random measures, Giry probability, Bochner integrability, and normalized GUE spectral moments"
reading_time: "85 to 115 minutes"
prerequisites:
  - "Decreasing finite Hermitian eigenvalues with multiplicity"
  - "Zero-aware empirical spectral measures"
  - "Measurability of the Hermitian spectrum map"
  - "The intrinsic and ambient finite GUE laws"
  - "Exact integrable GUE trace moments one and two"
  - "No prior Lean proof experience required"
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleSpectrum"
lean_source: "formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleSpectrum.lean"
tags:
  - "Lean 4"
  - "Gaussian unitary ensemble"
  - "Empirical spectral law"
  - "Random measure"
  - "Giry monad"
  - "Barycenter"
  - "Normalized spectral moment"
  - "Wigner normalization"
og_image: "finite-gue-empirical-spectral-laws-and-moments-card.png"
og_image_alt: "Warm-paper teaching card showing a sample Hermitian matrix becoming an empirical spectral measure, then a probability law over measures, then a mean measure; the footer states that the expected first normalized moment is zero and the expected second is one in positive dimension, with no limiting law claimed."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed Research Note. Verify claims against the cited primary
sources and any released artifacts before relying on them.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This teaching chapter is published as an open working
note while human
editorial acceptance and the separate scientific-integrity and zero-context
expert-reader reviews are pending. The checked Lean source is authoritative
for every theorem statement.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** Earlier milestones constructed a Wigner-scaled finite Gaussian
unitary ensemble (GUE), proved its intrinsic and ambient presentations agree,
computed its first two trace expectations, defined the ordered Hermitian
spectrum, and made the resulting empirical spectral measure unconditionally
measurable. RMT-10C composes those interfaces into the first named finite-GUE
spectral law.

The module distinguishes four types that informal prose often collapses. A
matrix sample is an intrinsic Hermitian point. Its empirical spectral measure
is a measure on the real line. The distribution of that random measure is a
measure on the space of measures. The Giry join of that distribution is the
mean empirical spectral measure back on the real line. The raw law is an outer
probability measure in every dimension, including dimension zero, where it is
the Dirac mass at the zero measure. Only positive-dimensional samples are
themselves probability measures, so only there does Lean construct a law
valued in <code>ProbabilityMeasure ℝ</code>.

For one sample, the first two complex moments of the empirical spectral
measure are the reciprocal-dimension normalized trace and normalized trace
square. The source then transports RMT-09's Bochner integrability and exact
trace integrals from the ambient matrix law to the intrinsic law. The expected
first moment is zero in every dimension. The expected second moment is
\[
  ((n:\mathbb R)^{-1}:\mathbb C)(n:\mathbb C),
\]
so Lean's total inverse convention makes the zero-dimensional value zero and
the successor-dimensional theorem exactly one.

No density, joint eigenvalue formula, Vandermonde determinant, higher moment,
moment of the barycenter, concentration estimate, semicircle law, convergence
rate, or universality theorem is asserted.
{{< /panel >}}

This is the proof-to-prose companion for
<code>formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleSpectrum.lean</code>.
It maps all twenty-one public declarations and the one private helper in source
order.

The immediate predecessor,
[Hermitian Spectral Stability in Lean]({{< relref "/development-notebook/2026/07/hermitian-spectral-perturbation-and-measurability" >}}),
made the empirical spectral measure measurable and proved the unconditional
ambient-versus-intrinsic pushforward bridge. The sample spectral identities
come from
[Ordered Hermitian Spectra in Lean]({{< relref "/development-notebook/2026/07/ordered-hermitian-spectra-and-empirical-measures" >}}),
while the ensemble integrals come from
[The First Exact GUE Trace Moments in Lean]({{< relref "/development-notebook/2026/07/gue-first-exact-trace-moments" >}}).
The parallel textbook treatment is
[Finite Gaussian Unitary Ensemble Empirical Spectral Laws and Normalized Moments]({{< relref "/knowledge-base/deep-dives/finite-gue-empirical-spectral-laws-and-normalized-moments" >}}).

Reusable definitions appear under
{{< refterm "empirical-spectral-measure" >}},
{{< refterm "empirical-spectral-law" >}},
{{< refterm "probability-law" >}},
{{< refterm "pushforward-measure" >}},
{{< refterm "finite-matrix-trace-moment" >}},
{{< refterm "gaussian-unitary-ensemble" >}},
{{< refterm "normalization-convention" >}}, and
{{< refterm "measurable-space" >}}.

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| First encounter | [Four objects, four types](#four-objects-four-types) | Stop confusing a sample measure, its law, and its mean |
| Spectral route | [Moments of one realized spectrum](#moments-of-one-realized-spectrum) | Recover normalized traces from finite atoms |
| Probability route | [A probability law over raw measures](#a-probability-law-over-raw-measures) | Understand why the outer law is probabilistic even at dimension zero |
| Positive-dimension route | [A law whose values are probability measures](#a-law-whose-values-are-probability-measures) | See the stricter successor-only package |
| Giry route | [Averaging a law of measures](#averaging-a-law-of-measures) | Read the mean empirical measure as a barycenter |
| Integration route | [Transporting integrability from ambient matrices](#transporting-integrability-from-ambient-matrices) | Follow the bridge from RMT-09 trace moments |
| Normalization route | [Why the second expected moment is one](#why-the-second-expected-moment-is-one) | Audit the all-dimension expression and Wigner scale |
| Lean route | [The complete declaration map](#the-complete-declaration-map) | Inspect all twenty-one public declarations and the private helper |
| Integrity route | [Strict nonclaims](#strict-nonclaims) | Separate this finite layer from density and asymptotic theory |

### Learning objectives

By the summit, a reader should be able to:

1. distinguish a Hermitian matrix sample from its empirical spectral measure;
2. distinguish a random measure from the pushforward law of that random
   measure;
3. distinguish a law on measures from its Giry barycenter;
4. explain why a probability law may be concentrated on an object that is not
   itself a probability measure;
5. state the project's zero-dimensional empirical-measure policy;
6. explain why the raw spectral law exists in every natural dimension;
7. explain why the probability-measure-valued law is successor-only;
8. read both similarly named probability wrappers from their Lean types;
9. derive the first sample spectral moment from the trace identity;
10. derive the second sample spectral moment from the trace-square identity;
11. explain why every sample moment is zero at dimension zero;
12. transport integrability through an equality of pushforward laws;
13. separate <code>integrable_map_measure</code> from
    <code>integral_map</code>;
14. derive the expected first normalized spectral moment from the centered
    trace theorem;
15. derive the all-dimension second expectation
    \(((n:\mathbb R)^{-1}:\mathbb C)(n:\mathbb C)\);
16. simplify that expression to one only after assuming positive dimension;
17. explain why the mean empirical measure has mass one in positive dimension;
18. state what the module does not prove about moments of that mean measure;
19. compile the module and inspect its public API; and
20. identify the next mathematical layers required for finite densities or
    large-dimension limits.

### Lineage, contribution, and boundary

Normalized trace powers and empirical spectral measures are standard
random-matrix tools. Guionnet's ICM survey states their classical connection
under the Wigner-scaled GUE convention
([Guionnet, 2022](#ref-guionnet-2022)). This chapter does not claim to invent
that mathematics.

The local contribution is a declaration-complete Lean interface that composes
the project's already checked ingredients: a measurable ordered spectrum, an
intrinsic finite-GUE probability law, an ambient law bridge, and integrable
trace moments. It makes the four object types explicit, freezes the
zero-dimensional policy, and proves the exact finite expectations. It does not
derive a density or an asymptotic law; [Strict nonclaims](#strict-nonclaims)
records the boundary in full.

## Four objects, four types

The central lesson is a type ladder. Let \(H\) be one intrinsic Hermitian
matrix of size \(n\). RMT-10A assigns it the empirical spectral measure
\[
  \mu_H=\frac1n\sum_{i=0}^{n-1}\delta_{\lambda_i(H)}
\]
when \(n\) is positive, with multiplicity retained. The project deliberately
sets \(\mu_H=0\) when \(n=0\).

Now sample \(H\) from the intrinsic finite-GUE law \(\gamma_n\). The map
\(H\mapsto\mu_H\) is a random variable whose codomain happens to be a space of
measures. Its law is
\[
  \mathcal L_n=(H\mapsto\mu_H)_*\gamma_n.
\]
Thus \(\mathcal L_n\) is not a measure on eigenvalue locations. It is a
measure on possible measures on eigenvalue locations.

Finally, the barycenter averages those output measures:
\[
  \overline\mu_n=\operatorname{join}(\mathcal L_n).
\]
This returns to a measure on \(\mathbb R\). On a measurable set \(S\), the
Giry join is characterized by
\[
  \overline\mu_n(S)=\int \mu(S)\,d\mathcal L_n(\mu).
\]
The right side averages how much mass each sampled spectral measure assigns to
\(S\).

| Mathematical object | Lean shape | Where it lives |
|---|---|---|
| Matrix sample \(H\) | <code>HermitianEuclidean n</code> | Intrinsic Hermitian Euclidean space |
| Sample empirical measure \(\mu_H\) | <code>Measure ℝ</code> | Measures on the real line |
| Spectral law \(\mathcal L_n\) | <code>Measure (Measure ℝ)</code> | Measures on the space of measures |
| Mean empirical measure \(\overline\mu_n\) | <code>Measure ℝ</code> | Back on the real line |

{{< mermaid >}}
flowchart LR
  H["one intrinsic Hermitian matrix"] --> M["one empirical spectral measure"]
  G["intrinsic finite GUE law"] --> P["push forward by the measurable spectrum map"]
  M --> P
  P --> L["probability law over measures"]
  L --> J["Giry join averages the random measures"]
  J --> B["mean empirical measure on the real line"]
{{< /mermaid >}}

<p class="figure-note"><strong>Figure.</strong> The first arrow changes one
matrix into one finite atomic measure. Pushforward remembers the full
sample-to-sample distribution of those measures. Giry join then averages that
distribution and discards its higher-order variability. The final measure is
not the same object as the law over measures.</p>

This ladder is not bureaucracy. A law retains fluctuations among spectra. A
barycenter does not. Two ensembles can have the same mean empirical measure
and different distributions of gaps, extreme eigenvalues, or linear
statistics. RMT-10C names both objects so later work cannot silently substitute
one for the other.

## Moments of one realized spectrum

The first public declaration is
<code>RandomMatrix.empiricalSpectralMoment</code>. For a natural exponent
\(k\), it defines
\[
  m_k(H)=\int_{\mathbb R}(x:\mathbb C)^k\,d\mu_H(x).
\]
The codomain is complex because it aligns with the existing complex
trace-power observable. Every eigenvalue is real, so these particular values
are real inside \(\mathbb C\), but the module does not add a separate theorem
expressing that reality.

For positive dimension, expanding the atomic measure gives
\[
  m_k(H)=\frac1n\sum_{i=0}^{n-1}\lambda_i(H)^k.
\]
RMT-10C exports only the cases needed to consume the checked trace integrals:
\[
  m_1(H)=((n:\mathbb R)^{-1}:\mathbb C)\operatorname{Tr}(H),
\]
and
\[
  m_2(H)=((n:\mathbb R)^{-1}:\mathbb C)\operatorname{Tr}(H^2).
\]

The Lean proofs do not reprove the spectral theorem. They unfold the empirical
measure as a scalar multiple of the counting measure, move that scalar through
the integral, and invoke RMT-10A:

- <code>integral_complex_ofReal_spectralCountingMeasure</code> turns the first
  counting-measure integral into the matrix trace;
- <code>integral_sq_complex_ofReal_spectralCountingMeasure</code> turns the
  second into the trace of the square.

Those predecessor identities ultimately sit on Mathlib's finite Hermitian
spectral API ([Mathlib Hermitian spectra](#ref-mathlib-spectrum)).

The public theorems
<code>RandomMatrix.empiricalSpectralMoment_one</code> and
<code>RandomMatrix.empiricalSpectralMoment_two</code> are stated for every
natural dimension. At \(n=0\), both right sides contain a total field inverse
of zero, which is zero, and the zero matrix has zero trace. The equalities
therefore remain exact without an informal division by zero.

### The zero-dimensional moment policy

<code>RandomMatrix.empiricalSpectralMoment_zero</code> is stronger than the
first two formulas. It proves that every exponent gives zero when the matrix
dimension is zero:
\[
  m_k(H)=0.
\]
The reason is measure-theoretic, not a convention about \(0^0\). The
zero-dimensional empirical spectral measure is the zero measure, and every
integral against the zero measure is zero. In particular, the zeroth moment is
zero at dimension zero, rather than the mass-one value familiar from a
probability measure.

{{< panel "info" >}}
**The zeroth moment exposes the policy.** In positive dimension,
\(m_0(H)=1\) because the empirical measure has mass one. At dimension zero,
the project chose the zero measure, so \(m_0(H)=0\). RMT-10C proves the latter
through the all-exponent zero theorem. It does not export a named
positive-dimensional zeroth-moment theorem.
{{< /panel >}}

## A probability law over raw measures

The definition <code>GUE.empiricalSpectralLaw</code> is the exact pushforward
\[
  \mathcal L_n=(\operatorname{empiricalSpectralMeasure})_*\gamma_n,
\]
where \(\gamma_n=\operatorname{GUE.intrinsicLaw}(n)\). RMT-10B supplied
ordinary measurability of the map, so the definition carries no analytic
hypothesis.

Its codomain is <code>Measure (Measure ℝ)</code>. The inner
<code>Measure ℝ</code> is intentionally raw. It includes both mass-one
measures from positive dimensions and the zero measure selected at dimension
zero.

The instance
<code>GUE.instIsProbabilityMeasureEmpiricalSpectralLaw</code> says that
\(\mathcal L_n\) has total outer mass one for every \(n\). Pushforward preserves
the total mass of the intrinsic GUE probability law. This statement does not
say that every point in the support of \(\mathcal L_n\) is itself a probability
measure.

That distinction is clearest at dimension zero:
\[
  \mathcal L_0=\delta_0.
\]
The Dirac measure \(\delta_0\) is an outer probability measure concentrated at
the zero measure. Its sampled value \(0:\operatorname{Measure}(\mathbb R)\)
has total mass zero. Outer probability and inner probability are separate
claims.

<code>GUE.empiricalSpectralLawProbability</code> merely bundles this
all-dimensional outer result:
\[
  \operatorname{ProbabilityMeasure}(\operatorname{Measure}(\mathbb R)).
\]
It changes the Lean type so probability-law APIs can consume the object. It
does not change the points from raw measures into probability measures.

## A law whose values are probability measures

Positive dimension supports a stricter construction.
<code>GUE.empiricalSpectralProbabilityLaw n</code> samples a matrix of size
\(n+1\), applies the bundled map
<code>empiricalSpectralProbability n</code>, and returns
\[
  \operatorname{ProbabilityMeasure}
    (\operatorname{ProbabilityMeasure}(\mathbb R)).
\]
Now both levels are certified:

1. the outer distribution has total mass one; and
2. every value carries an inner total-mass-one proof in its type.

The successor index is not a cosmetic way to avoid a proof branch. No bundled
<code>ProbabilityMeasure ℝ</code> can represent the zero measure chosen at
dimension zero. The all-dimension raw law and the successor-only bundled law
are therefore both necessary.

The theorem
<code>GUE.map_empiricalSpectralProbabilityLaw_coe</code> proves that forgetting
the inner probability wrapper recovers
<code>GUE.empiricalSpectralLaw (n + 1)</code>. Its proof composes two
measurable maps:

1. a matrix becomes a bundled empirical probability measure;
2. subtype coercion forgets the bundle and returns the underlying raw measure.

<code>Measure.map_map</code> collapses the two pushforwards. The composition is
definitionally the raw empirical spectral measure. This theorem is an exact
compatibility bridge, not a claim that the zero-dimensional raw law can be
upgraded.

| Name | Outer package | Inner values | Dimensions |
|---|---|---|---|
| <code>empiricalSpectralLaw</code> | Raw <code>Measure</code>, with a probability instance | Raw measures | All \(n\) |
| <code>empiricalSpectralLawProbability</code> | Bundled <code>ProbabilityMeasure</code> | Raw measures | All \(n\) |
| <code>empiricalSpectralProbabilityLaw</code> | Bundled <code>ProbabilityMeasure</code> | Bundled probability measures | Sizes \(n+1\) |

The similar names encode genuinely different types. Reading only their English
glosses is risky. When debugging downstream Lean code, inspect the complete
codomain first.

## Intrinsic and ambient laws agree

The spectral law is defined using <code>GUE.intrinsicLaw</code>, whose samples
are Hermitian by type. Existing applications may instead start from
<code>GUE.matrixLaw</code> on the full ambient complex matrix space. RMT-10B
defined a total observable
<code>ambientEmpiricalSpectralMeasure n</code>: it recovers the intrinsic
matrix when the input is Hermitian and otherwise uses the project's zero
fallback.

<code>GUE.empiricalSpectralLaw_eq_map_matrixLaw_ambient</code> proves
\[
  \mathcal L_n
  {} =
  (\operatorname{ambientEmpiricalSpectralMeasure}(n))_*
    \operatorname{matrixLaw}(n).
\]
The proof is a one-line orientation of RMT-10B's unconditional pushforward
bridge. It shows that the newly named law is compatible with both established
GUE presentations.

The theorem does not say the ambient fallback is a spectral theory for
non-Hermitian matrices. The ambient GUE law gives the Hermitian locus full
measure, so the fallback has no effect on the pushforward law. Off that
almost-sure support it remains a totalization device.

## Dimension zero, audited end to end

The dimension-zero branch is visible at every layer:

| Layer | Checked value at \(n=0\) | Reason |
|---|---|---|
| Intrinsic empirical measure | Zero measure | No eigenvalue indices and explicit zero-aware normalization |
| Any sample spectral moment | Zero | Integral against the zero measure |
| Spectral law | Dirac at the zero measure | Pushforward of the zero-dimensional intrinsic Dirac law |
| Outer law mass | One | A Dirac measure is a probability measure |
| Probability-valued spectral law | Not constructed | The inner zero measure is not a probability measure |
| Mean empirical measure | Zero measure | Giry join of a Dirac mass at zero |
| Expected first moment | Zero | Centered trace identity, also the sample zero theorem |
| Expected second moment | Zero | Total expression \(0^{-1}0=0\) in the field |

The theorem <code>GUE.empiricalSpectralLaw_zero</code> proves the Dirac row.
It maps the zero-dimensional intrinsic Dirac law through the measurable
empirical-measure map and simplifies the unique output to the zero measure.

The theorem <code>GUE.meanEmpiricalSpectralMeasure_zero</code> then rewrites
the barycenter definition, substitutes the Dirac law, and simplifies its join.
These are not merely consequences left for a reader. They freeze the boundary
policy into named rewrite rules for future modules.

There are two inverse conventions to keep separate. The raw empirical measure
uses an extended-nonnegative scalar. In that type,
\((0:\mathbb R_{\ge0}^{\infty})^{-1}=\infty\), while the empty counting measure
is zero, and the checked measure simplification is \(\infty\cdot0=0\).
The sample trace formulas instead expose the real inverse after
<code>ENNReal.toReal</code>; the real value \(0^{-1}\) is zero. Saying only
"the reciprocal is zero" would conflate those two stages.

## Averaging a law of measures

<code>GUE.meanEmpiricalSpectralMeasure</code> is defined by
\[
  \overline\mu_n=\mathcal L_n.\operatorname{join}.
\]
Mathlib's Giry join flattens a measure of measures into a measure. For a
measurable set \(S\), its evaluation theorem reads as the nonnegative integral
of \(\mu(S)\) over the outer law. This is the precise sense in which the
construction is the mean or barycenter of the random empirical measure
([Mathlib Giry monad](#ref-mathlib-giry)).

At positive dimension, every inner measure has total mass one. The theorem
<code>GUE.meanEmpiricalSpectralMeasure_succ_isProbability</code> proves that
the barycenter also has total mass one. Its proof uses
<code>isProbabilityMeasure_join</code>, whose key premise is that the outer law
lands almost everywhere in the measurable set of probability measures.

The proof establishes that premise under the pushforward by moving the
almost-everywhere statement back to intrinsic matrices. There the pointwise
theorem <code>empiricalSpectralMeasure_succ_isProbability</code> applies to
every sample. This sequence records the real probability logic:

1. each successor-dimensional sample measure is a probability measure;
2. the property is measurable in the Giry space;
3. therefore the pushforward law is almost surely supported on probability
measures;
4. joining an outer probability law with probability-valued support preserves
   total mass one.

The bundled type, measurable support set, and join probability theorem are
documented together in Mathlib's
[probability-measure API](#ref-mathlib-probability).

{{< panel "info" >}}
**A barycenter forgets fluctuations.** The mean measure records expected mass
of measurable sets. It does not retain the distribution of the largest
eigenvalue, correlations between eigenvalues, gap statistics, or variance of
linear statistics. Those live at the law-over-measures layer or in further
pushforwards.
{{< /panel >}}

RMT-10C does not prove an equation identifying the complex moments of
\(\overline\mu_n\) with the expected sample moments below. Such an identity is
mathematically natural but requires the relevant integration-through-join
argument and integrability hypotheses in the exact complex-valued form. The
module keeps its claims at the level actually checked.

## Transporting integrability from ambient matrices

The private helper <code>GUE.ambientTracePower</code> specializes the existing
random-matrix observable to the identity sample map:
\[
  A\longmapsto\operatorname{Tr}(A^k).
\]
It gives the longer polymorphic expression a stable local name. This is the
module's only private declaration.

RMT-09 already proves that ambient trace powers one and two are Bochner
integrable under <code>GUE.matrixLaw n</code>. RMT-10C needs integrability of
the corresponding empirical spectral moment under
<code>GUE.intrinsicLaw n</code>. The bridge is the checked law identity
\[
  \operatorname{matrixLaw}(n)
  {} =
  (\operatorname{hermitianToMatrix})_*\operatorname{intrinsicLaw}(n).
\]

For exponent one, <code>GUE.integrable_empiricalSpectralMoment_one</code>
follows this proof spine:

1. import <code>integrable_tracePower_one n</code> under the ambient law;
2. rewrite the ambient law as the pushforward of the intrinsic law;
3. use <code>integrable_map_measure</code> to transport integrability to
   <code>ambientTracePower n 1 ∘ hermitianToMatrix</code>;
4. multiply by the constant reciprocal dimension;
5. use <code>empiricalSpectralMoment_one</code> to identify the scaled
   composition with the desired sample moment.

The exponent-two theorem
<code>GUE.integrable_empiricalSpectralMoment_two</code> has the same
architecture with RMT-09's second trace-power integrability.

This is not a free consequence of finite dimension. The sample space of
matrices is unbounded, and a continuous polynomial observable need not be
integrable under an arbitrary probability measure. Gaussian moment control,
already established by RMT-09, supplies the finiteness.

Dimension zero gets a more general theorem:
<code>GUE.integrable_empiricalSpectralMoment_zero k</code> covers every
exponent. The function is pointwise zero by
<code>empiricalSpectralMoment_zero</code>, so it rewrites to the integrable
zero function. The companion
<code>GUE.integral_empiricalSpectralMoment_zero k</code> evaluates its
integral as zero.

### Two transport lemmas with different jobs

<code>integrable_map_measure</code> transfers the finiteness property between a
function on the target of a pushforward and its composition on the source.
<code>integral_map</code> evaluates the integral after that transport. The
first prevents a totalized Bochner integral from hiding nonintegrability. The
second changes variables only after its measurability premise is supplied.

The module invokes both explicitly. This keeps expectation theorems from
becoming bare equalities whose finiteness status is invisible.
The underlying change-of-variables and Banach-valued integral interfaces are
documented in Mathlib's [Bochner integration API](#ref-mathlib-bochner).

## The expected first moment is zero

<code>GUE.integral_empiricalSpectralMoment_one n</code> proves
\[
  \int m_1(H)\,d\gamma_n(H)=0
\]
for every natural dimension. Its calculation has four transparent steps:

\[
\begin{aligned}
  \int m_1(H)\,d\gamma_n(H)
  &=
  \int c_n\operatorname{Tr}(H)\,d\gamma_n(H)\\
  &=
  c_n\int\operatorname{Tr}(H)\,d\gamma_n(H)\\
  &=
  c_n\int\operatorname{Tr}(A)\,d\operatorname{matrixLaw}(n)(A)\\
  &=c_n\cdot0=0,
\end{aligned}
\]
where \(c_n=((n:\mathbb R)^{-1}:\mathbb C)\).

The first equality is the sample trace identity. The second pulls a constant
through the Bochner integral. The third is
<code>integral_map</code> along <code>hermitianToMatrix</code>. The fourth uses
RMT-09's exact centered trace integral.

The statement is a first moment of the random empirical measure, averaged over
the intrinsic matrix law. It does not prove that each sample has zero first
moment. Individual matrices generally have nonzero trace. Centering is an
ensemble expectation.

## Why the second expected moment is one

The all-dimensional theorem
<code>GUE.integral_empiricalSpectralMoment_two n</code> proves
\[
  \int m_2(H)\,d\gamma_n(H)
  {} =
  ((n:\mathbb R)^{-1}:\mathbb C)(n:\mathbb C).
\]
The proof mirrors the first-moment calculation but ends with RMT-09's exact
identity
\[
  \int\operatorname{Tr}(A^2)\,
    d\operatorname{matrixLaw}(n)(A)=n.
\]

Why retain the unsimplified product? It is the honest theorem for all natural
dimensions. In Lean's fields, \(0^{-1}=0\), so at \(n=0\) the right side is
zero. For positive \(n\), reciprocal cancellation is valid and the value is
one.

<code>GUE.integral_empiricalSpectralMoment_two_succ n</code> states that
positive-dimensional corollary directly:
\[
  \int m_2(H)\,d\gamma_{n+1}(H)=1.
\]
The proof rewrites with the all-dimensional theorem, coerces the arithmetic,
and invokes inverse cancellation with positivity of \(n+1\).

This value is the finite normalization certificate. RMT-09 proved
\(\mathbb E\operatorname{Tr}(H^2)=n\) for the Wigner-scaled ensemble. Dividing
the spectral sum by the number of eigenvalues gives average squared spectral
location one. It is consistent with an order-one spectral scale, but it does
not identify the distribution of those locations.

{{< panel "warning" >}}
**One moment is not a law.** Mean zero and second moment one are shared by many
probability measures. They do not imply a semicircle density, compact support,
Gaussian eigenvalues, concentration, or convergence as dimension grows.
{{< /panel >}}

## Physics reading: density of states and ensemble disorder

Read \(H\) as a finite Hamiltonian after a choice of energy units. Its
eigenvalues are the allowed energies, repeated by degeneracy. The sample
empirical measure
\[
  \mu_H=\frac1n\sum_i\delta_{\lambda_i(H)}
\]
is the normalized finite density of states: it reports the fraction of energy
levels in each measurable region of the real line.

The law \(\mathcal L_n\) answers a different physical question. If the
Hamiltonian is drawn from an ensemble, how does the entire density-of-states
measure fluctuate from one realization to another? An event in this law can
describe a set of possible empirical measures. The barycenter
\(\overline\mu_n\) instead answers the ensemble-averaged density-of-states
question. It gives expected level mass in an energy window, but it cannot say
whether individual samples fluctuate coherently around that average.

This separation matters in disordered systems and quantum chaos. A mean
density can be smooth even though each finite sample is atomic. It can also be
identical for two ensembles with different level correlations. Repulsion,
gap distributions, and extreme-level fluctuations require more than the
barycenter. The law-over-measures layer is closer to those questions, though
RMT-10C does not yet formalize their observables.

The first sample moment is the energy centroid:
\[
  m_1(H)=\frac1n\operatorname{Tr}(H).
\]
Its ensemble mean zero says that the GUE energy cloud is centered under the
chosen normalization. It does not say each Hamiltonian is traceless. The
second sample moment is the mean squared energy:
\[
  m_2(H)=\frac1n\operatorname{Tr}(H^2).
\]
Its positive-dimensional ensemble mean one calibrates the global quadratic
energy scale. It does not bound every energy by one, determine the spectral
edge, or identify a density.

Unitary conjugation is a change of orthonormal basis for the finite Hilbert
space. Earlier modules prove both unitary invariance of the GUE matrix law and
unitary invariance of the ordered spectrum. Those ingredients explain why the
spectral constructions are physically basis-independent. RMT-10C consumes the
resulting intrinsic law and spectrum map, but it does not export a new named
unitary-invariance theorem for \(\mathcal L_n\).

## The complete declaration map

The module exports twenty-one declarations and keeps one helper private. The
tables follow source order and preserve namespace qualification.

### Public API: sample spectral moments

| Declaration | Exact role | Proof engine |
|---|---|---|
| <code>RandomMatrix.empiricalSpectralMoment</code> | Defines the \(k\)-th complex moment of one zero-aware empirical spectral measure | Bochner integral of the complex-coerced power |
| <code>RandomMatrix.empiricalSpectralMoment_zero</code> | Proves every exponent gives zero in dimension zero | Empirical measure is zero, then integral against zero |
| <code>RandomMatrix.empiricalSpectralMoment_one</code> | Identifies the first sample moment with reciprocal-dimension trace | Unfold normalization and apply the counting-measure trace integral |
| <code>RandomMatrix.empiricalSpectralMoment_two</code> | Identifies the second sample moment with reciprocal-dimension trace square | Unfold normalization and apply the counting-measure square integral |

### Public API: laws and barycenter

| Declaration | Exact role | Proof engine |
|---|---|---|
| <code>GUE.empiricalSpectralLaw</code> | Defines the intrinsic finite-GUE pushforward law on raw empirical measures | <code>intrinsicLaw.map empiricalSpectralMeasure</code> |
| <code>GUE.instIsProbabilityMeasureEmpiricalSpectralLaw</code> | Gives the raw spectral law outer mass one in every dimension | Probability preservation under measurable pushforward |
| <code>GUE.empiricalSpectralLawProbability</code> | Bundles the all-dimensional outer law as a probability measure on raw measures | The preceding probability instance |
| <code>GUE.empiricalSpectralProbabilityLaw</code> | Defines the successor-dimensional outer probability law valued in bundled probability measures | Pushforward through <code>empiricalSpectralProbability</code> |
| <code>GUE.map_empiricalSpectralProbabilityLaw_coe</code> | Shows that forgetting inner probability wrappers recovers the raw successor law | Measurable subtype coercion and <code>Measure.map_map</code> |
| <code>GUE.empiricalSpectralLaw_eq_map_matrixLaw_ambient</code> | Identifies intrinsic and ambient presentations of the named spectral law | RMT-10B's unconditional pushforward bridge |
| <code>GUE.empiricalSpectralLaw_zero</code> | Computes the dimension-zero law as a Dirac mass at the zero measure | Map the intrinsic zero-dimensional Dirac law |
| <code>GUE.meanEmpiricalSpectralMeasure</code> | Defines the barycenter of the raw spectral law | Giry <code>Measure.join</code> |
| <code>GUE.meanEmpiricalSpectralMeasure_zero</code> | Computes the zero-dimensional barycenter as the zero measure | Join the Dirac law at zero |
| <code>GUE.meanEmpiricalSpectralMeasure_succ_isProbability</code> | Proves the positive-dimensional barycenter has total mass one | Almost-sure probability-valued support and <code>isProbabilityMeasure_join</code> |

### Public API: integrability and exact expectations

| Declaration | Exact role | Proof engine |
|---|---|---|
| <code>GUE.integrable_empiricalSpectralMoment_zero</code> | Proves every exponent integrable in dimension zero | Rewrite the observable to the zero function |
| <code>GUE.integral_empiricalSpectralMoment_zero</code> | Evaluates every dimension-zero expected spectral moment as zero | Pointwise zero and <code>integral_eq_zero_of_ae</code> |
| <code>GUE.integrable_empiricalSpectralMoment_one</code> | Proves first sample moments integrable under every intrinsic finite-GUE law | Transport ambient trace integrability and multiply by reciprocal dimension |
| <code>GUE.integral_empiricalSpectralMoment_one</code> | Evaluates the expected first sample moment as zero in every dimension | Sample trace formula, <code>integral_map</code>, and RMT-09 trace centering |
| <code>GUE.integrable_empiricalSpectralMoment_two</code> | Proves second sample moments integrable under every intrinsic finite-GUE law | Transport ambient trace-square integrability and scale |
| <code>GUE.integral_empiricalSpectralMoment_two</code> | Evaluates the all-dimensional expectation as \(n^{-1}n\) | Sample trace-square formula, law transport, and RMT-09 second trace integral |
| <code>GUE.integral_empiricalSpectralMoment_two_succ</code> | Simplifies the positive-dimensional expected second moment to one | All-dimensional identity plus nonzero inverse cancellation |

### Private helper

| Declaration | Proof job |
|---|---|
| <code>GUE.ambientTracePower</code> | Names <code>RandomMatrix.tracePower id k</code> on the ambient \(n\)-by-\(n\) complex matrix carrier so transport calculations remain readable |

The public dependency spine is deliberate. Sample identities come first, then
law packaging and barycenters, then integrability and expectation. Downstream
files can import a named spectral law without inheriting a private proof
representation for trace transport.

## Lean proof engineering

### Why define the raw law before the bundled law?

The zero-aware observable is total in every dimension and naturally lands in
<code>Measure ℝ</code>. Defining its raw pushforward preserves that uniform
interface. Probability structure is then layered on: an outer instance in all
dimensions, an outer bundle in all dimensions, and an inner probability-valued
bundle only for successors.

### Why does the outer law use the intrinsic presentation?

The intrinsic sample space makes Hermiticity true by type and avoids carrying
an almost-everywhere support proof into every later theorem. The ambient
presentation remains available through a named equality, so matrix-law users
lose nothing.

### Why use Giry join instead of an informal expectation symbol?

The output of the random variable is itself a measure. Giry join is Mathlib's
canonical measurable flattening operation. It supplies a set-evaluation
semantics and composes with the existing measure-valued measurable structure.
An overloaded scalar expectation symbol would hide both the codomain and the
required measurability.

### Why prove integrability again after RMT-09?

RMT-09's observable and measure live on the ambient matrix carrier. RMT-10C's
observable and measure live on the intrinsic Hermitian carrier. Their values
are pointwise related, and their laws are connected, but Lean still needs the
explicit transport theorem to move the integrability fact across that bridge.

### Why keep the all-dimensional second expectation unsimplified?

The expression \(n^{-1}n\) displays the exact normalization and handles zero
without a false cancellation. The successor theorem performs cancellation
only where positivity proves the denominator nonzero.

### Why is there no theorem about the barycenter's second moment?

The module proves sample-moment integrability under the matrix law and defines
the measure barycenter. Connecting a complex Bochner moment of the join to an
iterated integral is a further theorem. It should be proved with the precise
integrability and Giry interfaces, not asserted because the notation looks
like expectation.

## How to run the checked source

Compile the module directly with every warning promoted to an error:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleSpectrum.lean
~~~

Build the complete Lean library:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake build
~~~

From the repository root, check the public teaching content:

~~~sh
make content-hygiene
make site-check
~~~

This complete Lean snippet checks every public declaration:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleSpectrum

open Matrix MeasureTheory
open scoped ENNReal Matrix
open NonlinearDynamics.Random

#check RandomMatrix.empiricalSpectralMoment
#check RandomMatrix.empiricalSpectralMoment_zero
#check RandomMatrix.empiricalSpectralMoment_one
#check RandomMatrix.empiricalSpectralMoment_two
#check GUE.empiricalSpectralLaw
#check GUE.instIsProbabilityMeasureEmpiricalSpectralLaw
#check GUE.empiricalSpectralLawProbability
#check GUE.empiricalSpectralProbabilityLaw
#check GUE.map_empiricalSpectralProbabilityLaw_coe
#check GUE.empiricalSpectralLaw_eq_map_matrixLaw_ambient
#check GUE.empiricalSpectralLaw_zero
#check GUE.meanEmpiricalSpectralMeasure
#check GUE.meanEmpiricalSpectralMeasure_zero
#check GUE.meanEmpiricalSpectralMeasure_succ_isProbability
#check GUE.integrable_empiricalSpectralMoment_zero
#check GUE.integral_empiricalSpectralMoment_zero
#check GUE.integrable_empiricalSpectralMoment_one
#check GUE.integral_empiricalSpectralMoment_one
#check GUE.integrable_empiricalSpectralMoment_two
#check GUE.integral_empiricalSpectralMoment_two
#check GUE.integral_empiricalSpectralMoment_two_succ
~~~

Save the snippet inside <code>formalization</code> and run
<code>lake env lean path/to/Scratch.lean</code>. The private helper is
intentionally absent from this import-level API audit.

Useful local Mathlib reconnaissance:

~~~sh
rg -n "def join|join_apply|isProbabilityMeasure_join" \
  formalization/.lake/packages/mathlib/Mathlib/MeasureTheory/Measure

rg -n "integrable_map_measure|theorem integral_map" \
  formalization/.lake/packages/mathlib/Mathlib/MeasureTheory/Integral

rg -n "measurableSet_isProbabilityMeasure" \
  formalization/.lake/packages/mathlib/Mathlib/MeasureTheory/Measure
~~~

The pinned local
[Mathlib 4.32.0 release](#ref-mathlib-release) source is the exact API
authority. Online
documentation is a navigational aid, not a replacement for compiling against
the selected checkout.

## Common failure modes

### Calling a sample empirical measure its law

<code>empiricalSpectralMeasure H</code> has type <code>Measure ℝ</code>.
<code>empiricalSpectralLaw n</code> has type
<code>Measure (Measure ℝ)</code>. Confusing them removes one probability layer
and turns statements about ensemble variability into statements about one
matrix.

### Calling the barycenter the law

<code>meanEmpiricalSpectralMeasure n</code> returns to
<code>Measure ℝ</code>. It averages set masses and forgets the distribution
among sample measures. It cannot answer fluctuation questions that the law
retains.

### Assuming outer probability implies inner probability

At dimension zero, the spectral law is a probability measure concentrated at
the zero measure. The zero measure is not itself a probability measure. The
outer instance does not justify constructing
<code>ProbabilityMeasure ℝ</code> values.

### Swapping the two probability-law wrappers

<code>empiricalSpectralLawProbability</code> bundles only the outer law.
<code>empiricalSpectralProbabilityLaw</code> bundles outer and inner
probability and therefore uses size \(n+1\). Inspect the nested codomain rather
than relying on their similar names.

### Canceling dimension at zero

The all-dimensional second expectation is \(n^{-1}n\), not unconditionally
one. Cancellation requires \(n\ne0\). The successor theorem supplies that
proof and only then concludes one.

### Giving the wrong value to an extended-nonnegative inverse

The scalar in <code>empiricalSpectralMeasure</code> is extended nonnegative.
Its inverse at zero is infinity, not zero. The measure is still zero because
the counting measure is empty and infinity scales the zero measure to zero.
Only after <code>ENNReal.toReal</code> does the normalization appearing in the
complex trace formula become real zero.

### Treating integrability as automatic

Finite matrix dimension does not make an unbounded polynomial observable
integrable under every law. The proof imports Gaussian trace-moment
integrability and transports it across the intrinsic-to-ambient pushforward.

### Reversing <code>integral_map</code>

The source measure is intrinsic and the map is
<code>hermitianToMatrix</code>. After mapping, the integral is under the
ambient matrix law. Reversing that direction produces the wrong composition
and mismatched carrier types.

### Reading the zero policy as a hidden probability completion

The dimension-zero empirical measure is exactly zero. No dummy eigenvalue is
inserted, and no arbitrary probability distribution is selected to fill the
empty spectrum.

### Equating expected sample moments with barycenter moments without proof

The module evaluates integrals of <code>empiricalSpectralMoment</code> under
the intrinsic law. It does not export the corresponding integral against
<code>meanEmpiricalSpectralMeasure</code>. Interchanging the Giry join and a
complex-valued integral remains a separate formal obligation.

### Inferring a density from a named law

A probability law on the measurable space of measures need not admit a
density with respect to any convenient reference measure. Naming the
pushforward and proving its mass do not produce a finite-dimensional
eigenvalue density.

## Strict nonclaims

RMT-10C does **not** prove:

- a joint density for the ordered GUE eigenvalues;
- a matrix-to-eigenvalue change-of-variables theorem;
- a Vandermonde determinant or Jacobian factor;
- absolute continuity of the empirical spectral law;
- a closed-form finite-dimensional mean spectral density;
- a formula for the moments of
  <code>GUE.meanEmpiricalSpectralMeasure</code>;
- equality between a barycenter moment and the expected sample moment;
- integrability or expectation of empirical spectral moments above degree two;
- Wick expansion, pairing enumeration, or Catalan moment formulas;
- variance, covariance, or concentration of spectral linear statistics;
- largest-eigenvalue or smallest-eigenvalue distributions;
- level spacing, repulsion, unfolding, or local correlation functions;
- finite-\(n\) determinantal kernels or Hermite-polynomial formulas;
- compact support of a finite-GUE sample or its mean measure;
- convergence in probability, almost surely, weakly, or in Wasserstein
  distance;
- a semicircle law or a rate of convergence to one;
- edge scaling, Tracy-Widom behavior, sine-kernel statistics, or universality;
- non-Hermitian spectral laws;
- a numerical eigensolver or floating-point error theorem; or
- a quantum-chaos diagnostic.

The exact output is a finite measurable law-and-moment layer. The first two
normalized expectations are normalization checks, not a reconstruction of a
distribution.

## Exercises with solutions

### Exercise 1: read the type ladder

What are the codomains of <code>empiricalSpectralMeasure</code>,
<code>empiricalSpectralLaw</code>, and
<code>meanEmpiricalSpectralMeasure</code>?

**Solution.** They are <code>Measure ℝ</code>,
<code>Measure (Measure ℝ)</code>, and <code>Measure ℝ</code>, respectively.
The repeated first and third codomains do not make those objects equal: one is
a sample output, the other is an ensemble barycenter.

### Exercise 2: audit outer and inner mass

Why can \(\delta_0\) be a probability law when its point \(0\) is not a
probability measure on \(\mathbb R\)?

**Solution.** The outer Dirac law assigns mass one to the singleton containing
the zero measure. The inner zero measure assigns mass zero to the real line.
The masses belong to different measurable spaces.

### Exercise 3: expand a sample moment

For a positive-dimensional Hermitian matrix with eigenvalues
\(\lambda_0,\ldots,\lambda_{n-1}\), what is \(m_2(H)\)?

**Solution.**
\[
  m_2(H)=\frac1n\sum_i\lambda_i^2
  =\frac1n\operatorname{Tr}(H^2).
\]
Multiplicity is retained by the indexed sum.

### Exercise 4: handle the empty spectrum

What is \(m_0(H)\) when \(H\) has dimension zero?

**Solution.** It is zero. The integral is against the zero empirical measure.
The answer is not obtained by evaluating \(0^0\).

### Exercise 5: distinguish two bundles

Which definition can be used in dimension zero:
<code>empiricalSpectralLawProbability</code> or
<code>empiricalSpectralProbabilityLaw</code>?

**Solution.** The first. It bundles the outer law on raw measures.
The second requires positive dimension because its inner values are bundled
probability measures.

### Exercise 6: evaluate the barycenter on a set

What does \(\overline\mu_n(S)\) mean for measurable \(S\)?

**Solution.** It is the outer-law average of \(\mu(S)\) over sampled empirical
measures \(\mu\). It is expected spectral mass in \(S\), not the probability
of one particular empirical measure.

### Exercise 7: transport integrability

Why is the equality
<code>matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw</code> useful?

**Solution.** It rewrites the ambient measure as a pushforward. Mathlib's
<code>integrable_map_measure</code> then transfers RMT-09's ambient
trace-power integrability to the trace-power composition on intrinsic
Hermitian samples.

### Exercise 8: compute the first expectation

If \(\mathbb E\operatorname{Tr}(H)=0\), what is
\(\mathbb E m_1(H)\)?

**Solution.** It is the reciprocal-dimension constant times zero, hence zero.
The dimension-zero case also agrees because the sample moment is identically
zero.

### Exercise 9: simplify the second expectation

Why is \(\mathbb E m_2(H)=1\) stated only for dimensions \(n+1\)?

**Solution.** The all-dimensional value is \(n^{-1}n\). At zero it is zero
under Lean's total inverse. At a successor, positivity permits reciprocal
cancellation and yields one.

### Exercise 10: test the claim boundary

Do mean zero and second moment one determine the semicircle law?

**Solution.** No. Infinitely many probability distributions share those two
moments. A semicircle theorem needs control of a determining family of
observables together with an asymptotic convergence argument.

### Exercise 11: compare law and barycenter

Could two spectral laws have the same barycenter?

**Solution.** Yes. Averages can agree while sample-to-sample fluctuations
differ. The law over measures retains those differences; the joined measure
does not.

### Exercise 12: identify the unproved interchange

What additional bridge would connect the checked expected sample second moment
to a second moment of the mean empirical measure?

**Solution.** One needs a theorem moving the complex function
\(x\mapsto x^2\) through the Giry join, with the required measurability and
integrability. RMT-10C does not export that theorem.

## The next ridge

RMT-10C completes the first finite-GUE spectral-law interface. A downstream
module can now refer to a named probability law over empirical measures,
choose the stricter positive-dimensional probability-valued package when
needed, and consume exact normalized moments without rebuilding trace
transport.

Its immediate successor,
[Ordered Finite Matrix Products in Lean]({{< relref "/development-notebook/2026/07/ordered-finite-matrix-products-and-growth-bounds" >}}),
returns to the dependency-ordered deterministic branch. It fixes the
newest-factor-left time convention, proves shifted splitting and chronological
vector action, and establishes finite-time product and power bounds in the
maximum-row-sum operator norm before measurable random products and cocycles.

Within spectral theory, later self-contained milestones may add higher finite
trace moments, a rigorously derived finite-dimensional eigenvalue density, or
an integration-through-barycenter theorem. Any semicircle law must remain a
separate asymptotic development with an explicit convergence mode and enough
moment or transform control to justify the limit.

## References

The links below were checked on 2026-07-21. The pinned local Mathlib 4.32.0
checkout remains the exact API authority for the Lean proof.

<a id="ref-guionnet-2022"></a>
**Alice Guionnet.**
["Rare Events in Random Matrix Theory"](https://doi.org/10.4171/ICM2022/174),
*Proceedings of the International Congress of Mathematicians 2022*, volume 2,
pages 1008-1052. The survey records the classical Wigner-scaled GUE
normalization and the relation between normalized trace powers and empirical
spectral moments. It supplies context, not the checked law packaging or
integrability transport.

<a id="ref-mathlib-release"></a>
**Mathlib contributors.**
[Mathlib 4.32.0 release](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
2026. This is the dependency release selected by
<code>formalization/lakefile.toml</code>.

<a id="ref-mathlib-giry"></a>
**Mathlib contributors.**
[The Giry monad](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/GiryMonad.html),
Mathlib 4 documentation. This official page defines <code>Measure.join</code>
and its measurable-set evaluation, the formal barycenter operation used by
<code>meanEmpiricalSpectralMeasure</code>.

<a id="ref-mathlib-probability"></a>
**Mathlib contributors.**
[Probability measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/ProbabilityMeasure.html),
Mathlib 4 documentation. This official page defines the bundled
<code>ProbabilityMeasure</code> type, the measurable set of probability
measures inside a measure space, and probability preservation under Giry join.

<a id="ref-mathlib-bochner"></a>
**Mathlib contributors.**
[Bochner integration](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Integral/Bochner/Basic.html),
Mathlib 4 documentation. This official page supplies
<code>integral_map</code>, constant multiplication, and the Banach-valued
integral interfaces used in the exact expectation proofs.

<a id="ref-mathlib-spectrum"></a>
**Mathlib contributors.**
[Hermitian matrix spectra](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Spectrum.html),
Mathlib 4 documentation. This official page documents the finite Hermitian
spectral theorem and eigenvalue-sum identities beneath the project's ordered
spectral measure.
