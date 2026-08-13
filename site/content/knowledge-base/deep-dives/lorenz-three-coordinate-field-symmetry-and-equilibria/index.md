---
title: "Lorenz: Three-Coordinate Field, Symmetry, and Equilibria"
slug: "lorenz-three-coordinate-field-symmetry-and-equilibria"
date: 2026-08-12
summary: "Five exact integer states introduce the Lorenz vector field, its simultaneous sign-flip symmetry, and the three positive-parameter equilibria without making an attractor or chaos claim."
lead: "Compute a finite state ledger first, then climb from product coordinates to the complete equilibrium proof and its strict stopping point."
draft: true
pro_reviewed: false
level: "Introductory algebra and ordinary differential equations"
reading_time: "30 to 45 minutes"
prerequisites: "Ordered triples, square roots, vector fields, and equilibria are introduced through the worked example"
lean_module: "NonlinearDynamics.Deterministic.Models.Lorenz"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Models/Lorenz.lean"
lean_source_sha256: "602368c3e382c1686e1a8a5c6c4ebbf48f76dffe824588e7ba7a2b6433c68665"
toc: true
og_image: "lorenz-three-coordinate-field-symmetry-and-equilibria-card.png"
og_image_alt: "Five exact Lorenz states include the origin, two symmetric equilibria, and two symmetry-related nonzero field vectors."
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

## Start with five exact states

Choose the integer-friendly parameters

\[
(\sigma,\rho,\beta)=(1,3,2).
\]

The {{< refterm "lorenz-system" "Lorenz vector field" >}} becomes

\[
F(x,y,z)=\bigl(y-x,\;x(3-z)-y,\;xy-2z\bigr).
\]

Evaluate five integer states:

| State \((x,y,z)\) | First coordinate | Second coordinate | Third coordinate | Field value |
|---|---:|---:|---:|---|
| \((0,0,0)\) | \(0\) | \(0\) | \(0\) | \((0,0,0)\) |
| \((2,2,2)\) | \(0\) | \(0\) | \(0\) | \((0,0,0)\) |
| \((-2,-2,2)\) | \(0\) | \(0\) | \(0\) | \((0,0,0)\) |
| \((1,2,3)\) | \(1\) | \(-2\) | \(-4\) | \((1,-2,-4)\) |
| \((-1,-2,3)\) | \(-1\) | \(2\) | \(-4\) | \((-1,2,-4)\) |

The first three rows are the complete equilibrium list for this parameter
choice. The last two states are exchanged by simultaneous negation of \(x\)
and \(y\), and their field vectors transform the same way. Every entry is an
instantaneous derivative.

{{< reference-figure
  wide="true"
  src="five-state-lorenz-ledger.svg"
  alt="Five integer Lorenz states map to three zero vectors followed by vectors one minus two minus four and minus one two minus four."
  caption="**A bounded exact ledger:** three stored rows are equilibria, while the last pair checks the sign-flip pattern. Exhausting these five rows does not classify arbitrary real states; the general Lean theorem supplies that separate proof."
>}}

