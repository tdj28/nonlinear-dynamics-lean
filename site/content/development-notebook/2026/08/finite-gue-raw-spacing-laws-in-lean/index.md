---
title: "Finite GUE Raw-Spacing Laws in Lean"
slug: "finite-gue-raw-spacing-laws-in-lean"
date: 2026-08-23
summary: "A bounded bridge from the existing finite Gaussian unitary ensemble to the probability law of zero-aware empirical raw-spacing measures."
lead: "One Hamiltonian produces one spacing measure. A random Hamiltonian produces a probability law whose outcomes are whole spacing measures."
draft: true
pro_reviewed: false
tags:
  - "Lean"
  - "Quantum chaos"
  - "Gaussian unitary ensemble"
  - "Spectral statistics"
  - "Pushforward measures"
lean_module: "NonlinearDynamics.QuantumChaos.GUE"
lean_source: "formalization/NonlinearDynamics/QuantumChaos/GUE.lean"
lean_snapshot: "/lean/NonlinearDynamics/QuantumChaos/GUE.lean"
lean_source_sha256: "d55058cd72aa6c59ff331293a3a8396f6d2bdf04befce978ca7de3b2d30fc454"
toc: true
og_image: "finite-gue-raw-spacing-laws-in-lean-card.png"
og_image_alt: "A finite Gaussian unitary ensemble law passes through the raw-spacing observable to a probability law whose outcomes are whole measures, with zero-measure outcomes in dimensions zero and one."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed Research Note. Verify claims against the cited primary
sources and any released artifacts before relying on them.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This is a private AI-assisted source candidate.
Professional review and pinned-toolchain validation of the exact source hash
remain pending, so `pro_reviewed` remains false.
{{< /panel >}}

## Abstract

`NonlinearDynamics.QuantumChaos.GUE` connects two already separated layers.
The random-matrix layer supplies the intrinsic finite
{{< refterm "gaussian-unitary-ensemble" "Gaussian unitary ensemble (GUE)" >}}
probability law γₙ on Hermitian matrices. The deterministic spectral-statistics
layer supplies the measurable map

\[
L_n^{\mathrm{raw}}:H\longmapsto
\text{the zero-aware empirical measure of adjacent raw gaps of }H.
\]

The new outer law is the
{{< refterm "pushforward-measure" "pushforward measure" >}}

\[
\mathcal Q_n^{\mathrm{raw}}
  =(L_n^{\mathrm{raw}})_*\gamma_n.
\]

It is a probability measure in every dimension because its input is a
probability measure and its observable is measurable. Its outcomes, however,
are whole measures on the real line. In dimensions zero and one, every inner
outcome is the zero measure, so the outer law is the Dirac probability measure
concentrated at that zero-measure point. From dimension two onward, the inner
measure has mass one and can be carried by `ProbabilityMeasure ℝ`.

The module defines no unfolding, density, first moment, mean measure,
level-repulsion statement, universal limit, or quantum-chaos criterion.

## Begin with two possible spectra

Use a finite two-outcome model only to see the nested types. Let outcomes
`A` and `B` each have probability `1/2`, and assign the decreasing spectra

\[
\lambda(A)=(2,2,-1),
\qquad
\lambda(B)=(3,1,1).
\]

The adjacent raw gaps are

\[
\Delta(A)=(0,3),
\qquad
\Delta(B)=(2,0).
\]

Both repeated levels remain visible as zero gaps. Each three-level spectrum
has two adjacent slots, so its empirical raw-spacing measure is

\[
\mu_A=\tfrac12\delta_0+\tfrac12\delta_3,
\qquad
\mu_B=\tfrac12\delta_2+\tfrac12\delta_0.
\]

Here `δₓ` is the Dirac measure that places one unit of mass at the real
number `x`. The probability law of the measure-valued output is

\[
\mathcal Q_{\mathrm{toy}}
  =\tfrac12\delta_{\mu_A}+\tfrac12\delta_{\mu_B}.
\]

The atoms of this outer law are `μᴬ` and `μᴮ`, not the real numbers `0`, `2`,
or `3`. One sample from the outer law returns one entire measure.

