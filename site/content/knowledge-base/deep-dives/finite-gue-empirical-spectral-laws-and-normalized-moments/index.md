---
title: "Finite Gaussian Unitary Ensemble Empirical Spectral Laws and Normalized Moments"
slug: "finite-gue-empirical-spectral-laws-and-normalized-moments"
date: 2026-07-21
summary: "A textbook construction of the finite Gaussian unitary ensemble law on empirical spectral measures, its probability packaging and Giry mean, and the first two exact normalized sample-moment expectations."
lead: "A random matrix does not have one deterministic empirical spectrum. It produces a random measure, whose distribution is a probability law on measures. This chapter builds that law for the finite Gaussian unitary ensemble, keeps it separate from its Giry mean, and transports exact trace moments into the first normalized spectral moments."
draft: true
pro_reviewed: false
level: "Finite random matrix probability, measurable measure-valued observables, and exact normalized moments"
reading_time: "100 to 130 minutes"
prerequisites: "Hermitian eigenvalues with multiplicity, empirical spectral measures, measurable pushforwards, finite Gaussian unitary ensemble trace moments, probability-measure subtypes, and Bochner integration; each boundary is reviewed before use"
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleSpectrum"
toc: true
og_image: "finite-gue-empirical-spectral-laws-and-normalized-moments-card.png"
og_image_alt: "Intrinsic and ambient finite Gaussian unitary ensemble laws lead to the same probability law on empirical spectral measures. Giry join produces a separate mean measure, while normalized trace identities produce exact first and second expected sample moments without a moment-interchange theorem."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The mathematical
prose, sources, Lean declaration map, figure, and accessibility have not yet
received the required human and Pro reviews. The page must remain a draft until
those gates are complete.
{{< /panel >}}

A finite Hermitian matrix has a finite multiset of real eigenvalues. Its
{{< refterm "empirical-spectral-measure" "empirical spectral measure" >}}
turns that multiset into one normalized measure on the real line. A random
Hermitian matrix therefore produces a **random measure**. The distribution of
that random measure is the
{{< refterm "empirical-spectral-law" "empirical spectral law" >}}.

That sentence hides a climb through four type levels:

1. one sampled matrix;
2. one empirical spectral measure produced by that matrix;
3. a probability law whose outcomes are such measures; and
4. one mean measure obtained by averaging the measure-valued outcomes.

The tenth finite random-matrix milestone, part C (RMT-10C), makes every one of
those levels explicit for the finite Wigner-scaled Gaussian unitary ensemble
(GUE). It proves that the raw empirical spectral law is a probability measure
in every dimension, including the empty dimension. In positive dimension it
also packages each outcome as a bundled probability measure. It identifies
the intrinsic and ambient constructions, computes the zero-dimensional law,
forms the mean empirical spectral measure with Mathlib's Giry join, and proves
that mean has mass one in positive dimension.

The same module defines complex moments of a single empirical spectral
measure. Its first two sample moments are exactly reciprocal-dimension
normalized trace and trace square. Transporting the preceding finite GUE trace
theorems then gives

\[
\mathbb E[m_1(H)]=0
\]

in every dimension and

\[
\mathbb E[m_2(H)]
{} =
\left(\frac{1}{n}:\mathbb C\right)n.
\]

The second expression is zero when \(n=0\) and one whenever \(n\gt0\). These
are exact finite identities under the normalization implemented in this
repository.

