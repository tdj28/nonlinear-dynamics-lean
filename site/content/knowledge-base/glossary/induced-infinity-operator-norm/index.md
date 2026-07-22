---
title: "Induced infinity operator norm"
slug: "induced-infinity-operator-norm"
summary: "The induced infinity operator norm measures the largest amplification of a vector's supremum norm and, for a finite matrix, equals the largest absolute row sum."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.MatrixProducts.FiniteProducts"
og_image: "induced-infinity-operator-norm-card.png"
og_image_alt: "A teaching card turns absolute matrix entries into row totals, keeps the largest row total, and uses it to bound the supremum size of the output vector."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

The **induced infinity operator norm** of a finite matrix is the largest factor
by which that matrix can amplify the supremum norm of a column vector. If
\(x=(x_i)_{i\in\iota}\), its supremum norm is

\[
\lVert x\rVert_\infty=\max_{i\in\iota}|x_i|.
\]

For a square matrix \(A=(A_{ij})\) over the real or complex numbers, the
corresponding induced matrix norm is

\[
\lVert A\rVert_\infty
=\max_{i\in\iota}\sum_{j\in\iota}|A_{ij}|.
\]

It is therefore also called the **maximum absolute row-sum norm**. The word
*induced* records the defining relationship with vector action:

\[
\lVert Ax\rVert_\infty
\leq \lVert A\rVert_\infty\lVert x\rVert_\infty.
\]

