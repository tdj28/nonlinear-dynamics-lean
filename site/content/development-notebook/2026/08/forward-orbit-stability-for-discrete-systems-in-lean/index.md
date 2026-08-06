---
title: "Forward-Orbit Stability for Discrete Systems in Lean"
slug: "forward-orbit-stability-for-discrete-systems-in-lean"
date: 2026-08-06
weight: -73
author: "tdj28"
summary: "A deterministic stability interface defines forward stability as equicontinuity of all natural-number iterates, then separates reference-orbit stability from fixedness and attraction."
lead: |
  Translation by a nonzero real number has no fixed point, yet two translated trajectories keep their initial separation forever. This boundary example fixes the interface: forward stability compares a nearby trajectory with one chosen reference orbit at every natural-number time, while Lyapunov stability of a fixed point records fixedness separately.
key_result: |
  In a pseudo-metric space, IsForwardStableAt f p is equivalent to the uniform-in-time epsilon-delta orbit estimate. Every nonexpansive self-map is forward stable, and every fixed point of such a map is Lyapunov stable. No attraction, error decay, set stability, or perturbation robustness is asserted.
draft: false
pro_reviewed: false
status: "Pending human editorial, scientific-integrity, and expert-reader review"
level: "Intermediate topology, metric spaces, function iteration, and Lean 4"
reading_time: "45 to 65 minutes"
prerequisites:
  - "Orbit and iterate"
  - "Metric neighborhoods and uniform closeness"
  - "Continuity and Lipschitz maps"
lean_module: "NonlinearDynamics.Deterministic.Discrete.Stability"
lean_source: "formalization/NonlinearDynamics/Deterministic/Discrete/Stability.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Discrete/Stability.lean"
lean_source_sha256: "ccc2ae73a4696bdf488f64281ef53cd1db066d78b5f1e2a9a4471c3f90062186"
tags:
  - "Lean 4"
  - "Discrete dynamics"
  - "Forward stability"
  - "Equicontinuity"
  - "Lyapunov stability"
  - "Fixed points"
og_image: "forward-orbit-stability-for-discrete-systems-in-lean-card.png"
og_image_alt: "Warm-paper teaching card showing a reference orbit and nearby orbit staying inside one forward-time tube, with fixedness as a separate gate."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the scope, approved the formal-check
workflow, and remains responsible for the statements, sources, and released
artifacts. This is an independent, non-peer-reviewed Research Note.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** The Lean source has passed warning-fatal leaf and
deterministic-aggregator checks. Human editorial acceptance and separate
scientific-integrity and expert-reader reviews remain pending. The configured
professional review has not been performed, and `pro_reviewed` remains false.
{{< /panel >}}

## Begin with a moving reference orbit

Let \(f(x)=x+3\) on the real line. Start one trajectory at \(p=10\) and a
nearby trajectory at \(x=10.2\).

| time \(n\) | \(f^n(p)\) | \(f^n(x)\) | separation |
|---:|---:|---:|---:|
| 0 | 10 | 10.2 | 0.2 |
| 1 | 13 | 13.2 | 0.2 |
| 2 | 16 | 16.2 | 0.2 |
| 3 | 19 | 19.2 | 0.2 |

For every natural number \(n\),

\[
f^n(x)-f^n(p)=x-p.
\]

The reference point is not fixed: \(f(10)=13\). Nevertheless, every nearby
trajectory remains exactly as close to the reference trajectory as it was at
time zero. This example refutes any universal identification of orbit
stability with fixed-point stability.

{{< reference-figure
  wide="true"
  src="reference-orbit-tube.svg"
  alt="Two forward translation orbits begin at 10 and 10.2, advance by three at each time, and remain separated by 0.2 inside a shaded tube."
  caption="**A stable orbit need not be stationary:** translation moves both starts by the same amount. The shaded band is one allowed epsilon tube, not attraction toward the reference orbit."
>}}

The calculation exhibits a forward-stable reference orbit that is not a
fixed point. It does not establish attraction, robustness under changing the
map, or a classification of all stable systems.

## The interface decision

The module makes four choices explicit:

1. The reference object is a point together with its entire forward orbit.
2. Time is indexed by \(\mathbb N\), so time zero is included and no inverse
   map is assumed.
3. The primary definition is uniform-space equicontinuity of the iterate
   family.
4. Fixedness is an additional conjunct, not a consequence of orbit stability.

