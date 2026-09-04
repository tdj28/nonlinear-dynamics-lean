---
title: "Tent-Map Branches, an Invariant Interval, and a Turning Point in Lean"
slug: "tent-map-branches-invariant-interval-and-turning-point-in-lean"
date: 2026-08-09
summary: "The piecewise-linear tent family gets exact branch formulas, a sharp unit-interval parameter gate, fixed-point classifications, and its differentiability boundary."
lead: "A single midpoint finds the parameter window, two affine branches expose the fixed points and slopes, and the corner at one half keeps continuity separate from differentiability."
draft: true
pro_reviewed: false
tags:
  - "Lean"
  - "Discrete dynamics"
  - "Tent map"
  - "Invariant sets"
  - "Fixed points"
  - "Piecewise linear maps"
lean_module: "NonlinearDynamics.Deterministic.Models.TentMap"
lean_source: "formalization/NonlinearDynamics/Deterministic/Models/TentMap.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Models/TentMap.lean"
lean_source_sha256: "901090d0c34d055932d92a689ace5a4f02cb73507bf70d627e6a69757e2c7bf9"
toc: true
og_image: "tent-map-branches-invariant-interval-and-turning-point-in-lean-card.png"
og_image_alt: "A two-branch tent peaks at the midpoint, beside the exact slope window from zero to two and a warning that the corner is not differentiable."
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
candidate until its exact commit passes the repository's pinned checks.
{{< /panel >}}

## Abstract

For a real slope parameter (s), the {{< refterm "tent-map" "tent map" >}}
in this milestone is

\[
T_s(x)=s\min\{x,1-x\}
=s\left(\frac12-\left|x-\frac12\right|\right).
\]

The candidate formalizes both affine branches, their shared midpoint value,
continuity, midpoint symmetry, and the sharp equivalence

\[
T_s([0,1])\subseteq[0,1]
\quad\Longleftrightarrow\quad
0\le s\le2.
\]

For (s\gt1), it classifies the fixed points in the unit interval as (0)
and (s/(s+1)). At the boundary (s=1), the fixed set is the entire interval
([0,1/2]), not merely two points. The source also calculates the branch
derivatives (s) and (-s), and proves that a nonzero tent is not
differentiable at its turning point. These results do not establish
transitivity, dense periodic points, sensitivity, mixing, entropy, or a
conjugacy with another map.

## Prior work, contribution, and non-claims

**Prior work.** The tent family is a standard piecewise-linear model in
one-dimensional dynamics. De Melo and van Strien develop the surrounding
theory of noninvertible interval maps. Cánovas uses the same slope convention,
with (sx) on the left half and (s-sx) on the right half. Mathlib supplies
the fixed-point, continuity, order, absolute-value, and derivative primitives
used by this module.

**Contribution.** This candidate connects the repository's abstract discrete
dynamics interfaces to its second concrete map. It packages the piecewise
definition as one total real function, proves the exact parameter gate instead
of assuming it, exposes the slope-one fixed-interval boundary, and records the
corner and branch multipliers with their hypotheses.

**Non-claims.** No finite table, diagram, branch slope, or short orbit is used
as a substitute for a chaos theorem. The candidate proves no periodic-point
density, topological transitivity, sensitive dependence, entropy formula,
invariant measure, Bernoulli property, symbolic coding, or topological
conjugacy. It also does not infer attraction or Lyapunov stability from a
multiplier magnitude.

## One formula, two affine branches

The minimum selects the smaller distance to an endpoint:

\[
T_s(x)=
\begin{cases}
sx,&x\le1/2,\\
s(1-x),&1/2\le x.
\end{cases}
\]

Both formulas give (s/2) at the turning point. The source proves
`tentMap_eq_left_of_le_oneHalf`,
`tentMap_eq_right_of_oneHalf_le`, and `tentMap_oneHalf` separately. The
identity `tentCore_eq_oneHalf_sub_abs` packages the same geometry in centered
absolute-value form, and `tentMap_eq_oneHalf_sub_abs` lifts it to the family.

The corner does not break continuity. The minimum of two continuous real
functions is continuous, so `continuous_tentMap` holds for every real
parameter. Reflection swaps the two arguments of `min`, giving

\[
T_s(1-x)=T_s(x).
\]

That symmetry is `tentMap_one_sub`.

{{< reference-figure
  wide="true"
  src="tent-parameter-gate.svg"
  alt="Three slope regions show the midpoint image below zero for negative slope, inside the unit interval from slope zero through two, and above one for slope greater than two."
  caption="**The midpoint is decisive:** its image is s over two. Outside the highlighted parameter window it leaves the unit interval; inside the window, the global half-height bound controls every point."
>}}

## The sharp unit-interval gate

Take (x\in[0,1]). Both (x) and (1-x) are nonnegative, hence

\[
0\le\min\{x,1-x\}.
\]

At least one of (x) and (1-x) is at most (1/2), so

