---
title: "Logistic-ODE Interior Curves and Equilibria in Lean"
slug: "logistic-ode-interior-curves-and-equilibria-in-lean"
date: 2026-08-09
summary: "The normalized logistic vector field gets an exact equilibrium classification and denominator-safe global curves for every interior initial state."
lead: "Start with the vector-field arrows, use Mathlib's sigmoid as the explicit solution, and keep curvewise convergence separate from a bundled flow theorem."
draft: true
pro_reviewed: false
tags:
  - "Lean"
  - "Continuous dynamics"
  - "Ordinary differential equations"
  - "Logistic equation"
  - "Integral curves"
  - "Equilibria"
lean_module: "NonlinearDynamics.Deterministic.Models.LogisticODE"
lean_source: "formalization/NonlinearDynamics/Deterministic/Models/LogisticODE.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Models/LogisticODE.lean"
lean_source_sha256: "a3b2ff8b54aadd0a0a0c89ef561e8a5e1eecd47f277ac201b2af16cc9413dfcb"
toc: true
og_image: "logistic-ode-interior-curves-and-equilibria-in-lean-card.png"
og_image_alt: "A logistic vector-field sign line sits beside three increasing sigmoid solution curves between equilibrium levels zero and one."
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
`pro_reviewed` remains false. The source interface described below remains a
candidate until that validation is complete.
{{< /panel >}}

## Abstract

The normalized {{< refterm "logistic-ordinary-differential-equation"
"logistic ordinary differential equation" >}} is

\[
x'(t)=r x(t)(1-x(t)).
\]

The carrying capacity is one and the real parameter \(r\) controls the time
scale and direction. This candidate formalizes the vector field

\[
F_r(x)=r x(1-x),
\]

classifies its zeros, proves the sign pattern for \(r\gt0\), and constructs a
global family of interior {{< refterm "integral-curve" "integral curves" >}}

\[
x_{r,c}(t)=\operatorname{sigmoid}(rt+c)
=\frac{1}{1+e^{-(rt+c)}}.
\]

Mathlib already proves that the sigmoid lies strictly between zero and one,
has derivative \(s(1-s)\), and tends to zero and one at the two ends of the
real time axis. The source composes those theorems with the affine clock
\(t\mapsto rt+c\). It does not construct a state-space flow or infer a
flow-level stability theorem.

## Prior work, contribution, and non-claims

**Prior work.** Verhulst's 1845 memoir develops a population-growth law whose
relative growth rate decreases with population and uses the term
"logistique." The present module uses the standard carrying-capacity-one
normalization. Mathlib 4.32.0 supplies both the scalar `IsIntegralCurve`
predicate and a fully developed real sigmoid API.

**Contribution.** The candidate connects that pinned analytic API to the
repository's first concrete continuous-time model. It gives a division-free
equilibrium classification, exact phase-line signs, endpoint constant
solutions, an explicit global solution through every interior state, its two
time limits for positive \(r\), and a restart identity for the phase
parameter.

**Non-claims.** The candidate does not prove global existence through every
real state, does not construct `Flow ℝ ℝ` or a flow on a subtype of
\([0,1]\), and does not feed its curvewise limits into the repository's
Lyapunov-stability or basin-of-attraction predicates. It makes no empirical
population forecast. Normalizing the carrying capacity to one is a modeling
convention, not a claim that every application has that physical scale.

## Begin with the arrows

Take \(r\gt0\). The factors in \(F_r(x)=r x(1-x)\) determine its sign.

| State region | Sign of \(x\) | Sign of \(1-x\) | Sign of \(F_r(x)\) |
|---|---:|---:|---:|
| \(x\lt0\) | negative | positive | negative |
| \(0\lt x\lt1\) | positive | positive | positive |
| \(x\gt1\) | positive | negative | negative |

