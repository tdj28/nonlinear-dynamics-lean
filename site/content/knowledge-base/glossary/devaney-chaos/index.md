---
title: "Devaney chaos"
slug: "devaney-chaos"
summary: "A continuous self-map combines topological transitivity, dense positive-period points, and sensitive dependence under a stated metric convention."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Chaos.Devaney"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Chaos/Devaney.lean"
lean_source_sha256: "52fe20359c5c07407e0d3e319a26e9c2dd593c97f88f1dc6b3acf9adc1abf39f"
tags:
  - "Discrete dynamics"
  - "Devaney chaos"
  - "Topological transitivity"
  - "Periodic points"
  - "Sensitive dependence"
og_image: "devaney-chaos-card.png"
og_image_alt: "Three labeled clauses form the historical Devaney chaos package, while an infinite metric-space boundary lets the first two imply sensitivity."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this chapter. The author selected the questions, shaped the
exposition, has inspected the sources and artifacts cited here, and is
responsible for the final text and claims. This is an independent,
non-peer-reviewed draft. Verify claims against the cited primary sources and
any released artifacts before relying on them.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial and validation status.** This draft accompanies warning-fatal
checked source. The complete project gate passes. Professional review remains
pending, so <code>pro_reviewed</code> remains false.
{{< /panel >}}

**Devaney chaos** is a named package for a continuous discrete-time dynamical
system. In the historical three-clause convention, the map is topologically
transitive, its positive-period points are dense, and it has sensitive
dependence on initial conditions.

## Start with a boundary example

Let \(X=\{0,1,2\}\) and rotate the states \(0\mapsto1\mapsto2\mapsto0\).
With the discrete topology, positive iterates connect every ordered pair of
nonempty open sets. Every point is periodic, so periodic points are dense.

The system is not sensitive under the discrete metric. A ball of radius
\(1/2\) contains only its center, leaving no distinct nearby point that can
separate. Thus the first two dynamical clauses do not imply the third on every
metric space. This counterexample identifies the missing infinitude boundary.

{{< reference-figure
  src="devaney-three-clauses.svg"
  alt="A three-state cycle passes transitivity and dense periodicity, but a singleton neighborhood blocks the sensitivity clause."
  caption="**Historical package and boundary:** the finite cycle satisfies the two topological clauses. It fails sensitivity because its small metric balls are singletons. On an infinite genuine metric space, the Banks theorem recovers the third clause from the continuous topological core."
>}}

## Historical and reduced conventions

Devaney's textbook presentation lists all three dynamical conditions. Banks,
Brooks, Cairns, Davis, and Stacey proved that continuity, transitivity, and
dense periodic points imply sensitivity when the metric space is infinite.
Some later sources therefore use a reduced two-clause convention while keeping
continuity in the ambient setup.

The conventions agree only when the Banks hypotheses are available. The
project preserves both:

\[
\operatorname{Core}(f)
=\operatorname{Continuous}(f)
\land\operatorname{Transitive}(f)
\land\overline{\operatorname{Per}(f)}=X,
\]

and

\[
\operatorname{Devaney}(f)
=\operatorname{Core}(f)\land\operatorname{Sensitive}(f).
\]

See [topological transitivity]({{< relref
"/knowledge-base/glossary/topological-transitivity" >}}),
[dense periodic points]({{< relref
"/knowledge-base/glossary/dense-periodic-points" >}}), and
[sensitive dependence]({{< relref
"/knowledge-base/glossary/sensitive-dependence-on-initial-conditions" >}})
for the individual quantifiers.

## In Lean

{{< lean-bridge
  human="The historical package is the continuous transitive core with dense positive-period points, together with metric sensitivity."
  math="\(\operatorname{Devaney}(f)\iff\operatorname{Core}(f)\land\operatorname{Sensitive}(f).\)"
  lean="def HasDevaneyCore [TopologicalSpace X] (f : X → X) : Prop :=\n  Continuous f ∧ IsTopologicallyTransitive f ∧ HasDensePeriodicPoints f\n\ndef IsDevaneyChaotic [PseudoMetricSpace X] (f : X → X) : Prop :=\n  HasDevaneyCore f ∧ IsSensitive f"
>}}
`TopologicalSpace X` suffices for the core. `PseudoMetricSpace X` adds `dist`
for sensitivity. The two `∧` symbols package conjunctions. The theorem
`isDevaneyChaotic_iff_hasDevaneyCore` says the two packages are equivalent when
Lean also has `[MetricSpace X] [Infinite X]`.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.Chaos.Devaney

open NonlinearDynamics.Deterministic.Chaos

#check HasDevaneyCore
#check IsDevaneyChaotic
#check HasDevaneyCore.isSensitive
#check isDevaneyChaotic_iff_hasDevaneyCore
#check not_isDevaneyChaotic_of_finite
~~~

This is a **full project check** on macOS or Linux. It requires the pinned Lean
and Mathlib dependencies and may require substantial initial disk space or
build time.

{{< repo-check >}}
The worksheet inspects both conventions, the Banks bridge, and the exact finite
obstruction.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Chaos/Devaney.lean
```

## What the term does not claim

The term does not by itself select a unique convention across the literature.
It supplies no mixing, minimality, expansivity, entropy bound, Lyapunov
exponent, exponential rate, shadowing property, numerical prediction theorem,
or optimal sensitivity constant. The Banks implication needs an infinite
genuine metric space; it is not a theorem for arbitrary pseudo-metric or finite
spaces.

For the full proof architecture, continue to
[Devaney Chaos, Transitivity, and Dense Periodic Points]({{< relref
"/knowledge-base/deep-dives/devaney-chaos-transitivity-and-dense-periodic-points"
>}}).

## References

- Robert L. Devaney, *An Introduction to Chaotic Dynamical Systems*, second
  edition, Definitions 8.1, 8.2, and 8.5, pp. 49–50.
- John Banks, Jeff Brooks, Grant Cairns, Gary Davis, and Peter Stacey, “On
  Devaney's Definition of Chaos,” *American Mathematical Monthly* 99(4)
  (1992), 332–334. [DOI](https://doi.org/10.1080/00029890.1992.11995856).