{{< reference-figure
  wide="true"
  src="two-outcome-raw-spacing-law.svg"
  alt="Two equally likely decreasing spectra, two two minus one and three one one, become raw gap vectors zero three and two zero. Each gap vector becomes a two-atom empirical measure, and the outer law assigns probability one half to each whole measure."
  caption="**Nested finite example:** each spectrum first becomes its own empirical raw-spacing measure. Only then does the outer probability law place mass (1/2) on each measure-valued outcome. The example checks the bookkeeping and type distinction; it is not sampled from the Gaussian unitary ensemble and does not exhibit a GUE density or asymptotic spacing law."
>}}

The averaged inner measure would instead be

\[
\bar\mu
  =\tfrac12\mu_A+\tfrac12\mu_B
  =\tfrac12\delta_0+\tfrac14\delta_2+\tfrac14\delta_3.
\]

That average is one measure on `ℝ`. It is not the outer law
`Q_toy`, which is a probability measure on a space of measures and retains
which atoms appeared together. The candidate does not define this average; the
calculation marks a later interface boundary.

## Frozen interface decisions

| Question | Decision | Boundary protected |
|---|---|---|
| Input ensemble | Reuse `Random.GUE.intrinsicLaw n` | No second GUE normalization or carrier |
| Observable | Reuse `empiricalRawSpacingMeasure` | No duplicate gap or counting convention |
| Outer object | `Measure (Measure ℝ)` with a probability instance | The law is not confused with one sample measure |
| Dimensions 0 and 1 | Outer Dirac mass at the inner zero measure | No invented adjacent gap and no loss of outer mass |
| Dimensions at least 2 | A separate law on `ProbabilityMeasure ℝ` | The inner mass-one certificate is type-visible |
| Wrapper relation | Push forward by coercion to recover the raw law | The raw and bundled interfaces cannot silently diverge |
| Unfolding | Deferred | Mass normalization is not a change of spectral scale |
| Moments and mean measure | Deferred | Measurability alone is not an integrability theorem |
| Repulsion and universality | Not claimed | A finite pushforward definition is not a limiting law |

The decision to preserve dimensions zero and one is deliberate. The inner
observable is the zero measure in each case because no adjacent pair exists.
The outer law still has mass one because there is a definite measure-valued
outcome: the zero measure itself.

## The two probability layers

For every natural-number dimension `n`, the types are

\[
\gamma_n:\operatorname{Measure}(\mathcal H_n),
\qquad
L_n^{\mathrm{raw}}:\mathcal H_n\to\operatorname{Measure}(\mathbb R),
\]

and therefore

\[
\mathcal Q_n^{\mathrm{raw}}
  :\operatorname{Measure}(\operatorname{Measure}(\mathbb R)).
\]

The first `Measure` is the outer distribution across Hamiltonians. The second
is the inner empirical distribution across gap slots of one Hamiltonian.

For `n = 0` and `n = 1`,

\[
\mathcal Q_n^{\mathrm{raw}}=\delta_{0_{\operatorname{Measure}(\mathbb R)}}.
\]

This is not `δ₀` on the real line. Its atom is the zero measure, a point in
`Measure ℝ`.

For dimensions written `n + 2`, each inner outcome is a probability measure.
The candidate therefore also defines

\[
\widetilde{\mathcal Q}_n^{\mathrm{raw}}
  :\operatorname{ProbabilityMeasure}
      (\operatorname{ProbabilityMeasure}(\mathbb R)).
\]

If `ι` forgets the inner mass-one certificate, then

\[
\iota_*\widetilde{\mathcal Q}_n^{\mathrm{raw}}
  =\mathcal Q_{n+2}^{\mathrm{raw}}.
\]

{{< reference-figure
  wide="true"
  src="inner-outer-dimension-boundary.svg"
  alt="In every dimension the Gaussian unitary ensemble input law maps to an outer probability law on measures. Dimensions zero and one land at the zero measure and cannot bundle the inner outcome as a probability measure. Dimensions two and above land in probability measures, and forgetting that wrapper returns the same raw outer law."
  caption="**Two independent mass questions:** the outer law has mass one in every dimension. The inner empirical spacing measure has mass zero for dimensions 0 and 1, then mass one from dimension 2 onward. The positive-dimensional wrapper records only the second fact and does not alter the underlying measure."
>}}