The bundled **standalone tutorial** imports only `Std`. It evaluates the five
integer rows and checks the sign-flip relation on the two stored nonzero rows.

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/lorenz-three-coordinate-field-symmetry-and-equilibria/lorenz-five-states.lean
```

Its trust boundary is finite. `decide` checks the stored integer lists and the
stored symmetry relation. The worksheet does not quantify over real states,
reason about square roots, construct solutions, or establish an attractor.

## Recover the three-parameter equations

Lorenz's equations (25) through (27), using modern Greek parameter names, are

\[
\begin{aligned}
x'&=\sigma(y-x),\\
y'&=x(\rho-z)-y,\\
z'&=xy-\beta z.
\end{aligned}
\]

Lorenz identifies \(x\) with convective intensity, \(y\) with the temperature
difference between ascending and descending currents, and \(z\) with the
distortion of the vertical temperature profile. The equations arise after a
severe truncation. Keeping that origin visible prevents the three-coordinate
system from being described as a complete atmospheric model.

The Lean definition accepts arbitrary real parameters. The classical physical
regime has positive parameters, but continuity and symmetry require no sign
hypothesis.

## Read a right-associated Lean triple

Lean parses `ℝ × ℝ × ℝ` as `ℝ × (ℝ × ℝ)`. If `state` represents
\((x,y,z)\), then

\[
x=\texttt{state.1},\qquad
y=\texttt{state.2.1},\qquad
z=\texttt{state.2.2}.
\]

The notation `(x, y, z)` elaborates to the same nested product. The source
uses the selectors explicitly in the vector-field definition, then destructures
the state into three names inside proofs.

This choice avoids introducing a custom three-coordinate structure before one
is needed. It also means that any code copied from the module must preserve
the association; `state.2` is the pair \((y,z)\), not a real coordinate.

## Verify the symmetry coordinate by coordinate

Define

\[
S(x,y,z)=(-x,-y,z).
\]

The involution law is immediate from double negation:

\[
S(S(x,y,z))=(x,y,z).
\]

For field equivariance, compute:

\[
\begin{aligned}
F_1(S(x,y,z))
  &=\sigma((-y)-(-x))=-F_1(x,y,z),\\
F_2(S(x,y,z))
  &=(-x)(\rho-z)-(-y)=-F_2(x,y,z),\\
F_3(S(x,y,z))
  &=(-x)(-y)-\beta z=F_3(x,y,z).
\end{aligned}
\]

Thus \(F\circ S=S\circ F\). The field respects the transformation at every
state. The current source does not construct a nonconstant solution and does
not prove the corresponding transformation law for a selected global flow.

## Derive all field zeros

Assume \(\sigma\ne0\), \(\beta\gt0\), and \(\rho\gt1\). Setting the first
field coordinate to zero gives

\[
\sigma(y-x)=0,
\]

so \(y=x\). The second coordinate becomes

\[
x(\rho-z)-x=x(\rho-z-1)=0.
\]

There are two branches.

1. If \(x=0\), then \(y=0\), and the third equation reduces to
   \(-\beta z=0\). Since \(\beta\ne0\), this gives \(z=0\).
2. If \(x\ne0\), then \(z=\rho-1\). The third equation gives
   \(x^2=\beta(\rho-1)\), so
   \(x=\pm\sqrt{\beta(\rho-1)}\), with \(y=x\).

This yields exactly

\[
(0,0,0),\qquad
(q,q,\rho-1),\qquad
(-q,-q,\rho-1),
\quad q=\sqrt{\beta(\rho-1)}.
\]

The source first proves that each nonzero candidate is a field zero when the
radicand is merely nonnegative. Its completeness theorem adds the stronger
classical hypotheses only when excluding degenerate branches.

{{< reference-figure
  wide="true"
  src="equilibrium-proof-tree.svg"
  alt="The first Lorenz zero equation yields y equals x, then the second splits into x equals zero or z equals rho minus one, producing the origin or two square-root equilibria."
  caption="**Complete algebraic split:** every zero enters one of two branches after the first substitution. Positivity rules out the degenerate coefficient cases. The tree classifies field zeros only; it does not classify trajectories near them."
>}}

## Why three equilibria are not a Lorenz attractor

An equilibrium calculation is local in phase space. It identifies points where
the tangent vector vanishes. A Lorenz-attractor theorem concerns a global
invariant object and the behavior of nonconstant solutions over time. Tucker's
result requires normal forms, rigorous ODE integration, interval arithmetic,
and a detailed return-map argument.

The present module has none of that infrastructure. It therefore does not use
the phrases “the attractor exists” or “the system is chaotic” as conclusions.
The cited results explain the significance of those later statements and the
distance between them and this first algebraic slice.

## In Lean

{{< lean-bridge
  human="At the classical parameters, state one comma two comma three has tangent vector ten comma twenty-three comma minus six."
  math="\(F_{10,28,8/3}(1,2,3)=(10,23,-6).\)"
  lean="theorem lorenzVectorField_classical_benchmark :\n    lorenzVectorField 10 28 (8 / 3) (1, 2, 3) =\n      (10, 23, -6)"
>}}
All values are exact reals in the inferred field type. The division `8 / 3`
does not use floating-point arithmetic.
{{< /lean-bridge >}}

{{< lean-bridge
  human="A nonnegative radicand makes the positive-sign equilibrium candidate a field zero."
  math="\(0\le\beta(\rho-1)\Longrightarrow F(q,q,\rho-1)=0.\)"
  lean="theorem lorenzVectorField_positiveEquilibrium\n    {sigma rho beta : ℝ}\n    (hRadicand : 0 ≤ beta * (rho - 1)) :\n    lorenzVectorField sigma rho beta\n      (lorenzPositiveEquilibrium rho beta) = 0"
>}}
The theorem does not require `sigma` to be positive or nonzero because the
first coordinate vanishes when \(x=y\) for every `sigma`.
{{< /lean-bridge >}}

{{< lean-bridge
  human="The constant negative-sign equilibrium curve satisfies the ODE for every real time when the radicand is nonnegative."
  math="\(\beta(\rho-1)\ge0\Longrightarrow\gamma(t)=p_-\text{ is an integral curve}.\)"
  lean="theorem lorenz_negativeEquilibrium_isIntegralCurve\n    {sigma rho beta : ℝ}\n    (hRadicand : 0 ≤ beta * (rho - 1)) :\n    IsIntegralCurve\n      (fun _ : ℝ ↦ lorenzNegativeEquilibrium rho beta)\n      (lorenzODEField sigma rho beta)"
>}}
The ignored time argument makes the curve constant. This establishes one
explicit solution, not a solution through every state.
{{< /lean-bridge >}}

## Try the full project module

~~~lean
import NonlinearDynamics.Deterministic.Models.Lorenz

open NonlinearDynamics.Deterministic.Models

#check continuous_lorenzVectorField
#check lorenzSymmetry_involutive
#check lorenzVectorField_symmetry
#check lorenzVectorField_zAxis
#check lorenzVectorField_xAxis
#check lorenzVectorField_classical_benchmark
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
The full module asks Lean to check general theorems over real parameters and
states. Its elaborator constructs candidate proof terms and its kernel checks
them against the formal statements. This is logically different from the
bounded `Std` worksheet and from a global Lorenz-attractor proof.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/Lorenz.lean
```

