---
title: "Lotka-Volterra: Positive Quadrant, Equilibria, and First Integral"
slug: "lotka-volterra-positive-quadrant-equilibria-and-first-integral"
date: 2026-08-11
summary: "Five exact normalized states lead to the four-parameter predator-prey field, its two positive-parameter equilibria, and the local logarithmic cancellation."
lead: "Compute a bounded state ledger first, then separate field geometry, logarithmic domain, and orbit-level claims."
draft: true
pro_reviewed: false
level: "Introductory calculus and ordinary differential equations"
reading_time: "30 to 45 minutes"
prerequisites: "Ordered pairs, derivatives, logarithms, and vector fields are introduced through the worked example"
lean_module: "NonlinearDynamics.Deterministic.Models.LotkaVolterra"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Models/LotkaVolterra.lean"
lean_source_sha256: "21205e54129b8ca0f026a3042c674e48a7b00f6c816644f0181fd827116904c6"
toc: true
og_image: "lotka-volterra-positive-quadrant-equilibria-and-first-integral-card.png"
og_image_alt: "Five normalized prey-predator states show two equilibria, two axis vectors, and the benchmark vector minus four comma three."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this note. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary
  sources and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial and validation status.** This is an AI-assisted working draft.
Professional review remains pending, so `pro_reviewed` remains false.

**Status correction, 2026-09-04.** The linked Lean source snapshot
has passed warning-fatal pinned-toolchain validation and the complete
repository gate. The earlier pending-validation label was stale.
{{< /panel >}}

## Start with five exact states

Use the normalized {{< refterm "lotka-volterra-predator-prey-model"
"Lotka-Volterra predator-prey model" >}}

\[
x'=x(1-y),
\qquad
y'=y(x-1).
\]

The first coordinate \(x\) is prey and the second \(y\) is predator. Evaluate
the field at five integer states:

| State \((x,y)\) | Prey derivative \(x(1-y)\) | Predator derivative \(y(x-1)\) | Field value |
|---|---:|---:|---|
| \((0,0)\) | \(0\) | \(0\) | \((0,0)\) |
| \((1,1)\) | \(0\) | \(0\) | \((0,0)\) |
| \((2,1)\) | \(0\) | \(1\) | \((0,1)\) |
| \((1,2)\) | \(-1\) | \(0\) | \((-1,0)\) |
| \((2,3)\) | \(-4\) | \(3\) | \((-4,3)\) |

The first two rows are equilibria for this parameter choice. The next two
isolate one zero per-capita factor. The last row shows simultaneous prey
decrease and predator increase. These are exact instantaneous derivatives,
not finite time steps.

{{< reference-figure
  wide="true"
  src="five-state-ledger.svg"
  alt="Five normalized prey-predator states map respectively to vectors zero zero, zero zero, zero one, minus one zero, and minus four three."
  caption="**A finite anchor:** the two field zeros, the two one-factor rows, and the off-nullcline benchmark are all exact. This complete five-row worksheet checks only the stored states, not every point of the plane."
>}}

