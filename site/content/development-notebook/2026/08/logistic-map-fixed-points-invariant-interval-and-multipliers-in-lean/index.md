---
title: "Logistic-Map Fixed Points, an Invariant Interval, and Multipliers in Lean"
slug: "logistic-map-fixed-points-invariant-interval-and-multipliers-in-lean"
date: 2026-08-09
summary: "The polynomial family r x (1-x) gets an exact fixed-point equation, a sharp unit-interval parameter range, elementary orbit checks, and derivative formulas."
lead: "Start at the midpoint of the unit interval, solve every fixed-point equation without dividing by the parameter, and separate exact multiplier calculations from later stability theorems."
draft: true
pro_reviewed: false
tags:
  - "Lean"
  - "Discrete dynamics"
  - "Logistic map"
  - "Invariant sets"
  - "Fixed points"
  - "Derivatives"
lean_module: "NonlinearDynamics.Deterministic.Models.LogisticMap"
lean_source: "formalization/NonlinearDynamics/Deterministic/Models/LogisticMap.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Models/LogisticMap.lean"
lean_source_sha256: "36961ccbda91cf9408d0f57b0f8635e1cec09bc4119bc3c08064a34c26921e6d"
toc: true
og_image: "logistic-map-fixed-points-invariant-interval-and-multipliers-in-lean-card.png"
og_image_alt: "A logistic parabola maps the unit interval into itself precisely across the highlighted parameter window from zero to four."
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
**Editorial status.** This is a private AI-assisted working draft.
Professional review and the warning-fatal Lean release gate remain pending, so
`pro_reviewed` remains false. The source interface described below is a
candidate until the exact commit passes the repository's pinned checks.
{{< /panel >}}

## Abstract

For a real parameter \(r\), the {{< refterm "logistic-map" "logistic map" >}}
is

\[
f_r(x)=r x(1-x).
\]

This milestone formalizes the first exact layer of that family. The source
proves continuity, solves the fixed-point equation without dividing by \(r\),
records the zero and nonzero fixed-point branches, and identifies their
collision at \(r=1\). Its central theorem is the sharp equivalence

\[
f_r([0,1])\subseteq[0,1]
\quad\Longleftrightarrow\quad
0\le r\le4.
\]

