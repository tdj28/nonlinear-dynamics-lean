---
title: "Finite Hermitian Spectra and Empirical Measures"
slug: "finite-hermitian-spectra-and-empirical-measures"
date: 2026-07-21
summary: "Diagonalize one exact two-by-two Hermitian matrix, place half an atom at each ordered eigenvalue, then climb carefully from a sample spectrum to a random measure, its law, and its mean."
lead: "Start with the matrix [[2,1],[1,2]], certify eigenvalues three and one by hand, and keep those two atoms visible while Lean separates deterministic spectral algebra from measure-valued probability."
draft: false
pro_reviewed: false
level: "Exact size-two spectrum through finite measure-valued probability"
reading_time: "90 to 120 minutes"
prerequisites: "Two-by-two matrix multiplication and basic fractions; Hermitian matrices, Dirac measures, pushforwards, Giry measurability, and Lean syntax are introduced as they appear"
lean_module: "NonlinearDynamics.Random.RandomMatrices.HermitianSpectrum"
toc: true
og_image: "finite-hermitian-spectra-and-empirical-measures-card.png"
og_image_alt: "The Hermitian matrix with rows two one and one two has checked ordered eigenvalues three and one, giving counting masses one and one and empirical masses one half and one half."
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
prose, sources, exact example, Lean declaration map, worksheet, figures, and
accessibility have not yet received the required human and Pro reviews. The
page is publicly available as an open working note while those reviews remain
pending.
{{< /panel >}}

## Begin with one matrix you can finish by hand

Take the real symmetric, hence complex Hermitian, matrix

\[
H=
\begin{bmatrix}
2&1\\
1&2
\end{bmatrix}.
\]

Hermitian means \(H^*=H\), where \(^*\) is conjugate transpose. Here every
entry is real and the two off-diagonal entries agree, so that check is visible
without a theorem prover.

An **eigenpair** is a scalar \(\lambda\) and a nonzero vector \(v\) satisfying
\(Hv=\lambda v\). Two direct multiplications give

\[
H\begin{bmatrix}1\\1\end{bmatrix}
{} =
\begin{bmatrix}3\\3\end{bmatrix}
{} =
3\begin{bmatrix}1\\1\end{bmatrix},
\qquad
H\begin{bmatrix}1\\-1\end{bmatrix}
{} =
\begin{bmatrix}1\\-1\end{bmatrix}
{} =
1\begin{bmatrix}1\\-1\end{bmatrix}.
\]

The characteristic polynomial confirms that there are no other eigenvalue
slots:

\[
\det(tI-H)
{} =
(t-2)^2-1
{} =
(t-3)(t-1).
\]

The project's ordered convention is decreasing, so the exact ordered spectrum
is

\[
\Lambda(H)=(\lambda_0(H),\lambda_1(H))=(3,1).
\]

This vector keeps two **slots**, not merely a set of distinct values. If an
eigenvalue repeats, it repeats in the vector. That is how algebraic
multiplicity survives the next construction.

### Place one atom at each slot

The {{< refterm "measure" "Dirac measure" >}} \(\delta_x\) is the particular
measure that puts unit
mass at the single point \(x\). The **spectral counting measure** of our matrix
is therefore

\[
N_H=\delta_3+\delta_1.
\]

It has total mass two. Divide by the number of eigenvalue slots to obtain the
{{< refterm "empirical-spectral-measure" "empirical spectral measure" >}}

\[
L_H=\frac12N_H
{} =
\frac12\delta_3+\frac12\delta_1.
\]

Here is the measure atom by atom. A singleton \(\{x\}\) asks how much mass is
located exactly at \(x\).

| Test set | \(N_H\) | \(L_H\) | Why |
|---|---:|---:|---|
| \(\{3\}\) | \(1\) | \(1/2\) | the first ordered slot equals three |
| \(\{1\}\) | \(1\) | \(1/2\) | the second ordered slot equals one |
| \(\{2\}\) | \(0\) | \(0\) | two is a matrix entry, not an eigenvalue |
| \(\mathbb R\) | \(2\) | \(1\) | both slots lie on the real line |

Two power-sum checks tie the atoms back to the entries:

\[
\operatorname{Tr}(H)=2+2=4=3+1,
\]

and, since

\[
H^2=
\begin{bmatrix}
5&4\\
4&5
\end{bmatrix},
\]