The core definition is

```lean
def IsForwardStableAt [UniformSpace X]
    (f : X → X) (p : X) : Prop :=
  EquicontinuousAt (fun n : ℕ ↦ f^[n]) p
```

Here `f^[n]` is the \(n\)-fold function iterate. `EquicontinuousAt` requires
one neighborhood of `p` that works simultaneously for every member of the
family indexed by `n`.

The fixed-point specialization is separate:

```lean
def IsLyapunovStableFixedPoint [UniformSpace X]
    (f : X → X) (p : X) : Prop :=
  IsFixedPt f p ∧ IsForwardStableAt f p
```

`IsFixedPt f p` means `f p = p`. The conjunction records two independent
facts: the reference orbit is stationary, and nearby forward orbits remain
close to it.

{{< lean-bridge
  human="A point is forward stable when one sufficiently small initial neighborhood keeps every forward iterate inside any requested closeness relation around the reference orbit."
  math="For every entourage (U), there is a neighborhood of (p) such that ((f^n(p),f^n(x))\in U) for every (n\in\mathbb N)."
  lean="theorem isForwardStableAt_iff [UniformSpace X] :\n    IsForwardStableAt f p ↔\n      ∀ U ∈ 𝓤 X, ∀ᶠ x in nhds p, ∀ n : ℕ,\n        (f^[n] p, f^[n] x) ∈ U"
>}}
`𝓤 X` is the uniformity filter. `∀ᶠ x in nhds p` means the claim holds for
every `x` in some neighborhood of `p`. The neighborhood may depend on `U`, but
it may not depend on the later time `n`.
{{< /lean-bridge >}}

## The metric theorem

In a pseudo-metric space, the definition becomes

\[
\forall \varepsilon\gt0\;\exists\delta\gt0\;\forall x,
d(x,p)\lt\delta\Longrightarrow
\forall n\in\mathbb N,
d(f^n(p),f^n(x))\lt\varepsilon.
\]

This is `isForwardStableAt_iff_dist`. A pseudo-metric is sufficient because
the proof uses distances but never needs distinct points to have positive
distance.

{{< lean-bridge
  human="Every requested orbit tube has an initial radius that keeps all forward iterates inside it."
  math="\(\forall\varepsilon\gt0\,\exists\delta\gt0\,\forall x,\ d(x,p)\lt\delta\Rightarrow\forall n,\ d(f^n(p),f^n(x))\lt\varepsilon\)."
  lean="theorem isForwardStableAt_iff_dist [PseudoMetricSpace X] :\n    IsForwardStableAt f p ↔\n      ∀ ε > 0, ∃ δ > 0, ∀ x, dist x p < δ →\n        ∀ n : ℕ, dist (f^[n] p) (f^[n] x) < ε"
>}}
The same `δ` works for all `n`. Allowing a separate `δ n` would describe
continuity of individual iterates, not uniform forward stability.
{{< /lean-bridge >}}

At a fixed point, `Function.iterate_fixed` rewrites \(f^n(p)\) to \(p\).
`isLyapunovStableFixedPoint_iff_dist` therefore yields the usual stationary
form

\[
d(x,p)\lt\delta\Longrightarrow d(f^n(x),p)\lt\varepsilon
\quad\text{for every }n.
\]

Both directions retain `IsFixedPt f p`. The distance estimate at time zero
cannot manufacture fixedness.

## Consequences and examples

The iterate at index one is `f`, so
`IsForwardStableAt.continuousAt` extracts ordinary one-step continuity at the
reference point. This implication is one-way; the source never claims that
one-step continuity controls every iterate uniformly.

If \(f\) is nonexpansive,

\[
d(f(x),f(y))\le d(x,y),
\]

then Mathlib's `LipschitzWith.iterate` gives
\(d(f^n(x),f^n(y))\le d(x,y)\) for every \(n\). Taking
\(\delta=\varepsilon\) proves
`isForwardStableAt_of_lipschitzWith_one`.

The wrapper `isLyapunovStableFixedPoint_of_lipschitzWith_one` adds an explicit
fixed-point hypothesis. The endpoint examples are
`isForwardStableAt_id`, `isForwardStableAt_add_const`,
`forwardStableAt_add_const_not_fixed`, and
`isLyapunovStableFixedPoint_const`. Identity and the constant map supply fixed
points; nonzero translation supplies a stable moving orbit.