The bundled **standalone tutorial** imports only `Std`. It computes all five
integer vectors and a second five-entry algebraic cancellation ledger.

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/lotka-volterra-positive-quadrant-equilibria-and-first-integral/lotka-volterra-ledger.lean
```

Its trust boundary is finite. `decide` checks integer arithmetic on the two
stored five-entry lists. The worksheet does not define the real logarithm,
take a derivative, quantify over arbitrary parameters or states, construct a
solution, or establish a general first-integral theorem.

## Recover the four-parameter field

Lotka's 1920 article writes the prey or plant equation in the factored form
\(X_1(A_1-B_1X_2)\) and the consumer equation as
\(X_2(A_2X_1-B_2)\). This chapter uses the conversion

\[
(A_1,B_1,B_2,A_2)
\longmapsto
(\alpha,\beta,\gamma,\delta)
\]

and keeps prey first:

\[
F_{\alpha,\beta,\gamma,\delta}(x,y)
=\bigl(x(\alpha-\beta y),
       y(\delta x-\gamma)\bigr).
\]

For the usual predator-prey interpretation, all four parameters are positive:
\(\alpha\) is uncoupled prey growth, \(\beta\) is prey loss per prey-predator
interaction, \(\gamma\) is uncoupled predator mortality, and \(\delta\) is
predator gain per interaction in the chosen units. This interpretation is a
modeling convention. The Lean function itself accepts arbitrary real
parameters so that degenerate algebraic cases remain visible.

The field is polynomial and therefore continuous on the full plane. The full
plane is a mathematical carrier, not a claim that negative populations are
biologically meaningful.

## Read the axes without claiming invariance

If predators are absent, \(y=0\), then

\[
F(x,0)=(\alpha x,0).
\]

If prey are absent, \(x=0\), then

\[
F(0,y)=(0,-\gamma y).
\]

In each equation the missing coordinate has derivative zero. This shows that
the vector field is tangent to that axis. A theorem saying that a solution
starting on an axis remains there requires a solution and a uniqueness or
invariance argument. The current module deliberately does not infer that
dynamic statement from the field-value identity alone.

The same distinction applies to the strict positive quadrant

\[
Q_{++}=\{(x,y)\in\mathbb R^2:x\gt0\text{ and }y\gt0\}.
\]

`lotkaVolterraPositiveQuadrant` names this set, and
`mem_lotkaVolterraPositiveQuadrant` unpacks membership. Neither declaration
says that an integral curve stays in the set.

## Find every field zero for positive parameters

An equilibrium is a state where both field coordinates vanish:

\[
x(\alpha-\beta y)=0,
\qquad
y(\delta x-\gamma)=0.
\]

The origin always works. Assume now that
\(\alpha,\beta,\gamma,\delta\gt0\).

If \(x=0\), the second equation becomes \(-\gamma y=0\), and positivity of
\(\gamma\) gives \(y=0\). Otherwise, the first equation gives
\(y=\alpha/\beta\). This is positive, so \(y\ne0\), and the second equation
gives \(x=\gamma/\delta\). Thus the complete list is

\[
(0,0),
\qquad
p_*=\left(\frac{\gamma}{\delta},
          \frac{\alpha}{\beta}\right).
\]

Positive numerators and denominators place \(p_*\) in \(Q_{++}\). The theorem
`lotkaVolterraVectorField_eq_zero_iff_of_pos` proves both directions of the
classification. `lotkaVolterraCoexistence_mem_positiveQuadrant` proves the
separate domain statement.

The word “coexistence” names the algebraic state where both coordinates are
positive. It does not claim stability, persistence under perturbation, or
empirical coexistence in an ecosystem.

## Derive the first-integral cancellation

On positive states define

\[
H(x,y)=\delta x-\gamma\log x+\beta y-\alpha\log y.
\]

Suppose positive differentiable component curves satisfy the two ODE values at
one time \(t\). Differentiate term by term:

\[
\frac{dH}{dt}
=\delta x'-\gamma\frac{x'}{x}
 +\beta y'-\alpha\frac{y'}{y}.
\]

Substitute \(x'=x(\alpha-\beta y)\) and
\(y'=y(\delta x-\gamma)\):

\[
\begin{aligned}
\frac{dH}{dt}
&=\delta x(\alpha-\beta y)
  -\gamma(\alpha-\beta y)\\
&\quad+\beta y(\delta x-\gamma)
  -\alpha(\delta x-\gamma)\\
&=\delta\alpha x-\delta\beta xy-\gamma\alpha+\gamma\beta y\\
&\quad+\beta\delta xy-\beta\gamma y-\alpha\delta x+\alpha\gamma\\
&=0.
\end{aligned}
\]

Every term cancels with one equal term of opposite sign. The divisions by
\(x\) and \(y\) were valid because the theorem assumed both component values
strictly positive.

The standalone worksheet checks the division-cleared normalized identity

\[
(x-1)(1-y)+(y-1)(x-1)=0
\]

on its five stored states. That finite integer computation illustrates the
same cancellation pattern. The project theorem uses Mathlib's real logarithm
chain rule and establishes the general pointwise statement.

{{< reference-figure
  wide="true"
  src="log-cancellation-and-boundary.svg"
  alt="Four derivative groups cancel in pairs inside the strictly positive quadrant, while a boundary separates this pointwise identity from positive invariance, closed orbits, periodicity, flow, and stability."
  caption="**Cancellation with a visible domain:** positive coordinates justify both logarithmic derivatives. Pairwise algebra yields zero at the chosen time. The lower boundary lists orbit-level conclusions that are not supplied by this calculation."
>}}

## Why a conserved scalar is not yet a periodic orbit

If a differentiable solution remains positive and the derivative identity
holds throughout an interval, a separate zero-derivative theorem can show that
\(H\) is constant on that interval. Even that constancy statement does not by
itself prove that the corresponding level set is a compact regular curve, that
the solution exists for all time, or that it traverses the whole component
periodically.

The historical Lotka and Volterra analyses discuss oscillations and positive
quadrant trajectories. This first formal slice does not import those complete
arguments. It records only the ingredients already checked in its source:
field algebra, equilibrium classification, a positive-domain derivative
cancellation, and two constant integral curves.

## In Lean

{{< lean-bridge
  human="With all four parameters equal to one, state two comma three has field vector minus four comma three."
  math="\(F_{1,1,1,1}(2,3)=(-4,3).\)"
  lean="theorem lotkaVolterraVectorField_normalized_benchmark :\n    lotkaVolterraVectorField 1 1 1 1 (2, 3) = (-4, 3)"
>}}
The numerals are exact real numbers after Lean infers the field's type. The
returned pair uses prey derivative first and predator derivative second.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Positive parameters place the coexistence state in the strict positive quadrant."
  math="\(\alpha,\beta,\gamma,\delta\gt0\Longrightarrow(\gamma/\delta,\alpha/\beta)\in Q_{++}.\)"
  lean="theorem lotkaVolterraCoexistence_mem_positiveQuadrant\n    {alpha beta gamma delta : ℝ}\n    (hAlpha : 0 < alpha) (hBeta : 0 < beta)\n    (hGamma : 0 < gamma) (hDelta : 0 < delta) :\n    lotkaVolterraCoexistence alpha beta gamma delta ∈\n      lotkaVolterraPositiveQuadrant"
>}}
Each named hypothesis is used in one numerator or denominator sign argument.
The conclusion is set membership, not invariance under time evolution.
{{< /lean-bridge >}}

{{< lean-bridge
  human="The normalized coexistence state has first-integral value two."
  math="\(H_{1,1,1,1}(1,1)=2.\)"
  lean="theorem lotkaVolterraFirstIntegral_normalized_coexistence :\n    lotkaVolterraFirstIntegral 1 1 1 1 (1, 1) = 2"
>}}
Mathlib reduces both occurrences of `Real.log 1` to zero. This exact value is
a scalar benchmark, not an orbit classification.
{{< /lean-bridge >}}

{{< lean-bridge
  human="The constant coexistence-state curve is a global integral curve when its two denominators are nonzero."
  math="\(\beta\ne0\land\delta\ne0\Longrightarrow\gamma(t)=p_*\text{ satisfies }\gamma'=F\circ\gamma.\)"
  lean="theorem lotkaVolterra_coexistence_isIntegralCurve\n    {alpha beta gamma delta : ℝ}\n    (hBeta : beta ≠ 0) (hDelta : delta ≠ 0) :\n    IsIntegralCurve\n      (fun _ : ℝ ↦ lotkaVolterraCoexistence alpha beta gamma delta)\n      (lotkaVolterraODEField alpha beta gamma delta)"
>}}
The ignored time argument makes the curve constant. `IsIntegralCurve`
quantifies over all real times, but only for this explicitly constructed
equilibrium curve.
{{< /lean-bridge >}}

## Try the full project module

~~~lean
import NonlinearDynamics.Deterministic.Models.LotkaVolterra

open NonlinearDynamics.Deterministic.Models

#check mem_lotkaVolterraPositiveQuadrant
#check lotkaVolterraCoexistence_mem_positiveQuadrant
#check continuous_lotkaVolterraVectorField
#check lotkaVolterraVectorField_predator_free
#check lotkaVolterraVectorField_prey_free
#check lotkaVolterraVectorField_eq_zero_iff_of_pos
#check lotkaVolterraVectorField_normalized_benchmark
#check lotkaVolterraFirstIntegral_normalized_coexistence
#check hasDerivAt_lotkaVolterraFirstIntegral_along
#check lotkaVolterra_origin_isIntegralCurve
#check lotkaVolterra_coexistence_isIntegralCurve
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies and may require substantial disk space or
build time.

{{< repo-check >}}
The full module asks Lean to check general theorems over real parameters,
states, and differentiable component curves. It is logically different from
the bounded `Std` worksheet, which checks two finite integer ledgers.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Models/LotkaVolterra.lean
```

## Misconceptions and limits

- A field vector is an instantaneous derivative, not a one-step update.
- The full-plane carrier does not make negative coordinates biological
  population states.
- Axis tangency does not establish forward invariance without a solution and
  an appropriate uniqueness or invariance argument.
- The strict positive quadrant is named, but its forward invariance is not
  proved.
- `Real.log` is totalized in Lean. The derivative theorem still requires
  positive component values and makes no axis conservation claim.
- A zero derivative under ODE hypotheses does not construct a solution.
- A conserved scalar does not by itself establish compact level sets,
  nonconstant closed orbits, periodicity, or a period formula.
- The coexistence equilibrium is not proved stable, unstable, attracting, or
  persistent under perturbation.
- The module contains no carrying capacity, predator saturation, delay,
  harvesting, seasonality, demographic noise, or environmental noise.

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

See the [glossary chapter]({{< relref
"/knowledge-base/glossary/lotka-volterra-predator-prey-model" >}}) for a
short orientation or the [Research Note]({{< relref
"/development-notebook/2026/08/lotka-volterra-vector-field-and-first-integral-in-lean" >}})
for the complete declaration and design ledger.
