---
title: "Devaney Chaos and the Banks Implication in Lean"
slug: "devaney-chaos-and-the-banks-implication-in-lean"
date: 2026-08-07
weight: -79
author: "tdj28"
summary: "A Lean interface separates Devaney's historical three clauses from their continuous topological core and checks when sensitivity follows."
lead: |
  Transitivity and dense periodic points look purely topological. Sensitivity needs a metric scale. The Banks theorem explains when the first two dynamical conditions force the third, and which hypotheses make that implication valid.
key_result: |
  On an infinite metric space, a continuous self-map that is topologically transitive and has dense positive-period points is sensitive. The source keeps that theorem separate from the historical three-clause definition and records the finite-space obstruction.
draft: true
pro_reviewed: false
status: "Source and teaching candidate; warning-fatal leaf and deterministic aggregator passed, complete repository validation pending"
level: "Intermediate topology, metric dynamics, periodic points, and Lean 4"
reading_time: "35 to 50 minutes"
prerequisites:
  - "Open and dense sets"
  - "Function iteration"
  - "Sensitive dependence on initial conditions"
lean_module: "NonlinearDynamics.Deterministic.Chaos.Devaney"
lean_source: "formalization/NonlinearDynamics/Deterministic/Chaos/Devaney.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Chaos/Devaney.lean"
lean_source_sha256: "52fe20359c5c07407e0d3e319a26e9c2dd593c97f88f1dc6b3acf9adc1abf39f"
tags:
  - "Lean 4"
  - "Discrete dynamics"
  - "Devaney chaos"
  - "Topological transitivity"
  - "Periodic points"
og_image: "devaney-chaos-and-the-banks-implication-in-lean-card.png"
og_image_alt: "Two disjoint periodic orbits determine a positive separation scale, while transitivity carries a nearby point toward the selected orbit."
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
**Editorial status.** This draft accompanies a warning-fatal source candidate.
Professional review has not been performed, so `pro_reviewed` remains false.
The Devaney leaf and deterministic aggregator pass; the complete repository
gate and final publication decision remain pending.
{{< /panel >}}

## Begin with a three-state cycle

Let \(X=\{0,1,2\}\) with the discrete metric, and let
\(f(0)=1\), \(f(1)=2\), and \(f(2)=0\). Every state returns after three
updates. Every nonempty open set contains at least one state, and an appropriate
positive iterate carries that state into any other nonempty open set. Thus this
finite system has the two familiar topological ingredients: transitivity and
dense periodic points.

It is not sensitive. The ball of radius \(1/2\) around any state contains only
that state, so no distinct nearby partner is available. This example is a
counterexample to the unrestricted claim that the two topological clauses
always imply sensitivity. The missing hypothesis is infinitude of the metric
space.

{{< reference-figure
  src="finite-cycle-boundary.svg"
  alt="A three-state cyclic orbit satisfies transitivity and periodicity, but a small singleton metric ball blocks sensitivity."
  caption="**Boundary case:** the three arrows make one periodic orbit and connect every ordered pair of nonempty open sets after a positive number of steps. The dashed ball contains only state 0, so the same finite system cannot satisfy metric sensitivity."
>}}

## Separate the definition from the theorem

Devaney's second edition lists three ingredients for chaos: topological
transitivity, density of periodic points, and sensitive dependence on initial
conditions. Continuity of the self-map belongs to the surrounding dynamical
system setup. Banks, Brooks, Cairns, Davis, and Stacey later showed that on an
infinite metric space, continuity plus the first two dynamical clauses imply
the third.

The Lean module therefore exposes two packages. The topological core is

```lean
def HasDevaneyCore [TopologicalSpace X] (f : X → X) : Prop :=
  Continuous f ∧ IsTopologicallyTransitive f ∧ HasDensePeriodicPoints f
```

The historical metric package is

```lean
def IsDevaneyChaotic [PseudoMetricSpace X] (f : X → X) : Prop :=
  HasDevaneyCore f ∧ IsSensitive f
```

This organization does not redefine Devaney chaos as a two-clause property.
It names the two-clause core so that the redundancy of sensitivity appears as
a theorem with visible hypotheses. Modern authors sometimes use the reduced
convention after citing the Banks implication; the source keeps the historical
and reduced conventions distinguishable.

## Positive time and positive period are deliberate

The project predicate `IsTopologicallyTransitive` asks that for every ordered
pair of nonempty open sets \(U,V\), some point \(x\in U\) enters \(V\) after a
**positive** number of iterations:

\[
\forall U,V,\quad U,V\text{ nonempty and open}
\Longrightarrow
\exists n\gt0\;\exists x\in U,\quad f^n(x)\in V.
\]

