---
title: "Finite Hermitian Spectra and Empirical Measures"
slug: "finite-hermitian-spectra-and-empirical-measures"
date: 2026-07-21
summary: "A textbook ascent from the ordered real spectrum of one finite Hermitian matrix to counting and empirical measures, with the exact zero-dimensional policy and conditional measurable-law boundary made explicit."
lead: "A spectrum becomes probabilistic in stages. First order the real eigenvalues of one Hermitian matrix. Then count them with multiplicity, normalize the count, and only after proving measurability push a random-matrix law onto the resulting space of measures."
draft: false
pro_reviewed: false
level: "Finite Hermitian spectral algebra through conditional measure-valued probability"
reading_time: "85 to 110 minutes"
prerequisites: "Finite-dimensional linear algebra, Hermitian matrices, Dirac and pushforward measures, and the distinction between a random variable and its law; all specialized ingredients are reviewed before use"
lean_module: "NonlinearDynamics.Random.RandomMatrices.HermitianSpectrum"
toc: true
og_image: "finite-hermitian-spectra-and-empirical-measures-card.png"
og_image_alt: "A Hermitian matrix sample yields a decreasing real eigenvalue vector, then a finite empirical spectral measure; a further pushforward to a law over measures is available only after a separate coordinatewise eigenvalue-measurability gate."
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
prose, citations, Lean declaration map, figure, and accessibility have not yet
received the required human and Pro reviews. The page is publicly available as
an open working note while those reviews remain pending.
{{< /panel >}}

A finite Hermitian matrix carries two complementary descriptions. Its entries
say how a chosen basis is coupled. Its eigenvalues say how the corresponding
operator acts along its preferred orthogonal directions. Changing the basis by
a unitary matrix scrambles the entries but leaves the spectrum untouched.

The tenth random-matrix-theory milestone begins formalizing that spectral
description. RMT-10A constructs the decreasing real eigenvalue vector of every
intrinsic finite Hermitian matrix, proves its first two power sums equal the
trace and trace square, and packages the vector as two finite measures:

\[
N_H=\sum_i\delta_{\lambda_i(H)},
\qquad
L_H=\frac1nN_H
\]

when the matrix dimension is \(n\). The first is the spectral counting measure.
The second is the {{< refterm "empirical-spectral-measure" "empirical spectral measure" >}}.
The module explicitly defines \(L_H=0\) at \(n=0\), so the all-dimensions
object is zero or probabilistic rather than always probabilistic.

This is a strong algebraic layer, but within RMT-10A it is not yet a random
spectral law. Pinned Mathlib supplies a canonical ordered Hermitian eigenvalue
enumeration and the finite spectral theorem. It does not directly supply the
continuity or measurability theorem for those ordered coordinates that this
project needs. Every RMT-10A theorem that maps a matrix law into a law on
spectral measures therefore takes coordinatewise eigenvalue measurability as
an explicit hypothesis.

That boundary is the chapter's central lesson. Pointwise spectral algebra,
measure-valued measurability, and a pushforward probability law are different
summits. RMT-10A reaches the first, builds conditional bridges toward the
second and third, and does not pretend that the missing bridge has already been
crossed.

