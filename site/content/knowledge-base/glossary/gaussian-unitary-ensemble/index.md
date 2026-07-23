---
title: "Gaussian unitary ensemble"
slug: "gaussian-unitary-ensemble"
summary: "The repository's finite Wigner-scaled GUE law, from independent Gaussian Hermitian coordinates through exact trace and normalized spectral moments."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleSpectrum"
og_image: "gaussian-unitary-ensemble-card.png"
og_image_alt: "Four independent centered real Gaussian coordinates assemble the size-two Wigner-scaled GUE, with expected trace zero, trace-square two, and normalized second moment one."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working note. Human review of the
mathematics, Lean interpretation, sources, figures, and accessibility remains
pending. The page is public so readers can follow the work while that review
is still open.
{{< /panel >}}

The **Gaussian unitary ensemble**, or **GUE**, is a probability law on finite
complex {{< refterm "hermitian-matrix" "Hermitian matrices" >}}.

Each word names a different part of the story:

- **Gaussian:** the freely chosen real scalar coordinates have Gaussian laws;
- **unitary:** changing basis by a deterministic unitary matrix does not
  change the matrix law; and
- **ensemble:** the object is a probability measure over matrices, not one
  particular matrix.

Those three facts do not follow from one another. This repository constructs
the coordinate law, pushes it through Hermitian assembly, proves concentration
on the Hermitian locus, proves unitary-conjugation invariance, and then proves
the first two finite trace and empirical spectral moments in separate modules.

## The entire \(n=2\) construction

For dimension \(n=2\), the repository's Wigner variance scale is

\[
s_2=\frac12.
\]

Choose four centered real Gaussian variables:

\[
a,d\sim N\!\left(0,\frac12\right),
\qquad
x,y\sim N\!\left(0,\frac14\right),
\]

with all four primitive real coordinates independent. Here the second
parameter of \(N(m,v)\) is the **variance**, not the standard deviation.

The two diagonal variables use variance \(s_2=1/2\). The real and imaginary
parts of the one strict-upper entry use half that variance:

\[
\frac{s_2}{2}=\frac14.
\]

Set

\[
z=x+iy
\]

and assemble

\[
H=
\begin{bmatrix}
a & z\\
\overline z & d
\end{bmatrix}
{}=
\begin{bmatrix}
a & x+iy\\
x-iy & d
\end{bmatrix}.
\]

This matrix is Hermitian for every coordinate outcome. Randomness chooses
\(a,d,x,y\); conjugate reflection determines the lower-left entry.

The upper entry has total squared-magnitude expectation

\[
\mathbb E|z|^2
=\mathbb E[x^2+y^2]
=\frac14+\frac14
=\frac12.
\]

The factor \(1/4\) on each Cartesian component is therefore essential. Giving
both \(x\) and \(y\) variance \(1/2\) would double the intended off-diagonal
energy.

{{< reference-figure
  wide="true"
  src="gue-n2-moment-ledger.svg"
  alt="Four independent centered real Gaussian variables assemble a two by two Hermitian matrix. The diagonal variables each have variance one half, and the upper real and imaginary parts each have variance one quarter. The expected trace is zero, the expected trace square is two, and one half of that second trace moment gives normalized spectral second moment one."
  caption="**The \(n=2\) ledger:** \(a,d\sim N(0,1/2)\) and \(x,y\sim N(0,1/4)\) assemble \(H=\bigl[\begin{smallmatrix}a&x+iy\\x-iy&d\end{smallmatrix}\bigr]\). Centering gives \(\mathbb E\operatorname{Tr}(H)=0\). Expanding the square gives \(\mathbb E\operatorname{Tr}(H^2)=2\). The empirical spectral measure divides the trace-square by \(n=2\), so its expected second moment is \(1\). Patterns separate diagonal, upper-coordinate, and spectral roles without relying on color."
>}}

## Compute \(\mathbb E\,\operatorname{Tr}(H)\)

The trace reads only the diagonal:

\[
\operatorname{Tr}(H)=a+d.
\]

Both coordinates are centered, so linearity of
{{< refterm "expectation" "expectation" >}} gives

\[
\begin{aligned}
\mathbb E\,\operatorname{Tr}(H)
&=\mathbb E[a]+\mathbb E[d]\\
&=0+0\\
&=0.
\end{aligned}
\]

