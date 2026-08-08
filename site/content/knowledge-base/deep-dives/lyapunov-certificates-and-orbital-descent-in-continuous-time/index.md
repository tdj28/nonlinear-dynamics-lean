---
title: "Lyapunov Certificates and Orbital Descent in Continuous Time"
slug: "lyapunov-certificates-and-orbital-descent-in-continuous-time"
date: 2026-08-08
summary: "A scalar certificate descends along a real-time orbit, but stability and attraction require different additional hypotheses."
lead: "Calculate one exponential orbit, audit a strict-descent counterexample, and follow the exact proof obligations from scalar values to stability and attraction."
draft: true
pro_reviewed: false
level: "Intermediate dynamical systems and real analysis"
reading_time: "30 to 45 minutes"
prerequisites: "Flows, derivatives, metric balls, and limits are introduced through examples"
lean_module: "NonlinearDynamics.Deterministic.ODE.Lyapunov"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/ODE/Lyapunov.lean"
lean_source_sha256: "1a236598b8d8aba803ab4b9e29195f08390e823870b29605b84f29ff1fb79a13"
toc: true
og_image: "lyapunov-certificates-and-orbital-descent-in-continuous-time-card.png"
og_image_alt: "A descending exponential scalar trace splits into a stability path and a zero-limit attraction path."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is a private AI-assisted working draft.
Professional review and the warning-fatal Lean release gate remain pending;
`pro_reviewed` remains false.
{{< /panel >}}

## Start with a decaying orbit

Let \(\Phi(t,x)=e^{-t}x\) on \(\mathbb R\), let the equilibrium be \(p=0\),
and choose \(V(x)=x^2\). For every real time \(t\), the map
\(x\mapsto e^{-t}x\) is invertible, so this is a genuine two-sided flow. The
direct method uses only \(t\ge0\).

Starting at \(x=2\),

\[
V(\Phi(t,2))=4e^{-2t},
\qquad
\frac{d}{dt}V(\Phi(t,2))=-8e^{-2t}.
\]

The derivative is negative at every finite time, and the value tends to zero.
These are different statements: the sign orders finite-time values, while the
limit identifies their asymptotic level.

{{< reference-figure
  wide="true"
  src="exponential-flow-energy.svg"
  alt="A curve labeled four exp minus two t descends from four through one to one quarter at times zero, log two, and log four. A lower annotation states that its derivative is minus eight exp minus two t, which is negative."
  caption="**One orbit, two facts:** the derivative sign gives descent. The separately displayed limit to zero is what later supplies attraction."
>}}

## Positive definite is not the same as decreasing

A scalar function is positive definite relative to \(p\) on \(S\) when

\[
p\in S,
\qquad V(p)=0,
\qquad x\in S\setminus\{p\}\Longrightarrow V(x)\gt0.
\]

This says how \(V\) compares states in space. Weak orbital descent says

\[
x\in S,\ t\ge0
\Longrightarrow V(\Phi(t,x))\le V(x).
\]

Neither condition contains the other. The identity flow with
\(V(x)=x^2\) has a positive-definite certificate whose value is constant.
Conversely, the translation example below has strict descent for a scalar that
is not positive definite relative to the named point.

## Weak descent closes invariant sublevels

Suppose \(S\) is forward invariant. If \(x\in S\) and \(V(x)\lt c\), then

\[
\Phi(t,x)\in S,
\qquad V(\Phi(t,x))\le V(x)\lt c
\qquad(t\ge0).
\]

Thus \(S\cap\{V\lt c\}\) is forward invariant. Replacing both strict
inequalities with weak ones yields the closed-sublevel theorem.

Restarting at time \(s\ge0\) gives

\[
V(\Phi(t,x))
=V(\Phi(t-s,\Phi(s,x)))
\le V(\Phi(s,x))
\qquad(0\le s\le t),
\]

so the orbital scalar trace is antitone on the whole forward half-line.

## A derivative sign is a bridge, not a definition

Define the {{< refterm "orbital-lyapunov-derivative" "orbital Lyapunov derivative" >}}
by

\[
\dot V_\Phi(x,t)
=\frac{d}{ds}\bigg|_{s=t}V(\Phi(s,x)).
\]

When the scalar orbit is differentiable and this derivative is nonpositive for
every real time, the real mean-value theorem makes the scalar orbit antitone.
Comparing \(0\) with \(t\ge0\) yields weak descent.

The source does not identify this derivative with \(DV(x)[F(x)]\) for a
vector field \(F\). That familiar chain-rule formula needs differentiability
of \(V\), an integral-curve relation, and a compatible manifold derivative
interface. Those hypotheses are not inferred from a topological flow.

## The stability proof uses three gates

For a requested radius \(\varepsilon\gt0\):

1. Sublevel control chooses \(c\gt0\) with
   \(V(x)\lt c\Rightarrow d(x,p)\lt\varepsilon\).
2. Continuity at \(p\) and \(V(p)=0\) choose an initial ball inside
   \(\{V\lt c\}\).
3. Weak descent keeps every forward orbit from that ball inside the same
   sublevel.

