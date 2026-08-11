---
title: "Lotka-Volterra predator-prey model"
slug: "lotka-volterra-predator-prey-model"
summary: "A two-coordinate continuous-time model in which prey growth, predator mortality, and bilinear encounters determine an instantaneous vector field."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Models.LotkaVolterra"
tags:
  - "Continuous dynamics"
  - "Ordinary differential equations"
  - "Lotka-Volterra"
  - "Predator-prey models"
  - "Vector fields"
  - "First integrals"
og_image: "lotka-volterra-predator-prey-model-card.png"
og_image_alt: "A normalized prey count two and predator count three produce instantaneous derivatives minus four and three."
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

The **Lotka-Volterra predator-prey model** is a continuous-time system for two
interacting quantities. Write \(x(t)\) for prey and \(y(t)\) for predators.
The convention used in this repository is

\[
\begin{aligned}
x'(t)&=x(t)(\alpha-\beta y(t)),\\
y'(t)&=y(t)(\delta x(t)-\gamma).
\end{aligned}
\]

The four parameters are normally positive. The term \(\alpha x\) is prey
growth without predators, \(-\beta xy\) is prey loss from encounters,
\(-\gamma y\) is predator mortality without prey, and
\(\delta xy\) is predator gain from encounters in the chosen units.

The associated {{< refterm "vector-field" "vector field" >}} is

\[
F(x,y)=\bigl(x(\alpha-\beta y),
             y(\delta x-\gamma)\bigr).
\]

It returns two instantaneous derivatives. It is not a rule that advances both
populations by one unit of time.

## Start at one normalized state

Set \(\alpha=\beta=\gamma=\delta=1\) and choose \((x,y)=(2,3)\). Then

\[
\begin{aligned}
x'&=2(1-3)=-4,\\
y'&=3(2-1)=3.
\end{aligned}
\]

Thus

\[
F(2,3)=(-4,3).
\]

This computation says that prey is instantaneously decreasing and predators
are instantaneously increasing at the chosen state. It does not say that the
state one time unit later is \((-2,6)\). Obtaining a later state requires an
{{< refterm "integral-curve" "integral curve" >}} of the differential
equation.

{{< reference-figure
  wide="true"
  src="predator-prey-state.svg"
  alt="At normalized state prey two and predators three, multiplying two by one minus three gives prey derivative minus four, while multiplying three by two minus one gives predator derivative three."
  caption="**One exact state:** the two coordinate calculations produce the tangent vector minus four comma three. The arrow indicates an instantaneous direction only; no finite-time population is computed."
>}}

## Two field zeros under positive parameters

An equilibrium is a state where both field coordinates are zero. The origin
\((0,0)\) is always an equilibrium. If all four parameters are strictly
positive, the only other equilibrium is

\[
p_*=\left(\frac{\gamma}{\delta},
          \frac{\alpha}{\beta}\right).
\]

At this state, \(\delta x-\gamma=0\) and
\(\alpha-\beta y=0\). Positive numerators and denominators put both
coordinates in the strict positive quadrant.

The name **coexistence equilibrium** means that both coordinates are positive
and the field is zero. It does not assert that the equilibrium is stable,
attracting, robust under a changed model, or observed in a particular
ecosystem.

## The axes and positive quadrant are different claims

On the predator-free axis,

\[
F(x,0)=(\alpha x,0).
\]

On the prey-free axis,

\[
F(0,y)=(0,-\gamma y).
\]

These equations show that the field is tangent to each axis. The Lean module
also names the strict positive quadrant

\[
Q_{++}=\{(x,y):x\gt0\text{ and }y\gt0\}.
\]

Neither fact alone is a forward-invariance theorem. Such a theorem concerns
solution curves through time and requires more ODE structure than a field
value at one state.

## A logarithmic scalar on positive states

For positive \(x\) and \(y\), define

\[
H(x,y)=\delta x-\gamma\log x+\beta y-\alpha\log y.
\]

If positive differentiable component curves satisfy the model at one time,
the chain rule and substitution give

\[
\frac{dH}{dt}
=\delta x'-\gamma\frac{x'}x
 +\beta y'-\alpha\frac{y'}y
=0.
\]

The Lean theorem checks this pointwise cancellation under visible positivity
and derivative hypotheses. It does not construct the component curves. It
also does not infer a nonconstant closed orbit, periodicity, or stability from
the scalar identity.

