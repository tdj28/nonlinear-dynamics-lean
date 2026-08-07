---
title: "From Global Integral Curves to Topological Flows"
slug: "from-global-integral-curves-to-topological-flows"
date: 2026-08-07
summary: "ODE uniqueness supplies the restart law for an evolution family, while joint continuity in time and initial state is the separate topological input needed to build a flow."
lead: "Follow one translation flow, one restart argument, and one continuity counterexample to see exactly what unique global solutions do and do not provide."
draft: true
pro_reviewed: false
level: "Intermediate differential equations and topology"
reading_time: "35 to 50 minutes"
prerequisites: "Integral curves, uniqueness, and continuity are introduced through examples"
lean_module: "NonlinearDynamics.Deterministic.ODE.ToFlow"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/ODE/ToFlow.lean"
lean_source_sha256: "01994837eefd5c21d00ff9fcd8f118db9a48d186c2a5333ef65fe9a20072ac16"
toc: true
og_image: "from-global-integral-curves-to-topological-flows-card.png"
og_image_alt: "A trajectory restarts from an intermediate point, uniqueness closes the algebraic loop, and joint continuity is shown as a separate gate into a topological flow."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working draft. The Lean
leaf and deterministic aggregator pass with warnings treated as errors. The
exact-commit full repository gate and professional review remain pending.
{{< /panel >}}

## Start with a flow you can calculate

Fix a real constant (c). The autonomous differential equation

\[
x'(t)=c
\]

has the solution through (x_0)

\[
\gamma_{x_0}(t)=x_0+ct.
\]

Collect the curves into one map by setting Φ(t,x)=x+ct. The time-zero law
is Φ(0,x)=x, and the restart law is a direct calculation:

\[
\Phi(t,\Phi(s,x))=(x+cs)+ct=x+c(t+s)=\Phi(t+s,x).
\]

The formula is jointly continuous in ((t,x)). These are the identity,
composition, and continuity obligations in Mathlib's `Flow ℝ M`.

{{< reference-figure
  wide="true"
  src="flow-restart-law.svg"
  alt="A trajectory passes through an initial point, an intermediate point after time s, and a final point after another time t. A direct arc from the initial to final point is labeled time t plus s."
  caption="**The restart law:** the two-stage evolution and the one-stage evolution have the same endpoint. For a general autonomous ODE, uniqueness rather than coordinate arithmetic identifies the two paths."
>}}

## The uniqueness argument

Suppose the vector field has exactly one global integral curve through every
point. Write γ_x for the selected curve through (x). Fix a time (s) and
translate the curve in time:

\[
\widetilde\gamma(t)=\gamma_x(t+s).
\]

For an autonomous vector field, time translation preserves the integral-curve
equation. The translated curve starts at γ_x(s). The selected curve through
γ_x(s) starts at the same point and satisfies the same equation. Uniqueness
therefore identifies the two functions:

\[
\gamma_x(t+s)=\gamma_{\gamma_x(s)}(t).
\]

This equality is the flow composition law after defining Φ(t,x)=γ_x(t).
Global existence makes both curves available for every real time; uniqueness
identifies them.

## The topology does not come from that proof

Each integral curve is continuous as a function of time. A topological flow
requires the uncurried map ((t,x)\mapsto\gamma_x(t)) to be jointly
continuous. Continuity of every time curve with (x) fixed does not establish
that stronger statement.

For a boundary example, define (F:\mathbb R^2\to\mathbb R) by

\[
F(t,x)=
\begin{cases}
x+\dfrac{tx}{t^2+x^2},&(t,x)\ne(0,0),\\
0,&(t,x)=(0,0).
\end{cases}
\]

For every fixed (x), the function (t\mapsto F(t,x)) is continuous, and
(F(0,x)=x). Along the diagonal (t=x\ne0), however,

\[
F(x,x)=x+\frac12\longrightarrow\frac12,
\]

while (F(0,0)=0). Thus (F) is not jointly continuous at the origin. This
is a counterexample to the topological inference only. It is not asserted to
be a family of integral curves for one common vector field and does not refute
an ODE continuous-dependence theorem with suitable hypotheses.