we have

\[
\operatorname{Tr}(H^2)=10=3^2+1^2.
\]

{{< reference-figure
  wide="true"
  src="hermitian-2x2-spectrum-ledger.svg"
  alt="The two-by-two Hermitian matrix with diagonal entries two and off-diagonal entries one has eigenvectors one one and one minus one with ordered eigenvalues three and one. Its counting measure has unit atoms at three and one, and its empirical measure has one-half atoms at those same points. Trace four and trace-square ten match the first two spectral power sums."
  caption="**The complete size-two ledger:** multiplying \(H\) by \((1,1)\) and \((1,-1)\) certifies the ordered eigenvalues \(3\) and \(1\). The counting masses are \(N_H(\{3\})=N_H(\{1\})=1\); division by two gives \(L_H(\{3\})=L_H(\{1\})=1/2\). The moment checks \(4=3+1\) and \(10=3^2+1^2\) agree exactly with the matrix traces."
>}}

## A near-miss in reconstruction: the spectrum forgets the basis

Now compare \(H\) with the diagonal matrix

\[
D=
\begin{bmatrix}
3&0\\
0&1
\end{bmatrix}.
\]

Both matrices are Hermitian. Both have the same decreasing ordered spectrum
\((3,1)\), hence the same counting measure and empirical measure:

\[
\Lambda(D)=\Lambda(H),
\qquad
N_D=N_H,
\qquad
L_D=L_H.
\]

Yet the matrices are not equal. For example, \(H_{01}=1\) while \(D_{01}=0\).
Their displayed eigenvectors are different too: the standard basis
diagonalizes \(D\), whereas the diagonal directions \((1,1)\) and \((1,-1)\)
diagonalize \(H\). In fact,

\[
H=UDU^*,
\qquad
U=\frac1{\sqrt2}
\begin{bmatrix}
1&1\\
1&-1
\end{bmatrix}.
\]

This is not a failure of spectral theory. The spectrum is deliberately
basis-independent. It records energy levels and multiplicities while
forgetting the coordinate basis and eigenvectors. Therefore no theorem should
try to reconstruct arbitrary matrix entries from \(L_H\) alone.

{{< reference-figure
  wide="true"
  src="isospectral-data-loss.svg"
  alt="The coupled Hermitian matrix two one; one two and the diagonal matrix three zero; zero one are different matrices but have the same ordered eigenvalues three and one and the same empirical measure with half mass at each eigenvalue. The first uses diagonal eigenvectors while the second uses the standard basis, demonstrating that spectral measures forget basis coordinates and eigenvectors."
  caption="**A controlled information-loss boundary:** \(H_{01}=1\) and \(D_{01}=0\), so \(H\ne D\). Nevertheless, the unitary basis change \(H=UDU^*\) gives both matrices ordered spectrum \((3,1)\) and empirical measure \((1/2)\delta_3+(1/2)\delta_1\). Equal spectral measures do not imply equal matrices or equal eigenvectors."
>}}

## Five objects that the phrase “spectral distribution” can hide

The running matrix has now produced a vector and a measure without any
probability experiment. Randomness adds more layers, each with a different
type.

| Object | Paper type | Lean type | What it describes |
|---|---|---|---|
| Ordered spectrum of one \(H\) | \(\Lambda(H)\in\mathbb R^n\) | <code>Fin n → ℝ</code> | decreasing eigenvalue slots with multiplicity |
| Empirical measure of one \(H\) | \(L_H\in\operatorname{Measure}(\mathbb R)\) | <code>Measure ℝ</code> | one equal-weight atom ledger |
| Random spectral measure | \(H\mapsto L_H\) | <code>HermitianEuclidean n → Measure ℝ</code> | a measure-valued observable before a source law is pushed through it |
| Law of that random measure | \(\mathcal Q_n=(L_{\bullet})_*\mu_n\) | <code>Measure (Measure ℝ)</code> | probability across whole sample measures |
| Mean empirical measure | \(\overline L_n=\int L\,\mathcal Q_n(\mathrm dL)\) | <code>Measure ℝ</code> | the Giry barycenter, which averages inner measures |

The second and fifth rows share the Lean type <code>Measure ℝ</code>, but
they are not the same construction. The second belongs to one realized
matrix. The fifth averages over an outer law and forgets sample-to-sample
variation. Likewise, the third row is a function; it is not itself the fourth
row's probability measure.

