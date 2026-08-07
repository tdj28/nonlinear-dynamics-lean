---
title: "Attraction and Basins for Discrete Systems in Lean"
slug: "attraction-and-basins-for-discrete-systems-in-lean"
date: 2026-08-06
weight: -74
author: "tdj28"
summary: "A discrete-time attraction interface separates orbit convergence, point and set basins, local and global attraction, and asymptotic stability."
lead: |
  Stability asks whether nearby trajectories stay nearby. Attraction asks whether a trajectory approaches a target as time tends to infinity. This milestone gives those questions separate Lean predicates, joins them only in asymptotic stability, and makes the empty-set distance boundary explicit.
key_result: |
  The point basin is the set of starts whose natural-number iterates converge to one target. A locally attracting fixed point has that basin as a neighborhood. For a nonempty invariant set, the corresponding distance-to-set basin is also defined, and the singleton theorem connects the two interfaces exactly.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Intermediate topology, metric spaces, filters, function iteration, and Lean 4"
reading_time: "45 to 65 minutes"
prerequisites:
  - "Orbit and iterate"
  - "Forward stability"
  - "Limits and neighborhoods"
lean_module: "NonlinearDynamics.Deterministic.Discrete.Attraction"
lean_source: "formalization/NonlinearDynamics/Deterministic/Discrete/Attraction.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Discrete/Attraction.lean"
lean_source_sha256: "b457f16d9ebf151337b65f8e429e6957a222a0f86b562e1bc52ace6e6fb939ad"
tags:
  - "Lean 4"
  - "Discrete dynamics"
  - "Attraction"
  - "Basins"
  - "Asymptotic stability"
  - "Fixed points"
og_image: "attraction-and-basins-for-discrete-systems-in-lean-card.png"
og_image_alt: "Three orbit paths enter a fixed target neighborhood, with basin membership, fixedness, and asymptotic stability labeled separately."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the scope, approved the formal-check
workflow, and remains responsible for the statements, sources, and released
artifacts. This is an independent, non-peer-reviewed Research Note.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This is a public working note. Human editorial and
expert review remain pending. The configured professional review has not been
performed, and `pro_reviewed` remains false.
{{< /panel >}}

## A finite basin before the topology

Consider three states with the update rule


| current state | next state |
|---|---|
| low | low |
| middle | low |
| high | middle |

Starting at `high` gives



\[
\text{high},\ \text{middle},\ \text{low},\ \text{low},\ldots
\]

Every start reaches `low` by time two and remains there. The basin of `low` is
therefore the whole three-state space. The first two iterates differ across
starts; attraction is a statement about the eventual tail, not equality of
finite prefixes.

{{< reference-figure
  wide="true"
  src="orbit-convergence.svg"
  alt="Rows starting at low, middle, and high all reach low by time two and remain there."
  caption="**A finite basin:** all three starts eventually have the constant low tail. This exhaustive three-state calculation establishes basin membership for this finite model; it is not a proof about arbitrary dynamical systems."
>}}

The bundled standalone tutorial encodes this exact state machine and proves
the three cases exhaustively using Lean and `Std`.

## Point attraction and its basin

For a self-map \(f:X\to X\), the orbit from \(x\) is attracted to \(p\) when

\[
f^n(x)\longrightarrow p\qquad(n\to\infty).
\]

The definition uses the natural-number `atTop` filter and the neighborhood
filter of \(p\):

```lean
def IsAttractedTo [TopologicalSpace X]
    (f : X → X) (x p : X) : Prop :=
  Tendsto (fun n : ℕ ↦ f^[n] x) atTop (𝓝 p)
```

`IsAttractedTo` deliberately does not require \(f(p)=p\). If the map is
continuous at \(p\) in a Hausdorff space, convergence of the shifted orbit
forces fixedness; the theorem
`IsAttractedTo.isFixedPt_of_continuousAt` records exactly those gates.

The point basin is

\[
B_f(p)=\{x\in X:f^n(x)\to p\}.
\]

