---
title: "Ordered Hermitian Spectra in Lean: From Eigenvalues to Empirical Measures"
slug: "ordered-hermitian-spectra-and-empirical-measures"
date: 2026-07-21
weight: -20
author: "tdj28"
summary: "A machine-checked finite spectral layer: decreasingly ordered Hermitian eigenvalues with multiplicity, exact trace identities, unitary-congruence invariance, counting and zero-aware empirical measures, and honest conditional interfaces for the still-missing eigenvalue measurability theorem."
lead: |
  A spectrum is more than a list of roots. To become a probability observable, it needs a stable ordering, multiplicity bookkeeping, a finite measure, a zero-dimensional convention, and measurability into a space of measures. RMT-10A formalizes every algebraic and measure-valued step that does not depend on eigenvalue perturbation theory, then leaves the missing measurability theorem visible as an explicit hypothesis.
key_result: |
  Lean now packages every intrinsic finite Hermitian matrix as a decreasing real eigenvalue vector indexed by `Fin n`. It proves that the vector recovers the trace and the trace of the matrix square, is unchanged by unitary congruence, and generates a counting measure of mass `n` plus a zero-aware empirical measure. The empirical measure is zero at `n = 0`, is a probability measure in positive dimension, and becomes a measurable random measure only under an explicit coordinatewise eigenvalue-measurability hypothesis.
draft: true
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Finite Hermitian spectral theory, measure-valued observables, and Lean proof engineering"
reading_time: "85 to 120 minutes"
prerequisites:
  - "Finite Hermitian matrices and the spectral theorem"
  - "Pushforward probability laws and the Giry measurable structure"
  - "The intrinsic and ambient finite GUE laws"
  - "The first two exact finite GUE trace moments"
  - "No prior Lean proof experience required"
lean_module: "NonlinearDynamics.Random.RandomMatrices.HermitianSpectrum"
lean_source: "formalization/NonlinearDynamics/Random/RandomMatrices/HermitianSpectrum.lean"
tags:
  - "Lean 4"
  - "Hermitian spectrum"
  - "Ordered eigenvalues"
  - "Empirical spectral measure"
  - "Counting measure"
  - "Giry monad"
  - "Gaussian unitary ensemble"
og_image: "ordered-hermitian-spectra-and-empirical-measures-card.png"
og_image_alt: "Warm-paper teaching card showing a finite Hermitian matrix passing to a decreasing eigenvalue list, then to counting and empirical measures; the footer states that the measurability hypothesis remains visible."
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
**Editorial status.** This teaching chapter remains a draft while human
editorial acceptance and the separate scientific-integrity and zero-context
expert-reader reviews are pending. The checked Lean source is authoritative
for every theorem statement.
{{< /panel >}}

{{< panel "info" >}}
**Abstract.** A finite Hermitian matrix has real eigenvalues and a unitary
diagonalization. Turning that theorem into a reusable random-matrix interface
requires several choices that ordinary paper notation often suppresses. The
eigenvalues must be indexed, repeated roots must retain multiplicity, the
ordering must survive reindexing, and the resulting finite cloud must be
packaged as a measure. If dimension zero is admitted, normalization cannot
pretend that a probability measure exists there.

RMT-10A makes those choices explicit. It transports Mathlib's decreasingly
sorted `Matrix.IsHermitian.eigenvalues₀` vector to `Fin n` with an
order-preserving cast. The resulting `orderedHermitianEigenvalues` is
antitone, its first and second power sums recover the complex trace and trace
square, and unitary congruence preserves the entire ordered vector. A finite
sum of Dirac masses gives `spectralCountingMeasure`; scaling by the inverse
dimension gives `empiricalSpectralMeasure`. The counting measure has mass
`n`. The empirical measure is zero in dimension zero, satisfies the
zero-or-probability predicate in every dimension, and has a genuine
`ProbabilityMeasure` wrapper only in successor dimension.

The module does not hide the remaining analytic gap. Pinned Mathlib exposes
the algebraic sorted eigenvalue API but no theorem here establishes its
continuity or measurability as the matrix varies. Every theorem that produces
a measurable measure-valued observable therefore accepts coordinatewise
eigenvalue measurability as a hypothesis. The final ambient/intrinsic GUE
pushforward identity is exact under that hypothesis, but it is not an
unconditional construction of a GUE empirical spectral law.
{{< /panel >}}

This is the proof-to-prose companion for
`formalization/NonlinearDynamics/Random/RandomMatrices/HermitianSpectrum.lean`.
Every public declaration and both private proof helpers in that stable source
are mapped below.

The immediate predecessor,
[The First Exact GUE Trace Moments]({{< relref "/development-notebook/2026/07/gue-first-exact-trace-moments" >}}),
computed the first two matrix trace moments without eigenvalues. The present
chapter builds the deterministic spectral object that can eventually turn
those trace powers into moments of an empirical spectral measure. The broader
textbook ascent is introduced in
[Random Matrices: From Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}}).

Reusable background appears under
{{< refterm "empirical-spectral-measure" >}},
{{< refterm "hermitian-matrix" >}},
{{< refterm "matrix-trace" >}},
{{< refterm "trace-power" >}},
{{< refterm "unitary-invariance" >}},
{{< refterm "pushforward-measure" >}},
{{< refterm "probability-law" >}}, and
{{< refterm "normalization-convention" >}}.

## Choose a route up

