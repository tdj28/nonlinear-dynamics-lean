---
title: "Lotka-Volterra Vector Field and First Integral in Lean"
slug: "lotka-volterra-vector-field-and-first-integral-in-lean"
date: 2026-08-11
summary: "A four-parameter predator-prey field gets an explicit phase-space convention, complete positive-parameter equilibria, axis formulas, and a strictly positive pointwise first-integral identity."
lead: "Begin at one exact prey-predator state, keep the full plane separate from the positive quadrant, and stop before invariance, periodic-orbit, flow, or stability claims."
draft: true
pro_reviewed: false
tags:
  - "Lean"
  - "Continuous dynamics"
  - "Ordinary differential equations"
  - "Lotka-Volterra"
  - "Predator-prey models"
  - "First integrals"
lean_module: "NonlinearDynamics.Deterministic.Models.LotkaVolterra"
lean_source: "formalization/NonlinearDynamics/Deterministic/Models/LotkaVolterra.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Models/LotkaVolterra.lean"
lean_source_sha256: "cc080be90c157df512b659b6d75ae55eac3e0f8ecce6da03e83a842e1d9f71cc"
toc: true
og_image: "lotka-volterra-vector-field-and-first-integral-in-lean-card.png"
og_image_alt: "A prey-predator state at two comma three maps to vector minus four comma three, beside a positive-quadrant first-integral boundary."
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
Professional review and pinned-toolchain validation remain pending, so
`pro_reviewed` remains false. The Lean interface described below is a
source-only candidate until that validation is complete.
{{< /panel >}}

## Abstract

The four-parameter {{< refterm "lotka-volterra-predator-prey-model"
"Lotka-Volterra predator-prey model" >}} used here is

\[
\begin{aligned}
x'&=x(\alpha-\beta y),\\
y'&=y(\delta x-\gamma).
\end{aligned}
\]

The coordinate \(x\) is prey abundance and \(y\) is predator abundance. The
parameters \(\alpha,\beta,\gamma,\delta\) are kept explicit and become
strictly positive only where the predator-prey interpretation or the complete
equilibrium classification needs that assumption.

The candidate defines the polynomial {{< refterm "vector-field" "vector field" >}}
on the full plane \(\mathbb R^2\), names the strict positive quadrant as a
separate set, classifies the two field zeros for positive parameters, records
the exact axis formulas, and evaluates the normalized state \((2,3)\). On
positive component values it defines

\[
H(x,y)=\delta x-\gamma\log x+\beta y-\alpha\log y
\]

and checks the pointwise derivative cancellation \(dH/dt=0\) under explicit
component ODE hypotheses. It does not construct a nonconstant solution or
promote that cancellation to a closed-orbit, periodicity, flow, invariance,
or stability theorem.

## Prior work, contribution, and non-claims

**Prior work.** Lotka's 1920 PNAS article writes a plant or prey coordinate
as \(X_1(A_1-B_1X_2)\) and a consumer coordinate as
\(X_2(A_2X_1-B_2)\) in equations (8) and (10), then lists the extinction and
coexistence equilibria in equations (11) and (12). Volterra's 1926 *Nature*
article develops the interacting-species problem independently. Lotka's 1927
letter documents the overlap with his 1925 book. The source record matters
here because parameter letters and coordinate order vary across modern
presentations.

**Contribution.** This candidate freezes one repository convention:
\((\alpha,\beta,\gamma,\delta)=(A_1,B_1,B_2,A_2)\), prey first and predator
second. It then separates three mathematical layers that are often merged in
an informal phase portrait: a full-plane polynomial field, algebraic facts
about its zeros and axes, and a logarithmic identity whose derivative theorem
requires strict positivity at the time under study.

**Non-claims.** The axis formulas show tangency of the field, but this module
does not prove forward invariance of either axis or the positive quadrant. The
constant curves establish solutions only through the two named equilibria.
No theorem constructs arbitrary solutions, uniqueness, completeness, a
{{< refterm "flow" "flow" >}}, nonconstant closed or periodic orbits, an
orbit period, Lyapunov stability, attraction, or ecological adequacy for a
particular population.

## One exact state before the parameter algebra

Set all four parameters equal to one and choose \((x,y)=(2,3)\). The field is

\[
F(2,3)=\bigl(2(1-3),3(2-1)\bigr)=(-4,3).
\]

At this state the prey coordinate has negative instantaneous derivative and
the predator coordinate has positive instantaneous derivative. The pair is a
tangent vector, not the population after one unit of time. The exact equality
is `lotkaVolterraVectorField_normalized_benchmark`.

