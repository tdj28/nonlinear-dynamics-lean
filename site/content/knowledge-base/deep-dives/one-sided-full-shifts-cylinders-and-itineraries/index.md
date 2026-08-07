---
title: "One-Sided Full Shifts, Cylinders, and Itineraries"
slug: "one-sided-full-shifts-cylinders-and-itineraries"
summary: "Build the full shift from prefix neighborhoods, then separate the automatic itinerary equation from continuity, surjectivity, and invertibility."
lead: "A finite prefix controls a neighborhood, a repeated prefix supplies a periodic point, and an itinerary records orbit labels without automatically preserving all source information."
draft: true
pro_reviewed: false
toc: true
level: "Intermediate"
reading_time: "35 to 50 minutes"
prerequisites:
  - "Function iteration"
  - "Product topology"
  - "Semiconjugacy"
lean_module: "NonlinearDynamics.Deterministic.Chaos.SymbolicCoding"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Chaos/SymbolicCoding.lean"
lean_source_sha256: "5cde6756c1fc0dc56a7a66ed5cc559e24a145db1f2a09e8c0e04a9414cf30014"
tags:
  - "Symbolic dynamics"
  - "Full shift"
  - "Cylinder sets"
  - "Itineraries"
  - "Factor maps"
  - "Lean 4"
og_image: "one-sided-full-shifts-cylinders-and-itineraries-card.png"
og_image_alt: "Three nested prefix cylinders lead to a shift, while a separate commuting square distinguishes orbit coding from an invertible coordinate change."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this Deep Dive. The author selected the questions, shaped the
  exposition, has inspected the sources and artifacts cited here, and is
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary sources
  and any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial and validation status.** The warning-fatal source-module check
passes. The deterministic aggregator, complete project gate, and professional
review remain pending, so <code>pro_reviewed</code> remains false.
{{< /panel >}}

## Learning objectives

After this chapter, you should be able to:

1. read a one-sided sequence as a function from natural-number time to an alphabet;
2. use finite prefix cylinders as product-topology neighborhoods;
3. construct transitive and periodic witnesses for the full shift;
4. explain why a nontrivial alphabet and a finite alphabet play different roles;
5. derive the itinerary semiconjugacy equation; and
6. identify the extra hypotheses needed for a factor map or invertible coding.

Begin with {{< refterm "symbolic-dynamics" "symbolic dynamics" >}},
{{< refterm "cylinder-set" "cylinder sets" >}}, and
{{< refterm "semiconjugacy-and-conjugacy" "semiconjugacy and conjugacy" >}}.
The [Development Notebook]({{< relref "/development-notebook/2026/08/one-sided-symbolic-coding-and-the-full-shift-in-lean" >}})
contains the complete declaration map and source decision record.

## A sequence is a state, not a finite sample

Fix an alphabet \(A\). A one-sided symbolic state is an entire function
\(x:\mathbb N\to A\), written

\[
x=x_0x_1x_2x_3\ldots
\]

The left shift \(\sigma\) removes the first visible symbol:

\[
(\sigma x)_n=x_{n+1}.
\]

After \(k\) updates, \((\sigma^k x)_n=x_{k+n}\). This exact index identity is
the arithmetic used by both the splicing and itinerary arguments.

The state is not a finite word. A finite word specifies only a neighborhood of
states that share those coordinates. Confusing the word with the full sequence
would collapse topology and state representation into one object.

## Prefix cylinders form the local geometry

The length-\(n\) cylinder around \(x\) is

\[
C_n(x)=\{y\mid \forall i\lt n,\ y_i=x_i\}.
\]

The product topology says that a neighborhood constrains only finitely many
coordinates. For natural-number indices and a discrete alphabet, initial
segments suffice: every open set containing \(x\) contains some \(C_n(x)\).

{{< reference-figure
  wide="true"
  src="nested-prefix-cylinders.svg"
  alt="Three nested rounded regions represent all sequences, sequences beginning with zero, and sequences beginning with zero one; each additional fixed symbol gives a smaller cylinder."
  caption="**Cylinder basis:** the whole sequence space contains the prefix-zero cylinder, which contains the prefix-zero-one cylinder. Longer prefixes impose more coordinate equalities. The regions describe set inclusion, not metric area."
>}}

Mathlib's general cylinder accepts any finite coordinate support. The project
prefix cylinder uses `Finset.range n` and proves those definitions equal. That
bridge lets the proof use the convenient `PiNat` basis without disconnecting
from Mathlib's symbolic-dynamics API.

## Transitivity by exact splicing

Let \(U\) and \(V\) be nonempty open sets. Choose \(x\in U\) and a prefix
cylinder \(C_n(z)\subseteq U\). Choose \(y\in V\). Form a sequence whose first
\(n+1\) coordinates come from \(z\) and whose remaining coordinates are the
tail \(y\).

The new sequence lies in \(C_{n+1}(z)\subseteq C_n(z)\subseteq U\). After
\(n+1\) shifts it equals \(y\), hence lies in \(V\). The positive time is built
into the use of \(n+1\), including when the basis cylinder has length zero.

This proves topological transitivity. It does not prove mixing, because the
construction supplies one selected time rather than every sufficiently large
time.

## Periodic points by repeating a block

Given \(C_n(x)\), repeat the first \(n+1\) entries of \(x\). Reduction modulo
\(n+1\) leaves every index below \(n\) unchanged, so the repeated sequence lies
in the cylinder. Shifting by \(n+1\) positions returns the same sequence.

Because every nonempty open set contains a prefix cylinder, every nonempty
open set contains a positive-period point. This establishes density of
periodic points. The construction supplies a period, not necessarily the least
period.