Allowing \(n=0\) would let an overlap between \(U\) and \(V\) supply a witness
without testing the dynamics. Devaney's convention uses a positive iterate,
so the project definition records that choice rather than inheriting the
identity element of a generic monoid action.

`HasDensePeriodicPoints` uses Mathlib's `Function.periodicPts f`. Membership
means that some **positive** natural number \(n\) satisfies \(f^n(x)=x\). Fixed
points are included with period one. The empty phase space is explicitly
excluded from both predicates so that universal statements do not succeed
vacuously.

For background definitions, see
[topological transitivity]({{< relref "/knowledge-base/glossary/topological-transitivity" >}}),
[dense periodic points]({{< relref "/knowledge-base/glossary/dense-periodic-points" >}}),
and [sensitive dependence]({{< relref "/knowledge-base/glossary/sensitive-dependence-on-initial-conditions" >}}).

## How the Banks proof creates one scale

Dense periodic points first provide one periodic point \(p\). Its orbit is a
finite set. Because the metric space is infinite, the complement is nonempty;
density then provides a second periodic point \(q\) outside the first orbit.
Two periodic orbits that meet are the same orbit, so these two finite orbits
are disjoint.

Disjoint compact and closed sets in a metric space have a positive separation
in this finite setting. Write that separation as \(r\gt0\) and choose
\(\delta=r/8\). For every reference point \(x\), at least one of the two
periodic orbits stays at distance at least \(4\delta\) from \(x\). Call a point
on that far orbit \(q\).

Now receive an arbitrary neighborhood of \(x\). Density supplies a periodic
point \(p\) inside it. Continuity controls the first finitely many iterates of
points near \(q\). Transitivity carries some point \(y\), also in the original
neighborhood of \(x\), into that controlled neighborhood. A modular-arithmetic
alignment chooses a time that is simultaneously a period multiple for \(p\)
and a controlled iterate for \(y\). At that time, \(p\) and \(y\) are more than
\(2\delta\) apart. The triangle inequality then says that at least one of them
is more than \(\delta\) from the corresponding iterate of \(x\).

{{< reference-figure
  src="banks-proof-architecture.svg"
  alt="Two disjoint periodic orbits supply a positive scale; density chooses a nearby periodic point, transitivity chooses another nearby point, and the triangle inequality forces one to separate from the reference orbit."
  caption="**Proof architecture:** infinitude and density produce two disjoint finite periodic orbits. Their separation fixes the global scale before the reference point and neighborhood arrive. Continuity, transitivity, period alignment, and the triangle inequality then produce the required witness."
>}}

The constants \(4\delta\), \(2\delta\), and \(\delta\) are bookkeeping margins.
The theorem claims existence of a positive sensitivity scale, not optimality of
the factor \(1/8\).

## Why each hypothesis is visible

- A genuine `MetricSpace` separates distinct points. A pseudo-metric can give
  distinct points distance zero, so disjoint finite orbits need not have
  positive metric separation.
- `Infinite X` rules out the finite cycle above.
- `Continuous f` makes finitely many orbit-coordinate constraints open.
- Topological transitivity transports a point between the two selected open
  regions.
- Dense positive-period points provide the repeating orbit used for time
  alignment.

No compactness, completeness, separability, surjectivity, or mixing assumption
appears in the implication. Adding one would weaken the formal result relative
to the cited theorem.

## In Lean

{{< lean-bridge
  human="On an infinite metric space, the continuous transitive core with dense positive-period points supplies sensitive dependence."
  math="\(\operatorname{Core}(f)\Longrightarrow\exists\delta\gt0\;\forall x\;\forall\varepsilon\gt0\;\exists y,n,\ d(y,x)\lt\varepsilon\land\delta\lt d(f^n x,f^n y).\)"
  lean="theorem HasDevaneyCore.isSensitive [MetricSpace X] [Infinite X]\n    {f : X → X} (h : HasDevaneyCore f) : IsSensitive f"
>}}
`MetricSpace X` supplies a genuine distance, while `[Infinite X]` is a typeclass
hypothesis excluding finite state spaces. The receiver notation
`HasDevaneyCore.isSensitive` lets a proof `h : HasDevaneyCore f` be used as
`h.isSensitive`. The result reuses the fixed-scale `IsSensitive` interface from
the preceding milestone.
{{< /lean-bridge >}}

## Try it in the repository

Create a reader worksheet containing:

~~~lean
import NonlinearDynamics.Deterministic.Chaos.Devaney

open NonlinearDynamics.Deterministic.Chaos

#check IsTopologicallyTransitive
#check HasDensePeriodicPoints
#check HasDevaneyCore.isSensitive
#check isDevaneyChaotic_iff_hasDevaneyCore
#check not_isDevaneyChaotic_of_finite
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies; initial setup may require substantial
disk space and build time.

