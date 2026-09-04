---
title: "Lorenz Vector Field, Symmetry, and Equilibria in Lean"
slug: "lorenz-vector-field-symmetry-and-equilibria-in-lean"
date: 2026-08-12
summary: "The classical three-parameter Lorenz equations get an explicit product-coordinate convention, exact field benchmarks, sign-flip symmetry, and a complete positive-parameter equilibrium classification."
lead: "Start with five integer states, then separate polynomial field algebra from the much harder theorems about solutions, attractors, and chaos."
draft: true
pro_reviewed: false
tags:
  - "Lean"
  - "Continuous dynamics"
  - "Ordinary differential equations"
  - "Lorenz system"
  - "Vector fields"
  - "Equilibria"
lean_module: "NonlinearDynamics.Deterministic.Models.Lorenz"
lean_source: "formalization/NonlinearDynamics/Deterministic/Models/Lorenz.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Models/Lorenz.lean"
lean_source_sha256: "d24e390c28dc9f2ab91e9d23cdd2b54897e64d67e0f2da72bba8541ca489a835"
toc: true
og_image: "lorenz-vector-field-symmetry-and-equilibria-in-lean-card.png"
og_image_alt: "The Lorenz state one comma two comma three maps to the exact tangent vector ten comma twenty-three comma minus six, beside two symmetry-related equilibria."
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
**Editorial status.** This is an AI-assisted working draft.
Professional review remains pending, so `pro_reviewed` remains false.

**Status correction, 2026-09-04.** The linked Lean source snapshot
has passed warning-fatal pinned-toolchain validation and the complete
repository gate. The earlier pending-validation label was stale.
{{< /panel >}}

## Abstract

The classical {{< refterm "lorenz-system" "Lorenz system" >}} used here is

\[
\begin{aligned}
x'&=\sigma(y-x),\\
y'&=x(\rho-z)-y,\\
z'&=xy-\beta z.
\end{aligned}
\]

The module defines this polynomial
{{< refterm "vector-field" "vector field" >}} on the right-associated Lean product
\(\mathbb R\times(\mathbb R\times\mathbb R)\). It proves continuity,
records the origin and two axis formulas, checks the classical field value at
\((1,2,3)\), formalizes the symmetry
\((x,y,z)\mapsto(-x,-y,z)\), and classifies every field zero under
\(\sigma\ne0\), \(\beta\gt0\), and \(\rho\gt1\).

The source constructs only three constant integral curves, one through each
equilibrium. It does not construct a solution through an arbitrary state,
prove boundedness or completeness, build a global flow, define an absorbing
set, construct the Lorenz attractor, or establish any chaos property.

## Prior work, contribution, and non-claims

**Prior work.** Lorenz derives equations (25) through (27) in his 1963 paper
from a severe finite-mode truncation of convection equations. On p. 135 he
records the two additional steady states for \(\rho\gt1\) as
\(X=Y=\pm\sqrt{\beta(\rho-1)}\), \(Z=\rho-1\). The paper then studies the
classical values \(\sigma=10\), \(\beta=8/3\), and \(\rho=28\) using
numerical solutions. Tucker's later computer-assisted work establishes a
strange-attractor result for the classical equations with a much larger
analytic and validated-numerical argument.

**Contribution.** This module freezes the source convention as parameter
order \((\sigma,\rho,\beta)\), coordinate order \((x,y,z)\), and Lean carrier
`ℝ × ℝ × ℝ`. It isolates reusable algebraic facts that precede trajectory
analysis: exact field values, continuity, symmetry, equilibrium construction,
equilibrium completeness under visible hypotheses, and constant curves.

**Non-claims.** A polynomial formula and three field zeros do not establish
global solutions. Symmetry does not establish recurrence or mixing. A plotted
trajectory or finite worksheet would not establish an attractor, sensitive
dependence, transitivity, dense periodic points, or chaos. None of those
conclusions appears in the Lean source.

## One exact state before the general algebra

Use Lorenz's classical parameters and the exact state \((1,2,3)\):

