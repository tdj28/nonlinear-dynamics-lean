---
title: "Sensitivity Quantifiers and the Symbolic Shift"
slug: "sensitivity-quantifiers-and-the-symbolic-shift"
summary: "Follow one flipped bit through the binary shift, then read the global scale, local neighborhood, witness state, and witness time in their exact order."
lead: "Sensitive dependence is a statement about every state and every neighborhood, with one positive separation scale fixed in advance."
draft: true
pro_reviewed: false
toc: true
level: "Intermediate"
reading_time: "40 to 55 minutes"
prerequisites:
  - "Orbit and iterate"
  - "Metric ball"
  - "Neighborhood"
  - "Forward stability"
lean_module: "NonlinearDynamics.Deterministic.Chaos.Sensitivity"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Chaos/Sensitivity.lean"
lean_source_sha256: "bb6e1cf5ae0e22a491bc499ca95a6fbafc6e31a7a2a455d7603be0bf39a7ad27"
tags:
  - "Discrete dynamics"
  - "Sensitive dependence"
  - "Symbolic dynamics"
  - "Metric spaces"
  - "Lean 4"
og_image: "sensitivity-quantifiers-and-the-symbolic-shift-card.png"
og_image_alt: "Two binary streams share a prefix and differ at the next bit, which moves to the head after repeated shifts."
ai_disclosure: |
  **AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
  and review this Deep Dive. The author selected the questions, shaped the
  exposition, and remains responsible for inspecting the cited sources,
  artifacts, and final claims before publication. This is an independent,
  non-peer-reviewed draft. Verify claims against the cited primary sources and
  any released artifacts before relying on them.
---

{{< panel "warning" >}}
**Editorial and validation status.** This AI-assisted draft accompanies a
source candidate. Professional review and the warning-fatal full project gate
are pending, so <code>pro_reviewed</code> remains false.
{{< /panel >}}

## Learning objectives

After this chapter, you should be able to:

1. state metric sensitive dependence with its quantifiers in order;
2. construct a nearby binary stream that the shift later separates;
3. explain why the witness time depends on the requested neighborhood;
4. use an isolated singleton as a decisive non-example;
5. distinguish sensitivity from forward stability and from stronger chaos
   properties; and
6. read and run both the standalone `Std` worksheet and full project source.

For a compact definition, start with the
{{< refterm "sensitive-dependence-on-initial-conditions" "sensitive dependence on initial conditions" >}}
glossary chapter. The [Development Notebook]({{< relref
"/development-notebook/2026/08/sensitivity-scales-for-discrete-systems-in-lean"
>}}) records the formal design decision.

## Two streams that agree for six bits

Consider one-sided infinite binary streams. Let

