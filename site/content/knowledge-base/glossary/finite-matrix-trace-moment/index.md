---
title: "Finite matrix trace moment"
slug: "finite-matrix-trace-moment"
summary: "A finite matrix trace moment is the expectation of a trace-power observable under a specified matrix law, after measurability, integrability, and normalization have each been made explicit."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleMoments"
og_image: "finite-matrix-trace-moment-card.png"
og_image_alt: "A two-point matrix law maps trace-square values zero and ten to raw moment five, while normalized trace gives five halves."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page is publicly available as an open working note while that
review remains pending.
{{< /panel >}}

## Start with a two-matrix probability law

Before introducing Gaussian coordinates, put equal probability on two
deterministic Hermitian matrices:

\[
H_0=
\begin{pmatrix}
0&0\\
0&0
\end{pmatrix},
\qquad
H_1=
\begin{pmatrix}
1&0\\
0&3
\end{pmatrix},
\qquad
\mathbb P(H=H_0)=\mathbb P(H=H_1)=\frac12.
\]

For the second trace power,

\[
\operatorname{Tr}(H_0^2)=0,
\qquad
\operatorname{Tr}(H_1^2)=1^2+3^2=10.
\]

The finite trace moment is therefore

\[
\mathbb E[\operatorname{Tr}(H^2)]
=\frac12\cdot0+\frac12\cdot10
=5.
\]

Everything is visible in this finite model. The law supplies the two weights,
the observable turns each matrix into one number, integrability is automatic
because only two finite values occur, and expectation performs the weighted
average. If we instead use normalized trace for these two-by-two matrices, the
answer is

\[
\mathbb E\!\left[\frac12\operatorname{Tr}(H^2)\right]
=\frac52.
\]

That factor of two is a convention change, not an algebra mistake.

{{< reference-figure
  wide="true"
  src="two-point-trace-moment.svg"
  alt="A probability law assigns mass one half to the zero two-by-two matrix and mass one half to the diagonal matrix with entries one and three. Squaring and taking traces gives zero and ten. The weighted raw trace moment is five, while dividing each trace by dimension two gives normalized moment five halves."
  caption="**Finding:** a matrix moment is an average of an observable under a law. The two matrices, their probabilities, the trace-square values, and the normalization divisor are four separate pieces of data. Changing only the final divisor changes \(5\) to \(5/2\)."
>}}

A **finite matrix trace moment** is the expected value of the trace of a fixed
power of a finite random matrix. Three words in that sentence carry separate
obligations: the matrix has a specified probability law, the trace power is a
measurable complex-valued observable, and the observable is integrable.

Let \(\mu\) be a probability measure on complex \(n\)-by-\(n\) matrices, and
let \(k\) be a nonnegative integer. When the function
\(H\mapsto\operatorname{Tr}(H^k)\) is integrable under \(\mu\), its trace
moment is

\[
m_k(\mu)
=\int \operatorname{Tr}(H^k)\,\mathrm d\mu(H).
\]

The project uses the ordinary, unnormalized matrix trace. A normalized-trace
moment would instead divide by the matrix dimension and is a different
quantity. Neither convention should be inferred from the word *moment* alone.
The complex Bochner integral in the definition is the norm-controlled integral
for complex-valued functions; its integrability gate is explained below.

{{< reference-figure
  src="observable-to-expectation.svg"
  alt="A matrix probability law feeds a measurable trace-power observable. A separate integrability theorem licenses its complex Bochner integral, which may then be read as an expected trace moment. Exact finite identities lie on this checked path, while eigenvalue laws and large-size limits remain later questions."
  caption="**Finding:** a trace power does not become a finite moment merely by being measurable. The probability law and normalization must be fixed, and integrability must be proved before the complex Bochner integral carries the intended expectation. An exact finite identity at the end of this chain does not by itself establish a spectral law or an asymptotic limit."
>}}

## Observable, integrability, and moment are different layers

