---
title: "Empirical spectral measure"
slug: "empirical-spectral-measure"
summary: "An empirical spectral measure gives equal mass to every eigenvalue of one finite matrix, counting repeated eigenvalues with multiplicity."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.HermitianSpectrum"
og_image: "empirical-spectral-measure-card.png"
og_image_alt: "A finite ordered Hermitian spectrum becomes one point mass per eigenvalue slot, then equal weighting turns the counting measure into an empirical spectral measure; the empty spectrum follows a separate zero-measure branch."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page must remain a draft until that review is complete.
{{< /panel >}}

An **empirical spectral measure** places equal mass on every eigenvalue of one
finite matrix, with repeated eigenvalues repeated according to their algebraic
multiplicity. In positive dimension it is a probability measure. In this
project it is explicitly the zero measure at dimension zero. The construction
turns a finite list of spectral locations into a measure, so questions about
many individual eigenvalues can be expressed as integrals against one object.

For an \(n\)-by-\(n\) Hermitian matrix \(H\) with real eigenvalues
\(\lambda_0(H),\ldots,\lambda_{n-1}(H)\), the positive-dimensional definition
is

\[
L_H=\frac1n\sum_{i=0}^{n-1}\delta_{\lambda_i(H)}.
\]

Here \(\delta_x\) is the Dirac measure concentrated at \(x\). The project first
defines the unnormalized **spectral counting measure**

\[
N_H=\sum_{i=0}^{n-1}\delta_{\lambda_i(H)},
\]

then defines \(L_H=n^{-1}N_H\). The two objects answer different questions.
\(N_H\) remembers that the matrix has total spectral multiplicity \(n\), while
\(L_H\) assigns total mass one when \(n\gt0\).

{{< reference-figure
  src="count-normalize-spectrum.svg"
  alt="A decreasing list of real Hermitian eigenvalues, including a repeated value, becomes one Dirac point mass for every index slot. Equal weighting produces one empirical spectral measure in positive dimension, while an empty spectrum follows an explicit zero-measure branch."
  caption="**Finding:** multiplicity belongs to the index slots, not merely to the set of distinct spectral locations. The counting measure places one atom at every slot, so coincident eigenvalues add their masses. Equal weighting produces a probability measure only in positive dimension. This conceptual plate does not assert that the eigenvalue map is measurable or that any random-matrix limit exists."
>}}

## Multiplicity is part of the measure

Consider the Hermitian matrix

\[
H=
\begin{bmatrix}
4&0&0\\
0&1&0\\
0&0&1
\end{bmatrix}.
\]

Its distinct spectral locations form the set \(\{4,1\}\), but its ordered
eigenvalue vector is \((4,1,1)\). The counting and empirical measures are

\[
N_H=\delta_4+2\delta_1,
\qquad
L_H=\frac13\delta_4+\frac23\delta_1.
\]

The repeated eigenvalue at \(1\) carries twice the mass because two index
slots contain it. Replacing the eigenvalue vector by the set of distinct
values would lose multiplicity and give the wrong trace, the wrong total mass,
and the wrong spectral moments.

For a measurable set \(B\subseteq\mathbb R\), the empirical measure reads

\[
L_H(B)=\frac1n\#\{i:\lambda_i(H)\in B\}.
\]

