---
title: "Finite Hermitian Matrices from Coordinates"
slug: "finite-hermitian-matrices-from-coordinates"
date: 2026-07-21
summary: "A textbook ascent from the nonredundant real and complex coordinates of a finite Hermitian matrix to direct assembly, Hermiticity, measurability, and the exact zero-dimensional boundary."
lead: "A Hermitian matrix does not have a free complex variable in every entry. Its true coordinates are a real diagonal and a complex strict upper triangle, assembled without hiding a scale."
draft: true
pro_reviewed: false
level: "Finite matrix foundations to measurable assembly"
reading_time: "50 to 70 minutes"
prerequisites: "Finite sets, complex conjugation, matrices, and functions; measurable spaces and Lean subtypes are introduced when necessary"
lean_module: "NonlinearDynamics.Random.RandomMatrices.HermitianCoordinates"
toc: true
og_image: "finite-hermitian-coordinates-card.png"
og_image_alt: "A warm-paper teaching card routes real diagonal, complex strict-upper, and conjugate-reflected lower entries through one deterministic map to a Hermitian matrix."
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
received the required human and Pro reviews. The page must remain a draft until
those gates are complete.
{{< /panel >}}

A finite complex Hermitian matrix satisfies one compact equation,
\(H^*=H\), but that equation hides a precise coordinate geometry. The diagonal
entries are real. An entry above the diagonal is complex and free. The
reflected entry below the diagonal is its complex conjugate and is therefore
not a second free coordinate.

This chapter turns that geometry into a deterministic program. It defines the
strict-upper index type, counts the real degrees of freedom, inserts every
supplied coordinate exactly once, proves Hermiticity by the three possible
index orderings, and proves measurability entry by entry. It also treats
dimension zero as an ordinary executable case.

No probability measure enters this construction. No coordinate is declared
Gaussian or independent. No Gaussian unitary ensemble (GUE) normalization,
matrix law, unitary invariance, spectral statistic, or asymptotic theorem is
selected. The chapter builds the deterministic bridge that those later layers
may use.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [The symmetry constraint removes redundant data](#base-camp-the-symmetry-constraint-removes-redundant-data) | Read a Hermitian matrix as free coordinates plus reflection |
| Dimension route | [Count the real degrees of freedom](#camp-one-count-the-real-degrees-of-freedom) | Derive the \(n^2\) real-coordinate count |
| Construction route | [Insert coordinates directly](#camp-three-insert-coordinates-directly) | Understand the diagonal, upper, and lower branches |
| Proof route | [Hermiticity is a three-case proof](#camp-five-hermiticity-is-a-three-case-proof) | Follow the exact entrywise argument used in Lean |
| Measurability route | [Measurability reduces to scalar coordinates](#camp-six-measurability-reduces-to-scalar-coordinates) | See why no measure or law is required |
| Lean route | [The checked declaration map](#the-checked-declaration-map) | Audit all 17 public declarations |
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
6. prove Hermiticity entry by entry using order trichotomy;
7. reduce matrix-valued measurability to scalar coordinate maps;
8. distinguish assembly from a bundled measurable Hermitian random matrix;
9. explain the zero-dimensional coordinate and matrix spaces; and
10. separate the 17 checked Lean declarations from unproved dimension,
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

The two real diagonal coordinates plus the two real components of \(u_{01}\)
give \(4=2^2\) real coordinates. For \(n=3\), three real diagonal coordinates
and three complex upper coordinates give \(3+2\cdot3=9=3^2\).

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

### A complete three-by-three assembly

Let

\[
d_0=2,\qquad d_1=-1,\qquad d_2=4
\]

and choose

\[
u_{01}=1+2i,\qquad
u_{02}=-3+i,\qquad
u_{12}=5-2i.
\]

Direct assembly gives

\[
H=
\begin{bmatrix}
2 & 1+2i & -3+i\\
1-2i & -1 & 5-2i\\
-3-i & 5+2i & 4
\end{bmatrix}.
\]

The diagonal values appear unchanged. Every lower entry is the conjugate of
the reflected upper entry. These values are a toy calculation, not empirical
measurements, random samples, or a selected ensemble convention.

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

All 17 declarations compile with warnings treated as errors under Lean 4.32.0
and the pinned Mathlib 4.32.0 dependency. The module contains no
<code>sorry</code> or <code>admit</code>.

### Reproduce the check

From the repository root:

~~~sh
source "$HOME/.elan/env"
cd formalization
lake env lean -DwarningAsError=true NonlinearDynamics/Random/RandomMatrices/HermitianCoordinates.lean
~~~

The command checks the actual module. It does not execute a random simulation,
estimate a spectrum, or validate an unformalized probability convention.

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
4. **Diagnose.** Build the upper-triangular temporary matrix for the worked
   example and compute the diagonal of \(X+X^*\).
5. **Measure.** Explain why conjugating a measurable complex coordinate
   preserves measurability but need not leave its law unchanged.
6. **Boundary.** Prove that any two matrices indexed by <code>Fin 0</code>
   are equal.
7. **Lean.** Locate the branch in
   <code>measurable_hermitianFromCoordinates</code> where conjugation is used.
8. **Design.** State the type of an inverse that extracts coordinates from a
   Hermitian matrix subtype.
9. **Scope.** Separate the hypotheses for a pushforward probability law from
   those needed for unitary invariance.

## Summit register

The checked module provides a finite strict-upper index type, a
normalization-free coordinate space, direct assembly, exact entry formulas,
pointwise Hermiticity, coordinatewise and canonical measurability, an explicit
zero-dimensional result, and a bundled measurable Hermitian sample map.

The mathematical count explains \(n^2\) real degrees of freedom, but it is not
yet a named Lean theorem. The module does not define an inverse, probability
measure, coordinate law, independence, Gaussian ensemble, density,
normalization, unitary invariance, eigenvalue map, trace expectation, or
asymptotic result.

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
