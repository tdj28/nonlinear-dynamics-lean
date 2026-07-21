---
title: "Hermitian Spectral Perturbation, Continuity, and Measurability"
slug: "hermitian-spectral-perturbation-continuity-and-measurability"
date: 2026-07-21
summary: "A textbook climb from Frobenius matrix-vector control through a finite min-max witness to 1-Lipschitz ordered eigenvalues, measurable empirical spectra, and an unconditional intrinsic-versus-ambient Gaussian unitary ensemble pushforward bridge."
lead: "Ordered Hermitian eigenvalues do not jump when the matrix moves. A direct finite-dimensional proof turns a Frobenius perturbation budget into a coordinatewise spectral bound, then turns that bound into continuity, measurability, and law-level spectral observables."
draft: true
pro_reviewed: false
level: "Finite-dimensional Hermitian perturbation theory through measurable spectral laws"
reading_time: "90 to 120 minutes"
prerequisites: "Hermitian matrices, finite-dimensional inner-product spaces, ordered eigenvalues, Frobenius norm, elementary measure pushforwards, and the distinction between a sample observable and its probability law; every specialized step is rebuilt along the route"
lean_module: "NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity"
toc: true
og_image: "hermitian-spectral-perturbation-continuity-and-measurability-card.png"
og_image_alt: "Top modes of one Hermitian matrix and bottom modes of another overlap to provide a witness; quadratic-form control yields a Weyl bound, then Lipschitz continuity unlocks measurable empirical spectra and the intrinsic-versus-ambient Gaussian unitary ensemble law bridge."
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
prose, citations, Lean declaration map, figures, and accessibility have not yet
received the required human and Pro reviews. The page must remain a draft until
those gates are complete.
{{< /panel >}}

The preceding spectral layer attached a decreasing real eigenvalue vector to
every finite intrinsic Hermitian matrix. It then turned that vector into a
spectral counting measure and a zero-aware
{{< refterm "empirical-spectral-measure" "empirical spectral measure" >}}.
Those constructions were algebraically complete, but their measure-valued
maps were conditionally measurable: each theorem asked the caller to prove
that every ordered eigenvalue coordinate was measurable.

RMT-10B closes that seam. Its central deterministic estimate is

\[
\boxed{
\left|\lambda_i(A)-\lambda_i(B)\right|
\le \lVert A-B\rVert_F
}
\]

