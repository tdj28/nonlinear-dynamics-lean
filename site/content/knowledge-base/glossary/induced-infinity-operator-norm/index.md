---
title: "Induced infinity operator norm"
slug: "induced-infinity-operator-norm"
summary: "The maximum absolute row sum is exactly the worst-case amplification factor for a finite vector's supremum norm."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.MatrixProducts.FiniteProducts"
og_image: "induced-infinity-operator-norm-card.png"
og_image_alt: "For the matrix with rows one minus two and three four, the card computes absolute row sums three and seven, rejects the column-sum answer six, and shows a vector that attains the infinity-norm bound seven."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working note. Human review of the
mathematics, Lean interpretation, sources, figures, and accessibility remains
pending. The page is public so readers can follow the work while that review
is still open.
{{< /panel >}}

The **induced infinity operator norm** measures the largest possible
amplification of a vector's supremum norm under matrix action.

For a finite vector \(x=(x_j)\),

\[
\lVert x\rVert_\infty=\max_j|x_j|.
\]

For a finite matrix \(A=(A_{ij})\), the induced matrix norm is

\[
\lVert A\rVert_\infty
=\max_i\sum_j|A_{ij}|.
\]

This is the **maximum absolute row-sum norm**. Rows appear because row \(i\)
computes output coordinate \((Ax)_i\).

## Compute one matrix completely

Take

\[
A=
\begin{bmatrix}
1&-2\\
3&4
\end{bmatrix}.
\]

First discard signs inside the row budgets:

\[
|A|=
\begin{bmatrix}
1&2\\
3&4
\end{bmatrix}.
\]

The absolute row sums are

\[
r_0=|1|+|-2|=3
\]

and

\[
r_1=|3|+|4|=7.
\]

The second row is the maximizing row. Therefore

\[
\boxed{\lVert A\rVert_\infty=\max(3,7)=7}.
\]

The norm is not the largest entry, which would be \(4\). It adds magnitudes
within each row before taking the maximum.

## Verify the action inequality on a concrete vector

Choose

\[
x=
\begin{bmatrix}
2\\
-1
\end{bmatrix}.
\]

Its supremum norm is

\[
\lVert x\rVert_\infty=\max(|2|,|-1|)=2.
\]

Matrix action gives

\[
Ax=
\begin{bmatrix}
1\cdot2+(-2)(-1)\\
3\cdot2+4(-1)
\end{bmatrix}
{}=
\begin{bmatrix}
4\\
2
\end{bmatrix}.
\]

Hence

\[
\lVert Ax\rVert_\infty=4
\]

and the induced-norm inequality reads

\[
4\leq7\cdot2=14.
\]

The inequality is true but not tight for this \(x\). An operator norm is a
worst-case factor, not the amplification experienced by every vector.

## A vector that attains equality

The maximizing row \((3,4)\) has both entries positive. Choose matching signs:

\[
x_*=
\begin{bmatrix}
1\\
1
\end{bmatrix},
\qquad
\lVert x_*\rVert_\infty=1.
\]

Then

\[
Ax_*=
\begin{bmatrix}
-1\\
7
\end{bmatrix},
\]

so

\[
\lVert Ax_*\rVert_\infty
=7
=\lVert A\rVert_\infty\lVert x_*\rVert_\infty.
\]

This equality shows that the bound is sharp for this matrix.

For a general real maximizing row, choose each input coordinate to match the
entry's sign. For a nonzero complex entry
\(A_{i_*j}=|A_{i_*j}|e^{i\theta_j}\), choose
\(x_j=e^{-i\theta_j}\). Then \(A_{i_*j}x_j=|A_{i_*j}|\), so every summand in
the selected row points in the same phase and the row sum is attained.

