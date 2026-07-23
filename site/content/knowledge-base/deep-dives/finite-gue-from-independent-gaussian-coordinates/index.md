---
title: "Finite Gaussian Unitary Ensemble (GUE) from Independent Gaussian Coordinates"
slug: "finite-gue-from-independent-gaussian-coordinates"
date: 2026-07-21
summary: "At size two, follow four independent real Gaussian primitives through the Wigner variance ledger, Hermitian reflection, measurable assembly, and the exact finite Gaussian unitary ensemble matrix law."
lead: "Compute one complete matrix by hand, analyze two near-misses, and then climb from a deterministic coordinate map to the checked probability law."
draft: false
pro_reviewed: false
level: "First size-two ledger to the exact finite ensemble law"
reading_time: "75 to 95 minutes"
prerequisites: "Complex conjugation and finite arithmetic; Gaussian laws, product measures, Hermitian matrices, and pushforwards are introduced as they appear"
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsemble"
toc: true
og_image: "finite-gue-coordinate-law-card.png"
og_image_alt: "At matrix size two, diagonal variances one half and upper real and imaginary variances one quarter give four primitive real degrees and expected Frobenius square two; the toy coordinates two, negative one, one, and two assemble to a Hermitian matrix with trace one and Frobenius square fifteen."
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

## Start with one exact size-two ledger

A **Gaussian unitary ensemble (GUE)** is a
{{< refterm "probability-law" "probability law" >}} on complex matrices whose
realizations are {{< refterm "hermitian-matrix" "Hermitian" >}}. Hermitian
means that reflecting an entry across the diagonal also takes its complex
conjugate. The word *unitary* belongs to the classical symmetry of the law,
not to a claim that each matrix entry is a unitary number.

Begin at matrix size \(n=2\). There are two diagonal locations and one strict
upper-triangular location. The repository's Wigner scale is

\[
s_2=\frac12.
\]

The diagonal variables use {{< refterm "variance" "variance" >}} \(s_2\),
while each real Cartesian component of the complex upper variable uses half
of that variance. Name the four primitive real variables

\[
d_0,\qquad d_1,\qquad x,\qquad y.
\]

Their exact parameter ledger is

| Primitive coordinate | Exact law | Mean | Variance |
|---|---|---:|---:|
| first diagonal \(d_0\) | real Gaussian \(N(0,1/2)\) | \(0\) | \(1/2\) |
| second diagonal \(d_1\) | real Gaussian \(N(0,1/2)\) | \(0\) | \(1/2\) |
| upper real part \(x\) | real Gaussian \(N(0,1/4)\) | \(0\) | \(1/4\) |
| upper imaginary part \(y\) | real Gaussian \(N(0,1/4)\) | \(0\) | \(1/4\) |

Here \(N(0,v)\) means a real Gaussian law with mean zero and **variance**
\(v\). Its standard deviation is \(\sqrt v\), so the two quantities must not
be interchanged. The repository builds a nested product law: \(d_0,d_1\) are
the real diagonal block, \(x+iy\) is the complex upper block, the two blocks
are {{< refterm "independence" "independent" >}}, and \(x\) and \(y\) are
independent inside the Cartesian complex law. Independence means that joint
event probabilities factor; it does not mean realized values must differ.

The count of primitive real degrees of freedom is

\[
2+2\binom22=2+2=4=2^2.
\]

The first \(2\) counts the real diagonal. The second \(2\) counts the real and
imaginary parts of the single strict-upper coordinate. The reflected lower
entry contributes no new freedom.

### Assemble one deterministic coordinate point

A law assigns mass to measurable subsets of its value space. To test the
deterministic assembly map, choose one exact toy coordinate point:

\[
(d_0,d_1,x,y)=(2,-1,1,2).
\]

This tuple is not an estimate, sample statistic, or claim that a continuous
Gaussian experiment hits this exact point with positive probability. It is a
fixed input used to check the map. Set \(u=x+iy=1+2i\). Hermitian assembly
produces

\[
H=
\begin{bmatrix}
2 & 1+2i \\
1-2i & -1
\end{bmatrix}.
\]

The conjugate transpose swaps the off-diagonal entries and conjugates them.
Since \(\overline{1+2i}=1-2i\),

\[
H^*=H.
\]

The ordinary, unnormalized matrix trace is the diagonal sum:

\[
\operatorname{Tr}(H)=2+(-1)=1.
\]

The squared Frobenius norm is the sum of the squared magnitudes of all four
entries:

\[
\begin{aligned}
\lVert H\rVert_{\mathrm F}^2
&=|2|^2+|1+2i|^2+|1-2i|^2+|-1|^2\\
&=4+5+5+1\\
&=15.
\end{aligned}
\]

For a Hermitian matrix, \(H^*H=H^2\), so this same number is
\(\operatorname{Tr}(H^2)\). Notice the two copies of \(5\): the single
primitive complex upper coordinate appears twice in the assembled matrix.

The **law-level** variance budget uses the same slots but answers a different
question. Centering makes each expected square equal its variance, so

\[
\begin{aligned}
\mathbb E\lVert H\rVert_{\mathrm F}^2
&=2\left(\frac12\right)
 +2\left(\frac14+\frac14\right)\\
&=2.
\end{aligned}
\]

The number \(15\) belongs to the displayed deterministic point; the number
\(2\) belongs to the chosen distribution. RMT-06 fixes the exact coordinate
laws but does not itself prove this expectation identity. The later checked
module
<code>NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleMoments</code>
proves the corresponding all-dimensional statement
\(\mathbb E[\operatorname{Tr}(H^2)]=n\).

{{< reference-figure
  wide="true"
  src="gue-n2-coordinate-ledger.svg"
  alt="At matrix size two, two diagonal Gaussian variances are one half and the upper real and imaginary variances are one quarter. The toy coordinate values two, negative one, one, and two assemble to a Hermitian matrix with trace one and Frobenius-square contributions four, five, five, and one, totaling fifteen."
  caption="**Finding:** the size-two Wigner law has four primitive real degrees with variances \((1/2,1/2,1/4,1/4)\). The exact toy coordinate point \((2,-1,1,2)\) assembles to rows \((2,1+2i)\) and \((1-2i,-1)\), so conjugate reflection holds, the trace is 1, and the Frobenius-square ledger is \(4+5+5+1=15\). The bottom strip separately computes the distribution-level expected Frobenius square \(2\). These are exact toy values and law parameters, not empirical or simulated observations."
>}}

### In Lean: expose the size-two Wigner scale

{{< lean-bridge
  human="At matrix size two, a diagonal coordinate has variance one half, and each real Cartesian component of the strict-upper coordinate has variance one quarter."
  math="\(d_2=1/2\quad\text{and}\quad a_2=1/4.\)"
  lean="(GUE.diagonalVariance_succ 1, GUE.upperCartesianVariance_succ 1)"
>}}

- <code>GUE</code> is the namespace containing the repository's selected finite
  ensemble convention.
- <code>diagonalVariance_succ 1</code> specializes the positive-size diagonal
  formula to \(1+1=2\).
- <code>upperCartesianVariance_succ 1</code> specializes the upper real-part
  and imaginary-part formula to the reciprocal of \(2(1+1)=4\).
- The surrounding parentheses form one Lean pair of proof terms. They do not
  pair the two variances into an undocumented single "complex variance."
- Both results live in \(\mathbb R_{\ge0}\), written <code>ℝ≥0</code>, so a
  negative variance cannot be supplied.
{{< /lean-bridge >}}

