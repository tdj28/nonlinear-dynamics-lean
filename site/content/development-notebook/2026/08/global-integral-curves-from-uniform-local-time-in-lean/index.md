---
title: "Global Integral Curves from Uniform Local Time in Lean"
slug: "global-integral-curves-from-uniform-local-time-in-lean"
date: 2026-08-07
weight: -79
author: "tdj28"
summary: "A precise local-to-global ODE interface separates uniform local time, arbitrarily long local curves, global existence, and uniqueness."
lead: |
  Local differential-equation theory gives a curve near its initial time. A global curve needs continuation for every real time. This milestone packages the exact bridge available in Mathlib: one positive local-time radius that works at every point yields global integral curves on a boundaryless manifold.
key_result: |
  For a continuously differentiable vector field on a boundaryless manifold, global integral curves through every point are equivalent to one uniform positive local-time radius. At one initial point, global existence is equivalent to integral curves on every symmetric finite interval. Smoothness supplies uniqueness as a separate conclusion.
draft: true
pro_reviewed: false
status: "Warning-fatal source leaf and deterministic aggregator pass; full gate pending"
level: "Intermediate differential equations, manifolds, and Lean 4"
reading_time: "30 to 45 minutes"
prerequisites:
  - "Vector fields"
  - "Integral curves"
  - "Continuous differentiability"
lean_module: "NonlinearDynamics.Deterministic.ODE.GlobalExistence"
lean_source: "formalization/NonlinearDynamics/Deterministic/ODE/GlobalExistence.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/ODE/GlobalExistence.lean"
lean_source_sha256: "ce3e3f6bc4aecf83dffa4b10481487cbba1ba8c8e27d0a9c47a4c6339764c862"
tags: ["Lean 4", "ODE", "Integral curves", "Global existence", "Manifolds"]
og_image: "global-integral-curves-from-uniform-local-time-in-lean-card.png"
og_image_alt: "Overlapping local time windows extend a trajectory across the real line, with existence and uniqueness shown as separate gates."
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
**Editorial status.** The exact source passes its warning-fatal Lean leaf and
deterministic aggregator checks. The complete repository gate remains pending.
Professional review has not been performed, so `pro_reviewed` remains false.
{{< /panel >}}

## Begin with two scalar equations

