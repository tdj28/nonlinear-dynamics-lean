---
title: "Signed Real-Log Kingman Convergence in Lean"
slug: "signed-real-log-kingman-convergence-in-lean"
date: 2026-07-27
weight: -70
author: "tdj28"
summary: "Random-matrix-theory milestone 35 constructs the finite signed Fekete rate and proves almost-everywhere convergence of normalized real-log cocycle growth from pointwise invertibility, two integrable generator tails, and a pre-ergodic probability base."
lead: |
  A constant one-dimensional generator with entry exp(r) has horizon-n norm exp(nr), so its normalized signed real log is exactly r. The contraction, neutral, and expansion choices r = -1, 0, 1 are the boundary atlas for RMT-35. The general theorem replaces this exact scalar calculation by two deterministic and samplewise squeezes: inverse tails keep normalized growth bounded below, subadditivity determines a finite Fekete rate, and lower-liminf plus upper-limsup estimates force almost-everywhere convergence to that rate.
key_result: |
  On a probability space, if a one-sided discrete matrix cocycle has pointwise invertible generators, integrable forward and inverse generator log-positive norms, and a pre-ergodic measure-preserving base, then Real.log ‖C.value n ω‖ / n converges almost everywhere to the finite signed integrated Fekete rate. The result is pointwise almost-everywhere convergence only.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Advanced finite-dimensional matrix cocycles, integrability, subadditivity, Fekete limits, Birkhoff averages, and almost-everywhere convergence"
reading_time: "150 to 220 minutes"
prerequisites:
  - "RMT-34 finite-time real-log integrability and signed subadditivity"
  - "RMT-29 generalized upper-limsup phase averaging"
  - "RMT-32 centered lower-deviation control"
  - "Probability measures, almost-everywhere statements, liminf, and limsup"
lean_module: "NonlinearDynamics.Random.RandomCocycles.RealLogNormKingman"
lean_source: "formalization/NonlinearDynamics/Random/RandomCocycles/RealLogNormKingman.lean"
lean_snapshot: "/lean/NonlinearDynamics/Random/RandomCocycles/RealLogNormKingman.lean"
lean_source_sha256: "428cf84a18fcec75a8a2deb9aaa49e612b87706d3f39da4aa81e61b78d8e601a"
tags:
  - "Lean 4"
  - "Random matrix products"
  - "Matrix cocycles"
  - "Kingman theorem"
  - "Signed logarithmic growth"
  - "Fekete lemma"
  - "Almost everywhere convergence"
og_image: "signed-real-log-kingman-convergence-in-lean-card.png"
og_image_alt: "Warm-paper teaching card showing contraction, neutral, and expansion scalar cocycles with exact signed rates negative one, zero, and one, followed by lower-liminf and upper-limsup rails squeezing normalized real-log growth to one finite Fekete rate."
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
**Editorial status.** This declaration-complete teaching chapter is an
AI-assisted public working note. The warning-fatal Lean source is
authoritative. Human editorial acceptance and separate scientific-integrity
and expert-reader reviews remain pending. The configured Pro review has not
been performed, and `pro_reviewed` remains false.
{{< /panel >}}

## Start with the exact scalar boundary

Fix a real number \(r\). On the one-point probability space, use the identity
base map and the one-by-one generator

\[
A=\begin{bmatrix}e^r\end{bmatrix}.
\]

At horizon \(n\), the cocycle value is \(A^n=[e^{nr}]\). Its selected operator
norm is \(e^{nr}\), so

\[
\frac{\log\lVert A^n\rVert}{n}=r
\qquad(n\ge1).
\]

Thus \(r=-1\) gives exact contraction, \(r=0\) gives neutral growth, and
\(r=1\) gives exact expansion. These are not numerical experiments. The
private Lean atlas checks the matrix power, its norm, the real logarithm, the
integrability package, and the resulting Fekete rate for an arbitrary real
\(r\), then instantiates all three signs.

{{< reference-figure
  wide="true"
  src="signed-rate-boundary-atlas.svg"
  alt="Three one-dimensional constant cocycles have generator entries exp negative one, one, and exp one. Their horizon-n signed log norms are negative n, zero, and n, so their normalized signed rates are negative one, zero, and one."
  caption="**Exact boundary atlas:** a constant scalar generator \(e^r\) has \(C_n=e^{nr}\) and normalized signed log \(r\) at every positive horizon. The three displayed choices check contraction, neutral growth, and expansion. They exhibit the sign range of the theorem; they do not establish the general result."
>}}