No eigenvalue calculation is needed for this first trace moment.

## Compute \(\mathbb E\,\operatorname{Tr}(H^2)\)

Multiplying the matrix by itself gives diagonal entries

\[
(H^2)_{00}=a^2+|z|^2,
\qquad
(H^2)_{11}=d^2+|z|^2.
\]

Therefore

\[
\begin{aligned}
\operatorname{Tr}(H^2)
&=a^2+d^2+2|z|^2\\
&=a^2+d^2+2(x^2+y^2).
\end{aligned}
\]

For a centered real random variable, its second moment equals its variance.
Substitute the four variance entries:

\[
\begin{aligned}
\mathbb E\,\operatorname{Tr}(H^2)
&=\frac12+\frac12
  +2\left(\frac14+\frac14\right)\\
&=2.
\end{aligned}
\]

The doubled off-diagonal term is geometric, not an extra random coordinate.
Both \(H_{01}H_{10}=|z|^2\) and \(H_{10}H_{01}=|z|^2\) enter the trace of the
square.

## Why the normalized spectral second moment is one

Let \(\lambda_1,\lambda_2\in\mathbb R\) be the eigenvalues of \(H\). Its
empirical spectral measure is

\[
\mu_H=\frac12\left(\delta_{\lambda_1}+\delta_{\lambda_2}\right).
\]

The second moment of this one sample measure is

\[
\begin{aligned}
\int_{\mathbb R} t^2\,d\mu_H(t)
&=\frac12(\lambda_1^2+\lambda_2^2)\\
&=\frac12\operatorname{Tr}(H^2).
\end{aligned}
\]

Taking the ensemble expectation gives

\[
\mathbb E\!\left[\int_{\mathbb R}t^2\,d\mu_H(t)\right]
=\frac12\,\mathbb E\,\operatorname{Tr}(H^2)
=\frac12\cdot2
=1.
\]

The normalization occurs at a precise place: the empirical measure divides
the spectral counting measure by the number of eigenvalues. The ordinary
matrix trace itself is not normalized.

The repository proves this finite identity in every positive dimension, not
only at \(n=2\).

## The same count for every positive dimension

For \(n\gt0\), there are \(n\) diagonal entries with variance \(1/n\), and
\(\binom n2\) strict-upper entries with expected squared magnitude \(1/n\).
Since each upper entry appears twice in \(\operatorname{Tr}(H^2)\),

\[
\begin{aligned}
\mathbb E\,\operatorname{Tr}(H^2)
&=n\cdot\frac1n
  +2\binom n2\cdot\frac1n\\
&=1+(n-1)\\
&=n.
\end{aligned}
\]

Consequently,

\[
\mathbb E\!\left[\frac1n\operatorname{Tr}(H^2)\right]=1
\qquad(n\gt0).
\]

This exact finite calculation explains one purpose of Wigner scaling: the
average squared eigenvalue stays of order one as dimension changes.

## Six layers that must not be collapsed

| Layer | Exact question | What this repository establishes |
|---|---|---|
| Coordinate shape | Which entries are freely supplied? | Real diagonal plus complex strict upper; the lower triangle is conjugate reflection |
| Coordinate law | What is the joint probability law? | Centered finite Gaussian product laws with all required independence scopes |
| Normalization | Which variances are used? | \(1/n\) on each diagonal and \(1/(2n)\) on each displayed upper real component for \(n\gt0\) |
| Hermitian-locus concentration | Where does the ambient matrix law place its mass? | The measurable Hermitian set has mass one |
| Unitary invariance | Does \(H\mapsto UHU^*\) preserve the law? | Yes, for every deterministic unitary \(U\) |
| Spectral consequences | What is proved about eigenvalues? | Finite ordered spectra, empirical spectral laws, and the first two expected empirical moments |

The Hermitian-set theorem is a measure-one statement. It should not be
silently strengthened to a theorem that the topological support is exactly
the entire Hermitian space.

Likewise, unitary invariance is an equality of full matrix probability laws.
It is stronger than saying that individual entries have symmetric marginal
distributions, and it is separate from Hermitian-locus concentration.