For finite Gaussian unitary ensemble (GUE) matrices, the repository now has
all five layers, but not in one source file:

- RMT-10A, <code>HermitianSpectrum.lean</code>, defines the first three objects
  and proves law transport only under an explicit coordinatewise
  eigenvalue-measurability hypothesis.
- RMT-10B, <code>HermitianSpectrumContinuity.lean</code>, proves the ordered
  coordinates are 1-Lipschitz, continuous, and measurable, then removes that
  hypothesis from the measure-valued interfaces.
- RMT-10C, <code>GaussianUnitaryEnsembleSpectrum.lean</code>, defines
  <code>GUE.empiricalSpectralLaw</code> and
  <code>GUE.meanEmpiricalSpectralMeasure</code> and proves their finite
  zero/positive-dimensional facts.

{{< reference-figure
  wide="true"
  src="sample-measure-law.svg"
  alt="A typed ladder begins with the fixed matrix H and its ordered vector three one, then its empirical measure with one-half atoms at three and one. A random matrix input makes the same construction a measure-valued function. After measurability, pushing a matrix law forward yields a measure on measures; joining that law yields one mean measure on the real line."
  caption="**Do not collapse the types:** \(\Lambda(H)\) is a vector, \(L_H\) is one measure, \(H\mapsto L_H\) is a measure-valued function, \(\mathcal Q_n\) is a measure on a space of measures, and \(\overline L_n\) is the joined mean measure. RMT-10A builds the deterministic objects and conditional map; RMT-10B proves the needed measurability; RMT-10C names the finite GUE law and mean."
>}}

### The empty-size boundary

At \(n=0\), there are no eigenvalue slots. RMT-10A defines both the counting
measure and empirical measure to be zero:

\[
N_H=0,
\qquad
L_H=0.
\]

The inner zero measure is not a probability measure because its total mass is
zero. Nevertheless, RMT-10C's **outer** law at size zero is the probability
measure \(\delta_0\) on the space <code>Measure ℝ</code>: it puts all outer
mass on the single sample measure \(0\). Its mean measure is again zero. This
is a useful type test: a probability law may be concentrated on an object
that is not itself a probability measure.

