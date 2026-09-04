---
title: "Lyapunov Certificates for Continuous-Time Flows in Lean"
slug: "lyapunov-certificates-for-continuous-time-flows-in-lean"
date: 2026-08-08
summary: "A trajectory-level direct method separates spatial positivity, nonnegative-real-time descent, stability, and zero-certificate attraction."
lead: "Follow one scalar value along every real-time orbit, then see exactly which additional hypotheses turn its descent into stability or attraction."
draft: true
pro_reviewed: false
tags:
  - "Lean"
  - "Ordinary differential equations"
  - "Lyapunov methods"
  - "Stability"
  - "Continuous-time dynamics"
lean_module: "NonlinearDynamics.Deterministic.ODE.Lyapunov"
lean_source: "formalization/NonlinearDynamics/Deterministic/ODE/Lyapunov.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/ODE/Lyapunov.lean"
lean_source_sha256: "50154741063f7b233ed9a3092c06747a88239a2d9cb465df0e02d447a9c12b99"
toc: true
og_image: "lyapunov-certificates-for-continuous-time-flows-in-lean-card.png"
og_image_alt: "A descending scalar trace feeds a stability gate, while a separate zero-limit gate feeds attraction before the two conclusions combine."
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
Professional review and the warning-fatal Lean release gate remain pending, so
`pro_reviewed` remains false. The source interface described below is a
candidate until the exact commit passes the repository's pinned checks.
{{< /panel >}}

## Abstract

The direct method studies a scalar function \(V:X\to\mathbb R\) along a
continuous-time orbit \(t\mapsto\Phi(t,x)\). This candidate module makes four
boundaries explicit.

First, positivity of \(V\) is a spatial condition. Second, weak or strict
descent is a condition along every nonnegative real time, not merely at integer
samples. Third, weak descent proves Lyapunov stability only after continuity
at the equilibrium and quantitative sublevel control are supplied. Fourth,
attraction is obtained from the separate hypothesis
\(V(\Phi(t,x))\to0\).

The derivative bridge is deliberately one-dimensional: a nonpositive
derivative of \(t\mapsto V(\Phi(t,x))\), together with differentiability,
gives orbital descent by the real mean-value theorem. A manifold Lie
derivative and the chain rule from a vector field to this orbital derivative
remain outside the slice.

## Prior work, contribution, and non-claims

**Prior work.** Bhatia and Szegő treat the second method of Lyapunov for ODEs
after developing stability in metric dynamical systems. LaSalle separates
stability conclusions from stronger invariance-principle arguments. The
repository already checks the real-flow equilibrium, forward-stability,
basin, and asymptotic-stability predicates, plus a discrete direct-method
interface.

**Contribution.** The candidate reuses the discrete module's spatial
positivity and sublevel-control predicates, then adds real-flow descent,
forward-invariant sublevels, antitone orbital values, derivative-sign bridges,
and separate stability and attraction theorems.

**Non-claims.** The module proves no converse Lyapunov theorem, LaSalle
invariance principle, exponential rate, stable-set result, input-to-state
criterion, structural stability statement, stochastic robustness theorem, or
Lyapunov exponent. It does not yet turn a manifold vector-field derivative
condition into the trajectory derivative hypothesis.

## Start with an exact orbit

On \(X=\mathbb R\), consider the real flow

\[
\Phi(t,x)=e^{-t}x
\]

and the scalar certificate \(V(x)=x^2\). Start at \(x=2\). Then

\[
V(\Phi(t,2))=4e^{-2t}.
\]

At \(t=0\), \(t=\log 2\), and \(t=\log 4\), the values are
\(4\), \(1\), and \(1/4\). The orbital derivative is

\[
\frac{d}{dt}V(\Phi(t,2))=-8e^{-2t}\le0.
\]

For a general initial state \(x\),

\[
V(\Phi(t,x))=e^{-2t}x^2\le x^2=V(x)
\qquad(t\ge0),
\]

