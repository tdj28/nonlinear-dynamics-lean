---
title: "Unitary invariance"
slug: "unitary-invariance"
summary: "A matrix law is unitarily invariant when every fixed unitary change of basis leaves the entire probability distribution unchanged."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.HermitianSpectrum"
og_image: "unitary-invariance-card.png"
og_image_alt: "A unitary basis swap changes a two-by-two matrix but preserves its spectrum, while a balanced law remains invariant and a point mass does not."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working draft. Human review
of the mathematics, Lean examples, sources, figure, and accessibility remains
pending. Publication does not imply that review is complete.
{{< /panel >}}

A **unitary change of basis** can alter every visible matrix entry while
leaving the underlying Hermitian operator's eigenvalues unchanged. **Unitary
invariance of a law** asks for more: after making that change of basis, the
entire probability distribution on matrices must be the same as before.

The distinction is easiest to see in one exact two-by-two calculation.

## Start with one matrix and swap the basis vectors

Consider the real symmetric, hence complex
{{< refterm "hermitian-matrix" "Hermitian" >}}, matrix

\[
H=
\begin{bmatrix}
2 & 1 \\
1 & 0
\end{bmatrix}
\]

and the coordinate-swap matrix

\[
S=
\begin{bmatrix}
0 & 1 \\
1 & 0
\end{bmatrix}.
\]

The conjugate transpose \(S^*\) equals \(S\), and

\[
SS^*=S^2=I.
\]

Thus \(S\) is unitary. Multiplying in two visible steps gives

\[
\begin{aligned}
SHS^*
&=
\begin{bmatrix}
0 & 1 \\
1 & 0
\end{bmatrix}
\begin{bmatrix}
2 & 1 \\
1 & 0
\end{bmatrix}
\begin{bmatrix}
0 & 1 \\
1 & 0
\end{bmatrix} \\
&=
\begin{bmatrix}
1 & 0 \\
2 & 1
\end{bmatrix}
\begin{bmatrix}
0 & 1 \\
1 & 0
\end{bmatrix}
&=
\begin{bmatrix}
0 & 1 \\
1 & 2
\end{bmatrix}
=:H'.
\end{aligned}
\]

