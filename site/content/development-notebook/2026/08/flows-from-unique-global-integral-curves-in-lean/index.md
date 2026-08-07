---
title: "Flows from Unique Global Integral Curves in Lean"
slug: "flows-from-unique-global-integral-curves-in-lean"
date: 2026-08-07
weight: -80
author: "tdj28"
summary: "Unique global ODE solutions supply the identity and composition laws of a flow, while joint continuity remains an explicit additional hypothesis."
lead: |
  A global solution through every initial point is still a family of curves. A flow is one jointly continuous time-and-state map whose time slices compose. This milestone uses ODE uniqueness to prove the algebraic laws and keeps continuous dependence as a separate gate.
key_result: |
  The uniquely selected global integral curves satisfy the restart identity: evolving for time s and then for time t agrees with evolving for t+s. If their uncurried time-and-state map is jointly continuous, they assemble into Mathlib's Flow ℝ M. Individual time continuity alone is not presented as continuous dependence on the initial state.
draft: true
pro_reviewed: false
status: "Warning-fatal leaf, deterministic aggregator, and full repository gate pass; professional review pending"
level: "Intermediate differential equations, topology, and Lean 4"
reading_time: "30 to 45 minutes"
prerequisites:
  - "Global integral curves"
  - "Uniqueness"
  - "Continuity"
lean_module: "NonlinearDynamics.Deterministic.ODE.ToFlow"
lean_source: "formalization/NonlinearDynamics/Deterministic/ODE/ToFlow.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/ODE/ToFlow.lean"
lean_source_sha256: "01994837eefd5c21d00ff9fcd8f118db9a48d186c2a5333ef65fe9a20072ac16"
tags: ["Lean 4", "ODE", "Flows", "Integral curves", "Continuous dependence"]
og_image: "flows-from-unique-global-integral-curves-in-lean-card.png"
og_image_alt: "A time-and-state grid shows translation flow, with uniqueness supplying the composition law and joint continuity shown as a separate gate."
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
**Editorial status.** The source passes its warning-fatal Lean leaf, the
deterministic aggregator, and the exact-candidate full repository gate with
the pinned toolchain. Professional review remains pending, so `draft` remains
true and `pro_reviewed` remains false.
{{< /panel >}}

## Begin with translation on the real line

Take the constant vector field \(v(x)=c\) on \(\mathbb R\). The integral
curve through \(x\) is

\[
\gamma_x(t)=x+ct.
\]

Putting every initial point into one map gives

\[
\Phi(t,x)=x+ct.
\]

Three checks distinguish this map from an arbitrary family of curves:

\[
\Phi(0,x)=x,
\qquad
\Phi(t+s,x)=\Phi\bigl(t,\Phi(s,x)\bigr),
\qquad
(t,x)\longmapsto\Phi(t,x)\text{ is continuous}.
\]

The first equality says time zero does nothing. The second says restarting the
solution after time \(s\) agrees with the original solution. The third controls
time and the initial point together. Mathlib packages exactly these three
fields in `Flow ℝ M`.

{{< reference-figure
  wide="true"
  src="translation-flow-laws.svg"
  alt="Three starting points move right by the same distance under a constant vector field; a two-step path and one combined step end at the same point."
  caption="**Translation flow:** every horizontal trajectory has the same velocity. Moving for time \(s\) and then \(t\) reaches the same point as moving once for \(t+s\). The diagram explains the algebraic identity; the displayed formula supplies its exact statement."
>}}

## From existential curves to one evolution map

The previous milestone established `HasUniqueGlobalIntegralCurves vfield`.
For each initial point \(x\), that proposition contains exactly one function
`curve : ℝ → M` with `curve 0 = x` and `IsMIntegralCurve curve vfield`.

The new definition `globalIntegralCurve h x` uses `Classical.choose` to select
that witness. This is noncomputable: the proposition does not contain an
algorithm for evaluating the curve. Uniqueness makes the selected value
canonical at the proposition level. The theorem `globalIntegralCurve_eq`
states that any other global integral curve through \(x\) equals the selected
one as a function.

Two projections record the selected witness:

1. `globalIntegralCurve_zero` gives its value at time zero; and
2. `globalIntegralCurve_isMIntegralCurve` gives the differential equation.

The theorem `globalIntegralCurve_continuous` then uses Mathlib's fact that a
global manifold integral curve is continuous in its time variable.

## Uniqueness proves the restart law

Fix an initial point \(x\) and a time \(s\). Translate its selected curve:

\[
\widetilde\gamma(t)=\gamma_x(t+s).
\]

Mathlib's `IsMIntegralCurve.comp_add` says that this translated function is
again a global integral curve of the same autonomous vector field. At time
zero it has value \(\gamma_x(s)\). The selected curve
\(\gamma_{\gamma_x(s)}\) has the same initial value and follows the same field.
Uniqueness therefore gives equality of the two functions:

\[
\gamma_x(t+s)=\gamma_{\gamma_x(s)}(t).
\]

This is `globalIntegralCurve_add`. Reordering its arguments into a time-first
map `globalIntegralCurveMap h t x` produces the exact action law expected by
`Flow.map_add`.

{{< reference-figure
  wide="true"
  src="uniqueness-to-flow-architecture.svg"
  alt="A selected curve is shifted at time s and compared with the selected curve restarted from the reached point; uniqueness identifies them, while joint continuity enters through a separate gate."
  caption="**Proof architecture:** time translation produces two integral curves through the same intermediate state. Uniqueness identifies them and yields the action law. Joint continuity is not part of that uniqueness argument, so it enters separately before constructing a topological flow."
>}}

## Why continuity is an explicit input

For every fixed \(x\), `globalIntegralCurve_continuous` proves continuity of
\(t\mapsto\gamma_x(t)\). A topological {{< refterm "flow" "flow" >}} requires
continuity of the single map

\[
(t,x)\longmapsto\gamma_x(t).
\]

That is a stronger statement. It controls simultaneous changes in time and
initial state. The project names it
`HasContinuousGlobalIntegralCurveFamily h`, defined as

```lean
Continuous (Function.uncurry (globalIntegralCurveMap h))
```

This distinction is the formal boundary around
{{< refterm "continuous-dependence-on-initial-conditions" "continuous dependence on initial conditions" >}}.
The source does not derive joint continuity from one-variable continuity, nor
does it package a differentiable dependence theorem that has not been proved.

## Constructing Mathlib's flow

`HasUniqueGlobalIntegralCurves.toFlow` fills the four fields of Mathlib's
structure:

| `Flow` field | Source of the field |
|---|---|
| `toFun` | `globalIntegralCurveMap h` |
| `cont'` | the explicit joint-continuity hypothesis `hcont` |
| `map_add'` | `globalIntegralCurveMap_add`, proved by uniqueness |
| `map_zero'` | `globalIntegralCurveMap_zero` |

The theorem `toFlow_apply` keeps evaluation transparent: the constructed flow
at time \(t\) and point \(x\) is the selected integral curve through \(x\)
evaluated at \(t\).

`IsIntegralCurveFlow ϕ vfield` records the converse compatibility condition:
every orbit map \(t\mapsto\phi(t,x)\) is a global integral curve of the vector
field. The theorem `toFlow_isIntegralCurveFlow` checks that the construction
has this property.

## The bridge in the reverse direction

If a `Flow ℝ M` is already known to be an integral-curve flow, then its orbit
through \(x\) supplies a global curve with initial value \(x\). This is
`IsIntegralCurveFlow.hasGlobalIntegralCurves`.

For a continuously differentiable field on a boundaryless manifold,
`IsIntegralCurveFlow.hasUniqueGlobalIntegralCurves` then invokes the earlier
uniqueness theorem. The flow structure is not used as a substitute for the ODE
regularity assumption. It supplies existence; the `CMDiff 1` and
`BoundarylessManifold` hypotheses supply uniqueness.

## Trust and dependency boundary

The source depends on two pinned Mathlib interfaces. `Dynamics.Flow` defines a
flow as a continuous additive action. `IntegralCurve.Transform` proves that
time translation preserves the integral-curve equation. The earlier
`IntegralCurve.ExistUnique` result supplies the uniqueness principle already
packaged by `GlobalExistence.lean`.

The four `#print axioms` commands report only `propext`, `Classical.choice`,
and `Quot.sound`. `Classical.choice` is expected because the evolution map is
selected from propositional unique existence. No report contains `sorryAx`.
That axiom audit checks the proof terms' trusted dependencies; it does not
establish that a modeled vector field matches a particular physical system.

## In Lean

