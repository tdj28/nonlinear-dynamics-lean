---
title: "Tent-Map Branches, Fixed Points, and the Turning Point"
slug: "tent-map-branches-fixed-points-and-the-turning-point"
date: 2026-08-09
summary: "A midpoint test gives the exact state-space gate, branch equations classify fixed points, and absolute value isolates the nondifferentiable corner."
lead: "Follow one exact quarter-grid example into the general two-branch proof, then keep the slope-one fixed interval and the midpoint corner visible as real boundary cases."
draft: true
pro_reviewed: false
level: "Introductory real analysis and discrete dynamical systems"
reading_time: "30 to 45 minutes"
prerequisites: "Closed intervals, fixed points, elementary derivatives, and one-step iteration are introduced through the running example"
lean_module: "NonlinearDynamics.Deterministic.Models.TentMap"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Models/TentMap.lean"
lean_source_sha256: "901090d0c34d055932d92a689ace5a4f02cb73507bf70d627e6a69757e2c7bf9"
toc: true
og_image: "tent-map-branches-fixed-points-and-the-turning-point-card.png"
og_image_alt: "A symmetric tent map displays its exact zero-to-two parameter gate, two fixed points above slope one, and a corner at the midpoint."
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

## Run the standard tent on a quarter grid

Set (s=2) and begin with five states:

\[
0,\quad\frac14,\quad\frac12,\quad\frac34,\quad1.
\]

The update (T_2(x)=2\min\{x,1-x\}) gives

\[
0,\quad\frac12,\quad1,\quad\frac12,\quad0.
\]

The left two nonzero states use (2x). The right two use (2(1-x)). The
midpoint is the peak, and reflection (x\mapsto1-x) leaves the output
unchanged.

{{< reference-figure
  wide="true"
  src="tent-branches.svg"
  alt="The standard tent map connects the five quarter-grid states to outputs zero, one half, one, one half, and zero, with the left and right affine rules labeled."
  caption="**A finite entry point:** the five exact values act out both branches and symmetry. They illustrate the formula but do not establish a theorem over every real input."
>}}