For the constant field \(v(x)=1\) on the real line, the curve
\(\gamma(t)=x_0+t\) satisfies \(\gamma(0)=x_0\) and
\(\gamma'(t)=v(\gamma(t))\) for every real \(t\). It is global.

The equation \(x'=x^2\) has the solution
\(x(t)=x_0/(1-x_0t)\). When \(x_0\gt0\), its denominator vanishes at
\(t=1/x_0\). The field is smooth, but that solution is not defined for every
real time. Smooth local existence alone therefore does not imply global
existence.

## Four statements that must remain distinct

The source introduces four interfaces:

1. a global integral curve through one point;
2. a global integral curve through every point;
3. a unique global integral curve through one or every point; and
4. local curves supplied either on every finite symmetric interval or on one
   positive interval whose radius works at every point.

{{< reference-figure
  wide="true"
  src="local-windows-to-global-curve.svg"
  alt="Several overlapping local intervals cover a horizontal time axis; an upper arrow labels the resulting curve as defined for every real time, while a separate uniqueness gate sits to the right."
  caption="**Continuation architecture:** a common local radius lets Mathlib repeatedly continue curves along time. The output is global existence. Continuous differentiability on a boundaryless manifold then supplies uniqueness through a separate theorem."
>}}

At a fixed point, curves on every interval \((-a,a)\) need not be presented
as one preassembled compatible family. Mathlib's theorem performs the
continuation argument under the continuously differentiable, boundaryless
hypotheses.

## Why uniformity matters

Pointwise local existence may give a radius \(\varepsilon_x\) depending on the
initial point \(x\). The continuation theorem used here assumes a single
\(\varepsilon\gt0\) valid for every point. This prevents the guaranteed time
step from shrinking unpredictably along the curve.

Global existence immediately gives such a radius: restrict each global curve
to \((-1,1)\). The reverse direction is the substantive continuation result.
The equivalence is therefore exact only with the stated regularity and
boundaryless assumptions on the reverse implication.

## Existence is not yet a flow

A global curve through every point is the raw material for a global flow, but
this module does not package a map \(\Phi:\mathbb R\times M\to M\), establish
the group law, or prove continuous dependence on the initial point. Those
belong to the later `ToFlow` milestone. Keeping that boundary explicit avoids
treating a family of existential witnesses as a structured flow.

## The finite-time boundary in detail

The scalar equation \(x'=x^2\) makes the continuation issue calculable. For an
initial value \(x(0)=x_0\ne0\), separation of variables gives

\[
-\frac{1}{x(t)}=t+C,
\qquad
x(t)=\frac{x_0}{1-x_0t}.
\]

Substitution checks the equation:

\[
x'(t)=\frac{x_0^2}{(1-x_0t)^2}=x(t)^2.
\]

If \(x_0\gt0\), the right endpoint \(1/x_0\) is finite. If \(x_0\lt0\), the
corresponding obstruction lies at a finite negative time. The equilibrium
initial value \(x_0=0\) instead gives the constant global solution. One smooth
field therefore contains both a global equilibrium curve and non-global
curves through other points. The relevant global property must quantify over
initial points rather than being inferred from the field's differentiability
class alone.

This calculation is a counterexample to the universal statement that every
smooth vector field on \(\mathbb R\) has global integral curves through every
point. It is not a counterexample to the uniform-time theorem. Indeed, the
local existence radius for \(x'=x^2\) cannot remain bounded below by one fixed
positive number over all starting points: the positive-time pole occurs at
\(1/x_0\), which approaches zero as \(x_0\) grows.

## Symmetric intervals and a quantifier edge case

`HasArbitrarilyLongLocalIntegralCurvesAt` quantifies over every real `a`, not
only positive values. When `a ≤ 0`, the interval `Ioo (-a) a` is empty. The
integral-curve condition on that empty set is vacuous, but the definition still
asks for a total function `curve : ℝ → M` whose value at time zero is the
initial point. The substantive cases are the positive radii, and the
equivalence theorem is inherited directly from Mathlib's statement with the
same quantifier.

This edge case does not turn an empty interval into a global existence
argument. The theorem assumes the condition for every `a`, including every
positive `a`; those positive cases cover arbitrarily large finite time
windows. Recording the exact upstream quantifier avoids silently changing the
library interface while still explaining which instances carry the
continuation content.

By contrast, `HasUniformLocalIntegralCurves` explicitly stores `0 < ε`. Its
interval is genuinely open around time zero, and the same positive `ε` is
chosen before any initial point. The two definitions answer different
questions: arbitrarily long curves are pointwise in the initial state and grow
in requested radius, while uniform local curves use one fixed radius across
the entire state space.

## Why the manifold has no boundary here

On a manifold with boundary, a tangent vector may point out of the permitted
state space at a boundary point. A theorem about unrestricted two-sided time
then needs a boundary-compatible hypothesis or a different notion of solution.
The upstream continuation and uniqueness results used here assume
`BoundarylessManifold I M`, and the project exposes that assumption in every
theorem that invokes them.

This is separate from metric completeness. The source does not assume a
complete Riemannian metric and does not derive vector-field completeness from
geometric completeness. It also does not assert that compactness supplies the
uniform radius, even though compactness-based completeness results are common
in differential geometry. Such a theorem would need its own formal hypotheses
and a checked bridge to this interface.

## How the source delegates to Mathlib

The project definitions are small wrappers around four upstream facts:

1. `exists_isMIntegralCurve_of_isMIntegralCurveOn` performs uniform-time
   continuation from local curves through all points to global curves;
2. `exists_isMIntegralCurve_iff_exists_isMIntegralCurveOn_Ioo` characterizes
   global existence through one point using all symmetric finite intervals;
3. `isMIntegralCurve_Ioo_eq_of_contMDiff_boundaryless` identifies two integral
   curves that share an initial value; and
4. `isMIntegralCurve_const` checks the constant curve at a zero of the field.

The first two carry the existence work. The third upgrades an existing curve
to unique existence. The fourth supplies an independent boundary example.
The source deliberately does not duplicate the analytic continuation proof or
introduce a second definition of a manifold integral curve.

The uniqueness proof also has an orientation detail worth auditing. Given an
existing curve `curve` and a competitor `other`, their stored initial
equalities are `curve 0 = x` and `other 0 = x`. Composing the competitor's
equality with the reverse of the existing curve's equality yields
`other 0 = curve 0`, exactly the input order expected by the upstream
uniqueness theorem. The resulting functional equality is `other = curve`,
which is the orientation required by Lean's `ExistsUnique` field.

## Trust and dependency boundary

The four `#print axioms` commands at the end of the module expose the axiom
footprint of the two continuation results, the unique-existence upgrade, and
the zero-field example. The warning-fatal leaf check confirms that none depends
on `sorryAx`. An axiom report does not establish that the formal
definitions match every intended physical interpretation; that fidelity is
the purpose of the proposition split, examples, nonclaims, and review record.

The module imports `IntegralCurve.UniformTime`, which in turn rests on
Mathlib's manifold derivative and integral-curve infrastructure. The ordinary
differential-equation Picard-Lindelöf files explain the local analytic layer,
but the project theorem does not repackage their local Lipschitz conclusions
as an unconditional global result. This dependency choice keeps the public
theorem type aligned with the actual continuation theorem used by the proof.

## In Lean

{{< lean-bridge
  human="One positive local-time radius that works through every point yields a global integral curve through every point."
  math="\(\exists\varepsilon>0\;\forall x\;\exists\gamma_x:\ (-\varepsilon,\varepsilon)\to M\quad\Longrightarrow\quad\forall x\;\exists\Gamma_x:\mathbb R\to M.\)"
  lean="theorem HasUniformLocalIntegralCurves.hasGlobalIntegralCurves [BoundarylessManifold I M] (hvfield : CMDiff 1 (fun x ↦ (⟨x, vfield x⟩ : TangentBundle I M))) (h : HasUniformLocalIntegralCurves vfield) : HasGlobalIntegralCurves vfield"
>}}
`CMDiff 1` says that the bundled vector field is continuously differentiable.
`BoundarylessManifold I M` excludes a manifold boundary. `h` contains the
common positive radius and a local curve through every initial point. The
conclusion contains a curve defined on all of `ℝ` through every point.
{{< /lean-bridge >}}

{{< lean-bridge
  human="At one initial point, a global curve exists exactly when curves exist on every symmetric finite interval."
  math="\(\exists\Gamma:\mathbb R\to M\quad\Longleftrightarrow\quad\forall a\in\mathbb R\;\exists\gamma_a\text{ on }(-a,a).\)"
  lean="theorem hasGlobalIntegralCurveAt_iff_hasArbitrarilyLongLocalIntegralCurvesAt [BoundarylessManifold I M] (hvfield : CMDiff 1 (fun x ↦ (⟨x, vfield x⟩ : TangentBundle I M))) (x : M) : HasGlobalIntegralCurveAt vfield x ↔ HasArbitrarilyLongLocalIntegralCurvesAt vfield x"
>}}
The existential curve may depend on `a`. The theorem does not assume those
curves have already been bundled with compatibility proofs.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.ODE.GlobalExistence

open NonlinearDynamics.Deterministic.ODE

#check HasGlobalIntegralCurveAt
#check HasUniformLocalIntegralCurves
#check hasGlobalIntegralCurves_iff_hasUniformLocalIntegralCurves
#check HasUniformLocalIntegralCurves.hasUniqueGlobalIntegralCurves
#check zeroVectorField_hasGlobalIntegralCurves
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies; initial setup may require substantial
disk space and build time.

{{< repo-check >}}
The worksheet inspects the separate existence, uniform-time, uniqueness, and
zero-field interfaces.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/ODE/GlobalExistence.lean
```

## Declaration map and nonclaims

| Declaration | Role |
|---|---|
| `HasGlobalIntegralCurveAt`, `HasGlobalIntegralCurves` | global existence at one or every point |
| `HasUniqueGlobalIntegralCurveAt`, `HasUniqueGlobalIntegralCurves` | uniqueness kept separate from existence |
| `HasArbitrarilyLongLocalIntegralCurvesAt` | a curve on every symmetric finite interval |
| `HasUniformLocalIntegralCurves` | one positive radius valid through every point |
| `hasGlobalIntegralCurveAt_iff_hasArbitrarilyLongLocalIntegralCurvesAt` | pointwise finite-interval equivalence |
| `hasGlobalIntegralCurves_iff_hasUniformLocalIntegralCurves` | global versus uniform-local equivalence |
| `hasGlobalIntegralCurveAt_of_eq_zero` | constant curve at an equilibrium |

Not claimed: global existence from local smoothness alone, a linear-growth
criterion, completeness of an arbitrary vector field, maximal solution
intervals, parameter dependence, a global flow, or stability.

## References

1. John M. Lee, *Introduction to Smooth Manifolds*, second edition, Springer,
   2013, Chapters 8 and 9. [Publisher record](https://doi.org/10.1007/978-1-4419-9982-5).
2. Mathlib contributors, `Mathlib.Geometry.Manifold.IntegralCurve.UniformTime`,
   version 4.32.0. [Pinned source](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Geometry/Manifold/IntegralCurve/UniformTime.lean).
3. Mathlib contributors, `Mathlib.Geometry.Manifold.IntegralCurve.ExistUnique`,
   version 4.32.0. [Pinned source](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Geometry/Manifold/IntegralCurve/ExistUnique.lean).
4. Mathlib contributors, `Mathlib.Analysis.ODE.PicardLindelof`, version 4.32.0.
   [Pinned source](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Analysis/ODE/PicardLindelof.lean).

## Discussion

This milestone contributes an audited project interface around upstream
continuation and uniqueness theorems. Its main design decision is negative but
important: it does not turn a local theorem into a global one by omitting the
continuation hypothesis. The next dependency-ordered step is to construct the
flow interface from unique global curves and verify its time-zero and
composition laws.
