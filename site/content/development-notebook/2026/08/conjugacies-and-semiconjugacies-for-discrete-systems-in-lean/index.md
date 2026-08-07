---
title: "Conjugacies and Semiconjugacies for Discrete Systems in Lean"
slug: "conjugacies-and-semiconjugacies-for-discrete-systems-in-lean"
date: 2026-08-06
weight: -76
author: "tdj28"
summary: "A discrete conjugacy interface separates orbit intertwining, continuous semiconjugacy, surjective factor maps, and invertible topological coordinate changes."
lead: |
  A projection may preserve every update while forgetting which source state produced the target state. A conjugacy crosses the boundary from one-way orbit transport to an invertible coordinate change. This milestone records the algebraic, topological, and surjectivity gates separately.
key_result: |
  Every semiconjugacy intertwines all natural-number iterates. Continuity transports point attraction forward, surjectivity lets a factor inherit a global attracting fixed point, and a homeomorphic conjugacy identifies fixed points, specified periods, point basins, and local and global attraction in both directions.
draft: false
pro_reviewed: false
status: "Warning-fatal formal validation passed; human editorial, scientific-integrity, and expert-reader review remain pending"
level: "Intermediate function iteration, topology, filters, homeomorphisms, and Lean 4"
reading_time: "50 to 70 minutes"
prerequisites:
  - "Orbit and iterate"
  - "Function composition and inverse functions"
  - "Continuity and homeomorphisms"
lean_module: "NonlinearDynamics.Deterministic.Discrete.Conjugacy"
lean_source: "formalization/NonlinearDynamics/Deterministic/Discrete/Conjugacy.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Discrete/Conjugacy.lean"
lean_source_sha256: "d0ed8eadee33f2716210e12a57a15a51fc08e37a6bdab1f8d5039062d9fa9d34"
tags:
  - "Lean 4"
  - "Discrete dynamics"
  - "Semiconjugacy"
  - "Topological conjugacy"
  - "Factor maps"
  - "Orbit transport"
og_image: "conjugacies-and-semiconjugacies-for-discrete-systems-in-lean-card.png"
og_image_alt: "A commuting square maps a north-to-east quarter turn onto a vertical-to-horizontal axis toggle, beside the statement that one step controls every iterate."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this note. The author selected the scope, approved the formal-check
workflow, and remains responsible for the statements, sources, and released
artifacts. This is an independent, non-peer-reviewed Research Note.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial status.** This is a public working note paired with warning-fatal
checked source. Human editorial and expert review remain pending. The
configured professional review has not been performed, and `pro_reviewed`
remains false.
{{< /panel >}}

## Start with a projection that forgets direction

Let four compass directions update by one clockwise quarter turn:

| current | next | axis | next axis |
|---|---|---|---|
| north | east | vertical | horizontal |
| east | south | horizontal | vertical |
| south | west | vertical | horizontal |
| west | north | horizontal | vertical |

Project north and south to `vertical`, and east and west to `horizontal`.
The target system toggles its axis. For every direction \(d\),

\[
\operatorname{axis}(\operatorname{turn}(d))
{} =
\operatorname{toggle}(\operatorname{axis}(d)).
\]

The four rows exhaust the finite source type, so the calculation establishes
this equation for the model. North and south have the same image, however.
The projection retains the axis alternation and discards orientation.

{{< reference-figure
  wide="true"
  src="commuting-square.svg"
  alt="North turns to east across the top while vertical toggles to horizontal across the bottom; projecting at either endpoint makes both routes finish at horizontal."
  caption="**The one-step square commutes:** update then project agrees with project then update. The dashed projection is many-to-one, so this figure explains semiconjugacy rather than conjugacy."
>}}

The accompanying Deep Dive packages this model as a **standalone tutorial**
using only Lean and `Std`. The project module begins with Mathlib's general
`Function.Semiconj` relation instead of defining a second algebraic predicate.

## Four interfaces, not one overloaded word

For maps \(f : X \to X\), \(g : Y \to Y\), and
\(\varphi : X \to Y\), the algebraic relation is

\[
\varphi(f(x))=g(\varphi(x))\qquad(x\in X).
\]

Mathlib names it `Function.Semiconj φ f g`. The new module then records three
topological refinements and one existential relation:

```lean
def IsTopologicalSemiconjugacy (φ : X → Y) (f : X → X) (g : Y → Y) : Prop :=
  Continuous φ ∧ Semiconj φ f g

def IsTopologicalFactorMap (φ : X → Y) (f : X → X) (g : Y → Y) : Prop :=
  IsTopologicalSemiconjugacy φ f g ∧ Surjective φ

def IsTopologicalConjugacy (e : X ≃ₜ Y) (f : X → X) (g : Y → Y) : Prop :=
  Semiconj e f g

def AreTopologicallyConjugate (f : X → X) (g : Y → Y) : Prop :=
  ∃ e : X ≃ₜ Y, IsTopologicalConjugacy e f g
```

`Continuous φ` supplies the limit-preservation gate. `Surjective φ` says that
each target state has a source representative. `X ≃ₜ Y` is a homeomorphism:
a bijection whose forward and inverse maps are continuous. The specified
predicate keeps the coordinate change visible; the existential relation says
only that some such change exists.

{{< reference-figure
  wide="true"
  src="interface-boundaries.svg"
  alt="An algebraic semiconjugacy branches to a continuous topological semiconjugacy and to a homeomorphic conjugacy; adding surjectivity to the continuous branch gives a factor map."
  caption="**Data gates:** continuity, surjectivity, and a continuous inverse play different roles. The interface does not infer distance preservation, a convergence rate, or the project's uniform-space forward-stability predicate from topology alone."
>}}

## One step controls every iterate

The theorem `semiconj_iterate_apply` states

\[
\varphi(f^n(x))=g^n(\varphi(x))
\qquad(n\in\mathbb N).
\]

It delegates the induction to Mathlib's `Function.Semiconj.iterate_right`.
Time zero is included: both iterates are identities. No continuity,
injectivity, or surjectivity enters this algebraic proof.

{{< lean-bridge
  human="Projecting the source state after n updates gives the same target state as projecting first and then applying n target updates."
  math="\(\varphi(f^n(x))=g^n(\varphi(x))\) for every \(n\in\mathbb N\)."
  lean="theorem semiconj_iterate_apply\n    (h : Semiconj φ f g) (n : ℕ) (x : X) :\n    φ (f^[n] x) = g^[n] (φ x)"
>}}
`f^[n]` and `g^[n]` are function iterates. `h.iterate_right n` lifts the
one-step relation to the two iterate families, and `.eq x` evaluates the
result at the chosen state.
{{< /lean-bridge >}}

This identity also sends fixed and specified-period points forward. A
many-to-one projection may merge distinct periodic points, so forward mapping
does not by itself recover the source point or its least period.

## Continuity transports attraction forward

Suppose \(f^n(x) \to p\). The iterate identity rewrites the projected sequence
as \(g^n(\varphi(x))\). If
\(\varphi\) is continuous at \(p\), then

\[
g^n(\varphi(x))
=\varphi(f^n(x))
\longrightarrow\varphi(p).
\]

`IsAttractedTo.map_semiconj` records exactly these two hypotheses:
`ContinuousAt φ p` and `Semiconj φ f g`. The wrapper
`IsTopologicalSemiconjugacy.map_isAttractedTo` projects continuity from the
bundled topological semiconjugacy.

Surjectivity enters only when a conclusion quantifies over every target
state. `IsTopologicalFactorMap.map_isGloballyAttractingFixedPoint` starts with
a target state \(y\), selects \(x\) with
\(\varphi(x)=y\), and transports global
attraction from that representative. It also maps the source fixed point to a
target fixed point using the semiconjugacy equation.

This direction is one-way. A factor can forget distinctions in the source, so
target attraction does not automatically lift through an arbitrary factor.

## A homeomorphism supplies the return path

For a specified conjugacy \(e : X \simeq_{\mathrm{top}} Y\),
`IsTopologicalConjugacy.symm` proves that `e.symm` intertwines \(g\) with \(f\).
`IsTopologicalConjugacy.trans` composes two coordinate changes. At the
existential level, `areTopologicallyConjugate_refl`,
`AreTopologicallyConjugate.symm`, and `AreTopologicallyConjugate.trans` show
that topological conjugacy is reflexive, symmetric, and transitive across
possibly different state types.

The inverse equation gives two-way statements:

- `IsTopologicalConjugacy.isFixedPt_iff` identifies corresponding fixed
  points;
- `IsTopologicalConjugacy.isPeriodicPt_iff` identifies points having a
  specified natural-number period;
- `IsTopologicalConjugacy.isAttractedTo_iff` identifies attraction of
  corresponding point orbits;
- `IsTopologicalConjugacy.basin_preimage` describes the source basin as an
  exact preimage;
- `IsTopologicalConjugacy.image_basin` describes the target basin as an exact
  image;
- `IsTopologicalConjugacy.isLocallyAttractingFixedPoint_iff` transports the
  basin-neighborhood condition in both directions; and