At \(x=0\) and \(x=1\), the vector field is zero. If \(r\ne0\), these are
the only zeros because a product of three real factors vanishes exactly when
one factor vanishes. At \(r=0\), the whole vector field is zero, so every
state is an equilibrium of the degenerate equation \(x'=0\).

{{< reference-figure
  wide="true"
  src="phase-line-and-curves.svg"
  alt="A phase line marks equilibria zero and one. Arrows point left below zero, right between zero and one, and left above one. Three sigmoid curves remain in the horizontal strip from zero to one."
  caption="**Two related views:** the phase line records the sign of the vector field for positive r. The solution panel shows three phase shifts of the checked interior family. The picture explains the relationship; the Lean theorems establish the displayed sign and derivative statements."
>}}

The arrows are local derivative information. They motivate a trajectory
shape, but the sign diagram alone does not construct a solution or prove a
limit.

## Use a denominator-safe parameterization

Writing an explicit solution directly in terms of an initial state often
introduces a quotient whose denominator needs a domain proof. This candidate
instead chooses a real phase \(c\) and uses Mathlib's sigmoid:

\[
x_{r,c}(t)=\operatorname{sigmoid}(rt+c).
\]

Because the sigmoid's range is exactly \((0,1)\), every real phase produces an
interior state at every time. Conversely, for every \(x_0\in(0,1)\), the
range theorem supplies some phase \(c\) with

\[
x_{r,c}(0)=\operatorname{sigmoid}(c)=x_0.
\]

This existential phase is enough to cover every interior initial state. The
source does not need to choose and simplify a logarithmic inverse formula.

Differentiate with the chain rule. If \(s(u)=\operatorname{sigmoid}(u)\),
Mathlib proves \(s'(u)=s(u)(1-s(u))\). Since the derivative of \(rt+c\) is
\(r\),

\[
\begin{aligned}
x_{r,c}'(t)
&=r\,s(rt+c)(1-s(rt+c)) \\
&=r x_{r,c}(t)(1-x_{r,c}(t)) \\
&=F_r(x_{r,c}(t)).
\end{aligned}
\]

That pointwise derivative identity is precisely Mathlib's scalar
`IsIntegralCurve` obligation for the time-independent field
`logisticODEField r`.

## Endpoints and limits are separate facts

The sigmoid never reaches zero or one at a finite real argument, so the
interior family does not include the endpoint solutions. The source records
them separately as the constant curves \(t\mapsto0\) and \(t\mapsto1\).
Their derivatives and the vector field are both zero.

For \(r\gt0\), the affine clock \(rt+c\) tends to positive infinity as
\(t\to+\infty\) and to negative infinity as \(t\to-\infty\). Composing with
the two sigmoid limit theorems gives

\[
\lim_{t\to-\infty}x_{r,c}(t)=0,
\qquad
\lim_{t\to+\infty}x_{r,c}(t)=1.
\]

These are statements about each member of an explicit curve family. The
repository's `IsAttractedTo` predicate takes a bundled `Flow ℝ X`; the current
module has not supplied one. Reusing the word "attraction" before that bridge
would hide a missing object and its laws.

## The restart identity and the flow boundary

An algebraic time translation gives

\[
\begin{aligned}
x_{r,c}(t+s)
&=\operatorname{sigmoid}(r(t+s)+c) \\
&=\operatorname{sigmoid}(rt+(rs+c)) \\
&=x_{r,rs+c}(t).
\end{aligned}
\]

The source proves this as `logisticInteriorCurve_add`. It updates the phase
after a time shift. A state-space flow law would instead require a map whose
second input is a state, plus time-zero, composition, and joint-continuity
proofs on a specified state space.

{{< reference-figure
  wide="true"
  src="claim-boundary.svg"
  alt="A four-step ladder marks vector field, explicit curve, curve limits, and state-space flow. The first three are checked in the candidate, while the flow box is labeled as a later construction requiring a state space and flow laws."
  caption="**Claim boundary:** a derivative identity checks an integral curve, and limit composition checks its endpoints at infinite time. Neither statement alone constructs a flow or proves the project's flow-level stability predicates."
>}}

The distinction also guards against a whole-real-line overclaim. The familiar
initial-value quotient can have a zero denominator for states outside the
unit interval. The candidate therefore proves global curves through the two
endpoints and every interior state, but does not assert global completeness
through all of \(\mathbb R\).

## In Lean

{{< lean-bridge
  human="The normalized logistic vector field multiplies the growth rate, the state, and one minus the state."
  math="\( F_r(x)=r x(1-x). \)"
  lean="def logisticODEVectorField (r x : ℝ) : ℝ :=\n  r * (x * (1 - x))"
>}}
`r` selects the equation and `x` is the state. The carrying capacity one is
visible in the factor `1 - x`; it is not an implicit unit conversion.
{{< /lean-bridge >}}

{{< lean-bridge
  human="For a nonzero growth rate, the vector field vanishes exactly at zero or one."
  math="\( r\ne0\Longrightarrow(F_r(x)=0\iff x=0\lor x=1). \)"
  lean="theorem logisticODEVectorField_eq_zero_iff_of_ne {r : ℝ}\n    (hr : r ≠ 0) (x : ℝ) :\n    logisticODEVectorField r x = 0 ↔ x = 0 ∨ x = 1"
>}}
The hypothesis `hr` removes the degenerate zero-rate case. The symbol `∨`
is logical "or," so the conclusion lists both endpoint zeros.
{{< /lean-bridge >}}

{{< lean-bridge
  human="The phase-shifted sigmoid is an integral curve of the autonomous logistic field for every real growth rate and phase."
  math="\( x_{r,c}'(t)=F_r(x_{r,c}(t))\text{ for all }t\in\mathbb R. \)"
  lean="theorem logisticInteriorCurve_isIntegralCurve (r c : ℝ) :\n    IsIntegralCurve (logisticInteriorCurve r c)\n      (logisticODEField r)"
>}}
`IsIntegralCurve` quantifies over every real time. The field is written with a
time argument because Mathlib's scalar ODE interface also supports
time-dependent vector fields; `logisticODEField` ignores that argument.
{{< /lean-bridge >}}

{{< lean-bridge
  human="At positive growth rate, each checked interior curve tends to one at positive infinite time."
  math="\( r>0\Longrightarrow\lim_{t\to+\infty}x_{r,c}(t)=1. \)"
  lean="theorem tendsto_logisticInteriorCurve_atTop {r : ℝ}\n    (hr : 0 < r) (c : ℝ) :\n    Filter.Tendsto (logisticInteriorCurve r c)\n      Filter.atTop (nhds 1)"
>}}
`Filter.atTop` expresses real time tending without an integer sampling grid.
`nhds 1` is the neighborhood filter that encodes convergence to one.
{{< /lean-bridge >}}

## Reproduce the candidate checks

~~~lean
import NonlinearDynamics.Deterministic.Models.LogisticODE

open Set
open NonlinearDynamics.Deterministic.Models

#check logisticODEVectorField_eq_zero_iff
#check logisticODEVectorField_pos
#check logisticInteriorCurve_isIntegralCurve
#check exists_logisticInteriorCurve_through
#check tendsto_logisticInteriorCurve_atTop
#check logisticInteriorCurve_add
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
The command asks Lean to elaborate the whole source module with warnings
treated as errors. Lean's kernel checks proof terms against the formal
statements. This does not independently certify that the normalization models
a particular population or that the chosen statements exhaust the
mathematics of the logistic equation.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/LogisticODE.lean
```

The first candidate contains the following declaration groups:

- `logisticODEVectorField`, `logisticODEField`, and
  `logisticODEField_apply` define the autonomous scalar field.
- `logisticODEVectorField_zero`, `logisticODEVectorField_one`, and
  `continuous_logisticODEVectorField` record its endpoints and continuity.
- `logisticODEVectorField_eq_zero_iff` preserves the \(r=0\) case, while
  `logisticODEVectorField_eq_zero_iff_of_ne` classifies the nondegenerate
  equilibria.
- `logisticODEVectorField_pos`, `logisticODEVectorField_neg_of_neg`, and
  `logisticODEVectorField_neg_of_one_lt` establish the positive-rate sign
  ledger.
- `logisticInteriorCurve`, `logisticInteriorCurve_eq_inv`,
  `logisticInteriorCurve_zero`, and `logisticInteriorCurve_mem_Ioo` define the
  explicit family and its range.
- `hasDerivAt_logisticInteriorCurve` checks the differential equation, and
  `logisticInteriorCurve_isIntegralCurve` packages it with Mathlib's scalar
  ODE predicate.
- `exists_logisticInteriorCurve_through` covers every interior initial state;
  `logisticODE_zero_isIntegralCurve` and
  `logisticODE_one_isIntegralCurve` handle the endpoints.
- `tendsto_logisticInteriorCurve_atTop` and
  `tendsto_logisticInteriorCurve_atBot` prove the positive-rate limits.
- `logisticInteriorCurve_add` records the exact phase update under time
  translation.

## Discussion

The sigmoid parameterization makes the strongest part of this slice almost
taut: Mathlib already knows the needed range, derivative, and limit theorems.
The new work is to state the model convention and compose those facts without
changing their logical level.

That choice also postpones a genuinely separate construction. A future module
may put the closed unit interval into a state type, define the time maps there,
and prove the flow laws and continuity needed by the repository's ODE
stability interfaces. The present restart theorem is useful input, but it is
not relabeled as that endpoint.

The source is still an unvalidated candidate. Until the pinned project check
passes, the prose above describes intended theorem statements rather than a
validated formal milestone.

## References

- P.-F. Verhulst, “Recherches mathématiques sur la loi d’accroissement de la
  population,” *Nouveaux mémoires de l'Académie royale des sciences et
  belles-lettres de Bruxelles* 18, 1–40 (1845).
  [DOI 10.3406/marb.1845.3438](https://doi.org/10.3406/marb.1845.3438).
- Mathlib contributors,
  [`Analysis.SpecialFunctions.Sigmoid`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/SpecialFunctions/Sigmoid.lean),
  [`Analysis.ODE.Basic`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/ODE/Basic.lean),
  and
  [`Order.Filter.AtTopBot.Field`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Order/Filter/AtTopBot/Field.lean),
  pinned revision `81a5d257` used by Mathlib 4.32.0.
- Repository source,
  [`LogisticODE.lean`](/lean/NonlinearDynamics/Deterministic/Models/LogisticODE.lean),
  candidate SHA-256
  `a3b2ff8b54aadd0a0a0c89ef561e8a5e1eecd47f277ac201b2af16cc9413dfcb`.

Continue with the [Logistic ODE Deep Dive]({{< relref
"/knowledge-base/deep-dives/logistic-ode-interior-curves-equilibria-and-limits"
>}}), or compare the discrete-time [logistic map]({{< relref
"/knowledge-base/glossary/logistic-map" >}}). The two models use the same
quadratic expression but a different rule for advancing time.
