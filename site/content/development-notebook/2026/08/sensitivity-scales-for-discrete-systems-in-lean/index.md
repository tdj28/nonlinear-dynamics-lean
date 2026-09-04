---
title: "Sensitivity Scales for Discrete Systems in Lean"
slug: "sensitivity-scales-for-discrete-systems-in-lean"
date: 2026-08-07
weight: -78
author: "tdj28"
summary: "A metric-first interface fixes one positive separation scale before the state and neighborhood, then checks doubling, isolated-point obstructions, and conflict with forward stability."
lead: |
  Nearby starts separating once is not yet sensitive dependence. The decisive data are the order of five quantifiers and one scale shared by the entire state space.
key_result: |
  The source defines sensitivity on a nonempty pseudo-metric space, proves its ball and neighborhood forms equivalent under the fixed metric, rules it out on isolated and finite metric spaces, connects it to failure of forward stability at every point, and checks the real doubling map at scale one.
draft: true
pro_reviewed: false
status: "Warning-fatal formal validation passed; professional review and publication inspection pending"
level: "Intermediate metric topology, filters, iterates, and Lean 4"
reading_time: "40 to 55 minutes"
prerequisites:
  - "Orbit and iterate"
  - "Metric balls and neighborhoods"
  - "Forward stability"
lean_module: "NonlinearDynamics.Deterministic.Chaos.Sensitivity"
lean_source: "formalization/NonlinearDynamics/Deterministic/Chaos/Sensitivity.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Chaos/Sensitivity.lean"
lean_source_sha256: "747205ab52e00260c89da63b10b4869144d066ea49266c55639467da2e56f83d"
tags:
  - "Lean 4"
  - "Discrete dynamics"
  - "Sensitive dependence"
  - "Metric spaces"
  - "Forward stability"
og_image: "sensitivity-scales-for-discrete-systems-in-lean-card.png"
og_image_alt: "A fixed sensitivity scale stands above nested neighborhoods, with a nearby point and a later separation time chosen below it."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the questions, shaped the
exposition, and remains responsible for inspecting the cited sources,
artifacts, and final claims before publication. This is an independent,
non-peer-reviewed Development Notebook candidate. Verify claims against the
cited primary sources and released artifacts before relying on them.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This draft explains a validated Lean module.
Professional review has not been performed, so `pro_reviewed` remains false.

**Status correction, 2026-09-04.** The linked Lean source snapshot
has passed the warning-fatal leaf, deterministic aggregator, and complete
repository gate. The earlier pending-validation label was stale.
{{< /panel >}}

## Begin with two real numbers

Let \(D(x)=2x\) on the real line. Starting from \(x\) and
\(y=x+\varepsilon/2\), the initial distance is

\[
|y-x|=\varepsilon/2\lt\varepsilon.
\]

After \(n\) updates,

\[
D^n(x)=2^n x,
\qquad
D^n(y)=2^n y,
\qquad
|D^n(y)-D^n(x)|=2^n\varepsilon/2.
\]

Powers of two are unbounded. Therefore some \(n\) makes the last quantity
larger than \(1\), no matter how small the requested radius
\(\varepsilon\gt0\) was. This complete argument establishes that the unbounded
real doubling map is sensitive with scale \(1\).

It does not establish bounded chaotic dynamics. Orbits usually leave every
bounded interval, and the theorem asserts no recurrence, mixing, entropy, or
dense periodic points.

## Freeze the quantifier order

The selected convention is

\[
\exists\delta\gt0\;\forall x\;\forall\varepsilon\gt0\;
\exists y\;\exists n\in\mathbb N,
\quad d(y,x)\lt\varepsilon
\quad\land\quad
\delta\lt d(f^n(x),f^n(y)).
\]