{{< reference-figure
  wide="true"
  src="normalized-benchmark.svg"
  alt="At normalized state prey two and predator three, the prey factor one minus three gives derivative minus four while the predator factor two minus one gives derivative three."
  caption="**One state, both coordinate ledgers:** each derivative is its current coordinate multiplied by a per-capita factor. The computation checks one exact field value; it does not advance time or describe an orbit."
>}}

## Why the carrier is the full plane

The vector field is a polynomial map, so it is meaningful and continuous at
every pair of real coordinates. The Lean carrier is therefore
\(\mathbb R\times\mathbb R\). Biological population states normally lie in
the nonnegative quadrant, and the logarithmic expression requires
\(x\gt0\) and \(y\gt0\) for its intended calculus interpretation. Those are
separate facts, not reasons to hide the field inside a subtype.

The candidate names

\[
Q_{++}=\{(x,y):x\gt0\text{ and }y\gt0\}
\]

as `lotkaVolterraPositiveQuadrant`. Its membership theorem exposes the two
inequalities directly. This design lets later work choose the right invariant
set or solution object without burdening the algebraic definitions with
coercions.

On the predator-free axis,

\[
F(x,0)=(\alpha x,0).
\]

On the prey-free axis,

\[
F(0,y)=(0,-\gamma y).
\]

The zero coordinate of each returned pair is the exact tangency statement.
It does not by itself establish that every solution starting on an axis exists
or remains there. Such a conclusion requires a solution and an appropriate
uniqueness or invariance argument.

## Classify the equilibria under positive parameters

The origin is a field zero for every parameter choice. If all four parameters
are strictly positive, the only other zero is

\[
p_*=\left(\frac{\gamma}{\delta},
          \frac{\alpha}{\beta}\right).
\]

Indeed, the two factored equations are

\[
x(\alpha-\beta y)=0,
\qquad
y(\delta x-\gamma)=0.
\]

If \(x=0\), positivity of \(\gamma\) forces \(y=0\). If \(x\ne0\), then
\(y=\alpha/\beta\). That positive value rules out \(y=0\), so the second
factor gives \(x=\gamma/\delta\). The reverse direction is checked by direct
substitution.

The candidate records both the zero classification and the separate fact that
\(p_*\in Q_{++}\). The latter uses all four positivity hypotheses. The
constant curve through \(p_*\) needs only \(\beta\ne0\) and
\(\delta\ne0\), because those are the denominators used in its algebraic
definition.

## The logarithmic first integral has a domain boundary

On the strict positive quadrant define

\[
H_{\alpha,\beta,\gamma,\delta}(x,y)
=\delta x-\gamma\log x+\beta y-\alpha\log y.
\]

For the normalized parameter choice, the coexistence state is \((1,1)\), and

\[
H_{1,1,1,1}(1,1)=1-\log1+1-\log1=2.
\]

Lean's `Real.log` is a total function and satisfies `Real.log 0 = 0`. That
library convention is useful for totalized analysis, but it must not erase
the mathematical domain of the logarithmic differentiation argument. The
candidate therefore leaves the scalar definition total while requiring the
visible hypotheses \(0\lt x(t)\) and \(0\lt y(t)\) in the derivative
theorem.

Suppose the component curves obey the model at one time \(t\). The chain rule
gives

\[
\begin{aligned}
\frac{dH}{dt}
&=\delta x'-\gamma\frac{x'}{x}
  +\beta y'-\alpha\frac{y'}{y}\\
&=\delta x(\alpha-\beta y)
  -\gamma(\alpha-\beta y)\\
&\quad+\beta y(\delta x-\gamma)
  -\alpha(\delta x-\gamma)\\
&=0.
\end{aligned}
\]

`hasDerivAt_lotkaVolterraFirstIntegral_along` formalizes this pointwise
calculation. The positive hypotheses justify the two logarithmic chain rules
and divisions. The component derivative hypotheses supply \(x'\) and \(y'\).
No curve is constructed inside the proof.

{{< reference-figure
  wide="true"
  src="domain-and-claim-boundary.svg"
  alt="A full-plane polynomial field contains a highlighted strictly positive quadrant where logarithmic differentiation is valid, followed by a boundary that stops before invariance, closed orbits, flows, and stability."
  caption="**Two domains and one stopping point:** the polynomial field is defined on the full plane, while the logarithmic derivative theorem uses positive component values. The checked cancellation does not supply the orbit-level statements listed beyond the boundary."
>}}

## Constant curves are the only solutions constructed here

At the origin and coexistence state, the vector field is zero. A constant
curve has zero derivative at every real time, so each state yields a global
{{< refterm "integral-curve" "integral curve" >}}. These examples establish
existence through exactly those initial states.

