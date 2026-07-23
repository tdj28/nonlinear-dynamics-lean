---
title: "Hermitian matrix"
slug: "hermitian-matrix"
summary: "A Hermitian matrix equals its conjugate transpose, forcing real diagonal entries and conjugate-paired off-diagonal entries."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.Hermitian"
og_image: "hermitian-matrix-card.png"
og_image_alt: "A two-by-two complex matrix passes the Hermitian entry test and has real eigenvalues four and minus three, while a repeated off-diagonal entry fails."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean examples, source interpretation, diagram, and accessibility
remains pending. The page is public so readers can follow the educational
rebuild while that review remains open.
{{< /panel >}}

Consider the concrete complex matrix

\[
H=
\begin{bmatrix}
2 & 1+3i\\
1-3i & -1
\end{bmatrix}.
\]

It is **Hermitian** because reflecting its entries across the diagonal and
taking their complex conjugates gives the same matrix back. This small example
contains the whole entry-by-entry idea.

## Check the example one entry at a time

On the diagonal, both entries are real:

\[
\overline{2}=2,
\qquad
\overline{-1}=-1.
\]

Across the diagonal, the two entries form a conjugate pair:

\[
\overline{1+3i}=1-3i,
\qquad
\overline{1-3i}=1+3i.
\]

The {{< refterm "conjugate-transpose" "conjugate transpose" >}} of \(H\) is
therefore

\[
H^{\mathrm H}
{} =
\begin{bmatrix}
\overline{2} & \overline{1-3i}\\
\overline{1+3i} & \overline{-1}
\end{bmatrix}
{} =
\begin{bmatrix}
2 & 1+3i\\
1-3i & -1
\end{bmatrix}
=H.
\]

That equality, \(H^{\mathrm H}=H\), is the definition of Hermitian.

{{< reference-figure
  wide="true"
  src="hermitian-entry-check.svg"
  alt="The matrix H has real diagonal entries two and minus one. Its upper-right entry one plus three i is paired with the lower-left entry one minus three i by complex conjugation, so it passes the Hermitian check. A near-miss matrix K repeats one plus three i below the diagonal and fails. A final panel computes trace one, determinant minus twelve, and real eigenvalues four and minus three for H."
  caption="**Finding:** the diagonal entries of \(H\) have zero imaginary part, and reflecting \(1+3i\) across the diagonal changes it to its conjugate \(1-3i\). Those displayed entry equalities are exactly \(H^{\mathrm H}=H\) for this matrix. The near miss \(K\) copies \(1+3i\) instead of conjugating it, so \(K^{\mathrm H}\ne K\). For the passing matrix, the characteristic polynomial factors as \((\lambda-4)(\lambda+3)\), giving the real eigenvalues \(4\) and \(-3\). This one calculation illustrates the spectral theorem; the general theorem requires a separate argument."
>}}

## The general two-by-two pattern

A two-by-two complex matrix is Hermitian exactly when it has the form

\[
\begin{bmatrix}
a & z\\
\overline z & b
\end{bmatrix},
\qquad
a,b\in\mathbb R,
\quad
z\in\mathbb C.
\]

The diagonal entries \(a\) and \(b\) each contribute one real degree of
freedom. The upper entry \(z=x+iy\) contributes two more. The lower entry is
then forced to be \(\overline z=x-iy\); it is not a new independent choice.
Thus a two-by-two Hermitian matrix has four real degrees of freedom, not eight.

For a larger square matrix \(A=(A_{ij})\), the same rule is

\[
\overline{A_{ji}}=A_{ij}
\qquad\text{for every pair }i,j.
\]

Putting \(i=j\) gives

\[
\overline{A_{ii}}=A_{ii},
\]

so every diagonal entry has zero imaginary part. For \(i\ne j\), choosing one
entry determines the reflected entry.

## A near miss: copying is not conjugating

Now change only the lower-left entry:

\[
K=
\begin{bmatrix}
2 & 1+3i\\
1+3i & -1
\end{bmatrix}.
\]

The diagonal is still real, but

\[
\overline{K_{12}}
=\overline{1+3i}
=1-3i
\ne
1+3i
=K_{21}.
\]

