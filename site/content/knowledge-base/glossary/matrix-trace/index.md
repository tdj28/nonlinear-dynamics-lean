---
title: "Matrix trace"
slug: "matrix-trace"
summary: "The trace adds a square matrix's diagonal entries and packages information that does not depend on the chosen basis."
draft: true
pro_reviewed: false
toc: false
---

The **trace** of a finite square matrix \(A\) is the sum of its diagonal
entries:

\[
\operatorname{tr}(A)=\sum_i A_{ii}.
\]

For example,

\[
A=
\begin{bmatrix}
2 & 7 \\
-1 & 5
\end{bmatrix}
\qquad\Longrightarrow\qquad
\operatorname{tr}(A)=2+5=7.
\]

The off-diagonal entries do not appear directly in this formula. They still
affect the traces of higher powers because multiplication mixes coordinates.

## Why the trace is structural

For compatible finite matrices,

\[
\operatorname{tr}(AB)=\operatorname{tr}(BA).
\]

Consequently, similarity transformations preserve trace:

\[
\operatorname{tr}(SAS^{-1})=\operatorname{tr}(A)
\]

when \(S\) is invertible. Trace is therefore a basis-independent feature
of the represented linear operator, even though its coordinate definition is a
diagonal sum.

When \(H\) is {{< refterm "hermitian-matrix" "Hermitian" >}}, its diagonal
entries are real, so \(\operatorname{tr}(H)\) is real. Equivalently,
Hermitian eigenvalues are real and their sum equals the trace.

## In the random-matrix formalization

For a finite {{< refterm "random-matrix" "random matrix" >}}
\(X:\Omega\to\mathbb C^{n\times n}\), the trace becomes a scalar
function of the outcome:

\[
\omega\longmapsto\operatorname{tr}(X(\omega)).
\]

The project proves this function is measurable whenever \(X\) is
measurable. The proof expands trace into a finite sum of measurable diagonal
coordinates.

Lean writes the operation as `Matrix.trace A`. The word `trace` alone does not
mean expectation, average, or normalized trace.

{{< panel "warning" >}}
**Convention check.** Random-matrix texts often use both the ordinary trace
\(\operatorname{tr}\) and the normalized trace
\(n^{-1}\operatorname{tr}\). A theorem or moment formula must state which
one it uses.
{{< /panel >}}

Related concept: {{< refterm "trace-power" "trace-power observable" >}}.

Further reading: Mathlib's
[matrix trace module](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Trace.html)
documents the finite algebraic API used by the project.
