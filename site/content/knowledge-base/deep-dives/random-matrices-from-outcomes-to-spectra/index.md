---
title: "Random Matrices: From Outcomes to Spectra"
slug: "random-matrices-from-outcomes-to-spectra"
date: 2026-07-20
summary: "A worked ascent from one finite probability experiment to measurable matrix coordinates, Hermitian realizations, eigenvalues, empirical spectral measures, and a probability law on measures."
lead: "A fair coin chooses one of two concrete matrices. We will follow that single experiment all the way from outcomes and entry maps to checked eigenpairs, sample spectral measures, and the law of the random measure, then translate every layer into Lean."
draft: false
pro_reviewed: false
level: "Base camp to finite spectral probability"
reading_time: "55 to 75 minutes"
prerequisites: "Basic arithmetic and two-by-two matrices; probability, measure theory, spectral measures, and Lean syntax are introduced as they appear"
lean_module: "NonlinearDynamics.Random.RandomMatrices.Basic"
toc: true
og_image: "random-matrices-card.png"
og_image_alt: "A fair red-or-blue outcome selects one of two exact two-by-two matrices, whose checked eigenvalue slots become one of two empirical spectral measures."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note. Human review
of the rebuilt prose, citations, equations, exact example, Lean tutorial, and
accessible figures remains pending. The page stays
<code>pro_reviewed: false</code> until that review is complete.
{{< /panel >}}

A random matrix is not a matrix with mysterious entries. It is a function:
give it an outcome, and it returns one ordinary matrix. Probability enters
through a measure on the outcomes. Spectral theory enters only after a matrix
has been realized. A
{{< refterm "probability-law" "probability distribution, or law" >}} enters
only after measurability permits probability to be pushed through the
function.

Those layers are easy to blur in prose. We will keep them separate by carrying
one exact finite example through the whole chapter.

## The running experiment: one fair coin, two matrices

Let the sample space be

\[
\Omega=\{\mathrm{red},\mathrm{blue}\}.
\]

A **sample space** is simply the set of possible underlying outcomes. Declare
every subset of \(\Omega\) to be an
{{< refterm "event" "event" >}}, and assign the fair
{{< refterm "probability-measure" "probability measure" >}}

\[
\mathbb P(\{\mathrm{red}\})
{} =
\mathbb P(\{\mathrm{blue}\})
{} =
\frac12.
\]

Define the matrix-valued rule \(X\) by

\[
X(\mathrm{red})
{} =
R=
\begin{bmatrix}
2&0\\
0&0
\end{bmatrix},
\qquad
X(\mathrm{blue})
{} =
B=
\begin{bmatrix}
0&1\\
1&0
\end{bmatrix}.
\]

The function \(X\) is the random matrix. The ordinary matrix \(R\) or \(B\)
seen after one coin toss is a **realization**, also called a sample value.
One realization is not the whole random matrix, just as one coin toss is not
the coin-tossing rule.

### Check every coordinate before invoking probability

Write \(X_{ij}(\omega)=X(\omega)_{ij}\). In this example the four scalar
coordinate functions have the following values:

| Entry map | At red | At blue |
|---|---:|---:|
| \(X_{00}\) | \(2\) | \(0\) |
| \(X_{01}\) | \(0\) | \(1\) |
| \(X_{10}\) | \(0\) | \(1\) |
| \(X_{11}\) | \(0\) | \(0\) |

Because every subset of the two-point source is measurable, the preimage of
every scalar event is measurable. For example,

\[
\{\omega:X_{00}(\omega)\gt1\}
{} =
\{\mathrm{red}\},
\qquad
\mathbb P\{X_{00}\gt1\}
{} =
\frac12.
\]

This one calculation already has the shape of a pushforward law: define a
set of possible values, pull it back through the random object, and measure
the resulting source event.

### Check the red realization and its spectrum

An **eigenvalue** of a matrix \(H\) is a scalar \(\lambda\) for which some
nonzero vector \(v\) satisfies \(Hv=\lambda v\). Such a vector is an
eigenvector. The matrix \(R\) is diagonal. Its standard basis vectors satisfy

\[
R
\begin{bmatrix}1\\0\end{bmatrix}
{} =
2\begin{bmatrix}1\\0\end{bmatrix},
\qquad
R
\begin{bmatrix}0\\1\end{bmatrix}
{} =
0\begin{bmatrix}0\\1\end{bmatrix}.
\]

Its two eigenvalue slots, counted with multiplicity, are therefore \(2\) and
\(0\). Equivalently,

\[
\det(\lambda I-R)=\lambda(\lambda-2).
\]

### Check the blue realization and its spectrum

The blue matrix swaps the two coordinates. The two diagonal directions obey

\[
B
\begin{bmatrix}1\\1\end{bmatrix}
{} =
1\begin{bmatrix}1\\1\end{bmatrix},
\qquad
B
\begin{bmatrix}1\\-1\end{bmatrix}
{} =
-1\begin{bmatrix}1\\-1\end{bmatrix}.
\]

Thus the blue eigenvalue slots are \(1\) and \(-1\). The characteristic
polynomial confirms the same roots:

\[
\det(\lambda I-B)=\lambda^2-1=(\lambda-1)(\lambda+1).
\]

