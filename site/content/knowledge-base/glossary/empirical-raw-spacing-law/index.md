---
title: "Empirical raw-spacing law"
slug: "empirical-raw-spacing-law"
summary: "The probability distribution of the whole empirical raw-spacing measure produced by a random finite Hamiltonian, not one sample measure and not its average."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.QuantumChaos.GUE"
lean_snapshot: "/lean/NonlinearDynamics/QuantumChaos/GUE.lean"
lean_source_sha256: "d55058cd72aa6c59ff331293a3a8396f6d2bdf04befce978ca7de3b2d30fc454"
tags:
  - "Quantum chaos"
  - "Gaussian unitary ensemble"
  - "Spectral statistics"
  - "Probability laws"
og_image: "empirical-raw-spacing-law-card.png"
og_image_alt: "A probability law on Hamiltonians maps to a probability law whose outcomes are whole empirical raw-spacing measures; dimensions zero and one land at the zero measure."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this chapter. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed glossary chapter. Verify claims against the cited primary
sources and any released artifacts before relying on them.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial and validation status.** This is a private AI-assisted source
candidate. Professional review and pinned-toolchain validation of the paired
Lean source remain pending, so `pro_reviewed` remains false.
{{< /panel >}}

An **empirical raw-spacing law** is the
{{< refterm "probability-law" "probability distribution, or law" >}} of the
whole empirical {{< refterm "raw-level-spacing" "raw-spacing" >}} measure
produced by a random finite Hamiltonian.

The objects come in this order:

1. sample one Hamiltonian `H`;
2. compute its one empirical raw-spacing measure `L_H^raw`; and
3. take the law of the measure-valued map `H ↦ L_H^raw`.

The result is a probability measure whose points are themselves measures on
the real line.

## A two-outcome example

Suppose two decreasing spectra each receive probability `1/2`:

\[
\lambda(A)=(2,2,-1),
\qquad
\lambda(B)=(3,1,1).
\]

Their adjacent gaps are `(0,3)` and `(2,0)`, so their sample measures are

\[
\mu_A=\tfrac12\delta_0+\tfrac12\delta_3,
\qquad
\mu_B=\tfrac12\delta_2+\tfrac12\delta_0.
\]

The outer law is

\[
\mathcal Q
  =\tfrac12\delta_{\mu_A}+\tfrac12\delta_{\mu_B}.
\]

Its atoms are the whole measures `μᴬ` and `μᴮ`. They are not the gap
locations `0`, `2`, and `3`.

{{< reference-figure
  wide="true"
  src="raw-spacing-law-map.svg"
  alt="A probability law on two spectra maps each spectrum to a separate empirical raw-spacing measure, then assigns outer probability one half to each whole measure. A side boundary shows dimensions zero and one mapping to the inner zero measure while the outer law remains a Dirac probability measure."
  caption="**Law of a sample measure:** the inner weights count gap slots within one spectrum; the outer weights describe variation across spectra. The boundary case keeps outer mass one at the inner zero measure when no gap slot exists. The displayed two-outcome law is a toy model, not a Gaussian unitary ensemble calculation."
>}}

## The general definition

Let `γₙ` be a probability measure on the intrinsic space of `n` by `n`
Hermitian matrices. Let

\[
L_n^{\mathrm{raw}}:H\mapsto
  \text{the empirical raw-spacing measure of }H
\]

be measurable. The empirical raw-spacing law is the
{{< refterm "pushforward-measure" "pushforward measure" >}}

\[
\mathcal Q_n^{\mathrm{raw}}
  =(L_n^{\mathrm{raw}})_*\gamma_n.
\]

In the formal module, `γₙ` is the existing finite
{{< refterm "gaussian-unitary-ensemble" "Gaussian unitary ensemble (GUE)" >}}
law. The definition does not require a formula for the spacing density.

## Two different mass questions

The outer law has total mass one in every dimension. The inner empirical
spacing measure has total mass zero in dimensions zero and one, then total
mass one from dimension two onward.

Therefore

\[
\mathcal Q_0^{\mathrm{raw}}
  =\mathcal Q_1^{\mathrm{raw}}
  =\delta_{0_{\operatorname{Measure}(\mathbb R)}}.
\]

