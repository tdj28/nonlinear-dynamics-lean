---
title: "Continuous-Time Stability, Attraction, and Equilibria"
slug: "continuous-time-stability-attraction-and-equilibria"
date: 2026-08-07
summary: "A real flow separates orbitwise forward stability, fixed equilibria, long-time attraction, and the conjunction called asymptotic stability."
lead: "Use translation and identity flows to see why staying close, remaining fixed, and approaching a target are three different mathematical statements."
draft: false
pro_reviewed: false
level: "Intermediate dynamical systems and topology"
reading_time: "30 to 45 minutes"
prerequisites: "Flows and metric-space limits are introduced through examples"
lean_module: "NonlinearDynamics.Deterministic.ODE.Stability"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/ODE/Stability.lean"
lean_source_sha256: "270cf7a6d17f11af10c421a4351ce4c96b1cd6df59f806713317e25237c5a6c6"
toc: true
og_image: "continuous-time-stability-attraction-and-equilibria-card.png"
og_image_alt: "A continuous forward-time tube follows a moving orbit, while equilibrium and attraction remain separate gates before asymptotic stability."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note. The source
passes its warning-fatal Lean 4.32.0 leaf, deterministic aggregator, and
complete repository gate; the paired pages also pass desktop and mobile
browser inspection. Professional review remains pending, so `pro_reviewed`
remains false.
{{< /panel >}}

## Start with a moving stable orbit

Fix \(c=3\) and define a {{< refterm "flow" "flow" >}} on the real line by

\[
\Phi(t,x)=x+3t.
\]

Take \(p=1\) and \(x=1.2\). For every real time,

\[
|\Phi(t,x)-\Phi(t,p)|=|(1.2+3t)-(1+3t)|=0.2.
\]

One initial error stays unchanged for the complete orbit. The reference point
is forward stable. It is not an equilibrium, since
\(\Phi(1,p)=p+3\ne p\).

{{< reference-figure
  wide="true"
  src="moving-orbit-tube.svg"
  alt="Two parallel translation trajectories begin 0.2 units apart and remain inside one tube for every nonnegative real time, although neither trajectory is stationary."
  caption="**Stable moving reference orbit:** a single initial tolerance controls a continuum of forward times. Constant separation gives stability, not convergence and not equilibrium."
>}}

## The quantifiers define the property

For a flow \(\Phi:\mathbb R\times X\to X\) on a metric space, forward stability
at \(p\) means

\[
\forall\varepsilon\gt0\;\exists\delta\gt0\;\forall x,
d(x,p)\lt\delta\Longrightarrow
\forall t\ge0,\quad
d(\Phi(t,p),\Phi(t,x))\lt\varepsilon.
\]

The same \(\delta\) must control every nonnegative real time. Proving
continuity separately for each fixed \(t\) would permit a time-dependent
radius and would not establish this statement.

The formal definition uses equicontinuity of the family
\((\Phi_t)_{t\ge0}\). A uniform space supplies a notion of closeness without
choosing a metric; a pseudo-metric space recovers the displayed formula.

## Equilibrium freezes the reference orbit

An equilibrium \(p\) satisfies

\[
\Phi(t,p)=p\qquad\text{for every }t\in\mathbb R.
\]

For a real flow, it is enough to check nonnegative times. If \(t\lt0\), apply the
positive-time identity at \(-t\) and the composition law
\(\Phi(t,\Phi(-t,p))=\Phi(0,p)\).

At an equilibrium, forward stability reduces to

\[
d(x,p)\lt\delta\Longrightarrow d(\Phi(t,x),p)\lt\varepsilon
\quad(t\ge0).
\]

The project calls the conjunction `IsLyapunovStableEquilibrium`.

## Attraction asks for approach

An orbit from \(x\) is attracted to \(p\) when

\[
\Phi(t,x)\to p\qquad\text{as }t\to+\infty.
\]

This is not an all-time error bound. A converging trajectory may have a large
transient before it enters and remains in a small neighborhood. The
{{< refterm "basin-of-attraction" "basin of attraction" >}} collects the
starts with this limit.

The identity flow supplies a checkable non-example. Every point is a stable
equilibrium, but the orbit from \(x\ne p\) is the constant function \(x\), so
it does not approach \(p\).

{{< reference-figure
  wide="true"
  src="stability-attraction-ledger.svg"
  alt="A four-row ledger marks translation as forward stable but not equilibrium, identity points as stable equilibria but not attractive to distinct starts, and asymptotic stability as requiring both stability and a local basin."
  caption="**Predicate ledger:** translation and identity fill different rows. Asymptotic stability is not a synonym for either ingredient; it requires Lyapunov stability and local attraction together."
>}}

## Why an orbit limit is an equilibrium

