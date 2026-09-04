---
title: "Logistic map"
slug: "logistic-map"
summary: "The one-parameter quadratic update f_r(x)=r x(1-x), with an exact unit-interval parameter range and two algebraic fixed-point branches."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Models.LogisticMap"
tags:
  - "Discrete dynamics"
  - "Logistic map"
  - "Fixed points"
  - "Invariant intervals"
  - "Derivatives"
og_image: "logistic-map-card.png"
og_image_alt: "The logistic parabola over the unit interval marks zero at both endpoints and reaches r over four at the midpoint."
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
**Editorial and validation status.** This is an AI-assisted working
chapter. Professional review and the warning-fatal Lean release gate remain
pending, so <code>pro_reviewed</code> remains false.
{{< /panel >}}

The **logistic map** is the one-parameter family

\[
f_r(x)=r x(1-x),
\]

where \(r\) is a parameter and \(x\) is the current state. One iteration sends
\(x_n\) to

\[
x_{n+1}=f_r(x_n).
\]

The parameter is held fixed along one orbit. Changing \(r\) selects a
different dynamical system; changing \(n\) advances time in the selected
system.

## Start with the endpoints and midpoint

Three substitutions reveal the parabola's basic shape:

\[
f_r(0)=0,
\qquad
f_r(1)=0,
\qquad
f_r(1/2)=r/4.
\]

Thus both endpoints map to zero, and the midpoint reaches the parabola's
maximum when \(r\ge0\).

{{< reference-figure
  wide="true"
  src="logistic-parabola.svg"
  alt="A downward-opening parabola crosses the horizontal axis at zero and one and reaches the labeled height r over four at x equals one half. Arrows distinguish varying the parameter from advancing iteration time."
  caption="**Read the two directions separately:** horizontal position is the state. Applying the chosen parabola advances one time step, while changing its height by changing r selects a different map."
>}}

The identity

\[
x(1-x)=\frac14-\left(x-\frac12\right)^2
\]

shows that \(x(1-x)\le1/4\) for every real \(x\). On \([0,1]\), the same
factor is also nonnegative.

## When is the unit interval invariant?

For every \(x\in[0,1]\), the image lies in \([0,1]\) exactly when

\[
0\le r\le4.
\]

Sufficiency follows from

\[
0\le r x(1-x)\le r/4\le1.
\]

Necessity follows by evaluating the midpoint. If the entire interval maps
into itself, then \(r/4=f_r(1/2)\) must lie between zero and one, which is
equivalent to \(0\le r\le4\).

Outside this range the polynomial still maps real numbers to real numbers.
What fails is the more specific statement that it maps the selected state
space \([0,1]\) into itself.

## Fixed points and branches

A fixed point obeys \(f_r(x)=x\). Factoring the equation gives

\[
x\bigl(r(1-x)-1\bigr)=0.
\]

Therefore \(x=0\), or \(r x=r-1\). The latter becomes

\[
x=1-\frac1r
\]

only when \(r\ne0\). Keeping the division-free equation first prevents the
zero parameter from being discarded.

As the parameter varies, \(x=0\) is one fixed-point branch and
\(x=1-1/r\) is another on the nonzero parameters. They meet at \(r=1\).
This branch collision is not, by itself, a complete bifurcation theorem.

## Derivative and multiplier

Differentiation gives

\[
f_r'(x)=r(1-2x).
\]

The derivative evaluated at a fixed point is often called its multiplier. It
equals \(r\) at the zero branch and \(2-r\) at the nonzero branch. These exact
formulas are inputs to local stability analysis. The current source does not
infer a stability or attraction conclusion from them.

## In Lean

{{< lean-bridge
  human="The real logistic map multiplies r, x, and one minus x."
  math="\( f_r(x)=r x(1-x). \)"
  lean="def logisticMap (r x : ℝ) : ℝ :=\n  r * (x * (1 - x))"
>}}
The two real arguments have different roles. `r` selects a map, while `x` is
the input state. Parentheses expose the quadratic core used in the interval
bound.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.Models.LogisticMap

open NonlinearDynamics.Deterministic.Models

#check logisticMap
#check logisticMap_isFixedPt_iff
#check logisticMap_mapsTo_unitInterval_iff
~~~

This is a **full project check** on macOS or Linux. It uses the pinned Lean and
Mathlib dependencies and may require substantial disk space or build time.

{{< repo-check >}}
The command checks the exact source module. It does not simulate a collection
of floating-point trajectories.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/LogisticMap.lean
```

Continue with [the Deep Dive]({{< relref
"/knowledge-base/deep-dives/logistic-map-fixed-points-invariant-interval-and-multipliers"
>}}) for the complete invariant-interval argument and a bounded standalone
worksheet, or see [orbit and iterate]({{< relref
"/knowledge-base/glossary/orbit-and-iterate" >}}) for the time notation.

## References

- Robert M. May, “Simple mathematical models with very complicated
  dynamics,” *Nature* 261, 459–467 (1976).
  [DOI 10.1038/261459a0](https://doi.org/10.1038/261459a0).
- Welington de Melo and Sebastian van Strien, *One-Dimensional Dynamics*,
  Springer, 1993. [DOI 10.1007/978-3-642-78043-1](https://doi.org/10.1007/978-3-642-78043-1).
- Mathlib contributors,
  [`Dynamics.FixedPoints.Basic`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/FixedPoints/Basic.lean)
  and
  [`Analysis.Calculus.Deriv.Mul`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Calculus/Deriv/Mul.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.