## Two near-misses identify the required conditions

### Near-miss A: copy the upper entry without conjugating it

Replace the lower-left entry by another copy of \(1+2i\):

\[
K=
\begin{bmatrix}
2 & 1+2i \\
1+2i & -1
\end{bmatrix}.
\]

This matrix still satisfies

\[
\operatorname{Tr}(K)=1,
\qquad
\lVert K\rVert_{\mathrm F}^2=15.
\]

Those two scalar checks do not see the sign error. But
\(K^*\ne K\), because its lower-left entry should be \(1-2i\). A constructor
that merely copies the upper triangle has failed before probability enters.

### Near-miss B: keep the map but remove the Wigner scale

Suppose all four primitive real coordinates instead have variance one. The
same Hermitian assembly map is still valid, but its expected squared
Frobenius budget becomes

\[
2(1)+2(1+1)=6,
\]

not \(2\). This defines a legitimate Gaussian Hermitian matrix law, but it is
not <code>GUE.matrixLaw 2</code> under this repository's normalization. A map
does not remember which source law was pushed through it.

{{< reference-figure
  wide="true"
  src="gue-n2-independence-and-near-misses.svg"
  alt="The source law makes two diagonal Gaussians independent of one complex upper Gaussian and makes its real and imaginary parts independent. Hermitian assembly then makes the lower matrix entry the conjugate of the upper entry, so those reflected entries are dependent. Copying rather than conjugating fails Hermiticity despite the same trace and Frobenius square, while unit component variances give expected Frobenius square six instead of two."
  caption="**Finding:** independence belongs to the primitive source coordinates, while reflection creates deterministic dependence between matrix entries. The wrong-reflection matrix keeps trace 1 and Frobenius square 15 but is not Hermitian. The unscaled law keeps the assembly map but changes the expected Frobenius-square budget from 2 to 6. The zero-size branch has no primitive coordinates and ends in Dirac laws. Every displayed number is an exact toy or normalization value, not a sample statistic."
>}}

### In Lean: the deterministic map owns the reflection rule

{{< lean-bridge
  human="Place each real coordinate on the diagonal, each complex primitive above the diagonal, and the conjugate of that primitive in the reflected lower position."
  math="\(A_n(d,u)_{ij}=u_{ij}\) for \(i\lt j\), \(A_n(d,u)_{ji}=\overline{u_{ij}}\), and \(A_n(d,u)_{ii}=d_i.\)"
  lean="RandomMatrix.hermitianFromCoordinates d u"
>}}

- <code>d : Fin n → ℝ</code> is the real diagonal function.
- <code>u : StrictUpperIndex n → ℂ</code> stores only positions with
  \(i\lt j\).
- <code>hermitianFromCoordinates</code> branches on the comparison between the
  row and column. The lower branch uses <code>star</code>, complex conjugation.
- The theorem
  <code>RandomMatrix.hermitianFromCoordinates_isHermitian d u</code> checks
  Hermiticity for every input. It needs no Gaussian law or independence.
- This expression returns a matrix. It is not <code>GUE.matrixLaw n</code>,
  which is a measure on matrices.
{{< /lean-bridge >}}

{{< repo-check module="NonlinearDynamics.Random.RandomMatrices.HermitianCoordinates" >}}
**Full project check.** After installing the repository's pinned dependencies,
place the following source in a temporary project scratch file:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.HermitianCoordinates

open Matrix
open NonlinearDynamics.Random

#print StrictUpperIndex
#print HermitianCoordinateSpace
#print RandomMatrix.hermitianFromCoordinates
#check RandomMatrix.hermitianFromCoordinates_apply_diag
#check RandomMatrix.hermitianFromCoordinates_apply_upper
#check RandomMatrix.hermitianFromCoordinates_apply_lower
#check RandomMatrix.hermitianFromCoordinates_isHermitian
#check RandomMatrix.measurable_hermitianCoordinateMap
#check RandomMatrix.hermitianCoordinateMap_zero
~~~

<code>#print</code> exposes a definition. <code>#check</code>
elaborates an existing declaration and displays its type. The full project
command rendered below checks the exact Mathlib-backed project module.
{{< /repo-check >}}

## Type the complete finite ledger with Lean and Std

The exact Gaussian measures and matrix libraries need Mathlib, so they are full
project checks and may require substantial disk space and memory. The size-two
arithmetic and reflection logic fit in a standalone worksheet importing only
Lean's <code>Std</code> library. Save this exact file as
<code>/tmp/GUEN2Ledger.lean</code> on a normal macOS or Linux host:

~~~lean
import Std

namespace GUEN2Ledger

structure ComplexInt where
  re : Int
  im : Int
deriving Repr, DecidableEq

def conj (z : ComplexInt) : ComplexInt :=
  { re := z.re, im := -z.im }

def normSq (z : ComplexInt) : Nat :=
  z.re.natAbs ^ 2 + z.im.natAbs ^ 2

structure Matrix2 where
  h00 : ComplexInt
  h01 : ComplexInt
  h10 : ComplexInt
  h11 : ComplexInt
deriving Repr, DecidableEq

def assemble (d0 d1 x y : Int) : Matrix2 :=
  let upper : ComplexInt := { re := x, im := y }
  { h00 := { re := d0, im := 0 }
    h01 := upper
    h10 := conj upper
    h11 := { re := d1, im := 0 } }

def wrongReflection (d0 d1 x y : Int) : Matrix2 :=
  let upper : ComplexInt := { re := x, im := y }
  { h00 := { re := d0, im := 0 }
    h01 := upper
    h10 := upper
    h11 := { re := d1, im := 0 } }

def isHermitian (H : Matrix2) : Bool :=
  H.h00.im == 0 && H.h11.im == 0 && H.h10 == conj H.h01

def trace (H : Matrix2) : ComplexInt :=
  { re := H.h00.re + H.h11.re, im := H.h00.im + H.h11.im }

def frobeniusLedger (H : Matrix2) : List Nat :=
  [normSq H.h00, normSq H.h01, normSq H.h10, normSq H.h11]

def frobeniusSq (H : Matrix2) : Nat :=
  (frobeniusLedger H).sum

def strictUpperCount (n : Nat) : Nat :=
  n * (n - 1) / 2

def realDegrees (n : Nat) : Nat :=
  n + 2 * strictUpperCount n

def varianceScale (n : Nat) : Rat :=
  if n = 0 then 0 else 1 / n

def diagonalVariance (n : Nat) : Rat :=
  varianceScale n

def upperCartesianVariance (n : Nat) : Rat :=
  varianceScale n / 2

def expectedFrobeniusFromLedger
    (n : Nat) (diagVar upperPartVar : Rat) : Rat :=
  n * diagVar + 2 * strictUpperCount n * (2 * upperPartVar)

def H : Matrix2 := assemble 2 (-1) 1 2
def K : Matrix2 := wrongReflection 2 (-1) 1 2

#eval (varianceScale 0, strictUpperCount 0, realDegrees 0)
#eval [varianceScale 2, diagonalVariance 2, upperCartesianVariance 2]
#eval [strictUpperCount 2, realDegrees 2]
#eval H
#eval [isHermitian H, isHermitian K]
#eval trace H
#eval frobeniusLedger H
#eval frobeniusSq H
#eval [expectedFrobeniusFromLedger 2 (1 / 2) (1 / 4),
  expectedFrobeniusFromLedger 2 1 1]

