---
title: "Upper Stability of Signed Integrated Cocycle Growth"
slug: "upper-stability-of-signed-integrated-cocycle-growth"
date: 2026-07-27
summary: "A worked scalar perturbation leads to the finite-horizon dominated-convergence and Fekete-infimum mechanism behind RMT-36."
lead: "Uniformly convergent bounded invertible generators have convergent signed log integrals at every fixed horizon. Because the long-run signed rate is the infimum of those normalized integrals, one finite-horizon witness gives sequential upper semicontinuity."
draft: false
pro_reviewed: false
level: "Advanced matrix cocycles, uniform convergence, dominated convergence, and subadditive rates"
reading_time: "120 to 180 minutes"
prerequisites: "Probability measures, measurable functions, matrix products, operator norms, real logarithms, and Fekete's lemma"
lean_module: "NonlinearDynamics.Random.RandomCocycles.GrowthRateStability"
lean_snapshot: "/lean/NonlinearDynamics/Random/RandomCocycles/GrowthRateStability.lean"
lean_source_sha256: "ce7cd60eff690b86ef03d1a992be9596afdea1e8cbb1788d25212b5a61030d7f"
toc: true
og_image: "upper-stability-of-signed-integrated-cocycle-growth-card.png"
og_image_alt: "Textbook card showing uniform convergence of generators, fixed-product convergence, dominated convergence of finite-horizon integrals, and an infimum witness producing an upper bound on long-run signed rates."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note. Human review
of the mathematics, exposition, sources, Lean interpretation, and
accessibility remains pending. The configured Pro review has not been
performed, and `pro_reviewed` remains false.
{{< /panel >}}

## A calculation before the general statement

On the one-point probability space with identity base, choose
\(G_j=[e^{2+1/(j+1)}]\) and \(G_0=[e^2]\). Every positive horizon \(k\)
has

\[
\frac1k\log\lVert G_j^k\rVert=2+\frac1{j+1},
\qquad
\frac1k\log\lVert G_0^k\rVert=2.
\]

The exact rates converge from above to \(2\). All generators and inverses have
common norm bounds. Replacing \(2\) with a negative number gives the same
calculation in the contracting regime.

This example makes three roles visible. The perturbation index \(j\) varies
the generator. The horizon \(k\) measures cocycle time. The output
\(\lambda(G_j)\) is a deterministic number obtained after integration and a
long-horizon Fekete limit. These indices and operations cannot be exchanged
without justification.

## The theorem in mathematical language

Fix a probability space \((\Omega,\mu)\), a measure-preserving map
\(T:\Omega\to\Omega\), and a finite matrix dimension. Let \(G_j\) and \(G_0\)
be measurable matrix-valued functions such that:

1. \(G_j(\omega)\) is invertible for every \(j,\omega\);
2. \(\lVert G_j(\omega)\rVert\le M\) for one common \(M\);
3. \(\lVert G_j(\omega)^{-1}\rVert\le K\) for one common \(K\); and
4. \(G_j\to G_0\) uniformly on \(\Omega\).

Then

\[
\limsup_{j\to\infty}\lambda(G_j)\le\lambda(G_0),
\]

where \(\lambda(G)\) is the signed integrated real-log Fekete rate from
RMT-35.

{{< reference-figure
  wide="true"
  src="three-layer-stability-proof.svg"
  alt="A four-stage diagram sends uniform generator convergence to convergence of fixed cocycle products, then through a common absolute bound to dominated convergence of finite-horizon integrals, and finally through a selected Fekete infimum witness to an eventual upper bound on the rates."
  caption="**Proof architecture:** the first three stages preserve a fixed horizon. Only the last stage uses long-time structure, selecting one horizon from the limiting Fekete infimum and using it as a common upper witness."
>}}

## Layer one: finite products

For fixed \(k\),

\[
C_j^k(\omega)=
G_j(T^{k-1}\omega)\cdots G_j(\omega).
\]

There are only \(k\) factors. Uniform convergence supplies convergence at
every displayed orbit point, and continuity of multiplication transfers it to
the product. The theorem
`tendsto_value_of_tendstoUniformly` proves this by induction on \(k\).

Pointwise invertibility matters before taking the logarithm. It guarantees
\(\lVert C_0^k(\omega)\rVert\ne0\), which is the continuity domain needed for
\(\log\lVert\cdot\rVert\).

## Layer two: a two-sided envelope

The forward bound gives

\[
\log\lVert C_j^k(\omega)\rVert\le k\log^+M.
\]

The inverse product gives the lower estimate

\[
-k\log^+K\le\log\lVert C_j^k(\omega)\rVert.
\]

Together,

\[
\left|\log\lVert C_j^k(\omega)\rVert\right|
\le k(\log^+M+\log^+K).
\]

The right side depends on \(k\) but not on \(j\) or \(\omega\). For each fixed
horizon it is integrable on the probability space, so dominated convergence
transfers the finite-horizon signed integrals.

The inverse bound is essential for this proof. A forward bound alone controls
large positive log norms but does not control near-singular contraction and
large negative log norms.

{{< lean-bridge
  human="Shared forward and inverse bounds convert pointwise convergence of fixed products into convergence of their signed log-norm integrals."
  math="\(\lvert\log\lVert C_j^k\rVert\rvert\le k(\log^+M+\log^+K)\) and pointwise convergence imply \(a_k(G_j)\to a_k(G_0)\) by dominated convergence."
  lean="abs_realLogNormObservable_le G hT k ω\n\ntendsto_integratedRealLogNorm_of_tendstoUniformly hT hG k"
>}}
The first line supplies a pointwise absolute bound. The second applies the
measure-theoretic dominated-convergence theorem. Both live in the namespace
`UniformlyBoundedInvertibleGenerator`.
{{< /lean-bridge >}}