```lean
def basinOfAttraction [TopologicalSpace X]
    (f : X → X) (p : X) : Set X :=
  {x | IsAttractedTo f x p}
```

{{< lean-bridge
  human="The forward orbit from x converges to p."
  math="\(f^n(x)\to p\) as \(n\to\infty\)."
  lean="IsAttractedTo f x p :=\n  Tendsto (fun n : ℕ ↦ f^[n] x) atTop (𝓝 p)"
>}}
`f^[n] x` is the state after `n` updates. `atTop` sends the natural-number
index toward arbitrarily large times. `𝓝 p` is the filter of neighborhoods of
the target. `Tendsto` says every target neighborhood contains all sufficiently
late iterates.
{{< /lean-bridge >}}

In a pseudo-metric space, `isAttractedTo_iff_dist` gives the equivalent scalar
statement

\[
d(f^n(x),p)\longrightarrow 0.
\]

## Local, global, and asymptotic

A locally attracting fixed point satisfies two conditions:

1. \(f(p)=p\);
2. \(B_f(p)\) is a neighborhood of \(p\).

The second condition means that some whole neighborhood of initial states
converges to \(p\). It is stronger than the tautological fact that a fixed
point's own constant orbit converges to itself.

Global attraction replaces the neighborhood condition with
\(B_f(p)=X\), expressed by quantifying over every start.

Asymptotic stability keeps the earlier stability predicate separate:

\[
\text{asymptotically stable}
\quad\Longleftrightarrow\quad
\text{Lyapunov stable and locally attracting}.
\]

{{< reference-figure
  wide="true"
  src="interface-layers.svg"
  alt="Orbit convergence defines a basin; fixedness and a basin neighborhood give local attraction; adding Lyapunov stability gives asymptotic stability; set attraction uses distance to a nonempty set."
  caption="**Separate obligations:** convergence does not mean that nearby trajectories stayed uniformly close during the transient. Asymptotic stability records both the all-time stability requirement and the long-time attraction requirement."
>}}

The theorem `isAsymptoticallyStableFixedPoint_iff` checks the displayed
decomposition against the definitions.

## Contraction supplies both halves

Mathlib defines `ContractingWith K f` as a Lipschitz estimate with (K<1).
On a nonempty complete metric space, its Banach fixed-point theorem
constructs `ContractingWith.fixedPoint f hf` and proves that every orbit
converges to it.

The project packages that result twice:

- `isGloballyAttractingFixedPoint_fixedPoint` records global attraction;
- `isAsymptoticallyStableFixedPoint_fixedPoint` combines global attraction
  with the prior nonexpansive stability theorem.

The stability proof weakens (K<1) to a Lipschitz constant at most one. The
attraction proof uses Mathlib's convergence theorem. No new Banach fixed-point
argument is reimplemented here.

## Nonempty set targets

For a set \(A\subseteq X\), the selected orbit-level statement is

\[
A\ne\varnothing
\quad\text{and}\quad
\operatorname{dist}(f^n(x),A)\longrightarrow0.
\]

Nonemptiness is part of `IsAttractedToSet`. This is not cosmetic: Mathlib
defines `Metric.infDist x ∅ = 0`. Without the explicit gate, every orbit would
be attracted to the empty set by totalization.

A locally attracting set is nonempty, forward invariant, and has a set basin
that is a neighborhood of each target point. Forward invariance means
\(f(A)\subseteq A\); equality invariance is not claimed.

The set interface is pointwise in its initial condition. It does not assert
uniform attraction of all bounded subsets, Hausdorff convergence, or
compactness. Those stronger forms need additional definitions and hypotheses.

For \(A=\{p\}\), Mathlib's `Metric.infDist_singleton` rewrites the set distance
to (d(\cdot,p)). The source proves:

- `isAttractedToSet_singleton_iff`;
- `basinOfAttractionSet_singleton`;
- `isLocallyAttractingSet_singleton_iff`.

These theorems make the point and set APIs meet without treating a general set
as if it selected one limiting point.

## Declaration-complete source map

The source introduces the following public declarations:

| Declaration | Role |
|---|---|
| `IsAttractedTo` | orbit convergence to one point |
| `basinOfAttraction` | point basin |
| `IsLocallyAttractingFixedPoint` | fixedness plus basin neighborhood |
| `IsGloballyAttractingFixedPoint` | fixedness plus attraction from every start |
| `IsAsymptoticallyStableFixedPoint` | Lyapunov stability plus local attraction |
| `mem_basinOfAttraction` | point-basin membership unfolding |
| `isAttractedTo_iff_dist` | point attraction as distance convergence |
| `IsFixedPt.isAttractedTo` | a fixed point attracts its own orbit |
| `IsAttractedTo.isFixedPt_of_continuousAt` | continuity-gated fixedness consequence |
| `IsGloballyAttractingFixedPoint.isLocallyAttractingFixedPoint` | global-to-local bridge |
| `isAsymptoticallyStableFixedPoint_iff` | stability-attraction decomposition |
| `isGloballyAttractingFixedPoint_fixedPoint` | contraction gives global attraction |
| `isAsymptoticallyStableFixedPoint_fixedPoint` | contraction gives both halves |
| `isGloballyAttractingFixedPoint_const` | constant-map example |
| `IsAttractedToSet` | nonempty distance-to-set convergence |
| `basinOfAttractionSet` | set basin |
| `IsLocallyAttractingSet` | nonempty forward-invariant local target |
| `mem_basinOfAttractionSet` | set-basin membership unfolding |
| `isAttractedToSet_singleton_iff` | point/set orbit bridge |
| `basinOfAttractionSet_singleton` | point/set basin bridge |
| `isLocallyAttractingSet_singleton_iff` | point/set local bridge |

Six `#print axioms` commands audit the main bridges and contraction endpoints.
The formal gate must show no `sorryAx` before this milestone is called green.

## Reproduce the checks

The finite state machine is a **standalone tutorial** importing only `Std`:

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/attraction-basins-and-asymptotic-stability-in-discrete-time/finite-basin.lean
```

The exact source is a **full project check** using the pinned Lean and Mathlib
dependencies:

```sh
git clone https://github.com/tdj28/nonlinear-dynamics-lean.git
cd nonlinear-dynamics-lean/formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Discrete/Attraction.lean
```

`lake env lean` selects the pinned project environment, and
`-DwarningAsError=true` rejects warnings. The command is portable across macOS
and Linux after the project dependencies are installed.

Lean's elaborator constructs proof terms and its kernel checks them against
the formal statements. That check does not by itself establish that the
chosen definitions match every convention called an attractor in the
literature; the scope decisions and references still require mathematical
review.

## What this milestone does not claim

It proves no convergence rate beyond the imported contraction theorem, no
uniform attraction of sets of initial conditions, no compact global attractor,
no Hausdorff convergence, no invariant-set Lyapunov stability, no periodic
orbit interface, no robustness under perturbation, and no stable-manifold
theorem.

The next [Lyapunov Functions Research Note]({{< relref
"/development-notebook/2026/08/lyapunov-functions-for-discrete-systems-in-lean"
>}}) explains how scalar sublevels can supply the separate stability and
attraction obligations without identifying weak descent with convergence.

## References

- J. P. LaSalle, “Difference Equations. Discrete Semidynamical Systems,”
  Chapter 1 of *The Stability of Dynamical Systems*, SIAM CBMS 25 (1976),
  pages 1–25, [DOI 10.1137/1.9781611970432.ch1](https://doi.org/10.1137/1.9781611970432.ch1).
- Jack K. Hale, *Asymptotic Behavior of Dissipative Systems*, AMS
  Mathematical Surveys and Monographs 25 (1988), especially Chapter 2 on
  discrete dynamical systems,
  [DOI 10.1090/surv/025](https://doi.org/10.1090/surv/025).
- Mathlib 4.32.0, pinned revision `81a5d257`,
  `Topology.MetricSpace.Contracting`,
  `Topology.MetricSpace.HausdorffDistance`, and
  `Dynamics.FixedPoints.Topology`.
