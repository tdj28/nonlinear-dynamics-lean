---
title: "Bifurcation Interfaces for Discrete Systems in Lean"
slug: "bifurcation-interfaces-for-discrete-systems-in-lean"
date: 2026-08-06
weight: -77
author: "tdj28"
summary: "A parameterized-map interface separates fixed and specified-period branches, classifier changes, and failure of nearby whole-state-space topological conjugacy."
lead: |
  A curve of fixed points is not an orbit, and a moving fixed point is not automatically a bifurcation. This milestone names the parameter family, the selected invariant, and the conjugacy obstruction separately.
key_result: |
  A change in any conjugacy-invariant classifier is sufficient for the module's whole-state-space conjugacy bifurcation predicate. Fixed-point existence and specified-period existence supply two checked classifiers, while the quadratic family exhibits the fixed-point-existence route at parameter zero. The quadratic fold-type event remains local in the literature's local/global bifurcation taxonomy.
draft: false
pro_reviewed: false
status: "Warning-fatal formal validation passed; public working note with professional review pending"
level: "Intermediate topology, filters, fixed and periodic points, and Lean 4"
reading_time: "45 to 65 minutes"
prerequisites:
  - "Orbit and iterate"
  - "Fixed and periodic points"
  - "Neighborhood filters"
  - "Topological conjugacy"
lean_module: "NonlinearDynamics.Deterministic.Discrete.Bifurcation"
lean_source: "formalization/NonlinearDynamics/Deterministic/Discrete/Bifurcation.lean"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Discrete/Bifurcation.lean"
lean_source_sha256: "1c9ed02764e75b136567e879da85922ac9d6013836e582e4f539a23d3c11a1d0"
tags:
  - "Lean 4"
  - "Discrete dynamics"
  - "Bifurcation"
  - "Fixed points"
  - "Periodic points"
  - "Topological conjugacy"
og_image: "bifurcation-interfaces-for-discrete-systems-in-lean-card.png"
og_image_alt: "Two fixed-point branches meet at a parameter threshold beside the labels family, branch, and qualitative change."
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
**Editorial status.** This is a public working note paired with warning-fatal
Lean source. The changed module, deterministic aggregator, and complete
repository gate passed under the pinned Lean 4.32.0 environment. The owner
completed the required source-and-artifact inspection. The configured
professional review has not been performed, and `pro_reviewed` remains false.
{{< /panel >}}

## Begin with an equation that can be solved completely

For a real parameter \(\mu\), define

\[
F_\mu(x)=x+(\mu-x^2).
\]

A fixed point satisfies \(F_\mu(x)=x\). Cancelling \(x\) gives

\[
\mu=x^2.
\]

This identity determines every real fixed point:

- if \(\mu\lt0\), no real square equals \(\mu\), so there is no fixed point;
- if \(\mu=0\), the only fixed point is \(x=0\); and
- if \(\mu\gt0\), the two fixed points are
  \(x=\sqrt\mu\) and \(x=-\sqrt\mu\).

The algebra establishes the three cases. The diagram explains their
relationship but supplies no additional proof.

{{< reference-figure
  wide="true"
  src="branch-geometry.svg"
  alt="Two fixed-point branches meet at the reference parameter; negative parameters have no fixed point, the reference parameter has one, and positive parameters have two."
  caption="**Branch geometry, not an orbit:** the horizontal direction varies the parameter that selects a map. Iteration time would instead apply one selected map repeatedly to a state."
>}}

