---
title: "Local Existence, Uniform Time, and Global Integral Curves"
slug: "local-existence-uniform-time-and-global-integral-curves"
summary: "Learn why local ODE solutions need a continuation hypothesis, how uniform local time supplies it, and where uniqueness enters."
lead: "A smooth vector field determines motion near an initial point, but a trajectory can still escape in finite time. The missing bridge is continuation, not more optimistic terminology."
draft: true
pro_reviewed: false
toc: true
level: "Intermediate"
reading_time: "35 to 50 minutes"
prerequisites: ["Vector fields", "Integral curves", "Differentiability"]
lean_module: "NonlinearDynamics.Deterministic.ODE.GlobalExistence"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/ODE/GlobalExistence.lean"
lean_source_sha256: "ce3e3f6bc4aecf83dffa4b10481487cbba1ba8c8e27d0a9c47a4c6339764c862"
tags: ["ODE", "Integral curves", "Global existence", "Uniform time", "Lean 4"]
og_image: "local-existence-uniform-time-and-global-integral-curves-card.png"
og_image_alt: "The solution of x prime equals x squared approaches a finite-time pole, contrasted with overlapping fixed-width continuation windows."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this Deep Dive. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary sources
  and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial and validation status.** The exact source passes its warning-fatal
Lean leaf and deterministic aggregator checks. The complete repository gate
remains pending. Professional review remains pending, so `pro_reviewed`
remains false.
{{< /panel >}}

## Learning objectives

After this chapter, you should be able to:

1. distinguish a local solution from a global one;
2. compute a smooth equation with finite-time blow-up;
3. explain the difference between pointwise and uniform local time;
4. separate existence from uniqueness; and
5. read the corresponding propositions in Lean.

Begin with {{< refterm "vector-field" "vector fields" >}} and
{{< refterm "integral-curve" "integral curves" >}}. The
[Development Notebook]({{< relref "/development-notebook/2026/08/global-integral-curves-from-uniform-local-time-in-lean" >}})
records the complete declaration map and formalization boundary.

## Running example: a smooth field can blow up

Consider the vector field \(v(x)=x^2\) on \(\mathbb R\). Starting at
\(x(0)=1\), the function

\[
x(t)=\frac{1}{1-t}
\]