{{< reference-figure
  wide="true"
  src="row-sum-norm-worked-example.svg"
  alt="For the matrix with rows one minus two and three four, the absolute row sums are three and seven, so the infinity operator norm is seven. The absolute column sums are four and six, and six is marked as the wrong norm. The vector two minus one gives the inequality four is at most fourteen. The vector one one gives output minus one seven and attains equality. A final strip connects submultiplicativity to finite matrix product growth."
  caption="**Worked norm:** the largest absolute row sum is \(7\). The test vector \(x=(2,-1)\) gives \(\lVert Ax\rVert_\infty=4\leq14\). The phase-aligned vector \(x_*=(1,1)\) gives equality \(7=7\cdot1\). Column sums \(4\) and \(6\) are shown as a near-miss because they belong to the induced one-norm convention, not the infinity norm. Patterns distinguish the two rows and the warning without relying on color."
>}}

## Why the inequality always holds

The \(i\)-th output coordinate is

\[
(Ax)_i=\sum_jA_{ij}x_j.
\]

Apply the triangle inequality:

\[
\begin{aligned}
|(Ax)_i|
&\leq\sum_j|A_{ij}|\,|x_j|\\
&\leq\left(\sum_j|A_{ij}|\right)\lVert x\rVert_\infty\\
&\leq\left(\max_k\sum_j|A_{kj}|\right)\lVert x\rVert_\infty.
\end{aligned}
\]

The last quantity is independent of \(i\). Taking the maximum over output
coordinates gives

\[
\lVert Ax\rVert_\infty
\leq\lVert A\rVert_\infty\lVert x\rVert_\infty.
\]

The sign or phase construction above supplies a unit vector that reaches the
maximizing row budget. For finite nonempty coordinate spaces, the row-sum
formula is therefore not merely an upper bound; it equals the induced
operator norm.

{{< reference-figure
  src="induced-infinity-operator-norm.svg"
  alt="A four-stage process takes absolute sizes of matrix entries, adds those sizes within each row, keeps the largest row total, and uses that total to bound the supremum size of every output vector."
  caption="**General mechanism:** absolute values and the triangle inequality turn each row into one amplification budget. The largest budget controls all output coordinates. A phase-matched input shows that this common bound is optimal in finite nonempty dimension."
>}}

## Near-miss: column sums compute a different norm

For the same matrix, the absolute column sums are

\[
c_0=|1|+|3|=4,
\qquad
c_1=|-2|+|4|=6.
\]

Their maximum is \(6\), not \(7\). If one incorrectly declared
\(\lVert A\rVert_\infty=6\), the attaining vector refutes the claimed bound:

\[
\lVert Ax_*\rVert_\infty=7\not\leq6\cdot1.
\]

Maximum absolute **column** sum is the matrix norm induced by the vector
one-norm. Maximum absolute **row** sum is induced by the vector infinity norm.
The two conventions agree for some matrices, but not in general.

## Products multiply worst-case budgets

For compatible matrices,

\[
\lVert AB\rVert_\infty
\leq\lVert A\rVert_\infty\lVert B\rVert_\infty.
\]

Operationally, \(B\) acts first and can amplify by at most
\(\lVert B\rVert_\infty\); \(A\) acts next and can amplify that intermediate
vector by at most \(\lVert A\rVert_\infty\).

For the project's {{< refterm "forward-matrix-product" "forward product" >}}

\[
P_A(k)=A_{k-1}\cdots A_1A_0,
\]

repeated submultiplicativity gives

\[
\lVert P_A(k)\rVert_\infty
\leq\prod_{j=0}^{k-1}\lVert A_j\rVert_\infty
\]

and

\[
\lVert P_A(k)x\rVert_\infty
\leq
\left(\prod_{j=0}^{k-1}\lVert A_j\rVert_\infty\right)
\lVert x\rVert_\infty.
\]

If every factor through horizon \(k\) has norm at most \(C\), then

\[
\lVert P_A(k)x\rVert_\infty\leq C^k\lVert x\rVert_\infty.
\]

For the constant system \(A_j=A\) from the example, this gives

\[
\lVert A^kx\rVert_\infty\leq7^k\lVert x\rVert_\infty.
\]

These are upper envelopes. Cancellation and invariant directions can make
actual growth much smaller.

## The empty-index policy

If the row and column index type is empty, there is one empty vector and one
empty square matrix. The supremum of the empty family of row sums is zero, so