Kuznetsov analyzes \(x\mapsto\alpha+x+x^2\) and immediately notes the
variant \(x\mapsto\alpha+x-x^2\). The project family is exactly the latter
after renaming \(\alpha\) to \(\mu\) [in the scalar map fold
discussion](https://doi.org/10.4249/scholarpedia.4399). The present module
checks this family directly. It does not formalize the generic scalar fold
theorem, which assumes a smooth \(f(x,\alpha)\) with
\(f(0,0)=0\), \(f_x(0,0)=1\), \(f_{xx}(0,0)\ne0\), and
\(f_\alpha(0,0)\ne0\).

## Why literal fixed-point sets are the wrong primary test

Suppose a family has one fixed point that moves continuously with the
parameter. The literal subsets of the chosen coordinate space are different
at nearby parameters, but the maps may still be topologically conjugate. A
definition based on equality of those subsets would report coordinate motion
as a qualitative change.

The module therefore follows the standard idea of detecting topological
inequivalence at arbitrarily close parameters, as summarized by
[Guckenheimer](https://doi.org/10.4249/scholarpedia.1517). Its first formal
predicate is a **whole-state-space conjugacy bifurcation**: maps not
topologically conjugate to \(F_\mu\) by a homeomorphism of the entire state
space occur arbitrarily near \(\mu\):

```lean
def IsGlobalTopologicalBifurcationAt
    (family : ParameterizedFamily P X) (μ : P) : Prop :=
  ¬∀ᶠ ν in 𝓝 μ, AreTopologicallyConjugate (family ν) (family μ)
```

`𝓝 μ` is the neighborhood filter. `∀ᶠ ν in 𝓝 μ, ...` means that the
statement holds throughout some neighborhood of \(\mu\). Negating it means
that every neighborhood contains parameters where the statement fails. The
equivalent theorem
`isGlobalTopologicalBifurcationAt_iff_frequently_not_conjugate` exposes that
frequent form.

In the Lean declaration name, **Global** modifies the domain of the
conjugating homeomorphism. It does not classify the quadratic event as a
global bifurcation in the literature's local/global sense: the fold-type
fixed-point event is local in that taxonomy. The definition does not yet
cover local conjugacy near one invariant set. It also requires no continuous
choice of conjugating homeomorphisms as the parameter varies. Those are
separate, stronger interfaces.

## Classifiers are witnesses, not replacements for equivalence

Some topological inequivalences are easier to establish through a selected
classifier. The project defines

```lean
def IsClassificationChangeAt (classify : P → C) (μ : P) : Prop :=
  ¬∀ᶠ ν in 𝓝 μ, classify ν = classify μ
```

An arbitrary classifier does not automatically describe qualitative
dynamics. The bridge theorem asks for the missing fact explicitly: whenever
the nearby map is conjugate to the reference map, its classifier value must
equal the reference value. Under that hypothesis, a classifier change implies
the whole-state-space conjugacy bifurcation predicate.

{{< reference-figure
  wide="true"
  src="interface-gates.svg"
  alt="A family of self-maps leads to a conjugacy-invariant classifier, then a nearby classifier change, then an obstruction to one nearby whole-state-space conjugacy class; differentiability, hyperbolicity, normal forms, and numerical detection remain separate."
  caption="**The sufficient-witness route:** the proof depends on conjugacy invariance. A convenient number, plot label, or coordinate-dependent set is not a safe classifier merely because it changes."
>}}

Two safe classifiers are included:

- `HasFixedPoint f` says that some state satisfies `IsFixedPt f x`;
- `HasSpecifiedPeriodPoint f n` says that some state satisfies
  `IsPeriodicPt f n x`.

The previous Conjugacy milestone identifies corresponding fixed and
specified-period points. This module lifts those pointwise theorems to
existence equivalences, then uses `propext` to turn equivalence of
propositions into the equality expected by the generic classifier interface.

The implications are one-way. A fixed-point-existence change establishes a
bifurcation under this whole-state-space equivalence. Constancy of fixed-point existence
does not establish conjugacy and does not rule out a bifurcation involving
stability, a periodic orbit, an invariant curve, or another feature.

## Branches are selections satisfying equations

For a parameter set \(S\), a fixed-point branch is represented by a function
\(b : P\to X\) satisfying

\[
F_\mu(b(\mu))=b(\mu)\qquad(\mu\in S).
\]

The Lean predicate is deliberately pointwise:

```lean
def IsFixedPointBranchOn (family : ParameterizedFamily P X)
    (branch : P → X) (s : Set P) : Prop :=
  ∀ μ ∈ s, IsFixedPt (family μ) (branch μ)
```

`IsSpecifiedPeriodBranchOn family n branch s` replaces `IsFixedPt` with
`IsPeriodicPt ... n`. No continuity, differentiability, uniqueness, or
maximality is hidden in either definition.

Every fixed point returns after every natural number of updates.
Consequently, every fixed-point branch is also a specified-period branch for
every `n`, including zero. This theorem does not turn it into a branch of
least period `n`. Exact least period needs additional exclusions.

For the quadratic family, `Real.sqrt` and `fun μ ↦ -√μ` are fixed-point
branches on `Set.Ici 0`. The source proves that they give all fixed points
there and that they are distinct for a positive parameter. At zero the two
branch expressions coincide.

## The checked witness at zero

`quadraticFixedPointFamily_hasFixedPoint_iff` proves

\[
(\exists x,\ F_\mu(x)=x)\quad\Longleftrightarrow\quad 0\leq\mu.
\]

Mathlib's `frequently_lt_nhds` supplies negative real parameters arbitrarily
near zero. At those parameters the classifier is false, while at zero it is
true. The theorem
`quadraticFixedPointFamily_isFixedPointExistenceChangeAt_zero` packages this
filter argument.

Finally,
`quadraticFixedPointFamily_isGlobalTopologicalBifurcationAt_zero` applies the
generic invariant-classifier theorem. The logical path is complete:

1. the fixed-point equation gives existence exactly for nonnegative
   parameters;
2. negative parameters occur arbitrarily near zero;
3. fixed-point existence therefore changes at zero;
4. global topological conjugacy preserves fixed-point existence; and
5. nearby negative maps cannot all be globally conjugate to the map at zero.

This is a theorem about the selected whole-state-space predicate and this exact family.
It is not a sampled numerical diagnosis.

## Isolated parameters form a boundary case

If the singleton \(\{\mu\}\) is open, then some neighborhood contains only
\(\mu\). Every classifier is constant on that neighborhood. The theorem
`not_isClassificationChangeAt_of_isOpen_singleton` records this boundary.

That fact matters for finite teaching models. A finite type with its usual
discrete topology can illustrate different regimes, fixed-point counts, and
specified periods. Its adjacent entries do not by themselves form a
topological parameter continuum, so the table alone does not establish this
module's real-parameter bifurcation predicate.

## Declaration-complete source map

| Declarations | Role |
|---|---|
| `ParameterizedFamily` | family of self-maps indexed by parameters |
| `IsClassificationChangeAt`, `isClassificationChangeAt_iff_frequently_ne` | local failure of classifier constancy |
| `IsGlobalTopologicalBifurcationAt`, its frequent-form theorem | nearby failure of whole-state-space conjugacy |
| `IsClassificationChangeAt.isGlobalTopologicalBifurcationAt` | invariant-classifier bridge |
| `IsFixedPointBranchOn`, `IsSpecifiedPeriodBranchOn` | pointwise branch equations on a set |
| `IsFixedPointBranchOn.isSpecifiedPeriodBranchOn` | fixed implies every specified period |
| `HasFixedPoint`, `HasSpecifiedPeriodPoint` | existence classifiers |
| `AreTopologicallyConjugate.hasFixedPoint_iff` | fixed-point-existence invariance |
| `AreTopologicallyConjugate.hasSpecifiedPeriodPoint_iff` | specified-period-existence invariance |
| `IsFixedPointExistenceChangeAt` | fixed-point-existence classifier change |
| `IsSpecifiedPeriodExistenceChangeAt` | specified-period-existence classifier change |
| `IsFixedPointExistenceChangeAt.isGlobalTopologicalBifurcationAt` | fixed-point witness bridge |
| `IsSpecifiedPeriodExistenceChangeAt.isGlobalTopologicalBifurcationAt` | specified-period witness bridge |
| `not_isClassificationChangeAt_of_isOpen_singleton` | isolated-parameter boundary |
| `quadraticFixedPointFamily` | elementary real family |
| `quadraticFixedPointFamily_isFixedPt_iff` | exact fixed-point equation |
| `quadraticFixedPointFamily_hasFixedPoint_iff` | existence exactly at nonnegative parameters |
| `quadraticFixedPointFamily_isFixedPt_iff_eq_sqrt_or_eq_neg_sqrt` | complete square-root classification |
| `quadraticFixedPointFamily_sqrt_isFixedPointBranchOn` | upper square-root branch |
| `quadraticFixedPointFamily_neg_sqrt_isFixedPointBranchOn` | lower square-root branch |
| `quadraticFixedPointFamily_sqrt_ne_neg_sqrt` | positive-parameter branch separation |
| `quadraticFixedPointFamily_isFixedPointExistenceChangeAt_zero` | classifier change at zero |
| `quadraticFixedPointFamily_isGlobalTopologicalBifurcationAt_zero` | final conjugacy obstruction |

Six `#print axioms` commands audit the generic filter equivalence, the
classifier bridge, fixed-point invariance, the fixed-point witness bridge, the
complete square-root classification, and the final example theorem. The
formal release gate shows only standard `propext`, `Classical.choice`, and
`Quot.sound` dependencies as applicable, with no `sorryAx`.

## Reproduce the checks

The finite regime table is a **standalone tutorial** importing only `Std`:

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/parameter-families-branches-and-bifurcation-in-discrete-time/finite-branch-table.lean
```

The project module is a **full project check** using the repository's pinned
Lean and Mathlib dependencies. Initial setup may require substantial disk
space and build time:

```sh
git clone https://github.com/tdj28/nonlinear-dynamics-lean.git
cd nonlinear-dynamics-lean/formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Discrete/Bifurcation.lean
```

Lean's elaborator constructs candidate proof terms and its kernel checks them
against the formal statements. That check does not establish that this
whole-state-space convention covers every use of “bifurcation” in the
literature.

The [Deep Dive]({{< relref
"/knowledge-base/deep-dives/parameter-families-branches-and-bifurcation-in-discrete-time"
>}}) develops the example and finite worksheet more slowly. The
{{< refterm "bifurcation-point" "bifurcation point" >}} glossary chapter gives
a shorter entry point.

## Exact nonclaims

The module does not formalize local phase-space equivalence, continuity or
differentiability of a family, continuous or smooth branch regularity,
derivatives, Jacobians, multipliers, hyperbolicity, genericity,
transversality, codimension, center manifolds, fold or flip normal-form
classification, Neimark-Sacker bifurcation, stability exchange, least-period
branches, continuation, numerical detection, structural stability in a
function-space topology, chaos, entropy, mixing, symbolic coding, stochastic
systems, or ODE bifurcations.

Different fixed-point existence values obstruct conjugacy. Equal existence
values do not establish conjugacy. A branch may persist through a
bifurcation, and a bifurcation may concern a classifier not included here.

## References

- John Guckenheimer, “Bifurcation,” *Scholarpedia* 2(6):1517 (2007),
  [DOI 10.4249/scholarpedia.1517](https://doi.org/10.4249/scholarpedia.1517).
  The definition uses arbitrarily close parameters with topologically
  inequivalent dynamics.
- Yuri A. Kuznetsov, *Elements of Applied Bifurcation Theory*, 3rd ed.,
  Applied Mathematical Sciences 112, Springer (2004), Chapter 2 on
  equivalence and bifurcations and Chapter 4 on one-parameter bifurcations of
  fixed points in discrete time,
  [DOI 10.1007/978-1-4757-3978-7](https://doi.org/10.1007/978-1-4757-3978-7).
- Yuri A. Kuznetsov, “Saddle-node bifurcation for maps,” *Scholarpedia*
  3(4):4399 (2008),
  [DOI 10.4249/scholarpedia.4399](https://doi.org/10.4249/scholarpedia.4399).
- Yuri A. Kuznetsov and Hil G. E. Meijer, *Numerical Bifurcation Analysis of
  Maps: From Theory to Software*, Cambridge University Press (2019), Chapter
  2, [DOI 10.1017/9781108585804](https://doi.org/10.1017/9781108585804).
- Mathlib 4.32.0, pinned revision `81a5d257`,
  [`Dynamics.PeriodicPts.Defs`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Dynamics/PeriodicPts/Defs.lean),
  [`Topology.Order.LeftRight`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Topology/Order/LeftRight.lean), and
  [`Analysis.Real.Sqrt`](https://github.com/leanprover-community/mathlib4/blob/81a5d257c8e410db227a6665ed08f64fea08e997/Mathlib/Analysis/Real/Sqrt.lean).