- `IsTopologicalConjugacy.isGloballyAttractingFixedPoint_iff` transports
  global attraction in both directions.

The periodic theorem uses `IsPeriodicPt f n p`, which says that \(n\) is a
period. It does not assert that \(n\) is the least positive period. Conjugacy
does preserve the displayed specified-period statement exactly.

## Declaration-complete source map

The source candidate contains twenty public declarations:

| Declaration | Role |
|---|---|
| `IsTopologicalSemiconjugacy` | continuity plus algebraic semiconjugacy |
| `IsTopologicalFactorMap` | continuous surjective semiconjugacy |
| `IsTopologicalConjugacy` | specified homeomorphism intertwining two maps |
| `AreTopologicallyConjugate` | existence of a specified conjugacy |
| `semiconj_iterate_apply` | all-iterate orbit identity |
| `IsAttractedTo.map_semiconj` | continuity-at-limit attraction transport |
| `IsTopologicalSemiconjugacy.map_isAttractedTo` | bundled forward attraction map |
| `IsTopologicalFactorMap.map_isGloballyAttractingFixedPoint` | global attractor descends to a factor |
| `IsTopologicalConjugacy.symm` | inverse homeomorphism conjugates back |
| `IsTopologicalConjugacy.trans` | specified conjugacies compose |
| `IsTopologicalConjugacy.isFixedPt_iff` | corresponding fixed points |
| `IsTopologicalConjugacy.isPeriodicPt_iff` | corresponding specified periods |
| `IsTopologicalConjugacy.isAttractedTo_iff` | corresponding point attraction |
| `IsTopologicalConjugacy.basin_preimage` | exact basin preimage |
| `IsTopologicalConjugacy.image_basin` | exact basin image |
| `IsTopologicalConjugacy.isLocallyAttractingFixedPoint_iff` | local attraction equivalence |
| `IsTopologicalConjugacy.isGloballyAttractingFixedPoint_iff` | global attraction equivalence |
| `areTopologicallyConjugate_refl` | reflexivity |
| `AreTopologicallyConjugate.symm` | symmetry |
| `AreTopologicallyConjugate.trans` | transitivity |

Six `#print axioms` commands audit the iterate theorem, factor endpoint,
specified-period equivalence, attraction equivalence, local-attraction
equivalence, and existential transitivity. Warning-fatal project validation must
show no `sorryAx` before the milestone is recorded as green.

## Reproduce the checks

The finite quarter-turn model is a **standalone tutorial** importing only
`Std`:

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/conjugacy-semiconjugacy-and-orbit-transport-in-discrete-time/quarter-turn-factor.lean
```

The exact module is a **full project check** using pinned Lean and Mathlib
dependencies. Initial setup may require substantial disk space and build time:

```sh
git clone https://github.com/tdj28/nonlinear-dynamics-lean.git
cd nonlinear-dynamics-lean/formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Discrete/Conjugacy.lean
```

`lake env lean` selects the pinned environment. Lean's elaborator constructs
candidate proof terms and the kernel checks them against the formal
statements. That check does not by itself establish that this interface covers
every convention called a factor or conjugacy in the literature.

The paired [Deep Dive]({{< relref
"/knowledge-base/deep-dives/conjugacy-semiconjugacy-and-orbit-transport-in-discrete-time"
>}}) develops the finite model and syntax gradually. The
{{< refterm "semiconjugacy-and-conjugacy" "Semiconjugacy and conjugacy" >}}
glossary chapter gives a shorter first pass. The later [Bifurcation Interfaces
Research Note]({{< relref
"/development-notebook/2026/08/bifurcation-interfaces-for-discrete-systems-in-lean"
>}}) uses conjugacy invariance to turn selected fixed- and periodic-point
existence changes into sufficient bifurcation witnesses.

## Exact nonclaims

The module proves no preservation theorem for
{{< refterm "forward-stability" "forward stability" >}}, uniform
equicontinuity, distances, Lipschitz constants, or convergence rates. A
homeomorphism preserves topology, not a chosen metric. The module also proves
no entropy, transitivity, mixing, chaos, symbolic coding, structural
stability, parameter robustness, measure conjugacy, stochastic result,
time-reparameterized orbit equivalence, ODE result, or algorithm for finding a
conjugacy.

A semiconjugacy need not be injective or surjective. A factor map is
surjective but may still lose information. A specified-period statement does
not identify the least period. Dynamical conjugacy here is not matrix
similarity, complex conjugation, or the unitary-conjugacy relation used
elsewhere in the random-matrix track.

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
