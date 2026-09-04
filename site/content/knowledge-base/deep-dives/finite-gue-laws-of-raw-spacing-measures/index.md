---
title: "Finite GUE Laws of Raw Spacing Measures"
slug: "finite-gue-laws-of-raw-spacing-measures"
date: 2026-08-23
summary: "Follow one finite ensemble from ordered spectra to raw gap measures, then distinguish the all-dimensional outer law from the inner probability wrapper available only at dimension two and above."
lead: "A law of spacing measures has two layers of probability mass. The outer layer survives even when the inner spacing measure is zero."
draft: true
pro_reviewed: false
level: "Introductory probability and finite spectra"
reading_time: "30 to 40 minutes"
prerequisites: "Probability laws, pushforward measures, and raw level spacings are defined as they enter the worked example"
lean_module: "NonlinearDynamics.QuantumChaos.GUE"
lean_snapshot: "/lean/NonlinearDynamics/QuantumChaos/GUE.lean"
lean_source_sha256: "d55058cd72aa6c59ff331293a3a8396f6d2bdf04befce978ca7de3b2d30fc454"
toc: true
og_image: "finite-gue-laws-of-raw-spacing-measures-card.png"
og_image_alt: "Two equally likely three-level spectra yield two empirical raw-spacing measures; an outer law assigns probability one half to each whole measure, while dimensions zero and one concentrate at the zero measure."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial and validation status.** This is an AI-assisted source
candidate. Professional review and pinned-toolchain validation of the exact
source hash remain pending, so `pro_reviewed` remains false.
{{< /panel >}}

## Start with two spectra and compute every gap

Let the finite sample space be

\[
\Omega=\{A,B\},
\qquad
\mathbb P(\{A\})=\mathbb P(\{B\})=\tfrac12.
\]

Every subset of this two-point space is measurable. Assign each outcome an
already decreasing three-level spectrum:

\[
\lambda(A)=(2,2,-1),
\qquad
\lambda(B)=(3,1,1).
\]

A {{< refterm "raw-level-spacing" "raw level spacing" >}} subtracts the next
decreasing level from the current level. Therefore

\[
\begin{aligned}
\Delta(A)&=(2-2,\;2-(-1))=(0,3),\\
\Delta(B)&=(3-1,\;1-1)=(2,0).
\end{aligned}
\]

Each repeated level produces a zero gap. Neither zero is filtered out. Both
spectra have two adjacent slots, so every slot receives empirical weight
`1/2`:

\[
\mu_A=\tfrac12\delta_0+\tfrac12\delta_3,
\qquad
\mu_B=\tfrac12\delta_2+\tfrac12\delta_0.
\]

The symbol `δₓ` denotes the Dirac measure at the real number `x`. It assigns
unit mass to any measurable set containing `x` and zero mass otherwise.

{{< reference-figure
  wide="true"
  src="two-spectrum-spacing-law-ledger.svg"
  alt="Outcome A has decreasing levels two two minus one, raw gaps zero and three, and empirical measure one half at zero plus one half at three. Outcome B has levels three one one, gaps two and zero, and empirical measure one half at two plus one half at zero. The outer law gives the two whole measures equal probability."
  caption="**Complete toy ledger:** the first probability layer inside each row weights adjacent gap slots. The second probability layer between rows weights the two sample outcomes. Repeated levels remain as zero-gap atoms. This finite model explains the construction but is not a Gaussian unitary ensemble sample."
>}}

The displayed calculation checks this two-outcome example. It does not
establish the formal all-matrix statements. Those statements use the checked
ordered-eigenvalue, measurability, and finite GUE APIs.

## The outer law has measures as outcomes

Define the measure-valued map

\[
L^{\mathrm{raw}}:\Omega\to\operatorname{Measure}(\mathbb R),
\qquad
L^{\mathrm{raw}}(A)=\mu_A,
\quad
L^{\mathrm{raw}}(B)=\mu_B.
\]