Continuity, transitivity, and dense periodic points give the Devaney core. For
a nontrivial alphabet the sequence space is infinite, and the compatible
prefix metric allows the Banks theorem to supply sensitivity.

## Compactness is a separate finite-alphabet fact

Two symbols already give infinitely many one-sided sequences, which is the
infinitude needed by the Banks implication. An alphabet may be nontrivial and
infinite, so nontriviality does not imply compactness.

When \(A\) is finite and discrete, \(A\) is compact. The product
\(A^{\mathbb N}\) is compact by the product compactness theorem. The finite hypothesis
therefore locates the familiar compact full shift. It is not secretly used to
prove transitivity or dense periodic points.

## The itinerary square

For a self-map \(f:X\to X\) and observable \(\ell:X\to A\), define

\[
I(x)_n=\ell(f^n(x)).
\]

Then \(I(f(x))_n=\ell(f^{n+1}(x))=(\sigma I(x))_n\). Coordinatewise equality
gives the commuting square \(I\circ f=\sigma\circ I\).

{{< reference-figure
  wide="true"
  src="itinerary-factor-gates.svg"
  alt="A commuting square maps source states through f and itinerary to shifted sequences; three labeled gates below distinguish algebraic semiconjugacy, continuity, and surjectivity."
  caption="**Coding gates:** the commuting square is automatic from the itinerary definition. Continuity makes it a topological semiconjugacy. Surjectivity is an additional obligation for a factor map. Injectivity and a continuous inverse are further obligations for conjugacy."
>}}

The algebraic equation does not say that every symbolic sequence occurs as an
itinerary. It also does not say that two source points with the same itinerary
are equal. Those are surjectivity and injectivity questions about the complete
map \(I:X\to A^{\mathbb N}\).

If \(f\) and \(\ell\) are continuous, each coordinate
\(x\mapsto\ell(f^n(x))\) is continuous. The universal property of the product
topology then makes \(I\) continuous. Adding surjectivity yields the project's
`IsTopologicalFactorMap`. An inverse code remains outside that structure.

## In Lean

{{< lean-bridge
  human="Prefix cylinders form a basis, and every such cylinder contains a positive-period point."
  math="\(\forall x,n\;\exists p\in C_n(x)\;\exists k\gt0,\ \sigma^k(p)=p.\)"
  lean="theorem exists_isPeriodicPt_mem_prefixCylinder (x : OneSidedSequence A) (n : ℕ) : ∃ p ∈ prefixCylinder x n, ∃ k : ℕ, 0 < k ∧ IsPeriodicPt oneSidedShift k p"
>}}
The two existential witnesses are the repeated sequence and the positive block
length `n + 1`. `IsPeriodicPt` records a specified period, not minimality.
{{< /lean-bridge >}}

{{< lean-bridge
  human="A continuous surjective itinerary is a topological factor map onto the one-sided full shift."
  math="\(I\circ f=\sigma\circ I,\ I\text{ continuous and onto}.\)"
  lean="theorem itinerary_isTopologicalFactorMap (hf : Continuous f) (hlabel : Continuous label) (hsurj : Surjective (itinerary f label)) : IsTopologicalFactorMap (itinerary f label) f oneSidedShift"
>}}
The theorem does not attempt to manufacture `hsurj`. A concrete coding
application must establish that every target sequence has a source preimage.
{{< /lean-bridge >}}

## Try it in the repository

~~~lean
import NonlinearDynamics.Deterministic.Chaos.SymbolicCoding

open NonlinearDynamics.Deterministic.Chaos

#print prefixCylinder
#check isTopologicalBasis_prefixCylinders
#check exists_isPeriodicPt_mem_prefixCylinder
#check oneSidedShift_isDevaneyChaotic
#check itinerary_semiconj
#check itinerary_isTopologicalFactorMap
~~~

This is a **full project check** on macOS or Linux. It requires the repository's
pinned Lean and Mathlib dependencies, whose initial setup may require
substantial disk space or build time.

{{< repo-check >}}
The worksheet inspects the topology, periodic construction, full-shift chaos,
and the separate coding gates.
{{< /repo-check >}}

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Chaos/SymbolicCoding.lean
```

## What is and is not established

| Statement | Status in this module |
|---|---|
| shift continuity | established |
| prefix cylinders form a basis | established |
| positive-time transitivity of the full shift | established |
| dense positive-period points | established |
| Devaney chaos for a nontrivial discrete alphabet | established through the Banks theorem |
| compactness for the finite-alphabet setting | supplied by existing typeclass theory, not a new theorem here |
| every itinerary is a semiconjugacy | established |
| every itinerary is continuous | false without continuity hypotheses |
| every itinerary is onto | not claimed |
| every itinerary is invertible | not claimed |
| mixing or positive entropy | not claimed |

## References

- Marston Morse and Gustav A. Hedlund, “Symbolic Dynamics,” *American Journal
  of Mathematics* 60(4) (1938), 815–866.
  [DOI](https://doi.org/10.2307/2371264).
- Gustav A. Hedlund, “Endomorphisms and Automorphisms of the Shift Dynamical
  System,” *Mathematical Systems Theory* 3 (1969), 320–375.
  [DOI](https://doi.org/10.1007/BF01691062).
- Douglas Lind and Brian Marcus, *An Introduction to Symbolic Dynamics and
  Coding*, second edition, Cambridge University Press, 2021, Chapters 1, 6,
  7, and 10. [Publisher record](https://doi.org/10.1017/9781108899727).
- Mathlib contributors,
  [`SymbolicDynamics.Basic`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/SymbolicDynamics/Basic.lean)
  and [`PiNat`](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Topology/MetricSpace/PiNat.lean), version 4.32.0.
