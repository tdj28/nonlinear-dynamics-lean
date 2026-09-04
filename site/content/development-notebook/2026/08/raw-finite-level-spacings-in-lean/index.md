---
title: "Raw Finite Level Spacings in Lean"
slug: "raw-finite-level-spacings-in-lean"
date: 2026-08-17
summary: "A source-backed interface for decreasing-order adjacent gaps, multiplicity-preserving counting measures, zero-aware empirical normalization, and measurable probability packaging from dimension two onward."
lead: "Freeze the finite raw statistic before any unfolding, ensemble average, asymptotic law, or quantum-chaos interpretation enters the API."
draft: true
pro_reviewed: false
tags:
  - "Lean"
  - "Quantum chaos"
  - "Spectral statistics"
  - "Level spacing"
  - "Empirical measures"
lean_module: "NonlinearDynamics.QuantumChaos.SpectralStatistics"
lean_source: "formalization/NonlinearDynamics/QuantumChaos/SpectralStatistics.lean"
lean_snapshot: "/lean/NonlinearDynamics/QuantumChaos/SpectralStatistics.lean"
lean_source_sha256: "62a54be4b21c8b68c211ce88244a48418b7d33b99fc36c615f786216bd488941"
toc: true
og_image: "raw-finite-level-spacings-in-lean-card.png"
og_image_alt: "A decreasing three-level spectrum two, two, minus one becomes raw adjacent gaps zero and three, then a counting measure and a mass-normalized empirical measure."
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
**Editorial status.** This is an AI-assisted source
candidate. The exact source identified by the SHA-256 field has passed the
repository's pinned Lean 4.32.0 checks. Professional review remains pending,
so `pro_reviewed` remains false.
{{< /panel >}}

## Abstract

`NonlinearDynamics.QuantumChaos.SpectralStatistics` defines deterministic raw
adjacent gaps for one finite Hermitian Hamiltonian. The existing spectrum is
decreasing,

\[
\lambda_0(H)\ge\lambda_1(H)\ge\cdots\ge\lambda_{n-1}(H),
\]

so the nonnegative orientation is

\[
\Delta_i(H)=\lambda_i(H)-\lambda_{i+1}(H),
\qquad i\in\operatorname{Fin}(\operatorname{pred} n).
\]

Every adjacent rank contributes one slot. Equal neighboring levels contribute
a zero gap rather than being filtered out. The counting measure

\[
C_H=\sum_i\delta_{\Delta_i(H)}
\]

has mass \(\operatorname{pred} n\). The zero-aware empirical measure

\[
L_H^{\mathrm{raw}}=(\operatorname{pred} n)^{-1}C_H
\]

is zero in dimensions zero and one and a probability measure from dimension
two onward. This scaling normalizes mass only. It does not unfold the spectrum
or force mean spacing one.

## Begin with a repeated three-level spectrum

Take the already ordered finite spectrum

\[
(\lambda_0,\lambda_1,\lambda_2)=(2,2,-1).
\]

The adjacent gaps are

\[
(\Delta_0,\Delta_1)=(2-2,\;2-(-1))=(0,3).
\]

The repeated level contributes the atom at zero:

\[
C_H=\delta_0+\delta_3,
\qquad
L_H^{\mathrm{raw}}=\tfrac12\delta_0+\tfrac12\delta_3.
\]

The empirical measure has total mass one, but its first moment is

\[
\tfrac12\cdot0+\tfrac12\cdot3=\tfrac32.
\]

That calculation separates two operations that are sometimes blurred in
informal discussion. Dividing by the number of gaps produces a probability
measure. Unfolding is an additional transformation intended to remove the
smooth variation of mean spectral density; in standard conventions it leads
to unit mean spacing. The candidate performs only the first operation.

{{< reference-figure
  wide="true"
  src="raw-spacing-pipeline.svg"
  alt="Three decreasing levels at two, two, and minus one produce adjacent gaps zero and three. Both gaps enter a counting measure. Dividing by two gives an empirical measure of mass one whose mean remains three halves."
  caption="**The complete finite pipeline:** decreasing spectral order fixes the subtraction direction. The repeated level produces a zero gap, the counting measure retains both adjacent slots, and division by two normalizes total mass without changing the gap scale."
>}}