## Declaration-complete source map

1. `empiricalRawSpacingLaw` maps the existing intrinsic GUE law through the
   existing zero-aware empirical raw-spacing observable.
2. `instIsProbabilityMeasureEmpiricalRawSpacingLaw` proves that the outer law
   has total mass one in every dimension.
3. `empiricalRawSpacingLawProbability` bundles that outer law as a
   `ProbabilityMeasure (Measure ℝ)`.
4. `empiricalRawSpacingLaw_zero` identifies the dimension-zero law with the
   Dirac mass at the zero measure.
5. `empiricalRawSpacingLaw_one` identifies the dimension-one law with the same
   Dirac mass, despite the nontrivial one-dimensional GUE input.
6. `empiricalRawSpacingProbabilityLaw` maps dimension `n + 2` GUE through the
   inner probability wrapper.
7. `map_empiricalRawSpacingProbabilityLaw_coe` proves that forgetting the inner
   wrapper recovers `empiricalRawSpacingLaw (n + 2)`.

The last theorem is a commuting-square check, not a new probabilistic claim.
It prevents the two exposed APIs from naming different underlying laws.

## Proof architecture

The outer probability instance is a direct application of Mathlib's theorem
that a measurable pushforward of a probability measure remains a probability
measure. Its premises are already checked:

- `Random.GUE.intrinsicLaw n` is a probability measure;
- `measurable_empiricalRawSpacingMeasure` proves measurability of the raw
  measure-valued observable; and
- `measurable_empiricalRawSpacingProbability` proves measurability after the
  positive-gap-count wrapper.

The dimension-zero theorem uses the earlier equality saying that intrinsic
zero-dimensional GUE is Dirac at the unique zero Hamiltonian. The
dimension-one theorem uses the stronger deterministic fact that every
one-dimensional Hamiltonian has zero raw-spacing measure. The wrapper theorem
uses functoriality of pushforward: mapping through the wrapper and then through
coercion equals mapping through their composition.

## In Lean

{{< lean-bridge
  human="The finite GUE law of raw spacing measures is the input matrix law pushed through the measurable raw-spacing observable."
  math="\(\mathcal Q_n^{\mathrm{raw}}=(L_n^{\mathrm{raw}})_*\gamma_n.\)"
  lean="noncomputable def empiricalRawSpacingLaw (n : ℕ) :\n    Measure (Measure ℝ) :=\n  (Random.GUE.intrinsicLaw n).map empiricalRawSpacingMeasure"
>}}
The first `Measure` is the outer law. Its elements have type `Measure ℝ`,
which is the inner sample statistic. `.map` is Mathlib's pushforward operation.
{{< /lean-bridge >}}

{{< lean-bridge
  human="With zero or one energy level, the random raw-spacing outcome is always the zero measure, so its outer law is concentrated at that one measure-valued point."
  math="\(\mathcal Q_0^{\mathrm{raw}}=\mathcal Q_1^{\mathrm{raw}}=\delta_{0_{\operatorname{Measure}(\mathbb R)}}.\)"
  lean="@[simp] theorem empiricalRawSpacingLaw_zero :\n    empiricalRawSpacingLaw 0 = Measure.dirac (0 : Measure ℝ)\n\n@[simp] theorem empiricalRawSpacingLaw_one :\n    empiricalRawSpacingLaw 1 = Measure.dirac (0 : Measure ℝ)"
>}}
The type annotation `(0 : Measure ℝ)` distinguishes the zero measure from
the real number zero. `Measure.dirac` then places outer unit mass at that
measure-valued point.
{{< /lean-bridge >}}