The conclusion is Lyapunov stability: one initial neighborhood controls every
nonnegative real time. No limit has been used.

## Attraction uses the missing limit

If one orbit satisfies \(V(\Phi(t,x))\to0\), then every positive controlling
sublevel eventually contains its scalar value. Sublevel control converts that
eventual scalar statement into \(\Phi(t,x)\to p\).

A neighborhood on which every orbital value tends to zero gives local
attraction. Combining that local limit with the stability result gives
asymptotic stability.

## Strict descent does not supply an equilibrium

Take the translation flow \(\Phi(t,x)=x+t\) and \(V(x)=-x\). For every
\(t\gt0\),

\[
V(\Phi(t,x))=-(x+t)\lt-x=V(x).
\]

Yet \(\Phi(1,p)=p+1\ne p\) for every \(p\). The example is a checked
counterexample to the universal implication “strict orbital descent alone
implies that the named point is an equilibrium.”

{{< reference-figure
  wide="true"
  src="strict-descent-translation-boundary.svg"
  alt="A translation orbit moves from x to x plus t while the scalar minus x moves downward from minus x to minus x minus t. A separate equilibrium gate is crossed out because p plus one is not p."
  caption="**Boundary case:** strict descent is present, but the equilibrium hypothesis is absent. The direct-method theorem keeps that obligation explicit."
>}}

## In Lean

{{< lean-bridge
  human="Weak descent holds at every nonnegative real time."
  math="\( x\in S,\ t\ge0\Rightarrow V(\Phi(t,x))\le V(x). \)"
  lean="def IsWeakLyapunovDecreaseOn [TopologicalSpace X]\n    (ϕ : Flow ℝ X) (V : X → ℝ) (S : Set X) : Prop :=\n  ∀ x ∈ S, ∀ t : ℝ, 0 ≤ t → V (ϕ t x) ≤ V x"
>}}
`TopologicalSpace X` is required by Mathlib's `Flow`. `t : ℝ` is real time,
and the proof argument `0 ≤ t` restricts the conclusion to forward time.
{{< /lean-bridge >}}

{{< lean-bridge
  human="A zero scalar limit plus sublevel control makes one orbit converge to p."
  math="\( V(\Phi(t,x))\to0\ \land\ \text{sublevel control at }p\Rightarrow\Phi(t,x)\to p. \)"
  lean="theorem isAttractedTo_of_tendsto_lyapunov\n    [PseudoMetricSpace X] {ϕ : Flow ℝ X} {x p : X} {V : X → ℝ}\n    (hcontrol : HasSublevelControlAt V p)\n    (hlim : Tendsto (fun t : ℝ ↦ V (ϕ t x)) atTop (𝓝 0)) :\n    IsAttractedTo ϕ x p"
>}}
`atTop` means that real time tends to positive infinity. `𝓝 0` is the
neighborhood filter of zero, and `IsAttractedTo` is the existing flow-orbit
limit predicate.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.ODE.Lyapunov

open NonlinearDynamics.Deterministic.ODE

#check isWeakLyapunovDecreaseOn_of_derivative_nonpos
#check IsWeakLyapunovDecreaseOn.isForwardInvariant_openSublevel
#check isLyapunovStableEquilibrium_of_continuousAt_of_sublevelControl
#check isAttractedTo_of_tendsto_lyapunov
#check strictLyapunovDecreaseOn_neg_translationFlow_not_equilibrium
~~~

This is a **full project check** on macOS or Linux. It uses the pinned Lean and
Mathlib dependencies and may require substantial disk space or build time.

{{< repo-check >}}
This command checks the exact source module with warnings treated as errors.
It does not numerically simulate an ODE.
{{< /repo-check >}}

## What this chapter does not claim

The chapter supplies no converse theorem, compact invariance principle,
largest invariant subset, convergence rate, exponential estimate, robustness
to vector-field perturbations, stochastic stability statement, or Lyapunov
exponent. The exponential orbit is a worked mathematical example; the checked
source boundary uses the translation flow.

## Related trail markers

- [Lyapunov function]({{< relref "/knowledge-base/glossary/lyapunov-function" >}})
- [Continuous-time stability]({{< relref "/knowledge-base/glossary/continuous-time-stability" >}})
- [Basin of attraction]({{< relref "/knowledge-base/glossary/basin-of-attraction" >}})
- [Lyapunov Certificates for Continuous-Time Flows in Lean]({{< relref "/development-notebook/2026/08/lyapunov-certificates-for-continuous-time-flows-in-lean" >}})

## References

1. N. P. Bhatia and G. P. Szegő, *Dynamical Systems: Stability Theory and
   Applications*, Lecture Notes in Mathematics 35, Springer, 1967, pages
   246–367. [Publisher record](https://doi.org/10.1007/BFb0080630).
2. J. P. LaSalle, *The Stability of Dynamical Systems*, SIAM CBMS 25, 1976.
   [Publisher record](https://doi.org/10.1137/1.9781611970432).
3. Mathlib contributors,
   [`Analysis.Calculus.Deriv.MeanValue`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Analysis/Calculus/Deriv/MeanValue.lean),
   version 4.32.0.
