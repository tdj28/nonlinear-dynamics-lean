---
title: "Empirical spectral measure"
slug: "empirical-spectral-measure"
summary: "A finite matrix spectrum becomes a counting measure with multiplicity, then a probability-normalized empirical measure in positive dimension."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleSpectrum"
og_image: "empirical-spectral-measure-card.png"
og_image_alt: "A three-by-three spectrum two, two, minus one becomes counting measure two delta at two plus delta at minus one, then empirical masses two thirds and one third with trace moments shown."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working note. Human review of the
mathematics, Lean interpretation, sources, figures, and accessibility remains
pending. The page is public so readers can follow the work while that review
is still open.
{{< /panel >}}

An **empirical spectral measure** turns the eigenvalues of one finite matrix
into one measure on the number line. Every eigenvalue slot receives equal
weight, and repeated eigenvalues contribute repeatedly.

For a positive-dimensional \(n\times n\) Hermitian matrix \(H\) with ordered
real eigenvalues

\[
\lambda_0(H)\geq\lambda_1(H)\geq\cdots\geq\lambda_{n-1}(H),
\]

first form the **spectral counting measure**

\[
\kappa_H=\sum_{i=0}^{n-1}\delta_{\lambda_i(H)}.
\]

It has total mass \(n\). Then divide every atom by \(n\):

\[
\mu_H=\frac1n\kappa_H
=\frac1n\sum_{i=0}^{n-1}\delta_{\lambda_i(H)}.
\]

The result has total mass one when \(n\gt0\). It is therefore a probability
measure describing the fraction of eigenvalue slots in any measurable region.

## A \(3\times3\) example with a repeated eigenvalue

Take the real diagonal, hence Hermitian, matrix

\[
H=
\begin{bmatrix}
2&0&0\\
0&2&0\\
0&0&-1
\end{bmatrix}.
\]

Its decreasing eigenvalue vector is

\[
(\lambda_0,\lambda_1,\lambda_2)=(2,2,-1).
\]

The value \(2\) occurs in two different index slots. The spectral counting
measure therefore is

\[
\begin{aligned}
\kappa_H
&=\delta_2+\delta_2+\delta_{-1}\\
&=2\delta_2+\delta_{-1}.
\end{aligned}
\]

Its mass on the whole real line is

\[
\kappa_H(\mathbb R)=3.
\]

Normalize by the number of slots:

\[
\mu_H
=\frac13\kappa_H
=\frac23\delta_2+\frac13\delta_{-1}.
\]

Now

\[
\mu_H(\mathbb R)=1,
\qquad
\mu_H(\{2\})=\frac23,
\qquad
\mu_H(\{-1\})=\frac13.
\]

Replacing the eigenvalue vector by the set of distinct values
\(\{2,-1\}\) would erase the multiplicity at \(2\). It would produce the
wrong masses and the wrong moments.

## First moment: normalized trace

Integrating the identity function against the counting measure adds all three
eigenvalue slots:

\[
\begin{aligned}
\int_{\mathbb R}t\,d\kappa_H(t)
&=2+2-1\\
&=3\\
&=\operatorname{Tr}(H).
\end{aligned}
\]

For the normalized empirical measure,

\[
\begin{aligned}
\int_{\mathbb R}t\,d\mu_H(t)
&=\frac13(2+2-1)\\
&=1\\
&=\frac13\operatorname{Tr}(H).
\end{aligned}
\]

The first empirical spectral moment is the average eigenvalue, not the
unnormalized trace.

## Second moment: normalized trace square

The second counting-measure moment is

\[
\begin{aligned}
\int_{\mathbb R}t^2\,d\kappa_H(t)
&=2^2+2^2+(-1)^2\\
&=4+4+1\\
&=9.
\end{aligned}
\]

Because

\[
H^2=
\begin{bmatrix}
4&0&0\\
0&4&0\\
0&0&1
\end{bmatrix},
\]

this is exactly

\[
\int_{\mathbb R}t^2\,d\kappa_H(t)=\operatorname{Tr}(H^2)=9.
\]

Normalize once more:

\[
\int_{\mathbb R}t^2\,d\mu_H(t)
=\frac13\operatorname{Tr}(H^2)
=3.
\]