The example exhibits the sign convention, the multiplicity policy, and the
normalization boundary. It does not establish a statement about all
Hamiltonians. The general source theorems are the separate proof layer.

## Frozen interface decisions

| Question | Decision | Alternative rejected |
|---|---|---|
| Spectrum order | Reuse the decreasing `orderedHermitianEigenvalues` vector | Introducing a second increasing spectrum would split the API |
| Gap orientation | \(\lambda_i-\lambda_{i+1}\) | The increasing-order formula would be negative after direct reuse |
| Gap index | `Fin n.pred` | A sentinel gap would invent data; a list would hide the exact cardinality |
| Codomain | `ℝ` with a nonnegativity theorem | `ℝ≥0` would add coercions to later algebraic transformations |
| Degeneracy | Retain zero gaps with multiplicity | Dropping zero gaps would silently impose simplicity and change total mass |
| Counting normalization | Divide by `n.pred` | Dividing by `n` gives mass \((n-1)/n\) when \(n\gt0\) |
| Dimensions 0 and 1 | Empty gap vector and zero measures | A Dirac mass at zero would invent an adjacent pair |
| Probability wrapper | Only for `FiniteHamiltonian (n + 2)` | An all-dimensional wrapper needs an arbitrary probability fallback |
| Regularity | Pointwise 2-Lipschitz, vector-continuous, and Giry-measurable | No differentiability at eigenvalue collisions is asserted |
| Unfolding | Deferred | Dividing by a sample mean is not adopted as a canonical unfolding |
| Ensemble and GUE law | Deferred | A sample empirical measure and its law are different objects |

The empty-boundary convention is an explicit project choice. Schubert and
Venker choose an arbitrary probability measure when their spacing count is
zero. This project instead preserves the exact zero measure and exposes a
bundled probability measure only when at least one gap exists.

## Dimension ledger

| Matrix dimension | Ordered levels | Gap slots | Counting mass | Empirical measure | Probability wrapper |
|---:|---:|---:|---:|---|---|
| 0 | 0 | 0 | 0 | zero | unavailable |
| 1 | 1 | 0 | 0 | zero | unavailable |
| 2 | 2 | 1 | 1 | probability | available |
| \(n\ge2\) | \(n\) | \(n-1\) | \(n-1\) | probability | available |

`Nat.pred` makes the first two rows total: `0.pred = 0` and `1.pred = 0`.
The type `Fin 0` has no inhabitants, so neither boundary contains a hidden
spacing value.

{{< reference-figure
  wide="true"
  src="spacing-boundary-map.svg"
  alt="A dimension table shows zero and one levels with no gaps and zero measures, while two or more levels have one fewer gap than levels and admit a probability wrapper. A boundary separates raw finite statistics from unfolding, GUE laws, repulsion, and chaos claims."
  caption="**Type boundary:** `Fin n.pred` records exactly the available adjacent slots. The zero-aware measure is total in every dimension; the probability subtype starts only at dimension two. Unfolding and probabilistic interpretation remain downstream."
>}}

## Declaration-complete source map

### Raw gap coordinates

1. `rawLevelSpacing` subtracts neighboring entries in the existing decreasing
   ordered spectrum.
2. `rawLevelSpacing_nonneg` applies antitonicity to prove each difference is
   nonnegative. It does not prove strict positivity.
3. `rawLevelSpacing_hermitianCongruence` transports the earlier equality of
   entire ordered spectra through subtraction.
4. `lipschitzWith_rawLevelSpacing` combines two 1-Lipschitz eigenvalue bounds
   into a 2-Lipschitz bound.
5. `continuous_rawLevelSpacing` records coordinate continuity.
6. `continuous_rawLevelSpacings` packages every coordinate into the finite
   function space.
7. `measurable_rawLevelSpacing` derives coordinate Borel measurability.
8. `measurable_rawLevelSpacings` derives measurability of the whole vector.

The 2-Lipschitz constant is a safe bound from the triangle inequality. This
candidate does not claim it is the best possible constant.

### Counting measure