example : diagonalVariance 2 = 1 / 2 := by native_decide
example : upperCartesianVariance 2 = 1 / 4 := by native_decide
example : varianceScale 0 = 0 := by native_decide
example : realDegrees 0 = 0 := by decide
example : realDegrees 2 = 4 := by decide
example : isHermitian H = true := by decide
example : isHermitian K = false := by decide
example : trace H = { re := 1, im := 0 } := by decide
example : frobeniusLedger H = [4, 5, 5, 1] := by decide
example : frobeniusSq H = 15 := by decide
example : expectedFrobeniusFromLedger 2 (1 / 2) (1 / 4) = 2 := by
  native_decide
example : expectedFrobeniusFromLedger 2 1 1 = 6 := by native_decide

end GUEN2Ledger
~~~

Type these commands exactly:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean /tmp/GUEN2Ledger.lean
~~~

This exact worksheet was executed successfully with Lean 4.32.0. It printed:

~~~text
(0, 0, 0)
[(1 : Rat)/2, (1 : Rat)/2, (1 : Rat)/4]
[1, 4]
{ h00 := { re := 2, im := 0 }, h01 := { re := 1, im := 2 }, h10 := { re := 1, im := -2 }, h11 := { re := -1, im := 0 } }
[true, false]
{ re := 1, im := 0 }
[4, 5, 5, 1]
15
[2, 6]
~~~

The first line is the size-zero scale, strict-upper count, and real-degree
count. The second line is the size-two scale, diagonal variance, and upper
component variance. The third line is the single strict-upper location
followed by four real degrees. The matrix record makes the conjugate sign
visible. The Boolean pair confirms that the correct matrix is Hermitian and
the copied-sign near-miss is not. The remaining lines give trace, the
four-entry Frobenius ledger, its sum, and the selected-versus-unscaled expected
budgets.

<code>ComplexInt</code> is a tiny tutorial-only pair of integer coordinates;
it is not Lean's full complex-number type and carries no Gaussian law.
<code>Rat</code> stores exact rational numbers, so the variance output preserves
\(1/2\) and \(1/4\) rather than rounding them to floating-point decimals.
<code>native_decide</code> evaluates rational equalities using Lean's native
decision procedure; <code>decide</code> suffices for the finite integer and
Boolean checks. This worksheet checks only the finite data transformations
it defines. It does not define a Gaussian measure, prove independence, or replace
the full Mathlib-backed module checks.

A finite GUE matrix can now be summarized in one sentence: choose independent
centered Gaussian free coordinates at the Wigner scale, assemble a Hermitian
matrix, and push the coordinate law through that measurable map. The rest of
the chapter expands each phrase without confusing a coordinate point, a sample
map, a deterministic assembly map, and a probability law.

The sixth random-matrix-theory milestone (RMT-06) answers the finite
law-construction questions with 26 checked declarations. It fixes one
normalization, constructs one canonical coordinate probability measure,
proves its exact laws and independence structure, pushes it through measurable
Hermitian assembly, transfers exact diagonal and upper entry laws, and proves
a Dirac boundary in dimension zero.

This chapter does not silently import the rest of random-matrix theory. A
classical density, eigenvalue density, semicircle law, and universality remain
outside RMT-06. Later checked project modules now prove that the Hermitian set
has full measure, unitary-conjugation invariance, the first two trace
expectations, and finite spectral-measure interfaces. Those later results are
identified as such rather than retroactively attributed to the constructor
module.

## Choose a route up