satisfies \(x'(t)=x(t)^2\) wherever \(t\ne1\). It is a valid integral curve
near time zero, but its value diverges as \(t\) approaches 1 from below. It
cannot be extended through \(t=1\) as a real-valued differentiable solution.

The field is infinitely differentiable. Regularity gives local existence and
uniqueness; it does not stop this finite-time escape.

{{< reference-figure
  wide="true"
  src="blowup-versus-uniform-continuation.svg"
  alt="On the left, the graph of one over one minus t rises toward a dashed vertical line at t equals one. On the right, equal-width overlapping intervals cover an unbounded time axis."
  caption="**Two different situations:** the smooth field \(x'=x^2\) has a local solution that approaches a pole at finite time. The continuation theorem instead assumes one fixed positive local radius at every point, allowing repeated extension without the guaranteed step collapsing."
>}}

## Local, arbitrarily long local, and global

A **local integral curve** is required to satisfy the differential equation on
a time set such as \((-\varepsilon,\varepsilon)\). An **arbitrarily long local
curve at \(x\)** means that for every finite radius \(a\), some curve through
\(x\) works on \((-a,a)\). The curve may depend on \(a\).

A **global integral curve** is one function \(\Gamma:\mathbb R\to M\) that
satisfies the equation at every real time. Under the regularity and
boundaryless hypotheses, Mathlib identifies existence of that one curve with
existence on every symmetric finite interval.

This is an existence equivalence. The upstream theorem performs the
compatibility work; the project definition does not hide a family of already
compatible curves.

## Pointwise radius versus uniform radius

Suppose each initial point \(x\) has a local curve on
\((-\varepsilon_x,\varepsilon_x)\). The radius may become small along a
trajectory. That statement alone is not the continuation hypothesis used in
this module.

The stronger statement is

\[
\exists\varepsilon\gt0\;\forall x\in M\;\exists\gamma_x
\quad\text{on }(-\varepsilon,\varepsilon).
\]

The order of quantifiers matters: `∃ ε, ∀ x` selects the radius before the
point, while `∀ x, ∃ ε` permits a different radius after seeing the point.

## Uniqueness is another theorem

Existence asks for at least one curve. Unique existence says that every other
global curve through the same point is equal to it as a function. For a
continuously differentiable vector field on a boundaryless manifold,
Mathlib's integral-curve uniqueness theorem supplies this second conclusion.

The zero vector field supplies a boundary check. If \(v(x)=0\), then the
constant curve \(\gamma(t)=x\) has derivative zero at every time and is a
global integral curve. The source packages that fact separately, without
requiring the continuation theorem.

## In Lean

{{< lean-bridge
  human="Global existence through every point is equivalent to one uniform positive local-time radius."
  math="\(\bigl[\forall x\;\exists\Gamma_x:\mathbb R\to M\bigr]\iff\bigl[\exists\varepsilon>0\;\forall x\;\exists\gamma_x\text{ on }(-\varepsilon,\varepsilon)\bigr].\)"
  lean="theorem hasGlobalIntegralCurves_iff_hasUniformLocalIntegralCurves [BoundarylessManifold I M] (hvfield : CMDiff 1 (fun x ↦ (⟨x, vfield x⟩ : TangentBundle I M))) : HasGlobalIntegralCurves vfield ↔ HasUniformLocalIntegralCurves vfield"
>}}
`TangentBundle I M` packages a point together with a tangent vector there.
`CMDiff 1` applies continuous differentiability to that bundled map. The
forward implication restricts global curves to radius one. The reverse
implication invokes Mathlib's uniform-time continuation theorem.
{{< /lean-bridge >}}

{{< lean-bridge
  human="At a zero of the vector field, the constant curve is global."
  math="\(v(x)=0\Longrightarrow\gamma(t)=x\text{ is an integral curve for every }t\in\mathbb R.\)"
  lean="theorem hasGlobalIntegralCurveAt_of_eq_zero {x : M} (hx : vfield x = 0) : HasGlobalIntegralCurveAt vfield x"
>}}
`hx` identifies the vector field value with the zero tangent vector. The
conclusion contains the literal constant function `fun _ ↦ x`.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.ODE.GlobalExistence

open NonlinearDynamics.Deterministic.ODE

#print HasGlobalIntegralCurveAt
#print HasUniformLocalIntegralCurves
#check HasGlobalIntegralCurveAt.hasUnique
#check HasUniformLocalIntegralCurves.hasGlobalIntegralCurves
#check hasGlobalIntegralCurveAt_of_eq_zero
~~~

This is a **full project check** on macOS or Linux. It requires the pinned Lean
and Mathlib dependencies; initial setup may use substantial disk space or
build time.

{{< repo-check >}}
The worksheet exposes the quantifier order and the separate uniqueness and
constant-curve results.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/ODE/GlobalExistence.lean
```

## Claim ledger

| Statement | Status |
|---|---|
| a uniform positive local radius gives global curves | established under the stated smooth boundaryless hypotheses |
| global curves give a uniform local radius | established by restriction |
| global curves through a point are unique | established under continuous differentiability and no boundary |
| local smoothness alone gives global curves | refuted by \(x'=x^2\) with positive initial value |
| the module constructs a global flow | not claimed |
| the module supplies compactness or growth criteria | not claimed |

## References

- John M. Lee, *Introduction to Smooth Manifolds*, second edition, Springer,
  2013, Chapters 8 and 9. [Publisher record](https://doi.org/10.1007/978-1-4419-9982-5).
- Mathlib contributors,
  [`IntegralCurve.UniformTime`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Geometry/Manifold/IntegralCurve/UniformTime.lean)
  and [`IntegralCurve.ExistUnique`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Geometry/Manifold/IntegralCurve/ExistUnique.lean),
  version 4.32.0.
- Mathlib contributors,
  [`ODE.PicardLindelof`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Analysis/ODE/PicardLindelof.lean),
  version 4.32.0.