The atom here is the zero measure, not the real number zero. The project does
not replace an empty gap list by a Dirac atom at real zero.

From dimension two onward, each inner outcome may be bundled as a
{{< refterm "probability-measure" "probability measure" >}}. Forgetting that
mass-one certificate returns the same underlying raw law.

## In Lean

{{< lean-bridge
  human="The finite GUE raw-spacing law pushes the matrix probability law through the measurable sample-spacing-measure map."
  math="\(\mathcal Q_n^{\mathrm{raw}}=(L_n^{\mathrm{raw}})_*\gamma_n.\)"
  lean="noncomputable def empiricalRawSpacingLaw (n : ℕ) :\n    Measure (Measure ℝ) :=\n  (Random.GUE.intrinsicLaw n).map empiricalRawSpacingMeasure"
>}}
`Random.GUE.intrinsicLaw n` is the input probability measure. The inner
`Measure ℝ` is one sample statistic; the outer `Measure` is its law. `.map`
is Mathlib's pushforward operation.
{{< /lean-bridge >}}

{{< lean-bridge
  human="In dimensions zero and one, the outer law is concentrated at the inner zero measure."
  math="\(\mathcal Q_0^{\mathrm{raw}}=\mathcal Q_1^{\mathrm{raw}}=\delta_{0_{\operatorname{Measure}(\mathbb R)}}.\)"
  lean="@[simp] theorem empiricalRawSpacingLaw_zero :\n    empiricalRawSpacingLaw 0 = Measure.dirac (0 : Measure ℝ)\n\n@[simp] theorem empiricalRawSpacingLaw_one :\n    empiricalRawSpacingLaw 1 = Measure.dirac (0 : Measure ℝ)"
>}}
The annotation `(0 : Measure ℝ)` fixes the atom's type. The surrounding
`Measure.dirac` supplies outer mass one.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.QuantumChaos.GUE

open MeasureTheory
open NonlinearDynamics.QuantumChaos.GUE

#check empiricalRawSpacingLaw
#check empiricalRawSpacingLawProbability
#check empiricalRawSpacingLaw_zero
#check empiricalRawSpacingLaw_one
#check empiricalRawSpacingProbabilityLaw
#check map_empiricalRawSpacingProbabilityLaw_coe
~~~

This is a **full project check** on macOS or Linux. It uses the pinned Lean and
Mathlib dependencies and may require substantial disk space or build time.

{{< repo-check >}}
Lean's elaborator constructs candidate proof terms and its kernel checks them
against the formal pushforward and boundary statements. That does not
establish a GUE spacing density, a universal limit, or quantum chaos.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/QuantumChaos/GUE.lean
```

Continue with the [Deep Dive]({{< relref
"/knowledge-base/deep-dives/finite-gue-laws-of-raw-spacing-measures" >}}) for
the executable two-spectrum ledger and wrapper square.

## Nonclaims

- A law on measures is not one sample measure and not their average.
- The toy two-outcome ensemble is not GUE.
- Outer mass one does not imply inner mass one in dimensions zero and one.
- A raw-spacing law is not unfolded or normalized to mean one.
- No density, moment, repulsion, universality, asymptotic, or chaos theorem
  follows from the pushforward definition.

## References

- Kristina Schubert and Martin Venker, “Empirical Spacings of Unfolded
  Eigenvalues,” *Electronic Journal of Probability* 20 (2015), paper 120,
  [DOI 10.1214/EJP.v20-4436](https://doi.org/10.1214/EJP.v20-4436),
  [arXiv 1505.07664v2](https://arxiv.org/abs/1505.07664), 23 August 2015.
- T. Kriecherbauer and K. Schubert, “Spacings: An Example for Universality in
  Random Matrix Theory,” in *Random Matrices and Iterated Random Functions*,
  Springer Proceedings in Mathematics & Statistics 53 (2013), 45–71,
  [DOI 10.1007/978-3-642-38806-4_3](https://doi.org/10.1007/978-3-642-38806-4_3).
- Mathlib contributors,
  [`MeasureTheory.Measure.ProbabilityMeasure`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/ProbabilityMeasure.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.