{{< panel "info" >}}
**Successor layer.** RMT-10B now proves a Frobenius
{{< refterm "weyl-eigenvalue-bound" "Weyl eigenvalue bound" >}}, packages the
ordered spectrum as 1-Lipschitz, and discharges these coordinatewise
measurability hypotheses.
[Hermitian Spectral Perturbation, Continuity, and Measurability]({{< relref "/knowledge-base/deep-dives/hermitian-spectral-perturbation-continuity-and-measurability" >}})
develops that proof and the resulting unconditional GUE pushforward bridge.
This chapter continues to document the exact RMT-10A boundary.
{{< /panel >}}

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [Three objects, three levels](#three-objects-three-levels) | Separate a spectrum, its empirical measure, and a law over measures |
| Linear algebra route | [The finite Hermitian spectral theorem](#base-camp-one-the-finite-hermitian-spectral-theorem) | Understand why the eigenvalues are real and why multiplicity matters |
| Lean indexing route | [Why the sorted enumeration matters](#camp-one-why-the-sorted-enumeration-matters) | See why <code>eigenvalues₀</code> is transported by an order-preserving cast |
| Moment route | [Trace as a spectral power sum](#camp-two-trace-as-a-spectral-power-sum) | Recover trace and trace square from the ordered vector |
| Symmetry route | [Unitary congruence changes coordinates, not spectrum](#camp-three-unitary-congruence-changes-coordinates-not-spectrum) | Follow the characteristic-polynomial proof of invariance |
| Measure route | [From repeated coordinates to finite atoms](#camp-four-from-repeated-coordinates-to-finite-atoms) | Build counting and empirical spectral measures |
| Boundary route | [Dimension zero is not a probability space of eigenvalues](#camp-five-dimension-zero-is-not-a-probability-space-of-eigenvalues) | Audit the explicit empty-spectrum policy |
| Probability route | [The Giry measurability gate](#camp-six-the-giry-measurability-gate) | Identify the exact missing hypothesis |
| Ambient-law route | [A total observable on all complex matrices](#camp-seven-a-total-observable-on-all-complex-matrices) | Understand the Hermitian-or-zero extension and conditional GUE bridge |
| Lean audit route | [The complete public API](#the-complete-public-api) | Map every declaration to its mathematical layer |

### Learning objectives

By the summit, you should be able to:

1. state the finite Hermitian spectral theorem and explain why its eigenvalues
   are real;
2. distinguish an ordered eigenvalue vector from the set of distinct spectral
   locations;
3. explain how repeated indices encode algebraic multiplicity;
4. distinguish Mathlib's sorted <code>eigenvalues₀</code> from its generally
   reindexed <code>eigenvalues</code>;
5. explain why an order-preserving cast is used to obtain a vector on
   <code>Fin n</code>;
6. derive the trace and trace-square power-sum identities;
7. explain why unitary congruence preserves the whole ordered vector;
8. build a finite spectral counting measure from Dirac atoms;
9. derive its total mass and first two complex moments;
10. normalize the count into an empirical spectral measure in positive
    dimension;
11. defend the explicit zero-measure policy at dimension zero;
12. distinguish <code>Measure ℝ</code>, <code>ProbabilityMeasure ℝ</code>,
    and a probability law on either of those spaces;
13. describe the Giry measurable structure on a space of measures;
14. identify coordinatewise eigenvalue measurability as an unproved input,
    rather than an implicit fact;
15. explain why the Hermitian-or-zero extension is total and measurable;
16. state the conditional intrinsic-versus-ambient GUE pushforward equality;
17. separate deterministic unitary invariance from random-law invariance; and
18. list the density, asymptotic, and local-statistics conclusions that do not
    follow from this module.

## Three objects, three levels

{{< reference-figure
  src="sample-measure-law.svg"
  alt="One Hermitian matrix sample yields a decreasing real eigenvalue list and then one equally weighted finite spectral measure. A separate measurability gate must be passed before a random matrix law can be pushed forward to a law whose samples are measures."
  caption="**Finding:** one deterministic empirical spectral measure and a probability law over empirical spectral measures are different objects. The first follows from finite spectral algebra. The second requires the matrix-to-measure map to be measurable. RMT-10A proves the law-level comparison only under that explicit eigenvalue-measurability hypothesis; the figure does not claim the hypothesis has been discharged."
>}}

Start with an intrinsic Hermitian matrix \(H\). It has a deterministic ordered
eigenvalue vector

\[
\Lambda(H)=\bigl(\lambda_0(H),\ldots,\lambda_{n-1}(H)\bigr).
\]

That vector determines one deterministic measure \(L_H\) on the real line. If
we then sample \(H\) from a probability law \(\mu\), the expression

\[
\mu\mathbin{\mathrm{map}}\bigl(H\mapsto L_H\bigr)
\]

would be a probability law on a space whose points are measures. It answers
questions such as, "Across random matrix samples, how is the entire empirical
spectrum distributed?"

These levels should never be compressed into the phrase *the spectral
distribution*:

1. \(\Lambda(H)\) is a finite vector attached to one matrix.
2. \(L_H\) is a finite measure attached to one matrix.
3. \(\mu\mathbin{\mathrm{map}}(H\mapsto L_H)\) is a law over measure-valued
   samples, and it requires measurability of the map being pushed forward.
4. The mean measure \(\mathbb E[L_H]\), if later defined, would be another
   object again. It averages the random measure and forgets sample-to-sample
   variability.

In a deterministic theorem, the first two levels need no probability space.
The third level is where the Giry measurable structure and RMT-10A's displayed
eigenvalue-measurability obligation enter. RMT-10B later discharges it.

{{< checkpoint stage="Orientation" title="The theorem boundary in one sentence" >}}
RMT-10A defines finite spectra and empirical measures unconditionally for each
intrinsic Hermitian matrix, but it pushes random-matrix laws through those
objects only under a displayed coordinatewise eigenvalue-measurability
hypothesis.
{{< /checkpoint >}}

## Base camp zero: intrinsic Hermitian matrices

The project's intrinsic carrier
<code>RandomMatrix.HermitianEuclidean n</code> is a real normed space whose
elements are complex \(n\)-by-\(n\) matrices together with a proof of
Hermiticity. If \(H\) is represented by the matrix \(A\), the property is

\[
A^*=A,
\]

where \(A^*\) is the conjugate transpose.

Bundling the property matters. A theorem about an intrinsic value may use
Hermiticity without carrying a new premise at every line. The earlier
Frobenius-geometry module also gives this carrier the topology and measurable
space inherited from its finite real Euclidean structure. The later
measurability problem is not that the matrix space lacks measurable structure.
It is that the specific ordered-eigenvalue functions still need a theorem
connecting them to that structure.

The module uses <code>hermitianToMatrix</code> when it needs the ambient matrix
and <code>hermitianCongruence U H</code> for the intrinsic action

\[
H\longmapsto UHU^*.
\]

For unitary \(U\), this action stays inside the Hermitian carrier.

## Base camp one: the finite Hermitian spectral theorem

For a complex Hermitian matrix \(H\), the finite spectral theorem supplies a
unitary matrix \(U\) and a real diagonal vector \(\lambda\) such that

\[
H=U\,\operatorname{diag}(\lambda)\,U^*.
\]

The columns of \(U\) form an orthonormal eigenbasis. Every diagonal entry of
\(\operatorname{diag}(\lambda)\) is real, and each root of the characteristic
polynomial appears according to its algebraic multiplicity. Mathlib's official
matrix-spectrum module proves this diagonalization and exposes both ordered and
reindexed eigenvalue interfaces
([Mathlib contributors](#ref-spectrum-mathlib-spectrum)).

The theorem changes what can be regarded as intrinsic. Matrix entries depend
on a basis. The multiset of eigenvalues does not. If two Hermitian matrices
are related by a unitary basis change, they describe the same diagonal
operator in different coordinates.

### Multiplicity is not an optional annotation

For

\[
H=
\begin{bmatrix}
5&0&0\\
0&2&0\\
0&0&2
\end{bmatrix},
\]

the set of distinct eigenvalues is \(\{5,2\}\), but the characteristic
polynomial is

\[
(X-5)(X-2)^2.
\]

The ordered vector is \((5,2,2)\). The repeated coordinate is needed for

\[
\operatorname{Tr}(H)=5+2+2
\]

and for every spectral power sum. The counting measure will later turn those
two copies of \(2\) into an atom of mass two. A set of distinct spectral
locations cannot recover this information.

## Camp one: why the sorted enumeration matters

Mathlib offers two closely related definitions for a Hermitian matrix whose
entry index type is \(\iota\):

~~~lean
Matrix.IsHermitian.eigenvalues₀ :
  Fin (Fintype.card ι) → ℝ

Matrix.IsHermitian.eigenvalues :
  ι → ℝ
~~~

The first is canonical as an ordered finite ordinal. Mathlib proves
<code>eigenvalues₀_antitone</code>, so lower indices contain no smaller values:

\[
i\le j\quad\Longrightarrow\quad
\operatorname{eigenvalues}_0(H,i)\ge
\operatorname{eigenvalues}_0(H,j).
\]

The second reuses the original index type by choosing a general equivalence
with the finite ordinal. That equivalence preserves the number of indices. It
need not preserve any order living on \(\iota\). This is entirely appropriate
for results that only need a product or sum over all eigenvalues, but it is not
a sorted coordinate interface.

The project specializes to \(\iota=\operatorname{Fin}(n)\). Mathlib's theorem
<code>Fintype.card_fin n</code> identifies the cardinality of that type with
\(n\). The definition
<code>orderedHermitianEigenvalues</code> transports
<code>eigenvalues₀</code> along the corresponding finite cast:

~~~lean
noncomputable def orderedHermitianEigenvalues {n : ℕ}
    (H : HermitianEuclidean n) : Fin n → ℝ :=
  fun i => H.2.eigenvalues₀
    (Fin.cast (Fintype.card_fin n).symm i)
~~~

This cast is order preserving. The theorem
<code>orderedHermitianEigenvalues_antitone</code> transports Mathlib's
antitonicity through <code>Fin.cast_le_cast</code>. When sums later need an
explicit equivalence, the proof uses
<code>Fin.castOrderIso (Fintype.card_fin n).symm</code>.

Why spend proof effort on order if the empirical measure forgets permutations?
Because this vector is intended as a reusable spectral interface. The largest
eigenvalue is coordinate zero. Monotone comparisons between coordinates have a
meaning. Future perturbation and extreme-eigenvalue results can state their
coordinates without first quotienting by permutations. The measure layer then
uses the same vector without losing multiplicity.

{{< panel "info" >}}
**A finite cast is not a numerical approximation.** It transports an index
across a proof that two finite ordinal bounds are equal. No eigenvalue is
rounded or recomputed. The cast changes only the type in which the index is
recognized.
{{< /panel >}}

## Camp two: trace as a spectral power sum

Trace is basis invariant. In an eigenbasis it becomes the sum of diagonal
eigenvalues:

\[
\operatorname{Tr}(H)=\sum_{i=0}^{n-1}\lambda_i(H).
\]

The project theorem
<code>trace_eq_sum_orderedHermitianEigenvalues</code> states this in the
ambient complex codomain:

~~~lean
theorem trace_eq_sum_orderedHermitianEigenvalues
    (H : HermitianEuclidean n) :
    Matrix.trace (hermitianToMatrix H) =
      ∑ i, (orderedHermitianEigenvalues H i : ℂ)
~~~

The coercion from real eigenvalues to complex numbers is explicit. The matrix
trace is complex because the ambient entries are complex, even though
Hermiticity forces its value to be real.

### The proof route through characteristic roots

The proof does not simply rewrite with Mathlib's arbitrarily reindexed
<code>trace_eq_sum_eigenvalues</code>. It follows a route that preserves the
chosen ordered interface:

1. Hermiticity proves the characteristic polynomial splits.
2. The matrix trace is rewritten as the sum of characteristic-polynomial
   roots.
3. Mathlib identifies that root multiset with the values of
   <code>eigenvalues₀</code>.
4. A sum along the order isomorphism moves from the cardinality-indexed vector
   to <code>Fin n</code>.

The value of a finite sum is permutation invariant, but the proof explicitly
connects it to the same ordered vector used everywhere else.

### The square sees spectral energy

The second identity is

\[
\operatorname{Tr}(H^2)=\sum_{i=0}^{n-1}\lambda_i(H)^2.
\]

RMT-09 reached the left side without eigenvalues by proving that a Hermitian
trace square is the Frobenius norm square. RMT-10A now reaches the right side
through diagonalization. The theorem
<code>trace_sq_eq_sum_sq_orderedHermitianEigenvalues</code> makes the bridge
exact.

Let \(D=\operatorname{diag}(\lambda)\) and \(H=UDU^*\). Then

\[
\begin{aligned}
H^2
&=(UDU^*)(UDU^*)\\
&=UD(U^*U)DU^*\\
&=UD^2U^*.
\end{aligned}
\]

Cyclicity of trace and \(U^*U=I\) give

\[
\operatorname{Tr}(H^2)
=\operatorname{Tr}(D^2)
=\sum_i\lambda_i^2.
\]

The Lean proof follows this calculation with matrix associativity,
<code>Matrix.trace_mul_cycle</code>, the unitary identity, and the explicit
diagonal formula. It then reindexes Mathlib's diagonal eigenvalues to
<code>eigenvalues₀</code> and finally to the project vector.

These identities are deterministic. They do not assert integrability under a
random-matrix law. RMT-09 separately proved integrability and expected values
for the first two ambient Gaussian unitary ensemble (GUE) trace powers.
RMT-10C now combines those layers into normalized sample moments and their
exact finite GUE expectations in
[Finite Gaussian Unitary Ensemble Empirical Spectral Laws and Normalized Moments]({{< relref "/knowledge-base/deep-dives/finite-gue-empirical-spectral-laws-and-normalized-moments" >}}).

## Camp three: unitary congruence changes coordinates, not spectrum

For a unitary matrix \(U\), intrinsic congruence sends \(H\) to \(UHU^*\).
The characteristic polynomial is unchanged:

\[
\det(XI-UHU^*)=\det(XI-H).
\]

The theorem
<code>orderedHermitianEigenvalues_hermitianCongruence</code> proves the
strong coordinatewise statement

\[
\Lambda(UHU^*)=\Lambda(H).
\]

Its Lean proof has two conceptual stages.

First, it uses the characteristic-polynomial identity
<code>Matrix.charpoly_mul_comm</code>. Moving a factor cyclically and reducing
\(U^*U\) to the identity proves that the two characteristic polynomials are
equal.

Second, it avoids selecting or matching individual eigenvectors. Mathlib
describes <code>eigenvalues₀</code> as the decreasing sort of the real parts
of the characteristic roots. Equal characteristic polynomials have equal root
multisets, and sorting the same multiset by the same order yields the same
list. Function extensionality then gives equality of every project coordinate.

This proof handles repeated eigenvalues naturally. When an eigenspace has
dimension greater than one, an eigenbasis inside it is far from unique. The
sorted root list is still canonical.

Once the vector equality is available, unitary invariance of both spectral
measures is immediate:

\[
N_{UHU^*}=N_H,
\qquad
L_{UHU^*}=L_H.
\]

These are pointwise deterministic invariances. They should be distinguished
from the earlier theorem that the GUE matrix **law** is unitary invariant.
The former says the observable is constant along every unitary orbit. The
latter says the random input law is itself unchanged by the action.

## Camp four: from repeated coordinates to finite atoms

The Dirac measure \(\delta_x\) places unit mass at the point \(x\). For a
measurable set \(B\subseteq\mathbb R\),

\[
\delta_x(B)=
\begin{cases}
1,&x\in B,\\
0,&x\notin B.
\end{cases}
\]

Mathlib's official Dirac module provides that atomic measure together with its
map and probability properties. Its counting-measure module defines global
counting measure as a sum of Dirac measures
([Mathlib contributors](#ref-spectrum-mathlib-atoms)). RMT-10A uses the same
idea over a finite eigenvalue index:

~~~lean
noncomputable def spectralCountingMeasure
    (H : HermitianEuclidean n) : Measure ℝ :=
  ∑ i, Measure.dirac (orderedHermitianEigenvalues H i)
~~~

If two indices carry the same eigenvalue, two equal Dirac measures occur in the
sum. Their masses add. This is exactly how algebraic multiplicity becomes
measure multiplicity.

### Total mass

Every Dirac measure assigns mass one to the whole real line. There are \(n\)
index slots, so

\[
N_H(\mathbb R)=n.
\]

The theorem <code>spectralCountingMeasure_univ</code> states this uniformly,
including the empty case. The specialized theorem
<code>spectralCountingMeasure_zero</code> makes the zero-dimensional identity
visible:

\[
N_H=0\quad\text{when }n=0.
\]

Unitary invariance is transferred by
<code>spectralCountingMeasure_hermitianCongruence</code>, which rewrites every
Dirac location with the already proved ordered-vector equality.

### The first two counting-measure moments

Integrating against a finite sum of Dirac atoms evaluates the integrand at
each atom. Therefore

\[
\int_{\mathbb R}x\,\mathrm dN_H(x)
=\sum_i\lambda_i(H)
=\operatorname{Tr}(H)
\]

and

\[
\int_{\mathbb R}x^2\,\mathrm dN_H(x)
=\sum_i\lambda_i(H)^2
=\operatorname{Tr}(H^2).
\]

The project states these as
<code>integral_complex_ofReal_spectralCountingMeasure</code> and
<code>integral_sq_complex_ofReal_spectralCountingMeasure</code>. The integrands
are coerced into \(\mathbb C\), matching the codomain of the trace. Finite sums
of Dirac integrals are automatically integrable for these pointwise finite
values, and the proof supplies those obligations to
<code>integral_finsetSum_measure</code>.

For positive dimension, the corresponding empirical moments follow on paper
by multiplying by \(1/n\):

\[
\int x\,\mathrm dL_H(x)=\frac1n\operatorname{Tr}(H),
\qquad
\int x^2\,\mathrm dL_H(x)=\frac1n\operatorname{Tr}(H^2).
\]

Those two normalized formulas are explanatory consequences. RMT-10A does not
publish them as separate public declarations, and at \(n=0\) the right sides
would require a separate convention.

## Camp five: dimension zero is not a probability space of eigenvalues

For \(n\gt0\), normalization gives

\[
L_H=\frac1nN_H,
\qquad
L_H(\mathbb R)=1.
\]

The dimension-zero case has no eigenvalue slots. There is no uniform
probability distribution over an empty set. One could force a total
probability-valued definition by choosing an arbitrary fallback point and
returning a Dirac measure there, but that point would not be an eigenvalue and
would inject fake spectral mass.

The project instead defines

~~~lean
noncomputable def empiricalSpectralMeasure
    (H : HermitianEuclidean n) : Measure ℝ :=
  (n : ℝ≥0∞)⁻¹ • spectralCountingMeasure H
~~~

In the extended nonnegative reals, the inverse of zero is infinity. The empty
counting measure is zero, and infinity scaled by the zero measure is zero.
Thus

\[
L_H=0\quad\text{when }n=0.
\]

Three declarations expose the boundary at the right strengths:

- <code>empiricalSpectralMeasure_zero</code> proves the exact empty-case
  equality.
- <code>empiricalSpectralMeasure_isZeroOrProbability</code> says the measure
  has total mass zero or one in every natural dimension.
- <code>empiricalSpectralMeasure_succ_isProbability</code> proves mass one for
  dimensions written as \(n+1\).

Mathlib's <code>IsZeroOrProbabilityMeasure</code> typeclass is precisely the
uniform proposition needed here. Its <code>ProbabilityMeasure ℝ</code> type is
a subtype containing a measure together with a proof that its total mass is
one
([Mathlib contributors](#ref-spectrum-mathlib-probability)).

The definition <code>empiricalSpectralProbability n H</code> bundles
\(L_H\) into that subtype only when \(H\) has dimension \(n+1\). This makes a
valuable impossible state unrepresentable: code receiving that wrapper never
has to wonder whether it was handed the zero-dimensional zero measure.

Unitary invariance survives scaling and appears as
<code>empiricalSpectralMeasure_hermitianCongruence</code>.

## Camp six: the Giry measurability gate

A measure can itself be a point in a measurable space. Mathlib equips
<code>Measure α</code> with the Giry measurable structure: the smallest
measurable structure making every evaluation map

\[
\mu\longmapsto\mu(B)
\]

measurable when \(B\) is measurable. The official Giry module includes all
measures, not only probability measures, and proves that Dirac embedding,
measure addition, mapping, joining, and related constructions are measurable
([Mathlib contributors](#ref-spectrum-mathlib-giry)).

For the spectral counting map

\[
H\longmapsto\sum_i\delta_{\lambda_i(H)}
\]

the outer operations are therefore available. If every coordinate map
\(H\mapsto\lambda_i(H)\) is measurable, composition with measurable Dirac and
finite measurable addition proves that the whole counting-measure map is
measurable. Scaling by the constant inverse dimension then proves
measurability of the empirical-measure map.

RMT-10A packages these deductions as:

~~~lean
theorem measurable_spectralCountingMeasure_of_measurable_eigenvalues
    (h : ∀ i, Measurable
      (fun H => orderedHermitianEigenvalues H i)) :
    Measurable spectralCountingMeasure

theorem measurable_empiricalSpectralMeasure_of_measurable_eigenvalues
    (h : ∀ i, Measurable
      (fun H => orderedHermitianEigenvalues H i)) :
    Measurable empiricalSpectralMeasure
~~~

For positive dimension, subtype construction then yields
<code>measurable_empiricalSpectralProbability_of_measurable_eigenvalues</code>.

### What is proved, and what is only assumed

The implication is checked. Its premise is not.

Pinned Mathlib's matrix-spectrum module provides
<code>eigenvalues₀</code>, antitonicity in the **index**, and algebraic
spectral identities. It does not provide continuity of the map from Hermitian
matrices to each ordered eigenvalue coordinate, nor the weaker measurability
theorem needed here. Antitonicity in \(i\) says nothing about dependence on
\(H\).

A future perturbation layer may discharge the premise using a Weyl inequality,
a min-max characterization, or another continuity theorem. Until that proof
exists, writing

\[
\bigl(\operatorname{GUE\ matrix\ law}\bigr)
\mathbin{\mathrm{map}}L
\]

without displaying the hypothesis would overstate the formalization.

{{< panel "warning" >}}
**Do not read an <code>of_measurable_eigenvalues</code> theorem backwards.**
It proves that coordinatewise measurability is sufficient for the
measure-valued observable. It does not synthesize or certify that hypothesis.
The hypothesis is the exact open seam for RMT-10B.
{{< /panel >}}

## Camp seven: a total observable on all complex matrices

The intrinsic map \(H\mapsto L_H\) accepts only bundled Hermitian inputs. The
project's ambient GUE matrix law lives on the full type of complex matrices,
even though it is constructed as the pushforward of an intrinsic Hermitian
law. To compose an intrinsic observable with that ambient law, RMT-10A defines
a total extension.

The map <code>matrixToHermitianOrZero n</code> behaves as follows:

\[
A\longmapsto
\begin{cases}
\text{the intrinsic matrix }A,&A\text{ is Hermitian},\\
0,&A\text{ is not Hermitian}.
\end{cases}
\]

This is a policy choice for totalization, not a spectral claim about
non-Hermitian matrices. Sending an off-locus matrix to zero does not assert
that its spectrum is zero. It simply gives the ambient function a value where
the intended Hermitian observable is outside its domain.

The theorem <code>measurable_matrixToHermitianOrZero</code> is unconditional.
The Hermitian locus is a measurable set from the earlier geometry module. The
matrix-to-Frobenius inclusion is measurable coordinatewise. Mathlib's
measurable piecewise construction then combines the Hermitian branch with the
constant-zero branch.

The theorem
<code>matrixToHermitianOrZero_hermitianToMatrix</code> proves that the
extension is a left inverse on genuine intrinsic inputs:

\[
\operatorname{matrixToHermitianOrZero}
  \bigl(\operatorname{hermitianToMatrix}(H)\bigr)=H.
\]

The ambient observable is now a simple composition:

~~~lean
noncomputable def ambientEmpiricalSpectralMeasure (n : ℕ)
    (A : Matrix (Fin n) (Fin n) ℂ) : Measure ℝ :=
  empiricalSpectralMeasure (matrixToHermitianOrZero n A)
~~~

Its measurability theorem remains conditional because the totalization is
measurable but the intrinsic empirical-measure map still depends on ordered
eigenvalue measurability.

### Why zero totalization is harmless for the checked GUE comparison

The ambient GUE law is not an unrelated law that merely happens to give the
Hermitian set probability one. It is definitionally connected to the
intrinsic law by the checked pushforward identity

\[
\operatorname{GUE.matrixLaw}(n)
=\operatorname{GUE.intrinsicLaw}(n)
  \mathbin{\mathrm{map}}\operatorname{hermitianToMatrix}.
\]

Push the ambient law through the totalized observable and use associativity of
measure map. Every source sample first enters the ambient space through
<code>hermitianToMatrix</code>, then immediately returns through the left
inverse. Pointwise, the composition reduces to the intrinsic empirical
measure.

Under the coordinatewise measurability hypothesis, RMT-10A proves:

~~~lean
theorem
  map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw_of_measurable_eigenvalues
    (h : ∀ i, Measurable
      (fun H => orderedHermitianEigenvalues H i)) :
    (GUE.matrixLaw n).map (ambientEmpiricalSpectralMeasure n) =
      (GUE.intrinsicLaw n).map empiricalSpectralMeasure
~~~

This is an exact equality of two measures on <code>Measure ℝ</code>. It says
the ambient and intrinsic routes agree whenever both maps are licensed. It
does not remove the premise, introduce a named unconditional GUE empirical
spectral law, or claim a density for that law.

### What the two routes mean

The left route matches downstream code that starts from the existing ambient
matrix law. Non-Hermitian inputs have a total fallback, though this particular
source law reaches the observable through the intrinsic inclusion.

The right route is mathematically direct. It samples from the real Euclidean
Hermitian carrier and applies the intrinsic spectral observable.

The equality proves representational independence between those routes, not
an asymptotic or universality statement.

## A worked three-by-three audit

Let

\[
H=
\begin{bmatrix}
3&0&0\\
0&-1&0\\
0&0&-1
\end{bmatrix}.
\]

The decreasing eigenvalue vector is

\[
\Lambda(H)=(3,-1,-1).
\]

Its counting measure and empirical measure are

\[
N_H=\delta_3+2\delta_{-1},
\qquad
L_H=\frac13\delta_3+\frac23\delta_{-1}.
\]

The total masses are

\[
N_H(\mathbb R)=3,
\qquad
L_H(\mathbb R)=1.
\]

The first counting moment is

\[
\int x\,\mathrm dN_H(x)=3-1-1=1=\operatorname{Tr}(H).
\]

The second is

\[
\int x^2\,\mathrm dN_H(x)=9+1+1=11
=\operatorname{Tr}(H^2).
\]

The empirical moments are \(1/3\) and \(11/3\), respectively. If \(U\) is any
three-dimensional unitary matrix and \(K=UHU^*\), then \(K\) will usually have
nondiagonal entries, but the checked invariance theorems give

\[
\Lambda(K)=\Lambda(H),\qquad N_K=N_H,\qquad L_K=L_H.
\]

No probability enters this example. If a random unitary were sampled and used
to rotate \(H\), every realization would still have the same deterministic
empirical measure. A probability law on those measures would therefore be a
Dirac law at \(L_H\), provided the random construction and the relevant map
were shown measurable. That final sentence illustrates the next level; it is
not a declaration added by RMT-10A.

## Physics: spectra are the basis-independent energy record

In finite-dimensional quantum mechanics, an observable such as a Hamiltonian
is represented by a Hermitian operator. Hermiticity makes measurement outcomes
real and supplies an orthonormal eigenbasis. The eigenvalues of the Hamiltonian
are its possible energy levels. A unitary basis change alters the matrix
coordinates but not those energies.

For one finite Hamiltonian, the empirical spectral measure is therefore a
compact ledger of energy levels with degeneracies. If an energy has a
multidimensional eigenspace, the repeated atom records that degeneracy. The
measure does not record eigenvectors, transition amplitudes, or which basis
vectors span the degenerate subspace.

For a random Hamiltonian ensemble, a law over empirical spectral measures can
describe sample-to-sample variation of the global energy-level distribution.
That is only a starting point for quantum-chaos questions. Local spacing
statistics typically require ordering, rescaling, and unfolding. Spectral
form factors use pairwise phase information across levels. Eigenvector
statistics need information discarded by \(L_H\). None is present merely
because an empirical measure has been defined.

Dyson's symmetry classification connects unitary symmetry classes with
quantum-mechanical antiunitary symmetries
([Dyson](#ref-spectrum-dyson)). That physics motivates why GUE and unitary
congruence matter here. It does not imply that every physical Hamiltonian is
GUE-distributed, nor does RMT-10A formalize a Hamiltonian dynamics model.

## Empirical spectral distribution in the wider literature

The phrase **empirical spectral distribution (ESD)** is used for normalized
eigenvalue counting in both Hermitian and non-Hermitian random-matrix theory.
The codomain changes with the spectrum. Hermitian eigenvalues lie on
\(\mathbb R\); a general complex matrix may have eigenvalues in
\(\mathbb C\).

Tao, Vu, and Krishnapur define the ESD of a general complex matrix by counting
its complex eigenvalues with equal weight, then study limiting distributions
for normalized random matrices and prove circular-law results
([Tao, Vu, and Krishnapur](#ref-spectrum-tao-vu)). That paper is useful here as
a primary example of the finite normalized-counting convention and of the
distinction between a sample ESD and an asymptotic law.

Its theorem is not a source for the present Hermitian claims. The paper's
matrices are not restricted to be Hermitian, its eigenvalues live in the
complex plane, and its target asymptotic distribution is the circular law.
RMT-10A proves no result from that asymptotic argument. The citation is
deliberately scoped to shared vocabulary and measure architecture.

## The complete public API

The module exposes twenty-six public declarations. The following atlas keeps
unconditional algebra separate from conditional measure-valued probability.

### Ordered finite spectrum

| Declaration | Exact role |
|---|---|
| <code>orderedHermitianEigenvalues</code> | Decreasing real eigenvalue vector on <code>Fin n</code>, built from <code>eigenvalues₀</code> by an order-preserving cast |
| <code>orderedHermitianEigenvalues_antitone</code> | Lower indices carry no smaller eigenvalues |
| <code>trace_eq_sum_orderedHermitianEigenvalues</code> | Ordinary complex trace equals the sum of ordered real eigenvalues |
| <code>trace_sq_eq_sum_sq_orderedHermitianEigenvalues</code> | Trace of the square equals the sum of squared ordered eigenvalues |
| <code>orderedHermitianEigenvalues_hermitianCongruence</code> | Intrinsic unitary congruence preserves the entire ordered vector |

All five are unconditional finite-dimensional algebra.

### Spectral counting measure

| Declaration | Exact role |
|---|---|
| <code>spectralCountingMeasure</code> | Finite sum of one Dirac mass per ordered eigenvalue slot |
| <code>spectralCountingMeasure_hermitianCongruence</code> | Pointwise unitary invariance |
| <code>spectralCountingMeasure_zero</code> | Empty spectrum gives the zero measure |
| <code>spectralCountingMeasure_univ</code> | Total mass is the matrix dimension |
| <code>integral_complex_ofReal_spectralCountingMeasure</code> | First complex counting-measure moment equals trace |
| <code>integral_sq_complex_ofReal_spectralCountingMeasure</code> | Second complex counting-measure moment equals trace square |
| <code>measurable_spectralCountingMeasure_of_measurable_eigenvalues</code> | Giry measurability, conditional on every ordered eigenvalue coordinate being measurable |

Only the last row has the open coordinatewise premise.

### Empirical spectral measure

| Declaration | Exact role |
|---|---|
| <code>empiricalSpectralMeasure</code> | Inverse-dimension scaling of the counting measure, zero at dimension zero |
| <code>empiricalSpectralMeasure_hermitianCongruence</code> | Pointwise unitary invariance |
| <code>empiricalSpectralMeasure_zero</code> | Exact zero-dimensional value |
| <code>empiricalSpectralMeasure_isZeroOrProbability</code> | Uniform total-mass statement for every natural dimension |
| <code>empiricalSpectralMeasure_succ_isProbability</code> | Probability-measure theorem in every positive dimension |
| <code>empiricalSpectralProbability</code> | Positive-dimensional empirical measure bundled as <code>ProbabilityMeasure ℝ</code> |
| <code>measurable_empiricalSpectralMeasure_of_measurable_eigenvalues</code> | Conditional Giry measurability of the measure-valued map |
| <code>measurable_empiricalSpectralProbability_of_measurable_eigenvalues</code> | Conditional measurability of the positive-dimensional wrapper |

The first six are unconditional. The last two display the unresolved premise.

### Ambient totalization and GUE bridge

| Declaration | Exact role |
|---|---|
| <code>matrixToHermitianOrZero</code> | Convert a Hermitian ambient matrix to the intrinsic carrier, otherwise return zero |
| <code>measurable_matrixToHermitianOrZero</code> | Unconditional measurability of that piecewise totalization |
| <code>matrixToHermitianOrZero_hermitianToMatrix</code> | Left-inverse theorem on every intrinsic Hermitian input |
| <code>ambientEmpiricalSpectralMeasure</code> | Compose the totalization with the intrinsic empirical measure |
| <code>measurable_ambientEmpiricalSpectralMeasure_of_measurable_eigenvalues</code> | Conditional measurability of the ambient observable |
| <code>map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw_of_measurable_eigenvalues</code> | Conditional equality of the ambient and intrinsic GUE pushforward measures |

The final equality is the strongest law-level theorem in the file, and its
hypothesis is part of its mathematical content.

## Common wrong turns

### Calling <code>eigenvalues</code> sorted

Mathlib's <code>eigenvalues</code> is reindexed by a general finite
equivalence. Use <code>eigenvalues₀</code> when order matters, then transport
that index with an order-preserving cast.

### Replacing multiplicity by distinct locations

The empirical measure counts index slots. Collapsing repeated values to a set
changes total mass before normalization and changes every moment afterward.

### Calling the zero-dimensional object a probability measure

The project returns the zero measure at \(n=0\). It has mass zero. Only the
<code>n + 1</code> wrapper is a genuine <code>ProbabilityMeasure</code>.

### Confusing an empirical measure with its law

\(L_H\) is one measure on \(\mathbb R\). A random \(H\) may induce a probability
law on a space of such measures, but that is a pushforward and needs
measurability.

### Treating antitonicity as measurability

<code>orderedHermitianEigenvalues_antitone</code> compares coordinates within
one fixed matrix. It does not compare nearby matrices and does not imply that
\(H\mapsto\lambda_i(H)\) is measurable.

### Forgetting the hypothesis in the GUE bridge

The ambient-versus-intrinsic pushforward equality assumes coordinatewise
eigenvalue measurability. The theorem does not make that premise disappear.

### Reading zero totalization as non-Hermitian spectral theory

<code>matrixToHermitianOrZero</code> is an extension policy. On a
non-Hermitian input it does not calculate that input's complex spectrum.

### Inferring asymptotics from finite moments

The trace and trace-square identities hold exactly at each finite dimension.
They do not prove tightness, convergence, a semicircle law, or universality.

## What has and has not been proved

| Topic | Current repository status from RMT-10A onward |
|---|---|
| Real eigenvalues of an intrinsic finite Hermitian matrix | Checked through Mathlib's finite spectral API |
| Decreasing eigenvalue vector on <code>Fin n</code> | Defined and antitonicity checked |
| Multiplicity preservation | Built into the indexed vector and Dirac sum |
| Trace as first eigenvalue power sum | Checked |
| Trace square as second eigenvalue power sum | Checked |
| Ordered-vector unitary invariance | Checked |
| Spectral counting measure and total mass | Checked |
| First two counting-measure moments | Checked |
| Empirical spectral measure | Defined for all dimensions |
| Zero-dimensional empirical measure | Checked equal to zero |
| Positive-dimensional probability property | Checked |
| Positive-dimensional <code>ProbabilityMeasure</code> wrapper | Defined |
| Measurable Hermitian-or-zero ambient totalization | Checked |
| Coordinatewise ordered-eigenvalue measurability | Checked in successor RMT-10B |
| Unconditional measure-valued GUE observable | Checked in successor RMT-10B |
| Unconditional GUE empirical spectral law | Constructed in successor RMT-10C |
| Intrinsic/ambient GUE pushforward agreement | Checked conditionally here and unconditionally in RMT-10B/RMT-10C |
| Empirical-moment bridge to RMT-09 expectations | Checked for the first two moments in successor RMT-10C |
| Joint eigenvalue density | Not checked |
| Semicircle law or any large-dimension convergence | Not checked |
| Concentration, rigidity, or extreme-eigenvalue limits | Not checked |
| Unfolding and local spacing statistics | Not checked |
| Spectral form factor or out-of-time-order correlator | Not checked |

## Exercises from trailhead to summit

### Trailhead

1. Compute the ordered eigenvalue vector, counting measure, and empirical
   measure of a two-dimensional scalar matrix \(aI\). How is multiplicity
   represented?
2. For the worked three-dimensional example, evaluate \(L_H(B)\) when
   \(B=[-2,0]\), \(B=\{-1\}\), and \(B=(0,\infty)\).
3. Show directly that the total mass of
   \(\sum_i\delta_{\lambda_i}\) is the number of index slots, even when all
   eigenvalues coincide.
4. Explain in plain language why the empirical measure forgets eigenvectors.

### Mid-mountain

5. Starting from \(H=UDU^*\), derive
   \(\operatorname{Tr}(H^2)=\operatorname{Tr}(D^2)\) one matrix-associativity
   step at a time.
6. Prove that equal characteristic polynomials of Hermitian matrices imply
   equal decreasing eigenvalue vectors. Identify where real roots and sorting
   enter.
7. Give a finite permutation of an eigenvalue vector. Prove that its Dirac sum
   is unchanged while its coordinate-zero value may change.
8. Compare the types <code>Measure ℝ</code> and
   <code>ProbabilityMeasure ℝ</code>. Which field or proof is added by the
   latter?
9. Propose two possible conventions at dimension zero. Explain why the
   arbitrary-Dirac convention is total and probabilistic but spectrally
   dishonest.

### Summit

10. Assume each \(H\mapsto\lambda_i(H)\) is measurable. Build the measurability
    proof for \(H\mapsto\sum_i\delta_{\lambda_i(H)}\) from measurable Dirac and
    finite addition.
11. Explain why scaling a measurable measure-valued map by a fixed extended
    nonnegative real preserves measurability in the Giry structure.
12. Expand the intrinsic-versus-ambient GUE pushforward proof as a commuting
    diagram. Label the use of <code>Measure.map_map</code> and the left-inverse
    theorem.
13. State a continuity or perturbation theorem that would imply coordinatewise
    eigenvalue measurability. Be precise about the matrix norm and eigenvalue
    ordering.
14. Reconstruct the successor RMT-10C definition of the unconditional named
    GUE empirical spectral law and derive its dimension-zero behavior without
    inventing a probability measure on an empty spectrum.
15. Assuming positive dimension, combine the counting-measure moments with
    RMT-09 to derive the expected first two empirical moments under the
    project's Wigner-scaled GUE. Compare your route with RMT-10C and mark which
    steps belong to deterministic algebra, integrability, and law transport.

## Reproduce the checked slice

From the repository root, load the pinned Lean toolchain and compile the module
with warnings treated as errors:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomMatrices/HermitianSpectrum.lean
~~~

Build the targeted module and its dependencies:

~~~sh
lake build NonlinearDynamics.Random.RandomMatrices.HermitianSpectrum
~~~

Return to the repository root and build the complete draft teaching site:

~~~sh
cd ..
make site-check
~~~

The repository-wide milestone gate is <code>make check</code>. A green
technical build does not complete editorial review of this public working note.
The required human mathematical and publication reviews remain pending.

## Where to continue

The {{< refterm "empirical-spectral-measure" "empirical spectral measure" >}}
entry is the compact operational reference. Read
{{< refterm "finite-matrix-trace-moment" "finite matrix trace moment" >}} for
the preceding integrability and expectation layer, and
{{< refterm "unitary-invariance" "unitary invariance" >}} for the symmetry
distinction used here.

[First Exact Finite Gaussian Unitary Ensemble Trace Moments]({{< relref "/knowledge-base/deep-dives/first-exact-finite-gue-trace-moments" >}})
supplies the finite expected trace identities that a later empirical-moment
bridge can consume.
[From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance]({{< relref "/knowledge-base/deep-dives/normalized-hermitian-coordinates-to-gue-invariance" >}})
constructs the intrinsic law and ambient pushforward identity used by the
conditional comparison.

The successor formal milestone now proves coordinatewise continuity and
measurability of the ordered Hermitian eigenvalues:
[Hermitian Spectral Perturbation, Continuity, and Measurability]({{< relref "/knowledge-base/deep-dives/hermitian-spectral-perturbation-continuity-and-measurability" >}}).
It removes the hypotheses from the Giry interfaces and proves the
ambient-versus-intrinsic GUE pushforward equality unconditionally. The next
layer is now available:
[Finite Gaussian Unitary Ensemble Empirical Spectral Laws and Normalized Moments]({{< relref "/knowledge-base/deep-dives/finite-gue-empirical-spectral-laws-and-normalized-moments" >}})
names the law, packages it as a probability measure, forms its Giry mean, and
checks the first two normalized expected sample moments.

## References

<a id="ref-spectrum-mathlib-spectrum"></a>**Mathlib contributors.**
[Spectral theory of Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Spectrum.html),
Mathlib 4 documentation. This official page proves the finite Hermitian
spectral theorem and defines <code>eigenvalues₀</code>, its antitonicity,
the generally reindexed <code>eigenvalues</code>, characteristic-polynomial
root identities, and trace as an eigenvalue sum.

<a id="ref-spectrum-mathlib-atoms"></a>**Mathlib contributors.**
[Dirac measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Dirac.html)
and
[counting measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Count.html),
Mathlib 4 documentation. These official APIs define point masses, their
integrals and pushforwards, and counting measure as a sum of Dirac measures.
RMT-10A uses the finite indexed version of that atomic pattern.

<a id="ref-spectrum-mathlib-giry"></a>**Mathlib contributors.**
[The Giry measurable structure on measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/GiryMonad.html),
Mathlib 4 documentation. This official module equips all measures with the
evaluation-generated measurable structure and proves the measurability of the
measure constructors used by the conditional spectral interfaces.

<a id="ref-spectrum-mathlib-probability"></a>**Mathlib contributors.**
[Probability measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/ProbabilityMeasure.html)
and
[probability-measure typeclasses](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Typeclasses/Probability.html),
Mathlib 4 documentation. These official pages define
<code>ProbabilityMeasure</code> as a subtype with total mass one and
<code>IsZeroOrProbabilityMeasure</code> as the zero-or-unit-mass interface.

<a id="ref-spectrum-tao-vu"></a>**Terence Tao, Van Vu, with an appendix by Manjunath Krishnapur.**
[Random matrices: Universality of ESDs and the circular law](https://arxiv.org/abs/0807.4898v5),
arXiv:0807.4898v5, revised 23 April 2009 and accessed 21 July 2026; published
in *The Annals of Probability* 38 (2010), 2023-2065,
[doi:10.1214/10-AOP534](https://doi.org/10.1214/10-AOP534). This primary source
defines normalized eigenvalue counting for general complex matrices and
studies non-Hermitian circular-law asymptotics. It is cited only for the
finite empirical-spectral-distribution convention and the distinction between
a sample distribution and its limiting behavior.

<a id="ref-spectrum-dyson"></a>**Freeman J. Dyson.**
[The Threefold Way: Algebraic Structure of Symmetry Groups and Ensembles in Quantum Mechanics](https://doi.org/10.1063/1.1703863),
*Journal of Mathematical Physics* 3 (1962), 1199-1215. This primary source
supplies historical physics context for the unitary symmetry class. It does
not supply the project-specific finite measure definitions or any theorem
formalized in RMT-10A.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
