---
title: "Continuous dependence on initial conditions"
slug: "continuous-dependence-on-initial-conditions"
summary: "Continuous dependence says that nearby initial states have nearby evolved states over the stated time regime; it is stronger than continuity of each trajectory in time."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.ODE.ToFlow"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/ODE/ToFlow.lean"
lean_source_sha256: "01994837eefd5c21d00ff9fcd8f118db9a48d186c2a5333ef65fe9a20072ac16"
og_image: "continuous-dependence-on-initial-conditions-card.png"
og_image_alt: "A glossary card showing a small neighborhood of time-state inputs mapped into a controlled output neighborhood, contrasted with separate time traces."
---

{{< panel "warning" >}}
**Editorial status.** This AI-assisted glossary entry is a public working
draft. Its linked Lean leaf and exact-candidate full repository gate pass with
warnings fatal; `pro_reviewed` remains false.
{{< /panel >}}

For the translation family

\[
\Phi(t,x)=x+ct,
\]

changing the initial point by δ changes the evolved point by exactly δ:

\[
\Phi(t,x+\delta)-\Phi(t,x)=\delta.
\]

Nearby initial states therefore remain equally near at every common time.
This is a particularly strong and concrete form of **continuous dependence on
initial conditions**.

## What the term controls

For a global evolution map Φ, one useful topological formulation is joint
continuity of ((t,x)\mapsto\Phi(t,x)). At a point ((t_0,x_0)), this means
that every output neighborhood of Φ(t_0,x_0) contains the images of all
sufficiently nearby pairs ((t,x)). It controls changes in time and initial
state together.

Exact ODE theorems vary in strength. Some establish dependence only on a
finite time interval, some give local dependence before solutions leave a
chart, and stronger regularity hypotheses may yield differentiable parameter
dependence. The time domain and regularity assumptions must be stated.

{{< reference-figure
  wide="true"
  src="joint-continuity-neighborhoods.svg"
  alt="A small rectangle around one time-state input maps into a small neighborhood around the evolved output. A second panel shows fixed-state time lines that do not control a diagonal approach."
  caption="**Joint control:** one input neighborhood covers simultaneous perturbations of time and state. Checking each fixed-state time line supplies less information because it does not quantify uniformly across nearby initial states."
>}}

## Why time continuity is insufficient

Define (F:\mathbb R^2\to\mathbb R) by

\[
F(t,x)=
\begin{cases}
x+\dfrac{tx}{t^2+x^2},&(t,x)\ne(0,0),\\
0,&(t,x)=(0,0).
\end{cases}
\]

For every fixed (x), the map (t\mapsto F(t,x)) is continuous, including
when (x=0), and (F(0,x)=x). But along (t=x\ne0),

\[
F(x,x)=x+\frac12\longrightarrow\frac12\ne F(0,0).
\]

This explicit diagonal sequence refutes the universal claim that continuity
of every fixed-state time trace implies joint continuity. It is a topology
counterexample, not a claim that (F) is an integral-curve family for a
single vector field.

## In Lean

The ToFlow milestone records exactly the joint-continuity gate needed for its
selected global solution family.

{{< lean-bridge
  human="The time-and-initial-state evaluation map of the selected global curves is jointly continuous."
  math="\(\operatorname{Continuous}[(t,x)\mapsto\gamma_x(t)].\)"
  lean="def HasContinuousGlobalIntegralCurveFamily (h : HasUniqueGlobalIntegralCurves vfield) : Prop := Continuous (Function.uncurry (globalIntegralCurveMap h))"
>}}
`Function.uncurry` converts the time-first function `ℝ → M → M` into one
function on pairs `ℝ × M → M`. The definition deliberately names a
hypothesis; the module does not derive it from continuity of individual
curves.
{{< /lean-bridge >}}

This is a **full project check** on macOS or Linux. It uses pinned Lean and
Mathlib dependencies and may require substantial disk space and build time.

{{< repo-check >}}
The command checks the exact boundary between individual time continuity and
the joint-continuity assumption used to construct a flow.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/ODE/ToFlow.lean
```

## Boundaries

- Joint continuity is not a numerical error estimate or a Lipschitz bound.
- Global continuous dependence should not be inferred from a theorem stated
  only on a local or finite time interval.
- Continuous dependence does not by itself assert differentiable dependence.
- The repository's current ToFlow module assumes this property; it does not
  yet prove it from a vector-field regularity theorem.

## Related trail markers

- [Flow]({{< relref "/knowledge-base/glossary/flow" >}})
- [From Global Integral Curves to Topological Flows]({{< relref "/knowledge-base/deep-dives/from-global-integral-curves-to-topological-flows" >}})

## References

1. John M. Lee, *Introduction to Smooth Manifolds*, second edition, Springer,
   2013, Chapters 8 and 9. [Publisher record](https://doi.org/10.1007/978-1-4419-9982-5).
2. Mathlib contributors,
   [`Mathlib.Dynamics.Flow`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/Flow.lean),
   version 4.32.0.