Suppose \(X\) is Hausdorff and \(\Phi(t,x)\to p\). Fix a time \(s\). Continuity
of the map (y\mapsto\Phi(s,y)) gives

\[
\Phi(s,\Phi(t,x))\longrightarrow\Phi(s,p).
\]

The flow law rewrites the left side as (\Phi(s+t,x)). Translating real time
by the fixed amount \(s\) does not change the \(t\to+\infty\) limit, so the
same expression also tends to \(p\). Hausdorff uniqueness of limits yields
\(\Phi(s,p)=p\). Since \(s\) was arbitrary, \(p\) is an equilibrium.

This argument uses the topological flow structure. It does not infer
Lyapunov stability from attraction.

## Asymptotic stability combines two obligations

A locally attracting equilibrium has a basin containing a neighborhood of
\(p\). An asymptotically stable equilibrium is both Lyapunov stable and locally
attracting:

\[
\operatorname{AsympStable}(p)
\iff
\operatorname{LyapStable}(p)
\land B(p)\in\mathcal N(p).
\]

This interface controls initial perturbations of the state under one fixed
flow. It does not compare nearby vector fields or random perturbations.

## In Lean

{{< lean-bridge
  human="All nonnegative-time maps are equicontinuous together at p."
  math="\(\operatorname{EquicontinuousAt}((\Phi_t)_{t\ge0},p).\)"
  lean="def IsForwardStableAt [UniformSpace X] (ϕ : Flow ℝ X) (p : X) : Prop := EquicontinuousAt (fun t : AddSubmonoid.nonneg ℝ ↦ ϕ t) p"
>}}
`AddSubmonoid.nonneg ℝ` is the type of pairs consisting of a real number and
a proof that it is nonnegative. `EquicontinuousAt` chooses one neighborhood
before quantifying over that whole time index.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Any finite forward orbit limit of a continuous real flow on a Hausdorff space is an equilibrium."
  math="\(\Phi(t,x)\to p\Rightarrow\forall s\in\mathbb R,\ \Phi(s,p)=p.\)"
  lean="theorem IsAttractedTo.isEquilibrium [TopologicalSpace X] [T2Space X] (hxp : IsAttractedTo ϕ x p) : IsEquilibrium ϕ p"
>}}
`T2Space X` is the Hausdorff separation assumption used for uniqueness of
limits. `Flow.continuous_toFun` transports the limit through one time slice,
and `Flow.map_add` rewrites the transported orbit as a shifted orbit.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.ODE.Stability

open NonlinearDynamics.Deterministic.ODE

#check isForwardStableAt_iff_dist
#check isLyapunovStableEquilibrium_iff_dist
#check isEquilibrium_iff_nonneg
#check IsAttractedTo.isEquilibrium
#check isAttractedTo_id_iff
#check forwardStableAt_translationFlow_not_equilibrium
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
This command checks the exact source module with warnings treated as errors.
It checks proof terms against formal statements, not the suitability of a flow
as a model of measured physics.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/ODE/Stability.lean
```

## What this chapter does not claim

No theorem here supplies an attraction rate, exponential stability, an
invariant-set stability theory, a Lyapunov function, stable manifolds,
structural stability, or robustness to stochastic perturbations. The metric
theorems allow pseudo-metrics, so zero distance need not imply equality unless
stronger separation assumptions are present.

## Related trail markers

- [Continuous-time stability]({{< relref "/knowledge-base/glossary/continuous-time-stability" >}})
- [Flow]({{< relref "/knowledge-base/glossary/flow" >}})
- [Forward stability in discrete time]({{< relref "/knowledge-base/glossary/forward-stability" >}})
- [Basin of attraction]({{< relref "/knowledge-base/glossary/basin-of-attraction" >}})
- [Stability and Attraction for ODE Flows in Lean]({{< relref "/development-notebook/2026/08/stability-and-attraction-for-ode-flows-in-lean" >}})

## References

1. N. P. Bhatia and G. P. Szegő, *Dynamical Systems: Stability Theory and
   Applications*, Lecture Notes in Mathematics 35, Springer, 1967.
   [Publisher record](https://doi.org/10.1007/BFb0080630).
2. J. P. LaSalle, *The Stability of Dynamical Systems*, SIAM CBMS 25, 1976.
   [Publisher record](https://doi.org/10.1137/1.9781611970432).
3. Mathlib contributors,
   [`Mathlib.Dynamics.Flow`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/Flow.lean),
   version 4.32.0.
4. Mathlib contributors,
   [`Topology.UniformSpace.Equicontinuity`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Topology/UniformSpace/Equicontinuity.lean)
   and
   [`Topology.MetricSpace.Equicontinuity`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Topology/MetricSpace/Equicontinuity.lean),
   version 4.32.0.