## Misconceptions and limits

- A field vector is an instantaneous derivative, not a finite-time update.
- `ℝ × ℝ × ℝ` is right associated; `state.2` is the pair containing \(y\)
  and \(z\).
- The sign-flip theorem is pointwise field equivariance, not a theorem about a
  selected nonconstant orbit or flow.
- The two nonzero candidates are field zeros under nonnegative radicand; the
  complete classification uses stronger hypotheses.
- Three field zeros do not establish stability, instability, attraction, or
  bifurcation at any of them.
- The constant curves do not establish local or global existence through an
  arbitrary state.
- The worksheet exhausts five stored integer rows only.
- No boundedness, absorbing set, invariant set, attractor, sensitivity,
  transitivity, periodic-orbit density, mixing, or chaos theorem appears here.
- Lorenz's three-mode truncation is not a complete atmospheric model.

## References

- Edward N. Lorenz, “Deterministic Nonperiodic Flow,” *Journal of the
  Atmospheric Sciences* 20 (1963), 130–141, especially equations (25)–(27)
  and the coordinate interpretation on p. 134, the steady states on p. 135,
  and the classical numerical parameters on p. 136,
  [DOI 10.1175/1520-0469(1963)020<0130:DNF>2.0.CO;2](https://doi.org/10.1175/1520-0469%281963%29020%3C0130%3ADNF%3E2.0.CO%3B2).
- Warwick Tucker, “A Rigorous ODE Solver and Smale's 14th Problem,”
  *Foundations of Computational Mathematics* 2 (2002), 53–117,
  [DOI 10.1007/s002080010018](https://doi.org/10.1007/s002080010018).
- Mathlib contributors,
  [`Analysis.ODE.Basic`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/ODE/Basic.lean)
  and
  [`Data.Real.Sqrt`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Data/Real/Sqrt.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.

See the [Research Note]({{< relref
"/development-notebook/2026/08/lorenz-vector-field-symmetry-and-equilibria-in-lean" >}})
for the declaration ledger or the [glossary chapter]({{< relref
"/knowledge-base/glossary/lorenz-system" >}}) for a shorter orientation.
