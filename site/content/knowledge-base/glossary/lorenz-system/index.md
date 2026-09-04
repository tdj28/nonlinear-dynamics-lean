---
title: "Lorenz system"
slug: "lorenz-system"
summary: "A three-coordinate autonomous polynomial ordinary differential equation introduced by Edward Lorenz as a severe truncation of a convection model."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Models.Lorenz"
tags:
  - "Continuous dynamics"
  - "Ordinary differential equations"
  - "Lorenz system"
  - "Vector fields"
  - "Equilibria"
og_image: "lorenz-system-card.png"
og_image_alt: "The Lorenz sign flip exchanges two nonzero equilibria while preserving the third coordinate."
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
**Editorial and validation status.** This is an AI-assisted working draft.
Professional review remains pending, so `pro_reviewed` remains false.

**Status correction, 2026-09-04.** The linked Lean source snapshot
has passed warning-fatal pinned-toolchain validation and the complete
repository gate. The earlier pending-validation label was stale.
{{< /panel >}}

The **Lorenz system** is the three-coordinate autonomous ordinary differential
equation

\[
\begin{aligned}
x'&=\sigma(y-x),\\
y'&=x(\rho-z)-y,\\
z'&=xy-\beta z.
\end{aligned}
\]

Lorenz introduced the equations in 1963 after a severe finite-mode truncation
of convection equations. In his notation, \(x\) measures convective intensity,
\(y\) measures a horizontal temperature difference, and \(z\) measures a
distortion of the vertical temperature profile. The system is a historically
important low-dimensional model, not a complete model of the atmosphere.

The associated {{< refterm "vector-field" "vector field" >}} is

\[
F(x,y,z)=\bigl(\sigma(y-x),x(\rho-z)-y,xy-\beta z\bigr).
\]

It returns an instantaneous tangent vector. Computing \(F(p)\) at one state
does not compute the state after one unit of time.

## One classical field value

Lorenz used the parameter values

\[
\sigma=10,\qquad \rho=28,\qquad \beta=\frac83.
\]

At \((x,y,z)=(1,2,3)\),

\[
F(1,2,3)=\left(10(2-1),1(28-3)-2,
  1\cdot2-\frac83\cdot3\right)=(10,23,-6).
\]

The Lean theorem checks this exact rational field value. It does not use a
floating-point integrator and does not describe a trajectory.

## A symmetry and three equilibria

The simultaneous sign flip

\[
S(x,y,z)=(-x,-y,z)
\]

is an involution and satisfies \(F(S(p))=S(F(p))\). It changes the signs of
the first two derivative coordinates and preserves the third.

Assume \(\sigma\ne0\), \(\beta\gt0\), and \(\rho\gt1\). Then the field zeros
are exactly

\[
(0,0,0),\qquad
(q,q,\rho-1),\qquad
(-q,-q,\rho-1),
\quad q=\sqrt{\beta(\rho-1)}.
\]

The two nonzero points are exchanged by \(S\). Calling them equilibria says
only that the vector field vanishes there. It does not state whether they are
stable, unstable, attracting, or part of an attractor.

{{< reference-figure
  wide="true"
  src="lorenz-symmetry-and-scope.svg"
  alt="The Lorenz sign flip sends the positive equilibrium q q rho minus one to the negative equilibrium minus q minus q rho minus one, while field algebra stops before attractor and chaos claims."
  caption="**Paired field zeros:** simultaneous negation of the first two coordinates exchanges the nonzero equilibria and commutes with the field. The diagram explains this algebraic relation only; it is not a Lorenz-attractor image."
>}}

## In Lean