Thus it is literally the fraction of eigenvalue slots lying in \(B\). Mathlib's
Dirac-measure API formalizes the unit atom, while its counting-measure API
formalizes counting as a sum of Dirac measures
([Mathlib contributors](#ref-esm-mathlib-atoms)). The project uses an explicit
finite sum because the measure is attached to the finite spectrum of one
matrix rather than to every point of the ambient real line.

## Ordering matters before the measure forgets it

An empirical measure is unchanged by permuting the eigenvalue vector. Why,
then, does the project insist on an ordered vector?

The order supplies a canonical coordinate interface. For Hermitian matrices,
Mathlib provides <code>Matrix.IsHermitian.eigenvalues₀</code>, indexed by a
finite ordinal whose size is the matrix dimension, and proves that this vector
is antitone. In project notation,

\[
i\le j\quad\Longrightarrow\quad\lambda_i(H)\ge\lambda_j(H).
\]

Mathlib also provides <code>eigenvalues</code> on the matrix's original index
type, but that definition reindexes through a general finite equivalence. A
general equivalence preserves cardinality, not order. Treating that vector as
sorted would smuggle in a false property.

The project therefore transports <code>eigenvalues₀</code> to
<code>Fin n</code> using the order-preserving cast supplied by the equality
between the cardinality of <code>Fin n</code> and \(n\). The resulting
<code>orderedHermitianEigenvalues</code> is checked to be antitone. This choice
keeps statements about largest and smallest coordinates meaningful, even
though the later sum of Dirac measures is permutation invariant. The official
Mathlib spectrum page documents the sorted vector, its antitonicity, the
arbitrary reindexing, and the spectral theorem
([Mathlib contributors](#ref-esm-mathlib-spectrum)).

## Counting measure, empirical measure, and spectral law

Three levels are easy to conflate:

| Object | Input | Output | Total mass |
|---|---|---|---|
| Spectral counting measure \(N_H\) | One deterministic Hermitian matrix | A measure on \(\mathbb R\) | \(n\) |
| Empirical spectral measure \(L_H\) | One deterministic Hermitian matrix | A measure on \(\mathbb R\) | One for \(n\gt0\), zero at \(n=0\) by project convention |
| Law of the empirical spectral measure | A random Hermitian matrix law | A measure on a space of measures | One, provided the sample-to-measure map is measurable and the source law is probabilistic |

The adjective *empirical* does not mean that experimental data were collected.
It says that one finite realization contributes one equal-weighted atom per
eigenvalue slot. If \(H(\omega)\) is a random matrix, then \(L_{H(\omega)}\) is
a measure-valued random object only after the map
\(\omega\mapsto L_{H(\omega)}\) has been proved measurable. Its probability law
is a further pushforward.

This hierarchy mirrors the distinction between a random variable and its law.
One sampled empirical measure is not the same object as the distribution of
empirical measures across repeated matrix samples. Neither is the same as an
expected empirical measure, which would average \(L_H\) over the matrix law.

## The explicit zero-dimensional convention

The formula \(n^{-1}N_H\) needs a boundary policy at \(n=0\). The project does
not invent an eigenvalue or use ordinary real division by zero. Its scalar is
an extended nonnegative real: there, the inverse of zero is infinity. The
spectral counting measure over the empty index type is zero, and infinity
scaled by the zero measure is zero. Therefore

\[
N_H=0,
\qquad
L_H=0
\quad\text{when }n=0.
\]

The zero measure is not a probability measure because its total mass is zero.
The theorem
<code>empiricalSpectralMeasure_isZeroOrProbability</code> records the honest
uniform statement for every natural dimension. A genuine
<code>ProbabilityMeasure ℝ</code> wrapper is exposed only for matrices of size
<code>n + 1</code>, where positivity is built into the type of the dimension.
Mathlib defines <code>ProbabilityMeasure</code> as the subtype of measures with
total mass one, and <code>IsZeroOrProbabilityMeasure</code> as the disjunction
between total mass zero and total mass one
([Mathlib contributors](#ref-esm-mathlib-probability)).

This is more than a Lean convenience. A total definition over all natural
dimensions is useful for recursive constructions, but totality should not
erase the fact that an empty spectrum has no uniform probability distribution
over its elements.

## Trace identities become moment identities

The spectral theorem diagonalizes a Hermitian matrix by a unitary basis. The
first two power sums of the eigenvalues recover familiar matrix observables:

\[
\operatorname{Tr}(H)=\sum_i\lambda_i(H),
\qquad
\operatorname{Tr}(H^2)=\sum_i\lambda_i(H)^2.
\]

The project proves both identities for its ordered vector. Equivalently, the
first two complex-valued moments of the counting measure are

\[
\int_{\mathbb R}x\,\mathrm dN_H(x)=\operatorname{Tr}(H),
\qquad
\int_{\mathbb R}x^2\,\mathrm dN_H(x)=\operatorname{Tr}(H^2).
\]

For positive dimension, dividing by \(n\) yields the corresponding empirical
moments. RMT-10A states the counting-measure identities directly. The
successor RMT-10C layer now defines those normalized sample moments and
combines their first two cases with the expected finite Gaussian unitary
ensemble (GUE) trace moments from RMT-09. See the
{{< refterm "empirical-spectral-law" "empirical spectral law" >}} entry and
[Finite Gaussian Unitary Ensemble Empirical Spectral Laws and Normalized Moments]({{< relref "/knowledge-base/deep-dives/finite-gue-empirical-spectral-laws-and-normalized-moments" >}}).

## Unitary changes of basis do not move spectral mass

If \(U\) is unitary, then \(UHU^*\) represents the same Hermitian operator in a
different orthonormal basis. Its characteristic polynomial, ordered
eigenvalue vector, counting measure, and empirical measure are unchanged:

\[
L_{UHU^*}=L_H.
\]

The Lean proof first identifies the characteristic polynomials, then compares
the decreasingly sorted real roots. This avoids arguing that two arbitrary
eigenvalue enumerations agree coordinate by coordinate. The result is
pointwise and deterministic. It does not require a random-matrix law.

## The RMT-10A measurability seam and its discharge

The algebraic definition exists for every intrinsic finite Hermitian matrix,
but a law on empirical measures needs more. The target <code>Measure ℝ</code>
uses Mathlib's Giry measurable structure, generated by evaluation maps
\(\mu\mapsto\mu(B)\) on measurable sets \(B\). In that structure, Dirac
embedding and the relevant finite measure operations are measurable
([Mathlib contributors](#ref-esm-mathlib-giry)).

The input left open by RMT-10A was measurability of each ordered eigenvalue
coordinate as a function of the matrix. Pinned Mathlib supplies the algebraic
ordered eigenvalues but does not supply the continuity or measurability theorem
needed by this project. The RMT-10A module therefore exposes conditional
interfaces:

~~~lean
theorem measurable_empiricalSpectralMeasure_of_measurable_eigenvalues
    (h : ∀ i, Measurable (fun H => orderedHermitianEigenvalues H i)) :
    Measurable empiricalSpectralMeasure
~~~

Read the hypothesis as a genuine premise of that theorem, not as documentation
of an automatically available instance. The successor RMT-10B module now
proves a Frobenius {{< refterm "weyl-eigenvalue-bound" "Weyl eigenvalue bound" >}},
deduces 1-Lipschitz continuity and coordinatewise measurability, and applies
that result to discharge this premise. The conditional theorem remains the
compositional bridge; the later theorem supplies its input.

## What the checked layer establishes

The RMT-10A module checks:

- a decreasing real eigenvalue vector with multiplicity;
- exact trace and trace-square power-sum identities;
- invariance of the ordered vector under intrinsic unitary congruence;
- finite spectral counting measure, including total mass \(n\);
- the zero-aware empirical spectral measure;
- the zero-or-probability theorem in every dimension;
- a positive-dimensional <code>ProbabilityMeasure</code> wrapper;
- a measurable Hermitian-or-zero totalization on ambient complex matrices;
- conditional Giry-measurability theorems; and
- a conditional equality between the ambient and intrinsic GUE pushforwards.

RMT-10A itself does **not** prove coordinatewise eigenvalue measurability or
continuity. RMT-10B now supplies those results and an unconditional equality of
the ambient and intrinsic GUE empirical-spectral pushforwards. Neither module
proves an eigenvalue density, semicircle law, concentration estimate, unfolding
procedure, spacing statistic, universality result, or large-dimension limit.

The empirical spectral distribution (ESD) in Tao, Vu, and Krishnapur's
circular-law paper is also a normalized eigenvalue-counting object, but that paper studies
general complex non-Hermitian matrices and eigenvalues in the complex plane
([Tao, Vu, and Krishnapur](#ref-esm-tao-vu)). It is cited here for a primary
example of the empirical-spectral-distribution convention and its later
asymptotic use, not as evidence for any Hermitian, GUE, or Lean theorem in this
project.

## Exercises

1. Compute \(N_H\) and \(L_H\) for a diagonal matrix with eigenvalue vector
   \((3,3,-2,-2)\). Evaluate both measures on the singleton \(\{3\}\).
2. Show that permuting an eigenvalue vector leaves its sum of Dirac measures
   unchanged. Explain why this does not make an ordered coordinate API
   useless.
3. For positive \(n\), derive the first two moments of \(L_H\) from the checked
   counting-measure identities.
4. Explain why there is no uniform probability measure on an empty finite
   spectrum. Compare the zero-measure convention with an arbitrary Dirac
   fallback and state which one preserves spectral meaning.
5. Draw the type distinction between a matrix \(H\), its empirical measure
   \(L_H\), and a probability law on the space containing \(L_H\).
6. Identify the exact hypothesis needed before pushing a matrix law through
   <code>empiricalSpectralMeasure</code>. Why does pointwise algebra not prove
   it?

## Where to continue

[Finite Hermitian Spectra and Empirical Measures]({{< relref "/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures" >}})
develops the spectral theorem, the Lean index choice, all three measure levels,
the ambient totalization, and the conditional GUE bridge as one continuous
ascent.
[Hermitian Spectral Perturbation, Continuity, and Measurability]({{< relref "/knowledge-base/deep-dives/hermitian-spectral-perturbation-continuity-and-measurability" >}})
proves the Frobenius perturbation theorem that makes those measure-valued maps
unconditionally measurable. The
{{< refterm "finite-matrix-trace-moment" "finite matrix trace moment" >}}
entry explains the earlier expectation layer, while
{{< refterm "unitary-invariance" "unitary invariance" >}} explains the symmetry
that leaves these measures unchanged.

## References

<a id="ref-esm-mathlib-spectrum"></a>**Mathlib contributors.**
[Spectral theory of Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Spectrum.html),
Mathlib 4 documentation. This official page defines
<code>eigenvalues₀</code>, proves its antitonicity, documents the generally
reindexed <code>eigenvalues</code>, and supplies the finite Hermitian spectral
theorem used by the project.

<a id="ref-esm-mathlib-atoms"></a>**Mathlib contributors.**
[Dirac measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Dirac.html)
and
[counting measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Count.html),
Mathlib 4 documentation. These official APIs define the atomic measure and
explain counting measure as a sum of Dirac masses. The project specializes
that pattern to a finite indexed spectrum.

<a id="ref-esm-mathlib-probability"></a>**Mathlib contributors.**
[Probability measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/ProbabilityMeasure.html)
and
[probability-measure typeclasses](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Typeclasses/Probability.html),
Mathlib 4 documentation. These official pages define the subtype of measures
with total mass one and the zero-or-probability interface used at the
zero-dimensional boundary.

<a id="ref-esm-mathlib-giry"></a>**Mathlib contributors.**
[The Giry measurable structure on measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/GiryMonad.html),
Mathlib 4 documentation. Mathlib equips the space of all measures with the
evaluation-generated measurable structure and proves measurability of Dirac,
map, finite addition, and related operations consumed by the conditional
interfaces.

<a id="ref-esm-tao-vu"></a>**Terence Tao, Van Vu, with an appendix by Manjunath Krishnapur.**
[Random matrices: Universality of ESDs and the circular law](https://arxiv.org/abs/0807.4898v5),
arXiv:0807.4898v5, revised 23 April 2009 and accessed 21 July 2026; published
in *The Annals of Probability* 38 (2010), 2023-2065,
[doi:10.1214/10-AOP534](https://doi.org/10.1214/10-AOP534). The paper defines
the normalized empirical spectral distribution of a general complex matrix
and studies non-Hermitian circular-law asymptotics. Only the finite normalized
counting convention is used as context here.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