## In Lean

{{< lean-bridge
  human="The four-parameter model maps a prey-predator state to its two instantaneous derivatives."
  math="\(F(x,y)=(x(\alpha-\beta y),y(\delta x-\gamma)).\)"
  lean="def lotkaVolterraVectorField (alpha beta gamma delta : ℝ)\n    (state : ℝ × ℝ) : ℝ × ℝ :=\n  (state.1 * (alpha - beta * state.2),\n    state.2 * (delta * state.1 - gamma))"
>}}
`.1` selects prey and `.2` selects predator. The output uses the same order.
The factored form keeps each coordinate and its per-capita rate visible.
{{< /lean-bridge >}}

{{< lean-bridge
  human="At normalized state two comma three, the exact field value is minus four comma three."
  math="\(F_{1,1,1,1}(2,3)=(-4,3).\)"
  lean="theorem lotkaVolterraVectorField_normalized_benchmark :\n    lotkaVolterraVectorField 1 1 1 1 (2, 3) = (-4, 3)"
>}}
Lean treats these numerals as exact real values in the inferred field type.
No floating-point approximation or numerical ODE solver appears in this
theorem.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.Models.LotkaVolterra

open NonlinearDynamics.Deterministic.Models

#check lotkaVolterraVectorField
#check lotkaVolterraPositiveQuadrant
#check lotkaVolterraCoexistence
#check lotkaVolterraVectorField_predator_free
#check lotkaVolterraVectorField_prey_free
#check lotkaVolterraVectorField_eq_zero_iff_of_pos
#check lotkaVolterraVectorField_normalized_benchmark
#check lotkaVolterraFirstIntegral
#check hasDerivAt_lotkaVolterraFirstIntegral_along
~~~

This is a **full project check** on macOS or Linux. It uses the pinned Lean and
Mathlib dependencies and may require substantial disk space or build time.

{{< repo-check >}}
The command asks Lean to elaborate the exact source module and its general
real-number theorems. The kernel checks proof terms against their formal
statements. This does not validate the model for an empirical ecosystem,
construct arbitrary trajectories, or establish periodicity from a phase
portrait.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/LotkaVolterra.lean
```

Continue with the [Deep Dive]({{< relref
"/knowledge-base/deep-dives/lotka-volterra-positive-quadrant-equilibria-and-first-integral" >}})
for the five-state standalone worksheet, complete equilibrium classification,
and derivative ledger.

## Boundary cases and nonclaims

- Parameter letters differ across sources. This repository fixes prey first
  and the order \((\alpha,\beta,\gamma,\delta)\).
- If a parameter is zero or has another sign, the positive-parameter
  equilibrium classification does not apply unchanged.
- The full-plane Lean carrier does not treat negative coordinates as
  biological populations.
- Axis tangency and named positive-quadrant membership are not forward-
  invariance theorems.
- Lean totalizes `Real.log`, but the derivative theorem requires both
  component values to be strictly positive.
- Zero derivative under ODE hypotheses does not construct a solution.
- No nonconstant closed orbit, periodicity, period formula, global flow,
  attraction, or stability theorem is claimed in this slice.
- The classical model omits saturation, carrying capacity, delay, harvesting,
  seasonality, and stochastic effects.

## References

- Alfred J. Lotka, “Analytical Note on Certain Rhythmic Relations in Organic
  Systems,” *Proceedings of the National Academy of Sciences* 6 (1920),
  410–415, especially equations (8), (10), (11), and (12) on pp. 412–413,
  [DOI 10.1073/pnas.6.7.410](https://doi.org/10.1073/pnas.6.7.410),
  [open scan at PubMed Central](https://pmc.ncbi.nlm.nih.gov/articles/PMC1084562/).
- Alfred J. Lotka, *Elements of Physical Biology* (Baltimore: Williams &
  Wilkins, 1925),
  [Internet Archive record](https://archive.org/details/elementsofphysic0000alfr).
- Vito Volterra, “Fluctuations in the Abundance of a Species Considered
  Mathematically,” *Nature* 118 (1926), 558–560,
  [DOI 10.1038/118558a0](https://doi.org/10.1038/118558a0).
- Mathlib contributors,
  [`Analysis.ODE.Basic`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/ODE/Basic.lean)
  and
  [`Analysis.SpecialFunctions.Log.Deriv`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/SpecialFunctions/Log/Deriv.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.
