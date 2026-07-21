---
title: "Weyl eigenvalue bound"
slug: "weyl-eigenvalue-bound"
summary: "A Weyl eigenvalue bound says that a small Hermitian matrix perturbation can move no ordered eigenvalue coordinate by more than a controlled matrix-norm budget."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.HermitianSpectrumContinuity"
og_image: "weyl-eigenvalue-bound-card.png"
og_image_alt: "A perturbation between two Hermitian matrices creates one Frobenius-size budget, and every corresponding slot in their decreasingly ordered spectra stays within that same budget."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page must remain a draft until that review is complete.
{{< /panel >}}

A **Weyl eigenvalue bound** controls how far the ordered eigenvalues of a
Hermitian matrix can move when the matrix is perturbed. Write the real
eigenvalues of two \(n\)-by-\(n\) Hermitian matrices in decreasing order:

\[
\lambda_0(A)\ge\lambda_1(A)\ge\cdots\ge\lambda_{n-1}(A),
\qquad
\lambda_0(B)\ge\lambda_1(B)\ge\cdots\ge\lambda_{n-1}(B).
\]

The classical operator-norm form says

\[
\left|\lambda_i(A)-\lambda_i(B)\right|
\le \lVert A-B\rVert_{\mathrm{op}}
\]

for every index \(i\). The checked project theorem proves the following
Frobenius-norm version directly:

\[
\boxed{
\left|\lambda_i(A)-\lambda_i(B)\right|
\le \lVert A-B\rVert_F .
}
\]

Here \(\lVert M\rVert_F^2=\sum_{j,k}|M_{jk}|^2\). Since the operator norm is at
most the Frobenius norm, the checked statement is compatible with the sharper
classical form, but it does not formalize that operator-norm theorem.

{{< reference-figure
  src="frobenius-budget-to-level-shifts.svg"
  alt="Two Hermitian matrices are compared by one Frobenius perturbation budget. Their eigenvalues are matched by decreasing index, and every ordered level shift remains inside that common budget."
  caption="**Finding:** ordering supplies the correspondence. Once both real spectra are sorted in the same direction, one matrix-level Frobenius budget controls every coordinate pair. The plate does not claim a Euclidean bound on the whole eigenvalue vector, any control of eigenvectors, or any random-matrix concentration result."
>}}

## Why ordering is essential

An unordered spectrum is a multiset. A perturbation theorem then needs a
matching rule before the phrase “the same eigenvalue” has meaning. Hermitian
matrices provide a canonical rule: sort all eigenvalues decreasingly and
compare equal indices.