The {{< refterm "trace-power" "trace-power observable" >}}

\[
T_k(H)=\operatorname{Tr}(H^k)
\]

is defined pointwise. Measurability says that inverse images of measurable
sets are measurable, so \(T_k\) is eligible to participate in measure theory.
It does not bound the size of \(T_k\).

For a complex-valued function, Bochner integrability requires strong
measurability up to a null set and finite integral of the complex norm
([Mathlib contributors](#ref-gloss-mathlib-bochner)):

\[
\int \lVert T_k(H)\rVert\,\mathrm d\mu(H)\lt\infty.
\]

Only after this analytic condition is available does the displayed complex
integral behave as the expected trace power. This separation matters especially
in Lean. Mathlib's Bochner integral is a total function: outside the integrable
case its definition returns zero. Therefore an isolated equation involving an
integral could conceal a failed integrability obligation. The project pairs
each exact identity with an explicit <code>Integrable</code> theorem.

The codomain is ℂ because the ambient matrix space is complex. If the law is
concentrated on Hermitian matrices, then every trace power is real-valued
almost everywhere under that law, but the integral is still stated in the
ambient complex codomain. Reality and integrability remain distinct facts.

## Why a probability measure turns the integral into expectation

An expectation is an integral with respect to a probability measure. The
project's finite Gaussian unitary ensemble (GUE) matrix law already has an
<code>IsProbabilityMeasure</code> instance, so no additional normalization by
the total mass is needed:

\[
\mathbb E_{H\sim\mu}[T_k(H)]
=\int T_k(H)\,\mathrm d\mu(H).
\]

For a general finite measure, the same integral need not equal an average
unless one divides by the total mass. Calling every finite-measure integral an
expectation would silently change the convention.

## Pushforward laws let the integral move to useful coordinates

Suppose a measurable map \(F:X\to Y\) transports a source measure \(\nu\) to
\(\mu\), so \(\mu\) is the
{{< refterm "pushforward-measure" "pushforward" >}}
\(F_*\nu\). Under the corresponding measurability and integrability
hypotheses,

\[
\int_Y g(y)\,\mathrm d(F_*\nu)(y)
=\int_X g(F(x))\,\mathrm d\nu(x).
\]

This is not only a computational convenience. It preserves the exact law while
moving the observable to a space where its algebra is transparent. For finite
GUE, the ambient matrix law is represented as the pushforward of a normalized
real Hermitian coordinate law. Composing the observable with that assembly map
moves the integral to the coordinate space. The first two trace powers then
reduce to finite sums of ordinary real Gaussian coordinates or their squares
([Mathlib contributors](#ref-gloss-mathlib-gaussian)).

Integrability must move through the pushforward too. One proves the composed
source observable integrable and transfers that fact to the target law, or
uses the appropriate equivalence supplied by the measurable map. The integral
identity does not erase that obligation.

## The first power reads only the diagonal

For every finite square matrix,

\[
\operatorname{Tr}(H)=\sum_{i=0}^{n-1}H_{ii}.
\]

Under the project's centered finite GUE law, each complex-valued diagonal
coordinate has a centered Cartesian complex Gaussian law with real-coordinate
variance \(s_n\) and imaginary-coordinate variance zero, where \(s_0=0\) and
\(s_n=1/n\) for positive dimension. It is therefore real almost surely. Each
coordinate is integrable and has complex mean zero
([Mathlib contributors](#ref-gloss-mathlib-gaussian)). Finite linearity of the
Bochner integral therefore gives

\[
\mathbb E[\operatorname{Tr}(H)]=0.
\]

Off-diagonal entries do not enter this calculation. Neither independence nor
unitary invariance is needed for the first identity once the centered diagonal
marginals are known.

## The second power includes every Hermitian entry

For a Hermitian matrix, conjugate symmetry turns the trace square into the
Frobenius norm square:

\[
\begin{aligned}
\operatorname{Tr}(H^2)
&=\sum_{i,j}H_{ij}H_{ji}\\
&=\sum_{i,j}H_{ij}\overline{H_{ij}}\\
&=\sum_{i,j}|H_{ij}|^2
=\lVert H\rVert_F^2.
\end{aligned}
\]

Now write \(H\) in
{{< refterm "normalized-hermitian-coordinates" "normalized Hermitian coordinates" >}}.
There is one real orthonormal coordinate for every ambient matrix position,
so the coordinate index has cardinality \(n^2\). If those real coordinates
are \(z_a\), then

\[
\operatorname{Tr}(H^2)=\sum_a z_a^2.
\]

Every \(z_a\) is centered Gaussian with variance \(s_n\). Hence finite
linearity and the scalar second-moment formula yield

\[
\mathbb E[\operatorname{Tr}(H^2)]
=n^2s_n
=n
\]

for positive \(n\). At \(n=0\), the coordinate index is empty, the matrix is
the unique empty matrix, and both sides are zero. The formal theorem handles
both branches.

Independence is not used in the final sum. Expectation is linear even for
dependent summands. The product-law construction is still important because
it established the exact normalized coordinate law and its scalar marginals,
but no cross term appears in the norm-square expression.

## Normalization ledger for the checked finite GUE moments

| Item | Project convention | Consequence here |
|---|---|---|
| Dimension | \(n\in\mathbb N\), including zero | Theorems require no positivity hypothesis |
| Diagonal variance | \(1/n\) for positive \(n\) | Each diagonal contributes \(1/n\) to the second moment |
| Off-diagonal displayed variances | Real and imaginary parts each have variance \(1/(2n)\) | Their two reflected matrix entries have the correct total Frobenius weight |
| Normalized real coordinates | Diagonal, scaled upper-real, and scaled upper-imaginary coordinates each have variance \(1/n\) | One homogeneous real Gaussian product |
| Coordinate count | \(n^2\) | The expected squared Frobenius norm is \(n^2/n=n\) |
| Trace | Ordinary, unnormalized trace | The second expected trace power is \(n\), not \(1\) |
| Zero dimension | Variance scale zero and empty coordinate family | Both checked moments are zero |
| Density and eigenvalues | Not used | No Jacobian, spectral theorem, or eigenvalue enumeration enters the proof |

The often-quoted positive-dimensional identity
\(\mathbb E[n^{-1}\operatorname{Tr}(H^2)]=1\) follows on paper by dividing the
checked second identity by \(n\). That normalized statement is not the theorem
formalized here, and it has no literal \(n=0\) form without an additional
convention.

## In Lean

{{< lean-bridge
  human="Under the finite GUE matrix law in dimension n, the expected ordinary trace of H squared is n."
  math="\(\displaystyle \int \operatorname{Tr}(H^2)\,d\mu_n(H)=n.\)"
  lean="GUE.integral_tracePower_two n"
>}}

- <code>GUE</code> is the project namespace for the chosen finite Gaussian
  unitary ensemble convention.
- <code>integral_tracePower_two</code> names the theorem; the word
  <code>integral</code> keeps the operation explicit, while
  <code>tracePower_two</code> fixes both observable and exponent.
- <code>n : ℕ</code> is the matrix dimension. The theorem deliberately includes
  <code>n = 0</code>.
- The full elaborated conclusion below contains
  <code>∂GUE.matrixLaw n</code>, so the measure is not inferred from prose.
- The right side is coerced to <code>ℂ</code> because the trace-power observable
  and Bochner integral are complex-valued.
- This theorem uses the ordinary trace. It does not hide the divisor
  \(1/n\).
{{< /lean-bridge >}}

The RMT-09 module states four theorems for every natural dimension:

~~~lean
theorem GUE.integrable_tracePower_one (n : ℕ) :
    MeasureTheory.Integrable
      (RandomMatrix.tracePower
        (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ) 1)
      (GUE.matrixLaw n)

theorem GUE.integral_tracePower_one (n : ℕ) :
    ∫ H : Matrix (Fin n) (Fin n) ℂ,
        RandomMatrix.tracePower id 1 H ∂GUE.matrixLaw n = 0

theorem GUE.integrable_tracePower_two (n : ℕ) :
    MeasureTheory.Integrable
      (RandomMatrix.tracePower
        (id : Matrix (Fin n) (Fin n) ℂ → Matrix (Fin n) (Fin n) ℂ) 2)
      (GUE.matrixLaw n)

theorem GUE.integral_tracePower_two (n : ℕ) :
    ∫ H : Matrix (Fin n) (Fin n) ℂ,
        RandomMatrix.tracePower id 2 H ∂GUE.matrixLaw n = (n : ℂ)
~~~

Here <code>id</code> is the identity random matrix on the ambient matrix sample
space. It makes <code>tracePower id k</code> the observable
\(H\mapsto\operatorname{Tr}(H^k)\). The first and third declarations are not auxiliary
noise: they are the analytic licenses for reading the following integral
identities as finite expectations.

### Type the two-point calculation locally

The following worksheet imports only <code>Std</code> and checks the finite law
from the opening example with exact rational arithmetic. Save it as
<code>TwoPointTraceMoment.lean</code>:

~~~lean
import Std

structure Diagonal2 where
  d0 : Int
  d1 : Int
deriving Repr

def traceSquare (H : Diagonal2) : Int :=
  H.d0 * H.d0 + H.d1 * H.d1

def H0 : Diagonal2 := { d0 := 0, d1 := 0 }
def H1 : Diagonal2 := { d0 := 1, d1 := 3 }

def rawSecondMoment : Rat :=
  (1 : Rat) / 2 * traceSquare H0 +
  (1 : Rat) / 2 * traceSquare H1

def normalizedSecondMoment : Rat :=
  rawSecondMoment / 2

#eval traceSquare H0
#eval traceSquare H1
#eval rawSecondMoment
#eval normalizedSecondMoment

example : rawSecondMoment = 5 := by native_decide
example : normalizedSecondMoment = (5 : Rat) / 2 := by native_decide
~~~

Run it on a Mac or Linux machine with the pinned toolchain already installed:

~~~sh
elan run leanprover/lean4:v4.32.0 lean TwoPointTraceMoment.lean
~~~

This exact worksheet was executed successfully with Lean 4.32.0 and printed:

~~~text
0
10
5
(5 : Rat)/2
~~~

Both exact equality examples elaborated without error. This worksheet
formalizes a finite arithmetic model, not the continuous GUE law.

{{< repo-check >}}
The authoritative source is
[<code>formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleMoments.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleMoments.lean).
In a clone with the repository's pinned Lean and Mathlib dependencies
installed, a human can make a scratch file containing:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleMoments

#check NonlinearDynamics.Random.GUE.integrable_tracePower_one
#check NonlinearDynamics.Random.GUE.integral_tracePower_one
#check NonlinearDynamics.Random.GUE.integrable_tracePower_two
#check NonlinearDynamics.Random.GUE.integral_tracePower_two
~~~

The first and third checks expose the integrability licenses. The second and
fourth expose the corresponding exact integral identities. The full-project command
below checks the full pinned module and its Mathlib dependencies.
{{< /repo-check >}}

## What these moments do not establish

The checked identities do not by themselves define measurable eigenvalues,
construct an empirical spectral measure, prove a joint eigenvalue density, or
establish the semicircle law. They do not give higher trace moments, variances
of trace powers, concentration, local spacing statistics, or universality.

The identity for the second power is consistent with an order-one spectral
scale under Wigner normalization
([Anderson, Guionnet, and Zeitouni](#ref-gloss-agz);
[Tao](#ref-gloss-tao)). That is explanatory context, not a checked
large-dimension theorem. A finite expectation at each \(n\) does not imply a
limit as \(n\to\infty\). Wigner's early large-matrix work supplies historical
context for the trace-moment program, not a premise of this exact proof
([Wigner](#ref-gloss-wigner)).

## Exercises

1. For a deterministic two-by-two Hermitian matrix, expand
   \(\operatorname{Tr}(H^2)\) entry by entry and verify that it equals the
   Frobenius norm square.
2. Replace the ordinary trace by \(n^{-1}\operatorname{Tr}\) for positive
   \(n\). Derive the corresponding first two expected values, and identify
   exactly where the positivity assumption is used.
3. Explain why the second-moment sum needs scalar second moments but not
   independence between distinct coordinates.
4. Construct a measurable but nonintegrable real random variable. Use it to
   explain why measurability alone cannot license the word *expectation*.
5. Starting from a pushforward law \(F_*\nu\), list the separate hypotheses
   needed to transfer both integrability and an integral identity.

## Where to continue

[First Exact Finite Gaussian Unitary Ensemble Trace Moments]({{< relref "/knowledge-base/deep-dives/first-exact-finite-gue-trace-moments" >}})
derives both identities with every algebraic step explicit and maps them to the
checked Lean proofs.
The {{< refterm "matrix-trace" "matrix trace" >}} entry fixes the algebraic
operation, while
{{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius geometry" >}}
explains the norm identity behind the second moment.

For the law being integrated, read the
{{< refterm "gaussian-unitary-ensemble" "Gaussian unitary ensemble" >}}
entry and
[From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance]({{< relref "/knowledge-base/deep-dives/normalized-hermitian-coordinates-to-gue-invariance" >}}).

The next algebraic layer is now available in the
{{< refterm "empirical-spectral-measure" "empirical spectral measure" >}}
entry and
[Finite Hermitian Spectra and Empirical Measures]({{< relref "/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures" >}}).
It converts the first two trace powers into moments of a finite spectral
counting measure while keeping the unresolved eigenvalue-measurability premise
explicit.

## References

<a id="ref-gloss-mathlib-bochner"></a>**Mathlib contributors.**
[Bochner integral](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Integral/Bochner/Basic.html),
[pushforward of a measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Map.html),
and
[matrix trace](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Trace.html),
Mathlib 4 documentation. These official APIs define the complex-valued
Bochner integral, transport integration through measurable maps, and provide
the finite trace algebra used here.

<a id="ref-gloss-mathlib-gaussian"></a>**Mathlib contributors.**
[Real Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Real.html)
and
[multivariate Gaussian distributions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Probability/Distributions/Gaussian/Multivariate.html),
Mathlib 4 documentation. These official pages document the centered scalar
Gaussian moments and the finite-dimensional standard Gaussian representation.

<a id="ref-gloss-agz"></a>**Greg W. Anderson, Alice Guionnet, and Ofer Zeitouni.**
[An Introduction to Random Matrices](https://doi.org/10.1017/CBO9780511801334),
Cambridge University Press, 2010. Chapters 2 and 3 provide the standard
Wigner-matrix and Gaussian-ensemble context. Normalizations vary across the
literature, so the project ledger above remains authoritative for the checked
identities.

<a id="ref-gloss-tao"></a>**Terence Tao.**
[Topics in Random Matrix Theory](https://doi.org/10.1090/gsm/132),
American Mathematical Society, 2012. The trace-moment method and its spectral
interpretation are developed in a standard asymptotic setting; those later
results are not inferred here from the first two finite identities.

<a id="ref-gloss-wigner"></a>**Eugene P. Wigner.**
[Characteristic Vectors of Bordered Matrices With Infinite Dimensions](https://doi.org/10.2307/1970079),
*Annals of Mathematics* 62 (1955), 548-564. This primary source is historical
context for the large-matrix moment program, not a source for the project-specific
Lean proof.

The exact upstream Lean source audited for this entry is Mathlib commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
the revision pinned by <code>formalization/lake-manifest.json</code>.
