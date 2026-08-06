---
title: "Attraction, Basins, and Asymptotic Stability in Discrete Time"
slug: "attraction-basins-and-asymptotic-stability-in-discrete-time"
summary: "Start with a finite state basin, then separate convergence to a target, basin neighborhoods, Lyapunov stability, and distance-to-set attraction."
lead: "An orbit may wander before it converges, and convergence alone does not control its transient error. Basins describe where convergence begins; asymptotic stability adds the separate requirement that nearby orbits stay close throughout the transient."
draft: false
pro_reviewed: false
toc: true
level: "Intermediate"
reading_time: "35 to 50 minutes"
prerequisites:
  - "Orbit and iterate"
  - "Forward stability"
  - "Metric limits"
lean_module: "NonlinearDynamics.Deterministic.Discrete.Attraction"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Discrete/Attraction.lean"
lean_source_sha256: "b457f16d9ebf151337b65f8e429e6957a222a0f86b562e1bc52ace6e6fb939ad"
tags:
  - "Discrete dynamics"
  - "Attraction"
  - "Basins"
  - "Asymptotic stability"
  - "Lean 4"
og_image: "attraction-basins-and-asymptotic-stability-card.png"
og_image_alt: "A basin encloses a target neighborhood with orbits converging to a fixed point, beside the formula Lyapunov stable plus locally attracting."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this Deep Dive. The author selected the questions and remains
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary sources
  and released Lean source before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note. Human review
of its mathematics, Lean examples, figures, accessibility, and references is
pending. Professional review has not been performed, so
<code>pro_reviewed</code> remains false.
{{< /panel >}}

## Start with three states

Let the state space be `low`, `middle`, and `high`, with

\[
\text{high}\mapsto\text{middle},\qquad
\text{middle}\mapsto\text{low},\qquad
\text{low}\mapsto\text{low}.
\]

The orbit from `high` reaches `low` after two updates. The orbit from
`middle` reaches it after one, and the orbit from `low` is already constant.
All three states therefore lie in the basin of the fixed point `low`.

This finite example is stronger than a sample calculation because the three
constructors exhaust the state type. It establishes the stated basin for this
model, not for arbitrary maps.

## Convergence defines the point basin

For a map \(f:X\to X\), define

\[
B_f(p)=\{x\in X:f^n(x)\to p\}.
\]

Membership is about the complete limiting tail. Visiting a neighborhood once
does not suffice, and reaching \(p\) at one time does not suffice unless later
iterates remain appropriately close.

{{< lean-bridge
  human="The orbit beginning at x converges to the target p."
  math="\(f^n(x)\to p\) as \(n\to\infty\)."
  lean="def IsAttractedTo [TopologicalSpace X]\n    (f : X → X) (x p : X) : Prop :=\n  Tendsto (fun n : ℕ ↦ f^[n] x) atTop (𝓝 p)"
>}}
`f^[n]` is the `n`-fold function iterate. `atTop` represents arbitrarily late
natural-number times. `𝓝 p` contains the neighborhoods of `p`. `Tendsto`
means every such neighborhood contains all sufficiently late iterates.
{{< /lean-bridge >}}

In a pseudo-metric space, the same statement is

\[
d(f^n(x),p)\to0.
\]

The theorem `isAttractedTo_iff_dist` uses Mathlib's
`tendsto_iff_dist_tendsto_zero` for this translation.

## Local attraction is a neighborhood condition

The point \(p\) is a **locally attracting fixed point** when

\[
f(p)=p
\quad\text{and}\quad
B_f(p)\in\mathcal N(p).
\]

The filter statement says that the basin contains some neighborhood of \(p\).
It does not say the basin is only local. The basin may extend far beyond the
neighborhood used by the definition.

{{< reference-figure
  wide="true"
  src="basin-neighborhood.svg"
  alt="A large basin contains a smaller neighborhood around fixed point p, and starts in that neighborhood follow curved paths toward p."
  caption="**Local attraction:** the basin itself may be large or irregular. The required fact is that it contains a whole neighborhood of the fixed point, not merely the fixed point alone."
>}}

Global attraction quantifies over every initial state. The theorem
`IsGloballyAttractingFixedPoint.isLocallyAttractingFixedPoint` restricts that
universal statement to a neighborhood.

## Attraction and stability answer different questions

Forward stability asks whether a nearby start remains close to the reference
orbit at every time. Attraction asks whether the orbit approaches a target as
time tends to infinity.

A transient can be large even when the eventual limit is \(p\). Conversely,
two translated trajectories may stay a constant distance apart forever, so
the reference orbit is stable without attracting the nearby orbit.

The project therefore defines

\[
\begin{aligned}
\text{asymptotically stable fixed point}
&= \text{Lyapunov-stable fixed point}\\
&\quad+\text{local attraction}.
\end{aligned}
\]

The plus sign denotes conjunction, not numerical addition.