Its {{< refterm "probability-law" "probability distribution, or law" >}} is
the {{< refterm "pushforward-measure" "pushforward" >}} of `P`:

\[
\mathcal Q_{\mathrm{toy}}
  =(L^{\mathrm{raw}})_*\mathbb P
  =\tfrac12\delta_{\mu_A}+\tfrac12\delta_{\mu_B}.
\]

This notation contains two different uses of Dirac mass:

- `δ₀`, `δ₂`, and `δ₃` inside `μᴬ` and `μᴮ` are measures on the real
  line; and
- `δ_{μᴬ}` and `δ_{μᴮ}` are measures on a space whose points are themselves
  measures on the real line.

The nested type is

\[
\mathcal Q_{\mathrm{toy}}
  :\operatorname{Measure}(\operatorname{Measure}(\mathbb R)).
\]

For a measurable collection `C` of real-line measures, the pushforward rule is

\[
\mathcal Q_{\mathrm{toy}}(C)
  =\mathbb P\bigl(\{\omega\in\Omega:
      L^{\mathrm{raw}}(\omega)\in C\}\bigr).
\]

The outer law preserves sample-to-sample variation. Averaging the inner
measures gives the different object

\[
\bar\mu
  =\tfrac12\mu_A+\tfrac12\mu_B
  =\tfrac12\delta_0+\tfrac14\delta_2+\tfrac14\delta_3.
\]

Two distinct laws on measures can share one averaged inner measure, so the
average cannot in general recover the outer law. The formal candidate stops
before defining this average.

## Replace the toy input by finite GUE

Fix a dimension `n`. Let `H_n` be the project's intrinsic Euclidean space of
`n` by `n` Hermitian matrices. The existing finite
{{< refterm "gaussian-unitary-ensemble" "Gaussian unitary ensemble" >}}
law is

\[
\gamma_n:\operatorname{Measure}(\mathcal H_n).
\]

It has total mass one. The earlier deterministic module supplies the
{{< refterm "measurable-function" "measurable function" >}}

\[
L_n^{\mathrm{raw}}:\mathcal H_n
  \to\operatorname{Measure}(\mathbb R).
\]

The candidate defines

\[
\mathcal Q_n^{\mathrm{raw}}
  =(L_n^{\mathrm{raw}})_*\gamma_n.
\]

Because `L_n^raw` is measurable, this is a valid probability pushforward. The
construction does not require a formula for the joint eigenvalue density and
does not use an unfolding map.

{{< reference-figure
  wide="true"
  src="pushforward-type-ladder.svg"
  alt="A type ladder starts with the intrinsic finite Gaussian unitary ensemble probability law on Hermitian matrices, maps each matrix to one empirical raw-spacing measure, and ends with an outer probability law on measures. A separate arrow in dimensions two and above packages each inner measure as a probability measure, while dimensions zero and one land at the zero measure."
  caption="**Pushforward and wrapper are different steps:** measurability permits the outer law in every dimension. A positive number of adjacent slots permits the inner probability wrapper only from dimension 2 onward. Neither step unfolds the gaps or computes an ensemble average."
>}}

## Why dimensions zero and one still have an outer probability law

The deterministic boundary is

\[
L_0^{\mathrm{raw}}(H)=0,
\qquad
L_1^{\mathrm{raw}}(H)=0.
\]

Here `0` is the zero measure on `ℝ`. It has total mass zero because neither
dimension has an adjacent pair. Mapping either input law through this constant
observable gives

\[
\mathcal Q_0^{\mathrm{raw}}
  =\mathcal Q_1^{\mathrm{raw}}
  =\delta_{0_{\operatorname{Measure}(\mathbb R)}}.
\]

The outer Dirac measure has total mass one. Its single atom is the inner zero
measure. There is no contradiction: inner mass and outer mass answer different
questions.

