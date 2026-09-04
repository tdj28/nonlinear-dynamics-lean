---
title: "Logistic-Map Fixed Points, an Invariant Interval, and Multipliers"
slug: "logistic-map-fixed-points-invariant-interval-and-multipliers"
date: 2026-08-09
summary: "A complete midpoint argument finds the exact parameter window for unit-interval invariance, while fixed-point branches and multipliers remain logically separate from stability."
lead: "Calculate before generalizing: the midpoint detects both bad parameter ranges, completing the square controls every state, and a division-free equation preserves the exceptional parameter."
draft: true
pro_reviewed: false
level: "Introductory real analysis and discrete dynamical systems"
reading_time: "30 to 45 minutes"
prerequisites: "Intervals, fixed points, elementary derivatives, and one-step iteration are introduced through the worked example"
lean_module: "NonlinearDynamics.Deterministic.Models.LogisticMap"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Models/LogisticMap.lean"
lean_source_sha256: "36961ccbda91cf9408d0f57b0f8635e1cec09bc4119bc3c08064a34c26921e6d"
toc: true
og_image: "logistic-map-fixed-points-invariant-interval-and-multipliers-card.png"
og_image_alt: "A midpoint test and a completed-square bound meet at the exact logistic-map parameter window from zero to four."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted working draft.
Professional review and the warning-fatal Lean release gate remain pending;
`pro_reviewed` remains false.
{{< /panel >}}

## Start with three midpoint calculations

The {{< refterm "logistic-map" "logistic map" >}}

\[
f_r(x)=r x(1-x)
\]

depends on a real parameter \(r\). To understand whether the unit interval is
a suitable state space, test its midpoint:

\[
f_r(1/2)=\frac r4.
\]

Three parameters immediately show the regimes.

| Parameter | Midpoint image | Consequence for \([0,1]\) |
|---:|---:|---|
| \(-2\) | \(-1/2\) | the image leaves below zero |
| \(2\) | \(1/2\) | the midpoint is fixed |
| \(6\) | \(3/2\) | the image leaves above one |

The first and third rows are counterexamples to unit-interval invariance at
those two parameters. More generally, the same midpoint refutes invariance
for every \(r\lt0\) and every \(r\gt4\).

{{< reference-figure
  wide="true"
  src="midpoint-parameter-gate.svg"
  alt="A number line highlights the parameter interval zero through four. The midpoint image r over four lies below zero to the left, inside zero through one in the highlighted band, and above one to the right."
  caption="**One witness gives necessity:** if the whole unit interval maps into itself, its midpoint must do so. The inequality zero at most r over four at most one is exactly zero at most r at most four."
>}}

## One square controls every other point

The midpoint test proves only necessity. To prove sufficiency, take an
arbitrary \(x\in[0,1]\). Then

\[
x\ge0,
\qquad
1-x\ge0,
\qquad
x(1-x)\ge0.
\]

Complete the square:

\[
\left(x-\frac12\right)^2
=x^2-x+\frac14\ge0.
\]

Rearranging gives

\[
x(1-x)\le\frac14.
\]

If \(0\le r\le4\), multiplication by the nonnegative number \(r\) preserves
the inequality:

\[
0\le f_r(x)=r x(1-x)\le\frac r4\le1.
\]

Every \(x\in[0,1]\) therefore returns to \([0,1]\) after one step. The same
argument can be applied again to the image, so every natural-number iterate
remains in the interval. The formal theorem packages the one-step fact as
`MapsTo`; iteration closure follows from the general meaning of forward
invariance.

Together, the midpoint obstruction and completed-square bound establish

\[
f_r([0,1])\subseteq[0,1]
\quad\Longleftrightarrow\quad
r\in[0,4].
\]

The claim is sharp at both endpoints. At \(r=0\), every state maps to zero. At
\(r=4\), the midpoint maps exactly to one, while all other unit-interval
states map between zero and one.

## Fixed points without premature division