\[
\min\{x,1-x\}\le\frac12.
\]

The source records these bounds as `tentCore_nonneg` and
`tentCore_le_oneHalf`. If (0\le s\le2), then

\[
0\le T_s(x)\le\frac{s}{2}\le1.
\]

This establishes `tentMap_mapsTo_unitInterval`. Conversely, the midpoint
belongs to the source interval, so an assumed `MapsTo` statement forces
(s/2\in[0,1]), hence (s\in[0,2]). That is
`tentMap_parameter_mem_unitInterval_of_mapsTo`. The theorem
`tentMap_mapsTo_unitInterval_iff` packages both directions.

The theorem concerns the chosen state space. For any real (s), `tentMap s`
is still a real function. Outside ([0,2]), it is not a self-map of the
closed unit interval.

## Fixed points and the slope-one boundary

Zero is fixed for every parameter, while one maps to zero. The declarations
`tentMap_zero` and `tentMap_one` record these facts, and
`tentFamily_zero_isFixedPointBranchOn` packages zero as a global branch.

For (s\gt1), the nonzero fixed point lies on the right branch. Solving

\[
s(1-x)=x
\]

gives (x=s/(s+1)). The definition `tentNonzeroFixedPoint` names that value.
`oneHalf_lt_tentNonzeroFixedPoint` places it strictly beyond the turning
point, and `tentNonzeroFixedPoint_mem_unitInterval` places it inside the
state space. Only then does `tentNonzeroFixedPoint_isFixedPt` use the right
branch formula. `tentFamily_nonzero_isFixedPointBranchOn` packages the result
on the parameter set (s\gt1).

The classification `tentMap_isFixedPt_iff_of_one_lt` proves that, for a state
in ([0,1]), those two points are exhaustive. On the left, (sx=x) with
(s\gt1) forces (x=0). On the right, (s(1-x)=x) forces
(x=s/(s+1)).

At (s=1), every (x\in[0,1/2]) satisfies (T_1(x)=x). The theorem
`tentMap_one_isFixedPt_iff` records the entire fixed interval. This is why the
(s\gt1) classification cannot be extended to the boundary by deleting its
strict hypothesis.

At (s=2), `tentMap_two_isFixedPt_iff` specializes the fixed points to (0)
and (2/3). `tentMap_two_oneHalf` and
`tentMap_two_iterate_two_oneHalf` check the short orbit

\[
\frac12\longmapsto1\longmapsto0.
\]

That calculation establishes exactly those transitions.

## Branch derivatives and the corner

On the open left branch, `hasDerivAt_tentMap_of_lt_oneHalf` gives derivative
(s). On the open right branch,
`hasDerivAt_tentMap_of_oneHalf_lt` gives derivative (-s). The corresponding
operator formulas are `deriv_tentMap_of_lt_oneHalf` and
`deriv_tentMap_of_oneHalf_lt`.

If (s\ne0), those one-sided slopes disagree at the midpoint. The theorem
`not_differentiableAt_tentMap_oneHalf` formalizes the corner by reducing a
hypothetical derivative to differentiability of absolute value at zero,
contradicting Mathlib's checked theorem. The nonzero assumption is necessary:
when (s=0), the map is constant and differentiable everywhere.

{{< reference-figure
  wide="true"
  src="tent-fixed-points-slopes.svg"
  alt="The left tent branch has slope s and fixed point zero, while the right branch has slope minus s and fixed point s over s plus one for slope above one. The midpoint corner is labeled nondifferentiable for nonzero s."
  caption="**Exact calculus boundary:** the affine branch derivatives and fixed-point multipliers are checked. The corner theorem needs s nonzero, and no local attraction or chaos conclusion follows from the slope labels alone."
>}}

The multiplier at zero is (s), recorded by `deriv_tentMap_zero`. For
(s\gt1), the nonzero fixed point lies on the open right branch, so
`deriv_tentMap_nonzeroFixedPoint` gives multiplier (-s). These are exact
derivative values, not a stability classification.

## In Lean

{{< lean-bridge
  human="The closed unit interval maps into itself exactly when the real slope lies from zero through two."
  math="\( T_s([0,1])\subseteq[0,1]\iff s\in[0,2]. \)"
  lean="@[simp] theorem tentMap_mapsTo_unitInterval_iff (s : ℝ) :\n    MapsTo (tentMap s) (Set.Icc 0 1) (Set.Icc 0 1) ↔\n      s ∈ Set.Icc 0 2"
>}}
`MapsTo f A B` means that every member of `A` is sent to a member of `B`.
The `↔` includes both the global bound and the midpoint obstruction.
{{< /lean-bridge >}}