{{< lean-bridge
  human="Restarting the unique solution at an intermediate time gives the same future trajectory as the original solution."
  math="\(\gamma_x(t+s)=\gamma_{\gamma_x(s)}(t).\)"
  lean="theorem globalIntegralCurve_add (h : HasUniqueGlobalIntegralCurves vfield) (t s : ℝ) (x : M) : globalIntegralCurve h x (t + s) = globalIntegralCurve h (globalIntegralCurve h x s) t"
>}}
`h` supplies unique global curves through all points. `t + s` is time
translation on the original curve. The point `globalIntegralCurve h x s` is
the state reached after time `s`. Function equality from uniqueness is then
evaluated at `t`.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Unique global integral curves form a topological flow once their time-and-state evaluation map is jointly continuous."
  math="\(\operatorname{Continuous}[(t,x)\mapsto\gamma_x(t)]\Longrightarrow\Phi\in\operatorname{Flow}(\mathbb R,M).\)"
  lean="noncomputable def HasUniqueGlobalIntegralCurves.toFlow (h : HasUniqueGlobalIntegralCurves vfield) (hcont : HasContinuousGlobalIntegralCurveFamily h) : Flow ℝ M"
>}}
`hcont` is not synthesized from the individual curves. It is the exact
continuity field required by `Flow`. The result contains the selected
evolution map, the restart law, the time-zero law, and joint continuity.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.ODE.ToFlow

open NonlinearDynamics.Deterministic.ODE

#check globalIntegralCurve_add
#check HasContinuousGlobalIntegralCurveFamily
#check HasUniqueGlobalIntegralCurves.toFlow
#check HasUniqueGlobalIntegralCurves.toFlow_isIntegralCurveFlow
#check IsIntegralCurveFlow.hasUniqueGlobalIntegralCurves
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies; initial setup may require substantial
disk space and build time.

{{< repo-check >}}
The worksheet inspects the selected-curve interface, the restart theorem, the
joint-continuity gate, and both directions of the flow bridge.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/ODE/ToFlow.lean
```

## Declaration map and nonclaims

| Declaration | Role |
|---|---|
| `globalIntegralCurve` | noncomputable selected curve through an initial point |
| `globalIntegralCurve_zero` | selected curve starts at that point |
| `globalIntegralCurve_isMIntegralCurve` | selected curve follows the field |
| `globalIntegralCurve_eq` | any competitor equals the selected curve |
| `globalIntegralCurve_continuous` | time continuity of each selected curve |
| `globalIntegralCurve_add` | restart identity from translation and uniqueness |
| `globalIntegralCurveMap` | time-first evolution map |
| `globalIntegralCurveMap_zero` | identity law at time zero |
| `globalIntegralCurveMap_add` | additive action law |
| `HasContinuousGlobalIntegralCurveFamily` | explicit joint-continuity gate |
| `HasUniqueGlobalIntegralCurves.toFlow` | construction of `Flow ℝ M` |
| `toFlow_apply` | evaluation bridge to the selected curve |
| `IsIntegralCurveFlow` | compatibility between a flow and a vector field |
| `toFlow_isIntegralCurveFlow` | constructed flow follows the field |
| `IsIntegralCurveFlow.hasGlobalIntegralCurves` | compatible flow gives existence |
| `IsIntegralCurveFlow.hasUniqueGlobalIntegralCurves` | compatible flow plus ODE regularity gives uniqueness |

Not claimed: that unique existence alone implies joint continuity; that every
continuous flow is differentiable in time; that a topological flow determines
a vector field without further structure; smooth dependence on parameters;
local flow construction; maximal solution intervals; numerical evaluation of
the noncomputable selected curves; or a physical-model validation theorem.

## References

- John M. Lee, *Introduction to Smooth Manifolds*, second edition, Springer,
  2013, Chapters 8 and 9. [Publisher record](https://doi.org/10.1007/978-1-4419-9982-5).
- Mathlib contributors,
  [`Mathlib.Dynamics.Flow`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/Flow.lean),
  version 4.32.0.
- Mathlib contributors,
  [`IntegralCurve.Transform`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Geometry/Manifold/IntegralCurve/Transform.lean)
  and
  [`IntegralCurve.ExistUnique`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Geometry/Manifold/IntegralCurve/ExistUnique.lean),
  version 4.32.0.

## Discussion

This milestone isolates a useful construction boundary. ODE uniqueness carries
the algebraic restart law, while continuous dependence carries the topology of
the assembled evolution map. Keeping those jobs separate makes later stability
work inspectable: a theorem may consume the flow laws, the flow's continuity,
or the differential equation, and its assumptions can name exactly which layer
it needs. The next dependency-ordered module can define stability for ODE
flows without treating an existential family of curves as a structured
dynamical system.
