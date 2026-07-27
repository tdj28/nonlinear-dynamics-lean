---
title: "Integrated real-log growth rate"
slug: "integrated-real-log-growth-rate"
summary: "The integrated real-log growth rate is the finite Fekete limit of normalized signed expected cocycle log norms under pointwise invertibility and integrable forward and inverse generator tails."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.RealLogNormKingman"
lean_snapshot: "/lean/NonlinearDynamics/Random/RandomCocycles/RealLogNormKingman.lean"
lean_source_sha256: "428cf84a18fcec75a8a2deb9aaa49e612b87706d3f39da4aa81e61b78d8e601a"
og_image: "integrated-real-log-growth-rate-card.png"
og_image_alt: "A glossary teaching card showing signed integrated values a n, normalized values a n over n bounded below by a finite inverse-tail budget, and their convergence to the positive-horizon infimum lambda."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note.
`pro_reviewed` remains false. Human review of the mathematics, Lean
interpretation, source use, and accessibility remains pending.
{{< /panel >}}

On a one-point probability space, let a one-by-one matrix cocycle use the
constant generator \([e^{-1}]\). At horizon \(n\), its value is
\([e^{-n}]\), its norm is \(e^{-n}\), and its signed log norm is \(-n\).
Therefore

\[
\frac1n\int\log\lVert C_n(\omega)\rVert\,d\mu(\omega)=-1
\qquad(n\ge1).
\]

The **integrated real-log growth rate** is the general version of that
long-run signed number.

## Definition

For a matrix cocycle \(C\), define

\[
a_n=\int \log\lVert C_n(\omega)\rVert\,d\mu(\omega).
\]

Under pointwise invertibility and integrable forward and inverse one-step
log-positive norms, RMT-35 proves that \(a_n\) is subadditive and that
\(a_n/n\) has a finite lower bound. Its integrated real-log growth rate is

\[
\lambda_{\mathrm{real}}
=\lim_{n\to\infty}\frac{a_n}{n}
=\inf_{n\ge1}\frac{a_n}{n}.
\]

The word **integrated** means that each finite-horizon signed observable is
integrated before taking the long-run limit. The word **real-log**
distinguishes the signed logarithm from the clipped nonnegative quantity
\(\log^+x=\max(0,\log x)\). The word **growth** includes negative contraction
rates, zero neutral rates, and positive expansion rates.

{{< reference-figure
  wide="true"
  src="integrated-real-log-growth-rate.svg"
  alt="A sequence of normalized signed integrals a one over one, a two over two, and later a n over n stays above negative J and approaches lambda, which equals the infimum over all positive horizons."
  caption="**Definition with its analytic gate:** integrated subadditivity organizes \(a_n/n\), while the inverse-tail budget \(J\) gives the finite floor \(-J\). Fekete's lemma then identifies the limit with the positive-horizon infimum."
>}}

## Why an inverse tail appears

Forward log-positive control only sees expansion. For the running generator
\([e^{-1}]\),

\[
\log^+\lVert[e^{-1}]\rVert=0
\]

even though the signed value is \(-1\). Its inverse is \([e]\), whose
log-positive norm is \(1\). In general the integrated inverse budget

\[
J=\int\log^+\lVert A(\omega)^{-1}\rVert\,d\mu(\omega)
\]

gives

\[
-J\le\frac{a_n}{n}.
\]

That finite floor is what prevents the real-valued Fekete sequence from
escaping toward negative infinity.

## In Lean

{{< lean-bridge
  human="Package the finite long-run signed rate from the subadditive integrated sequence and its inverse-tail lower bound."
  math="Define \(\lambda_{\mathrm{real}}\) as the Fekete limit of \(a_n=\int\log\lVert C_n\rVert\,d\mu\), with \(-J\le a_n/n\)."
  lean="def integratedRealLogGrowthRate\n+    (C : DiscreteMatrixCocycle (ι := ι) μ)\n+    (hC : C.HasIntegrableGeneratorLogTails) : ℝ :=\n+  hC.subadditive_integratedRealLogNorm.lim"
>}}
`C` is the cocycle. `hC` stores pointwise invertibility and the integrable
forward and inverse generator tails. The return type `ℝ` records that this is
a finite real rate. `.lim` is Mathlib's Fekete limit for the checked
subadditive sequence.
{{< /lean-bridge >}}

The exact convergence and infimum declarations are
`HasIntegrableGeneratorLogTails.tendsto_normalizedIntegratedRealLogNorm` and
`HasIntegrableGeneratorLogTails.integratedRealLogGrowthRate_eq_sInf`.
Under a pre-ergodic probability base,
`HasIntegrableGeneratorLogTails.ae_tendsto_normalizedRealLogNormObservable`
also identifies this deterministic rate with normalized sample growth almost
everywhere.

{{< repo-check >}}
This full project command checks the Mathlib-backed definition and theorems.
It may require substantial initial disk space and build time. For a
lightweight scalar arithmetic introduction, use the standalone `Std` tutorial
in the linked Deep Dive.
{{< /repo-check >}}

## Boundaries

- At time zero, the normalized expression is totalized as zero. The infimum
  defining the Fekete rate ranges over \(n\ge1\).
- In empty matrix dimension, the checked rate is zero.
- Singular generators are outside this signed theorem; `Real.log 0 = 0` is a
  total-function convention, not a replacement for invertibility.
- If the integrated log-positive growth rate is strictly positive, RMT-35
  proves that it equals the signed rate.
- Almost-everywhere convergence does not imply \(L^1\) convergence or justify
  moving the limit through the integral.

## Related trail markers

- [Integrable generator log tails]({{< relref "/knowledge-base/glossary/integrable-generator-log-tails" >}})
- [Integrated log-positive growth rate]({{< relref "/knowledge-base/glossary/integrated-log-positive-growth-rate" >}})
- [Integrated Real-Log Growth and Signed Kingman Convergence]({{< relref "/knowledge-base/deep-dives/integrated-real-log-growth-and-signed-kingman-convergence" >}})
- [Signed Real-Log Kingman Convergence in Lean]({{< relref "/development-notebook/2026/07/signed-real-log-kingman-convergence-in-lean" >}})

## Reference

J. F. C. Kingman, “The Ergodic Theory of Subadditive Stochastic Processes,”
*Journal of the Royal Statistical Society: Series B* 30(3), 499–510 (1968),
[doi:10.1111/j.2517-6161.1968.tb00749.x](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x).