{{< reference-figure
  src="gue-coordinate-ledger.svg"
  alt="The Wigner ledger assigns variance one over n to real diagonal coordinates and variance one over two n to each real component of a complex strict-upper coordinate, forms a product measure, and pushes it through measurable Hermitian assembly."
  caption="**Construction before consequences:** the finite product coordinate measure records the marginal laws and independence. Measurable Hermitian assembly then produces the ambient matrix law. Support, invariance, trace moments, and spectral theorems are later propositions about that law, not hidden consequences of its name."
>}}

## The project normalization ledger

The acronym GUE is not enough to recover scale conventions. This project uses:

| Ledger field | Project value |
|---|---|
| Positive-dimensional scale | \(s_n=1/n\) |
| Zero-dimensional scale | \(s_0=0\), by a separate definition branch |
| Diagonal coordinate | centered real Gaussian, variance \(s_n\) |
| Strict-upper coordinate | \(X_{ij}+iY_{ij}\) |
| Upper real-part variance | \(s_n/2\) |
| Upper imaginary-part variance | \(s_n/2\) |
| Primitive dependence | mutual independence within each block and independence between blocks |
| Lower entry | \(H_{ji}=\overline{H_{ij}}\) |
| Matrix law | measurable pushforward of the coordinate product law |
| Trace | ordinary, unnormalized \(\operatorname{Tr}\) |
| Empirical spectral measure for \(n\gt0\) | \(n^{-1}\sum_{j=1}^n\delta_{\lambda_j}\) |

For a strict-upper entry,

\[
\operatorname{Var}(X_{ij})
=\operatorname{Var}(Y_{ij})
=\frac1{2n},
\]

so

\[
\mathbb E|H_{ij}|^2=\frac1n.
\]

The component variance \(1/(2n)\), the complex squared-magnitude expectation
\(1/n\), and the normalized spectral second moment \(1\) are three different
quantities.

## In Lean: name the coordinate law

{{< lean-bridge
  human="Use the repository's exact size-two product law for all free Hermitian coordinates."
  math="\(\nu_2=\bigotimes_{i=0}^{1}N(0,1/2)\ \otimes\ N_{\mathbb C}^{\mathrm{cart}}(0;1/4,1/4).\)"
  lean="NonlinearDynamics.Random.GUE.coordinateMeasure 2"
>}}

- <code>GUE</code> is the project namespace for this ensemble.
- <code>coordinateMeasure</code> constructs the product probability measure
  before matrix assembly.
- <code>2</code> fixes the finite index types for the two diagonal positions
  and the single strict-upper position.
- The first product block contains real Gaussian coordinates.
- The second product block contains Cartesian complex Gaussian coordinates.
- Independence is supplied by the product measures; it is not inferred from
  the marginal law names.
{{< /lean-bridge >}}

## In Lean: ask for the exact second trace moment

{{< lean-bridge
  human="Under the size-two GUE matrix law, the expected ordinary trace of H squared is two."
  math="\(\displaystyle\int \operatorname{Tr}(H^2)\,d\mu_2(H)=2.\)"
  lean="NonlinearDynamics.Random.GUE.integral_tracePower_two 2"
>}}

- <code>integral_tracePower_two</code> is a theorem, not a numerical
  simulator.
- Its argument <code>2</code> is the matrix dimension.
- The theorem uses <code>GUE.matrixLaw 2</code> as the measure.
- <code>tracePower ... 2</code> means the ordinary complex trace of the
  matrix square.
- The result is <code>(2 : ℂ)</code>; Lean inserts the coercion from the
  natural dimension into the complex codomain.
{{< /lean-bridge >}}

The first trace theorem is the parallel declaration
<code>GUE.integral_tracePower_one 2</code>, whose right side is zero.

## In Lean: ask for the normalized spectral moment

{{< lean-bridge
  human="Dimension two is positive, so the expected second moment of its empirical spectral measure is exactly one."
  math="\(\displaystyle\int\!\left(\int t^2\,d\mu_H(t)\right)d\mathbb P(H)=1.\)"
  lean="NonlinearDynamics.Random.GUE.integral_empiricalSpectralMoment_two_succ 1"
>}}

- The theorem is indexed by <code>n</code> but states its result in dimension
  <code>n + 1</code>. Typing <code>1</code> therefore selects dimension two.
- <code>empiricalSpectralMoment 2 H</code> is the second moment of one
  matrix's empirical spectral measure.
