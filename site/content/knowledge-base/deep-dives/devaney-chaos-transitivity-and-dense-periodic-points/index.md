---
title: "Devaney Chaos, Transitivity, and Dense Periodic Points"
slug: "devaney-chaos-transitivity-and-dense-periodic-points"
summary: "Use a finite cycle to expose the missing infinitude hypothesis, then follow the Banks proof from two periodic orbits to one global sensitivity scale."
lead: "Devaney's three clauses mix topology and metric geometry; the Banks theorem explains when the metric clause follows from the topological core."
draft: true
pro_reviewed: false
toc: true
level: "Intermediate"
reading_time: "40 to 55 minutes"
prerequisites:
  - "Open and dense sets"
  - "Periodic point and orbit"
  - "Metric distance"
  - "Sensitive dependence"
lean_module: "NonlinearDynamics.Deterministic.Chaos.Devaney"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Chaos/Devaney.lean"
lean_source_sha256: "52fe20359c5c07407e0d3e319a26e9c2dd593c97f88f1dc6b3acf9adc1abf39f"
tags:
  - "Discrete dynamics"
  - "Devaney chaos"
  - "Topological transitivity"
  - "Periodic points"
  - "Sensitive dependence"
  - "Lean 4"
og_image: "devaney-chaos-transitivity-and-dense-periodic-points-card.png"
og_image_alt: "Three labeled Devaney clauses point toward a theorem boundary requiring an infinite genuine metric space."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this Deep Dive. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary sources
  and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial and validation status.** This AI-assisted draft accompanies a
warning-fatal Lean source candidate. The leaf and deterministic aggregator
pass, but professional review and the complete project gate remain pending.
Accordingly, <code>pro_reviewed</code> remains false.
{{< /panel >}}

## Learning objectives

After this chapter, you should be able to:

1. test positive-time topological transitivity on a small finite cycle;
2. distinguish a periodic point from density of all periodic points;
3. state Devaney's historical three-clause package;
4. explain why infinitude and a genuine metric are needed in the Banks theorem;
5. follow the distance budget that creates one global sensitivity scale; and
6. read and check the corresponding Lean declarations.

For compact definitions, begin with
{{< refterm "devaney-chaos" "Devaney chaos" >}},
{{< refterm "topological-transitivity" "topological transitivity" >}}, and
{{< refterm "dense-periodic-points" "dense periodic points" >}}. The
[Development Notebook]({{< relref "/development-notebook/2026/08/devaney-chaos-and-the-banks-implication-in-lean" >}})
records the formal design decision and declaration map.

## A cycle that satisfies two clauses but not three

Take \(X=\{0,1,2\}\) with the discrete topology and metric, and define

\[
f(0)=1,\qquad f(1)=2,\qquad f(2)=0.
\]

Every subset is open. Given nonempty open sets \(U,V\subseteq X\), choose
\(u\in U\) and \(v\in V\). Moving around the cycle reaches \(v\) from \(u\)
in one, two, or three updates, so the positive-time transitivity condition
holds. Every point has period three, hence the periodic points equal \(X\)
and are dense.

Sensitivity fails. For any \(x\in X\), the open ball \(B(x,1/2)\) is the
singleton \(\{x\}\). Any candidate \(y\) in that ball equals \(x\), and equal
starts have equal iterates. No positive output-separation scale can work.

This explicit counterexample refutes the theorem without an infinitude
hypothesis. It does not refute Devaney's three-clause definition: the example
fails its sensitivity clause and therefore is not Devaney chaotic.

{{< reference-figure
  src="three-clause-ladder.svg"
  alt="A finite three-cycle passes positive-time transitivity and dense periodicity but stops before sensitivity because singleton metric balls contain no distinct partner."
  caption="**Two clauses are not always three:** the finite cycle supplies positive-time transport and makes every point periodic. Its discrete metric creates singleton neighborhoods, which block sensitivity. Infinitude is therefore a theorem hypothesis, not decorative context."
>}}

## The historical package

For a continuous self-map \(f:X\to X\), Devaney's presentation combines:

1. **topological transitivity:** each ordered pair of nonempty open sets is
   connected by a positive iterate;
2. **dense periodic points:** every nonempty open set contains a point that
   returns after some positive number of iterations; and
3. **sensitive dependence:** one positive metric separation scale works at
   every point and every input radius.

The first two statements make sense with a topology. The third uses a selected
metric. The project calls continuity plus the first two clauses
`HasDevaneyCore`; it calls the core plus sensitivity `IsDevaneyChaotic`.

