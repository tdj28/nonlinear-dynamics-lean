---
title: "Pendulum Vector Field and Energy in Lean"
slug: "pendulum-vector-field-and-energy-in-lean"
date: 2026-08-10
summary: "A normalized undamped pendulum gets an exact phase-plane field, equilibrium classification, angle periodicity, and a pointwise energy-conservation proof."
lead: "Start at one quarter-turn state, separate the angle cover from physical directions, and stop before flow, orbit, or stability claims."
draft: true
pro_reviewed: false
tags:
  - "Lean"
  - "Continuous dynamics"
  - "Ordinary differential equations"
  - "Pendulum"
  - "Energy conservation"
  - "Phase plane"
lean_module: "NonlinearDynamics.Deterministic.Models.Pendulum"
lean_source: "formalization/NonlinearDynamics/Deterministic/Models/Pendulum.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Models/Pendulum.lean"
lean_source_sha256: "52ec379c7f53c27b6977d5b1220dda2810f12e7c13a4e23ed746c400e8acf6d3"
toc: true
og_image: "pendulum-vector-field-and-energy-in-lean-card.png"
og_image_alt: "A pendulum at a quarter turn connects to a phase-plane arrow and a closed normalized-energy contour."
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
**Editorial status.** This is a private AI-assisted working draft.
Professional review and pinned-toolchain validation remain pending, so
`pro_reviewed` remains false. The Lean interface described below is a
source-only candidate until that validation is complete.
{{< /panel >}}

## Abstract

The normalized {{< refterm "undamped-pendulum" "undamped pendulum" >}} is
written as the first-order system

\[
\theta'=\omega,
\qquad
\omega'=-\kappa\sin\theta.
\]

The source takes the state space to be the unwrapped plane
\(\mathbb R\times\mathbb R\): angle and angular velocity are real numbers,
even though adding a whole turn does not change the physical direction. It
defines the vector field

\[
F_\kappa(\theta,\omega)
=(\omega,-\kappa\sin\theta)
\]

and energy

\[
E_\kappa(\theta,\omega)
=\frac{\omega^2}{2}+\kappa(1-\cos\theta).
\]

The candidate proves continuity, classifies all field zeros when
\(\kappa\ne0\), records full-turn periodicity, evaluates exact benchmark
states, establishes energy nonnegativity for \(\kappa\ge0\), checks the
pointwise derivative cancellation behind energy conservation, and exhibits
the two familiar constant equilibrium curves. It does not construct the
nonconstant motion.

## Prior work, contribution, and non-claims

**Prior work.** Huygens's 1673 *Horologium Oscillatorium* is a foundational
historical treatment of pendulum motion. Arnold's *Mathematical Methods of
Classical Mechanics* places oscillations, differential equations, and phase
flows inside modern classical mechanics. The present normalization is the
standard unit-mass energy after absorbing the gravitational length scale into
one real parameter \(\kappa\). Mathlib 4.32.0 supplies real sine and cosine,
their exact special values and periodicity, their derivative rules, and the
`IsIntegralCurve` predicate used here.

**Contribution.** The candidate turns those ingredients into a small,
auditable bridge between a physical model and the repository's continuous
dynamics layer. Its most important design decision is the logical stopping
point: energy conservation is stated conditionally on component derivatives
that satisfy the equation at the time under consideration.

**Non-claims.** No theorem here constructs a solution through an arbitrary
initial state. No theorem bundles a {{< refterm "flow" "flow" >}}, proves
uniqueness or completeness, constructs a nonconstant periodic orbit,
classifies libration or rotation, or proves Lyapunov stability or
instability. The parameter \(\kappa\) is allowed to be any real number in the
algebraic definitions; physical gravitational pendula use \(\kappa\gt0\).
The upright equilibrium is listed, but its instability is not asserted.

## One exact state before the general formulas

Choose \(\kappa=1\), angle \(\theta=\pi/2\), and angular velocity
\(\omega=0\). Since \(\sin(\pi/2)=1\),

\[
F_1(\pi/2,0)=(0,-1).
\]

The first coordinate says that the angle is instantaneously stationary. The
second says that the angular velocity has derivative \(-1\). This is an
instantaneous statement at a phase-plane state, not a numerical time step.
It neither says where the bob is one second later nor constructs a curve
through the state.

At the same state, \(\cos(\pi/2)=0\), so

\[
E_1(\pi/2,0)=0+1(1-0)=1.
\]

These two equalities are formalized as
`pendulumVectorField_one_quarter_turn` and
`pendulumEnergy_one_quarter_turn`.

{{< reference-figure
  wide="true"
  src="quarter-turn-state.svg"
  alt="A pendulum bob at a rightward quarter turn is linked to the phase-plane state pi over two comma zero, the vector zero comma minus one, and energy one."
  caption="**One state, three objects:** the physical pose chooses an angle convention, the vector field supplies an instantaneous derivative, and the scalar energy labels the same state. The source proves the displayed exact identities."
>}}

## Why the state space is an angle cover

