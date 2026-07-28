---
title: "Upper semicontinuity"
slug: "upper-semicontinuity"
summary: "Upper semicontinuity means that nearby function values cannot remain substantially above the value at the limiting input; downward jumps may still occur."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Random.RandomCocycles.GrowthRateStability"
lean_snapshot: "/lean/NonlinearDynamics/Random/RandomCocycles/GrowthRateStability.lean"
lean_source_sha256: "ce7cd60eff690b86ef03d1a992be9596afdea1e8cbb1788d25212b5a61030d7f"
og_image: "upper-semicontinuity-card.png"
og_image_alt: "A glossary teaching card showing nearby values below an epsilon roof over the limiting function value, while a downward jump remains permitted."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note.
`pro_reviewed` remains false. Human review of the mathematics, Lean
interpretation, source use, and accessibility remains pending.
{{< /panel >}}

Consider

\[
f(x)=
\begin{cases}
1,&x=0,\\
0,&x\ne0.
\end{cases}
\]

If \(x_j\to0\), then \(f(x_j)\le1=f(0)\), so

\[
\limsup_{j\to\infty}f(x_j)\le f(0).
\]

The function is upper semicontinuous at zero even though it is not continuous
there. Its values may jump downward away from zero. Reversing the two values
would create an upward jump at zero and would fail upper semicontinuity.

## Definition

A real-valued function \(f:X\to\mathbb R\) is **sequentially upper
semicontinuous at \(x\)** when every sequence \(x_j\to x\) satisfies

\[
\limsup_{j\to\infty}f(x_j)\le f(x).
\]

An equivalent epsilon formulation is:

\[
\forall\varepsilon\gt0,\quad
f(x_j)\le f(x)+\varepsilon
\quad\text{for all sufficiently large }j.
\]

In general topological spaces, the neighborhood or filter definition is the
primary one. The sequential definition completely detects the topology in
metric and first-countable settings, but not in every topological space.

{{< reference-figure
  wide="true"
  src="upper-semicontinuity-roof.svg"
  alt="A point at x has height f of x. Nearby function values remain below the horizontal roof f of x plus epsilon. One nearby value lies far below f of x, showing that downward jumps are allowed."
  caption="**The epsilon roof:** nearby values must eventually stay below \(f(x)+\varepsilon\). Upper semicontinuity does not place a matching floor under them, so it does not imply continuity."
>}}

## In RMT-36

The input is a measurable finite-dimensional matrix generator over one fixed
probability-preserving base. The output is its signed integrated real-log
growth rate \(\lambda(G)\). RMT-36 proves the sequential statement

\[
G_j\longrightarrow G_0\ \text{uniformly}
\quad\Longrightarrow\quad
\forall\varepsilon\gt0,\quad
\lambda(G_j)\le\lambda(G_0)+\varepsilon
\ \text{eventually},
\]

within a class having shared forward and inverse norm bounds and pointwise
invertibility.

{{< lean-bridge
  human="No positive tolerance above the limiting rate is crossed by all sufficiently late perturbed rates."
  math="\(\forall\varepsilon>0,\ \lambda(G_j)\le\lambda(G_0)+\varepsilon\) eventually."
  lean="eventually_integratedRealLogGrowthRate_le_add\n  hT hG hε"
>}}
`hT` fixes the probability-preserving base. `hG` is uniform convergence of
the generators. `hε : 0 < ε` records that the tolerance is positive.
`eventually` is expressed in the theorem by the filter notation
`∀ᶠ n in atTop`.
{{< /lean-bridge >}}

{{< repo-check >}}
This full project command checks the exact matrix-cocycle upper-stability
theorem. It can require substantial disk space and build time. The theorem is
sequential and one-sided; the command does not check a full-continuity claim.
{{< /repo-check >}}

## Why infima often produce upper semicontinuity

Suppose

\[
f(x)=\inf_{k\ge1}q_k(x)
\]

and each fixed \(q_k\) is continuous. If \(y\gt f(x)\), one index \(k\) has
\(q_k(x)\lt y\). Continuity preserves that strict inequality near \(x\), and
\(f\le q_k\) transfers it to \(f\). This selects one upper witness.

RMT-36 follows exactly this pattern. The functions \(q_k\) are normalized
finite-horizon signed log-norm integrals, and dominated convergence supplies
their sequential continuity.

## Boundaries

- Upper semicontinuity controls upward displacement, not downward
  displacement.
- It does not imply lower semicontinuity or continuity.
- A sequential theorem should not be silently promoted to a theorem for all
  nets in an arbitrary topology.
- RMT-36 varies the matrix generator only. It does not vary the base map or
  probability measure.
- The term *stochastic stability* may instead concern stationary measures or
  random attractors. Those are different outputs.

## Related trail markers

- [Limit superior]({{< relref "/knowledge-base/glossary/limit-superior" >}})
- [Integrated real-log growth rate]({{< relref "/knowledge-base/glossary/integrated-real-log-growth-rate" >}})
- [Upper Stability of Signed Integrated Cocycle Growth]({{< relref "/knowledge-base/deep-dives/upper-stability-of-signed-integrated-cocycle-growth" >}})
- [Upper Stability of Signed Cocycle Growth in Lean]({{< relref "/development-notebook/2026/07/upper-stability-of-signed-cocycle-growth-in-lean" >}})

## References

1. J. Bochi, “Genericity of zero Lyapunov exponents,” *Ergodic Theory and
   Dynamical Systems* 22(6), 1667–1696 (2002),
   [doi:10.1017/S0143385702001165](https://doi.org/10.1017/S0143385702001165).
2. L. Backes, A. Brown, and C. Butler, “Continuity of Lyapunov exponents for
   cocycles with invariant holonomies,” *Journal of Modern Dynamics* 12,
   223–260 (2018),
   [doi:10.3934/jmd.2018009](https://doi.org/10.3934/jmd.2018009).