{{< lean-bridge
  human="The right-associated state stores x first, then y and z inside the second component."
  math="\(F(x,y,z)=(\sigma(y-x),x(\rho-z)-y,xy-\beta z).\)"
  lean="def lorenzVectorField (sigma rho beta : ℝ)\n    (state : ℝ × ℝ × ℝ) : ℝ × ℝ × ℝ :=\n  (sigma * (state.2.1 - state.1),\n    state.1 * (rho - state.2.2) - state.2.1,\n    state.1 * state.2.1 - beta * state.2.2)"
>}}
`state.1` is \(x\), `state.2.1` is \(y\), and `state.2.2` is \(z\). The
returned nested product follows the same order.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Under the displayed hypotheses, exactly three real states are field zeros."
  math="\(F(p)=0\iff p=0\lor p=p_+\lor p=p_-.\)"
  lean="theorem lorenzVectorField_eq_zero_iff_of_pos\n    {sigma rho beta : ℝ} (hSigma : sigma ≠ 0)\n    (hBeta : 0 < beta) (hRho : 1 < rho)\n    (state : ℝ × ℝ × ℝ) :\n    lorenzVectorField sigma rho beta state = 0 ↔\n      state = (0, 0, 0) ∨\n        state = lorenzPositiveEquilibrium rho beta ∨\n        state = lorenzNegativeEquilibrium rho beta"
>}}
The theorem's nested disjunction lists the origin, positive-sign state, and
negative-sign state. Each parameter hypothesis rules out a degenerate algebraic
branch.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.Models.Lorenz

open NonlinearDynamics.Deterministic.Models

#check lorenzVectorField
#check continuous_lorenzVectorField
#check lorenzSymmetry
#check lorenzVectorField_symmetry
#check lorenzVectorField_classical_benchmark
#check lorenzPositiveEquilibrium
#check lorenzNegativeEquilibrium
#check lorenzVectorField_eq_zero_iff_of_pos
#check lorenz_origin_isIntegralCurve
~~~

This is a **full project check** on macOS or Linux. It uses the pinned Lean and
Mathlib dependencies and may require substantial disk space or build time.

{{< repo-check >}}
Lean's elaborator constructs candidate proof terms and its kernel checks them
against the exact source statements. This checks the encoded field algebra.
It does not establish the existence or chaotic
properties of a Lorenz attractor.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/Lorenz.lean
```

Continue with the [Deep Dive]({{< relref
"/knowledge-base/deep-dives/lorenz-three-coordinate-field-symmetry-and-equilibria" >}})
for the five-state standalone worksheet and complete equilibrium proof.

## Boundary cases and nonclaims

- Parameter letters and order vary across modern presentations. This
  repository fixes \((\sigma,\rho,\beta)\).
- Lean parses `ℝ × ℝ × ℝ` as a right-associated product.
- If \(\sigma=0\), \(\beta=0\), or \(\rho\le1\), the three-state
  classification does not apply unchanged.
- Field equivariance is not a theorem about a selected global flow.
- An equilibrium list does not establish local stability or a bifurcation.
- Constant equilibrium curves do not establish existence through arbitrary
  initial states.
- No boundedness, absorbing set, attractor, sensitive dependence,
  transitivity, periodic-orbit density, mixing, or chaos theorem is included.
- A numerical butterfly-shaped trace would illustrate computed behavior but
  would not supply one of those omitted proofs.

## References

- Edward N. Lorenz, “Deterministic Nonperiodic Flow,” *Journal of the
  Atmospheric Sciences* 20 (1963), 130–141, especially equations (25)–(27)
  and the coordinate interpretation on p. 134, the additional steady states
  on p. 135, and the classical numerical parameters on p. 136,
  [DOI 10.1175/1520-0469(1963)020<0130:DNF>2.0.CO;2](https://doi.org/10.1175/1520-0469%281963%29020%3C0130%3ADNF%3E2.0.CO%3B2).
- Warwick Tucker, “A Rigorous ODE Solver and Smale's 14th Problem,”
  *Foundations of Computational Mathematics* 2 (2002), 53–117,
  [DOI 10.1007/s002080010018](https://doi.org/10.1007/s002080010018).
- Mathlib contributors,
  [`Analysis.ODE.Basic`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/ODE/Basic.lean)
  and
  [`Analysis.Real.Sqrt`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Real/Sqrt.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.
