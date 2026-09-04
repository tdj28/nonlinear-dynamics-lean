---
title: "Tent map"
slug: "tent-map"
summary: "A symmetric piecewise-linear update with slopes s and minus s, a midpoint peak s over two, and an exact unit-interval parameter range."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Models.TentMap"
tags:
  - "Discrete dynamics"
  - "Tent map"
  - "Fixed points"
  - "Invariant intervals"
  - "Piecewise linear maps"
og_image: "tent-map-card.png"
og_image_alt: "A symmetric two-branch tent rises from zero to s over two at the midpoint and returns to zero at one."
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

The **tent map** used in this project is the real family

\[
T_s(x)=s\min\{x,1-x\},
\]

where (s) is the fixed parameter and (x) is the current state. One orbit
keeps (s) fixed and repeats (x_{n+1}=T_s(x_n)).

## Start with five exact values

At parameter (s=2), evaluate the quarter grid:

| State (x) | (T_2(x)) |
|---:|---:|
| (0) | (0) |
| (1/4) | (1/2) |
| (1/2) | (1) |
| (3/4) | (1/2) |
| (1) | (0) |

The table exhibits the tent shape and its midpoint symmetry. It checks five
states, not every real input.

{{< reference-figure
  wide="true"
  src="tent-map-shape.svg"
  alt="Two straight branches rise from zero to a midpoint peak labeled s over two and descend to zero, with matching points x and one minus x connected by a symmetry marker."
  caption="**Two affine pieces, one continuous map:** the left branch is s times x and the right branch is s times one minus x. Reflection about one half preserves the output."
>}}

## Branches, interval, and fixed points

The minimum produces the piecewise formula

\[
T_s(x)=
\begin{cases}
sx,&x\le1/2,\\
s(1-x),&1/2\le x.
\end{cases}
\]

The branches meet at (T_s(1/2)=s/2), so the map is continuous. The closed
unit interval maps into itself exactly when (0\le s\le2). Necessity comes
from the midpoint. Sufficiency comes from

\[
0\le\min\{x,1-x\}\le\frac12
\quad\text{for }x\in[0,1].
\]

Zero is fixed for every (s). If (s\gt1), the only other fixed point in the
unit interval is (s/(s+1)). At the boundary (s=1), every point in
([0,1/2]) is fixed. A statement valid only for (s\gt1) must not erase that
fixed-interval boundary.

The derivative is (s) on the open left branch and (-s) on the open right
branch. For (s\ne0), the two slopes meet at a corner, so the map is not
differentiable at (1/2). Continuity and differentiability are different
claims.

## In Lean

{{< lean-bridge
  human="The tent map is the slope times the smaller of x and one minus x."
  math="\( T_s(x)=s\min\{x,1-x\}. \)"
  lean="def tentMap (s x : ℝ) : ℝ :=\n  s * min x (1 - x)"
>}}
`s` selects the family member. `x` is the state. Real `min` packages both
affine branches into one total function.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.Models.TentMap

open NonlinearDynamics.Deterministic.Models

#check tentMap
#check tentMap_one_sub
#check tentMap_mapsTo_unitInterval_iff
#check not_differentiableAt_tentMap_oneHalf
~~~

This is a **full project check** on macOS or Linux. It uses the pinned Lean and
Mathlib dependencies and may require substantial disk space or build time.

{{< repo-check >}}
The command checks the exact source module. It does not infer long-run
dynamics from a plotted graph or a finite orbit table.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/TentMap.lean
```

Continue with [the Deep Dive]({{< relref
"/knowledge-base/deep-dives/tent-map-branches-fixed-points-and-the-turning-point"
>}}) for the complete interval and fixed-point arguments, or review
[orbit and iterate]({{< relref "/knowledge-base/glossary/orbit-and-iterate" >}})
for the time notation.

## What this entry does not claim

The definition and first-order facts do not establish topological
transitivity, dense periodic points, sensitive dependence, entropy, mixing,
an invariant probability measure, symbolic coding, or conjugacy to the
logistic map. Those statements require their own hypotheses and proofs.

## References

- Welington de Melo and Sebastian van Strien, *One-Dimensional Dynamics*,
  Springer, 1993. [DOI 10.1007/978-3-642-78043-1](https://doi.org/10.1007/978-3-642-78043-1).
- José S. Cánovas, "Parrondo's Paradox for Tent Maps," *Axioms* 10(2), 85
  (2021). [DOI 10.3390/axioms10020085](https://doi.org/10.3390/axioms10020085).
- Mathlib contributors,
  [`Order.MinMax`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/MinMax.lean) and
  [`Analysis.Calculus.Deriv.Abs`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Calculus/Deriv/Abs.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.
