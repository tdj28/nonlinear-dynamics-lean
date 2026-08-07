---
title: "Integral curve"
slug: "integral-curve"
summary: "An integral curve is a time-parametrized path whose velocity equals the vector field at its current point."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.ODE.GlobalExistence"
tags: ["Integral curves", "Vector fields", "ODE", "Lean 4"]
og_image: "integral-curve-card.png"
og_image_alt: "A curve passes through several points, and its tangent arrows match the vector-field arrows at those points."
---

{{< panel "warning" >}}
**Editorial and validation status.** The paired exact source passes its
warning-fatal Lean leaf and deterministic aggregator checks; the complete
repository gate remains pending. Professional review is pending, so
`pro_reviewed` remains false.
{{< /panel >}}

An **integral curve** of a {{< refterm "vector-field" "vector field" >}} is a
time-parametrized path whose velocity agrees with the field at its current
point:

\[
\gamma'(t)=v(\gamma(t)).
\]

## A checkable example

For \(v(x)=1\) on \(\mathbb R\), take \(\gamma(t)=3+t\). Then
\(\gamma(0)=3\), \(\gamma'(t)=1\), and \(v(\gamma(t))=1\). Thus this curve
follows the field through the initial point 3 for every real time.

The curve \(\eta(t)=3+2t\) is a non-example: its velocity is 2 while the field
value is 1.

{{< reference-figure
  src="velocity-matches-field.svg"
  alt="A horizontal curve gamma of t equals three plus t has three tangent arrows pointing right at equal speed. Beneath it, the equation gamma prime of t equals one equals v of gamma of t is displayed."
  caption="**Velocity matching:** the path \(\gamma(t)=3+t\) moves right with velocity one. The constant field assigns the same velocity at every point, so the differential equation holds at every time."
>}}

## Local and global domains

A local curve may satisfy the equation only for times in a set such as
\((-\varepsilon,\varepsilon)\). A global curve is defined and satisfies it for
every \(t\in\mathbb R\). Being global concerns the curve's time domain, not
whether its image covers the entire state space.

At a zero of the field, \(v(x)=0\), the constant path \(\gamma(t)=x\) is a
global integral curve because both sides of the equation are zero. This
establishes existence of one global curve at that equilibrium; uniqueness
requires a separate regularity theorem.

## In Lean

{{< lean-bridge
  human="A global integral curve through x starts at x at time zero and follows the vector field for every real time."
  math="\(\exists\gamma:\mathbb R\to M,\ \gamma(0)=x\ \text{and}\ \gamma'(t)=v(\gamma(t))\text{ for all }t.\)"
  lean="def HasGlobalIntegralCurveAt (vfield : (x : M) → TangentSpace I x) (x : M) : Prop := ∃ curve : ℝ → M, curve 0 = x ∧ IsMIntegralCurve curve vfield"
>}}
The existential witness `curve` is a function on all real times. `curve 0 = x`
sets the initial condition. Mathlib's `IsMIntegralCurve` expresses the
manifold derivative equation globally.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.ODE.GlobalExistence

open Manifold
open NonlinearDynamics.Deterministic.ODE

#check IsMIntegralCurve
#print HasGlobalIntegralCurveAt
#check hasGlobalIntegralCurveAt_of_eq_zero
~~~

This is a **full project check** on macOS or Linux. It uses the pinned Lean and
Mathlib dependencies; initial setup may require substantial disk space or
build time.

{{< repo-check >}}
The worksheet inspects Mathlib's integral-curve predicate and the project's
global existence interface.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/ODE/GlobalExistence.lean
```

## References

- John M. Lee, *Introduction to Smooth Manifolds*, second edition, Springer,
  2013, Chapter 9. [Publisher record](https://doi.org/10.1007/978-1-4419-9982-5).
- Mathlib contributors,
  [`IntegralCurve.Basic`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Geometry/Manifold/IntegralCurve/Basic.lean),
  version 4.32.0.
