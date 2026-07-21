---
title: "Conjugate transpose"
slug: "conjugate-transpose"
summary: "The conjugate transpose flips a complex matrix across its diagonal and conjugates every entry."
draft: true
pro_reviewed: false
toc: false
---

The **conjugate transpose** of a complex matrix \(A\), written
\(A^*\) or \(A^\dagger\), performs two operations:

1. transpose the matrix, exchanging rows and columns;
2. take the complex conjugate of every entry.

Entry by entry,

\[
(A^*)_{ij}=\overline{A_{ji}}.
\]

For example,

\[
A=
\begin{bmatrix}
1 & 2+i \\
-3i & 4
\end{bmatrix}
\qquad\Longrightarrow\qquad
A^*=
\begin{bmatrix}
1 & 3i \\
2-i & 4
\end{bmatrix}.
\]

The operation reverses multiplication order:

\[
(AB)^*=B^*A^*.
\]

It also satisfies \((A^*)^*=A\) and
\((A+B)^*=A^*+B^*\). These identities make it the matrix-level version
of taking the adjoint of a linear operator on a complex inner-product space.

## Why it matters here

A matrix is {{< refterm "hermitian-matrix" "Hermitian" >}} precisely when it
is fixed by conjugate transpose. The transformation

\[
A \longmapsto A+A^*
\]

therefore converts any square complex matrix into a Hermitian one. The factor
\(1/2\) is sometimes included when the goal is an averaging projection;
the project's first constructor is explicitly unnormalized.

## In Lean

With the `Matrix` scoped notation open, Mathlib writes conjugate transpose as
`Aᴴ`. The random-matrix foundation proves that if \(\omega\mapsto
X(\omega)\) is measurable, then so is
\(\omega\mapsto X(\omega)^ᴴ\).

{{< panel "info" >}}
For a real matrix, complex conjugation does nothing. The conjugate transpose
then reduces to the ordinary transpose.
{{< /panel >}}

Related concepts: {{< refterm "random-matrix" "random matrix" >}} and
{{< refterm "hermitian-matrix" "Hermitian matrix" >}}. The
{{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}
uses conjugation only on the reflected lower triangle, so every free complex
coordinate is supplied once.

Further reading: Mathlib's
[Hermitian-matrix module](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html)
uses conjugate transpose in its core definition.
