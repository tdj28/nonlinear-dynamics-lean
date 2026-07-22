---
title: "Matrix trace"
slug: "matrix-trace"
summary: "The trace adds a finite square matrix's diagonal entries; for one linear operator, that sum is unchanged by a change of basis."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.Hermitian"
og_image: "matrix-trace-card.png"
og_image_alt: "A two-by-two matrix has its diagonal entries extracted and added, alongside a basis-swap similarity check and a warning that off-diagonal entries return in higher powers."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
prose, equations, example, diagram, references, and Lean interpretation is
still pending. The page is public as an open working note while that review
remains pending.
{{< /panel >}}

The **trace** of a finite square matrix is found by reading its main diagonal
and adding those entries. It turns an entire matrix into one scalar.

## Start with one 2 by 2 matrix

Take

\[
A=
\begin{bmatrix}
2&7\\
-1&5
\end{bmatrix}.
\]

The main diagonal runs from the top-left entry to the bottom-right entry, so

\[
\operatorname{tr}(A)=2+5=7.
\]

The entries \(7\) and \(-1\) are off the main diagonal. They do not enter this
particular sum directly. In general, for a square matrix whose rows and columns
share the finite index set \(I\),

\[
\operatorname{tr}(A)=\sum_{i\in I}A_{ii}.
\]

{{< reference-figure
  wide="true"
  src="diagonal-to-trace.svg"
  alt="The diagonal cells two and five are selected from a two by two matrix and added to obtain trace seven, while the off-diagonal cells seven and minus one are skipped. A basis swap gives a different similar matrix with the same trace. Squaring the original matrix moves products involving off-diagonal entries onto the diagonal and gives trace fifteen."
  caption="**Finding:** for \(A=\left[\begin{smallmatrix}2&7\\-1&5\end{smallmatrix}\right]\), trace reads the solid diagonal cells and gives \(2+5=7\); the hatched off-diagonal cells do not contribute directly. Swapping the two basis vectors produces the similar matrix \(B=PAP^{-1}=\left[\begin{smallmatrix}5&-1\\7&2\end{smallmatrix}\right]\), whose diagonal sum is still seven. This illustrates change-of-basis invariance, but equal traces alone do not imply similarity. Off-diagonal does not mean irrelevant: \(A^2=\left[\begin{smallmatrix}-3&49\\-7&18\end{smallmatrix}\right]\), so products involving \(7\) and \(-1\) affect the new diagonal and \(\operatorname{tr}(A^2)=15\)."
>}}

## Why off-diagonal entries still matter

The phrase "trace ignores off-diagonal entries" is safe only for the direct
calculation of \(\operatorname{tr}(A)\). Matrix multiplication mixes rows and
columns. In this example,

\[
A^2
{} =
\begin{bmatrix}
-3&49\\
-7&18
\end{bmatrix},
\qquad
\operatorname{tr}(A^2)=-3+18=15.
\]

The new top-left entry is

\[
(A^2)_{11}=2\cdot2+7\cdot(-1)=-3,
\]

so the old off-diagonal entries now influence a diagonal entry. This is why
the {{< refterm "trace-power" "trace-power observable" >}}
\(\operatorname{tr}(A^k)\) contains more information than
\(\operatorname{tr}(A)\) alone.

## Why the trace is structural

The coordinate matrix of a linear operator changes when its basis changes.
The individual diagonal entries can change too, but their sum does not. For
the example, let

\[
P=
\begin{bmatrix}
0&1\\
1&0
\end{bmatrix}.
\]

This matrix swaps the two basis vectors and satisfies \(P^{-1}=P\). The
similar matrix is

\[
B=PAP^{-1}
{} =
\begin{bmatrix}
5&-1\\
7&2
\end{bmatrix},
\qquad
\operatorname{tr}(B)=5+2=7.
\]

The general calculation uses cyclicity. For compatible finite square matrices,

\[
\operatorname{tr}(AB)=\operatorname{tr}(BA).
\]

If \(S\) is invertible, then

\[
\operatorname{tr}(SAS^{-1})
{} =
\operatorname{tr}(AS^{-1}S)
{} =
\operatorname{tr}(A).
\]

Thus trace is a basis-independent feature of a finite-dimensional linear
endomorphism, even though its coordinate formula is a diagonal sum. This is a
specific similarity statement. It does not say that trace is unchanged under
an arbitrary edit or rearrangement of matrix entries.

The converse is false: equal traces do not imply similarity. The zero matrix
and

\[
N=
\begin{bmatrix}
0&1\\
0&0
\end{bmatrix}
\]

both have trace zero, but the nonzero matrix \(N\) cannot be similar to the
zero matrix.

When \(H\) is {{< refterm "hermitian-matrix" "Hermitian" >}}, its diagonal
entries are real, so \(\operatorname{tr}(H)\) is real. From the spectral
viewpoint, its eigenvalues are real and, with multiplicity, their sum equals
the trace. That spectral statement uses additional finite-dimensional
eigenvalue theory; it is not the definition of trace.

## Trace as a random-matrix observable