The signed observable matters because the older positive-log observable clips
contraction:

\[
\log^+ \lVert [e^{-n}]\rVert=0,
\qquad
\log \lVert [e^{-n}]\rVert=-n.
\]

RMT-35 therefore uses the real-valued family

\[
X_n(\omega)=\log\lVert C_n(\omega)\rVert
\]

constructed in RMT-34. Pointwise invertibility prevents a finite product from
being zero, while integrable forward and inverse one-step tails control the
positive and negative sides.

## The deterministic ledger

Define the signed integral and its normalized version by

\[
a_n=\int X_n\,d\mu,
\qquad
\bar a_n=\frac{a_n}{n}.
\]

The Lean names are `integratedRealLogNorm` and
`normalizedIntegratedRealLogNorm`. Time zero is totalized as zero, but the
Fekete infimum uses only positive horizons. The lemmas
`integratedRealLogNorm_zero`,
`integratedRealLogNorm_eq_zero_of_isEmpty`,
`normalizedIntegratedRealLogNorm_zero`, and
`normalizedIntegratedRealLogNorm_eq_zero_of_isEmpty` record those boundary
values.

Measure preservation removes a shifted base iterate from an integral through
`integral_realLogNormObservable_at_base_iterate_eq`. RMT-34 supplies signed
pointwise subadditivity and finite-horizon integrability. Their integrated
form is
`HasIntegrableGeneratorLogTails.integratedRealLogNorm_add_le`; the packaged
sequence result is
`HasIntegrableGeneratorLogTails.subadditive_integratedRealLogNorm`.

The lower budget is the one-step integral
`integratedInverseGeneratorLogPlusNorm`. Its nonnegativity is
`integratedInverseGeneratorLogPlusNorm_nonneg`. The definitional bridge
`birkhoffSum_inverseGeneratorLogPlusNormObservable_eq` identifies the abstract
Birkhoff sum with the cocycle's inverse-orbit sum, while
`integral_inverseOrbitLogPlusSum_eq` evaluates its integral as \(n\) times the
one-step integral.

Consequently,
`HasIntegrableGeneratorLogTails.neg_nat_mul_integratedInverseGeneratorLogPlusNorm_le_integratedRealLogNorm`
gives

\[
-n\int\log^+\lVert A(\omega)^{-1}\rVert\,d\mu(\omega)
\le a_n.
\]

The upper comparisons are
`HasIntegrableGeneratorLogTails.integratedRealLogNorm_le_integratedLogPlusNorm`
and `HasIntegrableGeneratorLogTails.integratedRealLogNorm_le_nat_mul`.
After division by \(n\), the lower result becomes
`HasIntegrableGeneratorLogTails.neg_integratedInverseGeneratorLogPlusNorm_le_normalizedIntegratedRealLogNorm`;
`HasIntegrableGeneratorLogTails.bddBelow_normalizedIntegratedRealLogNorm`
packages boundedness below.

The finite real number
`integratedRealLogGrowthRate` is Mathlib's Fekete limit for this subadditive
sequence. The convergence theorem is
`HasIntegrableGeneratorLogTails.tendsto_normalizedIntegratedRealLogNorm`, and
`HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_eq_sInf`
identifies the rate with the infimum of \(\bar a_n\) over \(n\ge1\).
The comparison API consists of
`HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_le_normalized`,
`HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_le_oneStep`,
`HasIntegrableGeneratorLogTails.neg_integratedInverseGeneratorLogPlusNorm_le_integratedRealLogGrowthRate`,
and
`HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_le_integratedLogPlusGrowthRate`.

{{< lean-bridge
  human="The long-run signed integrated rate is finite, is approached by normalized signed integrals, and is no larger than any positive-horizon normalized integral."
  math="If \(a_{m+n}\le a_m+a_n\) and \(a_n/n\) is bounded below, then \(\lambda=\lim_n a_n/n=\inf_{n\ge1}a_n/n\), so \(\lambda\le a_k/k\) for \(k\ge1\)."
  lean="hC.tendsto_normalizedIntegratedRealLogNorm\nhC.integratedRealLogGrowthRate_eq_sInf\nhC.integratedRealLogGrowthRate_le_normalized hk"
>}}
`hC` stores pointwise invertibility and both integrable one-step tails.
`Tendsto ... atTop (𝓝 λ)` is ordinary sequence convergence to the
neighborhood filter of `λ`. `sInf` is the greatest lower bound. The argument
`hk : k ≠ 0` excludes the totalized time-zero quotient.
{{< /lean-bridge >}}