The example has empirical mean \(1\) and empirical second moment \(3\).
Its empirical variance is consequently \(3-1^2=2\), although the current
project theorem names only the first two raw moments.

{{< reference-figure
  wide="true"
  src="empirical-spectrum-3x3-ledger.svg"
  alt="The diagonal Hermitian matrix with entries two, two, and minus one produces eigenvalue slots two, two, and minus one. Its counting measure has mass two at two and mass one at minus one, total three. Dividing by three gives empirical masses two thirds and one third. First moments are three and one; second moments are nine and three. A lower flow separates the realized measure from its probability law when the matrix is random."
  caption="**Worked ledger:** repeated eigenvalue slots add their Dirac masses, so \(\kappa_H=2\delta_2+\delta_{-1}\) and \(\mu_H=(2/3)\delta_2+(1/3)\delta_{-1}\). Counting moments recover \(\operatorname{Tr}(H)\) and \(\operatorname{Tr}(H^2)\); empirical moments divide them by \(3\). The lower row emphasizes a type distinction: one matrix gives one measure, while a random matrix law pushes forward to a probability distribution over such measures."
>}}

## The exact general moment bridge

For any intrinsic \(n\times n\) Hermitian matrix, the project proves

\[
\int_{\mathbb R}(t:\mathbb C)\,d\kappa_H(t)
=\operatorname{Tr}(H)
\]

and

\[
\int_{\mathbb R}(t:\mathbb C)^2\,d\kappa_H(t)
=\operatorname{Tr}(H^2).
\]

The cast into \(\mathbb C\) matches the complex-valued matrix trace. Since all
Hermitian eigenvalues are real, this changes the codomain, not the numerical
values in the worked example.

The normalized sample moments are

\[
m_1(H)=n^{-1}\operatorname{Tr}(H),
\qquad
m_2(H)=n^{-1}\operatorname{Tr}(H^2),
\]

with the project's zero-dimensional inverse convention included in the Lean
theorems.

{{< reference-figure
  src="count-normalize-spectrum.svg"
  alt="A decreasing list keeps one slot for every Hermitian eigenvalue, including repeated values. Each slot contributes one point mass. Equal weighting gives an empirical spectral measure in positive dimension, while an empty spectrum gives the zero measure."
  caption="**General pattern:** preserve multiplicity as one Dirac mass per finite index, then scale the counting measure. Ordering supplies a canonical eigenvalue coordinate system even though the final sum of atoms is unchanged by permutation."
>}}

## Ordering is useful even though measures forget order

The sum of Dirac measures is unchanged if the eigenvalue vector is permuted.
The project nevertheless starts with a decreasing vector because canonical
coordinates support statements about the largest and smallest eigenvalues.

Pinned Mathlib supplies <code>Matrix.IsHermitian.eigenvalues₀</code> in
decreasing order. The project transports that vector to the concrete index
type <code>Fin n</code> using an order-preserving cast and proves
<code>orderedHermitianEigenvalues_antitone</code>.

Multiplicity survives that ordering. In the example, the first two
coordinates both equal \(2\); the measure then adds their two unit atoms at
the same real location.

## The \(n=0\) policy

At dimension zero, there are no eigenvalue slots. The finite sum defining the
counting measure is empty, so

\[
\kappa_H=0.
\]

The project defines the empirical measure uniformly as

\[
\mu_H=(n:\mathbb R_{\geq0}^{\infty})^{-1}\,\kappa_H.
\]

When \(n=0\), the counting measure is already zero, and scalar multiplication
of the zero measure remains zero. Thus

\[
\mu_H=0
\qquad(n=0).
\]

This zero measure has total mass zero, so it is not a probability measure on
\(\mathbb R\). The project exposes:

- <code>empiricalSpectralMeasure_isZeroOrProbability</code> in every
  dimension;
- <code>empiricalSpectralMeasure_succ_isProbability</code> for dimension
  <code>n + 1</code>; and
- <code>empiricalSpectralProbability n H</code> as a genuine bundled
  probability measure only in positive dimension.

No artificial eigenvalue at zero is inserted merely to make the empty case
look probabilistic.

## One realized measure is not its probability law

Suppose now that \(H(\omega)\) is random.

