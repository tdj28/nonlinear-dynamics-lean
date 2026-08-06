---
title: "Basin of attraction"
slug: "basin-of-attraction"
summary: "A basin of attraction is the set of initial states whose forward orbits converge to one point or approach one specified set."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Discrete.Attraction"
tags:
  - "Discrete dynamics"
  - "Attraction"
  - "Basins"
  - "Fixed points"
og_image: "basin-of-attraction-card.png"
og_image_alt: "Two starts inside a basin follow paths to fixed target p, while one start outside follows a path elsewhere."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note. Human review
of the mathematics, Lean bridge, figures, accessibility, and references
remains pending. Professional review has not been performed, so
<code>pro_reviewed</code> remains false.
{{< /panel >}}

A **basin of attraction** collects the initial states whose forward orbits
approach a specified target.

For a point target \(p\) and self-map \(f:X\to X\), the basin is

\[
B_f(p)=\{x\in X:f^n(x)\to p\text{ as }n\to\infty\}.
\]

The target matters. One initial state may belong to the basin of \(p\), while
another converges to a different fixed point (q) and therefore lies outside
\(B_f(p)\).

## A three-state basin

Take the finite update rule

\[
\text{high}\mapsto\text{middle},\qquad
\text{middle}\mapsto\text{low},\qquad
\text{low}\mapsto\text{low}.
\]

The three orbits are

| start | orbit tail |
|---|---|
| low | low, low, low, ... |
| middle | middle, low, low, ... |
| high | high, middle, low, low, ... |

Every start eventually has the constant `low` tail. Since these rows exhaust
the state type, the basin of `low` is the entire three-state space.

A nearby non-example changes the rule to keep `high` fixed. Then the orbit
from `high` never converges to `low`, so that one state leaves the basin.

{{< reference-figure
  wide="true"
  src="basin-membership.svg"
  alt="Two starts have paths converging to target p inside its basin, while a third path converges to q outside."
  caption="**Membership follows the limit:** different finite prefixes are allowed. A start belongs to \(B_f(p)\) only when its complete forward orbit tends to the specified target \(p\)."
>}}

## Eventual entry is not enough

Suppose an orbit reaches \(p\) once and then leaves. That single visit does not
place the start in \(B_f(p)\). Convergence requires every neighborhood of \(p\)
to contain all sufficiently late iterates.

If \(p\) is fixed, then reaching \(p\) does suffice because every later iterate
also equals \(p\). Fixedness is a reason for the constant tail; it is not part
of the raw orbit-convergence relation.

The checked theorem `IsFixedPt.isAttractedTo` records that a fixed point
attracts its own orbit. The converse needs more care: if some orbit converges
to \(p\), then \(p\) is fixed when \(f\) is continuous at \(p\) and the space
is Hausdorff. Without those gates, the module does not infer fixedness.

## Local and global basins

A fixed point is **locally attracting** when its basin contains a neighborhood
of the point:

\[
f(p)=p
\quad\text{and}\quad
B_f(p)\in\mathcal N(p).
\]

The basin may be much larger than that one neighborhood. Local attraction sets
a lower bound on its size near \(p\); it does not impose an upper bound.

A **globally attracting fixed point** has \(B_f(p)=X\). Global attraction
therefore implies local attraction.

Neither term alone says that nearby orbits stayed close to \(p\) during their
transient. The separate page on
{{< refterm "forward-stability" "forward stability" >}} explains the
all-time closeness requirement. An asymptotically stable fixed point satisfies
both stability and local attraction.

## Point and set targets

For a nonempty set \(A\subseteq X\), the corresponding basin is defined by

\[
B_f(A)=\{x\in X:\operatorname{dist}(f^n(x),A)\to0\}.
\]

This statement does not select one point of \(A\). An orbit may approach
different parts of \(A\) while its distance to the set tends to zero.