for two \(n\)-by-\(n\) Hermitian matrices \(A\) and \(B\), with both spectra
listed in decreasing order and \(i\in\operatorname{Fin}(n)\). The norm is the
intrinsic {{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius norm" >}}.

The estimate is strong enough to make each coordinate 1-Lipschitz and the full
ordered vector 1-Lipschitz for the finite function-space sup metric. Lipschitz
maps are continuous; continuous maps between the Borel spaces in use are
measurable. The conditional Giry interfaces from RMT-10A can therefore be
discharged, including the equality between the empirical-spectral
pushforwards of the ambient and intrinsic Gaussian unitary ensemble (GUE)
laws.

The proof is deliberately finite and structural. It does not import an
operator-norm Weyl theorem. Instead it builds an ordered eigenbasis, forms top
and bottom spectral subspaces, forces them to intersect by dimension, and
uses a vector in that intersection to compare two quadratic forms. That route
makes every hypothesis and every norm visible in Lean.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [The result in one picture](#the-result-in-one-picture) | See how a witness becomes a measurable-law bridge |
| Norm route | [Frobenius control of matrix-vector multiplication](#base-camp-one-frobenius-control-of-matrix-vector-multiplication) | Prove the analytic estimate that bounds quadratic-form change |
| Spectral route | [Reindex the eigenbasis in the same order](#base-camp-two-reindex-the-eigenbasis-in-the-same-order) | Align eigenvectors with the decreasing eigenvalue API |
| Min-max route | [Top and bottom spectral subspaces](#camp-two-top-and-bottom-spectral-subspaces) | Build the nonzero intersection witness |
| Inequality route | [The one-sided Weyl estimate](#camp-four-the-one-sided-weyl-estimate) | Derive the absolute coordinate bound |
| Topology route | [From coordinates to a Lipschitz vector](#camp-five-from-coordinates-to-a-lipschitz-vector) | Separate coordinate and finite sup-metric claims |
| Probability route | [From continuity to Giry measurability](#camp-six-from-continuity-to-giry-measurability) | Remove the earlier measure-valued hypotheses |
| Physics route | [Energy levels under a Hamiltonian perturbation](#physics-camp-energy-levels-under-a-hamiltonian-perturbation) | Interpret the theorem without inventing a probabilistic result |
| Lean audit route | [The complete public API](#the-complete-public-api) | Map every public declaration to its exact role |

### Learning objectives

By the summit, you should be able to:

1. distinguish the Frobenius norm from the spectral operator norm;
2. derive the matrix-vector estimate used by the proof;
3. explain why the eigenbasis must be reindexed by the same order-preserving
   cast as the eigenvalue vector;
4. expand a Hermitian quadratic form as a weighted sum of squared eigenbasis
   coordinates;
5. define the top \(i+1\) and bottom \(n-i\) spectral subspaces;
6. prove that those two subspaces have a nonzero intersection;
7. explain why the intersection vector is the finite min-max witness;
8. derive the one-sided ordered-eigenvalue estimate;
9. obtain the absolute bound by swapping the two matrices;
10. state the coordinatewise 1-Lipschitz theorem;
11. identify the whole-vector target metric as the finite sup metric rather
    than an \(\ell^2\) eigenvalue metric;
12. follow the implication from Lipschitz to continuous to measurable;
13. explain how coordinate measurability makes a finite Dirac sum measurable;
14. state the now-unconditional counting, empirical, and ambient spectral
    measurability theorems;
15. draw the intrinsic-versus-ambient GUE pushforward square;
16. distinguish eigenvalue continuity from eigenvector continuity;
17. distinguish this theorem from Hoffman-Wielandt and Davis-Kahan; and
18. list the density, concentration, differentiability, gap, and asymptotic
    results that RMT-10B does not prove.

## The result in one picture

{{< reference-figure
  src="intersection-to-measurable-law.svg"
  alt="Top spectral modes of a first Hermitian matrix and bottom spectral modes of a second matrix overlap by dimension. A shared nonzero witness lets quadratic forms squeeze one ordered eigenvalue, swapping the matrices gives a two-sided bound, and the resulting Lipschitz spectrum unlocks measurable spectral pushforwards."
  caption="**Finding:** the bridge from algebra to probability is earned by one deterministic witness. A dimension-forced intersection compares the same vector against both quadratic forms; the resulting coordinate bound yields continuity and measurability, which then discharges the earlier Giry hypotheses. This proof ladder does not control eigenvectors, prove a full-spectrum Euclidean estimate, or add a GUE density or limit theorem."
>}}

The figure compresses three mathematical layers that must stay separate:

1. **Linear algebra:** an ordered eigenbasis and two spectral subspaces produce
   a nonzero common vector.
2. **Analysis:** a matrix-vector norm estimate bounds the change in a
   quadratic form and therefore the change in an ordered eigenvalue.
3. **Measurable probability:** continuity of the eigenvalue coordinates makes
   the finite atomic spectral observables measurable, so probability laws may
   be pushed through them without a conditional premise.

No probability distribution is used to prove the perturbation bound. GUE
enters only at the final pushforward comparison.

{{< checkpoint stage="Orientation" title="The theorem boundary in one sentence" >}}
RMT-10B proves deterministic Frobenius 1-Lipschitz control of the decreasing
Hermitian eigenvalue vector and uses it to establish measurability of existing
finite spectral observables. It does not prove stability of eigenvectors,
probabilistic concentration, a density, or any large-dimension limit.
{{< /checkpoint >}}

## Base camp zero: spaces, norms, and indexing

The source type is
<code>RandomMatrix.HermitianEuclidean n</code>. It is the real Euclidean
subspace of complex matrices satisfying \(H^*=H\), where \(H^*\) is the
conjugate transpose. Its norm is inherited from the ambient Frobenius space:

\[
\lVert H\rVert_F^2
=\sum_{j,k}|H_{jk}|^2
=\operatorname{Tr}(H^2).
\]

The last equality uses Hermiticity. It should not be transferred unchanged to
an arbitrary complex matrix.

Vectors live in <code>EuclideanSpace ℂ (Fin n)</code>, with the ordinary
complex Euclidean norm. Matrix-vector multiplication is written
<code>A *ᵥ x</code>. The conversion <code>WithLp.toLp 2</code> packages the
resulting coordinate function as the Euclidean-space value expected by the
norm and inner-product APIs.

The ordered spectrum from RMT-10A is

\[
\Lambda(H)
=\bigl(\lambda_0(H),\ldots,\lambda_{n-1}(H)\bigr),
\qquad
\lambda_0(H)\ge\cdots\ge\lambda_{n-1}(H).
\]

Indices start at zero. Thus “top through \(i\)” contains \(i+1\) slots, while
“bottom from \(i\)” contains \(n-i\) slots. This arithmetic is the engine of
the later intersection proof.

### Frobenius versus operator norm

The Frobenius norm measures the Euclidean size of all matrix entries. The
\(\ell^2\) operator norm measures the largest vector amplification:

\[
\lVert A\rVert_{\mathrm{op}}
=\sup_{\lVert x\rVert=1}\lVert Ax\rVert.
\]

For a finite matrix,

\[
\lVert A\rVert_{\mathrm{op}}\le\lVert A\rVert_F.
\]

The sharp classical Weyl perturbation theorem is commonly stated with the
operator norm. The checked module proves a Frobenius statement directly
because the project already has a carefully audited intrinsic Frobenius
geometry. Saying “Weyl bound” here therefore names the ordered-eigenvalue
perturbation pattern; the exact formal theorem uses \(\lVert\cdot\rVert_F\).
The {{< refterm "weyl-eigenvalue-bound" "Weyl eigenvalue bound" >}} entry keeps
this distinction available as a compact reference.

## Base camp one: Frobenius control of matrix-vector multiplication

The first public theorem is more general than the later Hermitian result. For
any complex square matrix \(M\) and Euclidean vector \(x\),

\[
\lVert Mx\rVert_2
\le\lVert M\rVert_F\lVert x\rVert_2.
\]

In Lean:

~~~lean
theorem norm_mulVec_le_frobenius
    (A : Matrix (Fin n) (Fin n) ℂ)
    (x : EuclideanSpace ℂ (Fin n)) :
    ‖WithLp.toLp 2 (A *ᵥ x)‖ ≤
      ‖matrixToFrobenius A‖ * ‖x‖
~~~

The proof reuses Mathlib's Frobenius submultiplicativity rather than expanding
every coordinate and running Cauchy-Schwarz by hand. Regard \(x\) as the single
column of an \(n\)-by-\(1\) matrix. Then

\[
Mx=M\,\operatorname{col}(x),
\]

and

\[
\begin{aligned}
\lVert Mx\rVert_2
&=\lVert M\,\operatorname{col}(x)\rVert_F\\
&\le\lVert M\rVert_F\,
     \lVert\operatorname{col}(x)\rVert_F\\
&=\lVert M\rVert_F\lVert x\rVert_2.
\end{aligned}
\]

The private lemma <code>norm_matrixToFrobenius_eq_frobenius</code> aligns the
norm on the project's flattened Frobenius carrier with Mathlib's matrix
Frobenius norm. The official matrix-norm documentation emphasizes that
Mathlib has several matrix norms and deliberately exposes them through scoped
instances; importing or opening the wrong scope would change the meaning of
the displayed norm
([Mathlib contributors](#ref-perturb-mathlib-normed)).

### The quadratic-form difference bound

For an intrinsic Hermitian matrix \(H\), define the real quadratic form

\[
q_H(x)=\operatorname{Re}\langle x,Hx\rangle.
\]

The real part makes the codomain explicit. Hermiticity implies the inner
product is real, but the ambient complex inner-product API still returns a
complex number.

Apply the matrix-vector theorem to \(A-B\), then use the inner-product
Cauchy-Schwarz inequality:

\[
\begin{aligned}
|q_A(x)-q_B(x)|
&=\left|\operatorname{Re}\langle x,(A-B)x\rangle\right|\\
&\le\left|\langle x,(A-B)x\rangle\right|\\
&\le\lVert x\rVert\,\lVert(A-B)x\rVert\\
&\le\lVert A-B\rVert_F\lVert x\rVert^2.
\end{aligned}
\]

The module keeps <code>hermitianQuadratic</code> and this difference theorem
private. They are proof architecture, not a parallel public quadratic-form
library.

## Base camp two: reindex the eigenbasis in the same order

Mathlib's finite Hermitian spectral theorem supplies an orthonormal eigenbasis
and an ordered real eigenvalue vector
([Mathlib contributors](#ref-perturb-mathlib-spectrum)). RMT-10A transported
the ordered vector from <code>Fin (Fintype.card (Fin n))</code> to
<code>Fin n</code> using an order-preserving cast.

RMT-10B must perform the same transport on the eigenbasis. Otherwise the basis
coordinate at index \(i\) and the ordered eigenvalue at index \(i\) could refer
to different slots. The private
<code>orderedHermitianEigenvectorBasis</code> reindexes Mathlib's basis by the
same finite order equivalence.

The key action theorem then reads, schematically,

\[
\widehat{Hx}_j=\lambda_j(H)\widehat{x}_j,
\]

where \(\widehat{x}_j\) is the \(j\)-th coordinate of \(x\) in the ordered
eigenbasis. This gives the weighted expansion

\[
q_H(x)=\sum_j\lambda_j(H)|\widehat{x}_j|^2.
\]

Orthonormality also gives Parseval's identity:

\[
\lVert x\rVert^2=\sum_j|\widehat{x}_j|^2.
\]

These two formulas translate ordering information into inequalities for whole
subspaces. The private helper <code>re_inner_real_mul_self</code> handles the
small complex-arithmetic step that turns the real part of an inner product
with a real scalar into a real scalar times a squared norm.

## Camp two: top and bottom spectral subspaces

Fix \(i\in\operatorname{Fin}(n)\). For the first matrix \(A\), define the top
spectral subspace

\[
T_A(i)
=\operatorname{span}\{u_j(A):j\le i\}.
\]

It contains the first \(i+1\) ordered eigenvectors, so

\[
\dim_{\mathbb C}T_A(i)=i+1.
\]

For the second matrix \(B\), define the bottom spectral subspace

\[
S_B(i)
=\operatorname{span}\{u_j(B):i\le j\}.
\]

It contains the last \(n-i\) ordered eigenvectors, so

\[
\dim_{\mathbb C}S_B(i)=n-i.
\]

The module defines these subspaces using <code>Set.Iic i</code> and
<code>Set.Ici i</code>, the closed lower and upper order intervals. It proves
their dimensions from linear independence of subsets of an orthonormal basis.

### Why top vectors bound from below

If \(x\in T_A(i)\), every eigenbasis coordinate with \(j\gt i\) is zero. For
the remaining coordinates, decreasing order gives
\(\lambda_j(A)\ge\lambda_i(A)\). Therefore

\[
\begin{aligned}
q_A(x)
&=\sum_{j\le i}\lambda_j(A)|\widehat{x}_j|^2\\
&\ge\lambda_i(A)\sum_{j\le i}|\widehat{x}_j|^2\\
&=\lambda_i(A)\lVert x\rVert^2.
\end{aligned}
\]

The private support lemma
<code>ordered_repr_eq_zero_of_mem_top</code> supplies the vanishing
coordinates.

### Why bottom vectors bound from above

If \(x\in S_B(i)\), every coordinate with \(j\lt i\) is zero. For the remaining
coordinates, \(\lambda_j(B)\le\lambda_i(B)\). Hence

\[
q_B(x)\le\lambda_i(B)\lVert x\rVert^2.
\]

This is the mirror image of the top-space argument, with
<code>ordered_repr_eq_zero_of_mem_bottom</code> supplying the support fact.

## Camp three: dimension forces a common witness

Both subspaces sit in the \(n\)-dimensional complex Euclidean space. Their
dimensions add to

\[
(i+1)+(n-i)=n+1.
\]

Two disjoint subspaces of an \(n\)-dimensional space can have total dimension
at most \(n\). Therefore

\[
T_A(i)\cap S_B(i)\ne\{0\}.
\]

Choose a nonzero vector \(x\) in the intersection. It is simultaneously a top
combination for \(A\) and a bottom combination for \(B\), so the two previous
inequalities apply to the same vector:

\[
\lambda_i(A)\lVert x\rVert^2
\le q_A(x),
\qquad
q_B(x)\le\lambda_i(B)\lVert x\rVert^2.
\]

This is the heart of the finite min-max argument. The proof does not need to
choose one eigenvector shared by \(A\) and \(B\), which generally would not
exist. It chooses a vector shared by two deliberately oversized spectral
subspaces.

In Lean, <code>ordered_top_inf_bottom_ne_bot</code> proves that the infimum of
the two submodules is not bottom. It argues by contradiction: disjointness
would invoke Mathlib's finite-rank inequality, while the already calculated
dimensions reduce that inequality to impossible natural-number arithmetic.

## Camp four: the one-sided Weyl estimate

Subtract the two quadratic inequalities:

\[
\bigl(\lambda_i(A)-\lambda_i(B)\bigr)\lVert x\rVert^2
\le q_A(x)-q_B(x).
\]

The quadratic-form difference bound gives

\[
q_A(x)-q_B(x)
\le |q_A(x)-q_B(x)|
\le\lVert A-B\rVert_F\lVert x\rVert^2.
\]

Because \(x\ne0\), its squared norm is positive and can be cancelled. The
result is

\[
\lambda_i(A)\le\lambda_i(B)+\lVert A-B\rVert_F.
\]

This is the public theorem
<code>orderedHermitianEigenvalues_le_add_frobenius</code>. The one-sided form
is a useful interface in its own right: many real-valued Lipschitz lemmas are
designed around a bound of the form \(f(A)\le f(B)+K\,d(A,B)\).

Swap \(A\) and \(B\). Symmetry of the norm gives

\[
\lambda_i(B)\le\lambda_i(A)+\lVert A-B\rVert_F.
\]

Combining both sides yields

\[
\left|\lambda_i(A)-\lambda_i(B)\right|
\le\lVert A-B\rVert_F,
\]

the public theorem
<code>abs_orderedHermitianEigenvalues_sub_le_frobenius</code>.

### A diagonal check

Suppose \(A\) and \(B\) are already diagonal in the same basis, with
decreasing diagonals \(a_0,\ldots,a_{n-1}\) and
\(b_0,\ldots,b_{n-1}\). Then

\[
|a_i-b_i|
\le\left(\sum_j|a_j-b_j|^2\right)^{1/2}
=\lVert A-B\rVert_F.
\]

The theorem reduces to the fact that one coordinate of a Euclidean vector is
at most its total Euclidean length. The full proof earns the same conclusion
when the two matrices have unrelated eigenbases.

### Dimension zero

When \(n=0\), there is no value of type <code>Fin 0</code>. Every theorem that
takes an eigenvalue index is vacuous rather than false. The whole-vector map
lands in the unique empty function and is still 1-Lipschitz. No artificial
eigenvalue or fallback coordinate is introduced.

## Camp five: from coordinates to a Lipschitz vector

For each fixed \(i\), the absolute bound is exactly the metric inequality

\[
d_{\mathbb R}\bigl(\lambda_i(A),\lambda_i(B)\bigr)
\le 1\cdot d_F(A,B).
\]

Mathlib packages that statement as

~~~lean
theorem lipschitzWith_orderedHermitianEigenvalues_apply (i : Fin n) :
    LipschitzWith 1 (fun H : HermitianEuclidean n =>
      orderedHermitianEigenvalues H i)
~~~

The constant has type <code>NNReal</code>, a nonnegative real number. The
official <code>LipschitzWith</code> API defines the predicate by a distance
inequality and supplies continuity as a theorem
([Mathlib contributors](#ref-perturb-mathlib-lipschitz)).

The full map

\[
\Lambda:\mathcal H_n\longrightarrow(\operatorname{Fin}(n)\to\mathbb R)
\]

is also 1-Lipschitz:

~~~lean
theorem lipschitzWith_orderedHermitianEigenvalues :
    LipschitzWith 1 (@orderedHermitianEigenvalues n)
~~~

The target is an ordinary finite function type with Mathlib's uniform
function-space metric. The proof invokes <code>dist_pi_le_iff</code> and checks
the distance bound coordinate by coordinate. In familiar finite-dimensional
language, this is the sup estimate

\[
\max_i|\lambda_i(A)-\lambda_i(B)|
\le\lVert A-B\rVert_F
\]

when the index type is nonempty. The formal statement also covers the empty
index type without inventing a maximum of an empty set.

### What “1-Lipschitz” does and does not say

It says that \(1\) is a globally valid Lipschitz constant for the displayed
source and target metrics. It does not prove that \(1\) is the smallest
possible constant on every restricted subset. It does not replace the
Frobenius source norm by the operator norm. It also does not change the target
to a Euclidean \(\ell^2\) norm.

The last distinction matters. Hoffman-Wielandt controls a matched
full-spectrum \(\ell^2\) cost by the Frobenius matrix distance for normal
matrices ([Hoffman and Wielandt](#ref-perturb-hoffman-wielandt)). RMT-10B
proves a coordinate bound and packages those coordinates in the finite sup
metric. The two conclusions are related, but they are not the same theorem.

## Camp six: from continuity to Giry measurability

A Lipschitz map is continuous. The module records both coordinatewise and
whole-vector forms:

~~~lean
theorem continuous_orderedHermitianEigenvalues_apply (i : Fin n) :
    Continuous (fun H : HermitianEuclidean n =>
      orderedHermitianEigenvalues H i)

theorem continuous_orderedHermitianEigenvalues :
    Continuous (@orderedHermitianEigenvalues n)
~~~

The intrinsic Hermitian space and finite real function space carry their Borel
measurable structures. Continuity therefore supplies:

~~~lean
theorem measurable_orderedHermitianEigenvalues_apply (i : Fin n) :
    Measurable (fun H : HermitianEuclidean n =>
      orderedHermitianEigenvalues H i)

theorem measurable_orderedHermitianEigenvalues :
    Measurable (@orderedHermitianEigenvalues n)
~~~

These are ordinary <code>Measurable</code> statements, not only
almost-everywhere measurability under one selected law.

### From coordinates to a measure-valued map

RMT-10A had already proved a conditional theorem. If every coordinate
\(H\mapsto\lambda_i(H)\) is measurable, then so is

\[
H\longmapsto\sum_i\delta_{\lambda_i(H)}.
\]

The reason is compositional:

1. a measurable real-valued coordinate can be inserted into the measurable
   Dirac map;
2. finitely many measurable measure-valued maps can be added; and
3. multiplication by the fixed inverse-dimension scalar is measurable.

The target <code>Measure ℝ</code> uses Mathlib's Giry measurable structure,
generated by evaluating a measure on measurable sets
([Giry](#ref-perturb-giry);
[Mathlib contributors](#ref-perturb-mathlib-giry)). Mathlib applies this
measurable-space construction to all measures, not only probability measures.
RMT-10B supplies the missing coordinate premise and exposes unconditional
theorems:

~~~lean
theorem measurable_spectralCountingMeasure :
    Measurable (@spectralCountingMeasure n)

theorem measurable_empiricalSpectralMeasure :
    Measurable (@empiricalSpectralMeasure n)

theorem measurable_empiricalSpectralProbability (n : ℕ) :
    Measurable (empiricalSpectralProbability n)
~~~

The second map returns the zero measure at dimension zero. The third has source
<code>HermitianEuclidean (n + 1)</code> and returns a bundled
<code>ProbabilityMeasure ℝ</code>, so positive dimension is encoded in the
type.

This measurable result is not a continuity theorem for empirical measures in a
weak, Wasserstein, or total-variation topology. The module uses the Giry
measurable space and proves exactly the measurable statements displayed above.

## Camp seven: the ambient observable and the GUE bridge

The intrinsic empirical measure accepts only a value already certified
Hermitian. The ambient GUE matrix law lives on all complex matrices. RMT-10A
connected the two with
<code>matrixToHermitianOrZero</code>:

\[
A\longmapsto
\begin{cases}
\text{the intrinsic value represented by }A, & A\text{ Hermitian},\\
0, & A\text{ otherwise}.
\end{cases}
\]

Composing with the empirical spectral measure gives
<code>ambientEmpiricalSpectralMeasure n</code>. The fallback is an extension
policy, not a spectral calculation for a non-Hermitian matrix. RMT-10B now
proves unconditionally:

~~~lean
theorem measurable_ambientEmpiricalSpectralMeasure (n : ℕ) :
    Measurable (ambientEmpiricalSpectralMeasure n)
~~~

The earlier GUE geometry established

\[
\operatorname{GUE.matrixLaw}_n
= (\operatorname{hermitianToMatrix})_*
\operatorname{GUE.intrinsicLaw}_n.
\]

On an intrinsic Hermitian input, the ambient totalizer followed by the
empirical measure equals the intrinsic empirical measure. Measurability now
allows the pushforwards to compose honestly, giving:

~~~lean
theorem map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw
    (n : ℕ) :
    (GUE.matrixLaw n).map (ambientEmpiricalSpectralMeasure n) =
      (GUE.intrinsicLaw n).map empiricalSpectralMeasure
~~~

In commuting-square form:

\[
\begin{array}{ccc}
\mathcal H_n & \xrightarrow{\operatorname{hermitianToMatrix}}
  & \mathbb C^{n\times n}\\
\downarrow L & & \downarrow L_{\mathrm{ambient}}\\
\operatorname{Measure}(\mathbb R) & = &
  \operatorname{Measure}(\mathbb R).
\end{array}
\]

The intrinsic law starts at the upper left. The ambient matrix law is its
pushforward across the top. The new theorem says that pushing down either side
produces the same measure on the space of measures.

This is an unconditional equality of two existing pushforwards. The module
does not yet introduce a dedicated name for the finite-GUE empirical spectral
law, prove a new density for it, or compute its normalized moments. Those are
separate next-layer tasks.

## Physics camp: energy levels under a Hamiltonian perturbation

In finite-dimensional quantum mechanics, a Hermitian Hamiltonian \(H\)
represents an observable whose eigenvalues are possible energy levels. Add a
Hermitian perturbation \(V\), perhaps modeling a weak field, a coupling term,
or an imperfect calibration:

\[
H\longmapsto H+V.
\]

The checked bound gives

\[
\left|\lambda_i(H+V)-\lambda_i(H)\right|
\le\lVert V\rVert_F.
\]

Every ordered energy level stays inside the same deterministic energy budget.
The statement remains valid when levels cross or a degenerate level splits,
because the comparison is between decreasing order statistics rather than
between labeled eigenvectors.

That strength has a matching limitation. Near a degeneracy, an arbitrarily
small perturbation can rotate a selected eigenbasis dramatically. The energy
levels can remain close while the directions representing states change. A
Davis-Kahan theorem controls invariant subspaces using a perturbation size
divided by a spectral-gap scale
([Davis and Kahan](#ref-perturb-davis-kahan)). RMT-10B assumes no gap and proves
no such rotation estimate.

The Frobenius norm is invariant under unitary basis changes, which makes the
budget coordinate independent. It is also sensitive to dimension: many small
entrywise perturbations can accumulate into a comparatively large Frobenius
norm. The operator-norm Weyl theorem can give a sharper energy-level budget,
but that norm comparison is not the theorem formalized here.

### Random matrices enter after the deterministic theorem

For a random Hamiltonian, the perturbation inequality may later become one
ingredient in concentration or approximation arguments. RMT-10B does not take
that probabilistic step. It proves no tail bound for
\(\lVert V\rVert_F\), no rigidity of individual GUE eigenvalues, and no
semicircle law.

Its probability contribution is structural instead: it proves that the map
from a sampled Hermitian matrix to its finite empirical spectral measure is
measurable. This is what allows the sample observable to have a pushforward
law at all. Existence of that law is logically earlier than its density,
moments, concentration, or asymptotics.

## The complete public API

RMT-10B exposes fourteen public theorems. The eigenbasis, support, dimension,
intersection, and quadratic-form helpers stay private.

### Analytic and ordered-coordinate bounds

| Declaration | Exact role |
|---|---|
| <code>norm_mulVec_le_frobenius</code> | Bounds Euclidean matrix-vector multiplication by the Frobenius matrix norm for an arbitrary complex square matrix |
| <code>orderedHermitianEigenvalues_le_add_frobenius</code> | One-sided ordered-coordinate perturbation bound |
| <code>abs_orderedHermitianEigenvalues_sub_le_frobenius</code> | Two-sided absolute ordered-coordinate perturbation bound |

### Lipschitz and continuous spectrum

| Declaration | Exact role |
|---|---|
| <code>lipschitzWith_orderedHermitianEigenvalues_apply</code> | One fixed ordered coordinate is 1-Lipschitz |
| <code>lipschitzWith_orderedHermitianEigenvalues</code> | The whole ordered vector is 1-Lipschitz into the finite function-space sup metric |
| <code>continuous_orderedHermitianEigenvalues_apply</code> | Coordinatewise continuity |
| <code>continuous_orderedHermitianEigenvalues</code> | Whole-vector continuity |

### Measurable spectrum and measure-valued observables

| Declaration | Exact role |
|---|---|
| <code>measurable_orderedHermitianEigenvalues_apply</code> | Ordinary measurability of one ordered coordinate |
| <code>measurable_orderedHermitianEigenvalues</code> | Ordinary measurability of the full vector |
| <code>measurable_spectralCountingMeasure</code> | Unconditional Giry measurability of the finite Dirac sum |
| <code>measurable_empiricalSpectralMeasure</code> | Unconditional Giry measurability of the zero-aware empirical measure |
| <code>measurable_empiricalSpectralProbability</code> | Measurability of the positive-dimensional probability-measure wrapper |
| <code>measurable_ambientEmpiricalSpectralMeasure</code> | Measurability of the ambient Hermitian-or-zero spectral observable |
| <code>map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw</code> | Unconditional equality of the ambient and intrinsic GUE empirical-spectral pushforwards |

The final theorem removes the measurability argument from the conditional
RMT-10A theorem
<code>map_matrixLaw_ambientEmpiricalSpectralMeasure_eq_map_intrinsicLaw_of_measurable_eigenvalues</code>.
The conditional theorem remains valuable as the compositional bridge; RMT-10B
supplies its premise.

## Private proof architecture

The private declarations fall into five groups:

| Group | Job |
|---|---|
| Ordered eigenbasis | Reindex Mathlib's orthonormal eigenbasis and prove the coordinate action of matrix-vector multiplication |
| Weighted quadratic form | Express the real quadratic form as ordered eigenvalues weighted by squared basis coordinates |
| Spectral subspaces | Define top and bottom spans, compute their dimensions, and prove coordinates outside each interval vanish |
| Intersection witness | Use finite rank to prove the top and bottom subspaces intersect nontrivially |
| Norm bridge | Align flattened and matrix Frobenius norms, then control the difference of quadratic forms |

Keeping these private prevents a proof-specific choice of eigenbasis from
becoming a long-term public dependency. The public interface depends only on
the canonical ordered eigenvalue vector, the intrinsic Frobenius geometry, and
standard topological and measurable predicates.

## Common wrong turns

### Calling the whole-vector theorem Hoffman-Wielandt

The theorem
<code>lipschitzWith_orderedHermitianEigenvalues</code> targets a finite
function space with its sup metric. Hoffman-Wielandt controls a full-spectrum
Euclidean matching cost. Do not substitute one statement for the other.

### Claiming the operator-norm Weyl theorem was formalized

The checked source norm is Frobenius. The classical operator-norm result is
sharper because
\(\lVert M\rVert_{\mathrm{op}}\le\lVert M\rVert_F\), but RMT-10B does not
define or prove that sharper interface.

### Treating eigenvalue continuity as eigenvector continuity

Repeated eigenvalues make an individual eigenbasis noncanonical. The ordered
eigenvalue vector can be globally Lipschitz while a chosen eigenvector branch
fails to be continuous. No eigenvector or spectral-projector conclusion is in
the module.

### Forgetting the target measurable structure

The measure-valued maps are measurable for Mathlib's Giry structure. The
module does not put a Wasserstein metric on measures or prove weak continuity.

### Reading an ambient fallback as non-Hermitian spectral theory

On a non-Hermitian ambient matrix,
<code>matrixToHermitianOrZero</code> returns zero in the intrinsic Hermitian
space. It does not compute complex eigenvalues of the original matrix.

### Turning deterministic stability into concentration

The inequality holds pointwise for every pair of Hermitian matrices. It gives
no probability for how large a random perturbation is and no tail estimate for
an eigenvalue.

### Inferring differentiability

A 1-Lipschitz map is continuous and measurable. It need not be differentiable
where ordered eigenvalues collide. RMT-10B proves no analytic branch, gradient,
or response coefficient.

### Inferring asymptotics

Every theorem is finite dimensional and exact. No parameter tends to infinity.
There is no semicircle law, universality statement, unfolding, local spacing
law, edge scaling, or spectral form factor.

## Nearby perturbation theorems, kept separate

| Theorem family | Typical input | Typical conclusion | Status here |
|---|---|---|---|
| Weyl ordered-eigenvalue perturbation | Two Hermitian matrices | Each ordered eigenvalue moves by at most a matrix-norm budget | Frobenius version checked |
| Hoffman-Wielandt | Two normal matrices | A permutation matches spectra with an \(\ell^2\) cost bounded by Frobenius distance | Not checked |
| Davis-Kahan | Perturbed invariant subspaces plus a spectral gap | Gap-dependent angle or projector bound | Not checked |
| Rellich-Kato perturbation theory | A parameterized self-adjoint family with regularity assumptions | Local analytic or differentiable eigenvalue and eigenvector branches | Not checked |
| Random-matrix concentration and rigidity | A probability ensemble plus distributional hypotheses | High-probability deviations from deterministic or classical locations | Not checked |

Bhatia's *Matrix Analysis* develops variational principles and spectral
variation in a unified finite-dimensional setting
([Bhatia](#ref-perturb-bhatia)). Kato's standard perturbation text develops the
regular parameter-dependent theory named in the Rellich-Kato row
([Kato](#ref-perturb-kato)). The table is a scope map, not a claim that these
results are interchangeable.

## What has and has not been proved

| Topic | Checked status after RMT-10B |
|---|---|
| Generic complex matrix-vector Frobenius bound | Checked |
| Ordered orthonormal Hermitian eigenbasis for the proof | Constructed privately |
| Weighted quadratic-form expansion | Checked privately |
| Top and bottom spectral subspace dimensions | Checked privately |
| Nonzero intersection witness | Checked privately |
| One-sided ordered eigenvalue bound | Checked |
| Absolute coordinatewise Frobenius bound | Checked |
| Coordinatewise 1-Lipschitz continuity | Checked |
| Whole-vector 1-Lipschitz continuity in finite sup metric | Checked |
| Coordinate and vector Borel measurability | Checked |
| Spectral counting-measure measurability | Checked |
| Zero-aware empirical spectral-measure measurability | Checked |
| Positive-dimensional probability-wrapper measurability | Checked |
| Ambient empirical spectral observable measurability | Checked |
| Ambient/intrinsic GUE empirical-spectral pushforward equality | Checked unconditionally |
| Dedicated named finite-GUE empirical spectral law | Not yet defined |
| First normalized moments of that law | Not yet connected |
| Operator-norm Weyl bound | Not checked |
| Hoffman-Wielandt \(\ell^2\) spectrum bound | Not checked |
| Eigenvector or invariant-subspace perturbation | Not checked |
| Spectral gap, simplicity, or differentiability | Not checked |
| Weak or Wasserstein continuity of empirical measures | Not checked |
| Joint eigenvalue density | Not checked |
| Concentration, rigidity, or extreme-value law | Not checked |
| Semicircle law or any large-dimension convergence | Not checked |

## Exercises from trailhead to summit

### Trailhead

1. For diagonal Hermitian matrices with decreasing diagonals \(a\) and \(b\),
   prove \(|a_i-b_i|\le\lVert a-b\rVert_2\). Identify the matrix Frobenius
   norm in this special case.
2. Let \(A=0\) and \(B\) have diagonal entries
   \(\varepsilon,-\varepsilon\). Check the coordinate bound and explain why an
   eigenbasis of \(A\) is noncanonical.
3. Prove that \(\lVert Mx\rVert_2\le\lVert M\rVert_F\lVert x\rVert_2\) by
   expanding coordinates and applying Cauchy-Schwarz to each row. Compare that
   route with the single-column matrix proof used in Lean.
4. Explain why sorting both spectra is a matching rule. What goes wrong if one
   side is arbitrarily reindexed?

### Mid-mountain

5. Using the weighted quadratic-form expansion, prove the lower bound on
   \(T_A(i)\) and the upper bound on \(S_B(i)\).
6. Prove the dimension formula
   \(\dim(U\cap V)\ge\dim U+\dim V-n\) in a finite vector space. Apply it to
   the two spectral subspaces.
7. Starting from a nonzero intersection vector, derive the one-sided estimate
   without normalizing the vector. Identify exactly where its nonzeroness is
   used.
8. Swap the matrices in the one-sided estimate and derive the absolute value
   theorem.
9. Explain why the same proof does not choose a common eigenvector of \(A\) and
   \(B\).

### Summit

10. Translate the absolute coordinate theorem into the definition of
    <code>LipschitzWith 1</code>.
11. Explain how <code>dist_pi_le_iff</code> turns all coordinate estimates into
    the whole-vector theorem. Why is this a sup-metric statement?
12. Build the measurable spectral counting map from measurable eigenvalue
    coordinates, measurable Dirac embedding, and finite addition.
13. Draw the ambient/intrinsic GUE pushforward square and derive the equality
    using composition of measurable maps.
14. Design the next named finite-GUE empirical spectral law. State its
    zero-dimensional boundary without falsely calling the zero measure a
    probability measure.
15. State a Davis-Kahan-style question that would require a gap. Explain why
    no theorem in RMT-10B answers it.
16. State a Hoffman-Wielandt \(\ell^2\) conclusion and identify the target norm
    missing from the current API.

## Reproduce the checked slice

From the repository root, load the pinned Lean toolchain and compile the module
with warnings treated as errors:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Random/RandomMatrices/HermitianSpectrumContinuity.lean
~~~

Build the targeted module and its dependencies:

~~~sh
lake build \
  NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity
~~~

Return to the repository root and build the complete draft teaching site:

~~~sh
cd ..
make site-check
~~~

The repository-wide milestone gate is <code>make check</code>. A green
technical build does not change the editorial state: this page remains a draft
until the required human mathematical and publication reviews are complete.

## Where to continue

The {{< refterm "weyl-eigenvalue-bound" "Weyl eigenvalue bound" >}} entry is
the compact perturbation reference. The
{{< refterm "empirical-spectral-measure" "empirical spectral measure" >}}
entry explains the measure-valued target, while
{{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius geometry" >}}
explains the source norm and intrinsic matrix carrier.

[Finite Hermitian Spectra and Empirical Measures]({{< relref "/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures" >}})
constructs every algebraic and conditional interface that this chapter
discharges.
[Intrinsic Hermitian Gaussian Symmetry and Matrix-Law Support]({{< relref "/knowledge-base/deep-dives/intrinsic-hermitian-gaussian-symmetry-and-matrix-law-support" >}})
builds the intrinsic carrier and its measurable ambient inclusion.
[From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance]({{< relref "/knowledge-base/deep-dives/normalized-hermitian-coordinates-to-gue-invariance" >}})
proves the intrinsic-to-ambient GUE law identity consumed by the final
pushforward theorem.

The next spectral-law milestone can now name the finite-GUE empirical spectral
law, prove its exact dimension-zero behavior, and connect its first two
normalized moments to the already checked finite trace expectations. It still
must not claim a density, semicircle law, concentration estimate, or
large-dimension convergence without additional formal layers.

## References

<a id="ref-perturb-bhatia"></a>**Rajendra Bhatia.**
[Matrix Analysis](https://doi.org/10.1007/978-1-4612-0653-8), Graduate Texts in
Mathematics 169, Springer, 1997. The chapters on variational principles and
spectral variation supply standard finite-dimensional context for the min-max
and ordered-eigenvalue perturbation arguments. RMT-10B proves its displayed
Frobenius theorem directly.

<a id="ref-perturb-hoffman-wielandt"></a>**Alan J. Hoffman and Helmut W. Wielandt.**
[The variation of the spectrum of a normal matrix](https://doi.org/10.1215/S0012-7094-53-02004-3),
*Duke Mathematical Journal* 20 (1953), 37-39. This primary source proves the
normal-matrix full-spectrum matching inequality. It is cited to mark the
boundary between its \(\ell^2\) conclusion and the project's finite sup-metric
whole-vector theorem.

<a id="ref-perturb-davis-kahan"></a>**Chandler Davis and W. M. Kahan.**
[The Rotation of Eigenvectors by a Perturbation. III](https://doi.org/10.1137/0707001),
*SIAM Journal on Numerical Analysis* 7 (1970), 1-46. This primary source
studies gap-dependent perturbation of invariant subspaces. RMT-10B proves no
eigenvector, angle, or spectral-projector bound.

<a id="ref-perturb-kato"></a>**Tosio Kato.**
[Perturbation Theory for Linear Operators](https://doi.org/10.1007/978-3-642-66282-9),
second edition, Classics in Mathematics, Springer, 1995. This standard
monograph develops finite-dimensional, analytic, and asymptotic perturbation
theory. It is cited to distinguish those regularity conclusions from the
global Lipschitz theorem checked here.

<a id="ref-perturb-giry"></a>**Michèle Giry.**
[A categorical approach to probability theory](https://doi.org/10.1007/BFb0092872),
in *Categorical Aspects of Topology and Analysis*, Lecture Notes in
Mathematics 915, Springer, 1982, 68-85. This is the original source for the
measure-space construction that motivates the Giry terminology. The checked
implementation details come from Mathlib's official documentation below.

<a id="ref-perturb-mathlib-spectrum"></a>**Mathlib contributors.**
[Spectral theory of Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Spectrum.html),
Mathlib 4 documentation. This official page defines the ordered real
eigenvalues and orthonormal eigenbasis reindexed by the project.

<a id="ref-perturb-mathlib-normed"></a>**Mathlib contributors.**
[Matrices as a normed space](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Normed.html),
Mathlib 4 documentation. This official page distinguishes the Frobenius,
elementwise, and operator norm scopes and supplies the matrix-norm
infrastructure used by the matrix-vector proof.

<a id="ref-perturb-mathlib-lipschitz"></a>**Mathlib contributors.**
[Lipschitz continuous functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Topology/MetricSpace/Lipschitz.html),
Mathlib 4 documentation. This official page defines
<code>LipschitzWith</code> through distance inequalities and proves the
continuity consequences consumed by RMT-10B.

<a id="ref-perturb-mathlib-giry"></a>**Mathlib contributors.**
[The Giry measurable structure on measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/GiryMonad.html),
Mathlib 4 documentation. This official module equips the type of all measures
with its evaluation-generated measurable structure and provides the
measure-valued measurability infrastructure used by the spectral observables.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