9. `rawSpacingCountingMeasure` sums one Dirac measure over `Fin n.pred`.
10. `rawSpacingCountingMeasure_hermitianCongruence` proves basis invariance.
11. `rawSpacingCountingMeasure_zero` states the dimension-zero boundary.
12. `rawSpacingCountingMeasure_one` states the dimension-one boundary.
13. `rawSpacingCountingMeasure_univ` proves exact mass `n.pred`.
14. `measurable_rawSpacingCountingMeasure` proves Giry measurability by a
    finite sum of measurable Dirac maps.

The counting measure forgets the order of gaps after placing their atoms. The
ordered function `rawLevelSpacing H` remains public because later consecutive
gap statistics need that rank information.

### Empirical measure and probability subtype

15. `empiricalRawSpacingMeasure` scales the counting measure by the reciprocal
    number of gap slots.
16. `empiricalRawSpacingMeasure_hermitianCongruence` preserves that measure
    under unitary congruence.
17. `empiricalRawSpacingMeasure_zero` makes the first empty boundary explicit.
18. `empiricalRawSpacingMeasure_one` makes the second empty boundary explicit.
19. `empiricalRawSpacingMeasure_isZeroOrProbability` states the total
    all-dimensional contract.
20. `empiricalRawSpacingMeasure_succ_succ_isProbability` proves mass one for
    dimensions written `n + 2`.
21. `empiricalRawSpacingProbability` bundles that measure with its mass-one
    certificate.
22. `measurable_empiricalRawSpacingMeasure` proves Giry measurability of the
    zero-aware map.
23. `measurable_empiricalRawSpacingProbability` proves measurability of the
    positive-gap probability wrapper.

## Proof architecture

The source reuses four earlier facts rather than reconstructing spectral
theory:

1. `orderedHermitianEigenvalues_antitone` fixes decreasing order.
2. `orderedHermitianEigenvalues_hermitianCongruence` supplies unitary
   congruence invariance.
3. `lipschitzWith_orderedHermitianEigenvalues_apply` bounds each level by the
   Frobenius distance.
4. `continuous_orderedHermitianEigenvalues_apply` supplies coordinate
   continuity and hence Borel measurability.

For a fixed gap slot, subtraction of the two level coordinates is continuous.
A finite sum of Dirac maps is measurable as a map into `Measure ℝ`. Constant
measure scaling is measurable, so the empirical map and its probability
subtype inherit measurability.

This is Giry measurability. No topology on the space of measures is selected,
so the candidate does not claim weak continuity of the measure-valued map.

## In Lean

{{< lean-bridge
  human="The raw spacing at adjacent spectral rank i subtracts the next decreasing eigenvalue from the current one."
  math="\(\Delta_i(H)=\lambda_i(H)-\lambda_{i+1}(H)\ge0.\)"
  lean="def rawLevelSpacing {n : ℕ}\n    (H : FiniteHamiltonian n) (i : Fin n.pred) : ℝ"
>}}
`n.pred` is the predecessor of the dimension, `Fin n.pred` has exactly that
many indices, and the result stays in `ℝ`. The separate theorem
`rawLevelSpacing_nonneg` records the order consequence without changing the
codomain.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Place one Dirac atom at every raw adjacent gap, including zero gaps."
  math="\(C_H=\sum_{i=0}^{n-2}\delta_{\Delta_i(H)}.\)"
  lean="def rawSpacingCountingMeasure {n : ℕ}\n    (H : FiniteHamiltonian n) : Measure ℝ :=\n  ∑ i, Measure.dirac (rawLevelSpacing H i)"
>}}
The finite sum ranges over every inhabitant of `Fin n.pred`.
`Measure.dirac x` puts unit mass at `x`; repeated values create repeated
summands rather than being deduplicated.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Only a Hamiltonian with at least two levels receives a bundled empirical spacing probability measure."
  math="\(H\in M_{n+2}\Longrightarrow L_H^{\mathrm{raw}}\in\mathcal P(\mathbb R).\)"
  lean="def empiricalRawSpacingProbability (n : ℕ)\n    (H : FiniteHamiltonian (n + 2)) : ProbabilityMeasure ℝ"