They do not establish that every positive initial state has a global solution.
They also do not establish that a nonconstant solution lies on a compact level
set or traverses such a set periodically. Those conclusions require more than
the displayed cancellation.

## In Lean

{{< lean-bridge
  human="The field returns the prey derivative first and the predator derivative second."
  math="\(F(x,y)=(x(\alpha-\beta y),y(\delta x-\gamma)).\)"
  lean="def lotkaVolterraVectorField (alpha beta gamma delta : ℝ)\n    (state : ℝ × ℝ) : ℝ × ℝ :=\n  (state.1 * (alpha - beta * state.2),\n    state.2 * (delta * state.1 - gamma))"
>}}
`state.1` is prey and `state.2` is predator. Each output coordinate retains
the corresponding population factor. The parameter order is fixed once in
the definition and reused throughout the module.
{{< /lean-bridge >}}

{{< lean-bridge
  human="A state lies in the strict positive quadrant exactly when both coordinates are positive."
  math="\((x,y)\in Q_{++}\iff 0\lt x\land0\lt y.\)"
  lean="@[simp] theorem mem_lotkaVolterraPositiveQuadrant\n    (state : ℝ × ℝ) :\n    state ∈ lotkaVolterraPositiveQuadrant ↔\n      0 < state.1 ∧ 0 < state.2"
>}}
`∈` is set membership. `↔` states equivalence, while `∧` requires both
coordinate inequalities. This theorem names a region; it does not say that a
solution remains there.
{{< /lean-bridge >}}

{{< lean-bridge
  human="For four positive parameters, the origin and coexistence state are exactly the field zeros."
  math="\(F(p)=0\iff p=(0,0)\lor p=(\gamma/\delta,\alpha/\beta).\)"
  lean="theorem lotkaVolterraVectorField_eq_zero_iff_of_pos\n    {alpha beta gamma delta : ℝ}\n    (hAlpha : 0 < alpha) (hBeta : 0 < beta)\n    (hGamma : 0 < gamma) (hDelta : 0 < delta)\n    (state : ℝ × ℝ) :\n    lotkaVolterraVectorField alpha beta gamma delta state = 0 ↔\n      state = (0, 0) ∨\n        state = lotkaVolterraCoexistence alpha beta gamma delta"
>}}
The four named hypotheses rule out degenerate zero coefficients. `∨` lists
the two alternatives in the complete classification.
{{< /lean-bridge >}}

{{< lean-bridge
  human="At a time where two positive component curves satisfy the model, the logarithmic first integral has derivative zero."
  math="\(x,y\gt0\land x'=x(\alpha-\beta y)\land y'=y(\delta x-\gamma)\Longrightarrow H'=0.\)"
  lean="theorem hasDerivAt_lotkaVolterraFirstIntegral_along\n    (alpha beta gamma delta : ℝ) {x y : ℝ → ℝ} {t : ℝ}\n    (hxPositive : 0 < x t) (hyPositive : 0 < y t)\n    (hx : HasDerivAt x (x t * (alpha - beta * y t)) t)\n    (hy : HasDerivAt y (y t * (delta * x t - gamma)) t) :\n    HasDerivAt\n      (fun s ↦ lotkaVolterraFirstIntegral alpha beta gamma delta\n        (x s, y s)) 0 t"
>}}
Each `HasDerivAt` names a function, its derivative value, and the time. The
conclusion is local at `t`. The positive hypotheses are part of the public
statement rather than an informal side condition.
{{< /lean-bridge >}}

## Reproduce the candidate checks

~~~lean
import NonlinearDynamics.Deterministic.Models.LotkaVolterra

open NonlinearDynamics.Deterministic.Models

