---
title: "Symbolic dynamics"
slug: "symbolic-dynamics"
summary: "Symbolic dynamics represents a state by a sequence of letters and advances time with a shift, while coding maps determine how another system is related to that sequence model."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Chaos.SymbolicCoding"
tags: ["Symbolic dynamics", "Full shift", "Itineraries", "Discrete dynamics"]
og_image: "symbolic-dynamics-card.png"
og_image_alt: "Orbit states receive successive labels that form a one-sided sequence, and one update corresponds to one left shift."
---

{{< panel "warning" >}}
**Editorial and validation status.** The warning-fatal source-module check
passes. Professional review and the complete project gate remain pending, so
<code>pro_reviewed</code> remains false.
{{< /panel >}}

**Symbolic dynamics** studies sequences of symbols together with shift maps.
For a one-sided alphabet \(A\), a state is a function \(x:\mathbb N\to A\),
and the left shift is

\[
(\sigma x)_n=x_{n+1}.
\]

## A checkable example

For the binary sequence

\[
x=0,1,1,0,1,\ldots,
\]

one shift gives \(\sigma x=1,1,0,1,\ldots\). Two shifts give
\(\sigma^2x=1,0,1,\ldots\). In general,
\((\sigma^k x)_n=x_{k+n}\).

The **full shift** contains every sequence in \(A^{\mathbb N}\). A **subshift**
is a closed shift-invariant subset. These are different state spaces even when
they use the same alphabet and shift formula.

{{< reference-figure
  src="orbit-labels-to-sequence.svg"
  alt="Four successive orbit states point downward to four labels, which are arranged as the coordinates of a one-sided sequence."
  caption="**Orbit coding:** an observable assigns one symbol at each forward time. The resulting itinerary intertwines one source update with one left shift, but it need not be onto or one-to-one."
>}}

## Coding another system

Given \(f:X\to X\) and an observable \(\ell:X\to A\), the itinerary is

\[
I(x)_n=\ell(f^n(x)).
\]

It always satisfies \(I(f(x))=\sigma(I(x))\). This is a semiconjugacy equation.
Continuity of \(f\) and \(\ell\) makes \(I\) continuous. Surjectivity of \(I\)
is an additional requirement for a topological factor map. Injectivity and a
continuous inverse are further requirements for topological conjugacy.

## In Lean

{{< lean-bridge
  human="The itinerary records one observable value at each forward iterate and intertwines updates with the left shift."
  math="\(I_{f,\ell}(x)_n=\ell(f^n(x)),\quad I_{f,\ell}\circ f=\sigma\circ I_{f,\ell}.\)"
  lean="theorem itinerary_semiconj (f : X → X) (label : X → A) : Function.Semiconj (itinerary f label) f oneSidedShift"
>}}
The iterate notation `f^[n]` includes time zero. The semiconjugacy theorem is
algebraic and does not assert continuity, surjectivity, or invertibility.
{{< /lean-bridge >}}

This is a **full project check** using the repository's pinned Lean and Mathlib
dependencies:

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Chaos/SymbolicCoding.lean
```

Continue to the
[Deep Dive]({{< relref "/knowledge-base/deep-dives/one-sided-full-shifts-cylinders-and-itineraries" >}})
for cylinders, periodic completion, and the full-shift Devaney theorem.

## References

- Marston Morse and Gustav A. Hedlund, “Symbolic Dynamics,” *American Journal
  of Mathematics* 60(4) (1938), 815–866.
  [DOI](https://doi.org/10.2307/2371264).
- Douglas Lind and Brian Marcus, *An Introduction to Symbolic Dynamics and
  Coding*, second edition, Cambridge University Press, 2021.
  [Publisher record](https://doi.org/10.1017/9781108899727).
- Mathlib contributors,
  [`SymbolicDynamics.Basic`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/SymbolicDynamics/Basic.lean),
  version 4.32.0.
