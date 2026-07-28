---
title: "Upper Stability of Signed Cocycle Growth in Lean"
slug: "upper-stability-of-signed-cocycle-growth-in-lean"
date: 2026-07-27
weight: -72
author: "tdj28"
summary: "RMT-36 formalizes sequential upper semicontinuity of the signed integrated real-log growth rate under uniform convergence of finite-dimensional matrix generators with shared forward and inverse bounds."
lead: |
  On a one-point probability space, the scalar generators exp(r_j) with r_j tending to r have exact rates r_j tending to r. RMT-36 extracts the robust half of this calculation for general random matrix products. Uniform generator convergence transfers each fixed finite-horizon integral, while the Fekete infimum turns one carefully chosen horizon into an eventual upper bound for the perturbed long-run rates.
key_result: |
  Fix a probability-preserving base. If finite-dimensional measurable matrix generators G_j converge uniformly to G_0, are pointwise invertible, and share uniform bounds on both G_j and G_j inverse, then for every positive epsilon, eventually lambda(G_j) is at most lambda(G_0) plus epsilon. No lower semicontinuity or full continuity is claimed.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Advanced finite-dimensional matrix cocycles, dominated convergence, uniform convergence, and subadditive Fekete rates"
reading_time: "100 to 150 minutes"
prerequisites:
  - "RMT-35 signed integrated real-log growth"
  - "Probability measures and measure-preserving transformations"
  - "Uniform convergence, integrability, and dominated convergence"
lean_module: "NonlinearDynamics.Random.RandomCocycles.GrowthRateStability"
lean_source: "formalization/NonlinearDynamics/Random/RandomCocycles/GrowthRateStability.lean"
lean_snapshot: "/lean/NonlinearDynamics/Random/RandomCocycles/GrowthRateStability.lean"
lean_source_sha256: "ce7cd60eff690b86ef03d1a992be9596afdea1e8cbb1788d25212b5a61030d7f"
tags:
  - "Lean 4"
  - "Random matrix products"
  - "Matrix cocycles"
  - "Upper semicontinuity"
  - "Lyapunov growth"
  - "Dominated convergence"
  - "Stochastic stability"
og_image: "upper-stability-of-signed-cocycle-growth-in-lean-card.png"
og_image_alt: "Warm-paper teaching card showing uniformly convergent generators feeding finite-horizon dominated convergence and then an infimum witness that bounds the perturbed signed growth rates from above."
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

## Start with an exact scalar perturbation

Let the probability space contain one point, let the base map be the identity,
and choose one-by-one generators

\[
G_j=[e^{r_j}],\qquad G_0=[e^r],
\qquad r_j\longrightarrow r.
\]

At horizon \(k\),

\[
G_j^k=[e^{kr_j}],
\qquad
\frac1k\log\lVert G_j^k\rVert=r_j.
\]

Thus the signed integrated growth rate is exactly
\(\lambda(G_j)=r_j\), and these rates converge to
\(\lambda(G_0)=r\). If all \(r_j\) lie in a bounded interval, then both
\(\lVert G_j\rVert\) and \(\lVert G_j^{-1}\rVert\) have common bounds.

This family establishes that the assumptions are compatible with contraction,
neutrality, and expansion. It also exhibits full continuity in one commuting
scalar family. It does not establish continuity for arbitrary matrix
cocycles.

{{< reference-figure
  wide="true"
  src="finite-horizon-witness.svg"
  alt="The scalar generators exp r j converge to exp r and have exact rates r j converging to r. Beside them, a general finite-horizon curve has one selected horizon k whose normalized integral lies below the limiting rate plus a chosen tolerance. Convergence at that horizon transfers the upper bound to perturbed rates."
  caption="**One finite horizon carries the upper estimate:** the scalar family has equality at every horizon. In the general proof, the limiting Fekete infimum supplies one positive horizon \(k\) near \(\lambda(G_0)\). Fixed-horizon convergence transfers that witness to \(G_j\), and every perturbed rate lies below its own horizon-\(k\) value."
>}}

## The selected meaning of stochastic stability

The phrase *stochastic stability* is used for several different questions.
RMT-36 makes one precise choice:

> Sequential upper semicontinuity of the signed integrated real-log growth
> rate as the matrix generator varies uniformly over a fixed
> probability-preserving base.