- <code>intrinsicLaw (1 + 1)</code> is the GUE law on the intrinsic Hermitian
  carrier used for spectral analysis.
- The conclusion <code>= 1</code> is valid for every positive dimension.
- A separate theorem keeps the dimension-zero value visible.
{{< /lean-bridge >}}

## Exact project excerpts

**Full project check.** This uses the repository's pinned Lean and Mathlib
dependencies and may require substantial disk space and memory.
The scale functions in
[<code>GaussianUnitaryEnsemble.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsemble.lean)
are:

~~~lean
noncomputable def varianceScale : ℕ → ℝ≥0
  | 0 => 0
  | n + 1 => (((n + 1 : ℕ) : ℝ≥0))⁻¹

noncomputable def diagonalVariance (n : ℕ) : ℝ≥0 := varianceScale n

noncomputable def upperCartesianVariance (n : ℕ) : ℝ≥0 := varianceScale n / 2
~~~

The coordinate and matrix measures are then defined exactly as follows:

~~~lean
noncomputable def coordinateMeasure (n : ℕ) : Measure (HermitianCoordinateSpace n) :=
  (gaussianProductMeasure (fun _ : Fin n => 0) (fun _ => diagonalVariance n)).prod
    (cartesianComplexGaussianProductMeasure
      (fun _ : StrictUpperIndex n => 0)
      (fun _ => upperCartesianVariance n)
      (fun _ => upperCartesianVariance n))

noncomputable def matrixLaw (n : ℕ) :
    Measure (Matrix (Fin n) (Fin n) ℂ) :=
  RandomMatrix.law (RandomMatrix.hermitianCoordinateMap n)
    (RandomMatrix.measurable_hermitianCoordinateMap n) (coordinateMeasure n)
~~~

The first definition builds the exact joint law of the free coordinates. The
second applies the measurable deterministic assembly map. Neither definition
mentions eigenvalues or unitary invariance.

The positive-dimensional spectral normalization theorem in
[<code>GaussianUnitaryEnsembleSpectrum.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleSpectrum.lean)
is short:

~~~lean
@[simp] theorem integral_empiricalSpectralMoment_two_succ (n : ℕ) :
    ∫ H, empiricalSpectralMoment 2 H ∂intrinsicLaw (n + 1) = 1 := by
  rw [integral_empiricalSpectralMoment_two]
  norm_cast
  exact inv_mul_cancel₀ (by positivity)
~~~

It rewrites with the all-dimensions formula \(n^{-1}n\), then uses positivity
of \(n+1\) to cancel the reciprocal. This proof is the formal endpoint of the
worked \(n=2\) calculation.

## Standalone tutorial: moment ledger

**Standalone tutorial.** This worksheet imports only
<code>Std</code> and evaluates the rational arithmetic in the size-two
example. It is not a random-variable construction and proves no Gaussian law,
independence, matrix support, invariance, or spectral theorem.

Save it as <code>GUE2MomentLedgerScratch.lean</code>:

~~~lean
import Std

structure GUE2Ledger where
  meanA : Rat
  meanD : Rat
  meanX : Rat
  meanY : Rat
  varA : Rat
  varD : Rat
  varX : Rat
  varY : Rat
deriving Repr

def scalarSecondMoment (mean variance : Rat) : Rat :=
  variance + mean ^ 2

def expectedTrace (L : GUE2Ledger) : Rat :=
  L.meanA + L.meanD

def expectedTraceSq (L : GUE2Ledger) : Rat :=
  scalarSecondMoment L.meanA L.varA
    + scalarSecondMoment L.meanD L.varD
    + 2 * (scalarSecondMoment L.meanX L.varX
      + scalarSecondMoment L.meanY L.varY)

def expectedNormalizedSecond (L : GUE2Ledger) : Rat :=
  expectedTraceSq L / 2

def wignerGUE2 : GUE2Ledger :=
  { meanA := 0, meanD := 0, meanX := 0, meanY := 0
    varA := (1 : Rat) / 2
    varD := (1 : Rat) / 2
    varX := (1 : Rat) / 4
    varY := (1 : Rat) / 4 }

#eval expectedTrace wignerGUE2
#eval expectedTraceSq wignerGUE2
#eval expectedNormalizedSecond wignerGUE2
~~~

Run it with:

~~~sh
elan run leanprover/lean4:v4.32.0 lean GUE2MomentLedgerScratch.lean
~~~

