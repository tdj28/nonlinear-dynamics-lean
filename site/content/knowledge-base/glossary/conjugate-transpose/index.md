---
title: "Conjugate transpose"
slug: "conjugate-transpose"
summary: "The conjugate transpose flips a complex matrix across its diagonal and conjugates every entry."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.Basic"
og_image: "conjugate-transpose-card.png"
og_image_alt: "A complex two-by-two matrix is transposed, conjugated, and combined into its conjugate transpose, with product order reversed for adjoints."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
prose, equations, example, diagram, references, and Lean interpretation is
still pending. The page is public as an open working note while that review
remains pending.
{{< /panel >}}

The **conjugate transpose** of a complex matrix combines two familiar moves:
flip the matrix across its main diagonal, then replace every complex entry by
its complex conjugate. It is commonly written \(A^*\), \(A^\dagger\), or
\(A^{\mathrm H}\). This project and Mathlib use the Lean notation
<code>Aᴴ</code>.

## Start with one complex 2 by 2 matrix

Take

\[
A=
\begin{bmatrix}
1&2+i\\
-3i&4
\end{bmatrix}.
\]

First transpose: exchange row and column positions without changing the scalar
values.

\[
A^{\mathsf T}=
\begin{bmatrix}
1&-3i\\
2+i&4
\end{bmatrix}.
\]

Then conjugate each entry. Complex conjugation changes \(i\) to \(-i\), so
\(\overline{-3i}=3i\) and \(\overline{2+i}=2-i\):

\[
A^{\mathrm H}
{} =
\overline{A^{\mathsf T}}
{} =
\begin{bmatrix}
1&3i\\
2-i&4
\end{bmatrix}.
\]

Entry by entry, the rule is

\[
\left(A^{\mathrm H}\right)_{ji}=\overline{A_{ij}},
\]

or, after renaming the two indices,

\[
\left(A^{\mathrm H}\right)_{ij}=\overline{A_{ji}}.
\]

Both displays say the same thing: the entry moves across the diagonal and is
then conjugated.

{{< reference-figure
  wide="true"
  src="flip-and-conjugate.svg"
  alt="The original complex matrix is first transposed, which swaps the two off-diagonal positions without changing their values. Conjugation then changes minus three i to three i and two plus i to two minus i. A lower process shows that the adjoint of a product applies A conjugate transpose before B conjugate transpose, reversing the written factor order."
  caption="**Finding:** starting from \(A=\left[\begin{smallmatrix}1&2+i\\-3i&4\end{smallmatrix}\right]\), transposition moves \(-3i\) to the upper-right cell and \(2+i\) to the lower-left cell without changing either value. Conjugation then sends them to \(3i\) and \(2-i\), giving \(A^{\mathrm H}=\left[\begin{smallmatrix}1&3i\\2-i&4\end{smallmatrix}\right]\). The color and cell position track the same two off-diagonal entries through both operations. The lower path explains the reversed product law: \(AB\) acts by \(B\) then \(A\), while \((AB)^{\mathrm H}=B^{\mathrm H}A^{\mathrm H}\) acts by \(A^{\mathrm H}\) then \(B^{\mathrm H}\)."
>}}

## Transpose, conjugation, and conjugate transpose

The three operations answer different questions.

| Operation | What happens to positions? | What happens to scalar values? | Result for the example |
|---|---|---|---|
| Transpose \(A^{\mathsf T}\) | Swap row and column indices | Leave values unchanged | \(\left[\begin{smallmatrix}1&-3i\\2+i&4\end{smallmatrix}\right]\) |
| Entrywise conjugation \(\overline A\) | Leave positions unchanged | Replace \(i\) by \(-i\) | \(\left[\begin{smallmatrix}1&2-i\\3i&4\end{smallmatrix}\right]\) |
| Conjugate transpose \(A^{\mathrm H}\) | Swap row and column indices | Conjugate every value | \(\left[\begin{smallmatrix}1&3i\\2-i&4\end{smallmatrix}\right]\) |

Transposition and entrywise conjugation commute, so one may conjugate first
and transpose second. Keeping the two stages conceptually separate still
prevents the most common sign and index mistakes.

For a real matrix, complex conjugation changes nothing. Its conjugate
transpose is therefore its ordinary transpose.

## Why multiplication order reverses

Suppose \(A\) and \(B\) have compatible dimensions. Then

\[
(AB)^{\mathrm H}=B^{\mathrm H}A^{\mathrm H}.
\]

The reversal is not cosmetic. Acting on a column vector, \(AB\) means apply
\(B\) first and \(A\) second:

\[
x\longmapsto Bx\longmapsto A(Bx).
\]

The adjoint route reverses those stages:

\[
y\longmapsto A^{\mathrm H}y
\longmapsto B^{\mathrm H}\!\left(A^{\mathrm H}y\right).
\]