\[
\lVert A\rVert_\infty=0
\]

for that unique matrix. The unique identity matrix equals the unique zero
matrix, and its selected row-sum norm is also zero.

Mathlib's matrix-product and matrix-vector inequalities remain meaningful for
empty finite index types. The project's four normalized finite-product norm
theorems ask for <code>Nonempty ι</code>. That hypothesis supplies positive
dimension and the usual identity normalization
\(\lVert I\rVert_\infty=1\) used by the current proof interface at horizon
zero.

The algebraic definitions of the forward product, its split law, and its
chronological vector action do not require positive dimension.

## In Lean: expose the maximum row-sum formula

The matrix norm notation depends on a scoped instance:

~~~lean
open scoped Matrix.Norms.Operator
~~~

Inside that scope, the following theorem identifies the notation.

{{< lean-bridge
  human="The selected matrix norm is the supremum, over rows, of the sum of entry magnitudes in that row."
  math="\(\displaystyle\lVert A\rVert_\infty=\max_i\sum_j|A_{ij}|.\)"
  lean="Matrix.linfty_opNorm_def A"
>}}

- <code>A</code> is a finite matrix.
- <code>Matrix.Norms.Operator</code> selects the maximum-row-sum norm instance.
- <code>‖A‖</code> is the norm notation under that instance.
- <code>Finset.univ</code> enumerates every finite row and column index.
- <code>Finset.sup</code> selects the largest row total, with value zero when
  the row index type is empty.
- The source theorem uses nonnegative norms internally and coerces the final
  value to \(\mathbb R\).
{{< /lean-bridge >}}

The scope is semantic context, not cosmetic formatting. Matrices admit several
useful norms, and the same notation should not be interpreted without knowing
which instance is active.

## In Lean: bound one matrix-vector action

{{< lean-bridge
  human="Applying A to x cannot amplify the vector supremum norm by more than the maximum absolute row sum."
  math="\(\lVert Ax\rVert_\infty\leq\lVert A\rVert_\infty\lVert x\rVert_\infty.\)"
  lean="Matrix.linfty_opNorm_mulVec A x"
>}}

- <code>A *ᵥ x</code> is Mathlib's matrix-vector multiplication.
- The function-space norm on <code>x</code> is the supremum norm in this
  finite setting.
- The theorem returns an inequality proof for every compatible <code>A</code>
  and <code>x</code>.
- It does not claim equality for every vector. The worked \(x_*\) is a
  separately chosen maximizer.
{{< /lean-bridge >}}

## In Lean: pass the bound through a finite product

{{< lean-bridge
  human="If every factor before time k has infinity norm at most C, the forward product acting on x has norm at most C to the k times the norm of x."
  math="\(\bigl\lVert A_{k-1}\cdots A_0x\bigr\rVert_\infty\leq C^k\lVert x\rVert_\infty.\)"
  lean="NonlinearDynamics.Random.MatrixProducts.linfty_opNorm_forwardProduct_mulVec_le_pow A C k hA x"
>}}

- <code>A : ℕ → Matrix ι ι 𝕜</code> is the time-indexed matrix family.
- <code>k</code> is the finite horizon.
- <code>hA : ∀ j &lt; k, ‖A j‖ ≤ C</code> supplies the one-step bound.
- <code>forwardProduct A k</code> means
  <code>A (k - 1) * ... * A 0</code>, so the newest factor acts on the left.
- The theorem assumes <code>Nonempty ι</code> and a real-or-complex-like
  scalar type through <code>RCLike 𝕜</code>.
{{< /lean-bridge >}}

## Exact source excerpts

**Resource label: pinned Mathlib.** The selected norm formula and its two
fundamental bounds come from the repository's pinned
[<code>Mathlib/Analysis/Matrix/Normed.lean</code>](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Matrix/Normed.lean):