The page bundle includes a **standalone tutorial** that exhausts exactly this
finite table with Lean core and `Std`:

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/tent-map-branches-fixed-points-and-the-turning-point/tent-grid.lean
```

The worksheet's exhaustive check establishes equality of the displayed
five-element list. Its trust boundary is finite and explicit. The real
interval theorem belongs to the Mathlib-backed project module.

## Turn the minimum into two branches

For any real (x), compare (x) with (1/2). If (x\le1/2), then
(x\le1-x), so the minimum is (x). If (1/2\le x), then
(1-x\le x), so the minimum is (1-x). Therefore

\[
T_s(x)=
\begin{cases}
sx,&x\le1/2,\\
s(1-x),&1/2\le x.
\end{cases}
\]

The inequalities overlap at the midpoint, where both formulas equal (s/2).
That overlap is intentional: it makes the total map continuous without
selecting an arbitrary branch at equality.

Centering at (1/2) gives a second useful form:

\[
\min\{x,1-x\}
=\frac12-\left|x-\frac12\right|.
\]

This identity displays the peak, reflection symmetry, and corner. The source
proves it by splitting on (x\le1/2), applying the appropriate sign formula
for absolute value, and normalizing the resulting linear equality.

## Prove the state-space gate in both directions

Suppose (x\in[0,1]). Then (x\ge0) and (1-x\ge0), so their minimum is
nonnegative. Also either (x\le1/2) or (1-x\le1/2). Hence

\[
0\le\min\{x,1-x\}\le\frac12.
\]

If (s\in[0,2]), multiplication preserves the lower bound and gives

\[
0\le T_s(x)\le\frac{s}{2}\le1.
\]

This proves that every unit-interval input returns to the unit interval. For
necessity, test (x=1/2). If the whole interval maps into itself, then

\[
T_s(1/2)=s/2\in[0,1],
\]

which is equivalent to (s\in[0,2]). One direction is a universal inequality
and the other is a formal witness argument.

The endpoints are sharp. At (s=0), the map is constantly zero. At (s=2),
the midpoint reaches one. If (s\lt0), the midpoint image is negative. If
(s\gt2), it exceeds one.

## Classify fixed points without losing the boundary

For (s\gt1), split the fixed-point equation at the turning point. On the
left branch, (sx=x). Because (s\ne1), this forces (x=0). On the right,

\[
s(1-x)=x
\quad\Longleftrightarrow\quad
x=\frac{s}{s+1}.
\]

The strict hypothesis also places the second solution strictly to the right
of the midpoint:

\[
\frac12\lt\frac{s}{s+1}\le1.
\]

Thus the right-branch equation used to verify it is justified. The checked
classification is

\[
x\in[0,1],\ s\gt1
\quad\Longrightarrow\quad
\bigl(T_s(x)=x\iff x=0\text{ or }x=s/(s+1)\bigr).
\]

Now inspect the excluded endpoint (s=1). For every (x\in[0,1/2]), the
left formula becomes (T_1(x)=x). Above the midpoint, the right formula is
(1-x), which equals (x) only at (1/2). Therefore

\[
\{x\in[0,1]:T_1(x)=x\}=[0,1/2].
\]

{{< reference-figure
  wide="true"
  src="tent-boundaries.svg"
  alt="One panel shows the slope-one tent coinciding with the diagonal on the whole left half. A second panel shows the slope-two tent crossing the diagonal only at zero and two thirds."
  caption="**A hypothesis with visible content:** at slope one there is a continuum of fixed points. Above slope one, the unit-interval fixed set has the two-point classification used by the source."
>}}

At (s=2), the second fixed point is (2/3). The midpoint follows
(1/2\mapsto1\mapsto0). These facts are exact but narrow. They do not
classify all periodic orbits or long-run behavior.

## Separate continuity from differentiability

Each affine branch has a constant derivative:

\[
T_s'(x)=s\quad\text{for }x\lt1/2,
\qquad
T_s'(x)=-s\quad\text{for }1/2\lt x.
\]

At the turning point, these candidates agree only when (s=0). The source
does not rely on an informal picture. It rewrites the tent in absolute-value
form. If a nonzero tent were differentiable at (1/2), algebraic
rearrangement would make (x\mapsto|x-1/2|) differentiable there. Translating
the input would make ordinary absolute value differentiable at zero, contrary
to Mathlib's theorem `not_differentiableAt_abs_zero`.

This boundary matters for later dynamics. A theorem that assumes a globally
differentiable map cannot be applied to a nonzero tent without replacing that
hypothesis by a piecewise or nonsmooth interface.

The branch derivative at the fixed point zero is (s). For (s\gt1), the
nonzero fixed point lies on the open right branch and has derivative (-s).
The source records these multiplier values without asserting a stability
conclusion.

## In Lean

{{< lean-bridge
  human="Above slope one, the unit-interval fixed points are exactly zero and s divided by s plus one."
  math="\( s\gt1,\ x\in[0,1]\Longrightarrow(T_s(x)=x\iff x=0\lor x=s/(s+1)). \)"
  lean="theorem tentMap_isFixedPt_iff_of_one_lt {s x : ℝ} (hs : 1 < s)\n    (hx : x ∈ Set.Icc 0 1) :\n    IsFixedPt (tentMap s) x ↔\n      x = 0 ∨ x = tentNonzeroFixedPoint s"
>}}
`hs` excludes the slope-one fixed interval and places the named nonzero point
on the right branch. `hx` scopes exhaustiveness to the selected state space.
{{< /lean-bridge >}}

{{< lean-bridge
  human="At slope one, the unit-interval fixed set is the whole closed left half."
  math="\( x\in[0,1]\Longrightarrow(T_1(x)=x\iff x\in[0,1/2]). \)"
  lean="theorem tentMap_one_isFixedPt_iff {x : ℝ}\n    (hx : x ∈ Set.Icc 0 1) :\n    IsFixedPt (tentMap 1) x ↔\n      x ∈ Set.Icc 0 ((1 : ℝ) / 2)"
>}}
The separate theorem prevents a strict parameter hypothesis from being
silently weakened. `IsFixedPt f x` is Mathlib's predicate for `f x = x`.
{{< /lean-bridge >}}

## Try the full project module

~~~lean
import NonlinearDynamics.Deterministic.Models.TentMap

open Set
open NonlinearDynamics.Deterministic.Models

#check tentMap_eq_oneHalf_sub_abs
#check continuous_tentMap
#check tentMap_mapsTo_unitInterval_iff
#check tentMap_isFixedPt_iff_of_one_lt
#check tentMap_one_isFixedPt_iff
#check hasDerivAt_tentMap_of_lt_oneHalf
#check not_differentiableAt_tentMap_oneHalf
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
The command checks the exact source module with warnings treated as errors.
The kernel checks the branch, interval, fixed-point, and derivative proof
terms. The choice of this family as a model and every omitted asymptotic claim
remain outside those statements.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/TentMap.lean
```

## Common confusions

| Confusion | Correction |
|---|---|
| The graph stays real, so ([0,1]) is invariant for every slope. | A real function need not preserve the selected interval. The exact slope gate is ([0,2]). |
| The map has two linear formulas, so it is discontinuous. | The formulas agree at (1/2), making the total map continuous. |
| The map is continuous, so it is differentiable at the peak. | For nonzero (s), the branch slopes disagree and the midpoint is a corner. |
| The (s\gt1) fixed-point formula also covers (s=1). | At (s=1), every state in ([0,1/2]) is fixed. |
| Slopes of magnitude two establish chaos. | A graph slope is not a proof of transitivity, periodic density, or sensitivity. |
| The midpoint orbit represents typical behavior. | It is one selected initial state and reaches zero in two steps. |

## What this chapter does not claim

There is no theorem here about least periods, dense periodic points,
topological transitivity, sensitive dependence, Devaney chaos, symbolic
coding of this interval map, topological entropy, mixing, invariant measures,
ergodicity, Bernoulli dynamics, conjugacy with the logistic map, numerical
roundoff, or physical parameter estimation.

De Melo and van Strien and Milnor and Thurston supply broader interval-dynamics
context. Cánovas supplies a directly matching modern slope convention. The
Lean results are established from the displayed definition and pinned Mathlib
interfaces, not by silently importing every contextual theorem.

## Related trail markers

- [Tent map]({{< relref "/knowledge-base/glossary/tent-map" >}})
- [Orbit and iterate]({{< relref "/knowledge-base/glossary/orbit-and-iterate" >}})
- [Logistic map]({{< relref "/knowledge-base/glossary/logistic-map" >}})
- [Research Note]({{< relref "/development-notebook/2026/08/tent-map-branches-invariant-interval-and-turning-point-in-lean" >}})

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