This rule remains meaningful at repeated eigenvalues. If a double eigenvalue
splits under perturbation, the two new values simply occupy the corresponding
adjacent slots. No continuously chosen eigenvector is needed. The project uses
Mathlib's antitone <code>eigenvalues₀</code> enumeration, transported to
<code>Fin n</code> by an order-preserving equivalence
([Mathlib contributors](#ref-weyl-mathlib-spectrum)).

## The proof mechanism in one paragraph

Fix an index \(i\). The top spectral subspace of \(A\), spanned by eigenvectors
with indices at most \(i\), has complex dimension \(i+1\). The bottom spectral
subspace of \(B\), spanned by eigenvectors with indices at least \(i\), has
dimension \(n-i\). Those dimensions add to \(n+1\), so the two subspaces cannot
be disjoint inside an \(n\)-dimensional space. A nonzero vector \(x\) in their
intersection satisfies

\[
\lambda_i(A)\lVert x\rVert^2
\le \operatorname{Re}\langle x,Ax\rangle,
\qquad
\operatorname{Re}\langle x,Bx\rangle
\le \lambda_i(B)\lVert x\rVert^2.
\]

The matrix-vector estimate

\[
\lVert (A-B)x\rVert
\le \lVert A-B\rVert_F\lVert x\rVert
\]

then bounds the difference of the two quadratic forms. Cancelling the positive
quantity \(\lVert x\rVert^2\) gives the one-sided inequality

\[
\lambda_i(A)\le\lambda_i(B)+\lVert A-B\rVert_F.
\]

Swapping \(A\) and \(B\) supplies the other side and therefore the absolute
value bound. This is a finite-dimensional min-max witness argument of the kind
developed in standard matrix analysis
([Bhatia](#ref-weyl-bhatia)).

## A degeneracy example

Take

\[
A=
\begin{bmatrix}
0&0\\
0&0
\end{bmatrix},
\qquad
B=
\begin{bmatrix}
\varepsilon&0\\
0&-\varepsilon
\end{bmatrix}.
\]

The ordered spectrum moves from \((0,0)\) to
\((|\varepsilon|,-|\varepsilon|)\). Each coordinate moves by
\(|\varepsilon|\), while

\[
\lVert A-B\rVert_F=\sqrt2\,|\varepsilon|.
\]

The bound holds even though every direction is an eigenvector of \(A\), so
there is no canonical way to choose an eigenbasis of \(A\) that varies with
\(B\). Eigenvalue stability survives degeneracy; eigenvector stability is a
different question.

## From a bound to measurability

The coordinate estimate says that each function

\[
A\longmapsto\lambda_i(A)
\]

is 1-Lipschitz from the intrinsic Hermitian Frobenius space to
\(\mathbb R\). A Lipschitz map is continuous, and a continuous map between the
Borel spaces used here is measurable. Mathlib packages exactly this chain in
<code>LipschitzWith</code>, <code>Continuous</code>, and
<code>Measurable</code>
([Mathlib contributors](#ref-weyl-mathlib-lipschitz)).

The project also packages the whole decreasing spectrum as 1-Lipschitz into
the finite function space with its sup-style metric. This means every
coordinate is controlled simultaneously by the same Frobenius budget. It is
not an \(\ell^2\) estimate on the vector of eigenvalue differences.

Once coordinatewise measurability is available, the earlier conditional
Giry-measurability results become unconditional. In particular, the spectral
counting measure, the {{< refterm "empirical-spectral-measure" "empirical spectral measure" >}},
its positive-dimensional probability wrapper, and the ambient
Hermitian-or-zero observable are measurable maps into their respective target
spaces.

## Nearby theorems that this term does not name

| Nearby result | What it controls | Why it is different here |
|---|---|---|
| Hoffman-Wielandt | An \(\ell^2\) matching cost for the full spectra of normal matrices, bounded by Frobenius distance | The checked whole-vector theorem uses the finite sup metric, not the Euclidean eigenvalue norm ([Hoffman and Wielandt](#ref-weyl-hoffman-wielandt)) |
| Davis-Kahan | Rotation of an invariant subspace or eigenspace under a perturbation, with a spectral-gap denominator | RMT-10B proves no eigenvector or spectral-projector bound ([Davis and Kahan](#ref-weyl-davis-kahan)) |
| Differentiable perturbation theory | Derivatives or analytic branches of eigenvalues and eigenvectors under stronger hypotheses | Lipschitz continuity alone supplies no derivative or smooth eigenbasis |
| Random-matrix concentration | Tail probabilities for spectral deviations under a probability law | The Weyl bound is deterministic and contains no probabilistic estimate |

The theorem also says nothing about a spectral density, a semicircle law,
universality, eigenvalue rigidity, local spacing, or a large-dimension limit.

## Lean interface

The central checked declarations are:

~~~lean
theorem abs_orderedHermitianEigenvalues_sub_le_frobenius
    (A B : HermitianEuclidean n) (i : Fin n) :
    |orderedHermitianEigenvalues A i -
      orderedHermitianEigenvalues B i| ≤ ‖A - B‖

theorem lipschitzWith_orderedHermitianEigenvalues_apply (i : Fin n) :
    LipschitzWith 1 (fun H : HermitianEuclidean n =>
      orderedHermitianEigenvalues H i)
~~~

The norm on <code>HermitianEuclidean n</code> is the intrinsic Frobenius norm.
The numeral <code>1</code> records a valid Lipschitz constant; the theorem does
not assert that no smaller constant could work on a restricted domain.

## Where to continue

[Hermitian Spectral Perturbation, Continuity, and Measurability]({{< relref "/knowledge-base/deep-dives/hermitian-spectral-perturbation-continuity-and-measurability" >}})
develops the complete matrix-vector, eigenbasis, subspace-intersection,
quadratic-form, Lipschitz, Giry, and Gaussian unitary ensemble (GUE) law bridge.
[Finite Hermitian Spectra and Empirical Measures]({{< relref "/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures" >}})
constructs the ordered vector and measure-valued observables whose conditional
measurability hypotheses this result discharges. The
{{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius geometry" >}}
entry explains the source norm.

## References

<a id="ref-weyl-bhatia"></a>**Rajendra Bhatia.**
[Matrix Analysis](https://doi.org/10.1007/978-1-4612-0653-8), Graduate Texts in
Mathematics 169, Springer, 1997. The chapters on variational principles and
spectral variation provide the standard finite-dimensional matrix-analysis
context for ordered Hermitian eigenvalue perturbation. The project proves its
Frobenius statement directly rather than importing a book theorem.

<a id="ref-weyl-hoffman-wielandt"></a>**Alan J. Hoffman and Helmut W. Wielandt.**
[The variation of the spectrum of a normal matrix](https://doi.org/10.1215/S0012-7094-53-02004-3),
*Duke Mathematical Journal* 20 (1953), 37-39. This primary source establishes
the full-spectrum Euclidean matching result cited only to distinguish it from
the project's sup-metric whole-vector theorem.

<a id="ref-weyl-davis-kahan"></a>**Chandler Davis and W. M. Kahan.**
[The Rotation of Eigenvectors by a Perturbation. III](https://doi.org/10.1137/0707001),
*SIAM Journal on Numerical Analysis* 7 (1970), 1-46. This primary source
studies perturbation of invariant subspaces and gap-dependent rotation bounds.
RMT-10B does not formalize those conclusions.

<a id="ref-weyl-mathlib-spectrum"></a>**Mathlib contributors.**
[Spectral theory of Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Spectrum.html),
Mathlib 4 documentation. This official page defines the ordered real
Hermitian eigenvalues and eigenvector basis used in the proof.

<a id="ref-weyl-mathlib-lipschitz"></a>**Mathlib contributors.**
[Lipschitz continuous functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Topology/MetricSpace/Lipschitz.html),
Mathlib 4 documentation. This official page defines
<code>LipschitzWith</code> and supplies the continuity consequences used by
the project.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