{{< panel "info" >}}
**Current theorem boundary.** RMT-10A's declarations ending in
<code>of_measurable_eigenvalues</code> are genuinely conditional. RMT-10B later
proves their hypotheses and exports unconditional versions. RMT-10C then
defines the finite GUE spectral law and mean. This chapter attributes each
claim to its actual module; it does not present a once-open RMT-10A premise as
an open project problem today.
{{< /panel >}}

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [Begin with one matrix](#begin-with-one-matrix-you-can-finish-by-hand) | Compute every eigenvalue slot and atom |
| Information route | [The spectrum forgets the basis](#a-near-miss-in-reconstruction-the-spectrum-forgets-the-basis) | See why equal spectra do not reconstruct entries |
| Type route | [Five spectral objects](#five-objects-that-the-phrase-spectral-distribution-can-hide) | Separate a sample measure, random measure, law, and mean |
| Linear algebra route | [The finite Hermitian spectral theorem](#base-camp-one-the-finite-hermitian-spectral-theorem) | Generalize the size-two computation |
| Lean route | [Seven exact bridges](#in-lean-seven-bridges-from-one-spectrum-to-a-law) | Translate paper objects into checked interfaces |
| Hands-on route | [Run the worksheet](#type-the-size-two-ledger-yourself-with-lean-and-std) | Recheck the integer arithmetic locally |
| API route | [The complete public API](#the-complete-public-api) | Audit the exact RMT-10A declaration boundary |

### Learning objectives

By the summit, you should be able to compute the running example without a
black box, explain multiplicity and unitary invariance, distinguish all five
typed objects above, defend the \(n=0\) policy, read seven Lean interfaces token
by token, and state exactly which claims belong to RMT-10A, RMT-10B, and
RMT-10C. You should also be able to name what is absent: no joint eigenvalue
density, semicircle law, large-dimension convergence, rigidity, local spacing
limit, spectral form factor, or out-of-time-order correlator is proved here.

## In Lean: seven bridges from one spectrum to a law

The numeric worksheet later in the chapter checks the size-two arithmetic
using only <code>Std</code>. The interfaces in this section are different: they
are the exact Mathlib-backed project declarations, so their literal repository
checks belong on an approved Linux builder.

### Bridge one: the ordered spectrum is a function on finite slots

{{< lean-bridge
  human="For one intrinsic size-n Hermitian matrix H, ask for the real eigenvalue in each decreasingly ordered slot."
  math="\(\Lambda(H):\operatorname{Fin}(n)\to\mathbb R,\quad i\mapsto\lambda_i(H),\quad i\le j\Rightarrow\lambda_i(H)\ge\lambda_j(H).\)"
  lean="RandomMatrix.orderedHermitianEigenvalues H : Fin n → ℝ"
>}}

- <code>H</code> has type <code>HermitianEuclidean n</code>, the intrinsic
  Hermitian carrier.
- <code>Fin n</code> contains exactly the index slots zero through
  \(n-1\).
- <code>→ ℝ</code> means that each slot returns one real number.
- <code>orderedHermitianEigenvalues_antitone H</code> is the separate theorem
  that records decreasing order; the type alone does not encode it.
- The definition is <code>noncomputable</code>. It is a mathematical interface,
  not a floating-point eigenvalue routine.
{{< /lean-bridge >}}

For the running matrix, a human writes \(\Lambda(H)=(3,1)\). The project
definition generalizes the slot structure, while our direct eigenvector
certificates establish the two concrete values.

### Bridge two: trace is the first ordered power sum

{{< lean-bridge
  human="Adding every ordered eigenvalue of a Hermitian matrix gives its ordinary complex trace."
  math="\(\operatorname{Tr}(H)=\sum_{i=0}^{n-1}\lambda_i(H).\)"
  lean="RandomMatrix.trace_eq_sum_orderedHermitianEigenvalues H"
>}}

- <code>Matrix.trace</code> adds the diagonal entries of the ambient matrix.
- <code>hermitianToMatrix H</code> forgets the intrinsic proof wrapper and
  exposes that ambient matrix.
- <code>∑ i</code> is a finite sum over every value of <code>Fin n</code>.
- <code>(... : ℂ)</code> coerces each real eigenvalue into the trace's complex
  codomain.
- The sibling theorem
  <code>trace_sq_eq_sum_sq_orderedHermitianEigenvalues</code> replaces each
  summand by its square and the left side by <code>trace (H ^ 2)</code>.
{{< /lean-bridge >}}

At size two these statements read \(4=3+1\) and
\(10=3^2+1^2\). They are pointwise algebraic identities, not expectations.

### Bridge three: counting measure means one Dirac mass per slot

{{< lean-bridge
  human="Place one unit point mass at each ordered eigenvalue slot, including repeated slots."
  math="\(N_H=\sum_{i=0}^{n-1}\delta_{\lambda_i(H)}.\)"
  lean="RandomMatrix.spectralCountingMeasure H : Measure ℝ"
>}}

- <code>Measure ℝ</code> is the type of measures on the real line.
- <code>Measure.dirac x</code> is the unit point mass \(\delta_x\).
- The source definition uses <code>∑ i</code>, so multiplicity is represented
  by repeated index contributions rather than by a set of distinct values.
- <code>spectralCountingMeasure_univ H</code> proves that the total mass is
  exactly <code>n</code>.
- No probability law on matrices occurs in this definition.
{{< /lean-bridge >}}

For the running spectrum, the definition unfolds to
\(\delta_3+\delta_1\). If the spectrum were \((3,3)\), the result would be
\(2\delta_3\), not \(\delta_3\).

### Bridge four: empirical means normalize the slot count

{{< lean-bridge
  human="Scale the counting measure by the reciprocal dimension; at size zero, use the zero measure."
  math="\(L_H=n^{-1}N_H\text{ for }n\gt0,\qquad L_H=0\text{ for }n=0.\)"
  lean="RandomMatrix.empiricalSpectralMeasure H : Measure ℝ"
>}}

- The source writes <code>(n : ℝ≥0∞)⁻¹</code>, the inverse of the
  dimension in the extended nonnegative reals used to scale measures.
- <code>•</code> is scalar multiplication of a measure.
- <code>empiricalSpectralMeasure_zero H</code> proves the empty-size value is
  exactly zero.
- <code>empiricalSpectralMeasure_succ_isProbability n H</code> proves mass one
  for a matrix of size <code>n + 1</code>.
- <code>empiricalSpectralProbability n H</code> adds the mass-one proof and
  returns a bundled <code>ProbabilityMeasure ℝ</code> only in positive
  dimension.
{{< /lean-bridge >}}

For our matrix, the dimension is two, so each unit counting atom becomes an
empirical atom of mass one half.

### Bridge five: measurability belongs to the whole observable

{{< lean-bridge
  human="In the current successor module, the map sending a Hermitian matrix to its empirical spectral measure is measurable."
  math="\(H\mapsto L_H:\mathcal H_n\to\operatorname{Measure}(\mathbb R)\text{ is measurable}.\)"
  lean="RandomMatrix.measurable_empiricalSpectralMeasure : Measurable (@RandomMatrix.empiricalSpectralMeasure n)"
>}}

- <code>@</code> exposes the implicit dimension argument so the function being
  measured is unambiguous.
- <code>Measurable</code> licenses preimages and pushforward measures. It does
  not choose a source probability law.
- The codomain <code>Measure ℝ</code> carries Mathlib's Giry measurable
  structure, generated by measurable evaluation maps.
- RMT-10A exports only
  <code>measurable_empiricalSpectralMeasure_of_measurable_eigenvalues</code>,
  whose argument is the coordinatewise hypothesis.
- RMT-10B proves
  <code>measurable_orderedHermitianEigenvalues_apply</code> from a 1-Lipschitz
  perturbation bound, then supplies it to the RMT-10A theorem.
{{< /lean-bridge >}}

This is a current project theorem, but it belongs to
<code>HermitianSpectrumContinuity.lean</code>, not to the base RMT-10A module.

### Bridge six: a random spectral law is an outer measure

{{< lean-bridge
  human="Push the intrinsic finite GUE matrix law through the measurable sample-measure map; the result is a law whose points are whole measures."
  math="\(\mathcal Q_n=(H\mapsto L_H)_*\mu_n\in\operatorname{Measure}(\operatorname{Measure}(\mathbb R)).\)"
  lean="GUE.empiricalSpectralLaw n : Measure (Measure ℝ)"
>}}

- <code>GUE.intrinsicLaw n</code> is the source probability measure on
  intrinsic Hermitian matrices.
- <code>.map empiricalSpectralMeasure</code> is the pushforward through the
  sample-measure function.
- The outer <code>Measure (...)</code> describes randomness across matrix
  samples; the inner <code>Measure ℝ</code> is one sample's spectral measure.
- <code>instIsProbabilityMeasureEmpiricalSpectralLaw n</code> proves the outer
  law has mass one in every dimension.
- At \(n=0\), <code>empiricalSpectralLaw_zero</code> identifies this outer law
  with <code>Measure.dirac (0 : Measure ℝ)</code>.
{{< /lean-bridge >}}

This named unconditional law first appears in RMT-10C. RMT-10A's strongest
law statement is only the conditional equality between ambient and intrinsic
pushforward routes.

### Bridge seven: joining the outer law gives one mean measure

{{< lean-bridge
  human="Average the inner sample measures under their outer law; the result is one measure on the real line, not another law on measures."
  math="\(\overline L_n(B)=\int L(B)\,\mathcal Q_n(\mathrm dL),\qquad \overline L_n\in\operatorname{Measure}(\mathbb R).\)"
  lean="GUE.meanEmpiricalSpectralMeasure n = (GUE.empiricalSpectralLaw n).join"
>}}

- <code>.join</code> is the Giry barycenter operation on a measure of measures.
- The result has type <code>Measure ℝ</code>, one level lower than
  <code>Measure (Measure ℝ)</code>.
- This is an average of sample measures, not the expected value of a matrix and
  not a sample empirical measure for a distinguished matrix.
- <code>meanEmpiricalSpectralMeasure_zero</code> proves that the mean is zero at
  size zero.
- <code>meanEmpiricalSpectralMeasure_succ_isProbability</code> proves the mean
  has mass one in every positive dimension.
{{< /lean-bridge >}}

The displayed equality is the body of the RMT-10C definition. It does not by
itself prove a density, an interchange of arbitrary integrals, or an
asymptotic limit.

### Try the exact RMT-10A declarations in the repository

{{< repo-check >}}
**Resource label: pinned project plus Mathlib, cloud-only for this project.**
On an approved Linux builder, place this probe in a temporary project scratch
file:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.HermitianSpectrum

open Matrix MeasureTheory
open scoped ENNReal Matrix
open NonlinearDynamics.Random

#print RandomMatrix.orderedHermitianEigenvalues
#check RandomMatrix.orderedHermitianEigenvalues_antitone
#check RandomMatrix.trace_eq_sum_orderedHermitianEigenvalues
#check RandomMatrix.trace_sq_eq_sum_sq_orderedHermitianEigenvalues
#check RandomMatrix.orderedHermitianEigenvalues_hermitianCongruence
#print RandomMatrix.spectralCountingMeasure
#check RandomMatrix.spectralCountingMeasure_univ
#print RandomMatrix.empiricalSpectralMeasure
#check RandomMatrix.empiricalSpectralMeasure_zero
#check RandomMatrix.empiricalSpectralMeasure_succ_isProbability
#check RandomMatrix.empiricalSpectralProbability
#check RandomMatrix.measurable_empiricalSpectralMeasure_of_measurable_eigenvalues
#check RandomMatrix.map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw_of_measurable_eigenvalues
~~~

<code>#print</code> exposes definition bodies. <code>#check</code> asks the
pinned elaborator for exact declaration types. Notice that the final two names
retain the hypothesis in their names. The guarded command rendered below
checks the authoritative RMT-10A source, not the temporary probe.
{{< /repo-check >}}

### Try the exact RMT-10B measurability bridge

{{< repo-check module="NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity" >}}
**Resource label: pinned project plus Mathlib, cloud-only for this project.**
Type this separate probe on the approved Linux builder:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity

open NonlinearDynamics.Random

#check RandomMatrix.abs_orderedHermitianEigenvalues_sub_le_frobenius
#check RandomMatrix.lipschitzWith_orderedHermitianEigenvalues_apply
#check RandomMatrix.continuous_orderedHermitianEigenvalues_apply
#check RandomMatrix.measurable_orderedHermitianEigenvalues_apply
#check RandomMatrix.measurable_spectralCountingMeasure
#check RandomMatrix.measurable_empiricalSpectralMeasure
#check RandomMatrix.measurable_empiricalSpectralProbability
#check RandomMatrix.measurable_ambientEmpiricalSpectralMeasure
#check RandomMatrix.map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw
~~~

These are unconditional successor declarations. Their module first proves the
perturbation bound, then continuity, then measurability. The generated command
checks that exact leaf with warnings fatal through the repository guard.
{{< /repo-check >}}

### Try the exact RMT-10C law and mean interfaces

{{< repo-check module="NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleSpectrum" >}}
**Resource label: pinned project plus Mathlib, cloud-only for this project.**
The final probe distinguishes the sample measure, its law, and its mean:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleSpectrum

open NonlinearDynamics.Random

#check RandomMatrix.empiricalSpectralMeasure
#check GUE.empiricalSpectralLaw
#check GUE.empiricalSpectralLawProbability
#check GUE.empiricalSpectralProbabilityLaw
#check GUE.empiricalSpectralLaw_zero
#print GUE.meanEmpiricalSpectralMeasure
#check GUE.meanEmpiricalSpectralMeasure_zero
#check GUE.meanEmpiricalSpectralMeasure_succ_isProbability
#check GUE.integral_empiricalSpectralMoment_one
#check GUE.integral_empiricalSpectralMoment_two
#check GUE.integral_empiricalSpectralMoment_two_succ
~~~

The two nested law types are intentionally different. The raw all-dimensions
law has samples in <code>Measure ℝ</code>; the positive-dimensional bundled
law has samples in <code>ProbabilityMeasure ℝ</code>. The final three
theorems are finite expected-moment statements, not asymptotics.
{{< /repo-check >}}

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
space inherited from its finite real Euclidean structure. At the RMT-10A
boundary, the remaining problem was not a missing measurable structure on the
matrix space. It was the lack, inside that module, of a theorem connecting the
specific ordered-eigenvalue functions to that structure. RMT-10B now supplies
that theorem.

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

### What RMT-10A assumes, and RMT-10B proves

Inside RMT-10A, the implication is checked while its premise remains an
argument to the theorem.

Pinned Mathlib's matrix-spectrum module provides
<code>eigenvalues₀</code>, antitonicity in the **index**, and algebraic
spectral identities. It does not provide continuity of the map from Hermitian
matrices to each ordered eigenvalue coordinate, nor the weaker measurability
theorem needed here. Antitonicity in \(i\) says nothing about dependence on
\(H\).

The repository's next module, RMT-10B, discharges the premise. It proves the
Frobenius perturbation inequality

\[
|\lambda_i(A)-\lambda_i(B)|\leq \|A-B\|_F,
\]

then derives 1-Lipschitz continuity, continuity, and coordinatewise
measurability. Therefore the current project may write the unconditional
<code>measurable_empiricalSpectralMeasure</code>. When discussing RMT-10A
alone, however, writing

\[
\bigl(\operatorname{GUE\ matrix\ law}\bigr)
\mathbin{\mathrm{map}}L
\]

without displaying its hypothesis would overstate that module's interface.

{{< panel "warning" >}}
**Do not read an <code>of_measurable_eigenvalues</code> theorem backwards.**
It proves that coordinatewise measurability is sufficient for the
measure-valued observable. It does not synthesize or certify that hypothesis.
That was the exact design seam consumed by RMT-10B; the successor's
unconditional theorem is the current interface once that module is imported.
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

Its RMT-10A measurability theorem remains conditional because the totalization
is measurable but that module still requests ordered-eigenvalue measurability.
RMT-10B supplies the request and exports
<code>measurable_ambientEmpiricalSpectralMeasure</code> unconditionally.

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

## Type the size-two ledger yourself with Lean and Std

The exact project spectrum uses Mathlib's complex matrices, Hermitian spectral
theorem, finite measures, and Giry measurable space. A first-time reader can
check the running arithmetic before loading that machinery. The worksheet
below imports only Lean's <code>Std</code> library and models real two-by-two
matrices with four integer fields.

Create a scratch directory outside <code>formalization/</code>. Save this exact
block as <code>HermitianSpectraTutorial.lean</code>:

~~~lean
import Std

namespace HermitianSpectraTutorial

structure Vec2 where
  x : Int
  y : Int
  deriving Repr, DecidableEq

def Vec2.scale (a : Int) (v : Vec2) : Vec2 :=
  { x := a * v.x, y := a * v.y }

structure Matrix2 where
  a00 : Int
  a01 : Int
  a10 : Int
  a11 : Int
  deriving Repr, DecidableEq

def Matrix2.mulVec (A : Matrix2) (v : Vec2) : Vec2 :=
  { x := A.a00 * v.x + A.a01 * v.y
    y := A.a10 * v.x + A.a11 * v.y }

def Matrix2.IsHermitian (A : Matrix2) : Prop :=
  A.a01 = A.a10

instance (A : Matrix2) : Decidable A.IsHermitian := by
  unfold Matrix2.IsHermitian
  infer_instance

def isEigenpair (A : Matrix2) (lambda : Int) (v : Vec2) : Bool :=
  v != { x := 0, y := 0 } &&
    A.mulVec v == v.scale lambda

def trace (A : Matrix2) : Int :=
  A.a00 + A.a11

def traceSquare (A : Matrix2) : Int :=
  A.a00 * A.a00 + 2 * A.a01 * A.a10 + A.a11 * A.a11

def spectralSum (spectrum : List Int) : Int :=
  spectrum.foldl (fun total x => total + x) 0

def spectralSquareSum (spectrum : List Int) : Int :=
  spectrum.foldl (fun total x => total + x * x) 0

def atomCount (spectrum : List Int) (x : Int) : Nat :=
  spectrum.count x

def H : Matrix2 :=
  { a00 := 2, a01 := 1, a10 := 1, a11 := 2 }

def D : Matrix2 :=
  { a00 := 3, a01 := 0, a10 := 0, a11 := 1 }

def plus : Vec2 := { x := 1, y := 1 }
def minus : Vec2 := { x := 1, y := -1 }
def e0 : Vec2 := { x := 1, y := 0 }
def e1 : Vec2 := { x := 0, y := 1 }

def orderedSpectrumH : List Int := [3, 1]
def orderedSpectrumD : List Int := [3, 1]
def emptySpectrum : List Int := []

#eval [isEigenpair H 3 plus, isEigenpair H 1 minus,
  isEigenpair D 3 e0, isEigenpair D 1 e1]

#eval (orderedSpectrumH,
  [atomCount orderedSpectrumH 3,
   atomCount orderedSpectrumH 1,
   atomCount orderedSpectrumH 2],
  orderedSpectrumH.length)

#eval [trace H, traceSquare H,
  spectralSum orderedSpectrumH,
  spectralSquareSum orderedSpectrumH]

#eval [decide (H = D), decide (orderedSpectrumH = orderedSpectrumD),
  decide H.IsHermitian, decide D.IsHermitian]

#eval (emptySpectrum.length, atomCount emptySpectrum 0)

example : isEigenpair H 3 plus = true := by decide
example : isEigenpair H 1 minus = true := by decide
example : orderedSpectrumH = [3, 1] := by decide
example : atomCount orderedSpectrumH 3 = 1 := by decide
example : atomCount orderedSpectrumH 1 = 1 := by decide
example : atomCount orderedSpectrumH 2 = 0 := by decide
example : trace H = spectralSum orderedSpectrumH := by decide
example : traceSquare H = spectralSquareSum orderedSpectrumH := by decide
example : H ≠ D := by decide
example : orderedSpectrumH = orderedSpectrumD := by decide
example : emptySpectrum.length = 0 := by decide

end HermitianSpectraTutorial
~~~

Open a terminal in that scratch directory and type:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean HermitianSpectraTutorial.lean
~~~

This exact worksheet was executed successfully with Lean 4.32.0 while the
chapter was rebuilt. Lean printed:

~~~text
[true, true, true, true]
([3, 1], [1, 1, 0], 2)
[4, 10, 4, 10]
[false, true, true, true]
(0, 0)
~~~

Read the output in order:

1. the four candidate eigenpairs for \(H\) and \(D\) all satisfy
   \(Av=\lambda v\);
2. the ordered spectrum is \([3,1]\), its masses at \(3,1,2\) are
   \([1,1,0]\) in counting units, and it has two slots;
3. matrix trace, matrix trace square, spectral sum, and spectral square sum
   are \([4,10,4,10]\);
4. \(H=D\) is false, their spectrum lists are equal, and both symmetry checks
   are true; and
5. the empty spectrum has zero slots and zero atoms at zero.

Each <code>example</code> asks Lean's kernel to certify one finite equality.
The code deliberately stores empirical masses as integer atom counts with a
separate denominator two, so there is no hidden floating-point calculation.
It verifies the tutorial ledger only. It does not prove the general Hermitian
spectral theorem, compute Mathlib's <code>eigenvalues₀</code>, construct a
<code>Measure ℝ</code>, or check any project declaration. Its command is safe
on an ordinary Mac or Linux host because it loads only the pinned compiler and
<code>Std</code>.

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

Only the last row is conditional inside RMT-10A. RMT-10B later discharges its
premise and exports <code>measurable_spectralCountingMeasure</code>.

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

The first six are unconditional in RMT-10A. The last two display the premise
that RMT-10B discharges before exporting unconditional counterparts.

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

### Forgetting which GUE bridge is being quoted

The RMT-10A name ending in
<code>of_measurable_eigenvalues</code> assumes coordinatewise eigenvalue
measurability. The theorem does not make that premise disappear. RMT-10B's
shorter theorem
<code>map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw</code>
has no such argument because that successor imports the proof.

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

## Reproduce the chapter without crossing the host boundary

On an ordinary Mac or Linux machine, a reader may run the bounded
<code>Std</code> worksheet exactly as shown above. From the repository root,
the workstation may also verify the page-owned card and the static site:

~~~sh
site/content/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures/generate-card.sh --verify
make site-check
git diff --check
~~~

These commands do not compile the project. The exact RMT-10A, RMT-10B, and
RMT-10C modules import Mathlib and therefore belong on approved Linux compute.
The three <strong>Try it in the repository</strong> panels above render the
guarded commands separately:

~~~sh
CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/Random/RandomMatrices/HermitianSpectrum.lean

CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/Random/RandomMatrices/HermitianSpectrumContinuity.lean

CLOUD_LEAN_BUILD=1 make lean-file \
  LEAN_FILE=NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleSpectrum.lean
~~~

The full cloud release gate is <code>CLOUD_LEAN_BUILD=1 make check</code> on an
approved Linux builder. This rebuild does not claim that any project module
was recompiled on the Mac. A green technical build would still not complete
the pending human mathematical, editorial, scientific-integrity, and
accessibility reviews.

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