A physical direction repeats after \(2\pi\), but the simplest Lean state type
for this slice is \(\mathbb R\times\mathbb R\). Distinct real coordinates
\(\theta\) and \(\theta+2\pi n\) represent the same direction. Instead of
silently identifying them, the source proves the invariance that is actually
used:

\[
F_\kappa(\theta+2\pi n,\omega)=F_\kappa(\theta,\omega)
\]

and

\[
E_\kappa(\theta+2\pi n,\omega)=E_\kappa(\theta,\omega)
\]

for every integer \(n\). This separates a representational choice from a
mathematical theorem. A later development could replace the cover by a
quotient or Mathlib's angle type, but that would add coercion and quotient
interfaces without strengthening this milestone's derivative identity.

When \(\kappa\ne0\), the field vanishes exactly when \(\omega=0\) and
\(\sin\theta=0\). Mathlib's real sine zero-set theorem turns the latter into

\[
\theta=n\pi\quad\text{for some }n\in\mathbb Z.
\]

Even multiples are downward representatives and odd multiples are upright
representatives. The theorem intentionally lists all points on the cover;
calling only \((0,0)\) and \((\pi,0)\) “the equilibria” would conflate physical
directions with their repeated real representatives.

## Energy and the local cancellation

Assume component curves \(\theta(t)\) and \(\omega(t)\) are differentiable at
one time and satisfy

\[
\theta'(t)=\omega(t),
\qquad
\omega'(t)=-\kappa\sin(\theta(t)).
\]

Differentiate the energy using the power and chain rules:

\[
\begin{aligned}
\frac{d}{dt}E_\kappa(\theta(t),\omega(t))
&=\omega(t)\omega'(t)
  +\kappa\sin(\theta(t))\theta'(t)\\
&=\omega(t)(-\kappa\sin\theta(t))
  +\kappa\sin(\theta(t))\omega(t)\\
&=0.
\end{aligned}
\]

`hasDerivAt_pendulumEnergy_along` formalizes exactly this calculation. Its
two hypotheses are visible. It proves that the derivative is zero at the
chosen time; it does not quantify over a solution whose existence has not
been established.

For \(\kappa\ge0\), kinetic energy is nonnegative because it is a square
divided by two. The potential term is nonnegative because
\(\cos\theta\le1\). `pendulumEnergy_nonneg` combines those facts. The values
at the downward and upright states are recorded by `pendulumEnergy_down` and
`pendulumEnergy_up`: zero and \(2\kappa\), respectively.

{{< reference-figure
  wide="true"
  src="energy-cancellation-and-boundary.svg"
  alt="Two derivative terms, negative kappa omega sine theta and positive kappa sine theta omega, cancel. A boundary ladder stops before solution existence, periodic orbits, and stability."
  caption="**Checked identity and stopping point:** the algebra establishes zero energy derivative under the displayed ODE hypotheses. The crossed boundary records the additional constructions that are not consequences of this cancellation alone."
>}}

## Constant curves are genuine solutions

The candidate does prove two global {{< refterm "integral-curve" "integral curves" >}}.
At \((0,0)\) and \((\pi,0)\), the vector field is zero. A
constant curve has zero derivative at every real time, so the downward and
upright constant curves satisfy Mathlib's `IsIntegralCurve` definition.

These examples establish existence for those two initial states. They do not
establish existence for any non-equilibrium state. In particular, drawing a
closed energy contour and knowing the tangent field is consistent with it do
not by themselves construct a periodic parametrized orbit on that contour.

## In Lean

{{< lean-bridge
  human="A pendulum state consists of an unwrapped angle and an angular velocity, and the vector field returns their two derivatives."
  math="\( F_\kappa(\theta,\omega)=(\omega,-\kappa\sin\theta). \)"
  lean="def pendulumVectorField (κ : ℝ) (state : ℝ × ℝ) : ℝ × ℝ :=\n  (state.2, -κ * Real.sin state.1)"
>}}
`state.1` is the first coordinate \(\theta\); `state.2` is the second
coordinate \(\omega\). The returned pair has the same order. The unary minus
is part of the restoring angular acceleration.
{{< /lean-bridge >}}

{{< lean-bridge
  human="For nonzero κ, a state is an equilibrium exactly when its velocity is zero and its unwrapped angle is an integer multiple of pi."
  math="\( \kappa\ne0\Longrightarrow(F_\kappa(\theta,\omega)=0\iff\omega=0\land\exists n\in\mathbb Z,\ n\pi=\theta). \)"
  lean="theorem pendulumVectorField_eq_zero_iff_of_ne {κ : ℝ}\n    (hκ : κ ≠ 0) (state : ℝ × ℝ) :\n    pendulumVectorField κ state = 0 ↔\n      state.2 = 0 ∧ ∃ n : ℤ, (n : ℝ) * Real.pi = state.1"
>}}
`∧` requires both coordinate conditions. `∃ n : ℤ` exposes the repeated
representatives on the real angle cover. The hypothesis `hκ` removes the
degenerate zero field in the acceleration coordinate.
{{< /lean-bridge >}}

