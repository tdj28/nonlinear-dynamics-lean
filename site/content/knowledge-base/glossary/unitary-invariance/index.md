---
title: "Unitary invariance"
slug: "unitary-invariance"
summary: "A matrix law is unitarily invariant when conjugating every matrix by any fixed unitary matrix leaves the law unchanged."
draft: true
pro_reviewed: false
toc: true
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
prose, equations, examples, references, and Lean interpretation is still
pending. The page must remain a draft until that review occurs.
{{< /panel >}}

**Unitary invariance** is a symmetry of a measure on matrix space. When that
measure is a probability law, it says that a deterministic unitary change of
basis does not change how probability is distributed over matrices.

Let \(I\) be the identity matrix. A complex square matrix \(U\) is
**unitary** when

\[
UU^*=U^*U=I,
\]

where \(U^*\) is the
{{< refterm "conjugate-transpose" "conjugate transpose" >}}. For fixed \(U\),
define unitary conjugation by

\[
C_U(H)=UHU^*.
\]

Let \(\nu\) be a measure on the ambient measurable space of
\(n\times n\) complex matrices. In random-matrix applications, \(\nu\) is
usually a probability law supported on the Hermitian matrices. The measure is
**unitarily invariant** when

\[
(C_U)_*\nu=\nu
\qquad\text{for every deterministic unitary }U.
\]

The symbol \((C_U)_*\nu\) denotes a
{{< refterm "pushforward-measure" "pushforward measure" >}}. Equivalently, for
every measurable set \(B\) in the ambient matrix space,

\[
\nu(B)=\nu\bigl(C_U^{-1}(B)\bigr).
\]

If \(H\) is a random Hermitian matrix with
{{< refterm "probability-law" "probability law" >}} \(\nu\), the same
condition can be written

\[
UHU^*\mathrel{\overset{d}{=}}H
\qquad\text{for every deterministic unitary }U.
\]

The symbol \(\mathrel{\overset{d}{=}}\) means equality in distribution. It
does not mean \(UHU^*=H\) for each outcome.

## What changes and what stays fixed

Unitary conjugation changes the coordinate representation of a matrix while
preserving its spectrum. For a Hermitian matrix, it rotates an orthonormal
eigenbasis but keeps the real eigenvalues, including their multiplicities.

| Level | Under \(H\mapsto UHU^*\) | What invariance asks |
|---|---|---|
| Individual entries | Usually change | Nothing entrywise must remain fixed |
| Eigenvectors | Rotate by \(U\) | Their coordinate orientation is not privileged by the law |
| Eigenvalues | Stay the same | Spectral observables are unchanged sample by sample |
| Probability law | Is pushed forward | The transported law must equal the original law |

The last row is the definition. The other rows explain why the definition is
geometrically natural, but none of them can replace equality of laws.

## A two-by-two counterexample: Hermitian is not invariant

Consider the deterministic Hermitian matrix

\[
D=
\begin{bmatrix}
1&0\\
0&-1
\end{bmatrix}
\]

and the unitary coordinate-swap matrix

\[
S=
\begin{bmatrix}
0&1\\
1&0
\end{bmatrix}.
\]

Because \(S^*=S\), direct multiplication gives

\[
SDS^*=
\begin{bmatrix}
-1&0\\
0&1
\end{bmatrix}
=-D.
\]

Let the random matrix be constantly equal to \(D\). Its law is the point mass
\(\delta_D\), meaning the probability measure concentrated entirely at
\(D\). After conjugation by \(S\), its law is \(\delta_{-D}\). The two laws
differ because \(D\ne-D\), so \(\delta_D\) is not unitarily invariant.

Yet all of the following are true:

- \(D\) is Hermitian;
- \(SDS^*\) is Hermitian;
- \(D\) and \(SDS^*\) have the same eigenvalues; and
- conjugation preserved Hermiticity perfectly.

This example isolates the key boundary. Algebraic preservation of the set of
Hermitian matrices does not establish a symmetry of a probability law.

## A simple invariant law

For any real scalar \(c\), let \(\delta_{cI}\) be the point mass at \(cI\).
Since

\[
U(cI)U^*=cUU^*=cI
\]

for every unitary \(U\), the law \(\delta_{cI}\) is unitarily invariant. This
example is degenerate, but exact. It shows that the definition is about a law
and an action, not about Gaussianity.

A richer construction starts with a fixed Hermitian matrix \(D\) and
randomizes its eigenbasis using a suitably invariant probability measure on
the unitary group. The matrices \(UDU^*\) then range over the unitary orbit of
\(D\). Making that statement rigorous requires a measurable group action and
an invariant probability measure on the compact unitary group. Those
ingredients are not part of the project's present formalization.

## Spectral observables do not test the whole law

For each positive integer \(k\),

\[
\operatorname{tr}\bigl((UHU^*)^k\bigr)
=\operatorname{tr}(H^k).
\]

This is a pointwise identity for unitary conjugation. Therefore the
{{< refterm "trace-power" "trace-power" >}} observable has the same value
before and after conjugation even when the law of \(H\) is not unitarily
invariant. The counterexample \(\delta_D\) above already demonstrates this:
\(D\) and \(SDS^*=-D\) have identical trace powers of every order but different
point-mass laws.

Consequently, checking one conjugation-invariant observable, or even many
spectral observables, is not by itself a proof that the entire matrix law is
unitarily invariant. The definition quantifies over the full law.

## Relation to the Gaussian unitary ensemble

In a common class of finite-dimensional conventions, the **Gaussian unitary
ensemble (GUE)** is a Gaussian probability law on Hermitian matrices with
density

