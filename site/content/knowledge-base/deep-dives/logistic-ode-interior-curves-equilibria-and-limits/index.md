---
title: "Logistic-ODE Interior Curves, Equilibria, and Limits"
slug: "logistic-ode-interior-curves-equilibria-and-limits"
date: 2026-08-09
summary: "A phase-line calculation, Mathlib's sigmoid derivative, and two filter limits build the first checked layer of the normalized logistic ODE."
lead: "Compute one finite sign table, then climb from the vector field to explicit global interior curves without treating a curve family as a flow."
draft: true
pro_reviewed: false
level: "Introductory calculus and ordinary differential equations"
reading_time: "35 to 50 minutes"
prerequisites: "Derivatives, real exponential functions, and equilibrium points are introduced through the worked example"
lean_module: "NonlinearDynamics.Deterministic.Models.LogisticODE"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Models/LogisticODE.lean"
lean_source_sha256: "ab2eaa5b0af808e19e2d21131c00124dede5ef7262fca8bb7fa7b7440180d326"
toc: true
og_image: "logistic-ode-interior-curves-equilibria-and-limits-card.png"
og_image_alt: "A derivative identity connects a phase-shifted sigmoid curve to the normalized logistic vector field between zero and one."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial and validation status.** This is a private AI-assisted working
draft. Professional review and pinned-toolchain validation remain pending;
`pro_reviewed` remains false.
{{< /panel >}}

## Start with five exact states

Consider the normalized {{< refterm "logistic-ordinary-differential-equation"
"logistic ODE" >}}

\[
x'=r x(1-x)
\]

at \(r=2\). Evaluate its {{< refterm "vector-field" "vector field" >}}
at the quarter grid \(x=k/4\):

\[
F_2(k/4)
=2\frac{k}{4}\left(1-\frac{k}{4}\right)
=\frac{k(4-k)}{8}.
\]

| \(k\) | state \(x=k/4\) | scaled value \(8F_2(x)\) | \(F_2(x)\) |
|---:|---:|---:|---:|
| 0 | 0 | 0 | 0 |
| 1 | \(1/4\) | 3 | \(3/8\) |
| 2 | \(1/2\) | 4 | \(1/2\) |
| 3 | \(3/4\) | 3 | \(3/8\) |
| 4 | 1 | 0 | 0 |

The table checks five exact arithmetic cases. The positive middle entries
illustrate that the vector field points toward increasing state inside the
unit interval. The two zero entries exhibit the endpoint equilibria. A finite
grid does not establish the sign for every real state.