{{< reference-figure
  wide="true"
  src="point-versus-set-basin.svg"
  alt="The point basin requires an orbit to converge to p; the set basin requires only its distance to nonempty A to tend to zero."
  caption="**Two target types:** point attraction names one limit. Set attraction names a vanishing infimum distance. When \(A=\{p\}\), the two statements agree exactly."
>}}

The nonempty condition is essential in the formal interface. Mathlib
totalizes the infimum distance at the empty set by

\[
\operatorname{dist}(x,\varnothing)=0.
\]

If nonemptiness were omitted, every orbit would satisfy the numerical limit
for the empty target. `IsAttractedToSet` records `A.Nonempty` explicitly to
block that vacuous boundary.

## In Lean

The point basin is a set comprehension over orbit convergence:

{{< lean-bridge
  human="The basin of p contains exactly the starts whose forward iterates converge to p."
  math="\(B_f(p)=\{x:f^n(x)\to p\}\)."
  lean="def basinOfAttraction [TopologicalSpace X]\n    (f : X → X) (p : X) : Set X :=\n  {x | IsAttractedTo f x p}"
>}}
`Set X` is a set of states. `{x | ...}` is set-builder notation.
`IsAttractedTo f x p` expands to `Tendsto (fun n : ℕ ↦ f^[n] x) atTop
(𝓝 p)`. The membership theorem `mem_basinOfAttraction` exposes this
definition directly.
{{< /lean-bridge >}}

For a pseudo-metric space, the point relation has the distance form:

~~~lean
theorem isAttractedTo_iff_dist [PseudoMetricSpace X] :
    IsAttractedTo f x p ↔
      Tendsto (fun n : ℕ ↦ dist (f^[n] x) p) atTop (𝓝 0)
~~~

The set basin uses `Metric.infDist`. The singleton bridge is literal:

~~~lean
theorem basinOfAttractionSet_singleton [PseudoMetricSpace X] :
    basinOfAttractionSet f {p} = basinOfAttraction f p
~~~

## Try it in the repository

Create a small file after cloning the repository:

~~~lean
import NonlinearDynamics.Deterministic.Discrete.Attraction

#check IsAttractedTo
#check basinOfAttraction
#check IsLocallyAttractingFixedPoint
#check basinOfAttractionSet_singleton
~~~

This is a **full project check** with pinned Lean and Mathlib dependencies. The
initial setup may require substantial disk space and build time:

{{< repo-check >}}
The copied checks are a reader worksheet. The authoritative source is
`NonlinearDynamics/Deterministic/Discrete/Attraction.lean`; the command below
checks that complete module with the repository's pinned environment.
{{< /repo-check >}}

For a smaller **standalone tutorial**, use the `finite-basin.lean` file in the
paired Deep Dive. It imports only `Std` and checks the three-state model
without Mathlib.

## Common boundary mistakes

- Entering the target once is not the same as converging to it.
- Attraction is not the same as Lyapunov stability.
- Point attraction selects one limiting point; set attraction need not.
- A set-distance definition needs an explicit nonempty target under Mathlib's
  totalized `Metric.infDist`.
- Pointwise attraction of every start is not automatically uniform attraction
  of a whole set of starts.

## What this term does not claim

A basin definition alone gives no attraction rate, no compactness, no
Hausdorff convergence, no robustness under perturbation, no stable manifold,
and no algorithm for computing the basin in a nonlinear model.

## References

- J. P. LaSalle, “Difference Equations. Discrete Semidynamical Systems,” in
  *The Stability of Dynamical Systems*, SIAM CBMS 25 (1976), pages 1–25,
  [DOI 10.1137/1.9781611970432.ch1](https://doi.org/10.1137/1.9781611970432.ch1).
- Jack K. Hale, *Asymptotic Behavior of Dissipative Systems*, AMS Surveys and
  Monographs 25 (1988), Chapter 2,
  [DOI 10.1090/surv/025](https://doi.org/10.1090/surv/025).
- Mathlib 4.32.0, pinned revision `81a5d257`, especially
  `Topology.MetricSpace.HausdorffDistance` and
  `Topology.MetricSpace.Contracting`.
