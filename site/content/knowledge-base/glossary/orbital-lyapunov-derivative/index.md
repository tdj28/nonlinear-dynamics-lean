---
title: "Orbital Lyapunov derivative"
slug: "orbital-lyapunov-derivative"
summary: "The orbital Lyapunov derivative is the real-time derivative of a scalar certificate evaluated along one flow orbit."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.ODE.Lyapunov"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/ODE/Lyapunov.lean"
lean_source_sha256: "1a236598b8d8aba803ab4b9e29195f08390e823870b29605b84f29ff1fb79a13"
og_image: "orbital-lyapunov-derivative-card.png"
og_image_alt: "A scalar value is pulled back along a flow orbit and differentiated on the real-time axis."
---

{{< panel "warning" >}}
**Editorial status.** This is a private AI-assisted working draft.
Professional review and the warning-fatal Lean release gate remain pending;
`pro_reviewed` remains false.
{{< /panel >}}

Let \(\Phi:\mathbb R\times X\to X\) be a real-time flow and let
\(V:X\to\mathbb R\) be a scalar function. For a start \(x\), compose them to
obtain the real function

\[
g_x(t)=V(\Phi(t,x)).
\]

The **orbital Lyapunov derivative** at time \(t\) is

\[
\dot V_\Phi(x,t)=g_x'(t)
=\frac{d}{ds}\bigg|_{s=t}V(\Phi(s,x)).
\]

For the flow \(\Phi(t,x)=e^{-t}x\) and \(V(x)=x^2\),

\[
\dot V_\Phi(x,t)=-2e^{-2t}x^2\le0.
\]

{{< reference-figure
  wide="true"
  src="orbital-derivative-sign.svg"
  alt="A state orbit passes through the scalar function V to produce a real trace g sub x of t. A tangent on the descending trace is labeled g prime sub x of t less than or equal to zero."
  caption="**Pull back, then differentiate:** the orbital derivative is an ordinary real derivative of the scalar trace. A vector-field formula requires an additional chain rule."
>}}

## What the sign establishes

If \(g_x\) is differentiable on \(\mathbb R\) and
\(g_x'(t)\le0\) for every \(t\), the mean-value theorem makes \(g_x\)
antitone. Therefore

\[
t\ge0\Longrightarrow V(\Phi(t,x))\le V(\Phi(0,x))=V(x).
\]

This establishes weak orbital descent. It does not by itself establish that a
named point is an equilibrium, that \(V\) is positive definite, or that the
orbital value tends to zero.

## In Lean

{{< lean-bridge
  human="Differentiate the scalar value along the orbit from x at time t."
  math="\( \dot V_\Phi(x,t)=\frac{d}{ds}|_{s=t}V(\Phi(s,x)). \)"
  lean="noncomputable def lyapunovDerivativeAlong [TopologicalSpace X]\n    (ϕ : Flow ℝ X) (V : X → ℝ) (x : X) (t : ℝ) : ℝ :=\n  deriv (fun s : ℝ ↦ V (ϕ s x)) t"
>}}
`deriv` is Mathlib's total real derivative. It returns zero when the function
is not differentiable, so the weak sign theorem carries a separate
`Differentiable` hypothesis.
{{< /lean-bridge >}}

This is a **full project check** on macOS or Linux. It uses the pinned Lean and
Mathlib dependencies and may require substantial disk space or build time.

{{< repo-check >}}
The command checks the exact orbital-derivative definition and its mean-value
theorem bridge. It does not calculate a vector-field Lie derivative.
{{< /repo-check >}}

## Boundary with a Lie derivative

In a normed vector space, paper mathematics often combines a differentiable
scalar \(V\), a vector field \(F\), and an integral curve to write

\[
\frac{d}{dt}V(x(t))=DV(x(t))[F(x(t))].
\]

That equality is a chain-rule theorem, not the definition above. On a
manifold it also requires the appropriate tangent-space derivative. The
current repository slice stops at the orbital derivative until those
regularity and compatibility hypotheses receive their own checked interface.

## Related trail markers

- [Lyapunov function]({{< relref "/knowledge-base/glossary/lyapunov-function" >}})
- [Continuous-time stability]({{< relref "/knowledge-base/glossary/continuous-time-stability" >}})
- [Lyapunov Certificates and Orbital Descent in Continuous Time]({{< relref "/knowledge-base/deep-dives/lyapunov-certificates-and-orbital-descent-in-continuous-time" >}})

## References

1. N. P. Bhatia and G. P. Szegő, *Dynamical Systems: Stability Theory and
   Applications*, Lecture Notes in Mathematics 35, Springer, 1967, pages
   246–367. [Publisher record](https://doi.org/10.1007/BFb0080630).
2. Mathlib contributors,
   [`Analysis.Calculus.Deriv.MeanValue`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Analysis/Calculus/Deriv/MeanValue.lean),
   version 4.32.0.