#check lotkaVolterraVectorField
#check lotkaVolterraODEField
#check lotkaVolterraODEField_apply
#check lotkaVolterraPositiveQuadrant
#check mem_lotkaVolterraPositiveQuadrant
#check lotkaVolterraCoexistence
#check lotkaVolterraCoexistence_mem_positiveQuadrant
#check continuous_lotkaVolterraVectorField
#check lotkaVolterraVectorField_origin
#check lotkaVolterraVectorField_predator_free
#check lotkaVolterraVectorField_prey_free
#check lotkaVolterraVectorField_coexistence
#check lotkaVolterraVectorField_eq_zero_iff_of_pos
#check lotkaVolterraVectorField_normalized_benchmark
#check lotkaVolterraFirstIntegral
#check lotkaVolterraFirstIntegral_normalized_coexistence
#check hasDerivAt_lotkaVolterraFirstIntegral_along
#check lotkaVolterra_origin_isIntegralCurve
#check lotkaVolterra_coexistence_isIntegralCurve
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
Lean's elaborator constructs proof terms for the exact source statements, and
its kernel checks those terms. That verifies the formal algebra and calculus
claims once the module passes the pinned toolchain. It does not independently
certify the biological interpretation, construct omitted trajectories, or
turn a pointwise identity into a periodic-orbit theorem.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/LotkaVolterra.lean
```

## Declaration ledger

- `lotkaVolterraVectorField`, `lotkaVolterraODEField`, and
  `lotkaVolterraODEField_apply` define the autonomous system.
- `lotkaVolterraPositiveQuadrant` and
  `mem_lotkaVolterraPositiveQuadrant` name and unpack the strict-positive
  domain.
- `lotkaVolterraCoexistence` and
  `lotkaVolterraCoexistence_mem_positiveQuadrant` define the nonzero
  equilibrium candidate and place it in the positive quadrant under positive
  parameters.
- `continuous_lotkaVolterraVectorField` proves continuity of the polynomial
  field.
- `lotkaVolterraVectorField_origin`,
  `lotkaVolterraVectorField_predator_free`, and
  `lotkaVolterraVectorField_prey_free` record the origin and both axis
  formulas.
- `lotkaVolterraVectorField_coexistence` proves the coexistence zero under
  nonzero denominators.
- `lotkaVolterraVectorField_eq_zero_iff_of_pos` gives the complete
  positive-parameter zero classification.
- `lotkaVolterraVectorField_normalized_benchmark` checks the exact
  \((2,3)\mapsto(-4,3)\) state.
- `lotkaVolterraFirstIntegral` and
  `lotkaVolterraFirstIntegral_normalized_coexistence` define and evaluate the
  logarithmic scalar.
- `hasDerivAt_lotkaVolterraFirstIntegral_along` checks its positive-domain
  pointwise derivative cancellation.
- `lotkaVolterra_origin_isIntegralCurve` and
  `lotkaVolterra_coexistence_isIntegralCurve` exhibit the two constant global
  integral curves.

## Decision record

Four choices control the scope.

First, the source follows Lotka's prey-first factorization and maps his
\((A_1,B_1,B_2,A_2)\) to
\((\alpha,\beta,\gamma,\delta)\). The conversion is recorded instead of
assuming that parameter letters are universal.

Second, the carrier is the full plane. The positive quadrant is a named set,
not the underlying type. This keeps polynomial algebra and biological-domain
claims distinguishable.

Third, positivity is theorem-local. All four parameters are positive for the
complete equilibrium classification. Only nonzero interaction denominators
are needed for the coexistence field zero and its constant curve. Strictly
positive component values are required for logarithmic differentiation.

Fourth, conservation is local and conditional. The theorem checks a chain-rule
cancellation at one time. It does not infer forward invariance, global
existence, compact level sets, closed or periodic orbits, or stability.

## References

- Alfred J. Lotka, “Analytical Note on Certain Rhythmic Relations in Organic
  Systems,” *Proceedings of the National Academy of Sciences* 6 (1920),
  410–415, especially equations (8), (10), (11), and (12) on pp. 412–413 and
  the positive-quadrant discussion on pp. 414–415,
  [DOI 10.1073/pnas.6.7.410](https://doi.org/10.1073/pnas.6.7.410),
  [open scan at PubMed Central](https://pmc.ncbi.nlm.nih.gov/articles/PMC1084562/).
- Alfred J. Lotka, *Elements of Physical Biology* (Baltimore: Williams &
  Wilkins, 1925),
  [Internet Archive record](https://archive.org/details/elementsofphysic0000alfr).
- Vito Volterra, “Fluctuations in the Abundance of a Species Considered
  Mathematically,” *Nature* 118 (1926), 558–560,
  [DOI 10.1038/118558a0](https://doi.org/10.1038/118558a0).
- Alfred J. Lotka, “Fluctuations in the Abundance of a Species Considered
  Mathematically,” *Nature* 119 (1927), 12,
  [DOI 10.1038/119012a0](https://doi.org/10.1038/119012a0).
- Mathlib contributors,
  [`Analysis.ODE.Basic`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/ODE/Basic.lean)
  and
  [`Analysis.SpecialFunctions.Log.Deriv`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/SpecialFunctions/Log/Deriv.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.

Continue with the [Deep Dive]({{< relref
"/knowledge-base/deep-dives/lotka-volterra-positive-quadrant-equilibria-and-first-integral" >}})
for the five-state worksheet and full cancellation ledger, or the [glossary
chapter]({{< relref
"/knowledge-base/glossary/lotka-volterra-predator-prey-model" >}}) for a
short orientation.