and the value tends to zero as \(t\to+\infty\). This example has both pieces:
descent controls all future values, and the separate zero limit supplies
attraction.

{{< reference-figure
  wide="true"
  src="energy-descent-ledger.svg"
  alt="The orbit x of t equals two times exp minus t is sampled at zero, log two, and log four. Its squared values descend from four to one to one quarter, with a nonpositive derivative shown beneath the samples."
  caption="**Exact energy ledger:** the scalar value decreases at every nonnegative real time and also tends to zero. Descent and the zero limit are recorded as distinct facts."
>}}

## The interface separates four obligations

The source reuses four spatial predicates from the discrete module:

1. `IsNonnegativeOn V S` says \(V(x)\ge0\) on \(S\).
2. `IsPositiveDefiniteOn V p S` says \(p\in S\), \(V(p)=0\), and
   \(V(x)\gt0\) for \(x\in S\setminus\{p\}\).
3. `IsLocallyPositiveDefiniteAt V p` records positivity near \(p\).
4. `HasSublevelControlAt V p` says sufficiently small positive sublevels of
   \(V\) fit inside every requested metric ball around \(p\).

Time enters only in the descent predicates:

\[
\operatorname{WeakDecrease}(\Phi,V,S)
\iff
\forall x\in S\;\forall t\ge0,\quad
V(\Phi(t,x))\le V(x).
\]

Strict descent excludes the reference point and uses \(t\gt0\):

\[
x\in S,\ x\ne p,\ t\gt0
\Longrightarrow V(\Phi(t,x))\lt V(x).
\]

The zero-time exclusion matters. Every flow satisfies
\(\Phi(0,x)=x\), so strict descent at \(t=0\) would be inconsistent.

## Why invariant sublevels matter

Let \(S\) be forward invariant and suppose \(V\) weakly decreases. If
\(x\in S\) and \(V(x)\le c\), then for every \(t\ge0\),

\[
\Phi(t,x)\in S,
\qquad
V(\Phi(t,x))\le V(x)\le c.
\]

Thus \(S\cap\{V\le c\}\) is forward invariant. The same argument works for
the open sublevel \(S\cap\{V\lt c\}\). Restarting the flow at time \(s\) also
shows that \(t\mapsto V(\Phi(t,x))\) is antitone on \([0,\infty)\).

This is stronger than checking \(V(\Phi(t,x))\le V(x)\) at a few plotted
times. The theorem quantifies over the continuum of nonnegative real times.

## The derivative bridge

The candidate defines

\[
\dot V_\Phi(x,t)
{} =
\frac{d}{ds}\bigg|_{s=t}V(\Phi(s,x)).
\]

If the orbital scalar function is differentiable for every real time and
\(\dot V_\Phi(x,t)\le0\), Mathlib's
`antitone_of_deriv_nonpos` makes the entire function antitone. Comparing time
zero with any \(t\ge0\) gives weak descent.

Strict negativity uses `strictAnti_of_deriv_neg`. Mathlib's total `deriv`
returns zero at a nondifferentiability point, so a strictly negative value
already forces differentiability there. The weak theorem cannot use that
shortcut and therefore carries differentiability explicitly.

{{< panel "info" >}}
**Why no Lie derivative yet?** For a vector field \(F\) and differentiable
\(V\), paper mathematics often writes
\(\dot V(x)=DV(x)[F(x)]\). The repository's flow can live on a manifold, where
that formula needs a checked manifold derivative and a chain rule connecting
`IsIntegralCurveFlow` to the one-variable orbit map. The current trajectory
theorem is valid without choosing that extra interface.
{{< /panel >}}

## Stability is a sublevel argument

Fix an equilibrium \(p\) and a requested radius \(\varepsilon\gt0\).
Sublevel control supplies \(c\gt0\) such that

\[
V(x)\lt c\Longrightarrow d(x,p)\lt\varepsilon.
\]

Continuity at \(p\), together with \(V(p)=0\lt c\), supplies an initial radius
\(\delta\gt0\) whose ball lies in \(\{V\lt c\}\). Weak descent then keeps every
forward image in that same sublevel. Hence every orbit beginning within
\(\delta\) stays within \(\varepsilon\) for every nonnegative time.

