---
title: "One-Sided Symbolic Coding and the Full Shift in Lean"
slug: "one-sided-symbolic-coding-and-the-full-shift-in-lean"
date: 2026-08-07
weight: -78
author: "tdj28"
summary: "Prefix splicing, periodic completion, and itinerary maps connect Mathlib's full shift to Devaney chaos and topological factor maps."
lead: |
  A symbolic sequence records one letter per update. Finite prefixes describe its neighborhoods, the left shift advances time, and an itinerary turns observations of another system into a sequence. The formal boundary is exact: every itinerary intertwines updates, but only a continuous surjective itinerary is a topological factor map.
key_result: |
  The one-sided full shift over a nontrivial discrete alphabet is Devaney chaotic in the compatible prefix metric. For a finite alphabet this is the customary compact full-shift model. Orbit itineraries are semiconjugacies, with continuity and surjectivity exposed as separate hypotheses.
draft: true
pro_reviewed: false
status: "Warning-fatal source leaf passes; aggregator and full gate pending"
level: "Intermediate topology, discrete dynamics, symbolic sequences, and Lean 4"
reading_time: "35 to 50 minutes"
prerequisites:
  - "Function iteration"
  - "Product topology"
  - "Topological transitivity"
  - "Semiconjugacy and factor maps"
lean_module: "NonlinearDynamics.Deterministic.Chaos.SymbolicCoding"
lean_source: "formalization/NonlinearDynamics/Deterministic/Chaos/SymbolicCoding.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Chaos/SymbolicCoding.lean"
lean_source_sha256: "5cde6756c1fc0dc56a7a66ed5cc559e24a145db1f2a09e8c0e04a9414cf30014"
tags:
  - "Lean 4"
  - "Symbolic dynamics"
  - "Full shift"
  - "Cylinder sets"
  - "Devaney chaos"
  - "Factor maps"
og_image: "one-sided-symbolic-coding-and-the-full-shift-in-lean-card.png"
og_image_alt: "A fixed finite prefix is joined to a free infinite tail, then shifted until the tail becomes the whole visible sequence."
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
**Editorial status.** The warning-fatal source-module check passes on the
pinned project environment. The deterministic aggregator and complete
repository gate remain pending. Professional review has not been performed,
so `pro_reviewed` remains false.
{{< /panel >}}

## Begin with a prefix and a tail

Take the binary prefix `0, 1, 1` and any infinite tail
\(y_0,y_1,y_2,\ldots\). Joining them gives

\[
0, 1, 1, y_0, y_1, y_2,\ldots
\]

After three applications of the left shift, the visible sequence is exactly
the chosen tail. This finite construction is the engine behind open-set
transitivity. Any open neighborhood contains a cylinder that fixes only a
finite prefix. We satisfy that prefix, place a point from the target open set
after it, and shift by a positive time longer than the prefix.

{{< reference-figure
  wide="true"
  src="prefix-splice-and-shift.svg"
  alt="A three-symbol fixed prefix is followed by a free tail; an arrow labeled shift three times removes the prefix and leaves the tail."
  caption="**Prefix splicing:** membership in the source cylinder depends only on the fixed prefix. After the matching positive number of shifts, the selected tail is recovered exactly. This establishes the open-set witness once the source and target cylinders are chosen."
>}}

The source uses the one-sided space \(A^{\mathbb N}\). A point is a function
`ℕ → A`, and the update sends \(x_0x_1x_2\ldots\) to
\(x_1x_2x_3\ldots\). Mathlib already defines the generic monoid-indexed full
shift and finite cylinders. The project specializes that API rather than
introducing a competing shift.

## Cylinder neighborhoods

For \(x\in A^{\mathbb N}\), the prefix cylinder of length \(n\) is

\[
C_n(x)=\{y: y_i=x_i\text{ for every }i\lt n\}.
\]

The length-zero cylinder is the whole space. Longer cylinders contain more
coordinate requirements and are therefore smaller. When (A) has the
discrete topology, prefix cylinders form a basis for the product topology.
The project proves that `prefixCylinder x n` is exactly Mathlib's full-shift
cylinder supported on `Finset.range n`.

This bridge matters. The topology is not an informal statement that two long
strings look alike. It is the product topology already carried by the function
space, with a checked basis theorem and a compatible metric from
`Mathlib.Topology.MetricSpace.PiNat`.

## Periodic completion

Every prefix cylinder also contains a positive-period point. Given a prefix of
length \(n\), repeat the first \(n+1\) symbols forever. The extra symbol makes
the chosen period positive even when \(n=0\). For every \(i\lt n\), reduction
modulo \(n+1\) leaves \(i\) unchanged, so the repeated sequence remains in the
original cylinder. Shifting by (n+1) positions changes no coordinate.

Thus every nonempty open set contains a positive-period point. Together with
prefix splicing and continuity of the shift, this supplies the complete
topological core used by the preceding Devaney milestone.