{{< reference-figure
  wide="true"
  src="separate-continuity-boundary.svg"
  alt="Time traces at fixed initial states are continuous, but a diagonal sequence in the time-state plane approaches the origin while the output remains near one half."
  caption="**Boundary case:** continuity along every fixed-state time line leaves a diagonal approach uncontrolled. Joint continuity quantifies over all nearby time-state pairs at once."
>}}

## The formal construction

The project names the extra hypothesis
`HasContinuousGlobalIntegralCurveFamily h`. Its definition is

```lean
Continuous (Function.uncurry (globalIntegralCurveMap h))
```

The constructor `HasUniqueGlobalIntegralCurves.toFlow` then fills Mathlib's
four fields: the selected evolution map, joint continuity, the restart law,
and the time-zero law. No continuity theorem is hidden inside
`Classical.choose`.

{{< lean-bridge
  human="Restarting the unique global solution at an intermediate state reproduces the original future trajectory."
  math="\(\gamma_x(t+s)=\gamma_{\gamma_x(s)}(t).\)"
  lean="theorem globalIntegralCurve_add (h : HasUniqueGlobalIntegralCurves vfield) (t s : ℝ) (x : M) : globalIntegralCurve h x (t + s) = globalIntegralCurve h (globalIntegralCurve h x s) t"
>}}
`h` provides unique global curves. The left side translates the curve through
`x`; the right side restarts the selected curve from the state reached at
time `s`. Mathlib's time-translation lemma and uniqueness produce equality.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Joint continuity upgrades the uniquely selected evolution family to a topological flow."
  math="\(\operatorname{Continuous}[(t,x)\mapsto\gamma_x(t)]\Longrightarrow\Phi\in\operatorname{Flow}(\mathbb R,M).\)"
  lean="noncomputable def HasUniqueGlobalIntegralCurves.toFlow (h : HasUniqueGlobalIntegralCurves vfield) (hcont : HasContinuousGlobalIntegralCurveFamily h) : Flow ℝ M"
>}}
`hcont` is precisely the continuity field required by `Flow`. `noncomputable`
records that the curves were propositionally selected; it is not a numerical
ODE solver.
{{< /lean-bridge >}}

## Try the checked interface

~~~lean
import NonlinearDynamics.Deterministic.ODE.ToFlow

open NonlinearDynamics.Deterministic.ODE

#check globalIntegralCurve_add
#check HasContinuousGlobalIntegralCurveFamily
#check HasUniqueGlobalIntegralCurves.toFlow
#check HasUniqueGlobalIntegralCurves.toFlow_isIntegralCurveFlow
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space
and build time.

{{< repo-check >}}
This command checks the source module with warnings treated as errors. It
checks formal statements and proof terms, not the fidelity of a proposed
physical vector field to measured dynamics.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/ODE/ToFlow.lean
```

## Claim ledger

| Claim | Status |
|---|---|
| selected curves start at their designated points | checked in Lean |
| selected curves solve the vector field | checked in Lean |
| uniqueness implies the restart law | checked in Lean |
| joint continuity plus the laws constructs `Flow ℝ M` | checked in Lean |
| the constructed flow follows the vector field | checked in Lean |
| unique existence alone implies joint continuity | not claimed |
| the selected flow is computationally evaluable | not claimed |
| a continuous flow determines a differentiable vector field | not claimed |
| the formal model agrees with a particular physical system | not claimed |

## Related trail markers

- [Flow]({{< relref "/knowledge-base/glossary/flow" >}})
- [Continuous dependence on initial conditions]({{< relref "/knowledge-base/glossary/continuous-dependence-on-initial-conditions" >}})
- [Flows from Unique Global Integral Curves in Lean]({{< relref "/development-notebook/2026/08/flows-from-unique-global-integral-curves-in-lean" >}})

## References

1. John M. Lee, *Introduction to Smooth Manifolds*, second edition, Springer,
   2013, Chapters 8 and 9. [Publisher record](https://doi.org/10.1007/978-1-4419-9982-5).
2. Mathlib contributors,
   [`Mathlib.Dynamics.Flow`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/Flow.lean),
   version 4.32.0.
3. Mathlib contributors,
   [`IntegralCurve.Transform`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Geometry/Manifold/IntegralCurve/Transform.lean)
   and
   [`IntegralCurve.ExistUnique`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Geometry/Manifold/IntegralCurve/ExistUnique.lean),
   version 4.32.0.
