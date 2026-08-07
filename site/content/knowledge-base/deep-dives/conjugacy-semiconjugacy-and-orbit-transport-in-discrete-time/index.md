---
title: "Conjugacy, Semiconjugacy, and Orbit Transport in Discrete Time"
slug: "conjugacy-semiconjugacy-and-orbit-transport-in-discrete-time"
summary: "Begin with a four-state factor, derive all-iterate transport, then add continuity, surjectivity, and an invertible coordinate change one gate at a time."
lead: "Two update rules can share the same visible orbit pattern even when one description forgets source information. Semiconjugacy records the shared pattern; conjugacy adds a reversible change of coordinates."
draft: false
pro_reviewed: false
toc: true
level: "Intermediate"
reading_time: "40 to 55 minutes"
prerequisites:
  - "Orbit and iterate"
  - "Function composition and inverse functions"
  - "Continuity and homeomorphisms"
lean_module: "NonlinearDynamics.Deterministic.Discrete.Conjugacy"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Discrete/Conjugacy.lean"
lean_source_sha256: "d0ed8eadee33f2716210e12a57a15a51fc08e37a6bdab1f8d5039062d9fa9d34"
tags:
  - "Discrete dynamics"
  - "Semiconjugacy"
  - "Topological conjugacy"
  - "Factor maps"
  - "Orbit transport"
  - "Lean 4"
og_image: "conjugacy-semiconjugacy-and-orbit-transport-card.png"
og_image_alt: "A four-direction cycle projects onto a two-axis toggle, separating a factor that forgets orientation from an invertible coordinate change."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this Deep Dive. The author selected the questions and remains
  responsible for the final text and claims. This is an independent,
  non-peer-reviewed Deep Dive. Verify claims against the cited primary sources
  and released Lean source before relying on them.
---

{{< panel "warning" >}}
**Editorial status.** This is an AI-assisted public working note paired with
warning-fatal checked source. Human review of the mathematics, Lean examples,
figures, accessibility, and references remains pending. Professional review
has not been performed, so
<code>pro_reviewed</code> remains false.
{{< /panel >}}

## Start with a four-state factor

Consider the clockwise cycle

\[
\text{north}\mapsto\text{east}\mapsto\text{south}
\mapsto\text{west}\mapsto\text{north}.
\]

Now keep only the axis. North and south become `vertical`; east and west
become `horizontal`. The target update toggles between these two labels.

| source state | source next | projected state | target next |
|---|---|---|---|
| north | east | vertical | horizontal |
| east | south | horizontal | vertical |
| south | west | vertical | horizontal |
| west | north | horizontal | vertical |

Every row says that update-then-project agrees with
project-then-update. Because the rows exhaust the source type, they establish
the one-step relation for this finite model.

{{< reference-figure
  wide="true"
  src="four-state-factor.svg"
  alt="A clockwise four-cycle of north, east, south, and west projects onto a two-cycle of vertical and horizontal axes; opposite directions share each target image."
  caption="**A many-to-one factor:** the target retains alternation between axes. It cannot recover orientation because north and south both map to vertical, while east and west both map to horizontal. Surjectivity does not imply injectivity."
>}}

This is a semiconjugacy. It is also a factor in the finite discrete topology
because the projection is continuous and onto. It is not a conjugacy: there
is no inverse that reconstructs which opposite direction was present.

## Read the commuting equation

Let \(f : X \to X\) and \(g : Y \to Y\) be update rules. A map
\(\varphi : X \to Y\) **semiconjugates** \(f\) to \(g\) when

\[
\varphi\circ f=g\circ\varphi.
\]

Evaluated at \(x \in X\), this is

\[
\varphi(f(x))=g(\varphi(x)).
\]

The equation has a direction. It sends source dynamics through
\(\varphi\) to target dynamics. Nothing in it says that
\(\varphi\) is
continuous, injective, or surjective.

