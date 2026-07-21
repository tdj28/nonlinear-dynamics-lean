---
title: "Finite matrix trace moment"
slug: "finite-matrix-trace-moment"
summary: "A finite matrix trace moment is the expectation of a trace-power observable under a specified matrix law, after measurability, integrability, and normalization have each been made explicit."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleMoments"
og_image: "finite-matrix-trace-moment-card.png"
og_image_alt: "A matrix law passes through a trace-power observable and a separate integrability gate before its complex Bochner integral can be read as a finite expected trace moment."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft. Human review of the
mathematics, Lean interpretation, sources, figure, and accessibility remains
pending. The page must remain a draft until that review is complete.
{{< /panel >}}

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

## The second power sees the whole Hermitian matrix

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
derives both identities step by step and maps them to the checked Lean proofs.
The {{< refterm "matrix-trace" "matrix trace" >}} entry fixes the algebraic
operation, while
{{< refterm "hermitian-frobenius-geometry" "Hermitian Frobenius geometry" >}}
explains the norm identity behind the second moment.

For the law being integrated, read the
{{< refterm "gaussian-unitary-ensemble" "Gaussian unitary ensemble" >}}
entry and
[From Normalized Hermitian Coordinates to Gaussian Unitary Ensemble Invariance]({{< relref "/knowledge-base/deep-dives/normalized-hermitian-coordinates-to-gue-invariance" >}}).

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