It also checks two midpoint calculations and derives
\(f_r'(x)=r(1-2x)\). The corresponding fixed-point multipliers are \(r\) at
zero and \(2-r\) on the nonzero branch. These are algebraic and calculus
facts. No theorem in the module infers attraction, Lyapunov stability,
period-doubling, or chaos from those values.

## Prior work, contribution, and non-claims

**Prior work.** May's 1976 review used first-order difference equations to
exhibit a progression from stable points through cycles to irregular
deterministic behavior. De Melo and van Strien develop the broader theory of
one-dimensional, generally noninvertible dynamics. The repository already
contains interfaces for orbits, fixed and periodic points, branches,
stability, attraction, conjugacy, bifurcation, sensitivity, and Devaney chaos.

**Contribution.** The candidate connects those abstract interfaces to the
first concrete polynomial model in `Deterministic.Models`. It gives exact
fixed-point and invariant-domain theorems, rather than a numerical plot or a
finite sample of parameters. It also provides derivative facts that a later
local-stability theorem may consume.

**Non-claims.** The candidate proves no local derivative criterion for
stability, no stability exchange at \(r=1\), no flip bifurcation at \(r=3\),
no periodic-window result, no dense-orbit theorem, no sensitive-dependence
result, and no universality statement. A branch collision alone is not fed to
the project's topological-bifurcation predicate.

## Begin at the midpoint

Take \(x=1/2\). Direct substitution gives

\[
f_r(1/2)=r\left(\frac12\right)\left(1-\frac12\right)
=\frac r4.
\]

This one point detects both sharp parameter boundaries. If \(r\lt0\), its image
is below zero. If \(r\gt4\), its image is above one. Therefore either parameter
range prevents the entire closed unit interval from mapping into itself.

For \(0\le r\le4\), let \(x\in[0,1]\). Both \(x\) and \(1-x\) are
nonnegative, and completing the square gives

\[
x(1-x)=\frac14-\left(x-\frac12\right)^2\le\frac14.
\]

Multiplying by nonnegative \(r\) yields

\[
0\le r x(1-x)\le \frac r4\le1.
\]

The midpoint supplies necessity; the square bound supplies sufficiency. The
two arguments together establish the equivalence for every real parameter.

{{< reference-figure
  wide="true"
  src="invariant-window.svg"
  alt="Three parameter panels show the midpoint below zero for negative r, inside the unit interval for r from zero to four, and above one for r greater than four."
  caption="**A sharp gate:** the midpoint detects both failures outside the highlighted parameter window. Inside the window, the global quadratic bound controls every state in the interval."
>}}

The figure organizes the cases. The algebra above establishes the universal
statement.

## Solve the fixed-point equation without losing a parameter

A fixed point satisfies

\[
r x(1-x)=x.
\]

Factoring gives

\[
x\bigl(r(1-x)-1\bigr)=0.
\]

Hence either \(x=0\), or

\[
r(1-x)=1
\quad\Longleftrightarrow\quad
r x=r-1.
\]

The source stops at `r * x = r - 1` in its division-free classification.
That equation remains valid at \(r=0\). Only after assuming \(r\ne0\) does
the module define the second branch

\[
b(r)=1-\frac1r.
\]

The zero branch exists for every real parameter. The branch \(b\) is asserted
to be fixed only on the set of nonzero parameters. Solving \(b(r)=0\) under
that domain condition gives \(r=1\), so the two branches meet there.

This is a pointwise branch statement. `IsFixedPointBranchOn` does not bundle
continuity, maximal continuation, stability, or a bifurcation classification.

## Two exact orbits anchor the formulas

At \(r=2\), the midpoint is fixed:

\[
f_2(1/2)=1/2.
\]

At \(r=4\), the same start follows the short chain

\[
\frac12\longmapsto1\longmapsto0\longmapsto0.
\]

The source records the first arrow explicitly and provides the general
endpoint simplifications `logisticMap_one` and `logisticMap_zero`, from which
the rest follows. These calculations establish facts about the displayed
initial states and parameters. They do not classify all orbits.

## Derivatives and multipliers

The product rule gives

\[
f_r'(x)
=r\bigl((1-x)-x\bigr)
=r(1-2x).
\]

At the zero fixed point,

\[
f_r'(0)=r.
\]

On the nonzero branch \(b(r)=1-1/r\), for \(r\ne0\),

\[
f_r'(b(r))
=r\left(1-2\left(1-\frac1r\right)\right)
=2-r.
\]

{{< reference-figure
  wide="true"
  src="branch-multiplier-ledger.svg"
  alt="The zero branch and the branch one minus one over r meet at r equals one. A ledger labels their exact derivative values r and two minus r, while a separate stability gate remains unproved."
  caption="**What is checked and what is deferred:** branch geometry and multiplier formulas are exact. Converting a multiplier inequality into a local stability or attraction theorem requires a separate checked criterion."
>}}

In one-dimensional smooth dynamics, multiplier magnitudes are standard inputs
to local fixed-point analysis. This module intentionally records the inputs
without importing an unstated theorem. In particular, a diagram shading
“attracting” parameter bands would assert more than this source establishes.

## In Lean

{{< lean-bridge
  human="The closed unit interval maps into itself exactly when the real parameter lies from zero through four."
  math="\( f_r([0,1])\subseteq[0,1]\iff r\in[0,4]. \)"
  lean="@[simp] theorem logisticMap_mapsTo_unitInterval_iff (r : ℝ) :\n    MapsTo (logisticMap r) (Set.Icc 0 1) (Set.Icc 0 1) ↔\n      r ∈ Set.Icc 0 4"
>}}
`MapsTo f A B` expands to `∀ x ∈ A, f x ∈ B`. `Set.Icc 0 1` is the closed
interval. The theorem is an `↔`, so it contains both the invariant-interval
proof and the midpoint obstruction outside the parameter range.
{{< /lean-bridge >}}

{{< lean-bridge
  human="The derivative of the logistic map is r times one minus twice the state."
  math="\( f_r'(x)=r(1-2x). \)"
  lean="theorem hasDerivAt_logisticMap (r x : ℝ) :\n    HasDerivAt (logisticMap r) (r * (1 - 2 * x)) x"
>}}
`HasDerivAt f d x` states the derivative candidate `d` at `x`. The proof
builds this fact from Mathlib's identity, constant, subtraction, product, and
constant-multiplication derivative rules. Kernel checking confirms the
resulting proof term against this formal statement.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.Models.LogisticMap

open Set
open NonlinearDynamics.Deterministic.Models

#check logisticMap_isFixedPt_iff
#check logisticMap_mapsTo_unitInterval_iff
#check hasDerivAt_logisticMap
#check deriv_logisticMap_nonzeroFixedPoint
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
The command checks the exact model module with warnings treated as errors.
Lean checks the formal fixed-point, interval, and derivative statements. It
does not certify a population-model interpretation or any omitted stability
claim.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/LogisticMap.lean
```

## Declaration map

- `logisticMap` defines \(r x(1-x)\), and `logisticFamily` exposes the same
  function through the parameter-family interface.
- `logisticMap_zero` and `logisticMap_one` calculate the two endpoints.
- `continuous_logisticMap` proves continuity for each fixed parameter.
- `logisticMap_isFixedPt_iff` gives the division-free classification
  \(x=0\lor rx=r-1\).
- `logisticNonzeroFixedPoint` names \(1-1/r\), while
  `logisticNonzeroFixedPoint_isFixedPt` supplies its required nonzero-domain
  proof.
- `logisticFamily_zero_isFixedPointBranchOn` and
  `logisticFamily_nonzero_isFixedPointBranchOn` connect both formulas to the
  branch interface.
- `logisticNonzeroFixedPoint_eq_zero_iff` identifies the branch collision at
  \(r=1\).
- `logisticCore_nonneg` and `logisticCore_le_oneQuarter` bound \(x(1-x)\).
- `logisticMap_oneHalf` calculates the midpoint image.
- `logisticMap_mapsTo_unitInterval` proves sufficiency, and
  `logisticMap_parameter_mem_unitInterval_of_mapsTo` proves necessity.
- `logisticMap_mapsTo_unitInterval_iff` packages the sharp equivalence.
- `logisticMap_two_oneHalf` and `logisticMap_four_oneHalf` provide exact
  anchor calculations.
- `hasDerivAt_logisticMap` and `deriv_logisticMap` give the general derivative.
- `deriv_logisticMap_zero` and
  `deriv_logisticMap_nonzeroFixedPoint` calculate the two branch multipliers.

## Discussion

The sharp invariant-interval theorem is a useful model boundary. Restricting
to \(0\le r\le4\) makes the compact interval a genuine state space for every
iterate. Outside that range, the real polynomial still defines a self-map of
ℝ, but not a self-map of \([0,1]\). Statements about interval dynamics must
therefore carry the parameter hypothesis rather than treating it as
background convention.

The division-free fixed-point theorem is similarly deliberate. Writing the
second solution immediately as \(1-1/r\) hides the exceptional parameter
\(r=0\). The formal interface first records an equation valid everywhere and
then introduces division under an explicit nonzero hypothesis.

The next mathematical layer should state and prove a one-dimensional local
fixed-point criterion before interpreting the multiplier formulas. After that
bridge exists, stability exchanges and periodic branches can be discussed
without relying on an informal derivative heuristic.

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