A fixed point is a state \(x\) satisfying \(f_r(x)=x\). Algebra gives

\[
r x(1-x)=x
\iff
x\bigl(r(1-x)-1\bigr)=0.
\]

The product is zero exactly when one factor is zero. Thus

\[
x=0
\quad\text{or}\quad
r x=r-1.
\]

This is the source theorem's final form. It has no denominator and remains
valid at every real parameter. If \(r\ne0\), the second equation becomes

\[
x=1-\frac1r.
\]

Why retain the intermediate equation? At \(r=0\), division by \(r\) is not
defined, but the polynomial map and its fixed-point equation are defined. The
division-free statement does not discard that case. The second branch is then
introduced only on the explicit domain \(r\ne0\).

The zero branch and \(1-1/r\) meet when

\[
1-\frac1r=0,
\]

which, under \(r\ne0\), is equivalent to \(r=1\). This establishes a branch
collision. It does not establish the project's whole-state-space topological
{{< refterm "bifurcation-point" "bifurcation" >}} predicate, because zero is
a fixed point at every parameter and fixed-point existence therefore does not
change at \(r=1\).

## A small orbit ledger

At \(r=2\), start from the midpoint:

\[
x_0=\frac12,
\qquad
x_1=f_2(x_0)=\frac12.
\]

The orbit stays at this fixed point. At \(r=4\),

\[
x_0=\frac12,
\quad
x_1=1,
\quad
x_2=0,
\quad
x_3=0.
\]

The two examples show different trajectories in two selected systems. They
do not establish a statement about all parameters or initial conditions.

The bundled **standalone tutorial** imports only `Std` and evaluates a scaled
five-point table for the quadratic core. It is intentionally finite: it
checks all entries of that table, not the real-interval theorem.

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/logistic-map-fixed-points-invariant-interval-and-multipliers/logistic-grid.lean
```

## Derivative data is not yet a stability conclusion

Using the product rule,

\[
f_r'(x)=r(1-2x).
\]

At the zero branch, the derivative is \(r\). At the nonzero branch,

\[
f_r'\left(1-\frac1r\right)=2-r.
\]

{{< reference-figure
  wide="true"
  src="fixed-branches-and-multipliers.svg"
  alt="Two fixed-point branches meet at parameter one. The horizontal zero branch is labeled multiplier r, and the curved one minus one over r branch is labeled multiplier two minus r. A separate unfilled box says local stability criterion not yet applied."
  caption="**Exact inputs, bounded conclusion:** the source checks both branch equations and both derivative formulas. It does not infer attraction or stability from a multiplier magnitude."
>}}

The standard one-dimensional heuristic says that a differentiable fixed point
with multiplier magnitude below one is locally attracting under suitable
local hypotheses. This chapter does not treat that sentence as an available
theorem. A checked bridge must state the neighborhood, differentiability, and
contraction assumptions and prove the orbit conclusion. Until then, the
multiplier formulas are inputs to later work.

For the same reason, the branch collision at \(r=1\) is not labeled a
transcritical bifurcation here, and the value \(r=3\), where the nonzero
branch multiplier equals \(-1\), is not labeled a flip bifurcation theorem.
Normal-form, nondegeneracy, and stability information would be required.

## In Lean

{{< lean-bridge
  human="A state is fixed exactly when it is zero or satisfies the division-free linear equation r times x equals r minus one."
  math="\( f_r(x)=x\iff x=0\lor rx=r-1. \)"
  lean="@[simp] theorem logisticMap_isFixedPt_iff (r x : ℝ) :\n    IsFixedPt (logisticMap r) x ↔ x = 0 ∨ r * x = r - 1"
>}}
`IsFixedPt` is Mathlib's fixed-point predicate. The disjunction `∨` records
the two factors. No `r ≠ 0` assumption appears because the theorem performs
no division.
{{< /lean-bridge >}}

{{< lean-bridge
  human="The unit interval is forward invariant exactly for parameters from zero to four."
  math="\( f_r([0,1])\subseteq[0,1]\iff r\in[0,4]. \)"
  lean="@[simp] theorem logisticMap_mapsTo_unitInterval_iff (r : ℝ) :\n    MapsTo (logisticMap r) (Set.Icc 0 1) (Set.Icc 0 1) ↔\n      r ∈ Set.Icc 0 4"
>}}
`MapsTo` quantifies over every state in the source set. `Set.Icc` includes
both endpoints. The reverse direction evaluates the map at `1 / 2`; the
forward direction uses nonnegativity and the completed-square bound.
{{< /lean-bridge >}}

## Try the full project module

~~~lean
import NonlinearDynamics.Deterministic.Models.LogisticMap

open Set
open NonlinearDynamics.Deterministic.Models

#check logisticMap_isFixedPt_iff
#check logisticFamily_nonzero_isFixedPointBranchOn
#check logisticMap_mapsTo_unitInterval_iff
#check deriv_logisticMap_nonzeroFixedPoint
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
This command checks the exact source module with warnings treated as errors.
The kernel checks proof terms against the formal statements. The modeling
choice that \(x\), \(1-x\), and \(r\) represent a particular application
remains an external interpretation.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/LogisticMap.lean
```