The matrix dimensions enforce the same order. If \(A\) is \(m\) by \(n\) and
\(B\) is \(n\) by \(\ell\), then \(B^{\mathrm H}\) is \(\ell\) by \(n\) and
\(A^{\mathrm H}\) is \(n\) by \(m\), so
\(B^{\mathrm H}A^{\mathrm H}\) is \(\ell\) by \(m\), exactly the shape of
\((AB)^{\mathrm H}\). Writing \(A^{\mathrm H}B^{\mathrm H}\) would generally
have the wrong intermediate dimensions.

Two other useful identities are

\[
\left(A^{\mathrm H}\right)^{\mathrm H}=A,
\qquad
(A+B)^{\mathrm H}=A^{\mathrm H}+B^{\mathrm H}.
\]

The first says the operation is an involution: applying it twice returns the
original matrix.

## Hermitian and non-Hermitian boundaries

A matrix is {{< refterm "hermitian-matrix" "Hermitian" >}} precisely when
\(A^{\mathrm H}=A\). The running example is **not** Hermitian. Its
upper-right entry is \(A_{12}=2+i\), but the corresponding entry in
\(A^{\mathrm H}\) is \(3i\). Equivalently,
\(A_{21}=-3i\) is not the conjugate \(2-i\) of \(A_{12}\).

The transformation

\[
A\longmapsto A+A^{\mathrm H}
\]

does produce a Hermitian matrix. For the example,

\[
A+A^{\mathrm H}
{} =
\begin{bmatrix}
2&2+4i\\
2-4i&8
\end{bmatrix}.
\]

The project uses exactly this unnormalized symmetrization for a
{{< refterm "random-matrix" "random matrix" >}}. Dividing by two gives the
usual Hermitian part over \(\mathbb C\), but that factor is not hidden in the
project constructor. In particular, the unnormalized map sends an already
Hermitian matrix \(H\) to \(2H\), not to \(H\).

Do not confuse the conjugate transpose with an inverse. The equality
\(U^{\mathrm H}=U^{-1}\) is an additional unitary condition, not an identity
for every complex matrix.

## In Lean

Mathlib's entrywise theorem is the direct translation of "flip, then
conjugate."

{{< lean-bridge
  human="The entry in row j and column i of the conjugate transpose is the complex conjugate of the entry in row i and column j of the original matrix."
  math="\(\left(A^{\mathrm H}\right)_{ji}=\overline{A_{ij}}.\)"
  lean="Matrix.conjTranspose_apply A i j : Aᴴ j i = star (A i j)"
>}}

- <code>Aᴴ</code> is Mathlib's scoped notation for
  <code>Matrix.conjTranspose A</code>.
- <code>A i j</code> reads the entry in row <code>i</code> and column
  <code>j</code>. Matrices act like two-argument functions in Lean.
- The indices appear as <code>j i</code> on the left because transposition
  swaps their positions.
- <code>star</code> is Mathlib's general scalar involution. On
  <code>ℂ</code>, it is complex conjugation.
- The colon means that
  <code>Matrix.conjTranspose_apply A i j</code> is a proof of the equality
  written after it.
{{< /lean-bridge >}}

### Try the entry arithmetic locally

The project theorem below uses Mathlib's general matrix and complex-number
interfaces. Before loading that machinery, a reader can reproduce the opening
calculation with integer real-and-imaginary pairs. Save this file as
<code>ConjugateTransposeScratch.lean</code> in a scratch directory outside
<code>formalization/</code>:

~~~lean
import Std

structure GaussianInt where
  re : Int
  im : Int
  deriving DecidableEq, Repr

def GaussianInt.conj (z : GaussianInt) : GaussianInt :=
  { re := z.re, im := -z.im }

structure Mat2 where
  a11 : GaussianInt
  a12 : GaussianInt
  a21 : GaussianInt
  a22 : GaussianInt
  deriving DecidableEq, Repr

def Mat2.conjTranspose (M : Mat2) : Mat2 :=
  { a11 := M.a11.conj
    a12 := M.a21.conj
    a21 := M.a12.conj
    a22 := M.a22.conj }

def A : Mat2 :=
  { a11 := { re := 1, im := 0 }
    a12 := { re := 2, im := 1 }
    a21 := { re := 0, im := -3 }
    a22 := { re := 4, im := 0 } }

def AH : Mat2 :=
  { a11 := { re := 1, im := 0 }
    a12 := { re := 0, im := 3 }
    a21 := { re := 2, im := -1 }
    a22 := { re := 4, im := 0 } }

def entries (M : Mat2) : List (Int × Int) :=
  [(M.a11.re, M.a11.im), (M.a12.re, M.a12.im),
   (M.a21.re, M.a21.im), (M.a22.re, M.a22.im)]