{{< reference-figure
  wide="true"
  src="proof-obligation-ladder.svg"
  alt="Continuity at p and a zero scalar value feed an initial sublevel. Sublevel control maps it inside an epsilon ball, and weak descent keeps the orbit there to yield Lyapunov stability. A separate scalar limit to zero yields attraction. The two endpoints join at asymptotic stability."
  caption="**Proof obligations stay separate:** weak descent closes the all-time stability path. A zero-value limit closes the attraction path. Only their conjunction reaches asymptotic stability."
>}}

Pointwise positive definiteness alone is not used to manufacture the
sublevel-to-distance implication on an arbitrary noncompact pseudo-metric
space. That comparison remains an explicit hypothesis.

## Attraction needs a limit

Suppose instead that one orbit satisfies

\[
V(\Phi(t,x))\longrightarrow0.
\]

Given \(\varepsilon\gt0\), sublevel control supplies \(c\gt0\). Eventually the
orbital value is less than \(c\), so the state is eventually within
\(\varepsilon\) of \(p\). This proves attraction of that orbit.

If the zero-value limit holds for every start in a neighborhood of \(p\), the
equilibrium is locally attracting. If it holds for every state, the equilibrium
is globally attracting. The asymptotic-stability theorem combines the local
zero-limit hypothesis with the separate stability bridge.

## A strict-descent boundary

For the translation flow \(\Phi(t,x)=x+t\), choose \(V(x)=-x\). Then

\[
V(\Phi(t,x))=-(x+t)\lt-x=V(x)
\qquad(t\gt0).
\]

The scalar strictly decreases, but no point is an equilibrium of this flow.
The checked boundary theorem therefore pairs the strict-descent certificate
with the negation of `IsEquilibrium`. It refutes the implication from strict
descent alone to an equilibrium conclusion. It does not refute a direct-method
theorem whose equilibrium, positivity, regularity, and sublevel hypotheses are
all present.

## In Lean

{{< lean-bridge
  human="The scalar value never exceeds its initial value at any nonnegative real time."
  math="\( \forall x\in S\;\forall t\ge0,\ V(\Phi(t,x))\le V(x). \)"
  lean="def IsWeakLyapunovDecreaseOn [TopologicalSpace X]\n    (ϕ : Flow ℝ X) (V : X → ℝ) (S : Set X) : Prop :=\n  ∀ x ∈ S, ∀ t : ℝ, 0 ≤ t → V (ϕ t x) ≤ V x"
>}}
`ϕ` is the real-time flow, `V` is the scalar certificate, `S` is the selected
region, and the final implication restricts the time variable to the forward
half-line.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Continuity, sublevel control, and forward scalar descent prove Lyapunov stability of an equilibrium."
  math="\( p\text{ equilibrium},\ V(p)=0,\ V\text{ continuous at }p,\ \text{sublevel control},\ V\circ\Phi_t\le V\Longrightarrow p\text{ Lyapunov stable}. \)"
  lean="theorem isLyapunovStableEquilibrium_of_continuousAt_of_sublevelControl\n    [PseudoMetricSpace X] {ϕ : Flow ℝ X} {p : X} {V : X → ℝ}\n    (hp : IsEquilibrium ϕ p) (hV0 : V p = 0) (hVc : ContinuousAt V p)\n    (hcontrol : HasSublevelControlAt V p)\n    (hdec : IsWeakLyapunovDecreaseOn ϕ V Set.univ) :\n    IsLyapunovStableEquilibrium ϕ p"
>}}
The conclusion uses the already-checked continuous-time stability predicate.
The assumptions do not include attraction.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.ODE.Lyapunov

open NonlinearDynamics.Deterministic.ODE

