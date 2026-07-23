---
title: "Finite Hermitian Matrices from Coordinates"
slug: "finite-hermitian-matrices-from-coordinates"
date: 2026-07-21
summary: "Build one exact two-by-two Hermitian matrix from four real coordinates, then climb through reconstruction, dimension counting, Frobenius geometry, measurability, Lean syntax, and the zero-dimensional boundary."
lead: "Start with four integers, watch conjugate reflection fill a matrix, and keep the same example in view until the abstract coordinate map and its Lean proof feel inevitable."
draft: false
pro_reviewed: false
level: "Finite matrix foundations to measurable assembly"
reading_time: "65 to 85 minutes"
prerequisites: "Arithmetic with complex numbers and two-by-two matrices; finite types, measurable spaces, and Lean subtypes are introduced when they first appear"
lean_module: "NonlinearDynamics.Random.RandomMatrices.HermitianCoordinates"
toc: true
og_image: "finite-hermitian-coordinates-card.png"
og_image_alt: "Four real coordinates two, minus one, one, and two reconstruct a two-by-two Hermitian matrix; the lower imaginary part changes sign under conjugation, while a copied-sign near-miss fails the symmetry test."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. The mathematical
prose, sources, Lean declaration map, figures, and accessibility have not yet
received the required human and Pro reviews. The page is publicly available as
an open working note while those reviews remain pending.
{{< /panel >}}

## Start with four integers and one forced reflection

Take two real diagonal coordinates and one complex strict-upper coordinate:

\[
d_0=2,
\qquad
d_1=-1,
\qquad
u_{01}=1+2i.
\]

The subscripts record destinations. The number \(d_0\) goes in row 0, column
0; \(d_1\) goes in row 1, column 1; and \(u_{01}\) goes in row 0, column 1.
The remaining cell is not a fourth matrix-entry choice. It is forced to be
the complex conjugate \(\overline{u_{01}}=1-2i\):

\[
H=
\begin{bmatrix}
2 & 1+2i\\
1-2i & -1
\end{bmatrix}.
\]

Check the defining symmetry entry by entry. The diagonal values are real,
and the off-diagonal pair obeys

\[
H_{10}=1-2i=\overline{1+2i}=\overline{H_{01}}.
\]

Therefore the conjugate transpose of \(H\) is \(H\) itself. The four real
numbers

\[
q=(d_0,d_1,\operatorname{Re}u_{01},\operatorname{Im}u_{01})
=(2,-1,1,2)
\]

are enough to reconstruct all four complex matrix positions. This tuple
\(q\) is the running example for the whole chapter.

Now copy the upper entry into the lower slot without changing the sign of its
imaginary part:

\[
M=
\begin{bmatrix}
2 & 1+2i\\
1+2i & -1
\end{bmatrix}.
\]

This near-miss is not Hermitian because
\(M_{10}=1+2i\ne1-2i=\overline{M_{01}}\). Reflection alone is not enough;
reflection **and complex conjugation** are the rule.

{{< reference-figure
  wide="true"
  src="two-by-two-coordinate-reconstruction.svg"
  alt="Four real inputs, two diagonal values and the real and imaginary parts of one upper entry, reconstruct the matrix with rows two comma one plus two i and one minus two i comma minus one. A near-miss copies plus two as the lower imaginary part instead of changing it to minus two."
  caption="**Finding:** the coordinate ledger \((2,-1,1,2)\) supplies exactly four real choices. Assembly places 2 and -1 on the diagonal, places real part 1 and imaginary part +2 above the diagonal, and forces real part 1 and imaginary part -2 below it. The near-miss keeps +2 below the diagonal and therefore fails conjugate symmetry. These are exact toy values, not sampled data or an ensemble normalization."
>}}

A finite complex Hermitian matrix satisfies the compact equation \(H^*=H\).
The example shows what that equation means operationally: diagonal entries
are real, strict-upper entries are free, and strict-lower entries are
determined. This chapter turns that geometry into a deterministic program,
then separates what the checked Lean module proves from later dimension,
Euclidean-geometry, probability, and spectral layers.

