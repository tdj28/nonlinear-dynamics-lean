---
title: "Logistic ordinary differential equation"
slug: "logistic-ordinary-differential-equation"
summary: "The continuous-time equation x'=r x(1-x), with endpoint equilibria and sigmoid-shaped interior solution curves."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Models.LogisticODE"
tags:
  - "Continuous dynamics"
  - "Ordinary differential equations"
  - "Logistic equation"
  - "Vector fields"
  - "Integral curves"
og_image: "logistic-ordinary-differential-equation-card.png"
og_image_alt: "A phase line for the logistic differential equation points toward increasing states between equilibrium levels zero and one."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this chapter. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed glossary chapter. Verify claims against the cited primary
sources and any released artifacts before relying on them.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial and validation status.** This is a private AI-assisted working
chapter. Professional review and pinned-toolchain validation remain pending,
so <code>pro_reviewed</code> remains false.
{{< /panel >}}

The **logistic ordinary differential equation** in carrying-capacity-one form
is

\[
x'(t)=r x(t)(1-x(t)).
\]

Here \(t\) is continuous time, \(x(t)\) is the state at time \(t\), and \(r\)
is a fixed real growth-rate parameter. The right-hand side is the
{{< refterm "vector-field" "vector field" >}}

\[
F_r(x)=r x(1-x).
\]

The equation asks for a differentiable curve whose derivative at every time
equals the vector field evaluated at its current state.

## Start at one state

Choose \(r=2\) and \(x=1/4\). Then

\[
F_2(1/4)
=2\left(\frac14\right)\left(1-\frac14\right)
=\frac38.
\]

The positive value says that a solution passing through \(1/4\) has positive
instantaneous derivative there. It does not say that the next state is
\(1/4+3/8\). An ordinary differential equation constrains a derivative; it is
not the one-step update rule of the discrete logistic map.

At the two endpoints,

\[
F_r(0)=0,
\qquad
F_r(1)=0.
\]

The constant curves \(x(t)=0\) and \(x(t)=1\) therefore solve the equation for
every \(r\). When \(r\ne0\), they are the only states where the vector field
vanishes. When \(r=0\), the equation is \(x'=0\), so every constant state is an
equilibrium.

{{< reference-figure
  wide="true"
  src="logistic-ode-vector-field.svg"
  alt="A number line marks equilibria at zero and one. For positive r, arrows point left below zero, right between zero and one, and left above one. A worked box calculates F sub 2 of one quarter as three eighths."
  caption="**Read arrows as derivative signs:** the worked value fixes the instantaneous slope of any solution at that state. It is not a discrete jump. The endpoint dots mark zeros of the vector field."
>}}

## Interior solution curves

Mathlib defines the real sigmoid by

\[
\operatorname{sigmoid}(u)=\frac{1}{1+e^{-u}}.
\]

For any real phase \(c\), set

\[
x_{r,c}(t)=\operatorname{sigmoid}(rt+c).
\]

The sigmoid lies strictly between zero and one. Its derivative is
\(s(u)(1-s(u))\), so the chain rule gives

\[
x_{r,c}'(t)=r x_{r,c}(t)(1-x_{r,c}(t)).
\]

Thus every such curve is a global {{< refterm "integral-curve"
"integral curve" >}} of the logistic vector field. Mathlib also proves that
the sigmoid's range is exactly \((0,1)\), so every interior initial state is
\(x_{r,c}(0)\) for some phase \(c\).

If \(r\gt0\), the curve tends to zero as \(t\to-\infty\) and to one as
\(t\to+\infty\). These are curvewise limit statements. The current model does
not yet package the curves into a {{< refterm "flow" "flow" >}}, so it does
not state the repository's flow-level attraction or stability predicates.

## Do not confuse it with the logistic map

The [logistic map]({{< relref "/knowledge-base/glossary/logistic-map" >}})
uses the same quadratic expression:

\[
x_{n+1}=r x_n(1-x_n).
\]

The roles differ.

| Model | Time | Meaning of \(r x(1-x)\) |
|---|---|---|
| logistic ODE | \(t\in\mathbb R\) | instantaneous derivative \(x'(t)\) |
| logistic map | \(n\in\mathbb N\) | entire next state \(x_{n+1}\) |

Sharing a formula does not make the trajectories or parameter regimes the
same. For example, \(r=4\) is a distinguished interval-preserving boundary
for the discrete map. In the normalized ODE, a positive \(r\) primarily
rescales how quickly an interior sigmoid curve traverses continuous time.

## In Lean

{{< lean-bridge
  human="The normalized logistic vector field multiplies r, x, and one minus x."
  math="\( F_r(x)=r x(1-x). \)"
  lean="def logisticODEVectorField (r x : ℝ) : ℝ :=\n  r * (x * (1 - x))"
>}}
Both arguments are real numbers. `r` is fixed when selecting one ODE; `x` is
the current state at which the vector field is evaluated.
{{< /lean-bridge >}}

{{< lean-bridge
  human="A phase-shifted sigmoid solves the time-independent logistic equation at every real time."
  math="\( x_{r,c}'(t)=F_r(x_{r,c}(t)). \)"
  lean="theorem logisticInteriorCurve_isIntegralCurve (r c : ℝ) :\n    IsIntegralCurve (logisticInteriorCurve r c)\n      (logisticODEField r)"
>}}
`IsIntegralCurve` is Mathlib's scalar ODE predicate. It checks a derivative at
every real time. `logisticODEField r` accepts a time argument because the
general interface allows time-dependent equations, but this field ignores it.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.Models.LogisticODE

open Set
open NonlinearDynamics.Deterministic.Models

#check logisticODEVectorField
#check logisticODEVectorField_eq_zero_iff_of_ne
#check logisticInteriorCurve_isIntegralCurve
#check tendsto_logisticInteriorCurve_atTop
~~~

This is a **full project check** on macOS or Linux. It uses the pinned Lean and
Mathlib dependencies and may require substantial disk space or build time.

{{< repo-check >}}
The command checks the exact source module. It does not numerically simulate
trajectories or validate a population model against observations.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/LogisticODE.lean
```

Continue with the [Deep Dive]({{< relref
"/knowledge-base/deep-dives/logistic-ode-interior-curves-equilibria-and-limits"
>}}) for the derivative and limit argument, a bounded standalone worksheet,
and the boundary between explicit curves and a flow construction.

## Boundary cases and nonclaims

- At \(r=0\), every state is a zero of the vector field. A theorem that lists
  only zero and one must assume \(r\ne0\).
- The sigmoid family covers exactly the open interval. Endpoint solutions are
  separate constant curves.
- Curvewise containment in \((0,1)\) is not yet a formal invariant-set theorem
  for a bundled flow.
- The model does not claim that solutions are global through every real
  initial state.
- No parameter value is classified as chaotic, bifurcating, or empirically
  correct for a particular population.

## References

- P.-F. Verhulst, “Recherches mathématiques sur la loi d’accroissement de la
  population,” *Nouveaux mémoires de l'Académie royale des sciences et
  belles-lettres de Bruxelles* 18, 1–40 (1845).
  [DOI 10.3406/marb.1845.3438](https://doi.org/10.3406/marb.1845.3438).
- Mathlib contributors,
  [`Analysis.SpecialFunctions.Sigmoid`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/SpecialFunctions/Sigmoid.lean)
  and
  [`Analysis.ODE.Basic`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/ODE/Basic.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.