| Dimension | Number of gap slots | Inner outcome type used by total API | Outer law |
|---:|---:|---|---|
| 0 | 0 | zero `Measure ℝ` | Dirac at the zero measure |
| 1 | 0 | zero `Measure ℝ` | Dirac at the zero measure |
| 2 | 1 | `ProbabilityMeasure ℝ` after wrapping | probability law on probability measures |
| `n + 2` | `n + 1` | `ProbabilityMeasure ℝ` after wrapping | probability law on probability measures |

The candidate does not replace the inner zero measure by `δ₀` on the real
line. Such a replacement would invent a gap at location zero.

## The wrapper square

For dimension `n + 2`, write

\[
\widetilde L_n^{\mathrm{raw}}(H)
  \in\operatorname{ProbabilityMeasure}(\mathbb R)
\]

for the empirical raw-spacing measure together with its checked mass-one
certificate. Pushing finite GUE through that map gives

\[
\widetilde{\mathcal Q}_n^{\mathrm{raw}}
  :\operatorname{ProbabilityMeasure}
     (\operatorname{ProbabilityMeasure}(\mathbb R)).
\]

Let `ι` forget the inner certificate. The formal coherence theorem states

\[
\iota_*\widetilde{\mathcal Q}_n^{\mathrm{raw}}
  =\mathcal Q_{n+2}^{\mathrm{raw}}.
\]

This equality says the wrapper changes only the exposed type. It does not
change atom locations, atom weights, total mass, or gap scale.

## A standalone Lean worksheet

The bundled worksheet uses only Lean core and `Std`. It computes adjacent
integer differences for the two toy spectra and checks the empty-list,
one-level, and two-level boundaries. It does not construct Hermitian matrices,
GUE laws, Mathlib measures, or noncomputable eigenvalues.

```sh
lean two-spectrum-raw-spacing-law.lean
```

This is a **standalone tutorial** on macOS or Linux. Its exact output under
Lean 4.32.0 is:

```text
[[0, 3], [2, 0]]
0
0
1
```

The first line checks both worked gap vectors. The next three lines show that
zero levels and one level have no gap, while two levels have one gap. The
finite `example` declarations exhaustively decide those exact list equalities;
they do not establish a theorem about real eigenvalues or probability laws.

## In Lean: map the ensemble through the statistic

{{< lean-bridge
  human="Push the intrinsic finite GUE probability law through the empirical raw-spacing map."
  math="\(\mathcal Q_n^{\mathrm{raw}}=(L_n^{\mathrm{raw}})_*\gamma_n.\)"
  lean="noncomputable def empiricalRawSpacingLaw (n : ℕ) :\n    Measure (Measure ℝ) :=\n  (Random.GUE.intrinsicLaw n).map empiricalRawSpacingMeasure"
>}}
- `Random.GUE.intrinsicLaw n` is the outer input probability measure.
- `empiricalRawSpacingMeasure` maps one Hamiltonian to one inner measure.
- `.map` transports the input mass through that measurable map.
- `Measure (Measure ℝ)` makes the two levels visible in the result type.
{{< /lean-bridge >}}

{{< lean-bridge
  human="The zero- and one-dimensional outer laws both assign unit mass to the inner zero measure."
  math="\(\mathcal Q_0^{\mathrm{raw}}=\mathcal Q_1^{\mathrm{raw}}=\delta_{0_{\operatorname{Measure}(\mathbb R)}}.\)"
  lean="@[simp] theorem empiricalRawSpacingLaw_zero :\n    empiricalRawSpacingLaw 0 = Measure.dirac (0 : Measure ℝ)\n\n@[simp] theorem empiricalRawSpacingLaw_one :\n    empiricalRawSpacingLaw 1 = Measure.dirac (0 : Measure ℝ)"
>}}
The type annotation tells Lean that `0` is a measure. The outer `dirac` then
uses that measure as its atom.
{{< /lean-bridge >}}