For a finite {{< refterm "random-matrix" "random matrix" >}}
\(X:\Omega\to\mathbb C^{n\times n}\), the trace becomes a scalar function of
the outcome:

\[
\omega\longmapsto\operatorname{tr}(X(\omega)).
\]

The project proves this function is measurable whenever \(X\) is measurable.
The proof expands trace into a finite sum of measurable diagonal coordinates.
If one realization equals the example matrix \(A\), then the scalar observable
returns seven on that outcome. A different realization can return a different
number. Taking the trace pointwise does not take an expectation over outcomes.

## In Lean

Lean writes the operation on one matrix as <code>Matrix.trace A</code>. The
project theorem connects the finite diagonal sum to probability by showing
that pointwise trace preserves measurability.

{{< lean-bridge
  human="If a finite complex random matrix depends measurably on the outcome, then its trace also depends measurably on the outcome."
  math="\(X:\Omega\to\mathbb C^{I\times I}\text{ measurable}\;\Longrightarrow\;\bigl(\omega\mapsto\operatorname{tr}(X(\omega))\bigr)\text{ measurable}.\)"
  lean="RandomMatrix.measurable_trace hX : Measurable fun ω ↦ Matrix.trace (X ω)"
>}}

- <code>X</code> is a square complex
  <code>RandomMatrix Ω ι ι ℂ</code>. Using <code>ι</code> for both matrix
  indices is Lean's version of "square."
- <code>[Fintype ι]</code> tells Lean that the diagonal index set is finite, so
  its entries can be added with a finite sum.
- <code>hX : Measurable X</code> is the hypothesis that the matrix-valued map
  is measurable.
- <code>fun ω ↦ Matrix.trace (X ω)</code> is an anonymous function: take an
  outcome <code>ω</code>, realize <code>X ω</code>, and compute its trace.
- <code>Measurable</code> before that function is the conclusion. The colon in
  the Lean line reads "this proof term has the following proposition as its
  type."
{{< /lean-bridge >}}

This is the exact checked source declaration and proof:

~~~lean
theorem measurable_trace [Fintype ι] {X : RandomMatrix Ω ι ι ℂ}
    (hX : Measurable X) : Measurable fun ω ↦ Matrix.trace (X ω) := by
  simp only [Matrix.trace, Matrix.diag_apply]
  exact Finset.measurable_sum Finset.univ fun i _ ↦ measurable_entry hX i i
~~~

The proof unfolds <code>Matrix.trace</code> into its diagonal sum. For each
index <code>i</code>, <code>measurable_entry hX i i</code> supplies
measurability of the diagonal coordinate, and
<code>Finset.measurable_sum</code> combines finitely many such coordinates.

The same module proves that the trace of a finite Hermitian complex matrix is
fixed by complex conjugation, and hence has zero imaginary part. That theorem
uses Hermiticity as an explicit hypothesis; an arbitrary complex matrix need
not have real trace.

{{< repo-check >}}
The authoritative project source is
[formalization/NonlinearDynamics/Random/RandomMatrices/Hermitian.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/Hermitian.lean).
A learner can type the following in a temporary Lean file on an approved Linux
builder:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.Hermitian

#check Matrix.trace
#check NonlinearDynamics.Random.RandomMatrix.measurable_trace
#check NonlinearDynamics.Random.RandomMatrix.star_trace_eq_of_isHermitian
~~~

The import makes the project declarations available. Each <code>#check</code>
asks Lean to elaborate a name and display its exact type; it does not prove a
new theorem. The guarded command below checks the authoritative module itself.
{{< /repo-check >}}

## Boundaries and convention checks

{{< panel "warning" >}}
**Ordinary versus normalized trace.** Random-matrix texts use both the ordinary
trace \(\operatorname{tr}(A)\) and the normalized trace
\(n^{-1}\operatorname{tr}(A)\). For the example, those values are seven and
\(7/2\). A theorem or moment formula must state which convention it uses.
{{< /panel >}}

- Trace is defined here for finite square matrices. A rectangular matrix has
  no basis-independent main-diagonal sum of this kind.
- Cyclicity permits cyclic rotation of a product inside trace. It does not
  permit arbitrary reordering of noncommuting factors.
- Trace is not a determinant, a norm, an expectation, or a probability. One
  scalar cannot generally reconstruct a matrix or its spectrum.
- Similarity preserves trace, but sharing a trace does not prove similarity.
- Off-diagonal entries make no direct contribution to
  \(\operatorname{tr}(A)\), but they can contribute to
  \(\operatorname{tr}(A^k)\) for \(k\ge2\).

## Where to continue

The {{< refterm "trace-power" "trace-power observable" >}} page studies higher
powers. The
{{< refterm "finite-matrix-trace-moment" "finite matrix trace moment" >}} page
separates pointwise trace powers from their integrals under a matrix law. The
{{< refterm "conjugate-transpose" "conjugate transpose" >}} page explains the
operation used in Hermitian symmetry.

## Further reading

Mathlib's
[matrix trace module](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Trace.html)
documents the finite algebraic API used by the project.
