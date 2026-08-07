---
title: "Forward stability"
slug: "forward-stability"
summary: "Forward stability means that every sufficiently close initial state remains uniformly close to one reference orbit for all natural-number times."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Discrete.Stability"
tags:
  - "Discrete dynamics"
  - "Stability"
  - "Equicontinuity"
  - "Fixed points"
og_image: "forward-stability-card.png"
og_image_alt: "An initial delta interval feeds a sequence of epsilon neighborhoods centered along a moving reference orbit, with attraction and fixedness separated."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note. Human review
of the mathematics, Lean bridge, figures, accessibility, and references
remains pending. Professional review has not been performed, so
<code>pro_reviewed</code> remains false.
{{< /panel >}}

**Forward stability at a point** means that a small initial change stays small
relative to the chosen reference orbit for every forward time.

Let \(f:X\to X\) be a discrete-time update rule and let \(p\in X\). In a
metric space, \(p\) is forward stable when

\[
\forall\varepsilon\gt0,\quad
\exists\delta\gt0,\quad
d(x,p)\lt\delta\Longrightarrow
d(f^n(x),f^n(p))\lt\varepsilon
\]

for every state \(x\) and every \(n\in\mathbb N\).

The center of the allowed epsilon ball is \(f^n(p)\). It may move with time.
That feature distinguishes stability of a reference orbit from stability of a
fixed point.

## Start with translation

Take \(f(x)=x+5\) on the real line. If \(p=2\) and \(x=2.25\), then

\[
f^n(p)=2+5n,\qquad
f^n(x)=2.25+5n.
\]

Their distance is always \(0.25\). Given any \(\varepsilon\gt0\), choosing
\(\delta=\varepsilon\) works: if \(|x-p|\lt\delta\), then

\[
|f^n(x)-f^n(p)|=|x-p|\lt\varepsilon
\]

for every forward time.

This establishes forward stability for the translation map once the same
identity is proved for arbitrary starts. It also exhibits why the reference
point need not be fixed. If the translation amount is nonzero, then
\(f(p)\ne p\) for every \(p\).

{{< reference-figure
  wide="true"
  src="forward-stability-tube.svg"
  alt="An initial delta interval around p maps to a sequence of epsilon intervals centered at the moving states f to the n of p, and a nearby orbit remains in each interval."
  caption="**Forward stability follows a moving center:** one delta-neighborhood at time zero controls membership in every later epsilon-neighborhood around \(f^n(p)\). The picture represents all-time quantifiers through a repeated pattern; the formal statement quantifies over every natural number."
>}}

## The quantifier order

The order

\[
\forall\varepsilon\;\exists\delta\;\forall x\;\forall n
\]

is part of the definition.

The radius \(\delta\) may depend on the requested tolerance \(\varepsilon\).
It may not depend on \(x\), because every start in the initial ball must work.
It may not depend on \(n\), because one initial radius controls the full
forward orbit.

If one proves only

\[
\forall n\;\forall\varepsilon\;\exists\delta_n,
\]

then each iterate is continuous at \(p\), but the radii may collapse as time
grows. That statement is not forward stability.

Time zero is included. At \(n=0\), both iterates are identities, so the
condition includes \(d(x,p)\lt\varepsilon\). A proof can always reduce its chosen
radius to be at most \(\varepsilon\).

## Equicontinuity

**Equicontinuity at \(p\)** is the topological form of “one neighborhood works
for every function in a family.” Consider the family

\[
F_n=f^n,\qquad n\in\mathbb N.
\]

Equicontinuity of this family at \(p\) is exactly forward stability.

Uniform spaces state this without choosing a numerical metric. An
**entourage** is a set of pairs regarded as uniformly close. For each
entourage \(U\), equicontinuity supplies a neighborhood of \(p\) such that

\[
(f^n(p),f^n(x))\in U
\]

for every \(n\). In a pseudo-metric space, the standard entourages are given by
\(d(a,b)\lt\varepsilon\), recovering the epsilon-delta statement.

## In Lean

The project reuses Mathlib's equicontinuity interface:

{{< lean-bridge
  human="All natural-number iterates of f are equicontinuous together at p."
  math="\(\operatorname{EquicontinuousAt}((f^n)_{n\in\mathbb N},p)\)."
  lean="def IsForwardStableAt [UniformSpace X]\n    (f : X → X) (p : X) : Prop :=\n  EquicontinuousAt (fun n : ℕ ↦ f^[n]) p"
>}}
<code>UniformSpace X</code> supplies uniform closeness and an induced topology.
<code>fun n : ℕ ↦ ...</code> constructs the iterate family.
<code>f^[n]</code> applies the function \(n\) times.
<code>EquicontinuousAt</code> binds one source neighborhood before quantifying
over the family index.
{{< /lean-bridge >}}

