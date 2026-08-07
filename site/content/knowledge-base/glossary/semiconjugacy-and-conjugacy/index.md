---
title: "Semiconjugacy and conjugacy"
slug: "semiconjugacy-and-conjugacy"
summary: "A semiconjugacy maps one update rule into another and may lose information; a conjugacy is an invertible coordinate change that identifies the two dynamics."
draft: false
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Discrete.Conjugacy"
tags:
  - "Discrete dynamics"
  - "Semiconjugacy"
  - "Topological conjugacy"
  - "Factor maps"
  - "Orbit transport"
og_image: "semiconjugacy-and-conjugacy-card.png"
og_image_alt: "A many-to-one map merges four compass directions into two axes, while an invertible map connects two axis labels with Boolean labels in both directions."
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note paired with
warning-fatal checked source. Human review of the mathematics, Lean bridge,
figures, accessibility, and references remains pending. Professional review
has not been performed, so
<code>pro_reviewed</code> remains false.
{{< /panel >}}

A **semiconjugacy** is a map between two state spaces that respects one update
step. A **conjugacy** adds an inverse, so the change of coordinates can be
undone.

Let \(f : X \to X\) and \(g : Y \to Y\). A map
\(\varphi : X \to Y\) semiconjugates
\(f\) to \(g\) when

\[
\varphi(f(x))=g(\varphi(x))
\qquad\text{for every }x\in X.
\]

This relation is directional. It transports a source orbit to a target orbit,
but it does not promise that the source state can be reconstructed.

## Start with a quarter-turn factor

Take four compass directions and update them by a clockwise quarter turn:

\[
\text{north}\mapsto\text{east}\mapsto\text{south}
\mapsto\text{west}\mapsto\text{north}.
\]

Project north and south to the `vertical` axis, and east and west to the
`horizontal` axis. The target update toggles its axis. Updating and then
projecting agrees with projecting and then toggling in all four cases.

The projection is onto: each target axis has a source direction. It is not
one-to-one: north and south share an image, as do east and west. The target
retains axis alternation and loses orientation.

{{< reference-figure
  wide="true"
  src="semiconjugacy-versus-conjugacy.svg"
  alt="The left panel merges north and south into vertical and east and west into horizontal; the right panel maps vertical and horizontal bijectively to false and true with arrows in both directions."
  caption="**The inverse boundary:** semiconjugacy may identify different source states. Conjugacy requires an invertible map. Topological conjugacy adds continuity of both the map and its inverse; it still does not claim that numerical distances are preserved."
>}}

## One step gives every forward iterate

If the one-step square commutes, then for every \(n \in \mathbb N\),

\[
\varphi(f^n(x))=g^n(\varphi(x)).
\]

This follows by induction. The case (n=0) uses identity iterates. The next
case applies the one-step equation after the preceding iterate equality.

The natural-number clock is unchanged. Semiconjugacy is not the broader idea
of orbit equivalence with a time reparameterization.

## Add continuity and surjectivity separately

The algebraic equation alone has no topology. A **topological semiconjugacy**
adds continuity of
\(\varphi\). Continuity is what sends a convergent source orbit
to a convergent target orbit.

A **topological factor map** adds surjectivity as well. Surjectivity says that
every target state has at least one source representative. It is needed when a
transported conclusion quantifies over every target start, such as global
attraction.

Surjectivity does not recover information. The quarter-turn projection is
surjective and still merges opposite directions.

## Conjugacy is reversible

A **topological conjugacy** uses a homeomorphism
\(e : X \simeq_{\mathrm{top}} Y\): a bijection whose forward and inverse maps are continuous.
It satisfies

\[
e(f(x))=g(e(x)).
\]

The inverse homeomorphism semiconjugates \(g\) back to \(f\). This gives
two-way statements for corresponding fixed points, specified periods, point
attraction, basins, and local or global attracting fixed points in the
project module.

The word “specified” matters for periods. `IsPeriodicPt f n p` says that
\(n\) is a period of \(p\), not necessarily its least positive period. A
many-to-one factor can collapse a least period even though it maps every
specified-period point forward.

## In Lean

Mathlib supplies the algebraic predicate; the project adds the topological
packages.