The exact rational outputs should be \(0\), \(2\), and \(1\). The worksheet
checks only the displayed moment ledger. The project declarations below carry
the measure-theoretic and spectral content.

## Try the exact declarations in the project

{{< repo-check >}}
**Full project check.** This uses the repository's pinned Lean and Mathlib
dependencies and may require substantial disk space and memory.
Create a temporary project worksheet containing:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleSpectrum

#check NonlinearDynamics.Random.GUE.varianceScale
#check NonlinearDynamics.Random.GUE.varianceScale_zero
#check NonlinearDynamics.Random.GUE.varianceScale_succ
#check NonlinearDynamics.Random.GUE.diagonalVariance
#check NonlinearDynamics.Random.GUE.upperCartesianVariance
#check NonlinearDynamics.Random.GUE.coordinateMeasure
#check NonlinearDynamics.Random.GUE.coordinateMeasure_diagonal_hasLaw
#check NonlinearDynamics.Random.GUE.coordinateMeasure_upper_hasLaw
#check NonlinearDynamics.Random.GUE.coordinateMeasure_diagonal_iIndepFun
#check NonlinearDynamics.Random.GUE.coordinateMeasure_upper_iIndepFun
#check NonlinearDynamics.Random.GUE.matrixLaw
#check NonlinearDynamics.Random.GUE.matrixLaw_diagonal_hasLaw
#check NonlinearDynamics.Random.GUE.matrixLaw_upper_hasLaw
#check NonlinearDynamics.Random.GUE.coordinateMeasure_zero
#check NonlinearDynamics.Random.GUE.matrixLaw_zero
#check NonlinearDynamics.Random.GUE.matrixLaw_hermitianSet
#check NonlinearDynamics.Random.GUE.matrixLaw_isUnitaryConjugationInvariant
#check NonlinearDynamics.Random.GUE.integral_tracePower_one
#check NonlinearDynamics.Random.GUE.integral_tracePower_two
#check NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMoment_two
#check NonlinearDynamics.Random.GUE.integral_empiricalSpectralMoment_two
#check NonlinearDynamics.Random.GUE.integral_empiricalSpectralMoment_two_succ
~~~

Each <code>#check</code> asks the pinned elaborator for an exact declaration
type. The final import reaches the coordinate, geometry, invariance, moment,
and finite-spectrum layers. The full-project command below checks that complete
leaf module.
{{< /repo-check >}}

## Dimension zero and positive dimension are different

At \(n=0\), the project does not evaluate an informal \(1/0\). Instead:

- <code>varianceScale 0 = 0</code> by its own definition branch;
- the coordinate law is Dirac at the unique empty coordinate point;
- the ambient matrix law is Dirac at the unique empty matrix;
- the intrinsic Hermitian law is also Dirac at its zero element;
- the zero-aware empirical spectral measure is the zero measure; and
- every empirical spectral moment is zero.

The raw law of empirical spectral measures is still a probability law: it is
Dirac at the zero measure. But the zero empirical measure itself has total
mass zero, so it is not a probability measure on \(\mathbb R\).

For \(n\gt0\), the empirical spectral measure has mass one and its expected
second moment is one. Lean exposes that boundary honestly:

\[
\mathbb E[m_2]=
\begin{cases}
0,&n=0,\\
1,&n\gt0.
\end{cases}
\]

## Physics meaning without overclaiming

In quantum mechanics, a finite Hamiltonian is Hermitian so its measured
energies are real. Replacing a basis by a unitary matrix sends

\[
H\longmapsto UHU^*.
\]

A unitary-invariant ensemble assigns the same law before and after that basis
change. This is why the word *unitary* describes a symmetry class rather than
the claim that the random matrix \(H\) is itself unitary.

Dyson's unitary class models systems where the relevant antiunitary
time-reversal symmetry is absent. GUE is an idealized reference model for
spectral statistics, not a claim that every physical Hamiltonian has
independent Gaussian entries in every basis.

The finite identity
\(\mathbb E[n^{-1}\operatorname{Tr}(H^2)]=1\) says that the average squared
eigenvalue is normalized. It does **not** prove a semicircle law,
concentration, level repulsion, universality, or any large-\(n\) limit.

## Distinctions and failure modes