## The two samplewise rails

The deterministic rate must next be compared with each normalized sample
path. The lower rail uses the centered lower-deviation theorem. Its exact
input is
`HasIntegrableGeneratorLogTails.centeredRealLogFeketeOffset_le_normalizedIntegral`;
its endpoint is
`HasIntegrableGeneratorLogTails.ae_integratedRealLogGrowthRate_le_liminf_normalized`.
In symbols, for almost every \(\omega\),

\[
\lambda\le\liminf_{n\to\infty}\frac{X_n(\omega)}n.
\]

The upper rail cannot assume nonnegativity: contraction makes that false.
`IsPointwiseInvertible.neg_birkhoffAverage_inverseGenerator_le_normalizedRealLogNorm`
instead places the negative inverse-tail average below normalized signed
growth. Ordinary pointwise Birkhoff convergence makes that lower comparison
eventually bounded; the packaged statement is
`IsPointwiseInvertible.ae_isBoundedUnder_ge_normalizedRealLogNormObservable`.
That hypothesis is exactly what the generalized RMT-29 phase-averaging
theorem requires. The resulting endpoint is
`HasIntegrableGeneratorLogTails.ae_limsup_normalized_le_integratedRealLogGrowthRate`:

\[
\limsup_{n\to\infty}\frac{X_n(\omega)}n\le\lambda
\quad\text{almost everywhere}.
\]

The squeeze is visual rather than an extra assumption:

{{< reference-figure
  wide="true"
  src="signed-kingman-squeeze.svg"
  alt="A lower-liminf rail places the finite signed Fekete rate below the sample-path liminf. An upper-limsup rail places the limsup below the same rate. Since liminf never exceeds limsup, all three values coincide almost everywhere."
  caption="**Two rails, one limit:** centered lower deviations give \(\lambda\le\liminf X_n/n\). Phase averaging, enabled by the inverse-tail eventual lower bound, gives \(\limsup X_n/n\le\lambda\). Together with \(\liminf\le\limsup\), they force convergence almost everywhere."
>}}

The principal theorem is
`HasIntegrableGeneratorLogTails.ae_tendsto_normalizedRealLogNormObservable`.
It assumes `IsProbabilityMeasure μ` and `PreErgodic C.base μ`; preservation is
already part of the cocycle. It concludes almost-everywhere convergence to
`C.integratedRealLogGrowthRate hC`.

`HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_eq_zero_of_isEmpty`
records that empty matrix dimension has rate zero. Finally,
`HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_eq_integratedLogPlusGrowthRate_of_pos`
identifies the signed and positive-log deterministic rates when the latter is
strictly positive. That proof uses uniqueness of the two almost-everywhere
sample limits, not an exchange of a limit with an integral.

## A lightweight standalone tutorial

This small file imports only `Std`. It checks the arithmetic shape of the
scalar atlas without matrices or measure theory:

```lean
import Std

def signedPrefix (rate : Int) (n : Nat) : Int :=
  (n : Int) * rate

example (n : Nat) : signedPrefix (-1) n = -(n : Int) := by
  simp [signedPrefix]

example (n : Nat) : signedPrefix 0 n = 0 := by
  simp [signedPrefix]

example (n : Nat) : signedPrefix 1 n = n := by
  simp [signedPrefix]
```

Save it as `SignedRateTutorial.lean`, then run on macOS or Linux:

```text
lean SignedRateTutorial.lean
```

This standalone tutorial checks integer identities only. It does not import
the repository definitions or establish any probabilistic convergence claim.

{{< repo-check >}}
This full project check elaborates the exact matrix, measure-theoretic, Fekete,
and almost-everywhere statements. Lean's elaborator constructs candidate proof
terms and the kernel checks them against the formal declarations. That does
not by itself audit whether those declarations match an intended application.
The displayed command uses `lake env lean` with the repository's pinned
toolchain and dependency manifest.
{{< /repo-check >}}

## Complete public declaration map