{{< lean-bridge
  human="A nonzero tent is continuous but not differentiable at one half."
  math="\( s\ne0\Longrightarrow T_s \text{ is not differentiable at }1/2. \)"
  lean="theorem not_differentiableAt_tentMap_oneHalf {s : ℝ} (hs : s ≠ 0) :\n    ¬ DifferentiableAt ℝ (tentMap s) ((1 : ℝ) / 2)"
>}}
`DifferentiableAt ℝ f x` is Mathlib's real differentiability predicate. The
negation applies only at the turning point; each open branch has a
`HasDerivAt` theorem.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.Models.TentMap

open Set
open NonlinearDynamics.Deterministic.Models

#check tentMap_eq_left_of_le_oneHalf
#check tentMap_mapsTo_unitInterval_iff
#check tentMap_isFixedPt_iff_of_one_lt
#check tentMap_one_isFixedPt_iff
#check not_differentiableAt_tentMap_oneHalf
#check deriv_tentMap_nonzeroFixedPoint
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
The command checks the exact model module with warnings treated as errors.
Lean's kernel checks proof terms against the formal statements. It does not
certify any omitted chaos, entropy, invariant-measure, or modeling claim.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/TentMap.lean
```

## Declaration map

- `tentMap` defines the family, and `tentFamily` exposes it through
  `ParameterizedFamily`.
- `tentMap_zero`, `tentMap_one`, `tentMap_eq_left_of_le_oneHalf`,
  `tentMap_eq_right_of_oneHalf_le`, and `tentMap_oneHalf` give the endpoint,
  branch, and peak calculations.
- `tentCore_eq_oneHalf_sub_abs`, `tentMap_eq_oneHalf_sub_abs`,
  `continuous_tentMap`, and `tentMap_one_sub` give the centered, continuity,
  and symmetry interfaces.
- `tentCore_nonneg`, `tentCore_le_oneHalf`, `tentMap_mapsTo_unitInterval`,
  `tentMap_parameter_mem_unitInterval_of_mapsTo`, and
  `tentMap_mapsTo_unitInterval_iff` establish the sharp state-space gate.
- `tentFamily_zero_isFixedPointBranchOn`, `tentNonzeroFixedPoint`,
  `oneHalf_lt_tentNonzeroFixedPoint`,
  `tentNonzeroFixedPoint_mem_unitInterval`,
  `tentNonzeroFixedPoint_isFixedPt`, and
  `tentFamily_nonzero_isFixedPointBranchOn` construct the branches with their
  exact domains.
- `tentMap_isFixedPt_iff_of_one_lt` classifies the (s\gt1) unit-interval
  fixed set, while `tentMap_one_isFixedPt_iff` preserves the slope-one
  continuum boundary.
- `tentMap_two_oneHalf`, `tentMap_two_iterate_two_oneHalf`, and
  `tentMap_two_isFixedPt_iff` give exact facts for the standard full tent.
- `hasDerivAt_tentMap_of_lt_oneHalf`,
  `hasDerivAt_tentMap_of_oneHalf_lt`,
  `not_differentiableAt_tentMap_oneHalf`, `deriv_tentMap_of_lt_oneHalf`,
  `deriv_tentMap_of_oneHalf_lt`, `deriv_tentMap_zero`, and
  `deriv_tentMap_nonzeroFixedPoint` expose the first-order interface.

## Discussion

The tent and logistic families share a proof pattern at the state-space level:
a midpoint gives necessity and a global core bound gives sufficiency. Their
fixed-point boundaries are not interchangeable. The slope-one tent has a
whole interval of fixed states, which must remain visible in any later
bifurcation account.

The corner is another useful interface boundary. A piecewise-linear map can
be continuous without being differentiable at its turning point. A future
proof using a global derivative formula would therefore be malformed. The
current API gives separate open-branch derivatives and a checked
non-differentiability theorem.

Future work may connect the parameter-two member to the repository's symbolic
coding and Devaney interfaces. Such a connection must construct the coding or
direct topological proofs and state the exact state space. The graph and slope
magnitudes do not supply those theorems by themselves.

## References

1. Welington de Melo and Sebastian van Strien, *One-Dimensional Dynamics*,
   Springer, 1993. [DOI 10.1007/978-3-642-78043-1](https://doi.org/10.1007/978-3-642-78043-1).
2. José S. Cánovas, "Parrondo's Paradox for Tent Maps," *Axioms* 10(2), 85
   (2021). [DOI 10.3390/axioms10020085](https://doi.org/10.3390/axioms10020085).
3. John Milnor and William Thurston, "On Iterated Maps of the Interval," in
   *Dynamical Systems*, Lecture Notes in Mathematics 1342, 465–563.
   [DOI 10.1007/BFb0082847](https://doi.org/10.1007/BFb0082847).
4. Mathlib contributors,
   [`Order.MinMax`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/MinMax.lean),
   [`Topology.Order.OrderClosed`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/Order/OrderClosed.lean), and
   [`Analysis.Calculus.Deriv.Abs`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Calculus/Deriv/Abs.lean),
   pinned revision `81a5d257` used by Mathlib 4.32.0.
