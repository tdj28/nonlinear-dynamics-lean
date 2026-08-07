---
title: "Flow"
slug: "flow"
summary: "A flow is a jointly continuous real-time action: time zero fixes every state, and consecutive time steps compose by addition."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.ODE.ToFlow"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/ODE/ToFlow.lean"
lean_source_sha256: "01994837eefd5c21d00ff9fcd8f118db9a48d186c2a5333ef65fe9a20072ac16"
og_image: "flow-card.png"
og_image_alt: "A glossary card showing time zero as identity and two consecutive time steps joining into one summed step."
---

{{< panel "warning" >}}
**Editorial status.** This AI-assisted glossary entry is a public working
draft. Its linked Lean leaf passes warning-fatal checking;
`pro_reviewed` remains false.
{{< /panel >}}

On the real line, fix (c\in\mathbb R) and define

\[
\Phi(t,x)=x+ct.
\]

Time zero fixes the point, and two steps compose:

\[
\Phi(0,x)=x,
\qquad
\Phi(t,\Phi(s,x))=\Phi(t+s,x).
\]

The map is continuous in the pair ((t,x)). It is therefore the basic
example of a continuous-time **flow**.

{{< reference-figure
  wide="true"
  src="translation-flow-grid.svg"
  alt="Three horizontal trajectories are sampled at times zero, s, and s plus t. Moving first to s and then to s plus t matches the single combined time step."
  caption="**Translation flow:** each initial point moves at the same constant velocity. The columns show the identity time, an intermediate time, and the combined time."
>}}

## Definition

Let (M) be a topological space. A real-time flow is a jointly continuous map

\[
\Phi:\mathbb R\times M\to M
\]

such that, for all (x\in M) and (s,t\in\mathbb R),

\[
\Phi(0,x)=x,
\qquad
\Phi(t+s,x)=\Phi(t,\Phi(s,x)).
\]

The first law is identity at time zero. The second is the additive action law.
Negative time is part of the domain, so every time slice has the inverse time
slice Φ(-t,·). A forward-only evolution indexed by nonnegative time is
usually called a semiflow instead.

The curve (t\mapsto\Phi(t,x)) is the **orbit** through (x). For an ODE, it
may also be an integral curve of a vector field, but being a flow alone does
not supply differentiability in time or identify a vector field.

## In Lean

Mathlib's `Flow ℝ M` packages a jointly continuous additive action. The
repository constructs one only after proving the algebraic laws and receiving
joint continuity as an explicit hypothesis.

{{< lean-bridge
  human="The uniquely selected global ODE solutions form a flow when their time-and-state evaluation map is jointly continuous."
  math="\(\operatorname{Continuous}[(t,x)\mapsto\gamma_x(t)]\Longrightarrow\operatorname{Flow}(\mathbb R,M).\)"
  lean="noncomputable def HasUniqueGlobalIntegralCurves.toFlow (h : HasUniqueGlobalIntegralCurves vfield) (hcont : HasContinuousGlobalIntegralCurveFamily h) : Flow ℝ M"
>}}
`h` supplies one unique global integral curve through each point. `hcont`
supplies joint continuity. `Flow ℝ M` then contains the evolution map, its
continuity, the additive law, and the identity law.
{{< /lean-bridge >}}

This is a **full project check** on macOS or Linux. It uses pinned Lean and
Mathlib dependencies and may require substantial disk space and build time.

{{< repo-check >}}
The command checks the repository's flow constructor and exact imported
interfaces. It does not numerically simulate an orbit.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/ODE/ToFlow.lean
```

## Boundaries

- A family of curves is not a flow until the identity, composition, and joint
  continuity obligations are supplied.
- Continuity of each orbit in time does not by itself give joint continuity
  in time and initial state.
- A topological flow need not be differentiable in time.
- A noncomputable Lean definition is a mathematical selection, not a
  numerical integrator.

## Related trail markers

- [Continuous dependence on initial conditions]({{< relref "/knowledge-base/glossary/continuous-dependence-on-initial-conditions" >}})
- [From Global Integral Curves to Topological Flows]({{< relref "/knowledge-base/deep-dives/from-global-integral-curves-to-topological-flows" >}})

## References

1. John M. Lee, *Introduction to Smooth Manifolds*, second edition, Springer,
   2013, Chapters 8 and 9. [Publisher record](https://doi.org/10.1007/978-1-4419-9982-5).
2. Mathlib contributors,
   [`Mathlib.Dynamics.Flow`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/Flow.lean),
   version 4.32.0.