>}}
Writing the dimension as `n + 2` makes the positive number of gap slots part
of the type. `ProbabilityMeasure ℝ` contains both the underlying measure and
the checked mass-one certificate.
{{< /lean-bridge >}}

## Try the full project module

~~~lean
import NonlinearDynamics.QuantumChaos.SpectralStatistics

open NonlinearDynamics.QuantumChaos

#check rawLevelSpacing
#check rawLevelSpacing_nonneg
#check lipschitzWith_rawLevelSpacing
#check rawSpacingCountingMeasure
#check rawSpacingCountingMeasure_univ
#check empiricalRawSpacingMeasure
#check empiricalRawSpacingMeasure_isZeroOrProbability
#check empiricalRawSpacingProbability
#check measurable_empiricalRawSpacingProbability
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
Lean's elaborator constructs candidate proof terms and its kernel checks them
against the exact finite-spectrum statements. That check does not certify
that raw gaps are a faithful chaos diagnostic, that an ensemble model applies,
or that an asymptotic spacing law holds.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/QuantumChaos/SpectralStatistics.lean
```

## Claim boundary

The candidate establishes finite definitions, nonnegativity, mass, invariance,
continuity of gap coordinates, and measurability of the resulting measures.
It does not establish:

- strict positivity of every gap or simplicity of the spectrum;
- differentiability of ordered eigenvalues through collisions;
- unit mean spacing;
- an unfolding map, bulk window, or edge convention;
- a random Hamiltonian law or law of the spacing measure;
- existence of ensemble moments or interchange of expectation and moments;
- Wigner-Dyson statistics, level repulsion, universality, or an asymptotic
  limit; or
- quantum chaos for any physical system.

“Nearest neighbor” here means adjacent rank in the ordered finite spectrum. It
does not mean a separately minimized distance in another metric space.

## References

- Kristina Schubert and Martin Venker, “Empirical Spacings of Unfolded
  Eigenvalues,” *Electronic Journal of Probability* 20 (2015), paper 120,
  [DOI 10.1214/EJP.v20-4436](https://doi.org/10.1214/EJP.v20-4436),
  [arXiv 1505.07664](https://arxiv.org/abs/1505.07664). Equation (1.1)
  defines a spacing counting measure from adjacent ordered differences; the
  normalization divides by the number of included gaps. Their empty case uses
  an arbitrary probability measure, while this project keeps the zero measure.
- Thomas Guhr, Axel Müller-Groeling, and Hans A. Weidenmüller,
  “Random-matrix theories in quantum physics: common concepts,” *Physics
  Reports* 299 (1998), 189–425,
  [DOI 10.1016/S0370-1573(97)00088-4](https://doi.org/10.1016/S0370-1573%2897%2900088-4),
  [arXiv cond-mat/9707301](https://arxiv.org/abs/cond-mat/9707301).
  Section III.B separates unfolding from nearest-neighbor statistics and
  normalizes the unfolded spacing density by both mass and first moment.
- T. Kriecherbauer and K. Schubert, “Spacings: An Example for Universality in
  Random Matrix Theory,” in *Random Matrices and Iterated Random Functions*,
  Springer Proceedings in Mathematics & Statistics 53 (2013), 45–71,
  [DOI 10.1007/978-3-642-38806-4_3](https://doi.org/10.1007/978-3-642-38806-4_3).
  The full-spectrum empirical spacing measure uses the factor `1/(N-1)`.
- Mathlib contributors,
  [`Analysis.Matrix.Spectrum`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Matrix/Spectrum.lean),
  [`MeasureTheory.Measure.GiryMonad`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/GiryMonad.lean), and
  [`MeasureTheory.Measure.ProbabilityMeasure`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/ProbabilityMeasure.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.

Continue with the [Deep Dive]({{< relref
"/knowledge-base/deep-dives/raw-adjacent-level-spacings-counting-measures-and-normalization" >}})
for the computed worksheet and concept-by-concept explanation, or use the
[raw level spacing glossary chapter]({{< relref
"/knowledge-base/glossary/raw-level-spacing" >}}) for a shorter orientation.
