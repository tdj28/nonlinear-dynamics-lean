---
title: "Finite orbit visit count"
slug: "finite-orbit-visit-count"
summary: "A finite orbit visit count is the natural number of times a chosen finite orbit prefix lands in a set."
draft: false
pro_reviewed: false
toc: false
lean_module: "NonlinearDynamics.Random.RandomCocycles.SubadditiveBadBlockMeasure"
og_image: "finite-orbit-visit-count-card.png"
og_image_alt: "Warm-paper glossary card showing seven zero-based orbit positions, visits marked at times zero, two, and five, and the resulting natural count three before its real-valued integral identity."
---

The **finite orbit visit count** records how many of a fixed number of
successive orbit positions lie in a chosen set. It is a count over a finite,
zero-based time window, so its value is a natural number.

Let \(T:\Omega\to\Omega\) be a map on a state space \(\Omega\), let
\(s\subseteq\Omega\), let \(H\in\mathbb N\) be the horizon, and let
\(\omega\in\Omega\) be the starting point. The count is

\[
N_H(s,\omega)
{} =
\#\left\{j\in\mathbb N:j\lt H\ \text{and}\ T^j\omega\in s\right\}.
\]

The horizon contains exactly the indices \(0,\ldots,H-1\). It does not include
time \(H\). Thus \(H=0\) gives an empty index set and \(N_0(s,\omega)=0\), while
\(H=1\) tests only the starting point because \(T^0\omega=\omega\). Repeated
returns at different indices are counted separately, even if the orbit visits
the same state more than once.

{{< reference-figure
  src="finite-orbit-visit-count.svg"
  alt="Seven zero-based orbit positions have indicator values one, zero, one, zero, zero, one, zero. The marked visits at times zero, two, and five sum to the natural count three, which can then be cast to the real number three for integration."
  caption="A toy horizon with indices zero through six contains three marked visits. The visit count is the sum of the seven indicator values. Casting places that count in the real codomain used by the integral; integrability still comes from the later finite-measure hypotheses."
>}}

## Indicator and Birkhoff-sum form

Define the real-valued indicator of \(s\) by

\[
\mathbf 1_s(x)=
\begin{cases}
1,&x\in s,\\
0,&x\notin s.
\end{cases}
\]

Then the natural count, after casting it to \(\mathbb R\), is exactly a finite
{{< refterm "birkhoff-sum" "Birkhoff sum" >}}:

\[
\bigl(N_H(s,\omega):\mathbb R\bigr)
{} =
\sum_{\substack{j\in\mathbb N\\j\lt H}}\mathbf 1_s(T^j\omega).
\]

This identity is finite combinatorics. It needs no measurable space, measure,
measure preservation, probability normalization, or ergodicity. The real cast
is a type change used for real scalar algebra and integration. The underlying
value remains an integer between \(0\) and \(H\).

For example, suppose \(H=7\) and the orbit is in \(s\) at precisely the times
\(0\), \(2\), and \(5\). The indicator sequence on the finite window is

\[
(1,0,1,0,0,1,0),
\qquad
N_7(s,\omega)=1+0+1+0+0+1+0=3.
\]

## Integral under preservation

Now give \(\Omega\) a measurable structure and a finite measure \(\mu\). Assume
that \(T\) is measurable and preserves \(\mu\), meaning that precomposing with
\(T\) leaves the measure unchanged, and assume that \(s\) is null measurable.
These are the two fields bundled by Mathlib's `MeasurePreserving` interface.
Null measurability means that \(s\) agrees almost everywhere with a measurable
set; ordinary measurability is not required. Under these hypotheses,

\[
\int_\Omega \bigl(N_H(s,\omega):\mathbb R\bigr)\,d\mu(\omega)
{} =
H\,\mu(s).
\]

In the Lean statement, the right side is written `H * μ.real s`, where
`μ.real s` is Mathlib's real-valued view of the set measure. Finite total
measure ensures that the indicator is integrable. Preservation makes every
term \(\mathbf 1_s\circ T^j\) have the same integral \(\mu(s)\), and the finite
sum therefore contributes \(H\) copies. At \(H=0\), the identity correctly
reduces to \(0=0\).

On a probability space, this integral can be read as the expected number of
visits in the finite window. For a general finite measure it is an unnormalized
integral, not an expectation.

## In Lean

The repository definition is a filtered finite-set cardinality:

```lean
noncomputable def finiteOrbitVisitCount (T : Ω → Ω) (s : Set Ω)
    (H : ℕ) (ω : Ω) : ℕ := by
  classical
  exact ((Finset.range H).filter fun j ↦ T^[j] ω ∈ s).card
```

`Finset.range H` fixes the zero-based convention. The theorem
`natCast_finiteOrbitVisitCount_eq_birkhoffSum_indicator` identifies its real
cast with `birkhoffSum T (s.indicator fun _ ↦ (1 : ℝ)) H ω`. The theorem
`integral_finiteOrbitVisitCount` then uses finite measure,
`MeasurePreserving T μ μ`, and `NullMeasurableSet s μ` to prove the exact
integral formula.

The definition is `noncomputable` because membership in an arbitrary set need
not be decidable. This is a logical implementation detail, not a restriction
on the finite counting identity.

## What the count does not say

A finite orbit visit count is not automatically:

- a visit frequency, because it has not been divided by \(H\);
- an asymptotic density, because no limit as \(H\to\infty\) has been taken;
- a recurrence theorem, because a finite count does not show that visits occur
  infinitely often;
- an ergodic theorem, because the definition and indicator identity assume no
  ergodicity and the integral formula assumes only finite measure and
  preservation; or
- a probability, except after adding probability normalization and an
  appropriate interpretation.

Related concepts: {{< refterm "birkhoff-sum" "Birkhoff sums" >}},
{{< refterm "measurable-space" "measurable spaces" >}},
{{< refterm "almost-everywhere" "almost-everywhere equality" >}}, and
{{< refterm "ergodicity" "ergodicity" >}}.

Companion chapters:
[Finite Centered Bad-Block Measure Control in Lean]({{< relref "/development-notebook/2026/07/finite-centered-bad-block-measure-control-in-lean" >}})
and
[Finite Bad-Block Measure Bounds Before Kingman Lower Liminf]({{< relref "/knowledge-base/deep-dives/finite-bad-block-measure-bounds-before-kingman-lower-liminf" >}}).

## Sources

The repository's
[checked RMT-30 module](https://github.com/tdj28/nonlinear-dynamics-lean/blob/main/formalization/NonlinearDynamics/Random/RandomCocycles/SubadditiveBadBlockMeasure.lean)
is authoritative for the definition and theorem signatures. The pinned
Mathlib sources provide the
[Birkhoff-sum interface](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/BirkhoffSum/Basic.lean),
[null-measurable indicator integration](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Integral/Bochner/Set.lean),
and
[null-measurable function and set APIs](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/MeasureTheory/Measure/NullMeasurable.lean)
used by that proof.