Both realizations are real symmetric, hence complex Hermitian. A
{{< refterm "hermitian-matrix" "Hermitian matrix" >}} equals its own
{{< refterm "conjugate-transpose" "conjugate transpose" >}}. Its finite
eigenvalues are real, which is why Hermitian matrix models lead naturally to
measures on the real line
([Mathlib contributors](#ref-mathlib-spectrum)).

### Turn each realized spectrum into one measure

The {{< refterm "empirical-spectral-measure" "empirical spectral measure" >}}
places equal mass on every eigenvalue slot. Each realization here has two
slots, so

\[
L_R=\frac12\delta_2+\frac12\delta_0,
\qquad
L_B=\frac12\delta_1+\frac12\delta_{-1}.
\]

The symbol \(\delta_x\) denotes the Dirac measure at \(x\): it puts one unit
of mass at \(x\) and none elsewhere. Each \(L\) above has total mass one.
It is one measure produced by one realized matrix.

Now repeat the outer coin experiment. The
{{< refterm "empirical-spectral-law" "empirical spectral law" >}} is

\[
\mathcal Q
{} =
\frac12\delta_{L_R}+\frac12\delta_{L_B}.
\]

The atoms of \(\mathcal Q\) are whole measures, not real eigenvalues. With
outer probability \(1/2\), a sample from \(\mathcal Q\) returns \(L_R\); with
outer probability \(1/2\), it returns \(L_B\).

{{< reference-figure
  wide="true"
  src="coin-matrices-to-spectra.svg"
  alt="The fair red outcome selects the diagonal matrix with eigenvalues two and zero, while the fair blue outcome selects the symmetric swap matrix with eigenvalues one and minus one. Each pair becomes an equally weighted sample spectral measure, and the outer law chooses either whole measure with probability one half."
  caption="**Worked example:** red selects \(R=\operatorname{diag}(2,0)\), whose two eigenvalue slots give \(L_R=(1/2)\delta_2+(1/2)\delta_0\). Blue selects the symmetric swap matrix, whose slots \(1,-1\) give \(L_B=(1/2)\delta_1+(1/2)\delta_{-1}\). The fair outer law is \((1/2)\delta_{L_R}+(1/2)\delta_{L_B}\). The plate shows a finite teaching model, not a Gaussian ensemble, a fitted dataset, or an asymptotic law."
>}}

## One average is not the law on measures

If we average the two sample measures, we obtain one measure on \(\mathbb R\):

\[
\overline L
{} =
\frac12L_R+\frac12L_B
{} =
\frac14\delta_2+
\frac14\delta_1+
\frac14\delta_0+
\frac14\delta_{-1}.
\]

The types tell us why \(\mathcal Q\) and \(\overline L\) are different:

| Object | Mathematical type | What one sample returns |
|---|---|---|
| \(X\) | \(\Omega\to\mathbb C^{2\times2}\) | one matrix |
| \(L_X\) | \(\Omega\to\operatorname{Measure}(\mathbb R)\) | one spectral measure |
| \(\mathcal Q\) | \(\operatorname{Measure}(\operatorname{Measure}(\mathbb R))\) | one whole spectral measure |
| \(\overline L\) | \(\operatorname{Measure}(\mathbb R)\) | one real location, if sampled |

The average forgets which eigenvalues arrived together. For example, under
\(\mathcal Q\), eigenvalues \(2\) and \(0\) occur in the same matrix sample.
The single measure \(\overline L\) retains their marginal masses but not that
pairing.

This distinction is central to the repository's typed-object ledger. A sample
measure, its law on a space of measures, a bundled probability-valued law,
and a **Giry barycenter**, which integrates the inner measures into one mean
measure, are related constructions, not interchangeable names.

## A nearby nonexample: equal spectra can hide different operators

Consider

\[
Z=
\begin{bmatrix}
0&0\\
0&0
\end{bmatrix},
\qquad
N=
\begin{bmatrix}
0&1\\
0&0
\end{bmatrix}.
\]

Both characteristic polynomials are \(\lambda^2\), so both empirical
spectral measures are \(\delta_0\). Yet \(Z\) kills every vector, while

\[
N
\begin{bmatrix}0\\1\end{bmatrix}
{} =
\begin{bmatrix}1\\0\end{bmatrix}.
\]

The matrix \(N\) is nonzero, **nilpotent** because \(N^2=0\), and not
Hermitian. This boundary teaches two rules:

1. real eigenvalues do not imply Hermitian symmetry; and
2. an empirical spectral measure does not determine the original matrix.

The blue realization is recovered from this nonexample by unnormalized
Hermitian symmetrization:

\[
N+N^*=B.
\]

Symmetrization changes the spectrum and the geometry. It is a constructor,
not a harmless relabeling.

{{< reference-figure
  wide="true"
  src="entry-gates-and-spectrum-boundary.svg"
  alt="The red then blue coordinate pairs are upper-left two then zero, upper-right zero then one, lower-left zero then one, and lower-right zero then zero. The upper-left-greater-than-one event pulls back to red and has probability one half. Typed gates separate the matrix rule, measurability, matrix law, spectral map, and law on measures. The zero matrix and a nonzero square-zero matrix share two zero eigenvalue slots but act differently; the latter is not Hermitian."
  caption="**Two gates and a boundary:** the red-then-blue coordinate pairs are \(2,0\) at upper left, \(0,1\) at upper right, \(0,1\) at lower left, and \(0,0\) at lower right. Thus the upper-left-entry event pulls back to red and has probability \(1/2\). Entrywise measurability licenses the matrix pushforward; measurability of the spectral observable separately licenses the outer law on measures. On the right, \(Z\) and the nonzero square-zero matrix \(N\) both yield \(\delta_0\), but \(N(0,1)=(1,0)\) and \(N\ne N^*\). The comparison shows that spectral data can discard operator geometry. It does not claim that all non-Hermitian matrices have real spectra."
>}}

## The abstract climb, now that every object has a face

The running example instantiates five general layers.

### 1. Outcomes and measurable events

A {{< refterm "measurable-space" "measurable space" >}}
\((\Omega,\mathcal F)\) consists of a set of outcomes and a collection
\(\mathcal F\) of measurable events. A
{{< refterm "measure" "measure" >}} \(\mu\) assigns sizes to those events.
When \(\mu(\Omega)=1\), it is a probability measure. These are the foundations
for random elements and their laws
([Kallenberg](#ref-kallenberg)).

Our finite example uses \(\mathcal F=\mathcal P(\Omega)\), the collection of
all subsets. In an uncountable sample space, not every subset is automatically
declared measurable, so the measurability obligation becomes substantive.

### 2. A matrix-valued map

For index sets \(\iota\) and \(\kappa\), a matrix-valued map is

\[
X:\Omega\longrightarrow\mathbb K^{\iota\times\kappa}.
\]

The project's base {{< refterm "random-matrix" "random matrix" >}} type is
exactly this function. It deliberately stores neither a source measure nor a
measurability proof. This makes the same function reusable under different
measures and in deterministic arguments.

In standard probability language, the map becomes a matrix-valued
{{< refterm "random-variable" "random variable" >}} once it is measurable.
A {{< refterm "measurable-function" "measurable function" >}} pulls every
measurable target set back to a measurable source event.

### 3. Entrywise measurability

The project's matrix space carries the product measurable structure generated
by its entries, even before the index types are assumed finite. Under the
project instance,

\[
X\text{ is measurable}
\quad\Longleftrightarrow\quad
\omega\longmapsto X(\omega)_{ij}
\text{ is measurable for every }i,j.
\]

This theorem concerns visibility to a measure. It says nothing about whether
different entries are independent. In a Hermitian matrix, lower-triangular
entries are conjugates of upper-triangular entries, so they are deliberately
dependent.

### 4. A realization and its spectral observable

Fixing \(\omega\) gives one ordinary matrix \(X(\omega)\). If that matrix is
Hermitian, its finite eigenvalues are real. The ordered eigenvalue vector and
the empirical spectral measure are deterministic functions of that one
realization.

The project later proves that the ordered Hermitian eigenvalues are continuous,
hence measurable, for its finite
{{< refterm "hermitian-frobenius-geometry" "Frobenius geometry" >}}, the
Euclidean geometry obtained by summing the squared magnitudes of all entries.
This is a second measurability gate. Measurability of matrix entries does not
make every nonlinear statistic measurable by magic; the statistic needs its
own theorem.

### 5. Pushforward laws

Given a measurable map \(X\) and source measure \(\mu\), the
{{< refterm "pushforward-measure" "pushforward" >}} law is

\[
\mathcal L_\mu(X)=X_*\mu.
\]

For every measurable matrix set \(D\),

\[
(X_*\mu)(D)=\mu(X^{-1}(D)).
\]

Applying the same construction to a measurable spectral-measure map produces
a law whose points are measures. A probability distribution need not have a
density; the running example is **atomic**, meaning its mass sits at finitely
many individual points.

## In Lean: from a bare carrier to Hermitian closure

### The bare function is the first layer

{{< lean-bridge
  human="A project random matrix accepts an outcome and returns one matrix. The base type alone contains no probability measure and no measurability proof."
  math="\(X:\Omega\longrightarrow\mathbb K^{\iota\times\kappa}.\)"
  lean="X : NonlinearDynamics.Random.RandomMatrix Ω ι κ 𝕜"
>}}

- <code>Ω</code> is the outcome type.
- <code>ι</code> and <code>κ</code> are the row and column index types.
- <code>𝕜</code> is the scalar type, such as <code>ℝ</code> or <code>ℂ</code>.
- <code>Matrix ι κ 𝕜</code> is Mathlib's two-index function type for matrices.
- <code>RandomMatrix Ω ι κ 𝕜</code> unfolds to
  <code>Ω → Matrix ι κ 𝕜</code>.
- The arrow <code>→</code> is the same outcome-to-value arrow used on paper.
{{< /lean-bridge >}}

The checked definition is:

~~~lean
abbrev RandomMatrix
    (Ω : Type uΩ) (ι : Type uι) (κ : Type uκ) (𝕜 : Type u𝕜) :=
  Ω → Matrix ι κ 𝕜
~~~

An abbreviation introduces a project name without wrapping the function in a
new data constructor. Applying <code>X</code> to <code>ω</code> still gives the
realized matrix <code>X ω</code> directly.

### The coordinate criterion is an equivalence

{{< lean-bridge
  human="The whole matrix-valued map is measurable exactly when every scalar entry map is measurable."
  math="\(X\text{ measurable}\iff\forall i,j,\;[\omega\mapsto X(\omega)_{ij}]\text{ measurable}.\)"
  lean="NonlinearDynamics.Random.RandomMatrix.measurable_iff_entries X : Measurable X ↔ ∀ i j, Measurable fun ω ↦ X ω i j"
>}}

- <code>Measurable X</code> is the matrix-level claim.
- <code>↔</code> means both implications are proved.
- <code>∀ i j</code> means every row index and every column index.
- <code>fun ω ↦ ...</code> constructs the scalar entry function.
- <code>X ω i j</code> first realizes the matrix at <code>ω</code>, then reads
  row <code>i</code> and column <code>j</code>.
- The theorem is about measurability only. No symbol here asserts independence,
  identical distribution, Gaussianity, or Hermitian symmetry.
{{< /lean-bridge >}}

The exact project proof is short because the matrix measurable structure was
chosen entrywise:

~~~lean
theorem measurable_iff_entries (X : RandomMatrix Ω ι κ 𝕜) :
    Measurable X ↔ ∀ i j, Measurable fun ω ↦ X ω i j := by
  rw [measurable_comap_iff]
  change Measurable (fun ω i j ↦ X ω i j) ↔ _
  simp only [measurable_pi_iff]
~~~

Read the proof in three moves:

1. <code>measurable_comap_iff</code> unfolds the measurable structure pulled
   back from the curried function representation.
2. <code>change</code> displays a matrix-valued function as a function of an
   outcome, row, and column.
3. <code>measurable_pi_iff</code> reduces product-valued measurability to all
   coordinate maps.

This release-specific interface was checked against
[Mathlib 4.32.0](#ref-mathlib-release). The exact
[pinned matrix source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/LinearAlgebra/Matrix/Defs.lean)
and
[pinned measurable-space source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/MeasurableSpace/Basic.lean)
remain the implementation authority for the imported APIs
([Mathlib contributors](#ref-mathlib-measurable)).

### Build new measurable matrices entry by entry

The base module proves that the operations needed for finite matrix theory
preserve measurability.

| Operation | Why each output entry is measurable | Extra finite gate |
|---|---|---|
| Transpose | read the input entry with swapped indices | none |
| Scalar map | compose one entry map with a measurable scalar function | none |
| Constant matrix | every entry is a constant function | none |
| Conjugate transpose | swap indices and take complex conjugation | none |
| Addition | add two measurable scalar functions | none |
| Multiplication | sum products of corresponding scalar functions | the shared index is finite |

For multiplication,

\[
(XY)_{ik}=\sum_jX_{ij}Y_{jk}.
\]

The theorem uses a finite sum over \(j\). It is not an infinite-dimensional
operator theorem.

#### Unnormalized Hermitian symmetrization

For a square complex matrix-valued map, the project defines

\[
\operatorname{sym}(X)(\omega)=X(\omega)+X(\omega)^*.
\]

It proves this constructor measurable when \(X\) is measurable. Separately, it
proves the result Hermitian at every outcome without needing a measurability
assumption. The constructor is intentionally **unnormalized**. Some contexts
use \((A+A^*)/2\), but that scaling would change future distributional and
spectral formulas even though Hermiticity remains true.

{{< lean-bridge
  human="At every outcome, add the realized complex matrix to its conjugate transpose. The result is Hermitian at every outcome, not merely almost surely."
  math="\(\operatorname{sym}(X)(\omega)=X(\omega)+X(\omega)^*,\quad \operatorname{sym}(X)(\omega)^*=\operatorname{sym}(X)(\omega).\)"
  lean="NonlinearDynamics.Random.RandomMatrix.hermitianSymmetrization_isHermitian X ω : (NonlinearDynamics.Random.RandomMatrix.hermitianSymmetrization X ω).IsHermitian"
>}}

- <code>hermitianSymmetrization X ω</code> applies the constructor and then
  realizes it at <code>ω</code>.
- <code>.IsHermitian</code> is the matrix property that the conjugate transpose
  equals the matrix.
- The explicit <code>ω</code> makes the statement pointwise.
- The later almost-everywhere theorem uses
  <code>Filter.Eventually.of_forall</code> to weaken this everywhere statement.
{{< /lean-bridge >}}

Pinned Mathlib's Hermitian algebra supplies the matrix property and closure
lemmas used here
([Mathlib contributors](#ref-mathlib-hermitian)).

### Try the exact base declarations in the repository

{{< repo-check >}}
**Resource label: pinned project plus Mathlib, cloud-only for this project.**
A learner can create a temporary probe on an approved Linux builder with:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.Basic

#print NonlinearDynamics.Random.RandomMatrix
#check NonlinearDynamics.Random.RandomMatrix.measurable_iff_entries
#check NonlinearDynamics.Random.RandomMatrix.measurable_entry
#check NonlinearDynamics.Random.RandomMatrix.measurable_mul
#check NonlinearDynamics.Random.RandomMatrix.hermitianSymmetrization
#check NonlinearDynamics.Random.RandomMatrix.hermitianSymmetrization_isHermitian
#check NonlinearDynamics.Random.RandomMatrix.hermitianSymmetrization_isHermitianAE
~~~

<code>#print</code> unfolds the project abbreviation. Each
<code>#check</code> asks the pinned elaborator for the exact type of a checked
declaration. The generated guarded command below validates the authoritative
module, not the temporary probe.
{{< /repo-check >}}

## In Lean: from one Hermitian matrix to a random spectral law

### Give one matrix a finite empirical measure

For an intrinsic \(n\)-by-\(n\) Hermitian matrix \(H\), let

\[
\lambda_0(H)\geq\lambda_1(H)\geq\cdots\geq\lambda_{n-1}(H)
\]

be its real eigenvalues with multiplicity. The spectral counting measure is

\[
\kappa_H=\sum_{i=0}^{n-1}\delta_{\lambda_i(H)}.
\]

Its total mass is \(n\). The empirical spectral measure is

\[
L_H=\frac1n\kappa_H
\]

when \(n\gt0\). Repeated eigenvalues contribute repeated atoms; replacing the
vector by a set of distinct roots would lose multiplicity and produce the
wrong trace moments.

Viewing each real integration variable as a complex number, the first two
counting-measure moments recover the ordinary complex matrix traces:

\[
\int x\,d\kappa_H(x)=\operatorname{Tr}(H),
\qquad
\int x^2\,d\kappa_H(x)=\operatorname{Tr}(H^2).
\]

The empirical moments divide these by \(n\) in positive dimension. In the
running example,

| Realization | First empirical moment | Second empirical moment |
|---|---:|---:|
| \(R\) with slots \(2,0\) | \((2+0)/2=1\) | \((2^2+0^2)/2=2\) |
| \(B\) with slots \(1,-1\) | \((1-1)/2=0\) | \((1^2+(-1)^2)/2=1\) |

At dimension zero, the finite sum has no atoms. The repository deliberately
defines both the counting measure and empirical measure to be the zero measure.
The empirical measure is therefore zero or probabilistic in all dimensions,
and a bundled probability-measure wrapper appears only in positive dimension.
No fake eigenvalue is inserted at zero.

{{< lean-bridge
  human="Give every ordered eigenvalue slot one Dirac atom, then scale the resulting counting measure by the inverse dimension."
  math="\(\kappa_H=\sum_i\delta_{\lambda_i(H)},\qquad L_H=n^{-1}\kappa_H.\)"
  lean="NonlinearDynamics.Random.RandomMatrix.spectralCountingMeasure H; NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMeasure H"
>}}

- <code>H</code> is an intrinsic <code>HermitianEuclidean n</code> value.
- <code>orderedHermitianEigenvalues H i</code> is the real eigenvalue in slot
  <code>i : Fin n</code>.
- <code>spectralCountingMeasure H</code> has type <code>Measure ℝ</code> and
  adds one Dirac mass per slot.
- <code>empiricalSpectralMeasure H</code> also has type
  <code>Measure ℝ</code>; it applies the project's zero-aware normalization.
- Neither expression is a probability law on matrices or on measures. Each is
  a deterministic measure attached to one matrix <code>H</code>.
{{< /lean-bridge >}}

### Push a matrix law to a law on spectral measures

The matrix-law layer makes measurability explicit:

~~~lean
noncomputable def law (X : RandomMatrix Ω ι ι ℂ) (_hX : Measurable X)
    (μ : Measure Ω) : Measure (Matrix ι ι ℂ) :=
  Measure.map X μ
~~~

The keyword <code>noncomputable</code> permits a classical mathematical
definition that Lean is not promising to execute as a program. It does not
weaken the proposition proved about the resulting measure.

The proof argument <code>_hX</code> is semantically important even though the
value of <code>Measure.map</code> does not store it. Mathlib's map operation is
total and has fallback behavior outside the
{{< refterm "almost-everywhere" "almost-everywhere" >}} measurable case. The
project name <code>law</code> therefore demands evidence that the standard
pushforward interpretation is licensed.

{{< lean-bridge
  human="Push the source measure through the measurable matrix-valued map. A measurable matrix set receives the mass of its preimage."
  math="\(\mathcal L_\mu(X)=X_*\mu,\qquad (X_*\mu)(D)=\mu(X^{-1}(D)).\)"
  lean="NonlinearDynamics.Random.RandomMatrix.law X hX μ; NonlinearDynamics.Random.RandomMatrix.law_apply X hX μ hD"
>}}

- <code>hX : Measurable X</code> is the gate that licenses the law.
- <code>μ : Measure Ω</code> is the source measure.
- <code>RandomMatrix.law X hX μ</code> has type
  <code>Measure (Matrix ι ι ℂ)</code>.
- <code>D</code> is a set of matrices and <code>hD : MeasurableSet D</code>
  proves that it is a legal target event.
- <code>law_apply</code> states the exact preimage evaluation rule.
{{< /lean-bridge >}}

At the later finite Gaussian unitary ensemble (GUE) layer, the repository has
proved that the empirical-spectral-measure observable is measurable and names
its pushforward law:

{{< lean-bridge
  human="Sample a finite Gaussian unitary ensemble matrix, turn it into one empirical spectral measure, and take the probability law of that measure-valued output."
  math="\(\mathcal Q_n=(L_n)_*\mathbb P_n.\)"
  lean="NonlinearDynamics.Random.GUE.empiricalSpectralLaw n = (NonlinearDynamics.Random.GUE.intrinsicLaw n).map NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMeasure"
>}}

- <code>GUE.intrinsicLaw n</code> is a probability law on intrinsic Hermitian
  matrices.
- <code>RandomMatrix.empiricalSpectralMeasure</code> maps one matrix to one
  <code>Measure ℝ</code>.
- <code>.map</code> pushes the matrix law through that measurable observable.
- The result has type <code>Measure (Measure ℝ)</code>. The outer measure is the
  random law; each point in its carrier is an inner spectral measure.
- This named project law is not the fair-coin law \(\mathcal Q\) computed
  above. The coin model is a finite teaching analogue of the same typed path.
{{< /lean-bridge >}}

### Run the finite model locally with Lean and Std

This first worksheet is deliberately tiny. It imports only Lean's
<code>Std</code> library, uses two fixed integer matrices, and performs bounded
list computations. It does not import Mathlib, open the repository's Lake
project, download a cache, or prove measure-theoretic measurability.

Create a scratch directory outside <code>formalization/</code>. Save the
following as <code>CoinMatrixTutorial.lean</code>:

~~~lean
import Std

inductive Outcome where
  | red
  | blue
deriving Repr, DecidableEq

structure Matrix2 where
  a00 : Int
  a01 : Int
  a10 : Int
  a11 : Int
deriving Repr, DecidableEq

abbrev Vec2 := Int × Int

def outcomeLabel : Outcome → String
  | .red => "red"
  | .blue => "blue"

def sampleMatrix : Outcome → Matrix2
  | .red => ⟨2, 0, 0, 0⟩
  | .blue => ⟨0, 1, 1, 0⟩

def entries (A : Matrix2) : Int × Int × Int × Int :=
  (A.a00, A.a01, A.a10, A.a11)

def mulVec (A : Matrix2) (v : Vec2) : Vec2 :=
  (A.a00 * v.1 + A.a01 * v.2,
   A.a10 * v.1 + A.a11 * v.2)

def scaleVec (lambda : Int) (v : Vec2) : Vec2 :=
  (lambda * v.1, lambda * v.2)

structure Eigenpair where
  value : Int
  vector : Vec2
deriving Repr, DecidableEq

def eigenpairs : Outcome → List Eigenpair
  | .red => [⟨2, (1, 0)⟩, ⟨0, (0, 1)⟩]
  | .blue => [⟨1, (1, 1)⟩, ⟨-1, (1, -1)⟩]

def eigenpairOK (A : Matrix2) (pair : Eigenpair) : Bool :=
  decide (mulVec A pair.vector = scaleVec pair.value pair.vector)

def spectrum (omega : Outcome) : List Int :=
  (eigenpairs omega).map (fun pair => pair.value)

def spectralCertificate (omega : Outcome) : Bool :=
  (eigenpairs omega).all (eigenpairOK (sampleMatrix omega))

def outcomes : List Outcome := [.red, .blue]

def largeFirstEntryPreimage : List String :=
  (outcomes.filter (fun omega => decide ((sampleMatrix omega).a00 > 1))).map
    outcomeLabel

def quarterMass (x : Int) : Nat :=
  outcomes.foldl (fun total omega => total + (spectrum omega).count x) 0

def meanMassLedger : List (Int × Nat) :=
  ([-1, 0, 1, 2] : List Int).map (fun x => (x, quarterMass x))

#eval outcomes.map (fun omega =>
  (outcomeLabel omega, entries (sampleMatrix omega)))
#eval outcomes.map (fun omega => (outcomeLabel omega, spectrum omega))
#eval outcomes.map (fun omega =>
  (outcomeLabel omega, spectralCertificate omega))
#eval largeFirstEntryPreimage
#eval meanMassLedger

example : spectralCertificate .red = true := by decide
example : spectralCertificate .blue = true := by decide
example : largeFirstEntryPreimage = ["red"] := by decide
example : meanMassLedger = [(-1, 1), (0, 1), (1, 1), (2, 1)] := by decide
~~~

Open a terminal in that scratch directory and type:

~~~sh
source "$HOME/.elan/env"
elan run leanprover/lean4:v4.32.0 lean CoinMatrixTutorial.lean
~~~

This exact worksheet was executed successfully with Lean 4.32.0. It printed:

~~~text
[("red", 2, 0, 0, 0), ("blue", 0, 1, 1, 0)]
[("red", [2, 0]), ("blue", [1, -1])]
[("red", true), ("blue", true)]
["red"]
[(-1, 1), (0, 1), (1, 1), (2, 1)]
~~~

Read the output in order:

1. the first line shows the two realized matrices in row-major entry order;
2. the second shows the two eigenvalue-slot lists;
3. the third verifies all four displayed eigenvector equations;
4. the fourth computes the preimage of the upper-left-entry event; and
5. the fifth records the averaged spectral mass in quarter-units, so each
   listed eigenvalue has mass \(1/4\).

The four <code>example</code> declarations ask Lean's kernel to check the same
finite claims. This worksheet verifies the arithmetic and type separation of
the toy model. It does **not** verify the general spectral theorem, matrix
measurability, pushforward law, or project declarations below.

### Try the exact spectral-law declarations in the repository

{{< repo-check module="NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleSpectrum" >}}
**Resource label: later project modules plus Mathlib, cloud-only for this
project.** Type this probe only on an approved Linux host that has the pinned
project cache:

~~~lean
import NonlinearDynamics.Random.RandomMatrices.GaussianUnitaryEnsembleSpectrum

#check NonlinearDynamics.Random.RandomMatrix.orderedHermitianEigenvalues
#check NonlinearDynamics.Random.RandomMatrix.spectralCountingMeasure
#check NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMeasure
#check NonlinearDynamics.Random.RandomMatrix.empiricalSpectralMeasure_zero
#check NonlinearDynamics.Random.RandomMatrix.measurable_empiricalSpectralMeasure
#check NonlinearDynamics.Random.GUE.empiricalSpectralLaw
#check NonlinearDynamics.Random.GUE.empiricalSpectralLaw_zero
#check NonlinearDynamics.Random.GUE.meanEmpiricalSpectralMeasure
~~~

These names span the deterministic sample spectrum, its zero-dimensional
boundary, measurability of the measure-valued observable, the outer finite GUE
law, and its mean measure. The guarded command below checks the full imported
leaf. Do not replace it with a local project or Lake command on this Mac.
{{< /repo-check >}}

## What the repository has checked, and what it has not

The page's primary module,
<code>NonlinearDynamics.Random.RandomMatrices.Basic</code>, proves only the
entrywise measurable foundation and its finite algebraic closure. Later
modules now add substantial finite theory:

| Layer | Checked repository contribution |
|---|---|
| Matrix carrier | outcome-to-matrix functions and the entrywise measurable structure |
| Hermitian structure | pointwise and almost-everywhere Hermiticity, bundled measurable Hermitian matrices, and congruence |
| Matrix law | measurable pushforwards, probability preservation, Dirac rules, and unitary-invariance interfaces |
| Finite GUE | exact Wigner-scaled coordinate law, ambient matrix law, zero-dimensional Dirac boundary, and unitary invariance |
| Finite observables | measurable trace powers and the first two exact integrable finite GUE trace moments |
| Finite spectrum | ordered real Hermitian eigenvalues, counting and empirical measures, perturbation continuity, and measurability |
| Spectral law | the finite GUE law on empirical spectral measures, its mean measure, and first two normalized expected sample moments |

Here GUE means **Gaussian unitary ensemble**. The project's convention is
Wigner scaled: diagonal variance \(1/n\), off-diagonal real and imaginary
variances \(1/(2n)\), ordinary matrix trace, and an order-one spectrum in
positive dimension. That normalization belongs to the GUE modules, not to the
bare <code>RandomMatrix</code> definition. Standard references explain why
normalization ledgers and symmetry classes matter
([Tao](#ref-tao-rmt); [Anderson, Guionnet, and Zeitouni](#ref-agz)).

For positive dimension, the complete convention ledger is:

| Convention field | This project's finite GUE choice |
|---|---|
| Dimension | \(n\times n\), with a separate explicit Dirac policy at \(n=0\) |
| Diagonal coordinates | independent centered real Gaussians of variance \(1/n\) |
| Strict-upper coordinates | independent complex coordinates whose real and imaginary parts are independent centered Gaussians, each of variance \(1/(2n)\) |
| Lower triangle | conjugate reflection of the strict upper triangle, not new independent data |
| Density exponent | the associated classical convention is proportional to \(\exp[-n\operatorname{Tr}(H^2)/2]\); the repository has not proved a density theorem |
| Spectral scale | the \(n^{-1/2}\) scale is already built into the entries, producing an order-one spectrum |
| Trace | <code>Matrix.trace</code> is ordinary; empirical moments introduce the factor \(n^{-1}\) separately |

The density row records the convention needed to compare literature formulas.
It is explanatory context, not a checked density identity.

The checked {{< refterm "unitary-invariance" "unitary invariance" >}} statement
is law-level symmetry: pushing the finite GUE matrix law through
\(H\mapsto UHU^*\) leaves that law unchanged for every unitary \(U\). It is not
pointwise equality \(UHU^*=H\).

The repository does **not** yet prove:

- a Hermitian-space or joint-eigenvalue density formula;
- the semicircle law or any large-dimension spectral limit;
- local spacing universality, edge statistics, or Tracy-Widom laws;
- a Gaussian orthogonal or symplectic ensemble;
- that an empirical spectral measure determines its matrix;
- that a random Jacobian belongs to GUE;
- a physical quantum-chaos conclusion from the finite GUE construction; or
- any result merely because the running two-outcome worksheet computed it.

The first four absences are later random-matrix work. The remaining four are
claim boundaries: spectra discard information, modeling assumptions must be
stated, and a pedagogical computation is not a project theorem.

## Why physicists care, without skipping the assumptions

Hermitian random matrices became central in mathematical physics because
Hermitian operators model finite quantum observables and have real energy
levels. Wigner used random-matrix ideas to study the statistics of complex
nuclear spectra, and Dyson organized the orthogonal, unitary, and symplectic
symmetry classes
([Wigner, 1955](#ref-wigner-1955);
[Dyson, 1962](#ref-dyson-1962);
[Dyson, Threefold Way](#ref-dyson-threefold)).

That history motivates an ensemble. It does not prove that a particular
Hamiltonian has independent Gaussian coordinates or that one finite sample
already exhibits a universal limit. The project therefore formalizes the
finite probability object and its normalization before asking asymptotic or
physical questions.

## Two bridges back to nonlinear dynamics

### Random Jacobians

The derivative of a random or uncertain dynamical system can be a random
matrix. Its action on perturbation vectors and its singular values can encode
one-step growth. Eigenvalues of one fixed linearization answer a narrower
question and can miss transient growth for a **nonnormal** matrix, one that
does not commute with its conjugate transpose. The nilpotent boundary above
already shows that eigenvalues can miss operator action.

The measurable-matrix layer can carry such Jacobians without assuming they
are Gaussian, Hermitian, independent, or identically distributed.

### Matrix cocycles

Linearization along an orbit produces ordered products

\[
A_{t-1}\cdots A_1A_0.
\]

A base transformation and generator can organize these matrices into a
{{< refterm "one-sided-discrete-matrix-cocycle" "one-sided random matrix cocycle" >}}.
Long-time norm growth then leads toward Lyapunov exponents, asymptotic
exponential growth rates, under additional
{{< refterm "integrability" "integrability" >}} and
{{< refterm "ergodicity" "ergodicity" >}} hypotheses. The finite measurable
multiplication theorem is one early ingredient, not a Lyapunov theorem by
itself.

## Exercises: use the same example until every layer is yours

1. **Preimage.** Compute the source event where the lower-left entry equals
   one. What probability does it have?
2. **Realization.** Multiply both \(R\) and \(B\) by \((1,2)\). Which output
   belongs to each outcome?
3. **Eigenpairs.** Verify the four eigenvector equations without using the
   characteristic polynomial.
4. **Characteristic roots.** Expand both determinants
   \(\det(\lambda I-R)\) and \(\det(\lambda I-B)\).
5. **Sample moments.** Recompute the first two empirical moments in the table.
6. **Outer event.** Let \(C\) be the set of empirical measures assigning
   positive mass to \(\{2\}\). Compute \(\mathcal Q(C)\).
7. **Law versus mean.** Construct a different law on measures whose mean is
   \(\overline L\). Explain what sample-to-sample information changes.
8. **Boundary.** Verify \(N^2=0\), \(N\ne0\), and \(N\ne N^*\).
9. **Symmetrization.** Compute \((N+N^*)/2\). How do its eigenvalues compare
   with the unnormalized blue matrix \(B\)?
10. **Lean tokens.** In the local worksheet, change the red diagonal entry
    from \(2\) to \(3\). Update its eigenpair certificate, spectrum, event
    preimage, and mass ledger together.
11. **Resource boundary.** Explain why the <code>Std</code> worksheet is safe
    locally while the two <code>repo-check</code> modules belong on the guarded
    Linux builder.
12. **Research boundary.** Name one additional theorem needed before a finite
    spectral law can support a large-dimension universality claim.

## Where to continue

- Start with {{< refterm "random-matrix" "Random matrix" >}} for a compact
  account of the carrier, realization, measurability, and law distinction.
- Continue to
  [Finite Hermitian Matrices from Coordinates]({{< relref "/knowledge-base/deep-dives/finite-hermitian-matrices-from-coordinates" >}})
  for direct assembly from nonredundant coordinates.
- Use
  [Finite Hermitian Spectra and Empirical Measures]({{< relref "/knowledge-base/deep-dives/finite-hermitian-spectra-and-empirical-measures" >}})
  for the ordered spectrum, multiplicity, zero-dimensional policy, and
  deterministic measure layer.
- Then read
  [Hermitian Spectral Perturbation, Continuity, and Measurability]({{< relref "/knowledge-base/deep-dives/hermitian-spectral-perturbation-continuity-and-measurability" >}})
  for the theorem that opens the spectral pushforward gate.
- Finish the finite path with
  [Finite Gaussian Unitary Ensemble Empirical Spectral Laws and Normalized Moments]({{< relref "/knowledge-base/deep-dives/finite-gue-empirical-spectral-laws-and-normalized-moments" >}}).

## References

<a id="ref-mathlib-measurable"></a>
**Mathlib contributors.**
[Measurable spaces and measurable functions](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/MeasurableSpace/Basic.html),
Mathlib 4 documentation. Accessed 2026-07-20. This is the
implementation-level source for Lean's measurable-space and
measurable-function interfaces.

<a id="ref-mathlib-release"></a>
**Mathlib contributors.**
[Mathlib 4.32.0 release](https://github.com/leanprover-community/mathlib4/releases/tag/v4.32.0),
commit `81a5d257c8e410db227a6665ed08f64fea08e997`. This is the exact dependency
release against which the Lean declarations in this chapter were checked.

<a id="ref-mathlib-hermitian"></a>
**Mathlib contributors.**
[Hermitian matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/LinearAlgebra/Matrix/Hermitian.html),
Mathlib 4 documentation. Accessed 2026-07-20. This documents
<code>Matrix.IsHermitian</code> and the algebraic closure lemmas used by the
project.

<a id="ref-mathlib-spectrum"></a>
**Mathlib contributors.**
[Spectral theory of matrices](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Matrix/Spectrum.html),
Mathlib 4 documentation. Accessed 2026-07-20. This documents the finite
Hermitian spectral infrastructure consumed by the later project modules.

<a id="ref-tao-rmt"></a>
**Terence Tao.**
[Topics in Random Matrix Theory](https://doi.org/10.1090/gsm/132),
Graduate Studies in Mathematics 132, American Mathematical Society, 2012.
The [author's book page](https://teorth.github.io/tao-web/topics-in-random-matrix-theory.html)
links an online draft, lecture notes, and errata.

<a id="ref-kallenberg"></a>
**Olav Kallenberg.**
[Foundations of Modern Probability](https://doi.org/10.1007/978-3-030-61871-1),
third edition, Probability Theory and Stochastic Modelling 99, Springer, 2021.
This is a standard source for measurable random elements, laws, product
spaces, independence, and almost-everywhere reasoning.

<a id="ref-agz"></a>
**Greg W. Anderson, Alice Guionnet, and Ofer Zeitouni.**
[An Introduction to Random Matrices](https://doi.org/10.1017/CBO9780511801334),
Cambridge Studies in Advanced Mathematics 118, Cambridge University Press,
2010. This is a standard systematic source for real and complex Wigner
matrices, Gaussian ensembles, and asymptotic spectral theory.

<a id="ref-wigner-1955"></a>
**Eugene P. Wigner.**
[Characteristic Vectors of Bordered Matrices With Infinite Dimensions](https://doi.org/10.2307/1970079),
*Annals of Mathematics* 62(3), 548-564, 1955. This is cited for historical
context on random-matrix models of complex spectra, not as a source for the
Lean implementation.

<a id="ref-dyson-1962"></a>
**Freeman J. Dyson.**
[Statistical Theory of the Energy Levels of Complex Systems. I](https://doi.org/10.1063/1.1703773),
*Journal of Mathematical Physics* 3, 140-156, 1962. This is cited for the
symmetry-class framing that connects orthogonal, unitary, and symplectic
ensembles to physical invariances.

<a id="ref-dyson-threefold"></a>
**Freeman J. Dyson.**
[The Threefold Way: Algebraic Structure of Symmetry Groups and Ensembles in Quantum Mechanics](https://doi.org/10.1063/1.1703863),
*Journal of Mathematical Physics* 3(6), 1199-1215, 1962. This is the original
three-class symmetry analysis, not the broader later tenfold classification.