{{< lean-bridge
  human="For at least two levels, forgetting the inner probability certificate returns the all-dimensional raw law."
  math="\(\iota_*\widetilde{\mathcal Q}_n^{\mathrm{raw}}=\mathcal Q_{n+2}^{\mathrm{raw}}.\)"
  lean="theorem map_empiricalRawSpacingProbabilityLaw_coe (n : ℕ) :\n    ((empiricalRawSpacingProbabilityLaw n :\n      ProbabilityMeasure (ProbabilityMeasure ℝ)) :\n      Measure (ProbabilityMeasure ℝ)).map\n        (fun μ : ProbabilityMeasure ℝ => (μ : Measure ℝ)) =\n      empiricalRawSpacingLaw (n + 2)"
>}}
The two coercions expose the underlying outer and inner measures. The final
equality is proved with Mathlib's composition rule for measurable pushforwards.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.QuantumChaos.GUE

open MeasureTheory
open NonlinearDynamics.QuantumChaos.GUE

#check empiricalRawSpacingLaw
#check instIsProbabilityMeasureEmpiricalRawSpacingLaw
#check empiricalRawSpacingLawProbability
#check empiricalRawSpacingLaw_zero
#check empiricalRawSpacingLaw_one
#check empiricalRawSpacingProbabilityLaw
#check map_empiricalRawSpacingProbabilityLaw_coe
~~~

This is a **full project check** on macOS or Linux. It requires the
repository's pinned Lean and Mathlib dependencies and may require substantial
disk space or build time.

{{< repo-check >}}
Lean's elaborator constructs candidate proof terms and its kernel checks those
terms against the exact nested-measure statements. The kernel check does not
certify a physical GUE model, unfolding convention, or asymptotic
interpretation.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/QuantumChaos/GUE.lean
```

## What this chapter does not establish

- The two-outcome worksheet is not a finite GUE sampler.
- The outer law is not the average of its inner measure-valued outcomes.
- Outer probability mass one does not make an inner zero measure a probability
  measure.
- A raw-spacing law is not an unfolded or unit-mean spacing law.
- Measurability does not supply ensemble moments or integrability.
- No spacing density, level-repulsion exponent, universal limit, or
  quantum-chaos criterion is formalized.

## References

- Kristina Schubert and Martin Venker, “Empirical Spacings of Unfolded
  Eigenvalues,” *Electronic Journal of Probability* 20 (2015), paper 120,
  [DOI 10.1214/EJP.v20-4436](https://doi.org/10.1214/EJP.v20-4436),
  [arXiv 1505.07664v2](https://arxiv.org/abs/1505.07664), 23 August 2015.
  Equation (1.1) gives the adjacent-spacing empirical-measure comparison;
  this chapter does not import its unfolding or limit theorem.
- T. Kriecherbauer and K. Schubert, “Spacings: An Example for Universality in
  Random Matrix Theory,” in *Random Matrices and Iterated Random Functions*,
  Springer Proceedings in Mathematics & Statistics 53 (2013), 45–71,
  [DOI 10.1007/978-3-642-38806-4_3](https://doi.org/10.1007/978-3-642-38806-4_3),
  [arXiv 1510.06597v2](https://arxiv.org/abs/1510.06597).
- Thomas Guhr, Axel Müller-Groeling, and Hans A. Weidenmüller,
  “Random-matrix theories in quantum physics: common concepts,” *Physics
  Reports* 299 (1998), 189–425,
  [DOI 10.1016/S0370-1573(97)00088-4](https://doi.org/10.1016/S0370-1573%2897%2900088-4),
  [arXiv cond-mat/9707301](https://arxiv.org/abs/cond-mat/9707301).
- Mathlib contributors,
  [`MeasureTheory.Measure.GiryMonad`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/GiryMonad.lean)
  and
  [`MeasureTheory.Measure.ProbabilityMeasure`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/ProbabilityMeasure.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.

See the [Research Note]({{< relref
"/development-notebook/2026/08/finite-gue-raw-spacing-laws-in-lean" >}}) for
the design ledger, or the
[empirical raw-spacing law glossary chapter]({{< relref
"/knowledge-base/glossary/empirical-raw-spacing-law" >}}) for a shorter
orientation.