\[
p(H)=Z^{-1}\exp\bigl(-c\,\operatorname{tr}(H^2)\bigr).
\]

Here \(c>0\) sets the scale and \(Z\) is the normalizing constant for the
chosen reference volume measure on Hermitian matrix space. Because

\[
\operatorname{tr}\bigl((UHU^*)^2\bigr)=\operatorname{tr}(H^2),
\]

the density has the expected conjugation symmetry. A complete proof of
invariance must also account for the reference volume measure under the
unitary action. Different normalization conventions change variances and
spectral scales, even though they preserve the same symmetry principle.

{{< panel "warning" >}}
**Current project boundary.** The project now defines a finite GUE matrix law
from Wigner-scaled independent Gaussian coordinates and measurable Hermitian
assembly. It has **not** proved that this law is invariant under unitary
conjugation. The earlier law layer defines the invariance predicate and proves
it only for the zero measure and the point mass at the zero matrix. Those
remain interface checks, not the nontrivial GUE symmetry theorem.
{{< /panel >}}

## Lean-facing interpretation

For a finite index type \(\iota\), Mathlib supplies the bundled matrix unitary
group <code>Matrix.unitaryGroup ι ℂ</code>. The checked project definition is

~~~lean
def RandomMatrix.IsUnitaryConjugationInvariant
    [Fintype ι] [DecidableEq ι]
    (ν : Measure (Matrix ι ι ℂ)) : Prop :=
  ∀ U : Matrix.unitaryGroup ι ℂ,
    Measure.map
      (RandomMatrix.congruence (U : Matrix ι ι ℂ)) ν = ν
~~~

The underlying <code>RandomMatrix.congruence A</code> is exactly the map
\(H\mapsto AHA^*\), and <code>measurable_congruence</code> proves it measurable
for every fixed finite matrix \(A\). The theorem
<code>HermitianRandomMatrix.law_conjugateBy</code> then identifies the law of
\(AXA^*\) with the congruence pushforward of the law of \(X\).

For bundled Hermitian random matrices, the project defines
<code>HasUnitaryConjugationInvariantLaw X μ</code>. The checked theorem
<code>hasUnitaryConjugationInvariantLaw_iff</code> converts it into the
sample-map presentation

~~~text
for every U : Matrix.unitaryGroup ι ℂ,
law (X.conjugateBy (U : Matrix ι ι ℂ)) μ = law X μ.
~~~

The API deliberately accepts an arbitrary measure. The law module proves the
predicate for the zero measure, which is not a probability law, and for the
Dirac probability law at the zero matrix. It does not claim that an arbitrary
<code>HermitianRandomMatrix</code> has the property. The later RMT-06 module
constructs the finite GUE coordinate and matrix laws but does not close this
invariance obligation.

## Distinctions and failure modes

| Statement | What it actually establishes |
|---|---|
| \(H^*=H\) | One matrix is Hermitian |
| \(H^*=H\Rightarrow(AHA^*)^*=AHA^*\) | Congruence preserves Hermiticity for every \(A\) |
| \(UHU^*=H\) | One matrix is fixed by one particular conjugation |
| \((C_U)_*\nu=\nu\) for one \(U\) | The law has one specified symmetry |
| \((C_U)_*\nu=\nu\) for every unitary \(U\) | Full unitary invariance |

Other common overreads include:

- **Subgroup versus full group.** Invariance under coordinate permutations or
  diagonal phase matrices alone is weaker than invariance under every unitary
  matrix.
- **Random versus deterministic conjugator.** The standard definition
  quantifies over every fixed deterministic unitary \(U\). A statement about
  one independently sampled random unitary can be weaker.
- **Same spectrum versus same law.** Conjugate matrices share a spectrum, but a
  law can still prefer one eigenbasis over another.
- **Support versus symmetry.** A law supported on Hermitian matrices need not
  distribute mass symmetrically along unitary orbits.
- **Gaussianity versus invariance.** Some invariant laws are not Gaussian, and
  some Gaussian laws on matrix coordinates are not unitarily invariant.

## Where to continue

Review {{< refterm "hermitian-matrix" "Hermitian matrix" >}} for the structural
constraint that unitary conjugation preserves. Review
{{< refterm "probability-law" "probability law" >}} and
{{< refterm "pushforward-measure" "pushforward measure" >}} for the precise
level at which invariance is stated. The chapter
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}})
constructs the checked finite law and marks invariance as the next separate
symmetry theorem. [Random Matrices: From Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}})
provides the broader probability-to-spectrum path.

## References

**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems. I](https://doi.org/10.1063/1.1703773),
*Journal of Mathematical Physics* 3, 140-156, 1962. This original paper
introduces the orthogonal, unitary, and symplectic ensemble framing in its
physical and group-theoretic setting.

**Greg W. Anderson, Alice Guionnet, and Ofer Zeitouni.**
[An Introduction to Random Matrices](https://doi.org/10.1017/CBO9780511801334),
Cambridge University Press, 2010. This gives a systematic treatment of
Gaussian ensembles, invariant matrix laws, and their eigenvalue distributions.

**Mathlib contributors.**
[The matrix unitary group](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/UnitaryGroup.html),
Mathlib 4 documentation. This official implementation reference documents
<code>Matrix.unitaryGroup</code> and the bundled algebraic identities available
to a future formalization.

**Mathlib contributors.**
[Pushforward of a measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
Mathlib 4 documentation. This is the official source for the
<code>Measure.map</code> operation needed to state law invariance in Lean.