{{< lean-bridge
  human="If the component derivatives satisfy the pendulum equations at t, the energy derivative at t is zero."
  math="\( \theta'=\omega\land\omega'=-\kappa\sin\theta\Longrightarrow(E_\kappa\circ(\theta,\omega))'=0. \)"
  lean="theorem hasDerivAt_pendulumEnergy_along (κ : ℝ)\n    {θ ω : ℝ → ℝ} {t : ℝ}\n    (hθ : HasDerivAt θ (ω t) t)\n    (hω : HasDerivAt ω (-κ * Real.sin (θ t)) t) :\n    HasDerivAt (fun s ↦ pendulumEnergy κ (θ s, ω s)) 0 t"
>}}
Each `HasDerivAt` names a function, its derivative value, and the time. The
conclusion is also local at `t`; no solution object is hidden in the syntax.
{{< /lean-bridge >}}

{{< lean-bridge
  human="The downward equilibrium gives a constant global integral curve of the autonomous field."
  math="\( \gamma(t)=(0,0)\Longrightarrow\gamma'(t)=F_\kappa(\gamma(t))\text{ for every real }t. \)"
  lean="theorem pendulum_down_isIntegralCurve (κ : ℝ) :\n    IsIntegralCurve (fun _ : ℝ ↦ (0, 0))\n      (pendulumODEField κ)"
>}}
The underscore ignores time because the curve is constant.
`pendulumODEField` accepts time to match Mathlib's general ODE interface but
returns the same autonomous vector field at every time.
{{< /lean-bridge >}}

## Reproduce the candidate checks

~~~lean
import NonlinearDynamics.Deterministic.Models.Pendulum

open NonlinearDynamics.Deterministic.Models

#check pendulumVectorField
#check pendulumODEField
#check pendulumODEField_apply
#check continuous_pendulumVectorField
#check pendulumVectorField_down
#check pendulumVectorField_up
#check pendulumVectorField_eq_zero_iff_of_ne
#check pendulumVectorField_add_int_mul_two_pi
#check pendulumVectorField_one_quarter_turn
#check pendulumEnergy
#check pendulumEnergy_down
#check pendulumEnergy_up
#check pendulumEnergy_one_quarter_turn
#check pendulumEnergy_nonneg
#check pendulumEnergy_add_int_mul_two_pi
#check hasDerivAt_pendulumEnergy_along
#check pendulum_down_isIntegralCurve
#check pendulum_up_isIntegralCurve
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
Lean elaborates the source and constructs proof terms, then its kernel checks
those terms against the stated propositions. That process checks the formal
derivative and algebraic claims. It does not independently certify the
physical normalization, prove that arbitrary solutions exist, or establish
that every informal drawing corresponds to a formal orbit.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/Pendulum.lean
```

## Declaration ledger

- `pendulumVectorField`, `pendulumODEField`, and
  `pendulumODEField_apply` define the autonomous first-order system.
- `continuous_pendulumVectorField` records continuity of the phase-plane
  field.
- `pendulumVectorField_down`, `pendulumVectorField_up`, and
  `pendulumVectorField_eq_zero_iff_of_ne` give two representatives and the
  complete nondegenerate zero classification.
- `pendulumVectorField_add_int_mul_two_pi` records field periodicity on the
  unwrapped angle cover.
- `pendulumVectorField_one_quarter_turn` checks the benchmark vector.
- `pendulumEnergy`, `pendulumEnergy_down`, `pendulumEnergy_up`, and
  `pendulumEnergy_one_quarter_turn` define and evaluate the normalized energy.
- `pendulumEnergy_nonneg` proves nonnegativity under the explicit assumption
  \(\kappa\ge0\).
- `pendulumEnergy_add_int_mul_two_pi` records energy periodicity.
- `hasDerivAt_pendulumEnergy_along` proves the pointwise conservation
  identity under the two component ODE hypotheses.
- `pendulum_down_isIntegralCurve` and `pendulum_up_isIntegralCurve` exhibit
  the two constant global integral curves.

## Decision record

Three choices keep this first slice narrow and reusable.

First, the state is the unwrapped cover rather than an angle quotient. The
periodicity theorems make the repeated representation explicit, while the
plain product type gives direct access to Mathlib's derivative calculus.

Second, \(\kappa\) remains a parameter. Positivity is required only by the
energy nonnegativity theorem, and nonzeroness only by the equilibrium
classification. This preserves the exact degenerate cases instead of hiding
them in a global type-level restriction.

Third, conservation is local and conditional. This prevents an algebraic
chain-rule proof from being presented as a global existence, orbit, or
stability theorem. A later module can consume it after constructing the
appropriate solutions or flow.

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
  [`Analysis.SpecialFunctions.Trigonometric.Basic`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/SpecialFunctions/Trigonometric/Basic.lean),
  [`Analysis.SpecialFunctions.Trigonometric.Deriv`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/SpecialFunctions/Trigonometric/Deriv.lean),
  and
  [`Analysis.ODE.Basic`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/ODE/Basic.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.

Continue with the [Deep Dive]({{< relref
"/knowledge-base/deep-dives/pendulum-phase-plane-equilibria-and-energy" >}})
for the worked finite ledger and derivative calculation, or the [glossary
chapter]({{< relref "/knowledge-base/glossary/undamped-pendulum" >}}) for a
short orientation.