| Object | Type-level role | Meaning |
|---|---|---|
| \(H(\omega)\) | one Hermitian matrix | one realized sample |
| \(\mu_{H(\omega)}\) | one measure on \(\mathbb R\) | the realized empirical spectrum |
| \(\omega\mapsto\mu_{H(\omega)}\) | a measure-valued random variable | the empirical spectrum varies with the sample |
| \(\mathcal L(\mu_H)\) | a measure on the space of measures | the distribution of realized empirical measures |
| \(\mathbb E[\mu_H]\) | one averaged measure on \(\mathbb R\) | the barycenter of that distribution |

For finite GUE, the project names the distribution
<code>GUE.empiricalSpectralLaw n</code>. It is a probability measure on
<code>Measure ℝ</code>. In positive dimension it also offers a law valued in
<code>ProbabilityMeasure ℝ</code>.

This distinction is especially sharp at \(n=0\):

\[
\mu_H=0,
\qquad
\mathcal L(\mu_H)=\delta_0.
\]

The realized empirical measure is the zero measure on \(\mathbb R\). Its law
is a Dirac probability measure on the **space of measures**. These live on
different spaces and have different total masses.

## In Lean: one matrix gives one measure

{{< lean-bridge
  human="Take the eigenvalues of this intrinsic Hermitian matrix H, count every slot with multiplicity, and divide by the matrix dimension."
  math="\(\displaystyle\mu_H=\frac1n\sum_{i=0}^{n-1}\delta_{\lambda_i(H)}.\)"
  lean="NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMeasure H"
>}}

- <code>H</code> is one value of type
  <code>RandomMatrix.HermitianEuclidean n</code>.
- <code>orderedHermitianEigenvalues H i</code> is the real eigenvalue in slot
  <code>i : Fin n</code>.
- <code>spectralCountingMeasure H</code> sums one Dirac measure per slot.
- <code>empiricalSpectralMeasure H</code> scales that measure by the extended
  nonnegative-real reciprocal of <code>n</code>.
- The result has type <code>Measure ℝ</code>. In positive dimension a theorem
  separately certifies total mass one.
{{< /lean-bridge >}}

## In Lean: the second sample moment is a trace power

{{< lean-bridge
  human="The second moment of H's empirical spectral measure equals one over n times the ordinary trace of H squared."
  math="\(\displaystyle m_2(H)=\int t^2\,d\mu_H(t)=n^{-1}\operatorname{Tr}(H^2).\)"
  lean="NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMoment_two H"
>}}

- <code>empiricalSpectralMoment 2 H</code> is a complex-valued integral.
- <code>hermitianToMatrix H</code> forgets the intrinsic Hermitian wrapper
  without changing matrix entries.
- <code>Matrix.trace ((hermitianToMatrix H) ^ 2)</code> is the ordinary,
  unnormalized trace of the square.
- The theorem's reciprocal is totalized, so the same statement also covers
  \(n=0\).
- For the worked size-three matrix, the right side is
  \(3^{-1}\cdot9=3\).
{{< /lean-bridge >}}

## In Lean: a random matrix gives a law of measures

{{< lean-bridge
  human="Sample a size-three GUE matrix repeatedly, compute its empirical spectral measure each time, and take the distribution of those measure-valued outputs."
  math="\(\mathcal Q_3=(\mu_{\bullet})_*\mathbb P_{\mathrm{GUE},3}\in\operatorname{Prob}(\operatorname{Measure}(\mathbb R)).\)"
  lean="NonlinearDynamics.Random.GUE.empiricalSpectralLaw 3"
>}}

- <code>GUE.intrinsicLaw 3</code> is the source probability law on intrinsic
  Hermitian matrices.
- <code>empiricalSpectralMeasure</code> is the measurable map applied to each
  matrix.
- <code>empiricalSpectralLaw 3</code> is their pushforward and has type
  <code>Measure (Measure ℝ)</code>.
- Its samples are measures such as \(\mu_H\); it is not itself the empirical
  measure of one fixed matrix.
- <code>meanEmpiricalSpectralMeasure 3</code> is yet another object, obtained
  by taking the Giry barycenter of this law.
{{< /lean-bridge >}}

## Exact project excerpts

**Resource label: pinned project plus Mathlib.** The authoritative deterministic
definitions are in
[<code>HermitianSpectrum.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/HermitianSpectrum.lean):