| Layer | Public declarations |
|---|---|
| Signed integrals | `integratedRealLogNorm`; `integratedRealLogNorm_zero`; `integratedRealLogNorm_eq_zero_of_isEmpty`; `integral_realLogNormObservable_at_base_iterate_eq`; `HasIntegrableGeneratorLogTails.integratedRealLogNorm_add_le`; `HasIntegrableGeneratorLogTails.subadditive_integratedRealLogNorm` |
| Inverse and forward controls | `integratedInverseGeneratorLogPlusNorm`; `integratedInverseGeneratorLogPlusNorm_nonneg`; `birkhoffSum_inverseGeneratorLogPlusNormObservable_eq`; `integral_inverseOrbitLogPlusSum_eq`; `HasIntegrableGeneratorLogTails.neg_nat_mul_integratedInverseGeneratorLogPlusNorm_le_integratedRealLogNorm`; `HasIntegrableGeneratorLogTails.integratedRealLogNorm_le_integratedLogPlusNorm`; `HasIntegrableGeneratorLogTails.integratedRealLogNorm_le_nat_mul` |
| Normalization and Fekete rate | `normalizedIntegratedRealLogNorm`; `normalizedIntegratedRealLogNorm_zero`; `normalizedIntegratedRealLogNorm_eq_zero_of_isEmpty`; `HasIntegrableGeneratorLogTails.neg_integratedInverseGeneratorLogPlusNorm_le_normalizedIntegratedRealLogNorm`; `HasIntegrableGeneratorLogTails.bddBelow_normalizedIntegratedRealLogNorm`; `integratedRealLogGrowthRate`; `HasIntegrableGeneratorLogTails.tendsto_normalizedIntegratedRealLogNorm`; `HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_eq_sInf`; `HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_le_normalized`; `HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_le_oneStep`; `HasIntegrableGeneratorLogTails.neg_integratedInverseGeneratorLogPlusNorm_le_integratedRealLogGrowthRate`; `HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_le_integratedLogPlusGrowthRate` |
| Kingman rails | `HasIntegrableGeneratorLogTails.centeredRealLogFeketeOffset_le_normalizedIntegral`; `IsPointwiseInvertible.neg_birkhoffAverage_inverseGenerator_le_normalizedRealLogNorm`; `IsPointwiseInvertible.ae_isBoundedUnder_ge_normalizedRealLogNormObservable`; `HasIntegrableGeneratorLogTails.ae_integratedRealLogGrowthRate_le_liminf_normalized`; `HasIntegrableGeneratorLogTails.ae_limsup_normalized_le_integratedRealLogGrowthRate`; `HasIntegrableGeneratorLogTails.ae_tendsto_normalizedRealLogNormObservable` |
| Boundary and rate comparison | `HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_eq_zero_of_isEmpty`; `HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_eq_integratedLogPlusGrowthRate_of_pos` |

## Exact nonclaims

RMT-35 proves pointwise almost-everywhere convergence. It does not prove
\(L^1\) convergence, uniform integrability of the normalized signed family,
interchange of limit and integral, a quantitative convergence rate, a
concentration inequality, a conorm or singular-value limit, a Lyapunov
spectrum, invariant subspaces, an Oseledets splitting, a derivative-cocycle
bridge, or a stable-manifold theorem. It also does not claim that the
deterministic rate equals an individual sample rate without the probability
and pre-ergodicity assumptions in the endpoint.

## References

1. J. F. C. Kingman, “The Ergodic Theory of Subadditive Stochastic
   Processes,” *Journal of the Royal Statistical Society: Series B* 30(3),
   499–510 (1968),
   [doi:10.1111/j.2517-6161.1968.tb00749.x](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x).
2. [RMT-34: Real Log-Norm Integrability from Forward and Inverse Tails in Lean]({{< relref "/development-notebook/2026/07/real-log-norm-integrability-from-forward-and-inverse-tails-in-lean" >}}).
3. [RMT-29: Subadditive Upper Limsup from Phase Averaging in Lean]({{< relref "/development-notebook/2026/07/subadditive-upper-limsup-from-phase-averaging-in-lean" >}}).
4. [Integrated real-log growth rate]({{< relref "/knowledge-base/glossary/integrated-real-log-growth-rate" >}}).
5. [Integrated Real-Log Growth and Signed Kingman Convergence]({{< relref "/knowledge-base/deep-dives/integrated-real-log-growth-and-signed-kingman-convergence" >}}).
