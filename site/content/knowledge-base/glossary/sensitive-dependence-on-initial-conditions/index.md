---
title: "Sensitive dependence on initial conditions"
slug: "sensitive-dependence-on-initial-conditions"
summary: "One positive separation scale works at every state and in every neighborhood, with the nearby partner and witness time chosen afterward."
draft: true
pro_reviewed: false
toc: true
lean_module: "NonlinearDynamics.Deterministic.Chaos.Sensitivity"
lean_snapshot: "/lean/NonlinearDynamics/Deterministic/Chaos/Sensitivity.lean"
lean_source_sha256: "747205ab52e00260c89da63b10b4869144d066ea49266c55639467da2e56f83d"
tags:
  - "Discrete dynamics"
  - "Sensitive dependence"
  - "Metric spaces"
  - "Initial conditions"
og_image: "sensitive-dependence-on-initial-conditions-card.png"
og_image_alt: "Nested neighborhoods around one state contain a nearby partner whose iterated image later lies beyond a fixed sensitivity scale."
---

{{< panel "info" >}}
**AI-use disclosure.** Generative-AI tools helped draft, revise, illustrate,
and review this chapter. The author selected the questions, shaped the
exposition, and remains responsible for inspecting the cited sources,
artifacts, and final claims before publication. This is an independent,
non-peer-reviewed draft. Verify claims against the cited primary sources and
released artifacts before relying on them.
{{< /panel >}}

{{< panel "warning" >}}
**Editorial and validation status.** This draft accompanies a source
candidate. Professional review and the warning-fatal full project gate are
pending, so <code>pro_reviewed</code> remains false.
{{< /panel >}}

**Sensitive dependence on initial conditions** for a discrete self-map means
that one positive output-separation scale works at every reference state and
at every input resolution. The scale is chosen first; the nearby partner and
time of separation are chosen afterward.

## Start with doubling on the real line

Let \(D(x)=2x\). Given any \(x\in\mathbb R\) and any radius
\(\varepsilon\gt0\), choose \(y=x+\varepsilon/2\). The two initial states satisfy

\[
|y-x|=\varepsilon/2\lt\varepsilon.
\]

After \(n\) updates their distance is

\[
|D^n(y)-D^n(x)|=2^n\varepsilon/2.
\]

Because powers of two are unbounded, some \(n\) makes this distance larger
than \(1\). Thus the same scale \(1\) works for every \(x\) and every positive
input radius. This argument establishes sensitivity of this explicit map; it
does not establish recurrence, mixing, or any other chaos property.

## The five quantifier blocks

For \(f:X\to X\) on a nonempty pseudo-metric space, the selected convention is

\[
\exists\delta\gt0\;\forall x\in X\;\forall\varepsilon\gt0\;
\exists y\in X\;\exists n\in\mathbb N,
\quad d(y,x)\lt\varepsilon
\quad\land\quad
d(f^n(x),f^n(y))\gt\delta.
\]

The order matters:

- \(\delta\) is one global **sensitivity scale**;
- \(x\) is any reference state;
- \(\varepsilon\) is any requested input radius;
- \(y\) may depend on \(x\) and \(\varepsilon\); and
- \(n\) may depend on all the preceding choices.

{{< reference-figure
  src="sensitivity-neighborhood.svg"
  alt="Three nested neighborhoods surround x. Each contains a possible nearby y; after a witness time the images of x and y lie more than fixed delta apart."
  caption="**One scale, arbitrarily small starts:** the definition asks for a suitable partner in every neighborhood, not for every nearby partner to separate."
>}}

Allowing \(\delta\) to depend on \(x\) gives a weaker pointwise-instability
statement. Selecting \(n\) before receiving the neighborhood gives a stronger
statement. Requiring every nearby \(y\) to separate is stronger again.