~~~lean
theorem linfty_opNorm_def (A : Matrix m n α) :
    ‖A‖ = ((Finset.univ : Finset m).sup fun i : m => ∑ j : n, ‖A i j‖₊ : ℝ≥0) := by
  change ‖fun i => toLp 1 (A i)‖ = _
  simp [Pi.norm_def, PiLp.nnnorm_eq_of_L1]

theorem linfty_opNorm_mul (A : Matrix l m α) (B : Matrix m n α) :
    ‖A * B‖ ≤ ‖A‖ * ‖B‖ :=
  linfty_opNNNorm_mul _ _

theorem linfty_opNorm_mulVec (A : Matrix l m α) (v : m → α) :
    ‖A *ᵥ v‖ ≤ ‖A‖ * ‖v‖ :=
  linfty_opNNNorm_mulVec _ _
~~~

The use of <code>sup</code> rather than an arbitrarily chosen maximizing row
makes the definition total even when there are no rows.

**Full project check.** This uses the repository's pinned Lean and Mathlib
dependencies and may require substantial disk space and memory.
The project then iterates
submultiplicativity in
[<code>FiniteProducts.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/MatrixProducts/FiniteProducts.lean):

~~~lean
theorem linfty_opNorm_forwardProduct_le_prod (A : ℕ → Matrix ι ι 𝕜) (k : ℕ) :
    ‖forwardProduct A k‖ ≤ ∏ j ∈ Finset.range k, ‖A j‖ := by
  induction k with
  | zero => simp
  | succ k ih =>
      rw [forwardProduct_succ, Finset.prod_range_succ]
      calc
        ‖A k * forwardProduct A k‖ ≤ ‖A k‖ * ‖forwardProduct A k‖ :=
          norm_mul_le _ _
        _ ≤ ‖A k‖ * ∏ j ∈ Finset.range k, ‖A j‖ :=
          mul_le_mul_of_nonneg_left ih (norm_nonneg _)
        _ = (∏ j ∈ Finset.range k, ‖A j‖) * ‖A k‖ := by
          rw [mul_comm]
~~~

The induction follows the definition: the newest factor \(A_k\) is multiplied
on the left, then its norm budget is appended to the scalar product.

## Standalone tutorial: arithmetic worksheet

**Standalone tutorial.** This worksheet imports only
<code>Std</code>. It calculates the integer matrix, row and column sums, two
matrix-vector actions, and the corresponding numerical inequalities. It does
not define Mathlib's norm instance or prove the general theorem.

Save it as <code>InfinityNorm2Scratch.lean</code>:

~~~lean
import Std

structure Matrix2 where
  a00 : Int
  a01 : Int
  a10 : Int
  a11 : Int
deriving Repr

structure Vector2 where
  x0 : Int
  x1 : Int
deriving Repr

def row0Sum (A : Matrix2) : Nat :=
  A.a00.natAbs + A.a01.natAbs

def row1Sum (A : Matrix2) : Nat :=
  A.a10.natAbs + A.a11.natAbs

def column0Sum (A : Matrix2) : Nat :=
  A.a00.natAbs + A.a10.natAbs

def column1Sum (A : Matrix2) : Nat :=
  A.a01.natAbs + A.a11.natAbs

def matrixInfinityNorm (A : Matrix2) : Nat :=
  max (row0Sum A) (row1Sum A)

def vectorInfinityNorm (x : Vector2) : Nat :=
  max x.x0.natAbs x.x1.natAbs

def mulVec (A : Matrix2) (x : Vector2) : Vector2 :=
  { x0 := A.a00 * x.x0 + A.a01 * x.x1
    x1 := A.a10 * x.x0 + A.a11 * x.x1 }

def boundHolds (A : Matrix2) (x : Vector2) : Bool :=
  decide (vectorInfinityNorm (mulVec A x)
    ≤ matrixInfinityNorm A * vectorInfinityNorm x)

def A : Matrix2 :=
  { a00 := 1, a01 := -2, a10 := 3, a11 := 4 }

def test : Vector2 := { x0 := 2, x1 := -1 }
def attainer : Vector2 := { x0 := 1, x1 := 1 }