The base map \(T\), probability measure \(\mu\), matrix dimension, and norm are
fixed. For real constants \(M,K\), every generator in the sequence satisfies

\[
\lVert G_j(\omega)\rVert\le M,\qquad
\lVert G_j(\omega)^{-1}\rVert\le K
\]

at every sample point, and every \(G_j(\omega)\) is invertible. Uniform
convergence means

\[
\sup_\omega\lVert G_j(\omega)-G_0(\omega)\rVert\longrightarrow0.
\]

The conclusion is

\[
\forall\varepsilon\gt0,\quad
\lambda(G_j)\le\lambda(G_0)+\varepsilon
\quad\text{for all sufficiently large }j.
\]

Equivalently,
\(\limsup_j\lambda(G_j)\le\lambda(G_0)\). This is an upper bound on
perturbed rates. It is not a matching lower bound.

## Why fixed horizons converge

The cocycle product at horizon \(k\) is

\[
C_j^k(\omega)=
G_j(T^{k-1}\omega)\cdots G_j(T\omega)G_j(\omega).
\]

For a fixed \(k\), uniform generator convergence gives convergence of each
factor at each of the finitely many orbit points. Continuity of matrix
multiplication then gives

\[
C_j^k(\omega)\longrightarrow C_0^k(\omega).
\]

This is
`UniformlyBoundedInvertibleGenerator.tendsto_value_of_tendstoUniformly`.
Pointwise invertibility makes every finite product nonzero, so continuity of
the real logarithm yields

\[
\log\lVert C_j^k(\omega)\rVert
\longrightarrow
\log\lVert C_0^k(\omega)\rVert.
\]

The Lean declaration is
`UniformlyBoundedInvertibleGenerator.tendsto_realLogNormObservable_of_tendstoUniformly`.

Pointwise convergence is not enough to move through the integral. The common
two-sided generator bounds give the horizon-\(k\) estimate

\[
\left|\log\lVert C_j^k(\omega)\rVert\right|
\le k\bigl(\log^+M+\log^+K\bigr).
\]

This is
`UniformlyBoundedInvertibleGenerator.abs_realLogNormObservable_le`.
The right side is a constant integrable function on a finite measure space.
Dominated convergence therefore gives

\[
\int\log\lVert C_j^k\rVert\,d\mu
\longrightarrow
\int\log\lVert C_0^k\rVert\,d\mu,
\]

formalized as
`UniformlyBoundedInvertibleGenerator.tendsto_integratedRealLogNorm_of_tendstoUniformly`.

{{< lean-bridge
  human="Uniform generator convergence transfers each fixed finite product, and shared forward and inverse bounds provide one integrable absolute bound for its signed log norm."
  math="For fixed \(k\), \(C_j^k(\omega)\to C_0^k(\omega)\) and \(\lvert\log\lVert C_j^k(\omega)\rVert\rvert\le k(\log^+M+\log^+K)\), hence \(\int\log\lVert C_j^k\rVert\,d\mu\to\int\log\lVert C_0^k\rVert\,d\mu\)."
  lean="tendsto_integratedRealLogNorm_of_tendstoUniformly\n    (hT : MeasurePreserving T μ μ)\n    (hG : TendstoUniformly\n      (fun n ↦ (G n : Ω → Matrix ι ι ℂ)) G₀ atTop)\n    (k : ℕ)"
>}}
`TendstoUniformly` is convergence uniform in `ω`. `k` is fixed before the
limit in the perturbation index `n` is taken. The common constants `M` and
`K` are parameters of the generator bundle, so the dominator does not depend
on `n`.
{{< /lean-bridge >}}

## Why an infimum gives only the upper half

RMT-35 identifies the signed rate with a positive-horizon Fekete infimum:

\[
\lambda(G)=\inf_{k\ge1}
\frac1k\int\log\lVert C_G^k(\omega)\rVert\,d\mu(\omega).
\]

Given a real \(y\gt\lambda(G_0)\), convergence of the normalized finite-horizon
sequence for \(G_0\) supplies some positive \(k\) with

\[
\frac1k\int\log\lVert C_0^k\rVert\,d\mu\lt y.
\]