\[
\begin{aligned}
x'&=10(2-1)=10,\\
y'&=1(28-3)-2=23,\\
z'&=1\cdot2-\frac83\cdot3=-6.
\end{aligned}
\]

Therefore

\[
F_{10,28,8/3}(1,2,3)=(10,23,-6).
\]

This pair of equalities checks one tangent vector with exact rational
arithmetic. It does not advance the state to time one and it does not sample a
numerical solver.

{{< reference-figure
  wide="true"
  src="classical-state-ledger.svg"
  alt="At Lorenz state one comma two comma three, the classical parameters give coordinate derivatives ten, twenty-three, and minus six."
  caption="**One field evaluation:** each of the three coordinate formulas is evaluated exactly. The returned triple is an instantaneous tangent vector, not the state after a finite time interval."
>}}

## Make the triple convention visible

Lean's product symbol is right associative. The type

```lean
ℝ × ℝ × ℝ
```

means `ℝ × (ℝ × ℝ)`. For a state representing \((x,y,z)\), the selectors are
therefore:

| Mathematical coordinate | Lean selector |
|---|---|
| \(x\) | `state.1` |
| \(y\) | `state.2.1` |
| \(z\) | `state.2.2` |

The vector field returns a value in the same association and coordinate order.
This representation is elementary and already carries the product normed-space
instances used by Mathlib's ODE interface.

## Two axis formulas

On the \(z\)-axis,

\[
F(0,0,z)=(0,0,-\beta z).
\]

On the \(x\)-axis,

\[
F(x,0,0)=(-\sigma x,\rho x,0).
\]

The first formula shows tangency to the \(z\)-axis. The second shows that the
field usually points away from the \(x\)-axis in the \(y\) coordinate. These
are identities at individual states. Only the constant origin curve is
constructed in this slice; no general axis-invariance theorem is inferred.

## The simultaneous sign-flip symmetry

Define

\[
S(x,y,z)=(-x,-y,z).
\]

Applying \(S\) twice returns the original state. Direct substitution also
gives

\[
F(S(p))=S(F(p)).
\]

The first two output coordinates change sign, while the third does not:
\((-x)(-y)=xy\). The theorem `lorenzVectorField_symmetry` records this
equivariance exactly. It implies that field-zero candidates occur in symmetric
pairs. It does not say that a nonconstant orbit crosses from one lobe of a
phase portrait to another.

{{< reference-figure
  wide="true"
  src="symmetry-equilibria-boundary.svg"
  alt="The Lorenz sign flip maps x y z to minus x minus y z and exchanges the two nonzero equilibria, while a boundary stops before flow, attractor, and chaos claims."
  caption="**Algebraic symmetry and its limit:** the sign flip is an involution and the field commutes with it. This explains the paired equilibrium formulas, but it supplies none of the orbit-level statements beyond the boundary."
>}}

## Classify the equilibria

An equilibrium is a state where all three field coordinates vanish. The
origin always works. Assume now

\[
\sigma\ne0,\qquad \beta\gt0,\qquad \rho\gt1.
\]

The first zero equation forces \(y=x\). Substituting this into the second gives

\[
x(\rho-z-1)=0.
\]

If \(x=0\), the third equation and \(\beta\gt0\) force \(z=0\), so the state
is the origin. If \(x\ne0\), then \(z=\rho-1\), and the third equation becomes

\[
x^2=\beta(\rho-1).
\]

The radicand is positive under the displayed hypotheses. Hence the remaining
states are

\[
p_+=\bigl(q,q,\rho-1\bigr),\qquad
p_-=\bigl(-q,-q,\rho-1\bigr),
\quad q=\sqrt{\beta(\rho-1)}.
\]

The source separates construction from completeness. Two theorems substitute
\(p_+\) and \(p_-\) into the field under the weaker assumption that the
radicand is nonnegative. The classification theorem then uses the stronger
nondegeneracy and sign hypotheses to show that there are no other zeros.

