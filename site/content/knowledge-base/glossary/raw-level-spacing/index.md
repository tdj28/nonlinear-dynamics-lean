---
title: "Raw level spacing"
slug: "raw-level-spacing"
summary: "The nonnegative difference between adjacent decreasingly ordered finite energy levels, before unfolding or ensemble averaging."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.QuantumChaos.SpectralStatistics"
tags:
  - "Quantum chaos"
  - "Spectral statistics"
  - "Eigenvalues"
  - "Empirical measures"
og_image: "raw-level-spacing-card.png"
og_image_alt: "A decreasing three-level spectrum two, two, minus one becomes two raw adjacent gaps, zero and three."
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
candidate. Its paired Lean module has passed the repository's pinned Lean
4.32.0 checks. Professional review remains pending, so `pro_reviewed` remains
false.
{{< /panel >}}

A **raw level spacing** is the difference between adjacent entries of a
finite ordered spectrum before any unfolding or ensemble operation. This
project orders the eigenvalues of a finite
{{< refterm "hermitian-matrix" "Hermitian matrix" >}} decreasingly,

\[
\lambda_0\ge\lambda_1\ge\cdots\ge\lambda_{n-1},
\]

and defines

\[
\Delta_i=\lambda_i-\lambda_{i+1}\ge0.
\]

The index \(i\) ranges over the \(n-1\) adjacent rank pairs when \(n\ge2\).

## A three-level example

For the decreasing spectrum

\[
(2,2,-1),
\]

the raw gaps are

\[
(2-2,\;2-(-1))=(0,3).
\]

The zero is retained: equal adjacent eigenvalues produce a zero spacing. The
two gap slots generate the counting measure

\[
\delta_0+\delta_3
\]

and the empirical raw-spacing measure

\[
\tfrac12\delta_0+\tfrac12\delta_3.
\]

That empirical measure has mass one and mean \(3/2\). Mass normalization does
not make the mean spacing one.

{{< reference-figure
  wide="true"
  src="raw-level-spacing-map.svg"
  alt="Three decreasing levels two, two, and minus one have adjacent differences zero and three. Both differences enter the empirical raw-spacing measure with weight one half. A separate boundary labels unfolding and ensemble laws as later operations."
  caption="**Raw means before unfolding:** the subtraction direction follows the project's decreasing spectrum. Degeneracy contributes a zero gap, and dividing by the two gap slots normalizes mass without rescaling gap size."
>}}

## Four distinctions

1. **Adjacent rank, not minimum distance.** “Nearest neighbor” means the next
   entry in the ordered finite spectrum.
2. **Nonnegative, not necessarily positive.** Hermiticity supplies real
   eigenvalues and the ordering supplies nonnegative gaps. Repeated levels
   produce zero.
3. **Mass normalization, not unfolding.** Dividing the counting measure by
   the number of gap slots makes a probability measure. Unfolding is a later
   density-dependent transformation.
4. **One sample, not an ensemble law.** The empirical measure belongs to one
   Hamiltonian. A probability law of such measures needs a random Hamiltonian
   and a measurable pushforward.

## Empty boundary cases

Dimensions zero and one have no adjacent pair. Their raw gap index type is
`Fin 0`, and both their counting measure and empirical raw-spacing measure are
zero. The project does not invent a Dirac atom for these empty cases.

A bundled {{< refterm "probability-measure" "probability measure" >}} starts
at dimension two, where one gap exists.

## In Lean

{{< lean-bridge
  human="The raw spacing at adjacent rank i is a real number and is nonnegative."
  math="\(\Delta_i(H)=\lambda_i(H)-\lambda_{i+1}(H)\ge0.\)"
  lean="def rawLevelSpacing {n : ℕ}\n    (H : FiniteHamiltonian n)\n    (i : Fin n.pred) : ℝ\n\ntheorem rawLevelSpacing_nonneg\n    (H : FiniteHamiltonian n) (i : Fin n.pred) :\n    0 ≤ rawLevelSpacing H i"
>}}
`Fin n.pred` contains exactly the available adjacent slots. The codomain is
`ℝ` for compatibility with the existing real spectrum; nonnegativity is a
proved property rather than a coercion built into the type.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.QuantumChaos.SpectralStatistics

open NonlinearDynamics.QuantumChaos

#check rawLevelSpacing
#check rawLevelSpacing_nonneg
#check rawSpacingCountingMeasure
#check rawSpacingCountingMeasure_univ
#check empiricalRawSpacingMeasure
#check empiricalRawSpacingProbability
~~~

This is a **full project check** on macOS or Linux. It uses the pinned Lean and
Mathlib dependencies and may require substantial disk space or build time.

{{< repo-check >}}
Lean's elaborator constructs candidate proof terms and its kernel checks them
against the formal finite-spectrum statements. That does not establish level
repulsion, universality, or chaos for a physical system.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/QuantumChaos/SpectralStatistics.lean
```

Continue with the [Deep Dive]({{< relref
"/knowledge-base/deep-dives/raw-adjacent-level-spacings-counting-measures-and-normalization" >}})
for the computed worksheet, measure construction, and dimension boundary.

## Nonclaims

- A raw gap is not an unfolded gap.
- Nonnegative gaps do not imply a simple spectrum.
- A mass-one empirical gap measure need not have mean one.
- The empirical measure is not an ensemble average or its probability law.
- No GUE law, repulsion statement, universal limit, or quantum-chaos
  criterion follows from the definition.

## References

- Kristina Schubert and Martin Venker, “Empirical Spacings of Unfolded
  Eigenvalues,” *Electronic Journal of Probability* 20 (2015), paper 120,
  [DOI 10.1214/EJP.v20-4436](https://doi.org/10.1214/EJP.v20-4436),
  [arXiv 1505.07664](https://arxiv.org/abs/1505.07664).
- Thomas Guhr, Axel Müller-Groeling, and Hans A. Weidenmüller,
  “Random-matrix theories in quantum physics: common concepts,” *Physics
  Reports* 299 (1998), 189–425,
  [DOI 10.1016/S0370-1573(97)00088-4](https://doi.org/10.1016/S0370-1573%2897%2900088-4),
  [arXiv cond-mat/9707301](https://arxiv.org/abs/cond-mat/9707301).
- Mathlib contributors,
  [`Analysis.Matrix.Spectrum`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Matrix/Spectrum.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.