{{< repo-check >}}
The copied checks inspect the project definitions, the Banks implication, the
equivalence under its hypotheses, and the finite-space obstruction.
{{< /repo-check >}}

The literal underlying command is:

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Chaos/Devaney.lean
```

`lake env` selects the pinned environment. `-DwarningAsError=true` prevents a
warning from being mistaken for a clean milestone. The command checks the
complete module, not only the displayed signatures.

## Declaration map

| Declaration | Role |
|---|---|
| `IsTopologicallyTransitive` | positive-time open-set transport |
| `HasDensePeriodicPoints` | density of Mathlib's positive-period points |
| `HasDevaneyCore` | continuity plus the two topological clauses |
| `IsDevaneyChaotic` | historical core plus metric sensitivity |
| `IsTopologicallyTransitive.exists_pos_iterate_mem` | public witness unpacking theorem |
| `HasDensePeriodicPoints.exists_mem_open` | select a periodic point in a nonempty open set |
| `HasDensePeriodicPoints.exists_isPeriodicPt_mem_open` | expose its positive period witness |
| `periodicOrbit_eq_of_mem` | points on one positive periodic orbit determine the same cycle |
| `HasDevaneyCore.isSensitive` | the Banks implication |
| `HasDevaneyCore.isDevaneyChaotic` | assemble the historical package |
| `isDevaneyChaotic_iff_hasDevaneyCore` | reduced and historical forms agree under Banks hypotheses |
| `not_isDevaneyChaotic_of_finite` | finite genuine metric obstruction |
| `IsDevaneyChaotic.perfectSpace` | a chaotic metric space has no isolated points |

## Prior work, contribution, and non-claims

**Prior work.** Devaney gives the historical three-clause definition in his
textbook. Banks et al. establish redundancy of the sensitivity clause under
continuity, infinitude, transitivity, and dense periodic points. Jacelon uses
the bundled modern convention in a recent operator-algebraic setting, while
Vejnar explicitly discusses the reduced convention. These later choices
motivate naming both interfaces rather than declaring one wording canonical
for every source.

**Contribution.** This milestone contributes a project-local positive-time
transitivity predicate, a positive-period density predicate, a separated core,
the Banks implication with its exact metric and infinitude boundary, public
unpacking lemmas, and finite/perfect-space consequences. It does not introduce
a new mathematical theorem.

**Non-claims.** The source establishes no mixing, weak mixing, minimality,
expansivity, entropy bound, Lyapunov exponent, shadowing theorem, specification
property, rate of separation, optimal sensitivity constant, numerical
prediction limit, or characterization of chaos outside the stated convention.

## Discussion

The useful design decision is to preserve a historical definition while also
making a later redundancy theorem ergonomic. If sensitivity were deleted from
`IsDevaneyChaotic`, the API would silently adopt a modern convention and hide
the theorem's domain restrictions. If the core were not named, every downstream
theorem would repeatedly unpack the same topological assumptions.

The finite three-cycle is the decisive specification test. It tells us that
the topological core is meaningful on finite spaces and that sensitivity is
not automatic there. The Banks implication therefore belongs on `MetricSpace`
with `[Infinite X]`, while the raw topological predicates remain available in
their natural generality.

Future modules can build symbolic models and conjugacy transport on top of this
interface. Such work must still state which metric or compactness hypotheses
are used when transporting sensitivity; topological transitivity and periodic
point density alone do not erase that issue.

## References

1. Robert L. Devaney, *An Introduction to Chaotic Dynamical Systems*, second
   edition, CRC Press, 2003 reprint of the 1989 edition, Definitions 8.1, 8.2,
   and 8.5, pp. 49–50.
   [Publisher record](https://www.routledge.com/An-Introduction-To-Chaotic-Dynamical-Systems/Devaney/p/book/9780813340852).
2. John Banks, Jeff Brooks, Grant Cairns, Gary Davis, and Peter Stacey, “On
   Devaney's Definition of Chaos,” *American Mathematical Monthly* 99(4)
   (1992), 332–334.
   [doi:10.1080/00029890.1992.11995856](https://doi.org/10.1080/00029890.1992.11995856).
3. Bhishan Jacelon, “Chaotic tracial dynamics,” *Forum of Mathematics, Sigma*
   11 (2023), e53.
   [doi:10.1017/fms.2023.38](https://doi.org/10.1017/fms.2023.38).
4. Benjamin Vejnar, “Topological dynamics and chaos,” *Bulletin of Symbolic
   Logic* (2026), online publication.
   [doi:10.1017/bsl.2026.10158](https://doi.org/10.1017/bsl.2026.10158).
