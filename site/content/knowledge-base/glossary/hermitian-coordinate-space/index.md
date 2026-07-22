---
title: "Hermitian coordinate space"
slug: "hermitian-coordinate-space"
summary: "A Hermitian coordinate space stores one real value on each diagonal position and one complex value at each strict-upper position, with the lower triangle determined by conjugation."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.HermitianCoordinates"
og_image: "hermitian-coordinate-space-card.png"
og_image_alt: "A real diagonal and a complex strict upper triangle enter a deterministic assembly step; the lower triangle is then filled by conjugate reflection."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

A **Hermitian coordinate space** is a nonredundant way to describe a finite
complex {{< refterm "hermitian-matrix" "Hermitian matrix" >}}. It stores one
real coordinate for each diagonal position and one complex coordinate for
each position strictly above the diagonal. The entries below the diagonal are
not new data: they are forced to be the complex conjugates of the reflected
upper entries.

For a matrix of size \(n\), define the strict-upper index set

\[
I_n^{\lt}=\{(i,j):0\leq i\lt n,\ 0\leq j\lt n,\ i\lt j\}.
\]

The coordinate space used by this project is

\[
\mathcal C_n
=\bigl(\{0,\ldots,n-1\}\to\mathbb R\bigr)
 \times
 \bigl(I_n^{\lt}\to\mathbb C\bigr).
\]

An element \((d,u)\in\mathcal C_n\) therefore has a real diagonal function
\(d\) and a complex strict-upper function \(u\). This is a deterministic
algebraic object. It carries no probability law, Gaussian assumption,
independence claim, or dimension-dependent scale.

{{< reference-figure
  src="hermitian-coordinate-space.svg"
  alt="A matrix is partitioned into a supplied real diagonal, a supplied complex strict upper triangle, and a lower triangle determined by conjugate reflection."
  caption="**Finding:** only the diagonal and strict upper triangle are primitive coordinates. Diagonal slots take real values. Strict-upper slots take complex values. Every lower slot is filled by conjugating the reflected upper slot, so treating it as a further free coordinate would duplicate data. The plate shows structure only; it does not specify a probability law or normalization."
>}}

## Why these are exactly the free real coordinates

There are \(n\) diagonal positions. Each stores one real degree of freedom.
There are

\[
\binom n2=\frac{n(n-1)}2
\]

strict-upper positions. Each complex coordinate stores two real degrees of
freedom. The total is therefore

\[
n+2\binom n2
=n+n(n-1)
=n^2.
\]

This agrees with the real dimension of the vector space of \(n\times n\)
complex Hermitian matrices. The count is mathematical context for the chosen
representation. The current Lean module defines the coordinate type and its
forward assembly map, but it does not yet package an inverse or prove a named
real-linear equivalence and dimension theorem.

The adjective **strict** matters. If the upper index set included its
diagonal, the representation would need an extra proof that those complex
diagonal values were real, or it would store illegal Hermitian data. A
separate real diagonal makes the constraint true by construction.

## The direct assembly rule

Given \((d,u)\in\mathcal C_n\), the assembled matrix \(H\) is defined entry by
entry:

\[
H_{ij}=
\begin{cases}
u_{ij}, & i\lt j,\\
\overline{u_{ji}}, & j\lt i,\\
d_i, & i=j.
\end{cases}
\]

The three branches are exhaustive because two finite indices satisfy exactly
one of \(i\lt j\), \(i=j\), or \(j\lt i\). They are disjoint, so no coordinate is
overwritten and no scale factor is introduced.

For \(n=3\), the rule reads

\[
H=
\begin{bmatrix}
d_0 & u_{01} & u_{02}\\
\overline{u_{01}} & d_1 & u_{12}\\
\overline{u_{02}} & \overline{u_{12}} & d_2
\end{bmatrix},
\qquad
d_0,d_1,d_2\in\mathbb R,
\quad
u_{01},u_{02},u_{12}\in\mathbb C.
\]

Every diagonal entry is real, and every reflected off-diagonal pair is
conjugate. Hence \(H^*=H\) without a later correction step.

## Why this is not \(X+X^*\)

The map \(X\mapsto X+X^*\) is a useful universal Hermitian constructor, but it
is not the right insertion map for already named free coordinates. Suppose
\(X\) is upper triangular with real diagonal \(d\) and upper entries \(u\).
Then

\[
(X+X^*)_{ii}=d_i+\overline{d_i}=2d_i.
\]

The off-diagonal entries land in the intended locations, but the diagonal is
doubled. Dividing the whole matrix by two would also halve the supplied
off-diagonal coordinates. Feeding \(d_i/2\) into an internal temporary matrix
could compensate, but it would hide a scale convention inside what should be
a transparent coordinate insertion.