## Layer three: the infimum witness

Write

\[
q_k(G)=\frac1k\int\log\lVert C_G^k\rVert\,d\mu.
\]

RMT-35 proves

\[
\lambda(G)=\inf_{k\ge1}q_k(G).
\]

Choose \(y\gt\lambda(G_0)\). By convergence of \(q_k(G_0)\) to its Fekete rate,
some positive \(k\) satisfies \(q_k(G_0)\lt y\). Layer two gives
\(q_k(G_j)\lt y\) eventually. Finally,

\[
\lambda(G_j)\le q_k(G_j)\lt y.
\]

The proof does not need convergence to be uniform in the horizon \(k\).
Selecting one horizon before transferring it is the key economy.

## In Lean

{{< lean-bridge
  human="The rate functional cannot eventually cross any strict upper threshold above its limiting value."
  math="If \(\lambda(G_0)<y\), then \(\lambda(G_j)<y\) for all sufficiently large \(j\)."
  lean="theorem eventually_integratedRealLogGrowthRate_lt\n    [IsProbabilityMeasure μ]\n    (hT : MeasurePreserving T μ μ)\n    (hG : TendstoUniformly\n+      (fun n ↦ (G n : Ω → Matrix ι ι ℂ)) G₀ atTop)\n+    (hy : G₀.integratedRealLogGrowthRate hT < y) :\n+    ∀ᶠ n in atTop,\n+      (G n).integratedRealLogGrowthRate hT < y"
>}}
`hy` chooses the strict upper threshold. The conclusion is an eventual
statement in the perturbation index. `MeasurePreserving` fixes both the base
and the measure throughout the sequence.
{{< /lean-bridge >}}

{{< repo-check >}}
This full project command checks the exact finite-dimensional
Mathlib-backed theorem. Its setup may consume substantial disk space and build
time. The command checks the formal statement and proof term, not the
scientific adequacy of applying that statement to a particular model.
{{< /repo-check >}}

## Which stochastic-stability question?

{{< reference-figure
  wide="true"
  src="stability-meaning-fork.svg"
  alt="A fork separates three meanings of stochastic stability. The highlighted branch varies a matrix generator and studies a signed integrated growth rate. The other branches vary noise and study stationary measures, or vary a random system and study attractor sets."
  caption="**Three outputs, three theorems:** RMT-36 selects the cocycle-rate branch. Zero-noise stationary-measure stability and random-attractor upper semicontinuity require different definitions and are not consequences of this result."
>}}

The selected branch varies a generator and outputs one real number. In
zero-noise stochastic stability, the perturbation parameter often changes a
Markov process or random perturbation and the output is a stationary measure.
In random-attractor stability, the output is a random set compared using a
set distance. Sharing a phrase does not identify these mathematical objects.

## What upper semicontinuity permits

Upper semicontinuity prohibits late rates from remaining above
\(\lambda(G_0)+\varepsilon\). It permits lower rates. The Fekete formula
explains the asymmetry: an infimum has readily transferable upper witnesses,
while lower bounds must control every horizon at once or use additional
structure.

The result therefore supplies no lower semicontinuity, full continuity,
modulus of continuity, or convergence rate. It also does not vary the base or
measure, admit a singular limit, identify the remaining Lyapunov spectrum, or
control invariant splittings.

## Related trail markers

- [Upper semicontinuity]({{< relref "/knowledge-base/glossary/upper-semicontinuity" >}})
- [Integrated real-log growth rate]({{< relref "/knowledge-base/glossary/integrated-real-log-growth-rate" >}})
- [Probability measure]({{< relref "/knowledge-base/glossary/probability-measure" >}})
- [Measure-preserving transformation]({{< relref "/knowledge-base/glossary/measure-preserving-transformation" >}})
- [Upper Stability of Signed Cocycle Growth in Lean]({{< relref "/development-notebook/2026/07/upper-stability-of-signed-cocycle-growth-in-lean" >}})

## References

1. J. F. C. Kingman, “The Ergodic Theory of Subadditive Stochastic
   Processes,” *Journal of the Royal Statistical Society: Series B* 30(3),
   499–510 (1968),
   [doi:10.1111/j.2517-6161.1968.tb00749.x](https://doi.org/10.1111/j.2517-6161.1968.tb00749.x).
2. J. Bochi, “Genericity of zero Lyapunov exponents,” *Ergodic Theory and
   Dynamical Systems* 22(6), 1667–1696 (2002),
   [doi:10.1017/S0143385702001165](https://doi.org/10.1017/S0143385702001165).
3. L. Backes, A. Brown, and C. Butler, “Continuity of Lyapunov exponents for
   cocycles with invariant holonomies,” *Journal of Modern Dynamics* 12,
   223–260 (2018),
   [doi:10.3934/jmd.2018009](https://doi.org/10.3934/jmd.2018009).
4. M. Viana and J. Yang, “Continuity of Lyapunov exponents in the
   \(C^0\) topology,” *Israel Journal of Mathematics* 229, 461–485 (2019),
   [doi:10.1007/s11856-018-1809-7](https://doi.org/10.1007/s11856-018-1809-7).
5. J. F. Alves, V. Araújo, and C. H. Vásquez, “Stochastic stability of
   diffeomorphisms with dominated splitting,”
   [arXiv:math/0404160](https://arxiv.org/abs/math/0404160).
6. J. C. Robinson, “Stability of random attractors under perturbation and
   approximation,” *Journal of Differential Equations* 186(2), 652–669
   (2002),
   [doi:10.1016/S0022-0396(02)00038-4](https://doi.org/10.1016/S0022-0396(02)00038-4).