The scale \(\delta\) is chosen before the state and neighborhood. The nearby
state \(y\) and witness time \(n\) may depend on both. Banks, Brooks, Cairns,
Davis, and Stacey use this global sensitivity constant in their analysis of
Devaney chaos ([1992, pp. 332–334](https://doi.org/10.1080/00029890.1992.11995856)).
Auslander and Yorke's earlier stability/instability framework is pointwise
([1980, pp. 181–182](https://doi.org/10.2748/tmj/1178229634)); it should not be
silently identified with one uniform scale for the whole space.

{{< reference-figure
  src="quantifier-dependency.svg"
  alt="A dependency ladder fixes positive delta first, then receives a state and neighborhood, then chooses a nearby state and separation time; a crossed branch chooses the time before the neighborhood."
  caption="**The dependency is the definition:** the witness state and time respond to the requested neighborhood. Selecting a time first is stronger and fails even for the symbolic shift rehearsal below."
>}}

Strict \(\gt\delta\) matches the common Devaney-style form. A source using
\(\geq\delta\) defines the same existential property only after rescaling:
strict separation at \(\delta\) gives weak separation at \(\delta\), while weak
separation at a positive \(\delta\) gives strict separation at \(\delta/2\).
The constants themselves are not interchangeable.

## Why the first API is metric-first

A topology determines neighborhoods. It does not by itself choose a uniform
meaning for two images being “\(\delta\) apart.” On noncompact spaces,
sensitivity may depend on which compatible metric is selected. Good and
Macías prove equivalence among relevant metric, uniform, and finite-open-cover
forms under compactness hypotheses
([2018, Theorem 3.2](https://doi.org/10.3934/dcds.2018043)).

The present module therefore uses `PseudoMetricSpace` and exposes a
neighborhood reformulation under that fixed pseudo-metric. It does not call
the result a topology-only predicate. A later uniform-space interface can
select a sensitivity entourage when a theorem actually needs that abstraction.

Continuity, compactness, and surjectivity are also absent from the raw
predicate. A theorem that needs one of them must state it.

## The source hierarchy

The formal interface separates four layers:

```lean
def SeparatesAtScale [PseudoMetricSpace X]
    (f : X → X) (δ : ℝ) (x y : X) : Prop :=
  ∃ n : ℕ, δ < dist (f^[n] x) (f^[n] y)

def IsSensitiveAtWith [PseudoMetricSpace X]
    (f : X → X) (δ : ℝ) (x : X) : Prop :=
  ∀ ε > 0, ∃ y, dist y x < ε ∧ SeparatesAtScale f δ x y

def IsSensitiveWith [PseudoMetricSpace X]
    (f : X → X) (δ : ℝ) : Prop :=
  Nonempty X ∧ 0 < δ ∧ ∀ x, IsSensitiveAtWith f δ x

def IsSensitive [PseudoMetricSpace X] (f : X → X) : Prop :=
  ∃ δ, IsSensitiveWith f δ
```

`Nonempty X` is deliberate. Without it, the universal statement over `x`
would make the empty phase space satisfy every positive scale vacuously.

Natural-number time includes zero. The source proves that if the initial
distance is below the positive scale, a separating witness must have
\(n\gt0\). Thus the indexing convention does not turn initial distance into the
global result.

## Balls and neighborhoods say the same thing here

`isSensitiveAtWith_iff_nhds` states

```lean
IsSensitiveAtWith f δ x ↔
  ∀ U ∈ 𝓝 x, ∃ y ∈ U, SeparatesAtScale f δ x y
```

For the forward direction, every neighborhood \(U\) contains some positive
metric ball around \(x\). Sensitivity supplies a witness in that ball, hence
in \(U\). For the reverse direction, use the ball itself as the neighborhood.

This equivalence translates two presentations under one fixed metric. It does
not prove invariance under replacing that metric by any other compatible
metric on a noncompact space.

## Boundary cases drove the theorem suite

If \(\{x\}\) is open, use it as the neighborhood. Membership forces \(y=x\),
but equal initial states have equal iterates and can never become a positive
distance apart. Therefore sensitivity at \(x\) is impossible.

Consequences checked in the module include:

- a sensitive space has no isolated point and satisfies Mathlib's
  `PerfectSpace` proposition;
- no map on a discrete pseudo-metric space is sensitive once the required
  nonempty witness is unpacked; and
- no map on a finite genuine metric space is sensitive, because finite metric
  spaces have discrete topology.

The last statement intentionally uses `MetricSpace`, not merely
`PseudoMetricSpace`: distinct points in a pseudo-metric space may have zero
distance, so its topology need not be discrete even when the underlying type
is finite.

{{< reference-figure
  src="isolated-point-obstruction.svg"
  alt="A singleton neighborhood around x contains only x, so the required nearby witness y equals x and both iterated images remain identical."
  caption="**Isolated-point obstruction:** one legal singleton neighborhood defeats every positive sensitivity scale. This is why a genuinely finite metric state space cannot supply the positive example."
>}}

## Sensitivity contradicts forward stability point by point

Forward stability at \(x\) says that for every output tolerance, some input
ball keeps all corresponding iterates within that tolerance. Apply it at the
sensitivity scale \(\delta\). Sensitivity in the resulting input ball produces
an iterate farther than \(\delta\), a direct contradiction.

The module packages this as
`IsSensitiveAtWith.not_isForwardStableAt`. It then derives that a globally
sensitive map is forward-stable nowhere. Existing project results say every
nonexpansive map is forward stable everywhere, so nonexpansive maps, including
the identity map, are not sensitive.

The converse is not asserted. Failure of global sensitivity does not by
itself construct a forward-stable point.

## A bounded standalone symbolic rehearsal

A finite metric state space cannot be sensitive, so the standalone worksheet
uses infinite binary streams but only finite-prefix reasoning. Given any
requested prefix length \(k\), it copies those \(k\) bits, flips the next bit,
and shifts exactly \(k\) times. The altered bit then reaches coordinate zero.

The same worksheet refutes a stronger quantifier order in which one time
\(n\) must be selected before the prefix length. Requesting a prefix of length
\(n+1\) fixes the very bit that the \(n\)-fold shift would expose.

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/sensitivity-quantifiers-and-the-symbolic-shift/prefix-shift-sensitivity.lean
```

This is a **standalone tutorial** importing only `Std`. It checks exact
finite-prefix combinatorics. It does not formalize the Cantor metric or
product topology and therefore is not, by itself, a Lean theorem that the
shift is metrically sensitive.

## Prior work, contribution, and non-claims

**Prior work.** Banks et al. state the familiar global metric sensitivity
condition in their theorem on Devaney chaos. Akin and Kolyada carefully
separate pointwise instability from a global sensitivity constant and study
stronger recurrent separation sets
([2003, §3](https://doi.org/10.1088/0951-7715/16/4/313)). Good and Macías
analyze which sensitivity formulations are genuinely topological under
compactness. Antunes and Carvalho distinguish ordinary sensitivity from
first-time-sensitive refinements
([2025, Definitions 1.1–1.3](https://doi.org/10.1007/s10884-024-10362-x)).

**Contribution.** This milestone contributes a small project-local Lean
interface, its neighborhood theorem, boundary lemmas, a bridge to the existing
forward-stability API, and one exact real example. It does not introduce a new
mathematical definition.

**Non-claims.** The predicates and doubling proof establish no expansivity,
transitivity, mixing, dense periodic points, Devaney chaos, positive entropy,
exponential separation rate, Lyapunov exponent, derivative growth, numerical
roundoff amplification, shadowing result, prediction theorem, two-sided-time
statement, or topological-conjugacy invariance on arbitrary noncompact spaces.

## Declaration map

| Declaration | Role |
|---|---|
| `SeparatesAtScale` | one pair separates at one later natural-number time |
| `IsSensitiveAtWith` | every ball at one state has a separating witness |
| `IsSensitiveWith` | nonempty space, positive global scale, every state |
| `IsSensitive` | existence of such a scale |
| `SeparatesAtScale.mono` | lower the separation scale |
| `SeparatesAtScale.ne` | positive separation forces distinct starts |
| `SeparatesAtScale.exists_pos` | sufficiently close starts cannot use time zero |
| `isSensitiveAtWith_iff_nhds` | ball/neighborhood equivalence under the fixed metric |
| `not_isSensitiveAtWith_of_isOpen_singleton` | isolated-state obstruction |
| `not_isSensitive_of_discreteTopology` | discrete-space obstruction |
| `not_isSensitive_of_finite` | finite genuine metric spaces are excluded |
| `IsSensitive.perfectSpace` | sensitivity removes isolated points |
| `IsSensitiveAtWith.not_isForwardStableAt` | sensitivity/stability contradiction |
| `not_isSensitive_of_lipschitzWith_one` | nonexpansive non-example |
| `not_isSensitive_id` | identity-map nonexample |
| `doublingMap_iterate` | closed form for every doubling-map iterate |
| `doublingMap_isSensitiveWith_one` | checked scale-one real example |

## Discussion

The most important design result is negative: sensitivity should not become a
catch-all name for trajectory divergence. Its global scale, local input
quantifier, existential partner, and adaptive witness time jointly define the
property. Removing any one changes what can be concluded.

The metric-first choice also makes the current trust boundary visible. The
module can interact cleanly with the project's pseudo-metric forward-stability
theory now. A uniform or compact-topological layer should arrive with explicit
hypotheses and equivalence theorems, not with a renamed metric definition.

The warning-fatal Mathlib-backed check and complete repository validation
have passed for the linked Lean source snapshot. Professional review and
publication inspection remain pending, so this page remains a working draft.

## Reproduce the project check

This is a **full project check** using the pinned Lean and Mathlib
dependencies. Initial setup may require substantial disk space or build time
on macOS or Linux.

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Chaos/Sensitivity.lean
```

`lake env` selects the repository environment. `-DwarningAsError=true`
rejects warnings. The command checks the complete source module; the smaller
standalone command above checks only the finite-prefix teaching worksheet.

## References

1. Ethan Akin and Sergiy Kolyada, “Li–Yorke sensitivity,” *Nonlinearity* 16
   (2003), 1421–1433.
   [doi:10.1088/0951-7715/16/4/313](https://doi.org/10.1088/0951-7715/16/4/313).
2. Joseph Auslander and James A. Yorke, “Interval maps, factors of maps, and
   chaos,” *Tohoku Mathematical Journal* 32 (1980), 177–188.
   [doi:10.2748/tmj/1178229634](https://doi.org/10.2748/tmj/1178229634).
3. John Banks, Jeff Brooks, Grant Cairns, Gary Davis, and Peter Stacey, “On
   Devaney's Definition of Chaos,” *American Mathematical Monthly* 99(4)
   (1992), 332–334.
   [doi:10.1080/00029890.1992.11995856](https://doi.org/10.1080/00029890.1992.11995856).
4. Chris Good and Sergio Macías, “What is topological about topological
   dynamics?”, *Discrete and Continuous Dynamical Systems* 38(3) (2018),
   1007–1031.
   [doi:10.3934/dcds.2018043](https://doi.org/10.3934/dcds.2018043).
5. Douglas Antunes and Bernardo Carvalho, “First-time Sensitive
   Homeomorphisms,” *Journal of Dynamics and Differential Equations* 37
   (2025), 2281–2321.
   [doi:10.1007/s10884-024-10362-x](https://doi.org/10.1007/s10884-024-10362-x).
