---
title: "Hermitian matrix"
slug: "hermitian-matrix"
summary: "A Hermitian matrix equals its conjugate transpose, forcing real diagonal entries and conjugate-paired off-diagonal entries."
draft: false
pro_reviewed: false
toc: false
---

A square complex matrix \(H\) is **Hermitian** when it equals its
{{< refterm "conjugate-transpose" "conjugate transpose" >}}:

\[
H^*=H.
\]

Entrywise, this says

\[
H_{ji}=\overline{H_{ij}}.
\]

The diagonal condition \(H_{ii}=\overline{H_{ii}}\) forces every
diagonal entry to be real. Away from the diagonal, choosing \(H_{ij}\)
automatically determines the reflected entry \(H_{ji}\).

A general two-by-two example is

\[
H=
\begin{bmatrix}
a & z \\
\overline z & b
\end{bmatrix},
\qquad a,b\in\mathbb R,\quad z\in\mathbb C.
\]

## The spectral reward

Finite-dimensional Hermitian matrices have real eigenvalues and admit an
orthonormal basis of eigenvectors. Equivalently, a unitary matrix can
diagonalize \(H\) with a real diagonal. This is why Hermitian random
matrices are natural models for quantum Hamiltonians: the modeled energy
levels remain real.

The statement above is a structural theorem. It does not say that eigenvalues
are independent, that their distribution is Gaussian, or that every Hermitian
random matrix belongs to the Gaussian unitary ensemble.

## A universal constructor

Every square complex matrix \(A\) yields a Hermitian matrix:

\[
H=A+A^*.
\]

Indeed,

\[
H^*=(A+A^*)^*=A^*+A=H.
\]

This calculation is the mathematical heart of the project's first Hermitian
symmetrization theorem.

When a construction already begins with the free matrix coordinates,
\(A+A^*\) is unnecessarily indirect and doubles a supplied real diagonal. The
project's newer
{{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}
stores a real diagonal and complex strict upper triangle, then fills the lower
triangle by conjugate reflection. The Deep Dive
[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}})
proves why that direct map is Hermitian and measurable without selecting a
probability law or scale.

## In Lean

Mathlib defines `Matrix.IsHermitian A` by the equality `Aᴴ = A`. The
project proves the symmetrization property both for every sample and, as an
immediate consequence, {{< refterm "almost-everywhere" "almost everywhere" >}}
with respect to any measure.

{{< panel "warning" >}}
**Normalization matters later.** Multiplying a random Hermitian matrix by a
dimension-dependent scalar preserves Hermitian symmetry but changes its
spectral scale. An eventual Gaussian unitary ensemble definition must state
that convention explicitly.
{{< /panel >}}

Related concepts: {{< refterm "random-matrix" "random matrix" >}} and
{{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}.

Further reading: Mathlib documents
[`Matrix.IsHermitian`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html)
and its connection with self-adjoint linear maps in
[the analytic Hermitian module](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Hermitian.html).