Fixed-horizon dominated convergence makes the same strict inequality true for
\(G_j\) once \(j\) is large. Since an infimum is no larger than any one of its
terms,

\[
\lambda(G_j)
\le \frac1k\int\log\lVert C_j^k\rVert\,d\mu
\lt y.
\]

That argument is
`UniformlyBoundedInvertibleGenerator.eventually_integratedRealLogGrowthRate_lt`.
Choosing \(y=\lambda(G_0)+\varepsilon\) gives
`UniformlyBoundedInvertibleGenerator.eventually_integratedRealLogGrowthRate_le_add`.

{{< reference-figure
  wide="true"
  src="upper-not-lower.svg"
  alt="A horizontal roof at lambda zero plus epsilon blocks the eventually perturbed rates from above. Several rates may remain well below the limiting rate, illustrating that the theorem does not give a lower bound or full continuity."
  caption="**Upper does not mean two-sided:** every sufficiently late perturbed rate stays below the \(\lambda(G_0)+\varepsilon\) roof. The proof permits downward displacement because an infimum transfers upper witnesses but does not provide a common lower witness."
>}}

## The formal interface

`UniformlyBoundedInvertibleGenerator` packages a measurable generator,
pointwise matrix invertibility, the bound by `M`, and the inverse bound by
`K`. Its coercion lets the bundle be used as a function.

`UniformlyBoundedInvertibleGenerator.toCocycle` installs the generator over a
fixed measure-preserving base.
`UniformlyBoundedInvertibleGenerator.hasIntegrableGeneratorLogTails`
derives the RMT-35 two-sided one-step integrability package on a finite measure
space.
`UniformlyBoundedInvertibleGenerator.integratedRealLogGrowthRate` then names
the signed integrated Fekete rate of the resulting cocycle.

{{< lean-bridge
  human="Every positive tolerance eventually bounds the perturbed signed rates by the limiting signed rate plus that tolerance."
  math="If \(G_j\to G_0\) uniformly within one shared two-sided bounded invertible class, then \(\forall\varepsilon>0,\ \lambda(G_j)\le\lambda(G_0)+\varepsilon\) eventually."
  lean="theorem eventually_integratedRealLogGrowthRate_le_add\n    [IsProbabilityMeasure μ]\n    (hT : MeasurePreserving T μ μ)\n    (hG : TendstoUniformly\n      (fun n ↦ (G n : Ω → Matrix ι ι ℂ)) G₀ atTop)\n    {ε : ℝ} (hε : 0 < ε) :\n    ∀ᶠ n in atTop,\n      (G n).integratedRealLogGrowthRate hT ≤\n        G₀.integratedRealLogGrowthRate hT + ε"
>}}
`∀ᶠ n in atTop` means that the property holds for every sufficiently large
natural number `n`. The theorem is sequential because perturbations are
indexed by `ℕ`. `IsProbabilityMeasure μ` fixes total mass one.
{{< /lean-bridge >}}

## A lightweight standalone tutorial

The following `Std` file checks the scalar perturbation arithmetic without
matrices, topology, or measure theory:

```lean
import Std

def scalarRate (r : Int) : Int := r

example (j : Nat) : scalarRate (5 - (j : Int)) = 5 - (j : Int) := by
  rfl

example (ε : Nat) (hε : 0 < ε) :
    scalarRate 2 ≤ scalarRate 2 + (ε : Int) := by
  simp [scalarRate, Int.ofNat_pos.mpr hε]
```

Save it as `UpperStabilityTutorial.lean`, then run on macOS or Linux:

```text
lean UpperStabilityTutorial.lean
```

This standalone tutorial checks only integer identities modeling an exact
scalar rate and a positive upper tolerance. It does not establish uniform
matrix convergence, dominated convergence, or a Fekete-rate theorem.

{{< repo-check >}}
This full project command checks the exact Mathlib-backed matrix-cocycle
module. It may require substantial initial disk space and build time. Lean's
elaborator constructs candidate proof terms and the kernel checks them against
the formal declarations. That check does not by itself audit whether the
formal statement matches a proposed scientific application. The displayed
portable command runs `lake env lean` from the repository's `formalization`
directory with warnings treated as errors.
{{< /repo-check >}}

## Complete public declaration map