Therefore \(K\) is not Hermitian. A matrix with real diagonal entries need not
be Hermitian, and a complex Hermitian matrix need not be symmetric under an
ordinary transpose. The conjugation is essential.

For real matrices, complex conjugation does nothing. In that special case,
Hermitian is the same condition as symmetric.

## Why the eigenvalues become real

For the example \(H\), its {{< refterm "matrix-trace" "trace" >}} and
determinant are

\[
\operatorname{tr}(H)=2+(-1)=1
\]

and

\[
\det(H)
=2(-1)-(1+3i)(1-3i)
=-2-10
=-12.
\]

Its characteristic polynomial is therefore

\[
\lambda^2-\operatorname{tr}(H)\lambda+\det(H)
=\lambda^2-\lambda-12
=(\lambda-4)(\lambda+3).
\]

The eigenvalues are \(4\) and \(-3\), both real. Their sum \(1\) matches the
trace, and their product \(-12\) matches the determinant.

This calculation is evidence for one matrix, not a proof for every Hermitian
matrix. The finite-dimensional spectral theorem supplies the general result:
a complex Hermitian matrix has real eigenvalues and an orthonormal basis of
eigenvectors. Equivalently, it can be diagonalized by a unitary change of
basis, with real numbers on the diagonal.

The negative eigenvalue \(-3\) also gives an important boundary case.
Hermitian does **not** mean positive semidefinite. Positivity would require all
eigenvalues to be nonnegative, which this \(H\) fails.

## Observables and random matrices

In finite-dimensional quantum models, a Hermitian matrix can represent an
observable or Hamiltonian. Hermiticity makes its spectral values real. That
statement does not by itself select a physical state, assign probabilities to
the possible values, or establish a complete physical model.

A {{< refterm "random-matrix" "random matrix" >}} is a function

\[
X:\Omega\longrightarrow \operatorname{Mat}_{n\times n}(\mathbb C).
\]

Saying that \(X\) is Hermitian everywhere means

\[
X(\omega)^{\mathrm H}=X(\omega)
\qquad\text{for every }\omega\in\Omega.
\]

This is stronger than saying the equality holds
{{< refterm "almost-everywhere" "almost everywhere" >}}, where failures on a
{{< refterm "null-set" "null set" >}} are permitted. It is also distinct from
{{< refterm "measurable-function" "measurability" >}}, which says that \(X\)
respects the measurable structures on outcomes and matrices.

The project's `HermitianRandomMatrix` bundles two facts:

1. the outcome-to-matrix function is measurable; and
2. every realized matrix is Hermitian.

It does not choose a source measure, a
{{< refterm "probability-law" "probability distribution" >}}, a Gaussian
model, independent coordinates, unitary invariance, or a normalization. Those
are additional layers.

## A universal constructor, and its normalization

Every square complex matrix \(A\) produces a Hermitian matrix through

\[
H=A+A^{\mathrm H}.
\]

Indeed,

\[
H^{\mathrm H}
=(A+A^{\mathrm H})^{\mathrm H}
=A^{\mathrm H}+A
=H.
\]

This is the unnormalized symmetrization used by the project's base
constructor. The more familiar Hermitian part

\[
\frac12(A+A^{\mathrm H})
\]

has the same symmetry, but a different scale. If \(A\) is already Hermitian,
the unnormalized constructor returns \(2A\), not \(A\). The factor therefore
matters for eigenvalue scales and probability models even though it does not
matter for Hermiticity itself.

