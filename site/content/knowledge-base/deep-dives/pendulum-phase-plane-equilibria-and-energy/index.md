---
title: "Pendulum Phase Plane, Equilibria, and Energy"
slug: "pendulum-phase-plane-equilibria-and-energy"
date: 2026-08-10
summary: "Five exact quarter-turn states lead to the normalized pendulum field, its repeated equilibria, and the local cancellation behind energy conservation."
lead: "Compute a bounded ledger first, then distinguish what the vector field, energy identity, and constant curves each establish."
draft: true
pro_reviewed: false
level: "Introductory calculus and ordinary differential equations"
reading_time: "30 to 45 minutes"
prerequisites: "Sine, cosine, derivatives, ordered pairs, and equilibrium points are introduced through the worked example"
lean_module: "NonlinearDynamics.Deterministic.Models.Pendulum"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Models/Pendulum.lean"
lean_source_sha256: "52ec379c7f53c27b6977d5b1220dda2810f12e7c13a4e23ed746c400e8acf6d3"
toc: true
og_image: "pendulum-phase-plane-equilibria-and-energy-card.png"
og_image_alt: "Five pendulum angles map to phase-plane acceleration arrows and a normalized-energy ledger."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial and validation status.** This is a private AI-assisted working
draft. Professional review and pinned-toolchain validation remain pending;
`pro_reviewed` remains false.
{{< /panel >}}

## Start with five exact phase-plane states

Use the normalized {{< refterm "undamped-pendulum" "undamped pendulum" >}}
with \(\kappa=1\):

\[
\theta'=\omega,
\qquad
\omega'=-\sin\theta.
\]

A state is the ordered pair \((\theta,\omega)\). Fix the angular velocity at
zero and sample five quarter-turn representatives. Their exact trigonometric
values give this ledger:

| angle \(\theta\) | \(\sin\theta\) | field \(F_1(\theta,0)\) | \(\cos\theta\) | energy \(E_1(\theta,0)\) |
|---:|---:|---:|---:|---:|
| \(0\) | \(0\) | \((0,0)\) | \(1\) | \(0\) |
| \(\pi/2\) | \(1\) | \((0,-1)\) | \(0\) | \(1\) |
| \(\pi\) | \(0\) | \((0,0)\) | \(-1\) | \(2\) |
| \(3\pi/2\) | \(-1\) | \((0,1)\) | \(0\) | \(1\) |
| \(2\pi\) | \(0\) | \((0,0)\) | \(1\) | \(0\) |

At zero angular velocity the first field coordinate is zero. The second
coordinate gives the instantaneous angular acceleration. At \(\pi/2\) it is
negative, and at \(3\pi/2\) it is positive. Those two values point toward a
downward representative. They do not move the state through a finite time
step.

The table also shows the two kinds of equilibrium representative. Angles
\(0\) and \(2\pi\) represent the same downward physical direction, while
\(\pi\) represents the upright direction. Their field values are all zero,
but their normalized energies differ.

{{< reference-figure
  wide="true"
  src="five-state-ledger.svg"
  alt="Five pendulum poses at angles zero, pi over two, pi, three pi over two, and two pi have acceleration values zero, minus one, zero, one, zero and energies zero, one, two, one, zero."
  caption="**A finite anchor:** these five exact states display the restoring sign, repeated angle representatives, and benchmark energies. The finite ledger illustrates the general formulas; it does not quantify over every real angle."
>}}