{{< reference-figure
  wide="true"
  src="periodic-completion-and-itinerary.svg"
  alt="The upper row repeats a finite word to make a periodic sequence; the lower row records labels along an orbit and commutes with one update and one left shift."
  caption="**Two constructions with different jobs:** periodic completion puts a repeating point inside a prefix cylinder. The itinerary records observed orbit labels and satisfies a one-step semiconjugacy equation. Neither construction supplies entropy or an inverse code."
>}}

## Why nontriviality and finiteness differ

If the alphabet has at least two symbols, the sequence space is infinite. With
the compatible prefix metric, the Banks implication upgrades the full shift's
continuous transitive core and dense periodic points to Devaney chaos.

Finiteness is not used by that implication. It supplies a different fact: a
finite discrete alphabet is compact, and an arbitrary product of compact
spaces is compact. The customary finite-alphabet full shift is therefore a
compact Devaney-chaotic model. An infinite discrete alphabet still satisfies
the source's chaoticity theorem, but its full product is not being presented
here as compact.

The singleton alphabet is the opposite boundary. Its sequence space has one
point, so the shift cannot be sensitive. This is why `Nontrivial A`, rather
than mere nonemptiness, appears at the Devaney endpoint.

## Itineraries are directional codes

Let \(f:X\to X\) be any self-map and let \(\ell:X\to A\) be an observable. The
itinerary of (x) is

\[
I_{f,\ell}(x)_n=\ell(f^n(x)).
\]

The identity

\[
I_{f,\ell}(f(x))=\sigma(I_{f,\ell}(x))
\]

is algebraic. It requires neither topology nor continuity. It says that
observing after one source update produces the same sequence as shifting the
existing observation record once.

A topological claim needs more. If both (f) and (ell) are continuous,
every itinerary coordinate is continuous and the product map is continuous.
This gives a topological semiconjugacy. To call the itinerary a topological
factor map onto the full shift, the source requires a separate proof that the
itinerary is surjective. No such proof is inferred from the one-step equation.

The head observable on the full shift reads coordinate zero. Its itinerary is
literally the original sequence, so this special code is both injective and
surjective. That identity is a boundary check, not a claim that arbitrary
observable codings can reconstruct their source states.

## In Lean

{{< lean-bridge
  human="A finite prefix can be joined to any tail, and shifting by the prefix length recovers that tail exactly."
  math="\(\sigma^k(\operatorname{splice}(u,y,k))=y.\)"
  lean="theorem oneSidedShift_iterate_splicePrefix (stem tail : OneSidedSequence A) (k : ℕ) : (oneSidedShift^[k]) (splicePrefix stem tail k) = tail"
>}}
`oneSidedShift^[k]` is Lean's notation for the `k`th function iterate.
`splicePrefix stem tail k` uses `stem` strictly before coordinate `k` and
uses `tail (i-k)` afterward. The equality is extensional: it is checked at
every natural-number coordinate.
{{< /lean-bridge >}}

{{< lean-bridge
  human="For a nontrivial discrete alphabet, the one-sided full shift is Devaney chaotic in the compatible prefix metric."
  math="\(|A|\ge 2\Longrightarrow\operatorname{Devaney}(\sigma:A^{\mathbb N}\to A^{\mathbb N}).\)"
  lean="theorem oneSidedShift_isDevaneyChaotic [TopologicalSpace A] [DiscreteTopology A] [Nontrivial A] : letI := PiNat.metricSpace (fun _ : ℕ => A); IsDevaneyChaotic (oneSidedShift (A := A))"
>}}
`DiscreteTopology A` makes finite-coordinate cylinders open. `Nontrivial A`
supplies two distinct symbols and hence infinitely many sequences. The local
`PiNat.metricSpace` has the existing product topology, so the earlier Banks
theorem applies without changing the cylinder neighborhoods.
{{< /lean-bridge >}}

{{< lean-bridge
  human="Every itinerary intertwines one source update with one left shift; continuity and surjectivity are separate gates for a topological factor map."
  math="\(I_{f,\ell}\circ f=\sigma\circ I_{f,\ell}.\)"
  lean="theorem itinerary_isTopologicalFactorMap (hf : Continuous f) (hlabel : Continuous label) (hsurj : Surjective (itinerary f label)) : IsTopologicalFactorMap (itinerary f label) f oneSidedShift"
>}}
The first theorem is algebraic. The second theorem adds three independently
visible obligations: source dynamics continuity, observable continuity, and
surjectivity of the complete itinerary map.
{{< /lean-bridge >}}

## Try it in the repository

Create a reader worksheet containing:

~~~lean
import NonlinearDynamics.Deterministic.Chaos.SymbolicCoding

open NonlinearDynamics.Deterministic.Chaos

#check oneSidedShift_iterate_apply
#check prefixCylinder_eq_fullShift_cylinder
#check oneSidedShift_isTopologicallyTransitive
#check oneSidedShift_hasDensePeriodicPoints
#check finiteAlphabet_oneSidedShift_isDevaneyChaotic
#check itinerary_semiconj
#check itinerary_isTopologicalFactorMap
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies; initial setup may require substantial
disk space and build time.