One boundary matters enough to state before anything else: RMT-10C does
**not** prove that a moment of the Giry mean measure equals the expected
moment of the sampled empirical measure. The two expressions are naturally
related, but their interchange needs its own measurability and integrability
theorem. This chapter keeps that unproved bridge visible throughout.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [Two routes in one picture](#two-routes-in-one-picture) | Distinguish laws, means, and moments |
| Type route | [Four levels, four objects](#base-camp-one-four-levels-four-objects) | Stop confusing a measure with a law on measures |
| Boundary route | [Two inverses at dimension zero](#camp-two-two-inverses-at-dimension-zero) | Reconcile the empty spectrum with totalized arithmetic |
| Probability route | [Package the law without changing it](#camp-four-package-the-law-without-changing-it) | Compare raw and probability-valued laws |
| Transport route | [Intrinsic and ambient laws agree](#camp-six-intrinsic-and-ambient-laws-agree) | Audit the almost-everywhere Hermitian bridge |
| Giry route | [Average measures with join](#camp-seven-average-measures-with-giry-join) | Construct the mean measure and respect its limits |
| Moment route | [Sample moments are normalized traces](#camp-nine-sample-moments-are-normalized-traces) | Derive and integrate the first two moments |
| Lean route | [The complete checked interface](#the-complete-checked-interface) | Audit all public declarations and the private helper |
| Summit route | [What has and has not been proved](#summit-what-has-and-has-not-been-proved) | Separate finite foundations from future spectral theory |

### Learning objectives

By the summit, you should be able to:

1. distinguish one sample empirical measure from its probability law;
2. distinguish a law on raw measures from a law on bundled probability
   measures;
3. explain why the raw empirical spectral law remains a probability law in
   dimension zero although its only outcome has mass zero;
4. derive the law as a measurable pushforward of the intrinsic GUE law;
5. explain why the ambient and intrinsic pushforwards agree;
6. state what Mathlib's Giry join does to a law on measures;
7. explain why joining a law and integrating a sample moment are separate
   operations;
8. derive the first two empirical spectral moments from spectral counting
   trace identities;
9. audit the extended-nonnegative inverse and field inverse at dimension zero;
10. transport integrability from the ambient finite GUE trace observables;
11. derive the exact first and second expected sample moments;
12. explain why the second expected normalized moment is zero at empty size
    and one at every positive size;
13. identify every public declaration exposed by the checked Lean module;
14. describe the private helper that keeps ambient trace transport readable;
    and
15. state the density, asymptotic, and interchange claims that are still
    absent.

## Two routes in one picture

{{< reference-figure
  src="law-packaging-and-moment-routes.svg"
  alt="The intrinsic Hermitian Gaussian unitary ensemble law and ambient matrix Gaussian unitary ensemble law lead to the same raw empirical spectral law. That law can be bundled as a probability law in every dimension, or in positive dimension as a law whose outcomes are bundled probability measures. Giry join makes a separate mean measure, with no theorem here interchanging its moments with expected sample moments. A second route rewrites the first two sample moments as normalized traces and then evaluates their exact finite expectations."
  caption="**Finding:** the law route and the moment route share the same random matrices but answer different typed questions. Measurable pushforward creates a probability law on measures. Giry join averages its measure-valued outcomes. Normalized trace identities evaluate expected sample moments. RMT-10C connects intrinsic and ambient presentations, but it deliberately does not identify moments of the joined mean with expectations of sample moments."
>}}

The upper route begins with randomness. It asks what probability distribution
is induced on empirical spectral measures. The lower route begins with an
observable of one sampled measure. It rewrites that observable as a normalized
trace and computes its expectation under the matrix law.

The routes are compatible, but compatibility is not automatic interchange.
A typed formalization is valuable precisely because it refuses to let the
same word, *average*, blur three operations:

- averaging eigenvalue atoms within one sample;
- averaging a scalar moment across random samples; and
- averaging entire measures by Giry join.

{{< checkpoint stage="Orientation" title="Name the object before manipulating it" >}}
If an expression is a measure on the real line, a measure on a space of
measures, a bundled probability measure, or a complex number, say which one.
Most conceptual errors in this slice arise before any calculation begins.
{{< /checkpoint >}}

## Base camp zero: conventions and notation

Fix \(n\in\mathbb N\). The intrinsic matrix space is

\[
\mathcal H_n
{} =
\{\text{complex Hermitian matrices of size }n\}.
\]

In Lean this is the finite-dimensional real Euclidean space
<code>HermitianEuclidean n</code>. The project uses two compatible finite GUE
laws:

\[
\mathbb P_n^{\mathrm{int}}
\quad\text{on }\mathcal H_n,
\qquad
\mathbb P_n^{\mathrm{amb}}
\quad\text{on all complex square matrices}.
\]

They are named <code>GUE.intrinsicLaw n</code> and
<code>GUE.matrixLaw n</code>. The ambient law gives the Hermitian locus full
mass, while the intrinsic law makes Hermitian structure true by type.

For \(H\in\mathcal H_n\), let

\[
N_H=\sum_{i\in\operatorname{Fin}(n)}\delta_{\lambda_i(H)}
\]

be the spectral counting measure, with eigenvalues counted by their indices
and therefore with algebraic multiplicity. The project's empirical spectral
measure is

\[
L_H=(n:\mathbb R_{\ge0}^{\infty})^{-1}N_H.
\]

For \(n\gt0\), this is the familiar probability measure

\[
L_H=\frac1n\sum_{i=1}^{n}\delta_{\lambda_i(H)}.
\]

The extended-nonnegative formulation also defines \(L_H\) when \(n=0\). That
boundary will matter later.

For a natural power \(k\), the complex sample moment is

\[
m_k(H)
{} =
\int_{\mathbb R}(x:\mathbb C)^k\,\mathrm dL_H(x).
\]

The coercion into \(\mathbb C\) is explicit because the trace theorems used
later are complex-valued.

Finally, write

\[
\mathcal Q_n
{} =
(H\mapsto L_H)_\#\mathbb P_n^{\mathrm{int}}
\]

for the raw empirical spectral law and

\[
\overline L_n=\operatorname{join}(\mathcal Q_n)
\]

for its Giry mean measure.

## Base camp one: four levels, four objects

### Level one: a matrix sample

A sample \(H\) contains random entries constrained by Hermitian symmetry. It
is not a measure. Its eigenvalues are derived data.

### Level two: a sample empirical measure

Applying \(H\mapsto L_H\) yields one measure on \(\mathbb R\). In positive
dimension it assigns equal mass to each indexed eigenvalue. Repeated
eigenvalues appear repeatedly in the finite sum, so multiplicity is retained.

At this level, the word *empirical* refers to averaging the atoms within one
matrix:

\[
\int f\,\mathrm dL_H
{} =
\frac1n\sum_i f(\lambda_i(H))
\]

for positive \(n\) and suitable \(f\).

### Level three: a law on measures

The matrix itself is random, so \(L_H\) varies from trial to trial. Its law
\(\mathcal Q_n\) is therefore a measure on <code>Measure ℝ</code>:

\[
\mathcal Q_n\in\operatorname{Measure}(\operatorname{Measure}(\mathbb R)).
\]

For a measurable set \(C\) of measures,

\[
\mathcal Q_n(C)
{} =
\mathbb P_n^{\mathrm{int}}\{H:L_H\in C\}.
\]

The event in braces is meaningful because RMT-10B proved
<code>measurable_empiricalSpectralMeasure</code>.

### Level four: the mean measure

Joining \(\mathcal Q_n\) produces one measure \(\overline L_n\) on
\(\mathbb R\). Informally, for a measurable spectral set \(B\),

\[
\overline L_n(B)
{} =
\int_{\operatorname{Measure}(\mathbb R)}
  \mu(B)\,\mathrm d\mathcal Q_n(\mu).
\]

The law \(\mathcal Q_n\) remembers the distribution of whole empirical
measures. The mean \(\overline L_n\) retains only their setwise average.
Different laws on measures can have the same joined mean.

### The type ledger

| Name | Mathematical home | Lean-shaped type | Randomness remaining |
|---|---|---|---|
| \(H\) | Hermitian matrix space | <code>HermitianEuclidean n</code> | One sampled matrix |
| \(L_H\) | Measures on the real line | <code>Measure ℝ</code> | Depends on \(H\) |
| \(\mathcal Q_n\) | Measures on measures | <code>Measure (Measure ℝ)</code> | Distribution across samples |
| bundled raw law | Probability measures on raw measures | <code>ProbabilityMeasure (Measure ℝ)</code> | Same outer law, mass-one evidence bundled |
| positive-dimensional bundled law | Probability measures on probability measures | <code>ProbabilityMeasure (ProbabilityMeasure ℝ)</code> | Inner and outer mass-one evidence bundled |
| \(\overline L_n\) | Measures on the real line | <code>Measure ℝ</code> | No sample remains |
| \(m_k(H)\) | Complex numbers | <code>ℂ</code> | Scalar observable of \(H\) |
| \(\mathbb E[m_k]\) | Complex numbers | <code>ℂ</code> | Randomness integrated out |

Two rows can have the same underlying raw measure and still play distinct interface
roles. A <code>ProbabilityMeasure α</code> is a subtype carrying proof that
its underlying <code>Measure α</code> has mass one
([Mathlib contributors](#ref-gue-law-probability)). Coercion forgets the proof,
not the measure.

{{< checkpoint stage="Base camp" title="A law on measures is not the mean measure" >}}
The outer law records how entire sample measures fluctuate. Giry join
collapses those fluctuations to one averaged measure. No amount of notation
can make the two objects interchangeable: their types differ.
{{< /checkpoint >}}

## Camp one: define the empirical spectral law by pushforward

### Pushforward is the construction

Once \(H\mapsto L_H\) is measurable, the shortest correct definition of the
law is the pushforward:

~~~lean
noncomputable def GUE.empiricalSpectralLaw (n : ℕ) :
    Measure (Measure ℝ) :=
  (GUE.intrinsicLaw n).map RandomMatrix.empiricalSpectralMeasure
~~~

Mathlib's Giry measurable structure equips <code>Measure ℝ</code> with the
measurable structure generated by evaluation on measurable sets. Its official
interface supplies measurable pushforward, Dirac embedding, and join
([Mathlib contributors](#ref-gue-law-giry-mathlib)). This lets the repository
use an established space of measures instead of inventing a custom finite
spectrum space.

For a measurable \(C\subseteq\operatorname{Measure}(\mathbb R)\), the defining
pushforward equation is

\[
\mathcal Q_n(C)
{} =
\mathbb P_n^{\mathrm{int}}(L_n^{-1}(C)),
\qquad
L_n(H)=L_H.
\]

The matrix distribution supplies the probability. The observable supplies the
new sample space. Measurability is the gate between them.

### Why the law is a probability law

The intrinsic GUE law has total mass one. A measurable pushforward of a
probability measure again has total mass one. Lean records this as the
instance

~~~lean
GUE.instIsProbabilityMeasureEmpiricalSpectralLaw (n : ℕ) :
    IsProbabilityMeasure (GUE.empiricalSpectralLaw n)
~~~

This statement concerns the **outer** measure \(\mathcal Q_n\). It does not
claim every outcome \(L_H\) has mass one. That distinction is invisible in
positive dimension but decisive at \(n=0\).

### What measurability contributed

RMT-10B established continuity of ordered Hermitian eigenvalues using Weyl's
perturbation bound, then continuity and measurability of spectral counting and
empirical measures. RMT-10C consumes that work in one line of mathematical
design: use <code>Measure.map</code>.

The dependency ladder is:

\[
\text{Weyl bound}
\Longrightarrow
\text{continuous eigenvalue coordinates}
\Longrightarrow
\text{measurable empirical measure}
\Longrightarrow
\text{empirical spectral law}.
\]

The law is not an independent density calculation. It is the distribution of
an already formalized measure-valued observable.

## Camp two: two inverses at dimension zero

The same symbol \(n^{-1}\) appears in two algebraic systems. At positive
dimension they agree after coercion. At zero they behave differently, and the
formalization uses both behaviors correctly.

### Extended-nonnegative inverse in the sample measure

The empirical measure uses a scalar in
\(\mathbb R_{\ge0}^{\infty}\):

\[
(n:\mathbb R_{\ge0}^{\infty})^{-1}.
\]

In the extended nonnegative reals,

\[
(0:\mathbb R_{\ge0}^{\infty})^{-1}=\infty.
\]

The zero-dimensional spectral counting measure is the zero measure because
there are no eigenvalue indices. Mathlib's measure scalar action is totalized
so the resulting empirical measure is still zero:

\[
L_H=0
\qquad\text{for }H\in\mathcal H_0.
\]

This is not a probability measure. Its total mass is zero.

### Field inverse in the trace formula

The sample moment identities use a real reciprocal coerced into \(\mathbb C\):

\[
\left((n:\mathbb R)^{-1}:\mathbb C\right).
\]

In a field, inversion is totalized with

\[
(0:\mathbb R)^{-1}=0.
\]

Thus the normalized-trace side of the zero-dimensional identity is also zero.
The trace of the unique empty matrix is zero, but the coefficient is already
zero as well.

### The conversion point

The proof of the sample identities starts from integration against the
extended-nonnegative scaled measure. The lemma
<code>ENNReal.toReal_inv</code> converts the finite real content needed for
complex scalar multiplication. At zero, conversion sends the infinite
extended value to zero. The final theorem is therefore stated with the field
inverse.

| Stage | Scalar system | Zero inverse | Object produced |
|---|---|---|---|
| Define \(L_H\) | \(\mathbb R_{\ge0}^{\infty}\) | \(\infty\) | A measure |
| Convert a measure scalar for integration | \(\mathbb R\) | conversion gives \(0\) | A real coefficient |
| State normalized trace moment | \(\mathbb C\) via \(\mathbb R\) | \(0\) | A complex number |

There is no contradiction. The two inverses live in different types and enter
at different stages.

{{< checkpoint stage="Arithmetic ledge" title="Do not simplify before naming the scalar type" >}}
At dimension zero, asking only “what is zero inverse?” is under-specified.
First ask whether the scalar is extended nonnegative, real, or complex.
{{< /checkpoint >}}

## Camp three: the empty law is Dirac at the zero measure

There is a unique intrinsic Hermitian matrix of size zero. Its empirical
spectral measure is deterministically zero. Pushing a Dirac law through a
measurable map yields a Dirac law at the image, so

\[
\mathcal Q_0=\delta_{0}.
\]

The checked theorem is

~~~lean
@[simp] theorem GUE.empiricalSpectralLaw_zero :
    GUE.empiricalSpectralLaw 0 = Measure.dirac (0 : Measure ℝ)
~~~

The inner point \(0:\operatorname{Measure}(\mathbb R)\) has total mass zero.
The outer Dirac measure \(\delta_0\), considered as a measure on the space of
measures, has total mass one.

This resolves a common false inference:

> If the sample empirical measure is not a probability measure at size zero,
> its law cannot be a probability measure.

The premise concerns an **outcome**. The conclusion concerns the
**distribution over outcomes**. A probability law may be concentrated at any
measurable object, including the zero measure.

The design choice is valuable. Rather than deleting dimension zero from every
statement, the raw law remains total in \(n\). The positive-dimensional interface
adds stronger inner probability packaging when that evidence is actually
true.

## Camp four: package the law without changing it

RMT-10C exposes two probability packages whose names differ only by word
order. The distinction is structural.

### Outer probability, raw inner outcomes

Because \(\mathcal Q_n\) has mass one for every \(n\), it can be bundled as

~~~lean
noncomputable def GUE.empiricalSpectralLawProbability (n : ℕ) :
    ProbabilityMeasure (Measure ℝ)
~~~

The outer object is a bundled probability measure. Its sample space remains
<code>Measure ℝ</code>. At \(n=0\), its sole outcome is the raw zero measure.

### Outer probability, bundled inner outcomes

For a positive dimension written \(n+1\), every empirical spectral measure
has mass one. The earlier interface packages the sample map as

~~~lean
RandomMatrix.empiricalSpectralProbability (n : ℕ) :
    HermitianEuclidean (n + 1) → ProbabilityMeasure ℝ
~~~

Pushing the intrinsic law through it yields

~~~lean
noncomputable def GUE.empiricalSpectralProbabilityLaw (n : ℕ) :
    ProbabilityMeasure (ProbabilityMeasure ℝ)
~~~

Now both levels are bundled:

- the outer distribution has mass one; and
- every inner outcome carries its own proof of mass one.

The parameter \(n\) corresponds to matrix dimension \(n+1\). This successor
index is a proof-engineering choice that makes positivity structural.

### Forgetting the inner wrapper

Let

\[
\iota:\operatorname{ProbabilityMeasure}(\mathbb R)
\longrightarrow
\operatorname{Measure}(\mathbb R)
\]

be the coercion that forgets the mass-one proof. RMT-10C proves

\[
\iota_\#
\bigl(\mathcal Q_{n+1}^{\mathrm{prob\ outcome}}\bigr)
{} =
\mathcal Q_{n+1}.
\]

The exact theorem is
<code>GUE.map_empiricalSpectralProbabilityLaw_coe</code>. Its proof uses
measurability of subtype coercion and associativity of <code>Measure.map</code>.
At the pointwise level, coercing
<code>empiricalSpectralProbability n H</code> gives exactly
<code>empiricalSpectralMeasure H</code>.

### A naming audit

| Declaration | Outer carrier | Inner outcome | Dimensions |
|---|---|---|---|
| <code>empiricalSpectralLaw n</code> | raw <code>Measure</code> | raw <code>Measure ℝ</code> | every \(n\) |
| <code>empiricalSpectralLawProbability n</code> | bundled <code>ProbabilityMeasure</code> | raw <code>Measure ℝ</code> | every \(n\) |
| <code>empiricalSpectralProbabilityLaw n</code> | bundled <code>ProbabilityMeasure</code> | bundled <code>ProbabilityMeasure ℝ</code> | matrix size \(n+1\) |

Read the name from the outside in:

- **LawProbability** packages the law as a probability measure.
- **ProbabilityLaw** is a law whose outcomes are probability measures.

The names are close because the mathematics is close. The Lean types remain
the reliable source of truth.

## Camp five: a finite toy model that exposes the types

Before returning to GUE, consider a random source that selects one of two
Hermitian matrices with equal probability:

\[
H_+=
\begin{bmatrix}
2&0\\
0&0
\end{bmatrix},
\qquad
H_-=
\begin{bmatrix}
0&0\\
0&-2
\end{bmatrix}.
\]

Their empirical measures are

\[
L_+
{} =
\frac12\delta_2+\frac12\delta_0,
\qquad
L_-
{} =
\frac12\delta_0+\frac12\delta_{-2}.
\]

The empirical spectral law is

\[
\mathcal Q
{} =
\frac12\delta_{L_+}+\frac12\delta_{L_-}.
\]

Its atoms are measures. It places no atom directly at the real number \(2\).
The joined mean is

\[
\overline L
{} =
\frac14\delta_2+\frac12\delta_0+\frac14\delta_{-2}.
\]

The mean has atoms on the real line. It no longer records whether positive
and negative outer atoms arrived together in one matrix or on separate
trials.

For this toy model,

\[
m_1(H_+)=1,
\qquad
m_1(H_-)=-1,
\]

so the expected first sample moment is zero. Both second sample moments equal
\(2\). These values illustrate the layers only. They are not finite GUE
moment values under the repository's Wigner scaling.

The example also shows why a law contains more information than its joined
mean. If another random mechanism produced different measure-valued outcomes
with the same setwise average, it would share \(\overline L\) but not
\(\mathcal Q\).

## Camp six: intrinsic and ambient laws agree

The empirical spectral law was defined from intrinsic Hermitian matrices. The
earlier finite GUE trace moments were proved for the ambient matrix law. The
two presentations need a bridge.

### The ambient observable

RMT-10B defined

~~~lean
RandomMatrix.ambientEmpiricalSpectralMeasure n :
    Matrix (Fin n) (Fin n) ℂ → Measure ℝ
~~~

It returns the empirical spectral measure when the input is Hermitian and
returns the zero measure otherwise. That fallback makes a total measurable
function on all complex square matrices.

The fallback is not a claim that zero is the correct spectrum of a
non-Hermitian matrix. It is a formal extension chosen because finite GUE gives
the non-Hermitian set probability zero.

### The commuting pushforward square

The checked equality is

\[
\mathcal Q_n
{} =
(\operatorname{ambientEmpiricalSpectralMeasure}_n)_\#
  \mathbb P_n^{\mathrm{amb}}.
\]

In Lean:

~~~lean
theorem GUE.empiricalSpectralLaw_eq_map_matrixLaw_ambient (n : ℕ) :
    GUE.empiricalSpectralLaw n =
      (GUE.matrixLaw n).map
        (RandomMatrix.ambientEmpiricalSpectralMeasure n)
~~~

The proof consumes the RMT-10B transport theorem whose orientation runs from
the ambient pushforward to the intrinsic pushforward, then uses symmetry.

Conceptually, the square is

\[
\begin{array}{ccc}
\mathcal H_n & \xrightarrow{\ H\mapsto L_H\ } &
  \operatorname{Measure}(\mathbb R)\\
\downarrow & & \uparrow\!\!\text{ almost surely compatible}\\
\text{all complex matrices}
& \xrightarrow{\ \text{Hermitian-or-zero observable}\ } &
  \operatorname{Measure}(\mathbb R).
\end{array}
\]

The left map forgets the intrinsic proof and views a Hermitian matrix as an
ambient matrix. The ambient matrix law is the corresponding pushforward of
the intrinsic law. Along samples from that law, the ambient observable agrees
with the intrinsic one.

### What the equality licenses

The theorem licenses either presentation of the same finite spectral law. It
also explains how trace-moment results proved under <code>matrixLaw</code> can
support sample-moment expectations under <code>intrinsicLaw</code>.

It does not license:

- spectral claims about arbitrary non-Hermitian matrices;
- replacing an almost-everywhere statement by pointwise equality everywhere;
- a joint eigenvalue density; or
- any large-dimension limit.

## Camp seven: average measures with Giry join

### Join flattens one measure layer

Mathlib defines

~~~lean
Measure.join : Measure (Measure α) → Measure α
~~~

for the Giry measurable structure. It is the measure-theoretic analogue of
flattening a nested probabilistic computation. RMT-10C names

~~~lean
noncomputable def GUE.meanEmpiricalSpectralMeasure (n : ℕ) :
    Measure ℝ :=
  (GUE.empiricalSpectralLaw n).join
~~~

For a measurable set \(B\), the intended evaluation is

\[
\overline L_n(B)
{} =
\int \mu(B)\,\mathrm d\mathcal Q_n(\mu).
\]

The evaluation map \(\mu\mapsto\mu(B)\) is measurable under the Giry
structure. Mathlib's <code>join_apply</code> theorem makes this setwise
interpretation precise under its hypotheses
([Mathlib contributors](#ref-gue-law-giry-mathlib)).

Giry's original categorical account organizes probability measures into a
monadic structure whose multiplication averages a measure of measures
([Giry](#ref-gue-law-giry)). The repository relies on Mathlib's checked
implementation for exact Lean statements.

### Empty dimension

Since \(\mathcal Q_0=\delta_0\), joining it returns its only inner measure:

\[
\overline L_0=0.
\]

This is proved by
<code>GUE.meanEmpiricalSpectralMeasure_zero</code>.

### Positive dimension

For \(n+1\), the empirical spectral law is concentrated on inner measures of
mass one. Joining a probability law supported on probability measures
produces a probability measure. RMT-10C proves

~~~lean
theorem GUE.meanEmpiricalSpectralMeasure_succ_isProbability (n : ℕ) :
    IsProbabilityMeasure
      (GUE.meanEmpiricalSpectralMeasure (n + 1))
~~~

The proof exposes the exact condition used by Mathlib:

1. the outer empirical spectral law is a probability measure;
2. almost every inner outcome is a probability measure;
3. <code>isProbabilityMeasure_join</code> concludes that the join has mass
   one.

The earlier pointwise theorem
<code>empiricalSpectralMeasure_succ_isProbability</code> supplies the
almost-everywhere inner condition.

### Why not define only the mean?

The law \(\mathcal Q_n\) supports future questions about fluctuations,
concentration, and nonlinear functionals of the entire sample measure. The
mean alone cannot answer those questions. Defining the law first preserves
the richer object; join then derives the mean through a standard operation.

## Camp eight: the unproved moment-interchange bridge

There are two plausible complex numbers:

\[
A_{n,k}
{} =
\int_{\mathcal H_n}
  \left(\int_{\mathbb R}(x:\mathbb C)^k\,\mathrm dL_H(x)\right)
  \mathrm d\mathbb P_n^{\mathrm{int}}(H)
\]

and

\[
B_{n,k}
{} =
\int_{\mathbb R}(x:\mathbb C)^k\,\mathrm d\overline L_n(x).
\]

RMT-10C proves exact values for \(A_{n,1}\) and \(A_{n,2}\). It does not prove
\(A_{n,k}=B_{n,k}\).

### Why the equality is not definitional

Join is defined setwise for measures. The function
\(x\mapsto(x:\mathbb C)^k\) is unbounded for positive \(k\). Passing its
integral through a measure-valued average requires more than the definition
of join.

A formal theorem would need to establish the appropriate measurability and
integrability conditions and invoke or prove a suitable Tonelli, Fubini, or
kernel-integration result. Complex-valued Bochner integration introduces its
own norm-integrability gate.

### What is safe to say

It is safe to say:

- \(A_{n,k}\) is the expected moment of a sampled empirical measure;
- \(B_{n,k}\) is a moment of the joined mean measure, when that integral is
  meaningful;
- mathematical probability suggests an interchange theorem under suitable
  hypotheses; and
- that theorem is absent from the current checked module.

It is not safe to cite
<code>integral_empiricalSpectralMoment_two_succ</code> as a theorem about
\(\int x^2\,\mathrm d\overline L_{n+1}\). The declaration integrates over
<code>intrinsicLaw</code>, not over
<code>meanEmpiricalSpectralMeasure</code>.

{{< panel "warning" >}}
**Crucial nonclaim.** The exact expected sample moments in this chapter are
not formalized moments of the Giry mean empirical spectral measure. A future
interchange theorem must connect those objects explicitly.
{{< /panel >}}

## Camp nine: sample moments are normalized traces

### Define the sample moment once

The pointwise observable is

~~~lean
noncomputable def RandomMatrix.empiricalSpectralMoment
    {n : ℕ} (k : ℕ) (H : HermitianEuclidean n) : ℂ :=
  ∫ x : ℝ, (x : ℂ) ^ k
    ∂RandomMatrix.empiricalSpectralMeasure H
~~~

This definition works for every natural power and dimension. The module then
publishes exact identities only for powers one and two.

### Dimension zero

Every moment is zero when \(n=0\), because the underlying empirical spectral
measure is zero:

\[
m_k(H)=0.
\]

The theorem
<code>RandomMatrix.empiricalSpectralMoment_zero</code> is tagged for
simplification. It makes later empty-dimensional integrability and expectation
theorems short and honest.

### First moment

The spectral counting measure already satisfies a trace identity:

\[
\int_{\mathbb R}(x:\mathbb C)\,\mathrm dN_H(x)
{} =
\operatorname{Tr}(H).
\]

Scaling the measure by reciprocal dimension yields

\[
m_1(H)
{} =
\left((n:\mathbb R)^{-1}:\mathbb C\right)
  \operatorname{Tr}(H).
\]

Lean states the matrix as <code>hermitianToMatrix H</code> because the
intrinsic Hermitian space is a real Euclidean model with a canonical map back
to an ambient complex matrix.

### Second moment

The second spectral counting identity is

\[
\int_{\mathbb R}(x:\mathbb C)^2\,\mathrm dN_H(x)
{} =
\operatorname{Tr}(H^2).
\]

Therefore

\[
m_2(H)
{} =
\left((n:\mathbb R)^{-1}:\mathbb C\right)
  \operatorname{Tr}(H^2).
\]

These are deterministic identities. No GUE distribution is needed. The
probability law enters only when the functions of \(H\) are integrated.

### Why use complex moments?

The eigenvalues are real, so these first two values are real after embedding.
The ambient trace interface, however, is naturally complex-valued. Defining
<code>empiricalSpectralMoment</code> in \(\mathbb C\) avoids a separate
real-part transport layer and matches the existing finite GUE trace theorems
exactly.

## Camp ten: transport integrability before expectations

Mathlib's Bochner integral is totalized
([Mathlib contributors](#ref-gue-law-bochner)). A numerical integral identity
does not by itself advertise whether the integrand is genuinely integrable.
RMT-10C therefore publishes separate integrability theorems.

### The private ambient helper

The module defines

~~~lean
private noncomputable def GUE.ambientTracePower (n k : ℕ) :
    Matrix (Fin n) (Fin n) ℂ → ℂ :=
  RandomMatrix.tracePower
    (id : Matrix (Fin n) (Fin n) ℂ →
      Matrix (Fin n) (Fin n) ℂ) k
~~~

This is not new mathematics. It specializes the general trace-power
observable to the identity matrix-valued function. Giving that specialization
a private name keeps the transport proofs readable without expanding the
public interface.

### Move integrability from ambient to intrinsic

The previous trace-moment module proved

\[
H\longmapsto\operatorname{Tr}(H)
\quad\text{and}\quad
H\longmapsto\operatorname{Tr}(H^2)
\]

integrable under the ambient matrix law. RMT-10C rewrites that law as the
pushforward of <code>intrinsicLaw</code> through
<code>hermitianToMatrix</code>. Mathlib's integrability-under-map theorem then
pulls the claim back to the composition on intrinsic matrices.

Finally, integrability is preserved by multiplication by the constant

\[
c_n=\left((n:\mathbb R)^{-1}:\mathbb C\right).
\]

The pointwise sample-moment identity shows that this scaled composition is
exactly <code>empiricalSpectralMoment</code> for the selected power.

The proof pipeline is:

\[
\begin{array}{c}
\text{ambient trace power is integrable}\\
\Downarrow\\
\text{compose with intrinsic-to-ambient map}\\
\Downarrow\\
\text{multiply by reciprocal dimension}\\
\Downarrow\\
\text{rewrite as sample spectral moment}.
\end{array}
\]

No eigenvalue growth estimate is reproved here. The established trace
integrability theorem carries the analytic burden.

### Empty-dimensional integrability

For \(n=0\), every sample moment function is identically zero. Thus every
power is integrable and its integral vanishes. RMT-10C publishes these generic
zero-dimensional facts even though its positive-dimensional calculations stop
at powers one and two.

## Camp eleven: exact normalized ensemble moments

### The first expected moment

For every \(n\),

\[
\begin{aligned}
\mathbb E[m_1(H)]
&=
c_n\,\mathbb E[\operatorname{Tr}(H)]\\
&=
c_n\cdot0\\
&=0.
\end{aligned}
\]

The first exact ambient trace moment was already proved as
\(\mathbb E[\operatorname{Tr}(H)]=0\). RMT-10C transports the integral from
the intrinsic law to the ambient law, rewrites the private helper as the
existing trace-power observable, and invokes that theorem.

The result includes \(n=0\). No division-by-zero side condition is required
because the field inverse is totalized.

### The second expected moment

Similarly,

\[
\begin{aligned}
\mathbb E[m_2(H)]
&=
c_n\,\mathbb E[\operatorname{Tr}(H^2)]\\
&=
\left((n:\mathbb R)^{-1}:\mathbb C\right)(n:\mathbb C).
\end{aligned}
\]

The earlier finite GUE result

\[
\mathbb E[\operatorname{Tr}(H^2)]=n
\]

contains the exact Wigner normalization. Multiplying by reciprocal dimension
turns an extensive trace-square energy into an order-one empirical spectral
moment.

At \(n=0\),

\[
\left((0:\mathbb R)^{-1}:\mathbb C\right)(0:\mathbb C)=0.
\]

For \(n\gt0\),

\[
\left((n:\mathbb R)^{-1}:\mathbb C\right)(n:\mathbb C)=1.
\]

The successor theorem packages the positive branch without an external
positivity hypothesis:

\[
\mathbb E[m_2(H)]=1
\qquad
\text{for matrix size }n+1.
\]

### Normalization ledger

| Quantity | Convention in this project | Exact finite expectation |
|---|---|---|
| ordinary trace | no dimension factor | \(0\) |
| ordinary trace square | no dimension factor | \(n\) |
| first empirical moment | reciprocal dimension times trace | \(0\) |
| second empirical moment | reciprocal dimension times trace square | \(0\) at empty size, \(1\) at positive size |

The value one is not universal across arbitrary random-matrix scalings. It is
the consequence of this repository's Wigner-scaled GUE coordinate variance
and its empirical measure normalization.

### Physical and statistical reading

The first sample moment is the center of mass of the empirical eigenvalue
cloud. Its expectation is zero because the finite GUE is centered.

The second sample moment is the mean squared eigenvalue measured across all
indexed eigenvalues of one sample:

\[
m_2(H)=\frac1n\sum_i\lambda_i(H)^2
\]

in positive dimension. The expected value one says that the chosen Wigner
scale keeps the average squared eigenvalue at order one as dimension changes.
This is a finite normalization identity, not yet a theorem that the empirical
measure converges to any limiting distribution.

## Camp twelve: proof architecture in Lean

The module is deliberately thin because it composes earlier interfaces.

### Layer A: deterministic spectral algebra

The sample-moment definition integrates powers against
<code>empiricalSpectralMeasure</code>. The first two identities use:

- integration against a scaled measure;
- conversion of the extended-nonnegative inverse to a real scalar;
- the first and second spectral-counting-measure integral identities; and
- coercion into \(\mathbb C\).

### Layer B: law construction

The empirical spectral law uses:

- <code>intrinsicLaw</code>;
- <code>measurable_empiricalSpectralMeasure</code>;
- <code>Measure.map</code>; and
- preservation of probability under measurable pushforward.

### Layer C: packaging and mean

The probability-valued law uses:

- the positive-dimensional sample probability wrapper;
- its measurability;
- bundled <code>ProbabilityMeasure</code> constructors; and
- measurable coercion back to raw measures.

The mean uses:

- <code>Measure.join</code>;
- the zero law computation; and
- Mathlib's probability theorem for join with an almost-sure inner
  probability condition.

### Layer D: normalized expected moments

The expectation proofs use:

- exact ambient trace integrability and integral identities from RMT-09;
- the intrinsic-to-ambient law equality;
- measurability of <code>hermitianToMatrix</code>;
- <code>integrable_map_measure</code> and <code>integral_map</code>;
- preservation of integrability under constant multiplication; and
- the deterministic sample-moment identities.

This layered design minimizes duplicated analysis. Each theorem crosses one
interface already made explicit in the dependency chain.

## The complete checked interface

The module exposes twenty-one public declarations. The tables below list
every one.

### Sample moments in <code>RandomMatrix</code>

| Declaration | Kind | Checked content |
|---|---|---|
| <code>RandomMatrix.empiricalSpectralMoment</code> | definition | The \(k\)-th complex moment of one empirical spectral measure |
| <code>RandomMatrix.empiricalSpectralMoment_zero</code> | theorem | Every sample moment is zero in dimension zero |
| <code>RandomMatrix.empiricalSpectralMoment_one</code> | theorem | The first sample moment is reciprocal-dimension normalized trace |
| <code>RandomMatrix.empiricalSpectralMoment_two</code> | theorem | The second sample moment is reciprocal-dimension normalized trace square |

### Laws and probability packaging in <code>GUE</code>

| Declaration | Kind | Checked content |
|---|---|---|
| <code>GUE.empiricalSpectralLaw</code> | definition | Pushforward of the intrinsic GUE law through the empirical spectral measure |
| <code>GUE.instIsProbabilityMeasureEmpiricalSpectralLaw</code> | instance | The raw empirical spectral law has mass one in every dimension |
| <code>GUE.empiricalSpectralLawProbability</code> | definition | The raw law bundled as <code>ProbabilityMeasure (Measure ℝ)</code> |
| <code>GUE.empiricalSpectralProbabilityLaw</code> | definition | In size \(n+1\), a bundled law on bundled probability measures |
| <code>GUE.map_empiricalSpectralProbabilityLaw_coe</code> | theorem | Forgetting the inner bundle recovers the raw positive-dimensional law |
| <code>GUE.empiricalSpectralLaw_eq_map_matrixLaw_ambient</code> | theorem | Intrinsic and ambient spectral pushforwards agree |
| <code>GUE.empiricalSpectralLaw_zero</code> | theorem | The empty-dimensional law is Dirac at the zero measure |

### Mean empirical spectral measure

| Declaration | Kind | Checked content |
|---|---|---|
| <code>GUE.meanEmpiricalSpectralMeasure</code> | definition | Giry join of the raw empirical spectral law |
| <code>GUE.meanEmpiricalSpectralMeasure_zero</code> | theorem | The empty-dimensional mean measure is zero |
| <code>GUE.meanEmpiricalSpectralMeasure_succ_isProbability</code> | theorem | The mean measure has mass one in every positive dimension |

### Integrability and exact ensemble moments

| Declaration | Kind | Checked content |
|---|---|---|
| <code>GUE.integrable_empiricalSpectralMoment_zero</code> | theorem | Every sample-moment power is integrable at size zero |
| <code>GUE.integral_empiricalSpectralMoment_zero</code> | theorem | Every expected sample-moment power is zero at size zero |
| <code>GUE.integrable_empiricalSpectralMoment_one</code> | theorem | The first sample moment is integrable under intrinsic finite GUE |
| <code>GUE.integral_empiricalSpectralMoment_one</code> | theorem | Its expectation is zero in every dimension |
| <code>GUE.integrable_empiricalSpectralMoment_two</code> | theorem | The second sample moment is integrable under intrinsic finite GUE |
| <code>GUE.integral_empiricalSpectralMoment_two</code> | theorem | Its expectation is reciprocal dimension times dimension |
| <code>GUE.integral_empiricalSpectralMoment_two_succ</code> | theorem | Its expectation is one in every positive dimension |

### The private helper

The module also defines one private implementation helper:

| Declaration | Visibility | Purpose |
|---|---|---|
| <code>GUE.ambientTracePower</code> | private | Specialize the general trace-power observable to the ambient identity map for readable law transport |

Private visibility is intentional. Downstream code should cite the public
sample-moment, trace-moment, and transport theorems rather than depend on this
local abbreviation.

### Declaration count audit

The public surface consists of:

- four declarations for deterministic sample moments;
- seven declarations for the law and its packages;
- three declarations for the Giry mean;
- seven declarations for integrability and exact expectations.

That totals twenty-one. The private helper makes twenty-two named declarations
in the source file while remaining absent from its external interface.

## How to read the theorem statements without overclaiming

### Read the measure after the integral sign

The moment theorems integrate over <code>GUE.intrinsicLaw n</code>. They are
expectations across matrix samples.

They do not integrate over <code>GUE.empiricalSpectralLaw n</code>, whose
points are measures, and they do not integrate over
<code>GUE.meanEmpiricalSpectralMeasure n</code>, whose points are real
spectral locations.

### Read the dimension parameter

The raw law accepts <code>n</code> directly and includes zero. The
probability-valued law accepts <code>n</code> but describes matrix dimension
<code>n + 1</code>. The positive second-moment theorem uses the same successor
pattern.

### Read the codomain

Sample moments and their expectations live in \(\mathbb C\). The underlying
eigenvalues remain real. The complex codomain aligns with matrix trace and
Bochner integration.

### Read instances as theorems

<code>instIsProbabilityMeasureEmpiricalSpectralLaw</code> is an instance so
typeclass inference can use it automatically. It is still a checked
mathematical result: the outer raw law has total mass one.

### Read simplification tags as boundary policy

The zero-law, zero-mean, zero-moment, and positive second-moment theorems are
tagged where automatic simplification is useful. Those tags encode expected
normal forms, not new assumptions.

## Common wrong turns

### “One sample measure is the empirical spectral law”

No. \(L_H\) is one outcome. \(\mathcal Q_n\) is its distribution over random
matrix samples.

### “The empirical spectral law is a measure on eigenvalues”

Not directly. It is a measure on a space whose points are measures on
eigenvalues.

### “The joined mean and the law are equivalent”

No. Join forgets distributional information about the measure-valued outcome.
It is many-to-one.

### “The zero sample measure prevents a probability law”

No. At size zero, the law is a Dirac probability measure concentrated at the
zero measure.

### “Probability packaging changes the numerical measure”

No. The wrapper adds mass-one evidence. The coercion theorem proves that
forgetting the inner wrapper recovers the raw law.

### “The ambient fallback describes non-Hermitian spectra”

No. It is a zero-totalized measurable extension. Its value off the Hermitian
locus is irrelevant under finite GUE because that locus has full measure.

### “Normalized means the same scalar at zero in every type”

No. The empirical measure begins with an extended-nonnegative inverse, while
the trace identity ends with a field inverse. Their zero behaviors differ.

### “Expected second sample moment one is a semicircle law”

No. It is one exact finite moment under one normalization. Many distinct
probability measures share the same first two moments.

### “The Giry mean has second moment one by the theorem here”

Not yet formalized. The checked theorem concerns expected sample moments.
Moving the unbounded moment integrand through join requires a separate result.

### “All spectral moments are now known”

No. Every power is defined, and every power is handled at size zero. Only the
first two positive-dimensional integrability and expectation calculations are
proved.

## Summit: what has and has not been proved

### Checked in RMT-10C

The Lean kernel has checked:

- complex moments of one empirical spectral measure;
- zero-dimensional vanishing for every power;
- normalized-trace identities for the first two sample moments;
- the raw finite GUE empirical spectral law;
- probability of that outer law in every dimension;
- raw-outcome and positive-dimensional probability-outcome packages;
- equality after forgetting the positive-dimensional inner wrapper;
- equality of intrinsic and ambient spectral pushforwards;
- the empty law as Dirac at the zero measure;
- the mean empirical spectral measure as Giry join;
- zero mean at empty size and probability mass at positive size;
- integrability of the first two sample moments;
- exact expected first moment zero;
- exact expected second moment reciprocal dimension times dimension; and
- exact positive-dimensional second moment one.

### Not checked in this slice

RMT-10C does not prove:

- a joint density of GUE eigenvalues;
- a Vandermonde factor or normalization constant;
- absolute continuity of the empirical law or its mean;
- a finite eigenvalue correlation function;
- a determinantal kernel;
- a formula for the density of the mean empirical measure;
- any third or higher positive-dimensional moment;
- an interchange theorem between Giry mean moments and expected sample
  moments;
- concentration of the empirical spectral measure;
- convergence in probability, almost surely, or in expectation;
- a semicircle law;
- edge scaling, Tracy-Widom behavior, or rigidity;
- local spacing statistics;
- universality; or
- any statement about independent eigenvalues.

The standard random-matrix literature develops many of these themes from
additional finite formulas and asymptotic estimates
([Anderson, Guionnet, and Zeitouni](#ref-gue-law-agz)). They remain future
formalization milestones here.

### Why this finite slice matters

A future convergence theorem needs a precisely typed sequence of random
measures. RMT-10C supplies that sequence. A future mean-measure theorem needs
an actual mean measure. RMT-10C supplies it through Giry join. A future moment
method needs normalized finite moments and their integrability. RMT-10C
supplies the first two.

The result is infrastructure, but it is mathematically meaningful
infrastructure. It fixes the sample space, normalization, zero boundary,
probability packaging, measurable transport, and exact base moments before
asymptotic language enters.

## Exercises: trailhead to summit

### Trailhead

1. Write the Lean-shaped type of \(H\), \(L_H\), \(\mathcal Q_n\),
   \(\overline L_n\), and \(m_k(H)\). Which pairs live in the same raw type but
   have different meanings?
2. In the two-sample toy model, compute
   \(\mathcal Q(\{L_+\})\) and \(\overline L(\{0\})\). Explain why the two
   numbers answer different questions.
3. Explain in one paragraph why \(\delta_0\) is a probability measure on
   <code>Measure ℝ</code> although its atom is the zero measure.
4. For positive \(n\), show directly that \(L_H(\mathbb R)=1\).
5. State the difference between
   <code>empiricalSpectralLawProbability</code> and
   <code>empiricalSpectralProbabilityLaw</code> without using the word
   “basically.”

### Mid-mountain

6. Starting from
   \(N_H=\sum_i\delta_{\lambda_i(H)}\), derive the first two sample-moment
   formulas from the trace identities.
7. Audit dimension zero in both formulas. Identify the type of each inverse
   before simplifying.
8. Draw the intrinsic-to-ambient commuting square and mark which equality is
   pointwise and which compatibility is almost everywhere.
9. Explain why measurability of \(H\mapsto L_H\) creates
   \(\mathcal Q_n\) but does not prove integrability of \(m_2\).
10. Reconstruct the proof that forgetting the inner probability wrapper
    recovers the raw positive-dimensional law. Which measurable maps are
    composed?
11. Give two different laws on probability measures with the same Giry join.
    State what information the join loses.

### Summit

12. Design a precise theorem statement relating
    \(\int f\,\mathrm d\overline L_n\) to
    \(\mathbb E[\int f\,\mathrm dL_H]\) for bounded measurable real \(f\).
    List the Mathlib interfaces that would likely be needed.
13. Explain what additional work is needed when
    \(f(x)=(x:\mathbb C)^k\) is unbounded and complex-valued.
14. Starting only from the earlier ambient trace integrability theorem and
    <code>matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw</code>, sketch the
    Lean proof of
    <code>integrable_empiricalSpectralMoment_two</code>.
15. Propose a third-moment milestone. Separate deterministic spectral
    identities, integrability, finite GUE expectation, and any symmetry
    argument into distinct declarations.
16. Explain why the exact first two moments do not determine the empirical
    spectral law. Construct two probability measures on \(\mathbb R\) with
    first moment zero and second moment one.
17. State a future semicircle theorem using a topology on probability
    measures. Identify which object should converge and which RMT-10C theorem
    makes that object available.

## Reproduce the checked slice

From the repository root:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean \
  NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleSpectrum.lean
~~~

To audit the declaration surface interactively, import the module in a small
Lean file and use <code>#check</code> on the names listed in
[the complete checked interface](#the-complete-checked-interface). The source contains no
<code>sorry</code> placeholders. The project-wide validation commands and
pinned toolchain are documented in the repository README.

The generated card is deterministic. From either the repository root or any
other working directory:

~~~sh
site/content/knowledge-base/deep-dives/finite-gue-empirical-spectral-laws-and-normalized-moments/generate-card.sh --verify
~~~

The script resolves its own directory and compares a temporary regeneration
with the checked PNG at exactly 1200 by 630 pixels.

## Where to continue

The {{< refterm "empirical-spectral-law" "empirical spectral law" >}} glossary
entry is the compact reference for the four type levels, the empty-dimensional
law, and the mean-measure warning.

[Hermitian Spectra and Empirical Measures in Finite Dimension]({{< relref "/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures" >}})
constructs the one-sample spectral counting and empirical measures.
[Hermitian Spectral Perturbation, Continuity, and Measurability]({{< relref "/knowledge-base/deep-dives/hermitian-spectral-perturbation-continuity-and-measurability" >}})
proves the measurable observable needed for the pushforward law.
[First Exact Finite Gaussian Unitary Ensemble Trace Moments]({{< relref "/knowledge-base/deep-dives/first-exact-finite-gue-trace-moments" >}})
proves the ambient trace integrability and exact expectations transported here.

The next natural proof milestone is an explicit integration theorem for Giry
join, first for bounded measurable scalar functions and later for integrable
complex spectral powers. That theorem would turn the crucial nonclaim in this
chapter into a checked bridge. Higher finite normalized moments, finite
eigenvalue densities, and asymptotic spectral laws should remain separate
milestones.

## References

<a id="ref-gue-law-giry-mathlib"></a>**Mathlib contributors.**
[The Giry measurable structure on measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/GiryMonad.html),
Mathlib 4 documentation. This official interface documents the measurable structure
on spaces of measures, measurable pushforward, Dirac embedding,
<code>Measure.join</code>, <code>join_apply</code>, and measurability of join.

<a id="ref-gue-law-probability"></a>**Mathlib contributors.**
[Probability measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/ProbabilityMeasure.html),
Mathlib 4 documentation. This official interface defines
<code>ProbabilityMeasure α</code>, its coercion to raw measures, and measurable
pushforward. It also documents <code>isProbabilityMeasure_join</code>, which
supplies the probability conclusion for the positive-dimensional mean measure.

<a id="ref-gue-law-bochner"></a>**Mathlib contributors.**
[The Bochner integral](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Integral/Bochner/Basic.html),
Mathlib 4 documentation. This official page documents the totalized
Banach-valued integral and the separate integrability interface used for the
complex sample-moment expectations.

<a id="ref-gue-law-giry"></a>**Michèle Giry.**
[A Categorical Approach to Probability Theory](https://doi.org/10.1007/BFb0092872),
in *Categorical Aspects of Topology and Analysis*, Lecture Notes in
Mathematics 915, Springer, 1982, pp. 68-85. This primary source introduced the
categorical probability framework associated with the Giry monad. Exact Lean
claims in this chapter follow Mathlib's checked interface.

<a id="ref-gue-law-agz"></a>**Greg W. Anderson, Alice Guionnet, and Ofer Zeitouni.**
[An Introduction to Random Matrices](https://doi.org/10.1017/CBO9780511801334),
Cambridge University Press, 2010. Chapters 2 and 3 provide a standard account
of finite Gaussian ensembles, empirical eigenvalue measures, moment methods,
and their later asymptotic role. This chapter uses only the finite concepts
and states the repository's normalization independently.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