This split preserves the historical package while making the later Banks
implication stateable. It also prevents a theorem proved for infinite genuine
metric spaces from being silently used on a finite or pseudo-metric space.

## Unpack transitivity carefully

The selected open-set condition is

\[
\forall U,V\subseteq X,\quad
U,V\text{ nonempty and open}
\Longrightarrow
\exists n\in\mathbb N_{\gt0}\;\exists x\in U,\quad f^n(x)\in V.
\]

The point \(x\) and time \(n\) may depend on \(U\) and \(V\). This is not
mixing, which would ask all sufficiently large times to work. It is not
minimality, which asks every orbit to be dense. It is also not the weaker
statement that one selected orbit is dense unless additional hypotheses make
those formulations equivalent.

Positive time matters. If \(U\cap V\ne\varnothing\), time zero always maps a
point of the intersection into \(V\). Allowing that witness would not test the
map. Devaney's stated convention requires a positive iterate, and the Lean
predicate writes `0 < n` explicitly.

## Unpack dense periodic points

A point \(p\) is periodic when

\[
\exists n\in\mathbb N_{\gt0},\qquad f^n(p)=p.
\]

The set of all such points is dense when every nonempty open set contains one.
The period depends on the point and need not be the least positive period.
Fixed points qualify with period one.

Density does not say that every point is periodic. Nor does one periodic orbit
being dense automatically say that all periodic points are dense without
first observing that the orbit itself consists of periodic points. The project
uses Mathlib's `Function.periodicPts f`, whose witness period is positive.

## The Banks construction

Assume now that \(X\) is an infinite metric space and that \(f\) has the
continuous topological core.

First select a periodic point \(p_0\). Its periodic orbit \(P\) is finite.
Infinitude leaves a point outside \(P\), so the open complement of \(P\) is
nonempty. Density supplies a periodic point \(q_0\) there. If the periodic
orbits \(P\) and \(Q\) met, periodic-orbit arithmetic would make them equal,
contradicting \(q_0\notin P\). Hence they are disjoint finite sets.

Because the metric separates distinct points, the finite collection of
distances between \(P\) and \(Q\) has a positive minimum \(r\). Set
\(\delta=r/8\). For any reference state \(x\), at least one of \(P,Q\) remains
at distance at least \(4\delta\) from \(x\); otherwise one point from each
orbit would be less than \(4\delta\) from \(x\), putting them less than
\(8\delta=r\) apart.

Receive a radius \(\varepsilon\gt0\). Density chooses a periodic point \(p\)
inside \(B(x,\min(\varepsilon,\delta))\). Choose \(q\) on a periodic orbit
staying far from \(x\). Continuity makes the conditions

\[
d(f^i(z),f^i(q))\lt\delta,\qquad 0\le i\le n,
\]

simultaneously open, where \(n\) is a positive period of \(p\). Transitivity
then chooses \(y\) near \(x\) whose \(k\)-th iterate enters that open region.
Advance at most \(n\) more steps so the total time \(m\) is divisible by \(n\).
Then \(f^m(p)=p\), while \(f^m(y)\) remains within \(\delta\) of the far orbit.

The four-point triangle inequality yields

\[
d(f^m(p),f^m(y))\gt2\delta.
\]

Therefore \(f^m(x)\) cannot lie within \(\delta\) of both endpoints. Either
\(p\) or \(y\) is the nearby start whose \(m\)-th image is more than
\(\delta\) from \(f^m(x)\). Since \(\delta\) was chosen before \(x\) and
\(\varepsilon\), this is the required global sensitivity scale.

{{< reference-figure
  src="banks-distance-budget.svg"
  alt="Two periodic orbit regions are separated by r equals eight delta; a reference point is far from one orbit, while nearby p and y become more than two delta apart, forcing one to be more than delta from the reference image."
  caption="**Distance budget:** the disjoint periodic orbits fix r equal to eight delta. One orbit is at least four delta from the reference point. After continuity, transitivity, and period alignment, the two nearby candidates are more than two delta apart, so the triangle inequality forces one candidate to separate from the reference by more than delta. The constants provide slack; the theorem does not claim an optimal scale."
>}}

## Why pseudo-metrics are insufficient here

A pseudo-metric allows \(d(a,b)=0\) for distinct points. Two disjoint finite
orbits can therefore have zero separation. The proof step selecting a positive
\(r\) would fail. The historical predicate can still be written on a
`PseudoMetricSpace`, because sensitivity itself is meaningful there, but the
Banks implication is stated on `MetricSpace`.

The theorem also does not require compactness, completeness, separability,
surjectivity, or mixing. The two finite periodic orbits provide all compactness
used in the separation step.