For the integer-friendly parameters \((\sigma,\rho,\beta)=(1,3,2)\), the
radius is two and the nonzero equilibria are \((2,2,2)\) and
\((-2,-2,2)\). Those are the finite worksheet's two nonzero zero-field rows.

## Constant curves are the only curves constructed here

A constant curve has derivative zero. At any state where the Lorenz field is
zero, that derivative equals the field value, so the curve is an
{{< refterm "integral-curve" "integral curve" >}}. The source constructs the
constant origin curve for all parameters and the two nonzero constant curves
whenever \(\beta(\rho-1)\ge0\).

`IsIntegralCurve` quantifies over every real time, but only for each explicitly
constant function. It does not supply local existence, uniqueness, or a
{{< refterm "flow" "flow" >}} through arbitrary initial conditions.

## In Lean

{{< lean-bridge
  human="The field stores x first, then the right-associated pair y comma z, and returns derivatives in the same order."
  math="\(F(x,y,z)=(\sigma(y-x),x(\rho-z)-y,xy-\beta z).\)"
  lean="def lorenzVectorField (sigma rho beta : ℝ)\n    (state : ℝ × ℝ × ℝ) : ℝ × ℝ × ℝ :=\n  (sigma * (state.2.1 - state.1),\n    state.1 * (rho - state.2.2) - state.2.1,\n    state.1 * state.2.1 - beta * state.2.2)"
>}}
`state.1`, `state.2.1`, and `state.2.2` are respectively \(x\), \(y\), and
\(z\). Each output coordinate is a polynomial in those selectors.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Simultaneously negating x and y commutes with the vector field."
  math="\(F(S(p))=S(F(p))\), where \(S(x,y,z)=(-x,-y,z)\)."
  lean="theorem lorenzVectorField_symmetry (sigma rho beta : ℝ)\n    (state : ℝ × ℝ × ℝ) :\n    lorenzVectorField sigma rho beta (lorenzSymmetry state) =\n      lorenzSymmetry (lorenzVectorField sigma rho beta state)"
>}}
The equality is pointwise for every real parameter choice and every state. It
is a field identity, not an orbit-construction theorem.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Under the classical sign and nondegeneracy hypotheses, exactly three states are field zeros."
  math="\(F(p)=0\iff p=0\lor p=p_+\lor p=p_-.\)"
  lean="theorem lorenzVectorField_eq_zero_iff_of_pos\n    {sigma rho beta : ℝ} (hSigma : sigma ≠ 0)\n    (hBeta : 0 < beta) (hRho : 1 < rho)\n    (state : ℝ × ℝ × ℝ) :\n    lorenzVectorField sigma rho beta state = 0 ↔\n      state = (0, 0, 0) ∨\n        state = lorenzPositiveEquilibrium rho beta ∨\n        state = lorenzNegativeEquilibrium rho beta"
>}}
The nested `∨` lists three alternatives. `hSigma` permits cancellation in the
first equation, while `hBeta` and `hRho` control the remaining algebra and the
square-root radicand.
{{< /lean-bridge >}}

## Reproduce the project check

~~~lean
import NonlinearDynamics.Deterministic.Models.Lorenz

open NonlinearDynamics.Deterministic.Models