| Layer | Public declarations |
|---|---|
| Perturbation bundle | `UniformlyBoundedInvertibleGenerator`; `UniformlyBoundedInvertibleGenerator.toCocycle`; `UniformlyBoundedInvertibleGenerator.hasIntegrableGeneratorLogTails`; `UniformlyBoundedInvertibleGenerator.integratedRealLogGrowthRate` |
| Fixed products and observables | `UniformlyBoundedInvertibleGenerator.tendsto_value_of_tendstoUniformly`; `UniformlyBoundedInvertibleGenerator.tendsto_realLogNormObservable_of_tendstoUniformly`; `UniformlyBoundedInvertibleGenerator.abs_realLogNormObservable_le`; `UniformlyBoundedInvertibleGenerator.tendsto_integratedRealLogNorm_of_tendstoUniformly` |
| Upper stability | `UniformlyBoundedInvertibleGenerator.eventually_integratedRealLogGrowthRate_lt`; `UniformlyBoundedInvertibleGenerator.eventually_integratedRealLogGrowthRate_le_add` |

## Decision ledger and exact nonclaims

The selected theorem concerns the growth-rate functional of a random matrix
cocycle under perturbation of its generator. It does not formalize the
zero-noise convergence of stationary measures sometimes called stochastic
stability. It also does not formalize upper semicontinuity of random
attractors in a set distance. Those are different state spaces, outputs, and
hypotheses.

Within the selected cocycle setting, RMT-36 supplies no lower
semicontinuity, full continuity, quantitative modulus, convergence rate,
varying base map, varying probability measure, singular generator limit,
infinite-dimensional operator result, Lyapunov spectrum, Oseledets splitting,
invariant subspace stability, or random-attractor statement.

The shared inverse bound is not decorative. It prevents finite products from
approaching singular collapse without control and supplies the negative half
of the dominated-convergence envelope. Pointwise invertibility is still
recorded separately because Lean's total matrix inverse is defined even for a
singular matrix.

## References

1. J. F. C. Kingman, “The Ergodic Theory of Subadditive Stochastic
   Processes,” *Journal of the Royal Statistical Society: Series B* 30(3),
   499–510 (1968),
   [doi:10.1111/j.2517-6161.1968.tb00749.x](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x).
2. J. Bochi, “Genericity of zero Lyapunov exponents,” *Ergodic Theory and
   Dynamical Systems* 22(6), 1667–1696 (2002),
   [doi:10.1017/S0143385702001165](https://doi.org/10.1017/S0143385702001165).
   The paper provides a continuous-cocycle setting in which integrated top
   exponents are treated as an upper-semicontinuous functional.
3. L. Backes, A. Brown, and C. Butler, “Continuity of Lyapunov exponents for
   cocycles with invariant holonomies,” *Journal of Modern Dynamics* 12,
   223–260 (2018),
   [doi:10.3934/jmd.2018009](https://doi.org/10.3934/jmd.2018009).
4. M. Viana and J. Yang, “Continuity of Lyapunov exponents in the
   \(C^0\) topology,” *Israel Journal of Mathematics* 229, 461–485 (2019),
   [doi:10.1007/s11856-018-1809-7](https://doi.org/10.1007/s11856-018-1809-7).
   References 3 and 4 illustrate that stronger continuity conclusions require
   additional dynamical structure or hypotheses absent from RMT-36.
5. J. F. Alves, V. Araújo, and C. H. Vásquez, “Stochastic stability of
   diffeomorphisms with dominated splitting,”
   [arXiv:math/0404160](https://arxiv.org/abs/math/0404160).
   This is a primary-source example of the distinct zero-noise
   stationary-measure usage.
6. J. C. Robinson, “Stability of random attractors under perturbation and
   approximation,” *Journal of Differential Equations* 186(2), 652–669
   (2002),
   [doi:10.1016/S0022-0396(02)00038-4](https://doi.org/10.1016/S0022-0396(02)00038-4).
   This reference represents a distinct attractor upper-semicontinuity
   setting, not the cocycle-rate theorem formalized here.
7. [Upper semicontinuity]({{< relref "/knowledge-base/glossary/upper-semicontinuity" >}}).
8. [Upper Stability of Signed Integrated Cocycle Growth]({{< relref "/knowledge-base/deep-dives/upper-stability-of-signed-integrated-cocycle-growth" >}}).
