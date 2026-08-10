---
title: "Undamped pendulum"
slug: "undamped-pendulum"
summary: "A continuous-time angle-and-velocity model with restoring acceleration, repeated equilibria, and a conserved mechanical-energy expression."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Models.Pendulum"
tags:
  - "Continuous dynamics"
  - "Ordinary differential equations"
  - "Pendulum"
  - "Vector fields"
  - "Energy conservation"
og_image: "undamped-pendulum-card.png"
og_image_alt: "A pendulum pose is paired with its angle-velocity state, restoring vector, and normalized energy."
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

An **undamped pendulum** is an idealized continuous-time model with no
friction and no external driving force. Write \(\theta(t)\) for its angle and
\(\omega(t)\) for its angular velocity. In the normalization used here,

\[
\theta'(t)=\omega(t),
\qquad
\omega'(t)=-\kappa\sin(\theta(t)).
\]

The parameter \(\kappa\gt0\) sets the gravitational time scale. The minus
sign makes the acceleration restoring: near the downward direction, a
positive angle produces negative angular acceleration and a negative angle
produces positive angular acceleration.

The state is the ordered pair \((\theta,\omega)\). The right-hand side is the
{{< refterm "vector-field" "vector field" >}}

\[
F_\kappa(\theta,\omega)
=(\omega,-\kappa\sin\theta).
\]

It returns the two instantaneous derivatives. It is not a rule that advances
the state by one second.

## Start at a quarter turn

Choose \(\kappa=1\) and the state \((\pi/2,0)\). Because
\(\sin(\pi/2)=1\),

\[
F_1(\pi/2,0)=(0,-1).
\]

The zero first coordinate says the angle is instantaneously stationary. The
second says the angular velocity is changing at rate \(-1\) in the chosen
units. This one computation illustrates the restoring direction. It does not
construct the later trajectory.

The normalized mechanical energy is

\[
E_\kappa(\theta,\omega)
=\frac{\omega^2}{2}+\kappa(1-\cos\theta).
\]

At the same quarter-turn state, \(E_1(\pi/2,0)=1\). The first term is kinetic
energy and the second is potential energy measured from zero at the downward
direction.

{{< reference-figure
  wide="true"
  src="pendulum-state-and-energy.svg"
  alt="A pendulum at angle pi over two and zero angular velocity is labeled with vector zero comma minus one and normalized energy one."
  caption="**Read the labels at one instant:** the vector gives the state derivative and the energy gives a scalar value at the same state. Neither label is a finite-time update."
>}}

## Equilibria repeat on the angle cover

The Lean source represents angle as a real number. Thus angles separated by
a full turn are different coordinates:

\[
\theta,\quad \theta+2\pi,\quad \theta-2\pi.
\]

Sine and cosine repeat, so the vector field and energy have the same value at
all of those representatives. When \(\kappa\ne0\), an equilibrium must have

\[
\omega=0,
\qquad
\theta=n\pi\quad(n\in\mathbb Z).
\]

Even multiples of \(\pi\) represent the downward direction; odd multiples
represent the upright direction. The source proves that the constant curves
through \((0,0)\) and \((\pi,0)\) are global
{{< refterm "integral-curve" "integral curves" >}}. It does not yet prove the stability classification of
either equilibrium.

## Why energy conservation is conditional

Suppose differentiable component curves satisfy the two pendulum equations at
a time \(t\). Differentiating the energy gives

\[
\omega\omega'
+\kappa\sin\theta\,\theta'.
\]

Substitution yields

\[
\omega(-\kappa\sin\theta)
+\kappa\sin\theta\,\omega=0.
\]

The Lean theorem checks this cancellation at an arbitrary time under the two
visible derivative hypotheses. It does not use the calculation to claim that
a solution exists through every state. A later existence theorem or a bundled
{{< refterm "flow" "flow" >}} would be needed before making corresponding
global dynamical claims.

## In Lean

{{< lean-bridge
  human="The normalized pendulum vector field maps angle and angular velocity to their instantaneous derivatives."
  math="\( F_\kappa(\theta,\omega)=(\omega,-\kappa\sin\theta). \)"
  lean="def pendulumVectorField (κ : ℝ) (state : ℝ × ℝ) : ℝ × ℝ :=\n  (state.2, -κ * Real.sin state.1)"
>}}
`ℝ × ℝ` is a product of real numbers. `.1` selects the angle and `.2`
selects angular velocity. The output uses the same coordinate order.
{{< /lean-bridge >}}

{{< lean-bridge
  human="At the quarter-turn benchmark with κ equal to one, the normalized energy is exactly one."
  math="\( E_1(\pi/2,0)=1. \)"
  lean="theorem pendulumEnergy_one_quarter_turn :\n    pendulumEnergy 1 (Real.pi / 2, 0) = 1"
>}}
`Real.pi / 2` remains an exact real expression. No floating-point
approximation is involved in this theorem.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.Models.Pendulum

open NonlinearDynamics.Deterministic.Models

#check pendulumVectorField
#check pendulumVectorField_eq_zero_iff_of_ne
#check pendulumEnergy
#check pendulumEnergy_nonneg
#check hasDerivAt_pendulumEnergy_along
#check pendulum_down_isIntegralCurve
~~~

This is a **full project check** on macOS or Linux. It uses the pinned Lean and
Mathlib dependencies and may require substantial disk space or build time.

{{< repo-check >}}
The command asks Lean to elaborate the exact source module and its general
real-number theorems. The kernel checks proof terms against their formal
statements. This does not validate a particular physical pendulum's units,
construct arbitrary trajectories, or prove stability from a phase portrait.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/Pendulum.lean
```

Continue with the [Deep Dive]({{< relref
"/knowledge-base/deep-dives/pendulum-phase-plane-equilibria-and-energy" >}})
for a five-state worksheet, equilibrium classification, and the full energy
derivative calculation.

## Boundary cases and nonclaims

- When \(\kappa=0\), every zero-velocity state is an equilibrium; the
  integer-multiple classification therefore assumes \(\kappa\ne0\).
- Real angle coordinates repeat the same physical direction. The source
  proves periodicity rather than quotienting the state space.
- The finite quarter-turn ledger checks cases, not all real angles.
- Zero energy derivative is conditional on curves satisfying the ODE. It is
  not an existence theorem.
- The model has no damping and no driving term; those models have different
  energy balances.
- No nonconstant periodic orbit, libration/rotation classification, global
  flow, attraction, or stability theorem is claimed in this slice.

## References

- Christiaan Huygens, *Christiani Hugenii Horologium Oscillatorium sive de
  motu pendulorum ad horologia aptato demonstrationes geometricae* (Paris:
  F. Muguet, 1673), ETH-Bibliothek Zürich digitization, Rar 4649,
  [DOI 10.3931/e-rara-11164](https://doi.org/10.3931/e-rara-11164), Public
  Domain Mark.
- V. I. Arnold, *Mathematical Methods of Classical Mechanics*, Graduate Texts
  in Mathematics 60 (Springer New York, 1978),
  [DOI 10.1007/978-1-4757-1693-1](https://doi.org/10.1007/978-1-4757-1693-1).
- Mathlib contributors,
  [`Analysis.SpecialFunctions.Trigonometric.Deriv`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/SpecialFunctions/Trigonometric/Deriv.lean)
  and
  [`Analysis.ODE.Basic`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/ODE/Basic.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.