## In Lean

{{< lean-bridge
  human="The continuous positive-time transitive system has a periodic point in every nonempty open set; on an infinite metric space, those data imply sensitivity."
  math="\(\bigl(\operatorname{Continuous}(f)\land\operatorname{Transitive}(f)\land\overline{\operatorname{Per}(f)}=X\bigr)\Longrightarrow\operatorname{Sensitive}(f).\)"
  lean="def HasDevaneyCore [TopologicalSpace X] (f : X → X) : Prop :=\n  Continuous f ∧ IsTopologicallyTransitive f ∧ HasDensePeriodicPoints f\n\ntheorem HasDevaneyCore.isSensitive [MetricSpace X] [Infinite X]\n    {f : X → X} (h : HasDevaneyCore f) : IsSensitive f"
>}}
`TopologicalSpace X` is sufficient for the core. `MetricSpace X` strengthens
the ambient structure for the implication, and `[Infinite X]` records the
finite-cycle boundary. `periodicPts f` inside `HasDensePeriodicPoints` uses
positive natural periods. The method-style theorem name means a proof `h` of
the core can be followed by `h.isSensitive`.
{{< /lean-bridge >}}

## Try it in the repository

Create a reader worksheet containing:

~~~lean
import NonlinearDynamics.Deterministic.Chaos.Devaney

open NonlinearDynamics.Deterministic.Chaos

#print IsTopologicallyTransitive
#print HasDensePeriodicPoints
#check HasDensePeriodicPoints.exists_isPeriodicPt_mem_open
#check periodicOrbit_eq_of_mem
#check HasDevaneyCore.isSensitive
#check IsDevaneyChaotic.perfectSpace
~~~

This is a **full project check** on macOS or Linux. It requires the repository's
pinned Lean and Mathlib dependencies, whose initial setup may use substantial
disk space or build time.

{{< repo-check >}}
The worksheet inspects the positive-time and positive-period definitions, the
open-set periodic witness, the orbit-cycle lemma, the Banks implication, and
the no-isolated-points consequence.
{{< /repo-check >}}

The literal underlying command is:

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Chaos/Devaney.lean
```

The command checks the complete Mathlib-backed source. The displayed finite
cycle is a paper example used to expose the theorem boundary; it is not a
standalone formalization of finite topological dynamics.

## Nearby properties

| Property | Main quantifier | Not supplied by the Devaney core alone |
|---|---|---|
| Transitivity | some positive time connects each ordered pair of nonempty open sets | late-time persistence |
| Mixing | every sufficiently large time connects the open sets | follows neither from the definition nor this theorem |
| Dense periodic points | every nonempty open set contains some positive-period point | every point periodic |
| Sensitivity | one positive metric scale works in every neighborhood | rate or persistent separation |
| Minimality | every orbit is dense | periodic points usually obstruct nontrivial minimality |
| Positive entropy | orbit-complexity growth | no entropy estimate appears here |

## What this chapter establishes and what it does not

The three-cycle calculation establishes the necessity of an infinitude
boundary for the unrestricted implication. The Banks argument establishes
sensitivity from the continuous topological core on an infinite genuine metric
space. The Lean module checks a formal statement of that implication against
the pinned kernel after elaboration.

Neither the example, figure, nor formal theorem establishes mixing, minimality,
expansivity, positive entropy, a Lyapunov exponent, exponential divergence,
optimal sensitivity constants, numerical unpredictability, metric invariance
on arbitrary noncompact spaces, or equivalence among every convention bearing
the word chaos.

## References

- Robert L. Devaney, *An Introduction to Chaotic Dynamical Systems*, second
  edition, CRC Press, 2003 reprint of the 1989 edition, pp. 49–50.
  [Publisher record](https://www.routledge.com/An-Introduction-To-Chaotic-Dynamical-Systems/Devaney/p/book/9780813340852).
- John Banks, Jeff Brooks, Grant Cairns, Gary Davis, and Peter Stacey, “On
  Devaney's Definition of Chaos,” *American Mathematical Monthly* 99(4)
  (1992), 332–334.
  [DOI](https://doi.org/10.1080/00029890.1992.11995856).
- Bhishan Jacelon, “Chaotic tracial dynamics,” *Forum of Mathematics, Sigma*
  11 (2023), e53. [DOI](https://doi.org/10.1017/fms.2023.38).
- Benjamin Vejnar, “Topological dynamics and chaos,” *Bulletin of Symbolic
  Logic* (2026), online publication.
  [DOI](https://doi.org/10.1017/bsl.2026.10158).
