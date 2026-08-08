---
title: "Continuous-time stability"
slug: "continuous-time-stability"
summary: "Continuous-time forward stability uses one initial neighborhood to control nearby trajectories for every nonnegative real time."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.ODE.Stability"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/ODE/Stability.lean"
lean_source_sha256: "270cf7a6d17f11af10c421a4351ce4c96b1cd6df59f806713317e25237c5a6c6"
tags:
  - "Continuous-time dynamics"
  - "Stability"
  - "Flows"
  - "Equicontinuity"
og_image: "continuous-time-stability-card.png"
og_image_alt: "One initial delta interval controls an epsilon tube around a moving reference trajectory for every nonnegative real time."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note. Its source
passes its warning-fatal Lean 4.32.0 leaf, deterministic aggregator, and
complete repository gate; the paired pages also pass desktop and mobile
browser inspection. Professional review has not been performed, so
`pro_reviewed` remains false.
{{< /panel >}}

**Continuous-time forward stability** means that one sufficiently small
initial perturbation remains uniformly small relative to a reference
trajectory at every nonnegative real time.

## Start with translation

For the real {{< refterm "flow" "flow" >}}

\[
\Phi(t,x)=x+2t,
\]

take \(p=4\) and \(x=4.1\). Then

\[
|\Phi(t,x)-\Phi(t,p)|=0.1
\]

for every real \(t\). More generally, choosing
\(\delta=\varepsilon\) shows that every start satisfying
\(|x-p|\lt\delta\) stays within \(\varepsilon\) of the moving reference orbit
for every \(t\ge0\).

This establishes forward stability of this translation flow. When the
velocity is nonzero, it is also a counterexample to the claim that a stable
reference point must be an equilibrium.

{{< reference-figure
  wide="true"
  src="continuous-time-stability-tube.svg"
  alt="A delta interval around the initial reference state becomes a continuous epsilon tube centered on a moving orbit for every time at or after zero."
  caption="**One neighborhood, all forward real times:** the tube follows the reference orbit. Its center may move, and the statement does not say that neighboring trajectories approach the center."
>}}

## Definition

For a metric-space flow \(\Phi\), forward stability at \(p\) is

\[
\forall\varepsilon\gt0\;\exists\delta\gt0\;\forall x,
d(x,p)\lt\delta\Longrightarrow
\forall t\ge0,
d(\Phi(t,p),\Phi(t,x))\lt\varepsilon.
\]

The quantifier order is essential. One \(\delta\) must work for the entire
continuum of forward times. A radius chosen separately for each \(t\) gives
continuity of individual time maps, not forward stability.

In a uniform space, the same definition uses entourages rather than numeric
distances. It is equicontinuity at \(p\) of all nonnegative-time maps.

## Equilibrium and attraction are separate

An equilibrium satisfies \(\Phi(t,p)=p\) for every real \(t\). A
**Lyapunov-stable equilibrium** is an equilibrium that is also forward stable.

Attraction instead asks for a limit:

\[
\Phi(t,x)\to p\qquad(t\to+\infty).
\]

The {{< refterm "basin-of-attraction" "basin of attraction" >}} contains the
starts with that limit. An asymptotically stable equilibrium has both
Lyapunov stability and a basin containing a neighborhood of the equilibrium.

The identity flow is the nearby boundary case. Every point is a stable
equilibrium, but a distinct constant orbit does not approach it. Thus
stability does not imply attraction.

## In Lean

{{< lean-bridge
  human="All nonnegative real-time maps of the flow are equicontinuous together at p."
  math="\(\operatorname{EquicontinuousAt}((\Phi_t)_{t\ge0},p).\)"
  lean="def IsForwardStableAt [UniformSpace X] (ϕ : Flow ℝ X) (p : X) : Prop := EquicontinuousAt (fun t : AddSubmonoid.nonneg ℝ ↦ ϕ t) p"
>}}
`Flow ℝ X` is the jointly continuous real-time action.
`AddSubmonoid.nonneg ℝ` is the subtype of real numbers satisfying (0\le t).
`EquicontinuousAt` places one source neighborhood before the quantifier over
that subtype.
{{< /lean-bridge >}}

The metric theorem `isForwardStableAt_iff_dist` translates this definition to
epsilon and delta. `IsLyapunovStableEquilibrium` adds `IsEquilibrium` as a
separate conjunct.

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.ODE.Stability

open NonlinearDynamics.Deterministic.ODE

#check IsForwardStableAt
#check isForwardStableAt_iff_dist
#check IsEquilibrium
#check IsLyapunovStableEquilibrium
#check forwardStableAt_translationFlow_not_equilibrium
#check isAttractedTo_id_iff
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
The command checks the complete module with warnings treated as errors. It
does not numerically simulate a trajectory.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/ODE/Stability.lean
```

## Boundaries

- Forward time is \(t\ge0\), including zero; negative times are not part of
  the stability quantifier.
- The reference orbit may move.
- Stability means remaining close, not converging.
- The definition fixes one flow. Structural stability compares different
  flows, while stochastic stability needs an explicitly chosen random object
  and perturbation topology.
- No attraction rate, Lyapunov function, or physical-model validity follows
  from the definition.

Continue with [Continuous-Time Stability, Attraction, and
Equilibria]({{< relref
"/knowledge-base/deep-dives/continuous-time-stability-attraction-and-equilibria"
>}}) or inspect the declaration-complete [Development Notebook entry]({{<
relref
"/development-notebook/2026/08/stability-and-attraction-for-ode-flows-in-lean"
>}}).

## References

- N. P. Bhatia and G. P. Szegő, *Dynamical Systems: Stability Theory and
  Applications*, Lecture Notes in Mathematics 35, Springer, 1967,
  [doi:10.1007/BFb0080630](https://doi.org/10.1007/BFb0080630).
- J. P. LaSalle, *The Stability of Dynamical Systems*, SIAM CBMS 25, 1976,
  [doi:10.1137/1.9781611970432](https://doi.org/10.1137/1.9781611970432).
- Mathlib contributors,
  [`Mathlib.Dynamics.Flow`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/Flow.lean)
  and
  [`Metric equicontinuity`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Topology/MetricSpace/Equicontinuity.lean),
  version 4.32.0.