The bundled **standalone tutorial** imports only `Std`. It stores the five
sine and cosine values as an explicit integer table, then checks the resulting
acceleration and twice-energy lists.

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/pendulum-phase-plane-equilibria-and-energy/pendulum-quarter-turns.lean
```

Its trust boundary is narrow. `decide` checks arithmetic on two concrete
five-entry integer lists. The sine and cosine samples are data in the file;
the worksheet does not derive them from real trigonometric functions and does
not establish the general ODE or conservation theorem.

## From a second-order equation to a vector field

For a simple undamped gravitational pendulum, a common normalization is

\[
\theta''=-\kappa\sin\theta,
\]

where \(\kappa\gt0\) contains the gravitational and length scale. Introduce
angular velocity \(\omega=\theta'\). The one second-order equation becomes
two first-order equations:

\[
\theta'=\omega,
\qquad
\omega'=-\kappa\sin\theta.
\]

The associated {{< refterm "vector-field" "vector field" >}} is

\[
F_\kappa(\theta,\omega)=(\omega,-\kappa\sin\theta).
\]

The first component is not a force; it is the rate of change of angle. The
second is the rate of change of angular velocity. A solution curve
\(\gamma(t)=(\theta(t),\omega(t))\) must have tangent vector
\(\gamma'(t)=F_\kappa(\gamma(t))\) at every time in its domain.

The Lean candidate uses \(\mathbb R\times\mathbb R\), not a circle times a
line. Thus \(0\), \(2\pi\), and \(-2\pi\) are different coordinates even
though they represent the same direction. This is why the source separately
proves

\[
F_\kappa(\theta+2\pi n,\omega)=F_\kappa(\theta,\omega)
\]

for every integer \(n\). It makes the repeated representation visible rather
than silently identifying coordinates.

## Classify the equilibria without a picture

An equilibrium is a state where the vector field is zero. For
\(\kappa\ne0\),

\[
F_\kappa(\theta,\omega)=(0,0)
\]

requires \(\omega=0\) from the first coordinate and
\(\sin\theta=0\) from the second. The real sine zero set is exactly the
integer multiples of \(\pi\), so

\[
\omega=0,
\qquad
\theta=n\pi\quad(n\in\mathbb Z).
\]

This is a classification on the unwrapped cover. Even \(n\) gives a downward
representative and odd \(n\) gives an upright representative. The present
module does not prove the familiar stability distinction between them.

The hypothesis \(\kappa\ne0\) matters. If \(\kappa=0\), the field is
\((\omega,0)\), so every zero-velocity state is an equilibrium, not only the
integer-multiple angles. Keeping this degenerate case out of the theorem is
an explicit assumption, not a cancellation hidden inside a division.

## Build the energy from two terms

The normalized energy is

\[
E_\kappa(\theta,\omega)
=\underbrace{\frac{\omega^2}{2}}_{\text{kinetic}}
+\underbrace{\kappa(1-\cos\theta)}_{\text{potential}}.
\]

The potential is zero at a downward representative. At the upright state it
is \(2\kappa\). Adding \(2\pi n\) to the angle leaves cosine unchanged, so
energy is periodic in the same angle coordinate as the field.

If \(\kappa\ge0\), both terms are nonnegative. The kinetic term is a square
divided by a positive number. The inequality \(\cos\theta\le1\) gives
\(1-\cos\theta\ge0\), and multiplication by nonnegative \(\kappa\) preserves
that inequality. This proves `pendulumEnergy_nonneg`; it does not require a
solution curve.

{{< reference-figure
  wide="true"
  src="energy-landscape.svg"
  alt="A periodic potential curve kappa times one minus cosine theta has minima at even multiples of pi and maxima at odd multiples. Vertical kinetic energy lifts a phase-plane state above the potential curve."
  caption="**Energy as a landscape:** the potential repeats across the unwrapped angle coordinate. Angular velocity contributes a nonnegative vertical amount. Level-set geometry is informative, but the current source does not construct motion along a level set."
>}}

## Why the energy derivative vanishes

Now suppose two differentiable component curves obey the pendulum equations
at a particular time \(t\):

\[
\theta'(t)=\omega(t),
\qquad
\omega'(t)=-\kappa\sin(\theta(t)).
\]

The derivative rules give

\[
\frac{d}{dt}\frac{\omega(t)^2}{2}
=\omega(t)\omega'(t)
\]

and

\[
\frac{d}{dt}\kappa(1-\cos(\theta(t)))
=\kappa\sin(\theta(t))\theta'(t).
\]

Substitute the two ODE values:

\[
-\kappa\omega(t)\sin(\theta(t))
+\kappa\sin(\theta(t))\omega(t)=0.
\]

This cancellation is the candidate theorem
`hasDerivAt_pendulumEnergy_along`. It is a general real-algebra and calculus
statement, unlike the finite worksheet. Its conclusion is still local: the
energy derivative is zero at the time where the hypotheses hold.

To conclude that energy is constant on an interval, one would combine such a
derivative theorem holding throughout the interval with a theorem that zero
derivative implies constancy under the appropriate domain assumptions. To
obtain a statement for every initial condition, one would also need to
construct or invoke existence of the corresponding solution. Those bridges
are outside this slice.

## What the two constant curves establish

At \((0,0)\), both components of the vector field vanish. The constant curve
\(t\mapsto(0,0)\) has zero derivative and is therefore a global
{{< refterm "integral-curve" "integral curve" >}}. Exactly the same argument
works at \((\pi,0)\).

These two theorems establish global solutions through two equilibrium
states. They do not imply that the upright equilibrium is stable or unstable.
They also do not construct a nonconstant solution through the quarter-turn
state. A vector field, a scalar first integral, and a phase portrait are
related objects, but their existence claims are not interchangeable.

## In Lean

{{< lean-bridge
  human="The exact quarter-turn benchmark has field vector zero comma minus one."
  math="\( F_1(\pi/2,0)=(0,-1). \)"
  lean="theorem pendulumVectorField_one_quarter_turn :\n    pendulumVectorField 1 (Real.pi / 2, 0) = (0, -1)"
>}}
`Real.pi / 2` is an exact real expression, not a decimal approximation. The
pair on the right gives angle derivative first and angular-velocity derivative
second.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Adding any integer number of full turns leaves the vector field unchanged."
  math="\( F_\kappa(\theta+2\pi n,\omega)=F_\kappa(\theta,\omega). \)"
  lean="theorem pendulumVectorField_add_int_mul_two_pi\n    (κ θ ω : ℝ) (n : ℤ) :\n    pendulumVectorField κ (θ + n * (2 * Real.pi), ω) =\n      pendulumVectorField κ (θ, ω)"
>}}
`n : ℤ` allows positive, zero, and negative turn counts. Lean coerces the
integer into a real number inside the angle expression.
{{< /lean-bridge >}}

{{< lean-bridge
  human="For nonnegative κ, every phase-plane state has nonnegative normalized energy."
  math="\( \kappa\ge0\Longrightarrow E_\kappa(\theta,\omega)\ge0. \)"
  lean="theorem pendulumEnergy_nonneg {κ : ℝ}\n    (hκ : 0 ≤ κ) (state : ℝ × ℝ) :\n    0 ≤ pendulumEnergy κ state"
>}}
The named hypothesis `hκ` is used only where the sign of the potential term
requires it. The vector-field and derivative definitions remain meaningful
for every real parameter.
{{< /lean-bridge >}}

{{< lean-bridge
  human="The upright equilibrium also defines a constant global integral curve."
  math="\( \gamma(t)=(\pi,0)\Longrightarrow\gamma'=F_\kappa\circ\gamma. \)"
  lean="theorem pendulum_up_isIntegralCurve (κ : ℝ) :\n    IsIntegralCurve (fun _ : ℝ ↦ (Real.pi, 0))\n      (pendulumODEField κ)"
>}}
`IsIntegralCurve` quantifies over every real time. This theorem is global
because the particular curve is explicitly constant, not because a general
global-existence theorem has been proved.
{{< /lean-bridge >}}

## Try the full project module

~~~lean
import NonlinearDynamics.Deterministic.Models.Pendulum

open NonlinearDynamics.Deterministic.Models

#check continuous_pendulumVectorField
#check pendulumVectorField_eq_zero_iff_of_ne
#check pendulumVectorField_add_int_mul_two_pi
#check pendulumVectorField_one_quarter_turn
#check pendulumEnergy_down
#check pendulumEnergy_up
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
This command checks general theorems over real angles, velocities, parameters,
and differentiable curves. It is logically different from the bounded `Std`
worksheet, which checks arithmetic after five trigonometric values have been
encoded as finite data.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/Pendulum.lean
```

## Misconceptions and limits

- A field vector is an instantaneous derivative, not the state after one
  unit of time.
- The coordinates \(\theta\) and \(\theta+2\pi\) are different points in the
  chosen Lean type even though the field and energy agree there.
- A five-state table illustrates exact cases; it does not establish a theorem
  for all real angles.
- Zero energy derivative under ODE hypotheses does not construct a solution
  satisfying those hypotheses.
- A closed energy level in a drawing does not, by itself, establish a
  nonconstant periodic orbit or its period.
- Listing the downward and upright equilibria does not establish their
  stability classifications.
- The module has no friction or forcing term. Damped and driven pendula have
  different energy balances.
- No {{< refterm "flow" "flow" >}} is constructed, so the repository's
  flow-level stability and attraction predicates are not instantiated.

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

See the [glossary chapter]({{< relref
"/knowledge-base/glossary/undamped-pendulum" >}}) for a shorter orientation or
the [Research Note]({{< relref
"/development-notebook/2026/08/pendulum-vector-field-and-energy-in-lean" >}})
for the source-design and claim-boundary record.