{{< reference-figure
  wide="true"
  src="interface-boundaries.svg"
  alt="Forward orbit stability and fixedness feed a Lyapunov-stable fixed point, while attraction, decay, set stability, two-sided time, and perturbation robustness remain outside."
  caption="**The module boundary:** forward stability and fixedness are separate inputs. Their conjunction defines a Lyapunov-stable fixed point. The gray neighboring notions require different predicates or hypotheses."
>}}

## Declaration-complete source map

The frozen source contains twelve public declarations:

| Declaration | Role |
|---|---|
| `IsForwardStableAt` | primary uniform-space definition |
| `IsLyapunovStableFixedPoint` | fixedness plus forward stability |
| `isForwardStableAt_iff` | entourage/neighborhood unfolding |
| `isForwardStableAt_iff_dist` | metric epsilon-delta equivalence |
| `isLyapunovStableFixedPoint_iff_dist` | fixed-point metric equivalence |
| `IsForwardStableAt.continuousAt` | one-step continuity consequence |
| `isForwardStableAt_of_lipschitzWith_one` | nonexpansive sufficient condition |
| `isLyapunovStableFixedPoint_of_lipschitzWith_one` | fixed-point wrapper |
| `isForwardStableAt_id` | identity example |
| `isForwardStableAt_add_const` | real-translation example |
| `forwardStableAt_add_const_not_fixed` | stable but nonfixed witness |
| `isLyapunovStableFixedPoint_const` | constant-map fixed-point example |

Six `#print axioms` commands audit the central equivalences, consequence, and
examples. Every report is exactly `[propext, Classical.choice, Quot.sound]`;
none contains `sorryAx`.

## Reproduce the project check

This is a **full project check** using the pinned Lean and Mathlib dependencies.
It may require substantial disk space and build time.

```sh
git clone https://github.com/tdj28/nonlinear-dynamics-lean.git
cd nonlinear-dynamics-lean/formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Discrete/Stability.lean
```

`lake env lean` selects the project environment. `-DwarningAsError=true`
rejects warnings. The command is portable across macOS and Linux once the
pinned dependencies are installed. The paired [Forward-Orbit and Fixed-Point
Stability Deep Dive]({{< relref
"/knowledge-base/deep-dives/forward-orbit-and-fixed-point-stability-in-discrete-time"
>}}) also supplies a small **standalone tutorial** importing only `Std`. The
[Forward Stability glossary chapter]({{< relref
"/knowledge-base/glossary/forward-stability" >}}) gives a shorter first pass.

## Exact nonclaims

The module proves no attraction result: translated trajectories retain their
gap rather than converging. It proves no asymptotic or exponential stability,
invariant-set stability, basin theorem, Lyapunov-function criterion,
two-sided-time result, structural stability, robustness under perturbing `f`,
or stable-manifold theorem. It also does not claim that continuity implies
forward stability.

These are interface boundaries. Attraction needs a distance-to-target limit
or comparable neighborhood condition. Two-sided time needs invertibility or a
\(\mathbb Z\)-action. Perturbation stability compares different maps, whereas
`IsForwardStableAt` fixes one map and varies only the initial condition.

## References

1. Ethan Akin, “On Chain Continuity,” *Discrete and Continuous Dynamical
   Systems* 2(1), 111–120 (1996),
   [doi:10.3934/dcds.1996.2.111](https://doi.org/10.3934/dcds.1996.2.111).
2. Saber Elaydi and H. R. Farran, “On Variation of Equicontinuity in
   Dynamical Systems,” *Bulletin of the Australian Mathematical Society*
   42(3), 391–397 (1990),
   [doi:10.1017/S0004972700028550](https://doi.org/10.1017/S0004972700028550).
3. J. P. LaSalle, “Difference Equations and Discrete Semidynamical Systems,”
   Chapter 1 of *The Stability of Dynamical Systems*, SIAM CBMS 25 (1976),
   [doi:10.1137/1.9781611970432.ch1](https://doi.org/10.1137/1.9781611970432.ch1).
4. Mathlib, [`Topology.UniformSpace.Equicontinuity`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/UniformSpace/Equicontinuity.lean), pinned revision `81a5d257`.
5. Mathlib, [`Topology.MetricSpace.Equicontinuity`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/MetricSpace/Equicontinuity.lean), pinned revision `81a5d257`.