| Tempting shortcut | What goes wrong | Correct repair |
|---|---|---|
| "Hermitian Gaussian matrix" uniquely fixes the law | Variance and dependence conventions remain unspecified | Publish the complete normalization and independence ledger |
| Give each upper real component variance \(1/n\) | Then \(\mathbb E|H_{ij}|^2=2/n\) | Use \(1/(2n)\) for both Cartesian components |
| Treat \(H_{10}\) as independent of \(H_{01}\) | Hermitian reflection forces \(H_{10}=\overline{H_{01}}\) | Randomize only the strict upper triangle |
| Call mass one on the Hermitian set "unitary invariance" | Support and symmetry are different measure statements | Prove both the mass-one theorem and the pushforward equality |
| Normalize \(\operatorname{Tr}(H^2)\) inside its definition | The project trace observable is ordinary trace | Divide by \(n\) when forming the empirical spectral moment |
| Extend the positive formula through \(1/0\) informally | Dimension zero has no eigenvalues and no empirical probability measure | Use the explicit zero branch |
| Read the second moment as a semicircle theorem | One moment does not determine a limiting distribution | Prove higher and asymptotic claims separately |
| Read unitary invariance as "\(H\) is unitary" | The sampled matrices are Hermitian, generally not unitary | Interpret invariance as equality in law under \(H\mapsto UHU^*\) |

## Where to continue

[Finite GUE from Independent Gaussian Coordinates]({{< relref "/knowledge-base/deep-dives/finite-gue-from-independent-gaussian-coordinates" >}})
builds the product law and explains every independence scope.
[From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance]({{< relref "/knowledge-base/deep-dives/normalized-hermitian-coordinates-to-gue-invariance" >}})
proves the bridge from entry coordinates to isotropic Hermitian Gaussian
geometry and then to unitary invariance.

[First Exact Finite Gaussian Unitary Ensemble Trace Moments]({{< relref "/knowledge-base/deep-dives/first-exact-finite-gue-trace-moments" >}})
develops the integrability and first two trace calculations.
[Finite Gaussian Unitary Ensemble Empirical Spectral Laws and Normalized Moments]({{< relref "/knowledge-base/deep-dives/finite-gue-empirical-spectral-laws-and-normalized-moments" >}})
continues from traces to zero-aware empirical spectral measures and their
normalized expected moments.

Read {{< refterm "hermitian-coordinate-space" "Hermitian coordinate space" >}}
for the deterministic assembly,
{{< refterm "unitary-invariance" "unitary invariance" >}} for the law symmetry,
and {{< refterm "empirical-spectral-law" "empirical spectral law" >}} for the
measure-valued spectral layer.

## References

**Alice Guionnet.**
[Rare Events in Random Matrix Theory](https://doi.org/10.4171/ICM2022/174),
in *Proceedings of the International Congress of Mathematicians 2022*, volume
2, European Mathematical Society Press, 2022, pp. 1008-1052. Section 1.1.1
states the GUE entry variances \(1/n\) and \(1/(2n)\), the conventional density,
and unitary invariance.

**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems. I](https://doi.org/10.1063/1.1703773),
*Journal of Mathematical Physics* 3 (1962), 140-156. This primary source
develops the orthogonal, unitary, and symplectic symmetry classes and their
physical motivation.

**Terence Tao.**
[Topics in Random Matrix Theory](https://doi.org/10.1090/gsm/132),
Graduate Studies in Mathematics 132, American Mathematical Society, 2012.
This monograph develops finite Wigner-scaled ensembles and their spectral
context. Its asymptotic results are context, not formalized claims here.

**Mathlib contributors.**
[Gaussian distributions over the reals](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html)
and
[Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html),
Mathlib 4 documentation. These official APIs underlie the coordinate laws and
Hermitian matrix statements.

**Nonlinear Dynamics in Lean contributors.**
[GaussianUnitaryEnsemble.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsemble.lean),
[GaussianUnitaryEnsembleInvariance.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleInvariance.lean),
[GaussianUnitaryEnsembleMoments.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleMoments.lean),
and
[GaussianUnitaryEnsembleSpectrum.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleSpectrum.lean),
the checked project sources for construction, symmetry, trace moments, and
normalized spectral moments.

The upstream Mathlib revision audited for this entry is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
pinned by <code>formalization/lake-manifest.json</code>.