{{< repo-check >}}
The worksheet inspects the shift arithmetic, cylinder bridge, full-shift
Devaney result, and the algebraic versus topological coding boundary.
{{< /repo-check >}}

The literal underlying command is:

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Chaos/SymbolicCoding.lean
```

## Declaration map

| Declaration group | Checked role |
|---|---|
| `OneSidedSequence`, `oneSidedShift`, `oneSidedShift_apply`, `oneSidedShift_iterate_apply` | sequence carrier and exact shift arithmetic |
| `prefixCylinder`, `prefixCylinder_eq_fullShift_cylinder`, `isOpen_prefixCylinder`, `isTopologicalBasis_prefixCylinders` | product-topology neighborhood interface |
| `splicePrefix`, `splicePrefix_apply_of_lt`, `splicePrefix_apply_add`, `splicePrefix_mem_prefixCylinder`, `oneSidedShift_iterate_splicePrefix` | exact finite-prefix and free-tail construction |
| `periodicExtension`, `periodicExtension_apply_of_lt`, `periodicExtension_isPeriodicPt`, `exists_isPeriodicPt_mem_prefixCylinder` | positive-period point in every prefix cylinder |
| `continuous_oneSidedShift` | continuity inherited from Mathlib's shift action |
| `oneSidedShift_isTopologicallyTransitive` | positive-time open-set transport |
| `oneSidedShift_hasDensePeriodicPoints` | density of positive-period points |
| `oneSidedShift_hasDevaneyCore` | continuous topological core |
| `oneSidedShift_isDevaneyChaotic` | Banks endpoint for a nontrivial discrete alphabet |
| `finiteAlphabet_oneSidedShift_isDevaneyChaotic` | customary finite-alphabet specialization |
| `itinerary`, `itinerary_apply`, `itinerary_semiconj` | orbit labels and algebraic coding identity |
| `continuous_itinerary`, `itinerary_isTopologicalSemiconjugacy`, `itinerary_isTopologicalFactorMap` | continuity and surjectivity gates |
| `headSymbol`, `itinerary_oneSidedShift_headSymbol`, `injective_itinerary_oneSidedShift_headSymbol`, `surjective_itinerary_oneSidedShift_headSymbol` | identity-code injective/surjective boundary check |

## Prior work, contribution, and nonclaims

Morse and Hedlund introduced symbolic dynamics as an explicit coding language
for trajectories. Hedlund's later shift-system work made continuous
shift-commuting maps central, and Lind and Marcus give the standard modern
treatment of full shifts, cylinders, codes, factors, and conjugacies. Mathlib
4.32.0 already supplies the ambient monoid-indexed full shift, finite
cylinders, patterns, subshifts, and the compatible metric on natural-indexed
products.

This repository contribution is integration and specialization. It connects
that upstream API to the project's positive-time Devaney interface, formalizes
the prefix-splicing and periodic-completion proofs, and packages itineraries
through the existing semiconjugacy and factor-map definitions.

Not claimed: topological mixing, entropy, a subshift of finite type, a Markov
partition, injectivity of an arbitrary itinerary, existence of a surjective
coding for an arbitrary system, or reconstruction of source states from a
factor code.

## References

1. Marston Morse and Gustav A. Hedlund, “Symbolic Dynamics,” *American Journal
   of Mathematics* 60(4) (1938), 815–866.
   [DOI](https://doi.org/10.2307/2371264).
2. Gustav A. Hedlund, “Endomorphisms and Automorphisms of the Shift Dynamical
   System,” *Mathematical Systems Theory* 3 (1969), 320–375.
   [DOI](https://doi.org/10.1007/BF01691062).
3. Douglas Lind and Brian Marcus, *An Introduction to Symbolic Dynamics and
   Coding*, second edition, Cambridge University Press, 2021, Chapters 1, 6,
   7, and 10. [Publisher record](https://doi.org/10.1017/9781108899727).
4. Mathlib contributors, `Mathlib.Dynamics.SymbolicDynamics.Basic`, version
   4.32.0. [Pinned source](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Dynamics/SymbolicDynamics/Basic.lean).
5. Mathlib contributors, `Mathlib.Topology.MetricSpace.PiNat`, version 4.32.0.
   [Pinned source](https://github.com/leanprover-community/mathlib4/blob/v4.32.0/Mathlib/Topology/MetricSpace/PiNat.lean).

## Discussion

This candidate establishes a formal interface, not a new theorem in symbolic
dynamics. Its value is that the assumptions are executable and reusable:
prefix topology, positive time, positive period, the nontrivial-alphabet
boundary, and the difference between semiconjugacy and a surjective factor are
all visible in theorem types.

The next mathematical expansion should not jump directly to entropy. A
smaller dependency-ordered step is to restrict the ambient full shift to a
closed invariant subshift and expose which prefix-splicing or recurrence
hypotheses recover transitivity and dense periodic points there.