Banks et al. use the global metric scale in their classic treatment of
Devaney chaos ([1992](https://doi.org/10.1080/00029890.1992.11995856)). Akin
and Kolyada discuss the distinction between pointwise instability and global
sensitivity ([2003, §3](https://doi.org/10.1088/0951-7715/16/4/313)).

## Neighborhood form

Fixing the scale \(\delta\) and state \(x\), the same property can be written:

\[
\forall U\in\mathcal N(x),\quad
\exists y\in U\;\exists n\in\mathbb N,
\quad d(f^n(x),f^n(y))\gt\delta.
\]

Here \(\mathcal N(x)\) is the collection, represented as a filter, of
neighborhoods of \(x\). The ball and neighborhood forms agree because every
metric neighborhood contains a positive-radius ball and each such ball is a
neighborhood.

This is still a statement under the fixed pseudo-metric. A bare topology does
not select the global separation scale. Good and Macías establish equivalence
of metric, uniform, and suitable open-cover formulations under compactness
hypotheses
([2018, Theorem 3.2](https://doi.org/10.3934/dcds.2018043)).

## Isolated points are an exact boundary

If \(\{x\}\) is open, choose that singleton as the neighborhood. Then the only
possible partner is \(y=x\), and equal initial states have equal iterates at
every time. Their distance remains zero, contradicting any positive scale.

Consequently:

- a sensitive space has no isolated point;
- no nonempty discrete pseudo-metric space supports a sensitive self-map; and
- no finite genuine metric space supports one.

The word “genuine” matters in the last sentence: a pseudo-metric may assign
distance zero to distinct points, so a finite pseudo-metric topology need not
be discrete.

## In Lean

{{< lean-bridge
  human="The space is nonempty, the scale is positive, and every state is sensitive at that same scale."
  math="\(X\ne\varnothing\land\delta\gt0\land\forall x,\forall\varepsilon\gt0,\exists y,n,\quad d(y,x)\lt\varepsilon\land\delta\lt d(f^n x,f^n y)\)."
  lean="def IsSensitiveWith [PseudoMetricSpace X]\n    (f : X → X) (δ : ℝ) : Prop :=\n  Nonempty X ∧ 0 < δ ∧ ∀ x, IsSensitiveAtWith f δ x"
>}}
`Nonempty X` prevents the empty type from satisfying the universal statement
vacuously. `0 < δ` records a meaningful separation scale. `∀ x` places every
reference state under that same scale. `IsSensitiveAtWith` contains the
positive-radius, nearby-state, and natural-number-time quantifiers.
{{< /lean-bridge >}}

## Try it in the repository

Create a reader worksheet containing:

~~~lean
import NonlinearDynamics.Deterministic.Chaos.Sensitivity

open NonlinearDynamics.Deterministic.Chaos

#check SeparatesAtScale
#check IsSensitiveWith
#check isSensitiveAtWith_iff_nhds
#check not_isSensitive_of_finite
#check doublingMap_isSensitive
~~~

This is a **full project check** on macOS or Linux. It uses the repository's
pinned Lean and Mathlib dependencies, whose initial setup may require
substantial disk space and build time.

{{< repo-check >}}
The checks inspect the exact source declarations, neighborhood theorem,
finite-space obstruction, and real doubling example.
{{< /repo-check >}}

The literal underlying command is:

```sh
cd formalization
lake env lean -DwarningAsError=true \
  NonlinearDynamics/Deterministic/Chaos/Sensitivity.lean
```

For a bounded **standalone tutorial**, run the finite-prefix symbolic
worksheet:

```sh
elan run leanprover/lean4:v4.32.0 lean \
  site/content/knowledge-base/deep-dives/sensitivity-quantifiers-and-the-symbolic-shift/prefix-shift-sensitivity.lean
```

It imports only `Std` and checks how one flipped bit reaches the head after a
matching number of shifts. The stream space is infinite; every proof step is
finite. The worksheet does not formalize the Cantor metric or by itself
establish the full metric sensitivity theorem.

## Sensitivity versus neighboring ideas

| Idea | Decisive difference |
|---|---|
| Forward stability | one input neighborhood keeps all iterates within a requested tolerance |
| Positive expansivity | every distinct pair must eventually separate |
| Mixing | sufficiently late images of open sets must meet other open sets |
| Positive entropy | orbit-complexity growth must be quantified |
| Finite-time divergence | one selected pair and time window do not cover every state and radius |
| Roundoff amplification | requires a numerical representation and error analysis |

Sensitivity at \(x\) contradicts forward stability at \(x\): use the
sensitivity scale as the stability tolerance. The converse is not automatic.
Sensitivity also asserts no exponential rate, persistent separation, positive
Lyapunov exponent, or uniformly bounded witness time.

## Common confusions

| Confusion | Correction |
|---|---|
| A plotted pair diverged. | One pair does not cover every state and every radius. |
| The output threshold can shrink with the input ball. | One positive threshold is selected first. |
| All close states diverge. | The predicate asks for one suitable partner. |
| The witness time is fixed. | It may depend on the requested neighborhood. |
| Sensitivity means exponential divergence. | No growth rate appears in the definition. |
| Sensitivity is purely topological on every metric space. | Metric-independence needs additional hypotheses. |
| Sensitivity alone is chaos. | Named chaos definitions impose other conditions. |

## What this term does not claim

The term alone supplies no continuity, compactness, surjectivity, expansivity,
transitivity, mixing, dense periodic points, Devaney chaos, positive
topological or measure entropy, exponential rate, Lyapunov exponent,
differentiability, derivative growth, numerical prediction limit, roundoff
amplification, shadowing, or two-sided-time statement. It is also not asserted
to be invariant under arbitrary topological conjugacy between noncompact
metric spaces.

For the complete construction, proofs, and source map, continue to
[Sensitivity Quantifiers and the Symbolic Shift]({{< relref
"/knowledge-base/deep-dives/sensitivity-quantifiers-and-the-symbolic-shift"
>}}).
