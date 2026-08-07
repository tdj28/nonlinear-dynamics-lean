---
title: "Dense periodic points"
slug: "dense-periodic-points"
summary: "Every nonempty open set contains a point that returns to itself after some positive number of iterations."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Chaos.Devaney"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Chaos/Devaney.lean"
lean_source_sha256: "52fe20359c5c07407e0d3e319a26e9c2dd593c97f88f1dc6b3acf9adc1abf39f"
tags:
  - "Discrete dynamics"
  - "Periodic points"
  - "Dense sets"
  - "Positive period"
og_image: "dense-periodic-points-card.png"
og_image_alt: "Every illustrated open neighborhood contains a marked periodic point with a positive return loop."
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

A self-map has **dense periodic points** when every nonempty open region
contains a point that returns to itself after a positive number of updates.
The return time may vary from point to point.

## Start with the identity map

Let \(f(x)=x\) on the real line. Every point has positive period one because
\(f^1(x)=x\). Therefore the set of periodic points is all of \(\mathbb R\),
which is dense. For the particular open interval \((2,3)\), the point
\(p=5/2\) lies in the interval and satisfies \(f(p)=p\).

This calculation verifies both requirements for this explicit map but not chaos. The identity map is not
topologically transitive on a space with disjoint nonempty open sets, and it is
not sensitive. Dense periodic points are one clause, not the whole package.

As a non-example, consider \(g(x)=x/2\) on \(\mathbb R\). Its only periodic
point is 0: if \(g^n(x)=x\) for positive \(n\), then \(x/2^n=x\), hence
\(x=0\). The open interval \((1,2)\) contains no periodic point, so the
periodic-point set is not dense.

{{< reference-figure
  src="periodic-points-meet-open-sets.svg"
  alt="Three overlapping open regions each contain a marked periodic point with a return loop; a separate open interval for the contraction contains no periodic mark."
  caption="**Density is an open-set test:** every nonempty open region must contain at least one positive-period point. The identity passes because every point has period one. The contraction fails because the open interval from one to two misses its only periodic point, 0."
>}}

## Pointwise return and set density

A point \(p\in X\) is periodic for \(f:X\to X\) when

\[
\exists n\in\mathbb N,\quad n\gt0\quad\text{and}\quad f^n(p)=p.
\]

Write \(\operatorname{Per}(f)\) for the set of all such points. Density can be
expressed as

\[
\overline{\operatorname{Per}(f)}=X,
\]

or equivalently by the open-set test

\[
\forall U\subseteq X,\quad
U\text{ open and nonempty}
\Longrightarrow U\cap\operatorname{Per}(f)\ne\varnothing.
\]

The period witness is positive. Time zero would make every point satisfy
\(f^0(p)=p\), erasing the dynamical content. A fixed point is still periodic:
its positive period witness is one.

Density does not mean every point is periodic. It says periodic points lie in
every open region. Nor does it give one common period for all selected points.

## In Lean

{{< lean-bridge
  human="The space is nonempty, and every nonempty open set contains a point with some positive return time."
  math="\(X\ne\varnothing\land\overline{\operatorname{Per}(f)}=X.\)"
  lean="def HasDensePeriodicPoints [TopologicalSpace X] (f : X → X) : Prop :=\n  Nonempty X ∧ Dense (periodicPts f)"
>}}
`periodicPts f` is Mathlib's set of points with some positive natural period.
`Dense S` means the closure of `S` is the whole space, with an equivalent
nonempty-open-set witness theorem. `Nonempty X` blocks the empty phase space
from satisfying the package vacuously.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.Chaos.Devaney

open Function
open NonlinearDynamics.Deterministic.Chaos

#check periodicPts
#check HasDensePeriodicPoints
#check HasDensePeriodicPoints.exists_mem_open
#check HasDensePeriodicPoints.exists_isPeriodicPt_mem_open
#check periodicOrbit_eq_of_mem
~~~

This is a **full project check** on macOS or Linux. It requires the repository's
pinned Lean and Mathlib dependencies and may require substantial initial disk
space or build time.

{{< repo-check >}}
The worksheet inspects Mathlib's positive-period set, both open-set witness
forms, and the theorem identifying cycles that share a point.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Chaos/Devaney.lean
```

## Common confusions

| Confusion | Correction |
|---|---|
| One periodic orbit was found. | One orbit need not meet every nonempty open set. |
| Every point must be periodic. | Density permits nonperiodic points. |
| All periodic points share one period. | Each point may have its own positive period. |
| Fixed points do not count. | Period one is positive, so fixed points count. |
| Time zero is a period. | The selected convention requires a positive period. |
| Dense periodic points imply chaos. | Transitivity and sensitivity are separate obligations. |

## What the term does not claim

Dense periodic points supply no continuity, transitivity, sensitivity, mixing,
minimality, common period, recurrence frequency, entropy bound, or rate of
return. The property does not say that periodic points have positive measure
or that a randomly selected state is periodic.

## References

- Robert L. Devaney, *An Introduction to Chaotic Dynamical Systems*, second
  edition, Definition 8.2, p. 49.
- John Banks, Jeff Brooks, Grant Cairns, Gary Davis, and Peter Stacey, “On
  Devaney's Definition of Chaos,” *American Mathematical Monthly* 99(4)
  (1992), 332–334. [DOI](https://doi.org/10.1080/00029890.1992.11995856).