The metric bridge is
<code>isForwardStableAt_iff_dist</code>. The theorem
<code>IsForwardStableAt.continuousAt</code> selects the iterate at time one and
deduces continuity of \(f\) at \(p\). The converse is not claimed.

This is a **full project check** using pinned Lean and Mathlib dependencies. It
may require substantial disk space and build time:

~~~sh
git clone https://github.com/tdj28/nonlinear-dynamics-lean.git
cd nonlinear-dynamics-lean/formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Discrete/Stability.lean
~~~

The command is portable across macOS and Linux after the dependencies are
installed. The paired Deep Dive includes a smaller **standalone tutorial**
that imports only <code>Std</code>.

## Fixed-point stability adds a condition

A fixed point satisfies \(f(p)=p\), so its reference orbit never moves. In
that case forward stability becomes

\[
d(x,p)\lt\delta\Longrightarrow d(f^n(x),p)\lt\varepsilon.
\]

The project calls the conjunction a **Lyapunov-stable fixed point**:

\[
f(p)=p
\quad\text{and}\quad
p\text{ is forward stable}.
\]

It does not define forward stability so that fixedness is hidden inside it.
The checked nonzero-translation example is the boundary witness: forward
stability holds, fixedness fails.

{{< reference-figure
  wide="true"
  src="stability-boundary-map.svg"
  alt="A map of concepts shows forward stability combining with fixedness to give a Lyapunov-stable fixed point, while attraction requires a separate decay arrow and perturbation stability compares different maps."
  caption="**Keep the predicates separate:** fixedness is a property of the reference point, attraction adds long-time approach, and perturbation stability compares different update rules. None follows merely from an orbit staying inside an epsilon tube."
>}}

## Nonexpansive maps

A self-map is nonexpansive when

\[
d(f(x),f(y))\le d(x,y).
\]

Repeating the estimate gives

\[
d(f^n(x),f^n(y))\le d(x,y).
\]

Thus every nonexpansive self-map is forward stable at every point. If such a
map has a fixed point, that point is Lyapunov stable. The identity, real
translations, and constant maps provide checked examples in the module.

Nonexpansive is sufficient, not necessary. The definition permits other maps
whose iterates remain equicontinuous at selected points.

## Not attraction or robustness

Forward stability says “remain close.” Attraction says “approach.” The
translation example keeps a constant gap, so it is stable without attracting
the nearby orbit. The {{< refterm "basin-of-attraction" "basin of attraction"
>}} collects starts whose orbits do approach a specified target.

Forward stability also fixes one map \(f\). Structural stability and many
uses of stochastic stability compare different maps, invariant measures, or
random systems. Those questions use different inputs and conclusions.

This glossary entry does not define invariant-set stability, asymptotic or
exponential stability, two-sided-time stability, stable manifolds, or a
Lyapunov-function criterion. The separate {{< refterm "lyapunov-function"
"Lyapunov function" >}} chapter introduces that criterion without changing
the meaning of forward stability.

Continue with the worked [Forward-Orbit and Fixed-Point Stability Deep
Dive]({{< relref
"/knowledge-base/deep-dives/forward-orbit-and-fixed-point-stability-in-discrete-time"
>}}), continue to [Attraction, Basins, and Asymptotic Stability]({{< relref
"/knowledge-base/deep-dives/attraction-basins-and-asymptotic-stability-in-discrete-time"
>}}), continue to [Lyapunov Functions and the Direct Method]({{< relref
"/knowledge-base/deep-dives/lyapunov-functions-and-the-direct-method-in-discrete-time"
>}}), or inspect the declaration-complete [Research Note]({{< relref
"/development-notebook/2026/08/forward-orbit-stability-for-discrete-systems-in-lean"
>}}).

## References

- Ethan Akin, “On Chain Continuity,” *DCDS* 2(1), 111–120 (1996),
  [doi:10.3934/dcds.1996.2.111](https://doi.org/10.3934/dcds.1996.2.111).
- Saber Elaydi and H. R. Farran, “On Variation of Equicontinuity in
  Dynamical Systems,” *Bull. Aust. Math. Soc.* 42(3), 391–397 (1990),
  [doi:10.1017/S0004972700028550](https://doi.org/10.1017/S0004972700028550).
- J. P. LaSalle, *The Stability of Dynamical Systems*, Chapter 1, SIAM
  (1976), [doi:10.1137/1.9781611970432.ch1](https://doi.org/10.1137/1.9781611970432.ch1).
- Mathlib, [uniform-space equicontinuity source](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/UniformSpace/Equicontinuity.lean).