When a construction begins with free coordinates, the project's
{{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}
avoids that redundancy. It stores a real diagonal and a complex strict upper
triangle, then fills the lower triangle by conjugate reflection.

## In Lean

Mathlib writes the conjugate transpose of a matrix as `Aᴴ` and defines
`Matrix.IsHermitian A` by the literal equality `Aᴴ = A`.

{{< lean-bridge
  human="A square complex matrix is Hermitian when reflecting it across the diagonal and conjugating every entry leaves it unchanged."
  math="\(H^{\mathrm H}=H,\quad\text{equivalently}\quad \overline{H_{ji}}=H_{ij}\text{ for every }i,j.\)"
  lean="H.IsHermitian"
>}}

- `H.IsHermitian` is method notation for `Matrix.IsHermitian H`.
- A type such as `H : Matrix ι ι ℂ` says that rows and columns use the same
  index type `ι`, so the matrix is square, and that its entries lie in the
  complex numbers `ℂ`.
- `Hᴴ` is the conjugate transpose: transpose the matrix and apply `star` to
  each entry. On complex numbers, `star z` is complex conjugation.
- `Hᴴ = H` is equality of matrices, so it can be checked entry by entry.
- In `star (H j i) = H i j`, the indices reverse from `i, j` to `j, i`
  because of the transpose, and `star` supplies the conjugation.
{{< /lean-bridge >}}

The following is the exact core definition and entrywise theorem from the
pinned Mathlib source:

~~~lean
def IsHermitian (A : Matrix n n α) : Prop := Aᴴ = A

theorem IsHermitian.ext_iff {A : Matrix n n α} :
    A.IsHermitian ↔ ∀ i j, star (A j i) = A i j :=
  ⟨IsHermitian.apply, IsHermitian.ext⟩
~~~

Read `↔` as "if and only if," `∀ i j` as "for every row index `i` and column
index `j`," and `Prop` as the type of propositions. The theorem says that the
single matrix equation and all of the entry equations express exactly the
same property.

The project lifts that definition to matrix-valued functions. These are exact
excerpts from the checked module:

~~~lean
def IsHermitianEverywhere (X : RandomMatrix Ω ι ι ℂ) : Prop :=
  ∀ ω, (X ω).IsHermitian

theorem isHermitianEverywhere_iff_entries (X : RandomMatrix Ω ι ι ℂ) :
    IsHermitianEverywhere X ↔ ∀ ω i j, star (X ω j i) = X ω i j := by
  simp only [IsHermitianEverywhere, Matrix.IsHermitian.ext_iff]

theorem IsHermitianEverywhere.diagonal_im_eq_zero
    {X : RandomMatrix Ω ι ι ℂ} (hX : IsHermitianEverywhere X) (ω : Ω) (i : ι) :
    (X ω i i).im = 0 := by
  rw [← Complex.conj_eq_iff_im, ← Complex.star_def]
  exact hX.star_entry ω i i
~~~

Here `∀ ω` means every outcome, `X ω` is the ordinary matrix realized at
that outcome, and `.im = 0` is the real-diagonal conclusion. The theorem uses
the `i = j` case of conjugate reflection, as in the hand calculation.

### A tiny standalone worksheet

The next program models the same two-by-two check with Gaussian integers,
numbers of the form \(a+bi\) with integer real and imaginary parts. It imports
only Lean's `Std` library. It is a pedagogical miniature, not Mathlib's
`Matrix`, `ℂ`, or the project's checked definition.

Save the complete block as `HermitianWorksheet.lean`:

~~~lean
import Std

structure GaussianInt where
  re : Int
  im : Int
deriving Repr, DecidableEq

def GaussianInt.conj (z : GaussianInt) : GaussianInt :=
  { re := z.re, im := -z.im }

structure Matrix2 where
  a00 : GaussianInt
  a01 : GaussianInt
  a10 : GaussianInt
  a11 : GaussianInt
deriving Repr

def Matrix2.IsHermitian (A : Matrix2) : Prop :=
  A.a00.im = 0 ∧
  A.a11.im = 0 ∧
  A.a10 = GaussianInt.conj A.a01

instance (A : Matrix2) : Decidable (Matrix2.IsHermitian A) := by
  unfold Matrix2.IsHermitian
  infer_instance

def good : Matrix2 :=
  { a00 := { re := 2, im := 0 }
    a01 := { re := 1, im := 3 }
    a10 := { re := 1, im := (-3 : Int) }
    a11 := { re := (-1 : Int), im := 0 } }

def nearMiss : Matrix2 :=
  { a00 := { re := 2, im := 0 }
    a01 := { re := 1, im := 3 }
    a10 := { re := 1, im := 3 }
    a11 := { re := (-1 : Int), im := 0 } }

#eval decide (Matrix2.IsHermitian good)
#eval decide (Matrix2.IsHermitian nearMiss)

example : Matrix2.IsHermitian good := by decide
example : ¬ Matrix2.IsHermitian nearMiss := by decide
~~~

On any Mac or Linux machine with the pinned Lean toolchain available, a human
types:

~~~sh
elan run leanprover/lean4:v4.32.0 lean HermitianWorksheet.lean
~~~

Lean prints `true` and then `false` for the two `#eval` lines. The two
`example` declarations ask the kernel to check the positive and negative proof
terms. This standalone command does not import Mathlib or build this project.

{{< repo-check >}}
The authoritative project source is
[`formalization/NonlinearDynamics/Random/RandomMatrices/Hermitian.lean`](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/Hermitian.lean).
A learner can put these lines in a temporary scratch file inside the
`formalization` project in a clone with the repository's pinned Lean and Mathlib dependencies
installed:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.Hermitian

open scoped Matrix

#print Matrix.IsHermitian
#check Matrix.IsHermitian.ext_iff
#check NonlinearDynamics.Random.RandomMatrix.IsHermitianEverywhere
#check NonlinearDynamics.Random.RandomMatrix.isHermitianEverywhere_iff_entries
#check NonlinearDynamics.Random.HermitianRandomMatrix
~~~

`import` loads the exact project module and its pinned dependencies. `#print`
shows the definition behind a name. Each `#check` asks Lean to elaborate an
identifier and report its type; it does not assert a new theorem. The literal
full-project command below checks the authoritative project file itself.
{{< /repo-check >}}

## Distinctions that prevent common mistakes

| Do not infer | Why it does not follow from Hermiticity |
|---|---|
| Every entry is real | Only the diagonal must be real; \(1+3i\) is a valid off-diagonal entry in \(H\) |
| The matrix is positive semidefinite | The example \(H\) is Hermitian but has eigenvalue \(-3\) |
| The matrix is unitary | Hermitian means \(H^{\mathrm H}=H\); unitary means \(H^{\mathrm H}H=I\) |
| A random matrix is measurable | Hermiticity constrains each value; measurability constrains the outcome-to-value map |
| A random Hermitian matrix has a particular law | Hermiticity does not choose probabilities, a density, or a normalization |
| Its entries are independent or Gaussian | Those are separate assumptions, and conjugate-reflected entries are already linked |
| It is {{< refterm "unitary-invariance" "unitarily invariant" >}} | Support on Hermitian matrices and invariance of a probability law are different properties |
| An everywhere statement is only almost-sure | Everywhere is stronger; almost-sure statements may ignore a null set |

{{< panel "warning" >}}
**Scope of the calculation.** The explicit eigenvalue calculation treats one
two-by-two matrix. The general spectral theorem is a separate result. The
project module checked here formalizes Hermitian predicates, entry reflection,
real diagonals, traces, measurability, and pointwise versus almost-everywhere
interfaces. It does not yet formalize the full spectral theorem on this page,
nor does it define a named random-matrix ensemble merely by bundling
Hermiticity.
{{< /panel >}}

## Where to continue

The {{< refterm "conjugate-transpose" "conjugate transpose" >}} page builds
the operation \(A\mapsto A^{\mathrm H}\) entry by entry. The
{{< refterm "matrix-trace" "matrix trace" >}} page develops the first scalar
observable used above. The
{{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}
page explains how to store exactly the free coordinates.

For the construction and proof in context, continue to
[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}}).
For the probability layers that come afterward, continue to
[Random Matrices: From Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}}).

## References

**Mathlib contributors.**
[`Matrix.IsHermitian`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html),
Mathlib 4 documentation. This is the official implementation reference for
the definition and its entrywise interface.

**Mathlib contributors.**
[Hermitian matrices as analytic objects](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Hermitian.html),
Mathlib 4 documentation. This develops connections with self-adjoint linear
maps and finite-dimensional spectral structure.

**Greg W. Anderson, Alice Guionnet, and Ofer Zeitouni.**
[An Introduction to Random Matrices](https://doi.org/10.1017/CBO9780511801334),
Cambridge University Press, 2010. This supplies the random-matrix context in
which Hermitian support, probability laws, symmetry, and scaling must be kept
as distinct layers.
