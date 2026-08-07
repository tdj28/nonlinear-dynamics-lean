---
title: "Topological transitivity"
slug: "topological-transitivity"
summary: "Every ordered pair of nonempty open sets is connected by a positive iterate of some point from the first set."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Chaos.Devaney"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Chaos/Devaney.lean"
lean_source_sha256: "52fe20359c5c07407e0d3e319a26e9c2dd593c97f88f1dc6b3acf9adc1abf39f"
tags:
  - "Discrete dynamics"
  - "Topological transitivity"
  - "Open sets"
  - "Iterates"
og_image: "topological-transitivity-card.png"
og_image_alt: "A point begins in open set U and a positive iterate lands in open set V, while time zero is crossed out."
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
**Editorial and validation status.** This draft accompanies a warning-fatal
source candidate. Professional review and the complete project gate remain
pending, so <code>pro_reviewed</code> remains false.
{{< /panel >}}

**Topological transitivity** says that the dynamics can carry some point from
any nonempty open region into any other nonempty open region. This project uses
a positive-time convention.

## Start with a three-state cycle

Let \(X=\{0,1,2\}\) have the discrete topology, and rotate
\(0\mapsto1\mapsto2\mapsto0\). Take \(U=\{0\}\) and \(V=\{2\}\). The point
\(x=0\) starts in \(U\), and \(f^2(0)=2\in V\).

The same check works for every ordered pair of nonempty subsets. Pick one state
from each set and move one, two, or three times around the cycle. Because every
subset is open, this exhaustive finite argument establishes topological
transitivity of this explicit system.

The identity map on the same three-state space is a non-example. For the
disjoint open sets \(\{0\}\) and \(\{1\}\), every positive iterate of 0 remains 0.

{{< reference-figure
  src="open-set-transport.svg"
  alt="A point x in open set U follows a curved arrow labeled positive n and lands in open set V; a short time-zero arrow remains inside U and is crossed out."
  caption="**Positive-time transport:** the witness point begins in U, and some positive iterate lies in V. Time zero does not test the update rule and is excluded by this convention."
>}}

## The quantifiers

For a self-map \(f:X\to X\), the project definition is

\[
\forall U,V\subseteq X,\quad
U,V\text{ open and nonempty}
\Longrightarrow
\exists n\gt0\;\exists x\in U,\quad f^n(x)\in V.
\]

Both witnesses may depend on the ordered pair \(U,V\). Reversing the sets is a
new obligation. The definition asks for at least one point and one positive
time; it does not ask every point of \(U\) to enter \(V\).

Equivalent formulations require care. Some texts write
\(f^n(U)\cap V\ne\varnothing\), which expresses the same witness statement.
Generic monoid-action APIs may permit the identity time, and some theorems
relate transitivity to existence of a dense orbit only under additional
topological hypotheses. This entry records the project convention rather than
asserting every formulation is interchangeable without conditions.

## Transitivity is not mixing

Mixing asks that there is a threshold \(N\) after which **every** time
\(n\ge N\) connects \(U\) to \(V\). Transitivity asks for one positive time.
The three-cycle is transitive, but it is not mixing: visits to a selected state
occur only in one congruence class modulo three.

Transitivity is also not minimality. Minimality asks every orbit to be dense,
while transitivity only supplies a suitable witness for each open-set pair.

## In Lean

{{< lean-bridge
  human="For every ordered pair of nonempty open sets, some point in the first enters the second after a positive number of updates."
  math="\(\forall U,V,\ U,V\text{ open nonempty}\Rightarrow\exists n\in\mathbb N_{>0}\;\exists x\in U,\ f^n(x)\in V.\)"
  lean="def IsTopologicallyTransitive [TopologicalSpace X] (f : X → X) : Prop :=\n  Nonempty X ∧\n    ∀ ⦃U V : Set X⦄, IsOpen U → U.Nonempty → IsOpen V → V.Nonempty →\n      ∃ n : ℕ, 0 < n ∧ ∃ x ∈ U, f^[n] x ∈ V"
>}}
`Nonempty X` excludes the empty phase space. Braces around `U V` make them
implicit arguments. `f^[n]` is Mathlib notation for the \(n\)-fold iterate.
The nested `∃` chooses the time and point after receiving the open sets, while
`0 < n` enforces positive time.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.Chaos.Devaney

open NonlinearDynamics.Deterministic.Chaos

#print IsTopologicallyTransitive
#check IsTopologicallyTransitive.exists_pos_iterate_mem
#check HasDevaneyCore.isSensitive
~~~

This is a **full project check** on macOS or Linux. It uses pinned Lean and
Mathlib dependencies and may require substantial initial disk space or build
time.

{{< repo-check >}}
The worksheet prints the quantifiers, checks the public witness theorem, and
shows where transitivity enters the Banks implication.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Chaos/Devaney.lean
```

## What the term does not claim

Transitivity alone supplies no continuity, dense periodic points, sensitivity,
mixing, minimality, surjectivity, entropy bound, recurrence frequency,
equidistribution, or uniform hitting time. The existence of one successful
iterate for each open-set pair does not say that late iterates continue to
hit.

## References

- Robert L. Devaney, *An Introduction to Chaotic Dynamical Systems*, second
  edition, Definition 8.1, p. 49.
- John Banks, Jeff Brooks, Grant Cairns, Gary Davis, and Peter Stacey, “On
  Devaney's Definition of Chaos,” *American Mathematical Monthly* 99(4)
  (1992), 332–334. [DOI](https://doi.org/10.1080/00029890.1992.11995856).