~~~lean
noncomputable def spectralCountingMeasure {n : ℕ}
    (H : HermitianEuclidean n) : Measure ℝ :=
  ∑ i, Measure.dirac (orderedHermitianEigenvalues H i)

noncomputable def empiricalSpectralMeasure {n : ℕ}
    (H : HermitianEuclidean n) : Measure ℝ :=
  (n : ℝ≥0∞)⁻¹ • spectralCountingMeasure H
~~~

The first line preserves multiplicity because the sum runs over all finite
index slots, not over the set of distinct real values. The second line
normalizes the complete counting measure.

The exact second counting-moment theorem is:

~~~lean
theorem integral_sq_complex_ofReal_spectralCountingMeasure {n : ℕ}
    (H : HermitianEuclidean n) :
    ∫ x : ℝ, (x : ℂ) ^ 2 ∂spectralCountingMeasure H =
      Matrix.trace ((hermitianToMatrix H) ^ 2) := by
  rw [spectralCountingMeasure]
  rw [integral_finsetSum_measure]
  · simp only [integral_dirac]
    exact (trace_sq_eq_sum_sq_orderedHermitianEigenvalues H).symm
  · intro i _
    exact integrable_dirac (by simp)
~~~

The proof expands the finite sum of Dirac measures, evaluates the integral at
each atom, and invokes the checked eigenvalue power-sum identity.

The normalized moment layer in
[<code>GaussianUnitaryEnsembleSpectrum.lean</code>](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleSpectrum.lean)
defines:

~~~lean
noncomputable def empiricalSpectralMoment {n : ℕ} (k : ℕ)
    (H : HermitianEuclidean n) : ℂ :=
  ∫ x : ℝ, (x : ℂ) ^ k ∂empiricalSpectralMeasure H

theorem empiricalSpectralMoment_two {n : ℕ} (H : HermitianEuclidean n) :
    empiricalSpectralMoment 2 H =
      (((n : ℕ) : ℝ)⁻¹ : ℂ) * Matrix.trace ((hermitianToMatrix H) ^ 2) := by
  rw [empiricalSpectralMoment, empiricalSpectralMeasure,
    integral_smul_measure, ENNReal.toReal_inv]
  rw [integral_sq_complex_ofReal_spectralCountingMeasure]
  norm_cast
~~~

Finally, the law of the random measure is a separate definition:

~~~lean
noncomputable def empiricalSpectralLaw (n : ℕ) : Measure (Measure ℝ) :=
  (intrinsicLaw n).map empiricalSpectralMeasure
~~~

The nested type <code>Measure (Measure ℝ)</code> is deliberate: the outer
measure describes how the inner realized measures vary.

## Tiny local Lean/Std multiplicity worksheet

**Resource label: tiny standalone check.** This worksheet imports only
<code>Std</code>. It calculates the finite eigenvalue ledger using exact
rationals. It does not define Dirac measures, diagonalize matrices, or prove
the project trace theorems.

Save it as <code>EmpiricalSpectrum3Scratch.lean</code>:

~~~lean
import Std

def eigenvalueSlots : List Rat :=
  [2, 2, -1]

def countingMomentOf (xs : List Rat) (k : Nat) : Rat :=
  xs.foldl (fun total x => total + x ^ k) 0

def empiricalMomentOf (xs : List Rat) (k : Nat) : Rat :=
  match xs with
  | [] => 0
  | _ :: _ => countingMomentOf xs k / (xs.length : Rat)

#eval eigenvalueSlots.length
#eval eigenvalueSlots.count 2
#eval eigenvalueSlots.count (-1)
#eval countingMomentOf eigenvalueSlots 1
#eval empiricalMomentOf eigenvalueSlots 1
#eval countingMomentOf eigenvalueSlots 2
#eval empiricalMomentOf eigenvalueSlots 2
#eval empiricalMomentOf [] 2
~~~

Run it with:

~~~sh
elan run leanprover/lean4:v4.32.0 lean EmpiricalSpectrum3Scratch.lean
~~~

The outputs should be \(3,2,1,3,1,9,3,0\). The second output is the
multiplicity of eigenvalue \(2\); the final output implements the explicit
empty-list policy.

## Try the exact declarations in the project

{{< repo-check >}}
**Resource label: pinned project plus Mathlib.** A human can type this
worksheet in a deliberately provisioned copy of the repository:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleSpectrum

#check NonlinearDynamics.Random.RandomMatrix.orderedHermitianEigenvalues
#check NonlinearDynamics.Random.RandomMatrix.orderedHermitianEigenvalues_antitone
#check NonlinearDynamics.Random.RandomMatrix.trace_eq_sum_orderedHermitianEigenvalues
#check NonlinearDynamics.Random.RandomMatrix.trace_sq_eq_sum_sq_orderedHermitianEigenvalues
#check NonlinearDynamics.Random.RandomMatrix.spectralCountingMeasure
#check NonlinearDynamics.Random.RandomMatrix.spectralCountingMeasure_zero
#check NonlinearDynamics.Random.RandomMatrix.spectralCountingMeasure_univ
#check NonlinearDynamics.Random.RandomMatrix.integral_complex_ofReal_spectralCountingMeasure
#check NonlinearDynamics.Random.RandomMatrix.integral_sq_complex_ofReal_spectralCountingMeasure
#check NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMeasure
#check NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMeasure_zero
#check NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMeasure_isZeroOrProbability
#check NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMeasure_succ_isProbability
#check NonlinearDynamics.Random.RandomMatrix.empiricalSpectralProbability
#check NonlinearDynamics.Random.RandomMatrix.measurable_empiricalSpectralMeasure
#check NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMoment
#check NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMoment_zero
#check NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMoment_one
#check NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMoment_two
#check NonlinearDynamics.Random.GUE.empiricalSpectralLaw
#check NonlinearDynamics.Random.GUE.empiricalSpectralLaw_zero
#check NonlinearDynamics.Random.GUE.meanEmpiricalSpectralMeasure
#check NonlinearDynamics.Random.GUE.meanEmpiricalSpectralMeasure_zero
#check NonlinearDynamics.Random.GUE.empiricalSpectralLaw_eq_map_matrixLaw_ambient
~~~

Each <code>#check</code> asks the pinned elaborator for an exact declaration
type. The imported leaf module reaches deterministic spectra, continuity and
measurability, GUE pushforwards, and normalized moments. The guarded command
below checks that complete module on an approved Linux builder.
{{< /repo-check >}}

## Measurability is the bridge to a distribution

The formula for \(\mu_H\) makes sense pointwise before any probability space
is introduced. To push a matrix law through

\[
H\longmapsto\mu_H,
\]

the map must also be measurable into the space of measures carrying Mathlib's
Giry measurable structure.

The project proves a Frobenius-norm Weyl perturbation bound for ordered
Hermitian eigenvalues, deduces continuity and coordinatewise measurability,
and then proves
<code>measurable_empiricalSpectralMeasure</code>. Only after that bridge is
available does the pushforward law become an unconditional checked object.

This separates two questions:

1. **Algebraic:** what measure does a fixed matrix produce?
2. **Probabilistic:** can a random matrix law be pushed through that map?

A correct pointwise formula does not automatically answer the second
question.

## Unitary basis changes preserve the realized measure

For a unitary matrix \(U\), intrinsic congruence sends

\[
H\longmapsto UHU^*.
\]

The project proves the complete ordered eigenvalue vector unchanged, and
therefore proves

\[
\kappa_{UHU^*}=\kappa_H,
\qquad
\mu_{UHU^*}=\mu_H.
\]

This is a deterministic statement for each \(H\) and \(U\). It is different
from unitary invariance of a random matrix law, although the two facts work
together in GUE.

## Distinctions and failure modes

| Tempting shortcut | What goes wrong | Correct repair |
|---|---|---|
| Replace repeated eigenvalues by a set of distinct values | Algebraic multiplicity disappears | Sum one Dirac mass per eigenvalue index |
| Call \(\kappa_H\) a probability measure | Its total mass is \(n\), not one | Divide by \(n\) when \(n\gt0\) |
| Call \(\mu_H\) the spectral law of random \(H\) | \(\mu_H\) is one realized measure | Push the matrix law through \(H\mapsto\mu_H\) |
| Confuse \(\mathcal L(\mu_H)\) with \(\mathbb E[\mu_H]\) | One is a distribution on measures; the other is one barycenter measure | Track the outer and inner carrier types |
| Insert \(\delta_0\) for an empty spectrum | It invents an eigenvalue that does not exist | Use the explicit zero-measure policy |
| Say the empirical measure is always probabilistic | At \(n=0\), its total mass is zero | Use zero-or-probability globally and probability only for positive dimension |
| Normalize the trace theorem itself | The checked counting moment uses ordinary trace | Apply \(n^{-1}\) at the empirical-measure layer |
| Infer a semicircle law from two moments | Two finite moments do not prove convergence or identify a limit | State asymptotic claims separately and prove them |
| Assume measurability from the formula | Eigenvalue selection requires an analytic continuity argument | Use the checked Weyl-continuity bridge |