No {{< refterm "probability-measure" "probability measure" >}} enters this
construction. No coordinate is declared Gaussian or independent. No
Gaussian unitary ensemble (GUE) normalization, matrix law, unitary invariance,
spectral statistic, or asymptotic theorem is selected. The chapter builds the
deterministic bridge that those later layers may use.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [The symmetry constraint removes redundant data](#base-camp-the-symmetry-constraint-removes-redundant-data) | Read a Hermitian matrix as free coordinates plus reflection |
| Dimension route | [Count the real degrees of freedom](#camp-one-count-the-real-degrees-of-freedom) | Derive the \(n^2\) real-coordinate count |
| Construction route | [Insert coordinates directly](#camp-three-insert-coordinates-directly) | Understand the diagonal, upper, and lower branches |
| Geometry route | [Reflection changes the coordinate metric](#geometry-ridge-reflection-changes-the-coordinate-metric) | Compute norms and an inner product from the same raw ledger |
| Proof route | [Hermiticity is a three-case proof](#camp-five-hermiticity-is-a-three-case-proof) | Follow the exact entrywise argument used in Lean |
| Measurability route | [Measurability reduces to scalar coordinates](#camp-six-measurability-reduces-to-scalar-coordinates) | See why no measure or law is required |
| Hands-on Lean route | [Type the running example yourself](#type-the-running-example-yourself-with-lean-and-std) | Run a bounded <code>Std</code> worksheet on Mac or Linux |
| Project Lean route | [The checked declaration map](#the-checked-declaration-map) | Audit all 17 public declarations on an approved Linux builder |
| Boundary route | [Dimension zero is not an exception](#camp-eight-dimension-zero-is-not-an-exception) | Understand the unique empty coordinate point and matrix |

### Learning objectives

By the summit, you should be able to:

1. identify the real diagonal and complex strict upper triangle as the free
   coordinates of a finite Hermitian matrix;
2. derive the \(n^2\) real-degree-of-freedom count;
3. explain why the lower triangle is determined rather than independently
   supplied;
4. evaluate the direct assembly map in all three index-order cases;
5. show why an \(X+X^*\) implementation doubles a supplied real diagonal;
6. compute the running matrix's Frobenius square and its inner product with a
   second matrix from the raw coordinate ledger;
7. explain why raw upper coordinates receive weight two in matrix geometry;
8. prove Hermiticity entry by entry using order trichotomy;
9. reduce matrix-valued measurability to scalar coordinate maps;
10. distinguish assembly from a bundled measurable Hermitian random matrix;
11. run the bounded <code>Std</code> reconstruction and near-miss worksheet;
12. explain the zero-dimensional coordinate and matrix spaces; and
13. separate the 17 checked Lean declarations from unproved dimension,
    inverse, probability, and spectral statements.

## The assembly program in one picture

{{< reference-figure
  src="three-branch-hermitian-assembly.svg"
  alt="Comparing a row and column sends an entry to one of three branches: copy a strict-upper complex coordinate, insert a real diagonal coordinate, or conjugate the reflected upper coordinate; all branches join at a Hermitian matrix."
  caption="**Finding:** the assembly map is a total three-branch program. Above the diagonal it copies a supplied complex coordinate. On the diagonal it inserts a supplied real coordinate. Below the diagonal it conjugates the reflected upper coordinate. The branches are selected only by finite-index order and introduce no probability law or scale."
>}}

## Base camp: the symmetry constraint removes redundant data

For a complex matrix \(H\), the
{{< refterm "conjugate-transpose" "conjugate transpose" >}} is defined by

\[
(H^*)_{ij}=\overline{H_{ji}}.
\]

The matrix is {{< refterm "hermitian-matrix" "Hermitian" >}} when \(H^*=H\).
Entrywise, this is

\[
\overline{H_{ji}}=H_{ij}
\qquad\text{for every }i,j.
\]

Set \(i=j\). Then \(H_{ii}=\overline{H_{ii}}\), which means that the diagonal
entry is real. Now take \(i\ne j\). Choosing \(H_{ij}\) determines
\(H_{ji}=\overline{H_{ij}}\). The two reflected off-diagonal slots carry one
complex coordinate together, not two unrelated complex coordinates.

This distinction matters before probability appears. Independently supplied
nondegenerate upper and lower variables cannot also satisfy the deterministic
Hermitian reflection constraint. A Hermitian construction identifies each
lower entry with the conjugate of its upper partner, so the pair is generally
dependent. The safest representation records only the primitive positions and
performs reflection deterministically. Degenerate constant coordinates can
make independence and a deterministic relation coexist, but they do not
justify treating both slots as separate free data.

For size \(n\), let

\[
I_n^{\lt}=\{(i,j):0\le i\lt n,\ 0\le j\lt n,\ i\lt j\}
\]

be the strict-upper positions. A coordinate point is a pair

\[
(d,u)
\in
(\operatorname{Fin}(n)\to\mathbb R)
\times
(I_n^{\lt}\to\mathbb C).
\]

Here \(d_i\) is intended for the \(i\)-th diagonal slot, and \(u_{ij}\) is
intended for the strict-upper slot \((i,j)\). The lower triangle is absent
from the input type because Hermiticity already determines it.

{{< checkpoint stage="Base camp" title="Name the primitive data" >}}
The free data are not all matrix entries. They are a real diagonal and a
complex strict upper triangle. Calling the lower triangle a further coordinate
family would duplicate rather than enrich the matrix.
{{< /checkpoint >}}

## Camp one: count the real degrees of freedom

The coordinate representation exposes the real dimension of the Hermitian
space. The diagonal contributes \(n\) real coordinates. The number of
strict-upper positions is

\[
\lvert I_n^{\lt}\rvert
=\binom n2
=\frac{n(n-1)}2.
\]

Every strict-upper coordinate is complex, so it contributes two real
coordinates. Therefore

\[
\begin{aligned}
n+2\lvert I_n^{\lt}\rvert
&=n+2\binom n2\\
&=n+n(n-1)\\
&=n^2.
\end{aligned}
\]

This is the real dimension of the vector space of \(n\times n\) complex
Hermitian matrices.

For \(n=1\), there is one real diagonal value and no strict-upper position.
For \(n=2\), there are two real diagonal values and one complex upper value:

\[
H=
\begin{bmatrix}
d_0 & u_{01}\\
\overline{u_{01}} & d_1
\end{bmatrix}.
\]

The running ledger \(q=(2,-1,1,2)\) is exactly this case. Its first two
numbers are the real diagonal; its last two are the real and imaginary parts
of the one complex upper value. Thus it has

\[
2+2\binom22=2+2=4=2^2
\]

real coordinates. The lower-left matrix cell consumes no new degree of
freedom. For \(n=3\), three real diagonal coordinates and three complex upper
coordinates give \(3+2\cdot3=9=3^2\).

These counts are mathematical context. The RMT-05 Lean module does not define
a basis, prove the cardinality formula for <code>StrictUpperIndex</code>, or
package a real-linear equivalence. Its checked interface defines the
coordinate type and proves direct assembly, entry formulas, Hermiticity, and
measurability.

## Camp two: make the strict upper triangle a type

Lean's finite index type <code>Fin n</code> contains natural numbers smaller
than \(n\), together with the proof of that bound. The project defines

~~~lean
def StrictUpperIndex (n : ℕ) :=
  {ij : Fin n × Fin n // ij.1 < ij.2}
~~~

This is a **subtype**. A value contains a pair \((i,j)\) and evidence that
\(i\lt j\). Thus a function

~~~lean
u : StrictUpperIndex n → ℂ
~~~

can only be evaluated at a genuine strict-upper position. There is no need to
assign dummy values on or below the diagonal and later prove they are ignored.

The module supplies three instances:

- <code>StrictUpperIndex.instFintype</code> proves the index type is finite;
- <code>StrictUpperIndex.instDecidableEq</code> decides equality of two
  strict-upper positions; and
- <code>StrictUpperIndex.instIsEmptyZero</code> records that no such position
  exists when \(n=0\).

The full coordinate type is deliberately simple:

~~~lean
abbrev HermitianCoordinateSpace (n : ℕ) :=
  (Fin n → ℝ) × (StrictUpperIndex n → ℂ)
~~~

It is an abbreviation for a product of function spaces. It does not carry
proof fields, a measure, or a normalization ledger.

### In Lean: the input type records only free entries

{{< lean-bridge
  human="A size-n coordinate point is a real number for every diagonal position together with a complex number for every strict-upper position."
  math="\((d,u)\in(\operatorname{Fin}(n)\to\mathbb R)\times(I_n^{\lt}\to\mathbb C)\)."
  lean="(Fin n → ℝ) × (StrictUpperIndex n → ℂ)"
>}}

- <code>Fin n</code> is the type of row or column indices from zero through
  \(n-1\), with the bound carried in the value.
- <code>→</code> is a function type. Thus <code>Fin n → ℝ</code> assigns one
  real number to each diagonal position.
- <code>StrictUpperIndex n</code> contains pairs together with a proof that the
  row is strictly smaller than the column.
- <code>×</code> is a product type. A coordinate point contains both families.
- There is no strict-lower factor. Its omission is the type-level expression
  of conjugate reflection.
{{< /lean-bridge >}}

## Camp three: insert coordinates directly

For a real diagonal \(d\) and a complex strict upper triangle \(u\), define
\(H=\operatorname{assemble}(d,u)\) by

\[
H_{ij}=
\begin{cases}
u_{ij}, & i\lt j,\\
\overline{u_{ji}}, & j\lt i,\\
d_i, & i=j.
\end{cases}
\]

Lean implements the same rule:

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

The first branch builds a subtype value from \((i,j)\) and the proof
<code>hij</code>. The second uses the reflected pair \((j,i)\) and applies
<code>star</code>, which is complex conjugation here. If neither strict
inequality holds, order forces \(i=j\), so the last branch inserts \(d_i\),
coerced from \(\mathbb R\) into \(\mathbb C\).

Three simplification theorems expose the behavior:

\[
\begin{aligned}
\operatorname{assemble}(d,u)_{ii}
&=d_i,\\
\operatorname{assemble}(d,u)_{ij}
&=u_{ij} &&\text{when }i\lt j,\\
\operatorname{assemble}(d,u)_{ij}
&=\overline{u_{ji}} &&\text{when }j\lt i.
\end{aligned}
\]

Their Lean names are
<code>hermitianFromCoordinates_apply_diag</code>,
<code>hermitianFromCoordinates_apply_upper</code>, and
<code>hermitianFromCoordinates_apply_lower</code>.

### Reconstruct the running matrix one branch at a time

For \(q=(2,-1,1,2)\), the diagonal function returns \(d_0=2\) and
\(d_1=-1\). The strict-upper function has one input, the pair \((0,1)\), and
returns \(u_{01}=1+2i\). The three branches now give

\[
\begin{aligned}
H_{00}&=d_0=2,\\
H_{01}&=u_{01}=1+2i,\\
H_{10}&=\overline{u_{01}}=1-2i,\\
H_{11}&=d_1=-1.
\end{aligned}
\]

Reading those four results by rows reconstructs the opening matrix exactly.
Nothing is sampled, averaged, or scaled during this computation.

### In Lean: a lower entry is the conjugate of a proved upper position

{{< lean-bridge
  human="When column j comes before row i, the assembled entry at row i, column j is the conjugate of the supplied entry at the reflected strict-upper position."
  math="\(j\lt i\Longrightarrow H_{ij}=\overline{u_{ji}}\)."
  lean="RandomMatrix.hermitianFromCoordinates d u i j = star (u ⟨(j, i), hji⟩)"
>}}

- <code>hji : j &lt; i</code> is evidence that the reflected pair really lies
  in the strict upper triangle.
- <code>⟨(j, i), hji⟩</code> packages the pair and its proof as one
  <code>StrictUpperIndex n</code> value.
- <code>u ...</code> retrieves the supplied complex coordinate.
- <code>star</code> is complex conjugation in this type.
- The exact project theorem is
  <code>RandomMatrix.hermitianFromCoordinates_apply_lower</code>; the displayed
  equation is its conclusion after the variables are instantiated.
{{< /lean-bridge >}}

## Camp four: why \(X+X^*\) is the wrong insertion map

Given any square complex matrix \(X\), the matrix \(X+X^*\) is Hermitian. But
a universal repair map and a coordinate insertion map have different jobs.
Build an upper-triangular temporary matrix from the intended coordinates:

\[
X_{ij}=
\begin{cases}
u_{ij}, & i\lt j,\\
d_i, & i=j,\\
0, & j\lt i.
\end{cases}
\]

Above the diagonal, \((X+X^*)_{ij}=u_{ij}\). On the diagonal,

\[
\begin{aligned}
(X+X^*)_{ii}
&=X_{ii}+\overline{X_{ii}}\\
&=d_i+d_i\\
&=2d_i.
\end{aligned}
\]

The diagonal is doubled. Using \((X+X^*)/2\) repairs the diagonal but turns the
upper coordinate into \(u_{ij}/2\). Supplying \(d_i/2\) only on the temporary
diagonal could compensate, but then a hidden scaling convention lives inside
the constructor.

Direct assembly inserts \(d_i\), \(u_{ij}\), and
\(\overline{u_{ij}}\) exactly where intended. Later probability code can scale
primitive coordinates explicitly.

{{< checkpoint stage="Camp four" title="Do not hide a scale in algebra" >}}
Hermiticity alone cannot tell whether a diagonal was intended to be \(d_i\),
\(2d_i\), or \(d_i/\sqrt n\). The direct constructor preserves the supplied
coordinates. Any later scale belongs in the probabilistic model.
{{< /checkpoint >}}

## Geometry ridge: reflection changes the coordinate metric

The running ledger is a perfect encoding, but its ordinary unweighted dot
product is not yet the Frobenius geometry of the assembled matrix. The reason
is visible: one strict-upper complex coordinate occupies two matrix cells.

The squared Frobenius norm adds the squared magnitude of every entry. For the
running matrix,

\[
\begin{aligned}
\lVert H\rVert_F^2
&=|2|^2+|-1|^2+|1+2i|^2+|1-2i|^2\\
&=4+1+5+5\\
&=15.
\end{aligned}
\]

By contrast, the unweighted square of the four-number ledger is

\[
\lVert q\rVert_{\mathrm{raw}}^2
=2^2+(-1)^2+1^2+2^2
=10.
\]

The missing \(5\) is the second matrix copy of the upper entry. If a raw
coordinate is written \((d_0,d_1,a,b)\), the matrix-induced squared norm is

\[
\lVert(d_0,d_1,a,b)\rVert_{\mathrm{weighted}}^2
=d_0^2+d_1^2+2(a^2+b^2).
\]

That weight also controls cross inner products. Compare \(H\) with the
Hermitian matrix encoded by

\[
r=(1,3,-2,1),
\qquad
K=
\begin{bmatrix}
1 & -2+i\\
-2-i & 3
\end{bmatrix}.
\]

The real Frobenius inner product is the real part of the entrywise complex
inner product:

\[
\langle H,K\rangle_{F,\mathbb R}
=\operatorname{Re}\!\left(
\sum_{i,j}\overline{H_{ij}}K_{ij}
\right).
\]

In raw coordinates it becomes

\[
\begin{aligned}
\langle q,r\rangle_{\mathrm{weighted}}
&=2\cdot1+(-1)\cdot3
  +2\bigl(1\cdot(-2)+2\cdot1\bigr)\\
&=2-3+2(0)\\
&=-1.
\end{aligned}
\]

The same ledger gives \(\lVert K\rVert_F^2=1+9+2(4+1)=20\). Thus the
three exact geometric outputs for this pair are

\[
\lVert H\rVert_F^2=15,
\qquad
\langle H,K\rangle_{F,\mathbb R}=-1,
\qquad
\lVert K\rVert_F^2=20.
\]

{{< reference-figure
  wide="true"
  src="two-by-two-coordinate-geometry.svg"
  alt="The first raw ledger two, minus one, one, two has unweighted square ten but matrix-weighted square fifteen because the upper real and imaginary pair is counted twice. A second ledger one, three, minus two, one has weighted square twenty. Their diagonal inner contribution is minus one, their upper contribution is zero even after doubling, and their total real Frobenius inner product is minus one."
  caption="**Finding:** conjugate reflection changes geometry even though it adds no new freedom. For \(q=(2,-1,1,2)\), the ordinary raw-ledger square is 10 while the assembled Frobenius square is 15. For \(r=(1,3,-2,1)\), the Frobenius square is 20. Their diagonal cross contribution is -1; the upper real-imaginary dot product is zero, so doubling it still contributes zero and the total inner product is -1. This is exact finite arithmetic, not empirical evidence."
>}}

There are two equivalent ways to remember the factor of two:

1. keep the raw upper real and imaginary parts \((a,b)\) and use the weighted
   inner product above; or
2. replace them by \((\sqrt2a,\sqrt2b)\), after which the ordinary Euclidean
   dot product has the right size.

For the running example, the second convention stores
\((2,-1,\sqrt2,2\sqrt2)\), whose ordinary squared length is
\(4+1+2+8=15\). The RMT-05 module in this chapter does **not** formalize this
inner-product structure or the normalized-coordinate equivalence. Those are
later checked layers explained in
{{< refterm "normalized-hermitian-coordinates" "normalized Hermitian coordinates" >}}
and
{{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius geometry" >}}.
The present module supplies the unscaled assembly map on which that geometry
is built.

## Camp five: Hermiticity is a three-case proof

Mathlib defines <code>Matrix.IsHermitian H</code> by \(H^*=H\). Its entrywise
criterion asks for

\[
\overline{H_{ji}}=H_{ij}
\qquad\text{for every }i,j.
\]

Fix indices \(i\) and \(j\). A finite linear order gives exactly three cases.

### Case one: \(i\lt j\)

The forward entry is strict upper and the reflected entry is lower:

\[
H_{ij}=u_{ij},
\qquad
H_{ji}=\overline{u_{ij}}.
\]

Therefore

\[
\overline{H_{ji}}
=\overline{\overline{u_{ij}}}
=u_{ij}
=H_{ij}.
\]

### Case two: \(i=j\)

The diagonal entry is the complex coercion of a real number:

\[
H_{ii}=d_i.
\]

Real numbers are fixed by complex conjugation, so

\[
\overline{H_{ii}}=\overline{d_i}=d_i=H_{ii}.
\]

This is why the diagonal input type is \(\mathbb R\), not \(\mathbb C\). A
putative diagonal value \(2+i\) would become \(2-i\) under conjugation and
would fail the diagonal equation. The type rules out that near-miss before a
proof starts.

### Case three: \(j\lt i\)

This is the reflected version of case one:

\[
H_{ij}=\overline{u_{ji}},
\qquad
H_{ji}=u_{ji}.
\]

Conjugating the second equation gives exactly the first.

The Lean theorem
<code>RandomMatrix.hermitianFromCoordinates_isHermitian</code> follows this
architecture. It rewrites Hermiticity to the entrywise criterion, splits with
<code>lt_trichotomy i j</code>, and applies the three entry simplification
theorems. There is no probability space and no almost-everywhere qualifier.
The result holds for every coordinate input.

### In Lean: assembly is Hermitian for every input

{{< lean-bridge
  human="Every real diagonal and complex strict-upper family assembles to a Hermitian matrix, with no exceptional coordinate points."
  math="\(\forall d\,u,\;\operatorname{assemble}(d,u)^*=\operatorname{assemble}(d,u)\)."
  lean="(RandomMatrix.hermitianFromCoordinates d u).IsHermitian"
>}}

- The parentheses first build the matrix from <code>d</code> and <code>u</code>.
- <code>.IsHermitian</code> is Mathlib's predicate that the conjugate transpose
  equals the original matrix.
- The exact theorem
  <code>RandomMatrix.hermitianFromCoordinates_isHermitian d u</code> produces
  a proof of this proposition.
- No symbol for a measure, an outcome, or "almost every" occurs. The claim is
  pointwise in the coordinate input.
- In the proof source, <code>lt_trichotomy i j</code> creates the upper,
  diagonal, and lower cases used in the hand argument.
{{< /lean-bridge >}}

### Physics window: reality and conjugate couplings

Hermiticity is the finite-dimensional algebra behind two central physics
facts. Let \(\psi\in\mathbb C^n\) be a column vector and let
\(\psi^\dagger\) be its conjugate transpose. The quadratic form of a Hermitian
matrix is real:

\[
\begin{aligned}
\overline{\psi^\dagger H\psi}
&=\psi^\dagger H^*\psi\\
&=\psi^\dagger H\psi.
\end{aligned}
\]

In quantum mechanics, when \(H\) is a Hamiltonian, this reality is the
algebraic prerequisite for real expectation values. The paired entries
\(H_{ij}\) and \(H_{ji}=\overline{H_{ij}}\) are conjugate coupling matrix
elements between the two basis directions. They are not themselves transition
amplitudes or probabilities, and the relationship does not say that matrix
coordinates are statistically independent.

Hermiticity also turns \(-iH\) into a skew-Hermitian generator:

\[
(-iH)^*=iH^*=iH=-(-iH).
\]

Consequently, in finite dimensions and in units where \(\hbar=1\), the
exponential \(U(t)=\exp(-itH)\) is unitary, which preserves inner products
during Schrödinger evolution. This paragraph is mathematical and physical context.
The present Lean module formalizes neither state vectors, quadratic forms,
matrix exponentials, spectra, quantum measurement, nor time evolution. It
checks only deterministic coordinate assembly, Hermiticity, and
measurability.

## Camp six: measurability reduces to scalar coordinates

Let the coordinate data vary with an outcome \(\omega\) in a
{{< refterm "measurable-space" "measurable space" >}} \(\Omega\):

\[
d:\Omega\to(\operatorname{Fin}(n)\to\mathbb R),
\qquad
u:\Omega\to(I_n^{\lt}\to\mathbb C).
\]

For each fixed diagonal index \(i\), assume
\(\omega\mapsto d(\omega)_i\) is measurable. For each fixed strict-upper
index \(q\), assume \(\omega\mapsto u(\omega)_q\) is measurable. The assembled
sample map is

\[
\omega\longmapsto
\operatorname{assemble}\bigl(d(\omega),u(\omega)\bigr).
\]

The project's matrix measurable space is entrywise: a matrix-valued function
is measurable exactly when every fixed entry is measurable. Fix \(i,j\) and
reuse the order branches.

- If \(i\lt j\), the output entry is the assumed measurable map
  \(\omega\mapsto u(\omega)_{ij}\).
- If \(j\lt i\), the output is the conjugate of
  \(\omega\mapsto u(\omega)_{ji}\). Complex conjugation is continuous and
  therefore measurable.
- Otherwise the output is the assumed measurable real diagonal map, followed
  by the continuous inclusion \(\mathbb R\to\mathbb C\).

This is
<code>RandomMatrix.measurable_hermitianFromCoordinates</code>. Its hypotheses
are ordinary coordinatewise <code>Measurable</code> statements. It needs no
measure on \(\Omega\), and it infers no laws, moments, or independence.

### The canonical coordinate map

Package the two coordinate functions as one point \(x=(d,u)\) of the
{{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}.
The project defines

~~~lean
def hermitianCoordinateMap (n : ℕ) :
    HermitianCoordinateSpace n → Matrix (Fin n) (Fin n) ℂ :=
  fun x ↦ hermitianFromCoordinates x.1 x.2
~~~

The theorem <code>measurable_hermitianCoordinateMap n</code> proves this map
measurable. Coordinate evaluation on each function-space factor is measurable;
composition with the product projections supplies the hypotheses of the
general assembly theorem.

This named map is the eventual transport bridge. A later module may place a
probability measure on the coordinate space and push it forward through
<code>hermitianCoordinateMap</code>. RMT-05 does not perform that pushforward
or choose a source measure.

### In Lean: coordinatewise measurability lifts through assembly

{{< lean-bridge
  human="If every diagonal coordinate process and every strict-upper coordinate process is measurable, then the assembled matrix-valued process is measurable."
  math="\(\bigl[\forall i,\ d_i\text{ measurable}\bigr]\land\bigl[\forall q,\ u_q\text{ measurable}\bigr]\Longrightarrow\bigl[\omega\mapsto\operatorname{assemble}(d(\omega),u(\omega))\text{ measurable}\bigr].\)"
  lean="Measurable fun ω ↦ RandomMatrix.hermitianFromCoordinates (d ω) (u ω)"
>}}

- <code>fun ω ↦ ...</code> is an anonymous function of the outcome
  <code>ω</code>.
- <code>d ω</code> and <code>u ω</code> are the two coordinate families at that
  outcome.
- <code>Measurable</code> is a predicate on the whole matrix-valued function.
- The theorem
  <code>RandomMatrix.measurable_hermitianFromCoordinates hd hu</code> proves
  the displayed proposition from coordinatewise hypotheses <code>hd</code> and
  <code>hu</code>.
- A measurable space tells Lean which preimages are legitimate events. No
  measure, probability mass, density, or expectation is introduced here.
{{< /lean-bridge >}}

{{< checkpoint stage="Camp six" title="Measurable is not distributed" >}}
A measurable assembly map can transport a measure after one is supplied.
Measurability alone does not provide that source measure, an exact coordinate
law, independence, or a matrix law.
{{< /checkpoint >}}

## Camp seven: bundle the sample map without adding a law

The existing <code>HermitianRandomMatrix</code> structure packages a matrix
sample map with two proofs:

1. the sample map is measurable; and
2. every realized matrix is Hermitian.

The constructor <code>HermitianRandomMatrix.ofCoordinates</code> takes the
coordinate processes \(d\) and \(u\), together with their coordinatewise
measurability proofs. Its underlying matrix is direct assembly. The
measurability field is filled by
<code>measurable_hermitianFromCoordinates</code>, and the pointwise symmetry
field is filled by <code>hermitianFromCoordinates_isHermitian</code>.

The theorem <code>HermitianRandomMatrix.ofCoordinates_apply</code> exposes the
bundle at an outcome:

\[
\operatorname{ofCoordinates}(d,u)(\omega)
=\operatorname{assemble}\bigl(d(\omega),u(\omega)\bigr).
\]

The word **random** in the carrier name does not add a probability measure.
The bundle is a measurable Hermitian sample map on a measurable outcome space.
Its law becomes meaningful only after a measure is supplied separately.

The separation keeps the constructor reusable. The same assembly works for
Gaussian coordinates, bounded coordinates, empirical inputs, or fully
deterministic functions. Hermiticity and measurability do not depend on which
later distributional story is chosen.

## Camp eight: dimension zero is not an exception

When \(n=0\), <code>Fin 0</code> has no values. Consequently:

- the diagonal index type is empty;
- <code>StrictUpperIndex 0</code> is empty;
- there is exactly one diagonal function from <code>Fin 0</code> to
  \(\mathbb R\);
- there is exactly one strict-upper function into \(\mathbb C\); and
- a matrix indexed by <code>Fin 0</code> in both directions has no entries.

Two functions with an empty domain are equal because there is no input on
which they can differ. The coordinate product therefore contains one point.
The matrix space also contains one matrix, represented by the zero matrix.

The theorem <code>hermitianFromCoordinates_zero</code> proves that every
zero-dimensional input assembles to this unique zero matrix. The theorem
<code>hermitianCoordinateMap_zero</code> states the same fact for the named
coordinate map.

The proofs do not divide by \(n\), appeal to a density, or special-case a
random law. They eliminate the impossible row index. This settles the
deterministic boundary. A later dimension-dependent ensemble still needs its
own explicit \(n=0\) probability policy.

## Type the running example yourself with Lean and Std

The project theorem uses Mathlib's complex numbers, matrices, measurable
spaces, and Hermitian predicate. Before loading that machinery, a learner can
model the same finite bookkeeping with two small structures. The worksheet
below imports only Lean's <code>Std</code> library. It is intentionally bounded
and suitable for an ordinary Mac or Linux machine.

Create a scratch directory outside <code>formalization/</code>. Save the exact
block below as <code>HermitianCoordinatesTutorial.lean</code>:

~~~lean
import Std

namespace HermitianCoordinatesTutorial

structure ComplexInt where
  re : Int
  im : Int
  deriving Repr, DecidableEq

def ComplexInt.conj (z : ComplexInt) : ComplexInt :=
  { re := z.re, im := -z.im }

structure Hermitian2Coordinates where
  d0 : Int
  d1 : Int
  upper : ComplexInt
  deriving Repr, DecidableEq

structure Matrix2 where
  a00 : ComplexInt
  a01 : ComplexInt
  a10 : ComplexInt
  a11 : ComplexInt
  deriving Repr, DecidableEq

def Matrix2.IsHermitian (A : Matrix2) : Prop :=
  A.a00.im = 0 ∧
  A.a11.im = 0 ∧
  A.a10 = A.a01.conj

instance (A : Matrix2) : Decidable (Matrix2.IsHermitian A) := by
  unfold Matrix2.IsHermitian
  infer_instance

def assemble (x : Hermitian2Coordinates) : Matrix2 :=
  { a00 := { re := x.d0, im := 0 }
    a01 := x.upper
    a10 := x.upper.conj
    a11 := { re := x.d1, im := 0 } }

def extract (A : Matrix2) : Hermitian2Coordinates :=
  { d0 := A.a00.re
    d1 := A.a11.re
    upper := A.a01 }

def rawLedgerSq (x : Hermitian2Coordinates) : Int :=
  x.d0 * x.d0 + x.d1 * x.d1 +
    x.upper.re * x.upper.re + x.upper.im * x.upper.im

def frobeniusSq (x : Hermitian2Coordinates) : Int :=
  x.d0 * x.d0 + x.d1 * x.d1 +
    2 * (x.upper.re * x.upper.re + x.upper.im * x.upper.im)

def frobeniusInner
    (x y : Hermitian2Coordinates) : Int :=
  x.d0 * y.d0 + x.d1 * y.d1 +
    2 * (x.upper.re * y.upper.re + x.upper.im * y.upper.im)

def q : Hermitian2Coordinates :=
  { d0 := 2
    d1 := -1
    upper := { re := 1, im := 2 } }

def r : Hermitian2Coordinates :=
  { d0 := 1
    d1 := 3
    upper := { re := -2, im := 1 } }

def nearMiss : Matrix2 :=
  { a00 := { re := 2, im := 0 }
    a01 := { re := 1, im := 2 }
    a10 := { re := 1, im := 2 }
    a11 := { re := -1, im := 0 } }

#eval [decide (extract (assemble q) = q),
  decide (Matrix2.IsHermitian (assemble q)),
  decide (Matrix2.IsHermitian nearMiss)]

#eval [rawLedgerSq q, frobeniusSq q,
  frobeniusInner q r, frobeniusSq r]

example : extract (assemble q) = q := by decide
example : Matrix2.IsHermitian (assemble q) := by decide
example : ¬ Matrix2.IsHermitian nearMiss := by decide
example : rawLedgerSq q = 10 := by decide
example : frobeniusSq q = 15 := by decide
example : frobeniusInner q r = -1 := by decide
example : frobeniusSq r = 20 := by decide

end HermitianCoordinatesTutorial
~~~

Open a terminal in that scratch directory and type:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean HermitianCoordinatesTutorial.lean
~~~

This exact worksheet was executed successfully with Lean 4.32.0 while editing
this chapter. Its output was

~~~text
[true, true, false]
[10, 15, -1, 20]
~~~

Read the first line as: extraction reconstructs \(q\); assembled \(q\) is
Hermitian; the copied-without-conjugating near-miss is not. Read the second as
the raw ledger square, \(H\)'s Frobenius square, the real Frobenius inner
product of \(H\) with \(K\), and \(K\)'s Frobenius square. Each
<code>example</code> asks the kernel to certify the corresponding equality.

This miniature uses integer real-imaginary pairs, not Mathlib's
<code>ℂ</code> or <code>Matrix</code>. It does not prove the general
dimension count, measurable assembly, or the project theorem. Most
importantly, the command loads only the pinned Lean compiler and
<code>Std</code>; it does not run Lake, import Mathlib, or compile this project.

## The checked declaration map

The module
<code>NonlinearDynamics.Random.RandomMatrices.HermitianCoordinates</code>
exports 17 public declarations. The table separates checked content from
interpretations that the declaration does not add.

| Declaration | Checked content | Does not add |
|---|---|---|
| <code>StrictUpperIndex</code> | Finite pairs whose row is less than their column | A cardinality formula or random coordinates |
| <code>StrictUpperIndex.instFintype</code> | Finiteness of the strict-upper index type | An ordering of random variables |
| <code>StrictUpperIndex.instDecidableEq</code> | Decidable equality of strict-upper indices | Independence or identical distributions |
| <code>StrictUpperIndex.instIsEmptyZero</code> | No strict-upper index exists at size zero | A matrix law |
| <code>HermitianCoordinateSpace</code> | Real diagonal paired with complex strict upper triangle | Proof fields, a measure, or a scale |
| <code>RandomMatrix.hermitianFromCoordinates</code> | Direct three-branch matrix assembly | Gaussianity or normalization |
| <code>RandomMatrix.hermitianFromCoordinates_apply_diag</code> | Diagonal entry is the supplied real coordinate | A diagonal distribution |
| <code>RandomMatrix.hermitianFromCoordinates_apply_upper</code> | Upper entry is the supplied complex coordinate | An upper-coordinate distribution |
| <code>RandomMatrix.hermitianFromCoordinates_apply_lower</code> | Lower entry is the conjugate of the reflected upper coordinate | A free lower coordinate |
| <code>RandomMatrix.hermitianFromCoordinates_isHermitian</code> | Every assembled matrix is Hermitian | Unitary invariance of a law |
| <code>RandomMatrix.measurable_hermitianFromCoordinates</code> | Coordinatewise measurable processes assemble measurably | A probability measure or almost-everywhere repair |
| <code>RandomMatrix.hermitianCoordinateMap</code> | Named map from coordinate space to matrices | An inverse or linear equivalence |
| <code>RandomMatrix.measurable_hermitianCoordinateMap</code> | The named map is measurable | Measure preservation |
| <code>RandomMatrix.hermitianFromCoordinates_zero</code> | Zero-dimensional assembly is the zero matrix | A zero-dimensional ensemble law |
| <code>RandomMatrix.hermitianCoordinateMap_zero</code> | The named zero-dimensional map is constantly zero | A Dirac-law theorem |
| <code>HermitianRandomMatrix.ofCoordinates</code> | Bundled measurable pointwise-Hermitian sample map | A base probability measure |
| <code>HermitianRandomMatrix.ofCoordinates_apply</code> | Bundle evaluation reduces to direct assembly | Any law or moment statement |

The repository's recorded cloud validation compiled all 17 declarations with
warnings treated as errors under Lean 4.32.0 and the pinned Mathlib 4.32.0
dependency. The module contains no <code>sorry</code> or <code>admit</code>.
This educational rewrite does not claim a new project build on the Mac; the
guarded Linux command below is the exact route for a fresh replay.

### Inspect and check the exact project interfaces

{{< repo-check >}}
The authoritative source is
[<code>formalization/NonlinearDynamics/Random/RandomMatrices/HermitianCoordinates.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/HermitianCoordinates.lean).
On an approved Linux builder with the pinned project dependencies already
provisioned, a learner can put these exact lines in a temporary project
scratch file:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.HermitianCoordinates

open Matrix MeasureTheory
open scoped Matrix
open NonlinearDynamics.Random

#check StrictUpperIndex
#check HermitianCoordinateSpace
#print RandomMatrix.hermitianFromCoordinates
#check RandomMatrix.hermitianFromCoordinates_apply_diag
#check RandomMatrix.hermitianFromCoordinates_apply_upper
#check RandomMatrix.hermitianFromCoordinates_apply_lower
#check RandomMatrix.hermitianFromCoordinates_isHermitian
#check RandomMatrix.measurable_hermitianFromCoordinates
#check RandomMatrix.hermitianCoordinateMap
#check RandomMatrix.measurable_hermitianCoordinateMap
#check RandomMatrix.hermitianFromCoordinates_zero
#check RandomMatrix.hermitianCoordinateMap_zero
#check HermitianRandomMatrix.ofCoordinates
#check HermitianRandomMatrix.ofCoordinates_apply
~~~

<code>import</code> loads the exact project module and its pinned Mathlib
dependencies. <code>#print</code> shows the constructor body, while each
<code>#check</code> asks Lean to elaborate an existing declaration and report
its type. These commands neither sample a random matrix nor establish any
probability law. The guarded command below checks the authoritative source
file with the repository's cloud-build policy.
{{< /repo-check >}}

## Checked Lean and mathematical context are different layers

The \(n^2\) count suggests a bijection between \(\mathcal C_n\) and the real
vector space of Hermitian matrices. Read a Hermitian matrix's real diagonal
and strict upper triangle, then assemble them back. Conversely, assemble
coordinates and extract those same positions.

That paper argument is useful context, but RMT-05 does not package it as a Lean
inverse, equivalence, real-linear equivalence, topology theorem, or dimension
theorem. The forward measurable map is the smallest interface needed by the
next probability milestone. If later proofs need Jacobians, densities, or an
intrinsic Euclidean structure, the inverse and linear geometry should become
explicit declarations rather than being assumed from the count.

Likewise, measurability means that a source measure can be transported through
the assembly map. It does not identify the source measure, prove a pushforward
identity in this module, or establish invariance under unitary conjugation.

| Layer | Available now | Still separate |
|---|---|---|
| Algebraic coordinates | Strict-upper type, coordinate product, entry insertion | Extractor, inverse, real-linear equivalence |
| Coordinate geometry | Exact paper calculation for the running two-by-two ledgers | RMT-05 has no norm, inner-product, isometry, or dimension declaration |
| Symmetry | Pointwise Hermiticity for every input | Spectral applications in this module |
| Measurability | Coordinatewise assembly and canonical map | A base measure or probability law |
| Boundary | Unique zero-dimensional output is zero | A zero-dimensional ensemble policy |
| Probability | No claim | Coordinate laws, independence, pushforward law |
| Ensemble symmetry | No claim | Nontrivial unitary invariance |

## The ridge toward a finite Gaussian matrix law

At the RMT-05 boundary, the deterministic map made a later probability
construction possible without making it automatic. That law-level module
still needed to:

1. choose real random coordinates for the diagonal;
2. choose complex random coordinates for the strict upper triangle;
3. state their complete joint law and dependence structure;
4. select the diagonal variance and both real component variances of every
   complex upper coordinate;
5. state every dimension-dependent scale and the \(n=0\) policy;
6. define the coordinate probability measure;
7. push that measure through the measurable assembly map;
8. prove that the resulting law has Hermitian support; and
9. separately prove any nontrivial unitary-invariance or moment theorem.

The existing
{{< refterm "independent-cartesian-complex-gaussian-family" "independent Cartesian complex Gaussian family" >}}
can eventually supply the upper-coordinate side of such a ledger. It does not
supply the real diagonal family or decide the matrix normalization. The
{{< refterm "normalization-convention" "normalization convention" >}} entry
tracks the choices that remain open.

The lower triangle will never be an independent primitive family in this
route. Its entries are deterministic functions of upper coordinates. This
does not prevent the full matrix from having a rich law; it identifies the
correct primitive building blocks before assembly.

RMT-06 has now completed items 1 through 7 with a Wigner-scale coordinate
product law and an explicit zero branch. Measure-level Hermitian support,
unitary invariance, and moments remain separate. Continue to
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}})
for the completed probability bridge.

## Common wrong turns

### Treating every matrix slot as a primitive coordinate

This conflicts with Hermitian reflection unless lower entries are identified
with conjugates of upper entries. Use the strict upper triangle as the
primitive complex index type.

### Letting diagonal coordinates be arbitrary complex numbers

Hermitian diagonals must be real. A real-valued input type enforces this before
the proof begins.

### Using \(X+X^*\) without tracking the diagonal

Universal symmetrization doubles a real diagonal. It is not a transparent
insertion of already named coordinates.

### Giving the raw ledger the ordinary Euclidean dot product

The raw upper real and imaginary coordinates each appear in two matrix cells.
Without a factor of two in the coordinate metric, the running ledger has
squared length 10 while its assembled matrix has Frobenius square 15. Use the
weighted metric, or rescale upper coordinates by \(\sqrt2\), and state which
convention is active.

### Calling measurability a probability law

A measurable function has well-formed preimages. It has no distribution until
a measure on its domain is supplied.

### Calling the primitive coordinates independent

RMT-05 contains no independence assumption or theorem. It works for arbitrary
coordinate functions, including deterministically dependent ones.

### Inferring a GUE law from Hermiticity

Hermiticity is an algebraic support constraint. It fixes neither a Gaussian
law nor a dimension scale nor invariance under unitary conjugation.

### Ignoring \(n=0\) until a reciprocal appears

The deterministic coordinate map is well-defined at size zero. A later model
that uses \(1/n\) or \(1/\sqrt n\) must state its own boundary policy.

### Assuming the dimension count is already formalized

The count is correct mathematical context, but the module has no named
cardinality or dimension theorem. Cite the checked forward map for checked
claims and label the count as context.

## Exercises

1. **Count.** Derive the real-coordinate count for \(n=4\), then compare it
   with \(n^2\).
2. **Assemble.** Write the matrix produced from a real diagonal \((a,b)\) and
   one complex strict-upper coordinate \(x+iy\).
3. **Reflect.** Verify the entrywise Hermitian equation for \(j\lt i\) without
   citing the upper case.
4. **Geometry.** Recompute \(\lVert H\rVert_F^2=15\) directly from the four
   matrix entries, then recover the same answer from the weighted ledger.
5. **Cross term.** Expand
   \(\operatorname{Re}\sum_{i,j}\overline{H_{ij}}K_{ij}\) and verify that
   the two off-diagonal contributions have real part zero.
6. **Diagnose.** Build the upper-triangular temporary matrix for the worked
   example and compute the diagonal of \(X+X^*\).
7. **Measure.** Explain why conjugating a measurable complex coordinate
   preserves measurability but need not leave its law unchanged.
8. **Boundary.** Prove that any two matrices indexed by <code>Fin 0</code>
   are equal.
9. **Lean.** Change <code>nearMiss.a10.im</code> from 2 to -2 in the standalone
   worksheet and predict which output changes before rerunning it.
10. **Project Lean.** Locate the branch in
   <code>measurable_hermitianFromCoordinates</code> where conjugation is used.
11. **Design.** State the type of an inverse that extracts coordinates from a
   Hermitian matrix subtype.
12. **Scope.** Separate the hypotheses for a pushforward probability law from
   those needed for unitary invariance.

## Summit register

The checked module provides a finite strict-upper index type, a
normalization-free coordinate space, direct assembly, exact entry formulas,
pointwise Hermiticity, coordinatewise and canonical measurability, an explicit
zero-dimensional result, and a bundled measurable Hermitian sample map.

The mathematical count explains \(n^2\) real degrees of freedom, and the
running example explains the weighted norm and inner product. Neither is a
named theorem in this RMT-05 module. The standalone <code>Std</code> worksheet
checks only its finite integer model. The project module does not define an
inverse, dimension theorem, Frobenius isometry, probability measure,
coordinate law, independence, Gaussian ensemble, density, normalization,
unitary invariance, eigenvalue map, trace expectation, or asymptotic result.

That boundary is the achievement. A later probability module can now make
every distributional choice visibly rather than hiding one in matrix
bookkeeping.

## Where to continue

Use the
{{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}
entry for the compact definition, degree count, and boundary checklist.
[Random Matrices: From Outcomes to Spectra]({{< relref "/knowledge-base/deep-dives/random-matrices-from-outcomes-to-spectra" >}})
develops the surrounding sample-map, Hermiticity, law, and observable layers.

[Finite Product Probability Spaces and Independent Gaussian Fields]({{< relref "/knowledge-base/deep-dives/finite-product-probability-spaces-and-independent-gaussian-fields" >}})
provides exact finite product laws for independent complex coordinates.
[Gaussian Laws, Independence, and Normalization]({{< relref "/knowledge-base/deep-dives/gaussian-laws-independence-and-normalization" >}})
and [Complex Gaussian Coordinates and Geometry]({{< relref "/knowledge-base/deep-dives/complex-gaussian-coordinates-and-geometry" >}})
explain scalar laws and visible variance ledgers a later ensemble may use.

Read {{< refterm "probability-law" "probability law" >}} and
{{< refterm "pushforward-measure" "pushforward measure" >}} before transporting
a coordinate measure. Read
{{< refterm "unitary-invariance" "unitary invariance" >}} for the separate
law-level symmetry claim that direct assembly does not prove.

The next checked layer is
[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}}),
which supplies the Wigner ledger, canonical product measure, exact
independence architecture, and matrix pushforward.

## References

**Lean contributors.**
[Subtypes](https://lean-lang.org/doc/reference/latest/Basic-Types/Subtypes/),
The Lean Language Reference. This official reference explains the
value-plus-proof packaging used by <code>StrictUpperIndex</code> and the
notation <code>{x : α // p x}</code>.

**Mathlib contributors.**
[Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html),
Mathlib 4 documentation. This official API defines
<code>Matrix.IsHermitian</code> and its entrywise criterion.

**Mathlib contributors.**
[Measurable spaces and measurable functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/MeasurableSpace/Basic.html),
Mathlib 4 documentation. This is the official foundation for measurable
spaces, measurable maps, and composition.

**Mathlib contributors.**
[Finite index types](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/Fin/Basic.html),
Mathlib 4 documentation. This documents <code>Fin n</code> and the empty
<code>Fin 0</code> type used in the boundary proofs.

**John von Neumann.**
[Mathematical Foundations of Quantum Mechanics](https://doi.org/10.1515/9781400889921),
Princeton University Press, English translation first published in 1955.
This foundational source supplies the broader operator-theoretic physics
context for Hermitian observables and unitary evolution. The present Lean
module does not formalize that quantum-mechanical layer.

**Terence Tao.**
[Topics in Random Matrix Theory](https://doi.org/10.1090/gsm/132),
Graduate Studies in Mathematics 132, American Mathematical Society, 2012.
This monograph supplies broader context, not an unproved law for this module.

**Greg W. Anderson, Alice Guionnet, and Ofer Zeitouni.**
[An Introduction to Random Matrices](https://doi.org/10.1017/CBO9780511801334),
Cambridge Studies in Advanced Mathematics 118, Cambridge University Press,
2010. This monograph provides systematic context for Hermitian coordinate
models and Gaussian ensembles. The present chapter stops before those
probability choices.

The exact upstream Lean source audited for this chapter is
[Mathlib commit 81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
