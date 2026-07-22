---
title: "Forward matrix product"
slug: "forward-matrix-product"
summary: "A forward matrix product composes a time-indexed sequence so the earliest factor acts first on a column vector, the newest factor is written on the left, and the empty horizon is the identity."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.MatrixProducts.FiniteProducts"
og_image: "forward-matrix-product-card.png"
og_image_alt: "A shear followed by a stretch sends zero-one to two-one, while reversing the matrix order sends it to one-one; the newest chronological factor is written on the left."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

A **forward matrix product** packages a finite history of linear updates into
one matrix. For a sequence of square matrices
\(A_0,A_1,A_2,\ldots\), this project writes

\[
P_A(k)=A_{k-1}\cdots A_1A_0
\]

when \(k\) is positive, and sets \(P_A(0)=I\). The convention is designed for
column vectors. Starting from \(x_0=x\), the recurrence

\[
x_{j+1}=A_jx_j
\]

gives \(x_k=P_A(k)x\). The earliest matrix acts first, even though it appears
furthest to the right in the written product. The newest matrix acts last and
therefore appears on the left.

That reversal between reading order and action order is the central fact to
remember. It follows from composition, not from a typographical preference.
Transition and fundamental matrices in finite-dimensional linear dynamics use
the same chronological logic ([Coppel](#ref-forward-coppel)).

{{< reference-figure
  src="forward-matrix-product.svg"
  alt="An initial column state passes first through the earliest matrix action, then the next action, and finally the newest action. A lower note says that the written product places the newest factor on the left even though time flows from earliest to newest."
  caption="**Finding:** action time flows from the initial state through the earliest factor toward the newest factor. Matrix notation records the same composition with the newest factor on the left. Keeping those two views together prevents accidental reversal of a noncommutative product."
>}}

## The first four horizons

The safest way to learn the convention is to expand the first few cases:

\[
\begin{aligned}
P_A(0)&=I,\\
P_A(1)&=A_0,\\
P_A(2)&=A_1A_0,\\
P_A(3)&=A_2A_1A_0.
\end{aligned}
\]

Applied to a column vector \(x\), these become

\[
\begin{aligned}
P_A(0)x&=x,\\
P_A(1)x&=A_0x,\\
P_A(2)x&=A_1(A_0x),\\
P_A(3)x&=A_2(A_1(A_0x)).
\end{aligned}
\]

The horizon \(k\) counts **factors**, not the largest time index. Thus
\(P_A(3)\) uses the factors with indices \(0,1,2\). This zero-based convention
matches the natural-number recursion used in Lean.

The empty product must be the identity. It makes the state at time zero equal
to its initial value, makes concatenation valid when either block is empty,
and makes a constant family agree with the zeroth matrix power.

## The defining recursion

The project defines the product recursively:

~~~lean
def forwardProduct (A : ℕ → Matrix ι ι 𝕜) : ℕ → Matrix ι ι 𝕜
  | 0 => 1
  | k + 1 => A k * forwardProduct A k
~~~

The successor equation says to prepend the newest factor:

\[
P_A(k+1)=A_kP_A(k).
\]

This direction matters because matrices generally do not commute. Replacing
the right side by \(P_A(k)A_k\) would define a different product and would
reverse chronological action on column vectors.

Only modest algebra is needed. The index type \(\iota\) is finite and has
decidable equality so that matrix multiplication is a finite sum. The scalar
type \(\mathbb K\) is a semiring, which supplies zero, one, addition,
multiplication, distributivity, and associativity. The definition does not
need subtraction, division, an order, a topology, a norm, or probability.

The index type may be empty. There is still one empty square matrix, and its
identity and multiplication are well-defined. Empty dimension becomes a
separate issue only when a normalized operator norm is requested.

## Splitting a history after a chosen time

Let the first block contain \(m\) steps and the second contain \(k\) steps.
Define the shifted sequence by

\[
A^{(m)}_j=A_{m+j}.
\]

Then the checked split law is

\[
P_A(m+k)=P_{A^{(m)}}(k)P_A(m).
\]

The earlier block is on the right because it acts first. The later, shifted
block is on the left because it acts second. For example, taking \(m=2\) and
\(k=3\) gives

\[
\begin{aligned}
P_A(5)
&=A_4A_3A_2A_1A_0\\
&=(A_4A_3A_2)(A_1A_0)\\
&=P_{A^{(2)}}(3)P_A(2).
\end{aligned}
\]

This is the discrete-time analogue of composing a transition from time zero
to time \(m\) with a transition from time \(m\) to time \(m+k\). It is also the
finite algebraic skeleton of a cocycle law. The current module does not define
a base dynamical system or prove a random-cocycle theorem.

## Constant systems recover powers

If every factor is the same matrix \(B\), the nonautonomous product reduces to
an ordinary power:

\[
P_{j\mapsto B}(k)=B^k.
\]

The first cases agree:

\[
I=B^0,\qquad B=B^1,\qquad BB=B^2.
\]

If every factor is the identity, every forward product is the identity. These
facts are calibration tests. They show that the time-dependent definition
extends the familiar autonomous iteration \(x_{j+1}=Bx_j\).

## A two-dimensional example where order matters

Consider

\[
A_0=
\begin{bmatrix}
1&1\\
0&1
\end{bmatrix},
\qquad
A_1=
\begin{bmatrix}
2&0\\
0&1
\end{bmatrix},
\qquad
x=
\begin{bmatrix}
0\\
1
\end{bmatrix}.
\]

The first update shears the vector:

\[
A_0x=
\begin{bmatrix}
1\\
1
\end{bmatrix}.
\]

The second update stretches its first coordinate:

\[
A_1(A_0x)=
\begin{bmatrix}
2\\
1
\end{bmatrix}.
\]

Accordingly, \(P_A(2)=A_1A_0\). Reversing the factors gives

\[
A_0(A_1x)=
\begin{bmatrix}
1\\
1
\end{bmatrix},
\]

which is different. A harmless-looking order reversal therefore changes the
dynamics.

{{< reference-figure
  wide="true"
  src="shear-then-stretch.svg"
  alt="The column vector zero one first passes through a shear matrix and becomes one one, then passes through a horizontal stretch and becomes two one. The forward product is the stretch times the shear. A lower comparison applies the stretch first, obtaining zero one, then the shear, obtaining one one, so the reversed product is different."
  caption="**Finding:** chronological action runs \(x\to A_0x\to A_1A_0x\), while written matrix multiplication places the newest factor \(A_1\) on the left. The reversed product \(A_0A_1\) sends the same vector somewhere else."
>}}

## The checked Lean interface

{{< lean-bridge
  human="At the next time step, put the newest matrix on the left of the product already accumulated."
  math="\(P_A(k+1)=A_kP_A(k),\qquad P_A(0)=I.\)"
  lean="forwardProduct A (k + 1) = A k * forwardProduct A k"
>}}

- <code>forwardProduct</code> is the project definition for this precise
  order convention.
- <code>A : ℕ → Matrix ι ι 𝕜</code> is a time-indexed family of square
  matrices.
- <code>k + 1</code> is the successor horizon. It counts \(k+1\) factors,
  whose indices run from \(0\) through \(k\).
- <code>A k</code> is the newest factor at that horizon.
- <code>*</code> is matrix multiplication. Its order is meaningful because
  this multiplication generally does not commute.
- <code>forwardProduct A k</code> is the earlier block, placed on the right so
  it acts first on a column vector.
- The zero branch lives in the definition as
  <code>forwardProduct A 0 = 1</code>; here <code>1</code> is the identity
  matrix.
{{< /lean-bridge >}}

The algebraic part of the module publishes nine declarations:

| Declaration | Meaning |
|---|---|
| <code>forwardProduct</code> | Defines the ordered product at every natural horizon |
| <code>forwardProduct_zero</code> | The zero-horizon product is the identity |
| <code>forwardProduct_succ</code> | The newest factor is prepended on the left |
| <code>forwardProduct_add</code> | Splits a history into a shifted later block and an earlier block |
| <code>forwardProduct_one</code> | The one-step product is the time-zero factor |
| <code>forwardProduct_const</code> | A constant sequence gives ordinary matrix powers |
| <code>forwardProduct_const_one</code> | An identity sequence stays at the identity |
| <code>forwardProduct_mulVec_zero</code> | The zero-horizon product fixes every column vector |
| <code>forwardProduct_mulVec_succ</code> | Product action is chronological iteration |

The last theorem uses Mathlib's compatibility between matrix multiplication
and matrix-vector multiplication, <code>Matrix.mulVec_mulVec</code>
([Mathlib contributors](#ref-forward-mathlib-mul)). It turns the matrix
recursion directly into the state recursion.

### Type the noncommutative example locally

This worksheet models two-by-two integer matrices and column vectors with
<code>Std</code> only. Save it as <code>ForwardProductTutorial.lean</code>:

~~~lean
import Std

structure Mat2 where
  a00 : Int
  a01 : Int
  a10 : Int
  a11 : Int
deriving Repr, DecidableEq

structure Vec2 where
  x0 : Int
  x1 : Int
deriving Repr, DecidableEq

def Mat2.mul (A B : Mat2) : Mat2 :=
  { a00 := A.a00 * B.a00 + A.a01 * B.a10
    a01 := A.a00 * B.a01 + A.a01 * B.a11
    a10 := A.a10 * B.a00 + A.a11 * B.a10
    a11 := A.a10 * B.a01 + A.a11 * B.a11 }

def Mat2.mulVec (A : Mat2) (x : Vec2) : Vec2 :=
  { x0 := A.a00 * x.x0 + A.a01 * x.x1
    x1 := A.a10 * x.x0 + A.a11 * x.x1 }

def shear : Mat2 :=
  { a00 := 1, a01 := 1, a10 := 0, a11 := 1 }

def stretch : Mat2 :=
  { a00 := 2, a01 := 0, a10 := 0, a11 := 1 }

def initial : Vec2 := { x0 := 0, x1 := 1 }

#eval shear.mulVec initial
#eval stretch.mulVec (shear.mulVec initial)
#eval shear.mulVec (stretch.mulVec initial)
#eval stretch.mul shear
#eval shear.mul stretch

example : stretch.mulVec (shear.mulVec initial) =
    { x0 := 2, x1 := 1 } := by decide
example : shear.mulVec (stretch.mulVec initial) =
    { x0 := 1, x1 := 1 } := by decide
example : stretch.mul shear ≠ shear.mul stretch := by decide
~~~

Run it with the installed pinned toolchain:

~~~sh
elan run leanprover/lean4:v4.32.0 lean ForwardProductTutorial.lean
~~~

The first three outputs are \((1,1)\), \((2,1)\), and \((1,1)\). The last
two outputs are distinct matrix products. The kernel-certified examples then
make both trajectories and noncommutativity explicit. This miniature checks
the finite arithmetic and order convention, not Mathlib's generic matrix API.

{{< repo-check >}}
The authoritative source is
[<code>formalization/NonlinearDynamics/Random/MatrixProducts/FiniteProducts.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/MatrixProducts/FiniteProducts.lean).
On an approved Linux builder, a human can type:

~~~lean
import NonlinearDynamics.Random.MatrixProducts.FiniteProducts

#check NonlinearDynamics.Random.MatrixProducts.forwardProduct
#check NonlinearDynamics.Random.MatrixProducts.forwardProduct_zero
#check NonlinearDynamics.Random.MatrixProducts.forwardProduct_succ
#check NonlinearDynamics.Random.MatrixProducts.forwardProduct_add
#check NonlinearDynamics.Random.MatrixProducts.forwardProduct_const
#check NonlinearDynamics.Random.MatrixProducts.forwardProduct_mulVec_succ
~~~

These checks expose the definition, identity horizon, successor order, block
split, constant-sequence calibration, and chronological vector action. The
guarded command below checks the pinned project module and Mathlib dependencies
in the cloud.
{{< /repo-check >}}

## What the definition does not say

The phrase *forward product* fixes an order and an empty-product convention. It
does not by itself say that the factors are random, measurable, independent,
stationary, invertible, or identically distributed. It does not supply a base
flow, a cocycle over that flow, or an infinite product.

It also makes no growth claim. A product may expand some vectors, contract
others, or alternate between both behaviors. The companion
{{< refterm "induced-infinity-operator-norm" "induced infinity operator norm" >}}
entry explains one finite-horizon upper-bound mechanism. Such an upper bound
is not automatically an equality, a sharp rate, a Lyapunov exponent, or a
stability theorem.

In nonlinear dynamics, products of derivative matrices describe linearized
perturbation propagation along an orbit. That application motivates the
interface, but the present Lean module contains no differentiable map, no
Jacobian identification, and no theorem connecting a nonlinear orbit to this
matrix sequence.

Random products are another major destination. Oseledets' multiplicative
ergodic theorem classically organizes long-time exponential growth rates under
substantial dynamical and integrability hypotheses
([Oseledets](#ref-forward-oseledets)). Nothing in the finite recursive
definition proves those hypotheses or conclusions.

## Exercises

1. Expand \(P_A(4)x\) with parentheses showing chronological action.
2. Check the split law for \(m=1\) and \(k=3\) by writing every factor.
3. Explain why \(P_A(m+k)=P_A(m)P_{A^{(m)}}(k)\) is generally false.
4. For the matrices in the worked example, compute both \(A_1A_0\) and
   \(A_0A_1\).
5. Prove on paper by induction that a constant family gives \(B^k\). Identify
   why the successor-power convention must match left multiplication.
6. Describe the unique forward product when the matrix index type is empty.
   Which parts of the algebraic interface still make sense?

## Where to continue

[Ordered Finite Matrix Products and Operator-Norm Growth]({{< relref "/knowledge-base/deep-dives/ordered-finite-matrix-products-and-operator-norm-growth" >}})
develops all thirteen public declarations in the module, including the exact
assumption ledger and finite-horizon product, power, and orbit bounds.

The next checked layer evaluates the factors at one outcome, proves exact
finite-prefix measurability, and forms a pushforward law. Begin with the
{{< refterm "finite-random-matrix-product" "finite random-matrix product" >}}
entry, then climb
[Measurable Finite Random-Matrix Products and Proof-Carrying Pushforward Laws]({{< relref "/knowledge-base/deep-dives/measurable-finite-random-matrix-products-and-pushforward-laws" >}}).

Read the
{{< refterm "induced-infinity-operator-norm" "induced infinity operator norm" >}}
entry before interpreting those bounds. The
{{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius geometry" >}}
entry explains a different, entrywise Euclidean matrix norm. The earlier
[Finite Product Probability Spaces and Independent Gaussian Fields]({{< relref "/knowledge-base/deep-dives/finite-product-probability-spaces-and-independent-gaussian-fields" >}})
uses *product* for a product probability measure. That commutative measure
construction should not be confused with an ordered, generally
noncommutative matrix product.

## References

<a id="ref-forward-mathlib-mul"></a>**Mathlib contributors.**
[Matrix-vector multiplication](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/Matrix/Mul.html),
Mathlib 4 documentation. This official interface supplies the compatibility
between matrix multiplication and successive action on a column vector.

<a id="ref-forward-coppel"></a>**W. A. Coppel.**
[Dichotomies in Stability Theory](https://doi.org/10.1007/BFb0067780),
Lecture Notes in Mathematics, Springer, 1978. This monograph supplies the
classical stability motivation for transition matrices and products in linear
evolution problems. The page's exact indexing convention is fixed by the Lean
definition above.

<a id="ref-forward-oseledets"></a>**V. I. Oseledets.**
[A multiplicative ergodic theorem. Characteristic Ljapunov exponents of dynamical systems](https://www.mathnet.ru/eng/mmo214),
*Transactions of the Moscow Mathematical Society* 19 (1968), 197-231. This
primary source identifies the long-time random-dynamical destination. Its
ergodic hypotheses and asymptotic conclusions are not formalized in the
finite-product module.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