#eval row0Sum A
#eval row1Sum A
#eval matrixInfinityNorm A
#eval max (column0Sum A) (column1Sum A)
#eval mulVec A test
#eval vectorInfinityNorm (mulVec A test)
#eval boundHolds A test
#eval mulVec A attainer
#eval vectorInfinityNorm (mulVec A attainer)
#eval boundHolds A attainer
~~~

Run it with:

~~~sh
elan run leanprover/lean4:v4.32.0 lean InfinityNorm2Scratch.lean
~~~

The scalar outputs should include row sums \(3,7\), matrix infinity norm \(7\),
column maximum \(6\), output norms \(4\) and \(7\), and <code>true</code> for
both inequality checks. The displayed vectors should be \((4,2)\) and
\((-1,7)\).

## Try the exact declarations in the project

{{< repo-check >}}
**Full project check.** This uses the repository's pinned Lean and Mathlib
dependencies and may require substantial disk space and memory.
Create a temporary project worksheet containing:

~~~lean
import NonlinearDynamics.Random.MatrixProducts.FiniteProducts

open scoped Matrix.Norms.Operator

#check Matrix.linfty_opNorm_def
#check Matrix.linfty_opNorm_mul
#check Matrix.linfty_opNorm_mulVec
#check Matrix.linfty_opNorm_diagonal
#check Matrix.linfty_opNorm_eq_opNorm
#check NonlinearDynamics.Random.MatrixProducts.forwardProduct
#check NonlinearDynamics.Random.MatrixProducts.forwardProduct_zero
#check NonlinearDynamics.Random.MatrixProducts.forwardProduct_succ
#check NonlinearDynamics.Random.MatrixProducts.forwardProduct_add
#check NonlinearDynamics.Random.MatrixProducts.forwardProduct_const
#check NonlinearDynamics.Random.MatrixProducts.linfty_opNorm_forwardProduct_le_prod
#check NonlinearDynamics.Random.MatrixProducts.linfty_opNorm_forwardProduct_le_pow
#check NonlinearDynamics.Random.MatrixProducts.linfty_opNorm_forwardProduct_mulVec_le_prod
#check NonlinearDynamics.Random.MatrixProducts.linfty_opNorm_forwardProduct_mulVec_le_pow
~~~

Each <code>#check</code> asks the pinned elaborator for an exact declaration
type. Opening <code>Matrix.Norms.Operator</code> before the checks makes the
intended norm instance explicit. The full-project command below checks the
complete project source module.
{{< /repo-check >}}

## Compare the nearby matrix norms

For the worked matrix:

| Quantity | Value | Geometry |
|---|---:|---|
| Largest entry magnitude | \(4\) | one entry only |
| Maximum absolute column sum | \(6\) | induced vector one-norm |
| Maximum absolute row sum | \(7\) | induced vector infinity norm |
| Frobenius norm | \(\sqrt{30}\) | Euclidean norm of all four entries |

These are not interchangeable. The {{< refterm "hermitian-frobenius-geometry" "Frobenius norm" >}}
is natural for entrywise Euclidean geometry. The induced infinity norm is
natural when a state is measured by its largest coordinate.

Mathlib also proves that the concrete row-sum norm equals the ordinary operator
norm of the continuous linear map \(x\mapsto Ax\) after the finite function
spaces are equipped with supremum norms. That is the exact sense in which the
row-sum formula is **induced**.

## What product growth does and does not say

The project theorem is deterministic and finite-horizon. It uses a scalar type
with the <code>RCLike</code> interface, covering the real and complex numbers
needed by Mathlib's analytic matrix norm API.

A bound such as

\[
\lVert P_A(k)x\rVert_\infty\leq C^k\lVert x\rVert_\infty
\]

does not by itself prove:

- equality or sharpness of the product bound;
- contraction unless an additional condition such as \(C\lt1\) is supplied;
- a lower growth bound;
- convergence of the matrix product or vector orbit;
- a spectral-radius identity;
- measurability or integrability of random matrix factors;
- existence of an asymptotic growth rate; or
- a Lyapunov exponent or multiplicative ergodic theorem.