For a nonempty finite coordinate type, the row-sum formula equals the ordinary
operator norm of the linear map \(x\mapsto Ax\) when both domain and codomain
carry the vector supremum norm. Mathlib checks this identification in its
finite-matrix norm library
([Mathlib contributors](#ref-linfty-mathlib-normed)).

{{< reference-figure
  src="induced-infinity-operator-norm.svg"
  alt="A four-stage process takes absolute sizes of matrix entries, adds those sizes within each row, keeps the largest row total, and uses that total to bound the supremum size of every output column vector."
  caption="**Finding:** the matrix norm is computed row by row because one output coordinate is one row acting on the input vector. Absolute values and the triangle inequality turn each row into a total amplification budget; the largest budget controls every output coordinate at once."
>}}

## Why row sums appear

The \(i\)-th output coordinate is

\[
(Ax)_i=\sum_j A_{ij}x_j.
\]

The triangle inequality gives

\[
\begin{aligned}
|(Ax)_i|
&\leq \sum_j |A_{ij}|\,|x_j|\\
&\leq \left(\sum_j|A_{ij}|\right)\lVert x\rVert_\infty.
\end{aligned}
\]

Taking the maximum over output coordinates yields

\[
\lVert Ax\rVert_\infty
\leq
\left(\max_i\sum_j|A_{ij}|\right)\lVert x\rVert_\infty.
\]

The bound is optimal. Choose a row whose absolute sum is maximal, then choose
unit-sized input coordinates whose phases align the summands in that row. Over
the real numbers this means choosing signs. Over the complex numbers it means
choosing conjugate phases. That input has supremum norm one and makes the
selected row attain its full absolute sum. This standard argument identifies
the induced norm with the maximum row sum
([Horn and Johnson](#ref-linfty-horn-johnson)).

## A worked two-by-two calculation

Let

\[
A=
\begin{bmatrix}
1&-2\\
3&4
\end{bmatrix}.
\]

The two absolute row sums are

\[
|1|+|-2|=3,
\qquad
|3|+|4|=7.
\]

Therefore \(\lVert A\rVert_\infty=7\). If

\[
x=
\begin{bmatrix}
1\\
1
\end{bmatrix},
\]

then \(\lVert x\rVert_\infty=1\) and

\[
Ax=
\begin{bmatrix}
-1\\
7
\end{bmatrix}.
\]

Thus \(\lVert Ax\rVert_\infty=7\), so this particular vector attains the
operator norm. Other vectors can experience much less amplification. The norm
records a worst case, not the behavior of every state.

## Products multiply amplification budgets

If \(A\) and \(B\) are compatible square matrices, then

\[
\lVert AB\rVert_\infty
\leq
\lVert A\rVert_\infty\lVert B\rVert_\infty.
\]

One way to read this is operational. First \(B\) can amplify an input by at
most \(\lVert B\rVert_\infty\). Then \(A\) can amplify the intermediate vector
by at most \(\lVert A\rVert_\infty\). Multiplying the two budgets bounds the
complete action.

For the
{{< refterm "forward-matrix-product" "forward matrix product" >}}

\[
P_A(k)=A_{k-1}\cdots A_0,
\]

repeated submultiplicativity gives

\[
\lVert P_A(k)\rVert_\infty
\leq
\prod_{j=0}^{k-1}\lVert A_j\rVert_\infty.
\]

If every factor through the chosen horizon satisfies
\(\lVert A_j\rVert_\infty\leq C\), the product is at most \(C^k\). Acting on a
vector gives the corresponding orbit bound

\[
\lVert P_A(k)x\rVert_\infty
\leq C^k\lVert x\rVert_\infty.
\]

These are upper envelopes. Different factors can cancel, align poorly, or
preserve special subspaces, so the inequalities need not be equalities.

## The Lean norm scope is part of the theorem

Mathlib provides several natural norms on finite matrices. They are not all
definitionally or mathematically interchangeable. The project opens

~~~lean
open scoped Matrix.Norms.Operator
~~~

before writing expressions such as <code>‖A‖</code>. Inside that scope, the
matrix norm is the induced infinity operator norm documented above. Without
the scope, the same notation may refer to another available instance or fail
to resolve in the intended way. The scope is part of the semantic context of
every norm theorem in the module.

Mathlib exposes the key estimates as
<code>Matrix.linfty_opNorm_mul</code> and
<code>Matrix.linfty_opNorm_mulVec</code>, and proves that this concrete norm
agrees with the operator norm of the associated continuous linear map on
finite function spaces. The vector norm is the finite function-space supremum
norm, supplied by the normed-space construction for dependent functions
([Mathlib contributors](#ref-linfty-mathlib-pi)).

## It is not the Frobenius norm

For a finite matrix, the Frobenius norm is

\[
\lVert A\rVert_F
=\left(\sum_{i,j}|A_{ij}|^2\right)^{1/2}.
\]

It treats all entries as one Euclidean coordinate list. The infinity operator
norm instead adds absolute values within each row and selects the largest row
total. For the worked matrix,

\[
\lVert A\rVert_F=\sqrt{30},
\qquad
\lVert A\rVert_\infty=7.
\]

Both norms are useful, but for different jobs. Frobenius geometry is natural
for entrywise Gaussian coordinates and unitary-invariant Euclidean structure.
The induced infinity norm is natural for controlling the supremum size of
matrix-vector action. See
{{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius geometry" >}}
for the entrywise Euclidean viewpoint.

This norm is also not the entrywise maximum
\(\max_{i,j}|A_{ij}|\), and it is not the Euclidean spectral operator norm
induced by the vector two-norm. In finite dimension these norms can be compared
by dimension-dependent inequalities, but the current module does not formalize
those comparisons.

## Why positive dimension appears

The algebraic forward product permits an empty index type. The analytic
theorems in the current module additionally assume <code>Nonempty ι</code>.
This is not a claim that empty matrices are ill-defined.

For an empty index type, the space of column vectors and the space of square
matrices are both trivial. Mathlib's concrete maximum-row-sum construction is
a supremum over the finite set of rows. The supremum of the empty family is
zero, so even the unique identity matrix has norm zero. That is a valid norm
on a trivial additive space, but it does not satisfy the normalized identity
law \(\lVert I\rVert=1\).

The finite-product estimates use the normalized identity law at horizon zero:

\[
\lVert P_A(0)\rVert_\infty
=\lVert I\rVert_\infty
=1.
\]

The assumption <code>Nonempty ι</code> provides exactly the positive-dimension
condition under which Mathlib installs that identity normalization. The
recursion, split law, constant-power law, and chronological action remain
valid without it.

## Scalar and constant assumptions

The norm estimates use a scalar type satisfying Mathlib's
<code>RCLike</code> interface, covering the real and complex numbers with the
analytic structure needed by the matrix norm library. This is stronger than
the semiring assumption used by the algebraic product.

The uniform bound theorem takes \(C\in\mathbb R\) and assumes

\[
\lVert A_j\rVert_\infty\leq C
\quad\text{for every }j\lt k.
\]

It does not separately assume \(0\leq C\). At a positive horizon, at least one
nonnegative norm is bounded above by \(C\), which forces \(C\) to be
nonnegative. At horizon zero, there are no factor hypotheses and \(C^0=1\), so
the power estimate is valid for every real \(C\). This edge case is deliberate.

## What the norm bound does not establish

A finite-horizon upper bound is not a stability classification. In particular,
the checked theorems do not prove:

- equality or sharpness of any product bound;
- a lower growth bound;
- contraction without an additional condition such as \(C\lt1\);
- convergence of a matrix product or a vector orbit;
- a spectral-radius or eigenvalue formula;
- an asymptotic exponential rate or Lyapunov exponent;
- measurability or integrability of random factors; or
- a multiplicative ergodic theorem.

The bounds are useful raw material for those subjects, but each requires its
own hypotheses and definitions. Coppel develops stability theory for linear
evolution problems, while Oseledets addresses asymptotic rates in a
measure-preserving setting
([Coppel](#ref-linfty-coppel); [Oseledets](#ref-linfty-oseledets)). Their
conclusions are motivation only here.

## Exercises

1. Compute the induced infinity norm of
   \(\begin{bmatrix}2&-1\\-4&0\end{bmatrix}\).
2. Find a supremum-norm-one real vector that attains the largest row sum in
   the preceding matrix.
3. Derive the matrix-vector inequality directly from the triangle inequality.
4. Explain why taking a maximum of column sums would correspond to a different
   vector norm convention.
5. Compare the Frobenius and induced infinity norms of the identity matrix in
   dimensions one, two, and three.
6. At horizon zero, verify the power estimate for a negative \(C\). Explain
   why the same \(C\) cannot satisfy the factor hypothesis at a positive
   horizon.
7. Describe why the empty coordinate space has identity norm zero under the
   row-sum formula and why that does not violate positive definiteness.

## Where to continue

[Ordered Finite Matrix Products and Operator-Norm Growth]({{< relref "/knowledge-base/deep-dives/ordered-finite-matrix-products-and-operator-norm-growth" >}})
derives the product, geometric-power, and vector-orbit bounds from the exact
Lean declarations. The
{{< refterm "forward-matrix-product" "forward matrix product" >}}
entry fixes the order convention that those bounds control.

For a deliberately different matrix geometry, read
{{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius geometry" >}}.
[Random Matrices from Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}})
explains how deterministic matrices can become values of measurable random
variables. No such probability layer is present in the current product module.

## References

<a id="ref-linfty-mathlib-normed"></a>**Mathlib contributors.**
[Norms on finite matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Normed.html),
Mathlib 4 documentation. This official source defines the maximum absolute
row-sum norm, proves its matrix-product and matrix-vector inequalities, and
identifies it with the induced operator norm on finite supremum-norm spaces.

<a id="ref-linfty-mathlib-pi"></a>**Mathlib contributors.**
[Normed structures on function spaces](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Normed/Group/Constructions.html),
Mathlib 4 documentation. This official interface supplies the pointwise
function-space norm whose finite form is the vector supremum norm.

<a id="ref-linfty-horn-johnson"></a>**Roger A. Horn and Charles R. Johnson.**
[Matrix Analysis, second edition](https://www.cambridge.org/highereducation/books/matrix-analysis/FDA3627DC2B9F5C3DF2FD8C3CC136B48),
Cambridge University Press, 2013, ISBN 978-0-521-54823-6. Chapter 5 develops
vector norms, induced matrix norms, and standard finite-dimensional norm
comparisons. The project uses the maximum absolute row-sum convention.

<a id="ref-linfty-coppel"></a>**W. A. Coppel.**
[Dichotomies in Stability Theory](https://doi.org/10.1007/BFb0067780),
Lecture Notes in Mathematics, Springer, 1978. This is classical motivation
for using transition-matrix bounds in stability theory; no dichotomy theorem
is claimed here.

<a id="ref-linfty-oseledets"></a>**V. I. Oseledets.**
[A multiplicative ergodic theorem. Characteristic Ljapunov exponents of dynamical systems](https://www.mathnet.ru/eng/mmo214),
*Transactions of the Moscow Mathematical Society* 19 (1968), 197-231. This
primary source supplies asymptotic motivation only. The finite norm estimates
do not establish its hypotheses or conclusions.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
