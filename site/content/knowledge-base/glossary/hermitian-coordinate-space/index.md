---
title: "Hermitian coordinate space"
slug: "hermitian-coordinate-space"
summary: "A minimal coordinate system for Hermitian matrices: real diagonal entries and complex strict-upper entries assemble the whole matrix without duplicated lower-triangle data."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.HermitianCoordinates"
og_image: "hermitian-coordinate-space-card.png"
og_image_alt: "Three real diagonal and three complex upper-triangle coordinates assemble a three-by-three Hermitian matrix, recover exactly, and total nine real degrees of freedom."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working note. Human review of the
mathematics, Lean interpretation, sources, figures, and accessibility remains
pending. The page is public so readers can follow the work while that review
is still open.
{{< /panel >}}

A **Hermitian coordinate space** records exactly the entries of a finite
complex {{< refterm "hermitian-matrix" "Hermitian matrix" >}} that can be
chosen freely:

- one **real** number at every diagonal position; and
- one **complex** number at every position strictly above the diagonal.

Nothing is independently chosen below the diagonal. Hermitian symmetry fills
that entry by conjugating its reflected partner above the diagonal.

This is bookkeeping before probability enters. The coordinate space alone
does not say that the coordinates are random, Gaussian, independent, or
normalized in any particular way.

{{< reference-figure
  src="hermitian-coordinate-space.svg"
  alt="A three by three matrix grid separates freely supplied real diagonal positions, freely supplied complex strict-upper positions, and lower positions determined by conjugate reflection."
  caption="**Structural preview:** green diagonal slots and blue strict-upper slots are the primitive inputs. Orange lower slots are consequences, not another input family. This separation makes Hermitian symmetry true by construction while leaving every probability and scaling choice for a later layer."
>}}

## Start with one actual \(3\times3\) matrix

Use row and column labels \(0,1,2\). Supply the three real diagonal
coordinates

\[
d_0=2,
\qquad
d_1=-1,
\qquad
d_2=4,
\]

and the three complex strict-upper coordinates

\[
u_{01}=1+2i,
\qquad
u_{02}=-3+i,
\qquad
u_{12}=5-2i.
\]

The phrase **strict upper** means that the row index is smaller than the
column index. For size three, the complete list is

\[
(0,1),\ (0,2),\ (1,2).
\]

There are no other strict-upper positions.

Insert those six supplied coordinate objects into a matrix. Reflect each
upper entry across the diagonal and conjugate it:

\[
H=
\begin{bmatrix}
2 & 1+2i & -3+i\\
1-2i & -1 & 5-2i\\
-3-i & 5+2i & 4
\end{bmatrix}.
\]

For example,

\[
H_{10}=\overline{H_{01}}=\overline{1+2i}=1-2i,
\]

and

\[
H_{21}=\overline{H_{12}}=\overline{5-2i}=5+2i.
\]

The diagonal entries are already real, so conjugating them changes nothing.
Every entry therefore satisfies

\[
H_{ji}=\overline{H_{ij}},
\]

which is the entrywise form of \(H^*=H\).

## Recover the coordinates without solving anything

Read the diagonal and strict upper triangle of the assembled matrix:

\[
\begin{aligned}
(H_{00},H_{11},H_{22})&=(2,-1,4),\\
(H_{01},H_{02},H_{12})&=(1+2i,-3+i,5-2i).
\end{aligned}
\]

These are exactly the supplied \(d\)- and \(u\)-coordinates. Recovery needs
no averaging, division, or rescaling. The project currently exposes this
fact through separate diagonal and upper-entry simplification theorems. It
does not yet package the recovery operation and assembly as a named
equivalence.

{{< reference-figure
  wide="true"
  src="hermitian-n3-round-trip.svg"
  alt="Three real diagonal values two, minus one, and four and three complex strict-upper values one plus two i, minus three plus i, and five minus two i assemble a three by three Hermitian matrix. The diagonal and upper entries recover those values. A lower value seven plus i chosen independently conflicts with the required conjugate one minus two i."
  caption="**Worked round trip:** three real diagonal values and three complex upper values supply \(3+2\cdot3=9\) real degrees of freedom. Conjugate reflection fills the lower triangle. Reading the diagonal and strict upper triangle recovers every input unchanged. The red near-miss shows why an independently chosen lower entry is not extra freedom: unless it equals the required conjugate, the matrix is not Hermitian. Patterns distinguish the three matrix roles without relying on color."
>}}