{{< panel "warning" >}}
**What this entry does not establish.** The finite empirical measure does not
by itself give an eigenvalue density, level-spacing statistic, unfolded
spectrum, concentration estimate, semicircle law, circular law, universality
theorem, or large-dimension convergence result.
{{< /panel >}}

## Exercises

1. Replace the example by
   \(H=\operatorname{diag}(3,3,-2,-2)\). Compute
   \(\kappa_H(\{3\})\), \(\mu_H(\{3\})\), and both first two empirical
   moments.
2. Verify directly that permuting \((2,2,-1)\) leaves the sum of Dirac
   measures unchanged.
3. Explain why \(\delta_0\) is the law of the zero empirical measure at
   \(n=0\), while it is not the zero empirical measure itself.
4. Draw the carrier types for \(H\), \(\mu_H\),
   \(\mathcal L(\mu_H)\), and \(\mathbb E[\mu_H]\).

## Where to continue

[Finite Hermitian Spectra and Empirical Measures]({{< relref "/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures" >}})
develops the ordered spectrum, multiplicity, counting measure, normalization,
ambient totalization, and zero boundary in textbook detail.
[Hermitian Spectral Perturbation, Continuity, and Measurability]({{< relref "/knowledge-base/deep-dives/hermitian-spectral-perturbation-continuity-and-measurability" >}})
proves the Weyl bound that turns this pointwise observable into a measurable
map.

[Finite Gaussian Unitary Ensemble Empirical Spectral Laws and Normalized Moments]({{< relref "/knowledge-base/deep-dives/finite-gue-empirical-spectral-laws-and-normalized-moments" >}})
continues from one realized measure to its GUE distribution, Giry mean, and
first two expected normalized moments. Read
{{< refterm "empirical-spectral-law" "empirical spectral law" >}} for the
outer probability law and
{{< refterm "finite-matrix-trace-moment" "finite matrix trace moment" >}} for
the earlier ordinary-trace expectation layer.

## References

**Mathlib contributors.**
[Spectral theory of Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Spectrum.html),
Mathlib 4 documentation. This official page defines the decreasingly sorted
Hermitian eigenvalue vector and supplies the finite spectral theorem used by
the project.

**Mathlib contributors.**
[Dirac measure](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Dirac.html)
and
[probability measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/ProbabilityMeasure.html),
Mathlib 4 documentation. These APIs underlie the finite atomic sum and the
positive-dimensional probability wrapper.

**Mathlib contributors.**
[The Giry measurable structure on measures](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/GiryMonad.html),
Mathlib 4 documentation. This is the measure-space structure used when an
empirical measure itself becomes a random output.

**Terence Tao, Van Vu, with an appendix by Manjunath Krishnapur.**
[Random matrices: Universality of ESDs and the circular law](https://doi.org/10.1214/10-AOP534),
*The Annals of Probability* 38 (2010), 2023-2065. This primary paper uses the
normalized empirical spectral distribution convention for general complex
matrices. Its non-Hermitian asymptotic results are context, not project
theorems.

**Nonlinear Dynamics in Lean contributors.**
[HermitianSpectrum.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/HermitianSpectrum.lean),
[HermitianSpectrumContinuity.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/HermitianSpectrumContinuity.lean),
and
[GaussianUnitaryEnsembleSpectrum.lean](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomMatrices/GaussianUnitaryEnsembleSpectrum.lean),
the checked project sources for finite spectra, measure-valued measurability,
random spectral laws, and normalized moments.

The upstream Mathlib revision audited for this entry is commit
[81a5d257](https://github.com/leanprover-community/mathlib4/tree/81a5d257c8e410db227a6665ed08f64fea08e997),
pinned by <code>formalization/lake-manifest.json</code>.