The direct three-branch definition inserts every supplied coordinate
unchanged. This makes later normalization choices visible where the primitive
coordinates are chosen.

## The exact project definition

Lean represents a strict-upper position as a pair of finite indices together
with the proof that the row is smaller than the column:

~~~lean
def StrictUpperIndex (n : ℕ) :=
  {ij : Fin n × Fin n // ij.1 < ij.2}

abbrev HermitianCoordinateSpace (n : ℕ) :=
  (Fin n → ℝ) × (StrictUpperIndex n → ℂ)
~~~

`StrictUpperIndex n` has explicit `Fintype` and `DecidableEq` instances. The
first lets finite constructions enumerate the primitive upper positions. The
second lets Lean decide when two such positions are equal. Neither instance
asserts that the coordinates are random or independent.

The project function
`RandomMatrix.hermitianFromCoordinates d u` implements the three branches.
Named simplification theorems expose its diagonal, upper, and lower entries,
and `hermitianFromCoordinates_isHermitian` checks the resulting Hermiticity
for every input.

## Measurability belongs to the map, not the name

If \(d_i(\omega)\) and \(u_{ij}(\omega)\) vary with an outcome \(\omega\), the
assembly is a matrix-valued sample map. The module proves it measurable when
every supplied scalar coordinate map is measurable. Entrywise proof is enough:
each output entry is either a real diagonal coordinate embedded in
\(\mathbb C\), an upper coordinate, or the complex conjugate of an upper
coordinate.

The named map `RandomMatrix.hermitianCoordinateMap n` packages the same
deterministic assembly on \(\mathcal C_n\), and the theorem
`measurable_hermitianCoordinateMap` proves that map measurable for the
canonical product measurable structure. Read
{{< refterm "measurable-space" "measurable space" >}} for why this proof is a
well-formedness bridge rather than a probability claim.

## The zero-dimensional coordinate space

When \(n=0\), `Fin 0` is empty and `StrictUpperIndex 0` is empty. There is one
function from each empty index type into its target, so the coordinate space
has one element. The target matrix type also has no entries and contains one
matrix, written (0).

The checked theorems `hermitianFromCoordinates_zero` and
`hermitianCoordinateMap_zero` state that assembly returns this unique empty
matrix. No division by \(n\) occurs. This settles the deterministic boundary
only; it does not define a zero-dimensional random-matrix law.

## What the term does not imply

A Hermitian coordinate space does not by itself provide:

- random variables on any outcome space;
- coordinate independence or identical distribution;
- real or complex Gaussian laws;
- a Gaussian unitary ensemble (GUE) normalization;
- a probability measure on the coordinate or matrix space;
- unitary invariance of a matrix law;
- eigenvalue measurability, trace expectations, or spectral asymptotics; or
- a checked inverse or dimension theorem for the assembly map.

Those are separate layers. The value of this coordinate space is that later
layers can choose their laws and scales without reopening the basic
Hermitian bookkeeping.

## Where to continue

[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}})
develops the dimension count, direct assembly, Hermiticity proof,
measurability argument, Lean declaration map, and empty boundary in textbook
detail. Read {{< refterm "conjugate-transpose" "conjugate transpose" >}} for
the reflection operation and {{< refterm "random-matrix" "random matrix" >}}
for the later sample-map layer.

[Finite Product Probability Spaces and Independent Gaussian Fields]({{< relref "/knowledge-base/deep-dives/finite-product-probability-spaces-and-independent-gaussian-fields" >}})
supplies the primitive finite product machinery. The next completed layer,
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}}),
chooses the diagonal and upper laws, their scales and independence, and pushes
the resulting coordinate measure through this assembly map.

## References

**Mathlib contributors.**
[Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html),
Mathlib 4 documentation. This is the official API for
`Matrix.IsHermitian`, conjugate transpose, and the entrywise Hermitian
criterion used by the checked proof.

**Mathlib contributors.**
[Finite index types](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/Fin/Basic.html),
Mathlib 4 documentation. This documents `Fin n`, including the empty
zero-dimensional index type used by the boundary theorems.

**Terence Tao.**
[Topics in Random Matrix Theory](https://doi.org/10.1090/gsm/132),
Graduate Studies in Mathematics 132, American Mathematical Society, 2012.
This standard monograph provides broader finite-dimensional Hermitian and
random-matrix context. It is not used to infer a probability law for the
project's deterministic coordinate space.

The exact upstream Lean source audited for this entry is Mathlib commit
[`81a5d257`](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by `formalization/lake-manifest.json`.