#eval entries A.conjTranspose
#eval [decide (A.conjTranspose = AH),
       decide (Mat2.conjTranspose (Mat2.conjTranspose A) = A)]

example : A.conjTranspose = AH := by decide
example : Mat2.conjTranspose (Mat2.conjTranspose A) = A := by decide
~~~

The four pairs list entries in row order as
<code>(real part, imaginary part)</code>. Run the file with exactly:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean ConjugateTransposeScratch.lean
~~~

This exact worksheet was executed successfully with Lean 4.32.0 and printed:

~~~text
[(1, 0), (0, 3), (2, -1), (4, 0)]
[true, true]
~~~

This bounded file imports only <code>Std</code>, so it is suitable for a normal
Mac or Linux machine. It checks the exact four-entry ledger and involution for
this example. It does not import Mathlib, define its general
<code>Matrix.conjTranspose</code>, or prove measurability. Those exact project
obligations use the full project workflow below.

The project's random-matrix foundation contains this exact checked theorem:

~~~lean
theorem measurable_conjTranspose {X : RandomMatrix Ω ι κ ℂ}
    (hX : Measurable X) :
    Measurable fun ω ↦ (X ω)ᴴ := by
  rw [measurable_iff_entries]
  intro j i
  change Measurable (star ∘ fun ω ↦ X ω i j)
  exact continuous_star.measurable.comp (measurable_entry hX i j)
~~~

The proof exposes both parts of the operation. After the transpose, the target
entry has indices <code>j i</code>. It is the composition of the original
coordinate function with <code>star</code>, and complex conjugation is
continuous, hence measurable.

### Full project check

The following scratch file imports the real project module, asks Lean for the
relevant theorem types, and then proves the product and involution identities
by applying those declarations.

~~~lean
import NonlinearDynamics.Random.RandomMatrices.Basic

open scoped Matrix

universe u v w

variable {m : Type u} {n : Type v} {l : Type w} [Fintype n]
variable (A : Matrix m n ℂ) (B : Matrix n l ℂ)

#check Matrix.conjTranspose_apply
#check Matrix.conjTranspose_mul
#check Matrix.conjTranspose_conjTranspose
#check NonlinearDynamics.Random.RandomMatrix.measurable_conjTranspose

example : (A * B)ᴴ = Bᴴ * Aᴴ := by
  exact Matrix.conjTranspose_mul A B

example : (Aᴴ)ᴴ = A := by
  exact Matrix.conjTranspose_conjTranspose A
~~~

The <code>open scoped Matrix</code> line enables the postfix
<code>ᴴ</code> notation. The three types <code>m</code>, <code>n</code>, and
<code>l</code> keep the rectangular dimensions visible. The
<code>[Fintype n]</code> assumption makes the shared multiplication index
finite, which matrix multiplication needs here.

{{< repo-check >}}
The authoritative project source is
[formalization/NonlinearDynamics/Random/RandomMatrices/Basic.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/Basic.lean).
The worksheet above is pedagogical; the quoted
<code>measurable_conjTranspose</code> declaration is the exact checked project
source. Put the worksheet in a temporary <code>.lean</code> file inside a clone
with the repository's pinned dependencies
installed. The full-project command
below checks the authoritative module itself.
{{< /repo-check >}}

## Boundaries and nonclaims

- Conjugate transpose is not entrywise conjugation alone and is not transpose
  alone when entries are genuinely complex.
- The factor order in \((AB)^{\mathrm H}\) must reverse. The operation is an
  adjoint-like anti-homomorphism, not an order-preserving multiplication map.
- The condition \(A^{\mathrm H}=A\) defines Hermitian matrices. It does not
  define unitary matrices, which instead satisfy inverse identities involving
  \(A^{\mathrm H}\).
- The map \(A\mapsto A+A^{\mathrm H}\) is unnormalized. It proves Hermiticity
  of the output but does not preserve an already Hermitian input.
- Measurability of \(\omega\mapsto X(\omega)^{\mathrm H}\) follows from
  measurability of \(X\). It does not by itself choose a probability law or
  prove independence or integrability.

## Where to continue

The {{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}
uses conjugation on the reflected lower triangle so each free complex
coordinate is supplied once. The
{{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius geometry" >}}
uses \(A^{\mathrm H}B\) in its inner-product formulas. The
{{< refterm "unitary-invariance" "unitary-invariance" >}} page explains why
congruence by \(U\) uses \(UAU^{\mathrm H}\).

## Further reading

Mathlib's
[conjugate-transpose source](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/ConjTranspose.html)
documents the entry rule, involution, and reversed-product theorem. Its
[Hermitian-matrix module](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html)
uses conjugate transpose in the core fixed-point definition.