{{< lean-bridge
  human="The fixed point is Lyapunov stable, and its basin contains a neighborhood of it."
  math="\(\operatorname{Stable}(f,p)\land B_f(p)\in\mathcal N(p)\)."
  lean="def IsAsymptoticallyStableFixedPoint [UniformSpace X]\n    (f : X → X) (p : X) : Prop :=\n  IsLyapunovStableFixedPoint f p ∧\n    basinOfAttraction f p ∈ 𝓝 p"
>}}
The first conjunct already includes fixedness. The second is the attraction
obligation. The equivalence theorem rewrites it as Lyapunov stability together
with `IsLocallyAttractingFixedPoint`.
{{< /lean-bridge >}}

## Why contractions are the clean test case

Suppose \(f\) has Lipschitz constant \(K\lt1\) on a nonempty complete
metric space. Mathlib's Banach fixed-point API constructs a unique
fixed point and proves

\[
f^n(x)\to p
\]

for every \(x\). This gives a global basin. Since \(K\le1\), the same map is
nonexpansive, and the preceding stability module proves forward stability.
The two results together yield asymptotic stability.

The source reuses Mathlib's theorem rather than encoding a second contraction
proof. Completeness and nonemptiness remain visible because the constructed
fixed point needs them.

## Attraction to a set

For a nonempty set \(A\subseteq X\), the orbit from \(x\) is attracted to
\(A\) when

\[
\operatorname{dist}(f^n(x),A)\to0.
\]

The orbit need not converge to one selected point in \(A\). It may approach
different parts of the set at different times.

{{< reference-figure
  wide="true"
  src="set-distance.svg"
  alt="Successive orbit points approach different nearby parts of a nonempty target set while the distance segments shrink."
  caption="**Distance-to-set attraction:** only the infimum distance to \(A\) is required to vanish. The diagram does not assert convergence to one point, eventual membership in \(A\), or Hausdorff convergence of orbit tails."
>}}

{{< lean-bridge
  human="The target set is nonempty, and the distance from the orbit to that set tends to zero."
  math="\(A\ne\varnothing\land\operatorname{dist}(f^n(x),A)\to0\)."
  lean="def IsAttractedToSet [PseudoMetricSpace X]\n    (f : X → X) (x : X) (A : Set X) : Prop :=\n  A.Nonempty ∧\n    Tendsto (fun n : ℕ ↦ Metric.infDist (f^[n] x) A)\n      atTop (𝓝 0)"
>}}
`Metric.infDist y A` is the infimum distance from `y` to `A`. The explicit
`A.Nonempty` blocks the totalized identity `Metric.infDist y ∅ = 0` from
turning the empty set into a universal target.
{{< /lean-bridge >}}

A locally attracting set is also required to be forward invariant and to have
its basin as a neighborhood of each point in the set. This milestone chooses
forward inclusion \(f(A)\subseteq A\), not equality invariance.

For a singleton, `Metric.infDist_singleton` recovers the ordinary point
distance. Three checked bridge theorems identify orbit attraction, basins, and
local attraction for \(A=\{p\}\).

## Standalone Lean tutorial

The file `finite-basin.lean` imports only `Std`. It defines the three-state
system, proves an eventual constant tail for every constructor, and evaluates
the first five states of the high orbit.

~~~lean
def reachesLow (x : State) : Prop :=
  ∃ N, ∀ n, N ≤ n → orbit x n = low

theorem every_state_reachesLow (x : State) : reachesLow x := by
  refine ⟨2, fun n hn => ?_⟩
  obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_le hn
  simpa [Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using
    orbit_after_two x k
~~~

The bundled file contains the complete definitions and supporting lemmas. Run
it on macOS or Linux:

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/attraction-basins-and-asymptotic-stability-in-discrete-time/finite-basin.lean
```

## Try it in the repository

The exact source is a **full project check** using pinned Lean and Mathlib
dependencies and may require substantial disk space or setup time:

~~~lean
import NonlinearDynamics.Deterministic.Discrete.Attraction

#check IsAttractedTo
#check basinOfAttraction
#check IsAsymptoticallyStableFixedPoint
#check isAttractedToSet_singleton_iff
~~~

{{< repo-check >}}
The copied checks are a reader worksheet. The authoritative source is
`NonlinearDynamics/Deterministic/Discrete/Attraction.lean`; the command below
checks that complete module with the repository's pinned environment.
{{< /repo-check >}}

## Boundaries

This interface does not define uniform attraction of bounded sets, compact
global attractors, equality invariance, Hausdorff convergence, invariant-set
Lyapunov stability, periodic attractors, attraction rates, robustness under
map perturbations, or stable manifolds.

## References

- J. P. LaSalle, “Difference Equations. Discrete Semidynamical Systems,” in
  *The Stability of Dynamical Systems*, SIAM CBMS 25 (1976), pages 1–25,
  [DOI 10.1137/1.9781611970432.ch1](https://doi.org/10.1137/1.9781611970432.ch1).
- Jack K. Hale, *Asymptotic Behavior of Dissipative Systems*, AMS Surveys and
  Monographs 25 (1988), Chapter 2,
  [DOI 10.1090/surv/025](https://doi.org/10.1090/surv/025).
- Mathlib 4.32.0, pinned revision `81a5d257`, source modules
  `Topology.MetricSpace.Contracting`,
  `Topology.MetricSpace.HausdorffDistance`, and
  `Dynamics.FixedPoints.Topology`.