The matrix changed: \(H'\ne H\). Nevertheless,

\[
\operatorname{tr}(H)=2=\operatorname{tr}(H'),
\qquad
\det(H)=-1=\det(H').
\]

For a two-by-two matrix, the characteristic polynomial is determined by trace
and determinant:

\[
\chi_H(\lambda)
=\lambda^2-\operatorname{tr}(H)\lambda+\det(H)
=\lambda^2-2\lambda-1
=\chi_{H'}(\lambda).
\]

Both matrices therefore have the same two eigenvalues,

\[
1+\sqrt 2
\qquad\text{and}\qquad
1-\sqrt 2.
\]

This is **deterministic spectral invariance**: for this fixed matrix \(H\) and
fixed unitary \(S\), conjugation changes coordinates but not the spectrum. It
does not say that the matrix itself is fixed.

{{< reference-figure
  wide="true"
  src="unitary-swap-and-law.svg"
  alt="Swapping two basis coordinates changes the example matrix entries but leaves trace two, determinant minus one, and both eigenvalues unchanged. The same swap preserves a balanced two-point law but moves a point mass, while a non-unitary stretch changes the spectral checks."
  caption="**Finding:** the unitary swap sends \(H=\bigl[\begin{smallmatrix}2&1\\1&0\end{smallmatrix}\bigr]\) to the different matrix \(H'=\bigl[\begin{smallmatrix}0&1\\1&2\end{smallmatrix}\bigr]\), yet both have trace \(2\), determinant \(-1\), characteristic polynomial \(\lambda^2-2\lambda-1\), and eigenvalues \(1\pm\sqrt2\). On the same two matrices, the swap exchanges two equal probability masses, so \(\tfrac12\delta_H+\tfrac12\delta_{H'}\) is unchanged under that one conjugation, whereas \(\delta_H\) moves to \(\delta_{H'}\). A non-unitary coordinate stretch sends \(H\) to \(\bigl[\begin{smallmatrix}8&2\\2&0\end{smallmatrix}\bigr]\), changing trace and determinant. The balanced two-point law illustrates one specified symmetry only, not invariance under every unitary matrix."
>}}

## The same action can preserve a law without fixing samples

Let \(C_S\) denote the deterministic map

\[
C_S(M)=SMS^*.
\]

Because \(S^2=I\), the action exchanges the two matrices:

\[
C_S(H)=H',
\qquad
C_S(H')=H.
\]

Now put equal probability on them:

\[
\nu=\frac12\delta_H+\frac12\delta_{H'}.
\]

Here \(\delta_H\) is the point-mass probability measure concentrated at
\(H\). Pushing \(\nu\) through \(C_S\) merely swaps the two equal masses:

\[
\begin{aligned}
(C_S)_*\nu
&=\frac12\delta_{C_S(H)}+\frac12\delta_{C_S(H')} \\
&=\frac12\delta_{H'}+\frac12\delta_H
=\nu.
\end{aligned}
\]

So this law is invariant under conjugation by \(S\), even though neither
sample matrix is fixed by that conjugation.

The nearby false claim is

\[
C_S(H)=H.
\]

It is false. Equality in distribution does not become pointwise equality.
Indeed, the one-point law is not invariant under this swap:

\[
(C_S)_*\delta_H=\delta_{H'}\ne\delta_H.
\]

The displayed equality is the invariance equation for the swap \(S\). It does
not establish full unitary invariance, which quantifies over every unitary
matrix rather than only \(S\) or the two-element subgroup it generates.

## Why unitarity matters for the spectrum

The project defines congruence \(M\mapsto AMA^*\) for every square matrix
\(A\), not only unitary ones. Such congruence preserves Hermiticity, but an
arbitrary \(A\) need not preserve eigenvalues.

For example, stretch the first coordinate by a factor of two:

\[
A=
\begin{bmatrix}
2 & 0 \\
0 & 1
\end{bmatrix}.
\]

This matrix is not unitary because \(AA^*\ne I\). Direct multiplication gives

\[
AHA^* =
\begin{bmatrix}
8 & 2 \\
2 & 0
\end{bmatrix}.
\]

The result is still Hermitian, but

\[
\operatorname{tr}(AHA^*)=8\ne2,
\qquad
\det(AHA^*)=-4\ne-1.
\]

Thus “congruence preserves Hermiticity” is true for arbitrary \(A\), while
“congruence preserves the spectrum” needs the unitary hypothesis.

## From one symmetry to full unitary invariance

Let \(\nu\) be a measure on the space of \(n\times n\) complex matrices. For
each fixed unitary \(U\), define

\[
C_U(H)=UHU^*.
\]

The measure \(\nu\) is **unitarily invariant** when

\[
(C_U)_*\nu=\nu
\qquad
\text{for every deterministic unitary }U.
\]

The symbol \((C_U)_*\nu\) is the
{{< refterm "pushforward-measure" "pushforward measure" >}}. It records how
probability mass moves when every sampled matrix is transformed by \(C_U\).
Equivalently, for every measurable set \(B\) of matrices,

\[
\nu(B)=\nu\bigl(C_U^{-1}(B)\bigr).
\]

The word **deterministic** matters. A unitary \(U\) is chosen and held fixed,
then the definition compares the law before and after applying that same
change of basis to every sample. A statement involving one randomly sampled
unitary is not a replacement for the quantifier over every fixed \(U\).

If a random Hermitian matrix \(X\) has
{{< refterm "probability-law" "probability distribution, or law" >}} \(\nu\),
the same condition is written

\[
UXU^*\mathrel{\overset{d}{=}}X
\qquad
\text{for every deterministic unitary }U.
\]

The symbol \(\mathrel{\overset{d}{=}}\) means equality in distribution. It
does not assert \(UX(\omega)U^*=X(\omega)\) for each outcome \(\omega\).

## Keep the three levels separate

| Level | Exact statement | What it does not say |
|---|---|---|
| Deterministic action | \(H\mapsto UHU^*\) | The entries or matrix must stay fixed |
| Pointwise spectral invariance | \(\lambda^\downarrow(UHU^*)=\lambda^\downarrow(H)\) | The input law is invariant |
| Invariance in distribution | \((C_U)_*\nu=\nu\) for every unitary \(U\) | Each transformed sample equals the original sample |

Here \(\lambda^\downarrow(H)\) is the list of real eigenvalues of a Hermitian
matrix in decreasing order, with multiplicities. Pointwise spectral
invariance holds for every Hermitian \(H\) and unitary \(U\). Law invariance
is an additional property of how probability mass is distributed across
matrices.

## Two fully invariant laws

For any real scalar \(c\), the point mass at \(cI\) is fully unitarily
invariant:

\[
U(cI)U^*=cUU^*=cI
\]

for every unitary \(U\). This exact example is degenerate but useful. It shows
that Gaussianity is not part of the definition.

The finite-dimensional
**Gaussian unitary ensemble (GUE)** gives a nondegenerate example. Under the
project's Wigner scaling, its law is constructed from independent Gaussian
coordinates, identified with a scaled intrinsic Gaussian on Hermitian
Frobenius space, and then proved invariant under every deterministic unitary
conjugation. The checked endpoint is
<code>GUE.matrixLaw_isUnitaryConjugationInvariant</code>.

This proof uses equality of the whole joint law. Matching individual
coordinate marginals would not be enough.

## Spectral observables cannot test the whole law

Every unitary conjugation preserves the ordered eigenvalues and therefore
preserves conjugation-invariant scalar quantities such as

\[
\operatorname{tr}(H^k)
\]

for positive integers \(k\). The project calls these
{{< refterm "trace-power" "trace-power observables" >}}.

But preserved spectral observables do not prove law invariance. The point mass
\(\delta_H\) from the opening example moves to the different point mass
\(\delta_{H'}\), even though \(H\) and \(H'\) have identical eigenvalues and
identical trace powers of every order.

This is a useful diagnostic boundary:

- spectrum preservation is a sample-by-sample algebraic fact;
- unitary invariance is equality of complete measures; and
- checking selected scalar observables can miss a preferred eigenbasis.

## In Lean: the law-level definition

{{< lean-bridge
  human="Every fixed unitary change of basis leaves the whole matrix measure unchanged."
  math="\((C_U)_*\nu=\nu\) for every \(U\in\mathrm U(n)\), where \(C_U(H)=UHU^*\)."
  lean="RandomMatrix.IsUnitaryConjugationInvariant ν"
>}}

- <code>ν</code> is a <code>Measure (Matrix ι ι ℂ)</code>, so the predicate
  concerns a complete measure on matrix space.
- <code>Matrix.unitaryGroup ι ℂ</code> bundles a matrix together with its
  unitary equations.
- <code>∀ U</code> quantifies over every fixed bundled unitary, not over one
  random conjugator.
- <code>RandomMatrix.congruence (U : Matrix ι ι ℂ)</code> is the function
  \(H\mapsto UHU^*\). The parenthesized expression coerces the bundled unitary
  back to its underlying matrix.
- <code>Measure.map</code> is Lean's pushforward operation. Its first argument
  is the measurable transformation and its second is the original measure.
- The final <code>= ν</code> is equality of measures, not equality of
  individual matrices.
{{< /lean-bridge >}}

The exact checked project definition, with its namespace context, is:

~~~lean
namespace NonlinearDynamics.Random
namespace RandomMatrix

def IsUnitaryConjugationInvariant
    [Fintype ι] [DecidableEq ι]
    (ν : Measure (Matrix ι ι ℂ)) : Prop :=
  ∀ U : Matrix.unitaryGroup ι ℂ,
    Measure.map
      (congruence (U : Matrix ι ι ℂ)) ν = ν

end RandomMatrix
end NonlinearDynamics.Random
~~~

The finite index type <code>ι</code> names rows and columns.
<code>Fintype ι</code> says there are finitely many of them, while
<code>DecidableEq ι</code> lets Lean decide when two indices agree.

## In Lean: the pointwise spectral theorem is different

{{< lean-bridge
  human="For one Hermitian matrix, unitary conjugation preserves its complete ordered eigenvalue list."
  math="\(\lambda^\downarrow(UHU^*)=\lambda^\downarrow(H)\)."
  lean="RandomMatrix.orderedHermitianEigenvalues (RandomMatrix.hermitianCongruence U H) = RandomMatrix.orderedHermitianEigenvalues H"
>}}

- <code>H : RandomMatrix.HermitianEuclidean n</code> is one intrinsic
  Hermitian matrix, not a random variable or measure.
- <code>U : Matrix.unitaryGroup (Fin n) ℂ</code> is one fixed unitary matrix.
- <code>hermitianCongruence U H</code> constructs the transformed Hermitian
  matrix.
- <code>orderedHermitianEigenvalues</code> returns a function
  <code>Fin n → ℝ</code>, the decreasing eigenvalue vector with multiplicity.
- Equality here is pointwise equality of two finite eigenvalue vectors. No
  probability law appears.
{{< /lean-bridge >}}

The theorem proving this proposition is
<code>RandomMatrix.orderedHermitianEigenvalues_hermitianCongruence</code>.
The separate GUE theorem proves the law-level predicate. Their different types
make it hard to accidentally treat one as the other.

## Try the arithmetic locally with Lean and Std

The following tiny worksheet encodes only the opening integer calculation. It
uses a four-field record instead of Mathlib's matrix library, so it imports
only <code>Std</code> and stays small enough for an ordinary Mac or Linux
machine.

Save it as <code>UnitarySwapTutorial.lean</code> outside the project's
<code>formalization/</code> directory:

~~~lean
import Std

structure Mat2 where
  a11 : Int
  a12 : Int
  a21 : Int
  a22 : Int
  deriving DecidableEq, Repr

def swapCongruence (M : Mat2) : Mat2 :=
  { a11 := M.a22
    a12 := M.a21
    a21 := M.a12
    a22 := M.a11 }

def stretchCongruence (M : Mat2) : Mat2 :=
  { a11 := 4 * M.a11
    a12 := 2 * M.a12
    a21 := 2 * M.a21
    a22 := M.a22 }

def matTrace (M : Mat2) : Int :=
  M.a11 + M.a22

def matDet (M : Mat2) : Int :=
  M.a11 * M.a22 - M.a12 * M.a21

def H : Mat2 :=
  { a11 := 2, a12 := 1, a21 := 1, a22 := 0 }

def Hswap : Mat2 :=
  { a11 := 0, a12 := 1, a21 := 1, a22 := 2 }

#eval swapCongruence H
#eval (matTrace H, matTrace Hswap, matDet H, matDet Hswap)

example : swapCongruence H = Hswap := by decide
example : H ≠ Hswap := by decide
example : matTrace (swapCongruence H) = matTrace H := by decide
example : matDet (swapCongruence H) = matDet H := by decide
example : matTrace (stretchCongruence H) = 8 := by decide
example : matDet (stretchCongruence H) = -4 := by decide
~~~

Run it with the repository's pinned compiler:

~~~sh
elan run leanprover/lean4:v4.32.0 lean UnitarySwapTutorial.lean
~~~

The two <code>#eval</code> commands print the transformed record and the tuple
<code>(2, 2, -1, -1)</code>. Each <code>example</code> asks Lean's decidable
arithmetic kernel to verify one finite claim. This tutorial does not define
complex matrices, prove that \(S\) is unitary, construct a measure, or establish
the general spectral theorem. Those are Mathlib-backed project obligations.

## Try the exact project interfaces

{{< repo-check >}}
The project-backed worksheet below imports the full Hermitian-spectrum module,
which transitively includes the law and finite-GUE invariance modules. It is a
list of exact declaration checks, not a replacement proof:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.HermitianSpectrum

open NonlinearDynamics.Random

#check RandomMatrix.congruence
#check RandomMatrix.measurable_congruence
#check RandomMatrix.IsUnitaryConjugationInvariant
#check HermitianRandomMatrix.law_conjugateBy
#check HermitianRandomMatrix.hasUnitaryConjugationInvariantLaw_iff
#check RandomMatrix.orderedHermitianEigenvalues_hermitianCongruence
#check GUE.matrixLaw_isUnitaryConjugationInvariant
~~~

The first three names expose the deterministic action, its measurability, and
the measure-level predicate. The next two connect a bundled random Hermitian
matrix to equality of its laws after conjugation. The ordered-eigenvalue
theorem is pointwise. The final theorem is the checked nondegenerate
finite-GUE law invariant under every deterministic unitary.
{{< /repo-check >}}

## Boundaries that prevent common mistakes

| Tempting claim | Correct statement |
|---|---|
| “Unitary conjugation leaves a matrix unchanged.” | It generally changes entries and eigenvectors; it preserves the spectrum. |
| “Same spectrum means same matrix law.” | Distinct point masses can sit on conjugate matrices with the same spectrum. |
| “Hermitian support implies unitary invariance.” | A law may live entirely on Hermitian matrices while preferring one basis. |
| “Invariance under one swap is full unitary invariance.” | Full invariance requires every unitary \(U\). |
| “A random unitary test proves the definition.” | The definition quantifies over each fixed deterministic unitary. |
| “Congruence by any matrix preserves eigenvalues.” | Arbitrary congruence preserves Hermiticity, but spectral preservation uses unitarity. |
| “A density depending on \(\operatorname{tr}(H^2)\) settles everything.” | A density proof must also show that the reference measure is preserved by the action. |

{{< panel "warning" >}}
**What the definition does not prove.** Unitary invariance alone supplies no
Gaussianity, independence of entries, eigenvalue density, large-dimension
limit, level-repulsion law, or dynamical chaos. It is one exact symmetry of a
measure.
{{< /panel >}}

## Where to continue

Review {{< refterm "hermitian-matrix" "Hermitian matrix" >}} for the structural
constraint preserved by every congruence, and
{{< refterm "pushforward-measure" "pushforward measure" >}} for the law-level
transport operation. The chapter
[From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance]({{< relref "/knowledge-base/deep-dives/normalized-hermitian-coordinates-to-gue-invariance" >}})
builds the checked whole-law argument. The chapter
[Finite Hermitian Spectra and Empirical Measures]({{< relref "/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures" >}})
develops ordered eigenvalues and their samplewise invariance. For the broader
path from an outcome to a matrix law and then a spectrum, continue to
[Random Matrices: From Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}}).

## References

**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems. I](https://doi.org/10.1063/1.1703773),
*Journal of Mathematical Physics* 3, 140-156, 1962. This original paper
introduces the orthogonal, unitary, and symplectic symmetry classes in their
physical and group-theoretic setting.

**Greg W. Anderson, Alice Guionnet, and Ofer Zeitouni.**
[An Introduction to Random Matrices](https://doi.org/10.1017/CBO9780511801334),
Cambridge University Press, 2010. This monograph treats invariant matrix laws
and Gaussian ensembles systematically.

**Mathlib contributors.**
[The matrix unitary group](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/UnitaryGroup.html),
Mathlib 4 documentation. This is the official source for
<code>Matrix.unitaryGroup</code>.

**Mathlib contributors.**
[Pushforward of a measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
Mathlib 4 documentation. This is the official source for
<code>Measure.map</code>.

**Project source.**
[Laws.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/Laws.lean)
defines matrix congruence and unitary invariance of a measure.
[GaussianUnitaryEnsembleInvariance.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleInvariance.lean)
proves invariance of the finite GUE law, and
[HermitianSpectrum.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/HermitianSpectrum.lean)
proves ordered-spectrum invariance.