The bundled **standalone tutorial** imports only `Std`. It evaluates the whole
five-row scaled table and asks Lean to decide the resulting finite equality.

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/logistic-ode-interior-curves-equilibria-and-limits/logistic-ode-grid.lean
```

Its trust boundary is explicit: `decide` checks the equality of two concrete
lists of natural numbers. It neither quantifies over real \(x\) nor checks an
exponential solution curve.

{{< reference-figure
  wide="true"
  src="vector-field-to-sigmoid.svg"
  alt="Five quarter-grid columns show scaled vector-field values zero, three, four, three, zero. An arrow leads to a smooth sigmoid curve, whose tangent is labeled r times x times one minus x."
  caption="**From cases to a general candidate:** the finite ledger anchors the signs at five states. The source's real-algebra theorem covers the whole open interval, and the derivative theorem checks the displayed sigmoid curve."
>}}

## Classify every equilibrium before dividing

For arbitrary real \(r\) and \(x\),

\[
F_r(x)=0
\iff
r x(1-x)=0.
\]

The zero-product rule gives

\[
r=0
\quad\text{or}\quad
x=0
\quad\text{or}\quad
x=1.
\]

This is the candidate's complete theorem. It retains the degenerate parameter
\(r=0\), where the vector field vanishes everywhere. Only after assuming
\(r\ne0\) may the conclusion be shortened to \(x=0\lor x=1\).

For \(r\gt0\), real sign arithmetic gives the complete phase-line ledger:

\[
F_r(x)
\begin{cases}
\lt0, & x\lt0,\\
\gt0, & 0\lt x\lt1,\\
\lt0, & 1\lt x.
\end{cases}
\]

The source proves the three open-region statements separately. It does not
derive them from a picture.

## Why the sigmoid solves the equation

Mathlib's real sigmoid is

\[
s(u)=\frac{1}{1+e^{-u}}.
\]

Its formal API supplies four facts used here:

- \(0\lt s(u)\lt1\) for every real \(u\).
- Its range is exactly \((0,1)\).
- \(s'(u)=s(u)(1-s(u))\).
- It tends to zero at negative infinity and one at positive infinity.

Choose a growth rate \(r\) and phase \(c\), then define

\[
x_{r,c}(t)=s(rt+c).
\]

The affine inner function has derivative \(r\). The chain rule therefore
gives

\[
\begin{aligned}
x_{r,c}'(t)
&=s'(rt+c)r \\
&=r s(rt+c)(1-s(rt+c)) \\
&=r x_{r,c}(t)(1-x_{r,c}(t)).
\end{aligned}
\]

The candidate theorem `hasDerivAt_logisticInteriorCurve` states this equality
at one arbitrary time. `logisticInteriorCurve_isIntegralCurve` then exposes
the same proof as Mathlib's universally quantified scalar
`IsIntegralCurve` predicate.

{{< reference-figure
  wide="true"
  src="phase-shifts-and-limits.svg"
  alt="Three sigmoid curves with phases negative two, zero, and positive two remain between dashed equilibrium lines zero and one. Horizontal arrows label the negative-infinity limit zero and positive-infinity limit one."
  caption="**Phase changes position, not endpoints:** for positive r, every displayed curve has the same two infinite-time limits. The vertical strip is strict at each finite time; zero and one are approached but not attained by the sigmoid family."
>}}

## Every interior initial state gets a phase

At time zero,

\[
x_{r,c}(0)=s(c).
\]

Because `Real.range_sigmoid` states

\[
s(\mathbb R)=(0,1),
\]

every \(x_0\in(0,1)\) equals \(s(c)\) for at least one real \(c\). The theorem
`exists_logisticInteriorCurve_through` uses that range equality and returns a
phase together with both required facts:

- the curve starts at (x_0); and
- it satisfies the logistic ODE for every real time.

The proof is existential. It does not need to introduce the inverse-logistic
formula \(c=\log(x_0/(1-x_0))\), so there are no extra denominator and
logarithm-domain obligations in this first slice.

The endpoints require different curves. Since a finite sigmoid value is
always strictly interior, the source separately proves that \(t\mapsto0\) and
\(t\mapsto1\) are global integral curves.

## Limits use the sign of the growth rate

Assume \(r\gt0\). Multiplication by \(r\) and addition of \(c\) preserve the two
directions of infinite time:

\[
rt+c\longrightarrow+\infty
\quad(t\to+\infty),
\]

and

\[
rt+c\longrightarrow-\infty
\quad(t\to-\infty).
\]

Composing those filter statements with the sigmoid limits yields

\[
x_{r,c}(t)\longrightarrow1
\quad(t\to+\infty),
\qquad
x_{r,c}(t)\longrightarrow0
\quad(t\to-\infty).
\]

If \(r=0\), the interior curve is constant at \(s(c)\). If \(r\lt0\), the time
orientation reverses. Those cases explain why the formal limit theorems carry
the strict hypothesis `0 < r`.

## Restarting a curve is not yet a state-space flow

The explicit formula satisfies

\[
x_{r,c}(t+s)=x_{r,rs+c}(t).
\]

This theorem says how the phase changes when the time origin changes. It is a
useful restart law for the family. A {{< refterm "flow" "flow" >}} requires a
different type of object:

\[
\phi:\mathbb R\to X\to X,
\]

together with a time-zero law, a state-composition law, and joint continuity
for a specified state space \(X\). The current source deliberately stops
before bundling those obligations. Consequently it also stops before calling
the curve limits a theorem about a {{< refterm "basin-of-attraction"
"basin of attraction" >}} or continuous-time stability.

## In Lean

{{< lean-bridge
  human="The complete zero classification retains the degenerate zero growth rate."
  math="\( F_r(x)=0\iff r=0\lor x=0\lor x=1. \)"
  lean="@[simp] theorem logisticODEVectorField_eq_zero_iff (r x : ℝ) :\n    logisticODEVectorField r x = 0 ↔\n      r = 0 ∨ x = 0 ∨ x = 1"
>}}
`↔` is a two-way implication. The nested `∨` records all three zero factors,
including the parameter factor.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Every phase-shifted sigmoid remains strictly inside the unit interval at every real time."
  math="\( 0 \lt x_{r,c}(t) \lt 1. \)"
  lean="theorem logisticInteriorCurve_mem_Ioo (r c t : ℝ) :\n    logisticInteriorCurve r c t ∈ Set.Ioo 0 1"
>}}
`Set.Ioo 0 1` is the open interval, so both inequalities are strict. The
theorem is pointwise in `t`, but all three arguments are arbitrary.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Every interior initial state lies on a global phase-parameterized integral curve."
  math="\( x_0\in(0,1)\Longrightarrow\exists c,\ x_{r,c}(0)=x_0\text{ and }x_{r,c}'=F_r\circ x_{r,c}. \)"
  lean="theorem exists_logisticInteriorCurve_through {r x : ℝ}\n    (hx : x ∈ Set.Ioo 0 1) :\n    ∃ c : ℝ, logisticInteriorCurve r c 0 = x ∧\n      IsIntegralCurve (logisticInteriorCurve r c)\n        (logisticODEField r)"
>}}
The existential quantifier returns a phase `c`. The conjunction `∧` keeps the
initial-value equation and the global integral-curve proof together.
{{< /lean-bridge >}}

{{< lean-bridge
  human="A time translation changes the phase by r times the shift."
  math="\( x_{r,c}(t+s)=x_{r,rs+c}(t). \)"
  lean="theorem logisticInteriorCurve_add (r c t s : ℝ) :\n    logisticInteriorCurve r c (t + s) =\n      logisticInteriorCurve r (r * s + c) t"
>}}
This is an equality of two real values. It is not a `Flow.map_add` theorem
because the second parameter is a phase rather than a state-space input.
{{< /lean-bridge >}}

## Try the full project module

~~~lean
import NonlinearDynamics.Deterministic.Models.LogisticODE

open Filter Set
open NonlinearDynamics.Deterministic.Models

#check logisticODEVectorField_eq_zero_iff
#check logisticODEVectorField_neg_of_neg
#check logisticInteriorCurve_mem_Ioo
#check hasDerivAt_logisticInteriorCurve
#check exists_logisticInteriorCurve_through
#check logisticODE_zero_isIntegralCurve
#check logisticODE_one_isIntegralCurve
#check tendsto_logisticInteriorCurve_atTop
#check tendsto_logisticInteriorCurve_atBot
#check logisticInteriorCurve_add
~~~

This is a **full project check** on macOS or Linux. It uses the pinned Lean and
Mathlib dependencies and may require substantial disk space or build time.

{{< repo-check >}}
This command checks general real statements and the exact exponential
derivative proof. It is logically different from the bounded `Std` worksheet,
which checks only one five-entry integer list.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/LogisticODE.lean
```

## Misconceptions and limits

- The sign table does not numerically advance the ODE. A vector-field value is
  an instantaneous derivative.
- The formula \(r x(1-x)\) also appears in the discrete logistic map, but the
  two time models are not interchangeable.
- A finite grid illustrates the phase line; the real-algebra proof establishes
  the open-region sign theorems.
- The sigmoid family never reaches either endpoint at finite time. The two
  equilibrium curves must be supplied separately.
- The explicit interior curves do not establish global completeness for every
  initial state in \(\mathbb R\).
- A restart identity for phases is not a bundled flow law on states.
- Curvewise convergence does not, by itself, instantiate the repository's
  flow-level definitions of attraction or stability.

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

See the [glossary chapter]({{< relref
"/knowledge-base/glossary/logistic-ordinary-differential-equation" >}}) for a
shorter orientation, the [Research Note]({{< relref
"/development-notebook/2026/08/logistic-ode-interior-curves-and-equilibria-in-lean"
>}}) for the source-design record, or [stability and attraction for ODE
flows]({{< relref
"/knowledge-base/deep-dives/continuous-time-stability-attraction-and-equilibria"
>}}) for the later flow-level vocabulary.