These estimates are the finite-time envelope used by later stability and
random-cocycle arguments, not their conclusion.

## Distinctions and failure modes

| Tempting shortcut | What goes wrong | Correct repair |
|---|---|---|
| Add down columns | That gives the induced one-norm, \(6\) in the example | Add across each row, then take the largest row sum |
| Take the largest entry | A row can combine several large contributions | Sum entry magnitudes before maximizing |
| Drop absolute values before summing | Cancellation hides possible phase-aligned amplification | Apply magnitudes term by term |
| Claim every vector attains the norm | Most inputs have slack, as \(x=(2,-1)\) does | Distinguish a uniform bound from a maximizing vector |
| Use \(\lVert A\rVert_\infty=6\) in the example | \(x_*=(1,1)\) gives output norm \(7\) | Check the proposed bound on a phase-aligned input |
| Read <code>‖A‖</code> without its scope | Matrices have multiple norm instances | Open <code>Matrix.Norms.Operator</code> explicitly |
| Assume \(\lVert I\rVert_\infty=1\) for an empty index | The unique empty identity has row-sum norm zero | Separate the empty policy from positive dimension |
| Turn a finite product bound into a Lyapunov theorem | No limit, lower estimate, or ergodic hypothesis was proved | Add the asymptotic probabilistic layer separately |

## Exercises

1. Compute the induced infinity norm of
   \(\bigl[\begin{smallmatrix}2&-1\\-4&0\end{smallmatrix}\bigr]\) and find a
   supremum-norm-one attaining vector.
2. For the worked \(A\), find a nonzero vector whose output amplification is
   strictly less than one.
3. Replace the entries by complex numbers and construct the conjugate-phase
   vector for a chosen maximizing row.
4. Prove the row-sum bound directly for a \(3\times3\) matrix before reading
   the general triangle-inequality derivation.
5. Explain why the empty matrix has norm zero without violating positive
   definiteness of a norm.

## Where to continue

[Ordered Finite Matrix Products and Operator-Norm Growth]({{< relref "/knowledge-base/deep-dives/ordered-finite-matrix-products-and-operator-norm-growth" >}})
derives the product, geometric-power, and vector-orbit bounds from the exact
Lean declarations. The
{{< refterm "forward-matrix-product" "forward matrix product" >}} entry fixes
the chronological multiplication order.

For a deliberately different matrix geometry, read
{{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius geometry" >}}.
[Random Matrices from Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}})
explains how deterministic matrices become values of measurable random
variables. No probability layer appears in the finite-products module itself.

## References

**Mathlib contributors.**
[Norms on finite matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Normed.html),
Mathlib 4 documentation. This official source defines the maximum absolute
row-sum norm, proves its product and matrix-vector inequalities, and identifies
it with the operator norm on finite supremum-norm spaces.

**Roger A. Horn and Charles R. Johnson.**
[Matrix Analysis, second edition](https://www.cambridge.org/highereducation/books/matrix-analysis/FDA3627DC2B9F5C3DF2FD8C3CC136B48),
Cambridge University Press, 2013. Chapter 5 develops induced matrix norms,
attaining vectors, and finite-dimensional norm comparisons.

**W. A. Coppel.**
[Dichotomies in Stability Theory](https://doi.org/10.1007/BFb0067780),
Lecture Notes in Mathematics 629, Springer, 1978. This is classical
motivation for transition-matrix bounds in stability theory; no dichotomy
theorem is claimed here.

**V. I. Oseledets.**
[A multiplicative ergodic theorem. Characteristic Ljapunov exponents of dynamical systems](https://www.mathnet.ru/eng/mmo214),
*Transactions of the Moscow Mathematical Society* 19 (1968), 197-231. This
primary source supplies asymptotic motivation only.

**Nonlinear Dynamics in Lean contributors.**
[FiniteProducts.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/MatrixProducts/FiniteProducts.lean),
the checked project source for ordered products and induced-infinity-norm
growth estimates.

The upstream Mathlib revision audited for this entry is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
pinned by <code>formalization/lake-manifest.json</code>.