{{< lean-bridge
  human="The coordinate map sends one source update to one target update."
  math="\(\varphi(f(x))=g(\varphi(x))\) for every \(x\in X\)."
  lean="Function.Semiconj φ f g :=\n  ∀ x, φ (f x) = g (φ x)"
>}}
`φ` maps source states to target states. `f` and `g` are the two update rules.
The proposition can be applied to `x` to obtain the displayed equality.
{{< /lean-bridge >}}

The topological interfaces are:

~~~lean
def IsTopologicalSemiconjugacy (φ : X → Y) (f : X → X) (g : Y → Y) : Prop :=
  Continuous φ ∧ Function.Semiconj φ f g

def IsTopologicalFactorMap (φ : X → Y) (f : X → X) (g : Y → Y) : Prop :=
  IsTopologicalSemiconjugacy φ f g ∧ Function.Surjective φ

def IsTopologicalConjugacy (e : X ≃ₜ Y) (f : X → X) (g : Y → Y) : Prop :=
  Function.Semiconj e f g
~~~

`X ≃ₜ Y` is Mathlib's homeomorphism type. Its data include the function, its
inverse, both inverse identities, and continuity in both directions.

## Try it in the repository

Create a reader worksheet containing:

~~~lean
import NonlinearDynamics.Deterministic.Discrete.Conjugacy

#check Function.Semiconj
#check IsTopologicalSemiconjugacy
#check IsTopologicalFactorMap
#check IsTopologicalConjugacy
#check semiconj_iterate_apply
#check IsTopologicalConjugacy.isAttractedTo_iff
~~~

This is a **full project check** using pinned Lean and Mathlib dependencies.
Initial setup may require substantial disk space and build time.

{{< repo-check >}}
The copied checks form a reader worksheet. The authoritative source is
`NonlinearDynamics/Deterministic/Discrete/Conjugacy.lean`; the command below
checks the complete module with the repository's pinned environment.
{{< /repo-check >}}

For a **standalone tutorial**, run the `quarter-turn-factor.lean` file in the
paired Deep Dive. It imports only `Std`, checks the four-state factor, and
constructs an invertible encoding of the two-axis system.

## Boundaries that prevent common mistakes

- A semiconjugacy need not be injective or surjective.
- A factor map is surjective but may remain many-to-one.
- Orbit transport is forward unless inverse data are supplied.
- A bijection without continuity does not transport topological limits.
- A homeomorphism preserves topology, not a selected metric or convergence
  rate.
- A specified period need not be the least positive period.
- Dynamical conjugacy is not matrix similarity, complex conjugation, or
  unitary conjugation.

This chapter establishes no preservation theorem for
{{< refterm "forward-stability" "forward stability" >}}, entropy, mixing,
transitivity, chaos, symbolic coding, structural robustness, measure
conjugacy, stochastic systems, or differential equations. It gives no
algorithm for finding a conjugacy.

Continue with [Conjugacy, Semiconjugacy, and Orbit Transport in Discrete
Time]({{< relref
"/knowledge-base/deep-dives/conjugacy-semiconjugacy-and-orbit-transport-in-discrete-time"
>}}) or inspect the declaration-complete [Research Note]({{< relref
"/development-notebook/2026/08/conjugacies-and-semiconjugacies-for-discrete-systems-in-lean"
>}}).

## References

- Volodymyr Nekrashevych, *Groups and Topological Dynamics*, Graduate Studies
  in Mathematics 223, AMS (2022), Chapter 1, section 1.1, Definition 1.1.4,
  page 7 (author PDF page 10),
  [DOI 10.1090/gsm/223](https://doi.org/10.1090/gsm/223).
- Richard A. Holmgren, *A First Course in Discrete Dynamical Systems*, chapter
  “The Logistic Function, Part II: Topological Conjugacy,” pages 95–103,
  [DOI 10.1007/978-1-4684-0222-3](https://doi.org/10.1007/978-1-4684-0222-3).
- Mathlib 4.32.0, pinned revision `81a5d257`,
  [`Logic.Function.Conjugate`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Logic/Function/Conjugate.lean),
  [`Logic.Function.Iterate`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Logic/Function/Iterate.lean), and
  [`Topology.Homeomorph.Lemmas`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/Homeomorph/Lemmas.lean).