## Count the real degrees of freedom

For an \(n\times n\) matrix, there are \(n\) diagonal positions. Each stores
one real degree of freedom.

There are

\[
\binom n2=\frac{n(n-1)}2
\]

strict-upper positions. Each stores a complex number, hence two real degrees
of freedom. The total is

\[
\begin{aligned}
n+2\binom n2
&=n+n(n-1)\\
&=n^2.
\end{aligned}
\]

For \(n=3\), this is

\[
3+2\cdot3=9.
\]

The six named inputs in the example are not six real numbers. Three are real
and three are complex, so they contain \(3+6=9\) real scalar components.
This matches the real dimension of the vector space of \(3\times3\) complex
Hermitian matrices.

The dimension count is mathematical context for the representation. The
current project module defines the coordinate type and forward assembler, but
does not yet prove a named real-dimension theorem.

## Near-miss: counting the lower triangle twice

Suppose someone records the diagonal as real but treats all six off-diagonal
positions as independent complex inputs. The storage count becomes

\[
3+2\cdot6=15
\]

real scalar slots instead of \(9\).

This creates two possible failures:

1. If the lower values are genuinely independent choices, the result is
   usually not Hermitian. In the example, choosing
   \(\ell_{10}=7+i\) conflicts with
   \(\overline{u_{01}}=1-2i\).
2. If constraints \(\ell_{ji}=\overline{u_{ij}}\) are imposed afterward, the
   representation can describe a Hermitian matrix, but it stores six
   redundant real scalar components and carries extra consistency proofs.

The lower triangle is not missing data. It is already encoded in the upper
triangle.

There is another tempting construction. Start with an upper-triangular matrix
\(X\) and form \(X+X^*\). This always produces a Hermitian matrix, but if the
diagonal of \(X\) is the supplied real vector \(d\), then

\[
(X+X^*)_{ii}=d_i+\overline{d_i}=2d_i.
\]

The diagonal has been doubled. Dividing the whole result by two would also
halve the supplied upper entries. The project's direct three-branch
assembler inserts every coordinate unchanged and keeps later normalization
choices visible.

## The abstract coordinate space

Let

\[
I_n^{\lt}
=\{(i,j):0\leq i\lt n,\ 0\leq j\lt n,\ i\lt j\}.
\]

The project uses

\[
\mathcal C_n
{}=
(\{0,\ldots,n-1\}\to\mathbb R)
\times
(I_n^{\lt}\to\mathbb C).
\]

A point \(x=(d,u)\in\mathcal C_n\) is a pair of functions. The first function
answers, "what real value belongs at diagonal index \(i\)?" The second
answers, "what complex value belongs at strict-upper pair \((i,j)\)?"

The adjective **strict** matters. If the upper index set also contained the
diagonal, those diagonal coordinates would be complex and an extra condition
would be needed to force their imaginary parts to zero. A separate real
diagonal makes the constraint true by the type itself.

## In Lean: the coordinate point

{{< lean-bridge
  human="A size-three coordinate point is a real diagonal function paired with a complex strict-upper function."
  math="\((d,u)\in(\{0,1,2\}\to\mathbb R)\times(I_3^{\lt}\to\mathbb C).\)"
  lean="x : NonlinearDynamics.Random.HermitianCoordinateSpace 3"
>}}

- <code>x</code> is a human-chosen name for the whole coordinate point.
- <code>3</code> fixes three row and column labels, represented by
  <code>Fin 3</code>.
- <code>HermitianCoordinateSpace 3</code> abbreviates a product. Its first
  projection <code>x.1</code> has type <code>Fin 3 → ℝ</code>.
- Its second projection <code>x.2</code> has type
  <code>StrictUpperIndex 3 → ℂ</code>.
- A value of <code>StrictUpperIndex 3</code> contains both a pair of finite
  indices and evidence that the first is strictly smaller than the second.
{{< /lean-bridge >}}

The exact project definitions are short enough to read directly:

~~~lean
def StrictUpperIndex (n : ℕ) := {ij : Fin n × Fin n // ij.1 < ij.2}

abbrev HermitianCoordinateSpace (n : ℕ) :=
  (Fin n → ℝ) × (StrictUpperIndex n → ℂ)
~~~

In the first line, braces form a subtype: a pair <code>ij</code> is admitted
only together with a proof of <code>ij.1 &lt; ij.2</code>. That proof prevents a
diagonal or lower pair from being used as an upper-coordinate key.

## In Lean: assemble and certify Hermiticity

On paper, the assembly rule is

\[
H_{ij}=
\begin{cases}
u_{ij}, & i\lt j,\\
\overline{u_{ji}}, & j\lt i,\\
d_i, & i=j.
\end{cases}
\]

The three branches are exhaustive and disjoint. Lean implements exactly this
case split.

{{< lean-bridge
  human="Assemble d and u, then use the checked theorem saying that the resulting matrix is Hermitian for every input."
  math="\(H=\operatorname{assemble}(d,u)\Longrightarrow H^*=H.\)"
  lean="hH : (NonlinearDynamics.Random.RandomMatrix.hermitianFromCoordinates d u).IsHermitian := NonlinearDynamics.Random.RandomMatrix.hermitianFromCoordinates_isHermitian d u"
>}}

- <code>hH</code> is the name given to the resulting proof.
- <code>hermitianFromCoordinates d u</code> is the assembled matrix.
- <code>.IsHermitian</code> is the proposition that the matrix equals its
  {{< refterm "conjugate-transpose" "conjugate transpose" >}}.
- <code>:=</code> separates the claimed type from the term proving it.
- <code>hermitianFromCoordinates_isHermitian d u</code> supplies that proof;
  it has no probability, measurability, or normalization hypothesis.
{{< /lean-bridge >}}

## Exact project excerpts

**Resource label: pinned project plus Mathlib.** The authoritative source is
[<code>formalization/NonlinearDynamics/Random/RandomMatrices/HermitianCoordinates.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/HermitianCoordinates.lean).
The checked assembler is:

~~~lean
def hermitianFromCoordinates {n : ℕ} (d : Fin n → ℝ)
    (u : StrictUpperIndex n → ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  fun i j ↦
    if hij : i < j then
      u ⟨(i, j), hij⟩
    else if hji : j < i then
      star (u ⟨(j, i), hji⟩)
    else
      d i
~~~

Read the nested conditional from top to bottom:

1. if \(i\lt j\), use the supplied upper coordinate;
2. otherwise, if \(j\lt i\), reverse the index pair and apply
   <code>star</code>, which is complex conjugation here; and
3. otherwise the indices are equal, so use the real diagonal value, coerced
   into \(\mathbb C\) by the expected matrix-entry type.

The exact lower-entry recovery theorem is:

~~~lean
@[simp]
theorem hermitianFromCoordinates_apply_lower {n : ℕ} (d : Fin n → ℝ)
    (u : StrictUpperIndex n → ℂ) {i j : Fin n} (hji : j < i) :
    hermitianFromCoordinates d u i j = star (u ⟨(j, i), hji⟩) := by
  have hnot : ¬ i < j := not_lt_of_ge (le_of_lt hji)
  simp [hermitianFromCoordinates, hji, hnot]
~~~

The proof first rules out the upper branch, then simplifies the definition to
the reflected conjugate branch. Its hypothesis <code>hji : j &lt; i</code> is
the typed evidence that the requested entry lies below the diagonal.

The pointwise Hermiticity theorem is:

~~~lean
theorem hermitianFromCoordinates_isHermitian {n : ℕ} (d : Fin n → ℝ)
    (u : StrictUpperIndex n → ℂ) :
    (hermitianFromCoordinates d u).IsHermitian := by
  rw [Matrix.IsHermitian.ext_iff]
  intro i j
  rcases lt_trichotomy i j with hij | rfl | hji
  · rw [hermitianFromCoordinates_apply_upper d u hij]
    rw [hermitianFromCoordinates_apply_lower d u hij]
    simp
  · simp
  · rw [hermitianFromCoordinates_apply_lower d u hji]
    rw [hermitianFromCoordinates_apply_upper d u hji]
~~~

The three goals correspond to upper, diagonal, and lower positions. This is a
direct proof of the same trichotomy visible in the diagrams.

## Tiny local Lean/Std coordinate worksheet

**Resource label: tiny standalone check.** This worksheet imports only
<code>Std</code>. It models the concrete size-three ledger with rational real
and imaginary parts. It checks the arithmetic, reflection, degree count, and
round trip, but it does not import Mathlib or prove the project's matrix
theorem.

Save this as <code>HermitianCoordinates3Scratch.lean</code>:

~~~lean
import Std

structure ComplexRat where
  re : Rat
  im : Rat
deriving Repr, BEq

def ComplexRat.conj (z : ComplexRat) : ComplexRat :=
  { re := z.re, im := -z.im }

def ComplexRat.ofReal (x : Rat) : ComplexRat :=
  { re := x, im := 0 }

structure Coordinates3 where
  d0 : Rat
  d1 : Rat
  d2 : Rat
  u01 : ComplexRat
  u02 : ComplexRat
  u12 : ComplexRat
deriving Repr, BEq

structure Matrix3 where
  a00 : ComplexRat
  a01 : ComplexRat
  a02 : ComplexRat
  a10 : ComplexRat
  a11 : ComplexRat
  a12 : ComplexRat
  a20 : ComplexRat
  a21 : ComplexRat
  a22 : ComplexRat
deriving Repr

def assemble (c : Coordinates3) : Matrix3 :=
  { a00 := ComplexRat.ofReal c.d0
    a01 := c.u01
    a02 := c.u02
    a10 := c.u01.conj
    a11 := ComplexRat.ofReal c.d1
    a12 := c.u12
    a20 := c.u02.conj
    a21 := c.u12.conj
    a22 := ComplexRat.ofReal c.d2 }

def recover (A : Matrix3) : Coordinates3 :=
  { d0 := A.a00.re
    d1 := A.a11.re
    d2 := A.a22.re
    u01 := A.a01
    u02 := A.a02
    u12 := A.a12 }

def strictUpperCount (n : Nat) : Nat :=
  n * (n - 1) / 2

def realDegreesOfFreedom (n : Nat) : Nat :=
  n + 2 * strictUpperCount n

def exampleCoordinates : Coordinates3 :=
  { d0 := 2, d1 := -1, d2 := 4
    u01 := { re := 1, im := 2 }
    u02 := { re := -3, im := 1 }
    u12 := { re := 5, im := -2 } }

#eval realDegreesOfFreedom 3
#eval (assemble exampleCoordinates).a10
#eval (assemble exampleCoordinates).a21
#eval recover (assemble exampleCoordinates) == exampleCoordinates
~~~

Run it with:

~~~sh
elan run leanprover/lean4:v4.32.0 lean HermitianCoordinates3Scratch.lean
~~~

The outputs should report \(9\), then the conjugates \(1-2i\) and \(5+2i\)
as structures with rational <code>re</code> and <code>im</code> fields, then
<code>true</code> for the recovered-coordinate comparison.

## Try the exact declarations in the project

{{< repo-check >}}
**Resource label: pinned project plus Mathlib.** A human can type the following
worksheet in a deliberately provisioned copy of the repository:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.HermitianCoordinates

#check NonlinearDynamics.Random.StrictUpperIndex
#check NonlinearDynamics.Random.HermitianCoordinateSpace
#check NonlinearDynamics.Random.StrictUpperIndex.instFintype
#check NonlinearDynamics.Random.StrictUpperIndex.instDecidableEq
#check NonlinearDynamics.Random.RandomMatrix.hermitianFromCoordinates
#check NonlinearDynamics.Random.RandomMatrix.hermitianFromCoordinates_apply_diag
#check NonlinearDynamics.Random.RandomMatrix.hermitianFromCoordinates_apply_upper
#check NonlinearDynamics.Random.RandomMatrix.hermitianFromCoordinates_apply_lower
#check NonlinearDynamics.Random.RandomMatrix.hermitianFromCoordinates_isHermitian
#check NonlinearDynamics.Random.RandomMatrix.measurable_hermitianFromCoordinates
#check NonlinearDynamics.Random.RandomMatrix.hermitianCoordinateMap
#check NonlinearDynamics.Random.RandomMatrix.measurable_hermitianCoordinateMap
#check NonlinearDynamics.Random.RandomMatrix.hermitianFromCoordinates_zero
#check NonlinearDynamics.Random.RandomMatrix.hermitianCoordinateMap_zero
#check NonlinearDynamics.Random.HermitianRandomMatrix.ofCoordinates
~~~

Each <code>#check</code> asks the pinned elaborator to print an exact
declaration type. It does not run a simulation or establish an unstated
inverse or dimension theorem. The guarded command below checks the complete
source module on an approved Linux builder.
{{< /repo-check >}}

## Measurability enters only when coordinates vary

For fixed \(d\) and \(u\), assembly is purely deterministic. If the
coordinates depend on an outcome \(\omega\), then

\[
\omega\longmapsto
\operatorname{assemble}\bigl(d(\omega),u(\omega)\bigr)
\]

is a matrix-valued sample map. The project proves it measurable when every
coordinate function \(\omega\mapsto d_i(\omega)\) and
\(\omega\mapsto u_{ij}(\omega)\) is measurable. Entrywise measurability is
enough because every matrix entry is one coordinate, a coerced real
coordinate, or the conjugate of one coordinate.

The named function <code>RandomMatrix.hermitianCoordinateMap n</code>
packages assembly on the complete product coordinate space. The theorem
<code>measurable_hermitianCoordinateMap</code> certifies its measurable
structure. Read {{< refterm "measurable-space" "measurable space" >}} for why
this is a well-formedness condition rather than a probability distribution.

## The empty \(n=0\) boundary

At \(n=0\), both <code>Fin 0</code> and
<code>StrictUpperIndex 0</code> are empty. A function out of an empty type has
no values to choose, so the coordinate product has one point. A matrix indexed
by <code>Fin 0</code> also has no entries and is the unique empty matrix,
written \(0\).

The checked theorems <code>hermitianFromCoordinates_zero</code> and
<code>hermitianCoordinateMap_zero</code> say that assembly returns that empty
matrix. No division by \(n\) occurs in this deterministic layer.

## Distinctions and failure modes

| Tempting shortcut | What goes wrong | Correct repair |
|---|---|---|
| Store every lower entry independently | Most choices violate \(H_{ji}=\overline{H_{ij}}\) | Store only strict-upper entries and reflect them |
| Count six named inputs as six real degrees | Each \(u_{ij}\in\mathbb C\) contains two real components | Count \(3+2\cdot3=9\) for \(n=3\) |
| Include the diagonal in the complex upper block | Hermitian diagonal entries must be real | Give the diagonal its own \(\mathbb R\)-valued function |
| Assemble with \(X+X^*\) | A real diagonal already present in \(X\) is doubled | Use the direct diagonal, upper, lower case split |
| Call the coordinate point a random matrix | No outcome space or sample map has been supplied | Add a coordinate process and prove measurability |
| Infer independence from the product type | A product type describes data shape, not a probability law | Put a product measure or independence theorem in the probability layer |
| Claim a checked inverse | This module exposes coordinate-entry theorems but no packaged inverse equivalence | State recovery entrywise or formalize the equivalence separately |
| Ignore \(n=0\) | Informal index enumeration may silently assume a first entry | Use the explicit empty-index theorems |

{{< panel "warning" >}}
**What this coordinate space does not prove.** It supplies no probability
measure, Gaussian law, independence, GUE scaling, unitary invariance,
eigenvalue theorem, trace moment, or spectral limit. It is the deterministic
assembly layer on which those later claims can be stated precisely.
{{< /panel >}}

## Where to continue

[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}})
develops this representation, its Hermiticity proof, and its measurable
sample-map role in textbook detail. Read
{{< refterm "conjugate-transpose" "conjugate transpose" >}} for the symmetry
operation and {{< refterm "random-matrix" "random matrix" >}} for the later
probability-space layer.