#check lorenzVectorField
#check lorenzODEField
#check lorenzODEField_apply
#check continuous_lorenzVectorField
#check lorenzSymmetry
#check lorenzSymmetry_involutive
#check lorenzVectorField_symmetry
#check lorenzVectorField_origin
#check lorenzVectorField_zAxis
#check lorenzVectorField_xAxis
#check lorenzVectorField_classical_benchmark
#check lorenzEquilibriumRadius
#check lorenzPositiveEquilibrium
#check lorenzNegativeEquilibrium
#check lorenzSymmetry_positiveEquilibrium
#check lorenzVectorField_positiveEquilibrium
#check lorenzVectorField_negativeEquilibrium
#check lorenzVectorField_eq_zero_iff_of_pos
#check lorenz_origin_isIntegralCurve
#check lorenz_positiveEquilibrium_isIntegralCurve
#check lorenz_negativeEquilibrium_isIntegralCurve
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
Lean's elaborator constructs proof terms for the exact source statements, and
its kernel checks those terms against the formal statements. That
does not establish any omitted trajectory, attractor, or chaos statement, and
it does not by itself audit the match between Lorenz's notation and this
formal interface.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/Lorenz.lean
```

## Declaration ledger

- `lorenzVectorField`, `lorenzODEField`, and `lorenzODEField_apply` define the
  autonomous system.
- `continuous_lorenzVectorField` proves continuity of the polynomial field.
- `lorenzSymmetry`, `lorenzSymmetry_involutive`, and
  `lorenzVectorField_symmetry` define and verify the sign-flip interface.
- `lorenzVectorField_origin`, `lorenzVectorField_zAxis`, and
  `lorenzVectorField_xAxis` record the origin and two coordinate-axis values.
- `lorenzVectorField_classical_benchmark` checks the exact classical field
  value \((1,2,3)\mapsto(10,23,-6)\).
- `lorenzEquilibriumRadius`, `lorenzPositiveEquilibrium`, and
  `lorenzNegativeEquilibrium` define the two nonzero candidates.
- `lorenzSymmetry_positiveEquilibrium` records that symmetry exchanges them.
- `lorenzVectorField_positiveEquilibrium` and
  `lorenzVectorField_negativeEquilibrium` prove they are field zeros under a
  nonnegative radicand.
- `lorenzVectorField_eq_zero_iff_of_pos` proves completeness of the three-state
  list under \(\sigma\ne0\), \(\beta\gt0\), and \(\rho\gt1\).
- `lorenz_origin_isIntegralCurve`,
  `lorenz_positiveEquilibrium_isIntegralCurve`, and
  `lorenz_negativeEquilibrium_isIntegralCurve` construct the three constant
  global integral curves.

## Decision record

First, the parameter order is \((\sigma,\rho,\beta)\), matching Lorenz's
equations while using `rho` and `beta` as ASCII Lean names. The classical
values are recorded in that same order.

Second, the state type is the right-associated product
\(\mathbb R\times(\mathbb R\times\mathbb R)\). The selector ledger is stated
in both source comments and teaching prose so a reader does not silently swap
the second and third coordinates.

Third, the nonzero candidate theorems use only radicand nonnegativity. The
complete classification adds precisely the assumptions used to cancel
\(\sigma\), force \(z=0\) on the zero branch, and make the classical nonzero
branch available.

Fourth, the milestone stops at constant curves. Lorenz's numerical trajectories
and Tucker's strange-attractor theorem require mathematical objects and proof
obligations not represented by these algebraic declarations.

## References

- Edward N. Lorenz, “Deterministic Nonperiodic Flow,” *Journal of the
  Atmospheric Sciences* 20 (1963), 130–141, especially equations (25)–(27)
  and the variable interpretation on p. 134, the additional steady states and
  bounded-region discussion on p. 135, and the numerical parameter choice on
  p. 136,
  [DOI 10.1175/1520-0469(1963)020<0130:DNF>2.0.CO;2](https://doi.org/10.1175/1520-0469%281963%29020%3C0130%3ADNF%3E2.0.CO%3B2).
- Warwick Tucker, “A Rigorous ODE Solver and Smale's 14th Problem,”
  *Foundations of Computational Mathematics* 2 (2002), 53–117,
  [DOI 10.1007/s002080010018](https://doi.org/10.1007/s002080010018).
- Mathlib contributors,
  [`Analysis.ODE.Basic`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/ODE/Basic.lean)
  and
  [`Analysis.Real.Sqrt`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Real/Sqrt.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.

Continue with the [Deep Dive]({{< relref
"/knowledge-base/deep-dives/lorenz-three-coordinate-field-symmetry-and-equilibria" >}})
for the finite worksheet and proof architecture, or the [glossary
chapter]({{< relref "/knowledge-base/glossary/lorenz-system" >}}) for a shorter
orientation.