{{< lean-bridge
  human="From two levels onward, package each sample spacing measure as a probability measure, and recover the raw law by forgetting only that certificate."
  math="\(\iota_*\widetilde{\mathcal Q}_n^{\mathrm{raw}}=\mathcal Q_{n+2}^{\mathrm{raw}}.\)"
  lean="theorem map_empiricalRawSpacingProbabilityLaw_coe (n : ℕ) :\n    ((empiricalRawSpacingProbabilityLaw n :\n      ProbabilityMeasure (ProbabilityMeasure ℝ)) :\n      Measure (ProbabilityMeasure ℝ)).map\n        (fun μ : ProbabilityMeasure ℝ => (μ : Measure ℝ)) =\n      empiricalRawSpacingLaw (n + 2)"
>}}
The inner coercion changes the type from `ProbabilityMeasure ℝ` to
`Measure ℝ`; it does not renormalize or modify the measure.
{{< /lean-bridge >}}

## Try the full project module

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

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
Lean's elaborator constructs candidate proof terms and its kernel checks them
against the formal pushforward statements. That check does not establish that
finite GUE models a particular physical Hamiltonian or that raw finite gaps
follow a universal limiting law.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/QuantumChaos/GUE.lean
```

## Prior work, contribution, and nonclaims

Schubert and Venker define empirical nearest-neighbor spacing measures for
unfolded random-matrix spectra and distinguish an empirical distribution from
an expected spacing distribution. Kriecherbauer and Schubert likewise use a
full-spectrum empirical spacing measure normalized by the number of available
gaps. Those works motivate the spacing object and its later probabilistic
study; this finite Lean module does not formalize their unfolding or
large-dimension theorems.

This candidate contributes only a checked interface layer:

- it reuses the project's exact finite GUE and raw-spacing conventions;
- it makes the nested measure type explicit;
- it closes both empty-gap dimensions without inventing an inner probability
  measure; and
- it proves coherence between raw and probability-valued outcome laws.

It does not claim:

- a formula for a spacing density or joint eigenvalue density;
- a mean spacing measure, moment, or integrability statement;
- unit mean, unfolding, a bulk or edge window, or a large-`n` limit;
- level repulsion, Wigner-Dyson statistics, or universality; or
- quantum chaos for a physical system.

## References

- Kristina Schubert and Martin Venker, “Empirical Spacings of Unfolded
  Eigenvalues,” *Electronic Journal of Probability* 20 (2015), paper 120,
  [DOI 10.1214/EJP.v20-4436](https://doi.org/10.1214/EJP.v20-4436),
  [arXiv 1505.07664v2](https://arxiv.org/abs/1505.07664), 23 August 2015.
  Equation (1.1) supplies the adjacent-spacing empirical-measure comparison;
  its unfolding and asymptotic results remain outside this module.
- T. Kriecherbauer and K. Schubert, “Spacings: An Example for Universality in
  Random Matrix Theory,” in *Random Matrices and Iterated Random Functions*,
  Springer Proceedings in Mathematics & Statistics 53 (2013), 45–71,
  [DOI 10.1007/978-3-642-38806-4_3](https://doi.org/10.1007/978-3-642-38806-4_3),
  [arXiv 1510.06597v2](https://arxiv.org/abs/1510.06597). The full-spectrum
  spacing measure uses the available-gap normalization `1/(N-1)`.
- Thomas Guhr, Axel Müller-Groeling, and Hans A. Weidenmüller,
  “Random-matrix theories in quantum physics: common concepts,” *Physics
  Reports* 299 (1998), 189–425,
  [DOI 10.1016/S0370-1573(97)00088-4](https://doi.org/10.1016/S0370-1573%2897%2900088-4),
  [arXiv cond-mat/9707301](https://arxiv.org/abs/cond-mat/9707301). Section
  III.B separates unfolding and unit-mean spacing from raw finite gaps.
- Mathlib contributors,
  [`MeasureTheory.Measure.GiryMonad`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/GiryMonad.lean)
  and
  [`MeasureTheory.Measure.ProbabilityMeasure`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/ProbabilityMeasure.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0. These are the formal API
  sources for measure-valued measurability, pushforward, and probability
  subtypes.

Continue with the [Deep Dive]({{< relref
"/knowledge-base/deep-dives/finite-gue-laws-of-raw-spacing-measures" >}}) for
the executable two-spectrum ledger, or use the
[empirical raw-spacing law glossary chapter]({{< relref
"/knowledge-base/glossary/empirical-raw-spacing-law" >}}) for the compact type
boundary.