[Finite Product Probability Spaces and Independent Gaussian Fields]({{< relref "/knowledge-base/deep-dives/finite-product-probability-spaces-and-independent-gaussian-fields" >}})
explains how finite coordinate families acquire a joint law. The subsequent
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}})
chooses the diagonal and upper Gaussian laws, fixes their scales and
independence, and pushes that coordinate measure through this assembler.

## References

**Mathlib contributors.**
[Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html),
Mathlib 4 documentation. This is the official API for
<code>Matrix.IsHermitian</code>, conjugate transpose, and the entrywise
criterion used by the checked proof.

**Mathlib contributors.**
[Finite index types](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/Fin/Basic.html),
Mathlib 4 documentation. This documents <code>Fin n</code>, including the
empty zero-dimensional index type used by the boundary theorems.

**Terence Tao.**
[Topics in Random Matrix Theory](https://doi.org/10.1090/gsm/132),
Graduate Studies in Mathematics 132, American Mathematical Society, 2012.
This monograph supplies broader Hermitian and random-matrix context. It is not
used to infer a probability law for the deterministic coordinate space.

**Nonlinear Dynamics in Lean contributors.**
[HermitianCoordinates.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/HermitianCoordinates.lean),
the checked project source for the coordinate type, direct assembler,
entrywise recovery lemmas, Hermiticity, measurability, and zero-dimensional
boundary.

The upstream Mathlib revision audited for this entry is commit
[`81a5d257`](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
pinned by <code>formalization/lake-manifest.json</code>.