#check IsWeakLyapunovDecreaseOn.antitoneOn_orbit
#check isWeakLyapunovDecreaseOn_of_derivative_nonpos
#check isLyapunovStableEquilibrium_of_continuousAt_of_sublevelControl
#check isAttractedTo_of_tendsto_lyapunov
#check isAsymptoticallyStableEquilibrium_of_lyapunov
#check strictLyapunovDecreaseOn_neg_translationFlow_not_equilibrium
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
The command checks the exact source module with warnings treated as errors.
Lean's kernel checks proof terms against the formal statements; it does not
certify that a chosen certificate models a physical energy.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/ODE/Lyapunov.lean
```

## Declaration map

- `IsNonnegativeOn`, `IsPositiveDefiniteOn`,
  `IsLocallyPositiveDefiniteAt`, and `HasSublevelControlAt` reuse the spatial
  certificate predicates from the discrete direct-method layer.
- `lyapunovDerivativeAlong`, `IsWeakLyapunovDecreaseOn`, and
  `IsStrictLyapunovDecreaseOn` define the continuous-time certificate data.
- `IsPositiveDefiniteOn.isNonnegativeOn` records the spatial sign implication.
- `IsStrictLyapunovDecreaseOn.isWeakLyapunovDecreaseOn` uses equilibrium and
  the zero-time flow law to weaken strict positive-time descent.
- `IsWeakLyapunovDecreaseOn.isForwardInvariant_closedSublevel`,
  `IsWeakLyapunovDecreaseOn.isForwardInvariant_openSublevel`, and
  `IsWeakLyapunovDecreaseOn.antitoneOn_orbit` provide the invariant-sublevel
  and orbital-order consequences.
- `isWeakLyapunovDecreaseOn_of_derivative_nonpos` and
  `isStrictLyapunovDecreaseOn_of_derivative_neg` connect real derivatives to
  the two descent predicates.
- `isLyapunovStableEquilibrium_of_continuousAt_of_sublevelControl` and
  `isLyapunovStableEquilibrium_of_positiveDefinite_of_sublevelControl` close
  the stability path.
- `isAttractedTo_of_tendsto_lyapunov`,
  `isLocallyAttractingEquilibrium_of_tendsto_lyapunov`, and
  `isGloballyAttractingEquilibrium_of_tendsto_lyapunov` close the scalar-limit
  attraction paths.
- `isAsymptoticallyStableEquilibrium_of_lyapunov` combines the separate local
  stability and attraction obligations.
- `strictLyapunovDecreaseOn_neg_translationFlow` and
  `strictLyapunovDecreaseOn_neg_translationFlow_not_equilibrium` supply the
  strict-descent boundary example.

## Discussion

The trajectory-level interface is intentionally reusable. A user who already
knows an orbital scalar derivative can apply the direct-method theorems without
committing to Euclidean coordinates or a particular vector-field API.

That generality also marks the next proof-engineering task. A future
vector-field corollary should connect a checked manifold derivative of \(V\)
and `IsIntegralCurveFlow` to `lyapunovDerivativeAlong`. It must state the
regularity and chain-rule hypotheses rather than presenting the familiar
formula \(DV[F]\) as definitional.

The strongest current conclusion, asymptotic stability, consumes two evidence
paths. Weak descent plus sublevel control proves that nearby starts remain
nearby. A zero-value limit proves approach. Neither path substitutes for the
other.

## References

1. N. P. Bhatia and G. P. Szegő, *Dynamical Systems: Stability Theory and
   Applications*, Lecture Notes in Mathematics 35, Springer, 1967, especially
   “The second method of liapunov for ordinary differential equations,” pages
   246–367. [Publisher record](https://doi.org/10.1007/BFb0080630).
2. J. P. LaSalle, *The Stability of Dynamical Systems*, SIAM CBMS 25, 1976.
   [Publisher record](https://doi.org/10.1137/1.9781611970432).
3. Mathlib contributors,
   [`Analysis.Calculus.Deriv.MeanValue`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Analysis/Calculus/Deriv/MeanValue.lean),
   [`Dynamics.Flow`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/Flow.lean),
   version 4.32.0.