\[
x=0,1,0,1,0,1\,\color{#b84a5a}{0}\,1\,0\,1\ldots
\]

and let \(y\) agree with the first six coordinates but flip coordinate six:

\[
y=0,1,0,1,0,1\,\color{#0a7280}{1}\,1\,0\,1\ldots
\]

The left shift \(\sigma\) discards the head bit. After six shifts, the marked
bits occupy coordinate zero, so \(\sigma^6(x)\) and \(\sigma^6(y)\) disagree at
the head.

{{< reference-figure
  src="prefix-conveyor.svg"
  alt="Two binary streams agree at coordinates zero through five and differ at coordinate six; six left shifts move the differing bits to coordinate zero."
  caption="**Finite witness inside an infinite model:** matching a longer prefix means starting closer in the usual Cantor-space metric. The witness time grows with the requested prefix length."
>}}

In the usual Cantor metric, agreement on a long initial prefix makes streams
arbitrarily close. A disagreement at the head has a fixed positive distance.
The construction therefore provides the combinatorial core of sensitivity of
the one-sided full shift.

The figure and worksheet do not independently define that metric. The full
mathematical conclusion additionally needs the standard metric or product
topology on binary streams.

## Generalize the construction

Let \(k\) be any natural number and \(x\) any binary stream. Define \(y\) by
copying coordinates \(0,\ldots,k-1\) and flipping coordinate \(k\). Then:

- \(x\) and \(y\) agree on the requested prefix of length \(k\);
- after \(k\) shifts, coordinate \(k\) becomes the head; and
- the shifted streams disagree at that head coordinate.

Every statement concerns finitely many indices even though a stream is a
function \(\mathbb N\to\{0,1\}\). That makes it suitable for a small `Std`-only
Lean worksheet.

```lean
abbrev BitStream := Nat → Bool

def shiftN (n : Nat) (x : BitStream) : BitStream :=
  fun i => x (n + i)

def PrefixEq (k : Nat) (x y : BitStream) : Prop :=
  ∀ i, i < k → x i = y i

def flipAt (k : Nat) (x : BitStream) : BitStream :=
  fun i => if i = k then !x i else x i
```

`flipAt_prefixEq` checks prefix agreement. `shift_prefix_sensitive` checks
that the flipped bit reaches the head after exactly \(k\) shifts.

## Why the witness time comes last

Suppose instead that one time \(n\) had to be selected before the neighborhood
depth \(k\). Request a prefix of length \(n+1\). Any permitted \(y\) then agrees
with \(x\) at coordinate \(n\), so after \(n\) shifts their head bits are equal.
That fixed time cannot witness separation.

The worksheet formalizes the negation:

```lean
theorem no_neighborhood_independent_separation_time :
    ¬∃ n, ∀ x k, ∃ y,
      PrefixEq k x y ∧ shiftN n x 0 ≠ shiftN n y 0
```

This does not refute sensitivity. It refutes a stronger, incorrectly ordered
statement. Sensitivity permits \(n\) to depend on \(x\), the requested
neighborhood, and the chosen partner.

{{< reference-figure
  src="quantifier-ladder.svg"
  alt="The correct branch selects a global positive scale, receives a state and neighborhood, then selects a nearby state and time; the incorrect branch selects the time before receiving the neighborhood."
  caption="**Dependency ladder:** moving an existential quantifier changes the property. A finite orbit plot cannot recover which dependencies were assumed."
>}}

Another near miss lets the separation scale depend on the point. That is
pointwise instability, not one global sensitivity scale. Akin and Kolyada
give explicit attention to this distinction
([2003, §3](https://doi.org/10.1088/0951-7715/16/4/313)).

## State the metric definition

For a self-map \(f:X\to X\) of a nonempty pseudo-metric space, sensitive
dependence means

\[
\exists\delta\gt0\;\forall x\in X\;\forall\varepsilon\gt0\;
\exists y\in X\;\exists n\in\mathbb N,
\quad d(y,x)\lt\varepsilon
\quad\text{and}\quad
d(f^n(x),f^n(y))\gt\delta.
\]

Read the blocks aloud:

1. select one positive sensitivity scale \(\delta\);
2. receive an arbitrary reference state \(x\);
3. receive an arbitrary positive input radius \(\varepsilon\);
4. choose a permitted nearby state \(y\); and
5. choose a natural-number time \(n\) that separates their images.

The strict inequality agrees with a common Devaney-style convention, as in
Banks et al. ([1992](https://doi.org/10.1080/00029890.1992.11995856)). Some
sources use a weak inequality. The existential properties agree after
shrinking a positive constant, but the same numerical scale need not satisfy
both versions.

## The neighborhood form

Instead of a radius, let \(U\) be any neighborhood of \(x\):

\[
\forall U\in\mathcal N(x),\quad
\exists y\in U\;\exists n\in\mathbb N,
\quad d(f^n(x),f^n(y))\gt\delta.
\]

Every metric neighborhood contains a positive-radius ball, and every such
ball is itself a neighborhood. The project theorem
`isSensitiveAtWith_iff_nhds` checks this equivalence.

This is a neighborhood reformulation under the selected pseudo-metric. It is
not a topology-only definition. On noncompact spaces, compatible metrics need
not give equivalent sensitivity predicates. Good and Macías explain the
compactness hypotheses under which metric, uniform, and appropriate open-cover
forms coincide
([2018, Theorem 3.2](https://doi.org/10.3934/dcds.2018043)).

## A real-line proof with no symbolic topology

The checked source candidate also uses \(D(x)=2x\) on \(\mathbb R\). For a
requested radius \(\varepsilon\gt0\), choose \(y=x+\varepsilon/2\). Then

\[
|D^n(y)-D^n(x)|=2^n\varepsilon/2.
\]

Some \(n\) makes this quantity larger than \(1\), so \(1\) is a global
sensitivity scale. The argument uses exact real arithmetic and unboundedness
of powers of two.

This model is intentionally elementary, not a claim that unbounded doubling
has every property associated with chaos. It supplies a complete witness for
the one predicate under study.

## Isolated points defeat the definition

Suppose \(x\) is isolated, meaning that \(\{x\}\) is open. Use that singleton as
the neighborhood. The only possible witness is \(y=x\). Every iterate of \(x\)
then equals the corresponding iterate of \(y\), so the output distance is
zero at every time. No positive scale can work.

Therefore a nonempty discrete metric space is never sensitive. In particular,
no genuinely finite metric state space can be the positive example. This is
why the standalone worksheet uses an infinite stream type with finite proofs,
rather than falsely labeling a finite transition table sensitive.

## Compare with forward stability

Forward stability at \(x\) says that for each output tolerance, a sufficiently
small input ball keeps every iterate within that tolerance. Sensitivity at
\(x\) with scale \(\delta\gt0\) says every input ball has some pair that becomes
farther than \(\delta\). Applying stability at tolerance \(\delta\) makes the
two statements contradictory.

The source derives:

- sensitivity at \(x\) implies failure of forward stability at \(x\);
- global sensitivity implies failure of forward stability everywhere; and
- nonexpansive maps, including the identity, are not sensitive.

Failure of sensitivity is weaker than forward stability. It does not supply a
stable state without additional hypotheses.

## In Lean

{{< lean-bridge
  human="One positive scale works at every state: however small an input ball is, some state in it has an iterate more than that scale from the reference iterate."
  math="\(\exists\delta\gt0\;\forall x\;\forall\varepsilon\gt0\;\exists y,n,\quad d(y,x)\lt\varepsilon\land\delta\lt d(f^n x,f^n y)\)."
  lean="def IsSensitiveWith [PseudoMetricSpace X]\n    (f : X → X) (δ : ℝ) : Prop :=\n  Nonempty X ∧ 0 < δ ∧ ∀ x, IsSensitiveAtWith f δ x\n\ndef IsSensitive [PseudoMetricSpace X] (f : X → X) : Prop :=\n  ∃ δ, IsSensitiveWith f δ"
>}}
`PseudoMetricSpace X` supplies `dist` and the induced neighborhoods.
`Nonempty X` blocks vacuous sensitivity of the empty type. `0 < δ` makes the
scale meaningful. The first `∃` chooses the scale before `∀ x` and the radius
quantifier inside `IsSensitiveAtWith`. `f^[n]` in that inner predicate is
Mathlib notation for the \(n\)-fold iterate.
{{< /lean-bridge >}}

## Try it in the repository

Create a reader worksheet containing:

~~~lean
import NonlinearDynamics.Deterministic.Chaos.Sensitivity

open NonlinearDynamics.Deterministic.Chaos

#check IsSensitive
#check isSensitiveAtWith_iff_nhds
#check IsSensitiveAtWith.not_isForwardStableAt
#check doublingMap_isSensitive
~~~

`import` loads the exact project module. `open` shortens this milestone's
namespace. The four checks inspect the global predicate, neighborhood bridge,
stability obstruction, and exact real example.

This is a **full project check** on macOS or Linux. The pinned Mathlib
environment may require substantial initial disk space and build time.

{{< repo-check >}}
The copied checks form a reader worksheet. The authoritative source is
`NonlinearDynamics/Deterministic/Chaos/Sensitivity.lean`; the command below
checks the complete module with the repository's pinned environment.
{{< /repo-check >}}

The literal underlying command is:

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Chaos/Sensitivity.lean
```

For the bounded **standalone tutorial**, run:

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/sensitivity-quantifiers-and-the-symbolic-shift/prefix-shift-sensitivity.lean
```

The standalone file imports only `Std` and may be run on macOS or Linux. It
checks the finite-prefix construction and the incorrectly early witness-time
near miss. It does not check the Mathlib metric-space theorem.

## Property boundary table

| Property | Quantified requirement | Not supplied by sensitivity alone |
|---|---|---|
| Sensitivity | one partner in every neighborhood eventually separates at one global scale | rate, persistence, recurrence |
| Positive expansivity | every distinct pair eventually separates | the universal pair quantifier |
| Topological mixing | all sufficiently late images of each open set meet another open set | open-set transport and late-time uniformity |
| Positive entropy | asymptotic orbit-complexity growth | a complexity count or measure statement |
| Finite-time divergence | a selected pair separates over a selected window | arbitrarily small starts at every state |
| Roundoff amplification | numerical perturbations grow in an implementation | floating-point and conditioning analysis |

Sensitivity need not imply expansivity, mixing, or positive entropy, and none
of those words should substitute for the displayed quantifiers. Stronger
time-set notions are studied separately, for example by Moothathu
([2007](https://doi.org/10.1088/0951-7715/20/9/006)) and by Antunes and
Carvalho
([2025](https://doi.org/10.1007/s10884-024-10362-x)).

## Common confusions

| Confusion | Correction |
|---|---|
| One close pair separated. | Sensitivity quantifies over every state and every input radius. |
| The scale may shrink with the neighborhood. | One positive scale is fixed before every state and neighborhood. |
| One time must work everywhere. | The witness time may depend on the state, neighborhood, and partner. |
| All nearby states must separate. | The definition asks for at least one suitable partner. |
| Separation must be exponential. | No rate or monotonicity appears in the predicate. |
| A finite transition table is sensitive. | A finite genuine metric space is discrete and has singleton neighborhoods. |
| “Topological sensitivity” ignores the metric. | Metric-independence needs additional hypotheses, such as compactness in standard equivalence results. |
| Sensitivity is Devaney chaos. | Devaney chaos also invokes transitivity and dense periodic points under stated hypotheses. |

## What this chapter establishes and what it does not

The stream construction establishes the exact finite-prefix witness used by
the standard symbolic model. The real doubling calculation establishes the
metric sensitivity predicate for that explicit map once the source passes its
formal gate. The isolated-point argument establishes a genuine obstruction.

The chapter makes no claim of expansivity, transitivity, mixing, dense
periodic points, Devaney chaos, positive topological or measure entropy,
exponential divergence, positive Lyapunov exponent, differentiability,
derivative growth, numerical unpredictability, roundoff amplification,
shadowing, two-sided time, or invariance under arbitrary compatible metrics on
noncompact spaces.

## References

- Ethan Akin and Sergiy Kolyada, “Li–Yorke sensitivity,” *Nonlinearity* 16
  (2003), 1421–1433. [DOI](https://doi.org/10.1088/0951-7715/16/4/313).
- Joseph Auslander and James A. Yorke, “Interval maps, factors of maps, and
  chaos,” *Tohoku Mathematical Journal* 32 (1980), 177–188.
  [DOI](https://doi.org/10.2748/tmj/1178229634).
- John Banks, Jeff Brooks, Grant Cairns, Gary Davis, and Peter Stacey, “On
  Devaney's Definition of Chaos,” *American Mathematical Monthly* 99(4)
  (1992), 332–334.
  [Publisher DOI](https://doi.org/10.1080/00029890.1992.11995856).
- Chris Good and Sergio Macías, “What is topological about topological
  dynamics?”, *Discrete and Continuous Dynamical Systems* 38(3) (2018),
  1007–1031. [DOI](https://doi.org/10.3934/dcds.2018043).