| Route | Begin | Destination |
|---|---|---|
| First encounter | [One matrix, three spectral objects](#one-matrix-three-spectral-objects) | See why a vector, a counting measure, and an empirical measure are different |
| Algebra route | [A decreasing vector with multiplicity](#a-decreasing-vector-with-multiplicity) | Understand the ordered Mathlib eigenvalue interface |
| Trace route | [The first two spectral power sums](#the-first-two-spectral-power-sums) | Recover the trace and the trace of the matrix square from eigenvalues |
| Symmetry route | [Unitary congruence preserves the ordered vector](#unitary-congruence-preserves-the-ordered-vector) | Follow characteristic polynomials through a basis change |
| Measure route | [From repeated eigenvalues to a counting measure](#from-repeated-eigenvalues-to-a-counting-measure) | Package multiplicity as Dirac mass |
| Boundary route | [Why dimension zero cannot be a probability measure](#why-dimension-zero-cannot-be-a-probability-measure) | Audit the zero-aware normalization policy |
| Probability route | [Measures as measurable outputs](#measures-as-measurable-outputs) | Learn the Giry interface and its exact missing hypothesis |
| Ambient route | [Totalizing an intrinsic observable](#totalizing-an-intrinsic-observable) | Compare the ambient and intrinsic GUE pushforwards |
| Lean route | [The complete declaration map](#the-complete-declaration-map) | Inspect all twenty-six public declarations and two private helpers |
| Integrity route | [Strict nonclaims](#strict-nonclaims) | Separate this finite algebraic layer from perturbation and asymptotics |

### Learning objectives

By the summit, a reader should be able to:

1. explain why an unordered multiset, an ordered eigenvalue vector, a counting
   measure, and a probability measure serve different jobs;
2. read `Antitone` as a decreasing-order guarantee on `Fin n`;
3. explain why repeated indices preserve algebraic multiplicity;
4. distinguish Mathlib's `eigenvalues₀` ordering from its arbitrarily
   reindexed `eigenvalues` function;
5. follow the order-preserving `Fin.castOrderIso` reindexing used by the
   project;
6. derive the trace as the first eigenvalue power sum;
7. derive the trace of the square as the second eigenvalue power sum;
8. explain how unitary congruence preserves the characteristic polynomial and
   therefore the entire sorted vector;
9. interpret a finite sum of Dirac measures as a multiplicity-aware spectral
   counting measure;
10. distinguish mass `n` from mass one;
11. audit the explicit `n = 0` policy for the empirical measure;
12. understand why `IsZeroOrProbabilityMeasure` is the correct all-dimension
    statement and `IsProbabilityMeasure` is restricted to successor dimension;
13. read `ProbabilityMeasure ℝ` as a bundled positive-dimensional object;
14. explain what Giry measurability of a measure-valued map means;
15. identify coordinatewise eigenvalue measurability as a hypothesis, not a
    theorem proved in this module;
16. understand why an ambient matrix observable needs a total extension away
    from the Hermitian locus;
17. follow the exact ambient/intrinsic GUE pushforward bridge; and
18. state precisely which density, perturbation, random-law, and asymptotic
    claims remain open.

## One matrix, three spectral objects

{{< mermaid >}}
flowchart LR
  H["intrinsic Hermitian matrix"] --> E["decreasing real eigenvalue vector"]
  E --> C["one Dirac mass per index"]
  C --> M["counting measure of mass equal to dimension"]
  M --> N["dimension-normalized empirical measure"]
  Z["dimension zero"] --> Q["zero measure policy"]
  Q --> N
  P["coordinatewise eigenvalue measurability"] --> G["measurable random measure"]
  N --> G
{{< /mermaid >}}

<p class="figure-note"><strong>Figure.</strong> The algebraic path from a
Hermitian matrix to its ordered spectrum and finite spectral measures is
checked without an analytic hypothesis. The last arrow, from a matrix-varying
empirical measure to a measurable random measure, is conditional on
coordinatewise eigenvalue measurability. Dimension zero follows a separate
zero-measure policy rather than pretending that an empty spectrum has total
mass one.</p>

The diagram separates three objects that are easy to blur in handwritten
notation.

- The **ordered vector** remembers which eigenvalue is largest, second
  largest, and so on. Equal values may occupy several indices.
- The **counting measure** forgets the names of the indices but keeps their
  multiplicities as repeated Dirac mass. Its total mass is the dimension.
- The **empirical measure** divides that mass by the dimension when the
  dimension is positive. It gives equal weight to every eigenvalue occurrence.

The ordered vector is convenient for edge statistics and perturbation bounds.
The empirical measure is convenient for integration and weak convergence.
Neither is interchangeable with the matrix law itself. A matrix law is a
measure on matrices. An empirical spectral measure is one measure on the real
line produced from one matrix. A random empirical spectral law, when it is
legitimate to construct one, is a measure on the space of measures on the
real line.

## Base camp: the deterministic object comes first

Fix a natural dimension \(n\). The intrinsic carrier
`RandomMatrix.HermitianEuclidean n` is the real inner-product space of
Hermitian complex matrices developed in RMT-07. An element \(H\) has an
ambient matrix `hermitianToMatrix H` and a proof \(H^*=H\).

The finite spectral theorem gives real eigenvalues and a unitary
diagonalization. Pinned Mathlib packages that theorem through
`Matrix.IsHermitian.eigenvalues₀`, `eigenvectorUnitary`, and
`spectral_theorem` ([Mathlib matrix-spectrum documentation](#ref-mathlib-spectrum)).
The project deliberately starts there, before randomness. For each fixed
matrix, all statements in the first two-thirds of the module are algebraic or
finite-measure statements. They require no probability space and no GUE law.

This dependency order matters. If we first wrote "the random eigenvalue
distribution," several hidden obligations would be fused together:

| Obligation | Question it answers | Status in RMT-10A |
|---|---|---|
| Algebraic spectrum | What are the eigenvalues, with order and multiplicity? | Proved |
| Spectral measures | How does one matrix become a finite measure? | Defined and normalized |
| Matrix-varying measurability | Is the spectral object a random variable? | Conditional interface only |
| Pushforward law | What is the distribution of the random spectral object? | Equality proved under the same hypothesis |
| Asymptotics | What happens as dimension grows? | Not addressed |

The point is not bureaucratic caution. Each row lives in a different
mathematical category. A correct statement in one row cannot silently supply
the next.

## A decreasing vector with multiplicity

### Why `eigenvalues₀` is the right source

Mathlib exposes two related Hermitian eigenvalue functions. The distinction is
small in type syntax and large in meaning.

- `Matrix.IsHermitian.eigenvalues₀` is indexed by
  `Fin (Fintype.card (Fin n))` and is decreasing by construction.
- `Matrix.IsHermitian.eigenvalues` is reindexed to the matrix index type by
  `Fintype.equivOfCardEq`. That equivalence supplies a bijection, but it is not
  an order theorem.

For a statement such as "the largest eigenvalue is coordinate zero," arbitrary
reindexing is not acceptable. RMT-10A therefore defines:

```lean
noncomputable def orderedHermitianEigenvalues {n : ℕ}
    (H : HermitianEuclidean n) : Fin n → ℝ :=
  fun i => H.2.eigenvalues₀ (Fin.cast (Fintype.card_fin n).symm i)
```

`Fintype.card_fin n` proves that the cardinality of `Fin n` is `n`. Its
symmetric equality transports an index from `Fin n` to the natural index of
`eigenvalues₀`. The corresponding `Fin.castOrderIso` is an order isomorphism,
so this transport preserves the sorted interpretation.

The definition is `noncomputable` because the eigenvalue construction uses
classical spectral data. That does not weaken its theorem content. It means
Lean is specifying the value extensionally rather than extracting an
executable numerical eigensolver.

### Decreasing means antitone

The theorem
`orderedHermitianEigenvalues_antitone` states:

```lean
theorem orderedHermitianEigenvalues_antitone {n : ℕ}
    (H : HermitianEuclidean n) :
    Antitone (orderedHermitianEigenvalues H)
```

For indices \(i\le j\), antitonicity says
\(\lambda_i(H)\ge \lambda_j(H)\). The proof sends the index inequality through
`Fin.cast_le_cast` and invokes Mathlib's
`Matrix.IsHermitian.eigenvalues₀_antitone`. This is the small theorem that
licenses all later language about a decreasing spectrum.

{{< panel "info" >}}
**Multiplicity is not deduplication.** If one eigenvalue has algebraic
multiplicity three, the ordered vector contains the same real value at three
indices. The later counting measure therefore receives three Dirac
contributions at the same point. Sorting changes order, not multiplicity.
{{< /panel >}}

At \(n=0\), `Fin 0` has no elements. The function still exists, and every
universal statement about its coordinates is vacuous. No dummy eigenvalue is
invented.

## The first two spectral power sums

The next two declarations connect RMT-10A back to the observable layer. They
are deterministic identities for one Hermitian matrix, not expectations under
a random law.

### The trace is the first power sum

`trace_eq_sum_orderedHermitianEigenvalues` proves

\[
\operatorname{Tr}(H)=\sum_{i\in\operatorname{Fin}(n)}\lambda_i(H),
\]

with the left side in \(\mathbb C\) and each real eigenvalue coerced to
\(\mathbb C\). The Lean statement is:

```lean
theorem trace_eq_sum_orderedHermitianEigenvalues {n : ℕ}
    (H : HermitianEuclidean n) :
    Matrix.trace (hermitianToMatrix H) =
      ∑ i, (orderedHermitianEigenvalues H i : ℂ)
```

The proof does not rely on a slogan about diagonalization. It walks through
the characteristic polynomial:

1. Hermiticity supplies `H.2.splits_charpoly`, so the trace equals the sum of
   characteristic-polynomial roots.
2. `H.2.roots_charpoly_eq_eigenvalues₀` identifies those roots with the
   sorted real eigenvalues after coercion to \(\mathbb C\).
3. `Equiv.sum_comp` transports the finite sum through the order-preserving
   cast from Mathlib's cardinality index to `Fin n`.

Because finite sums over `Fin 0` are empty and the trace of the empty matrix is
zero, the same theorem includes dimension zero.

### The trace of the square is the second power sum

`trace_sq_eq_sum_sq_orderedHermitianEigenvalues` proves

\[
\operatorname{Tr}(H^2)=
\sum_{i\in\operatorname{Fin}(n)}\lambda_i(H)^2.
\]

This proof uses the spectral theorem more visibly. Let \(U\) be Mathlib's
unitary eigenvector matrix and let \(D\) be the diagonal matrix containing the
arbitrarily reindexed `H.2.eigenvalues`. The spectral theorem gives

\[
H=UDU^*.
\]

The proof expands the square, cancels \(U^*U=I\), and cycles factors under the
trace until only \(D^2\) remains:

\[
\operatorname{Tr}\!\left((UDU^*)^2\right)
=\operatorname{Tr}(D^2)
=\sum_i\lambda_i^2.
\]

Lean's proof then performs two separate finite reindexings. The first moves
from Mathlib's arbitrary `eigenvalues` index back to `eigenvalues₀`. The second
moves from the native `eigenvalues₀` cardinality index to the project's
order-preserving `Fin n` index. The square sum is permutation invariant, so
the first reindexing is legitimate even though it does not preserve order.
The final public statement nevertheless uses the ordered vector.

This is a useful proof-engineering lesson: order matters to the interface, but
a symmetric finite sum may pass through a temporary arbitrary enumeration.

### Matrix moments are not random moments yet

The two identities can be read as first and second moments of a finite
counting measure, which the module proves shortly. They are not the RMT-09
expectation statements. RMT-09 integrated trace powers over `GUE.matrixLaw n`.
RMT-10A currently integrates powers over the spectral measure of one fixed
matrix. An outer integral over a random matrix law would require the
matrix-to-spectral-measure map to be measurable.

## Unitary congruence preserves the ordered vector

For a unitary matrix \(U\), intrinsic Hermitian congruence sends

\[
H\longmapsto UHU^*.
\]

The theorem
`orderedHermitianEigenvalues_hermitianCongruence` proves equality of the
entire functions `Fin n → ℝ`, not merely equality of their sums:

```lean
theorem orderedHermitianEigenvalues_hermitianCongruence {n : ℕ}
    (U : Matrix.unitaryGroup (Fin n) ℂ)
    (H : HermitianEuclidean n) :
    orderedHermitianEigenvalues (hermitianCongruence U H) =
      orderedHermitianEigenvalues H
```

The proof architecture is characteristic-polynomial invariance followed by
sorting:

1. `Matrix.charpoly_mul_comm` cycles a factor in the characteristic
   polynomial of \(UHU^*\).
2. Unitarity supplies \(U^*U=I\), reducing the polynomial to the
   characteristic polynomial of \(H\).
3. `sort_roots_charpoly_eq_eigenvalues₀` describes each sorted eigenvalue
   vector as the decreasing sort of the real parts of the polynomial roots.
4. Equal characteristic polynomials therefore give equal `List.ofFn` lists.
5. `List.ofFn_inj` converts that list equality back to equality of functions,
   after which the same index cast gives the public vector equality.

This result is deterministic spectral invariance. It should not be confused
with RMT-08's law-level unitary invariance of GUE. Every individual Hermitian
matrix and its unitary conjugate have the same spectrum. A random matrix law is
unitarily invariant only when the distribution of the whole matrix is also
unchanged.

## From repeated eigenvalues to a counting measure

The definition `spectralCountingMeasure` places one Dirac mass at each index:

\[
\Xi_H=\sum_{i\in\operatorname{Fin}(n)}\delta_{\lambda_i(H)}.
\]

Its Lean spelling is:

```lean
noncomputable def spectralCountingMeasure {n : ℕ}
    (H : HermitianEuclidean n) : Measure ℝ :=
  ∑ i, Measure.dirac (orderedHermitianEigenvalues H i)
```

Dirac measure turns one point into one unit of measure. A finite sum of Dirac
measures is therefore a natural counting measure for a finite multiset. The
official Mathlib documentation defines its general counting measure through a
sum of Dirac masses as well
([counting measure](#ref-mathlib-count), [Dirac measure](#ref-mathlib-dirac)).
RMT-10A uses an explicit finite sum because the eigenvalue locations, rather
than the index set itself, carry the mass.

If \(\lambda\) occurs at \(r\) different indices, then a measurable set
containing \(\lambda\) receives \(r\) contributions. Algebraic multiplicity is
therefore retained without separately storing a multiplicity function.

### Five immediate theorems

`spectralCountingMeasure_hermitianCongruence` is a simplification theorem. It
rewrites each eigenvalue through
`orderedHermitianEigenvalues_hermitianCongruence`, so the finite sum of Dirac
measures is unchanged.

`spectralCountingMeasure_zero` proves that an intrinsic zero-dimensional
Hermitian matrix has the zero counting measure. The proof is literally
`Fintype.sum_empty`: there are no indices and therefore no Dirac masses.

`spectralCountingMeasure_univ` evaluates the measure on the whole real line:

\[
\Xi_H(\mathbb R)=n.
\]

The equality lives in extended nonnegative reals, with the natural number
coerced into the measure's value type. Every Dirac measure assigns mass one to
the whole space, and the finite sum has one term per index.

The final two declarations in this group turn the earlier power-sum identities
into integral identities:

\[
\int_{\mathbb R}x\,d\Xi_H(x)=\operatorname{Tr}(H),
\qquad
\int_{\mathbb R}x^2\,d\Xi_H(x)=\operatorname{Tr}(H^2).
\]

Because the public trace codomain is complex, Lean integrates the functions
`fun x : ℝ => (x : ℂ)` and `fun x : ℝ => (x : ℂ) ^ 2`. The theorems are named
`integral_complex_ofReal_spectralCountingMeasure` and
`integral_sq_complex_ofReal_spectralCountingMeasure`.

Both proofs use `integral_finsetSum_measure` to exchange an integral against a
finite sum of measures with a finite sum of integrals. Every Dirac integral is
integrable, and `integral_dirac` evaluates it at its support point. The result
then closes with the corresponding trace identity. No limiting theorem and no
matrix probability law appears.

## Normalizing the cloud

Random-matrix theory often replaces the mass-\(n\) counting measure by a
mass-one empirical spectral measure. For positive dimension, the familiar
formula is

\[
L_H=\frac1n\sum_{i\in\operatorname{Fin}(n)}\delta_{\lambda_i(H)}.
\]

The definition `empiricalSpectralMeasure` implements the same idea in the
scalar system used by Mathlib measures:

```lean
noncomputable def empiricalSpectralMeasure {n : ℕ}
    (H : HermitianEuclidean n) : Measure ℝ :=
  (n : ℝ≥0∞)⁻¹ • spectralCountingMeasure H
```

The scalar belongs to `ℝ≥0∞`, Mathlib's extended nonnegative reals, because
that is the scalar action on positive measures. The inverse is attached to the
dimension and not hidden in notation. The definition is total for every
natural \(n\), but the theorem interface distinguishes zero from positive
dimension.

`empiricalSpectralMeasure_hermitianCongruence` follows immediately from the
counting-measure invariance. Scaling the same measure by the same scalar gives
the same empirical measure.

### Why dimension zero cannot be a probability measure

At \(n=0\), the spectrum has no points. Its counting measure is zero, and the
module chooses the empirical measure to be zero as well. The theorem
`empiricalSpectralMeasure_zero` states this explicitly.

There is a subtle type-level detail worth seeing. In extended nonnegative
reals, the inverse of zero is the top element. The definition therefore does
not simplify by pretending that an ordinary real reciprocal exists. Instead,
`spectralCountingMeasure_zero` first reduces the measure to zero, and
`smul_zero` proves that any scalar multiple of the zero measure is zero. The
mathematical policy is clear: an empty spectrum has zero mass, not an invented
unit mass at a placeholder location.

That choice forces two probability interfaces.

1. `empiricalSpectralMeasure_isZeroOrProbability` states, in every dimension,
   that the empirical measure is either zero or a probability measure. Its
   proof observes that the scaling factor is the inverse of the counting
   measure's total mass and invokes Mathlib's normalized-measure instance.
2. `empiricalSpectralMeasure_succ_isProbability` specializes to dimension
   `n + 1`, where the total mass is positive and finite. It proves directly
   that inverse dimension multiplied by dimension is one.

The all-dimension theorem is not a weaker proof accidentally left in place.
It records the real boundary. There is no probability measure on the real line
with total mass zero.

### Bundle probability only where it is true

Mathlib's `ProbabilityMeasure ℝ` is a bundled measure together with a proof of
total mass one. The definition
`empiricalSpectralProbability` accepts a matrix of dimension `n + 1` and
packages `empiricalSpectralMeasure H` with
`empiricalSpectralMeasure_succ_isProbability n H`:

```lean
noncomputable def empiricalSpectralProbability (n : ℕ)
    (H : HermitianEuclidean (n + 1)) : ProbabilityMeasure ℝ
```

The successor index is not cosmetic. It makes an invalid zero-dimensional
probability object unrepresentable at this API boundary. The official Mathlib
documentation describes `ProbabilityMeasure` as the type of probability
measures and equips it with the topology of weak convergence
([Mathlib probability measures](#ref-mathlib-probability-measure)). RMT-10A
uses only its bundled mass-one structure and measurable subtype here. It does
not prove convergence of any sequence of these measures.

### A finite worked example

Suppose a three-dimensional Hermitian matrix has ordered eigenvalues

\[
\lambda_0=4,
\qquad
\lambda_1=1,
\qquad
\lambda_2=1.
\]

The repeated value is kept twice. The counting and empirical measures are

\[
\Xi_H=\delta_4+2\delta_1,
\qquad
L_H=\frac13\delta_4+\frac23\delta_1.
\]

Their total masses are three and one. Their first moments are

\[
\int x\,d\Xi_H(x)=6=\operatorname{Tr}(H),
\qquad
\int x\,dL_H(x)=2=\frac1{3}\operatorname{Tr}(H).
\]

The module checks the counting-measure identity directly. The normalized
first-moment identity displayed in the example is an immediate paper
calculation from scalar multiplication, but it is not exported as a named
RMT-10A theorem. This distinction keeps the chapter aligned with the actual
public API.

## Measures as measurable outputs

Defining \(H\mapsto L_H\) pointwise does not yet make it a random variable.
The codomain is itself `Measure ℝ`, and Mathlib equips that type with the Giry
measurable structure. A map into measures is measurable when evaluation on
every measurable set varies measurably. The official documentation states
this through `Measure.measurable_coe` and
`Measure.measurable_of_measurable_coe`, and proves that the Dirac map itself is
measurable ([Mathlib Giry monad](#ref-mathlib-giry)).

The central unresolved input is:

```lean
h : ∀ i, Measurable (fun H : HermitianEuclidean n =>
  orderedHermitianEigenvalues H i)
```

This hypothesis says that every fixed ordered eigenvalue coordinate is a
measurable real-valued function of the intrinsic Hermitian matrix. It is
exactly the theorem one expects to obtain from a continuity or perturbation
bound. RMT-10A does not prove it.

### Counting measures are measurable if the coordinates are

`measurable_spectralCountingMeasure_of_measurable_eigenvalues` consumes the
coordinatewise hypothesis and proves:

```lean
Measurable (@spectralCountingMeasure n)
```

For each index, measurability of the eigenvalue coordinate composes with
`Measure.measurable_dirac`. `Finset.measurable_fun_sum` then closes the finite
sum. This proof exposes the exact analytic dependency: finite summation and
Dirac packaging add no new obstacle once each coordinate is measurable.

### Constant scaling in the Giry space

The private helper `measurable_const_smul_measure` proves that, for a fixed
extended nonnegative scalar \(c\), the map

\[
\mu\longmapsto c\mu
\]

from `Measure ℝ` to `Measure ℝ` is measurable. It applies
`Measure.measurable_of_measurable_coe`, fixes an arbitrary measurable set
\(s\), rewrites evaluation as \(c\mu(s)\), and multiplies a measurable
constant by the measurable evaluation function `Measure.measurable_coe hs`.

This helper is private because the public scientific interface needs only the
specific inverse-dimension scaling. Its proof is still important: it shows
that normalization happens inside the Giry measurable space rather than by an
unjustified coercion.

`measurable_empiricalSpectralMeasure_of_measurable_eigenvalues` composes this
constant-scaling map with the measurable counting-measure map. It proves
measurability of the intrinsic empirical spectral measure under the same
coordinatewise hypothesis.

`measurable_empiricalSpectralProbability_of_measurable_eigenvalues` handles
positive dimension. Since `empiricalSpectralProbability n H` is a subtype
whose underlying measure is the empirical measure, `.subtype_mk` lifts the
measurability theorem into `ProbabilityMeasure ℝ`.

{{< panel "warning" >}}
**Conditional means conditional.** A theorem named
`measurable_empiricalSpectralMeasure_of_measurable_eigenvalues` is not a proof
that the empirical spectral measure is measurable without assumptions. Its
argument `h` is the missing eigenvalue theorem. Every later use must either
carry `h` or first discharge it.
{{< /panel >}}

### Why the missing theorem belongs to perturbation theory

The intended next theorem is continuity of each ordered eigenvalue coordinate.
One route is a Weyl-type bound controlling each coordinate by an operator-norm
perturbation; once such continuity is checked, measurability follows. None of
that mathematics is encoded in this module. Merely knowing that the
characteristic polynomial depends continuously on entries is not enough to
claim that a chosen sorted root coordinate is measurable without a root or
eigenvalue continuity theorem.

The explicit hypothesis is therefore a useful dependency seam. RMT-10A can
finish the algebra, normalization, and pushforward architecture now. A later
perturbation slice can discharge the one named assumption everywhere without
redesigning the measure interfaces.

## Totalizing an intrinsic observable

`GUE.matrixLaw n` lives on the full ambient matrix type, while
`empiricalSpectralMeasure` accepts the intrinsic Hermitian subtype. Even though
the GUE law gives the Hermitian locus mass one, a function used by
`Measure.map` must still be defined on every ambient matrix.

The module solves this with an explicit total extension.

### Hermitian matrices pass through; everything else becomes zero

`matrixToHermitianOrZero` checks whether an ambient matrix \(A\) is Hermitian.
If it is, the function packages the same entries as an element of
`HermitianEuclidean n`. If it is not, the function returns the zero intrinsic
matrix.

```lean
noncomputable def matrixToHermitianOrZero (n : ℕ)
    (A : Matrix (Fin n) (Fin n) ℂ) : HermitianEuclidean n
```

This policy is total and deterministic. It does not assert that a
non-Hermitian matrix has a Hermitian spectrum. It merely supplies a fallback
value outside the intended locus so a measurable function can exist on the
ambient carrier.

The private helper `measurable_matrixToFrobenius` proves that the ambient
matrix-to-Frobenius conversion is measurable. It unfolds the finite
`EuclideanSpace` representation, uses `WithLp.measurable_toLp`, reduces
function-space measurability with `measurable_pi_iff`, and closes each
coordinate with the project's measurable matrix-entry theorem.

`measurable_matrixToHermitianOrZero` then rewrites the underlying Frobenius
value as a piecewise function on `RandomMatrix.hermitianSet n`. The set is
measurable by RMT-07, the true branch is
`measurable_matrixToFrobenius n`, and the false branch is constant zero.
`Measurable.piecewise` and `Measurable.subtype_mk` produce the final intrinsic
map.

Finally,
`matrixToHermitianOrZero_hermitianToMatrix` proves the exact left-inverse
identity

\[
\operatorname{matrixToHermitianOrZero}
  (\operatorname{hermitianToMatrix}(H))=H.
\]

The Hermitian proof stored in \(H\) selects the true branch, and subtype
extensionality reduces equality to the unchanged entries. This theorem is the
key simplification in the final pushforward bridge.

### The ambient spectral observable

`ambientEmpiricalSpectralMeasure` is the composition

\[
A\longmapsto
\operatorname{empiricalSpectralMeasure}
  (\operatorname{matrixToHermitianOrZero}(A)).
\]

It is a total function from ambient complex matrices to measures on
\(\mathbb R\). On the Hermitian locus it agrees exactly with the intrinsic
observable. Off that locus it applies the intrinsic empirical-measure
definition to the zero Hermitian matrix. The module needs no further formula
for that fallback value.

`measurable_ambientEmpiricalSpectralMeasure_of_measurable_eigenvalues`
composes `measurable_matrixToHermitianOrZero` with the conditional intrinsic
measurability theorem. It carries precisely the same coordinatewise
eigenvalue-measurability hypothesis.

## The conditional ambient/intrinsic GUE bridge

The module culminates in the long but descriptive theorem
`map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw_of_measurable_eigenvalues`:

```lean
theorem map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw_of_measurable_eigenvalues
    {n : ℕ}
    (h : ∀ i, Measurable (fun H : HermitianEuclidean n =>
      orderedHermitianEigenvalues H i)) :
    (GUE.matrixLaw n).map (ambientEmpiricalSpectralMeasure n) =
      (GUE.intrinsicLaw n).map empiricalSpectralMeasure
```

Both sides are measures on `Measure ℝ`. The left side samples an ambient GUE
matrix and applies the totalized spectral observable. The right side samples
an intrinsic Hermitian GUE matrix and applies the intrinsic observable. The
theorem says these two laws of measure-valued outputs agree, provided the
eigenvalue coordinates are measurable.

The proof uses the exact RMT-08 identity
`GUE.matrixLaw_eq_map_hermitianToMatrix_intrinsicLaw`, not merely the statement
that the Hermitian locus has mass one. It then applies `Measure.map_map` with
both measurability proofs and uses function extensionality. At each intrinsic
matrix, `matrixToHermitianOrZero_hermitianToMatrix` collapses the composition
back to `empiricalSpectralMeasure`.

{{< mermaid >}}
flowchart LR
  I["intrinsic GUE law"] --> H["intrinsic Hermitian matrix"]
  I -->|"map inclusion"| A["ambient GUE law"]
  H --> E["intrinsic empirical measure"]
  A --> T["Hermitian-or-zero totalization"]
  T --> E
  E --> L["law on the space of real-line measures"]
{{< /mermaid >}}

<p class="figure-note"><strong>Figure.</strong> RMT-08 identifies the ambient
GUE law as the pushforward of the intrinsic law. The totalization is a left
inverse on every included Hermitian matrix, so the two routes to a law on
measure-valued outputs agree. The diagram presupposes the coordinatewise
eigenvalue-measurability hypothesis required by both `Measure.map`
calculations.</p>

This theorem is an architectural bridge, not the final random spectral law.
Until the hypothesis `h` is discharged by a checked continuity or
measurability theorem, downstream code cannot invoke it without carrying the
assumption.

## The complete declaration map

The frozen module exports six definitions and twenty theorems. Two additional
private theorems are proof engines. The table follows source order.

| Declaration | Kind | Exact role |
|---|---|---|
| `orderedHermitianEigenvalues` | public definition | Reindexes Mathlib's decreasing `eigenvalues₀` vector to `Fin n` with the finite cardinal cast |
| `orderedHermitianEigenvalues_antitone` | public theorem | Proves the project vector is decreasing |
| `trace_eq_sum_orderedHermitianEigenvalues` | public theorem | Identifies the complex trace with the first ordered eigenvalue power sum |
| `trace_sq_eq_sum_sq_orderedHermitianEigenvalues` | public theorem | Identifies the trace of the matrix square with the second ordered eigenvalue power sum |
| `orderedHermitianEigenvalues_hermitianCongruence` | public theorem | Proves equality of the whole ordered vector under intrinsic unitary congruence |
| `spectralCountingMeasure` | public definition | Sums one Dirac measure per eigenvalue index, retaining multiplicity |
| `spectralCountingMeasure_hermitianCongruence` | public theorem | Preserves the counting measure under unitary congruence |
| `spectralCountingMeasure_zero` | public theorem | Reduces the empty spectral sum to the zero measure at dimension zero |
| `spectralCountingMeasure_univ` | public theorem | Computes total counting mass as `n` |
| `integral_complex_ofReal_spectralCountingMeasure` | public theorem | Computes the first complex counting-measure moment as the matrix trace |
| `integral_sq_complex_ofReal_spectralCountingMeasure` | public theorem | Computes the second complex counting-measure moment as the trace of the matrix square |
| `measurable_spectralCountingMeasure_of_measurable_eigenvalues` | public theorem | Lifts coordinatewise eigenvalue measurability through Dirac maps and a finite sum |
| `empiricalSpectralMeasure` | public definition | Scales the counting measure by inverse dimension, with a total zero-aware definition |
| `empiricalSpectralMeasure_hermitianCongruence` | public theorem | Preserves the normalized measure under unitary congruence |
| `empiricalSpectralMeasure_zero` | public theorem | Proves the explicit zero-measure policy at dimension zero |
| `empiricalSpectralMeasure_isZeroOrProbability` | public theorem | Gives the correct zero-or-probability statement uniformly in dimension |
| `empiricalSpectralMeasure_succ_isProbability` | public theorem | Proves total mass one for successor dimensions |
| `empiricalSpectralProbability` | public definition | Bundles the positive-dimensional empirical measure as `ProbabilityMeasure ℝ` |
| `measurable_const_smul_measure` | private theorem | Proves fixed scalar multiplication is measurable in the Giry measurable space |
| `measurable_empiricalSpectralMeasure_of_measurable_eigenvalues` | public theorem | Composes counting-measure measurability with inverse-dimension scaling |
| `measurable_empiricalSpectralProbability_of_measurable_eigenvalues` | public theorem | Lifts conditional measurability into the bundled probability-measure subtype |
| `matrixToHermitianOrZero` | public definition | Totalizes the intrinsic carrier on ambient matrices with a zero fallback |
| `measurable_matrixToFrobenius` | private theorem | Proves the ambient-to-Frobenius coordinate conversion measurable |
| `measurable_matrixToHermitianOrZero` | public theorem | Proves the totalization measurable as a piecewise map on the Hermitian set |
| `matrixToHermitianOrZero_hermitianToMatrix` | public theorem | Proves totalization is a left inverse to intrinsic inclusion |
| `ambientEmpiricalSpectralMeasure` | public definition | Composes totalization with the intrinsic empirical measure |
| `measurable_ambientEmpiricalSpectralMeasure_of_measurable_eigenvalues` | public theorem | Makes the ambient measure-valued observable measurable under the same hypothesis |
| `map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw_of_measurable_eigenvalues` | public theorem | Equates ambient and intrinsic GUE pushforward laws under coordinatewise measurability |

### The dependency shape

The declaration graph has four layers:

1. **Ordered algebra:** sorted eigenvalues, order, power sums, and congruence.
2. **Finite measures:** counting measure, total mass, and pointwise moments.
3. **Normalization:** zero-aware empirical measure and positive-dimensional
   probability bundling.
4. **Measurable transport:** conditional Giry maps, ambient totalization, and
   the GUE pushforward equality.

Only the fourth layer depends on the missing coordinatewise measurability
hypothesis. That separation is the main design achievement of the module.

## Lean proof anatomy and engineering choices

### Why there are two eigenvalue enumerations in one proof

`trace_sq_eq_sum_sq_orderedHermitianEigenvalues` temporarily uses
`H.2.eigenvalues` because Mathlib's `spectral_theorem` is stated with that
enumeration. It later reindexes to `eigenvalues₀`, and then through the ordered
cast to the project vector. This is not an inconsistency. The diagonalization
needs a complete enumeration; the public interface needs a sorted one; the
square sum is invariant under the intermediate permutation.

### Why characteristic polynomials prove congruence invariance

One might try to transport each eigenvector through \(U\). That creates
bookkeeping around repeated eigenspaces and the chosen basis. Characteristic
polynomials avoid the choice. Unitary congruence is a similarity because
\(U^{-1}=U^*\), so the characteristic polynomial is unchanged. Sorting the
same multiset of real roots then produces the same ordered vector, including
ties.

### Why measures use `ℝ≥0∞`

A positive measure evaluates sets in extended nonnegative reals, and scalar
multiplication by `ℝ≥0∞` remains within that structure. It naturally handles
infinite mass in general measure theory. The spectral counting measure is
finite, but using the ambient measure API avoids building a separate custom
finite-measure calculus.

### Why the ambient fallback is zero

Any fixed intrinsic Hermitian matrix could serve as the off-locus fallback.
Zero is canonical, dimension-uniform, and measurable as a constant. More
importantly, the final bridge starts from the exact intrinsic pushforward
representation of `GUE.matrixLaw`, so only the value on included Hermitian
matrices is used in the composition proof. The left-inverse theorem makes that
fact syntactic.

### Why there is no global measurability instance

Installing an instance without a proof would hide a mathematical assumption
inside typeclass search. The module instead uses named theorems with an
explicit argument `h`. Downstream declarations must reveal whether they have
actually discharged the perturbation-theory dependency.

## How to run the checked source

Load elan and compile this module with warnings promoted to errors:

```sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomMatrices/HermitianSpectrum.lean
```

Build the entire Lean library:

```sh
source "$HOME/.elan/env"
cd formalization
lake build
```

From the repository root, run the integrated proof-to-prose and Hugo gates:

```sh
make check
```

Useful source reconnaissance commands are:

```sh
rg -n "eigenvalues₀|eigenvalues₀_antitone|spectral_theorem" \
  formalization/.lake/packages/mathlib/Mathlib/Analysis/Matrix/Spectrum.lean

rg -n "measurable_dirac|measurable_of_measurable_coe|measurable_coe" \
  formalization/.lake/packages/mathlib/Mathlib/MeasureTheory/Measure/GiryMonad.lean
```

The [pinned Mathlib 4.32.0 checkout](#ref-mathlib-release) is the API authority.
Web documentation is useful for orientation, but it may describe a newer
revision than the project's dependency.

## Common failure modes

### Treating an arbitrary enumeration as sorted

Mathlib's `eigenvalues` supplies values indexed by the matrix index type, but
its reindexing equivalence is not an order-preserving theorem. Use
`orderedHermitianEigenvalues` whenever coordinate order has meaning.

### Deduplicating repeated eigenvalues

An empirical spectral measure counts roots with algebraic multiplicity.
Replacing the indexed vector by the set of distinct real values changes the
measure, its total mass, and its moments.

### Calling the counting measure a probability measure

`spectralCountingMeasure H` has total mass `n`, not one. Only the normalized
measure in positive dimension is a probability measure.

### Hiding the zero-dimensional branch

The formula \(1/n\) is a positive-dimensional mnemonic. The checked definition
is total and theorems state that dimension zero gives the zero measure. Do not
package that result as a `ProbabilityMeasure`.

### Reading a conditional theorem as an unconditional result

Every declaration ending in `_of_measurable_eigenvalues` takes the missing
coordinatewise theorem as an argument. The final map equality does too.

### Confusing pointwise spectral invariance with law invariance

`orderedHermitianEigenvalues_hermitianCongruence` concerns one matrix and one
unitary. RMT-08's GUE theorem concerns equality of matrix probability laws.
The final RMT-10A bridge combines law transport with a pointwise left inverse,
but only after measurability is supplied.

### Calling `matrixToHermitianOrZero` a spectral theorem for general matrices

The function discards non-Hermitian inputs by returning zero. It does not
compute the possibly complex spectrum of a non-Hermitian matrix.

### Equating a random measure with its expectation

`ambientEmpiricalSpectralMeasure n A` is a measure-valued observable. Mapping a
matrix law through it gives a distribution over measures. Averaging those
measures, or integrating a test function against that average, is an
additional construction not exported here.

## Strict nonclaims

RMT-10A does **not** prove any of the following:

- continuity, Lipschitz continuity, or measurability of the ordered eigenvalue
  coordinates;
- a Weyl perturbation inequality, min-max theorem, or Courant-Fischer
  characterization;
- an unconditional measurable empirical spectral observable;
- an unconditional finite-GUE empirical spectral law;
- a joint eigenvalue density, Vandermonde factor, or matrix-to-eigenvalue
  Jacobian;
- a formula for the expected empirical spectral measure;
- a connection between the RMT-09 GUE expectations and expectations of
  empirical spectral moments;
- eigenvalue rigidity, spacing, unfolding, edge statistics, or spectral form
  factors;
- convergence to the semicircle law or any other large-dimension limit;
- universality, concentration, or a rate of convergence;
- an executable numerical eigenvalue algorithm; or
- spectral results for arbitrary non-Hermitian matrices.

The finite empirical spectral distribution is standard random-matrix
language. For example, Tao, Vu, and Krishnapur define the empirical spectral
distribution of a finite complex matrix by assigning equal mass to its
eigenvalues before studying a limiting circular law
([Tao, Vu, and Krishnapur, 2010](#ref-tao-vu-krishnapur-2010)). That source
illustrates the broader role of empirical spectral distributions. It does not
warrant importing its non-Hermitian universality or asymptotic conclusions
into this Hermitian finite Lean module.

## Exercises with solutions

### Exercise 1: read antitonicity

Suppose \(i\le j\). What does
`orderedHermitianEigenvalues_antitone H` say?

**Solution.** It says

\[
\operatorname{orderedHermitianEigenvalues}(H)(j)\le
\operatorname{orderedHermitianEigenvalues}(H)(i).
\]

Equivalently, earlier indices hold eigenvalues at least as large as later
indices.

### Exercise 2: preserve multiplicity

A four-dimensional Hermitian matrix has eigenvalues \(3,3,0,-2\). Write its
counting measure and empirical measure.

**Solution.** The counting measure is
\(2\delta_3+\delta_0+\delta_{-2}\). The empirical measure is
\(\tfrac12\delta_3+\tfrac14\delta_0+\tfrac14\delta_{-2}\). Replacing the two
copies of three by one point would give the wrong mass.

### Exercise 3: separate order from symmetric sums

Why may the proof of the trace-of-square identity pass through Mathlib's arbitrarily reindexed
`eigenvalues`, while the public vector should still use `eigenvalues₀`?

**Solution.** A finite sum of squares is unchanged by a permutation, so the
intermediate enumeration does not affect the value. Coordinate claims such as
largest or second largest do depend on order, so the public interface must
retain the sorted enumeration.

### Exercise 4: check the first two moments

For ordered eigenvalues \(2,0,-1\), compute the mass, first counting-measure
moment, and second counting-measure moment.

**Solution.** The mass is three. The first moment is \(2+0-1=1\), which equals
the trace. The second is \(4+0+1=5\), which equals the trace of the square for
a Hermitian matrix with that spectrum.

### Exercise 5: explain unitary congruence

Why is \(H\mapsto UHU^*\) a similarity transformation when \(U\) is unitary?

**Solution.** Unitarity gives \(U^{-1}=U^*\). Therefore
\(UHU^*=UHU^{-1}\), so the characteristic polynomial and its roots are
unchanged. Sorting the same roots gives the same ordered vector.

### Exercise 6: audit dimension zero

What are `spectralCountingMeasure H` and `empiricalSpectralMeasure H` when
`H : HermitianEuclidean 0`?

**Solution.** Both are the zero measure. The counting sum has no terms, and
scalar multiplication of the zero measure remains zero.

### Exercise 7: choose the correct probability predicate

Why does the all-dimension theorem use `IsZeroOrProbabilityMeasure`?

**Solution.** At positive dimension the normalized measure has total mass one.
At dimension zero the explicit policy gives total mass zero. One predicate
must honestly cover both cases without pretending the zero measure is a
probability measure.

### Exercise 8: identify the missing analytic input

Which exact hypothesis is reused by all conditional measurability theorems?

**Solution.** For every `i : Fin n`, the map from an intrinsic Hermitian matrix
to `orderedHermitianEigenvalues H i` must be measurable. A future continuity
or perturbation theorem should discharge this coordinatewise statement.

### Exercise 9: understand Giry measurability

What does it mean, operationally, for
`fun H => spectralCountingMeasure H` to be measurable?

**Solution.** The codomain `Measure ℝ` has the Giry measurable structure. For
each measurable set \(s\subseteq\mathbb R\), evaluating the output measure on
\(s\) must give a measurable scalar function of \(H\). Mathlib packages this
criterion through its measure-evaluation API.

### Exercise 10: test the ambient fallback

Let \(A\) be non-Hermitian. Does `matrixToHermitianOrZero n A` expose the
spectrum of \(A\)?

**Solution.** No. It returns the zero intrinsic Hermitian matrix. The function
exists to totalize an intrinsic observable on the ambient carrier, not to
extend Hermitian spectral theory to general matrices.

### Exercise 11: follow the commuting square

Why is `matrixToHermitianOrZero_hermitianToMatrix` sufficient to identify the
two GUE pushforward routes after `Measure.map_map`?

**Solution.** RMT-08 already writes the ambient law as the map of the intrinsic
law through `hermitianToMatrix`. Composing that inclusion with the ambient
observable first applies `matrixToHermitianOrZero`; the left-inverse theorem
reduces the composition pointwise to the intrinsic empirical measure.

### Exercise 12: classify the final theorem

Does
`map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw_of_measurable_eigenvalues` construct
an unconditional GUE empirical spectral law?

**Solution.** No. It takes coordinatewise eigenvalue measurability as an
explicit argument. It proves an exact equality of two pushforward measures
under that assumption.

## The next ridge

RMT-10A has built the algebraic summit and stopped at the first analytic cliff.
The next dependency is a reusable perturbation theorem for decreasingly
ordered Hermitian eigenvalues. A Weyl or Courant-Fischer layer should give a
coordinate bound strong enough to prove continuity, hence measurability, of
`orderedHermitianEigenvalues`.

Once that theorem exists, the conditional suffixes in this module can be
discharged without changing the spectral interfaces. A later vertical slice
may then define the finite-GUE empirical spectral law unconditionally, prove
its intrinsic and ambient constructions agree, audit its zero-dimensional
law, and connect its first two normalized moments to RMT-09. Joint densities,
higher moments, and asymptotic semicircle behavior remain later ridges.

## References

The external links below were opened and checked on 2026-07-21. The pinned
local Mathlib 4.32.0 source remains the API authority for the Lean proof.

<a id="ref-mathlib-release"></a>
**Mathlib contributors.**
[Mathlib 4.32.0 release](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
2026. This is the exact dependency release selected by
`formalization/lakefile.toml`.

<a id="ref-mathlib-spectrum"></a>
**Mathlib contributors.**
[Hermitian matrix spectra](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Spectrum.html),
Mathlib 4 documentation. This page documents `eigenvalues₀`, its antitone
ordering, unitary diagonalization, characteristic-polynomial roots, and trace
as an eigenvalue sum. RMT-10A reuses those algebraic results and adds the
project's concrete ordered index and spectral-measure layer.

<a id="ref-mathlib-giry"></a>
**Mathlib contributors.**
[The Giry monad](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/GiryMonad.html),
Mathlib 4 documentation. This page defines the measurable structure on
`Measure α` through measurable-set evaluations and documents measurable
Dirac, map, and measure-evaluation interfaces used in the conditional proofs.

<a id="ref-mathlib-dirac"></a>
**Mathlib contributors.**
[Dirac measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Dirac.html),
Mathlib 4 documentation. This page defines the point mass and its integration,
mapping, finiteness, and probability properties.

<a id="ref-mathlib-count"></a>
**Mathlib contributors.**
[Counting measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Count.html),
Mathlib 4 documentation. This page records the general construction of
counting measure as a sum of Dirac masses and its total-mass behavior on finite
sets.

<a id="ref-mathlib-probability-measure"></a>
**Mathlib contributors.**
[Probability measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/ProbabilityMeasure.html),
Mathlib 4 documentation. This page defines the bundled `ProbabilityMeasure`
type and its weak-convergence topology. RMT-10A uses the bundle only in
positive dimension and proves no convergence theorem.

<a id="ref-tao-vu-krishnapur-2010"></a>
**Terence Tao, Van Vu, with an appendix by Manjunath Krishnapur.**
["Random Matrices: Universality of ESDs and the Circular Law"](https://doi.org/10.1214/10-AOP534),
*The Annals of Probability* 38(5), 2023-2065, 2010.
[arXiv:0807.4898](https://arxiv.org/abs/0807.4898), first submitted 2008.
The paper gives a primary finite empirical-spectral-distribution definition
before studying a non-Hermitian large-dimension problem. It is cited here for
that standard measure viewpoint, not as support for any Hermitian continuity,
GUE density, or asymptotic theorem in this module.