| Route | Begin with | Destination |
|---|---|---|
| First encounter | [The exact size-two ledger](#start-with-one-exact-size-two-ledger) | Compute every variance, reflected entry, degree count, trace, and Frobenius term |
| Hands-on Lean route | [The standalone <code>Std</code> worksheet](#type-the-complete-finite-ledger-with-lean-and-std) | Execute the finite arithmetic without Mathlib or Lake |
| Type route | [Name the three spaces](#base-camp-name-the-three-spaces) | Distinguish coordinates, assembly, and a matrix law |
| Normalization route | [The Wigner ledger](#camp-one-the-wigner-ledger) | Derive every variance and the factor of two |
| Probability route | [Build the coordinate measure](#camp-three-build-the-coordinate-measure) | See why a product law contains dependence information |
| Independence route | [Three scopes of independence](#camp-four-three-scopes-of-independence) | Separate block, within-block, and cross-coordinate claims |
| Transport route | [Push the law through assembly](#camp-six-push-the-law-through-assembly) | Follow the measurable map into matrix space |
| Lean route | [The checked declaration map](#the-checked-declaration-map) | Audit all 26 public declarations |
| Boundary route | [Dimension zero](#camp-eight-dimension-zero-is-a-dirac-law) | Understand the total zero-size policy |

### Learning objectives

By the summit, you should be able to:

1. reproduce the exact \(n=2\) law ledger, four-degree count, assembled matrix,
   trace \(1\), and Frobenius square \(15\);
2. explain why the wrong-reflection matrix fails even though its trace and
   Frobenius square match the correct toy matrix;
3. state the complete positive-dimensional GUE normalization ledger used here;
4. derive \(\mathbb E|H_{ij}|^2=1/n\) from two component variances;
5. derive the factor of two in
   \(\operatorname{Tr}(H^2)\) from Hermitian reflection;
6. distinguish a coordinate point, assembly map, coordinate law, and matrix
   law;
7. distinguish scalar marginals from a finite joint product law;
8. identify block independence, mutual independence within each block, and
   cross-block coordinate independence as separate theorem shapes;
9. explain why measurable assembly is the bridge from coordinates to a matrix
   law;
10. state the full Cartesian complex law of a diagonal matrix entry, including
   its zero imaginary variance;
11. explain why reflected upper and lower entries are not independent primitive
   coordinates;
12. compute the unique zero-dimensional coordinate and matrix laws; and
13. separate all 26 checked declarations from later density, invariance,
    spectral, moment, and asymptotic work.

## The construction in one picture

{{< reference-figure
  src="gue-law-construction.svg"
  alt="The Wigner normalization feeds a product measure on real diagonal and complex strict-upper coordinates; exact laws and independence precede measurable Hermitian assembly, whose pushforward is the finite GUE matrix law. Later modules prove that the Hermitian set has mass one and check unitary invariance, finite spectra, and first trace moments, while density and semicircle asymptotics remain unformalized."
  caption="**Finding:** the finite matrix law is the endpoint of a dependency chain. Scale comes before product law; product law comes before exact independence interfaces; measurable Hermitian assembly comes before the pushforward law. The solid path is checked in RMT-06, including dimension zero. The gray boundary is not attributed to this constructor: later modules now prove that the Hermitian set has mass one and check unitary invariance, finite spectral laws, and first trace moments, while density and semicircle asymptotics remain unformalized."
>}}

## Base camp: name the three spaces

Fix a natural number \(n\). Three spaces play different roles.

First is the {{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}

\[
\mathcal C_n
=(\operatorname{Fin}(n)\to\mathbb R)
 \times
 (I_n^{\lt}\to\mathbb C),
\]

where \(I_n^{\lt}\) contains index pairs \((i,j)\) with \(i\lt j\). A point
\(c=(d,u)\) stores a real diagonal \(d\) and a complex strict upper triangle
\(u\). It is not yet random.

Second is the ambient matrix space

\[
\mathcal M_n
=\operatorname{Matrix}(\operatorname{Fin}(n),\operatorname{Fin}(n),\mathbb C).
\]

The deterministic assembly map \(A_n:\mathcal C_n\to\mathcal M_n\) is

\[
(A_n(d,u))_{ij}
{} =
\begin{cases}
u_{ij},&i\lt j,\\
d_i,&i=j,\\
\overline{u_{ji}},&j\lt i.
\end{cases}
\]

Every output is {{< refterm "hermitian-matrix" "Hermitian" >}}, and RMT-05
proved this map measurable.

Third is a space of probability measures. A coordinate law
\(\nu_n\) is a measure on \(\mathcal C_n\). A matrix law \(\mu_n\) is a
measure on \(\mathcal M_n\). RMT-06 defines

\[
\mu_n=(A_n)_*\nu_n.
\]

This distinction prevents a common category error. A coordinate point is not
a sample map; an assembly function is not a law; a law is not a realized
matrix. Each layer needs its own definition and proof.

{{< checkpoint stage="Base camp" title="The ensemble is a measure" >}}
The finite GUE constructed here is the matrix probability measure
\(\mu_n\). Coordinates supply its source law, and assembly supplies the
measurable transport. No individual matrix is itself an ensemble.
{{< /checkpoint >}}

## Camp one: the Wigner ledger

The project stores variances in \(\mathbb R_{\ge0}\), Lean's nonnegative real
type. Define the total scale

\[
s_n=
\begin{cases}
0,&n=0,\\
1/n,&n\gt0.
\end{cases}
\]

The zero branch is a definition, not an interpretation of division by zero.
For positive \(n\), the coordinate ledger is

\[
\operatorname{Var}(d_i)=s_n=\frac1n,
\]

and, writing \(u_{ij}=x_{ij}+iy_{ij}\),

\[
\operatorname{Var}(x_{ij})
=\operatorname{Var}(y_{ij})
=\frac{s_n}{2}
=\frac{1}{2n}.
\]

All means are zero. Real and imaginary parts inside one Cartesian complex law
are independent by its product-law definition. The upper complex coordinates
are mutually independent. The diagonal real coordinates are mutually
independent. The two entire blocks are independent.

Lean gives the scale three names:

~~~lean
noncomputable def varianceScale : ℕ → ℝ≥0
  | 0 => 0
  | n + 1 => (((n + 1 : ℕ) : ℝ≥0))⁻¹

noncomputable def diagonalVariance (n : ℕ) : ℝ≥0 :=
  varianceScale n

noncomputable def upperCartesianVariance (n : ℕ) : ℝ≥0 :=
  varianceScale n / 2
~~~

The successor formulas expose the positive-dimensional meaning without a side
condition:

\[
\begin{aligned}
s_{n+1}&=\frac{1}{n+1},\\
d_{n+1}&=\frac{1}{n+1},\\
a_{n+1}&=\frac{1}{2(n+1)}.
\end{aligned}
\]

Here \(d_n\) abbreviates the diagonal variance and \(a_n\) the variance of
each displayed real coordinate of an upper entry. Named zero formulas expose
all three values at \(n=0\).

### The complex second-moment check

For a strict-upper entry \(u_{ij}=x_{ij}+iy_{ij}\),

\[
|u_{ij}|^2=x_{ij}^2+y_{ij}^2.
\]

The components are centered, so for positive \(n\),

\[
\begin{aligned}
\mathbb E|u_{ij}|^2
&=\mathbb E[x_{ij}^2]+\mathbb E[y_{ij}^2]\\
&=\operatorname{Var}(x_{ij})+\operatorname{Var}(y_{ij})\\
&=\frac{1}{2n}+\frac{1}{2n}\\
&=\frac1n.
\end{aligned}
\]

This is why the number \(1/(2n)\) belongs to each **real Cartesian part**.
Saying merely that an upper entry has variance \(1/n\) is ambiguous unless
"variance" is explicitly defined as total complex squared magnitude.

RMT-06 does not prove this expectation identity. It checks both exact
component laws. The expectation calculation is a direct mathematical
consequence once the existing complex-Gaussian integrability and second-moment
interfaces are combined, but that combination has no named theorem here.

## Camp two: the factor-of-two geometry

The Wigner ledger is also the coordinate form of the conventional quadratic
GUE density. The bridge is a geometric identity.

For a Hermitian matrix \(H\),

\[
\operatorname{Tr}(H^2)
=\sum_i(H^2)_{ii}
=\sum_i\sum_j H_{ij}H_{ji}.
\]

Hermiticity gives \(H_{ji}=\overline{H_{ij}}\), hence

\[
H_{ij}H_{ji}=|H_{ij}|^2.
\]

The diagonal terms appear once. Every unordered off-diagonal pair
\(\{i,j\}\) appears twice, once as \((i,j)\) and once as \((j,i)\). Therefore

\[
\operatorname{Tr}(H^2)
=\sum_i H_{ii}^2
 +2\sum_{i\lt j}|H_{ij}|^2.
\]

Writing \(H_{ii}=d_i\) and \(H_{ij}=x_{ij}+iy_{ij}\) above the diagonal gives

\[
\operatorname{Tr}(H^2)
=\sum_i d_i^2
 +2\sum_{i\lt j}(x_{ij}^2+y_{ij}^2).
\]

Now consider, as mathematical context, the density shape

\[
\exp\!\left(-\frac n2\operatorname{Tr}(H^2)\right).
\]

In free coordinates its exponent is

\[
-\sum_i\frac n2d_i^2
-\sum_{i\lt j}n(x_{ij}^2+y_{ij}^2).
\]

A centered real Gaussian with variance \(v\) has exponent
\(-x^2/(2v)\). Comparing coefficients gives \(v=1/n\) on the diagonal and
\(v=1/(2n)\) for each upper real part. The apparently asymmetric ledger is
exactly what the Hermitian trace geometry requires.

This derivation also identifies a formal boundary. To prove a matrix density
in Lean, the project will need a concrete real-linear model of Hermitian
matrices, a reference volume, an equivalence with coordinates, and a
change-of-variables argument. RMT-06 defines no density and proves no Jacobian.
It uses the coordinate product law directly.

## Camp three: build the coordinate measure

Let

\[
\gamma_{0,v}
\]

denote the centered real Gaussian measure with variance \(v\). For the
diagonal block, form the finite indexed product

\[
D_n=\bigotimes_{i\in\operatorname{Fin}(n)}\gamma_{0,d_n}.
\]

For one strict-upper index \(q\), the Cartesian complex law is the image of

\[
\gamma_{0,a_n}\otimes\gamma_{0,a_n}
\]

under \((x,y)\mapsto x+iy\). Form the finite product of these complex laws:

\[
U_n=\bigotimes_{q\in I_n^{\lt}}
\operatorname{CGauss}_{\mathrm{cart}}(0;a_n,a_n).
\]

The coordinate measure is the product of the two blocks:

\[
\nu_n=D_n\otimes U_n.
\]

The Lean definition mirrors this formula:

~~~lean
noncomputable def coordinateMeasure (n : ℕ) :
    Measure (HermitianCoordinateSpace n) :=
  (gaussianProductMeasure
      (fun _ : Fin n => 0)
      (fun _ => diagonalVariance n)).prod
    (cartesianComplexGaussianProductMeasure
      (fun _ : StrictUpperIndex n => 0)
      (fun _ => upperCartesianVariance n)
      (fun _ => upperCartesianVariance n))
~~~

Every scalar factor is a probability measure. A finite product of probability
measures is a probability measure, and a binary product of probability
measures is again one. The instance
<code>instIsProbabilityMeasureCoordinateMeasure</code> records this for every
\(n\), including zero.

The definition has no arbitrary sample enumeration. It is a canonical law on
the function spaces themselves. Coordinate evaluation is the random-variable
map. This makes exact marginals and independence accessible through Mathlib's
finite product-measure application programming interface (API).

## Camp four: three scopes of independence

The word "independent" can describe several families at different levels.
RMT-06 proves each needed scope explicitly.

### Scope one: the two blocks

Under \(\nu_n=D_n\otimes U_n\), the projections

\[
\pi_D(d,u)=d,
\qquad
\pi_U(d,u)=u
\]

have laws \(D_n\) and \(U_n\). The theorems
<code>coordinateMeasure_hasLaw_diagonalBlock</code> and
<code>coordinateMeasure_hasLaw_upperBlock</code> state those exact full-vector
laws. The theorem
<code>coordinateMeasure_indepFun_diagonal_upper</code> states that the two
projection functions are independent.

This is stronger than saying a particular \(d_i\) is independent of one
\(u_q\). It is independence of the sigma-algebras generated by the whole
vectors.

### Scope two: coordinates inside each block

Theorems
<code>coordinateMeasure_diagonal_iIndepFun</code> and
<code>coordinateMeasure_upper_iIndepFun</code> state mutual independence of
the evaluation families

\[
i\longmapsto((d,u)\mapsto d_i)
\]

and

\[
q\longmapsto((d,u)\mapsto u_q).
\]

Mutual independence is the finite-family property needed for arbitrary finite
subcollections, not merely pairwise independence.

### Scope three: one coordinate across blocks

For every diagonal index \(i\) and strict-upper index \(q\), the theorem
<code>coordinateMeasure_diagonal_indepFun_upper</code> proves

\[
((d,u)\mapsto d_i)
\quad\text{is independent of}\quad
((d,u)\mapsto u_q).
\]

This theorem follows by composing block independence with measurable
coordinate evaluations. It is exposed because scalar cross-block independence
is often the exact hypothesis a later calculation needs.

### In Lean: independence is stored on the source law

{{< lean-bridge
  human="Under the coordinate probability law, the complete real diagonal vector is independent of the complete complex strict-upper vector."
  math="\(\pi_D\perp\!\!\!\perp\pi_U\quad\text{under }\nu_n=D_n\otimes U_n.\)"
  lean="GUE.coordinateMeasure_indepFun_diagonal_upper n"
>}}

- <code>coordinateMeasure</code> is the probability measure \(\nu_n\) on the
  pair of coordinate blocks.
- <code>Prod.fst</code> and <code>Prod.snd</code>, implicit in the theorem's
  result, are the two block projections \(\pi_D\) and \(\pi_U\).
- <code>IndepFun</code> states independence of the functions under a named
  measure. It does not say the two output values are unequal or unrelated
  pointwise.
- The theorem is stronger than one selected diagonal-upper pair. Separate
  theorems expose mutual independence within each block and any one
  cross-block pair.
- The theorem is about primitive coordinate blocks before assembly. It makes
  no independence claim about \(H_{01}\) and \(H_{10}\).
{{< /lean-bridge >}}

### What independence does not apply to

After assembly, \(H_{ji}=\overline{H_{ij}}\). These two reflected entries are
deterministically related. They are not separate primitive coordinates and
are not claimed independent. Similarly, the real and imaginary components
inside one upper entry are independent because its Cartesian complex law is a
product, but the matrix-level module does not restate that fact as a separate
entry-component theorem.

## Camp five: exact scalar coordinate laws

Full block laws imply exact marginal laws by evaluation.

For every \(i:\operatorname{Fin}(n)\),

\[
d_i\sim\gamma_{0,d_n}.
\]

This is
<code>coordinateMeasure_diagonal_hasLaw</code>, an exact
<code>HasRealGaussianLaw</code> statement. It does not merely say
"qualitatively Gaussian."

For every \(q:I_n^{\lt}\),

\[
u_q\sim
\operatorname{CGauss}_{\mathrm{cart}}(0;a_n,a_n).
\]

This is <code>coordinateMeasure_upper_hasLaw</code>, an exact
<code>HasCartesianComplexGaussianLaw</code> statement. The two equal variance
arguments remain visible. No undifferentiated "complex variance" appears.

For \(n\gt0\), substitution gives

\[
d_i\sim N(0,1/n)
\]

and

\[
\operatorname{Re}u_q,\operatorname{Im}u_q
\sim N(0,1/(2n))
\]

with independent Cartesian parts. At \(n=0\), there is no \(i\) or \(q\) at
which to instantiate these theorems. The total measure still exists and is
handled separately.

{{< checkpoint stage="Camp five" title="Marginals do not replace the joint law" >}}
The scalar theorems make computations convenient. The earlier block product
laws and independence theorems carry the joint information. Keeping both
layers prevents the incorrect inference that a list of Gaussian marginals
determines a GUE.
{{< /checkpoint >}}

## Camp six: push the law through assembly

RMT-05 proved that the deterministic coordinate map \(A_n\) is measurable.
RMT-06 can therefore define the
{{< refterm "pushforward-measure" "pushforward" >}}

\[
\mu_n=(A_n)_*\nu_n
\]

without an extra measurability hypothesis from the caller.

In Lean:

~~~lean
noncomputable def matrixLaw (n : ℕ) :
    Measure (Matrix (Fin n) (Fin n) ℂ) :=
  RandomMatrix.law
    (RandomMatrix.hermitianCoordinateMap n)
    (RandomMatrix.measurable_hermitianCoordinateMap n)
    (coordinateMeasure n)
~~~

### In Lean: finite GUE begins at the pushed-forward matrix law

{{< lean-bridge
  human="The finite GUE matrix probability law is the image of the independent coordinate probability law under measurable Hermitian assembly."
  math="\(\mu_n=(A_n)_*\nu_n.\)"
  lean="GUE.matrixLaw_eq_map n"
>}}

- <code>GUE.matrixLaw n</code> is a <code>Measure</code> on ambient
  \(n\)-by-\(n\) complex matrices. This is where the repository names the
  finite ensemble.
- <code>Measure.map</code> is Mathlib's pushforward operation. It transports
  mass through a function; it does not execute a pseudorandom sampler.
- <code>RandomMatrix.hermitianCoordinateMap n</code> is the deterministic map
  \(A_n\).
- <code>GUE.coordinateMeasure n</code> is the nested Gaussian product law
  \(\nu_n\).
- The theorem is an equality between measures. A particular matrix such as
  the opening \(H\) is a point in the target space, not either side of this
  equality.
{{< /lean-bridge >}}

The theorem <code>matrixLaw_eq_map</code> exposes the definitional identity
with <code>Measure.map</code>. The instance
<code>instIsProbabilityMeasureMatrixLaw</code> proves the pushforward retains
total mass one.

Why define the law on the full ambient matrix type rather than a Hermitian
subtype? The existing project law API, measurable matrix entries, congruence
maps, and observables live on that ambient space. Assembly guarantees every
realized output is Hermitian pointwise, but RMT-06 does not yet package the
full-mass theorem saying the Hermitian set has measure one and its complement
has measure zero.

That missing full-mass declaration does not invalidate the construction. It
marks the difference between a sample map whose outputs satisfy a property and
a named theorem evaluating its pushforward law on the Hermitian set.

The follow-up RMT-07 module now supplies that named mass-one theorem. It also
proves symmetry of the intrinsic standard Gaussian on Hermitian Frobenius
space, while leaving the coordinate-to-intrinsic comparison for RMT-08; see
[Intrinsic Hermitian Gaussian Symmetry and Matrix-Law Support]({{< relref "/knowledge-base/deep-dives/intrinsic-hermitian-gaussian-symmetry-and-matrix-law-support" >}}).

## Camp seven: transfer matrix-entry laws

The diagonal and upper entry maps composed with assembly reduce to coordinate
evaluations. That fact transfers exact laws from \(\nu_n\) to \(\mu_n\).

### The full diagonal entry, not just its real part

A diagonal entry is complex-valued in the ambient matrix type even though
assembly inserts a real coordinate. The strongest justified law statement is

\[
H_{ii}\sim
\operatorname{CGauss}_{\mathrm{cart}}(0;d_n,0).
\]

The real coordinate has variance \(d_n\). The imaginary coordinate has
variance zero, so its law is Dirac at zero. This is exactly
<code>matrixLaw_diagonal_hasLaw</code>.

For positive \(n\), \(d_n=1/n\). The theorem therefore records both
Gaussian diagonal scaling and concentration of each diagonal entry on the
real axis at the scalar law level. It does not prove a density on the full
matrix space.

### A strict-upper entry

For \(i\lt j\),

\[
H_{ij}\sim
\operatorname{CGauss}_{\mathrm{cart}}(0;a_n,a_n),
\]

which is <code>matrixLaw_upper_hasLaw</code>. For positive \(n\), both
component variances are \(1/(2n)\).

The theorem requires a proof \(i\lt j\), exactly matching the branch where
assembly copies the primitive upper coordinate. There is no named lower-entry
law theorem in RMT-06. A later result may derive it by conjugation, but it must
not present the lower slot as a new independent Gaussian input.

### In Lean: transfer the exact strict-upper law

{{< lean-bridge
  human="If i is strictly less than j, then the matrix entry H i j under the finite GUE law is centered Cartesian complex Gaussian with the selected equal component variances."
  math="\(i\lt j\Longrightarrow H_{ij}\sim\operatorname{CGauss}_{\mathrm{cart}}(0;a_n,a_n).\)"
  lean="GUE.matrixLaw_upper_hasLaw n hij"
>}}

- <code>hij : i &lt; j</code> is evidence selecting the strict-upper branch.
- <code>matrixLaw_upper_hasLaw</code> is an exact
  <code>HasCartesianComplexGaussianLaw</code> statement, not only a mean or
  variance calculation.
- Both displayed variance arguments are
  <code>GUE.upperCartesianVariance n</code>. Equality of those component
  scales is visible in the result.
- The source measure in the conclusion is <code>GUE.matrixLaw n</code>, so the
  theorem concerns evaluation on the assembled matrix law rather than the
  earlier coordinate product law.
- No lower-triangular independence follows. The lower entry is the conjugate
  of this same upper coordinate.
{{< /lean-bridge >}}

### What the transfer does not prove

The two matrix-entry marginal theorems do not by themselves expose the full
matrix joint law. That joint law is already \(\mu_n\), the pushforward of the
coordinate product measure. Nor do the current declarations restate mutual
independence of matrix diagonal and strict-upper entry maps after transport.
Such theorems are mathematically reachable through assembly identities but
are not public RMT-06 claims.

## Camp eight: dimension zero is a Dirac law

At \(n=0\), both <code>Fin 0</code> and
<code>StrictUpperIndex 0</code> are empty. A function from either empty type
has one possible value. Consequently, \(\mathcal C_0\) is a singleton.

Each finite indexed product over an empty type is a Dirac measure on the
unique empty function. Their binary product is a Dirac measure on the unique
coordinate pair:

\[
\nu_0=\delta_{0_{\mathcal C_0}}.
\]

This is <code>coordinateMeasure_zero</code>.

The assembly map sends that unique coordinate to the unique empty matrix.
Mapping a Dirac measure through a measurable function gives a Dirac measure at
the image:

\[
\mu_0=\delta_{0_{\mathcal M_0}}.
\]

This is <code>matrixLaw_zero</code>.

The proof does not evaluate \(1/n\), appeal to a limiting argument, or leave a
partial constructor. The pattern-matched scale and the empty product agree on
one executable boundary policy.

### In Lean: the zero-size law is a Dirac mass

{{< lean-bridge
  human="At dimension zero, the finite GUE law puts all mass on the unique empty zero matrix."
  math="\(\mu_0=\delta_{0_{\mathcal M_0}}.\)"
  lean="GUE.matrixLaw_zero"
>}}

- <code>matrixLaw 0</code> still has a well-formed ambient matrix type,
  <code>Matrix (Fin 0) (Fin 0) ℂ</code>.
- <code>Fin 0</code> has no indices, so that matrix type has one element.
- <code>Measure.dirac 0</code> is the point mass at the unique empty matrix.
- The companion theorem <code>GUE.coordinateMeasure_zero</code> proves the
  same Dirac boundary before assembly.
- This theorem is not the limit of positive-dimensional laws as \(n\) tends to
  zero. Natural-number dimension is pattern matched exactly.
{{< /lean-bridge >}}

## The checked declaration map

The module
<code>NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsemble</code>,
in namespace <code>NonlinearDynamics.Random.GUE</code>, exports exactly 26
public declarations.

| Declaration | Checked content | Explicit boundary |
|---|---|---|
| <code>varianceScale</code> | Total Wigner variance scale on natural dimensions | Pattern matches zero; no division-by-zero claim |
| <code>diagonalVariance</code> | Names the real diagonal variance | Does not create a law |
| <code>upperCartesianVariance</code> | Names each upper real/imaginary component variance as half the scale | Does not name total complex variance |
| <code>varianceScale_zero</code> | \(s_0=0\) | Not a positive-size reciprocal formula |
| <code>varianceScale_succ</code> | \(s_{n+1}=1/(n+1)\) | No asymptotic statement |
| <code>diagonalVariance_zero</code> | Diagonal scale is zero at size zero | There is no diagonal index at size zero |
| <code>diagonalVariance_succ</code> | Positive-size diagonal variance is \(1/(n+1)\) | No density theorem |
| <code>upperCartesianVariance_zero</code> | Upper component scale is zero at size zero | There is no upper index at size zero |
| <code>upperCartesianVariance_succ</code> | Positive-size component variance is \(1/[2(n+1)]\) | No complex second-moment theorem |
| <code>coordinateMeasure</code> | Product of the real diagonal and Cartesian complex upper product measures | No matrix assembly yet |
| <code>instIsProbabilityMeasureCoordinateMeasure</code> | Coordinate measure has total mass one | No sample algorithm or empirical claim |
| <code>coordinateMeasure_hasLaw_diagonalBlock</code> | First projection has the exact finite real Gaussian product law | Not merely scalar marginals |
| <code>coordinateMeasure_hasLaw_upperBlock</code> | Second projection has the exact finite complex Gaussian product law | No lower-triangle family |
| <code>coordinateMeasure_indepFun_diagonal_upper</code> | Full diagonal and upper projections are independent | Does not assert unitary symmetry |
| <code>coordinateMeasure_diagonal_hasLaw</code> | Every selected diagonal coordinate has exact centered real Gaussian law | No matrix-entry theorem yet |
| <code>coordinateMeasure_upper_hasLaw</code> | Every selected upper coordinate has exact centered Cartesian complex law | Both component variances remain explicit |
| <code>coordinateMeasure_diagonal_iIndepFun</code> | Diagonal evaluations are mutually independent | Stronger scope than pairwise only |
| <code>coordinateMeasure_upper_iIndepFun</code> | Upper evaluations are mutually independent | Reflected lower entries are absent |
| <code>coordinateMeasure_diagonal_indepFun_upper</code> | Any diagonal evaluation is independent of any upper evaluation | No claim about reflected matrix entries |
| <code>matrixLaw</code> | Law on ambient complex matrices obtained through checked assembly | Does not define a density or spectrum |
| <code>matrixLaw_eq_map</code> | Exposes the exact measurable pushforward formula | No invariance under a second map |
| <code>instIsProbabilityMeasureMatrixLaw</code> | Matrix law has total mass one | No Hermitian-set mass-one theorem |
| <code>matrixLaw_diagonal_hasLaw</code> | Full complex diagonal entry has real variance \(d_n\) and imaginary variance zero | Not just a real-part marginal |
| <code>matrixLaw_upper_hasLaw</code> | Strict-upper entry has equal component variances \(a_n\) | Requires the strict inequality branch |
| <code>coordinateMeasure_zero</code> | Zero-dimensional coordinate law is Dirac at the unique zero coordinate | No reciprocal reasoning |
| <code>matrixLaw_zero</code> | Zero-dimensional matrix law is Dirac at the empty zero matrix | No positive-dimensional limit |

All 26 declarations compile under Lean 4.32.0 and the pinned Mathlib 4.32.0
dependency. The module contains no <code>sorry</code> or <code>admit</code>.

### Full project check of the exact finite-law interfaces

{{< repo-check >}}
The authoritative source is
[<code>formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsemble.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsemble.lean).
After installing the repository's pinned dependencies, put these lines in a
temporary project scratch file:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsemble

open Matrix MeasureTheory ProbabilityTheory
open scoped ENNReal NNReal ProbabilityTheory Matrix
open NonlinearDynamics.Random

#print GUE.varianceScale
#print GUE.diagonalVariance
#print GUE.upperCartesianVariance
#check GUE.varianceScale_zero
#check GUE.varianceScale_succ
#check GUE.diagonalVariance_zero
#check GUE.diagonalVariance_succ
#check GUE.upperCartesianVariance_zero
#check GUE.upperCartesianVariance_succ
#print GUE.coordinateMeasure
#check GUE.instIsProbabilityMeasureCoordinateMeasure
#check GUE.coordinateMeasure_hasLaw_diagonalBlock
#check GUE.coordinateMeasure_hasLaw_upperBlock
#check GUE.coordinateMeasure_indepFun_diagonal_upper
#check GUE.coordinateMeasure_diagonal_hasLaw
#check GUE.coordinateMeasure_upper_hasLaw
#check GUE.coordinateMeasure_diagonal_iIndepFun
#check GUE.coordinateMeasure_upper_iIndepFun
#check GUE.coordinateMeasure_diagonal_indepFun_upper
#print GUE.matrixLaw
#check GUE.matrixLaw_eq_map
#check GUE.instIsProbabilityMeasureMatrixLaw
#check GUE.matrixLaw_diagonal_hasLaw
#check GUE.matrixLaw_upper_hasLaw
#check GUE.coordinateMeasure_zero
#check GUE.matrixLaw_zero
~~~

The full project command rendered below checks the authoritative module with
Lean 4.32.0 and pinned Mathlib 4.32.0. It type-checks definitions and proofs;
it does not sample a matrix, estimate eigenvalues, or test an asymptotic
claim. It may require substantial disk space and memory.
{{< /repo-check >}}

## Checked construction versus classical context

The classical finite GUE admits several equivalent descriptions. One uses the
independent Gaussian free entries chosen here. Another uses a density on the
real vector space of Hermitian matrices proportional to

\[
\exp\!\left(-\frac n2\operatorname{Tr}(H^2)\right).
\]

Another emphasizes invariance under

\[
H\longmapsto UHU^*
\]

for every deterministic unitary \(U\). Diagonalization then leads to an
eigenvalue density with a squared Vandermonde factor.

These equivalences are mathematics, not definitional shortcuts. RMT-06 chooses
the coordinate presentation as its definition. The broader repository has
since proved some, but not all, of the later characterizations.

| Layer | RMT-06 status | Current broader-project status |
|---|---|---|
| Variance ledger | Checked | Still the governing normalization |
| Coordinate product probability law | Checked | Reused by later geometry and moment proofs |
| Coordinate marginals and independence | Checked | Whole normalized product transport is checked later |
| Measurable Hermitian assembly pushforward | Checked | Measure-one Hermitian locus is checked in RMT-07 |
| Matrix diagonal and upper marginals | Checked | Integrability is supplied by imported Gaussian interfaces and later observables |
| Hermitian-space density | Not checked | Still unformalized; no reference-volume or Jacobian theorem |
| Unitary invariance | Not checked here | Checked in RMT-08 for <code>GUE.matrixLaw n</code> |
| Finite spectral law | Not checked here | Ordered eigenvalues and empirical spectral laws are checked in RMT-10A through RMT-10C |
| First two trace expectations | Not checked here | Checked in RMT-09, with \(\mathbb E\operatorname{Tr}(H)=0\) and \(\mathbb E\operatorname{Tr}(H^2)=n\) |
| Semicircle behavior | Not checked | Still requires an asymptotic empirical-measure theorem |

The phrase "GUE matrix law" in RMT-06 refers to the explicit standard
coordinate construction. It does not claim that every classical
characterization has already been proved equivalent in Lean.

### Inspect the later checked boundary without importing it into RMT-06

{{< repo-check module="NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleMoments" >}}
The later moments module imports the geometry and invariance continuation, so
one full project scratch file can verify the exact theorem names that mark the
current boundary:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleMoments

open Matrix MeasureTheory ProbabilityTheory
open scoped ENNReal NNReal ProbabilityTheory Matrix
open NonlinearDynamics.Random

#check GUE.matrixLaw_hermitianSet
#check GUE.matrixLaw_ae_isHermitian
#check GUE.matrixLaw_isUnitaryConjugationInvariant
#check GUE.integrable_tracePower_one
#check GUE.integral_tracePower_one
#check GUE.integrable_tracePower_two
#check GUE.integral_tracePower_two
~~~

These are checked later-module theorems about the same finite matrix law. No
density, eigenvalue density, semicircle limit, universality, or quantum-chaos
observable follows merely from these <code>#check</code> lines.
{{< /repo-check >}}

## Physics window: why the unitary class matters

In finite-dimensional quantum mechanics, a Hamiltonian \(H=H^*\) has real
expectation values and generates unitary evolution
\(e^{-itH}\). Random-matrix models do not replace a microscopic Hamiltonian;
they model statistical spectral features after detailed system-specific
structure is suppressed.

Dyson organized three symmetry classes associated with real, complex, and
quaternionic structures. The unitary class is the complex Hermitian class
appropriate when the relevant time-reversal constraint is absent. In the
classical GUE, conjugating by a deterministic unitary changes the basis but not
the law. This makes the ensemble a natural basis-neutral reference model for
that class.

RMT-06 proves the complex Hermitian coordinate law but not its basis
invariance. RMT-08 later proves that exact invariance theorem for the same
<code>matrixLaw</code>. The project still does not formalize Hamiltonians,
time-reversal operators, matrix exponentials, energy levels, level spacing,
spectral form factors, or quantum chaos at this point in the dependency chain.
The physical motivation informs later theorem sequences; it does not supply
proofs by naming the ensemble.

The Wigner \(1/n\) variance scale keeps typical eigenvalues order one as
dimension grows. Classical results then place the limiting spectral mass on
\([-2,2]\) under the chosen convention. That statement is not a consequence
of the finite probability instance alone. It requires a measurable empirical
spectral measure and a large-\(n\) convergence proof. The former now exists in
later finite-dimensional modules; the latter remains unformalized.

## Common wrong turns

### Calling Hermiticity a distribution

Hermiticity constrains entries pointwise. It does not choose Gaussian laws,
variance, independence, or any measure. RMT-05 supplies assembly; RMT-06
supplies the source probability law.

### Giving each upper component variance \(1/n\)

That choice would give \(\mathbb E|H_{ij}|^2=2/n\). The selected convention
uses \(1/(2n)\) for each component so their sum is \(1/n\).

### Treating upper and lower entries as independent

They obey \(H_{ji}=\overline{H_{ij}}\). Only the strict upper triangle is a
primitive complex family.

### Listing Gaussian marginals without a joint law

Dependent variables can have the same Gaussian marginals as independent ones.
The coordinate product measure and independence theorems carry indispensable
joint information.

### Reading `HasLaw` as a generated sample

A law is a pushforward identity between measures. It does not run a random
number generator or record an observed realization.

### Calling the matrix law unitarily invariant by its name

The classical GUE has this symmetry. RMT-06 has not proved the measure equality
under unitary conjugation. RMT-08 builds it. The later geometry and transport
argument proves the theorem; the namespace alone implies no such result.

### Deriving a density without choosing reference volume

A density is relative to a measure. Hermitian-space coordinates, real-linear
geometry, and the factor-of-two quadratic form must be formalized before the
entrywise product law can be converted into the invariant density.

### Letting \(n=0\) fall through a reciprocal

The definition pattern matches zero, and the empty product laws are Dirac.
This is a total boundary policy, not a limiting slogan.

### Claiming an order-one spectrum from the probability instance

Total mass one says nothing about eigenvalue scale. The spectral statement
requires estimates or asymptotic theorems not present here.

## Exercises

1. **Ledger.** For \(n=4\), list the variance of every diagonal coordinate and
   every real Cartesian upper coordinate.
2. **Energy.** Compute \(\mathbb E|H_{12}|^2\) from the two component
   variances when \(n=4\).
3. **Geometry.** Expand \(\operatorname{Tr}(H^2)\) for a \(2\times2\)
   Hermitian matrix and locate the off-diagonal factor of two.
4. **Density context.** Match the coefficient of \(x^2\) in
   \(e^{-nx^2}\) with a centered real Gaussian variance.
5. **Scopes.** Give an example showing why scalar marginals do not imply
   independence.
6. **Transport.** Mathlib's <code>Measure.map</code> is total even for a
   nonmeasurable function. State the measurability hypothesis needed to use
   \((A_n)_*\nu_n\) as the intended pushforward and apply map evaluation or
   composition theorems.
7. **Diagonal law.** Explain why the exact complex law of \(H_{ii}\) has
   imaginary variance zero rather than omitting the imaginary coordinate.
8. **Reflection.** Explain why no independent lower-coordinate block belongs
   in \(\nu_n\).
9. **Boundary.** Prove on paper that the function space
   \(\operatorname{Fin}(0)\to\mathbb R\) has one element.
10. **Lean.** Find which declaration exposes the matrix law as a
    <code>Measure.map</code>.
11. **Later theorem.** Write the unitary-invariance measure equality and find
    the later project declaration that now proves it.
12. **Roadmap.** List the new definitions needed before a semicircle theorem
    can even be stated precisely.

## Summit register

RMT-06 fixes a Wigner-scale ledger with an explicit zero branch. It builds the
canonical product law on real diagonal and complex strict-upper coordinates,
proves that law is probabilistic, exposes full block laws, exact scalar laws,
mutual independence within both blocks, and independence across blocks. It
then pushes the law through the checked measurable Hermitian assembly map,
proves the resulting matrix law is probabilistic, transfers exact diagonal and
strict-upper entry laws, and identifies both zero-dimensional laws as Dirac.

The result is the first checked finite named matrix ensemble in the project. It
is also deliberately bounded. RMT-06 itself adds no density, matrix-level
Hermitian-set mass-one theorem, unitary-invariance theorem, eigenvalue law,
expectation, trace moment, empirical spectral law, semicircle limit, or
universality theorem.

The broader project has climbed several of those finite-dimensional steps.
RMT-07 proves that the Hermitian set has measure one, RMT-08 proves unitary
invariance, RMT-09 proves the first two trace expectations, and RMT-10A
through RMT-10C build finite spectral laws and expected first two empirical
moments. A Hermitian-space density, a joint eigenvalue density, a semicircle
limit, universality, and quantum-chaos observables remain outside the checked
claims of this chapter.

## Where to continue

Use the
{{< refterm "gaussian-unitary-ensemble" "Gaussian unitary ensemble" >}}
glossary entry for the compact definition and normalization ledger.
[Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}})
derives the deterministic assembly map.

[Finite Product Probability Spaces and Independent Gaussian Fields]({{< relref "/knowledge-base/deep-dives/finite-product-probability-spaces-and-independent-gaussian-fields" >}})
explains the finite product and independence APIs, while
[Complex Gaussian Coordinates and Geometry]({{< relref "/knowledge-base/deep-dives/complex-gaussian-coordinates-and-geometry" >}})
develops the exact two-variance complex law. Read
{{< refterm "normalization-convention" "normalization convention" >}},
{{< refterm "pushforward-measure" "pushforward measure" >}}, and
{{< refterm "unitary-invariance" "unitary invariance" >}} for the three
boundaries this construction makes most visible.

## References

**Alice Guionnet.**
[Rare Events in Random Matrix Theory](https://ems.press/content/book-chapter-files/33150),
in *Proceedings of the International Congress of Mathematicians 2022*, volume
2, European Mathematical Society Press, 2022,
[doi:10.4171/ICM2022/174](https://doi.org/10.4171/ICM2022/174),
pp. 1008-1052. Section 1.1.1
states the GUE diagonal variance \(1/n\), upper real and imaginary variances
\(1/(2n)\), and the Gaussian-ensemble density
\(\exp[-\beta n\operatorname{Tr}(H^2)/4]\). For \(\beta=2\), this is the
density context used in the factor-of-two derivation. Density remains
unformalized in the project. Unitary invariance is absent from RMT-06 but is
proved for the same matrix law in RMT-08.

**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems. I](https://doi.org/10.1063/1.1703773),
*Journal of Mathematical Physics* 3 (1962), 140-156. This primary paper
develops the symmetry-class framework and its quantum-spectral motivation.

**Terence Tao and Van Vu.**
[Random Matrices: Sharp Concentration of Eigenvalues](https://arxiv.org/abs/1201.4789),
arXiv:1201.4789, 2012. The normalization \(W_n=M_n/\sqrt n\) and the
order-one spectral window provide context for the scale selected here. No
spectral statement from that paper is claimed as checked by RMT-06.

**Mathlib contributors.**
[Gaussian distributions over the reals](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html),
[indexed product measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Constructions/Pi.html),
[independence](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Independence/Basic.html),
and
[measure maps](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
Mathlib 4 documentation. These official API references underlie the exact
Gaussian, finite product, independence, and pushforward proofs.

The exact upstream Lean source audited for this chapter is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