{{< lean-bridge
  human="Applying the source update and then the coordinate map gives the same target state as applying the coordinate map first and then the target update."
  math="\(\varphi(f(x))=g(\varphi(x))\) for every \(x\in X\)."
  lean="Function.Semiconj φ f g :=\n  ∀ x, φ (f x) = g (φ x)"
>}}
`Semiconj` comes from Mathlib. The first argument is the map between state
spaces. The next two arguments are the source and target self-maps. A proof
can be applied directly to a state `x`.
{{< /lean-bridge >}}

## Repeat the square along the orbit

One commuting square gives all natural-number iterates:

\[
\varphi(f^n(x))=g^n(\varphi(x)).
\]

At time zero, both sides reduce to
\(\varphi(x)\). For the induction step,
apply the one-step equation after the induction hypothesis. Mathlib already
packages this induction as `Semiconj.iterate_right`; the project theorem
`semiconj_iterate_apply` exposes the evaluated identity.

{{< reference-figure
  wide="true"
  src="iterate-ladder.svg"
  alt="At times zero through four, the source row cycles north, east, south, west, north and the target row toggles vertical, horizontal, vertical, horizontal, vertical; a projection arrow joins each column."
  caption="**Synchronized time:** every column is one instance of the iterate identity. The factor changes the state description, not the natural-number clock. It is not an orbit equivalence with time reparameterization."
>}}

The ladder also explains a limitation. The target sequence records only axes.
It cannot distinguish the north start from the south start. All-iterate
transport does not undo information loss.

## Add topology only when limits enter

An orbit approaching a point is a topological statement. Suppose

\[
f^n(x)\longrightarrow p.
\]

The algebraic identity identifies the projected sequence, but the conclusion

\[
g^n(\varphi(x))\longrightarrow\varphi(p)
\]

also needs
\(\varphi\) to be continuous at \(p\). This is the exact split in
`IsAttractedTo.map_semiconj`: one hypothesis supplies the limit, one supplies
continuity at the limit point, and one supplies orbit intertwining.

The definition `IsTopologicalSemiconjugacy` packages global continuity with
the algebraic relation. Its method `map_isAttractedTo` uses continuity at the
needed point. It does not add surjectivity.

A **topological factor map** adds surjectivity. That gate matters for a global
claim about every target start. Given \(y \in Y\), surjectivity supplies
\(x \in X\) with
\(\varphi(x)=y\). If every source orbit approaches a fixed
point \(p\), then every target orbit approaches
\(\varphi(p)\). The theorem
`IsTopologicalFactorMap.map_isGloballyAttractingFixedPoint` formalizes this
argument.

## Conjugacy adds a reversible coordinate change

A **homeomorphism** \(e : X \simeq_{\mathrm{top}} Y\) is a bijection with a continuous forward
map and continuous inverse. The project calls it a topological conjugacy when

\[
e(f(x))=g(e(x)).
\]

The inverse satisfies the reverse equation. This is
`IsTopologicalConjugacy.symm`. Specified conjugacies compose through
`IsTopologicalConjugacy.trans`.

In the standalone worksheet, the two axis labels are encoded as `Bool`:
vertical becomes `false`, horizontal becomes `true`. A decoding function
returns the original axis, and both inverse identities are checked by cases.
That finite encoding is invertible and intertwines the two toggles. It models
conjugacy without claiming a nontrivial topological theorem.

At the existential level,

```lean
def AreTopologicallyConjugate (f : X → X) (g : Y → Y) : Prop :=
  ∃ e : X ≃ₜ Y, IsTopologicalConjugacy e f g
```

the source proves reflexivity, symmetry, and transitivity. Those relations
compare systems across possibly different state types.

## What the inverse lets us transport

The source proves the following equivalences for corresponding points:

- fixedness via `IsTopologicalConjugacy.isFixedPt_iff`;
- having a specified natural-number period via
  `IsTopologicalConjugacy.isPeriodicPt_iff`;
- point attraction via `IsTopologicalConjugacy.isAttractedTo_iff`;
- local attraction via
  `IsTopologicalConjugacy.isLocallyAttractingFixedPoint_iff`; and
- global attraction via
  `IsTopologicalConjugacy.isGloballyAttractingFixedPoint_iff`.

The basin identities retain set-level information:

\[
e^{-1}(B_g(e(p)))=B_f(p),
\qquad
e(B_f(p))=B_g(e(p)).
\]

They appear as `IsTopologicalConjugacy.basin_preimage` and
`IsTopologicalConjugacy.image_basin`. The local-attraction proof uses the fact
that a homeomorphism is an open map, so the image of a basin neighborhood is a
neighborhood of the image point.

The specified-period theorem is deliberately narrow. `IsPeriodicPt f n p`
means that \(n\) is a period. It does not say that \(n\) is the least positive
period. Under a noninjective semiconjugacy, a least period may collapse; the
two-way conjugacy theorem only states the exact predicate present in the
source.

## Standalone Lean tutorial

The bundled `quarter-turn-factor.lean` is a **standalone tutorial** importing
only `Std`. It proves the commuting square by cases, proves all-iterate
transport by induction, exhibits noninjectivity, and checks the inverse axis
encoding.

~~~lean
theorem axisOf_directionOrbit (d : Direction) :
    ∀ n, axisOf (directionOrbit d n) = axisOrbit (axisOf d) n := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih =>
      simp only [directionOrbit, axisOrbit, axisOf_quarterTurn, ih]

theorem axisOf_not_injective : ¬Function.Injective axisOf := by
  intro h
  exact north_ne_south (h rfl)
~~~

Run it on macOS or Linux with the pinned compiler:

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/conjugacy-semiconjugacy-and-orbit-transport-in-discrete-time/quarter-turn-factor.lean
```

The worksheet has finite types and recursive natural-number orbits. It does
not define `TopologicalSpace`, continuity, filters, or homeomorphisms.

## Try the full project interface

The following is a **full project check** using pinned Lean and Mathlib
dependencies. Initial setup may require substantial disk space and build time.

~~~lean
import NonlinearDynamics.Deterministic.Discrete.Conjugacy

#check IsTopologicalSemiconjugacy
#check IsTopologicalFactorMap
#check IsTopologicalConjugacy
#check semiconj_iterate_apply
#check IsTopologicalConjugacy.isAttractedTo_iff
#check IsTopologicalConjugacy.image_basin
~~~

{{< repo-check >}}
The copied checks form a reader worksheet. The authoritative source is
`NonlinearDynamics/Deterministic/Discrete/Conjugacy.lean`; the command below
checks the complete module in the repository's pinned environment.
{{< /repo-check >}}

## Boundaries

This interface supplies no preservation theorem for
{{< refterm "forward-stability" "forward stability" >}}, distances,
Lipschitz constants, or rates. Topological conjugacy keeps open sets,
convergence, and neighborhood structure; it need not keep a chosen metric.
The source also proves no entropy, mixing, transitivity, chaos, symbolic
coding, structural stability, parameter robustness, measurable conjugacy,
stochastic statement, ODE result, or algorithm for constructing a conjugacy.

Semiconjugacy is directional. A target conclusion does not lift without
inverse data. A factor map is onto but may remain many-to-one. Dynamical
conjugacy is also distinct from matrix similarity, complex conjugation, and
the unitary-conjugacy orbits used in random-matrix theory.

Continue with the shorter {{< refterm "semiconjugacy-and-conjugacy"
"Semiconjugacy and conjugacy" >}} glossary chapter or inspect the
declaration-complete [Research Note]({{< relref
"/development-notebook/2026/08/conjugacies-and-semiconjugacies-for-discrete-systems-in-lean"
>}}). The next Deep Dive, [Parameter Families, Branches, and Bifurcation in
Discrete Time]({{< relref
"/knowledge-base/deep-dives/parameter-families-branches-and-bifurcation-in-discrete-time"
>}}), uses fixed- and specified-period preservation as conjugacy obstructions.

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
  [`Logic.Function.Iterate`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Logic/Function/Iterate.lean),
  [`Dynamics.FixedPoints.Basic`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/FixedPoints/Basic.lean),
  [`Dynamics.PeriodicPts.Defs`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/PeriodicPts/Defs.lean), and
  [`Topology.Homeomorph.Lemmas`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/Homeomorph/Lemmas.lean).