## Common confusions

| Confusion | Correction |
|---|---|
| The polynomial maps ℝ to ℝ, so it maps \([0,1]\) to itself. | A real self-map need not preserve the selected interval. The exact parameter condition is \(0\le r\le4\). |
| The second fixed point is always \(1-1/r\). | That formula requires \(r\ne0\). The division-free equation handles every parameter. |
| A fixed-point branch is an orbit. | A branch changes \(r\); an orbit iterates one fixed \(f_r\). |
| Two branches meet, so a bifurcation theorem is complete. | The project predicate needs a justified qualitative inequivalence near the parameter. |
| A derivative was computed, so stability follows. | A local orbit theorem with explicit hypotheses is still required. |
| The \(r=4\) midpoint orbit establishes chaos. | It reaches zero after two steps and says nothing universal about other starts. |

## What this chapter does not claim

There is no theorem here about local attraction, Lyapunov stability,
hyperbolicity, stability exchange, least period, period doubling, symbolic
coding of the logistic map, sensitive dependence, topological transitivity,
dense periodic points, invariant measures, entropy, universality, numerical
roundoff, or biological parameter estimation.

May's review is cited for the historical and scientific role of simple
first-order difference equations. The exact results in this chapter are
established directly from the displayed polynomial and checked candidate
source. De Melo and van Strien provide broader context for interval dynamics;
their general results are not silently imported into this Lean module.

## Related trail markers

- [Logistic map]({{< relref "/knowledge-base/glossary/logistic-map" >}})
- [Orbit and iterate]({{< relref "/knowledge-base/glossary/orbit-and-iterate" >}})
- [Bifurcation point]({{< relref "/knowledge-base/glossary/bifurcation-point" >}})
- [Research Note]({{< relref "/development-notebook/2026/08/logistic-map-fixed-points-invariant-interval-and-multipliers-in-lean" >}})

## References

1. Robert M. May, “Simple mathematical models with very complicated
   dynamics,” *Nature* 261, 459–467 (1976).
   [DOI 10.1038/261459a0](https://doi.org/10.1038/261459a0).
2. Welington de Melo and Sebastian van Strien, *One-Dimensional Dynamics*,
   Springer, 1993. [DOI 10.1007/978-3-642-78043-1](https://doi.org/10.1007/978-3-642-78043-1).
3. Mathlib contributors,
   [`Dynamics.FixedPoints.Basic`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/FixedPoints/Basic.lean)
   and
   [`Analysis.Calculus.Deriv.Mul`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Calculus/Deriv/Mul.lean),
   pinned revision `81a5d257` used by Mathlib 4.32.0.
